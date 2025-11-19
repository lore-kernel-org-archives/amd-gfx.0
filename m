Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55716CF648C
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 23:34:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4F2610E6A9;
	Wed, 19 Nov 2025 23:34:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ytpUQlTs";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012013.outbound.protection.outlook.com [52.101.48.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2FA810E6A9
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 23:34:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vi6ZY71vZmWPEcoRAG9eSc87XDm7pNymzcuQF8YxJThv4K4XcsxDjg7TQG6K3wABqs4xsfui1RcqPMHHA/5QVp0QmcaJRUc5ic2Axtufl2CxIlFq8mhRKE6hVF+GHAT5vsQkA9vzU5MExNm+yZ9Cx0ICvvxNFfozGqnwA6N3QELioG29Am8p8FRZ2jq00RgfTzTZy8md6WR5oq6gKgveOQEYf5MdOQVorMF/qdhYkBsGF428gogCGYEJyDDxCehDFhH27MuSZDphgsd2WS3Ch2QahKGZeQlFmkC2d37rQRSr3EN6PFgHbZV5ER50Sk7sNeRYo2Npgu6opV9J7IFlHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMFd8oWdKYctPo1ff+oLo13e6w0dVGtltBJxJ+vhpXw=;
 b=vhAKCJ4cwMq1/TzReVoE3loVP/k1i6qj1hf+fXMuy7glfFeIqhE0Ok2BqyD3Q9QmMVJrl7RkJa0fXOM5rR+KbAwoNjXTSZ8Df01H/lfr1JC9iPgUWuStLeokA4hZ5Aj/bWuW0OvZQf7+QjEprddCqrtCYx4OqA40ru8GM9t6DF8SkeFS03UH4Mc53cD2nE0tG9l/qz6ddADU5Eot4CI+24nv0TBg8AIyPPrdzqR5Va5X6z+LNNFHLRcsqz7TZnI8TwvheVVNE8RbQrklfhFBmr7zSki72RpCTiGR8lY51QkesIe93+JOLSc034nyOrmaFsqs2b1TsGFSZg3/p/vFww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMFd8oWdKYctPo1ff+oLo13e6w0dVGtltBJxJ+vhpXw=;
 b=ytpUQlTssLpEAW38CZXVVgM9NSsBy1NGBbdt4idh7imNghU8HIFnwv3PnZaTDvbYaOtgpHY+GZnd0UB9EciVtYYM0z+mBBobw+zAgn907UMhGyRWHpTI9OGpkGWZ/SlSrZEsYsoD5YyIVhq9GFpDFoLPoclwts2BsLplakUYzSk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CH3PR12MB9100.namprd12.prod.outlook.com (2603:10b6:610:1a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 23:34:01 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%5]) with mapi id 15.20.9320.013; Wed, 19 Nov 2025
 23:34:01 +0000
