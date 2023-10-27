Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9155C25B48
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Oct 2023 20:06:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48A0410EA3B;
	Fri, 27 Oct 2023 20:06:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8331F10EA3D
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Oct 2023 20:06:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N75jbFvH1XnzdCNqljSo8+mdDsQTrItXi3QQbuQ2mcDJwwdkDD6kyIfHJcH0IqnkCVV6wrRuxzVdO6ZbFyxpNwTLgFfPko5G6TaIhgLfglZ+RDqhjlo3RU5qx2Nv+3mSA0qpJUZ+WBGZdNqzydbTZnR9lMG0nDwfDcJjqbarXNm1fu3DxQAqZ7pKg4vzEKp9ZuaIwCXL2wOidGF94WVyGgpb5HbYH14KDC58GzPkFguEudSc7rIxp20CLsgOWytcbgPVoLQMjCAiHqBVJeSfeFbPByeXzWstQdguZBHvW8pfx2kRJN2zxeXrb6/1uR+b5o9nsq2UMWsyehs68E8jBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxLovBkCQqc3B6b/+LFduextEboMk2zqWrQZPgZHj1o=;
 b=E83U5rYMSwd58TBCLPWmZ5gj0/FLM3eJ3YFvPPXw7CYkNAtOM/tC90VOSTVpxZJ3ghOkTzXCGh0Gq4XQjfKRC/LQJN0xHFWrzkYbQKASIGwa2Mzh0iDqmcfn2ubeYXRPMGJBp7stO6qRnHz7BTuqd/Vn2KaAef08Ca4LQ8Bzhsd56Y454Ckyp/ERxOKXwp0e6YClCrju3Z62ujScs/XF5ZUuvSwNtA5O43IxF+OZmnLbE9nGmoLqJnvS09mo34sJiAHP3XwxeOkdsAy8G2ekrfRIyVpdkqdZanMVqDTHiLPsoMC2cvBcalWiuUYV2V5ZLt23BuJjgxZbEz2RoK3PEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxLovBkCQqc3B6b/+LFduextEboMk2zqWrQZPgZHj1o=;
 b=1HpKgZRjNMFzz57Di1q9UplT6nvi/iQRRZUfE5bYOHtsRX3wckwz4hg9RJpijDANWN2RQ9oKavuhZGuQavc6FfCL7EI2ldyQJoJ9Y7irUqNRRKBeltmPhY/3PJAc45UkE36T669QLDDcU1XrA9Z4DPgTxgPHZAabBV+YAUfIwgE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN2PR12MB4437.namprd12.prod.outlook.com (2603:10b6:208:26f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Fri, 27 Oct
 2023 20:06:22 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2c3:911a:bd2c:ac31]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2c3:911a:bd2c:ac31%4]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 20:06:22 +0000
