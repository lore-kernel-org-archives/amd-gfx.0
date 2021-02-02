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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9B4C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 08:29:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3948664EC3
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 08:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3948664EC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7BA76E8DF;
	Tue,  2 Feb 2021 08:29:02 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B5EF6E8DF
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Feb 2021 08:29:01 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id r12so28591497ejb.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Feb 2021 00:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=x4VRDd1lIQbbYallxYu/meBTUhz8O895/DklS60c35g=;
 b=rdRnqzlzGNgqGsIUGaHEp9BMe7UMRRC8PKPU0TittZkKhJG7jjB5Gr9JGO5cX5wGJi
 brCCrPFAaoaIi/em5Ts4+pO2gjYSCoS1wgR/D0Y7z5CiXRZ0qRyfaRO0ecp9T3wIhHht
 yDiPTkv3XdQ0zIrKX+kXO4/uvjRNxozZpT/D5p3mLNosinfabpSAEJtqxLu5Ah5nwQEy
 SmhkoIF/OAnLZtLh5BkV6UAhhF6uU+9mHSdk8rVXGjfRqzmZ6cj8B35CG9yCWSdufIZz
 ylfBwa9TB++KcXsxKlL27d85kaqt6W56rqXFnmI+nOKjPEDLqLfZjN99R0moel/7Ec7t
 gtpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=x4VRDd1lIQbbYallxYu/meBTUhz8O895/DklS60c35g=;
 b=HpF7tdfWZh4gp+HKELUT/774pOnYa4raoFPO7d4KFBIsipGuKg3MyMAkZ1PH/juvbp
 uxE7k2UIuc8zOie0SaUsn2ZEAHCzk/Kryhf1mLH/1IP/jIbTBjLy8CqA4u60Yn3L5ubN
 ocLTrmqnl5f0TqL62WPYxQyGhmNMT+9L+sc4uL4J0+fAG0aOedyFsrg4mFeIGwXEuQ/a
 VAf/xvG3vsRBdum07LADFsOYPYaAIZjJx3jozRs27zZXYPMCIr31Z6CHgyTjarU6CXUx
 y6AuIedwYBokNZxuIiC/NTaTZVYjeMRGPQ4JmyW9+n+SEx27zm2ar8Nl7wwbcSYPvn5Q
 ZC/w==
X-Gm-Message-State: AOAM530mXudqvk4Dx84TXdESCctTlhJ/G//2iReqPjskqxA7aD736S/9
 k44wLOku4d2OjS5C4TROolo=
X-Google-Smtp-Source: ABdhPJxOfQCKaqchmfsyVFyCcDTE5lHmF4JbHVSlluhofS40VO9v5QU8d16cEY9BbkqMhbEJ0sk+Ig==
X-Received: by 2002:a17:906:d19b:: with SMTP id
 c27mr21668143ejz.234.1612254540024; 
 Tue, 02 Feb 2021 00:29:00 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id e11sm9067875ejz.94.2021.02.02.00.28.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Feb 2021 00:28:59 -0800 (PST)
Subject: Re: [PATCH 2/4] drm/amdgpu: add video decode/encode cap tables and
 asic callbacks (v2)
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20210201165605.465228-1-alexander.deucher@amd.com>
 <20210201165605.465228-2-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <0aa05d1f-e8a3-930b-f2bb-18d622a32818@gmail.com>
