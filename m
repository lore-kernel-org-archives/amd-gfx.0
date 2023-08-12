Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 890B5C001B0
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Aug 2023 00:24:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40ABD10E123;
	Sat, 12 Aug 2023 00:24:34 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DF7710E123
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Aug 2023 00:24:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJYQIgkTlXaQW+gciPgLdzx/uD1jetjXgXdNNEsxlclOvMuxmtMZqOFvu35XLeHoGOSMBBGgiPK068tfmPnaKb5338iQs4uSY814f9k0/a9aqzqHpJFXJwR6/nHP8cP6uN8DY4D1B58wayytlgvpoHGzLX47d5bQRQ7sra5gclFKxiMQgsAx6sAh8Js+9odFA/T/JVtmurHliLDneNdVw4bwXG44rM5QhpOyN6UMinMM5A+xEyE5cr0ucAbXaFC24XcuqtFhnmeyG04UCaBU/MfDReFOg4cu3+CZxGGY5Noo8sEzplbWA2iFAc++SBnFsWJnN1blUQr7G6Lxd/+DuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVDRk1SD0nYeOC500BnIvCUs19HvV5lQ9cV8VjtncXo=;
 b=ZEczY3dQu32IkOL+VVWcqzmY6FcdD3bMIjkQUIyMnFuPCzlpOayfkRbotSCin/L6MjX5bPKszotFA9iSwAPELglhJIjZmvm1jKK2HZMH6alCU9eUzCPrVN6FPxmRt+jlq0IaOaV8YWfoanSZHqSLDQrMXhSrPelpX3ubTgPBIMjS1GX926aryruX0n4mT21mQ/nWgvxxWpD9wHn8BOJttSs3ptAK9diPTdvwqEgUy2st+Dhb85l0J0f/BHfE/MTFOv/nczHqQhA3DsLfiHlhkbP3Fv6j6n9dPtn05R80fOSvi9rnfHrTQX0lw//YSCOmbDGyh63TymKX8nnY4Wd7aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVDRk1SD0nYeOC500BnIvCUs19HvV5lQ9cV8VjtncXo=;
 b=K2OSakJ++HrzzMzwNnLaZng72hq+YvclGKsLiUlSZO5m1LFZkUFjLT7UQpCqWOj9smBYROZyGdy16hPZeNFbfDZDHk4SvRWa70RP68SK9qC575mIDLw9mx5YAttk6anbCa8h4pV1hbSDF7fOY6w1bsLtCjcc6X/gaGvSwww4OwU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by CY8PR12MB7434.namprd12.prod.outlook.com (2603:10b6:930:52::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.20; Sat, 12 Aug
 2023 00:24:28 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::6b2:a798:b3f7:66f5]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::6b2:a798:b3f7:66f5%5]) with mapi id 15.20.6678.019; Sat, 12 Aug 2023
 00:24:28 +0000
