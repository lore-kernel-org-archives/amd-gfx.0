Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06EC2E9A02C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Feb 2026 15:37:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 807B210E5D9;
	Wed, 18 Feb 2026 15:37:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lV9JZlFL";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD5B510E5D9
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Feb 2026 15:37:55 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-824a6f2d816so2625016b3a.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Feb 2026 07:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771429075; x=1772033875; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=VaAniGLhMxwLFTX0Y2etfOX2Em4BjeJ+Ttkj11LkOEQ=;
 b=lV9JZlFLGu9P6d4VYWch3Onu5f+XTH53cRbOxhjghqa5H43GAG1fSsXISzbfBMVJwr
 jDwRoMY3cytQbGizJTvLLDbQgmZWGtMANnQD2L/WFIVtHLWodtEt1M/ovPT2z1wU+6g2
 M+bRnNFKxQXeY8fX9oolt+wodiskH6XsfePL5i8EeKUGuPraMNlTVytuUZXuUwX0ds1T
 KGbIZLsvVZZm7eaB3TtVwBErj+ta22vICa/y02MRY60Vj3wmTCVWydawlnRfmDJR/CM6
 JN4/ffCC5DBVPrn9uF1A+23DITm/GRZDDKu1gL83OyMyYJjRmosmChCpwRBaiWHylGqb
 EyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771429075; x=1772033875;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VaAniGLhMxwLFTX0Y2etfOX2Em4BjeJ+Ttkj11LkOEQ=;
 b=KPbPUZQjQIgamD7sKTpClbK+1UkRa8m32wl6XuPYD0yGifVlin49TtXOcDdaiiwaqc
 ACoUWiVRzI11WIkWH6/v9nO4tJg4rm4315QvdXdgPFbz4/jCghG6mnd2g1ijfpjZP9cq
 d/69FFIKaRkLS0M2+/EHMtZ0znWv5MoaXxy8QNnuUcj1emNaaY5SCss1T+QC/eOBoI0X
 +rh6+viR/tyQz1yYi81VRAWkCjJlf0Q8ja5H57z+VBPviumvDVJ3TP9SlmDu/4AYXdJo
 DJzZEN+Lb3ug+bkmRLP0pWr68fth/pwH40y04yvSKi5e8Hnz7FIwIkO7hVY6t73t/wgq
 eQww==
X-Gm-Message-State: AOJu0Yy2Y8V/ivTCqiaYcJF2LiqGe6mnK/BdJusD3FZYLEbRHEE8gY9w
 JhQS5o/ck/zGyPU04HdvEcWa7nBSqnRZqsbV5ymE2z04MMiEQOnnbcuXm8dHHw==
X-Gm-Gg: AZuq6aJjg7EXoe/jORkG8I0tn7pFzQSNWmeJyPyNK0CqOBsYex8inahs6Lw8pC2A85G
 J3FHoA3bGVEs+yOSIuNADVm3pY6VwEeEdPClIPsjma1TVak0uNEMxBC6UI/DT3tr4R7QKCYcR2C
 cl3P4ytUxOP0lIVQ/dml3ljTSOCTnlhpplgLMv1MqoPpwQmQkt913JQOncTS/Zbwoy/T8y66lXN
 zMtxGsNQAuyGKGKMjZ65u8ukqsvCPFhxfH7UHtldHLgcHCnfQCFFZkcpFasB0fNAswMp8GUDj11
 Lr6P2lg47+AotElZaMsj5ZTwc4f3VKFrUN/d/imN/tytQkbWRx6pAWOISpvaeco8lhe5Detmq57
 d5ZhULheur/a+0IdmXvq7n8jsRreDYJCTtTe5vVxNc9VDiks6KufSu/haRQafPvNATdXTXxueUQ
 EfK+rKyNy19/ETrAXqcYDIEsRntTXGmXuRwpI=
X-Received: by 2002:a05:6a00:6c9c:b0:824:3bd9:aac6 with SMTP id
 d2e1a72fcca58-825274c549cmr2027488b3a.16.1771429075074; 
 Wed, 18 Feb 2026 07:37:55 -0800 (PST)
