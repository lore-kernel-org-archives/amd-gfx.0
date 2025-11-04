Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7269ECCFA04
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 17:10:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1404810E293;
	Tue,  4 Nov 2025 17:10:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nq9Uv4Yy";
	dkim-atps=neutral
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C44710E293
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 17:10:36 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-64088c6b309so6191359a12.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Nov 2025 09:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762276235; x=1762881035; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WjIsechpouPS+4l6jnFyXwIQaqxP5wM+7UWujYZP77Y=;
 b=nq9Uv4YyP7iDAh3bg/7WIQTx9X51r1VyCxyRTlpZ3j74nYJz7QDXV8TTZlE/qRW7Pi
 QBlv+pvlXiQxbv7wf35Q4XN2Dw1HoOJ4M/sE++jC7hvjGUWctTLyAu4BtClimNHeQMHo
 5cXvxn2CrjfEiZWArQQLAF7f2ScG2g94uXbZ3c4p6Z/kJtoJwMq+WUFSvBU25KtWNVuK
 FUjEL9XY2lcv2t58Xhjdee9u2OIyUgsqSbiDrzs/vS33x0uy+1JQZBHFdmwWbM3v73VN
 cAPEKRnl/JcMerIYwSPZ1g+1iMIYbI23xg/xZbqSkFUebq70w9/FpGoIXyK3GDZrCQOl
 sL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762276235; x=1762881035;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WjIsechpouPS+4l6jnFyXwIQaqxP5wM+7UWujYZP77Y=;
 b=Jxj46wV3uO0d5xq2nOwwVZLlZ43Fb2ad538DZLK3yfY3r4XAdPxJlkIZNU+KoCkHob
 nwIxf0oKmuhPoPQf4xEyryaRgMXZd4dersl5oQvKB8pFKHwOd4q/+fxNgJB0KVyEERJK
 9PxVsBxS1l1TiFdOW9A1DCW8uqcWO1rpG6FuVOaYCJx+lGN1J33/wW55845nTV9NSW6w
 Hy1GIvNTz2SMqdQ83WQ3zJ4kMwlXINzhjCjg/x1pEveKhyUD83Vq4vf13OWBrk9imXZ0
 OxRW5sGlFFz+taD/ZV/YhJdbH7QNex+HUoVX321Z3sqn05moromXbOLdX5VQtNoJy4sY
 ttcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCViFU7FIPZgP4xVujL4muOVO5M2PXHUZPDtV29OfPIgVw4dsZwOiktDMbgzVivhcrvg/6Rpdb14@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy5sPxA4kvFFhyeIK+EFzfm3e9ZUVOOxxgC8xIJIQYpXMYchOM1
 iBCYqomwOzKD0YdOn1yrkQpo/DeGQDrQ3SUCJYrfIP5ZIERGu6D5SiET
X-Gm-Gg: ASbGnctcfhSzTeWaxzXUfYJCcKshRY/wWuE8YpryYAAhhSE9Er1W2qTWkAzK5VisZ9L
 qYafE0pMl2ex25SuTB9gSLCWD282yOeu9nphRs135t5VHAQKBETxkfexT3tN5oCvJCl1hj+ZHQv
 Ms3+KZ3KSyCD7XNP2UU+Mqnx22pGimXYTaURMuV9l75GWexncLaj1LBlVMB85qzSAVE5Mvk6wtL
 biYQrQgBBXP2rh+L//S6ucDbgCuX+a86l3cs+oJQjZ2Ratd1laI6DDYZT61XKiTDbKeRE9I06WY
 IXupqzyrkGjXwYKwSnwsd+BLBZ3ZYYB1modwX4ck+6nGyluTorUxi3361wYPH1y1BOIBku8I5fw
 /Ha2nRjKCrklvnkZliE7SFrOfEc+gdv13bmD28WPEc5XdoZLNcaR4Ks1ZzztKh1HYiufku/Lw84
 pWJzIUOO3X2kXX371mfmd7zN5hVtlQvCs3qDBKTA3ZSUSrlNHXXQmByWd/S+4ZYwLeemTkp1qTR
 udGlZEKxaspKWw7VCEh9FL2znK4alv6WX/1HEpJlQ+LY2aD7Uuh
