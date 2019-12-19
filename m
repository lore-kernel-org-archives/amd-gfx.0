Return-Path: <SRS0=793y=2J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4AFC43603
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 03:13:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4060F21D7D
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 03:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WbYsDMU7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4060F21D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D18706E072;
	Thu, 19 Dec 2019 03:13:21 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 138506E072
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2019 03:13:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WuS1XfcGf+3ZCPkBBd1L11ZOo4FrhTE+QVQD8syx9Jnhb2eQCw79MUUCpSc94OP1TzfEHKc1KVNgeyRoCkpsIvCbJ5XevRIarvYp8GQelEW4uXTEqcEyq6AuA+V7J2oM8zl8Nqkziiym7hCutj3V72v6k+yp5DQhZ0XdHbBWLMZXEQMw2ovM5nbO0ZSOfqN1rjE1JZASS2jfBHVXUkND/ssU+IpvhOOetyy2dJQagYY1vM4eWte0R1Se72xW49ihFCMrhRSTEujmTrN2A5i/FbTe3hBAYmEqmXmq7MKE6Koe8+OHNp6OhOeiTj39kgTXN6OZ6EOKC4IMRK/Yd++ROA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkumE1SlwPz+uYGV3+pGrjD9tnlWme4IuOIaY7KHz54=;
 b=Qx0qTpIpWO5ku9USZ9vJC0OYxwYHtYRMLctfoT2hxW+zV/a7sulT5sJMX4N1CC6n539BmiL4OAO5g5DdBvNx4kaZLSuKVJ/DTConTK2S24unfE8X+3o/BuTU8yDVMZ+r4hOPz6ztnyQ9BhynqAiMNyUdhc0TxuNu2K+ONK4hyTITDKlb/exW3BRmwjjz8Jih1T5zzEKCE+XP1vVQsAyOLoBEn9uGuM/b3vRYwg5LGeAhmygRS8UAjJbKCS3v0gUWXBFt0irdNvdQkC9SQDvR53/tbjEl+VnDcdpeNHSYXJpQIbN3TvLmsyTlr1hANxCDJJNLGZrIA2mmnuM2OHKtzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkumE1SlwPz+uYGV3+pGrjD9tnlWme4IuOIaY7KHz54=;
 b=WbYsDMU7btqoOpyWRXtZdvogVtg/NpYaVThT+yC6qjWRBnbZGszDZ6QyP+3OuZ9JzYXV5T2sAI8U+tm8r0KvPNoqalcaeWrbEaTMFpWdBNKlx9mH1e0SqndaHjoQ7acgp8vRbmlaI5BRtcZZC4udNfRJUjcPZN3QLs7RROnOeWo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (20.178.29.90) by
 DM6PR12MB2601.namprd12.prod.outlook.com (20.176.117.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.15; Thu, 19 Dec 2019 03:13:17 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::799b:b372:6589:c8a]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::799b:b372:6589:c8a%7]) with mapi id 15.20.2538.019; Thu, 19 Dec 2019
 03:13:17 +0000
Subject: Re: [PATCH] drm/amdgpu: simplify padding calculations (v3)
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20191218231217.204500-1-luben.tuikov@amd.com>
 <001a6842-50cb-dd1f-2adb-1cd24f03afec@amd.com>
 <MWHPR12MB13583FE24170AEBBBD3DD450F7520@MWHPR12MB1358.namprd12.prod.outlook.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <dbf6fb2b-916b-326d-5319-acadda0aaa4c@amd.com>
Date: Wed, 18 Dec 2019 22:13:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
In-Reply-To: <MWHPR12MB13583FE24170AEBBBD3DD450F7520@MWHPR12MB1358.namprd12.prod.outlook.com>
Content-Language: en-CA
X-ClientProxiedBy: YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22)
 To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 164152cb-fc90-44f6-6f96-08d784316487
