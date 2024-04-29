Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F32C3C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 22:34:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7154710E057;
	Mon, 29 Apr 2024 22:34:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gOu4MdSr";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6027B10E057
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 22:34:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3CoC3vG0nFLCI8yUIietpF3RNTqmhE3cnFbzzpy2im3yafrHpTANgg277E4s+cfWuNaytyiqGIeaE9k7QdAiqj9sYBuNR3vSeEeAVYG8O4GADswvX2Tl5tCFlDqJ1pmLOg4EUkF2U3s2sH1wzHceUiVUjvgLNibYG5vkdflsutryv6CWzxgVXtCH2jSFI2ELN8TRbaUTxlZxsDDc/Ak4NcKO3lQ2kcxDc7k32cduXoTE3crmB+jUffK03Vd49VZuPTqAGG4Y5uAGVhRvDpuOc7pBpHkZ+2ykygqXIu6Ppcc8y5C1rKRURWDP3VR18lwAerFvAOPss24GlEG4mJxAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHDgv/LnVLJKJqIWcYERTtiO70q8BGhtLfjKqYQYeVk=;
 b=KGgP/Fhv4iSFi0V8mAd3iFgurZ+deDhn4ARSznEhyLNRJmINUr9SiBYyRuGD3CBLRIxD1gVgBxqw/9274wGi5XCm4dtkrk+tcDBg9uTqtPlJ5dTYfvReXl4EJRtXrWlFZXnwUonL3HL3ze6QCF3CL4dP3N9TDcsv1Zx0eVqRTArOf5JboFuVm7p6Fap47AFtJ3qdYh8bGst5A/XMn9l3q9+Z9Tv72NpDcBcG+jopeEwPIs3+zO3eGN//aByiZoqbChRBqwL1gXKJd4H7756/Pw4CWrCuMOI1pAoNUTfNyHIYkM43MPrgoaoomz63IPr65QGZAVdH85kbmHjcSsiPYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHDgv/LnVLJKJqIWcYERTtiO70q8BGhtLfjKqYQYeVk=;
 b=gOu4MdSryR4v3ajzgvtr/Of8jVu0sS95GBRn72ejWtd/DHWiSGrGPgwKbcCkVGKIgJhIwvNlno0AZa2dyh6gGCZq/JLxtiMwPrmyGgSoek7XnJ+vJOaNpG4FHk3wDIfiNry5ykVY1WY09giKElltjsDXBdCzTWauIj4uNe/KUeM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW4PR12MB6898.namprd12.prod.outlook.com (2603:10b6:303:207::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 22:34:39 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7%3]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 22:34:38 +0000
Message-ID: <240ca989-57a5-4fef-a956-082f993e89a1@amd.com>
Date: Mon, 29 Apr 2024 18:34:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: update buffer_{store,load}_* modifiers for
 gfx940
To: Jay Cornwall <jay.cornwall@amd.com>, Lancelot SIX <lancelot.six@amd.com>, 
 amd-gfx@lists.freedesktop.org
