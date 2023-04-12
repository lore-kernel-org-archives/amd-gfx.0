Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859D1C77B6E
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Apr 2023 05:42:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA71010E164;
	Wed, 12 Apr 2023 05:42:33 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::606])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 184CA10E164
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 05:42:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Paw8jrH9pGxMI9BJDPMsgH9fQLB2h8+Gwi5XvCm2RKLoxct7h53znz8lxj19GyOW/4e1mSdIEUhdRMj209+WWYErhXkUzoCutkuqrlUv9B+EekpJKLImqXUzijRzOKi996OivcVpAlH74EBusxZIj6Xg7BROEsljBtGRz1UobUgVRRZKTHUgRFAuBJyWH/QbaQbAiLwZQPiso0FfAG8KLlypYbDai25Usyz3RrG++DWfaXKJFlKgSnzbaJXrPyj4AMQFVzScPdSY1czoYtoZI+mKLYC9ArV85KRvYW1CGWvbulIUWPd5hsOY9BUcP09me31yrc9uqbxBCp1CjzhRow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vfIGwTV5rahQn5nv9fqQ7QXIJ/8avwCrAkKimG6Ou8c=;
 b=Yxa4k6b5p6FaIiAPtAN7KuKm4CnoPyB3nVrZ8T0OYYcRcGRqxBrYRmdqQ7EJ8eXdmQ7IJFPP5+BATS3gci4w9VVEXaZwQqgydkF3DwQ2bQKXqI+oAxPDNNMzOwDlOv0hgAM8/7TxcgAbdcmvvSSuTavnNZIyv+FSis8xQwT/I2EN1LsXQchgCfDTYQvC15zKO6QZKmnY/0ejLU5bBzl1EeS2F97cNcHLuMwcX/VsVYZMJHCh86M17lGftrRkXsrHQ5rjPXUE9QVOWizK2iZDkQ+EJ+jN4C/7g3jY7Yx1AaD13Qm0IUmG89sPjzA0XA4uJFJ0mA1Y5gPNZTKdEFBXEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfIGwTV5rahQn5nv9fqQ7QXIJ/8avwCrAkKimG6Ou8c=;
 b=g6hB3UNoYULfNHOlNGUCxJNsrSBRDwaWBk2hZXlZNqAlpCSaTNOCz12t8B5rK4rzQrFXn5A+6dl65I0v+nz+nDxjncZDs32iRraqhw1gItLguOeXuU/lgYL5XpCWzT4hjTJYEzDnnKcm3IsDCv+ubxAB6x8G/fgrGMrKusmNIWc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 IA1PR12MB8078.namprd12.prod.outlook.com (2603:10b6:208:3f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 12 Apr
 2023 05:42:26 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::3c3:83f1:333c:fc17]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::3c3:83f1:333c:fc17%5]) with mapi id 15.20.6298.028; Wed, 12 Apr 2023
 05:42:26 +0000
Message-ID: <dd7593db-d9c7-1358-8549-87926a1ad721@amd.com>
Date: Wed, 12 Apr 2023 00:42:22 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/amdkfd: Change WARN to pr_debug when same userptr BOs
 got invalidated by mmu.
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230410143605.334232-1-xiaogang.chen@amd.com>
 <c48e62e2-fc71-c81b-8523-6fa9b99f1b14@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <c48e62e2-fc71-c81b-8523-6fa9b99f1b14@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR07CA0001.namprd07.prod.outlook.com
 (2603:10b6:610:32::6) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|IA1PR12MB8078:EE_
