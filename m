Return-Path: <SRS0=ROs4=M4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272F6C4338F
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Aug 2021 12:33:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCC8861131
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Aug 2021 12:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DCC8861131
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74AC66EA1F;
	Thu,  5 Aug 2021 12:33:23 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 202666EA1F
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Aug 2021 12:33:22 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id l18so6331107wrv.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Aug 2021 05:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=pq/7PwbB0ORjkXkPsbVs9ifsbwzmZqfthsgdsrE9peo=;
 b=PbmVcajgK+C6zfCQoD60/op6Ugqli0uugni4BzHnde5z1+sQvck/4+L2fsebhdymO8
 FQO/e5Zmn4aiTEe/1z1b8eSMqnoHeLK24scdi1NGpKtVSgljEcJWVFHdbDLur29BtJby
 6aV1B+webB0ZFCw1L1sPOEp1jm1Dd/KjTbs5AtqNChU2X9djg7k6aXMgz6Cx3AUJyOPt
 DLB19jX0w+u0j6S4SGv8hga0knSMvFPn6I0oiVeLf9PjoRwUPX4VVdD/7DqcrEm5qmnp
 Ol3uh/DfiIwru/ircpdbV6W+VlQ6cMudL4dAzVl6l8NOOt0eUaYe2H4TwMfe2kSdyqK1
 m04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=pq/7PwbB0ORjkXkPsbVs9ifsbwzmZqfthsgdsrE9peo=;
 b=ZvPRr7o0n5AbUebl49/HVbm3jk/NAp5BZTkFZ+ityiriKfZm1sYzUBUIEtZI22hGPm
 X+SgbxhCaGrxHWYuJCxbqPYD/G5gtEliTsSIZ7zfZ4g0iKhuV4obgvmE1dcGz30xfCRo
 nXIxYq5L+ZykEI0lunFaSl5l6omup1MCB1gRLQtMAp3twVyrFweZmrUpGurBWGITTMUb
 HWcY4sTKy+5w7gTaRgms9zUeoxM4l5r9CvTaebKPQ0CLrXZkvXieYa1fgr4PWADAi4/y
 BBFULbiPRILJASLBnGGKNJyZZ3kx5hzdqcMiuC7j0s9MgWDyv4E/m2lTBGk0qlVQW+LJ
 eTMA==
X-Gm-Message-State: AOAM53185cOlcEL3EH1CjF2DtVolvjsq34KAa4z3NcpxHwVB7FP86YuQ
 BQCSnA/PnqOR8SySii+eCHA=
X-Google-Smtp-Source: ABdhPJwP8PzL01eP0xe6aSZwwTPEGKbYH42KVliK4VaxwnFOmJ52jJuGRleH/T95c0lPQdcPxZ6Avw==
X-Received: by 2002:adf:fc8b:: with SMTP id g11mr5010415wrr.224.1628166800726; 
 Thu, 05 Aug 2021 05:33:20 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:ae89:49de:1628:3147?
 ([2a02:908:1252:fb60:ae89:49de:1628:3147])
 by smtp.gmail.com with ESMTPSA id g138sm6701228wmg.32.2021.08.05.05.33.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Aug 2021 05:33:20 -0700 (PDT)
Subject: Re: [PATCH] DRM: gpu: radeon: Fixed coding style issues
To: =?UTF-8?Q?Sergio_Migu=c3=a9ns_Iglesias?= <lonyelon@gmail.com>,
 airlied@linux.ie
Cc: daniel@ffwll.ch, alexander.deucher@amd.com, christian.koenig@amd.com,
 Xinhui.Pan@amd.com, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Sergio_Migu=c3=a9ns_Iglesias?=
 <sergio@lony.xyz>
References: <20210804112053.263887-1-sergio@lony.xyz>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <296a3a38-2e9c-f3f2-66a8-70f52eaff2eb@gmail.com>
Date: Thu, 5 Aug 2021 14:33:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210804112053.263887-1-sergio@lony.xyz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Am 04.08.21 um 13:20 schrieb Sergio Miguéns Iglesias:
> Fixed braces, an unnecessary if statement and added a missing space.
>
> Signed-off-by: Sergio Miguéns Iglesias <sergio@lony.xyz>

Normally we see patches which just fixes coding style as unnecessary 
churn, but the "if (rbo) {}" is really ugly here.

So Reviewed-by: Christian König <christian.koenig@amd.com>.

Thanks,
Christian.

> ---
>   drivers/gpu/drm/radeon/radeon_fb.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_fb.c b/drivers/gpu/drm/radeon/radeon_fb.c
> index 0b206b052972..6640b7c947fe 100644
> --- a/drivers/gpu/drm/radeon/radeon_fb.c
> +++ b/drivers/gpu/drm/radeon/radeon_fb.c
> @@ -54,6 +54,7 @@ radeonfb_open(struct fb_info *info, int user)
>   	struct radeon_fbdev *rfbdev = info->par;
>   	struct radeon_device *rdev = rfbdev->rdev;
>   	int ret = pm_runtime_get_sync(rdev->ddev->dev);
> +
>   	if (ret < 0 && ret != -EACCES) {
>   		pm_runtime_mark_last_busy(rdev->ddev->dev);
>   		pm_runtime_put_autosuspend(rdev->ddev->dev);
> @@ -196,9 +197,8 @@ static int radeonfb_create_pinned_object(struct radeon_fbdev *rfbdev,
>   		radeon_bo_check_tiling(rbo, 0, 0);
>   	ret = radeon_bo_kmap(rbo, NULL);
>   	radeon_bo_unreserve(rbo);
> -	if (ret) {
> +	if (ret)
>   		goto out_unref;
> -	}
>   
>   	*gobj_p = gobj;
>   	return 0;
> @@ -294,9 +294,6 @@ static int radeonfb_create(struct drm_fb_helper *helper,
>   	return 0;
>   
>   out:
> -	if (rbo) {
> -
> -	}
>   	if (fb && ret) {
>   		drm_gem_object_put(gobj);
>   		drm_framebuffer_unregister_private(fb);