Message-ID: <95910ab2-d869-4c63-95f4-47b31e643ef9@amd.com>
Date: Fri, 27 Oct 2023 16:06:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/2] drm/amdkfd: Populate cache info for GFX 9.4.3
Content-Language: en-US
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231027190402.553203-1-mukul.joshi@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20231027190402.553203-1-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0155.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::8) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN2PR12MB4437:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f4e01df-01d6-4a6f-e01b-08dbd7282ff6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ybZxIALzPPAYOpwZlDiUM2nH3MVXkodELDEcO+eFf6f0/dCWJdySVkXETWaCZHAZqIFb2sn375TER2VL3D7kdDQK3ZOsteKuCDc1oBguW9LdNRONBiKnztr4RfPXq+T3vLepT6Cs7P/b4Z46RWzrRRcO03z7PqwkT63djYtBb/j0WcL9fVef5PapRqftrRXrS+bHAVClV7e0msDZE8oPnoXmPhV3/EkjW3XknuNbgCp9vI3zwXieTd3siRyFg9b7zO1XEvOBLqiz99h0aZMM1QD/9hexTolhdI+QQ+5wTQZOp3Eoia36wtI9d0YFIs+nYaPMmy8F6wgx5CvIffwQ9VIhbPrirU9Bssm91bSCmmjVl9GkwjZJJTAh+qNo8etC5otL+d150T1LLulDvMPrKUzL8CRuJUSSH/YMga3xmZOTE/5+foya/CpaQSFfbIRi9XUwSUjAaUu+dJ/j+azQeYzhlYj+tnqftXeBdUp9ov1SpCeJCylvGcSHtuWbZ7W7gTYg1koXt92EguIwazm0fyeatVZc9K9YZpBYE1s4fc8SE4h6WzNUBonfYL1Plj2gWYQfYI19RNIyrwkWzMTt3jYnAUyT+jbxE91ejr3Lx7HJzOoNQNAIcN5FnMVOCMxXV7l4KniDUQy573oSxl1+HQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(376002)(396003)(39860400002)(366004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6512007)(2616005)(41300700001)(44832011)(5660300002)(26005)(8676002)(8936002)(478600001)(66556008)(66476007)(316002)(66946007)(36756003)(6506007)(36916002)(6486002)(53546011)(6666004)(86362001)(38100700002)(2906002)(31696002)(31686004)(4001150100001)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlJzT0ViTmlOekNFNzdrWXFycjd1OTVaMmpKNndKQzdWbEVXTEZISU1QRTB6?=
 =?utf-8?B?RHpPS0F1dEJYTStHM3ZQUFJVa05JL3o2VG93VWFKeHdON05rV3FjeHUzSmU0?=
 =?utf-8?B?VHE5cHVrWGxJQjdXd2tjdzgvZERnWUM4RWQ5U3lEemFEajZsNFUyZFlLVFQ4?=
 =?utf-8?B?azFwMVhzbElSU0hpWEU4MVR6ZjladjZZc2RCWUdIa08zOERYWFQ3cTFzMUta?=
 =?utf-8?B?MVVqUGxzZjQvbE55MmpKVnJubGRKa3pQcTdMT3pkQW15YVdaOXcrRDlHeGwz?=
 =?utf-8?B?L2NwTTNoeHkvQ2xHZ1RUVUp3NEZ6NmE1STFhRm0yeTcvaTkrTWtObHA4TnM1?=
 =?utf-8?B?QVF5VzZ3WWJZY1Z4V3RVUXhvYTRtVmlXcEkwWHdENU1nb3ZKaTFlOStIcDdU?=
 =?utf-8?B?NzFHcnJTbTF3c1JHMWdERUF3QzN5MHRlajVaV1hYTFJxaG9zUkkwYXQ2M3Jp?=
 =?utf-8?B?YUk2RlFQTSsyNGFKWlBrRmJiZU1abllnbmNvcDhibzBKV1BDNXJIcyt6UEd3?=
 =?utf-8?B?cFlZWHRSSmRSSEVDWGFkMUpNc0JGYWtPNytYalJpaEIwbC9sdDlkWDY5YkRE?=
 =?utf-8?B?L2lrZlZkY0pHUndGZkVsc2F2cWRVd2RLWkg5V0ZXMGlGcHJLTkJmMndXc1M4?=
 =?utf-8?B?V3hKQjdqQ3NXU2lBVmNEWjRySC8xMjB5NTR1bksybkVjbFRkcC9XMktNdEpt?=
 =?utf-8?B?YVlJS2tTZFNqdndvclhLUERPdlpxUUd6ZnBhRURsOHFwWEZtZFFLTkxNZkVw?=
 =?utf-8?B?QkRnTDFYV3czWWJCM2pTZkFQV296WE03bjI2SG9VWW1YWERjWGE1MDNqSS84?=
 =?utf-8?B?VEo5OWxPYXBTY0dxbjVhdU5OK0piZEYvTnh4RmhiK2M2bExmd3FxTkJXdndn?=
 =?utf-8?B?MnNzN1JNTHdNU1BPL1RSUW1JN0JnK1hPOGtnWkdGR1Z5cXRudGpqQllRSHJQ?=
 =?utf-8?B?YXh1eFhFY0RmMElrOHBYSzluT05RbzAwaGNsNS9IUVBkZHdUajJtd3EzS2F5?=
 =?utf-8?B?aDhSWkZRaUFCS21zN0NHbjgxMW5hN2dnVGhJRE1qbWdVMUlsczk3NkRxOTc4?=
 =?utf-8?B?bTVnaU91TVBHSVp1dCtzNTRYbTdTbWF0MWcyTG9FaUl5bi9wbUFHbWZZM3kz?=
 =?utf-8?B?SXJ2ZUhrbTFRL09zTThkT3k3Mmt0cnczRkNob1ZXMng2bjlscmtsdFMxd1d2?=
 =?utf-8?B?QUt3TTk3ZVdMOEdXZFhUdFF3dVJWUWk3NDFjWmRDWHF5a2RlcjVhK2I3d2Rs?=
 =?utf-8?B?b0RPTllURDh1cnRUdFdmSi9xdWRQZVVDWFY5b09vUDI2NUptQ2k0SW5CakxL?=
 =?utf-8?B?Rm1YV0hZZDNJVWN5ZmpkRThNd3ZYK1RmUlVMbVNibUxyMTZTR0VOTmMzb29k?=
 =?utf-8?B?emFyd0F6M0xQMFpFQTVOcXlqcExCZkhnTjFid1JDcnBZMStBaWJ5ckwxcHNn?=
 =?utf-8?B?ZmpHM1hGdnFGZElWNHJxTTl3WU1QR2ZFMTh6aXplYlcyaXk4dC85VVpqSDlP?=
 =?utf-8?B?S2UrSm1KcmZBNk1PditOUVRhbm1PVjhtTTVaZjNYSXdZbVFTaFdiRWJob2Fn?=
 =?utf-8?B?ckhMMTlNeXFoOTVaeEF6VW9uUEgvemZ4QktDOHBKNWVFbDZLN256NUNzamI0?=
 =?utf-8?B?UWEwZWZrRWp2V1ZDYzhrQkdPbFJ6TzE5bDkzZUlManY4UjZ0N0lHSGNMSDZY?=
 =?utf-8?B?Nk9nV1U4ZU0xYlM0b04vN080bUo4UUVKSmxldXUxcWk5VkNrSGY2bHlmVGhI?=
 =?utf-8?B?ZUJweUVmaUlUZWxONXp3UWU1NkxTZEZmZ1prN0xoMWZQZHRlTDNrdk9MdDlm?=
 =?utf-8?B?QlpNUHhkQmdoY0hUeFBGVlA1WUlEdDF2V0JIZ1VxajRhZCs1WUhvQzBvaDU3?=
 =?utf-8?B?WkpuV2xJaGV3dFhJSGhFakhVV2hWWm95WDNOK3NkM0dBb0QxbE4weVQ0YVEv?=
 =?utf-8?B?QWVjakpsanRtU3dodGE3eVVoTDNhY3VsSGlmZXdib3dqdkpCMXJZaTh5SVVq?=
 =?utf-8?B?amJpYWVxdENwclp1bFJMbmQ2SnZ2ZlBJY0Z4MzRpb3dpaXM4TEFzRVFpK1ll?=
 =?utf-8?B?ZGRDMmQzcjZud1lwZ1BpRnRSWm54Q2YyWUV5aHo5RWswTGVvTXY3MnRPTDlu?=
 =?utf-8?Q?MFMR2pVVxPdRqOVNUtilX18tI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f4e01df-01d6-4a6f-e01b-08dbd7282ff6
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 20:06:22.2255 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0XUzpSctUc2UqOg1KEdMPEMxGmoB52C2voa1CmJfQxvYjsFCXdJTk/oEtILOh+7AQcl5FxZZpuht6BUY2jELXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4437
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

