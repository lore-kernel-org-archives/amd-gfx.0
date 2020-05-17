Return-Path: <SRS0=zeZE=67=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606A9C433DF
	for <amd-gfx@archiver.kernel.org>; Sun, 17 May 2020 20:51:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 337AB206F4
	for <amd-gfx@archiver.kernel.org>; Sun, 17 May 2020 20:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T69MYByO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 337AB206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F03016E131;
	Sun, 17 May 2020 20:51:22 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD7A96E131
 for <amd-gfx@lists.freedesktop.org>; Sun, 17 May 2020 20:51:21 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id w22so6389766otp.5
 for <amd-gfx@lists.freedesktop.org>; Sun, 17 May 2020 13:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=OHwlnDTVmv+uEyI86ttvTZcujyEu8I4LwQxvAg+wgww=;
 b=T69MYByOWhwOHUOWcvXSI4Cti1i3hVr183gExhOOBUImKw/6VKT9hxnVUjKDcCBUmT
 9bJVlEw8tDT9KaX+ruAdn45/wdTQ7nj9M1VBsjjD1nTn/e3e+xEF065gmcLh1xtIxHC+
 MML6sKthV4TkhSaGJu9eCrUmhwvejr0fcKx8VKLP1dhVPuVjIdW/HQpNv6QPDqC0hWcD
 35XVgPGgw0demljWW3HqedIBPH716w16nxbsAQKduEjbGQFM3Gzr+cLCIimI7bZYlD1l
 bkXTsJfXYRnAkkMRIcvnNzjnerKGU694xUMEaRMkaazH2fuRYwLMAKubP8y/qvkGutM7
 JYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=OHwlnDTVmv+uEyI86ttvTZcujyEu8I4LwQxvAg+wgww=;
 b=Nzo2QD83JwhinumP1evvtKTsxStdpZOLYyqCBWpsF++6WuXG1Gmc0S1rB2cGXMlO/S
 Xu/qcXAmyj81rBodgNmQwI+3JG+l1LqBx49tUqlg/Dy6qSf3uZQRPnA7Xe6bgynyaTKn
 wUUJVuQmIAUB2NDNyt9qh+yz9NSZfO3xn3ObMzzYTFUIoAb9VCz1A8AP2l+9uZhs4h5e
 2hypo5j6Jznu3bsJ32mT6aGvBXL1tcGE71/KDxKBjuD3ZAjEhJGB4cZ0NSVII1gl/pjJ
 Fs4htVosbhiSfBRUSCB9eSgGcUIv0rbel0vAx6hKqNrw6SmFqJZ/0lx+1Rf1MGiJc/xX
 8Asg==
X-Gm-Message-State: AOAM531/H+c2prrREKWLFPe8QoEpML30ZJYmd3A1cfpBqPo9mFSYulvn
 l/txwdfLCSPrBrcDY3opVd4yuQwXbetl7m8sttRzAjIk55M=
X-Google-Smtp-Source: ABdhPJywxP2vwg1nSIU7GVx5PmfW9KUuZEN2of3jm7vHYDWQj5F3BHJr13cKuSw9oG7rfn/z3fNIdQafgKz2G58ISDM=
X-Received: by 2002:a9d:ec3:: with SMTP id 61mr10215670otj.286.1589748680446; 
 Sun, 17 May 2020 13:51:20 -0700 (PDT)
MIME-Version: 1.0
From: Javad Karabi <karabijavad@gmail.com>
Date: Sun, 17 May 2020 15:51:09 -0500
Message-ID: <CAEOHGOnvFxBtFixhVWtO=Mx3t2-0YYJM8pHD_FaKhQRTkjJjTw@mail.gmail.com>
Subject: XFX RX 5600 XT Raw II graphics card slow
To: amd-gfx@lists.freedesktop.org
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1084804633=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1084804633==
Content-Type: multipart/alternative; boundary="00000000000061569805a5de357d"

--00000000000061569805a5de357d
Content-Type: text/plain; charset="UTF-8"

Heres my setup:

kernel: linux-5.6.13
card: XFX RX 5600 XT Raw II  (
https://www.bestbuy.com/site/xfx-amd-radeon-rx-5600-xt-raw-ii-pro-6gb-gddr6-pci-express-4-0-graphics-card/6398005.p?skuId=6398005
)