X-MS-TrafficTypeDiagnostic: DM6PR12MB2601:|DM6PR12MB2601:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB26016551695B35B49AA3176B99520@DM6PR12MB2601.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0256C18696
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(39860400002)(376002)(136003)(366004)(189003)(199004)(13464003)(26005)(6512007)(2906002)(31696002)(6486002)(86362001)(4001150100001)(31686004)(186003)(110136005)(2616005)(36756003)(44832011)(53546011)(6506007)(66476007)(66556008)(66946007)(316002)(8936002)(81156014)(8676002)(81166006)(52116002)(478600001)(5660300002)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2601;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: weSOgJSeuXDsFxmaUFCUe/FNskc/QOx1Sb47WKOXnp38X3D95MLkpUWfdl+dhW3kfKp468psuYrrncAVTkSiIfaPIUa3Au7otIfyNHC5D0OnpHftfLu2N3QrOnOJqpvDfSrdUgJ2j8DGAaGORGQTNtr0N1nkXwOV3GnQ69HKkT3XAimlJosduDP3pj43hAAHZfiMHqJEIQ6UZqFGW8F9jWBqdhUfDfUkBC1K2JRKVClijISm/xbCUEiQOCR1EMc43Hd/HzptWia1fceXOoFRkeYx9PDXW7YtSl+TlUJtDs73YjH3E1R74uwXxZjaLHsHISo8kTtyZLm6bST6HitS1fcCIkJADWqanF6xYLrsE8wiZUM6kuJbLzM/cYsMl29CHnbLE4qETPK/PumDOOE5coc6kWV2e8LLRZSGFDWNrzr3231yazd8xZBYccTP9eGuiqmsxDiriSE5ngDo982sSYXPEoAtT/ecZgP5LoqDyn+08xDyA1oIhdsTpG32vHwL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 164152cb-fc90-44f6-6f96-08d784316487
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2019 03:13:17.3084 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K+3GshgiCsq3Qn56JmB/Haj04/1Ku5OTd3bntiu3GoPGHZ2NIIzb2kDj5/uNMzGU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2601
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
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2019-12-18 9:59 p.m., Deucher, Alexander wrote:
>> -----Original Message-----
>> From: Tuikov, Luben <Luben.Tuikov@amd.com>
>> Sent: Wednesday, December 18, 2019 6:17 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: simplify padding calculations (v3)
>>
>> This patch seems to have been dropped after posting and reposting. I'm not
>> sure why it keeps being dropped.
> 
> Dropped from what?  Once it's been reviewed, add the RBs and go ahead and push it to amd-staging-drm-next.

Oh, thanks!

I seem to forget about this push to refs/for/amd-staging-drm-next.
I'll write it on a post-it note so I can remember.

Okay, so then that's what I need to do.

Regards,
Luben

