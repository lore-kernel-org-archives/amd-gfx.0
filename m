Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 057DCC87FCF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 05:59:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9241B10E1B1;
	Wed, 13 Aug 2025 05:59:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M4XpkRDH";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C34C289EFF
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 05:59:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yj9NXP1zCaaCPaYRrvRVyNbrCLNrL9azXlz8WRSzkSaHGx1nkc/FSCjcn+ce+uPmC7HDLoo7xyrTanEff3txhyvIrwwqGrh4+Wq6AwF2Ua12vqtY6Uze41i73mnfHFGG6SAN8tkolPL8VT2yvt/Oc136fKKTAsPBsZWXwopZyd7mlowR2xjVH/keZB1b2qX76jamvxNp2SJmZ4Z1Hf9S7MGS8CQJXQLWgMQghwXVuLBIuMWTVUS3Jk0m5nBlfQPNCuqnHLs0LcEG/mInaKVkMm5RZfUI4HsW03xF1BIWAcpt5gWXneYJj9df4ABi7G6ZX5/k3cpvyJuAEgAapjSyXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAZTacC/MFT+CjuQdCgRkaiztmRqQg0Lu1qw/yC9SpU=;
 b=r0tmvZzBemkw0xBaK2vmNRp1/21mCCPc32ecxjM83XT0TrvJF5owEfGjx4v/yrSa2Gx9TsorMR224ole1DZjvcZZvnCcLtc8Rq6+NFn+IUKwzkO8FgrJqdW1IB9wMYzZlYvz/1iN29JD9vMNTnQgtr70mImhi3rOFDxLIZANFuH1LSao9KpkS1oR9KamvliomY156HoXm8NTFs5S9ratknQjUPIUvZcMEI3acR6dLEZBxNC3qBGWE3WBVtHCUg5Nu171esYMx7GiQsDztTO9L4FRCnHUsL2pl6nk4QbCBzYJoiWzYGIHQKv8CzBnk7FxafMWetFUpArTlqGqDVb71g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAZTacC/MFT+CjuQdCgRkaiztmRqQg0Lu1qw/yC9SpU=;
 b=M4XpkRDHvpZwzNVmQPr1JoowA0/jJ6BpmOhJCatgAYkpyeekPA1e8lSOIn6bent5eTq6O+IwBJ5hdY0o8ycw9fqG5sgLaMy9aoAjAuPLAKy49CvLDkvwTpPMlLDgLX+QLjgnja2gwdUn0VbPauebnU8J+R+TY13qPnLOr+EXKvg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA5PPF7F0CA3746.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d1)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Wed, 13 Aug
 2025 05:59:25 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 05:59:24 +0000
Message-ID: <e3dd6d5d-cd28-4922-af48-dd94584f5f06@amd.com>
Date: Wed, 13 Aug 2025 11:29:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [v5 3/3] drm/amd/vcn: Add late_init callback for VCN v4.0.3 reset
 handling
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 Ruili Ji <ruiliji2@amd.com>
References: <20250813052102.3438895-1-Jesse.Zhang@amd.com>
 <20250813052102.3438895-3-Jesse.Zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250813052102.3438895-3-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0079.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::19) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA5PPF7F0CA3746:EE_