x1 carbon 7th gen -thunderbolt-> Razer Core X -> rx 5600 xt -> hdmi
connection to my monitor (asus mg248)

when i boot into windows, the card works totally fine (installed the radeon
drivers and everything)

when im in linux, the card works, my monitor works, radeontop shows the gpu
being used when i run DRI_PRIME=1 glxgears, etc etc, so it seems that the
card is being properly utilized by everything.

one interesting detail: when i install the kernel, update-initramfs reports
that there is "possibly missing firmware". i dont see any errors in dmesg
about missing firmware so im assuming thats not a problem?

problem is, its very low fps. for example, heres my glxinfo/glxgears output:

$ DRI_PRIME=0 glxgears
3148 frames in 5.0 seconds = 628.420 FPS
1950 frames in 5.0 seconds = 389.999 FPS
^C
$ DRI_PRIME=1 glxgears
755 frames in 5.0 seconds = 150.698 FPS
662 frames in 5.0 seconds = 132.296 FPS
^C
$ DRI_PRIME=0 glxinfo | grep vendor
server glx vendor string: SGI
client glx vendor string: Mesa Project and SGI
OpenGL vendor string: Intel
$ DRI_PRIME=1 glxinfo | grep vendor
server glx vendor string: SGI
client glx vendor string: Mesa Project and SGI
OpenGL vendor string: X.Org

$ dmesg | egrep -i "amdgpu|radeon"
[    4.798043] amdgpu: unknown parameter 'si_support' ignored
[    4.802600] amdgpu: unknown parameter 'cik_support' ignored
[    4.813305] [drm] amdgpu kernel modesetting enabled.
[    4.813449] amdgpu 0000:0c:00.0: enabling device (0000 -> 0003)
[    5.051950] amdgpu 0000:0c:00.0: VRAM: 6128M 0x0000008000000000 -
0x000000817EFFFFFF (6128M used)
[    5.051952] amdgpu 0000:0c:00.0: GART: 512M 0x0000000000000000 -
0x000000001FFFFFFF
[    5.052081] [drm] amdgpu: 6128M of VRAM memory ready
[    5.052084] [drm] amdgpu: 6128M of GTT memory ready.
[    6.125885] amdgpu 0000:0c:00.0: RAS: ras ta ucode is not available
[    6.131800] amdgpu: [powerplay] use vbios provided pptable
[    6.131973] amdgpu: [powerplay] smu driver if version = 0x00000033, smu
fw if version = 0x00000035, smu fw version = 0x002a3200 (42.50.0)
[    6.131979] amdgpu: [powerplay] SMU driver if version not matched
[    6.176170] amdgpu: [powerplay] SMU is initialized successfully!
[    6.298473] amdgpu 0000:0c:00.0: fb0: amdgpudrmfb frame buffer device
[    6.310927] amdgpu 0000:0c:00.0: ring gfx_0.0.0 uses VM inv eng 0 on hub
0
[    6.311158] amdgpu 0000:0c:00.0: ring comp_1.0.0 uses VM inv eng 1 on
hub 0
[    6.311401] amdgpu 0000:0c:00.0: ring comp_1.1.0 uses VM inv eng 4 on
hub 0
[    6.311648] amdgpu 0000:0c:00.0: ring comp_1.2.0 uses VM inv eng 5 on
hub 0
[    6.311904] amdgpu 0000:0c:00.0: ring comp_1.3.0 uses VM inv eng 6 on
hub 0
[    6.312133] amdgpu 0000:0c:00.0: ring comp_1.0.1 uses VM inv eng 7 on
hub 0
[    6.312376] amdgpu 0000:0c:00.0: ring comp_1.1.1 uses VM inv eng 8 on
hub 0
[    6.312619] amdgpu 0000:0c:00.0: ring comp_1.2.1 uses VM inv eng 9 on
hub 0
[    6.312863] amdgpu 0000:0c:00.0: ring comp_1.3.1 uses VM inv eng 10 on
hub 0
[    6.313110] amdgpu 0000:0c:00.0: ring kiq_2.1.0 uses VM inv eng 11 on
hub 0
[    6.313355] amdgpu 0000:0c:00.0: ring sdma0 uses VM inv eng 12 on hub 0
[    6.313585] amdgpu 0000:0c:00.0: ring sdma1 uses VM inv eng 13 on hub 0
[    6.313821] amdgpu 0000:0c:00.0: ring vcn_dec uses VM inv eng 0 on hub 1
[    6.314059] amdgpu 0000:0c:00.0: ring vcn_enc0 uses VM inv eng 1 on hub 1
[    6.314298] amdgpu 0000:0c:00.0: ring vcn_enc1 uses VM inv eng 4 on hub 1
[    6.314536] amdgpu 0000:0c:00.0: ring jpeg_dec uses VM inv eng 5 on hub 1
[    6.316101] [drm] Initialized amdgpu 3.36.0 20150101 for 0000:0c:00.0 on
minor 1
[   10.797203] snd_hda_intel 0000:0c:00.1: bound 0000:0c:00.0 (ops
amdgpu_dm_audio_component_bind_ops [amdgpu])