References: <20240429110628.149277-1-lancelot.six@amd.com>
 <2eb63de5-2335-47da-81f3-42900a6caff0@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <2eb63de5-2335-47da-81f3-42900a6caff0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0161.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::29) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW4PR12MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: 370c3f85-1453-484e-6abf-08dc689c8e0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cDNTdjhJTHUyeUdYTHp1dWdIL2VUTkdZOWovaUM2azdhMmNuKzRhd2sxc1RM?=
 =?utf-8?B?clcxQUdZa0Zic0c1bG80c3kyb3FhRDlkZTVEWnpjQ1ErUHkyalQ0S2RWV2ZO?=
 =?utf-8?B?WTZHNHZDZ3pmV1NraXJFd0d5blVqeXVvV3ZzVytuZ0JuZ1ByTHN3MmVvM1lY?=
 =?utf-8?B?RjVrUzBBa2FGR0RjeTlselkvdENzZmhRajlZazQxUDQ1cjlBbVJlRDJTTFFl?=
 =?utf-8?B?bllKOHpyS0JPUitCSys4TEdEWGdLd0hEN2pKTjhGdDRXNEQ0Nkkxcndva0Y2?=
 =?utf-8?B?VXJmRnRTWHlTWnNFZUNNb0Y3TXhIQWZSbVZpZjFiaVkvdVZEbUtwWlpMZW1S?=
 =?utf-8?B?cHJ0M0RVUTA0MG5PVnpjZ08rYVZ5amc2cXRtNER5NTF4T3BHNXk0ZVEvb2Jt?=
 =?utf-8?B?SmRQMGpWakVOMEtjcEk2WWhxM0NRUzhCTCtiOTdNZ3hIZHV6dGV1anRZTHNk?=
 =?utf-8?B?ZElhRCtpZU1oeTJ5NkNRMkdiOVlCeVpDbjF1dU1NZGJMRTZpZlZCbVBZRTJY?=
 =?utf-8?B?UkRWNWtkMkI2cnlrVW0zNjNuYVpJeS9GVmpVRkdZZHY4QkEyMlJSN2JESEky?=
 =?utf-8?B?VS9DOXdYeTZwMVBDcndqbzd2cEc0VVVsUEVoanA3NEpvdXNva0ZxT0l0UVc1?=
 =?utf-8?B?NjVnaG03eVBRQ2pZVGxHVnFrYWM5MXVCUnk4UmJlTzlERllxZXlmWXI4ZE5M?=
 =?utf-8?B?elFxb3l2b05UdDFNRVJpaGllRE5RMk1ndDg4SzZKMHA1TEh4Vzl6WTkvdFlH?=
 =?utf-8?B?V0xOcThTekFPbXBpSHhJcmNuRzB1Q0YzdktGc1B0b0xvVTQxTmVCYXdlYm1i?=
 =?utf-8?B?NTgxaTc4S1FiSUZsNlR6SlZLZmV3NittaEtVaGtCTCtRV1ZwMGlwbW5RVU51?=
 =?utf-8?B?MFF2cjNiQWlSOWtKb1NxMCtxdjkycU9nMFY4bzRMM2w0RXVFejZXN0RSVVRT?=
 =?utf-8?B?ZXQ4UVRyUTRkRHlDcUttS3l5NzZMQ29hSEJqN2lha3lWV1dleXgzTVFaZFFy?=
 =?utf-8?B?TXNVS3BVZ3RUcmlSRjhsNjR4NmdVZWdiV09yeVlvMU0xZEJVOUZLK1g1L205?=
 =?utf-8?B?S3RPeEdDU3VuS2ptYlZDWGpPZ2o4M0p0THhxdlFMdHR3QlZWZG03L2hjV3lv?=
 =?utf-8?B?WFhrQzRtakswcUxpellqWkd3V1h5d0U5TTVJLzB0b3RDNit2TWIwQnZ3OFVD?=
 =?utf-8?B?ZE92RlFCanZTemE0RUtwakV1M0plZ21TWkRBbXpCK25ETWR2aHBqNkphSnF6?=
 =?utf-8?B?T3ZIcWRIZDF5Z2p3TElCT2dkc21PYkVrdmpOa1poU0JxQ1A1Nkh1eFJtQVpM?=
 =?utf-8?B?NitSdXVaQmxXTTFhdWU4S0cxOVY0Tkl3TTRTa0J0NVFPalF3dzhNUEh4dVpI?=
 =?utf-8?B?bnJZc3cxT3MzS09xbDM2L3lPcDFCOHhPb3g1UksyN09wNVdvZjVqM09jdjRV?=
 =?utf-8?B?YW1xNm81ajJOVkpuZEY3V1Q3REpEb21CcWoyMktzM0s0QmdGY3QzMDJKSkg0?=
 =?utf-8?B?Mm9ZTzZTa1U5bmFHc1FkdUNOcXVXTUs3b3pRZHlWZVRnNElja3IyS3hvUTNN?=
 =?utf-8?B?UjRHc0crZGY2YlZ4Y3hVQzU3Q2N4OEVMUldHdnVVMlRKTUtYMVRkbm8zNXBP?=
 =?utf-8?B?Q3RzZXZDaEszTDJ4Q2RKWFNUTmg1MWplRHpGMElsenh6N1VaM1dndTMvU0Zl?=
 =?utf-8?B?UVYxVzQyKzIzcmI1bGFuVHZJdW95RmM0VzBzd1o1dFJNc0Y4K3pWMEFnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mnk5YUQyNTdYOE13L3BOeDBhVUVuQWtLVzRjZjlZN0M5K1RBaG5LUEZCbENz?=
 =?utf-8?B?Q2FhRDNLNlZJTGJQSFpodXlsVjZ3MGs3VzJwZndLUjFsYXBsakZWcThxWU9m?=
 =?utf-8?B?ZlZ2TlY0YlRRWjQ5VHNLK1gyR0pvNWttejk3NllzT3dueXFMcHN2KzlpQmpv?=
 =?utf-8?B?NjAwOG83dDFHckVReE5JVll2OERleGhobzBObnA0RitPb0xZUWY3V1hEYzhv?=
 =?utf-8?B?aFdZRkNDeDZUZmdCRjdHRTQ5MXlmWk5ESWxpYWR2NHlqcWVBNzFjTFVsVXJs?=
 =?utf-8?B?NGZxTmJHRzBmNDVNS1BybHJvV2ZyblNuazVkUFVROXVyUG1hc2NXL3ZTaDRU?=
 =?utf-8?B?OTdVZmp4NzJjZFI1b1JoTnBseGZST3d0U3F3Q0g5c1NqeXh0bnRiRzlMSGRD?=
 =?utf-8?B?K3lCNDltNXRseVFITGFJeVR6djRCeTN3cGVsNERrdktLWmM5ZjU4dlloUWd4?=
 =?utf-8?B?VHU3N1o2UEFGUUFObndKSDNNRWdLelFhR2Q3VFdsUVAvMHlpTDRTTHg5dmNa?=
 =?utf-8?B?MWZjWHlJaUtaY2U0R09zTTViTk5NcWlYN0UyaDlxbTdZVWxpbU9oZTdVNkd3?=
 =?utf-8?B?N3VneThzcDRmKzdEbEgzUUk2U2prNXU4ZUk2UUhUWjZKVmtwNUp3byt3aCtQ?=
 =?utf-8?B?TVF5UUNNK1U4RFNKaWxnejR5MGZIajZpa2dGVENWTk8rSVhHQ2pGeFlPcFht?=
 =?utf-8?B?Zm1RcEsxVUM5SERyeUhPVCtxUWttRVpONUtIWjQwUkhka3BRZ0tPVE1lb0g4?=
 =?utf-8?B?RjBFbFh5WkdEN2hVL25KK21CRHBJRElsUmNkTU53NDY3djdQSjR3bU9JRlBh?=
 =?utf-8?B?QWcyRlR0a0cwYXBWV240R2d3Y2JIanh4T3phQk8yUm5sU0ROVzA4NEZGZ2Nu?=
 =?utf-8?B?NFZrSTdEeWtMM1dwVVZudnFRRk5lL0hJS1NuTnJPL3Urai9KU29va2ovTDQ0?=
 =?utf-8?B?RDJrZytBdFJWcXRIUlBBTkd1MHdFWUE0Z1FpanlQcE9sejE1cWppWHk0aTh2?=
 =?utf-8?B?YXZ0dUtsRklvT3BjalVHMzBJQkpHV2Q0dzVkdDVmd1VNWSswdE41b1JLaWJF?=
 =?utf-8?B?VzhHQlVhNStPS0NkM25QQk1BZVR0Z0VLTHhkRW1tQisrN1QyWS83ejV6UG1t?=
 =?utf-8?B?WnVVcjlQSytGMXZ2d2Qydk11VER2Z2czYzg5TzZmZEN1OFhJQXRncmo2NFc1?=
 =?utf-8?B?b04xanNHZzdCM3VrUm9nTWFnQUY1eTRYTjRVTGZyVWNqcXJaSXpBZ0ZTS2tU?=
 =?utf-8?B?REVmNG12dHhyUzVpQ1hBeWVxelpIZUxKYjhKUDBMNHpscEJSeG9xcGppRis0?=
 =?utf-8?B?SkhldmlmM01IemNMbFpRcW9SdU0vS05IbnZNaHozTGtTaXNmZTVkTmVmMXNY?=
 =?utf-8?B?MzhDSU1ZNEZ4cTYxRUpidGxJdFNMWFYyL2NwLzRXTEtRRlFGZUc3bjN5ZGlK?=
 =?utf-8?B?Mng4MllMRS9PWmxFbVZLem5KNTNYMTdVYm12NWdleXd0K2pTbG05WnZ1L3B5?=
 =?utf-8?B?dGhHbm1DdWlBRWswb3pPM05ZeS9TaDhvYWl5cThadHE1WWFpbzVMNXhRV1lU?=
 =?utf-8?B?TzVtTHBOOUdYc0dhSDRmTnRtUUtuLzRGdXVOMHJ3RlBVTDl6SzJEcnh6SGpY?=
 =?utf-8?B?RlJwZTFQQityNWRRK1QyWTJHWWQrYzQxNW9EM2RrazN3OE9kZHZsY3hGTnQz?=
 =?utf-8?B?RmsyV3hqNm8wK0RRRkY0aU5kdExWWmhzSnczdW0wNHhRekVVWk83QUFBMHA0?=
 =?utf-8?B?aFhPNlpQVVRuOWFiQSs3VkpWUHBxSEcrYXpyYVpGTWNXS0dVQmdWaUpucEox?=
 =?utf-8?B?Nlo3SUFTN3kyVFlYWktVdFBIUkZJOVlVcWUyZzdIV1hjekZXbWxpUm1Ya3BK?=
 =?utf-8?B?RHdVUlhZVjVOV25QM0NxVWlFM05KRkhoRXF0ZXo2UGhqSk5VUzVxclQva2J6?=
 =?utf-8?B?ZTV4QmNCM0RadW1XMlA5QytESjhTVVBsZm96YlVtUjVVS1pNd250OUk2NW11?=
 =?utf-8?B?amlDOXBQWitZZDBmWWx3TW8yNysvLzY2Zmd6bHBXT2s2aG5xZXlOQXhCODJl?=
 =?utf-8?B?YTZlTi9wMkYyNnVjMmJpMitmNHozaTNSYWRNZ1p1d0RNME1naHVMeVhtQXN6?=
 =?utf-8?Q?Y1mOwngYUVV1BqhaCUO/9kR1o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 370c3f85-1453-484e-6abf-08dc689c8e0a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 22:34:38.8025 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kNkuSn1jkWrrdbHVMaopfXSnn9Py2MUIiKNA+PnsRyIM/1Ax0WXWmhQW2XcD0KtV91J1V2JBoPGx6lVQ9U1evw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6898
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

