Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA14EC021A0
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Feb 2025 07:49:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68AA910E147;
	Mon, 17 Feb 2025 07:49:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s2QlUkPL";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D41410E147
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Feb 2025 07:49:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KkTPJxHtz/hNPPZ1mf/2fTVDuzK8u5lqSEO/yjqiD3Jazq8E0Pws14fxYec4U06CuBc5RiX6iV9s8d4sbP7ildUm1uqx9O0suwZKCsHH5ESLxIdKFL7GCU1QiFL0ozN/3b+hnaYdQNkL6djlb7S49UU8fHAr4FbLfRNjRZpO5GpHry80Sd30xG+HYMAC+Jmg65yuURP5CUmxMG4dLdWj+Wie7xQh3Tmz92s9FP2qFFFEdQ5jGQDuWQw8usbm2fZkAuDTAaDkwDjRvNJqgnonFpA+ZmcN/UkaSYKS4R4OaIBN1WpG946GLIiPsKgGaGaGT/kGtG2S97iNaFfY0twOag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wsEDF0QsWqlhpTcZluz6nLD9Gw8hWr1X/k+oDBzdoI8=;
 b=fHm8vqpErsMQhsII0eTnIjQJsTwoea+5IPJY4jRGnC6rhtwyyMco+iBHFnSN+LMjGiWIWkVlc5O+vkrksjN8DoG7/QdUV3oFK3KZg4mKDh73mwJr6I6nUBlSKV6XS2raELadqz9cclaorpAUcpkn81FR4RZi0KorHGzZssY8yD4JBlXQSAC9ztuKyeIuXte5s8GmEwxWXX3lcr6uKfiozUMei8qkMAi5WhnzTbiNiKDKHBOTLoDbBD2J1lBh6OC1FgTZ19N/NoyPkD27Kg2v7kuu3Dh7uFhJ8RSVQZAQnZLfcMkYsV/miT9SNqOaX4b3qy2tKY2st4GuG9GNhms0QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsEDF0QsWqlhpTcZluz6nLD9Gw8hWr1X/k+oDBzdoI8=;
 b=s2QlUkPLHHnWu3FTDFL56eN/RHIi3x5cEAiKOTVKjJjzYvvrZnJPu/WJUAPdn9QI+6/UTmsa2iVkJptApyBPYYpEk6nPm3SvzhFusBG7JLkJ+0JBtjZNfpefZUHHmTouf4J5oEuwoZX+E8Osg30iM5grmzVYuYW1ItRdVa27B4w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY8PR12MB8364.namprd12.prod.outlook.com (2603:10b6:930:7f::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.19; Mon, 17 Feb 2025 07:49:34 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 07:49:34 +0000
Message-ID: <ff8f30be-b948-44ff-a624-990ecf51619e@amd.com>
Date: Mon, 17 Feb 2025 13:19:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: simplify xgmi peer info calls
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250212155734.2213096-1-jonathan.kim@amd.com>
 <63230f85-c3de-43aa-b23a-d7cec00d23ab@amd.com>
 <CY8PR12MB743521D96B986FABB06327D285FF2@CY8PR12MB7435.namprd12.prod.outlook.com>
 <3536548b-9e4f-4223-92a3-d616c4843f90@amd.com>
 <CY8PR12MB74355B8D95866E74CE18ADE685FE2@CY8PR12MB7435.namprd12.prod.outlook.com>
 <DS0PR12MB780445C81DE6CB10E083174397FE2@DS0PR12MB7804.namprd12.prod.outlook.com>
 <CY8PR12MB743532330A07911F2FA60DEA85FE2@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CY8PR12MB743532330A07911F2FA60DEA85FE2@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::19) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CY8PR12MB8364:EE_
