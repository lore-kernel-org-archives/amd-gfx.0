Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1FFC77B6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 03:27:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F035C10E074;
	Fri, 14 Apr 2023 03:27:44 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AB4010E074
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 03:27:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqcHLXA2IhH+Nj/U5A/VKA4pvdb7Exf40ScrYJw/3phPmyTS0JLt6t0e8gfc9WJ6PlKHw+v5XPyliIsfO1jNZfAHju7wkIpq6D4v3R/+2/j9/wdQvGux5tyLoTUe4t1IA1/Y82GXfBUpLnYbbJUfWoUMs5k5ClnAyvTX2nj/WkhuxJ0Pp1+mHQScdZHhYF1AgWlbH3jl6ah2+HXgbEBNM0/pVofSIp1DcNuyA/5ixs1GB8xHCVv0yHCFW+3jXxEtQ77zbHEC5QHmvo0n7VBbdITCL68P7rxk4z14W0+5AaF8A0wu0UUzkkgjwmOHb/bjNXh+ymFDqgOuMJtwhQWZaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cxeo1QYUtJ1kMkRRX+ziZzHsjWZLKsDaWB0AMX1hgQ=;
 b=AtCtRZRoXgF07KA2jANjUfbqfeFxmK5NgKSpRv4kKw0pOo+r3yZXP11KYIIgHMz4W+RtrS5HhhZKDLt4DBbsG9w5x6egzNzMx3plD53Ru9xYfqk66NmcOhvH5xkH0hcXZh/j9z6OyOonLyWceos2xEdnIWCrE10tYviQbOS2EFz9j0ayDAH2yj+HKMocjzSWWAqEerkP20kDkQHXxq+izoMSyPfKBBcjmjMwThpeVBuPM9ZGidbrEyOs8JqJ7pJSEVKg5s1M6n5zQUtfC5LC8Ug6m9vvOlHolUhwHAdhdI7kyXGdTEu5Cbm2k0KpjHv/sAaNp75NobIk+hUb93UojA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cxeo1QYUtJ1kMkRRX+ziZzHsjWZLKsDaWB0AMX1hgQ=;
 b=3FrA4EGUsOmFbvtPqlxQuRHV7hKmTyeyCgEGr9TzvMDHY0HRFhiX0TCwSoDSKTX2sz/qBJGt7nkBlJgMvsNZcBRC5c+3W2wQI1j4uup0GaNWt/c3HbjRm7gXhItv4kIguIxlGNULlMFDANuuAt+Mee0G6q4dbRUgOZJy0voQbiQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 MW6PR12MB8959.namprd12.prod.outlook.com (2603:10b6:303:23c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Fri, 14 Apr
 2023 03:27:40 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::3c3:83f1:333c:fc17]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::3c3:83f1:333c:fc17%5]) with mapi id 15.20.6298.028; Fri, 14 Apr 2023
 03:27:40 +0000
Message-ID: <da29b4b9-0c7a-21ca-a050-007f4c7ce203@amd.com>
Date: Thu, 13 Apr 2023 22:27:37 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/amdkfd: Fix some issues at userptr buffer validation
 process.
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230412061432.207610-1-xiaogang.chen@amd.com>
 <aa76e51f-8343-a1d0-a4a9-8f1329288535@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <aa76e51f-8343-a1d0-a4a9-8f1329288535@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR01CA0050.prod.exchangelabs.com (2603:10b6:208:23f::19)
 To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|MW6PR12MB8959:EE_
