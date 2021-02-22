Return-Path: <SRS0=DoF4=HY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EEBC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 21:48:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BD4F64DFD
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 21:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BD4F64DFD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFFAA6E7EF;
	Mon, 22 Feb 2021 21:48:00 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C6CA6E7EF
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Feb 2021 21:47:59 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id j1so3641251oiw.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Feb 2021 13:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9ZQbAYdH3+0OuJPkSKYjLlDNhlq/Q+Rx8FohyiIZWMk=;
 b=aeeIjH6MfqhUXMMyPYpDzThFVj5kXxOOPSaiM2P/1h0kRuSINZFDEW+Cb7RFZc9Ak2
 CstDSHJqCkNtvqDDcUkxCJSXzzZzQX45WWFiy8ZM4qhMecm01QA5mMfi1OYyJiti2gOq
 2kp/PjhlkR9yyzFkAg371GDHL4HzwxeRiZblhpXfVs2VjY112l2hKWoDTcZeHcYCnUhb
 /Ry7PkUXyAp1OppVEfYVi7qmBgBLD8OCUoySMlpV5BObuDOX6dManRDITbvU+XsHz3Vl
 Uy2ehKAAdKRwr3n8QI+P2+vhbdrO9NlCDUcH+/ZCWLbc5yvRgqL4xtJpWf53EZd04C/s
 e94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9ZQbAYdH3+0OuJPkSKYjLlDNhlq/Q+Rx8FohyiIZWMk=;
 b=f+xDsvlT3wQZ8/dvGi44keQUpDp7QBgOOQB3aeroj8maHbSezPWOskiE03insxYeVI
 1YfAFNeDdiE3ZbponkXtqmbKIZJoADtudd6WsVGC/x5LyMcHT9DKxUbIpaNdFm9sQYY3
 jqDQj+k+CtA2UlcmOCjrPKmS05hCB+YZJsyWKXqtUbnRiVxIEwuJwZP6F3CPr4dkMtr6
 FAk7tWDpKHsfAxhjBeyEqedrZhORLD21eM2kOBIpMMIdQQozTiiQZylpBxmxyCH2x2AE
 OqZnlFv3FXztVnPk6/X1xrQm25mNxrxdPN+9/WettMkGnqFmIxhldkUGxZVnKLp8kX4c
 3yvg==
X-Gm-Message-State: AOAM531+Yploq5tuAxjACRHN07bpn8oqx5pSuhi4Zilajmat+HC6zHSN
 EkexlppEngPNqspSeXXn/YQoDdGuFcvLOjSNURo=
X-Google-Smtp-Source: ABdhPJxVOqiWnD/9S7a1ObhxwJ+gduHKwfjb9QiI/qhi57gcpRkLkJZ76DlW3F77Gqflxaf+Cv6tQPGIHzudJoSOjk4=
X-Received: by 2002:aca:fccb:: with SMTP id a194mr7846358oii.5.1614030478785; 
 Mon, 22 Feb 2021 13:47:58 -0800 (PST)
MIME-Version: 1.0
References: <20210222040329.1280956-1-evan.quan@amd.com>
 <20210222040329.1280956-2-evan.quan@amd.com>
In-Reply-To: <20210222040329.1280956-2-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 22 Feb 2021 16:47:47 -0500
Message-ID: <CADnq5_N0=a_5wd1aLhvMPeX2_SnyTvA3+7tyt14Bx8mRo3-6PA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/pm: optimize the link width/speed retrieving
To: Evan Quan <evan.quan@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, Feb 21, 2021 at 11:04 PM Evan Quan <evan.quan@amd.com> wrote:
>
> By using the information provided by PMFW when available.
>
> Change-Id: I1afec4cd07ac9608861ee07c449e320e3f36a932
> Signed-off-by: Evan Quan <evan.quan@amd.com>

What about arcturus?
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 17 ++++++++++----
>  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 22 +++++++++++++++----
>  2 files changed, 31 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 29e04f33f276..7fe2876c99fe 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -72,6 +72,8 @@
>
>  #define SMU_11_0_GFX_BUSY_THRESHOLD 15
>
> +static uint16_t link_speed[] = {25, 50, 80, 160};
> +
>  static struct cmn2asic_msg_mapping navi10_message_map[SMU_MSG_MAX_COUNT] = {
>         MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,                  1),
>         MSG_MAP(GetSmuVersion,                  PPSMC_MSG_GetSmuVersion,                1),
> @@ -2391,10 +2393,17 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
>
>         gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
>
> -       gpu_metrics->pcie_link_width =
> -                       smu_v11_0_get_current_pcie_link_width(smu);
> -       gpu_metrics->pcie_link_speed =
> -                       smu_v11_0_get_current_pcie_link_speed(smu);
> +       if (((adev->asic_type == CHIP_NAVI14) && smu_version > 0x00351F00) ||
> +             ((adev->asic_type == CHIP_NAVI12) && smu_version > 0x00341C00) ||
> +             ((adev->asic_type == CHIP_NAVI10) && smu_version > 0x002A3B00)) {
> +               gpu_metrics->pcie_link_width = (uint16_t)metrics.PcieWidth;
> +               gpu_metrics->pcie_link_speed = link_speed[metrics.PcieRate];
> +       } else {
> +               gpu_metrics->pcie_link_width =
> +                               smu_v11_0_get_current_pcie_link_width(smu);
> +               gpu_metrics->pcie_link_speed =
> +                               smu_v11_0_get_current_pcie_link_speed(smu);
> +       }
>
>         gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index e74299da1739..6fd95764c952 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -73,6 +73,8 @@
>
>  #define SMU_11_0_7_GFX_BUSY_THRESHOLD 15
>
> +static uint16_t link_speed[] = {25, 50, 80, 160};
> +
>  static struct cmn2asic_msg_mapping sienna_cichlid_message_map[SMU_MSG_MAX_COUNT] = {
>         MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,                 1),
>         MSG_MAP(GetSmuVersion,                  PPSMC_MSG_GetSmuVersion,               1),
> @@ -3124,6 +3126,8 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
>         SmuMetricsExternal_t metrics_external;
>         SmuMetrics_t *metrics =
>                 &(metrics_external.SmuMetrics);
> +       struct amdgpu_device *adev = smu->adev;
> +       uint32_t smu_version;
>         int ret = 0;
>
>         ret = smu_cmn_get_metrics_table(smu,
> @@ -3170,10 +3174,20 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
>
>         gpu_metrics->current_fan_speed = metrics->CurrFanSpeed;
>
> -       gpu_metrics->pcie_link_width =
> -                       smu_v11_0_get_current_pcie_link_width(smu);
> -       gpu_metrics->pcie_link_speed =
> -                       smu_v11_0_get_current_pcie_link_speed(smu);
> +       ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
> +       if (ret)
> +               return ret;
> +
> +       if (((adev->asic_type == CHIP_SIENNA_CICHLID) && smu_version > 0x003A1E00) ||
> +             ((adev->asic_type == CHIP_NAVY_FLOUNDER) && smu_version > 0x00410400)) {
> +               gpu_metrics->pcie_link_width = (uint16_t)metrics->PcieWidth;
> +               gpu_metrics->pcie_link_speed = link_speed[metrics->PcieRate];
> +       } else {
> +               gpu_metrics->pcie_link_width =
> +                               smu_v11_0_get_current_pcie_link_width(smu);
> +               gpu_metrics->pcie_link_speed =
> +                               smu_v11_0_get_current_pcie_link_speed(smu);
> +       }
>
>         gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
>
> --
> 2.29.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
