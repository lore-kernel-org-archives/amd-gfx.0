Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994D3FB44D6
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2026 08:29:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40B9410F432;
	Fri, 24 Apr 2026 08:29:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vx0EWJEz";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010067.outbound.protection.outlook.com [52.101.46.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D07E110F434
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2026 08:29:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BchC/RXAxm0g2ShyG80hzFIbvdaydBOa2IkzQQ67erGTcgKvAb1ngAVkObZ/9q2spb3WlWJY4PXnN3+nm/7Yh8GXKzTkmYcah2L3ji/BnI4Z+88WUeDmGzD46+TFPT8EA5KySRCycCioLp5YbWIUmM/3t4pSrZJoxuHbkgJd8UDuWVrz6/Rm5vvVEXuSr81OAexCLPmeDbqR6okBwDvCrT9LMx2InDeqGJDUTsPuJJT4l0I5VPlsC6Fktj0f8c9m5AwP/baym4q5DHj9L8DcxNoP3xWSWvO7YitgtMznLs7V+zohDF+sgfWk75ji9InxFRGQjdy5WdPEEAZ0XrJ7Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfNwIgz56ter9VYAExsMP9GAQDodFgn03rlddDgzAyQ=;
 b=HUSnZzOn2BSPtecP6tWDoxsHQXCEy9zpkLbzvhN0lToC2PFbujXL20DFNZRWn8HF9286VO9HQyFPZM1Y0DxzaX0iDlL94LoeY9hcHbmB82Mqdxq19xUvsZrWdgY5Pgfia0aNzP4OUOfbA21lt44V1jdY/2TBA0eY9qvNZpd57IJqVtAXfIDZypldh7Qpe15OjamdN/gnAhYn3lZ9sJeSf4d/0aN+uJ9EM9l2JLw3HmST/NaueXcaTe1Tp41s0b0MEligF8bdRdZZ0kzNPhzE/2PMbJAnU2TpFys4F4CHlyoTbJL56qT0iPKBTv5mNPMLKqEY/GyEXfdQNSqJzldnnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfNwIgz56ter9VYAExsMP9GAQDodFgn03rlddDgzAyQ=;
 b=Vx0EWJEz9n06jP9QgMC2BbS32mGv2Vm1e8Bt390Ma+SYc3AzGnffqbu+YknePIV0BT6i++IFv64hAk7UOttthzFFgwTjtTGtCBlqURjBBmRUk82h7zLOvaEIc2R7vwVooxluW9NaoJwTScR/z+yHQuhv58W1iSK3WfY7PWUDYlk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV2PR12MB5848.namprd12.prod.outlook.com (2603:10b6:408:173::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 08:29:14 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 08:29:13 +0000
Message-ID: <ffd8867b-50b8-4f67-a21c-45dfd24a2ae9@amd.com>
Date: Fri, 24 Apr 2026 10:29:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] drm/amdgpu: add AMDGPU_INFO_SDMA_USERQ_DOORBELL
 ioctl
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20260424081955.873090-1-Jesse.Zhang@amd.com>
 <20260424081955.873090-5-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260424081955.873090-5-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P222CA0008.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV2PR12MB5848:EE_
