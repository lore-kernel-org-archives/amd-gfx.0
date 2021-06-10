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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68ED0C48BDF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 21:02:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F7D4613B3
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 21:02:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F7D4613B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E32136EDED;
	Thu, 10 Jun 2021 21:02:18 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 191126EDE9
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 21:02:18 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 j11-20020a9d738b0000b02903ea3c02ded8so1070245otk.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 14:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lyY+9YtdR41VxVlz6S9obd9mt4oQ3sgiqhRpBoahbwg=;
 b=UDRz5ijgdOdtRS+zKBS0rhGZVF1y1m/pO8rXlTV/XCt0uYG/SVoRSBOSZcHT0MLID1
 MKcVlDlKZzozCJsm9kcGMBUxROHxUxUOInQRPuDZPj++h2P2HZlpymrLROORSDoDGOf6
 CI2ycdMXGuS2jN1A/jsd5l3C6WBMYhFrl0ULTtAvjeX9ERdFe3aFtxydbprOdS4TAKTZ
 7Esb8AsVzd2KX8LkixyVoFRmnVux60+hWruc9Gmyc4pk4u4rfuQklub0aqcPjxDT0MOY
 vUzB6CTyRBOYuCsgqP/+wcu9zmF7p/JLJxYiz1GYv6Zu+qP2kd3hcSS2B+/GWUmObSPW
 EPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lyY+9YtdR41VxVlz6S9obd9mt4oQ3sgiqhRpBoahbwg=;
 b=tAO36h6DDbRHFnVf5cDLMtTzV76kGIxBHMt6H6SLQnFi6me/dkvLMyNh2/dpERf/dx
 jENdusnVQ2Xl9WybMobSfhDbpcyCBzXtfYeYVtno+lqQUNNcDZ1aBIFd6FN9ktbHvYik
 y6wMg/Wnrmfz1fWvO5UPEpL1GYioea69yc8Xs2YFWsDLypCNRbaQgKROaC8D7sAdkwHr
 IcOm4tjqhIfZOBoYn15rnfSMXoKs+8Mzp+XifURbFnyNrBnoj6XB46EEIdDhlbx2ZR9l
 IWhw/9YdMV6T+wxlp4rgdCOVsxrzsk2YpGLNGEHt8kjUtk0xl+4orJE4hbhdImup6tKa
 Y8pA==
X-Gm-Message-State: AOAM532rY5f2pcslGl7KkFk7H+RRuTusE4y8BydVfcq8vEhKTRLR5RQZ
 uayPqwFrqG3P20Wgo2bohsO9c+lLVrsbVMECtKY=
X-Google-Smtp-Source: ABdhPJwAY3XZNsiKPhoNNVNdjLopXU89W+UdLRKfUqxdgiU8owXAO9fwJjpHxaNWwrYDYyIiyV3PBUXjiqL7PicMjKA=
X-Received: by 2002:a05:6830:1e64:: with SMTP id
 m4mr243817otr.23.1623358937537; 
 Thu, 10 Jun 2021 14:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210608213954.5517-1-luben.tuikov@amd.com>
 <20210608213954.5517-25-luben.tuikov@amd.com>
In-Reply-To: <20210608213954.5517-25-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 10 Jun 2021 17:02:06 -0400
Message-ID: <CADnq5_O31yA5KZqP___54R+YSLvK3+o7t=RjHxvxA_FOExVU0g@mail.gmail.com>
Subject: Re: [PATCH 24/40] drm/amdgpu: I2C class is HWMON
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
> Set the auto-discoverable class of I2C bus to
> HWMON. Remove SPD.
>
> Cc: Jean Delvare <jdelvare@suse.de>
> Cc: Alexander Deucher <Alexander.Deucher@amd.com>
> Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
> Cc: Lijo Lazar <Lijo.Lazar@amd.com>
> Cc: Stanley Yang <Stanley.Yang@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c              | 2 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 2 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 2 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
> index b8d6d308fb06a0..e403ba556e5590 100644
> --- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
> +++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
> @@ -667,7 +667,7 @@ int smu_v11_0_i2c_control_init(struct i2c_adapter *control)
>
>         mutex_init(&adev->pm.smu_i2c_mutex);
>         control->owner = THIS_MODULE;
> -       control->class = I2C_CLASS_SPD | I2C_CLASS_HWMON;
> +       control->class = I2C_CLASS_HWMON;
>         control->dev.parent = &adev->pdev->dev;
>         control->algo = &smu_v11_0_i2c_algo;
>         snprintf(control->name, sizeof(control->name), "AMDGPU SMU");
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index c2d6d7c8129593..974740ac72fded 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -2016,7 +2016,7 @@ static int arcturus_i2c_control_init(struct smu_context *smu, struct i2c_adapter
>         int res;
>
>         control->owner = THIS_MODULE;
> -       control->class = I2C_CLASS_SPD | I2C_CLASS_HWMON;
> +       control->class = I2C_CLASS_HWMON;
>         control->dev.parent = &adev->pdev->dev;
>         control->algo = &arcturus_i2c_algo;
>         control->quirks = &arcturus_i2c_control_quirks;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 56000463f64e45..8ab06fa87edb04 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2810,7 +2810,7 @@ static int navi10_i2c_control_init(struct smu_context *smu, struct i2c_adapter *
>         int res;
>
>         control->owner = THIS_MODULE;
> -       control->class = I2C_CLASS_SPD | I2C_CLASS_HWMON;
> +       control->class = I2C_CLASS_HWMON;
>         control->dev.parent = &adev->pdev->dev;
>         control->algo = &navi10_i2c_algo;
>         snprintf(control->name, sizeof(control->name), "AMDGPU SMU");
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 86804f3b0a951b..91614ae186f7f5 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -3498,7 +3498,7 @@ static int sienna_cichlid_i2c_control_init(struct smu_context *smu, struct i2c_a
>         int res;
>
>         control->owner = THIS_MODULE;
> -       control->class = I2C_CLASS_SPD | I2C_CLASS_HWMON;
> +       control->class = I2C_CLASS_HWMON;
>         control->dev.parent = &adev->pdev->dev;
>         control->algo = &sienna_cichlid_i2c_algo;
>         snprintf(control->name, sizeof(control->name), "AMDGPU SMU");
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
