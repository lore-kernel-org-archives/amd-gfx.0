Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29375C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 31 May 2022 21:15:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B144E10E297;
	Tue, 31 May 2022 21:15:39 +0000 (UTC)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 155F610E272
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 May 2022 21:15:38 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-f33f0f5b1dso76272fac.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 May 2022 14:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eVGMLAt+MW45fHvXWhF+SQqA896TELWImbRqkIbpoy0=;
 b=CdSI9xSRYwsoBIVRaUMoODMaBJ+PjCO+ES7pPzIAu0XTMH2PDqlLJH66MeXc2vz+xb
 I1z1durksXUjofGl1qFpg82ZMpmG5stLAC7wVrv0jIQDJTaPMJWOOE9Nzg/w5+Vn4vtm
 kejJ/9QHxqdscCLDTBFvoNrO2aEz7uTpQMGw6Slr9QMGTxPgicl5JOmAuDEGZ4CXoI2f
 QPtTNLgBHrfF7qYza+NwuPwEYiuk54cQkCTy9XA3hMDbgvYh/+JcmmXAAzYkzeOL7oBF
 YRghW2tNiQhU7o+XF9ybqIi5effg88QepmeuabjFGHte2sDl2/aFFHEHBxtt46Zuog1n
 pqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eVGMLAt+MW45fHvXWhF+SQqA896TELWImbRqkIbpoy0=;
 b=TVpbZlNgACoYATwr8oAd2iAZztsxuBhoNxumpvlk6yCsfuKoon+NogeHrgUay7qTXl
 +EQ0481cZ1ZvHSsdFcLuJMx3podW2TbFd3C/VAgwFJiWnEpLPANRLbzAhFkNvxDJW/00
 KzFkzMoPwtCsKFZKRB/BwgnCsfnj/TBJC+DBIESJjVhswCxTi5AWZnVshjgWfCDp9O17
 rdcq1r+a5Fy4JqpHItputN/P7pFC85c38s1/2rTk0moxBPrIFeFkU4FWMlLsNHR0PI+H
 7r7gRo0pZXs6ltItfIRu1wg7PBrF8r+2lJlrA26+vLaXMjA2oVt/mS/3vhtxCC6871fq
 Cszg==
X-Gm-Message-State: AOAM5316jREE32gxKrvOvXmE66eGywOJtcsMa6zUrYEWyj1q+/gygKKd
 swTC1UCBiBMfkeWaMdEbpUciLWGOgeI472gr2Ne6DjtCdnc=
X-Google-Smtp-Source: ABdhPJw/WBoBJgXB0kFxAWTc/hse3umFcNNN0KYRCs7D5NWIdY2hW2/KYrpr9VnrhqEKDS41fbYOnnANTmN5XbRQKOQ=
X-Received: by 2002:a05:6870:3105:b0:f2:9615:ff8e with SMTP id
 v5-20020a056870310500b000f29615ff8emr13917484oaa.200.1654031737281; Tue, 31
 May 2022 14:15:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220526180027.3044740-1-alexander.deucher@amd.com>
 <20220526180027.3044740-3-alexander.deucher@amd.com>
In-Reply-To: <20220526180027.3044740-3-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 31 May 2022 17:15:26 -0400
Message-ID: <CADnq5_PuocLqGG9gO_UFiCR59jfWGizm7ujfTnTpS53ZUMYT0Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu/swsmu: use new register offsets for
 smu_cmn.c
To: Alex Deucher <alexander.deucher@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

