Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8EDCD5BD5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2026 14:34:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 870D088C4C;
	Wed, 27 May 2026 14:34:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LFwZxDAP";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 923A988C4C
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2026 14:34:36 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-43fe608cb92so7238051f8f.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2026 07:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779892475; x=1780497275; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g0l3QMDmLkGp/VA5PaWhQOeZ8ImsFrgHglUHf29FLsw=;
 b=LFwZxDAPin8anPMcYYdkUoze/ra/QI+1mIcCCcImJyfcgSQfhXOmXlsZv/y0CMhsIU
 lP4dV9ryFeKwsNHSA3qjsq/QRtvlp5n2LWrPheALl5t65joSBmBhcNVmpDPfASxDVoHO
 iEq7FRCfSsu+2sRLP4zCe0hzBlyX7qVkyEPK9IbcY83iZj7mrOSbaFY5bgSTAGgc++uz
 QvGTp5s1X9M+nITctv8TWUS7fJVxizhs7rSsN/jDrLMbNUcp53GfjLDsXoLHMuZdekos
 1XgE9p2xIZowdzBtZujHYMfnMmNU4z9y/IaeT6r6kXrwWwN/gjlV2PnE5bKBa+34VMrx
 UyeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779892475; x=1780497275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g0l3QMDmLkGp/VA5PaWhQOeZ8ImsFrgHglUHf29FLsw=;
 b=U1WL8fcLKhT8jkl3wwNN9WQaEoCMDmJIPB7PYpDo/+GviGvFoFjGw2GFC86BLamWg9
 qF97KhlfnlCPGcXYscpecSwESnYitVFNy59oDuqbEqL5D4lWXx2xBh7/Cfybu1qeKJS+
 BrFMKPM1SJ3f7x3ZEVobHw/r4DcocDRKQOr4zgZgm6v6Obe4gL04UDFk8lgEN8LP5odk
 pL6Mu9QGCSI4SU3e5saVcJLbmI3kxKT+4A3DC9tWE1AXSc9Y32dgl7s8jEEXFVqxiszs
 8sm1qoo32fvoDFdDtSc50+Gz1TXbGGl9ekn7IngiXWpsosR4A5YfCOYQS1urPR6PYQL5
 /2UA==
X-Gm-Message-State: AOJu0YxP37oEEFBCU75Bf8pFbmMQd3dLfchgRqqwap0FBGhKVsIpv71t
 NyCjOYEzR4oBZ9HTZyXYD5mdFUuzwrNzTN2LXdXV9/TXQzlaSjynjse3j5JiEa1S
X-Gm-Gg: Acq92OH3Trb7aGCZ3FVtVceTxxHBJZZOOnXY2bpCO4LV2fER6NC3QsglXjUI5WUeYpk
 zAamkIOZ092rm2f94AaL1jhEqUzVYLWF83g1PFVMXP8IzaEzKF6o1jD4e0sFhn38yaSySJk/XSy
 dRnQGKlD9W9igDHBWluMGJChD/JuaVUg5c9K+7OfICDu9I7KdYC6Ul1G3BZ4HMFgUqVOZP7Omgm
 SQlOq1vKFcj4VQTSpNjmhyqnCKXYzap7fu10gsXaUEH/imDddbSK39xaKRFDcmuS6HOvViY3O4L
 WZvA/XYIEn9mlq5i7QvXR5mTDOQ4Nd8umNzInHdSNmD86Ng7pDi3yxuv60iK8ofA9IrvhfZ4cRz
 dTC+TNWSoxY9PLn6cnqE+NaR0ycxs4AmHBUZGUU+CcdRgstzyehA+52GOQemzgzoDYzu6hkFcmm
 Ftp4go7MStvNeUE5DBAmdn5uwlHizteMzVSSkss6/dHtUXKDslRLEOMmH1
X-Received: by 2002:a5d:5d82:0:b0:454:a12c:6cdb with SMTP id
 ffacd0b85a97d-45eb36b0b6cmr39348524f8f.2.1779892474847; 
 Wed, 27 May 2026 07:34:34 -0700 (PDT)
Received: from timur-max.localnet (zugloihajos.finet.hu. [212.108.221.74])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5c27e7sm6466252f8f.35.2026.05.27.07.34.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 07:34:34 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>, Donet Tom <donettom@linux.ibm.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, donettom@linux.ibm.com
Subject: Re: [PATCH v3] drm/amdgpu: Fix incorrect VRAM GART mappings on non-4K
 page size systems
Date: Wed, 27 May 2026 16:34:33 +0200
Message-ID: <10065023.eNJFYEL58v@timur-max>
In-Reply-To: <20260527131931.1133797-1-donettom@linux.ibm.com>
References: <20260527131931.1133797-1-donettom@linux.ibm.com>
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

On 2026. m=C3=A1jus 27., szerda 15:19:31 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=C3=
=A1ri id=C5=91 Donet Tom wrote:
> When mapping VRAM pages into the GART page table,
> amdgpu_gart_map_vram_range() assumes that the system page size is the
> same as the GPU page size.
>=20
> On systems with non-4K page sizes, multiple GPU pages can exist within
> a single CPU page. As a result, the mappings are created incorrectly
> because fewer page table entries are programmed than required.
>=20
> Fix this by programming the mappings correctly for non-4K page size
> systems.
>=20
> Fixes: 237d623ae659 ("drm/amdgpu/gart: Add helper to bind VRAM pages (v2)=
")
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> ---

Thank you! The fix looks good to me.
Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>


> v2 -> v3
> - Addressed Christian's review comments and added the Reviewed-by tag.
>=20
> v2 -
> https://lore.kernel.org/all/20260527111750.1084088-1-donettom@linux.ibm.c=
om
> / v1 -
> https://lore.kernel.org/all/20260522112838.1311531-1-donettom@linux.ibm.c=
om
> / ---
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c index b6f849d51c2e..c4c21dbbbd=
bf
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> @@ -394,7 +394,8 @@ void amdgpu_gart_map_vram_range(struct amdgpu_device
> *adev, uint64_t pa, uint64_t start_page, uint64_t num_pages,
>  				uint64_t flags, void *dst)
>  {
> -	u32 i, idx;
> +	u32 i, j, t, idx;
> +	u64 page_base;
>=20
>  	/* The SYSTEM flag indicates the pages aren't in VRAM. */
>  	WARN_ON_ONCE(flags & AMDGPU_PTE_SYSTEM);
> @@ -402,9 +403,12 @@ void amdgpu_gart_map_vram_range(struct amdgpu_device
> *adev, uint64_t pa, if (!drm_dev_enter(adev_to_drm(adev), &idx))
>  		return;
>=20
> -	for (i =3D 0; i < num_pages; ++i) {
> -		amdgpu_gmc_set_pte_pde(adev, dst,
> -			start_page + i, pa + AMDGPU_GPU_PAGE_SIZE *=20
i, flags);
> +	page_base =3D pa;
> +	for (i =3D 0, t =3D 0; i < num_pages; i++) {
> +		for (j =3D 0; j < AMDGPU_GPU_PAGES_IN_CPU_PAGE; j++, t++)=20
{
> +			amdgpu_gmc_set_pte_pde(adev, dst, start_page=20
+ t, page_base, flags);
> +			page_base +=3D AMDGPU_GPU_PAGE_SIZE;
> +		}
>  	}
>=20
>  	drm_dev_exit(idx);




