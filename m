Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 216BDD5B84C
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 16:36:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD14810E533;
	Mon, 15 Dec 2025 16:36:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NhSs1HX4";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011011.outbound.protection.outlook.com [52.101.62.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C7B110E533
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 16:36:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9Y/ot0NrINiEgzfpQrATAFt57Wsm2CO4d3PrvBamB1WDv08pA3caWydgMAMyJKEkrzlabIn3oCuZcxPHWUPmml3ecQmCWxyayYc8aEuIiL6lj+OPtzUIHFfsb+p81/b5cD9+pTVCtPri6/imC96O3HprCsBoWnfXg9FyX51n1IMMnHHVFX81yot2m3r5MEQEBivHGnM29ommp+zH1SCGxQcGlR2xLm1q2QG6hm1rQWwWU3zLaCpEP+HbW4QFsL4zpv1t3h3a9LvM0HdYb0jY/UNyNZwvg3g3HxLjOIrtSlt3telVd/+vw48GnfyjdtZy6H8CYxViK3vIKij3B8/5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mC02MTWj+K1vTsrfM5SA57SV7nM19suDEw7v+Lr/w+s=;
 b=YoT/ZIJ/JIyGDXMOHgaLvj5p7OFsPomQAph9Urr/Q7TifZ8VUPZKs3w2v+gxJYba+sD5b+uj8xefozBRr6XYC5difXFELAdLiW3buTfcKr01DK3pGamwr0k3fn7f5ho8gDetZgdMOlep2ZI1cJqxllNTeDy740+zE1wonhqNqqHAl1ve0XutBISAHn/IkTFewn8kvoRw/L6BgPd9tRZYrJb76JTvwkTUN0unTunzPfmDm8ICv0iLPtPxI6f2Sn7g/umA2xkxJNoDmnfxoNZBd4pK9IQKh021Y8UMW+QDbH1OdpCu6c67FBES4KaW76Sipvvi0i+xIRYQwQPSXO0cUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mC02MTWj+K1vTsrfM5SA57SV7nM19suDEw7v+Lr/w+s=;
 b=NhSs1HX4PuCpRxkp0U2qVoqzghcyK/QjMSVT8CHj/9kFFRuViFtuqgvHFpJkAqzpuikfcR9R2fvMT/c9skD0MCvfVtlET8US53Jp9iUIHJkgNcCrVjy4nklm3qbqyYjU5DgqNSAPcWs+Qa4iM5ytwjMxcSxKDNNc/6nVyrwlcoA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SN7PR12MB8792.namprd12.prod.outlook.com (2603:10b6:806:341::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 16:35:59 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%5]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 16:35:59 +0000
Message-ID: <f6649909-cf18-48a0-b930-7bd3d60c7d16@amd.com>
Date: Mon, 15 Dec 2025 11:35:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] drm/amdkfd: Map VRAM MQD on GART
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, david.yatsin@amd.com,
 pierre-eric.pelloux-prayer@amd.com, kent.russell@amd.com
References: <20251209234328.625670-1-Philip.Yang@amd.com>
 <20251209234328.625670-7-Philip.Yang@amd.com>
 <8c9dd8e8-35f8-493a-8457-be027581ead9@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <8c9dd8e8-35f8-493a-8457-be027581ead9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0272.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::13) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SN7PR12MB8792:EE_
