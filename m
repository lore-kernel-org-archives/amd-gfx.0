Return-Path: <SRS0=7Ry8=JY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A470C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Apr 2021 17:46:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0C7E613BD
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Apr 2021 17:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C7E613BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 615516E231;
	Tue, 27 Apr 2021 17:46:24 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C36B66E231
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Apr 2021 17:46:22 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 g4-20020a9d6b040000b029029debbbb3ecso23069950otp.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Apr 2021 10:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kplpqA84YGEgyBZ7mugK9Z6i3BSJ4z/StHPwqWPZCkA=;
 b=JU3zQSC2NAKFGOB2jxU2dR21jJYvWCMDF7U9BwOsLEGS2ZSOGJkYIQkkom7ssVWiam
 zLV9UH4Tw4xs/rl8A9uVgDljUk19gnbJGwO+EDwrRfVpxXIYE3dAMdeZ9ZFo/jzQGX0M
 p88wGFDk5jbuFeL7+gvm08fz8cUA6ALaHPcvA4138xhYEv4RN0fWf7Nxe4hnyppbQwoh
 8ZsyYDlBSOrEHZCGYni6ZgW5a/Ilb1nR11RqDgp8hTUVTPtpfOFXHfuPjrTBszESPAbJ
 inn9o6HiVUqSGtVPOWanCLjIHYMYGE4Rct60IFcaHi2AMSGTF1EhJGbpbgfNXWkuo9zn
 JA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kplpqA84YGEgyBZ7mugK9Z6i3BSJ4z/StHPwqWPZCkA=;
 b=T+O6ayKBHTFLYVo9ifRl/It3tsADQuf/kmodZCGRGtjOKORTsShvpfDlAXfWAgHBJi
 sQbn+ARVLCwppPHZFF3psUyEKySImLHixSKNdIAd8zzg5SrTP/hYZXpIj/tLU9q+nD9r
 1Jkdp80yIvQZmaG2ubbFlfxk8YNniW7KktktdpgQigxQghnrRBLuAddGLcCW5nGslnlz
 4s8llPvR7L0RLKW9vmEyVfLmMDU3961VcWjldU57okLgeL8rN0VaLQtK91XpWcUgc08d
 HYKcWMaGyFtYtYaJcmy4ie99j0sr7l+N5FYnycoDQyS5TbdnVE4x/kNvzC2iyC0iS/1/
 U8uw==
X-Gm-Message-State: AOAM530+6vNAPiUF0GijhF0+MjzIJKtncsSGP4FM+cQjbPvM3mD11dOB
 vP6FSnQHVuOQ35GY2yrGj1B+WcgbCMFNqehap9M=
X-Google-Smtp-Source: ABdhPJwnmoG+W20lK4xKjyMbovOm8m78WeBkUSS5XXpk59fRELFF93BL4jidUY14EjXLi63GEDr5eK/5mmd0F06OvU0=
X-Received: by 2002:a05:6830:1f12:: with SMTP id
 u18mr21127118otg.132.1619545582114; 
 Tue, 27 Apr 2021 10:46:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210427045118.87459-1-pavan.ramayanam@amd.com>
In-Reply-To: <20210427045118.87459-1-pavan.ramayanam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 27 Apr 2021 13:46:11 -0400
Message-ID: <CADnq5_PUxtPRnh-Mv8803zdvUn_bf5YRG9a-UVn-2b_vVgUvuA@mail.gmail.com>
Subject: Re: [PATCH] Handling of amdgpu_device_resume return value for
 graceful teardown
To: pavan.ramayanam@amd.com
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

On Tue, Apr 27, 2021 at 12:51 AM <pavan.ramayanam@amd.com> wrote:
>
> From: Pavan Kumar Ramayanam <pavan.ramayanam@amd.com>
>
> The runtime resume PM op disregards the return value from
> amdgpu_device_resume(), masking errors for failed resumes at the PM
> layer.
>
> Signed-off-by: Pavan Kumar Ramayanam <pavan.ramayanam@amd.com>

Subject should be prefixed with drm/amdgpu:, with that fixed,
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Do you need me to commit this for you?

Alex


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 0369d3532bf0..03f3cf194300 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1574,6 +1574,9 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
>                 amdgpu_device_baco_exit(drm_dev);
>         }
>         ret = amdgpu_device_resume(drm_dev, false);
> +       if (ret)
> +               return ret;
> +
>         if (amdgpu_device_supports_px(drm_dev))
>                 drm_dev->switch_power_state = DRM_SWITCH_POWER_ON;
>         adev->in_runpm = false;
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
