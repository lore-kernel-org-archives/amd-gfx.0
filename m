Return-Path: <SRS0=l0jK=2O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CF2C2D0CF
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Dec 2019 06:38:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D54D206B7
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Dec 2019 06:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkFKMK+L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D54D206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D5E56E0A1;
	Tue, 24 Dec 2019 06:38:46 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E79C6E0A1
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Dec 2019 06:38:45 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id p17so1669525wma.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Dec 2019 22:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=Y/F9Cz4E/OUS6q4INK9bEJa9PXQSCnHXUO7AVMFDWAM=;
 b=UkFKMK+LgRM8d+hmpo6AFllDcbdKQPQNlfkUQIW9o6/UUsPUK5U3LAsLlDvK7jQfnC
 wkS7pL4tMN1j/G+2TiACueoIQfwH/BdKjxC/cuB2+rQ+junjnBTf/lMjdVzbx6W5xJ7h
 ee4VzxwLXuQWkWtvQZGWXj7F3E/ZaxqSH//Ts6riRkfDB8w7fMpQyKcqSMokeooeVCHe
 MOC/qDrEhRvMPBi1Pl+mPTnmzT2fp2GTweg11LENTliUSWBT9QchWXxANeIQSUMCBAoG
 02+wyD9b5Z3Hd/M1HdaF4uOOCVIpMTQmB67wQb99xIVw23tI68yTUFdIBJeQFJdUsOr8
 HqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=Y/F9Cz4E/OUS6q4INK9bEJa9PXQSCnHXUO7AVMFDWAM=;
 b=EJZSJsLA8FsJXzkcP49pUu6oXY5bPwlelu8gGqiu6GZLgCh23+0W/+x/Dvbx5o7Jmr
 jv/d4leOgq2KCVzDMk2qntdIy/1n5mgmhqGGasmabTGFKqUi9YthE8+Mqr151R4NNGeJ
 3IGOMJ2Mixgg8/2q+sE3JYRv9chbZxVhEhtdQOd1rD8jALB0srydmdfYbtKVnH3/Oe9z
 lM2YtaWyRQ6RL1zy/yZNgSNP3T6MVu51kOsMo4CMosl6fsc2Dx+IqAxtVQEm2wDiwlQb
 RzhIS5CqSiBr8AkjVjoHd7+aIgtJ4l+jodME/qYlv5GNsxCN+x3kE21jip7CWis7IFWr
 bLZQ==
X-Gm-Message-State: APjAAAXELck1X7Zvw/3wwNIuKvhmnCqKRSmyQdOO0B/j1MmANq/6FhGF
 NjmDO4n86ywVjNyNhrhKXKJe9idr2xk1psZzJswk6g==
X-Google-Smtp-Source: APXvYqyMFTb4UFePzm4jcwWGBbHC12mDQVo+LUAKhf48zBEIZBPiaMVls+QGDFgpjDItm4xbMJF9W/NPYyWUKtuF7Tc=
X-Received: by 2002:a1c:4c10:: with SMTP id z16mr2620750wmf.136.1577169523585; 
 Mon, 23 Dec 2019 22:38:43 -0800 (PST)
MIME-Version: 1.0
From: =?UTF-8?Q?Yusuf_Alt=C4=B1parmak?= <yusufalti1997@gmail.com>
Date: Tue, 24 Dec 2019 09:38:32 +0300
Message-ID: <CAGzVRjxOWf=0T9vd6u4-qasWPzzKZoafrz_02+A40=KGZkgrow@mail.gmail.com>
Subject: polaris12_mc.bin error
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
Content-Type: multipart/mixed; boundary="===============1518938264=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1518938264==
Content-Type: multipart/alternative; boundary="00000000000034373c059a6d6503"

--00000000000034373c059a6d6503
Content-Type: text/plain; charset="UTF-8"

Hello, I just compiled my 4.19 kernel with amdgpu driver (amdgpu as
builtin). The driver is giving me  -2 error because of polaris12_mc.bin did
not found. I couldn't find that file anywhere. How can i get
polaris12_mc.bin and where should I place it ?

*Dmesg:*
[    5.425323] [drm] amdgpu kernel modesetting enabled.
[    5.429066] amdgpu 0001:01:00.0: runtime IRQ mapping not provided by arch
[    5.429609] [drm] initializing kernel modesetting (POLARIS12
0x1002:0x6987 0x1787:0x2389 0x80).
[    5.437091] [drm] register mmio base: 0x20200000
[    5.445303] [drm] register mmio size: 262144
[    5.448288] [drm] add ip block number 0 <vi_common>
[    5.451864] [drm] add ip block number 1 <gmc_v8_0>
[    5.455351] [drm] add ip block number 2 <tonga_ih>
[    5.458833] [drm] add ip block number 3 <powerplay>
[    5.462410] [drm] add ip block number 4 <dm>
[    5.465376] [drm] add ip block number 5 <gfx_v8_0>
[    5.468864] [drm] add ip block number 6 <sdma_v3_0>
[    5.472438] [drm] add ip block number 7 <uvd_v6_0>
[    5.475929] [drm] add ip block number 8 <vce_v3_0>
[    5.479530] [drm] UVD is enabled in VM mode
[    5.482411] [drm] UVD ENC is enabled in VM mode
[    5.485647] [drm] VCE enabled in VM mode
[    5.717932] ATOM BIOS: 113-ER16BFC-001
[    5.720412] [drm] GPU posting now...
[    5.843160] [drm] vm size is 64 GB, 2 levels, block size is 10-bit,
fragment size is 9-bit
[    5.850175] amdgpu 0001:01:00.0: Direct firmware load for
amdgpu/polaris12_mc.bin failed with error -2
*[    5.858187] mc: Failed to load firmware "amdgpu/polaris12_mc.bin"*
*[    5.863752] [drm:.gmc_v8_0_sw_init [amdgpu]] *ERROR* Failed to load mc
firmware!*
*[    5.870501] [drm:.amdgpu_device_init [amdgpu]] *ERROR* sw_init of IP
block <gmc_v8_0> failed -2*


