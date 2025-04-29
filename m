Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E73C369DC
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 16:08:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2AC210E500;
	Tue, 29 Apr 2025 16:08:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JRihWYN1";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A6BA10E500
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 16:08:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PMY+wA+Ncm6aVCteZKoapnpoghPolbfRtHnDVOULmYb4/He3tLwPzOrrjEBxAP8j9q4xDltmO5VSnIzbxHwKYhnOLKapnARjtT/GxkbmFPpnJEU/pXJMGwHj7zSE9X5BbEHbNleB9WzUX/ef4CDxTwTNTK9spX9190RrOAkKQK35KlC7cm2j33lRoj20P7eUOHyfoeCXhEmbmYT41bd44zCi8ZcahHG/mDs6g79zPtCU0LrDtJS/5kSZjAHBXmvj2MD7ZpfJqX79dSXkNIvP7VrFs/UJE21cCP0oCJzl50haYGF3NC+1pXPyPme74E9eSi2xBaExaBQVhHHGCyvAXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=waAdUGTGIOO5kF5JdA8/vzhCw1K3wJkltoeqCSJQ0q8=;
 b=dM5kg7VKmxTaPysxywT15oa2V57vz4cUzVL8jRaJkNMsGnzxOObFqZLzjVmqlBjXrCrscJbQvM4/7gT83ofDp/yWAHx6hpYa8y6l3UvTkNVPyzFlyKwzqhjZvcOaq5vzB/a9lMLVoDb55/wj8uHp0O2Pu60WI60KerkPG+va2P6F9UbbeZBmbkVyOHLrVA9VKdQNYatKAAu1/zaSZFrHF9QQAlyFeXTUbBesdc1po7VYfAaF2RHFVuKBJ7Ne8TDVA+xJ6/tDPT5O7pU/xCGp6tM5esW6I8WcJD88i8LG+VYq81KyitNg7/3tFUbICBztl9IK6H/wJMA0lBoMilFMuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waAdUGTGIOO5kF5JdA8/vzhCw1K3wJkltoeqCSJQ0q8=;
 b=JRihWYN1Dy8a59J+jMwCzxt1L76rd2MMYKuHCV7EXIHdswYW6TiG9X5WZiuPM/YM5j8/odlR/OU1cDONSe1exMC37cEDFxCqJIGvQSvoImokTfww1ciTGbw/5QnxCXQhdfRCpRnY54haC6vouP/dmdVmnPeH01Avic3nZqqzwnw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4419.namprd12.prod.outlook.com (2603:10b6:5:2aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Tue, 29 Apr
 2025 16:08:45 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 16:08:45 +0000
Message-ID: <a3dfe7f7-7ea4-4c30-abb0-93c5965b71f3@amd.com>
Date: Tue, 29 Apr 2025 18:08:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dma-fence: Add unwrap mode enum and macro for
 in-place deduplication
To: Arvind Yadav <Arvind.Yadav@amd.com>, alexander.deucher@amd.com,
 sunil.khatri@amd.com, Arunpravin.PaneerSelvam@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20250429152448.205212-1-Arvind.Yadav@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250429152448.205212-1-Arvind.Yadav@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4419:EE_
X-MS-Office365-Filtering-Correlation-Id: ec501675-ae46-4000-6d24-08dd87381e65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?LzF2QnREdU1MRWtJcDRNZzc2VVZWdWhpcjRhdnV4czYyUWJJTmg5TTNRelJn?=
 =?utf-8?B?cXJ0alpxd2ZSU2RkbnFkOWVNK0Fmbno0Z1NZY2RVU24zcnRtTmlFYytMMnV5?=
 =?utf-8?B?OElySHc5bGFrU0dENHNxekpHeWpvWFdqdUVka0NjTytHN2RrakFLT1JTb0pr?=
 =?utf-8?B?K1lRSHpVNXRZdmxuZkFsOW1UL084R2JBa1ZOQUhtZjliTm84SG5WdFAxSVkr?=
 =?utf-8?B?Szc3OXJqbCtIKzJLMldWZTErK3hGRFJ3QjIwL29CZmtGT3FsSTczK0FwUDla?=
 =?utf-8?B?U1o0Q1IyUC9oeXZ0WVFvMUFRMjQrYW5jVzNISTlvSngwY3RLWTcxWlZ4TFh3?=
 =?utf-8?B?Nk1LdlgzcklaRFhGUzFmaHVla2pRL2liYVpCK3R0a1BmREVzUVp2dVdUODE4?=
 =?utf-8?B?b1JZVFVxT3VmTlNWdDFVN0NNVFNjNERUNnA0TlpIK3Z5TWZudXF4VkFUamRP?=
 =?utf-8?B?STZlT2dJNU1IbDEzcTNSeitRVGxyYnR6N0RBdjgxTS9DZitpVFFjbUF6QTQw?=
 =?utf-8?B?WHRoYUY0NU1wQnh5S05VY2JNaUsrY29XZnVhZlF3bllCczBqWCtkMDFCVHpS?=
 =?utf-8?B?ZWlmSWF3Z1pVdmMyQTJicEt6Qm44aXhwWGU3bmtmR3VlMlBNbUI3azJKdlZq?=
 =?utf-8?B?ZFFIVjNYU0d5QThXME9ZbllIQ1hCcWFhT25tT3VGSzRTR1FGem5adVRuL3Ix?=
 =?utf-8?B?ME56TVN4eXo4Sk5JVjNQeFhFb1EzUzBBZm9PTndhRTRZTjQxTVM2dmVGOG0w?=
 =?utf-8?B?MmRYajV2YWd2NnkxbTJpMlE2elorb2lBYkJpaTZSR2ltQmlBa2NxTnJLdXVP?=
 =?utf-8?B?MTF3ejEwUW1ZYllEeTBaUm5kNlZTVHlpdlF5Q2l5WFY3ZjF6WVlyRDE2TGFC?=
 =?utf-8?B?OG5VSEF5RFVleTRhUHhZNUNEaTAxeGZsNkpmRG1KdWtEbEtwcjg0YmJWRW5n?=
 =?utf-8?B?WTJuNkVsQVo2dUI0ZkxZZ1dlb3ZqNXlmUWxKbUR4SkxoMFBCL050VEkyL2JJ?=
 =?utf-8?B?UE5VbkFVckF4WEVZS3FGZ2VVUm03UStRb1lUejBmUzJIOEhWdTRycllGdzVX?=
 =?utf-8?B?Tjc0NDBhV3BFMGU2OWVlOTVybXhLb0lyYzVVQTdGVkUzZ0poNHdLZ3BWc1M0?=
 =?utf-8?B?MElmekZSS09wVHdIVGZBa0IwY1pTbHlRN1VVQmEyWWxtVmN3L2Myams3elI4?=
 =?utf-8?B?d1QvN29zcGJLQ3JJMzlFWU8wSDhHK01sczUvMDRWbjVzanFhOXg4RTFpbE8z?=
 =?utf-8?B?QVdnb1FUYTZlZU93a2wvdTg3WUpiWVQwN1BxNTRieXdJZDlRMTVleno4OHJE?=
 =?utf-8?B?TjJ0Qi9EQkhIWlNOaXpZek5uVW5kaWtuYkZSWW1aTnM3WnQ4YWxBWmlEaVNS?=
 =?utf-8?B?WWhrREx5MEF3QnB6SUdlMytqZWlwQUZSeW96ZC9Kc3JrYzBWMjU4T2krWVBw?=
 =?utf-8?B?Y2FieEkrZVRPTXFFVjRuQk1YSTFvajdQblB1WCtwREZtaElQeC9aUnA2VWVo?=
 =?utf-8?B?MUV6dUZRSi8zQkhmMFZSQ2ZmN25FRVREQnJTMm5id1czeC9uNUFwTGJMRlo2?=
 =?utf-8?B?czJtS1NrVkdPQU5raFc2UjdlNnI5QkJETjBnYjc0bUxGQ3pibDV2ZmJBVHFC?=
 =?utf-8?B?ODlJcncxSk9WSnJTRXNzOGQ1eU9ZU2xadCtuZDlpWEFXNUNIcVZoK0RsYVJh?=
 =?utf-8?B?dFpSK3A5Q1phWnBSQzZkclkvVkYwc1d3ejRMYWVjeFVvVW8vTk5oTVFLRFRW?=
 =?utf-8?B?MzF0YjBRU2ZzeWtJc3F1MUo4SDFWVzNlREhrZlJYUDNITk4vTmlRWmlwWDJ6?=
 =?utf-8?B?RWlNRWlKSnMvWTlHS2hvU1kzNStnTlBQTTZjSmhkZ2ROcEVDY3d1bnFsbUhP?=
 =?utf-8?B?UGlCWDlGVkU2bVB3ZFNNbXZqem5JYTN2T05rMEZHY3BHalBPK0FzbnZHMkNY?=
 =?utf-8?Q?oEOpNGxm230=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ui9URjB3RkFBWkNGWmRRSG5TYzVFNGVnUXlDbnJ3bE1HRE9iYThQdGx5M1dP?=
 =?utf-8?B?L0E4eUZPb2ZHNEFGRjFTVHhKSHVZSEg1VXRDckNVK0NhV2V0MmoxTFhmZFVJ?=
 =?utf-8?B?Nmp0ZzdpVGRjdE9COHg4Ykl1OXBUaFMwVVdHYmdCbjZlTEZ4NXM2U3VXbzNk?=
 =?utf-8?B?OWZlaGd5N2FFWkhncTNoaXVxbEZxeHVndUdOU2xnYTdzc1VJcGozOFREWlBQ?=
 =?utf-8?B?NStUbFZabk9WNFlyOGR1UFgyQjVJbkJhOTUzRXo2TDVweGdvcUVMTHRUWXMr?=
 =?utf-8?B?RUN1eE9JUnVZM21Ba3NpemdGME8rMGc5bnRXWndDTXBRbFVwZmg1aTA5dU81?=
 =?utf-8?B?UGVPVU1IVmtkaDJLT0RTV2V1YUVCZjR1dGVjOTZIUXJZT0ZCZ2E4Qlk4Mmls?=
 =?utf-8?B?eVpualhmNFlaTnhVMTNSMUk4RFRkNHNhWHA5bjRmZTVEVDRMMmdxenAwVzNv?=
 =?utf-8?B?YjVhS2ovOTU5Uk11UlV6YUsycUw1L0tIcjFHZkdNOHYzeUwzSWtMbnhMWFdJ?=
 =?utf-8?B?cUwwcGwyVERWY3kwWHdGckpkMm4vNTE4alZlWERLQXAzUldEcmFCU045a2Ns?=
 =?utf-8?B?TXI0SGljcnlKeEtwRU5lNStTaVF4ZFB2NCtVNEpKOWtoWGhDVkZjTmpNdjFm?=
 =?utf-8?B?WWFVSEtGRnNKZlNNR1h3Zm4yVmN3b2lxNGZmcUs5czdxRFJzODlDd2xpcmdN?=
 =?utf-8?B?TXhYb2dxL09uUGlZLzFWZkxUaUMzL2VRVFlqOFMxZCtLcTFKdFJHS1M3U2M0?=
 =?utf-8?B?TGNmbXVUd05XZHZ0RVE1bEQ4MitXYklMREMrODhReUxMck13MFlVaE9FVGdt?=
 =?utf-8?B?c25TVDRxUVlRbENta21JendCaVZvSHBLMndsOVNLNkRnekFRVGd1RE5MZ0JM?=
 =?utf-8?B?QU5leml4emt5MHhVRVRRMTBsNHBzMU1VUXJrMGkyWEs5bEpYNi9MSVNJaUY2?=
 =?utf-8?B?azV1bXFXMDZ4WllQdDRSYzVURy9UQkhteHVHQk43bm13MzdWZGpERHZJVzU1?=
 =?utf-8?B?UHc3bGlEckVpR3NQWFpXVEQvTGNqdEFQQVUvaThUck5VSFdsY3czRVN6T2xy?=
 =?utf-8?B?ck1lSm42M3BzeS9namt2RGN2Zlo0OEhOSmVidUFuWTVEcWNVeEVCYWgxZGJD?=
 =?utf-8?B?a2hyMS94QTI0NUtEQlNiRktINEhNSUliWnFOcWkwYk93dDdPRkpqYW9tdjhp?=
 =?utf-8?B?N0U3YUdIN3k3c2N6OFNuM2hZUktyUmgyNHVEaXo1TkljVkxBV0M5UEVaSWFW?=
 =?utf-8?B?dEg3Qy9PdFV0OCtUM0lsalZJY0Ivc1JRbC9ESG5LMStqajVDdU96RzFiaE5z?=
 =?utf-8?B?Sm9qdi9jczNtenhnODZGN3NiTW9rSHh2L041RTF4and5eVI2NnpEMDI4Yzc0?=
 =?utf-8?B?Ry9SZXRRY0s0STh4SzRhMU1Obk12eUJMNG9ielNCcHNEbmpZUVJPUWZHc0Rh?=
 =?utf-8?B?Y1M1dWhQdjZQblp4dWtzWUQ5NzZCN2svSDlTWHVubkFvQTFPdmpoSm5od1Zz?=
 =?utf-8?B?aVI5RGVrTDBqY1hyKzVFWUpYb2JNTi9jOXBITFVmU2tkUnlqZUFySy94NW1w?=
 =?utf-8?B?VnpMSzhlS0h4OWV2ZmtCMnYvQUZKVEV6VGFXc3JjY2VsZVcwamlYVy9BU2gw?=
 =?utf-8?B?RjQ0WVpWbGVxYU1HR2xDTHpCVnpJdEZqSSsydVAxTk5JYXhSdkZnWjkwOThN?=
 =?utf-8?B?WXhyWHVvR0tPcEFxT2RPWmdDcHZvVXBkNUIzNW5HcmZwZFE1MnV0KyswUk5B?=
 =?utf-8?B?d0lrbFY2V01wcEtRVzlOZDBiclFhN3pKMVpBNGw4UVh5a1VBb1dxcER4dUhX?=
 =?utf-8?B?WUh5Si9IMEZoVGs1Y1JyY011QWJDNWs2cVRpUnBqR3hlR0NuTVc4b2l3VDZC?=
 =?utf-8?B?TzRkNmgzNjAzZk13cityNm00aVJsUU0ycHZOZm5YaE13MDJaWVZkZ3l2ZjAx?=
 =?utf-8?B?TzRCNi9yL2xKajZhM1NuK3dhdUt4MDRCMkNPeGdhQ3NBWGhvc3BzRm5leEI3?=
 =?utf-8?B?ektFVDR6RjQ1NkJxZ1ZzN3R4dGNNOTRiWXJQQmV6YlhWVXp6Q0d3ZzNpRnRl?=
 =?utf-8?B?S2kxMlNKQlZzWk9zSjJwN3g3M2Z1Y3B4cHluRk5oMnlXK0x5cmoyMHQ1Uy81?=
 =?utf-8?Q?dlVf087NuWbqP7Oj2ZrONhxib?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec501675-ae46-4000-6d24-08dd87381e65
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 16:08:45.5802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BenCzJhRl1L0aUyvo+aaMbGnZz7Od7i9N6xcooH1hOwi+OKOGjb6NneuFu894e/U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4419
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

On 4/29/25 17:24, Arvind Yadav wrote:
> Introduce a new `enum dma_fence_unwrap_mode` to support multiple modes
> of fence unwrapping and merging behavior. This lays the groundwork for
> more flexible and efficient fence operations.
> 
> Add a new macro `dma_fence_unwrap_shrink_array()` to allow callers to
> unwrap, deduplicate, and sort dma_fence arrays in-place, avoiding
> additional memory allocations. This mode filters out already signaled
> fences and keeps only the latest fence per context.
> 
> To support this, refactor `__dma_fence_unwrap_merge()` to handle both
> merge and shrink modes through the new `dma_fence_unwrap_mode` parameter.
> The sorting and deduplication logic is extracted into a new helper function
> `dma_fence_unwrap_dedup_sort()`.
> 
> These changes allow clients to efficiently compact arrays of fences with
> minimal overhead, improving memory usage and performance in common
> scenarios like command submission or dependency tracking.
> 
> v2: - Export this code from dma-fence-unwrap.c(by Christian).
> v3: - To split this in a dma_buf patch and amd userq patch(by Sunil).
>     - No need to add a new function just re-use existing(by Christian).
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Sunil Khatri <sunil.khatri@amd.com>
> Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>
> ---
>  drivers/dma-buf/dma-fence-unwrap.c | 54 +++++++++++++++++++++---------
>  include/linux/dma-fence-unwrap.h   | 44 ++++++++++++++++++++++--
>  2 files changed, 81 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-fence-unwrap.c b/drivers/dma-buf/dma-fence-unwrap.c
> index 2a059ac0ed27..f389c37a0eb5 100644
> --- a/drivers/dma-buf/dma-fence-unwrap.c
> +++ b/drivers/dma-buf/dma-fence-unwrap.c
> @@ -79,15 +79,51 @@ static int fence_cmp(const void *_a, const void *_b)
>  	return 0;
>  }
>  
> +static void dma_fence_unwrap_dedup_sort(struct dma_fence **array,
> +					unsigned int *count)

