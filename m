Return-Path: <SRS0=kdbD=HM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2FDC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Feb 2021 18:22:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3A5464D99
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Feb 2021 18:22:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A5464D99
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75B176ECC3;
	Wed, 10 Feb 2021 18:22:33 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E5DB6ECC3
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Feb 2021 18:22:31 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id q2so4159427edi.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Feb 2021 10:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=jGAOMVVeKc5mG2FhVEVgK6DZWa3CzZyy5rM1jHa48i8=;
 b=rt1zRe3zD820r/V07EiBBoHvHjszxZP+bzrNuYg2gdeOCwcVnM8BpIGv15pswmj8OH
 K3d47pv9WOmVE7PE2N67w7KOTgEaLcbBH4GawGiWhJwpZ88ut7Oy6oj40Jaae59bpUJy
 Q318+zLwMk8q/AKXzTitGbEF0/zj/sgz/2aVubI5TEysN6Jl3mY/LxPLYpnhJ/vlJtP/
 CqFaGEcSSA13UhiTFcYYzk0ebtiylBKjAEqLt2bvhr07RaH4H76am647Ap4wNaFm/Cz7
 Nbx5lHtT71++AvsHveEdrnr7HFRUmhftYndz+RS3HBvslVl1qUXJ5C8LaR0ptccuXG0p
 8R7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=jGAOMVVeKc5mG2FhVEVgK6DZWa3CzZyy5rM1jHa48i8=;
 b=kUHwfKHjnwQfINfRbZo9xu1eW8tfc52z7bkeFNVFkZatYie2FxWasEVuPOA671g/eZ
 b1s1jdVDleRuNsfxk5/AAjyQA8b8eug6INGWaJWruQ4JwWdvqkeLodFXc2byKVzBPgLf
 XkgEsBqrRZv9I3l0zPtbcjbMbhN6MHz9A8nt8PRQRIQRn3jiflhGP23VjV5GamPRu1uG
 s+uyo0U+/QOA18gRA311arCJGySucjQd5g8h6r6mDV3PjsPN6sI5ToSKZ/pEi6TCQsL3
 5V0V6GmGW8nCsSIhEpDNLHWZwnFAVQfJbPdkpDus704oCDbCe8brPb0PvL2S38fStVC6
 0+JA==
X-Gm-Message-State: AOAM530Zh+YFtSKlYIFC+RcpaBRQbNPOGsYESy5hIi3KNNxHM/QApPwB
 1k6GL2MgBT/bRmz5B+La1rIVpvlcvoITGQ==
X-Google-Smtp-Source: ABdhPJyfjmC6IPMSOfbeEX2HRljhNItVvDrKOqjMLMIb1hAJLYOKIYE6SV6FU2H7JgfyT1st2KHUhg==
X-Received: by 2002:a05:6402:20e:: with SMTP id
 t14mr4391320edv.178.1612981350257; 
 Wed, 10 Feb 2021 10:22:30 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:78b9:aa01:2f51:becf?
 ([2a02:908:1252:fb60:78b9:aa01:2f51:becf])
 by smtp.gmail.com with ESMTPSA id i18sm1673238edt.68.2021.02.10.10.22.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Feb 2021 10:22:29 -0800 (PST)
Subject: Re: [PATCH 1/2] drm/amdgpu: do not keep debugfs dentry
To: Nirmoy Das <nirmoy.das@amd.com>, Christian.Koenig@amd.com
References: <20210210160602.15903-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <a646cc69-864c-9f23-9a1b-144fa269deed@gmail.com>
Date: Wed, 10 Feb 2021 19:22:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210210160602.15903-1-nirmoy.das@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 10.02.21 um 17:06 schrieb Nirmoy Das:
> Cleanup unwanted  debugfs dentries.

Maybe write unnecessary instead of unwanted.

