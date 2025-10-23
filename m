Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D089DCCD1BC
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Oct 2025 12:58:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A27510E408;
	Thu, 23 Oct 2025 12:58:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="ImGUBfjZ";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 201C010E8D6
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Oct 2025 08:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1761208606;
 bh=08czwfWnlPMIpqql5kd6oFtIulIPYNZfTQcKVVm39ak=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=ImGUBfjZmyC2H/390jykNrSExURMxO3gj7gR7HZuoE1JscX//GLPiqrwFzSw98Z8Q
 OEgoKoRBw/yquiO4Q6VC/as+scRlGtmqHuTC+q0zyKnvibDjf1nHhcht+WBRS2brt+
 nX3r+SBhrlZwnd6Glzx7QIWEZIw70J7zkF1lSndcX27b/O0CxESnHoblK/Hnkugh2a
 nbmXoGL/YaDaEJUTezANmZcWe4ar4iIgEbNRxB0mjzuVRDNlQSADDjFSJPIr26Qiz9
 jEFOsPP/xJo5VBEAfdStkgFEhofcpeIPsP+uukfuyuKNK593T7ybIGxs2PjRbhLF8+
 VGI1GqxTxqqRA==
Received: from [192.168.100.50] (unknown [144.48.130.189])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: usama.anjum)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 0B4F717E0964;
 Thu, 23 Oct 2025 10:36:43 +0200 (CEST)
Message-ID: <217840b8-2a44-4788-8e2e-e5525f32ca8f@collabora.com>
Date: Thu, 23 Oct 2025 13:36:14 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@collabora.com, "Mario Limonciello (AMD)"
 <superm1@kernel.org>, linux-doc@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] PM: Allow device drivers to manage the frozen state
 of a device
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org, corbet@lwn.net, rafael@kernel.org,
 gregkh@linuxfoundation.org, dakr@kernel.org
References: <20251022155114.48418-1-mario.limonciello@amd.com>
 <20251022155114.48418-2-mario.limonciello@amd.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20251022155114.48418-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 23 Oct 2025 12:58:42 +0000
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

On 10/22/25 8:50 PM, Mario Limonciello wrote:
> From: "Mario Limonciello (AMD)" <superm1@kernel.org>
> 
> During a normal successful hibernate sequence devices will go through
> the freeze() callbacks create an image, go through the thaw() callbacks,
> and poweroff() callbacks.
> 
> During a successful hibernate sequence some device drivers may want to
> skip the thaw() callbacks.  This confuses the PM core though because it
> thinks the device is no longer suspended.
> 
> To accommodate drivers that want to do this, introduce a new is_frozen
> bit that the driver can set and manage.  From the driver perspective
> any thaw() or restore() callbacks that are being skipped should set
> is_frozen and return an error code.  The PM core will then put the
> device back into the list of devices to resume for any aborted hibernate.
> 
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  Documentation/driver-api/pm/devices.rst | 8 ++++++++
>  drivers/base/power/main.c               | 5 +++++
>  include/linux/pm.h                      | 3 +++
>  3 files changed, 16 insertions(+)
> 
> diff --git a/Documentation/driver-api/pm/devices.rst b/Documentation/driver-api/pm/devices.rst
> index 36d5c9c9fd11..55c633727108 100644
> --- a/Documentation/driver-api/pm/devices.rst
> +++ b/Documentation/driver-api/pm/devices.rst
> @@ -578,6 +578,14 @@ should already have been stored during the ``freeze``, ``freeze_late`` or
>  the entire system, so it is not necessary for the callback to put the device in
>  a low-power state.
>  
> +Skipping thaw phase
> +-------------------
> +In some rare situations, it may be desirable to skip the thaw phases
> +(``thaw_noirq``, ``thaw_early``, ``thaw``) of a device entirely.  This can be
> +achieved by a device driver returning an error code from any of it's thaw
> +callbacks but also setting dev->power.is_frozen to true.  This indicates to the
> +PM core that the device is still in the frozen state.  The PM core will consider
> +this when resuming the device in later phases such as `restore` or `poweroff`.
>  
>  Leaving Hibernation
>  -------------------
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index e83503bdc1fd..451d54486645 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1100,6 +1100,11 @@ static void device_resume(struct device *dev, pm_message_t state, bool async)
>  
>   End:
>  	error = dpm_run_callback(callback, dev, state, info);
> +	/* device manages frozen state */
> +	if (error && dev->power.is_frozen) {
> +		dev->power.is_suspended = true;
> +		error = 0;
> +	}
>  
>  	device_unlock(dev);
>  	dpm_watchdog_clear(&wd);
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index cc7b2dc28574..52ee38d72aa2 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -688,6 +688,9 @@ struct dev_pm_info {
>  #else
>  	bool			should_wakeup:1;
>  #endif
> +#ifdef CONFIG_HIBERNATE_CALLBACKS
> +	bool			is_frozen:1;	/* Owned by the driver */
> +#endif
>  #ifdef CONFIG_PM
>  	struct hrtimer		suspend_timer;
>  	u64			timer_expires;


-- 
---
Thanks,
Usama