Just call that dma_fence_dedup_array() (e.g. without the unwrap).

> +{
> +	int i, j;
> +
> +	sort(array, *count, sizeof(*array), fence_cmp, NULL);
> +
> +	/*
> +	 * Only keep the most recent fence for each context.
> +	 */
> +	j = 0;
> +	for (i = 1; i < *count; i++) {
> +		if (array[i]->context == array[j]->context)
> +			dma_fence_put(array[i]);
> +		else
> +			array[++j] = array[i];
> +	}
> +
> +	*count = ++j;
> +}

Instead of making count a pointer just return the resulting count.

> +
>  /* Implementation for the dma_fence_merge() marco, don't use directly */
>  struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
>  					   struct dma_fence **fences,
> -					   struct dma_fence_unwrap *iter)
> +					   struct dma_fence_unwrap *iter,
> +					   enum dma_fence_unwrap_mode mode,
> +					   unsigned int *out_count)
>  {
>  	struct dma_fence *tmp, *unsignaled = NULL, **array;
>  	struct dma_fence_array *result;
>  	ktime_t timestamp;
> -	int i, j, count;
> +	int i, count;
> +
> +	if (mode == DMA_FENCE_UNWRAP_ARRAY) {
> +		array = fences;
> +		count = num_fences;
> +
> +		if (count > 1)
> +			dma_fence_unwrap_dedup_sort(array, &count);
> +
> +		if (out_count)
> +			*out_count = count;
> +
> +		return NULL;
> +	}


Completely drop that. Just export the dma_fence_dedup_array() function and use that directly.

Regards,
Christian.

>  
>  	count = 0;
>  	timestamp = ns_to_ktime(0);
> @@ -141,19 +177,7 @@ struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
>  	if (count == 0 || count == 1)
>  		goto return_fastpath;
>  
> -	sort(array, count, sizeof(*array), fence_cmp, NULL);
> -
> -	/*
> -	 * Only keep the most recent fence for each context.
> -	 */
> -	j = 0;
> -	for (i = 1; i < count; i++) {
> -		if (array[i]->context == array[j]->context)
> -			dma_fence_put(array[i]);
> -		else
> -			array[++j] = array[i];
> -	}
> -	count = ++j;
> +	dma_fence_unwrap_dedup_sort(array, &count);
>  
>  	if (count > 1) {
>  		result = dma_fence_array_create(count, array,
> diff --git a/include/linux/dma-fence-unwrap.h b/include/linux/dma-fence-unwrap.h
> index 66b1e56fbb81..b5683b024548 100644
> --- a/include/linux/dma-fence-unwrap.h
> +++ b/include/linux/dma-fence-unwrap.h
> @@ -10,6 +10,18 @@
>  
>  struct dma_fence;
>  
> +/**
> + * enum dma_fence_unwrap_mode - Mode of operation for fence unwrap and merge
> + * @DMA_FENCE_UNWRAP_MERGE: Merge all unsignaled fences into a new dma_fence object.
> + *                          Returns a single merged fence or stub.
> + * @DMA_FENCE_UNWRAP_ARRAY: Deduplicate and sort fences in-place.
> + *                          Returns nothing, but updates the input array and count.
> + */
> +enum dma_fence_unwrap_mode {
> +	DMA_FENCE_UNWRAP_MERGE,  /* Return a single merged dma_fence or NULL on error */
> +	DMA_FENCE_UNWRAP_ARRAY,  /* Return deduplicated, sorted in-place array */
> +};
> +
>  /**
>   * struct dma_fence_unwrap - cursor into the container structure
>   *
> @@ -50,7 +62,9 @@ struct dma_fence *dma_fence_unwrap_next(struct dma_fence_unwrap *cursor);
>  
>  struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
>  					   struct dma_fence **fences,
> -					   struct dma_fence_unwrap *cursors);
> +					   struct dma_fence_unwrap *cursors,
> +					   enum dma_fence_unwrap_mode mode,
> +					   unsigned int *out_count);
>  
>  /**
>   * dma_fence_unwrap_merge - unwrap and merge fences
> @@ -58,6 +72,9 @@ struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
>   * All fences given as parameters are unwrapped and merged back together as flat
>   * dma_fence_array. Useful if multiple containers need to be merged together.
>   *
> + * Internally uses the DMA_FENCE_UNWRAP_MERGE mode to return a single merged
> + * dma_fence (or a stub if all fences are signaled).
> + *
>   * Implemented as a macro to allocate the necessary arrays on the stack and
>   * account the stack frame size to the caller.
>   *
> @@ -69,7 +86,30 @@ struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
>  		struct dma_fence *__f[] = { __VA_ARGS__ };		\
>  		struct dma_fence_unwrap __c[ARRAY_SIZE(__f)];		\
>  									\
> -		__dma_fence_unwrap_merge(ARRAY_SIZE(__f), __f, __c);	\
> +		__dma_fence_unwrap_merge(ARRAY_SIZE(__f), __f, __c,	\
> +					 DMA_FENCE_UNWRAP_MERGE, NULL);	\
> +	})
> +
> +/**
> + * dma_fence_unwrap_shrink_array - Deduplicate and sort an array of fences in-place
> + * @ _num_fences: Number of input fences
> + * @ _fences:     Array of dma_fence pointers to be deduplicated and sorted
> + * @ _out_fences: Output variable updated with the number of fences after deduplication
> + *
> + * This macro unwraps each fence (handling dma_fence_array if needed),
> + * filters out signaled fences, sorts the remaining ones by context and
> + * timestamp, and removes duplicates (keeping only the most recent fence per context).
> + *
> + * Internally uses the DMA_FENCE_UNWRAP_ARRAY mode to perform in-place filtering and
> + * sorting.
> + *
> + * The result is stored back in the input array (_fences) and the final count
> + * is written to @_out_fences. No memory allocation is performed.
> + */
> +#define dma_fence_unwrap_shrink_array(_num_fences, _fences, _out_fences)	\
> +	({									\
> +		__dma_fence_unwrap_merge((_num_fences), (_fences), NULL,	\
> +					 DMA_FENCE_UNWRAP_ARRAY, &_out_fences);	\
>  	})
>  
>  #endif

