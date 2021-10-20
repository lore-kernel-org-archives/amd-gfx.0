Return-Path: <SRS0=xYMq=PI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FDEC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 06:52:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1926661074
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 06:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1926661074
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA3D36E214;
	Wed, 20 Oct 2021 06:52:18 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D05E96E214
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Oct 2021 06:52:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHYsoePcTFeXXEzjsvZzJAzFGDwDCGbCaaewx/zfTjhj2+bBRBsXCW9xmbFoWq+/HkT4GWZRsg8juZ4ZXptQaeSYHYeq7XENf0V301uq7U25veYbfbHtE8lMYBgnerKIHxfHQaazMWoE4ZLrmO+bnVh+cV4JHOWIZJ6XsW/YyPmrQJ3lkP0f7cgw9reIXHd+KVDOH+tlAkCCASG0kLtQjUPnXJUsY7Zl0ZejbLLPU8a1lav+xm7j9yyg7U5RO23vpKCv16zWtwrFRqu7Kbkd9xIiN1KC9GLJhL1KXMUhNkS6jt0NHfoxpDbfYgyPPTE3GXsd8fmIze773xmntllNdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAz0dOMa0/4Yy8Gxep5QQhcBHzP631pC85dKOLs/WGw=;
 b=MvKuVKUjCDEJmXLVpfelNq7Tyzn47Sx3IdwTrKNHjNCu69IDZWDShkgbJkgT+pgmHVotlBI5/Cg5IKMqTvYF37iBdMTP7d0SKfPrpwL28bW4HDoJ6woUylqOx8APDyFbB870dNOROCgMMPlIxBPw3V6W4orCuepGizxCLp3SdMuHqeUbqct75VKrcBHG3dOam4fk1pFvEF4oL1erKWJ5MYqMyQl0ODcV6fer85i/uCVWP2FJXwcmKX0BrH8lyzRbHuZBwbZySyWxUsL6NvGFOWrsAOABDG6pdZ0BJ2QjufGLZZtVdh+1+BO8do3Jw4ULRshgGWc8kUQU3WHbpYKQWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAz0dOMa0/4Yy8Gxep5QQhcBHzP631pC85dKOLs/WGw=;
 b=BSYGUHqKrqkPr7kKCNKUhUqZ2i0Xb0oZqLngPpqmToqh81vRUNQeRHx9igxPlupfEuW7xt8kvwXhQeF/k0NSj7EJvQT1EbU+/bDdY+pv57NmDq2YMF+QFC+HMs2Jf+rLdjKUQ9m4MCCWbABqLQbnAW6z86RUd/kdAVpWl120Es8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MW2PR12MB2553.namprd12.prod.outlook.com
 (2603:10b6:907:9::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Wed, 20 Oct
 2021 06:52:16 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::55c7:6fc9:b2b1:1e6a]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::55c7:6fc9:b2b1:1e6a%10]) with mapi id 15.20.4608.018; Wed, 20 Oct
 2021 06:52:16 +0000
Subject: Re: [PATCH v2 3/3] drm/amdgpu: recover gart table at resume
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Cc: andrey.grodzovsky@amd.com
References: <20211019181449.12356-1-nirmoy.das@amd.com>
 <20211019181449.12356-3-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <e80e95fa-5acc-1cc4-dc38-14c7469144a8@amd.com>
Date: Wed, 20 Oct 2021 08:52:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211019181449.12356-3-nirmoy.das@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM5PR1001CA0031.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:2::44) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:6048:8836:7968:5df6]
 (2a02:908:1252:fb60:6048:8836:7968:5df6) by
 AM5PR1001CA0031.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:2::44) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18 via Frontend
 Transport; Wed, 20 Oct 2021 06:52:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84896fd4-9f26-45b0-e161-08d9939626f4
