Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86552EE14D0
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Sep 2023 07:03:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20F0E10E774;
	Thu,  7 Sep 2023 07:03:51 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66CA110E774
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Sep 2023 07:03:50 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9a65f9147ccso66732866b.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Sep 2023 00:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694070229; x=1694675029; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3F5qdrNMRQPlna2b5xgS4IlqRcKmNFR4cjR9i9vXjTo=;
 b=DyzZYWnn4djr8PCHtsWc923x5OAIMgZATolptGRWp1hPwyDYK4aXjroYjHX///3bjt
 w7EkntZBZ6AYCpCsAu0ocWn11ifOkqn34qFZRbfbfMc+3S81LMomjUUOFC69hPbdK6uS
 adAXcBozqjSgvvFzowUjRulP+1lLROt4tJbbaKuDus62itzvHCSYHHuHmb2XhYjnQaDE
 NF5mH0C5O+mCc2Alo5xHhKOVb3/WxzeCZaTQXjJ6l/gW3SVQpkB1O9QgMYgjJId2vhzc
 CvshzwmArZ0cOxjqvz7nmAI3aa08m5ShKQKFZP4ObEbS5Ec3Gy5CknCLg4JQggM9hZ//
 jomw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694070229; x=1694675029;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3F5qdrNMRQPlna2b5xgS4IlqRcKmNFR4cjR9i9vXjTo=;
 b=h2oo2weQvWan73+FdMSbyHc+hofx9UHZ860hSCyyuBTB9Zos+wgsc+VEGe9LpsOqMu
 v0SMMB/3+UsyFh4/d5toErBqgD0Y4YQy7PQVumjLXz/5UT7BW9eWJ6971AK0q1QldIBP
 LdRFrmC4kGn+10RchaGFg0TAA85rXYkJZDLinTpU6Dk1dzgRgJQ+I0/KnMMnqKbMXVmS
 bNasTf8eRcXZFkG2uNhLfThy31calG+tkQGJxEAYry05rlImn0DGugyfdVl2jOrrnzU8
 pD842FGpSt2zohZbOOyWsseh3KTlYr8jnOSp3Sg+hPy544DbQavrPvjGvM117sEyD3Ys
 aHww==
X-Gm-Message-State: AOJu0YxGBL3KsbC2cJo55yEydfkx25FORBPHSSeRX4icaH/HKva/N5hn
 BKMIYAlFyYzenusQlu17Guc=
X-Google-Smtp-Source: AGHT+IHbPtdiWTpEoOIk0yKaSTCjbk/QTr5OWN0TH26+HgSw2j2dCVX7TlqBvkQWqm+MnLaTeRFHaQ==
X-Received: by 2002:a17:906:768d:b0:9a6:3d19:df7 with SMTP id
 o13-20020a170906768d00b009a63d190df7mr4251180ejm.17.1694070228534; 
 Thu, 07 Sep 2023 00:03:48 -0700 (PDT)
Received: from [192.168.178.25] ([134.19.111.81])
 by smtp.gmail.com with ESMTPSA id
 g4-20020a170906594400b0099b76c3041csm10004261ejr.7.2023.09.07.00.03.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Sep 2023 00:03:48 -0700 (PDT)
Message-ID: <f9db3fc9-2247-8998-0587-1cadc051be18@gmail.com>
Date: Thu, 7 Sep 2023 09:03:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] drm/radeon: make fence wait in suballocator
 uninterrruptable
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230906195517.1345717-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230906195517.1345717-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: Simon Pilkington <simonp.git@gmail.com>, stable@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 06.09.23 um 21:55 schrieb Alex Deucher:
> Commit 254986e324ad ("drm/radeon: Use the drm suballocation manager implementation.")
> made the fence wait in amdgpu_sa_bo_new() interruptible but there is no
> code to handle an interrupt. This caused the kernel to randomly explode
> in high-VRAM-pressure situations so make it uninterruptible again.
>
> Fixes: 254986e324ad ("drm/radeon: Use the drm suballocation manager implementation.")
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2769
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> CC: stable@vger.kernel.org # 6.4+
> CC: Simon Pilkington <simonp.git@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

Going to push this to drm-misc-fixes in a minute.

Regards,
Christian.

> ---
>   drivers/gpu/drm/radeon/radeon_sa.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_sa.c b/drivers/gpu/drm/radeon/radeon_sa.c
> index c87a57c9c592..22dd8b445685 100644
> --- a/drivers/gpu/drm/radeon/radeon_sa.c
> +++ b/drivers/gpu/drm/radeon/radeon_sa.c
> @@ -123,7 +123,7 @@ int radeon_sa_bo_new(struct radeon_sa_manager *sa_manager,
>   		     unsigned int size, unsigned int align)
>   {
>   	struct drm_suballoc *sa = drm_suballoc_new(&sa_manager->base, size,
> -						   GFP_KERNEL, true, align);
> +						   GFP_KERNEL, false, align);
>   
>   	if (IS_ERR(sa)) {
>   		*sa_bo = NULL;

