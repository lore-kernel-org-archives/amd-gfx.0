Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB60C982C1
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 07:07:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F266A10E5DD;
	Thu, 17 Sep 2026 07:07:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="cRckbceA";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAE2310E4F5
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 14:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789569288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=EDPix/sRkBcOfCZAVkb02PByHKB2s9aiXN3Tj10q83I=;
 b=cRckbceAgXULJSLQ2p+DnG7E2Tuq+u2P9Bowq8lb/XP5vpTipc60TG1blpBu3V9E+SQX5L
 L00zNHFrYsMYqC7nPFC1BZ4REcMOe/W6Ab1CujP6e45BMZuPzCicw7V5B0+7KNFotNtCdK
 BTk9ICw6zLFK7vST92kLC6nDwn/SK9g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-sNAJA2UcOGWNfxpSNp4Nqw-1; Wed, 16 Sep 2026 10:34:47 -0400
X-MC-Unique: sNAJA2UcOGWNfxpSNp4Nqw-1
X-Mimecast-MFC-AGG-ID: sNAJA2UcOGWNfxpSNp4Nqw_1789569286
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49e65f2f1baso45931715e9.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 07:34:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789569286; x=1790174086;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EDPix/sRkBcOfCZAVkb02PByHKB2s9aiXN3Tj10q83I=;
 b=wyTclah6LhXsLlffp8vDAnffcAst7/uQETj4MgKVR4ClmprKg/DZbQy4t3u6ARGcHm
 sMo087GdeySbvNRQvqGUTL8G2h5WKS7v6q9vnUeYN+XNKDCoqlzWauxhSIGbuMOu5OwG
 4CMynUoQ+Mi6KycmQ9v7q5HxZ7xmaAew48zyxd3OWlYCQOTTtCKGxT0rm/lzSLXfRppv
 mxlB/4yp9CftpwPy9EnlexJ0ub5Ksi9C6cU6F3AeWfBOWcqczoXilAXYrZdTeO7eEqsP
 zLj4vXV7df9yNN2zMqhTdLWjf0p3BD0PbQJ6xY87Wf1x/jGzJZ9NZxFzHMDVNA1UQ1Nq
 bo/w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzqmvcZFIhALtxxuviyvguODWvjMDs71hNPGawzZdj20ind7TGc4mwcas85sKnFq8MDXe/wYKM6@lists.freedesktop.org
X-Gm-Message-State: AFuF++m08jnJG+IEt1ZwTt4upeX7JuaoNM0qM1xTmQFmP3WHNg+JXfdP
 0PVwZUpVYysuP+B4QDqhaKcKGc+JjHl9cbHz3yt+sldWdHBuWDoXbgo6NXXyh28fsWqGFHBv7an
 HzU6QeVO79U4NUg/1bPyIPyEenKmZHv/DvHwt69OkemdNf/ssa10tYSXtdhF7qdAN8Hs=
X-Gm-Gg: AYBFou1ySogTX8CUiCXYdr1c0ayV6c5JyPdY3wuhICNPNk/ZlDRzfHn8aXkEhw2H7tY
 limF7louSezPs4nbairkWgAYOCh0r2hxixTaq4vwbSdTt/hymhA0sdMC8jJ85kmR8OdnU9Cjwxd
 mDa2O0zVLAGvIOdckhgdycR3h9qQ5gpVJ7rPDLmaJIc2iFE0DZBOtXHxhbSxmhhXcmNv17LfL9R
 l+LRmDuldbcwTXaa+7rgk1LRyTH0YeORhYw6d6VC0+hl8l0PtHBOMDjGxkseNn5M62TOLol07Uo
 MdEBOnoDXU0tCjzLbsMnpb0UIZhIPbKA/SjnxtOfe6D1agA4QAhYF6YEGIZtQYUby5cN/Foxiau
 jj238hrf767eDL6SUmVO9NkC9o8Xr
X-Received: by 2002:a05:600c:3492:b0:49e:7d25:f397 with SMTP id
 5b1f17b1804b1-49eb7301fd4mr28484075e9.15.1789569285802; 
 Wed, 16 Sep 2026 07:34:45 -0700 (PDT)
X-Received: by 2002:a05:600c:3492:b0:49e:7d25:f397 with SMTP id
 5b1f17b1804b1-49eb7301fd4mr28483675e9.15.1789569285291; 
 Wed, 16 Sep 2026 07:34:45 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-41-176-3.web.vodafone.de. [109.41.176.3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf2797csm7514919f8f.16.2026.09.16.07.34.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 07:34:44 -0700 (PDT)
Message-ID: <1b962878-c0a8-4f23-a00e-cc23be3b2c6c@redhat.com>
Date: Wed, 16 Sep 2026 16:34:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: fix kernel-doc warnings
To: Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>, Chuanyu Tseng
 <chuanyu.tseng@amd.com>, Ray Wu <ray.wu@amd.com>,
 Chenyu Chen <chen-yu.chen@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 amd-gfx@lists.freedesktop.org
References: <20260520183721.279669-1-rdunlap@infradead.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260520183721.279669-1-rdunlap@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JS0vowBLb2UWeVZ-VR6TRHVtBzCxCfAXMCSJMg-4_1Q_1789569286
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 17 Sep 2026 07:07:03 +0000
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

On 20/05/2026 20.37, Randy Dunlap wrote:
> Add a kernel-doc comment for @power_module and use the correct name
> for @boot_time_crc_info to eliminate kernel-doc warnings:
> 
> WARNING: ../drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:715 struct
>   member 'power_module' not described in 'amdgpu_display_manager'
> WARNING: ../drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:715 struct
>   member 'boot_time_crc_info' not described in 'amdgpu_display_manager'
> WARNING: ../drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:715 Excess
>   struct member 'dm_boot_time_crc_info' description in 'amdgpu_display_manager'
> 
> Fixes: b034c5b0d831 ("drm/amd/display: Add a buffer for boot time crc")
> Fixes: 3c108046e1d6 ("drm/amd/display: Add power module on Linux")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
...
> --- linux-next-20260520.orig/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ linux-next-20260520/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -330,6 +330,7 @@ struct hpd_rx_irq_offload_work {
>    * @backlight_link: Link on which to control backlight
>    * @backlight_caps: Capabilities of the backlight device
>    * @freesync_module: Module handling freesync calculations
> + * @power_module: Manages replay, PSR, and backlight control functionality
>    * @hdcp_workqueue: AMDGPU content protection queue
>    * @fw_dmcu: Reference to DMCU firmware
>    * @dmcu_fw_version: Version of the DMCU firmware
> @@ -708,7 +709,7 @@ struct amdgpu_display_manager {
>   	} fused_io[8];
>   
>   	/**
> -	 * @dm_boot_time_crc_info:
> +	 * @boot_time_crc_info:
>   	 *
>   	 * Buffer info for the boot time crc.
>   	 */
> 

I just ran into these kerneldoc warnings, too, would be nice to get those 
fixed, indeed!

Reviewed-by: Thomas Huth <thuth@redhat.com>