X-Google-Smtp-Source: AGHT+IGkwFXlQaQm4PsyzZ4qTCCypAry6jNibeDSvJfC91MY7ZSOzuCmoy0turQsEh1IAUsQypE4KQ==
X-Received: by 2002:a17:907:6d09:b0:b6d:801a:648 with SMTP id
 a640c23a62f3a-b70706271famr1884928166b.48.1762276234715; 
 Tue, 04 Nov 2025 09:10:34 -0800 (PST)
Received: from ?IPv6:2001:4c4e:24ca:a400:8825:f46d:d14d:d33?
 (20014C4E24CAA4008825F46DD14D0D33.dsl.pool.telekom.hu.
 [2001:4c4e:24ca:a400:8825:f46d:d14d:d33])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b723fa023adsm251945466b.51.2025.11.04.09.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 09:10:34 -0800 (PST)
Message-ID: <740c84405156456c01ab89c45a087cb75bcad597.camel@gmail.com>
Subject: Re: [PATCH 01/16] drm/amdgpu/gmc: Don't hardcode GART page count
 before GTT
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher	 <alexander.deucher@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,  Rodrigo Siqueira
 <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
Date: Tue, 04 Nov 2025 18:10:33 +0100
In-Reply-To: <30d7073e8289db8a2db9d1ae15b33ca50680364c.camel@gmail.com>
References: <20251103222333.37817-1-timur.kristof@gmail.com>
 <20251103222333.37817-2-timur.kristof@gmail.com>
 <9b4daf2b-d97d-4b3d-bd7b-3b136a4e304c@amd.com>
 <237b5110-bf9b-452a-ab51-51ca67f7589d@damsy.net>
 <30d7073e8289db8a2db9d1ae15b33ca50680364c.camel@gmail.com>
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

