Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5AE1C3ABAC
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 09:09:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67E9F10E075;
	Tue,  6 May 2025 09:09:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TyWcUNBC";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2040.outbound.protection.outlook.com [40.107.101.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F8C710E075
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 09:09:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p8Id/XR0DyJieom6hzqkmOjFBOgaHOxJiyopz+yBm0MzHfsJl7tSOx37KvGm9hsm8G5il0Zh3SycXPjIokAy7o1fBSbZMp8Udzpcx+EYTaUTwLuyzt3KxjNCDAuMejNMkhPO1Qpu8Aw6n96na2kiE9KOPWhFTjcz7RrSW7P+bJpXl6/G5oXdt7bS2omsfbr3UdQQQOm5thZSputiLaojsl1mzMIcJWTsSXW+k8MNfsyF/z4m+HxcwUah0fY+JTiLTaT96ba3oDYRY2fzpBFuyz3qajYWDGWBzKcXQU29lqfJ/8p24O5AD8+f3Qp/w3GN/3vS1fDz0UHF3DTlQPDIBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CeaTqqKNh2jCTnuEOK00rYR6WDNO/q+kotaIyFfU38k=;
 b=I01vx3xa786ETYCwfhcks5ypefewmGvbm5SCO6Iw+W/E/JAABLSye7bjU+xtHD8d/FZ37xXEiqZRYGGJR3aKTcrDW/IBr7cjZFQEjnQmVYu7xDjbd/XrKIW02L+HOTPmuL2NoibikLMNMpLd8gL9/nZ+7ieRoJ/o3sxnK5ADlUFM+mDkv5+jFsXu7I48LbXFmB+G3sDhrdigUEua7p4ZHC7ULx0eGymqQrG9+44LyYVQnKUu4CvkkZu+w7p2DYAyslfOT3hCobSn/s+aEV423P/MOIFTFJx3SH1G/D9jkZvuCa/ovoSM87x2LK7IJpdnR5NyxQaX0b9PudpTm7e3Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeaTqqKNh2jCTnuEOK00rYR6WDNO/q+kotaIyFfU38k=;
 b=TyWcUNBCLYta4ib4nGF54yHQ2IRgDeBSS/IP/qMG7Ksq1JCcqtAOmsbm5ajsIz2GLhCL8ECFozffZW0vSRvFnz8dSDx+vOYZH/GDAaLC0LVN7MTW5yRmrg3CljdWzeMdD+hIlQYY/dI3x1OM7sJBk9Y+ViSptZ+2rNo7bGPXQ9E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB5604.namprd12.prod.outlook.com (2603:10b6:303:18d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 6 May
 2025 09:09:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Tue, 6 May 2025
 09:09:12 +0000
Message-ID: <d77a97a3-ca55-4b75-a2de-6f786174f612@amd.com>
Date: Tue, 6 May 2025 11:09:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] drm/amdgpu/userq: implement support for query status
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>
References: <20250430154809.2665473-1-alexander.deucher@amd.com>
 <20250430154809.2665473-7-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250430154809.2665473-7-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0136.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB5604:EE_
