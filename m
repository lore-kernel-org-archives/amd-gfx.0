Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB7FCE79DC
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 14:35:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86D0B10E4D0;
	Wed, 20 Sep 2023 14:35:34 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45E4210E4D0
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 14:35:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5WB2NLGSsyQLjsiSf/oYySA098ID2xk+2uvxx6lUsCbdegDBtmdQwcNwrq3KBaeCF9aA00we9+qnUGnVhWekehZRaUaZUOh8/AJmQgSizgve1QD6qwd2vbgecZniEsxLgTg0QJtMTEmKDDovfXdOOPslJU5WznfH7jQ3ZWu1X7pv3rCW8Z8+g7SLD8nZoK6UMb/g8KPXOVnI+xxQTr9SDWXPe+CcMFavitERUcv/bWH+gVXBnjreHN3PEFuthylgs7nMCE3EQc0R+yCDHXn7q+P7eII0DsMYuXqss3pMxQaE9c0FPyiEO+V1/VSxtMRYU9YockTYffqzawcmZP9Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2g/NO86acIZ6z2o7maTeEa6uz8Nq0Ba6uQYArTFco6E=;
 b=EC0JYEbd1W1SgjhQZzyYeozQ4BtMndIDz8GE9BfNKaOrjyJuFZOGgi/iI3qpSqPkIEeWsXLKhMiN+1qhZTYhP1AFWQ63+stJnO00FVP6rFY95CIM8od4ruUoqAh71VjtoNJpCT6AFn1BtQSEI6JqO5E2TS/LD8iXqLs9wrDJs5qjlPRKwJOwCO8goYOxOJM3r502CMlW//zFCsl+g3XWx/FZ5pzyHps9IpRkZiHDMwXh88Likfo79TSKIntErLtFwjronCAJKQbbZnDga9Zaut1roqauYhJS3xvIpgLsOtYHTMejQ3tNIKaWE8EAwPz9W7UEe27aH7dg/r1ZeXDCbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2g/NO86acIZ6z2o7maTeEa6uz8Nq0Ba6uQYArTFco6E=;
 b=kOXmL2jt+T10v2I98ymZfbBnTwmiasNEunr1gmHLJUJQ4pgphVyRb2qbaWmt0rFO1zxafG5t+eJNhRAB5LY8CZf9lpk5ncf3R4Ip7KElxnTwiaoZgX8cTfczGgpzBPjE8yplj5szP0a/o3pEeUOVmhi46oArT7z//FHpIuUT9Gs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN0PR12MB6055.namprd12.prod.outlook.com (2603:10b6:208:3cd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 14:35:28 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f%6]) with mapi id 15.20.6813.018; Wed, 20 Sep 2023
 14:35:28 +0000
Message-ID: <b6fb1ca2-906c-08c5-9dd7-34e7f21af870@amd.com>
Date: Wed, 20 Sep 2023 10:35:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3] drm/amdkfd: Handle errors from svm validate and map
Content-Language: en-US
To: Philip Yang <yangp@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230913151617.18894-1-Philip.Yang@amd.com>
 <20230919142124.15092-1-Philip.Yang@amd.com>
 <cb12d72b-8427-89c1-209f-eb08901eb40f@amd.com>
 <b505cf13-aa3f-efaa-9510-fdc71ec94fd3@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <b505cf13-aa3f-efaa-9510-fdc71ec94fd3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXPR0101CA0042.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::19) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN0PR12MB6055:EE_
