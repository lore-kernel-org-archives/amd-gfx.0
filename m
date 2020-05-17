Return-Path: <SRS0=zeZE=67=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666B3C433DF
	for <amd-gfx@archiver.kernel.org>; Sun, 17 May 2020 21:02:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A61B207D3
	for <amd-gfx@archiver.kernel.org>; Sun, 17 May 2020 21:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Effvruag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A61B207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C88A6E0AC;
	Sun, 17 May 2020 21:02:43 +0000 (UTC)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C4DD6E0AC
 for <amd-gfx@lists.freedesktop.org>; Sun, 17 May 2020 21:02:42 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id z3so4731172otp.9
 for <amd-gfx@lists.freedesktop.org>; Sun, 17 May 2020 14:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=JadtpPLqFxanXaGHWdFWt86o/pCv+E5woPLAZWyNajc=;
 b=EffvruagWVcfOY8ZfCYJ/uco/c7oxFUf23vTfYBN95vurjrV9g5VuZDrZCzUncq3Pc
 3PPBgs36uNC0et8M62BNeGoPLLwh03Ju508K1n1zfy6nIpuZBZeh/qwjt7XjE8sHDow+
 Ax4X5KL2Hv6enDm2ELjJgjMTcyvZwfN9zu5yMXKRwjHxsqjgjDUKWCfdd1Gm48KKPsAW
 o6ggrp0NKaWGaT1CZnegb6+VuZgolaTPJGhydUUAjRs+BOxbv061N/T4Fh9L1fSZJKFE
 H0Z9Esmx8lk3B+0e8A8bLIKhPeFmgIFcWFi2IUKypn380nTp+ey71toofqaUJDwP0U2h
 rkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=JadtpPLqFxanXaGHWdFWt86o/pCv+E5woPLAZWyNajc=;
 b=pBGGTbrQjrq8VW1hefV8FrdJk6Z7Vyu7ndjHADBCFngN/q95G8tkStl4yUEHdUj0C8
 MRS9E435jyFM8E0PhyV1HJkDPWA2zq420v5xL9DGOGfYTppqypzwG/GxNagfedTuYcgh
 83TuVuFZGZ7KgvX4ZNBP9oQhGrwYHUNo/C3xKlSmE3JIErVsFV3TUQP/W5hQnMitTicP
 /+UlnunUixrOqPYB99wprOOyZm3KguiW5d3AuP6eu6hbIwmSG9wZeir4AlvOvhH5tKzp
 1Psp1Y/S0eUnGYZDZTLzVO8VSVPdyREPq0n+bM9U1RfcTfJPyTxdgByg/YrDZG6DeSHU
 zb9w==
X-Gm-Message-State: AOAM5323IeAfU6KhrceGzOw8+QDiY8cEbcNyOz+Ir6U6Vqn+3n8SsM1V
 6Cs71IKhm+zYq7IKlqkktGTWMgNdG4nsOhgFyGGHt4hmow8=
X-Google-Smtp-Source: ABdhPJzhuKN6XBhNvNKf2y6yrFv3hq1nQRFMHZsrBuCHmQwmIV6YX2XzVPpE1GyFmM0BzsrRIWy9n66QoYa6xqQfZiU=
X-Received: by 2002:a9d:6352:: with SMTP id y18mr10822496otk.4.1589749361147; 
 Sun, 17 May 2020 14:02:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAEOHGOnvFxBtFixhVWtO=Mx3t2-0YYJM8pHD_FaKhQRTkjJjTw@mail.gmail.com>
In-Reply-To: <CAEOHGOnvFxBtFixhVWtO=Mx3t2-0YYJM8pHD_FaKhQRTkjJjTw@mail.gmail.com>
From: Javad Karabi <karabijavad@gmail.com>
Date: Sun, 17 May 2020 16:02:29 -0500
Message-ID: <CAEOHGOkqs3qicXrT_wWZEbedXoT2Mp884aMSLEDBBYKDWbdnKg@mail.gmail.com>
Subject: Re: XFX RX 5600 XT Raw II graphics card slow
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
Content-Type: multipart/mixed; boundary="===============0525556006=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0525556006==
Content-Type: multipart/alternative; boundary="000000000000f4068905a5de5df6"

