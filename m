From: Przemek Socha <soprwa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: BISECTED- amd-staging-drm-next,
 xorg-server segfault A6-6310 APU - R4 Mullins.
Date: Thu, 10 Jan 2019 18:56:30 +0100
Message-ID: <5741871.Z2MBXCYFqd@eclipse>
References: <3677766.FRf3LM2rx8@eclipse> <91019770.5DcfmtkFX1@eclipse>
 <641eb681-2952-19d9-5c74-01616a51c6ec@daenzer.net>
Reply-To: soprwa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1563786928=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <641eb681-2952-19d9-5c74-01616a51c6ec-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: yuzhao-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============1563786928==
Content-Type: multipart/signed; boundary="nextPart2564753.EKTGQ9l1mP"; micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart2564753.EKTGQ9l1mP
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Dnia czwartek, 10 stycznia 2019 17:22:07 CET piszesz:
> On 2019-01-10 5:06 p.m., Przemek Socha wrote:
> > Dnia czwartek, 10 stycznia 2019 12:25:01 CET piszesz:
> >> On 2019-01-10 10:44 a.m., Przemek Socha wrote:
> >>> Hi,
> >>> after yesterday's fetch of amd-staging-drm-next tree from agd5f git r=
epo
> >>> my
> >>> xorg server is segfaulting when starting up.
> >>>=20
> >>> I am using gentoo ~amd64, xorg-server 1.20.3, xf86-video-amdgpu-18.1.=
0.
> >>> Machine is an old Lenovo g50-45 netbook with A6-6310 APU - R4 Mullins.
> >>>=20
> >>> - excerpt from Xorg.log:
> >>>=20
> >>> "[    21.878] (II) AMDGPU(0): Setting screen physical size to 700 x 2=
70
> >>> [    21.880] (EE)
> >>> [    21.880] (EE) Backtrace:
> >>> [    21.880] (EE) 0: /usr/bin/X (xorg_backtrace+0x4d) [0x559df051f0bd]
> >>> [    21.880] (EE) 1: /usr/bin/X (0x559df0376000+0x1acc89)
> >>> [0x559df0522c89]
> >>> [    21.880] (EE) 2: /lib64/libpthread.so.0 (0x7f6f2edad000+0x14560)
> >>> [0x7f6f2edc1560]
> >>> [    21.880] (EE) 3: /usr/lib64/xorg/modules/drivers/amdgpu_drv.so
> >>> (0x7f6f2f32b000+0x14fce) [0x7f6f2f33ffce]
> >>> [    21.880] (EE) 4: /usr/lib64/xorg/modules/drivers/amdgpu_drv.so
> >>> (0x7f6f2f32b000+0xd1c4) [0x7f6f2f3381c4]
> >>> [    21.880] (EE) 5: /usr/bin/X (0x559df0376000+0xdf024)
> >>> [0x559df0455024]
> >>> [    21.881] (EE) 6: /usr/bin/X (InitRootWindow+0x11) [0x559df03f8761]
> >>> [    21.881] (EE) 7: /usr/bin/X (0x559df0376000+0x5b574)
> >>> [0x559df03d1574]
> >>> [    21.881] (EE) 8: /lib64/libc.so.6 (__libc_start_main+0xee)
> >>> [0x7f6f2ec054ce]
> >>> [    21.881] (EE) 9: /usr/bin/X (_start+0x2a) [0x559df03bb00a]
> >>> [    21.881] (EE)
> >>> [    21.881] (EE) Segmentation fault at address 0x4
> >>> [    21.881] (EE)
> >>> Fatal server error:
> >>> [    21.881] (EE) Caught signal 11 (Segmentation fault). Server abort=
ing
> >>> [    21.881] (EE)
> >>> [    21.881] (EE)
> >>> Please consult the The X.Org Foundation support
> >>>=20
> >>> 	 at http://wiki.x.org
> >>> =20
> >>>  for help.
> >>>=20
> >>> [    21.881] (EE) Please also check the log file at
> >>> "/var/log/Xorg.0.log"
> >>> for additional information.
> >>> [    21.881] (EE)
> >>> [    21.881] (II) AIGLX: Suspending AIGLX clients for VT switch
> >>> [    21.957] (EE) Server terminated with error (1). Closing log file."
> >>>=20
> >>>=20
> >>> I am not sure if I didn't mess up anything, but git bisect gives the
> >>> results:
> >>>=20
> >>> [...]
> >>>=20
> >>> 79c6b898011958fba7722528d567b64e1cdc8dbe is the first bad commit
> >>> commit 79c6b898011958fba7722528d567b64e1cdc8dbe
> >>> Author: Yu Zhao <yuzhao-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
> >>> Date:   Mon Jan 7 15:51:14 2019 -0700
> >>>=20
> >>>     drm/amdgpu: validate user pitch alignment
> >>>    =20
> >>>     Userspace may request pitch alignment that is not supported by GP=
U.
> >>>     Some requests 32, but GPU ignores it and uses default 64 when cpp=
 is
> >>>     4. If GEM object is allocated based on the smaller alignment, GPU
> >>>     DMA will go out of bound.
> >>>    =20
> >>>     Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org # v4.2+
> >>>     Reviewed-by: Michel D=C3=A4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>
> >>>     Signed-off-by: Yu Zhao <yuzhao-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
> >>> :
> >>> :040000 040000 5338964e9975e461ceedb27f6342c2896f54607a
> >>>=20
> >>> ed2f04fc9b665b27b1905fd60b7d2a3933d1fdcc M      drivers
> >>=20
> >> Thanks for tracking this down. It turns out the check added by this
> >> change is too strict for linear framebuffers. I've sent a patch
> >> reverting it for review: https://patchwork.freedesktop.org/patch/27612=
2/
> >>=20
> >> Sorry I didn't realize this issue when reviewing this change.
> >=20
> > Thanks for the swift response and sorry about the delay on my side.
>=20
> No worries.
>=20
> > Unfortunately applying this patch does not help in my case (but could be
> > necessarily after all).
> >=20
> > To start xorg-server I had to apply your patch, and, on top of this,
> > reverse the  "drm/amdgpu: validate user pitch alignment" -
> > 79c6b898011958fba7722528d567b64e1cdc8dbe.
> >=20
> > Now xorg server starts, but I have doubt about system stability because
> > description of reverted one is saying that "if GEM object is allocated
> > based on the smaller alignment, GPU
> > DMA will go out of bound".
>=20
> I don't think you need to worry. If the pitch chosen by
> xf86-video-amdgpu actually didn't match the one used by the hardware,
> the output would be unusably distorted. So the pitch check seems too
> strict in this case as well.
>=20
> Please provide the full Xorg log file and the output of dmesg
> corresponding to a failure. If you write 4 to
> /sys/module/drm/parameters/debug before reproducing the problem (you can
> write 0 to it again afterwards), dmesg should give us even more
> information about why the pitch is rejected.

