Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 241FAC54E5D
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 19:00:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B376010E93B;
	Mon, 18 Mar 2024 19:00:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UyKfdYAY";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B861D10E93B
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 19:00:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7nDqgc2G8ZfAm8BgYAp4pBumKn/kC4YKcc/RDEUbKa1VI30A9T9YjXm8aWEHfbfH97kLBl70B6h94eV3cHOyd0j3tpsV41hflAyCROh9YHDqkCvVkOWIoAbUWZYKQ1bGR/GufpOsNmHeQB0usUWUK27FEmhJ0UhUJtNLyY3/t5HWsCpkGzCC2ATKFjSuxHWPLDXbZtGo7D/LatZyJZRETWbW8Cdluc6oyMgllCrXfb4jRAdbs8ZiH+CA4Ilp4IZBHAa8SLgfLvSrP34kC1zcRGoMSjQ66EuDilgT5JbmWsUpKtxur13K1cukJLruHlBAIvkEbR1d4KjPVCG3mhPaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7HS7cuKYA/kdRdOEgTAvtCnbv33SNbaP2ecwEI8LRSg=;
 b=csbbzYtyWawkfGNC1p054UaQlf+p3K4z05Dlr8KP3rIQvyYUp28VpUYSsbdd1qsOljIzcSnHQQ/keGdKfCrEM5zC6szqN8bpwJVMnlYQ7bpMg5gXq9tA7UCxCBD1DaThXgRcUaHDg9AsUQ/38Cns2JOYtb7knihUfercGVo/dWq8WoiGCtiYWr5HSx079IzgKMqal08tiguEe16hBlGHgtVhfxL+hB8lJnDbfMw91ZcntIiy/w1KjeVb5+IXGse9oLjZuDScfgkWBfPZ3UnbvhTA0ISyS8OCfIPAIRBeIH3KtmJJ2cc9CQUos7KDju3kP/IwhvUvs/o1xLL5T96ewQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HS7cuKYA/kdRdOEgTAvtCnbv33SNbaP2ecwEI8LRSg=;
 b=UyKfdYAYfnJ6LymTpztNSdeMzW0a/dyO5tiybtcEL40N/ZyCJ3nxzOa/Qq2AkES6/kzjCGgEY5lxQCrmAx831BHidFvoZMwr8XPccpZYiPSmYO8fv5OQLATtOIc85B8996XIs7Jb++1Xg4ahHknySJQT7qzkq2OPfM6m3uBAst8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 19:00:08 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b%5]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 19:00:08 +0000
Message-ID: <0331587e-fa1b-f1f6-c72b-3d8509c51d45@amd.com>
Date: Mon, 18 Mar 2024 20:00:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v9 1/2] drm/amdgpu: implement TLB flush fence
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Felix Kuehling <Felix.Kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20240318161140.2101-1-shashank.sharma@amd.com>
 <1733c1ef-f8c0-46db-8b1d-73a6520b8c75@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <1733c1ef-f8c0-46db-8b1d-73a6520b8c75@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::11) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|DM6PR12MB4124:EE_
