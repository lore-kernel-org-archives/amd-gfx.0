Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 668C1CCF9E3
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Nov 2025 16:25:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DB4E10E066;
	Mon, 10 Nov 2025 16:25:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iLrwmJ7C";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012057.outbound.protection.outlook.com
 [40.107.200.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DC9710E066
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Nov 2025 16:25:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lUg25yiB94XDuGmzpSzqDzNxQ+Z3HjCb3f7qcvBVM8tpR7PtX56EEwEH7icgg9I/VdgnLhmMmKBpANpKYhQ9WqdCvoF2xp1/HF6HHbOjtMDWOHHU8rslA7Tfop9kypDgBo0ee6llKPYrf/wZI2QF5PAcifnVUhXHJ7d88g+DAUIaYPlSFLd/hAGZ9jcb4rZbUrtjhZ6hdKoSaItm4OV+l7RXMolJEaga3xuC2AVcIbAdQz7C4DECwpzkXIM4/5rmfPRYrPsbJZbJk3q64DGNjtFDmxtoXgjIwD7yXVUL5O55tNzMzFc1UjA1vv8ZREOBMTBjElKRQ5ugXl/uM3V1qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5JAT32mFppoKKyNIWfweXJYUEJOhu21oWwjNeF/Ru4c=;
 b=AwhIiJDm2XwaDuv+I72UcOefvc88xzSX4fjzDM11S7C3jF6mJheH7LtSfXqeYoIYiKumRfMIRCCCuknfPvAb+HcLxe165SehNQJYUeSyTT0JhuYOiTMrbMNS9ZepecfCzV8B/ba0QeBNC569y9xBm/6KvbEeduwGoMd/T528md9W+oRzZz02waisJkJ8jLE+/xBpx/W4qQefWCxIWKJYbNqvtjDlnadMD/xzkPzjB6Lz2IWYTTXJO8mdBy3O1h37qOieo0MZhYzIWZiT2p1+jlVLi8Bej2dWajAaEr0wRxfObkM9dChZgcbjzNV0+pQX1WyVsxx/hi4z9hngz/vbQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JAT32mFppoKKyNIWfweXJYUEJOhu21oWwjNeF/Ru4c=;
 b=iLrwmJ7CdgulHeT9GaXrJbyrNWPZKaSeBEuRKY5rR3SVFA4nHvgesD4LcIETTu1G44u6eAAhlzxoiW0ykvpoDiibTQdc1joNEh/W+8W7pfGi6qSQjbwRF8KrucBXqT7nyITIgpI1VoH0KXPpOG5eFGHRvjxt2JwcP3xSOjhWuTk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB6037.namprd12.prod.outlook.com (2603:10b6:8:b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 16:25:09 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 16:25:09 +0000
Message-ID: <f0e69b99-ff5f-4208-9056-7e22d9e0a687@amd.com>
Date: Mon, 10 Nov 2025 11:25:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdkfd: Fix GPU mappings for APU after prefetch
To: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Philip Yang <Philip.Yang@amd.com>
References: <20251105225128.3182714-1-Harish.Kasiviswanathan@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20251105225128.3182714-1-Harish.Kasiviswanathan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0068.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::26) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB6037:EE_
X-MS-Office365-Filtering-Correlation-Id: 209b6b55-3b6a-44ec-36b5-08de2075b72f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MUNhdjVNeTRJQmxDK0pkNW5ISjRkYXhLYkJYNmFCNDNhZENGdnRuL2NrYW84?=
 =?utf-8?B?NjcrblRnRFd1MXhxMXVyQXZBV3pjblVzMmlubWV3S1lKcFZEdzFYLy9qWWRW?=
 =?utf-8?B?MDN4VytaZ0NENmpSMlFWMFZTVnNNdzZ5OEswNlpMWmI2ekRtQklwY0p0cDAw?=
 =?utf-8?B?MEd4MUt1NG40aXhqLzQ1d2lIUzBwWVp4RHFjZmJLN21iTVFqdFNpaTVPdUNh?=
 =?utf-8?B?Q1pza3BPL3UzT3VUV2wzeUFuSisrZ1dFcVlsN2RmSGxpK1NrZkdnZkNlVUdF?=
 =?utf-8?B?NGhTU2REenZGZVptWGxFWmlNempqbmdCUDh3aXpxSWlMYktFNndhQmpHMWg5?=
 =?utf-8?B?ck1Ya2lFdFFsNlhDUHZUQmRjRGtsWEhCQXQ5ZmVQdzhMRllUMWVkelNVbGo3?=
 =?utf-8?B?TnMzcUE4K3ZFN2w5eVorbi9BUDA3L3RIVFVQazA2TmhkNmVNTExVcllHM1Z4?=
 =?utf-8?B?U1duZU1xb0JBWHU4RkJ6d2k4ejROdU5BQnlaa3RlRXhqdC9UaGgreGcwZWtU?=
 =?utf-8?B?L0p1U3dZeHdSb0M4ZzRDRkQvcFdGZjZOZ3M1NkpqK3BqSFJsVjNhMmE5ZHJq?=
 =?utf-8?B?K2YxUVJ1MEpUNHdvcUlIZnhaUDlNVTAyMGtJaDVMa1h2TFF3ZEdVQ1l5TXh0?=
 =?utf-8?B?RTZjYWQ3WTdjMXVROVpxdlovZ0pSUk5XMVh0YTRnRGpRcHZ5elQwaHc0SmpW?=
 =?utf-8?B?MnVtM1dFdjc1SnFUSFNjRUMycXN1V0dCcDBvVm1jMmVDaVhMd3V1N2R5QkVB?=
 =?utf-8?B?R3ArSmRqdnNYMDZpRDNCbkhRcHhwLy9YSGFESGJJS1EwNVJwMitIM0M2TFB2?=
 =?utf-8?B?cytKdWs3a3k4Nlpibmp3Ti9xN3RrQm1KMnozM3Q4eTNYd0VpRm1PRENSM0ht?=
 =?utf-8?B?N1pYcGRFbkxla28rdDFicGNVaWRsTGNQd2libmF0aG9aWXROdEljallTWEJP?=
 =?utf-8?B?UC9jYmFYTnBwUExaY2IvV0NBYlEyK3RvNnNMa3ZPU3NtMFExbHZiUytYVzk2?=
 =?utf-8?B?eVlxV093K0ZVbVFPYVVIaHdmU21TNHpsOUhCMU84bzU0MTFmaDRVSVNUWVgy?=
 =?utf-8?B?MDB3K0p0Y3VzMzNvR3RUbWhtb1pQNzVlSFRkZDM5cEhEUTJ6dHdXVEtoYjM1?=
 =?utf-8?B?ck1DeExhdjhjenJERzljT3hiZ3I5OHhiMHFJclFqODdteGtxWmppNmxBK3dV?=
 =?utf-8?B?aGdBaHlnNnZ3NTVhQnZXYzZpbDI3bG4yM2hrMmFDeGZua3JDVTdiTkpJNk42?=
 =?utf-8?B?QjJzNTNISk9GUUlUVTlaTHNUWE9oTjFJbDRLRVV2eFcyQTE4eXpWRjJiRWox?=
 =?utf-8?B?SllzLzdkS3ZpYVp0SnRCamd2cUd4R0xZUU5IZjNFNWp0eUl0clZlTnZSVVdw?=
 =?utf-8?B?elIwWTF4VjFLbVhnaFo5UFFYbkc3NGxia2hieVVtbXpwR3grZEs1cDVvMzVH?=
 =?utf-8?B?N1pVUEtRcktnYmNqdGwvUEdIcFpXUlNIRm1Jc0kvZnRZWEdzQ3pMa0oyb0U0?=
 =?utf-8?B?TWJMdHZPaDRFTHgwK203VTdsREg5TjM3NEVYWVVWeHBIejc2UXVTd3dBallv?=
 =?utf-8?B?M1NOb0pSdFFXZXB5ZFZCNTI1a2NBdFdvQnBpNVlPNnBQcFgxeTBTU2l5MWpH?=
 =?utf-8?B?NUoyTXdiL25tYWQxVTNtODZHclc3UTVycHAzY1RCQ0VoTjNVU29paFhBU1Fp?=
 =?utf-8?B?bHlxOXkvUmhCekRaUTFaelh2VkhtVWE3RlJkVWlSSDFaQnR4c3ZYUU90Ny9a?=
 =?utf-8?B?RzcrOGUrZnB6ZUxPY2ExeEYrZXkxaG1zYnhVdEt0STUvMDlMemdvQS9sVTdU?=
 =?utf-8?B?V0ZuQm92bjQ1bm5qRE9zQnJCS3Faa0xJbEdkcHVBMUpUVWFMN3VNYVZBd3Fm?=
 =?utf-8?B?cGhoNjFrWFNpVnBaYXdOcVVYc2JRMmx1M0N0OGM1SGZCM09KQ2xTcWF2MDVa?=
 =?utf-8?Q?7HoQTaMb6s0LS8QSbZkyESWpudYLJOy+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmxobUd4M1ZlQmpKajZ3VmJGYiszMDhkaUpydXA1bE9nOHhKbnE1Y2NCNzJT?=
 =?utf-8?B?ekdsMjVoMU5zK21JWWo3NmxLVTRRMCs1aWJKUGFndW81TlJxWllqYjg3S2FE?=
 =?utf-8?B?Um95N2NCK3A4MTk1a1hRK2VyZ0h2anRRSS9TdnQrYkNycUJzalNuYTNXamZq?=
 =?utf-8?B?Vnd0c2xxSGVsV3c2V3ROL2NFSlZiNVZ6Qk1weXpabDIxUGZJY0cvZHc4dml2?=
 =?utf-8?B?V1ViaU5OaXk4NjFmQkhKOUdTa1R1YURodG9CTDR2a1ZrdTRXbEFxNnF6WTBn?=
 =?utf-8?B?NjZmNFJxSWltSGxDbGtvdWhmMzQwanVvc2RiUjJkaFU4ejJ0MjFtZjVCbG43?=
 =?utf-8?B?bHU5clRGQ0VJK1VjUG9XbFhTYWNzbkRtWGl5VS9MaEFKMEtiQmtyaGlGOHdQ?=
 =?utf-8?B?WXBoREJkeXNXNnpsaS9MZzBnK2xhTVZRWk1acHBMaThNQklJaEtMTW9sSU1I?=
 =?utf-8?B?cjlVcGtLOTJJQ1pFN3grS2xKd1k2SE9DSlhVSVhGNjdGQ3NUVGVEUVdHT1I1?=
 =?utf-8?B?SVRwSVdLN2hlV1RRRDNJZklkaU5mMXllend3ZUU5enNkNHVXYzVkUmhTb2xM?=
 =?utf-8?B?bjNjZ3dzVkVxRnNMN0hIYzNUZ0FrU1hYUUhBUjQ0SEd6VExsUG5LZ0JTTktp?=
 =?utf-8?B?akNUMmI4VWxINmdYc21CTjlCYW9iMXFScUIxTEZXY3NkdkZEV0h2dnFrQmxu?=
 =?utf-8?B?bTB0dThhY0tDZlZxTHM0TGZHQjNIaUJHQlgwVEkrbGI2WXpYNEhQOW01a0F2?=
 =?utf-8?B?NVFiYng0M3BGWUJhZ2hsWWM5RUlVOWVYTmpFbG5sMUd6dm84WVpwQTU1cDhH?=
 =?utf-8?B?bGVudUlMRktpT0l2YjNhbWk3V2ptNDhkaG1UbEQxVm8wVWFPd3Y1QTJTNmtk?=
 =?utf-8?B?TVhuMnEzb1h5RW5FL0gxdlU5bzNLdHVEUHZVMklEaGsrY29DU0NGeEEzZGRF?=
 =?utf-8?B?aGxnUktmYm83MFV0S2FvU1kwSkN2MlRlV0pMbGV0QUlSQjFsSjF4cHZxZmR1?=
 =?utf-8?B?aTZMQlVya1gvSi85eklrS0x6T0g2aUM0bGhyNjhLSDR5dGxZUGRYU3lsUXNF?=
 =?utf-8?B?TmRIWCs3V2hxUzRKRFMvQUdtaDc3YkpWRzBYZVdHc2MrMXVsTyswblQ0YUFo?=
 =?utf-8?B?VnE0aHJMVGpyMTM4N1ovWjFHNFBtUDF3ZWRKY1IrOW5FUlVDdTRxUUFQTmc3?=
 =?utf-8?B?dXJ5VjJDcElTNWJhclN3cFdINHVGckR1UnI3K2JDZXlUQ2NmK3k4UVNvNXpz?=
 =?utf-8?B?VnBON3ZENW5laXpITWRJSXIydUp0dTREenZOU2tGSVR6ektLYnVNU3ExZjRB?=
 =?utf-8?B?QXVDdjlNNHlZR0dORzFITEtMSll3Z3YrNGJBckZ1TEJ4bkJQNkt1S2ZtY0Fo?=
 =?utf-8?B?QjRMS1N6RTBrYWlhYlRicG5xTjE2S2xXYk9TeHJmaS9XMytDQjNEekNEQzh1?=
 =?utf-8?B?a0F6d1hUanJRQVVsUTNIeFZVTGdnWUtwZVZhV24zVVdaZ0pVMHpHSjRXMzN2?=
 =?utf-8?B?QUxzZ090K3hhY24zZGNKcVRoeUFvT2RCYmFYZW10WWs4Mm9reFVLNUZhSS96?=
 =?utf-8?B?NEpIYzFRbmtYVFd5ejlJdEhmRFNTYVpRampIYnBUdmNYbEpVL2FCZTI2K0pB?=
 =?utf-8?B?bzduNzBtOUJhVFN2US9ud1B1eWR5ZitiSWV5b2VBSkZJNU5VLzNPU2RIL2d4?=
 =?utf-8?B?Y0pPTDlNYzFQeVQ3b2xWUG5MRGNFNlFUZzcySkgyUzBoeVRLRlkxY21EaXBS?=
 =?utf-8?B?b3pIUHpHQ2hJLzNja09XdUsyTDZ5T1NONFVYYThwb0s4MkdWaUlPVTZwU05y?=
 =?utf-8?B?cTd0Mkx4Smt6QTJjNVltQ3RiTWtnSEs0T3lqVUlpOVN3dGFaanNHUzZQQ0tq?=
 =?utf-8?B?MU1sTU5mQ2ZmdmNRSFlUN2FMQXp4OHdjKzl4SytTbWVtaVRwVk9TbmxNZ05Z?=
 =?utf-8?B?OXlHR1RFL3dOd3ZlM2dXSCt3WTNIUnlEMkJ3WGJZWkZvNEVaWWxNZkhRMlBS?=
 =?utf-8?B?dUxPOUpUdzRsMTNINlhGQmlGZjFYSHdiRnZPWjRpQkZ3Q2k3U25rUUt0MGVi?=
 =?utf-8?B?VzhrUEltVEc0ak1jcE5paTdsOXp6N1V0ZDZhbDFEZThqNUxHajFtSS83Q1Qw?=
 =?utf-8?Q?wAL+5iuhhOASN4j9BMQAN5pDK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 209b6b55-3b6a-44ec-36b5-08de2075b72f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 16:25:09.2078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hEwE2TZ6TgfuQV2Gh6gUAIB3OYyRyOeKZq3O0Bg+fvzuOOEl5vW9vXQblHh/RZS6IyAOfyQwETA5QYdiCd56Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6037
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

On 2025-11-05 17:51, Harish Kasiviswanathan wrote:
> Fix the following corner case:-
>   Consider a 2M huge page SVM allocation, followed by prefetch call for
> the first 4K page. The whole range is initially mapped with single PTE.
> After the prefetch, this range gets split to first page + rest of the
> pages. Currently, the first page mapping is not updated on MI300A (APU)
> since page hasn't migrated. However, after range split PTE mapping it not
> valid.
>
> Fix this by forcing page table update for the whole range when prefetch
> is called.  Calling prefetch on APU doesn't improve performance. If all
> it deteriotes. However, functionality has to be supported.
>
> v2: Use apu_prefer_gtt as this issue doesn't apply to APUs with carveout
> VRAM
>
> v3: Simplify by setting the flag for all ASICs as it doesn't affect dGPU
>
> v4: Remove v2 and v3 changes. Force update_mapping when range is split
> at a size that is not aligned to prange granularity
>
> Suggested-by: Philip Yang <Philip.Yang@amd.com>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> Reviewed-by: Philip Yang<Philip.Yang@amd.com>

In case you haven't submitted this yet, it's also

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index c30dfb8ec236..97c2270f278f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -3693,6 +3693,8 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   		svm_range_apply_attrs(p, prange, nattr, attrs, &update_mapping);
>   		/* TODO: unmap ranges from GPU that lost access */
>   	}
> +	update_mapping |= !p->xnack_enabled && !list_empty(&remap_list);
> +
>   	list_for_each_entry_safe(prange, next, &remove_list, update_list) {
>   		pr_debug("unlink old 0x%p prange 0x%p [0x%lx 0x%lx]\n",
>   			 prange->svms, prange, prange->start,
