Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE21C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Nov 2022 06:26:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEC6210E11A;
	Tue,  1 Nov 2022 06:26:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16AD410E11A
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Nov 2022 06:26:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHtuaAyPJ0a8B1kb0TcNrR0Akag7nIx/ZHwH7cxpJi/9aA0CnZJKp2Ls1l2z34YUi/8Na5244m6RoQ7s/kT2+kUTQAsbjfRrl5FraKPuQNYq6GcGoERc60HScxrizpU/HJTJdoc+LuhpkwGgtKUvCi9aD0IUcUAR7E7prm8RWaJT1bwfAojyH4kq7gCqwC0bYKmqS3BZMYbAqFpTgYaSVYRHjHkhEqKDyFChgfYc02U63NilenziNf/jm/7ogf+pOpF7hB18eUHX/RFWqj63gH91T0jgtDztb7lsu8Asr5xE0n3P+RjHzGRuJHk0LFLYa1L9wzv4Q5ZRGXPfJW0IbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mc4T2O7sjcW8FGquuAeNyPiLdS2zwKUc2qweu0ipAaI=;
 b=j5GRMUKo6+lvfV0VZ0yhtA7xaAbpxhp2uzcbsdi2WDmxwPmnqR2JhiJTw1d5Ge+vqW8czPZ0Gl5p4NDV6MsHKkLawHWLh2/4PS9IL5ae6YGZpD5fR6paSepSYThUWaXcDYHFUj2WmJdXyQdGJ0kL/eq4xzYrpdhzQF+rzh3LzLImXe+vs2pNbMx23fDwbjjKOtfADlGb3GBl3oCkuw0TW9O1TYh+3ww2OCjzFj2m0wWjN0/ZvAqiVOjkNqk6tuxl6INiyTXMR9y0r7FC3f/z1pO1ccU4RH1+z7jy+UKWztlIqF7BWlJdkJOxs7l+1nsx0VRpBg6tePL13qzNMNU5Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mc4T2O7sjcW8FGquuAeNyPiLdS2zwKUc2qweu0ipAaI=;
 b=z0CB0V0215jL1bMtntizS1bbgMI5DRytsV0Nu6hEAhoQdIwh5Mmo1lxTKbTDD4yOaiIBgiw6/WL9HlZyw+/XTYTXJFQk6gtpvb802vIVu8ZPkQ4kfnFQhljZ+vUkHrGSNeoVo9gIHhsJx9C4Ism30Co/4B1GKtV/O5zIAngLny0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 CY5PR12MB6203.namprd12.prod.outlook.com (2603:10b6:930:24::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.15; Tue, 1 Nov 2022 06:26:41 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::dda9:dc0a:4491:ac2]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::dda9:dc0a:4491:ac2%6]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 06:26:40 +0000
