Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B35CCA470
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Oct 2025 05:41:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E5C710E66A;
	Wed,  1 Oct 2025 05:41:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ctZTggsX";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013017.outbound.protection.outlook.com
 [40.107.201.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BF0310E66D
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Oct 2025 05:41:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qj+kQw/jJvakt3IFbzGAPmvyyzawLlwfg/MuYZF/C75wMQ6qQKaY03hkXuh1L0r8Sxd8qafhXP5MzBJSGr+3tJPdk7C84j2Q+2CKWnwTQ/WpOsZo6JyHruI78hkANpSCTwdEwFMHm/JB1+YaRXq1yGGDdsAqpqQgYkfJ0gWrYs6BK8lj/jBWYr4Qth9rwebzHyp0Zr6yjTvR/M8IHCQacI7r1grgCz7CpBqpq8jligCUVIvg+hfOvkXmHAmcOm8+wdrHFgfBJPuZoDJVk00OOzWLeXgi8Ml1DH2AgyGRNhX5MoA0B4T3KilDH4yHkSyblKq24Vvia1/LAJ403BftUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=asNuHyHTRfYv3JtZS+jLjLrnSYKHvt0Sw8bZ7h6aRdQ=;
 b=wxjdof2AbJ6b7vPLp/sEue3vEqw4sqwHgyLaQX8Lxn2kXjwwmLKcB01KKGwB7LVgU0ryn6lCE25PIbUbZdi18Tp1WflCqM5tl7x2vVVxjYq0bvLNqAj5MILRB96n3jYHyuaoZEzBA038VWc8f5IBbO41DxBclgIUzvf0n92SSFiliPlyjLRpcfNqTHvgCdTighi39GquqWe7coZiRDQ1ZDmYxNNlybcEyM/SgXtRNafgTrpOdxzdDxJfevJYDS7rLHa1eZXp8NnJGfkG4d18neouXa60o+0/tI4Sj+4wongLjoPuJeXmd7fPZlH3PQD472w8sVcR5wQNaiA6HJXdiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asNuHyHTRfYv3JtZS+jLjLrnSYKHvt0Sw8bZ7h6aRdQ=;
 b=ctZTggsXSitXAI5sQS5aLeLTUA7LFAr4tVhCRIL4frSCV9i3s3ygfeMaCH1pQMEG5HDGn2Ncu/WgnZNXkHLKQLoqz8B5czmTI8b9lxBogk7GBlv5btHBWvTJU/GieygKD8QiZqfwJ2eHlRDzBQppdRR5PjxZEM/iCj+hfSk40ns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA0PR12MB7700.namprd12.prod.outlook.com (2603:10b6:208:430::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Wed, 1 Oct
 2025 05:41:02 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 05:41:02 +0000
Message-ID: <0ebd74aa-3628-470a-bf37-3b11bcbcaf5f@amd.com>
Date: Wed, 1 Oct 2025 01:41:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 1/2] drm/amdgpu: use user provided hmm_range buffer in
 amdgpu_ttm_tt_get_user_pages
To: "Khatri, Sunil" <sukhatri@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250924100156.3746229-1-sunil.khatri@amd.com>
 <c5b52ba0-efe1-497e-9d35-a752a2b35267@amd.com>
 <662c2254-dcfc-46d7-b11c-51111c26f23e@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <662c2254-dcfc-46d7-b11c-51111c26f23e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0151.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::12) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA0PR12MB7700:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b207bd4-13c0-40fc-5a35-08de00ad1ba1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S1dHcGQvd2loRnIyTEpsSHJPODI4S0hjSnVyWW9QRGx5N2pBd2liQkdPZTlR?=
 =?utf-8?B?T0VJOTFsbXRnUTFJbEQrR2lCNWlHRld6NEJab2FpZHc5Zkd6bjF3Ump0bEpt?=
 =?utf-8?B?OHFqeFFneGRJckJpbFh5a1lRTFJ6eWZja0ZQMGROV1ZyelAvUW51WkMrMXM4?=
 =?utf-8?B?ZzczNDNlektZS3lIbEJIK2hmSjdWRmRHYnZ4RHgveGZ3N2c3K3dtT0VadlE0?=
 =?utf-8?B?a3dTUDJyd1hkL1JiZmg2UHY1ZHFnNWhFLzRYc1NjY0JVUi9ZZS9YbE1RR2Fp?=
 =?utf-8?B?akhZOEo3TUs1OG0wazFsYVJyS3hjcloxN3VBRWtzRnBSOFpWdDJnSWVPcW0w?=
 =?utf-8?B?cFZiSUJLaG9JQ2N4aXE2NTFsVytMRlBIM1ZnREFWRlk2a2o4aHZsYkZ3Nlpj?=
 =?utf-8?B?NzNVcTM3RHBPQTE0T3FKZnhrWEJEVFRYeXpTLzFNeThhM3FOWGZ4T3AxOXpv?=
 =?utf-8?B?blNML2NTbEkrbDB5LzlGa0dJOUs4SHhFMUl6YTZiOUxPK2c1TFcxVDNpSUN3?=
 =?utf-8?B?YmhKODdGZXNET3ZWU3VhUkhnSzNrbEowMkdvWlc2MUhyMThEM1VTS3VFa2Ru?=
 =?utf-8?B?Y0JnTTlXeDQvRnRESlVyUUtiNEJwM0tQSEtkZWRNb24yekZXd3NqZy82eDN0?=
 =?utf-8?B?WnhrMmpxK3I3OXpWY1VjclV0UjNQK2lrU2I0dTB4YTlvSCtaUGc5Z0RDamRx?=
 =?utf-8?B?VjJmZStxTnY1bWQ1VmQ3NnZEelNmL0RnRnJ3SlBSTll6ODdFNmFoQTVLaXZ4?=
 =?utf-8?B?Sjl5dmtJTktOU041VTJwcy8zeFhRYWdQMVhSeU1zYjFFbDh6VDJzSlFKWVJ6?=
 =?utf-8?B?elhycnBNUVduVzEzL2RSRFNIRXh5U0ZRQUszRTJ2R2NuSUc5WFh3VTY4d0Iz?=
 =?utf-8?B?bE15RG53OGY4a0RQRlFtNzdsOElnRnRlMTFaYUozalVaTUlTTTM5enFVRHcv?=
 =?utf-8?B?T2pNNGxoZi81Rmp2Y0lNTDBaYmc1Y1dleVBTRkhTVENUY3hxVjJDM21PN0VR?=
 =?utf-8?B?SzY2YzRiZ1J0L3ZGaFJ0QlZjRzdiQ3lrY0FNa0orYStRcnZmYlhuQUFRczNG?=
 =?utf-8?B?Z084c2VlVzJwaHRWVHg0MEZWajRrVGNralVOTkJCMDhGejh2emFFa0Fvb013?=
 =?utf-8?B?SXFhYzAwRkMvVGQ0clViQTdrbytaSHdKbHRSL2RmRmtQRG5OdTl0QjBVY2l0?=
 =?utf-8?B?RWsrWUY4ZEkyY1h6ajdvYk50U3VGcWdTN2doZFg4aUtjUzFSVzFaM0ZTUjdY?=
 =?utf-8?B?L05IWkU1YStnNGNMQlJVUXJERDJCNVRQS2JhWEh2RE9kY2xVYzZJVEZ2eHda?=
 =?utf-8?B?YjIwVk0vR1pYYlN2bFk2T1g3K3lzTTRMM0xUNzBnNGRlZjFpY1lKcTJjaFJy?=
 =?utf-8?B?aFhia0d1WHQrSjlHK3I5UWZVdEg1ejdWMS9McmVCNG4xZjJpZk5NMkZMSlNV?=
 =?utf-8?B?VDduZnR6VGJRUzNWR0YydURuUXRvMy8rNGpNMU5Mc1JOZlorY1FYZ2IwSjZ1?=
 =?utf-8?B?T2tTSCtFZkFlSHAwQ3dXTzlUWUo3SWdIMFFmTFFmemU1ZW9yWDlKQThjQ2d4?=
 =?utf-8?B?dVpaeXc4bGxlYitnZ05Sd3Bwam00MTRIMmE2aHl2TnVXTmIvdUpmOWNuZURK?=
 =?utf-8?B?eVFOeWxPMWlrTng5Z3dSUmRWY3g5Uis0bkEzVDU3eG5tU1VUdi9qbHRpdC9F?=
 =?utf-8?B?ZlIyUzFsc2MydGFFK2hsOVJoYUpBbVUrSmR3Y01rSnNVTFExZ0U3citQdjhC?=
 =?utf-8?B?QkxZK1JURjBRY00vTG5tSHBXU3hiV0NIMTRxV1BiYWU0cnBKbzU4UFdMc1ZL?=
 =?utf-8?B?SFlXNUN2dHhrYXZEVDBnQVl0cnRuN0xKWU9RdE1BdWJ2VXNsWHZjRWdvUmR5?=
 =?utf-8?B?V3pJdm1LaVFnYkpQenlFVkhneHFmSHdCb29QY0w4VXFOdldkeGlEVVhjSHpY?=
 =?utf-8?Q?sjgMOGvk7UsUE9/mWkHdqxqvKIytXscN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWFpWEx3aHRYQkdreXNPK0M2Y3NSM2w2UnJROGJkbGVsUVZRVHRGU3BPcHR5?=
 =?utf-8?B?N0FSandRVDhwV0RJc2VETHUvWll0WEpKZHNraFRzQnlQRmMvL29oTWJ0V1hW?=
 =?utf-8?B?S3d2Qm9weGtNdlVObmsxYnhXeW1PVWdyeXdXZW50a3lzYlcvcjQrTGV6Y1M2?=
 =?utf-8?B?ZGVpb2dLT204OWRGbnd6QkZuWHZqMVh1YU5QandlMzRYZVNSRmhIUFc0RHlF?=
 =?utf-8?B?RUhzTkhweTQvblNqbmp0SmpoakZ3UHdnZ0hHWUdUVEdGeDRpKytHcmRGUGxh?=
 =?utf-8?B?UXBOVXEyL3NiZUpaR1pHMDdjK1JPSFJjTDRJNnFzZ3pUczhOeUJ2Nm9ZSFVs?=
 =?utf-8?B?L3o2KzBTWHFtQXd4WlErRmVTQmF2cjBvMUxOSk9BNnNNWCtjSHpoYjc3cEEy?=
 =?utf-8?B?ak5ZSUljUzVDZzd2VmZULzBpUVl3dmZMZTFjZGRKN1FONmZ1TG4vRytSbk9q?=
 =?utf-8?B?R1BqZGsxRDhpSXdZZkswcldPbWRtV2k2REcxK251YmN4dTBRRitLU3JUNUZu?=
 =?utf-8?B?MnNqZ2tZRG1pU1hTMnJFTVdEVjlzSU1KVXd6aUo1aEFObHp0cUdqTU9BM1FE?=
 =?utf-8?B?SnlsVjZXZHdxdENUVkNoV0lpc1ppUTRLaU0xSnpSMmIwTGlpeGk4UnIzMGQv?=
 =?utf-8?B?K0cyVVFEeWFmbUcvOW1JWEkwd2JFV29hdGI3RVVrK2dwNUF2bXVTMitIcSt5?=
 =?utf-8?B?UDUzcVpJMmdaQmtKdVg4Snh5L0xZRGxoYVdMOWZzVGlLemNmaTkrdEdOaHVu?=
 =?utf-8?B?Z2VpRVJVdGQrVzlyT2g1LzZUMFAxZm9Da3UxSlhpbm1KdHVjdTJzYmo1a1Fz?=
 =?utf-8?B?SDJNSlYwbXBaM1hOUkIvbVMwNXYvY2VMc0h3M3ZMVWVucTVlMzE0cDhuNXdO?=
 =?utf-8?B?ZElIZjB6ZUNDcUVsTGlQVlNtUHRCSTU5cjlsc0xwbm8vSDV6Vk1tWUNhdnZj?=
 =?utf-8?B?ejZpb3RsaWx0dnhPOGUwdmFMM05mVHIxemF1WDJWbTFXY3VlVkovTnJ1ejN3?=
 =?utf-8?B?aDhIc1dzUm9COHlCZUt3WkUrRnlaK0ZsRGphODFTbWhpOTlxVEhqWHNncGNz?=
 =?utf-8?B?Z1FacHZvdXd6L0xPeEVrSU1UQzhvQ0pQL1R3TmdWVEptQTBxaWtmc3ExNU12?=
 =?utf-8?B?eHovTlAyaWNzTDNXOVF2SlVqaW52N0I5akNWZWZrNFFDdmZEeUQ5b2dRREhl?=
 =?utf-8?B?cVBhN1R3aG92UGFCU0FHaXFvRzk2WW5seUd6MjVnUmZ2bzREYmQ5VWJ1YXMv?=
 =?utf-8?B?VExLR0tWcGZDaGJJdGlEaW1YYldMdXpxSy9IVlZNaUh5QnlnbFdxYkN1R1Jy?=
 =?utf-8?B?bmExU2w3UVZoNXdVWFJsTUlYbzlGRDk1RlR1QlV6cTRraC90OForN0loWFRu?=
 =?utf-8?B?NHZoTDBMUmpuZWF0dXloMlVSZnVHLzVCNEUwVkZUUVVaamw5cEIzK2t6d2tG?=
 =?utf-8?B?UHNnYkx0T2pKSytjRVhBdDVDakJZSytWb0l3c3J2QU9abnM4ais3dWo0bExt?=
 =?utf-8?B?a1pJSnEwUktlSWllckQxZjhTWkR0SmhZckc4NHY3dzUreFV6Z3dFWVBQa3NF?=
 =?utf-8?B?OHAvNDJPMVkzT0gwVUdVM2JBSXg5NktXN21KUFl2KzRVVC9YUFdhalpHUGc2?=
 =?utf-8?B?SmN0TTVSL292S3d6eWhIQjNYdGNUZE9Ebzh2bjdnYTFFdzJXTFVBbUdYSHJV?=
 =?utf-8?B?dGk4bkV0K0h0VTJSSEF0ZjBNc1Jacms3M01lR2g3eWhLUzR1OUZ1TnV6a2R4?=
 =?utf-8?B?Z1kzdU5lYlE3OWNRUTk1dGhZU1l1UURNdWRvRm5hRVNkZTFlY1hhTlVwZERj?=
 =?utf-8?B?OE51S3NoeDVvZWxTYjZSenFBYk5udE82c1dXdlZ2WmN4TVZta2FxbUY1MlE3?=
 =?utf-8?B?Q3hmNlFCL3pndFR3QzRFSjk5Y2ZMbXZubVZXNGtHVWhqRDdVdGMvVUlNbk5J?=
 =?utf-8?B?QWw4MCtUZDhRK3ZZd3BaT05YMUFxNENMdkg3K1E2dVJZaHZ0NmlidDlSTGYv?=
 =?utf-8?B?c0o3dHlISnowb0dhaEhtRjdGbHpmNlJzaDIyeWx4M1Y0bmp6YWRDZTdoaU9a?=
 =?utf-8?B?blkxc2NUSDg5WDZranJKMXF2RDRFR3FkZUpNL2VNRXdnbzROYWJSVGl6Y3Ri?=
 =?utf-8?Q?LXVHf9YNRUn2ZK5IBaVw+bmX0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b207bd4-13c0-40fc-5a35-08de00ad1ba1
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 05:41:02.7484 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ClI0/9mZMPftCurRiuYV0WKCXBqVlo98qKSlSW/11jHxDTj9keJHpf5sTmkcXRbuYfR3GgGt7cd0FoHig13Uhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7700
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

