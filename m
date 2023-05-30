Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33398C7EE2C
	for <amd-gfx@archiver.kernel.org>; Tue, 30 May 2023 15:51:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B05810E16E;
	Tue, 30 May 2023 15:51:29 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69A2A10E16E
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 May 2023 15:51:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bpsBkhc3IlKHg3dIa2A2FHhKcLILkh9ZNSI2YNJ1+rQyxKMYvB0eTOqA1R0Su5H5fpgJKUL5vrTd2rNnTtVAeBpEYxeT8OgCi7twQCHGZtTkMt9Xd10MFwAxo5uIL97Y2L4tf7x6va17qpR1Jyhzs+48My50FPJYuFQTGxwxvQKLgTPZkdFhD6a+7uGr+jx0PigRdVZrbpa9FrcJayBMwMyMbB0eEQHfMLmiUVp9a5KKAC2gxlgcMUU7NfhipWDEGlaVZqcmG2RjRDHWv7GQOu6mPwb9R5jxXahSyFYczSK5zKNCDTFVYJWAo15gz8roZSAqgIej4R5tRbojhbfM4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nyPY9PVg6d1rcTOlQRw7qFfRAzfnsXjKIIEdr1DkK/c=;
 b=ZsMCgeYKsd3/pq6CJBwfkXDaKjyQpM39MlLAnm3xmPqiNl+LA+037rXeFoxVotlSTN4AygmspPj3PrxKC/UTtp0hFrZKihVQVi0+hTkIf5MpcUnaVeUOZBAvbateP/6iqx/I2LHscWGCFbz4L78kjM/Cklqbs6iOXlOMR0XbU4IEw5RtEjzaekl5rdTyYPzODHq0tAYg31Da7kKDNvzKyB4inIIy5DDiM/W786MLLL4y/bYPxAspK3TwgJ8AwMQtpgAEBiCPQHSEQGtw4GDpoHFj8dqIxXeAYOvBulN5UqQ2mQtE6MJPNHt1S9Sr34uIJqT1/e3GlNksMtRtl+FlhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyPY9PVg6d1rcTOlQRw7qFfRAzfnsXjKIIEdr1DkK/c=;
 b=jeihESp4nTqa6Jbc3NhLfAytC4UuqxYMcY18AEbtrfL4ye4b1N/wofG2KdG4ZiQhWIqoxrL42eQXtUUjm6sR09MD/FC074/K91E4d4jjYZljHyyJrZ2MxDi00EUxTELmzxeQwEpxoH1SVtpevvL0s7qUTm5uM9rrKf30MsyZpt0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA0PR12MB4573.namprd12.prod.outlook.com (2603:10b6:806:9c::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 15:51:25 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::943e:32fb:5204:a343]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::943e:32fb:5204:a343%3]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 15:51:24 +0000