X-MS-Office365-Filtering-Correlation-Id: a206a8d0-a712-47da-4b6b-08db3c9833a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YucLEiPM/crdukVRj5j1GIPUJOh7THA/lwwfSuET0Rkoq3a2nW36hj0MgnpoBusDShZd7aO7nGfbIlrzbq4skjgSTf2LZhv75F0PQb1Lm/S+GppLsDJEOslK46ESRXRI3dgUOe92xUpoda2esE2ET6RzUQHx8/yOecQWuQIuStdRriZSfCXIqblTewo7aPqS/hlDz3fIM54A0H30IiRR5XJ+vD7yPuYH0KCJHkIImwrBNOzCruCJtBmaFD6KdsUYqlkIw+npDdXErJ9z1nVkxV2Ya3v8oSPqUFNgGR1k/+n+aCYDEhfyLDm9weRG1UqK9d4W3HhExJd+7Bx5Fi/enYAaZQetNRkIcYdq8tQXusbwukHZEo8gmxPr5nsMs8ekw/MvOcna8pmCHPPBSzUWek1oCd5NJm/d15wiQMNjJw4KyBfux4ChmG4xPTQOro+XwnA7UAlee89KSB1F/C5rC6H2GQ558WflwKpka6dZoYPNDbukBhHYjygRxwLs5G4WMQFjhGUSPUvXrgh+kTUZCmHPsu9gWRfxW+bbOoHV1k4ugyQjPvLRaPP3ZKEFLPhMEcKEQKKqZpFWslxo5RMb7wddXNNyH6tjmUE+NppC4l5QUmLfClXHyRwjb6qKTSOJmRMNN/E1h1Ung0B8BVcB5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(451199021)(31686004)(478600001)(86362001)(36756003)(83380400001)(38100700002)(5660300002)(2616005)(6666004)(2906002)(6512007)(316002)(26005)(186003)(66476007)(53546011)(8676002)(41300700001)(66556008)(8936002)(66946007)(31696002)(6506007)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTNQeFVXM252cUtEZ1JVNS9jM1FJVmFGbnNBZjkwdEFSamlBMEpwVEdGem5M?=
 =?utf-8?B?dmpBb1NHUHQ2QnNVZHBqYmVkaDZoeTE3MXNyOGZwNXhjWTB4d0F1R09WS0N1?=
 =?utf-8?B?MXJEeFd0N1BKTDlEcWR5UmdWOVhVZG5GWG03UWtRWi9HS082ZW5KWnEwUWJ3?=
 =?utf-8?B?b1hjbnhLczJUNXowQ2tmNVNuQ2hiN1dNSmhTWUtYaEhKdlhuQjdPTmZ6RzBW?=
 =?utf-8?B?TkRyc1J6Ym91Zk04VG1uMTg2SlgxVS9ndGtScDg4K3ducVVqYy8rOGlqL3U1?=
 =?utf-8?B?WHJBMGtkcFUrY1hHU25EWVRPNVV2THIyUEdqR2hMbGYrRUErWWhkYUtSRThH?=
 =?utf-8?B?QWJiQ2o0R211OUJJNXN3dUR2RUlLMS8zMVh5aVBTNURzSytQTHd0YUJhRlUv?=
 =?utf-8?B?U3B5RjhSQURjWnVkbCtkL0wvRWQ5amdHN243bW5CQXFqSlpSZE5vcnRZd3lI?=
 =?utf-8?B?dmpCRmtKRnV6WllGTTdBYzNOYktJck5jTU1QeDUza0h3NzBld0xZZ3kvb1B1?=
 =?utf-8?B?QmFWVXd6WVhoZXJYYzlMZERSbnNBMGdSMmp4ZHRBcHp0VGw5cE1pdmNLaVY2?=
 =?utf-8?B?K01OQUszSTdmN2t3RXlVVHVFWUx0UTRQVjUrQllGVlJNNWNaYk5hbVpmOGNn?=
 =?utf-8?B?ZWw3VmpMZkUwenBHRnpkNUh2Qm54VW41bVN6L0YwU0N1d1FQdXFDemt4UlVv?=
 =?utf-8?B?MlJGVzBDS2piK0JpTEJwRnlCRjNIUXBxcU11ZTZ2VWRMbHZkQVlkSzBiVGpB?=
 =?utf-8?B?L0pBNXV2V3Fqb212d1VoV0ZWUllqSm5qRDh3TkJYelVKMEN1M1NpSEVaZ3VT?=
 =?utf-8?B?Ni92a1YrbWViTmRreG44K2E2RmVGKzgwcis1SjBtdnlOTFNVYWdtbU4xQ2Yy?=
 =?utf-8?B?cU12eHdvdTJVT3ZHL2ZYOVJ0WGNDWFRkSlpXeFR3d3BaSXlhbWVOVlA5MDl0?=
 =?utf-8?B?UG5xSkJUUXdpT0kybXZjaXpXbFgyblJVTVF6b1BtYVhPM0JydnZ4eWMxdUVX?=
 =?utf-8?B?QVN2Q0hsek4xdys1ZXZoc0xYTjhoMlhmK0dYTUxRcUdNb1RtOHhQSEhtVlVj?=
 =?utf-8?B?Qjl3RGZ2RjBmNURmNk5qVVBHNkZHTmo2bTlqM0lUSnZia2FMRjlxcWxHc3lo?=
 =?utf-8?B?eklEY1dXUXljUkNvb2pNbmFSTjI5WDM0d2xYdHE0MkU3ZTRhQTZ0ZkRuTlQ5?=
 =?utf-8?B?U0ZWU3FzMFlFbk5NV0xqMmJlUTBCNHpPaGxVQXQ5SFE0eHJUZjY4R0NIWlEr?=
 =?utf-8?B?OTNHdHExWTJxWS9SS0V5Zy8vTGgzQXp4WjRha1c5TDdZWjFlSHp0UnpHd25O?=
 =?utf-8?B?VEFSUS9PcGtZOU1aTVZHbDAwdGtzT0cwKzRsaGQ0S0VqU1NkQ0tpVlNRUHA5?=
 =?utf-8?B?bk5VbjYxV2NXYjNXZHRqWVZqb1ZzclJvVURIdzhGSWo5K0dxRGVFa0xoVFZw?=
 =?utf-8?B?VTlpTjV5T2NMR0E1Qy9BUUhpaTFrRUh2Y2p4eTB0TmxucWp0TVRFTDE3YjA3?=
 =?utf-8?B?aWRpczZod1BadG42WG1ibXp4bllnaWY1SFhwNjJQL2FmeUNWZWtJeXlDMHds?=
 =?utf-8?B?dUQrU3NncmcwQUk2SWJhNVJTRXY2SlN6NTVFK0Z6MnROcGs2MlI1MVdTcUJa?=
 =?utf-8?B?WENESy83djBaci9KbE12V2IwNG5UbUJVbm03K2t5Tit5UHMxNUZ5T3dlaVRC?=
 =?utf-8?B?TU1INVF3VjZMdTlxZSs5YTRBUk1YeSt2eldBV3dlZXhIWjU0T0E3MDlreTNi?=
 =?utf-8?B?QW1JMnBPUCsxYzVhTG54UjBXSERBQVhPVklWdzdaNkNTdWVzeUJoMDY0SXJG?=
 =?utf-8?B?U0JvQTRzSWp6SlNvNXlGS0E3blVhS3ppWXBrNDVMUzArTndaM0dYc0loaG9H?=
 =?utf-8?B?Q0lCNzJRNlNzTHQ2ajlKSWI5K1NDK29zZVYySWJQWmpHS1UvYVN3ZlZTU2Zr?=
 =?utf-8?B?M3dkSWFJWC9OWDIvOHJCTnRsUnRHd3dlcG1GK1pJN3U2cDFNc0F6L0lVaDFm?=
 =?utf-8?B?NDlKY2dTOXdnVHZFZGdjOVNUL3JOSUl5RUNjUlQzUExoSmd5c2xaeURxSElr?=
 =?utf-8?B?S09vU05EMEQ2QnJWaTBneWhkaTBkYXRqMnRBbzJib0V5NUtiRUM4NVNzOC9F?=
 =?utf-8?Q?cQX8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a206a8d0-a712-47da-4b6b-08db3c9833a9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 03:27:40.3920 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WePvPlTMkBP6TLMNTB/SJJMlhCBWN+qUJYjDJIxZPTPyHZPoPmXTPGgj8E8394nq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8959
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