On 2024-04-29 17:50, Jay Cornwall wrote:
> On 4/29/2024 06:06, Lancelot SIX wrote:
>> Instruction modifiers of the untyped vector memory buffer instructions
>> (MUBUF encoded) changed in gfx940.  The slc, scc and glc modifiers have
>> been replaced with sc0, sc1 and nt.
>>
>> The current CWSR trap handler is written using pre-gfx940 modifier
>> names, making the source incompatible with a strict gfx940 assembler.
>>
>> This patch updates the cwsr_trap_handler_gfx9.s source file to be
>> compatible with all gfx9 variants of the ISA.  The binary assembled code
>> is unchanged (so the behaviour is unchanged as well), only the source
>> representation is updated.
>>
>> Signed-off-by: Lancelot SIX <lancelot.six@amd.com>
>> ---
>>   .../drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm | 24 ++++++++++++-------
>>   1 file changed, 15 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm 
>> b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
>> index bb26338204f4..a2d597d7fb57 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
>> +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
>> @@ -48,6 +48,12 @@ var ACK_SQC_STORE            = 1            
>> //workaround for suspected SQC store bug causing
>>   var SAVE_AFTER_XNACK_ERROR        =    1 //workaround for TCP store 
>> failure after XNACK error when ALLOW_REPLAY=0, for debugger
>>   var SINGLE_STEP_MISSED_WORKAROUND   =    (ASIC_FAMILY <= 
>> CHIP_ALDEBARAN)    //workaround for lost MODE.DEBUG_EN exception when 
>> SAVECTX raised
>>   +#if ASIC_FAMILY < CHIP_GC_9_4_3
>> +#define VMEM_MODIFIERS slc:1 glc:1
>> +#else
>> +#define VMEM_MODIFIERS sc0:1 nt:1
>> +#endif
>> +
>> /**************************************************************************/
>>   /*            variables                      */
>> /**************************************************************************/
>> @@ -581,7 +587,7 @@ end
>>   L_SAVE_LDS_LOOP_VECTOR:
>>         ds_read_b64 v[0:1], v2    //x =LDS[a], byte address
>>         s_waitcnt lgkmcnt(0)
>> -      buffer_store_dwordx2  v[0:1], v2, s_save_buf_rsrc0, 
>> s_save_mem_offset offen:1  glc:1  slc:1
>> +      buffer_store_dwordx2  v[0:1], v2, s_save_buf_rsrc0, 
>> s_save_mem_offset VMEM_MODIFIERS offen:1
>>   //    s_waitcnt vmcnt(0)
>>   //    v_add_u32 v2, vcc[0:1], v2, v3
>>         v_add_u32 v2, v2, v3
>> @@ -979,17 +985,17 @@ L_TCP_STORE_CHECK_DONE:
>>   end
>>     function write_4vgprs_to_mem(s_rsrc, s_mem_offset)
>> -    buffer_store_dword v0, v0, s_rsrc, s_mem_offset slc:1 glc:1
>> -    buffer_store_dword v1, v0, s_rsrc, s_mem_offset slc:1 glc:1  
>> offset:256
>> -    buffer_store_dword v2, v0, s_rsrc, s_mem_offset slc:1 glc:1  
>> offset:256*2
>> -    buffer_store_dword v3, v0, s_rsrc, s_mem_offset slc:1 glc:1  
>> offset:256*3
>> +    buffer_store_dword v0, v0, s_rsrc, s_mem_offset VMEM_MODIFIERS
>> +    buffer_store_dword v1, v0, s_rsrc, s_mem_offset VMEM_MODIFIERS 
>> offset:256
>> +    buffer_store_dword v2, v0, s_rsrc, s_mem_offset VMEM_MODIFIERS 
>> offset:256*2
>> +    buffer_store_dword v3, v0, s_rsrc, s_mem_offset VMEM_MODIFIERS 
>> offset:256*3
>>   end
>>     function read_4vgprs_from_mem(s_rsrc, s_mem_offset)
>> -    buffer_load_dword v0, v0, s_rsrc, s_mem_offset slc:1 glc:1
>> -    buffer_load_dword v1, v0, s_rsrc, s_mem_offset slc:1 glc:1 
>> offset:256
>> -    buffer_load_dword v2, v0, s_rsrc, s_mem_offset slc:1 glc:1 
>> offset:256*2
>> -    buffer_load_dword v3, v0, s_rsrc, s_mem_offset slc:1 glc:1 
>> offset:256*3
>> +    buffer_load_dword v0, v0, s_rsrc, s_mem_offset VMEM_MODIFIERS
>> +    buffer_load_dword v1, v0, s_rsrc, s_mem_offset VMEM_MODIFIERS 
>> offset:256
>> +    buffer_load_dword v2, v0, s_rsrc, s_mem_offset VMEM_MODIFIERS 
>> offset:256*2
>> +    buffer_load_dword v3, v0, s_rsrc, s_mem_offset VMEM_MODIFIERS 
>> offset:256*3
>>       s_waitcnt vmcnt(0)
>>   end
>>
>> base-commit: cf743996352e327f483dc7d66606c90276f57380
>
> Reviewed-by: Jay Cornwall <jay.cornwall@amd.com>

Acked-by: Felix Kuehling <felix.kuehling@amd.com>

Do you need me to submit the patch to amd-staging-drm-next?

Thanks,
   Felix


