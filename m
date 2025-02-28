Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E35ECC282C5
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 09:37:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9233110EC33;
	Fri, 28 Feb 2025 09:37:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JZlOMou6";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D8B310EC31
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 09:36:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f4FK+kuVqKuMKbAKEJObTn+Rb8Q9YpHKpvAL3C2jWxJbcmX1lFh81T4p2U4jE/wZLfYszNDckzTcMVnLtqYhjbGrRLjle5C7vB9jHyL+bUZyUqOF7hDr0EUAaMOOEQSVslCmSnbuPiJKUlSRtrFytGiX38ta6L24iD+yjcSFeJ9N1eOCfbHH+ym2cK7lP/ZyTjjfG6TH/UQOG7Qp1bwK3WSO4yCUx9+9w78WXFKd55td544U8tM7UEM9rlfloHcAMzPbuytGZNA8cdQIK1HZPF3/48xBSjGmzznTgOEhrylWRVicd1mDaLy1xHO5J6o1wZzxYG95k7ZGXi/TLhLbJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLYFV5XF8bPTO6E7GCIroCcfDucJ3T3vK/aJ5ABC/50=;
 b=EVucKSV98+1zfgelkkfRukC9LrKqSK2A+xm0hZDT3djQ364FKthvCkW2E2gaJvHG5BJI4POiZaPovKmOV+2mysCJGWajHS5k2Q0qSo44ydJaOTcRyIsHuRsm8ol4TfGphhDGK/h7ydbEhZ4RDl9zpz4bbg6rphTStfAUK4sQtNt3PkVpiNLrkKR3FlzLhEgEGsvV2V4257lwn/4PX5SHithwTqp4fmZk0ewtwWhhE57uZRY/xsSfR3zDYcuibhrH9IPVXb58Hwjlgl/FrR1f0EUVlEXlHaVgNdOK5EkMtC7B8pbIi/qDknY2OQqtyfrKrzTcU+DF4oO1CBWJiFek8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLYFV5XF8bPTO6E7GCIroCcfDucJ3T3vK/aJ5ABC/50=;
 b=JZlOMou6dQpOQfWbrRt9xsGsvs1riNDDPUazy8XJ6xToaNLsEpVgK6ZB0QJbvJ+TESWSAOPz7yQ4474X0JdtYBGCeK8uAr1keH5k50QnUsDnqqlzWLsCAGRRD79LpPmEouD+vorBLjhEqkhEqhR++90heJ81bq+cpEqi8DPKmVw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.22; Fri, 28 Feb 2025 09:36:54 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 09:36:54 +0000
Message-ID: <3b9c9a6b-c219-41df-8867-fbbbf9f58b38@amd.com>
Date: Fri, 28 Feb 2025 15:06:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu/sdma_v4_4_2: update VM flush
 implementation for SDMA
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Jesse.zhang@amd.com" <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Jiadong Zhu <Jiadong.Zhu@amd.com>
References: <20250227114755.444535-1-jesse.zhang@amd.com>
 <20250227114755.444535-3-jesse.zhang@amd.com>
 <88bcde2c-19e0-429e-abea-5ed6e7cf2bdc@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <88bcde2c-19e0-429e-abea-5ed6e7cf2bdc@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0048.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::23) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CH3PR12MB9079:EE_
