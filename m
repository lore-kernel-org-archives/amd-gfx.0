Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BB3CD8CB9
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 07:09:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3393810E23A;
	Thu, 11 Jun 2026 07:09:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RsEvn/FN";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012003.outbound.protection.outlook.com
 [40.107.200.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0FC810E23A
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 07:09:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wygTO6O6lg+DvSA3v742NeiU20xTd+CigVlPIWOm3PlfhG0hmBHsES7TZrwbuUTki55H6juyXzvwBV+4QFdhZeJebruKADcs3tHwdosPd6n4pE+W/Jo1ndIhFCM+Mua0sq6lqk4tD2w4C5JletnyaS8b5lCpCmS7h9imM/T6CLvBMS+EArVFcnJtqz6W3go9XKb49C3Mxn3zqJe8P0GZ3HgjLxmM1ErFw6X5SMmkIAT54tGsU/s58pkVyGLMT8tkO6iBN0f2AxFIll5TOoLzUaTJldLjaROuLMw/Eww7OUMgrMB6pF13d/MAqcawDBdgTz3OGdHTTPJRVfVNTi439g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgQT/NZzmAUaDM6cPOgLUZZilAV6mcN1cQFqwu3vtrY=;
 b=qx6rlumaOC8NpXMQIv49no1LVs3t02hfnAKxx0JvPFTlZ0+kCHJ5HWBGD0rhqz9E3yWizniI8iIl/Dig4b0s7cOPLQa6QPiH0EIEmSKUorRWBk1EfkvLUrAfBYjOiYohS3df7XsMF2NSx/U7Ffab8HVG9DgazH2gFu+qRiMZP/ehbpyd08x6v3Q83BPX3Kh2ITIss94i0v2nszpcH5VjLlHJ1kma/ncY5VXECsYnrQBgtLsXkwx0gGr3W6BH4lqXJ52E3WaeRyYxzdhfHOj2KgUjEautYt42NQ8QxY1uYYbeOKO/iNDQw7wH0KnDfD4MbQ9SAmbKP/lx52MoRNIGeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgQT/NZzmAUaDM6cPOgLUZZilAV6mcN1cQFqwu3vtrY=;
 b=RsEvn/FN7rsBpAfNT4oMrXUce0+CzaNui8nIR4DlcCXEbBNFDXX35AtzE266vUPtRZmsC1YsALHIfskmZIiet/fYCkXcJEyBNCAR2D3v9Lo+O/3lWPg4FYP536Ogpf/JXNiQW5mP7ayvCTQCnmUyTMRszMyKgcDvJhObKRWosio=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by BN5PR12MB9538.namprd12.prod.outlook.com (2603:10b6:408:2ac::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Thu, 11 Jun
 2026 07:09:40 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.21.0092.011; Thu, 11 Jun 2026
 07:09:40 +0000
Message-ID: <fe555f65-8f9f-4a8c-8c9a-a2479d3f8ec4@amd.com>
Date: Thu, 11 Jun 2026 12:39:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] drm/amdgpu/gfx9: Fix Ring and IB test fail after
 mode2
To: Huang Rui <ray.huang@amd.com>, Jiqian Chen <Jiqian.Chen@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, =?UTF-8?Q?Timur_Krist=C3=B3f?=
 <timur.kristof@gmail.com>, Samuel Pitoiset <samuel.pitoiset@gmail.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Huang Trigger <Trigger.Huang@amd.com>
References: <20260611055715.1142135-1-Jiqian.Chen@amd.com>
 <aipVLOVnOxst+zTS@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <aipVLOVnOxst+zTS@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0097.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::14) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|BN5PR12MB9538:EE_
