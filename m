Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B664606A31B
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 20:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HBgMQiW+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2A3510F835;
	Tue,  3 Nov 2026 20:41:28 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CB0A10F835
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 20:41:23 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a4d7ae1ae9so45994825e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Nov 2026 12:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793738481; x=1794343281; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EYGOdxC2hYF7pmwkE6PpRPFPK8Zo0dfEfpHkQPL9iSo=;
 b=HBgMQiW+ZRjdaC7XpX07e17y20EaCrOESbTRkuC8NZeMS7xhXtl6iWieprUATHt/DM
 1djpWSEifAvtTJUgSaAak0xhR2WzbvznaBhwHpg3Iipki09Of77QqnD+X5998hxe4ihA
 Twu0ulWjl+TVwDp2rrwnBV/KzrZxZNwY+/83WWBYI/Jev72dE/jBUAezP9vpTGdd10vx
 2bxRlKL3IDsMaIKVpF88DQNgjVqdJaM2wXUKOTvUaKxGkFf9KsvLdmowBy1YGgK+bVq+
 bNN8IogBWehKK6JkqeMK/rl7bir0mfdqni+3l3L04iI64hTugdk4c5DgT7bsuqmMhWNP
 SzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793738481; x=1794343281;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EYGOdxC2hYF7pmwkE6PpRPFPK8Zo0dfEfpHkQPL9iSo=;
 b=OdXl4od2A6w/T9t+lWKuuz4j5IFMDhfrMCrm3kr24aZpt2tjf+9M3T++xE8kf6ui4a
 5XgCwm2UHg0JdiX2eT5pTvAOnmuv6QWGfJ78ksYXHoLm5q1oR3mJiDuzfokUvmbtrkKy
 qIwR82dDb65DoURfVjl6aP66e00VzpmQWjOaEeeTA3K1KDBlTBLhc5qxQBmPrkPNnTt9
 niucbW/Wb0Ggeax/6dTi8U0ON8XkWFvqwJT/sQJV34gU4XcwDMY/FBawiwf14N3YoZAW
 hBSei/l6Ooq7oaSIfpND16bFXLG/A9O+t/B+4uZR+UYgXXMgaabd9QHRxvPXRan8vajI
 qe7g==
X-Forwarded-Encrypted: i=1;
 AKwUvByw4OlXdA7rtV8MXkBxVRMQOlXEtx/w9YhmWcIj6/kTJrPFtT7N7ATBz6WN+Mjko4u/yY5xua7H@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/S9oyukgxfUFhD6GluBgH3wwl9qg2DbwAkOJ3UjHvRuHzY36yD
 qWi2m/c/EZkHaU9Gf+G2JpA4j0THbzNMLagb4y3N7vSB+VYMlwwLaByz
X-Gm-Gg: AYBFou1pGI37wkgcGnp9Rvf+R0mlD7KdHuU5ZDOxSNWebWWLVolItCCxAR5K8/Maoy8
 tcMaxzR59QdRe8EFFzSU2i6uRAKp32HILhzGmneTYLyNgf5ZKKvnWnqGQoJkwDlmTqzlKsQpIss
 kwIkCBSR0Z1RPynp9o6jSmVAT6n1+NOVoPvIql2jbVBKBsblrZcpusiVKBYH0/r61xCTMpUXwvl
 MbTtFFZHxDLzpS1l0XoEe0maISsyKzGB/ukE3S52WlKDt56xi98t6hk0I1m6RkgPgwEr/IHN+d0
 fGIqdmvusE1beN14BXAOlRjY/LQZH+GWH7ojl7ez1hQlwCt/uW+0uCx4R4nDf+FEjmW1WDVi9TW
 bsqXWeR0/SnwOAj/Dp4N9hvEqT96jjoXXibDw5BTUGJKsyQBhELxjHHeYZkvQWDdEvTFBhiI2vw
 C53J1Cu+NlUa6ZCDY/YeAbXCDCkqkSZ7796A3DpfyQzTkKbYyjFT0Sk9XC22wQfmk5/7Y7JGOWK
 NKAQFV/UNMsNklmpG8XFff9XJtivy33E01BTM5EfHPZ90hksO1oWJheOtz441i7ASntD9eur5h6
 U0OLPdPHULpc8d4FTOL12RpHI6N44S4LRdrhQV3OBXbkqrMH6CyxdGBynqvS3gdSu1ePMgEgkYo
 rG93PM2Ps
X-Received: by 2002:a05:600c:8183:b0:4a2:1364:252b with SMTP id
 5b1f17b1804b1-4ac198f7338mr273626695e9.35.1793738481364; 
 Tue, 03 Nov 2026 12:41:21 -0800 (PST)
