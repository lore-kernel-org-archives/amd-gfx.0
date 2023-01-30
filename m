Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5853C54EAA
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Jan 2023 16:31:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 646AA10E275;
	Mon, 30 Jan 2023 16:31:35 +0000 (UTC)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B943710E0F8
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Jan 2023 16:31:33 +0000 (UTC)
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-163adf0cfc4so4438607fac.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Jan 2023 08:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KJ+6sl/FOdqRjO5izT/BrKJrBbcUVaLnFErRbMWVl9M=;
 b=W1zskDgQB+L96TobostjdScB7gYCv+uVc6eak8sRa9+ns1tbAXnJC+dvFJdXy01iRX
 RnojpRjTMPmvNy4lNfcEBpHbXNYpJ0R/8Lgq7rBN/+4TQAIXbzgv/9vFcO1QgSQEfaS+
 hidTexUEu6zdbnMckXFLhEXuWBNoKVhjHjXcrsgBL/eyNZ1O7bAh7z2x36+XIYGS3D27
 CPOQTTTPeUvGu/x0J5b8Qp3inGUhYJMg9yHTYJVSOS/+kMCQy0uC9WnCCfYeba/jm1yj
 xhD0fDyuEnlhnzN4ZQBKlzxAoH7uQdZz5XsW+ikNXRHLkMNNi/P2o5SLVwoB5xX3LDN9
 ZPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KJ+6sl/FOdqRjO5izT/BrKJrBbcUVaLnFErRbMWVl9M=;
 b=5wQcinGbYq53snjQX81+PjpDUe94PPfCdT7d3T4H8RdgERufJHEZLFYNhP2qcVlbES
 CPYjNmn4pr8DrJbcVKnYPzoXwhRteIT2nVWVhw+T097X+i2o8tkswsaA0A6YhqJ3mm5B
 G7yRjVwRlMeusvvbXQFJ6JLB59FkKe6Qdvrr2Lh4wbgFEHCWDWZuxksxj4yoSOgnRI7F
 NDP3T0hcJ4XgW7z4JtXE5ypiaHoidGlizNtiB2zsn1ytwQ/bxI725CC/+hdE8wJMn1p+
 mAQ2bcyuuNXPpRjBJ2+VUHqFglY3WWe7IPTDMXusB9O3LtqIiqPSMVG08eeF/PHUd+OE
 aSFQ==
X-Gm-Message-State: AO0yUKX5cLiWE9knBVF2kEN7x/e32KikbCQgozFYikGdPgUi8TFCDWO0
 DoG9zQi3OAFfSX2R4FczmQGy8agTqpSMX2pm3Hs=
X-Google-Smtp-Source: AK7set8oYSA6aBnrYN2514jUMbpVgpmr/lDZE4V0pDY0tFab08HlCsYSwaAYRZ7IOaynxyB/Gdd3jBfaZ4Lhpfdt9+g=
X-Received: by 2002:a05:6870:b522:b0:163:8cc6:86a with SMTP id
 v34-20020a056870b52200b001638cc6086amr1062500oap.46.1675096292897; Mon, 30
 Jan 2023 08:31:32 -0800 (PST)
MIME-Version: 1.0
References: <20230130161606.6386-1-mario.limonciello@amd.com>
In-Reply-To: <20230130161606.6386-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 30 Jan 2023 11:31:21 -0500
Message-ID: <CADnq5_O6w0-yhH1rw3hmZMh9OCdMUT64HY4JSoQNH-fm-JzYuw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Fix initialization for nbio 4.3.0
To: Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Satyanarayana ReddyTVN <Satyanarayana.ReddyTVN@amd.com>,
 Rutvij Gajjar <Rutvij.Gajjar@amd.com>, amd-gfx@lists.freedesktop.org,
 Natikar Basavaraj <Basavaraj.Natikar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jan 30, 2023 at 11:16 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> A mistake has been made on some boards with NBIO 4.3.0 where some
> NBIO registers aren't properly set by the hardware.
>
> Ensure that they're set during initialization.
>
> Cc: Natikar Basavaraj <Basavaraj.Natikar@amd.com>
> Tested-by: Satyanarayana ReddyTVN <Satyanarayana.ReddyTVN@amd.com>
> Tested-by: Rutvij Gajjar <Rutvij.Gajjar@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
> index 15eb3658d70e6..4b1c6946a60f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
> @@ -337,6 +337,13 @@ const struct nbio_hdp_flush_reg nbio_v4_3_hdp_flush_reg = {
>
>  static void nbio_v4_3_init_registers(struct amdgpu_device *adev)
>  {
> +       if (adev->ip_versions[NBIO_HWIP][0] == IP_VERSION(4, 3, 0)) {
> +               uint32_t data;
> +
> +               data = RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF2_STRAP2);
> +               data &= ~RCC_DEV0_EPF2_STRAP2__STRAP_NO_SOFT_RESET_DEV0_F2_MASK;
> +               WREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF2_STRAP2, data);
> +       }
>         return;

You can drop the return here.  With that, the patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>  }
>
> --
> 2.34.1
>