>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  4 ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 12 +++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c     | 34 ++++++++++-----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h     |  4 ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     |  4 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  4 ---
>   drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h     |  3 --
>   7 files changed, 23 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index e0c797a5f739..e3d4d2dcb3a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -797,10 +797,6 @@ struct amdgpu_device {
>   	struct amdgpu_i2c_chan		*i2c_bus[AMDGPU_MAX_I2C_BUS];
>   	struct amdgpu_debugfs		debugfs[AMDGPU_DEBUGFS_MAX_COMPONENTS];
>   	unsigned			debugfs_count;
> -#if defined(CONFIG_DEBUG_FS)
> -	struct dentry                   *debugfs_preempt;
> -	struct dentry			*debugfs_regs[AMDGPU_DEBUGFS_MAX_COMPONENTS];
> -#endif
>   	struct amdgpu_atif		*atif;
>   	struct amdgpu_atcs		atcs;
>   	struct mutex			srbm_mutex;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 4c38c5771cbc..874522217b7c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1228,7 +1228,6 @@ int amdgpu_debugfs_regs_init(struct amdgpu_device *adev)
>   					  adev, debugfs_regs[i]);
>   		if (!i && !IS_ERR_OR_NULL(ent))
>   			i_size_write(ent->d_inode, adev->rmmio_size);
> -		adev->debugfs_regs[i] = ent;
>   	}
>   
>   	return 0;
> @@ -1592,21 +1591,20 @@ DEFINE_SIMPLE_ATTRIBUTE(fops_sclk_set, NULL,
>   int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   {
>   	int r, i;
> +	struct dentry *ent = NULL;

Please don't initialize the variables and sort them so that r and i are 
last.

>   
> -	adev->debugfs_preempt =
> -		debugfs_create_file("amdgpu_preempt_ib", 0600,
> +	ent = debugfs_create_file("amdgpu_preempt_ib", 0600,
>   				    adev_to_drm(adev)->primary->debugfs_root, adev,
>   				    &fops_ib_preempt);
> -	if (!(adev->debugfs_preempt)) {
> +	if (!ent) {
>   		DRM_ERROR("unable to create amdgpu_preempt_ib debugsfs file\n");
>   		return -EIO;
>   	}
>   
> -	adev->smu.debugfs_sclk =
> -		debugfs_create_file("amdgpu_force_sclk", 0200,
> +	ent = debugfs_create_file("amdgpu_force_sclk", 0200,
>   				    adev_to_drm(adev)->primary->debugfs_root, adev,
>   				    &fops_sclk_set);
> -	if (!(adev->smu.debugfs_sclk)) {
> +	if (!ent) {
>   		DRM_ERROR("unable to create amdgpu_set_sclk debugsfs file\n");
>   		return -EIO;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 1fb2a91ad30a..1efdfb9b5506 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1137,15 +1137,16 @@ static int amdgpu_ras_sysfs_remove_all(struct amdgpu_device *adev)
>    *
>    */
>   /* debugfs begin */
> -static void amdgpu_ras_debugfs_create_ctrl_node(struct amdgpu_device *adev)
> +static void amdgpu_ras_debugfs_create_ctrl_node(struct amdgpu_device *adev,
> +						struct dentry *dir)
>   {
>   	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>   	struct drm_minor *minor = adev_to_drm(adev)->primary;
>   
> -	con->dir = debugfs_create_dir(RAS_FS_NAME, minor->debugfs_root);
> -	debugfs_create_file("ras_ctrl", S_IWUGO | S_IRUGO, con->dir,
> +	dir = debugfs_create_dir(RAS_FS_NAME, minor->debugfs_root);
> +	debugfs_create_file("ras_ctrl", S_IWUGO | S_IRUGO, dir,
>   				adev, &amdgpu_ras_debugfs_ctrl_ops);
> -	debugfs_create_file("ras_eeprom_reset", S_IWUGO | S_IRUGO, con->dir,
> +	debugfs_create_file("ras_eeprom_reset", S_IWUGO | S_IRUGO, dir,
>   				adev, &amdgpu_ras_debugfs_eeprom_ops);
>   
>   	/*
> @@ -1156,7 +1157,7 @@ static void amdgpu_ras_debugfs_create_ctrl_node(struct amdgpu_device *adev)
>   	 * ERREVENT_ATHUB_INTERRUPT generated. Normal GPU recovery routine
>   	 * will never be called.
>   	 */
> -	debugfs_create_bool("auto_reboot", S_IWUGO | S_IRUGO, con->dir,
> +	debugfs_create_bool("auto_reboot", S_IWUGO | S_IRUGO, dir,
>   				&con->reboot);
>   
>   	/*
> @@ -1164,16 +1165,16 @@ static void amdgpu_ras_debugfs_create_ctrl_node(struct amdgpu_device *adev)
>   	 * of RAS IPs during ras recovery.
>   	 */
>   	debugfs_create_bool("disable_ras_err_cnt_harvest", 0644,
> -			con->dir, &con->disable_ras_err_cnt_harvest);
> +			dir, &con->disable_ras_err_cnt_harvest);
>   }
>   
>   static void amdgpu_ras_debugfs_create(struct amdgpu_device *adev,
> -		struct ras_fs_if *head)
> +				      struct ras_fs_if *head,
> +				      struct dentry *dir)
>   {
> -	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>   	struct ras_manager *obj = amdgpu_ras_find_obj(adev, &head->head);
>   
> -	if (!obj || obj->ent)
> +	if (!obj || !dir)
>   		return;
>   
>   	get_obj(obj);
> @@ -1182,9 +1183,8 @@ static void amdgpu_ras_debugfs_create(struct amdgpu_device *adev,
>   			head->debugfs_name,
>   			sizeof(obj->fs_data.debugfs_name));
>   
> -	obj->ent = debugfs_create_file(obj->fs_data.debugfs_name,
> -				       S_IWUGO | S_IRUGO, con->dir, obj,
> -				       &amdgpu_ras_debugfs_ops);
> +	debugfs_create_file(obj->fs_data.debugfs_name, S_IWUGO | S_IRUGO, dir,
> +			    obj, &amdgpu_ras_debugfs_ops);
>   }
>   
>   void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev)
> @@ -1192,6 +1192,7 @@ void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev)
>   	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>   	struct ras_manager *obj;
>   	struct ras_fs_if fs_info;
> +	struct dentry *dir = NULL;
>   
>   	/*
>   	 * it won't be called in resume path, no need to check
> @@ -1200,7 +1201,7 @@ void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev)
>   	if (!IS_ENABLED(CONFIG_DEBUG_FS) || !con)
>   		return;
>   
> -	amdgpu_ras_debugfs_create_ctrl_node(adev);
> +	amdgpu_ras_debugfs_create_ctrl_node(adev, dir);

That won't work. You need to return the created directory here.

And please stop initializing variables if it isn't explicitly needed, 
the compiler would have pointed out that there is something wrong here 
without that.

>   
>   	list_for_each_entry(obj, &con->head, node) {
>   		if (amdgpu_ras_is_supported(adev, obj->head.block) &&
> @@ -1208,7 +1209,7 @@ void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev)
>   			sprintf(fs_info.debugfs_name, "%s_err_inject",
>   					ras_block_str(obj->head.block));
>   			fs_info.head = obj->head;
> -			amdgpu_ras_debugfs_create(adev, &fs_info);
> +			amdgpu_ras_debugfs_create(adev, &fs_info, dir);
>   		}
>   	}
>   }
> @@ -1218,10 +1219,9 @@ static void amdgpu_ras_debugfs_remove(struct amdgpu_device *adev,
>   {
>   	struct ras_manager *obj = amdgpu_ras_find_obj(adev, head);
>   
> -	if (!obj || !obj->ent)
> +	if (!obj)
>   		return;
>   
> -	obj->ent = NULL;
>   	put_obj(obj);
>   }

Is that function really doing anything any more? I don't think so.

Regards,
Christian.

>   
> @@ -1233,8 +1233,6 @@ static void amdgpu_ras_debugfs_remove_all(struct amdgpu_device *adev)
>   	list_for_each_entry_safe(obj, tmp, &con->head, node) {
>   		amdgpu_ras_debugfs_remove(adev, &obj->head);
>   	}
> -
> -	con->dir = NULL;
>   }
>   /* debugfs end */
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 762f5e46c007..aed0716efa5a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -318,8 +318,6 @@ struct amdgpu_ras {
>   	uint32_t supported;
>   	uint32_t features;
>   	struct list_head head;
> -	/* debugfs */
> -	struct dentry *dir;
>   	/* sysfs */
>   	struct device_attribute features_attr;
>   	struct bin_attribute badpages_attr;
> @@ -395,8 +393,6 @@ struct ras_manager {
>   	struct list_head node;
>   	/* the device */
>   	struct amdgpu_device *adev;
> -	/* debugfs */
> -	struct dentry *ent;
>   	/* sysfs */
>   	struct device_attribute sysfs_attr;
>   	int attr_inuse;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index aaad9e304ad9..f4d7cf60c262 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1788,7 +1788,7 @@ static void amdgpu_ttm_training_data_block_init(struct amdgpu_device *adev)
>   		(adev->gmc.mc_vram_size - GDDR6_MEM_TRAINING_OFFSET);
>   	ctx->train_data_size =
>   		GDDR6_MEM_TRAINING_DATA_SIZE_IN_BYTES;
> -	
> +
>   	DRM_DEBUG("train_data_size:%llx,p2c_train_data_offset:%llx,c2p_train_data_offset:%llx.\n",
>   			ctx->train_data_size,
>   			ctx->p2c_train_data_offset,
> @@ -2560,11 +2560,11 @@ int amdgpu_ttm_debugfs_init(struct amdgpu_device *adev)
>   				ttm_debugfs_entries[count].fops);
>   		if (IS_ERR(ent))
>   			return PTR_ERR(ent);
> +
>   		if (ttm_debugfs_entries[count].domain == TTM_PL_VRAM)
>   			i_size_write(ent->d_inode, adev->gmc.mc_vram_size);
>   		else if (ttm_debugfs_entries[count].domain == TTM_PL_TT)
>   			i_size_write(ent->d_inode, adev->gmc.gart_size);
> -		adev->mman.debugfs_entries[count] = ent;
>   	}
>   
>   	count = ARRAY_SIZE(amdgpu_ttm_debugfs_list);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 6c142455fc66..4df4cf2fd4dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -68,10 +68,6 @@ struct amdgpu_mman {
>   	bool				initialized;
>   	void __iomem			*aper_base_kaddr;
>   
> -#if defined(CONFIG_DEBUG_FS)
> -	struct dentry			*debugfs_entries[8];
> -#endif
> -
>   	/* buffer handling */
>   	const struct amdgpu_buffer_funcs	*buffer_funcs;
>   	struct amdgpu_ring			*buffer_funcs_ring;
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> index 10b0624ade65..83147b7d836e 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -439,9 +439,6 @@ struct smu_context
>   	struct smu_baco_context		smu_baco;
>   	struct smu_temperature_range	thermal_range;
>   	void *od_settings;
> -#if defined(CONFIG_DEBUG_FS)
> -	struct dentry                   *debugfs_sclk;
> -#endif
>   
>   	struct smu_umd_pstate_table	pstate_table;
>   	uint32_t pstate_sclk;

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