X-MS-Office365-Filtering-Correlation-Id: 4677a611-df61-4063-3f97-08ddda2e8df7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YlBNQnBIdzExdEVnbG8yUFoxQi8yZnR0U0Vnamo4dDVEUjZ0V25idVB4MmVV?=
 =?utf-8?B?ckNTbmFiR2hQd2NzeGlxNEJ3TnVtazJmNi9JVzlTZGs4L1dENkxjWGZEOUJk?=
 =?utf-8?B?aTYxdzI0dEZ1UnpXR2FuZkgxcDdPVUkrOEQwalZOK0tUSGNuU2svV0cwYnll?=
 =?utf-8?B?WjNITjFOeG5ZUXJPamN3T1Q5bWJSWElBUUk4SEl3aFhqaVpjM3BOVThlMmVQ?=
 =?utf-8?B?WVkzd0hueVpISzNVZHpWTkhqVEYxSnVWTE9rRXcwczNtNitiUldiQVVwR3FR?=
 =?utf-8?B?UExUNVhiZ3BOeFlINGxGY2dMd2lsQ0VLc3BuQXVuRW42ejdvZnB4Mm1TT2Fr?=
 =?utf-8?B?bGZ2MWxRSG5nUytkczFXZzUrZ2xialU5dmc5VmtNVkErNE02czFvL3JPZUhF?=
 =?utf-8?B?Z3Q4YXphOStzaGhkc2NlSHZ4NEgycXpTMlhzanRmOHQydUF0c0VEZWZoS0g1?=
 =?utf-8?B?cTdVNnp3WTdKb2xhVmpseU1BclVTS1VnTExmOVN6Q3pKR0tNclZnOEVqWDNE?=
 =?utf-8?B?OTNXL2RSeVJCK1l0b084bTdqWFdvU0pvWE4vcW9Bbi96SFFYeWgvbXp5QnMx?=
 =?utf-8?B?STVzTUNsY2tFRStTWFpkc3NzaWN4ZHFMc3ptQmtEREJZSHQzS2RLOTdldXNV?=
 =?utf-8?B?OXZCK0FKMnNFRGRMUWtxRDh2d0dpaUNSMzlnbnJKdkQrVkVtdWdoK1VLM0NT?=
 =?utf-8?B?NXlSeGJHNWxRSkNSKzcrclQyWGR6TmRDOFltRTgyeEhSb29laklXSEJ6cHpt?=
 =?utf-8?B?blZHaUtObXVWa2RyNU5pelloMW1xU1FNbTlRazFra01GMnN0ZU9jYW5FQ01H?=
 =?utf-8?B?dzlSVDYrVVF1SXgxampjcGM1aEJJcExXeDBBTzV5cWJqWXJodFFrK0EvMmVn?=
 =?utf-8?B?RE10S1ovYVBPSlhzVCtXM1NiRUU0K2k2TWkrR0U2L0t5VzBVYXFhY1ZySzlt?=
 =?utf-8?B?SHJpcjhIelgzZXBoZ0p4TnJQTmxyMUs2REpmRVZrRUliU0dxTUdSbElkYW05?=
 =?utf-8?B?Vm5NOFNmTU9aZW9PVGp3K0FFTDNnSjdkR3ZqcWdFRnNBRTdTMStGc3krL3Z6?=
 =?utf-8?B?WmFrdStMUDhjcXJTbTN5Mnp0TzVGQmxtWmVnTzgyODBtbURqQWFaVUc5dVkv?=
 =?utf-8?B?b3hrbk51anVCakFTWGt3eTdxVUtNS3ltMjVCY3p2YjRBaEtzaEFTb3ZPWUN6?=
 =?utf-8?B?dCtQYUJmbnVQQ0hZSnNvS3BISkhGQlA0Z05PamFiaG5HVTcyYmp1WWErSlNh?=
 =?utf-8?B?dHB6RFFKbkxnZFhGSW1nRGxkc3d0VGJLUVNYbUhkNHNaRnV4MmUyQStFVFhn?=
 =?utf-8?B?YVp2cEhUOGNoeDB1b05BcGYyQ0Fpb0tFVFdDQjFJTElsZFVqZ254MjNEd3pk?=
 =?utf-8?B?Z3N1R1BGVUsxbUJia2hVUFZUTG5iYXp0aXhJMW1lTXc3V0tOQnd4WVJ2REdB?=
 =?utf-8?B?cTFFaWIwaUJoS3dqWXJyT1hLalNkTHRuSVhkMEhZMHhhQWVGTXR0Rm4zMXRP?=
 =?utf-8?B?dkdmZmxleXMwT1F3R3U5Ym5WMm5qN3BsREthbHFYM295dFNuS01HTDNIR2NS?=
 =?utf-8?B?S2lRZEQ1cGZVTzZTK0FEUVBlYjMyejZaeE9WMnBrU2s5T0lBSnRSalFBQnJx?=
 =?utf-8?B?OUwwSWdLTmJ4ZmlBajhoOE1ET0Q0eWtUdTR0UnlyRjBDaHoxRjBtN3JUVDNI?=
 =?utf-8?B?RDJtdEVmOTdBeW1OM3lrOGhNb1ZEeVBnN2JOdG1HYnNsRVZmaXBVSTZVVDd5?=
 =?utf-8?B?enQydUZJZHhBSDN2NzEzdHQ4TFRFanpWRVlsZmRqOW1ZV0tzdVpTbHY0M1BH?=
 =?utf-8?B?WDU1SUFtOVFMV2wvVEpVUlZZbTNIa294RWxpdW9nc2kvYmFYNFFjaTVXTXNQ?=
 =?utf-8?B?c21OOTBsN2hRT1E3STBkUWxXOXBsekFodmFGR2lnMHNTdUdGUW1WN1BLVUZL?=
 =?utf-8?Q?sEHK//EDr+0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2t0VDI0WWp0dXhHNWUzMFRzYTVzK2lvMkp0Zm01dWhjaFAyZk93QllMd1JQ?=
 =?utf-8?B?UDk5YjU5TkVtZW1hck9Qbm8yOHFNVHZ6c09MemFNVHZJWnB1cFVSMG1YTldi?=
 =?utf-8?B?aytBK3psdmRZdDZKOUxVMnJFWUg2bVA3Y1o1OFRxOTE5aVVpMURLYWY4V2lN?=
 =?utf-8?B?aW5QRXdaZ1d1R0NIVnJyU0NndzJJSmdrbHVoWTE3Mzk2aHRZQmFCYXZPeURW?=
 =?utf-8?B?eWVKaDZxc2E4U0FIdEErZXBqcUFOc2dKK2EwbUgzYXBBcTBkaVI2TU9zekVi?=
 =?utf-8?B?eStiMWM2V25sck5DV3hnRmkxUDcyRmJjNitJUUppTENTVGNFd2YyaG5OeEdi?=
 =?utf-8?B?dGJzelN5L3BsVFkxdmhtSkZhRlpCWWdtUEQ3bUN1VFVZd2pNWEo5T29UdHpl?=
 =?utf-8?B?MVArVVVodm00YXBKN3AySnUxYkxEdnorMWdIK01zbEw1cGFnVHFmU3lZRnFx?=
 =?utf-8?B?WTk5Q051WWMwYTZBOG83TmdaeGlVaE1rTVVESk8vQ3ViQk1DY3J5MG5maWJD?=
 =?utf-8?B?eFBrZTFqSFh6ODQ2MVlVb20wekR5YzF3YU9zb0NrcGtaOFY4Tm5aT08wVkl6?=
 =?utf-8?B?ZHZnZnJsQWdSblFkdFZOYWFLVEJDRFp5dkFnZFBlSVAvV2gzWVVQeFJQTnI3?=
 =?utf-8?B?TWJoRjl2Y3lXNXlWaUoxamV5cmVlbVdPdDhkd0YvMEtITFprSVowbnEwdUNE?=
 =?utf-8?B?TzNOckhqTGFNOVFXenFRSEE0T0M0NkFSZVJIUW9BOGRLcGFac2xLczBxa1BU?=
 =?utf-8?B?YkZZd1M5R1B3WE1HSzhNZ3ZkWTlORTNtbjBKRWtuSXhkckZNTEU2S2hDYWk3?=
 =?utf-8?B?c2x3dnpTVi82bXpPUTNYMzl2aG0rbmMxVG4rOHNZQVpacWNVTVVKb2ZaZE91?=
 =?utf-8?B?RkpnV0l5cEdzNEZzNEZnMWJQQlFyUkQzempuck9OWWlOTm9vSFE0VXZQNFlF?=
 =?utf-8?B?Q1dtUERFMkNYMkh1cUpKcnRSUGNwT1krNFprYkUwbkdZeWJnUHFjczVDRFRq?=
 =?utf-8?B?UFJkRXNnMWl5YUYwRkxBaTZCZU8xQVFiaklDUFN2RllPY24yQXNWeU83Q3la?=
 =?utf-8?B?MjZrYW1lRmk5c0lNN3o5TndCeEJlNXUrQy9PQncwYWJWdEFFelJYTFMvNE54?=
 =?utf-8?B?OGlRWnAvemVIUmdEVGdBak13TXM4V2ROY3VBK2RTKzZaNHZUbEdmbFc2cWpB?=
 =?utf-8?B?ZFNYM0FlMGpWRmp3RXhDZlZueHByQnFpSlNLbDB4c1FsV0J6cmI1eTh2emJM?=
 =?utf-8?B?NUloVUNmMnFvRGtGNFVQd2p5UStITlVNYUpUWnRFVDVRYXNIZTFXOEtCak5z?=
 =?utf-8?B?YW1OWlBpaFhxSHNwV1RPL1dPTUZGMHM2WGhMdW5vK0pObHlzOEFmbzRrV1FX?=
 =?utf-8?B?TjB1bHFYWjE4NnJpTndzWnVIVWxzYk1LaWhLc1F6dEpsTXg3UE5aV09NODc2?=
 =?utf-8?B?Q1IxT1Y5NE5LV3kwSXVTbjgzSDJkRStDVlNNdGgyWUREdkV0RTNFYTJaSldu?=
 =?utf-8?B?ajlPdTVQM1BMWE9wajMzR01HazAxaDlyV2orSVU4aGd6aE1Vb2NFZFAzK3NZ?=
 =?utf-8?B?NnlVTklHaWJvQ0JPYUw4Q2NZT2tDdTdCelBoZmY3dDFhY3ArUzVYZGRtUXRD?=
 =?utf-8?B?dmdHQTdSak4yU3Bsak44QWIvUXVFQVJWc1g1VzQ3czl0RnoyMkY0aXFsVnNt?=
 =?utf-8?B?eVh0UXR4cFV0R1BETUJmZlA3dnUyM3lzd3BaMW9QV2U5ampPWWFCY29HeVha?=
 =?utf-8?B?S2VsVllONDAvU3diUTlMWGRWaDhYV21wMDZ0U2lqNDJZMytSbHhGNWZ5U0Zt?=
 =?utf-8?B?VzFLdW45b0Jmd2VRR3QxdWJETEtQWnhqejN2aHlFdXdtZ1VLRGk5NzB2VUQy?=
 =?utf-8?B?UEcrWS9LNXlxYXB2WWtlb2NRdlVyR2ZLTXNkODUrRVBIT1BwYUdKd3ZQMzUv?=
 =?utf-8?B?RW1yei9ocGZiK25KaUJaalg0SFd5VG9BNW1OY0xlYWdBV1JHc08vYStaLzlY?=
 =?utf-8?B?am94Z0ZwdXYvRUpidFNLTVROd0JkV2V3WVFKT3Y0RGR1MXltRGh4c3U0Y1Nl?=
 =?utf-8?B?TXBGb0V2WCtuSStQN3B5OHlmeHZFWlNZZkhVdktDdHpKQnNaRElhNFRDeitE?=
 =?utf-8?Q?IQvUy+z0JruVItjNt9zYivA3r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4677a611-df61-4063-3f97-08ddda2e8df7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 05:59:24.6528 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QYBK+gkN5F4dqkpIjm6hfCtw3t9esJehcyMFWjP9UQ/NSZYmzKyaELAvOvvKjmPj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF7F0CA3746
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



