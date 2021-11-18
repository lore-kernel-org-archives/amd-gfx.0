Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C43C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 16:01:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2221E60F4B
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 16:01:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2221E60F4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FACC6E7F5;
	Thu, 18 Nov 2021 16:01:56 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28EB56E7F5
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 16:01:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0I8uMUPsJ/o2L2N0bwGrTzV5npqlNP9nlA6wuPfcY1BpgX/MA9HuMXDzMSLyWje6WszZpqV700YPTmqFNXytKKlHVyOkxzbtqH/Zofhz6+dCIMOSmCKs7YKE2SSfcymnrUIbTOslgi5/6cX6BI2L52vUKvwZpdnUcDoxI5DKHkJJWNlRZ7qX5zpCqR7PIYeYRZQWNBRmYp3GQqncdLI4yaruM32+5OlqtMIhjnw5H9MlJiy5ZWXUkiSPR2/mexfYWf3uMfZNpMs24pNYj9sq4D1hRvDM6hIkB/uGm65XY+I3giGPqmG1FotBtiBSoDI6hz5B7sUtnWXIoaBaOk1Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gG2rpk3C3MSdMvLQb4MWTwXud9VeIqYCmXB3FIAnigU=;
 b=Ide6ZSFDACpzHRSX5L2AtvGqnJOmJGBr9FC2amb+0esRoBuHbu816cnSgYvsJ2u6SAAJl/L3V0X9alePJPuWGJXAQ60oBSqTjDc80Z/UFDbIrKA8VHD4f5KKizU5RmsEG2+6COvvON7QYrPU4BD9EARracJdusEOUCUkrI5VYSvcgWZXjck2IdZC0+zPR4S66UVjCV7l+EAKM9xEae/zYaneE1gyxVqVHdUpFiROQ3YGz+2CChcrR1qx6UQno5DUnvl9IxKry6n/TBMqH8+dZA3HOdx20v1Q72rsvH+W21LTRMKMlcW1Uo3u0Tv5UzUOgMFCuKAWrNp/qVl5z31s2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gG2rpk3C3MSdMvLQb4MWTwXud9VeIqYCmXB3FIAnigU=;
 b=fqR5jKd+FfvMF1FsYDU6nDuJc6dpz+s/AcwM5Rbr/VWrepSuSxN+kdgd0iYoLymY2PNAXtBzSn6YsFKKlRD7nvPn6f5bzADt8xPojuNR1jrGUkZM90eTX8QSt97fqWMi/w4Mba1YCVZNIR5cEf9gPC9+uLhpDnQvVLDOI+JFooc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5340.namprd12.prod.outlook.com (2603:10b6:408:105::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Thu, 18 Nov
 2021 16:01:48 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%8]) with mapi id 15.20.4713.022; Thu, 18 Nov 2021
 16:01:48 +0000
Subject: Re: [PATCH 2/3] drm/amdkfd: handle VMA remove race
To: philip yang <yangp@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20211117034324.4663-1-Philip.Yang@amd.com>
 <20211117034324.4663-2-Philip.Yang@amd.com>
 <5e1927f0-2cbc-e639-57b1-f61274ec97f4@amd.com>
 <5162a906-2f1d-bf1d-8313-62105e8f618e@amd.com>
 <f751ec08-d21b-819a-528d-65511095602d@amd.com>
 <6e00cc95-a6bb-0abd-36b9-96b4248d6aac@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <cc1345d4-e280-e7c6-a78c-1dd8778b82c7@amd.com>
Date: Thu, 18 Nov 2021 11:01:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <6e00cc95-a6bb-0abd-36b9-96b4248d6aac@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0146.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.127.191.123) by
 YT1PR01CA0146.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.19 via Frontend Transport; Thu, 18 Nov 2021 16:01:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c66f99c8-3672-4414-2692-08d9aaacb9ab