--000000000000f4068905a5de5df6
Content-Type: text/plain; charset="UTF-8"

oh, i also flashed the card bios with the bios provided at:
https://www.xfxforce.com/gpus/xfx-amd-radeon-tm-rx-5600-xt-6gb-gddr6-raw-ii

if you scroll down a bit and click on downloads, they have a link to a
"performance bios". i flashed that, and nothing changed. after the flash,
the card still worked great in windows, and still terrible in linux. so i
guess that flash didnt change anything.

also, fyi i do have the latest linux-firmware installed (since apparently
there was some issue with the firmware for the rx 5600 which was solved in
the latest firmware i guess)

$ md5sum /lib/firmware/amdgpu/navi10_smc.bin
632de739379e484c0233f6808cba2c7f  /lib/firmware/amdgpu/navi10_smc.bin

On Sun, May 17, 2020 at 3:51 PM Javad Karabi <karabijavad@gmail.com> wrote:

> Heres my setup:
>
> kernel: linux-5.6.13
> card: XFX RX 5600 XT Raw II  (
> https://www.bestbuy.com/site/xfx-amd-radeon-rx-5600-xt-raw-ii-pro-6gb-gddr6-pci-express-4-0-graphics-card/6398005.p?skuId=6398005
> )
>
> x1 carbon 7th gen -thunderbolt-> Razer Core X -> rx 5600 xt -> hdmi
> connection to my monitor (asus mg248)
>
> when i boot into windows, the card works totally fine (installed the
> radeon drivers and everything)
>
> when im in linux, the card works, my monitor works, radeontop shows the
> gpu being used when i run DRI_PRIME=1 glxgears, etc etc, so it seems that
> the card is being properly utilized by everything.
>
> one interesting detail: when i install the kernel, update-initramfs
> reports that there is "possibly missing firmware". i dont see any errors in
> dmesg about missing firmware so im assuming thats not a problem?
>
> problem is, its very low fps. for example, heres my glxinfo/glxgears
> output:
>
> $ DRI_PRIME=0 glxgears
> 3148 frames in 5.0 seconds = 628.420 FPS
> 1950 frames in 5.0 seconds = 389.999 FPS
> ^C
> $ DRI_PRIME=1 glxgears
> 755 frames in 5.0 seconds = 150.698 FPS
> 662 frames in 5.0 seconds = 132.296 FPS
> ^C
> $ DRI_PRIME=0 glxinfo | grep vendor
> server glx vendor string: SGI
> client glx vendor string: Mesa Project and SGI
> OpenGL vendor string: Intel
> $ DRI_PRIME=1 glxinfo | grep vendor
> server glx vendor string: SGI
> client glx vendor string: Mesa Project and SGI
> OpenGL vendor string: X.Org
>
> $ dmesg | egrep -i "amdgpu|radeon"
> [    4.798043] amdgpu: unknown parameter 'si_support' ignored
> [    4.802600] amdgpu: unknown parameter 'cik_support' ignored
> [    4.813305] [drm] amdgpu kernel modesetting enabled.
> [    4.813449] amdgpu 0000:0c:00.0: enabling device (0000 -> 0003)
> [    5.051950] amdgpu 0000:0c:00.0: VRAM: 6128M 0x0000008000000000 -
> 0x000000817EFFFFFF (6128M used)
> [    5.051952] amdgpu 0000:0c:00.0: GART: 512M 0x0000000000000000 -
> 0x000000001FFFFFFF
> [    5.052081] [drm] amdgpu: 6128M of VRAM memory ready
> [    5.052084] [drm] amdgpu: 6128M of GTT memory ready.
> [    6.125885] amdgpu 0000:0c:00.0: RAS: ras ta ucode is not available
> [    6.131800] amdgpu: [powerplay] use vbios provided pptable
> [    6.131973] amdgpu: [powerplay] smu driver if version = 0x00000033, smu
> fw if version = 0x00000035, smu fw version = 0x002a3200 (42.50.0)
> [    6.131979] amdgpu: [powerplay] SMU driver if version not matched
> [    6.176170] amdgpu: [powerplay] SMU is initialized successfully!
> [    6.298473] amdgpu 0000:0c:00.0: fb0: amdgpudrmfb frame buffer device
> [    6.310927] amdgpu 0000:0c:00.0: ring gfx_0.0.0 uses VM inv eng 0 on
> hub 0
> [    6.311158] amdgpu 0000:0c:00.0: ring comp_1.0.0 uses VM inv eng 1 on
> hub 0
> [    6.311401] amdgpu 0000:0c:00.0: ring comp_1.1.0 uses VM inv eng 4 on
> hub 0
> [    6.311648] amdgpu 0000:0c:00.0: ring comp_1.2.0 uses VM inv eng 5 on
> hub 0
> [    6.311904] amdgpu 0000:0c:00.0: ring comp_1.3.0 uses VM inv eng 6 on
> hub 0
> [    6.312133] amdgpu 0000:0c:00.0: ring comp_1.0.1 uses VM inv eng 7 on
> hub 0
> [    6.312376] amdgpu 0000:0c:00.0: ring comp_1.1.1 uses VM inv eng 8 on
> hub 0
> [    6.312619] amdgpu 0000:0c:00.0: ring comp_1.2.1 uses VM inv eng 9 on
> hub 0
> [    6.312863] amdgpu 0000:0c:00.0: ring comp_1.3.1 uses VM inv eng 10 on
> hub 0
> [    6.313110] amdgpu 0000:0c:00.0: ring kiq_2.1.0 uses VM inv eng 11 on
> hub 0
> [    6.313355] amdgpu 0000:0c:00.0: ring sdma0 uses VM inv eng 12 on hub 0
> [    6.313585] amdgpu 0000:0c:00.0: ring sdma1 uses VM inv eng 13 on hub 0
> [    6.313821] amdgpu 0000:0c:00.0: ring vcn_dec uses VM inv eng 0 on hub 1
> [    6.314059] amdgpu 0000:0c:00.0: ring vcn_enc0 uses VM inv eng 1 on hub
> 1
> [    6.314298] amdgpu 0000:0c:00.0: ring vcn_enc1 uses VM inv eng 4 on hub
> 1
> [    6.314536] amdgpu 0000:0c:00.0: ring jpeg_dec uses VM inv eng 5 on hub
> 1
> [    6.316101] [drm] Initialized amdgpu 3.36.0 20150101 for 0000:0c:00.0
> on minor 1
> [   10.797203] snd_hda_intel 0000:0c:00.1: bound 0000:0c:00.0 (ops
> amdgpu_dm_audio_component_bind_ops [amdgpu])
>
> is this perhaps a power management issue?
> i can include my kernel config and X logs etc if yall need.
>
>