On Tue, 2025-11-04 at 16:26 +0100, Timur Krist=C3=B3f wrote:
> On Tue, 2025-11-04 at 16:08 +0100, Pierre-Eric Pelloux-Prayer wrote:
> >=20
> >=20
> > Le 04/11/2025 =C3=A0 14:23, Christian K=C3=B6nig a =C3=A9crit=C2=A0:
> > >=20
> > >=20
> > > On 11/3/25 23:23, Timur Krist=C3=B3f wrote:
> > > > GART contains some pages in its address space that come before
> > > > the GTT and are used for BO copies.
> > > >=20
> > > > Instead of hardcoding the size of the GART space before GTT,
> > > > make it a field in the amdgpu_gmc struct. This allows us to map
> > > > more things in GART before GTT.
> > > >=20
> > > > Split this into a separate patch to make it easier to bisect,
> > > > in case there are any errors in the future.
> > > >=20
> > > > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > > ---
> > > > =C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c=C2=A0=C2=A0=C2=A0=C2=
=A0 | 2 ++
> > > > =C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h=C2=A0=C2=A0=C2=A0=C2=
=A0 | 1 +
> > > > =C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 2 +-
> > > > =C2=A0 3 files changed, 4 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > > > index 97b562a79ea8..bf31bd022d6d 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > > > @@ -325,6 +325,8 @@ void amdgpu_gmc_gart_location(struct
> > > > amdgpu_device *adev, struct amdgpu_gmc *mc,
> > > > =C2=A0=C2=A0		break;
> > > > =C2=A0=C2=A0	}
> > > > =C2=A0=20
> > > > +	mc->num_gart_pages_before_gtt =3D
> > > > +		AMDGPU_GTT_MAX_TRANSFER_SIZE *
> > > > AMDGPU_GTT_NUM_TRANSFER_WINDOWS;
> > > > =C2=A0=C2=A0	mc->gart_start &=3D ~(four_gb - 1);
> > > > =C2=A0=C2=A0	mc->gart_end =3D mc->gart_start + mc->gart_size - 1;
> > > > =C2=A0=C2=A0	dev_info(adev->dev, "GART: %lluM 0x%016llX -
> > > > 0x%016llX\n",
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> > > > index 55097ca10738..568eed3eb557 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> > > > @@ -266,6 +266,7 @@ struct amdgpu_gmc {
> > > > =C2=A0=C2=A0	u64			fb_end;
> > > > =C2=A0=C2=A0	unsigned		vram_width;
> > > > =C2=A0=C2=A0	u64			real_vram_size;
> > > > +	u32			num_gart_pages_before_gtt;
> > > > =C2=A0=C2=A0	int			vram_mtrr;
> > > > =C2=A0=C2=A0	u64=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mc_ma=
sk;
> > > > =C2=A0=C2=A0	const struct firmware=C2=A0=C2=A0 *fw;	/* MC firmware =
*/
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> > > > index 0760e70402ec..4c2563a70c2b 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> > > > @@ -283,7 +283,7 @@ int amdgpu_gtt_mgr_init(struct
> > > > amdgpu_device
> > > > *adev, uint64_t gtt_size)
> > > > =C2=A0=20
> > > > =C2=A0=C2=A0	ttm_resource_manager_init(man, &adev->mman.bdev,
> > > > gtt_size);
> > > > =C2=A0=20
> > > > -	start =3D AMDGPU_GTT_MAX_TRANSFER_SIZE *
> > > > AMDGPU_GTT_NUM_TRANSFER_WINDOWS;
> > > > +	start =3D adev->gmc.num_gart_pages_before_gtt;
> > >=20
> > > I would prefer that we have a single function which returns the
> > > number of GART pages we need before the dynamic GTT mapping.
> > >=20
> > > But let me see how Pierre-Eric solved this first.
> > >=20
> >=20
> > The only conflicting change with my series is that I changed this:
> >=20
> > -	start =3D AMDGPU_GTT_MAX_TRANSFER_SIZE *
> > AMDGPU_GTT_NUM_TRANSFER_WINDOWS;
> > +	start =3D AMDGPU_GTT_MAX_TRANSFER_SIZE * reserved_windows;
> >=20
> > So to account for Timur's change, I would only need to adapt this
> > part:
> >=20
> > +	mc->num_gart_pages_before_gtt =3D
> > +		AMDGPU_GTT_MAX_TRANSFER_SIZE * reserved_windows;
> >=20
>=20
> Hi Christian & Pierre-Eric,
>=20
> I assume this conversation is about the following series:
> drm/amdgpu: use all SDMA instances for TTM clears and moves
>=20
> My question is, which series do we want to land first? I would really
> like VCE1 to get into Linux 6.19, but otherwise I'm OK with either of
> these two options:
>=20
> 1. If Pierre-Eric's series lands sooner: I'm happy to rebase my work
> and use Pierre-Eric's solution.
> 2. If my series lands first: I'm happy to contribute a patch to
> Pierre-
> Eric's series to adapt my workaround to his solution, if that helps.
>=20
> Please let me know how you guys prefer to proceed.
>=20
> Thanks & best regards,
> Timur

We just had a conversation with Christian and Pierre-Eric about this.
We arrived at the following suggested solution:

1. Add a new function to the VCE code which returns the amount of GTT
pages the VCE needs in the GART before GTT. The function would return
the amound of pages necessary for this "hack" on VCE1, and 0 on other
VCE versions.
2. Call that function from amdgpu_gtt_mgr_init(), and add the result to
the "start" variable there.
3. Then there is no need for a "num_gart_pages_before_gtt" variable.

If everyone agrees with this, I will do that in the next version of
this series.


>=20
> > >=20
> > > > =C2=A0=C2=A0	size =3D (adev->gmc.gart_size >> PAGE_SHIFT) - start;
> > > > =C2=A0=C2=A0	drm_mm_init(&mgr->mm, start, size);
> > > > =C2=A0=C2=A0	spin_lock_init(&mgr->lock);
