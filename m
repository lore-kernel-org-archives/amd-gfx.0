From: Bjarni Ingi Gislason <bjarniig-2945IVfuVpf1P9xLtpHBDw@public.gmane.org>
Subject: radeon.4 (radeon.man): Some fixes in the manual
Date: Fri, 29 Jun 2018 00:22:25 +0000
Message-ID: <20180629002224.GA12691@rhi.hi.is>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k1lZvvs/B4yU6o8G"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
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


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  This was sent to Debian (bug #902555), which asked for it to be
reported upstream.

Package: xserver-xorg-video-radeon
Version: 1:18.0.1-1
Severity: minor
Tags: patch

Dear Maintainer,

  Summary of changes:

Remove superfluous quotation marks (") from the argument of a
single-font macro.

Use a better presentation for an ellipsis (with narrow space between
the periods).

Split long lines (> 80).

Begin a sentence on a new line if there is only one space separating
sentences.

Don't begin a sentence with a digit.

Add a comma after "e.g.".

Separate numbers from the units (with an unpaddable space).

Change - to \- if it shall be printed as a minus.

Change a two-fonts macro to an one-font macro for a
single argument.

Protect . if not an end of sentence.

Don't repeat a "long" word, but rephrase the text.

Use "tbl" to create a table, otherwise the text looks ugly with a
proportional font.

Protect . if not an end of sentence.

####

  The patch is in the attachment.

-- System Information:
Debian Release: buster/sid
  APT prefers stable-updates
  APT policy: (500, 'stable-updates'), (500, 'proposed-updates'), (500, 'testing'), (500, 'stable')
Architecture: amd64 (x86_64)

Kernel: Linux 4.9.110-1 (SMP w/2 CPU cores)
Locale: LANG=is_IS.iso88591, LC_CTYPE=is_IS.iso88591 (charmap=ISO-8859-1), LANGUAGE=is_IS.iso88591 (charmap=ISO-8859-1)
Shell: /bin/sh linked to /bin/dash
Init: sysvinit (via /sbin/init)

Versions of packages xserver-xorg-video-radeon depends on:
ii  libc6                                  2.27-3
ii  libdrm-radeon1                         2.4.92-1
ii  libudev1                               238-5
ii  xserver-xorg-core [xorg-video-abi-23]  2:1.19.6-1

xserver-xorg-video-radeon recommends no packages.

Versions of packages xserver-xorg-video-radeon suggests:
ii  firmware-amd-graphics  20170823-1

-- no debconf information

-- 
Bjarni I. Gislason

--k1lZvvs/B4yU6o8G
Content-Type: application/x-troff-man
Content-Disposition: attachment; filename="bug.radeon.4"
Content-Transfer-Encoding: quoted-printable

--- radeon.4	2018-03-20 12:17:16.000000000 +0000=0A+++ radeon.4.new	2018-06=
-27 01:55:21.000000000 +0000=0A@@ -1,13 +1,14 @@=0A+'\" t=0A .ds q \N'34'=
=0A .TH RADEON 4 "xf86-video-ati 18.0.1" "X Version 11"=0A .SH NAME=0A rade=
on \- ATI/AMD RADEON video driver=0A .SH SYNOPSIS=0A .nf=0A-.B "Section \*q=
Device\*q"=0A+.B Section \*qDevice\*q=0A .BI "  Identifier \*q"  devname \*=
q=0A .B  "  Driver \*qradeon\*q"=0A-\ \ ...=0A+\ \ \&.\|.\|.\&=0A .B EndSec=
tion=0A .fi=0A .SH DESCRIPTION=0A@@ -18,7 +19,8 @@ following features:=0A .=
PD 0=0A .TP 2=0A \(bu=0A-Full support for 8-, 15-, 16- and 24-bit pixel dep=
ths, and for 30-bit depth on Linux 3.16=0A+Full support for 8-, 15-, 16- an=
d 24-bit pixel depths, and for 30-bit=0A+depth on Linux 3.16=0A and later;=
=0A .TP=0A \(bu=0A@@ -37,7 +39,8 @@ only available on R/RV3xx, R/RV/RS4xx, =
R=0A .SH SUPPORTED HARDWARE=0A The=0A .B radeon=0A-driver supports PCI, AGP=
, and PCIe video cards based on the following ATI/AMD chips=0A+driver suppo=
rts PCI, AGP, and PCIe video cards based on the following=0A+ATI/AMD chips=
=0A (note: list is non-exhaustive):=0A .PP=0A .PD 0=0A@@ -243,33 +246,43 @@=
 Option \*qZaphodHeads\*q \*qLVDS,VGA-0\*=0A will assign xrandr outputs LVD=
S and VGA-0 to this instance of the driver.=0A .TP=0A .BI "Option \*qColorT=
iling\*q \*q" "boolean" \*q=0A-The framebuffer can be addressed either in l=
inear or tiled mode. Tiled mode can provide=0A-significant performance bene=
fits with 3D applications.  Tiling will be disabled if the drm=0A-module is=
 too old or if the current display configuration does not support it.  On R=
600+=0A-this enables 1D tiling mode.=0A+The framebuffer can be addressed ei=
ther in linear or tiled mode.=0A+Tiled mode can provide=0A+significant perf=
ormance benefits with 3D applications.=0A+Tiling will be disabled if the dr=
m=0A+module is too old or if the current display configuration does not sup=
port=0A+it.=0A+On R600+ this enables 1D tiling mode.=0A .br=0A The default =
value is=0A .B on=0A-for R/RV3XX, R/RV4XX, R/RV5XX, RS6XX, RS740, R/RV6XX, =
R/RV7XX, RS780, RS880,=0A-EVERGREEN, CAYMAN, ARUBA, Southern Islands, and S=
ea Islands and=0A+for R/RV3XX, R/RV4XX, R/RV5XX, RS6XX, RS740, R/RV6XX, R/R=
V7XX, RS780,=0A+RS880, EVERGREEN, CAYMAN, ARUBA, Southern Islands, and Sea =
Islands and=0A .B off=0A-for R/RV/RS1XX, R/RV/RS2XX, RS3XX, and RS690/RS780=
/RS880 when fast fb feature is enabled.=0A+for R/RV/RS1XX, R/RV/RS2XX, RS3X=
X, and RS690/RS780/RS880 when fast fb=0A+feature is enabled.=0A .TP=0A .BI =
"Option \*qColorTiling2D\*q \*q" "boolean" \*q=0A-The framebuffer can be ad=
dressed either in linear, 1D, or 2D tiled modes. 2D tiled mode can=0A-provi=
de significant performance benefits over 1D tiling with 3D applications.  T=
iling=0A-will be disabled if the drm module is too old or if the current di=
splay configuration=0A-does not support it. KMS ColorTiling2D is only suppo=
rted on R600 and newer chips and requires=0A-Mesa 9.0 or newer for R6xx-ARU=
BA, Mesa 9.2 or newer for Southern Islands, and Mesa=0A-10.1 or newer for S=
ea Islands.=0A+The framebuffer can be addressed either in linear, 1D, or 2D=
 tiled=0A+modes.=0A+The 2D tiled mode can=0A+provide significant performanc=
e benefits over 1D tiling with 3D=0A+applications.=0A+Tiling will be disabl=
ed if the drm module is too old or if the current=0A+display configuration =
does not support it.=0A+KMS ColorTiling2D is only supported on R600 and new=
er chips and=0A+requires Mesa 9.0 or newer for R6xx-ARUBA,=0A+Mesa 9.2 or n=
ewer for Southern Islands, and Mesa 10.1 or newer for Sea=0A+Islands.=0A .b=
r=0A The default value is=0A .B on=0A-for R/RV6XX, R/RV7XX, RS780, RS880, E=
VERGREEN, CAYMAN, ARUBA, Southern Islands, and=0A-Sea Islands.=0A+for R/RV6=
XX, R/RV7XX, RS780, RS880, EVERGREEN, CAYMAN, ARUBA, Southern=0A+Islands, a=
nd Sea Islands.=0A .TP=0A .BI "Option \*qDRI\*q \*q" integer \*q=0A-Define =
the maximum level of DRI to enable. Valid values are 2 for DRI2 or 3 for DR=
I3.=0A+Define the maximum level of DRI to enable.  Valid values are 2 for=
=0A+DRI2 or 3 for DRI3.=0A The default is=0A .B 3 for DRI3=0A if the Xorg v=
ersion is >=3D 1.18.3 and glamor is enabled, otherwise=0A@@ -283,11 +296,11=
 @@ Pageflipping is supported on all radeon=0A .TP=0A .BI "Option \*qTearFr=
ee\*q \*q" boolean \*q=0A Set the default value of the per-output 'TearFree=
' property, which controls=0A-tearing prevention using the hardware page fl=
ipping mechanism. TearFree is=0A-on for any CRTC associated with one or mor=
e outputs with TearFree on. Two=0A+tearing prevention using the hardware pa=
ge flipping mechanism.  TearFree is=0A+on for any CRTC associated with one =
or more outputs with TearFree on.  Two=0A separate scanout buffers need to =
be allocated for each CRTC with TearFree=0A-on. If this option is set, the =
default value of the property is 'on' or 'off'=0A-accordingly. If this opti=
on isn't set, the default value of the property is=0A+on.  If this option i=
s set, the default value of the property is 'on' or 'off'=0A+accordingly.  =
If this option isn't set, the default value of the property is=0A .B auto,=
=0A which means that TearFree is on for rotated outputs, outputs with RandR=
=0A transforms applied and for RandR 1.4 slave outputs, otherwise off.=0A@@=
 -297,9 +310,10 @@ Chooses between available acceleration a=0A .B EXA=0A (f=
or pre-TAHITI GPUs) and=0A .B glamor=0A-(for R300 or higher). The default i=
s=0A+(for R300 or higher).  The default is=0A .B glamor=0A-with R600 or new=
er (with Xorg >=3D 1.18.3, otherwise with TAHITI or newer), otherwise=0A+wi=
th R600 or newer (with Xorg >=3D 1.18.3, otherwise with TAHITI or=0A+newer)=
, otherwise=0A .B EXA.=0A =0A .PP=0A@@ -313,7 +327,7 @@ are supported for=
=0A This option enables a so-called "shadow primary" buffer for fast CPU ac=
cess to=0A pixel data, and separate scanout buffers for each display contro=
ller (CRTC).=0A This may improve performance for some 2D workloads, potenti=
ally at the expense=0A-of other (e.g. 3D, video) workloads.=0A+of other (e.=
g., 3D, video) workloads.=0A Note in particular that enabling this option c=
urrently disables page flipping.=0A The default is=0A .B off.=0A@@ -338,7 +=
352,9 @@ we use a heuristic based on VRAM amount=0A to use VRAM for non-ess=
ential pixmaps.  This option allows us to override the=0A heuristic.  The d=
efault is=0A .B on=0A-with > 32MB VRAM, off with < 32MB or when fast fb fea=
ture is enabled for RS690/RS780/RS880.=0A+with > 32\ MB VRAM,=0A+.B off=0A+=
with < 32\ MB or when fast fb feature is enabled for RS690/RS780/RS880.=0A =
=2ETP=0A .BI "Option \*qSwapbuffersWait\*q \*q" boolean \*q=0A This option =
controls the behavior of glXSwapBuffers and glXCopySubBufferMESA=0A@@ -356,=
29 +372,29 @@ The driver supports the following X11 Xv=0A You can use the "=
xvattr" tool to query/set those attributes at runtime.=0A =0A .TP=0A-.BI "X=
V_VSYNC"=0A+.B XV_VSYNC=0A XV_VSYNC is used to control whether textured ada=
pter synchronizes=0A the screen update to the monitor vertical refresh to e=
liminate tearing.=0A-It has two values: 'off'(0) and 'on'(1). The default i=
s=0A+It has two values: 'off'(0) and 'on'(1).  The default is=0A .B 'on'(1)=
=2E=0A =0A .TP=0A-.BI "XV_CRTC"=0A+.B XV_CRTC=0A XV_CRTC is used to control=
 which display controller (crtc) the textured=0A adapter synchronizes the s=
creen update with when XV_VSYNC is enabled.=0A-The default, 'auto'(-1), wil=
l sync to the display controller that more=0A+The default, 'auto'(\-1), wil=
l sync to the display controller that more=0A of the video is on; when this=
 is ambiguous, the display controller associated=0A with the RandR primary =
output is preferred.  This attribute is useful for=0A things like clone mod=
e where the user can best decide which display should be=0A synced.=0A The =
default is=0A-.B 'auto'(-1).=0A+.B 'auto'(\-1).=0A =0A .TP=0A-.BI "XV_BICUB=
IC"=0A+.B XV_BICUBIC=0A XV_BICUBIC is used to control whether textured adap=
ter should apply=0A-a bicubic filter to smooth the output. It has three val=
ues: 'off'(0), 'on'(1)=0A-and 'auto'(2). 'off' means never apply the filter=
, 'on' means always apply=0A+a bicubic filter to smooth the output.  It has=
 three values: 'off'(0), 'on'(1)=0A+and 'auto'(2).  'off' means never apply=
 the filter, 'on' means always apply=0A the filter and 'auto' means apply t=
he filter only if the X and Y=0A sizes are scaled to more than double to av=
oid blurred output.  Bicubic=0A filtering is not currently compatible with =
other Xv attributes like hue,=0A@@ -407,27 +423,31 @@ https://lists.freedes=
ktop.org/mailman/li=0A IRC channel:=0A .RS 4=0A #radeon on irc.freenode.net=
=0A+.sp 1=0A+Use the bugtracker "https://bugs.freedesktop.org/"=0A .RE=0A .=
IP " 5." 4=0A-Query the bugtracker for radeon bugs:=0A+to query for radeon =
bugs:=0A .RS 4=0A-https://bugs.freedesktop.org/query.cgi?product=3Dxorg&com=
ponent=3DDriver/Radeon=0A+query.cgi?product=3Dxorg&component=3DDriver/Radeo=
n=0A .RE=0A .IP " 6." 4=0A-Submit bugs & patches:=0A+to submit bugs & patch=
es:=0A .RS 4=0A-https://bugs.freedesktop.org/enter_bug.cgi?product=3Dxorg&c=
omponent=3DDriver/Radeon=0A+enter_bug.cgi?product=3Dxorg&component=3DDriver=
/Radeon=0A .RE=0A-=0A .SH AUTHORS=0A-.nf=0A Authors include:=0A-Rickard E. =
(Rik) Faith   \fIfaith-cB/ihCqopeG9fK9uEoC1w1aTQe2KTcn/@public.gmane.org\fP=0A-Kevin E. Martin          =
\fIkem-CC+yJ3UmIYqDUpFQwHEjaQ@public.gmane.org\fP=0A-Alan Hourihane           \fIalanh-ASBjxr/nLg+34jqm1rpR7w@public.gmane.org=
on.co.uk\fP=0A-Marc Aurele La France    \fItsi-72qDnkntNoRAfugRpC6u6w@public.gmane.org\fP=0A-Benjamin H=
errenschmidt   \fIbenh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org\fP=0A-Michel D\(:anzer          =
  \fImichel-otUistvHUpPR7s880joybQ@public.gmane.org\fP=0A-Alex Deucher             \fIalexdeucher@gmail=
=2Ecom\fP=0A-Bogdan D.                \fIbogdand-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org\fP=
=0A-Eric Anholt              \fIeric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org\fP=0A+.if n .bp \" avoid a =
possible extra empty line in the table=0A+.TS=0A+l l .=0A+Rickard E.\& (Rik=
) Faith	\fIfaith-cB/ihCqopeG9fK9uEoC1w1aTQe2KTcn/@public.gmane.org\fP=0A+Kevin E.\& Martin	\fIkem@freede=
sktop.org\fP=0A+Alan Hourihane	\fIalanh-ASBjxr/nLg+TY6FTCsQk+9Bc4/FLrbF6@public.gmane.org\fP=0A+Marc Aur=
ele La France	\fItsi-72qDnkntNoRAfugRpC6u6w@public.gmane.org\fP=0A+Benjamin Herrenschmidt	\fIbenh@kerne=
l.crashing.org\fP=0A+Michel D\(:anzer	\fImichel-otUistvHUpPR7s880joybQ@public.gmane.org\fP=0A+Alex Deuc=
her	\fIalexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org\fP=0A+Bogdan D.\&	\fIbogdand-Rn4VEauK+AKRv+LV9MX5urNAH6kLmebB@public.gmane.org=
=2Enet\fP=0A+Eric Anholt	\fIeric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org\fP=0A+.TE=0A=0A
--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--k1lZvvs/B4yU6o8G--
