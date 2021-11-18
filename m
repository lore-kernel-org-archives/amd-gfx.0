Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493ACC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 15:07:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3B766139F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 15:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F3B766139F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98B886ECE3;
	Thu, 18 Nov 2021 15:07:26 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 185956ECE3
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 15:07:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnNnxnBD2qevilhneUaXT1WRash3+RS4OdiPx+jnj44qErrgzdD2B8lgXgT4QIrDwLGyVmxa8TyzxqcX3C/CM3taJ05/2r58jfoNBbEfCTt4JCzyJFK0TaaTpOcbJq7N77o72MEWCyHMx7pQ2YFC1b3kGOMa0JkjbtZrky56m2LMlNxP32V4OpTa8nO8E8LQtJePu5d459KLB5fAW7xrfxi++eROChOaSUAbhjxFBVn2ed2VXEevvNfqIZIyl43Cvc5ChdJWySnsD/IGIHOENFr+NPYDSxX1hoUMOcXy0h9zQeucq+NGYKxLKC+PdK14ApdEC42XTXaFsbBdwDnAaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pEuM2BkSgkK5ar0V2NFhnPvVGgR8D82evzRJfmZW1KA=;
 b=bOBuydITWqgIvG61fkz3bK556FhCFjE/Oy5OA/lD63TF7e7BDrO+L8RT/5lS09Ev/mDjvkG2nGsCjYtfw+Nf90CegKG8e+AS3+SBuxpTXgiyap0KDBwINO1Ib2lKLZvDPJkRUjUs3m4h78WqfO8Yz/7ywnRFArnwpkKoqVjXKlv3Ut2qXkJ/djpPj7N84yGBLqEmlT8ShAT68lBlwSf5CZEmarSHlgpsXjB7wXcoYD4Hdczlcx8NHkypv+54p4PtmNwF0blNulCivIPV0j12f+MBtGbSdHIIH3wEmC1r+Tz5oWoN81qvGpO2TUiyCbEH69/YUnREs3PfN7tE2+u3fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEuM2BkSgkK5ar0V2NFhnPvVGgR8D82evzRJfmZW1KA=;
 b=pdvtbLbT36vapV6Rkmzy7/joCCiCgR4jVHksUOy82ZaI3DQCGHqOK4dd8pMA4te8xdFg5q+LyIfJN8p0nEkAEqvM+JlI2l/E0xxIbpr0aX+gAjSVGFvJ4Gw3Y8+G1fxmNktBVGmfknwGzSoOK4fM2GxcXn7bQf1IQNPpqFl0iQU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5289.namprd12.prod.outlook.com (2603:10b6:408:102::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.20; Thu, 18 Nov
 2021 15:07:24 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%8]) with mapi id 15.20.4713.022; Thu, 18 Nov 2021
 15:07:24 +0000
Subject: Re: [PATCH 2/3] drm/amdkfd: handle VMA remove race
To: philip yang <yangp@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20211117034324.4663-1-Philip.Yang@amd.com>
 <20211117034324.4663-2-Philip.Yang@amd.com>
 <5e1927f0-2cbc-e639-57b1-f61274ec97f4@amd.com>
 <5162a906-2f1d-bf1d-8313-62105e8f618e@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <f751ec08-d21b-819a-528d-65511095602d@amd.com>
Date: Thu, 18 Nov 2021 10:07:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <5162a906-2f1d-bf1d-8313-62105e8f618e@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0140.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::8) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.127.191.123) by
 YT3PR01CA0140.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:83::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.19 via Frontend Transport; Thu, 18 Nov 2021 15:07:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33b88a32-7414-4b41-b56d-08d9aaa52050