X-MS-TrafficTypeDiagnostic: BN9PR12MB5340:
X-Microsoft-Antispam-PRVS: <BN9PR12MB53406AC756832C01DA1A78D6929B9@BN9PR12MB5340.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d1eUuCYWUVhU8CnmG5sDa/G8xm/+6D34q8ZjXROMl99U+eB3CFodvRkUROpSAvWadkq7kkvrC2pgsBOpJg1CzVECDENSNB7NcPNV7GJx+MIKTezWjiBuoofKGasuJRfTUb2WlFf3IY9h6ZSCjPbdnn4xSQFEEOfIoULGShydpe7JG3ZviaK/U3zeFDwCIkcRYLNJd5sFYpKNB1mrjuzz+BKso0Cps1unP7pRQ1iDH5SyBZK71WultdgwzkTa7Ooz4IAJFHkUvi3qelb4BObF83mzwHq4Jj/tTWNvbFZpwa3Te99K1BJ/16JWMYEGU4snoodFYIcZc0HxhCAJww0BKC3ZVMOk/1umw8p7RSRk7NDhpRHNaEpN/yaGENNdsUExJ+KSrzOupd/jXWNsyak6OAkktz5Ixevc9WJjjAnA6qS2bLlX2vwGoNXZj1YGMPtlmJ31Vhuev9/xZ8zU6j0W8EIhzI/v2PJEhR8Oo0+MI/NIsrdz5cbfBWN3GDSBgF2aDrD21c7Gxk0y7bFM7dC08C3xmkj822nwYZ42hqi5vznH1+wuOyWAwEnGWEZk4sXvcjuVqa+bVdRcx93clbEWSNZHg9lbzLJjzTzIa8uWCENclqTGwb59/9LYUIHjM/e6je20JG3AmYkPzidaS14XG8LbkaS0tSljaoUe21f8RVnBTv7HhhAmWOx5VzMCjbVHjeN9ugfehWgSPxRAs2rvu7w9UQHtZI7FnQ5MmBolfiiALL1p1Xy6l6GUB2jKWBsT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31696002)(6486002)(186003)(5660300002)(38100700002)(66556008)(110136005)(8936002)(86362001)(26005)(30864003)(31686004)(2906002)(316002)(508600001)(83380400001)(8676002)(66476007)(16576012)(956004)(66946007)(53546011)(2616005)(44832011)(4001150100001)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1ZLejZwUWJ4RDF0dTJqQ2lQdEhpTXRPbnhFbTZ5dGY5aDFSVTdBSG1MZk5o?=
 =?utf-8?B?TWRWWm0zZmZhUG93N0FKeHpIeERqYllwSExqMEdIY1NEb25lVGFUWkdMYW83?=
 =?utf-8?B?Mnd3Zk42Y2s5OVRwbml3cWtvUDljVmx1dE83c3NsQWxIV3ArQXBMWStXaTBp?=
 =?utf-8?B?WWsxN2lLYkNvT1lWaENPWGZmUXdNNEtrYUJKK1NMWWd6UjNhSjYrZkR5bnM4?=
 =?utf-8?B?THVxcldabG5tczluUlNtRkYyNE9LM3ZpcmJYQi8xbmpQbVNyUVVFQWc0WEhT?=
 =?utf-8?B?RkI0UU5vZmFzOUQ0ZXdiaG5tOTEyNmJMdWtFWG11b0RkTVJSczE4Z2ttQktU?=
 =?utf-8?B?UkdRaHlTaStDUG8yWEJlS0Y2NmFzMTQ3dFdFS0hLRXRxTkJqT08wM1lRMjN2?=
 =?utf-8?B?QXQ1RkJ0alphdTFzN3h1V0FsVXNZR1RIbTZLWnFZV08yeUVmcVZaZzVJdmVX?=
 =?utf-8?B?ckN6d0dETC9OMFRqYklkMHBNc3dteDNiU2huR3NDa3RNZnpRN1drdlF6Qndp?=
 =?utf-8?B?ekFZL3g3aUw2VlBreGFwVEVIOFNZTUhLclhSL3U5Y1FpcGxybVFjdHZxUW5J?=
 =?utf-8?B?a3E2ekYxZWxFMTRkWkM1T1FkMkpVUVZ3UllRaTdkWjl6Z1lPSXd3SmhRREpW?=
 =?utf-8?B?NmIwakFGYkpSV3BIeEJ5QXFyVDNvdlhndGJNRjdRMDJNZXJIRGVHUnFKWWlE?=
 =?utf-8?B?TlNnUnF2OFovZ0gxWGszaXdSNnBVNzFEcFZDRFkrV1B5OWpnS0VMZCttejNO?=
 =?utf-8?B?b1VoSnRjYjhXNUkwZ0s2eEVyK1k1Z3plby9kK2prSWF6Z3lVdGJ3YVhhRS8w?=
 =?utf-8?B?S016OG85M2o5YW5YL0VaNHBTaHlycUxWbE5WMzdzdTQ0QUIzWlZRSnJ2K3ll?=
 =?utf-8?B?dndjdDRyai9pdFh6NWJiTFEweE1yaWR4WXU0LzhCMDRIVjNXNzVMMXFDT3FQ?=
 =?utf-8?B?UkdYSGNveGFsR2Qrb3pYQXkwSmZjRVI4SzZhUVhsQ3Uzc2dOaDlmaGNNbitt?=
 =?utf-8?B?ekUzb0o0VkliZkFMZ1VkNnl2bytORjJYU0I1VFhjd2dQTjNvUDVGQS9EMEJT?=
 =?utf-8?B?RW5ONVA1eUQ5OEg1RStnRHA3bnFEQ29TZGhCd3FJaGtlbWJINnRyVUFFdjZs?=
 =?utf-8?B?cWYwMDZPOWsyVDB0T3B0dTB0aWpGTm1TbWgzUDZvSENHZ3Jsa2hqclRMZ2Jx?=
 =?utf-8?B?SDhxck5TY0JwYjMvSkhrYVpRT2h0Sk5scE9VNlBjVUQ5ak5OOGd2a05xVFVD?=
 =?utf-8?B?V25QV1JJWnBhbVdNTkVJa01sdGtJUmdYeW9TZDVoZ0tFaXlSZW91YzBMZU9C?=
 =?utf-8?B?ekZFZnZXWGRQRUpRUUUzTzlYd3ZwY1MrcXNwUGJRcjlNczFDVU1JMG00S3Zu?=
 =?utf-8?B?UmtHSDAveThvRzN1eXpYejVrTkh6VlVnUkJ5SHJiUytlOHl4OGl6N3JySmVQ?=
 =?utf-8?B?TmJ4OC9QOExyUDZXSksyNW16ZW04MEUySmNQT0c5Q2NkZnRjbkcraWJ5Uksz?=
 =?utf-8?B?czd0aTdqanNYZzN1d0lPVmZPRW1zU0pBa29PaHRrakw5S1FISHFHRHcyNThr?=
 =?utf-8?B?SnRERnM5YVRyak9Od0dvTkZuN1pGalF1b2NaUnZRZzk3YUMzYUlYdnVGRG02?=
 =?utf-8?B?VW54dnQ1bmozTDQxMWgzUVNxcW0rTU5QYUxpOGxFbHQ3R2Z4aGZjY0p4WW5n?=
 =?utf-8?B?b08yQW9QMHRUMmZxV0gwN1lNcGczVS9QZ1lwSGtmeU1ERllwRy9mcjFYWUt3?=
 =?utf-8?B?c0xpZzRONmtOeUo2Sk9CWlVaOS9ic3MrK200M3huZjNrajhvck5PV3NUcEda?=
 =?utf-8?B?U1hxd3VxYzVobllxa0Z3Vm1DWkQ2NHQ3ZjNZaURnRnZORFFjN0k3OFYvN2pB?=
 =?utf-8?B?b2JZdytQdG1WUDhYWElja0lNV2NXYUEyYXluUmQ4dkZkbUpCdjhLOEtja05q?=
 =?utf-8?B?a09JemFOYmxYWmVCeXFjUWttTjRvZXh1VzBCSXFUNE42UmxQVVYzcWNaUkpi?=
 =?utf-8?B?d0E3c1lXYjJYSG5GZGo0cXJBUlIvR3czMERwTXM5WEQzQ215V3FpWFZZMFdo?=
 =?utf-8?B?S1d6eUt3OUM3ZC8zZlJnVEpYa3dxemNZa1J0eSswZ08va1VGVVMrdmxMWXRx?=
 =?utf-8?B?K0dBMFNEakRGRjhYUzV4MzlIamI2VzRLb1AzYTF2NUlTWlVORnpJSVgvdzE4?=
 =?utf-8?Q?gfowEm/yDlGWHpzbSEfMW4Y=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c66f99c8-3672-4414-2692-08d9aaacb9ab
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 16:01:47.8034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ARSrh4VkRfZH8cqFyHA6c86WxJ7/D8CLLCksj4gYiUkPkB/lBxb/lDea/o920AZwGnhvA7BwNmGPuAtQw7JVvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5340
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