is this perhaps a power management issue?
i can include my kernel config and X logs etc if yall need.

--00000000000061569805a5de357d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Heres my setup:<div><br></div><div>kernel: linux-5.6.13</d=
iv><div>card: XFX RX 5600 XT Raw II=C2=A0 (<a href=3D"https://www.bestbuy.c=
om/site/xfx-amd-radeon-rx-5600-xt-raw-ii-pro-6gb-gddr6-pci-express-4-0-grap=
hics-card/6398005.p?skuId=3D6398005" target=3D"_blank">https://www.bestbuy.=
com/site/xfx-amd-radeon-rx-5600-xt-raw-ii-pro-6gb-gddr6-pci-express-4-0-gra=
phics-card/6398005.p?skuId=3D6398005</a>)<br></div><div><br></div><div>x1 c=
arbon 7th gen -thunderbolt-&gt; Razer Core X -&gt; rx 5600 xt -&gt; hdmi co=
nnection to my monitor (asus mg248)</div><div><br></div><div>when i boot in=
to windows, the card works totally fine (installed the radeon drivers and e=
verything)</div><div><br></div><div>when im in=C2=A0linux, the card works, =
my monitor works, radeontop shows the gpu being used when i run DRI_PRIME=
=3D1 glxgears, etc etc, so it seems that the card is being properly utilize=
d by everything.</div><div><br></div><div>one interesting detail: when i in=
stall the kernel, update-initramfs reports that there is &quot;possibly mis=
sing firmware&quot;. i dont see any errors in dmesg about missing firmware =
so im assuming thats not a problem?</div><div><br></div><div>problem is, it=
s very low fps. for example, heres my glxinfo/glxgears output:<br></div><di=
v><br></div><div>$ DRI_PRIME=3D0 glxgears<br>3148 frames in 5.0 seconds =3D=
 628.420 FPS<br>1950 frames in 5.0 seconds =3D 389.999 FPS<br>^C<br>$ DRI_P=
RIME=3D1 glxgears<br>755 frames in 5.0 seconds =3D 150.698 FPS<br>662 frame=
s in 5.0 seconds =3D 132.296 FPS<br>^C<br>$ DRI_PRIME=3D0 glxinfo | grep ve=
ndor <br>server glx vendor string: SGI<br>client glx vendor string: Mesa Pr=
oject and SGI<br>OpenGL vendor string: Intel<br>$ DRI_PRIME=3D1 glxinfo | g=
rep vendor<br>server glx vendor string: SGI<br>client glx vendor string: Me=
sa Project and SGI<br>OpenGL vendor string: X.Org<br></div><div><br></div><=
div>$ dmesg | egrep -i &quot;amdgpu|radeon&quot;<br>[ =C2=A0 =C2=A04.798043=
] amdgpu: unknown parameter &#39;si_support&#39; ignored<br>[ =C2=A0 =C2=A0=
4.802600] amdgpu: unknown parameter &#39;cik_support&#39; ignored<br>[ =C2=
=A0 =C2=A04.813305] [drm] amdgpu kernel modesetting enabled.<br>[ =C2=A0 =
=C2=A04.813449] amdgpu 0000:0c:00.0: enabling device (0000 -&gt; 0003)<br>[=
 =C2=A0 =C2=A05.051950] amdgpu 0000:0c:00.0: VRAM: 6128M 0x0000008000000000=
 - 0x000000817EFFFFFF (6128M used)<br>[ =C2=A0 =C2=A05.051952] amdgpu 0000:=