X-MS-TrafficTypeDiagnostic: MW2PR12MB2553:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2553C35439FF9F44FDC8C85383BE9@MW2PR12MB2553.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +fRpYCwFBe5FiCwMcwWEVkEANRw8gQayHObwC6t62jjgOe+B46ZSqqPl0XrTThG7AHboROEKGBJpiGzi48QCBRU1buUD4Vy6XQcAexvGITXgkfYIr5/hMHzWrBQnlOM2MZ/uDgXdqqmubn64HQkcXqWnqulp4u0Tq5KChhBjsXhPtaUPDstTKP6aNK4Dts9mXOeY12mHMvliUik+FObBjmDAYT9ql2EQdUS4u6uZaxkjBQZRX9CnAwB6X9qg+PsjPkkzJlQR8cif2jbavyJVxML2Q6Q3cFWSQ+E9brI8qCFRUsgTk2LZflibkU0JfNdS0HjxQQcJveYr69PnqT/exLCwfMUmZWt3BnKWNulebL25MyzrvcXKWjCBAxqNoHe9bckzMb8aWrdvAkb5eVnKz4KWIgmQzzBdmTZrOieMCcZ0yM5F6eh6lSoZJzki4AmHQzcrtY+BlmjtU8Lm2+ImSNYIeV0f/3NQnOQ5xkwWtk9Wre/MMyiRM6+KVd3CmbBdDvfFaKRCrWWBHjW4R3bn692Dar7yGvxxJwvVihPep7omQheJKZFQD0m7TRNfv6VmXRGGt8Xc0b5ZRgXxqOyaYxssrydz6eb/Jk4G3z1yC63hO9XsCijP57bWclAR3/9Xu32McWDFEX1tA9JSVKxzM6rqHX82yDtDM5RoOPEGPS8i8aj6zrFSwtqEFohfd7byBYVK6fvdA1bQNOx8dY4TLA+WM8K+cz19eGtoogK2Yweix/NVUuzBwL8yRPOGM70M
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6666004)(31696002)(2906002)(6486002)(66476007)(2616005)(5660300002)(31686004)(36756003)(83380400001)(316002)(38100700002)(86362001)(66556008)(508600001)(8936002)(66946007)(4326008)(8676002)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1lYY0NXSEVtOEFNUHdPWW9TZHc0UXFBTjNQZ0lZTGNHZXVHRFBBRVBhU2Fq?=
 =?utf-8?B?SjNnWnFZTWdCU2Y1V0ZSVlcwQkdScTlWdHFVNTVUTDZ2dm9ibVM4NFltVnVa?=
 =?utf-8?B?bE91MTRqMTRMVlFmL2U5RE91ZTdvZmhhTi9ZblRjUldTWitqaG5kUGRFUWpw?=
 =?utf-8?B?Zyt5c2o2MC9VSjh2cUlLNlh0ZUw3RmgxMFM3TWdSZ2ZORnJSK1p5WkxoSEFP?=
 =?utf-8?B?MG0rS0hGM1lRM2EzaUczMkxyTVE3ZDZCUy9BWnhtaE4rY3JoR0RNdkEvRXgz?=
 =?utf-8?B?NHBUNVRXdGQvTzZLSnlLaFVCR21PRmdPNmNiVmZqQlcwVVE5cytMVUFhcmY0?=
 =?utf-8?B?N2p3TFVJblRaZXlSR0FJWS9WeDFrQlNUSjNDS3UwWVdOWks3OXhBemFKbHlR?=
 =?utf-8?B?WDFMTnQvUXA2TVEvWjNQWFFqTnVSWmFJdFJPZGhURmY5MWwwRHRpT2ZiM1Vr?=
 =?utf-8?B?VWlMZ1RKdmROT0l1T1R6TElMWTFZRmF3ZExxVS9aM0lWU2ZrTmQvUVdLQ0oz?=
 =?utf-8?B?Qy9rY0xvNVR5cEdCQURnNWxjemkycWJMT05CQlFjWXlNZEdBQzFxeXZTNHlt?=
 =?utf-8?B?SDVtU2ZwRnFxeGk5NGxka0dIN3d2UzREZXNGM0h2cHI1cGcrNk45WVBpSmND?=
 =?utf-8?B?NVlGblJQYThreEhMSWJML3hzZnQ1aDFxcE1ld1UxTWhpNlVURURPMkRlOSt2?=
 =?utf-8?B?cWRBVjJyV2tYaHNkTEJ1c09qNC9OUXl1Z1AvRnk1QThqRnVwb1J6M3BicjlR?=
 =?utf-8?B?UGhDT3kvMHZFSGd3RktETDd5ZjJNb0VJOFhiSW9EMGJ5WTN5TDJnaTk0aGxy?=
 =?utf-8?B?cmNpUUFuV3BQcDdzc1M4OE9UZU5HRDBPcExqRk9UZVBxL0VWaVpXQTJmejhD?=
 =?utf-8?B?eFFZYkRFd1BEM01oUEkxNXg2ODRLMU8yVDZjWXFnQjFmYmNGOUhXQjVEMGx4?=
 =?utf-8?B?UlVMckNrWEIzVmwrNHhEelFBOHIxdFpiek1MWHlwMTRpeERjWWZBNDZyMU9L?=
 =?utf-8?B?bHo2eDkzbXVYQmJuRFhkU3l0aU1FVUx2eFVpSXNvelBRV2pySmdZRkxESFFB?=
 =?utf-8?B?RlRoVGR4WEpic2twdmVqcEk2ZWdIazRBT0VmMEFrMzU3WDNvcHIyR3lndEpF?=
 =?utf-8?B?STlDRFIyQlRQMlR6dVZvSkZkWklsRktpaWNVdHJvSGZ4U0ZaK21xcHF2czdX?=
 =?utf-8?B?TklJTWtTSXZXVGJ2OExuY1VGcFJLbkpzSWZVL0pBcnRaQ1FTR2tLaUhuMjdC?=
 =?utf-8?B?NGx6MC9uZFVKQUVVWkUrQUFZd2ttMGFQbVI2RHlzWlFCbDhjdVkwVHdYWUIr?=
 =?utf-8?B?aE81cWVBZy85dS9LbmFoa3J3bW1FRW9vNDNpQUphaFluZHpsZjRRanF1eWpM?=
 =?utf-8?B?T21iZ1pqeG93cUcrL3NXRTFPTmFvaFZMYi8wQnAvMmFHQUswV1JaMXZONkE2?=
 =?utf-8?B?RG14K2hUdXJFaE1CL212Z3d2T0ZmNE91R1dheE40SkYxeGhXUWVtTlZtZ0RV?=
 =?utf-8?B?S0RlR24wYkxNM1NRSTlsTWVNZk42aXgvcGdPcnNuMkJmL1BYWDJlVjVIQnZE?=
 =?utf-8?B?TUlBWHlWRTZHcWVvTXNMTkpTcXYrSW1LWWZLdDV3T09hYnExWXlxZHp5Zmhm?=
 =?utf-8?B?L2NGSmhlZ3NXeTRVN2NDS2xYVXJKT2xQTWllYzNoSUkxMTVobm1QK3pxbkc2?=
 =?utf-8?B?MzRNQjc4UWZkRklXTW9OWk1NcVF5ckt5Nk04K0pzMVlzbFFvZVZmUjhvYjBm?=
 =?utf-8?B?bVZDM1JLQ0c4R2tzK3I0RzFwdTJOaEcvVmpJdzJDbCtPUGNtOURYeW5ta0pX?=
 =?utf-8?B?T01nSnlwdFdEaExQbHJFaGIrS0NDSG9pc2wyMWVjSHd5azB3OWhTTW1KTjV6?=
 =?utf-8?Q?XrUB4Z7XHnwBw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84896fd4-9f26-45b0-e161-08d9939626f4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 06:52:15.9155 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PdPJRUQjqxH2zNeiGTiTFq7DGAvpg3eIrTlSuL6nGQjAyOSfnDciR9tGwwZ6pv+P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2553
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

