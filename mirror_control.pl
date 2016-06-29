#Ian Mackenzie E-GO CG#Drone Mirror Control


#TextOut( "Start\n" );  # display text in the message console
#SetAngle( 0, 0, -50 ); # sets pitch, roll, yaw, in degrees
#Wait( 3 );             # waits 3 seconds
#DoCamera( 'Shutter' ); # releases the camera shutter, if activated
#RecenterCamera();      # recenters all three axes
sub calcDeg{
  
  my ($deg) = $_[0];
  
  return ($deg * (180.0/3.14159265735));}

#calculate the tilt required to direct at a point

sub calcTilt{

  
  my ($X) = $_[0];  my ($Y) = $_[1];  my ($Z) = $_[2];


  my ($a1) = $Z;

  my ($b1) = ($X*$X);  my ($c1) = ($Y*$Y);

  my ($d1) = $b1 + $c1;

  my ($e1) = sqrt($d1);  #my ($f1) = $e1/$a1;  my ($g1) = atan2($e1, $a1);

  my ($tilt) = calcDeg($g1);  return $tilt;


}


#calculate the pan required to direct at a pointsub calcPan{
  my ($X) = $_[0];

  my ($Y) = $_[1];

  
$Y *= -1;


#  my ($slope) = ($Y)/($X);

  my ($panRad) = atan2($Y, $X);

  my ($pan) = calcDeg($panRad);

  return $pan;
}

sub main{
  my ($initDroneX) = $_[0];

  my ($initDroneY) = $_[1];  my ($initDroneZ) = $_[2];
  my ($light1X)=0;

  my ($light1Y)=0;

  my ($light1Z)=10;

  my $droneX = ($initDroneX - $light1X);  
  my $droneY = ($initDroneY - $light1Y);

  my $droneZ = ($initDroneZ - $light1Z);


  my ($pan) = calcPan($droneX, $droneY);


  if($droneX > 0){

    $pan += 180;  }
  my ($tilt) = calcTilt($droneX, $droneY, $droneZ);  
  SetAngle( $tilt , 0, $pan );}


TextOut( "Start\n" );
main(0, 0, 0);
TextOut( "End\n" );