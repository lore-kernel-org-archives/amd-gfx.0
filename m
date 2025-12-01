Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1293D116E2
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 08:27:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4961410E2DC;
	Mon,  1 Dec 2025 08:27:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RIlDe/RU";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012063.outbound.protection.outlook.com
 [40.93.195.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3943E10E2DC
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 08:27:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pbt3eVhUOiaXXJgyUQ6ks+mW6xWemgal67H4lAIoJ/BWGL66HtUJqdaxh2F1pvrC6IS89p2C8Ceilf4HcIfMZZChwIo+/tLDVzttAik1JY+qXDSr9aBle22wLB1+/Q2zLema8Tt/uPCgyp3w/pw9L8vIL0R8bgcSUcCCwEeu1rp4r0smJAUKHAEKFh7WMzdHhHJXzAk/NtNfnOoCWg2OgziP6Kz7VGwy5Bl/GGzsjyRWjebF3pT8CjJ+Tq55nOq7/iohMRj1e/9xIil8jMf4T3j+X9I37IVC4QttNvp+M+gIr2q1w2+KVlEkvzosS9pq3dEeA4jbfNfvBMkkdVubKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJS1N3SIVEtpKE2N8RfZ/dtBjlJo3KBMAKCWP+mp8BE=;
 b=w+wljcTh9ezwKq1I5cdwgG9y5Ta0KnGWdROS3g9Y9julpqGbUSxXPm8KayRhad9jmFmL3/YRl07e2UkFjZ78Z83l3IYNJ6hntc4uzermBSAYF2fEX4XWbJooQHl4sYP8dkJeiynMdE2LyRC16odFsbtUBnZmddxEas090sghzyHnmvAsSFAk1bKE71TblKNmR4NPVrIFxjxbX2QIgh9+5aM113BRJrcPwkzHllrVKz3qM8rc94tn9MQskCzfbKVr35R7OJRsFHSAzax0AkoK8vkNiYQAWZQrCBZt+quDMieFDdMGZZ+wxcjX5uaQYvu2rvW2fk2JtR1O/JC7l7iV5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJS1N3SIVEtpKE2N8RfZ/dtBjlJo3KBMAKCWP+mp8BE=;
 b=RIlDe/RUyiDI2bt77vB+iZmQRpA1vJn1GtEwcZGPEPTyVQ3spCaBUO/5WEBAMpwvyT/JDWf5OJEWG0GDUCCC30E68iW5EKiKYNLDxNqH5oEUMBlyk5PZJR+tYM2EVkv0pRl6qxhbVYzSZaVUt9Nbb5tnO4iNuXJnd/NM8/2+H4A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CYYPR12MB8990.namprd12.prod.outlook.com (2603:10b6:930:ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 08:27:54 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 08:27:54 +0000
Message-ID: <eef300e9-9368-43db-b148-f31453031f88@amd.com>
Date: Mon, 1 Dec 2025 09:27:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Allow direct CPU drawing of DRM panic on APUs
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>,
 Melissa Wen <mwen@igalia.com>, Rodrigo Siqueira <siqueira@igalia.com>
References: <20251128150814.11612-1-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251128150814.11612-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0322.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CYYPR12MB8990:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fe69ffe-e952-4a0b-051d-08de30b3861f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MmhPeFp3ZWIySEhWWlZKa1A0bG5DYzlVWmNEYkpWNVJhQTBsSG1WbWIydTcy?=
 =?utf-8?B?ZjQ2T0p4SGY1SmlCalBXQmhqN1lxSVYwOXpNd3g4bktaNTFqMkZSai9tMUo2?=
 =?utf-8?B?bFBlRU9kOUtuY2xlUTlOQ2RBYjhReVp6VHRlcHNVTHQxSExmMzZmT0p6TVoy?=
 =?utf-8?B?QzJRcnNxcU1kSXBhc0pNcFJQbzN2Vm1icWI0STg5b25ZVEcwTXhyM0xRN2Za?=
 =?utf-8?B?WEcxL3FKa25DT3k0R0M2eFZ5NHY1a1VQcExzYit4ZHY4eGFHWlQ1aVA3SGM1?=
 =?utf-8?B?MGx4czgxWjNISCtDQ3pHdHQ5NVdQbVdjN0oyZWpXckE1c0kwenNTS25aNzhy?=
 =?utf-8?B?eEE5aEtXN0JoUUtndy9XZjhDOUhiSnlXSzZpTW0yYWRGSGFPdmlOT2VlSDVD?=
 =?utf-8?B?WFY3R21XV0VBYXFmN0NaT2NxclpzbWlIL3hUakxzVHN2QjB3UXBMdlEzMjBm?=
 =?utf-8?B?eEJvY1hYS3VHTTZPcDFwUG5RQ0RRWHA4RXJ6TEczdHpydUJOeDJGV3NtNzM3?=
 =?utf-8?B?WHZ1VDlqUlNUdzV3WGV1VzJPOUQ2ckVGd0dTQkF5Ni8wZnArOWFOdE9zZ0FG?=
 =?utf-8?B?cERHMU5hYUc2VWFXNXFzTCtyZmx5ZlFlV1hWd2pKLzYzdU9YekcvUkwwbFBT?=
 =?utf-8?B?QmM5SzA5Vys2TnVCUWk1b0JGUUhFcHNnUTBNZ3pwb1lreVRTVTNZREg5V0hu?=
 =?utf-8?B?Q2xnME5wMU42Z1FzWDk3c24vZmhBUE5aTXJTMVRySXJNQTFHRlpkSDBKME02?=
 =?utf-8?B?VFZRbUQ1MnBpWkMzQTliVEtIdjZ4SFRDYWZiUXRZUzh6WHhTcXg5dFFTMnR1?=
 =?utf-8?B?MFR0QkFDTXY0TFhPQ1pVQmdSZXVLMldPeng0c25ZWHlSODRuS1YwSCszWnIw?=
 =?utf-8?B?bTFuZUZkOHFTZ3NCVWcxZVJBVEkwUnA5MVNrMWVPcXR0RkxDWkFWNlE0T0lI?=
 =?utf-8?B?T2JlWS9OdjBGR0FCbVZaVmZwV2drN0RkTjZkTTZFYTROV3VqS0xTbEkzbnRI?=
 =?utf-8?B?M3FKd3RydFZkTjJQcjBsbVUzSlBTamlqYkwrcTIyNURXbFZIMmdtbkZjN0l4?=
 =?utf-8?B?QjNyQjJIVjByc1dsSEJxclhCemZFWUEwR3hBdEJsTWdkV2lnbDJPS2VZSS9E?=
 =?utf-8?B?SzllL1BCVjg2c2wwUERrWktRcmNUL09GRFYvZFR4REVGR3o1Y3phaVYwZHRn?=
 =?utf-8?B?TmgzRCs2N3NVK2VPSTVFWVVBcEdDNzRjU1o1M2g1TkRiNGdoYVdnaUNDN0VZ?=
 =?utf-8?B?WHN1U1pPTzJrVUgyNXk3VTZOc0YxK29zN0RTYkdJcmdGbWtpeEdFZ1UyNG14?=
 =?utf-8?B?Sys4RGx5OW41Ni82amVDZVZzNkVibjd4bnoxUXJTOXhZckI5dG55S0dJVTdo?=
 =?utf-8?B?cFRxcVZpZC9TdzVnYURLOUJSVzUvYW93T29KVCsyd3VMSUkySUExL3RGT2pU?=
 =?utf-8?B?TllOQ2FUcVQxYThrNUlpOU5xbGJBcmR4b2dvMjhUaXF2emhjZVF5NmsvODdG?=
 =?utf-8?B?bGlCK2ZkeGcwL0cwMEs3dk5EMEp6VjFvWU1uK3Y3RWhCYkNKcWo0SVpQZys2?=
 =?utf-8?B?azduRjhNMUtOOFI2T2t6LzJ0QWtYQ1AwNHA1NGZ0dkYzaW5FNnFSa1BUWXov?=
 =?utf-8?B?cmV5UXV2ZndNQ1JoNlVmQ3hzdnZyVUFwMUN6WXZtaWUrZ3JwYk80NmdYb0d2?=
 =?utf-8?B?Wm1SNWZRYlM5Qk1JMmdUUXV6Z084ZE9vcmtGSE42R1cvaktpWGtON29ZUkxL?=
 =?utf-8?B?Q0c3VkUwemNVZit5UFJUckRXWDZQYVVtOXZOZEt4SmQvbGF1bG93aFZ1NVF6?=
 =?utf-8?B?SWhPcWdydDFpazZQMjB1endQQk5LdXU1VTZQWU5jSHJOZ3RIOE1QLzRUVDZp?=
 =?utf-8?B?a1F5YW04M3UvdVVqenh5c3lZOFVkc0ZoZWdhSUEwemV5SEFXV0QrcUpDYkxh?=
 =?utf-8?Q?Ysu2GE/WYdDpOuvB/Kee7GjhmG7r0qSJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUIwdXRsbkR5WElCYldiRzJvdWpaSUY3eUw1ZWtTTE1qZnRDR0QwbGlIZWpH?=
 =?utf-8?B?YnRkYXVCcFNFem03cTB6TDZVektxYTRJSjBkMHphdE82S3U3QVZ3aVcrK095?=
 =?utf-8?B?Mm8xNmJ2cHNWRlJUdDlXRHBXQkEzaHp0TDJCbjQyeUpCKzAwQ0tYSDJyd2lh?=
 =?utf-8?B?dkZvNmswcVFJSjQ5Zmt4aGxjVnI5Wnk0WGFud0ZwWlo5T2c1Z3lTeGpocStx?=
 =?utf-8?B?OWRRQ1J0Q05rMHcvOVp0N1hCNnFwVFR6MURzd2pEZG5lam1CR0xYNW5RZUtp?=
 =?utf-8?B?c0J3UldKVnlQU2g5TkNxenREcEtaYk5ySG9abHVWdDQzTEhaOUZCVFI0SUZq?=
 =?utf-8?B?SFR6cEQ5VGU0Zk9sQ0RKU1BTTGxtcmN6bnJqTFN5UWk2ajhyMHRPcTNoeGUz?=
 =?utf-8?B?QlRESHFKdnBmWit3bC84SWNrRVdHT01EZkZFemtPMEpqaDJ1Y1k2bUpyZmht?=
 =?utf-8?B?RnJsOHBhRnpNU2E4OGtmcEs0TmkyemdYSU9XQ1AwbnVmRFlDdWFhWVJtWUhK?=
 =?utf-8?B?RnlZMGNFdElmUkM4em84UzlGa3hYTmZnZXVpYmx0SnpZT1hMWjY1YjFXeDRG?=
 =?utf-8?B?S2VJcUwvZWtPUHVPZGI2cjNZUlR5Vy9zckN2NS8zME9HcGh2U3RKeU1XWXh0?=
 =?utf-8?B?RnpsbXhBb0xQUzhtb1ZhcnBQcnZBQlFPQTErdHlzeTRkdEV2bnRvNE5lc3lp?=
 =?utf-8?B?S3NZOTJpazB1R2VaaHlhb3d4QlhxbllSVUtJT05NZXRnekFNeUJSU3oxNzFw?=
 =?utf-8?B?enlrT0ZFdVlRRkg3TGxnZ1RyMmFneXdPYUo2azhpMVltUmNubytCR3pDWUxz?=
 =?utf-8?B?ZVU5bjR2YzhiN21Bc2xBVjkwdnJhRkJGWXdoZkgrOVhlM0Z2Z0xhVmtGWEVi?=
 =?utf-8?B?YjF3RzZFazBrQjkvQTVNYXQ2bHR2MjhuMVB2Wjg4Y2M3cUYrWGVoVkxreFcx?=
 =?utf-8?B?Rld2Wlk1STFKd0ljQ2Fub3hhdkxtVFB2U3NhOFI0Nlpadi9INVhiM1VYSGRK?=
 =?utf-8?B?VzdzQWhmM205ZEFZTEhQSHA3RWsrTjVNSndUK2YydktDS2MwRlFBeUJYSG54?=
 =?utf-8?B?cmE4aHB4RmlYYXpYaVVNc2g0RWlOalhzanBmWmg5dDlCcEE3MjdaaEtDRkpC?=
 =?utf-8?B?MmM4UDB3Yjk1Q1ZoUEpnc0hkSTV1SURsQ0JXRzhjdUdRaE8xTzRqRHdLQUZq?=
 =?utf-8?B?SHlGNndHblJ6SEIyWDhCNEpIYXhTczlZUmpBS243OWZYZVhVRGtuTW1TYk5F?=
 =?utf-8?B?U2VJa1Y4K2EveHZ4d2VsRm9MMVRnSUwyR3pDNTdOWW5iajR1eEI1ZkZmdSs0?=
 =?utf-8?B?U0VzYXRZS244ak15NFNBZG80eFlvcmZseGhZZ3pPNVlzZjkwZ01BTy9hVDIr?=
 =?utf-8?B?WjBzeERPcXpBcXFYZG85NUw1T1doQUxrcStsQWtLN25paEZYNkJZY2haSmd3?=
 =?utf-8?B?RkdOZ2VtanZrNGNaZlEwcGRXNDNMRHRFSHltaE1GcVlDMmVsNHBqdVY3ZWph?=
 =?utf-8?B?dGEvVkwrMXdub2dvdDNLRWxYRUpIZi9oY3RaRzNTUnVlTlV3L2hHcjkyQ29r?=
 =?utf-8?B?eWlSZHY2MnNJcmV3QTFpOWFXTmk4SHp5ZjJKYWxJM3h5cVo5OTdBcTNmemw3?=
 =?utf-8?B?WHhibEhLUVhZRDU0ejlCUnQ5SERoeGt6WTY3T1Q4WVozRWxnNnVKdlRQK2Nr?=
 =?utf-8?B?OUZxQXhwNnZ1ZnhwbmVDbTM2aHVqdGRFaXNuYzZKNVR6cVptOUNSajV5UUJF?=
 =?utf-8?B?Zm9sYzdubDgyUVhheEN1QTc5NlNLWC9RM2lCQmJRMEsxL3BzeFhXL0JaZ3Er?=
 =?utf-8?B?Yk8wSkVkbktSRkNhN0FkN1dOQUNzU2NHWWFtSk54YWJCVkZZRXE4d3Y0T2oy?=
 =?utf-8?B?d1RIaFhCY1Q1MXhyRzVEZHFVTC8rb2lDcFp5YzJhT3E4ODFrSkVZbGE5Wlhl?=
 =?utf-8?B?ZFkrcWdkaUVLSDlTSWk5NHhIRVlOcHcyZ2ZuWW8yM25vclR3M2wzYzRyZGdZ?=
 =?utf-8?B?TVRUaG1ROUNOOXhTaENRdEphNU1SazFNWDBuM2FMSHJSaGFwRlRSK1B2QzhQ?=
 =?utf-8?B?aXE4VWdxa29mTTdrakkxRU5vNytTd0lNdjhheXRxQzF3c0ZLQS9Kd3ZmZWJD?=
 =?utf-8?Q?BJPc5yxmwq5BfaOScVDQeMdBo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe69ffe-e952-4a0b-051d-08de30b3861f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 08:27:54.2436 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I6Gg3eZNaGtPQODsHXPgMQ8HbNfdKAgKTFAZqiy5iFYtkABH8gp7yPdRHDuBT6/B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8990
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

On 11/28/25 16:08, Tvrtko Ursulin wrote:
> There is no need to draw the panic screen via the slow MMIO access on
> APUs, since the frame buffer is guaranteed to be CPU accessible.

Well that is actually not correct. It is only guaranteed to be CPU accessible on 64bit kernels!

I suggest to use the appropriate test function to see if a BO is fully CPU accessible or not and just drop the check for the AMDGPU_GEM_CREATE_NO_CPU_ACCESS flag.

BTW: It is perfectly normal for the framebuffer to not be in VRAM on APUs! So the check below is broken as well.

Regards,
Christian.

> 
> Lets skip setting the .set_pixel method which allows the DRM panic core to
> just work and it renders much more quickly.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: Melissa Wen <mwen@igalia.com>
> Cc: Rodrigo Siqueira <siqueira@igalia.com>
> ---
> FWIW this draws the panic faster, but.. the whole DRM panic setup only
> appears to work with non-tiled modes. There is something broken in the 
> dcn10_reset_surface_dcc_and_tiling() code with "more advanced" modes
> where thing the turning off compression seems to trigger some weird
> display engine behaviour. (On the Steam Deck at least.)
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index b5d34797d606..7f75f1319d3f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -1900,7 +1900,8 @@ int amdgpu_display_get_scanout_buffer(struct drm_plane *plane,
>  
>  	sb->pitch[0] = fb->pitches[0];
>  
> -	if (abo->flags & AMDGPU_GEM_CREATE_NO_CPU_ACCESS) {
> +	if (!(amdgpu_ttm_adev(abo->tbo.bdev)->flags & AMD_IS_APU) &&
> +	    (abo->flags & AMDGPU_GEM_CREATE_NO_CPU_ACCESS)) {
>  		if (abo->tbo.resource->mem_type != TTM_PL_VRAM) {
>  			drm_warn(plane->dev, "amdgpu panic, framebuffer not in VRAM\n");
>  			return -EINVAL;

