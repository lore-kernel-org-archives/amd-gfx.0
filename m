Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF963C67871
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Oct 2022 21:03:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 047B210E7E8;
	Mon, 24 Oct 2022 21:03:48 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1E1810E7F5
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Oct 2022 21:03:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LI2wujyQLnQVJgNRBJ/XTCtVT07r9ubC5ipdFiaefmXEr/gMBaZ8PxJw1j4uAjIj0NpEElRuDp4ALzajhJmhz6sytn7rTozLvCHl+NBCZJYnKfesg93/rLaQbim54xkGIg8rE0huBfQAamK0LnOBjt8BejsTDUJ5fi5+TARvhhOUiedSdmeTyrSdCG62XV25Wn9cKv9FBRIi39PhGeSiuMZ398bvdGzWL0C7DHjwG/LQ5/KoUwD7wiDu2iYSCn82T6iCh/2pYaEwh4v6i1sMSAj6uyHT2sxAEMG/lPmp27pEBBEyWSHRFM3Lpr5N1oj/al2Ol11jjsKX68hj1bXjgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gorWZMfXPmVIQTT8GJ9H90ewbeRUR9WTwrTY6Dx+uA=;
 b=nCUa7cHviSqYnGAcqrFe8KscaoKthZNtfjFEZRLpZuS+iF7j9ALxpLN/0kXsSCvrJA5PwSqFqNQb36g4DuMZ0TByq5vJlNlFHKavS8I0LhcP4tO/F2aDHmudPDvjecPQbpUgMqd1JL/HGhB1LcfrQxAJfbTHoBYvrNTHC9N7pyKzH1j/sQcSjUh1qo9piyg2aUjWBRpmtU7zRiZES25B7MkM9Y3+evo20N+g5Q2OH/2aCEFuUYwmJgJeTzLA0YTSbAPH8ewKk6cYNO5XIApUQDHcHAkhiU7CrbUZsIaeHJzqgIsr7Ed6BbGVVfva8r8q5DW/Fdm0Dg7WIWfX9w+5lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gorWZMfXPmVIQTT8GJ9H90ewbeRUR9WTwrTY6Dx+uA=;
 b=KevX37VE1E8M4+fAA8ZTwHSc/UDAoNn/loE/cR0DtBSNv9JYOKH1Dun17Aj3BsY98xfAxwQ5KtVTj+etmY8mZWt/M82l1rs3Df6yOx+vwVO4RF+lSqSHHmRKuaI4rxTW/0OdRrfBAaTNrLDzFlHpasDGdccFAV6EIyJ1pvJ2EVM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL1PR12MB5706.namprd12.prod.outlook.com (2603:10b6:208:385::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Mon, 24 Oct
 2022 21:03:40 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7e91:f457:9ec5:33be]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7e91:f457:9ec5:33be%6]) with mapi id 15.20.5746.026; Mon, 24 Oct 2022
 21:03:40 +0000
Message-ID: <0090fb7a-209d-11ce-e16b-35dab826b4f7@amd.com>
Date: Mon, 24 Oct 2022 17:03:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/2] drm/amdkfd: Init the base cu processor id
Content-Language: en-US
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com
References: <20221024112639.3440664-1-Jun.Ma2@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20221024112639.3440664-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR01CA0045.prod.exchangelabs.com (2603:10b6:208:23f::14)
 To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BL1PR12MB5706:EE_
