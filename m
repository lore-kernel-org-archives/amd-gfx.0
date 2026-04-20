Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 643F1F588CB
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2026 13:50:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED7A210E663;
	Mon, 20 Apr 2026 13:50:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IrrHWPU6";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCFAD10E663
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 13:50:01 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so41016115e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 06:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776693000; x=1777297800; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y1JCNG9WDhYkg3amgItK3ZH1Vu4vJiYJVoY41s5z4XU=;
 b=IrrHWPU64VNIZU9MfuMzf+X/JE+9WoYN+Ne76bTOV4ztm2FuSnHQfCHDY5wXWiH/S7
 8d70LU7F+GQhDfx/ATfuoywDc0pdOOFvYNicGdqDn/Q+Ue7+h959gLNDECQLC5z/kVY6
 a+ghMd5wz2kSN1wuNnmdbwdIhOjQNfz2u2PaYzBmWALOgHx9HwI2qljwKhLzgCANgPC0
 C8HaGyQVPLuvuk++X5qkk4wu0xLniJyPsS/5QwRsh3i08t3S+cLwknHEqzuK+xwuDJvI
 ba7bYzDxkItlrPP1Puyj+5V1twUtcmryPJhHYtXa+/bSpBINhI2i5E+Nq6+NjNmZ7Qp0
 n1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776693000; x=1777297800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=y1JCNG9WDhYkg3amgItK3ZH1Vu4vJiYJVoY41s5z4XU=;
 b=K0bTGzpwDbD1JTQXCCLemcbtKXSME+cJyS2DgiBbe6V4u91S9gLb7cB93S4xrEgFoD
 41OWRCyIejcO+Pl6Lz1L1yhlWtVPahMTvNz2jUjw9iBb9Wzg5fI57qGm7NWFkSnGATqZ
 6NqPEP9BrjUkaG8nfWDj3sdXGlDZjYnpozDQEHqL2d+8OGCpUKJ7hRwgo3FGSCUca6Td
 zISl9d4y1eISWHWyQi3n5HGrtf6i7Yuvd4lEUjNak5YuPcGwp/FYCmP2aRoBORlBvbMz
 JgYaa4PZcZltevgqYHsRihq55K25uSWJb5enbNPVK1JvfXT9WDXjANqH0DsONImQLjm9
 gJrw==
X-Gm-Message-State: AOJu0Yx5PI3lI7D0MajChmEnIOZMEVtp/5EZA7aAI49YVJMcDMgJgvlc
 tBrKesq+N1S/GNTtVGn+qI2YSDNXW4Ih6qOQQEaxThX4miNtRqtbPWYzcrz3ig==
X-Gm-Gg: AeBDiet4EAx/PHYkorEQUTQjvIrWJzw8Vrz/FWUIewuqCyLeWTYZTmcVwgTr9YdfPPd
 WyWxhHPUwRjO7Zn767rwoHxeu+eugvrmA8I3epy9cP+PkcqBM5nefdApKW3XRiUgA6Lc+0s7Uu4
 EHqPwJac4ziT7CM4OYqijPY5Pvzm9jtDFiDiQTyo/1y8gnhVtn0YQxpHEU8SCOSly50SjXJzwe5
 HqGzHrKUKpB2PxmkBtkyRxwE+Mbyzq9UFE5bxyncxIoOC2uBa49Zq/NjNCgyLUSs9qywTpFLE9u
 pQOIg9jBY9Z62f4TGwe618eeyRKvSAUxQMysCWx7QNROupw/RtqcVOVWH7keBKOe1c0I47OFmQp
 rIVaq3ToqzioDtuO5EBzVqJerfntrkT6LiQ9IZzImctFGUVQhofjJeoV7awoDcXvlJiZmu7D2NF
 0LNbKVx0W+sWJ+F7XJUkYPQubcNi68qZzGMr41ZnsDFHXBDnEgpUl42q2aZWO/6KJGNoN93qA6V
 f6AiGJ1AVE=
X-Received: by 2002:a05:600c:3553:b0:48a:52f2:a0f1 with SMTP id
 5b1f17b1804b1-48a52f2a5f0mr15867325e9.18.1776693000045; 
 Mon, 20 Apr 2026 06:50:00 -0700 (PDT)
