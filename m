Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C4AC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Nov 2023 08:16:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB81110E943;
	Fri, 10 Nov 2023 08:16:06 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97C1C10E943
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 08:16:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzO0WaXzXsp1Mb8/lY9eU6Azo2/28pwzrw4gSM2Q9zWeztJ0tY6Yis4LTeyTDQ7se+B5yF7z7ddTDoDHudvGYIuBH70whtuVJ0YkCppilgMLMyVqyHxBfC19lTc5rjDm5s6p8IELNJ6xp+KwBZ+3eYgIL1PyjWqp0lCSEQSG636N2D3xBtmHrv+VEZFgvIAJ8sXy5SuuugaBtFSqd/WJtB2oEHYJV39ISCoUJVBsuhBmv331GmJC5uDfU0w73+YMqj+2YBRxTfGcfAaf8IeF08QzCTYYUW5+N5ZTumuqhA7M/f/eNuBtHUIes2ViheQj0akQEyMUgcam3wSPqkFyiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVEaK4NO7pEIS6hgnpgMZ0NVHBl3pStX6Kax6Q0qX3k=;
 b=FW9LSyuQEy9TzOL6oBQqOB2mTQ7bskilJSSKJQ0rdGOFly0Um3ho8qCHrcCPFOnGMnza2/rA9NTls6clFg+GBxw+DhF5UOkS5RpvXVLYQmYD0DTTbAZ1bric1FSKkWM+5CqwZKMSV0QLAwl9OXREljNrK8SPwGrJWX7rNvqHhkN4UK/cSsIIKmdnzhDCYhMWcDwQKdL0RO4IpQSfFsjLiteIkBlU0bJmzqOXQAOXvbWnUel2p/Z66wOmDqt5xK+aEnhigKTm58ETRlOpvxjLHHbBoitIdnDeYQ6FMd+9QWzQH+pZ94jgqqw32HbKcFYHFNR1v00+ZQ2w64k7X9XbQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVEaK4NO7pEIS6hgnpgMZ0NVHBl3pStX6Kax6Q0qX3k=;
 b=DTeXuVbI+qqV7chKJyuBrEJ3b4CngNPImJ4/mNmSW2a+01HNSci1FM3nmM0UBKrEGunQ0bmciE4bMx6UQF5VFB3hNhhAQuHVGPe+JaRKDcenpQ/hBUl0aLm0HpVR5/UKoL1wsUPMXHLLUM+M2ekiLV0gizuWlTU+TieqH9jPjnM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by MN0PR12MB5836.namprd12.prod.outlook.com (2603:10b6:208:37b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Fri, 10 Nov
 2023 08:15:59 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::c258:1e94:a85b:1510]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::c258:1e94:a85b:1510%4]) with mapi id 15.20.6977.019; Fri, 10 Nov 2023
 08:15:59 +0000
