Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15266C43327
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2026 12:08:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A972C10E840;
	Mon, 29 Jun 2026 12:08:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mNe9/JTV";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012015.outbound.protection.outlook.com
 [40.93.195.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C903D10E84C
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2026 12:08:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bkEn4M0Ff33Mo/X+cTwVdOYaVbjSkXbMt0pCo9JzHWMDOIGGZdvd2OxLIJmGAaQBz9rw3tk99lkPD649XQWK35QDWAE5dAbTDG84FYurXFCt+CLF5UDM/fjgAgSJseFYXKa6iHO8OpL9r5Gcxax06VVpVZmtor19lrW44yteXv+rh72EDngpGADHoe4dW/9yEYt32kV8QZbOYdLW7Onruf+85wJCJDtkl+ATLUlo1pm6x5bEaBYhCvhsklQmycJxyQXQuGxPkXEmGe5SUIvcm6soJSO/8K0LzDx0ZeKOGZhOieaG41QiiV4w8Zrd8v0reAWSRKRUcZ6Emh58gURi6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSRPh/7wkisM9pZ//T1bk5ebQG/8Zf3nllAvDl2K12o=;
 b=rI3+PBLn00RgFC3zivMBUKF/2e/jSVk7Y47LzPmXnDGPv98QrW0iWVTRaMnTkMrTmcyo7fdm7dBc82RZyNLifkDzJnPaJFymEGFzILRUYGQflBMXW/b+8YCD/VLPu1GoPX5A8dsSLsfGpLdnua/r68Tflm/2gh5016iYzI7UlCQCF1OK9MV0jhXISlGYP5CVKFGaoiVNOvNWwNXZpkTy4/qgGdtspsGPNYS5Jf4X7DgPDscxQKFl/xHCDyWkSJZ4esh5osTE8g/MmwfXphjY5fBF2qyHIBuf9V/FbU3LVF/ZmFGr7sMG5M2BMnWI7vBlyVnpZAR0IQ7GV14dPDGtsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSRPh/7wkisM9pZ//T1bk5ebQG/8Zf3nllAvDl2K12o=;
 b=mNe9/JTVSiVEDMr/k7nimEu/q934g0cYVpmjxaTynPNQ4VmDNONJ2I4JY2pfQQFMDXC0P6AnXSHlOTi89eI34W5DD96sUV7oe9y1p0FTetxeM2BfwTDRXELeKUw96cP2LnGs3WBCXkHQkcJbW2GxrinQjx03EEGK/1k4hLeSOeM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7292.namprd12.prod.outlook.com (2603:10b6:930:53::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 12:08:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 12:08:24 +0000
Message-ID: <664b38fe-3f2b-4640-9507-36eaf63f925b@amd.com>
Date: Mon, 29 Jun 2026 14:08:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu/mes11: set doorbell offset for suspending
 userq
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
References: <20260625031252.298647-1-Prike.Liang@amd.com>
 <20260625031252.298647-2-Prike.Liang@amd.com>
 <32c5afa2-f24e-4d8c-8872-72826e7d3d08@amd.com>
 <DS7PR12MB60051BBD4AAF99711CCD899FFBEB2@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB60051BBD4AAF99711CCD899FFBEB2@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:208:36e::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7292:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a3e1c1a-5d14-47ce-7269-08ded5d71ed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|18002099003|22082099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: Dq8WwGGfdzButv+jBRZ8QFEENWRxYPUkejT5oqTBLX1g8Sex2DgnKxPwETWk4hDe0p/jUvlFCDGyEpR69S2EDSJitJcPMIGur+mII+Es0iSpvyXq4Tui4tB8z7hdCOzeHjN+sz1k+S9d0J7H+VaFczqZlcRk3XCkMULTRcD8OeTOXHmPkWefZwBO3SMSKY7BY2q7fs7izTVwHRt8ud06mHZfs5XKMuV3aIXX3HH04MhCk86mcCpWTV+ojAGSrchGFyGTsLLHGEjC7r8NX+ChmjprLfN2izg1fQFBTEPBRJr1aXd96SKRiATdbfcYZHtrueaN5tnIQQf1YJ7GgP5yDAECB7Ri9NztIdvQkpKkFU37NFBc59akyBXpGtCQerDMcXTl1/GrVWWvP/GHT7vVSShjHXWzfkseqK+FGaeDCBTVXEqSgyPoP4EruvKXdj8m2tHCni4Js8sUCIjWj01UcMpqy/m3me4ZRw32rdaXH1aAdhVYdVeSwUlYBxA3O3ZZBQw4KODqv1zuGb49IaaDu5BXwO4I3/hmkLEhsQ50Fx9U6m0ZC3ZWsPCZJaudcN4b/0ypimcVtzJpsw4JJcItg3MIzEMw/4ahN6ixdlUeypys1u+AsZKpLQ+Jjmhmg7ikGI/Xht6X+K8CF3Z87vIm93CVD1cdwXr1fz1i83BEUSw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmRSbkJIZW1VUld4dDR6SlptM0p3L2pIYlFuamY5M21nR0pBV0Z2eGhla3JS?=
 =?utf-8?B?ODVWdWJMemdEWnB2TlMrTDZmQmtjUEE4WFVUcjVUeENnWVdVWnRXeTRHQmxz?=
 =?utf-8?B?L0NRNXJ3MUI4QTBoOWxIRXE0YURuQmlBSzR1MThCYkUyVzNidnkrRUFuekdr?=
 =?utf-8?B?S3MxOWhNaGQwOHdiK2lQY2dTMnhCUzFFWGVjekFvWWJ0UjFIbGlEN2xwWVlj?=
 =?utf-8?B?bUlUeWZEemZ3WklXT2hvQy9EWDlZaEJ3N2w5NCtKbWxyWk9TT1l5ak40bFkz?=
 =?utf-8?B?SEU3T1dyU3kveldDYVg1cTVieHV0L3pmWGMyUE1sZ2xDYXFiMjNOc1lZWWhq?=
 =?utf-8?B?U09QVVZoeXVJZEEzamJJdDhFU3ZKOWpZK1ZDdVV6SEZTbm11d25zN1RxM2l1?=
 =?utf-8?B?MjBMUzJQTSsrc2E4d3RKQnJNV1E3WkVBaDh6Yi81S1hlTEhBZEh3UGtoSW1D?=
 =?utf-8?B?NFFaaTMzUERtMFp2dUx3Y3ZuWUxySFQ1Q045enYwZ280bjdmMExETjdoaXB3?=
 =?utf-8?B?UmlQaitXZWUreERrbzZoNzlhZ3V6Q1NBZnYrMjN4Z2lPVGl6SjNnbTdUcy9K?=
 =?utf-8?B?VHg0ZkZpRkhLSFVvNGdZM0NZOTZEVVJJWm5CK0w2ejV1TnVrckx5cURTUWR5?=
 =?utf-8?B?aFNkOHhJZkZyOWYxQ1dNdXp2VXRYQjhDdEFzcjBYdi92U3o2azhtbmRDTmtw?=
 =?utf-8?B?cXRxYVozQVBLYXJYT1lLWVRCd3BjQjAwU2NGcHdwemVJc21oRFA2U1h5blNU?=
 =?utf-8?B?VlJuYmpXTEV1MWpGRGk4TUxReXdkQkxCOWVEUENVaVdYc0RSL1Q1ZjlqWWNB?=
 =?utf-8?B?NFgyRGdPNHhYYURVN2JGWlJGNzl2bC9yT2x5VVVLdklxVkRkbGw0bUJIMU9l?=
 =?utf-8?B?Zi80REM5cEpTb0tETVBsVjVybXBEZjhZSjF4MFZKczZnbllnckFqbC9HWE0w?=
 =?utf-8?B?LzVTN2tqbDBjSzNjS0tZaDRTeFVyZklXR0w2Nkd2YThQb2J5L2ZBa0lhV2Rh?=
 =?utf-8?B?alpmbHdGblFtOWdRM21DcWlPdVlsWFVQdFJVUzdVUzhxeUZ4QnRTNEpQZ0cy?=
 =?utf-8?B?YWtGa0NEaUhoM3IreVE2S1JnMVdPcEYxVTlyYWxFc0VhRngzU1RPU0hpRm5L?=
 =?utf-8?B?N0gyZEwyTUNZclE3c2FFK285cGhWTGxrblRpdnE1c0tNNjNLMzhPNDVlZ2gz?=
 =?utf-8?B?aDV5cDJZTWFiZXJpRUdtR2NvNmNtQ2NDWUExNXJLZmU1bjZ6ZmVJYWZvQlo4?=
 =?utf-8?B?T1NSUWk1NDhVSjNQZC9vVk1RK1FOVm9VbmxmTjRQemw4S2Nxakt4NTRQNUw4?=
 =?utf-8?B?dnczVXRLMU0yVG1ReWc4ZzE3Vy8wZmV4K2Y5TWpGQlcwYU9PbWwvMVZaRDUy?=
 =?utf-8?B?aWtqVkpaV3pzNWdJTFJvYVRoMXNpUUVxRVpDWWRvTEVxdzFUbGphdzRVWlZM?=
 =?utf-8?B?YWU4bkZkV3ZNbnloZUJTaEVZRlN6RjlISi9YTlJNYmRnckxhNHh1T0draXIx?=
 =?utf-8?B?ZGZ1aGNTd0JmWm5TUlR2UGRmam9vUnh1cms1QjRJZXlzL2xDblM3cmFsc0VI?=
 =?utf-8?B?ajlXTWFtODI3SGRjTmVqUGdrMVV6aG15ZTl3WFJ2TkszYllReVJ0S2N5cHpv?=
 =?utf-8?B?TWtjQzYvSENSR0dWMlh4d3V3Vk1YMHJlN21OZVZ3bWJVd2tlZG13UDZrVGlZ?=
 =?utf-8?B?bTNGVVdNQ1ZueDdMMGdqejliUjVyK3lCL0QzcXBIU3BTeHBnWEl6NklEQlMr?=
 =?utf-8?B?am5SRHl5a0Y3Y0t2b2JPOHh6Nnh4RlN2ZkdoQ09sSm1RTzRtTlZiTndpK0Er?=
 =?utf-8?B?UkVSM3NmK2FaU1FrOTgycVMvRmUzOUtKK003aEtBakx4Q25WMmxkWTBKejBo?=
 =?utf-8?B?R1B4TGlEeFlOZDNZd2JzeWJQWnl4QitQem5RK255ZVpjMU1QM3BTSk1hYmIx?=
 =?utf-8?B?OE9YYllPQlgzOVVnVEloOW56SjNCZkxZUmtZUEpPMkpBUklSbzhXOEQ5dm1v?=
 =?utf-8?B?c2ZVbWcxWW5YMVNwbU5SdGtaR3piVTRLNkxGMDAzTWxyMG1SQnVuNnFNSE12?=
 =?utf-8?B?ODlzdElMczZRc3B3bDZDVHpWQlhobDFwR0JzYnJncmhhT2prbjdibVYzc05i?=
 =?utf-8?B?Sm8xV2ZGWFVOYnh1N1NLWURTb3RpMUZXdXBQVTBPWk5zbWE3bklXRmZDbmpM?=
 =?utf-8?B?SFBXT2FjQlN2M0dyN2FQRlo4OWNDNExwVDBQOHp4TEVwSEE5RkJ2OTFtSW9Z?=
 =?utf-8?B?V0hkQzNqbmlyNFJXRVlKd2JXNjFMM2V4aG1MRFFBQUVMMm56ek1kQVR2ZmhO?=
 =?utf-8?Q?xewwYQUCJLp6qpJUHj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a3e1c1a-5d14-47ce-7269-08ded5d71ed8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 12:08:24.6860 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9K4R/mKbcmm7eRKpW6ff7I6LacPhKsXAZzXALDpzl05OdOUrI/OEaqTYrmE0CCC7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7292
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

On 6/26/26 05:59, Liang, Prike wrote:
> Public
> 
> Regards,
>       Prike
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Thursday, June 25, 2026 6:40 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Shaoyun
>> <Shaoyun.Liu@amd.com>
>> Subject: Re: [PATCH 2/3] drm/amdgpu/mes11: set doorbell offset for suspending
>> userq
>>
>>
>>
>> On 6/25/26 05:12, Prike Liang wrote:
>>> Updating the union MESAPI__SUSPEND and union MESAPI__RESUME to add
>> the
>>> doorbell offset for suspending userq.
>>>
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        | 2 ++
>>>  drivers/gpu/drm/amd/include/mes_v11_api_def.h | 2 ++
>>>  2 files changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>>> index 9e27d01cbfa3..ab0de6d04ff8 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>>> @@ -783,6 +783,7 @@ static int mes_v11_0_suspend_gang(struct amdgpu_mes
>> *mes,
>>>     mes_suspend_gang_pkt.gang_context_addr = input->gang_context_addr;
>>>     mes_suspend_gang_pkt.suspend_fence_addr = input-
>>> suspend_fence_addr;
>>>     mes_suspend_gang_pkt.suspend_fence_value =
>>> input->suspend_fence_value;
>>> +   mes_suspend_gang_pkt.doorbell_offset = input->doorbell_offset;
>>>
>>>     return mes_v11_0_submit_pkt_and_poll_completion(mes,
>>>                     &mes_suspend_gang_pkt, sizeof(mes_suspend_gang_pkt),
>> @@ -802,6
>>> +803,7 @@ static int mes_v11_0_resume_gang(struct amdgpu_mes *mes,
>>>
>>>     mes_resume_gang_pkt.resume_all_gangs = input->resume_all_gangs;
>>>     mes_resume_gang_pkt.gang_context_addr = input->gang_context_addr;
>>> +   mes_resume_gang_pkt.doorbell_offset = input->doorbell_offset;
>>>
>>>     return mes_v11_0_submit_pkt_and_poll_completion(mes,
>>>                     &mes_resume_gang_pkt, sizeof(mes_resume_gang_pkt), diff
>> --git
>>> a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
>>> b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
>>> index 6644fabeb0b7..b06412ac8583 100644
>>> --- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
>>> +++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
>>> @@ -428,6 +428,7 @@ union MESAPI__SUSPEND {
>>>             uint32_t                suspend_fence_value;
>>>
>>>             struct MES_API_STATUS   api_status;
>>> +           uint32_t                doorbell_offset;
>>>     };
>>>
>>>     uint32_t        max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
>>> @@ -445,6 +446,7 @@ union MESAPI__RESUME {
>>>             uint64_t                gang_context_addr;
>>>
>>>             struct MES_API_STATUS   api_status;
>>> +           uint32_t                doorbell_offset;
>>
>> Is this backward compatible?
>>
>> Keep in mind that we can't break the FW interface.
> 
> 
> This patch aligns the MESAPI__SUSPEND/RESUME structure definition with
> the MES firmware. In MES11, the doorbell_offset field is also included
> in the SUSPEND/RESUME structures. However, the driver-provided
> doorbell_offset is not directly used by MES FW; this field may be
> removed in a future revision.

In that case Acked-by: Christian König <christian.koenig@amd.com> for the whole series.

Thanks,
Christian.

> 
>>
>> Regards,
>> Christian.
>>
>>>     };
>>>
>>>     uint32_t        max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
> 

