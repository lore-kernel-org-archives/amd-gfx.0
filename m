Return-Path: <SRS0=u08i=64=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BFBC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 14 May 2020 07:01:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3775206BE
	for <amd-gfx@archiver.kernel.org>; Thu, 14 May 2020 07:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LeFguYIF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3775206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79DBE6EAB4;
	Thu, 14 May 2020 07:01:56 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7AD56EAB4
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 May 2020 07:01:54 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id l11so2453162wru.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 May 2020 00:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=e4/U5+5LYj9oktKAefRoYAS8JB5+4OfTNjIkAqPw5EM=;
 b=LeFguYIF3UeEf1V7eZ3uQdIBPbpFFNqlNWOKi5AD8WVVQEQF+iMOdo58whTQetwmnq
 DoGr2yXPeiIHD3hsexNU7BmDpcFszE0IT0VKU3bjZFM155H49cJU5HI41SctRv6nF7ei
 Z9/bBXwE0KiMrsgy7s8q0VyGUk8dRTG3wMJopVTqYhi7/KJ0tgVW7IQUA+tuSgyAefAC
 L9FLtWzlgDQYXR3b45wlvJXetnV/h0uBKSkv1Eu1NVJ3okVg2aBZ9RwFGX1j9QvuclJC
 TKWPwGeN8IEeDWGUatxX1JSH1mAYmEX2zAHu5ZhT9Lv6OjKwGXQtfNtVPiYpXnK3DnFO
 kzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=e4/U5+5LYj9oktKAefRoYAS8JB5+4OfTNjIkAqPw5EM=;
 b=NgBUbtz4yU2Kg57g6UGoqQ30aZpEJRZGa+nYLYXPyDgJtjEp6tTFTZpXZpMd1ol00f
 yAuTWEq/RJuEWvpliduQAwGoswazcRf/mzVZlBK6gayulRmikWTjcioxkeVGV9r3nlSb
 mBxD5NR++gu1kQlvQiZzXsmRqnhKzRkm3NlUKSCGIZh7ZE7ebsb7v0YkpkTDe/b2x5we
 6MI+WR6gri/ylGgxgNMbd6TSGrqKRHcSYORGcO4d0JOmo0kgxS6o+HTRn/DxQDhHgNj9
 UwzYKd6rMTFfALXfaG8fyDdZx+FG6SAxytFCDOL4iJBUUCYza6DfUa4nh9L6dIrwCmwp
 l/oQ==
X-Gm-Message-State: AOAM533HmdHYsDanZeFm5O6SLwRz4SALLzFXFAhFet7LUCEGyaiWlZ64
 HgjbW4duvX9jbConyYR2zAUAzSDd
X-Google-Smtp-Source: ABdhPJza/duuP9k78TKnXzMcuk3NqZeoJsXdJgkgjn+71lF80GBLf9krSk/12+FrpkDqxN0lVS0ktg==
X-Received: by 2002:adf:e988:: with SMTP id h8mr3618025wrm.365.1589439713313; 
 Thu, 14 May 2020 00:01:53 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id 60sm2675979wrp.92.2020.05.14.00.01.51
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 May 2020 00:01:52 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset v4
To: jianzh@amd.com, amd-gfx@lists.freedesktop.org
References: <20200514052952.19260-1-jianzh@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <993d856e-1084-92c7-e43e-d9276acfad92@gmail.com>
Date: Thu, 14 May 2020 09:01:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200514052952.19260-1-jianzh@amd.com>
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
Cc: Pierre-eric.Pelloux-prayer@amd.com, Jiange Zhao <Jiange.Zhao@amd.com>,
 Felix.Kuehling@amd.com, Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
 Monk.Liu@amd.com, Hawking.Zhang@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 14.05.20 um 07:29 schrieb jianzh@amd.com:
> From: Jiange Zhao <Jiange.Zhao@amd.com>
>
> When GPU got timeout, it would notify an interested part
> of an opportunity to dump info before actual GPU reset.
>
> A usermode app would open 'autodump' node under debugfs system
> and poll() for readable/writable. When a GPU reset is due,
> amdgpu would notify usermode app through wait_queue_head and give
> it 10 minutes to dump info.
>
> After usermode app has done its work, this 'autodump' node is closed.
> On node closure, amdgpu gets to know the dump is done through
> the completion that is triggered in release().
>
> There is no write or read callback because necessary info can be
> obtained through dmesg and umr. Messages back and forth between
> usermode app and amdgpu are unnecessary.
>
> v2: (1) changed 'registered' to 'app_listening'
>      (2) add a mutex in open() to prevent race condition
>
> v3 (chk): grab the reset lock to avoid race in autodump_open,
>            rename debugfs file to amdgpu_autodump,
>            provide autodump_read as well,
>            style and code cleanups
>
> v4: add 'bool app_listening' to differentiate situations, so that
>      the node can be reopened; also, there is no need to wait for
>      completion when no app is waiting for a dump.
>
> v5: change 'bool app_listening' to 'enum amdgpu_autodump_state'
>      add 'app_state_mutex' for race conditions:
> 	(1)Only 1 user can open this file node
> 	(2)wait_dump() can only take effect after poll() executed.
> 	(3)eliminated the race condition between release() and
> 	   wait_dump()
>
> v6: removed 'enum amdgpu_autodump_state' and 'app_state_mutex'
>      removed state checking in amdgpu_debugfs_wait_dump
>      Improve on top of version 3 so that the node can be reopened.
>
> v7: move reinit_completion into open() so that only one user
>      can open it.
>
> Signed-off-by: Jiange Zhao <Jiange.Zhao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 79 ++++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  6 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  2 +
>   4 files changed, 88 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 2a806cb55b78..9e8eeddfe7ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -992,6 +992,8 @@ struct amdgpu_device {
>   	char				product_number[16];
>   	char				product_name[32];
>   	char				serial[16];
> +
> +	struct amdgpu_autodump		autodump;
>   };
>   
>   static inline struct amdgpu_device *amdgpu_ttm_adev(struct ttm_bo_device *bdev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 1a4894fa3693..efee3f1adecf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -27,7 +27,7 @@
>   #include <linux/pci.h>
>   #include <linux/uaccess.h>
>   #include <linux/pm_runtime.h>
> -
> +#include <linux/poll.h>
>   #include <drm/drm_debugfs.h>
>   
>   #include "amdgpu.h"
> @@ -74,8 +74,83 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> +int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev)
> +{
> +#if defined(CONFIG_DEBUG_FS)
> +	unsigned long timeout = 600 * HZ;
> +	int ret;
> +
> +	wake_up_interruptible(&adev->autodump.gpu_hang);
> +
> +	ret = wait_for_completion_interruptible_timeout(&adev->autodump.dumping, timeout);
> +	complete_all(&adev->autodump.dumping);

Sorry that I'm mentioning this only now. But what is this complete_all() 
here good for?

I mean we already waited for completion, didn't we?

Christian.

> +	if (ret == 0) {
> +		pr_err("autodump: timeout, move on to gpu recovery\n");
> +		return -ETIMEDOUT;
> +	}
> +#endif
> +	return 0;
> +}
> +
>   #if defined(CONFIG_DEBUG_FS)
>   
> +static int amdgpu_debugfs_autodump_open(struct inode *inode, struct file *file)
> +{
> +	struct amdgpu_device *adev = inode->i_private;
> +	int ret;
> +
> +	file->private_data = adev;
> +
> +	mutex_lock(&adev->lock_reset);
> +	if (adev->autodump.dumping.done) {
> +		reinit_completion(&adev->autodump.dumping);
> +		ret = 0;
> +	} else {
> +		ret = -EBUSY;
> +	}
> +	mutex_unlock(&adev->lock_reset);
> +
> +	return ret;
> +}
> +
> +static int amdgpu_debugfs_autodump_release(struct inode *inode, struct file *file)
> +{
> +	struct amdgpu_device *adev = file->private_data;
> +
> +	complete_all(&adev->autodump.dumping);
> +	return 0;
> +}
> +
> +static unsigned int amdgpu_debugfs_autodump_poll(struct file *file, struct poll_table_struct *poll_table)
> +{
> +	struct amdgpu_device *adev = file->private_data;
> +
> +	poll_wait(file, &adev->autodump.gpu_hang, poll_table);
> +
> +	if (adev->in_gpu_reset)
> +		return POLLIN | POLLRDNORM | POLLWRNORM;
> +
> +	return 0;
> +}
> +
> +static const struct file_operations autodump_debug_fops = {
> +	.owner = THIS_MODULE,
> +	.open = amdgpu_debugfs_autodump_open,
> +	.poll = amdgpu_debugfs_autodump_poll,
> +	.release = amdgpu_debugfs_autodump_release,
> +};
> +
> +static void amdgpu_debugfs_autodump_init(struct amdgpu_device *adev)
> +{
> +	init_completion(&adev->autodump.dumping);
> +	complete_all(&adev->autodump.dumping);
> +	init_waitqueue_head(&adev->autodump.gpu_hang);
> +
> +	debugfs_create_file("amdgpu_autodump", 0600,
> +		adev->ddev->primary->debugfs_root,
> +		adev, &autodump_debug_fops);
> +}
> +
>   /**
>    * amdgpu_debugfs_process_reg_op - Handle MMIO register reads/writes
>    *
> @@ -1434,6 +1509,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   
>   	amdgpu_ras_debugfs_create_all(adev);
>   
> +	amdgpu_debugfs_autodump_init(adev);
> +
>   	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_list,
>   					ARRAY_SIZE(amdgpu_debugfs_list));
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> index de12d1101526..2803884d338d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> @@ -31,6 +31,11 @@ struct amdgpu_debugfs {
>   	unsigned		num_files;
>   };
>   
> +struct amdgpu_autodump {
> +	struct completion		dumping;
> +	struct wait_queue_head		gpu_hang;
> +};
> +
>   int amdgpu_debugfs_regs_init(struct amdgpu_device *adev);
>   int amdgpu_debugfs_init(struct amdgpu_device *adev);
>   void amdgpu_debugfs_fini(struct amdgpu_device *adev);
> @@ -40,3 +45,4 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *adev,
>   int amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
>   int amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
>   int amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
> +int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index cc41e8f5ad14..545beebcf43e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3927,6 +3927,8 @@ static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>   	int i, r = 0;
>   	bool need_full_reset  = *need_full_reset_arg;
>   
> +	amdgpu_debugfs_wait_dump(adev);
> +
>   	/* block all schedulers and reset given job's ring */
>   	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>   		struct amdgpu_ring *ring = adev->rings[i];

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