X-MS-Office365-Filtering-Correlation-Id: 291ffef2-983b-4a10-3218-08dd8c7daa86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0Q1TTVadlAwRmdWN1hDaTJNZkFvM1p2dmM5VTljT2xzOGdVeklUSVAxQlRs?=
 =?utf-8?B?SzV5clJnYjhzUTF1M3lRUm9XeElWaXl1Sm02MmZqenFTdVFoakg0UGlIRUhr?=
 =?utf-8?B?OTZnalQ4NkJ6Rm5EZXd4Vm13RVlWOGdieGNoM0NjK2JIUFRTaGhnZlErenFY?=
 =?utf-8?B?cC9TR3RNeWpWajdkMjdjTzJtcG5ZNmtnNUNIeXBJR2lIVVZsMko0VmREdmpC?=
 =?utf-8?B?TlJ6cUl0NzB3Y1Y4RGhOQ1VHelEyYWJPOGZ3WHVhYUVndUQrMVpSeGNxR1Vj?=
 =?utf-8?B?SjZGVlgzQm9JY2kwYmI2Y1Q2dFBDWGdZdmlNcTVtSm81N3F6RXpZelFWL2hI?=
 =?utf-8?B?WU50Z0VUdzBXQ1ZuQzdCSSs2ZlY1ckcxYk82U1RYMGRUeEhZUEhwaEg3c0k5?=
 =?utf-8?B?L3k4N2JoOGVqcmw3NUpjZjRDUDFWNnlYRDNRQ1RMTEJYakE4eGxFSEw5V2s2?=
 =?utf-8?B?R2xKdVo0YXpHc2ZNd0taZ1Z1N1ZTc2pIZ2FwUlI1Ylo1YTJwd1BPWTRjZmtn?=
 =?utf-8?B?dkprTjEvZGU4MW5kWFRzZ2NyK0tSSUdjRjIzR1owWno4N0ZmWGpwaVdpRU1j?=
 =?utf-8?B?U1JNZXJCWHVkSnNwa0ZDYi85ajIyRzV5aVFGK3h5M2hPcm5JOGRlU1pjbWsw?=
 =?utf-8?B?clhoa3JwSE13NDdWVysrZTlLZlRCR0cxQ3I2emZUcGJKTVBVRVlLVUE0NTVy?=
 =?utf-8?B?bS9lSnRCdGZDK0lyb0hlSjNEWFJGTjlIam9WcWlMK3Z1UU1qclV1RHpHLzh4?=
 =?utf-8?B?eWxnektiUE1Vb0VxOXJlTnB6RVVnTTZpL0pxT2o5THFxUDRtVkVKdE45NjZC?=
 =?utf-8?B?SmpzVk1aanBleDBqc1dkaVJDVHFDV2xsaFh1T1J4VllGR0d5Z0pvcG1ZVzgy?=
 =?utf-8?B?MG1ERU1TQTVQUEF4ckJNZWxWOS9vVkhFd0l5cGZia05tS2s5cG1PMjZRVkI4?=
 =?utf-8?B?cTA3ZlpXNWxFQnZ4UklKOWpBZmt5TndXY3daL0kxTjVmWDE1VDJiT1VwOGlj?=
 =?utf-8?B?QkRpamU4Tko2ZDkzS0IzQ0dKSGFDbWlqcTNEaFpwc0RodkNtZ2V5NEN3Nkp6?=
 =?utf-8?B?WEkvU2FyNWlUTnlqY1AyWUhzV2hmcXA5a0lIZUtreEpmNk1ocE9obmVTM2VD?=
 =?utf-8?B?NmtzdTVJenJQeTZralVkNnp6M3Faay9qcUtRcWhSei9zRGZGK0hDUmwzQ0Qx?=
 =?utf-8?B?SmtOU1ZNd3Ftem5pQUc4SjhMZitSd3JzRTFad1FZNGFFdFpXbFlVUHBoMUFJ?=
 =?utf-8?B?UGxCNUlDeUFDYzhSdENCWmhYdG03ZzgyMktpeGJMQ01zQmVuQmNDb1UyTXFi?=
 =?utf-8?B?VW1oNC8veHpnaXYxRzZQUHVFMkFuWld5NGVCeWpxSE1tKzBtdjdGMDRmQTkr?=
 =?utf-8?B?ajEzNnFxekk5S3NObE1OdEFvb2QvN3NBVEx3SC9uOTlLbStIb3FScHl3ekx2?=
 =?utf-8?B?RUdPaUU4QW1yNDlBRHpIdnluaVpJaDJHdUY2UEVrTGpnSnJSTGc2NHBGZ3l6?=
 =?utf-8?B?SE1tYThXTlVmQlkvbHVTNkJLTzRWSWs2Nys1cThhOU4wejBZVDUzQ2dlNUsz?=
 =?utf-8?B?Zy9QbG85MGoyU2NpZHZVNCs3czJNUW9zZi83VFcrZ1kxZmswWnJVUW04NUZi?=
 =?utf-8?B?enBnczNpeTdqL1ZnajZjSmhUWnp0QngrOHJweW5aVVVMVjNHbWxmWGVrWDF0?=
 =?utf-8?B?WUUwdUZQaFNqYVB0Nkx6UUlWQkRhd1NMRkpPWTB3OGZyMHhFK0lQYndVMHRH?=
 =?utf-8?B?dDFDYWYybDlZYllXaVZhRHNjU0FvdGFQRTlMV0ZDNXhWRmpTcHZEQ2kzZU9h?=
 =?utf-8?B?OW5DdGZ6ZVpuL3NwaTFoZlFnWTNVVFpQVFliSHJLL0cvZzNTWUNodW1ZUU5s?=
 =?utf-8?B?ZktuV3E5TXg3NmpMSkVtUjRwRm1uNVA4ZXNLQ1lkbjNSWWErR2tUbkFUSDZ1?=
 =?utf-8?Q?VXShr1bDoRQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djhxeU15OFhNa3pxMmE3WDRGR1g2cXpmcFBxV1k2NUxKMXAyc2YxSklmUGd5?=
 =?utf-8?B?Rk9jczVvNlZMRUh5MGRudzR4YnhXTUhiOGd4NlNLSWkzOGgxdjV5c0ZNUElE?=
 =?utf-8?B?Y2F6NEI3NFBSbXFzK1cwUFRGb1pqSWY2YUNGT1duRElVb2JoNmFqY1A5Y040?=
 =?utf-8?B?Sm5ocDRnbTRxUlM3SWRlM0ZWMmMwZURKcnBybkEyeElTSXZaNk5qdjM2SEli?=
 =?utf-8?B?bFMrYVYzc3Rha0pFbXlHWFpFbzJvZmovaStJQUdKeENNcm15WDlETWxwMklC?=
 =?utf-8?B?YllMK3BqVjA5bVl3MXlpbTZPSHRNaGN6ZVZVVkZzemExbm83dmw5SWNCakhz?=
 =?utf-8?B?ZE1RdmgyRlZZdUxqK1g2YUt4cUZYTVJtMjVUT0lhd2hzM3lQVDZURG4vaUEv?=
 =?utf-8?B?UEJVQXdiQWhZaTBIblJVMHZBUkJzeHhYN1VnYmNCYjR4QlFjWXBkb0xvSyth?=
 =?utf-8?B?MUpzcjFPTnJNNmw3UEJWV1Rhc1QyOFFXRUlPeWVZYitrb1MvMXdtTHhVVGpx?=
 =?utf-8?B?UmdsU3FiVFR4MmRaU3RDMStnRFg0czBTSGJZdVg4S2d5dVNmTG44YXNiVG1y?=
 =?utf-8?B?WTd6VFAzU3Y0c25MV2J6Q1BmaEUzRDFjd3g0djViQ0NDUUE0RnA5dlZaQkMv?=
 =?utf-8?B?UzVPbTdGcUE1NzloU1NjREQwSXFDYndvTEpldHoyamplai9DcTgyL0JqaXV2?=
 =?utf-8?B?bjh2NlpwZjhPd1gwSzlUSjRLa1g2Uk1sUDM3endDRStYVGdMWDlWbmxZMWVH?=
 =?utf-8?B?eWhNOU1tQUhLdUFqZjFiNkRaOCtwb0l0eERkSEZwZkE0TWFMU0RHYUdxNXlp?=
 =?utf-8?B?dlYzSUUzbjRvYWVTRlA2UEJ3R2FBTFg3MEp1Z1VSOWpadXFXVG5vK1lxRm1a?=
 =?utf-8?B?NXhHRlVzSU1yTzl6dkVFb3ZGVnRHTHU1MFRLWjZpMW5FNlEveHh1WHdFbmlL?=
 =?utf-8?B?a1pTNUtHeVNZSXNsbUxma29qRkwyR1NuZFplQlVuM25uWkRXWE1MVlRmNjI3?=
 =?utf-8?B?ZkJqQXpDdWEzRGdVQnN6b2VYOVVoeVpqSjM5RlFDV2tOb3lQWDlWOUVuYkxI?=
 =?utf-8?B?UjkyRk9PQUgvQVVGMllEMERMMWRVc2k3bmRmMGNVNDdjNjVaMEJZcnBlNHRr?=
 =?utf-8?B?Q3RsNlFYWlAram9QaGhsMk1iUTJnZHh3ZnBzdHhVem43cm5BaHhJSVQwQUUy?=
 =?utf-8?B?NS9JMEZGL3UwRmxXcGsyNTR3QkpNZ29YdWU2NUxBMFlFSXNnSERYaXdFTyt3?=
 =?utf-8?B?eHhaTFlmdUdQaFdKK1ZsSmJiMHBwQ3hEdW9TempvT08zYkZ1RlVxbVhHK0gw?=
 =?utf-8?B?QmFwdXQzRWt6Z3ovRnpoR21KS2lvcmt3SEFielZmYXdhazI2RlBpOGpmUnBv?=
 =?utf-8?B?OUxKblBmN1hFUzFOYkJkc2N5d3JJdUZUcHM0dzhjOUhiRVQ0c0ZENjl3dkla?=
 =?utf-8?B?azR1U2ZsL2xRc3E1cDVTNjNXWTVWbTBOUjlEMzNPMnVGSDZJUUh5SEo2b1Ny?=
 =?utf-8?B?VkpkaFd2TWJtTnp2THhFalBXYVVhQ1g1TTRITVljUlQzN21BbG94SlNOOFVR?=
 =?utf-8?B?c1ExYTFaL2I0NCt5UEpUVnY5eEtkWDJscWxDZmJZcHlmQzRkczhTRnBSS2x0?=
 =?utf-8?B?Vm8yMG5QVWlWM29nOUJ4Ym9DRjlpOVVhNWVKbVI3alhzald4L0VmeDNPZnEw?=
 =?utf-8?B?ZkRRZUQvbG9md1FaU216UE9JRjNEcExOR1Fkc1I2UE5KQm16MEJ5RTluMUk1?=
 =?utf-8?B?RXJNb0x3Ly9OTkgwT0oyeWZxQ3RiTzJYNE0xc2w2UUtnamQxRUtjbkxUckdk?=
 =?utf-8?B?eU9UMTBZd3NhZmJDUHFiUkpOT3A2V0dxeHl0NE1CY3RhZU9FZXJWWlpXK1BM?=
 =?utf-8?B?TFBYem1HZ2I1RFFLRkRkTE1SNkxZcFVaUzN6VkZBR2d0MkJuYUhKQzhjL2dH?=
 =?utf-8?B?dDNXMXIxV28zb3ZWbFJOa3NucENpbHFZZkNrK2NiRUpFYm5kYjhCclk1M0Jl?=
 =?utf-8?B?T2JGK2NUWHdraDRwdVVkcEg4dkROSkI3aUdLUW83cjI2MW5UWTlwYVVJVjI0?=
 =?utf-8?B?SDVNWjE4d0tpZDlCN2JaNXhNT2hIeXh5aDdNTEV1dGVLMlZRdno5Q0pOcHR1?=
 =?utf-8?Q?y/UmmOt23c+aCF8Kpl0ef2zep?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 291ffef2-983b-4a10-3218-08dd8c7daa86
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 09:09:11.8876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MzWVDyj/4m6a4SpF1aXOEpSEeialfZDYRSLEI17vr+Fz1WZlE9Cbl12vfDjXbud/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5604
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

