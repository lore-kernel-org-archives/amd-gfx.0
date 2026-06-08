Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A594BCD8C8E
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2026 07:25:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45C5C10E0C2;
	Mon,  8 Jun 2026 07:25:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SpwLGlDv";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012066.outbound.protection.outlook.com
 [40.93.195.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1258010E0C2
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2026 07:25:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AX8GuMj+mUsnK4+nVAs45CnWztXTmtYaUTGGv4ozWTIMOWwi2QAGokY1GFmkA1J4M+xOD+djDWFPsnhqAYfrExtcNl4mbCwKHHPQwlmy2BDSEZ/qXrNL44PdNWc8Bkrttu4n5R4ZpnXls4LwLMNPeJX/afjOZCjvK4q8n3N/E2qnHi+2WW/3/0dp2W/sRf2S5ksCbQGFIxNob1gOxEZeuWRhzuMjsx1tRiFomkW119GE+4pThrFhaSbr+CtINlDPiFBbYaqfFXnMlVEw5X7vamBmhdrmjMsKxpR2rNgjMoSZXMkkRfbQVKDf3u8xICv1fRhtubYzFBGynzk1wnmr2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DnvZQBTag3eUeR5sXcTCNT5MbtQwwNWiR9eMBGHJ2E=;
 b=CQSolY8n2tEFJQ68/Uxhq1JpiQS4cUjPNsaq7XFMR6DlMNxvDA+ZbwDXdjunicy5fFpgKUw6F/xoHhMlS/gdk1QzVfDHkCTKEvefScWT+0eyPZVsw9XB+b/xPsSSF8YEeE4ul1wn2uNG5xJx+bqji0ERI1eEvD9aclDrvV7jTJ8kjZ5MxePFWLCdPwbHVVmdoFgi4eE+dpKdh+Kc9oMxobc1hSLHF4roLbl1r+CdNLiaPQunTF2SdeK7HqKBojV2ny101CJwcoeumoObDzPvTFY4Li13dELUTr2cbtUNBqRJGGCQZwepLHKyCtLridUbaF98L20kGR23wchEp/bEBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DnvZQBTag3eUeR5sXcTCNT5MbtQwwNWiR9eMBGHJ2E=;
 b=SpwLGlDvowS5Xyqov2iEHBn9Sanjnbz6JjZoS61srOLHL7duJhzUmtJN7yRHIhL7xesL12/+XjhdQNWoZVNjukUSB3XWdhAdacM6Erwe6e78NYc8N797Y+X1jIKDJqWDhwp13QUeU5pd3bei+QQsW0fV395bVeWOdFmyRZ9bLmc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CY5PR12MB6525.namprd12.prod.outlook.com (2603:10b6:930:32::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Mon, 8 Jun 2026
 07:25:40 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 07:25:39 +0000
Message-ID: <70051591-bce7-4a0a-86d6-b9a949a41069@amd.com>
Date: Mon, 8 Jun 2026 12:55:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/gfx: fix cleaner shader IB buffer overflow
To: Alex Deucher <alexdeucher@gmail.com>, Asad Kamal <asad.kamal@amd.com>
Cc: amd-gfx@lists.freedesktop.org, hawking.zhang@amd.com, le.ma@amd.com,
 shiwu.zhang@amd.com, alexander.deucher@amd.com, kevinyang.wang@amd.com,
 srinivasan.shanmugam@amd.com
References: <20260605154920.1314590-1-asad.kamal@amd.com>
 <CADnq5_MO7q3E99QZhkLqYGAJP8m6kH7Mf2ATkut6kPikehB10g@mail.gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_MO7q3E99QZhkLqYGAJP8m6kH7Mf2ATkut6kPikehB10g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0315.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21a::16) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CY5PR12MB6525:EE_
X-MS-Office365-Filtering-Correlation-Id: 886c1661-ba91-4c1d-bb1c-08dec52f2459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|11063799006|4143699003|56012099006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: oNnnOtLq8FCSdGEcJ7j/JJKvFQk8MGxiaILy7UJvT8Vgzlu1aOQLprbPF09a12MUivKCfrTw9E4vD3n0a6wHEBnIpszDSJEdZnJ9KYj5qtuGf2yhrqfnkNKPfU3hQHFAah26Wq4RaPAk0ezTvT/K+a8wjenHaub5wIlecWVgBlmsvCHXgQVlZADjgBeU/4RfzCkj4D08nkPpH/PiwIyjsZPsuFFDWQDOG3Bf5oLIzAfpRIMNuLwHo1Hvyq1Y7NJCtDxqRM94m+l/bRtWaBO0TEfBco3Eo0PgXUxn0XtkWbVOHP2k7Cj4K1TW9hHXcDiBewPSFBV04WsYF3bf1ogComr13bER0oly4k5MTev7f0gpQmKxyuBrR0mB9EQ8ow6UK8FtFeaEF5cY+M97sfZZSPkLEhllB2k3eyzsiJia1UOTkfJS+QoU0wgbTQlq23zTf1/mwVkJ/Q9bYpL5IMZhPECrmwCGnPpxxGC+5eVqVLYzqcMciJNS7AjIuj4Bk401XFGbk+/90X2r84VOZnrchoRHEG9AVzdh61/sbSPe3TIc5D/nfMe1e9AoTkVx1VZd0f3xIsMnu06blCFzlqTIafEkQbObMCCpBcP5rkKeCOO8/HQgQEZVv5xpt8C9p+GjtPCi8yojAFdL2qfnGZirNig9In0izFLBxDAruvSjghM2tkY53T3llOI6npmwzfYa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHJIQWZVb1VQQjN4MElzUThvQjFxRGxHRDcxTUZJQjV5WUNvd2ptb0o2b1dH?=
 =?utf-8?B?ZVdGZEIra3RWem53dDRNUythaFBaSTUwZkJtSmc0WllRRCtldVlWSGhqZHMv?=
 =?utf-8?B?ejFzOW1NbW5ScW1WdkdWcnJYbVlhdnZLYmx6VVBKcVd6U2R4Y1BGcFpBM3dt?=
 =?utf-8?B?NTc1cnZiNHJ0S09hZ2llL0hYTWt4MWk2cmZ6Z2JnZFNJK281Myt5Q3Fyc3ZO?=
 =?utf-8?B?c1NDM2NXN0JqYVFoMHowWkhzSXlxaWttUDc3czNVQ1UyRVVoRFVLSEtaRVc0?=
 =?utf-8?B?aU42eWw0NWVPVFBwd2graVlkVmY4Ny8yMW81WHV2TnJ2WnRlY1g0U3NsaTFV?=
 =?utf-8?B?UFVYSXZCK1RxZW9KaXBnTWs2dTRaZDdORm1VOXhMVFZ0dXFDWmJGblJRc1BB?=
 =?utf-8?B?UGVCcFUrVkRNN09VT1lIYTZkN3dHMUVLQU9hTlFDd1ZFcklGUldUMENWdzd3?=
 =?utf-8?B?NDdaUnBweVRQNkRSMUd6QUxUdWIydnEwMVZqUnA4VWw1eTNCZ3AyYW51emgz?=
 =?utf-8?B?bWlLMSthQmJDOGFRTkVBQXM2QkducFI1elpiemNIaDB1UHdVVnFTbGtQaUZG?=
 =?utf-8?B?Mm5GM3RobmZhMnIvOStTY1kwb05BMDlLMnhKWHVVK20raFdqVjlEVmlEdjh0?=
 =?utf-8?B?SU1FQ1p0OE9XYXpvQTdxNHZoUkN6Q3Uvem5RVmhUNDBpdHVRb3lNTm16K2Rt?=
 =?utf-8?B?VW1ydGI5SmdRUWpBMjliUGdqdlNyT1BOUjNKWEZ4T2F3cFltdzNZZTUvWnlk?=
 =?utf-8?B?dDlJSlNRWlBLOE5BaExkLzJuN0xzM004azJFaHhSa29zZGk0VmZvT2QyVUk3?=
 =?utf-8?B?QW5SRnpaTTF2WlZFU3YyOUZOVFNuWTQyQTNKZ3ZUdnFsMG9nVEZZR0s2UmNL?=
 =?utf-8?B?SzJaVzhzZ0pqMWhoY042ckhybWYxaG1MZS9LRm1JRGtid2FpWUIvM1NOVnA3?=
 =?utf-8?B?N1FnSkxCLzdTL1pVMVREenRIWloxbUtaQWpNWnZsQ3RXbVB6aUd3bk5Ddld0?=
 =?utf-8?B?cjFmbHhBNnlnWFlNNzFzc2EzN05kc0N1L250cXVTTmxaZUJIVzA1aWRGU3pE?=
 =?utf-8?B?MytBRTJSMmRBd1dMbHBta1dBVG9sQjRFRmllSW15R0pibnkrSkNHa21kTVMw?=
 =?utf-8?B?bUQ5OFdQVVhXTmdLMWp6MW0xS1BlTFlJVVZ2ZmpBVGw1WVllVjdXc3ovS1lR?=
 =?utf-8?B?bXA2bW5UNHc5VnZVdEtQSTBIanROM3hMM0tGUjVZUzdOSjN5M0xmN2RGd3Bk?=
 =?utf-8?B?RVNlMDMxTklSenlPb0U4dlNROXRMcStBUVFPeVlObmNuL3FjT1JoOXVjYjdy?=
 =?utf-8?B?V2lrZHkvQkhrdXZnb0xNcTdJWmRvZlFVSUEvNXg3a3I5Zi95ZDF5clRlR0Jy?=
 =?utf-8?B?blVJQUFQSlVQelZLb0h0R2pZN1VOc3d2cHFTcmpqM3Z4YTBrVlNuOFlvU2hN?=
 =?utf-8?B?MlJVMHhkZk9PQVZPcUlMSmovbEFvQTMxR1RGbXVEMWNLN3BQMUJSZk4wRU9N?=
 =?utf-8?B?bDl6Zy83YU4waE1qaEpuTnFXYVgwVTZrbkpmWkkvVGtQWUcxZUV3ZjFYMVUr?=
 =?utf-8?B?SHRTdWwzajFxS1VQN3FzdlBLUWJ3cGRwSXFzWEwyblhtUHB5ZzdjMmZoNG1q?=
 =?utf-8?B?czkyWXQ3Z3EvVlRLTUMvYkVoUE8zOUpMYXRIZUM3VU40ajZUeWFUWTVraEdU?=
 =?utf-8?B?bXpkTUVWRlZOQnl4Z2NNWVFxelpvcHFQTHR2NHQvYnBscVorb3NRQ0h6WWtT?=
 =?utf-8?B?VkFNVldmT21zTmRpLzBWQVlSQm5kZU9wUGR5aGkrcEsrRFdSdmtTTVFjdjJ5?=
 =?utf-8?B?OFpvRWJ2N2tXZ25ZUkgvdEgwL0Zrcis1ZFUvZDRyZzFJWllCM0xXdEtSSGRF?=
 =?utf-8?B?KzlWRkpiT1JxVHpGSUt5ZnVTdDNxYmVYajY4WDdhZllLbU9GMW1nei94TmV4?=
 =?utf-8?B?RW1EUTV5ZCtORDlVZ1RsaFJmNjl3bDBYVnRRaFVHRTY3ZzB0Y1VPZnNmOENZ?=
 =?utf-8?B?NTJDV2lybGZaNkZVdDZteXNmOEQ4M0Vnd2FHTjBLcXlPdHcwSlBXaFplbnpU?=
 =?utf-8?B?dFJqOVJFN0UyYXdweGpFWGtJVEFZbEpwbEZXd1NNT2NjN0hCdTJ5U3kzNm91?=
 =?utf-8?B?K0lpVEYzUjRKbWsxZ2RPNDVDNllKZkZlV09NZTJUdEovcVMwdHNNZmw1OGZy?=
 =?utf-8?B?T1ZJQ3FXeG43WW1JL0RYN1ZNZFRySUdmaEIrcUJ2K29leEQ2SWUwQUhDb1hy?=
 =?utf-8?B?V3YzNG5BdEF2elZHVzRCUjhERkZFUXhwdWR3OWdseCtWM1BNSmlrOXZEMUFk?=
 =?utf-8?B?Wnl5MWFrYnorVlVSU09qZ0dHdnJYWlVvYk5jZUVMcCsrZGxJeFJsdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 886c1661-ba91-4c1d-bb1c-08dec52f2459
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 07:25:39.8639 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bM7rrNRJx68dHAMfl0byu4IIhoZR4jWClGpf+EnIFe7DWxCmzDudlb63qK9DUzwx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6525
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



On 06-Jun-26 1:30 AM, Alex Deucher wrote:
> On Fri, Jun 5, 2026 at 11:59 AM Asad Kamal <asad.kamal@amd.com> wrote:
>>
>> The cleaner shader sysfs path allocates a 16-dword (64 byte) IB but
>> incorrectly fills (align_mask + 1) dwords. On GFX rings align_mask is
>> 0xff, so the loop wrote 256 dwords into a 64-byte buffer, causing a
>> kernel page fault.
> 
> It would be better to set the job alloc size to
> ring->funcs->align_mask + 1.  The whole point of the align mask is to
> align to the hardware's fetch boundary.
> 

Hi Alex,

This is for IB packet. Is this a restriction from the FW? For 9.4.3, CP 
team mentioned that hardware doesn't have any such restriction.

As a side note (not related to IB), within the primary queue, the 
default RPTR_BLOCK_SIZE is 64DWs - block size granularity for RPTR updates.

Thanks,
Lijo

> Alex
> 
>>
>> The IB only needs to be a minimal NOP shell to schedule the job; the
>> cleaner shader itself is emitted on the ring via emit_cleaner_shader().
>> Fill 16 dwords to match the allocation.
>>
>> Fixes: d361ad5d2fc0 ("drm/amdgpu: Add sysfs interface for running cleaner shader")
>>
>> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
>> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> index ff5a55f5f3c9..f2c536929446 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> @@ -1694,7 +1694,7 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
>>          struct amdgpu_job *job;
>>          struct amdgpu_ib *ib;
>>          void *owner;
>> -       int i, r;
>> +       int r;
>>
>>          /* Initialize the scheduler entity */
>>          r = drm_sched_entity_init(&entity, DRM_SCHED_PRIORITY_NORMAL,
>> @@ -1722,9 +1722,8 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
>>          job->run_cleaner_shader = true;
>>
>>          ib = &job->ibs[0];
>> -       for (i = 0; i <= ring->funcs->align_mask; ++i)
>> -               ib->ptr[i] = ring->funcs->nop;
>> -       ib->length_dw = ring->funcs->align_mask + 1;
>> +       memset32(ib->ptr, ring->funcs->nop, 16);
>> +       ib->length_dw = 16;
>>
>>          f = amdgpu_job_submit(job);
>>
>> --
>> 2.46.0
>>

