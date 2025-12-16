Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE71D609B6
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 16:06:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAF2510E83E;
	Tue, 16 Dec 2025 16:06:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sejJNz27";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012049.outbound.protection.outlook.com [40.107.209.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 825CD10E83E
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 16:06:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NJaWcl0D54zKYyaQWbsTyGmbxomnWXFK7ZutVTCDikeJ7AauApiD1uA2Lf5g7JyK88IA3cNUUhmZavBIL1STlKMkya+tOT6uLNKzzc54umLgxxy5V8+q09769Zsc5wnML2aMJit2Emo+4OyvdVEClA7GChdVOF3+W5BrIHSu9nZ48nMxlQ5EvD20nHMa+wwncXVyAdW37zCf0PH7Jjlu+xN7fO1Gwn0xQxHPhgK5D5RHpOaB0MCfs5ee/jAehQdHwC3AF8Syw2g6Seo1DLKSez95PNS7LLiKEkGSbCZQ6bfKNusDgZXBWwDzmgT90MUFOGE1bWnqTtGU6PfKqhNC1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5pil21gQ/RKCyA2GwUiC1hEagJ/N8B2NbIprYLqW0w=;
 b=ZPnO6FozMvLObSTEEc28gBBcy88NLXn1phahKKPy+37NbWQNX7DtoL9CZNKy0GIWHYLbfo/37rF/jOyLsiwcme6mK1VFY6jNeFmds+Edg9cBDyL82H1ntBYn3SnAwzcaihK3MYOnXqzRMwzOoxVRMYoNI+IF8IbQRiN5pMll3/eWigraa6JWw5j5yE6zAbEKLxd7bF/+gfCIfwlC4ddLl7g+1p2+ugNRbPMCkExajfihg7p96dN4NiCMmwiB0af+2owqEbhd0ZVaQG7KGXPq3coVTW58DrOG09Dimhc04MoheexCBpAP1i7LUTbPJ4abvgV5260a1L1wzF0JSJBF9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5pil21gQ/RKCyA2GwUiC1hEagJ/N8B2NbIprYLqW0w=;
 b=sejJNz27wEYcXWtl+9qCFX9BBem23ZwQNj4vYiyMVam7etZ2HAjnaqlsNCNQvzuoktmy+GzaN7hrTptnhKjiGAi5REHwHUKL1y0huvSpRHGqibhk6vb/fB3yVh76pAAd7Fsgkq9H5LjCh0gBRWPzhwdmY9GIBwKq1B2PcCvCndM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 16:06:43 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 16:06:42 +0000
Message-ID: <a25b3fc8-4a13-49c6-8011-9830a53cf3c9@amd.com>
Date: Tue, 16 Dec 2025 17:06:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/8] amdgpu/amdkfd: Add support for non-4K page
 size systems
