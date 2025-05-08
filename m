Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD04C3ABBE
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 14:26:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 453DC10E1C5;
	Thu,  8 May 2025 14:26:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CDbz8wRy";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A697910E1C5
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 14:26:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2CmN9zewJ++kaI6yLu+f+XB1xeRo5NDxOtoIzp3Y1HHEDn5yUfDckJUUsWKB7Db5fqhTVtU5b4y4EYlCzcCU3WGlLU3XtcDek893jfLmrvnTxBK9l+BEg1Oev7v7I58QhvHoDbFmMShDLPFW/AnvT7hIUDbdKA7igfVQVBdXgekcrhZBZDs4/PDUscUZH01URUpKrq9V/4Q0u6tmD9MOCHbsl6fqDkL/Gh0m/LNaGMaZ9E3xLxMZ/zpmGjCu39w+oVsVMq6mWx+ZeFl+cAZQ6NlHGOTQoXbfRgkIK4sTWc9fjeSUSTohhLzeUr5G397zPHVXHuZ0OBjZ8CFdjICag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VL9BgLThYrwIxxQP9XCfC2DzxoNigBJ1+3Qr1y6tpj0=;
 b=HFHqft1SYOdCnpFq11Xb34q5ErOm58cwKx8sSBIfqtpqSp+84BwN9ogh4H7ch5KT5F6En3YaQZfUN0s5gqmSBEnxjj5AgOPUFI0wfiSX1uKiIekaZcoGLv6Nj4dsbTfKPfUhcG8yeDG06SBzbiHB8YJz9zpzYFEQtrjtVuzLr4xH1JqrvfePYucqd+KEsy0jjhQV9w8k+zVRYPNQwaV7nzoV5boKZCmDNuX4GiIPw0PhX4mwt+dZ+0InBBfYIxSBPZkxvLV0F4LfrwGltP/TpmOlOIuN/iD2dYNWLjkQfLoHAtiTFvJA3X+hu8TgkAOyzSc/3Spz/k8CCX+wTSCXSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VL9BgLThYrwIxxQP9XCfC2DzxoNigBJ1+3Qr1y6tpj0=;
 b=CDbz8wRyp44g7GDUEqvbTBSnNt4QAqXeQQ9Jzefli1z5T1Kjh2FJV0/KMNr6wh+Q+KF3ho6YI3OtU6hNJin0tbJgOPNX4tNpeM1r4y1buLDiC2RfF7sQyh8okQ8lhbPgdo+wc7fnP0FibZ+hd7Ky4BYgY1W+Hgf9D/uE615mEfs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by PH7PR12MB6718.namprd12.prod.outlook.com (2603:10b6:510:1b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 8 May
 2025 14:26:19 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%6]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 14:26:19 +0000
