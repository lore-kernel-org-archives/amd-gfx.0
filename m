Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57018CCF9E9
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 11:26:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F36B410E134;
	Wed, 29 Oct 2025 11:26:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QzVhjinh";
	dkim-atps=neutral
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E117110E134
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 11:26:30 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-61feb87fe26so11979435a12.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 04:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761737189; x=1762341989; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PW6nodYYRRzOgHXTc/k6J6eunzcteKyTPUYoXg+YJV4=;
 b=QzVhjinhjtRDUoTbi0fSG43Z6m7DpWuGSdTsZySymYWgN/7r2oJf8Br6RVeXUIOLHL
 E6nFZxgD1SQ2gkiTpQvSCbM4oOBTVtYil7GV+bPNKhTLZ6AHUGckN+I/truEf2mTafEe
 LGCZ4SeUTJgt2SAeMsJX1OwpuF+FctItTRFcsn9rS8pqLjChMo9yP2z38vADnbF0IG0U
 NWxHn5YpMY6rFMLdqGqpZ5SbMI69TcVc4axdoEgVG7hPRtZWpJIhzxGTqF6ITxzVEKlM
 GyqraHOFzWqXxm4tDi9y0xNWJxdnYMQ6qt0oBi2yl0GcOlcx+JV0Pzfxb21IAGehvPFr
 cF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761737189; x=1762341989;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PW6nodYYRRzOgHXTc/k6J6eunzcteKyTPUYoXg+YJV4=;
 b=LixbJWu8sRD19X8wC80TjG9zo5eIesViBsjN3zP4hkH86jE7fyfHm6VJu5MP9yOraB
 dmWL06ydIW1Q8JQy4ZPL/c31da7vwisXdRT5SwmPsToFII3B4wEmXnHrgje6/mnUqT9o
 Hv9goKsIoG1V8ivOl80F8Af1PN0C1c5ETHcnJctqBBbGFpRNRXHHtBB64SC4tAc/72q+
 SY+b3gfZ2HmDjf3qq5YFLjjpsBeicK73iH02NEn2cLPjER7///kNKjAaFrhdRTrR95t9
 k/x4UWSy3PcXM5ZnGxnjORBTiVuh4/2nMtlLbLXaPHZhiOEG9U7GZn7EnpYEHq+r6nJ5
 Nn6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEY1D4gFNUy6cR1Twbu1JrmSPL97awYXLQYoaADuRqGpdTxszSuV+LmXkVRoaWPNYDLUsRAjvy@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyCbIM/IsDPgWu7bBh8MzY5SQAAj+gJ+hajlC7VB06UUHxlLSvC
 IyDEsNyCSPjsb3K5lc3bw1Egh+q20CyKHmUe8BEUOoY1SfjFJ/WBerlb
X-Gm-Gg: ASbGncvmC+inksP/AePmAqP7vx5SOeHJ1FR+ZnlG8biV70fms7EDUM05jwRul73bLOg
 av+lFs7lagiLYnDj+jEmSvGnxbM23CrkymIvmEk7b4b+Vj64AsXM6hARC5Po4K1PsE5hZzkz9Mw
 xgtymsv+2Ptn8uIAr7NtuBQ/+e0S7KpDfLVRHOnlmiRwH7Z24vj/0Z5nNUVIKLgijc9soxK138S
 V8j/PWwSMqnFE9hANkBrb5Nn/KCreJW2lxaVDv/18FLrs+7CcpIdMJ0AHBn92HgCjCKXdaIyOET
 F8QB6Ux9+h3OGfaNf+z1hZ3JViae7zXXB+FFnzqfuAOs8e0aXwwT4KqqUdO200b9jZEfjdsmIFU
 x1N1g93VBstRJWPb3n/olaG6My2cA3vvQgw8Ubj18UsgBr0A7saRkrO5UfkpSBWKcD67QImGaYr
 eTbaV3s3jasMYHkKr0SgtBCgRCUgnlQEm6MP9vnTRnwJ/2ED8nXuP6OQzGCxQZnnSgXVO/umheg
 qjPi/ogoOR3eik7cglRQYkIwBHPK/CYpvGF58Vlo/F8
