Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671B4606A326
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 21:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uXa07e2X
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC66110E493;
	Fri,  6 Nov 2026 21:02:19 +0000 (UTC)
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0243710E493
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 21:02:12 +0000 (UTC)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-1b1cc08166bso8730c88.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Nov 2026 13:02:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793998932; cv=none;
 d=google.com; s=arc-20260327;
 b=DvVXTvbOGtU9vZd5QPkkqMvv70nTE7gt7PRT/qRSZl/7N3tP17SXFGHM71aFrjSey0
 SC5asKdij93krOLYwvM5+tiifNM6uONqB/xbfmNOZHne2vVL5jCu7Ipfcc5oYTuSPCCy
 jxoRe4ZSba5Le1aWjOknLe01Y81SUQ3Iq8OvBHgYK3SgXVwruH+QwroM8dLlzx2Ljsxq
 L+nDMT6NMSzBDLRf5lu6Ct6QiI8JOEeGgHWwGzRYxU4VMYtNFMEHkZKsNfG2mfx+c7BT
 isVoj8spc2wgPmqqNKbyZLEN27oc809pQwD9M+haL6BHvD6r4d+8Cb8NXfnoO2NAImba
 uGeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VAhXOqcTJFDMsa37hIuWQCQp6FXuY2o15iXi8cjYc6s=;
 fh=ZxvrC6rNjWHvCh5o5yNM8zSSCYAFdK0GMEIYqGOthl0=;
 b=MnCO5jfS1RKW2Z8ZyZrRbPScMtX5D9/U/UK/xp/AF+EYobefIlgvTQSotasRvgLapD
 UqPZx8BsOTf/4Z7LYXwKzz6UwTxSP6sOrmgWTCppsB7sK7EZ9r8Hm14cDSk3tt79n9tP
 EJuTdfUBgcsStRNEdDwrpp+imxCT7cEZO/LxwtZeHUSG7ICy0HpSjB3Qz9oUqHimaRBv
 nkXGamPd3oQ0HninlNdr8QmRLRTaHyYSD6Cclfi45F1cUuX2KbSM3U7yCiWS3ZUJNxb0
 PqIdWVCzx/Cr+P/4N9Ocr8JBh+qjz1vmITigkRcINHyTHiC+LTyXJvXSTgpdSijv44PQ
 goyA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793998932; x=1794603732; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VAhXOqcTJFDMsa37hIuWQCQp6FXuY2o15iXi8cjYc6s=;
 b=uXa07e2X6YsR5mjKK8PCJ5qP86DTACFP+zu6tEi5p1gtho1EZ61yYznY5n1LG2YZcg
 Sr/wuWkrHWsdGfUjqJ5+7xZYkIuQYH0yMJlvHlTueO2E9wF8ffZdgkqVo64k3rw2gdxM
 dEOgvwR2+xmVUqVeX9eLuNQkKNLCkz2z6sKCWePY+JdG2PtQV+bbSvdCypGb23Pgefju
 yjmYh4HgyTNDODuOHJbjTH6ygPGhHk7yqIHL6hXUYajwiOHwfeT7gK6ngessQGpFp/cm
 C8p1d7gTQim0HwFKo3qKIbhxqgpaD2pyLBB6vuhCZQBnAruaVhKf1nvuhaJrvAKRcJ5l
 4lyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793998932; x=1794603732;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VAhXOqcTJFDMsa37hIuWQCQp6FXuY2o15iXi8cjYc6s=;
 b=Viq9QF4x4fnModFkeWXHx0alqB89taUC7w21Q1xGPtJCG/VzMFtX9/kOZq78PUEyl9
 RexfaI2jEoc8rv9EAdjC6VvN/JwdU+UFF+PRxnzsoTiOQUe9vOy58+w4iXAUO0H8ELE0
 3z7j/xSmYyufXeHy7cjTgZUSbq9u/QQ7UonMzXGNtqUrL9h0RgqMx92icxXDsAgHeYCD
 8Vx0MIg7vD01MSczKZ5DrN/cK/Nr01UvsPOQ8DfGFAnFiOipnc8DC0ubces64+qECxEm
 3CM9ZTJHWoNF4a229TKcZIbD9lX4kX6Ys+PjjgKyABReYfL98JOXS0OAmUm0bGRpseul
 JFFA==
X-Gm-Message-State: APuU4Z+U+H23Y2QjN5qD+MxanaUn7XO4qOCZyAXSDCL3vdjuyizUc5Jx
 PPCodpG0qz6v1yQQGKmDsI30JQzwAZhuTCFwtGpCFDPsv83wxU/av8YqHno7cS6QkF72XRZQjj/
 dDF2Czn9gjSr5K9x5HT67PzIcHPsAYCk=
