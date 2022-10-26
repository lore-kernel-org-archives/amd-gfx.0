Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D3CC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Oct 2022 19:07:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1622C10E748;
	Wed, 26 Oct 2022 19:07:46 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D33B10E748
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Oct 2022 19:07:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eq12jmDVjWPJwrBMCEjqAyQmyTSRmtyy44qHkB03/XcHLdZ8tPNEC05wbfg6waeuITdKaYGv78Q/Zjr5UWoj7FRA4lfpNIya8NcKeQS5WOd2v++m+M3yIJGzAxYIDk7kxaYxXCHM6sgEFxnS/WUhaQvgZUNeiUc2ZLKAmFh5v9V1/jeooaeAjsfMxvbZFxlkjfUpfe2iEh+HLyXRSW41YowW9mYeGAb4D3RqgWy9+SCa8Gl8DHQmQDpoo+4i0BK8niFWozjo+akNcoFBxkssK2IT8YHmcC9HXtIg6CFYSiPWlsyVkUfgmH4JLcatpx8aWWSGoEKA8OrwWBaprt/YjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ge0Eblu/YC8XVy2jE4dDVmeRiqnXB9Cq0R2XAnf+0a8=;
 b=VBZJLtoRG5txeu4bwNaqDSyPLu3MPMa/Td9IGkSd7Cs7JzEKF2BZPb5xEdYjWZWyupIW+T8Qc+7TX6ixuoI0SAV1Vi2Inhmq+xXYkG/58LCGhO6d7/8MotNqIyh/hhSB3YKXWI5+jxfyeq6d+OiiPBAO5uQiaoacIPeYivUe70eb2OxPvyxzqehAXEHAbNADOkZdhBar0m2b3kbfXMzyU9dAlLudi7/jWUXghF64qdAHF+ztpuDkniW2K4dOlApfgu6JH2cjMe/cIhmbbv98/N1LEjAF25HwkUTH6Fz9CfT6xabtDBHEeeP34x/kcGsikjWrsEGZCBZpjY8kJawOOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ge0Eblu/YC8XVy2jE4dDVmeRiqnXB9Cq0R2XAnf+0a8=;
 b=bYhOMJfeIQ69mb0tqQDyVnZZt5lyq7hiJKA1oCohqVkGFVEPGeAgOU9Qld3MELTliGUX4hz1N3bVhMfTqaKe+8oBYGFrIIW27HbthV3qmncT4h9yaHgC5iorAsoUOGLu+eIn147/CskuXKmUdpqaxjCfIc4ImnOOQfxgFs4+nvY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH0PR12MB5219.namprd12.prod.outlook.com (2603:10b6:610:d2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 19:07:39 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7e91:f457:9ec5:33be]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7e91:f457:9ec5:33be%6]) with mapi id 15.20.5746.026; Wed, 26 Oct 2022
 19:07:39 +0000
Message-ID: <a68d95b7-ed9f-6fbf-e655-8401e8ab5d3b@amd.com>
Date: Wed, 26 Oct 2022 15:07:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/2] drm/amdkfd: Init the base cu processor id
Content-Language: en-US
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com
References: <20221026090313.4117136-1-Jun.Ma2@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20221026090313.4117136-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR01CA0003.prod.exchangelabs.com (2603:10b6:208:71::16)
 To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH0PR12MB5219:EE_
