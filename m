Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAAD9C54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 15:24:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4781810FA0A;
	Mon, 18 Mar 2024 15:24:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K3uKfIMO";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58C7310FAA5
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 15:24:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJJemROdr6YW5+24sIPZhJbrEDq/AoAUEXazX7+puYaVbHIuVeG66Zm2yqN7zIi9UqJxYBu+/OsUNkGjSOnfs+t0QDh3mZgzCiXMyr1iH7HRAcr2rLek4SZxAb1wZ5Z1rRkMe5zxS+EV1slHomYq73WlQbkgwVSeu5VuFJF/zd+JWl3jdx916nTkWjWbp4BSFBfXspHcvOhY2Nww9VJlUomvqtwnv7B0vrPHn1mRpEBvCX4K98SkYkoi50XRIMTxys1tYb5LhA1fR+OR4rdSU4bj4u2g9hZiC3RNrRZtxIsOCL+Do5CL97EA7Nb/tfOF3bkjwKe0BGIFE6ySARonBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpXvMalcnXsnZ/YrHUcxGxd0qPxZ0PmbaMP0C5ThkRg=;
 b=DbYWDY/1HMNRpl9+JnJQVPgNFEIx/PsrCXC1GnBv40rnuFNye98Ca0Vcb4pD4fhW3zCpv7h5BqdqTO4fQseDXy7lc0XqpLpJvXGZMumrB0qrzIfwrEFxUcP+d3UGN45bKf1Dsikz6girUx6RoYKlsjEa5nSC0fqGBTrySnAlqxSTBL33tVRxCTc95A4VfxxXhLIPxPU/X9Vs0bo+Q51RTg7lCXD7Uo4wsAxXDuBZHIfBjYBYos0jHaytFP4hun54ossou4w5lItqgB0P4kjhIkIcSxOQpWv4upwUFH+0lrg4k2682TA+lxXvSkfBZJL/lyvDxIptRChxPgGu0pFQ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpXvMalcnXsnZ/YrHUcxGxd0qPxZ0PmbaMP0C5ThkRg=;
 b=K3uKfIMO10F5sjutSE1cURzNNJK9y1+e6RzJTvMfhIoVEmI6bf39y/buyldBYmZ6VNv8B3Dlj3usvi9J0pWlQ6mXYobUWwwENVYV6K1LqjmvNmA5PawWk2YU0t2uzj7Ubu24DXlXnhiyuWrMXiF/wODgAsBugzHZAX0lS0rvWu0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA0PR12MB4446.namprd12.prod.outlook.com (2603:10b6:806:71::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 15:24:53 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7386.023; Mon, 18 Mar 2024
 15:24:52 +0000
Message-ID: <c85e5897-66cf-46b8-aa8f-c208c4a6c68a@amd.com>
Date: Mon, 18 Mar 2024 16:24:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] drm/amdgpu: sync page table freeing with tlb flush
Content-Language: en-US
To: "Sharma, Shashank" <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
References: <7caeb5ca-4164-4d4d-bfd9-147abcbf105d@amd.com>
 <20240318144412.2051-1-shashank.sharma@amd.com>
 <cc76d0a2-90e3-420e-9521-f64a75863c25@amd.com>
 <9c9e9efe-56bb-d7dd-3b73-7d3150a7c215@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <9c9e9efe-56bb-d7dd-3b73-7d3150a7c215@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0190.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA0PR12MB4446:EE_
X-MS-Office365-Filtering-Correlation-Id: 061d3903-17ae-4939-504c-08dc475f8ead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r9J6SZXuYhqm72/uukpaNgBzI0bsdKgUOysOYJ9kPMRXMWM4/V/pP5qzwOKWZMXTdNakZDTS2Z2SSFhyIUabx8z5CY5Y+SH6LzOUsXCpeX3G2mBVnho9zZNcr5LzZ+Bi/FFsr/gkfezAw3ZQIIRq6+w21q78MC4dhTijQHO1ZnKyxVCfZOKddfL5T1H+3HWlwxWYectoP1yipBjLZqhN4jUzSL7sPr6aZS3A4DLAczDgRCEaGUTE++IR6kt5d/filtJZruoqj+IDWWwmzEH1aLRkY2YJzsZXNi1QdR8xyVHIngnTYn8cdqsnqN4dV5gFtMJEYKCPLcbLnReWlS6k5KYx9LW/8uD0bxq/5oM4eRBuF2lpm4HTSWbyeMZOsHRDmzKXICpQTujUqusZHXjBfCizFxROdAYOp3wRKABaLWg+26WUv6yl2VsCi7TcsVUjoX/SWBnzF7QA+SWeNLtVRwp9GQ77WGHOCeGnX5WKOjibg2+qrmMl35m9W2pcW2XrOumX8JfauwebeopX1NoipehpHufK8gXoX4CS3SxLwHfo/tjo2UunbghQi93yI5yGegVu7WsCdRmvIiVHKCkHylLsdLqOTwZQEJguCVDARFjy50Y382DChoH7361eNViIDlGyALBI2PDICiOk4kFW5QaVPTv3/NyTIi8Xeec9a0A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnNyNU5URWc3Q3ZodFhjQmR0aTlPSHp2Mkx0MUlSeHdOcXdXZEdTMmx2d0o1?=
 =?utf-8?B?VFU5Q2pPcitlNzRYMGVJUndUVDRVMXBLTDU1MHNiRDNwV0FKakl3aFNLZ0s3?=
 =?utf-8?B?YTF2cHMxaWlBRHFFaGJ2OVd0NXEySkthOHN1SUxuenY0MzhvcVJSZ3p3ejlS?=
 =?utf-8?B?VE5reHZPU2xOM0NUMEhuN25QbFB6MmJqODZ2U2x0U04vWGJ2RnBxd09PNzJP?=
 =?utf-8?B?M2ZxbERkVU5YejgxQ2c3Znd5MVMwdkZQUzdwbTgyeVRqa3VwU1dZV1ZEU2c3?=
 =?utf-8?B?VS91NDZzNmt4MnVUWC9ZT1UyczcyeDRDMHhKc0pqMTBBOVhhcGljYjFMcTA0?=
 =?utf-8?B?VXhwd1g4MUUyM05Wbnlwa2VNQWNuNnMyaU1qeHV6dTJyVlFqSXNqMFZFQkFH?=
 =?utf-8?B?RElUREl1YlErNmI5dTFzVmgzRFZjUnpMMUtnWS9OVk9sQ0NiczQwOE5pdVNz?=
 =?utf-8?B?dmZPWFIvTlhNMFB4R09zVGZkSEhmVnJEWTZVNlQ1V2ZuMkp4K2dJS1dRRmVS?=
 =?utf-8?B?TnNEZGNtQ25YdEQ2Q1lNaGRDamlKSXFEZGlxSXkxcGVxZzE2SmFLK1JoVTI4?=
 =?utf-8?B?QzBVRm9LODhqSW4wTFFxZ1ZTdWJscVA3OEVhZkhGd2NxdkJveldLZFZRM1VO?=
 =?utf-8?B?cENXS0MybTFDd1V5dWE0UXZLdHNRSFF6cE1ScTQvRDZsRG5IUzJyV3grcllK?=
 =?utf-8?B?blRtVmRWVzRNQUhFMlBBbGp1cGlHZTBBK0YxN1FCbFhHdlZJMG9FbUFnajhT?=
 =?utf-8?B?VTFXWit4MjBGUVhHYmd6bDdNcXhrR1AyQmtFZkpzSWo4L3AvcGl5YVdmWGNH?=
 =?utf-8?B?UlRmSmlwS3JjTWdJTWZwV0V3MWpBMHJ0MHcwNEtheldhL1E3dDVERkJzQkJH?=
 =?utf-8?B?eGFjbGJlZEUzZzBOT2VLeHNnQS93akFvTk55WThiRnJOUGRma3VweWNZdE5k?=
 =?utf-8?B?N1krSlBEQWN6dEJmL1JKL2xicWs0d0lVeGU1ek9DQmZMbms1eXZ3WCtKT0tv?=
 =?utf-8?B?YnRQczZZMUU0MlJXQTUzWmFDVExHVTNCZWU2d0d3U3RlcTdzVDlNRGhqL0Y0?=
 =?utf-8?B?N2JzZGgvUldJc0I0dW1MSVBCdzJOTE9IRENoVUxJVWp5cW5nb01GR1o1ME1I?=
 =?utf-8?B?UTlpZ2VyN0hjRERFQ2hYSkJiUkZhN3NodnlGOHFMbzc0cFJuTjVNUklnMkZm?=
 =?utf-8?B?cUVCWmFLaml3dGQzMlV3bkNHNFdKaVZ2S05hODkwRk5jbEQzMjRaTGU0NWp4?=
 =?utf-8?B?ZXV0bm40Y0J3blZMV0RqTWJSbXkvcSszUUcwWGpONXlGd3NvN0FrckV3SG1r?=
 =?utf-8?B?TExzNlFHTzRob01aam5TcStWZmcxcDlmRUUvb3hMRy80S0hlQitVNTBwYUc5?=
 =?utf-8?B?MTlITFNNY0VSWVFiVGxFcDRhZWNycEsva2w5SW9nOGNXVTEyM3BpMkVTUS9h?=
 =?utf-8?B?VVNlek5NN3U3QlBUV1Btb2dhWGhlRmxjYjhCcjhkSkU0TXpicmNDSlQvclgx?=
 =?utf-8?B?OXlPbFBDNHNXd1hrWWpBSGhFb0JqYlhHdDRhUkJrODNLNVd5NjZHNVlqMEY1?=
 =?utf-8?B?cE5QeEw0VnlPYW9TYjZ0ZXgxTGkvNFY1SzdZTHh1K0tvYkJPc0l6U3FYSytD?=
 =?utf-8?B?R2NIVVM0ODJEL25sdVk1UFNPVk9IdWQ3VmdHa0w2Q2Y5NGN1SHh3cVE1dUxL?=
 =?utf-8?B?UGJ2WWNJcmJobUdkRzF6MUJ1aEljenJ0TXpERXJiSkFrMlcwT09YRDJtN05R?=
 =?utf-8?B?QTJrdmJVQ0I0MkpCTFFBZUlrYjJEbHNac29PMHlJQnEvVXQ1SEwvSzZyODUx?=
 =?utf-8?B?Mmo3Q2QzYnhveXRuMW1xYmlkbnZSVUFlbkFZbHJieE0rVFQ2SURwWitlMmlz?=
 =?utf-8?B?a0xIYzdRWE1XTk9DRm1ocm5EcGk2ZHhBbzFDalJKamY5SzMycWFVNEdFYThh?=
 =?utf-8?B?MHZaZ0g5TU1YTG1oOHNoVGFQWHo0SW5HQzYyYmJXa3RQYzZHVzdrWkdCeUhT?=
 =?utf-8?B?NmthcXErOVRSQzZHS0FKVHB1T2N2d2xYQnlROXhNVzhOeUJ5Q3BTK1ZmMmVm?=
 =?utf-8?B?dWxodjl1VFkyNmxQcUgxT3NhTWpnb1A2bUZZSkFJUWpOWmRoeVg4bThvbEkx?=
 =?utf-8?Q?J6IUfrcjMQqOcp+iVRRqe7VSN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 061d3903-17ae-4939-504c-08dc475f8ead
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 15:24:52.2658 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VhcVzwMyr1kRYqemRqksWIuSJ/gAL+pXxYh2F8bEpGX95XQ88BNDOPn00hndTzxC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4446
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

Am 18.03.24 um 16:22 schrieb Sharma, Shashank:
>
> On 18/03/2024 16:01, Christian König wrote:
>> Am 18.03.24 um 15:44 schrieb Shashank Sharma:
>>> The idea behind this patch is to delay the freeing of PT entry objects
>>> until the TLB flush is done.
>>>
>>> This patch:
>>> - Adds a tlb_flush_waitlist in amdgpu_vm_update_params which will 
>>> keep the
>>>    objects that need to be freed after tlb_flush.
>>> - Adds PT entries in this list in amdgpu_vm_ptes_update after finding
>>>    the PT entry.
>>> - Changes functionality of amdgpu_vm_pt_free_dfs from (df_search + 
>>> free)
>>>    to simply freeing of the BOs, also renames it to
>>>    amdgpu_vm_pt_free_list to reflect this same.
>>> - Exports function amdgpu_vm_pt_free_list to be called directly.
>>> - Calls amdgpu_vm_pt_free_list directly from amdgpu_vm_update_range.
>>>
>>> V2: rebase
>>> V4: Addressed review comments from Christian
>>>      - add only locked PTEs entries in TLB flush waitlist.
>>>      - do not create a separate function for list flush.
>>>      - do not create a new lock for TLB flush.
>>>      - there is no need to wait on tlb_flush_fence exclusively.
>>>
>>> V5: Addressed review comments from Christian
>>>      - change the amdgpu_vm_pt_free_dfs's functionality to simple 
>>> freeing
>>>        of the objects and rename it.
>>>      - add all the PTE objects in params->tlb_flush_waitlist
>>>      - let amdgpu_vm_pt_free_root handle the freeing of BOs 
>>> independently
>>>      - call amdgpu_vm_pt_free_list directly
>>>
>>> V6: Rebase
>>> V7: Rebase
>>> V8: Added a NULL check to fix this backtrace issue:
>>> [  415.351447] BUG: kernel NULL pointer dereference, address: 
>>> 0000000000000008
>>> [  415.359245] #PF: supervisor write access in kernel mode
>>> [  415.365081] #PF: error_code(0x0002) - not-present page
>>> [  415.370817] PGD 101259067 P4D 101259067 PUD 10125a067 PMD 0
>>> [  415.377140] Oops: 0002 [#1] PREEMPT SMP NOPTI
>>> [  415.382004] CPU: 0 PID: 25481 Comm: test_with_MPI.e Tainted: 
>>> G           OE 5.18.2-mi300-build-140423-ubuntu-22.04+ #24
>>> [  415.394437] Hardware name: AMD Corporation Sh51p/Sh51p, BIOS 
>>> RMO1001AS 02/21/2024
>>> [  415.402797] RIP: 0010:amdgpu_vm_ptes_update+0x6fd/0xa10 [amdgpu]
>>> [  415.409648] Code: 4c 89 ff 4d 8d 66 30 e8 f1 ed ff ff 48 85 db 74 
>>> 42 48 39 5d a0 74 40 48 8b 53 20 48 8b 4b 18 48 8d 43 18 48 8d 75 b0 
>>> 4c 89 ff <48
>>>> 89 51 08 48 89 0a 49 8b 56 30 48 89 42 08 48 89 53 18 4c 89 63
>>> [  415.430621] RSP: 0018:ffffc9000401f990 EFLAGS: 00010287
>>> [  415.436456] RAX: ffff888147bb82f0 RBX: ffff888147bb82d8 RCX: 
>>> 0000000000000000
>>> [  415.444426] RDX: 0000000000000000 RSI: ffffc9000401fa30 RDI: 
>>> ffff888161f80000
>>> [  415.452397] RBP: ffffc9000401fa80 R08: 0000000000000000 R09: 
>>> ffffc9000401fa00
>>> [  415.460368] R10: 00000007f0cc0000 R11: 00000007f0c85000 R12: 
>>> ffffc9000401fb20
>>> [  415.468340] R13: 00000007f0d00000 R14: ffffc9000401faf0 R15: 
>>> ffff888161f80000
>>> [  415.476312] FS:  00007f132ff89840(0000) GS:ffff889f87c00000(0000) 
>>> knlGS:0000000000000000
>>> [  415.485350] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [  415.491767] CR2: 0000000000000008 CR3: 0000000161d46003 CR4: 
>>> 0000000000770ef0
>>> [  415.499738] PKRU: 55555554
>>> [  415.502750] Call Trace:
>>> [  415.505482]  <TASK>
>>> [  415.507825]  amdgpu_vm_update_range+0x32a/0x880 [amdgpu]
>>> [  415.513869]  amdgpu_vm_clear_freed+0x117/0x250 [amdgpu]
>>> [  415.519814] amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu+0x18c/0x250 
>>> [amdgpu]
>>> [  415.527729]  kfd_ioctl_unmap_memory_from_gpu+0xed/0x340 [amdgpu]
>>> [  415.534551]  kfd_ioctl+0x3b6/0x510 [amdgpu]
>>>
>>> Cc: Christian König <Christian.Koenig@amd.com>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Felix Kuehling <felix.kuehling@amd.com>
>>> Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>>> Acked-by: Felix Kuehling <felix.kuehling@amd.com>
>>> Acked-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>>> Tested-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  5 +-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  7 +++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 58 
>>> +++++++++++++----------
>>>   3 files changed, 45 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index 26f1c3359642..eaa402f99fe0 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -977,6 +977,7 @@ int amdgpu_vm_update_range(struct amdgpu_device 
>>> *adev, struct amdgpu_vm *vm,
>>>       params.unlocked = unlocked;
>>>       params.needs_flush = flush_tlb;
>>>       params.allow_override = allow_override;
>>> +    INIT_LIST_HEAD(&params.tlb_flush_waitlist);
>>>         /* Implicitly sync to command submissions in the same VM before
>>>        * unmapping. Sync to moving fences before mapping.
>>> @@ -1062,8 +1063,10 @@ int amdgpu_vm_update_range(struct 
>>> amdgpu_device *adev, struct amdgpu_vm *vm,
>>>       if (r)
>>>           goto error_unlock;
>>>   -    if (params.needs_flush)
>>> +    if (params.needs_flush) {
>>>           r = amdgpu_vm_tlb_flush(&params, fence);
>>> +        amdgpu_vm_pt_free_list(adev, &params);
>>
>> This is completed independent of the VM flush and should always be 
>> called.
>>
>>> +    }
>>>     error_unlock:
>>>       amdgpu_vm_eviction_unlock(vm);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> index b0a4fe683352..54d7da396de0 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> @@ -266,6 +266,11 @@ struct amdgpu_vm_update_params {
>>>        * to be overridden for NUMA local memory.
>>>        */
>>>       bool allow_override;
>>> +
>>> +    /**
>>> +     * @tlb_flush_waitlist: temporary storage for BOs until tlb_flush
>>> +     */
>>> +    struct list_head tlb_flush_waitlist;
>>>   };
>>>     struct amdgpu_vm_update_funcs {
>>> @@ -547,6 +552,8 @@ int amdgpu_vm_ptes_update(struct 
>>> amdgpu_vm_update_params *params,
>>>                 uint64_t start, uint64_t end,
>>>                 uint64_t dst, uint64_t flags);
>>>   void amdgpu_vm_pt_free_work(struct work_struct *work);
>>> +void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
>>> +                struct amdgpu_vm_update_params *params);
>>>     #if defined(CONFIG_DEBUG_FS)
>>>   void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct 
>>> seq_file *m);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> index 601df0ce8290..9231edfb427e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> @@ -622,40 +622,30 @@ void amdgpu_vm_pt_free_work(struct work_struct 
>>> *work)
>>>   }
>>>     /**
>>> - * amdgpu_vm_pt_free_dfs - free PD/PT levels
>>> + * amdgpu_vm_pt_free_list - free PD/PT levels
>>>    *
>>>    * @adev: amdgpu device structure
>>> - * @vm: amdgpu vm structure
>>> - * @start: optional cursor where to start freeing PDs/PTs
>>> - * @unlocked: vm resv unlock status
>>> + * @params: see amdgpu_vm_update_params definition
>>>    *
>>> - * Free the page directory or page table level and all sub levels.
>>> + * Free the page directory objects saved in the flush list
>>>    */
>>> -static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
>>> -                  struct amdgpu_vm *vm,
>>> -                  struct amdgpu_vm_pt_cursor *start,
>>> -                  bool unlocked)
>>> +void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
>>> +                struct amdgpu_vm_update_params *params)
>>>   {
>>> -    struct amdgpu_vm_pt_cursor cursor;
>>> -    struct amdgpu_vm_bo_base *entry;
>>> +    struct amdgpu_vm_bo_base *entry, *next;
>>> +    struct amdgpu_vm *vm = params->vm;
>>> +    bool unlocked = params->unlocked;
>>>         if (unlocked) {
>>>           spin_lock(&vm->status_lock);
>>> -        for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
>>> -            list_move(&entry->vm_status, &vm->pt_freed);
>>> -
>>> -        if (start)
>>> -            list_move(&start->entry->vm_status, &vm->pt_freed);
>>> +        list_splice_init(&vm->pt_freed, &params->tlb_flush_waitlist);
>>>           spin_unlock(&vm->status_lock);
>>>           schedule_work(&vm->pt_free_work);
>>>           return;
>>>       }
>>>   -    for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
>>> +    list_for_each_entry_safe(entry, next, 
>>> &params->tlb_flush_waitlist, vm_status)
>>>           amdgpu_vm_pt_free(entry);
>>> -
>>> -    if (start)
>>> -        amdgpu_vm_pt_free(start->entry);
>>>   }
>>>     /**
>>> @@ -667,7 +657,13 @@ static void amdgpu_vm_pt_free_dfs(struct 
>>> amdgpu_device *adev,
>>>    */
>>>   void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct 
>>> amdgpu_vm *vm)
>>>   {
>>> -    amdgpu_vm_pt_free_dfs(adev, vm, NULL, false);
>>> +    struct amdgpu_vm_pt_cursor cursor;
>>> +    struct amdgpu_vm_bo_base *entry;
>>> +
>>> +    for_each_amdgpu_vm_pt_dfs_safe(adev, vm, NULL, cursor, entry) {
>>> +        if (entry)
>>
>> Entry can't be NULL here I think.
> Yeah, makes sense, if there is a GPU process, it will have at-least 
> one page table entry.

The problem is rather that entry is either the root entry or a child 
element within the array of entries.

So entry can never be NULL, only entry->bo can be NULL if there is no 
PD/PT allocated for this slot.

Regards,
Christian.

>>
>>> +            amdgpu_vm_pt_free(entry);
>>> +    }
>>>   }
>>>     /**
>>> @@ -972,10 +968,24 @@ int amdgpu_vm_ptes_update(struct 
>>> amdgpu_vm_update_params *params,
>>>               while (cursor.pfn < frag_start) {
>>>                   /* Make sure previous mapping is freed */
>>>                   if (cursor.entry->bo) {
>>> +                    struct amdgpu_vm_pt_cursor seek;
>>> +                    struct amdgpu_vm_bo_base *entry;
>>> +
>>>                       params->needs_flush = true;
>>> -                    amdgpu_vm_pt_free_dfs(adev, params->vm,
>>> -                                  &cursor,
>>> -                                  params->unlocked);
>>> + spin_lock(&params->vm->status_lock);
>>> +                    for_each_amdgpu_vm_pt_dfs_safe(adev, 
>>> params->vm, &cursor,
>>> +                                       seek, entry) {
>>> +                        if (!entry || !entry->bo)
>>> +                            continue;
>>> +
>>> +                        list_move(&entry->vm_status,
>>> + &params->tlb_flush_waitlist);
>>> +                    }
>>> +
>>> +                    /* enter start node now */
>>> + list_move(&cursor.entry->vm_status,
>>> + &params->tlb_flush_waitlist);
>>> + spin_unlock(&params->vm->status_lock);
>>
>> I would put this into a separate function maybe.
>
> Noted,
>
> - Shashank
>
>>
>> Apart from those nit-picks looks good to me.
>>
>> Regards,
>> Christian.
>>
>>>                   }
>>>                   amdgpu_vm_pt_next(adev, &cursor);
>>>               }
>>

