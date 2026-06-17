Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 195E1CD98F2
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 17:23:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B22E10E2FD;
	Wed, 17 Jun 2026 17:23:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nzZ519Aa";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010022.outbound.protection.outlook.com [52.101.46.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A724110E2FD
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 17:22:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LHvYQ+wgOCZw74L+n8m1oXXRw3u11IabzmETCUWbKFGCJ2D9qY1eQIcarZ1Ru/16lyKhYjR8Zkg6M0hwRhMLuY1s4zUAAwY81pW/YUQWJRv2LBgoh7H412sRaq6sP6fQ1RNv4kk8AWzHcLLvISUeiqzdvGOKCTfkY8VkufboyBxG0YceAHk0yWR15Tv2I5EN+3pc3WDijZIR2B48Nnz2nhti3T4XgSKy3tsFn04Bp9J2Dk9BjtG0lBPF158ohlSMkgTMi9Zs4lr2xD3bMTw/fw00KfwwIYm/VHgiUY0WBrueRe7JUKc3xfXcQTE/gRhdHtIGwbYwt1G2u4Mc7Hb9cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dv2hz9Y03yeKxqzARNQQsvRWotIgfk9YvGWgdtdNs48=;
 b=UI7IxvP8UsxVVxMdU1ncZXdA223dYS7FACNMytoyEQzksWp3YfHfzr56FvWoq+JgyGJgZegPsxpQ0i5UFx+dphx9BI0+XOHqPD0s0A0UEHe06J5a9Zh5vif44r8hIFB1H2RzntngufffjBFG4YNMX2nqLDFhEgbFlRgyhVIsQocuFaFIeLrjv8vgF8WWMbCHSQRjDXpDdw299JJPMI+i+i3GKrMx2razsjQaZLgsn+/ekqo9QW0tG27m9Gd8nHzY7kNgS95IqvueRb73tG4gD/aw8IrUk4596xz7oneanN3yG4yOS83ZKGsR66d70/povvs4Um65ciV0dWLvY739dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dv2hz9Y03yeKxqzARNQQsvRWotIgfk9YvGWgdtdNs48=;
 b=nzZ519AarC7G+wOxg3Uv1ilpdQIgbaNziOYlCBqvRqGBNgCciDOPyHJ1Efn8kHJ6I4Vrxbiige3YlMLfdQSnwReJ/c+PXxZuAS06BGwlPVoXAZ0H/cY15b3yCou1H0q7j7GfBLeX5ECu3ovAS+rR2yvWiiA7Bdr2qyOFAzIFqQg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8)
 by DM4PR12MB7694.namprd12.prod.outlook.com (2603:10b6:8:102::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 17:22:54 +0000
Received: from IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525]) by IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525%5]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 17:22:50 +0000
Message-ID: <cb289cab-f676-4d37-b62b-e931ab83b91c@amd.com>
Date: Wed, 17 Jun 2026 12:22:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdkfd: Unmap svm range when all GPUs set to
 no-access