X-MS-Office365-Filtering-Correlation-Id: bc3f59b3-20d0-426c-c008-08db3b18b20a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +C4CYz9EL2uiHSrv1lPrtLGLuUQZl5cyXbqMeYuW1Xgj1Oi9XyRdb0DZP3iWjRQ65VB57O9hLXc0gQz0ZCHhBk1oxfXegz5p7qTS6vTnyG1l2Q7v1mjJKi00gFLNIZm9+nID1Ct7RXyoS91pElAs8okAjj/Ist9SK4VwpZm4vUllkpBCG2zGgIpLz4DU67ZnKboIvA0l99EAyIHaH+KPN443LAazJC4Hd4y/ozaB+QBZUYgt0cR7k+TU8EdUhDK+46WV1EMt2kBafxL3wLGV5PKWQsQiW1dYGX33joTkFNQdYcJaWorBZzObTuOytdtv1s0d1SSGwsAQ8O5OM/zhSQv45NW6C7IwatqRly/yWSBswd0fBywANbt//YDmyBRg5ROfcL1u/NCVa/6x1jkaRohEfq3ampGwT8/zfxl5vV5tHQE5OPu1F4XD4bFssiJX5ENqbftwCjIqwv6yWqc5245fk7aXw6iXTr9iSwRhUBqQRwmJdO0sKNIf0LPrQf4Cok/P5gVKVDGVIJOXMt+Fe2fuDj+dHZ8vC/U6MLnOb/aLZeCS/Yex/YyxQhZhmAtH5smRGf0FebqMxUNOQ029AITHXwjyxWp4WGWztKsDVfOKBA0j0CKe4foGUnQuYZb6mVHGtLgDK6W1WDS+W9XqaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(451199021)(86362001)(66556008)(66476007)(8676002)(66946007)(478600001)(26005)(31696002)(6506007)(6512007)(6486002)(2616005)(6666004)(36756003)(186003)(53546011)(316002)(83380400001)(5660300002)(38100700002)(2906002)(8936002)(31686004)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vk5LeFZ3eFJrM1d5Wm10OUxhV2ltc1p2S1hsN3NHOVRzRWJyUTZOdmNXbkN0?=
 =?utf-8?B?WTJBcDNER1dLY0p0MzhnVVZXWTFrY0hnZEVJMUtMaWdzdUNIdW80cFFiaGhK?=
 =?utf-8?B?ZExHOUJOQWV0MG5lSTA4bis5cy8xeUJJY3hEWHZhNWQrQ3lndXl5YUdwK3A3?=
 =?utf-8?B?ZTNLbHdjd0FlS2FDTFZoWFZ4MU5NM3RobDVDOCtWcFpDZ3VVbzl0UEE3RmE5?=
 =?utf-8?B?UzF3MGNQRlVLQzNpbWM4eFlrenJXMDlIUnl6d2lBMll4ZUVERWJmRlJJMmNz?=
 =?utf-8?B?ZkVmWEdMZ0hFQ0V0Y2IvM1doczlObnBjMVlWNDcyUGh1RitBRFNDWlhqUysv?=
 =?utf-8?B?bVViZ1ZWS0ZrZGticnZ0TWxrZXFGWk5PdjNkeHZXVVNWL2YyMlRDVDBPUUhN?=
 =?utf-8?B?VzNrbnl2bWFzUTVyVGRFQXJnWk9WNXZGTWhONm9CRDF5aEhsOUVFQnhINTdw?=
 =?utf-8?B?UzlFbmFIRDY2cW1yZElNT1pud0Rhby8wT0xnYXpFMmw5bng1enoyNUlWUWlB?=
 =?utf-8?B?V3FjeW5rcXM1K0o1ODJmZlhneEVMZjFiR3RsSllOUlkwdE1qSVFwdzN4UStJ?=
 =?utf-8?B?ZG1uMkFtdTMySnMzQ2dKKzNISEhZOGRBTWMzandySG5XT2U2amV4MDEwSDg3?=
 =?utf-8?B?czRxZnNQM3doY1ZqY2t6MXpEWlFlRFRRb3d3MGFoNlBENHNvclArQ3grUVpL?=
 =?utf-8?B?ejg1czB6Y1hwK0dwSFR2WjgzNE95dWI2OEw2YTVPUm5hVDFWbE42SXExZmtl?=
 =?utf-8?B?UVA4YlZsVkpjeS9GNXBoY05KdHJMbDR4RnBRVkhjZ2locVoxRDgyaElFQW1n?=
 =?utf-8?B?MGw1WjhwSlJzUi9UQ3U5ak05RUxKWWsxcW9pYzEzWDBvUnVORHFUaTNYdnp3?=
 =?utf-8?B?T2dDUHc3djhMTHA0eDd3Y2M1RHZHRG55WHNkMkpjMzB4VXNxczlOMHBIYTlp?=
 =?utf-8?B?NmVhdm53UGpMcVYrVnh4V2kyN3NXSHppOE5DV0N1MFlyYi9BVHh0RzVtZWhQ?=
 =?utf-8?B?eWxFVi9TbG5RNmFIQ1B0L1Z2OWJsVVRIMUpOcUF1NE5XakNBVlhJVmtYNnVj?=
 =?utf-8?B?ZGtEdDlMYThqL1IyTnNETnZKcnRKNEpVVlNvQWUxditFK1hYMjJJT2EzVmxy?=
 =?utf-8?B?UEx1ZzVOUkhrUTZ2RnI5a1NRdHlmdmZ0blh3M2xsWEZ0aGtmS2dEOHRxOWU3?=
 =?utf-8?B?M3hpbm1VZnBqb2JZcTZCTmsxbkVPZ3Q0VTNuOHBqR2dzd2t6UktTcWR3anNQ?=
 =?utf-8?B?cFVQVFFpcTJ4bDVCTkdIVGJ5ZDAyR2dJZUc5U3QyS2dYQnJoNVBSbFVyUVFr?=
 =?utf-8?B?bkZsS1lYK2lOMlN1U2dQUWRPN3BwRjhVR1ErbUlad1lYcWV5T29aRDVQS25M?=
 =?utf-8?B?SmlJT3N2SWh5YXpZQkhxY25wRkZvWFF6R0svMzd2N1hXckRHWVEwalFTYzJu?=
 =?utf-8?B?aVRkNEo2V04reDVpOVZleG9UbGpydEs2N2JTZnpVTU9XWkppekRIbTM1UnNp?=
 =?utf-8?B?SENDeGhkbGRCS3NGZ2NmbWdrYStJVVVmZ2lzSFpoVXRadWpPL1lvdVlHYm51?=
 =?utf-8?B?dVRkd0hIVmJHLzNYVG1TcmUxR2wxUEYweU1Td1F5THlUd3JEeGFKc0JuMzdq?=
 =?utf-8?B?ZUYrcmExeXNHSzRrVjBHQk1XRXJ2UXpoRWZxZ2RxTDdac3J2QU5ETmw4OEFM?=
 =?utf-8?B?TitISXBHRWpNbnkydDBFTDhuNUg5ZmVFZ3l4VzFmbitxM25PQ3lZaXlPUkFu?=
 =?utf-8?B?T25GRHpiNTU2dXZXNHpVaFVEZjFyT0FlTXZpaG50Z285RlhBMDlLQ242UDlE?=
 =?utf-8?B?Y2VTc2NqRkNLa2pPOWhuclorL2NiejNndUZSUUE5eER4UitlK0FLa291dVoz?=
 =?utf-8?B?NWhwUVpjWkNIeURWSDhSc1F3NGxrZEZNRkVYenpISlc0eldJOURBNUpBdUVk?=
 =?utf-8?B?aGU3U1JJNWp4aHVuMjh2bmRtL1EvUkQyRGRtb0ZQOTVOMFZxc1RRejJsUW9H?=
 =?utf-8?B?ejJwd25zM2gvWDBacWdDZTZxMmVXbFRqVGZMT2c2M1NDOFBmbFNkeW5OWGMx?=
 =?utf-8?B?MmV6ME9pS2tNbHpFNVVNdjZZOS9EK2xxQnFsMGtCQ2NOSWJMZnF0Y2VVZW5G?=
 =?utf-8?Q?a2q4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc3f59b3-20d0-426c-c008-08db3b18b20a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 05:42:25.6965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c0kLtZAT1+0tSte9QIuSPudpLzU+Z43o3YD0/FG2B+MOi4ZO+4NxoWPxjTs7l4Y0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8078
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