Message-ID: <d3610129-9e74-b565-fa74-e3faa8924bdd@amd.com>
Date: Fri, 10 Nov 2023 13:45:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 3/3] drm/amdgpu: add new INFO IOCTL query for input power
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231109221400.936847-1-alexander.deucher@amd.com>
 <20231109221400.936847-3-alexander.deucher@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20231109221400.936847-3-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::7) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|MN0PR12MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: cc45094c-7fd9-4380-cfc6-08dbe1c54516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vLu2UsWh6FS4PHgNO6Duab+SabE96s3vYRO9yPPEkQfCwRVu+FPhZuQRgxxpsvydiDi8uHZy6d449RJoEAi6n+efEH1a+/43fRgBSXB6BFDbBZRocfUgAZtoWBIJDIt1EnxErAlRnT8Gl/rM8z5R8z4QWHLnV0au/hzg9IPTs99SNs8lBR2mnvyRXKyhnJ8szvKC8stOJJP2OTi+Iv8el4O3+pY5TSCBYy7wv+0GsxoDGXqP1jN5H4o+jmOiIttHgERhxSJKjRTnUJIpTnoHPVkKmvbj+SbPYhliMRmRC7Xm+36zwvg//ORO+7mOikVslZtwZ6T4N1p++3GRbNrYt136Vqqj5voASO1Y0DQJlvg2+Lcm6n1ncjujFAT9PYZMHv+5fAytRWFPqxlWnzoh5uA8djlpOafp+ln7NGJt5q3KGb25mLFTIWxQeuFqTrfPjvyQVs5KFZe+YKvSH9kQ9fnI92pUBSCwy3Tio6+MjJ7F6dESoTiSTM+QCPhyRIDGiZxRi5HiKaDoxa0175TrHR50Q0bO1wdhGACGqqzyOCHpouINgOv+flDIWVYoJRi9TejfUvcvaQVp6gYbEs0zuZ+bxfmwERkiv9i030CZiDFuApGpBTg+5z20O+nugMwdiHdw+cXhUsEqnQcz8nj/TQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(478600001)(6666004)(6506007)(966005)(2616005)(6512007)(38100700002)(6486002)(53546011)(316002)(26005)(66476007)(83380400001)(41300700001)(2906002)(66946007)(8936002)(5660300002)(66556008)(8676002)(36756003)(31696002)(86362001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akx4YUdqRE5BTEVNaXRxcnk4dThsSW1aZWpHS2VZNEdkOTVaT1Rvdk5VY0Np?=
 =?utf-8?B?WU9sNTNvV2Vld213Y1ZiRENoRHplS2I1MU1Xc1hLaitrRElZRHFoOC9tQTF0?=
 =?utf-8?B?WEhZaCt4d3lTV0o0ek5BRnd5ZmxVMnBuVlRxOXJZaXpna3huT1RwUWlEa1FS?=
 =?utf-8?B?RDNUNjhUcmVNRGxTRG9YU0tQWnJPWXQ4SzY3NzZPVmJ2blVnL3JTSDhIdldp?=
 =?utf-8?B?dHZyTU9WakxhL0kzbmpYajdyV3l6YUlJWVl5d0UrU0RpcUsrdlhxMnlDckhq?=
 =?utf-8?B?Q0NMVVNVdWhDb2wwU1JHUkxJN1E5OGxyMS90c0k2STFPcVRDQlRWSC9ISVI3?=
 =?utf-8?B?TUpFRy9sQzN2NG4rWmxxWEFBQXNGK0dwVUJSbEg2N2JTd1BpRkVKL3RiYVp1?=
 =?utf-8?B?MGY4NzgwbE50S3d1WWlGaWROQXZFTlQzYW1EOUcyTFJjM2xhalZRdlUyYUdG?=
 =?utf-8?B?bDZxdWZOSXphZE1yK0Mva0JLQUZmU2U0VDlFVmN3czlPZEpLQUYwbytzQ1pB?=
 =?utf-8?B?RGRIemdUbmxaOWgwS3pFQnAvbG5rN3BXYnNybGpEWEhvb3NQdUo2MFV1Rlhx?=
 =?utf-8?B?ejFOcHNUSHgzMmswOHBRdnpLQkJpZmcvNVdQdXAxeVpKU2VGOGJFcmdZcFVq?=
 =?utf-8?B?am5lZEpneG1xTXNxcmVZN0wrUmlzT2pINkRDZ2dKZ3p4aFpZRjdIOTJBcVdX?=
 =?utf-8?B?bitCSjl6SURSQ2RVM1JpVW9vY1RreTNiNDRBVXhUOXE4RGZuV1pqbitYT0Nj?=
 =?utf-8?B?WEVzUVVJdEg1akNvMjlla2lTWUd3K1ozU3VWQzQrQ25KTUVqS3RoSEo4TE9U?=
 =?utf-8?B?alRXdzZwNzVqd3VqaFVGQUsxQkJ1MG1DQUcxSGsxMFlxMzV2aXpyZkg4bW1q?=
 =?utf-8?B?eTNxWDNmRjVFZmdIaE1Hdkd1Q0ZoQzMzRjlrN1BackxwLytLVDk1UzIrbk0r?=
 =?utf-8?B?OElqR2dSWDdjbnhsRHZUeHdLQTVoWlNvbWw0RjcrckJXQlBucjRkTTNmZ0dm?=
 =?utf-8?B?ZFZaSW9NY1U0YmFIck9yS0xrbGtkc3htVVdNSjhjTHBkOFgvSzFjQmlpNkhn?=
 =?utf-8?B?MjVGTWIwOE9jV1cydS9QQnpYdzUrWHVzZnBPRWxoZFNRS0IwWVUySXkvV1JZ?=
 =?utf-8?B?WDNTUEZ5NXRqY0xudDh5cXk0YVo0bDc2MWFKYnA0MFBjM1p4VWtQNUY5elZo?=
 =?utf-8?B?elVwdTRkYUVGWXQyZUFSM09yNWRmRHI1b2JobytoWG9qdko5K1d4NGJJeFVP?=
 =?utf-8?B?QUY2N09YWVBUNUdKNW9oVTNDTFNjS2Q1MFRNZHFxSW0zdEl5cU5velVYYmtZ?=
 =?utf-8?B?MkVXN2xmZ2tNUTk2RXk4TVdhRTNweFArdVBiSWNkNDNLLzhmcTFYUEI1T3dh?=
 =?utf-8?B?RGNLeVlOR0RPb2w5ZzlHZWxMUlU3eit2YWhKdkdwdWlOS2RUbVU0MW5sdW9s?=
 =?utf-8?B?azc2VFNsVnNJSE1PTGpaSHFOc1hJQVUvNDhoaWVYK1FPd2hCTDdNcGNLaWdy?=
 =?utf-8?B?VytwKzdCU3ZpYlZPUkkvZDNCbS9OMThpekZSbVdScFQxQlE4Z2I1dE51UkRY?=
 =?utf-8?B?QzZGVkYwRHgvMU4yTWhhTTA3WUQ3Y0dLOTFBMkxmc052dDZ6NVcvcVNjZkNw?=
 =?utf-8?B?M0RpbFB3cEh3cEE0K3IzNytCMTU0Q1ZxYk13dkRzV2Q3RTAzUHRyMEdJZ2J1?=
 =?utf-8?B?anhCbkQ0alJGdHBOejIzRjRsMFphcWZWanJRZG9NNUI2M3dOZndtSDkwWktY?=
 =?utf-8?B?NXFta2hZRXphK1NBcFBtUEJNd0RuOUxKY0cxSVloa2JoUUZFL3VWdVNzM1Fk?=
 =?utf-8?B?OXk5dWhPZ0ZhMkhJWUMrMzBab3RCdHdoaTkvSVcrR1dvSWdWT2FUQUdWR1BJ?=
 =?utf-8?B?RXZwZjBCZjZQN1pGRmcxbXVYcUlIOHBrZlpjUnVTM0xDdzNIdEVxV0U4U3ZZ?=
 =?utf-8?B?OXdZd0ljR1A2bVNTZnpaUVExY1QrYlJtcXJEZHd2bnVyNS9pWENZejNWN0hY?=
 =?utf-8?B?NS9sbVdOZHphU0htcXZvdk0zeTA5ZmJlL3FXdXdjeEtUeW5TbUdid2haVkxE?=
 =?utf-8?B?Sk1EUk1pYkU4RjJXZno4bHVaWW0zVU9INFkwei9YYkQrTnlqc1R6ekI1bDJB?=
 =?utf-8?Q?DQqiYgd/VTp+M+ayr8KqwERMI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc45094c-7fd9-4380-cfc6-08dbe1c54516
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 08:15:59.2061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6lubBkfmmzYmxNepN5viCKH8/5MbZZYhbMOAmRs7I5qbScmpTBZINgRQuVqUEz/e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5836
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