--000000000000f4068905a5de5df6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">oh, i also flashed the card bios with the bios provided at=
:<div><a href=3D"https://www.xfxforce.com/gpus/xfx-amd-radeon-tm-rx-5600-xt=
-6gb-gddr6-raw-ii">https://www.xfxforce.com/gpus/xfx-amd-radeon-tm-rx-5600-=
xt-6gb-gddr6-raw-ii</a><br></div><div><br></div><div>if you scroll down a b=
it and click on downloads, they have a link to a &quot;performance bios&quo=
t;. i flashed that, and nothing changed. after the flash, the card still wo=
rked great in windows, and still terrible in linux. so i guess that flash d=
idnt=C2=A0change anything.=C2=A0</div><div><br></div><div>also, fyi i do ha=
ve the latest linux-firmware installed (since apparently there was some iss=
ue with the firmware for the rx 5600 which was solved in the latest firmwar=
e i guess)</div><div><br></div><div>$ md5sum /lib/firmware/amdgpu/navi10_sm=
c.bin<br></div><div>632de739379e484c0233f6808cba2c7f =C2=A0/lib/firmware/am=
dgpu/navi10_smc.bin<br></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Sun, May 17, 2020 at 3:51 PM Javad Karabi =
&lt;<a href=3D"mailto:karabijavad@gmail.com">karabijavad@gmail.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=
=3D"ltr">Heres my setup:<div><br></div><div>kernel: linux-5.6.13</div><div>=
card: XFX RX 5600 XT Raw II=C2=A0 (<a href=3D"https://www.bestbuy.com/site/=
xfx-amd-radeon-rx-5600-xt-raw-ii-pro-6gb-gddr6-pci-express-4-0-graphics-car=
d/6398005.p?skuId=3D6398005" target=3D"_blank">https://www.bestbuy.com/site=
/xfx-amd-radeon-rx-5600-xt-raw-ii-pro-6gb-gddr6-pci-express-4-0-graphics-ca=
rd/6398005.p?skuId=3D6398005</a>)<br></div><div><br></div><div>x1 carbon 7t=
h gen -thunderbolt-&gt; Razer Core X -&gt; rx 5600 xt -&gt; hdmi connection=
 to my monitor (asus mg248)</div><div><br></div><div>when i boot into windo=
