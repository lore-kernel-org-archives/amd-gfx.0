Return-Path: <SRS0=jMTE=63=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A832CA90AF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2020 08:19:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A943205C9
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2020 08:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ech5eifL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A943205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C7906E9AC;
	Wed, 13 May 2020 08:19:55 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D25E96E9AC
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2020 08:19:54 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id y16so12528584wrs.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2020 01:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=yRU9gXK2DC0gscMFaCmBPdDoZ5sN5N1GQmvpiD8EV3A=;
 b=ech5eifLkc++QVbGmlh0zc1XqtxD9ekdbHSg7IIR35EHz0udhZ2onFfMiTA6JOtOIl
 NjkeIqNFQ7+2xHK4ZAuwYCmffBN0/lUq2dvuz6mEbqYIeFigsPrRTTtavWp2fNm3+RBw
 MIAARNBcpgpDsBEXo9kUma3jPysneIAx9lNgROlK9EPphE6PFpfSePTjhW4h3uFbtnoS
 nsd+HHNqC4SqzwuWDPQt9Qxes/OoU7JSJCoVZq9X+MQzcf26rVYRiquopb0C0LABJK20
 9k8HzB5/3aXtsgtPqkI5GYp5gR7EPTaGUQumRTe2wuXLdKRbRd+QDcvO/XAB49mdgupB
 FjVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=yRU9gXK2DC0gscMFaCmBPdDoZ5sN5N1GQmvpiD8EV3A=;
 b=lyUL+XM0HV09PbKjOidYbHKHj+QRVqCfHiPAvTMnPUXsF1D27Bm1ausVyZ7YBrPTt4
 pUrMj/kb5nIYRPj02BBdnu6Byitx/PYeNgpA4B6PlJRT55zsxqI9IU+v2SvQKfjL5u+E
 KazYS6T0Il+yfvoFOoplQSP4jhHCfNJl8MZC23Hgr6BmL4S4JTDss9sfhEZRSawMo79N
 jlwh26+QApdgfVA5PFbuOm8EdhgBoKJQ5DlJTznTCU0uGDIGs2oLV03hR+W6cwqAQmIp
 mGxlobQEn22S7j9JKGc7p2QZxabZ6pOR8p5NHmbqnxYlj3erWHcJ3vS60MxnKYnD+DiQ
 9hWA==
X-Gm-Message-State: AGi0PuaD/R18b8pVVk2+27ifaJyPRm54GFBKD+wL2cth4PcpVeYo8V8c
 1y3zT5ZN1eO2s+ks0XcGVf4=
X-Google-Smtp-Source: APiQypK4OYMXdRtSZc7dL6A2sYtDuX//5g1LJWYiL9D0X1zIY6TER0p93Ijqn8UCoN9YQK+mQEF/EA==
X-Received: by 2002:adf:9444:: with SMTP id 62mr30001496wrq.68.1589357993509; 
 Wed, 13 May 2020 01:19:53 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id p10sm1681419wra.78.2020.05.13.01.19.52
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 May 2020 01:19:53 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset v4
To: jianzh@amd.com, amd-gfx@lists.freedesktop.org
References: <20200509094508.28909-1-jianzh@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <9595e459-500a-40f5-e128-079605f9a284@gmail.com>
Date: Wed, 13 May 2020 10:19:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200509094508.28909-1-jianzh@amd.com>
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
Cc: alexander.deucher@amd.com, pierre-eric.pelloux-prayer@amd.com,
 Jiange Zhao <Jiange.Zhao@amd.com>, christian.koenig@amd.com, monk.liu@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 09.05.20 um 11:45 schrieb jianzh@amd.com:
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
> Signed-off-by: Jiange Zhao <Jiange.Zhao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 78 ++++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  6 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  2 +
>   4 files changed, 87 insertions(+), 1 deletion(-)
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
> index 1a4894fa3693..261b67ece7fb 100644
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
> @@ -74,8 +74,82 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *adev,
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
> +	if (adev->autodump.dumping.done)
> +		ret = 0;
> +	else
> +		ret = -EBUSY;
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
> +	reinit_completion(&adev->autodump.dumping);

Why do you have the reinit_completion here and not in open callback?

Apart from that looks good to me.

Regards,
Christian.

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
> @@ -1434,6 +1508,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
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
