Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEA7D2F7C6
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 09:30:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F17210EA8B;
	Fri,  5 Dec 2025 09:30:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3HSnZzOI";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013008.outbound.protection.outlook.com
 [40.107.201.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52F9C10EA8B
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 09:30:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TSvJ+UF/cFDrsyIVMGHvrdXAYbIU2g9O32mbK0aZeX3VdrLg1O7VWLfTOVn50wklQykQXsidvZqMzonwDveIfhTvdfN253PWF0WQikW8yJXK56QqRXnAwSDA4S6c9CmBua/0fUpRRvxM1jwCYsnlyzgXr5BMpI9UFikGhhwQ50F9J1KU0lwGKJwUe9WtJdF03YBPv6ll6fdIMxSreua/fqT0yKO18p8D/EZ+GuKXmpo5Oc1Ltfup9B+MAfESlc29i7fj+Wwta6CAGkCvGycWUjVC2f+q3KoJGUeSnllEMdT5hpbsdFQCTJ+6xdfBZvEiY4+K6/aaUcfBDZbjEhyo1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWd29nygiOMV9/KtbQmXvMali8pzwpMiEnj55dnHHYw=;
 b=MCenqRTLlF8EOVfiuS7MlUYPAs8uOiP33ERABmbXWuHrASIkZGnm5dFOE5nulmg/atMeJiUZHa6kw9Ea7oAKwd/vzxo77sqAMgjdywYBWwfCA5NmXYwHx1Om508b9AOzK2XC/D42/RV4bK2XfnfuZr7TO4Ft4eESFwWKwpy/CzO+PONBM7UMgO/9RFOmuaOa0oBCEEBnSiGm9FgkpycAKAzaIn3kYn7mKmYg1KEAVQ7hYC47VruF3xUgRVlEm48ogvL2YMU342xS//VY5/Sq2uy7V1WcQ8/0HB6LYzJSlMB9BJpjyY+xO7JAZJwImLWeHg4JQNQ9+xNP4paDHi6BvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWd29nygiOMV9/KtbQmXvMali8pzwpMiEnj55dnHHYw=;
 b=3HSnZzOI/JjLE3PXNh1sXhwpMz0rvZkuBQkcP6wzxydl592+dHYIEV8x5caZK5jXLjlDX/ia0mjdlmchrIr9xrORnagcTOay53eORvCPysX3bg2FLHqQB1d9jo8Bxdel1qn/VhoaRwGjePUhFpMYzMygx6AFBDapHeEIdnvGAfI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 09:30:11 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 09:30:11 +0000
Message-ID: <5814160b-7715-4b62-820a-e23e88b6f595@amd.com>
Date: Fri, 5 Dec 2025 10:30:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] drm/amdkfd: Map VRAM MQD on GART
To: Philip Yang <yangp@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, david.yatsin@amd.com
References: <20251201142838.1516452-1-Philip.Yang@amd.com>
 <20251201142838.1516452-5-Philip.Yang@amd.com>
 <ba907ce9-8a80-4aa7-8d41-11880b56c0c0@amd.com>
 <61c8b00f-ec7a-482b-a3d0-b37d3a8fcedb@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <61c8b00f-ec7a-482b-a3d0-b37d3a8fcedb@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH0PR12MB8464:EE_