To: Donet Tom <donettom@linux.ibm.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Kent.Russell@amd.com,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>
References: <cover.1765519875.git.donettom@linux.ibm.com>
 <fbc164ab-964f-464d-b94a-80131016b5b8@amd.com>
 <871pl0567w.ritesh.list@gmail.com>
 <1f10b67a-ffdc-4962-af52-758247569e09@amd.com>
 <CADnq5_NbDzqucujDyW009+55mLXZz2PiyaSd9PKXXeXv4pYn0Q@mail.gmail.com>
 <996ef75a-71b3-4ba7-a255-40516c5e9acd@amd.com>
 <444bfeba-deae-4f7b-84d7-29048256b69d@linux.ibm.com>
 <50dee2c9-bcfc-462b-bf46-f110a082e2d3@amd.com>
 <45654396-6b21-4599-aeb9-0fed68135675@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <45654396-6b21-4599-aeb9-0fed68135675@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0034.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB5933:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d47a1c4-1329-4418-3729-08de3cbd1a27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ekJTSUdoTE83WFZiZDkrOU80R3dTNjI5OVBpVjNEeUFBdGtWbVpsVllrWnpQ?=
 =?utf-8?B?ejJRQ2hQYlllNFhmVDZIdFpHOVEvMHdkWkRxU1lKbklzd2s4VUFwQnJlTzB5?=
 =?utf-8?B?dmhyWERhSTkwZEdRNkdqVU9IT0N6STAvMWtiWTFXVkZJNUJsK3RMYWhreGVi?=
 =?utf-8?B?NHBLMlNPRkxWUGVrenR3ZFNiTDZpRUVRNjZIdXZwU1gwRkNnbFk0bnREV05Q?=
 =?utf-8?B?ampXcTZuOFNZd0pXVFpOaUZsc0dJQmx2YnRSYVFGdnI2Y3J3Q3hGOUpBYXE5?=
 =?utf-8?B?Y21DNm9kdFl3YzhSaG8zUDIyMllrTUovUnl6ZVpvUmFicTJvcDIrdnA3c1lr?=
 =?utf-8?B?ZGF4OGNCRE9vZzdsdi8yQjZSYTVjaVJCWlJ5QUVtSzd4SXc2T0FDaUZIUS9w?=
 =?utf-8?B?OGE5TEFjRjh5UlR0U2FUb1dNZHNrREl3UHVFWWhHeVlTZEp2NTB3T0tsMjZW?=
 =?utf-8?B?cllzaXE1Nk9zYlZBb3c0UG9BS2JkS1dJNE4wZ2tFSEtuZjZ2Sjhlb0t1WGtw?=
 =?utf-8?B?TUVWOERDS1FreFpMRWx3aEFwTFBBVWtZb2VPMjdCcG5uY25NM2tDRC9GMEJt?=
 =?utf-8?B?eFFUemhpWSt6N2tCSEhJMzVTc2pwNUdoVG1QaXY0TGg0bG92dEdNR0F4RTcw?=
 =?utf-8?B?ZE9QZmM2L3QwVEhjYVJsMk5pM3E4U2EyUjd1R0dZbzdrWWVOSGpBV3p2SXVk?=
 =?utf-8?B?a1ZSUi9rMnlpRHJuVTdOYmpUQy9FZU9mZUIzcFEvRmU1VlJxTGJUeVI3TEtv?=
 =?utf-8?B?aXNuSGIrVU82M1cydGJQOEFEQWQzVUxTRyt1anRXLzBvWTZnQTUzWWdRaEpK?=
 =?utf-8?B?QnhiekFmUDRoK3hQOXAyYzhUMkxEODI5b3lzaGpBSkpIMnJ2NnhuaXIzREJF?=
 =?utf-8?B?OE11ajhhMk9ZcjlwSk9objg1T1FZQnJOM0QwOXExRmgxemZZVkVtRzBwTnNC?=
 =?utf-8?B?YzlBV0VEcUoxai82cW9HUm9KQ09pc29IY3pwR29KT2c2NVNWdkt5K05nbjZP?=
 =?utf-8?B?VHQwZytYcitsdElGUjE5bkRMdjZmd1lBMEVBSHgydENDR2pIeWRtUGNmZ2Fx?=
 =?utf-8?B?eUk3SXE4d1V5b1hzMGlsMm9SbjZEWitWL3NEbnJPS0tpZG9EN25LZjRQVzRU?=
 =?utf-8?B?ZGd6RnExeGRvN1dZdXpFc0o1TnNZM0RDWWZMV0JqNzE3bGVGaTBlRDFSbkd0?=
 =?utf-8?B?NjZoN2orbzFOUHBWaTNUelBvL1NVZEVHb0wzU0RVdmFxaTdIdDFpZUFKb2dW?=
 =?utf-8?B?ZmtXdXRzWWVIZ2c4dTZsSGZJZWhDbXM3Y1ZLL0g5bGxJMkVYdU9TR2Q1Vmkr?=
 =?utf-8?B?d3piRkp3bTBFL0lrTTlEOHhWTno4azR6aEZtSGhKSFBjNFQ0M2xsaVFkVkdU?=
 =?utf-8?B?ODdUNTNYTzRUdXg4a1pBOVdSRWJ0MXRKZndUNlZVQTBjQWtTWjl1L1pRK3JT?=
 =?utf-8?B?VjYwZG9HMGgvQitoV21WQ1hnUEZZSnIrNzM5SHd4SzJNU3ZiWjlLbVc0TjVz?=
 =?utf-8?B?L05QaE5FTUZwUmNWYXk5RklkbDIrTVBzVXRrQ1FZN0NwYnVSRmYyaGlGZUFQ?=
 =?utf-8?B?WHpmak0ydzFVelpRTjI5b3JEOHFFYndLa3pLWXZhYkVadFRvVDZiTDJvVlpV?=
 =?utf-8?B?R3ZLdytTNExPVFoxcVYzd21WNG1uRkNndm9oTXN6Lytua3hDRmMyRmlwcDB2?=
 =?utf-8?B?TmRBSThMR0kxN0ZyYitNZzJvVCtsN3owaWYyaDkrMGhCTXBWWnQwNGVlemZP?=
 =?utf-8?B?VE5Fb3VxYWtMZHpOZjVKQ1RSZ2tuRFAzYjZRNVdPamZ1NHNsMmNYL05aUm9i?=
 =?utf-8?B?aHBOSFB6bjE3UFJjZjR6T0tVUFhMTVlqNm92Njc5WWJCYWdVRTMxb3FmNGFp?=
 =?utf-8?B?RkFobnBBRWNTVGR3YXE4amJ0Z0ZKaUVVanBuTjFYZzNxV3ErbXFLckIxckto?=
 =?utf-8?Q?kGpXLvUXaKKiCsRhq63+03WVFNk5gDCf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDgweW9oeXdhWWdRdVNaUXNhSFJLRlh1SDBnRTdOU2xnVlk0b1RqcGJZbkJT?=
 =?utf-8?B?emY1WWptZHpndm14cWp1dHVuaWVlbFZUVElESVZYTXlIay84c0lDTmR0K2JR?=
 =?utf-8?B?dU5GdUFNRzRYVk53RGhPYjVEZHZ2RjM5ZTFRdVQxRUIvMUlkSDRMd2xnOGQz?=
 =?utf-8?B?WEdrVzhRTGlETXRYRTdlbW94dE52UTJoUlh4aUsyNzNsalNTVDdIdlRQajFG?=
 =?utf-8?B?ZWZZSlRLRFpjWkc1SC9HODlzTlF2dkVXYVZ0VWNNODJ1cDZKV3hjeWk0TDlh?=
 =?utf-8?B?ZkRMazlJQnpmMnl4UU9hSGNldGhYWlNIWUJqUDRHZkxLN2hLSkZhUFNtUllB?=
 =?utf-8?B?VklGZTR3bnQ2WXpvbnVldm5tMnFTVmNFTGtCaXB2d0N6aGFiejEzcjFzSitz?=
 =?utf-8?B?ZGZtQzlobFBOeGRGc2FTdHR5VlM1dmE1OWh5M01LdXZ6RXRhMmN4dWZ0MUFK?=
 =?utf-8?B?b3hZS3FZa3JWL1p0dHlQSlNQSWtEaWVUdTVSS1R0MkMxSEw4SktQNk1YUEtC?=
 =?utf-8?B?QWN0TmowL1FmVW5pQ1JMRXZBRWFmRjE1T242WGh1bWRwTTVFNGZZV2FUZ1Na?=
 =?utf-8?B?NmNVSlJpWW1YeGVxMlZxNFY2OU5EbmREeE9rWnVRbXFrTDVVZm5NQ2xzNUNS?=
 =?utf-8?B?ZG5vUWlVT2t2dkYvRUtvMlNkcFliT0tVSEN0bzE3bzQrcHYyanVhVnFId0FP?=
 =?utf-8?B?TzBuN1F3Yno1TEhRVUluNERXRjB6SHovdWpiMlpGMG8rZ0M0bFNtRnlmcExC?=
 =?utf-8?B?ci9rWEdHcXRTWUFNNk11M1ZUL2dMYk5lN3JsZkZBVWFnL3hsUWxVcWt3dlZ3?=
 =?utf-8?B?MlBXaDJtMkRkeVZjRzlBWnZ4WUlLdXFObVRsbzdxVU5ZVm0xelQ3QTBRMVl1?=
 =?utf-8?B?SUpGa2g4S1I1NktRdUZ0UURnYVRRQWN3WjRnZy9pa0VTMFRjM3BqWlNmN3pq?=
 =?utf-8?B?aW5XRDdxQWIrWXZ1Y1orbEFIUDBXb2NpQ1pjUGZiU3lMWFJxV1gvY0dIK0xY?=
 =?utf-8?B?NzJsNnhNOHF0NXhib3ZQUTBuTGV3ZzQ4dDhIS1ZnUjNkOUFqNkxmcnlKRkgx?=
 =?utf-8?B?VzNIZWdhZnJTRWZjUE1xbXc4Nld4RTVGMmR2QXdlQm5lN1Jnem00dVdTRURY?=
 =?utf-8?B?dlRHL3lzTFZQQjVpdStJN2dOU0xXbks5SVlLOGlDS2FwQkdXWndxNExtN3Qw?=
 =?utf-8?B?Rm9GK2RLU0JFaU11aDdoTW9jelB6K1A3YkE1dEowYmU3WW83ZnQ1bU5ybnlv?=
 =?utf-8?B?cDUxSDFYdTFxQkVPYVpnQ1NQT2VLRXVFODNyVGU0bmt0NnpxOFZtbUE0ak0w?=
 =?utf-8?B?RVhoL1NUQmZsTE9qNlNVZk1BbmVKN0VpM2psTHBiSFlwQ2Z4SUdBZmNGMVNG?=
 =?utf-8?B?VzVNWDIxR29JU1VkYkRQcG56anJZMm82OVFrdTVWaFhkN0Y4ZzVsWFN4Ykw5?=
 =?utf-8?B?UmgrQ2t4V3hpSjQ1MVhQcWhQMTd5Ni9QbURTVDhzNk1uKzhVcm9tclorbGIx?=
 =?utf-8?B?RXlkMFpTRktOOG1xS090VVJoNzJ5aHpINlJXd09xVE80dkxMMm91S09TVitk?=
 =?utf-8?B?UXZKcEZiYWpta0hMZ0xmZ2FqbjV4L3Y5aDJkaXdVVFYzTzBEdkR0cUNBVE52?=
 =?utf-8?B?WDM4aDRBRGhMdDVtNXBCNG1zaHlrSVNTQTRvUndNMVhpUmQyRzYzSTFzdUxu?=
 =?utf-8?B?bHBUeldIQ1hNWnFBa2NiNXU3ZmdrUldBeUhhOW13YVp6WTh3ZHJIYWhXUitv?=
 =?utf-8?B?Mms5dnFQVVhpelMrQ3JrcUNpeGJZelNYc2I5Y2liWTVxbDEyamlNMFoxajFz?=
 =?utf-8?B?VzhJdmlucE5YWit0TGZIVEROdVl1Q0FSNlVQUXlDMTdCWko5R0tteENlVlh4?=
 =?utf-8?B?RE9KOVFmZDUyUi9oOTg4L0tsNDFDaDhFSERkSjF1RDBFRzM1R1l6ditSVjV0?=
 =?utf-8?B?bGN6ZnU1Wk01UjFUYUREeGtRVHZYMGtKZzlXVlo4OWtaY3dZZzBJM3RPL0VU?=
 =?utf-8?B?MVAwRUdSSTJXWFRaeUozVkNrZUFxL1JxZXFFcDF6ZDlndU84alN2R04yTGYr?=
 =?utf-8?B?NW5jNVhHVnducGZhWC8zOUlzSkFJd1RHZU1EOCtLRmZuMXQzc0Yybkd0S0Zj?=
 =?utf-8?Q?Iz9fuRD80NxZGiH59rZpXgXFW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d47a1c4-1329-4418-3729-08de3cbd1a27
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 16:06:42.5070 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bcdFmlOPzjdcN+d9YM6MuLdW+GAmbCGc194wuvABnCL6bDWjzCtMXzuN1Iaz4rOe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5933
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