On 4/13/2023 3:08 PM, Felix Kuehling wrote:
> Am 2023-04-12 um 02:14 schrieb Xiaogang.Chen:
>> From: Xiaogang Chen<xiaogang.chen@amd.com>
>>
>> Notice userptr buffer restore process has following issues:
>>
>> 1: amdgpu_ttm_tt_get_user_pages can fail(-EFAULT). If it failed we 
>> should not set
>> it valid(mem->invalid = 0). In this case mem has no associated hmm 
>> range or user_pages
>> associated.
>
> We don't want to suspend the process indefinitely when this happens. 
> This can happen if usermode calls munmap before unregistering the 
> userptr. What we want to happen in this case is, the process should 
> resume. If it accesses the virtual address, it will result in a page 
> fault, which alerts the application to its mistake. If it doesn't 
> access the virtual address, then there is no harm.
>
> It's a good catch that there is no useful hmm_range in this case to 
> check validity, so we should not warn about it in 
> confirm_valid_user_pages_locked.
>
Not sure why you said "suspend the process indefinitely". When 
mem(kgd_mem) has no hmm_range due to amdgpu_ttm_tt_get_user_pages fail 
the patch does not mark it valid( set mem->invalid != 0) and keep it at 
userptr_inval_list. The process has not been suspended.

