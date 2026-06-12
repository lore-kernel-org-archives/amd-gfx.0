Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBCACD98CE
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 06:13:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD99410F26A;
	Fri, 12 Jun 2026 06:13:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HPgNyCc8";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A706E10F26A
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 06:13:05 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-490b915ded5so4710035e9.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 23:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781244784; x=1781849584; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6uekIXxGYkdBnXHeisqWDfwfiR9h2WjXl4zHuu+8QjU=;
 b=HPgNyCc84bgAJqGhKmAQY3p6EzXuiptJpJRoeufRXlllXNEBTyCg4w5iM/tw7Q3dWF
 d3JaqPohZgt9Z35a/oSOAZRcos0uNNNlAbKgBULVN+Ci6LukLuleEEmQXOZMSlTBR2It
 6gvRgYh7RhWegPvS/FSvRLFkQAKK3JlVj3dxoiJ1yAyk8E3O63NS9yVc3mOwW4rhSJAN
 ggBWxyGUi2e+9XoeI7KPmeLYAaga5gT5y7vZ1shhDU6oGd8k5C9URXjXVdYOCMcRPbNF
 TSTZ0hyQSbrZG7A+jZhhUYJvRNKCPbyQXagFk265PHpXdrILzn01l4IAWUDYn3Bkz1us
 u+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781244784; x=1781849584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6uekIXxGYkdBnXHeisqWDfwfiR9h2WjXl4zHuu+8QjU=;
 b=lURejfkBstgM7zlxWJqsAdlT8MCJvtzRB3Umutfc6O5Omw1y1O51gcCeFGlT2sysl6
 WZDeNva0PTChql16CqVcO9CBMFIBS7rMCZ9WQI7wlm8atvEJgOm9tIGx5zKPc3c6wfIG
 LithdY7o0Dy+DVDWHRUpxbeDyGAX+kuZlAVW6Uf1F5Q2dhdPP/AZcmg1+7Y0QXJLNDZe
 LT3gfcW8bThKm5pSGoGXp8HeiPPk16KstkXZSzmP8L6S/KdQyvTTVo6AkTxwcc2tbpPK
 LLYP8AZqcX/9AyJ2GMVNVwgi22nxxVaJoKZXxRkD7Bw0TgigWlhXPgABs56VImYfQWOY
 Ukeg==
X-Gm-Message-State: AOJu0YxOlfK+ZAs7k6KXuIp+6O3+FCPhZjGA+jy7JMlqt6Hyf91yIU/Z
 btQ0pDlvZKM8iIomoFUYbA1yZjICAZeAsd2s5iacZsFrCNpbUeH93Hbz
X-Gm-Gg: Acq92OHtt72PSGwnlmcYrs1BdMyTkMQoyXcrs2FgwHBtukUjrxXERYj3E8gWvxVMHe2
 sb84IuS6pbgCoj1/1KHAwdmHNDnh8q5NLwHkCUOmcr5jm9MI0vzki9M6cBYGu8kIrFv1sfAx8gW
 f1O0aKNjplE9B922TYcPXZe9GZyvBo6VQSp/lYzFb5TXRsaLrGrAsdc0ujoTBYHIHn+XITrTr1p
 kgdKqZ8+ZbSsmeEH6OsU/pF6ByHb8xl9wbzvA5KupjVVswYnSvT/opZD7bv4+vkxv472nxy/PRD
 AdiEOtxMiByLIQg6Am67PH1rScmd7n3dRbKb1TDTeaUOPvcz2QLpjkNwaLw6F1QH/zsrv/w7Vfd
 VKpl6EU7B5AYK5r8padi1/pOWtVr7Fw9O5NajrBTYgLySlFFrQa/sgk2sJgAfxh8CKVc2Mkbny6
 BEMOopDM1oUD1Z1DwWhynJWWIbejHCKqvI/t1GC46FzSjMMcy/fieATq/M+NwYu7s6sc2BNX5lz
 0kf9xPM0AEg+GIlBfPgz9RY+29rOQ==
X-Received: by 2002:a05:600c:1d15:b0:490:a2fd:e1e5 with SMTP id
 5b1f17b1804b1-490ec504c92mr12887945e9.17.1781244784018; 
 Thu, 11 Jun 2026 23:13:04 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24EDFA00ACE56DB4A62D1E35.dsl.pool.telekom.hu.
 [2001:4c4e:24ed:fa00:ace5:6db4:a62d:1e35])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e2ca1a43sm128071305e9.8.2026.06.11.23.13.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 23:13:03 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com, christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 02/13] drm/amdgpu: give different sizes for each SA pool
 type
Date: Fri, 12 Jun 2026 08:13:02 +0200
Message-ID: <2796234.vuYhMxLoTh@timur-max>
In-Reply-To: <20260529114031.3714-3-christian.koenig@amd.com>
References: <20260529114031.3714-1-christian.koenig@amd.com>
 <20260529114031.3714-3-christian.koenig@amd.com>
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

On 2026. m=C3=A1jus 29., p=C3=A9ntek 13:24:04 k=C3=B6z=C3=A9p-eur=C3=B3pai =
ny=C3=A1ri id=C5=91 Christian K=C3=B6nig=20
wrote:
> The IMMEDIATE (page fault) and DIRECT (reset) pool should be used only
> very rarely and by a single thread.
>=20
> Saves roughly 1.25MiB of memory and GART space for each amdgpu device.
>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   | 8 +++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 2 --
>  2 files changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c index f1ed4a436f5b..334f95f8f339
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -351,14 +351,20 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring,
> unsigned int num_ibs, */
>  int amdgpu_ib_pool_init(struct amdgpu_device *adev)
>  {
> +	const int sizes[AMDGPU_IB_POOL_MAX] =3D {
> +		[AMDGPU_IB_POOL_DELAYED] =3D SZ_1M,
> +		[AMDGPU_IB_POOL_IMMEDIATE] =3D SZ_128K,
> +		[AMDGPU_IB_POOL_DIRECT] =3D SZ_512K
> +	};
>  	int r, i;
>=20
>  	if (adev->ib_pool_ready)
>  		return 0;
>=20
> +

There is a spurious newline here.

Otherwise the patch makes good sense.
Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

>  	for (i =3D 0; i < AMDGPU_IB_POOL_MAX; i++) {
>  		r =3D amdgpu_sa_bo_manager_init(adev, &adev->ib_pools[i],
> -					     =20
AMDGPU_IB_POOL_SIZE, 256,
> +					      sizes[i], 256,
>  					     =20
AMDGPU_GEM_DOMAIN_GTT);
>  		if (r)
>  			goto error;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h index 8f28b3bd7010..1a063a0a42=
80
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -68,8 +68,6 @@ enum amdgpu_ring_priority_level {
>=20
>  #define to_amdgpu_ring(s) container_of((s), struct amdgpu_ring, sched)
>=20
> -#define AMDGPU_IB_POOL_SIZE	(1024 * 1024)
> -
>  enum amdgpu_ring_type {
>  	AMDGPU_RING_TYPE_GFX		=3D AMDGPU_HW_IP_GFX,
>  	AMDGPU_RING_TYPE_COMPUTE	=3D AMDGPU_HW_IP_COMPUTE,




