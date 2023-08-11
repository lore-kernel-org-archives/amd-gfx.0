Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D0CC001B0
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 21:28:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71A9110E6FB;
	Fri, 11 Aug 2023 21:28:03 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2074.outbound.protection.outlook.com [40.107.212.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF3DB10E6FB
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 21:28:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oi/4f8zcCkUv3FeYk25ljq4c7+r3HVhaGQ6u+m2nyPdtU9cNwZolE6FR5JO2ekqfFdqg1FZ8HsMmnyfVZYMSVBiVEI8PT0xRhS6RSzddspwRRjebfd+lhrUpb8GOjUcCaSUP0IDWTzWR1TR4QdhGUGxV/P5KUePXndnhqi78fcDlPPHLJ58qc76K45tsYXSnayyW2fQGcLzC65dACawPr0T2Ou1m0fYcbmLLPZglAGr7y8ix8VLQmzBzVu7Wpm4CcCgyDXKeG7MM0vSF6+fJta4i1WEVhamf+6hG36n3CymiRa75gk0zfjkzarnxPmAB4KzNlLrQH/n6tmsRYYtp1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JW3hsDa/UQVWVdOUkPjsiQUtoqEuRtPGg6XHA898rqI=;
 b=cwbXoN+uLgPEeVXAlWdLOrKX+Lr+OO7Z/g7UR5VqyEpH6Krl+2XNWEGUf92x9uPYnxLYkbLBfh1hvNvS3AjZ7Ppz0xmiYcGuMmxDRqAayRSr7ureIHHImbC5WGEYz2km20JyotFvrH3r2zwRSPkXSE/zzrmj/F6ujX4kI3djFTKb3JjoNYtPIA830XzuPdSHLxnZvzkAcIpOyWL9YKhIjF7no/4FoxPDd6AUl5ngpTmgizya2q6P/kmWb4aIdf97Upw26oCkUXvx2eY4yJSGa+5rpUow+ExxLobhx6syUHX/NGQ8d1A1Lp59PxnLn8F/Ujf0jXWGcFUjtXHIlZcRJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JW3hsDa/UQVWVdOUkPjsiQUtoqEuRtPGg6XHA898rqI=;
 b=5ctdZ28H7czxHkpHM+OE6ENa2os+aYffKYCBprC8tY6c/lPXKNLXfy0nb9eziMuZtelEhnqkBGyPiLkZjCWIOjrEn9IItP6YsrSXVohMtAGbo+bS6ibZd7Wb7CV0jCxcxUuaW5yodpu1MxHNQ5FzuOkJ0qE+5FmKBQU8BTtYtCA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 MN2PR12MB4536.namprd12.prod.outlook.com (2603:10b6:208:263::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.20; Fri, 11 Aug
 2023 21:27:56 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::8172:fab3:9de4:a004]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::8172:fab3:9de4:a004%4]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 21:27:56 +0000
Message-ID: <5ae99973-1b5d-4672-de31-4f2f23330bb4@amd.com>
Date: Fri, 11 Aug 2023 16:27:54 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/amdkfd: add schedule to remove RCU stall on CPU
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230811191108.1808648-1-James.Zhu@amd.com>
 <3268e31b-bfd8-7e40-d7df-068f51dc8ff6@amd.com>
 <9c146294-f979-a2f9-13c9-fac588a63406@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <9c146294-f979-a2f9-13c9-fac588a63406@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR12CA0019.namprd12.prod.outlook.com
 (2603:10b6:806:6f::24) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|MN2PR12MB4536:EE_
