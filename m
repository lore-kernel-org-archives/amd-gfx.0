Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFED2C8303C
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 12:14:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78C9910E283;
	Fri, 11 Jul 2025 12:14:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vjuzQRPz";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8389410E283
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 12:14:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJhChYkWvSCiZkGA9RFxWU9scQw339r40J+bJikk19hrIOJBP4iG5U7r6i5s343C+WiqeSxQsYeqCzD3ioJ9RwzpL2Jyw9fWollhIuaEYzj63lt/m522CuFZLw7qCAhEMoE04Wex2sugycdMM0ikLMbSAa9nCKelB/J7kfIpN8kSz1r2j67vXddNAeYHf+Ukqtc+zFJVpno+gIpdP2XNnnenyyKAllcg3y6ESmwE8alQfTVSFVJ2mCLxSr0qd9oI29foxa5LUmH/2LuQK3lg6PlXl4c6GDdy/Ge5Nm68gFcRHPer1+gMacKOFyH9r2ieLVbs3gTujFjUSQb2/Zo+1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0STg3hj3t8BLiHWjhtSI/+JzJFlHN0VWodXyr90MnYo=;
 b=bGAnM0i5vDd9wvrPL39m8TLK9BPuc07noBPMQn4xEwFUdqrf0Kt+E6FeG07DQ2bXhYoxGcSw9KnTazqa67N8n0d8+pjlLRHXW5r0zA7Ms7qykhwphSHXvtA4en2SP7to9g6RinHdwqUA41WPmC3BSCPUNgTZWY8ll9hhpQuIgqtTx/ozY77aocI3kd5y+stw3GEgg7jcVhMf8GcVG+cynLJr0COmd05UF6HACut0uAVQJE5H/1Lnv3GkGXHD838sUckUIANbUHjwzaoCq5dIhElNl14CmWsOektR49Pw8+CQtj4Qy3C63rrX7msybENWw0jtQgjVhC17kfOp//pHNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0STg3hj3t8BLiHWjhtSI/+JzJFlHN0VWodXyr90MnYo=;
 b=vjuzQRPzMCPAEie7DCHb4+1WRk3l8ja8a+E1klW1ema6458gCAiftNYQ06VWOx9e5XkXlZS4rcggBeJLLF56uZuk6OwKNlpYr1cBL64aTqySwjbeOUXUCly8BSQQ2JB0fi16hs5BrMQXk22oeuzD1A/tDEuRQ5vwo5mDm8oQJ/k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV8PR12MB9617.namprd12.prod.outlook.com (2603:10b6:408:2a0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 12:14:29 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 12:14:29 +0000
Message-ID: <efff0172-7df4-4da9-a03d-2041990bb7e9@amd.com>
Date: Fri, 11 Jul 2025 14:14:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/11] drm/amdgpu: validate the shared bo for tracking
 usage size
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250711093930.1411470-1-Prike.Liang@amd.com>
 <20250711093930.1411470-9-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250711093930.1411470-9-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR0102CA0002.prod.exchangelabs.com
 (2603:10b6:207:18::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV8PR12MB9617:EE_
X-MS-Office365-Filtering-Correlation-Id: adba7f26-dff4-4c0c-8a37-08ddc0747c9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aDBXWTNxUUwrdFBZaDJEa2EzVXdDWDhUQlBjbFlUUHJ0U3RUUnZCNlhvUkFZ?=
 =?utf-8?B?dGFueHZVWjBQWENFcGR1bWRPQWF5eURoeTRxbUhVU2llM2c5Snk3Vk1waG00?=
 =?utf-8?B?V3kwM1ZHODFPYi9vakxrN29qSWxOVFBwME9WUjVXNGVteUM3S0EvaWlNTHR1?=
 =?utf-8?B?RFJaSlJSeDJXWXhhdDAvWnhGdXJyMC9xYkRhaGt1WXFwWGZOWlpQWWlYSTVt?=
 =?utf-8?B?bjJtT3B2c3g4cDFGbUR4UVhoaFVJcFd2c0w4V0dSU0VSOU5TWFBYNkQ5ZWxU?=
 =?utf-8?B?M0QwNEtJSlowVWNsWDN5S3Jmdkt6ZGNCM3cwSVpOTTlZV1c1NWZFVENsbmJz?=
 =?utf-8?B?WDNwNytVTU1TYnI5YUxHeWRMTFZRWVJWRE5ycm95VUdINWZ0enQwK2g0ekxM?=
 =?utf-8?B?bnQ2Y0tHcjBwa3FwaWJMR3Vjd3NRekxTQkUyQ1RMUzVnendKT3IyOVUxdkcr?=
 =?utf-8?B?Zk90Q3Y5M2pmNFpBVGdrOEhyQysvdWp2K2FxUXRLeFJvaHFmdWU3YU4xaDMx?=
 =?utf-8?B?STRLOXNiV0xwRnQ2VmQrdlBDKzdIc3pUWlRDNmpRbmtYZTFiL1BSWWZRVnl2?=
 =?utf-8?B?VDVnT1dPcERpV0ovWFJ0aUFhK1l1R0h5TStDL3gzZmhMKzJZbFN0dUlMOS9s?=
 =?utf-8?B?TnFpeU5YWE9sN2FJc0dEK2pBbkVIcG1LOVcybG0xajQ3Y1NWdTJIQ3JqY3ZE?=
 =?utf-8?B?QmMrVkRORENOeEJ2aVBseTZIWkpIMG00TitQTXJoTFljZm80eEI5aUtyNkkv?=
 =?utf-8?B?UWdnTW5kR1lSc2lMYUU5cUpXL0h4aUZZUldFK2pXaklLTGIwQ2hEREIvVHIv?=
 =?utf-8?B?OHVDN1doOE9TdFl2aXo4enpXNkNLUFU1YVB1K1pjclRRcXEvbWZKaHdCdFFy?=
 =?utf-8?B?SVJQVE4vQTRBTUNBZk5HbVdaN1lpM1NaM0tkajZPNDErUWZmbWJSc1MvMmZi?=
 =?utf-8?B?WllISUxPanJUM3J2MUhKamo3ME1COUlmdmlMWXJSL00xZWllQ2JkajBUSU1p?=
 =?utf-8?B?b1pUaDBaQUtJRGVYdm5wSHpTS0RpTWdaakhvVGloaklEMHF6ZlhZaTFHWko2?=
 =?utf-8?B?M3VYZEZwUWUzVDRadlJhYldYdFVOUERIMjFsWXRTWWhIdlc5TkZMUmNMMzhB?=
 =?utf-8?B?R1hmalN2enNLMVZxVEEyMWRsOWxJeTRVQk4wUzBSUEJaTy9pR1V5OHc2NE5r?=
 =?utf-8?B?TFUweXpSMlJlbW1pS2Y4RXc5YzVBaStodFQ3ZnFmeE1wOEFCRWVhbzdvbEpo?=
 =?utf-8?B?VzRjaHVkM09heFdIOVBGazZkK0x3VlBJTk1Dei9EMDF5L1UydzVZTFVmOWNv?=
 =?utf-8?B?bUhaOTFocm5YblhHYldSdExuMVNUL0phWmVFa0pEL0Y2bkJkYmJ4VEVNTzVF?=
 =?utf-8?B?YnZPKzlCV3JyZEdKejhObUJPVjRZTEl1MjF2NHhWNGVna2FtdFNEdlNKU3N6?=
 =?utf-8?B?d1dSNEhRSUg2MTNpRHdEWXdIaUYxWVRiZUpoempQbVRoSVZneHlHMHgzWnpJ?=
 =?utf-8?B?SlpCaFdzSW5CVy9ueFZQRXJZY2h3ekJaYXdsM3JlWU9zYjNYZ2IrdDBVSVIv?=
 =?utf-8?B?L0lpUlR1T3JmdnBLRnlMQ00vTmhqMnhueEY4dllQM0JscUdsMkpqU0NZTnN5?=
 =?utf-8?B?dXNBRnd6V1NyMDhIcGNmL0Z2WWZKdHpHMDBqMWNzN2RzV09jWmNyK3hMeFFV?=
 =?utf-8?B?WVhjU0EvSnBSSXdmNTRZRTlEdmE1b0RxWXRNUFI1SFJEbndNSEQ2TGc0NXlm?=
 =?utf-8?B?UWxkRVBqM1cyVXdpdGJZNHpqOFJidHdweW5Ta1oxV0E4ZDEvalI4aXA4Q3hT?=
 =?utf-8?B?dXRaU3dSYUw3Y3V2Z2E5U2ZOeEcwM0NRc0djRTRJR1l4M00xbzlZOHc1VENz?=
 =?utf-8?B?RmhvVXhTMEh5Q2V4dzJlcmZHVHFhMWRqd29uL0haVXlEd20vaWc1WG5XV2Rq?=
 =?utf-8?Q?DIuqjhQ0HGE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkIzUFpJdVk0cXVrc1lpT2ZkWWhpZnFJZzhiY0NGL1hYdFlKLzJtZDVudm10?=
 =?utf-8?B?RkZLbEY2Q3dHSEJNTkxtL0xBMituV09aRkQzYUQwb1o5NGUyeUo1bFlsOVNL?=
 =?utf-8?B?VWtpQjVsSUVOZG1TV29QMHcxOWZXMEliMmhwQ3E5elVtRzA3WDRnaElPZWdY?=
 =?utf-8?B?SHNEY2NBK2dxaHh5cFBvWklUMUY0Sm4vRHJjWXJZOUhSS0I0bWQrUjVZVC9L?=
 =?utf-8?B?Tmh3c0ZoZDd2WHArSmg5bVcyRjZBeG94VUwrZ3pBeEkzSmQ4SFpKeU91djYv?=
 =?utf-8?B?Z2w4bW5DYWJJN0VLZlpWaHlBK2JQbFpMT3pNR01zQ0J2bjFGbjQrK0hoSlJI?=
 =?utf-8?B?aFRvT3FGM3R2YVhmQVNabHJsQ3huanNKRkFHNXgzaVNBcTlsZXY3TmN5aWx0?=
 =?utf-8?B?UlJ6RTRidmZNVXkyUTNFK0Eyc0tFOFhDUFlMbTVNU2V1a25wSGJNUGtvdjZz?=
 =?utf-8?B?VUUzQm5meUdLd2hpTm1SMTF5RjZFMnR2bGZqWUNkR210UVRoUGt0dktqeTlI?=
 =?utf-8?B?MksxU29BaDFCTVIyL0ZGVWpOR3ZzSTlQSDNGN2JyWnVCNDN5Q1NISWFBM2JG?=
 =?utf-8?B?TjJnUmxBVVlROFZ3dHhpeGxQclE0U2RkQmg5UzVOc2dLTHlUdEZPTGdiZFdN?=
 =?utf-8?B?VEU4VmYzOTRMaTU1N1dzb0t1K2Z5MUkveGNRRS80OXFSUUhMd3lCRTFZaWQv?=
 =?utf-8?B?UUVzcTlNOGVpZVVaTUVxc0pyZ1dDek0yOVl6OTM1WkdPck9ZS09qRENYYURE?=
 =?utf-8?B?MzFVWDZQZ01VbUFnWVFUeXFLRFNJWko5ZWRudi94MVNpMHI3LzAzRDdRL01a?=
 =?utf-8?B?Yzd1V09rMko3bko1TUpQaEltejBqN2ZYdlhob0xoNU54NEJ0d01FaUlHaVRT?=
 =?utf-8?B?ZHNGdnk5UmM5WDJIVitiSEpSMUVXdngzb1gvNndFMzVqbkVxS0FqRmRYYXJZ?=
 =?utf-8?B?SEE0eTNKcmkrRk4wcitES2Jid1pnVWs4RWZjNjFKbTBXUHBnV3R6K3NzNWlS?=
 =?utf-8?B?QVhMZWJvNnpMd3pmcjB0cEJ5NjBpQitSNFFKZ2dIYkhZc0hkUXFIbUNpZWJF?=
 =?utf-8?B?ZWhENWpLM3pndm4vSXBJTi9Xb1lKczFWQmwvWjJEeW9QMFV4TzErdjVhMWcv?=
 =?utf-8?B?Z05hR0ZzUGJWTVh1TFF3R2d0OWxuSnFDN1haQ0pWOU5aQytiWG9nS0Fxc1Bs?=
 =?utf-8?B?UC9ST0dCejBrZnZQbUJZR0hCdTBkT0ZsNmY1T3plUUs5ekVWQTB2SHNRN0dY?=
 =?utf-8?B?SnBtSStTUUJhNmhreGhlWUsyaVVkVTBnRHlOd1pYN3grNDBPdlVvbUx3dmhv?=
 =?utf-8?B?MFJtODY5K0dxUElxUXZJb24wSVZMWjlKRVc4RzRpY2dLbkViRnlOVmx2SS9s?=
 =?utf-8?B?NWxGUXJhaGtLWm1TU1k1TjZwYmdwV2FJcGFsWEdaSXRCeXR0YXJFaXplMlBi?=
 =?utf-8?B?ZVZrYmdQS3hKMUdINGdKQVpjM1RodisxbFhDbjVkdUJKSXpNYVo3WklpL3pr?=
 =?utf-8?B?bkcwRFFvcTU0K3RhRENROXZ1RUxJM2xpY2hiSTBaKyt0QWJWQ2RTYmt1aDYz?=
 =?utf-8?B?OVV1Z3Y4SHBFbGlsckNLRVpuUDdYWmFGbURldnV4S0tEc29yc0Z5WTRrM0kz?=
 =?utf-8?B?VXhrTFEzTFljSitITElITzQrajNGejkzZCtCdTNDT2doaEc1bGVOUkU5Vmkw?=
 =?utf-8?B?UjRSQjZpdU5oNlRJalQ3eUZlWEk1aENOdkRkQlgrUmdvNWM4c2p6UldFOXhV?=
 =?utf-8?B?NC9mN1AzZ2ZzWlUwcFdtRlZhTjc4NU50amNuektUa0FkcmNrWm00ci92c3Z2?=
 =?utf-8?B?MEdGU1ArMVMxcUxwZTZIV3BRdld1a2hkVlRiYWRVc29sWC9ic3R2K0F1SjIv?=
 =?utf-8?B?VW9sQW9kUTVrSDZ5bTVIMzdibzFiT0xBS3ZMYVBIOEZKWVFPdExXQXR1ZzBD?=
 =?utf-8?B?N1hNTUswdC9FYW01dkdjSytVVFVxVFFsbmpFeTRJTlU0Ni9iMHZYS01SNHF3?=
 =?utf-8?B?ZWx3T25xNWtKQTZrSzJCTXlKUUFmREtOblFhRHhESjQ4WTR6Z2VMbGxuMDc0?=
 =?utf-8?B?ZnFZOTVLSkpZVExaWThjV1JVZlgyS1dKMVJibVhxMHE5RkZkeklhVnVFVFYv?=
 =?utf-8?Q?CGMPEXquz0IZl2AGT/j4fwJll?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adba7f26-dff4-4c0c-8a37-08ddc0747c9c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 12:14:29.7958 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qMA0krQwxZu0VIX2OadXt7s+Jzwi4B5ae6rtIdtvnPFtD9UgYOozvetNeR/v3kuU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9617
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

On 11.07.25 11:39, Prike Liang wrote:
> It requires validating the shared BO before updating its usage
> size; otherwise, there is a potential NULL pointer error when the
> BO released improperly.

Clear NAK to that. You are obviously working around a bug elsewhere.

Regards,
Christian.

> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index f042372d9f2e..a574effdd3ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -321,12 +321,26 @@ static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
>   */
>  static void amdgpu_vm_update_shared(struct amdgpu_vm_bo_base *base)
>  {
> -	struct amdgpu_vm *vm = base->vm;
> -	struct amdgpu_bo *bo = base->bo;
> -	uint64_t size = amdgpu_bo_size(bo);
> -	uint32_t bo_memtype = amdgpu_bo_mem_stats_placement(bo);
> +	struct amdgpu_vm *vm;
> +	struct amdgpu_bo *bo;
> +	uint64_t size = 0;
> +	uint32_t bo_memtype = TTM_PL_SYSTEM;
>  	bool shared;
>  
> +	if (likely(base)) {
> +		vm = base->vm;
> +		bo = base->bo;
> +	} else {
> +		return;
> +	}
> +
> +	if (likely(bo)) {
> +		size = amdgpu_bo_size(bo);
> +		bo_memtype = amdgpu_bo_mem_stats_placement(bo);
> +	} else {
> +		return;
> +	}
> +
>  	spin_lock(&vm->status_lock);
>  	shared = drm_gem_object_is_shared_for_memory_stats(&bo->tbo.base);
>  	if (base->shared != shared) {
> @@ -353,6 +367,9 @@ void amdgpu_vm_bo_update_shared(struct amdgpu_bo *bo)
>  {
>  	struct amdgpu_vm_bo_base *base;
>  
> +	if (unlikely(!bo))
> +		return;
> +
>  	for (base = bo->vm_bo; base; base = base->next)
>  		amdgpu_vm_update_shared(base);
>  }

