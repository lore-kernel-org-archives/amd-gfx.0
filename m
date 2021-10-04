Return-Path: <SRS0=otPk=OY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6858C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 08:31:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 700E761130
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 08:31:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 700E761130
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7A086E95B;
	Mon,  4 Oct 2021 08:31:26 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DF696E95B
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Oct 2021 08:31:26 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id t8so29414748wri.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Oct 2021 01:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=UdUrSHVFZvxtnxaz4hN+hmBUeV2/FrCsSbPjleSsdbc=;
 b=RGLKBURBhjreR6PFU6EWP1tya68JKv8/E+oN3JGIXWhqFB6RgKGZ73duRgZRnNe+NH
 k/cUhU/IP/siJHMOLGn/stpXgomweeA0+sEDebZYUFdluL8r0Y6S894HlmfQhnTDZBNF
 pZ32GgGITXfafPjIZrqsxFTJ9lXiqeihDpNLPFCshXpdcgvevmZT7gGwMQPWs9M2ncV4
 GuDXby+93KsEP5YrJnKod81HSGNUEwmEsGD+v4S7gNIMLiZ9PImVB9TNP/U6JVR7xpYm
 TCD+i6x6j3n7xdUYJs6wYTytss8klfqJ4th4rnlOHMkxFQEekTLmQJEvVFb5fB+4nqNp
 Ygng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=UdUrSHVFZvxtnxaz4hN+hmBUeV2/FrCsSbPjleSsdbc=;
 b=qF2VC8H8kJkHfAh2zERj03eQq7OXYGA5JYwF/XsUUl+z5guTqzs35tlHqeM/DXYUBn
 aIG9Wustz/xZtnx+Aj23AY23GODFVAj9aPkTAqKRtJeI4+I5HrjyKfSX9+L2kOBNxeYp
 Zyt+Yx+3Yc3OMjMC2J8H79Iadgl9/M51muoZaWHYAI9lzSXKPOkyPc4nCfzlqegcp8cU
 DV5bsn4TXXK29qH1GDQZn55J/S2OX1d+ZfFyif65+rPfz3D5Bs6sQlvsI9sPcibUnHyb
 0Zvkbv38fxxRUZwrg6myuGTMmTtvA4v933b4F58s3COwuPwvK4nQBnwhIbONjXiaYd4a
 piWA==
X-Gm-Message-State: AOAM532zd3qYYYqq9O3XEv2GE+igdPKmuZMNbxNgmQPYO+774+NG/S1G
 ZRl6OG6QqFTc8Xq0L97SPzzzUqWxbFU=
