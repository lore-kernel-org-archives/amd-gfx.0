Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB2EACDB470
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 09:04:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A16D10EA27;
	Tue, 23 Jun 2026 09:04:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nJDS1iHv";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010064.outbound.protection.outlook.com [52.101.85.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 730A610EA27
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 09:04:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pnSyudu0xuPIPc723Fe+ZcQsaYUHzeJkJFkq2Mp4F0xspopJULWq2ifWGMRbPz0BdoQpspLL02m1XgxJ0IBmHnAnUQNUX2PV47IVc7gkfvFxXECsU3UyMozJaVaCPPDZyZND7JAzsMfeW1258vq2q57XEteJQTjlN2unS7w+3Iy7DvVPzUbEbligETUIYMwqcSiOyfeobrnTAOfBJpxxMghyRKAakbQ5glzWFn/e6YO6HfYHBoNl8rHEsOmmmeWOUlhZjA07ibqKmuVZJ7aEmK6cRiT8+FBZgRe3RD4mrTtrGNska5ZhDOB4CaP2Bf4khlbC3wPBQLpTNs5NlK8dcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWUVDJCTN9KmS4KsbDbmQNN8uS6tbj+CErZ2KkzPGNQ=;
 b=oTf6cwOBNmeLUKccEOw3yE+UiyCFjvKvCLGXmpI4nFkcxbmGF/h7NXLXHuFFW4sUa0C9u8QxXKzvfRIk6ILOxH/mJL/2Lssy71FMyPjGL9SOdefK+Df9GPwyULtMkahrfT3P+OsInVPAQ2HmXeacyGzoR4C5Z0Dx7hkIo65o2sG2hOMoh3Wzlx1HCWbsqqYrKjG7pjAIWKchTladrUA/LfNqbIMx3y06Ny4+dBSxBbkDCV7sNb782gCtv6I9lLXcyj0zGPgGEsAO7o1XcWbFL/8vnSTijslAG4VBqLd0f2wdDf1ndHzUlSfl7c8Ljima7P2i4vtf16SRk+fwG0zgNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWUVDJCTN9KmS4KsbDbmQNN8uS6tbj+CErZ2KkzPGNQ=;
 b=nJDS1iHvBevk3IIGV/t9DWb3AIdwAI+jX0YS1QlIjqCM+tgB5PBB+S9ksKcBwBU0Pe3hJEFAt2wYUD0q/oXszRHhoW4E4kKlgEauyP1bgeNhF0dBRxiFC4C9+nlnvmi7OeVg6vbdtz1KnrCG9avt6q5I7aRyDuuu1ARqDSnho+Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB6236.namprd12.prod.outlook.com (2603:10b6:208:3e4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 09:04:14 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 09:04:14 +0000
Message-ID: <8f135ee0-7d1d-4af2-aa89-36fb2265a66d@amd.com>
Date: Tue, 23 Jun 2026 11:04:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] drm/amdgpu: move struct amdgpu_mqd and helpers
 into header file
To: Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org, 
 "Khatri, Sunil" <Sunil.Khatri@amd.com>
