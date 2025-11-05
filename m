Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 918B2CCF9F8
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 09:45:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E27210E2D7;
	Wed,  5 Nov 2025 09:45:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="l23jIGZz";
	dkim-atps=neutral
X-Greylist: delayed 548 seconds by postgrey-1.36 at gabe;
 Wed, 05 Nov 2025 09:45:44 UTC
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAF9810E2D7
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 09:45:44 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4d1gFD1qXqz9tSG;
 Wed,  5 Nov 2025 10:36:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762335392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oBZ0pIMXONiJhjfSFBMYwgpP7H9XMze04T5vP2FWER8=;
 b=l23jIGZzugTvq6kxvEyPqHi6de4FpWf6QCZWseZ0JcXhBMmANrl7FCxWzVLGXNziGnwG3A
 muuEZEhT3s6RiqKBMMyPLvX65r6xEypsu1IelnDtOIUbZH1R1JYqWXrzute2ZKkXRMRPj5
 OvWvgMbi+PiDfP7QkrlQ7x4N5OtP03hVhRhOZl7ZvkPMFYSLMRGIXcdWhZGXHSx96ahKk2
 B8tbsHUo1t1jTsBKVjl0jHzhyyA5zR+PMkpOUtjfDlcosYA89xmtZW/4ciEb6ukV0aZB1X
 J6dNrNBaJ9zum1vCkjksvdvXfjZtYwbb8uFxoCXbIqOxLHA7TgTkSBpBUvxADg==
Message-ID: <fcac60d6-1bea-4e02-aa7a-4521c52f0148@mailbox.org>
Date: Wed, 5 Nov 2025 10:36:29 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] amdkfd: Do nto wait for queue op response during reset
To: Ahmad Rehman <Ahmad.Rehman@amd.com>
Cc: Lijo.Lazar@amd.com, amd-gfx@lists.freedesktop.org
References: <20251104173325.1381513-1-Ahmad.Rehman@amd.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <20251104173325.1381513-1-Ahmad.Rehman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 2bc02d2c8f4c65ab47c
X-MBO-RS-META: ajmaak31tfz73b1obnoor8tecqbyoia7
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

On 11/4/25 18:33, Ahmad Rehman wrote:
> This patch adds the condition to not wait for
> the queue response for unmap, if the gpu is in reset.
> 
> Signed-off-by: Ahmad Rehman <Ahmad.Rehman@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 4fbe865ff279..0904c36192c7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -2094,7 +2094,8 @@ int amdkfd_fence_wait_timeout(struct device_queue_manager *dqm,
>  
>  	while (*fence_addr != fence_value) {
>  		/* Fatal err detected, this response won't come */
> -		if (amdgpu_amdkfd_is_fed(dqm->dev->adev))
> +		if (amdgpu_amdkfd_is_fed(dqm->dev->adev) ||
> +				amdgpu_in_reset(dqm->dev->adev))
>  			return -EIO;
>  
>  		if (time_after(jiffies, end_jiffies)) {

Indentation of the second new line looks wrong, should be aligned to the opening parenthesis.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