On 4/10/2023 2:58 PM, Felix Kuehling wrote:
> On 2023-04-10 10:36, Xiaogang.Chen wrote:
>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>
>> During KFD restore evicted userptr BOs mmu invalidate callback may 
>> invalidate
>> same userptr BOs that have been just restored. When KFD restore 
>> process detects
>> it KFD will reschedule another validation process. It is not an 
>> error. Change
>> WARN to pr_debug, not put the BOs at userptr_valid_list, let next 
>> scheduled
>> delayed work validate them again.
>
> The problem is not, that a concurrent MMU notifier invalidated the 
> pages. The problem is, that the sequence number and the mem->inval 
> flag disagree on this. In theory, both the sequence number and the 
> mem->inval flag are updated by amdgpu_amdkfd_evict_userptr in the same 
> critical section.
>
> When we validate the BO, we set mem->valid to true. If mem->valid gets 
> set back to false later, the sequence number should also be updated so 
> that amdgpu_ttm_tt_get_user_pages_done should return false. So 
> mem->valid and the sequence number should agree on whether the memory 
> is valid. However, these WARNs indicate that there is a mismatch. If 
> that happens, it means something went wrong. Some of the code's 
> assumptions are being violated and this justifies a WARN.
>
yes, mem->invalid change and mmu_interval_set_seq(mni, cur_seq) at 
amdgpu_amdkfd_evict_userptr are under process_info->notifier_lock 
protection, but mem->range->notifier_seq could be stale when mmu 
notifier happens concurrently.
> I think you mentioned that you only see the warnings with the DKMS 
> driver. I suspect this is happening on some old get_user_pages code 
> path, not the current hmm_range_fault-based one. I would recommend 
> looking into this problem on the DKMS branch and addressing the 
> problem there. This should not be fixed but removing legitimate WARNs 
> on the upstream branch.

