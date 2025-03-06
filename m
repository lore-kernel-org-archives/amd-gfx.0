Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 482E3C282D1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 03:50:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B96AC10E0FD;
	Thu,  6 Mar 2025 03:50:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sX28fXO4";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C384010E0FD
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 03:50:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wiiVRAQ1WMR76ujgjViosRU3NkSSFrJdJYkonTLVD9gIaV7j5gVSjXbnYvT4QAXKGV7BiDH5IsYLiJY2trCF59VBAtmWjbmLtjHo1hQDKwc8oYqpj9rgPO4Kc3s7H0mc2lGF5u2i3Aj7xgyS57rbjK8PfIBGZhffsQR4BHGV/O6YF+uf4BxBV4d06jvE96hrjv6PGHjLzMfMHDOLHHBaEEW3c1D0m3rlVRAaPM46IrGF6QToaDlTgtsLMsnRKKrknH7D40oTPvcom7RhGv3z2ESNGN7iOv6pqcp9NviLBQ0nA+r8WI1Mpfr9JNSQIyWw5KqfmrGhHTLnODKjuYzdqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evL1jXWlyLowQsD5HqLOFTzSzhRzkGIePYRT5Tng//g=;
 b=nrLBSFZfcSPb5KQt9DPmztGcOJyeYVghZTmkNE9heGkadE3wE9hXrO+ZYz0B6xVJ15OzfK+8fSVyzcwke2dWx1lUPH4pxX8viOjZUs4/eo/a/+OuBJhas5gNh716PABkCQNj+ycvLIWVq8mV+x+HKF/d1cGGm97z0sSjQ+Hehaz2M5dErgQw2WHK/bfymyltIyYrH7fjvX7u45q8xfX8s37XiBtX/nR0OBAlqGK9Uv2DR4goB8G7sumvMBMRwTicAwUBbBorx7QWEi5E92uR8RiS4zzUdqKoIRzFygQhnqYk1ipaePwF1DsxtzidbPBvWxPwwDpdJstYy7EBZczL4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evL1jXWlyLowQsD5HqLOFTzSzhRzkGIePYRT5Tng//g=;
 b=sX28fXO4E1XkNbq/OeQt/a/PQJP5aoOwvJYdgrx6qRyOid+yz7EIRVRt4Bya7R603uobtIlWLBy8wAUtaMbEXcBJLTtcJ5pSvlchNn+1m4u3hIwwrxy9k3uhPl6WR444dSYpTd8fOv/BjA5sXOfst4dUNRp2qVo7m9rZ4na5htA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4402.namprd12.prod.outlook.com (2603:10b6:5:2a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 03:50:25 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 03:50:24 +0000
Message-ID: <7ee7f8be-4c12-4c85-9b5c-f11f93224f77@amd.com>
Date: Wed, 5 Mar 2025 21:50:22 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Fail initialization earlier when DC is disabled
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250305213742.13559-1-mario.limonciello@amd.com>
 <5f8f95a9-ca19-4d28-82fc-7445e2be24ba@amd.com>
 <CADnq5_P-i0TJ35Q6EEbT6994=BH2tjE5Fj_236rfK6wn8OXDFQ@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_P-i0TJ35Q6EEbT6994=BH2tjE5Fj_236rfK6wn8OXDFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR2101CA0017.namprd21.prod.outlook.com
 (2603:10b6:805:106::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4402:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e0e1fc0-96e9-4995-579a-08dd5c6206a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2cyeXBEaFd1ZXd1dVZmeGZ1aEwxRG9xbDQ5cU9wTnR4ZzFiR01yWkdObzlU?=
 =?utf-8?B?VUQ3aVZKb2YzeVJ3MDRFMExPcWV2YUtBQUlzMU9TeHltbk0xTmpOa0Z3b2Ru?=
 =?utf-8?B?MTdYdHVIcWU3MS84RmplcEh4aDFQcjlYVVZ2NnFzWFVJNTArd1hVc2RuZEpQ?=
 =?utf-8?B?M0lqUk96bkQ0MVMxWTBnc3BzUFpCQXRzeVRKRE5NbjRKcTl1SDdUWDNIYnlr?=
 =?utf-8?B?SlFhV2Vyd1BRYnJ3YTlaWXlaKzlBSHdRMkRiM3JEaHV6RkVUTnlZMnNqRE9C?=
 =?utf-8?B?eVNvNjlHdUQ2Q1FPWmtqZWZHQUNKbXRwQ0pNTWkyQ2puUTJ4eDZFenNvM1lR?=
 =?utf-8?B?QThVU0ZxQjNKZjEreHFDRVdFWVh4ZUo2M2M3NDUwN1V4YmZKZnBzVGtuejY2?=
 =?utf-8?B?eE1zMExRSVpTUGZLeVQ4TlJSVEovemM2MEZmQ1ZnVERJc2lVZGMwa2kvR3l2?=
 =?utf-8?B?SjQ4Z1NoVzlHOTRPcnIvS01BOGk3VVArOVNBSWdsaHFxaUtFYjRDTlU5MG41?=
 =?utf-8?B?bWZYWWYzaTZsUjJUbHlnZnpra2YrVUxzOGp2WWphMUtXaWNaWHFBUFlLYUFv?=
 =?utf-8?B?VndtZWw0WkhqK3FWQWpqMGlqb3hvNGhSRnVySlp5VFpubUdqNTA3R1pCMkpp?=
 =?utf-8?B?QzhvNWNCNEpsZHA1bkp2eG1WaGdkZ3lBZnFRelJwNVFndFJvZHFVNFV1dmVo?=
 =?utf-8?B?TjFHM0FYTVlPc2xlQlV1SHRmRURsQk5jRXJiQ2x4RHBvbjVEaTFWd3cwUWZX?=
 =?utf-8?B?R3oxaWFlTWprbUM1b1U2OTAxZjVzZ1d3T0FMNUw1ekp4Unpad0dKWFlUQXd2?=
 =?utf-8?B?R3h6bythOUFSeXZhZ3FRK2VUaHovY2VSYWJ6MkhncjY1TEYvQVVnTzFndVN4?=
 =?utf-8?B?WmhseTdIV1lINEgzQU1OYyt4UTdPanVxemVOcUxoZVpRRHFacHVUVUpHYW1y?=
 =?utf-8?B?ZEt2WU15WHVZbWt3cTN5ZWFOYTZOb2RDYVF5ejd3REk2dkFFRGN2RStiVmpn?=
 =?utf-8?B?b3ZNcjFTQUtCUzU1QnMyS2dCRWZ4a0lxK3ZpTFNXaXU5dHdmMlhIT2EvU3lz?=
 =?utf-8?B?ZzB0Wk9PLzM3Q2xjWkhib1Nvb2hWdjY1RWpWNUgwVFhhQk1LcDA5Qzg2VURB?=
 =?utf-8?B?T284Q2JqOHpUZitodGRtcmZrblFkUkw3MnA5WUs3c0x2KzhzVHlDU3NDeW0z?=
 =?utf-8?B?UTA4Qjl5aDJTME9KVmdhMFZrTmg4NVhWdEdhNkFHdzBueTZFdW5wVUZlUE1i?=
 =?utf-8?B?aldNWEM5dW53SUJ3NHFUTnA4bzJoNHlLRjNyR3NrdmFDRVFIUVBNTXN0Z2xx?=
 =?utf-8?B?bEw5cS93ejFFME5lekhVVTFyallOMXZ2MHNzV2dPeUpDRW5TQ1hGMlFRMzQ4?=
 =?utf-8?B?VTdkemM5dGVLUmc0cENOZldvTmpTZ2N3eGtpbFd5dUU5aW1CM2pHU2ZQVnR4?=
 =?utf-8?B?NFdzZHNGVDdlSDF4bDhFWUtIVVhvL1pZQ2drSVFzN252OWhQYWRyWTJpemIw?=
 =?utf-8?B?cVEyRTNQWTR4U0FKRThiY2xKQWdZNzdtbE9PZE9PUGhUS2U1RXN5am1RUERE?=
 =?utf-8?B?ejg5ZSt1cVZRUDFac2c1TEMva0IzTzg5RDNVbit2THRIRUJLUC82clI3MkJt?=
 =?utf-8?B?NzgyWTc2MVBJdnV4TmR4ZW11L0gzMDhnVG1sUjJkMHFwM0tXdkV1eVVaM1JK?=
 =?utf-8?B?TDV6bzRGZWNSMHhXTStOOUNkeHZ5aC80YnhnMGhWZTJNdkc3eVhBWTBsQWFy?=
 =?utf-8?B?TTNINjZ3SGg0b3RjK2Y0ZlZqd3d6WElKKy9qY0h4TmFyM0hsRlc4V2dDL29Q?=
 =?utf-8?B?cmc5T2xkZ1BEdElGM3hpbURRMWQxUmJ5UzFFWi96VXVKRFhPdmxWSFdkMnBP?=
 =?utf-8?Q?q9EBZbwvn5IXi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmVRWFNsaUZrN3lUYjdXeXhGbUd4ZWtMZEE0bFNQZmNJM1cvMzVISURzWnZR?=
 =?utf-8?B?RkY2Mk9vZ0NMclNNcmlHNjljT2NrK1BFNEkxQldNV2l2RmhWR1FkZENOYk5V?=
 =?utf-8?B?eEUvVXJZY0dJR1ZhcnVSUU1zdzBMZGR5eGxHSnRFOWJVS2wrVzN6eFoyRHlT?=
 =?utf-8?B?TWs1QnBmYlp2ZzNRWEU1TEFnRjlsSEdXbVdzZHZYV2U1SzJxV3NvOWNURjUv?=
 =?utf-8?B?eVNnTUgvbjloZi9TcFNScTdoVjY2OFAwbS9neURTSWNLMG43eGhQZU4xekJ5?=
 =?utf-8?B?R2M3bkgzNGJKVHc1VUkxbmxqRWtYakhZcEdIbEdLaGhjQkJndTJIS2JVeWpK?=
 =?utf-8?B?RDBBTWk2K1doMUw0UkZkQy9OU3A5TGJhZzhrYWYwNUpKRmZIdWhLZEMzcHhW?=
 =?utf-8?B?ZXowclV2NEZHRms4RzVYQVNObFBRbmF0ZThDNmZxTGFaRW9UK1pvSm80K0xD?=
 =?utf-8?B?WVptNURIQ3FZUjdIZHRXZGNpek9uK3MzT3Ztdm1sUnlnMUNmUWpYUnlDbmRM?=
 =?utf-8?B?b1FucmlhNmtOVm5VNjA2OGlvcU5DRHBLK2tCeVQ1M3VETzE0eXMxZnE3MFNy?=
 =?utf-8?B?QWdOeE1LRHpSaGpQT25zR1RyOTdJVWVBcEtsV2VTcUVjeVRIQ1NVaEtaUHVL?=
 =?utf-8?B?Vk93bXl4U1ZQMkZsSzZaSlJvZXpER2RrSGFZeVJjcS8wbmF5empwbXJYcHJF?=
 =?utf-8?B?RHdXRWFRUGZxQkgrYWI5K21aa3MyZGpnUUV3Zi9vKzU5WnV2MDJQSm04dGI2?=
 =?utf-8?B?MW16YjUrSll1OUFaWklqS21hZGxzR24xcDd1SUtTQXV3MG9JSkNsK2Y2bHRM?=
 =?utf-8?B?L2NWRzh2b2twcWFucWtwcHFyRUlPOUJYTXBiQ0xMWmxNbWFNenczalkzNU5l?=
 =?utf-8?B?NGxWak5EbnF2S3ZsaDFkUS9qQnVid01mVEpyem1FNVk1QTlmY3Z1OWwvSTUz?=
 =?utf-8?B?alJxenlyODFRRFdaMk81MXNZVkF0dlVIdzM2UzVoTkZLSUlPekIxR2dOdXBi?=
 =?utf-8?B?NHpPUkcyVndlZitmaDdEQ25MeEEvQmUwRWd2WVVYQWdCWWZjWjRoRUNnYzBR?=
 =?utf-8?B?OUlBc0luVXBDcjUybTkreEVwUnBZYkpIblZUSXlYbVo2M09kam8xaExET1hU?=
 =?utf-8?B?SVg2YUQzTFVkdXVOcHE3WU9Nc1VWY1plcUVWQXdITXRWS3U4WENvemw4YUZI?=
 =?utf-8?B?RlB4bHpGeDNVdW4zOWNyWGZVRDIvbjBmclpuWFZ6aVg1K1NGZGlMOFJxUGdq?=
 =?utf-8?B?NWRWZXVOQ3E5dkRTY25XM1NQLzNYUFI5OG04SUIzakhNYjFROFlrclNUMzN2?=
 =?utf-8?B?ZXBuT0ZMd1pVenYrcnczK1FQVXZzY2dBSDB2bU9xK1dIZC82NjlNelhtaXhu?=
 =?utf-8?B?bUFrNEdFTHNsRE1rdlFVSVdQN0ZZQ0dJeGFyZEMvQjJRYXVJMkFad3lDeG5O?=
 =?utf-8?B?bUcxVEhDOFJaWk5IOTJrN29oblhTTWd6N3FCdmFPOUE0dlBLS3JQKythaUdh?=
 =?utf-8?B?MTlRTUV1d01MUUNxL0E1L0xwSDRrSUpMOC94dzJJR3I5RmlRdlZIS0VzcnNt?=
 =?utf-8?B?b3ltQnpQcUZWem4zVWZ0Q0YxTENvMmR6UmNjK25EckNhSDlnaUdNNUllVGtH?=
 =?utf-8?B?dDhvTXk4aXljTTYwUjE4aUEvZlUrbmg1MndtRis2U09IdXFYNWdianZ5UTdM?=
 =?utf-8?B?RzdZdUpGSnZ6MGhvRUpTMTEzUHZyaThVM3ZLZVNkeGlpU2dLNUNQaEVNWmE2?=
 =?utf-8?B?dWF5RGRRZDFNMlN2UXVNM0hyNjgvbjA1Q3RGdDRTaTBLbEFQd0FkdFlXQWVq?=
 =?utf-8?B?dWVZMkU3U1Q2WFB1ZFhXRGFDVTV4Q081cys1dHZDVlNCOHRBWVhmbFh0dXRn?=
 =?utf-8?B?Vmh5WFNCc1BMcVkwOGRSdHluQVNpRFhRTStFSnIva1BZWXJOUHRobXVkRy80?=
 =?utf-8?B?S1oxNDVZZk0yMnFWQTYzRUYvZlBxWmRTWk53OHdtWVc3UWdtS1RadjBGaDV4?=
 =?utf-8?B?cjZ0bzNEM1k0cmdaNzZaeXY2WWd2T21pQUdMN0Qxc1QvV1JOMlJsT1VtS2hY?=
 =?utf-8?B?aHIrOUdpQnBqQUtmVE01emxXRTNkYU1WdVk1ZXV0b1lySXB1ZTBSNGhSSzM5?=
 =?utf-8?Q?9I+KFspJVSd0REwDzWiPnmZfE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0e1fc0-96e9-4995-579a-08dd5c6206a2
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 03:50:24.6049 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sWOq8Lq5jZLeB2BuIfK1U8gsr/8D38hwfOjabob+9KupYLqnt6tPqp751l1a/67+9Rw9MLOyVNByUS6SWRUAew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4402
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

On 3/5/2025 17:04, Alex Deucher wrote:
> On Wed, Mar 5, 2025 at 4:53 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> On 3/5/2025 15:37, Mario Limonciello wrote:
>>> Modern APU and dGPU require DC support to be able to light up the
>>> display.  If DC support has been disabled either by kernel config
>>> or by kernel command line fail init early so that the system won't
>>> freeze with a lack of display.
>>>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 24 +++++++++++++++----
>>>    1 file changed, 19 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>> index a4258127083d..c4e1505dcaac 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>> @@ -2139,10 +2139,6 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
>>>                return 0;
>>>        }
>>>
>>> -     if (!amdgpu_device_has_dc_support(adev))
>>> -             return 0;
>>> -
>>> -#if defined(CONFIG_DRM_AMD_DC)
>>>        if (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
>>>                switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
>>>                case IP_VERSION(1, 0, 0):
>>> @@ -2166,15 +2162,24 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
>>>                case IP_VERSION(3, 5, 1):
>>>                case IP_VERSION(3, 6, 0):
>>>                case IP_VERSION(4, 1, 0):
>>> +                     if (!amdgpu_device_has_dc_support(adev)) {
>>> +                             dev_err(adev->dev,
>>> +                                     "DC support is required for dm ip block(DCE_HWIP:0x%x)\n",
>>> +                                     amdgpu_ip_version(adev, DCE_HWIP, 0));
>>> +                             return -EINVAL;
>>> +                     }
>>> +
>>>                        /* TODO: Fix IP version. DC code expects version 4.0.1 */
>>>                        if (adev->ip_versions[DCE_HWIP][0] == IP_VERSION(4, 1, 0))
>>>                                adev->ip_versions[DCE_HWIP][0] = IP_VERSION(4, 0, 1);
>>>
>>> +#if defined(CONFIG_DRM_AMD_DC)
>>>                        if (amdgpu_sriov_vf(adev))
>>>                                amdgpu_discovery_set_sriov_display(adev);
>>>                        else
>>>                                amdgpu_device_ip_block_add(adev, &dm_ip_block);
>>>                        break;
>>> +#endif
>>>                default:
>>
>> Looking closer at this failure path I *think* this patch will cause
>> issues on GPU without DC support.
>>
>> In the 'default' case now I think it should do something like this:
>>
>> if (amdgpu_device_has_dc_support(adev))
>>          //existing error flow
>> else
>>          return 0;
>>
>> Agree?
> 
> I think it would be better to just dump a warning in the log if the
> board supports displays but CONFIG_DRM_AMD_DC=n rather than failing to
> initialize the driver.  The end result is pretty much the same and it
> wouldn't break users that want this scenario for some reason.

Actually it's a very different result with this patch vs a warning.  By 
failing to initialize then the existing efifb keeps working.

This means you can boot with amdgpu.dc=0 and rather than get a frozen 
display you end up unaccelerated graphics.

> 
> Alex
> 
>>
>>>                        dev_err(adev->dev,
>>>                                "Failed to add dm ip block(DCE_HWIP:0x%x)\n",
>>> @@ -2186,11 +2191,21 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
>>>                case IP_VERSION(12, 0, 0):
>>>                case IP_VERSION(12, 0, 1):
>>>                case IP_VERSION(12, 1, 0):
>>> +
>>> +             if (!amdgpu_device_has_dc_support(adev)) {
>>> +                     dev_err(adev->dev,
>>> +                             "DC support is required for dm ip block(DCI_HWIP:0x%x)\n",
>>> +                             amdgpu_ip_version(adev, DCI_HWIP, 0));
>>> +                     return -EINVAL;
>>> +             }
>>> +
>>> +#if defined(CONFIG_DRM_AMD_DC)
>>>                        if (amdgpu_sriov_vf(adev))
>>>                                amdgpu_discovery_set_sriov_display(adev);
>>>                        else
>>>                                amdgpu_device_ip_block_add(adev, &dm_ip_block);
>>>                        break;
>>> +#endif
>>>                default:
>>>                        dev_err(adev->dev,
>>>                                "Failed to add dm ip block(DCI_HWIP:0x%x)\n",
>>> @@ -2198,7 +2213,6 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
>>>                        return -EINVAL;
>>>                }
>>>        }
>>> -#endif
>>>        return 0;
>>>    }
>>>
>>