On 12/16/25 11:08, Donet Tom wrote:
>> The GPU page tables are 4k in size no matter what the CPU page size is and there is some special handling so that we can allocate them even under memory pressure. Background is that you sometimes need to split up higher order pages (1G, 2M) into lower order pages (2M, 4k) to be able to swap things to system memory for example and for that you need some an extra layer of page tables.
>>
>> The problem is now that those 4k pages are rounded up to your CPU page size, resulting in both wasting quite some memory as well as messing up the special handling to not run into OOM situations when swapping things to system memory....
>>
>> What we could potentially do is to switch to 64k pages on the GPU as well (the HW is flexible enough to be re-configurable), but that is tons of changes and probably not easily testable.
> 
> 
> If possible, could you share the steps to change the hardware page size? I can try testing it on our system.

Just typing that down from the front of my head, so don't nail me for 100% correctness.

Modern HW, e.g. gfx9/Vega and newer including all MI* products, has a maximum of 48bits of address space.

Those 48bits are divided on multiple page directories (PD) and a leave page table (PT).

IIRC vm_block_size module parameter controls the size of the PDs. If you set that to 13 instead of the default 9 you should already get 64k PDs instead of 4k PDs. But take that with a grain of salt I think we haven't tested that parameter in the last 10 years or so.

