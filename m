Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 952DFFED2F6
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2026 09:22:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3315A10E9CE;
	Thu, 12 Mar 2026 09:22:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vCH5q3i9";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011028.outbound.protection.outlook.com [52.101.52.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9262010E9CE
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 09:22:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s0XCJx1+nsCZQFfRTPhyHq5pK2hWHNw7/yx3mFjAzMGnIs5z1hMBLvjLjM/wHAGniCMH8BwnLoEYHuVByh+D2HpxijLBWJ4hr/0TkaUnD/g3tjmhdLObI090VnhBTzmtiff4GPaPmeuG3YdMMPTp5RvLB8IexFZ03bSk4WtF0+w7lWKGc8/xxKb5UlHmSNIDt8KvjISU7t+fswP4v+I7fZeCRc4gW1q3sYgh931OVPJfyqmM5WPAfPW/YI2/sCc4aMGenI2Sxd0MdrGGPorWYNK4YBYullNlCf5LjqRxxcmMVLxOqVpAZcxdxi7id+3cD0txwSzSV67WULUvCAb2iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBWY94FUVGmQth/Uqn0vMD0BmqOCOY5Sd0OgO2TCVEI=;
 b=sY91rfv6w7iWsAF1qg+MujnH6uWLVTvzws0tdDnPu2b4DzS9i1Fu3lcboHZQFybpK4WARFyoL4ez75TsYOXPJ/C2igss44T0Vj9gMld9DXb1YPM0DiSx3B4riAMpr6m6+UrrR6uGHoCPUBIj1ii2ySCa+/UJ1uYuFIP1wEFcGy+VQLQ1uuWFOGhn7DhyBMWfC1JNUc9op9Bv+UmRvMri3+8jNvUAWbw8HRw4G0hzBimKPub32LuyuscCD2EXxZEAiGr+He6Gy3DHVVhfi5CkH1sNvUuGl7wduysdZqV7eXK0O2ZHd28xRUuDDLpSrJfT969mSpmxthio2cqBcBLfEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBWY94FUVGmQth/Uqn0vMD0BmqOCOY5Sd0OgO2TCVEI=;
 b=vCH5q3i9LRLpsmJc02XgJNDQP6BCkw1pzlvCrhvi8s8Js4w/sejxWaigeKPAi2+dY/DUkbjbwP9DkEBRaaHiN5cRVB7u2c0oqc425KJgp8wFns2aJsH0rOAy5NdtceXioMefxrZSu9vQJNWeZgV5Usz4Vx5DPvwQLofWdpKGcO8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by IA0PR12MB8694.namprd12.prod.outlook.com (2603:10b6:208:488::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 09:22:36 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9723.000; Thu, 12 Mar 2026
 09:22:35 +0000
Message-ID: <96ede71f-1438-4cf2-ac61-3dcab09f54c3@amd.com>
Date: Thu, 12 Mar 2026 14:52:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Drop unreachable return in
 amdgpu_reg_get_smn_base64()
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Dan Carpenter <dan.carpenter@linaro.org>,
 Hawking Zhang <Hawking.Zhang@amd.com>
References: <20260312085222.1834845-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260312085222.1834845-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0009.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:176::13) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|IA0PR12MB8694:EE_
X-MS-Office365-Filtering-Correlation-Id: 6528616e-f03c-4cf0-5a4f-08de8018e5c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: GmRS+0P41u84kUChT4ce1Tp1cygLdlWtJBXO7dGP8V/HPa97miAULEkPBnFL55E4W+iV0L2sSZydRcLJxj1SzdF7gVuwJjRxbr1r0MfQhNZl6ri1rxcYKmLeg0tgIhpHgnrajIOIOZBijUoRmLLMosDshsFxD2aK0pr6fk1pZ9w5VNETDNOqLZlJPkfVvRyWzzDDPPg/CFLDR8eBDyDHHBlraOY9PSSp0S4I/O4eyjpCBM+9HdwY61VgA+oZ+UIb8I11pnvuhpymjv6Rt9UpA1LG09knChl4si51oAguWC5KEjDaQOYAXuS2fy/9yD5Pt/CH93FLu4fedCiCPE9gMAzelPh4Aka1DNs5KC7GKy71gvq4sUjBfEvqGDavCSfBONHIBQdw0NNdBt8Ua6u43HP/ldMeZSsWSwsM4ClyYbfeZvSHKUYO//598hfDVmylqCrl+crxHItHg+LAkC5hoHGoDy+et1aDsz93R3kiPEtVp8HOKHS7y1boCvL0bxoMMyfSEz1plwu5OGZX36b6rSbj6RJJtpClBcxelfgeYwCB5LTfK9JFqVwTjb8yJA+xYbzIdJ4+u9fkYw04cFZKmOoRkcRpRh69652Xa2OJuQxM2nfmyzxI3M4Pv604OSO00JeggCJIDlrtMIGRCcMXAjvx2mmkzmEypNB19CI4xjgqk/7QfmcgV66Brcd9VI+BnrUQuGg2WO4BDFBOA1P5Jud5Q/2h5XjxdUaucXdtbAw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3g0RjYyakpzUDRzbXRlWmJ2QzZOUGVjbFFOallUeEFaQkdVMDNsRWlFcTlH?=
 =?utf-8?B?djNhWVBnTmJLRDZ2ckhXM2prK3NGWmtybEZ3amhrQktKeUdhQkRhaFVXTHli?=
 =?utf-8?B?UFVJWFAyRW5rK1ozdUxLTUxzS3E0ZEtUd3JrZHJzMFNMeWh2Ymg5aFNLdjlT?=
 =?utf-8?B?QjFqcFZQQUFwNXdWdU1iVGt3eklROHlJcGhGQXErUkRPbXVRRWEwNXUrRHk3?=
 =?utf-8?B?UGNUT2dNNEZoRHplNUZEZFFuVEs1M0RycWxhaVFGak1CNWtMNHkyL1lRLzFI?=
 =?utf-8?B?YTVMd2tBNXJYZisrUGk5Q3FMenZmamttYW5aZUtkOHkySlRlWHFTNStPakpz?=
 =?utf-8?B?UmN4eTNxV2c1MHd3MlhCU0dYZXBCb2g5ZEhmSkhTbjYvRWlkc0RYaVJJY2lC?=
 =?utf-8?B?YjJPRWNSZkFGVWlXZXdQbER2aVpoc2lGOEpxcHZlRnc0bjBOQWEzK0ZHcG5I?=
 =?utf-8?B?Q3NOTHhxeE9hMzlSbGkxeDZrbi9aRjlMR3NhVmRTY2NCdnBSWTJOczdkQ1VG?=
 =?utf-8?B?YlBTVDNVMlh2eHM3cWxxNDdtaW5TRHlRR0Z5ZVMwTUQzWHJEUjllYjNzOGFt?=
 =?utf-8?B?QmlydnVzS1M5TmNhUTNuZDV3Vm85YWVOS0ZEMjNJRG9YdUZMNlFxOUlEejR1?=
 =?utf-8?B?YnMrSkVMZEhFTDFiSmJ5MTVzWkNScmthanhBQ3BaSmJSbmJhYzVkczAxc1ND?=
 =?utf-8?B?dlBPQlUwMGZqb0EybEZOK0dXL1JWaWZSNFRXYURQWWNaVEp3NW9vT0J3Vkgw?=
 =?utf-8?B?NTBFdHZCMkFuYXBlNWZybjYwNjJhMjhldUphYmhjQ0VGTy9tY2xRWTBNSjMr?=
 =?utf-8?B?SjRLN0Mxd3Q3NFdWblBramhzSGdKL3NCMDFndW90UUU1YURMQXZZdXl0U2hs?=
 =?utf-8?B?VnYxNGpjTUI3dGVPV2licFBQeXBoYVV4UWNWMEJJcDlqWXoxU0I1Qk1yakh4?=
 =?utf-8?B?RzFHTXRlYzNTaTc0bzVscHdwQVk3b2hTZXJ0MEJPQytPaFFUV1EraWJ4aCty?=
 =?utf-8?B?Uzg5S3E2TE9oWnQ5WjZGdnZPM2d0cUxPRFh6N0ZLRDh6Q0NzTXI0L0hFSVd0?=
 =?utf-8?B?WHNBcUVoaGlnZ0VBa0FQNW4wNWhudjBjSGlIOStLcDVka0JDWDBmYUM3bzRR?=
 =?utf-8?B?YkV5S2dNaE5weklqUk5YTmM1UUNCd1lZelZSUndzdVh3aHpsQ1NDZytpeUFO?=
 =?utf-8?B?Zk9OZlVnTzVMelpjamxpUTlKMEtsclp2TFNIVTY4NGlEQzlRbnNsZkJJN1k2?=
 =?utf-8?B?NlpjTXlnZVhUcUNkeWVZdHVzZ015d1NqZGxERnJUc0RoY01HSjB4cXE4VmY5?=
 =?utf-8?B?MTB4OHFnZ0FIYllkTzVybkRJc0ZiK05RNHlKYWJOcW92TWZHYUcyNXUzSFJh?=
 =?utf-8?B?NHVxS2JMRGkzYXVpVkFkUjJaV2d3QmM0TUtlbHFuT01aT3htSlNNbWNid0oy?=
 =?utf-8?B?bmFXb3JuUWozSU1jbjhUdmVKVjlzNmpacHdYalRQekRJYU1BejRUQWYwN0lT?=
 =?utf-8?B?N1FQUjRSQ0tXRmhtQlNxQ2RaVjNrQ0YvZ1lleFUxM1V0eWVrVktFMk1mT2d4?=
 =?utf-8?B?aXRpaHZzQzlxS0FPZUNjUkszN1J1UHJBT1FGa0wxZmlCd212eTFXem5JUzhH?=
 =?utf-8?B?Y0FuaERkcXRYQXZqcnM4N010VE1HZmgzVU54OGl3SG5rUWp0OGlQOGZuT0wr?=
 =?utf-8?B?SEpXbXAwcHZNTFp4SFlwN2ZheFdkUmh5MGR6WWp6UnBSUExFOWUvdEE1T21l?=
 =?utf-8?B?TENyVi83M3V5MHpjQmtPMVc5bmQ5SFlwWTljV08yQWxjcWVWa29JRGx3UWJP?=
 =?utf-8?B?UnAyTnM0M2NHV3ByV2FaQjlnbVlHeDRtRmZjN0ZWZ0lEeXJzWE5uN21ULzRS?=
 =?utf-8?B?Z0NkZXNxNDVVb1l3eEhJR2NjWnFObmZoV1hpbTljYjhYME0zRktXWkh3cENj?=
 =?utf-8?B?enRBWmlXRDVmV0NZMGVMclpLTEs2dlNBT0JlMTNIVWo1Ung5L2liejJTV3FE?=
 =?utf-8?B?c3owRGp3MWpzeU96RklXNVZtSkF4SzA3MVAxTi9wUTloZXFJcDl1dXpVUy8r?=
 =?utf-8?B?SVF3WnV0M0lMMkFBVUhvN3NPb2R5ZWo3aTI3QUFyTDJMZ0k1azlpcnFDQmxs?=
 =?utf-8?B?LzNGdXFmSmtZT0tlTE4zTzZWTjM0ajY4dVI3ckdvY0FUNGdEdFMwVDFBUzJm?=
 =?utf-8?B?c1dHNVAwdnhUbnFEc29iS0F6bnBIeFdDZzNYYktpNWxoVmJGMTBCa0ZRam50?=
 =?utf-8?B?UTN0MjlRQk04QXRoQzluMXpZUjlNdDVrc29INkowSWk1UmhxdnBHRkc5OVh4?=
 =?utf-8?B?RkhyQ2ZEZnRzMzJiOTZwYUEvR3BDTXlVKzRSUzRocFYvdnZya3BrQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6528616e-f03c-4cf0-5a4f-08de8018e5c7
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 09:22:35.9282 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nPC9qqtWi6SnhAH2534bDesI/Za/9ptcs2wKPdUtk2fsd7fSuQE7vswMPO9+0fsZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8694
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



On 12-Mar-26 2:22 PM, Srinivasan Shanmugam wrote:
> amdgpu_reg_get_smn_base64() returns from all control-flow paths inside
> the !adev->reg.smn.get_smn_base fallback path.
> 
> For version == 1, the function returns the base address from
> amdgpu_reg_smn_v1_0_get_base(). For all other versions, the default
> switch branch emits a dev_err_once() and returns 0.
> 
> The trailing return 0 after the switch is therefore unreachable and is
> reported by Smatch as dead code:
> 
>    drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c:317
>    amdgpu_reg_get_smn_base64() warn: ignoring unreachable code
> 
> Remove the redundant return statement.
> 
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
> index bf8645390bdc..540040c76058 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
> @@ -314,7 +314,6 @@ uint64_t amdgpu_reg_get_smn_base64(struct amdgpu_device *adev,
>   				"SMN base address query not supported for this device\n");
>   			return 0;
>   		}
> -		return 0;
>   	}
>   	return adev->reg.smn.get_smn_base(adev, block, die_inst);
>   }

