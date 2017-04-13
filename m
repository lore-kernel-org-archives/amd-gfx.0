From: Dennis Schridde <dennis.schridde-axtXthT+lymYbFdUjOg7S7NAH6kLmebB@public.gmane.org>
Subject: amdgpu 0000:84:00.0: gpu post error! \\ Fatal error during GPU init
Date: Thu, 13 Apr 2017 16:18:28 +0200
Message-ID: <6570445.DKuzpyIqJk@c07060>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1576605916=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============1576605916==
Content-Type: multipart/signed; boundary="nextPart1522759.ULZe8p0PED"; micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart1522759.ULZe8p0PED
Content-Type: multipart/mixed; boundary="nextPart11244922.Dc9rs1IUlE"
Content-Transfer-Encoding: 7Bit

This is a multi-part message in MIME format.

--nextPart11244922.Dc9rs1IUlE
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hello!

I am trying to use an AMD FirePro S7150X2 with the AMDGPU driver of a Linux 
4.10.9 kernel (CoreOS Container Linux) and linux-firmware 
e39f0e3e6897ad865b3704f61218ae83f98a85da, but I run into the following error 
after the amdgpu module is being loaded:

[   17.692746] amdgpu 0000:84:00.0: enabling device (0000 -> 0003)
[   17.692940] [drm] initializing kernel modesetting (TONGA 0x1002:0x6929 
0x1002:0x0334 0x00).
[   17.692963] [drm] register mmio base: 0xD0100000
[   17.692964] [drm] register mmio size: 262144
[   17.692970] [drm] doorbell mmio base: 0xF0000000
[   17.692971] [drm] doorbell mmio size: 2097152
[   17.692980] [drm] probing gen 2 caps for device 10b5:8747 = 8796103/10e
[   17.692981] [drm] probing mlw for device 10b5:8747 = 8796103
[   17.692992] [drm] VCE enabled in physical mode
[   18.648132] ATOM BIOS: C76301
[   18.651758] [drm] GPU posting now...
[   23.661513] [drm:amdgpu_connector_add [amdgpu]] *ERROR* atombios stuck in 
loop for more than 5secs aborting
[   23.673155] [drm:amdgpu_connector_add [amdgpu]] *ERROR* atombios stuck 
executing F250 (len 334, WS 4, PS 0) @ 0xF365
[   23.685453] [drm:amdgpu_connector_add [amdgpu]] *ERROR* atombios stuck 
executing DB34 (len 324, WS 4, PS 0) @ 0xDC2C
[   23.697816] [drm:amdgpu_connector_add [amdgpu]] *ERROR* atombios stuck 
executing BCDE (len 254, WS 0, PS 4) @ 0xBDB4
[   23.710137] [drm:amdgpu_connector_add [amdgpu]] *ERROR* atombios stuck 
executing B832 (len 143, WS 0, PS 8) @ 0xB8A9
[   23.722451] amdgpu 0000:84:00.0: gpu post error!
[   23.727950] amdgpu 0000:84:00.0: Fatal error during GPU init
[   23.734594] [drm] amdgpu: finishing device.
[   23.739592] ------------[ cut here ]------------
...
[   24.096608] ---[ end trace 88c8cb35b32e3b88 ]---
[   24.102086] BUG: unable to handle kernel NULL pointer dereference at 
0000000000000018
[   24.111438] IP: __ww_mutex_lock+0x24/0xa0
[   24.116222] PGD 0 
[   24.116223] 
[   24.120737] Oops: 0002 [#1] SMP
...

Please find a full log attached.

My kernel configuration is available at:
 https://github.com/urzds/coreos-overlay/blob/hpc_support/sys-kernel/coreos-modules/files/{commonconfig-4.10,amd64_defconfig-4.10}
Please refer to the the commit log of the "hpc_support" branch for my changes 
compared to the CoreOS CL stock config.

I would be very glad if you could help me in debugging the issue and getting 
the GPU running.

Thanks,
Dennis
--nextPart11244922.Dc9rs1IUlE
Content-Disposition: attachment; filename="node-amd-kernel-oops.log"
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-log; charset="UTF-8"; name="node-amd-kernel-oops.log"

[SOL Session operational.  Use ~? for help]
Lifecycle Controller: Done
Booting...
=1B[2J=1B[01;01H=1B[2J=1B[01;01H=1B[0;37;40m=1B[2J=1B[H=1B[0;37;40m=1B[2J=
=1B[H=0F=1B(B=1B[?1;6;7l=1B>=1B[?25h=1B[0;37;40m=1B[2J=1B[5;1H=1B[0;37;40m=
=1B[2J






=1B[2;1HBooting=1B[2;9Hfrom=1B[2;14HBRCM=1B[2;19HMBA=1B[2;23HSlot=1B[2;28H0=
100=1B[2;33Hv20.2.0=1B[4;1HBroadcom=1B[4;10HUNDI=1B[4;15HPXE-2.1=1B[4;23Hv2=
0.2.0=1B[5;1HCopyright=1B[5;11H(C)=1B[5;15H2000-2016=1B[5;25HBroadcom=1B[5;=
34HCorporation=1B[6;1HCopyright=1B[6;11H(C)=1B[6;15H1997-2000=1B[6;25HIntel=
=1B[6;31HCorporation=1B[7;1HAll=1B[7;5Hrights=1B[7;12Hreserved.=1B[8;1H=1B[=
?25h
=08
=1B[9;1HCLIENT=1B[9;8HMAC=1B[9;12HADDR:=1B[9;18H18=1B[9;21H66=1B[9;24HDA=1B=
[9;27HF0=1B[9;30H43=1B[9;33H18=1B[9;37HGUID:=1B[9;43H4C4C4544-004C-5610-804=
C-B8C04F574732=1B[10;1HDHCP.=1B[?25h=08=1B[10;6H-=1B[10;6H=1B[?25h=08=1B[10=
;6H=08=1B[10;6H\=1B[10;6H=1B[?25h=08=1B[10;6H=08=1B[10;6H|=1B[10;6H=1B[?25h=
=08=1B[10;6H=08=1B[10;6H/=1B[10;6H=1B[?25h=08=1B[10;6H=08=1B[10;6H-=1B[10;6=
H=1B[?25h=08=1B[10;6H=08=1B[10;6H\=1B[10;6H=1B[?25h=08=1B[10;6H=08=1B[10;6H=
|=1B[10;6H=1B[?25h=08=1B[10;6H=08=1B[10;6H/=1B[10;6H=1B[?25h=08=1B[10;6H=08=
=1B[10;6H-=1B[10;6H=1B[?25h=08=1B[10;6H=08=1B[10;6H\=1B[10;6H=1B[?25h=08=1B=
[10;6H=08=1B[10;6H|=1B[10;6H=1B[?25h=08=1B[10;6H=08=1B[10;6H/=1B[10;6H=1B[?=
25h=08=1B[10;6H=08=1B[10;6H-=1B[10;6H=1B[?25h=08=1B[10;6H=08=1B[10;6H\=1B[1=
0;6H=1B[?25h=08=1B[10;6H=08=1B[10;6H|=1B[10;6H=1B[?25h=08=1B[10;6H=08=1B[10=
;6H/=1B[10;6H=1B[?25h=08=1B[10;6H=08=1B[10;6H-=1B[10;6H=1B[?25h=08=1B[10;6H=
=08=1B[10;6H\=1B[10;6H=1B[?25h=08=1B[10;6H=08=1B[10;6H|=1B[10;6H=1B[?25h=08=
=1B[10;6H=08=1B[10;6H/=1B[10;6H=1B[?25h=08=1B[10;6H=08=1B[10;6H-=1B[10;6H=
=1B[?25h=08=1B[10;6H=08=1B[10;6H\=1B[10;6H=1B[?25h=08=1B[10;6H=08=1B[10;6H|=
=1B[10;6H=1B[?25h=08=1B[10;6H=08=1B[10;6H/=1B[10;6H=1B[?25h=08=1B[10;6H=08=
=1B[10;6H-=1B[10;6H=1B[?25h=08=1B[10;6H=08=1B[10;6H\=1B[10;6H=1B[?25h=08=1B=
[10;6H=08=1B[10;6H|=1B[10;6H=1B[?25h=08=1B[10;6H=08=1B[10;6H/=1B[10;6H=1B[?=
25h=08=1B[10;6H=08=1B[10;6H-=1B[10;6H=1B[?25h=08=1B[10;6H=08=1B[10;6H\=1B[1=
0;6H=1B[?25h=08=1B[10;6H=08=1B[10;6H|=1B[10;6H=1B[?25h=08=1B[10;6H=08=1B[10=
;6H/=1B[10;6H=1B[?25h=08=1B[10;6H=08=1B[10;6H-=1B[10;6H=1B[?25h=08=1B[10;6H=
=08=1B[10;6H\=1B[10;6H=1B[?25h=08=1B[10;6H=08=1B[10;6H|=1B[10;6H=1B[?25h=08=
=1B[10;6H=08=1B[10;6H/=1B[10;6H=1B[?25h=08=1B[10;6H=08=1B[10;6H-=1B[10;6H=
=1B[?25h=08=0D=0D

=0D=0D=0D=0D=1B[10;1HCLIENT=1B[10;8HIP:=1B[10;12H192.168.10.73=1B[10;27HMAS=
K:=1B[10;33H255.255.255.0=1B[10;48HDHCP=1B[10;53HIP:=1B[10;57H192.168.10.27=
=1B[11;1HGATEWAY=1B[11;9HIP:=1B[11;13H192.168.10.27=1B[12;1HTFTP.=1B[?25h=
=0D=0D=0D


=0D=1B[12;1HPXE->EB:=1B[12;10H!PXE=1B[12;15Hat=1B[12;18H95E1:0040,=1B[12;29=
Hentry=1B[12;35Hpoint=1B[12;41Hat=1B[12;44H95E1:00D6=1B[13;10HUNDI=1B[13;15=
Hcode=1B[13;20Hsegment=1B[13;28H95E1:6B70,=1B[13;39Hdata=1B[13;44Hsegment=
=1B[13;52H922A:3B70=1B[13;62H(584-627kB)=1B[14;10HUNDI=1B[14;15Hdevice=1B[1=
4;22His=1B[14;25HPCI=1B[14;29H01:00.0,=1B[14;38Htype=1B[14;43HDIX+802.3=1B[=
15;1H=1B[?25h
=0D=1B[15;10H584kB=1B[15;16Hfree=1B[15;21Hbase=1B[15;26Hmemory=1B[15;33Haft=
er=1B[15;39HPXE=1B[15;43Hunload=1B[16;1HiPXE=1B[16;6Hinitialising=1B[16;19H=
devices...=1B[?25h






=1B[16;29Hok=1B[0m=1B[1;37;40m=1B[20;1HiPXE 1.0.0+ (6c748)=1B[0m=1B[37;40m=
=1B[20;21H--=1B[20;24HOpen=1B[20;29HSource=1B[20;36HNetwork=1B[20;44HBoot=
=1B[20;49HFirmware=1B[20;58H--=1B[0m=1B[36;40m=1B[20;61Hhttp://ipxe.org=1B[=
0m=1B[37;40m=1B[21;1HFeatures:=1B[21;11HDNS=1B[21;15HHTTP=1B[21;20HiSCSI=1B=
[21;26HTFTP=1B[21;31HAoE=1B[21;35HELF=1B[21;39HMBOOT=1B[21;45HPXE=1B[21;49H=
bzImage=1B[21;57HMenu=1B[21;62HPXEXT=1B[23;1HPress=1B[23;7HCtrl-B=1B[23;14H=
for=1B[23;18Hthe=1B[23;22HiPXE=1B[23;27Hcommand=1B[23;35Hline...=1B[?25h=08=
=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=
=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=
=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=
=08=08=08=08=08=08


=1B[22;1Hnet0:=1B[22;7H18:66:da:f0:43:18 using u=1B[22;34Hionly on=1B[22;43=
H0000:01:00.0=1B[22;56H(open)=1B[23;3H[Link:up,=1B[23;13HTX:0=1B[23;18HTXE:=
1=1B[23;24HRX:0=1B[23;29HRXE:0]=1B[24;3H[TXE:=1B[24;9H1=1B[24;11Hx=1B[24;13=
H"Network=1B[24;22Hunreachable=1B[24;34H(http://ipxe.org/28086011)"]=1B[25;=
1HConfiguring=1B[25;13H(net0=1B[25;19H18:66:da:f0:43:18)...=1B[?25h.=1B[?25=
h.=1B[?25h






=1B[1;1HGAT=1B[1;5HWAY IP: 192.16=1B[1;20H.10.27=1B[1;27H  =1B[1;30H  =1B[1=
;33H  =1B[1;37H     =1B[1;43H                                    =1B[2;1HPX=
E->EB: !PXE at 95E1:0040, entry point at 95E1:00D6   =1B[2;57H             =
=1B[3;1H       =1B[3;9H UNDI code segment=1B[3;28H95E1:6B70,=1B[3;39Hdata=
=1B[3;44Hsegment=1B[3;52H922A:3B70=1B[3;62H(584-627kB)=1B[4;1H        =1B[4=
;10HUNDI=1B[4;15Hdevice is PCI=1B[4;29H01:00.0, type DIX+802.3 =1B[5;10H584=
kB fr=1B[5;19He bas=1B[5;25H memory after=1B[5;39HPXE unload  =1B[5;52H    =
     =1B[5;62H           =1B[6;1HiPXE=1B[6;6Hinitialising d=1B[6;21Hv=1B[6;=
23Hces...ok      =1B[6;38H    =1B[6;43H         =1B[7;10H     =1B[7;16H    =
=1B[7;21H    =1B[7;26H      =1B[7;33H     =1B[7;39H   =1B[7;43H      =1B[8;=
1H    =1B[8;6H            =1B[8;19H            =1B[0m=1B[1;37;40m=1B[10;1Hi=
PXE 1.0.0+ (6c748)=1B[0m=1B[37;40m=1B[10;21H--=1B[10;24HOpen=1B[10;29HSourc=
e=1B[10;36HNetwork=1B[10;44HBoot=1B[10;49HFirmware=1B[10;58H--=1B[0m=1B[36;=
40m=1B[10;61Hhttp://ipxe.org=1B[0m=1B[37;40m=1B[11;1HFeatures:=1B[11;11HDNS=
=1B[11;15HHTTP=1B[11;20HiSCSI=1B[11;26HTFTP=1B[11;31HAoE=1B[11;35HELF=1B[11=
;39HMBOOT=1B[11;45HPXE=1B[11;49HbzImage=1B[11;57HMenu=1B[11;62HPXEXT=1B[12;=
1H                   =1B[12;21H  =1B[12;24H    =1B[12;29H      =1B[12;36H  =
     =1B[12;44H    =1B[12;49H        =1B[12;58H  =1B[12;61H               =
=1B[13;1Hn=1B[13;3Ht0: 18=1B[13;10H66:da:f0:43:18 using=1B[13;31Hundionly o=
n 0000:01:00.0 (open)     =1B[14;3H[Link:up,=1B[14;13HTX:0=1B[14;18HTXE:1=
=1B[14;24HRX:0=1B[14;29HRXE:0]=1B[15;1H  [TXE: 1 x "Network unreachable (ht=
tp://ipxe.org/28086011)"]=1B[16;1HConf=1B[16;6Hguring=1B[16;13H(net0 18=1B[=
16;22H66:da:f0:43:18).....=1B[16;43Hok=1B[17;1Hnet0: 192.168.10.73/255.255.=
255.0 gw 192.168.10.27           =1B[18;1HNext se=1B[18;9Hver: 192.16=1B[18=
;21H.10.27               =1B[19;1HFilename:=1B[19;11Hhttp://192.168.10.27:8=
080/boot.ipxe=1B[20;1Hhttp://192.168.10.27:8080/boot.ipxe...=1B[20;40Hok=1B=
[21;1Hboot.ipxe=1B[21;11H:=1B[21;13H104=1B[21;17Hbytes=1B[21;23H[script]=1B=
[22;1Hipxe?uuid=3D4c4c4544-004c-5610-804c-b8c04f574732&mac=3D18-66-da-f0-43=
=2D18&domain=3D&hos=1B[23;1Htname=3Dlocal_mutalisk10&serial=3D8LVLWG2...=1B=
[23;42Hok=1B[24;1H/assets/coreos/developer-1381.0.0+2017-04-13-1434-a1/core=
os_production_pxe.vmlin=1B[25;1Huz...=1B[?25h
=1B[1;1H        =1B[1;10HUNDI=1B[1;15Hcode segment 95E1:6B70, data=1B[1;44H=
segment 922A:3B70=1B[1;62H(584-627kB)=1B[2;15Hdevice is PCI 01:00.0, type D=
IX+802.3         =1B[2;62H           =1B[3;10H584kB free ba=1B[3;24He memor=
y after PXE=1B[3;43Hunload   =1B[4;1HiPXE=1B[4;6Hinitialising devic=1B[4;25=
Hs...=1B[4;30Hk =1B[4;33H     =1B[4;39H   =1B[4;43H      =1B[5;1H    =1B[5;=
6H            =1B[5;19H            =1B[0m=1B[1;37;40m=1B[8;1HiPXE 1.0.0+ (6=
c748)=1B[0m=1B[37;40m=1B[8;21H--=1B[8;24HOpen=1B[8;29HSource=1B[8;36HNetwor=
k=1B[8;44HBoot=1B[8;49HFirmware=1B[8;58H--=1B[0m=1B[36;40m=1B[8;61Hhttp://i=
pxe.org=1B[0m=1B[37;40m=1B[9;1HFeatures: DNS HTTP iSCSI TFTP AoE ELF MBOOT =
PXE=1B[9;49HbzI=1B[9;53Hage Menu PXEXT         =1B[10;1H         =1B[10;11H=
   =1B[10;15H    =1B[10;20H     =1B[10;26H    =1B[10;31H   =1B[10;35H   =1B=
[10;39H     =1B[10;45H   =1B[10;49H       =1B[10;57H    =1B[10;62H     =1B[=
11;1Hnet0:=1B[11;7H18:66:da:f0:43:18=1B[11;25Husing=1B[11;31Hundionly=1B[11=
;40Hon=1B[11;43H0000:01:00.0=1B[11;56H(open)=1B[12;1H  [Link:up, TX=1B[12;1=
6H0 TXE=1B[12;23H RX:0 RXE:0]    =1B[12;40H  =1B[12;43H            =1B[12;5=
6H      =1B[13;4HTXE: 1 x=1B[13;13H"Network unreachable (http://ipxe.org/28=
086011)"]=1B[14;1HConfiguring=1B[14;13H(n=1B[14;17H0 18:66:d=1B[14;27H:f0:4=
3:18)..... ok                 =1B[15;1Hnet0: 192.168.10.73/255.255.255.0 gw=
 192=1B[15;42H168.10.27=1B[16;1HN=1B[16;3Hxt server: 192=1B[16;18H168.10=1B=
[16;26H7       =1B[16;35H  =1B[16;38H             =1B[17;1HFilename: http:/=
/=1B[17;19H92=1B[17;23H68.10.27:8080/boot.ipxe=1B[18;1Hhttp://192.168.10.27=
:80=1B[18;25H0/boot.ipxe... ok    =1B[19;1Hboot.ipxe : 104 bytes [script]  =
      =1B[19;40H  =1B[20;1Hipxe?uuid=3D4c4c=1B[20;16H544-004c-5610-804c-b8c=
04f574732&mac=3D18-66-da-f0-43-18&domain=3D&hos=1B[21;1Htname=3Dlocal_mutal=
isk10&serial=3D8LVLWG2... ok                                     =1B[22;1H/=
ass=1B[22;6Hts/=1B[22;10Horeos/developer-1381.0.0+2017-04-13-1434-a1/coreos=
_production_pxe.vmlin=1B[23;1Huz... ok                                     =
                                   =1B[24;1H/assets/coreos/developer-1381.0=
=2E0+2017-04-13-1434-a1/coreos_production_pxe_image=1B[25;1H.cpio.gz...=1B[=
?25h=1B[25;13H30%=1B[?25h=08=08=08=08=08=08=08=08=1B[25;13H65=1B[25;16H=1B[=
?25h=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08
=1B[24;13Hok =1B[25;1H=1B[?25h=1B[0;37;40m=1B[2J=1B[H[    0.000000] Linux v=
ersion 4.10.9-coreos (tf128@c07060) (gcc version 4.9.4 (Gentoo Hardened 4.9=
=2E4 p1.0, pie-0.6.4) ) #1 SMP Thu Apr 13 11:26:21 CEST 2017
[    0.000000] Command line: coreos.config.url=3Dhttp://192.168.10.27:8080/=
ignition?uuid=3D4c4c4544-004c-5610-804c-b8c04f574732&mac=3D18-66-da-f0-43-1=
8 coreos.autologin coreos.first_boot console=3DttyS0,115200n8 console=3Dtty0
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 by=
tes, using 'standard' format.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000008dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000008e000-0x000000000009ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007a288fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007a289000-0x000000007af0afff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000007af0b000-0x000000007b93afff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x000000007b93b000-0x000000007bab3fff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x000000007bab4000-0x000000007bae8fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007bae9000-0x000000007bafefff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x000000007baff000-0x000000007bafffff] usable
[    0.000000] BIOS-e820: [mem 0x000000007bb00000-0x000000008fffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000feda8000-0x00000000fedabfff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000ff310000-0x00000000ffffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000407fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: Dell Inc. PowerEdge R730/0WCJNT, BIOS 2.2.5 09/06/2016
[    0.000000] e820: last_pfn =3D 0x4080000 max_arch_pfn =3D 0x400000000
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- WT=
 =20
[    0.000000] e820: last_pfn =3D 0x7bb00 max_arch_pfn =3D 0x400000000
[    0.000000] Using GB pages for direct mapping
[    0.000000] RAMDISK: [mem 0x6ad4a000-0x7a1eafff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000FE320 000024 (v02 DELL  )
[    0.000000] ACPI: XSDT 0x000000007BAF9188 0000D4 (v01 DELL   PE_SC3   00=
000000      01000013)
[    0.000000] ACPI: FACP 0x000000007BAAC000 0000F4 (v04 DELL   PE_SC3   00=
000000 DELL 00000001)
[    0.000000] ACPI: DSDT 0x000000007BA94000 0107EF (v02 DELL   PE_SC3   00=
000003 DELL 00000001)
[    0.000000] ACPI: FACS 0x000000007B8C2000 000040
[    0.000000] ACPI: MCEJ 0x000000007BAB1000 000130 (v01 INTEL           00=
000001 INTL 0100000D)
[    0.000000] ACPI: SSDT 0x000000007BAB0000 0003C6 (v02 DELL   Tpm2Tabl 00=
001000 INTL 20121114)
[    0.000000] ACPI: TPM2 0x000000007BAAF000 000038 (v04 DELL   EDK2     00=
000002      01000013)
[    0.000000] ACPI: WD__ 0x000000007BAAE000 000134 (v01 DELL   PE_SC3   00=
000001 DELL 00000001)
[    0.000000] ACPI: SLIC 0x000000007BAAD000 000024 (v01 DELL   PE_SC3   00=
000001 DELL 00000001)
[    0.000000] ACPI: HPET 0x000000007BAAB000 000038 (v01 DELL   PE_SC3   00=
000001 DELL 00000001)
[    0.000000] ACPI: APIC 0x000000007BAAA000 000AFC (v02 DELL   PE_SC3   00=
000000 DELL 00000001)
[    0.000000] ACPI: MCFG 0x000000007BAA9000 00003C (v01 DELL   PE_SC3   00=
000001 DELL 00000001)
[    0.000000] ACPI: MSCT 0x000000007BAA8000 000090 (v01 DELL   PE_SC3   00=
000001 DELL 00000001)
[    0.000000] ACPI: SLIT 0x000000007BAA7000 00006C (v01 DELL   PE_SC3   00=
000001 DELL 00000001)
[    0.000000] ACPI: SRAT 0x000000007BAA5000 001130 (v03 DELL   PE_SC3   00=
000001 DELL 00000001)
[    0.000000] ACPI: SSDT 0x000000007B951000 1424A9 (v02 DELL   PE_SC3   00=
004000 INTL 20121114)
[    0.000000] ACPI: SSDT 0x000000007B94E000 002198 (v02 DELL   PE_SC3   00=
000002 INTL 20121114)
[    0.000000] ACPI: SSDT 0x000000007B94D000 00006E (v02 DELL   PE_SC3   00=
000002 INTL 20121114)
[    0.000000] ACPI: PRAD 0x000000007B94C000 000132 (v02 DELL   PE_SC3   00=
000002 INTL 20121114)
[    0.000000] ACPI: SPCR 0x000000007BAFE000 000050 (v01                 00=
000000      00000000)
[    0.000000] ACPI: DMAR 0x000000007BAFD000 000120 (v01 DELL   PE_SC3   00=
000001 DELL 00000001)
[    0.000000] ACPI: HEST 0x000000007BAFC000 00017C (v01 DELL   PE_SC3   00=
000002 DELL 00000001)
[    0.000000] ACPI: BERT 0x000000007BAFB000 000030 (v01 DELL   PE_SC3   00=
000002 DELL 00000001)
[    0.000000] ACPI: ERST 0x000000007BAFA000 000230 (v01 DELL   PE_SC3   00=
000002 DELL 00000001)
[    0.000000] ACPI: EINJ 0x000000007BAF8000 000150 (v01 DELL   PE_SC3   00=
000002 DELL 00000001)
[    0.000000] SRAT: PXM 0 -> APIC 0x00 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x20 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x02 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x22 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x04 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x24 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x06 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x26 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x08 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x28 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x0a -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x2a -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x0c -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x2c -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x10 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x30 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x12 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x32 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x14 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x34 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x16 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x36 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x18 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x38 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x1a -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x3a -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x1c -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x3c -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x01 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x21 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x03 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x23 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x05 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x25 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x07 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x27 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x09 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x29 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x0b -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x2b -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x0d -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x2d -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x11 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x31 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x13 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x33 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x15 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x35 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x17 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x37 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x19 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x39 -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x1b -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x3b -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x1d -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x3d -> Node 1
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x207fffffff]
[    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0x2080000000-0x407fffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x207fffa000-0x207fffffff]
[    0.000000] NODE_DATA(1) allocated [mem 0x407fff9000-0x407fffefff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000407fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000008dfff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x000000007a288fff]
[    0.000000]   node   0: [mem 0x000000007bab4000-0x000000007bae8fff]
[    0.000000]   node   0: [mem 0x000000007baff000-0x000000007bafffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000207fffffff]
[    0.000000]   node   1: [mem 0x0000002080000000-0x000000407fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000207ffff=
fff]
[    0.000000] Initmem setup node 1 [mem 0x0000002080000000-0x000000407ffff=
fff]
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x05] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x06] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x07] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x08] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x09] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x10] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x11] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x12] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x13] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x14] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x15] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x16] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x17] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x18] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x19] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x20] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x21] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x22] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x23] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x24] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x25] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x26] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x27] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x28] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x29] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x2a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x2b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x2c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x2d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x2e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x2f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x30] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x31] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x32] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x33] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x34] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x35] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x36] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x37] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x38] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x39] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x3a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x3b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x3c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x3d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x3e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x3f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x40] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x41] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x42] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x43] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x44] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x45] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x46] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x47] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x48] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x49] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x4a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x4b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x4c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x4d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x4e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x4f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x50] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x51] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x52] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x53] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x54] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x55] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x56] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x57] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x58] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x59] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x5a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x5b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x5c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x5d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x5e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x5f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x60] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x61] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x62] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x63] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x64] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x65] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x66] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x67] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x68] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x69] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x6a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x6b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x6c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x6d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x6e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x6f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x70] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x71] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x72] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x73] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x74] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x75] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x76] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x77] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x78] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x79] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x7a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x7b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x7c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x7d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x7e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x7f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x80] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x81] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x82] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x83] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x84] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x85] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x86] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x87] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x88] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x89] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x8a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x8b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x8c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x8d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x8e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x8f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x90] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x91] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x92] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x93] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x94] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x95] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x96] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x97] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x98] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x99] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x9a] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x9b] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x9c] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x9d] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x9e] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x9f] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xa0] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xa1] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xa2] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xa3] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xa4] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xa5] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xa6] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xa7] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xa8] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xa9] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xaa] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xab] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xac] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xad] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xae] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xaf] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xb0] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xb1] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xb2] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xb3] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xb4] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xb5] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xb6] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xb7] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xb8] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xb9] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xba] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xbb] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xbc] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xbd] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xbe] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xbf] high level lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-=
23
[    0.000000] IOAPIC[1]: apic_id 9, version 32, address 0xfec01000, GSI 24=
=2D47
[    0.000000] IOAPIC[2]: apic_id 10, version 32, address 0xfec40000, GSI 4=
8-71
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.000000] smpboot: Allowing 56 CPUs, 0 hotplug CPUs
[    0.000000] e820: [mem 0x90000000-0xfeda7fff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:56 =
nr_node_ids:2
[    0.000000] percpu: Embedded 35 pages/cpu @ffff927b7f600000 s104600 r819=
2 d30568 u262144
[    0.000000] Built 2 zonelists in Node order, mobility grouping on.  Tota=
l pages: 66036651
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: rootflags=3Drw mount.usrflags=3Dro core=
os.config.url=3Dhttp://192.168.10.27:8080/ignition?uuid=3D4c4c4544-004c-561=
0-804c-b8c04f574732&mac=3D18-66-da-f0-43-18 coreos.autologin coreos.first_b=
oot console=3DttyS0,115200n8 console=3Dtty0
[    0.000000] log_buf_len individual max cpu contribution: 4096 bytes
[    0.000000] log_buf_len total cpu_extra contributions: 225280 bytes
[    0.000000] log_buf_len min size: 262144 bytes
[    0.000000] log_buf_len: 524288 bytes
[    0.000000] early log buf free: 235676(89%)
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Memory: 263776016K/268339504K available (6100K kernel code, =
1244K rwdata, 2512K rodata, 31644K init, 864K bss, 4563488K reserved, 0K cm=
a-reserved)
[    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D56, =
Nodes=3D2
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=3D512 to nr_cpu_ids=3D56.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=3D64, nr_cpu_ids=
=3D56
[    0.000000] NR_IRQS:33024 nr_irqs:1688 16
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] console [ttyS0] enabled
[    0.000000] mempolicy: Enabling automatic NUMA balancing. Configure with=
 numa_balancing=3D or the kernel.numa_balancing sysctl
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, =
max_idle_ns: 133484882848 ns
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2599.804 MHz processor
[    0.000027] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 5199.60 BogoMIPS (lpj=3D2599804)
[    0.012406] pid_max: default: 57344 minimum: 448
[    0.017877] ACPI: Core revision 20160930
[    0.095361] ACPI: 5 ACPI AML tables successfully acquired and loaded
[    0.102828] Security Framework initialized
[    0.107699] SELinux:  Initializing.
[    0.120985] Dentry cache hash table entries: 33554432 (order: 16, 268435=
456 bytes)
[    0.174129] Inode-cache hash table entries: 16777216 (order: 15, 1342177=
28 bytes)
[    0.202832] Mount-cache hash table entries: 524288 (order: 10, 4194304 b=
ytes)
[    0.211271] Mountpoint-cache hash table entries: 524288 (order: 10, 4194=
304 bytes)
[    0.221887] CPU: Physical Processor ID: 0
[    0.226673] CPU: Processor Core ID: 0
[    0.231059] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.238067] ENERGY_PERF_BIAS: View and update with x86_energy_perf_polic=
y(8)
[    0.246246] mce: CPU supports 22 MCE banks
[    0.251134] CPU0: Thermal monitoring enabled (TM1)
[    0.256801] process: using mwait in idle threads
[    0.262256] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.268590] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.276110] Freeing SMP alternatives memory: 24K
[    0.283606] ftrace: allocating 24093 entries in 95 pages
[    0.297607] smpboot: Max logical packages: 4
[    0.302689] DMAR: Host address width 46
[    0.307269] DMAR: DRHD base: 0x000000fbffc000 flags: 0x0
[    0.313507] DMAR: dmar0: reg_base_addr fbffc000 ver 1:0 cap 8d2078c106f0=
466 ecap f020df
[    0.322965] DMAR: DRHD base: 0x000000c7ffc000 flags: 0x1
[    0.329196] DMAR: dmar1: reg_base_addr c7ffc000 ver 1:0 cap 8d2078c106f0=
466 ecap f020df
[    0.338656] DMAR: RMRR base: 0x0000007ae07000 end: 0x0000007af06fff
[    0.345956] DMAR: ATSR flags: 0x0
[    0.349949] DMAR: ATSR flags: 0x0
[    0.353944] DMAR-IR: IOAPIC id 10 under DRHD base  0xfbffc000 IOMMU 0
[    0.361434] DMAR-IR: IOAPIC id 8 under DRHD base  0xc7ffc000 IOMMU 1
[    0.368834] DMAR-IR: IOAPIC id 9 under DRHD base  0xc7ffc000 IOMMU 1
[    0.376227] DMAR-IR: HPET id 0 under DRHD base 0xc7ffc000
[    0.382560] DMAR-IR: x2apic is disabled because BIOS sets x2apic opt out=
 bit.
[    0.382561] DMAR-IR: Use 'intremap=3Dno_x2apic_optout' to override the B=
IOS setting.
[    0.400596] DMAR-IR: Enabled IRQ remapping in xapic mode
[    0.406820] x2apic: IRQ remapping doesn't support X2APIC mode
[    0.413537] Switched APIC routing to physical flat.
[    0.419898] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
=2D1
[    0.436911] smpboot: CPU0: Intel(R) Xeon(R) CPU E5-2690 v4 @ 2.60GHz (fa=
mily: 0x6, model: 0x4f, stepping: 0x1)
[    0.448678] Performance Events: PEBS fmt2+, Broadwell events, 16-deep LB=
R, full-width counters, Intel PMU driver.
[    0.460678] ... version:                3
[    0.465448] ... bit width:              48
[    0.470316] ... generic registers:      4
[    0.475083] ... value mask:             0000ffffffffffff
[    0.481309] ... max period:             00007fffffffffff
[    0.487536] ... fixed-purpose events:   3
[    0.492302] ... event mask:             000000070000000f
[    0.501230] NMI watchdog: enabled on all CPUs, permanently consumes one =
hw-PMU counter.
[    0.510692] smp: Bringing up secondary CPUs ...
[    0.516140] x86: Booting SMP configuration:
[    0.521102] .... node  #1, CPUs:        #1
[    0.607258] .... node  #0, CPUs:    #2
[    0.673015] .... node  #1, CPUs:    #3
[    0.738737] .... node  #0, CPUs:    #4
[    0.804476] .... node  #1, CPUs:    #5
[    0.870201] .... node  #0, CPUs:    #6
[    0.935941] .... node  #1, CPUs:    #7
[    1.001670] .... node  #0, CPUs:    #8
[    1.067415] .... node  #1, CPUs:    #9
[    1.133138] .... node  #0, CPUs:   #10
[    1.198877] .... node  #1, CPUs:   #11
[    1.264611] .... node  #0, CPUs:   #12
[    1.330356] .... node  #1, CPUs:   #13
[    1.396095] .... node  #0, CPUs:   #14
[    1.461840] .... node  #1, CPUs:   #15
[    1.527566] .... node  #0, CPUs:   #16
[    1.593320] .... node  #1, CPUs:   #17
[    1.659042] .... node  #0, CPUs:   #18
[    1.724784] .... node  #1, CPUs:   #19
[    1.790512] .... node  #0, CPUs:   #20
[    1.856256] .... node  #1, CPUs:   #21
[    1.921983] .... node  #0, CPUs:   #22
[    1.987732] .... node  #1, CPUs:   #23
[    2.053456] .... node  #0, CPUs:   #24
[    2.119204] .... node  #1, CPUs:   #25
[    2.184930] .... node  #0, CPUs:   #26
[    2.250680] .... node  #1, CPUs:   #27
[    2.316407] .... node  #0, CPUs:   #28
[    2.382204] .... node  #1, CPUs:   #29
[    2.447930] .... node  #0, CPUs:   #30
[    2.513668] .... node  #1, CPUs:   #31
[    2.579478] .... node  #0, CPUs:   #32
[    2.645226] .... node  #1, CPUs:   #33
[    2.710955] .... node  #0, CPUs:   #34
[    2.776689] .... node  #1, CPUs:   #35
[    2.842414] .... node  #0, CPUs:   #36
[    2.908158] .... node  #1, CPUs:   #37
[    2.973885] .... node  #0, CPUs:   #38
[    3.039628] .... node  #1, CPUs:   #39
[    3.105355] .... node  #0, CPUs:   #40
[    3.171104] .... node  #1, CPUs:   #41
[    3.236828] .... node  #0, CPUs:   #42
[    3.302569] .... node  #1, CPUs:   #43
[    3.368295] .... node  #0, CPUs:   #44
[    3.434043] .... node  #1, CPUs:   #45
[    3.499777] .... node  #0, CPUs:   #46
[    3.565517] .... node  #1, CPUs:   #47
[    3.631252] .... node  #0, CPUs:   #48
[    3.697001] .... node  #1, CPUs:   #49
[    3.762724] .... node  #0, CPUs:   #50
[    3.828475] .... node  #1, CPUs:   #51
[    3.894204] .... node  #0, CPUs:   #52
[    3.959950] .... node  #1, CPUs:   #53
[    4.025684] .... node  #0, CPUs:   #54
[    4.091434] .... node  #1, CPUs:   #55
[    4.152602] smp: Brought up 2 nodes, 56 CPUs
[    4.162132] smpboot: Total of 56 processors activated (291567.59 BogoMIP=
S)
[    4.324480] devtmpfs: initialized
[    4.328515] x86/mm: Memory block size: 2048MB
[    4.335674] PM: Registering ACPI NVS region [mem 0x7af0b000-0x7b93afff] =
(10682368 bytes)
[    4.345473] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 1911260446275000 ns
[    4.356937] futex hash table entries: 16384 (order: 8, 1048576 bytes)
[    4.364819] pinctrl core: initialized pinctrl subsystem
[    4.371628] NET: Registered protocol family 16
[    4.382893] cpuidle: using governor menu
[    4.387563] PCCT header not found.
[    4.391778] ACPI FADT declares the system doesn't support PCIe ASPM, so =
disable it
[    4.400754] ACPI: bus type PCI registered
[    4.405526] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    4.413089] dca service started, version 1.12.1
[    4.418456] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000=
=2D0x8fffffff] (base 0x80000000)
[    4.429426] PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved in E820
[    4.437314] PCI: Using configuration type 1 for base access
[    4.443839] PCI: Dell System detected, enabling pci=3Dbfsort.
[    4.465343] HugeTLB registered 1 GB page size, pre-allocated 0 pages
[    4.472747] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    4.480824] ACPI: Added _OSI(Module Device)
[    4.485797] ACPI: Added _OSI(Processor Device)
[    4.491050] ACPI: Added _OSI(3.0 _SCP Extensions)
[    4.496608] ACPI: Added _OSI(Processor Aggregator Device)
[    4.599569] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    4.617541] ACPI: Interpreter enabled
[    4.621939] ACPI: (supports S0 S5)
[    4.626035] ACPI: Using IOAPIC for interrupt routing
[    4.631912] HEST: Table parsing has been initialized.
[    4.637859] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    4.658133] ACPI: PCI Root Bridge [UNC1] (domain 0000 [bus ff])
[    4.665053] acpi PNP0A03:02: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI]
[    4.674777] acpi PNP0A03:02: PCIe AER handled by firmware
[    4.681206] acpi PNP0A03:02: _OSC: OS now controls [PCIeHotplug PME PCIe=
Capability]
[    4.690290] acpi PNP0A03:02: FADT indicates ASPM is unsupported, using B=
IOS configuration
[    4.699990] PCI host bridge to bus 0000:ff
[    4.704863] pci_bus 0000:ff: root bus resource [bus ff]
[    4.713659] ACPI: PCI Root Bridge [UNC0] (domain 0000 [bus 7f])
[    4.720576] acpi PNP0A03:03: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI]
[    4.730291] acpi PNP0A03:03: PCIe AER handled by firmware
[    4.736720] acpi PNP0A03:03: _OSC: OS now controls [PCIeHotplug PME PCIe=
Capability]
[    4.745803] acpi PNP0A03:03: FADT indicates ASPM is unsupported, using B=
IOS configuration
[    4.755498] PCI host bridge to bus 0000:7f
[    4.760368] pci_bus 0000:7f: root bus resource [bus 7f]
[    4.770267] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7e])
[    4.777475] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI]
[    4.787196] acpi PNP0A08:00: PCIe AER handled by firmware
[    4.793624] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIe=
Capability]
[    4.802703] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using B=
IOS configuration
[    4.812510] PCI host bridge to bus 0000:00
[    4.817384] pci_bus 0000:00: root bus resource [io  0x0000-0x03bb window]
[    4.825267] pci_bus 0000:00: root bus resource [io  0x03bc-0x03df window]
[    4.833146] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    4.841032] pci_bus 0000:00: root bus resource [io  0x1000-0x7fff window]
[    4.848918] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]
[    4.857801] pci_bus 0000:00: root bus resource [mem 0x90000000-0xc7ffbff=
f window]
[    4.866686] pci_bus 0000:00: root bus resource [mem 0x38000000000-0x3bff=
fffffff window]
[    4.876149] pci_bus 0000:00: root bus resource [bus 00-7e]
[    4.882879] pci 0000:00:01.0: System wakeup disabled by ACPI
[    4.889676] pci 0000:00:02.0: System wakeup disabled by ACPI
[    4.896443] pci 0000:00:03.0: System wakeup disabled by ACPI
[    4.903181] pci 0000:00:03.1: System wakeup disabled by ACPI
[    4.909939] pci 0000:00:03.2: System wakeup disabled by ACPI
[    4.917920] pci 0000:00:1c.0: Enabling MPC IRBNCE
[    4.923483] pci 0000:00:1c.0: Intel PCH root port ACS workaround enabled
[    4.931430] pci 0000:00:1c.7: Enabling MPC IRBNCE
[    4.936987] pci 0000:00:1c.7: Intel PCH root port ACS workaround enabled
[    4.944804] pci 0000:00:1c.7: System wakeup disabled by ACPI
[    4.952052] pci 0000:00:01.0: PCI bridge to [bus 03]
[    4.957930] pci 0000:00:02.0: PCI bridge to [bus 04]
[    4.967789] pci 0000:00:03.0: PCI bridge to [bus 02]
[    4.976646] pci 0000:00:03.1: PCI bridge to [bus 01]
[    4.982520] pci 0000:00:03.2: PCI bridge to [bus 05]
[    4.988388] pci 0000:00:1c.0: PCI bridge to [bus 06]
[    5.001388] pci 0000:00:1c.7: PCI bridge to [bus 07-0b]
[    5.015137] pci 0000:07:00.0: PCI bridge to [bus 08-0b]
[    5.027598] pci 0000:08:00.0: PCI bridge to [bus 09-0a]
[    5.040781] pci 0000:09:00.0: PCI bridge to [bus 0a]
[    5.048001] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 11 12 1=
4 *15)
[    5.056634] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 *=
14 15)
[    5.065255] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 =
14 15)
[    5.073879] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 *6 7 9 10 11 12 =
14 15)
[    5.082508] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 1=
4 15) *0, disabled.
[    5.092398] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 1=
4 15) *0, disabled.
[    5.102282] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 1=
4 15) *0, disabled.
[    5.112175] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11 12 1=
4 15) *0, disabled.
[    5.122216] ACPI: PCI Root Bridge [PCI1] (domain 0000 [bus 80-fe])
[    5.129424] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI]
[    5.139133] acpi PNP0A08:01: PCIe AER handled by firmware
[    5.145559] acpi PNP0A08:01: _OSC: OS now controls [PCIeHotplug PME PCIe=
Capability]
[    5.154643] acpi PNP0A08:01: FADT indicates ASPM is unsupported, using B=
IOS configuration
[    5.164411] PCI host bridge to bus 0000:80
[    5.169282] pci_bus 0000:80: root bus resource [io  0x8000-0xffff window]
[    5.177167] pci_bus 0000:80: root bus resource [mem 0xc8000000-0xfbffbff=
f window]
[    5.186056] pci_bus 0000:80: root bus resource [mem 0x3c000000000-0x3fff=
fffffff window]
[    5.195526] pci_bus 0000:80: root bus resource [bus 80-fe]
[    5.202061] pci 0000:80:01.0: System wakeup disabled by ACPI
[    5.208800] pci 0000:80:02.0: System wakeup disabled by ACPI
[    5.215638] pci 0000:80:03.0: System wakeup disabled by ACPI
[    5.222383] pci 0000:80:03.2: System wakeup disabled by ACPI
[    5.229364] pci 0000:80:01.0: PCI bridge to [bus 81]
[    5.235368] pci 0000:80:02.0: PCI bridge to [bus 82-85]
[    5.241812] pci 0000:82:00.0: PCI bridge to [bus 83-85]
[    5.248133] pci 0000:84:00.0: VF(n) BAR0 space: [mem 0x00000000-0xffffff=
ff 64bit pref] (contains BAR0 for 16 VFs)
[    5.260140] pci 0000:84:00.0: VF(n) BAR2 space: [mem 0x00000000-0x03ffff=
ff 64bit pref] (contains BAR2 for 16 VFs)
[    5.272148] pci 0000:84:00.0: VF(n) BAR5 space: [mem 0x00000000-0x03ffff=
ff] (contains BAR5 for 16 VFs)
[    5.283145] pci 0000:83:08.0: PCI bridge to [bus 84]
[    5.288998] pci 0000:83:08.0: bridge has subordinate 84 but max busn 85
[    5.296871] pci 0000:85:00.0: VF(n) BAR0 space: [mem 0x00000000-0xffffff=
ff 64bit pref] (contains BAR0 for 16 VFs)
[    5.308872] pci 0000:85:00.0: VF(n) BAR2 space: [mem 0x00000000-0x03ffff=
ff 64bit pref] (contains BAR2 for 16 VFs)
[    5.320868] pci 0000:85:00.0: VF(n) BAR5 space: [mem 0x00000000-0x03ffff=
ff] (contains BAR5 for 16 VFs)
[    5.331869] pci 0000:83:10.0: PCI bridge to [bus 85]
[    5.337725] pci 0000:83:10.0: bridge has subordinate 85 but max busn 86
[    5.347380] pci 0000:80:03.0: PCI bridge to [bus 86]
[    5.355187] pci 0000:80:03.2: PCI bridge to [bus 87]
[    5.361107] ACPI: Enabled 2 GPEs in block 00 to 3F
[    5.386318] pci 0000:0a:00.0: vgaarb: setting as boot VGA device
[    5.393332] pci 0000:0a:00.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dio+mem,locks=3Dnone
[    5.403384] pci 0000:84:00.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dnone,locks=3Dnone
[    5.413244] pci 0000:85:00.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dnone,locks=3Dnone
[    5.423105] pci 0000:85:00.0: vgaarb: bridge control possible
[    5.429821] pci 0000:84:00.0: vgaarb: bridge control possible
[    5.436539] pci 0000:0a:00.0: vgaarb: bridge control possible
[    5.443352] vgaarb: loaded
[    5.446701] PCI: Using ACPI for IRQ routing
[    5.457930] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    5.465138] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    5.474134] clocksource: Switched to clocksource hpet
[    5.486401] VFS: Disk quotas dquot_6.6.0
[    5.491118] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    5.499183] pnp: PnP ACPI init
[    5.503218] pnp 00:01: disabling [mem 0xfeda8000-0xfedcbfff] because it =
overlaps 0000:84:00.0 BAR 7 [mem 0x00000000-0xffffffff 64bit pref]
[    5.517639] pnp 00:01: disabling [mem 0xff000000-0xffffffff] because it =
overlaps 0000:84:00.0 BAR 7 [mem 0x00000000-0xffffffff 64bit pref]
[    5.532071] pnp 00:01: disabling [mem 0xfee00000-0xfeefffff] because it =
overlaps 0000:84:00.0 BAR 7 [mem 0x00000000-0xffffffff 64bit pref]
[    5.546502] pnp 00:01: disabling [mem 0xfed12000-0xfed1200f] because it =
overlaps 0000:84:00.0 BAR 7 [mem 0x00000000-0xffffffff 64bit pref]
[    5.560932] pnp 00:01: disabling [mem 0xfed12010-0xfed1201f] because it =
overlaps 0000:84:00.0 BAR 7 [mem 0x00000000-0xffffffff 64bit pref]
[    5.575357] pnp 00:01: disabling [mem 0xfed1b000-0xfed1bfff] because it =
overlaps 0000:84:00.0 BAR 7 [mem 0x00000000-0xffffffff 64bit pref]
[    5.589785] pnp 00:01: disabling [mem 0xfeda8000-0xfedcbfff disabled] be=
cause it overlaps 0000:85:00.0 BAR 7 [mem 0x00000000-0xffffffff 64bit pref]
[    5.605089] pnp 00:01: disabling [mem 0xff000000-0xffffffff disabled] be=
cause it overlaps 0000:85:00.0 BAR 7 [mem 0x00000000-0xffffffff 64bit pref]
[    5.620388] pnp 00:01: disabling [mem 0xfee00000-0xfeefffff disabled] be=
cause it overlaps 0000:85:00.0 BAR 7 [mem 0x00000000-0xffffffff 64bit pref]
[    5.635684] pnp 00:01: disabling [mem 0xfed12000-0xfed1200f disabled] be=
cause it overlaps 0000:85:00.0 BAR 7 [mem 0x00000000-0xffffffff 64bit pref]
[    5.651072] pnp 00:01: disabling [mem 0xfed12010-0xfed1201f disabled] be=
cause it overlaps 0000:85:00.0 BAR 7 [mem 0x00000000-0xffffffff 64bit pref]
[    5.666364] pnp 00:01: disabling [mem 0xfed1b000-0xfed1bfff disabled] be=
cause it overlaps 0000:85:00.0 BAR 7 [mem 0x00000000-0xffffffff 64bit pref]
[    5.681705] system 00:01: [io  0x0500-0x053f] has been reserved
[    5.688626] system 00:01: [io  0x0400-0x047f] has been reserved
[    5.695544] system 00:01: [io  0x0540-0x057f] has been reserved
[    5.702460] system 00:01: [io  0x0600-0x061f] has been reserved
[    5.709372] system 00:01: [io  0x0ca0-0x0ca5] has been reserved
[    5.716284] system 00:01: [io  0x0880-0x0883] has been reserved
[    5.723201] system 00:01: [io  0x0800-0x081f] has been reserved
[    5.730397] system 00:04: [io  0x0ca8] has been reserved
[    5.742054] system 00:04: [io  0x0cac] has been reserved
[    5.748357] pnp: PnP ACPI: found 5 devices
[    5.758826] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    5.769274] pci 0000:03:00.0: can't claim BAR 6 [mem 0xfff00000-0xffffff=
ff pref]: no compatible bridge window
[    5.780882] pci 0000:02:00.0: can't claim BAR 6 [mem 0xfffc0000-0xffffff=
ff pref]: no compatible bridge window
[    5.792489] pci 0000:02:00.1: can't claim BAR 6 [mem 0xfffc0000-0xffffff=
ff pref]: no compatible bridge window
[    5.804184] pci 0000:01:00.0: can't claim BAR 6 [mem 0xfffc0000-0xffffff=
ff pref]: no compatible bridge window
[    5.815792] pci 0000:01:00.1: can't claim BAR 6 [mem 0xfffc0000-0xffffff=
ff pref]: no compatible bridge window
[    5.827397] pci 0000:84:00.0: can't claim BAR 6 [mem 0xfffe0000-0xffffff=
ff pref]: no compatible bridge window
[    5.839001] pci 0000:85:00.0: can't claim BAR 6 [mem 0xfffe0000-0xffffff=
ff pref]: no compatible bridge window
[    5.850607] pci 0000:86:00.0: can't claim BAR 6 [mem 0xfff00000-0xffffff=
ff pref]: no compatible bridge window
[    5.862209] pci 0000:86:00.1: can't claim BAR 6 [mem 0xfff00000-0xffffff=
ff pref]: no compatible bridge window
[    5.873815] pci 0000:87:00.0: can't claim BAR 6 [mem 0xfff00000-0xffffff=
ff pref]: no compatible bridge window
[    5.885424] pci 0000:87:00.1: can't claim BAR 6 [mem 0xfff00000-0xffffff=
ff pref]: no compatible bridge window
[    5.897823] pci 0000:00:03.0: BAR 14: assigned [mem 0x91f00000-0x91fffff=
f]
[    5.905806] pci 0000:00:03.1: BAR 14: assigned [mem 0x92000000-0x920ffff=
f]
[    5.913791] pci 0000:03:00.0: BAR 6: no space for [mem size 0x00100000 p=
ref]
[    5.921976] pci 0000:03:00.0: BAR 6: failed to assign [mem size 0x001000=
00 pref]
[    5.930764] pci 0000:00:01.0: PCI bridge to [bus 03]
[    5.936612] pci 0000:00:01.0:   bridge window [io  0x2000-0x2fff]
[    5.943720] pci 0000:00:01.0:   bridge window [mem 0x91c00000-0x91dfffff]
[    5.951611] pci 0000:00:02.0: PCI bridge to [bus 04]
[    5.957466] pci 0000:02:00.0: BAR 6: assigned [mem 0x91f00000-0x91f3ffff=
 pref]
[    5.966064] pci 0000:02:00.1: BAR 6: assigned [mem 0x91f40000-0x91f7ffff=
 pref]
[    5.974655] pci 0000:00:03.0: PCI bridge to [bus 02]
[    5.980494] pci 0000:00:03.0:   bridge window [mem 0x91f00000-0x91ffffff]
[    5.988379] pci 0000:00:03.0:   bridge window [mem 0x91a00000-0x91afffff=
 64bit pref]
[    5.997558] pci 0000:01:00.0: BAR 6: assigned [mem 0x92000000-0x9203ffff=
 pref]
[    6.006140] pci 0000:01:00.1: BAR 6: assigned [mem 0x92040000-0x9207ffff=
 pref]
[    6.014821] pci 0000:00:03.1: PCI bridge to [bus 01]
[    6.020671] pci 0000:00:03.1:   bridge window [mem 0x92000000-0x920fffff]
[    6.028554] pci 0000:00:03.1:   bridge window [mem 0x91b00000-0x91bfffff=
 64bit pref]
[    6.037735] pci 0000:00:03.2: PCI bridge to [bus 05]
[    6.043586] pci 0000:00:1c.0: PCI bridge to [bus 06]
[    6.049443] pci 0000:09:00.0: PCI bridge to [bus 0a]
[    6.055433] pci 0000:09:00.0:   bridge window [mem 0x91000000-0x918fffff]
[    6.063419] pci 0000:09:00.0:   bridge window [mem 0x90000000-0x90ffffff=
 64bit pref]
[    6.072796] pci 0000:08:00.0: PCI bridge to [bus 09-0a]
[    6.079087] pci 0000:08:00.0:   bridge window [mem 0x91000000-0x918fffff]
[    6.087073] pci 0000:08:00.0:   bridge window [mem 0x90000000-0x90ffffff=
 64bit pref]
[    6.096452] pci 0000:07:00.0: PCI bridge to [bus 08-0b]
[    6.102722] pci 0000:07:00.0:   bridge window [mem 0x91000000-0x919fffff]
[    6.110691] pci 0000:07:00.0:   bridge window [mem 0x90000000-0x90ffffff=
 64bit pref]
[    6.120087] pci 0000:00:1c.7: PCI bridge to [bus 07-0b]
[    6.126321] pci 0000:00:1c.7:   bridge window [mem 0x91000000-0x919fffff]
[    6.134212] pci 0000:00:1c.7:   bridge window [mem 0x90000000-0x90ffffff=
 64bit pref]
[    6.143562] pci 0000:80:03.0: BAR 14: assigned [mem 0xd0400000-0xd05ffff=
f]
[    6.151547] pci 0000:80:03.2: BAR 14: assigned [mem 0xd0600000-0xd07ffff=
f]
[    6.159532] pci 0000:80:01.0: PCI bridge to [bus 81]
[    6.165385] pci 0000:84:00.0: BAR 7: no space for [mem size 0x100000000 =
64bit pref]
[    6.174464] pci 0000:84:00.0: BAR 7: failed to assign [mem size 0x100000=
000 64bit pref]
[    6.183935] pci 0000:84:00.0: BAR 9: no space for [mem size 0x04000000 6=
4bit pref]
[    6.192922] pci 0000:84:00.0: BAR 9: failed to assign [mem size 0x040000=
00 64bit pref]
[    6.202297] pci 0000:84:00.0: BAR 12: no space for [mem size 0x04000000]
[    6.210086] pci 0000:84:00.0: BAR 12: failed to assign [mem size 0x04000=
000]
[    6.218267] pci 0000:84:00.0: BAR 6: assigned [mem 0xd0140000-0xd015ffff=
 pref]
[    6.226856] pci 0000:83:08.0: PCI bridge to [bus 84]
[    6.232707] pci 0000:83:08.0:   bridge window [io  0x9000-0x9fff]
[    6.239816] pci 0000:83:08.0:   bridge window [mem 0xd0100000-0xd01fffff]
[    6.247701] pci 0000:83:08.0:   bridge window [mem 0x3ffe0000000-0x3fff0=
1fffff 64bit pref]
[    6.257458] pci 0000:85:00.0: BAR 7: no space for [mem size 0x100000000 =
64bit pref]
[    6.266534] pci 0000:85:00.0: BAR 7: failed to assign [mem size 0x100000=
000 64bit pref]
[    6.276003] pci 0000:85:00.0: BAR 9: no space for [mem size 0x04000000 6=
4bit pref]
[    6.284984] pci 0000:85:00.0: BAR 9: failed to assign [mem size 0x040000=
00 64bit pref]
[    6.294354] pci 0000:85:00.0: BAR 12: no space for [mem size 0x04000000]
[    6.302144] pci 0000:85:00.0: BAR 12: failed to assign [mem size 0x04000=
000]
[    6.310320] pci 0000:85:00.0: BAR 6: assigned [mem 0xd0040000-0xd005ffff=
 pref]
[    6.318921] pci 0000:83:10.0: PCI bridge to [bus 85]
[    6.324765] pci 0000:83:10.0:   bridge window [io  0x8000-0x8fff]
[    6.331871] pci 0000:83:10.0:   bridge window [mem 0xd0000000-0xd00fffff]
[    6.339759] pci 0000:83:10.0:   bridge window [mem 0x3ffc0000000-0x3ffd0=
1fffff 64bit pref]
[    6.349520] pci 0000:82:00.0: PCI bridge to [bus 83-85]
[    6.355649] pci 0000:82:00.0:   bridge window [io  0x8000-0x9fff]
[    6.362763] pci 0000:82:00.0:   bridge window [mem 0xd0000000-0xd01fffff]
[    6.370648] pci 0000:82:00.0:   bridge window [mem 0x3ffc0000000-0x3fff0=
1fffff 64bit pref]
[    6.380413] pci 0000:80:02.0: PCI bridge to [bus 82-85]
[    6.386549] pci 0000:80:02.0:   bridge window [io  0x8000-0x9fff]
[    6.393659] pci 0000:80:02.0:   bridge window [mem 0xd0000000-0xd02fffff]
[    6.401547] pci 0000:80:02.0:   bridge window [mem 0x3ffc0000000-0x3fff0=
1fffff 64bit pref]
[    6.411311] pci 0000:86:00.0: BAR 6: assigned [mem 0xd0400000-0xd04fffff=
 pref]
[    6.419907] pci 0000:86:00.1: BAR 6: assigned [mem 0xd0500000-0xd05fffff=
 pref]
[    6.428492] pci 0000:80:03.0: PCI bridge to [bus 86]
[    6.434329] pci 0000:80:03.0:   bridge window [mem 0xd0400000-0xd05fffff]
[    6.442211] pci 0000:80:03.0:   bridge window [mem 0xc8000000-0xcbffffff=
 64bit pref]
[    6.451390] pci 0000:87:00.0: BAR 6: assigned [mem 0xd0600000-0xd06fffff=
 pref]
[    6.459987] pci 0000:87:00.1: BAR 6: assigned [mem 0xd0700000-0xd07fffff=
 pref]
[    6.468585] pci 0000:80:03.2: PCI bridge to [bus 87]
[    6.474434] pci 0000:80:03.2:   bridge window [mem 0xd0600000-0xd07fffff]
[    6.482322] pci 0000:80:03.2:   bridge window [mem 0xcc000000-0xcfffffff=
 64bit pref]
[    6.491505] pci_bus 0000:80: Some PCI device resources are unassigned, t=
ry booting with pci=3Drealloc
[    6.502215] NET: Registered protocol family 2
[    6.507858] TCP established hash table entries: 524288 (order: 10, 41943=
04 bytes)
[    6.517388] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    6.525340] TCP: Hash tables configured (established 524288 bind 65536)
[    6.533129] UDP hash table entries: 65536 (order: 9, 2097152 bytes)
[    6.540779] UDP-Lite hash table entries: 65536 (order: 9, 2097152 bytes)
[    6.549037] NET: Registered protocol family 1
[    6.568377] pci 0000:03:00.0: [Firmware Bug]: disabling VPD access (can'=
t determine size of non-standard VPD format)
[    6.581008] pci 0000:0a:00.0: Video device with shadowed ROM at [mem 0x0=
00c0000-0x000dffff]
[    6.943986] Unpacking initramfs...
[    7.455124] Freeing initrd memory: 250500K
[    7.474854] DMAR: dmar0: Using Queued invalidation
[    7.480515] DMAR: dmar1: Using Queued invalidation
[    7.486196] DMAR: Setting RMRR:
[    7.490416] DMAR: Setting identity map for device 0000:00:1a.0 [0x7ae070=
00 - 0x7af06fff]
[    7.500411] DMAR: Setting identity map for device 0000:00:1d.0 [0x7ae070=
00 - 0x7af06fff]
[    7.509975] DMAR: Prepare 0-16MiB unity mapping for LPC
[    7.516596] DMAR: Setting identity map for device 0000:00:1f.0 [0x0 - 0x=
ffffff]
[    7.525294] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    7.532901] iommu: Adding device 0000:00:00.0 to group 0
[    7.539158] iommu: Adding device 0000:00:01.0 to group 1
[    7.545413] iommu: Adding device 0000:00:02.0 to group 2
[    7.551675] iommu: Adding device 0000:00:03.0 to group 3
[    7.557932] iommu: Adding device 0000:00:03.1 to group 4
[    7.564259] iommu: Adding device 0000:00:03.2 to group 5
[    7.570583] iommu: Adding device 0000:00:05.0 to group 6
[    7.576841] iommu: Adding device 0000:00:05.1 to group 6
[    7.583099] iommu: Adding device 0000:00:05.2 to group 6
[    7.589353] iommu: Adding device 0000:00:05.4 to group 6
[    7.595641] iommu: Adding device 0000:00:11.0 to group 7
[    7.601894] iommu: Adding device 0000:00:11.4 to group 7
[    7.608169] iommu: Adding device 0000:00:16.0 to group 8
[    7.614433] iommu: Adding device 0000:00:16.1 to group 8
[    7.620692] iommu: Adding device 0000:00:1a.0 to group 9
[    7.626949] iommu: Adding device 0000:00:1c.0 to group 10
[    7.633299] iommu: Adding device 0000:00:1c.7 to group 11
[    7.639648] iommu: Adding device 0000:00:1d.0 to group 12
[    7.646028] iommu: Adding device 0000:00:1f.0 to group 13
[    7.652380] iommu: Adding device 0000:00:1f.2 to group 13
[    7.658773] iommu: Adding device 0000:01:00.0 to group 14
[    7.670501] iommu: Adding device 0000:01:00.1 to group 14
[    7.676887] iommu: Adding device 0000:02:00.0 to group 15
[    7.683245] iommu: Adding device 0000:02:00.1 to group 15
[    7.689602] iommu: Adding device 0000:03:00.0 to group 16
[    7.695956] iommu: Adding device 0000:07:00.0 to group 17
[    7.702310] iommu: Adding device 0000:08:00.0 to group 18
[    7.708679] iommu: Adding device 0000:09:00.0 to group 18
[    7.715021] iommu: Adding device 0000:0a:00.0 to group 18
[    7.721418] iommu: Adding device 0000:7f:08.0 to group 19
[    7.727776] iommu: Adding device 0000:7f:08.2 to group 19
[    7.734135] iommu: Adding device 0000:7f:08.3 to group 19
[    7.740542] iommu: Adding device 0000:7f:09.0 to group 20
[    7.746900] iommu: Adding device 0000:7f:09.2 to group 20
[    7.753257] iommu: Adding device 0000:7f:09.3 to group 20
[    7.759674] iommu: Adding device 0000:7f:0b.0 to group 21
[    7.766029] iommu: Adding device 0000:7f:0b.1 to group 21
[    7.772387] iommu: Adding device 0000:7f:0b.2 to group 21
[    7.778737] iommu: Adding device 0000:7f:0b.3 to group 21
[    7.785220] iommu: Adding device 0000:7f:0c.0 to group 22
[    7.791580] iommu: Adding device 0000:7f:0c.1 to group 22
[    7.797927] iommu: Adding device 0000:7f:0c.2 to group 22
[    7.804276] iommu: Adding device 0000:7f:0c.3 to group 22
[    7.810633] iommu: Adding device 0000:7f:0c.4 to group 22
[    7.816987] iommu: Adding device 0000:7f:0c.5 to group 22
[    7.823335] iommu: Adding device 0000:7f:0c.6 to group 22
[    7.829694] iommu: Adding device 0000:7f:0c.7 to group 22
[    7.836143] iommu: Adding device 0000:7f:0d.0 to group 23
[    7.842498] iommu: Adding device 0000:7f:0d.1 to group 23
[    7.848850] iommu: Adding device 0000:7f:0d.2 to group 23
[    7.855208] iommu: Adding device 0000:7f:0d.3 to group 23
[    7.861566] iommu: Adding device 0000:7f:0d.4 to group 23
[    7.867919] iommu: Adding device 0000:7f:0d.5 to group 23
[    7.874388] iommu: Adding device 0000:7f:0f.0 to group 24
[    7.880748] iommu: Adding device 0000:7f:0f.1 to group 24
[    7.887106] iommu: Adding device 0000:7f:0f.2 to group 24
[    7.893464] iommu: Adding device 0000:7f:0f.3 to group 24
[    7.899821] iommu: Adding device 0000:7f:0f.4 to group 24
[    7.906266] iommu: Adding device 0000:7f:0f.5 to group 24
[    7.912622] iommu: Adding device 0000:7f:0f.6 to group 24
[    7.919057] iommu: Adding device 0000:7f:10.0 to group 25
[    7.925415] iommu: Adding device 0000:7f:10.1 to group 25
[    7.931771] iommu: Adding device 0000:7f:10.5 to group 25
[    7.938131] iommu: Adding device 0000:7f:10.6 to group 25
[    7.944499] iommu: Adding device 0000:7f:10.7 to group 25
[    7.950948] iommu: Adding device 0000:7f:12.0 to group 26
[    7.957299] iommu: Adding device 0000:7f:12.1 to group 26
[    7.963652] iommu: Adding device 0000:7f:12.2 to group 26
[    7.969999] iommu: Adding device 0000:7f:12.4 to group 26
[    7.976364] iommu: Adding device 0000:7f:12.5 to group 26
[    7.982724] iommu: Adding device 0000:7f:12.6 to group 26
[    7.989182] iommu: Adding device 0000:7f:13.0 to group 27
[    7.995543] iommu: Adding device 0000:7f:13.1 to group 27
[    8.001905] iommu: Adding device 0000:7f:13.2 to group 27
[    8.008266] iommu: Adding device 0000:7f:13.3 to group 27
[    8.014625] iommu: Adding device 0000:7f:13.6 to group 27
[    8.020979] iommu: Adding device 0000:7f:13.7 to group 27
[    8.027463] iommu: Adding device 0000:7f:14.0 to group 28
[    8.033818] iommu: Adding device 0000:7f:14.1 to group 28
[    8.040179] iommu: Adding device 0000:7f:14.2 to group 28
[    8.046537] iommu: Adding device 0000:7f:14.3 to group 28
[    8.052898] iommu: Adding device 0000:7f:14.4 to group 28
[    8.059259] iommu: Adding device 0000:7f:14.5 to group 28
[    8.065613] iommu: Adding device 0000:7f:14.6 to group 28
[    8.071979] iommu: Adding device 0000:7f:14.7 to group 28
[    8.078430] iommu: Adding device 0000:7f:16.0 to group 29
[    8.084791] iommu: Adding device 0000:7f:16.1 to group 29
[    8.091245] iommu: Adding device 0000:7f:16.2 to group 29
[    8.097604] iommu: Adding device 0000:7f:16.3 to group 29
[    8.103960] iommu: Adding device 0000:7f:16.6 to group 29
[    8.110324] iommu: Adding device 0000:7f:16.7 to group 29
[    8.116808] iommu: Adding device 0000:7f:17.0 to group 30
[    8.123167] iommu: Adding device 0000:7f:17.1 to group 30
[    8.129525] iommu: Adding device 0000:7f:17.2 to group 30
[    8.135886] iommu: Adding device 0000:7f:17.3 to group 30
[    8.142245] iommu: Adding device 0000:7f:17.4 to group 30
[    8.148597] iommu: Adding device 0000:7f:17.5 to group 30
[    8.154956] iommu: Adding device 0000:7f:17.6 to group 30
[    8.161322] iommu: Adding device 0000:7f:17.7 to group 30
[    8.167753] iommu: Adding device 0000:7f:1e.0 to group 31
[    8.174114] iommu: Adding device 0000:7f:1e.1 to group 31
[    8.180477] iommu: Adding device 0000:7f:1e.2 to group 31
[    8.186839] iommu: Adding device 0000:7f:1e.3 to group 31
[    8.193198] iommu: Adding device 0000:7f:1e.4 to group 31
[    8.199584] iommu: Adding device 0000:7f:1f.0 to group 32
[    8.205938] iommu: Adding device 0000:7f:1f.2 to group 32
[    8.212288] iommu: Adding device 0000:80:01.0 to group 33
[    8.218643] iommu: Adding device 0000:80:02.0 to group 34
[    8.224995] iommu: Adding device 0000:80:03.0 to group 35
[    8.231348] iommu: Adding device 0000:80:03.2 to group 36
[    8.237767] iommu: Adding device 0000:80:05.0 to group 37
[    8.244125] iommu: Adding device 0000:80:05.1 to group 37
[    8.250483] iommu: Adding device 0000:80:05.2 to group 37
[    8.256843] iommu: Adding device 0000:80:05.4 to group 37
[    8.263195] iommu: Adding device 0000:82:00.0 to group 38
[    8.269548] iommu: Adding device 0000:83:08.0 to group 39
[    8.275900] iommu: Adding device 0000:83:10.0 to group 40
[    8.282256] iommu: Adding device 0000:84:00.0 to group 41
[    8.288609] iommu: Adding device 0000:85:00.0 to group 42
[    8.295019] iommu: Adding device 0000:86:00.0 to group 43
[    8.301403] iommu: Adding device 0000:86:00.1 to group 43
[    8.307817] iommu: Adding device 0000:87:00.0 to group 44
[    8.314204] iommu: Adding device 0000:87:00.1 to group 44
[    8.320606] iommu: Adding device 0000:ff:08.0 to group 45
[    8.326969] iommu: Adding device 0000:ff:08.2 to group 45
[    8.333420] iommu: Adding device 0000:ff:08.3 to group 45
[    8.339820] iommu: Adding device 0000:ff:09.0 to group 46
[    8.346171] iommu: Adding device 0000:ff:09.2 to group 46
[    8.352536] iommu: Adding device 0000:ff:09.3 to group 46
[    8.358951] iommu: Adding device 0000:ff:0b.0 to group 47
[    8.365313] iommu: Adding device 0000:ff:0b.1 to group 47
[    8.371675] iommu: Adding device 0000:ff:0b.2 to group 47
[    8.378037] iommu: Adding device 0000:ff:0b.3 to group 47
[    8.384521] iommu: Adding device 0000:ff:0c.0 to group 48
[    8.390880] iommu: Adding device 0000:ff:0c.1 to group 48
[    8.397240] iommu: Adding device 0000:ff:0c.2 to group 48
[    8.403608] iommu: Adding device 0000:ff:0c.3 to group 48
[    8.409970] iommu: Adding device 0000:ff:0c.4 to group 48
[    8.416332] iommu: Adding device 0000:ff:0c.5 to group 48
[    8.422688] iommu: Adding device 0000:ff:0c.6 to group 48
[    8.429038] iommu: Adding device 0000:ff:0c.7 to group 48
[    8.435488] iommu: Adding device 0000:ff:0d.0 to group 49
[    8.441853] iommu: Adding device 0000:ff:0d.1 to group 49
[    8.448214] iommu: Adding device 0000:ff:0d.2 to group 49
[    8.454578] iommu: Adding device 0000:ff:0d.3 to group 49
[    8.460937] iommu: Adding device 0000:ff:0d.4 to group 49
[    8.467298] iommu: Adding device 0000:ff:0d.5 to group 49
[    8.473761] iommu: Adding device 0000:ff:0f.0 to group 50
[    8.480126] iommu: Adding device 0000:ff:0f.1 to group 50
[    8.486489] iommu: Adding device 0000:ff:0f.2 to group 50
[    8.492851] iommu: Adding device 0000:ff:0f.3 to group 50
[    8.499212] iommu: Adding device 0000:ff:0f.4 to group 50
[    8.505575] iommu: Adding device 0000:ff:0f.5 to group 50
[    8.511939] iommu: Adding device 0000:ff:0f.6 to group 50
[    8.518460] iommu: Adding device 0000:ff:10.0 to group 51
[    8.524822] iommu: Adding device 0000:ff:10.1 to group 51
[    8.531186] iommu: Adding device 0000:ff:10.5 to group 51
[    8.537549] iommu: Adding device 0000:ff:10.6 to group 51
[    8.543912] iommu: Adding device 0000:ff:10.7 to group 51
[    8.550361] iommu: Adding device 0000:ff:12.0 to group 52
[    8.556724] iommu: Adding device 0000:ff:12.1 to group 52
[    8.563087] iommu: Adding device 0000:ff:12.2 to group 52
[    8.569456] iommu: Adding device 0000:ff:12.4 to group 52
[    8.575816] iommu: Adding device 0000:ff:12.5 to group 52
[    8.582178] iommu: Adding device 0000:ff:12.6 to group 52
[    8.588631] iommu: Adding device 0000:ff:13.0 to group 53
[    8.594998] iommu: Adding device 0000:ff:13.1 to group 53
[    8.601371] iommu: Adding device 0000:ff:13.2 to group 53
[    8.607737] iommu: Adding device 0000:ff:13.3 to group 53
[    8.614104] iommu: Adding device 0000:ff:13.6 to group 53
[    8.620464] iommu: Adding device 0000:ff:13.7 to group 53
[    8.626948] iommu: Adding device 0000:ff:14.0 to group 54
[    8.633308] iommu: Adding device 0000:ff:14.1 to group 54
[    8.639673] iommu: Adding device 0000:ff:14.2 to group 54
[    8.646036] iommu: Adding device 0000:ff:14.3 to group 54
[    8.652401] iommu: Adding device 0000:ff:14.4 to group 54
[    8.658766] iommu: Adding device 0000:ff:14.5 to group 54
[    8.665131] iommu: Adding device 0000:ff:14.6 to group 54
[    8.671499] iommu: Adding device 0000:ff:14.7 to group 54
[    8.677947] iommu: Adding device 0000:ff:16.0 to group 55
[    8.684312] iommu: Adding device 0000:ff:16.1 to group 55
[    8.690677] iommu: Adding device 0000:ff:16.2 to group 55
[    8.697044] iommu: Adding device 0000:ff:16.3 to group 55
[    8.703503] iommu: Adding device 0000:ff:16.6 to group 55
[    8.709870] iommu: Adding device 0000:ff:16.7 to group 55
[    8.716348] iommu: Adding device 0000:ff:17.0 to group 56
[    8.722714] iommu: Adding device 0000:ff:17.1 to group 56
[    8.729071] iommu: Adding device 0000:ff:17.2 to group 56
[    8.735438] iommu: Adding device 0000:ff:17.3 to group 56
[    8.741804] iommu: Adding device 0000:ff:17.4 to group 56
[    8.748172] iommu: Adding device 0000:ff:17.5 to group 56
[    8.754537] iommu: Adding device 0000:ff:17.6 to group 56
[    8.760897] iommu: Adding device 0000:ff:17.7 to group 56
[    8.767326] iommu: Adding device 0000:ff:1e.0 to group 57
[    8.773694] iommu: Adding device 0000:ff:1e.1 to group 57
[    8.780049] iommu: Adding device 0000:ff:1e.2 to group 57
[    8.786416] iommu: Adding device 0000:ff:1e.3 to group 57
[    8.792779] iommu: Adding device 0000:ff:1e.4 to group 57
[    8.799161] iommu: Adding device 0000:ff:1f.0 to group 58
[    8.805517] iommu: Adding device 0000:ff:1f.2 to group 58
[    8.812969] Intel CQM monitoring enabled
[    8.823076] Intel MBM enabled
[    8.827696] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360=
 ms ovfl timer
[    8.837077] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    8.843790] RAPL PMU: hw unit of domain package 2^-14 Joules
[    8.850416] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    8.856751] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    8.866732] audit: initializing netlink subsys (disabled)
[    8.873651] Initialise system trusted keyrings
[    8.879120] workingset: timestamp_bits=3D39 max_order=3D26 bucket_order=
=3D0
[    9.123300] Key type asymmetric registered
[    9.128162] Asymmetric key parser 'x509' registered
[    9.133950] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 251)
[    9.142828] io scheduler noop registered
[    9.147503] io scheduler deadline registered
[    9.152569] io scheduler cfq registered (default)
[    9.162749] pcieport 0000:00:01.0: Signaling PME with IRQ 26
[    9.169377] pcieport 0000:00:02.0: Signaling PME with IRQ 27
[    9.176007] pcieport 0000:00:03.0: Signaling PME with IRQ 28
[    9.182651] pcieport 0000:00:03.1: Signaling PME with IRQ 29
[    9.189276] pcieport 0000:00:03.2: Signaling PME with IRQ 30
[    9.195908] pcieport 0000:00:1c.0: Signaling PME with IRQ 31
[    9.202533] pcieport 0000:00:1c.7: Signaling PME with IRQ 32
[    9.209163] pcieport 0000:80:01.0: Signaling PME with IRQ 33
[    9.215789] pcieport 0000:80:02.0: Signaling PME with IRQ 34
[    9.222420] pcieport 0000:80:03.0: Signaling PME with IRQ 35
[    9.229048] pcieport 0000:80:03.2: Signaling PME with IRQ 36
[    9.238657] ERST: Error Record Serialization Table (ERST) support is ini=
tialized.
[    9.247541] pstore: using zlib compression
[    9.252419] pstore: Registered erst as persistent store backend
[    9.259791] GHES: APEI firmware first mode is enabled by APEI bit and WH=
EA _OSC.
[    9.268635] ioatdma: Intel(R) QuickData Technology Driver 4.00
[    9.275553] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    9.303434] 00:02: ttyS1 at I/O 0x2f8 (irq =3D 3, base_baud =3D 115200) =
is a 16550A
[    9.332718] 00:03: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200) =
is a 16550A
[    9.344763] i8042: PNP: No PS/2 controller found.
[    9.350366] rtc_cmos 00:00: RTC can wake from S4
[    9.355965] rtc_cmos 00:00: rtc core: registered rtc_cmos as rtc0
[    9.363104] rtc_cmos 00:00: alarms up to one month, y3k, 114 bytes nvram=
, hpet irqs
[    9.372179] intel_pstate: Intel P-state driver initializing
[    9.381902] NET: Registered protocol family 10
[    9.387656] Segment Routing with IPv6
[    9.392096] NET: Registered protocol family 17
[    9.397367] Key type dns_resolver registered
[    9.407367] microcode: sig=3D0x406f1, pf=3D0x1, revision=3D0xb00001e
[    9.415773] microcode: Microcode Update Driver: v2.2.
[    9.415868] registered taskstats version 1
[    9.426727] Loading compiled-in X.509 certificates
[    9.433937] alg: No test for pkcs1pad(rsa,sha256) (pkcs1pad(rsa-generic,=
sha256))
[    9.443357] Loaded X.509 cert 'CoreOS, Inc: Module signing key for 4.10.=
9-coreos: 39ee6a81d3dc03a08f20755d4ed06ad3688c9fa2'
[    9.456372] ima: No TPM chip found, activating TPM-bypass! (rc=3D-19)
[    9.466080] rtc_cmos 00:00: setting system clock to 2017-04-13 13:56:54 =
UTC (1492091814)
[    9.485870] Freeing unused kernel memory: 31644K
[    9.491331] Write protecting the kernel read-only data: 10240k
[    9.498411] Freeing unused kernel memory: 28K
[    9.506500] Freeing unused kernel memory: 1584K
[    9.514539] Unable to open file: /etc/ima/ima-policy (-2)
[    9.514543] IMA: policy update failed
[    9.527036] systemd[1]: Failed to insert module 'ip_tables': Function no=
t implemented
[    9.578238] random: systemd: uninitialized urandom read (16 bytes read)
[    9.586259] random: systemd: uninitialized urandom read (16 bytes read)
[    9.593967] random: systemd: uninitialized urandom read (16 bytes read)
[    9.606487] systemd[1]: systemd 233 running in system mode. (+PAM +AUDIT=
 +SELINUX +IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT -GNU=
TLS -ACL +XZ -LZ4 +SECCOMP +BLKID -ELFUTILS +KMOD -IDN default-hierarchy=3D=
legacy)
[    9.630449] systemd[1]: Detected architecture x86-64.
[    9.636400] systemd[1]: Running in initial RAM disk.
[    9.643415] systemd[1]: No hostname configured.
[    9.648785] systemd[1]: Set hostname to <localhost>.
[    9.654659] random: systemd: uninitialized urandom read (16 bytes read)
[    9.662363] systemd[1]: Initializing machine ID from random generator.
[    9.672451] random: systemd: uninitialized urandom read (16 bytes read)
[    9.681063] random: systemd: uninitialized urandom read (16 bytes read)
[    9.682466] random: systemd-cryptse: uninitialized urandom read (16 byte=
s read)
[    9.700606] random: systemd: uninitialized urandom read (16 bytes read)
[    9.708329] random: systemd: uninitialized urandom read (16 bytes read)
[    9.716045] random: systemd: uninitialized urandom read (16 bytes read)
[    9.728229] systemd[1]: Listening on Journal Socket.
[    9.734899] systemd[1]: Listening on udev Kernel Socket.
[    9.741927] systemd[1]: Listening on Network Service Netlink Socket.
[    9.750095] systemd[1]: Reached target Timers.
[    9.820429] device-mapper: uevent: version 1.0.3
[    9.825962] device-mapper: ioctl: 4.35.0-ioctl (2016-06-23) initialised:=
 dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
[    9.913466] tsc: Refined TSC clocksource calibration: 2599.996 MHz
[    9.920699] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x257=
a386c905, max_idle_ns: 440795250529 ns
[    9.968419] pps_core: LinuxPPS API ver. 1 registered
[    9.968420] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti-k2GhghHVRtY@public.gmane.org>
[    9.968645] SCSI subsystem initialized
[    9.990525] PTP clock support registered
[    9.995405] ACPI: bus type USB registered
[    9.995425] usbcore: registered new interface driver usbfs
[    9.995434] usbcore: registered new interface driver hub
[    9.995625] usbcore: registered new device driver usb
[   10.019491] megasas: 06.812.07.00-rc1
[   10.020961] megaraid_sas 0000:03:00.0: FW now in Ready state
[   10.021503] megaraid_sas 0000:03:00.0: firmware supports msix	: (96)
[   10.021504] megaraid_sas 0000:03:00.0: current msix/online cpus	: (56/56)
[   10.021505] megaraid_sas 0000:03:00.0: RDPQ mode	: (disabled)
[   10.021507] megaraid_sas 0000:03:00.0: Current firmware maximum commands=
: 928	 LDIO threshold: 0
[   10.022455] megaraid_sas 0000:03:00.0: FW supports sync cache	: No
[   10.043511] megaraid_sas 0000:03:00.0: Init cmd success
[   10.066508] megaraid_sas 0000:03:00.0: firmware type	: Extended VD(240 V=
D)firmware
[   10.066509] megaraid_sas 0000:03:00.0: controller type	: MR(1024MB)
[   10.066510] megaraid_sas 0000:03:00.0: Online Controller Reset(OCR)	: En=
abled
[   10.066511] megaraid_sas 0000:03:00.0: Secure JBOD support	: No
[   10.088900] megaraid_sas 0000:03:00.0: INIT adapter done
[   10.088901] megaraid_sas 0000:03:00.0: Jbod map is not supported megasas=
_setup_jbod_map 4947
[   10.105528] megaraid_sas 0000:03:00.0: pci id		: (0x1000)/(0x005d)/(0x10=
28)/(0x1f49)
[   10.105529] megaraid_sas 0000:03:00.0: unevenspan support	: yes
[   10.105530] megaraid_sas 0000:03:00.0: firmware crash dump	: no
[   10.105530] megaraid_sas 0000:03:00.0: jbod sync map		: no
[   10.105532] scsi host0: Avago SAS based MegaRAID driver
[   10.106641] scsi 0:0:0:0: Direct-Access     ATA      INTEL SSDSC2BX80 DL=
2B PQ: 0 ANSI: 6
[   10.170508] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   10.172739] mlx5_core 0000:86:00.0: firmware version: 12.16.1020
[   10.172905] ehci-pci: EHCI PCI platform driver
[   10.173153] ehci-pci 0000:00:1a.0: EHCI Host Controller
[   10.173159] ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus =
number 1
[   10.173184] ehci-pci 0000:00:1a.0: debug port 2
[   10.174712] AVX2 version of gcm_enc/dec engaged.
[   10.174713] AES CTR mode by8 optimization enabled
[   10.176483] tg3.c:v3.137 (May 11, 2014)
[   10.177123] ehci-pci 0000:00:1a.0: irq 18, io mem 0x91e03000
[   10.184494] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[   10.185461] hub 1-0:1.0: USB hub found
[   10.185468] hub 1-0:1.0: 2 ports detected
[   10.185765] ehci-pci 0000:00:1d.0: EHCI Host Controller
[   10.185770] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus =
number 2
[   10.185793] ehci-pci 0000:00:1d.0: debug port 2
[   10.189720] ehci-pci 0000:00:1d.0: irq 18, io mem 0x91e02000
[   10.190400] tg3 0000:01:00.0 eth0: Tigon3 [partno(BCM95720) rev 5720000]=
 (PCI Express) MAC address 18:66:da:f0:43:18
[   10.190402] tg3 0000:01:00.0 eth0: attached PHY is 5720C (10/100/1000Bas=
e-T Ethernet) (WireSpeed[1], EEE[1])
[   10.190403] tg3 0000:01:00.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF=
[1] TSOcap[1]
[   10.190404] tg3 0000:01:00.0 eth0: dma_rwctrl[00000001] dma_mask[64-bit]
[   10.196536] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[   10.196776] hub 2-0:1.0: USB hub found
[   10.196782] hub 2-0:1.0: 2 ports detected
[   10.197085] ahci 0000:00:11.4: SSS flag set, parallel bus scan disabled
[   10.197138] ahci 0000:00:11.4: AHCI 0001.0300 32 slots 4 ports 6 Gbps 0x=
f impl SATA mode
[   10.197139] ahci 0000:00:11.4: flags: 64bit ncq stag led clo pio slum pa=
rt ems apst=20
[   10.202985] tg3 0000:01:00.1 eth1: Tigon3 [partno(BCM95720) rev 5720000]=
 (PCI Express) MAC address 18:66:da:f0:43:19
[   10.202986] tg3 0000:01:00.1 eth1: attached PHY is 5720C (10/100/1000Bas=
e-T Ethernet) (WireSpeed[1], EEE[1])
[   10.202987] tg3 0000:01:00.1 eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF=
[1] TSOcap[1]
[   10.202988] tg3 0000:01:00.1 eth1: dma_rwctrl[00000001] dma_mask[64-bit]
[   10.207765] scsi host1: ahci
[   10.207872] scsi host2: ahci
[   10.207957] scsi host3: ahci
[   10.208082] scsi host4: ahci
[   10.208107] ata1: SATA max UDMA/133 abar m2048@0x91e01000 port 0x91e0110=
0 irq 103
[   10.208108] ata2: SATA max UDMA/133 abar m2048@0x91e01000 port 0x91e0118=
0 irq 103
[   10.208111] ata3: SATA max UDMA/133 abar m2048@0x91e01000 port 0x91e0120=
0 irq 103
[   10.208112] ata4: SATA max UDMA/133 abar m2048@0x91e01000 port 0x91e0128=
0 irq 103
[   10.208257] ahci 0000:00:1f.2: SSS flag set, parallel bus scan disabled
[   10.208320] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x=
3f impl SATA mode
[   10.208321] ahci 0000:00:1f.2: flags: 64bit ncq stag led clo pio slum pa=
rt ems apst=20
[   10.214928] tg3 0000:02:00.0 eth2: Tigon3 [partno(BCM95720) rev 5720000]=
 (PCI Express) MAC address 18:66:da:f0:43:1a
[   10.214930] tg3 0000:02:00.0 eth2: attached PHY is 5720C (10/100/1000Bas=
e-T Ethernet) (WireSpeed[1], EEE[1])
[   10.214931] tg3 0000:02:00.0 eth2: RXcsums[1] LinkChgREG[0] MIirq[0] ASF=
[1] TSOcap[1]
[   10.214932] tg3 0000:02:00.0 eth2: dma_rwctrl[00000001] dma_mask[64-bit]
[   10.226951] tg3 0000:02:00.1 eth3: Tigon3 [partno(BCM95720) rev 5720000]=
 (PCI Express) MAC address 18:66:da:f0:43:1b
[   10.226952] tg3 0000:02:00.1 eth3: attached PHY is 5720C (10/100/1000Bas=
e-T Ethernet) (WireSpeed[1], EEE[1])
[   10.226953] tg3 0000:02:00.1 eth3: RXcsums[1] LinkChgREG[0] MIirq[0] ASF=
[1] TSOcap[1]
[   10.226954] tg3 0000:02:00.1 eth3: dma_rwctrl[00000001] dma_mask[64-bit]
[   10.227032] scsi host5: ahci
[   10.227173] scsi host6: ahci
[   10.227277] scsi host7: ahci
[   10.227355] scsi host8: ahci
[   10.228085] scsi host9: ahci
[   10.228197] scsi host10: ahci
[   10.228245] ata5: SATA max UDMA/133 abar m2048@0x91e00000 port 0x91e0010=
0 irq 105
[   10.228247] ata6: SATA max UDMA/133 abar m2048@0x91e00000 port 0x91e0018=
0 irq 105
[   10.228250] ata7: SATA max UDMA/133 abar m2048@0x91e00000 port 0x91e0020=
0 irq 105
[   10.228253] ata8: SATA max UDMA/133 abar m2048@0x91e00000 port 0x91e0028=
0 irq 105
[   10.228255] ata9: SATA max UDMA/133 abar m2048@0x91e00000 port 0x91e0030=
0 irq 105
[   10.228258] ata10: SATA max UDMA/133 abar m2048@0x91e00000 port 0x91e003=
80 irq 105
[   10.374945] IPv6: ADDRCONF(NETDEV_UP): eth3: link is not ready
[   10.497549] usb 1-1: new high-speed USB device number 2 using ehci-pci
[   10.505546] usb 2-1: new high-speed USB device number 2 using ehci-pci
[   10.519173] ata1: SATA link down (SStatus 0 SControl 300)
[   10.535394] ata5: SATA link down (SStatus 0 SControl 300)
[   10.557581] IPv6: ADDRCONF(NETDEV_UP): eth2: link is not ready
[   10.616089] hub 1-1:1.0: USB hub found
[   10.616199] hub 1-1:1.0: 6 ports detected
[   10.624089] hub 2-1:1.0: USB hub found
[   10.624213] hub 2-1:1.0: 8 ports detected
[   10.681099] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
[   10.756505] mlx5_core 0000:86:00.0: Port module event: module 0, Cable p=
lugged
[   10.776389] mlx5_core 0000:86:00.1: firmware version: 12.16.1020
[   10.806137] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   10.889537] usb 1-1.6: new high-speed USB device number 3 using ehci-pci
[   10.898883] random: fast init done
[   10.921642] clocksource: Switched to clocksource tsc
[   10.976738] hub 1-1.6:1.0: USB hub found
[   10.981684] hub 1-1.6:1.0: 6 ports detected
[   11.239379] ata2: SATA link down (SStatus 0 SControl 300)
[   11.357001] mlx5_core 0000:86:00.1: Port module event: module 1, Cable u=
nplugged
[   11.376803] mlx5_core 0000:87:00.0: firmware version: 12.16.1020
[   11.559475] ata3: SATA link down (SStatus 0 SControl 300)
[   11.879481] ata4: SATA link down (SStatus 0 SControl 300)
[   11.976236] mlx5_core 0000:87:00.0: Port module event: module 0, Cable u=
nplugged
[   11.996405] mlx5_core 0000:87:00.1: firmware version: 12.16.1020
[   12.191569] ata6: SATA link down (SStatus 0 SControl 300)
[   12.503456] ata7: SATA link down (SStatus 0 SControl 300)
[   12.580063] mlx5_core 0000:87:00.1: Port module event: module 1, Cable u=
nplugged
[   12.815340] ata8: SATA link down (SStatus 0 SControl 300)
[   13.127582] ata9: SATA link down (SStatus 0 SControl 300)
[   13.439558] ata10: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   13.450382] ata10.00: ATAPI: PLDS DVD+/-RW DS-8ABSH, LD51, max UDMA/133
[   13.461507] ata10.00: configured for UDMA/133
[   13.475505] scsi 10:0:0:0: CD-ROM            PLDS     DVD+-RW DS-8ABSH L=
D51 PQ: 0 ANSI: 5
[   13.509199] sd 0:0:0:0: [sda] 1562824368 512-byte logical blocks: (800 G=
B/745 GiB)
[   13.518261] sd 0:0:0:0: [sda] 4096-byte physical blocks
[   13.525172] sd 0:0:0:0: [sda] Write Protect is off
[   13.529121] sr 10:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer dvd-ram c=
d/rw xa/form2 cdda tray
[   13.529122] cdrom: Uniform CD-ROM driver Revision: 3.20
[   13.548025] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 supports DPO and FUA
[   13.564593]  sda: sda1 sda2 sda3 sda4 sda6 sda7 sda9
[   13.575765] sd 0:0:0:0: [sda] Attached SCSI disk
[   14.139480] tg3 0000:01:00.1 eth1: Link is up at 1000 Mbps, full duplex
[   14.147165] tg3 0000:01:00.1 eth1: Flow control is off for TX and off fo=
r RX
[   14.155330] tg3 0000:01:00.1 eth1: EEE is enabled
[   14.160888] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
[   14.362477] tg3 0000:01:00.0 eth0: Link is up at 1000 Mbps, full duplex
[   14.370162] tg3 0000:01:00.0 eth0: Flow control is on for TX and on for =
RX
[   14.378137] tg3 0000:01:00.0 eth0: EEE is disabled
[   14.383796] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   16.157042] loop: module loaded
[   16.194807] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[   16.842691] systemd-journald[457]: Received SIGTERM from PID 1 (systemd).
[   16.854054] systemd: 21 output lines suppressed due to ratelimiting
[   16.927907] SELinux:  Permission validate_trans in class security not de=
fined in policy.
[   16.937464] SELinux:  Permission module_load in class system not defined=
 in policy.
[   16.946592] SELinux:  Class cap_userns not defined in policy.
[   16.953305] SELinux:  Class cap2_userns not defined in policy.
[   16.960111] SELinux: the above unknown classes and permissions will be a=
llowed
[   16.981511] systemd[1]: Successfully loaded SELinux policy in 71.716ms.
[   16.989218] Unable to open file: /etc/ima/ima-policy (-2)
[   16.989223] IMA: policy update failed
[   17.006568] ip_tables: (C) 2000-2006 Netfilter Core Team
[   17.018131] systemd[1]: Relabelled /dev and /run in 4.907ms.
[   17.148358] mlx5_ib: Mellanox Connect-IB Infiniband driver v2.2-1 (Feb 2=
014)
[   17.167605] systemd-journald[1578]: Received request to flush runtime jo=
urnal from PID 1
[   17.301264] random: crng init done
[   17.336131] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input0
[   17.344922] ACPI: Power Button [PWRF]
[   17.385710] tg3 0000:02:00.1 eno4: renamed from eth3
[   17.408168] tg3 0000:01:00.1 eno2: renamed from eth1
[   17.423282] tg3 0000:01:00.0 eno1: renamed from eth0
[   17.425170] ipmi message handler version 39.2
[   17.436730] ipmi device interface
[   17.438544] dcdbas dcdbas: Dell Systems Management Base Driver (version =
5.6.0-3.2)
[   17.439843] IPMI System Interface driver.
[   17.439889] ipmi_si: probing via SMBIOS
[   17.439890] ipmi_si: SMBIOS: io 0xca8 regsize 1 spacing 4 irq 10
[   17.439890] ipmi_si: Adding SMBIOS-specified kcs state machine
[   17.439893] ipmi_si: Trying SMBIOS-specified kcs state machine at i/o ad=
dress 0xca8, slave address 0x20, irq 10
[   17.441390] mei_me 0000:00:16.0: Device doesn't have valid ME Interface
[   17.451839] [drm] Initialized
[   17.452179] tg3 0000:02:00.0 eno3: renamed from eth2
[   17.550032] ipmi_si ipmi_si.0: The BMC does not support setting the recv=
 irq bit, compensating, but the BMC needs to be fixed.
[   17.563935] EDAC MC: Ver: 3.0.0
[   17.571234] EDAC MC0: Giving out device to module sbridge_edac.c control=
ler Broadwell Socket#0: DEV 0000:7f:12.0 (INTERRUPT)
[   17.583118] ipmi_si ipmi_si.0: Using irq 10
[   17.589379] EDAC MC1: Giving out device to module sbridge_edac.c control=
ler Broadwell Socket#1: DEV 0000:ff:12.0 (INTERRUPT)
[   17.602455] EDAC sbridge:  Ver: 1.1.1=20
[   17.607653] [drm] amdgpu kernel modesetting enabled.
[   17.617246] AMD IOMMUv2 driver by Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
[   17.622287] ipmi_si ipmi_si.0: Found new BMC (man_id: 0x0002a2, prod_id:=
 0x0100, dev_id: 0x20)
[   17.622327] ipmi_si ipmi_si.0: IPMI kcs interface initialized
[   17.641259] AMD IOMMUv2 functionality not available on this system
[   17.648684] IPMI SSIF Interface driver
[   17.678471] CRAT table not found
[   17.682378] Finished initializing topology ret=3D0
[   17.687915] kfd kfd: Initialized module
[   17.692746] amdgpu 0000:84:00.0: enabling device (0000 -> 0003)
[   17.692940] [drm] initializing kernel modesetting (TONGA 0x1002:0x6929 0=
x1002:0x0334 0x00).
[   17.692963] [drm] register mmio base: 0xD0100000
[   17.692964] [drm] register mmio size: 262144
[   17.692970] [drm] doorbell mmio base: 0xF0000000
[   17.692971] [drm] doorbell mmio size: 2097152
[   17.692980] [drm] probing gen 2 caps for device 10b5:8747 =3D 8796103/10e
[   17.692981] [drm] probing mlw for device 10b5:8747 =3D 8796103
[   17.692992] [drm] VCE enabled in physical mode
[   18.648132] ATOM BIOS: C76301
[   18.651758] [drm] GPU posting now...
[   23.661513] [drm:amdgpu_connector_add [amdgpu]] *ERROR* atombios stuck i=
n loop for more than 5secs aborting
[   23.673155] [drm:amdgpu_connector_add [amdgpu]] *ERROR* atombios stuck e=
xecuting F250 (len 334, WS 4, PS 0) @ 0xF365
[   23.685453] [drm:amdgpu_connector_add [amdgpu]] *ERROR* atombios stuck e=
xecuting DB34 (len 324, WS 4, PS 0) @ 0xDC2C
[   23.697816] [drm:amdgpu_connector_add [amdgpu]] *ERROR* atombios stuck e=
xecuting BCDE (len 254, WS 0, PS 4) @ 0xBDB4
[   23.710137] [drm:amdgpu_connector_add [amdgpu]] *ERROR* atombios stuck e=
xecuting B832 (len 143, WS 0, PS 8) @ 0xB8A9
[   23.722451] amdgpu 0000:84:00.0: gpu post error!
[   23.727950] amdgpu 0000:84:00.0: Fatal error during GPU init
[   23.734594] [drm] amdgpu: finishing device.
[   23.739592] ------------[ cut here ]------------
[   23.745068] WARNING: CPU: 12 PID: 1725 at ../source/drivers/gpu/drm/drm_=
modeset_lock.c:345 drm_modeset_lock+0xe4/0xf0 [drm]
[   23.758047] Modules linked in: sch_fq_codel amdkfd ipmi_ssif amd_iommu_v=
2 coretemp amdgpu(+) sb_edac edac_core ib_ipoib i2c_algo_bit x86_pkg_temp_t=
hermal drm_kms_helper ttm kvm_intel drm kvm i2c_core syscopyarea mei_me sys=
fillrect ipmi_si sysimgblt fb_sys_fops dcdbas ipmi_devintf irqbypass ib_cm =
backlight evdev mei ipmi_msghandler button mlx5_ib ib_core ip_tables squash=
fs loop sr_mod cdrom sd_mod crc32c_intel ahci aesni_intel libahci tg3 ehci_=
pci aes_x86_64 crypto_simd ehci_hcd mlx5_core hwmon libata megaraid_sas cry=
ptd glue_helper usbcore ptp pps_core scsi_mod usb_common libphy dm_mirror d=
m_region_hash dm_log dm_mod autofs4
[   23.821876] CPU: 12 PID: 1725 Comm: systemd-udevd Not tainted 4.10.9-cor=
eos #1
[   23.830458] Hardware name: Dell Inc. PowerEdge R730/0WCJNT, BIOS 2.2.5 0=
9/06/2016
[   23.839376] Call Trace:
[   23.842415]  dump_stack+0x63/0x90
[   23.846423]  __warn+0xd1/0xf0
[   23.850039]  warn_slowpath_null+0x1d/0x20
[   23.854808]  drm_modeset_lock+0xe4/0xf0 [drm]
[   23.859970]  drm_modeset_lock_all_ctx+0x22/0xb0 [drm]
[   23.865901]  drm_modeset_lock_all+0x60/0xe0 [drm]
[   23.871447]  drm_crtc_force_disable_all+0x21/0x80 [drm]
[   23.877602]  amdgpu_device_fini+0x2d/0x160 [amdgpu]
[   23.883379]  amdgpu_driver_unload_kms+0x44/0x80 [amdgpu]
[   23.889627]  amdgpu_driver_load_kms+0xf9/0x1b0 [amdgpu]
[   23.895798]  drm_dev_register+0x134/0x170 [drm]
[   23.901167]  drm_get_pci_dev+0x9a/0x1d0 [drm]
[   23.906327]  amdgpu_drm_ioctl+0x469/0x16f0 [amdgpu]
[   23.912083]  local_pci_probe+0x45/0xa0
[   23.916562]  pci_device_probe+0xff/0x140
[   23.921250]  driver_probe_device+0x2c5/0x470
[   23.926316]  __driver_attach+0xdf/0xf0
[   23.930811]  ? driver_probe_device+0x470/0x470
[   23.936066]  bus_for_each_dev+0x6c/0xc0
[   23.940637]  driver_attach+0x1e/0x20
[   23.944949]  bus_add_driver+0x45/0x270
[   23.949423]  ? 0xffffffffc06d8000
[   23.953428]  driver_register+0x60/0xe0
[   23.957925]  ? 0xffffffffc06d8000
[   23.961913]  __pci_register_driver+0x4c/0x50
[   23.966972]  drm_pci_init+0xed/0x100 [drm]
[   23.971834]  ? 0xffffffffc06d8000
[   23.975832]  init_module+0x92/0x1000 [amdgpu]
[   23.980985]  do_one_initcall+0x53/0x1b0
[   23.985557]  ? __vunmap+0x81/0xd0
[   23.989571]  ? kmem_cache_alloc_trace+0xdb/0x1b0
[   23.995031]  ? kfree+0x161/0x170
[   23.998922]  do_init_module+0x60/0x1fa
[   24.003398]  load_module+0x2329/0x27d0
[   24.007886]  ? __symbol_put+0x60/0x60
[   24.012264]  ? ima_post_read_file+0x74/0x90
[   24.017236]  SYSC_finit_module+0xa6/0xf0
[   24.021921]  SyS_finit_module+0xe/0x10
[   24.026396]  do_syscall_64+0x5a/0x160
[   24.030810]  entry_SYSCALL64_slow_path+0x25/0x25
[   24.041923] RIP: 0033:0x7f8eedab75e9
[   24.046205] RSP: 002b:00007ffc9814b048 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000139
[   24.055182] RAX: ffffffffffffffda RBX: 000055bf95cb1aa0 RCX: 00007f8eeda=
b75e9
[   24.063446] RDX: 0000000000000000 RSI: 00007f8eee3d618b RDI: 00000000000=
00017
[   24.071729] RBP: 00007ffc9814b0a0 R08: 0000000000000000 R09: 00000000000=
00000
[   24.080028] R10: 0000000000000017 R11: 0000000000000246 R12: 00007f8eee3=
d618b
[   24.088297] R13: 0000000000000000 R14: 000055bf95cb23f0 R15: 00000000000=
20000
[   24.096608] ---[ end trace 88c8cb35b32e3b88 ]---
[   24.102086] BUG: unable to handle kernel NULL pointer dereference at 000=
0000000000018
[   24.111438] IP: __ww_mutex_lock+0x24/0xa0
[   24.116222] PGD 0=20
[   24.116223]=20
[   24.120737] Oops: 0002 [#1] SMP
[   24.124547] Modules linked in: sch_fq_codel amdkfd ipmi_ssif amd_iommu_v=
2 coretemp amdgpu(+) sb_edac edac_core ib_ipoib i2c_algo_bit x86_pkg_temp_t=
hermal drm_kms_helper ttm kvm_intel drm kvm i2c_core syscopyarea mei_me sys=
fillrect ipmi_si sysimgblt fb_sys_fops dcdbas ipmi_devintf irqbypass ib_cm =
backlight evdev mei ipmi_msghandler button mlx5_ib ib_core ip_tables squash=
fs loop sr_mod cdrom sd_mod crc32c_intel ahci aesni_intel libahci tg3 ehci_=
pci aes_x86_64 crypto_simd ehci_hcd mlx5_core hwmon libata megaraid_sas cry=
ptd glue_helper usbcore ptp pps_core scsi_mod usb_common libphy dm_mirror d=
m_region_hash dm_log dm_mod autofs4
[   24.188339] CPU: 12 PID: 1725 Comm: systemd-udevd Tainted: G        W   =
    4.10.9-coreos #1
[   24.188339] Hardware name: Dell Inc. PowerEdge R730/0WCJNT, BIOS 2.2.5 0=
9/06/2016
[   24.188339] task: ffff927b6005d880 task.stack: ffffb4901adec000
[   24.188340] RIP: 0010:__ww_mutex_lock+0x24/0xa0
[   24.188341] RSP: 0018:ffffb4901adef8b0 EFLAGS: 00010246
[   24.188342] RAX: 0000000000000000 RBX: 0000000000000018 RCX: 00000000000=
00000
[   24.188342] RDX: ffff927b6005d880 RSI: ffff927b6005f1c0 RDI: ffff927b7f7=
98600
[   24.188343] RBP: ffffb4901adef8c8 R08: 0000000000000001 R09: 00000000000=
00000
[   24.188343] R10: 0000000000000001 R11: 0000000000000000 R12: ffff927b636=
2f280
[   24.188344] R13: fffffffffffffff0 R14: ffff929b715623a0 R15: ffff927b714=
d9d40
[   24.188345] FS:  00007f8eeea3f8c0(0000) GS:ffff927b7f780000(0000) knlGS:=
0000000000000000
[   24.188345] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   24.188346] CR2: 0000000000000018 CR3: 0000001fe0344000 CR4: 00000000003=
406e0
[   24.188346] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[   24.188346] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[   24.188347] Call Trace:
[   24.188350]  drm_modeset_lock+0x3d/0xf0 [drm]
[   24.188353]  drm_modeset_lock_all_ctx+0x5a/0xb0 [drm]
[   24.188355]  drm_modeset_lock_all+0x60/0xe0 [drm]
[   24.188358]  drm_crtc_force_disable_all+0x21/0x80 [drm]
[   24.188365]  amdgpu_device_fini+0x2d/0x160 [amdgpu]
[   24.188371]  amdgpu_driver_unload_kms+0x44/0x80 [amdgpu]
[   24.188377]  amdgpu_driver_load_kms+0xf9/0x1b0 [amdgpu]
[   24.188381]  drm_dev_register+0x134/0x170 [drm]
[   24.188384]  drm_get_pci_dev+0x9a/0x1d0 [drm]
[   24.188390]  amdgpu_drm_ioctl+0x469/0x16f0 [amdgpu]
[   24.188392]  local_pci_probe+0x45/0xa0
[   24.188393]  pci_device_probe+0xff/0x140
[   24.188394]  driver_probe_device+0x2c5/0x470
[   24.188395]  __driver_attach+0xdf/0xf0
[   24.188396]  ? driver_probe_device+0x470/0x470
[   24.188397]  bus_for_each_dev+0x6c/0xc0
[   24.188398]  driver_attach+0x1e/0x20
[   24.188399]  bus_add_driver+0x45/0x270
[   24.188400]  ? 0xffffffffc06d8000
[   24.188401]  driver_register+0x60/0xe0
[   24.188401]  ? 0xffffffffc06d8000
[   24.188402]  __pci_register_driver+0x4c/0x50
[   24.188405]  drm_pci_init+0xed/0x100 [drm]
[   24.188405]  ? 0xffffffffc06d8000
[   24.188411]  init_module+0x92/0x1000 [amdgpu]
[   24.188412]  do_one_initcall+0x53/0x1b0
[   24.188413]  ? __vunmap+0x81/0xd0
[   24.188414]  ? kmem_cache_alloc_trace+0xdb/0x1b0
[   24.188414]  ? kfree+0x161/0x170
[   24.188415]  do_init_module+0x60/0x1fa
[   24.188417]  load_module+0x2329/0x27d0
[   24.188418]  ? __symbol_put+0x60/0x60
[   24.188419]  ? ima_post_read_file+0x74/0x90
[   24.188420]  SYSC_finit_module+0xa6/0xf0
[   24.188421]  SyS_finit_module+0xe/0x10
[   24.188422]  do_syscall_64+0x5a/0x160
[   24.188423]  entry_SYSCALL64_slow_path+0x25/0x25
[   24.188423] RIP: 0033:0x7f8eedab75e9
[   24.188424] RSP: 002b:00007ffc9814b048 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000139
[   24.188424] RAX: ffffffffffffffda RBX: 000055bf95cb1aa0 RCX: 00007f8eeda=
b75e9
[   24.188425] RDX: 0000000000000000 RSI: 00007f8eee3d618b RDI: 00000000000=
00017
[   24.188425] RBP: 00007ffc9814b0a0 R08: 0000000000000000 R09: 00000000000=
00000
[   24.188425] R10: 0000000000000017 R11: 0000000000000246 R12: 00007f8eee3=
d618b
[   24.188426] R13: 0000000000000000 R14: 000055bf95cb23f0 R15: 00000000000=
20000
[   24.188426] Code: e3 e8 a8 ff 0f 1f 00 0f 1f 44 00 00 55 48 89 e5 41 55 =
41 54 53 49 89 f4 48 89 fb e8 37 de ff ff 65 48 8b 14 25 40 d4 00 00 31 c0 =
<f0> 48 0f b1 13 48 85 c0 75 1e 41 83 44 24 10 01 4c 89 63 20 0f=20
[   24.188437] RIP: __ww_mutex_lock+0x24/0xa0 RSP: ffffb4901adef8b0
[   24.188437] CR2: 0000000000000018
[   24.188443] ---[ end trace 88c8cb35b32e3b89 ]---
[   24.191020] Kernel panic - not syncing: Fatal exception
[   24.414327] Kernel Offset: 0x9000000 from 0xffffffff81000000 (relocation=
 range: 0xffffffff80000000-0xffffffffbfffffff)
[   24.822133] Rebooting in 60 seconds..
~. [terminated ipmitool]


--nextPart11244922.Dc9rs1IUlE--

--nextPart1522759.ULZe8p0PED
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQG0BAABCAAGBQJY74i0AAoJENS5dBsVnRQdVe4MwJ5R+LZboef5IlgSfaePLY0j
0qAqMG8IsXnHEcJf2wgHkw/lgFpZEjtU6aiWVi17haW5xD+tKELyAI9/DFcl0U1f
V7rZEUohcLzhy8le+++CnOQ/k2GIEZKVjGfhy9gkoE2tP06cDiwdJ1z09s1GAGgh
/Ss2dgArV7IvFzzULBtOSVRgma6sZrs0aaxgGzmr7OrTLLqA/NmUhkIN6Nr40b6e
cMANZ6Kt+806DWzSje+aUyRvqEDyn8BsSR4ngv4eqrgl3szd3kbtwyaJjvaRlJpC
6bS4IbwuXiT9UTGoPMHF3fA3CvpGNn/5xzGQIV00YL6tqXsm9JOvgR99kcgEWe1l
DBYI3DINYIyd7p2hx4MIOs9StDvTD17GKHUKiLBzp21/BfpD4H9uHRQTzsQpT9i5
Fcu1ZYTi6wW/SInWtNzKvat/jMQv7m9tgyx9phZK3w9DabP21LJqC5ImwxgwBNXK
fV9jk5jHdC2lBh2eA+Cd57Yg0ViRHJ9mrZ0pk07ZC/3L7ueoVAO0UQui8UG2sP8j
+VOFAO6gEQ==
=34JH
-----END PGP SIGNATURE-----

--nextPart1522759.ULZe8p0PED--


--===============1576605916==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1576605916==--