X-MS-Office365-Filtering-Correlation-Id: 56e012bc-de48-4751-a33a-08dc477da14a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pQXPlYGxfAU1eUKilT5bHe9DjerLripR90A0cSYnXpdUE3UUgHayDBrqWVUApDlR0MB30cTW2Pi4QnVXcDGt7IDw6KPigC/uc1XP2U//Gl41WlX6kyt5iciKoOULHbCDKSDgFHZjGjf7P3XhDMAxC0zhhehHmq+ZHaiEMG2uWeRBqrdGY8xzJfO2uktnSoyzymjzk7fqEWZhsg//1/xahkGcYRdX/fJBQiyh3EWftLPobyQTuE8CnAUGcfqz4gqp9Zf7RUEwhV/heXiIn2wrAMnsdKP4eXPYB83b0TnAjZOkHBEvGEQ4e7xgq+zwmRx++M5JVFgeyRoarZ+GhweIiMT2QjobDwHHiqPBw5bj4/MTMHCviGkuJF0TiJioEkH2xZSICmakgfYXUGS+wtf1wSdz0L25WHCH0yXMUVun8T2CnoapwMCcYx42NILyIBVdUkkKCBSxbjGOacMeRYOhNWOljV8HEIQCVTF4NEUnI7k9N5vlEYSwvHu8W82tLzzLvhNiNZJl2XdHQD1KZl86kf0DIZ6fpajONpiIlhGb514hQTQJY41i/1zbPzInNlO1WEajJeQi3vWek51q8Y2HjqbTFGjfMMYr/Qn2cxZJES8MY3JXco/deen0kz8grvoUJKBH4EqGU/0yjojAYyz2mhnNBraGcWFo3cMIyuzVCUI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STFtS1dtV1BJZmZFSWRoUnBENmt6YXI0U2NHRDBSQXUyUkFFL0VTR2g0cGNG?=
 =?utf-8?B?R21TUk1NNlZLR2VwbkpFQS9zRkhzcU40b25VTGlSalRCeTlYektYRWNWeUVO?=
 =?utf-8?B?c0NTdkluNi85d08vUWQwUEVIbUZZWGZDNkd4bjJSUmQxaVQ3OStQc1R4RHN3?=
 =?utf-8?B?UVJXNkU2NTdIR05KWXhoNU1lUWlyVE9pcE9OZE0xV2NRRU5tNFE2bHBuNUR2?=
 =?utf-8?B?VmlZRDM5VkJDWENvbDdTSlB0WlJDL1FnOW5HS3NQUnRFNHZFdGhQK2hia21p?=
 =?utf-8?B?RE0wbXRlZlZpMUI4YUhxdGUwcXNDaC9tZXp5Z2s4NzdPbE5reEFVUlhrRzBZ?=
 =?utf-8?B?RWt1WmdONFlHMGdoL3Ftam9vM1A0THhBQzAvc09jem0zNEZhTmtvVkhOdHlt?=
 =?utf-8?B?T0RiVy9hVzg2QWtWUnQ0VGdXVDFMVHFCc2JwY2gyYjhneGoyRERNUjY0VVJC?=
 =?utf-8?B?allsSGVnckhNTjNvT3U2SVpzVG5Bekx2U0hrNlpMWG9pbDBYTDJTZUJoeDM5?=
 =?utf-8?B?Qlh2a0ZsREk0WXBvOVJTdGl2Z2Ura1p4bDd0bDhNNml4M3RManhXOXR0YlQ3?=
 =?utf-8?B?QlJSbG4zY3pNL29vd1BPcFY0Vi9BWGN3eWxNdG5TLzIzcEhzSzd1MU1zUGh6?=
 =?utf-8?B?OGNQZmk5cm9NVGdsMTgweDYybStFZytZNzRlVTY4M2kwcFZlN3VlWFo2N2pE?=
 =?utf-8?B?QjhzODdFcnRJTUVSTlBGaDNobFNOYkNOVHR3VGZTV1EzQlB3Njd1MDNtelU2?=
 =?utf-8?B?enRiN0l4bkIxYUpkT1doOHZqZGR1TUY4K0hEcVhCMm9DblFYY1RITnZUeURw?=
 =?utf-8?B?YS9jWnlqVHJKaEJoSnBIZlJmTmJxS3pDakFwdkdJZTdJVXlwR0FybHg2aDVJ?=
 =?utf-8?B?ZE5yeG5tZDhYcm4rL1lLNGlNcTFzek1rS2VXWVhuQ09qNkdDRWhZazdOMUwv?=
 =?utf-8?B?SVZWbWVGeDVDRFRlQXJDNmgrbktNNEZ6bXl5eFhUelpFYTNSYXpQam1aNEo0?=
 =?utf-8?B?cTNKUUpOVDNnVjUxZS9ITzZKMEYrcW44TFk0eGV1VXFIQTFWTXFCeHpLUjBU?=
 =?utf-8?B?YXNnZDBvakJRQ0tWTVBtaW1rNjJZTVA1RUhXT0dqQXRCRmErMDU2b0RFZTNr?=
 =?utf-8?B?Q1IwTlkwcnB5S0o3ZnNQQUlTK0xtWFRkL1VvbHBJV0xnblZzR291cmVPNEU2?=
 =?utf-8?B?WVdlZ25RRnVRVHJKYi9jaUNubmhxM0Vqd0NwVjhaSUt0eU5BS1Zlc0k0dW96?=
 =?utf-8?B?Mno2Tkg0dW4wbHIvWWlFTnh5MHZycElVS0s0T2UwdFdIVlhKUEFyVEFoTTFW?=
 =?utf-8?B?Y3A2S0xkRU9qQ3pMY2xoT1lFRUVrWGlsaVVwMGxscExxOFFxTTQzSTZtdW1L?=
 =?utf-8?B?QWttMnNTUURjeVRiUm5QeGo1RzNSZW5ZdlN0Z1BSdmh6bFZ6UlBuYzBsWXZB?=
 =?utf-8?B?MHhsL1pSUzZrN2RQdVpaRGxkaEtON0xJdW81S0dLNUNFaFpiSFdUMW1NQ3F6?=
 =?utf-8?B?Y3dKODBnWExMRktUYnBqblB3ZkxUbVdUQUVSWGU3eGZhdFZ0RUJ6SzZsZW5U?=
 =?utf-8?B?MTRkbkgweVErSThpR1F1RFkwR2IzQnI3UDByZ045amRoM3RZaEdMWFhiVVVx?=
 =?utf-8?B?VDFKWFMxcUZLWGdPUE1tcTFYdWVSSStGc1RZNHRwK1NLK001R3FhaXMzd0Mx?=
 =?utf-8?B?L3NhMjdocGwvaC9VSys0V2N1aXJMOWlkaXlKV3pvT0ZPU1lCWitvWVhuYy95?=
 =?utf-8?B?ZjlBRTkzSU9tK1BUNGl5elJKYnNOQU4vTUdrTkErM0tHQXFHQzNSY0ZuT095?=
 =?utf-8?B?YXJoSnR0Nm5uSHJFNUROdGViUk5JUFhIbUl6VVNjNkNMV24wWUtNUFlUR2tI?=
 =?utf-8?B?cVdTYXF1aERZOUt1MVRPVFhiZ3F6dWR2Vm1vN0duK09lZVdLeHRQYUlyeUdJ?=
 =?utf-8?B?MHBUVnhBQy9VVjZGekhDUFJtaHlhTXZWdHg0SUpzaFM3ZWJHRGQrbkdXbGNQ?=
 =?utf-8?B?MFRWdUdoWFdmc1J5MVZxdTZNTTRLTkRjdTZFRDBURWl0Y3RUMzJIbFh6TW1o?=
 =?utf-8?B?QU9rVlRiYTJ5T2dGbG9ySnpBWHJ5cGszajUxVzZ4UUhRWHN5Z3J4SUZqcjZI?=
 =?utf-8?Q?/bL3WRAsaxIfJsCrUdDxwMCDZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e012bc-de48-4751-a33a-08dc477da14a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 19:00:08.4455 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vUcxkS0WrLHGqe4jTe2qrtGCrkh1h+zdl6iwyfE7yve0n3hkNh/MwFhbV4SaiqxKMLAPKPpg3NI0339YDJlyTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4124
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


