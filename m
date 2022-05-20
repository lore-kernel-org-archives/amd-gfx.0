Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C72B6C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 20 May 2022 15:13:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 373E910E2AA;
	Fri, 20 May 2022 15:13:05 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82C6E10E2AA
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 May 2022 15:13:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfHIuhDRJeZg2sV33c6K7Ee/ybk2ibdKMoxsRoXa3bzOM9aBIMRjxODqRC08P6BNkonLObPjFbIiUzA75hMDZmY2Qf63pkhW3pRheOH6omKyjnlLEeDmnqzkLIIT70zy9F95h/4W3mrHRi0m121y2SY+dAFXM9oW6SQ9tcBbld26qPd9OqELxXBraomtInLzhH73uusOMQGVfSxhc/yCfrVy0P+o4Tk+bip1su1n0CmDhCS98Gl5+qBpgIE98QlotpQY4RJyYR1c+NmOvysdV+a+b2wbOThbZFBd31SN7KuwwCKA9O2tDxapqxchzdCd+3iZ34S/CcpwX8F+0Q9+lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3kkaCw5kNF5HKoFVZ0Ep6O75lVd8VNTtt14Ad4xhA4=;
 b=OT+vpgh9MrhPNpLy1st1mAa3/UzpsjELQkvD2aHdy+VY5+uCV1vaujLVIdgwKSWje6nYO4SEEKDlCuEJOkEe5FbiFs4OFjC0NFY5F/cJLTySM1g7FiOltxnjDoxabPtw1blovS+qjzNVVVZUYdJ4fJaky0Lq3L3E5AgWF/V1dve2p1CybD9bWE7jDs1mTtO0v3RXEmDD3UZL0m03MMj5nkTE9SzwF9PkXCCHFpzMX8TPTlF9k84SEHRZAbSYUs+zq4OoDcxI9anu23VzBBgx9eAZcvz/PmMq3P2lgxw50qvE4K3gH1tNpiafpi9yFjjp/wvxxsn66qG7INkzQhwksg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3kkaCw5kNF5HKoFVZ0Ep6O75lVd8VNTtt14Ad4xhA4=;
 b=Mq4+7NAhkM6wjssHu2T6hLEVJOWMbCyMSP2q4MoB84J7opPvAeQZjIvjipScycvmFETEYFVoxJHH4xEaZFwNuBrmUrIDQtL/DsOwUkkDSOjUDuvclHotkV2J+P05K3r57Fny6HXIsetDKV06AmJRgnXQsWYRPu+TYSXrSvaLTI4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BYAPR12MB4727.namprd12.prod.outlook.com (2603:10b6:a03:99::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Fri, 20 May
 2022 15:12:59 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5273.018; Fri, 20 May 2022
 15:12:59 +0000
Message-ID: <0838194e-91d8-de41-aa7e-87531498a953@amd.com>
Date: Fri, 20 May 2022 11:12:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] drm/amdkfd: track unified memory reservation with
 xnack off
Content-Language: en-US
To: philip yang <yangp@amd.com>, Alex Sierra <alex.sierra@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220519162153.6268-1-alex.sierra@amd.com>
 <20220519162153.6268-2-alex.sierra@amd.com>
 <9ec46333-ec80-f258-febc-7c7110cecf56@amd.com>
 <d9242fbb-fb5e-e03a-fc04-4732c310c947@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <d9242fbb-fb5e-e03a-fc04-4732c310c947@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0122.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::31) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f60da2e-0580-4a68-6084-08da3a7339e7