Received: from ehlo.thunderbird.net ([101.0.63.217])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c6b6a3f8sm16880308b3a.36.2026.02.18.07.37.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Feb 2026 07:37:54 -0800 (PST)
Date: Wed, 18 Feb 2026 21:07:50 +0530
From: Saleemkhan <saleemkhan083@gmail.com>
To: amd-gfx@lists.freedesktop.org, "David (Ming Qiang) Wu" <David.Wu3@amd.com>,
 Christian.Koenig@amd.com, alexander.deucher@amd.com, leo.liu@amd.com
CC: leo.liu@amd.com, Boyuan.Zhang@amd.com, David.Wu3@amd.com
Subject: Re: [PATCH 00/14] user queue support for VCN 4.0.5
User-Agent: Thunderbird for Android
In-Reply-To: <20260210214729.80964-1-David.Wu3@amd.com>
References: <20260210214729.80964-1-David.Wu3@amd.com>
Message-ID: <4C922F99-7140-47A7-967E-D01DEF0D9ECD@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary=----Q92SF5P0KVKI0SYGJ165GX8G4X14NI
Content-Transfer-Encoding: 7bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

------Q92SF5P0KVKI0SYGJ165GX8G4X14NI
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi David, Leo,


Thank you for the UMSCH patches=2E

Are the  UMSCH and=C2=A0 vcn firmware are upstreamed ?
I want to try this on Strix=2E


Regards,

Saleem



On 11 February 2026 3:17:15 am IST, "David (Ming Qiang) Wu" <David=2EWu3@a=
md=2Ecom> wrote:
>add user queue support for VCN 4=2E0=2E5
>
>David (Ming Qiang) Wu (10):
>  amdgpu: add global aggregated doorbell bo
>  drm/amdgpu: add AMDGPU_GEM_GLOBAL_AGGREGATED_DOORBELL
>  drm/amdgpu/userq: add doorbell size for VCN and VPE
>  drm/amdgpu: use amdgpu_user_queue instead of amdgpu_umsch_mm
>  amdgpu/umsch: Add VCN IP init to umsch driver
>  drm/amdgpu/userq: change mes_userq_create_wptr_mapping() to be common
>  drm/amdgpu/userq: rework on amdgpu_userq_create_wptr_mapping
>  drm/amdgpu/umsch: user queue support for vcn
>  drm/amdgpu: add AMDGPU_INFO_DOORBELL
>  drm/amdgpu/umsch: userq suspend and resume context
>
>Saleemkhan Jamadar (4):
>  amdgpu/umsch: Update UMSCH interface and mqd structure
>  drm/amdgpu/vcn: changes when kernel queue is disabled
>  drm/amdgpu/vcn: handle interrupt received from fw
>  drm/amdgpu/vcn: handle the suspend context interrupt
>
> drivers/gpu/drm/amd/amdgpu/amdgpu=2Eh           |   4 +-
> drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs=2Ec   |   2 +-
> drivers/gpu/drm/amd/amdgpu/amdgpu_discovery=2Ec |   2 +-
> =2E=2E=2E/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr=2Ec  |  16 +
> drivers/gpu/drm/amd/amdgpu/amdgpu_drv=2Ec       |  10 -
> drivers/gpu/drm/amd/amdgpu/amdgpu_gem=2Ec       |   2 +
> drivers/gpu/drm/amd/amdgpu/amdgpu_kms=2Ec       |  18 ++
> drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm=2Ec  | 300 +++++++++++++++++-
> drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm=2Eh  |  43 ++-
> drivers/gpu/drm/amd/amdgpu/amdgpu_userq=2Ec     |  69 +++-
> drivers/gpu/drm/amd/amdgpu/amdgpu_userq=2Eh     |   4 +
> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn=2Eh       |   4 +
> drivers/gpu/drm/amd/amdgpu/mes_userqueue=2Ec    |  90 +-----
> drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0=2Ec    |  75 ++++-
> drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5=2Ec       | 122 +++++--
> =2E=2E=2E/amd/include/ivsrcid/vcn/irqsrcs_vcn_4_0=2Eh |  10 +
> =2E=2E=2E/drm/amd/include/umsch_mm_4_0_api_def=2Eh    |  12 +-
> include/uapi/drm/amdgpu_drm=2Eh                 |  14 +
> 18 files changed, 646 insertions(+), 151 deletions(-)
>
>--=20
>2=2E43=2E0
>

