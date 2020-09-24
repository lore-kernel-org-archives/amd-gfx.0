Return-Path: <SRS0=YZDW=DB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269E3C4363D
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2020 10:29:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC41623600
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2020 10:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+zIPX5l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC41623600
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54CC56E1D6;
	Thu, 24 Sep 2020 10:29:00 +0000 (UTC)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com
 [IPv6:2a00:1450:4864:20::642])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 356A96E1D6
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2020 10:28:59 +0000 (UTC)
Received: by mail-ej1-x642.google.com with SMTP id r7so3697220ejs.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2020 03:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=VGA/TsNUJWF1UD5H5RtHFb4fFNf1OhYKBnprGaEA6Qw=;
 b=k+zIPX5l/NJ4+MPrE+bnNkcKJ0GKMZSqjp/XPf43PoTs8vAOg8fJe5qs5xKtB6tfkI
 yfEqA8/jhZQCB8J+N3mJy98DNv8MSWVwatPCgcFXrgiGALse9/XzpCgNI1QCm4zge5O3
 Den6ifdcU8HPv7yIQ5OaW/2xYIGiaEzZEVGXsAdu0JoudLo66VNrD44hGBHBR80p+273
 6kmyG40cpV43hNUTMp0PZ9eqAxeb0l0UnnU6tZleXcjwXHqvqZp/98czVsj2k82kA0Rv
 bZdxTupYs0X3j31FT849O4O3m27ba8Ioq8pilsHh1i2lgZ0YoGIi5D2W0F6uQ5M1n6AE
 AcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=VGA/TsNUJWF1UD5H5RtHFb4fFNf1OhYKBnprGaEA6Qw=;
 b=E9pcSzMnov0PQ8UEmQZWndpYcApy+NEtcYq/yzhzmDxdD4rsKv4bvSDJvchZFk64bm
 bqKAsS72AM6Oh50AnmpNZtF6uhXSXoKVXbzzVPG3xxUnsw9Ek5HtZplePja7UfmlF0Lw
 BuHtAZo2zqgyweM2t29YqIfgDdZbq/fs9kO/uRD7pAwK5KFat2NnKp7n7gTNGRCwEjvv
 Bpr6oJJ9wAxujYwyThKeFcsPuLup7qGq1HPpiuwzbmS7shgsOVR4axyHTWiZtKXx0otj
 kXy+eXgDxoEHn8nGfwL1DdH+2nsYCl1eEcCpbtomKQ1Af7a+rCLETIs4hP2jvsXNk6/o
 9DDg==
X-Gm-Message-State: AOAM531JGuZzLga/E1hH8ycutvxek3+t18scAyPi1ApX+PB9c0MoKzLS
 kjPiWq1YY4aRKGVn9RL0l8sxmuFT00s=
X-Google-Smtp-Source: ABdhPJyATKllBpdB3UNG71kzKBTlhgk723fBTT9naOFMTWAHvBhEZWyU5PK6H28xDnIZkeBHg0rmwQ==
X-Received: by 2002:a17:906:b352:: with SMTP id
 cd18mr231930ejb.229.1600943337788; 
 Thu, 24 Sep 2020 03:28:57 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id l26sm2058141ejr.78.2020.09.24.03.28.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2020 03:28:57 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: fix ras calltrace problem by
 sysfs_update_group
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, Tao.Zhou1@amd.com,
 John.Clements@amd.com, alexander.deucher@amd.com, lijo.lazar@amd.com
References: <20200924102155.27046-1-guchun.chen@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <478404e5-7df0-b376-3621-abcd9574b3c9@gmail.com>
Date: Thu, 24 Sep 2020 12:28:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200924102155.27046-1-guchun.chen@amd.com>
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

Am 24.09.20 um 12:21 schrieb Guchun Chen:
> Sysfs_update_group brings below calltrace problem with kernel 3.10
> on RHEL7.9. The cause is the bug of sysfs_update_group on kernel 3.10,
> which always fail on one named group, as next calling internal_create_group
> will try to create one new sysfs dir unconditionally, so system
> complains one duplicate creation.

NAK, we should not have workarounds for older kernels in the upstream 
code base. You somehow need to handle this in the DKMS package.

Or is that also valid as a stand alone cleanup?

Regards,
Christian.