Message-ID: <06afbc37-0dd1-9b9c-f4e2-141824973252@amd.com>
Date: Fri, 11 Aug 2023 20:24:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdkfd: add schedule to remove RCU stall on CPU
Content-Language: en-US
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230811191108.1808648-1-James.Zhu@amd.com>
 <3268e31b-bfd8-7e40-d7df-068f51dc8ff6@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <3268e31b-bfd8-7e40-d7df-068f51dc8ff6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0045.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::17) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|CY8PR12MB7434:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d137ebc-4ded-43c5-a81f-08db9aca7d94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W4Q1fxmn6TUsnqyVwczslj3M2WryKrPyTBbAcLzi9WgTgQiwDkAXkwCEo2ipdZrgJRlJa8YcFdU8D9YqECvUBi7jvkjfGvo2q5AFzUvofh1IRn33Wqtb/uIT+UqgXo5NGBkFmLB5mwQNdcEjNRt45h5xcEvxoaLtzaREMZ6giLQ632iEujDMhYl+wNbUnbcOLWqvsxr80x8eadAgA1Ft/oV85Os6NG6cGA0gCWyXaMEK45t6CGTTwVqVfBTHQkFcniEt5FyN0ySZnAzP5RM+a1wO4m6ymILWmsktWaUxzWkSS/Rof2Q1H2vQjWeHYoQ4aUyusZ0DiSJaRpjdah8FD75eAHfZ6/30dk4xcDLoHzsGybUBhXnM4toIiewicz06QF+IK6HK+lhov1AsjA3yFQdymE/QmL5RUmvFEkbBw5pX16jgi6Np/wE3B4haddARFLxvEE3cQ1ZYXwl6OJ4wmilFrXHJotTMm4oBey0wc0isW0CH7vKfwbe/XrUGcGlYtchvzGCuyi8MzAJJbK5qPZuZwdQVPvs8D0T6EX58+8SlZdrEq8M4ZGpGI+mpp9d7w/rThbCNRVrgbOG+bpJc/tMyHXFfWjNXNij0y7ZrgDOzCNuftTW+8eGqpV26L1C6gxZmzy5iEXLl2bK8Sno8lA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199021)(1800799006)(186006)(31686004)(6512007)(36916002)(31696002)(36756003)(38100700002)(26005)(83380400001)(2906002)(110136005)(2616005)(6506007)(6666004)(478600001)(6486002)(53546011)(4326008)(316002)(41300700001)(8936002)(8676002)(5660300002)(66556008)(66946007)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SldzT2pLNUN0UVViUG1DclY4dEpwWitaWVV3OUxRODVaK2Vxa1AwM3M0Z3Ft?=
 =?utf-8?B?ODJQR1k3RnBlbVA4OCtYc0d3cFRzQzFsdkk3aTN1bjI4alhpeS9MaFdZbytK?=
 =?utf-8?B?cHZaL1ZUcVRGRXRzTmJyYTF3cUtwczlOMFhwYTYzZlo4ckNwbkpLdFF6Q1h6?=
 =?utf-8?B?dWlIOWpNYU5kbkcrdDJHdG9EeEVPQ0ROR281UG1QUTRWdEMyMko3UkhQMkJZ?=
 =?utf-8?B?WVFBWnlaVkhXSFNIRDRkc1pvRmg2VGI4bVVpY3NnVHQxMmpsKzFmc3RYOEdz?=
 =?utf-8?B?VnNvY0JuVnhHN3FWaDhabUpUK3JjSzBreGgxNUNkbVovYWxhRklIQkxWTTY5?=
 =?utf-8?B?VnNxUVlMMU5hWHkveVVOMjZuSFNJaGluU0ZLaWJRd0xiaGlrUXFRd1pkTnlW?=
 =?utf-8?B?NGFHMTdWdEc1NFphVU1LclE3VGhaSkZLdnNJdzR0dG52Z24vZVdMaVNJckFP?=
 =?utf-8?B?bVlNZU92S2g5NFZGMHBRNFVkTVZqWlpTRFBvZFlZUm9MR0VPRTMwUVhqckNF?=
 =?utf-8?B?eVR5Wk9LbjFnRkNsVEYyaU9nOWhwTng1Q2RiV216a2tKdFlXc1pCS0tKUDFz?=
 =?utf-8?B?aFRQcGRZQUpub1gwMlNCNWpRcnJ2eS9LMlpEWDIwYVlGK3RJZlRSVGxHRGk5?=
 =?utf-8?B?RTBSVnUyUVI0VUFNL0pNcklGQ1VXT2xKUkdKSnp5d3dYYzZJbXA4MnRkM3NQ?=
 =?utf-8?B?ZXBQalRlMFhDNXVMMlJlbU9aUXhpVU5mWEdncVFxRVorUnhGRmdFcExZMjMz?=
 =?utf-8?B?YmN1cVAvY3hvN0lSQlBPdDQ1NkUyNlRvQVRyajAvbVpiZnZRM0NvdEN0K0Iz?=
 =?utf-8?B?d3NUa21Fdks2QjlYTGk3QklrT2l3NzlHTndqeVUySlpJQ0hvZ3FXQ1FvdTRk?=
 =?utf-8?B?QlJlWDhzYy9yeDdaYVQ2b2Y1TFpxMHdzZjZhazlvdG5aN1NHTVJ3WEJmblpy?=
 =?utf-8?B?K0hCbHNKUWVpYnY5VWlHTUErTXNWRlRhNGxnekhHWXhlUVFPa21ZMHFjVHF1?=
 =?utf-8?B?TG1yanFjYW5LaUYySFpBcmtFMmlrWkdoTkNIV2h4b3ViRFJlRlZhbk5BZVFJ?=
 =?utf-8?B?UEgweHB5SG4xcWl2ZVVqYVlseGp5VVptcEhDZTVxREtVaTlNK1JBSkMrZU9r?=
 =?utf-8?B?Tk9HMnRjbC9yb1pGbENacUhRK3UzZ0c0OEQzT0c1Q2NONUx2US9xREd2VjVx?=
 =?utf-8?B?cTNUQ1FReGFieXhhaG1Rem5mZkJGb0YrUTdXWk82bHhXZDdjaDJoUHU2UHFT?=
 =?utf-8?B?OWwwS3kveDhDWGZzUXExZXpoMnYrRURwclhvYmhHS1hNYnVPN1JsbmJucUtX?=
 =?utf-8?B?cU1OeTR6WFlQSnNqNFhhTm15MzhDSGZUWS82YUcyZ2txL2F3RUEwQWxlSWlP?=
 =?utf-8?B?MERlRmg3Zkg0K3k3RDNJNG41RWVGb1FPb0NiWGp2WXZTMEk2RmhNTDM5MnpR?=
 =?utf-8?B?YUlHaWhNK1ZzL1VmQ2RUS1g0Uml1THFvTk42NGZ1L3NYaXNaMUF0ODVQT3JQ?=
 =?utf-8?B?eTlyRW1sNFh3U3hYRk51VmhXTW1uSVNpOWRtWUpKNVhCcDZMWCtKak5jZk1E?=
 =?utf-8?B?alRsZ3VzcDN4ejArYjEzOEc1RkF2U3p6WDZYT09YemtJQnAzQUtzQzdoWnoy?=
 =?utf-8?B?bmxzUnR0VUx1ZnRlL0NVZEd2ZVRzRy90dzczQ0RWaEV4MmFKQllSWndGLyta?=
 =?utf-8?B?dFlickhJNTluOG9tUG8zV1EvSHVsMlNEbStndTh1YUlwbTVJUG9qamp3UXIr?=
 =?utf-8?B?UVQ0YnNCc2lzVFN6Y01SZWEzQUF1Z3RTUWY3RDhGZGc2WFYraHFpd3pmM2pa?=
 =?utf-8?B?dDlIbElhMi9TYktEcmNSbDlQb2tldFR5d3RMSytaWHRwcDN5SkZkTEVsd3h4?=
 =?utf-8?B?Mkh2S25rV0JGdjdSdk85eEdHVVcya2piRVVISEdScU9wNVVqdWNJVUtrUFRw?=
 =?utf-8?B?WDM5a3ZyMHg3Y1EvcXVRNjRrdERLaW1qSmxzVHZKZnRveU1iZmV0RFdEblMr?=
 =?utf-8?B?aXNsZ2FYUERpVmlKV0s1Q04zcW53SzdndmY2bzV6aUluK0xoNnNQMUVBUzJP?=
 =?utf-8?B?V0NnNE42UXNxN296ekZPcUxodGFnZUxoS0hKSXFWeGF2T3AwOEJrdGpKaXFu?=
 =?utf-8?Q?J7LwthcfCAWw5jMyUE5w6zDhg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d137ebc-4ded-43c5-a81f-08db9aca7d94
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2023 00:24:28.5936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eG9pHp422fZQlDjPwxnvVmub+GcNUkI4vSURPDsAAKGyc/UqoIz2gIFIjqgfEhhc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7434
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
Cc: Felix.kuehling@amd.com, Roger.Madrid@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