Am 19.10.21 um 20:14 schrieb Nirmoy Das:
> Get rid off pin/unpin of gart BO at resume/suspend and
> instead pin only once and try to recover gart content
> at resume time. This is much more stable in case there
> is OOM situation at 2nd call to amdgpu_device_evict_resources()
> while evicting GART table.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c   | 42 ++++++++++++----------
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     |  9 ++---
>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      | 10 +++---
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      | 10 +++---
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  9 ++---
>   6 files changed, 45 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5807df52031c..f69e613805db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3941,10 +3941,6 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
>   	amdgpu_fence_driver_hw_fini(adev);
>
>   	amdgpu_device_ip_suspend_phase2(adev);
> -	/* This second call to evict device resources is to evict
> -	 * the gart page table using the CPU.
> -	 */
> -	amdgpu_device_evict_resources(adev);
>
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> index d3e4203f6217..97a9f61fa106 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> @@ -107,33 +107,37 @@ void amdgpu_gart_dummy_page_fini(struct amdgpu_device *adev)
>    *
>    * @adev: amdgpu_device pointer
>    *
> - * Allocate video memory for GART page table
> + * Allocate and pin video memory for GART page table
>    * (pcie r4xx, r5xx+).  These asics require the
>    * gart table to be in video memory.
>    * Returns 0 for success, error for failure.
>    */
>   int amdgpu_gart_table_vram_alloc(struct amdgpu_device *adev)
>   {
> +	struct amdgpu_bo_param bp;
>   	int r;
>
> -	if (adev->gart.bo == NULL) {
> -		struct amdgpu_bo_param bp;
> -
> -		memset(&bp, 0, sizeof(bp));
> -		bp.size = adev->gart.table_size;
> -		bp.byte_align = PAGE_SIZE;
> -		bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
> -		bp.flags = AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
> -			AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
> -		bp.type = ttm_bo_type_kernel;
> -		bp.resv = NULL;
> -		bp.bo_ptr_size = sizeof(struct amdgpu_bo);
> -
> -		r = amdgpu_bo_create(adev, &bp, &adev->gart.bo);
> -		if (r) {
> -			return r;
> -		}
> -	}
> +	if (adev->gart.bo != NULL)
> +		return 0;
> +
> +	memset(&bp, 0, sizeof(bp));
> +	bp.size = adev->gart.table_size;
> +	bp.byte_align = PAGE_SIZE;
> +	bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
> +	bp.flags = AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
> +		AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
> +	bp.type = ttm_bo_type_kernel;
> +	bp.resv = NULL;
> +	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
> +
> +	r = amdgpu_bo_create(adev, &bp, &adev->gart.bo);
> +	if (r)
> +		return r;
> +
> +	r = amdgpu_gart_table_vram_pin(adev);
> +	if (r)
> +		return r;
> +

Instead of all this you should be able to use amdgpu_bo_create_kernel().

>   	return 0;
>   }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 3ec5ff5a6dbe..75d584e1b0e9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -992,9 +992,11 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
>   		return -EINVAL;
>   	}
>
> -	r = amdgpu_gart_table_vram_pin(adev);
> -	if (r)
> -		return r;
> +	if (adev->in_suspend) {
> +		r = amdgpu_gtt_mgr_recover(adev);
> +		if (r)
> +			return r;
> +	}