Yes, in this customer application case amdgpu_ttm_tt_get_user_pages 
failed at vma_lookup. I think it unmap its buffer before unregister from 
KFD. This patch handles amdgpu_ttm_tt_get_user_pages in general: not 
mark it valid(mem->invalid != 0), keep it at userptr_inval_list, then at 
confirm_valid_user_pages_locked, check if mem has hmm range associated 
before WARN.

>> 2: mmu notifier can happen concurrently and update 
>> mem->range->notifier->invalidate_seq,
>> but not mem->range->notifier_seq. That causes 
>> mem->range->notifier_seq stale
>> when mem is in process_info->userptr_inval_list and 
>> amdgpu_amdkfd_restore_userptr_worker
>> got interrupted. At next rescheduled next attempt we use stale 
>> mem->range->notifier_seq
>> to compare with mem->range->notifier->invalidate_seq.
>
> amdgpu_hmm_range_get_pages updates mem->range->notifier_seq with the 
> current mem->range->notifier->invalidate_seq. If an eviction happens 
> after this, there is a collision and the range needs to be 
> revalidated. I think when you say "mem->range->notifier_seq is stale", 
> it means there was a collision. When this happens, mem->invalid should 
> be set to true at the same time. So confirm_valid_user_pages_locked 
> should not complain because mem->invalid and 
> amdgpu_ttm_tt_get_user_pages_done should agree that the range is invalid.
>
Yes, "mem->range->notifier_seq is stale" means it is different from 
mem->range->notifier_seq. It is caused by mmu notifier happened 
concurrently on same buffer that is still in restore process. For this 
case the patch update mem->range->notifier_seq:

+            if (mem->range)
+                mem->range->notifier_seq = 
mem->range->notifier->invalidate_seq;

Then restore process will skip confirm_valid_user_pages_locked, jump to 
next scheduled attempt: "goto unlock_notifier_out".

> "At next rescheduled next attempt we use stale 
> mem->range->notifier_seq": This is not really stale. The notifier_seq 
> indicates whether the pages returned by the last call to 
> amdgpu_hmm_range_get_pages are still valid. If it's "stale", it means 
> an invalidation (evict_userptr) happened and we need to 
> amdgpu_hmm_range_get_pages again. In theory, if an invalidation 
> happened since the last call, then mem->invalid should also be true. 
> So again, the sequence numbers and mem->invalid should agree and there 
> should be no warning.
>
When invalidation (evict_userptr) happen concurrently restore process 
will schedule next attempt. The mem->invalid is set to true by 
evict_userptr, also the sequence numbers. Both agree and with this patch 
we do not see WARN.
> The warning messages printed in confirm_valid_user_pages_locked 
> indicate that there is a mismatch between the sequence numbers and 
> mem->invalid. As I understand it, such a mismatch should be 
> impossible. Unless there are some bad assumptions in the code. I 
> haven't figured out what those bad assumptions are yet. Other than the 
> case for -EFAULT you pointed out above.
>
 From my debugging this customer app the warnings is due to we did not 
