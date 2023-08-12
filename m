Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFEC1C0015E
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Aug 2023 00:28:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11CEA10E120;
	Sat, 12 Aug 2023 00:28:18 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::620])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0254510E120
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Aug 2023 00:28:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FUkyhSMP5y7meEVJqIk6laYr5piGo0nqwOD0xPrl4TibUfgFnui5RSU3RckU3VvqNhlqu5uWcpaG50RuFN906vbeayC61FQBRbIK4Yi/krMsSzIASpGXe8WSuYgktwpJ9yCu7QhlgNwIxOQX2PkXt/M5Hzisar/3922uid8jk2aTA9wHH7mGRqg+gnzEGLDHCCGLgg8LRVlg26WwBmLleDX5h2pHosup4oz9uFozhiMhkJzLwas8BDtuzH7KrydgZ02kf9bsaOZ7JDsnX9nLFjVzGuIXB4XuM0jHy0caCTbQr5lDfG6y+OTwnDI7NTihzqnsP8fhdbkS7+oK3Xe/PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEg3GrYvsdeONdEsC+GMlhow1QwuY6qfYEBrnp2m14o=;
 b=HqqGuZN30QVZcDnnKKYfJD/QD2gGekfz/yRlBKkNb1/p8gOC9ts3MRmQHmQ88wKvpotTK+vmxGXyDf3SNaytp0wM/y9t/P9Pz6uZR7vuttao/ucF2ccmsG4ovfO8znqsEUgyfI9hncv9P/qYDGr2GTuMYbA4TY4yrY8lBU9qJN5h9u1NjkKcfFZ4YYuGnL8pglWI/tj4kwLQH4fE7diCLejDEnVp+GdQTtssMXnC3T8uGHIDhad5eP79qwqzdqCPK3AyqIpJwgPO9E7IOj7u8kyh9IwzS+O2cT1lEc2VZhI0LGPF/665Qd8Gf9juVL3fjUUu2wrpIHW+s0iG+6ddwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEg3GrYvsdeONdEsC+GMlhow1QwuY6qfYEBrnp2m14o=;
 b=KAGa0UHFVuzk7vPqENybjt/HWfJPA4yhaTK2dEwZlUCg4LC5V9dGK2k7GcE98AxKkzpCse9ab0iLW7ah1VETTsNkFah3K6APkH7QM5X2732ltgpol8jkhBOCQmn4x22GrcsE2Z090OcrNeeNsWN74sNwPvp7gMPXpf5vC8neInE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by SA0PR12MB7001.namprd12.prod.outlook.com (2603:10b6:806:2c0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Sat, 12 Aug
 2023 00:28:13 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::6b2:a798:b3f7:66f5]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::6b2:a798:b3f7:66f5%5]) with mapi id 15.20.6678.019; Sat, 12 Aug 2023
 00:28:13 +0000