X-MS-Office365-Filtering-Correlation-Id: 571975e1-7fe4-4f2d-18c5-08dab785598f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PTTxcbI39gVBc1QdJSnh31nHRyESRYsfgTb8t1IgyQX178Uha0JZ0e5oPV+8z4ruZyHogb8Sk8XdFtbE/8gBbi+Vuyc57QO0rc6lz4M7BlOwvMYdC+U7+2/5cK/8I1XoocNmqRhr4PEfDlX2bTLbcT0yM3hK4MwgRqM8BjliALmbhSRKVwGi+ufRkt3dqaPQaGWWDfLdNiK4awhr9FiPjn23MJXZQ3m0LzxmKi+AbUOpYOtd/YsBuM80X5rjC6p9Jgll3cDJKkCMT9lJqKq4HLrCReTS2dvb8Q4klSw0vkhbVsnTm4t0CXfzAm7K+3vPtD7aoBPx6i8Mob3UqC1Xjdydm4I+Yv4rniXDuWPwgOgZoyLyWCiD37OdDqhCnbWfAIbIlaeBJKs5lgVZ9gt1kWgY6DrdgKJdCfd+XxSUn2m5255sMOAiEsKotpHlKvgkNgfPJBBNrwswCx+WWC3L85ZGWAHx5pwOI36BpuEU+IRF2owBkSxtagNq7cLKI5qjxesaro+TGczgzCf2rkPppTWL8CDWUNDgz9j5YommpkDyBdtxPOmqmgJruS5cE5YFGrC2Q2netnb/7KpSKOCRR13o+8NGlLPqlvZLxqiNksPcO5yhDJF6ChvzLB/GunvpXAKYj5IIoIV+Um0zSFdeu6fTu/nSUkj9+5ZGnQ5NJtVtMJ4T8Hw5fOYA1bSE+KUNKv16aqykS65LpV3AlPrMxxmqXdJqvocwWqVOmSuqoxtDIL0z4lSv5C4gNAQMHiiSoCkN+kLic4JyW6HWRT3FQdooSbAdbK+lPSB4Ic8CJ1k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(451199015)(41300700001)(53546011)(36916002)(6506007)(38100700002)(36756003)(5660300002)(6636002)(316002)(31696002)(66946007)(8676002)(66476007)(44832011)(4326008)(8936002)(6486002)(66556008)(478600001)(86362001)(31686004)(83380400001)(6512007)(2616005)(2906002)(26005)(186003)(4001150100001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1hUSDhqZS9sSExNamIvVklGTUVzNXB4UTJyNDBreVBGbEZWbVMxRTRCbG1C?=
 =?utf-8?B?RHROcFlSU2tyV2N1OGgycXB0MWZxWXp5a2tiM1NvTlMra01UWDZnOURSc2pT?=
 =?utf-8?B?bkk4aHBnN25wRFJ6bk9JZ1h1QTRmMUczZ2ZRV0dBM2t4YWl6RUVvaVdVZnNH?=
 =?utf-8?B?dlJCdFF1bldjVlRwUEtnNzVQSWNJSnpkYnFtK2ZGVUtiejdtWXpOLzVERkgz?=
 =?utf-8?B?K0dkbUt1MFF3bXdiaHg2d24weDloSFlUK293L29zWnV2VFREY2hkbnNZVzA1?=
 =?utf-8?B?Q1ZKNXA3NlB1TnBXUE9iV3d6V1JNUXFod1NpTkowdzZRbWdvaWtKeUFRMC9s?=
 =?utf-8?B?U2JqYjduUWw4TnJsc2o0eDVOZjJQby8yN3ljTTU4V3preml6YjhBbm90R0ta?=
 =?utf-8?B?Ym5aeU9hdHFMUGoybW9hVHgwbGVDbFYvZ0dMbVVueGlueGd3WFlXTEpoMEt4?=
 =?utf-8?B?bmJIWC9jbWJXazE5SlEybnBuZ1d2a0tjWmtrelR5VkVSQmdCR2lteWtxNk84?=
 =?utf-8?B?MFpaeVJKU2VadmdOZzVNVHVTM2VEY1ROcFI4dlJEWG5nMEllRC9BZ3lWUzJG?=
 =?utf-8?B?bzVrazA2T3JTSkh5VUhNSWV2a0xRVFg1cWN5QlFMWThoRDdWS2VpWXJEeXpx?=
 =?utf-8?B?L1UrK3B3MStKUlltc3hZZ0w2Y2lKUUt3aVQvMGV4Z1BCSGc5ZTUwdDhFVXdV?=
 =?utf-8?B?R2xiZUpHTEVuaDlpeXFzUkhhTjVRSytMT2xQR2NiUmNtend5MDlCSGUyR1Rj?=
 =?utf-8?B?cGRYc2NQWXhoOHU0YWxRVWJGb0tyTlFJV3EwWlhnMlhndFlqcTQwZXozWjkw?=
 =?utf-8?B?dkdSeFkrczdYSFcxeFlpeExQemZiR1llQ3MzTHVQTElRSUgvcGRmdTlGQ2ZY?=
 =?utf-8?B?Si9FN01NNUNmUVZBanJMbFVaSkc3Sy9EOGpacGJybDAxOUwrazRHZFZrb25Y?=
 =?utf-8?B?YWZOUzdxSnZCejgyT2UzUWM0b2RwakQydWlENmFJNnIyRVJmd0lTRHZWMHBJ?=
 =?utf-8?B?NlBtVkFwRWJCeVdDUDZlZ3NTZGFxZVIrQ3hsMHJ3SzJYL0NOUTk1YWRyNmdX?=
 =?utf-8?B?OWZxemlJdGMwQ1EwQXN4NlE4TVMvMk1vWWZXeGFHTWpmQWZ0anBuWU9KaGJR?=
 =?utf-8?B?bFRleHRTNll0RjYyZktGTzJ3Nm9lVWF2d0lWSi9nOWJySWJmTWFEUDZjOUlR?=
 =?utf-8?B?S3ZHQndhQW1UWHhheUhEblJMRFYwN3lxNTk2SGpRejNQMnVja2pMQ0o5TUlx?=
 =?utf-8?B?aXUrWEphS2F0VGlkNjdmUzhjN2hLT1FtRE8ycFY3WEVkcndKN3RCQzdTUXZz?=
 =?utf-8?B?MlhiQjcrQUJWTGVDaW1LQ2p6TXhHWXl0SDl2eE9KVnRJbEY2WnA1YzBzdW1n?=
 =?utf-8?B?UnB1WTJFKzZSLytkbm1NK282NnduSHljdWFFM0VRY3Q1VXF1Sld0Z3B2em53?=
 =?utf-8?B?bkFhSUQ5eno0MitMYWRDRTVYTUcrU2lzTE56WjQ3aW1US1NKRXdFdGNvSzNk?=
 =?utf-8?B?WHJMcTUzR3pOY1d0QTZmcjZGWkx4R2FLZnZYNG8zcXE4b3dLWkRidjE5TTZV?=
 =?utf-8?B?WlhXaUFqS29NUWF5cXhPRnQ4bHozd0Z6REVTa3JEMGRZd203QXlibFhzUGMy?=
 =?utf-8?B?NmtJaEJQM1VCc3dWNkJmUEIvSlNLQm1VanJud0JBM2E3bUVKMFI5U2lKVUpq?=
 =?utf-8?B?aDFQMTBvVG54My9NMmRzQ2lkdVBXNitXeUpZQUF5c1VXSmFuN3lLUWtMcHhw?=
 =?utf-8?B?Y0JMUCtYRGJCS0pjc1BYYWczdm9JTmlmQjdCT1NSN1pGZHA3YzdyR2hZWUNa?=
 =?utf-8?B?TUVZM2ZGVTF6aVNXYXVoc0p0aVk1RGt5Z0YwMDFXQnRDKzQzT2s4c2ZJaFhE?=
 =?utf-8?B?MDU0Y0NTckVkRE9PNFB1dzhwa05KZ2NGWUs2MmZYRzJzc3lPT1k1b2kwaCtm?=
 =?utf-8?B?Rm4wWEdDUjhUN0tyOWMrZm1JUjltZDFnUDEvUW00OG5sbzhrTE1oNmV1RHJP?=
 =?utf-8?B?NW1mTzFJSjFQVkhMbEF1YVpuM0tsUTcxdVFBLzF4ZE8xVnlwT0ZGbzUvVmZy?=
 =?utf-8?B?Mkx1VzIxVW5rTFRCOCtMOWdRclF3a0N1MVpzZjh6T2czQ0xycjB4dHhoZFdk?=
 =?utf-8?Q?c6aevRiVrdAdaPpgqVzTQLJ4I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 571975e1-7fe4-4f2d-18c5-08dab785598f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 19:07:38.8367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mbXOLHtXRL3HGzdAFjsawuY82FIdrSP1r1edx+NM4DHgkLbL5QmGBrP2sxrHqbTXoJs8jHqbRk6lqy0EeBHuzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5219
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

On 2022-10-26 05:03, Ma Jun wrote:
> Init and save the base cu processor id for later use
>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 20 +++++++++++++-------
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h |  3 +++
>   2 files changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index d25ac9cbe5b2..35d09e29aafb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -41,13 +41,18 @@ static uint32_t gpu_processor_id_low = 0x80001000;
>    *	@total_cu_count - Total CUs present in the GPU including ones
>    *			  masked off
>    */
> -static inline unsigned int get_and_inc_gpu_processor_id(
> -				unsigned int total_cu_count)
> +static inline void assign_gpu_processor_id(struct kfd_dev *kfd)
>   {
> -	int current_id = gpu_processor_id_low;
> +	struct amdgpu_device *adev = kfd->adev;
> +	unsigned int array_count = 0;
> +	unsigned int total_cu_count = 0;
> +
> +	kfd->processor_id_low = gpu_processor_id_low;

This still seems backwards. And I don't think you need it. You can 
access this after the topology has been parsed from the 
kfd_topology_device (dev->node_props.simd_id_base). I see you're using 
it in the next patch in kfd_fill_cache_non_crat_info, which has a 
kfd_topology_device parameter. This should run after parsing the CRAT 
tables, so the info should be available at that time.

Regards,
   Felix


> +
> +	array_count = adev->gfx.config.max_sh_per_se * adev->gfx.config.max_shader_engines;
> +	total_cu_count = array_count * adev->gfx.config.max_cu_per_sh;
>   
>   	gpu_processor_id_low += total_cu_count;
> -	return current_id;
>   }
>   
>   /* Static table to describe GPU Cache information */
> @@ -2223,7 +2228,6 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
>   	struct crat_subtype_computeunit *cu;
>   	struct kfd_cu_info cu_info;
>   	int avail_size = *size;
> -	uint32_t total_num_of_cu;
>   	int num_of_cache_entries = 0;
>   	int cache_mem_filled = 0;
>   	uint32_t nid = 0;
> @@ -2275,8 +2279,10 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
>   	cu->wave_front_size = cu_info.wave_front_size;
>   	cu->array_count = cu_info.num_shader_arrays_per_engine *
>   		cu_info.num_shader_engines;
> -	total_num_of_cu = (cu->array_count * cu_info.num_cu_per_sh);
> -	cu->processor_id_low = get_and_inc_gpu_processor_id(total_num_of_cu);
> +
> +	assign_gpu_processor_id(kdev);
> +	cu->processor_id_low = kdev->processor_id_low;
> +
>   	cu->num_cu_per_array = cu_info.num_cu_per_sh;
>   	cu->max_slots_scatch_cu = cu_info.max_scratch_slots_per_cu;
>   	cu->num_banks = cu_info.num_shader_engines;
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