X-MS-Office365-Filtering-Correlation-Id: 62ad352a-7fbf-47d6-b7ed-08dd57db6f82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NEtNWDQrM2FnQi8ySG9vU2kzUThSbXNKbDVZcFFzMGs5V1NDZUZWdGRKRm9P?=
 =?utf-8?B?T3VPaHlCUUlTdm4xOUU3UmhLTXhPWDNXVlR2SnpPU2hCaFhrcDdTTkx4aDZh?=
 =?utf-8?B?dHgzK21sRS80QmZyKyswdTRLMm5ITlFHM21ZYzIzQUpaTlFhQzdQZEdVQVhy?=
 =?utf-8?B?T2gySXJzbHQ5YUlBRklpT2p1dGtZZDB4QmdlREo3ejNvQVUvd3J3L2p1NkVU?=
 =?utf-8?B?cEJma1gvSWRTaVd2VEQyTkJCdktnUEpmbVdqM1FMalAxaHJ1S0xiZFNmRngz?=
 =?utf-8?B?VUxCOGYvMkZqYnRxTjl5VDU2VHJzQXpnRGdFMU1kMXd3TzM0d0ZPS3JydkY2?=
 =?utf-8?B?ZWxRYmFlcUhJR0NYYnlKbG9mUHozM0R1V2lOdlFqNHllTFRVWHBuRHlERTRr?=
 =?utf-8?B?dGxUTy92MlR3YTJxVWdwekU0RVlQa1ZwOTM2bkprNC95d21GaXVxaUVrUDVk?=
 =?utf-8?B?dlBJMUw4bXFNeUUyY0gvSXB1RjVkU0tYay9JR0FkV0czK0VaQUZmMExGTHZV?=
 =?utf-8?B?S0I5ck5Rb25LL3RnNTdTeHlvMEloN0tqcHQrUW5CKzR2WWVTRWJnR3RJSHQ0?=
 =?utf-8?B?OTczUlBqOWcwQ0graWh6RnRRK3lGaTZZZEtTbDUvVGxCQlBFTTJUbkNaWEdk?=
 =?utf-8?B?eWpDWVRoK0wzZXVkR0g4VUlTZU5UNkhRTVJPdTY0SldhRFpRU0kwb1YxUWdt?=
 =?utf-8?B?ak9ta2doNHRnaE9yb1Awbmx3MkVxMnVDZjZxUFF5Mk5iR052Y2NMcHdsdXR3?=
 =?utf-8?B?RlBnNElxRVl1QVVuNEtGeG1CSE9Nd2gvUXorOEF1SnJzdUZGcS9RUDdtZjd4?=
 =?utf-8?B?WUlVUjhxWnFFaldGWGtLWmlhaDVnOEZvTXkwNS9CMGwyQkdTVGRsUUFlaVdQ?=
 =?utf-8?B?cEhpQkFxdWxHampTZDZCT2ZYY3hJaVpKS21PK1cwY3gyMk9GVlBOZmVNc0Zw?=
 =?utf-8?B?WkV1c3J1RG9TVDBNdEhDU0kvOVh2U3B3OEFHYmJCaXZwWjluMEVPczNBU2lm?=
 =?utf-8?B?OTd5cVVGMDdjYWJDU2xlQm4wa0VDdXY0RUFGdzFVUzlQRVV5dWtycytPRmIr?=
 =?utf-8?B?R0lSc2xISEpzclZpNTJQZ1BCU2VLVDBzTXNRNmVSb0I1b3pGUXkxTXVya0Vs?=
 =?utf-8?B?dmh4NUpWN3JYZTVZbjJ3K1llT29ya3g4cU9pSDZUS2Vid2dUelhxQ0JmaUZE?=
 =?utf-8?B?dUxmNUtMRFpqRUNCZnJ3Z1ZveFRJRzhHQlZGNkV6SjU4cVZDeWdOMWc3NTlq?=
 =?utf-8?B?WDFwNjBDc1I4eFZLRE5UUUFKUUtrenU0V1RyM0N0YVVQT0VzWGNBbFNvNCt1?=
 =?utf-8?B?Mi9iTlNMN3Q2Q1E0bXRUWW1iSFdSTmtxblN3VFMxQnM4eTd0dTdtRjlHZEIv?=
 =?utf-8?B?YTZRSVZ6Z01qTU1sWVU4ZXdzcHZWdkZObHdCZ0YwSzAzc1lXdStGNEJsSGJO?=
 =?utf-8?B?ZzJBT2lTN3Y1eloyQmVRN0llT2k4Vis0Z0xFb21SLzNDSDFJMGlWMnJuUktR?=
 =?utf-8?B?RjZjY1lHZjZSOFhRMmVZWEFaalo1RkdWSTZyazNRTzJjcFpINDJaYTgxQm9Z?=
 =?utf-8?B?aDA3L1l0Q3ZSalRCbmRtU0I2Yy9VcE1CSytjTFZSNVpsckZ5NUtwU2diNE9a?=
 =?utf-8?B?Yk1CMlRkOUxKdE5FaUthR0pNMjZkbjZoN0M0QXFSQk54aDNZQTdTN3B1eDVE?=
 =?utf-8?B?azFZd21qSlQ5SjRzeFdiL0JKVTlIMXB3aU5SZFo2RzFwc3owaXA0dlVVNXRD?=
 =?utf-8?B?bTNwa0s4ZU1ISXJQRVVxNnpad1BzVWdKZEs3MHhRWEZKWXhFNU1lWUNSOXpq?=
 =?utf-8?B?OHhHZUIvaDFOV2h1ckhjS0dyL3RQSGMyWWFaN0UycUx3MDlSc29uclBnT1hp?=
 =?utf-8?Q?BxqB1UnW/y8lp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnBjV0JTQzlqMG55MHFWOWt4MElsb1lrODhKS3l5cHY4NGpPQ3RyMXdPSHNC?=
 =?utf-8?B?dE1jT25MT2dEbWlFdW82NDFIcnRtSWtjVXM5MlFZelE2VFh3WDljRHlCZE5H?=
 =?utf-8?B?UW9mTmF0N2hLL2JFYit5Q2JPcm11UTVDWDFoUmlPeGdyZDdKaTVHQzBaRE96?=
 =?utf-8?B?ZTJDa1ZnZzAwTG9pSDBZZFJoNkxndlp0MWZYbHRBTlhHQTA5UStSM0RIc3R0?=
 =?utf-8?B?RVY2dWJnR1pJT0NMOVZyMVRmTkZKdCtJeWJhalljY3prMW9GVzZaaTFVZUps?=
 =?utf-8?B?VEVpVTl1d243RWd2QWxlQzJNcHdzM3ZTOCtZd2lvdVBvYytGcTNzWDh5OWha?=
 =?utf-8?B?WTRzSXpKK01uaEdaWk9XN3RpLzl6R2ZERW5wZlYxaVYwcDVQZWk3VWRiTU1E?=
 =?utf-8?B?bEJMdlFMazJtbkNpcTIvbTdhRTNmcWljOGYvTVZ4K0wvY0ZrSzJOU3E5R1dr?=
 =?utf-8?B?TzlyWFAzOVNoaUtXZHdoYlQxNnA5RDFoYUJPWi9USzJ4ZkcvK3VSQU9mOEE4?=
 =?utf-8?B?RGM3czNiZnJaNUZQUWtmZXVyN0pnTHlRaG81MHF6djBvMWpodkZmV1kyMnhp?=
 =?utf-8?B?cG5TSUtmNHVoQ1U3OHRUZThnQVYxeTd3K3ZLemRzbXhodHhTWUxhZVNrNVJ0?=
 =?utf-8?B?L3BFb0RDN0pPeFRhTnIzWGtoRTl0ejZqUjhMRkI3Z2VubTcyb2pmYVk2Sk1K?=
 =?utf-8?B?b01WbzYzbWZ3T0VUMUNuRTRSLzc5dEVqVU5SZjVvbVJxb05xTlA3SDZrRUdo?=
 =?utf-8?B?NHFmNzJCb2M1ZnJhTEw3RU9WVUllWGRTbEE5bHpmTjRwMGNqeGo0RnNrR1o4?=
 =?utf-8?B?VWdBMk1UbFBNTHFzS3RsSWJuM1hSYlJ1UGhFdTM5NjBCd2ZCRVdteFN6aDVj?=
 =?utf-8?B?Sjk1NEJoUS8wZDVvUWc0TURUcDNIREllSURMcDFXbDlOQkVTMDA4MWJ0RmxS?=
 =?utf-8?B?Rk1Qd1V6MUd0Z25USVRsV1A2YkxKbmxzbnNINy9xUk9kMllXenUxaFQyRUFH?=
 =?utf-8?B?VjRFRzNUeEp5VURZb01rMDQvcncydW9ISVAzMjBWQkR5VmJUVVA0S1NiZ0pE?=
 =?utf-8?B?QlhsenhGZDBQTGltOS9CWis2azl0bzREMVN2RkhCNWxDd2tCVFdRSmZjakFP?=
 =?utf-8?B?aFdGakVQc1J3M3dzVjFsWEpDUW1nUFpOSFJ5eHpMTzJCNXdaUFZFVVBRQzNI?=
 =?utf-8?B?VjBnK0pJSEUrYndFSldKaFJXY0JkZktZVUkyWitQaGdrcHdHRVhqVXBaQ24y?=
 =?utf-8?B?ZHRFTTBmUVRoYkpoc21DNURSVUFCLzJJZkVMYVZsSlEzS0lKZTMrcmIxTFpU?=
 =?utf-8?B?YWQwWGdJV09sd3lnN0oyd0ExLzlNak9sQU5Pb2RsT1o5aFNLQUI2aXZBWGg0?=
 =?utf-8?B?V3ZuVzhQaDcvejFFbzlJMEpqNkFkQVk5OUhMYmZHQ2s0VTlKY1hic1FJb1ZE?=
 =?utf-8?B?N2tBc2xqc3VORUdTOTZ6UXh2Nk5oVGJsVlgwbjdCYnVFWmxjSldNbnQzdklU?=
 =?utf-8?B?U1JNcGhiUjNnMWtnclFjdG9Kc3FMZHRSY3NXS1pTRlBYT2piUkhpVG84M1hn?=
 =?utf-8?B?aWsvTWVlbThiM29iaWhFNGVUZDFlNGUydVF0RFBaZnRoQTVGdmNIMTA4b1Yw?=
 =?utf-8?B?eVllaG5LcWRJeXNUSk9paG5OU1I4WXVnZXU3elpDZGx0WWk0T1RiZXNtRzd1?=
 =?utf-8?B?Q2lQQzFLeDZ0ZjZVRUE3OHF2dVFBYlVXL0R1ckdMVmhRWFJhYnZSbno4UWFP?=
 =?utf-8?B?dHIwOUpzb1BzK0svdFpWbnZDT0tsTkFFQ0dJS3JQQlk0cHVWQ1RGM0NpMUVp?=
 =?utf-8?B?YUE4cFJtNG1JOEF0UlVYd3Bhd0dXSjRzdU5KNXgxN3pMN2pxWENtZHNiRzFT?=
 =?utf-8?B?ODcycEVRVmlETTM5TnRxZ0V2NzZhZlhUeDU3UysvQkhRNlFBR2VMMzZHMjJC?=
 =?utf-8?B?SDBIa3pJWmFHc01hMXJsZ0VEVXdjUmR3L3lYeWtyM01jUVo4dW5tdEJ0eG9a?=
 =?utf-8?B?SU94RUNpSGlXMTBqcks3UEZkTU1mT2RkOE1BS0VqdHRVbXNVRXhhblZVMmJU?=
 =?utf-8?B?U1FOYW5yd3pBRU5JVGp3QXdKSXIra21KSlNaZ0FoaHQ3dm5oanZmTFBtN2lC?=
 =?utf-8?Q?UC4jIUjt8fskl2FotJ39toDtH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ad352a-7fbf-47d6-b7ed-08dd57db6f82
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 09:36:54.0221 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xbBgLfeTZ5KA6XsM8vxV4rofGq76D13wG7qlQSinNqi+k6fN78NdQxoAxTpppBPK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9079
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



