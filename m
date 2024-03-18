Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39642C54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 15:22:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C85BB10E08B;
	Mon, 18 Mar 2024 15:22:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W4C9+RVF";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E74E10E08B
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 15:22:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elwDT5pzlVr9Bo7X/6f2MYrKvK5p/0JLfCIo4gXDA0X1zvLpjltVKUft2WQ8/eg1DGQH5nIKjHWDB6l+/+Kumm8ZwoZXiKMOYHKkR7q2SYYXGC2puimKWH27yjpdCl8ZUYrU5IhkTVkYmeYtR/FXGQu200G68HyrNsjYFe/HTj9z8njBX8WrXvfAe57YO8GNhv+R+TaqS4At10PRHxS3sdmep/Tg+vbQOcYoQIWRmdhiGFEfaMqKtovrqbkwDmwzz2CmnV6/p9jA1aMgT3GEnmTlOjcHpNXpmAHWsnDETchNcW/uprhn9UzZsESDn0EKj+tqKjmi86vW5Yn6bBJteA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VtSiarrW6Y2rFucMc9X4aTsqq3gCSxFB2xgo9gqUlgs=;
 b=JqhZZmpZP/XOq4Mv71FGoHi8+sZgt+AcBMnKlmh0Ru2Dut74McjA+gwtsAQpfM+j6yOgeF0+Dd/wfROXsgE2aTXXKeaKlBdyuRky7xcSGwJAgt9ITcglpEel/noEi4h6r7GuqJWIvqXw++zZ1snfLBLNMgaRibAWnth8tJ9ESpxeYeBX28JxRklMdLNoIOZDQTmVLzOHq1YigO6krpWd2TuWO52GE65sTNgOTR7rf4IGIvXo99b+c9DNpbPYiBtSyxdMWrVOLrv3yMauH9o7/K66wiNl/n6a2Pme+Hk8kNClxSVGjiR0X56F/yVx4QWJb7Ui4LnQSVITXA3RJi4t6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtSiarrW6Y2rFucMc9X4aTsqq3gCSxFB2xgo9gqUlgs=;
 b=W4C9+RVFS+4/b+RapFwKQ59cuffdpTpez6BEArf8ozfuRtunfeanWHoOQqcVC3F3ZGqWqMO/ZtYlqb6fFefeKZ7KZigKeYWi9oMQ7Q9VSWo3/xKQnN27uaEjwyc1onSzbrDuNiUEVQ9LMAirNBVwJM8uG/GYwObgHbN5IqF5YHA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by BY5PR12MB4193.namprd12.prod.outlook.com (2603:10b6:a03:20c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 15:22:28 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b%5]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 15:22:28 +0000
Message-ID: <9c9e9efe-56bb-d7dd-3b73-7d3150a7c215@amd.com>
Date: Mon, 18 Mar 2024 16:22:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v8] drm/amdgpu: sync page table freeing with tlb flush
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
References: <7caeb5ca-4164-4d4d-bfd9-147abcbf105d@amd.com>
 <20240318144412.2051-1-shashank.sharma@amd.com>
 <cc76d0a2-90e3-420e-9521-f64a75863c25@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <cc76d0a2-90e3-420e-9521-f64a75863c25@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0222.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::18) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|BY5PR12MB4193:EE_
