Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B97C48BD1
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 21:07:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32A4C613DD
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 21:07:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A4C613DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC4F46EDEC;
	Thu, 10 Jun 2021 21:07:13 +0000 (UTC)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 085EF6EDEC
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 21:07:13 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 36-20020a9d0ba70000b02902e0a0a8fe36so1060094oth.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 14:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tUggtuXiX/fRUftY7ESkcrWWZtIrbPkpCYvWgUgEGWQ=;
 b=nR29GS6Kbnc3SRTL8pcousvE/tAZ/5OdTBBxKVby/s0uSy5R208QAE+EwTqwqC5F/n
 0w9DBX5CsOAK1lbbxkgv0YCVaTMKxoIyW3tPus1oU7A0fl/VP1Gqd97cEAU0OAy4tF8p
 qa4/EIEXAnvnDayRayZSgv86Uw9SlqTXl9McvcwBAKUeJ0f1AH+u5p0vnJUTEyB6v9GN
 isM33mki6NO54HhoO4apy3ew/ES7b6d92jsTLDFuLJPMXVnISt8TP82EQO9xyBmouj95
 UcoAoDCU4l6EncwY1nNJAQd5gkXVafnNOvApTPQuXLEKxAzHU2XGlBQfwNMCm+cvfL8C
 c3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tUggtuXiX/fRUftY7ESkcrWWZtIrbPkpCYvWgUgEGWQ=;
 b=oDIFxjrVoTqq1zQGp+t4InHTI8anRh81DSKgmdUz+0updWE+E1r5P8DpeTYvZiHDWz
 DbQ/MoLOhDeAFsE5SayQ7z3G6UKCZ5KHPt0eZSMJPYHLQFjPrWyRNZJL4KY0SFI0R3kG
 Us/V64/0fhRJVVk9Bx2oZQtaEMNgMnjqGfjGPqJGOOjz0GIjw5Wp+xhDSts3xsz7Iisq
 0Mslvrh3jFupPXDe/bjiztMriYfmaFf3KgmlYlI9+ISClMez10cDicvl85XCwW8+5jFL
 pAG2Q37PuJxjyXKCu+TKrTmQruLC8Ruh/tmrnOizWvw4FjY2mNTRMuXVQ58sANujXznH
 z9+Q==
X-Gm-Message-State: AOAM5311al0WKBEr0xatFTceCIzRgqH+Q9WmKZW7MuDXFykgOdcK8HrA
 oSu0S1qD7hx++4yViCE6NlfS6qKpuJnqoc6VMY8=
X-Google-Smtp-Source: ABdhPJyMBQzoM1MSNiE6N3gGyQTGcXG9vMIT/I+m5ILBWHxy3pRTTDx6W9YXuf1jqcZmL/Eq3EKRRexvkxndZTdufQQ=
X-Received: by 2002:a05:6830:33ef:: with SMTP id
 i15mr252971otu.311.1623359232469; 
 Thu, 10 Jun 2021 14:07:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210608213954.5517-1-luben.tuikov@amd.com>
 <20210608213954.5517-30-luben.tuikov@amd.com>
In-Reply-To: <20210608213954.5517-30-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 10 Jun 2021 17:07:01 -0400
Message-ID: <CADnq5_MV3j78r886tfiPbC9WhmtSvHRgt=191zcLgnZFhFR84w@mail.gmail.com>
Subject: Re: [PATCH 29/40] drm/amd/pm: Extend the I2C quirk table
To: Luben Tuikov <luben.tuikov@amd.com>
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Lijo Lazar <Lijo.Lazar@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Stanley Yang <Stanley.Yang@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>, Jean Delvare <jdelvare@suse.de>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jun 8, 2021 at 5:40 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> Extend the I2C quirk table for SMU access
> controlled I2C adapters. Let the kernel I2C layer
> check that the messages all have the same address,
> and that their combined size doesn't exceed the
> maximum size of a SMU software I2C request.
>
> Suggested-by: Jean Delvare <jdelvare@suse.de>
> Cc: Jean Delvare <jdelvare@suse.de>
> Cc: Alexander Deucher <Alexander.Deucher@amd.com>
> Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
> Cc: Lijo Lazar <Lijo.Lazar@amd.com>
> Cc: Stanley Yang <Stanley.Yang@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 5 ++++-
>  drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 5 ++++-
>  drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 5 ++++-
>  3 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index 974740ac72fded..de8d7513042966 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -2006,8 +2006,11 @@ static const struct i2c_algorithm arcturus_i2c_algo = {
>
>
>  static const struct i2c_adapter_quirks arcturus_i2c_control_quirks = {
> -       .max_read_len = MAX_SW_I2C_COMMANDS,
> +       .flags = I2C_AQ_COMB | I2C_AQ_COMB_SAME_ADDR,
> +       .max_read_len  = MAX_SW_I2C_COMMANDS,
>         .max_write_len = MAX_SW_I2C_COMMANDS,
> +       .max_comb_1st_msg_len = 2,
> +       .max_comb_2nd_msg_len = MAX_SW_I2C_COMMANDS - 2,
>  };
>
>  static int arcturus_i2c_control_init(struct smu_context *smu, struct i2c_adapter *control)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 8ab06fa87edb04..1b8cd3746d0ebc 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2800,8 +2800,11 @@ static const struct i2c_algorithm navi10_i2c_algo = {
>  };
>
>  static const struct i2c_adapter_quirks navi10_i2c_control_quirks = {
> -       .max_read_len = MAX_SW_I2C_COMMANDS,
> +       .flags = I2C_AQ_COMB | I2C_AQ_COMB_SAME_ADDR,
> +       .max_read_len  = MAX_SW_I2C_COMMANDS,
>         .max_write_len = MAX_SW_I2C_COMMANDS,
> +       .max_comb_1st_msg_len = 2,
> +       .max_comb_2nd_msg_len = MAX_SW_I2C_COMMANDS - 2,
>  };
>
>  static int navi10_i2c_control_init(struct smu_context *smu, struct i2c_adapter *control)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 91614ae186f7f5..b38127f8009d3d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -3488,8 +3488,11 @@ static const struct i2c_algorithm sienna_cichlid_i2c_algo = {
>  };
>
>  static const struct i2c_adapter_quirks sienna_cichlid_i2c_control_quirks = {
> -       .max_read_len = MAX_SW_I2C_COMMANDS,
> +       .flags = I2C_AQ_COMB | I2C_AQ_COMB_SAME_ADDR,
> +       .max_read_len  = MAX_SW_I2C_COMMANDS,
>         .max_write_len = MAX_SW_I2C_COMMANDS,
> +       .max_comb_1st_msg_len = 2,
> +       .max_comb_2nd_msg_len = MAX_SW_I2C_COMMANDS - 2,
>  };
>
>  static int sienna_cichlid_i2c_control_init(struct smu_context *smu, struct i2c_adapter *control)
> --
> 2.32.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