X-MS-Office365-Filtering-Correlation-Id: 88ea1109-a2ed-4e4a-59c2-08dd4f279e86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bVNOcWpWVGRJWmNSM0w3b25tWEFnR21vNjFDd0RGZ2pzWWpNOGQwcmt5Umxw?=
 =?utf-8?B?VnNBZU1IQTBGYlVvKy9ZWEhqR3o3dWVqZlNoc3BDK2l4MENWT3hVZkoxTVd1?=
 =?utf-8?B?Z2Vxd2tFZVpneXpkMkNVZHkzZkF5MHVhSnFBeEZVT1p1V1dXTThaWElVejNu?=
 =?utf-8?B?N1Jlbk0xNnRwOFVibmplak1wd2sxUGFibVJrTzlqUUFlREtHZkZlQTczQkdM?=
 =?utf-8?B?eVI2VW9DOEhIZTFGeEdTOHF1QjNGeXlCSHl6Uk5aM2ZldUpaUXFkM2JzUFJF?=
 =?utf-8?B?cllCQWpRZm9CdXVjNHJwZjdNWGpVWjAwL3g4WE4wdEs5c2R2clA5MFBHV0ly?=
 =?utf-8?B?L2c3Z3YvazJEUWh2WWRqOGJiVXVCMzV3d1B0Y1c4OXhXd0xBZnQyV0JsTDYy?=
 =?utf-8?B?ZDBWQW5Wck5kQXlTWDgya0lUQVlKYkN0bCt1V2UvQTVYZzlwM0ZETEdIaHBR?=
 =?utf-8?B?eVFuRmE1SU41Z0xNdm41MzVVcFVBN0lMNTdlV0ZOZ1dKVmxSZVlOSnhuclc2?=
 =?utf-8?B?aDlaWmpaVDZUT1VMMzFRNlNZdnRJK1BlU2V0NHVWTGl0WFVlaVFXMnNZRnlT?=
 =?utf-8?B?T3YwaU13RlM4Y1hpTXdIVUxQV3FJQ2NVbDNDamZqMUp0ZndEM25qbGlEbjdl?=
 =?utf-8?B?d3EzYjY2ZWd4L1lKU0Z3Y2FLbVVXWUZKSzRjWnk1dEYyVW5vRU9vaG5tNlVC?=
 =?utf-8?B?RkdPZWF1aENselNuMnBxM2xvbzBjTUU1aXBPaEVmdGI3TTA4WW95ZTZlS1VC?=
 =?utf-8?B?OHhFaTF0SU5MU045TXlEMWNxNTNJZTk0ZVAyTU1Xb0RhSUN0WXZ1S3ozM2tj?=
 =?utf-8?B?YTR5ZUJ4R0h3UzN3NHJsb1hWQXVUdlY4ZWJONFh1c25xYlMxMjhWakxJMHhZ?=
 =?utf-8?B?OUNOSTRHcUd2ZGFqZWJOK1YyM3JMRk5Mb2xKWnBQZ1lVK21RTmxXd09OQWZj?=
 =?utf-8?B?SXl6T21WUVhtRzNDUTZzVHBJeVRJYkJuY2N4MENBTjlmMExYNENhSFpKUjVh?=
 =?utf-8?B?OHhabWpmdU5lZThBMG5VL0M5SVIyMlBlcGxKcWNKZk9NbzdDMXlwNDdQWTU3?=
 =?utf-8?B?cU03aDl0bFZTRm4rcllpV1RIdzVGbXVNNXZrUHpXMnZZQ1JaZUU2UXRDM1c3?=
 =?utf-8?B?RTNicFZmaFpzUmtENEpuTTlxeWhxanBOTjh2NjQrYVdvc21mcE1xcGtScVps?=
 =?utf-8?B?QkxwQ1hsZUFVNExvdS9iVmlibktDMnhVUGFwTzU4ZVpoUVZsenZJVDlhbFJ0?=
 =?utf-8?B?a01FSHQxNC9lMVk1OWlYdk0rRjJ3dG5ZUUF4YVZjRnk1bUlzekpWOXVobDdr?=
 =?utf-8?B?VEIvcHRrSmViMmZKd290SmhZVXg5VlROaUx2bjM0enUrQ2tHV2MwM0lwaFdL?=
 =?utf-8?B?djRaM3FPSTNHclhUSW9ieHNxTXRqN2dUK0ZBNU9GS25mWHJaWXEwTUJZTzNu?=
 =?utf-8?B?Q25TbmhpMUZXSzJkSnc2SDNVNnNha0VocVltTUwzcnRCNDhtTnFBaEhiRGNG?=
 =?utf-8?B?aEhzcE9VazJ0REt2bTNROGNOcXc0L0s4ako1UXpvZW15WjUrZFlZL05MMkhD?=
 =?utf-8?B?UkJpUnlIMHRwTmZnaUwwaGIrWXVPOVZzS29sQnNGcm1wWklnaXJoMVJLSXI1?=
 =?utf-8?B?SFkzdUViS1dkbWJKS3pIcm54TWxzRCsySWpUdEVJQmRTbE9MVktqV3FaZ3lz?=
 =?utf-8?B?ZXZsbXN2ZWJWeTIxQUwwcDVkamdzSG5HU1lqbVRHcStCbEpZd25sU09oSmdp?=
 =?utf-8?B?Um1aQWdTd2Z3RE0zZE1VOGhpMXNjbnpHYlowZFFmRlFVOEdNeXFGY0F0Z3pj?=
 =?utf-8?B?eTVWV1liM0w3VC9WWm0rOVJJeXhaNHdISGhEc05mNkQ3bks5cDFQN09WZFpY?=
 =?utf-8?Q?bNfdxjjd82V7X?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2lMN0I0R0NINGsyZktzT2NCOFg2OW9BM0VjejBGTXVrRERJcmRtOWdZdGZY?=
 =?utf-8?B?dXdSU1VGbWRONGlyWTZuaGtjM1hUOXJ6Zlg1QlNvc0dqRjlrZ1hTT0R5V1d0?=
 =?utf-8?B?SDJncStNQ3BiSHlOTXZOOGc4UFBGaXpYL3I0eS9XZDFLQXhPWkxEeFNZb0JL?=
 =?utf-8?B?S2VtUm03NWV5cDdxYnE4ZDRSdjA4QTZ5L3dvcHJIMnJvNVNWK2lXZExRcm8y?=
 =?utf-8?B?c3dYa0p3NHJGYnVjbWtIcDVWcE9HNHZCTmNlODBtajZKdFVhcGE2Mi94amlJ?=
 =?utf-8?B?ZnJxdllWRzhZdlBqRnpRZFdmSFRQTFk5R2RQVUlMWnU0Y1BZRFplL2gyNTht?=
 =?utf-8?B?UU05bUZLWmtncmVjdGc5QTd1ZklPSUM1alJ0M3NmWlBQZHJESTR2SGx6VmlS?=
 =?utf-8?B?UzBmaTRHZ0xKejR3UVd4OGxEQ1hvclRrNEdvUVZveGMrMjBDQzc3Um1IT2lF?=
 =?utf-8?B?dXZXOUQ5S2FIdlM2WTdscXRxdVJualBWVmlzQnVBemZHQVZwOVVLYjJ2TGlV?=
 =?utf-8?B?eGRXeUI3TnBhVlZYRkdMS09pWm8wMmp6Q0xvQjlUWW1UUFd0YjZSZDNFbHVr?=
 =?utf-8?B?ZnNhL3R2QTBhT0pMQjBPYURGNWY4WVpGdFBhNEd2b0xnSUFvZnVpYTk3OHJ0?=
 =?utf-8?B?b3Yvc2w2dUl2Y2ExMFNaNmVvSythWGEzQVNzR0FZdk5TOGFzUTBlMDdBZkk0?=
 =?utf-8?B?WkRjSi9nNm5PZXdSbCttazVBUTh0MDZLNTJlbC9GNFhpVGpVbFV3TFd3bUFY?=
 =?utf-8?B?R3IvRVlUTHlzYk5wUlhhbkxndnRmMUovQ0IwcWl1YXlab1hlS3FuZldxTm03?=
 =?utf-8?B?cnFRT2hhZy9zQzNDUlhhTEpMRENselZqMjU1eUhBekVjaW5lb1ZkVkdzZTZn?=
 =?utf-8?B?TFdYUXpadUpLMnRrVXlvU3dLY0lrMlZUWnAxZnBGMFB2Tm1iYlh2RlFCemgx?=
 =?utf-8?B?OEF3RnNYbGxiaEE2Zmt6WDFWWExzRXpoaHUyU1l4aXAwalB4N2tNSVhIZjJ6?=
 =?utf-8?B?VllJUDhBWHhodTh6TEoyT3ROcGN4QzFDQ012aVFhRmFDN3J4bGZnbHY3WEh1?=
 =?utf-8?B?Y3BYSElMRTh0OE1pbUtVM2dmQUdWOXhzcGRrQzB6eGQ2RlRmRmJwZkR2OXRt?=
 =?utf-8?B?cHNCaCtmZDlsSFAwMEtnM0l0cS9jcnFtUmxKOXN0d0xaVGlheVdFenBqaWti?=
 =?utf-8?B?WGF1ZGY5bDg1Z045ZGxpUGVmL05lR2I4V0sxT3RBQkVHWWMxSlJnT21tV1pU?=
 =?utf-8?B?ZXByRmNhNDNHRFlFdXg0S05ud2gyTloveEJldnpvZG1JRlQxNWNwNFlMNDZQ?=
 =?utf-8?B?cXZJbnUvL2psTE56WUVXekRmS2ozWUhrdTFhNGRDRXFVLzBlQVRGOVA2Ykxx?=
 =?utf-8?B?SytheWY2QWxLU3F6Nno2STVlMUQ5RUJSKzVGcUxxUjFZeU1vbG5sczNWMWl2?=
 =?utf-8?B?Z2V3L2JVYVo2V0poZ2tMWkw1T1lxUUgwQ2FFRmhnOE9zU2dyUS9nYjBmbERI?=
 =?utf-8?B?NGVpYS9mSVFIS2N6QnVJa1VHUE1rL0xRWjcxYlI5ZldpMzQvcUVKQThwYjZp?=
 =?utf-8?B?Z2REcTVrSm9CYVpxUkhIRHRUT1lsNWlvTFR0OVN2UzM3alJET2R1dG1Mb0RP?=
 =?utf-8?B?c0NsTmNjSGlkVHNRaHJwNWhTOGliWStSSDhBOENHeHpmWEI3Zlk3OExGQmtV?=
 =?utf-8?B?cnQxdTVST3RLU3Z3QUZxMnF6WXV0RTI1K1pQWVJFenB2Wi82eDAvb29Pa0lY?=
 =?utf-8?B?U3BIUlFiV2NRNlRGMGwrVHVIWWtrR2N0cFB4bjdHRVhsZFFscThrVnAxS0M2?=
 =?utf-8?B?ajlyOCtUWGdKa040MFlKZFBoVXcyRDF0dHpsVDQ5K1pMNDg3U2NKVUNLSkM4?=
 =?utf-8?B?RUhVN1MyczBhTlZmQldZQ0RYMEt5WWJrWk8rR0R4SGlIdktpcjlhQzlHa0Jv?=
 =?utf-8?B?MXVvL2V4UFNBMXNxMXVoOTZwMjFhUVhrN3hOTkRyYk9qUnRwY1d4SmlOS3ow?=
 =?utf-8?B?ckFYRCthVUt6MXlzVjh3M3FZWDRSc1lBSHdMSzZPZHZIQVg5b3JGdWRDVHcx?=
 =?utf-8?B?aDhyNzF2Skh1UnBZMGQxN1drVXFOVll2V2pCS001ei8yT3puN0dFQVRELzF4?=
 =?utf-8?Q?B4hNRRjTKo4+yHHx8O/x5e0JA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ea1109-a2ed-4e4a-59c2-08dd4f279e86
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 07:49:34.1912 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+/jo2eOM+jiyEMej7KgEYQn9wMCd7NuqJExj5tzao2WT38bhCqUuHzScw9ZEKkA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8364
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



