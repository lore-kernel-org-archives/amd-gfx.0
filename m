Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E1C5D3C91A
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 14:39:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0223410E756;
	Wed, 10 Dec 2025 14:39:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XU+qfrCI";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E7ED10E706
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 13:00:45 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dRG6f1YGGz9t9S;
 Wed, 10 Dec 2025 14:00:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1765371642; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GhnOnPE/R4L0GYlgffmhTyzr1mcfuneZkYDZzeRkkMo=;
 b=XU+qfrCImq/h0VgrV2blG7MVdJThO3FG3r/9KF70HkEXHsMT6m38s/72rIKXVhhhCV8zBZ
 CSy1NId+PHG5SmCjOJvelQ1psYIkcK4fh2/2CoeW8KuLUxzjVwm58De/BTyRlo992ZWHbY
 zpSNydfbAubfpoUYtvZ/ukBHWk6iBP7n7kA2W6wgkptnCFCuIEabWE8U91/JIR2rkwrcAV
 G84abcpnO4tEFZeHBjpkpXmU/lB97eB/CWcblu5ApCZNdtD1n5lvTxw9ti2401eQ17RMm9
 vZlrlPGafl4E5yf31Zr+/5TLox7g1D4qLcU+SM9QA7AxQg2T2lItjvS2rQyTyQ==
Message-ID: <3c90635b46f1a867365fba026edbc28a33ad9d9d.camel@mailbox.org>
Subject: Re: [PATCH] drm/amdgpu: cache the pasid in amdgpu_device_gpu_recover
From: Philipp Stanner <phasta@mailbox.org>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 alexander.deucher@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 vitaly.prosyak@amd.com,  amd-gfx@lists.freedesktop.org
Date: Wed, 10 Dec 2025 14:00:40 +0100
In-Reply-To: <20251210125740.9551-1-christian.koenig@amd.com>
References: <20251210125740.9551-1-christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: 0ecdbb6687ed8f04e4c
X-MBO-RS-META: ch91yjdn9p6wxu1uskz841p8game4eo5
X-Mailman-Approved-At: Wed, 10 Dec 2025 14:39:28 +0000
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
Reply-To: phasta@kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, 2025-12-10 at 13:57 +0100, Christian K=C3=B6nig wrote:
> The job might already be freed up here. So cache the pasid for later
> use.
>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Suggested-by: Philipp Stanner <phasta@mailbox.org>

No! :D

You read the wrong quote.
Matthew found your issue (in the middle of my time zone's night, while
I was peacefully asleep).

> Fixes: a72002cb181f ("drm/amdgpu: Make use of drm_wedge_task_info")

I think there was a gitlab ticket about that a month ago? Could be
added to Closes:


P.

> ---
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++--
> =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 654f4844b7ad..84bb89498e12 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6506,8 +6506,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device =
*adev,
> =C2=A0	struct list_head device_list;
> =C2=A0	bool job_signaled =3D false;
> =C2=A0	struct amdgpu_hive_info *hive =3D NULL;
> -	int r =3D 0;
> =C2=A0	bool need_emergency_restart =3D false;
> +	unsigned int pasid =3D job->pasid;
> +	int r =3D 0;
> =C2=A0
> =C2=A0	/*
> =C2=A0	 * If it reaches here because of hang/timeout and a RAS error is
> @@ -6605,7 +6606,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device =
*adev,
> =C2=A0		struct amdgpu_task_info *ti =3D NULL;
> =C2=A0
> =C2=A0		if (job)
> -			ti =3D amdgpu_vm_get_task_info_pasid(adev, job->pasid);
> +			ti =3D amdgpu_vm_get_task_info_pasid(adev, pasid);
> =C2=A0
> =C2=A0		drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 ti ? &ti->task : NULL);

