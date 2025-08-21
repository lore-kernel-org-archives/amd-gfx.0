Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81EEFCA0EEB
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Aug 2025 08:47:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D78110E2E0;
	Thu, 21 Aug 2025 08:47:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Bkg7wAcx";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D26B210E2E0
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Aug 2025 08:47:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u0FyWIaEJ9u69GXMinWOijWxqugqV80/uN6BKD9kzNjHYKzGOIoQxBGNhBD4TRq59+lFPA3fVeQkAF67egDQwvumdJaqhVwBPmUnvRtJlIHJK3CaC9F3fXb94NRhDhJVBmZOAeDgYzLgRu/qfHR5H8xINyUD8PHwAEOZGDkDO8B9iqrYfM0g1x1g1Pq3DJB2gX1QtdJn1Z1mObrxmfZtHFQebjoaL9CFKaBi3Di1CaFh4Sn7auVYb4GAWVLjP5jHs8z3qT3BM4iNhD6c2LauHJKMiKspHtCepkn7FFC8RzbeCZOa2JbnRmgZalelWcqBTPHh+l0NU11DD2v14Kugwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVjYvzi/9+lEXqktS/gS8yu+odzNE2KXJjJG3TUQASk=;
 b=rAdYGKMB/C2kkecMtXD4E5Jb7L+kl3/iYCpzgvfC8pMLGJE75gJzzXFo01G9XKu8j93+aKAMOIXUUf+1gE+AB+4iT/9zRZ4BTDstYqnzwHf5OXJPEAbMHOVBBtBaxucCqbPrKenj/YioBglBpSO9vgKhFQSjbFzrjv4Mm8EG6UkgLDGPyO8HavGZ46NFnotka3Pr68MkkT/fAw85bY4ranoFuNmkt/LjmcVB87/pCatsR/PwguEAPkkfGCs3y+G5s06Ni5ZY1EL28qD3zQ1OdG1T9X7gKU/UnIuxheH6GkaakTDCGRfC0bOxCCO03O+87h6voVYHVc60e//6Sz+nMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVjYvzi/9+lEXqktS/gS8yu+odzNE2KXJjJG3TUQASk=;
 b=Bkg7wAcxrfdv1bDZEU+Et6N+tevTgPr2Q37JPWttXWK8gvTl+/YcxG4PGFjTAXydT2kxA56ihEBlPkL0HUkFh5OmbPggB50E+0jBjtV7wcAKOoWeHLaQ2zcLeIFcnHWN+9q7lRL3sEyuV4hSzHDb2T+2lOJOBCeSAlDXRWXOv8Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Thu, 21 Aug
 2025 08:47:41 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9052.014; Thu, 21 Aug 2025
 08:47:40 +0000