X-MS-Office365-Filtering-Correlation-Id: 687fcf48-62e0-4a93-58b6-08dc475f389c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F0ODMfEMPM+UV8a5u34yioWKEP5PGWZYe7BOERKvu2C3rFMtMJojsTbFBplHKRXCATYXaraFm+y9uqY0vnoOytMtEV5dZy6PJfbsk+XoqDc7Bk9zLUCuz/3PhRSfrMKlBxhMHn9NJHAOT+ODIHXn262Umy8p/smhIzur5WdXzx6pfpCLfBr+sc/qygJm03UD8a/SnA0KjdXwRgVcE/xjnNWwLhAfhw1Sulk7FNZSNQY6nmxsVPGSLzfWvW1mT8XUxiOp96az1k8fmFtqT3gBuGaUymRhGAQuxNJiUuUd9DGXvxyLzXBGyqsyr08olQ7p8YAPcs1XEwCbfnIWhBHp6nmB4PzUL9XCxjpDMtqNt3hP6Cf/klz8nhqy0P0Hf8xPZ8Z+i4g7bRXpkfSpV5wdoxdn661Vee4XpNFKR78vdFFNKL3YzgvfTl1XI0gebuaqHoFItERsuVYs5wTOpqxyCiBalrZIoJAt0yNTx2+iYAMRtPWyp0rkYqHOH8KvjA1yh3JCId7K1hRhzX3LqWixeyMxuEv7V1jGEG72YOeiCytnKVLJ6yx7wrmxSQjhM9EkV1GUTEZ5sjQTarOU7bTO7ABPhOReuqYw4VQGKxI5zaOkhHPLLdPiG1XaJJxoZbQ7EKc3kpv6sHD1MY1SpT72ds7MnqKuj33IQd1efs9WD9Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1lmR3gyN3o5QjNGMER2RjlRREh5a3ZraFl6WUYzajNBYkVsUjZwdHRSd1Yx?=
 =?utf-8?B?TWJiUTJLeDVPbVRBWHNIYWExamhMZVQ5QnR1OTNNakp4bXhlNkhibDJoMGhX?=
 =?utf-8?B?Qk03bUZtTW92NW54T1VmZ3A1YlhteUpDeEtPVE41WnhCMnR4bGtWRFVaRXdV?=
 =?utf-8?B?ZHJNSkFITHNjUjkrbVZaNDdvdUU5NDZhNFBaQWlPOXNZVVY4QnFWbUxKUmpZ?=
 =?utf-8?B?SUt2eUwxQlF0NFR2UjZabWEycnBKWTJuZFpaWjc0bEE3QWhyYTBTOWNzUWFp?=
 =?utf-8?B?b2xvSm1iR1ZUdmxhNFg2K3ZNYzl6Y2U3TkM5dzBrYVlzNElmYmlYY1g5eGdY?=
 =?utf-8?B?Z3A4VnNSc1RWakwwQ0xLeEdOS0RKM3FKd3FiSWJiakZrVUFkSkhiZHRXOFFZ?=
 =?utf-8?B?RkxLRlR5ZXQ5eG5MQ2I2aXdmWmhWcHpPTVJCR1V4VGdlM0RFVzFDMVp5SDBE?=
 =?utf-8?B?elZmcFo1ZDBpMWhCVWczRDVyWSt3ZDM1a054Ym1hWmMwczNzU3NxWnhSQ3VC?=
 =?utf-8?B?UmZ4d3pZSG5kenBrSDdqM3JPdWNrMGZ3KzNkTXdpc0o4UWhPS0I2UmpvYzVF?=
 =?utf-8?B?VkFFVXk1WHQ5ZDl6MEZYaGtpSDVhYUh2a1JZU0paNC9XSSs5bkRkQzZVeDNk?=
 =?utf-8?B?OCtEZ1NvV1o4OTBTRThCSkZBWlppOGJDUXBZS21HMG1oQkFxRXN2SmxxdjhZ?=
 =?utf-8?B?MFVpVVVPWm9PUEVqMmRla25pMDl2QWtnRE1DMFk3K3QxR25FdEY2YldwTWc5?=
 =?utf-8?B?UmN2RG5TOEpmQXIxeDNwM3FuQ0M2OVdxcy84TWh5RmlFWGc2UkZXejh6VGdr?=
 =?utf-8?B?YUR1Q2pkMGhCZUIyL0NSRmY3WGl1TVNLRmtBKzVrTU9Sd21SVkRYalpUOERL?=
 =?utf-8?B?SWdzNzBsTWtlSUc3bCtrYit2RVB0U2FkQUt6WDZHaXM4SFRJb0ZidU1tL0h5?=
 =?utf-8?B?ZjZlMzFZSmZpK2JQSWZLTXdobkFUR3l3aFJiY25HSUp3dy9kaDJ5UmFkVlRR?=
 =?utf-8?B?YWlxdncwckdxQ3g1S3JWN2FGL3hDN1VaQ1ZVUlRIWDRWU3BWd2kxWmVMKy90?=
 =?utf-8?B?Rk94K2xNRXNlNEdiSXhGTm5CQW5hVGJrb1pzOEhYUWtnVWF2SklSVWVzZUFC?=
 =?utf-8?B?Zk9tUGx1V3FhUVBoMlY1MVB6dVNyREhmVzJZRlpGNDB5OGNBaXhMdnhxR0Vs?=
 =?utf-8?B?QlJEQm11K1NZaTE0WFlWLzlpY0xIRnhtQVh0anNzU0p1bmNDeGR3cU4remdQ?=
 =?utf-8?B?SVEzRFdnY1NWNEtnRVdKK1FPU3VqamRmYTBaS3BkWVZkZnJxOUtrOG5nTUZj?=
 =?utf-8?B?YUpuSXdHMnM5VlFVbDZZc2h2cTRna1REQWJGdVpybVhOSGJOSU42alZVd0Fu?=
 =?utf-8?B?RWM1cGgrL0paakZZTmtQend5S1UxemxQcHNrNytwQUlZZXpMZ1B0QktoOHFt?=
 =?utf-8?B?ZnQwUGo5QUt6NnV1MGdNN3U5R1ZKZXNWbm9sczVOR2xaZXpkdnJ4VmJRN2pH?=
 =?utf-8?B?UHZNQW4vNlhJaDhmMzRwUFhjR2JNYUovQWhPWXVERG4wVVNyeUNuRWxwQ091?=
 =?utf-8?B?TkdRZ2YvWGhJY3pRalh2WCtXL1RuekhaVGU4NGVpNThTVWZGYmdiNlJWTlh4?=
 =?utf-8?B?cWdHanQwNUU0K3lsTElpNnFYM1hOZnlwcm5MVWw0NXY0ekdVN013b1ZUNFpR?=
 =?utf-8?B?OXByaU9UaGU4bGpjd0xyRHVTempiK3dGV0RwVUozTE9yRWtkV3VtZmlXb2ZX?=
 =?utf-8?B?OXRmb05PZWJRalg0YWxWWUNyYmRCbDZHQUxJbDNsWVpoeHUzWUFnbmRhd2RS?=
 =?utf-8?B?c2tycHhUeHlYWm52TjJFSXN5MHAyMjhMa0xCbjRSQ2RYb01MV2hsODFpSnUy?=
 =?utf-8?B?SUNVeUpiVUhXbG1ZSm81NUZiZlFZOUVXeTNYM1lsSlB1dklTK0o1VkFNa3FX?=
 =?utf-8?B?WEYrOHNrRVNkeFBUUVNreEViTHJBRml0akh1MGtnTDZsZnAxaEdQYVBTMkFp?=
 =?utf-8?B?S3RQVy9ya3BEMDU3Qm5MWlZ5L00vNHNVaG44R05LNlQxeFV1U2hoR3VDN2Fz?=
 =?utf-8?B?ZVdLSHZtMnUvQUNZekZNOGVXQnE1SnFUcThEd25BNFJYTExOWC9TZzYzZlBL?=
 =?utf-8?Q?mNpXWbLJV9wnJ0HFrKi5C8DeP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 687fcf48-62e0-4a93-58b6-08dc475f389c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 15:22:27.9586 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WZplY4Cf9/OeYIKSoqY+P/uyt5N8YWoRIzolX0pK5pISdbAbipE+xeRlQLaBjUGZkUkq0A0+P/qZzrBHTo/EfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4193
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