On 2/27/2025 9:26 PM, Christian König wrote:
> Am 27.02.25 um 12:47 schrieb Jesse.zhang@amd.com:
>> This commit updates the VM flush implementation for the SDMA engine.
>>
>> - Added a new function `sdma_v4_4_2_get_invalidate_req` to construct the VM_INVALIDATE_ENG0_REQ
>>   register value for the specified VMID and flush type. This function ensures that all relevant
>>   page table cache levels (L1 PTEs, L2 PTEs, and L2 PDEs) are invalidated.
>>
>> - Modified the `sdma_v4_4_2_ring_emit_vm_flush` function to use the new `sdma_v4_4_2_get_invalidate_req`
>>   function. The updated function emits the necessary register writes and waits to perform a VM flush
>>   for the specified VMID. It updates the PTB address registers and issues a VM invalidation request
>>   using the specified VM invalidation engine.
>>
>> - Included the necessary header file `gc/gc_9_0_sh_mask.h` to provide access to the required register
>>   definitions.
>>
>> v2: vm flush by the vm inalidation packet (Lijo)
>>
>> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
>> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 81 ++++++++++++++++++++----
>>  1 file changed, 67 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> index ba43c8f46f45..a9e46a4ed7a8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> @@ -31,6 +31,7 @@
>>  #include "amdgpu_ucode.h"
>>  #include "amdgpu_trace.h"
>>  #include "amdgpu_reset.h"
>> +#include "gc/gc_9_0_sh_mask.h"
>>  
>>  #include "sdma/sdma_4_4_2_offset.h"
>>  #include "sdma/sdma_4_4_2_sh_mask.h"
>> @@ -1292,21 +1293,75 @@ static void sdma_v4_4_2_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
>>  			       seq, 0xffffffff, 4);
>>  }
>>  
>> -
>> -/**
>> - * sdma_v4_4_2_ring_emit_vm_flush - vm flush using sDMA
>> +/*
>> + * sdma_v4_4_2_get_invalidate_req - Construct the VM_INVALIDATE_ENG0_REQ register value
>> + * @vmid: The VMID to invalidate
>> + * @flush_type: The type of flush (0 = legacy, 1 = lightweight, 2 = heavyweight)
>>   *
>> - * @ring: amdgpu_ring pointer
>> - * @vmid: vmid number to use
>> - * @pd_addr: address
>> + * This function constructs the VM_INVALIDATE_ENG0_REQ register value for the specified VMID
>> + * and flush type. It ensures that all relevant page table cache levels (L1 PTEs, L2 PTEs, and
>> + * L2 PDEs) are invalidated.
>> + */
>> +static uint32_t sdma_v4_4_2_get_invalidate_req(unsigned int vmid,
>> +					uint32_t flush_type)
>> +{
>> +	u32 req = 0;
>> +
>> +	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ,
>> +			    PER_VMID_INVALIDATE_REQ, 1 << vmid);
>> +	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, FLUSH_TYPE, flush_type);
>> +	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PTES, 1);
>> +	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE0, 1);
>> +	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE1, 1);
>> +	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE2, 1);
>> +	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L1_PTES, 1);
>> +	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ,
>> +			    CLEAR_PROTECTION_FAULT_STATUS_ADDR,	0);
>> +
>> +	return req;
>> +}
>> +/* The vm validate packet is only available for GC9.4.3/GC9.4.4/GC9.5.0 */
>> +#define SDMA_OP_VM_INVALIDATE 0x8
>> +#define SDMA_SUBOP_VM_INVALIDATE 0x4
> 
> That needs to be in a header.
> 
>> +
>> +/*
>> + * sdma_v4_4_2_ring_emit_vm_flush - Emit VM flush commands for SDMA
>> + * @ring: The SDMA ring
>> + * @vmid: The VMID to flush
>> + * @pd_addr: The page directory address
>>   *
>> - * Update the page table base and flush the VM TLB
>> - * using sDMA.
>> + * This function emits the necessary register writes and waits to perform a VM flush for the
>> + * specified VMID. It updates the PTB address registers and issues a VM invalidation request
>> + * using the specified VM invalidation engine.
>>   */
>>  static void sdma_v4_4_2_ring_emit_vm_flush(struct amdgpu_ring *ring,
>> -					 unsigned vmid, uint64_t pd_addr)
>> +					    unsigned int vmid, uint64_t pd_addr)
>>  {
>> -	amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
>> +	struct amdgpu_device *adev = ring->adev;
>> +	uint32_t req = sdma_v4_4_2_get_invalidate_req(vmid, 0);
>> +	unsigned int eng = ring->vm_inv_eng;
>> +	struct amdgpu_vmhub *hub = &adev->vmhub[ring->vm_hub];
>> +
> 
>> +	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_lo32 +
>> +                              (hub->ctx_addr_distance * vmid),
>> +                              lower_32_bits(pd_addr));
>> +
>> +        amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_hi32 +
>> +                              (hub->ctx_addr_distance * vmid),
>> +                              upper_32_bits(pd_addr));
> 
> That is unecessary.
> 

