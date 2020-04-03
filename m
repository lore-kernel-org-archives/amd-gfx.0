Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F1FC43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 14:53:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BFA520719
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 14:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSLQR5zK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BFA520719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A2A16EBFF;
	Fri,  3 Apr 2020 14:53:43 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E4B46EBFF
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 14:53:42 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id h9so8876980wrc.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Apr 2020 07:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=i/qT8CiO//53Z0QVFUU96GpaG0f3S+Zkj08FnU/ETC4=;
 b=eSLQR5zKEKCw+ScWWUvqMlu103pbZoqM2N/ggCjUnnoBPzu/oxCg5SPvttHnCn5HPj
 I0+7oc3ZzjTyN6kowUFOXgGmIKa8Kp7GO8YHEPvfBXl6ySIcbUsUvDmVFRTkjlz7EIKT
 +pa1KBw36rbMPxUGZSMd3XEGcKhZZYLzXSMI6hMkXm+CrkBDov2zfUOsNXfNePDTXvM/
 AS8egr+wmx41yymyIfESbTNbMkDikxb+RGe2tZ8YzWsFxPt8wYcKHvNPAJnofywWIuQz
 dpHvcUkIMJFErLOxoJv9sveUS1BlI9DzYxCLtcc6R3tDmqm/Jk70QaC2o6XFkN4eGq0Q
 Zxug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=i/qT8CiO//53Z0QVFUU96GpaG0f3S+Zkj08FnU/ETC4=;
 b=a2IFMQ8iZfMr7EG0ymK2Jg5rWwYaD6T9wpXOQi1yHCl/019zPJhy1yA995AIVKdfLl
 RgSbfgYibHLYDf0ar5AskL7OU/2Ra57FZpOPJZlMFnmj4jFDjMkggHXlZls6tyN79ppY
 K0PFoJK0+1qK0by46oJu2Ry654mOOOi2nFBSh544rIREWt+IgH7l+4CDtChQupmJsugP
 ByovLCVD3ddBjiIHsr/mXF9EVXpLENP9Rq5E1UHt8XKnXfb+jHD12oQC1b0bLrzo/ZX5
 EXi5WEKIKMRQ9TsyDqNJbKM1g1Ezbhd6p52qa/2xDN0WJPelKcrF7TYFYQLCXFJdiIwm
 Cgpg==
X-Gm-Message-State: AGi0PuZ0rT8HntfkKl4s/qr4k15mSUS0Bw5kvGR9chPh23377/uJ2ZeH
 xMfA3x3ByJsAZUeiXJy1xAvsTwtzUIArk5yTzyivGmNH
X-Google-Smtp-Source: APiQypIWA7hjdIfGvSputoq7MxvMdjEtgfrBwp1v46sUz0bPNkHPw7DZkxf/glcSb9Vee7PS8Hs7YMQT7A0HHfDc+DM=
X-Received: by 2002:adf:f50d:: with SMTP id q13mr9694655wro.374.1585925620801; 
 Fri, 03 Apr 2020 07:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200403052948.23664-1-tianci.yin@amd.com>
In-Reply-To: <20200403052948.23664-1-tianci.yin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 3 Apr 2020 10:53:29 -0400
Message-ID: <CADnq5_OF=MFbH5uqKGzCkL_oWuDUhQdv4QJh6spSdy9TLqhWpw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add SPM golden settings for Navi10
To: Tianci Yin <tianci.yin@amd.com>
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
Cc: Deucher Alexander <Alexander.Deucher@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, Hesik Christopher <Christopher.Hesik@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Apr 3, 2020 at 1:30 AM Tianci Yin <tianci.yin@amd.com> wrote:
>
> From: "Tianci.Yin" <tianci.yin@amd.com>
>
> Add RLC_SPM golden settings
>
> Change-Id: I616e127171293d915cb3a05dee02f51cec8d8f6f
> Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |    9 +
>  .../gpu/drm/amd/amdgpu/golden_gc_spm_10_1_0.h | 1058 +++++++++++++++++
>  2 files changed, 1067 insertions(+)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/golden_gc_spm_10_1_0.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 70edbbf84338..7c96a894ad37 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -48,6 +48,7 @@
>  #include "v10_structs.h"
>  #include "gfx_v10_0.h"
>  #include "nbio_v2_3.h"
> +#include "golden_gc_spm_10_1_0.h"

Can we just include the table directly in this file instead of a
separate header?  One more comment below.

>
>  /**
>   * Navi10 has two graphic rings to share each graphic pipe.
> @@ -138,6 +139,11 @@ static const struct soc15_reg_golden golden_settings_gc_10_0_nv10[] =
>         /* Pending on emulation bring up */
>  };
>
> +static const struct soc15_reg_golden golden_settings_gc_rlc_spm_10_0_nv10[] =
> +{
> +       GOLDEN_GC_SPM_10_1_0
> +};
> +
>  static const struct soc15_reg_golden golden_settings_gc_10_1_1[] =
>  {
>         SOC15_REG_GOLDEN_VALUE(GC, 0, mmCB_HW_CONTROL_4, 0xffffffff, 0x003c0014),
> @@ -388,6 +394,9 @@ static void gfx_v10_0_init_golden_registers(struct amdgpu_device *adev)
>                 soc15_program_register_sequence(adev,
>                                                 golden_settings_gc_10_0_nv10,
>                                                 (const u32)ARRAY_SIZE(golden_settings_gc_10_0_nv10));
> +               soc15_program_register_sequence(adev,
> +                                               golden_settings_gc_rlc_spm_10_0_nv10,
> +                                               (const u32)ARRAY_SIZE(golden_settings_gc_rlc_spm_10_0_nv10));
>                 break;
>         case CHIP_NAVI14:
>                 soc15_program_register_sequence(adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/golden_gc_spm_10_1_0.h b/drivers/gpu/drm/amd/amdgpu/golden_gc_spm_10_1_0.h
> new file mode 100644
> index 000000000000..e65af4a6fcdd
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/golden_gc_spm_10_1_0.h

This file is missing a license.

Alex
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