X-MS-Office365-Filtering-Correlation-Id: b23dda91-7f77-43a5-9fc0-08dec788678f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|4143699003|11063799006|56012099006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 5gfn/z+d/grCbYN/HnurQQ9p2eFgzZLdgI8/LGK7j3MdPczrDPNkoUTdIHG6UFJ9gRHXHIq5vwO6+vaYs1u1uqaxr/O6Tc384EfID8YZPEM0GzO7F3jF5ixepVKVq+Akw5Tv3GnfYIFf65U8Svil1JqtTI9Uz3owElaj6KImZRZItbvufNuzeJE9YEBfwSSJcAX8ZBEu5nTEn88qNxul2vzluWJWTGXl4fW5ZjkKg4mQvDEctaSKFhjhA8ELRGAH02BP1UEEiqF7Tuj7fmSmrdsZDzJNjkXW2cIU/Is4HbjtuTwsiJme5MoUac6LefH7wCt0LBcL6xjFoyUgrAwteUYVgojUyCKpT8c85fqH+fb1g/X6ZUiLk8ckbCLzR0AtpgeJ7UKrWd+o9STEt4ToI7XIvLGnPWo7TeMAkOUSvxPcPXSwJYnK6rQME2wmubpx3v+4b3tv1924BMxwiS1UZYtswPRin73IVyEDOmsS4c+p/5GqUWmcz1txwczusClsh+bWP/1VcjrOmJzae9E511Whu9dN23I3fX1HP2ZZdE6KVItdpQnX/qdn57uV9qBni3ch3XBEqlnhxiD09i+kEwkIr5P0WavSr8qYfXQpndH9aDLSf6GtpkSULxXuEJ7EgvFMPFNEmWwakNN8bD5M4nnHdRgd5VhFSs912fKu5Yz9nl3Wkj+yYCobeP4Gc47x
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnZ0UVhDVkFNUWZoMkpLMXUxdnBtVTZQaW9qUkJOS1NiZHZVUTB2K3RFWmxQ?=
 =?utf-8?B?d3FkRnBNczdlcHZuRGkrbU1ydlZ0Ym1lY0NGMkdvN2RtMTlnTk1XcktWNmho?=
 =?utf-8?B?aXEyQ2VCWHF5N0VNZTFZdHYxcUVsK1kxSWYzNUp4ajBCN2ViekZFRUVOeFdP?=
 =?utf-8?B?eloxOE0wVE02aXIvWm9OWkpkWVR2Vm0xaEEzdzlUWUdCTHRsb0VTU1J4M1N2?=
 =?utf-8?B?MzZURFhTVVRncWxlY05uM3JoUVV0L2dscnZRb0NJSm5vSU8zL2VBUFpxdkR6?=
 =?utf-8?B?STk3RjRGY3RRREZNVUxjTjNieWFZRGdsczlOZUsrQi9vaE1kM2F4bkNhWWJh?=
 =?utf-8?B?RnBxZ2x2d0JwZlJNczEvaVQwNmMvcFhCNVYxbjVGb09XdTJtVkIvcnczbjFw?=
 =?utf-8?B?TjVaUWZwcU1tOFNZNE5Dc3V6T21rdnRKWjFJQXpHTEhhUU1BSG9ibUlCd3hK?=
 =?utf-8?B?YnUrNyt1K1hSVysyMDlFWWxaTzlWTzdobWJ4alg4UU9udGZpV2VmSkZENzA4?=
 =?utf-8?B?WUhjUTZCeEhmWG1jSEREMEprQ3NNZkEwdEhDbk1VdXdrYVByNlUyQUQ1ZlVn?=
 =?utf-8?B?eTN4MFpnRTVmalNmTVFvK0FqL1JYSVdnSlh0UHEwNVpRTlpoZjFENE1Obzdl?=
 =?utf-8?B?LzEwRW9zdTkya25lZUNEYmduOUVqai9LZzN0QkhsVzNLNll1Q1IrSE05SWFK?=
 =?utf-8?B?RjU5ajJ3RmN5OStlcHF6U2NTY2RVU2kySVdqN25NR01nRzh2eTc4SzdzWkJH?=
 =?utf-8?B?UG1VMlBRNnIvRXM1Q2RkV1FWOHFlL20rMUJRamdYSWdCZkxpMC83Y003aTBi?=
 =?utf-8?B?VEtuR1pFZldzNERwRXhIblQxMlZkaTdBMjcwYk45TTlKcHdkNzdSSWFEZjRO?=
 =?utf-8?B?QnF6R1JqZE1oMHlRZzFQSTlhREVMODJQV1lvM1J4NEtuVll3TC85Rjl3MGs3?=
 =?utf-8?B?SVY4Q1BIWjFGajViRWVVMGpNVUs0d09ZQWt2MXRlMEM2TnZhaXVGcUgvSmZl?=
 =?utf-8?B?UDBHTkxFR0xhWnk5SW9MZFZ3VDhaUHduN3FpQXBubThlYURZcGZnMDUzM2J2?=
 =?utf-8?B?bVJkYTNCV1B1UWhqMUxNTGRvMDBhSGR2dnIwUCszdW5USVJWbGh6aXIvbHYy?=
 =?utf-8?B?S3d4R29HQ29rSkMzYzRmVzIrSmJOQTF2VW1WTVV2dFlQQnRzQ291RDFZb3E5?=
 =?utf-8?B?UGJCN2dXY3RpMURXUGRBQXhrT3BTaTdiZ0x4dnM2WnF3WVJzMy9wZUlTdkV6?=
 =?utf-8?B?VmtUQytaTWF5SDY3d2lFU2RWaG1lQTlkNDhDRkNicnQrUFFzcWdHNEgyemFP?=
 =?utf-8?B?TlJCUXBaWDdSbk4zeG0wMlRyS2RLM2crbE0xcThLd2NrT0YyMzVtdXdpY2hE?=
 =?utf-8?B?cU1vek1Jekx4NzY4Z2ROeGJSTXFRdDlXQ3V6VEdmaUczK29PRkp3dGtLMC9v?=
 =?utf-8?B?MmdtT1NwcDVQcy9ZUytwY1piNUJSdGVDNEFUTE1FM0pUK0NWRm9pWjIxRDlK?=
 =?utf-8?B?R0dCZ2Z4enBiYnlmR2lqQzFnZnoreEE1QnNYNWVhclpnbFJsZDBwUDdPdldW?=
 =?utf-8?B?Rm12bHQ5WHFGNVg2MC9GN3JrZjh3OCtjRk9DcERaMUMwVGIyTmg4eTh1b09P?=
 =?utf-8?B?cHdxckg0ZTRicEJvUDBoQk11WUN0YlRjU1MrMU5HcStXSklkTkkwMTNMS0JU?=
 =?utf-8?B?YitJdFd5WHdNbzBXREVOd1NCWVVQT0ZIZ1JpYnU4aGhzNmkvMVlUdmdjQzA4?=
 =?utf-8?B?VjRGbFJIdHVoemRMU2ZyUlVIeGJhZC83RXR0bFBsaksvQzhXcko0Yk10bjlQ?=
 =?utf-8?B?a2dTVU9QK0o2YnY5V3FzQmQyQXp2MWNHK1ZLczk0STVGdDNtVEg1UnN4U2Nn?=
 =?utf-8?B?UFNmbFdJMTFzYklxdUZ3YkdCa09tcjBWeDJKdFlmdjI5cmNGVW1rYlc5bDdB?=
 =?utf-8?B?R1FNWlM1OXcyazdxdVBIUFc2MTFORko1V2ZYWXJBM25OSWJXWmNtdndJdU9C?=
 =?utf-8?B?NzFxdFlSRk9aN2lQWkFIaWpUVklOYm1ZOWJIMnRZYjlvQW9aRFdJOTRpOERH?=
 =?utf-8?B?c1VISlp3dkl2c1RUeE9qUlkxRUllNFdwOE5Hc0VTaTFTVGJIdlVyazlQWHFI?=
 =?utf-8?B?SlNvMzg1UWlEdFFQaWJjdVNVc3IwZGlncklSVGZJRFo5VCsreDJzSk52UWRI?=
 =?utf-8?B?RlZ4a0VOSTZvQVR6bVdEeDFiazFtNWFxWFptWWZhTVlWWHQyN2VoSTZOWjdr?=
 =?utf-8?B?RFNwUS9CMXdCbW5qTVZlTmZGb3lLR3JDUElKOE5GQjdqWHIrWi8vMmZyd3Bn?=
 =?utf-8?Q?g9Y0Qe+rFtTtIPPNrt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b23dda91-7f77-43a5-9fc0-08dec788678f
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 07:09:40.3921 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jeJqegNJmpS3zdZNpMaGxOPYnCrqCAdW6vQFkZ4dHJOdWfxOg6ld+UjXi9FFSoCt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9538
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



