Return-Path: <SRS0=VEb6=7A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C2CC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2020 07:12:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D43BD207D4
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2020 07:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWdddxQi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D43BD207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E42989DC1;
	Mon, 18 May 2020 07:12:39 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C85D589DC1
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2020 07:12:37 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id g14so21633042wme.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2020 00:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=W/U0IjzHYn9jQgWQcyUQzTAnfptdch9IbK6PIZMob3o=;
 b=VWdddxQi+pH84FqYoF/FqmvhmgdKItCZJjdhQahwMDCYu38jVt31NxFsqos5WfjdgV
 FMHHGb76SyM2FSXDKJId+IJwltMTay0M/d0jYs9dtcXNCcnRYO1awjUtq2se/KxcvTor
 kV4LQIrDrca7nyC2lxlq1hYaSxT+qWAxP6bVgb/Y0P/if9GMEoe2go4L9swQW2EPg2+l
 H4Ri3SwWDB87cSf0/kFdnBZFPSjJpyQspBI94X/xPMcyVrj5ypuLykDWzIgyC854NCMv
 SAADvCjZwsHlxa+8Cut5rN6CGkmQpbqcybcTw1pQlvKgQ4ls7cHO6mzJGUvE7hrvne7+
 LDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=W/U0IjzHYn9jQgWQcyUQzTAnfptdch9IbK6PIZMob3o=;
 b=DkuDZTvpySOvvb0m7m44upyMh3uNU6TZJx2XDcl4EPgCP2NjFMfMwQ6ZI599cNbb9w
 Gv4SVvWtGA2RTrHQ8kNlw2AdNzF5RCPCmo029a5uGoq6d7U1hCLfmlV1WChR0/BhPBwB
 IPxSIJ8vWtyn6pEfPbgnYNInITYyG9kJ1aj9pGrn7MbWQWO+tVkem4UNZvhFJ+LJay+I
 y0ZBZKuY1zU4JSiFlbtzrSyv3g8GO/2SVigpl7ELGxaAVl3ZUTIVxP9o0xmE3NRXbOXT
 jqahIuP/ayBbmjlFzRHbJ2GskyQuru0WjLUKwvgoA2lz4Oju2Hz4vLri4MlEetsn1dd/
 BDEg==
X-Gm-Message-State: AOAM531eBZxaPSCuoyrPZFgypl/zY9yGfisCfP+lK4fIjnliQmowkKRG
 6p3EqkXo4Ac+V4Zz5mg1BJ90xUFo
X-Google-Smtp-Source: ABdhPJytWtNkEwyeC+U4ibCnlzbw0a9W9W6/92f/EqEvELs8+YDOz9ywOshhOyx1Yz7v739ARLfc2Q==
X-Received: by 2002:a7b:c201:: with SMTP id x1mr17312526wmi.14.1589785956056; 
 Mon, 18 May 2020 00:12:36 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id g135sm15074898wme.22.2020.05.18.00.12.35
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 May 2020 00:12:35 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu fix incorrect sysfs remove behavior for xgmi
To: Jack Zhang <Jack.Zhang1@amd.com>, amd-gfx@lists.freedesktop.org
References: <1589777093-8738-1-git-send-email-Jack.Zhang1@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <4a086ecb-5143-9aaa-1306-8dc5ebf2fffe@gmail.com>
Date: Mon, 18 May 2020 09:12:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1589777093-8738-1-git-send-email-Jack.Zhang1@amd.com>
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
Reply-To: christian.koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 18.05.20 um 06:44 schrieb Jack Zhang:
> Under xgmi setup,some sysfs fail to create for the second time of kmd
> driver loading. It's due to sysfs nodes are not removed appropriately
> in the last unlod time.
>
> Changes of this patch:
> 1. remove sysfs for dev_attr_xgmi_error
> 2. remove sysfs_link adev->dev->kobj with target name.
>     And it only needs to be removed once for a xgmi setup
> 3. remove sysfs_link hive->kobj with target name
>
> In amdgpu_xgmi_remove_device:
> 1. amdgpu_xgmi_sysfs_rem_dev_info needs to be run per device
> 2. amdgpu_xgmi_sysfs_destroy needs to be run on the last node of
> device.
>
> Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 22 +++++++++++++++-------
>   1 file changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index e9e59bc..bfe2468 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -325,9 +325,17 @@ static int amdgpu_xgmi_sysfs_add_dev_info(struct amdgpu_device *adev,
>   static void amdgpu_xgmi_sysfs_rem_dev_info(struct amdgpu_device *adev,
>   					  struct amdgpu_hive_info *hive)
>   {
> +	char node[10] = { 0 };

Please don't initialize things like this, use memset() instead.

Regards,
Christian.

>   	device_remove_file(adev->dev, &dev_attr_xgmi_device_id);
> -	sysfs_remove_link(&adev->dev->kobj, adev->ddev->unique);
> -	sysfs_remove_link(hive->kobj, adev->ddev->unique);
> +	device_remove_file(adev->dev, &dev_attr_xgmi_error);
> +
> +	if (adev != hive->adev) {
> +		sysfs_remove_link(&adev->dev->kobj,"xgmi_hive_info");
> +	}
> +
> +	sprintf(node, "node%d", hive->number_devices);
> +	sysfs_remove_link(hive->kobj, node);
> +
>   }
>   
>   
> @@ -583,14 +591,14 @@ int amdgpu_xgmi_remove_device(struct amdgpu_device *adev)
>   	if (!hive)
>   		return -EINVAL;
>   
> -	if (!(hive->number_devices--)) {
> +	task_barrier_rem_task(&hive->tb);
> +	amdgpu_xgmi_sysfs_rem_dev_info(adev, hive);
> +	mutex_unlock(&hive->hive_lock);
> +
> +	if(!(--hive->number_devices)){
>   		amdgpu_xgmi_sysfs_destroy(adev, hive);
>   		mutex_destroy(&hive->hive_lock);
>   		mutex_destroy(&hive->reset_lock);
> -	} else {
> -		task_barrier_rem_task(&hive->tb);
> -		amdgpu_xgmi_sysfs_rem_dev_info(adev, hive);
> -		mutex_unlock(&hive->hive_lock);
>   	}
>   
>   	return psp_xgmi_terminate(&adev->psp);

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