Message-ID: <8382d7f5-4743-416d-87d8-8b892dff4976@amd.com>
Date: Wed, 19 Nov 2025 18:33:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdkfd: Use huge page size to check split svm
 range alignment
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251118173228.1873433-1-xiaogang.chen@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20251118173228.1873433-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0121.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::21) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CH3PR12MB9100:EE_
X-MS-Office365-Filtering-Correlation-Id: ad23301d-7fad-4d3c-f842-08de27c41e78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WjBCcEdaZXdhTDZUWG81OS8yT1BnOWNwd21xWFE2bWxxV2k2RTlhZFVmMVRN?=
 =?utf-8?B?OElLVzFDNnNRa3pBZmtNSHZRbVMxWC9ZZnJoVXJGTHlPenZTejZTaUZ6TDRN?=
 =?utf-8?B?RFFab0ZsZTVWKytYM1RlY1FtS0JoVm5ibHJmUitmZFJMR3UxWXE1d0htT205?=
 =?utf-8?B?ME5PT1lQWmVVTXlUWmJKUDNmb1FtaEZ6cXp2K212M3FwYUw0RUhtd0wzejEz?=
 =?utf-8?B?NDFmMjg2SWgzUnNlcXBGWGo5WHlvVkRMQW5xM2hTeTNlcHpCTmpoMlF1SERP?=
 =?utf-8?B?YkNiNk45STVRUlFQaWRMWWpNcUVMQmo3NUpoczkrWTJNU2R5b3dMVDE1U0s3?=
 =?utf-8?B?V3paRWdrbWE4RTc1eVBWT0tpWGo3bGlQc0J4SkVjV05hVzZxRGZoMXIvWEJ3?=
 =?utf-8?B?RjJRK1ErSmFUUEZhUkIwcFNoeFFjbnRuNEgyT29EQ1hXbXJQYzJxOWlQNWd2?=
 =?utf-8?B?dmpmT1hDMU4ybmdNb014YjVHYW8zR0tleVJTeDhMbWE2a3BCbmhIYTMrUVph?=
 =?utf-8?B?Q0JteUEvbHVQZGZCdmZsZmRBNmtRdXBmSTFPa0ZDbUdqdTdRTWRsdmFqS2xa?=
 =?utf-8?B?QzBScVJXV0pXa2ZlaVE0dklIMnpFdGhsOGkvaU55c3c5b1cyR1BTZS8xemZr?=
 =?utf-8?B?UjhZZGtzZWREYnhuS0oveWhzOGYyRVRpMGVKQUp1YkJnWVNyRzd5TXhvSU9J?=
 =?utf-8?B?T1NuSmdZaFVWbGx3RnViaUxFa0cySHdBNmhyT3ZpeVUrOWtQa2pLTTltNTZs?=
 =?utf-8?B?ZkNqczZNMVNBdkFYZWRzdUw0RGFIbHNpVjlXdnZtTmRqQ01RSkNnbGdYSWgy?=
 =?utf-8?B?YUJwL0JNTTFhL1huUjhGTENrNkxvcndURHlPVXVUVk5zWk1hRzZoNFBPMmNv?=
 =?utf-8?B?R2dCT0NqV3JpTVNkN25JZWV5UWlaYXN3MjE5aFprZGkwT212aHczQXhuYVpr?=
 =?utf-8?B?bEE4YmExWWx5NGthbWNnN0w3QUVQQmpCczhKTUR6NWJmRnNsRWNaRTlNYndJ?=
 =?utf-8?B?Mml3OGR2K3JNN0l1NDM2OVllTDlHZXZzdFdQNDljZlFrYlFFN2RaYmxhQ2J5?=
 =?utf-8?B?d2Rhc0pQazNWekowbFpnWEo5VTE0SVRWd3pXN0h0YkJleEVPOTZhcFpySXc2?=
 =?utf-8?B?TUtHelNIc3o3SW41UmlFUUpOb1UwTWNjbXovWERueFVQbTBDdysvRkhWb2x1?=
 =?utf-8?B?MzlaVjRGM1dKU0NwM1d0blNPYTJRUVA1UnVaS0tPbXFwSWxUQVRTMGp3VVdh?=
 =?utf-8?B?bFcrdkY2OGdRUzVzYmhjYjFzL2NBT2k5VlNoQWxuaitWQ09idC9xTFNCS09E?=
 =?utf-8?B?MDh6K1dJRGtMYVh0dzdHb2JrTUhxb1Bka3dua01xZEZYUXZ3SFVVWVVmMEdD?=
 =?utf-8?B?b0pTN2QvV1J5c28rWHNLZnJaNUQ1bHprWllldlA3cVJEOGRHa3cvRUtnbjBP?=
 =?utf-8?B?MXY4TDYwN3lVdURYNEZOV0lIdzVkTGg0bTBiQXhCYTVUeE5nTUtyQkw0Q25p?=
 =?utf-8?B?NlM0cWJiODFydWJUNDdnNU1HQ0FlZUc5bm0vVXhWQmc3Z1NEMldROWovdVNK?=
 =?utf-8?B?bGd1QkNvREJmeVp4RWJKSGVOMUdoN0lSZnl1T2cyTWEwbkEveEc4RmdQeWlj?=
 =?utf-8?B?bGgxTzZPQnJBT0lGU1RNb1kvZHNxTmJrNHZYcFk0WkxlaVdDSFlOV01panZQ?=
 =?utf-8?B?UnNRLzFQK3hkSStJckhsMFREMjFIbm4zMmp1MEVabDlGbnBIeHpmUUlpK2Nl?=
 =?utf-8?B?SFFodDRuMnpQM0lTRElLbExnUHVrNVVHMlE4SnpDc2xCNloxUGRBWjhSMTFv?=
 =?utf-8?B?ZjM3aTRheFpRTEcyN242UWMvVWh2eVB3WFNsVUtranRWQ0R0SStNUldhR2RE?=
 =?utf-8?B?WmtzeDVMQmFBNVVGMmRDc1VWSFowWHVjR1A4KzVTcTJNMkgrRVIrUC93MEIw?=
 =?utf-8?Q?QL01t1MT3a4qC/TdG+p09LIREdtEf0//?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajBVQ0IzbU1SZDhWV001RFlkZWF1RHpVZGFuOUZZWC9MTW1jMzRGc3l5UnF4?=
 =?utf-8?B?VlRndlJlTnR3OVdtL0RyK0JiV0ZZNW84M2lxZEF4N0FaNHdlMmxJazcrZGV3?=
 =?utf-8?B?Yzd5eFVtVjBHd0VBY2RpQThHWGJmcSt6cU15ZVFxcDRjVHU1S0RsUm1LbGZS?=
 =?utf-8?B?TTFUVHJqbUw4NTEvWkFqZDlDQklIakZpVURBRks0WXhwWHFOcUVFZ0VCUExG?=
 =?utf-8?B?Q1dhVFA0TDJWSjB3VEFqSng5L1NXVytnUGZWQU9kNG5pM3phc3VxRk1hdmI1?=
 =?utf-8?B?R0REbHkxMjlIRno5ck0wbExMWU03K3BuZUlyVU93RHZ5RnUwVEdPZGRRTDJC?=
 =?utf-8?B?cVlOZ2krc29WaEpIejlUd28vcGd5Vm95c0E2Mm5CWmk3RzVEc3FpOVRpblg4?=
 =?utf-8?B?MVdjWWIrdm1PcmVuMzNTdTQzeE96TUpad1lSTkpWbHNORUJJekRNbHpvaXhP?=
 =?utf-8?B?Z0FKTXE3OXlNd2MvQlFSMHN5bWNxS2pNd1IvUDF6aVNYVE5PbEtnWFRiOUZD?=
 =?utf-8?B?dHF3Q0hhenAvKzd3M3lYYktiQndsOUdObWlDYlBWOGZkTGVON2VpVHhTdi9M?=
 =?utf-8?B?TU9FanJzWVA0QlhXTGR0OXhkUXNlbXhhRlRuL3ZkZUdORElPMmRSUFZGR2dC?=
 =?utf-8?B?VTc2Y3JreSs3YWtYdUJJUzBTRVowemczQ2svY1Q2ejhydi9zZC9UR3FFZm9M?=
 =?utf-8?B?c0ZmdEljZW53cVpQYktiWW96TnV2Nm9xczUwZHJseXpjeHI3ZEZoUXlqMks4?=
 =?utf-8?B?NjlYR0txbTNybWpuNUNzL1h0dkFuYWNBMk1JeUNPNFVEUHNIcDY5dXFiL01X?=
 =?utf-8?B?US9RU0lUOFoycWVXWExCWVlpTXYzYTBRM0x4SXVNekpsWFNPSEdHNE9hblNX?=
 =?utf-8?B?ellVcXNpTVBYSXZ6emhSMCtrOXYwU1VlUkh5L1NMcVRmbG1HbWNtMDVnbWdZ?=
 =?utf-8?B?VWdGeURxR2xxbFU5QlBlZnZNbGRyUG5QcUlJaVFMY3NybkRvOSswSDV6UkpQ?=
 =?utf-8?B?bXZVdUpOV2dKazN4MjV0Sy9vVDJRR3B6bGlLQk9zWEp1eEpHWUMwalhWYzlv?=
 =?utf-8?B?cytoZk9iK0JiZnFkMlh4aTM2bmtSbmg0NGZSSmxmSnhjL3piL2dBWm1mTEpt?=
 =?utf-8?B?VC9tSmNRcTdneUJaSXJQMVFSOG82YjFQVDVPdi92Ni9vSFJXS3UxdFdMcjc4?=
 =?utf-8?B?M1hTVHZySk9zdXJma3RMZmpPY1RXbzB5MDBOdWVaaHcvblQ3Q0h6YjJTZDdi?=
 =?utf-8?B?RUpOc2l4aFJ5a2k1R2tHKys1VVFNUXNCY0h4U1JpdTBzRXNDQkc0TVhaQXh0?=
 =?utf-8?B?ZkJpbjdxOXAwQjhaRktoUEt1a1BXWmVaWGlyMGhkcUNreDBkOXBpNkxSSGNW?=
 =?utf-8?B?T3FvQkd3eXNlVVUyTnFoN3hIK2llM2J5RFZXZys4ZFdYMndySnJHWW5KVmJh?=
 =?utf-8?B?bDRCQ29FYngxL3pWNHpTQi9PMVZaMzMyNlZyTmFZcmlzZFlPb013Rzl5VWVV?=
 =?utf-8?B?N0d0K2FMTXE1SXZHUFdIZW0wTU9OdG4zdERxbitHTE1oRFV2NFd3ZzNpcDVl?=
 =?utf-8?B?N2dhdHFJT0RDazZ0R2YveTlBdnh2QXZkUFZZRExBcDdLRHZKN3pJNlo4TDJF?=
 =?utf-8?B?TTduTk8rYTJ0ZzM2NlJxcmtEYlptOG90T2YwWTBkMlhWeE9MT1RtV1dHSW5P?=
 =?utf-8?B?eFk5UEhPSVFPRDZCQ0dDRUhPZnFxTS9jVlFjV1JCU2VzaVJzQVRDakQzSDhy?=
 =?utf-8?B?S1dDNGgycG9wWDc4NFNhaDVDeEVRSjVZSVBoeTRJK2dqbWlCcFlKbTBhekVD?=
 =?utf-8?B?d1NsZDhnNW1CcG5nY1p6Zm5GdVlsTmxVNCtkZi9EbUFYVVZJWXNWaGJJWnFU?=
 =?utf-8?B?MWZhNVcvQ0F4L0d3L2QwR3ova1pUM2g3ZDJjTEJkMURXK2wvYTFPaUNqK1Vl?=
 =?utf-8?B?VzJNNXZkbnJGaGxmbDc5aE9LV3hFS05wVS9rQVZzSE4rSWVZcHBmNE8wc3I5?=
 =?utf-8?B?UUo3TTM1bkR6Z1JvSGUwRkFDYkRrK0Y5eXFCbjJuVGZ0ZUNFZjFmVVFQRkJQ?=
 =?utf-8?B?QmRpMDFrN3AxUlduSXczRU01RnVxN2lWV1NNeFIzWU1lelN1dkwwM0hiU1FP?=
 =?utf-8?Q?BHhvn2hw7i3yqgBz0e8oHjiWN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad23301d-7fad-4d3c-f842-08de27c41e78
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 23:34:01.3391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H5xIT2yXLyqgI2YVbslgDMvYTI0uDVBl+azpRndf9igDe5UwaGnGsLh2fUeGKZzt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9100
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