X-MS-TrafficTypeDiagnostic: BN9PR12MB5289:
X-Microsoft-Antispam-PRVS: <BN9PR12MB528944BA861760FB600B5662929B9@BN9PR12MB5289.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RfmOsCklX75Ur34zDME1L47OrbSWOi1V8/H1ftn5U3blWKhNw0A+BXOir9qjEl4rZGfmZDX4apHsd8+nMq9wieVSw9wXg4CxC1M85nFxRHruZDiRgfCyswOAHMj7QeFjDjt/1aez5jkz8aqHHRqI6ZkBzWehTclDkGHiMWIyj2WdVDC8hkG7Kf8jpi5ky4nEYiKdj9SyNMeHVd2OnNBTUWxEq1ywjgYvhmM1VmjnfPCtM6Jb3st5DceCcRb2DN4zKsF/fwR9+ocPJjPJ5sV1PgTzqijP5K7SglncQT8Y3f8JBSVOTpfJxp+Lct1s6gTOionv3Pm273UDtDR4uIfemHESHW1dCTR/aJ7odVqWrZMoFvZUBkDAExVjRBjFd0pKApmL5ohh0zuAJCzyHswb4YWK7+wRtWjEv4edyZ14XBSFkJqEr7PNEoahk9dVmdLfGIb2Ndh3jtkusV8Szuk9sOSCAk+7+LvuPu7ny1kvBG4TCImwCrWd2IlKjL5DOOCz/XbCK/fx0lnEV3eR6IolwweJb1Y8L1Avh2Qu9lrbFp616SuyksbNsTrbPAufEyNmJkvWRuiJK58dy+cf6FPZwVWCRojMSfh+dVC0eyrNazMUUfJz9n1xMl5IZLqdIEFQN5mMJ0k7NmZgR1rN9WdXHq5ekm5EUXYCYXlfo00jr4xtRgD1TslMwejoscsbc9vH7XvBfRNJaJ/JjL3+cdVW4t2SbhsbqswpP8szBfIxqH5/Ttsnl45nVS9HRPn9kRPd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(316002)(36756003)(110136005)(26005)(6486002)(508600001)(53546011)(31686004)(31696002)(8936002)(44832011)(2906002)(83380400001)(16576012)(66946007)(2616005)(956004)(66556008)(66476007)(4001150100001)(38100700002)(8676002)(86362001)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dW4rN2pzcGJPMXk2dVJOTUlzWCtXb2VyOHJQT2NVOEpEdlUvU090SVJXSjlG?=
 =?utf-8?B?MzFybWFTZUpqNmk4ZjNsYkxQQnU5MDBBcEFVTHlqUndydjhzWFJ1WHFMVzdz?=
 =?utf-8?B?YTRqNGRLZTFoc1FLdllNNjE2WDJrMXZpdDRydi9KdkxDR3FqTWhOT29EZ04z?=
 =?utf-8?B?Q0M2Q3p3Q2UwVmdyS1hWNmpWMDl3dDNlZlRSYXFVQnNyUWhBT01Td3dORXZC?=
 =?utf-8?B?WVJMT1MyVTUyMndVQkxDZmYzK012SDR6b1YvT1RIT3NhRUxvV2QxVmt6UEwv?=
 =?utf-8?B?SG1KNW1FeU9SUG4vNnpBd1Fic1J2dEduMHNjSFlYU2pya0Z4VGl5RUVQY1Nm?=
 =?utf-8?B?Z05TWkVpbVEvd1FTTHFvTmd2SkFvZU56TWFnMVhvT3BVTllCcUYrNEMyQTNm?=
 =?utf-8?B?NVliNDFkNGJmV3QrWk1iUUdJM0QrYk9XOWlhZ0YxL094dXNMMnNKTzhMQ2ZV?=
 =?utf-8?B?QjZoQll4Z2ZqTGhEUCtKWndDY3cxODdGUmVxWWlVUFpheDU5M2oyNjdMcUJV?=
 =?utf-8?B?Wllock5TS3FYUU00T0tVZ29VVnZ1OE5hM3JldE9EVFFDaFJNUUhlN29DR1d4?=
 =?utf-8?B?YTlrTS9Zb0ZjeStxYzNlR09lS2k0S3lXZmV2SlpWZTFValoySGR5UXhKSzhY?=
 =?utf-8?B?L0NyNlU3Ui81KzQwUDMzNk5CaEVCdnltM1pUc0VNL1BtUG5HN1lhUXQ5T3Fk?=
 =?utf-8?B?MVF3QjRTWDhucTFxVUM1UllkYkFBSFZRT3l5SmcwWW1jbmcrb3BMeGVES3Np?=
 =?utf-8?B?bGY3WGpnbkdtL01DeDF3a0pCckNoSktJWlYyeWd3WXJIL29zOFhIbzVFUVRD?=
 =?utf-8?B?WG5ZUXF3ek42NW1lNWhGcVV2ZUtsNm9USmFIcVZ6WFdGZjcrZFFvVjI0STBy?=
 =?utf-8?B?NGRMWWk3ZE1kY0wzTVo4RExTblFvL3AzdFZyZjVVYUdTekU1Mi80aWxGN0gw?=
 =?utf-8?B?RVdodFVlNG9OSGpTQ0lCbWMwVnFNQjlXRGtRQWVBNXptOHpkaEJMZytYRytR?=
 =?utf-8?B?U3RWSUVMSnNkR0dNWTRnTVNJNnpGeE0wd3BKazg0eGhFcG9MWW9CQ1VNN3dF?=
 =?utf-8?B?S1pIOGhRWE1zZnVNbzZDL20xOXlaOVk5Umt2Uk92bHF1VHg1bEN4WGFaSEtr?=
 =?utf-8?B?RlovVE8zOUc0QWVVOVBoTmE0L25QWUpKRFk4dWxxVTFYY01kaHNoZ2lsOGRS?=
 =?utf-8?B?U0p5MCtSM25WM3JyODh3UWFzdTZHTHRWS28wZDhNbG5mOTlUOWpjVDA1RER4?=
 =?utf-8?B?RkhmLzNvNUpnS2paa0tlblJhbStwemlONi94QnlXRGZMYlZDYTFwaXBxbC8w?=
 =?utf-8?B?VFUvbnM1QW93MGpsQmRjaFBkcEU0NlhjYVlsWlpYZWhYNTlDZSs0b01BWXBU?=
 =?utf-8?B?OVpkUHVmQitZSHdrUGgvem1EbEN1TXNrOHFZNWloUEd5SnJ0Ui8wTVRveS9l?=
 =?utf-8?B?WmxQMGpBcGFCMHdRQUpHRlhJYTcvTEhUbXpEL2FJaGtKU0E5c3Z0Ny9jYnZw?=
 =?utf-8?B?SXd6UWE0SXkvNDhpcmRFWGVlVnJ2ZFJOQksvZXFCc1lPTnQzUEFMSGFuTm5z?=
 =?utf-8?B?RGR5a256TzJ5ZTRmSDE4c2xpYVFWNXUva2IycXJjNEVnVm1OQUEwQU9PcXJ5?=
 =?utf-8?B?QzZDUkFJelU2TThlU1FRd2J1S3RJQUtrV1RVSVY0eHdVYzFjcnVVbGd5bDd0?=
 =?utf-8?B?R1FGRWV5RmVtN2IrNWx3WVpSVGNaUEdBM1VHK25XSTh6VGJtWVZTS05seHBi?=
 =?utf-8?B?elNzZmRpR1FTeXlLODJzYXMzTVY1MFdNQXRzbk5NRkxvb09WdnM3L1FGWlVZ?=
 =?utf-8?B?ZzlqSU40NXYxVkNmak1ibTRIb2VUd0RSMHJ6d0JRTTBDYll6djJPcmE0elJY?=
 =?utf-8?B?ZzJMSzI4cXRGN3BjbkFYcGNBOUl1Q01HMGZmRjBYbWgxbXBJTEJYMU1SdGxx?=
 =?utf-8?B?UGZ6SzVlT1NLSjJsck9SWUR6NVZzYVVWOEVFcGYvbXhtRmdiN0lZRy80Kzdi?=
 =?utf-8?B?T05tQ0hnS29yS0x3ZXR0T2tBY2w1K0FFYkZLcDNDTWV6TXF1UGpKbmFzUzd6?=
 =?utf-8?B?R2VyditNbXNDQkxyOHA2TndYODRQNWE0eTJlemR0ZVpWWWhpUFFaTFJKT2pR?=
 =?utf-8?B?L2VNWXdTSVB0YU8xcDlJSldnb1ZycmYxdjMrdFFOQ3RPRkJTSGxrRUtsekdV?=
 =?utf-8?Q?2aWQq0tXXuvLTOF9zQGmyT0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b88a32-7414-4b41-b56d-08d9aaa52050
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 15:07:24.1427 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FBbGmXtZk2lA/FmUzX3oCOlF8OutN8G0zshELSZG1bipZ5rF/bjuMXgE3SIpHn/h8KsXkrWWNwtSs7bip2JzZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5289
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