X-MS-Office365-Filtering-Correlation-Id: bb24be65-2f5f-454d-6699-08dbb9e6d5e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: imoUqd1WG78zihn7zPsjIMXTuyJsc6fImnttTl68duuxe+I1u2KDhK3iGfPKhSQD7brYvjuyWN+d64BBCu4veuzqQ1RvJuObJZEAjmAF/W+SnHIkVs3NaIaKKPPuZNrzyP9koooH6sIOGA8gY8yFTvIaYqMeFncxsG4zLv1V4v5rKgjLRoYhT5AI14SOcfT2p3swdMV9hebKKgX2tNX7bOeo0f3C9g2YlcOrWZ2NQm+U2Yw6brqNfCiDaeEs1PUvwVzrNFuEHsSXqqzotaokadMDKgSBcqWUBZsQBW6tGGlchrUqvodnWXzpY6c3PtUt0GMC2OjxCW/22uvhQVagIuGTTaixzlbm4TJPOWycl1GgVZ2RA1GnYGNTET85JmS/6A1iNK9kjoYS8Gb7xHgXOQd2bms72Uz6PdgqHnruJL2HYTvss5qZ7T9O/tR4Q4mESvQx+su5fyqS4nN3WB9ysBbPtRj0lDB+LMzUOpNWVdo1jr1QID3klmoDuNSd+tKVRU2W/qXzmbExS1sh382wE/fCU2L9ke+TeNxKUR9ReF2XYt5yMHanttpnoQj/Sr4L1jv5YgP4nts/IcrIH5mqvt+frx1MmoXIEsMQl/3uNySBAH2BlG8Xm5k3EDjOyZPIly3iUuUXqV+uWDwyBDKJPWZW6YAjWYB3SlZxAaeSZ51wYX5X5s4PxpYxSMcBLXDq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199024)(186009)(1800799009)(44832011)(66946007)(6486002)(53546011)(6506007)(31686004)(66556008)(110136005)(66476007)(41300700001)(6512007)(316002)(478600001)(6666004)(4326008)(8936002)(8676002)(2616005)(26005)(5660300002)(36756003)(38100700002)(83380400001)(2906002)(86362001)(15650500001)(31696002)(43740500002)(45980500001)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U21ZQ052VGRXWTBySi80bjI4ZmpTVHBTV3IzTk5EOGw1YStnVy9RcWo1UXdv?=
 =?utf-8?B?MDJQRVBHZXB0RVo1VWZCYXpIa2lid09zaElVcmJIKzU3YVVpT3lzUU9XbEpz?=
 =?utf-8?B?Nitqb3J3Ui9oVEZxdlZCNmRQMWtyVU1hV1UwdGhVRXJwRVRRZTdCTmxXK3lB?=
 =?utf-8?B?ZlNCSmx0WmgzZGk0S25nRDJpdW1hVHdiTmNrUUxab1dIaGdpdUtYa0hwdVpn?=
 =?utf-8?B?QTlwbVpybkJpVFhtV3JIU2x3NjNlWHI4Sk0yYjJEcG5lakxySkdNVkZtTmo3?=
 =?utf-8?B?TkhKWEdPK3ROWEwyUDVTN2JwWjFTUzg2ZGp4OEFGdldpVUpBeDhPRkhzZnAz?=
 =?utf-8?B?cHFaVHFCZ0d0NDdtU3BzQmpmSnptUFZUK3phSmNpUmRTZEx5THZMTVZTSENO?=
 =?utf-8?B?V1Z4U3VSdlRWalJRdVJxN21MbEw5REhwRWx0VXpSY2FQMW0zbEwwZUc2Zng3?=
 =?utf-8?B?Z1pBZ2VIT2QwVkVxc0p5cHRjUWRXZlpldEJod3BFdmFQZXJiWkl6b09xbjM1?=
 =?utf-8?B?ZWF2SWF5YzBMenFzUEhVQTlIT3B4WmJCOHQ5Zm5Qc09oTHhJdFk3QzEzRjN1?=
 =?utf-8?B?bGpBdlRCVFBTazRzUFp0VlI2ZGZMZWh2SnNhSEV0T2Z2cTEzczhRVWJhUTNQ?=
 =?utf-8?B?T2xQY2RiV3VmbjNjSEpoQTFRWjVKNGcwc3ZXRVA1U2lteHZOcjVhSElqTURo?=
 =?utf-8?B?U2pxMnJiMUNlTEtaSzBTSnBoYS9Dc3dNRUhiNEZ0VXg2b2ltT0gzTXpPL0NC?=
 =?utf-8?B?RW9tS2JyK0dqeGtXdnBRaVNQT3JrOWJxcWgvRTYrQTVwZmsxaExIdDM4WnJO?=
 =?utf-8?B?WnI2MjVwL1IvZFBjUWRCYjBIMHFvaW9CcDRLYnZndElicWJ2WjYxeEN0aC8v?=
 =?utf-8?B?SnE5YTRlT3NjOFluRDJKV3d4VDZpQlNkQmhCR0JOVVJMTnQ0b3ZwSEd0R05B?=
 =?utf-8?B?L2xRYkZFeEh4WlM2VFd5eTNiMFhUaUdrTkZGa2EzZVZHN0xuQ1hzRU5yTjg1?=
 =?utf-8?B?anZRQ0J0WkVGeGFlSjRkbzNObGNiU054a0lNRFZFUXU4d2hCclQ3YVM4bTQ1?=
 =?utf-8?B?bGZLWXBwallqaTFxU09Td0VwbmpQaTJiWVh0elB1aWs2S3JCU1hkSXRwMWJq?=
 =?utf-8?B?NnZidlJvSVFOV2psT2V4RG9YdkpyTHFlL3p5eWhsQTgzTUgrQ0xCc3JDVHpO?=
 =?utf-8?B?MUhtbDNoTWJhcU9sM0xaWk80Z1QvTnBXeG5nN0l3TmFuaFYxN0p4Y1JWZ2xh?=
 =?utf-8?B?RW1KS2Q1c1Q2L2hiTU1kaTZsTlZhMXFrR0dIcVpIS0diTzdIZGhITUNsR09U?=
 =?utf-8?B?aVYwb0ZFVFFpZSt5bUc3TE10YnZkRjFFUzFPUDVyb3NGUStKN1lSTE5TdlNL?=
 =?utf-8?B?RGlja08xSUpnU2ZmZGRsSUdQL3hQTDV2YUJISjhEN3VmODdMZE9xMkJ0cXA1?=
 =?utf-8?B?bHlXNFpNWTNUdnNGNnlIUEVHZXlYRkdPSngzV3c1bkNpSGtIc1JvdlBIOFpW?=
 =?utf-8?B?c0tNcENXTjRESWV5QXlMU3NCYmdtTnJBMDVMRmlnVjBRQVRlWjA3VlhlbG5R?=
 =?utf-8?B?YTJodEtzaVdWZndqN3E2TkpjYktabHhIZXVxd3ZJVmFzOHhXQW1BNmc1RUJh?=
 =?utf-8?B?TVNDSFZtcXlZZEVwejVTRithajZ3NytNbTBnOG1wbW1aM0VhMk5WRDgxYTdo?=
 =?utf-8?B?Mmx6M2pNMkFYYVB3TGJ1SGd3QkthMWd5Mzk0RGM5RHJnT21hTW1FSWoyc1FC?=
 =?utf-8?B?RHFRY0VwcEluTk1FUW43Q3k0NmJDekdVQWhpcHo1Y2hlcmVSdElVM1A0NUJq?=
 =?utf-8?B?L0l3M2FpSlQyaGYrNzl4YW5tY3hlMnV6ODN3WllUUUQ3VHpJRTRpMVE4WnND?=
 =?utf-8?B?VXVtVGZ1b0ZvYjJaakJheHdIcjhqWE1zNUpaNGxRZllRMU9Sa3F5K0hwN0Zp?=
 =?utf-8?B?Mi9TeXl2WkRRTXZjd1V6ZHpmS0txY2lna3pRcUFLYnFwYlRVaGdQNmJkazVh?=
 =?utf-8?B?KzVibHlBT0dxRHlJNEZVcUQxOEU5RDZ4OHNHSW1VbUFzSjlJa1FXekQzMkNK?=
 =?utf-8?B?eDFWbFdJd3BrZTNrSS9FTVBndkJSd1JzR0NWTDdGYkhJRlBBajlJemdoTnRt?=
 =?utf-8?Q?6Kppcg4Se0/eytIb0SHakhN/V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb24be65-2f5f-454d-6699-08dbb9e6d5e5
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 14:35:28.6887 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3c3rM7MkqYsyGlc1Rf/Egop+8Albmd3oRcQKdZ2mXRRoBulhwWckL9Klb0k1XsGSWc4+aK/y3Tv+NpkhmeWZOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6055
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
Cc: alex.sierra@amd.com, james.zhu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-09-20 10:20, Philip Yang wrote:
>
>
> On 2023-09-19 17:15, Felix Kuehling wrote:
>>
>> On 2023-09-19 10:21, Philip Yang wrote:
>>> If new range is splited to multiple pranges with max_svm_range_pages
>>> alignment and added to update_list, svm validate and map should keep
>>> going after error to make sure prange->mapped_to_gpu flag is up to date
>>> for the whole range.
>>>
>>> svm validate and map update set prange->mapped_to_gpu after mapping to
>>> GPUs successfully, otherwise clear prange->mapped_to_gpu flag (for
>>> update mapping case) instead of setting error flag, we can remove
>>> the redundant error flag to simpliy code.
>>>
>>> Refactor to remove goto and update prange->mapped_to_gpu flag inside
>>> svm_range_lock, to guarant we always evict queues or unmap from GPUs if
>>> there are invalid ranges.
>>>
>>> After svm validate and map return error -EAGIN, the caller retry will
>>> update the mapping for the whole range again.
>>>
>>> Fixes: c22b04407097 ("drm/amdkfd: flag added to handle errors from 
>>> svm validate and map")
>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 78 
>>> +++++++++++++---------------
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h |  1 -
>>>   2 files changed, 36 insertions(+), 43 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index 50c29fd844fb..4812f4ac5579 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -818,7 +818,7 @@ svm_range_is_same_attrs(struct kfd_process *p, 
>>> struct svm_range *prange,
>>>           }
>>>       }
>>>   -    return !prange->is_error_flag;
>>> +    return true;
>>>   }
>>>     /**
>>> @@ -1671,7 +1671,7 @@ static int svm_range_validate_and_map(struct 
>>> mm_struct *mm,
>>>         start = prange->start << PAGE_SHIFT;
>>>       end = (prange->last + 1) << PAGE_SHIFT;
>>> -    for (addr = start; addr < end && !r; ) {
>>> +    for (addr = start; !r && addr < end; ) {
>>>           struct hmm_range *hmm_range;
>>>           struct vm_area_struct *vma;
>>>           unsigned long next;
>>> @@ -1680,62 +1680,55 @@ static int svm_range_validate_and_map(struct 
>>> mm_struct *mm,
>>>           bool readonly;
>>>             vma = vma_lookup(mm, addr);
>>> -        if (!vma) {
>>> +        if (vma) {
>>> +            readonly = !(vma->vm_flags & VM_WRITE);
>>> +
>>> +            next = min(vma->vm_end, end);
>>> +            npages = (next - addr) >> PAGE_SHIFT;
>>> +            WRITE_ONCE(p->svms.faulting_task, current);
>>> +            r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, 
>>> npages,
>>> +                               readonly, owner, NULL,
>>> +                               &hmm_range);
>>> +            WRITE_ONCE(p->svms.faulting_task, NULL);
>>> +            if (r) {
>>> +                pr_debug("failed %d to get svm range pages\n", r);
>>> +                if (r == -EBUSY)
>>> +                    r = -EAGAIN;
>>> +            }
>>> +        } else {
>>>               r = -EFAULT;
>>> -            goto unreserve_out;
>>> -        }
>>> -        readonly = !(vma->vm_flags & VM_WRITE);
>>> -
>>> -        next = min(vma->vm_end, end);
>>> -        npages = (next - addr) >> PAGE_SHIFT;
>>> -        WRITE_ONCE(p->svms.faulting_task, current);
>>> -        r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, 
>>> npages,
>>> -                           readonly, owner, NULL,
>>> -                           &hmm_range);
>>> -        WRITE_ONCE(p->svms.faulting_task, NULL);
>>> -        if (r) {
>>> -            pr_debug("failed %d to get svm range pages\n", r);
>>> -            if (r == -EBUSY)
>>> -                r = -EAGAIN;
>>> -            goto unreserve_out;
>>>           }
>>>   -        offset = (addr - start) >> PAGE_SHIFT;
>>> -        r = svm_range_dma_map(prange, ctx->bitmap, offset, npages,
>>> -                      hmm_range->hmm_pfns);
>>> -        if (r) {
>>> -            pr_debug("failed %d to dma map range\n", r);
>>> -            goto unreserve_out;
>>> +        if (!r) {
>>> +            offset = (addr - start) >> PAGE_SHIFT;
>>> +            r = svm_range_dma_map(prange, ctx->bitmap, offset, npages,
>>> +                          hmm_range->hmm_pfns);
>>> +            if (r)
>>> +                pr_debug("failed %d to dma map range\n", r);
>>>           }
>>>             svm_range_lock(prange);
>>> -        if (amdgpu_hmm_range_get_pages_done(hmm_range)) {
>>> +        if (!r && amdgpu_hmm_range_get_pages_done(hmm_range)) {
>>>               pr_debug("hmm update the range, need validate again\n");
>>>               r = -EAGAIN;
>>> -            goto unlock_out;
>>>           }
>>> -        if (!list_empty(&prange->child_list)) {
>>> +
>>> +        if (!r && !list_empty(&prange->child_list)) {
>>>               pr_debug("range split by unmap in parallel, validate 
>>> again\n");
>>>               r = -EAGAIN;
>>> -            goto unlock_out;
>>>           }
>>>   -        r = svm_range_map_to_gpus(prange, offset, npages, readonly,
>>> -                      ctx->bitmap, wait, flush_tlb);
>>> +        if (!r)
>>> +            r = svm_range_map_to_gpus(prange, offset, npages, 
>>> readonly,
>>> +                          ctx->bitmap, wait, flush_tlb);
>>>   -unlock_out:
>>> +        prange->mapped_to_gpu = !r;
>>
>> I'm still concerned that this can update prange->mapped_to_gpu to 
>> "true" before the entire range has been successfully mapped. This 
>> could cause race conditions if someone looks at this variable while a 
>> validate_and_map is in progress. This would avoid such race conditions:
>>
>>         if (!r && next == end)
>>             prange->mapped_to_gpu = true;
>>
> thanks, will also add else path for error handling, to exit the loop 
> with correct flag.
>
>           else if (r)
>
>              prange->mapped_to_gpu = false;
>
I thought about that. I think the flag should be false going into the 
function. There should be no need to validate and map the range if it's 
already mapped and valid. So if anything, we should set the flag to 
false in the beginning.

Regards,
   Felix


> Regards,
>
> Philip
>
>> Regards,
>>   Felix
>>
>>
>>>           svm_range_unlock(prange);
>>>             addr = next;
>>>       }
>>>   -    if (addr == end)
>>> -        prange->mapped_to_gpu = true;
>>> -
>>> -unreserve_out:
>>>       svm_range_unreserve_bos(ctx);
>>> -
>>> -    prange->is_error_flag = !!r;
>>>       if (!r)
>>>           prange->validate_timestamp = ktime_get_boottime();
>>>   @@ -2104,7 +2097,8 @@ svm_range_add(struct kfd_process *p, 
>>> uint64_t start, uint64_t size,
>>>           next = interval_tree_iter_next(node, start, last);
>>>           next_start = min(node->last, last) + 1;
>>>   -        if (svm_range_is_same_attrs(p, prange, nattr, attrs)) {
>>> +        if (svm_range_is_same_attrs(p, prange, nattr, attrs) &&
>>> +            prange->mapped_to_gpu) {
>>>               /* nothing to do */
>>>           } else if (node->start < start || node->last > last) {
>>>               /* node intersects the update range and its attributes
>>> @@ -3517,7 +3511,7 @@ svm_range_set_attr(struct kfd_process *p, 
>>> struct mm_struct *mm,
>>>       struct svm_range *next;
>>>       bool update_mapping = false;
>>>       bool flush_tlb;
>>> -    int r = 0;
>>> +    int r, ret = 0;
>>>         pr_debug("pasid 0x%x svms 0x%p [0x%llx 0x%llx] pages 0x%llx\n",
>>>            p->pasid, &p->svms, start, start + size - 1, size);
>>> @@ -3605,7 +3599,7 @@ svm_range_set_attr(struct kfd_process *p, 
>>> struct mm_struct *mm,
>>>   out_unlock_range:
>>>           mutex_unlock(&prange->migrate_mutex);
>>>           if (r)
>>> -            break;
>>> +            ret = r;
>>>       }
>>>         dynamic_svm_range_dump(svms);
>>> @@ -3618,7 +3612,7 @@ svm_range_set_attr(struct kfd_process *p, 
>>> struct mm_struct *mm,
>>>       pr_debug("pasid 0x%x svms 0x%p [0x%llx 0x%llx] done, r=%d\n", 
>>> p->pasid,
>>>            &p->svms, start, start + size - 1, r);
>>>   -    return r;
>>> +    return ret ? ret : r;
>>>   }
>>>     static int
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>> index c216c8dd13c6..25f711905738 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>> @@ -133,7 +133,6 @@ struct svm_range {
>>>       DECLARE_BITMAP(bitmap_access, MAX_GPU_INSTANCE);
>>>       DECLARE_BITMAP(bitmap_aip, MAX_GPU_INSTANCE);
>>>       bool                mapped_to_gpu;
>>> -    bool                is_error_flag;
>>>   };
>>>     static inline void svm_range_lock(struct svm_range *prange)
