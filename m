Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37DD4CDB483
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Oct 2023 07:25:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B838210E279;
	Tue, 17 Oct 2023 07:25:39 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2052.outbound.protection.outlook.com [40.107.101.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B816E10E279
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Oct 2023 07:25:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fuJQyPj9vw1AGN7LInzPPIpgwHIgD6MFRTE9BOiMcpv0tVjpb1F6q7UzTjQNpqjZ8PyUHVFftXw6FM3tWbYbpdVAV8hfVLqWT0nM1GACSbRbdJ+/WXgs1gsUXmWgRNppNWM9wuWc3DPNFeW8qT20sKnjMLYCmz4UQ0Kcht2kvM+IpiR5Gix20scv59InpyuX3Y1ZBAi0YlO6GS+ynB3RAS/XW2tRhI1o4wEUjpihxGfsXPucqlW2ItftMaXCQ2dB31lKozHc4qiD7RVaGA3vcn3gjxG3/QqKSUk4wZwKc386yWfVPqAVJPorh42zsMNrTO6O8u72r8ALm+hdFqcIKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OohYgXN7m6sHUjSCbnaSBQ3DXtvTuG+bVgKnsemK/wY=;
 b=Ov4B5sIlyI6Qz967H5dlPujZmh2OySCpOiTSS2y5ryk/8Mgsxo7X/RKxnBiR9E6quCfSZly6cLrc8jx1HXSRkiW0a6bVkIi1sOkhY39VCaglgtR43itiDptrqHPiUJuvbgEDZPWpoqI/h1zkNHt9tNOLYfqlCU74JP6XPH3WWMFqj2vYGusu/YHJxgfg1iuyJoTk7qBaE2OvwRb8828tgrA02180xIh0IYgALwP+4ryiv4ggSJh6M501r6AXJ0RPgYpFAvIzPxS8pL1xhpNFt+5Cb3VgrFNDWT+75egUDGcFKZvjvn6Ry5H3Kox19/WnWWh8hCwxZjCWZhql909+jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OohYgXN7m6sHUjSCbnaSBQ3DXtvTuG+bVgKnsemK/wY=;
 b=mXDbbMkvcIX9vhyI9pP6rgr6xXk41jMVLcbHj/Dn+RATaeNlK9sZVmEcnMa5DPaSvEgb1fxtpBYFadqrlG7F2y9xUrgRB90zdu6TB3azzfyNrZ47osOU/3GmfmMs+74S/MVCJgM7+AKxBn/QOtc2JWuYsUIEChjLF3yuRfaPmHI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by BN9PR12MB5353.namprd12.prod.outlook.com (2603:10b6:408:102::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 07:25:34 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::c65c:9847:210d:2f2d]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::c65c:9847:210d:2f2d%7]) with mapi id 15.20.6863.046; Tue, 17 Oct 2023
 07:25:33 +0000
Message-ID: <3c1b3f96-1456-506e-0914-504e64d247f7@amd.com>
Date: Tue, 17 Oct 2023 09:25:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] drm/amdgpu: move task_info to amdgpu_fpriv
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231016170820.979-1-shashank.sharma@amd.com>
 <b6709537-e2a4-4694-b5a6-862212ed0cbf@amd.com>
 <b096e8d1-e8ed-4e72-8282-c8cc5d32616b@amd.com>
Content-Language: en-US
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <b096e8d1-e8ed-4e72-8282-c8cc5d32616b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BEXP281CA0005.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::15)
 To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|BN9PR12MB5353:EE_