*[    5.877918] amdgpu 0001:01:00.0: amdgpu_device_ip_init failed[
 5.882365] amdgpu 0001:01:00.0: Fatal error during GPU init[    5.886722]
[drm] amdgpu: finishing device.*
*[    5.890054] amdgpu: probe of 0001:01:00.0 failed with error -2*

--00000000000034373c059a6d6503
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello, I just compiled my 4.19 kernel with amdgpu dri=
ver (amdgpu as builtin). The driver is giving me=C2=A0 -2 error because of =
polaris12_mc.bin did not found. I couldn&#39;t find that file anywhere. How=
 can i get polaris12_mc.bin and where should I place it ?<br></div><div><br=
></div><div><b>Dmesg:</b><br></div><div>[ =C2=A0 =C2=A05.425323] [drm] amdg=
pu kernel modesetting enabled.</div>[ =C2=A0 =C2=A05.429066] amdgpu 0001:01=
:00.0: runtime IRQ mapping not provided by arch<br>[ =C2=A0 =C2=A05.429609]=
 [drm] initializing kernel modesetting (POLARIS12 0x1002:0x6987 0x1787:0x23=
89 0x80).<br>[ =C2=A0 =C2=A05.437091] [drm] register mmio base: 0x20200000<=
br>[ =C2=A0 =C2=A05.445303] [drm] register mmio size: 262144<br>[ =C2=A0 =
=C2=A05.448288] [drm] add ip block number 0 &lt;vi_common&gt;<br>[ =C2=A0 =
=C2=A05.451864] [drm] add ip block number 1 &lt;gmc_v8_0&gt;<br>[ =C2=A0 =
=C2=A05.455351] [drm] add ip block number 2 &lt;tonga_ih&gt;<br>[ =C2=A0 =
=C2=A05.458833] [drm] add ip block number 3 &lt;powerplay&gt;<br>[ =C2=A0 =
=C2=A05.462410] [drm] add ip block number 4 &lt;dm&gt;<br>[ =C2=A0 =C2=A05.=
465376] [drm] add ip block number 5 &lt;gfx_v8_0&gt;<br>[ =C2=A0 =C2=A05.46=
8864] [drm] add ip block number 6 &lt;sdma_v3_0&gt;<br>[ =C2=A0 =C2=A05.472=
438] [drm] add ip block number 7 &lt;uvd_v6_0&gt;<br>[ =C2=A0 =C2=A05.47592=
9] [drm] add ip block number 8 &lt;vce_v3_0&gt;<br>[ =C2=A0 =C2=A05.479530]=
 [drm] UVD is enabled in VM mode<br>[ =C2=A0 =C2=A05.482411] [drm] UVD ENC =
is enabled in VM mode<br>[ =C2=A0 =C2=A05.485647] [drm] VCE enabled in VM m=
ode<br>[ =C2=A0 =C2=A05.717932] ATOM BIOS: 113-ER16BFC-001<br>[ =C2=A0 =C2=
=A05.720412] [drm] GPU posting now...<br>[ =C2=A0 =C2=A05.843160] [drm] vm =
size is 64 GB, 2 levels, block size is 10-bit, fragment size is 9-bit<br>[ =
=C2=A0 =C2=A05.850175] amdgpu 0001:01:00.0: Direct firmware load for amdgpu=
/polaris12_mc.bin failed with error -2<br><b>[ =C2=A0 =C2=A05.858187] mc: F=
ailed to load firmware &quot;amdgpu/polaris12_mc.bin&quot;</b><br><b>[ =C2=
=A0 =C2=A05.863752] [drm:.gmc_v8_0_sw_init [amdgpu]] *ERROR* Failed to load=
 mc firmware!</b><br><b>[ =C2=A0 =C2=A05.870501] [drm:.amdgpu_device_init [=
amdgpu]] *ERROR* sw_init of IP block &lt;gmc_v8_0&gt; failed -2</b><br><b>[=
 =C2=A0 =C2=A05.877918] amdgpu 0001:01:00.0: amdgpu_device_ip_init failed<b=
r>[ =C2=A0 =C2=A05.882365] amdgpu 0001:01:00.0: Fatal error during GPU init=
<br>[ =C2=A0 =C2=A05.886722] [drm] amdgpu: finishing device.</b><br><b>[ =
=C2=A0 =C2=A05.890054] amdgpu: probe of 0001:01:00.0 failed with error -2</=
b></div>

--00000000000034373c059a6d6503--

--===============1518938264==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1518938264==--