To: "Kuehling, Felix" <felix.kuehling@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Harish.Kasiviswanathan@amd.com, Amir.Shetaia@amd.com, Kent.Russell@amd.com
References: <20260616211652.1962285-1-Philip.Yang@amd.com>
 <20260616211652.1962285-2-Philip.Yang@amd.com>
 <a0e9c13f-aea7-437a-8134-0bdf52b57aac@amd.com>
 <37555d80-f60b-4b59-b083-e3e47c55a063@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <37555d80-f60b-4b59-b083-e3e47c55a063@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P221CA0015.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::25) To IA1PR12MB8517.namprd12.prod.outlook.com
 (2603:10b6:208:449::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8517:EE_|DM4PR12MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: c448c1b4-c54b-43ca-7084-08decc950ee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|11063799006|56012099006|5023799004|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: tk55u5VGaG49pza9UttC/Vb9gF88h7k/zDzB6hGW6fU/t2Qz7o2i68z+TBKrUTJCWv0tLn/gU1O8UG+k61XRYdSwiC/okFt9qFbWP1Xw86u3cdnct9WTcottSNnlQ4An28LCW5+sABZids7suYvl7Cw7ftx3l9zNQ3eT+eXuRYxNoYBMhDYlNNrzHTXnWUBzEXMTggsceEnc2jGRvwejOJsdSH41/KeC6M87HkYdN/Mv8n59mW+zL1S8x4fDn3nSjaJI5gdIPEXiVcg4PEsf5G9pODrQ+y02BHbfQeLAKgh+dLfL1XgYKcZfb90adYb968Z/NBDDTJ3fLLT7lDmMdVt1KWxIAANgkKEDCOz4149e/oaVoWTbOnuacatdppjOqfKEwaVnlapu233JG9q97ovBmdXQKiz0Ul46UBmO9NhRT9hlzUTtUPrahlPOZe+Kw9sw/cBieV962Op/kqkgvJmSiVIbxSus2s/X4tSvvmYLeKyBz6LA3hKxHrqg1IRZhYDey+xsvZoKpIfAfb0vn4mald2ub8HyFl8ccDsUeKuxb4gWraVTsQ5oztbY6uij1V8O/ZnpfVbHBCtP6wFPLwnTaDAfNE6WzDqQKiXksP67uzXJHnSKG4F2odIe3LOahu0ZYcJWThCzQifucBqowzqe3yvonam+XzAoR75LLYo+Bk+y5+5ZqOeeEo6LD+KQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(11063799006)(56012099006)(5023799004)(4143699003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z25pUnNzcmptQS92ZysxemlaUGRSckxxSFI3UE5SdWFtc1ExUTVzTHJPaHlI?=
 =?utf-8?B?emw2ckdpb28yczVLN2xhN3FQSUNLS0lKdE9jbUJ6VDhqdVRZdW9FbmE4cTZy?=
 =?utf-8?B?eVphdDFsVUFWS2JtWk9ubTBmTkRxd21zeUhTRmJPbnV4bmZYZlJPNXVsemNS?=
 =?utf-8?B?eVFrY1p5QkpQYVB3UUdaNkZRc2h0QXN1UkJVYytSVVZiZU1PQVpldGJ2WTJR?=
 =?utf-8?B?RVJsbStFN1Q3RWdwWFA1OGJvWG1zcDFaRmlRZm5MUFI5ZXJVRjNwV3RZand1?=
 =?utf-8?B?OGowbnZOTXlsUS9HOVZZT09NTHRsRkdTTFNreTU3TFZKeHM3aldGWWpCRkI3?=
 =?utf-8?B?Tm5ZamFSa2xvbG1YTDdXbVdTbWJGZS9rTHpib2xMRnU2WUFzeFZGaCtJUWxE?=
 =?utf-8?B?NGt2a1RYWVFCelNEdkhIWVVLUlkwMkxLYVo0MFVkSFJpTUpnMUtRY0RUTTV2?=
 =?utf-8?B?N0dJNkIzbDNVaTViSFMwRmhhcXM5UUVlT1FaSEYyaXJBakhFKyt1cVhDckMy?=
 =?utf-8?B?aUVkbHh0a1RtVlNQVjB0VXIzTGFJbWNadVVXbmFHVEh3V1FFbllNbmlodEdS?=
 =?utf-8?B?WnZ1dXNENG9NSmdocUV5aDBrOGtEV2hydG5pUEEycm9ObjhNQ0NCOUVwVVd3?=
 =?utf-8?B?K1hxRm5GZkJ1dkVILytKSXZxYU55TVRVMXRmMXp2eDFvNDRvZU5scS9Mc3ZG?=
 =?utf-8?B?WXdXbnJXN3lkTHlaZnQzNlBlUGlpYitKYWRoMVNtTjJyWkdrL1NnYW9abTR5?=
 =?utf-8?B?KzJHbElqdlNNM0pYT00xN2h6YUJiQllna09sell6ZTgwUkRjUkpVQ2ZoYXlB?=
 =?utf-8?B?VzJYdC8xU2d1UkZhZDlzaFdFQWZNSU0xOWY5ejFwOHpYV09adDBuc1RjVEVG?=
 =?utf-8?B?KzhacTk2eVhFNnh2WHJya0ZyYmlVVVNGZGdHQmRwczFrMU9hZ0RMNXlOWlJC?=
 =?utf-8?B?eWhRZFN1cDVCRkF6S3MvTjQyclg3SWYwMzRoWnRnQUJSOVpabzROcjhhcW9N?=
 =?utf-8?B?V2d6UDZFK1lOazU1TjJKc0poekZOTU9pZStWYSs4M1Y5OWhPdTZJRkFZQUVt?=
 =?utf-8?B?amdRckdaTnFkZS8wUjhESGhHWGo1bFZUc2dhS3lPWVVkS3ZKLzhBVlY4RFJJ?=
 =?utf-8?B?LzA3S1k1MWYrYVZCdUJyNVdNYWZJUmY1a2kwcW56MDRRYXRDaUMvM2JqRVJw?=
 =?utf-8?B?OVgrSHBwVXYrdVp3TkZyY0J5TklId29rcDMxYTgzNDBqMlRtVDhCakgxejFj?=
 =?utf-8?B?YnFVTXRJTHhwblMxOUlCVHZ0RjhWWEs5N3pxYVlObUxlYTZOc00waHRGek1E?=
 =?utf-8?B?WmFEbWNkbkl3d3kwblU5cFhZcXVTRDBHQ2dsL1NpNkxqQmxlNmZiOFdVSHVH?=
 =?utf-8?B?d1hkR0Z6RGFQR1VWYldCVWp2S2o5SzROWXlhMUcvMmxnMTR0a25ZY2dHYWNl?=
 =?utf-8?B?TUdqSXZxaXV2VThyb0VidUNyUlRrakpGZlRXVWMvYTRzTG5SZWxPMVk0dEtY?=
 =?utf-8?B?YzV4T2k2bC91UDRZVWQvL0xyZUxaSGZEa2pnWXJvOUhlWk0wZWloZHY3OHhK?=
 =?utf-8?B?OXdsYjRma3NuS2hsQU9VQS9XTGkyV21KUnY3RVE1cHJLR2Jxc0E0RlBFR05l?=
 =?utf-8?B?QlZoOWZEeGl2T1luRGNYdG54Y1E0bXQ2dWI1Q2l2K1JCZUI1Z3ZGOUhQN21D?=
 =?utf-8?B?MjJwSHdacGszL3FTMkJVY3o4L1Y2ZDdoWHZOS2xTRktMRTd6amk5L0lVVnc3?=
 =?utf-8?B?amJMT3BjMXdndkgzODJKSUxraGM5SFd4aHA1V0RsY25vYmxCcFRWQW0vcXBX?=
 =?utf-8?B?UEp1eWdhRWFiWlI0Rm1mdFljY09ta1NrNndzckZCV3Q4S21tVFQ1UElDVStq?=
 =?utf-8?B?WFAydjFuU0FVdlViTEsvcnppVEsrdVptUlZ0eExqYlVnc2krVVViM1REaDBH?=
 =?utf-8?B?bHlKRTY5NnFuUFppaFlnZGIySS93NkVBbDFZZTNzb0ptZUhQYS9YTEg4WXJZ?=
 =?utf-8?B?blI3MHo2TzdiY09jaTFZZURZdDIzcUtqdUp0SkM3TWNBbkNKekd4Q1QxODZQ?=
 =?utf-8?B?R1RQSndCZ04rU0NtQUdxc3lJSVJVdE5XbjhVV3RVelBlSk9lTlk5Q2M1OCts?=
 =?utf-8?B?YUlrUlowUlJuMTNlTjU3ZWVPQ1dYMkRpYXd3ZEZRSlBHZm9CTDNLZmVmMytw?=
 =?utf-8?B?Qmtsb2lSNG5jMDRwZnJZSnRNOTg2eXpvUEo4di9aRW0rN0ozOXVMczZYWVZv?=
 =?utf-8?B?SnQ1VWFOUTM0bkt3WklZdmFQRUlxL01TeDJRaE1RSEVDNjQ3a3ZCZ1QvaC91?=
 =?utf-8?Q?L2SdT8tVMyNOLXmXRE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c448c1b4-c54b-43ca-7084-08decc950ee9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 17:22:50.7366 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ejHWjLQuq6C7kwKz0+OoGfWRhhpwuLCqCs1WxYpYZSJ7TE15wrb0T4a9cNFqHUiU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7694
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


On 6/17/2026 11:24 AM, Kuehling, Felix wrote:
>
> On 2026-06-17 12:15, Chen, Xiaogang wrote:
>>
>>
>> On 6/16/2026 4:16 PM, Philip Yang wrote:
>>> When KFD_IOCTL_SVM_ATTR_NO_ACCESS is applied to all GPUs that have an
>>> SVM range mapped, unmap the range so the MMU notifier can skip queue
>>> eviction — safe because no GPU will access it.
>>
>> KFD_IOCTL_SVM_ATTR_NO_ACCESS means shadder will not access this 
>> prange on a gpu. It does not mean driver needs unmap this prange.
>>
>> At MMU notifier stop queue or not should be decided by affected 
>> prange's access attributions:
>>
>> KFD_IOCTL_SVM_ATTR_ACCESS,
>> KFD_IOCTL_SVM_ATTR_ACCESS_IN_PLACE,
>> KFD_IOCTL_SVM_ATTR_NO_ACCESS,
>>
>> or
>>
>> bitmap_access/bitmap_aip.
>>
>> Current kfd uses mapping info to decide evict queue at MMU notifier. 
>> I think it is not right. Should use prange access attributions that 
>> are from user to decide whether stop queue on this gpu. If user has 
>> specified KFD_IOCTL_SVM_ATTR_NO_ACCESS on this prange and this gpu 
>> driver does not need stop queue on this gpu at  MMU notifier.
>>
> I strongly disagree with this. The kernel mode driver cannot trust 
> user mode. User mode could say "no access, I'm not accessing this any 
> more" and then access it anyway. In the MMU notifier, the kernel mode 
> driver must guarantee that the memory will no longer be accessed. It 
> either has to unmap it from the page table or stop the user mode 
> queue. There is no way around it.

In svm gpu vm is mirror of cpu vm. kfd driver unmap a gpu vm range when 
mmu notifier send MMU_NOTIFY_UNMAP, so gpu vm keep aligned with cpu vm.

If driver unmap a gpu vm range for KFD_IOCTL_SVM_ATTR_NO_ACCESS, then 
cpu side still has this vm range, but gpu vm has not, though user did 
not ask to unregister this range. The user mode may think this gpu vm 
range still mapped since it does not ask to unmap it. It just told 
driver there is no access to this range at present.

I do not know how to judge "The kernel mode driver cannot trust user 
mode". If shadder still access the vm range that user mode said "no 
access" to it is a user mode bug.

My concern is separating "no access" from unmap from gpu. I think they 
belong to different categories.

>
> Stopping user mode queues has a large performance overhead if done 
> frequently. So we are trying to minimize that by unmapping memory 
> that's no longer accessed. That's what this patch is about.

Queue stop can be avoided by kfd driver to check if there is 
KFD_IOCTL_SVM_ATTR_NO_ACCESS attribution on the prange at MMU notifier.


Regards

Xiaogang

>
> Regards,
>   Felix
>
>
>> This patch seems introducing unnecessary complications if the goal is 
>> to not stop queue at MMU notifier when KFD_IOCTL_SVM_ATTR_NO_ACCESS 
>> has been specified by user. Driver should use prange access 
>> attributions to decide queue eviction at MMU notifier.
>>
>> And access attributions can be dynamically changed. User component 
>> can change a prange from no_access to access(or access to no_access) 
>> at runtime, then driver has to remap the prange if it had been 
>> unmapped during no_access. In other words mapping is not exact 
>> equivalent to accessing.
>>
>> Regards
>>
>> Xiaogang
>>
>>
>>> Replace the mapped_to_gpu boolean with bitmap_mapped to track which
>>> GPUs currently have the range mapped. Set bits in 
>>> svm_range_map_to_gpus()
>>> and clear them in svm_range_unmap_from_gpus(). This is separate from
>>> bitmap_access/bitmap_aip which track user-requested attributes and must
>>> not be used to determine mapping state.
>>>
>>> Add bitmap_needs_unmap to svm_range, set when a GPU is given no-access.
>>> Add svm_range_needs_unmap() to trigger the unmap once 
>>> bitmap_needs_unmap
>>> equals bitmap_mapped, i.e. all mapped GPUs are set to no-access.
>>>
>>> v4:
>>>   - Rename and set prange->mapping_done to false if validate and map 
>>> not
>>>     complete successfully (Felix)
>>> v3:
>>>   - Correct error handling, support app retry update mapping (Felix)
>>> v2:
>>>   - Add bitmap_mapped to not break get_attr (Felix)
>>>
>>> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
>>> Reviewed-by: Felix Kuehling<felix.kuehling@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_queue.c |   5 +-
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 103 
>>> ++++++++++++++++---------
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h   |   7 +-
>>>   3 files changed, 73 insertions(+), 42 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>>> index 9d4838461168..5d55407069a4 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>>> @@ -111,12 +111,11 @@ static int kfd_queue_buffer_svm_get(struct 
>>> kfd_process_device *pdd, u64 addr, u6
>>>           if (!prange)
>>>               break;
>>>   -        if (!prange->mapped_to_gpu)
>>> -            break;
>>> -
>>>           r = kfd_process_gpuid_from_node(p, pdd->dev, &gpuid, 
>>> &gpuidx);
>>>           if (r < 0)
>>>               break;
>>> +        if (!test_bit(gpuidx, prange->bitmap_mapped))
>>> +            break;
>>>           if (!test_bit(gpuidx, prange->bitmap_access) &&
>>>               !test_bit(gpuidx, prange->bitmap_aip))
>>>               break;
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index df7fca65e9a2..e039b6f2942f 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -786,6 +786,7 @@ svm_range_apply_attrs(struct kfd_process *p, 
>>> struct svm_range *prange,
>>>               if (attrs[i].type == KFD_IOCTL_SVM_ATTR_NO_ACCESS) {
>>>                   bitmap_clear(prange->bitmap_access, gpuidx, 1);
>>>                   bitmap_clear(prange->bitmap_aip, gpuidx, 1);
>>> +                bitmap_set(prange->bitmap_needs_unmap, gpuidx, 1);
>>>               } else if (attrs[i].type == KFD_IOCTL_SVM_ATTR_ACCESS) {
>>>                   bitmap_set(prange->bitmap_access, gpuidx, 1);
>>>                   bitmap_clear(prange->bitmap_aip, gpuidx, 1);
>>> @@ -1076,9 +1077,10 @@ svm_range_split_adjust(struct svm_range *new, 
>>> struct svm_range *old,
>>>       new->prefetch_loc = old->prefetch_loc;
>>>       new->actual_loc = old->actual_loc;
>>>       new->granularity = old->granularity;
>>> -    new->mapped_to_gpu = old->mapped_to_gpu;
>>> +    new->mapping_done = old->mapping_done;
>>>       bitmap_copy(new->bitmap_access, old->bitmap_access, 
>>> MAX_GPU_INSTANCE);
>>>       bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
>>> +    bitmap_copy(new->bitmap_mapped, old->bitmap_mapped, 
>>> MAX_GPU_INSTANCE);
>>>       atomic_set(&new->queue_refcount, 
>>> atomic_read(&old->queue_refcount));
>>>         return 0;
>>> @@ -1379,7 +1381,8 @@ svm_range_unmap_from_gpu(struct amdgpu_device 
>>> *adev, struct amdgpu_vm *vm,
>>>     static int
>>>   svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long 
>>> start,
>>> -              unsigned long last, uint32_t trigger)
>>> +              unsigned long last, unsigned long *bitmap_unmap,
>>> +              uint32_t trigger)
>>>   {
>>>       struct kfd_process_device *pdd;
>>>       struct dma_fence *fence = NULL;
>>> @@ -1387,21 +1390,15 @@ svm_range_unmap_from_gpus(struct svm_range 
>>> *prange, unsigned long start,
>>>       uint32_t gpuidx;
>>>       int r = 0;
>>>   -    if (!prange->mapped_to_gpu) {
>>> -        pr_debug("prange 0x%p [0x%lx 0x%lx] not mapped to GPU\n",
>>> -             prange, prange->start, prange->last);
>>> -        return 0;
>>> -    }
>>> -
>>> -    if (prange->start == start && prange->last == last) {
>>> -        pr_debug("unmap svms 0x%p prange 0x%p\n", prange->svms, 
>>> prange);
>>> -        prange->mapped_to_gpu = false;
>>> -    }
>>> -
>>>       p = container_of(prange->svms, struct kfd_process, svms);
>>>   -    for_each_or_bit(gpuidx, prange->bitmap_access, 
>>> prange->bitmap_aip, MAX_GPU_INSTANCE) {
>>> -        pr_debug("unmap from gpu idx 0x%x\n", gpuidx);
>>> +    for_each_set_bit(gpuidx, bitmap_unmap, MAX_GPU_INSTANCE) {
>>> +        if (prange->start == start && prange->last == last) {
>>> +            pr_debug("unmap svms 0x%p prange 0x%p from gpu_idx 
>>> 0x%x\n",
>>> +                 prange->svms, prange, gpuidx);
>>> +            clear_bit(gpuidx, prange->bitmap_mapped);
>>> +        }
>>> +
>>>           pdd = kfd_process_device_from_gpuidx(p, gpuidx);
>>>           if (!pdd) {
>>>               pr_debug("failed to find device idx %d\n", gpuidx);
>>> @@ -1554,6 +1551,8 @@ svm_range_map_to_gpus(struct svm_range 
>>> *prange, unsigned long offset,
>>>               continue;
>>>           }
>>>   +        set_bit(gpuidx, prange->bitmap_mapped);
>>> +
>>>           r = svm_range_map_to_gpu(pdd, prange, offset, npages, 
>>> readonly,
>>>                        prange->dma_addr[gpuidx],
>>>                        bo_adev, wait ? &fence : NULL,
>>> @@ -1699,7 +1698,9 @@ static int svm_range_validate_and_map(struct 
>>> mm_struct *mm,
>>>           bitmap_zero(ctx->bitmap, MAX_GPU_INSTANCE);
>>>           bitmap_set(ctx->bitmap, gpuidx, 1);
>>>       } else if (ctx->process->xnack_enabled) {
>>> -        bitmap_copy(ctx->bitmap, prange->bitmap_aip, 
>>> MAX_GPU_INSTANCE);
>>> +        /* Update mapping on already mapped or access in place GPU */
>>> +        bitmap_or(ctx->bitmap, prange->bitmap_mapped, 
>>> prange->bitmap_aip,
>>> +              MAX_GPU_INSTANCE);
>>>             /* If prefetch range to GPU, or GPU retry fault migrate 
>>> range to
>>>            * GPU, which has ACCESS attribute to the range, create 
>>> mapping
>>> @@ -1719,14 +1720,12 @@ static int svm_range_validate_and_map(struct 
>>> mm_struct *mm,
>>>           }
>>>             /*
>>> -         * If prange is already mapped or with always mapped flag,
>>> -         * update mapping on GPUs with ACCESS attribute
>>> +         * If prange with always mapped flag, update mapping on 
>>> GPUs with
>>> +         * ACCESS attribute
>>>            */
>>> -        if (bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
>>> -            if (prange->mapped_to_gpu ||
>>> -                prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)
>>> -                bitmap_copy(ctx->bitmap, prange->bitmap_access, 
>>> MAX_GPU_INSTANCE);
>>> -        }
>>> +        if (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)
>>> +            bitmap_or(ctx->bitmap, ctx->bitmap, prange->bitmap_access,
>>> +                  MAX_GPU_INSTANCE);
>>>       } else {
>>>           bitmap_or(ctx->bitmap, prange->bitmap_access,
>>>                 prange->bitmap_aip, MAX_GPU_INSTANCE);
>>> @@ -1792,6 +1791,7 @@ static int svm_range_validate_and_map(struct 
>>> mm_struct *mm,
>>>                   e = min(end, prange->last);
>>>                   if (e >= s)
>>>                       r = svm_range_unmap_from_gpus(prange, s, e,
>>> +                               prange->bitmap_mapped,
>>> KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU);
>>>                   svm_range_unlock(prange);
>>>                   /* If unmap returns non-zero, we'll bail on the 
>>> next for loop
>>> @@ -1854,7 +1854,9 @@ static int svm_range_validate_and_map(struct 
>>> mm_struct *mm,
>>>           }
>>>             if (!r && next == end)
>>> -            prange->mapped_to_gpu = true;
>>> +            prange->mapping_done = true;
>>> +        else
>>> +            prange->mapping_done = false;
>>>             svm_range_unlock(prange);
>>>   @@ -2024,10 +2026,10 @@ svm_range_evict(struct svm_range *prange, 
>>> struct mm_struct *mm,
>>>       if (!p->xnack_enabled ||
>>>           (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) {
>>>           int evicted_ranges;
>>> -        bool mapped = prange->mapped_to_gpu;
>>> +        bool mapped = !bitmap_empty(prange->bitmap_mapped, 
>>> MAX_GPU_INSTANCE);
>>>             list_for_each_entry(pchild, &prange->child_list, 
>>> child_list) {
>>> -            if (!pchild->mapped_to_gpu)
>>> +            if (bitmap_empty(pchild->bitmap_mapped, MAX_GPU_INSTANCE))
>>>                   continue;
>>>               mapped = true;
>>>               mutex_lock_nested(&pchild->lock, 1);
>>> @@ -2076,13 +2078,14 @@ svm_range_evict(struct svm_range *prange, 
>>> struct mm_struct *mm,
>>>               s = max(start, pchild->start);
>>>               l = min(last, pchild->last);
>>>               if (l >= s)
>>> -                svm_range_unmap_from_gpus(pchild, s, l, trigger);
>>> +                svm_range_unmap_from_gpus(pchild, s, l, 
>>> prange->bitmap_mapped,
>>> +                              trigger);
>>>               mutex_unlock(&pchild->lock);
>>>           }
>>>           s = max(start, prange->start);
>>>           l = min(last, prange->last);
>>>           if (l >= s)
>>> -            svm_range_unmap_from_gpus(prange, s, l, trigger);
>>> +            svm_range_unmap_from_gpus(prange, s, l, 
>>> prange->bitmap_mapped, trigger);
>>>       }
>>>         return r;
>>> @@ -2112,10 +2115,11 @@ static struct svm_range 
>>> *svm_range_clone(struct svm_range *old)
>>>       new->prefetch_loc = old->prefetch_loc;
>>>       new->actual_loc = old->actual_loc;
>>>       new->granularity = old->granularity;
>>> -    new->mapped_to_gpu = old->mapped_to_gpu;
>>> +    new->mapping_done = old->mapping_done;
>>>       new->vram_pages = old->vram_pages;
>>>       bitmap_copy(new->bitmap_access, old->bitmap_access, 
>>> MAX_GPU_INSTANCE);
>>>       bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
>>> +    bitmap_copy(new->bitmap_mapped, old->bitmap_mapped, 
>>> MAX_GPU_INSTANCE);
>>>       atomic_set(&new->queue_refcount, 
>>> atomic_read(&old->queue_refcount));
>>>         return new;
>>> @@ -2235,7 +2239,7 @@ svm_range_add(struct kfd_process *p, uint64_t 
>>> start, uint64_t size,
>>>           next_start = min(node->last, last) + 1;
>>>             if (svm_range_is_same_attrs(p, prange, nattr, attrs) &&
>>> -            prange->mapped_to_gpu) {
>>> +            prange->mapping_done) {
>>>               /* nothing to do */
>>>           } else if (node->start < start || node->last > last) {
>>>               /* node intersects the update range and its attributes
>>> @@ -2616,14 +2620,14 @@ svm_range_unmap_from_cpu(struct mm_struct 
>>> *mm, struct svm_range *prange,
>>>           s = max(start, pchild->start);
>>>           l = min(last, pchild->last);
>>>           if (l >= s)
>>> -            svm_range_unmap_from_gpus(pchild, s, l, trigger);
>>> +            svm_range_unmap_from_gpus(pchild, s, l, 
>>> prange->bitmap_mapped, trigger);
>>>           svm_range_unmap_split(prange, pchild, start, last);
>>>           mutex_unlock(&pchild->lock);
>>>       }
>>>       s = max(start, prange->start);
>>>       l = min(last, prange->last);
>>>       if (l >= s)
>>> -        svm_range_unmap_from_gpus(prange, s, l, trigger);
>>> +        svm_range_unmap_from_gpus(prange, s, l, 
>>> prange->bitmap_mapped, trigger);
>>>       svm_range_unmap_split(prange, prange, start, last);
>>>         if (unmap_parent)
>>> @@ -3706,6 +3710,23 @@ static void 
>>> svm_range_evict_svm_bo_worker(struct work_struct *work)
>>>       svm_range_bo_unref(svm_bo);
>>>   }
>>>   +static bool svm_range_needs_unmap(struct kfd_process *p, struct 
>>> svm_range *prange)
>>> +{
>>> +    if (bitmap_empty(prange->bitmap_needs_unmap, MAX_GPU_INSTANCE))
>>> +        return false;
>>> +
>>> +    pr_debug("prange 0x%p no access set for [0x%lx 0x%lx]\n",
>>> +         prange, prange->start, prange->last);
>>> +
>>> +    svm_range_unmap_from_gpus(prange, prange->start,
>>> +                  prange->last, prange->bitmap_needs_unmap,
>>> +                  KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU);
>>> +
>>> +    bitmap_clear(prange->bitmap_needs_unmap, 0, MAX_GPU_INSTANCE);
>>> +
>>> +    return bitmap_empty(prange->bitmap_mapped, MAX_GPU_INSTANCE);
>>> +}
>>> +
>>>   static int
>>>   svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>>>              uint64_t start, uint64_t size, uint32_t nattr,
>>> @@ -3761,10 +3782,10 @@ svm_range_set_attr(struct kfd_process *p, 
>>> struct mm_struct *mm,
>>>           svm_range_add_to_svms(prange);
>>>           svm_range_add_notifier_locked(mm, prange);
>>>       }
>>> -    list_for_each_entry(prange, &update_list, update_list) {
>>> +
>>> +    list_for_each_entry(prange, &update_list, update_list)
>>>           svm_range_apply_attrs(p, prange, nattr, attrs, 
>>> &update_mapping);
>>> -        /* TODO: unmap ranges from GPU that lost access */
>>> -    }
>>> +
>>>       update_mapping |= !p->xnack_enabled && !list_empty(&remap_list);
>>>         list_for_each_entry_safe(prange, next, &remove_list, 
>>> update_list) {
>>> @@ -3785,6 +3806,9 @@ svm_range_set_attr(struct kfd_process *p, 
>>> struct mm_struct *mm,
>>>       list_for_each_entry(prange, &update_list, update_list) {
>>>           bool migrated;
>>>   +        if (svm_range_needs_unmap(p, prange))
>>> +            continue;
>>> +
>>>           mutex_lock(&prange->migrate_mutex);
>>>             r = svm_range_trigger_migration(mm, prange, &migrated);
>>> @@ -3793,7 +3817,7 @@ svm_range_set_attr(struct kfd_process *p, 
>>> struct mm_struct *mm,
>>>             if (migrated && (!p->xnack_enabled ||
>>>               (prange->flags & 
>>> KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) &&
>>> -            prange->mapped_to_gpu) {
>>> +            !bitmap_empty(prange->bitmap_mapped, MAX_GPU_INSTANCE)) {
>>>               pr_debug("restore_work will update mappings of GPUs\n");
>>>               mutex_unlock(&prange->migrate_mutex);
>>>               continue;
>>> @@ -3804,7 +3828,8 @@ svm_range_set_attr(struct kfd_process *p, 
>>> struct mm_struct *mm,
>>>               continue;
>>>           }
>>>   -        flush_tlb = !migrated && update_mapping && 
>>> prange->mapped_to_gpu;
>>> +        flush_tlb = !migrated && update_mapping &&
>>> +                !bitmap_empty(prange->bitmap_mapped, 
>>> MAX_GPU_INSTANCE);
>>>             r = svm_range_validate_and_map(mm, prange->start, 
>>> prange->last, prange,
>>>                              MAX_GPU_INSTANCE, true, true, flush_tlb);
>>> @@ -3818,11 +3843,13 @@ svm_range_set_attr(struct kfd_process *p, 
>>> struct mm_struct *mm,
>>>       }
>>>         list_for_each_entry(prange, &remap_list, update_list) {
>>> +        flush_tlb = !bitmap_empty(prange->bitmap_mapped, 
>>> MAX_GPU_INSTANCE);
>>> +
>>>           pr_debug("Remapping prange 0x%p [0x%lx 0x%lx]\n",
>>>                prange, prange->start, prange->last);
>>>           mutex_lock(&prange->migrate_mutex);
>>>           r = svm_range_validate_and_map(mm, prange->start, 
>>> prange->last, prange,
>>> -                           MAX_GPU_INSTANCE, true, true, 
>>> prange->mapped_to_gpu);
>>> +                           MAX_GPU_INSTANCE, true, true, flush_tlb);
>>>           if (r)
>>>               pr_debug("failed %d on remap svm range\n", r);
>>>           mutex_unlock(&prange->migrate_mutex);
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>> index a63dfc95b602..0da635532aff 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>> @@ -100,6 +100,9 @@ struct svm_work_list_item {
>>>    * @child_list: list header for split ranges which are not added 
>>> to svms yet
>>>    * @bitmap_access: index bitmap of GPUs which can access the range
>>>    * @bitmap_aip: index bitmap of GPUs which can access the range in 
>>> place
>>> + * @bitmap_needs_unmap: index bitmap of GPUs which currently set 
>>> NO_ACCESS
>>> + * @bitmap_mapped: index bitmap of GPUs which currently have the 
>>> range mapped
>>> + * @mapping_done: true if range_validate_and_map complete successfully
>>>    *
>>>    * Data structure for virtual memory range shared by CPU and GPUs, 
>>> it can be
>>>    * allocated from system memory ram or device vram, and migrate 
>>> from ram to vram
>>> @@ -135,7 +138,9 @@ struct svm_range {
>>>       struct list_head        child_list;
>>>       DECLARE_BITMAP(bitmap_access, MAX_GPU_INSTANCE);
>>>       DECLARE_BITMAP(bitmap_aip, MAX_GPU_INSTANCE);
>>> -    bool                mapped_to_gpu;
>>> +    DECLARE_BITMAP(bitmap_needs_unmap, MAX_GPU_INSTANCE);
>>> +    DECLARE_BITMAP(bitmap_mapped, MAX_GPU_INSTANCE);
>>> +    bool                mapping_done;
>>>       atomic_t            queue_refcount;
>>>   };
