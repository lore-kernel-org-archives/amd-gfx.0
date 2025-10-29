Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF81CCF9E9
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 11:41:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 181D010E7A3;
	Wed, 29 Oct 2025 11:41:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b2zIjKBz";
	dkim-atps=neutral
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFBB110E7A3
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 11:41:17 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-63e0cec110eso12324074a12.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 04:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761738076; x=1762342876; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=tNBRk735nydQzMz3Q3u0ama6BsqXB/Oxr94G14Nbtb4=;
 b=b2zIjKBzdAe4wQ8j3hk5GIC8pO+trdN2XTJQJwj4XEfUiN84TiTe/CDNXJQgPsPq5b
 oIGW17bKl1ObylaatHWPInjq8pyqxN8n+d577IhBfGJI2Jf41PoAU+pFQfDuPKTDL+TI
 VLHBR32+mugfe89TOFurHwwKOL+G3AnUoRf7r28EtqfmDBCRVzCUiej3IGEgY/NRqVYe
 MJjmMwmMcG6HHtJi1oXMtERXwRzUpnugf53HTOZoT/HWNU8/tPkpZNp6SNf8Ju1guJ8W
 OOLbYzS3AwlrAt1dZw8zkPMjIp0SWlyxEJLXFZ4zabwL6U5HUusxUDP7T7JZUrQYiO6W
 EFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761738076; x=1762342876;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tNBRk735nydQzMz3Q3u0ama6BsqXB/Oxr94G14Nbtb4=;
 b=uYJK6ei8zIatAI95j/TeUtvspvUqVj2H6uAhw30jFfNE/zdNIvWoY9EQp/cODvWj5L
 mTS0w8wJ7dIt/yO0WyQItFQH6/8CY9oDZJtdCnlWWsA0AGiI2RJnNGIW1AkZbz/I56+o
 oBrEaBmebeh7xCU7WlcU0jzGnmZmxr4UGm7qyItOkgCcMKZl7+Ng3/eITC27gS2LfPyC
 LNhFLBeEEdHu8ykfPijk5ENcuO8o9zhIxsvrS7CGGV33Sl4QqdXWo3TbRc3FaEvhNuv2
 Z/ogOGRw1d/cUuXRcvm5o7hO6ZfaOSSxCQkZPrhVVYpmTc/YRzCcRNxG8HKTM0yn5uH/
 t+kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNDFpk2alSpZfp2WmEGp4BMlAED+W0Fz5gjqYG8oFrLn2UTNlrnC4G1tVWATgZXrEBG3BXG1C6@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxbo8AbahR44qGF/JLDJ9nse1/SSJWlah2dxxQtsWrr2xKJiQGe
 V2cTauGMchmvoFW7EEw2KHDqHd74cHDd86MVJTOjDbyTziT01L1la89jGuf4FEFn
X-Gm-Gg: ASbGncswiQTuz7mMg0N8E12rpH7F+pWyZpe0JTYrpqU9nuLoEEYDh+/Dk72ZSCb6UEq
 xHji2U1HXnJvSWDfnFgaHC0J5kgzixob7Ao4myvBVgxrmeA+Ax/3mDR6IlEfAo7alJyCwztSReF
 HNU1ceEFmP2S0/Ctsuim36dn0XMWoAgMXUL+CpTD06QxRq/Fc0V29+CuUjymI0ZXt12S66i+blx
 NwqccalYdXMtB+UMPy4lQO3MkiXd5Dahti8YEMomqtgGoDyDg1NmuhzOVfvdZX4JgafiqvWCh6p
 fDkWhrKHXdLJeL8TWTRjK0T0gwgLsNZsTs54FL5qMN4u2egIyCZQNCHIDt51Gd5XR76QCM6I5jo
 gJQxy6lYTnNZ2DPJ5NNvx6hkjzPp3OZz6aqeR+FNy5pqxRIUdgKTgvf38209o0gBxKbeGmgKhwO
 vtgdQxfotCsYMyagzYjiDuPwcP0Z6/d3Pc+7CxD5EU7f3L5yw7YYLbRDN6DcGuCL70OZNj8jT6V
 czvXStsZiuD7eoyPD0wtbiPUMXmoTgp8D169y1VPpmab3INdEnM51w=
X-Google-Smtp-Source: AGHT+IGXfrm3jnfpJ3ukTom6cEGIXd2N2QRC2mgcc+W/HfJoCdkHraHKky5L7CXq91dfDwAXcwTX3A==
X-Received: by 2002:a05:6402:50d0:b0:63b:dfab:6d5f with SMTP id
 4fb4d7f45d1cf-64044188b5emr2077928a12.5.1761738076206; 
 Wed, 29 Oct 2025 04:41:16 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24cb:f700:23e8:3719:bda9:8268?
 (20014C4E24CBF70023E83719BDA98268.dsl.pool.telekom.hu.
 [2001:4c4e:24cb:f700:23e8:3719:bda9:8268])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63e7efd0c1fsm11724033a12.37.2025.10.29.04.41.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 04:41:15 -0700 (PDT)