Received: from timur-hyperion.localnet (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0f8193sm259871165e9.1.2026.04.20.06.49.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 06:49:59 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [PATCH 3/7] drm/amdgpu/vce1: Correct firmware offset mask
Date: Mon, 20 Apr 2026 15:49:58 +0200
Message-ID: <2216811.9o76ZdvQCi@timur-hyperion>
In-Reply-To: <14b58bb8-e1bf-4b9d-9957-dbdc32144278@amd.com>
References: <20260420121044.155030-1-timur.kristof@gmail.com>
 <20260420121044.155030-4-timur.kristof@gmail.com>
 <14b58bb8-e1bf-4b9d-9957-dbdc32144278@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On Monday, April 20, 2026 2:23:18=E2=80=AFPM Central European Summer Time C=
hristian=20
K=C3=B6nig wrote:
> On 4/20/26 14:10, Timur Krist=C3=B3f wrote:
> > It's 0x0fffffff and not 0x7fffffff.
> >=20
> > Fixes: d4a640d4b9f3 ("drm/amdgpu/vce1: Implement VCE1 IP block (v2)")
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> >=20
> >  drivers/gpu/drm/amd/amdgpu/vce_v1_0.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> > b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c index
> > 2fe931366985a..ce993b57b0e9f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> > @@ -313,17 +313,17 @@ static int vce_v1_0_mc_resume(struct amdgpu_device
> > *adev)>=20
> >  	offset =3D  adev->vce.gpu_addr + AMDGPU_VCE_FIRMWARE_OFFSET;
> >  	size =3D VCE_V1_0_FW_SIZE;
> >=20
> > -	WREG32(mmVCE_VCPU_CACHE_OFFSET0, offset & 0x7fffffff);
> > +	WREG32(mmVCE_VCPU_CACHE_OFFSET0, offset & 0x0fffffff);
> >=20
> >  	WREG32(mmVCE_VCPU_CACHE_SIZE0, size);
> >  =09
> >  	offset +=3D size;
> >  	size =3D VCE_V1_0_STACK_SIZE;
> >=20
> > -	WREG32(mmVCE_VCPU_CACHE_OFFSET1, offset & 0x7fffffff);
> > +	WREG32(mmVCE_VCPU_CACHE_OFFSET1, offset & 0x0fffffff);
> >=20
> >  	WREG32(mmVCE_VCPU_CACHE_SIZE1, size);
> >  =09
> >  	offset +=3D size;
> >  	size =3D VCE_V1_0_DATA_SIZE;
> >=20
> > -	WREG32(mmVCE_VCPU_CACHE_OFFSET2, offset & 0x7fffffff);
> > +	WREG32(mmVCE_VCPU_CACHE_OFFSET2, offset & 0x0fffffff);
>=20
> We actually have that as VCE_VCPU_CACHE_OFFSET*__OFFSET_MASK in the heade=
rs,
> would probably be a good idea to use that one instead.
>=20
> Additional to that limiting the value actually doesn't make much sense, t=
hat
> just hides the problem when we really get an offset which is to large.
>=20
> We should probably rather have a WARN_ON(offset &
> ~VCE_VCPU_CACHE_OFFSET2__OFFSET_MASK) directly above the register write.
>=20
> Apart from that the patch looks good to me.
>=20
> Regards,
> Christian.

Hi Christian,

Thanks, I agree and I'll add the necessary changes.
That being said, with some further testing it seems that VCE fails to=20
initialize when the gpu_addr is 128 MiB or more, which makes me think that =
we=20
should use 0x07ffffff instead of 0x0fffffff. Does that sound reasonable to =
you?

Thanks,
Timur


>=20
> >  	WREG32(mmVCE_VCPU_CACHE_SIZE2, size);
> >  =09
> >  	WREG32_P(mmVCE_LMI_CTRL2, 0x0, ~0x100);
> >=20
> > @@ -531,7 +531,7 @@ static int vce_v1_0_early_init(struct amdgpu_ip_blo=
ck
> > *ip_block)>=20
> >  static int vce_v1_0_ensure_vcpu_bo_32bit_addr(struct amdgpu_device *ad=
ev)
> >  {
> > =20
> >  	u64 bo_size =3D amdgpu_bo_size(adev->vce.vcpu_bo);
> >=20
> > -	u64 max_vcpu_bo_addr =3D 0xffffffff - bo_size;
> > +	u64 max_vcpu_bo_addr =3D 0x0fffffff - bo_size;
> >=20
> >  	u64 num_pages =3D ALIGN(bo_size, AMDGPU_GPU_PAGE_SIZE) /
> >  	AMDGPU_GPU_PAGE_SIZE; u64 pa =3D amdgpu_gmc_vram_pa(adev,
> >  	adev->vce.vcpu_bo);
> >  	u64 flags =3D AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE |
> >  	AMDGPU_PTE_VALID;




