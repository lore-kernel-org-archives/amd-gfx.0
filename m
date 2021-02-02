Return-Path: <SRS0=dhbh=HE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5A2C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 08:30:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ED8464EC3
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 08:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ED8464EC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C9EA89C56;
	Tue,  2 Feb 2021 08:30:52 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 484AE89C56
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Feb 2021 08:30:51 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id n6so21880337edt.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Feb 2021 00:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=FJt+qAB2XWx9woURbUYNHoJMIdrJLTBBR34+RfewwPw=;
 b=oQ2ie4C2Us/q4V/YXNIVKDEULfvPDXZ9py1IVCWFHsPxWj9PBR9nXxGeiE71ek/DfB
 E/EnQtebIM28eVt/D4xEMvaKyYvySNrjhpdbH02pq6VYP2P1gkQoR83dz2p+FYCGt1Vp
 8XhVu20BiYbB6drvLT7jtM2X0vQnYqEZooIcud11n48m+G/7EQa1NSffv5LJFcbVWnqE
 o40aUGzJj38fel5rnm68bmFEpUdlCqSbKp6U9vDeymxunETZzuIAXmPXYCYX57J1qL+j
 lmzcTabZaQ1vVmjwJhDOngokQgMy75gSQL0B1V3ttFiehm65rF85rhMZkiK4B/Tgfggj
 UkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=FJt+qAB2XWx9woURbUYNHoJMIdrJLTBBR34+RfewwPw=;
 b=X15d14IVSbheZ282e67c8JvdqD/MIH6Md9+38AbFTer5lRBfOEi6CRneDkhdUghRzZ
 pNhYlzM5SEGoPpaeBFFk0jGlGEVrzLRLRg4QSt8jb4mW8QUqEaTXRh/c/KwzFKcBOTZw
 JPuxjq6lAbD5VrYRs1T8xVG4JemDeVsI6VNN4cTiOhyqj/RXoOE3Xe5TCPD7I5MG2jfz
 Mv2kXLGh6dJBkRth13hAfid+0UT7ck2NugZ9WHTyNn/OBjlKdt1+quNNNwNElIjQs9gY
 YtXi7k3DXtVnL8UU7rJ0gVL3kotO04dMmirTy9e9NK/vPoddRX30nQtjp/A34Hw3uK4T
 GovA==
X-Gm-Message-State: AOAM533bevLuieG9TmMNBWd4N1yyZu92kXO4k6QWLGHiNbGGww3au/29
 3KnnHb+M0nsBMzou7QoySZU=
X-Google-Smtp-Source: ABdhPJwDf55efGfqzYmrZCENTmQqSJAwnWnLHbX69yqhuyksnh8uZqXlo2EwPG4g8F2eTabXXJBuXQ==
X-Received: by 2002:a50:f19a:: with SMTP id x26mr13457861edl.354.1612254649789; 
 Tue, 02 Feb 2021 00:30:49 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id x14sm4539896ejb.0.2021.02.02.00.30.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Feb 2021 00:30:49 -0800 (PST)
Subject: Re: [PATCH 3/4] drm/amdgpu: add INFO ioctl support for querying video
 caps (v3)
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20210201165605.465228-1-alexander.deucher@amd.com>
 <20210201165605.465228-3-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <5bebcb9f-0606-d226-0856-ad3169bc99fb@gmail.com>