Message-ID: <e964e3ae-b5ca-1947-b6af-7b472cc4fdea@amd.com>
Date: Fri, 11 Aug 2023 20:28:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdkfd: add schedule to remove RCU stall on CPU
Content-Language: en-US
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230811191108.1808648-1-James.Zhu@amd.com>
 <3268e31b-bfd8-7e40-d7df-068f51dc8ff6@amd.com>
 <9c146294-f979-a2f9-13c9-fac588a63406@amd.com>
 <5ae99973-1b5d-4672-de31-4f2f23330bb4@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <5ae99973-1b5d-4672-de31-4f2f23330bb4@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0023.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::31)
 To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|SA0PR12MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c4cf9ee-2504-452a-87d7-08db9acb0390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wAEDlSMkDD2vo/y0/Qu1XWJLh+tw+HYi6OqmJ6FUePGznW08drWF09qZ9HgA75EUoXwz8DHXkhk9p9vGZQZxAKSVwKKOFKIWsyzr9mubFhRKiZd340esqDGN5xcGdv4Wc6wcqlIhGGMZdpf3LNdGddiikBSBK7d2oONV3BqdH/2eEy9QiVTvZT0ireypaPF6IwSrxMVvrWxogLTSjfrpG4K2AaSe4VoyBGNZCkgD4bW+23WgrFfcAH2Zy91fT24RSv8teDsIQDtE/cj4wTLihPNZJkL1HKGMbBhjN9pOG+qiNWSfTq1h8PC5dh5jnXJf+Ga5iJjtJ4hwkGEVqG/MXnlf46SrVB4hhPe/zEeKL1sE6QAz1pYqdf7GmnLKrrJVlWJW2dbcmOLh6A9gFxA1XOchAZFkqtGQiHueEXX9imR/L8MbZOD2Rl6mKvdvOdGtuviGU62UTgRniRIWCt7Ou33vRnl8qe/gSSPwrLShhOZ0nyMitnVzQ7bGzvIqEdSFe6B9xBnVljsgfPpzta8tj7DY4tySye1s1XV/LNryCT+6lO7x38FRlOic5ZAVkddIX0osLUN/A2ux1QYOkrBOvV76o9AMBqEWHEhPWmDQ2RrnN+aVHO3RFUIXU+ddqxaX9qqWtofMPlx4hmLkBT4NwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199021)(1800799006)(186006)(38100700002)(66556008)(66946007)(66476007)(83380400001)(36756003)(5660300002)(8676002)(110136005)(8936002)(316002)(4326008)(2906002)(6486002)(31696002)(41300700001)(6506007)(53546011)(31686004)(6512007)(478600001)(26005)(36916002)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TE41cWY5SlAzYlRxS1ZaUTE4UVJHK3o2czA1cmJCYkZianlxQVU5TTNPL2ox?=
 =?utf-8?B?Y0IwblkxUmt4NXZyVm84VG9OaGV0MGtqbHdhdExiNXdGYU5QRDRzRXZ3RUxX?=
 =?utf-8?B?M0F2TWxEVEczeVg4ejF1VFlPeEc5Y0RkOW1BamFwUnR2U0MxRkxLTGNMYUZH?=
 =?utf-8?B?S2JDRVRjZFpjbk1XZUU5S0o3Y2JUR3ROeWY5Y1NsUGxnMWRzK3BoMmFIbzZD?=
 =?utf-8?B?SW5YdlFCay9xbjZQOTJJdjcxVkNqRHhwaXMyR0ZNYVpMb1NRSmZ0UGNBdU5O?=
 =?utf-8?B?Tk96cUV1UnpqTjhsWmhkRWF5cHZ2M1NTNXgwZzhTQUxsdlFwcG9nZm9HOXFW?=
 =?utf-8?B?a3N0eWJOSithMnFVUVd3MlkvL28vMUNzTUcrcTg3ZkFaV3lXL0I3bWVhUzhm?=
 =?utf-8?B?ZVd1WjdudzhxSWEyRUFjUUttWnFFcFhkRERMM3IxanVWSTcvWWNhWnNMUUFu?=
 =?utf-8?B?c25keExINmRodHNRWmJYQW5DU29ZMUMwbXJKMU9yRkpOQmF4eEFTQUZPNGJJ?=
 =?utf-8?B?bFVHRlVSdkMxTEw4NmJSN0lKaEVMZ1lZT0tSa3djYVVxNlIzUGQvY1Y2Y2lK?=
 =?utf-8?B?MklUZEdZVmNqSkk2Z3BkSVV6N21XelNwc2ExOHBUcHZxcWl0NHpla3dNNEp2?=
 =?utf-8?B?a1JsbUxyQW5yU2l4ZHpRQXlwWnBzZVpyQXBlNVUwd1BRdXpFeWVwd0FCV1Rn?=
 =?utf-8?B?d0JURzBUbG12YUZUUFBFMFByWUI0UHRKMndZd20xMFJ3WCtxQjV6eUZSRHM1?=
 =?utf-8?B?TzhNSDBoT3RoMHhDd0lSN09YRTNxKzlrajEvTnFadFVSYW5yVlZxOWFFZGgw?=
 =?utf-8?B?NUdRSlhCZnBHRFdldVVDclVXMzB5UEdIcFNLdCtQME5kNUVVNVhPenRXTEQ4?=
 =?utf-8?B?bmxyQlN2MUxNVkpmNGRIZnUyWXNPSURzK1RMeittZ1N2Y1VhNStxdDNRa01q?=
 =?utf-8?B?RlN1Z3I2aWkyMzF4V1l4N3EvZUVReG96VWRPNzF6WWxuMTlBWS9QQ0hZSWJl?=
 =?utf-8?B?RXlEcDdvQXJJZXNOSVVVTUJ5NGhlVzB1S09IdnZoclVLVUNObmRmZ05iOGhN?=
 =?utf-8?B?bExIN0xTNktrekpvYzBOYkVSNkJrUTc4aExIMnAwQjZlcFFPS3BXUXVtdHZ0?=
 =?utf-8?B?TFRjZTl5VkZqWmo2ZlR0bWJMYVBiQTZQK21NSjRXSTBDeFo4QmpKaSsxSVc3?=
 =?utf-8?B?RTJZMmg4NEhNY245TFo2TC96MHV5NjdwbUJmSXJUWkhTb0tCQ1l0eStoRzlE?=
 =?utf-8?B?Rmt5V1ZVSXRqWkRqRC9uOHI5aGltYWdnYkptZ01sUjl2SVEyY1lGOEpCbEcw?=
 =?utf-8?B?d2tBY3dZS0xRR1V6ZCtTaUMzdDVLUFVIWFU0Vi93Sm1sR2ppTjJ1SDRmaEov?=
 =?utf-8?B?U3NIOUlXdldZS3V1enZ4MEdIVjZiTVBZc0czTk5aS3pCSGtya3Q4U2hIb2k0?=
 =?utf-8?B?b3BJSkx3L3RwN3JnakFMUXVRNDVDRm5TbHRGcEhqbG10N29LKzFvZ1R2STFT?=
 =?utf-8?B?cHpBR2hadDdVY3ZiR1lxR3hMS081U3l4elV5d2VnMzRPRzg0SDhMQ2VDTDJS?=
 =?utf-8?B?cjdIRU0yaFlrMDZydk9wRW5DcENlYnpEZU52WVhLQm04QmJQcWdzZUZJaHZ6?=
 =?utf-8?B?Z2lMdzFQQWdFWmxpbmNVMEt0eGVaaksxd204Q1V5NE5qSTRXVVFrK3k1cEY1?=
 =?utf-8?B?RTBIQ3M4UTQxdzlBanZic1FveDE3eVNtOC96czNsSnZOd3Yrby9BRVZFblhB?=
 =?utf-8?B?cFltMlV6VENLczZoU1dVZnRacUFMM2tRSXZuSkZkbUNRYk1aTXBtdGxZUEVr?=
 =?utf-8?B?d3FtUG91M3Z5dE9IVDFyeXFESXZXdFlXOWpUbDRITkY5aWYvYys4UTRhanZw?=
 =?utf-8?B?MzQ0dmJhSlVUVHRnNTdPK3FpajlSWXA3WlpRRGVPUTQrMURDYXA0VDJaNWVG?=
 =?utf-8?B?bEhSdEpDTUt6c1hPL1kxQjY2MHloTnJHSFRpZi9JRUxPcWpsbkpIUXJLSVZ4?=
 =?utf-8?B?SzNGTkIvbi9VZjJDZE43SmFSTitDbmoyUzVXUmQ0UVFnTUNLSlRWRWNCcytU?=
 =?utf-8?B?NGVPekg0OGVsaGh2RkVvWWN3cElyTWxUUjY5ZmtoWDQxRmNRSFN0QmtzbUhw?=
 =?utf-8?Q?ndewFLKqqfVefN/VM2kxSFm6Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4cf9ee-2504-452a-87d7-08db9acb0390
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2023 00:28:13.3998 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1abfexGk8IGv31f1Jvidy22GF/hkRCL9vTre16mYqlwGDlEh3iI31/2IpsQ3PIfe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7001
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
Cc: Roger.Madrid@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-08-11 17:27, Chen, Xiaogang wrote:
>
> On 8/11/2023 4:22 PM, Felix Kuehling wrote:
>> On 2023-08-11 17:12, Chen, Xiaogang wrote:
>>>
>>> I know the original jira ticket. The system got RCU cpu stall, then 
>>> kernel enter panic, then no response or ssh. This patch let prange 
>>> list update task yield cpu after each range update. It can prevent 
>>> task holding mm lock too long.
>>
>> Calling schedule does not drop the lock. If anything, it causes the 
>> lock to be held longer, because the function takes longer to complete.
>>
>> Regards,
>>   Felix
>>
> Right. I do not see either how this patch target the root cause. It is 
> on customer system that can have many RCU operations(not necessary 
> from our code). Any read critical section can cause write stall.
>
> I think we can use some RCU parameters first to see if thing can 
> change: like config_rcu_cpu_stall_timeout to increase grace period, or 
> rcuupdate.rcu_cpu_stall_suppress to surppress RCU stall.
[JZ] I tried to tune grace period before, it is easy to hung the system
>
> Regards
>
> Xiaogang
>
>>> mm lock is rw_semophore, not RCU mechanism. Can you explain how that 
>>> can prevent RCU cpu stall in this case?
>>>
>>> Regards
>>>
>>> Xiaogang
>>>
>>> On 8/11/2023 2:11 PM, James Zhu wrote:
>>>> Caution: This message originated from an External Source. Use 
>>>> proper caution when opening attachments, clicking links, or 
>>>> responding.
>>>>
>>>>
>>>> update_list could be big in list_for_each_entry(prange, 
>>>> &update_list, update_list),
>>>> mmap_read_lock(mm) is kept hold all the time, adding schedule() can 
>>>> remove
>>>> RCU stall on CPU for this case.
>>>>
>>>> RIP: 0010:svm_range_cpu_invalidate_pagetables+0x317/0x610 [amdgpu]
>>>> Code: 00 00 00 bf 00 02 00 00 48 81 c2 90 00 00 00 e8 1f 6a b9 e0 
>>>> 65 48 8b 14 25 00 bd 01 00 8b 42 2c 48 8b 3c 24 80 e4 f7 0b 43 d8 
>>>> <89> 42 2c e8 51 dd 2d e1 48 8b 7b 38 e8 98 29 b7 e0 48 83 c4 30 b8
>>>> RSP: 0018:ffffc9000ffd7b10 EFLAGS: 00000206
>>>> RAX: 0000000000000100 RBX: ffff88c493968d80 RCX: ffff88d1a6469b18
>>>> RDX: ffff88e18ef1ec80 RSI: ffffc9000ffd7be0 RDI: ffff88c493968d38
>>>> RBP: 000000000003062e R08: 000000003042f000 R09: 000000003062efff
>>>> R10: 0000000000001000 R11: ffff88c1ad255000 R12: 000000000003042f
>>>> R13: ffff88c493968c00 R14: ffffc9000ffd7be0 R15: ffff88c493968c00
>>>> __mmu_notifier_invalidate_range_start+0x132/0x1d0
>>>> ? amdgpu_vm_bo_update+0x3fd/0x520 [amdgpu]
>>>> migrate_vma_setup+0x6c7/0x8f0
>>>> ? kfd_smi_event_migration_start+0x5f/0x80 [amdgpu]
>>>> svm_migrate_ram_to_vram+0x14e/0x580 [amdgpu]
>>>> svm_range_set_attr+0xe34/0x11a0 [amdgpu]
>>>> kfd_ioctl+0x271/0x4e0 [amdgpu]
>>>> ? kfd_ioctl_set_xnack_mode+0xd0/0xd0 [amdgpu]
>>>> __x64_sys_ioctl+0x92/0xd0
>>>>
>>>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 1 +
>>>>   1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> index 113fd11aa96e..9f2d48ade7fa 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> @@ -3573,6 +3573,7 @@ svm_range_set_attr(struct kfd_process *p, 
>>>> struct mm_struct *mm,
>>>>                  r = svm_range_trigger_migration(mm, prange, 
>>>> &migrated);
>>>>                  if (r)
>>>>                          goto out_unlock_range;
>>>> +               schedule();
>>>>
>>>>                  if (migrated && (!p->xnack_enabled ||
>>>>                      (prange->flags & 
>>>> KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) &&
>>>> -- 
>>>> 2.34.1
>>>>