ws, the card works totally fine (installed the radeon drivers and everythin=
g)</div><div><br></div><div>when im in=C2=A0linux, the card works, my monit=
or works, radeontop shows the gpu being used when i run DRI_PRIME=3D1 glxge=
ars, etc etc, so it seems that the card is being properly utilized by every=
thing.</div><div><br></div><div>one interesting detail: when i install the =
kernel, update-initramfs reports that there is &quot;possibly missing firmw=
are&quot;. i dont see any errors in dmesg about missing firmware so im assu=
ming thats not a problem?</div><div><br></div><div>problem is, its very low=
 fps. for example, heres my glxinfo/glxgears output:<br></div><div><br></di=
v><div>$ DRI_PRIME=3D0 glxgears<br>3148 frames in 5.0 seconds =3D 628.420 F=
PS<br>1950 frames in 5.0 seconds =3D 389.999 FPS<br>^C<br>$ DRI_PRIME=3D1 g=
lxgears<br>755 frames in 5.0 seconds =3D 150.698 FPS<br>662 frames in 5.0 s=
econds =3D 132.296 FPS<br>^C<br>$ DRI_PRIME=3D0 glxinfo | grep vendor <br>s=
erver glx vendor string: SGI<br>client glx vendor string: Mesa Project and =
SGI<br>OpenGL vendor string: Intel<br>$ DRI_PRIME=3D1 glxinfo | grep vendor=
<br>server glx vendor string: SGI<br>client glx vendor string: Mesa Project=
 and SGI<br>OpenGL vendor string: X.Org<br></div><div><br></div><div>$ dmes=
g | egrep -i &quot;amdgpu|radeon&quot;<br>[ =C2=A0 =C2=A04.798043] amdgpu: =
unknown parameter &#39;si_support&#39; ignored<br>[ =C2=A0 =C2=A04.802600] =
amdgpu: unknown parameter &#39;cik_support&#39; ignored<br>[ =C2=A0 =C2=A04=
.813305] [drm] amdgpu kernel modesetting enabled.<br>[ =C2=A0 =C2=A04.81344=
9] amdgpu 0000:0c:00.0: enabling device (0000 -&gt; 0003)<br>[ =C2=A0 =C2=
=A05.051950] amdgpu 0000:0c:00.0: VRAM: 6128M 0x0000008000000000 - 0x000000=
817EFFFFFF (6128M used)<br>[ =C2=A0 =C2=A05.051952] amdgpu 0000:0c:00.0: GA=
RT: 512M 0x0000000000000000 - 0x000000001FFFFFFF<br>[ =C2=A0 =C2=A05.052081=
] [drm] amdgpu: 6128M of VRAM memory ready<br>[ =C2=A0 =C2=A05.052084] [drm=
] amdgpu: 6128M of GTT memory ready.<br>[ =C2=A0 =C2=A06.125885] amdgpu 000=
0:0c:00.0: RAS: ras ta ucode is not available<br>[ =C2=A0 =C2=A06.131800] a=
mdgpu: [powerplay] use vbios provided pptable<br>[ =C2=A0 =C2=A06.131973] a=
mdgpu: [powerplay] smu driver if version =3D 0x00000033, smu fw if version =
=3D 0x00000035, smu fw version =3D 0x002a3200 (42.50.0)<br>[ =C2=A0 =C2=A06=
.131979] amdgpu: [powerplay] SMU driver if version not matched<br>[ =C2=A0 =
=C2=A06.176170] amdgpu: [powerplay] SMU is initialized successfully!<br>[ =
=C2=A0 =C2=A06.298473] amdgpu 0000:0c:00.0: fb0: amdgpudrmfb frame buffer d=
evice<br>[ =C2=A0 =C2=A06.310927] amdgpu 0000:0c:00.0: ring gfx_0.0.0 uses =
VM inv eng 0 on hub 0<br>[ =C2=A0 =C2=A06.311158] amdgpu 0000:0c:00.0: ring=
 comp_1.0.0 uses VM inv eng 1 on hub 0<br>[ =C2=A0 =C2=A06.311401] amdgpu 0=