Message-ID: <2d5377e280e58e86d7c9cdda5497143ec853c263.camel@gmail.com>
Subject: Re: [PATCH 01/14] drm/amdgpu/gmc: Don't hardcode GART page count
 before GTT
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 Alexandre Demers <alexandre.f.demers@gmail.com>, Rodrigo Siqueira
 <siqueira@igalia.com>
Cc: "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>
Date: Wed, 29 Oct 2025 12:41:14 +0100
In-Reply-To: <f1e7e9ff-5314-4ace-9ced-42110ea791be@amd.com>
References: <20251028220628.8371-1-timur.kristof@gmail.com>
 <20251028220628.8371-2-timur.kristof@gmail.com>
 <f1e7e9ff-5314-4ace-9ced-42110ea791be@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
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

On Wed, 2025-10-29 at 11:00 +0100, Christian K=C3=B6nig wrote:
> On 10/28/25 23:06, Timur Krist=C3=B3f wrote:
> > GART contains some pages in its address space that come before
> > the GTT and are used for BO copies.
> >=20
> > Instead of hardcoding the size of the GART space before GTT,
> > make it a field in the amdgpu_gmc struct. This allows us to map
> > more things in GART before GTT.
> >=20
> > Split this into a separate patch to make it easier to bisect,
> > in case there are any errors in the future.
>=20
> Pierre-Eric has been working on something similar.
>=20
> On the newer HW generations we need more transfer windows since we
> want to utilize more DMA engines for copies and clears.
>=20
> My suggestion is that we just make AMDGPU_GTT_NUM_TRANSFER_WINDOWS
> depend on adev and so the HW generation and then reserve one extra
> transfer window for this workaround on SI.

I think the best would be to leave this patch as-is to avoid conflicts
with Pierre-Eric's work. After that work lands, we can revisit this
workaround.

Does that sound reasonable to you?

>=20
> Regards,
> Christian.
>=20
> >=20
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> > =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c=C2=A0=C2=A0=C2=A0=C2=A0 |=
 2 ++
> > =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h=C2=A0=C2=A0=C2=A0=C2=A0 |=
 1 +
> > =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 2 +-
> > =C2=A03 files changed, 4 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > index 97b562a79ea8..bf31bd022d6d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > @@ -325,6 +325,8 @@ void amdgpu_gmc_gart_location(struct
> > amdgpu_device *adev, struct amdgpu_gmc *mc,
> > =C2=A0		break;
> > =C2=A0	}
> > =C2=A0
> > +	mc->num_gart_pages_before_gtt =3D
> > +		AMDGPU_GTT_MAX_TRANSFER_SIZE *
> > AMDGPU_GTT_NUM_TRANSFER_WINDOWS;
> > =C2=A0	mc->gart_start &=3D ~(four_gb - 1);
> > =C2=A0	mc->gart_end =3D mc->gart_start + mc->gart_size - 1;
> > =C2=A0	dev_info(adev->dev, "GART: %lluM 0x%016llX - 0x%016llX\n",
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> > index 55097ca10738..568eed3eb557 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> > @@ -266,6 +266,7 @@ struct amdgpu_gmc {
> > =C2=A0	u64			fb_end;
> > =C2=A0	unsigned		vram_width;
> > =C2=A0	u64			real_vram_size;
> > +	u32			num_gart_pages_before_gtt;
> > =C2=A0	int			vram_mtrr;
> > =C2=A0	u64=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mc_mask;
> > =C2=A0	const struct firmware=C2=A0=C2=A0 *fw;	/* MC firmware */
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> > index 0760e70402ec..4c2563a70c2b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> > @@ -283,7 +283,7 @@ int amdgpu_gtt_mgr_init(struct amdgpu_device
> > *adev, uint64_t gtt_size)
> > =C2=A0
> > =C2=A0	ttm_resource_manager_init(man, &adev->mman.bdev,
> > gtt_size);
> > =C2=A0
> > -	start =3D AMDGPU_GTT_MAX_TRANSFER_SIZE *
> > AMDGPU_GTT_NUM_TRANSFER_WINDOWS;
> > +	start =3D adev->gmc.num_gart_pages_before_gtt;
> > =C2=A0	size =3D (adev->gmc.gart_size >> PAGE_SHIFT) - start;
> > =C2=A0	drm_mm_init(&mgr->mm, start, size);
> > =C2=A0	spin_lock_init(&mgr->lock);