On 2023-10-27 15:04, Mukul Joshi wrote:
> GFX 9.4.3 uses a new version of the GC info table which
> contains the cache info. This patch adds a new function
> to populate the cache info from IP discovery for GFX 9.4.3.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
> v1->v2:
> - Separate out the original patch into 2 patches.
>
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 66 ++++++++++++++++++++++++++-
>   1 file changed, 65 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 0e792a8496d6..cd8e459201f1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1404,6 +1404,66 @@ static int kfd_fill_gpu_cache_info_from_gfx_config(struct kfd_dev *kdev,
>   	return i;
>   }
>   
> +static int kfd_fill_gpu_cache_info_from_gfx_config_v2(struct kfd_dev *kdev,
> +						   struct kfd_gpu_cache_info *pcache_info)
> +{
> +	struct amdgpu_device *adev = kdev->adev;
> +	int i = 0;
> +
> +	/* TCP L1 Cache per CU */
> +	if (adev->gfx.config.gc_tcp_size_per_cu) {
> +		pcache_info[i].cache_size = adev->gfx.config.gc_tcp_size_per_cu;
> +		pcache_info[i].cache_level = 1;
> +		pcache_info[i].flags = (CRAT_CACHE_FLAGS_ENABLED |
> +					CRAT_CACHE_FLAGS_DATA_CACHE |
> +					CRAT_CACHE_FLAGS_SIMD_CACHE);
> +		pcache_info[i].num_cu_shared = 1;
> +		i++;
> +	}
> +	/* Scalar L1 Instruction Cache per SQC */
> +	if (adev->gfx.config.gc_l1_instruction_cache_size_per_sqc) {
> +		pcache_info[i].cache_size =
> +			adev->gfx.config.gc_l1_instruction_cache_size_per_sqc;
> +		pcache_info[i].cache_level = 1;
> +		pcache_info[i].flags = (CRAT_CACHE_FLAGS_ENABLED |
> +					CRAT_CACHE_FLAGS_INST_CACHE |
> +					CRAT_CACHE_FLAGS_SIMD_CACHE);
> +		pcache_info[i].num_cu_shared = adev->gfx.config.gc_num_cu_per_sqc;
> +		i++;
> +	}
> +	/* Scalar L1 Data Cache per SQC */
> +	if (adev->gfx.config.gc_l1_data_cache_size_per_sqc) {
> +		pcache_info[i].cache_size = adev->gfx.config.gc_l1_data_cache_size_per_sqc;
> +		pcache_info[i].cache_level = 1;
> +		pcache_info[i].flags = (CRAT_CACHE_FLAGS_ENABLED |
> +					CRAT_CACHE_FLAGS_DATA_CACHE |
> +					CRAT_CACHE_FLAGS_SIMD_CACHE);
> +		pcache_info[i].num_cu_shared = adev->gfx.config.gc_num_cu_per_sqc;
> +		i++;
> +	}
> +	/* L2 Data Cache per GPU (Total Tex Cache) */
> +	if (adev->gfx.config.gc_tcc_size) {
> +		pcache_info[i].cache_size = adev->gfx.config.gc_tcc_size;
> +		pcache_info[i].cache_level = 2;
> +		pcache_info[i].flags = (CRAT_CACHE_FLAGS_ENABLED |
> +					CRAT_CACHE_FLAGS_DATA_CACHE |
> +					CRAT_CACHE_FLAGS_SIMD_CACHE);
> +		pcache_info[i].num_cu_shared = adev->gfx.config.max_cu_per_sh;
> +		i++;
> +	}
> +	/* L3 Data Cache per GPU */
> +	if (adev->gmc.mall_size) {
> +		pcache_info[i].cache_size = adev->gmc.mall_size / 1024;

Is this /1024 a unit conversion? What are the units for L1/L2 caches 
compared to L3 caches?

When we report the sizes in the topology, they should be in the same 
units for all cache levels, I believe. Given that L3 is likely the 
largest, I'm a bit suspicious of this conversion.

Other than that, the series is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> +		pcache_info[i].cache_level = 3;
> +		pcache_info[i].flags = (CRAT_CACHE_FLAGS_ENABLED |
> +					CRAT_CACHE_FLAGS_DATA_CACHE |
> +					CRAT_CACHE_FLAGS_SIMD_CACHE);
> +		pcache_info[i].num_cu_shared = adev->gfx.config.max_cu_per_sh;
> +		i++;
> +	}
> +	return i;
> +}
> +
>   int kfd_get_gpu_cache_info(struct kfd_node *kdev, struct kfd_gpu_cache_info **pcache_info)
>   {
>   	int num_of_cache_types = 0;
> @@ -1461,10 +1521,14 @@ int kfd_get_gpu_cache_info(struct kfd_node *kdev, struct kfd_gpu_cache_info **pc
>   			num_of_cache_types = ARRAY_SIZE(vega20_cache_info);
>   			break;
>   		case IP_VERSION(9, 4, 2):
> -		case IP_VERSION(9, 4, 3):
>   			*pcache_info = aldebaran_cache_info;
>   			num_of_cache_types = ARRAY_SIZE(aldebaran_cache_info);
>   			break;
> +		case IP_VERSION(9, 4, 3):
> +			num_of_cache_types =
> +				kfd_fill_gpu_cache_info_from_gfx_config_v2(kdev->kfd,
> +									*pcache_info);
> +			break;
>   		case IP_VERSION(9, 1, 0):
>   		case IP_VERSION(9, 2, 2):
>   			*pcache_info = raven_cache_info;