Message-ID: <1587e564-ee39-4989-87b9-5b03a2867eb5@amd.com>
Date: Thu, 8 May 2025 10:26:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: use drm_dbg_driver() in amdgpu_dm.c
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alex.Hung@amd.com, sunpeng.li@amd.com
References: <20250507172519.7632-1-aurabindo.pillai@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20250507172519.7632-1-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::28) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|PH7PR12MB6718:EE_
X-MS-Office365-Filtering-Correlation-Id: 14d61164-fe5a-41a5-88be-08dd8e3c4c9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RlRPR3dGZmw2aVZOU2lRWjlNYjJ3OVppanAzckF1UjE4dnp5WGRsRittVDQ0?=
 =?utf-8?B?Nk9XQTlWTjZhTUpwanpRQTk3OHpZejZLd3hiM0F3RU5zTWtrWnlLbFNhb1Ns?=
 =?utf-8?B?RUhJQjc2V3I5RHFjYzVYS21zc0VhVW4zd2UzTVpMVENJTlluSjJ4V2k4OE9L?=
 =?utf-8?B?bHNrODY0S213NUtMWXo5c0l0WGhvQWh2WVZlSWJ0V1pwNWhjd25RdkF3U1hy?=
 =?utf-8?B?c2UrNklLMmV4Uk5KNzgxb3hJVHBmeXoxSGUvNnk1S0NlUlhJT05OV1VONXND?=
 =?utf-8?B?K0xZSjIrVEQyZGFIYS94Ri9COVo3RENMcFBvMGdiakZKQTd6MVZ5Ty9lcDB1?=
 =?utf-8?B?ZEQ4SStFU0ltYkhGV2VyYWQ3S2ZNajBERzN2M0lQcVU3ckxKZ0FadUMzK3JL?=
 =?utf-8?B?cUY3UkNQc3RvS0xqdFhlNzRBZU5vd3U3cjJEb1kxMURCQU82U3ZSTExuN1lK?=
 =?utf-8?B?a1QweEtQdzIyYmtVZXI0SkQ2QTBJL0lNZTlnelEwZWZmcEVHWmMrNzBaT294?=
 =?utf-8?B?R3g5YWpOSlFIS0RNSm5DdUZ2bDN1a1dxdTdvMjB6KzVHZ2xrQ2JxYUdJSEdr?=
 =?utf-8?B?NVdDWWlQNVh1OW5XcWt2Z05IaTFaMmI1MURmZjNOc094OGJTaTFoSHRLbTB0?=
 =?utf-8?B?ZlpVc3BPeVJTcHlpNTZURE5MWVFUcWkzYVpuSUlsN3A0OFB5UW96VHk2VUdm?=
 =?utf-8?B?NGZRa3NEZXQxT1d0enFyU3NzWnI0MzBOc215aEdHbFZHSWtnWDdPQWw0ZXl3?=
 =?utf-8?B?MVo5U09jZzJpRDBpSmVjNHVBNTd5SUdrdE5QVThXWTBXU0t1SVJNWUhyUWNP?=
 =?utf-8?B?LzZKc3pKZUsxMWJVNm1DODF6ZmNmbjR4UE5jeEg3OUc4ZkhHWFgyL0hNbE5l?=
 =?utf-8?B?RVVlZ2h5cUwzblZOb0ExaVhkMmFQZTZVOE9oRGlUVUJwMjhyalY3OEdMMXl0?=
 =?utf-8?B?RWgzWWRNRUN3YmVVVnI0d1Z6cDBtdnlwSTJ1cUptOWtJV3NLUkVlVzk1MVI2?=
 =?utf-8?B?TGkwVStIVEdJcUR1WWJXbTRZNGEycG1rZ1dIVGlFb2xoQzk5Wi9TQkM0SmxE?=
 =?utf-8?B?cThMM1BTTkE1TjdsRmlkdENqTHY2OVJPV3hxU2NhTkVhTDZSUS9qM3o2cWFh?=
 =?utf-8?B?RURSay9WcUVKRWdOa3FsdHM2UnhtU3crcWJRZml1Qmc2VTExbzdiY05XamNq?=
 =?utf-8?B?dlJ0YmJpNG9BYkROYmV6ZWpnMzVsL3gxQTMwYVVZZ2RjSzdlTlRaVUlON3FD?=
 =?utf-8?B?MDJDcmRPdkRnTFBpQlRLTzZHQ1c0SzgxZVJwNkRTSllUK2hRM0xXUE0vWVR5?=
 =?utf-8?B?ei9jbXBoVTVFZFYzR3hKOWFuZGQ3cGU3NEloUTA0S2QzNXJUeFlhM1h5bURS?=
 =?utf-8?B?NllPZnl4Ukc5bDExQitYRzAwVlpKTDNWR0E1dmY2WXc1cnhOTk05dGh1MFRw?=
 =?utf-8?B?djBTS0cxK1RROTdLcExsZHo1Y3FOMWo1ZjRkVmNkaElRUTNTZnZKbmZkdFQy?=
 =?utf-8?B?aWFyQXNYQ3Y5TWxUbHFSRzRnczQ5bUV6aUlJc1FzcXFITm4wWjZWZ1RJYUNR?=
 =?utf-8?B?L2NuMlBhajBRc3l5Vy80NWRtVi9Mcys0c0x4VkpXOUU4ajEwaGNWVGRaeUpx?=
 =?utf-8?B?eWx2b3pHNjZkWjRlZElxNEwyV0ZmOXZseTl1RHBtMWVZVXUrNHpnYUVWTTB2?=
 =?utf-8?B?amI3T2tMM3VBcWtaQlNSM2F2M0JFYUt5WGRnWU5WdVdjdHU2Y0hGaXIzVFJO?=
 =?utf-8?B?TnpRS1VBbjdHN0tJdTBweC9VazJXM1VQeEZIZTZSMjlaQzNZd1ZJME44OUpN?=
 =?utf-8?B?SFZJTWRiRTlPNnhkVDBnb1N3TmpvMjI0RXIrKytIR2ovczVtQjc0emFTR1N6?=
 =?utf-8?B?WXMxeExUeW01b3M1VkkyQTVZbUdZeG9TbVozWGtLRXhMWVFnUjJtamV2U0cw?=
 =?utf-8?Q?iiXOFG+nbSA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1kwVzJCR1hVY05uTGIycGJCbmcvOWovQ2dhbGs5cld0SUJGcmM3R2paVW1K?=
 =?utf-8?B?Vm8xbnBkL2hBOWRzcFBneHdmV1lIdmJYM3ROL0JoZWRzNUlaL1E3STBZUmxu?=
 =?utf-8?B?Z3RKY2VaNHNUMml3RjZGVTJ2RXJmT1JnR2hoeXJFWWt1MElMai96SzUvMlFN?=
 =?utf-8?B?YVA3eUxKMzdDL1FRaWhWdkFZZGZZbU56a2JjSVVrUGZvSURQVGFPZDhHM25H?=
 =?utf-8?B?TVVmNlpRVSs4M0NCekFybG9tbDBzSjhoMmVSVEtnUTU3YWpyOHkrSVh4ME5l?=
 =?utf-8?B?VVJRWUZ3dThhc005b05oSkQrTE5kV3ZKV2p5b0FIRlVtK2dSczArNFVWemQv?=
 =?utf-8?B?aEk4Q2NaTkp2REZBVHJTNFpxbFRac3lPZC9QSDl6R2xEeThYYjIvRVZQRlFl?=
 =?utf-8?B?RUZCdmJteFJtVzJWVlZRam9WV2VSVHNvVE9kYkVRQ2loaUxlZEhVQm0rR01q?=
 =?utf-8?B?anZuZEc0cllQSmpoMzh1akhvTWVuQjFXLzI1TWxJVXFpdnRTY04xQUZ1M1lZ?=
 =?utf-8?B?UXFwd2dSOVhCV1N5bzN3NkV6RU1zN01zRjB5ZnIyYjZ0MVJwRE9HZ2VMRFFU?=
 =?utf-8?B?K1RDN3V4WS9BRXg5SmVZS2FZeiszL25jb0piLzJZOW5NeDk3TEZXYWxQTVlD?=
 =?utf-8?B?RGRVUUhhTmZLTkkzemxFeHdXcnhCalR3RlNUS3h1N08wNVRvKzEwMXJDMEZu?=
 =?utf-8?B?SXc3eHdpdG1aSUZ1RzlnKzBWTTEyazR0Tk42ZmMzRnhweitqWGFjWmoxYXJo?=
 =?utf-8?B?am9KdkczQ0hjN2dkb1FPZWNYWjRIZ0k3eWxMTVZUSmMxbnlxYVhiUkdxZnNs?=
 =?utf-8?B?MDVHVlY3M1ZwOW1XUGtzM1hvWmpnVnhzTTdEajhaMXBoczR0cVAzRnJzSlVl?=
 =?utf-8?B?bHhVUlJzajNienRUdDkwbUlraTk0c2ZGa2grajBjUWR3am1MZFhSVkZSWFNZ?=
 =?utf-8?B?RStsamFVMGFEYkN4cUtRbjVUYk0razVNWDhYUHk5UjFkaG5WdHYwMmdEQ0I3?=
 =?utf-8?B?OHBUa0NFcnFCTWEvdCt5N0NNT0kySG9GN0JKSWhzL25FYUFZVERUMEIwODln?=
 =?utf-8?B?SStIN2E1NTcyNHhjQ3dDU3NRSU43RGZad0FMdW5BYjZzTWdENXd2OENNbFZt?=
 =?utf-8?B?clZiQjZFRlZSWEZKZGZQUXorTmsvSm9lRWdzSm81SHFmVWp1UlFqS2ZyY3V0?=
 =?utf-8?B?TWFkODdyTGx2T1EzL200WjFUSkc1TzIxdG5EeXpNOHJMUGNMSEZ3bkU4cTFp?=
 =?utf-8?B?T0lCL2pHUjQrQVd0anVRY1hXeXVFenpwZTlJS1hHMzFwMm5keDU5NXYvM2Ix?=
 =?utf-8?B?SzBmSjBRNTBRdnRXZ1drSjg5QStXRlNHOWhTeEtqeUFYNWpWak02NjJUYjVY?=
 =?utf-8?B?ZjRubXpsdDJQZzVXbW1EUU5tVzNTRDFMSEFLamVZL296cEt4VGp6eThEOHY4?=
 =?utf-8?B?UThiaXF1bmR6ejR6TnFSQmtRT1gwZVZtY2gxL0czNnY2SitNSE9PeDdTZ3VY?=
 =?utf-8?B?amFONFZiNHVmK1BHTEs2UEpHa2hYd1h4WHRJekJKNGNxVGlkbHZuMEk1N0Vm?=
 =?utf-8?B?aEM4MEhxL2pnN0tGNXdzNndEa2dDa0UrYUJFT0pkd0pWOWhuNGdYZldXT1NM?=
 =?utf-8?B?UXBqbFpPVU9xaXYyVFVaWUZMNm9SK1RabjRTU2dJTXZMVi9LNDFxSlJjWlhD?=
 =?utf-8?B?YW5McENZcWs2c0pEOGthbzNsY2syVUhlUHBYcHZOWjhQS3lCR3hwTUUwMkhF?=
 =?utf-8?B?bkttOXlRcVB3NXVOeVJVTGplWUxIUTZWK2RrK0pLNlFnQnZ4c3lzcmR3MWFR?=
 =?utf-8?B?WDZRdEo1eEJNbTVPRTlYVzVWN21kTUM4Z0hnR2lVS0tEa0t0MnNKK3dOZ0RK?=
 =?utf-8?B?eTN0VmJKNHlnNlJoSXhYbGorNlpNNE9zM2s1M2hybEZiWndxUVV4aVNzMW1I?=
 =?utf-8?B?Y1M2bW1rSmMxNDN2SnpseEs3VHRTZERjcGJsZ1JnYWNEVDgwWEJvenBxSFhU?=
 =?utf-8?B?NzVPRERKTTk5TmVISUN2QU0xaFlzVW5DeStOSXhlVzlKNEI5bXZ4QndWRkNj?=
 =?utf-8?B?QmlNOU1UM3R6UTc5SmxhK2w1VWVrcUNVWU1ZQ3pwMkowd2UreHc4RndVQ2NP?=
 =?utf-8?Q?Ynum8MVWGixgzRkaqOqKfM+CH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d61164-fe5a-41a5-88be-08dd8e3c4c9a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 14:26:19.3057 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4fQLiWI85NzyJ+EEBkCpnG9KivPK/cDyNqCUjwWl8Rj8iG1BzoCFVpMyE5zUhjLMDWwf+76LAwLGCVkCkA+4+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6718
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

