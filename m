Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC4ACA6007
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 08:20:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBC2210E782;
	Thu,  8 Oct 2026 08:20:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ohdZMyp0";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010016.outbound.protection.outlook.com
 [52.101.193.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3059B10E782
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 08:20:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o8uFX6IuDUmnCCjM19DMC88ffAGSPVB92JgLwxIbh4/KMWWc7GJOhV9ZhmyBcpzyqEq3rYRr69ckLj5woS9/Y3A/ZXms5OyoQMr1dl3mxU6h/xdmQH6iW73fTvLNU6pZ4TE08249Yip0Suc9TOUOxKe0Dd+33o2bv7dR1cvDJP+JTS9jS7280gYRgRvw1yVtHd47rorwqwkQiqP3CqRR8VPueziIj6cTqwssOALnYXW+u8HGdhOdw9Kd51xSG3k3rN6Om/6rxAe6FHEziRfRGTa0kcguY/B1IRIs8/Znipv3cMuQDSDBLwQ+qW+0i7/MrUtksl1IbxaFIxBEZOKn3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=imAgU0+viPDH01nGLZqsaZotcyqPE0Tnutwtjg/w1k0=;
 b=K8VY7sRfwEh9uIrkCZVDQb5WK4iVPKrJxOxLBlNDmGy8S81u4e231OyWzWy1SphIeMcz5/yEMRiFusX8DisCU+JMgeg6XI4QwYHgc1/5hKf5hbOpW9Fq6ck/t7A2oNOgO+T/QW6w3i7mIw0eLOnl5zo7bxeafhLVPCGyGC+yhAIgMtpFL2sba+Pb+4YWFqvQeJYTDwjX/ML5IxyyoC7Jw6C5z6cpgvemO21lMkS742u9a9wte/ZmNMiAz75stFZjQKpWBkHabmCemZlg7SJfis5JjjFS3syuXRhCfkrg0nIn0QXgUN2RFhcfhGGzdQC//go0Vh6hiTeDKx824jrVMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imAgU0+viPDH01nGLZqsaZotcyqPE0Tnutwtjg/w1k0=;
 b=ohdZMyp0467D2TcR+EEfGvAVqGFg/G1cUUeWsZAYE93wnBbRGHRr4Yv83/InCM+P6l7/46VdN0SlPdEjBvTqobNt07I+0iDpSgvsyKHl1uQ4TuNq8vyifmXGjCHRwbhaZZMKQHqsVKEspHxa/y9wq0EZDGAC47Uv/7+EuMEUDJE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4332.namprd12.prod.outlook.com (2603:10b6:5:21e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 8 Oct
 2026 08:20:31 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 08:20:31 +0000
Message-ID: <a6dc856e-e014-4ccd-8839-ab24346bf9c7@amd.com>
Date: Thu, 8 Oct 2026 10:20:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: wake the GPU for INFO queries that access the
 hardware
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Shahyan Soltani <shahyan.soltani@amd.com>
References: <20261008065140.3607658-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261008065140.3607658-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0086.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4332:EE_
X-MS-Office365-Filtering-Correlation-Id: 00d1df0b-fc74-4762-fcc2-08df25150482
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: JZtWuR6kYAcCdlxuU+Sox179mIwf/qfHImAVYSOaesTCg0YVXn2VUs/Ia3WNbOOsZSQAgMFqJwsH/CLusD3qub4Jj3th4uyJkCpsxsiKQZ5kFS3gsFNeyds1Tr3O7C+XW80YyzaSveeNtisnzwhqfg91usbIAa0Cwy1mYOqcZQIDgcKFIvPGWTtW1491fltz3JXZnJHjbmT79Is0nP2TIzhHz7P20ncbVoxESFmNtpOTaT05raXlwd4mPKyRWVcpOG2QGGuMk4YspO+TkslHIquxqg9SypoP+CIOWam1n/ZyowahM98J8iDC8Ju4ke56TQ8MfnygweHZPPKjxJfvhMbUTsQvJwK9VfC6mFdcqXSkF1tFhzoYX53sAnZO2u9HWj9Xc4P+Cc1pGtl4JTUBUASWF/zrCjWBps5Zbt62/AkATuenOKeLDGUiquxYGN/0+ucxaFq/SKcYEmzs34opwg5QFX6zHTy53kIVreXuL7CF8JN2t0gC+FuAlTOAPOLnS5cYPvHwTC+i81/UaQMlhLGYMM7kgZYecYtwn9nnWfNMNKQTFmD09909TP+SqX3XXbx77GVaQoZEZNNt3pWt1ip8hXtIvRzR3g6hY5lnP0kxR9scTEUVjOpWH4xNfS7CFg0ixPzd6PboNQwiT3L6THycFjSBPuAaA6LkDtrOl9o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHc1bzFaSG5aMHFDTlVnMHNMdHAwM3h5S1FkNkpiSEpVRnNxODBhUGlaMDht?=
 =?utf-8?B?MlZUZWdMbDVCSk9jcFd5VnZxNWpXcmxRZGdSQnVHQlR1N0ltWnVRVXc5Rnlv?=
 =?utf-8?B?SlRqN3lNb0NDQ0hVYWRXdlE3Wjd2eHRCOU00U21ScW5BbVRPT1ZGVWozTlYv?=
 =?utf-8?B?VThRNmpXRjRGeW1UaDlQeFo5UWppTW95UWJFcE1OblZFMWE4VWN3bFpZUnU1?=
 =?utf-8?B?aXNsWUJiOFZxeGRYVGhuU25KZDdGVzhJeG1BaWZ5NzRXSVZ3TksramxFRDFj?=
 =?utf-8?B?VVBmaGRyRm9WejNYZDlkRnhKQXl4dXQ0L3U3MDRhMEhaNmUrS095K0JSeHI5?=
 =?utf-8?B?eGlLVFlIb2xqajE1cmVLSWprYmk5R01ZcVhydnN3QmlYZVAwQVBaYzlNTEc2?=
 =?utf-8?B?UEsxYVg2T01YOW9OVWpoTm85MWhVY096a0FHQ09BTUFXcTRYTmphTnlncXl5?=
 =?utf-8?B?YWFsaWkrWnZrSVlsN21rZWxtSXFBczgrSkZuWTcxZjB3VG00dzNIcDQ5b2Vv?=
 =?utf-8?B?VmU1cUYxdGlnRUh3Y1hOM3ZKMEFTVm9Lc3dYQ2pPRUFONURTRmFJcmtwdnJq?=
 =?utf-8?B?d1lab1dQZzJ5dTBBM0RyUW5scGRWRW5EYXhLeGJ2RFA0S0RwR3dobnB4YlMz?=
 =?utf-8?B?RTBqQUZYZDI5RVBFMDhmNFU5OHpsWmNwMlZ4WTNEMzQ1bERnUmZ4bUxwYjNV?=
 =?utf-8?B?TDlZeVYzUFJPQ0dLYzB5c3lRbVUyNVJTdnBEdEFCWnl5NmFIZXpXZHJLU2Q3?=
 =?utf-8?B?Vkc1WnlmY216RGgzSSs4N1NVNDVwbExmSUQ5V2Zxb0hlYnVoQWwvdXVKQ1Ir?=
 =?utf-8?B?eS9oa2xCVlZrUFlMbDBBREg0UTF6UkRZY2RhaUUxWlVlSVJXQVpTSHRvK3BH?=
 =?utf-8?B?cytQYkVDYTFvS2ZVc0ZpdlF5L0dFUGZTSUJ6QmtxaFllVGt5b096WmhSYkMv?=
 =?utf-8?B?VHNWNHNBdWdRR1BBcDZDRDZqZTNlVU9KZ201SXRTZlRzTm0yODdhUWYrQXJG?=
 =?utf-8?B?SVF4c1pjOVpiKzZ2Z1FiNUtlcWFQVHg2NXJlVWZpeE8yc2o2SHlLWllCNTNL?=
 =?utf-8?B?WXhTMWN2QmgyT0FselJTWWdSZC96RG5EcFVLU29QU3Q2YXNkSDVsNG1UZk40?=
 =?utf-8?B?dWUvN29QQ2REUWo5UTVtZEIydkcvUTVmL3QyK0NxQ0lRUlZ6eTNRN2xEL0Jq?=
 =?utf-8?B?U0dNY1o3TG9kdzFoc1E4REpIUWh1YU5pL1RMem4ySWRJaUIyT3J5THpYMW5x?=
 =?utf-8?B?cmxGcUhycis4TjRvZmg4c0xNVTlEQ09pT2psOGhJTWF6T01EOGUrcGRPM0FF?=
 =?utf-8?B?UC9RdEhZWGoyaDVQejZlSllZVDFSWGF1QjVnMXRtd0plRGJUYzFQV2Q1UTY0?=
 =?utf-8?B?akRoOFNPd2tDUVF0UG5VTGtOWkh5Wm82L1hQNVlLaEl6Q2phN1RadjJxa2Fm?=
 =?utf-8?B?Z3c5b3UvRFdQU0NHaFdJa25HZE5PVFR6V1U4YmNBZVpsMWZHL25aTEMvd0Zp?=
 =?utf-8?B?Q1ROb0d0Z2JSRzM5dFVnOHVFanp2WTd5UWY4WWZ6TEQyR2EvOTRTeUZreWtB?=
 =?utf-8?B?Q0d4Yyt3cm5KeWdCeGw1NFUyVVo0d3I3cS9JK0N3REdoSjk1YXZjcmw3Y2NT?=
 =?utf-8?B?VmVjSlh3dkJlTHRYNG9qUjFhQWNGQW9aSWdmOWZROWIyWkUwVWIxS25rS1FJ?=
 =?utf-8?B?UDNwRnFuV0ZWL05YZ3Z2YWRmZUZFa0xMYis0ai9rUmRaWXN1TDkzeVR1ZHMr?=
 =?utf-8?B?VkYxVG5pNFg5NXk3NnBtTkpDOGpKaEwwS2hjNWtiU3h6eHhCZ2dHSFV2QTJQ?=
 =?utf-8?B?Yjk3Rk1UZnd6MUlCZ1JMZHlpYTFhUGltRVRuVTZiWG1Dam1iSVgvRm04b3BN?=
 =?utf-8?B?eFJaSjN3Qmd1RllBM3U5UGovdWdiendaT0pXNnVVcHBKeU11TERVU3JYcU83?=
 =?utf-8?B?MW55NzJRLzB3WGFrdEN1bWZsNXBHWnZheUlwbjBKYm5kcVRtd2RjYkIvTTkr?=
 =?utf-8?B?bWdBa3dyV0VTaUFVbFpxeTdSSkZLREx0dkZsYXRyZXZsTEp2d0JuUkJlTGo3?=
 =?utf-8?B?UHhBa29ZSHIvUXRCZGlseXRqYlpMNHFNMXpjRzZoN01sVjJMNmhwTkpCTEYx?=
 =?utf-8?B?c3M3R1JlNEs4S0t2NXh4RVl3Ty9TVnVERGlGd0R5ZkxVbzJmWlNseVBtdEpT?=
 =?utf-8?B?MmI4OHhjL2ZvNUQwTDhHVnRQRitLUWJkeWhHNGFBNHRYcm02RnlhNnJ5WHAw?=
 =?utf-8?B?bWpSNUh0V09tRkJoblZBSzJQN3QxdHU1Y2QydXl4N1orZ3BYcElxaHJtQXdV?=
 =?utf-8?Q?PR23ol89c0BC/Z2Lvd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d1df0b-fc74-4762-fcc2-08df25150482
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 08:20:31.1915 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M0rg8t3zpHSIOtzuTAYr5x6jozEu4j2UNTmuhu/8aFiH26itNYhlqQgXsk3k3+mG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4332
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

On 10/8/26 08:50, Jesse Zhang wrote:
> Since amdgpu_drm_ioctl() was removed, amdgpu_info_ioctl() no longer
> holds a runtime PM reference. When the GPU is runtime suspended, the
> queries that touch the hardware run against a powered down device:
> 
>   - AMDGPU_INFO_READ_MMR_REG reads all ones,
>   - AMDGPU_INFO_TIMESTAMP returns ~0ull,
>   - AMDGPU_INFO_DEV_INFO reports 0 for the engine and memory clock
>     limits because the SMU is down,
>   - AMDGPU_INFO_SENSOR fails with -ENOENT.
> 
> On Navi31 with an idle GPU in BAMACO, GRBM_STATUS reads 0xffffffff
> instead of 0x0000302c, the timestamp is 0xffffffffffffffff, and the
> min/max sclk is reported as 0/0 kHz instead of 500000/1880000 kHz.
> 
> Resume the GPU for these queries, the same way the CS ioctl does.
> 
> Fixes: a66aee8f3057 ("drm/amdgpu: get rid of amdgpu_drm_ioctl")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Yeah, I already expected that we have missed some.

Reviewed-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 28 ++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index f34150d20a2f..1589b6a6575f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -780,9 +780,16 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  
>  		return copy_to_user(out, &count, min(size, 4u)) ? -EFAULT : 0;
>  	}
> -	case AMDGPU_INFO_TIMESTAMP:
> +	case AMDGPU_INFO_TIMESTAMP: {
> +		PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, pm);
> +
> +		ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +		if (ret)
> +			return ret;
> +
>  		ui64 = amdgpu_gfx_get_gpu_clock_counter(adev);
>  		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
> +	}
>  	case AMDGPU_INFO_FW_VERSION: {
>  		struct drm_amdgpu_info_firmware fw_info;
>  
> @@ -906,6 +913,12 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  		if (info->read_mmr_reg.count > 128)
>  			return -EINVAL;
>  
> +		PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, pm);
> +
> +		ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +		if (ret)
> +			return ret;
> +
>  		regs = kmalloc_array(info->read_mmr_reg.count, sizeof(*regs),
>  				     GFP_KERNEL);
>  		if (!regs)
> @@ -940,6 +953,13 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  		uint64_t vm_size;
>  		uint32_t pcie_gen_mask, pcie_width_mask;
>  
> +		/* The clock limits are only available while the SMU is up. */
> +		PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, pm);
> +
> +		ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +		if (ret)
> +			return ret;
> +
>  		dev_info = kzalloc_obj(*dev_info);
>  		if (!dev_info)
>  			return -ENOMEM;
> @@ -1167,6 +1187,12 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  		}
>  	}
>  	case AMDGPU_INFO_SENSOR: {
> +		PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, pm);
> +
> +		ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +		if (ret)
> +			return ret;
> +
>  		if (!adev->pm.dpm_enabled)
>  			return -ENOENT;
>  