Thanks for the clarification,
By requested files this mail will be enormous:

part of dmesg output with "echo 4 > .. /debug" when I was trying to start x=
org=20
on the kernel with "drm/amdgpu: validate user pitch alignment" patch (kerne=
l=20
booted up with amdgpu.dc=3D1 amdgpu.dpm=3D1):

[   28.388290] elogind-daemon[5647]: New session 2 of user root.
[  147.756370] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:
48:eDP-1]
[  147.756379] [drm:drm_add_edid_modes] ELD: no CEA Extension found
[  147.756382] [drm:drm_add_display_info] non_desktop set to 0
[  147.756549] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:
48:eDP-1] probed modes :
[  147.756556] [drm:drm_mode_debug_printmodeline] Modeline 54:"1366x768" 60=
=20
76320 1366 1414 1446 1610 768 771 776 790 0x48 0xa
[  147.756561] [drm:drm_mode_debug_printmodeline] Modeline 58:"1280x720" 60=
=20
76320 1280 1414 1446 1610 720 771 776 790 0x40 0xa
[  147.756565] [drm:drm_mode_debug_printmodeline] Modeline 57:"1024x768" 60=
=20
76320 1024 1414 1446 1610 768 771 776 790 0x40 0xa
[  147.756570] [drm:drm_mode_debug_printmodeline] Modeline 56:"800x600" 60=
=20
76320 800 1414 1446 1610 600 771 776 790 0x40 0xa
[  147.756574] [drm:drm_mode_debug_printmodeline] Modeline 55:"640x480" 60=
=20
76320 640 1414 1446 1610 480 771 776 790 0x40 0xa
[  147.756690] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:
51:HDMI-A-1]
[  147.756697] [drm:drm_add_edid_modes] ELD monitor Philips 170C5
[  147.756701] [drm:drm_add_edid_modes] HDMI: latency present 0 0, video=20
latency 0 0, audio latency 0 0
[  147.756703] [drm:drm_add_edid_modes] ELD size 36, SAD count 1
[  147.756705] [drm:drm_add_display_info] non_desktop set to 0
[  147.756708] [drm:drm_add_display_info] HDMI: DVI dual 0, max TMDS clock=
=20
225000 kHz
[  147.756718] [drm:do_detailed_mode] composite sync not supported
[  147.757373] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:
51:HDMI-A-1] probed modes :
[  147.757377] [drm:drm_mode_debug_printmodeline] Modeline 59:"1280x1024" 6=
0=20
108000 1280 1328 1440 1688 1024 1025 1028 1066 0x48 0x5
[  147.757382] [drm:drm_mode_debug_printmodeline] Modeline 79:"1920x1080" 6=
0=20
148500 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0x5
[  147.757416] [drm:drm_mode_debug_printmodeline] Modeline 84:"1920x1080" 6=
0=20
148352 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0x5
[  147.757420] [drm:drm_mode_debug_printmodeline] Modeline 71:"1280x1024" 7=
5=20
135000 1280 1296 1440 1688 1024 1025 1028 1066 0x40 0x5
[  147.757428] [drm:drm_mode_debug_printmodeline] Modeline 63:"1280x960" 60=
=20
108000 1280 1376 1488 1800 960 961 964 1000 0x40 0x5
[  147.757436] [drm:drm_mode_debug_printmodeline] Modeline 87:"1280x800" 60=
=20
108000 1280 1328 1440 1688 800 1025 1028 1066 0x40 0x5
[  147.757444] [drm:drm_mode_debug_printmodeline] Modeline 62:"1152x864" 75=
=20
108000 1152 1216 1344 1600 864 865 868 900 0x40 0x5
[  147.757452] [drm:drm_mode_debug_printmodeline] Modeline 61:"1152x864" 70=
=20
96728 1152 1224 1344 1536 864 865 868 900 0x0 0x6
[  147.757459] [drm:drm_mode_debug_printmodeline] Modeline 80:"1280x720" 60=
=20
74250 1280 1390 1430 1650 720 725 730 750 0x40 0x5
[  147.757466] [drm:drm_mode_debug_printmodeline] Modeline 85:"1280x720" 60=
=20
74176 1280 1390 1430 1650 720 725 730 750 0x40 0x5
[  147.757474] [drm:drm_mode_debug_printmodeline] Modeline 72:"1024x768" 75=
=20
78750 1024 1040 1136 1312 768 769 772 800 0x40 0x5
[  147.757482] [drm:drm_mode_debug_printmodeline] Modeline 73:"1024x768" 70=
=20
75000 1024 1048 1184 1328 768 771 777 806 0x40 0xa
[  147.757489] [drm:drm_mode_debug_printmodeline] Modeline 74:"1024x768" 60=
=20
65000 1024 1048 1184 1344 768 771 777 806 0x40 0xa
[  147.757497] [drm:drm_mode_debug_printmodeline] Modeline 75:"832x624" 75=
=20
57284 832 864 928 1152 624 625 628 667 0x40 0xa
[  147.757504] [drm:drm_mode_debug_printmodeline] Modeline 76:"800x600" 75=
=20
49500 800 816 896 1056 600 601 604 625 0x40 0x5
[  147.757510] [drm:drm_mode_debug_printmodeline] Modeline 77:"800x600" 72=
=20
50000 800 856 976 1040 600 637 643 666 0x40 0x5
[  147.757514] [drm:drm_mode_debug_printmodeline] Modeline 64:"800x600" 60=
=20
40000 800 840 968 1056 600 601 605 628 0x40 0x5
[  147.757518] [drm:drm_mode_debug_printmodeline] Modeline 65:"800x600" 56=
=20
36000 800 824 896 1024 600 601 603 625 0x40 0x5
[  147.757522] [drm:drm_mode_debug_printmodeline] Modeline 82:"720x480" 60=
=20
27027 720 736 798 858 480 489 495 525 0x40 0xa
[  147.757526] [drm:drm_mode_debug_printmodeline] Modeline 60:"720x480" 60=
=20
27000 720 736 798 858 480 489 495 525 0x40 0xa
[  147.757531] [drm:drm_mode_debug_printmodeline] Modeline 81:"720x480" 60=
=20
27000 720 736 798 858 480 489 495 525 0x40 0xa
[  147.757535] [drm:drm_mode_debug_printmodeline] Modeline 66:"640x480" 75=
=20
31500 640 656 720 840 480 481 484 500 0x40 0xa
[  147.757539] [drm:drm_mode_debug_printmodeline] Modeline 67:"640x480" 73=
=20
31500 640 664 704 832 480 489 492 520 0x40 0xa
[  147.757543] [drm:drm_mode_debug_printmodeline] Modeline 68:"640x480" 67=
=20
30240 640 704 768 864 480 483 486 525 0x40 0xa
[  147.757547] [drm:drm_mode_debug_printmodeline] Modeline 83:"640x480" 60=
=20
25200 640 656 752 800 480 490 492 525 0x40 0xa
[  147.757551] [drm:drm_mode_debug_printmodeline] Modeline 69:"640x480" 60=
=20
25175 640 656 752 800 480 490 492 525 0x40 0xa
[  147.757555] [drm:drm_mode_debug_printmodeline] Modeline 70:"720x400" 70=
=20
28320 720 738 846 900 400 412 414 449 0x40 0x6
[  147.780171] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:
48:eDP-1]
[  147.780181] [drm:drm_add_edid_modes] ELD: no CEA Extension found
[  147.780186] [drm:drm_add_display_info] non_desktop set to 0
[  147.780402] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:
48:eDP-1] probed modes :
[  147.780410] [drm:drm_mode_debug_printmodeline] Modeline 54:"1366x768" 60=
=20
76320 1366 1414 1446 1610 768 771 776 790 0x48 0xa
[  147.780416] [drm:drm_mode_debug_printmodeline] Modeline 58:"1280x720" 60=
=20
76320 1280 1414 1446 1610 720 771 776 790 0x40 0xa
[  147.780422] [drm:drm_mode_debug_printmodeline] Modeline 57:"1024x768" 60=
=20
76320 1024 1414 1446 1610 768 771 776 790 0x40 0xa
[  147.780428] [drm:drm_mode_debug_printmodeline] Modeline 56:"800x600" 60=
=20
76320 800 1414 1446 1610 600 771 776 790 0x40 0xa
[  147.780434] [drm:drm_mode_debug_printmodeline] Modeline 55:"640x480" 60=
=20
76320 640 1414 1446 1610 480 771 776 790 0x40 0xa
[  147.782212] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:
51:HDMI-A-1]
[  147.782226] [drm:drm_add_edid_modes] ELD monitor Philips 170C5
[  147.782233] [drm:drm_add_edid_modes] HDMI: latency present 0 0, video=20
latency 0 0, audio latency 0 0
[  147.782238] [drm:drm_add_edid_modes] ELD size 36, SAD count 1
[  147.782243] [drm:drm_add_display_info] non_desktop set to 0
[  147.782249] [drm:drm_add_display_info] HDMI: DVI dual 0, max TMDS clock=
=20
225000 kHz
[  147.782271] [drm:do_detailed_mode] composite sync not supported
[  147.783693] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:
51:HDMI-A-1] probed modes :
[  147.783704] [drm:drm_mode_debug_printmodeline] Modeline 59:"1280x1024" 6=
0=20
108000 1280 1328 1440 1688 1024 1025 1028 1066 0x48 0x5
[  147.783713] [drm:drm_mode_debug_printmodeline] Modeline 79:"1920x1080" 6=
0=20
148500 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0x5
[  147.783723] [drm:drm_mode_debug_printmodeline] Modeline 84:"1920x1080" 6=
0=20
148352 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0x5
[  147.783732] [drm:drm_mode_debug_printmodeline] Modeline 71:"1280x1024" 7=
5=20
135000 1280 1296 1440 1688 1024 1025 1028 1066 0x40 0x5
[  147.783742] [drm:drm_mode_debug_printmodeline] Modeline 63:"1280x960" 60=
=20
108000 1280 1376 1488 1800 960 961 964 1000 0x40 0x5
[  147.783751] [drm:drm_mode_debug_printmodeline] Modeline 87:"1280x800" 60=
=20
108000 1280 1328 1440 1688 800 1025 1028 1066 0x40 0x5
[  147.783760] [drm:drm_mode_debug_printmodeline] Modeline 62:"1152x864" 75=
=20
108000 1152 1216 1344 1600 864 865 868 900 0x40 0x5
[  147.783770] [drm:drm_mode_debug_printmodeline] Modeline 61:"1152x864" 70=
=20
96728 1152 1224 1344 1536 864 865 868 900 0x0 0x6
[  147.783779] [drm:drm_mode_debug_printmodeline] Modeline 80:"1280x720" 60=
=20
74250 1280 1390 1430 1650 720 725 730 750 0x40 0x5
[  147.783788] [drm:drm_mode_debug_printmodeline] Modeline 85:"1280x720" 60=
=20
74176 1280 1390 1430 1650 720 725 730 750 0x40 0x5
[  147.783797] [drm:drm_mode_debug_printmodeline] Modeline 72:"1024x768" 75=
=20
78750 1024 1040 1136 1312 768 769 772 800 0x40 0x5
[  147.783807] [drm:drm_mode_debug_printmodeline] Modeline 73:"1024x768" 70=
=20
75000 1024 1048 1184 1328 768 771 777 806 0x40 0xa
[  147.783816] [drm:drm_mode_debug_printmodeline] Modeline 74:"1024x768" 60=
=20
65000 1024 1048 1184 1344 768 771 777 806 0x40 0xa
[  147.783825] [drm:drm_mode_debug_printmodeline] Modeline 75:"832x624" 75=
=20
57284 832 864 928 1152 624 625 628 667 0x40 0xa
[  147.783834] [drm:drm_mode_debug_printmodeline] Modeline 76:"800x600" 75=
=20
49500 800 816 896 1056 600 601 604 625 0x40 0x5
[  147.783843] [drm:drm_mode_debug_printmodeline] Modeline 77:"800x600" 72=
=20
50000 800 856 976 1040 600 637 643 666 0x40 0x5
[  147.783852] [drm:drm_mode_debug_printmodeline] Modeline 64:"800x600" 60=
=20
40000 800 840 968 1056 600 601 605 628 0x40 0x5
[  147.783862] [drm:drm_mode_debug_printmodeline] Modeline 65:"800x600" 56=
=20
36000 800 824 896 1024 600 601 603 625 0x40 0x5
[  147.783871] [drm:drm_mode_debug_printmodeline] Modeline 82:"720x480" 60=
=20
27027 720 736 798 858 480 489 495 525 0x40 0xa
[  147.783880] [drm:drm_mode_debug_printmodeline] Modeline 60:"720x480" 60=
=20
27000 720 736 798 858 480 489 495 525 0x40 0xa
[  147.783889] [drm:drm_mode_debug_printmodeline] Modeline 81:"720x480" 60=
=20
27000 720 736 798 858 480 489 495 525 0x40 0xa
[  147.783898] [drm:drm_mode_debug_printmodeline] Modeline 66:"640x480" 75=
=20
31500 640 656 720 840 480 481 484 500 0x40 0xa
[  147.783907] [drm:drm_mode_debug_printmodeline] Modeline 67:"640x480" 73=
=20
31500 640 664 704 832 480 489 492 520 0x40 0xa
[  147.783916] [drm:drm_mode_debug_printmodeline] Modeline 68:"640x480" 67=
=20
30240 640 704 768 864 480 483 486 525 0x40 0xa
[  147.783925] [drm:drm_mode_debug_printmodeline] Modeline 83:"640x480" 60=
=20
25200 640 656 752 800 480 490 492 525 0x40 0xa
[  147.783934] [drm:drm_mode_debug_printmodeline] Modeline 69:"640x480" 60=
=20
25175 640 656 752 800 480 490 492 525 0x40 0xa
[  147.783943] [drm:drm_mode_debug_printmodeline] Modeline 70:"720x400" 70=
=20
28320 720 738 846 900 400 412 414 449 0x40 0x6
[  147.846148] [drm:amdgpu_display_user_framebuffer_create [amdgpu]] Invali=
d=20
pitch: expecting 10752 but got 10624
[  147.846155] [drm:drm_internal_framebuffer_create] could not create=20
framebuffer"
=20
a full xorg log output:

"[   147.485] (--) Log file renamed from "/var/log/Xorg.pid-11182.log" to "/
var/log/Xorg.0.log"
[   147.486]=20
X.Org X Server 1.20.3
X Protocol Version 11, Revision 0
[   147.486] Build Operating System: Linux 4.18.20-gentoo x86_64 Gentoo
[   147.486] Current Operating System: Linux eclipse 4.20.0-rc3+ #36 SMP=20
PREEMPT Thu Jan 10 16:15:33 CET 2019 x86_64
[   147.486] Kernel command line: initrd=3D/initramfs-eclipse-x86_64-4.20.0=
=2Drc3+=20
crypt_root=3DUUID=3Dc0848674-82a6-4df8-869c-1a5c05f0c4b0 dolvm=20
real_root=3DUUID=3D4b2465e2-cab5-413f-aed5-d127557ec3ef rootfstype=3Dext4 r=
w=20
real_resume=3D/dev/mapper/cryptvg-swap pcie_aspm=3Dforce elevator=3Dbfq qui=
et=20
amdgpu.dc=3D1 amdgpu.dpm=3D1 root_trim=3Dyes
[   147.486] Build Date: 10 January 2019  09:24:34AM
[   147.486] =20
[   147.486] Current version of pixman: 0.36.0
[   147.486] 	Before reporting problems, check http://wiki.x.org
	to make sure that you have the latest version.