On 18/03/2024 19:10, Christian König wrote:
> Am 18.03.24 um 17:11 schrieb Shashank Sharma:
>> From: Christian Koenig <christian.koenig@amd.com>
>>
>> The problem is that when (for example) 4k pages are replaced
>> with a single 2M page we need to wait for change to be flushed
>> out by invalidating the TLB before the PT can be freed.
>>
>> Solve this by moving the TLB flush into a DMA-fence object which
>> can be used to delay the freeing of the PT BOs until it is signaled.
>>
>> V2: (Shashank)
>>      - rebase
>>      - set dma_fence_error only in case of error
>>      - add tlb_flush fence only when PT/PD BO is locked (Felix)
>>      - use vm->pasid when f is NULL (Mukul)
>>
>> V4: - add a wait for (f->dependency) in tlb_fence_work (Christian)
>>      - move the misplaced fence_create call to the end (Philip)
>>
>> V5: - free the f->dependency properly
>>
>> V6: (Shashank)
>>      - light code movement, moved all the clean-up in previous patch
>>      - introduce params.needs_flush and its usage in this patch
>>      - rebase without TLB HW sequence patch
>>
>> V7:
>>     - Keep the vm->last_update_fence and tlb_cb code until
>>       we can fix the HW sequencing (Christian)
>>     - Move all the tlb_fence related code in a separate function so that
>>       its easier to read and review
>>
>> V9: Addressed review comments from Christian
>>      - start PT update only when we have callback memory allocated
>>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
>> Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
>> Acked-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>> Tested-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>> Reviewed-by: Shashank Sharma <shashank.sharma@amd.com>
>> Signed-off-by: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  64 +++++++---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |   8 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c    |   4 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     |   2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c   |   4 +
>>   .../gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c  | 112 ++++++++++++++++++
>>   7 files changed, 175 insertions(+), 22 deletions(-)
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile 
>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>> index 4536c8ad0e11..f24f11ac3e92 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>> @@ -70,7 +70,8 @@ amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o 
>> amdgpu_kms.o \
>>       amdgpu_cs.o amdgpu_bios.o amdgpu_benchmark.o \
>>       atombios_dp.o amdgpu_afmt.o amdgpu_trace_points.o \
>>       atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
>> -    amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_ib.o 
>> amdgpu_pll.o \
>> +    amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_vm_tlb_fence.o \
>> +    amdgpu_ib.o amdgpu_pll.o \
>>       amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
>>       amdgpu_gtt_mgr.o amdgpu_preempt_mgr.o amdgpu_vram_mgr.o 
>> amdgpu_virt.o \
>>       amdgpu_atomfirmware.o amdgpu_vf_error.o amdgpu_sched.o \
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 81fb3465e197..104bf600c85f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -885,6 +885,44 @@ static void amdgpu_vm_tlb_seq_cb(struct 
>> dma_fence *fence,
>>       kfree(tlb_cb);
>>   }
>>   +/**
>> + * amdgpu_vm_tlb_flush - prepare TLB flush
>> + *
>> + * @params: parameters for update
>> + * @fence: input fence to sync TLB flush with
>> + * @tlb_cb: the callback structure
>> + *
>> + * Increments the tlb sequence to make sure that future CS execute a 
>> VM flush.
>> + */
>> +static void
>> +amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>> +            struct dma_fence **fence,
>> +            struct amdgpu_vm_tlb_seq_struct *tlb_cb)
>> +{
>> +    struct amdgpu_vm *vm = params->vm;
>> +
>> +    if (!fence || !*fence)
>> +        return;
>> +
>> +    tlb_cb->vm = vm;
>> +    if (!dma_fence_add_callback(*fence, &tlb_cb->cb,
>> +                    amdgpu_vm_tlb_seq_cb)) {
>> +        dma_fence_put(vm->last_tlb_flush);
>> +        vm->last_tlb_flush = dma_fence_get(*fence);
>> +    } else {
>> +        amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
>> +    }
>> +
>> +    /* Prepare a TLB flush fence to be attached to PTs */
>> +    if (!params->unlocked && vm->is_compute_context) {
>> +        amdgpu_vm_tlb_fence_create(params->adev, vm, fence);
>> +
>> +        /* Makes sure no PD/PT is freed before the flush */
>> +        dma_resv_add_fence(vm->root.bo->tbo.base.resv, *fence,
>> +                   DMA_RESV_USAGE_BOOKKEEP);
>> +    }
>> +}
>> +
>>   /**
>>    * amdgpu_vm_update_range - update a range in the vm page table
>>    *
>> @@ -916,8 +954,8 @@ int amdgpu_vm_update_range(struct amdgpu_device 
>> *adev, struct amdgpu_vm *vm,
>>                  struct ttm_resource *res, dma_addr_t *pages_addr,
>>                  struct dma_fence **fence)
>>   {
>> -    struct amdgpu_vm_update_params params;
>>       struct amdgpu_vm_tlb_seq_struct *tlb_cb;
>> +    struct amdgpu_vm_update_params params;
>>       struct amdgpu_res_cursor cursor;
>>       enum amdgpu_sync_mode sync_mode;
>>       int r, idx;
>> @@ -926,10 +964,8 @@ int amdgpu_vm_update_range(struct amdgpu_device 
>> *adev, struct amdgpu_vm *vm,
>>           return -ENODEV;
>>         tlb_cb = kmalloc(sizeof(*tlb_cb), GFP_KERNEL);
>> -    if (!tlb_cb) {
>> -        r = -ENOMEM;
>> -        goto error_unlock;
>> -    }
>> +    if (!tlb_cb)
>> +        return -ENOMEM;
>
> Looks like you forgot to drop the eviction lock again in the error 
> path. Or was the old code buggy?

>
> With that double checked the patch is Reviewed-by: Christian König 
> <christian.koenig@amd.com>

Ah, it got missing into removal of tlb_cb cleanup and restore process, 
will restore that.

- Shashank

>
> Regards,
> Christian.
>
>>         /* Vega20+XGMI where PTEs get inadvertently cached in L2 
>> texture cache,
>>        * heavy-weight flush TLB unconditionally.
>> @@ -948,6 +984,7 @@ int amdgpu_vm_update_range(struct amdgpu_device 
>> *adev, struct amdgpu_vm *vm,
>>       params.immediate = immediate;
>>       params.pages_addr = pages_addr;
>>       params.unlocked = unlocked;
>> +    params.needs_flush = flush_tlb;
>>       params.allow_override = allow_override;
>>         /* Implicitly sync to command submissions in the same VM before
>> @@ -1031,24 +1068,16 @@ int amdgpu_vm_update_range(struct 
>> amdgpu_device *adev, struct amdgpu_vm *vm,
>>       }
>>         r = vm->update_funcs->commit(&params, fence);
>> +    if (r)
>> +        goto error_free;
>>   -    if (flush_tlb || params.table_freed) {
>> -        tlb_cb->vm = vm;
>> -        if (fence && *fence &&
>> -            !dma_fence_add_callback(*fence, &tlb_cb->cb,
>> -                       amdgpu_vm_tlb_seq_cb)) {
>> -            dma_fence_put(vm->last_tlb_flush);
>> -            vm->last_tlb_flush = dma_fence_get(*fence);
>> -        } else {
>> -            amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
>> -        }
>> +    if (params.needs_flush) {
>> +        amdgpu_vm_tlb_flush(&params, fence, tlb_cb);
>>           tlb_cb = NULL;
>>       }
>>     error_free:
>>       kfree(tlb_cb);
>> -
>> -error_unlock:
>>       amdgpu_vm_eviction_unlock(vm);
>>       drm_dev_exit(idx);
>>       return r;
>> @@ -2391,6 +2420,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, 
>> struct amdgpu_vm *vm,
>>         mutex_init(&vm->eviction_lock);
>>       vm->evicting = false;
>> +    vm->tlb_fence_context = dma_fence_context_alloc(1);
>>         r = amdgpu_vm_pt_create(adev, vm, adev->vm_manager.root_level,
>>                   false, &root, xcp_id);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index 8efa8422f4f7..b0a4fe683352 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -257,9 +257,9 @@ struct amdgpu_vm_update_params {
>>       unsigned int num_dw_left;
>>         /**
>> -     * @table_freed: return true if page table is freed when updating
>> +     * @needs_flush: true whenever we need to invalidate the TLB
>>        */
>> -    bool table_freed;
>> +    bool needs_flush;
>>         /**
>>        * @allow_override: true for memory that is not uncached: 
>> allows MTYPE
>> @@ -342,6 +342,7 @@ struct amdgpu_vm {
>>       atomic64_t        tlb_seq;
>>       struct dma_fence    *last_tlb_flush;
>>       atomic64_t        kfd_last_flushed_seq;
>> +    uint64_t        tlb_fence_context;
>>         /* How many times we had to re-generate the page tables */
>>       uint64_t        generation;
>> @@ -611,5 +612,8 @@ void amdgpu_vm_update_fault_cache(struct 
>> amdgpu_device *adev,
>>                     uint64_t addr,
>>                     uint32_t status,
>>                     unsigned int vmhub);
>> +void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev,
>> +                 struct amdgpu_vm *vm,
>> +                 struct dma_fence **fence);
>>     #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
>> index 6e31621452de..3895bd7d176a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
>> @@ -108,7 +108,9 @@ static int amdgpu_vm_cpu_update(struct 
>> amdgpu_vm_update_params *p,
>>   static int amdgpu_vm_cpu_commit(struct amdgpu_vm_update_params *p,
>>                   struct dma_fence **fence)
>>   {
>> -    /* Flush HDP */
>> +    if (p->needs_flush)
>> +        atomic64_inc(&p->vm->tlb_seq);
>> +
>>       mb();
>>       amdgpu_device_flush_hdp(p->adev, NULL);
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> index 124389a6bf48..601df0ce8290 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> @@ -972,7 +972,7 @@ int amdgpu_vm_ptes_update(struct 
>> amdgpu_vm_update_params *params,
>>               while (cursor.pfn < frag_start) {
>>                   /* Make sure previous mapping is freed */
>>                   if (cursor.entry->bo) {
>> -                    params->table_freed = true;
>> +                    params->needs_flush = true;
>>                       amdgpu_vm_pt_free_dfs(adev, params->vm,
>>                                     &cursor,
>>                                     params->unlocked);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
>> index 349416e176a1..66e8a016126b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
>> @@ -126,6 +126,10 @@ static int amdgpu_vm_sdma_commit(struct 
>> amdgpu_vm_update_params *p,
>>         WARN_ON(ib->length_dw == 0);
>>       amdgpu_ring_pad_ib(ring, ib);
>> +
>> +    if (p->needs_flush)
>> +        atomic64_inc(&p->vm->tlb_seq);
>> +
>>       WARN_ON(ib->length_dw > p->num_dw_left);
>>       f = amdgpu_job_submit(p->job);
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
>> new file mode 100644
>> index 000000000000..51cddfa3f1e8
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
>> @@ -0,0 +1,112 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>> +/*
>> + * Copyright 2023 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person 
>> obtaining a
>> + * copy of this software and associated documentation files (the 
>> "Software"),
>> + * to deal in the Software without restriction, including without 
>> limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, 
>> sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom 
>> the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be 
>> included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>> EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>> MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO 
>> EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>> DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>> OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>> USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + */
>> +
>> +#include <linux/dma-fence.h>
>> +#include <linux/workqueue.h>
>> +
>> +#include "amdgpu.h"
>> +#include "amdgpu_vm.h"
>> +#include "amdgpu_gmc.h"
>> +
>> +struct amdgpu_tlb_fence {
>> +    struct dma_fence    base;
>> +    struct amdgpu_device    *adev;
>> +    struct dma_fence    *dependency;
>> +    struct work_struct    work;
>> +    spinlock_t        lock;
>> +    uint16_t        pasid;
>> +
>> +};
>> +
>> +static const char *amdgpu_tlb_fence_get_driver_name(struct dma_fence 
>> *fence)
>> +{
>> +    return "amdgpu tlb fence";
>> +}
>> +
>> +static const char *amdgpu_tlb_fence_get_timeline_name(struct 
>> dma_fence *f)
>> +{
>> +    return "amdgpu tlb timeline";
>> +}
>> +
>> +static void amdgpu_tlb_fence_work(struct work_struct *work)
>> +{
>> +    struct amdgpu_tlb_fence *f = container_of(work, typeof(*f), work);
>> +    int r;
>> +
>> +    if (f->dependency) {
>> +        dma_fence_wait(f->dependency, false);
>> +        dma_fence_put(f->dependency);
>> +        f->dependency = NULL;
>> +    }
>> +
>> +    r = amdgpu_gmc_flush_gpu_tlb_pasid(f->adev, f->pasid, 2, true, 0);
>> +    if (r) {
>> +        dev_err(f->adev->dev, "TLB flush failed for PASID %d.\n",
>> +            f->pasid);
>> +        dma_fence_set_error(&f->base, r);
>> +    }
>> +
>> +    dma_fence_signal(&f->base);
>> +    dma_fence_put(&f->base);
>> +}
>> +
>> +static const struct dma_fence_ops amdgpu_tlb_fence_ops = {
>> +    .use_64bit_seqno = true,
>> +    .get_driver_name = amdgpu_tlb_fence_get_driver_name,
>> +    .get_timeline_name = amdgpu_tlb_fence_get_timeline_name
>> +};
>> +
>> +void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct 
>> amdgpu_vm *vm,
>> +                struct dma_fence **fence)
>> +{
>> +    struct amdgpu_tlb_fence *f;
>> +
>> +    f = kmalloc(sizeof(*f), GFP_KERNEL);
>> +    if (!f) {
>> +        /*
>> +         * We can't fail since the PDEs and PTEs are already 
>> updated, so
>> +         * just block for the dependency and execute the TLB flush
>> +         */
>> +        if (*fence)
>> +            dma_fence_wait(*fence, false);
>> +
>> +        amdgpu_gmc_flush_gpu_tlb_pasid(adev, vm->pasid, 2, true, 0);
>> +        *fence = dma_fence_get_stub();
>> +        return;
>> +    }
>> +
>> +    f->adev = adev;
>> +    f->dependency = *fence;
>> +    f->pasid = vm->pasid;
>> +    INIT_WORK(&f->work, amdgpu_tlb_fence_work);
>> +    spin_lock_init(&f->lock);
>> +
>> +    dma_fence_init(&f->base, &amdgpu_tlb_fence_ops, &f->lock,
>> +               vm->tlb_fence_context, atomic64_read(&vm->tlb_seq));
>> +
>> +    /* TODO: We probably need a separate wq here */
>> +    dma_fence_get(&f->base);
>> +    schedule_work(&f->work);
>> +
>> +    *fence = &f->base;
>> +}
>
