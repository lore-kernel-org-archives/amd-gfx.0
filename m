Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52AE3CCD199
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 04:08:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB51310EAEF;
	Fri, 17 Oct 2025 04:08:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cr90KSDN";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012054.outbound.protection.outlook.com [52.101.53.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83A0E10EAEF
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 04:08:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kwLc2W88tYCFOg6OSvTeiZtuPWpg/uZqCdnLWcAqoH71JM49KglZpRsP2BwfN7LC5sJ6uMAq2pmh7boPCK3IqOM0VXyHTJc21LnEVtLXHo1hRGFlMsFtWsaR4F5vrm7yjfcT0bpH+460VsSG+pIg6HdTdX0MvSAL1M6HhLOOZ7A3z5qX2prCttO1n8WdGvCwAA+j1/pVO7EeBHwElUdmDXHIUBIeKXrSu+RJixN28NoaYGPv7Nh77Nth2AOtucUuC2cWWlQpNuMmqdonTqa9IY6xbx6sUI4qwGbrLVBgF1COjMPS7YuZVrHO7jekCVKjPQ8HWz6YbPH9YplWZXp3tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=954IUGUXDDils7W207B+JroQNI7j3QPosVtESCcoAHg=;
 b=xwHAuMchk8D0vHfXZbGVH95iu8aAgpv7jRrDfKQWfIN32LU0HQYBT1HmfjqETBChuMPggeB7qki3Fz+qacVB9Wzi5FTtE4A7geWXGg6S0sRJ6nfZfSfx31+wKAaXz1ohu1s6HKBR8veGobXqCJmRfEXq1HYoTcQ8DIAcJC7g3+OxycXJmQhcWAdZi0OqUtot6Z8gRahe5YEAOnJtcLTDfwxvSz0G+BhReBMx5DrUUO+gvxthgAOMTqW85vQvvraBr+vIPSTKHCVk82JY3milHsQQN7HNdNo8Y6I+yxZplErz+exo/foTEHnJMQqUbbwFykYMQKQDeBdueKVfELZyUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=954IUGUXDDils7W207B+JroQNI7j3QPosVtESCcoAHg=;
 b=cr90KSDNFT9VhS6qV+5erepe3Eq17sKTi8GidQuW75pFvQVhXrqSFbve2BxiDgzjtaLpG95iehMo+eW09UCCC/KgCLawHbuALr2e9HRNR0q+30lIDywRSVMaItsxiOvAXofwZ/bQzNDVvawihIXEEvIBJh9iMqDjjStGwAsj750=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS7PR12MB8292.namprd12.prod.outlook.com (2603:10b6:8:e2::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.11; Fri, 17 Oct 2025 04:08:28 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 04:08:28 +0000
Message-ID: <47832bb6-a836-498c-bd2c-fb7b22537f4f@amd.com>
Date: Fri, 17 Oct 2025 09:38:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] drm/amd: Check that VPE has reached DPM0 in idle
 handler
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Peyton.Lee@amd.com, Sultan Alsawaf <sultan@kerneltoast.com>
References: <20251016185527.1796606-1-mario.limonciello@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251016185527.1796606-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0105.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:276::8) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS7PR12MB8292:EE_
X-MS-Office365-Filtering-Correlation-Id: dc8257b2-3d32-4fa7-bc3a-08de0d32d313
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ckg2OEpNN0FzaEN3UVd6amlHQy95c05WVktRbGErbVlyYWtDaVdraDQrNFAr?=
 =?utf-8?B?SWVsUVNmWnZOcVd4UUk4MXNMRk9hblZQK3NON1lpVUxaZHA0M0duWThyM1VM?=
 =?utf-8?B?ZDVMNXNKOE5zTzhIYnFvYVVrVGFFdU5JTWR5L1NZeVJzRURvRWFsblFBcEtj?=
 =?utf-8?B?NlhXcHdDMDYxWUdYaGFxL0hvMURVZFp5a2dCNk5sVG9IcnozQUorVWVKMmpH?=
 =?utf-8?B?YU8wWkczRjVTNG5mVnkwVi9GL1lWVVYvV2U2bXVUcUFJbGU4WXJpOWYxdUh2?=
 =?utf-8?B?REtZUjlxWVRkRDQ2azczRnp4YkRqZ1U3ZjlSdDJKd3J1MFNWRVF6dXFLYm55?=
 =?utf-8?B?TmU1VFk3VVRZcDgxQW04YkQyNFZYWEJCd2ViczJENkhFUmpsTHVnVlFpbmVx?=
 =?utf-8?B?dzVwMmpzOXdPanZ3VnB0YTB2bkErVjQwOFZqQ3Q5MTFKK3hBQXBmL0VFK2pp?=
 =?utf-8?B?MjR5MnE3WVlJVXU1ZGhqckVPeUh6WGs4Nk8vMm9raEZMZnhNeEhMakQ1T1p2?=
 =?utf-8?B?SzBMYkF1NURSVXQ0azVGRkRBL2h1bittcDk4TDlZU21Sb3ZWVjNVc0xkdjlW?=
 =?utf-8?B?TlFSK1pBR3gzVWo0Y051WkxrRzVSU1JpMFhvRXRLZHZGUklyajVPMzByZDQ2?=
 =?utf-8?B?ZTNCZll6WFhsZWNaYitFQWl1RFRhVGFRbUJqVjNtSnQ5aWlUNlRhcWl6ekFM?=
 =?utf-8?B?T0xpdUVkZVdZMXA2L3VpVXM0VjEvZmhlU0NUQjQ2d01RN3crb1pjNHR6dHFr?=
 =?utf-8?B?Q1VYUGR5ajVzVHpiTVN6TVVzamhlMC9yZGJ4VTRKNW5XbFREN05GbUJIQXFC?=
 =?utf-8?B?ZkFvS2xjL0YvcFN5ZTZWUWllY0JpTlhhUUYrcVZJczBLVnZDcmlqN0xyU21T?=
 =?utf-8?B?OGJPYnVHRWVTU0tzMGVqQTJmK3FIVG4xM3hKQktCUlR2VGw2eS9wWHB1b1lx?=
 =?utf-8?B?NGs1UFJkckIyRHFFWG5ac1lmRHhzZHBWY0Z3SXZoMWsvRjBhcTFYRU1YQTVy?=
 =?utf-8?B?eUVtZ2FLMnphelZlclIxOWxITXBsYkNyOWdjY0l1ZHEydlhmQmxOR0trTk5v?=
 =?utf-8?B?M2pyb3RKMVplaVN6NHBRSlZkSTlDbStRaVRsMGplMUErcDAzQ2prVmxoNWd1?=
 =?utf-8?B?RWdJL2dscVRRbGpuK3RnNCsvNysyQWkxbkhIUko1NjYwb1R6K2tzbUlRbi9Z?=
 =?utf-8?B?UTlMTko2bVpnM3RTbFRobml0cXkzVkRlVXZudTVWY0ZLNktFRTR5ZEtnTVNi?=
 =?utf-8?B?d1FFWmU2WUNtTmFXOFpOTGMyTWxTSGJWU0N6bVROQmtnTFpXbE5jc2VuQnJn?=
 =?utf-8?B?dytFYWthdVRIa0ZaM25HdXZYR1BTY1FtRlROMmRhRWpqZDhrdVR0YTdvWW1J?=
 =?utf-8?B?UUJCV252NlJ6WFpVTXlwOE5yNHE1ZGQwbTl6RjJpOEtZL3NJdmVNTERYUGJF?=
 =?utf-8?B?T0E2cEQ0QWZYQ2tOMlI5VldBM3F6YXlFR1NPZVFqb3FUUTRrNXpvNUgvK21P?=
 =?utf-8?B?QTh6Vm12SkVHNzN0SzBTSU0wdkJtcUJoWmVFQUt0R2lHbk16YndLb3JNU3Zu?=
 =?utf-8?B?WjlaV2QzWndKazFRTzQ4Z3pKU0l6aGdsQXpHNkduNXROMHdjNVhnekJyMmF2?=
 =?utf-8?B?SzVHa21STENUcWNwUnRQaFlUcVJTY1pzTkRVblRWRlplWTRUa2JsUnlSaUNo?=
 =?utf-8?B?aFZrQ21OYVlSWjZIL3pTbk9STzlRWkpDVEhXZVQ2TXp2NHZXek80QVg0aGRX?=
 =?utf-8?B?VVE5V1dzMUVwYXFoeHArTDQ1QmxVVDkxYWlhc3BNUlJJcmFuK1FoS0hTb215?=
 =?utf-8?B?L25RL2IyZjNGQjFlb0twTG1Ba1JMMDVUN1Qvb0x3UkoxYXZKYVBSSFFVck96?=
 =?utf-8?B?bkc0MnNxR2hwQ2sxOVJrRFd4S1JBMW1UeHN3ZjZqczZTcVE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHlwK09rNTlxc2J6SEZyVmNhVm81Kys3bkd2bXJtcy9ucDgxL3ozR0VzM2hE?=
 =?utf-8?B?b0d0MFRRbmJ1em1GeDJiRkpjYy9DUEg3My9IMVdqSXB5b1RMb1lnaCt4UEpS?=
 =?utf-8?B?WTFhSU5QdXZHTDJPUHZOb0VzMzQ3bkdqMWdrSzNYZGRJTUFvN3M4M0NXbEVZ?=
 =?utf-8?B?ekc5aXdjZEtiMTFpKzIrdVdwQW93ZGhFcXdiemx3dlhjd3ZYNmkwM3l2RHov?=
 =?utf-8?B?UDFxRnlKc1FvaFZISnRJUmxVcDh1Skp1eXlFak91a0xSTkEzam1CUmxpZitu?=
 =?utf-8?B?SUlCZU93TDRxV1VGMjQvb0d2WThBRHdCSFJvcnhVUVAvTUQxd1dUNFQzZ1Mx?=
 =?utf-8?B?bWVnZElGbHY2c3lZZ0dDVW50SjZsRXRtZk1oU0dJWWNOWmVnT0ZqOGlWMWV3?=
 =?utf-8?B?aWt6TnRTdEh2TkwxVG9jYU9vUGU4K0NLeSsxK2pvb0wrUkRkM2RBU1hoWmxI?=
 =?utf-8?B?aUxpb1k4SlNldUlsZnUxVnM2djRNRStEdjhoclNPNVZLRTFsc25UNUZIV0l1?=
 =?utf-8?B?K1FUTDVEZTNjSXdSVzdsZnZjYTFWNVJxN0Q3ODBCaDRpNjZ6TmNmcWIrZXFH?=
 =?utf-8?B?bi8yK0ZyVnFOM2tUR3FZK2d5VE84RmFnODFwK3ZFaFViNjRLMm9FbGEwWXJq?=
 =?utf-8?B?Q3puYlNDSGFvWGJqdlBVWHExa2ZUY2lnWlo4Q1hMandiUURaL1RhNC9aTWps?=
 =?utf-8?B?dWI0ZVNMdHJsZU9kVm9QaUZuTHlVMTI1ajBHZEY5RmNqcU5GMHdnMENWNGVI?=
 =?utf-8?B?Q1dKWi94TGZpQ3puU3djZk9wZ3V1L2ZVdmEzZkJtS1l3a1pNY3J5L1FzRit6?=
 =?utf-8?B?eVRaRUcwNCs0cTNNYjdqVkJjUGJ5R3VOVVcySHFPeTRYYk9tR1NTMUVGUy9z?=
 =?utf-8?B?WFZvekt2MXpqeUpvVDNOM2JVQWhDWDlidE42NnU0RDhIRVYxYlRva09xcVFV?=
 =?utf-8?B?WGFRcGNCRTUzaDZNcnZIU3dOQTlQNDhhTHhwc0hQRXVuWW9NMWMydi9wVXNS?=
 =?utf-8?B?azNhRGRYdENZZXJjaHMxeWtFY1RNQi9WazAxazllSVVyZ2I0N1ljVC9ld0tH?=
 =?utf-8?B?bFVpRlQzdllGQ3JGbHhOY0NJTFFTUDE5OHdXODhWd1BsTnFaczdVckhkbFlT?=
 =?utf-8?B?K1dkRkQzRUFoeFVhSVBSaS9ibXJSQ3dNWTZCRFl0dVNVOStGajByWERFMkl6?=
 =?utf-8?B?aS96aHN3cEJ6MXZ2WEUwLzMvc3R1RzFqMDVWSVVFM0ljMGk5eS9Yd0dFL2tt?=
 =?utf-8?B?Umg0U2ZaSXJEV1BFQ3lQUDB2R2xMaEtIaVFNVFNReFFpQWxLTzRxVktVR3N4?=
 =?utf-8?B?SkpqZWlySGNkOU1SWTNYSFBpbGE3VW5BYzROdzA2aWV2d1lndEVmS21TWVhv?=
 =?utf-8?B?ZU5IdkJZMGIycHpOcjRNd3VhWkYyOHlmY05yRTRrekdEWFFFK25ocnhtWk54?=
 =?utf-8?B?VTJ4RXVCWm9CbDliVjhHeGM1Z0dlUmRMUzFVcS9rWm9TWTMwVVJRcGpQaEtu?=
 =?utf-8?B?d0NXSEd3NE1XOUhUNzhxcGM3VjVBaG8vblljQnB6Rk04RjFSVzVsN0kyalRZ?=
 =?utf-8?B?OGxkYmhFSzZoQmZvOVBNRUtDYUV5WlltcEJIbzkxdllZa1FKcXh0OEtORk9L?=
 =?utf-8?B?WERNM3RRQXA3ekhuVzRNV0krbk5Ia2tRNWZXVUhQbmY2QklDdjkwZG8za3ZV?=
 =?utf-8?B?QlloTnBwUGhyUjhJOFFISjBVMkU5QjBoNVcrNFJ6c0FJR3pHTGh4RGNpWnd6?=
 =?utf-8?B?b1RkU0p2czN4ZVdGZ09MU3dMaE9qZi9hcXFSZ1RwM0tja1FWRVJFeHBRT2VE?=
 =?utf-8?B?YXdKMXlWYlB1UU05YzJrTE9Sc1B3MWY1N3duNVNYYUg1alllRWNGSVZlekRS?=
 =?utf-8?B?a1B4M3ArNlNnc1BSYVhFZElqdkFSSnpIaFhPL1l0SzJVQWpObjR6NnF3QVh0?=
 =?utf-8?B?N290em9VSDJlaHoyc2RKbW5HYmc3N2E0M2ZwVHpKdFhoVFEzR3ZNeWs3T2hS?=
 =?utf-8?B?clBqOCtuNytVSXU0U0JaWVhhbnBxbUxWMTBMVlZJYlZLdGgraVlvZ1h1c2VL?=
 =?utf-8?B?U1g0dCtnWUxRdXVDcGVhaEJGdGxPd2QyMmFXUHJod3dCVjJoZjdlbGZxelhO?=
 =?utf-8?Q?YdJIjTioZGrBg5/8APWO4VaSX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc8257b2-3d32-4fa7-bc3a-08de0d32d313
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 04:08:27.8484 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gUtHC+znr6KY0nnytZeuuIequomc6RxBl57ceyouvt2QGzXAqvf1Fo2VAkU/iD/V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8292
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



