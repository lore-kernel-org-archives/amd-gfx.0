Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE0E0C004D4
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jan 2023 09:23:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E68010E36B;
	Wed, 18 Jan 2023 09:23:48 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76B5710E36B
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jan 2023 09:23:44 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id ud5so81719093ejc.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jan 2023 01:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gJSgz/a4V9qew15uhio+j9mBYpQuXRaP+x6poUmYuXg=;
 b=RBKu4lky14T4YUVxZ+ZA6sY8UNEMgw5tIzWRKnTicyneucu21rU4qcpj0ghsFlbUs2
 lx9AKrXirzpTAiQ/kIjG7WViD4HPvzOiCxWCGizqMuSPNUEXbu3jdVnzAW44uqv2OA1D
 XQVRn3erjtk5yWQRRQVVQmtXBn+ptDPqbWGE23ipdy+gPASfIQad2qbBti6WCVz4lZiA
 rDKxi3iEKov93YzA7prSICcXbQHHZlgLNTfHVtkU8RgLyaqUPMBI/d+6tj7ND4tKATyq
 oxWLcOvQkaUpGWbAWlg7LpQ3x83EuL908YwX7Sp5bMvzWOi81ESGoROB8torTTIgWMZf
 4PHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gJSgz/a4V9qew15uhio+j9mBYpQuXRaP+x6poUmYuXg=;
 b=PT/FseDgA+l2JmDKMIK898mwAXOr2WxYWpxGfLtnU0eKD4w0uhRGSdiU07D1nmz1vD
 0AkAtjPOl1Fho3Bbwliod80C1zyxUlTEFKgJT3AwXu/PxUUlnVxtUW0teAqQdHZRLmyn
 JKpTGaUSzKQJg92sid7ugna/z6pDXT+hEb9yrqsX33KFDRluy7jEKKOktAHk3ufZvYSk
 UURfXXg+ZBOYl3CK0VB5Kw3+4XJkcGQocyjbsno7kaL787qaS/fvp3ryLEuUlV1WdCuM
 iws5l9g36cQQj9aODsY2uZtxBh0RyLRp9MRNDUMqGvfnO/TOguVVE+Z8GRrF0U1rB3q1
 CfqQ==
X-Gm-Message-State: AFqh2kq7cpVE/9cNclCco2md0oyhhieI0/QCdOQK6N6R/gYpdQ1ep5BU
 PoQSqQtyq3fLyPKIUT39jMk=
X-Google-Smtp-Source: AMrXdXub63A3YrUhwe+JhwAHnt6TY4IIQ/woyVHAyNvzft8BmvSVDejKPQSeQPgMR9NkDOrIy3MoTg==
X-Received: by 2002:a17:906:7e0c:b0:877:60b3:3fce with SMTP id
 e12-20020a1709067e0c00b0087760b33fcemr795413ejr.45.1674033823049; 
 Wed, 18 Jan 2023 01:23:43 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:d3a3:981b:3e23:8647?
 ([2a02:908:1256:79a0:d3a3:981b:3e23:8647])
 by smtp.gmail.com with ESMTPSA id
 fs37-20020a170907602500b0086ffe3a99f9sm4104336ejc.82.2023.01.18.01.23.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Jan 2023 01:23:42 -0800 (PST)
Message-ID: <0a5d068e-72cf-8bf8-e2db-1ac664a5869e@gmail.com>
Date: Wed, 18 Jan 2023 10:23:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/4] drm/amdgpu/nv: don't expose AV1 if VCN0 is harvested
Content-Language: en-US
To: "Liu, Leo" <Leo.Liu@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230117195949.1729608-1-alexander.deucher@amd.com>
 <DM8PR12MB5399565D89E1995B46AFC760E5C79@DM8PR12MB5399.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <DM8PR12MB5399565D89E1995B46AFC760E5C79@DM8PR12MB5399.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Acked-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