Probably you got confused by the description below. The description
below is wrong.

>> +	/*
>> +	 * Construct and emit the VM invalidation packet:
>> +	 * DW0: OP, Sub OP, Engine IDs (XCC0, XCC1, MMHUB)
>> +	 * DW1: Invalidation request
>> +	 * DW2: Lower 32 bits of page directory address
>> +	 * DW3: Upper 32 bits of page directory address and INVALIDATEACK
> 

This description is not correct. DW2 and DW3 are for the logical address
ranges as filled in inv_eng_addr_lo/hi. They are not meant for PD address.

> How are upper bits and invalidateack mixed together here?
> 
>> +	 */
>> +	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_VM_INVALIDATE) |
>> +			       SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_VM_INVALIDATE) |
>> +				(0x1f << 16) | (0x1f << 21) | (eng << 26));
> 
> What does those magic numbers mean?

Yes, this means the packet definition needs to be there somewhere in the
header too.

Thanks,
Lijo

> 
>> +	amdgpu_ring_write(ring, req);
>> +	amdgpu_ring_write(ring, 0x0);
>> +	amdgpu_ring_write(ring, (0x1 << vmid));
> 
> Either drop the () and the 0x or even better use the bit macro.
> 
> And it looks like you completely missed the upper and lower bits of the page directory.
> 
> Christian.
> 
>>  }
>>  
>>  static void sdma_v4_4_2_ring_emit_wreg(struct amdgpu_ring *ring,
>> @@ -2112,8 +2167,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
>>  		3 + /* hdp invalidate */
>>  		6 + /* sdma_v4_4_2_ring_emit_pipeline_sync */
>>  		/* sdma_v4_4_2_ring_emit_vm_flush */
>> -		SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
>> -		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 6 +
>> +		4 + 2 * 3 +
>>  		10 + 10 + 10, /* sdma_v4_4_2_ring_emit_fence x3 for user fence, vm fence */
>>  	.emit_ib_size = 7 + 6, /* sdma_v4_4_2_ring_emit_ib */
>>  	.emit_ib = sdma_v4_4_2_ring_emit_ib,
>> @@ -2145,8 +2199,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
>>  		3 + /* hdp invalidate */
>>  		6 + /* sdma_v4_4_2_ring_emit_pipeline_sync */
>>  		/* sdma_v4_4_2_ring_emit_vm_flush */
>> -		SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
>> -		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 6 +
>> +		4 + 2 * 3 +
>>  		10 + 10 + 10, /* sdma_v4_4_2_ring_emit_fence x3 for user fence, vm fence */
>>  	.emit_ib_size = 7 + 6, /* sdma_v4_4_2_ring_emit_ib */
>> + 	.emit_ib = sdma_v4_4_2_ring_emit_ib,
> 

