Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294EDC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 18 May 2022 21:40:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 453B610E21B;
	Wed, 18 May 2022 21:40:47 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35AD710E21B
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 May 2022 21:40:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USg/Bp9LpyTJGIS7cXwRc6HiDJ+thiDNLNEh50oAWITzYQxem4RouRwv+d98FngwI7NJlIx8UzLgEvE3rO3Qt1pBkgkNx6BuG+d3UG+wMUusmU91ExYixviJlfiyZUXyK3j85OkFDYwBdY4mRcuK4Uc7+dqIKJYGF48WnLDh2ykbFScCZmNNi2GF5M3cS/qOYjDxwro9/8usHeiWYw+xku+VYcC83lqjx9e8hFd3e+LbPkY97XOdANsp5/BL1eI55PScGbgrSvgWFzVtwvIIkZDsgnHm/NAu52IJfaePSwklUDbvgdP8QGxgql3ESC/oT6aNeP9L2IqVkyhPVtpA6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aK20uA+Da/gbAMORXpEyVDZ1cSiGXY+fidBr1EgBTu4=;
 b=hQ5ZJ7vVIUctInWEVD2qh9hdDYClm0WVPUj/cdxB+ojsB+RGLwWNI47P1Ham/7zPV8Ah7eeWzkJdtzPWyQLqHdL5jBO//7tTXf5hZ9uY22doQfdKgwWtPnwkGW30F1/U3zfSyQHP0+QIR9rPm2XTSUzYXYR8yfrCTNBIKPVNkjF7ZbvxPW6KKy/KP0h8jET/eTac44OnUiSmGWd7N/bPPpcUKU84YzqwobB9gFOZZ8cUBsiJbp6htyEEuCKJSu9Imgs48hR5nGvd7RR94v/U0HRZ+cvlboRVC65iQPSntqJkeUB9wfbnGwsCP/73WiqEbnHCnxfvatQ01FrcmfTrug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aK20uA+Da/gbAMORXpEyVDZ1cSiGXY+fidBr1EgBTu4=;
 b=UDCoJRnidcKzGooa9Qqup9m/L2qSee2XGR5TtPlwXtSw8VlhxSp7wXZ/Nt6B1NdlgNrZs7z6LzLMPEcn5cJkBXrsm3yQceBY1NNjsGbEUyczIyjC7y1M/G2ayVxMcm5l1rKQg9Re20ybymX/EK0oz9HqwialXtguTgwx9bX2CVc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM5PR1201MB0028.namprd12.prod.outlook.com (2603:10b6:4:5a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Wed, 18 May
 2022 21:40:43 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5273.013; Wed, 18 May 2022
 21:40:43 +0000
Message-ID: <55882ef2-9dc7-36cb-1d60-2c868ea1c14c@amd.com>
Date: Wed, 18 May 2022 17:40:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] drm/amdkfd: track unified memory reservation with
 xnack off