On 18/03/2024 16:01, Christian König wrote:
> Am 18.03.24 um 15:44 schrieb Shashank Sharma:
>> The idea behind this patch is to delay the freeing of PT entry objects
>> until the TLB flush is done.
>>
>> This patch:
>> - Adds a tlb_flush_waitlist in amdgpu_vm_update_params which will 
>> keep the
>>    objects that need to be freed after tlb_flush.
>> - Adds PT entries in this list in amdgpu_vm_ptes_update after finding
>>    the PT entry.
>> - Changes functionality of amdgpu_vm_pt_free_dfs from (df_search + free)
>>    to simply freeing of the BOs, also renames it to
>>    amdgpu_vm_pt_free_list to reflect this same.
>> - Exports function amdgpu_vm_pt_free_list to be called directly.
>> - Calls amdgpu_vm_pt_free_list directly from amdgpu_vm_update_range.
>>
>> V2: rebase
>> V4: Addressed review comments from Christian
>>      - add only locked PTEs entries in TLB flush waitlist.
>>      - do not create a separate function for list flush.
>>      - do not create a new lock for TLB flush.
>>      - there is no need to wait on tlb_flush_fence exclusively.
>>
>> V5: Addressed review comments from Christian
>>      - change the amdgpu_vm_pt_free_dfs's functionality to simple 
>> freeing
>>        of the objects and rename it.
>>      - add all the PTE objects in params->tlb_flush_waitlist
>>      - let amdgpu_vm_pt_free_root handle the freeing of BOs 
>> independently
>>      - call amdgpu_vm_pt_free_list directly
>>
>> V6: Rebase
>> V7: Rebase
>> V8: Added a NULL check to fix this backtrace issue:
>> [  415.351447] BUG: kernel NULL pointer dereference, address: 
>> 0000000000000008
>> [  415.359245] #PF: supervisor write access in kernel mode
>> [  415.365081] #PF: error_code(0x0002) - not-present page
>> [  415.370817] PGD 101259067 P4D 101259067 PUD 10125a067 PMD 0
>> [  415.377140] Oops: 0002 [#1] PREEMPT SMP NOPTI
>> [  415.382004] CPU: 0 PID: 25481 Comm: test_with_MPI.e Tainted: 
>> G           OE     5.18.2-mi300-build-140423-ubuntu-22.04+ #24
>> [  415.394437] Hardware name: AMD Corporation Sh51p/Sh51p, BIOS 
>> RMO1001AS 02/21/2024
>> [  415.402797] RIP: 0010:amdgpu_vm_ptes_update+0x6fd/0xa10 [amdgpu]
>> [  415.409648] Code: 4c 89 ff 4d 8d 66 30 e8 f1 ed ff ff 48 85 db 74 
>> 42 48 39 5d a0 74 40 48 8b 53 20 48 8b 4b 18 48 8d 43 18 48 8d 75 b0 
>> 4c 89 ff <48
>>> 89 51 08 48 89 0a 49 8b 56 30 48 89 42 08 48 89 53 18 4c 89 63
>> [  415.430621] RSP: 0018:ffffc9000401f990 EFLAGS: 00010287
>> [  415.436456] RAX: ffff888147bb82f0 RBX: ffff888147bb82d8 RCX: 
>> 0000000000000000
>> [  415.444426] RDX: 0000000000000000 RSI: ffffc9000401fa30 RDI: 
>> ffff888161f80000
>> [  415.452397] RBP: ffffc9000401fa80 R08: 0000000000000000 R09: 
>> ffffc9000401fa00
>> [  415.460368] R10: 00000007f0cc0000 R11: 00000007f0c85000 R12: 
>> ffffc9000401fb20
>> [  415.468340] R13: 00000007f0d00000 R14: ffffc9000401faf0 R15: 
>> ffff888161f80000
>> [  415.476312] FS:  00007f132ff89840(0000) GS:ffff889f87c00000(0000) 
>> knlGS:0000000000000000
>> [  415.485350] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  415.491767] CR2: 0000000000000008 CR3: 0000000161d46003 CR4: 
>> 0000000000770ef0
>> [  415.499738] PKRU: 55555554
>> [  415.502750] Call Trace:
>> [  415.505482]  <TASK>
>> [  415.507825]  amdgpu_vm_update_range+0x32a/0x880 [amdgpu]
>> [  415.513869]  amdgpu_vm_clear_freed+0x117/0x250 [amdgpu]
>> [  415.519814] amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu+0x18c/0x250 
>> [amdgpu]
>> [  415.527729]  kfd_ioctl_unmap_memory_from_gpu+0xed/0x340 [amdgpu]
>> [  415.534551]  kfd_ioctl+0x3b6/0x510 [amdgpu]
>>
>> Cc: Christian König <Christian.Koenig@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Felix Kuehling <felix.kuehling@amd.com>
>> Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>> Acked-by: Felix Kuehling <felix.kuehling@amd.com>
>> Acked-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>> Tested-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  5 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  7 +++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 58 +++++++++++++----------
>>   3 files changed, 45 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 26f1c3359642..eaa402f99fe0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -977,6 +977,7 @@ int amdgpu_vm_update_range(struct amdgpu_device 
>> *adev, struct amdgpu_vm *vm,
>>       params.unlocked = unlocked;
>>       params.needs_flush = flush_tlb;
>>       params.allow_override = allow_override;
>> +    INIT_LIST_HEAD(&params.tlb_flush_waitlist);
>>         /* Implicitly sync to command submissions in the same VM before
>>        * unmapping. Sync to moving fences before mapping.
>> @@ -1062,8 +1063,10 @@ int amdgpu_vm_update_range(struct 
>> amdgpu_device *adev, struct amdgpu_vm *vm,
>>       if (r)
>>           goto error_unlock;
>>   -    if (params.needs_flush)
>> +    if (params.needs_flush) {
>>           r = amdgpu_vm_tlb_flush(&params, fence);
>> +        amdgpu_vm_pt_free_list(adev, &params);
>
> This is completed independent of the VM flush and should always be 
> called.
>
>> +    }
>>     error_unlock:
>>       amdgpu_vm_eviction_unlock(vm);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index b0a4fe683352..54d7da396de0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -266,6 +266,11 @@ struct amdgpu_vm_update_params {
>>        * to be overridden for NUMA local memory.
>>        */
>>       bool allow_override;
>> +
>> +    /**
>> +     * @tlb_flush_waitlist: temporary storage for BOs until tlb_flush
>> +     */
>> +    struct list_head tlb_flush_waitlist;
>>   };
>>     struct amdgpu_vm_update_funcs {
>> @@ -547,6 +552,8 @@ int amdgpu_vm_ptes_update(struct 
>> amdgpu_vm_update_params *params,
>>                 uint64_t start, uint64_t end,
>>                 uint64_t dst, uint64_t flags);
>>   void amdgpu_vm_pt_free_work(struct work_struct *work);
>> +void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
>> +                struct amdgpu_vm_update_params *params);
>>     #if defined(CONFIG_DEBUG_FS)
>>   void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct 
>> seq_file *m);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> index 601df0ce8290..9231edfb427e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> @@ -622,40 +622,30 @@ void amdgpu_vm_pt_free_work(struct work_struct 
>> *work)
>>   }
>>     /**
>> - * amdgpu_vm_pt_free_dfs - free PD/PT levels
>> + * amdgpu_vm_pt_free_list - free PD/PT levels
>>    *
>>    * @adev: amdgpu device structure
>> - * @vm: amdgpu vm structure
>> - * @start: optional cursor where to start freeing PDs/PTs
>> - * @unlocked: vm resv unlock status
>> + * @params: see amdgpu_vm_update_params definition
>>    *
>> - * Free the page directory or page table level and all sub levels.
>> + * Free the page directory objects saved in the flush list
>>    */
>> -static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
>> -                  struct amdgpu_vm *vm,
>> -                  struct amdgpu_vm_pt_cursor *start,
>> -                  bool unlocked)
>> +void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
>> +                struct amdgpu_vm_update_params *params)
>>   {
>> -    struct amdgpu_vm_pt_cursor cursor;
>> -    struct amdgpu_vm_bo_base *entry;
>> +    struct amdgpu_vm_bo_base *entry, *next;
>> +    struct amdgpu_vm *vm = params->vm;
>> +    bool unlocked = params->unlocked;
>>         if (unlocked) {
>>           spin_lock(&vm->status_lock);
>> -        for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
>> -            list_move(&entry->vm_status, &vm->pt_freed);
>> -
>> -        if (start)
>> -            list_move(&start->entry->vm_status, &vm->pt_freed);
>> +        list_splice_init(&vm->pt_freed, &params->tlb_flush_waitlist);
>>           spin_unlock(&vm->status_lock);
>>           schedule_work(&vm->pt_free_work);
>>           return;
>>       }
>>   -    for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
>> +    list_for_each_entry_safe(entry, next, 
>> &params->tlb_flush_waitlist, vm_status)
>>           amdgpu_vm_pt_free(entry);
>> -
>> -    if (start)
>> -        amdgpu_vm_pt_free(start->entry);
>>   }
>>     /**
>> @@ -667,7 +657,13 @@ static void amdgpu_vm_pt_free_dfs(struct 
>> amdgpu_device *adev,
>>    */
>>   void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct 
>> amdgpu_vm *vm)
>>   {
>> -    amdgpu_vm_pt_free_dfs(adev, vm, NULL, false);
>> +    struct amdgpu_vm_pt_cursor cursor;
>> +    struct amdgpu_vm_bo_base *entry;
>> +
>> +    for_each_amdgpu_vm_pt_dfs_safe(adev, vm, NULL, cursor, entry) {
>> +        if (entry)
>
> Entry can't be NULL here I think.
Yeah, makes sense, if there is a GPU process, it will have at-least one 
page table entry.
>
>> +            amdgpu_vm_pt_free(entry);
>> +    }
>>   }
>>     /**
>> @@ -972,10 +968,24 @@ int amdgpu_vm_ptes_update(struct 
>> amdgpu_vm_update_params *params,
>>               while (cursor.pfn < frag_start) {
>>                   /* Make sure previous mapping is freed */
>>                   if (cursor.entry->bo) {
>> +                    struct amdgpu_vm_pt_cursor seek;
>> +                    struct amdgpu_vm_bo_base *entry;
>> +
>>                       params->needs_flush = true;
>> -                    amdgpu_vm_pt_free_dfs(adev, params->vm,
>> -                                  &cursor,
>> -                                  params->unlocked);
>> + spin_lock(&params->vm->status_lock);
>> +                    for_each_amdgpu_vm_pt_dfs_safe(adev, params->vm, 
>> &cursor,
>> +                                       seek, entry) {
>> +                        if (!entry || !entry->bo)
>> +                            continue;
>> +
>> +                        list_move(&entry->vm_status,
>> + &params->tlb_flush_waitlist);
>> +                    }
>> +
>> +                    /* enter start node now */
>> +                    list_move(&cursor.entry->vm_status,
>> +                          &params->tlb_flush_waitlist);
>> + spin_unlock(&params->vm->status_lock);
>
> I would put this into a separate function maybe.

Noted,

- Shashank

>
> Apart from those nit-picks looks good to me.
>
> Regards,
> Christian.
>
>>                   }
>>                   amdgpu_vm_pt_next(adev, &cursor);
>>               }
>
