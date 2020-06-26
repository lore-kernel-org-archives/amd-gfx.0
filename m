Return-Path: <SRS0=Inwe=AH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D748C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2020 16:48:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F86C207E8
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2020 16:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="owpq/rYy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F86C207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07D496ECDF;
	Fri, 26 Jun 2020 16:48:50 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A22886ECDF
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2020 16:48:48 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id z13so10147283wrw.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2020 09:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8RuFbZZMpY5R6rsKr108Fd/4xIR/l2hKhHT4M3RVUGM=;
 b=owpq/rYyEaiY9YLsm5UUcXxh2tSEKj4C6VlRuJHTtNJ8CvNE+hMSqBej97GvJzKUBt
 H+uHwNffcjgSsBhYf6GoHxcDQ0o9OTmTwhhzdyUvipSLWHmoezKseFWnjRLd/aLZPBQ8
 oeR6hp+HcYp+fysfXtaf32ewRLhykkHbWWdg4yV+MnDyZCCWsNRuuW073jHQB0QJDrRA
 W/ZgBU1FY46oXnRstSvqNw6c4y3CGNhRSd5yURtzsEB1JbchoXX5GLxwt2Z1D1ywm3Pw
 LSMBPhl0SO03jJG0sf8545ySPsBtgWp55yVr5ya1pPnrWHdYJEQcxjEYQb2md/eOHBpH
 wSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8RuFbZZMpY5R6rsKr108Fd/4xIR/l2hKhHT4M3RVUGM=;
 b=rwpPg4wNWXLVbMp/Zs90MKHWXKqCrTlAnrC0hS2GfCFMibFccwDjuk6SCLDuegXrGR
 XCZUey7z6A8ZspwHW271mcrG3/nXTQZxO/Nl+EbO9HP9KUz3cJuFA6awaL3g4xZ7/xe0
 g1XgiJM9KAHnYkDACe6oBDRIvmJa4zoX9UcuvcnaIbi+qIh2FJhPVFkeaJYm8oIS/KJh
 t8STnaryO/Dai43fKWWDHion78CCZocTMnyzGIvs9TQE7Fzx5mpXDEXVrmWfr5AZCAB+
 a9hr1+mPF4C8EZLbfUv3SQlLmXoRSgGo3FLHwWLzCR+O3SAFdIIbhn1bFBxwVH0VeCtT
 Fsww==
X-Gm-Message-State: AOAM531aLL+UC6/XLTR067dTl8z3v8KTdyR08FSGxGscsg4o4jej8clW
 ioOGVpTK0m0QzqghzEgi9ywSgQAdmAFGT5RzFlQcpg==
X-Google-Smtp-Source: ABdhPJyvr2Uz0AKta28p/U4dAYYdz//J13z0g+qf4QbE+twmQHPCjoUSWhkMMHa1iOfg5AG651KbFQI8Xszt9fRjhYo=
X-Received: by 2002:a5d:6a46:: with SMTP id t6mr4819826wrw.374.1593190127187; 
 Fri, 26 Jun 2020 09:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200626161847.16000-1-eryk.brol@amd.com>
 <20200626161847.16000-5-eryk.brol@amd.com>
In-Reply-To: <20200626161847.16000-5-eryk.brol@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 26 Jun 2020 12:48:35 -0400
Message-ID: <CADnq5_ON7hzxmgVEjjhbu6pG5dNHVUMurBzDjhL+1mTiHtMW-Q@mail.gmail.com>
Subject: Re: [PATCH 04/11] drm/amd/display: Handle SMU msg response
To: Eryk Brol <eryk.brol@amd.com>
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
Cc: "Leo \(Sunpeng\) Li" <Sunpeng.Li@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Yongqiang Sun <yongqiang.sun@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jun 26, 2020 at 12:19 PM Eryk Brol <eryk.brol@amd.com> wrote:
>
> From: Yongqiang Sun <yongqiang.sun@amd.com>
>
> [Why]
> SMU may return error code to driver, but driver only check if response
> is OK.
>
> [How]
> Check SMU response instead of reg_wait, assert in case of reponse isn't
> OK.

Will you ever get concurrent calls to these interfaces or do you
already have a higher level lock to prevent that?  You need to make
sure you don't have multiple threads using these interfaces at the
same time or you'll need locking to protect the message, param, and
response registers.

Alex

