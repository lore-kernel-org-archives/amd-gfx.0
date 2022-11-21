Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9366FC433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Nov 2022 14:06:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FB9710E2CD;
	Mon, 21 Nov 2022 14:06:58 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8561610E2CD
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Nov 2022 14:06:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/wmu+6tOntyLVeRgn3PSkzKTFgBlfWqxNGaoT1Ppsaq0by0mHrUeNWF5xzFmIbvQQgs3etF9bHZLLPm62pnE5VB36V6HwdBwWlz4mNmhtrBQeJx9O8AcalWYXUbCTDJBzA9ckrMKfL1dfo1YXoo+Z5++YF8/4R3xHr3bM71rkeen5/e8/7eZQJEv1oJSuQ3vYRU+dpAr+vegcfOmtRtBMTQvRH8HL5U7JZzl1DQYWZdokr579suU3uJlo59DiCjPeLfU8tDWuDp6ZtAJINgpPQViH0no1rkG33mjqQqox/SqeR9kWSONlIAv304GRGUwZ6WJ+9+S5wnweVig6V5VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWUU3xtq6zbO7c4j/e0XatYHzTufXlDcZoW/J6xp/tc=;
 b=SJ+hTaGfOhSdKaac3SkVSRphWJsXd2oSwcghkYK0QC/mp2DlAYBw/ak9kvKB+v/tM7c5f6sH0aveNQt0FTeG7nwCIc/BGOsQVH2RCGhlk0RWgNdGseMNkvTVsjm+13OXbfvYyZHOQyA2SE5MbzJXXul8RdCgBjtQ9DhD6hbp66Jty5dzZY2IxoinkCvVQWLtkLpBf2CZZGtYCbdMvpwnDcwU7qFNyXp/2v2Gtn2WL7D9Iw/+gSQ/VS2wWh7wnugOmEUYm7GwEmm3+TRkn41xOORcQF1HDdWwgboGozr4zR8ZuRqeHBayUjlwUS+nZKGN5vg/bMCp4CUkuY7H443lQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWUU3xtq6zbO7c4j/e0XatYHzTufXlDcZoW/J6xp/tc=;
 b=EZuUEhJVyk5HRRGA8S9KsXo6C98IDysj37wHu23/vwjn/rrgEQkPF69XAM+jt5ZOelS+LPerb2wFuCIvjlcZaPlPMJkVmobBNrsfNw5vcRl6cpk9YZEmVLTgxxwtymp38hUK4LBzP0lE7Bc6CMILRbTYjmo5P1sihJ0cEJGCo6g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB6208.namprd12.prod.outlook.com (2603:10b6:8:a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 14:06:51 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 14:06:51 +0000
Message-ID: <aef0c654-d7d7-6933-ad13-276a3844341b@amd.com>
Date: Mon, 21 Nov 2022 09:06:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdkfd: Release the topology_lock in error case
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221121051340.1213970-1-Jun.Ma2@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20221121051340.1213970-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0151.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::9) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB6208:EE_
X-MS-Office365-Filtering-Correlation-Id: c0b5c41f-cd83-4c62-23ba-08dacbc9a2ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UG5GEBj1cwLkKDdRlbsa9009uNnWe/6OprMkAv+XD9e+cntpzlEmbWHFt6sgROOa06JKrnWUTSca/NrYNSw+jT0t+WdNSKsAWlfBffPpUNV98xE6wMEWbbimShlLWPTUKmmw9g/ABURrEkxbbrOc9mS8l9/BJEvv/YKNISRInl2uoZOAgUFPKV2HVHBu2UXKqvi3u9IPGyWo9QXJ+0Ia59DuKGW4AtvLdizT0xoLGNmBJGCD0TdhvqO+LD0e0nXiT0pTdfu+qs3BcJ1tiTyzLLLZ3USb9BXe4d/c3b6keVsabm6pQJDJTblkBrLAbIlry6EvdQA3e+duI4zHwtPl7WmfeYmsr+kbihcjmmmQ7Q1GAtrls6cSOYkx9HWK84hqdUZuMcsBcPdO8qA4l9mAALtMKwPWyxzpL0VOquG4qZIlFGPwjg+QsRfHdxJqfr2GxpYoZBfYfMw7th9ZMfd7cA+6bMES+u2Lenwe3M/9JB2t4JnXMpAJoJ7R2SLj5W8A+i4+jfHgRPZcsrxD6JGsnHm3S/0uD5bA8gLGoRH7oHIVzsWC5dhl7sqUzX3hz4Mf6PlZ+2R3Ct6raCx25/waOPkZ/WHO3R5ege/+rMYT9s6WuJliIqcC+RdVr4LqWDYTPBSpYnaL3Vs65amE7iHs9mnLLF/RBCNslrGEierLYvYXckPaygBJ8WAKuNsMHy8k4MFQtgYXffaoGpUCG6uFBeND8b/KAebsWan4bri3Nek=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(451199015)(6486002)(26005)(2906002)(86362001)(36756003)(6506007)(6666004)(31696002)(478600001)(83380400001)(6512007)(38100700002)(2616005)(186003)(4001150100001)(44832011)(8936002)(41300700001)(31686004)(66556008)(4326008)(66476007)(8676002)(5660300002)(66946007)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3NXcFVKdi9UM3RKZk9jd1VZK1dRVVdqMVQvNEcrTnpvQ1hpM3hkQVc5Nnh3?=
 =?utf-8?B?NDh3WEFQTWk4WENEMWd0T29aMHhjYXZZOExqVlpRTHkzVGMxQkc5S0hKbGhz?=
 =?utf-8?B?SVk3U3pEY1BuZmJjMlpaVEdxYjdrWVZOR2dCTW9abnNDT2hFV0tRZmp5SS9O?=
 =?utf-8?B?SHk5djMwOWJEeUIyM0xRVGpBNTc2N1FJOTkrRFMyM0JGS1FLR1dWaW03Wm5G?=
 =?utf-8?B?Rmx2bTB1ZzRjNmpjNDdQS0ZvTmhNMVp6UHR0SS9ZNVpjZU8vZ3RHdDRJdEl6?=
 =?utf-8?B?U2d1ZWorSzhPZmhjTExFeEtkN01salhvTjlUQ2dqOVplRWI2bGNiVjhkanNn?=
 =?utf-8?B?MURTdU1UN0t6VWFRYTNNU1lWc0xJbGJCbmtNNjA4U016c1B3bEpWSXVLZU9Z?=
 =?utf-8?B?NWUvMHdTK053N0ZRSFZRT3VvZ0lwdTdGWkNpTmlPa3pWTTNwNEpnTHdteEln?=
 =?utf-8?B?blY0TzIwOG5qWjJpSHQ5VW9DSVNRUGl0aDZSa1duY0I2MEVOQnpoL1pmaEcx?=
 =?utf-8?B?Ujc5WXdSdE9qSGZBaEFJMUMzdHI5OHpoUlFyZDFEUzRsbGZrRG9KUHZzUGVN?=
 =?utf-8?B?dHBUMW1UWTFQSVhnU3R4TXJzOGVFUEVZaWJjWmFzZUVManZEckwrOTUzQk1i?=
 =?utf-8?B?Z2Nlb3F1bXRjMHJzemVoaVllWWRweE4za1ZaS0VnK2VRVkxOWkdaWjBwVzF5?=
 =?utf-8?B?ZWlEc2dJSU1hK0R6OGxyeEtRdFZnOGtLT0V1OHd0WTloMGtlWjRJUVh6VWlx?=
 =?utf-8?B?Ry81MnNRQ1A3WlRnTTNXeHlMRnBXdDBZOTU1V1ZTTUpOWDcvdEdFZFczVDNy?=
 =?utf-8?B?cWNTSnVOdy9BNWZYS1NVRGMwQ01VR0RHK0xlMWN6c09lRTZkQzY2VTFJVThu?=
 =?utf-8?B?Z0x6ekZmZFptNTdvYyswOHFrbTdvZHVHNy9RQ3Z3aGNMb0FRTHhUbmYwditM?=
 =?utf-8?B?c1ZRWGE1MzBQUjBZN1hZdDljS0FZN29GaVlndGI4M2IrNGlTWnV2NkRkc1Q4?=
 =?utf-8?B?LzJRaUdZeEtDdUlySWFuaXdyVGk2MlQ1dVNBRE4vdCs4TC9Zejg4UzBPT1Jw?=
 =?utf-8?B?aGw0Vnp0eUJTb0JJSithbDZ6QTAwL3pmTmhuWHprL3FmM1kyRGNxQ0ZvalA2?=
 =?utf-8?B?aVZmRUN2bmF4dnBGSWYvaGhJVUMrSVFGNzR3ckNvYjlGUk1jTVZ5dCtuNDM3?=
 =?utf-8?B?S2hoMy8rcGJ4VXIvU25jNlNHUG1NS1FicGF2RE9iUyt1bFg2ellZdzlkSW5H?=
 =?utf-8?B?MGhzemdFVnVBVkx4V0tONVV2MGhGMTBaUEtLMkZwZk83WlR1anpQV0UrYnVN?=
 =?utf-8?B?NXRXQkEvYmExZE03M2tPSjRDSkxSUFlZL3VyWFErd3IxZkNSdUdWdkg2MWFq?=
 =?utf-8?B?VFBJb1dYTnduRnNkcXBpLzNJbzYvMHVQWFJRaHlPcTZYeXlsRGQvNytjMk9K?=
 =?utf-8?B?WjBxb1BGNm1lN0RVQVhCT0hoSjdKNU13NWNneVQ2TGozTmZqMTVmazJDRlZ5?=
 =?utf-8?B?bFBjcFJyVmsyZ3pmZTVyT0VVVHVrbWNRd1R1akhXN2l0Z2hWT1VqOEJaN2Vz?=
 =?utf-8?B?Z1RCOStzR24wMXRFSkEzdjUyOTBXczFQOFE4NmhlV1QxVkRPeGxnZ1dXaW1W?=
 =?utf-8?B?TWs1ZEpiSHA5RzMzZHRobkZCVFJTRW0wSEpZT0pNaW8wZ2ZtMU9lanVYOG1S?=
 =?utf-8?B?Tld4MTlHWHkrbjR5YnN0R0kvOGpsTGp3TEdsbEo4eVdURlZBQ1kzNnFHNjRu?=
 =?utf-8?B?SEtyRmNSeEFsZzByM2hobTVjeUxCN0RqdkR6VlBodGk5Ri9yN3d1eVNmbmNn?=
 =?utf-8?B?UnQ4ajF0WWtMblY4TzRWajFoRVBicFpCYjhXTktPRDRPUjIxTGFNRm9aRitD?=
 =?utf-8?B?UGZpcVNpTzdMVmJwZnkwbnFmVzczVk5xemlYQ0lLMW1hMDN4MDhXQzFoNlI0?=
 =?utf-8?B?RlRmSFJmRWcrYW9XVmxjOVVtbGw5eStyMndxMmh4eWZ2K1J3a2tKWGVKRHlp?=
 =?utf-8?B?Tnplb2drdC9aYjkwOVdyNVdtenJCVFhYTjYyZzNJbGgzZmJER3Z3WHZ1U3di?=
 =?utf-8?B?UnhyajJxUU9pMENPNXI1OExrMDBlbkc2ZFZkSXgxS25IK2RnanViTXFFK0gz?=
 =?utf-8?Q?JDTSITDHrGvDh1aV7TW8GiMJ/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b5c41f-cd83-4c62-23ba-08dacbc9a2ef
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 14:06:51.0042 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pJoYmU2xjV6w8HbvTXDmHiqERviddBiTnIsVjO9Avt4pxAKMm+Anc26duLMHuZ0Z90+zMcQnT+G1MfAZzI1DNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6208
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
Cc: error27@gmail.com, guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-11-21 um 00:13 schrieb Ma Jun:
> From: Felix Kuehling <felix.kuehling@gmail.com>
>
> Move the topology-locked part of kfd_topology_add_device into a separate
> function to simlpify error handling and release the topology lock
> consistently.
>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Felix Kuehling <felix.kuehling@gmail.com>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 120 ++++++++++++----------
>   1 file changed, 65 insertions(+), 55 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 8c555c32ea70..7d6fbfbfeb79 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1938,21 +1938,75 @@ static void kfd_fill_cache_non_crat_info(struct kfd_topology_device *dev, struct
>   	pr_debug("Added [%d] GPU cache entries\n", num_of_entries);
>   }
>   
> +static int kfd_topology_add_device_locked(struct kfd_dev *gpu, uint32_t gpu_id,
> +					  struct kfd_topology_device **dev)
> +{
> +	int proximity_domain = ++topology_crat_proximity_domain;
> +	struct list_head temp_topology_device_list;
> +	void *crat_image = NULL;
> +	size_t image_size = 0;
> +	int res;
> +
> +	res = kfd_create_crat_image_virtual(&crat_image, &image_size,
> +					    COMPUTE_UNIT_GPU, gpu,
> +					    proximity_domain);
> +	if (res) {
> +		pr_err("Error creating VCRAT for GPU (ID: 0x%x)\n",
> +		       gpu_id);
> +		topology_crat_proximity_domain--;
> +		goto err;
> +	}
> +
> +	INIT_LIST_HEAD(&temp_topology_device_list);
> +
> +	res = kfd_parse_crat_table(crat_image,
> +				   &temp_topology_device_list,
> +				   proximity_domain);
> +	if (res) {
> +		pr_err("Error parsing VCRAT for GPU (ID: 0x%x)\n",
> +		       gpu_id);
> +		topology_crat_proximity_domain--;
> +		goto err;
> +	}
> +
> +	kfd_topology_update_device_list(&temp_topology_device_list,
> +					&topology_device_list);
> +
> +	*dev = kfd_assign_gpu(gpu);
> +	if (WARN_ON(!*dev)) {
> +		res = -ENODEV;
> +		goto err;
> +	}
> +
> +	/* Fill the cache affinity information here for the GPUs
> +	 * using VCRAT
> +	 */
> +	kfd_fill_cache_non_crat_info(*dev, gpu);
> +
> +	/* Update the SYSFS tree, since we added another topology
> +	 * device
> +	 */
> +	res = kfd_topology_update_sysfs();
> +	if (!res)
> +		sys_props.generation_count++;
> +	else
> +		pr_err("Failed to update GPU (ID: 0x%x) to sysfs topology. res=%d\n",
> +		       gpu_id, res);
> +
> +err:
> +	kfd_destroy_crat_image(crat_image);
> +	return res;
> +}
> +
>   int kfd_topology_add_device(struct kfd_dev *gpu)
>   {
>   	uint32_t gpu_id;
>   	struct kfd_topology_device *dev;
>   	struct kfd_cu_info cu_info;
>   	int res = 0;
> -	struct list_head temp_topology_device_list;
> -	void *crat_image = NULL;
> -	size_t image_size = 0;
> -	int proximity_domain;
>   	int i;
>   	const char *asic_name = amdgpu_asic_name[gpu->adev->asic_type];
>   
> -	INIT_LIST_HEAD(&temp_topology_device_list);
> -
>   	gpu_id = kfd_generate_gpu_id(gpu);
>   	pr_debug("Adding new GPU (ID: 0x%x) to topology\n", gpu_id);
>   
> @@ -1964,54 +2018,11 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>   	 */
>   	down_write(&topology_lock);
>   	dev = kfd_assign_gpu(gpu);
> -	if (!dev) {
> -		proximity_domain = ++topology_crat_proximity_domain;
> -
> -		res = kfd_create_crat_image_virtual(&crat_image, &image_size,
> -						    COMPUTE_UNIT_GPU, gpu,
> -						    proximity_domain);
> -		if (res) {
> -			pr_err("Error creating VCRAT for GPU (ID: 0x%x)\n",
> -			       gpu_id);
> -			topology_crat_proximity_domain--;
> -			return res;
> -		}
> -
> -		res = kfd_parse_crat_table(crat_image,
> -					   &temp_topology_device_list,
> -					   proximity_domain);
> -		if (res) {
> -			pr_err("Error parsing VCRAT for GPU (ID: 0x%x)\n",
> -			       gpu_id);
> -			topology_crat_proximity_domain--;
> -			goto err;
> -		}
> -
> -		kfd_topology_update_device_list(&temp_topology_device_list,
> -			&topology_device_list);
> -
> -		dev = kfd_assign_gpu(gpu);
> -		if (WARN_ON(!dev)) {
> -			res = -ENODEV;
> -			goto err;
> -		}
> -
> -		/* Fill the cache affinity information here for the GPUs
> -		 * using VCRAT
> -		 */
> -		kfd_fill_cache_non_crat_info(dev, gpu);
> -
> -		/* Update the SYSFS tree, since we added another topology
> -		 * device
> -		 */
> -		res = kfd_topology_update_sysfs();
> -		if (!res)
> -			sys_props.generation_count++;
> -		else
> -			pr_err("Failed to update GPU (ID: 0x%x) to sysfs topology. res=%d\n",
> -						gpu_id, res);
> -	}
> +	if (!dev)
> +		res = kfd_topology_add_device_locked(gpu, gpu_id, &dev);
>   	up_write(&topology_lock);
> +	if (res)
> +		return res;
>   
>   	dev->gpu_id = gpu_id;
>   	gpu->id = gpu_id;
> @@ -2134,8 +2145,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>   
>   	if (!res)
>   		kfd_notify_gpu_change(gpu_id, 1);
> -err:
> -	kfd_destroy_crat_image(crat_image);
> +
>   	return res;
>   }
>   
