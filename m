Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC32FF495E
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2026 14:08:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA20D10E1B4;
	Mon, 30 Mar 2026 14:08:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WQDsnVL/";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012003.outbound.protection.outlook.com
 [40.107.200.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E56EB10E1B4
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2026 14:08:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cQJvggZCWUgeMZf3kNDYiBpIIunlG1nZVfyYBoqMEDZSa6amrnnSrNIaYCrA2ygiRCgUjucKNIZ+4gna1OJVBdJIGDEORbUKtK+p9VK0uSQuyVPlLyTGjEftITE+LG8LJg9kGgNhYu3iLklA+6q8ydU8dN1wi88JoOMJjeRahA2aGy5IRrAHxHrlht8jG2ZTazOVDfNc12e6pRd6xk54Oq7RXU9v/ZDrU8Mm5jvKfowjX7WKUjebn0qa4uE0UaLx/mm9343+ko5U4RqkuJ7CteNgd/1AlQp4m9HOp/RWh/5jMXG/cwFbNBjWz4/xdru0wmsOEut6mSDlxXWLQJl6dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EoatUX/28r3xOFW1nFhwxhicCjBBeBakrVVcbtNc8lA=;
 b=b4Hc6ndNqEbB2RJ4KPXN443E0GkYTdDMZwXAbjLVsBQyvQJ6vP+cc75rKUDJiK/UgNvoemzn60ixwldICF6v1LMqEPhWHTIagSLd1iXNHVIs26+5zfhkewxRQOsYfxeXXwBzV1qCmiFda/2vmMrV1YpA6h2fpGCJJoCGKVi0zdJs0BA/lonfs63uDcgqeAjdWUa27XuaAFwZrAzL4H3dHMF01BLj2F6EUEVj2utS/sLZmWC8aNrS0me1i+3JfZ9YZk11JSvcWJKIW2vKFHkDAkv75eT5HLKddMABsvqqZ8YKI1VTCr1WMtbaGtB7QxU8pxlHipeN6suNx7CLlDZr+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EoatUX/28r3xOFW1nFhwxhicCjBBeBakrVVcbtNc8lA=;
 b=WQDsnVL/ZBMp01T+jh6th33/ThOylZl/piklPY6PJcvL/F3zBTY7cBHdlabU9fFPzG0ERUmyddO9C/6q5QV+tRublLQaSyE8OcSkclou67PQgNpJM8J5USPYaWD4sEvOiaxPI9sVKJgtLcRzbL+x+Ud8IdgIjBDDXYkz7zW/Rbk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB8036.namprd12.prod.outlook.com (2603:10b6:a03:4c1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 14:08:16 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 14:08:16 +0000
Message-ID: <7546c926-c316-4820-a6db-2d09cbe7bf81@amd.com>
Date: Mon, 30 Mar 2026 16:08:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: rework userq fence driver alloc/destroy
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20260327103621.3374979-1-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260327103621.3374979-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0241.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB8036:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fb661eb-8f0e-4d6c-ba02-08de8e65c98a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: kvDjeSZKCtDW7mJB4fmSlNB8gsJINXjPrWsWijZ9nG0qO+D593G4/L40Tgc8qwisrXAq5at4ccmFUIOpKDmiKYrS2cZyNY5rkl0afSRtNKDnW/QEsAGORKR3tflT3iavETwcYB2YmD5COFKaRWs7rT76rpXAYSh8+nvppeL/PBJMmL18hi9n8B8vkyNvu333ubhJO1698v0qjK9+pfXQvGiJpPSBQsE3MARWMBkx0JHfqW5xhJxVvPrgnwCgv6z9RE5o1PswFOVbnyUPxGyOstOmR1JXfFWiP84Ky4UMIDtDBcb1/xV49FR4YVTLtUblNqaixQdqc09ZmgxJWDj43/wUbDJmKgxoSG960PBNAcIJmdDhSEmQIGXFOWHIryBCaPEneJLL1tR0XG8srCUAxHq6TKbj5TAJU/RJVPR6siMIBXNr/0SkSCjTeE2rMiMP0aaeYVNpysgnZTWGOrytta7fSemiGnCfEUfFUEU4Pcn5h1Sl6emdjGRpunI5pupoffBOpZv5fSKs23mXiaLGaCyyL75PT1Z9Tkw7SZNNZiRFx2fOOmfJsHfbaKFtywof9ciZ+EQ/hK/5mlU4BaBiy0eFqeIeDxepKvooI3XCvmCM2ZsKPqQnjJQlBfk/9jUxstt9sOseQ+2LRiJHZrmFESnouy4AfEMwvRiD6Wv0cPquWd38tfeKILPetOg+6KmVuhzD+kz7kN5R2Ovr79Zg89WnngUy3AdjHyoPPm+TL+U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QW5ibk1GUW1KM3RXVkxZWFBlQks0UGxMVmN5VnppcjV0eTlJajBHWFQxUkNw?=
 =?utf-8?B?d3VCMERwTzBjZWlFUTJWU3R2aUNpTmFWQnYwTU1Fd1MyNVphYmUzVWlXcFNN?=
 =?utf-8?B?anVCQktWM3ZaM2o0UG9Ua0VmYlJOYlI1bzdOMUFwemkycWFDZ2xFRXNSNUIw?=
 =?utf-8?B?MktGSEwyR0haa09XUDNncjBJUnVFN1JvTmtmMUFuNmlzcnd0bm9GdHNRdjlU?=
 =?utf-8?B?MlY0R3BKRnowOGttTHBMRnV4L0RnQ3dRZ2VnMFZlNmloYTFMR1llY0xoalhV?=
 =?utf-8?B?NElmbHNhNDBGREV3djltaEdPdndMZWtKUDh5cThEQVc0ZXpUanRBVHljNmps?=
 =?utf-8?B?OUpHK2EvdGZScWxpK3lvaUplRHVNdjZnbTVsTWh4THdtR2M3U0wrNytwWDZ0?=
 =?utf-8?B?VUpjQnY3ZTJDUmxjMlloZEU4LzlWMmtCT2R4NlRXVnFmRGdaaGYyZkY0ZWhz?=
 =?utf-8?B?Z1pMZ1ZFL1c1RmZWYlRXOGV1U3Y4eFFWbFJFV2haZU5ISHJ0KzNHa2ZIbmdH?=
 =?utf-8?B?NGhsSWF0VytTMDYzeGRRdUFNRWR4MTVDS0VsOERYbWVCVkI4d29naXIwNEhF?=
 =?utf-8?B?WlRmOXBINFEyK1I3QUpXWE5LQVY1aXlqUGtMSGZnYml0UHZNOE00MmdWNEJX?=
 =?utf-8?B?QkVVb0k1TUxzZnc1SThveCtYOXMzYXdoZGVhQXFpQS8vSVhMaWZmN3BZT0xX?=
 =?utf-8?B?a0RMWEpETTNuTmUwVTlySmRQT3lUVWdFTVRTYWlmZElsNE9NaFpQeTh3Z2JD?=
 =?utf-8?B?RGVRN3gzM2VEM1lkY1E4TmRyOEc0UUd6SlhBU3hBaUFWU3puUHk5WkgxZStK?=
 =?utf-8?B?a1Q1SzhYQWdyNHdpYUxQWTU0U1E2eGlxQUkrZnRuYXllYzE1TnZ5NUVmT2kx?=
 =?utf-8?B?YUN6WHRERlVPQ0pjYVQ2eG9xWEQweWdUVGszTWVKODhDUHVLNlF3ajFWZ004?=
 =?utf-8?B?cWJsQWxpdjB1Z3RKaGdZQ2o4QXQrRDBCSGhtZW1ndU14RW5JSWxMaVZzUzRj?=
 =?utf-8?B?QVN1aHBvNVRDbDdTc2dNMW00d2xCSTZkeUlZV2FydVlMR002MWhJV3NyM3Fh?=
 =?utf-8?B?K1ZPcGYva3lLSUtBakEzZVVpSHZjWVVONWlsN2JoYmZ4TC9Cb2Q3UzZ0QSs1?=
 =?utf-8?B?WnJ6emhyWGVYMU04WVhVWmRVYmdDRlJncVQ1bk5lT1BPMVlRdWsyL016YWE2?=
 =?utf-8?B?ZGZkUjJ5cjJlSjRBSk56NkhLL3lNcHBPZWQwTkVhYnRMeUQzOWdxOTJGVkp0?=
 =?utf-8?B?Mjk4WS9TdW9EMVVuUVIxRlVpaXU3UWhGV3pwQzhaQ1J0bHg4UFk3NDFlaXJJ?=
 =?utf-8?B?aHRNZUxtdlk4dk1hT3hweGE3aGVDNXhiOFNjWVVLN3dYZXN0U1ZRUlpDNXpU?=
 =?utf-8?B?Sll2QkJ3emFCTWUxNjhveUtLSk5JR3p5UjVtK0hhZkdtK2tzamhHOE1zeEZO?=
 =?utf-8?B?MW5uMmtPTEJ4S1hmUGltcnhlTUpmQ0JEbmlNY0lob0dJQ0dwUkpmRTNnbnpn?=
 =?utf-8?B?VC9HYUp3R2RMam9qU2NQQmlnc2dCRkJ2UzcyUWNlb2t3S25LdUxOUEdhSjNF?=
 =?utf-8?B?dURSa0tUcG1nRmR3cG1sTStWNEJQcEczazZMK2RQanVRSjJ1YkNRNFhxMzVi?=
 =?utf-8?B?YmVuTCtIUDlFbnh2QVRqM05CTS9nTUFYdGNyUjJDZlNjTzlrdW9pVUM0QnBY?=
 =?utf-8?B?dmdRNzMrR055Y0ZSMGlVYzFyd0xhZklZejVnemRzMDhBK2NkZ2wvdHBZdm04?=
 =?utf-8?B?WGlWc1M4YjRYL1NFK0RnZnhTU0JLMVE5OW9JaW12M0RjbHJ2R2VxTVdsbHcy?=
 =?utf-8?B?dFhxc1lTcUJRc3BDb0VjRnptSXRiNmE5RFlxYy9NVVNFdUpGSk11aWExVitt?=
 =?utf-8?B?OCthcjdGcVkrekVXTkZvOWpWOTFObE84QmtjZjlPUmJHa1hmRTl0Q0pOU25z?=
 =?utf-8?B?L0xwSFRYSldJV1NjbmtCSXJEMUtpQUNzOTBCaXRra2ovbjJDK3d1TmJ5d1lx?=
 =?utf-8?B?MFNUZXBlTzJZbzJ5d0Exd2M4aXIvbzlxcUIwUTlOaTZSUzZpd2srMTkxTWVa?=
 =?utf-8?B?RTRFdkFwMmxsaEVCR21PYWlRM2puaVBDem9rWnVpNXVoT0d3dFlvOGZwUE5J?=
 =?utf-8?B?ektranJQL1VRbFdoQ2MyQUtIa0V4LzBwWmdHOVFhTk1rTTQ1UXZPUVhzVVpG?=
 =?utf-8?B?ZjZVNGhvTFRxR0FVNkFuQ0d4MzJMT2RZdU5aUlUwd2tjQ05MejEwdmJCL09W?=
 =?utf-8?B?dTdpSUlmMlJtNWFnYnBhUGd4NUFxNlNYVWpUMWliSDFWWTduZy9JbzliMTV0?=
 =?utf-8?Q?OdVh9HEm1ozzA986MQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb661eb-8f0e-4d6c-ba02-08de8e65c98a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 14:08:15.9974 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJsdp+SPj94KBf2mvNMVzriVj/1gQgpyQ2nHXycPg029IuBvplOzO4ZCrE4PsSnZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8036
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

On 3/27/26 11:36, Prike Liang wrote:
> The correct fix is to tie the global xa entry lifetime to the
> queue lifetime: insert in amdgpu_userq_create() and erase in
> amdgpu_userq_cleanup(), both at the well-defined doorbell_index key,
> making the operation O(1) and resolve the fence driver UAF problem
> by binding the userq driver fence to per queue.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  5 -----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  4 +---
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 20 +------------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 10 +++++-----
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        | 10 +++++-----
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c        | 11 +++++-----
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        | 10 +++++-----
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        | 10 +++++-----
>  8 files changed, 28 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 49e7881750fa..8bc591deb546 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1045,11 +1045,6 @@ struct amdgpu_device {
>  	struct amdgpu_mqd               mqds[AMDGPU_HW_IP_NUM];
>  	const struct amdgpu_userq_funcs *userq_funcs[AMDGPU_HW_IP_NUM];
>  
> -	/* xarray used to retrieve the user queue fence driver reference
> -	 * in the EOP interrupt handler to signal the particular user
> -	 * queue fence.
> -	 */
> -	struct xarray			userq_xa;
>  	/**
>  	 * @userq_doorbell_xa: Global user queue map (doorbell index → queue)
>  	 * Key: doorbell_index (unique global identifier for the queue)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 0c0489395edf..a7b519f670a5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3757,15 +3757,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  	spin_lock_init(&adev->virt.rlcg_reg_lock);
>  	spin_lock_init(&adev->wb.lock);
>  
> -	xa_init_flags(&adev->userq_xa, XA_FLAGS_LOCK_IRQ);
> -
>  	INIT_LIST_HEAD(&adev->reset_list);
>  
>  	INIT_LIST_HEAD(&adev->ras_list);
>  
>  	INIT_LIST_HEAD(&adev->pm.od_kobj_list);
>  
> -	xa_init(&adev->userq_doorbell_xa);
> +	xa_init_flags(&adev->userq_doorbell_xa, XA_FLAGS_LOCK_IRQ);
>  
>  	INIT_DELAYED_WORK(&adev->delayed_init_work,
>  			  amdgpu_device_delayed_init_work_handler);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 6b33c2428b2d..87560c1251d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -81,7 +81,6 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
>  				    struct amdgpu_usermode_queue *userq)
>  {
>  	struct amdgpu_userq_fence_driver *fence_drv;
> -	unsigned long flags;
>  	int r;
>  
>  	fence_drv = kzalloc(sizeof(*fence_drv), GFP_KERNEL);
> @@ -104,19 +103,10 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
>  	fence_drv->context = dma_fence_context_alloc(1);
>  	get_task_comm(fence_drv->timeline_name, current);
>  
> -	xa_lock_irqsave(&adev->userq_xa, flags);
> -	r = xa_err(__xa_store(&adev->userq_xa, userq->doorbell_index,
> -			      fence_drv, GFP_KERNEL));
> -	xa_unlock_irqrestore(&adev->userq_xa, flags);
> -	if (r)
> -		goto free_seq64;
> -
>  	userq->fence_drv = fence_drv;
>  
>  	return 0;
>  
> -free_seq64:
> -	amdgpu_seq64_free(adev, fence_drv->va);
>  free_fence_drv:
>  	kfree(fence_drv);
>  
> @@ -187,11 +177,9 @@ void amdgpu_userq_fence_driver_destroy(struct kref *ref)
>  	struct amdgpu_userq_fence_driver *fence_drv = container_of(ref,
>  					 struct amdgpu_userq_fence_driver,
>  					 refcount);
> -	struct amdgpu_userq_fence_driver *xa_fence_drv;
>  	struct amdgpu_device *adev = fence_drv->adev;
>  	struct amdgpu_userq_fence *fence, *tmp;
> -	struct xarray *xa = &adev->userq_xa;
> -	unsigned long index, flags;
> +	unsigned long flags;
>  	struct dma_fence *f;
>  
>  	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
> @@ -208,12 +196,6 @@ void amdgpu_userq_fence_driver_destroy(struct kref *ref)
>  	}
>  	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
>  
> -	xa_lock_irqsave(xa, flags);
> -	xa_for_each(xa, index, xa_fence_drv)
> -		if (xa_fence_drv == fence_drv)
> -			__xa_erase(xa, index);
> -	xa_unlock_irqrestore(xa, flags);
> -
>  	/* Free seq64 memory */
>  	amdgpu_seq64_free(adev, fence_drv->va);
>  	kfree(fence_drv);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 78d1f3eb522e..c0921977b853 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6488,14 +6488,14 @@ static int gfx_v11_0_eop_irq(struct amdgpu_device *adev,
>  	DRM_DEBUG("IH: CP EOP\n");
>  
>  	if (adev->enable_mes && doorbell_offset) {
> -		struct amdgpu_userq_fence_driver *fence_drv = NULL;
> -		struct xarray *xa = &adev->userq_xa;
> +		struct amdgpu_usermode_queue *queue = NULL;

Please drop initializing the local variables to NULL, we have automated checkers which complain about that.



> +		struct xarray *xa = &adev->userq_doorbell_xa;
>  		unsigned long flags;
>  
>  		xa_lock_irqsave(xa, flags);
> -		fence_drv = xa_load(xa, doorbell_offset);
> -		if (fence_drv)
> -			amdgpu_userq_fence_driver_process(fence_drv);
> +		queue = xa_load(xa, doorbell_offset);
> +		if (queue)
> +			amdgpu_userq_fence_driver_process(queue->fence_drv);
>  		xa_unlock_irqrestore(xa, flags);
>  	} else {
>  		me_id = (entry->ring_id & 0x0c) >> 2;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index a418ae609c36..d4faceab8f88 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -4854,14 +4854,14 @@ static int gfx_v12_0_eop_irq(struct amdgpu_device *adev,
>  	DRM_DEBUG("IH: CP EOP\n");
>  
>  	if (adev->enable_mes && doorbell_offset) {
> -		struct amdgpu_userq_fence_driver *fence_drv = NULL;
> -		struct xarray *xa = &adev->userq_xa;
> +		struct xarray *xa = &adev->userq_doorbell_xa;
> +		struct amdgpu_usermode_queue *queue = NULL;

Same here and maybe other places I might have missed.

Apart from that looks really good to me.

Regards,
Christian.

>  		unsigned long flags;
>  
>  		xa_lock_irqsave(xa, flags);
> -		fence_drv = xa_load(xa, doorbell_offset);
> -		if (fence_drv)
> -			amdgpu_userq_fence_driver_process(fence_drv);
> +		queue = xa_load(xa, doorbell_offset);
> +		if (queue)
> +			amdgpu_userq_fence_driver_process(queue->fence_drv);
>  		xa_unlock_irqrestore(xa, flags);
>  	} else {
>  		me_id = (entry->ring_id & 0x0c) >> 2;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> index db49582a211f..642ddd9473cb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -3643,14 +3643,15 @@ static int gfx_v12_1_eop_irq(struct amdgpu_device *adev,
>  	DRM_DEBUG("IH: CP EOP\n");
>  
>  	if (adev->enable_mes && doorbell_offset) {
> -		struct amdgpu_userq_fence_driver *fence_drv = NULL;
> -		struct xarray *xa = &adev->userq_xa;
> +		struct xarray *xa = &adev->userq_doorbell_xa;
> +		struct amdgpu_usermode_queue *queue = NULL;
>  		unsigned long flags;
>  
>  		xa_lock_irqsave(xa, flags);
> -		fence_drv = xa_load(xa, doorbell_offset);
> -		if (fence_drv)
> -			amdgpu_userq_fence_driver_process(fence_drv);
> +		queue = xa_load(xa, doorbell_offset);
> +		if (queue)
> +			amdgpu_userq_fence_driver_process(queue->fence_drv);
> +
>  		xa_unlock_irqrestore(xa, flags);
>  	} else {
>  		me_id = (entry->ring_id & 0x0c) >> 2;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index b005672f2f96..301e9364aff1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -1662,16 +1662,16 @@ static int sdma_v6_0_process_fence_irq(struct amdgpu_device *adev,
>  	u32 doorbell_offset = entry->src_data[0];
>  
>  	if (adev->enable_mes && doorbell_offset) {
> -		struct amdgpu_userq_fence_driver *fence_drv = NULL;
> -		struct xarray *xa = &adev->userq_xa;
> +		struct amdgpu_usermode_queue *queue = NULL;
> +		struct xarray *xa = &adev->userq_doorbell_xa;
>  		unsigned long flags;
>  
>  		doorbell_offset >>= SDMA0_QUEUE0_DOORBELL_OFFSET__OFFSET__SHIFT;
>  
>  		xa_lock_irqsave(xa, flags);
> -		fence_drv = xa_load(xa, doorbell_offset);
> -		if (fence_drv)
> -			amdgpu_userq_fence_driver_process(fence_drv);
> +		queue = xa_load(xa, doorbell_offset);
> +		if (queue)
> +			amdgpu_userq_fence_driver_process(queue->fence_drv);
>  		xa_unlock_irqrestore(xa, flags);
>  	}
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> index 5679a94d0815..2660e8f08daa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -1594,16 +1594,16 @@ static int sdma_v7_0_process_fence_irq(struct amdgpu_device *adev,
>  	u32 doorbell_offset = entry->src_data[0];
>  
>  	if (adev->enable_mes && doorbell_offset) {
> -		struct amdgpu_userq_fence_driver *fence_drv = NULL;
> -		struct xarray *xa = &adev->userq_xa;
> +		struct xarray *xa = &adev->userq_doorbell_xa;
> +		struct amdgpu_usermode_queue *queue = NULL;
>  		unsigned long flags;
>  
>  		doorbell_offset >>= SDMA0_QUEUE0_DOORBELL_OFFSET__OFFSET__SHIFT;
>  
>  		xa_lock_irqsave(xa, flags);
> -		fence_drv = xa_load(xa, doorbell_offset);
> -		if (fence_drv)
> -			amdgpu_userq_fence_driver_process(fence_drv);
> +		queue = xa_load(xa, doorbell_offset);
> +		if (queue)
> +			amdgpu_userq_fence_driver_process(queue->fence_drv);
>  		xa_unlock_irqrestore(xa, flags);
>  	}
>  