On 2/14/2025 9:54 PM, Kim, Jonathan wrote:
> [Public]
> 
> 
> We could be talking about 2 types of bandwidth here.
> 
>  1. Bandwidth per link
>  2. Bandwidth per peer i.e. multiple xgmi links that are used for SDMA
>     gang submissions for effective max bandwidth * num_link copy speed. 
>     The is currently used by runtime i.e. max divide by min.  The number
>     of links per peer can be variable.
> 
>  
> 
> The peerless request is requesting for #1 because there should be no
> speed variability of links based on peer i.e. requesting max bandwidth
> per link for 1 link.
> 
>  
> 
> The interface could look like amdgpu_xgmi_get_bandwidth(adev, peer, enum
> unit_type, int *min, int *max) then.
> 
> Unit_type could be defined for illustration:
> 
> #define AMDGPU_XGMI_BW_MBYTES_MIN_MAX_PER_LINK 0
> 
> #define AMDGPU_XGMI_BW_MBYTES_MIN_MAX_PER_PEER 1
> 
>  
> 
> Where if unit_type == AMDGPU_XGMI_BW_*_MIN_MAX_PER_LINK, call would
> ignore peer and populate *min/max with per link min/max (keeps it open
> for powerplay range per link)
> 
> While unit_type  == AMDGPU_XGMI_BW_*_MIN_MAX_PER_PEER, call would
> populate *min/max with per peer, where min/max is max_bw * num_link range.
> 