Message-ID: <fd6e4c76-68a9-f528-e7a0-382c27c3ae26@amd.com>
Date: Tue, 1 Nov 2022 14:26:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3] drm/amdkfd: Fix the warning of
 array-index-out-of-bounds
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20221027081402.320626-1-Jun.Ma2@amd.com>
 <9db95d91-84f5-4f10-633b-e42e909b14d6@amd.com>
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <9db95d91-84f5-4f10-633b-e42e909b14d6@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:54::23) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|CY5PR12MB6203:EE_
X-MS-Office365-Filtering-Correlation-Id: 388f92f9-e1b2-4fc6-7417-08dabbd2098e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yvGP2BFdfl9r+T5d12aOhsMUHTozBATbNDjekiIP6ObwGquUuXj1R+NrrHXQa2wvH6GV+2g4sWgQ9h3Dici7vuZHQHj4NTNkYoh+Y0jlg9uUxBl/CbaWWkwt4t0OF9AgS2Ou4H2xTjkmV+DKIkk/NPhFc7pJevTRJTvMpHXw9CkFf1PRrq2QyXHgONikW6yPzHUUwlPeXmrw3ZQ1L4nJCDLFgE/2Xqg9nKbYkodPS3cUXSUKUSJdlbqq7lrvJwVY43ZmURVIlzt9qT7T9meDVZr+ji2WAO1zVgdKk/54YBaLEVb+nTh7B/29dRRgOUJSmRl62ErV/7eYqm4LNww8SpXz8S+d8nIFW/CGMkldzSLY/ekwaDc4vLkmmshA++g+pIyMyLfN4J3TISn4eovzqXRBRTslsJPq3iiVGWlaX6hpUCKs/edfVdXEpC/rxQ2zGk8KM/dehrp6FEaDs9+jNvvwpYpI+YlaP/cUMl9mFvIZyekh9pjN5ys9WHAswjtHxO+R/ZKold3vT2MxijoS5iq6Q8ERpajuZtIZovneJngLmRnv8mlF0Nnp9M9O+RIWrCT3X6Dc7F1HhDSlhNqnsLwzkAQ8MvPEjOZEMsLCMj7fnxL0QKg7V/P/aUwq2EsTNsOefE7kGp3MRY3bpLc8Jh8jr/BIvhxoWFr72b2Ur/e5qBfHQ39h7AbVatRUuLQuESjhSNSyHbxKvWBv7rAH11EbhTyGQak4Ab8brpTOpWSR3kAShaXyixcG8/adQdZoRlzr/jqlSx+vhebQ/QYCpY1J5ei5sxLj8bokPhs9jec=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(451199015)(66476007)(6666004)(6486002)(4001150100001)(478600001)(6506007)(110136005)(53546011)(2906002)(5660300002)(36756003)(41300700001)(66556008)(6636002)(31696002)(4326008)(8676002)(8936002)(66946007)(316002)(83380400001)(38100700002)(31686004)(6512007)(2616005)(26005)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2xsWWxwdXlpWkRKTEVMQVNLNGgzbHdNM2F2UlpkeEJ6U0xCZ1JXODVtdjNj?=
 =?utf-8?B?WDRQSHBXbmdDKys5OEFhaWlpWEpyZVNFT2Z4dW5WME1rbjJjZVNLeS9wOGE2?=
 =?utf-8?B?Rkl2YlhISVlGZklYd1krSXkvVjMvcktVK3VucVU2Q3RrdWFFREFQbEJXMFMx?=
 =?utf-8?B?OUJ2Y3ZhZ0NDY3NWRlByVGxaSWJKQk5NOCtPR3ZBTWp3UnpZV1BjNENxelRt?=
 =?utf-8?B?YTVBV0Y5NXMzN0hmcm1mWWRsK1VpUWZNUUovVXFPS3AwS29oWFBRdjFneEcx?=
 =?utf-8?B?bGFTWS8reHd6Q3RjS3dGdUI3SXhROXBIb2JUOS82TkxVWWZDaFRueW5Xc3Uv?=
 =?utf-8?B?dGcxOTBZamdIbkNaNUluNFNxZkVwakQxTm9ERS9LcUF5S2ZxcWtlYklBQW5C?=
 =?utf-8?B?ZENqYkFORGlxV0xCcWJMZklReE9uVFA2S1hVMms4S0gwbyt1ZzNIUjJYYVlR?=
 =?utf-8?B?ME8zWS9KSFhWM2cvMHpJUUhSMmtzVHlnTXh3NkNSOWJodHBVNStnNmh6QTI0?=
 =?utf-8?B?L25QRGY4ZThLcHNDM3p1QjA2U0dNTjNNcWZ1eW90Slk5K29XWTdUenJtbVFh?=
 =?utf-8?B?ZXpoc2R5cDVsU1pVUFhBSG1pVWxodzRvemZMUjVWMjF4RUFQaEVTR2g5eURy?=
 =?utf-8?B?a2NIZ1NDemppN3pzZUNuTUl3cWZ4OGV4SzdMbVFzT0Y4UC9rVWM4MUNGS2l4?=
 =?utf-8?B?bytyR0FuVmhzR0pJVEhHSXlSTnphU0NqZjAwOTNjRGhnTjFDc1NEOWhMR2E1?=
 =?utf-8?B?YU5QNmJYSDVYalZSZWVMN3plOHAwck9KSTZqSm1sVGlqdjI2aklNY2lUcGl4?=
 =?utf-8?B?VkRDTFJ1eDUxTFExVFdiak9MaXg2anhqOW9sQ1QzeGVlSW1MWHh4aVRvbnBY?=
 =?utf-8?B?ZmZxNnNET3E3ZVloNXpHbDI3UGtYcWkrQ004OWtLTUhJZ2Vpak44TDMrMVV5?=
 =?utf-8?B?WnlOVURsNDJPK1NQSVBCeHJiYW1DRUxsMzFYS2YvR2xKM3lLQ0pzNUY4K0Zi?=
 =?utf-8?B?bTg3NkJqdko5MTNEbmphajlNbENDVWlOMXlxMkE3MmY0VDU5YTdtM3RLY0Nu?=
 =?utf-8?B?S2pXd1pYRlFLVTJEZE9ZQzJyZ0NscUE4SEIyZElTek1OU2ZKZU8xTFJsd2dq?=
 =?utf-8?B?N3NpZFcvM0JKekhOOVQ2Q3V3eFgySUkvK0w1SE9KUlUxMW42VGx0WjcrK1lu?=
 =?utf-8?B?ZkVvQ0ZERHY0NCtVR1AvT2xhaE9UUFdZNnRCYmtlN3U5eDdOOHJvSERqam5l?=
 =?utf-8?B?ZHlXVHh6aXFsQWxNTEJ1SERNQnVpRU41UUl2MTllbHIwelBBUkM3aXhsaHV4?=
 =?utf-8?B?aE54UXh0UmZCU25ZVHlXdWJXb0luTkxKRXVDVG5UMU1ScDJ6VUN3cGRjZzdT?=
 =?utf-8?B?MTA4dHpoVFNnTS9SQytZU0c1N0s2RTZ5aGZhNUJ3U1crcjdIc3RLTFZwZ1Bq?=
 =?utf-8?B?UjJoNzV5TUs3TVpOaVYxN21pOXhRL3IzalN0MitiV3N1NXVldFdRbTdLdUJt?=
 =?utf-8?B?N1NnUXhITmVqSEM5RGo5T3ZnbWNMTjBUcy9YUVhhTHo4cHpsMGRkcENYOU8y?=
 =?utf-8?B?RlcyVUd5KzE5VExUWkpzR3FTeDdEOUhCbkZLcThaNEU1OGg3Wi9LVi9ITUY3?=
 =?utf-8?B?cVB0QXVJa3RPaTN5TkRRK1dOd3JCblptVkNOYmgreTBhaW1oZ2xQbTRTTzk4?=
 =?utf-8?B?VHN1SFR1NDN0L1lkODF5dlhacVdMU3liTTBMS1VrZ3lQUm1kZ2MrR0cvczBw?=
 =?utf-8?B?SE9INDJpQXJhUkRkWmV3VHRLY1ZGQkI5SllIa2JFUmt0UlAyR3NkVXpHSkZJ?=
 =?utf-8?B?cng2YnM5ZE9GT2tBbTBZM0R6Y3Rwa0hkSHplaFJ1TU05ZTY0SzMwRWNjaDZj?=
 =?utf-8?B?M0FBS0NCVlZ0N1lqVjg1cUdEQm96Z0JVdTJEOUpURDRHakk2d0NmSEx1OCtJ?=
 =?utf-8?B?SlFDaDJZaGFUVjlaRkgvRUE2NlhTK3Z2Vkc2bVU2MUxaODhYOU9vdDJuVnov?=
 =?utf-8?B?YnpSbHRBMXVhaCtJT1RUazYxMzMvNkdSeFdTWjVUVHExNUIydFZ0eW9tY2pR?=
 =?utf-8?B?dUFQeE1Ua2dVU1Q4cnNtUUc0TXRiQ2duTE9TVTNDaEJCTlN0UW1OUWtLU05M?=
 =?utf-8?Q?c2cMbjEgzwqYZAR0tnFYK++ua?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 388f92f9-e1b2-4fc6-7417-08dabbd2098e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 06:26:40.7172 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IChPo83uWQZ+AEOvLbI4CO6T5xor4AL+uewau0WP1xwVHL/dn/rW0jfRLNI1/Uhg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6203
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