On 11-Jun-26 11:56 AM, Huang Rui wrote:
> On Thu, Jun 11, 2026 at 01:57:15PM +0800, Jiqian Chen wrote:
>> For Renior APU with gfx9, in some test scenarios with disabling
>> ring_reset, like accessing an unmapped invalid address, it can
>> trigger a gpu job timeout event, then driver uses Mode2 reset
>> to reset GPU, but after Mode2 compute Ring test and IB test fail
>> randomly. It because the CPC and CPF are still stuck after Mode2,
>> that causes compute Ring test fail. What's more, the HQDs of
>> MECs are still active, that causes MECs use stale HQDs when MECs
>> are unhalted before driver restore MQDs, then causes compute IB
>> tests fail.
>>
>> So, add sequences to reset CPC and CPF after Mode2, and de-active
>> HQDs of MECs before unhalting MECs.
>>
>> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
>> ---
>> v1->v2 changes:
>> * Move my sequences into a new function gfx_v9_0_cp_mode2_clear_state
>> * Add reset Mode2 method check to the if condition that call my sequences
>>
>> v1:
>> Hi all,
>>
>> My board is Renior APU with gfx9, smu12. I run a testcase that
>> accesses an invalid address to trigger a amdgpu_job_timedout()
>> with disabling ring_reset, so that driver will call mode2 reset
>> directly. After mode2 reset I found compute Ring tests and compute
>> IB tests fail randomly on random compute ring.
>>
>> We checked the scan dump of GPU, we can see the CPC and CPF are
>> still stuck, that caused Compute Ring tests fail.
>>
>> I added printings in driver codes (gfx_v9_0_cp_resume), and found
>> the HQDs of MECs are still active, that may cause MECs use stale
>> HQDs when MECs are unhalted before mapping compute queues (restoring
>> MQDs to HQDs).
>>
>> So, I send this patch to fix above problems.
>> There are two main changes of my patch:
>> One is to reset CPC and CPF before resuming KCQ.
>> Another is to disable HQDs beofre unhalting MECs.
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 44 +++++++++++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> index 47721d0c3781..d3ef45aa299a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> @@ -3942,6 +3942,46 @@ static int gfx_v9_0_kcq_resume(struct amdgpu_device *adev)
>>   	return amdgpu_gfx_enable_kcq(adev, 0);
>>   }
>>   
>> +static void gfx_v9_0_cp_mode2_clear_state(struct amdgpu_device *adev)
>> +{
>> +	u32 tmp;
>> +	int i, j, k;
>> +
>> +	/*
>> +	 * CPC and CPF are still stuck after Mode2 reset, that causes later
>> +	 * compute ring test fail and then loop Mode2 reset infinitely
>> +	 */
>> +	tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
>> +	tmp = REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPC, 1);
>> +	tmp = REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPF, 1);
>> +	WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
>> +	tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
>> +	udelay(50);
>> +
>> +	tmp &= ~(GRBM_SOFT_RESET__SOFT_RESET_CPC_MASK |
>> +			GRBM_SOFT_RESET__SOFT_RESET_CPF_MASK);
>> +	WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
>> +	tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
>> +	udelay(50);
>> +
>> +	/*
>> +	 * CP_HQD_ACTIVE survives Mode2 reset. Deactivate every MEC HQD to
>> +	 * prevent MEC use stale HQD when MEC unhalted before restoring MQD.
>> +	 * Otherwise, later compute IB test may fail
>> +	 */
>> +	for (i = 0; i < adev->gfx.mec.num_mec; i++) {
>> +		for (j = 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
>> +			for (k = 0; k < adev->gfx.mec.num_queue_per_pipe; k++) {
>> +				mutex_lock(&adev->srbm_mutex);
>> +				soc15_grbm_select(adev, i + 1, j, k, 0, 0);
>> +				WREG32_SOC15_RLC(GC, 0, mmCP_HQD_ACTIVE, 0);
> 
> I think we don't need to use WREG32_SOC15_RLC here, because SRIOV GPU won't
> access this code path.
> 
>> +				soc15_grbm_select(adev, 0, 0, 0, 0, 0);
>> +				mutex_unlock(&adev->srbm_mutex);
>> +			}
>> +		}
>> +	}
>> +}
>> +
>>   static int gfx_v9_0_cp_resume(struct amdgpu_device *adev)
>>   {
>>   	int r, i;
>> @@ -3967,6 +4007,10 @@ static int gfx_v9_0_cp_resume(struct amdgpu_device *adev)
>>   		gfx_v9_0_cp_gfx_enable(adev, false);
>>   	gfx_v9_0_cp_compute_enable(adev, false);
>>   
>> +	if ((adev->flags & AMD_IS_APU) && amdgpu_in_reset(adev) &&
>> +		amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_MODE2)
> 
> If we constrain the condition to a mode2 reset, does that mean we no longer
> need to restrict it to APU?
> 

This issue is not reported on aldebaran which also supports mode-2 reset.

Thanks,
Lijo

> Thanks,
> Ray
> 
>> +		gfx_v9_0_cp_mode2_clear_state(adev);
>> +
>>   	r = gfx_v9_0_kiq_resume(adev);
>>   	if (r)
>>   		return r;
>> -- 
>> 2.39.5
>>