> 
> Alex
> 
>>
>> In v3, I added an explanation in the commit text below the original commit
>> text of the single sentence of "Simplify padding calculations." Identical
>> diffstat as v2.
>>
>> Regards,
>> Luben
>>
>> On 2019-12-18 6:12 p.m., Luben Tuikov wrote:
>>> Simplify padding calculations.
>>>
>>> 1. Taking the remainder of a binary value when the divisor is a power
>>> of two, such as, a % 2^n is identical to, a & (2^n - 1) in base-2
>>> arithmetic, and so expressions like this:
>>>
>>> (12 - (lower_32_bits(ring->wptr) & 7)) % 8
>>>
>>> are superflous. And can be reduced to a single remainder-taking
>>> operation.
>>>
>>> 2. Subtracting the remainder modulo 8 out of 12 and then again taking
>>> the remainder modulo 8, yields the same result as simply subtracting
>>> the value out of 4 and then taking the remainder.
>>> This is true because 4 belongs to the congruence
>>> (residue) class {4 + 8*k}, k in Z. (So using,  {..., -12, -4, 4, 12,
>>> 20, ...}, would yield  the same final result.
>>>
>>> So the above expression, becomes,
>>>
>>> (4 - lower_32_bits(ring->wptr)) & 7
>>>
>>> 3. Now since 8 is part of the conguence class
>>> {0 + 8*k}, k in Z, and from 1) and 2) above, then,
>>>
>>> (8 - (ib->length_dw & 0x7)) % 8
>>>
>>> becomes, simply,
>>>
>>> (-ib->length_dw) & 7.
>>>
>>> This patch implements all of the above in this code.
>>>
>>> v2: Comment update and spacing.
>>> v3: Add 1, 2, 3, above, in this commit message.
>>>
>>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/cik_sdma.c  |  4 ++--
>>> drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c |  4 ++--
>>> drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c |  4 ++--
>>> drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c |  4 ++--
>>> drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 17 ++++++++++++-----
>>>  5 files changed, 20 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>>> b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>>> index 1f22a8d0f7f3..4274ccf765de 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>>> @@ -228,7 +228,7 @@ static void cik_sdma_ring_emit_ib(struct
>> amdgpu_ring *ring,
>>>  	u32 extra_bits = vmid & 0xf;
>>>
>>>  	/* IB packet must end on a 8 DW boundary */
>>> -	cik_sdma_ring_insert_nop(ring, (12 - (lower_32_bits(ring->wptr) &
>> 7)) % 8);
>>> +	cik_sdma_ring_insert_nop(ring, (4 - lower_32_bits(ring->wptr)) & 7);
>>>
>>>  	amdgpu_ring_write(ring,
>> SDMA_PACKET(SDMA_OPCODE_INDIRECT_BUFFER, 0, extra_bits));
>>>  	amdgpu_ring_write(ring, ib->gpu_addr & 0xffffffe0); /* base must
>> be
>>> 32 byte aligned */ @@ -811,7 +811,7 @@ static void
>> cik_sdma_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
>>>  	u32 pad_count;
>>>  	int i;
>>>
>>> -	pad_count = (8 - (ib->length_dw & 0x7)) % 8;
>>> +	pad_count = (-ib->length_dw) & 7;
>>>  	for (i = 0; i < pad_count; i++)
>>>  		if (sdma && sdma->burst_nop && (i == 0))
>>>  			ib->ptr[ib->length_dw++] =
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>>> index 606b621145a1..fd7fa6082563 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>>> @@ -255,7 +255,7 @@ static void sdma_v2_4_ring_emit_ib(struct
>> amdgpu_ring *ring,
>>>  	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
>>>
>>>  	/* IB packet must end on a 8 DW boundary */
>>> -	sdma_v2_4_ring_insert_nop(ring, (10 - (lower_32_bits(ring->wptr) &
>> 7)) % 8);
>>> +	sdma_v2_4_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) &
>>> +7);
>>>
>>>  	amdgpu_ring_write(ring,
>> SDMA_PKT_HEADER_OP(SDMA_OP_INDIRECT) |
>>>  			  SDMA_PKT_INDIRECT_HEADER_VMID(vmid & 0xf));
>> @@ -750,7 +750,7 @@
>>> static void sdma_v2_4_ring_pad_ib(struct amdgpu_ring *ring, struct
>> amdgpu_ib *ib
>>>  	u32 pad_count;
>>>  	int i;
>>>
>>> -	pad_count = (8 - (ib->length_dw & 0x7)) % 8;
>>> +	pad_count = (-ib->length_dw) & 7;
>>>  	for (i = 0; i < pad_count; i++)
>>>  		if (sdma && sdma->burst_nop && (i == 0))
>>>  			ib->ptr[ib->length_dw++] =
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>>> index a559573ec8fd..4a8a7f0f3a9c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>>> @@ -429,7 +429,7 @@ static void sdma_v3_0_ring_emit_ib(struct
>> amdgpu_ring *ring,
>>>  	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
>>>
>>>  	/* IB packet must end on a 8 DW boundary */
>>> -	sdma_v3_0_ring_insert_nop(ring, (10 - (lower_32_bits(ring->wptr) &
>> 7)) % 8);
>>> +	sdma_v3_0_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) &
>>> +7);
>>>
>>>  	amdgpu_ring_write(ring,
>> SDMA_PKT_HEADER_OP(SDMA_OP_INDIRECT) |
>>>  			  SDMA_PKT_INDIRECT_HEADER_VMID(vmid & 0xf));
>> @@ -1021,7 +1021,7
>>> @@ static void sdma_v3_0_ring_pad_ib(struct amdgpu_ring *ring, struct
>> amdgpu_ib *ib
>>>  	u32 pad_count;
>>>  	int i;
>>>
>>> -	pad_count = (8 - (ib->length_dw & 0x7)) % 8;
>>> +	pad_count = (-ib->length_dw) & 7;
>>>  	for (i = 0; i < pad_count; i++)
>>>  		if (sdma && sdma->burst_nop && (i == 0))
>>>  			ib->ptr[ib->length_dw++] =
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>> index bd9ed33bab43..c69df0cb21ec 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>> @@ -698,7 +698,7 @@ static void sdma_v4_0_ring_emit_ib(struct
>> amdgpu_ring *ring,
>>>  	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
>>>
>>>  	/* IB packet must end on a 8 DW boundary */
>>> -	sdma_v4_0_ring_insert_nop(ring, (10 - (lower_32_bits(ring->wptr) &
>> 7)) % 8);
>>> +	sdma_v4_0_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) &
>>> +7);
>>>
>>>  	amdgpu_ring_write(ring,
>> SDMA_PKT_HEADER_OP(SDMA_OP_INDIRECT) |
>>>  			  SDMA_PKT_INDIRECT_HEADER_VMID(vmid & 0xf));
>> @@ -1579,7 +1579,7
>>> @@ static void sdma_v4_0_ring_pad_ib(struct amdgpu_ring *ring, struct
>> amdgpu_ib *ib
>>>  	u32 pad_count;
>>>  	int i;
>>>
>>> -	pad_count = (8 - (ib->length_dw & 0x7)) % 8;
>>> +	pad_count = (-ib->length_dw) & 7;
>>>  	for (i = 0; i < pad_count; i++)
>>>  		if (sdma && sdma->burst_nop && (i == 0))
>>>  			ib->ptr[ib->length_dw++] =
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>>> index 119364293cec..3912937f878f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>>> @@ -382,8 +382,15 @@ static void sdma_v5_0_ring_emit_ib(struct
>> amdgpu_ring *ring,
>>>  	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
>>>  	uint64_t csa_mc_addr = amdgpu_sdma_get_csa_mc_addr(ring,
>> vmid);
>>>
>>> -	/* IB packet must end on a 8 DW boundary */
>>> -	sdma_v5_0_ring_insert_nop(ring, (10 - (lower_32_bits(ring->wptr) &
>> 7)) % 8);
>>> +	/* An IB packet must end on a 8 DW boundary--the next dword
>>> +	 * must be on a 8-dword boundary. Our IB packet below is 6
>>> +	 * dwords long, thus add x number of NOPs, such that, in
>>> +	 * modular arithmetic,
>>> +	 * wptr + 6 + x = 8k, k >= 0, which in C is,
>>> +	 * (wptr + 6 + x) % 8 = 0.
>>> +	 * The expression below, is a solution of x.
>>> +	 */
>>> +	sdma_v5_0_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) &
>>> +7);
>>>
>>>  	amdgpu_ring_write(ring,
>> SDMA_PKT_HEADER_OP(SDMA_OP_INDIRECT) |
>>>  			  SDMA_PKT_INDIRECT_HEADER_VMID(vmid & 0xf));
>> @@ -1076,10 +1083,10
>>> @@ static void sdma_v5_0_vm_set_pte_pde(struct amdgpu_ib *ib,  }
>>>
>>>  /**
>>> - * sdma_v5_0_ring_pad_ib - pad the IB to the required number of dw
>>> - *
>>> + * sdma_v5_0_ring_pad_ib - pad the IB
>>>   * @ib: indirect buffer to fill with padding
>>>   *
>>> + * Pad the IB with NOPs to a boundary multiple of 8.
>>>   */
>>>  static void sdma_v5_0_ring_pad_ib(struct amdgpu_ring *ring, struct
>>> amdgpu_ib *ib)  { @@ -1087,7 +1094,7 @@ static void
>>> sdma_v5_0_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib
>>>  	u32 pad_count;
>>>  	int i;
>>>
>>> -	pad_count = (8 - (ib->length_dw & 0x7)) % 8;
>>> +	pad_count = (-ib->length_dw) & 0x7;
>>>  	for (i = 0; i < pad_count; i++)
>>>  		if (sdma && sdma->burst_nop && (i == 0))
>>>  			ib->ptr[ib->length_dw++] =
>>>
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