X-MS-Office365-Filtering-Correlation-Id: daa0ee46-c473-4de3-b2d8-08de33e0e37c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?am5aNnNSd01JME5wYWt6VzRNM2hkcmM0L1AwT21XTnlpMndvY2JKNmxRODRt?=
 =?utf-8?B?UG1KdVdvQUZnWTllMU4rdjMwSHR4YVo1cXB6YjZ2YUVBNXNMUHhuTEhHSUdi?=
 =?utf-8?B?QXpQUWtLWmR1b281Q215TEQ4OFhNb0t1cjRlNkU5OXlMY25PNUlUQXZ5L0ll?=
 =?utf-8?B?MWJ1Z2prTmUrVmM0OHlwS2tNNTBzQm41TFNJek5yOXhNSHpaNVhjOHNEdmVa?=
 =?utf-8?B?WHBUeHdEN1JRUmR2dDZMRU5RY1prR0s3UDd5UXpWZDhJNnBYK080NzZxV0pU?=
 =?utf-8?B?L3J3Tjd2a0FWTk50YzlKVU5RUXN2WC91TlVhK2JMU2R1RGpWMnlHdkw4WXJT?=
 =?utf-8?B?cEJ1WXo1S1lBb1NXaTdMOVVZWkJJMVdPbzNYNXd6Q2pDb3ZuMnp6Z1lEd0kw?=
 =?utf-8?B?R0tMU3g4bzkxWjFlNnpZdnhtOFV0NlpBV21wQnZtMGZOK3lNZi82ZllMMm1I?=
 =?utf-8?B?dFlMUnNRZmI3ZVY0RkdkMStSbDkrYmloT21mUG1OMENHNm9KNXJmQXRLaDVq?=
 =?utf-8?B?SE9jSG5mMVUvRVVtL3JNeDU5NVhVL2RqSTYyR2k0aURkUlVNOTF5U0oxalhm?=
 =?utf-8?B?NVdvYnVpQlBxSm1kUnNmR29NcWFBaEJpTmx0MHhqU3pyNkVoVkVUd0c4VWZu?=
 =?utf-8?B?RkRTOUoyeTJsRFJXWmkyb01lT3JKazRHSDMvL2ZCdXRoL1V4eXp5MEIxcjhK?=
 =?utf-8?B?WFJiTFVSREFWMW55c0k5V2pMaEtFMVo4YnJUb3lwNWN2NXF6V29NR3NCeTIy?=
 =?utf-8?B?TDkwRFJxa3pwYmNQV3IyVTVRTmhnYzNVcGErY0RCNXo0bzdDTTBBRktNQ2c2?=
 =?utf-8?B?TWE3OWdDNWx1dFJnZEFrVlpyUS9EQ3JYMlNBZ2VlRFVzZ3hTNkoycG10OWdu?=
 =?utf-8?B?Tkc3ZUlkRjgyME1Ed3ZxN0d1bHRjVG5aalNkbzlwand3U3FUMHdSZm1wWXFq?=
 =?utf-8?B?RDlrK1U1MEpRRDlucHhESGFRTFVaNkRGQmpZdmdhblFEUWsvdnRDMnBxTzNN?=
 =?utf-8?B?Tkl3eERoc3BCVWg3aFlaQmN0eWtrNlVzNVlaUzlOa1JCTGVTWnFlb2NlZWNq?=
 =?utf-8?B?MEp3QnhNbDRDQloyQTJBcGhXWVA0aDNIYUtCRTQvWVNhSjFSdzh4c3pHajR2?=
 =?utf-8?B?OWVpL1B4cytUdGxjSXl0ZW91TVhIZGVqWDFGWnJWbG4wcS91YVBDc3BRWkl5?=
 =?utf-8?B?V0NTeUxWY2dJWG5GaGpCY2s0L1Izb3JINklIaXF0QUgzdnZVYnByZzVSa2N5?=
 =?utf-8?B?RG5rTjVlaVUrN1lsS0FFNWVyYlVuMTlFZUR1R3lEVUFGVCtackM2dk44Mm5k?=
 =?utf-8?B?MFlXeUl3QnI0NjdaRW9idmJ0RlpOTkJYQTlyMWxQdFdkbXNhckJ6YWtQSG1l?=
 =?utf-8?B?WjN5cXZNbUo3OFJ6ZytYM0FPYXJkWWdQL3lMUlVxUGN1NHNnVU8rYkdKREVN?=
 =?utf-8?B?MW9zQnA2L0xwbnBEVFBDWXZ3VlBmWFdoQmJ6WHB2NGFISHJKbGJTeHlVK0Uz?=
 =?utf-8?B?WFRKRDBLYU5PMm8xSFJuZ0tXVFhuc1N4NmtRbTdhSVRHbVN3ams4clYwU2tn?=
 =?utf-8?B?WGNTdjI0RGhldk1GRjEzSGVnMmk0UW5tZW5RR09oL0dqSStGU2RrMjZpeWpt?=
 =?utf-8?B?MWxIVmFPNmg2NmFNQjg1LzJHaEZtdFVFaWJKNzBLM3hLaS9FNDFQQ2lybWJO?=
 =?utf-8?B?R290bjJEc214ZUZOZGNMUmNBbnhwdTZFQ0JyU1JSMEhrVjNLWEl1ejFnRitN?=
 =?utf-8?B?VVNxWjNGR1pQd2lEREtkbXF3T2FHL0RTV0RKbVVNRXppb3llZlljUFQyRUxq?=
 =?utf-8?B?WXNHM0VNci95aHd6a0l3QWhNV05sZk55UzF5NlRQdU9BbGJPQ0Mya2lkajV0?=
 =?utf-8?B?MGtCTGJwVzNrOEt0UXd4bnNPMGJ1OC84RXRFRC8zT1M5UVYxZmNGQmoycEFx?=
 =?utf-8?Q?hJklX7/n96wq4pc6ngh2hXpa5Hx/MDjo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmhZdEhyMDhCRG1yTGhRdUd5bWhTWlU3SW9HV2crMmRVcUIreTJqakt4UUU4?=
 =?utf-8?B?ZmMvMTNNYXA0VmRHemQybFVPSzFSc2pMK2VqK3RaWDJyZWFyUkJLZFZpRndy?=
 =?utf-8?B?ZWRnWjNQSjFlMG5kN01FWC9yS0VhanpWZDlOM0RvS1lmZ3lXTTd0WWZrU1k1?=
 =?utf-8?B?L1RRcjQ5S28rT3ltSXV5YlhzdnRodHl2VTl2SXl0NDFQT090ZnJnSFlOMk02?=
 =?utf-8?B?VlF1cjNjYUo3SDNtcytvZE5kdkpxYXFwZWtjL0JDSDRGZ1YrelFWMjBaL05z?=
 =?utf-8?B?bWQ2RTR4SmRHY3BZOTlFb0JseDVIUngyeEV6MUJGQXN5SmpmT2c4RGJCRm1i?=
 =?utf-8?B?TldCeXUwWFZCcXh0dndPQklIZngwUHljSDlZbU9jWDhDOGNQT2l1ZFphYVMr?=
 =?utf-8?B?bDNMUUgxc3FtaHlGcHJoTlhSMVZwZFUxeGJyRGNJVDJOWU9zaUZKdnM0dzBl?=
 =?utf-8?B?TE0xcDgyanNJK1JqdU5JbTdBWDJHVGNicFByUTJXRjdmYzFlQkdOOUU2dVZK?=
 =?utf-8?B?MGVuN1drVGF4ZDBRM0JUWnM2SlBoV3REbEY2Z01Cd0c3TXAzWTFPdURqMTFT?=
 =?utf-8?B?WjJ2R2lZYTNybWlod2NoODBVaE15YVlTTnloTnM3Zy9yZGExYzJJREl3eDNS?=
 =?utf-8?B?bmxYZForc2YvL3VuM3ZTZi9LL1pGa0J3YTUvbzU1V0ZPSjRHWFhZQWI4K0k2?=
 =?utf-8?B?WVhEV25DYzRaRm9BOXM0YjBheVU2MWZJZDRwWnhPS0hLZTd2b2V1UU9LT3lV?=
 =?utf-8?B?NFZ2TDFHOFdkOXNWVjZzdWxvRjNidzd0cDNWcm12T3Z2bFlSb1FoVklxOHEw?=
 =?utf-8?B?MGtMSE0xdGtlZkNETW9GcWJIMjJvQUV6NktCcXNrUytjM0xmZEhVT1RHSTVH?=
 =?utf-8?B?QzdIRDhtaGtsc3J1dERFdVFzOEllYzlqU1FETDljdHFaK2pBNWU2UFdtclY5?=
 =?utf-8?B?SXoyTHNmckRHOXBhOVNhazV4czZJRDlmL2JuZW1rNkFnT05SRGtoeGtCN2c4?=
 =?utf-8?B?QU5sVkpLVXp5QVdIcGcwdWMvbGZkaGg1bkpPU3BUWFNSVFNzWS9wdCttOTd5?=
 =?utf-8?B?SytjK25lTzlzMU5oM2F6bW84cEFhVm5vQXc0bWJZc08wQzROUTFocEZEMy9s?=
 =?utf-8?B?aG9qNWg1bWxUYVM0K043cWVxS3k1aWNTN2tpUjc1Mk1aVjNSclBlcWU5cFdY?=
 =?utf-8?B?c3BON3pZczZqSTlrZmF6dVJuTWRZczlYS1Q5UEM5TGxKeFBJcEQ3NHZpZTBB?=
 =?utf-8?B?VzNCbzI4dTZCeHVOQlprSm9BQlp2czNtTm1oU3ZCVEl2Y28vZjRja09Zckxp?=
 =?utf-8?B?TVA0NG9VeENqVVZDTWlLRkJhakdUYUMxQ3NwZTRJZ2Jod2JvbDh4bTFPcU9H?=
 =?utf-8?B?VWIxM2wxNnBQeForTlN3SzM4bHBBSW01UGRDME5OeFh3bHRjODJ4QmpUZ2gr?=
 =?utf-8?B?YlUwdHRpbFBuZW1HTWZJbXVFYVBIVE45eEw3anJRTWE0Tm5UZHJyUXMrck5U?=
 =?utf-8?B?ZUhqTmppOHRTb29BdWF1SFZCU0dLNlZnYVBzb0U4YjV1UzNEWkZnUHJuU01J?=
 =?utf-8?B?a3hUWDJubHZzTU1tcWR5aEVpcFBLT1B4Qi9abWpGZVdJcjVlYnZDL0NGZllP?=
 =?utf-8?B?UmdXNmROdHhQbWFTai84UmtkUHArYTgzZjR0ZmozVWczS3Z6V2dPQzk0cEFV?=
 =?utf-8?B?dzFzaTdzUWtxV2Y1Q3F5NHd6UlplWGtrZ3p5SEV6cEpKVUNaU0lTb1U1d3Vm?=
 =?utf-8?B?bllESEovdFQ4bVZpcmlTZVV0b3l3VkdwVWpvaGxPOGRIck1xUS9NOXExckhP?=
 =?utf-8?B?UXlBK1pRZEFWaVprSnRlbXhyZEN4bnBSS3psellQZkZ2VlhXNWk0YjVvcmxE?=
 =?utf-8?B?RXdoRnhOcGJUN0ZIckZzSWg4UWRra3oyMC96N2k5MEp5bk5sTEFjN0ZJRFNN?=
 =?utf-8?B?M0RIQTNvbGowMi9rZFRFbnpibGxCU2pBaGJ4MzU2NlRZVzFpclJxYll3bHNl?=
 =?utf-8?B?MFIrejNPVVdPdVBQdWFEWVFRTWRNWXpCODNuYXFWbjFmcGYxQzRMZjdLaXlG?=
 =?utf-8?B?Y0dSZ2pKZzF0T0RvRXdQeDFQTXJhU3pLQ3FHTVJrZDdRVTU0bldzbzRXNG1K?=
 =?utf-8?Q?Gg06fqy93mRh5/ZBHl907gSM2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daa0ee46-c473-4de3-b2d8-08de33e0e37c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 09:30:11.6884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j8h7c/zgnPejwV52s+jpCKhpwUZ7ds7sm/U9gzDXRu0Y1X/9ZMmHPnhU/Z2U00bd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8464
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