X-MS-Office365-Filtering-Correlation-Id: d04b42ec-1bc8-438b-e1bd-08de3bf80733
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cnVPS1NJWDROb3dDcUVPTUVrdjVXRnJJelR5OTl4TUZ3UnBmUE1JdkdKdXAy?=
 =?utf-8?B?aExvQ2xRcWR1R3JTRUFCUVhxTWZzUmtqNXhIN3l5UHM1RUpBWVBzRFRpWktu?=
 =?utf-8?B?Mk43MzRRYTFlWWprUWVFWW5qMWFLOHZabHNvYzFRVlNZQ0VDNkozOEJ4d3RE?=
 =?utf-8?B?aks5K3JROTdJSWR4OVRGYytjTC9iM3Z6UklpKzh3MG5CeG52bll3VEh2TTl5?=
 =?utf-8?B?Nng4RWNCT1BZTTIrakwyem4yaUo3MkNNN1BQS3I0bTRtRlRVUGpzVGtWUG5Z?=
 =?utf-8?B?TkFxcTRQajZYMi9aWUNkUWxVVHdqdms0KzlkY3RwcXBkQlFHVXdtM0hldlFN?=
 =?utf-8?B?Qnpod2xnbElSN2d3UFNYYmcybWZQdmM3MjZrUDM0RlpRVUoyWkZnTEhiWVRp?=
 =?utf-8?B?NHl0dXdiZWhmNi9hcUEwWU5YdmFGUVkrd3JnSHNBTGZydk5zRS9OTDFKcmNk?=
 =?utf-8?B?U1VBNEVrb2E0VUtkMW1sT1pldGVQL1YrYTFzNzdoY21tVExITkdtcSs1aWI5?=
 =?utf-8?B?MS9tQzNpeHdoTmdJT3BsblQvcVpEbXowYkN6aERKZ0JlWVlUdGh3cE9ydU9J?=
 =?utf-8?B?MEZ4NnBXK0RUQnBySHFqZEVIUzFzSmZTVHJIVVV2WjhlbVFFbGtRSTJhODVl?=
 =?utf-8?B?YWZpZHBId2l0MzNOZnJ1R0lVVnp2cUV5V3V5Zm9wc1cvdUw3UzRmZ29oQ29a?=
 =?utf-8?B?dUZzSjFsalJneTdtYU1OTzE1M0lDS3NrZGpWU1Q3MkxtVGxBczRXSU82Rm52?=
 =?utf-8?B?S2dkenBDZ0Z5WTJTN1psMjNQT2dpVnFQdWZ3KzFmbnVZWjlGYUdoNlh5eWUr?=
 =?utf-8?B?Q2YxZ2NKbVYvVnpxNVRTYUNaMVBUZG8rU0hyNE50Zzd3WjRodzVmZll2OFdC?=
 =?utf-8?B?c1dUSU5rNFE5TytwQzEwejJkOXhibFlGRGh4cG9hZTA3bnVzdDFNUHlFL2ZW?=
 =?utf-8?B?Vm12a0ZxWVpJQVJsUCtQUHdJTXhOcVo3Nm52dUhlcFN2cDhMQXIxSGFCRzRY?=
 =?utf-8?B?dzBOVE1KL2dLWGVzTnN3cjl6aU9CL2gzWlZob211dHd0TUFheXdCZkc2ZEMv?=
 =?utf-8?B?bzJSaGNJMWxmWU1LSWxHRklPOVVxMjQvUGNGeER3SU9iZVZ3aW9mKzQ0YkdM?=
 =?utf-8?B?d0VVVGRLRDFYeE85TXhpSksrSW52djllRzA3NUpSaVVML1REWWFzQ092M2Rj?=
 =?utf-8?B?RHlFSHJzSmxteTRmRXlTem1MdTVXVVZxREZmS3RZalI4dmtsUlh1MS9EdnNE?=
 =?utf-8?B?K2ozQ1ZVMHNjQ2lDWFJJaWFIS1FQeVBaVndUTDZPNG14T1VpZ1RWVHJuOFV2?=
 =?utf-8?B?cy9melNFSEN3WjUyT1F3LzhxTkg2aHVzeEVRS0ZDZjFpRjh3T3dPQmtvRlRQ?=
 =?utf-8?B?VU1kRFU1b2pEVU04VmJlT25QY21vc1RXdk9LT3lZbFR6WE5LSEZkZlpRdlpl?=
 =?utf-8?B?NDRhbFowQ0k3T29MSGE2Z2tib2Q0V3RweFgvRGc5aHkwWFYyaGlZc0gybTVL?=
 =?utf-8?B?VUswY0RNcEJ5UWxIQXNzbGdPNkZHeldqT00rcGdxUHgrOW1USWdCK1JaajQz?=
 =?utf-8?B?MlVodnVTZjRjdUhwei9TSmpYdTNtN0dWZ1JGL3FaajF4RnVOeXFoUzlKRmdM?=
 =?utf-8?B?WDlOejBJQlZ2c3FGYUJOUmJzNTR3QXNQR2J2dEFyQmRnR29rbjdKYnZ3VE5v?=
 =?utf-8?B?ZE9XZDVXMjM1Zi9XSDVYcjdyN1JaMWRsb3M3aGZickFTaU5qRGpIRkpXclYz?=
 =?utf-8?B?RFJPQXoyVHVPT3JJUnJNcDFOWjVjMDNVa3d5NzJFWlB1WFgxWFFkTXdmUUhw?=
 =?utf-8?B?Z3MxNzM2QXZhR1BOS0JyRjI1NXV6R1hrdldZTmFqUXlMOGlCcndVV1A1KytE?=
 =?utf-8?B?Sis5Z3JnS3NMaFd3bFltNXVnYWNZUTRZTmF1QmlhOVc5TlZyNE1jUHhIbWk0?=
 =?utf-8?Q?o9x/Gaw3PWPJpJ+2u/N9AiNBeACTJOKR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmk1SEpJaWV1MDNJZlR2bVVkNXJKNzcxQi8rVkpvNzF1L1BnVlF2Z3p5K2pn?=
 =?utf-8?B?ZGVWUS8vcmZ1SEtHSmFyTVBSZlhXWFdSLzE4Z3U5bjNqZ1RlWHFPZkxUMmdm?=
 =?utf-8?B?dEFJaDg2Qmx6WVBRNDQwK282MDlxWHQ2bG13T1BCdDBvZ1o5UUJYYWtDcE9L?=
 =?utf-8?B?SWdrUnJIZzR1VENpRXE4b3diY3RTdmxXM1NyVHFwbjV6RU5Sem1pUEdMRG9y?=
 =?utf-8?B?VVhYVnhnc2RMU0xuMDlyZktkSCs5SHZOQjdLc1VkRVdscnlQODI5Sm5YREpm?=
 =?utf-8?B?VXFGL0lMR3FQUDQyak5PcDNVVWsxaDFQa2piSXZxRlJFUWZINE56czhycVAr?=
 =?utf-8?B?MllvM2gxeGRpK29LS0hZaW1sMXgxOVBobFc4L1pHZTRheDRZdGQ4Z2YybTVz?=
 =?utf-8?B?TjdkaFBVQzMrZy9PQmZ0VUZZOTJIdGdZWHNjVXBKaTZjV1c2UHdnU2xlcENC?=
 =?utf-8?B?cFFKT0N5UkRCZ1gwUG5GTW9xV0VjVlpwT3hCZk5qaFBtWGtIb0xueUNFTGx3?=
 =?utf-8?B?enFkY1NzMmpHZE1mZ0xhNkQ3UEl1ZHQyWjNJRi9mWGpUSVJUL3RBTEdpSDNr?=
 =?utf-8?B?bXdqbmhoN241TWh0ZWVTOEVhdExtbC94ekxkYVRiTldtQ3dZamdUekNuVnNx?=
 =?utf-8?B?TVN4Z2V2bDBoY1BXVklnZ2FTL0szTm5JL2dHUkJwd3BxaWNEenZ1MW5tMUNr?=
 =?utf-8?B?Zk9TcVFaR0Yvd1BqY0tISjZkM21jSkRBUEVkWG5oZnY2Q1JHNnZhVi91V2tP?=
 =?utf-8?B?OVpjSHljWEREazQrK3pWZDFLQ01KL2I1MThsazY2Vjd3UkJFSUMyVVl0WXpu?=
 =?utf-8?B?N1RzTDFySm8wRzdWOTZNZ1hYMUxRcEpBdkdacVVja3VSbnJMd2dZYlBLcFox?=
 =?utf-8?B?SnBRcjBReFBZeWVoUGhYU0llK053NmxKQ3NXdXVXVlFSUjF1Zkc4YVNrMkND?=
 =?utf-8?B?RXh4Tzh6Z05Mb2hUYi9jUWRhMEZKZVNRVmt1MGZHZ0VoaHU3QmdWeU9DSDZi?=
 =?utf-8?B?TDJDUmJNSytzcE0rT2hXdUNuOXNKL1FzSXF2U24xNDRrTWZhYU14RzQwUDBr?=
 =?utf-8?B?WGlwOGdhWXVZNnprSkFsT201S2xaNWVVZ2xPdFNvaGNmNTBScUZ1YnVJQXBn?=
 =?utf-8?B?blk5dHVZNDFWV1FUNkI3K1lHQXhRY1BvZHpiWnNBajAwdTNTOWpvMW5qN0Jw?=
 =?utf-8?B?WWxPa091d1NBbUpTOUVFUEtoRlIvcTE2MWdabk0vMVFTUjhFMEJXVG5wbFU4?=
 =?utf-8?B?eTJsTHpTemRmZU1saUFGVEw1TVVsRUdneDN6OEt5K0hkSmNuODVBaE9TcHhE?=
 =?utf-8?B?OHdubTBZZk54ZjcvZGhiSXdZUU1GdjFoQlV6Vk91QTBORmlWM25abXpjcEQx?=
 =?utf-8?B?U2dCV2pHSVJMYStoTXZTLzBub1R3ZWJVamdxaFlNSFdBenZvSUlYZ0d1N1BT?=
 =?utf-8?B?ekQ0V3RnWHh1L09DdzI2a0swY1lBWUc2UjBTMytpbDg4eWJlZmpuYjZDN0w4?=
 =?utf-8?B?WDBPWmFzVGYvblJ5OWZCRS9UMWxiVjE2NlhaUlRQTVNtR1g3N2F0d3oyK01N?=
 =?utf-8?B?Mm9YVkNMQkUvU0dKWlc4elRoNHhmOEJHeEw2anA3QWxiWFdKYitEdUpqWTBZ?=
 =?utf-8?B?dTBZdU5mT2JHc2pqd2hkTVNkR2VhZkI4dGx1Sk9nUENzdGtFSVB2V2p4ZWdk?=
 =?utf-8?B?VHF0M1hYaXk0cVV0ZHZjdW1OYTNON21TTXd1OTFjR2lTcmErVENpUDdIMlBr?=
 =?utf-8?B?RExDdUl4NHdYKzFsZS9ucmlZQ0JGcDdDQmtSdUdBdnRoWEZVTTUzZ3F3WWV3?=
 =?utf-8?B?cXcrK1RYRVNaQnBuQVRVMktxK1g4cU5zZkpucG1EN1hWdGtwN1JrTUluMXNV?=
 =?utf-8?B?bVY4NkloZ0lMZFlLandUVGtPb3g0RHZMK3F6NlBOOWFhTlVJamJyL3I4a2x1?=
 =?utf-8?B?SlBDbUhUQ1IwbUVBbURXeDM1UHpJckFsMkdyVUxMbDhhSWxIa05iQnhBK3l4?=
 =?utf-8?B?dWxIQWdwcFVQUVU4QVl6dGJlczE3bUFaZUNFcTBGSER5RmVSZm9FN1B6Rlo1?=
 =?utf-8?B?Y1V1Mm92cDhjS2EzRXRZTkxueTBMRHF4OG05blZoU1lYWkJtb1RaaU5OSTBo?=
 =?utf-8?Q?I+DAat3Lb5F46qxksCmZoRD9m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d04b42ec-1bc8-438b-e1bd-08de3bf80733
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 16:35:59.2943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8zXeANlpHY0tjm0WkVSCWzECaUvew1p+ErzTuZhzhzOlRwIMfQClIdf0uy+um0Zd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8792
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



On 2025-12-15 10:20, Christian König wrote:
> On 12/10/25 00:43, Philip Yang wrote:
>> MQD BO on VRAM access via FB aperture is mtype UC uncaching, map
>> to GART as mtype RW caching, to reduce queue switch latency
>>
>> Add GART mm_node to kfd mem obj to free the GART entries after
>> MQD mem obj is freed.
>>
>> Use resource cursor to handle VRAM resource which maybe on multiple
>> blocks and use cursor_gart to handle GART entries.
>>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 89 +++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  4 +-
>>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |  2 +
>>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  9 ++
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
>>   5 files changed, 104 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index 4f8bc7f35cdc..ae4f60aeed14 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -880,6 +880,62 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
>>   	}
>>   }
>>   
>> +static void amdgpu_ttm_gart_bind_gfx9_mqd_vram(struct amdgpu_device *adev,
>> +				struct ttm_buffer_object *tbo,
>> +				struct drm_mm_node *mm_node,
>> +				uint64_t flags)
>> +{
>> +	uint64_t total_pages;
>> +	int num_xcc = max(1U, adev->gfx.num_xcc_per_xcp);
>> +	uint64_t page_idx, pages_per_xcc;
>> +	struct amdgpu_res_cursor cursor_gart;
>> +	struct amdgpu_res_cursor cursor;
>> +	uint64_t ctrl_flags = flags;
>> +	int i;
>> +
>> +	total_pages = tbo->resource->size >> PAGE_SHIFT;
> Please use tbo->base.size instead.
done
>
> And it would be nicer if the calculation was in bytes and not pages, but not a must have.
tbo resource and cursor start is bytes, GART entries and cursor start is 
page, but it is too much changes for drm mm_node
to use bytes start.
>
>> +
>> +	amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_NC, &ctrl_flags);
>> +
>> +	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 4, 3))
>> +		amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_RW, &flags);
>> +
>> +	pages_per_xcc = total_pages;
>> +	do_div(pages_per_xcc, num_xcc);
>> +
>> +	amdgpu_res_first(NULL, mm_node->start, total_pages, &cursor_gart);
>> +	amdgpu_res_first(tbo->resource, 0, tbo->resource->size, &cursor);
>> +
>> +	for (i = 0, page_idx = 0; i < num_xcc; i++, page_idx += pages_per_xcc) {
>> +		u64 start_page;
>> +		u64 npages, n;
>> +		u64 pa;
>> +
>> +		start_page = cursor_gart.start;
>> +		pa = cursor.start + adev->vm_manager.vram_base_offset;
>> +		n = 1;
>> +		amdgpu_gart_map_vram_range(adev, pa, start_page, n,
>> +					   flags, NULL);
>> +
>> +		npages = pages_per_xcc - 1;
>> +		while (npages) {
>> +			amdgpu_res_next(&cursor_gart, n);
>> +			amdgpu_res_next(&cursor, n * PAGE_SIZE);
>> +
>> +			start_page = cursor_gart.start;
>> +			pa = cursor.start + adev->vm_manager.vram_base_offset;
>> +			n = min3(cursor.size / PAGE_SIZE, cursor_gart.size, npages);
>> +
>> +			amdgpu_gart_map_vram_range(adev, pa, start_page, n,
>> +						   ctrl_flags, NULL);
>> +
>> +			npages -= n;
>> +		}
>> +		amdgpu_res_next(&cursor_gart, n);
>> +		amdgpu_res_next(&cursor, n * PAGE_SIZE);
>> +	}
>> +}
>> +
>>   static void amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
>>   				 struct ttm_buffer_object *tbo,
>>   				 uint64_t flags)
>> @@ -1017,6 +1073,39 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
>>   	return 0;
>>   }
>>   
>> +/*
>> + * amdgpu_ttm_alloc_gart_vram_bo - Bind VRAM pages to GART mapping
>> + *
>> + * call amdgpu_ttm_alloc_gart_entries to alloc GART dynamically
>> + */
>> +int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo,
>> +				  struct drm_mm_node *mm_node,
>> +				  u64 *gpu_addr)
>> +{
>> +	struct ttm_buffer_object *bo = &abo->tbo;
>> +	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
>> +	uint64_t flags;
>> +	int r;
>> +
>> +	/* Only for valid VRAM bo resource */
>> +	if (bo->resource->start == AMDGPU_BO_INVALID_OFFSET)
>> +		return 0;
> Please drop that check. We really shouldn't touch bo->resource->start any more.
How about this check, if MQD on GTT for other ASICs, that is already 
mapped correctly.

     if (amdgpu_mem_type_to_domain(bo.resource->mem_type) !=
         AMDGPU_GEM_DOMAIN_VRAM)
         return 0;

>
> Apart from that looks reasonable to me, but I'm wondering if GART re-creation after GPU recovery will still work or not.
The color parameter is removed, the GPU recovery path, gtt recover is 
not affected.

Regards,
Philip
>
> @Pierre-Eric could you double check that?
>
> Regards,
> Christian.
>
>> +
>> +	r = amdgpu_gtt_mgr_alloc_entries(&adev->mman.gtt_mgr, mm_node,
>> +					 amdgpu_bo_ngpu_pages(abo),
>> +					 0, 0, 0);
>> +	if (r)
>> +		return r;
>> +
>> +	/* compute PTE flags for this buffer object */
>> +	flags = amdgpu_ttm_tt_pte_flags(adev, NULL, bo->resource);
>> +	amdgpu_ttm_gart_bind_gfx9_mqd_vram(adev, bo, mm_node, flags);
>> +	amdgpu_gart_invalidate_tlb(adev);
>> +
>> +	*gpu_addr = mm_node->start << PAGE_SHIFT;
>> +	return 0;
>> +}
>> +
>>   /*
>>    * amdgpu_ttm_recover_gart - Rebind GTT pages
>>    *
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> index 28511e66d364..a8b8a541e21b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> @@ -140,7 +140,6 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);
>>   
>>   bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
>>   void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
>>   int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,
>>   				 struct drm_mm_node *node,
>>   				 u64 num_pages, u64 alignment,
>> @@ -192,6 +191,9 @@ int amdgpu_fill_buffer(struct amdgpu_ttm_buffer_entity *entity,
>>   		       u64 k_job_id);
>>   
>>   int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
>> +int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo,
>> +				  struct drm_mm_node *mm_node,
>> +				  u64 *gpu_addr);
>>   void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
>>   uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
>>   
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
>> index f78b249e1a41..edb72f4ef82d 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
>> @@ -225,6 +225,8 @@ void kfd_free_mqd_cp(struct mqd_manager *mm, void *mqd,
>>   	      struct kfd_mem_obj *mqd_mem_obj)
>>   {
>>   	if (mqd_mem_obj->mem) {
>> +		amdgpu_gtt_mgr_free_entries(&mm->dev->adev->mman.gtt_mgr,
>> +					    &mqd_mem_obj->mm_node);
>>   		amdgpu_amdkfd_free_kernel_mem(mm->dev->adev, &mqd_mem_obj->mem);
>>   		kfree(mqd_mem_obj);
>>   	} else {
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> index 14123e1a9716..5828220056bd 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> @@ -148,6 +148,15 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
>>   			kfree(mqd_mem_obj);
>>   			return NULL;
>>   		}
>> +
>> +		retval = amdgpu_ttm_alloc_gart_vram_bo(mqd_mem_obj->mem,
>> +						       &mqd_mem_obj->mm_node,
>> +						       &(mqd_mem_obj->gpu_addr));
>> +		if (retval) {
>> +			amdgpu_amdkfd_free_kernel_mem(node->adev, &(mqd_mem_obj->mem));
>> +			kfree(mqd_mem_obj);
>> +			return NULL;
>> +		}
>>   	} else {
>>   		retval = kfd_gtt_sa_allocate(node, sizeof(struct v9_mqd),
>>   				&mqd_mem_obj);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index 29419b3249cf..fdde907836fb 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -252,6 +252,7 @@ struct kfd_mem_obj {
>>   	uint64_t gpu_addr;
>>   	uint32_t *cpu_ptr;
>>   	void *mem;
>> +	struct drm_mm_node mm_node;
>>   };
>>   
>>   struct kfd_vmid_info {

