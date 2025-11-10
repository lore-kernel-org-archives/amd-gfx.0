Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0238FCCF9E3
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Nov 2025 16:37:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 998C410E2CD;
	Mon, 10 Nov 2025 16:37:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nyJ0ErmE";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010007.outbound.protection.outlook.com [52.101.85.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA0F410E2CD
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Nov 2025 16:37:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oAnmJ7n5xuTU741tZvkbKDDj8NjWiJj9/1PSa3EoWyt+Qe9EmYgcW7kSfGxjGY1B+USEoEbkY9ke3V8kp58S087p89wS1rAeq/oTFyTkktsPZsRDi+m1z1cVPzqb3JDa/fD+iBMf2fZ90zqcEUnxhm3l4fy1y/L7NjXnuO/B72Xi35sSv9vMo2eYDsJrwxZWvKgRM5xnOYws797u0DIVG0AF1JMo/GjoxwxnJizAEuPe4sev2gV3CHhAdXJiZAU5vD09Pdimuz94g81FGrM8tH025QNh7T+VaS9CcHvjHw59RRvdOLAjNS4XjZXz4Q75VXsJClphJhqw5VyFynfhIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAwWC0XqZwYwttEFnKcaBVsqkH1N33srQvRj5qDklvk=;
 b=wwqqm1fnC8UXufq0t7n+CxWJ9NB1P9z1ZYov0lcztLevvV8q4c1Jl8tAhf91voB48HfPW+2kQxMYEaol9U1TSCFgg1aqfXXOJNZkgq5R9dQjlCS7c4Jh7F7mshhaAozFbigPYAS4bEICYUMLGR2iDZJmUASSNz4G0KkoyQpAU6lMGcz/4pPvg+UEhyaXnneGBpqpxp8BSw6Y90yGy3ZgIUHYKU/eBMHOPbQUzhoDp3x5ewJXN0tDC0MfoGncbHT7/bwl1Wrq+T0mY7I9XdD8rLIyPf1cQOdYUNvdFTfMMXq8x/W2KXpTcm+nfKWnQQKJMKoDmfkpzWxMxCV5xqlqDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAwWC0XqZwYwttEFnKcaBVsqkH1N33srQvRj5qDklvk=;
 b=nyJ0ErmEM5MfAE9ks08cs5Ehb7TE1iqyJBgOIAHLFVl5GQWF9o55iO3DnSxCpaBrNa0TXEZDurRTs3pUPxjxdGSbSZAG4hJGxJ07a6mgVe+1nbpuB6EY/tX04nz6k7ppXmAk1VskN4/oHpaKlFbixLaWqnASlFAS2gQL9CWUU6o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 DS0PR12MB7746.namprd12.prod.outlook.com (2603:10b6:8:135::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.16; Mon, 10 Nov 2025 16:37:36 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 16:37:36 +0000
Message-ID: <18f995c4-ff1a-49ac-ab60-9619db8dd252@amd.com>
Date: Mon, 10 Nov 2025 10:37:34 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdkfd: Fix GPU mappings for APU after prefetch
To: amd-gfx@lists.freedesktop.org
References: <20251105225128.3182714-1-Harish.Kasiviswanathan@amd.com>
 <f0e69b99-ff5f-4208-9056-7e22d9e0a687@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <f0e69b99-ff5f-4208-9056-7e22d9e0a687@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR06CA0010.namprd06.prod.outlook.com
 (2603:10b6:8:2a::17) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|DS0PR12MB7746:EE_
X-MS-Office365-Filtering-Correlation-Id: 4daf5aee-c866-48d5-b2f0-08de2077747c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?citLSnJmVkVLMHphK3dIOWhLWjlteUhjSjZyNHBRcGh1MUozclVNSXRFVExx?=
 =?utf-8?B?ZllESFF6Mk5mSkpYWHUzZEpGcnZBSlhvVVdJY3UyaDRPZ3k5VWxYNllnNGQr?=
 =?utf-8?B?Q3VrZDNzeU1BV0ZvQlJXaS9tamxVc01yTmZDb2haaTM3V0szTGYzQkpjK2x1?=
 =?utf-8?B?RnZvdkJENm9UbUNNRnprNGZCblpjQkE2aUlETkYyRm1uc25vYmlzMWppVlBh?=
 =?utf-8?B?QThDcHBjbHpsVDR2K2RQVktIajBmcnlxQXMvVGl5Ry93R2N1RWxGdUdBem1D?=
 =?utf-8?B?VDNiL0JIN3RFZlVFOXdPZVRVdDhSRlBiOU52K1RibEJKQzNwc0xHSDUzSytQ?=
 =?utf-8?B?dmtZdUVmamJxdUtGSkx4dG9MLzVsL3VmdTBEZU9Gekg2aXRVSWRBb25JZTZr?=
 =?utf-8?B?OEkwMFhLTXdualVjN256QXdjRzRONWhKbHZaQzQwRHFlUXFRcmNOdWZIbWoz?=
 =?utf-8?B?WTZ5RlROUUNVRjNhYXhrcWRnQU8vaGloQnRNZGhMd2xSVFNJSEx5L2EzS095?=
 =?utf-8?B?VUhyNU5CVVJoS1hBWGV0blRzS1VBYlVPbzJNU0lmYnhuRyticTZtUTliVndW?=
 =?utf-8?B?ODJLWEhGOTQ5eklGZWF1eWd6bGtXYTNZWkgrTEt0cW9uTDJVbVRBeldBNlZt?=
 =?utf-8?B?UEhMd1h4V096V25jWlN1cnZ2cnJUemFyNjlYNWdpb2l4dGY5UWNXZzl3d0Va?=
 =?utf-8?B?RlZYRkNCZGJ5a1dPRW9hTkJxS1JLaXdCbWpCMVJRYndtVm1RMjJvcUduNEdy?=
 =?utf-8?B?d015TG1aR20vT2NBbDJETTZOTWdTaHVacXJhalBQV3dxcUxHQlB5QXdWLzJ5?=
 =?utf-8?B?U2VkOThYQUMrVk40bkp2MEY2MWRWR3Y2aHRWTUZxMVZBb1FEUE9lbUdhQU4r?=
 =?utf-8?B?S3hDM3lNTVN1eGxoaCtYcDVkL05xVTdzcUJQZ1pxemx3TjBuUEQ1NUtRYkVD?=
 =?utf-8?B?OTc2SHNXUWV1c1BReENxdlNCUHFaaHhhYnZlUVlQUG1aYVNxVGFYbFF5K3Jn?=
 =?utf-8?B?MmQrZ1o2UDJuQVdpVDFWcjRwcHR4Vk8zSHdYdlJCckhaTEEzZFpmcHArSnRm?=
 =?utf-8?B?aUwwckp2Rm5KclpZejNmbHZsckJ6cEZqb29ZSktYWnV6T0F1b2p0TDVKdWM1?=
 =?utf-8?B?K0NrNkg3L3JjTEd3L2xqRkhhVGZ3UzFTSWRzdC8vVDNxY2xxbnM0OVJici9p?=
 =?utf-8?B?R2VQSUhxZWtlWkdSMmJqUXhRb3o3UlhCR1prZ21peFhNR1hhOEE4blgzam1S?=
 =?utf-8?B?VzFtL3VaQ3dXSUh4d29ZNkFVcE00eTZ0WlJrQkhwSGJyLzJqL25oNlRVZHo2?=
 =?utf-8?B?bVBPaFBJRXBKOWVMQU5TcjF6aGNBM1JjQnlzYjFYUWg1ZitXZmI0Z3lxZ25P?=
 =?utf-8?B?bXRpYi9nRGZqeXlQY1NVbm1SaEdQbVZVSnB5YVMySnoreURXSUJoV0V5d3Jw?=
 =?utf-8?B?UExzWlRwT0VGV1hUaTdHMGRRSE9pR0VLOWwvdlJPalNnZGhKenhJVDNrcnJ5?=
 =?utf-8?B?M1hGNTZvUitkNnpUTEdWL2FoV1dsNkttYlZ3d3dsODMwdEQ2MEVQNzRGaDZh?=
 =?utf-8?B?QkNXb3BwekNMMndETEFDeWdFNW1BVmpud3JHOEZoZVZCcjFlcFNRK0NGU2JK?=
 =?utf-8?B?cmlpeXpGNHFOYlVxNFFZaWxsZ1VHNUh3bGFMR0NVTXhyeDJBZVJBOE1veVNh?=
 =?utf-8?B?T0l5N0t3M25PcjE4eC91UnZoeWVxUTFiVzkwUHRxdVpEQTVLQVdTbUlzM0Zj?=
 =?utf-8?B?ZUMweGtuV0I4OTdRMG1sU2YyNmwrU1RVRS9yOEpyTHR2S0FZTnE0QmpsSlE2?=
 =?utf-8?B?alNaUUdjeXd2YTlpTVpmaE51YUNkWG4rZFM0TlVjVDB0dkVKTDEyYTNnODRP?=
 =?utf-8?B?TXRoWldUNVpoMFBKWHlnbmZ1clN0andWS2dsZUZ4bmNmcEphUGVGb0xyYktt?=
 =?utf-8?Q?RLxobYgceZkii8RIwrlP95qPg8GxunO9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NElIeGtxbGpySVNSbDlHams5WDB4TEN2WDlFNm9jUitLcUlJS2VIQWlZMTJI?=
 =?utf-8?B?ZFNXcDF3NE9Wb2xBSERlWE5FMjZhVHlXdjFzNGp6NWJLNjJUcVo3ZmxQUDl3?=
 =?utf-8?B?OS8xSUlrYmtTcCsrTHIzeHFya21ta3FzWW94UlhOZTlGdlBtVm5JczREUkxv?=
 =?utf-8?B?elNDeXlsTU03SHA5NkxEUlVmV2llYUlsZ1ZDNldLK2dVWmM3cnhFZCsxWHRP?=
 =?utf-8?B?YWpmd2JRSDdJMllqRDZXaXROYVNKNWxBN2dOTHFsbVBsMW9KaENGaWt2L2d0?=
 =?utf-8?B?clFiU29HNlgzdkhsTFJhZTVoWDF0ZFRWaHVNNU5IcEhBSDJCTjdmKzJuRWlz?=
 =?utf-8?B?UnhUQzBhVGtvN1R0cHVOYXg5U2tRaG1aem1BZ1FWNGJEZ0pQdWw4RWlvbWE3?=
 =?utf-8?B?UndUUE9DZkEwQzkrc1JOUG9Vckg1RExvL2ExVGtMMDlJclNwS0VIUmw1VnN6?=
 =?utf-8?B?cTl1emZaSnY2TGF0SnZFT29BMUFwZjBNMm9sVjlhbXBLVlUxOER5M0JOR2pT?=
 =?utf-8?B?WEJmMFdiQitLTWpuUWo1ZVhjbDVKNlY3R25PR25vSUk2cDcxeXA1Ykh3dWFs?=
 =?utf-8?B?WDJDYmhEWmpoR0pUZVFxR0JBWGFIbkgvdDh1bzhjZEdlVFhxd3NLV2VDY0p3?=
 =?utf-8?B?bkI2cUljS0FPVXZJVHJGUlJkakZmd0IySGRZMURtYjJBU3dSYmsrbDA3Q09t?=
 =?utf-8?B?TlFZYjNNc01wVTdOQ3JhTWl3a3FBZjVTYmhwZFVidFZEU21UZUE2MzZ5eFlu?=
 =?utf-8?B?L3hxLy85QUNaRUR3WHhBNUJSaTY0eHhDdmhGTWFzVWtNM3ErNERYcDZDZkJM?=
 =?utf-8?B?c2tUSXFoOFQ5U0h2L010TzVBUlpkQVcrczRIZ3JEcy8zSG96OFcyVnh6cVA1?=
 =?utf-8?B?cG9RZHZPYkJFemlZUDA1YmxaY2ozSStuWS8zZU5zc1hZWWZ1SzhMc1ZSMlRl?=
 =?utf-8?B?K3lTVXdxQVNlNmpxa0RjemdmREVpQ2wxWk1FQ1hlSlozYVdBK3h6RngzTmtC?=
 =?utf-8?B?QlVLRmwyREhuWThVcG1GOE9jWDU5cUtiRUxEcUFIV2R0UXZZTnJnQ20yakRR?=
 =?utf-8?B?T3VHcDZjWTFGb2FmSnhsbUNWalIwdEdxSlRvYnpCTW1GWlMyaTJtNlJGc1Qv?=
 =?utf-8?B?WUJyNzlBRlNoSkQ0aWdHb0tDblRRK2ZDbHFmNmtzUnltMFJ4eVdlYzVwTVIr?=
 =?utf-8?B?K0NBN0hjRFh4YUhhaHUwY2tyMUZ6dXhkeU5XSlk2Y2t2WlRYc1dpQWV3V3Y5?=
 =?utf-8?B?MHlSQUhZckRLa0p2MEVJRFBiRVBKM0orMWk1TDUwL3lEU0tSdU9DMVJERzVn?=
 =?utf-8?B?anp1RUVVR3V6WkpMTkNWV3VRMXlPYTdNWlRHai9tQ0hYYlloSXdVNmZkSmdC?=
 =?utf-8?B?M05zMGZId1FYWmEwc1lLTWhKL05UMG5qZTlMaExqVkxrQmlYT2tSak9PanVU?=
 =?utf-8?B?cWs1anhLTDEyWFdrN2pQNkRrU2IrOXRVQ2taYkJCNWgvMk12amdHNnFmZmd1?=
 =?utf-8?B?bGxXY3AvdWhDUE9IN1ZkYWFsUW5EenF5QlNGL3dCeGZlcUd3TVRnY1IxS0VI?=
 =?utf-8?B?Z1RuQ1pSYnVpcTJ5Sy9iOVg5WWUxeHFOdTd6WFppSnVqdHJUcERkYm52eXBi?=
 =?utf-8?B?c0JKaXhVSUluUXExSndDaHdVaThUZy9LRk15Nm4wT1M3UHgzbzJEVzRiSm96?=
 =?utf-8?B?S1QwVThMQ04zaDZtME95cFBOWTZFYm1CQy9SRTZlZmxIclVUdTlMUzBydy9v?=
 =?utf-8?B?bnpHTHUvQkFYNk05RzhHVkZySUhaZ3JrZ1hnczZSUjN1Rm84RzNCNXI3OUZV?=
 =?utf-8?B?SFFoWVhtZGUrMjIzbG1RaXNJWnAxemxZN0NmdFMyOVNXQi9aLzFhc3crL0RC?=
 =?utf-8?B?cm9BR1FEem1hMkVTb0N3YWZSb2JjTHZybjhHMGJwNGFBUE5XZkpBS3YydVVo?=
 =?utf-8?B?Y2YxOWpnN0o3eEhZUE1VZjAwRE81bldIQVlta3pWOEJUZEtSRUFFT3oyMThv?=
 =?utf-8?B?d2dVcXNnTGpFWTUxOVJoWjFka2xtK3pVY1laMVkxbVFnZlpGRjZLL3hqSWZx?=
 =?utf-8?B?ZHUrbGRKbDB2TmJmSDFuVmcvVHlocnB5b3BtUG9iMHZSYXp1UjI4b3UwZzQ5?=
 =?utf-8?Q?b07I=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4daf5aee-c866-48d5-b2f0-08de2077747c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 16:37:36.2236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bm/o6mvdrusLfUmNo/vgRgKoE012KVm2xmYnPvcJVfhDXLIokzJQyl1N3w52MVkA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7746
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


On 11/10/2025 10:25 AM, Kuehling, Felix wrote:
> On 2025-11-05 17:51, Harish Kasiviswanathan wrote:
>> Fix the following corner case:-
>>   Consider a 2M huge page SVM allocation, followed by prefetch call for
>> the first 4K page. The whole range is initially mapped with single PTE.
>> After the prefetch, this range gets split to first page + rest of the
>> pages. Currently, the first page mapping is not updated on MI300A (APU)
>> since page hasn't migrated. However, after range split PTE mapping it 
>> not
>> valid.
>>
>> Fix this by forcing page table update for the whole range when prefetch
>> is called.  Calling prefetch on APU doesn't improve performance. If all
>> it deteriotes. However, functionality has to be supported.
>>
>> v2: Use apu_prefer_gtt as this issue doesn't apply to APUs with carveout
>> VRAM
>>
>> v3: Simplify by setting the flag for all ASICs as it doesn't affect dGPU
>>
>> v4: Remove v2 and v3 changes. Force update_mapping when range is split
>> at a size that is not aligned to prange granularity
>>
>> Suggested-by: Philip Yang <Philip.Yang@amd.com>
>> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
>> Reviewed-by: Philip Yang<Philip.Yang@amd.com>
>
> In case you haven't submitted this yet, it's also
>
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
>
This patch uses remap_list that is based on prange->granularity to 
decide huge page size. That need be addressed.

Regards

Xiaogang

>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index c30dfb8ec236..97c2270f278f 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -3693,6 +3693,8 @@ svm_range_set_attr(struct kfd_process *p, 
>> struct mm_struct *mm,
>>           svm_range_apply_attrs(p, prange, nattr, attrs, 
>> &update_mapping);
>>           /* TODO: unmap ranges from GPU that lost access */
>>       }
>> +    update_mapping |= !p->xnack_enabled && !list_empty(&remap_list);
>> +
>>       list_for_each_entry_safe(prange, next, &remove_list, 
>> update_list) {
>>           pr_debug("unlink old 0x%p prange 0x%p [0x%lx 0x%lx]\n",
>>                prange->svms, prange, prange->start,
