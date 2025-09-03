Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FAB1CA0FF2
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Sep 2025 04:57:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3299410E86B;
	Wed,  3 Sep 2025 04:57:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KokqZjkM";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC8BC10E86B
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Sep 2025 04:57:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vdBuFzIaKFxjagmgG3SJPeFz/J15zjbTFsi/ZRsWKhtlLtc1lleAf51zkfedyAZLl2CPrOPOPgTPiVwPXfplt6vsdFg87ln7axZymzQxdOgDFFqRkx/WvwtSHZtuvKpZVwiA/sIqnYak2PW0tucs/iZGFCuX6rhx3PZL3EM9DyHAd5nYbENrGJMHPb5di8u13fJiuXS95Fo/0tW51HH5tCPHt9Fg76wcx9DAIGuBmAYTQqwV6ePLhKO+0l5slbxjv+mPB6UooRyIX/JP6BgVzacedxZ8teKSCKEpR9m8k0TceJju0iXVZOHDo45y4eGaJTsoafLtnS5eOAAviSiZ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCNLU2Xxr7Kf1lBfAqF39O6stgdXC4bMdavjnFMF+zc=;
 b=e3ZGoKMBroXDv0i0e6jjXduVqidds7DtzKfqZoVfU3WCCHuY4yAAzTLxG/kYYrAeEoEcHwbxN+MhspSMO3q+ISDT/cK1M6BU8IrRjKnEEmoLvFIyQeQGcc4lAdtEhgceLA+eMwAPyB8bGV7SNKLMWoz1+NvQ8YuSjBNWpTi21mK1qdfzUnMs/TqyJ3qrTrvgqiKAr7HniPBxlA0gbXvPiM+jce38TSsWlTZgVkrpOqw6LkZocA2HLYdvybaW2edBjOmldTm+bzWvIV20MyTn6AixVbZ9IO+4pHhmll6KeB/Id+qx/uXGqda0I+0ILYY/Gr3iLs11s40FHmzDzPrOqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCNLU2Xxr7Kf1lBfAqF39O6stgdXC4bMdavjnFMF+zc=;
 b=KokqZjkMsn9R1d6G0Jj2h2R3kg70x9b4AIuvPoPzA4fcerwGKrOC9xuqdHphEoC/HhKuvPCEitt7fVMIi1VfT+TWRiFha3+NVbOKwZu0gDkszLNNIu6pJrEmYAJZe9iOwYF4jqYmOH85Z4kepOzr+X9Kxs0yiWUtW/c0bTxZzog=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB5902.namprd12.prod.outlook.com (2603:10b6:510:1d6::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 04:57:23 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 04:57:23 +0000
Message-ID: <11356cde-e7a2-4d34-b067-d38619e02187@amd.com>
Date: Tue, 2 Sep 2025 23:57:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amd/amdkfd: correct mem limit calculation for small APUs
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Felix.Kuehling@amd.com
References: <20250901022716.283793-1-yifan1.zhang@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250901022716.283793-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB5902:EE_
X-MS-Office365-Filtering-Correlation-Id: 572ba928-8c7f-4845-23f6-08ddeaa65eba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NkdmOHlyR0dUckZEZWRIM29nVFB5bEpwUnIvdUtMUSt6MVVEeEZNY1JmeDc5?=
 =?utf-8?B?eGVVclJXck1MOUxkSnNlTm9sVzZiNFc1TzZMaDlmN3FvTTM1S285Wkl4Nkl1?=
 =?utf-8?B?TmdmaEUwdW9vOW0raDVlbmVjbmNYUXUzOE9sbnNMT3BqVjRGakc0dXhkNFlG?=
 =?utf-8?B?a1YzalVBcXo1Sm9ZRmlic0ZhTUZ5bW81Y2dqMmMrMHFZNUw2SUJDQ1JDVjZ6?=
 =?utf-8?B?K1hrLzNLamZ5YVcvWm9LME5CZlpUTWhvOVNWbFdBRjBGbDIva3doaE1vVGJ5?=
 =?utf-8?B?MXlsZXlDRmNQanBxQ0hqNUdYZk9QUHpGd1E2dDg1VVo0MzNJb2krNjRta1BN?=
 =?utf-8?B?MFFiSG8wRXAvaWIyY216YUtsVS9RYXVvRWFqUklNS3BZWHppRTlaUEEzZnlT?=
 =?utf-8?B?TnNqS3dLbWs5UTAvMS9TV3hkdlM2TlVRRDhDVFdHZGYwODFOSWxsT0Y4WGJq?=
 =?utf-8?B?YUk2cjBSSHRxdkMzZTVZZ3BxYjF4czRiNjhKU0lXWmpXc0p4WmZlRGxySWRz?=
 =?utf-8?B?U0tRRUZOWENiZm80RXB4aWtOb1VNRk96UlJCUlY0R2hvaVhQZVk0NzArVWdU?=
 =?utf-8?B?SjNmR0NJNGJyazhDZUJuKzFQdXdKUTFacTJCNVkvSjc3RGc0cDE0aG9QZWlw?=
 =?utf-8?B?M1I1aStFNHRPVmlwbkRLdFlhTWp2YjYzaUdXNG1EWVBVOUNwZVNuTm4reW1s?=
 =?utf-8?B?dm16cUFJWHZOdFpLdk5IL1dWa0pCc2h1bm5RMTdneVhZWkJxSlAwb2ExZEI5?=
 =?utf-8?B?SVIwZGNkVVpIMC94czBsYmNocEhnWm5EMG1uZjVtWVJESXQ0N1cycGFCV0dk?=
 =?utf-8?B?b29zbS91QmpTajFWNnh1MkJpWGdPa3J5TjNUNlBibGhRbmJWT3BIMjlXaUNR?=
 =?utf-8?B?YTFweElzYUhmcTMyM2FwZDdzNE1FQVgyWG1MbTV1cTF1ZXZHZHFEU0ZpVklB?=
 =?utf-8?B?ZVJONlBqYmV4Q09BNjg4NG85SHpiTFZLRWpubTFUMm1LSnF1WU9yc2FZaVBX?=
 =?utf-8?B?ZEcxV3lzUEVSYmR1bnVxdDVNdlJkb2U3MVd5Q0EzVjBlRHNuVVU2UUdNNEFG?=
 =?utf-8?B?Mm9rSXdEYjhRMk5IQTJHQk9Qc1cwMEFtS2orTXE4cC9id3pORE9jS0puVW9a?=
 =?utf-8?B?MDdUckpWSWtSV0NWMXM4bTlZcGRaRGRjc3ZtK0s5UmtCZXJkY0d0UkRnbHB5?=
 =?utf-8?B?azQxVVQ0eGRmNFNGemtrekFFVUtsMm00ck9OQ2hhSGhnekcxVmU1cUpmQWkv?=
 =?utf-8?B?SnFISGdoamVRcFhRamFGdG1jQk1IcWxzdTV5Zk9saG9LQ3IwRUpJM3NQa2oy?=
 =?utf-8?B?WXNLeVlxQitzcWlFUWdVZ2FDa0JQSnI4TTFCdU9JZE4wcG93RnBKZm1EWlYz?=
 =?utf-8?B?eGlGY2dNeFhBbkdRUml1Y1FQY1M2ZXc2Ni8ybEd1MDNXTzlRNFNadVRQOHNP?=
 =?utf-8?B?cEorNkk5VERkS0NxQXpsM0NyVTR6WmJrNnFmaUp0bDBvb0hlamxtc2VFNWlS?=
 =?utf-8?B?NDYyMjhSL1VCVFQ4SzZsQVJ6UWFvREdaYzYwcXByUk5CNVdrMEtKU29reC9m?=
 =?utf-8?B?ZEdFeXlveFNNOWpnV0g2U09KSTAwaFhhbkhBNUY1NGR6RFk0VUdRSC94eFR4?=
 =?utf-8?B?OU5aYTlBemxTV3pkbzU1Wkt3MEZCMzVCb1ZvRnN2NzA5cjNCUjdDcjVlaXRv?=
 =?utf-8?B?Sm9IdjZHRm9GN1U3TmVvaEJyNjIvZUdOTTFybGNzVzdxeFhOUUVKMnpwTzRD?=
 =?utf-8?B?QVpCc2lVSW1FbXJ1Z1J5Q3dFWkdNN2RWZi9NUTBvck5DSWdVM1Z3VnFETzlj?=
 =?utf-8?B?ZFl6SzJmQXlaMUlMRGQ3TWJBM25vTWw5azczWFMzUFljcHJUd05tNno4RmpS?=
 =?utf-8?B?UG5rdFNOOUFCMVR4OTArSXRRbExtenU0VGJZb2QrV2h2N1Zxb2JldFRGWXVC?=
 =?utf-8?Q?w5gMD6FBH/s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEJVMTZuQUF3RHRVbXJJOHVSQlFwcEgxS0ZjMkNPZkNFekFXc2NkNFJIV2dl?=
 =?utf-8?B?aU5YS3h0Mk8yLzhCSFpLekR5eW1YWkxpY0JjOEJOcUQ5KzEvUVBHdEZiYzZq?=
 =?utf-8?B?YjJHZExEVUw1R2ttbHZtZmdWRzdQdHp5M0tORDJ6c2JScms4cjZGTkJqbXVi?=
 =?utf-8?B?Wm5VRG5JT0NlS3pCZlhyVzdnSTV3eWptaFhxQmxVT3ZZMUduTTMvOUU1ck9H?=
 =?utf-8?B?VHVibFF3RkRmWUlCenBNTVZrN2RpVG81RUlHMGdoU3BVdDZxUG9UcnVtTE9x?=
 =?utf-8?B?M0I0QnZUVjFpaXJmZXN1YXA3bWZtSWxhVmpiT09tWnNNVm4zaGYrdVo1Y1k0?=
 =?utf-8?B?L1BhTXE5eWZ3cmhoYys3emk3QUVMZVRnSU51azVEaW0wT3NsYTBLMzM1K3hJ?=
 =?utf-8?B?RGsxLzNNeUZ6akVmbXczYVBrdmtGRmhreHN3M2h6ekxBaTZoQ0lmSzdQRlpR?=
 =?utf-8?B?SGtsSXBYd1RRTmIzN1JtajNJeXdOK3pxNTN3TkM5OFgwelUrems0QlBORDQ4?=
 =?utf-8?B?U0taQU4zb0tjU1g1M3RXeXBFVU5adnY1OUJVaWUzZDZaeHp1Wis5YVB3dUJ0?=
 =?utf-8?B?d1RmUTZtMnlPMkNhaE9LRHZKT3ZOYUpCNEFMdzgwdHpZRUs3d2d2bTArbFVI?=
 =?utf-8?B?S0xIbXRYeERmaVdDNGtqMHlSVC9hQmJ4TE5Qc3dZcGMwc25iZXhZVjk1OE15?=
 =?utf-8?B?aG90RlZXTUJwS2Z2OEoxdStxdUc1Vk5JdStIMUl6cFhpbzZsc2hQdGNoYUpQ?=
 =?utf-8?B?MXd1aUxRWmdpMDJ5cVR3YW1KMGQ5RDlPU0ZldUJqK2YwaEowcWxVZmNRdkJh?=
 =?utf-8?B?eE9CNjNFUldhbGYrSzQzREdVUm40SlJTZlBQUEJJNG5wbTZKVDVTVWhtMEc3?=
 =?utf-8?B?cEM4b2NCQmgxUVlQOU1jZmtmMzhtb24zcmxiMW10K1o0OTBTZzhWMXprdDRz?=
 =?utf-8?B?WTBQOFRjb28vSTN3ek8ybHFva29iV2tPdVpldDFCYVlUQ2ZBQTk3cmM0cnBR?=
 =?utf-8?B?d0JOWWRpR2lVaXk4cEhuWDVUcWdXQ09scEpOWHFqT2ZDRGV6czZMMkZlZXlJ?=
 =?utf-8?B?QTZVMzFrV3FPWVI3RjhJNVVUOTFWVjZ2UnJBcGsyMS8veUJvcnlBQjVVQkEw?=
 =?utf-8?B?ZFFqN3JnRGVkbzdDK3ZtWXdDTmovWGhHWUJwaEpsMFRyNGRGNU5oaWZjZERq?=
 =?utf-8?B?SFpqN3Z1V2kwSlkyRTgrL2ZiRXNvaU13Z01aS0ZVdlRpbEFMUlpyMUI4clcx?=
 =?utf-8?B?dkZ3bVZyMHVpeE9kam94L0NwODlvaFR1NzNaRkhpSmkzY1djdHJGWDhUeEds?=
 =?utf-8?B?dFFxeEdWN3NMZEtpVzluZDhKZHlKRjdyTUNmcEFEUDJuQkFBOEV5cVFHczhs?=
 =?utf-8?B?M2grZFVpMjRtVWszWGpsNE12R2g2RUpTT3FlUVRXTDEzTldkZzdnMXpHZTVH?=
 =?utf-8?B?b1VpTVNobmtRaGNVVzloZGh1L1crK3J5UTdRMDlnVkpPR0NuY2lmUkhRalZu?=
 =?utf-8?B?cEVTQjJRT09hWFJob2l6cmo4cEpQSzlYbGtyOU1pU0s2ME50T2Q4bVNvelNY?=
 =?utf-8?B?dGtDZmlOeEYvQllTZWZ3MXhvcDFndlVPaGE1SDFWcjU5cjFnSFRGcUs2QnVZ?=
 =?utf-8?B?YTdpZ05mV0h2c1JOSDRvcUxMcXoxMW8rbUN0MDJuZHJrYm9sbUQ1UEdvaWJF?=
 =?utf-8?B?c3psby82anZrWlZGL3Z1SkVaeHhPSGR2dC94MC8yRVg4UkgwT3dHcnJmdjFQ?=
 =?utf-8?B?QVVneVJlTGd2RXMvR0tRT09iQ2JtQmF4Rk13ZVcxdmtJRFVoaG12cTVlSkJK?=
 =?utf-8?B?elJsbU1LNkdwdWozYzl3V3JOUzBJdm5RK3JJUFJMY2xOdTJBYzk1ZXdjQU40?=
 =?utf-8?B?NFJ4ODQwLzduSlhXNVY0SW81aktWankxVXE0cWJJQzVEV0Y0R3hrcGI1OWh4?=
 =?utf-8?B?WVFQbGpGZHA2djI0OC9qUHo5VUxRczc5Ris3QlJhMlVsMFpSK1U1SHFKQXdG?=
 =?utf-8?B?Zklaby9GYUhPYndkbTAzL0s2Y05UcXV4U0hoT1BpUkNGV2hlaDZtVUtqQXhK?=
 =?utf-8?B?TlEycmJ5c2k0S1I5UTFsU0RKMVk3eUczbmp2Q3Z2OEt4d3kyT1lqZFJVVkg1?=
 =?utf-8?Q?w388dUNn60npbb/nwLgP1YSNq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 572ba928-8c7f-4845-23f6-08ddeaa65eba
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 04:57:23.3218 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ot1+hSt5zbBa2ArH7dEwXdTpqyMVkqRbZYDTa4TaWL9ZJMA8txbMjFGfclzBUY43HLaO07CzY5BiJVGrA9brEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5902
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

On 8/31/2025 9:27 PM, Yifan Zhang wrote:
> Current mem limit check leaks some GTT memory (reserved_for_pt
> reserved_for_ras + adev->vram_pin_size) for small APUs.
> 
> Since carveout VRAM is tunable on APUs, there are three case
> regarding the carveout VRAM size relative to GTT:
> 
> 1. 0 < carveout < gtt
>     apu_prefer_gtt = true, is_app_apu = false
> 
> 2. carveout > gtt / 2
>     apu_prefer_gtt = false, is_app_apu = false
> 
> 3. 0 = carveout
>     apu_prefer_gtt = true, is_app_apu = true
> 
> It doesn't make sense to check below limitation in case 1
> (default case, small carveout) because the values in the below
> expression are mixed with carveout and gtt.
> 
> adev->kfd.vram_used[xcp_id] + vram_needed >
>      vram_size - reserved_for_pt - reserved_for_ras -
>      atomic64_read(&adev->vram_pin_size)
> 
> gtt: kfd.vram_used, vram_needed, vram_size
> carveout: reserved_for_pt, reserved_for_ras, adev->vram_pin_size
> 
> In case 1, vram allocation will go to gtt domain, skip vram check
> since ttm_mem_limit check already cover this allocation.
> 
> v2: simplify judgement logic (Mario)

You can strip the changelog from the commit message.

> 
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 44 ++++++++++++++-----
>   1 file changed, 32 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index d478acb4568a..c3b34a410375 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -213,19 +213,35 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>   	spin_lock(&kfd_mem_limit.mem_limit_lock);
>   
>   	if (kfd_mem_limit.system_mem_used + system_mem_needed >
> -	    kfd_mem_limit.max_system_mem_limit)
> +	    kfd_mem_limit.max_system_mem_limit) {
>   		pr_debug("Set no_system_mem_limit=1 if using shared memory\n");
> +		if (!no_system_mem_limit) {
> +			ret = -ENOMEM;
> +			goto release;
> +		}
> +	}
>   
> -	if ((kfd_mem_limit.system_mem_used + system_mem_needed >
> -	     kfd_mem_limit.max_system_mem_limit && !no_system_mem_limit) ||
> -	    (kfd_mem_limit.ttm_mem_used + ttm_mem_needed >
> -	     kfd_mem_limit.max_ttm_mem_limit) ||
> -	    (adev && xcp_id >= 0 && adev->kfd.vram_used[xcp_id] + vram_needed >
> -	     vram_size - reserved_for_pt - reserved_for_ras - atomic64_read(&adev->vram_pin_size))) {
> +	if (kfd_mem_limit.ttm_mem_used + ttm_mem_needed >
> +		kfd_mem_limit.max_ttm_mem_limit) {
>   		ret = -ENOMEM;
>   		goto release;
>   	}
>   
> +	/*if is_app_apu is false and apu_prefer_gtt is true, it is an APU with
> +	 * carve out < gtt. In that case, VRAM allocation will go to gtt domain, skip
> +	 * VRAM check since ttm_mem_limit check already cover this allocation
> +	 */
> +
> +	if (adev && xcp_id >= 0 && (!adev->apu_prefer_gtt || adev->gmc.is_app_apu)) {
> +		uint64_t vram_available =
> +			vram_size - reserved_for_pt - reserved_for_ras -
> +			atomic64_read(&adev->vram_pin_size);
> +		if (adev->kfd.vram_used[xcp_id] + vram_needed > vram_available) {
> +			ret = -ENOMEM;
> +			goto release;
> +		}
> +	}
> +
>   	/* Update memory accounting by decreasing available system
>   	 * memory, TTM memory and GPU memory as computed above
>   	 */
> @@ -1627,11 +1643,15 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev,
>   	uint64_t vram_available, system_mem_available, ttm_mem_available;
>   
>   	spin_lock(&kfd_mem_limit.mem_limit_lock);
> -	vram_available = KFD_XCP_MEMORY_SIZE(adev, xcp_id)
> -		- adev->kfd.vram_used_aligned[xcp_id]
> -		- atomic64_read(&adev->vram_pin_size)
> -		- reserved_for_pt
> -		- reserved_for_ras;
> +	if (adev->apu_prefer_gtt && !adev->gmc.is_app_apu)
> +		vram_available = KFD_XCP_MEMORY_SIZE(adev, xcp_id)
> +			- adev->kfd.vram_used_aligned[xcp_id];
> +	else
> +		vram_available = KFD_XCP_MEMORY_SIZE(adev, xcp_id)
> +			- adev->kfd.vram_used_aligned[xcp_id]
> +			- atomic64_read(&adev->vram_pin_size)
> +			- reserved_for_pt
> +			- reserved_for_ras;
>   
>   	if (adev->apu_prefer_gtt) {
>   		system_mem_available = no_system_mem_limit ?