Content-Language: en-US
To: philip yang <yangp@amd.com>, Alex Sierra <alex.sierra@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220517231108.14048-1-alex.sierra@amd.com>
 <20220517231108.14048-2-alex.sierra@amd.com>
 <e225fdde-d11a-2d83-c129-393f7284a6d2@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <e225fdde-d11a-2d83-c129-393f7284a6d2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::7) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f81ae3a-1182-4be7-86ec-08da39170f3b
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0028:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0028F38A1DA5CD2B374FB72092D19@DM5PR1201MB0028.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dTEo3mQSFDmeJzipWgWt+mufURQzhbFP1osQ0Ekw+SmXng48wXslQVgrvU/jG2FBEOcUFGKQ7XxBGvwP+axedYYwrbze6iDUEaKc/sUZduKlRG/YfL6+Cn9LCAAnytS6kBY/uAwuwv1e/VhuUvyj0KkfTQivnMsOxUxRud0Ze9+J0P7T5I2Fr9R30D6S+TKkPoe5dcI/JYIeyehRusCtDBWqWatb4jBl30IcmDgQHhBQ5M9rh/C5DsKOXJgtXuxyTYoUIWwRyY+OKgY7Gw8XzyPJYFdqN5UrLDLF0/8sGciDDqDpBn79Bwsazz1RXKw5uAsSNOSaY27C6wM29CPpJDxrc9aBg4+TWHO9jD6g7gr+JuV8dI/6FtaB/iQYcAQ61yxQC5N3TjUUyn6tGRiuknlNrnaGetxUlKAcgqNG4G2cMRtdu5c7GQ9uxpxd1h98ZmWAQknHekDyh5WJOgQLShLiQy4a6u7ycr4mWskMckiTzDs7L8xW9GVOwY+RpvD6OfbbTZYgaEYKIDAaVfSizKEhMSZwhLj9T/hj5PUaa4fqPvywVboRFYAJ1KyhujCg4FsOP7+V+u37G2dFqKKWK+bb9Ttj6dXUVu5zKkTs8Ur42GwEmg1hCjFhCvTrM1PJGawjYpyfcesz7J7N8Pkd4svhSMbPHQYxvLALQgGnawuBDTlV7OD0JTRp5UEn353zA9B/UuwPAUrO8ZtlmojMe3aZqBa70S1SMe6loh6mN6O0kPZVaRifs3a9Qs53Umdr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(2616005)(31696002)(186003)(2906002)(66476007)(66556008)(66946007)(5660300002)(44832011)(31686004)(86362001)(36756003)(6486002)(53546011)(6506007)(110136005)(83380400001)(508600001)(6512007)(30864003)(316002)(8936002)(38100700002)(36916002)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGpZS2Q2bkdLU0NkUG8yUjBBL3gveFBWTmdnWGY0c2RMMUM2ditHUVg5dUM2?=
 =?utf-8?B?UmtQeXlMQXdOTk5xSmZGU1R1VG5mdk04cEE3azVObitIUUQ1ZUphM1ZXVlJ2?=
 =?utf-8?B?ZmMzazBpS2hzaUsveEYxZ003VkdTeXlKQlpGSXdUZThET2g4aUd4ekxqYUtO?=
 =?utf-8?B?ZjZ1MEoyUlQ4dHU1YkhGZ3o0QnZtY3hQdENtdlF0c3ovcE80eXZXb2YwMktN?=
 =?utf-8?B?SC93Vjc5WkJ3UTdXU3pTZ1h4d2x6ZUNwQTFXdjlyTlk2OFpTSmFiLy9vVUhW?=
 =?utf-8?B?YkdwNGhFS29JM1ZFaU1LczV3ZjhHaCtWeXExcjRGRTRxWmlGRTVXVEkzU3hi?=
 =?utf-8?B?RWVJaDRqUFJVZEE2YmIxSVZQUHZlc3lOenBGRW5UbjNOVURNYXJqb1liakEv?=
 =?utf-8?B?bW95MGNsRU16MEpxZG5ZK0g2R0RoejZKQ0FQL1p2UkY0ekFFRUlRZHovbUpJ?=
 =?utf-8?B?OW9Kbm4wejcycDNUNUNGNHRTSVhpQjRoT2JSQ1FKdlBvZjd3dE5aZmpKN1dO?=
 =?utf-8?B?YnJIaUNWWGhobkRyaERNeGJKUm9OUWx1ekszSzNEVmlFazhBSHp2ZThDTnhG?=
 =?utf-8?B?dGttQkw4SnppY1FVNjBCODl4RjVBVUdZVzRscThzYTV3bFlXSUQxOWpPOUVU?=
 =?utf-8?B?STNXckFnME9IR1NmNGVKKzROa0o5ZGc2dlp4Y0NjeU5SVEFVN3ZQbG1vMUdQ?=
 =?utf-8?B?VmUrY1V1aEtMb2JmRzI1akJpTW9lckVrdzF3OStCNnV1OWFhQkRjbUNld0R6?=
 =?utf-8?B?WGZIRG1FLzhWVVZKVFBNUzU1ellFTHRqRW51eFdETHRJajA1NURVeWtZNkZa?=
 =?utf-8?B?S0lxc0JwUmJOdDZERHZnM25IYzVDUHEyRmVpSnU4QUhvcXJZbWpBcVV1V1p3?=
 =?utf-8?B?NFB0WWlZM3RtN29OS1ZaeE4vL09WTWJ4VE02Z2JkRlZaR3BUM1ZGK3pLUjBi?=
 =?utf-8?B?ME5SVjFsMkxnODFhRjNqRWNYSUZIejk3NmJJa3lIaFpJZlVqM05TYUFsRFBR?=
 =?utf-8?B?V1ZhQStxK0tlNmlFYkxzckxiLzJoaDA2akpEWFdpdHpYcFFyTC9sVEl6Q2Q3?=
 =?utf-8?B?MFpKR1M0OGk2MGowT3FHYTlCQXNtSmVPaGJUb2xuR1R2aU9Mc3h2NUlYMlBO?=
 =?utf-8?B?OS9YT01yWUJPNkl5OUNlUHdVUDRGbjF1RU9ybithV0U4Z1IvSGpCVERFY011?=
 =?utf-8?B?RWo5Y3haM01qRW9sZUhmRlJpdHhRenc3em5iTm5kaXpDbFhiVVRLcGp1a1dr?=
 =?utf-8?B?M3grRGJ4b1dsSmVjNGxiNkovWUZ5NkpFa1hHM294MHJ6M0lldlk2bnVIeUNj?=
 =?utf-8?B?VXRiUzRmUldpdTRBSjNid3RsUnBuOU9BZEdVeFRmTmFSZzVRZi9Uc1BWR1A4?=
 =?utf-8?B?Wis4bjhMdGd2cWNMY0s2ejBsaFJXMDhvUVNLZmtlRUUyZ1VrcHcyaGEwbE9T?=
 =?utf-8?B?R2o5K3hYNnhLa1ZXN09NV2xWOHNPTWNBK3MwdzNBS2VVMVRJM0hwV1ZtUXN3?=
 =?utf-8?B?b3VLMmNicnd3UXcwcWxEQmk3TWpQS2ZIb3Z0YVphQ1V2R0xLTyt2SjlYNVpx?=
 =?utf-8?B?cDJkbDZNVklHaXRhWFJnVE9QczhKOU1Nb1d6blkzUC9NbHpTLzVZKzNZdVA5?=
 =?utf-8?B?MFZnT1Q3OEhNOVIzWVY0VUszUzdabGRxNGU0eWxidVpSK3p5cXFBTzVOVDNx?=
 =?utf-8?B?YzNsRFB4NFIyV1gxdTRaMmlTandsU1dMdWg3dVo3YWtRVXB4dkJSWjJkUk4w?=
 =?utf-8?B?L28wZ1dLcUNBWTZnODdZdWlxQ0JHWlZRWFRXTTA2WEFMcTNHbjg2N0NUYnAz?=
 =?utf-8?B?Y2cyZHJCZUMwR21GZFJsMUpVekhlL1NHWUhLUmRLRG9pSE1IL2lGVzVUb3BH?=
 =?utf-8?B?cDR1TzczQkF3NUdqRmpTMzd3RVJyZjkvYk5FMzNCVlZ6RVRCV2ZpQWNZNmdE?=
 =?utf-8?B?R1lhL2FnRENrdy96WksxMWNmQ3U3Q2J2UVRzc1ZJcVlrL1YwNWdlaEF1VDVB?=
 =?utf-8?B?YzhQOHhoNGI2d3ZlRzdwQnJDNml5SzVNRGp2QjFVWTZDTk9ZUHZ0QU1DM1NX?=
 =?utf-8?B?WFB5NlJ2THBXdi9FSWI5MlhpdE5QWFRteDBzTmNlWTJ1RWlQenlXSnpSZWRF?=
 =?utf-8?B?ODE4TEdCb0YrWGVoN2dwQXZmWk0yemF4UlEyNFRMb2R1L3VidVJtZk5KMExu?=
 =?utf-8?B?QTlSY2h1TzUvbmhoVXdyZXUvREUyT2F3TnlzVERuWkczZER6L0xJdHY2L3pT?=
 =?utf-8?B?THR4em4rRVZtTzNjNnIwajl0cUZhdUVGQWRUZlIyVkdFd3JPbk9qN0JkZERF?=
 =?utf-8?B?WVc0bjRFdEw1Vm5KZW9DdTNXYWVyeGs5QzFLNFpmZi9oSkZELzB0Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f81ae3a-1182-4be7-86ec-08da39170f3b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 21:40:43.0655 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /YH+ST6Yu+mziFs96TYHAVn0wCEsQZqeZdoNlAzjfw6HgiH1NmFLzrQ0bYL16lluf4OnDH0txq3GNwKMvXFxcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0028
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