On 4/30/25 17:48, Alex Deucher wrote:
> Query the status of the user queue, currently whether
> the queue is hung and whether or not VRAM is lost.
> 
> Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 47 ++++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  1 +
>  2 files changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 4be46fa76ceba..e56fae10400db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -460,6 +460,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	queue->queue_type = args->in.ip_type;
>  	queue->vm = &fpriv->vm;
>  	queue->priority = priority;
> +	queue->generation = amdgpu_vm_generation(adev, &fpriv->vm);
>  
>  	db_info.queue_type = queue->queue_type;
>  	db_info.doorbell_handle = queue->doorbell_handle;
> @@ -532,6 +533,34 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	return r;
>  }
>  
> +static int
> +amdgpu_userq_query_status(struct drm_file *filp, union drm_amdgpu_userq *args)
> +{
> +	struct amdgpu_fpriv *fpriv = filp->driver_priv;
> +	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
> +	struct amdgpu_device *adev = uq_mgr->adev;
> +	struct amdgpu_usermode_queue *queue;
> +	int queue_id = args->in.queue_id;
> +
> +	mutex_lock(&uq_mgr->userq_mutex);
> +
> +	queue = amdgpu_userq_find(uq_mgr, queue_id);
> +	if (!queue) {
> +		dev_err(adev->dev, "Invalid queue id to query\n");

Using dev_err is probably not justified, this is more debug level.

> +		mutex_unlock(&uq_mgr->userq_mutex);
> +		return -EINVAL;
> +	}
> +	args->out_qs.flags = 0;
> +	if (queue->state == AMDGPU_USERQ_STATE_HUNG)
> +		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG;
> +	if (queue->generation != amdgpu_vm_generation(adev, &fpriv->vm))
> +		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST;
> +
> +	mutex_unlock(&uq_mgr->userq_mutex);
> +
> +	return 0;
> +}
> +
>  int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>  		       struct drm_file *filp)
>  {
> @@ -565,7 +594,23 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>  		if (r)
>  			DRM_ERROR("Failed to destroy usermode queue\n");
>  		break;
> -
> +	case AMDGPU_USERQ_OP_QUERY_STATUS:

> +		if (args->in.ip_type ||
> +		    args->in.doorbell_handle ||
> +		    args->in.doorbell_offset ||
> +		    args->in.flags ||
> +		    args->in.queue_va ||
> +		    args->in.queue_size ||
> +		    args->in.rptr_va ||
> +		    args->in.wptr_va ||
> +		    args->in.wptr_va ||
> +		    args->in.mqd ||
> +		    args->in.mqd_size)
> +			return -EINVAL;

We can't expect those fields to be initialized for this operation. So checking them is probably not a good idea.

> +		r = amdgpu_userq_query_status(filp, args);
> +		if (r)

> +			DRM_ERROR("Failed to query usermode queue status\n");
That message is overkill we already have the message inside amdgpu_userq_query_status().

Regards,
Christian.

> +		break;
>  	default:
>  		DRM_DEBUG_DRIVER("Invalid user queue op specified: %d\n", args->in.op);
>  		return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 6ede08dd821d2..35a08ee59d893 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -65,6 +65,7 @@ struct amdgpu_usermode_queue {
>  	struct dma_fence	*last_fence;
>  	u32			xcp_id;
>  	int			priority;
> +	uint64_t		generation;
>  };
>  
>  struct amdgpu_userq_funcs {