>
> Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
> Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
> Acked-by: Eryk Brol <eryk.brol@amd.com>
> ---
>  .../dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c  | 39 +++++++++++++++++-
>  .../dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c   | 40 ++++++++++++++++++-
>  2 files changed, 75 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c
> index c320b7af7d34..dbc7cde00433 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c
> @@ -26,6 +26,7 @@
>  #include "core_types.h"
>  #include "clk_mgr_internal.h"
>  #include "reg_helper.h"
> +#include <linux/delay.h>
>
>  #define MAX_INSTANCE   5
>  #define MAX_SEGMENT            5
> @@ -68,10 +69,42 @@ static const struct IP_BASE MP1_BASE  = { { { { 0x00016000, 0, 0, 0, 0 } },
>  #define VBIOSSMC_MSG_SetDispclkFreq           0x4
>  #define VBIOSSMC_MSG_SetDprefclkFreq          0x5
>
> +#define VBIOSSMC_Status_BUSY                      0x0
> +#define VBIOSSMC_Result_OK                        0x1
> +#define VBIOSSMC_Result_Failed                    0xFF
> +#define VBIOSSMC_Result_UnknownCmd                0xFE
> +#define VBIOSSMC_Result_CmdRejectedPrereq         0xFD
> +#define VBIOSSMC_Result_CmdRejectedBusy           0xFC
> +
> +/*
> + * Function to be used instead of REG_WAIT macro because the wait ends when
> + * the register is NOT EQUAL to zero, and because the translation in msg_if.h
> + * won't work with REG_WAIT.
> + */
> +static uint32_t rv1_smu_wait_for_response(struct clk_mgr_internal *clk_mgr, unsigned int delay_us, unsigned int max_retries)
> +{
> +       uint32_t res_val = VBIOSSMC_Status_BUSY;
> +
> +       do {
> +               res_val = REG_READ(MP1_SMN_C2PMSG_91);
> +               if (res_val != VBIOSSMC_Status_BUSY)
> +                       break;
> +
> +               if (delay_us >= 1000)
> +                       msleep(delay_us/1000);
> +               else if (delay_us > 0)
> +                       udelay(delay_us);
> +       } while (max_retries--);
> +
> +       return res_val;
> +}
> +
>  int rv1_vbios_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr, unsigned int msg_id, unsigned int param)
>  {
> +       uint32_t result;
> +
>         /* First clear response register */
> -       REG_WRITE(MP1_SMN_C2PMSG_91, 0);
> +       REG_WRITE(MP1_SMN_C2PMSG_91, VBIOSSMC_Status_BUSY);
>
>         /* Set the parameter register for the SMU message, unit is Mhz */
>         REG_WRITE(MP1_SMN_C2PMSG_83, param);
> @@ -79,7 +112,9 @@ int rv1_vbios_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr, unsigned
>         /* Trigger the message transaction by writing the message ID */
>         REG_WRITE(MP1_SMN_C2PMSG_67, msg_id);
>
> -       REG_WAIT(MP1_SMN_C2PMSG_91, CONTENT, 1, 10, 200000);
> +       result = rv1_smu_wait_for_response(clk_mgr, 10, 1000);
> +
> +       ASSERT(result == VBIOSSMC_Result_OK);
>
>         /* Actual dispclk set is returned in the parameter register */
>         return REG_READ(MP1_SMN_C2PMSG_83);
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
> index 6878aedf1d3e..d2facbb114d3 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
> @@ -26,6 +26,7 @@
>  #include "core_types.h"
>  #include "clk_mgr_internal.h"
>  #include "reg_helper.h"
> +#include <linux/delay.h>
>
>  #include "renoir_ip_offset.h"
>
> @@ -53,10 +54,43 @@
>  #define VBIOSSMC_MSG_EnableTmdp48MHzRefclkPwrDown 0xD
>  #define VBIOSSMC_MSG_UpdatePmeRestore                    0xE
>
> +#define VBIOSSMC_Status_BUSY                      0x0
> +#define VBIOSSMC_Result_OK                        0x1
> +#define VBIOSSMC_Result_Failed                    0xFF
> +#define VBIOSSMC_Result_UnknownCmd                0xFE
> +#define VBIOSSMC_Result_CmdRejectedPrereq         0xFD
> +#define VBIOSSMC_Result_CmdRejectedBusy           0xFC
> +
> +/*
> + * Function to be used instead of REG_WAIT macro because the wait ends when
> + * the register is NOT EQUAL to zero, and because the translation in msg_if.h
> + * won't work with REG_WAIT.
> + */
> +static uint32_t rn_smu_wait_for_response(struct clk_mgr_internal *clk_mgr, unsigned int delay_us, unsigned int max_retries)
> +{
> +       uint32_t res_val = VBIOSSMC_Status_BUSY;
> +
> +       do {
> +               res_val = REG_READ(MP1_SMN_C2PMSG_91);
> +               if (res_val != VBIOSSMC_Status_BUSY)
> +                       break;
> +
> +               if (delay_us >= 1000)
> +                       msleep(delay_us/1000);
> +               else if (delay_us > 0)
> +                       udelay(delay_us);
> +       } while (max_retries--);
> +
> +       return res_val;
> +}
> +
> +
>  int rn_vbios_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr, unsigned int msg_id, unsigned int param)
>  {
> +       uint32_t result;
> +
>         /* First clear response register */
> -       REG_WRITE(MP1_SMN_C2PMSG_91, 0);
> +       REG_WRITE(MP1_SMN_C2PMSG_91, VBIOSSMC_Status_BUSY);
>
>         /* Set the parameter register for the SMU message, unit is Mhz */
>         REG_WRITE(MP1_SMN_C2PMSG_83, param);
> @@ -64,7 +98,9 @@ int rn_vbios_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr, unsigned
>         /* Trigger the message transaction by writing the message ID */
>         REG_WRITE(MP1_SMN_C2PMSG_67, msg_id);
>
> -       REG_WAIT(MP1_SMN_C2PMSG_91, CONTENT, 1, 10, 200000);
> +       result = rn_smu_wait_for_response(clk_mgr, 10, 1000);
> +
> +       ASSERT(result == VBIOSSMC_Result_OK);
>
>         /* Actual dispclk set is returned in the parameter register */
>         return REG_READ(MP1_SMN_C2PMSG_83);
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
