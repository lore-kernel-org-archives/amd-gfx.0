Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD8E7CD8C9D
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 20:26:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B98910E869;
	Thu, 11 Jun 2026 20:26:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fR+lYCFa";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8317A10E869
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 20:26:52 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-45eec22fab7so96530f8f.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 13:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781209611; x=1781814411; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U6UKCSOJYwha3jIl0JTKzlw3XdatHr2oqfRRYtrV7eM=;
 b=fR+lYCFaHtcoqrfY88JhXYHTk7QffR9CjXtmyVuGssEWHkXhWw4ptpqzLeC5fYeOc3
 yyC5bqag1ARWboGXukWfQJNGu9uAVGtfciBDw4I+t2mC1riBGoPepCt/tpVEA+yMImPs
 Jh7oOhAWfXjvvPBJpFFSfM/c3SSQIB7FFEKA9pX+1BX6NBIeONizZri8zp6YNMCZ9bS3
 Xn7LfAGgHdJ9PHOsa55UcLQa41UVPLq3YTVrIqshQ0reUPZGLYKOEYmTRCLoosmQY5+o
 fqZL9Yw0jf8OuSIBPhI71RpSugISv0UuHs+fOBGkghYJpKrss/ue5D6mRDqVNN+lKsRo
 drTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781209611; x=1781814411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U6UKCSOJYwha3jIl0JTKzlw3XdatHr2oqfRRYtrV7eM=;
 b=JDjH42fvOdDkhmyIbNpUrCB5n8l+EnQxOkD5N9FWxwUaGoYVdeatRJ5TuxWwuWq4CF
 CP9pVybJaNhW6gJx3lo7H2ifS9L8jOHE2UOorEkjrABZq8jNV2Sjj8uLXnF422L19jO1
 dSNnc2AYQ4nHpG4aFBWJ8lAaCZSVZdi/CB5lVg2/biQ/SAWOM7HIhlQ25otCcjJHZlfQ
 75gOTXhJyaUi5Xwwd49DRDeMEM9ZOQf3UbaNnq+hvjK7s8jisuOUf03X6WNK5n0P1+T8
 kyQgGHU5BEQfZTVhqQ5/ToCpfWquoFBJjsI3fLIf5wiagIp8nSSj7UdfrFcbyU60K1f4
 XFxA==
X-Gm-Message-State: AOJu0YyOyTatXnZmmxhCnKCfegdNIcPeoircA/KARSfQB9ZtxRFXj/4Z
 YMGlGxOp/bt85ap7/wjy0QphLd7c8eeGKsC8xJYAEJ2ZFONmpOLH605G
X-Gm-Gg: Acq92OEBHXndlOHvZdyIP7g44BuMMsDNSPt4UBjFJBzhK5UjJmAkdowHhI7VgxeuQN4
 saoBz2PzExwOJvetBuqFPtZl+8ZyqpIjn+Se0FehggsRkRlZN3O0WvNZa+xf4OBsnq1mrm2qyni
 Khm+uKcug3EejZCEYwX/O7kBQbWs0bnz2rvispNuNrQ9v4iE0rshKOGbEyEXA7PQu0oGenXUW4s
 R+U0mEPd5lgdvcu6c+yI3tWsMmVCg1VWYHt66GxiMZgO4FKSzZJzQ0ZXMCdHSyqWeoXr4YID6Ww
 CfhLgMMz42V/BFG+JQ5AGfKT5UJA/zGaPUkrXauQJCVVP7ASiTmZA1sj5dZ2OxrBIy8RrQrKh/+
 bH50vHQk3dPCMKVB6mvY9q9T4cdD1iCLnulVctScnos8sfgIZkjeOTsamUz8pWflvc0wZE+Rrj1
 1CGouUus7/7wlMHyCsvUVLZQAJhVz9Su0jh8QKHQwI83wM2E/aOb8EzG3sNswqg+/qEluOBg==
X-Received: by 2002:a05:600c:4fd4:b0:490:bb59:63b7 with SMTP id
 5b1f17b1804b1-490e561f1f7mr56350485e9.28.1781209610589; 
 Thu, 11 Jun 2026 13:26:50 -0700 (PDT)