Then each page directory entry on level 0 (PDE0) has a field called block fragment size (see AMDGPU_PDE_BFS for MI products). This controls to how much memory each page table entry (PTE) finally points to.

So putting it all together you should be able to have a configuration with two levels PDs, each covering 13 bits of address space and 64k in size, plus a PT covering 18bits of address space and 2M in size where each PTE points to a 64k block.

Here are the relevant bits from function amdgpu_vm_adjust_size():
...
        tmp = roundup_pow_of_two(adev->vm_manager.max_pfn);
        if (amdgpu_vm_block_size != -1)
                tmp >>= amdgpu_vm_block_size - 9;
        tmp = DIV_ROUND_UP(fls64(tmp) - 1, 9) - 1;
        adev->vm_manager.num_level = min_t(unsigned int, max_level, tmp);
        switch (adev->vm_manager.num_level) {
        case 3:
                adev->vm_manager.root_level = AMDGPU_VM_PDB2;
                break;
        case 2:
                adev->vm_manager.root_level = AMDGPU_VM_PDB1;
                break;
        case 1:
                adev->vm_manager.root_level = AMDGPU_VM_PDB0;
                break;
        default:
                dev_err(adev->dev, "VMPT only supports 2~4+1 levels\n");
        }
        /* block size depends on vm size and hw setup*/
        if (amdgpu_vm_block_size != -1)
                adev->vm_manager.block_size =
                        min((unsigned)amdgpu_vm_block_size, max_bits
                            - AMDGPU_GPU_PAGE_SHIFT
                            - 9 * adev->vm_manager.num_level);
        else if (adev->vm_manager.num_level > 1)
                adev->vm_manager.block_size = 9;
        else
                adev->vm_manager.block_size = amdgpu_vm_get_block_size(tmp);

        if (amdgpu_vm_fragment_size == -1)
                adev->vm_manager.fragment_size = fragment_size_default;
        else
                adev->vm_manager.fragment_size = amdgpu_vm_fragment_size;
...

But again, that is probably tons of work since the AMDGPU_PAGE_SIZE macro needs to change as well and I'm not sure if the FW doesn't internally assume that we have 4k pages somewhere.

Regards,
Christian.
