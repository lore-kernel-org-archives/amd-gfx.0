Return-Path: <SRS0=l0jK=2O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5893C2D0C3
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Dec 2019 18:36:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 774572075B
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Dec 2019 18:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwEJ/qZO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 774572075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BEF56E354;
	Tue, 24 Dec 2019 18:36:22 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 360236E354
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Dec 2019 18:36:21 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id d16so20420619wre.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Dec 2019 10:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1Q/AgqXNPsyQBW694tRTn03FBuKIzAT3nBuCDf5wwEk=;
 b=lwEJ/qZOSBZgWQGLhP5EoZkOqmPa4iFluoeGwLTX02EK1nU5HBLwgPeK6v/PxJmiBp
 mke3jITe/1sw0Ww0rNfnvqvGPvIQUNlGqSU6X8vAiwqcD4Bxa6IN5zhusEy+qKLQaL6Y
 9qUC1u2+XsMIUZB5zCZeaqE7sGM5OApE/CE6EI/+133oJq+M2HkphVroDLyMyrqtxXUX
 vChPGOeNfP9IkSNUihSfEQNZE76vTZSQoIjBwo+Ru/7qCMTjrih7ipsVdx4nXFiAOskO
 qSjpLMnoQBkM3PIzAMzi5RtGoA3Af2w9kGHt1PezG6tcMI0ve3DEL/euXqBNb9uWTX8J
 HFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1Q/AgqXNPsyQBW694tRTn03FBuKIzAT3nBuCDf5wwEk=;
 b=NeF1NNlOTK8VsqEVaTDMfFO3sZ8Ib8phKwGDauzCEY9YXj+2AIO/bCb50zVhKJWAHE
 UM9cDQULb4irkpKdLiYpAYiPPJ10msLOOKTQ7oM6QgI1GHVYtAfNlSnaQRva6fOjz4CU
 14Q8b7TwpHB4ZBsvpSEf5yIYF8HPDaR6lUIkX5YDLsAgihnJmICyRIExfDSSN1qdEwno
 iIkpUsfYOg5HvxeKJ3cagfaW3fg6V7cUvCjZyKfBgKFtXjSMj3fi6tNKvEWeaj3P3IZX
 i7RKB3x7r/XORbSdM6vRiydDV1UOgmg4FN/2KxREhz8a8wfeY4Ufrar6m7JusRsCan2d
 paVg==
X-Gm-Message-State: APjAAAVd4IKcIFPMi8pifzot4GN9a+BnaFQpclYVtHJ2ftdgGrij9pwz
 WRcBmE+ZITCXncjdKGqtQ/wVIewugUUEwUYLMkA=
X-Google-Smtp-Source: APXvYqyf8+evYG+65Jv+EzudCb5E/7f74UTL/bSzzf0dMQ+nMgUWP/HJZYruPcQ+/BWV+KryeRS9Y/Ffq+z043uRkXA=
X-Received: by 2002:adf:8297:: with SMTP id 23mr34487260wrc.379.1577212579753; 
 Tue, 24 Dec 2019 10:36:19 -0800 (PST)
MIME-Version: 1.0
References: <CAGzVRjxOWf=0T9vd6u4-qasWPzzKZoafrz_02+A40=KGZkgrow@mail.gmail.com>
 <CADnq5_NVW1u9fJjA6xq3s-o+3XFLW4wajANN27ohAY=Hm4ZudA@mail.gmail.com>
In-Reply-To: <CADnq5_NVW1u9fJjA6xq3s-o+3XFLW4wajANN27ohAY=Hm4ZudA@mail.gmail.com>
From: =?UTF-8?Q?Yusuf_Alt=C4=B1parmak?= <yusufalti1997@gmail.com>
Date: Tue, 24 Dec 2019 21:36:09 +0300
Message-ID: <CAGzVRjyAwhxhXK_V=Saydv_UgBrtfbLt3uwya7U6P0w5jrvD_w@mail.gmail.com>
Subject: Re: polaris12_mc.bin error
To: Alex Deucher <alexdeucher@gmail.com>
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
Cc: amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============1304676558=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1304676558==
Content-Type: multipart/alternative; boundary="0000000000008d32bd059a776bd3"

--0000000000008d32bd059a776bd3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Alex,

Is this firmware differs on kernel version ? I am using linux kernel for
embedded device. If not, can I use the ones I found with google ?

Thanks.

Alex Deucher <alexdeucher@gmail.com>, 24 Ara 2019 Sal, 21:00 tarihinde =C5=
=9Funu
yazd=C4=B1:

> On Tue, Dec 24, 2019 at 1:38 AM Yusuf Alt=C4=B1parmak
> <yusufalti1997@gmail.com> wrote:
> >
> > Hello, I just compiled my 4.19 kernel with amdgpu driver (amdgpu as
> builtin). The driver is giving me  -2 error because of polaris12_mc.bin d=
id
> not found. I couldn't find that file anywhere. How can i get
> polaris12_mc.bin and where should I place it ?
> >
>
> If you are building amdgpu into your kernel, you need to build the
> firmware into the kernel too.  If you are using an initrd, you need to
> include the firmware in the initrd.  The firmware is usually in
> /lib/firmware, but may vary a bit depending on your distro.
>
> Alex
>
> > Dmesg:
> > [    5.425323] [drm] amdgpu kernel modesetting enabled.
> > [    5.429066] amdgpu 0001:01:00.0: runtime IRQ mapping not provided by
> arch
> > [    5.429609] [drm] initializing kernel modesetting (POLARIS12
> 0x1002:0x6987 0x1787:0x2389 0x80).
> > [    5.437091] [drm] register mmio base: 0x20200000
> > [    5.445303] [drm] register mmio size: 262144
> > [    5.448288] [drm] add ip block number 0 <vi_common>
> > [    5.451864] [drm] add ip block number 1 <gmc_v8_0>
> > [    5.455351] [drm] add ip block number 2 <tonga_ih>
> > [    5.458833] [drm] add ip block number 3 <powerplay>
> > [    5.462410] [drm] add ip block number 4 <dm>
> > [    5.465376] [drm] add ip block number 5 <gfx_v8_0>
> > [    5.468864] [drm] add ip block number 6 <sdma_v3_0>
> > [    5.472438] [drm] add ip block number 7 <uvd_v6_0>
> > [    5.475929] [drm] add ip block number 8 <vce_v3_0>
> > [    5.479530] [drm] UVD is enabled in VM mode
> > [    5.482411] [drm] UVD ENC is enabled in VM mode
> > [    5.485647] [drm] VCE enabled in VM mode
> > [    5.717932] ATOM BIOS: 113-ER16BFC-001
> > [    5.720412] [drm] GPU posting now...
> > [    5.843160] [drm] vm size is 64 GB, 2 levels, block size is 10-bit,
> fragment size is 9-bit
> > [    5.850175] amdgpu 0001:01:00.0: Direct firmware load for
> amdgpu/polaris12_mc.bin failed with error -2
> > [    5.858187] mc: Failed to load firmware "amdgpu/polaris12_mc.bin"
> > [    5.863752] [drm:.gmc_v8_0_sw_init [amdgpu]] *ERROR* Failed to load
> mc firmware!
> > [    5.870501] [drm:.amdgpu_device_init [amdgpu]] *ERROR* sw_init of IP
> block <gmc_v8_0> failed -2
> > [    5.877918] amdgpu 0001:01:00.0: amdgpu_device_ip_init failed
> > [    5.882365] amdgpu 0001:01:00.0: Fatal error during GPU init
> > [    5.886722] [drm] amdgpu: finishing device.
> > [    5.890054] amdgpu: probe of 0001:01:00.0 failed with error -2
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--0000000000008d32bd059a776bd3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello Alex,=C2=A0</div><div><br></div><div>Is this fi=
rmware differs on kernel version ? I am using linux kernel for embedded dev=
ice. If not, can I use the ones I found with google ?=C2=A0</div><div><br><=
/div><div>Thanks.</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com" =
target=3D"_blank">alexdeucher@gmail.com</a>&gt;, 24 Ara 2019 Sal, 21:00 tar=
ihinde =C5=9Funu yazd=C4=B1:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">On Tue, Dec 24, 2019 at 1:38 AM Yusuf Alt=C4=B1parmak<br>
&lt;<a href=3D"mailto:yusufalti1997@gmail.com" target=3D"_blank">yusufalti1=
997@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hello, I just compiled my 4.19 kernel with amdgpu driver (amdgpu as bu=
iltin). The driver is giving me=C2=A0 -2 error because of polaris12_mc.bin =
did not found. I couldn&#39;t find that file anywhere. How can i get polari=
s12_mc.bin and where should I place it ?<br>
&gt;<br>
<br>
If you are building amdgpu into your kernel, you need to build the<br>
firmware into the kernel too.=C2=A0 If you are using an initrd, you need to=
<br>
include the firmware in the initrd.=C2=A0 The firmware is usually in<br>
/lib/firmware, but may vary a bit depending on your distro.<br>
<br>
Alex<br>
<br>
&gt; Dmesg:<br>
&gt; [=C2=A0 =C2=A0 5.425323] [drm] amdgpu kernel modesetting enabled.<br>
&gt; [=C2=A0 =C2=A0 5.429066] amdgpu 0001:01:00.0: runtime IRQ mapping not =
provided by arch<br>
&gt; [=C2=A0 =C2=A0 5.429609] [drm] initializing kernel modesetting (POLARI=
S12 0x1002:0x6987 0x1787:0x2389 0x80).<br>
&gt; [=C2=A0 =C2=A0 5.437091] [drm] register mmio base: 0x20200000<br>
&gt; [=C2=A0 =C2=A0 5.445303] [drm] register mmio size: 262144<br>
&gt; [=C2=A0 =C2=A0 5.448288] [drm] add ip block number 0 &lt;vi_common&gt;=
<br>
&gt; [=C2=A0 =C2=A0 5.451864] [drm] add ip block number 1 &lt;gmc_v8_0&gt;<=
br>
&gt; [=C2=A0 =C2=A0 5.455351] [drm] add ip block number 2 &lt;tonga_ih&gt;<=
br>
&gt; [=C2=A0 =C2=A0 5.458833] [drm] add ip block number 3 &lt;powerplay&gt;=
<br>
&gt; [=C2=A0 =C2=A0 5.462410] [drm] add ip block number 4 &lt;dm&gt;<br>
&gt; [=C2=A0 =C2=A0 5.465376] [drm] add ip block number 5 &lt;gfx_v8_0&gt;<=
br>
&gt; [=C2=A0 =C2=A0 5.468864] [drm] add ip block number 6 &lt;sdma_v3_0&gt;=
<br>
&gt; [=C2=A0 =C2=A0 5.472438] [drm] add ip block number 7 &lt;uvd_v6_0&gt;<=
br>
&gt; [=C2=A0 =C2=A0 5.475929] [drm] add ip block number 8 &lt;vce_v3_0&gt;<=
br>
&gt; [=C2=A0 =C2=A0 5.479530] [drm] UVD is enabled in VM mode<br>
&gt; [=C2=A0 =C2=A0 5.482411] [drm] UVD ENC is enabled in VM mode<br>
&gt; [=C2=A0 =C2=A0 5.485647] [drm] VCE enabled in VM mode<br>
&gt; [=C2=A0 =C2=A0 5.717932] ATOM BIOS: 113-ER16BFC-001<br>
&gt; [=C2=A0 =C2=A0 5.720412] [drm] GPU posting now...<br>
&gt; [=C2=A0 =C2=A0 5.843160] [drm] vm size is 64 GB, 2 levels, block size =
is 10-bit, fragment size is 9-bit<br>
&gt; [=C2=A0 =C2=A0 5.850175] amdgpu 0001:01:00.0: Direct firmware load for=
 amdgpu/polaris12_mc.bin failed with error -2<br>