Received: from timur-hyperion.localnet (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea7db9c6sm9433255e9.8.2026.06.11.13.26.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 13:26:50 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Jiqian Chen <Jiqian.Chen@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Samuel Pitoiset <samuel.pitoiset@gmail.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Huang Rui <ray.huang@amd.com>,
 Huang Trigger <Trigger.Huang@amd.com>, Jiqian Chen <Jiqian.Chen@amd.com>
Subject: Re: [PATCH v2 1/1] drm/amdgpu/gfx9: Fix Ring and IB test fail after
 mode2
Date: Thu, 11 Jun 2026 22:26:48 +0200
Message-ID: <3694190.dWV9SEqChM@timur-hyperion>
In-Reply-To: <20260611055715.1142135-1-Jiqian.Chen@amd.com>
References: <20260611055715.1142135-1-Jiqian.Chen@amd.com>
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

On Thursday, June 11, 2026 7:57:15=E2=80=AFAM Central European Summer Time =
Jiqian Chen=20
wrote:
> For Renior APU with gfx9, in some test scenarios with disabling
> ring_reset, like accessing an unmapped invalid address, it can
> trigger a gpu job timeout event, then driver uses Mode2 reset
> to reset GPU, but after Mode2 compute Ring test and IB test fail
> randomly. It because the CPC and CPF are still stuck after Mode2,
> that causes compute Ring test fail. What's more, the HQDs of
> MECs are still active, that causes MECs use stale HQDs when MECs
> are unhalted before driver restore MQDs, then causes compute IB
> tests fail.
>=20
> So, add sequences to reset CPC and CPF after Mode2, and de-active
> HQDs of MECs before unhalting MECs.
>=20
> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> ---
> v1->v2 changes:
> * Move my sequences into a new function gfx_v9_0_cp_mode2_clear_state
> * Add reset Mode2 method check to the if condition that call my sequences
>=20
> v1:
> Hi all,
>=20
> My board is Renior APU with gfx9, smu12. I run a testcase that
> accesses an invalid address to trigger a amdgpu_job_timedout()
> with disabling ring_reset, so that driver will call mode2 reset
> directly. After mode2 reset I found compute Ring tests and compute
> IB tests fail randomly on random compute ring.
>=20
> We checked the scan dump of GPU, we can see the CPC and CPF are
> still stuck, that caused Compute Ring tests fail.
>=20
> I added printings in driver codes (gfx_v9_0_cp_resume), and found
> the HQDs of MECs are still active, that may cause MECs use stale
> HQDs when MECs are unhalted before mapping compute queues (restoring
> MQDs to HQDs).
>=20
> So, I send this patch to fix above problems.
> There are two main changes of my patch:
> One is to reset CPC and CPF before resuming KCQ.
> Another is to disable HQDs beofre unhalting MECs.

Hi,

Indeed I've seen similar issues on other GPUs, as I've been looking into=20
improving GPU recovery.

Instead of forcing the HQD_ACTIVE to zero, I suggest to deactivate the HQD=
=20
before reset. We should introduce a gfx_v9_0_deactivate_hqd() function simi=
lar=20
to what gfx_v8_0_deactivate_hqd() is doing, and call that from somewhere in=
=20
gfx_v9_0_hw_fini() when disabling the compute queues.

In fact, it looks like it already deactivates HQD, but only for the KIQ and=
=20
only when it isn't in reset or suspend. That looks wrong to me and I think =
it=20
should do that for all compute queues (in addition to the KIQ) either=20
unconditionally or before a mode2 reset.

What do you think?

I don't have a Renoir APU yet but if you need help, I can try to see if I c=
an=20
reproduce something like this on a Vega 10 dGPU.

Best regards,
Timur

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 44 +++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c index 47721d0c3781..d3ef45aa299a
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -3942,6 +3942,46 @@ static int gfx_v9_0_kcq_resume(struct amdgpu_device
> *adev) return amdgpu_gfx_enable_kcq(adev, 0);
>  }
>=20
> +static void gfx_v9_0_cp_mode2_clear_state(struct amdgpu_device *adev)
> +{
> +	u32 tmp;
> +	int i, j, k;
> +
> +	/*
> +	 * CPC and CPF are still stuck after Mode2 reset, that causes later
> +	 * compute ring test fail and then loop Mode2 reset infinitely
> +	 */
> +	tmp =3D RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
> +	tmp =3D REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPC, 1);
> +	tmp =3D REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPF, 1);
> +	WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
> +	tmp =3D RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
> +	udelay(50);
> +
> +	tmp &=3D ~(GRBM_SOFT_RESET__SOFT_RESET_CPC_MASK |
> +			GRBM_SOFT_RESET__SOFT_RESET_CPF_MASK);
> +	WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
> +	tmp =3D RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
> +	udelay(50);
> +
> +	/*
> +	 * CP_HQD_ACTIVE survives Mode2 reset. Deactivate every MEC HQD to
> +	 * prevent MEC use stale HQD when MEC unhalted before restoring=20
MQD.
> +	 * Otherwise, later compute IB test may fail
> +	 */
> +	for (i =3D 0; i < adev->gfx.mec.num_mec; i++) {
> +		for (j =3D 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
> +			for (k =3D 0; k < adev-
>gfx.mec.num_queue_per_pipe; k++) {
> +				mutex_lock(&adev->srbm_mutex);
> +				soc15_grbm_select(adev, i + 1, j,=20
k, 0, 0);
> +				WREG32_SOC15_RLC(GC, 0,=20
mmCP_HQD_ACTIVE, 0);
> +				soc15_grbm_select(adev, 0, 0, 0,=20
0, 0);
> +				mutex_unlock(&adev->srbm_mutex);
> +			}
> +		}
> +	}
> +}
> +
>  static int gfx_v9_0_cp_resume(struct amdgpu_device *adev)
>  {
>  	int r, i;
> @@ -3967,6 +4007,10 @@ static int gfx_v9_0_cp_resume(struct amdgpu_device
> *adev) gfx_v9_0_cp_gfx_enable(adev, false);
>  	gfx_v9_0_cp_compute_enable(adev, false);
>=20
> +	if ((adev->flags & AMD_IS_APU) && amdgpu_in_reset(adev) &&
> +		amdgpu_asic_reset_method(adev) =3D=3D=20
AMD_RESET_METHOD_MODE2)
> +		gfx_v9_0_cp_mode2_clear_state(adev);
> +
>  	r =3D gfx_v9_0_kiq_resume(adev);
>  	if (r)
>  		return r;