>
> The patch is to merge the sysfs setup together by calling sysfs_create_group
> once, though the nodes would vary on top of different configurations.
>
> [    6.531591] WARNING: CPU: 52 PID: 638 at fs/sysfs/dir.c:31 sysfs_warn_dup+0x64/0x80
> [    6.531592] sysfs: cannot create duplicate filename '/devices/pci0000:20/0000:20:03.1/0000:21:00.0/0000:22:00.0/0000:23:00.0/ras'
> [    6.531593] Modules linked in: amdgpu(OE+) amd_iommu_v2 amd_sched(OE) amdttm(OE) amdkcl(OE) drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ahci drm libahci igb libata crct10dif_pclmul crct10dif_common crc32c_intel ptp nvme atlantic pps_core dca drm_panel_orientation_quirks nvme_core i2c_algo_bit sdhci_acpi iosf_mbi sdhci mmc_core dm_mirror dm_region_hash dm_log dm_mod fuse
> [    6.531606] CPU: 52 PID: 638 Comm: systemd-udevd Tainted: G           OE  ------------   3.10.0-1152.el7.x86_64 #1
> [    6.531609] Hardware name: Gigabyte Technology Co., Ltd. TRX40 AORUS MASTER/TRX40 AORUS MASTER, BIOS F5c 03/05/2020
> [    6.531610] Call Trace:
> [    6.531615]  [<ffffffff9b18133a>] dump_stack+0x19/0x1b
> [    6.531618]  [<ffffffff9aa9b228>] __warn+0xd8/0x100
> [    6.531619]  [<ffffffff9aa9b2af>] warn_slowpath_fmt+0x5f/0x80
> [    6.531621]  [<ffffffff9acd8e48>] ? kernfs_path+0x48/0x60
> [    6.531622]  [<ffffffff9acdbb54>] sysfs_warn_dup+0x64/0x80
> [    6.531624]  [<ffffffff9acdc6ba>] internal_create_group+0x23a/0x250
> [    6.531625]  [<ffffffff9acdc706>] sysfs_update_group+0x16/0x20
> [    6.531660]  [<ffffffffc067fb67>] amdgpu_ras_init+0x1e7/0x240 [amdgpu]
>     6.531691]  [<ffffffffc063dc7c>] amdgpu_device_init+0xf9c/0x1cb0 [amdgpu]
> [    6.531694]  [<ffffffff9abe5608>] ? kmalloc_order+0x18/0x40
> [    6.531698]  [<ffffffff9ac24326>] ? kmalloc_order_trace+0x26/0xa0
> [    6.531726]  [<ffffffffc0642b1a>] amdgpu_driver_load_kms+0x5a/0x330 [amdgpu]
> [    6.531753]  [<ffffffffc063a832>] amdgpu_pci_probe+0x172/0x280 [amdgpu]
> [    6.531757]  [<ffffffff9add653a>] local_pci_probe+0x4a/0xb0
> [    6.531760]  [<ffffffff9add7c89>] pci_device_probe+0x109/0x160
> [    6.531762]  [<ffffffff9aebb0e5>] driver_probe_device+0xc5/0x3e0
> [    6.531764]  [<ffffffff9aebb4e3>] __driver_attach+0x93/0xa0
> [    6.531765]  [<ffffffff9aebb450>] ? __device_attach+0x50/0x50
> [    6.531766]  [<ffffffff9aeb8c85>] bus_for_each_dev+0x75/0xc0
> [    6.531767]  [<ffffffff9aebaa5e>] driver_attach+0x1e/0x20
> [    6.531769]  [<ffffffff9aeba500>] bus_add_driver+0x200/0x2d0
> [    6.531770]  [<ffffffff9aebbb74>] driver_register+0x64/0xf0
> [    6.531771]  [<ffffffff9add74c5>] __pci_register_driver+0xa5/0xc0
> [    6.531774]  [<ffffffffc0bd5000>] ? 0xffffffffc0bd4fff
> [    6.531806]  [<ffffffffc0bd50a4>] amdgpu_init+0xa4/0xb0 [amdgpu]
> [    6.531809]  [<ffffffff9aa0210a>] do_one_initcall+0xba/0x240
> [    6.531812]  [<ffffffff9ab1e45a>] load_module+0x271a/0x2bb0
> [    6.531815]  [<ffffffff9adb41c0>] ? ddebug_proc_write+0x100/0x100
> [    6.531817]  [<ffffffff9ab1e9df>] SyS_init_module+0xef/0x140
> [    6.531821]  [<ffffffff9b193f92>] system_call_fastpath+0x25/0x2a
> [    6.531822] ---[ end trace e2d035c822a91de6 ]---
>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 87 +++++++++----------------
>   1 file changed, 31 insertions(+), 56 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index e5ea14774c0c..6c57521b21fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1027,58 +1027,6 @@ static ssize_t amdgpu_ras_sysfs_features_read(struct device *dev,
>   	return scnprintf(buf, PAGE_SIZE, "feature mask: 0x%x\n", con->features);
>   }
>   
> -static void amdgpu_ras_sysfs_add_bad_page_node(struct amdgpu_device *adev)
> -{
> -	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
> -	struct attribute_group group;
> -	struct bin_attribute *bin_attrs[] = {
> -		&con->badpages_attr,
> -		NULL,
> -	};
> -
> -	con->badpages_attr = (struct bin_attribute) {
> -		.attr = {
> -			.name = "gpu_vram_bad_pages",
> -			.mode = S_IRUGO,
> -		},
> -		.size = 0,
> -		.private = NULL,
> -		.read = amdgpu_ras_sysfs_badpages_read,
> -	};
> -
> -	group.name = RAS_FS_NAME;
> -	group.bin_attrs = bin_attrs;
> -
> -	sysfs_bin_attr_init(bin_attrs[0]);
> -
> -	sysfs_update_group(&adev->dev->kobj, &group);
> -}
> -
> -static int amdgpu_ras_sysfs_create_feature_node(struct amdgpu_device *adev)
> -{
> -	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
> -	struct attribute *attrs[] = {
> -		&con->features_attr.attr,
> -		NULL
> -	};
> -	struct attribute_group group = {
> -		.name = RAS_FS_NAME,
> -		.attrs = attrs,
> -	};
> -
> -	con->features_attr = (struct device_attribute) {
> -		.attr = {
> -			.name = "features",
> -			.mode = S_IRUGO,
> -		},
> -			.show = amdgpu_ras_sysfs_features_read,
> -	};
> -
> -	sysfs_attr_init(attrs[0]);
> -
> -	return sysfs_create_group(&adev->dev->kobj, &group);
> -}
> -
>   static void amdgpu_ras_sysfs_remove_bad_page_node(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
> @@ -1300,13 +1248,40 @@ static void amdgpu_ras_debugfs_remove_all(struct amdgpu_device *adev)
>   /* debugfs end */
>   
>   /* ras fs */
> -
> +static BIN_ATTR(gpu_vram_bad_pages, S_IRUGO,
> +		amdgpu_ras_sysfs_badpages_read, NULL, 0);
> +static DEVICE_ATTR(features, S_IRUGO,
> +		amdgpu_ras_sysfs_features_read, NULL);
>   static int amdgpu_ras_fs_init(struct amdgpu_device *adev)
>   {
> -	amdgpu_ras_sysfs_create_feature_node(adev);
> +	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
> +	struct attribute_group group = {
> +		.name = RAS_FS_NAME,
> +	};
> +	struct attribute *attrs[] = {
> +		&con->features_attr.attr,
> +		NULL
> +	};
> +	struct bin_attribute *bin_attrs[] = {
> +		NULL,
> +		NULL,
> +	};
>   
> -	if (amdgpu_bad_page_threshold != 0)
> -		amdgpu_ras_sysfs_add_bad_page_node(adev);
> +	/* add features entry */
> +	con->features_attr = dev_attr_features;
> +	group.attrs = attrs;
> +	sysfs_attr_init(attrs[0]);
> +
> +	if (amdgpu_bad_page_threshold != 0) {
> +		/* add bad_page_features entry */
> +		bin_attr_gpu_vram_bad_pages.private = NULL;
> +		con->badpages_attr = bin_attr_gpu_vram_bad_pages;
> +		bin_attrs[0] = &con->badpages_attr;
> +		group.bin_attrs = bin_attrs;
> +		sysfs_bin_attr_init(bin_attrs[0]);
> +	}
> +
> +	sysfs_create_group(&adev->dev->kobj, &group);
>   
>   	return 0;
>   }

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