On 10/17/2025 12:25 AM, Mario Limonciello wrote:
> [Why]
> Newer VPE microcode has functionality that will decrease DPM level
> only when a workload has run for 2 or more seconds.  If VPE is turned
> off before this DPM decrease and the PMFW doesn't reset it when
> power gating VPE, the SOC can get stuck with a higher DPM level.
> 
> This can happen from amdgpu's ring buffer test because it's a short
> quick workload for VPE and VPE is turned off after 1s.
> 
> [How]
> In idle handler besides checking fences are drained check PMFW version
> to determine if it will reset DPM when power gating VPE.  If PMFW will
> not do this, then check VPE DPM level. If it is not DPM0 reschedule
> delayed work again until it is.
> 
> Cc: Peyton.Lee@amd.com
> Reported-by: Sultan Alsawaf <sultan@kerneltoast.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4615
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 33 ++++++++++++++++++++++---
>   1 file changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> index 474bfe36c0c2..f4932339d79d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> @@ -322,6 +322,26 @@ static int vpe_early_init(struct amdgpu_ip_block *ip_block)
>   	return 0;
>   }
>   
> +static bool vpe_need_dpm0_at_power_down(struct amdgpu_device *adev)
> +{
> +	switch (amdgpu_ip_version(adev, VPE_HWIP, 0)) {
> +	case IP_VERSION(6, 1, 1):
> +		return adev->pm.fw_version < 0x0a640500;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static int vpe_get_dpm_level(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_vpe *vpe = &adev->vpe;
> +
> +	if (!adev->pm.dpm_enabled)
> +		return 0;
> +
> +	return RREG32(vpe_get_reg_offset(vpe, 0, vpe->regs.dpm_request_lv));
> +}
> +
>   static void vpe_idle_work_handler(struct work_struct *work)
>   {
>   	struct amdgpu_device *adev =
> @@ -329,11 +349,16 @@ static void vpe_idle_work_handler(struct work_struct *work)
>   	unsigned int fences = 0;
>   
>   	fences += amdgpu_fence_count_emitted(&adev->vpe.ring);
> +	if (fences)
> +		goto reschedule;
>   
> -	if (fences == 0)
> -		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_GATE);
> -	else
> -		schedule_delayed_work(&adev->vpe.idle_work, VPE_IDLE_TIMEOUT);
> +	if (vpe_need_dpm0_at_power_down(adev) && vpe_get_dpm_level(adev) != 0)
> +		goto reschedule;
> +
> +	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_GATE);
> +
> +reschedule:
> +	schedule_delayed_work(&adev->vpe.idle_work, VPE_IDLE_TIMEOUT);
>   }
>   
>   static int vpe_common_init(struct amdgpu_vpe *vpe)