Cc: alexander.deucher@amd.com
References: <20260622195729.181216-1-shahyan.soltani@amd.com>
 <20260622195729.181216-5-shahyan.soltani@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260622195729.181216-5-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0236.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::31) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB6236:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c5713dd-3425-4fa6-f2b9-08ded10665d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|11063799006|56012099006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Ocm3hL77NCLLfRG9OcLS4A4HeXAwAgYaFC12VOWZTtAfmXgXKP6avGGwEnyuSp8qBA0FOYW0Puuq9ykyZNEhrsTZ9x5CZsA1g9jMPyWZx54a0dNOhYPvcGgJ2+Ree/m6cYRwikidQVR2RLWMMYd5nXrbmjUIE0+dj/Q3ul3uCuU6xLh2wTOzh1D3K/r30xrlfY8ZcIOhFdDNoUSJgcagDmnIPlyE+6QB7uqfTdG081Ej5yMoO1L9N+ep8IqxgGjZoXgU41rg3YF0GrxvHK716f6n/u6C+FlDsEfRTSc8WpDIBDntaar+HMA5AyyLJ+Brh8kgVH8ej/i0ArQ8O7NdP+J0WLLxs9gmxi/703HVWRV+HzuTHDk2zN6neWhTppQzkdlfXIoJuLjctZ7jtVavLLZxoknb80pTR9eJA1WoJ3zYoTO3MKlP7E0gA1PyyNkwG0dasPoQnvIUic1lxzQzhRf1f2MNgn099gFRSDs/kveuJC8I5e+Qh9GZd74BMU8MRaFYXbz1bb3zk+W87pZKqTTo4nY0aLRn1fLwOQO0SNNWUn5fORSArNtoD9PdSmqglZ9K1oa1lxI+B7avI70JZQlRgRr8bcrWYzOffR38zNNJ6o7N2Na3KAC+JqzSnHHQqq3MVnkcPHvZGXPFq9CMpzhqah0TKo4r/h64NA139Sk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(11063799006)(56012099006)(4143699003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Si9QWEFoT0VRaU5adjJVQXpYZ1V0dHVCQU5MMk04MlR6Rm4yS0w3ZU15c3hR?=
 =?utf-8?B?dnB4dnFSL0lVZGsyc2dZb1YrbUZFOC9GS09Oc0hNZ2FlRGxjV0NNdGxyY2Vz?=
 =?utf-8?B?RHBpQ1lENFJNSEdyTGQyRCtPUzJ3SW1SRU9xZjRmTCt2R1BNd0g5c1o0ZGYz?=
 =?utf-8?B?TzlGYVlrVUoyZzhUSENZUTY3MWZaUGNaczNQRHJmbldlRWF4MyttbjlCYVVk?=
 =?utf-8?B?NmJ5MUpjaXdXOU5BRFFhY1NmTmkwMmRqTmhCcDhTVFAxVVdTY2xsS1dhcW9m?=
 =?utf-8?B?S0VabWRQQkVXUVo4UmNXWXJZVi9OUzF3ZGd3Ykw0TEMxN0dkc1lGbjRydmJi?=
 =?utf-8?B?bXVwNGg1Y05pa1BiNU5hOStxSlVmbDljcC9QL3lKRjFhcjF4Y1FsSHF5QTZl?=
 =?utf-8?B?dXNodFlzOWVFaUMyMGFBZCtTNDZjWTViK1B2bHRNbmpEOG03eGEwM3lQSkRi?=
 =?utf-8?B?NCtEUy9ncGZBakhzT0U2OWNRVXNVeng3REVPZmZxNjViR1k1YzYySlNRYnBk?=
 =?utf-8?B?MzFQL2xvRE1NNlFreWEwSFVhQit6OTFUeWRsVFpDRUVielFmdXdQdkpjTUFu?=
 =?utf-8?B?YzNhdXhQVktHdk1Zb245MjkzTWlIYVB5ODF3UnBHOVpXZWQ2ZlN2TnJBTGZZ?=
 =?utf-8?B?b0JFUzk2cjRDTE1qbXBreTRaZytOQWNxTTFMM3BQLzJJVEdVbkdoMEVrT3R6?=
 =?utf-8?B?QitUK3FpdTJsaTdkNXdHb1NTNjByR0lwT3VrbmdkNC9FRU9aVW9ORFh5OVNm?=
 =?utf-8?B?SlF1RW1WajlYeGliNXNQSXd4SXJJSGdRcjhWQUlicTZjTkVyb3JiVzZxZ3ln?=
 =?utf-8?B?d1dnWG0zT0tuZkJPRHE4eXRWUHhWKzhzZGUxaUVNOWZ3ZFE4b0gxTnVacVJp?=
 =?utf-8?B?Q252TTlicndHWTJBWW90YVFUUDVlNDNHcm51L2FGN0VFOW5odmxkcHVuUDZO?=
 =?utf-8?B?UzUzNThmLzlnb3hZK0hLZDFIUEZSTFQ4SjhTOXJpYWtYT2ErMWNSNE1Jb01U?=
 =?utf-8?B?UjVRajhPUDFVYllBYlppemt0Y2VKU2o2MzNTL1BuZU9xbVJHY2dZWmVIdHZq?=
 =?utf-8?B?eU5mYWRTTXJQWGZYYkozb2FOMnV2WitkcGxzeHJxMkZjL3lBT0ZvclNrcWIx?=
 =?utf-8?B?UmJtcTJyK3BralRMZVVneU1JRXk3VC9nOWZpN1htMTlJQ3J0d1RJU2dzRkpn?=
 =?utf-8?B?SVJRUExTRWhRcXVJdmtPZFlQQmNHOSt5YWxSd3VBUFNUMWtRR2c2S0REQmt2?=
 =?utf-8?B?N0FzcEVTdzl1bTJtS2dCcTRkcDBFaDZtd215UHpydHZydXd0Qk5WUDdkTW1S?=
 =?utf-8?B?S3dCK3dlMmpVZWxPL3dUY1NMZ05KUEwvL3ZNUklPTTQ3MGVxWEdGd2xZRkpO?=
 =?utf-8?B?ZlJESndZZ1BOZ053Nzh4dHRFenB0TlRJendjRUdUQ2VOYkNZaXVuWXNTNWUz?=
 =?utf-8?B?Qlk1dGplWmx1OU9QQjJPREM3YjBFaDhIK3lyQjNQU2dDWEhHZzUyVUQyOHoz?=
 =?utf-8?B?V2lUVXg3Ymx0aTJLYUJjN09QYlFkVUdJRHVxWDVXS000TFRnWkhKOHVJdTRT?=
 =?utf-8?B?elVqT0FsTEkxbVlxMHZBRi9GaEpMekd3MDh6NkNXTXVhV1VGV2ZHbGtyU3ZY?=
 =?utf-8?B?ejFQS1NjUXNGeTIrUzE2cFdHb3dIT0Eya1NobjF2ZWRlYmc4MVY2MlhhNHEv?=
 =?utf-8?B?L1hoS3p1TFROdG5nemt4cFFnK3NzejFGcVJ5QjBsQmU1ejZrWU05alVScFpX?=
 =?utf-8?B?eFlaUzF5WVVJRk03WnBGbXBrQVM3Z0g5c0hRbnRXOW5hWDVlUzAxOTM2bWFW?=
 =?utf-8?B?YmVKeHRXL0VoelRRZ0UySjh6c090L3ZoTDhtZitTdzFuQngyWlEvRytCNHZQ?=
 =?utf-8?B?QTc5RG9tWWRYWGVWaXMvdFloTkxORXF2VENVOGNHb1ZGblRkc3BpcW56WXpU?=
 =?utf-8?B?RU1UTHF3Y2p2aERuVmF3cWs3Y1BPNTVHVFlTc3ROcTlMQk15TzRPNHhtWEZR?=
 =?utf-8?B?MVpGV1hMZm9jTUlnNGZPWVRheERvQUFnT3lDSEhGbGUyV21ZbVAwR0tadFVx?=
 =?utf-8?B?YzRiR1pDbDFIeEZkL1FNOTB6WGpTTCtnRkZTcjJaT2lqYmZtZytZK1U3UW14?=
 =?utf-8?B?TGwxZWJINW1xNVdDUEYydUhYR2kzOCtmMXZIeFd2dmlxbU50WG9JRkpKUFVr?=
 =?utf-8?B?eW01bkt2azJ5Zys5S0NlM2NpV1J2ZDIwM2p4U3JlVCtMM3dTR1FzNnR5eklC?=
 =?utf-8?B?NjhZN1lia09aNW1GSnZPNTJMemUvc09tdmpmT2FTK1F2ckQ4b25lTm16d0NB?=
 =?utf-8?Q?BZ6FpsEQPrl9cw5zsM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c5713dd-3425-4fa6-f2b9-08ded10665d7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 09:04:14.3183 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cO7tW8UUuwWh6n0BqSLOmlB/0yIt9LJgBVJpSZRJJ6K7ku7QkojG5yZ9SNXY7uMt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6236
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

On 6/22/26 21:57, Shahyan Soltani wrote:
> Move struct amdgpu_mqd_prop, struct amdgpu_mqd, and helpers from the monolithic amdgpu.h
> into existing amdgpu_mes.h file.
> 
> This is part of the ongoing effort to reduce the size of amdgpu.h into their own respective
> separate headers.
> 
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

@Sunil can you take a look at that as well? Just to keep you updated on all userqueue stuff.

Thanks,
Christian.

> 
> ---
> Following v2's feedback struct amdgpu_mqd and helpers were moved into
> the existing amdgpu_mes.h instead of creating a new amdgpu_mqh.h file
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 48 +------------------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 46 ++++++++++++++++++++++++
>  2 files changed, 47 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 61608acc0393..ca86cef62f44 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -96,7 +96,6 @@
>  #include "amdgpu_doorbell.h"
>  #include "amdgpu_amdkfd.h"
>  #include "amdgpu_discovery.h"
> -#include "amdgpu_mes.h"
>  #include "amdgpu_umc.h"
>  #include "amdgpu_mmhub.h"
>  #include "amdgpu_gfxhub.h"
> @@ -115,6 +114,7 @@
>  #include "amdgpu_eviction_fence.h"
>  #include "amdgpu_wb.h"
>  #include "amdgpu_ip.h"
> +#include "amdgpu_mes.h"
>  #include "amdgpu_sa.h"
>  #include "amdgpu_uid.h"
>  #include "amdgpu_video_codecs.h"
> @@ -609,44 +609,6 @@ struct amd_powerplay {
>  					  (rid == 0x01) || \
>  					  (rid == 0x10))))
>  
> -enum amdgpu_mqd_update_flag {
> -       AMDGPU_UPDATE_FLAG_DBG_WA_ENABLE = 1,
> -       AMDGPU_UPDATE_FLAG_DBG_WA_DISABLE = 2,
> -       AMDGPU_UPDATE_FLAG_IS_GWS = 4, /* quirk for gfx9 IP */
> -};
> -
> -struct amdgpu_mqd_prop {
> -	uint64_t mqd_gpu_addr;
> -	uint64_t hqd_base_gpu_addr;
> -	uint64_t rptr_gpu_addr;
> -	uint64_t wptr_gpu_addr;
> -	uint32_t queue_size;
> -	bool use_doorbell;
> -	uint32_t doorbell_index;
> -	uint64_t eop_gpu_addr;
> -	uint32_t hqd_pipe_priority;
> -	uint32_t hqd_queue_priority;
> -	uint32_t mqd_stride_size;
> -	bool allow_tunneling;
> -	bool hqd_active;
> -	uint64_t shadow_addr;
> -	uint64_t gds_bkup_addr;
> -	uint64_t csa_addr;
> -	uint64_t fence_address;
> -	bool tmz_queue;
> -	bool kernel_queue;
> -	uint32_t *cu_mask;
> -	uint32_t cu_mask_count;
> -	uint32_t cu_flags;
> -	bool is_user_cu_masked;
> -};
> -
> -struct amdgpu_mqd {
> -	unsigned mqd_size;
> -	int (*init_mqd)(struct amdgpu_device *adev, void *mqd,
> -			struct amdgpu_mqd_prop *p);
> -};
> -
>  struct amdgpu_pcie_reset_ctx {
>  	bool in_link_reset;
>  	bool occurs_dpc;
> @@ -1034,14 +996,6 @@ struct amdgpu_device {
>  	struct amdgpu_kfd_dev		kfd;
>  };
>  
> -/*
> - * MES FW uses address(mqd_addr + sizeof(struct mqd) + 3*sizeof(uint32_t))
> - * as fence address and writes a 32 bit fence value to this address.
> - * Driver needs to allocate at least 4 DWs extra memory in addition to
> - * sizeof(struct mqd). Add 8 DWs and align to AMDGPU_GPU_PAGE_SIZE for safety.
> - */
> -#define AMDGPU_MQD_SIZE_ALIGN(mqd_size) AMDGPU_GPU_PAGE_ALIGN(((mqd_size) + 32))
> -
>  static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
>  					 uint8_t ip, uint8_t inst)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index 5255360353f4..7b4cfb5c8f83 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -438,6 +438,52 @@ struct amdgpu_mes_funcs {
>  			      struct mes_inv_tlbs_pasid_input *input);
>  };
>  
> +enum amdgpu_mqd_update_flag {
> +	AMDGPU_UPDATE_FLAG_DBG_WA_ENABLE = 1,
> +	AMDGPU_UPDATE_FLAG_DBG_WA_DISABLE = 2,
> +	AMDGPU_UPDATE_FLAG_IS_GWS = 4, /* quirk for gfx9 IP */
> +};
> +
> +struct amdgpu_mqd_prop {
> +	uint64_t mqd_gpu_addr;
> +	uint64_t hqd_base_gpu_addr;
> +	uint64_t rptr_gpu_addr;
> +	uint64_t wptr_gpu_addr;
> +	uint32_t queue_size;
> +	bool use_doorbell;
> +	uint32_t doorbell_index;
> +	uint64_t eop_gpu_addr;
> +	uint32_t hqd_pipe_priority;
> +	uint32_t hqd_queue_priority;
> +	uint32_t mqd_stride_size;
> +	bool allow_tunneling;
> +	bool hqd_active;
> +	uint64_t shadow_addr;
> +	uint64_t gds_bkup_addr;
> +	uint64_t csa_addr;
> +	uint64_t fence_address;
> +	bool tmz_queue;
> +	bool kernel_queue;
> +	uint32_t *cu_mask;
> +	uint32_t cu_mask_count;
> +	uint32_t cu_flags;
> +	bool is_user_cu_masked;
> +};
> +
> +struct amdgpu_mqd {
> +	unsigned mqd_size;
> +	int (*init_mqd)(struct amdgpu_device *adev, void *mqd,
> +			struct amdgpu_mqd_prop *p);
> +};
> +
> +/*
> + * MES FW uses address(mqd_addr + sizeof(struct mqd) + 3*sizeof(uint32_t))
> + * as fence address and writes a 32 bit fence value to this address.
> + * Driver needs to allocate at least 4 DWs extra memory in addition to
> + * sizeof(struct mqd). Add 8 DWs and align to AMDGPU_GPU_PAGE_SIZE for safety.
> + */
> +#define AMDGPU_MQD_SIZE_ALIGN(mqd_size) AMDGPU_GPU_PAGE_ALIGN(((mqd_size) + 32))
> +
>  #define amdgpu_mes_kiq_hw_init(adev, xcc_id) \
>  	(adev)->mes.kiq_hw_init((adev), (xcc_id))
>  #define amdgpu_mes_kiq_hw_fini(adev, xcc_id) \

