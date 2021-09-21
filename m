Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8974DC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 21:00:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 501E661165
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 21:00:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 501E661165
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC6116E834;
	Tue, 21 Sep 2021 21:00:06 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F34F6E834
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 21:00:05 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id v22so1261101edd.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 14:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:subject:from:to:date:in-reply-to:references:user-agent
 :mime-version:content-transfer-encoding;
 bh=siqBb6uXo9+E+AQiRrpuzidYtOWAY+4r/1fjfvEl7Vs=;
 b=gw5CdomazoUWvPABKdRT22/7/YkOpDudyxImy6tEBnuefZpB4lCfyGBXLCBkXdae2P
 dN+2mej3Qu8HHKfxbEhRh+7xg6Xh+OMpU74KodI8WPmeYOS4DQ9bw5mRVIZmiakqoWbj
 g7fEunjQET8F4x5tv8F5wUc9uAWig63txN3aqscrUI0i8OPCuYKadB7woq92+PYglV8s
 zP0S5d3jd3rvGiD8IJN89s57f5mJ9NAdNCqYYD3+VoenGGBKnMXML/AZEqk/btlLPv3y
 KwdymZO5tvezbaP0h/GWDXz7WgTVolcsCUetcpl5JRfSholbsBhf29FHQoWteaV5gELY
 Zd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=siqBb6uXo9+E+AQiRrpuzidYtOWAY+4r/1fjfvEl7Vs=;
 b=TnvblksZ/ZkmUi/FE8Wf4en9Bc7cgnkvBRFwlcGAb/tIYwwe0+Y1GK5crtOpm8xE6R
 k4K17/NefXCv0ZTcacWsHU1VIVqcKerCqTr1BFcFYIPN4XDxCWyQNh73QEXBB0nr9/ji
 OthLyFLj5DDvjxOVjMYZKqR3PMKQyYMgqOZ+zyjKjJ/m8skYpTYpUHmX7gK5T+8BMNxc
 lTdiKLY0BxAUXupdjFbjwlFXkq5R9tLhpprZBWNDqpLwdB5w8YIikqNd3Zh8oi52Qewc
 TmK+PT377ukrIIbfVaXJErojOYhIGiKdE8PEbNHCAgbzwl7OiFMPQc/5DX9+RohWmFt9
 9grA==
X-Gm-Message-State: AOAM530TRrPt5RtsPybsaUrkMfDosHFa74/A7McRq1lZKy6AwHdhwu/O
 znUTwpS4nnoNywx7g1ewTSc=
X-Google-Smtp-Source: ABdhPJxDq5OftbOJ0L/NF95erXfZj0kBs33wjUE5fOqna73lw1ZTh7rBRuDiz94D9LWKHtsc0KOZ3w==
X-Received: by 2002:a17:906:5e43:: with SMTP id
 b3mr20453803eju.424.1632258003558; 
 Tue, 21 Sep 2021 14:00:03 -0700 (PDT)
Received: from [192.168.1.10] (c83-254-134-100.bredband.tele2.se.
 [83.254.134.100])
 by smtp.gmail.com with ESMTPSA id d16sm22943ejk.39.2021.09.21.14.00.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Sep 2021 14:00:02 -0700 (PDT)
Message-ID: <6768ce5600f8b20b1e5fbe20298a0296f3c053a5.camel@gmail.com>
Subject: Re: [PATCH 65/66] drm/amdkfd: convert kfd_device.c to use GC IP
 version
From: ernstp@gmail.com
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Date: Tue, 21 Sep 2021 23:00:01 +0200
In-Reply-To: <20210921180725.1985552-66-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
 <20210921180725.1985552-66-alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
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

