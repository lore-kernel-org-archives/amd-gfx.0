Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE80CCFA18
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Nov 2025 20:24:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FE7E10E15F;
	Tue, 11 Nov 2025 20:24:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MnE2EmtR";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010018.outbound.protection.outlook.com [52.101.56.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7CB210E15F
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Nov 2025 20:24:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/MTNlBvzcAqQ6nV8gOPw3dqA6sdGjybUexCVycK93l5/oZLAOKuPWvWuxgetAOG3QUSjnHA5UVT+ZK4lxuT2G8Q4mBHKmj8TlApLPiApLu0wz8RDyes8/gL+wSWFx2vQ0ea3g9MgqllEvM7xEEAzc6XT+sJzUhKuQXi7vq4xE4v62T9AvcdGaCTJWo0fVIjxNIDvcvCExrkxOD+EQ1CSAEP6RGHmWuwEgKNB7Um1idHQCfT0tE5njLfJf/s45J3hiooMlXeLsEB203x+g5M5ttOlzV8EOl2GwNIb937vMOz/kCllUZjN9vHwuN4yGk2Bn4V4/PIOfYaYl+wpSydbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbquLPvOGvz64+d6sCHjkEtCXavm/ZxncCEniBVyJMQ=;
 b=ahEsEtYvh3qq1bpAfvpYLfCTXCeVflmYfkysJ7QA4cKnsdVmVTVG5gNci04Ic90I+xIt90CDSRcQpg9bpYCMrdU8dC5MR3imLjohmC9J6voeK3NI+0++gbGu3NX2gOnGedn9nh7NKe4s7CYtlY5TO9M9jo46dwaYq/t3FVWFfVJ+R6SacJ+PfYrJYEcQhBeotDsKEhwj9eGjg5UZhBw6DidsO2RyIfCpkKvIrbBW6JP64+CSjPb76bwz9y2Ulb+F68IgHf7BlTePsjvc8vQywoeZGQVxmosG7Zz7swU34E30M0Ibm6z43YFe5EBIiniSAzXc/W6sc9qo3piX9oR+gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbquLPvOGvz64+d6sCHjkEtCXavm/ZxncCEniBVyJMQ=;
 b=MnE2EmtR+CJpzhBn8BwHArMk4d7213IDQDDSFTsWTjgVUdVLXJNaBpRJLMWNvuMX4hcgojkmPE9eejm0uA6NsRfo1eY9FAr+9v2DyvlJGCdgQZtV55yu+yRZvIhqlvw161dqH0cPu+zKUHBSImgsgYS2n/k2KjGVLBsgKKnt3M0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 20:24:04 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 20:24:04 +0000
Message-ID: <9a61061f-ad55-4dc6-89a3-46acf6704737@amd.com>
Date: Tue, 11 Nov 2025 14:24:02 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Use huge page size to check split svm range
 alignment
To: Philip Yang <yangp@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251110203007.246736-1-xiaogang.chen@amd.com>
 <591ae54d-4ee6-a31e-8524-53d05f3e137d@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <591ae54d-4ee6-a31e-8524-53d05f3e137d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR02CA0128.namprd02.prod.outlook.com
 (2603:10b6:5:1b4::30) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|CH3PR12MB8535:EE_
