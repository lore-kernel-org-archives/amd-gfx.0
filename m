Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC9AC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jun 2022 10:34:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A71EC11A524;
	Tue, 28 Jun 2022 10:34:55 +0000 (UTC)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28400113359
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 10:34:53 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4LXLZL2bFCz9sbl;
 Tue, 28 Jun 2022 12:34:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1656412490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GCsmhwxPKBHJ46dWmiVRWHiUT3ks2E1dAcyONJ6hmBo=;
 b=osKoUFpDaV9Xn6/YR52+bC3Tp28nCtNfV1JX5uc6mV+dvDRWGRuKf/MHczF+HeCF4rqvR7
 mezcwxwPkJRVbqBszbnVuriVCGDFFqb56FfwdDKZl6ybcE1cZhXjAEVbKEzu/c9i+avuJy
 lLhvsIRSB4qRpw7QlHM89oMr1xADNSThQcLNaR0vCS79jfevUDcDgd+uYUamRsUMkX+xHh
 T58dZSzAHkXHgmwp1SyMUhnYq7ZVj6wokc/STn8FlrgS1dFtokX/XxUiId1/ylmbG7yicV
 CTJOo7cvhVVQ+tSZZmZsMfvlZhAuTHjdcj6XiuHiWgfBRE7IdRMx6quP7QoJ/w==
Message-ID: <9d02d901-8015-dc02-250b-97ed1cfa16c2@mailbox.org>
Date: Tue, 28 Jun 2022 12:34:48 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 09/14] drm/radeon: use drm_oom_badness
Content-Language: en-CA
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 dri-devel@lists.freedesktop.org
References: <20220624080444.7619-1-christian.koenig@amd.com>
 <20220624080444.7619-10-christian.koenig@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <20220624080444.7619-10-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: cutc5b13i4ckkykp1cme1mpqiajc1ikh
X-MBO-RS-ID: dec7526ba758fff16cd
X-Rspamd-Queue-Id: 4LXLZL2bFCz9sbl
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
Cc: mhocko@suse.com,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-06-24 10:04, Christian König wrote:
> This allows the OOM killer to make a better decision which process to reap.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/radeon/radeon_drv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
> index 956c72b5aa33..11d310cdd2e8 100644
> --- a/drivers/gpu/drm/radeon/radeon_drv.c
> +++ b/drivers/gpu/drm/radeon/radeon_drv.c
> @@ -550,6 +550,7 @@ static const struct file_operations radeon_driver_kms_fops = {
>  #ifdef CONFIG_COMPAT
>  	.compat_ioctl = radeon_kms_compat_ioctl,
>  #endif
> +	.file_rss = drm_file_rss,
>  };
>  
>  static const struct drm_ioctl_desc radeon_ioctls_kms[] = {

Shortlog should now say "use drm_file_rss", right?


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer
