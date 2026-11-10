Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA9B606A33D
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2026 10:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=DOB4JlZN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43C3110E119;
	Tue, 10 Nov 2026 10:13:06 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012011.outbound.protection.outlook.com
 [40.93.195.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5442910E119
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 10:13:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PrJlqbyeqyOXPxqhDx1mtKuv6UO4F7jGavcyM9lf7XahC9+OmNezpvml/jcsq982ZHJaiWLjGbIsUs+szZC4P+xLFn0ZAmFk/fPh4xXmj0GuygYwCPWOE8Yp625se+LwHQFOAHq2MxEGpeY90GRfXRvJ+DvHFhIhccjtWbXYWSU+RCiyeKSNdhDY1WL6aS/M1cRcbXXaRG03WzAucXd9i5/70RIUNtWGmfUWGXUGrJ8CpJ8y5BJbwb9lfm5bMDmzdDYsy8r0AA8qXTcw8x1C+T/A2PwmVFOj6OB3D5PdDfKQRRnUkUIe97GNjhL+Zy0XuUPEu4bGp3+/ReSUITIzmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5l60eDl6pNNLXhDrqNsVIPyQNaD7yxLy9Hja44eGkU=;
 b=t+prIaHffCwmF0LboOBt2ls1vVHWdydpvr4FKOHRS56Egjc0f67obVh0a8+T3CdeAFPMTsTuSy6fV+WlPf4ahqBnt8CA4/xIDuyWmK1KfBQOyQoLLCIucJ6BZgt5hLcnh8RGyIU9sPV23pjM//R2C3DnKQnhLhiYYAxvFUsnvpusHpCkKyabs0iYrE7RCZuz4q8g7cMvYCWyVzm+gVVTXDXNM1CzoQ4Fy9PP4D/NXPgrQ0N9CfcS3Sa54o++z12pPHR4/BozLIe2cjyjrwQCfbWZzfgcXD0Jk8SS36dCA6QaVwdT2LVM1ZGxhvcvZRk8fgD9lZV4d0lI95axWAH2WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5l60eDl6pNNLXhDrqNsVIPyQNaD7yxLy9Hja44eGkU=;
 b=DOB4JlZNCX5LGx788CzJaS5SlrNF8vC/ntAeE0ujt5E/aNGKxvYXcTz4SdwQ+POFNOF/kNtZTf85XOj5HOySeXHtHxhpiXORRcM8mHNB3p/RVH8hE4oiOWiKwRJkHELS/ehmVor78iQMgAVeWfchDihXm6Ld82Zq5M9Mf+e+3JA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV2PR12MB5752.namprd12.prod.outlook.com (2603:10b6:408:177::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 10:12:56 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 10:12:49 +0000
Message-ID: <a4f245a0-8144-4eaa-97ca-e12a2686e4f8@amd.com>
Date: Tue, 10 Nov 2026 11:12:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix page fault by not skipping VM flush
 before tlb_seq update
To: "Li, Chong(Alan)" <Chong.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20261109140616.2326304-1-chongli2@amd.com>
 <bd300bdd-21e7-49e7-bb2c-2d0512c7fc8c@amd.com>
 <DS7PR12MB5768A46AA81FED421E1593C39B722@DS7PR12MB5768.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB5768A46AA81FED421E1593C39B722@DS7PR12MB5768.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0162.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV2PR12MB5752:EE_
X-MS-Office365-Filtering-Correlation-Id: 9231d86a-7e20-4ef9-86ae-08df3f132caa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|4143699003|11063799006|56012099006|22082099003|18002099003|10067099003|261102123227099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261028144727099003|261026140227099003|261026121527099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: VrzIdCYgRHYZHuUA0Sw6zr79/4qekPtcelCC2lKFRjeLQeTUp387yBKfMKTUB6jnBo/fvxMuqrLZ/URtLxAbE1tAnE+xBierV8CuJLlbY6dS0gFJDCGLKa7MJBjFQhKqDJ3bHQydQqC0iaOnNDDE4Lsm/4DS5IoL0/z00EK9WW76DbwfHvnB4hsO/qOLyvlNY/yZkQiopTIPboJV5tgduin6POtI1UDb2FVZamYsb7S7K2zCCbp5gyOV7o4mMDfTqD3oahjQzy7vQkUmNZmVGMuqnMtsXFVYzV3RYHPHN25hTMlE/RUCUEBWDwnuQUTszmweD3v8cPP6lWrzbPsVA/y77+/XSPm0yXDZkkhn8o63WYeSA5xpi70sza1jRAKvw1+iWLtxxedIrQMG2Zj/xS8KhYJvBndVwWkNPNBnlUd0qk3WfQ2ApBe8hU4rcbX61pLR+j3m3UXMgWdOa1VtPb57wiPo5/PJ3dMt30wiSl/LYsZo8A4xCHzIZu2aAyhLlq78le6waU7Pr0isEXvLM7rjs3bXDmTEof0/c1Xpl5cPgp3dcBu2JIaF2YsmYwUwlCFzTKTYQzNIxkrJHKh6o2HmDJDVP0r2+V8fF5juOh93LGUQ6vgs582hFCvLfYSvuSp1CRlYjwKTqoA7cZ56wAYCcJtajuIQ4Ot+No7pBiw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(10067099003)(261102123227099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261028144727099003)(261026140227099003)(261026121527099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmhQTXRmMklwczQzZDlvR0xjNlprbmMwa1pSNXN2UklLT0NYUG4xbW5yblV1?=
 =?utf-8?B?WUlSN2tkOEtPdkZDUGJVaUhiT0VwdGpNY0NOS1lJR3hkcVlENndPeitHTFB2?=
 =?utf-8?B?akE0cFpmK3RMOWhJQWNaTmFGUlVlQzdDNDcxdTVnWDl1L3hxU2lDTmFCRkxq?=
 =?utf-8?B?RjJaVmFvU0VNTTEwMmpKSDNNUStTa29YbnNkZnl5emc4SUo2MXVrbi9nU0w4?=
 =?utf-8?B?Qk4vaTlaQ0dybmN2aW1LeXNYN1hUSnpwalkyb3QyNzVUU0haR2x6Z1B5NER5?=
 =?utf-8?B?U090VmVMN3A5RGk0VmNyVVBUeUpUbEs4YzBPd1V0cXVYSndZbE5UMkd5a20y?=
 =?utf-8?B?NlFrSEt3a2lDazd1Wnd0K21LbzhuZFpIYU81KzF3bUc2Um1LTGg3eUdoZHBH?=
 =?utf-8?B?RCtRT1JYV3JvRVAvL0FCUkUrTlhONndUajdRN2NFRFI5endZR1dOWHlHaUpT?=
 =?utf-8?B?MStjQnJmbTgwSG9rMXcyVm1EOXdxeURmOVM1cGJJTFdkcUI3aTJ0VnlSRFlt?=
 =?utf-8?B?YUJacDRKbE9CUzRHQ0orN1MzVmJIb0x5eVljSm9WTHJ0UUlSbVhxQjFuWU5B?=
 =?utf-8?B?UTRXUldMdE5CQ1JQaWhTaXpXL1JVcHR4RElKVnVmN0FsL0FGS2ZpTjA3S0hD?=
 =?utf-8?B?ZDhVeGF2UHl2QjNWYWlScnpZSTdQK2Y1UXkzVkRpMTBwd0pRWmhSbzFlcDR3?=
 =?utf-8?B?L2VWWnY3TEd2RFlsVGZnOXNYWG9SRGtaVk1Ld3VIRllKN01DOFg1TTlwMmR1?=
 =?utf-8?B?ODFhNm5kZG5WS2ZBTjZOMVB0cndJeEFxOHpYMDJpcyt6VzJBVGVhZTNya0pz?=
 =?utf-8?B?L0c2UUd2bElnTnJCRk8vb1Y2aFNsMTJ6d1pPbzU0UXEzeGpLRW85Y040RHQr?=
 =?utf-8?B?cTE0dHd2U1dDdE1WZU1SWWJFNFRRVVZaMi8rbERTcWxvQ1RyRlVNZFByZURU?=
 =?utf-8?B?cW9KYzJpcUhIb2gzWHV4NW5weklaWFZla3I1cmZBYUo1cjdKQ2xVK2gxQXZ5?=
 =?utf-8?B?ZkY0dDFvSVpzL1MxRjZIeUNJdWJoSmVXRG4ycG5yczRIT21wQU1FMkp5RGJw?=
 =?utf-8?B?SWpLNVlwT01LTG9hd1BSQnhEdEQ2MFZRdUhzSXNYTVFaWHRXdUYyb2FzTGR0?=
 =?utf-8?B?R3RuWVYzbzlQcUJFTEcyTzZIMkJtVkNnNzJWdTJEM0tmY3ZzaTNJNDFuLzl0?=
 =?utf-8?B?RHgvS3dUNU1uSnM3aEt5U3FndTVBTzRQODQ1TmJjTE1wOFRCVjZQcnk5Q25p?=
 =?utf-8?B?Rld6dVh3TUN6YlRvL0IwVGhzbmV4VWxvd0FwVkxwQndXaW4vQkxlVHZRaE0z?=
 =?utf-8?B?TU5Ia1dkbUVDYjVsSmxXTnpCOFRxd3Z5Y0I3Q05TazRRMjBSc3c2aVk5YWtG?=
 =?utf-8?B?SzBEUTZ4WXpHeUxFeUtOd3VBNEVsTzhFSnN3Q0cvUjAvY3g4RHVISWtIbkhX?=
 =?utf-8?B?MG1US0JnYXFsS2V5L3VSRzl4ZHFWU29QckhOUU1jZklKTVd6dmRpK2NJZDly?=
 =?utf-8?B?R2dCVDZRdDM5a2x4djUzVU4xUVNoSDFLd1o0bmNPRWJqTzF3RFBlbVpZZzBP?=
 =?utf-8?B?Wm1FZ2o4eWxNRHcrUFQzT3N6Smhqd2VudUxJd2RIVWxGWEhXT09SRy9udHUy?=
 =?utf-8?B?dWRzaUNYaDhLUnExQmszNGloUnFsdHpvUFJhYjh1UkR6TndKL25mOFZZSTFW?=
 =?utf-8?B?QzI1TWtYaHZhZ0dEMjdEdDRHZEhYWFRMa09TYUdKSDkxa2xGRGJDNjV0QzF6?=
 =?utf-8?B?eXVIUS9kUkMzaVdDWWxRVTdvM1hLVUhDZSttcFFjWXlQZHg5M1puSk9KNGZp?=
 =?utf-8?B?WnhCUVVydDh1YjhvV1QzWGNJaTlCdk12NjdCQ21qSS9QaER6K1VGbmdmUkpK?=
 =?utf-8?B?dWpvUjRpMlErdTJyU3hxRS9qNndxNCtVZkVtb2ZGcGNvNXR5dHlnR3dMVmlj?=
 =?utf-8?B?L2tRL0haTmtKV0pqUjNOYmVvblZHR29Ea05TNVFzT3VpTEE5SkNPWkhpdFk4?=
 =?utf-8?B?alJNcXcvdVkxenlLZEhGTjFXMXJ0cE1ITjJpQjllSFV6Um15dHRPTDdubjdo?=
 =?utf-8?B?R2xTTzcwT1NSL3hGSGxCTVFaM2Y0cXp4SUVIU2R5WnVDM2dKTDllai9QUGFT?=
 =?utf-8?B?bU1LUmdFVnNpdkprNUZFZzdwM1MrbXpkWmdldmJydERBZHRZUEQ1eHNTTkNS?=
 =?utf-8?B?TGJ0cXc4Um5wNGY4Tk5vYTZZTjJPbG9SMXlZblZOMGFRelEvbDc1QTMrczly?=
 =?utf-8?B?VnF2anBNOENxSFNndit1dlM0eVdnMkMzUWd5TjR3RnJ2dmhuS0dsbzdqYTVD?=
 =?utf-8?Q?RPlxccpLwp40sxVIDM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9231d86a-7e20-4ef9-86ae-08df3f132caa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 10:12:49.7503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WwT0+j22EVf5N/W0U7x+3qrkfWdH9ie5nQxDBjVrr3NGptsFLOt3utJk1fNlrznr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5752
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Chong,

On 11/10/26 10:42, Li, Chong(Alan) wrote:
> AMD General
> 
> Hi, Christian.
> 
> The lock of each fence indeed never changes.
> Each PT update fence has its own lock.
> 
> The issue is in the fence locking process.
> 
> When a fence signals, dma_fence_signal() holds the fence's lock and
> calls amdgpu_vm_tlb_seq_cb(), which increments vm->tlb_seq.
> amdgpu_vm_tlb_seq() waits on the lock of vm->last_tlb_flush until
> amdgpu_vm_tlb_seq_cb() completes. The lock of vm->last_tlb_flush
> ensures that amdgpu_vm_tlb_seq() returns the incremented
> vm->tlb_seq. This is the normal flow.
> 
> But vm->last_tlb_flush may already point to a new fence:
> amdgpu_vm_tlb_flush() replaces it as soon as a new PT update is
> submitted, usually before the old fence signals. amdgpu_vm_tlb_seq()
> then takes the new fence's lock, which is not held while the old
> fence's callback runs, so it is not blocked and returns vm->tlb_seq
> before it is incremented.

No you are mixing things up, vm->last_tlb_flush was something completely different.

vm->last_seq_flush is the fence where we install the callback on and yes that is replaced with the next installed callback, but that doesn't matter the lock is always the same.

vm->last_tlb_inv is the TLB invalidation fence which actively invalidates the TLB for a passid.

That are two completely different things.

Regards,
Christian.

> 
> Finally, updates = amdgpu_vm_tlb_seq() misses the increment, the
> condition (*id)->flushed_updates < updates is not satisfied, and
> needs_flush is false, so the job reuses the VMID without a VM flush.
> 
> Please let me know if anything is unclear or if I'm missing something.
> 
> 
> 
> Thanks,
> Chong.
> 
> 
> 
> 
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Monday, November 9, 2026 10:08 PM
> To: Li, Chong(Alan) <Chong.Li@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amdgpu: fix page fault by not skipping VM flush before tlb_seq update
> 
> On 11/9/26 15:06, chong li wrote:
>> amdgpu_vm_tlb_seq() waits for the tlb_seq callback by taking the lock
>> of
>> vm->last_tlb_flush. Newer page table updates replace
>> vm->vm->last_tlb_flush
>> immediately, without waiting for older callbacks. A job scheduled
>> after an older fence signals but before its callback finishes takes
>> the newer fence's lock, while the callback runs under the older fence's own lock.
>> The job misses that tlb_seq increment and can reuse a VMID whose TLB
>> was last flushed before the older page table update completed, without
>> flushing the TLB again.
> 
> That's not even remotely correct.
> 
> All fences use the same lock, that's why this works correctly.
> 
> Regards,
> Christian.
> 
>>
>> how to fix:
>> Count the flush-requiring page table updates whose tlb_seq callback
>> has not run yet, and request a VM flush when a job reuses a VMID while
>> this count is non-zero.
>>
>> Signed-off-by: chong li <chongli2@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 10 ++++++++--
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 12 +++++++++++-
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 10 ++++++++++
>>  3 files changed, 29 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> index 9c879ac68352..b9e058da162b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> @@ -393,7 +393,8 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
>>       unsigned vmhub = ring->vm_hub;
>>       uint64_t fence_context = adev->fence_context + ring->idx;
>>       bool needs_flush = vm->use_cpu_for_update;
>> -     uint64_t updates = amdgpu_vm_tlb_seq(vm);
>> +     bool tlb_pending;
>> +     uint64_t updates = amdgpu_vm_tlb_seq_pending(vm, &tlb_pending);
>>       int r;
>>
>>       *id = vm->reserved_vmid[vmhub];
>> @@ -405,6 +406,8 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
>>            !dma_fence_is_signaled((*id)->last_flush)))
>>               needs_flush = true;
>>
>> +     needs_flush |= tlb_pending;
>> +
>>       if ((*id)->owner != vm->immediate.fence_context ||
>>           (!adev->vm_manager.concurrent_flush && needs_flush)) {
>>               struct dma_fence *tmp;
>> @@ -456,7 +459,8 @@ static int amdgpu_vmid_grab_used(struct amdgpu_vm *vm,
>>       unsigned vmhub = ring->vm_hub;
>>       struct amdgpu_kq_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
>>       uint64_t fence_context = adev->fence_context + ring->idx;
>> -     uint64_t updates = amdgpu_vm_tlb_seq(vm);
>> +     bool tlb_pending;
>> +     uint64_t updates = amdgpu_vm_tlb_seq_pending(vm, &tlb_pending);
>>       int r;
>>
>>       job->vm_needs_flush = vm->use_cpu_for_update; @@ -480,6 +484,8 @@
>> static int amdgpu_vmid_grab_used(struct amdgpu_vm *vm,
>>               if ((*id)->flushed_updates < updates)
>>                       needs_flush = true;
>>
>> +             needs_flush |= tlb_pending;
>> +
>>               if (needs_flush && !adev->vm_manager.concurrent_flush)
>>                       continue;
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 2ba33212d507..6d15fd001a42 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -1095,6 +1095,9 @@ static void amdgpu_vm_tlb_seq_cb(struct
>> dma_fence *fence,
>>
>>       tlb_cb = container_of(cb, typeof(*tlb_cb), cb);
>>       atomic64_inc(&tlb_cb->vm->tlb_seq);
>> +     /* Pairs with atomic_read_acquire() in amdgpu_vm_tlb_seq_pending() */
>> +     smp_mb__before_atomic();
>> +     atomic_dec(&tlb_cb->vm->tlb_pending);
>>       kfree(tlb_cb);
>>  }
>>
>> @@ -1281,9 +1284,16 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>               start = tmp;
>>       }
>>
>> +     /* Must be visible before the update fence can signal */
>> +     if (params.needs_flush)
>> +             atomic_inc(&vm->tlb_pending);
>> +
>>       r = vm->update_funcs->commit(&params, fence);
>> -     if (r)
>> +     if (r) {
>> +             if (params.needs_flush)
>> +                     atomic_dec(&vm->tlb_pending);
>>               goto error_free;
>> +     }
>>
>>       if (params.needs_flush) {
>>               amdgpu_vm_tlb_flush(&params, fence, tlb_cb); diff --git
>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index d8e17f493f61..312fd0d268ce 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -337,6 +337,8 @@ struct amdgpu_vm {
>>
>>       /* Last finished delayed update */
>>       atomic64_t              tlb_seq;
>> +     /* Flush updates whose tlb_seq callback has not run yet */
>> +     atomic_t                tlb_pending;
>>       struct dma_fence        *last_tlb_flush;
>>       atomic64_t              kfd_last_flushed_seq;
>>       uint64_t                tlb_fence_context;
>> @@ -578,6 +580,14 @@ static inline uint64_t amdgpu_vm_tlb_seq(struct amdgpu_vm *vm)
>>       return atomic64_read(&vm->tlb_seq);
>>  }
>>
>> +/* Read tlb_pending first; pairs with the barrier in
>> +amdgpu_vm_tlb_seq_cb() */ static inline uint64_t amdgpu_vm_tlb_seq_pending(struct amdgpu_vm *vm,
>> +                                              bool *pending)
>> +{
>> +     *pending = atomic_read_acquire(&vm->tlb_pending) != 0;
>> +     return amdgpu_vm_tlb_seq(vm);
>> +}
>> +
>>  void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
>>                                 unsigned int pasid,
>>                                 uint64_t addr,
> 