X-MS-Office365-Filtering-Correlation-Id: a8ce60e2-c6b1-4310-d43a-08de21604226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q2FoaWVTSDFhcWxONzAzZnhjNFpJYzAvajVBMTl2MWFNV3BNRmtZU1RIQ2J4?=
 =?utf-8?B?UythamZBa2tCSUdFRDZBVzNQNVIzcERaL2ZqQVlvcmhQbVRqVU1tTDcxWldK?=
 =?utf-8?B?cFVQQ0F3R2xxaE8wWnYrWlg1bThoeGJ6alVNam9rNlhHWUYrTWRKOUhtYTI0?=
 =?utf-8?B?enlQcU1hbWswUXBQbXB0UHNaQ1orMy9DU2xpWXNFeDVWTUtZaFo5enMrU1JX?=
 =?utf-8?B?RVo2OE5xTnkwSnI2Z1RjRk9JSDN1Q2g1Y2dnNFJodGNKSittOXhvazE2aGZl?=
 =?utf-8?B?MlNxTkRyb2JsZVkvamRJa3h5WVZrN0t0NUNMRjNjV3B5NGczb2UyVVZsTTRy?=
 =?utf-8?B?bnpGVzZ3S21ZVk1FOEpDSlg5WTJ6YnhhZ2FFT1l2L3Yxc3ViZms4b3hmS1Yr?=
 =?utf-8?B?Z0RWdFp3VU83ZnNwOUtPV2ZmK0doaGU2Y0NUY0lCVVZzVWJkWjYyZE9WYmdt?=
 =?utf-8?B?RlN0K3cvd0ZIaGE3TzhRK1VKaW5oYlIxdTdGVkVZNVdZYW1tRkJaa3BxbWZp?=
 =?utf-8?B?T0ZpYmNLTTJ0K1hxaWEzWDBTZ2ZFaHJnWU1PcTNHQkxwUEh4Z1BiMUVFRFVw?=
 =?utf-8?B?ZDhOZ0c0QklEUlVwMHpSaHR3c0p5Z0k1cE84MHlzcnk5a0FFTmpaejAycHV2?=
 =?utf-8?B?SHpqYm1YeXh5WFRUUlFiQ0R0dTc0WXQ0MmxqQ2x2U2k2L1hFM1p6ZDFZRFc4?=
 =?utf-8?B?UEwxdnByZWVjTEdhck1MMm5CVDA0Ylc2aDRyMHc0cmRHbExTZ1ZxNE9KUDNF?=
 =?utf-8?B?MUpLTUgrSjVad3pzNXFVN1VyWTF6Q0pSNlpNV0k1aXVNeHRlVGw0T3J2OXND?=
 =?utf-8?B?bHJGZ2orcVFqWHllTGo5bHhEMEFvaWxmN0gxK2RtYjJDclRTTGZjRXN5RGMw?=
 =?utf-8?B?UlVBWUVlSXdnVkxUVTZWUVFpRXFWakY3TDhEbkpzbEtFeGE4cmwvR3NFL3Nx?=
 =?utf-8?B?RFdkUjNFQzdFTlpNalVQemRHWjdkRnZWcFA2T2RMT3JhR1lncWJkK2pEWGdR?=
 =?utf-8?B?OHNmOHBoZXpTRVYwclZiYVdyUHN2YVBuNmkvRnVFVEo4NE5sMXdVa1FZaU5v?=
 =?utf-8?B?NHY5WHFXaktidU1UbzFjRFlkV1U2Tkk4ZXp6dHdmYitVS2JzZmx0RDNJWDBR?=
 =?utf-8?B?TUt0eXF2TGpjNW1mVS91WGsyN2xoclBrdGZwTWhjZWYzUUt2VmVDc3BKdk00?=
 =?utf-8?B?d1R1RHJiZnFBWjA5VkJEQU1yNUlhdVY3bWpmcW9uM3c0R2dDSFVQR0dzNGRv?=
 =?utf-8?B?d205STd5U3RCTDZmSnlLa0FWTkMrMnp3d2tBMjBlSGFHZHRtMHgyRE0wUHRj?=
 =?utf-8?B?UlJndlRhaHFRUGFGZnpka1RMVUorNUpVUkNlWjJYcmg4dTdPNjhWcTExT2dh?=
 =?utf-8?B?MFc0OTdQY01pSm94c2FZSENNR0pZUEVQV1JYQlAvWWZWazVmQndSclk1cnRD?=
 =?utf-8?B?RXZWM2Q4NTgrbmNEQ2duODZoRlVxYXhPUDlsQnRzYm9tblA2YXFsdHozZmRa?=
 =?utf-8?B?cFVUSXlYZWN5SXdjZHlXZlJLR0Q4T1JabzVXMHkwbjBuQWpkcC9EZnNhRVJY?=
 =?utf-8?B?Y1hhMEtldklIbC9ZMXZIcHFETldlaWFaSDZVeHNKa3NDM2h3V1o3Z0NHMklD?=
 =?utf-8?B?ajE2eEdIbVAybkZueHd6WW5Mdy9Rb05XdnA4L09adi92cGR3blZtd1VyZzBT?=
 =?utf-8?B?Q3pMZ3R6UStlSEExNTk2dlVxUmNQRDQ3b29sNG10TEVtQkNOMk1CTk9VdVVY?=
 =?utf-8?B?K2JYSVc1VTVLYUk2eWNhTXdtd0tDMUlyWm1YN3ZPcFRSK255UVQvS0RwQnUy?=
 =?utf-8?B?Ky8zTkxIN2NXbTNyYUNSWFZWU1Z5VS9Jc2V6blI0aWpteS9ZSWFJVTJsbjJx?=
 =?utf-8?B?S3c0MzdxRzRPdWo3NWxTdGFSZm0xc3pEdytXVGdsWW52UWR4RlYzbU9YZ2hD?=
 =?utf-8?Q?vJvKWrVWF+qop5D/ZtQ6b5vSkEzL4ZHl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHE0aitWRWExQWRoZGVRVi9VQkVLeWtxSGlsYnAzblRYVmFFM0pxdVVoUkEx?=
 =?utf-8?B?eWJHU3YwN3lQaUVhUU9mWlZaT21pelIvVis1SmE3U2J0dlRDMWtzOE9tSEts?=
 =?utf-8?B?YjV0aTlUOVZ6YkE4TGo4U1Q4UG9FRU84L2xGM1dZbW1zWEJDTTMzcnlEVzFW?=
 =?utf-8?B?b2pMVVhKN2poZ05zb3JQQkRTVnV2bU5qQ0YyUHJyTU1QaUdKdHpYcGF1TkZ6?=
 =?utf-8?B?Ymprb09mYmsra3orRGF6c3c3cEhvUlBlZnc4MzJVK2JVNGNOWWxjTmplWDJL?=
 =?utf-8?B?b1J1NHJORXhVOW5QWFg0Tko4dEg4b3JYU0o4UTNmalNydkFCMWQ0Vnp6UlR3?=
 =?utf-8?B?aXI5aC9xektLTVBhakg1d2VQdU00NkRZc3JXNXFUL2RUWmpmRlhEcWVIQkF6?=
 =?utf-8?B?N3ZDckRsc2pvcjFCUXYvUmpiY09nQSt4ZG5IUkw5aitIbG1Gc2lhOVlVUzJ2?=
 =?utf-8?B?UjBiNi9sZS9YRXZ1Y3AyR1NBRWx1Ulpta2Zrbm1YSG9vRDNSWmxqTEg0alZa?=
 =?utf-8?B?TnE5dDlrNmJDMExZazU0eFJNOWo5aHNCcGpWQUdnZFpkYTd4UjFoR096dUVj?=
 =?utf-8?B?d3RJZ2NYc0ZJTDFaOWdZTkEzZjlVcGVXSFNjUmpodnU3d3Z2SEZlNkJjVEdT?=
 =?utf-8?B?YTV3a2x5TjdsMXNUaEhmWHRGVml4R1dRTnFnbFRSNUFVMC9DODQvY2FUNVBz?=
 =?utf-8?B?RkhSd1prcGptMWZvamxoM2tubU1kb09OekdyYTlhb0FtbTUvaTAzbmRVVUY3?=
 =?utf-8?B?UzFHQ2UvRkZJSG9ENzZuemZYdlhaZzV0c1BLeldlRGcvRzVRUlJ3VThzbkV1?=
 =?utf-8?B?Nm01cUQrVUU5aVF3bWdCemFMQ1Y0K1MxMXhadzNyamVCZTN2azZ4aURxelFr?=
 =?utf-8?B?VTZScmcwbzMyaFJtVG8zM3ZNb3pzT1hRdWlZa1ZFTWdTNDdBNGVqL01KU291?=
 =?utf-8?B?dG5YbEwrMXJVTS9aRTBIYktnN1dnTGtjR2RLKzFFcmNLZU9SQ0NvbGx5TERz?=
 =?utf-8?B?dEZseFpXRFJuME9nOXFRMENMNWNldEx2cmFlUWpxNTlEdmMzU1lYcDJmV0Ur?=
 =?utf-8?B?UTIzK01qbGFYVG9qMXdiOEExRlNwZWtSNFZFbHIxU3ZtUERld2VpNGVLSEpX?=
 =?utf-8?B?cHg1MVVVWFhFK0NOdE9HMTgwU1hRZVhXa2R1enl2RXpJbkhLUFBmc3p3TWJW?=
 =?utf-8?B?S1ArSUd2ZHNsdkNYMXJvcE80dFRudlIvMDgycnlmdTcyNlpBblVRYno0bVhm?=
 =?utf-8?B?ZEJaWml3bU16Q0pKMzY2WkM2UXJwQitKMGhsTzQzRUhoVGFYNTk4ZFZyYVhr?=
 =?utf-8?B?bHRqSEsxbkhtSG1QK3VkS2pCNEFMY3FVcXEwWXFBTjkyQlVTeDZVb25ZNGM2?=
 =?utf-8?B?dEZ4NUdwa3pRRmRlSmU1allvOWVCeWhMYVFVSUdvSkVITUltVmdiSlNBKzBN?=
 =?utf-8?B?bFh4eUNOdEFoTThqaCs3ZmthOUkwQmdCL2tKSFVuaWtQVkV2U1BOMXpKSHQ1?=
 =?utf-8?B?aTh1RFRrd1IrSzd6Mmc4U0M1UDAzdGhEOVJvVGp6R21UVkpvLy9CempxTEJn?=
 =?utf-8?B?Q0JpK0xVQTlCTVMzemVuVW1yWkJQWHBNdVJHaGJ6OUV3cVlqVkt5NEJGYldR?=
 =?utf-8?B?Z1N5UGhMV015V2dUbnA1UUR5dW5OV2NuM203L3pkY1pSaFBRdlhmSUptWm54?=
 =?utf-8?B?VU9DWHBxODd6YzhUWjF5OUFoYVppVUlaMCs4SE8wOXVxcW56TGtxZEtHSnQz?=
 =?utf-8?B?QUJmb05ETTRzeVVPUW5NZ1A0aktiellWN09wMmNQVlNOcW5rZEJGTHhlbmVw?=
 =?utf-8?B?L0tqOEplQVp0aHhaQkZ4TVh2aG1CRTB6bTYrNHUrYU43YTV4T1QyVjR4eXZk?=
 =?utf-8?B?Ri83U0FvYTBiNWlnSGFyQWc0NDRjamwxdEw1ZWdZazJ5eVRpTnZoazBsUThC?=
 =?utf-8?B?U2x3VHVIQU5rd0Y1ZWs4REdsL2p1ZThqbVBPQ0ZEbkVuNEptdnRheWZLcmJw?=
 =?utf-8?B?cTFGU3Z6a1FHOUdxd1owOW5Ody9TeWQxZUMyclFOWXdFV2xLQ2xFWmRGL3hO?=
 =?utf-8?B?Z1FnQjhISnU0c2ROZCtkSVVIeGNwbktaaGwrenZWSGpQanhvSy9wMEtFV3lm?=
 =?utf-8?Q?Lh+w=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ce60e2-c6b1-4310-d43a-08de21604226
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 20:24:04.5293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zUWN2McCggC7ckrHwkljTPhzUpPyUIxeH0q2m92Z87BhSde+xxTcMHeizMw38x5S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8535
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