On 2025-11-18 12:32, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> Fixes: 7ef6b2d4b7e5 (drm/amdkfd: remap unaligned svm ranges that have split)
>
> When split svm ranges that have been mapped using huge page should use huge
> page size(2MB) to check split range alignment, not prange->granularity that
> means migration granularity.
>
> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>:
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 63 ++++++++++++++++++++++++++--
>   1 file changed, 59 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 521c14c7a789..7bb94555e5f9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1145,12 +1145,39 @@ svm_range_split_tail(struct svm_range *prange, uint64_t new_last,
>   		     struct list_head *insert_list, struct list_head *remap_list)
>   {
>   	struct svm_range *tail = NULL;
> +	unsigned long start_align = ALIGN(prange->start, 512);
> +	unsigned long last_align_down = ALIGN_DOWN(prange->last, 512);
>   	int r = svm_range_split(prange, prange->start, new_last, &tail);
move this function call after variable definition, easier to read.
> +	bool huge_page_mapping = (last_align_down > start_align) &&
> +				 (last_align_down - start_align) >= 512;
 >= 512 is redundant because start, last already aligned to 512
>   
>   	if (!r) {
>   		list_add(&tail->list, insert_list);
> -		if (!IS_ALIGNED(new_last + 1, 1UL << prange->granularity))
> -			list_add(&tail->update_list, remap_list);
> +		/* original prange has huge page mapping */
> +		if (huge_page_mapping) {
> +
> +			/* tail->start is inside huge page mapping but not 2MB aligned
> +			 * or tail size is smaller than 512 pages
> +			 */
> +			if (tail->start >= start_align && tail->start <= last_align_down &&
> +				(!IS_ALIGNED(tail->start, 512) ||
split from the tail, new range is the last part of prange, don't need 
check size
> +				(tail->last - tail->start) < 512)) {
> +
> +				list_add(&tail->update_list, remap_list);
> +				return 0;
> +			}
> +
> +			/* tail->last is inside huge page mapping but not 2MB aligned
> +			 * or tail size is smaller than 512 pages
> +			 */
tail->last is the original prange->last, impossible inside prange.
> +			if (tail->last >= start_align && tail->last <= last_align_down &&
> +				(!IS_ALIGNED(tail->last, 512) ||
> +				(tail->last - tail->start) < 512)) {
> +
> +				list_add(&tail->update_list, remap_list);
> +				return 0;
> +			}
> +		}
>   	}

to refactor the conditions

	unsigned long start_align = ALIGN(prange->start, 512);
	unsigned long last_align_down = ALIGN_DOWN(prange->last, 512);
	bool huge_page_mapping = last_align_down > start_align;

  	int r = svm_range_split(prange, prange->start, new_last, &tail);
if (r || !huge_page_mapping) return r; 	if (tail->start > start_align && tail->start < last_align_down &&
	    (!IS_ALIGNED(tail->start, 512))
		list_add(&tail->update_list, remap_list);


  	return 0;
  }

do the similar change for below split head.

Regards,
Philip

@@ -1160,13 +1187,41 @@ svm_range_split_head(struct svm_range *prange, uint64_t new_start,
  		     struct list_head *insert_list, struct list_head *remap_list)
  {
  	struct svm_range *head = NULL;
+	unsigned long start_align = ALIGN(prange->start, 512);
+	unsigned long last_align_down = ALIGN_DOWN(prange->last, 512);
  	int r = svm_range_split(prange, new_start, prange->last, &head);
+	bool huge_page_mapping = (last_align_down >= start_align) &&
+				 (last_align_down - start_align) >= 512;
  
  	if (!r) {
  		list_add(&head->list, insert_list);
-		if (!IS_ALIGNED(new_start, 1UL << prange->granularity))
-			list_add(&head->update_list, remap_list);
+
+		/* original prange has huge page mapping */
+		if (huge_page_mapping) {
+			/* head->start is inside huge page mapping but not 2MB aligned
+			 * or head size is smaller than 512 pages
+			 */
+			if (head->start >= start_align && head->start <= last_align_down &&
+				(!IS_ALIGNED(head->start, 512) ||
+				(head->last - head->start) < 512)) {
+
+				list_add(&head->update_list, remap_list);
+				return 0;
+			}
+
+			/* head->last is inside huge page mapping but not 2MB aligned
+			 * or head size is smaller than 512 pages
+			 */
+			if (head->last >= start_align && head->last <= last_align_down &&
+				(!IS_ALIGNED(head->last, 512) ||
+				(head->last - head->start) < 512)) {
+
+				list_add(&head->update_list, remap_list);
+				return 0;
+			}
+		}
  	}
+
  	return r;
  }
  