X-Google-Smtp-Source: AGHT+IGPweCG+28873TRCy5+bSqEAUTbR7n97hiRahRPSeXirpcIWVc2zD/lzghWdjTiGTIs9s8gOw==
X-Received: by 2002:a05:6402:510e:b0:63e:1354:d9c7 with SMTP id
 4fb4d7f45d1cf-64044272555mr1841131a12.25.1761737189325; 
 Wed, 29 Oct 2025 04:26:29 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24cb:f700:23e8:3719:bda9:8268?
 (20014C4E24CBF70023E83719BDA98268.dsl.pool.telekom.hu.
 [2001:4c4e:24cb:f700:23e8:3719:bda9:8268])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6402a6be2eesm4237020a12.16.2025.10.29.04.26.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 04:26:28 -0700 (PDT)
Message-ID: <dec6272ca0deb718da07bfdd1d932fb5758a931c.camel@gmail.com>
Subject: Re: [PATCH 03/14] drm/amdgpu/gmc6: Add GART space for VCPU BO
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 Alexandre Demers <alexandre.f.demers@gmail.com>, Rodrigo Siqueira
 <siqueira@igalia.com>
Date: Wed, 29 Oct 2025 12:26:28 +0100
In-Reply-To: <2ba47f43-36ed-4805-8d59-fdf37f38deac@amd.com>
References: <20251028220628.8371-1-timur.kristof@gmail.com>
 <20251028220628.8371-4-timur.kristof@gmail.com>
 <2ba47f43-36ed-4805-8d59-fdf37f38deac@amd.com>
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

On Wed, 2025-10-29 at 11:05 +0100, Christian K=C3=B6nig wrote:
> On 10/28/25 23:06, Timur Krist=C3=B3f wrote:
> > Add an extra 16M (4096 pages) to the GART before GTT.
> > This space is going to be used for the VCE VCPU BO.
> >=20
> > Split this into	a separate patch to make it easier to bisect,
> > in case	there are any errors in	the future.
> >=20
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> > =C2=A0drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 5 ++++-
> > =C2=A01 file changed, 4 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> > index 499dfd78092d..bfeb60cfbf62 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> > @@ -214,6 +214,9 @@ static void gmc_v6_0_vram_gtt_location(struct
> > amdgpu_device *adev,
> > =C2=A0	amdgpu_gmc_set_agp_default(adev, mc);
> > =C2=A0	amdgpu_gmc_vram_location(adev, mc, base);
> > =C2=A0	amdgpu_gmc_gart_location(adev, mc,
> > AMDGPU_GART_PLACEMENT_LOW);
> > +
> > +	/* Add space for VCE's VCPU BO so that VCE1 can access it.
> > */
> > +	mc->num_gart_pages_before_gtt +=3D 4096;
>=20
> 4096*4KiB=3D16MiB. Do we really need so much?

Is it enough to have just enough space for the VCPU BO?
In that case, I think we can use just 512 KiB (rounded up) if I
understand the VCPU BO size correctly. That would be 128 pages.

>=20
> > =C2=A0}
> > =C2=A0
> > =C2=A0static void gmc_v6_0_mc_program(struct amdgpu_device *adev)
> > @@ -338,7 +341,7 @@ static int gmc_v6_0_mc_init(struct
> > amdgpu_device *adev)
> > =C2=A0		case CHIP_TAHITI:=C2=A0=C2=A0 /* UVD, VCE do not support
> > GPUVM */
> > =C2=A0		case CHIP_PITCAIRN: /* UVD, VCE do not support
> > GPUVM */
> > =C2=A0		case CHIP_OLAND:=C2=A0=C2=A0=C2=A0 /* UVD, VCE do not support
> > GPUVM */
> > -			adev->gmc.gart_size =3D 1024ULL << 20;
> > +			adev->gmc.gart_size =3D 1040ULL << 20;
>=20
> Ideally that should be a power of two.
>=20
> We can in theory increase it in units of 2MiB without wasting memory,
> but I'm not 100% sure if that is actually tested everywhere.
>=20
> Regards,
> Christian.
>=20
> > =C2=A0			break;
> > =C2=A0		}
> > =C2=A0	} else {