Message-ID: <0bc82d5d-d5e0-46e5-a930-919a1fdb270b@amd.com>
Date: Thu, 21 Aug 2025 10:47:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: remove redundant AMDGPU_HAS_VRAM
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250821032143.3529874-1-yifan1.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250821032143.3529874-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0251.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fbc9d39-06e6-49c8-24b0-08dde08f6325
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QUdyWmFOaGRGM0dhaUo0eTNZVGUrWTJCUGQ2Y3dPQlNSMXdyaEJaazlwUnZW?=
 =?utf-8?B?czZXUW9QTEt6M1RRUUZKQjNvY3o4WkY0MkhpOWJoc1c4OERtUDRQd3l2b3dC?=
 =?utf-8?B?VVZWcGo4V1hCanp0OVYzeUZVNmlYSFM1Q3NTTkI4czNyWFc1c1haV1hjQTMx?=
 =?utf-8?B?YU1GUTRHMkZMNHlMVlhpQzVCQ1ZKVEpEeUE5TTUvRFBHM3lWcW9TS2RzakZw?=
 =?utf-8?B?bHBGQUowdlhLNlZNdkkrMi9pTkU0YytzNlAyT2hmY3dVWFlXK0lTYnFkeFBD?=
 =?utf-8?B?U0RhSXNRYnJCakhPQWZPTVRJa1hSSzF4KzUrc2dLQWF4WXFjWS8vSkx0VWZP?=
 =?utf-8?B?VDdYenZqdlE2eld5T1JCNE0xUStDQ29tM1ErR2EzSFZmVGc1M2kwTGVxVmgw?=
 =?utf-8?B?M0tUaEFsUWFrc1hSaXJIU3R6dTZ6cVF6bmUrRXZpK0poLzdQOFczUmNzOE5i?=
 =?utf-8?B?N0dpRlNPQ1pkYlZudCtKT2FNTUVOanhNZEU0d2FlWlc0ZEhUUWFJY09ZS0N6?=
 =?utf-8?B?dGt4N0V5bExzNXpnbmxsTHVFdUpaUVVWaDI3RFI4NXJQN05pU2FSL0JMcExr?=
 =?utf-8?B?TWNpdWo5YkN4TlkzTm9LeVkycnVJYkdDMlhtdkNUZndYaytHWkhPTWxTK0dK?=
 =?utf-8?B?ZGNldnhjRFowZkdyWGpFaFBQOUFYUGppY2JlOG1OcXV0SHp5dHRCY2hxd1p5?=
 =?utf-8?B?eStxSE4vOEFJNUVIM1c1ZkdUVHgwTXg0Wk5aU1ZiV1RZdC9CR0VQUXBBblN3?=
 =?utf-8?B?WW16KzlhQWlDUXE5KzRFWXp4NHd4Z1o0TjVSRVk0OTFKYTNJSE4rWjhsa004?=
 =?utf-8?B?NzNacUVEcVdncVFoYVk1Q2ZaNGhYVmp1bm11c1g4SnRQaCs3UVJCZnlCSUxG?=
 =?utf-8?B?MUdUL0trazcwbFl0aThIa1dpTmlRZ3dnaTlRSmxkMlllMDBvenpjV1EzSnN1?=
 =?utf-8?B?aGtBTGVIZlJsQk1LSlJEaUVVdHl6cFl3WXMrSjVjbkkyV0V0dVg5dzhsb0Jw?=
 =?utf-8?B?UzUyeFVvbFhPaThUSzFSTVhscUhaTmw5UjVIVnlIbmJzNTZmWVN2bG1wcGY2?=
 =?utf-8?B?S2x6M0JmeXlUNWVkWGExcEplOFhMTjNWc1BPQzZNd3NCNWt6bFlxMGxnR282?=
 =?utf-8?B?T09Sc2Y4L0JTekJoNTFCd2ljRlIwRGpMM253R0pvcldKM0wxaGU2Z2c5UlpZ?=
 =?utf-8?B?WnF1VVlvU0J3NGE0V3U2QjB5MjhjK0hkS05lMERvRFRVQmF1bEdSRy9Ec1B1?=
 =?utf-8?B?Ty9OT3cxL0VZck5TcEp5T0hKeWM4VkJVZFBSMjkyVmpQd1orU3pGZzZyNGh6?=
 =?utf-8?B?aUhDNlNKV2gvakMybFpBTFZaN3BTRXRCMGFOSTN3cmU2SzBqYkZuS1hOaUMy?=
 =?utf-8?B?Zmt5SS9DMlJDaHNVZ3JIWjdGNzdLTURPbTU5ZGZhN2ZNeXg0R25SYlV2R0Yv?=
 =?utf-8?B?UW1ZaFVYa3pIZlpOYTcvUG5XSGxPNEhhMnJFZ2NLRUZWazJWczkyQlNyeXhv?=
 =?utf-8?B?RUtpYVNJZFRrZnlpRnJhemVkNXhoNnUrNVN6a1EwekRqYTdXWGdDUUlNRFdr?=
 =?utf-8?B?dEVwdmpieE5sTUYvd2hEL1FoOGhGRTRpaUx6S2lGY2tOSWlRUVd0V2JveDE4?=
 =?utf-8?B?ZzlnSVV5OFh6Tlg0NEk3T001cWM4OFFwT0toUGNhOExBcXFydGtRcVgrNEk0?=
 =?utf-8?B?Rk1Wa2RsamtwUkMrTnJnS2ZsVmMvSTUzMnNuVkJRVGl4aVlucW4yZXU0VFBj?=
 =?utf-8?B?aFlhU2wydFdLeTVhZ3BZcG5tUFZpRCs2cGdEMzBvUVFHZDJDbitteXZaTjJ5?=
 =?utf-8?B?bEtxcU42R2FuaXgxd2twRHJJR1JTTGJrckVHUU1HdVlZMGUxZTFMalljNjEr?=
 =?utf-8?B?dnJHNXo0TE1XZVVua2lOenhBRGdnTUlxQ3ByeThncllNTEpBZVVUaE1MN2Jk?=
 =?utf-8?Q?yCp8JtI+m2U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTU4WllOeTY3YUgwRTlrUEVYek5NQlVKVkNHUkt4UHFRMU5MVDJ5Vkl3MDda?=
 =?utf-8?B?dUxqVEJYTVI0L3dTUFplYlVLbVg0S1JVQUVJVm5CYldwSDd0b0tDZkxpZnA3?=
 =?utf-8?B?OXI0STZ1cm9ERW9NTkkvbHNwbE40bE9KbzhqQzd6RUJ0d3JRbUVnWEpRU2xT?=
 =?utf-8?B?Y0xCTWZkSk8xaXlWSmdHRHMwN1NJczYxbXorMnVUNERHdUcrMjR3eU9EL2lP?=
 =?utf-8?B?alNpcW9sajFtY2FIRUx3TGVab0J4VXRhdFM1SlNUeUhxSkJvVGEvT2pvUzNZ?=
 =?utf-8?B?VzNFakQ5NHU2WG1FTkVERm53L0t6UytSZG1aUS9SUi95OWY0N2xQekplZTdy?=
 =?utf-8?B?TkhPRXBrdDBtSURyclB0OFJEcFdIeEc2NkNWUFp1Wk0wekZZdERydjRybkpS?=
 =?utf-8?B?b215RVBKT29mSzN1VmhYS2p5Y2piZXF1ZXEyTUk1a2lCMUFzdTRzSGpDQkVr?=
 =?utf-8?B?WnVVQllORXdtY0pHdHExWGYzK1lhcTJlTW1XZWpEZmVIblhOYUZpcWZKTC9j?=
 =?utf-8?B?OWsvTWJLdlF1aXc4L0RNSmJONDZmRXgxZzVNdDkzVmI2NzVuaUZBREVqQXhs?=
 =?utf-8?B?VkY5Wm9nbk5raE1zMTBQOThqV2xzbUFRTWFiRFFTbUV4eldqTGlUR3daTkRr?=
 =?utf-8?B?alNFaEJua2FwVnNaRGl2NzE4aUVuN0QwdEhxd0FmUzNDTnBIT3M5TThOSjZq?=
 =?utf-8?B?aTk3dGQxdzJNYzVFNmo3U2hoZnNueDlsU25WRW9RT3YyYmxjUTgwVGxwd05F?=
 =?utf-8?B?eUovZFkwM0J3dllmNzVpeVhqVk9lTDhqRVJiakZsRlBENHArR0FSL0trU2FH?=
 =?utf-8?B?Rjh4M0w5Qmd3YjRIN0RTY2k0NkJnM0ZEWUdzT2dyMWFPZ2xuQ2ptNnl5S2ZS?=
 =?utf-8?B?MTVncUdLL0lHSWg4VkpkdFczK1VFTW5YdWtLNzg5SUZRb1lYQU5qTGRreFBv?=
 =?utf-8?B?YTNsck5CNnAxTkUrRHMweHh4VDhnTkxPWEJCSmxyaWFDUXM5QmlhU0ROcUlB?=
 =?utf-8?B?OGZmYmJncnNSR2tlM0Jxb3NVSUFYY2pjL3VaQWhYQVRYUVdUWmhMNVYzMzM0?=
 =?utf-8?B?RVZsRUZ5S0h4R0VydkFjVEROcndWeVFwQ0pWVWRSWnVGak1HTTI5enRZVEJz?=
 =?utf-8?B?ejlKeFo4bHRyVlh0R3FtWFFsaUlDWWtFNEFYNmk5bForVmFjZG1Ja0NvTUto?=
 =?utf-8?B?QUNBeG0yZlkrSmN1Y1JIZkdKRDBWcTFKTFJWTFhqbjQwakt2QXpKVWZtMWtm?=
 =?utf-8?B?bWFMNzNOL2RjZzlPWmV3YjRmekxDRHFNU3pkNm1pVmNGbXRLSTNJbEFBd0tC?=
 =?utf-8?B?RGdTOHVlbDhDQmViL0VhbGZhemlyR2Z6ZXRGQnVoc2dMNVY5Z2hwbkN6OWIw?=
 =?utf-8?B?eDdoS1pPT1dHZmcwOWFVUVZIellFQmRQZUNVUkI4R2VSL0xFUXVhRmUwY2Qv?=
 =?utf-8?B?OHA3QnNONEQyU2ZmcnE4MjFtdjFJMUJqTWxuRFhDVDBhT3hPeTV1ZDMyemF2?=
 =?utf-8?B?RU5sRlVmcmhOYlNuSlFyOUpCcEdHMFc5MzdkNUZpZ3RLRURLaHVpcHlhVTE4?=
 =?utf-8?B?ZktGb1FTa0pKUk1UcUlxZjRGOEJ0bDJzVGNSQkFrV1cxcjMzQ2FYZ0E4dzNu?=
 =?utf-8?B?TUp0RHFERm11MGFHa0dOd3g0VDU4ZlA4dlZoUXEvaTJwNUl0U0F5Um51Nzhk?=
 =?utf-8?B?TzEwZVBqekpSQjk5eFpESjU2S1l0Z29PYUxPQU16TTBGcVVGTTZRTGlUUDVX?=
 =?utf-8?B?S3M1OG9NZDhuNlNuV3IzRWpiY3VUcUxoL0tFTThVSmRrZGw2ejE3Q2Nzb1ZO?=
 =?utf-8?B?S2MvMzNjV01XbkJZT1hzOVJKOXFNY1g4Q295WmlhVDJpeng1eEhTZjdzU25l?=
 =?utf-8?B?VUo4T0lkU01jUUhRQkJGT1lIQmhSbXN2bkdwN3JiNEZNV2o3WjNLU1BwUWVF?=
 =?utf-8?B?VlhCckVCQXZjQWZ3SU9qa3lEd0dYMFk3V3c0azhZMyszUTJPN0szR21Bc0lJ?=
 =?utf-8?B?TDlmT3h1cVJYNWpEZmp5L0pvcXhKYjh6RU0xSk9ITkI1eHF1S1ZhWFhxS3dw?=
 =?utf-8?B?ZnRaa2xHNVk3Qnc5aUtmMXlORDF4Vkh1NG1WZWZCcGcwZ29nL045TGRzL0xw?=
 =?utf-8?Q?RqVMkjfHFMiaeVXL6ns/4If4O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fbc9d39-06e6-49c8-24b0-08dde08f6325
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 08:47:40.8059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5BblYQ3Fa4wsrKcr2tFoXbyeUihI2RPKQwK2lDKT2yukMG/vEoFuEAdt7F62aTYC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6493
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