On 11/10/2023 3:44 AM, Alex Deucher wrote:
> Some chips provide both average and input power.  Previously
> we just exposed average power, add a new query for input
> power.
> 

Input looks like a misnomer (not the supply side, but the power 
consumed). Better to rename to instantaneous or current power. I guess 
that will require rename of AMDGPU_PP_SENSOR_GPU_INPUT_POWER too.

Thanks,
Lijo

> Example userspace:
> https://github.com/Umio-Yasuno/libdrm-amdgpu-sys-rs/tree/input_power
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 9 +++++++++
>   include/uapi/drm/amdgpu_drm.h           | 2 ++
>   2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index bf4f48fe438d..48496bb585c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1114,6 +1114,15 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   			}
>   			ui32 >>= 8;
>   			break;
> +		case AMDGPU_INFO_SENSOR_GPU_INPUT_POWER:
> +			/* get input GPU power */
> +			if (amdgpu_dpm_read_sensor(adev,
> +						   AMDGPU_PP_SENSOR_GPU_INPUT_POWER,
> +						   (void *)&ui32, &ui32_size)) {
> +				return -EINVAL;
> +			}
> +			ui32 >>= 8;
> +			break;
>   		case AMDGPU_INFO_SENSOR_VDDNB:
>   			/* get VDDNB in millivolts */
>   			if (amdgpu_dpm_read_sensor(adev,
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index ad21c613fec8..96e32dafd4f0 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -865,6 +865,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
>   	#define AMDGPU_INFO_SENSOR_PEAK_PSTATE_GFX_SCLK			0xa
>   	/* Subquery id: Query GPU peak pstate memory clock */
>   	#define AMDGPU_INFO_SENSOR_PEAK_PSTATE_GFX_MCLK			0xb
> +	/* Subquery id: Query input GPU power	*/
> +	#define AMDGPU_INFO_SENSOR_GPU_INPUT_POWER	0xc
>   /* Number of VRAM page faults on CPU access. */
>   #define AMDGPU_INFO_NUM_VRAM_CPU_PAGE_FAULTS	0x1E
>   #define AMDGPU_INFO_VRAM_LOST_COUNTER		0x1F