X-Gm-Gg: AYBFou0Q+RilTv5YJYqgklxhUvH+uEhWbqi9Tdurvt5sWoC1T4/QSoG502efsClNDrY
 trGom0zqT+LXJ0s82rezlqhRNtfYxZdrmnEZDrAlLINDQhHMT21VYxlJ7oH2hDJqBLTGV5hRbYB
 HJNgPLUGxccbkRAPJRlWctuCeDlQV2bZ1yffbjiz17PLFpI7BNw+/CsTZa0b9EIgDm0gb+dA1mR
 jefWzvCUwTIwoW5bRIKBe9/lf8ZXIuhl8XnujqK5XJyMXGl4RgaSEWmCIchXbrPP6J41wGOfRhq
 DDjOrTOVHOjmHREjG4teu3B8uI8F7I6ndnrvrtV/EMf6Bfv4JqXtJZffsQJwCl6WzhtUIbuwpHi
 M+m02/ogb8P/HepGc4e+Rm5o9PLSkiizGDLaACrhN8aH9SEyWGBFQQ2UxO3z7Naq39lzjbgnzmf
 ClE6nIM11SHviEn/9VCbbQByM=
X-Received: by 2002:a05:7022:295:10b0:1b2:5f0f:4282 with SMTP id
 a92af1059eb24-1b25f0f4be2mr5061399c88.1.1793998931982; Fri, 06 Nov 2026
 13:02:11 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105000613.3850438-1-alexander.deucher@amd.com>
In-Reply-To: <20261105000613.3850438-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 6 Nov 2026 16:01:59 -0500
X-Gm-Features: AclHuK8OWOtRbMCr-bTvFqfW-g9qbPxXXPsm9tmrTyBBcCkKrnw1es8B7UdGidM
Message-ID: <CADnq5_NMyjm5irMNDxTZQM=mcfiRes2BS0dBdrciPTpQ_oSEMg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add helper function to get hdp base addr
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, frank.min@amd.com, Hawking.Zhang@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ping?

On Wed, Nov 4, 2026 at 7:06=E2=80=AFPM Alex Deucher <alexander.deucher@amd.=
com> wrote:
>
> From: Frank Min <Frank.Min@amd.com>
>
> Add helper function to get hdp base addr.
>
> v2: drop debug message
>
> Signed-off-by: Frank Min <Frank.Min@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/hdp_v8_0.c   | 13 +++++++++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_hdp.h
> index d9f488fa76b94..efd6414bbe12e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
> @@ -35,6 +35,7 @@ struct amdgpu_hdp_funcs {
>         void (*update_clock_gating)(struct amdgpu_device *adev, bool enab=
le);
>         void (*get_clock_gating_state)(struct amdgpu_device *adev, u64 *f=
lags);
>         void (*init_registers)(struct amdgpu_device *adev);
> +       u64 (*get_hdp_base)(struct amdgpu_device *adev);
>  };
>
>  struct amdgpu_hdp {
> diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/hdp_v8_0.c
> index 63afdb5de3d4f..36e2bfbe91395 100644
> --- a/drivers/gpu/drm/amd/amdgpu/hdp_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/hdp_v8_0.c
> @@ -125,8 +125,21 @@ static void hdp_v8_0_get_clockgating_state(struct am=
dgpu_device *adev,
>                 *flags |=3D AMD_CG_SUPPORT_HDP_SD;
>  }
>
> +static u64 hdp_v8_0_get_hdp_base(struct amdgpu_device *adev)
> +{
> +       u32 hdp_base_hi, hdp_base_lo;
> +       u64 hdp_base;
> +
> +       hdp_base_hi =3D RREG32_SOC15(HDP, 0, regHDP_NONSURFACE_BASE_HI);
> +       hdp_base_lo =3D RREG32_SOC15(HDP, 0, regHDP_NONSURFACE_BASE);
> +       hdp_base =3D ((u64)hdp_base_hi << 40) | ((u64)hdp_base_lo << 8);
> +
> +       return hdp_base;
> +}
> +
>  const struct amdgpu_hdp_funcs hdp_v8_0_funcs =3D {
>         .flush_hdp =3D amdgpu_hdp_generic_flush,
>         .update_clock_gating =3D hdp_v8_0_update_clock_gating,
>         .get_clock_gating_state =3D hdp_v8_0_get_clockgating_state,
> +       .get_hdp_base =3D hdp_v8_0_get_hdp_base,
>  };
> --
> 2.56.0
>