On 2025-09-26 06:53, Khatri, Sunil wrote:
>
> On 9/24/2025 10:27 PM, Kuehling, Felix wrote:
>> On 2025-09-24 06:01, Sunil Khatri wrote:
>>> update the amdgpu_ttm_tt_get_user_pages and all dependent function
>>> along with it callers to use a user allocated hmm_range buffer instead
>>> hmm layer allocates the buffer.
>>>
>>> This is a need to get hmm_range pointers easily accessible
>>> without accessing the bo and that is a requirement for the
>>> userqueue to lock the userptrs effectively.
>>>
>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>
>> What's the reason for this change? In the current code, the hmm_range 
>> is allocated by amdgpu_hmm_range_get_pages and freed by 
>> amdgpu_hmm_range_get_pages_done. Your change is breaking that symmetry.
> Sorry i missed your comment. For userqueues locking the userptr bos 
> and making sure we have valid userptrs at the time of validation seems 
> too complicated, so along with christian we decided to use hmm_range 
> list instead and have reference to userptr bo and via hmm_range 
> private field to be set to bo.

I don't think this will work. See my reply to your other code review. 
hmm_range->dev_private_owner is not a device-private field that you can 
use to store random driver-data associated with the HMM range.

Regards,
   Felix


>
> Also i did made sure that wherever we are doing get pages and 
> allocating range the freeing part is taken care of. Specially for 
> freeing the memory is still done by amdgpu_hmm_range_get_pages_done 
> only. Please share if anywhere i missed something. Also Christian 
> brought out the point to have separate alloc/free for hmm_range which 
> i am working on and will share soon.
>
> Regards
> Sunil Khatri
>
>> Regards,
>>   Felix
>>
>>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 16 
>>> ++++++++++++++--
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c           |  6 +++++-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c          | 10 +++++++---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c          | 11 +----------
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h          |  2 +-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c          |  8 +++-----
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h          |  4 ++--
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c             |  7 +++++--
>>>   8 files changed, 38 insertions(+), 26 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> index 7c54fe6b0f5d..4babd37712fb 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> @@ -1089,8 +1089,15 @@ static int init_user_pages(struct kgd_mem 
>>> *mem, uint64_t user_addr,
>>>           return 0;
>>>       }
>>>   -    ret = amdgpu_ttm_tt_get_user_pages(bo, &range);
>>> +    range = kzalloc(sizeof(*range), GFP_KERNEL);
>>> +    if (unlikely(!range)) {
>>> +        ret = -ENOMEM;
>>> +        goto unregister_out;
>>> +    }
>>> +
>>> +    ret = amdgpu_ttm_tt_get_user_pages(bo, range);
>>>       if (ret) {
>>> +        kfree(range);
>>>           if (ret == -EAGAIN)
>>>               pr_debug("Failed to get user pages, try again\n");
>>>           else
>>> @@ -2567,9 +2574,14 @@ static int update_invalid_user_pages(struct 
>>> amdkfd_process_info *process_info,
>>>               }
>>>           }
>>>   +        mem->range = kzalloc(sizeof(*mem->range), GFP_KERNEL);
>>> +        if (unlikely(!mem->range))
>>> +            return -ENOMEM;
>>>           /* Get updated user pages */
>>> -        ret = amdgpu_ttm_tt_get_user_pages(bo, &mem->range);
>>> +        ret = amdgpu_ttm_tt_get_user_pages(bo, mem->range);
>>>           if (ret) {
>>> +            kfree(mem->range);
>>> +            mem->range = NULL;
>>>               pr_debug("Failed %d to get user pages\n", ret);
>>>                 /* Return -EFAULT bad address error as success. It will
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>> index 744e6ff69814..31eea1c7dac3 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>> @@ -884,9 +884,13 @@ static int amdgpu_cs_parser_bos(struct 
>>> amdgpu_cs_parser *p,
>>>       amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
>>>           bool userpage_invalidated = false;
>>>           struct amdgpu_bo *bo = e->bo;
>>> +        e->range = kzalloc(sizeof(*e->range), GFP_KERNEL);
>>> +        if (unlikely(!e->range))
>>> +            return -ENOMEM;
>>> +
>>>           int i;
>>>   -        r = amdgpu_ttm_tt_get_user_pages(bo, &e->range);
>>> +        r = amdgpu_ttm_tt_get_user_pages(bo, e->range);
>>>           if (r)
>>>               goto out_free_user_pages;
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> index 8524aa55e057..12f0597a3659 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> @@ -571,10 +571,14 @@ int amdgpu_gem_userptr_ioctl(struct drm_device 
>>> *dev, void *data,
>>>           goto release_object;
>>>         if (args->flags & AMDGPU_GEM_USERPTR_VALIDATE) {
>>> -        r = amdgpu_ttm_tt_get_user_pages(bo, &range);
>>> -        if (r)
>>> +        range = kzalloc(sizeof(*range), GFP_KERNEL);
>>> +        if (unlikely(!range))
>>> +            return -ENOMEM;
>>> +        r = amdgpu_ttm_tt_get_user_pages(bo, range);
>>> +        if (r) {
>>> +            kfree(range);
>>>               goto release_object;
>>> -
>>> +        }
>>>           r = amdgpu_bo_reserve(bo, true);
>>>           if (r)
>>>               goto user_pages_done;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>> index 2c6a6b858112..53d405a92a14 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>> @@ -168,18 +168,13 @@ void amdgpu_hmm_unregister(struct amdgpu_bo *bo)
>>>   int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier 
>>> *notifier,
>>>                      uint64_t start, uint64_t npages, bool readonly,
>>>                      void *owner,
>>> -                   struct hmm_range **phmm_range)
>>> +                   struct hmm_range *hmm_range)
>>>   {
>>> -    struct hmm_range *hmm_range;
>>>       unsigned long end;
>>>       unsigned long timeout;
>>>       unsigned long *pfns;
>>>       int r = 0;
>>>   -    hmm_range = kzalloc(sizeof(*hmm_range), GFP_KERNEL);
>>> -    if (unlikely(!hmm_range))
>>> -        return -ENOMEM;
>>> -
>>>       pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
>>>       if (unlikely(!pfns)) {
>>>           r = -ENOMEM;
>>> @@ -221,15 +216,11 @@ int amdgpu_hmm_range_get_pages(struct 
>>> mmu_interval_notifier *notifier,
>>>       hmm_range->start = start;
>>>       hmm_range->hmm_pfns = pfns;
>>>   -    *phmm_range = hmm_range;
>>> -
>>>       return 0;
>>>     out_free_pfns:
>>>       kvfree(pfns);
>>>   out_free_range:
>>> -    kfree(hmm_range);
>>> -
>>>       if (r == -EBUSY)
>>>           r = -EAGAIN;
>>>       return r;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
>>> index 953e1d06de20..c54e3c64251a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
>>> @@ -34,7 +34,7 @@
>>>   int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier 
>>> *notifier,
>>>                      uint64_t start, uint64_t npages, bool readonly,
>>>                      void *owner,
>>> -                   struct hmm_range **phmm_range);
>>> +                   struct hmm_range *hmm_range);
>>>   bool amdgpu_hmm_range_get_pages_done(struct hmm_range *hmm_range);
>>>     #if defined(CONFIG_HMM_MIRROR)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> index 901e0c39a594..046ff2346dab 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> @@ -705,10 +705,11 @@ struct amdgpu_ttm_tt {
>>>    * memory and start HMM tracking CPU page table update
>>>    *
>>>    * Calling function must call amdgpu_ttm_tt_userptr_range_done() 
>>> once and only
>>> - * once afterwards to stop HMM tracking
>>> + * once afterwards to stop HMM tracking. Its the caller 
>>> responsibility to ensure
>>> + * that range is a valid memory and it is freed too.
>>>    */
>>>   int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>>> -                 struct hmm_range **range)
>>> +                 struct hmm_range *range)
>>>   {
>>>       struct ttm_tt *ttm = bo->tbo.ttm;
>>>       struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
>>> @@ -718,9 +719,6 @@ int amdgpu_ttm_tt_get_user_pages(struct 
>>> amdgpu_bo *bo,
>>>       bool readonly;
>>>       int r = 0;
>>>   -    /* Make sure get_user_pages_done() can cleanup gracefully */
>>> -    *range = NULL;
>>> -
>>>       mm = bo->notifier.mm;
>>>       if (unlikely(!mm)) {
>>>           DRM_DEBUG_DRIVER("BO is not registered?\n");
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> index 6ac94469ed40..a8379b925878 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> @@ -191,14 +191,14 @@ uint64_t amdgpu_ttm_domain_start(struct 
>>> amdgpu_device *adev, uint32_t type);
>>>     #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
>>>   int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>>> -                 struct hmm_range **range);
>>> +                 struct hmm_range *range);
>>>   void amdgpu_ttm_tt_discard_user_pages(struct ttm_tt *ttm,
>>>                         struct hmm_range *range);
>>>   bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm,
>>>                          struct hmm_range *range);
>>>   #else
>>>   static inline int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>>> -                           struct hmm_range **range)
>>> +                           struct hmm_range *range)
>>>   {
>>>       return -EPERM;
>>>   }
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index 273f42e3afdd..9f0f14ea93e5 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -1737,12 +1737,15 @@ static int svm_range_validate_and_map(struct 
>>> mm_struct *mm,
>>>               }
>>>                 WRITE_ONCE(p->svms.faulting_task, current);
>>> +            hmm_range = kzalloc(sizeof(*hmm_range), GFP_KERNEL);
>>>               r = amdgpu_hmm_range_get_pages(&prange->notifier, 
>>> addr, npages,
>>>                                  readonly, owner,
>>> -                               &hmm_range);
>>> +                               hmm_range);
>>>               WRITE_ONCE(p->svms.faulting_task, NULL);
>>> -            if (r)
>>> +            if (r) {
>>> +                kfree(hmm_range);
>>>                   pr_debug("failed %d to get svm range pages\n", r);
>>> +            }
>>>           } else {
>>>               r = -EFAULT;
>>>           }