Please drop the in_suspend check here.

If I'm not completely mistaken the GTT domain should already be 
initialized here and if it's not then we can easily check for that in 
amdgpu_gtt_mgr_recover.

Christian.

>
>   	r = adev->gfxhub.funcs->gart_enable(adev);
>   	if (r)
> @@ -1062,7 +1064,6 @@ static void gmc_v10_0_gart_disable(struct amdgpu_device *adev)
>   {
>   	adev->gfxhub.funcs->gart_disable(adev);
>   	adev->mmhub.funcs->gart_disable(adev);
> -	amdgpu_gart_table_vram_unpin(adev);
>   }
>
>   static int gmc_v10_0_hw_fini(void *handle)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index 0a50fdaced7e..02e90d9443c1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -620,9 +620,12 @@ static int gmc_v7_0_gart_enable(struct amdgpu_device *adev)
>   		dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
>   		return -EINVAL;
>   	}
> -	r = amdgpu_gart_table_vram_pin(adev);
> -	if (r)
> -		return r;
> +
> +	if (adev->in_suspend) {
> +		r = amdgpu_gtt_mgr_recover(adev);
> +		if (r)
> +			return r;
> +	}
>
>   	table_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
>
> @@ -758,7 +761,6 @@ static void gmc_v7_0_gart_disable(struct amdgpu_device *adev)
>   	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
>   	WREG32(mmVM_L2_CNTL, tmp);
>   	WREG32(mmVM_L2_CNTL2, 0);
> -	amdgpu_gart_table_vram_unpin(adev);
>   }
>
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 492ebed2915b..dc2577e37688 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -837,9 +837,12 @@ static int gmc_v8_0_gart_enable(struct amdgpu_device *adev)
>   		dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
>   		return -EINVAL;
>   	}
> -	r = amdgpu_gart_table_vram_pin(adev);
> -	if (r)
> -		return r;
> +
> +	if (adev->in_suspend) {
> +		r = amdgpu_gtt_mgr_recover(adev);
> +		if (r)
> +			return r;
> +	}
>
>   	table_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
>
> @@ -992,7 +995,6 @@ static void gmc_v8_0_gart_disable(struct amdgpu_device *adev)
>   	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
>   	WREG32(mmVM_L2_CNTL, tmp);
>   	WREG32(mmVM_L2_CNTL2, 0);
> -	amdgpu_gart_table_vram_unpin(adev);
>   }
>
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index cb82404df534..732d91dbf449 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1714,9 +1714,11 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
>   		return -EINVAL;
>   	}
>
> -	r = amdgpu_gart_table_vram_pin(adev);
> -	if (r)
> -		return r;
> +	if (adev->in_suspend) {
> +		r = amdgpu_gtt_mgr_recover(adev);
> +		if (r)
> +			return r;
> +	}
>
>   	r = adev->gfxhub.funcs->gart_enable(adev);
>   	if (r)
> @@ -1793,7 +1795,6 @@ static void gmc_v9_0_gart_disable(struct amdgpu_device *adev)
>   {
>   	adev->gfxhub.funcs->gart_disable(adev);
>   	adev->mmhub.funcs->gart_disable(adev);
> -	amdgpu_gart_table_vram_unpin(adev);
>   }
>
>   static int gmc_v9_0_hw_fini(void *handle)
> --
> 2.32.0
>