[   147.486] Markers: (--) probed, (**) from config file, (=3D=3D) default =
setting,
	(++) from command line, (!!) notice, (II) informational,
	(WW) warning, (EE) error, (NI) not implemented, (??) unknown.
[   147.486] (=3D=3D) Log file: "/var/log/Xorg.0.log", Time: Thu Jan 10 18:=
28:27=20
2019
[   147.486] (=3D=3D) Using config directory: "/etc/X11/xorg.conf.d"
[   147.486] (=3D=3D) Using system config directory "/usr/share/X11/xorg.co=
nf.d"
[   147.487] (=3D=3D) No Layout section.  Using the first Screen section.
[   147.487] (=3D=3D) No screen section available. Using defaults.
[   147.487] (**) |-->Screen "Default Screen Section" (0)
[   147.487] (**) |   |-->Monitor "<default monitor>"
[   147.487] (=3D=3D) No monitor specified for screen "Default Screen Secti=
on".
	Using a default monitor configuration.
[   147.488] (=3D=3D) Automatically adding devices
[   147.488] (=3D=3D) Automatically enabling devices
[   147.488] (=3D=3D) Automatically adding GPU devices
[   147.488] (=3D=3D) Max clients allowed: 256, resource mask: 0x1fffff
[   147.488] (WW) `fonts.dir' not found (or not valid) in "/usr/share/fonts/
misc/".
[   147.488] 	Entry deleted from font path.
[   147.488] 	(Run 'mkfontdir' on "/usr/share/fonts/misc/").
[   147.488] (WW) The directory "/usr/share/fonts/TTF/" does not exist.
[   147.488] 	Entry deleted from font path.
[   147.488] (WW) The directory "/usr/share/fonts/OTF/" does not exist.
[   147.488] 	Entry deleted from font path.
[   147.488] (WW) The directory "/usr/share/fonts/Type1/" does not exist.
[   147.488] 	Entry deleted from font path.
[   147.488] (WW) `fonts.dir' not found (or not valid) in "/usr/share/fonts/
100dpi/".
[   147.488] 	Entry deleted from font path.
[   147.488] 	(Run 'mkfontdir' on "/usr/share/fonts/100dpi/").
[   147.488] (WW) `fonts.dir' not found (or not valid) in "/usr/share/fonts/
75dpi/".
[   147.488] 	Entry deleted from font path.
[   147.488] 	(Run 'mkfontdir' on "/usr/share/fonts/75dpi/").
[   147.488] (=3D=3D) FontPath set to:
=09
[   147.488] (=3D=3D) ModulePath set to "/usr/lib64/xorg/modules"
[   147.488] (II) The server relies on udev to provide the list of input=20
devices.
	If no devices become available, reconfigure udev or disable=20
AutoAddDevices.
[   147.488] (II) Loader magic: 0x55efcb8fcc40
[   147.488] (II) Module ABI versions:
[   147.488] 	X.Org ANSI C Emulation: 0.4
[   147.488] 	X.Org Video Driver: 24.0
[   147.488] 	X.Org XInput driver : 24.1
[   147.488] 	X.Org Server Extension : 10.0
[   147.488] (II) xfree86: Adding drm device (/dev/dri/card0)
[   147.504] (--) PCI:*(0@0:1:0) 1002:9851:17aa:3801 rev 0, Mem @=20
0xe0000000/268435456, 0xf0000000/8388608, 0xf0c00000/262144, I/O @=20
0x00003000/256, BIOS @ 0x????????/131072
[   147.504] (II) LoadModule: "glx"
[   147.504] (II) Loading /usr/lib64/xorg/modules/extensions/libglx.so
[   147.508] (II) Module glx: vendor=3D"X.Org Foundation"
[   147.508] 	compiled for 1.20.3, module version =3D 1.0.0
[   147.508] 	ABI class: X.Org Server Extension, version 10.0
[   147.508] (II) Applying OutputClass "AMDgpu" to /dev/dri/card0
[   147.508] 	loading driver: amdgpu
[   147.508] (=3D=3D) Matched amdgpu as autoconfigured driver 0
[   147.508] (=3D=3D) Matched ati as autoconfigured driver 1
[   147.508] (=3D=3D) Matched modesetting as autoconfigured driver 2
[   147.508] (=3D=3D) Matched fbdev as autoconfigured driver 3
[   147.508] (=3D=3D) Matched vesa as autoconfigured driver 4
[   147.508] (=3D=3D) Assigned the driver to the xf86ConfigLayout
[   147.508] (II) LoadModule: "amdgpu"
[   147.508] (II) Loading /usr/lib64/xorg/modules/drivers/amdgpu_drv.so
[   147.509] (II) Module amdgpu: vendor=3D"X.Org Foundation"
[   147.509] 	compiled for 1.20.3, module version =3D 18.1.0
[   147.509] 	Module class: X.Org Video Driver
[   147.509] 	ABI class: X.Org Video Driver, version 24.0
[   147.509] (II) LoadModule: "ati"
[   147.510] (II) Loading /usr/lib64/xorg/modules/drivers/ati_drv.so
[   147.510] (II) Module ati: vendor=3D"X.Org Foundation"
[   147.510] 	compiled for 1.20.3, module version =3D 18.1.0
[   147.510] 	Module class: X.Org Video Driver
[   147.510] 	ABI class: X.Org Video Driver, version 24.0
[   147.530] (II) LoadModule: "modesetting"
[   147.530] (II) Loading /usr/lib64/xorg/modules/drivers/modesetting_drv.so
[   147.530] (II) Module modesetting: vendor=3D"X.Org Foundation"
[   147.530] 	compiled for 1.20.3, module version =3D 1.20.3
[   147.530] 	Module class: X.Org Video Driver
[   147.530] 	ABI class: X.Org Video Driver, version 24.0
[   147.531] (II) LoadModule: "fbdev"
[   147.531] (WW) Warning, couldn't open module fbdev
[   147.531] (EE) Failed to load module "fbdev" (module does not exist, 0)
[   147.531] (II) LoadModule: "vesa"
[   147.531] (WW) Warning, couldn't open module vesa
[   147.531] (EE) Failed to load module "vesa" (module does not exist, 0)
[   147.531] (II) AMDGPU: Driver for AMD Radeon:
	All GPUs supported by the amdgpu kernel driver
[   147.531] (II) modesetting: Driver for Modesetting Kernel Drivers: kms
[   147.531] (++) using VT number 7

[   147.555] (II) AMDGPU(0): [KMS] Kernel modesetting enabled.
[   147.564] (WW) Falling back to old probe method for modesetting
[   147.564] (WW) VGA arbiter: cannot open kernel arbiter, no multi-card=20
support
[   147.564] (II) AMDGPU(0): Creating default Display subsection in Screen=
=20
section
	"Default Screen Section" for depth/fbbpp 24/32
[   147.564] (=3D=3D) AMDGPU(0): Depth 24, (--) framebuffer bpp 32
[   147.564] (II) AMDGPU(0): Pixel depth =3D 24 bits stored in 4 bytes (32 =
bpp=20
pixmaps)
[   147.564] (=3D=3D) AMDGPU(0): Default visual is TrueColor
[   147.564] (=3D=3D) AMDGPU(0): RGB weight 888
[   147.564] (II) AMDGPU(0): Using 8 bits per RGB (8 bit DAC)
[   147.564] (--) AMDGPU(0): Chipset: "Unknown AMD Radeon GPU" (ChipID =3D=
=20
0x9851)
[   147.564] (II) Loading sub module "fb"
[   147.564] (II) LoadModule: "fb"
[   147.565] (II) Loading /usr/lib64/xorg/modules/libfb.so
[   147.565] (II) Module fb: vendor=3D"X.Org Foundation"
[   147.565] 	compiled for 1.20.3, module version =3D 1.0.0
[   147.565] 	ABI class: X.Org ANSI C Emulation, version 0.4
[   147.565] (II) Loading sub module "dri2"
[   147.565] (II) LoadModule: "dri2"
[   147.565] (II) Module "dri2" already built-in
[   147.722] (II) Loading sub module "glamoregl"
[   147.722] (II) LoadModule: "glamoregl"
[   147.722] (II) Loading /usr/lib64/xorg/modules/libglamoregl.so
[   147.736] (II) Module glamoregl: vendor=3D"X.Org Foundation"
[   147.736] 	compiled for 1.20.3, module version =3D 1.0.1
[   147.736] 	ABI class: X.Org ANSI C Emulation, version 0.4
[   147.755] (II) AMDGPU(0): glamor X acceleration enabled on AMD MULLINS (=
DRM=20
3.27.0, 4.20.0-rc3+, LLVM 7.0.0)
[   147.755] (II) AMDGPU(0): glamor detected, initialising EGL layer.
[   147.755] (=3D=3D) AMDGPU(0): TearFree property default: auto
[   147.755] (II) AMDGPU(0): KMS Pageflipping: enabled
[   147.756] (II) AMDGPU(0): Output eDP has no monitor section
[   147.757] (II) AMDGPU(0): Output HDMI-A-0 has no monitor section
[   147.779] (II) AMDGPU(0): EDID for output eDP
[   147.779] (II) AMDGPU(0): Manufacturer: LGD  Model: 468  Serial#: 0
[   147.779] (II) AMDGPU(0): Year: 2014  Week: 0
[   147.780] (II) AMDGPU(0): EDID Version: 1.4
[   147.780] (II) AMDGPU(0): Digital Display Input
[   147.780] (II) AMDGPU(0): 6 bits per channel
[   147.780] (II) AMDGPU(0): Digital interface is DisplayPort
[   147.780] (II) AMDGPU(0): Max Image Size [cm]: horiz.: 34  vert.: 19
[   147.780] (II) AMDGPU(0): Gamma: 2.20
[   147.780] (II) AMDGPU(0): DPMS capabilities: StandBy Suspend Off
[   147.780] (II) AMDGPU(0): Supported color encodings: RGB 4:4:4 YCrCb 4:4=
:4=20
[   147.780] (II) AMDGPU(0): First detailed timing is preferred mode
[   147.780] (II) AMDGPU(0): Preferred mode is native pixel format and refr=
esh=20
rate
[   147.780] (II) AMDGPU(0): redX: 0.578 redY: 0.344   greenX: 0.337 greenY=
:=20
0.571
[   147.780] (II) AMDGPU(0): blueX: 0.159 blueY: 0.120   whiteX: 0.313 whit=
eY:=20
0.329
[   147.780] (II) AMDGPU(0): Manufacturer's mask: 0
[   147.780] (II) AMDGPU(0): Supported detailed timing:
[   147.780] (II) AMDGPU(0): clock: 76.3 MHz   Image Size:  344 x 194 mm
[   147.780] (II) AMDGPU(0): h_active: 1366  h_sync: 1414  h_sync_end 1446=
=20
h_blank_end 1610 h_border: 0
[   147.780] (II) AMDGPU(0): v_active: 768  v_sync: 771  v_sync_end 776=20
v_blanking: 790 v_border: 0
[   147.780] (II) AMDGPU(0):  LG Display
[   147.780] (II) AMDGPU(0):  LP156WHB-TPC1
[   147.780] (II) AMDGPU(0): EDID (in hex):
[   147.780] (II) AMDGPU(0): 	00ffffffffffff0030e4680400000000
[   147.781] (II) AMDGPU(0): 	0018010495221378ea05f59458569228
[   147.781] (II) AMDGPU(0): 	1e505400000001010101010101010101
[   147.781] (II) AMDGPU(0): 	010101010101d01d56f4500016303020
[   147.781] (II) AMDGPU(0): 	350058c2100000190000000000000000
[   147.781] (II) AMDGPU(0): 	00000000000000000000000000fe004c
[   147.781] (II) AMDGPU(0): 	4720446973706c61790a2020000000fe
[   147.781] (II) AMDGPU(0): 	004c503135365748422d5450433100b3
[   147.781] (II) AMDGPU(0): Printing probed modes for output eDP
[   147.781] (II) AMDGPU(0): Modeline "1366x768"x60.0   76.32  1366 1414 14=
46=20
1610  768 771 776 790 -hsync -vsync (47.4 kHz eP)
[   147.781] (II) AMDGPU(0): Modeline "1280x720"x60.0   76.32  1280 1414 14=
46=20
1610  720 771 776 790 -hsync -vsync (47.4 kHz e)
[   147.781] (II) AMDGPU(0): Modeline "1024x768"x60.0   76.32  1024 1414 14=
46=20
1610  768 771 776 790 -hsync -vsync (47.4 kHz e)
[   147.781] (II) AMDGPU(0): Modeline "800x600"x60.0   76.32  800 1414 1446=
=20
1610  600 771 776 790 -hsync -vsync (47.4 kHz e)
[   147.781] (II) AMDGPU(0): Modeline "640x480"x60.0   76.32  640 1414 1446=
=20
1610  480 771 776 790 -hsync -vsync (47.4 kHz e)
[   147.783] (II) AMDGPU(0): EDID for output HDMI-A-0
[   147.783] (II) AMDGPU(0): Manufacturer: PHL  Model: c00b  Serial#: 69075
[   147.783] (II) AMDGPU(0): Year: 2005  Week: 29
[   147.783] (II) AMDGPU(0): EDID Version: 1.3
[   147.783] (II) AMDGPU(0): Digital Display Input
[   147.783] (II) AMDGPU(0): Max Image Size [cm]: horiz.: 34  vert.: 27
[   147.783] (II) AMDGPU(0): Gamma: 2.20
[   147.783] (II) AMDGPU(0): DPMS capabilities: StandBy Suspend Off
[   147.783] (II) AMDGPU(0): Supported color encodings: RGB 4:4:4 YCrCb 4:4=
:4=20
[   147.783] (II) AMDGPU(0): Default color space is primary color space
[   147.783] (II) AMDGPU(0): First detailed timing is preferred mode
[   147.783] (II) AMDGPU(0): redX: 0.637 redY: 0.340   greenX: 0.300 greenY=
:=20
0.598
[   147.783] (II) AMDGPU(0): blueX: 0.143 blueY: 0.086   whiteX: 0.313 whit=
eY:=20
0.329
[   147.784] (II) AMDGPU(0): Supported established timings:
[   147.784] (II) AMDGPU(0): 720x400@70Hz
[   147.784] (II) AMDGPU(0): 640x480@60Hz
[   147.784] (II) AMDGPU(0): 640x480@67Hz
[   147.784] (II) AMDGPU(0): 640x480@72Hz
[   147.784] (II) AMDGPU(0): 640x480@75Hz
[   147.784] (II) AMDGPU(0): 800x600@56Hz
[   147.784] (II) AMDGPU(0): 800x600@60Hz
[   147.784] (II) AMDGPU(0): 800x600@72Hz
[   147.784] (II) AMDGPU(0): 800x600@75Hz
[   147.784] (II) AMDGPU(0): 832x624@75Hz
[   147.784] (II) AMDGPU(0): 1024x768@60Hz
[   147.784] (II) AMDGPU(0): 1024x768@70Hz
[   147.784] (II) AMDGPU(0): 1024x768@75Hz
[   147.784] (II) AMDGPU(0): 1280x1024@75Hz
[   147.784] (II) AMDGPU(0): 1152x864@75Hz
[   147.784] (II) AMDGPU(0): Manufacturer's mask: 0
[   147.784] (II) AMDGPU(0): Supported standard timings:
[   147.784] (II) AMDGPU(0): #0: hsize: 1152  vsize 864  refresh: 70  vid:=
=20
19057
[   147.784] (II) AMDGPU(0): #1: hsize: 1152  vsize 864  refresh: 75  vid:=
=20
20337
[   147.784] (II) AMDGPU(0): #2: hsize: 1280  vsize 960  refresh: 60  vid:=
=20
16513
[   147.784] (II) AMDGPU(0): #3: hsize: 1280  vsize 1024  refresh: 60  vid:=
=20
32897
[   147.784] (II) AMDGPU(0): Supported detailed timing:
[   147.784] (II) AMDGPU(0): clock: 108.0 MHz   Image Size:  338 x 270 mm
[   147.784] (II) AMDGPU(0): h_active: 1280  h_sync: 1328  h_sync_end 1440=
=20
h_blank_end 1688 h_border: 0
[   147.784] (II) AMDGPU(0): v_active: 1024  v_sync: 1025  v_sync_end 1028=
=20
v_blanking: 1066 v_border: 0
[   147.784] (II) AMDGPU(0): Serial No:  VN  069075
[   147.784] (II) AMDGPU(0): Monitor name: Philips 170C5
[   147.784] (II) AMDGPU(0): Ranges: V min: 56 V max: 76 Hz, H min: 30 H ma=
x:=20
82 kHz, PixClock max 145 MHz
[   147.785] (II) AMDGPU(0): Supported detailed timing:
[   147.785] (II) AMDGPU(0): clock: 27.0 MHz   Image Size:  160 x 90 mm
[   147.785] (II) AMDGPU(0): h_active: 720  h_sync: 736  h_sync_end 798=20
h_blank_end 858 h_border: 0
[   147.785] (II) AMDGPU(0): v_active: 480  v_sync: 489  v_sync_end 495=20
v_blanking: 525 v_border: 0
[   147.785] (II) AMDGPU(0): Number of EDID sections to follow: 1
[   147.785] (II) AMDGPU(0): EDID (in hex):
[   147.785] (II) AMDGPU(0): 	00ffffffffffff00410c0bc0d30d0100
[   147.785] (II) AMDGPU(0): 	1d0f010380221b78ee0c85a3574c9924
[   147.785] (II) AMDGPU(0): 	165054bfef80714a714f814081800101
[   147.785] (II) AMDGPU(0): 	010101010101302a009851002a403070
[   147.785] (II) AMDGPU(0): 	1300520e1100001e000000ff0020564e
[   147.785] (II) AMDGPU(0): 	20203036393037350a20000000fc0050
[   147.785] (II) AMDGPU(0): 	68696c697073203137304335000000fd
[   147.785] (II) AMDGPU(0): 	00384c1e520e000a20202020202001d3
[   147.785] (II) AMDGPU(0): 	02031b61230907078301000067030c00
[   147.785] (II) AMDGPU(0): 	2000802d43908402e2000f8c0ad08a20
[   147.785] (II) AMDGPU(0): 	e02d10103e9600a05a00000000000000
[   147.785] (II) AMDGPU(0): 	00000000000000000000000000000000
[   147.785] (II) AMDGPU(0): 	00000000000000000000000000000000
[   147.785] (II) AMDGPU(0): 	00000000000000000000000000000000
[   147.785] (II) AMDGPU(0): 	00000000000000000000000000000000
[   147.785] (II) AMDGPU(0): 	00000000000000000000000000000029
[   147.785] (--) AMDGPU(0): HDMI max TMDS frequency 225000KHz
[   147.786] (II) AMDGPU(0): Printing probed modes for output HDMI-A-0
[   147.786] (II) AMDGPU(0): Modeline "1280x1024"x60.0  108.00  1280 1328 1=
440=20
1688  1024 1025 1028 1066 +hsync +vsync (64.0 kHz eP)
[   147.786] (II) AMDGPU(0): Modeline "1920x1080"x60.0  148.50  1920 2008 2=
052=20
2200  1080 1084 1089 1125 +hsync +vsync (67.5 kHz e)
[   147.786] (II) AMDGPU(0): Modeline "1920x1080"x59.9  148.35  1920 2008 2=
052=20
2200  1080 1084 1089 1125 +hsync +vsync (67.4 kHz e)
[   147.786] (II) AMDGPU(0): Modeline "1280x1024"x75.0  135.00  1280 1296 1=
440=20
1688  1024 1025 1028 1066 +hsync +vsync (80.0 kHz e)
[   147.786] (II) AMDGPU(0): Modeline "1280x960"x60.0  108.00  1280 1376 14=
88=20
1800  960 961 964 1000 +hsync +vsync (60.0 kHz e)
[   147.786] (II) AMDGPU(0): Modeline "1280x800"x60.0  108.00  1280 1328 14=
40=20
1688  800 1025 1028 1066 +hsync +vsync (64.0 kHz e)
[   147.786] (II) AMDGPU(0): Modeline "1152x864"x75.0  108.00  1152 1216 13=
44=20
1600  864 865 868 900 +hsync +vsync (67.5 kHz e)
[   147.786] (II) AMDGPU(0): Modeline "1152x864"x70.0   96.73  1152 1224 13=
44=20
1536  864 865 868 900 -hsync +vsync (63.0 kHz)
[   147.786] (II) AMDGPU(0): Modeline "1280x720"x60.0   74.25  1280 1390 14=
30=20
1650  720 725 730 750 +hsync +vsync (45.0 kHz e)
[   147.786] (II) AMDGPU(0): Modeline "1280x720"x59.9   74.18  1280 1390 14=
30=20
1650  720 725 730 750 +hsync +vsync (45.0 kHz e)
[   147.786] (II) AMDGPU(0): Modeline "1024x768"x75.0   78.75  1024 1040 11=
36=20
1312  768 769 772 800 +hsync +vsync (60.0 kHz e)
[   147.786] (II) AMDGPU(0): Modeline "1024x768"x70.1   75.00  1024 1048 11=
84=20
1328  768 771 777 806 -hsync -vsync (56.5 kHz e)
[   147.786] (II) AMDGPU(0): Modeline "1024x768"x60.0   65.00  1024 1048 11=
84=20
1344  768 771 777 806 -hsync -vsync (48.4 kHz e)
[   147.786] (II) AMDGPU(0): Modeline "832x624"x74.6   57.28  832 864 928 1=
152 =20
624 625 628 667 -hsync -vsync (49.7 kHz e)
[   147.786] (II) AMDGPU(0): Modeline "800x600"x72.2   50.00  800 856 976 1=
040 =20
600 637 643 666 +hsync +vsync (48.1 kHz e)
[   147.786] (II) AMDGPU(0): Modeline "800x600"x75.0   49.50  800 816 896 1=
056 =20
600 601 604 625 +hsync +vsync (46.9 kHz e)
[   147.786] (II) AMDGPU(0): Modeline "800x600"x60.3   40.00  800 840 968 1=
056 =20
600 601 605 628 +hsync +vsync (37.9 kHz e)
[   147.786] (II) AMDGPU(0): Modeline "800x600"x56.2   36.00  800 824 896 1=
024 =20
600 601 603 625 +hsync +vsync (35.2 kHz e)
[   147.786] (II) AMDGPU(0): Modeline "720x480"x60.0   27.03  720 736 798 8=
58 =20
480 489 495 525 -hsync -vsync (31.5 kHz e)
[   147.786] (II) AMDGPU(0): Modeline "720x480"x59.9   27.00  720 736 798 8=
58 =20
480 489 495 525 -hsync -vsync (31.5 kHz e)
[   147.787] (II) AMDGPU(0): Modeline "640x480"x75.0   31.50  640 656 720 8=
40 =20
480 481 484 500 -hsync -vsync (37.5 kHz e)
[   147.787] (II) AMDGPU(0): Modeline "640x480"x72.8   31.50  640 664 704 8=
32 =20
480 489 492 520 -hsync -vsync (37.9 kHz e)
[   147.787] (II) AMDGPU(0): Modeline "640x480"x66.7   30.24  640 704 768 8=
64 =20
480 483 486 525 -hsync -vsync (35.0 kHz e)
[   147.787] (II) AMDGPU(0): Modeline "640x480"x60.0   25.20  640 656 752 8=
00 =20
480 490 492 525 -hsync -vsync (31.5 kHz e)
[   147.787] (II) AMDGPU(0): Modeline "640x480"x59.9   25.18  640 656 752 8=
00 =20
480 490 492 525 -hsync -vsync (31.5 kHz e)
[   147.787] (II) AMDGPU(0): Modeline "720x400"x70.1   28.32  720 738 846 9=
00 =20
400 412 414 449 -hsync +vsync (31.5 kHz e)
[   147.787] (II) AMDGPU(0): Output eDP connected
[   147.787] (II) AMDGPU(0): Output HDMI-A-0 connected
[   147.787] (II) AMDGPU(0): Using spanning desktop for initial modes
[   147.787] (II) AMDGPU(0): Output eDP using initial mode 1366x768 +0+0
[   147.787] (II) AMDGPU(0): Output HDMI-A-0 using initial mode 1280x1024=20
+1366+0
[   147.787] (II) AMDGPU(0): mem size init: gart size :bfece000 vram size: =
s:
3f695000 visible:3f695000
[   147.787] (=3D=3D) AMDGPU(0): DPI set to (96, 96)
[   147.787] (=3D=3D) AMDGPU(0): Using gamma correction (1.0, 1.0, 1.0)
[   147.787] (II) Loading sub module "ramdac"
[   147.787] (II) LoadModule: "ramdac"
[   147.787] (II) Module "ramdac" already built-in
[   147.787] (II) UnloadModule: "modesetting"
[   147.787] (II) Unloading modesetting
[   147.788] (II) AMDGPU(0): [DRI2] Setup complete
[   147.788] (II) AMDGPU(0): [DRI2]   DRI driver: radeonsi
[   147.788] (II) AMDGPU(0): [DRI2]   VDPAU driver: radeonsi
[   147.788] (II) AMDGPU(0): Front buffer pitch: 10624 bytes
[   147.788] (II) AMDGPU(0): SYNC extension fences enabled
[   147.788] (II) AMDGPU(0): Present extension enabled
[   147.789] (=3D=3D) AMDGPU(0): DRI3 enabled
[   147.789] (=3D=3D) AMDGPU(0): Backing store enabled
[   147.789] (II) AMDGPU(0): Direct rendering enabled
[   147.793] (II) AMDGPU(0): Use GLAMOR acceleration.
[   147.793] (II) AMDGPU(0): Acceleration enabled
[   147.793] (=3D=3D) AMDGPU(0): DPMS enabled
[   147.793] (=3D=3D) AMDGPU(0): Silken mouse enabled
[   147.793] (II) AMDGPU(0): Set up textured video (glamor)
[   147.829] (II) Initializing extension Generic Event Extension
[   147.829] (II) Initializing extension SHAPE
[   147.829] (II) Initializing extension MIT-SHM
[   147.829] (II) Initializing extension XInputExtension
[   147.829] (II) Initializing extension XTEST
[   147.829] (II) Initializing extension BIG-REQUESTS
[   147.829] (II) Initializing extension SYNC
[   147.829] (II) Initializing extension XKEYBOARD
[   147.829] (II) Initializing extension XC-MISC
[   147.830] (II) Initializing extension XFIXES
[   147.830] (II) Initializing extension RENDER
[   147.830] (II) Initializing extension RANDR
[   147.830] (II) Initializing extension COMPOSITE
[   147.830] (II) Initializing extension DAMAGE
[   147.830] (II) Initializing extension MIT-SCREEN-SAVER
[   147.830] (II) Initializing extension DOUBLE-BUFFER
[   147.830] (II) Initializing extension RECORD
[   147.830] (II) Initializing extension DPMS
[   147.830] (II) Initializing extension Present
[   147.830] (II) Initializing extension DRI3
[   147.830] (II) Initializing extension X-Resource
[   147.830] (II) Initializing extension XVideo
[   147.830] (II) Initializing extension XVideo-MotionCompensation
[   147.830] (II) Initializing extension GLX
[   147.842] (II) AIGLX: Loaded and initialized radeonsi
[   147.842] (II) GLX: Initialized DRI2 GL provider for screen 0
[   147.842] (II) Initializing extension XFree86-VidModeExtension
[   147.842] (II) Initializing extension XFree86-DGA
[   147.842] (II) Initializing extension XFree86-DRI
[   147.842] (II) Initializing extension DRI2
[   147.844] (II) AMDGPU(0): Setting screen physical size to 700 x 270
[   147.845] (EE)=20
[   147.845] (EE) Backtrace:
[   147.845] (EE) 0: /usr/bin/X (xorg_backtrace+0x4d) [0x55efcb86f0bd]
[   147.845] (EE) 1: /usr/bin/X (0x55efcb6c6000+0x1acc89) [0x55efcb872c89]
[   147.845] (EE) 2: /lib64/libpthread.so.0 (0x7fc4e3552000+0x14560)=20
[0x7fc4e3566560]
[   147.845] (EE) 3: /usr/lib64/xorg/modules/drivers/amdgpu_drv.so=20
(0x7fc4e3ad0000+0x14fce) [0x7fc4e3ae4fce]
[   147.845] (EE) 4: /usr/lib64/xorg/modules/drivers/amdgpu_drv.so=20
(0x7fc4e3ad0000+0xd1c4) [0x7fc4e3add1c4]
[   147.845] (EE) 5: /usr/bin/X (0x55efcb6c6000+0xdf024) [0x55efcb7a5024]
[   147.845] (EE) 6: /usr/bin/X (InitRootWindow+0x11) [0x55efcb748761]
[   147.846] (EE) 7: /usr/bin/X (0x55efcb6c6000+0x5b574) [0x55efcb721574]
[   147.846] (EE) 8: /lib64/libc.so.6 (__libc_start_main+0xee)=20
[0x7fc4e33aa4ce]
[   147.846] (EE) 9: /usr/bin/X (_start+0x2a) [0x55efcb70b00a]
[   147.846] (EE)=20
[   147.846] (EE) Segmentation fault at address 0x4
[   147.846] (EE)=20
=46atal server error:
[   147.846] (EE) Caught signal 11 (Segmentation fault). Server aborting
[   147.846] (EE)=20
[   147.846] (EE)=20
Please consult the The X.Org Foundation support=20
	 at http://wiki.x.org
 for help.=20
[   147.846] (EE) Please also check the log file at "/var/log/Xorg.0.log" f=
or=20
additional information.
[   147.846] (EE)=20
[   147.846] (II) AIGLX: Suspending AIGLX clients for VT switch
[   147.920] (EE) Server terminated with error (1). Closing log file."

Thanks,
Przemek.
--nextPart2564753.EKTGQ9l1mP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE2zcce+zboy/je1pmPMstj1lsVJMFAlw3h04ACgkQPMstj1ls
VJN/6A/+LIWEgUkeAnQ2iXMJ0j+CIaQpGDybv9KQDvmv9YI425U4P9qtb+lIYpf1
an2oLNsweB/wXcq2cVuu/N4pxe8wxQPJUYiZ0zDhtosid1IIWRGul7NBgGlZFBOQ
mNDEeNvmGF+TpDZOP6TLLgK6NjlRveok2/suqlnVG3z46FfizeoGPV73d/n2OP1C
1KTH/zD4kpu73TKtu/uXT6HHHvi64f2CcYnsozZwADA9tSqa+qlbWvsMPHDVb+0q
C/1MbMqbY4xa4/hcPJdy1f8U9u0+ale+Q49XNlkidvBuceNDZIDpZZeY4hMWmL1o
89mhrUqlXlL9LEETucJMx8c5O/fpLT2vVxwyOb6E+wR+10brgwBj8myN/8ziyCsA
GhdQcvwWQ2cMyAeveCkeFvv1U1NZ5XLsVh4ZK9/94ik8AU9DXxG4CyQosIvWl8Y/
tUyWi9kF5ct703OmqbXvhY+LH6Z+KJupO2mLtB+Vbrcu7ttxyN/syZ5IPxLEQvvw
QrKZcSO08WIxe2TsSlGTgSChl1qBUvRka11yzFKxbfas1muTjdhGhjv2yxCsnaOA
Oy9PWAw0C4cHPEVJPoaw+D1YJTMuLhbLGTu5vQJpRVrm29CRcHcnyeI6wL7pXqVf
hx1cgse0fzOxRtpWqIfyZ7+OxXh+VxSCt34rjg6X7BjPvAGclxg=
=NN0p
-----END PGP SIGNATURE-----

--nextPart2564753.EKTGQ9l1mP--




--===============1563786928==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1563786928==--