Am 2021-11-18 um 10:00 a.m. schrieb philip yang:
>
>
> On 2021-11-17 7:10 p.m., Felix Kuehling wrote:
>> On 2021-11-16 10:43 p.m., Philip Yang wrote:
>>> VMA may be removed before unmap notifier callback, restore pages take
>>> mmap write lock to lookup VMA to avoid race,
>>
>> The old code looked up the VMA after taking the mmap lock (either
>> read or write) and kept holding the lock afterwards. I think even
>> with your new code it's possible that the VMA disappears before you
>> take the lock the first time, so always taking the write lock only
>> reduces the time window in which things can go wrong, but it doesn't
>> remove the race.
> Take mmap write lock will serialize with __do_munmap,

__do_munmap runs with the mmap write lock. Taking the read lock should
be sufficient to serialize with it.

Regards,
  Felix


> to ensure vma remove and unmap callback are done, because unmap
> callback set drain_retryfaults flag, so we can safely drain the
> faults, and it is app bug if vma not found after taking mmap write lock.
>>
>> I still struggle to understand the race you're trying to fix. The
>> only time the svm_restore_pages can see that the VMA is gone AND the
>> prange is gone is after the deferred worker has removed the prange.
>> But the fault draining in the deferred worker should prevent us from
>> ever seeing stale faults in that situation. That means, if no prange
>> is found and no VMA is found, it's definitely an application bug.
>>
>> The only possible race is in the case where the prange still exists
>> but the VMA is gone (needed by svm_fault_allowed). We can treat that
>> as a special case where we just return success because we know that
>> we're handling a stale fault for a VMA that's in the middle of being
>> unmapped. The fact that the prange still existed means that there
>> once was a valid mapping at the address but the deferred worker just
>> hasn't had a chance to clean it up yet.
>>
> Yes, that is only possible race.
>> One more comment inline.
>>
>>
>>>   and then create unregister
>>> new range and check VMA access permission, then downgrade to take mmap
>>> read lock to recover fault. Refactor code to avoid duplicate VMA
>>> lookup.
>>>
>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 65
>>> ++++++++++------------------
>>>   1 file changed, 24 insertions(+), 41 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index c1f367934428..3eb0a9491755 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -2329,20 +2329,13 @@ svm_range_best_restore_location(struct
>>> svm_range *prange,
>>>   }
>>>     static int
>>> -svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
>>> -                   unsigned long *start, unsigned long *last,
>>> -                   bool *is_heap_stack)
>>> +svm_range_get_range_boundaries(struct kfd_process *p, struct
>>> vm_area_struct *vma,
>>> +                   int64_t addr, unsigned long *start,
>>> +                   unsigned long *last, bool *is_heap_stack)
>>>   {
>>> -    struct vm_area_struct *vma;
>>>       struct interval_tree_node *node;
>>>       unsigned long start_limit, end_limit;
>>>   -    vma = find_vma(p->mm, addr << PAGE_SHIFT);
>>> -    if (!vma || (addr << PAGE_SHIFT) < vma->vm_start) {
>>> -        pr_debug("VMA does not exist in address [0x%llx]\n", addr);
>>> -        return -EFAULT;
>>> -    }
>>> -
>>>       *is_heap_stack = (vma->vm_start <= vma->vm_mm->brk &&
>>>                 vma->vm_end >= vma->vm_mm->start_brk) ||
>>>                (vma->vm_start <= vma->vm_mm->start_stack &&
>>> @@ -2437,9 +2430,10 @@ svm_range_check_vm_userptr(struct kfd_process
>>> *p, uint64_t start, uint64_t last,
>>>     static struct
>>>   svm_range *svm_range_create_unregistered_range(struct
>>> amdgpu_device *adev,
>>> -                        struct kfd_process *p,
>>> -                        struct mm_struct *mm,
>>> -                        int64_t addr)
>>> +                           struct kfd_process *p,
>>> +                           struct mm_struct *mm,
>>> +                           struct vm_area_struct *vma,
>>> +                           int64_t addr)
>>>   {
>>>       struct svm_range *prange = NULL;
>>>       unsigned long start, last;
>>> @@ -2449,7 +2443,7 @@ svm_range
>>> *svm_range_create_unregistered_range(struct amdgpu_device *adev,
>>>       uint64_t bo_l = 0;
>>>       int r;
>>>   -    if (svm_range_get_range_boundaries(p, addr, &start, &last,
>>> +    if (svm_range_get_range_boundaries(p, vma, addr, &start, &last,
>>>                          &is_heap_stack))
>>>           return NULL;
>>>   @@ -2552,20 +2546,13 @@ svm_range_count_fault(struct amdgpu_device
>>> *adev, struct kfd_process *p,
>>>   }
>>>     static bool
>>> -svm_fault_allowed(struct mm_struct *mm, uint64_t addr, bool
>>> write_fault)
>>> +svm_fault_allowed(struct vm_area_struct *vma, bool write_fault)
>>>   {
>>>       unsigned long requested = VM_READ;
>>> -    struct vm_area_struct *vma;
>>>         if (write_fault)
>>>           requested |= VM_WRITE;
>>>   -    vma = find_vma(mm, addr << PAGE_SHIFT);
>>> -    if (!vma || (addr << PAGE_SHIFT) < vma->vm_start) {
>>> -        pr_debug("address 0x%llx VMA is removed\n", addr);
>>> -        return true;
>>> -    }
>>> -
>>>       pr_debug("requested 0x%lx, vma permission flags 0x%lx\n",
>>> requested,
>>>           vma->vm_flags);
>>>       return (vma->vm_flags & requested) == requested;
>>> @@ -2582,7 +2569,7 @@ svm_range_restore_pages(struct amdgpu_device
>>> *adev, unsigned int pasid,
>>>       uint64_t timestamp;
>>>       int32_t best_loc;
>>>       int32_t gpuidx = MAX_GPU_INSTANCE;
>>> -    bool write_locked = false;
>>> +    struct vm_area_struct *vma = NULL;
>>>       int r = 0;
>>>         if (!KFD_IS_SVM_API_SUPPORTED(adev->kfd.dev)) {
>>> @@ -2606,26 +2593,22 @@ svm_range_restore_pages(struct amdgpu_device
>>> *adev, unsigned int pasid,
>>>         /* mm is available because kfd_process_notifier_release
>>> drain fault */
>>>       mm = p->mm;
>>> +    mmap_write_lock(mm);
>>
>> Always taking the write lock is unnecessary. I think we can keep the
>> old strategy of retrying with the write lock only when necessary. I
>> think this should work correctly as long as you lookup the VMA every
>> time after taking either the mmap read or write lock. The vma you
>> looked up should be valid as long as you hold that lock.
>>
>> As I pointed out above, if svm_range_from_addr finds a prange but the
>> VMA is missing, we can treat that as a special case and return
>> success (just draining a stale fault on a VMA that's being unmapped).
>
> ok, I will change svm_fault_allowed to return success if VMA is
> missing, it is simpler to handle this special race case, without
> taking mmap write lock.
>
> Regards,
>
> Philip
>
>>
>> Regards,
>>   Felix
>>
>>
>>> +
>>> +    vma = find_vma(p->mm, addr << PAGE_SHIFT);
>>> +    if (!vma || (addr << PAGE_SHIFT) < vma->vm_start) {
>>> +        pr_debug("VMA not found for address 0x%llx\n", addr);
>>> +        mmap_write_downgrade(mm);
>>> +        r = -EFAULT;
>>> +        goto out_unlock_mm;
>>> +    }
>>>   -    mmap_read_lock(mm);
>>> -retry_write_locked:
>>>       mutex_lock(&svms->lock);
>>>       prange = svm_range_from_addr(svms, addr, NULL);
>>>       if (!prange) {
>>>           pr_debug("failed to find prange svms 0x%p address
>>> [0x%llx]\n",
>>>                svms, addr);
>>> -        if (!write_locked) {
>>> -            /* Need the write lock to create new range with MMU
>>> notifier.
>>> -             * Also flush pending deferred work to make sure the
>>> interval
>>> -             * tree is up to date before we add a new range
>>> -             */
>>> -            mutex_unlock(&svms->lock);
>>> -            mmap_read_unlock(mm);
>>> -            mmap_write_lock(mm);
>>> -            write_locked = true;
>>> -            goto retry_write_locked;
>>> -        }
>>> -        prange = svm_range_create_unregistered_range(adev, p, mm,
>>> addr);
>>> +        prange = svm_range_create_unregistered_range(adev, p, mm,
>>> vma, addr);
>>>           if (!prange) {
>>>               pr_debug("failed to create unregistered range svms
>>> 0x%p address [0x%llx]\n",
>>>                    svms, addr);
>>> @@ -2634,8 +2617,8 @@ svm_range_restore_pages(struct amdgpu_device
>>> *adev, unsigned int pasid,
>>>               goto out_unlock_svms;
>>>           }
>>>       }
>>> -    if (write_locked)
>>> -        mmap_write_downgrade(mm);
>>> +
>>> +    mmap_write_downgrade(mm);
>>>         mutex_lock(&prange->migrate_mutex);
>>>   @@ -2652,7 +2635,7 @@ svm_range_restore_pages(struct amdgpu_device
>>> *adev, unsigned int pasid,
>>>           goto out_unlock_range;
>>>       }
>>>   -    if (!svm_fault_allowed(mm, addr, write_fault)) {
>>> +    if (!svm_fault_allowed(vma, write_fault)) {
>>>           pr_debug("fault addr 0x%llx no %s permission\n", addr,
>>>               write_fault ? "write" : "read");
>>>           r = -EPERM;
>>> @@ -2704,10 +2687,10 @@ svm_range_restore_pages(struct amdgpu_device
>>> *adev, unsigned int pasid,
>>>       mutex_unlock(&prange->migrate_mutex);
>>>   out_unlock_svms:
>>>       mutex_unlock(&svms->lock);
>>> +out_unlock_mm:
>>>       mmap_read_unlock(mm);
>>>         svm_range_count_fault(adev, p, gpuidx);
>>> -
>>>   out:
>>>       kfd_unref_process(p);
>>>   