On Thu, May 26, 2022 at 2:01 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> Use the per asic offsets so the we don't have to have
> asic specific logic in the common code.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 77 +++-----------------------
>  1 file changed, 7 insertions(+), 70 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 5215ead4978f..53cd62ccab5d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -37,40 +37,6 @@
>  #undef pr_info
>  #undef pr_debug
>
> -/*
> - * Although these are defined in each ASIC's specific header file.
> - * They share the same definitions and values. That makes common
> - * APIs for SMC messages issuing for all ASICs possible.
> - */
> -#define mmMP1_SMN_C2PMSG_66                                                                            0x0282
> -#define mmMP1_SMN_C2PMSG_66_BASE_IDX                                                                   0
> -
> -#define mmMP1_SMN_C2PMSG_82                                                                            0x0292
> -#define mmMP1_SMN_C2PMSG_82_BASE_IDX                                                                   0
> -
> -#define mmMP1_SMN_C2PMSG_90                                                                            0x029a
> -#define mmMP1_SMN_C2PMSG_90_BASE_IDX                                                                   0
> -
> -#define mmMP1_SMN_C2PMSG_66_V13_0_4                    0x0282
> -#define mmMP1_SMN_C2PMSG_66_V13_0_4_BASE_IDX            1
> -
> -#define mmMP1_SMN_C2PMSG_82_V13_0_4                    0x0292
> -#define mmMP1_SMN_C2PMSG_82_V13_0_4_BASE_IDX            1
> -
> -#define mmMP1_SMN_C2PMSG_90_V13_0_4                    0x029a
> -#define mmMP1_SMN_C2PMSG_90_V13_0_4_BASE_IDX           1
> -
> -/* SMU 13.0.5 has its specific mailbox messaging registers */
> -
> -#define mmMP1_C2PMSG_2                                                                            (0xbee142 + 0xb00000 / 4)
> -#define mmMP1_C2PMSG_2_BASE_IDX                                                                   0
> -
> -#define mmMP1_C2PMSG_34                                                                           (0xbee262 + 0xb00000 / 4)
> -#define mmMP1_C2PMSG_34_BASE_IDX                                                                   0
> -
> -#define mmMP1_C2PMSG_33                                                                                (0xbee261 + 0xb00000 / 4)
> -#define mmMP1_C2PMSG_33_BASE_IDX                                                                   0
> -
>  #define MP1_C2PMSG_90__CONTENT_MASK                                                                    0xFFFFFFFFL
>
>  #undef __SMU_DUMMY_MAP
> @@ -99,12 +65,7 @@ static void smu_cmn_read_arg(struct smu_context *smu,
>  {
>         struct amdgpu_device *adev = smu->adev;
>
> -       if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 5))
> -               *arg = RREG32_SOC15(MP1, 0, mmMP1_C2PMSG_34);
> -       else if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 4))
> -               *arg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82_V13_0_4);
> -       else
> -               *arg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
> +       *arg = RREG32(smu->param_reg);
>  }
>
>  /* Redefine the SMU error codes here.
> @@ -150,12 +111,7 @@ static u32 __smu_cmn_poll_stat(struct smu_context *smu)
>         u32 reg;
>
>         for ( ; timeout > 0; timeout--) {
> -               if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 5))
> -                       reg = RREG32_SOC15(MP1, 0, mmMP1_C2PMSG_33);
> -               else if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 4))
> -                       reg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90_V13_0_4);
> -               else
> -                       reg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
> +               reg = RREG32(smu->resp_reg);
>                 if ((reg & MP1_C2PMSG_90__CONTENT_MASK) != 0)
>                         break;
>
> @@ -177,16 +133,8 @@ static void __smu_cmn_reg_print_error(struct smu_context *smu,
>
>         switch (reg_c2pmsg_90) {
>         case SMU_RESP_NONE: {
> -               if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 5)) {
> -                       msg_idx = RREG32_SOC15(MP1, 0, mmMP1_C2PMSG_2);
> -                       prm     = RREG32_SOC15(MP1, 0, mmMP1_C2PMSG_34);
> -               } else if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 4)) {
> -                       msg_idx = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66_V13_0_4);
> -                       prm     = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82_V13_0_4);
> -               } else {
> -                       msg_idx = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66);
> -                       prm     = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
> -               }
> +               msg_idx = RREG32(smu->msg_reg);
> +               prm     = RREG32(smu->param_reg);
>                 dev_err_ratelimited(adev->dev,
>                                     "SMU: I'm not done with your previous command: SMN_C2PMSG_66:0x%08X SMN_C2PMSG_82:0x%08X",
>                                     msg_idx, prm);
> @@ -280,20 +228,9 @@ static void __smu_cmn_send_msg(struct smu_context *smu,
>  {
>         struct amdgpu_device *adev = smu->adev;
>
> -       if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 5)) {
> -               WREG32_SOC15(MP1, 0, mmMP1_C2PMSG_33, 0);
> -               WREG32_SOC15(MP1, 0, mmMP1_C2PMSG_34, param);
> -               WREG32_SOC15(MP1, 0, mmMP1_C2PMSG_2, msg);
> -       } else if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 4)) {
> -               WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90_V13_0_4, 0);
> -               WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82_V13_0_4, param);
> -               WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66_V13_0_4, msg);
> -       } else {
> -               WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
> -               WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82, param);
> -               WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);
> -       }
> -
> +       WREG32(smu->resp_reg, 0);
> +       WREG32(smu->param_reg, param);
> +       WREG32(smu->msg_reg, msg);
>  }
>
>  /**
> --
> 2.35.3
>