Message-ID: <11a144a0-eee3-29c2-11e7-a89333ced706@amd.com>
Date: Tue, 30 May 2023 11:51:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: Fix up missing parameters kdoc in
 svm_migrate_vma_to_ram
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20230530045407.2266290-1-srinivasan.shanmugam@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230530045407.2266290-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0012.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::16) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SA0PR12MB4573:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b5c786a-407e-491b-aa63-08db6125b8eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M7vIuAvmfeW9UzFlHWRQsZcHuvumdONEkTkBxbNo3WUL1wRCFcQXq4Rx220TFlI1e1NlAv3rJ4XNI0nLO4w9Hx/gf5YktXNJfziMPEF59qB/66m0rvzTsC9htGmiWOUFNBv/h+vOlijDCHD8UXjaKikuwUcnGD4WXdsOzGjqtxautZcFOb2kZB/yXukPOSjqIDwDWjuweAi2oxhm0j7XGr8WyvAqE6z5U4oDAMu2n2/Da79nUTBHpsY4uB36/QL7LlxYoIH7LHNaCawZqB295MiX0yggh0nwjl7RSd/kvtT/gEudU1LaueT1/bClNDG9BfDs30ZlPZEShzBJ7iRc5+1Vryg3QeS//E6Y/f8HeEG+gSasCd9WBD088EX1zC26Y3rqGgkXruMIqA0cI541NVsAA2Qi+4MExkBT0ayDf9P+hnDGmPpQve0csDPcvkgnq0jcKym9l4w/eHwb8fNEgFaH8j4sDxbh1Q/AJYHs2d2Pvez7x3msSFWojIKVqiO2jF0P+tMuWvObuQR7qY3Hgr86Y94MbtUMd7/tDcN0Asv7oT10ybTHyx/MuFTBPTkDsGl4M6urGkx2P8/eadL4ga94mi2GkMp4rk5fTqRrtzrE1hm8yg3/RDLAIXThOWJICTT78yoJ/To4/cLmd1InFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(366004)(346002)(451199021)(31686004)(478600001)(38100700002)(86362001)(66946007)(66556008)(66476007)(83380400001)(2616005)(66574015)(110136005)(31696002)(6636002)(4326008)(2906002)(6506007)(6486002)(186003)(26005)(6512007)(316002)(36756003)(41300700001)(44832011)(5660300002)(8676002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2ZzcDl3dzNUeHFmelZwRHBzbTdheWlFOGU4NmVadUdFUlc0c2ZKd1plSGhH?=
 =?utf-8?B?Sjhram5xaERCQnN5Y1FUaU53aFVXL0ZTTi80UlBaUVgyWGtmaVRRREplanBT?=
 =?utf-8?B?SkpRUDgyQlZqVlcwUVZ6cU9WZ0gwZXBUTkVBd0hSWDNZNnR4MUw5VmlPSFVw?=
 =?utf-8?B?d1lNVG9OS09qZjZ5SnU5MEJWRUVrUlBZWE5kUm9uWVNobThNUXVYRmZHdlJV?=
 =?utf-8?B?SU0vanhJTHA2K0FROGlLdEdYWjVSK3QwTUl0VDFCWG9Sb0tXdVNBcjlleUZw?=
 =?utf-8?B?RkZpd3F6bzU1aGVNWWxkOGU0ZWNOOHQxcEN1TXRPV1NvRng3amZleU9SN0tV?=
 =?utf-8?B?Z21Ib3dxbDVCaWhIb3lyamt6Zk0vYkFGMU01b1dHdE0wdERUUnFFK2oxeFpZ?=
 =?utf-8?B?MkhrWUxZSHkrMTE5MmZmeERtalc4YzVmSW5hQmFSUW9EWHNvdm8wYVZyeG1Y?=
 =?utf-8?B?VEVyQkhhUmlhejZwSjAyOUlJRi9tazVOT2VvZ2F6QW83RDU0MkcxWjBtNjBq?=
 =?utf-8?B?TzhTbWE3WUdJS3A4dHVCb0Z4dGZuTnc0a2pqVnN5NDVCY2I3SVM3YThmemkr?=
 =?utf-8?B?b05XN0pDcmtIWTdzUVVJY3BLd0FySnVWS2NiSGhYZWZvOWJzNmMyR240SnVR?=
 =?utf-8?B?V3cwQS9yaFZ1eXFxVjBSaElvUVhReWduYnoyalpGZXI4Vm9BZVJ2QjBYRUNG?=
 =?utf-8?B?Zk92UERzZnBLRGloWFB3c1Z0NDZnQ1JaaCtRYjUwT1hTWk1zRGRaTnN6Z0tE?=
 =?utf-8?B?UGdMNHI2dmc4Wk9McEx0dkRqa2ZMOEhKYjJBRFAwdUIvaTg4QzQxUWtveHFJ?=
 =?utf-8?B?eElwVUd6TUQ4UXltNExQb21scERqYjJ6MmZhV0ZkYXlaWVpCb1ZEUWU3cStr?=
 =?utf-8?B?eXpTS3A3VGpyUVBtOHFkSXBUbmtXUU0rWVowVk5UWTVXRlY1STVtamMzUElZ?=
 =?utf-8?B?blhjR0EzenNzZnVBcTFMTzVaK3l3bUhDQm9tc1AzZ1BjYTR3NnRQYTRPU2ZY?=
 =?utf-8?B?Y2UrQUUvTlJuYVd1c2M1SC9RWHNIWEpTamRqRXdUSWtIRGt1aGZuS09RWk5s?=
 =?utf-8?B?WWhGOTFTcEpETlBCQlkrVjV2cVJNQXdQcFdtUEE2WnZyKzNiOWhxN3I1Zzh1?=
 =?utf-8?B?dUhld0RvWVc1UU5Iek9yK1MrRU0rVlMrOHpKNWlSN1pRMjBHVHlaOUJWQzF0?=
 =?utf-8?B?TUFQMTl2d0xYOU02WjYwUVZUS0pzM3VvY2IxeFNyUWFkS0dpWGJSSnBqRFJJ?=
 =?utf-8?B?YUgzWlU2RXpOc2pHdWxhZTVSTkJiZ3hKY2o1NzA2Q3BKeUQxTkpWc2x0eE5u?=
 =?utf-8?B?QXZqa0dMUXJFKzN1RklOZDFtWUlia21VVURoa1luWE5KTjRCYUh3MjBreHdT?=
 =?utf-8?B?V1I2anJkTFE1MXNjTHgxUHBLd2lQcVlISWVqS0tUYmRZSWZmbjFXZ2JHdGhI?=
 =?utf-8?B?RFIybXBKdUR6TVphV09OUFN5SE11emI2aTdRNTZpMjQwbytHdzBZRSszdyt3?=
 =?utf-8?B?TDlIUWtUdVVNdDJKOU9vMjU1alU1MlpIblAzVFZYWFlPNzNjTy9PcFo1d1dB?=
 =?utf-8?B?dEJuNkxjUzhqRmRaTVNZa2hZZUNjb2JGdUJOMm9RTUVjRVFSVmJ3T3BRRm0w?=
 =?utf-8?B?L3B2OXFua3N5ZHFlUE9zbCtrbHMzeEx0R0I1V0dKWTBUdzByNnFXT1FVSFJs?=
 =?utf-8?B?QlZrREFnMzRMY0ZIbnZSdlZoZjEwRFArZXVqY1RUL0hvdTBmeklJK3k1dkMx?=
 =?utf-8?B?eE5UQVBzRjlMWlcwZFRUUVZ4NEp5OHdPQ0NhblM5Vi9BMURHRWZTc2VZbmx0?=
 =?utf-8?B?V2FVaFQ0VXVUMmVVdkdYYnU1dzUwVlpNcmFUUXJ0UElrZ0JlTERTdzMycWtx?=
 =?utf-8?B?bDc5SXZZeUJyMURTUGdMZFRid0RPN01kaGc1djFIM2RNdnhyWjJGM0U1YUp4?=
 =?utf-8?B?WFZvYTlhdUFacXRPbEFteEtubzhTWlY3YVBJSnVhV2QwcTRQTEJyUVg2UFJG?=
 =?utf-8?B?UVcyb0tEc3JPYnFUUU1CbUZMWGNZR3dVc2RzVVFDb1puS1VIT0wrSlNtZUF1?=
 =?utf-8?B?MUZnazFxNTNJaTAwVlMyTytEcGJjdDNHZDFZcXpCWit4RzRqbE1xUUhkd1F1?=
 =?utf-8?Q?VpDlnSuFlZCNVvceRl5WbhVJS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b5c786a-407e-491b-aa63-08db6125b8eb
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 15:51:24.9011 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: id3GlRNydJAHRlxnFpKqpjOPV+FgCkN4xNWGVnACODVg5CdMxdisIMcIWojIZLLImf2G41Xg2cxEL/BL766JJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4573
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2023-05-30 um 00:54 schrieb Srinivasan Shanmugam:
> Fix these warnings by adding & deleting the deviant arguments.
>
> gcc with W=1
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_migrate.c:671: warning: Function parameter or member 'node' not described in 'svm_migrate_vma_to_ram'
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_migrate.c:671: warning: Function parameter or member 'trigger' not described in 'svm_migrate_vma_to_ram'
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_migrate.c:671: warning: Function parameter or member 'fault_page' not described in 'svm_migrate_vma_to_ram'
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_migrate.c:671: warning: Excess function parameter 'adev' description in 'svm_migrate_vma_to_ram'
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_migrate.c:771: warning: Function parameter or member 'fault_page' not described in 'svm_migrate_vram_to_ram'
>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 35cf6558cf1b..58d95fb99595 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -651,11 +651,13 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   /**
>    * svm_migrate_vma_to_ram - migrate range inside one vma from device to system
>    *
> - * @adev: amdgpu device to migrate from
>    * @prange: svm range structure
>    * @vma: vm_area_struct that range [start, end] belongs to
>    * @start: range start virtual address in pages
>    * @end: range end virtual address in pages
> + * @node: kfd node device to migrate from
> + * @trigger: reason of migration
> + * @fault_page: is from vmf->page, svm_migrate_to_ram(), this is CPU page fault callback
>    *
>    * Context: Process context, caller hold mmap read lock, prange->migrate_mutex
>    *
> @@ -760,6 +762,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>    * @prange: range structure
>    * @mm: process mm, use current->mm if NULL
>    * @trigger: reason of migration
> + * @fault_page: is from vmf->page, svm_migrate_to_ram(), this is CPU page fault callback
>    *
>    * Context: Process context, caller hold mmap read lock, prange->migrate_mutex
>    *
