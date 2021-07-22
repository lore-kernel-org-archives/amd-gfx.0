Return-Path: <SRS0=tcRC=MO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D55C63793
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jul 2021 14:43:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1719E6100C
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jul 2021 14:43:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1719E6100C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC82C6EEA7;
	Thu, 22 Jul 2021 14:43:33 +0000 (UTC)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 843D96EEAF
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jul 2021 14:42:39 +0000 (UTC)
Received: by mail-il1-x12e.google.com with SMTP id o8so5590869ilf.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jul 2021 07:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=AfaxiaFEM+oAf+QNFm/JJIjSIp7PY9czfYD2LPjRKoE=;
 b=C5zvr1W8PsvJY9D1vOc/zyw3otApCvAwhaKnpRwrUd0FQqvQjRg5es/qauQIoIxqUK
 y7f+tR1lrYy4UU8uLcniixFbwcMx/7F03M+5GHyPCQoOTg4UzW14C+ux3IeWSmqvuFqX
 CJhd38H0RodED67Cptz15TbOSjn+cGM7/Tr6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=AfaxiaFEM+oAf+QNFm/JJIjSIp7PY9czfYD2LPjRKoE=;
 b=UT9C2/oT85NhDsw/+IbmqtVqNpIyzziEj8Mleqois6fv+xr7GS6H7ZB1/yNUoz+UiD
 QTVYhd5Zlmc0S4zZ6VKnjbNobbfbFyUQW5FUToY951qjwaGZP0PTDFxeoajS60bUJGr9
 Ou/nqf/BL0oU/ldJ5frB53wiBKUaznE0Oi6pQZWFsEydYA5fHujAsHTN/sqOQPDS3Uek
 +S/V5aaoLJQ0GLQDsjtbtcPBKK6KngGMxCD7tTWlHySl8eesfIux4WTVHuiJlNRaQSF5
 Wn8kHQ4KQtJZLk6HvxlLwZiNc1xVHflwKzZb917tpCv4OhOzZX0xFxmgdMxzGM5Bh599
 7GYA==
X-Gm-Message-State: AOAM530yhnPhaOp+VtfjM36w25+ruGRRNJopei2W5kF7zujrVwgp37kY
 XcLS4AkFkV1q2fsq3E4UpsBZhw==
X-Google-Smtp-Source: ABdhPJyMzpF2zItmLxlb2gcEpwXqWTCphcSsRfeRc6/SRevZv3eoTHyewW1imtCEJom8fwwYEZLX3g==
X-Received: by 2002:a92:da86:: with SMTP id u6mr119559iln.265.1626964958900;
 Thu, 22 Jul 2021 07:42:38 -0700 (PDT)
Received: from google.com (h96-60-216-123.arvdco.broadband.dynamic.tds.net.
 [96.60.216.123])
 by smtp.gmail.com with ESMTPSA id e14sm14756871ilq.32.2021.07.22.07.42.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jul 2021 07:42:38 -0700 (PDT)
Date: Thu, 22 Jul 2021 08:42:37 -0600
From: Raul E Rangel <rrangel@chromium.org>
To: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: Re: drm/amdgpu: Check pmops for desired suspend state
Message-ID: <YPmD3YEmxIZAVQbB@google.com>
References: <20210722052714.626304-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210722052714.626304-1-Pratik.Vishwakarma@amd.com>
X-Mailman-Approved-At: Thu, 22 Jul 2021 14:43:32 +0000
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
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jul 22, 2021 at 10:57:14AM +0530, Pratik Vishwakarma wrote:
> [Why]
> User might set mem_sleep as deep and it will result
> in amdgpu resume errors.
> 
> [How]
> Check with pm for default suspend state
> 
> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index af1710971ff3..d92196429741 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1468,7 +1468,8 @@ static int amdgpu_pmops_suspend(struct device *dev)
>  	struct amdgpu_device *adev = drm_to_adev(drm_dev);
>  	int r;
>  
> -	if (amdgpu_acpi_is_s0ix_supported(adev))
> +	if (amdgpu_acpi_is_s0ix_supported(adev)
> +		&& pm_suspend_default_s2idle())

Why pm_suspend_default_s2idle instead of pm_suspend_via_firmware?
>  		adev->in_s0ix = true;
>  	adev->in_s3 = true;
>  	r = amdgpu_device_suspend(drm_dev, true);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