On 12/4/25 23:43, Philip Yang wrote:
> On 2025-12-03 11:06, Christian König wrote:
>> On 12/1/25 15:28, Philip Yang wrote:
>>> MQD BO on VRAM access via FB aperture is mtype UC uncaching, map to GART
>>> as mtype RW caching, to reduce queue switch latency.
>>>
>>> TTM bo only has one resource, add GART resource to amdgpu_bo in order to
>>> support dynamic GART resource and VRAM BO resource.
>>>
>>> Update amdgpu_ttm_gart_bind_gfx9_mqd to map MQD in system or VRAM.
>>>
>>> Add helper amdgpu_ttm_alloc_gart_for_vram_bo to alloc GART entries resource
>>> for MQD bo->gart_res and bind to GART mapping.
>> Clear NAK to that approach! That would completely confuse TTM.
>>
>> We need to talk about that on the weekly meeting first.
> I think that is becausettm_bo_mem_space also add GART resource into ttm bo, which already hold
> VRAM resource. Felix suggest to alloc gart space via drm_mm and store in mqd structure, not in amdgpu_bo.
> I will implement it in next version and we can discuss details in the meeting.

Yes, that sounds like a good approach to me.

We could implement GART as separate TTM domain and then have the ability to map anything to it, but that is a much wider change.