On 8/13/2025 10:50 AM, Jesse.Zhang wrote:
> This change reorganizes VCN reset capability detection by:
> 
> 1. Moving reset mask configuration from sw_init to new late_init phase
> 2. Adding vcn_v4_0_3_late_init() to properly check for per-queue reset support
> 3. Only setting soft full reset mask as fallback when per-queue reset isn't supported
> 4. Removing TODO comment now that queue reset support is implemented
> 
> V2: Removed unrelated changes. Keep amdgpu_get_soft_full_reset_mask in place
>     and remove TODO comment. (Alex)
> v3: set the flags at one place (all in late_init (Lijo)
> 
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Ruili Ji <ruiliji2@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Series is -

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 019bd362edb2..a63a1e3435ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -134,6 +134,19 @@ static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
>  	return 0;
>  }
>  
> +static int vcn_v4_0_3_late_init(struct amdgpu_ip_block *ip_block)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +
> +	adev->vcn.supported_reset =
> +		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
> +
> +	if (amdgpu_dpm_reset_vcn_is_supported(adev))
> +		adev->vcn.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
> +
> +	return 0;
> +}
> +
>  static int vcn_v4_0_3_fw_shared_init(struct amdgpu_device *adev, int inst_idx)
>  {
>  	struct amdgpu_vcn4_fw_shared *fw_shared;
> @@ -211,10 +224,6 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
>  			adev->vcn.inst[i].pause_dpg_mode = vcn_v4_0_3_pause_dpg_mode;
>  	}
>  
> -	/* TODO: Add queue reset mask when FW fully supports it */
> -	adev->vcn.supported_reset =
> -		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
> -
>  	if (amdgpu_sriov_vf(adev)) {
>  		r = amdgpu_virt_alloc_mm_table(adev);
>  		if (r)
> @@ -1871,6 +1880,7 @@ static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev)
>  static const struct amd_ip_funcs vcn_v4_0_3_ip_funcs = {
>  	.name = "vcn_v4_0_3",
>  	.early_init = vcn_v4_0_3_early_init,
> +	.late_init = vcn_v4_0_3_late_init,
>  	.sw_init = vcn_v4_0_3_sw_init,
>  	.sw_fini = vcn_v4_0_3_sw_fini,
>  	.hw_init = vcn_v4_0_3_hw_init,