0c:00.0: GART: 512M 0x0000000000000000 - 0x000000001FFFFFFF<br>[ =C2=A0 =C2=
=A05.052081] [drm] amdgpu: 6128M of VRAM memory ready<br>[ =C2=A0 =C2=A05.0=
52084] [drm] amdgpu: 6128M of GTT memory ready.<br>[ =C2=A0 =C2=A06.125885]=
 amdgpu 0000:0c:00.0: RAS: ras ta ucode is not available<br>[ =C2=A0 =C2=A0=
6.131800] amdgpu: [powerplay] use vbios provided pptable<br>[ =C2=A0 =C2=A0=
6.131973] amdgpu: [powerplay] smu driver if version =3D 0x00000033, smu fw =
if version =3D 0x00000035, smu fw version =3D 0x002a3200 (42.50.0)<br>[ =C2=
=A0 =C2=A06.131979] amdgpu: [powerplay] SMU driver if version not matched<b=
r>[ =C2=A0 =C2=A06.176170] amdgpu: [powerplay] SMU is initialized successfu=
lly!<br>[ =C2=A0 =C2=A06.298473] amdgpu 0000:0c:00.0: fb0: amdgpudrmfb fram=
e buffer device<br>[ =C2=A0 =C2=A06.310927] amdgpu 0000:0c:00.0: ring gfx_0=
.0.0 uses VM inv eng 0 on hub 0<br>[ =C2=A0 =C2=A06.311158] amdgpu 0000:0c:=
00.0: ring comp_1.0.0 uses VM inv eng 1 on hub 0<br>[ =C2=A0 =C2=A06.311401=
] amdgpu 0000:0c:00.0: ring comp_1.1.0 uses VM inv eng 4 on hub 0<br>[ =C2=
=A0 =C2=A06.311648] amdgpu 0000:0c:00.0: ring comp_1.2.0 uses VM inv eng 5 =
on hub 0<br>[ =C2=A0 =C2=A06.311904] amdgpu 0000:0c:00.0: ring comp_1.3.0 u=
ses VM inv eng 6 on hub 0<br>[ =C2=A0 =C2=A06.312133] amdgpu 0000:0c:00.0: =
ring comp_1.0.1 uses VM inv eng 7 on hub 0<br>[ =C2=A0 =C2=A06.312376] amdg=
pu 0000:0c:00.0: ring comp_1.1.1 uses VM inv eng 8 on hub 0<br>[ =C2=A0 =C2=
=A06.312619] amdgpu 0000:0c:00.0: ring comp_1.2.1 uses VM inv eng 9 on hub =
0<br>[ =C2=A0 =C2=A06.312863] amdgpu 0000:0c:00.0: ring comp_1.3.1 uses VM =
inv eng 10 on hub 0<br>[ =C2=A0 =C2=A06.313110] amdgpu 0000:0c:00.0: ring k=
iq_2.1.0 uses VM inv eng 11 on hub 0<br>[ =C2=A0 =C2=A06.313355] amdgpu 000=
0:0c:00.0: ring sdma0 uses VM inv eng 12 on hub 0<br>[ =C2=A0 =C2=A06.31358=
5] amdgpu 0000:0c:00.0: ring sdma1 uses VM inv eng 13 on hub 0<br>[ =C2=A0 =
=C2=A06.313821] amdgpu 0000:0c:00.0: ring vcn_dec uses VM inv eng 0 on hub =
1<br>[ =C2=A0 =C2=A06.314059] amdgpu 0000:0c:00.0: ring vcn_enc0 uses VM in=
v eng 1 on hub 1<br>[ =C2=A0 =C2=A06.314298] amdgpu 0000:0c:00.0: ring vcn_=
enc1 uses VM inv eng 4 on hub 1<br>[ =C2=A0 =C2=A06.314536] amdgpu 0000:0c:=
00.0: ring jpeg_dec uses VM inv eng 5 on hub 1<br>[ =C2=A0 =C2=A06.316101] =
[drm] Initialized amdgpu 3.36.0 20150101 for 0000:0c:00.0 on minor 1<br>[ =
=C2=A0 10.797203] snd_hda_intel 0000:0c:00.1: bound 0000:0c:00.0 (ops amdgp=
u_dm_audio_component_bind_ops [amdgpu])<br></div><div><br></div><div>is thi=
s perhaps a power management issue?</div><div>i can include my kernel confi=
g and X logs etc if yall need.</div><div><br></div></div>

--00000000000061569805a5de357d--

--===============1084804633==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1084804633==--
