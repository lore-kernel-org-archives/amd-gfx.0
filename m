Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 148E5C77B70
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Apr 2023 15:30:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 648F810E1BF;
	Sun,  9 Apr 2023 15:30:14 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D7E110E1BF
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Apr 2023 15:30:11 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id s8so1719981wmo.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 09 Apr 2023 08:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1681054210; x=1683646210;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6Pl6L/agtORjpix1MFO5EdIMhsZuHPPcqVJZw2uBSp8=;
 b=JDZkBHwmRRKQO0+v4PHES/9Km0Im5JdwrWeSNxBO6SSbJ+aLStNR84/8I8QqENBqXD
 HAmVTZBqbQhkyYpE9Z3e28m2X3M4dsmZLf793227tBu0Afb0ykPRr2qFb0fFRjz3Fvof
 SQWXnROlkoeBVsAM3r+cpO54xv/cVDPfwUga1RD2xUcRUpJiClb2g5Ut3NmvVMUhyZSG
 1MGlw0SMSl860DQdyaD4gXN7PqxUNXuuy9Xb60G0WH9kXMSJasjYT6GjNQc4HTByOPUL
 Gv0oXeTNuXPeuLoXXfO7321j2faYp0mwKYeUE0e61+ltS1j8u46Jsq1ZopXVRPrboZfm
 mkGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681054210; x=1683646210;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6Pl6L/agtORjpix1MFO5EdIMhsZuHPPcqVJZw2uBSp8=;
 b=rEKSfdN3uDefky4O9YiRsIwBU8BBQF55jL3czT2vU8Q9wy24bdd4i9hStRk1pjKu0E
 AQF0gOMu36RRdtYWBhXpJ7bWbMZV/Be7GxIQv4VlRkhLoq516UnO8JjjxPmgrtXitogR
 HLbzdFeydvgnBUcXUOjBPFAAC+6WUKL16yTCiYzZ3yEWUYoLlXm3gxDveHYBpjH6co5Q
 IE3+ZgNIzox73j6Y1+KiEdo/mk1mIyFuoJd+tF7ebJv/tqw6dyDvNfyZQw3S7MVohi4A
 b5uU+YVesYrCMxpc6A8CeccQlJarsw1F/MtwG4mz7Lw2zV/VdEJLYpT0CX8Z4ulm4490
 yUKQ==
X-Gm-Message-State: AAQBX9fIZb1pFygwpoDGP1jWPqq4D4s1VGDcCcbyP1/HOQbqxVpzPzSB
 U/BSo4s/iik0/HcCxIATmJs=
X-Google-Smtp-Source: AKy350bTDqvfhqCgc+ta3yKyWgwPQR74ELT17ezRSu+N+ZH++nUW+6Xlp7a4g2HsFEShygtxZMZgrA==
X-Received: by 2002:a1c:7513:0:b0:3f0:7e15:f8fc with SMTP id
 o19-20020a1c7513000000b003f07e15f8fcmr4582793wmc.14.1681054209844; 
 Sun, 09 Apr 2023 08:30:09 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:f3e8:9542:46ff:241f?
 ([2a02:908:1256:79a0:f3e8:9542:46ff:241f])
 by smtp.gmail.com with ESMTPSA id
 c8-20020adfed88000000b002e45f6ffe63sm9490484wro.26.2023.04.09.08.30.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Apr 2023 08:30:09 -0700 (PDT)
Message-ID: <99dad825-894a-bc00-7a26-6b1b917477d4@gmail.com>
Date: Sun, 9 Apr 2023 17:30:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/3] drm/amdgpu: Add support for querying the max ibs in a
 submission.
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, amd-gfx@lists.freedesktop.org
References: <20230409144445.374816-1-bas@basnieuwenhuizen.nl>
 <20230409144445.374816-3-bas@basnieuwenhuizen.nl>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230409144445.374816-3-bas@basnieuwenhuizen.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: alexander.deucher@amd.com, David Airlie <airlied@gmail.com>,
 christian.koenig@amd.com, maraeo@gmail.com, timur.kristof@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 09.04.23 um 16:44 schrieb Bas Nieuwenhuizen:
> We need to introduce a new version of the info struct because
> libdrm_amdgpu forgot any versioning info in amdgpu_query_hw_ip_info
> so the mesa<->libdrm_amdgpu interface can't handle increasing the
> size.

Those are not forgotten, but simply unnecessary.

The size of the input output structures are given to the IOCTL in bytes 
and additional bytes should be filled with zeros.

