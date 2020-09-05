Return-Path: <SRS0=S4aW=CO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274C9C43461
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Sep 2020 21:57:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F31C20760
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Sep 2020 21:56:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F31C20760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A42596E362;
	Sat,  5 Sep 2020 21:56:58 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6E266E362
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Sep 2020 21:56:57 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5af699.dynamic.kabel-deutschland.de
 [95.90.246.153])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0C117206442F5;
 Sat,  5 Sep 2020 23:56:54 +0200 (CEST)
Subject: Re: [PATCH] radeon: Use only a single work queue thread for crt
To: Andi Kleen <andi@firstfloor.org>,
 Alexander Deucher <Alexander.Deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20190803000908.5310-1-andi@firstfloor.org>
From: Paul Menzel <pmenzel+amd-gfx@molgen.mpg.de>
Message-ID: <d48d0d45-46eb-cf02-2603-c23aa4e7d157@molgen.mpg.de>
Date: Sat, 5 Sep 2020 23:56:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20190803000908.5310-1-andi@firstfloor.org>
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
Cc: Andi Kleen <ak@linux.intel.com>, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Andi,


Am 03.08.19 um 02:09 schrieb Andi Kleen:
> From: Andi Kleen <ak@linux.intel.com>
> 
> I got tired of seeing a lot of radeon-crt kernel threads in ps on my
> workstation, one for each CPU and one for each display, which never use any CPU time.
> Surely a single kernel thread is enough to handle the display.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>   drivers/gpu/drm/radeon/radeon_display.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
> index bd52f15e6330..fb0ca688f6fe 100644
> --- a/drivers/gpu/drm/radeon/radeon_display.c
> +++ b/drivers/gpu/drm/radeon/radeon_display.c
> @@ -682,7 +682,7 @@ static void radeon_crtc_init(struct drm_device *dev, int index)
>   
>   	drm_mode_crtc_set_gamma_size(&radeon_crtc->base, 256);
>   	radeon_crtc->crtc_id = index;
> -	radeon_crtc->flip_queue = alloc_workqueue("radeon-crtc", WQ_HIGHPRI, 0);
> +	radeon_crtc->flip_queue = alloc_workqueue("radeon-crtc", WQ_HIGHPRI|WQ_UNBOUND, 0);
>   	rdev->mode_info.crtcs[index] = radeon_crtc;
>   
>   	if (rdev->family >= CHIP_BONAIRE) {

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
