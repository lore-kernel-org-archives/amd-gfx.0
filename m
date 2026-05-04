Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E74CD3427
	for <amd-gfx@archiver.kernel.org>; Mon,  4 May 2026 20:54:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92A3610E14C;
	Mon,  4 May 2026 20:54:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AKt2UmkS";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C88C10E14C
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 May 2026 20:54:08 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4890d945eb4so30945275e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 May 2026 13:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777928047; x=1778532847; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6d+z0tqO34juau9HxEjc/O916TyjJHWFak0jYDfDOLA=;
 b=AKt2UmkS8KpYyAvpG5sgz2pphSePy+/DdC5zfHfh05yRmIShrvY4K5uuDsbNyJLX1S
 pCwHAFMSar7GV445BtxlmTRzT2riEemud8FjqjIEqJFdGCwVEay96leHBUwFVw4HjG1/
 /Jwi87XGtmv1U+kzBtuIWKeqMEOiYOODRHCB+/SXymZTB3LtxV4p5vn0TsiGrUOm03Ng
 No+Y9h4iEk2MaiZo6lvgcVPtC+GpvPahtUiuzBIRLsXfEow7E8HK66LtABUHgs+EuQlc
 uUCRqoVRlgJZjG/JVWJhnYi7KMoXEHNUHqEqcAgmDPvFHUg1EHtm8Uj1v3NSsu7fbnJL
 8Iaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777928047; x=1778532847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6d+z0tqO34juau9HxEjc/O916TyjJHWFak0jYDfDOLA=;
 b=nYbGjQdAXZTVyq8STXqX1y6Ur0F4WQTOG6t5PZltMCF2WIDaXa91m9A1AXp5c8bQeg
 TD2msWfXxzJLfjCZK9jtM6EAcSqxkhc+8HZhG7xbpdTNIR+z0Rc/chilqxG3owR94Id8
 +IIKduhzEJvHOgVObYu5PwcACuceghPhFWX7yw/+aB77JJZ26A6Sv0ZfiZJoPaX9tgEA
 VSnJsNbx0ZCWF8iWAWgnG3joayVcXXvHBEEBOPxi5vEp2AdsDQTerinT4KGEsDyTfBbl
 AiRLJwhB7SuM6KvjV0RststuIxo7Xhm/mK0ViPPb98oGwhn66iIeiSKc5q7YmTpKvT/w
 8XPw==
X-Gm-Message-State: AOJu0YwD9K6FvZZ6XXlfUM2B0NRYfaYiC4dW3iBdvr/NYJKCIK8GaQbF
 LBO3YudJGS81vPXJfufyHv4mgDSI0slKsTyBHPJDdRZ/5i0J53b/FDCTcZoQdQ==
X-Gm-Gg: AeBDievPqRrOOHJd1Kocs+AmPALroJikKJ6XXz5XAtsOX+OU8XvcOOQWcACvm6kq6NS
 KkPo7EuR9JMfpBh3hjNZpBAzK8Kcq+giFKdZUKsLmMYGviXItnIaODIhiRKzCNFoOcJZBh6/bkN
 qm+wDZva0Ytyzmo+KhwdkKk1mZiZ4ISR0jJbtje6hIEPxmTMOdEfqHj9qkpgUX7CMaPC5wcRpt0
 HKPXpLDQQwCBumQaWSUtyN+R0n1rSm+nUW5WmlOjMrr7fjMs/m1ouGRgjSQAk5e1oKiUhjXNKu7
 ntgHd5aUX/gtdWii6VXnMH8yNE7sIoThNbnhZRszLtBDcTuYCH91wpuwg05uGu+7QaQpevRVT6m
 FCQIn/WvWLsApzCUJWY8fxRLAyER10tYqmJb6ZHmwBJaz1t8xrYQiROvVa8g7qNFL4LRiWRIfuR
 8cW3qOAGdZHGTP0ttHSYw+TTqnY+LcrK26Wtmqewd/6luRetfz4hHP14rPHnh05UZna0x2ZimQB
 g2cDnt9EA==
X-Received: by 2002:a05:600c:4e16:b0:486:f893:56c6 with SMTP id
 5b1f17b1804b1-48d1425b450mr16499855e9.10.1777928046266; 
 Mon, 04 May 2026 13:54:06 -0700 (PDT)
Received: from timur-hyperion.localnet (5401DFC2.dsl.pool.telekom.hu.
 [84.1.223.194]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a81ed6bafsm625651905e9.2.2026.05.04.13.54.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 13:54:05 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Harry.Wentland@amd.com, Aurabindo.Pillai@amd.com,
 mario.limonciello@amd.com, wiagn233@outlook.com, sysdadmin@m1k.cloud,
 Leo Li <sunpeng.li@amd.com>, sunpeng.li@amd.com
Subject: Re: [PATCH] drm/amd/display: Use vline2 interrupt on DCN instead of
 vstartup
Date: Mon, 04 May 2026 22:54:04 +0200
Message-ID: <2349271.vFx2qVVIhK@timur-hyperion>
In-Reply-To: <20260504183649.165131-1-sunpeng.li@amd.com>
References: <20260504183649.165131-1-sunpeng.li@amd.com>
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

On Monday, May 4, 2026 8:36:49=E2=80=AFPM Central European Summer Time=20
sunpeng.li@amd.com wrote:
> From: Leo Li <sunpeng.li@amd.com>
>=20
> [Why]
>=20
> VStartup is an OTG event that fires when the pixel pipeline prepares for
> pixel scanout of the next frame. It was previously used to deliver
> vblank events for commits that do not trigger a fb address update, and
> hence a pflip interrupt (hw cursor updates, for example).
>=20
> The issue with vstartup is that HW can mask the interrupt in cases where
> idle optimizations are enabled or when a HW lock is active. This could
> the explain the range of flip_done timeouts frequently seen in the wild.

Can you help me understand how that could happen with vstartup?
Specifically, what is a "HW lock" and when is it active?

Many users have experienced flip_done timeouts while playing games.
In that scenario, would any idle optimization be enabled or is there a "HW=
=20
lock"?

> DCN hardware provides 3 generic OTG interrupts that can be programmed to
> fire on a specific line. Vline 0 and 1 are currently reserved, with
> vline2 available to use for event delivery. These interrupts cannot
> be masked, as long as the OTG is active.
>=20
> [How]
>=20
> Switch to vline2 for vblank handling. Today, DC will program the
> vline2 position to at vupdate -- the point at which HW latches to
> double-buffered registers.
>=20
> Since all the vline interrupt types share the same interrupt src_id,
> refactor the existing vline0 infrastructure to allow for all the vline0,
> 1, and 2 types.
>=20
> Since this is intended to replace vstartup for DCN, use the same handler
> logic, but be careful to leave DCE on vstartup.

Why not also switch DCE?
Does DCE not have the vline interrupts or does it not have the same issue w=
ith=20
the vstartup interrupt?

>=20
> Signed-off-by: Leo Li <sunpeng.li@amd.com>

I think this patch should have a "Fixes:" tag or another way to indicate th=
at=20
it should be backported to stable kernels.

Thanks,
Timur

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 165 ++++++++++++------
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   9 +
>  .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  20 ++-
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |  99 +++++++++--
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h |   7 +
>  .../display/dc/irq/dcn10/irq_service_dcn10.c  |  44 +++--
>  .../display/dc/irq/dcn20/irq_service_dcn20.c  |  43 +++--
>  .../dc/irq/dcn201/irq_service_dcn201.c        |  24 ++-
>  .../display/dc/irq/dcn21/irq_service_dcn21.c  |  44 +++--
>  .../display/dc/irq/dcn30/irq_service_dcn30.c  |  44 +++--
>  .../dc/irq/dcn302/irq_service_dcn302.c        |  43 +++--
>  .../dc/irq/dcn303/irq_service_dcn303.c        |  24 ++-
>  .../display/dc/irq/dcn31/irq_service_dcn31.c  |  44 +++--
>  .../dc/irq/dcn314/irq_service_dcn314.c        |  44 +++--
>  .../dc/irq/dcn315/irq_service_dcn315.c        |  44 +++--
>  .../display/dc/irq/dcn32/irq_service_dcn32.c  |  26 +--
>  .../display/dc/irq/dcn35/irq_service_dcn35.c  |  41 +++--
>  .../dc/irq/dcn351/irq_service_dcn351.c        |  43 +++--
>  .../display/dc/irq/dcn36/irq_service_dcn36.c  |  41 +++--
>  .../dc/irq/dcn401/irq_service_dcn401.c        |  25 +--
>  .../display/dc/irq/dcn42/irq_service_dcn42.c  |  26 +--
>  .../gpu/drm/amd/display/dc/irq/irq_service.h  |  23 +++
>  23 files changed, 673 insertions(+), 252 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h index 39894e38fee45..0d84293705107
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -947,7 +947,7 @@ struct amdgpu_device {
>  	/* For pre-DCE11. DCE11 and later are in "struct amdgpu_device-
>dm" */
>  	struct delayed_work         hotplug_work;
>  	struct amdgpu_irq_src		crtc_irq;
> -	struct amdgpu_irq_src		vline0_irq;
> +	struct amdgpu_irq_src		vline_irq;
>  	struct amdgpu_irq_src		vupdate_irq;
>  	struct amdgpu_irq_src		pageflip_irq;
>  	struct amdgpu_irq_src		hpd_irq;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c index
> 3fa4dbda4517c..429f8df17c5d1 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -646,7 +646,8 @@ static void dm_vupdate_high_irq(void *interrupt_param=
s)
>   * Handles the CRTC/VSYNC interrupt by notfying DRM's VBLANK
>   * event handler.
>   */
> -static void dm_crtc_high_irq(void *interrupt_params)
> +static void __dm_crtc_high_irq(void *interrupt_params,
> +			     int otg_inst)
>  {
>  	struct common_irq_params *irq_params =3D interrupt_params;
>  	struct amdgpu_device *adev =3D irq_params->adev;
> @@ -655,7 +656,7 @@ static void dm_crtc_high_irq(void *interrupt_params)
>  	unsigned long flags;
>  	int vrr_active;
>=20
> -	acrtc =3D get_crtc_by_otg_inst(adev, irq_params->irq_src -=20
IRQ_TYPE_VBLANK);
> +	acrtc =3D get_crtc_by_otg_inst(adev, otg_inst);
>  	if (!acrtc)
>  		return;
>=20
> @@ -755,6 +756,13 @@ static void dm_crtc_high_irq(void *interrupt_params)
>  	spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
>  }
>=20
> +static void dm_crtc_high_irq(void *interrupt_params)
> +{
> +	struct common_irq_params *irq_params =3D interrupt_params;
> +	__dm_crtc_high_irq(interrupt_params,
> +			   irq_params->irq_src -=20
DC_IRQ_SOURCE_VBLANK1);
> +}
> +
>  #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
>  /**
>   * dm_dcn_vertical_interrupt0_high_irq() - Handles OTG Vertical interrup=
t0
> for @@ -778,6 +786,17 @@ static void
> dm_dcn_vertical_interrupt0_high_irq(void *interrupt_params) }
>  #endif /* CONFIG_DRM_AMD_SECURE_DISPLAY */
>=20
> +
> +/**
> + * Same as dm_crtc_high_irq, but driven by the vline2 interrupt instead.
> + */
> +static void dm_dcn_vertical_interrupt2_high_irq(void *interrupt_params)
> +{
> +	struct common_irq_params *irq_params =3D interrupt_params;
> +	__dm_crtc_high_irq(interrupt_params,
> +			   irq_params->irq_src -=20
DC_IRQ_SOURCE_DC1_VLINE2);
> +}
> +
>  /**
>   * dmub_aux_setconfig_callback - Callback for AUX or SET_CONFIG command.
>   * @adev: amdgpu_device pointer
> @@ -4752,15 +4771,13 @@ static int dce110_register_irq_handlers(struct
> amdgpu_device *adev) return r;
>  }
>=20
> -/* Register IRQ sources and initialize IRQ callbacks */
> -static int dcn10_register_irq_handlers(struct amdgpu_device *adev)
> +
> +static int dcn10_register_vline_irq_handlers(struct amdgpu_device *adev)
>  {
>  	struct dc *dc =3D adev->dm.dc;
>  	struct common_irq_params *c_irq_params;
>  	struct dc_interrupt_params int_params =3D {0};
> -	int r;
> -	int i;
> -#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
> +	int r, i;
>  	static const unsigned int vrtl_int_srcid[] =3D {
>  		DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL,
>  		DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL,
> @@ -4769,89 +4786,127 @@ static int dcn10_register_irq_handlers(struct
> amdgpu_device *adev) DCN_1_0__SRCID__OTG5_VERTICAL_INTERRUPT0_CONTROL,
>  		DCN_1_0__SRCID__OTG6_VERTICAL_INTERRUPT0_CONTROL
>  	};
> +#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
> +	static const unsigned int vrtl0_int_ctxid[] =3D {
> +		DCN_1_0__CTXID__OTG1_VERTICAL_INTERRUPT0_CONTROL,
> +		DCN_1_0__CTXID__OTG2_VERTICAL_INTERRUPT0_CONTROL,
> +		DCN_1_0__CTXID__OTG3_VERTICAL_INTERRUPT0_CONTROL,
> +		DCN_1_0__CTXID__OTG4_VERTICAL_INTERRUPT0_CONTROL,
> +		DCN_1_0__CTXID__OTG5_VERTICAL_INTERRUPT0_CONTROL,
> +		DCN_1_0__CTXID__OTG6_VERTICAL_INTERRUPT0_CONTROL
> +	};
>  #endif
> +	static const unsigned int vrtl2_int_ctxid[] =3D {
> +		DCN_1_0__CTXID__OTG1_VERTICAL_INTERRUPT2_CONTROL,
> +		DCN_1_0__CTXID__OTG2_VERTICAL_INTERRUPT2_CONTROL,
> +		DCN_1_0__CTXID__OTG3_VERTICAL_INTERRUPT2_CONTROL,
> +		DCN_1_0__CTXID__OTG4_VERTICAL_INTERRUPT2_CONTROL,
> +		DCN_1_0__CTXID__OTG5_VERTICAL_INTERRUPT2_CONTROL,
> +		DCN_1_0__CTXID__OTG6_VERTICAL_INTERRUPT2_CONTROL
> +	};
>=20
>  	int_params.requested_polarity =3D INTERRUPT_POLARITY_DEFAULT;
>  	int_params.current_polarity =3D INTERRUPT_POLARITY_DEFAULT;
>=20
> -	/*
> -	 * Actions of amdgpu_irq_add_id():
> -	 * 1. Register a set() function with base driver.
> -	 *    Base driver will call set() function to enable/disable an
> -	 *    interrupt in DC hardware.
> -	 * 2. Register amdgpu_dm_irq_handler().
> -	 *    Base driver will call amdgpu_dm_irq_handler() for ALL=20
interrupts
> -	 *    coming from DC hardware.
> -	 *    amdgpu_dm_irq_handler() will re-direct the interrupt to DC
> -	 *    for acknowledging and handling.
> -	 */
> -
> -	/* Use VSTARTUP interrupt */
> -	for (i =3D DCN_1_0__SRCID__DC_D1_OTG_VSTARTUP;
> -			i <=3D DCN_1_0__SRCID__DC_D1_OTG_VSTARTUP +=20
adev->mode_info.num_crtc - 1;
> -			i++) {
> -		r =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE, i,=20
&adev->crtc_irq);
> +	for (i =3D 0; i <=3D adev->mode_info.num_crtc - 1; i++) {
> +		r =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE,
> +				vrtl_int_srcid[i], &adev-
>vline_irq);
>=20
>  		if (r) {
> -			drm_err(adev_to_drm(adev), "Failed to add=20
crtc irq id!\n");
> +			drm_err(adev_to_drm(adev),
> +				"Failed to add vline0/1/2 irq id!
\n");
>  			return r;
>  		}
>=20
> +#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
> +		/* Register vline0 */
>  		int_params.int_context =3D INTERRUPT_HIGH_IRQ_CONTEXT;
>  		int_params.irq_source =3D
> -			dc_interrupt_to_irq_source(dc, i, 0);
> +			dc_interrupt_to_irq_source(dc,
> +						  =20
vrtl_int_srcid[i],
> +						  =20
vrtl0_int_ctxid[i]);
>=20
>  		if (int_params.irq_source =3D=3D DC_IRQ_SOURCE_INVALID ||
> -			int_params.irq_source  <=20
DC_IRQ_SOURCE_VBLANK1 ||
> -			int_params.irq_source  >=20
DC_IRQ_SOURCE_VBLANK6) {
> -			drm_err(adev_to_drm(adev), "Failed to=20
register vblank irq!\n");
> +			int_params.irq_source <=20
DC_IRQ_SOURCE_DC1_VLINE0 ||
> +			int_params.irq_source >=20
DC_IRQ_SOURCE_DC6_VLINE0) {
> +			drm_err(adev_to_drm(adev),
> +				"Failed to register vline0 irq!
\n");
>  			return -EINVAL;
>  		}
>=20
> -		c_irq_params =3D &adev-
>dm.vblank_params[int_params.irq_source -
> DC_IRQ_SOURCE_VBLANK1]; +		c_irq_params =3D
> &adev->dm.vline0_params[int_params.irq_source
> +					-=20
DC_IRQ_SOURCE_DC1_VLINE0];
>=20
>  		c_irq_params->adev =3D adev;
>  		c_irq_params->irq_src =3D int_params.irq_source;
>=20
>  		if (!amdgpu_dm_irq_register_interrupt(adev,=20
&int_params,
> -			dm_crtc_high_irq, c_irq_params))
> +			dm_dcn_vertical_interrupt0_high_irq,
> +			c_irq_params))
>  			return -ENOMEM;
> -	}
> -
> -	/* Use otg vertical line interrupt */
> -#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
> -	for (i =3D 0; i <=3D adev->mode_info.num_crtc - 1; i++) {
> -		r =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE,
> -				vrtl_int_srcid[i], &adev-
>vline0_irq);
> -
> -		if (r) {
> -			drm_err(adev_to_drm(adev), "Failed to add=20
vline0 irq id!\n");
> -			return r;
> -		}
> -
> +#endif
> +		/*
> +		 * vline2 shares the same srcids as vline0, but different=20
ctxid.
> +		 */
>  		int_params.int_context =3D INTERRUPT_HIGH_IRQ_CONTEXT;
>  		int_params.irq_source =3D
> -			dc_interrupt_to_irq_source(dc,=20
vrtl_int_srcid[i], 0);
> +			dc_interrupt_to_irq_source(dc,
> +						  =20
vrtl_int_srcid[i],
> +						  =20
vrtl2_int_ctxid[i]);
>=20
>  		if (int_params.irq_source =3D=3D DC_IRQ_SOURCE_INVALID ||
> -			int_params.irq_source <=20
DC_IRQ_SOURCE_DC1_VLINE0 ||
> -			int_params.irq_source >=20
DC_IRQ_SOURCE_DC6_VLINE0) {
> -			drm_err(adev_to_drm(adev), "Failed to=20
register vline0 irq!\n");
> +			int_params.irq_source <=20
DC_IRQ_SOURCE_DC1_VLINE2 ||
> +			int_params.irq_source >=20
DC_IRQ_SOURCE_DC6_VLINE2) {
> +			drm_err(adev_to_drm(adev),
> +				"Failed to register vline2 irq!
\n");
>  			return -EINVAL;
>  		}
>=20
> -		c_irq_params =3D &adev-
>dm.vline0_params[int_params.irq_source
> -					-=20
DC_IRQ_SOURCE_DC1_VLINE0];
> +		c_irq_params =3D &adev-
>dm.vline2_params[int_params.irq_source
> +					-=20
DC_IRQ_SOURCE_DC1_VLINE2];
>=20
>  		c_irq_params->adev =3D adev;
>  		c_irq_params->irq_src =3D int_params.irq_source;
>=20
>  		if (!amdgpu_dm_irq_register_interrupt(adev,=20
&int_params,
> -			dm_dcn_vertical_interrupt0_high_irq,
> +			dm_dcn_vertical_interrupt2_high_irq,
>  			c_irq_params))
>  			return -ENOMEM;
>  	}
> -#endif
> +
> +	return 0;
> +}
> +
> +/* Register IRQ sources and initialize IRQ callbacks */
> +static int dcn10_register_irq_handlers(struct amdgpu_device *adev)
> +{
> +	struct dc *dc =3D adev->dm.dc;
> +	struct common_irq_params *c_irq_params;
> +	struct dc_interrupt_params int_params =3D {0};
> +	int r;
> +	int i;
> +
> +	int_params.requested_polarity =3D INTERRUPT_POLARITY_DEFAULT;
> +	int_params.current_polarity =3D INTERRUPT_POLARITY_DEFAULT;
> +
> +	/*
> +	 * Actions of amdgpu_irq_add_id():
> +	 * 1. Register a set() function with base driver.
> +	 *    Base driver will call set() function to enable/disable an
> +	 *    interrupt in DC hardware.
> +	 * 2. Register amdgpu_dm_irq_handler().
> +	 *    Base driver will call amdgpu_dm_irq_handler() for ALL=20
interrupts
> +	 *    coming from DC hardware.
> +	 *    amdgpu_dm_irq_handler() will re-direct the interrupt to DC
> +	 *    for acknowledging and handling.
> +	 */
> +
> +	r =3D dcn10_register_vline_irq_handlers(adev);
> +	if (r) {
> +		drm_err(adev_to_drm(adev),
> +			"Failed to register vline interrupts\n");
> +		return r;
> +	}
>=20
>  	/* Use VUPDATE_NO_LOCK interrupt on DCN, which seems to correspond=20
to
>  	 * the regular VUPDATE interrupt on DCE. We want=20
DC_IRQ_SOURCE_VUPDATEx
> @@ -9541,7 +9596,8 @@ static void manage_dm_interrupts(struct amdgpu_devi=
ce
> *adev, if (amdgpu_irq_get(adev, &adev->pageflip_irq, irq_type))
>  				drm_err(dev, "DM_IRQ: Cannot get=20
pageflip irq!\n");
>  #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
> -			if (amdgpu_irq_get(adev, &adev->vline0_irq,=20
irq_type))
> +			if (amdgpu_irq_get(adev, &adev->vline_irq,
> +					   DM_VLINE_IRQ(adev,=20
0, irq_type)))
>  				drm_err(dev, "DM_IRQ: Cannot get=20
vline0 irq!\n");
>  #endif
>  		}
> @@ -9554,7 +9610,8 @@ static void manage_dm_interrupts(struct amdgpu_devi=
ce
> *adev, case IP_VERSION(3, 0, 3):
>  		case IP_VERSION(3, 2, 0):
>  #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
> -			if (amdgpu_irq_put(adev, &adev->vline0_irq,=20
irq_type))
> +			if (amdgpu_irq_put(adev, &adev->vline_irq,
> +					   DM_VLINE_IRQ(adev,=20
0, irq_type)))
>  				drm_err(dev, "DM_IRQ: Cannot put=20
vline0 irq!\n");
>  #endif
>  			if (amdgpu_irq_put(adev, &adev->pageflip_irq,=20
irq_type))
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h index
> 1e0ccf58cdb8d..b4e785784a882 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -543,6 +543,15 @@ struct amdgpu_display_manager {
>  	struct common_irq_params
>  	vline0_params[DC_IRQ_SOURCE_DC6_VLINE0 - DC_IRQ_SOURCE_DC1_VLINE0=20
+ 1];
>=20
> +	/**
> +	 * @vline2_params:
> +	 *
> +	 * OTG vertical interrupt0 IRQ parameters, passed to registered
> +	 * handlers when triggered.
> +	 */
> +	struct common_irq_params
> +	vline2_params[DC_IRQ_SOURCE_DC6_VLINE2 - DC_IRQ_SOURCE_DC1_VLINE2 +=20
1];
> +
>  	/**
>  	 * @vupdate_params:
>  	 *
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c index
> efb19f675b0c2..0821b0996a85f 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> @@ -28,6 +28,7 @@
>=20
>  #include "dc.h"
>  #include "amdgpu.h"
> +#include "amdgpu_dm_irq.h"
>  #include "amdgpu_dm_psr.h"
>  #include "amdgpu_dm_replay.h"
>  #include "amdgpu_dm_crtc.h"
> @@ -290,10 +291,19 @@ static inline int amdgpu_dm_crtc_set_vblank(struct
> drm_crtc *crtc, bool enable)
>=20
>  	/* crtc vblank or vstartup interrupt */
>  	if (enable) {
> -		rc =3D amdgpu_irq_get(adev, &adev->crtc_irq, irq_type);
> +		/* vline only available on DCN+ */
> +		if (amdgpu_ip_version(adev, DCE_HWIP, 0) =3D=3D 0)
> +			rc =3D amdgpu_irq_get(adev, &adev->crtc_irq,=20
irq_type);
> +		else
> +			rc =3D amdgpu_irq_get(adev, &adev->vline_irq,
> +					    DM_VLINE_IRQ(adev,=20
2, irq_type));
>  		drm_dbg_vbl(crtc->dev, "Get crtc_irq ret=3D%d\n", rc);
>  	} else {
> -		rc =3D amdgpu_irq_put(adev, &adev->crtc_irq, irq_type);
> +		if (amdgpu_ip_version(adev, DCE_HWIP, 0) =3D=3D 0)
> +			rc =3D amdgpu_irq_put(adev, &adev->crtc_irq,=20
irq_type);
> +		else
> +			rc =3D amdgpu_irq_put(adev, &adev->vline_irq,
> +					    DM_VLINE_IRQ(adev,=20
2, irq_type));
>  		drm_dbg_vbl(crtc->dev, "Put crtc_irq ret=3D%d\n", rc);
>  	}
>=20
> @@ -323,10 +333,12 @@ static inline int amdgpu_dm_crtc_set_vblank(struct
> drm_crtc *crtc, bool enable) /* crtc vline0 interrupt, only available on
> DCN+ */
>  	if (amdgpu_ip_version(adev, DCE_HWIP, 0) !=3D 0) {
>  		if (enable) {
> -			rc =3D amdgpu_irq_get(adev, &adev->vline0_irq,=20
irq_type);
> +			rc =3D amdgpu_irq_get(adev, &adev->vline_irq,
> +					    DM_VLINE_IRQ(adev,=20
0, irq_type));
>  			drm_dbg_vbl(crtc->dev, "Get vline0_irq=20
ret=3D%d\n", rc);
>  		} else {
> -			rc =3D amdgpu_irq_put(adev, &adev->vline0_irq,=20
irq_type);
> +			rc =3D amdgpu_irq_put(adev, &adev->vline_irq,
> +					    DM_VLINE_IRQ(adev,=20
0, irq_type));
>  			drm_dbg_vbl(crtc->dev, "Put vline0_irq=20
ret=3D%d\n", rc);
>  		}
>=20
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c index
> 5948e2a6219e3..757529af72ceb 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> @@ -769,18 +769,86 @@ static int amdgpu_dm_set_crtc_irq_state(struct
> amdgpu_device *adev, __func__);
>  }
>=20
> -static int amdgpu_dm_set_vline0_irq_state(struct amdgpu_device *adev,
> -					struct amdgpu_irq_src=20
*source,
> -					unsigned int crtc_id,
> -					enum=20
amdgpu_interrupt_state state)
> +/**
> + * amdgpu_dm_set_vline_irq_state: Set interrupt state for vline
> + *
> + * Map base driver amdgpu_irq_update() -- called per interrupt src ID --=
 to
> + * their corresponding dc_irq_source, then set then to the requested
> state. + *
> + * Since all the vline0/1/2 interrupts have the same src_id, the standard
> + * amdgpu_irq_src.num_types mapping to the number of OTGs won't work. For
> vline, + * num_types will have to cover (number of different vline
> interrupt types) * + * (number of OTGs) types. For example, if there are 6
> OTGS, then num_types =3D + * 3*6 =3D 18.
> + *
> + * This is only needed for the amdgpu_irq_src_funcs.set_irq implementati=
on;
> the + * .process implementation is provided the interrupt vector, which
> contains both + * the src_id and ctx_id to uniquely map to the
> dc_irq_source.
> + *
> + * The vline_otg_id mapping is first by vline num, then by OTG num:
> + *
> + * | vline_otg_id | vline num | otg num |
> + * |--------------|-----------|---------|
> + * | 0            | 0         | 0       |
> + * | 1            | 0         | 1       |
> + * | ...          | ...       | ...     |
> + * | 5            | 0         | 5       |
> + * | 6            | 1         | 0       |
> + * | ...          | ...       | ...     |
> + * | 11           | 1         | 5       |
> + * | 12           | 2         | 0       |
> + * | ...          | ...       | ...     |
> + * | 17           | 2         | 5       |
> + */
> +static int amdgpu_dm_set_vline_irq_state(struct amdgpu_device *adev,
> +					 struct amdgpu_irq_src=20
*source,
> +					 unsigned int=20
vline_otg_id,
> +					 enum=20
amdgpu_interrupt_state state)
>  {
> -	return dm_irq_state(
> -		adev,
> -		source,
> -		crtc_id,
> -		state,
> -		IRQ_TYPE_VLINE0,
> -		__func__);
> +	bool st;
> +	unsigned int vline_num, otg_num;
> +	enum dc_irq_source irq_source;
> +	struct dc *dc =3D adev->dm.dc;
> +	struct amdgpu_crtc *acrtc;
> +
> +	if (vline_otg_id >=3D 3 * adev->mode_info.num_crtc) {
> +		drm_err(adev_to_drm(adev),
> +			"Invalid vline map_id :%d\n", vline_otg_id);
> +		return -EINVAL;
> +	}
> +
> +	vline_num =3D vline_otg_id / adev->mode_info.num_crtc;
> +	otg_num =3D vline_otg_id % adev->mode_info.num_crtc;
> +	acrtc =3D adev->mode_info.crtcs[otg_num];
> +
> +	if (!acrtc) {
> +		drm_err(adev_to_drm(adev),
> +			"crtc is NULL at id : %d\n", otg_num);
> +		return 0;
> +	}
> +
> +	if (acrtc->otg_inst =3D=3D -1)
> +		return 0;
> +
> +	if (vline_num =3D=3D 0)
> +		irq_source =3D IRQ_TYPE_VLINE0 + otg_num;
> +	else if (vline_num =3D=3D 1)
> +		irq_source =3D IRQ_TYPE_VLINE1 + otg_num;
> +	else if (vline_num =3D=3D 2)
> +		irq_source =3D IRQ_TYPE_VLINE2 + otg_num;
> +	else {
> +		drm_err(adev_to_drm(adev),
> +			"Invalid vline num :%d\n", vline_num);
> +		return -EINVAL;
> +	}
> +
> +	st =3D (state =3D=3D AMDGPU_IRQ_STATE_ENABLE);
> +
> +	if (dc && dc->caps.ips_support && dc->idle_optimizations_allowed)
> +		dc_allow_idle_optimizations(dc, false);
> +
> +	dc_interrupt_set(adev->dm.dc, irq_source, st);
> +	return 0;
>  }
>=20
>  static int amdgpu_dm_set_dmub_outbox_irq_state(struct amdgpu_device *ade=
v,
> @@ -826,8 +894,8 @@ static const struct amdgpu_irq_src_funcs
> dm_crtc_irq_funcs =3D { .process =3D amdgpu_dm_irq_handler,
>  };
>=20
> -static const struct amdgpu_irq_src_funcs dm_vline0_irq_funcs =3D {
> -	.set =3D amdgpu_dm_set_vline0_irq_state,
> +static const struct amdgpu_irq_src_funcs dm_vline_irq_funcs =3D {
> +	.set =3D amdgpu_dm_set_vline_irq_state,
>  	.process =3D amdgpu_dm_irq_handler,
>  };
>=20
> @@ -861,8 +929,9 @@ void amdgpu_dm_set_irq_funcs(struct amdgpu_device *ad=
ev)
> adev->crtc_irq.num_types =3D adev->mode_info.num_crtc;
>  	adev->crtc_irq.funcs =3D &dm_crtc_irq_funcs;
>=20
> -	adev->vline0_irq.num_types =3D adev->mode_info.num_crtc;
> -	adev->vline0_irq.funcs =3D &dm_vline0_irq_funcs;
> +	/* Number of vline types * num OTGs */
> +	adev->vline_irq.num_types =3D 3 * adev->mode_info.num_crtc;
> +	adev->vline_irq.funcs =3D &dm_vline_irq_funcs;
>=20
>  	adev->dmub_outbox_irq.num_types =3D 1;
>  	adev->dmub_outbox_irq.funcs =3D &dm_dmub_outbox_irq_funcs;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h index
> 4f6b58f4f90d7..a672b58b0f760 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
> @@ -27,6 +27,13 @@
>=20
>  #include "irq_types.h" /* DAL irq definitions */
>=20
> +/*
> + * Get OTG vline irq id from vline num and otg num. See also
> + * amdgpu_dm_set_vline_irq_state()
> + */
> +#define DM_VLINE_IRQ(adev, vline_num, otg_num) \
> +	adev->mode_info.num_crtc * vline_num + otg_num
> +
>  /*
>   * Display Manager IRQ-related interfaces (for use by DAL).
>   */
> diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn10/irq_service_dcn10.c
> b/drivers/gpu/drm/amd/display/dc/irq/dcn10/irq_service_dcn10.c index
> 7dff8731f414e..a72fefb531e99 100644
> --- a/drivers/gpu/drm/amd/display/dc/irq/dcn10/irq_service_dcn10.c
> +++ b/drivers/gpu/drm/amd/display/dc/irq/dcn10/irq_service_dcn10.c
> @@ -58,18 +58,6 @@ static enum dc_irq_source to_dal_irq_source_dcn10(stru=
ct
> irq_service *irq_servic return DC_IRQ_SOURCE_VBLANK5;
>  	case DCN_1_0__SRCID__DC_D6_OTG_VSTARTUP:
>  		return DC_IRQ_SOURCE_VBLANK6;
> -	case DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC1_VLINE0;
> -	case DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC2_VLINE0;
> -	case DCN_1_0__SRCID__OTG3_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC3_VLINE0;
> -	case DCN_1_0__SRCID__OTG4_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC4_VLINE0;
> -	case DCN_1_0__SRCID__OTG5_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC5_VLINE0;
> -	case DCN_1_0__SRCID__OTG6_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC6_VLINE0;
>  	case DCN_1_0__SRCID__OTG0_IHC_V_UPDATE_NO_LOCK_INTERRUPT:
>  		return DC_IRQ_SOURCE_VUPDATE1;
>  	case DCN_1_0__SRCID__OTG1_IHC_V_UPDATE_NO_LOCK_INTERRUPT:
> @@ -95,6 +83,19 @@ static enum dc_irq_source to_dal_irq_source_dcn10(stru=
ct
> irq_service *irq_servic case DCN_1_0__SRCID__HUBP5_FLIP_INTERRUPT:
>  		return DC_IRQ_SOURCE_PFLIP6;
>=20
> +	case DCN_VINT_SRCID(1, 0):
> +		DCN_VINT_TO_DC_IRQSRC(1, ext_id);
> +	case DCN_VINT_SRCID(2, 0):
> +		DCN_VINT_TO_DC_IRQSRC(2, ext_id);
> +	case DCN_VINT_SRCID(3, 0):
> +		DCN_VINT_TO_DC_IRQSRC(3, ext_id);
> +	case DCN_VINT_SRCID(4, 0):
> +		DCN_VINT_TO_DC_IRQSRC(4, ext_id);
> +	case DCN_VINT_SRCID(5, 0):
> +		DCN_VINT_TO_DC_IRQSRC(5, ext_id);
> +	case DCN_VINT_SRCID(6, 0):
> +		DCN_VINT_TO_DC_IRQSRC(6, ext_id);
> +
>  	case DCN_1_0__SRCID__DC_HPD1_INT:
>  		/* generic src_id for all HPD and HPDRX interrupts */
>  		switch (ext_id) {
> @@ -157,6 +158,11 @@ static struct irq_source_info_funcs
> vline0_irq_info_funcs =3D { .ack =3D NULL
>  };
>=20
> +static struct irq_source_info_funcs vline2_irq_info_funcs =3D {
> +	.set =3D NULL,
> +	.ack =3D NULL
> +};
> +
>  static struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs =3D {
>  	.set =3D NULL,
>  	.ack =3D NULL
> @@ -239,6 +245,14 @@ static struct irq_source_info_funcs
> vupdate_no_lock_irq_info_funcs =3D { .funcs =3D &vline0_irq_info_funcs\
>  	}
>=20
> +#define vline2_int_entry(reg_num)\
> +	[DC_IRQ_SOURCE_DC1_VLINE2 + reg_num] =3D {\
> +		IRQ_REG_ENTRY(OTG, reg_num,\
> +			OTG_VERTICAL_INTERRUPT2_CONTROL,=20
OTG_VERTICAL_INTERRUPT2_INT_ENABLE,\
> +			OTG_VERTICAL_INTERRUPT2_CONTROL,=20
OTG_VERTICAL_INTERRUPT2_CLEAR),\
> +		.funcs =3D &vline2_irq_info_funcs\
> +	}
> +
>  #define dummy_irq_entry() \
>  	{\
>  		.funcs =3D &dummy_irq_info_funcs\
> @@ -353,6 +367,12 @@ irq_source_info_dcn10[DAL_IRQ_SOURCES_NUMBER] =3D {
>  	vline0_int_entry(3),
>  	vline0_int_entry(4),
>  	vline0_int_entry(5),
> +	vline2_int_entry(0),
> +	vline2_int_entry(1),
> +	vline2_int_entry(2),
> +	vline2_int_entry(3),
> +	vline2_int_entry(4),
> +	vline2_int_entry(5),
>  };
>=20
>  static const struct irq_service_funcs irq_service_funcs_dcn10 =3D {
> diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
> b/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c index
> 34f9e8a9f488f..cbf65367cba5c 100644
> --- a/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
> +++ b/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
> @@ -59,18 +59,6 @@ static enum dc_irq_source to_dal_irq_source_dcn20(
>  		return DC_IRQ_SOURCE_VBLANK5;
>  	case DCN_1_0__SRCID__DC_D6_OTG_VSTARTUP:
>  		return DC_IRQ_SOURCE_VBLANK6;
> -	case DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC1_VLINE0;
> -	case DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC2_VLINE0;
> -	case DCN_1_0__SRCID__OTG3_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC3_VLINE0;
> -	case DCN_1_0__SRCID__OTG4_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC4_VLINE0;
> -	case DCN_1_0__SRCID__OTG5_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC5_VLINE0;
> -	case DCN_1_0__SRCID__OTG6_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC6_VLINE0;
>  	case DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT:
>  		return DC_IRQ_SOURCE_PFLIP1;
>  	case DCN_1_0__SRCID__HUBP1_FLIP_INTERRUPT:
> @@ -96,6 +84,19 @@ static enum dc_irq_source to_dal_irq_source_dcn20(
>  	case DCN_1_0__SRCID__OTG5_IHC_V_UPDATE_NO_LOCK_INTERRUPT:
>  		return DC_IRQ_SOURCE_VUPDATE6;
>=20
> +	case DCN_VINT_SRCID(1, 0):
> +		DCN_VINT_TO_DC_IRQSRC(1, ext_id);
> +	case DCN_VINT_SRCID(2, 0):
> +		DCN_VINT_TO_DC_IRQSRC(2, ext_id);
> +	case DCN_VINT_SRCID(3, 0):
> +		DCN_VINT_TO_DC_IRQSRC(3, ext_id);
> +	case DCN_VINT_SRCID(4, 0):
> +		DCN_VINT_TO_DC_IRQSRC(4, ext_id);
> +	case DCN_VINT_SRCID(5, 0):
> +		DCN_VINT_TO_DC_IRQSRC(5, ext_id);
> +	case DCN_VINT_SRCID(6, 0):
> +		DCN_VINT_TO_DC_IRQSRC(6, ext_id);
> +
>  	case DCN_1_0__SRCID__DC_HPD1_INT:
>  		/* generic src_id for all HPD and HPDRX interrupts */
>  		switch (ext_id) {
> @@ -163,6 +164,11 @@ static struct irq_source_info_funcs
> vline0_irq_info_funcs =3D { .ack =3D NULL
>  };
>=20
> +static struct irq_source_info_funcs vline2_irq_info_funcs =3D {
> +	.set =3D NULL,
> +	.ack =3D NULL
> +};
> +
>  #undef BASE_INNER
>  #define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
>=20
> @@ -244,6 +250,13 @@ static struct irq_source_info_funcs
> vline0_irq_info_funcs =3D { .funcs =3D &vline0_irq_info_funcs\
>  	}
>=20
> +#define vline2_int_entry(reg_num)\
> +	[DC_IRQ_SOURCE_DC1_VLINE2 + reg_num] =3D {\
> +		IRQ_REG_ENTRY(OTG, reg_num,\
> +			OTG_VERTICAL_INTERRUPT2_CONTROL,=20
OTG_VERTICAL_INTERRUPT2_INT_ENABLE,\
> +			OTG_VERTICAL_INTERRUPT2_CONTROL,=20
OTG_VERTICAL_INTERRUPT2_CLEAR),\
> +		.funcs =3D &vline2_irq_info_funcs\
> +	}
>  #define dummy_irq_entry() \
>  	{\
>  		.funcs =3D &dummy_irq_info_funcs\
> @@ -358,6 +371,12 @@ irq_source_info_dcn20[DAL_IRQ_SOURCES_NUMBER] =3D {
>  	vline0_int_entry(3),
>  	vline0_int_entry(4),
>  	vline0_int_entry(5),
> +	vline2_int_entry(0),
> +	vline2_int_entry(1),
> +	vline2_int_entry(2),
> +	vline2_int_entry(3),
> +	vline2_int_entry(4),
> +	vline2_int_entry(5),
>  };
>=20
>  static const struct irq_service_funcs irq_service_funcs_dcn20 =3D {
> diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201=
=2Ec
> b/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c index
> 6417011d22463..7ab8317961734 100644
> --- a/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c
> +++ b/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c
> @@ -47,10 +47,6 @@ static enum dc_irq_source to_dal_irq_source_dcn201(
>  		return DC_IRQ_SOURCE_VBLANK1;
>  	case DCN_1_0__SRCID__DC_D2_OTG_VSTARTUP:
>  		return DC_IRQ_SOURCE_VBLANK2;
> -	case DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC1_VLINE0;
> -	case DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC2_VLINE0;
>  	case DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT:
>  		return DC_IRQ_SOURCE_PFLIP1;
>  	case DCN_1_0__SRCID__HUBP1_FLIP_INTERRUPT:
> @@ -59,6 +55,12 @@ static enum dc_irq_source to_dal_irq_source_dcn201(
>  		return DC_IRQ_SOURCE_VUPDATE1;
>  	case DCN_1_0__SRCID__OTG1_IHC_V_UPDATE_NO_LOCK_INTERRUPT:
>  		return DC_IRQ_SOURCE_VUPDATE2;
> +
> +	case DCN_VINT_SRCID(1, 0):
> +		DCN_VINT_TO_DC_IRQSRC(1, ext_id);
> +	case DCN_VINT_SRCID(2, 0):
> +		DCN_VINT_TO_DC_IRQSRC(2, ext_id);
> +
>  	case DCN_1_0__SRCID__DC_HPD1_INT:
>  		/* generic src_id for all HPD and HPDRX interrupts */
>  		switch (ext_id) {
> @@ -104,6 +106,11 @@ static struct irq_source_info_funcs
> vline0_irq_info_funcs =3D { .set =3D NULL,
>  	.ack =3D NULL
>  };
> +
> +static struct irq_source_info_funcs vline2_irq_info_funcs =3D {
> +	.set =3D NULL,
> +	.ack =3D NULL
> +};
>  static struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs =3D {
>  	.set =3D NULL,
>  	.ack =3D NULL
> @@ -195,6 +202,13 @@ static struct irq_source_info_funcs
> vupdate_no_lock_irq_info_funcs =3D { .funcs =3D &vline0_irq_info_funcs\
>  	}
>=20
> +#define vline2_int_entry(reg_num)\
> +	[DC_IRQ_SOURCE_DC1_VLINE2 + reg_num] =3D {\
> +		IRQ_REG_ENTRY(OTG, reg_num,\
> +			OTG_VERTICAL_INTERRUPT2_CONTROL,=20
OTG_VERTICAL_INTERRUPT2_INT_ENABLE,\
> +			OTG_VERTICAL_INTERRUPT2_CONTROL,=20
OTG_VERTICAL_INTERRUPT2_CLEAR),\
> +		.funcs =3D &vline2_irq_info_funcs\
> +	}
>  #define dummy_irq_entry() \
>  	{\
>  		.funcs =3D &dummy_irq_info_funcs\
> @@ -309,6 +323,8 @@ irq_source_info_dcn201[DAL_IRQ_SOURCES_NUMBER] =3D {
>  	dummy_irq_entry(),
>  	dummy_irq_entry(),
>  	dummy_irq_entry(),
> +	vline2_int_entry(0),
> +	vline2_int_entry(1),
>  };
>=20
>  static const struct irq_service_funcs irq_service_funcs_dcn201 =3D {
> diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
> b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c index
> 05f7877d2d6c8..da1ebb9467c9d 100644
> --- a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
> +++ b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
> @@ -60,18 +60,6 @@ static enum dc_irq_source to_dal_irq_source_dcn21(stru=
ct
> irq_service *irq_servic return DC_IRQ_SOURCE_VBLANK6;
>  	case DCN_1_0__SRCID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT:
>  		return DC_IRQ_SOURCE_DMCUB_OUTBOX;
> -	case DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC1_VLINE0;
> -	case DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC2_VLINE0;
> -	case DCN_1_0__SRCID__OTG3_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC3_VLINE0;
> -	case DCN_1_0__SRCID__OTG4_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC4_VLINE0;
> -	case DCN_1_0__SRCID__OTG5_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC5_VLINE0;
> -	case DCN_1_0__SRCID__OTG6_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC6_VLINE0;
>  	case DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT:
>  		return DC_IRQ_SOURCE_PFLIP1;
>  	case DCN_1_0__SRCID__HUBP1_FLIP_INTERRUPT:
> @@ -97,6 +85,19 @@ static enum dc_irq_source to_dal_irq_source_dcn21(stru=
ct
> irq_service *irq_servic case
> DCN_1_0__SRCID__OTG5_IHC_V_UPDATE_NO_LOCK_INTERRUPT:
>  		return DC_IRQ_SOURCE_VUPDATE6;
>=20
> +	case DCN_VINT_SRCID(1, 0):
> +		DCN_VINT_TO_DC_IRQSRC(1, ext_id);
> +	case DCN_VINT_SRCID(2, 0):
> +		DCN_VINT_TO_DC_IRQSRC(2, ext_id);
> +	case DCN_VINT_SRCID(3, 0):
> +		DCN_VINT_TO_DC_IRQSRC(3, ext_id);
> +	case DCN_VINT_SRCID(4, 0):
> +		DCN_VINT_TO_DC_IRQSRC(4, ext_id);
> +	case DCN_VINT_SRCID(5, 0):
> +		DCN_VINT_TO_DC_IRQSRC(5, ext_id);
> +	case DCN_VINT_SRCID(6, 0):
> +		DCN_VINT_TO_DC_IRQSRC(6, ext_id);
> +
>  	case DCN_1_0__SRCID__DC_HPD1_INT:
>  		/* generic src_id for all HPD and HPDRX interrupts */
>  		switch (ext_id) {
> @@ -170,6 +171,11 @@ static struct irq_source_info_funcs
> vline0_irq_info_funcs =3D { .ack =3D NULL
>  };
>=20
> +static struct irq_source_info_funcs vline2_irq_info_funcs =3D {
> +	.set =3D NULL,
> +	.ack =3D NULL
> +};
> +
>  #undef BASE_INNER
>  #define BASE_INNER(seg) DMU_BASE__INST0_SEG ## seg
>=20
> @@ -266,6 +272,14 @@ static struct irq_source_info_funcs
> vline0_irq_info_funcs =3D { .funcs =3D &vline0_irq_info_funcs\
>  	}
>=20
> +#define vline2_int_entry(reg_num)\
> +	[DC_IRQ_SOURCE_DC1_VLINE2 + reg_num] =3D {\
> +		IRQ_REG_ENTRY(OTG, reg_num,\
> +			OTG_VERTICAL_INTERRUPT2_CONTROL,=20
OTG_VERTICAL_INTERRUPT2_INT_ENABLE,\
> +			OTG_VERTICAL_INTERRUPT2_CONTROL,=20
OTG_VERTICAL_INTERRUPT2_CLEAR),\
> +		.funcs =3D &vline2_irq_info_funcs\
> +	}
> +
>  #define dmub_outbox_int_entry()\
>  	[DC_IRQ_SOURCE_DMCUB_OUTBOX] =3D {\
>  		IRQ_REG_ENTRY_DMUB(DMCUB_INTERRUPT_ENABLE,=20
DMCUB_OUTBOX1_READY_INT_EN,\
> @@ -385,6 +399,12 @@ irq_source_info_dcn21[DAL_IRQ_SOURCES_NUMBER] =3D {
>  	vline0_int_entry(3),
>  	vline0_int_entry(4),
>  	vline0_int_entry(5),
> +	vline2_int_entry(0),
> +	vline2_int_entry(1),
> +	vline2_int_entry(2),
> +	vline2_int_entry(3),
> +	vline2_int_entry(4),
> +	vline2_int_entry(5),
>  	dmub_outbox_int_entry(),
>  };
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
> b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c index
> 3a7f76364000e..d4af3555d14ef 100644
> --- a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
> +++ b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
> @@ -68,18 +68,6 @@ static enum dc_irq_source to_dal_irq_source_dcn30(
>  		return DC_IRQ_SOURCE_VBLANK6;
>  	case DCN_1_0__SRCID__DMCUB_OUTBOX_HIGH_PRIORITY_READY_INT:
>  		return DC_IRQ_SOURCE_DMCUB_OUTBOX0;
> -	case DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC1_VLINE0;
> -	case DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC2_VLINE0;
> -	case DCN_1_0__SRCID__OTG3_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC3_VLINE0;
> -	case DCN_1_0__SRCID__OTG4_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC4_VLINE0;
> -	case DCN_1_0__SRCID__OTG5_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC5_VLINE0;
> -	case DCN_1_0__SRCID__OTG6_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC6_VLINE0;
>  	case DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT:
>  		return DC_IRQ_SOURCE_PFLIP1;
>  	case DCN_1_0__SRCID__HUBP1_FLIP_INTERRUPT:
> @@ -105,6 +93,19 @@ static enum dc_irq_source to_dal_irq_source_dcn30(
>  	case DCN_1_0__SRCID__OTG5_IHC_V_UPDATE_NO_LOCK_INTERRUPT:
>  		return DC_IRQ_SOURCE_VUPDATE6;
>=20
> +	case DCN_VINT_SRCID(1, 0):
> +		DCN_VINT_TO_DC_IRQSRC(1, ext_id);
> +	case DCN_VINT_SRCID(2, 0):
> +		DCN_VINT_TO_DC_IRQSRC(2, ext_id);
> +	case DCN_VINT_SRCID(3, 0):
> +		DCN_VINT_TO_DC_IRQSRC(3, ext_id);
> +	case DCN_VINT_SRCID(4, 0):
> +		DCN_VINT_TO_DC_IRQSRC(4, ext_id);
> +	case DCN_VINT_SRCID(5, 0):
> +		DCN_VINT_TO_DC_IRQSRC(5, ext_id);
> +	case DCN_VINT_SRCID(6, 0):
> +		DCN_VINT_TO_DC_IRQSRC(6, ext_id);
> +
>  	case DCN_1_0__SRCID__DC_HPD1_INT:
>  		/* generic src_id for all HPD and HPDRX interrupts */
>  		switch (ext_id) {
> @@ -177,6 +178,11 @@ static struct irq_source_info_funcs
> vline0_irq_info_funcs =3D { .ack =3D NULL
>  };
>=20
> +static struct irq_source_info_funcs vline2_irq_info_funcs =3D {
> +	.set =3D NULL,
> +	.ack =3D NULL
> +};
> +
>  #undef BASE_INNER
>  #define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
>=20
> @@ -280,6 +286,14 @@ static struct irq_source_info_funcs
> vline0_irq_info_funcs =3D { .funcs =3D &vline0_irq_info_funcs\
>  	}
>=20
> +#define vline2_int_entry(reg_num)\
> +	[DC_IRQ_SOURCE_DC1_VLINE2 + reg_num] =3D {\
> +		IRQ_REG_ENTRY(OTG, reg_num,\
> +			OTG_VERTICAL_INTERRUPT2_CONTROL,=20
OTG_VERTICAL_INTERRUPT2_INT_ENABLE,\
> +			OTG_VERTICAL_INTERRUPT2_CONTROL,=20
OTG_VERTICAL_INTERRUPT2_CLEAR),\
> +		.funcs =3D &vline2_irq_info_funcs\
> +	}
> +
>  #define dummy_irq_entry() \
>  	{\
>  		.funcs =3D &dummy_irq_info_funcs\
> @@ -394,6 +408,12 @@ irq_source_info_dcn30[DAL_IRQ_SOURCES_NUMBER] =3D {
>  	vline0_int_entry(3),
>  	vline0_int_entry(4),
>  	vline0_int_entry(5),
> +	vline2_int_entry(0),
> +	vline2_int_entry(1),
> +	vline2_int_entry(2),
> +	vline2_int_entry(3),
> +	vline2_int_entry(4),
> +	vline2_int_entry(5),
>  	dmub_trace_int_entry(),
>  };
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn302/irq_service_dcn302=
=2Ec
> b/drivers/gpu/drm/amd/display/dc/irq/dcn302/irq_service_dcn302.c index
> f4dfc96310c73..14631b78715a0 100644
> --- a/drivers/gpu/drm/amd/display/dc/irq/dcn302/irq_service_dcn302.c
> +++ b/drivers/gpu/drm/amd/display/dc/irq/dcn302/irq_service_dcn302.c
> @@ -55,18 +55,6 @@ static enum dc_irq_source to_dal_irq_source_dcn302(str=
uct
> irq_service *irq_servi return DC_IRQ_SOURCE_VBLANK6;
>  	case DCN_1_0__SRCID__DMCUB_OUTBOX_HIGH_PRIORITY_READY_INT:
>  		return DC_IRQ_SOURCE_DMCUB_OUTBOX0;
> -	case DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC1_VLINE0;
> -	case DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC2_VLINE0;
> -	case DCN_1_0__SRCID__OTG3_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC3_VLINE0;
> -	case DCN_1_0__SRCID__OTG4_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC4_VLINE0;
> -	case DCN_1_0__SRCID__OTG5_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC5_VLINE0;
> -	case DCN_1_0__SRCID__OTG6_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC6_VLINE0;
>  	case DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT:
>  		return DC_IRQ_SOURCE_PFLIP1;
>  	case DCN_1_0__SRCID__HUBP1_FLIP_INTERRUPT:
> @@ -92,6 +80,19 @@ static enum dc_irq_source to_dal_irq_source_dcn302(str=
uct
> irq_service *irq_servi case
> DCN_1_0__SRCID__OTG5_IHC_V_UPDATE_NO_LOCK_INTERRUPT:
>  		return DC_IRQ_SOURCE_VUPDATE6;
>=20
> +	case DCN_VINT_SRCID(1, 0):
> +		DCN_VINT_TO_DC_IRQSRC(1, ext_id);
> +	case DCN_VINT_SRCID(2, 0):
> +		DCN_VINT_TO_DC_IRQSRC(2, ext_id);
> +	case DCN_VINT_SRCID(3, 0):
> +		DCN_VINT_TO_DC_IRQSRC(3, ext_id);
> +	case DCN_VINT_SRCID(4, 0):
> +		DCN_VINT_TO_DC_IRQSRC(4, ext_id);
> +	case DCN_VINT_SRCID(5, 0):
> +		DCN_VINT_TO_DC_IRQSRC(5, ext_id);
> +	case DCN_VINT_SRCID(6, 0):
> +		DCN_VINT_TO_DC_IRQSRC(6, ext_id);
> +
>  	case DCN_1_0__SRCID__DC_HPD1_INT:
>  		/* generic src_id for all HPD and HPDRX interrupts */
>  		switch (ext_id) {
> @@ -164,6 +165,11 @@ static struct irq_source_info_funcs
> vline0_irq_info_funcs =3D { .ack =3D NULL
>  };
>=20
> +static struct irq_source_info_funcs vline2_irq_info_funcs =3D {
> +	.set =3D NULL,
> +	.ack =3D NULL
> +};
> +
>  #undef BASE_INNER
>  #define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
>=20
> @@ -262,6 +268,14 @@ static struct irq_source_info_funcs
> vline0_irq_info_funcs =3D { .funcs =3D &vline0_irq_info_funcs\
>  	}
>=20
> +#define vline2_int_entry(reg_num)\
> +	[DC_IRQ_SOURCE_DC1_VLINE2 + reg_num] =3D {\
> +		IRQ_REG_ENTRY(OTG, reg_num,\
> +			OTG_VERTICAL_INTERRUPT2_CONTROL,=20
OTG_VERTICAL_INTERRUPT2_INT_ENABLE,\
> +			OTG_VERTICAL_INTERRUPT2_CONTROL,=20
OTG_VERTICAL_INTERRUPT2_CLEAR),\
> +		.funcs =3D &vline2_irq_info_funcs\
> +	}
> +
>  #define dummy_irq_entry() { .funcs =3D &dummy_irq_info_funcs }
>=20
>  #define i2c_int_entry(reg_num) \
> @@ -363,6 +377,11 @@ static const struct irq_source_info
> irq_source_info_dcn302[DAL_IRQ_SOURCES_NUMBE vline0_int_entry(2),
>  		vline0_int_entry(3),
>  		vline0_int_entry(4),
> +		vline2_int_entry(0),
> +		vline2_int_entry(1),
> +		vline2_int_entry(2),
> +		vline2_int_entry(3),
> +		vline2_int_entry(4),
>  		dmub_trace_int_entry(),
>  };
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn303/irq_service_dcn303=
=2Ec
> b/drivers/gpu/drm/amd/display/dc/irq/dcn303/irq_service_dcn303.c index
> fdc7624461ac2..bd4768afafe43 100644
> --- a/drivers/gpu/drm/amd/display/dc/irq/dcn303/irq_service_dcn303.c
> +++ b/drivers/gpu/drm/amd/display/dc/irq/dcn303/irq_service_dcn303.c
> @@ -46,10 +46,6 @@ static enum dc_irq_source to_dal_irq_source_dcn303(str=
uct
> irq_service *irq_servi return DC_IRQ_SOURCE_VBLANK1;
>  	case DCN_1_0__SRCID__DC_D2_OTG_VSTARTUP:
>  		return DC_IRQ_SOURCE_VBLANK2;
> -	case DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC1_VLINE0;
> -	case DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC2_VLINE0;
>  	case DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT:
>  		return DC_IRQ_SOURCE_PFLIP1;
>  	case DCN_1_0__SRCID__HUBP1_FLIP_INTERRUPT:
> @@ -59,6 +55,11 @@ static enum dc_irq_source to_dal_irq_source_dcn303(str=
uct
> irq_service *irq_servi case
> DCN_1_0__SRCID__OTG1_IHC_V_UPDATE_NO_LOCK_INTERRUPT:
>  		return DC_IRQ_SOURCE_VUPDATE2;
>=20
> +	case DCN_VINT_SRCID(1, 0):
> +		DCN_VINT_TO_DC_IRQSRC(1, ext_id);
> +	case DCN_VINT_SRCID(2, 0):
> +		DCN_VINT_TO_DC_IRQSRC(2, ext_id);
> +
>  	case DCN_1_0__SRCID__DC_HPD1_INT:
>  		/* generic src_id for all HPD and HPDRX interrupts */
>  		switch (ext_id) {
> @@ -110,6 +111,11 @@ static struct irq_source_info_funcs
> vline0_irq_info_funcs =3D { .ack =3D NULL
>  };
>=20
> +static struct irq_source_info_funcs vline2_irq_info_funcs =3D {
> +	.set =3D NULL,
> +	.ack =3D NULL
> +};
> +
>  #undef BASE_INNER
>  #define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
>=20
> @@ -186,6 +192,14 @@ static struct irq_source_info_funcs
> vline0_irq_info_funcs =3D { .funcs =3D &vline0_irq_info_funcs\
>  	}
>=20
> +#define vline2_int_entry(reg_num)\
> +	[DC_IRQ_SOURCE_DC1_VLINE2 + reg_num] =3D {\
> +		IRQ_REG_ENTRY(OTG, reg_num,\
> +			OTG_VERTICAL_INTERRUPT2_CONTROL,=20
OTG_VERTICAL_INTERRUPT2_INT_ENABLE,\
> +			OTG_VERTICAL_INTERRUPT2_CONTROL,=20
OTG_VERTICAL_INTERRUPT2_CLEAR),\
> +		.funcs =3D &vline2_irq_info_funcs\
> +	}
> +
>  #define dummy_irq_entry() { .funcs =3D &dummy_irq_info_funcs }
>=20
>  #define i2c_int_entry(reg_num) \
> @@ -260,6 +274,8 @@ static const struct irq_source_info
> irq_source_info_dcn303[DAL_IRQ_SOURCES_NUMBE vblank_int_entry(1),
>  		vline0_int_entry(0),
>  		vline0_int_entry(1),
> +		vline2_int_entry(0),
> +		vline2_int_entry(1),
>  };
>=20
>  static const struct irq_service_funcs irq_service_funcs_dcn303 =3D {
> diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn31/irq_service_dcn31.c
> b/drivers/gpu/drm/amd/display/dc/irq/dcn31/irq_service_dcn31.c index
> 5fecd03f94999..9704f90cd0407 100644
> --- a/drivers/gpu/drm/amd/display/dc/irq/dcn31/irq_service_dcn31.c
> +++ b/drivers/gpu/drm/amd/display/dc/irq/dcn31/irq_service_dcn31.c
> @@ -56,18 +56,6 @@ static enum dc_irq_source to_dal_irq_source_dcn31(stru=
ct
> irq_service *irq_servic return DC_IRQ_SOURCE_VBLANK5;
>  	case DCN_1_0__SRCID__DC_D6_OTG_VSTARTUP:
>  		return DC_IRQ_SOURCE_VBLANK6;
> -	case DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC1_VLINE0;
> -	case DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC2_VLINE0;
> -	case DCN_1_0__SRCID__OTG3_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC3_VLINE0;
> -	case DCN_1_0__SRCID__OTG4_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC4_VLINE0;
> -	case DCN_1_0__SRCID__OTG5_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC5_VLINE0;
> -	case DCN_1_0__SRCID__OTG6_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC6_VLINE0;
>  	case DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT:
>  		return DC_IRQ_SOURCE_PFLIP1;
>  	case DCN_1_0__SRCID__HUBP1_FLIP_INTERRUPT:
> @@ -94,6 +82,20 @@ static enum dc_irq_source to_dal_irq_source_dcn31(stru=
ct
> irq_service *irq_servic return DC_IRQ_SOURCE_VUPDATE6;
>  	case DCN_1_0__SRCID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT:
>  		return DC_IRQ_SOURCE_DMCUB_OUTBOX;
> +
> +	case DCN_VINT_SRCID(1, 0):
> +		DCN_VINT_TO_DC_IRQSRC(1, ext_id);
> +	case DCN_VINT_SRCID(2, 0):
> +		DCN_VINT_TO_DC_IRQSRC(2, ext_id);
> +	case DCN_VINT_SRCID(3, 0):
> +		DCN_VINT_TO_DC_IRQSRC(3, ext_id);
> +	case DCN_VINT_SRCID(4, 0):
> +		DCN_VINT_TO_DC_IRQSRC(4, ext_id);
> +	case DCN_VINT_SRCID(5, 0):
> +		DCN_VINT_TO_DC_IRQSRC(5, ext_id);
> +	case DCN_VINT_SRCID(6, 0):
> +		DCN_VINT_TO_DC_IRQSRC(6, ext_id);
> +
>  	case DCN_1_0__SRCID__DC_HPD1_INT:
>  		/* generic src_id for all HPD and HPDRX interrupts */
>  		switch (ext_id) {
> @@ -166,6 +168,11 @@ static struct irq_source_info_funcs
> vline0_irq_info_funcs =3D { .ack =3D NULL
>  };
>=20
> +static struct irq_source_info_funcs vline2_irq_info_funcs =3D {
> +	.set =3D NULL,
> +	.ack =3D NULL
> +};
> +
>  #undef BASE_INNER
>  #define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
>=20
> @@ -260,6 +267,15 @@ static struct irq_source_info_funcs
> vline0_irq_info_funcs =3D { OTG_VERTICAL_INTERRUPT0_CONTROL,
> OTG_VERTICAL_INTERRUPT0_CLEAR),\ .funcs =3D &vline0_irq_info_funcs\
>  	}
> +
> +#define vline2_int_entry(reg_num)\
> +	[DC_IRQ_SOURCE_DC1_VLINE2 + reg_num] =3D {\
> +		IRQ_REG_ENTRY(OTG, reg_num,\
> +			OTG_VERTICAL_INTERRUPT2_CONTROL,=20
OTG_VERTICAL_INTERRUPT2_INT_ENABLE,\
> +			OTG_VERTICAL_INTERRUPT2_CONTROL,=20
OTG_VERTICAL_INTERRUPT2_CLEAR),\
> +		.funcs =3D &vline2_irq_info_funcs\
> +	}
> +
>  #define dmub_outbox_int_entry()\
>  	[DC_IRQ_SOURCE_DMCUB_OUTBOX] =3D {\
>  		IRQ_REG_ENTRY_DMUB(\
> @@ -376,6 +392,10 @@ irq_source_info_dcn31[DAL_IRQ_SOURCES_NUMBER] =3D {
>  	vline0_int_entry(3),
>  	[DC_IRQ_SOURCE_DC5_VLINE1] =3D dummy_irq_entry(),
>  	[DC_IRQ_SOURCE_DC6_VLINE1] =3D dummy_irq_entry(),
> +	vline2_int_entry(0),
> +	vline2_int_entry(1),
> +	vline2_int_entry(2),
> +	vline2_int_entry(3),
>  	dmub_outbox_int_entry(),
>  };
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn314/irq_service_dcn314=
=2Ec
> b/drivers/gpu/drm/amd/display/dc/irq/dcn314/irq_service_dcn314.c index
> a214f13c5a978..afa4a17ce2f0e 100644
> --- a/drivers/gpu/drm/amd/display/dc/irq/dcn314/irq_service_dcn314.c
> +++ b/drivers/gpu/drm/amd/display/dc/irq/dcn314/irq_service_dcn314.c
> @@ -58,18 +58,6 @@ static enum dc_irq_source to_dal_irq_source_dcn314(str=
uct
> irq_service *irq_servi return DC_IRQ_SOURCE_VBLANK5;
>  	case DCN_1_0__SRCID__DC_D6_OTG_VSTARTUP:
>  		return DC_IRQ_SOURCE_VBLANK6;
> -	case DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC1_VLINE0;
> -	case DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC2_VLINE0;
> -	case DCN_1_0__SRCID__OTG3_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC3_VLINE0;
> -	case DCN_1_0__SRCID__OTG4_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC4_VLINE0;
> -	case DCN_1_0__SRCID__OTG5_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC5_VLINE0;
> -	case DCN_1_0__SRCID__OTG6_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC6_VLINE0;
>  	case DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT:
>  		return DC_IRQ_SOURCE_PFLIP1;
>  	case DCN_1_0__SRCID__HUBP1_FLIP_INTERRUPT:
> @@ -96,6 +84,20 @@ static enum dc_irq_source to_dal_irq_source_dcn314(str=
uct
> irq_service *irq_servi return DC_IRQ_SOURCE_VUPDATE6;
>  	case DCN_1_0__SRCID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT:
>  		return DC_IRQ_SOURCE_DMCUB_OUTBOX;
> +
> +	case DCN_VINT_SRCID(1, 0):
> +		DCN_VINT_TO_DC_IRQSRC(1, ext_id);
> +	case DCN_VINT_SRCID(2, 0):
> +		DCN_VINT_TO_DC_IRQSRC(2, ext_id);
> +	case DCN_VINT_SRCID(3, 0):
> +		DCN_VINT_TO_DC_IRQSRC(3, ext_id);
> +	case DCN_VINT_SRCID(4, 0):
> +		DCN_VINT_TO_DC_IRQSRC(4, ext_id);
> +	case DCN_VINT_SRCID(5, 0):
> +		DCN_VINT_TO_DC_IRQSRC(5, ext_id);
> +	case DCN_VINT_SRCID(6, 0):
> +		DCN_VINT_TO_DC_IRQSRC(6, ext_id);
> +
>  	case DCN_1_0__SRCID__DC_HPD1_INT:
>  		/* generic src_id for all HPD and HPDRX interrupts */
>  		switch (ext_id) {
> @@ -168,6 +170,11 @@ static struct irq_source_info_funcs
> vline0_irq_info_funcs =3D { .ack =3D NULL
>  };
>=20
> +static struct irq_source_info_funcs vline2_irq_info_funcs =3D {
> +	.set =3D NULL,
> +	.ack =3D NULL
> +};
> +
>  #undef BASE_INNER
>  #define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
>=20
> @@ -262,6 +269,15 @@ static struct irq_source_info_funcs
> vline0_irq_info_funcs =3D { OTG_VERTICAL_INTERRUPT0_CONTROL,
> OTG_VERTICAL_INTERRUPT0_CLEAR),\ .funcs =3D &vline0_irq_info_funcs\
>  	}
> +
> +#define vline2_int_entry(reg_num)\
> +	[DC_IRQ_SOURCE_DC1_VLINE2 + reg_num] =3D {\
> +		IRQ_REG_ENTRY(OTG, reg_num,\
> +			OTG_VERTICAL_INTERRUPT2_CONTROL,=20
OTG_VERTICAL_INTERRUPT2_INT_ENABLE,\
> +			OTG_VERTICAL_INTERRUPT2_CONTROL,=20
OTG_VERTICAL_INTERRUPT2_CLEAR),\
> +		.funcs =3D &vline2_irq_info_funcs\
> +	}
> +
>  #define dmub_outbox_int_entry()\
>  	[DC_IRQ_SOURCE_DMCUB_OUTBOX] =3D {\
>  		IRQ_REG_ENTRY_DMUB(\
> @@ -378,6 +394,10 @@ irq_source_info_dcn314[DAL_IRQ_SOURCES_NUMBER] =3D {
>  	vline0_int_entry(3),
>  	[DC_IRQ_SOURCE_DC5_VLINE1] =3D dummy_irq_entry(),
>  	[DC_IRQ_SOURCE_DC6_VLINE1] =3D dummy_irq_entry(),
> +	vline2_int_entry(0),
> +	vline2_int_entry(1),
> +	vline2_int_entry(2),
> +	vline2_int_entry(3),
>  	dmub_outbox_int_entry(),
>  };
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn315/irq_service_dcn315=
=2Ec
> b/drivers/gpu/drm/amd/display/dc/irq/dcn315/irq_service_dcn315.c index
> dc2dced7db85d..b64fada140fb0 100644
> --- a/drivers/gpu/drm/amd/display/dc/irq/dcn315/irq_service_dcn315.c
> +++ b/drivers/gpu/drm/amd/display/dc/irq/dcn315/irq_service_dcn315.c
> @@ -63,18 +63,6 @@ static enum dc_irq_source to_dal_irq_source_dcn315(
>  		return DC_IRQ_SOURCE_VBLANK5;
>  	case DCN_1_0__SRCID__DC_D6_OTG_VSTARTUP:
>  		return DC_IRQ_SOURCE_VBLANK6;
> -	case DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC1_VLINE0;
> -	case DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC2_VLINE0;
> -	case DCN_1_0__SRCID__OTG3_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC3_VLINE0;
> -	case DCN_1_0__SRCID__OTG4_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC4_VLINE0;
> -	case DCN_1_0__SRCID__OTG5_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC5_VLINE0;
> -	case DCN_1_0__SRCID__OTG6_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC6_VLINE0;
>  	case DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT:
>  		return DC_IRQ_SOURCE_PFLIP1;
>  	case DCN_1_0__SRCID__HUBP1_FLIP_INTERRUPT:
> @@ -101,6 +89,20 @@ static enum dc_irq_source to_dal_irq_source_dcn315(
>  		return DC_IRQ_SOURCE_VUPDATE6;
>  	case DCN_1_0__SRCID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT:
>  		return DC_IRQ_SOURCE_DMCUB_OUTBOX;
> +
> +	case DCN_VINT_SRCID(1, 0):
> +		DCN_VINT_TO_DC_IRQSRC(1, ext_id);
> +	case DCN_VINT_SRCID(2, 0):
> +		DCN_VINT_TO_DC_IRQSRC(2, ext_id);
> +	case DCN_VINT_SRCID(3, 0):
> +		DCN_VINT_TO_DC_IRQSRC(3, ext_id);
> +	case DCN_VINT_SRCID(4, 0):
> +		DCN_VINT_TO_DC_IRQSRC(4, ext_id);
> +	case DCN_VINT_SRCID(5, 0):
> +		DCN_VINT_TO_DC_IRQSRC(5, ext_id);
> +	case DCN_VINT_SRCID(6, 0):
> +		DCN_VINT_TO_DC_IRQSRC(6, ext_id);
> +
>  	case DCN_1_0__SRCID__DC_HPD1_INT:
>  		/* generic src_id for all HPD and HPDRX interrupts */
>  		switch (ext_id) {
> @@ -173,6 +175,11 @@ static struct irq_source_info_funcs
> vline0_irq_info_funcs =3D { .ack =3D NULL
>  };
>=20
> +static struct irq_source_info_funcs vline2_irq_info_funcs =3D {
> +	.set =3D NULL,
> +	.ack =3D NULL
> +};
> +
>  #undef BASE_INNER
>  #define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
>=20
> @@ -267,6 +274,15 @@ static struct irq_source_info_funcs
> vline0_irq_info_funcs =3D { OTG_VERTICAL_INTERRUPT0_CONTROL,
> OTG_VERTICAL_INTERRUPT0_CLEAR),\ .funcs =3D &vline0_irq_info_funcs\
>  	}
> +
> +#define vline2_int_entry(reg_num)\
> +	[DC_IRQ_SOURCE_DC1_VLINE2 + reg_num] =3D {\
> +		IRQ_REG_ENTRY(OTG, reg_num,\
> +			OTG_VERTICAL_INTERRUPT2_CONTROL,=20
OTG_VERTICAL_INTERRUPT2_INT_ENABLE,\
> +			OTG_VERTICAL_INTERRUPT2_CONTROL,=20
OTG_VERTICAL_INTERRUPT2_CLEAR),\
> +		.funcs =3D &vline2_irq_info_funcs\
> +	}
> +
>  #define dmub_outbox_int_entry()\
>  	[DC_IRQ_SOURCE_DMCUB_OUTBOX] =3D {\
>  		IRQ_REG_ENTRY_DMUB(\
> @@ -383,6 +399,10 @@ irq_source_info_dcn315[DAL_IRQ_SOURCES_NUMBER] =3D {
>  	vline0_int_entry(3),
>  	[DC_IRQ_SOURCE_DC5_VLINE1] =3D dummy_irq_entry(),
>  	[DC_IRQ_SOURCE_DC6_VLINE1] =3D dummy_irq_entry(),
> +	vline2_int_entry(0),
> +	vline2_int_entry(1),
> +	vline2_int_entry(2),
> +	vline2_int_entry(3),
>  	dmub_outbox_int_entry(),
>  };
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c
> b/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c index
> 3090ceb664332..f347e2ab7ced3 100644
> --- a/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c
> +++ b/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c
> @@ -57,18 +57,6 @@ static enum dc_irq_source to_dal_irq_source_dcn32(
>  		return DC_IRQ_SOURCE_VBLANK5;
>  	case DCN_1_0__SRCID__DC_D6_OTG_VSTARTUP:
>  		return DC_IRQ_SOURCE_VBLANK6;
> -	case DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC1_VLINE0;
> -	case DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC2_VLINE0;
> -	case DCN_1_0__SRCID__OTG3_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC3_VLINE0;
> -	case DCN_1_0__SRCID__OTG4_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC4_VLINE0;
> -	case DCN_1_0__SRCID__OTG5_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC5_VLINE0;
> -	case DCN_1_0__SRCID__OTG6_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC6_VLINE0;
>  	case DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT:
>  		return DC_IRQ_SOURCE_PFLIP1;
>  	case DCN_1_0__SRCID__HUBP1_FLIP_INTERRUPT:
> @@ -95,6 +83,20 @@ static enum dc_irq_source to_dal_irq_source_dcn32(
>  		return DC_IRQ_SOURCE_VUPDATE6;
>  	case DCN_1_0__SRCID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT:
>  		return DC_IRQ_SOURCE_DMCUB_OUTBOX;
> +
> +	case DCN_VINT_SRCID(1, 0):
> +		DCN_VINT_TO_DC_IRQSRC(1, ext_id);
> +	case DCN_VINT_SRCID(2, 0):
> +		DCN_VINT_TO_DC_IRQSRC(2, ext_id);
> +	case DCN_VINT_SRCID(3, 0):
> +		DCN_VINT_TO_DC_IRQSRC(3, ext_id);
> +	case DCN_VINT_SRCID(4, 0):
> +		DCN_VINT_TO_DC_IRQSRC(4, ext_id);
> +	case DCN_VINT_SRCID(5, 0):
> +		DCN_VINT_TO_DC_IRQSRC(5, ext_id);
> +	case DCN_VINT_SRCID(6, 0):
> +		DCN_VINT_TO_DC_IRQSRC(6, ext_id);
> +
>  	case DCN_1_0__SRCID__DC_HPD1_INT:
>  		/* generic src_id for all HPD and HPDRX interrupts */
>  		switch (ext_id) {
> diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn35/irq_service_dcn35.c
> b/drivers/gpu/drm/amd/display/dc/irq/dcn35/irq_service_dcn35.c index
> 27289279b21ca..d70754f6ac0b6 100644
> --- a/drivers/gpu/drm/amd/display/dc/irq/dcn35/irq_service_dcn35.c
> +++ b/drivers/gpu/drm/amd/display/dc/irq/dcn35/irq_service_dcn35.c
> @@ -55,18 +55,6 @@ static enum dc_irq_source to_dal_irq_source_dcn35(
>  		return DC_IRQ_SOURCE_VBLANK5;
>  	case DCN_1_0__SRCID__DC_D6_OTG_VSTARTUP:
>  		return DC_IRQ_SOURCE_VBLANK6;
> -	case DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC1_VLINE0;
> -	case DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC2_VLINE0;
> -	case DCN_1_0__SRCID__OTG3_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC3_VLINE0;
> -	case DCN_1_0__SRCID__OTG4_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC4_VLINE0;
> -	case DCN_1_0__SRCID__OTG5_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC5_VLINE0;
> -	case DCN_1_0__SRCID__OTG6_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC6_VLINE0;
>  	case DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT:
>  		return DC_IRQ_SOURCE_PFLIP1;
>  	case DCN_1_0__SRCID__HUBP1_FLIP_INTERRUPT:
> @@ -93,6 +81,20 @@ static enum dc_irq_source to_dal_irq_source_dcn35(
>  		return DC_IRQ_SOURCE_VUPDATE6;
>  	case DCN_1_0__SRCID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT:
>  		return DC_IRQ_SOURCE_DMCUB_OUTBOX;
> +
> +	case DCN_VINT_SRCID(1, 0):
> +		DCN_VINT_TO_DC_IRQSRC(1, ext_id);
> +	case DCN_VINT_SRCID(2, 0):
> +		DCN_VINT_TO_DC_IRQSRC(2, ext_id);
> +	case DCN_VINT_SRCID(3, 0):
> +		DCN_VINT_TO_DC_IRQSRC(3, ext_id);
> +	case DCN_VINT_SRCID(4, 0):
> +		DCN_VINT_TO_DC_IRQSRC(4, ext_id);
> +	case DCN_VINT_SRCID(5, 0):
> +		DCN_VINT_TO_DC_IRQSRC(5, ext_id);
> +	case DCN_VINT_SRCID(6, 0):
> +		DCN_VINT_TO_DC_IRQSRC(6, ext_id);
> +
>  	case DCN_1_0__SRCID__DC_HPD1_INT:
>  		/* generic src_id for all HPD and HPDRX interrupts */
>  		switch (ext_id) {
> @@ -165,6 +167,11 @@ static struct irq_source_info_funcs
> vline0_irq_info_funcs =3D { .ack =3D NULL
>  };
>=20
> +static struct irq_source_info_funcs vline2_irq_info_funcs =3D {
> +	.set =3D NULL,
> +	.ack =3D NULL
> +};
> +
>  #undef BASE_INNER
>  #define BASE_INNER(seg) ctx->dcn_reg_offsets[seg]
>=20
> @@ -249,6 +256,12 @@ static struct irq_source_info_funcs
> vline0_irq_info_funcs =3D { OTG_VERTICAL_INTERRUPT0_CONTROL,
> OTG_VERTICAL_INTERRUPT0_CLEAR),\ REG_STRUCT[DC_IRQ_SOURCE_DC1_VLINE0 +
> reg_num].funcs =3D &vline0_irq_info_funcs\
>=20
> +#define vline2_int_entry(reg_num)\
> +		IRQ_REG_ENTRY(DC_IRQ_SOURCE_DC1_VLINE2, OTG, reg_num,\
> +			OTG_VERTICAL_INTERRUPT2_CONTROL,=20
OTG_VERTICAL_INTERRUPT2_INT_ENABLE,\
> +			OTG_VERTICAL_INTERRUPT2_CONTROL,=20
OTG_VERTICAL_INTERRUPT2_CLEAR),\
> +		REG_STRUCT[DC_IRQ_SOURCE_DC1_VLINE2 + reg_num].funcs =3D
> &vline2_irq_info_funcs\ +
>  #define dmub_outbox_int_entry()\
>  		IRQ_REG_ENTRY_DMUB(DC_IRQ_SOURCE_DMCUB_OUTBOX, \
>  			DMCUB_INTERRUPT_ENABLE,=20
DMCUB_OUTBOX1_READY_INT_EN,\
> @@ -362,6 +375,10 @@ static struct irq_source_info_funcs
> dummy_irq_info_funcs =3D { vline0_int_entry(3); \
>  	dummy_irq_entry(DC_IRQ_SOURCE_DC5_VLINE1); \
>  	dummy_irq_entry(DC_IRQ_SOURCE_DC6_VLINE1); \
> +	vline2_int_entry(0); \
> +	vline2_int_entry(1); \
> +	vline2_int_entry(2); \
> +	vline2_int_entry(3); \
>  	dmub_outbox_int_entry()
>=20
>  #define dcn35_irq_init() \
> diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn351/irq_service_dcn351=
=2Ec
> b/drivers/gpu/drm/amd/display/dc/irq/dcn351/irq_service_dcn351.c index
> 7404b572a4e96..8948cbb03011e 100644
> --- a/drivers/gpu/drm/amd/display/dc/irq/dcn351/irq_service_dcn351.c
> +++ b/drivers/gpu/drm/amd/display/dc/irq/dcn351/irq_service_dcn351.c
> @@ -4,8 +4,6 @@
>  #include "dm_services.h"
>  #include "include/logger_interface.h"
>  #include "../dce110/irq_service_dce110.h"
> -
> -
>  #include "dcn/dcn_3_5_1_offset.h"
>  #include "dcn/dcn_3_5_1_sh_mask.h"
>=20
> @@ -34,18 +32,6 @@ static enum dc_irq_source to_dal_irq_source_dcn351(
>  		return DC_IRQ_SOURCE_VBLANK5;
>  	case DCN_1_0__SRCID__DC_D6_OTG_VSTARTUP:
>  		return DC_IRQ_SOURCE_VBLANK6;
> -	case DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC1_VLINE0;
> -	case DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC2_VLINE0;
> -	case DCN_1_0__SRCID__OTG3_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC3_VLINE0;
> -	case DCN_1_0__SRCID__OTG4_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC4_VLINE0;
> -	case DCN_1_0__SRCID__OTG5_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC5_VLINE0;
> -	case DCN_1_0__SRCID__OTG6_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC6_VLINE0;
>  	case DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT:
>  		return DC_IRQ_SOURCE_PFLIP1;
>  	case DCN_1_0__SRCID__HUBP1_FLIP_INTERRUPT:
> @@ -72,6 +58,20 @@ static enum dc_irq_source to_dal_irq_source_dcn351(
>  		return DC_IRQ_SOURCE_VUPDATE6;
>  	case DCN_1_0__SRCID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT:
>  		return DC_IRQ_SOURCE_DMCUB_OUTBOX;
> +
> +	case DCN_VINT_SRCID(1, 0):
> +		DCN_VINT_TO_DC_IRQSRC(1, ext_id);
> +	case DCN_VINT_SRCID(2, 0):
> +		DCN_VINT_TO_DC_IRQSRC(2, ext_id);
> +	case DCN_VINT_SRCID(3, 0):
> +		DCN_VINT_TO_DC_IRQSRC(3, ext_id);
> +	case DCN_VINT_SRCID(4, 0):
> +		DCN_VINT_TO_DC_IRQSRC(4, ext_id);
> +	case DCN_VINT_SRCID(5, 0):
> +		DCN_VINT_TO_DC_IRQSRC(5, ext_id);
> +	case DCN_VINT_SRCID(6, 0):
> +		DCN_VINT_TO_DC_IRQSRC(6, ext_id);
> +
>  	case DCN_1_0__SRCID__DC_HPD1_INT:
>  		/* generic src_id for all HPD and HPDRX interrupts */
>  		switch (ext_id) {
> @@ -144,6 +144,11 @@ static struct irq_source_info_funcs
> vline0_irq_info_funcs =3D { .ack =3D NULL
>  };
>=20
> +static struct irq_source_info_funcs vline2_irq_info_funcs =3D {
> +	.set =3D NULL,
> +	.ack =3D NULL
> +};
> +
>  #undef BASE_INNER
>  #define BASE_INNER(seg) ctx->dcn_reg_offsets[seg]
>=20
> @@ -228,6 +233,12 @@ static struct irq_source_info_funcs
> vline0_irq_info_funcs =3D { OTG_VERTICAL_INTERRUPT0_CONTROL,
> OTG_VERTICAL_INTERRUPT0_CLEAR),\ REG_STRUCT[DC_IRQ_SOURCE_DC1_VLINE0 +
> reg_num].funcs =3D &vline0_irq_info_funcs\
>=20
> +#define vline2_int_entry(reg_num)\
> +		IRQ_REG_ENTRY(DC_IRQ_SOURCE_DC1_VLINE2, OTG, reg_num,\
> +			OTG_VERTICAL_INTERRUPT2_CONTROL,=20
OTG_VERTICAL_INTERRUPT2_INT_ENABLE,\
> +			OTG_VERTICAL_INTERRUPT2_CONTROL,=20
OTG_VERTICAL_INTERRUPT2_CLEAR),\
> +		REG_STRUCT[DC_IRQ_SOURCE_DC1_VLINE2 + reg_num].funcs =3D
> &vline2_irq_info_funcs\ +
>  #define dmub_outbox_int_entry()\
>  		IRQ_REG_ENTRY_DMUB(DC_IRQ_SOURCE_DMCUB_OUTBOX, \
>  			DMCUB_INTERRUPT_ENABLE,=20
DMCUB_OUTBOX1_READY_INT_EN,\
> @@ -342,6 +353,10 @@ static struct irq_source_info_funcs
> dummy_irq_info_funcs =3D { vline0_int_entry(3); \
>  	dummy_irq_entry(DC_IRQ_SOURCE_DC5_VLINE1); \
>  	dummy_irq_entry(DC_IRQ_SOURCE_DC6_VLINE1); \
> +	vline2_int_entry(0); \
> +	vline2_int_entry(1); \
> +	vline2_int_entry(2); \
> +	vline2_int_entry(3); \
>  	dmub_outbox_int_entry(); \
>  }
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn36/irq_service_dcn36.c
> b/drivers/gpu/drm/amd/display/dc/irq/dcn36/irq_service_dcn36.c index
> 3dd47a99f568d..5525a69d0ffd2 100644
> --- a/drivers/gpu/drm/amd/display/dc/irq/dcn36/irq_service_dcn36.c
> +++ b/drivers/gpu/drm/amd/display/dc/irq/dcn36/irq_service_dcn36.c
> @@ -33,18 +33,6 @@ static enum dc_irq_source to_dal_irq_source_dcn36(
>  		return DC_IRQ_SOURCE_VBLANK5;
>  	case DCN_1_0__SRCID__DC_D6_OTG_VSTARTUP:
>  		return DC_IRQ_SOURCE_VBLANK6;
> -	case DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC1_VLINE0;
> -	case DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC2_VLINE0;
> -	case DCN_1_0__SRCID__OTG3_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC3_VLINE0;
> -	case DCN_1_0__SRCID__OTG4_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC4_VLINE0;
> -	case DCN_1_0__SRCID__OTG5_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC5_VLINE0;
> -	case DCN_1_0__SRCID__OTG6_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC6_VLINE0;
>  	case DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT:
>  		return DC_IRQ_SOURCE_PFLIP1;
>  	case DCN_1_0__SRCID__HUBP1_FLIP_INTERRUPT:
> @@ -71,6 +59,20 @@ static enum dc_irq_source to_dal_irq_source_dcn36(
>  		return DC_IRQ_SOURCE_VUPDATE6;
>  	case DCN_1_0__SRCID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT:
>  		return DC_IRQ_SOURCE_DMCUB_OUTBOX;
> +
> +	case DCN_VINT_SRCID(1, 0):
> +		DCN_VINT_TO_DC_IRQSRC(1, ext_id);
> +	case DCN_VINT_SRCID(2, 0):
> +		DCN_VINT_TO_DC_IRQSRC(2, ext_id);
> +	case DCN_VINT_SRCID(3, 0):
> +		DCN_VINT_TO_DC_IRQSRC(3, ext_id);
> +	case DCN_VINT_SRCID(4, 0):
> +		DCN_VINT_TO_DC_IRQSRC(4, ext_id);
> +	case DCN_VINT_SRCID(5, 0):
> +		DCN_VINT_TO_DC_IRQSRC(5, ext_id);
> +	case DCN_VINT_SRCID(6, 0):
> +		DCN_VINT_TO_DC_IRQSRC(6, ext_id);
> +
>  	case DCN_1_0__SRCID__DC_HPD1_INT:
>  		/* generic src_id for all HPD and HPDRX interrupts */
>  		switch (ext_id) {
> @@ -143,6 +145,11 @@ static struct irq_source_info_funcs
> vline0_irq_info_funcs =3D { .ack =3D NULL
>  };
>=20
> +static struct irq_source_info_funcs vline2_irq_info_funcs =3D {
> +	.set =3D NULL,
> +	.ack =3D NULL
> +};
> +
>  #undef BASE_INNER
>  #define BASE_INNER(seg) ctx->dcn_reg_offsets[seg]
>=20
> @@ -227,6 +234,12 @@ static struct irq_source_info_funcs
> vline0_irq_info_funcs =3D { OTG_VERTICAL_INTERRUPT0_CONTROL,
> OTG_VERTICAL_INTERRUPT0_CLEAR),\ REG_STRUCT[DC_IRQ_SOURCE_DC1_VLINE0 +
> reg_num].funcs =3D &vline0_irq_info_funcs\
>=20
> +#define vline2_int_entry(reg_num)\
> +		IRQ_REG_ENTRY(DC_IRQ_SOURCE_DC1_VLINE2, OTG, reg_num,\
> +			OTG_VERTICAL_INTERRUPT2_CONTROL,=20
OTG_VERTICAL_INTERRUPT2_INT_ENABLE,\
> +			OTG_VERTICAL_INTERRUPT2_CONTROL,=20
OTG_VERTICAL_INTERRUPT2_CLEAR),\
> +		REG_STRUCT[DC_IRQ_SOURCE_DC1_VLINE2 + reg_num].funcs =3D
> &vline2_irq_info_funcs\ +
>  #define dmub_outbox_int_entry()\
>  		IRQ_REG_ENTRY_DMUB(DC_IRQ_SOURCE_DMCUB_OUTBOX, \
>  			DMCUB_INTERRUPT_ENABLE,=20
DMCUB_OUTBOX1_READY_INT_EN,\
> @@ -339,6 +352,10 @@ static struct irq_source_info_funcs
> dummy_irq_info_funcs =3D { vline0_int_entry(1); \
>  	vline0_int_entry(2); \
>  	vline0_int_entry(3); \
> +	vline2_int_entry(0); \
> +	vline2_int_entry(1); \
> +	vline2_int_entry(2); \
> +	vline2_int_entry(3); \
>  	dummy_irq_entry(DC_IRQ_SOURCE_DC5_VLINE1); \
>  	dummy_irq_entry(DC_IRQ_SOURCE_DC6_VLINE1); \
>  	dmub_outbox_int_entry(); \
> diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn401/irq_service_dcn401=
=2Ec
> b/drivers/gpu/drm/amd/display/dc/irq/dcn401/irq_service_dcn401.c index
> 42d9d42ba0b99..ce264333e3cf4 100644
> --- a/drivers/gpu/drm/amd/display/dc/irq/dcn401/irq_service_dcn401.c
> +++ b/drivers/gpu/drm/amd/display/dc/irq/dcn401/irq_service_dcn401.c
> @@ -36,18 +36,6 @@ static enum dc_irq_source to_dal_irq_source_dcn401(
>  		return DC_IRQ_SOURCE_VBLANK5;
>  	case DCN_1_0__SRCID__DC_D6_OTG_VSTARTUP:
>  		return DC_IRQ_SOURCE_VBLANK6;
> -	case DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC1_VLINE0;
> -	case DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC2_VLINE0;
> -	case DCN_1_0__SRCID__OTG3_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC3_VLINE0;
> -	case DCN_1_0__SRCID__OTG4_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC4_VLINE0;
> -	case DCN_1_0__SRCID__OTG5_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC5_VLINE0;
> -	case DCN_1_0__SRCID__OTG6_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC6_VLINE0;
>  	case DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT:
>  		return DC_IRQ_SOURCE_PFLIP1;
>  	case DCN_1_0__SRCID__HUBP1_FLIP_INTERRUPT:
> @@ -75,6 +63,19 @@ static enum dc_irq_source to_dal_irq_source_dcn401(
>  	case DCN_1_0__SRCID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT:
>  		return DC_IRQ_SOURCE_DMCUB_OUTBOX;
>=20
> +	case DCN_VINT_SRCID(1, 0):
> +		DCN_VINT_TO_DC_IRQSRC(1, ext_id);
> +	case DCN_VINT_SRCID(2, 0):
> +		DCN_VINT_TO_DC_IRQSRC(2, ext_id);
> +	case DCN_VINT_SRCID(3, 0):
> +		DCN_VINT_TO_DC_IRQSRC(3, ext_id);
> +	case DCN_VINT_SRCID(4, 0):
> +		DCN_VINT_TO_DC_IRQSRC(4, ext_id);
> +	case DCN_VINT_SRCID(5, 0):
> +		DCN_VINT_TO_DC_IRQSRC(5, ext_id);
> +	case DCN_VINT_SRCID(6, 0):
> +		DCN_VINT_TO_DC_IRQSRC(6, ext_id);
> +
>  	case DCN_1_0__SRCID__DC_HPD1_INT:
>  		/* generic src_id for all HPD and HPDRX interrupts */
>  		switch (ext_id) {
> diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn42/irq_service_dcn42.c
> b/drivers/gpu/drm/amd/display/dc/irq/dcn42/irq_service_dcn42.c index
> f4d1ce9079ded..f9113d9f3c3ee 100644
> --- a/drivers/gpu/drm/amd/display/dc/irq/dcn42/irq_service_dcn42.c
> +++ b/drivers/gpu/drm/amd/display/dc/irq/dcn42/irq_service_dcn42.c
> @@ -35,18 +35,6 @@ static enum dc_irq_source to_dal_irq_source_dcn42(
>  		return DC_IRQ_SOURCE_VBLANK5;
>  	case DCN_1_0__SRCID__DC_D6_OTG_VSTARTUP:
>  		return DC_IRQ_SOURCE_VBLANK6;
> -	case DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC1_VLINE0;
> -	case DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC2_VLINE0;
> -	case DCN_1_0__SRCID__OTG3_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC3_VLINE0;
> -	case DCN_1_0__SRCID__OTG4_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC4_VLINE0;
> -	case DCN_1_0__SRCID__OTG5_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC5_VLINE0;
> -	case DCN_1_0__SRCID__OTG6_VERTICAL_INTERRUPT0_CONTROL:
> -		return DC_IRQ_SOURCE_DC6_VLINE0;
>  	case DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT:
>  		return DC_IRQ_SOURCE_PFLIP1;
>  	case DCN_1_0__SRCID__HUBP1_FLIP_INTERRUPT:
> @@ -73,6 +61,20 @@ static enum dc_irq_source to_dal_irq_source_dcn42(
>  		return DC_IRQ_SOURCE_VUPDATE6;
>  	case DCN_1_0__SRCID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT:
>  		return DC_IRQ_SOURCE_DMCUB_OUTBOX;
> +
> +	case DCN_VINT_SRCID(1, 0):
> +		DCN_VINT_TO_DC_IRQSRC(1, ext_id);
> +	case DCN_VINT_SRCID(2, 0):
> +		DCN_VINT_TO_DC_IRQSRC(2, ext_id);
> +	case DCN_VINT_SRCID(3, 0):
> +		DCN_VINT_TO_DC_IRQSRC(3, ext_id);
> +	case DCN_VINT_SRCID(4, 0):
> +		DCN_VINT_TO_DC_IRQSRC(4, ext_id);
> +	case DCN_VINT_SRCID(5, 0):
> +		DCN_VINT_TO_DC_IRQSRC(5, ext_id);
> +	case DCN_VINT_SRCID(6, 0):
> +		DCN_VINT_TO_DC_IRQSRC(6, ext_id);
> +
>  	case DCN_1_0__SRCID__DC_HPD1_INT:
>  		/* generic src_id for all HPD and HPDRX interrupts */
>  		switch (ext_id) {
> diff --git a/drivers/gpu/drm/amd/display/dc/irq/irq_service.h
> b/drivers/gpu/drm/amd/display/dc/irq/irq_service.h index
> bbcef3d2fe334..ba2bca88e4ccb 100644
> --- a/drivers/gpu/drm/amd/display/dc/irq/irq_service.h
> +++ b/drivers/gpu/drm/amd/display/dc/irq/irq_service.h
> @@ -30,6 +30,29 @@
>=20
>  #include "irq_types.h"
>=20
> +/*
> + * Helper to get vertical interrupt src/ctx id by OTG instance and vint
> number + */
> +#define DCN_VINT_SRCID(otg_inst, vint_num) \
> +	DCN_1_0__SRCID__OTG ## otg_inst ## _VERTICAL_INTERRUPT ## vint_num=20
##
> _CONTROL +#define DCN_VINT_CTXID(otg_inst, vint_num) \
> +	DCN_1_0__CTXID__OTG ## otg_inst ## _VERTICAL_INTERRUPT ## vint_num=20
##
> _CONTROL +#define DC_VINT_IRQSRC(otg_inst, vint_num) \
> +	DC_IRQ_SOURCE_DC ## otg_inst ## _VLINE ## vint_num
> +
> +/* Helper to map vertical interrupt src/ctx id to DC irq source enum */
> +#define DCN_VINT_TO_DC_IRQSRC(otg_inst, ext_id) \
> +	switch (ext_id) { \
> +	case DCN_VINT_CTXID(otg_inst, 0): \
> +		return DC_VINT_IRQSRC(otg_inst, 0); \
> +	case DCN_VINT_CTXID(otg_inst, 1): \
> +		return DC_VINT_IRQSRC(otg_inst, 1); \
> +	case DCN_VINT_CTXID(otg_inst, 2): \
> +		return DC_VINT_IRQSRC(otg_inst, 2); \
> +	default: \
> +		return DC_IRQ_SOURCE_INVALID; \
> +	}
> +
>  struct irq_service;
>  struct irq_source_info;




