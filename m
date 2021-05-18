Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92722C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 15:23:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D31B61185
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 15:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D31B61185
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 063016EBB5;
	Tue, 18 May 2021 15:23:48 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB3B96EBB5
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 15:23:45 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id s6so11649406edu.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 08:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=msa6Gw/+3UOPTcIohmKWEB/H9l3M7iUxAFIXroWQiDc=;
 b=H9OhRHuVHTUb6OgFoqZOmRyL3iHhlw2yrETJzk2TauyvGRm4SCTFzD7nErH7XhnL7O
 XApZ51rbgOIAorlbVHZX2z7MaiJZbgnyyIt5+YTn0HPL6uFGAt0dWXznCVNZrEa54MRt
 9YoKmeFI8IpuWXdZMvEoE+sv8ckcDjJUwYcmoP4e3AIHuKu+IE7dcm5eJz9INChgv+EC
 zmzbBnvvwRi/d9t6ddC7z8w4+olHSs03goRd+JeXLoXyeY+hqWh4gzwiH7cEJeNxH2lE
 cglVy4+zoIJzWUhbNnb+Oprb8YScnMQOKOJtSdzE4yyeCRfEdssTpiP4zl9s8OszPTwM
 0+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=msa6Gw/+3UOPTcIohmKWEB/H9l3M7iUxAFIXroWQiDc=;
 b=FstR/ETnlS9Fp3hfl2dCmiUKu74CE0OW8qGhxO0d6FJ7JDUa+nMTz3gsRX9zgjIsxO
 lqMJEoaSPXLYpI6Y+xlE/WqABIuNUwGyILZuIo8ripdxkTc6LhGdsybrbAWbzv3iF1fi
 Z/SsaE5sIZnTPT1JnFoSdwllNdeHkXEqPeIo+50emXOnN8OM7eMut4PvXFfaqmVQ19qS
 x0ufw+O6woLAxdbO5qRZk/xQ1sXCJium07cCVBQN5Qs/E7r31SObY9Yp0wEr6/bhnL8p
 Sj+E4DymVnuRMOnmRAcFNe3Cv0+ZNXNCO0ldGwMRNO0WVA3gNlDQk1xo3swyqXRzexiz
 lt2A==
X-Gm-Message-State: AOAM532+br8UG9uNcNJV4hTYJWnrr8Z9du/tdm7x1HY2OXykqeO3UuIp
 6Vn/fuhw2gWGfogAAZAWQLeN1dcn7KQ=
X-Google-Smtp-Source: ABdhPJyEdItS1ikRfTl0hp+rSqp7QVK3Gq/n7GslaVVDTC1DsrITH2tqt6FrkaBZ2RPppiE2xFuwXA==
X-Received: by 2002:aa7:dc0b:: with SMTP id b11mr7838115edu.124.1621351424657; 
 Tue, 18 May 2021 08:23:44 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:3b27:1830:9671:4cc9?
 ([2a02:908:1252:fb60:3b27:1830:9671:4cc9])
 by smtp.gmail.com with ESMTPSA id g21sm272256edb.92.2021.05.18.08.23.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 May 2021 08:23:44 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu/vcn1: add cancel_delayed_work_sync before
 power gate
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1621350686-25923-1-git-send-email-James.Zhu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <352509e8-a836-f803-fbda-e31e0283dc41@gmail.com>
Date: Tue, 18 May 2021 17:23:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1621350686-25923-1-git-send-email-James.Zhu@amd.com>
Content-Language: en-US
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
Cc: jamesz@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 18.05.21 um 17:11 schrieb James Zhu:
> Add cancel_delayed_work_sync before set power gating state
> to avoid race condition issue when power gating.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 0c1beef..6c5c083 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -230,10 +230,27 @@ static int vcn_v1_0_hw_init(void *handle)
>   static int vcn_v1_0_hw_fini(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_ring *ring;
> +	int i;
> +
> +	ring = &adev->vcn.inst->ring_dec;
> +	ring->sched.ready = false;
> +
> +	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
> +		ring = &adev->vcn.inst->ring_enc[i];
> +		ring->sched.ready = false;
> +	}
> +
> +	ring = &adev->jpeg.inst->ring_dec;
> +	ring->sched.ready = false;

Thinking more about that this is a really big NAK. The scheduler threads 
must to stay ready during a reset.

This is controlled by the upper layer and shouldn't be messed with in 
the hardware specific backend at all.

I've removed all of those a couple of years ago.

Regards,
Christian.

> +
> +	cancel_delayed_work_sync(&adev->vcn.idle_work);
>   
>   	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -		RREG32_SOC15(VCN, 0, mmUVD_STATUS))
> +		(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> +		 RREG32_SOC15(VCN, 0, mmUVD_STATUS))) {
>   		vcn_v1_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
> +	}
>   
>   	return 0;
>   }

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