Am 2021-11-18 um 10:55 a.m. schrieb philip yang:
>
>
> On 2021-11-18 10:07 a.m., Felix Kuehling wrote:
>> Am 2021-11-18 um 10:00 a.m. schrieb philip yang:
>>> On 2021-11-17 7:10 p.m., Felix Kuehling wrote:
>>>> On 2021-11-16 10:43 p.m., Philip Yang wrote:
>>>>> VMA may be removed before unmap notifier callback, restore pages take
>>>>> mmap write lock to lookup VMA to avoid race,
>>>> The old code looked up the VMA after taking the mmap lock (either
>>>> read or write) and kept holding the lock afterwards. I think even
>>>> with your new code it's possible that the VMA disappears before you
>>>> take the lock the first time, so always taking the write lock only
>>>> reduces the time window in which things can go wrong, but it doesn't
>>>> remove the race.
>>> Take mmap write lock will serialize with __do_munmap,
>> __do_munmap runs with the mmap write lock. Taking the read lock should
>> be sufficient to serialize with it.
>
> __do_munmap takes mmap write lock to remove vma, then downgrade to
> read lock to call unmap_region.
>
Yes. But it does that after detaching the VMA. So holding the read lock
is sufficient to ensure that a VMA you have looked up remains valid and
that __do_munmap will not remove it.