handle well if amdgpu_hmm_range_get_pages return -EFAULT and mmu 
notifier happen on same buffer concurrently. That lead we use mem 
without hmm range associated and stale mem->range->notifier_seq for 
following operations. With this patch there is no warning messages and 
not see other errors.

Xiaogang

> Regards,
>   Felix
>
>
>>
>> Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
>> ---
>>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 45 +++++++++++++++----
>>   1 file changed, 37 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index 7b1f5933ebaa..6881f1b0844c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -2444,7 +2444,9 @@ static int update_invalid_user_pages(struct 
>> amdkfd_process_info *process_info,
>>               ret = -EAGAIN;
>>               goto unlock_out;
>>           }
>> -        mem->invalid = 0;
>> +         /* set mem valid if mem has hmm range associated */
>> +        if (mem->range)
>> +            mem->invalid = 0;
>>       }
>>     unlock_out:
>> @@ -2576,16 +2578,28 @@ static int 
>> confirm_valid_user_pages_locked(struct amdkfd_process_info *process_i
>>       list_for_each_entry_safe(mem, tmp_mem,
>>                    &process_info->userptr_inval_list,
>>                    validate_list.head) {
>> -        bool valid = amdgpu_ttm_tt_get_user_pages_done(
>> -                mem->bo->tbo.ttm, mem->range);
>> +        /* Only check mem with hmm range associated */
>> +        bool valid;
>>   -        mem->range = NULL;
>> -        if (!valid) {
>> -            WARN(!mem->invalid, "Invalid BO not marked invalid");
>> +        if (mem->range) {
>> +            valid = amdgpu_ttm_tt_get_user_pages_done(
>> +                    mem->bo->tbo.ttm, mem->range);
>> +
>> +            mem->range = NULL;
>> +            if (!valid) {
>> +                WARN(!mem->invalid, "Invalid BO not marked invalid");
>> +                ret = -EAGAIN;
>> +                continue;
>> +            }
>> +        } else
>> +            /* keep mem without hmm range at userptr_inval_list */
>> +            continue;
>> +
>> +        if (mem->invalid) {
>> +            WARN(1, "Valid BO is marked invalid");
>>               ret = -EAGAIN;
>>               continue;
>>           }
>> -        WARN(mem->invalid, "Valid BO is marked invalid");
>>             list_move_tail(&mem->validate_list.head,
>>                      &process_info->userptr_valid_list);
>> @@ -2644,8 +2658,23 @@ static void 
>> amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
>>        * reference counting inside KFD will handle this case.
>>        */
>>       mutex_lock(&process_info->notifier_lock);
>> -    if (process_info->evicted_bos != evicted_bos)
>> +    if (process_info->evicted_bos != evicted_bos) {
>> +        /* mmu notifier interrupted 
>> amdgpu_amdkfd_restore_userptr_worker
>> +         * before reschedule next attempt update stale 
>> mem->range->notifier_seq
>> +         * inside userptr_inval_list
>> +         */
>> +        struct kgd_mem *mem, *tmp_mem;
>> +
>> +        list_for_each_entry_safe(mem, tmp_mem,
>> +                &process_info->userptr_inval_list,
>> +                validate_list.head) {
>> +
>> +            if (mem->range)
>> +                mem->range->notifier_seq = 
>> mem->range->notifier->invalidate_seq;
>> +        }
>> +
>>           goto unlock_notifier_out;
>> +    }
>>         if (confirm_valid_user_pages_locked(process_info)) {
>>           WARN(1, "User pages unexpectedly invalid");
