Return-Path: <SRS0=PfTh=NJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493A9C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Aug 2021 08:06:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1433B60E76
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Aug 2021 08:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1433B60E76
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CEDC6E49A;
	Wed, 18 Aug 2021 08:06:48 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71FF56E49A
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Aug 2021 08:06:46 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id l11so2111415wrx.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Aug 2021 01:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=H9rXYnAGMtO8d0FEaf5xM940BMijAbIrTHN6nPT9NTE=;
 b=FkoDysTg/FbTAzJ71f/ADnxV8SCcvbVEEEiBZ/lVShSN3VpnwoyXvsPbBadG33CUeu
 vpHkGOBlOSO4NMcWdQwCz3zBVkBiwtlo7a/BYE5MOM/S7dyw+BMWeElpsuSllbVjRFuW
 ziQZt8z5hu0UYcQ/ji+yDNMcgr3IMPkdhGu7qctg5nrZggTkm7E08IOFoyYWDb0uayJH
 JuYChvM9kp0nDusGxFv42AlQRxDBy1JqYn4eFSv8ddtMqGRuI1z1MLcQUyuOi2BJg8kK
 /8WJLaUWA6jdfxVwXRPvx2rCqTAc+foXx1cesCiqnHnhwWXXFVPv7MKee7+AzMUUZOIX
 Cerg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=H9rXYnAGMtO8d0FEaf5xM940BMijAbIrTHN6nPT9NTE=;
 b=AzcbQB2oH7BMI5oQvS2jhiAFShv9t4KFkcf5HOYdr5XoQ71ToY7zdOKkfkPZHpXDJO
 zD9MfgZEpZw0uVFhcAMl1RLr3e3KqFD3TnJaoDeeWPunZ+HNQ0nx/kqht6Qums4c3+hd
 TlRxAeBDQY7Cf23ScEl//zzYZH8F8moMuLix9n7rzYtTCzNhC1LTmmy0tVd463hoq608
 SpXpFzynoslx6DI/QOGkohmeJdBfyubi/CBEDPH+DsfDJcDgFsISeBieoF4y8Q8c4Pje
 ixZA2Z7IHFIaoxYWMwoykWERZn0/QVco+F+FrQ3OkPT4XXKpuvY57Lp/MZfmQh1o4rfJ
 wo8A==
X-Gm-Message-State: AOAM5315LSnGPkRq/CLokXS6gyKT2kG4OAiHN8uAZXOLHhEkvLoPX5FW
 1hiakyI+MM/7R5ON4cQZlX1rUN9e3rw=
X-Google-Smtp-Source: ABdhPJxdr4q1hipSke9TL/CuoA891lsaoJnu8lDcHKyHoNAuUYAkfUWljD+GLl+iTar087CposTDZg==
X-Received: by 2002:a5d:5008:: with SMTP id e8mr8818416wrt.103.1629274005015; 
 Wed, 18 Aug 2021 01:06:45 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de.
 [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id i8sm4755089wrv.70.2021.08.18.01.06.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Aug 2021 01:06:44 -0700 (PDT)
Subject: Re: [PATCH] drm/amd/amdgpu:flush ttm delayed work before cancel_sync
To: YuBiao Wang <YuBiao.Wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Evan Quan <Evan.Quan@amd.com>, horace.chen@amd.com,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Jack Xiao
 <Jack.Xiao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Kevin Wang <Kevin1.Wang@amd.com>
References: <20210817095005.8536-1-YuBiao.Wang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <2696feb8-c937-c687-b449-2aebffae6116@gmail.com>
Date: Wed, 18 Aug 2021 10:06:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210817095005.8536-1-YuBiao.Wang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 17.08.21 um 11:50 schrieb YuBiao Wang:
> [Why]
> In some cases when we unload driver, warning call trace
> will show up in vram_mgr_fini which claims that LRU is not empty, caused
> by the ttm bo inside delay deleted queue.
>
> [How]
> We should flush delayed work to make sure the delay deleting is done.
>
> Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 4d266c40382c..0b5764aa98a4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3824,8 +3824,10 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>   {
>   	dev_info(adev->dev, "amdgpu: finishing device.\n");
>   	flush_delayed_work(&adev->delayed_init_work);
> -	if (adev->mman.initialized)
> +	if (adev->mman.initialized) {
> +		flush_delayed_work(&adev->mman.bdev.wq);
>   		ttm_bo_lock_delayed_workqueue(&adev->mman.bdev);
> +	}

If you flush the delayed work you can drop the call to 
ttm_bo_lock_delayed_workqueue().

It would also be nice to have to wrap this into a 
ttm_bo_flush_delayed_workqueue() function.

Apart from that looks good to me,
Christian.

>   	adev->shutdown = true;
>   
>   	/* make sure IB test finished before entering exclusive mode