Date: Tue, 2 Feb 2021 09:30:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210201165605.465228-3-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 01.02.21 um 17:56 schrieb Alex Deucher:
> We currently hardcode these in mesa, but querying them from
> the kernel makes more sense since there may be board specific
> limitations that the kernel driver is better suited to
> determining.
>
> Userpace patches that use this interface:
> https://gitlab.freedesktop.org/leoliu/drm/-/commits/info_video_caps
> https://gitlab.freedesktop.org/leoliu/mesa/-/commits/info_video_caps
>
> v2: reorder the codecs to better align with mesa
> v3: add max_pixels_per_frame to handle the portrait case, squash in
>      memory leak fix
>
> Reviewed-by: Leo Liu <leo.liu@amd.com> (v2)
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 58 +++++++++++++++++++++++++
>   include/uapi/drm/amdgpu_drm.h           | 34 +++++++++++++++
>   2 files changed, 92 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 3c37cf1ae8b7..390362beda0e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -983,6 +983,64 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   				min_t(u64, size, sizeof(ras_mask))) ?
>   			-EFAULT : 0;
>   	}
> +	case AMDGPU_INFO_VIDEO_CAPS: {
> +		const struct amdgpu_video_codecs *codecs;
> +		struct drm_amdgpu_info_video_caps *caps;
> +		int r;
> +
> +		switch (info->video_cap.type) {
> +		case AMDGPU_INFO_VIDEO_CAPS_DECODE:
> +			r = amdgpu_asic_query_video_codecs(adev, false, &codecs);
> +			if (r)
> +				return -EINVAL;
> +			break;
> +		case AMDGPU_INFO_VIDEO_CAPS_ENCODE:
> +			r = amdgpu_asic_query_video_codecs(adev, true, &codecs);
> +			if (r)
> +				return -EINVAL;
> +			break;
> +			break;
> +		default:
> +			DRM_DEBUG_KMS("Invalid request %d\n",
> +				      info->video_cap.type);
> +			return -EINVAL;
> +		}
> +
> +		caps = kzalloc(sizeof(*caps), GFP_KERNEL);
> +		if (!caps)
> +			return -ENOMEM;
> +
> +		for (i = 0; i < codecs->codec_count; i++) {
> +			int idx = codecs->codec_array[i].codec_type;
> +
> +			switch (idx) {
> +			case AMDGPU_VIDEO_CODEC_TYPE_MPEG2:
> +			case AMDGPU_VIDEO_CODEC_TYPE_MPEG4:
> +			case AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC:
> +			case AMDGPU_VIDEO_CODEC_TYPE_VC1:
> +			case AMDGPU_VIDEO_CODEC_TYPE_HEVC:
> +			case AMDGPU_VIDEO_CODEC_TYPE_JPEG:
> +			case AMDGPU_VIDEO_CODEC_TYPE_VP9:
> +			case AMDGPU_VIDEO_CODEC_TYPE_AV1:
> +				caps->codec_info[idx].valid = 1;
> +				caps->codec_info[idx].max_width =
> +					codecs->codec_array[i].max_width;
> +				caps->codec_info[idx].max_height =
> +					codecs->codec_array[i].max_height;
> +				caps->codec_info[idx].max_pixels_per_frame =
> +					codecs->codec_array[i].max_pixels_per_frame;
> +				caps->codec_info[idx].max_level =
> +					codecs->codec_array[i].max_level;
> +				break;
> +			default:
> +				break;
> +			}
> +		}
> +		r = copy_to_user(out, caps,
> +				 min((size_t)size, sizeof(*caps))) ? -EFAULT : 0;
> +		kfree(caps);
> +		return r;
> +	}
>   	default:
>   		DRM_DEBUG_KMS("Invalid request %d\n", info->query);
>   		return -EINVAL;
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 7fb9c09ee93f..728566542f8a 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -782,6 +782,12 @@ struct drm_amdgpu_cs_chunk_data {
>   #define AMDGPU_INFO_VRAM_LOST_COUNTER		0x1F
>   /* query ras mask of enabled features*/
>   #define AMDGPU_INFO_RAS_ENABLED_FEATURES	0x20
> +/* query video encode/decode caps */
> +#define AMDGPU_INFO_VIDEO_CAPS			0x21
> +	/* Subquery id: Decode */
> +	#define AMDGPU_INFO_VIDEO_CAPS_DECODE		0
> +	/* Subquery id: Encode */
> +	#define AMDGPU_INFO_VIDEO_CAPS_ENCODE		1
>   
>   /* RAS MASK: UMC (VRAM) */
>   #define AMDGPU_INFO_RAS_ENABLED_UMC			(1 << 0)
> @@ -878,6 +884,10 @@ struct drm_amdgpu_info {
>   		struct {
>   			__u32 type;
>   		} sensor_info;
> +
> +		struct {
> +			__u32 type;
> +		} video_cap;
>   	};
>   };
>   
> @@ -1074,6 +1084,30 @@ struct drm_amdgpu_info_vce_clock_table {
>   	__u32 pad;
>   };
>   
> +/* query video encode/decode caps */
> +#define AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2			0
> +#define AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4			1
> +#define AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1			2
> +#define AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC		3
> +#define AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC			4
> +#define AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG			5
> +#define AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9			6
> +#define AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1			7
> +#define AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_COUNT			8

If I'm not completely mistaken this needs to be kept identical to the 
defines in amdgpu.h.

I think it might be better to have only one define for this.

Christian.

> +
> +struct drm_amdgpu_info_video_codec_info {
> +	__u32 valid;
> +	__u32 max_width;
> +	__u32 max_height;
> +	__u32 max_pixels_per_frame;
> +	__u32 max_level;
> +	__u32 pad;
> +};
> +
> +struct drm_amdgpu_info_video_caps {
> +	struct drm_amdgpu_info_video_codec_info codec_info[AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_COUNT];
> +};
> +
>   /*
>    * Supported GPU families
>    */

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