Date: Tue, 2 Feb 2021 09:28:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210201165605.465228-2-alexander.deucher@amd.com>
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
> For each asic family.  Will be used to populate tables
> for the new INFO ioctl query.
>
> v2: add max_pixels_per_frame to handle the portrait case
>
> Reviewed-by: Leo Liu <leo.liu@amd.com> (v1)
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/cik.c   |  75 ++++++++++
>   drivers/gpu/drm/amd/amdgpu/nv.c    | 179 ++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/si.c    | 109 ++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/soc15.c | 230 +++++++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/vi.c    | 188 +++++++++++++++++++++++
>   5 files changed, 781 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
> index 13737b317f7c..12ed86deaa84 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik.c
> @@ -70,6 +70,80 @@
>   #include "amdgpu_amdkfd.h"
>   #include "dce_virtual.h"
>   
> +static const struct amdgpu_video_codec_info cik_video_codecs_encode_array[] =
> +{
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
> +		.max_width = 2048,
> +		.max_height = 1152,
> +		.max_pixels_per_frame = 2048 * 1152,
> +		.max_level = 0,
> +	},
> +};
> +
> +static const struct amdgpu_video_codecs cik_video_codecs_encode =
> +{
> +	.codec_count = ARRAY_SIZE(cik_video_codecs_encode_array),
> +	.codec_array = cik_video_codecs_encode_array,
> +};
> +
> +static const struct amdgpu_video_codec_info cik_video_codecs_decode_array[] =
> +{
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG2,
> +		.max_width = 2048,
> +		.max_height = 1152,
> +		.max_pixels_per_frame = 2048 * 1152,
> +		.max_level = 3,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
> +		.max_width = 2048,
> +		.max_height = 1152,
> +		.max_pixels_per_frame = 2048 * 1152,
> +		.max_level = 5,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
> +		.max_width = 2048,
> +		.max_height = 1152,
> +		.max_pixels_per_frame = 2048 * 1152,
> +		.max_level = 41,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
> +		.max_width = 2048,
> +		.max_height = 1152,
> +		.max_pixels_per_frame = 2048 * 1152,
> +		.max_level = 4,
> +	},
> +};
> +
> +static const struct amdgpu_video_codecs cik_video_codecs_decode =
> +{
> +	.codec_count = ARRAY_SIZE(cik_video_codecs_decode_array),
> +	.codec_array = cik_video_codecs_decode_array,
> +};
> +
> +static int cik_query_video_codecs(struct amdgpu_device *adev, bool encode,
> +				  const struct amdgpu_video_codecs **codecs)
> +{
> +	switch (adev->asic_type) {
> +	case CHIP_BONAIRE:
> +	case CHIP_HAWAII:
> +	case CHIP_KAVERI:
> +	case CHIP_KABINI:
> +	case CHIP_MULLINS:
> +		if (encode)
> +			*codecs = &cik_video_codecs_encode;
> +		else
> +			*codecs = &cik_video_codecs_decode;
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>   /*
>    * Indirect registers accessor
>    */
> @@ -1944,6 +2018,7 @@ static const struct amdgpu_asic_funcs cik_asic_funcs =
>   	.get_pcie_replay_count = &cik_get_pcie_replay_count,
>   	.supports_baco = &cik_asic_supports_baco,
>   	.pre_asic_init = &cik_pre_asic_init,
> +	.query_video_codecs = &cik_query_video_codecs,
>   };
>   
>   static int cik_common_early_init(void *handle)
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 66279f0c6808..09341e85fbb0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -64,6 +64,184 @@
>   
>   static const struct amd_ip_funcs nv_common_ip_funcs;
>   
> +/* Navi */
> +static const struct amdgpu_video_codec_info nv_video_codecs_encode_array[] =
> +{
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
> +		.max_width = 4096,
> +		.max_height = 2304,
> +		.max_pixels_per_frame = 4096 * 2304,
> +		.max_level = 0,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
> +		.max_width = 4096,
> +		.max_height = 2304,
> +		.max_pixels_per_frame = 4096 * 2304,
> +		.max_level = 0,
> +	},
> +};
> +
> +static const struct amdgpu_video_codecs nv_video_codecs_encode =
> +{
> +	.codec_count = ARRAY_SIZE(nv_video_codecs_encode_array),
> +	.codec_array = nv_video_codecs_encode_array,
> +};
> +
> +/* Navi1x */
> +static const struct amdgpu_video_codec_info nv_video_codecs_decode_array[] =
> +{
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG2,
> +		.max_width = 4096,
> +		.max_height = 4096,
> +		.max_pixels_per_frame = 4096 * 4096,
> +		.max_level = 3,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
> +		.max_width = 4096,
> +		.max_height = 4096,
> +		.max_pixels_per_frame = 4096 * 4096,
> +		.max_level = 5,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
> +		.max_width = 4096,
> +		.max_height = 4096,
> +		.max_pixels_per_frame = 4096 * 4096,
> +		.max_level = 52,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
> +		.max_width = 4096,
> +		.max_height = 4096,
> +		.max_pixels_per_frame = 4096 * 4096,
> +		.max_level = 4,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
> +		.max_width = 8192,
> +		.max_height = 4352,
> +		.max_pixels_per_frame = 4096 * 4096,

Are those numbers correct? Looks more like this should be 8192 * 4352.

Christian.

> +		.max_level = 186,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_JPEG,
> +		.max_width = 4096,
> +		.max_height = 4096,
> +		.max_pixels_per_frame = 4096 * 4096,
> +		.max_level = 0,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VP9,
> +		.max_width = 8192,
> +		.max_height = 4352,
> +		.max_pixels_per_frame = 4096 * 4096,
> +		.max_level = 0,
> +	},
> +};
> +
> +static const struct amdgpu_video_codecs nv_video_codecs_decode =
> +{
> +	.codec_count = ARRAY_SIZE(nv_video_codecs_decode_array),
> +	.codec_array = nv_video_codecs_decode_array,
> +};
> +
> +/* Sienna Cichlid */
> +static const struct amdgpu_video_codec_info sc_video_codecs_decode_array[] =
> +{
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG2,
> +		.max_width = 4096,
> +		.max_height = 4096,
> +		.max_pixels_per_frame = 4096 * 4096,
> +		.max_level = 3,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
> +		.max_width = 4096,
> +		.max_height = 4096,
> +		.max_pixels_per_frame = 4096 * 4096,
> +		.max_level = 5,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
> +		.max_width = 4096,
> +		.max_height = 4096,
> +		.max_pixels_per_frame = 4096 * 4096,
> +		.max_level = 52,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
> +		.max_width = 4096,
> +		.max_height = 4096,
> +		.max_pixels_per_frame = 4096 * 4096,
> +		.max_level = 4,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
> +		.max_width = 8192,
> +		.max_height = 4352,
> +		.max_pixels_per_frame = 8192 * 4352,
> +		.max_level = 186,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_JPEG,
> +		.max_width = 4096,
> +		.max_height = 4096,
> +		.max_pixels_per_frame = 4096 * 4096,
> +		.max_level = 0,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VP9,
> +		.max_width = 8192,
> +		.max_height = 4352,
> +		.max_pixels_per_frame = 8192 * 4352,
> +		.max_level = 0,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_AV1,
> +		.max_width = 8192,
> +		.max_height = 4352,
> +		.max_pixels_per_frame = 8192 * 4352,
> +		.max_level = 0,
> +	},
> +};
> +
> +static const struct amdgpu_video_codecs sc_video_codecs_decode =
> +{
> +	.codec_count = ARRAY_SIZE(sc_video_codecs_decode_array),
> +	.codec_array = sc_video_codecs_decode_array,
> +};
> +
> +static int nv_query_video_codecs(struct amdgpu_device *adev, bool encode,
> +				 const struct amdgpu_video_codecs **codecs)
> +{
> +	switch (adev->asic_type) {
> +	case CHIP_SIENNA_CICHLID:
> +	case CHIP_NAVY_FLOUNDER:
> +	case CHIP_DIMGREY_CAVEFISH:
> +	case CHIP_VANGOGH:
> +		if (encode)
> +			*codecs = &nv_video_codecs_encode;
> +		else
> +			*codecs = &sc_video_codecs_decode;
> +		return 0;
> +	case CHIP_NAVI10:
> +	case CHIP_NAVI14:
> +	case CHIP_NAVI12:
> +		if (encode)
> +			*codecs = &nv_video_codecs_encode;
> +		else
> +			*codecs = &nv_video_codecs_decode;
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>   /*
>    * Indirect registers accessor
>    */
> @@ -825,6 +1003,7 @@ static const struct amdgpu_asic_funcs nv_asic_funcs =
>   	.supports_baco = &nv_asic_supports_baco,
>   	.pre_asic_init = &nv_pre_asic_init,
>   	.update_umd_stable_pstate = &nv_update_umd_stable_pstate,
> +	.query_video_codecs = &nv_query_video_codecs,
>   };
>   
>   static int nv_common_early_init(void *handle)
> diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
> index 3cf0589bfea5..da258ff75042 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si.c
> @@ -905,6 +905,114 @@ static const u32 hainan_mgcg_cgcg_init[] =
>   	0x3630, 0xfffffff0, 0x00000100,
>   };
>   
> +/* XXX: update when we support VCE */
> +#if 0
> +/* tahiti, pitcarin, verde */
> +static const struct amdgpu_video_codec_info tahiti_video_codecs_encode_array[] =
> +{
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
> +		.max_width = 2048,
> +		.max_height = 1152,
> +		.max_pixels_per_frame = 2048 * 1152,
> +		.max_level = 0,
> +	},
> +};
> +
> +static const struct amdgpu_video_codecs tahiti_video_codecs_encode =
> +{
> +	.codec_count = ARRAY_SIZE(tahiti_video_codecs_encode_array),
> +	.codec_array = tahiti_video_codecs_encode_array,
> +};
> +#else
> +static const struct amdgpu_video_codecs tahiti_video_codecs_encode =
> +{
> +	.codec_count = 0,
> +	.codec_array = NULL,
> +};
> +#endif
> +/* oland and hainan don't support encode */
> +static const struct amdgpu_video_codecs hainan_video_codecs_encode =
> +{
> +	.codec_count = 0,
> +	.codec_array = NULL,
> +};
> +
> +/* tahiti, pitcarin, verde, oland */
> +static const struct amdgpu_video_codec_info tahiti_video_codecs_decode_array[] =
> +{
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG2,
> +		.max_width = 2048,
> +		.max_height = 1152,
> +		.max_pixels_per_frame = 2048 * 1152,
> +		.max_level = 3,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
> +		.max_width = 2048,
> +		.max_height = 1152,
> +		.max_pixels_per_frame = 2048 * 1152,
> +		.max_level = 5,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
> +		.max_width = 2048,
> +		.max_height = 1152,
> +		.max_pixels_per_frame = 2048 * 1152,
> +		.max_level = 41,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
> +		.max_width = 2048,
> +		.max_height = 1152,
> +		.max_pixels_per_frame = 2048 * 1152,
> +		.max_level = 4,
> +	},
> +};
> +
> +static const struct amdgpu_video_codecs tahiti_video_codecs_decode =
> +{
> +	.codec_count = ARRAY_SIZE(tahiti_video_codecs_decode_array),
> +	.codec_array = tahiti_video_codecs_decode_array,
> +};
> +
> +/* hainan doesn't support decode */
> +static const struct amdgpu_video_codecs hainan_video_codecs_decode =
> +{
> +	.codec_count = 0,
> +	.codec_array = NULL,
> +};
> +
> +static int si_query_video_codecs(struct amdgpu_device *adev, bool encode,
> +				 const struct amdgpu_video_codecs **codecs)
> +{
> +	switch (adev->asic_type) {
> +	case CHIP_VERDE:
> +	case CHIP_TAHITI:
> +	case CHIP_PITCAIRN:
> +		if (encode)
> +			*codecs = &tahiti_video_codecs_encode;
> +		else
> +			*codecs = &tahiti_video_codecs_decode;
> +		return 0;
> +	case CHIP_OLAND:
> +		if (encode)
> +			*codecs = &hainan_video_codecs_encode;
> +		else
> +			*codecs = &tahiti_video_codecs_decode;
> +		return 0;
> +	case CHIP_HAINAN:
> +		if (encode)
> +			*codecs = &hainan_video_codecs_encode;
> +		else
> +			*codecs = &hainan_video_codecs_decode;
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>   static u32 si_pcie_rreg(struct amdgpu_device *adev, u32 reg)
>   {
>   	unsigned long flags;
> @@ -1897,6 +2005,7 @@ static const struct amdgpu_asic_funcs si_asic_funcs =
>   	.get_pcie_replay_count = &si_get_pcie_replay_count,
>   	.supports_baco = &si_asic_supports_baco,
>   	.pre_asic_init = &si_pre_asic_init,
> +	.query_video_codecs = &si_query_video_codecs,
>   };
>   
>   static uint32_t si_get_rev_id(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 2396be16c28e..a81fd7de72b7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -83,6 +83,234 @@
>   #define mmMP0_MISC_LIGHT_SLEEP_CTRL                                                             0x01ba
>   #define mmMP0_MISC_LIGHT_SLEEP_CTRL_BASE_IDX                                                    0
>   
> +/* Vega, Raven, Arcturus */
> +static const struct amdgpu_video_codec_info vega_video_codecs_encode_array[] =
> +{
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
> +		.max_width = 4096,
> +		.max_height = 2304,
> +		.max_pixels_per_frame = 4096 * 2304,
> +		.max_level = 0,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
> +		.max_width = 4096,
> +		.max_height = 2304,
> +		.max_pixels_per_frame = 4096 * 2304,
> +		.max_level = 0,
> +	},
> +};
> +
> +static const struct amdgpu_video_codecs vega_video_codecs_encode =
> +{
> +	.codec_count = ARRAY_SIZE(vega_video_codecs_encode_array),
> +	.codec_array = vega_video_codecs_encode_array,
> +};
> +
> +/* Vega */
> +static const struct amdgpu_video_codec_info vega_video_codecs_decode_array[] =
> +{
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG2,
> +		.max_width = 4096,
> +		.max_height = 4096,
> +		.max_pixels_per_frame = 4096 * 4096,
> +		.max_level = 3,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
> +		.max_width = 4096,
> +		.max_height = 4096,
> +		.max_pixels_per_frame = 4096 * 4096,
> +		.max_level = 5,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
> +		.max_width = 4096,
> +		.max_height = 4096,
> +		.max_pixels_per_frame = 4096 * 4096,
> +		.max_level = 52,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
> +		.max_width = 4096,
> +		.max_height = 4096,
> +		.max_pixels_per_frame = 4096 * 4096,
> +		.max_level = 4,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
> +		.max_width = 4096,
> +		.max_height = 4096,
> +		.max_pixels_per_frame = 4096 * 4096,
> +		.max_level = 186,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_JPEG,
> +		.max_width = 4096,
> +		.max_height = 4096,
> +		.max_pixels_per_frame = 4096 * 4096,
> +		.max_level = 0,
> +	},
> +};
> +
> +static const struct amdgpu_video_codecs vega_video_codecs_decode =
> +{
> +	.codec_count = ARRAY_SIZE(vega_video_codecs_decode_array),
> +	.codec_array = vega_video_codecs_decode_array,
> +};
> +
> +/* Raven */
> +static const struct amdgpu_video_codec_info rv_video_codecs_decode_array[] =
> +{
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG2,
> +		.max_width = 4096,
> +		.max_height = 4096,
> +		.max_pixels_per_frame = 4096 * 4096,
> +		.max_level = 3,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
> +		.max_width = 4096,
> +		.max_height = 4096,
> +		.max_pixels_per_frame = 4096 * 4096,
> +		.max_level = 5,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
> +		.max_width = 4096,
> +		.max_height = 4096,
> +		.max_pixels_per_frame = 4096 * 4096,
> +		.max_level = 52,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
> +		.max_width = 4096,
> +		.max_height = 4096,
> +		.max_pixels_per_frame = 4096 * 4096,
> +		.max_level = 4,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
> +		.max_width = 4096,
> +		.max_height = 4096,
> +		.max_pixels_per_frame = 4096 * 4096,
> +		.max_level = 186,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_JPEG,
> +		.max_width = 4096,
> +		.max_height = 4096,
> +		.max_pixels_per_frame = 4096 * 4096,
> +		.max_level = 0,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VP9,
> +		.max_width = 4096,
> +		.max_height = 4096,
> +		.max_pixels_per_frame = 4096 * 4096,
> +		.max_level = 0,
> +	},
> +};
> +
> +static const struct amdgpu_video_codecs rv_video_codecs_decode =
> +{
> +	.codec_count = ARRAY_SIZE(rv_video_codecs_decode_array),
> +	.codec_array = rv_video_codecs_decode_array,
> +};
> +
> +/* Renoir, Arcturus */
> +static const struct amdgpu_video_codec_info rn_video_codecs_decode_array[] =
> +{
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG2,
> +		.max_width = 4096,
> +		.max_height = 4096,
> +		.max_pixels_per_frame = 4096 * 4096,
> +		.max_level = 3,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
> +		.max_width = 4096,
> +		.max_height = 4096,
> +		.max_pixels_per_frame = 4096 * 4096,
> +		.max_level = 5,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
> +		.max_width = 4096,
> +		.max_height = 4096,
> +		.max_pixels_per_frame = 4096 * 4096,
> +		.max_level = 52,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
> +		.max_width = 4096,
> +		.max_height = 4096,
> +		.max_pixels_per_frame = 4096 * 4096,
> +		.max_level = 4,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
> +		.max_width = 8192,
> +		.max_height = 4352,
> +		.max_pixels_per_frame = 4096 * 4096,
> +		.max_level = 186,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_JPEG,
> +		.max_width = 4096,
> +		.max_height = 4096,
> +		.max_pixels_per_frame = 4096 * 4096,
> +		.max_level = 0,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VP9,
> +		.max_width = 8192,
> +		.max_height = 4352,
> +		.max_pixels_per_frame = 4096 * 4096,
> +		.max_level = 0,
> +	},
> +};
> +
> +static const struct amdgpu_video_codecs rn_video_codecs_decode =
> +{
> +	.codec_count = ARRAY_SIZE(rn_video_codecs_decode_array),
> +	.codec_array = rn_video_codecs_decode_array,
> +};
> +
> +static int soc15_query_video_codecs(struct amdgpu_device *adev, bool encode,
> +				    const struct amdgpu_video_codecs **codecs)
> +{
> +	switch (adev->asic_type) {
> +	case CHIP_VEGA20:
> +	case CHIP_VEGA10:
> +	case CHIP_VEGA12:
> +		if (encode)
> +			*codecs = &vega_video_codecs_encode;
> +		else
> +			*codecs = &vega_video_codecs_decode;
> +		return 0;
> +	case CHIP_RAVEN:
> +		if (encode)
> +			*codecs = &vega_video_codecs_encode;
> +		else
> +			*codecs = &rv_video_codecs_decode;
> +		return 0;
> +	case CHIP_ARCTURUS:
> +	case CHIP_RENOIR:
> +		if (encode)
> +			*codecs = &vega_video_codecs_encode;
> +		else
> +			*codecs = &rn_video_codecs_decode;
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>   /*
>    * Indirect registers accessor
>    */
> @@ -988,6 +1216,7 @@ static const struct amdgpu_asic_funcs soc15_asic_funcs =
>   	.get_pcie_replay_count = &soc15_get_pcie_replay_count,
>   	.supports_baco = &soc15_supports_baco,
>   	.pre_asic_init = &soc15_pre_asic_init,
> +	.query_video_codecs = &soc15_query_video_codecs,
>   };
>   
>   static const struct amdgpu_asic_funcs vega20_asic_funcs =
> @@ -1009,6 +1238,7 @@ static const struct amdgpu_asic_funcs vega20_asic_funcs =
>   	.get_pcie_replay_count = &soc15_get_pcie_replay_count,
>   	.supports_baco = &soc15_supports_baco,
>   	.pre_asic_init = &soc15_pre_asic_init,
> +	.query_video_codecs = &soc15_query_video_codecs,
>   };
>   
>   static int soc15_common_early_init(void *handle)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
> index d56b474b3a21..462368d2804b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -79,6 +79,193 @@
>   #include "mxgpu_vi.h"
>   #include "amdgpu_dm.h"
>   
> +/* Topaz */
> +static const struct amdgpu_video_codecs topaz_video_codecs_encode =
> +{
> +	.codec_count = 0,
> +	.codec_array = NULL,
> +};
> +
> +/* Tonga, CZ, ST, Fiji */
> +static const struct amdgpu_video_codec_info tonga_video_codecs_encode_array[] =
> +{
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
> +		.max_width = 4096,
> +		.max_height = 2304,
> +		.max_pixels_per_frame = 4096 * 2304,
> +		.max_level = 0,
> +	},
> +};
> +
> +static const struct amdgpu_video_codecs tonga_video_codecs_encode =
> +{
> +	.codec_count = ARRAY_SIZE(tonga_video_codecs_encode_array),
> +	.codec_array = tonga_video_codecs_encode_array,
> +};
> +
> +/* Polaris */
> +static const struct amdgpu_video_codec_info polaris_video_codecs_encode_array[] =
> +{
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
> +		.max_width = 4096,
> +		.max_height = 2304,
> +		.max_pixels_per_frame = 4096 * 2304,
> +		.max_level = 0,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
> +		.max_width = 4096,
> +		.max_height = 2304,
> +		.max_pixels_per_frame = 4096 * 2304,
> +		.max_level = 0,
> +	},
> +};
> +
> +static const struct amdgpu_video_codecs polaris_video_codecs_encode =
> +{
> +	.codec_count = ARRAY_SIZE(polaris_video_codecs_encode_array),
> +	.codec_array = polaris_video_codecs_encode_array,
> +};
> +
> +/* Topaz */
> +static const struct amdgpu_video_codecs topaz_video_codecs_decode =
> +{
> +	.codec_count = 0,
> +	.codec_array = NULL,
> +};
> +
> +/* Tonga */
> +static const struct amdgpu_video_codec_info tonga_video_codecs_decode_array[] =
> +{
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG2,
> +		.max_width = 4096,
> +		.max_height = 4096,
> +		.max_pixels_per_frame = 4096 * 4096,
> +		.max_level = 3,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
> +		.max_width = 4096,
> +		.max_height = 4096,
> +		.max_pixels_per_frame = 4096 * 4096,
> +		.max_level = 5,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
> +		.max_width = 4096,
> +		.max_height = 4096,
> +		.max_pixels_per_frame = 4096 * 4096,
> +		.max_level = 52,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
> +		.max_width = 4096,
> +		.max_height = 4096,
> +		.max_pixels_per_frame = 4096 * 4096,
> +		.max_level = 4,
> +	},
> +};
> +
> +static const struct amdgpu_video_codecs tonga_video_codecs_decode =
> +{
> +	.codec_count = ARRAY_SIZE(tonga_video_codecs_decode_array),
> +	.codec_array = tonga_video_codecs_decode_array,
> +};
> +
> +/* CZ, ST, Fiji, Polaris */
> +static const struct amdgpu_video_codec_info cz_video_codecs_decode_array[] =
> +{
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG2,
> +		.max_width = 4096,
> +		.max_height = 4096,
> +		.max_pixels_per_frame = 4096 * 4096,
> +		.max_level = 3,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
> +		.max_width = 4096,
> +		.max_height = 4096,
> +		.max_pixels_per_frame = 4096 * 4096,
> +		.max_level = 5,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
> +		.max_width = 4096,
> +		.max_height = 4096,
> +		.max_pixels_per_frame = 4096 * 4096,
> +		.max_level = 52,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
> +		.max_width = 4096,
> +		.max_height = 4096,
> +		.max_pixels_per_frame = 4096 * 4096,
> +		.max_level = 4,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
> +		.max_width = 4096,
> +		.max_height = 4096,
> +		.max_pixels_per_frame = 4096 * 4096,
> +		.max_level = 186,
> +	},
> +	{
> +		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_JPEG,
> +		.max_width = 4096,
> +		.max_height = 4096,
> +		.max_pixels_per_frame = 4096 * 4096,
> +		.max_level = 0,
> +	},
> +};
> +
> +static const struct amdgpu_video_codecs cz_video_codecs_decode =
> +{
> +	.codec_count = ARRAY_SIZE(cz_video_codecs_decode_array),
> +	.codec_array = cz_video_codecs_decode_array,
> +};
> +
> +static int vi_query_video_codecs(struct amdgpu_device *adev, bool encode,
> +				 const struct amdgpu_video_codecs **codecs)
> +{
> +	switch (adev->asic_type) {
> +	case CHIP_TOPAZ:
> +		if (encode)
> +			*codecs = &topaz_video_codecs_encode;
> +		else
> +			*codecs = &topaz_video_codecs_decode;
> +		return 0;
> +	case CHIP_TONGA:
> +		if (encode)
> +			*codecs = &tonga_video_codecs_encode;
> +		else
> +			*codecs = &tonga_video_codecs_decode;
> +		return 0;
> +	case CHIP_POLARIS10:
> +	case CHIP_POLARIS11:
> +	case CHIP_POLARIS12:
> +	case CHIP_VEGAM:
> +		if (encode)
> +			*codecs = &polaris_video_codecs_encode;
> +		else
> +			*codecs = &cz_video_codecs_decode;
> +		return 0;
> +	case CHIP_FIJI:
> +	case CHIP_CARRIZO:
> +	case CHIP_STONEY:
> +		if (encode)
> +			*codecs = &tonga_video_codecs_encode;
> +		else
> +			*codecs = &cz_video_codecs_decode;
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>   /*
>    * Indirect registers accessor
>    */
> @@ -1093,6 +1280,7 @@ static const struct amdgpu_asic_funcs vi_asic_funcs =
>   	.get_pcie_replay_count = &vi_get_pcie_replay_count,
>   	.supports_baco = &vi_asic_supports_baco,
>   	.pre_asic_init = &vi_pre_asic_init,
> +	.query_video_codecs = &vi_query_video_codecs,
>   };
>   
>   #define CZ_REV_BRISTOL(rev)	 \

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