X-Google-Smtp-Source: ABdhPJyD3CXp+hroYZmJdi7MzlFciOq6ujWzD4liqHQf44y7XImwRJsU3vcDpoICAPMXKM9g2UB8RA==
X-Received: by 2002:adf:bb09:: with SMTP id r9mr12526808wrg.238.1633336284575; 
 Mon, 04 Oct 2021 01:31:24 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de.
 [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id f8sm13437246wrx.15.2021.10.04.01.31.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Oct 2021 01:31:24 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: revert "Add autodump debugfs node for gpu
 reset v8"
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
To: alexander.deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org, Jiange.Zhao@amd.com
References: <20210930092611.13615-1-christian.koenig@amd.com>
Message-ID: <ad72c18d-d0a6-51bb-540f-dde0688dc567@gmail.com>
Date: Mon, 4 Oct 2021 10:31:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210930092611.13615-1-christian.koenig@amd.com>
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

Ping? Alex any objections to this?

Otherwise I'm going to push it with Nirmoy's acked-by.

Christian.

Am 30.09.21 um 11:26 schrieb Christian König:
> This reverts commit 728e7e0cd61899208e924472b9e641dbeb0775c4.
>
> Further discussion reveals that this feature is severely broken
> and needs to be reverted ASAP.
>
> GPU reset can never be delayed by userspace even for debugging or
> otherwise we can run into in kernel deadlocks.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  2 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 80 ---------------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  5 --
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  4 --
>   4 files changed, 91 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index dc3c6b3a00e5..6a1928a720a6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1078,8 +1078,6 @@ struct amdgpu_device {
>   	char				product_name[32];
>   	char				serial[20];
>   
> -	struct amdgpu_autodump		autodump;
> -
>   	atomic_t			throttling_logging_enabled;
>   	struct ratelimit_state		throttling_logging_rs;
>   	uint32_t                        ras_hw_enabled;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 277128846dd1..0b89ba142a59 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -27,7 +27,6 @@
>   #include <linux/pci.h>
>   #include <linux/uaccess.h>
>   #include <linux/pm_runtime.h>
> -#include <linux/poll.h>
>   
>   #include "amdgpu.h"
>   #include "amdgpu_pm.h"
> @@ -37,85 +36,7 @@
>   #include "amdgpu_securedisplay.h"
>   #include "amdgpu_fw_attestation.h"
>   
> -int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev)
> -{
>   #if defined(CONFIG_DEBUG_FS)
> -	unsigned long timeout = 600 * HZ;
> -	int ret;
> -
> -	wake_up_interruptible(&adev->autodump.gpu_hang);
> -
> -	ret = wait_for_completion_interruptible_timeout(&adev->autodump.dumping, timeout);
> -	if (ret == 0) {
> -		pr_err("autodump: timeout, move on to gpu recovery\n");
> -		return -ETIMEDOUT;
> -	}
> -#endif
> -	return 0;
> -}
> -
> -#if defined(CONFIG_DEBUG_FS)
> -
> -static int amdgpu_debugfs_autodump_open(struct inode *inode, struct file *file)
> -{
> -	struct amdgpu_device *adev = inode->i_private;
> -	int ret;
> -
> -	file->private_data = adev;
> -
> -	ret = down_read_killable(&adev->reset_sem);
> -	if (ret)
> -		return ret;
> -
> -	if (adev->autodump.dumping.done) {
> -		reinit_completion(&adev->autodump.dumping);
> -		ret = 0;
> -	} else {
> -		ret = -EBUSY;
> -	}
> -
> -	up_read(&adev->reset_sem);
> -
> -	return ret;
> -}
> -
> -static int amdgpu_debugfs_autodump_release(struct inode *inode, struct file *file)
> -{
> -	struct amdgpu_device *adev = file->private_data;
> -
> -	complete_all(&adev->autodump.dumping);
> -	return 0;
> -}
> -
> -static unsigned int amdgpu_debugfs_autodump_poll(struct file *file, struct poll_table_struct *poll_table)
> -{
> -	struct amdgpu_device *adev = file->private_data;
> -
> -	poll_wait(file, &adev->autodump.gpu_hang, poll_table);
> -
> -	if (amdgpu_in_reset(adev))
> -		return POLLIN | POLLRDNORM | POLLWRNORM;
> -
> -	return 0;
> -}
> -
> -static const struct file_operations autodump_debug_fops = {
> -	.owner = THIS_MODULE,
> -	.open = amdgpu_debugfs_autodump_open,
> -	.poll = amdgpu_debugfs_autodump_poll,
> -	.release = amdgpu_debugfs_autodump_release,
> -};
> -
> -static void amdgpu_debugfs_autodump_init(struct amdgpu_device *adev)
> -{
> -	init_completion(&adev->autodump.dumping);
> -	complete_all(&adev->autodump.dumping);
> -	init_waitqueue_head(&adev->autodump.gpu_hang);
> -
> -	debugfs_create_file("amdgpu_autodump", 0600,
> -		adev_to_drm(adev)->primary->debugfs_root,
> -		adev, &autodump_debug_fops);
> -}
>   
>   /**
>    * amdgpu_debugfs_process_reg_op - Handle MMIO register reads/writes
> @@ -1590,7 +1511,6 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   	}
>   
>   	amdgpu_ras_debugfs_create_all(adev);
> -	amdgpu_debugfs_autodump_init(adev);
>   	amdgpu_rap_debugfs_init(adev);
>   	amdgpu_securedisplay_debugfs_init(adev);
>   	amdgpu_fw_attestation_debugfs_init(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> index 141a8474e24f..8b641f40fdf6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> @@ -26,10 +26,6 @@
>   /*
>    * Debugfs
>    */
> -struct amdgpu_autodump {
> -	struct completion		dumping;
> -	struct wait_queue_head		gpu_hang;
> -};
>   
>   int amdgpu_debugfs_regs_init(struct amdgpu_device *adev);
>   int amdgpu_debugfs_init(struct amdgpu_device *adev);
> @@ -37,4 +33,3 @@ void amdgpu_debugfs_fini(struct amdgpu_device *adev);
>   void amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
>   void amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
>   void amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
> -int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 41c6b3aacd37..4d34b2da8582 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4458,10 +4458,6 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>   	if (reset_context->reset_req_dev == adev)
>   		job = reset_context->job;
>   
> -	/* no need to dump if device is not in good state during probe period */
> -	if (!adev->gmc.xgmi.pending_reset)
> -		amdgpu_debugfs_wait_dump(adev);
> -
>   	if (amdgpu_sriov_vf(adev)) {
>   		/* stop the data exchange thread */
>   		amdgpu_virt_fini_data_exchange(adev);

