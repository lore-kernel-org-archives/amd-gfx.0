Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E1EC88E75
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 11:49:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0439710FBF3;
	Tue, 15 Sep 2026 11:49:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hWuWlg+H";
	dkim-atps=neutral
Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com
 [74.125.228.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 155FB10FBF2
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 11:49:01 +0000 (UTC)
Received: by mail-ed2-f12.google.com with SMTP id
 4fb4d7f45d1cf-6a60591ae52so5503927a12.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 04:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789472939; x=1790077739; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fozgkpC8P1uTXJr0309EdjbP096y+ykU4NJzLSGtJyg=;
 b=hWuWlg+HMGwl3ls/VGiw77rSFVedC3G7dS+9tqoSVE5pRTStkvL23Y2HxaPmkKHKHn
 H5wJ1C0buiRXm7UxrtAGyDerbGEuJWuvc92yjVgLTK01KYJXSU80gr4CoBSCjsV8UX1w
 L5UOUTqqFmNRcXwZYtGb/te5QxTRqwpie671f14YCQkd4nXM7GA0w67cXuGCZ0lz64oB
 UdkVW6GOeAqqHu1yGxm2mXXxDMRqLMhe1y5RE001NVj+w1GK1dryhmZpy1FcP3FnXV5A
 CpuodM3S/GN7X4jyimNyxf8n8kHXQl9RjnyM5aRBmHbnIaCyr4HYUmoko3m3vDX1blTs
 KFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789472939; x=1790077739;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fozgkpC8P1uTXJr0309EdjbP096y+ykU4NJzLSGtJyg=;
 b=k3oJNSW0jKFBaGEKCVgTlzYPHHnps+c0RRSu+UZnzKXY3lIVwGa6j+DXpXCLpVuM2q
 R5Q+UKKXppv1QVvVHNcEv0n1V3rBwDueLKK4BIMGMfpacftjL3UhbVwdF2idicrlQdjg
 rIlUmL/LNwKuvKPXyuXCKrWEvrK/ulz/DHFK8kpXV1maj1MaQKxaFuroRQzgWHfgQPyq
 GOS0nnWq8vK2ZOUvSMcyRCHl+hc8vqzBJpFswilmn/dzCe4Ij4MT0xB6gRLIVqnjREb2
 RIpjvJywgBhqpTt4UwMnncLqJCJxppCin7TnwOI2kOlQE03lJZbxKo2FpV2pf/bBpO+o
 iZnw==
X-Gm-Message-State: AFuF++k0McYKCBl5WohpfvFR2NFu40EDFx4qfVD7o2yyTtyOY2BJVJF2
 SlSl+NHmxSk296pBhIAvC6HPmVzeXkBtEXMcy8Fm4z1KvGUeVl0xu2jL8uNMDg==
X-Gm-Gg: AYBFou2jfoFLx/NP5iLTUGoAkC1RRuuLBjw7Uq8keZwFg53CtEpt9hqbB1RjGcVUWdE
 4O4kksGwY4OtfkZDYlmjixqCMO+za0pUhkito6YRfiAFZ91UrT573rL2nBakClAdWliFbjAiqwe
 98UzIyMDIsTtikqySPCaXbQXxwm4u56sr4dhVTAbc/SIWbZRx7DRi6QZtU4C+V1StBiWZbP/hH5
 DsaTcAENFR+jtaJDjQAzPunbMmR66IkDEqv/pPg6rkP/LFXqpVGBq8bxqIdB9oFd8gH00HXHsP/
 lWsFzQWRu76UL+rwpzqs0TMbFUjMmaQj4xDLmP3SoSL2/tvTcFQJuqU7Rc4RLZv59DDt45WbPp1
 eFhBOoj5r9XlThOnkrXYr6dvAsiyHuDAzZm0rUvMogcL+gnvPe+Qb4xd0GE4HThAYMvG0LOCmiG
 r6y2GpwRvbv+ssQlEDntuGfi+V9rLVBwsGThV0PDdKncLIGe/Yu2j+p4n2XlydRb5k6Te/QIcEE
 cAxm62T7O5MRw==
X-Received: by 2002:a05:6402:51c9:b0:6a9:cd42:eeae with SMTP id
 4fb4d7f45d1cf-6a9f6275068mr8169455a12.15.1789472939114; 
 Tue, 15 Sep 2026 04:48:59 -0700 (PDT)
Received: from timur-max.localnet ([2a0a:f640:1610:c196:e61f:9a27:3cc:341])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a9bf18d240sm5464665a12.6.2026.09.15.04.48.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 04:48:58 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: Re: [PATCH v3 0/6] A bit of SDMA (mostly) streamlining
Date: Tue, 15 Sep 2026 13:48:56 +0200
Message-ID: <O1tQ1AQDQIeJjv8ajXx3UQ@gmail.com>
In-Reply-To: <20260914145426.51458-1-tvrtko.ursulin@igalia.com>
References: <20260914145426.51458-1-tvrtko.ursulin@igalia.com>
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

On 2026. szeptember 14., h=C3=A9tf=C5=91 16:54:20 k=C3=B6z=C3=A9p-eur=C3=B3=
pai ny=C3=A1ri id=C5=91 Tvrtko Ursulin=20
wrote:
> Some old plus some new patches which mostly streamline the SDMA ring
> emission, plus a little bit of GFX ring padding optimisation.
>=20
> More or less it is about replacing repeated runtime array walks (and
> conditionals in general) with direct lookups for things which are invaria=
nt
> at runtime.
>=20
> Smoke tested on Steam Deck only.
>=20
> Bloat-o-meter (from a debug build though):
>=20
> add/remove: 14/15 grow/shrink: 70/294 up/down: 53590/-196161 (-142571)
> ...
> Total: Before=3D10822624, After=3D10680053, chg -1.32%
>=20
> ---
> v2/v3:
>  - Tweaks per individual patch changelogs.
>=20
> Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>

Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

The patches look good and make sense to me, but I can't test them right now.
Best regards,
Timur

>=20
> Tvrtko Ursulin (6):
>   drm/amdgpu: Add SDMA ring init helper
>   drm/amdgpu: Add amdgpu_sdma_types.h header
>   drm/amdgpu: Convert SDMA instance and index to direct lookup
>   drm/amdgpu: Cache the SDMA CSA address
>   drm/amdgpu: Extend logical to device instance lookup to all devices
>   drm/amdgpu: Use memset32 for SDMA padding
>=20
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +-
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   |   1 +
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c        |  49 ++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h        |  21 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c      |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c      |  17 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h      |  26 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      |  67 +++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h      | 162 ++++--------------
>  .../gpu/drm/amd/amdgpu/amdgpu_sdma_types.h    | 161 +++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c    |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c       |   1 +
>  drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c    |   3 +-
>  drivers/gpu/drm/amd/amdgpu/cik_sdma.c         |   1 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |   8 +-
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c      |   1 +
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |   1 +
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |   1 +
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |   1 +
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |   1 +
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c      |   1 +
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c      |   1 +
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c      |   1 +
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c      |   1 +
>  drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c        |   1 +
>  drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c        |  25 ++-
>  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        |  25 ++-
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c        |  31 ++--
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      |  39 ++---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |  29 ++--
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |  30 ++--
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |  32 ++--
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        |  31 ++--
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c        |  34 ++--
>  drivers/gpu/drm/amd/amdgpu/soc15_common.h     |   6 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c         |   1 +
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         |   1 +
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         |   1 +
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         |   1 +
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c       |   1 +
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c       |   1 +
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c       |   1 +
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c       |   1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |   2 +
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c |   1 +
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |   1 +
>  drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h     |   7 +-
>  53 files changed, 435 insertions(+), 405 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma_types.h