--
Saleem
------Q92SF5P0KVKI0SYGJ165GX8G4X14NI
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div dir=3D"auto">Hi David, Leo,<br><br><br>Thank =
you for the UMSCH patches=2E<br><br>Are the=C2=A0 UMSCH and=C2=A0 vcn firmw=
are are upstreamed ?<br>I want to try this on Strix=2E<br><br><br>Regards,<=
br><br>Saleem<br><br></div><br><br><div class=3D"gmail_quote"><div dir=3D"a=
uto">On 11 February 2026 3:17:15 am IST, "David (Ming Qiang) Wu" &lt;David=
=2EWu3@amd=2Ecom&gt; wrote:</div><blockquote class=3D"gmail_quote" style=3D=
"margin: 0pt 0pt 0pt 0=2E8ex; border-left: 1px solid rgb(204, 204, 204); pa=
dding-left: 1ex;">
<pre class=3D"k9mail"><div dir=3D"auto">add user queue support for VCN 4=
=2E0=2E5<br><br>David (Ming Qiang) Wu (10):<br>  amdgpu: add global aggrega=
ted doorbell bo<br>  drm/amdgpu: add AMDGPU_GEM_GLOBAL_AGGREGATED_DOORBELL<=
br>  drm/amdgpu/userq: add doorbell size for VCN and VPE<br>  drm/amdgpu: u=
se amdgpu_user_queue instead of amdgpu_umsch_mm<br>  amdgpu/umsch: Add VCN =
IP init to umsch driver<br>  drm/amdgpu/userq: change mes_userq_create_wptr=
_mapping() to be common<br>  drm/amdgpu/userq: rework on amdgpu_userq_creat=
e_wptr_mapping<br>  drm/amdgpu/umsch: user queue support for vcn<br>  drm/a=
mdgpu: add AMDGPU_INFO_DOORBELL<br>  drm/amdgpu/umsch: userq suspend and re=
sume context<br><br>Saleemkhan Jamadar (4):<br>  amdgpu/umsch: Update UMSCH=
 interface and mqd structure<br>  drm/amdgpu/vcn: changes when kernel queue=
 is disabled<br>  drm/amdgpu/vcn: handle interrupt received from fw<br>  dr=
m/amdgpu/vcn: handle the suspend context interrupt<br><br> drivers/gpu/drm/=
amd/amdgpu/amdgpu=2Eh           |   4 +-<br> drivers/gpu/drm/amd/amdgpu/amd=
gpu_debugfs=2Ec   |   2 +-<br> drivers/gpu/drm/amd/amdgpu/amdgpu_discovery=
=2Ec |   2 +-<br> =2E=2E=2E/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr=2Ec  |  =
16 +<br> drivers/gpu/drm/amd/amdgpu/amdgpu_drv=2Ec       |  10 -<br> driver=
s/gpu/drm/amd/amdgpu/amdgpu_gem=2Ec       |   2 +<br> drivers/gpu/drm/amd/a=
mdgpu/amdgpu_kms=2Ec       |  18 ++<br> drivers/gpu/drm/amd/amdgpu/amdgpu_u=
msch_mm=2Ec  | 300 +++++++++++++++++-<br> drivers/gpu/drm/amd/amdgpu/amdgpu=
_umsch_mm=2Eh  |  43 ++-<br> drivers/gpu/drm/amd/amdgpu/amdgpu_userq=2Ec   =
  |  69 +++-<br> drivers/gpu/drm/amd/amdgpu/amdgpu_userq=2Eh     |   4 +<br=
> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn=2Eh       |   4 +<br> drivers/gpu/d=
rm/amd/amdgpu/mes_userqueue=2Ec    |  90 +-----<br> drivers/gpu/drm/amd/amd=
gpu/umsch_mm_v4_0=2Ec    |  75 ++++-<br> drivers/gpu/drm/amd/amdgpu/vcn_v4_=
0_5=2Ec       | 122 +++++--<br> =2E=2E=2E/amd/include/ivsrcid/vcn/irqsrcs_v=
cn_4_0=2Eh |  10 +<br> =2E=2E=2E/drm/amd/include/umsch_mm_4_0_api_def=2Eh  =
  |  12 +-<br> include/uapi/drm/amdgpu_drm=2Eh                 |  14 +<br> =
18 files changed, 646 insertions(+), 151 deletions(-)<br><br></div></pre></=
blockquote></div><div dir=3D"auto">--<br>Saleem</div></body></html>
------Q92SF5P0KVKI0SYGJ165GX8G4X14NI--