On 2022-05-18 14:36, philip yang wrote:
>
>
> On 2022-05-17 19:11, Alex Sierra wrote:
>> [WHY]
>> Unified memory with xnack off should be tracked, as userptr mappings
>> and legacy allocations do. To avoid oversuscribe system memory when
>> xnack off.
>> [How]
>> Exposing functions reserve_mem_limit and unreserve_mem_limit to SVM
>> API and call them on every prange creation and free.
>>
>> Signed-off-by: Alex Sierra<alex.sierra@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  4 +++
>>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 24 +++++++------
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          | 34 ++++++++++++++-----
>>   3 files changed, 43 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> index f8b9f27adcf5..f55f34af6480 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> @@ -301,6 +301,10 @@ bool amdgpu_amdkfd_bo_mapped_to_dev(struct amdgpu_device *adev, struct kgd_mem *
>>   void amdgpu_amdkfd_block_mmu_notifications(void *p);
>>   int amdgpu_amdkfd_criu_resume(void *p);
>>   bool amdgpu_amdkfd_ras_query_utcl2_poison_status(struct amdgpu_device *adev);
>> +int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>> +		uint64_t size, u32 alloc_flag);
>> +void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
>> +		uint64_t size, u32 alloc_flag);
>>   
>>   #if IS_ENABLED(CONFIG_HSA_AMD)
>>   void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index e985cf9c7ec0..b2236159ff39 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -122,7 +122,7 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
>>    *
>>    * Return: returns -ENOMEM in case of error, ZERO otherwise
>>    */
>> -static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>> +int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>>   		uint64_t size, u32 alloc_flag)
>>   {
>>   	uint64_t reserved_for_pt =
>> @@ -157,8 +157,8 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>>   	     kfd_mem_limit.max_system_mem_limit && !no_system_mem_limit) ||
>>   	    (kfd_mem_limit.ttm_mem_used + ttm_mem_needed >
>>   	     kfd_mem_limit.max_ttm_mem_limit) ||
>> -	    (adev->kfd.vram_used + vram_needed >
>> -	     adev->gmc.real_vram_size - reserved_for_pt)) {
>> +	    (adev && (adev->kfd.vram_used + vram_needed >
>> +	     adev->gmc.real_vram_size - reserved_for_pt))) {
>>   		ret = -ENOMEM;
>>   		goto release;
>>   	}
>> @@ -166,7 +166,8 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>>   	/* Update memory accounting by decreasing available system
>>   	 * memory, TTM memory and GPU memory as computed above
>>   	 */
>> -	adev->kfd.vram_used += vram_needed;
>> +	if (adev)
>> +		adev->kfd.vram_used += vram_needed;
>>   	kfd_mem_limit.system_mem_used += system_mem_needed;
>>   	kfd_mem_limit.ttm_mem_used += ttm_mem_needed;
>>   
>> @@ -175,7 +176,7 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>>   	return ret;
>>   }
>>   
>> -static void unreserve_mem_limit(struct amdgpu_device *adev,
>> +void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
>>   		uint64_t size, u32 alloc_flag)
>>   {
>>   	spin_lock(&kfd_mem_limit.mem_limit_lock);
>> @@ -184,7 +185,8 @@ static void unreserve_mem_limit(struct amdgpu_device *adev,
>>   		kfd_mem_limit.system_mem_used -= size;
>>   		kfd_mem_limit.ttm_mem_used -= size;
>>   	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
>> -		adev->kfd.vram_used -= size;
>> +		if (adev)
>> +			adev->kfd.vram_used -= size;
>>   	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
>>   		kfd_mem_limit.system_mem_used -= size;
>>   	} else if (!(alloc_flag &
>> @@ -193,9 +195,9 @@ static void unreserve_mem_limit(struct amdgpu_device *adev,
>>   		pr_err("%s: Invalid BO type %#x\n", __func__, alloc_flag);
>>   		goto release;
>>   	}
>> -
>> -	WARN_ONCE(adev->kfd.vram_used < 0,
>> -		  "KFD VRAM memory accounting unbalanced");
>> +	if (adev)
>> +		WARN_ONCE(adev->kfd.vram_used < 0,
>> +			"KFD VRAM memory accounting unbalanced");
>>   	WARN_ONCE(kfd_mem_limit.ttm_mem_used < 0,
>>   		  "KFD TTM memory accounting unbalanced");
>>   	WARN_ONCE(kfd_mem_limit.system_mem_used < 0,
>> @@ -211,7 +213,7 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
>>   	u32 alloc_flags = bo->kfd_bo->alloc_flags;
>>   	u64 size = amdgpu_bo_size(bo);
>>   
>> -	unreserve_mem_limit(adev, size, alloc_flags);
>> +	amdgpu_amdkfd_unreserve_mem_limit(adev, size, alloc_flags);
>>   
>>   	kfree(bo->kfd_bo);
>>   }
>> @@ -1601,7 +1603,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>>   	/* Don't unreserve system mem limit twice */
>>   	goto err_reserve_limit;
>>   err_bo_create:
>> -	unreserve_mem_limit(adev, size, flags);
>> +	amdgpu_amdkfd_unreserve_mem_limit(adev, size, flags);
>>   err_reserve_limit:
>>   	mutex_destroy(&(*mem)->lock);
>>   	if (gobj)
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 5ed8d9b549a4..e7e9b388fea4 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -261,11 +261,21 @@ void svm_range_free_dma_mappings(struct svm_range *prange)
>>   
>>   static void svm_range_free(struct svm_range *prange)
>>   {
>> +	uint64_t size = (prange->last - prange->start + 1) << PAGE_SHIFT;
>> +	struct kfd_process *p;
>> +
>>   	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx]\n", prange->svms, prange,
>>   		 prange->start, prange->last);
>>   
>>   	svm_range_vram_node_free(prange);
>>   	svm_range_free_dma_mappings(prange);
>> +
>> +	p = container_of(prange->svms, struct kfd_process, svms);
>> +	if (!p->xnack_enabled) {
>> +		pr_debug("unreserve mem limit: %lld\n", size);
>> +		amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
>> +					KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
>> +	}
>>   	mutex_destroy(&prange->lock);
>>   	mutex_destroy(&prange->migrate_mutex);
>>   	kfree(prange);
>> @@ -284,7 +294,7 @@ svm_range_set_default_attributes(int32_t *location, int32_t *prefetch_loc,
>>   
>>   static struct
>>   svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
>> -			 uint64_t last)
>> +			 uint64_t last, bool is_new_alloc)
>>   {
>>   	uint64_t size = last - start + 1;
>>   	struct svm_range *prange;
>> @@ -293,6 +303,15 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
>>   	prange = kzalloc(sizeof(*prange), GFP_KERNEL);
>>   	if (!prange)
>>   		return NULL;
>> +
>> +	p = container_of(svms, struct kfd_process, svms);
>> +	if (!p->xnack_enabled && is_new_alloc &&
>> +	    amdgpu_amdkfd_reserve_mem_limit(NULL, size << PAGE_SHIFT,
>> +					    KFD_IOC_ALLOC_MEM_FLAGS_USERPTR)) {
> The range will create svm_bo to migrate to VRAM, so count acc_size is 
> correct.

I'm not sure how to understand this comment. The thing is, the VRAM BO 
can be evicted without losing functionality. So I don't think we need to 
track potential VRAM usage of SVM ranges. We only need to account for 
system memory usage. That includes the system memory being mapped, and 
maybe the prange structures and dma_addr arrays used for the mapping. 
However, like I said, the old acc_size isn't really suitable for that 
because it doesn't account for mappings on multiple GPUs.

The dma address arrays take 1/512 of the memory size, per GPU. Even on 
an 8GPU system, that's only 1/64 of the memory size. So I think the 
15/16 system memory limit still leaves enough room for those data 
structures. If that gets too tight, we may just decide to use a lower 
system memory limit, or change the system memory limit based on the 
number of GPUs in the system. That would be easier than accurately 
tracking the data structure sizes for each allocation and potentially 
each mapping on a multi-GPU system.

Regards,
   Felix


>> +		pr_err("Failed to allocate usrptr memory\n");
>> +		kfree(prange);
>> +		return NULL;
>> +	}
>>   	prange->npages = size;
>>   	prange->svms = svms;
>>   	prange->start = start;
>> @@ -307,7 +326,6 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
>>   	mutex_init(&prange->migrate_mutex);
>>   	mutex_init(&prange->lock);
>>   
>> -	p = container_of(svms, struct kfd_process, svms);
>>   	if (p->xnack_enabled)
>>   		bitmap_copy(prange->bitmap_access, svms->bitmap_supported,
>>   			    MAX_GPU_INSTANCE);
>> @@ -1000,9 +1018,9 @@ svm_range_split(struct svm_range *prange, uint64_t start, uint64_t last,
>>   
>>   	svms = prange->svms;
>>   	if (old_start == start)
>> -		*new = svm_range_new(svms, last + 1, old_last);
>> +		*new = svm_range_new(svms, last + 1, old_last, false);
>>   	else
>> -		*new = svm_range_new(svms, old_start, start - 1);
>> +		*new = svm_range_new(svms, old_start, start - 1, false);
>>   	if (!*new)
>>   		return -ENOMEM;
>>   
>> @@ -1825,7 +1843,7 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
>>   {
>>   	struct svm_range *new;
>>   
>> -	new = svm_range_new(old->svms, old->start, old->last);
>> +	new = svm_range_new(old->svms, old->start, old->last, true);
>
> clone prange is not new memory allocation, use false.
>
> Regards,
>
> Philip
>
>>   	if (!new)
>>   		return NULL;
>>   
>> @@ -1951,7 +1969,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>>   
>>   		/* insert a new node if needed */
>>   		if (node->start > start) {
>> -			prange = svm_range_new(svms, start, node->start - 1);
>> +			prange = svm_range_new(svms, start, node->start - 1, true);
>>   			if (!prange) {
>>   				r = -ENOMEM;
>>   				goto out;
>> @@ -1967,7 +1985,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>>   
>>   	/* add a final range at the end if needed */
>>   	if (start <= last) {
>> -		prange = svm_range_new(svms, start, last);
>> +		prange = svm_range_new(svms, start, last, true);
>>   		if (!prange) {
>>   			r = -ENOMEM;
>>   			goto out;
>> @@ -2585,7 +2603,7 @@ svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
>>   		last = addr;
>>   	}
>>   
>> -	prange = svm_range_new(&p->svms, start, last);
>> +	prange = svm_range_new(&p->svms, start, last, true);
>>   	if (!prange) {
>>   		pr_debug("Failed to create prange in address [0x%llx]\n", addr);
>>   		return NULL;