Thanks, Jon. I'm aligned with this approach.

Thanks,
Lijo

> 
> Jon
> 
>  
> 
> *From:*Lazar, Lijo <Lijo.Lazar@amd.com>
> *Sent:* Friday, February 14, 2025 10:39 AM
> *To:* Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
> *Subject:* Re: [PATCH] drm/amdgpu: simplify xgmi peer info calls
> 
>  
> 
> [Public]
> 
>  
> 
> For minimum bandwidth, we should keep the possibility of going to FW to
> get the data when XGMI DPM is in place. So it is all wrapped inside the
> API when the devices passed are connected. The caller doesn't need to know.
> 
>  
> 
> BTW, what is the real requirement of bandwidth data without any peer
> device? In what way that is useful?
> 
>  
> 
> Thanks,
> 
> Lijo
> 
> ------------------------------------------------------------------------
> 
> *From:*Kim, Jonathan <Jonathan.Kim@amd.com <mailto:Jonathan.Kim@amd.com>>
> *Sent:* Friday, February 14, 2025 8:27:28 PM
> *To:* Lazar, Lijo <Lijo.Lazar@amd.com <mailto:Lijo.Lazar@amd.com>>; amd-
> gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org> <amd-
> gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>>
> *Subject:* RE: [PATCH] drm/amdgpu: simplify xgmi peer info calls
> 
>  
> 
> [Public]
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com <mailto:Lijo.Lazar@amd.com>>
>> Sent: Friday, February 14, 2025 12:58 AM
>> To: Kim, Jonathan <Jonathan.Kim@amd.com <mailto:Jonathan.Kim@amd.com>>; amd-
> gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>> Subject: Re: [PATCH] drm/amdgpu: simplify xgmi peer info calls
>>
>>
>>
>> On 2/13/2025 9:20 PM, Kim, Jonathan wrote:
>> > [Public]
>> >
>> >> -----Original Message-----
>> >> From: Lazar, Lijo <Lijo.Lazar@amd.com <mailto:Lijo.Lazar@amd.com>>
>> >> Sent: Thursday, February 13, 2025 1:35 AM
>> >> To: Kim, Jonathan <Jonathan.Kim@amd.com <mailto:Jonathan.Kim@amd.com>>; amd-
> gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>> >> Subject: Re: [PATCH] drm/amdgpu: simplify xgmi peer info calls
>> >>
>> >>
>> >>
>> >> On 2/12/2025 9:27 PM, Jonathan Kim wrote:
>> >>> Deprecate KFD XGMI peer info calls in favour of calling directly from
>> >>> simplified XGMI peer info functions.
>> >>>
>> >>> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com <mailto:jonathan.kim@amd.com>>
>> >>> ---
>> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 42 ------------------
>> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  5 ---
>> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   | 51 +++++++++++++++++-----
>> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h   |  6 +--
>> >>>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c      | 11 +++--
>> >>>  5 files changed, 48 insertions(+), 67 deletions(-)
>> >>>
>> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> >>> index 0312231b703e..4cec3a873995 100644
>> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> >>> @@ -555,48 +555,6 @@ int amdgpu_amdkfd_get_dmabuf_info(struct
>> >> amdgpu_device *adev, int dma_buf_fd,
>> >>>     return r;
>> >>>  }
>> >>>
>> >>> -uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct amdgpu_device *dst,
>> >>> -                                     struct amdgpu_device *src)
>> >>> -{
>> >>> -   struct amdgpu_device *peer_adev = src;
>> >>> -   struct amdgpu_device *adev = dst;
>> >>> -   int ret = amdgpu_xgmi_get_hops_count(adev, peer_adev);
>> >>> -
>> >>> -   if (ret < 0) {
>> >>> -           DRM_ERROR("amdgpu: failed to get  xgmi hops count between
>> >> node %d and %d. ret = %d\n",
>> >>> -                   adev->gmc.xgmi.physical_node_id,
>> >>> -                   peer_adev->gmc.xgmi.physical_node_id, ret);
>> >>> -           ret = 0;
>> >>> -   }
>> >>> -   return  (uint8_t)ret;
>> >>> -}
>> >>> -
>> >>> -int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct amdgpu_device *dst,
>> >>> -                                       struct amdgpu_device *src,
>> >>> -                                       bool is_min)
>> >>> -{
>> >>> -   struct amdgpu_device *adev = dst, *peer_adev;
>> >>> -   int num_links;
>> >>> -
>> >>> -   if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, 4, 2))
>> >>> -           return 0;
>> >>> -
>> >>> -   if (src)
>> >>> -           peer_adev = src;
>> >>> -
>> >>> -   /* num links returns 0 for indirect peers since indirect route is unknown. */
>> >>> -   num_links = is_min ? 1 : amdgpu_xgmi_get_num_links(adev, peer_adev);
>> >>> -   if (num_links < 0) {
>> >>> -           DRM_ERROR("amdgpu: failed to get xgmi num links between
>> >> node %d and %d. ret = %d\n",
>> >>> -                   adev->gmc.xgmi.physical_node_id,
>> >>> -                   peer_adev->gmc.xgmi.physical_node_id, num_links);
>> >>> -           num_links = 0;
>> >>> -   }
>> >>> -
>> >>> -   /* Aldebaran xGMI DPM is defeatured so assume x16 x 25Gbps for
>> >> bandwidth. */
>> >>> -   return (num_links * 16 * 25000)/BITS_PER_BYTE;
>> >>> -}
>> >>> -
>> >>>  int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct amdgpu_device *adev,
>> >> bool is_min)
>> >>>  {
>> >>>     int num_lanes_shift = (is_min ? ffs(adev->pm.pcie_mlw_mask) :
>> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> >>> index 092dbd8bec97..28eb1cd0eb5a 100644
>> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> >>> @@ -255,11 +255,6 @@ int amdgpu_amdkfd_get_dmabuf_info(struct
>> >> amdgpu_device *adev, int dma_buf_fd,
>> >>>                               uint64_t *bo_size, void *metadata_buffer,
>> >>>                               size_t buffer_size, uint32_t *metadata_size,
>> >>>                               uint32_t *flags, int8_t *xcp_id);
>> >>> -uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct amdgpu_device *dst,
>> >>> -                                     struct amdgpu_device *src);
>> >>> -int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct amdgpu_device *dst,
>> >>> -                                       struct amdgpu_device *src,
>> >>> -                                       bool is_min);
>> >>>  int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct amdgpu_device *adev,
>> >> bool is_min);
>> >>>  int amdgpu_amdkfd_send_close_event_drain_irq(struct amdgpu_device *adev,
>> >>>                                     uint32_t *payload);
>> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>> >>> index 74b4349e345a..d18d2a26cc91 100644
>> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>> >>> @@ -818,28 +818,59 @@ int amdgpu_xgmi_update_topology(struct
>> >> amdgpu_hive_info *hive, struct amdgpu_dev
>> >>>   * num_hops[2:0] = number of hops
>> >>>   */
>> >>>  int amdgpu_xgmi_get_hops_count(struct amdgpu_device *adev,
>> >>> -           struct amdgpu_device *peer_adev)
>> >>> +                          struct amdgpu_device *peer_adev)
>> >>>  {
>> >>>     struct psp_xgmi_topology_info *top = &adev->psp.xgmi_context.top_info;
>> >>>     uint8_t num_hops_mask = 0x7;
>> >>>     int i;
>> >>>
>> >>> +   if (!adev->gmc.xgmi.supported)
>> >>> +           return 0;
>> >>> +
>> >>>     for (i = 0 ; i < top->num_nodes; ++i)
>> >>>             if (top->nodes[i].node_id == peer_adev->gmc.xgmi.node_id)
>> >>>                     return top->nodes[i].num_hops & num_hops_mask;
>> >>> -   return  -EINVAL;
>> >>> +
>> >>> +   DRM_ERROR("amdgpu: failed to get  xgmi hops count between node %d
>> >> and %d.\n",
>> >>
>> >> Suggest to use dev_ function to identify the device pci number. Since
>> >> the function still passes, maybe info level is good enough.
>> >
>> > Ack'd.  Will change.
>> >
>> >>
>> >>> +             adev->gmc.xgmi.physical_node_id,
>> >>> +             peer_adev->gmc.xgmi.physical_node_id);
>> >>> +
>> >>> +   return 0;
>> >>>  }
>> >>>
>> >>> -int amdgpu_xgmi_get_num_links(struct amdgpu_device *adev,
>> >>> -           struct amdgpu_device *peer_adev)
>> >>> +int amdgpu_xgmi_get_bandwidth_mbytes(struct amdgpu_device *adev,
>> >>> +                                struct amdgpu_device *peer_adev)
>> >>>  {
>> >>> -   struct psp_xgmi_topology_info *top = &adev->psp.xgmi_context.top_info;
>> >>> -   int i;
>> >>> +   int num_links = !peer_adev ? 1 : 0;
>> >>>
>> >>> -   for (i = 0 ; i < top->num_nodes; ++i)
>> >>> -           if (top->nodes[i].node_id == peer_adev->gmc.xgmi.node_id)
>> >>> -                   return top->nodes[i].num_links;
>> >>> -   return  -EINVAL;
>> >>> +   if (!adev->gmc.xgmi.supported)
>> >>> +           return 0;
>> >>> +
>> >>> +   if (peer_adev) {
>> >>> +           struct psp_xgmi_topology_info *top = &adev-
>> >>> psp.xgmi_context.top_info;
>> >>> +           int i;
>> >>> +
>> >>> +           for (i = 0 ; i < top->num_nodes; ++i) {
>> >>> +                   if (top->nodes[i].node_id != peer_adev->gmc.xgmi.node_id)
>> >>> +                           continue;
>> >>> +
>> >>> +                   num_links =  top->nodes[i].num_links;
>> >>> +                   break;
>> >>> +           }
>> >>> +   }
>> >>> +
>> >>> +   /* num links returns 0 for indirect peers since indirect route is unknown. */
>> >>> +   if (!num_links) {
>> >>
>> >> This looks problematic. I guess, it is better to keep the old way of
>> >> passing min/max. Otherwise, there is a chance that min reports some
>> >> value and max could report this error.
>> >
>> > I don't think this is a problem.  The old way of passing is_min ==  true is tied to
>> peer_dev == NULL, which made it a redundant argument.
>> > is_min ==  false doesn't prevent the issue you've mentioned from happening
>> because the old code effective sets num_link = 0 if the peer_dev search fails
>> anyways.
>>
>> The problem I was thinking about was with respect to usage in KFD
>> properties. With this way, min_bandwidth will report some value even if
>> no link is present between the devices. Max bandwidth will report 0.
>> Ideally, we should report both min/max = 0 when there is no link present
>> between the devices. I haven't checked if KFD does some other check to
>> ensure that there are links between devices before calling the API.
> 
> The KFD only queries for links within a hive.
> Checking for max first implies link on non-zero return.
> We could change the KFD to set zero on if max is zero then.
> 
>>
>>
>> > With the line at the top of the proposed function:
>> >>> +   int num_links = !peer_adev ? 1 : 0;
>> > The sematics are as follows:
>> > - NULL peer_dev indicates that caller doesn't want peer-to-peer data to factor
>> num_links into bandwidth reporting so assume a single XGMI link in bandwidth
>> calculation.
>>
>> I think this semantics doesn't provide enough clarity. XGMI is
>> interconnect between devices and ideally we expect two devices to be
>> passed to the API. If any one is NULL, then it's better to reject.
>>
>> > - If a failed peer_dev search ends up with num_links == 0, that means the caller
>> passed in an invalid node (i.e. it's not one of the nodes that's been registered to the
>> hive).
>> > Currently, get_hops_count (old and proposed) operates in the same fashion too.
>> > So the functionality between the proposed changes and old changes should have
>> remained the same.
>> >
>>
>> The API is usage is clear and general expectation is two devices are not
>> NULL. That is clear in the case of get_hops_count.
> 
> I don't see where that expectation is set in the proposal.
> peer_dev == NULL is asking for a peerless check of potential bandwidth.
> If you're saying we need a redundant is_min bool to ignore peer_dev
> num_links checks, I'd say then both are a waste of time for clarity's sake.
> 
> In that case, if we want to be strict with both peers being non-NULL,
> change the following:
> - expose amdgpu_xgmi_get_num_links to KFD to mirror get_num_hops
> - KFD calls amdgpu_xgmi_get_num_links to do some handling and later pass
> return into a new bandwidth call if return is non-zero
> - change amdgpu_xgmi_get_bandwidth_mbytes(peer1, peer2) to
> amdgpu_xgmi_get_bandwidth(adev, const int num_links, enum unit_type)
>         - adev -> used for future IP checks as a dynamic internal speed
> constant setter
>         - const int num_links -> caller passes in constant link
> multiplier.  So in this case KFD can pass back the num_links it finds
> from previous amdgpu_xgmi_get_num_links
>         - enum unit_type -> some enum we can define in amdgpu_xgmi.h to
> give the back the caller whatever units it's looking for (GTs, Mbytes/
> sec, Mbps etc ...)
> 
> Then this way:
> - KFD enforces min/max bandwidth to be consistent i.e. both are 0 or
> both are non-zero
> - bandwidth call is now more general purpose and flexible and provides
> various bandwidth return types by caller needs.
> 
> Jon
> 
>>
>> > I'm open to adjusting get_num_hops & get_bandwidth_mbytes to return either -
>> ENODEV (device not found in hive) or -EINVAL (bad peer_dev request) on a failed
>> search.
>>
>> On a failed search, does returning 0 work - zero hop/bandwidth
>> considered as no link found between the provided devices?
>>
>> Thanks,
>> Lijo
>>
>> > That would require a change to KFD CRAT logic to error return itself on an error.
>> > However, this would change the behaviour of a bandwidth reporting error where
>> ROCm could still function, to the KFD not loading at all.
>> > Currently, the consequence of passing an incorrect peer_dev to the bandwidth call
>> would result in the ROCm Runtime not issuing an SDMA ganged copy i.e. potential
>> peer-to-peer performance drop.
>> >
>> > Jon
>> >
>> >>
>> >> Thanks,
>> >> Lijo
>> >>
>> >>> +           DRM_ERROR("amdgpu: failed to get xgmi num links between
>> >> node %d and %d.\n",
>> >>> +                     adev->gmc.xgmi.physical_node_id,
>> >>> +                     peer_adev->gmc.xgmi.physical_node_id);
>> >>> +   }
>> >>> +
>> >>> +   /*
>> >>> +    * TBD - will update IP based bandwidth later.
>> >>> +    * Bandwidth currently assumed to be x16 lanes x 25Gbps.
>> >>> +    */
>> >>> +   return (num_links * 16 * 25000)/BITS_PER_BYTE;
>> >>>  }
>> >>>
>> >>>  bool amdgpu_xgmi_get_is_sharing_enabled(struct amdgpu_device *adev,
>> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
>> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
>> >>> index d1282b4c6348..325e7972469d 100644
>> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
>> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
>> >>> @@ -62,10 +62,8 @@ int amdgpu_xgmi_update_topology(struct
>> >> amdgpu_hive_info *hive, struct amdgpu_dev
>> >>>  int amdgpu_xgmi_add_device(struct amdgpu_device *adev);
>> >>>  int amdgpu_xgmi_remove_device(struct amdgpu_device *adev);
>> >>>  int amdgpu_xgmi_set_pstate(struct amdgpu_device *adev, int pstate);
>> >>> -int amdgpu_xgmi_get_hops_count(struct amdgpu_device *adev,
>> >>> -           struct amdgpu_device *peer_adev);
>> >>> -int amdgpu_xgmi_get_num_links(struct amdgpu_device *adev,
>> >>> -           struct amdgpu_device *peer_adev);
>> >>> +int amdgpu_xgmi_get_hops_count(struct amdgpu_device *adev, struct
>> >> amdgpu_device *peer_adev);
>> >>> +int amdgpu_xgmi_get_bandwidth_mbytes(struct amdgpu_device *adev, struct
>> >> amdgpu_device *peer_adev);
>> >>>  bool amdgpu_xgmi_get_is_sharing_enabled(struct amdgpu_device *adev,
>> >>>                                     struct amdgpu_device *peer_adev);
>> >>>  uint64_t amdgpu_xgmi_get_relative_phy_addr(struct amdgpu_device *adev,
>> >>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>> >> b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>> >>> index 70b3ae0b74fe..a787d192390c 100644
>> >>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>> >>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>> >>> @@ -2133,8 +2133,8 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int
>> >> *avail_size,
>> >>>             bool ext_cpu = KFD_GC_VERSION(kdev) != IP_VERSION(9, 4, 3);
>> >>>             int mem_bw = 819200, weight = ext_cpu ?
>> >> KFD_CRAT_XGMI_WEIGHT :
>> >>>
>> >>       KFD_CRAT_INTRA_SOCKET_WEIGHT;
>> >>> -           uint32_t bandwidth = ext_cpu ?
>> >> amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(
>> >>> -                                                   kdev->adev, NULL, true) :
>> >> mem_bw;
>> >>> +           uint32_t bandwidth = ext_cpu ?
>> >> amdgpu_xgmi_get_bandwidth_mbytes(kdev->adev, NULL) :
>> >>> +                                          mem_bw;
>> >>>
>> >>>             /*
>> >>>              * with host gpu xgmi link, host can access gpu memory whether
>> >>> @@ -2198,12 +2198,11 @@ static int kfd_fill_gpu_xgmi_link_to_gpu(int
>> >> *avail_size,
>> >>>
>> >>>     if (use_ta_info) {
>> >>>             sub_type_hdr->weight_xgmi = KFD_CRAT_XGMI_WEIGHT *
>> >>> -                   amdgpu_amdkfd_get_xgmi_hops_count(kdev->adev,
>> >> peer_kdev->adev);
>> >>> +                   amdgpu_xgmi_get_hops_count(kdev->adev, peer_kdev-
>> >>> adev);
>> >>>             sub_type_hdr->maximum_bandwidth_mbs =
>> >>> -                   amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(kdev->adev,
>> >>> -                                                   peer_kdev->adev, false);
>> >>> +                   amdgpu_xgmi_get_bandwidth_mbytes(kdev->adev,
>> >> peer_kdev->adev);
>> >>>             sub_type_hdr->minimum_bandwidth_mbs = sub_type_hdr-
>> >>> maximum_bandwidth_mbs ?
>> >>> -                   amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(kdev->adev,
>> >> NULL, true) : 0;
>> >>> +                   amdgpu_xgmi_get_bandwidth_mbytes(kdev->adev, NULL) :
>> >> 0;
>> >>>     } else {
>> >>>             bool is_single_hop = kdev->kfd == peer_kdev->kfd;
>> >>>             int weight = is_single_hop ?
>> >> KFD_CRAT_INTRA_SOCKET_WEIGHT :
>> >
> 