On 10/29/2022 4:17 AM, Felix Kuehling wrote:
> On 2022-10-27 04:14, Ma Jun wrote:
>> For some GPUs with more CUs, the original sibling_map[32]
>>
>> in struct crat_subtype_cache is not enough
>>
>> to save the cache information when create the VCRAT table,
>>
>> so skip filling the struct crat_subtype_cache info instead
>>
>> fill struct kfd_cache_properties directly to fix this problem.
>>
>> v3:
>> - Drop processor id calc function
>> v2:
>> - Remove unnecessary sys interface "cache_ext"
>>
>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 307 +++-------------------
>>   drivers/gpu/drm/amd/amdkfd/kfd_crat.h     |  12 +
>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 238 ++++++++++++++++-
>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.h |   5 +-
>>   4 files changed, 278 insertions(+), 284 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>> index d25ac9cbe5b2..8b7e34b45740 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> [snip]
>> +int get_gpu_cache_info(struct kfd_dev *kdev, struct kfd_gpu_cache_info **pcache_info)
>>   {
>> -	struct kfd_gpu_cache_info *pcache_info;
>>   	struct kfd_gpu_cache_info cache_info[KFD_MAX_CACHE_TYPES];
>>   	int num_of_cache_types = 0;
>> -	int i, j, k;
>> -	int ct = 0;
>> -	int mem_available = available_size;
>> -	unsigned int cu_processor_id;
>> -	int ret;
>> -	unsigned int num_cu_shared;
>>   
>>   	switch (kdev->adev->asic_type) {
> [snip]
>>
>>   	default:
>>   		switch (KFD_GC_VERSION(kdev)) {
> [snip]
>>   		case IP_VERSION(11, 0, 0):
>>   		case IP_VERSION(11, 0, 1):
>>   		case IP_VERSION(11, 0, 2):
>>   		case IP_VERSION(11, 0, 3):
>> -			pcache_info = cache_info;
>> +			*pcache_info = cache_info;
> 
> This won't work. cache_info is a local variable. It will be out of scope 
> as soon as this function returns. You'll need to allocate this in some 
> data structure that will persist after the function returns. Maybe 
> expect the caller to pass in a pointer to an array in their own stack frame.

Yes, this is my mistake. Will fix in next version

> 
> 
>>   			num_of_cache_types =
>> -				kfd_fill_gpu_cache_info_from_gfx_config(kdev, pcache_info);
>> +				kfd_fill_gpu_cache_info_from_gfx_config(kdev, *pcache_info);
> [snip]
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> index e0680d265a66..dc231e248258 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> 
> [snip]
> 
>  > int kfd_topology_add_device(struct kfd_dev *gpu)
>>   {
>>   	uint32_t gpu_id;
>> @@ -1759,6 +1970,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>>   			topology_crat_proximity_domain--;
>>   			return res;
>>   		}
>> +
>>   		res = kfd_parse_crat_table(crat_image,
>>   					   &temp_topology_device_list,
>>   					   proximity_domain);
>> @@ -1771,23 +1983,31 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>>   
>>   		kfd_topology_update_device_list(&temp_topology_device_list,
>>   			&topology_device_list);
>> +		up_write(&topology_lock);
> 
> I'm not sure if dropping and re-taking the topology lock here could lead 
> to race conditions. But this could be avoided, if you moved the 
> responsibility for topology locking out of kfd_assign_gpu and into the 
> caller (kfd_topology_add_device).

Thanks for review.Will fix in next version.

Regards,
Ma Jun
> 
> Regards,
>    Felix
> 
> 
>> +
>> +		dev = kfd_assign_gpu(gpu);
>> +		if (WARN_ON(!dev)) {
>> +			res = -ENODEV;
>> +			goto err;
>> +		}
>> +
>> +		down_write(&topology_lock);
>> +
>> +		/* Fill the cache affinity information here for the GPUs
>> +		 * using VCRAT
>> +		 */
>> +		kfd_fill_cache_non_crat_info(dev, gpu);
>>   
>>   		/* Update the SYSFS tree, since we added another topology
>>   		 * device
>>   		 */
>>   		res = kfd_topology_update_sysfs();
>>   		up_write(&topology_lock);
>> -
>>   		if (!res)
>>   			sys_props.generation_count++;
>>   		else
>>   			pr_err("Failed to update GPU (ID: 0x%x) to sysfs topology. res=%d\n",
>>   						gpu_id, res);
>> -		dev = kfd_assign_gpu(gpu);
>> -		if (WARN_ON(!dev)) {
>> -			res = -ENODEV;
>> -			goto err;
>> -		}
>>   	}
>>   
>>   	dev->gpu_id = gpu_id;
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
>> index dc4e239c8f8f..3e8ac87f0ac9 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
>> @@ -87,6 +87,8 @@ struct kfd_mem_properties {
>>   	struct attribute	attr_used;
>>   };
>>   
>> +#define CACHE_SIBLINGMAP_SIZE 64
>> +
>>   struct kfd_cache_properties {
>>   	struct list_head	list;
>>   	uint32_t		processor_id_low;
>> @@ -97,10 +99,11 @@ struct kfd_cache_properties {
>>   	uint32_t		cache_assoc;
>>   	uint32_t		cache_latency;
>>   	uint32_t		cache_type;
>> -	uint8_t			sibling_map[CRAT_SIBLINGMAP_SIZE];
>> +	uint8_t			sibling_map[CACHE_SIBLINGMAP_SIZE];
>>   	struct kfd_dev		*gpu;
>>   	struct kobject		*kobj;
>>   	struct attribute	attr;
>> +	uint32_t		sibling_map_size;
>>   };
>>   
>>   struct kfd_iolink_properties {