On 11/11/2025 9:21 AM, Philip Yang wrote:
>
> On 2025-11-10 15:30, Xiaogang.Chen wrote:
>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>
>> Fixes: 7ef6b2d4b7e5 (drm/amdkfd: remap unaligned svm ranges that have 
>> split)
>>
>> When split svm ranges that have been mapped using huge page should 
>> use huge
>> page size(2MB) to check split range alignment, not 
>> prange->granularity that
>> means migration granularity.
>>
>> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 521c14c7a789..3af85c232659 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -1149,7 +1149,7 @@ svm_range_split_tail(struct svm_range *prange, 
>> uint64_t new_last,
>>         if (!r) {
>>           list_add(&tail->list, insert_list);
>> -        if (!IS_ALIGNED(new_last + 1, 1UL << prange->granularity))
>> +        if (!IS_ALIGNED(new_last + 1, 512))
> we should check the original prange size is larger than 512 pages
>           if (!IS_ALIGNED(new_last + 1, 512) && tail->last - 
> prange->start >= 512)

ok, but should be following one?

   if (!IS_ALIGNED(tail->start, 512) || (tail->last - tail->start + 1)  
<  512)

>> list_add(&tail->update_list, remap_list);
>>       }
>>       return r;
>> @@ -1164,7 +1164,7 @@ svm_range_split_head(struct svm_range *prange, 
>> uint64_t new_start,
>>         if (!r) {
>>           list_add(&head->list, insert_list);
>> -        if (!IS_ALIGNED(new_start, 1UL << prange->granularity))
>> +        if (!IS_ALIGNED(new_start, 512))
>
> if (!IS_ALIGNED(new_start, 512) && prange->last - head->start >= 512)

same for head case, should use this?

if (!IS_ALIGNED( head->start , 512) || ( head->last - head->start + 1)  
< 512)

Regards

Xiaogang

> Regards,
>
> Philip
>
>> list_add(&head->update_list, remap_list);
>>       }
>>       return r;