It happened with dkms driver with HAVE_AMDKCL_HMM_MIRROR_ENABLED 
enabled, it is not old get_user_pages path. I retraced this part code. I 
think there are two issues:

1: amdgpu_ttm_tt_get_user_pages can fail(-EFAULT). If it failed we 
should not set it valid(mem->invalid = 0). In this case mem has no 
associated hmm range associated.

2: mmu notifier can happen concurrently and update 
mem->range->notifier->invalidate_seq, but not mem->range->notifier_seq. 
That causes mem->range->notifier_seq stale when mem is in 
process_info->userptr_inval_list and 
amdgpu_amdkfd_restore_userptr_worker got interrupted. At next 
rescheduled next attempt we use stale mem->range->notifier_seq to 
compare with mem->range->notifier->invalidate_seq.

I will send a patch based on amd-staging-drm-next and amd-staging-dkms-6.1.

Regards

Xiaogang

>
> Regards,
>   Felix
>
>
>>
>> Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 13 ++++++++++---
>>   1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index 7b1f5933ebaa..d0c224703278 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -2581,11 +2581,18 @@ static int 
>> confirm_valid_user_pages_locked(struct amdkfd_process_info *process_i
>>             mem->range = NULL;
>>           if (!valid) {
>> -            WARN(!mem->invalid, "Invalid BO not marked invalid");
>> +            if (!mem->invalid)
>> +                pr_debug("Invalid BO not marked invalid\n");
>> +
>> +            ret = -EAGAIN;
>> +            continue;
>> +        }
>> +
>> +        if (mem->invalid) {
>> +            pr_debug("Valid BO is marked invalid\n");
>>               ret = -EAGAIN;
>>               continue;
>>           }
>> -        WARN(mem->invalid, "Valid BO is marked invalid");
>>             list_move_tail(&mem->validate_list.head,
>>                      &process_info->userptr_valid_list);
>> @@ -2648,7 +2655,7 @@ static void 
>> amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
>>           goto unlock_notifier_out;
>>         if (confirm_valid_user_pages_locked(process_info)) {
>> -        WARN(1, "User pages unexpectedly invalid");
>> +        pr_debug("User pages unexpectedly invalid, reschedule 
>> another attempt\n");
>>           goto unlock_notifier_out;
>>       }
