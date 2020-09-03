Return-Path: <SRS0=hFGi=CM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CBFC433E2
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 13:41:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E269B2072A
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 13:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o36NlXdM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E269B2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76DB76E1D5;
	Thu,  3 Sep 2020 13:41:16 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FA0B6E1D7
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2020 13:41:15 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id z9so2959085wmk.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Sep 2020 06:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tnSMmHTQcHP6Z68EQxHm4TxxTEHGAya8wZs13ngbe08=;
 b=o36NlXdMu23QKucfApg0gjXgcKAw+XRg/kt1PCVrSrTevypscuweOzmdCspEJnfpUA
 nU+EwZ7tMomZfA82JA583ucD/ys/q/dneF1nA+VITLYGrCpc67E2C1cj7wA3w1+JSSiQ
 4grqf02JBwCO4dm6p+E8oyf8BqqjcWaLi+pWvkkaSQZGMIglEQ1Y6zELIZMyZso7nTy0
 PRoAg7hiXlosUflYxqBgSKmgB1s4k7DDrcO9q+QO+5vvZZGne2ZykBGE3qLB8IbBcpoj
 cKLbR3+B3AqMIlj17FKgeIPWL1J6/XJjsG2gamG4CiSDaLjvlSFxnQNYjQ5F0fJpSXwx
 LNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tnSMmHTQcHP6Z68EQxHm4TxxTEHGAya8wZs13ngbe08=;
 b=Wd8s588VNFLpwxQ6H/VW4Q5ZfXFmWfXwpuqkcRMr82JYnQjzJgFMhGEgwm/Ngd9vgI
 m5hWeVjLPLUDGh5n+hUm/BblAkSaMlzzzc2Ot6/wCbvviBoqDGYMDBoWx/QLr9J84fij
 eYjaCwhvcAC9FEAnXEcYeWUR4fvy0ZCjw2Fz/TDwFw6Etu9/3mYbLyNgjp0dRZAsg6Hl
 r2WbS6KJOBBSbnJ96WdMzBt609GGX5dZId9GZHStSkD+LtUUGLRefA0FuL1aBKeOfQfP
 IK8oIKiQa8WnMy3ecvwt9AIniASzwehFrbMEA0cF3jDNTRGhx9NzZg47WIjmvUR3HJuP
 7pcg==
X-Gm-Message-State: AOAM5320eqPT5qFbwpjk9wX1uRGjQsGReK8TX7dyCYWvZSoE2gFGSOvv
 fzirCFcjOWvOSFU25Wf2QiLqHj4/zYC7csHMKZlEIJv6
X-Google-Smtp-Source: ABdhPJxeFBmOaNOZ+0nGWGb0HnxdLhxK118UZKFj+AE38vDDHEus7N9BpY8gPmO5Q10iTrM0t83fJnhhOLJWw8ZL7pQ=
X-Received: by 2002:a1c:7d4d:: with SMTP id y74mr2577297wmc.73.1599140473920; 
 Thu, 03 Sep 2020 06:41:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200902083134.25569-1-evan.quan@amd.com>
 <20200902083134.25569-9-evan.quan@amd.com>
In-Reply-To: <20200902083134.25569-9-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 3 Sep 2020 09:41:02 -0400
Message-ID: <CADnq5_PvCJFGvKW27K=mnoZOtLtiSuQkJWKA4cQkG3SQMkJ00g@mail.gmail.com>
Subject: Re: [PATCH 9/9] drm/amd/pm: make namings and comments more readable
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Sep 2, 2020 at 4:32 AM Evan Quan <evan.quan@amd.com> wrote:
>
> And to fit more accurately what the cod does.
>
> Change-Id: I2d917e66b55925c3a14aa96ac8e0c8c2110848c0
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 801c92eb439f..cd5394d4beb0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2185,7 +2185,7 @@ static int navi10_run_btc(struct smu_context *smu)
>         return ret;
>  }
>
> -static bool navi10_need_umc_cdr_12gbps_workaround(struct smu_context *smu)
> +static bool navi10_need_umc_cdr_workaround(struct smu_context *smu)
>  {
>         struct amdgpu_device *adev = smu->adev;
>
> @@ -2276,7 +2276,7 @@ static int navi10_set_dummy_pstates_table_location(struct smu_context *smu)
>                                                NULL);
>  }
>
> -static int navi10_disable_umc_cdr_12gbps_workaround(struct smu_context *smu)
> +static int navi10_run_umc_cdr_workaround(struct smu_context *smu)
>  {
>         struct amdgpu_device *adev = smu->adev;
>         uint8_t umc_fw_greater_than_v136 = false;
> @@ -2284,7 +2284,7 @@ static int navi10_disable_umc_cdr_12gbps_workaround(struct smu_context *smu)
>         uint32_t param;
>         int ret = 0;
>
> -       if (!navi10_need_umc_cdr_12gbps_workaround(smu))
> +       if (!navi10_need_umc_cdr_workaround(smu))
>                 return 0;
>
>         ret = smu_cmn_send_smc_msg_with_param(smu,
> @@ -2655,7 +2655,7 @@ static int navi10_post_smu_init(struct smu_context *smu)
>                 return ret;
>         }
>
> -       ret = navi10_disable_umc_cdr_12gbps_workaround(smu);
> +       ret = navi10_run_umc_cdr_workaround(smu);
>         if (ret)
>                 dev_err(adev->dev, "Failed to apply umc cdr workaround!\n");
>
> --
> 2.28.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