X-MS-Office365-Filtering-Correlation-Id: 20e1152f-f94f-4d52-19cf-08dbcee23fcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W1WEgJ7WTYf2BWfcrLlKGVRFZsY14C/SX4vYdBLNfrkHWh5quuBYehJFrbk9oVJEzDv3nrhbxExmjG8G8g91Y7FPAr9Lft3svKgn3Lpe31Dme5FQ1Fy3VECVr9upAYBriV6cx7Rj0xj7bDUvQEevOgzivUUmeMEvqDmSLo4HVKAGIWR8YA2z3l5YP9ZdgPQBKOnt5a0+nN50fiBVb8DJvUAn9B/RbXHHN1qslu09r30i/sSW2wADod+fRhfHpiEWXepDvsum6KWrHDS7t9rdSFJknVE/enZJE8p+mzBTAxhNHT+sr5acL4/VzEn4SQKpZnPoLyaLlZm/y6EQpQY8bGQGHPAFs3NopPgrTEU4/XxPR6n6yixmV2CPPAI2Q6zsVsbyrivyfFzzsnKfJ61uDljzUZRS5fN5QvMRk3+DpiGumYwerlY4sp6ie+DV9T90o82C1d4aCnrzgmHknE9VkhvX0QAdOi7LeKN0D3hvRk0LIOXtFB5yHX93gS/xPTh2KPiDUuZ0IHLCBTQBJZy6FYdm3WV3llSd/7xZxD7lwJJTxR/Hz6fmnSDohYYuqFFbNwuQWq5hjKoySuOj101SteT9d+0+IvEuKNn7GhYSsft6hIiGLqH2aOVSxfJvR5gSfN5K1DVbp0UvPaT4XnrDvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(39860400002)(346002)(396003)(366004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6486002)(316002)(66476007)(66556008)(66946007)(478600001)(2616005)(110136005)(66574015)(6506007)(26005)(6666004)(6512007)(53546011)(8936002)(5660300002)(8676002)(44832011)(30864003)(4001150100001)(2906002)(4326008)(86362001)(31696002)(41300700001)(36756003)(83380400001)(38100700002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bk1TRFFHWDU0NlpsazQ2WkZ2eFlJdllMcDMxUTZjeUovd2lGQThRL2FPMHJw?=
 =?utf-8?B?YnZVdXNva0t1T0lkMXR3MXcxSjgwM0Y3TnRVZEpVYmptbDlFWWtuSEpOZzZv?=
 =?utf-8?B?aTNaYlFZd2NrcmpuQWhHbUI3bUJZVXFFUllaMGlTWE05RUtZVmtRQ0craEwz?=
 =?utf-8?B?WHJmV0hERHpjVXp3VTY5MUJzOG5aUTgxTGRLazY4bzY1N2UzODFqWDQ4SkJX?=
 =?utf-8?B?ZGo4ZmRoc2t2VHRBYTAvK0RQcVZFSWpTZXlpR3hNOXpJOGU3UEpMbzl1MmNu?=
 =?utf-8?B?NDd2L3luNXMwVVFncmIyZGpQRVdwTVFpcjBvQnpFRUdhOWhlNlU4eS96OWdQ?=
 =?utf-8?B?bXNoV2RVRVMwZ1o5TGNJZ0k1cFgrMGlGWGZUdTc1Wmx4eloxRDZHWFR5NmF3?=
 =?utf-8?B?NVdyL05JVUYrMHJNaFd1NDFoR2dxd1kxYnBLdmtYaFYybi9wZkJDdkdOQStR?=
 =?utf-8?B?ZHNOOFgxQ2x2cHhEUGVqd0RUK3ZHbUxLUWdHNzFoWk1tcE51cmY3V1JKNm94?=
 =?utf-8?B?bnFtbERCbURNS3FBSDBta0ZsTC9yVlZtOFMrSDl3NjJkWVpOT21zWWNaSTN4?=
 =?utf-8?B?aVU1MU9LOU50eE1WYjkzWXRUcWdsbzR0M01EWGhZL2o1YlBZNVNaR005b0Zl?=
 =?utf-8?B?TmhINWdZRVpocjBQUE44NFZ1WDE4eHFYWmFDOG96cDVoOWl3MG9pMzhrWXI5?=
 =?utf-8?B?RGhyWHNyWllLM0Yrd1FUZVo5OCt6SUMzdjVQeG1CVU9jc1RQdUJJa1NCUDlh?=
 =?utf-8?B?Y1p1Ni9MWldYU1UzMitUeWg5bXhwOTBqVXJ4OVBObWN5NGYxaU4yRzF3cUtq?=
 =?utf-8?B?MXZuSGpMdW9JNndTVis3a2xkcHBybUVBWjhkN3RKUzZrMnpSSTJRQjBCV2tW?=
 =?utf-8?B?Ti9UeXpLeFFvUERSajZ6ZDA4bU1MSURUSU82dG1wRG56bDAwNGVHb0FodTFG?=
 =?utf-8?B?aEIzMjJFOE5xZnBrcXVxUE95UEtLbHVQV2VnbmxHMFBJdi9xYU9GVzdzbEVt?=
 =?utf-8?B?VUdCQXdPK0t0ajc5THlKajg1TWNKL1ExVXVRVkFLbVExMklrM3luVEdQU2cy?=
 =?utf-8?B?NGc4NkxiTUtxWUlVOHJodXVIL1RlNUVVZWFnY3RyVnJMS0JJeEtGUXJxZTc4?=
 =?utf-8?B?RVY0b3pEa0EzY1AzTjg1TVVlOEp2ZnNKd2V3cDVHM0RVZ05namVOa0hrcmVM?=
 =?utf-8?B?V3FTcmpVM01pYTk4Mm9KQm5Fd3FlUklqTkZQWnR0b1lxOFlDbENxRjVadWRN?=
 =?utf-8?B?MWJkSGMrYVVxSkMvYzdlWE01OCs4QWRVbTIvdzRjc0V2MUQvNXhDQkVRQ00r?=
 =?utf-8?B?ZlBHZm00VENmb2cvRVVzQ3dwUHZPekdENzJhYlRxd0F4QWl4ZWJuUVhJK2JX?=
 =?utf-8?B?dHFUTHhkOG9vUENwdmZMUkdqTFl5dUVtaWNEb2VzbmgzVmh1ZURLQzZEWkpj?=
 =?utf-8?B?TG1iREY1b2ZBZnFPSnRBbVl4ZXcwZkgySmhSOWJQZFBGY25vOE5iUHJCQUNt?=
 =?utf-8?B?TVQ5bWQzRWtPd3hRMys4U1FkMG90Z0ZaSVFhSGdiTHNGSkd1cjdjeEpqbkUx?=
 =?utf-8?B?T09DK0N0V1FuODFuNjVPS0NWeWxPQzRMNW5EWm5IZ2x2ZE1lVFlza2RsRkxj?=
 =?utf-8?B?NldPeXpIZDMvWXJLeVVYVkd3dXpWeDgxamlnelNDSEVSUkduUkw4U3loWFoz?=
 =?utf-8?B?R0JrekY2WTNkdHB3TEZUZkdPSnJPVE5YQ2hnSUlFTmR4enMvS2FSaGlaTmRW?=
 =?utf-8?B?WE5LRFMvVzU5VmZuck1Ea2ZRS2trYVZlQW05U0lDc3pSQm1uQlFPVGhLV3oy?=
 =?utf-8?B?RWxpbEVkYWJXbmJsS2VZRGU0Zkt1dWM5WVFhSnRURW1XTlFaaGlkR2tidmJE?=
 =?utf-8?B?cHp0TnVCaVBxSkFwMkdQZmtFRFk2SDk4TzlvSUVKYUs3bUdrQTJaK3VQQ1NI?=
 =?utf-8?B?bXNOQThINDU1Y1FtSHVrWjZ6SHc3OVVFWHhDTFNMM0Y2WHVDaG9Qby9IbmJj?=
 =?utf-8?B?RVIwN0srZFdadytqd2R0ZVFPeThwRURxcGI4Zy9KaFZPcEljNHFWZHk3VjVy?=
 =?utf-8?B?Nkd5Z3NqZXZDL1lseWtFN1h6Y0xxa1lDTm9oYlY2dWZrSnpsOUxOcDg5NnVF?=
 =?utf-8?Q?JzgUsLYguYTLBUPmFCeRGDiDr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e1152f-f94f-4d52-19cf-08dbcee23fcd
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 07:25:33.4645 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iztQWUgNMdjWQ1CqJcGqWFpi//XuuiKg3ZJgNhv3THliSfPK3vrNC1n35mtLVT4mMklYEvPlnkk9rxKjOuAhRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5353
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello Christian, Felix,

Thanks for your comments, mine inline.

On 17/10/2023 07:55, Christian König wrote:
> Am 17.10.23 um 00:15 schrieb Felix Kuehling:
>> On 2023-10-16 13:08, Shashank Sharma wrote:
>>> This patch does the following:
>>> - moves vm->task_info struct to fpriv->task_info.
>>> - makes task_info allocation dynamic.
>>> - adds reference counting support for task_info structure.
>>> - adds some new helper functions to find and put task_info.
>>> - adds respective supporting changes for existing get_task_info 
>>> consumers.
>>>
>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  2 +
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  4 +-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 28 +++++--
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     | 16 ++--
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 87 
>>> ++++++++++++++++-----
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  9 +--
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |  5 +-
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c      | 19 +++--
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c      | 18 +++--
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c       | 17 ++--
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c       | 19 +++--
>>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c      | 19 ++---
>>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c    | 20 ++---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 14 ++--
>>>   14 files changed, 186 insertions(+), 91 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index dc2d53081e80..a90780d38725 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -469,6 +469,8 @@ struct amdgpu_fpriv {
>>>       struct mutex        bo_list_lock;
>>>       struct idr        bo_list_handles;
>>>       struct amdgpu_ctx_mgr    ctx_mgr;
>>> +    struct amdgpu_task_info *task_info;
>>> +
>>>       /** GPU partition selection */
>>>       uint32_t        xcp_id;
>>>   };
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> index a4faea4fa0b5..6e9dcd13ee34 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> @@ -1763,9 +1763,11 @@ static int amdgpu_debugfs_vm_info_show(struct 
>>> seq_file *m, void *unused)
>>>       list_for_each_entry(file, &dev->filelist, lhead) {
>>>           struct amdgpu_fpriv *fpriv = file->driver_priv;
>>>           struct amdgpu_vm *vm = &fpriv->vm;
>>> +        struct amdgpu_task_info *task_info = fpriv->task_info;
>>>             seq_printf(m, "pid:%d\tProcess:%s ----------\n",
>>> -                vm->task_info.pid, vm->task_info.process_name);
>>> +                task_info ? task_info->pid : 0,
>>> +                task_info ? task_info->process_name : "");
>>>           r = amdgpu_bo_reserve(vm->root.bo, true);
>>>           if (r)
>>>               break;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 3f001a50b34a..b372a87b9b77 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -4872,6 +4872,27 @@ static void 
>>> amdgpu_reset_capture_coredumpm(struct amdgpu_device *adev)
>>>       dev_coredumpm(dev->dev, THIS_MODULE, adev, 0, GFP_NOWAIT,
>>>                 amdgpu_devcoredump_read, amdgpu_devcoredump_free);
>>>   }
>>> +
>>> +static void
>>> +amdgpu_reset_dev_coredump(struct amdgpu_device *adev, struct 
>>> amdgpu_reset_context *reset_context)
>>> +{
>>> +    struct amdgpu_task_info *ti;
>>> +    struct amdgpu_vm *vm;
>>> +
>>> +    if (!reset_context->job || !reset_context->job->vm)
>>> +        return;
>>> +
>>> +    vm = reset_context->job->vm;
>>> +
>>> +    /* Get reset task info and save a copy of data to be consumed 
>>> later */
>>> +    ti = amdgpu_vm_get_task_info(adev, vm->pasid);
>>> +    if (ti) {
>>> +        adev->reset_task_info = *ti;
>>> +        amdgpu_reset_capture_coredumpm(adev);
>>> +    }
>>> +
>>> +    amdgpu_vm_put_task_info(adev, vm->pasid);
>>> +}
>>>   #endif
>>>     int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>>> @@ -4976,12 +4997,7 @@ int amdgpu_do_asic_reset(struct list_head 
>>> *device_list_handle,
>>>                   vram_lost = amdgpu_device_check_vram_lost(tmp_adev);
>>>   #ifdef CONFIG_DEV_COREDUMP
>>>                   tmp_adev->reset_vram_lost = vram_lost;
>>> -                memset(&tmp_adev->reset_task_info, 0,
>>> - sizeof(tmp_adev->reset_task_info));
>>> -                if (reset_context->job && reset_context->job->vm)
>>> -                    tmp_adev->reset_task_info =
>>> - reset_context->job->vm->task_info;
>>> -                amdgpu_reset_capture_coredumpm(tmp_adev);
>>> +                amdgpu_reset_dev_coredump(tmp_adev, reset_context);
>>>   #endif
>>>                   if (vram_lost) {
>>>                       DRM_INFO("VRAM is lost due to GPU reset!\n");
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> index 78476bc75b4e..99cf30c0bce6 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> @@ -35,7 +35,7 @@ static enum drm_gpu_sched_stat 
>>> amdgpu_job_timedout(struct drm_sched_job *s_job)
>>>   {
>>>       struct amdgpu_ring *ring = to_amdgpu_ring(s_job->sched);
>>>       struct amdgpu_job *job = to_amdgpu_job(s_job);
>>> -    struct amdgpu_task_info ti;
>>> +    struct amdgpu_task_info *ti;
>>>       struct amdgpu_device *adev = ring->adev;
>>>       int idx;
>>>       int r;
>>> @@ -48,7 +48,6 @@ static enum drm_gpu_sched_stat 
>>> amdgpu_job_timedout(struct drm_sched_job *s_job)
>>>           return DRM_GPU_SCHED_STAT_ENODEV;
>>>       }
>>>   -    memset(&ti, 0, sizeof(struct amdgpu_task_info));
>>>       adev->job_hang = true;
>>>         if (amdgpu_gpu_recovery &&
>>> @@ -58,12 +57,15 @@ static enum drm_gpu_sched_stat 
>>> amdgpu_job_timedout(struct drm_sched_job *s_job)
>>>           goto exit;
>>>       }
>>>   -    amdgpu_vm_get_task_info(ring->adev, job->pasid, &ti);
>>>       DRM_ERROR("ring %s timeout, signaled seq=%u, emitted seq=%u\n",
>>> -          job->base.sched->name, 
>>> atomic_read(&ring->fence_drv.last_seq),
>>> -          ring->fence_drv.sync_seq);
>>> -    DRM_ERROR("Process information: process %s pid %d thread %s pid 
>>> %d\n",
>>> -          ti.process_name, ti.tgid, ti.task_name, ti.pid);
>>> +           job->base.sched->name, 
>>> atomic_read(&ring->fence_drv.last_seq),
>>> +           ring->fence_drv.sync_seq);
>>> +
>>> +    ti = amdgpu_vm_get_task_info(ring->adev, job->pasid);
>>> +    if (ti)
>>> +        DRM_ERROR("Process information: process %s pid %d thread %s 
>>> pid %d\n",
>>> +               ti->process_name, ti->tgid, ti->task_name, ti->pid);
>>> +    amdgpu_vm_put_task_info(ring->adev, job->pasid);
>>> dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index f5daadcec865..aabfbb8edb2b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -2335,6 +2335,7 @@ void amdgpu_vm_fini(struct amdgpu_device 
>>> *adev, struct amdgpu_vm *vm)
>>>         root = amdgpu_bo_ref(vm->root.bo);
>>>       amdgpu_bo_reserve(root, true);
>>> +    amdgpu_vm_put_task_info(adev, vm->pasid);
>>>       amdgpu_vm_set_pasid(adev, vm, 0);
>>>       dma_fence_wait(vm->last_unlocked, false);
>>>       dma_fence_put(vm->last_unlocked);
>>> @@ -2491,26 +2492,44 @@ int amdgpu_vm_ioctl(struct drm_device *dev, 
>>> void *data, struct drm_file *filp)
>>>       return 0;
>>>   }
>>>   +static struct
>>> +amdgpu_task_info *amdgpu_vm_find_task_info(struct amdgpu_device 
>>> *adev, u32 pasid)
>>> +{
>>> +    unsigned long flags;
>>> +    struct amdgpu_vm *vm;
>>> +    struct amdgpu_fpriv *fpriv;
>>> +    struct amdgpu_task_info *task_info = NULL;
>>> +
>>> +    xa_lock_irqsave(&adev->vm_manager.pasids, flags);
>>> +
>>> +    vm = xa_load(&adev->vm_manager.pasids, pasid);
>>> +    if (vm) {
>>> +        fpriv = container_of(vm, struct amdgpu_fpriv, vm);
>>> +        task_info = fpriv->task_info;
>>> +    }
>>> +
>>> +    xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
>>> +    return task_info;
>>> +}
>>> +
>>>   /**
>>>    * amdgpu_vm_get_task_info - Extracts task info for a PASID.
>>>    *
>>>    * @adev: drm device pointer
>>>    * @pasid: PASID identifier for VM
>>> - * @task_info: task_info to fill.
>>> + *
>>> + * returns the task_info* (refrence counted) set under the vm_pasid
>>> + * user must call amdgpu_vm_put_task_info when done with the 
>>> task_info ptr
>>>    */
>>> -void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
>>> -             struct amdgpu_task_info *task_info)
>>> +struct amdgpu_task_info *amdgpu_vm_get_task_info(struct 
>>> amdgpu_device *adev, u32 pasid)
>>>   {
>>> -    struct amdgpu_vm *vm;
>>> -    unsigned long flags;
>>> -
>>> -    xa_lock_irqsave(&adev->vm_manager.pasids, flags);
>>> +    struct amdgpu_task_info *ti;
>>>   -    vm = xa_load(&adev->vm_manager.pasids, pasid);
>>> -    if (vm)
>>> -        *task_info = vm->task_info;
>>> +    ti = amdgpu_vm_find_task_info(adev, pasid);
>>> +    if (ti)
>>> +        kref_get(&ti->refcount);
>>>   -    xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
>>> +    return ti;
>>>   }
>>>     /**
>>> @@ -2520,17 +2539,49 @@ void amdgpu_vm_get_task_info(struct 
>>> amdgpu_device *adev, u32 pasid,
>>>    */
>>>   void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
>>>   {
>>> -    if (vm->task_info.pid)
>>> -        return;
>>> +    struct amdgpu_fpriv *fpriv = container_of(vm, struct 
>>> amdgpu_fpriv, vm);
>
> Big NAK to that, no idea why everybody wants to upcast the VM 
> structure to fpriv.
>
> Instead move this into the the fpriv handling in amdgpu_kms.c
If you see the existing consumers of amdgpu_vm_get_task_info(), in most 
of the cases they either have only the vm or the pasid available (Please 
see gmc_v*_0_process_interrupts, sdma_v4_*_print_iv_entry or 
kfd_smi_event_update_vmfault). Now if we want to move the task_info from 
vm to fpriv, the only way to do it without breaking these existing 
consumers, is to get fpriv from VM. If we move this handling into 
amdgpu_kms.c , then how to handle these consumers who do not have fpriv 
available with them ?
>
>>> +    struct amdgpu_task_info *task_info;
>>>   -    vm->task_info.pid = current->pid;
>>> -    get_task_comm(vm->task_info.task_name, current);
>>> +    if (fpriv->task_info)
>>> +        return;
>>>   -    if (current->group_leader->mm != current->mm)
>>> +    task_info = kzalloc(sizeof(*task_info), GFP_KERNEL);
>>> +    if (!task_info) {
>>> +        DRM_ERROR("OOM while task_info creation\n");
>>>           return;
>>> +    }
>>> +
>>> +    kref_init(&task_info->refcount);
>>> +    task_info->pid = current->pid;
>>> +    get_task_comm(task_info->task_name, current);
>>> +
>>> +    if (current->group_leader->mm != current->mm) {
>>> +        task_info->tgid = current->group_leader->pid;
>>> +        get_task_comm(task_info->process_name, current->group_leader);
>>> +    }
>>> +
>>> +    kref_get(&task_info->refcount);
>>> +    fpriv->task_info = task_info;
>>> +}
>>> +
>>> +static void amdgpu_vm_free_task_info(struct kref *kref)
>>> +{
>>> +    kfree(container_of(kref, struct amdgpu_task_info, refcount));
>>> +}
>>> +
>>> +/**
>>> + * amdgpu_vm_put_task_info - reference down the task_info ptr.
>>> + *
>>> + * @adev: drm device pointer
>>> + * @pasid: PASID identifier for VM
>>> + */
>>> +void amdgpu_vm_put_task_info(struct amdgpu_device *adev, u32 pasid)
>>> +{
>>> +    struct amdgpu_task_info *ti;
>>>   -    vm->task_info.tgid = current->group_leader->pid;
>>> -    get_task_comm(vm->task_info.process_name, current->group_leader);
>>> +    ti = amdgpu_vm_find_task_info(adev, pasid);
>> This doesn't make sense. Anyone trying to drop a reference should 
>> already have a ti * from a previous amdgpu_vm_get_task_info call. You 
>> don't need to find it again. Just pass the ti * from the caller to 
>> this function.
Agree, I will modify it.
>
> Yeah, agree completely. Additional to that one goal here was to 
> decouple the VM from the task_info.
>
> Probably best if you put the task_info structure into amdgpu_reset.h 
> and the related handling into amdgpu_kms.c or amdgpu_reset.c instead.
>
Same question as above.

- Shashank

> Regards,
> Christian.
>
>>
>> Regards,
>>   Felix
>>
>>
>>> +    if (ti)
>>> +        kref_put(&ti->refcount, amdgpu_vm_free_task_info);
>>>   }
>>>     /**
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> index 204ab13184ed..40a8c532a5ed 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> @@ -187,6 +187,7 @@ struct amdgpu_task_info {
>>>       char    task_name[TASK_COMM_LEN];
>>>       pid_t    pid;
>>>       pid_t    tgid;
>>> +    struct kref refcount;
>>>   };
>>>     /**
>>> @@ -333,9 +334,6 @@ struct amdgpu_vm {
>>>       /* Valid while the PD is reserved or fenced */
>>>       uint64_t        pd_phys_addr;
>>>   -    /* Some basic info about the task */
>>> -    struct amdgpu_task_info task_info;
>>> -
>>>       /* Store positions of group of BOs */
>>>       struct ttm_lru_bulk_move lru_bulk_move;
>>>       /* Flag to indicate if VM is used for compute */
>>> @@ -466,8 +464,9 @@ bool amdgpu_vm_need_pipeline_sync(struct 
>>> amdgpu_ring *ring,
>>>                     struct amdgpu_job *job);
>>>   void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev);
>>>   -void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
>>> -                 struct amdgpu_task_info *task_info);
>>> +struct amdgpu_task_info *
>>> +amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid);
>>> +void amdgpu_vm_put_task_info(struct amdgpu_device *adev, u32 pasid);
>>>   bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>>>                   u32 vmid, u32 node_id, uint64_t addr,
>>>                   bool write_fault);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> index 96d601e209b8..3d7a9ad963a8 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> @@ -1023,21 +1023,24 @@ int amdgpu_vm_ptes_update(struct 
>>> amdgpu_vm_update_params *params,
>>>               uint64_t upd_end = min(entry_end, frag_end);
>>>               unsigned int nptes = (upd_end - frag_start) >> shift;
>>>               uint64_t upd_flags = flags | AMDGPU_PTE_FRAG(frag);
>>> +            struct amdgpu_task_info *task_info;
>>>                 /* This can happen when we set higher level PDs to
>>>                * silent to stop fault floods.
>>>                */
>>>               nptes = max(nptes, 1u);
>>>   +            task_info = amdgpu_vm_get_task_info(adev, vm->pasid);
>>>               trace_amdgpu_vm_update_ptes(params, frag_start, upd_end,
>>>                               min(nptes, 32u), dst, incr,
>>>                               upd_flags,
>>> -                            vm->task_info.tgid,
>>> +                            task_info ? task_info->tgid : 0,
>>>                               vm->immediate.fence_context);
>>>               amdgpu_vm_pte_update_flags(params, to_amdgpu_bo_vm(pt),
>>>                              cursor.level, pe_start, dst,
>>>                              nptes, incr, upd_flags);
>>>   +            amdgpu_vm_put_task_info(adev, vm->pasid);
>>>               pe_start += nptes * 8;
>>>               dst += nptes * incr;
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> index fa87a85e1017..14ded13c8b09 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> @@ -107,7 +107,7 @@ static int gmc_v10_0_process_interrupt(struct 
>>> amdgpu_device *adev,
>>>       struct amdgpu_vmhub *hub = &adev->vmhub[vmhub_index];
>>>       bool retry_fault = !!(entry->src_data[1] & 0x80);
>>>       bool write_fault = !!(entry->src_data[1] & 0x20);
>>> -    struct amdgpu_task_info task_info;
>>> +    struct amdgpu_task_info *task_info;
>>>       uint32_t status = 0;
>>>       u64 addr;
>>>   @@ -155,15 +155,18 @@ static int 
>>> gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
>>>       if (!printk_ratelimit())
>>>           return 0;
>>>   -    memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>>> -    amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>>> -
>>> -    dev_err(adev->dev,
>>> -        "[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, for 
>>> process %s pid %d thread %s pid %d)\n",
>>> +    dev_err(adev->dev, "[%s] page fault (src_id:%u ring:%u vmid:%u 
>>> pasid:%u)\n",
>>>           entry->vmid_src ? "mmhub" : "gfxhub",
>>>           entry->src_id, entry->ring_id, entry->vmid,
>>> -        entry->pasid, task_info.process_name, task_info.tgid,
>>> -        task_info.task_name, task_info.pid);
>>> +        entry->pasid);
>>> +
>>> +    task_info = amdgpu_vm_get_task_info(adev, entry->pasid);
>>> +    if (task_info)
>>> +        dev_err(adev->dev, "for process %s pid %d thread %s pid %d\n",
>>> +                   task_info->process_name, task_info->tgid,
>>> +                   task_info->task_name, task_info->pid);
>>> +    amdgpu_vm_put_task_info(adev, entry->pasid);
>>> +
>>>       dev_err(adev->dev, "  in page starting at address 0x%016llx 
>>> from client 0x%x (%s)\n",
>>>           addr, entry->client_id,
>>>           soc15_ih_clientid_name[entry->client_id]);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>> index e3b76fd28d15..2d96567171bc 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>> @@ -120,17 +120,21 @@ static int gmc_v11_0_process_interrupt(struct 
>>> amdgpu_device *adev,
>>>       }
>>>         if (printk_ratelimit()) {
>>> -        struct amdgpu_task_info task_info;
>>> -
>>> -        memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>>> -        amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>>> +        struct amdgpu_task_info *task_info;
>>>             dev_err(adev->dev,
>>> -            "[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, 
>>> for process %s pid %d thread %s pid %d)\n",
>>> +            "[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u)\n",
>>>               entry->vmid_src ? "mmhub" : "gfxhub",
>>>               entry->src_id, entry->ring_id, entry->vmid,
>>> -            entry->pasid, task_info.process_name, task_info.tgid,
>>> -            task_info.task_name, task_info.pid);
>>> +            entry->pasid);
>>> +
>>> +        task_info = amdgpu_vm_get_task_info(adev, entry->pasid);
>>> +        if (task_info)
>>> +            dev_err(adev->dev, " for process %s pid %d thread %s 
>>> pid %d\n",
>>> +                task_info->process_name, task_info->tgid,
>>> +                task_info->task_name, task_info->pid);
>>> +        amdgpu_vm_put_task_info(adev, entry->pasid);
>>> +
>>>           dev_err(adev->dev, "  in page starting at address 
>>> 0x%016llx from client %d\n",
>>>               addr, entry->client_id);
>>>           if (!amdgpu_sriov_vf(adev))
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>> index 5af235202513..8759ef1c5ea5 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>> @@ -1446,14 +1446,19 @@ static int gmc_v8_0_process_interrupt(struct 
>>> amdgpu_device *adev,
>>>           gmc_v8_0_set_fault_enable_default(adev, false);
>>>         if (printk_ratelimit()) {
>>> -        struct amdgpu_task_info task_info;
>>> +        struct amdgpu_task_info *task_info;
>>>   -        memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>>> -        amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>>> +        dev_err(adev->dev, "GPU fault detected: %d 0x%08x\n",
>>> +            entry->src_id, entry->src_data[0]);
>>> +
>>> +        task_info = amdgpu_vm_get_task_info(adev, entry->pasid);
>>> +        if (task_info) {
>>> +            dev_err(adev->dev, "for process %s pid %d thread %s pid 
>>> %d\n\n",
>>> +                task_info->process_name, task_info->tgid,
>>> +                task_info->task_name, task_info->pid);
>>> +        }
>>> +        amdgpu_vm_put_task_info(adev, entry->pasid);
>>>   -        dev_err(adev->dev, "GPU fault detected: %d 0x%08x for 
>>> process %s pid %d thread %s pid %d\n",
>>> -            entry->src_id, entry->src_data[0], task_info.process_name,
>>> -            task_info.tgid, task_info.task_name, task_info.pid);
>>>           dev_err(adev->dev, " VM_CONTEXT1_PROTECTION_FAULT_ADDR   
>>> 0x%08X\n",
>>>               addr);
>>>           dev_err(adev->dev, " VM_CONTEXT1_PROTECTION_FAULT_STATUS 
>>> 0x%08X\n",
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> index f9a5a2c0573e..75b849d69875 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> @@ -550,7 +550,7 @@ static int gmc_v9_0_process_interrupt(struct 
>>> amdgpu_device *adev,
>>>       bool retry_fault = !!(entry->src_data[1] & 0x80);
>>>       bool write_fault = !!(entry->src_data[1] & 0x20);
>>>       uint32_t status = 0, cid = 0, rw = 0;
>>> -    struct amdgpu_task_info task_info;
>>> +    struct amdgpu_task_info *task_info;
>>>       struct amdgpu_vmhub *hub;
>>>       const char *mmhub_cid;
>>>       const char *hub_name;
>>> @@ -625,16 +625,19 @@ static int gmc_v9_0_process_interrupt(struct 
>>> amdgpu_device *adev,
>>>       if (!printk_ratelimit())
>>>           return 0;
>>>   -
>>> -    memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>>> -    amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>>> -
>>>       dev_err(adev->dev,
>>> -        "[%s] %s page fault (src_id:%u ring:%u vmid:%u pasid:%u, 
>>> for process %s pid %d thread %s pid %d)\n",
>>> +        "[%s] %s page fault (src_id:%u ring:%u vmid:%u pasid:%u)\n",
>>>           hub_name, retry_fault ? "retry" : "no-retry",
>>>           entry->src_id, entry->ring_id, entry->vmid,
>>> -        entry->pasid, task_info.process_name, task_info.tgid,
>>> -        task_info.task_name, task_info.pid);
>>> +        entry->pasid);
>>> +
>>> +    task_info = amdgpu_vm_get_task_info(adev, entry->pasid);
>>> +    if (task_info)
>>> +        dev_err(adev->dev, " process %s pid %d thread %s pid %d\n",
>>> +            task_info->process_name, task_info->tgid,
>>> +            task_info->task_name, task_info->pid);
>>> +    amdgpu_vm_put_task_info(adev, entry->pasid);
>>> +
>>>       dev_err(adev->dev, "  in page starting at address 0x%016llx 
>>> from IH client 0x%x (%s)\n",
>>>           addr, entry->client_id,
>>>           soc15_ih_clientid_name[entry->client_id]);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>> index cd37f45e01a1..d3b9fe74332a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>> @@ -2112,7 +2112,7 @@ static int sdma_v4_0_print_iv_entry(struct 
>>> amdgpu_device *adev,
>>>                             struct amdgpu_iv_entry *entry)
>>>   {
>>>       int instance;
>>> -    struct amdgpu_task_info task_info;
>>> +    struct amdgpu_task_info *task_info;
>>>       u64 addr;
>>>         instance = sdma_v4_0_irq_id_to_seq(entry->client_id);
>>> @@ -2124,15 +2124,16 @@ static int sdma_v4_0_print_iv_entry(struct 
>>> amdgpu_device *adev,
>>>       addr = (u64)entry->src_data[0] << 12;
>>>       addr |= ((u64)entry->src_data[1] & 0xf) << 44;
>>>   -    memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>>> -    amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>>> -
>>>       dev_dbg_ratelimited(adev->dev,
>>> -           "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
>>> -           "pasid:%u, for process %s pid %d thread %s pid %d\n",
>>> -           instance, addr, entry->src_id, entry->ring_id, entry->vmid,
>>> -           entry->pasid, task_info.process_name, task_info.tgid,
>>> -           task_info.task_name, task_info.pid);
>>> +           "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u 
>>> pasid:%u\n",
>>> +           instance, addr, entry->src_id, entry->ring_id, 
>>> entry->vmid, entry->pasid);
>>> +
>>> +    task_info = amdgpu_vm_get_task_info(adev, entry->pasid);
>>> +    if (task_info)
>>> +        dev_dbg_ratelimited(adev->dev, "for process %s pid %d 
>>> thread %s pid %d\n",
>>> +                    task_info->process_name, task_info->tgid,
>>> +                    task_info->task_name, task_info->pid);
>>> +    amdgpu_vm_put_task_info(adev, entry->pasid);
>>>       return 0;
>>>   }
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c 
>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> index f413898dda37..56c2f744d64e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> @@ -1633,7 +1633,7 @@ static int sdma_v4_4_2_print_iv_entry(struct 
>>> amdgpu_device *adev,
>>>                             struct amdgpu_iv_entry *entry)
>>>   {
>>>       int instance;
>>> -    struct amdgpu_task_info task_info;
>>> +    struct amdgpu_task_info *task_info;
>>>       u64 addr;
>>>         instance = sdma_v4_4_2_irq_id_to_seq(entry->client_id);
>>> @@ -1645,15 +1645,17 @@ static int sdma_v4_4_2_print_iv_entry(struct 
>>> amdgpu_device *adev,
>>>       addr = (u64)entry->src_data[0] << 12;
>>>       addr |= ((u64)entry->src_data[1] & 0xf) << 44;
>>>   -    memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>>> -    amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>>> -
>>>       dev_dbg_ratelimited(adev->dev,
>>> -           "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
>>> -           "pasid:%u, for process %s pid %d thread %s pid %d\n",
>>> -           instance, addr, entry->src_id, entry->ring_id, entry->vmid,
>>> -           entry->pasid, task_info.process_name, task_info.tgid,
>>> -           task_info.task_name, task_info.pid);
>>> +           "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u 
>>> pasid:%u\n",
>>> +           instance, addr, entry->src_id, entry->ring_id, 
>>> entry->vmid, entry->pasid);
>>> +
>>> +    task_info = amdgpu_vm_get_task_info(adev, entry->pasid);
>>> +    if (task_info)
>>> +        dev_dbg_ratelimited(adev->dev, "for process %s pid %d 
>>> thread %s pid %d\n",
>>> +                    task_info->process_name, task_info->tgid,
>>> +                    task_info->task_name, task_info->pid);
>>> +    amdgpu_vm_put_task_info(adev, entry->pasid);
>>> +
>>>       return 0;
>>>   }
>>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
>>> index d9953c2b2661..6b51262811f6 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
>>> @@ -238,16 +238,18 @@ void 
>>> kfd_smi_event_update_thermal_throttling(struct kfd_node *dev,
>>>     void kfd_smi_event_update_vmfault(struct kfd_node *dev, uint16_t 
>>> pasid)
>>>   {
>>> -    struct amdgpu_task_info task_info;
>>> +    struct amdgpu_task_info *task_info;
>>>   -    memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>>> -    amdgpu_vm_get_task_info(dev->adev, pasid, &task_info);
>>>       /* Report VM faults from user applications, not retry from 
>>> kernel */
>>> -    if (!task_info.pid)
>>> -        return;
>>> +    task_info = amdgpu_vm_get_task_info(dev->adev, pasid);
>>> +    if (!task_info || !task_info->pid)
>>> +        goto unref;
>>>         kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT, "%x:%s\n",
>>> -              task_info.pid, task_info.task_name);
>>> +              task_info->pid, task_info->task_name);
>>> +
>>> +unref:
>>> +    amdgpu_vm_put_task_info(dev->adev, pasid);
>>>   }
>>>     void kfd_smi_event_page_fault_start(struct kfd_node *node, pid_t 
>>> pid,
>