X-MS-Office365-Filtering-Correlation-Id: dd7a6821-0600-414d-c943-08dea1db90ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: aVZ4j+eCYgqjTG4Gq3A2PrS/muAON/l08/3H0tMcjtwqOkxzs9OL2UoDMmD42JXvt6NO/WBSdSH7XiNZ0KdyJN5en3iz3E8lP4bevNsG2MEGK0894CFfCE9iYYligUUP4kRFwRoJY6v793Q76kK+DNv8HDy9ZIqKPcbYnuJYH0U5MjI/MCBLwJvwApeGWhGrBMcmW/9ougaNtvxWCm3naI/c23ofvZ3GxOxSae/nNZwXKaYp+xlvDJXxaXAC4Kj5II9Up+dOl/mPP8Idj7UANhsco6czy3Dw1DsgE63+eaXI2R/+Xeu/DtMGTgG5W5/tarAXPbi8ySj6r6qnoFb553dWpJbzZEISUx2sVRDspqMNMAHzGFFR5Ta6SNkw5YL/Q+oJehTcrJOhDQq+svMr8CtYpomkUr5SqkfL4LmuYqaCEfZgtJBDYqUll86bFoJdGh7NbevylebDgaoWOjHzUkwmSOf4I1iSoVGDoq/moEzlnRIt9H4zCwP8SbR0XA6dGacR01sMaJeiPOL9+vhmsr9PQNeyXSfFrZAauz2JODlg9AEG1h0/+s3NV4svdYCGjj30dUd2S731h4rFXHMYkyRpWoo+Ri5fLoWyYxj9f2DBz2DafvEPt41PtofojbK3/DmJbt2A9UKGDS3y0yRijYO/1sLpuSSriOTZILpwncq2z4gG40RQPJqwNbFNcs2OLBa9MdmZphaHqttj7ZpJHwVNbCuw5pZIOA7+fVo2wkE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVpkYlE1eHpYRDU0c096dGNpVi93bXNjdnRkTkRaeE50NmJZcjlOb055dytR?=
 =?utf-8?B?dXJzRmVaSlFjclFFTlVHUmlPMmZQSFU5ZisvdFArN2U4NEgwREZMMzJDaTM5?=
 =?utf-8?B?R1BRZElnUStMKzRQZm1ELzNDRktzeGxrLzRCaWlnTEdOdXVoVmxtTFI4OU4y?=
 =?utf-8?B?N3lxMDVZdXZ5REhndThuT21ob3lhT2dMbVBoQ1JldXFsSUlYN0hvZysxeHo1?=
 =?utf-8?B?M01PNDNNcjkxRzRyUTFKOU1YTkQvZVdCZzMrdHdCZE5teHNLeW1NSmEzZ1N0?=
 =?utf-8?B?aEh1eVMrVWV0dzhjbTN2azExVU11TWNzdFdZTzM5Y1ZMSStrQTRtbFZsRTFj?=
 =?utf-8?B?M1hkajcxY0pFVkNPTUN4dkpTYXV5Q1Q2aEUzZllDNlFqZ3dibXQzRm5zTCtT?=
 =?utf-8?B?bEc2QTYrYmN1U2xVVXJaM0Jqdmx5U2UyYkVjZzJXR0pxVmtUd3dHRU5sdnpy?=
 =?utf-8?B?QVVMREVPbEFJNCtnWlFHUVA2SU5zRXk5WlpXbUxWQW1MN05JcmwvR3RiQi9m?=
 =?utf-8?B?N1U2WkFNYk1ubWE1RHFNckpZdGZaTnY5TXkyOUxEWE9TUFovc080TmcxdGNK?=
 =?utf-8?B?OEduM0FCKytRbTNwblJFYWlYRUZNN1RUNWdEaWcrL09jYTgrV1F1UjFrNmJs?=
 =?utf-8?B?c25ZSUh4dWJDVmpwUnlmTkdIaEJ5RldDamI2dnQ0dWpkT2Y2WnlIajY0aGdB?=
 =?utf-8?B?M2tZaWpJRE9uVFhPYUVSZmhrVDRFZHMxOVpSbk1RWUNGU1VRd2poeTF0bzhB?=
 =?utf-8?B?QlRBeDNMTTJCSXlWR2ZtNlcxTTdQOWZNclladDZDSWNHOXk3d3ZGL2Q1RHJZ?=
 =?utf-8?B?UFNOSWZBU1N3NWkxVXJkSEFKRWJOTkp0Mzd2b1RydytveG5tZDBBejVBWVJX?=
 =?utf-8?B?b1AvNE0vcEhDaFpzSkJKN3pIVDUxTGc3Z2V3ZEJxZm5OOXRtaW5kZTlwSlBM?=
 =?utf-8?B?Z2QyaVh6OW5YRDFhMVNEV1RkM055OWxiaHZlVzZZek5EYjJySU0zNVdnQkto?=
 =?utf-8?B?WmNHNTVLREN0RVpFWmxHdTdWaTRCb2VtbHNNRnA1akdiSWtxNFJWazNMbllu?=
 =?utf-8?B?MHNnSFh6WHFEUEFFazMwMTlqUldMbHp0NHFqellkdmVTTklZTUplbmpmVHZQ?=
 =?utf-8?B?bmkrMkRWWExKQ2RmNzVxaEl3OHFlU0czVXMwaGxDWUd1MkJKL1FRRXFNNmZv?=
 =?utf-8?B?VmRCNk1ES1BZeWxYODVZTTRmNmdZV2JtUnc2R0J6MFBMMVowSkpmZ2wrSGNH?=
 =?utf-8?B?bStNanpCZitmd1VoRnZYTVRpU0luNTJBOVU0aFoyRUpCZy9ZZkg0azFpT3Nm?=
 =?utf-8?B?TVVudnYxUEZMVXlsSyt6MWNqL2RQYzlhMXVOUEhOS2F2clJ0V095ZG5zTDhy?=
 =?utf-8?B?aWFoTjdoRWxrcDNOZHRtS3BvSHprVTE5OStkV3pmN3pxZEIzRWZCOXo3VWp2?=
 =?utf-8?B?K2gwSkIzZlJ6TzV6MTgrRytmckJQdGlYTTQxRGJoRTE5cENqbWk0amE1dHJ1?=
 =?utf-8?B?eWpXWlEra3NlSzBkVDZWMGJubSszL0NVZ2JEODg4NEx6aTlpc1pnZnU1cXdN?=
 =?utf-8?B?M05KcVFCR2dnb2pxeEtQaVVZcE9wQWc4c29aWUV1dCtKY0tzd2tzR1FmWWZW?=
 =?utf-8?B?WDV1YkJhQjFOdEVXNE44VFo2ZFhEZk1RdnZ1WTVYbUw4cHd3d1U1Mis3alpo?=
 =?utf-8?B?S3duNmEwWEVJUk5uditOWjlwYlpCWnFtcUkvWnp0MlQ3b1lhbkJGcitXNW9r?=
 =?utf-8?B?QUNoQ2ZSSzZ2Z3lqdHp0WC9yMlVzWmNHalErQXd5NzFFOVBuNWpLOVA2amFy?=
 =?utf-8?B?Q0lmUEpiTkJGVGszaVN2Z3VFUXZjRGhLT3FINEtMTzhWbzgrb0tJR3pSZU9i?=
 =?utf-8?B?emxkU1I5eTkySXBMU1ZLQ1F3NG1rSUkyQVYwYWNkbFk0cVVhWUlCUGVlMENz?=
 =?utf-8?B?MGp4SU8rUndXOU9uaC9Bc1dycFNFeHRFTzFIUHRHeFpVRzhiemNERGt4a1Nw?=
 =?utf-8?B?eXFCc1Z6MEZnREwzRGp0NlR0bDlQU0RUK3hBRXlxVGsrellqTFExWG1vejZj?=
 =?utf-8?B?aVB5cmdkNllTWTBna3NnVG93SGdLekpXa1FrbnFmcU42REZsb2tsMGRBU2hD?=
 =?utf-8?B?Y1puVWpRVkw5MGxIWlNJSFIvL2ZKNGJnZlNHdm56WGhYMkxPTDZyVHc3QkdO?=
 =?utf-8?B?VUZ6VFlFenNmM1duZ2ZjZzlyZkZXS3hveE4zWWE5bG5XQkp2YlZndFQ2d05Z?=
 =?utf-8?B?Nkx2L1FhM1hvRzRnOWhmWkkwQUtVR3IxdDdibS9NRzBBL09hWWt6YkNSZFFJ?=
 =?utf-8?Q?Kh7yn1BkSdy4x2Ts5a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd7a6821-0600-414d-c943-08dea1db90ec
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 08:29:13.8611 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jyzIKpzTPpbsA9AOVC8etDHiY1+pYzLaVMXj3aGU3d5JWVUE4/4Dc41I5BGdya6J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5848
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