tis 2021-09-21 klockan 14:07 -0400 skrev Alex Deucher:
> rather than asic type.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 254 +++++++++++++++++-------
>  1 file changed, 178 insertions(+), 76 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 9269b5e3aed1..25614a86b2c9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -53,41 +53,6 @@ extern const struct kfd2kgd_calls aldebaran_kfd2kgd;
>  extern const struct kfd2kgd_calls gfx_v10_kfd2kgd;
>  extern const struct kfd2kgd_calls gfx_v10_3_kfd2kgd;
>  
> 
> -static const struct kfd2kgd_calls *kfd2kgd_funcs[] = {
> -#ifdef KFD_SUPPORT_IOMMU_V2
> -#ifdef CONFIG_DRM_AMDGPU_CIK
> -	[CHIP_KAVERI] = &gfx_v7_kfd2kgd,
> -#endif
> -	[CHIP_CARRIZO] = &gfx_v8_kfd2kgd,
> -	[CHIP_RAVEN] = &gfx_v9_kfd2kgd,
> -#endif
> -#ifdef CONFIG_DRM_AMDGPU_CIK
> -	[CHIP_HAWAII] = &gfx_v7_kfd2kgd,
> -#endif
> -	[CHIP_TONGA] = &gfx_v8_kfd2kgd,
> -	[CHIP_FIJI] = &gfx_v8_kfd2kgd,
> -	[CHIP_POLARIS10] = &gfx_v8_kfd2kgd,
> -	[CHIP_POLARIS11] = &gfx_v8_kfd2kgd,
> -	[CHIP_POLARIS12] = &gfx_v8_kfd2kgd,
> -	[CHIP_VEGAM] = &gfx_v8_kfd2kgd,
> -	[CHIP_VEGA10] = &gfx_v9_kfd2kgd,
> -	[CHIP_VEGA12] = &gfx_v9_kfd2kgd,
> -	[CHIP_VEGA20] = &gfx_v9_kfd2kgd,
> -	[CHIP_RENOIR] = &gfx_v9_kfd2kgd,
> -	[CHIP_ARCTURUS] = &arcturus_kfd2kgd,
> -	[CHIP_ALDEBARAN] = &aldebaran_kfd2kgd,
> -	[CHIP_NAVI10] = &gfx_v10_kfd2kgd,
> -	[CHIP_NAVI12] = &gfx_v10_kfd2kgd,
> -	[CHIP_NAVI14] = &gfx_v10_kfd2kgd,
> -	[CHIP_SIENNA_CICHLID] = &gfx_v10_3_kfd2kgd,
> -	[CHIP_NAVY_FLOUNDER] = &gfx_v10_3_kfd2kgd,
> -	[CHIP_VANGOGH] = &gfx_v10_3_kfd2kgd,
> -	[CHIP_DIMGREY_CAVEFISH] = &gfx_v10_3_kfd2kgd,
> -	[CHIP_BEIGE_GOBY] = &gfx_v10_3_kfd2kgd,
> -	[CHIP_YELLOW_CARP] = &gfx_v10_3_kfd2kgd,
> -	[CHIP_CYAN_SKILLFISH] = &gfx_v10_kfd2kgd,
> -};
> -
>  #ifdef KFD_SUPPORT_IOMMU_V2
>  static const struct kfd_device_info kaveri_device_info = {
>  	.asic_family = CHIP_KAVERI,
> @@ -654,38 +619,6 @@ static const struct kfd_device_info cyan_skillfish_device_info = {
>  	.num_sdma_queues_per_engine = 8,
>  };
>  
> 
> -/* For each entry, [0] is regular and [1] is virtualisation device. */
> -static const struct kfd_device_info *kfd_supported_devices[][2] = {
> -#ifdef KFD_SUPPORT_IOMMU_V2
> -	[CHIP_KAVERI] = {&kaveri_device_info, NULL},
> -	[CHIP_CARRIZO] = {&carrizo_device_info, NULL},
> -#endif
> -	[CHIP_RAVEN] = {&raven_device_info, NULL},
> -	[CHIP_HAWAII] = {&hawaii_device_info, NULL},
> -	[CHIP_TONGA] = {&tonga_device_info, NULL},
> -	[CHIP_FIJI] = {&fiji_device_info, &fiji_vf_device_info},
> -	[CHIP_POLARIS10] = {&polaris10_device_info, &polaris10_vf_device_info},
> -	[CHIP_POLARIS11] = {&polaris11_device_info, NULL},
> -	[CHIP_POLARIS12] = {&polaris12_device_info, NULL},
> -	[CHIP_VEGAM] = {&vegam_device_info, NULL},
> -	[CHIP_VEGA10] = {&vega10_device_info, &vega10_vf_device_info},
> -	[CHIP_VEGA12] = {&vega12_device_info, NULL},
> -	[CHIP_VEGA20] = {&vega20_device_info, NULL},
> -	[CHIP_RENOIR] = {&renoir_device_info, NULL},
> -	[CHIP_ARCTURUS] = {&arcturus_device_info, &arcturus_device_info},
> -	[CHIP_ALDEBARAN] = {&aldebaran_device_info, &aldebaran_device_info},
> -	[CHIP_NAVI10] = {&navi10_device_info, NULL},
> -	[CHIP_NAVI12] = {&navi12_device_info, &navi12_device_info},
> -	[CHIP_NAVI14] = {&navi14_device_info, NULL},
> -	[CHIP_SIENNA_CICHLID] = {&sienna_cichlid_device_info, &sienna_cichlid_device_info},
> -	[CHIP_NAVY_FLOUNDER] = {&navy_flounder_device_info, &navy_flounder_device_info},
> -	[CHIP_VANGOGH] = {&vangogh_device_info, NULL},
> -	[CHIP_DIMGREY_CAVEFISH] = {&dimgrey_cavefish_device_info, &dimgrey_cavefish_device_info},
> -	[CHIP_BEIGE_GOBY] = {&beige_goby_device_info, &beige_goby_device_info},
> -	[CHIP_YELLOW_CARP] = {&yellow_carp_device_info, NULL},
> -	[CHIP_CYAN_SKILLFISH] = {&cyan_skillfish_device_info, NULL},
> -};
> -
>  static int kfd_gtt_sa_init(struct kfd_dev *kfd, unsigned int buf_size,
>  				unsigned int chunk_size);
>  static void kfd_gtt_sa_fini(struct kfd_dev *kfd);
> @@ -698,21 +631,190 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd, bool vf)
>  	const struct kfd_device_info *device_info;
>  	const struct kfd2kgd_calls *f2g;
>  	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
> -	unsigned int asic_type = adev->asic_type;
>  	struct pci_dev *pdev = adev->pdev;
>  
> 
> -	if (asic_type >= sizeof(kfd_supported_devices) / (sizeof(void *) * 2)
> -		|| asic_type >= sizeof(kfd2kgd_funcs) / sizeof(void *)) {
> -		dev_err(kfd_device, "asic_type %d out of range\n", asic_type);
> -		return NULL; /* asic_type out of range */
> +	switch (adev->asic_type) {
> +#ifdef KFD_SUPPORT_IOMMU_V2
> +#ifdef CONFIG_DRM_AMDGPU_CIK
> +	case CHIP_KAVERI:
> +		if (vf)
> +			device_info = NULL;
> +		else
> +			device_info = &kaveri_device_info;
> +		f2g = &gfx_v7_kfd2kgd;
> +		break;
> +#endif
> +	case CHIP_CARRIZO:
> +		if (vf)
> +			device_info = NULL;
> +		else
> +			device_info = &kaveri_device_info;

That should probably be carrizo. Found with W=1.

> +		f2g = &gfx_v8_kfd2kgd;
> +		break;
> +#endif
> +#ifdef CONFIG_DRM_AMDGPU_CIK
> +	case CHIP_HAWAII:
> +		if (vf)
> +			device_info = NULL;
> +		else
> +			device_info = &hawaii_device_info;
> +		f2g = &gfx_v7_kfd2kgd;
> +		break;
> +#endif
> +	case CHIP_TONGA:
> +		if (vf)
> +			device_info = NULL;
> +		else
> +			device_info = &tonga_device_info;
> +		f2g = &gfx_v8_kfd2kgd;
> +		break;
> +	case CHIP_FIJI:
> +		if (vf)
> +			device_info = &fiji_vf_device_info;
> +		else
> +			device_info = &fiji_device_info;
> +		f2g = &gfx_v8_kfd2kgd;
> +		break;
> +	case CHIP_POLARIS10:
> +		if (vf)
> +			device_info = &polaris10_vf_device_info;
> +		else
> +			device_info = &polaris10_device_info;
> +		f2g = &gfx_v8_kfd2kgd;
> +		break;
> +	case CHIP_POLARIS11:
> +		if (vf)
> +			device_info = NULL;
> +		else
> +			device_info = &polaris11_device_info;
> +		f2g = &gfx_v8_kfd2kgd;
> +		break;
> +	case CHIP_POLARIS12:
> +		if (vf)
> +			device_info = NULL;
> +		else
> +			device_info = &polaris12_device_info;
> +		f2g = &gfx_v8_kfd2kgd;
> +		break;
> +	case CHIP_VEGAM:
> +		if (vf)
> +			device_info = NULL;
> +		else
> +			device_info = &vegam_device_info;
> +		f2g = &gfx_v8_kfd2kgd;
> +		break;
> +	default:
> +		switch (adev->ip_versions[GC_HWIP][0]) {
> +		case IP_VERSION(9, 0, 1):
> +			if (vf)
> +				device_info = &vega10_vf_device_info;
> +			else
> +				device_info = &vega10_device_info;
> +			f2g = &gfx_v9_kfd2kgd;
> +			break;
> +#ifdef KFD_SUPPORT_IOMMU_V2
> +		case IP_VERSION(9, 1, 0):
> +		case IP_VERSION(9, 2, 2):
> +			if (vf)
> +				device_info = NULL;
> +			else
> +				device_info = &raven_device_info;
> +			f2g = &gfx_v9_kfd2kgd;
> +			break;
> +#endif
> +		case IP_VERSION(9, 2, 1):
> +			if (vf)
> +				device_info = NULL;
> +			else
> +				device_info = &vega12_device_info;
> +			f2g = &gfx_v9_kfd2kgd;
> +			break;
> +		case IP_VERSION(9, 3, 0):
> +			if (vf)
> +				device_info = NULL;
> +			else
> +				device_info = &renoir_device_info;
> +			f2g = &gfx_v9_kfd2kgd;
> +			break;
> +		case IP_VERSION(9, 4, 0):
> +			if (vf)
> +				device_info = NULL;
> +			else
> +				device_info = &vega20_device_info;
> +			f2g = &gfx_v9_kfd2kgd;
> +			break;
> +		case IP_VERSION(9, 4, 1):
> +			device_info = &arcturus_device_info;
> +			f2g = &arcturus_kfd2kgd;
> +			break;
> +		case IP_VERSION(9, 4, 2):
> +			device_info = &aldebaran_device_info;
> +			f2g = &aldebaran_kfd2kgd;
> +			break;
> +		case IP_VERSION(10, 1, 10):
> +			if (vf)
> +				device_info = NULL;
> +			else
> +				device_info = &navi10_device_info;
> +			f2g = &gfx_v10_kfd2kgd;
> +			break;
> +		case IP_VERSION(10, 1, 2):
> +			device_info = &navi12_device_info;
> +			f2g = &gfx_v10_kfd2kgd;
> +			break;
> +		case IP_VERSION(10, 1, 1):
> +			if (vf)
> +				device_info = NULL;
> +			else
> +				device_info = &navi14_device_info;
> +			f2g = &gfx_v10_kfd2kgd;
> +			break;
> +		case IP_VERSION(10, 1, 3):
> +			if (vf)
> +				device_info = NULL;
> +			else
> +				device_info = &cyan_skillfish_device_info;
> +			f2g = &gfx_v10_kfd2kgd;
> +			break;
> +		case IP_VERSION(10, 3, 0):
> +			device_info = &sienna_cichlid_device_info;
> +			f2g = &gfx_v10_3_kfd2kgd;
> +			break;
> +		case IP_VERSION(10, 3, 2):
> +			device_info = &navy_flounder_device_info;
> +			f2g = &gfx_v10_3_kfd2kgd;
> +			break;
> +		case IP_VERSION(10, 3, 1):
> +			if (vf)
> +				device_info = NULL;
> +			else
> +				device_info = &vangogh_device_info;
> +			f2g = &gfx_v10_3_kfd2kgd;
> +			break;
> +		case IP_VERSION(10, 3, 4):
> +			device_info = &dimgrey_cavefish_device_info;
> +			f2g = &gfx_v10_3_kfd2kgd;
> +			break;
> +		case IP_VERSION(10, 3, 5):
> +			device_info = &beige_goby_device_info;
> +			f2g = &gfx_v10_3_kfd2kgd;
> +			break;
> +		case IP_VERSION(10, 3, 3):
> +			if (vf)
> +				device_info = NULL;
> +			else
> +				device_info = &yellow_carp_device_info;
> +			f2g = &gfx_v10_3_kfd2kgd;
> +			break;
> +		default:
> +			return NULL;
> +		}
> +		break;
>  	}
>  
> 
> -	device_info = kfd_supported_devices[asic_type][vf];
> -	f2g = kfd2kgd_funcs[asic_type];
> -
>  	if (!device_info || !f2g) {
>  		dev_err(kfd_device, "%s %s not supported in kfd\n",
> -			amdgpu_asic_name[asic_type], vf ? "VF" : "");
> +			amdgpu_asic_name[adev->asic_type], vf ? "VF" : "");
>  		return NULL;
>  	}
>  
> 