Probably good to do that in the long term, but also tricky to get right.

Regards,
Christian.

> 
> Regards,
> Philip
>>
>> Regards,
>> Christian.
>>
>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |   3 +
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |   1 +
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 113 +++++++++++++++---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |   1 +
>>>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |   8 ++
>>>   5 files changed, 108 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> index 926a3f09a776..d267456cd181 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> @@ -1297,6 +1297,9 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
>>>         abo = ttm_to_amdgpu_bo(bo);
>>>   +    if (abo->gart_res)
>>> +        ttm_resource_free(bo, &abo->gart_res);
>>> +
>>>       WARN_ON(abo->vm_bo);
>>>         if (abo->kfd_bo)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>> index 52c2d1731aab..a412f5ec2a09 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>> @@ -106,6 +106,7 @@ struct amdgpu_bo {
>>>       struct ttm_place        placements[AMDGPU_BO_MAX_PLACEMENTS];
>>>       struct ttm_placement        placement;
>>>       struct ttm_buffer_object    tbo;
>>> +    struct ttm_resource        *gart_res;
>>>       struct ttm_bo_kmap_obj        kmap;
>>>       u64                flags;
>>>       /* per VM structure for page tables and with virtual addresses */
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> index 5f58cff2c28b..1d8f5fc66acc 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> @@ -832,14 +832,27 @@ static void amdgpu_ttm_tt_unpin_userptr(struct ttm_device *bdev,
>>>    * Ctrl stack and modify their memory type to NC.
>>>    */
>>>   static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
>>> -                struct ttm_tt *ttm, uint64_t flags)
>>> +                struct ttm_buffer_object *tbo,
>>> +                uint64_t flags)
>>>   {
>>> +    struct amdgpu_bo *abo = ttm_to_amdgpu_bo(tbo);
>>> +    struct ttm_tt *ttm = tbo->ttm;
>>>       struct amdgpu_ttm_tt *gtt = (void *)ttm;
>>> -    uint64_t total_pages = ttm->num_pages;
>>> +    uint64_t total_pages;
>>>       int num_xcc = max(1U, adev->gfx.num_xcc_per_xcp);
>>>       uint64_t page_idx, pages_per_xcc;
>>> -    int i;
>>>       uint64_t ctrl_flags = AMDGPU_PTE_MTYPE_VG10(flags, AMDGPU_MTYPE_NC);
>>> +    int i;
>>> +
>>> +    if (!ttm && !abo->gart_res)
>>> +        return;
>>> +
>>> +    if (ttm) {
>>> +        total_pages = ttm->num_pages;
>>> +    } else {
>>> +        WARN_ON_ONCE(abo->gart_res->size != tbo->resource->size);
>>> +        total_pages = (abo->gart_res->size) >> PAGE_SHIFT;
>>> +    }
>>>         flags = AMDGPU_PTE_MTYPE_VG10(flags, AMDGPU_MTYPE_RW);
>>>   @@ -847,19 +860,33 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
>>>       do_div(pages_per_xcc, num_xcc);
>>>         for (i = 0, page_idx = 0; i < num_xcc; i++, page_idx += pages_per_xcc) {
>>> -        /* MQD page: use default flags */
>>> -        amdgpu_gart_bind(adev,
>>> -                gtt->offset + (page_idx << PAGE_SHIFT),
>>> -                1, &gtt->ttm.dma_address[page_idx], flags);
>>> -        /*
>>> -         * Ctrl pages - modify the memory type to NC (ctrl_flags) from
>>> -         * the second page of the BO onward.
>>> -         */
>>> -        amdgpu_gart_bind(adev,
>>> -                gtt->offset + ((page_idx + 1) << PAGE_SHIFT),
>>> -                pages_per_xcc - 1,
>>> -                &gtt->ttm.dma_address[page_idx + 1],
>>> -                ctrl_flags);
>>> +        if (ttm) {
>>> +            /* MQD page: use default flags */
>>> +            amdgpu_gart_bind(adev,
>>> +                    gtt->offset + (page_idx << PAGE_SHIFT),
>>> +                    1, &gtt->ttm.dma_address[page_idx], flags);
>>> +            /*
>>> +             * Ctrl pages - modify the memory type to NC (ctrl_flags) from
>>> +             * the second page of the BO onward.
>>> +             */
>>> +            amdgpu_gart_bind(adev,
>>> +                    gtt->offset + ((page_idx + 1) << PAGE_SHIFT),
>>> +                    pages_per_xcc - 1,
>>> +                    &gtt->ttm.dma_address[page_idx + 1],
>>> +                    ctrl_flags);
>>> +        } else {
>>> +            u64 pa = (tbo->resource->start + page_idx) << PAGE_SHIFT;
>>> +            u64 start_page = abo->gart_res->start + page_idx;
>>> +
>>> +            pa += adev->vm_manager.vram_base_offset;
>>> +            amdgpu_gart_map_vram_range(adev, pa, start_page, 1,
>>> +                           flags, NULL);
>>> +
>>> +            amdgpu_gart_map_vram_range(adev, pa + PAGE_SIZE,
>>> +                           start_page + 1,
>>> +                           pages_per_xcc - 1,
>>> +                           ctrl_flags, NULL);
>>> +        }
>>>       }
>>>   }
>>>   @@ -875,12 +902,14 @@ static void amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
>>>           flags |= AMDGPU_PTE_TMZ;
>>>         if (abo->flags & AMDGPU_GEM_CREATE_CP_MQD_GFX9) {
>>> -        amdgpu_ttm_gart_bind_gfx9_mqd(adev, ttm, flags);
>>> +        amdgpu_ttm_gart_bind_gfx9_mqd(adev, tbo, flags);
>>>       } else {
>>>           amdgpu_gart_bind(adev, gtt->offset, ttm->num_pages,
>>>                    gtt->ttm.dma_address, flags);
>>>       }
>>> -    gtt->bound = true;
>>> +
>>> +    if (ttm)
>>> +        gtt->bound = true;
>>>   }
>>>     /*
>>> @@ -1000,6 +1029,54 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
>>>       return 0;
>>>   }
>>>   +int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo,
>>> +                  u64 *gpu_addr)
>>> +{
>>> +    struct ttm_buffer_object *bo = &abo->tbo;
>>> +    struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
>>> +    struct ttm_operation_ctx ctx = { false, false };
>>> +    struct ttm_placement placement;
>>> +    struct ttm_place placements;
>>> +    struct ttm_resource *res;
>>> +    uint64_t flags;
>>> +    int r;
>>> +
>>> +    /* Only for valid VRAM bo resource */
>>> +    if (bo->resource->start == AMDGPU_BO_INVALID_OFFSET)
>>> +        return 0;
>>> +
>>> +    r = amdgpu_bo_reserve(abo, false);
>>> +    if (unlikely(r))
>>> +        return r;
>>> +
>>> +    /* allocate GART space */
>>> +    placement.num_placement = 1;
>>> +    placement.placement = &placements;
>>> +    placements.fpfn = 0;
>>> +    placements.lpfn = adev->gmc.gart_size >> PAGE_SHIFT;
>>> +    placements.mem_type = TTM_PL_TT;
>>> +    placements.flags = bo->resource->placement;
>>> +
>>> +    r = ttm_bo_mem_space(bo, &placement, &res, &ctx);
>>> +    if (unlikely(r))
>>> +        goto out_unreserve;
>>> +
>>> +    /* compute PTE flags for this buffer object */
>>> +    flags = amdgpu_ttm_tt_pte_flags(adev, NULL, bo->resource);
>>> +
>>> +    /* Bind VRAM pages */
>>> +    abo->gart_res = res;
>>> +
>>> +    amdgpu_ttm_gart_bind(adev, bo, flags);
>>> +    amdgpu_gart_invalidate_tlb(adev);
>>> +
>>> +    *gpu_addr = res->start << PAGE_SHIFT;
>>> +
>>> +out_unreserve:
>>> +    amdgpu_bo_unreserve(abo);
>>> +    return r;
>>> +}
>>> +
>>>   /*
>>>    * amdgpu_ttm_recover_gart - Rebind GTT pages
>>>    *
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> index 15e659575087..707654732759 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> @@ -179,6 +179,7 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
>>>               u64 k_job_id);
>>>     int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
>>> +int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo, u64 *gpu_addr);
>>>   void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
>>>   uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
>>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>>> index c6945c842267..d96de02c6bb9 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>>> @@ -148,6 +148,14 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
>>>               kfree(mqd_mem_obj);
>>>               return NULL;
>>>           }
>>> +
>>> +        retval = amdgpu_ttm_alloc_gart_vram_bo(mqd_mem_obj->gtt_mem,
>>> +                               &(mqd_mem_obj->gpu_addr));
>>> +        if (retval) {
>>> +            amdgpu_amdkfd_free_gtt_mem(node->adev, &(mqd_mem_obj->gtt_mem));
>>> +            kfree(mqd_mem_obj);
>>> +            return NULL;
>>> +        }
>>>       } else {
>>>           retval = kfd_gtt_sa_allocate(node, sizeof(struct v9_mqd),
>>>                   &mqd_mem_obj);
> 