On 4/24/26 10:18, Jesse Zhang wrote:
> From: "Jesse.zhang" <Jesse.zhang@amd.com>
> 
> New AMDGPU_INFO query that returns a per-fpriv GEM handle for the
> kernel-owned BO backing the SDMA UMQ doorbell window, plus its size.
> Userspace mmap()s that handle through the standard
> AMDGPU_GEM_OP_MMAP / mmap() flow to obtain a CPU pointer to the
> routable doorbell BAR window; each created SDMA usermode queue's
> qword-slot offset inside that mapping is reported in
> drm_amdgpu_userq_out.sdma_doorbell_offset_bytes.

We added the separate IOCTL for this purpose on the KFD/KGD unification branch. I think we should just cherry pick that over to amd-staging-drm-next.

@Alex what do you think?

Regards,
Christian.

> 
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 13 +++++++++++++
>  include/uapi/drm/amdgpu_drm.h           | 16 ++++++++++++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index d88e4994c8c1..dbcfbe418e42 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1425,6 +1425,19 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  			return -EINVAL;
>  		}
>  	}
> +	case AMDGPU_INFO_SDMA_USERQ_DOORBELL: {
> +		struct drm_amdgpu_info_sdma_userq_doorbell db_info = {};
> +		int r;
> +
> +		r = amdgpu_sdma_userq_doorbell_create_handle(adev, filp,
> +							     &db_info.handle,
> +							     &db_info.size_bytes);
> +		if (r)
> +			return r;
> +		return copy_to_user(out, &db_info,
> +				    min((size_t)size, sizeof(db_info)))
> +			? -EFAULT : 0;
> +	}
>  	default:
>  		DRM_DEBUG_KMS("Invalid request %d\n", info->query);
>  		return -EINVAL;
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 79e8bbda046b..533be8ad8a7e 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -1280,6 +1280,22 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
>  #define AMDGPU_INFO_GPUVM_FAULT			0x23
>  /* query FW object size and alignment */
>  #define AMDGPU_INFO_UQ_FW_AREAS			0x24
> +/*
> + * SDMA usermode-queue doorbell window query.  Returns a per-fpriv GEM
> + * handle for a kernel-owned BO that backs the routable SDMA doorbell
> + * window, plus its byte size.  Userspace mmap()s the BO via the standard
> + * AMDGPU_GEM_OP_MMAP / mmap() flow to get a CPU pointer; each created
> + * SDMA usermode queue's slot offset inside that mapping is returned in
> + * drm_amdgpu_userq_out.sdma_doorbell_offset_bytes.
> + */
> +#define AMDGPU_INFO_SDMA_USERQ_DOORBELL		0x25
> +
> +struct drm_amdgpu_info_sdma_userq_doorbell {
> +	/* Per-fpriv GEM handle for the SDMA UMQ doorbell BO. */
> +	__u32 handle;
> +	/* Byte size of the BO (== mmappable window size). */
> +	__u32 size_bytes;
> +};
>  
>  #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT	0
>  #define AMDGPU_INFO_MMR_SE_INDEX_MASK	0xff

