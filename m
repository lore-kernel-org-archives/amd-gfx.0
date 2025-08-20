Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A45FCA0EED
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 09:38:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 033D310E6D6;
	Wed, 20 Aug 2025 09:38:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OfgM4o2q";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39F1010E6D6
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 09:38:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zt6/+gCdMZ5dQZd+Fm23SafiafDCqAKAf/I9d7v4KYafFt+QvrIYJ18XoY/po8BugK3yTLtz42xzqyEM2cIVIH+WpfTv9DzqQGQ0cIa7ReD1lt4PfhuiNrYPO17MJeYjWzRdMQPoqx16l0n4E7Sq3Itf8OV8WpnnK/RMA2yrH6ZvkAnzl/yu1O6c3fXDvOtu2cxxd9fz/he1UcwtnbUM9vEQvfUtC/k9HDdK9vPr8NZssE2QA51Vxxh5wHr5XWIjb3JQ4BYXqDMxHkRC86v2/JfCXbSXQEtYW+2MXgM+ukDlSdSoEIP1BNM1NpvzQvpFTA/nBdBu0xCxl9bLpJr4Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIf0FB3RNRrJOSkOp70ALk3vBnzec3j/W9ips8oSHvA=;
 b=yMeuZTJ8yvB53D1c+wecuIcFuJu+SJygAPvzNmrx4qjzlp0sbpYSZgQ0xeD9MjaZlcFwOpf4b6/jwJNbyoEyE841yJj/WxVCq9MX4HdNj+DRazvdKKfEwGEQZrPLMWDMWuGAC9CIL6EBZP5B/2AzcAdrl57FSKH226485Ee9R48pHU1FDsmDKMlYuIu9uJh61eEJ3TX+FM2Qy3V7723I7MLqyqxiJlp3HX9Y6dCzsLhEVR54jTPvFV21qeYU6aXUGBEMx3Ef9tqdXhRNN1nLO73r7EorXORMvDBryETRwkhPdcdEhSfucCDwjkaZeYzb1lLAJA7m3Yo02tuAl6gNqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIf0FB3RNRrJOSkOp70ALk3vBnzec3j/W9ips8oSHvA=;
 b=OfgM4o2quN3TTeoN45LCOytQ+5XLVgxaidnlwI2qmWx+NnLkMao/NO3z82Ff9m8Inz1M2TG4stUT6uKwMPzpjJFV7XSHXZtcsNct4aN4wiGybigtzIdx3gzesXD+OyoFi4qbh9MC6kkX/4jX4Ztx7g6sowSvzitvnvtQ44IvT8k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8756.namprd12.prod.outlook.com (2603:10b6:610:17f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Wed, 20 Aug
 2025 09:38:28 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 09:38:28 +0000
Message-ID: <6d499dcb-e88c-492a-9194-dca18a0f4528@amd.com>
Date: Wed, 20 Aug 2025 11:38:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: replace AMDGPU_HAS_VRAM with is_app_apu
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20250820073100.3500205-1-yifan1.zhang@amd.com>
 <274e7416-371f-464d-8d66-f9d81414bd4f@amd.com>
 <CY5PR12MB6369AF40DA64EB5477D24A49C133A@CY5PR12MB6369.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CY5PR12MB6369AF40DA64EB5477D24A49C133A@CY5PR12MB6369.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8756:EE_
X-MS-Office365-Filtering-Correlation-Id: d5592fb7-5620-4bef-2d02-08dddfcd512d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFdpcnpNUHZCS3I5NWwxbFJ4bjhNTTRrYlRLVFdkcHZxbnd1OGRvV0dCUjFk?=
 =?utf-8?B?a0JzQkhHbVVkdC9rL3FGV3BNNWZ4ck45SDROYjdXcWJ4S0tFOUd5ZUttZUxZ?=
 =?utf-8?B?Wmh5dFJLaTJWUDduSlQxNEZNVFhZZSs4ejFONm91U25LQ2U2V3hiRlRyMWFY?=
 =?utf-8?B?SHQxL2Ftbys3Myt2Qm1FMEZuSm4rZmtFZFQ3ekwwWGpVZFJuUnhxYjA5dUt0?=
 =?utf-8?B?Qm1rTkdxV1krWEpLRHJtSWFDR3BSSWR4QW5LTGVaOWt1Vk9GNGlUaThpRDBR?=
 =?utf-8?B?SWV1S0RuMFNYb2x2elpUZGU2bmhzK1YwMVRwZlJ5SGRQdmhXTUpaTnhKWmEz?=
 =?utf-8?B?a1NhaFlKaml1UThUYVJ0Lzc2YlJyL0JhWERJQzMyeExoMkxhL3RVamtlb0E1?=
 =?utf-8?B?dSthanpqL2drZTJ2U0FlQy9QenMrTVhlb3BwVTZzUTRNL284aWE5Ym5KaVZH?=
 =?utf-8?B?dnlKSVpNQ0hYeUtFQmdjaWwzd2dkWWdiMUdrNXZhUDJ2ckZENmhydVg1bjRI?=
 =?utf-8?B?Tlg4RG1FTytlZFR3bVZoWVNZcnJxa0dtb0t5RVJMSUxUSi8vclJMeXhqMU1Y?=
 =?utf-8?B?SlROZUlsQ05iUUtoUGNOQ002VkpDbkpmRzNSK0xrRjV0T2dTb2hXd0RNWXNZ?=
 =?utf-8?B?ZmpWNkkyZDVnQnFROFdDZ3RUMFgwakt4M1F0U042Nk1mK3c0dWIwWUtpMmFl?=
 =?utf-8?B?TUhPb0dTOS91OHJ2d2UrNWdrc2pIelh0dzhXN01lSVdvc2VycUErMzhqN1BP?=
 =?utf-8?B?anlwdkhEdE1iUmFjamlkSmdKRzMrSHpKTEhyWngxMDlLczZ2aXRBdkZqc3ZW?=
 =?utf-8?B?RzBiYXBoT1JhVWNVYUQrcTdMa0s0ak1sdVhjazlwYjFaTVlScXdjUW9sM0Rq?=
 =?utf-8?B?UmltRSszOUMyWWpnckozUGZib3YyRHBVNzZYeFh0THNjSWozaXFFdmZ5Slhl?=
 =?utf-8?B?ZE45Y3A2SXUwdmtWZHFvTmUzVElENTc4VGszcFdXb1J5QlFHZHJJSWovcTZk?=
 =?utf-8?B?ZDMyZzJZTmhnanhlcUxzMXpxM1JXK2tHYkZOUlZtY2Zyck54K2NscjczeXlm?=
 =?utf-8?B?T21QMEZ1RXhUTDdpRXU0UFgrb1RCSkZjcjZYSGlBZTNka1ZYVVBoVm1LUWlx?=
 =?utf-8?B?eGJQbXMxTzk5Q0FoSjlIcVpUSU13VW1IK3ZFc0l0NnN4Q1Y3dUxYZS9aQXE5?=
 =?utf-8?B?ZDFqSDFOQzNKM0owZ3NrZ0gvR1puNitHaHE5SEFpNUJrY05MRlZ6aDVPbThB?=
 =?utf-8?B?NWhrVEdYL1hneWl0WnNEcWlEM25rNE43NkZDOTI1VlgzNUlSV2daaVhwYXlT?=
 =?utf-8?B?UU9kbE52UEpoN3B1WG1mT0YyOGNPSTlQU0J6aDdTWXZvMUNPbHVBL25xaURB?=
 =?utf-8?B?andDV3h6VmdyUUEwMk01cU9XWWdVdmc2ZEFORXRqbEZLbitFd21YQ0xDdURs?=
 =?utf-8?B?R3hEU2ZlWEpRaXQwd3JUN0V3YmlJQnhLcE1yRVR5ejN5NWp5Ykg4SnEwVmJC?=
 =?utf-8?B?V0N6YVBHcDFEQzRSY0JxTVExTHNTUlNFRXd2OGV3Q2NRM2wvTEluQlV1bnpC?=
 =?utf-8?B?cloydWhicjhaNHprbEhSZ3podERobENlRHVMZ0tLZk1ON2JZcFBrNi8vUXlp?=
 =?utf-8?B?VHBxeng5Qk85S2ptSHVqMHhZamh1dFM1VW5JTUFZWGUrY1ZRYjNMUEFQSys3?=
 =?utf-8?B?bzVxaVh2UXd3bXdDdzRPYzc2cW9SSXdJOU5VaVA5eTNHeEQySFdjZm5qNFM1?=
 =?utf-8?B?SUE3b3hudTlvc0t3YjF1T2pSLzNCMWsxaEZmQXJTRmxsUVVVYXJQWVZHemhz?=
 =?utf-8?B?TDBPakZoOGRKeWZIczdhd1FIYU52N041dVA2MmFSdkFqQjVyRkZDaXhSdll2?=
 =?utf-8?B?N3NhR2J2SEUzdnZmMTFIalhGYUZvakxOVUlIdzJLRWZ4NEdtdlBYeHB1a3Ew?=
 =?utf-8?Q?CmJ6zhQgiew=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUV1UlR0QTlsdjg0bktMSFNKSU96WHIyMllScjVZOUIzbUhHWmRSWDQ4M01O?=
 =?utf-8?B?UzEwNEZiWGFMZkpHRmkwelc2TlVrMmxTZ3JxeDNzY1R6VllDSFdRT3BaR2xQ?=
 =?utf-8?B?UmxFNzh2R1gxSjR4N2czQlNKSEovSWpPeVFFREZlbUhuOXRBc0dkeEtoN0h3?=
 =?utf-8?B?NDg5TVdQS0VyTkdnM0xGUTNwQTE3TEN1NEZxMXN1b0tVcS9USGNJbnFSOUlB?=
 =?utf-8?B?YnpreDhCUmtubXVLL1VIRHIwVkc0aVpRWFI0TXhIZVhkbHRJQzZjeVVWNW0w?=
 =?utf-8?B?N0I0TE9ERExFQWV3U2ZxTW0yU0lrSFZEUDliSnh5b2dxMGtQRTdoWlFkMnVV?=
 =?utf-8?B?MWhwc1ArZ0lGejZEZUswclBzWHRHMTBqbmMwckJJejUybzl3dEkvSnF3Z1l2?=
 =?utf-8?B?OFNsUUVXa0pxRWpSbzJ0VVBqSTdVK0V0dGNvMFJzb2x0NENuNFU4MlpkeHRv?=
 =?utf-8?B?NnNGRWVndmg5T1Awdm1sVUtVZU03NEZ3dzE2NkQ3MHlaeHF6Tk9GVEMzSmkw?=
 =?utf-8?B?OWlYbWNZM3Q4d0RKbi9tOWtmandvYTErOU1NVlFvUXVQOFlhb2ZwM2pVNkRC?=
 =?utf-8?B?VDJ4ZHFnZFBtdzdIWk1naUcvQWlsSjFjbStad3l3YXJDWFBMdi8xNFRSSCsy?=
 =?utf-8?B?RDBzdFNmclhndkY4a1FNbEpISk1XYkxpdmFvMUR6VTFPS2tsd3c1eDRrbmQz?=
 =?utf-8?B?ajlPcGNnZ0F3RDdQUGRGb1I3TU9VUFJidWZZNjVIM2Y3YVZTT3R0M1ZhUEJm?=
 =?utf-8?B?R2U4ZDRWVXVaOFM3bjZUSEY5Y3psMzZjWWtlVjcrNzFCbDJWOWRWVHZyMDJJ?=
 =?utf-8?B?QkFMck5oQXRORlM4bS9maytHMFZrRXRZQ3dvNlUrVTU3ZWZ2Z2dSR1BqRHZy?=
 =?utf-8?B?RHp5SGhZMEQwbnJ3djA4TmhjclZPam9JMHNhY3l3eHhBYzJIWUFlc2VQMzFP?=
 =?utf-8?B?ZXdWL0kzTWxSTDNIbDAyR1JseXhaQVRwSFU5b3dpNEs5cER0d2g4RWFSekhR?=
 =?utf-8?B?WW1OT1pOMGtsdUhCeGtOQUNZTk45RU5yNWQxYkI4Y2lxamVMQ0FnM0RJZ2lE?=
 =?utf-8?B?T2N2WHdKOTBIbnBrOWE2TW5IUEthMnErQ282b2VpQmhKTUxBWXZaaWRJTkZX?=
 =?utf-8?B?UWI1U2tHSzkvdzVRTjZreEc0Ni9ucDRkSlM4Tk54aHJkL3NkY2s1WlFDYXJ2?=
 =?utf-8?B?RGp4WWJVZmZBTitWUFVBNTFkbWVmdEJlb04xVlFJUk5vYStaTlM4MmowVlVQ?=
 =?utf-8?B?d1F6eEM4VjJmUG9PRWxHRlk0VGs2dklIYXZqNzRLKy9MTDcwU0lMSW1TS0pw?=
 =?utf-8?B?TjNVdWhkbUFZVkxpN0lOSkNXM0lYYkYrT0J3M3BKbWlqT1JMRENHZ3AyMkJV?=
 =?utf-8?B?eHlZVXJBQzg0bXJsSmRXOUhTTEV4KzJhek9FdjJaV1ZpZHE0TllmV0dOcFhq?=
 =?utf-8?B?dThraXZCc1BkMWhFampLV3h5c0dYanhPQ2dEKzE1eC92cjYwYXVaaTFsS3k5?=
 =?utf-8?B?U3VTQUd4dHorMk5UNEhINjhUdHJ6aldTZUFHZ1piQzRmRGtHZGV1US9oUEZs?=
 =?utf-8?B?bnFLSzVLYmRxd0xFTVZPMEF0SnJrTFgrS1ZRVTFmNW1ZaHFWRzl5WWxtRjFm?=
 =?utf-8?B?aXhEVnBTOWgxTnFnTW00NEdIL3Y1ZjZYWWR2S3Q1Rk5FelV6MUlJUnBTdkNW?=
 =?utf-8?B?VmpOMHM1SGUxWllWeXRNRTdTR0NyckVuQlhpNDRsMlF1dXdKT2ZhaVFydDN2?=
 =?utf-8?B?SENBYi84QU1VKzBVcGd1amVrbTNwa1B0czNCTTUwaytqa0Q1WDlQWSthd0pQ?=
 =?utf-8?B?d1hNMndzamxTakFkU1RGUXlBT3ZDa0pNaWwwOFd5WGp0YS9zS3A3ekJnS1M0?=
 =?utf-8?B?VlZZd0VCRnZVNTUxQnNKeHVlaE9aOHV5VVlja29qUzdvOTR2VWdnclJmWW05?=
 =?utf-8?B?WS9rRWZtNEVvUVBpUjNXd1BaZHZvQmo2NU5YTUlSeWswOTBrY004YVFCOE50?=
 =?utf-8?B?YzVPS3JaVm5RRkN2RWU3cnlzYUlPQWNxVlBYRzVFWUhBSzhnM2QzcGZPQjVP?=
 =?utf-8?B?bTkrdHU4WTRGeDRndjl1aWN0dm5NTlJTYVpWYTVHdk9vRFdGWmx0bmhkYXJX?=
 =?utf-8?Q?BgoXV8tcwl3G0kDAK+8DGNi9F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5592fb7-5620-4bef-2d02-08dddfcd512d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 09:38:28.1092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zlhuM9u9jbSezY8VzcMDv6ZGyKp/JVP8D0tV7FVtR6QAMkdRRA04IEq77ympnpoe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8756
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

On 20.08.25 11:36, Zhang, Yifan wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> RE
> "The only reason I could come up with why we would need it is to have error handling if not enough VRAM is available for the TMR, but falling back to GTT is then probably still a good idea."
> 
> TMR allocation only happens in psp_hw_init, suppose there is enough VRAM for TMR at that moment. Right ?

Yeah, that's exactly my thinking as well. There is most likely enough VRAM in that situation.

Regards,
Christian.

> 
> 
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Wednesday, August 20, 2025 4:14 PM
> To: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: replace AMDGPU_HAS_VRAM with is_app_apu
> 
> On 20.08.25 09:31, Yifan Zhang wrote:
>> AMDGPU_HAS_VRAM is redundant with is_app_apu, as both refer to APUs
>> with no carve-out. Since AMDGPU_HAS_VRAM only occurs once, replace
>> AMDGPU_HAS_VRAM with is_app_apu.
>>
>> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 6 ------
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 +++---
>>  2 files changed, 3 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index ddd472e56f69..01f53700694b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -946,12 +946,6 @@ enum amdgpu_enforce_isolation_mode {
>>       AMDGPU_ENFORCE_ISOLATION_NO_CLEANER_SHADER = 3,  };
>>
>> -
>> -/*
>> - * Non-zero (true) if the GPU has VRAM. Zero (false) otherwise.
>> - */
>> -#define AMDGPU_HAS_VRAM(_adev) ((_adev)->gmc.real_vram_size)
>> -
>>  struct amdgpu_device {
>>       struct device                   *dev;
>>       struct pci_dev                  *pdev;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> index fa3e55700ad6..4125e73a0647 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> @@ -880,9 +880,9 @@ static int psp_tmr_init(struct psp_context *psp)
>>               pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
>>               ret = amdgpu_bo_create_kernel(psp->adev, tmr_size,
>>                                             PSP_TMR_ALIGNMENT,
>> -                                           AMDGPU_HAS_VRAM(psp->adev) ?
>> -                                           AMDGPU_GEM_DOMAIN_VRAM :
>> -                                           AMDGPU_GEM_DOMAIN_GTT,
>> +                                           psp->adev->gmc.is_app_apu ?
>> +                                           AMDGPU_GEM_DOMAIN_GTT :
>> +                                           AMDGPU_GEM_DOMAIN_VRAM,
> 
> Mhm the logic here is actually completely unnecessary. You can just specify AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT and get VRAM if available and GTT otherwise.
> 
> The only reason I could come up with why we would need it is to have error handling if not enough VRAM is available for the TMR, but falling back to GTT is then probably still a good idea.
> 
> Regards,
> Christian.
> 
> 
>>                                             &psp->tmr_bo, &psp->tmr_mc_addr,
>>                                             pptr);
>>       }
> 