000:0c:00.0: ring comp_1.1.0 uses VM inv eng 4 on hub 0<br>[ =C2=A0 =C2=A06=
.311648] amdgpu 0000:0c:00.0: ring comp_1.2.0 uses VM inv eng 5 on hub 0<br=
>[ =C2=A0 =C2=A06.311904] amdgpu 0000:0c:00.0: ring comp_1.3.0 uses VM inv =
eng 6 on hub 0<br>[ =C2=A0 =C2=A06.312133] amdgpu 0000:0c:00.0: ring comp_1=
.0.1 uses VM inv eng 7 on hub 0<br>[ =C2=A0 =C2=A06.312376] amdgpu 0000:0c:=
00.0: ring comp_1.1.1 uses VM inv eng 8 on hub 0<br>[ =C2=A0 =C2=A06.312619=
] amdgpu 0000:0c:00.0: ring comp_1.2.1 uses VM inv eng 9 on hub 0<br>[ =C2=
=A0 =C2=A06.312863] amdgpu 0000:0c:00.0: ring comp_1.3.1 uses VM inv eng 10=
 on hub 0<br>[ =C2=A0 =C2=A06.313110] amdgpu 0000:0c:00.0: ring kiq_2.1.0 u=
ses VM inv eng 11 on hub 0<br>[ =C2=A0 =C2=A06.313355] amdgpu 0000:0c:00.0:=
 ring sdma0 uses VM inv eng 12 on hub 0<br>[ =C2=A0 =C2=A06.313585] amdgpu =
0000:0c:00.0: ring sdma1 uses VM inv eng 13 on hub 0<br>[ =C2=A0 =C2=A06.31=
3821] amdgpu 0000:0c:00.0: ring vcn_dec uses VM inv eng 0 on hub 1<br>[ =C2=
=A0 =C2=A06.314059] amdgpu 0000:0c:00.0: ring vcn_enc0 uses VM inv eng 1 on=
 hub 1<br>[ =C2=A0 =C2=A06.314298] amdgpu 0000:0c:00.0: ring vcn_enc1 uses =
VM inv eng 4 on hub 1<br>[ =C2=A0 =C2=A06.314536] amdgpu 0000:0c:00.0: ring=
 jpeg_dec uses VM inv eng 5 on hub 1<br>[ =C2=A0 =C2=A06.316101] [drm] Init=
ialized amdgpu 3.36.0 20150101 for 0000:0c:00.0 on minor 1<br>[ =C2=A0 10.7=
97203] snd_hda_intel 0000:0c:00.1: bound 0000:0c:00.0 (ops amdgpu_dm_audio_=
component_bind_ops [amdgpu])<br></div><div><br></div><div>is this perhaps a=
 power management issue?</div><div>i can include my kernel config and X log=
s etc if yall need.</div><div><br></div></div>
</blockquote></div>

--000000000000f4068905a5de5df6--

--===============0525556006==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0525556006==--
