Return-Path: <SRS0=W/Sk=6I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E09C55186
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 08:58:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F22B20736
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 08:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlMuUy5e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F22B20736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B52536E448;
	Fri, 24 Apr 2020 08:58:05 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 991B96E448
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2020 08:58:03 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id j2so9802302wrs.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2020 01:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=HLZHWIHuTjOD20IpMGAzWlIlM6B3C5WxmXNAVDSLg1U=;
 b=UlMuUy5eHHrdEHiE+aFERBzlAlKo/lALcgxUcDvF53qBsiAmN98X+0bRVzpzXvhaRy
 yahhIEKTu/9nK6Wdw7PTQqi8ZA9dvQWP8UnYEQp+LS+UT1ZKP7HuLo+0Sb5fLQbHhne4
 BIbJO1nj/A+p/Wfz1pLc9wy9mxd+k4fAiHSzxYaB5Q/Ei06mOKjDLygnRkXz+70O6lW0
 FM/Om+QQDguTgZIaEkeaTqwGPRgHv3FF5Aqdhcs8tVNLUxNAlIcgY6Myg5KWsE8qjH9q
 x2zRSo2b6Pp3+DXH40QQc7f522T9VPBwhSJUsCFN+gtcpkaC6GdEc+jI9wx7UMOd/Alm
 79pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=HLZHWIHuTjOD20IpMGAzWlIlM6B3C5WxmXNAVDSLg1U=;
 b=X8poq8MLAV1JzmKAThpwBSr0+MsO/mUekydtID6mvULz7/HHTILwJrWqZd89fFSHFe
 6GrYDcci79A1oLEvnW0GMxh7ZIyQZkpHVTxcJO4Jbt5qn+hsdbV/RdmM2wdBCZDKW9NF
 AYKltBoeRfHdb36ZrbC/vsmGiCEG1VqMA8ts+Pmt791YTkAEAOgcS3NPDwQTCR1gVCNL
 y/YIQ7CrpbYTiq34SxjH96V8PMj26VF5XceyqDBAA8NwQ3r2gOJTjQ/o4N7NNSPvGwV2
 wFd+iUn9pga0w4x+R+qz/jld1EIVIuapJHNMMR381L6Arge5jW/E1W2JtUzeMET7CDnQ
 5qGQ==
X-Gm-Message-State: AGi0PuaKZiFB9MZt97BPTp40w3fxrS4TeTxp5GEFaSNjyoN5UFaOOPw6
 pmoUVaF5Kb4StDEthfP3+hmPtJK3
X-Google-Smtp-Source: APiQypK3p3UGaaxE/SSYSs2ZaRg6QFfPVlClMg1qYtZmj6UoLJrah71HqsKh2nw/M8pBt+EbEUd94A==
X-Received: by 2002:a5d:4e12:: with SMTP id p18mr10051683wrt.148.1587718682149; 
 Fri, 24 Apr 2020 01:58:02 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id y10sm1953630wma.5.2020.04.24.01.58.01
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 24 Apr 2020 01:58:01 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset (v2)
To: jianzh@amd.com, amd-gfx@lists.freedesktop.org
References: <20200424084943.27169-1-jianzh@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <083a34ce-9aeb-abf9-8777-92023c188348@gmail.com>
Date: Fri, 24 Apr 2020 10:58:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200424084943.27169-1-jianzh@amd.com>
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

Am 24.04.20 um 10:49 schrieb jianzh@amd.com:
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

May I pick this one up and modify it a bit?

There is still a race which needs to be fixed and it is a bit hard to 
explain what's going wrong here.

Christian.

>
> Signed-off-by: Jiange Zhao <Jiange.Zhao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         | 10 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 92 ++++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  2 +
>   4 files changed, 104 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index bc1e0fd71a09..34b8ce9fba47 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -724,6 +724,14 @@ struct amd_powerplay {
>   	const struct amd_pm_funcs *pp_funcs;
>   };
>   
> +struct amdgpu_autodump {
> +	bool				app_listening;
> +	struct completion		completed;
> +	struct dentry			*dentry;
> +	struct wait_queue_head		gpu_hang_wait;
> +	struct mutex			mutex;
> +};
> +
>   #define AMDGPU_RESET_MAGIC_NUM 64
>   #define AMDGPU_MAX_DF_PERFMONS 4
>   struct amdgpu_device {
> @@ -990,6 +998,8 @@ struct amdgpu_device {
>   	char				product_number[16];
>   	char				product_name[32];
>   	char				serial[16];
> +
> +	struct amdgpu_autodump		autodump;
>   };
>   
>   static inline struct amdgpu_device *amdgpu_ttm_adev(struct ttm_bo_device *bdev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 1a4894fa3693..693bfcaad312 100644
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
> @@ -74,8 +74,96 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> +int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev)
> +{
> +#if defined(CONFIG_DEBUG_FS)
> +	unsigned long tmo = 600*HZ;
> +	int ret;
> +
> +	if (!adev->autodump.app_listening)
> +		return 0;
> +
> +	wake_up_interruptible(&adev->autodump.gpu_hang_wait);
> +
> +	ret = wait_for_completion_interruptible_timeout(&adev->autodump.completed, tmo);
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
> +	int ret = 0;
> +	struct amdgpu_device *adev;
> +
> +	ret = simple_open(inode, file);
> +	if (ret)
> +		return ret;
> +
> +	adev = file->private_data;
> +
> +	mutex_lock(&adev->autodump.mutex);
> +	if (adev->autodump.app_listening == true) {
> +		ret = -EBUSY;
> +	} else {
> +		adev->autodump.app_listening = true;
> +	}
> +	mutex_unlock(&adev->autodump.mutex);
> +
> +	return ret;
> +}
> +
> +static int amdgpu_debugfs_autodump_release(struct inode *inode, struct file *file)
> +{
> +	struct amdgpu_device *adev = file->private_data;
> +
> +	complete(&adev->autodump.completed);
> +	adev->autodump.app_listening = false;
> +
> +	return 0;
> +}
> +
> +unsigned int amdgpu_debugfs_autodump_poll(struct file *file, struct poll_table_struct *poll_table)
> +{
> +	struct amdgpu_device *adev = file->private_data;
> +
> +	poll_wait(file, &adev->autodump.gpu_hang_wait, poll_table);
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
> +static int amdgpu_debugfs_autodump_init(struct amdgpu_device *adev)
> +{
> +	struct dentry *entry;
> +
> +	init_completion(&adev->autodump.completed);
> +	init_waitqueue_head(&adev->autodump.gpu_hang_wait);
> +	mutex_init(&adev->autodump.mutex);
> +	adev->autodump.app_listening = false;
> +
> +	entry = debugfs_create_file("autodump", 0600,
> +			adev->ddev->primary->debugfs_root,
> +			adev, &autodump_debug_fops);
> +	adev->autodump.dentry = entry;
> +
> +	return 0;
> +}
> +
>   /**
>    * amdgpu_debugfs_process_reg_op - Handle MMIO register reads/writes
>    *
> @@ -1434,6 +1522,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   
>   	amdgpu_ras_debugfs_create_all(adev);
>   
> +	amdgpu_debugfs_autodump_init(adev);
> +
>   	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_list,
>   					ARRAY_SIZE(amdgpu_debugfs_list));
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> index de12d1101526..9428940a696d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> @@ -40,3 +40,4 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *adev,
>   int amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
>   int amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
>   int amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
> +int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 3d601d5dd5af..44e54ea7af0f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3915,6 +3915,8 @@ static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
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