On 21.08.25 05:21, Yifan Zhang wrote:
> AMDGPU_HAS_VRAM is redundant with is_app_apu, as both refer to
> APUs with no carve-out. Since AMDGPU_HAS_VRAM only occurs once,
> remove AMDGPU_HAS_VRAM definition. The tmr allocation can be covered
> with AMDGPU_GEM_DOMAIN_GTT | AMDGPU_GEM_DOMAIN_VRAM in both vram and
> non vram ASICs.
> 
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 6 ------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 4 +---
>  2 files changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index ddd472e56f69..01f53700694b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -946,12 +946,6 @@ enum amdgpu_enforce_isolation_mode {
>  	AMDGPU_ENFORCE_ISOLATION_NO_CLEANER_SHADER = 3,
>  };
>  
> -
> -/*
> - * Non-zero (true) if the GPU has VRAM. Zero (false) otherwise.
> - */
> -#define AMDGPU_HAS_VRAM(_adev) ((_adev)->gmc.real_vram_size)
> -
>  struct amdgpu_device {
>  	struct device			*dev;
>  	struct pci_dev			*pdev;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index fa3e55700ad6..d92a73e7f2a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -880,9 +880,7 @@ static int psp_tmr_init(struct psp_context *psp)
>  		pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
>  		ret = amdgpu_bo_create_kernel(psp->adev, tmr_size,
>  					      PSP_TMR_ALIGNMENT,
> -					      AMDGPU_HAS_VRAM(psp->adev) ?
> -					      AMDGPU_GEM_DOMAIN_VRAM :
> -					      AMDGPU_GEM_DOMAIN_GTT,
> +					      AMDGPU_GEM_DOMAIN_GTT | AMDGPU_GEM_DOMAIN_VRAM,
>  					      &psp->tmr_bo, &psp->tmr_mc_addr,
>  					      pptr);
>  	}