X-MS-TrafficTypeDiagnostic: BYAPR12MB4727:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB4727E9EBCB04CB283A6EFEAB92D39@BYAPR12MB4727.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G4uDgRL/Qc/Xmc9nZdNRP+Eu7JzmrpwcmjMaqeTkQz9aCYgkSx1RdWYovTnCPNCr8ibsUVhJB6j6WeaeNqIppCPa08i+/d8Iu1WeAOmTlZh4TyNx1SOf8+o/H1jIEFaYimIU4nswTmyfU6po7ve26XDdgntU1xaWSy5w/XDzbNlAWbXApLjqILDkkBQD9ktKWLu5sKCHv3EB/CswhZJtnKknyIuyXKSN4v5Lv/FLxbC8fT0oNqEoSOG9gS0zo0Zf5LX04DotGjUv8Uk542B3SoWEFkd+giz8ivm9uwHMAl5rwlSzB0KnICOsowBMLWFRfUzlEAuM185VAz75FRzYwUj/dVZzGgXHOazTZJnnYRmRl90zf7nTk6xTlWatxGNNheUqBCdthWJrUB01pli2WgL2A4ZtfDPtTa4ml06sAmFtPcmkZMVBEBrwOAZk/uVaJoRBA8Vpn61ca/1POCAI7YdVrWEbRGkK/fOZ338qFifULZ75zwjJOHJfIg/379cIApk1DD3n7crqTkiImPmiAovMCGRRZ2FAHwnKBmiV3FH1+4wc4rea7AX+FvHufUYKEXjo+3I6ZNRPuQgVZFD8aa0w+1i9s+MwFPonbezdQ7ojKSvoGJH4JE1xhtlGsXx6JNIAMTLp1ovGxwhx0I6+hAg8gTjH253iGhRUnTbxB8iBu7NTD6/qdnFcx9xu8NKNAniprNVPFPXKckRx2ALeTzvbfoeT80+YoJLh5W6YvTI3GExXD2Sy/KcLikqjGpSk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6512007)(2616005)(26005)(31686004)(316002)(6506007)(5660300002)(110136005)(38100700002)(2906002)(53546011)(66556008)(86362001)(66476007)(66946007)(31696002)(186003)(8676002)(8936002)(44832011)(36756003)(508600001)(83380400001)(6486002)(30864003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vy9zd2RMUWhCOVJWUHNxT3NUcGxqUnlWUVpaSDZxZURrdWxSdHBlUWN5MUNJ?=
 =?utf-8?B?Sk9IQ1hiZDh3dWFvRWZ6cjB4djMwU0dHcDl5WWVCVVQxSVpNOXVxMXRZRDEr?=
 =?utf-8?B?Wm5saDhWVFp2Y056Q1FBVEFKV2Y1Z2Iza3lDZTFUWnpKcXpVNUZDcUhMQVNo?=
 =?utf-8?B?emVPQlZCOXptaXJHckhmWUZaUW1ZN21xMTRxS3QzRW0ybGFCbVZBS1JTWGtW?=
 =?utf-8?B?NXpsOGxzV2xpQTIwUVBJaXJhWS9NajRzM2NWSEw4S1VvQjlMUEVKVHNIdlFw?=
 =?utf-8?B?aE1ZT0FsVUtEMk9pMUorKzRWUUtmaUQzbGNNOXdubWpWT2NXUEpMbTVFVmtk?=
 =?utf-8?B?Sk16QU5USkwzckVwWUlta2tRMXV6NzU5T1A3Qy9OUUFhVTRNQktjTy9lVTlG?=
 =?utf-8?B?Rmp0VFJEaGdLRUJzcGtMd0FYM09BMW5sVjlmVWpoUm1oaVVkd2pvd1RZdGxD?=
 =?utf-8?B?S0NPUjhnTHk1cC9kSUluY1VZcnRqZjV1MUYvMnVxaUNTc0Zhb2RpcjdRcHlq?=
 =?utf-8?B?R1VzZWFlUWhOWEtYRU5GMlpIR1g4eGZIVTB0YldPbU0yNGV3VnNaaXJsUnBW?=
 =?utf-8?B?ZlJFZDVUV0o4RWRBb3lPazl3Mk9OanRFMkl0dXhGUGoxdTlBSkRVWnVjcEJR?=
 =?utf-8?B?OU1pcUxCY3JLMmJqRmxHYlZHSkdrQUJDeUNiQnRZR3dOZDlBdkNIK051Z3dw?=
 =?utf-8?B?bkRFQWFHbFN1SG9UYUxDMkJvZ2t2K2E5MTI0ZkN6NjUzNjI0dWVpdE5YdVZN?=
 =?utf-8?B?eENTcDh1MHZLN0lWdk5kWHh1Q1BoWEIwMzZrbVJvMVU5ci84dG1lQ0N4eFFV?=
 =?utf-8?B?UnlITzNRUkEwcG56Y212WmNJRVZEbVlEZUxUUzRteUxRaFMwTWF6MlJndVNs?=
 =?utf-8?B?eStpUWZkTlJwcEE3YnFuRnZlbTVmdXR5SncxVTRiZUdGeXA0aE1nY2hDc0Jp?=
 =?utf-8?B?eTNPZi9XbXlYZW9rWFZuWGFwZWM4WER1OFN4Mk43UEJjT3lzMS9CcmhpTzlL?=
 =?utf-8?B?bEdWcUdYWTZ1NjB2elM4a1NVVFVPRS8rSGdtdktBN0d1aEIzaUtNdllUOHpV?=
 =?utf-8?B?OUxreVV0Z0lyeWdIZEt1MFErRHptZjFEUDE3NkpKcUJzU2xveU5JY1lhaVpq?=
 =?utf-8?B?b3JPWWlpZzB6TmpGa3UyVnFkVmpCTGtNdlNIdFRWR3lxZTRnZTEvYXFSRVhv?=
 =?utf-8?B?dW05dVo4YVN5RjUzTGR3NzU1VGtqZk5mYmFuNE45QXdBWVVTOVh0UmF3MG1W?=
 =?utf-8?B?ZURYVHFEWCtKTzN5Z3ZqdEpRYzZsdCtBMlUvcEUxRHlDNmthTmlScHFxdWZp?=
 =?utf-8?B?Sm5PUXpjdGNaWWhzVGlNT05VUUsxNjBJeGpMa1l1L3hqclF4ak8rd3JWR1lT?=
 =?utf-8?B?UW1wZFpxem9CckdjZXR1OXZnelNsVmVMYXU2VjV5NDl2ZEhuV053allRdGFw?=
 =?utf-8?B?b1JqdkNPTjVYV2FORW00Sm9ybVVuWTNFL1BPQUdzSmk2WUY0Nk8xbEJXUUcr?=
 =?utf-8?B?Vld3NmxjOEZHUVJKTlptK1BpcFM3NXFjbTRPejM5TmVOanY5MFRhdDlZTjNt?=
 =?utf-8?B?RXRvYUIrMzhWQlE1T1M3aGkwSzZTcHdvME50eE9UQVJNZUhaWGo4M01kT1gr?=
 =?utf-8?B?SHdDdVdYVFBrTDNFSWt5djlBUTRBYys3Sm1TbTIvcnJUQjdubEFKUmsyNkRJ?=
 =?utf-8?B?Qzl6WjVYYnZsUmtIVUhpVmtCRW5OZjFva0dzSGxUNkoyUkV6dmxsQ3VCRGx3?=
 =?utf-8?B?MlRiTlRaYXViUkM0NXRtQlY0MEVFYU9TVXlzN3FCOGg5RHhSc1NMcDk1Q3lL?=
 =?utf-8?B?NG03WmJtSnIvL2MyME1ib0FpL3JjeTJMNUNHNFZmWGFxR2lVdUdWU1htK293?=
 =?utf-8?B?WmZ2QStIaU44SXJTczRVTzc1VWVyL043U2FWZ1B1eTl2WkpacktIRFcvM25i?=
 =?utf-8?B?WEtzNnVhc0VIMHpNTmU0ZXlPRklick5SMFdFOE91dXZtNi9OQ3hKYmhXTzBh?=
 =?utf-8?B?THRRVlFUUXhrcks0K092c0NKb25hL2xGQWJETnpuM245ZUt1Y1VkSGhhcG5Q?=
 =?utf-8?B?WVVwRzVuNnU4b0ZpcS84TEdMdm96Syt1anJXeUE0Z1lzT04ySnNxSWNEeCtw?=
 =?utf-8?B?aXcyNXR3d2U5c1IySzd2ZGFNbkpES2tzOWNQeHZ4Q3ZoMVZpZzFzWUFQWDRR?=
 =?utf-8?B?aCtSTThKMU9lUHAxdDB4dDdaUmh4eEczRjlKWTQwcTBJbnI4N3VDaTBRSjBs?=
 =?utf-8?B?VWxHc3YzMmtBeFJZbWliK3NmRjZwV0JJa1IwRE1pZWxPYlJNRXNEbEx1d3Vr?=
 =?utf-8?B?K202NEtXOXowSWlPcDFSLzlLVmo4UEhOQ3lpRzdxMnFDN2ZWZ3hzZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f60da2e-0580-4a68-6084-08da3a7339e7
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 15:12:59.5336 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lt0FT5N1hXiieFQtXE8t+4lSqrCBiy0RcqsGc+FczWv2orEyYA+E/fIWonyQuDL88Ecy7ik9PBKvSeWNZfKqJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4727
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


Am 2022-05-20 um 08:45 schrieb philip yang:
>
>
> On 2022-05-19 19:08, Felix Kuehling wrote:
>> Am 2022-05-19 um 12:21 schrieb Alex Sierra:
>>> [WHY]
>>> Unified memory with xnack off should be tracked, as userptr mappings
>>> and legacy allocations do. To avoid oversuscribe system memory when
>>> xnack off.
>>> [How]
>>> Exposing functions reserve_mem_limit and unreserve_mem_limit to SVM
>>> API and call them on every prange creation and free.
>>>
>>> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  4 +++
>>>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 24 +++++++------
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          | 34 
>>> ++++++++++++++-----
>>>   3 files changed, 43 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> index f8b9f27adcf5..f55f34af6480 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> @@ -301,6 +301,10 @@ bool amdgpu_amdkfd_bo_mapped_to_dev(struct 
>>> amdgpu_device *adev, struct kgd_mem *
>>>   void amdgpu_amdkfd_block_mmu_notifications(void *p);
>>>   int amdgpu_amdkfd_criu_resume(void *p);
>>>   bool amdgpu_amdkfd_ras_query_utcl2_poison_status(struct 
>>> amdgpu_device *adev);
>>> +int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>>> +        uint64_t size, u32 alloc_flag);
>>> +void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
>>> +        uint64_t size, u32 alloc_flag);
>>>     #if IS_ENABLED(CONFIG_HSA_AMD)
>>>   void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> index 966714dd764b..615e2b34fe12 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> @@ -122,7 +122,7 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t 
>>> size)
>>>    *
>>>    * Return: returns -ENOMEM in case of error, ZERO otherwise
>>>    */
>>> -static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>>> +int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>>>           uint64_t size, u32 alloc_flag)
>>>   {
>>>       uint64_t reserved_for_pt =
>>> @@ -157,8 +157,8 @@ static int 
>>> amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>>>            kfd_mem_limit.max_system_mem_limit && 
>>> !no_system_mem_limit) ||
>>>           (kfd_mem_limit.ttm_mem_used + ttm_mem_needed >
>>>            kfd_mem_limit.max_ttm_mem_limit) ||
>>> -        (adev->kfd.vram_used + vram_needed >
>>> -         adev->gmc.real_vram_size - reserved_for_pt)) {
>>> +        (adev && (adev->kfd.vram_used + vram_needed >
>>> +         adev->gmc.real_vram_size - reserved_for_pt))) {
>>>           ret = -ENOMEM;
>>>           goto release;
>>>       }
>>> @@ -166,7 +166,8 @@ static int 
>>> amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>>>       /* Update memory accounting by decreasing available system
>>>        * memory, TTM memory and GPU memory as computed above
>>>        */
>>> -    adev->kfd.vram_used += vram_needed;
>>> +    if (adev)
>>> +        adev->kfd.vram_used += vram_needed;
>>
>> Add a WARN_ONCE(vram_needed && !adev).
>>
>>
>>>       kfd_mem_limit.system_mem_used += system_mem_needed;
>>>       kfd_mem_limit.ttm_mem_used += ttm_mem_needed;
>>>   @@ -175,7 +176,7 @@ static int 
>>> amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>>>       return ret;
>>>   }
>>>   -static void unreserve_mem_limit(struct amdgpu_device *adev,
>>> +void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
>>>           uint64_t size, u32 alloc_flag)
>>>   {
>>>       spin_lock(&kfd_mem_limit.mem_limit_lock);
>>> @@ -184,7 +185,8 @@ static void unreserve_mem_limit(struct 
>>> amdgpu_device *adev,
>>>           kfd_mem_limit.system_mem_used -= size;
>>>           kfd_mem_limit.ttm_mem_used -= size;
>>>       } else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
>>> -        adev->kfd.vram_used -= size;
>>> +        if (adev)
>>
>> Add a WARN_ONCE(!adev) here.
>>
>>
>>> +            adev->kfd.vram_used -= size;
>>>       } else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
>>>           kfd_mem_limit.system_mem_used -= size;
>>>       } else if (!(alloc_flag &
>>> @@ -193,9 +195,9 @@ static void unreserve_mem_limit(struct 
>>> amdgpu_device *adev,
>>>           pr_err("%s: Invalid BO type %#x\n", __func__, alloc_flag);
>>>           goto release;
>>>       }
>>> -
>>> -    WARN_ONCE(adev->kfd.vram_used < 0,
>>> -          "KFD VRAM memory accounting unbalanced");
>>> +    if (adev)
>>> +        WARN_ONCE(adev->kfd.vram_used < 0,
>>> +            "KFD VRAM memory accounting unbalanced");
>>
>> This could be simplified to WARN_ONCE(adev && adev->kfd.vram_used < 
>> 0, ...).
>>
>>
>>> WARN_ONCE(kfd_mem_limit.ttm_mem_used < 0,
>>>             "KFD TTM memory accounting unbalanced");
>>>       WARN_ONCE(kfd_mem_limit.system_mem_used < 0,
>>> @@ -211,7 +213,7 @@ void amdgpu_amdkfd_release_notify(struct 
>>> amdgpu_bo *bo)
>>>       u32 alloc_flags = bo->kfd_bo->alloc_flags;
>>>       u64 size = amdgpu_bo_size(bo);
>>>   -    unreserve_mem_limit(adev, size, alloc_flags);
>>> +    amdgpu_amdkfd_unreserve_mem_limit(adev, size, alloc_flags);
>>>         kfree(bo->kfd_bo);
>>>   }
>>> @@ -1601,7 +1603,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>>>       /* Don't unreserve system mem limit twice */
>>>       goto err_reserve_limit;
>>>   err_bo_create:
>>> -    unreserve_mem_limit(adev, size, flags);
>>> +    amdgpu_amdkfd_unreserve_mem_limit(adev, size, flags);
>>>   err_reserve_limit:
>>>       mutex_destroy(&(*mem)->lock);
>>>       if (gobj)
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index 835b5187f0b8..1380c2fee0dc 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -261,11 +261,21 @@ void svm_range_free_dma_mappings(struct 
>>> svm_range *prange)
>>>     static void svm_range_free(struct svm_range *prange)
>>>   {
>>> +    uint64_t size = (prange->last - prange->start + 1) << PAGE_SHIFT;
>>> +    struct kfd_process *p;
>>> +
>>>       pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx]\n", 
>>> prange->svms, prange,
>>>            prange->start, prange->last);
>>>         svm_range_vram_node_free(prange);
>>>       svm_range_free_dma_mappings(prange);
>>> +
>>> +    p = container_of(prange->svms, struct kfd_process, svms);
>>
>> You could initialize p in the variable declaration above.
>>
>>
>>> +    if (!p->xnack_enabled) {
>>> +        pr_debug("unreserve mem limit: %lld\n", size);
>>> +        amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
>>> +                    KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
>>> +    }
>>>       mutex_destroy(&prange->lock);
>>>       mutex_destroy(&prange->migrate_mutex);
>>>       kfree(prange);
>>> @@ -284,7 +294,7 @@ svm_range_set_default_attributes(int32_t 
>>> *location, int32_t *prefetch_loc,
>>>     static struct
>>>   svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
>>> -             uint64_t last)
>>> +             uint64_t last, bool is_new_alloc)
>>>   {
>>>       uint64_t size = last - start + 1;
>>>       struct svm_range *prange;
>>> @@ -293,6 +303,15 @@ svm_range *svm_range_new(struct svm_range_list 
>>> *svms, uint64_t start,
>>>       prange = kzalloc(sizeof(*prange), GFP_KERNEL);
>>>       if (!prange)
>>>           return NULL;
>>> +
>>> +    p = container_of(svms, struct kfd_process, svms);
>>> +    if (!p->xnack_enabled && is_new_alloc &&
>>> +        amdgpu_amdkfd_reserve_mem_limit(NULL, size << PAGE_SHIFT,
>>> +                        KFD_IOC_ALLOC_MEM_FLAGS_USERPTR)) {
>>> +        pr_info("SVM mapping failed, exceeds resident system memory 
>>> limit\n");
>>> +        kfree(prange);
>>> +        return NULL;
>>> +    }
>>>       prange->npages = size;
>>>       prange->svms = svms;
>>>       prange->start = start;
>>> @@ -307,7 +326,6 @@ svm_range *svm_range_new(struct svm_range_list 
>>> *svms, uint64_t start,
>>>       mutex_init(&prange->migrate_mutex);
>>>       mutex_init(&prange->lock);
>>>   -    p = container_of(svms, struct kfd_process, svms);
>>>       if (p->xnack_enabled)
>>>           bitmap_copy(prange->bitmap_access, svms->bitmap_supported,
>>>                   MAX_GPU_INSTANCE);
>>> @@ -1000,9 +1018,9 @@ svm_range_split(struct svm_range *prange, 
>>> uint64_t start, uint64_t last,
>>>         svms = prange->svms;
>>>       if (old_start == start)
>>> -        *new = svm_range_new(svms, last + 1, old_last);
>>> +        *new = svm_range_new(svms, last + 1, old_last, false);
>>>       else
>>> -        *new = svm_range_new(svms, old_start, start - 1);
>>> +        *new = svm_range_new(svms, old_start, start - 1, false);
>>>       if (!*new)
>>>           return -ENOMEM;
>>>   @@ -1825,7 +1843,7 @@ static struct svm_range 
>>> *svm_range_clone(struct svm_range *old)
>>>   {
>>>       struct svm_range *new;
>>>   -    new = svm_range_new(old->svms, old->start, old->last);
>>> +    new = svm_range_new(old->svms, old->start, old->last, false);
>>
>> This won't work as intended. When a range gets cloned, one of the 
>> clones will be freed later. So when freeing that clone, you also need 
>> to skip unreserving its space, because the other clone is still 
>> holding it.
>
> Thanks Felix for catching this, svm_range_free should skip unreserving 
> the cloned ranges from remove_list, otherwise we don't account 
> overlapped head or tail range size now.
>
Also, in the error handling case of svm_range_add, we have to skip 
unreserving the cloned ranges being freed from the insert_list.

Regards,
   Felix


> Regards,
>
> Philip
>
>>
>> Regards,
>>   Felix
>>
>>
>>>       if (!new)
>>>           return NULL;
>>>   @@ -1951,7 +1969,7 @@ svm_range_add(struct kfd_process *p, 
>>> uint64_t start, uint64_t size,
>>>             /* insert a new node if needed */
>>>           if (node->start > start) {
>>> -            prange = svm_range_new(svms, start, node->start - 1);
>>> +            prange = svm_range_new(svms, start, node->start - 1, 
>>> true);
>>>               if (!prange) {
>>>                   r = -ENOMEM;
>>>                   goto out;
>>> @@ -1967,7 +1985,7 @@ svm_range_add(struct kfd_process *p, uint64_t 
>>> start, uint64_t size,
>>>         /* add a final range at the end if needed */
>>>       if (start <= last) {
>>> -        prange = svm_range_new(svms, start, last);
>>> +        prange = svm_range_new(svms, start, last, true);
>>>           if (!prange) {
>>>               r = -ENOMEM;
>>>               goto out;
>>> @@ -2585,7 +2603,7 @@ svm_range 
>>> *svm_range_create_unregistered_range(struct amdgpu_device *adev,
>>>           last = addr;
>>>       }
>>>   -    prange = svm_range_new(&p->svms, start, last);
>>> +    prange = svm_range_new(&p->svms, start, last, true);
>>>       if (!prange) {
>>>           pr_debug("Failed to create prange in address [0x%llx]\n", 
>>> addr);
>>>           return NULL;