Am 18.01.23 um 02:09 schrieb Liu, Leo:
> [AMD Official Use Only - General]
>
> The series are:
>
> Reviewed-by: Leo Liu <leo.liu@amd.com>
>
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
> Sent: January 17, 2023 3:00 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 1/4] drm/amdgpu/nv: don't expose AV1 if VCN0 is harvested
>
> Only VCN0 supports AV1.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/nv.c | 101 +++++++++++++++++++++++++-------
>   1 file changed, 81 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c index 6853b93ac82e..d972025f0d20 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -98,7 +98,7 @@ static const struct amdgpu_video_codecs nv_video_codecs_decode =  };
>
>   /* Sienna Cichlid */
> -static const struct amdgpu_video_codec_info sc_video_codecs_decode_array[] =
> +static const struct amdgpu_video_codec_info
> +sc_video_codecs_decode_array_vcn0[] =
>   {
>          {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
>          {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)}, @@ -110,10 +110,27 @@ static const struct amdgpu_video_codec_info sc_video_codecs_decode_array[] =
>          {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 4352, 0)},  };
>
> -static const struct amdgpu_video_codecs sc_video_codecs_decode =
> +static const struct amdgpu_video_codec_info
> +sc_video_codecs_decode_array_vcn1[] =
>   {
> -       .codec_count = ARRAY_SIZE(sc_video_codecs_decode_array),
> -       .codec_array = sc_video_codecs_decode_array,
> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)},
> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096, 4)},
> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352,
> +0)}, };
> +
> +static const struct amdgpu_video_codecs sc_video_codecs_decode_vcn0 = {
> +       .codec_count = ARRAY_SIZE(sc_video_codecs_decode_array_vcn0),
> +       .codec_array = sc_video_codecs_decode_array_vcn0,
> +};
> +
> +static const struct amdgpu_video_codecs sc_video_codecs_decode_vcn1 = {
> +       .codec_count = ARRAY_SIZE(sc_video_codecs_decode_array_vcn1),
> +       .codec_array = sc_video_codecs_decode_array_vcn1,
>   };
>
>   /* SRIOV Sienna Cichlid, not const since data is controlled by host */ @@ -123,7 +140,7 @@ static struct amdgpu_video_codec_info sriov_sc_video_codecs_encode_array[] =
>          {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 4096, 2304, 0)},  };
>
> -static struct amdgpu_video_codec_info sriov_sc_video_codecs_decode_array[] =
> +static struct amdgpu_video_codec_info
> +sriov_sc_video_codecs_decode_array_vcn0[] =
>   {
>          {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
>          {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)}, @@ -135,16 +152,33 @@ static struct amdgpu_video_codec_info sriov_sc_video_codecs_decode_array[] =
>          {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 4352, 0)},  };
>
> +static struct amdgpu_video_codec_info
> +sriov_sc_video_codecs_decode_array_vcn1[] = {
> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)},
> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096, 4)},
> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352,
> +0)}, };
> +
>   static struct amdgpu_video_codecs sriov_sc_video_codecs_encode =  {
>          .codec_count = ARRAY_SIZE(sriov_sc_video_codecs_encode_array),
>          .codec_array = sriov_sc_video_codecs_encode_array,
>   };
>
> -static struct amdgpu_video_codecs sriov_sc_video_codecs_decode =
> +static struct amdgpu_video_codecs sriov_sc_video_codecs_decode_vcn0 =
>   {
> -       .codec_count = ARRAY_SIZE(sriov_sc_video_codecs_decode_array),
> -       .codec_array = sriov_sc_video_codecs_decode_array,
> +       .codec_count = ARRAY_SIZE(sriov_sc_video_codecs_decode_array_vcn0),
> +       .codec_array = sriov_sc_video_codecs_decode_array_vcn0,
> +};
> +
> +static struct amdgpu_video_codecs sriov_sc_video_codecs_decode_vcn1 = {
> +       .codec_count = ARRAY_SIZE(sriov_sc_video_codecs_decode_array_vcn1),
> +       .codec_array = sriov_sc_video_codecs_decode_array_vcn1,
>   };
>
>   /* Beige Goby*/
> @@ -181,20 +215,37 @@ static const struct amdgpu_video_codecs yc_video_codecs_decode = {  static int nv_query_video_codecs(struct amdgpu_device *adev, bool encode,
>                                   const struct amdgpu_video_codecs **codecs)  {
> +       if (adev->vcn.num_vcn_inst == hweight8(adev->vcn.harvest_config))
> +               return -EINVAL;
> +
>          switch (adev->ip_versions[UVD_HWIP][0]) {
>          case IP_VERSION(3, 0, 0):
>          case IP_VERSION(3, 0, 64):
>          case IP_VERSION(3, 0, 192):
>                  if (amdgpu_sriov_vf(adev)) {
> -                       if (encode)
> -                               *codecs = &sriov_sc_video_codecs_encode;
> -                       else
> -                               *codecs = &sriov_sc_video_codecs_decode;
> +                       if (adev->vcn.harvest_config & AMDGPU_VCN_HARVEST_VCN0) {
> +                               if (encode)
> +                                       *codecs = &sriov_sc_video_codecs_encode;
> +                               else
> +                                       *codecs = &sriov_sc_video_codecs_decode_vcn1;
> +                       } else {
> +                               if (encode)
> +                                       *codecs = &sriov_sc_video_codecs_encode;
> +                               else
> +                                       *codecs = &sriov_sc_video_codecs_decode_vcn0;
> +                       }
>                  } else {
> -                       if (encode)
> -                               *codecs = &nv_video_codecs_encode;
> -                       else
> -                               *codecs = &sc_video_codecs_decode;
> +                       if (adev->vcn.harvest_config & AMDGPU_VCN_HARVEST_VCN0) {
> +                               if (encode)
> +                                       *codecs = &nv_video_codecs_encode;
> +                               else
> +                                       *codecs = &sc_video_codecs_decode_vcn1;
> +                       } else {
> +                               if (encode)
> +                                       *codecs = &nv_video_codecs_encode;
> +                               else
> +                                       *codecs = &sc_video_codecs_decode_vcn0;
> +                       }
>                  }
>                  return 0;
>          case IP_VERSION(3, 0, 16):
> @@ -202,7 +253,7 @@ static int nv_query_video_codecs(struct amdgpu_device *adev, bool encode,
>                  if (encode)
>                          *codecs = &nv_video_codecs_encode;
>                  else
> -                       *codecs = &sc_video_codecs_decode;
> +                       *codecs = &sc_video_codecs_decode_vcn0;
>                  return 0;
>          case IP_VERSION(3, 1, 1):
>          case IP_VERSION(3, 1, 2):
> @@ -993,9 +1044,19 @@ static int nv_common_late_init(void *handle)
>
>          if (amdgpu_sriov_vf(adev)) {
>                  xgpu_nv_mailbox_get_irq(adev);
> -               amdgpu_virt_update_sriov_video_codec(adev,
> -                               sriov_sc_video_codecs_encode_array, ARRAY_SIZE(sriov_sc_video_codecs_encode_array),
> -                               sriov_sc_video_codecs_decode_array, ARRAY_SIZE(sriov_sc_video_codecs_decode_array));
> +               if (adev->vcn.harvest_config & AMDGPU_VCN_HARVEST_VCN0) {
> +                       amdgpu_virt_update_sriov_video_codec(adev,
> +                                                            sriov_sc_video_codecs_encode_array,
> +                                                            ARRAY_SIZE(sriov_sc_video_codecs_encode_array),
> +                                                            sriov_sc_video_codecs_decode_array_vcn1,
> +                                                            ARRAY_SIZE(sriov_sc_video_codecs_decode_array_vcn1));
> +               } else {
> +                       amdgpu_virt_update_sriov_video_codec(adev,
> +                                                            sriov_sc_video_codecs_encode_array,
> +                                                            ARRAY_SIZE(sriov_sc_video_codecs_encode_array),
> +                                                            sriov_sc_video_codecs_decode_array_vcn1,
> +                                                            ARRAY_SIZE(sriov_sc_video_codecs_decode_array_vcn1));
> +               }
>          }
>
>          return 0;
> --
> 2.39.0
>