So you should be able to extend the structures at the end without 
breaking anything.

Regards,
Christian.

>
> This info would be used by radv to figure out when we need to
> split a submission into multiple submissions. radv currently has
> a limit of 192 which seems to work for most gfx submissions, but
> is way too high for e.g. compute or sdma.
>
> Because the kernel handling is just fine we can just use the v2
> everywhere and have the return_size do the versioning for us,
> with userspace interpreting 0 as unknown.
>
> Userspace implementation:
> https://gitlab.freedesktop.org/bnieuwenhuizen/drm/-/tree/ib-rejection
> https://gitlab.freedesktop.org/bnieuwenhuizen/mesa/-/tree/ib-rejection
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2498
> Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> Cc: David Airlie <airlied@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  7 ++++--
>   include/uapi/drm/amdgpu_drm.h           | 29 +++++++++++++++++++++++++
>   2 files changed, 34 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 89689b940493..c7e815c2733e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -360,7 +360,7 @@ static int amdgpu_firmware_info(struct drm_amdgpu_info_firmware *fw_info,
>   
>   static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>   			     struct drm_amdgpu_info *info,
> -			     struct drm_amdgpu_info_hw_ip *result)
> +			     struct drm_amdgpu_info_hw_ip2 *result)
>   {
>   	uint32_t ib_start_alignment = 0;
>   	uint32_t ib_size_alignment = 0;
> @@ -431,6 +431,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>   		return -EINVAL;
>   	}
>   
> +	result->max_ibs = UINT_MAX;
>   	for (i = 0; i < adev->num_rings; ++i) {
>   		/* Note that this uses that ring types alias the equivalent
>   		 * HW IP exposes to userspace.
> @@ -438,6 +439,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>   		if (adev->rings[i]->funcs->type == info->query_hw_ip.type &&
>   		    adev->rings[i]->sched.ready) {
>   			++num_rings;
> +			result->max_ibs = min(result->max_ibs,
> +					      adev->rings[i]->max_ibs);
>   		}
>   	}
>   
> @@ -536,7 +539,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   		}
>   		return copy_to_user(out, &ui32, min(size, 4u)) ? -EFAULT : 0;
>   	case AMDGPU_INFO_HW_IP_INFO: {
> -		struct drm_amdgpu_info_hw_ip ip = {};
> +		struct drm_amdgpu_info_hw_ip2 ip = {};
>   		int ret;
>   
>   		ret = amdgpu_hw_ip_info(adev, info, &ip);
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index b6eb90df5d05..45e5ae546d19 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -1128,6 +1128,9 @@ struct drm_amdgpu_info_device {
>   	__u32 enabled_rb_pipes_mask_hi;
>   };
>   
> +/* The size of this struct cannot be increased for compatibility reasons, use
> + * struct drm_amdgpu_info_hw_ip2 instead.
> + */
>   struct drm_amdgpu_info_hw_ip {
>   	/** Version of h/w IP */
>   	__u32  hw_ip_version_major;
> @@ -1144,6 +1147,32 @@ struct drm_amdgpu_info_hw_ip {
>   	__u32  ip_discovery_version;
>   };
>   
> +/* The prefix fields of this are intentionally the same as those of
> + * struct drm_amdgpu_info_hw_ip. The struct has a v2 to resolve a lack of
> + * versioning on the libdrm_amdgpu side.
> + */
> +struct drm_amdgpu_info_hw_ip2 {
> +	/** Version of h/w IP */
> +	__u32  hw_ip_version_major;
> +	__u32  hw_ip_version_minor;
> +	/** Capabilities */
> +	__u64  capabilities_flags;
> +	/** command buffer address start alignment*/
> +	__u32  ib_start_alignment;
> +	/** command buffer size alignment*/
> +	__u32  ib_size_alignment;
> +	/** Bitmask of available rings. Bit 0 means ring 0, etc. */
> +	__u32  available_rings;
> +	/** version info: bits 23:16 major, 15:8 minor, 7:0 revision */
> +	__u32  ip_discovery_version;
> +	/** The maximum number of IBs one can submit in a single submission
> +	 * ioctl. (When using gang submit: this is per IP type)
> +	 */
> +	__u32  max_ibs;
> +	/** padding to 64bit for arch differences */
> +	__u32  pad;
> +};
> +
>   struct drm_amdgpu_info_num_handles {
>   	/** Max handles as supported by firmware for UVD */
>   	__u32  uvd_max_handles;