&gt; [=C2=A0 =C2=A0 5.858187] mc: Failed to load firmware &quot;amdgpu/pola=
ris12_mc.bin&quot;<br>
&gt; [=C2=A0 =C2=A0 5.863752] [drm:.gmc_v8_0_sw_init [amdgpu]] *ERROR* Fail=
ed to load mc firmware!<br>
&gt; [=C2=A0 =C2=A0 5.870501] [drm:.amdgpu_device_init [amdgpu]] *ERROR* sw=
_init of IP block &lt;gmc_v8_0&gt; failed -2<br>
&gt; [=C2=A0 =C2=A0 5.877918] amdgpu 0001:01:00.0: amdgpu_device_ip_init fa=
iled<br>
&gt; [=C2=A0 =C2=A0 5.882365] amdgpu 0001:01:00.0: Fatal error during GPU i=
nit<br>
&gt; [=C2=A0 =C2=A0 5.886722] [drm] amdgpu: finishing device.<br>
&gt; [=C2=A0 =C2=A0 5.890054] amdgpu: probe of 0001:01:00.0 failed with err=
or -2<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd=
-gfx@lists.freedesktop.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=
=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/lis=
tinfo/amd-gfx</a><br>
</blockquote></div></div>

--0000000000008d32bd059a776bd3--

--===============1304676558==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1304676558==--