Received: from [192.168.1.86] (240.red-79-154-229.dynamicip.rima-tde.net.
 [79.154.229.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b40ff10f88sm6141215e9.0.2026.11.03.12.41.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 12:41:20 -0800 (PST)
Message-ID: <06afbec39afd388120e16d63c74080977a017619.camel@gmail.com>
Subject: Re: [PATCH v3 15/15] drm/amdgpu/gfx11: enable the gfx engine soft
 reset
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>, 
 Lijo.Lazar@amd.com, Mario.Novales@amd.com, Manu.Rastogi@amd.com, 
 Jiongyu.Zhu@amd.com
Date: Tue, 03 Nov 2026 21:41:19 +0100
In-Reply-To: <20261028085736.3808569-15-Jesse.Zhang@amd.com>
References: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
 <20261028085736.3808569-15-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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

On Wed, 2026-10-28 at 16:56 +0800, Jesse Zhang wrote:
> Report AMDGPU_RESET_TYPE_IP_BLOCK_SOFT_RESET for the gfx rings, with
> amdgpu_gfx_soft_reset_engine() as the soft_reset_engine() callback,
> when
> the reset_engine callback can be used: with MES, async gfx rings and
> the
> RS64 firmware. The reset restarts PFP and ME from the start of their
> RS64 firmware, and remaps the kernel gfx queue through MES from its
> MQD, which the kernel gfx queue only has with async gfx rings. Not on
> SR-IOV VFs.
>=20
> The kernel gfx queue and gfx user queue resets then fall back to a
> soft
> reset of the gfx engine before a full reset. The IP block soft reset
> of
> gfx11 only resets the gfx engine then; the whole IP block
> soft_reset()
> isn't used.
>=20
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
> =C2=A0drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 16 ++++++++++++++++
> =C2=A01 file changed, 16 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index a71dae5d0d3a..41ebd2ead99b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -363,6 +363,7 @@ static void gfx_v11_0_ring_invalidate_tlbs(struct
> amdgpu_ring *ring,
> =C2=A0static void gfx_v11_0_set_safe_mode(struct amdgpu_device *adev, int
> xcc_id);
> =C2=A0static void gfx_v11_0_unset_safe_mode(struct amdgpu_device *adev,
> int xcc_id);
> =C2=A0static void gfx_v11_0_userq_priv_fault_work(struct work_struct
> *work);
> +static bool gfx_v11_0_engine_reset_supported(struct amdgpu_device
> *adev);
> =C2=A0static int gfx_v11_0_reset_engine(struct amdgpu_device *adev,
> =C2=A0				=C2=A0 enum amd_ip_engine engine);
> =C2=A0static bool gfx_v11_0_read_gfx_hqd_ptrs(struct amdgpu_device *adev,
> @@ -1945,6 +1946,10 @@ static int gfx_v11_0_sw_init(struct
> amdgpu_ip_block *ip_block)
> =C2=A0		break;
> =C2=A0	}
> =C2=A0
> +	if (gfx_v11_0_engine_reset_supported(adev) &&
> +	=C2=A0=C2=A0=C2=A0 !adev->debug_disable_ip_block_soft_reset)
> +		adev->gfx.gfx_supported_reset |=3D
> AMDGPU_RESET_TYPE_IP_BLOCK_SOFT_RESET;
> +
> =C2=A0	if (!adev->enable_mes_kiq) {
> =C2=A0		r =3D amdgpu_gfx_kiq_init(adev, GFX11_MEC_HPD_SIZE,
> 0);
> =C2=A0		if (r) {
> @@ -6927,6 +6932,16 @@ static void gfx_v11_0_emit_mem_sync(struct
> amdgpu_ring *ring)
> =C2=A0	amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
> =C2=A0}
> =C2=A0
> +/*
> + * The reset restarts PFP/ME through their RS64 start addresses, and
> remaps the
> + * kernel gfx queue from its MQD, which needs async rings.
> + */
> +static bool gfx_v11_0_engine_reset_supported(struct amdgpu_device
> *adev)
> +{
> +	return !amdgpu_sriov_vf(adev) && adev->enable_mes &&
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amdgpu_async_gfx_ring && adev->gfx=
.rs64_enable;

I tried to test this on Strix Halo but it seems it doesn't work, maybe
due to rs64_enable?

Is there any reason to not enable this on GFX11.5 (and GFX11.7)?

> +}
> +
> =C2=A0/* Restart the PFP and ME pipes from the start of their RS64
> firmware. */
> =C2=A0static void gfx_v11_0_restart_gfx_rs64(struct amdgpu_device *adev)
> =C2=A0{
> @@ -7370,6 +7385,7 @@ static const struct amd_ip_funcs
> gfx_v11_0_ip_funcs =3D {
> =C2=A0	.resume =3D gfx_v11_0_resume,
> =C2=A0	.wait_for_idle =3D gfx_v11_0_wait_for_idle,
> =C2=A0	.soft_reset =3D gfx_v11_0_soft_reset,
> +	.soft_reset_engine =3D amdgpu_gfx_soft_reset_engine,
> =C2=A0	.set_clockgating_state =3D gfx_v11_0_set_clockgating_state,
> =C2=A0	.set_powergating_state =3D gfx_v11_0_set_powergating_state,
> =C2=A0	.get_clockgating_state =3D gfx_v11_0_get_clockgating_state,