X-MS-Office365-Filtering-Correlation-Id: b654f02f-2a66-4c98-b625-08dab6033a37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KBLZlZTrkcyfUqppGaHCqTOyjer8FBANyKa0J+YIAM5BRgnW60PZwdSGWLlgghUbR2z20WMzxtPBdZylqm9qZ6zf9yiBbNJnozSWZ802zevZUMhnNLnSnvBOX+MwfU3AH+X4Ep5+ttiW2E72TU0CIORmHhGmwTiDlI9Z9Z0N58oxjdxMIvpTY6xMYwR0DR++rtpy2xVaQFdJqxrR0bFx7STOgRXZ/kXaJLAIMd1JyQGBqZEGN19ZuQKE+a3H5/rhCtCvc+/Ha0r/BF+Cd0bRN5SBOx5UtjKiyNVjeJNhUrDvrt0yKzMY7k5jPHXws3sZ775bywUfWVjteMR2O8qVH76Y57x+UetvlEQM/f+h7qLILEDQd2rdsp4td2Ba6/9r1TCZsAbmRa5QMUXIU0Wa47moAW4azZOROSaAoK3Xbx/ltjgxkMDSTYp6l8DPMOYWiRwAORlAygAFtKdATxBDgUgiWY/gevWK8bCFo/8yb82u1OlhonEIl+APOH4upwyyQbCOL3CXJb4m05hdkkZpNQ6dn3PlzXeRoBWvqsCHn5SBVW3WUpmDKeT1sImSRPemt2bltSuN4qdXH2JTZMc8OzTfQ37Wi+xnTveqkHmQXy/GZKm2cZvmOmzTP5OYeW/k5dQNewOkAsGY5s8vcwe3FQDdTC4kXpqiuu69Zu81lV987p1lDvTJ8KQvCQPjsrMKeU80Oaz3+G3gWiGl/GjOdr2cCZx5ZK2inVD0RCAJKRt6+daLlMj1L0Tw8NHqSvn8JCvxnQcpUG9MJKWueSsP2bZKM7dJbm0BI5hLMATgkfM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199015)(6486002)(38100700002)(478600001)(31686004)(5660300002)(316002)(8936002)(83380400001)(66946007)(41300700001)(36756003)(4001150100001)(6506007)(6636002)(8676002)(66476007)(4326008)(2906002)(53546011)(186003)(66556008)(31696002)(2616005)(86362001)(36916002)(6512007)(44832011)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnAwWkZSeW0rd0FsMys3WVUyMVcwS1dsbDdqdURuNVBsdTlURTRGMGVrRXg2?=
 =?utf-8?B?QzllR0lyZ3M2K0g0cnBRNEVORzRMTXlLVjJ6ajJWRmZJY0UyTDd3M0RmY1B0?=
 =?utf-8?B?UldNUEovb1pvMWRrdGZQem94YUtmWEF3UHcrMU1JdjJhRCtVQXJPT2lXYXcz?=
 =?utf-8?B?c0Z1ci83Q2ZQNm01NG5ENXBBbGtRaVR2TDNEeXlNVFVpaHZCWXhlZUxWd1hh?=
 =?utf-8?B?Wnhxb2taTFNlcjd5dFpob25JNFczY2RxRW80VXlHaFB4anFNZnQwd21BWDFF?=
 =?utf-8?B?S1pWVkxDV1RiMjNpdGFBREtaSGhCYmNpV3hLNTZ1V2twYjVUR2lSOHZPajZ0?=
 =?utf-8?B?NWphQzE1Vm9od1dPczFnWEkyVDhCN1dwNFFOZWNWaStENmRuYVg3K2hyNmZB?=
 =?utf-8?B?ZjFNdHFRaks4R213NERYTlJOTDVSREJQa2Flcyt4eENyREc4OHVOTE1Hak9t?=
 =?utf-8?B?bzZUMjdER1E3a2pZT0M2dUlUb1VQdm1TamFHOW5qM3dQUGJXMjVTRTI4UG40?=
 =?utf-8?B?T0t3NlNnTE9nSEtMcVpya3NZWEVhUUh4NXdxS3JHTlNHaXkyK1h6NS82YVJs?=
 =?utf-8?B?aUNUYjkrMWpMZ3o4QldTdmV6K3gvbFFMaEJtUERVOWU5RmRQVk9sTFZIc0dN?=
 =?utf-8?B?OXc4MnA1YVRlYjhhRTlQUVhHSXBDZ0tEN1VhYTgzd0c3aHdpYWQyUGVmYVRk?=
 =?utf-8?B?L1p5UUNJekgvNjlEWkZ4V1k1RSsrYkswdVFEVjBBcy9nYkcydkNZaEhOeVFX?=
 =?utf-8?B?Rmptbkl1R3hFRjZxZ3JkTTh5RHRMdnliK3BJbUFNVkd2c05JMlNXUWt6MTc3?=
 =?utf-8?B?aGREaG5XTFZCL0ZvSHMrOVJqb1F3azZ1eTZ1c2xxdFNHOWJCb0M0U2NjNldu?=
 =?utf-8?B?aXFrQ2ZxaFVKaUJwbklCeVJuTkxmbW9RcGRYUkpVeGNXSVVrSFFkT3NVK09B?=
 =?utf-8?B?cUJSbVFYMWFGM3pzRVEvdTduRkZnSS9WaE5iRVF5V2JYY005OHYyWDUxbWlG?=
 =?utf-8?B?MnBBc0orMm1pOVRJV3pXRkg5NytRQjg0SWFLMTVjMGNBQjFLWDVobEpYdkR1?=
 =?utf-8?B?NVBrTkwzU0NDVTdoSFk3UWdIM2NkVXFxZU1SS3BaRFhJR2EwTWVtZVYzNjdJ?=
 =?utf-8?B?L0tqZUdRU0RSWnB3SFM0cmd0MW1ZNXdndGtWWlJjbHBVNGsvWGVKeDlDRmp5?=
 =?utf-8?B?NE9hKzlVMitodW5uWm5CTHQzZFlUQ3UyUm5xV1E3Q3lWQUs3cmNWL1QwK3V2?=
 =?utf-8?B?eW9Qdzk1bE1JaDJ6L0JUcWxNVVYxckxHK3cyV2YwL3Boa3UwRjNqeDBFV2ds?=
 =?utf-8?B?Sko5MERuR2FVeDNiSlZvWlhLS1c3MFhFL3lKS0phSkJZY3I3aitpL1dqc0gw?=
 =?utf-8?B?MXRyclBvbElqZ2sxcXlOTjFZdDdJSFJIUmtBS2N4S2pUb3BITG5EenV5S1R4?=
 =?utf-8?B?NFJhWXptS0luNEFUeDNORmJSbmhQa3lXb3ZpanhPU3RHajlYcExid2NVcE9H?=
 =?utf-8?B?V3F5cS9ON0RuMFBGcEpzUDRzeG85UnhEa05xSWVLZnU1T2h1SXpuVVZFMFpS?=
 =?utf-8?B?YXBJaXVWUjZzc3dZTndGckNlZnVPeHg2djN4ME50MVM4REpBaWV6aWRRMVA0?=
 =?utf-8?B?RkFuSWN3b1l0S1lCenhhQ3pTZVQ1U0UwTnQ2NjRFVWhoaTBka1h1SmpwK2cx?=
 =?utf-8?B?ZklML3FlNndIK0VkTXRjMkQrNzdSY2xYUG5mUmd1R1JiOENiR0h2NDFPRHZz?=
 =?utf-8?B?VEVvVkdNbG5iRWpZK2I0bUkxT0I5RnJQVmIwNlI1T3p4MmEybExHcjRsL1Mz?=
 =?utf-8?B?eUt3dkpPVzRIRjY2cVZEbWpxcXNyRjFKbFEyZ2NGMnJqaStvUGlka1pKazlk?=
 =?utf-8?B?aGNZSVlUOFZFcXRmOVQ3WDlXa2t4UFByZmgzditWcGxhaVN0dFdIeTNqU2tM?=
 =?utf-8?B?TnhYa2pRWWhsYThxeXpsTlVodS9zaWo0RlMyZkV5akRaZitUZ2tlaVRiN0tV?=
 =?utf-8?B?WUdaRWVhSFNublgzZ2UwWXdNUCtYMGJHNXN6VUIxSDVyT1JKcmQvNFBRcnZS?=
 =?utf-8?B?dzVFeGlUVXVMVUUyUDZMYktTbHY3eE1VRnRYZEEzNlZ3ME56eEx6dmV2Wlcw?=
 =?utf-8?Q?cbU60kmV5K/+WeDJfXkTp+aO9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b654f02f-2a66-4c98-b625-08dab6033a37
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 21:03:40.5326 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CI+/vt5vrlBQKA1wocspTfs9tVHE7Y4Fg+HOE74z4LqJ19ilFxsPTgG+jQBCPXD96Gr4UpRdEKtFwL4yJUFIaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5706
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
Cc: guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-10-24 07:26, Ma Jun wrote:
> Init and save the base cu processor id for later use
>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c   | 24 +--------------------
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 28 +++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h   |  3 +++
>   3 files changed, 32 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index d25ac9cbe5b2..4857ec5b9f46 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -30,26 +30,6 @@
>   #include "amdgpu.h"
>   #include "amdgpu_amdkfd.h"
>   
> -/* GPU Processor ID base for dGPUs for which VCRAT needs to be created.
> - * GPU processor ID are expressed with Bit[31]=1.
> - * The base is set to 0x8000_0000 + 0x1000 to avoid collision with GPU IDs
> - * used in the CRAT.
> - */
> -static uint32_t gpu_processor_id_low = 0x80001000;
> -
> -/* Return the next available gpu_processor_id and increment it for next GPU
> - *	@total_cu_count - Total CUs present in the GPU including ones
> - *			  masked off
> - */
> -static inline unsigned int get_and_inc_gpu_processor_id(
> -				unsigned int total_cu_count)
> -{
> -	int current_id = gpu_processor_id_low;
> -
> -	gpu_processor_id_low += total_cu_count;
> -	return current_id;
> -}
> -
>   /* Static table to describe GPU Cache information */
>   struct kfd_gpu_cache_info {
>   	uint32_t	cache_size;
> @@ -2223,7 +2203,6 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
>   	struct crat_subtype_computeunit *cu;
>   	struct kfd_cu_info cu_info;
>   	int avail_size = *size;
> -	uint32_t total_num_of_cu;
>   	int num_of_cache_entries = 0;
>   	int cache_mem_filled = 0;
>   	uint32_t nid = 0;
> @@ -2275,8 +2254,7 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
>   	cu->wave_front_size = cu_info.wave_front_size;
>   	cu->array_count = cu_info.num_shader_arrays_per_engine *
>   		cu_info.num_shader_engines;
> -	total_num_of_cu = (cu->array_count * cu_info.num_cu_per_sh);
> -	cu->processor_id_low = get_and_inc_gpu_processor_id(total_num_of_cu);
> +	cu->processor_id_low = kdev->processor_id_low;

I don't understand why you can't leave the call to get_and_inc here. You 
could set kdev->processor_id_low here. Or set it when parsing the CRAT 
table later. Setting it in kdev before creating the topology seems 
backwards.


>   	cu->num_cu_per_array = cu_info.num_cu_per_sh;
>   	cu->max_slots_scatch_cu = cu_info.max_scratch_slots_per_cu;
>   	cu->num_banks = cu_info.num_shader_engines;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index ae1f0be3f3a1..099df4598a42 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -38,6 +38,32 @@
>   
>   #define MQD_SIZE_ALIGNED 768
>   
> +/* GPU Processor ID base for dGPUs for which VCRAT needs to be created.
> + * GPU processor ID are expressed with Bit[31]=1.
> + * The base is set to 0x8000_0000 + 0x1000 to avoid collision with GPU IDs
> + * used in the CRAT.
> + */
> +static uint32_t gpu_processor_id_low = 0x80001000;
> +
> +/* Return the next available gpu_processor_id and increment it for next GPU
> + *	@total_cu_count - Total CUs present in the GPU including ones
> + *			  masked off
> + */
> +static inline unsigned int get_and_inc_gpu_processor_id(struct kfd_dev *kfd)
> +{
> +	struct amdgpu_device *adev = kfd->adev;
> +	unsigned int array_count = 0;
> +	unsigned int total_cu_count = 0;
> +
> +	kfd->processor_id_low = gpu_processor_id_low;
> +
> +	array_count = adev->gfx.config.max_sh_per_se * adev->gfx.config.max_shader_engines;
> +	total_cu_count = array_count * adev->gfx.config.max_cu_per_sh;
> +
> +	gpu_processor_id_low += total_cu_count;

Can this function fun on two threads concurrently? If yes, you may need 
a lock here.


> +	return 0;

If this function cannot fail, you should make it return void.


> +}
> +
>   /*
>    * kfd_locked is used to lock the kfd driver during suspend or reset
>    * once locked, kfd driver will stop any further GPU execution.
> @@ -656,6 +682,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>   
>   	amdgpu_amdkfd_get_local_mem_info(kfd->adev, &kfd->local_mem_info);
>   
> +	get_and_inc_gpu_processor_id(kfd);

You're ignoring the return value. Since the function cannot fail, make 
it void. The name "get_..." implies that it should return something, 
though, so maybe change the name. E.g. assign_gpu_processor_id.

Regards,
   Felix


> +
>   	if (kfd_topology_add_device(kfd)) {
>   		dev_err(kfd_device, "Error adding device to topology\n");
>   		goto kfd_topology_add_device_error;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 182eb67edbc5..4c06b233472f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -370,6 +370,9 @@ struct kfd_dev {
>   
>   	/* Track per device allocated watch points. */
>   	uint32_t alloc_watch_ids;
> +
> +	/* cu processor id base */
> +	unsigned int	processor_id_low;
>   };
>   
>   struct kfd_ipc_obj;