X-MS-Office365-Filtering-Correlation-Id: e36cd5cd-80fa-49bb-76f7-08db9ab1d44c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: anjqJKJQJMDB8sYBp7BYvBmRpLgIk6p5AwBLT1+vsvNSBI8/mpkBBLgGlw9ulLSfPpR0dvWOaO+WJDl9GNr+aYNRoO2UZMMpC0j0zU4Ww4/2RF7nLkqwSMzA77obaGRHdQvQGaGIit9JJLh9Yhq00pLBb56cwgcuBi0cgAgxh/BKzaOo670D7eDjKLHCBBz5huv4Zu4ryscAJW48zcbObujcgF6rglKH8cWD7TwMKPjvZ3IjLbXzbEpfZlNZcyJQlRgp7ed4+fpFpG+rCOajgRKIZCY7oyy5K6KC8MCN5zcOK7JKQ5gXa+lW4UoEbgn92amdMNZYPJpfs4j7R3HCjD7eztF4H/O/6iSzmgm0oFBsovE4fOoY5cgEJG6WNfI8eOIhpCMwyarVlWa6TJel0Um2wiEmbJ8SVGhXbxUsu47u7wU7RtGsTtPaGGIw6EbonvT6I30X5LkEWctPnWiPaIAIIxq16Hdgm/ZPxr/rXzM23ykyPCrA0VR/frSo6YRf1LC+K4VZDHyefzCaWYdVg8lA3uhObvgATEKjTXfuHFntOQzbs0OE6Q2zOVcVw5okNxzNgCrnGqOAyInIXA/B+hCASugOCh7B9oXWW2ax7cVZ9DQATxlFT6fv7BKuQNxKxN3RhUkJ8Xb7xHg0AcF4Kg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199021)(186006)(1800799006)(6512007)(478600001)(110136005)(6486002)(2906002)(83380400001)(53546011)(26005)(2616005)(66556008)(66946007)(5660300002)(4326008)(41300700001)(8936002)(316002)(8676002)(66476007)(6506007)(86362001)(31696002)(36756003)(38100700002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sk1SMG5udThpTDFBNmNKQVJzVEVVZnE0TkM1aE1ZSWxaQzE2TU1CTUpxdVlR?=
 =?utf-8?B?eWl2U0MyU1dIZ3gzRTFCaGFDYzhZaGJ2ajh3cmdPa1Y4RWlZWVVRTGJEVHNi?=
 =?utf-8?B?akhHa2IvSUJXVDRKS01Rd3ZFczhlWkhjRENqTDkwYUpFV3FBZGIyMU9xeUFs?=
 =?utf-8?B?OU5YTXowYXZtNEtYbENVRWh0anQ1VHZncEg4bkJ0TGFCcE14VUcyTVhUN1d2?=
 =?utf-8?B?b0V2LzZSeDNORDRmbTZ6QkRQOXVsNEtEK3o1UmQ4YzQ4VldYblo1Z05LT01E?=
 =?utf-8?B?cG84S3JHOFE5TGFXdWtlVThVWWIyRU5DV3pQK2xyWXdHVW4xTkZid0F2K0x6?=
 =?utf-8?B?aTI2T0RPekQzTk5SZzBlcERqK3V2d1lDTVMyc0ZIU1BwRkZHWm5yaUxtb1R4?=
 =?utf-8?B?VkNtekJDbmRkbnVMSnJpa3p1bnRMciszSGZpTVNCWGJ1OG04SHY2dDRLNkoz?=
 =?utf-8?B?ZWo0bTBNZ2ZWU0o0V0t6OHBST1RwVlNhd0lLejNLQkc3WThTemZicm95Q3po?=
 =?utf-8?B?WGFack0xNWdhTGVIUVNmK2lJL1hBNDFQRHBDTWdwZmg1cmgxVkZIZ0w0R2V5?=
 =?utf-8?B?aThVSWs2YzdNMndEbHNSMzYxZ2NOTExtbHQzU2s1NVY1RzBydkZMc3dhS0lO?=
 =?utf-8?B?VWFjR3ZrdXBVZ0drMjV3WUtnM2hBVURHNi85RHlUQ2htdjN0MHUvZmFiTjNS?=
 =?utf-8?B?ZnQ1bU5KdXpWemVzMnFpKy9KNU40NzJjZkN0ZGVCS2Ivem1xSG5BNEdlOHE3?=
 =?utf-8?B?QVEwbzN2MEoyVXQ0S2J0OG54N1lKcDFLQnU2eFdiWUl1blNUMTVPZ1ZhTUxU?=
 =?utf-8?B?aGp1SjFKT01qajNGank3K0pLSDFRazBHRTRCYVdUTFpYV0FEaWZ5K3MzVmM5?=
 =?utf-8?B?ekZTNkYzNW92NVRuUTg1Z1BUc3A5L0lKMXBNbEo1T1N5QWo3TThoc25YZDVU?=
 =?utf-8?B?YjVQQmJSaldDcmw3YVEyS2sxYXV4RExJRnBKUThPTkNibGFBWk1QMjlTS2RK?=
 =?utf-8?B?WFF3bGZXTHNZdGpVVkZHSEc0RTlMK2F3dkc2V3ZsVUF5WmRTUUNqeHJPcCt2?=
 =?utf-8?B?aHZjTDQrdVlNN2xZWHNwWlBnSFl2cTRiTThmYi9nS1phWVMrOTBKK3I0RUcw?=
 =?utf-8?B?bzFmSmk0WWY1L0xHZThBTGpudGs0WmlSL0Q1YjJWbVQwRytxWUtpMFk3dXd1?=
 =?utf-8?B?K1pmR25CUkUrOWdkSEZhdHR5YjZOekF2V3d0TGpyUzRSUFg1dDROMTBNdU1M?=
 =?utf-8?B?WFEyRzErVWJ1d2Y4NTdLL085UFd0Mks2eFlPM1EwNllpa0VRbXZIaVZzeVFW?=
 =?utf-8?B?Q3QwOVFLblBEWUJkVlhSa1JOR25BczVQZVk1L2RRMWVXZ3RLUmJicmI2QU45?=
 =?utf-8?B?SCtRM3YyNzZ4c1FVSDU0REVqTURrM3FBM3hLZDNQeml0KzFlMk93cUp4ak9K?=
 =?utf-8?B?aEJBUEk4ZVMwbklrL3I3VTJVVVhYb0JQYXM2a2d6REM2YmtCd05KcllBcENC?=
 =?utf-8?B?QWdWRVFuTUY5SzNKWWNPa01iNXJCSGJmQkxLcXpUUEFZN1BYZFI2K2wyN2NH?=
 =?utf-8?B?SUc5NDcrcnc0V1lSVTlBSStScWxZNnJNaUVqWnA4bFE3V1A5c1poVFlaUjZx?=
 =?utf-8?B?azZHVkk4N1RsVHozMFZ5VVlsT0ZISzF0TCtheC9MYkNoYTdVRloveFJLMDUx?=
 =?utf-8?B?N2RCeHZDS1BDdDRya0M0SWNnVDF1OU4zNFNCU2EwZFZDU1BiK1Z3bkJEMTd4?=
 =?utf-8?B?NDlHVnhaUitRaFIxZWJHTWM0NVdqdmlVK2JFb0lLNlFrR1lKc204cURWMGFT?=
 =?utf-8?B?RENub0loZkZZTng4WHI5TndQVVoyQXRvRnF6c2prNGsxeHdYTUJuWGFLZmhC?=
 =?utf-8?B?cm92cmI5eVF1VWM1RzZOS3l6N0VtdkNzSjZCUE9wNFJubSt4eEFRdVpqK3Qz?=
 =?utf-8?B?ZnRtSVpVMnhaWERLVkVRYlVHNDFPSkc0QnA0UkV1cmlSUW9EdjUvanVmVmMw?=
 =?utf-8?B?aEVjekpwNmNiYWhkdWN6WWZMdmFraXBURUFkTEF3VHhCT3JXbWhKMy82RWx5?=
 =?utf-8?B?b0wzWnkzVDhNTGJoUDhXSWsxVVhSdTd5Zm9NWkJFWVFuek5BZEpEOTEzNllh?=
 =?utf-8?Q?X6bc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e36cd5cd-80fa-49bb-76f7-08db9ab1d44c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 21:27:56.6174 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VZ9iXjY0opDOWE1Lky2quzB9mlmWYOm0KA/6x0omBMn28kGvOkTv2q18Lnyey3TE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4536
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
Cc: jamesz@amd.com, Roger.Madrid@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 8/11/2023 4:22 PM, Felix Kuehling wrote:
> On 2023-08-11 17:12, Chen, Xiaogang wrote:
>>
>> I know the original jira ticket. The system got RCU cpu stall, then 
>> kernel enter panic, then no response or ssh. This patch let prange 
>> list update task yield cpu after each range update. It can prevent 
>> task holding mm lock too long.
>
> Calling schedule does not drop the lock. If anything, it causes the 
> lock to be held longer, because the function takes longer to complete.
>
> Regards,
>   Felix
>
Right. I do not see either how this patch target the root cause. It is 
on customer system that can have many RCU operations(not necessary from 
our code). Any read critical section can cause write stall.

I think we can use some RCU parameters first to see if thing can change: 
like config_rcu_cpu_stall_timeout to increase grace period, or 
rcuupdate.rcu_cpu_stall_suppress to surppress RCU stall.

Regards

Xiaogang

>> mm lock is rw_semophore, not RCU mechanism. Can you explain how that 
>> can prevent RCU cpu stall in this case?
>>
>> Regards
>>
>> Xiaogang
>>
>> On 8/11/2023 2:11 PM, James Zhu wrote:
>>> Caution: This message originated from an External Source. Use proper 
>>> caution when opening attachments, clicking links, or responding.
>>>
>>>
>>> update_list could be big in list_for_each_entry(prange, 
>>> &update_list, update_list),
>>> mmap_read_lock(mm) is kept hold all the time, adding schedule() can 
>>> remove
>>> RCU stall on CPU for this case.
>>>
>>> RIP: 0010:svm_range_cpu_invalidate_pagetables+0x317/0x610 [amdgpu]
>>> Code: 00 00 00 bf 00 02 00 00 48 81 c2 90 00 00 00 e8 1f 6a b9 e0 65 
>>> 48 8b 14 25 00 bd 01 00 8b 42 2c 48 8b 3c 24 80 e4 f7 0b 43 d8 <89> 
>>> 42 2c e8 51 dd 2d e1 48 8b 7b 38 e8 98 29 b7 e0 48 83 c4 30 b8
>>> RSP: 0018:ffffc9000ffd7b10 EFLAGS: 00000206
>>> RAX: 0000000000000100 RBX: ffff88c493968d80 RCX: ffff88d1a6469b18
>>> RDX: ffff88e18ef1ec80 RSI: ffffc9000ffd7be0 RDI: ffff88c493968d38
>>> RBP: 000000000003062e R08: 000000003042f000 R09: 000000003062efff
>>> R10: 0000000000001000 R11: ffff88c1ad255000 R12: 000000000003042f
>>> R13: ffff88c493968c00 R14: ffffc9000ffd7be0 R15: ffff88c493968c00
>>> __mmu_notifier_invalidate_range_start+0x132/0x1d0
>>> ? amdgpu_vm_bo_update+0x3fd/0x520 [amdgpu]
>>> migrate_vma_setup+0x6c7/0x8f0
>>> ? kfd_smi_event_migration_start+0x5f/0x80 [amdgpu]
>>> svm_migrate_ram_to_vram+0x14e/0x580 [amdgpu]
>>> svm_range_set_attr+0xe34/0x11a0 [amdgpu]
>>> kfd_ioctl+0x271/0x4e0 [amdgpu]
>>> ? kfd_ioctl_set_xnack_mode+0xd0/0xd0 [amdgpu]
>>> __x64_sys_ioctl+0x92/0xd0
>>>
>>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index 113fd11aa96e..9f2d48ade7fa 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -3573,6 +3573,7 @@ svm_range_set_attr(struct kfd_process *p, 
>>> struct mm_struct *mm,
>>>                  r = svm_range_trigger_migration(mm, prange, 
>>> &migrated);
>>>                  if (r)
>>>                          goto out_unlock_range;
>>> +               schedule();
>>>
>>>                  if (migrated && (!p->xnack_enabled ||
>>>                      (prange->flags & 
>>> KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) &&
>>> -- 
>>> 2.34.1
>>>