On 2025-05-07 13:25, Aurabindo Pillai wrote:
> Replace all use of DRM_DEBUG_DRIVER in amdgpu_dm.c with
> drm_dbg_driver(). The latter prints the instance of the drm device
> associated with the error which would helpful in debugging scenarios
> involving multiple GPUs
> 
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 35 ++++++++++---------
>  1 file changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 8984e211dd1c..46fc4c94a879 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -866,7 +866,7 @@ static void dmub_hpd_callback(struct amdgpu_device *adev,
>  static void dmub_hpd_sense_callback(struct amdgpu_device *adev,
>  			      struct dmub_notification *notify)
>  {
> -	DRM_DEBUG_DRIVER("DMUB HPD SENSE callback.\n");
> +	drm_dbg_driver(adev_to_drm(adev), "DMUB HPD SENSE callback.\n");
>  }
>  
>  /**
> @@ -963,7 +963,7 @@ static void dm_dmub_outbox1_low_irq(void *interrupt_params)
>  			trace_amdgpu_dmub_trace_high_irq(entry.trace_code, entry.tick_count,
>  							entry.param0, entry.param1);
>  
> -			DRM_DEBUG_DRIVER("trace_code:%u, tick_count:%u, param0:%u, param1:%u\n",
> +			drm_dbg_driver(adev_to_drm(adev), "trace_code:%u, tick_count:%u, param0:%u, param1:%u\n",
>  				 entry.trace_code, entry.tick_count, entry.param0, entry.param1);
>  		} else
>  			break;
> @@ -973,7 +973,7 @@ static void dm_dmub_outbox1_low_irq(void *interrupt_params)
>  	} while (count <= DMUB_TRACE_MAX_READ);
>  
>  	if (count > DMUB_TRACE_MAX_READ)
> -		DRM_DEBUG_DRIVER("Warning : count > DMUB_TRACE_MAX_READ");
> +		drm_dbg_driver(adev_to_drm(adev), "Warning : count > DMUB_TRACE_MAX_READ");
>  
>  	if (dc_enable_dmub_notifications(adev->dm.dc) &&
>  		irq_params->irq_src == DC_IRQ_SOURCE_DMCUB_OUTBOX) {
> @@ -2200,7 +2200,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>  		drm_err(adev_to_drm(adev),
>  		"amdgpu: failed to initialize freesync_module.\n");
>  	} else
> -		DRM_DEBUG_DRIVER("amdgpu: freesync_module init done %p.\n",
> +		drm_dbg_driver(adev_to_drm(adev), "amdgpu: freesync_module init done %p.\n",
>  				adev->dm.freesync_module);
>  
>  	amdgpu_dm_init_color_mod();
> @@ -2222,7 +2222,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>  		if (!adev->dm.hdcp_workqueue)
>  			drm_err(adev_to_drm(adev), "amdgpu: failed to initialize hdcp_workqueue.\n");
>  		else
> -			DRM_DEBUG_DRIVER("amdgpu: hdcp_workqueue init done %p.\n", adev->dm.hdcp_workqueue);
> +			drm_dbg_driver(adev_to_drm(adev), "amdgpu: hdcp_workqueue init done %p.\n", adev->dm.hdcp_workqueue);
>  
>  		dc_init_callbacks(adev->dm.dc, &init_params);
>  	}
> @@ -2299,7 +2299,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>  
>  #endif
>  
> -	DRM_DEBUG_DRIVER("KMS initialized.\n");
> +	drm_dbg_driver(adev_to_drm(adev), "KMS initialized.\n");
>  
>  	return 0;
>  error:
> @@ -5097,7 +5097,7 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
>  		drm_err(drm, "DM: Backlight registration failed!\n");
>  		dm->backlight_dev[aconnector->bl_idx] = NULL;
>  	} else
> -		DRM_DEBUG_DRIVER("DM: Registered Backlight device: %s\n", bl_name);
> +		drm_dbg_driver(drm, "DM: Registered Backlight device: %s\n", bl_name);
>  }
>  
>  static int initialize_plane(struct amdgpu_display_manager *dm,
> @@ -6749,7 +6749,7 @@ get_highest_refresh_rate_mode(struct amdgpu_dm_connector *aconnector,
>  		m_pref = list_first_entry_or_null(
>  				&aconnector->base.modes, struct drm_display_mode, head);
>  		if (!m_pref) {
> -			DRM_DEBUG_DRIVER("No preferred mode found in EDID\n");
> +			drm_dbg_driver(aconnector->base.dev, "No preferred mode found in EDID\n");
>  			return NULL;
>  		}
>  	}
> @@ -6924,7 +6924,7 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
>  						dc_link_get_highest_encoding_format(aconnector->dc_link),
>  						&stream->timing.dsc_cfg)) {
>  				stream->timing.flags.DSC = 1;
> -				DRM_DEBUG_DRIVER("%s: SST_DSC [%s] DSC is selected from SST RX\n",
> +				drm_dbg_driver(drm_connector->dev, "%s: SST_DSC [%s] DSC is selected from SST RX\n",
>  							__func__, drm_connector->name);
>  			}
>  		} else if (sink->link->dpcd_caps.dongle_type == DISPLAY_DONGLE_DP_HDMI_CONVERTER) {
> @@ -6944,7 +6944,7 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
>  						dc_link_get_highest_encoding_format(aconnector->dc_link),
>  						&stream->timing.dsc_cfg)) {
>  					stream->timing.flags.DSC = 1;
> -					DRM_DEBUG_DRIVER("%s: SST_DSC [%s] DSC is selected from DP-HDMI PCON\n",
> +					drm_dbg_driver(drm_connector->dev, "%s: SST_DSC [%s] DSC is selected from DP-HDMI PCON\n",
>  									 __func__, drm_connector->name);
>  				}
>  		}
> @@ -7053,7 +7053,7 @@ create_stream_for_sink(struct drm_connector *connector,
>  		 * case, we call set mode ourselves to restore the previous mode
>  		 * and the modelist may not be filled in time.
>  		 */
> -		DRM_DEBUG_DRIVER("No preferred mode found\n");
> +		drm_dbg_driver(dev, "No preferred mode found\n");
>  	} else if (aconnector) {
>  		recalculate_timing = amdgpu_freesync_vid_mode &&
>  				 is_freesync_video_mode(&mode, aconnector);
> @@ -9201,7 +9201,7 @@ static void amdgpu_dm_handle_vrr_transition(struct dm_crtc_state *old_state,
>  		 */
>  		WARN_ON(amdgpu_dm_crtc_set_vupdate_irq(new_state->base.crtc, true) != 0);
>  		WARN_ON(drm_crtc_vblank_get(new_state->base.crtc) != 0);
> -		DRM_DEBUG_DRIVER("%s: crtc=%u VRR off->on: Get vblank ref\n",
> +		drm_dbg_driver(new_state->base.crtc->dev, "%s: crtc=%u VRR off->on: Get vblank ref\n",
>  				 __func__, new_state->base.crtc->base.id);
>  	} else if (old_vrr_active && !new_vrr_active) {
>  		/* Transition VRR active -> inactive:
> @@ -9209,7 +9209,7 @@ static void amdgpu_dm_handle_vrr_transition(struct dm_crtc_state *old_state,
>  		 */
>  		WARN_ON(amdgpu_dm_crtc_set_vupdate_irq(new_state->base.crtc, false) != 0);
>  		drm_crtc_vblank_put(new_state->base.crtc);
> -		DRM_DEBUG_DRIVER("%s: crtc=%u VRR on->off: Drop vblank ref\n",
> +		drm_dbg_driver(new_state->base.crtc->dev, "%s: crtc=%u VRR on->off: Drop vblank ref\n",
>  				 __func__, new_state->base.crtc->base.id);
>  	}
>  }
> @@ -10836,6 +10836,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>  	struct dm_atomic_state *dm_state = NULL;
>  	struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
>  	struct dc_stream_state *new_stream;
> +	struct amdgpu_device *adev = dm->adev;
>  	int ret = 0;
>  
>  	/*
> @@ -10889,7 +10890,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>  		 */
>  
>  		if (!new_stream) {
> -			DRM_DEBUG_DRIVER("%s: Failed to create new stream for crtc %d\n",
> +			drm_dbg_driver(adev_to_drm(adev), "%s: Failed to create new stream for crtc %d\n",
>  					__func__, acrtc->base.base.id);
>  			ret = -ENOMEM;
>  			goto fail;
> @@ -10927,7 +10928,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>  		    dc_is_stream_unchanged(new_stream, dm_old_crtc_state->stream) &&
>  		    dc_is_stream_scaling_unchanged(new_stream, dm_old_crtc_state->stream)) {
>  			new_crtc_state->mode_changed = false;
> -			DRM_DEBUG_DRIVER("Mode change not required, setting mode_changed to %d",
> +			drm_dbg_driver(adev_to_drm(adev), "Mode change not required, setting mode_changed to %d",
>  					 new_crtc_state->mode_changed);
>  		}
>  	}
> @@ -10965,7 +10966,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>  		    is_timing_unchanged_for_freesync(new_crtc_state,
>  						     old_crtc_state)) {
>  			new_crtc_state->mode_changed = false;
> -			DRM_DEBUG_DRIVER(
> +			drm_dbg_driver(adev_to_drm(adev),
>  				"Mode change not required for front porch change, setting mode_changed to %d",
>  				new_crtc_state->mode_changed);
>  
> @@ -10986,7 +10987,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>  		if (ret)
>  			goto fail;
>  
> -		DRM_DEBUG_DRIVER("Disabling DRM crtc: %d\n",
> +		drm_dbg_driver(adev_to_drm(adev), "Disabling DRM crtc: %d\n",
>  				crtc->base.id);
>  
>  		/* i.e. reset mode */