-Remove others, continue discussing internally

On 2023-08-11 17:12, Chen, Xiaogang wrote:
>
> I know the original jira ticket. The system got RCU cpu stall, then 
> kernel enter panic, then no response or ssh. This patch let prange 
> list update task yield cpu after each range update. It can prevent 
> task holding mm lock too long. mm lock is rw_semophore, not RCU 
> mechanism. Can you explain how that can prevent RCU cpu stall in this 
> case?
[JZ] I can't find exactly rcu_read_lock either, there are many different 
lockers protecting this period.  mm lock is rw_semaphore , i suspected 
it is implemented with RCU mechanism somewhere,
>
> Regards
>
> Xiaogang
>
> On 8/11/2023 2:11 PM, James Zhu wrote:
>> Caution: This message originated from an External Source. Use proper 
>> caution when opening attachments, clicking links, or responding.
>>
>>
>> update_list could be big in list_for_each_entry(prange, &update_list, 
>> update_list),
>> mmap_read_lock(mm) is kept hold all the time, adding schedule() can 
>> remove
>> RCU stall on CPU for this case.
>>
>> RIP: 0010:svm_range_cpu_invalidate_pagetables+0x317/0x610 [amdgpu]
>> Code: 00 00 00 bf 00 02 00 00 48 81 c2 90 00 00 00 e8 1f 6a b9 e0 65 
>> 48 8b 14 25 00 bd 01 00 8b 42 2c 48 8b 3c 24 80 e4 f7 0b 43 d8 <89> 
>> 42 2c e8 51 dd 2d e1 48 8b 7b 38 e8 98 29 b7 e0 48 83 c4 30 b8
>> RSP: 0018:ffffc9000ffd7b10 EFLAGS: 00000206
>> RAX: 0000000000000100 RBX: ffff88c493968d80 RCX: ffff88d1a6469b18
>> RDX: ffff88e18ef1ec80 RSI: ffffc9000ffd7be0 RDI: ffff88c493968d38
>> RBP: 000000000003062e R08: 000000003042f000 R09: 000000003062efff
>> R10: 0000000000001000 R11: ffff88c1ad255000 R12: 000000000003042f
>> R13: ffff88c493968c00 R14: ffffc9000ffd7be0 R15: ffff88c493968c00
>> __mmu_notifier_invalidate_range_start+0x132/0x1d0
>> ? amdgpu_vm_bo_update+0x3fd/0x520 [amdgpu]
>> migrate_vma_setup+0x6c7/0x8f0
>> ? kfd_smi_event_migration_start+0x5f/0x80 [amdgpu]
>> svm_migrate_ram_to_vram+0x14e/0x580 [amdgpu]
>> svm_range_set_attr+0xe34/0x11a0 [amdgpu]
>> kfd_ioctl+0x271/0x4e0 [amdgpu]
>> ? kfd_ioctl_set_xnack_mode+0xd0/0xd0 [amdgpu]
>> __x64_sys_ioctl+0x92/0xd0
>>
>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 113fd11aa96e..9f2d48ade7fa 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -3573,6 +3573,7 @@ svm_range_set_attr(struct kfd_process *p, 
>> struct mm_struct *mm,
>>                  r = svm_range_trigger_migration(mm, prange, &migrated);
>>                  if (r)
>>                          goto out_unlock_range;
>> +               schedule();
>>
>>                  if (migrated && (!p->xnack_enabled ||
>>                      (prange->flags & 
>> KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) &&
>> -- 
>> 2.34.1
>>
