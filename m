Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43DDC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 12:01:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8260860FA0
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 12:01:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8260860FA0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E49ED6EB73;
	Tue,  5 Oct 2021 12:01:33 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95F456EB73
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 12:01:32 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id t8so37009807wri.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Oct 2021 05:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=bSzc8Wv9+K7/UHef1QAwlQgR/NaBIHJBAtoJleUKCP8=;
 b=nYAgnAIBvzThTAX05K4uKZrKbsvWR+/H/EUkLmgg7eSK2AG17yt9l8BYkE5QOVoe6V
 +78ffa4jde6ao5RKVpAkqePcYKJDzvB6cn9FOanvozpC3j0ZTsHKUgyeOTRzT/72TBt7
 qWwE03PSckIHGxIynW5GLYAOaQpWkWLuo3uePtzRy0pFPwwM/+swEcUlFYjGzjzVyefg
 RFHMe+l0tt+hQ2W5wUKskogcUoI69bSq67EAqz7zq9BuuZqy8GRiwBRUbm3QSMANFwot
 ndftrbcsSIShQXZYGhffNKsKru2/tSbash0rzsCPDGR850pjvje/pU1u3xpyadkuXnwI
 bhvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=bSzc8Wv9+K7/UHef1QAwlQgR/NaBIHJBAtoJleUKCP8=;
 b=OCuVLsdjMoz9PrTf0aqOi685Se48QGmQfwLXZfDsmMP6wmFaJlXIbu6hQlzdSs1d9s
 oQnDHI6fjH26D+cbZE1VLvmJfa74FdTCgBRo0LdjJr1WUBwRs8E7qRafhx7poBSQUEXP
 yxXW53YmVpQPuSV5XsbOvpSZLV8+zskZjlfuv2ajeiLu3KH5C/s6uA6444Cn1vX946RW
 tJqR5r1qYpZz7uiQyEwcOqqu8832GFTuAX6WB+I34eMUEq6uST7OUObTh9Ar6xEa6uJZ
 yn4351AMQuCnhX23Z9PWi54Di2OvB0d+z1kO7IVy02BKpfjJD2YV3eeJzo0S2gBwD83g
 Hm4w==
X-Gm-Message-State: AOAM531rDT5FBhVzNpoWt6hphU/zq28rGd1K3LIrZ7Zn7lUXT+02zR5B
 Tr6MGak1RfzgUxhtBG/3brg/0L37g2Q=
X-Google-Smtp-Source: ABdhPJyODuzxSuYpPX/omuUty+2OTa0z6oxhnCqjEsnBXT4ASCKurTPXoePOCfW2TeBEVTS31GK53g==
X-Received: by 2002:adf:a443:: with SMTP id e3mr17643863wra.115.1633435291107; 
 Tue, 05 Oct 2021 05:01:31 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de.
 [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id x17sm17553486wrc.51.2021.10.05.05.01.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Oct 2021 05:01:30 -0700 (PDT)
Subject: Re: [PATCH 1/1] drm/amdgpu: init debugfs drm driver callback
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com, shashank.sharma@amd.com
References: <20211005115856.59649-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <015bf2cf-f085-0d55-17e2-f9583e0533ec@gmail.com>
Date: Tue, 5 Oct 2021 14:01:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211005115856.59649-1-nirmoy.das@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Am 05.10.21 um 13:58 schrieb Nirmoy Das:
> drm_dev_register() will try to init driver's debugfs using
> drm_driver.debugfs_init call back function. Use that callback
> also for amdgpu to intialize debugfs.

Mhm, why is that useful? We rather wanted to get rid of all this DRM 
midlayering.

Christian.

>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 10 +++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  7 +++----
>   3 files changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 6611b3c7c149..3076742f8f85 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1611,8 +1611,9 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>   			amdgpu_debugfs_sclk_set, "%llu\n");
>   
> -int amdgpu_debugfs_init(struct amdgpu_device *adev)
> +void amdgpu_debugfs_init(struct drm_minor *minor)
>   {
> +	struct amdgpu_device *adev = drm_to_adev(minor->dev);
>   	struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
>   	struct dentry *ent;
>   	int r, i;
> @@ -1621,14 +1622,14 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   				  &fops_ib_preempt);
>   	if (IS_ERR(ent)) {
>   		DRM_ERROR("unable to create amdgpu_preempt_ib debugsfs file\n");
> -		return PTR_ERR(ent);
> +		return;
>   	}
>   
>   	ent = debugfs_create_file("amdgpu_force_sclk", 0200, root, adev,
>   				  &fops_sclk_set);
>   	if (IS_ERR(ent)) {
>   		DRM_ERROR("unable to create amdgpu_set_sclk debugsfs file\n");
> -		return PTR_ERR(ent);
> +		return;
>   	}
>   
>   	/* Register debugfs entries for amdgpu_ttm */
> @@ -1682,11 +1683,10 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   	debugfs_create_blob("amdgpu_discovery", 0444, root,
>   			    &adev->debugfs_discovery_blob);
>   
> -	return 0;
>   }
>   
>   #else
> -int amdgpu_debugfs_init(struct amdgpu_device *adev)
> +void amdgpu_debugfs_init(struct drm_minor *minor)
>   {
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> index 371a6f0deb29..06b68e16e35d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> @@ -27,7 +27,7 @@
>    */
>   
>   int amdgpu_debugfs_regs_init(struct amdgpu_device *adev);
> -int amdgpu_debugfs_init(struct amdgpu_device *adev);
> +void amdgpu_debugfs_init(struct drm_minor *minor);
>   void amdgpu_debugfs_fini(struct amdgpu_device *adev);
>   void amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
>   void amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index df83b1f438b6..ceda650895db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2012,10 +2012,6 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>   			drm_fbdev_generic_setup(adev_to_drm(adev), 32);
>   	}
>   
> -	ret = amdgpu_debugfs_init(adev);
> -	if (ret)
> -		DRM_ERROR("Creating debugfs files failed (%d).\n", ret);
> -
>   	return 0;
>   
>   err_pci:
> @@ -2479,6 +2475,9 @@ static const struct drm_driver amdgpu_kms_driver = {
>   	.dumb_map_offset = amdgpu_mode_dumb_mmap,
>   	.fops = &amdgpu_driver_kms_fops,
>   	.release = &amdgpu_driver_release_kms,
> +#if defined(CONFIG_DEBUG_FS)
> +	.debugfs_init = amdgpu_debugfs_init,
> +#endif
>   
>   	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
>   	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,