Regards,
  Felix


> static int __vm_munmap(unsigned long start, size_t len, bool downgrade)
> {
>     int ret;
>     struct mm_struct *mm = current->mm;
>     LIST_HEAD(uf);
>
>     if (mmap_write_lock_killable(mm))
>         return -EINTR;
>
>     ret = __do_munmap(mm, start, len, &uf, downgrade);
>     /*
>      * Returning 1 indicates mmap_lock is downgraded.
>      * But 1 is not legal return value of vm_munmap() and munmap(), reset
>      * it to 0 before return.
>      */
>     if (ret == 1) {
>         mmap_read_unlock(mm);
>         ret = 0;
>     } else
>         mmap_write_unlock(mm);
>
> }
>
> int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
> {
>
> ...
>
>     /* Detach vmas from rbtree */
>     if (!detach_vmas_to_be_unmapped(mm, vma, prev, end))
>         downgrade = false;
>
>     if (downgrade)
>         mmap_write_downgrade(mm);
>
>     unmap_region(mm, vma, prev, start, end);
>
> }
>
> Regards,
>
> Philip
>
>> Regards,
>>   Felix
>>
>>
>>> to ensure vma remove and unmap callback are done, because unmap
>>> callback set drain_retryfaults flag, so we can safely drain the
>>> faults, and it is app bug if vma not found after taking mmap write lock.
>>>> I still struggle to understand the race you're trying to fix. The
>>>> only time the svm_restore_pages can see that the VMA is gone AND the
>>>> prange is gone is after the deferred worker has removed the prange.
>>>> But the fault draining in the deferred worker should prevent us from
>>>> ever seeing stale faults in that situation. That means, if no prange
>>>> is found and no VMA is found, it's definitely an application bug.
>>>>
>>>> The only possible race is in the case where the prange still exists
>>>> but the VMA is gone (needed by svm_fault_allowed). We can treat that
>>>> as a special case where we just return success because we know that
>>>> we're handling a stale fault for a VMA that's in the middle of being
>>>> unmapped. The fact that the prange still existed means that there
>>>> once was a valid mapping at the address but the deferred worker just
>>>> hasn't had a chance to clean it up yet.
>>>>
>>> Yes, that is only possible race.
>>>> One more comment inline.
>>>>
>>>>
>>>>>   and then create unregister
>>>>> new range and check VMA access permission, then downgrade to take mmap
>>>>> read lock to recover fault. Refactor code to avoid duplicate VMA
>>>>> lookup.
>>>>>
>>>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 65
>>>>> ++++++++++------------------
>>>>>   1 file changed, 24 insertions(+), 41 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>> index c1f367934428..3eb0a9491755 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>> @@ -2329,20 +2329,13 @@ svm_range_best_restore_location(struct
>>>>> svm_range *prange,
>>>>>   }
>>>>>     static int
>>>>> -svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
>>>>> -                   unsigned long *start, unsigned long *last,
>>>>> -                   bool *is_heap_stack)
>>>>> +svm_range_get_range_boundaries(struct kfd_process *p, struct
>>>>> vm_area_struct *vma,
>>>>> +                   int64_t addr, unsigned long *start,
>>>>> +                   unsigned long *last, bool *is_heap_stack)
>>>>>   {
>>>>> -    struct vm_area_struct *vma;
>>>>>       struct interval_tree_node *node;
>>>>>       unsigned long start_limit, end_limit;
>>>>>   -    vma = find_vma(p->mm, addr << PAGE_SHIFT);
>>>>> -    if (!vma || (addr << PAGE_SHIFT) < vma->vm_start) {
>>>>> -        pr_debug("VMA does not exist in address [0x%llx]\n", addr);
>>>>> -        return -EFAULT;
>>>>> -    }
>>>>> -
>>>>>       *is_heap_stack = (vma->vm_start <= vma->vm_mm->brk &&
>>>>>                 vma->vm_end >= vma->vm_mm->start_brk) ||
>>>>>                (vma->vm_start <= vma->vm_mm->start_stack &&
>>>>> @@ -2437,9 +2430,10 @@ svm_range_check_vm_userptr(struct kfd_process
>>>>> *p, uint64_t start, uint64_t last,
>>>>>     static struct
>>>>>   svm_range *svm_range_create_unregistered_range(struct
>>>>> amdgpu_device *adev,
>>>>> -                        struct kfd_process *p,
>>>>> -                        struct mm_struct *mm,
>>>>> -                        int64_t addr)
>>>>> +                           struct kfd_process *p,
>>>>> +                           struct mm_struct *mm,
>>>>> +                           struct vm_area_struct *vma,
>>>>> +                           int64_t addr)
>>>>>   {
>>>>>       struct svm_range *prange = NULL;
>>>>>       unsigned long start, last;
>>>>> @@ -2449,7 +2443,7 @@ svm_range
>>>>> *svm_range_create_unregistered_range(struct amdgpu_device *adev,
>>>>>       uint64_t bo_l = 0;
>>>>>       int r;
>>>>>   -    if (svm_range_get_range_boundaries(p, addr, &start, &last,
>>>>> +    if (svm_range_get_range_boundaries(p, vma, addr, &start, &last,
>>>>>                          &is_heap_stack))
>>>>>           return NULL;
>>>>>   @@ -2552,20 +2546,13 @@ svm_range_count_fault(struct amdgpu_device
>>>>> *adev, struct kfd_process *p,
>>>>>   }
>>>>>     static bool
>>>>> -svm_fault_allowed(struct mm_struct *mm, uint64_t addr, bool
>>>>> write_fault)
>>>>> +svm_fault_allowed(struct vm_area_struct *vma, bool write_fault)
>>>>>   {
>>>>>       unsigned long requested = VM_READ;
>>>>> -    struct vm_area_struct *vma;
>>>>>         if (write_fault)
>>>>>           requested |= VM_WRITE;
>>>>>   -    vma = find_vma(mm, addr << PAGE_SHIFT);
>>>>> -    if (!vma || (addr << PAGE_SHIFT) < vma->vm_start) {
>>>>> -        pr_debug("address 0x%llx VMA is removed\n", addr);
>>>>> -        return true;
>>>>> -    }
>>>>> -
>>>>>       pr_debug("requested 0x%lx, vma permission flags 0x%lx\n",
>>>>> requested,
>>>>>           vma->vm_flags);
>>>>>       return (vma->vm_flags & requested) == requested;
>>>>> @@ -2582,7 +2569,7 @@ svm_range_restore_pages(struct amdgpu_device
>>>>> *adev, unsigned int pasid,
>>>>>       uint64_t timestamp;
>>>>>       int32_t best_loc;
>>>>>       int32_t gpuidx = MAX_GPU_INSTANCE;
>>>>> -    bool write_locked = false;
>>>>> +    struct vm_area_struct *vma = NULL;
>>>>>       int r = 0;
>>>>>         if (!KFD_IS_SVM_API_SUPPORTED(adev->kfd.dev)) {
>>>>> @@ -2606,26 +2593,22 @@ svm_range_restore_pages(struct amdgpu_device
>>>>> *adev, unsigned int pasid,
>>>>>         /* mm is available because kfd_process_notifier_release
>>>>> drain fault */
>>>>>       mm = p->mm;
>>>>> +    mmap_write_lock(mm);
>>>> Always taking the write lock is unnecessary. I think we can keep the
>>>> old strategy of retrying with the write lock only when necessary. I
>>>> think this should work correctly as long as you lookup the VMA every
>>>> time after taking either the mmap read or write lock. The vma you
>>>> looked up should be valid as long as you hold that lock.
>>>>
>>>> As I pointed out above, if svm_range_from_addr finds a prange but the
>>>> VMA is missing, we can treat that as a special case and return
>>>> success (just draining a stale fault on a VMA that's being unmapped).
>>> ok, I will change svm_fault_allowed to return success if VMA is
>>> missing, it is simpler to handle this special race case, without
>>> taking mmap write lock.
>>>
>>> Regards,
>>>
>>> Philip
>>>
>>>> Regards,
>>>>   Felix
>>>>
>>>>
>>>>> +
>>>>> +    vma = find_vma(p->mm, addr << PAGE_SHIFT);
>>>>> +    if (!vma || (addr << PAGE_SHIFT) < vma->vm_start) {
>>>>> +        pr_debug("VMA not found for address 0x%llx\n", addr);
>>>>> +        mmap_write_downgrade(mm);
>>>>> +        r = -EFAULT;
>>>>> +        goto out_unlock_mm;
>>>>> +    }
>>>>>   -    mmap_read_lock(mm);
>>>>> -retry_write_locked:
>>>>>       mutex_lock(&svms->lock);
>>>>>       prange = svm_range_from_addr(svms, addr, NULL);
>>>>>       if (!prange) {
>>>>>           pr_debug("failed to find prange svms 0x%p address
>>>>> [0x%llx]\n",
>>>>>                svms, addr);
>>>>> -        if (!write_locked) {
>>>>> -            /* Need the write lock to create new range with MMU
>>>>> notifier.
>>>>> -             * Also flush pending deferred work to make sure the
>>>>> interval
>>>>> -             * tree is up to date before we add a new range
>>>>> -             */
>>>>> -            mutex_unlock(&svms->lock);
>>>>> -            mmap_read_unlock(mm);
>>>>> -            mmap_write_lock(mm);
>>>>> -            write_locked = true;
>>>>> -            goto retry_write_locked;
>>>>> -        }
>>>>> -        prange = svm_range_create_unregistered_range(adev, p, mm,
>>>>> addr);
>>>>> +        prange = svm_range_create_unregistered_range(adev, p, mm,
>>>>> vma, addr);
>>>>>           if (!prange) {
>>>>>               pr_debug("failed to create unregistered range svms
>>>>> 0x%p address [0x%llx]\n",
>>>>>                    svms, addr);
>>>>> @@ -2634,8 +2617,8 @@ svm_range_restore_pages(struct amdgpu_device
>>>>> *adev, unsigned int pasid,
>>>>>               goto out_unlock_svms;
>>>>>           }
>>>>>       }
>>>>> -    if (write_locked)
>>>>> -        mmap_write_downgrade(mm);
>>>>> +
>>>>> +    mmap_write_downgrade(mm);
>>>>>         mutex_lock(&prange->migrate_mutex);
>>>>>   @@ -2652,7 +2635,7 @@ svm_range_restore_pages(struct amdgpu_device
>>>>> *adev, unsigned int pasid,
>>>>>           goto out_unlock_range;
>>>>>       }
>>>>>   -    if (!svm_fault_allowed(mm, addr, write_fault)) {
>>>>> +    if (!svm_fault_allowed(vma, write_fault)) {
>>>>>           pr_debug("fault addr 0x%llx no %s permission\n", addr,
>>>>>               write_fault ? "write" : "read");
>>>>>           r = -EPERM;
>>>>> @@ -2704,10 +2687,10 @@ svm_range_restore_pages(struct amdgpu_device
>>>>> *adev, unsigned int pasid,
>>>>>       mutex_unlock(&prange->migrate_mutex);
>>>>>   out_unlock_svms:
>>>>>       mutex_unlock(&svms->lock);
>>>>> +out_unlock_mm:
>>>>>       mmap_read_unlock(mm);
>>>>>         svm_range_count_fault(adev, p, gpuidx);
>>>>> -
>>>>>   out:
>>>>>       kfd_unref_process(p);
>>>>>   
