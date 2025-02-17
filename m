Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC2DC021A0
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Feb 2025 09:57:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F04810E3A9;
	Mon, 17 Feb 2025 09:57:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g56tr0Ro";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAEC910E3A7
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Feb 2025 09:56:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+s1dvqatcsqRJHEgb6i85zx8BEl2Wgf0KpMRhM9btP6hu+LN2VkKoCmvQ7JpV/c+x6Nkn4NIIEAPWWLGMeAAPjE2c4KpWxLknuR/hGYk1Y3LeougvERSeCh2cnJ1dj4TLvQihgJ/8FSK24w4lnhkvuLXjDKxE1Eg4Mo8p4YFuVIkXcKfygZ3Y6jxeY0NDd2ZCV3pkkAC40Sl6vxgu0Jh9U5RkbV+nip7HXUl2viFDePzTy/onGUh0T+s0F27vOd8ADFSbGrUk9IUz7L46/+5GRFXTL8X4aRgBklAFYIZOMcGohxB66s1l8XJRFrX89cVHBCOwTRpUJPgOwG0qFs5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9UCgavn+AYh8GL5MCXjQwg0zVkrgZxKj3pdpBCmq04=;
 b=psdR/iSxxpkYI8Mf+LMAETJuIH+9srwVlSwBGoMW3jqJqYyDELIVHAwW/VslS4ie5U9SZZwtmfWrCvWeA0GvpH6TjHcQL3WqegMDw6ZE+p0z5HPprPSKs57zEBUj5eHFGoED9UcgXJOgqVwbCCYjR3ya3MLCYR/d1QUmvtAIRSCQVaY5/nfXwRnMtwfiZ4SVKxFmPhnPFh8XBzF15mfvxWmXD/cd4Y1xg/P6SPvk7yAVxCL9fgbLw4r0vEZ08SnIZq/hE48kjGSw+wc3S9r/tIFdBv53C53z2wQorr/R9j+toT4mdPAdv0LzUSvHj9dXNpHNAjwsU3ZAGS47NZ4N4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9UCgavn+AYh8GL5MCXjQwg0zVkrgZxKj3pdpBCmq04=;
 b=g56tr0RoIZYVoHaBifB75rcWBqune2v8ig7npHzd2bCUwfHExLG+GKX8QNsc4Tf7tcLc+sKxvJDq1k7VYj72hObCEDPrl5UcAwpJ7suGjhpcMswJSfPJetBoUlRkd8vGdvAt3ikD8vHhgl6eTek5qZnKJI1RAIJAs9ojyQ3SKf8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH3PR12MB7522.namprd12.prod.outlook.com (2603:10b6:610:142::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 09:56:56 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 09:56:55 +0000
Message-ID: <2d8664b0-0765-4538-8021-05e306adcb97@amd.com>
Date: Mon, 17 Feb 2025 15:26:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdgpu/pm/legacy: fix suspend/resume issues
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: "chr[]" <chris@rudorff.com>
References: <20250212161129.2712730-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250212161129.2712730-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0090.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::35) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CH3PR12MB7522:EE_
X-MS-Office365-Filtering-Correlation-Id: d767ca02-35b3-41d9-1a39-08dd4f396934
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WEhkckFZRHZmYkZRdEFsZ2JNLy9pSEZhK0ZaOGlIaWhJUEs0bGJsSmZEREI5?=
 =?utf-8?B?ZHdmc3BWRkN0SVIrZVI4R1VwekdSV05MVUpWNUoxS0x1OHZSbE92ZkVqSXUx?=
 =?utf-8?B?S3RvUVhFUnpnVkZaTndqTURYNUJCSXNNUUtaaUhsQUJaYm0xYjJ6bzRFdks4?=
 =?utf-8?B?aWRpTDVaa2NENkU0TVVTOFlUUlV3V1pTeU9peWlKbXJqZm9HbWhFUTJSQjVC?=
 =?utf-8?B?ZUM1b0FCQzhvM3Z6clNTejcwVlFRdkJyVGhmblpRQWc1c2R0b0UyaktGWm14?=
 =?utf-8?B?Nng1enkxQTBVNFNjYmg5eUhZVEFnYjIyei9lQ0xrdU5QNXA5VDJKc1RvRmNv?=
 =?utf-8?B?bFR6aGNFSGtnTXMxVlBLdUpTWFZjOEZvWm9YK3FOalZlRHBYOGlMbHJrRjBH?=
 =?utf-8?B?Z0FodjZ0TFZaTmNISEhaWjFCRENDTkJQa1A2ZnhTejdXZHpFbWFmM0pFNkJR?=
 =?utf-8?B?aWNrWjRISC9FMWhKT04vS21DUVJrd0hHcWg3ck5tcXY1NHllS0hnUUM1VG54?=
 =?utf-8?B?VXBaKzR4SDUzMHQ4OXpHZ01VaytqWEdMVHF0UHNlbVdVdUJpN3hTQjMyRkw0?=
 =?utf-8?B?aUM2Y1c4SGMyVVI1ZGVoUnlnQU9xMXlZbFNaUHBrRDlGcUdNQjhYWVBmYjBo?=
 =?utf-8?B?bVVySEl4dTRkRXhhdVVxckx1Ni94LytpdVR0OEN5M1BjeXJMOUROWldrdllP?=
 =?utf-8?B?SHUzKzJjc2ozeVBLN24zclpWeVNHS0wwaGRXNHhKMklwNER0YVZOZjloSWQ2?=
 =?utf-8?B?NjFTa1FCd0poNWlHN01ReWdEZU91bHNrR3I5U1dlbW81dDcvU3RkcWZqK1Jm?=
 =?utf-8?B?ZzlaTTkyejZINlVBQThJZWlVTVhpNUpwcE9PblROYUprSGNzV0t2Z2dHM0ty?=
 =?utf-8?B?emNnRDFtd2lhdTRvOEJ6L3M0bHNIaEFTNVM3Q3pSSlQvc1FZWlZhWVJNeXJm?=
 =?utf-8?B?YnE0c212Y3RBUVdJKzZaYXdCUnd1dW1wSG1qN0s4SHBaYTBrWloycDYxb2Ur?=
 =?utf-8?B?ZmRjWXJiY2tWVXhWRlZaQzBLUlNyS2g1YkxreGRNSDAvTjdwVldmaWV4K0xw?=
 =?utf-8?B?QjRWdFhOb3B1U0RzbUQ2V3hmd0tZM082ZFp6L2RGM3pENXJSaWxKUnk4ZDBw?=
 =?utf-8?B?TGZGemVieHFmYm5aY2N4c0x0elEydGtLbGw0SFlmbHJZRnNZTlB4NUxIeEJk?=
 =?utf-8?B?RGtFejg4V3RLYUNzOEdoOS93UVBPNjVWaGU2bithMjEzUnNqWDI3UVFjSW1Y?=
 =?utf-8?B?TmNOWERabGhHWEtuRTNkOFlCQW80eHoxNjE2Q3JuMG9XNXJnaEdYOFJqYUFB?=
 =?utf-8?B?ZzVoT1lTNkJ0c2htamJEckltSWcvREVNNlBWcnl6OGtuMzdyMGV1Vmt6ZzZW?=
 =?utf-8?B?b1JDRk9jaEI0cUZIbDlpeEg4ME8vM2grKzZCWFUzbEZWUURYc2tQTDREbWVH?=
 =?utf-8?B?amEvVy9XMkdTcXVBUjVhUUUwWnRrLzV3OVB2YWhxcWN2SEsvQkVoM0cxSTdG?=
 =?utf-8?B?Sy9VS1F2THovVGZ4WDFQR3RxSXlkOXk1TnlqdHQ1K1J4Mm9hTlZQZHVPUVcx?=
 =?utf-8?B?N0ZRc2F2dWRBM25mQ2dlQmZWQ2NLMEFObCt6a0lmSEdkaEpERXRJVFAzTGN4?=
 =?utf-8?B?aHFCMEdvRFZKK2JHY2ZNV0E4WTRhY1IrYVRDR1JYUXYxbkU5elRnNlVETzJE?=
 =?utf-8?B?Mkt3MWlMWVFHRy9RTnJQeGlFeU5RZjRSL2pqK2ZpajFQVUVMaUdRQ2MwMG5v?=
 =?utf-8?B?MVpxMmNCa0NncmlwUUYxVWthVi9sbUtGME53QVBVYlp1ZGR4QTBVZ0t6STB6?=
 =?utf-8?B?N0lUb2FXcHBoS1pCY1Irdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTRjdWp0YThxbHVWekRjNlkyMllJNVZNTXhHcVRzd3NERy91cGFXa2gzaVZ3?=
 =?utf-8?B?am9DelJna0R3SXo0TU5mNzUyRlo0OEZOei8vMHU5a1RLUE52Z1haa0xoWjg3?=
 =?utf-8?B?SVZBUng5K3BYSFNDOTRzR1lvTXVrVUgwYWtPZ0toWXU0S3RvVUVtbjJaanVR?=
 =?utf-8?B?SU9uSjZYK2FBTnhJWkZUUzFSa1lJZG4yVVZReUEwdFgwcDVsajdVd0ZDNER1?=
 =?utf-8?B?RmFQbnFqYVNqMkg0WWZqbk51REVUanBFKzc0UEpDbHZiK1N2UHVEK2h4QStZ?=
 =?utf-8?B?TjRlZDF1TEpaaWFVTVgyWi9DWHV5UHVGbDJWUXFXQUVlK0N1Z2h1SHYrZEZa?=
 =?utf-8?B?NjVFY2lSMHZqS1ZvdlpIYkJwbHpFcEJ4b0Jsam5PMklXY3JIRnE3WXM4eHgx?=
 =?utf-8?B?TUNPYmVlLytyZXMybFhiQnZRRmpjNGVYVUV6SzREL2c0b1lQbGtFbWZqbzFm?=
 =?utf-8?B?RlpNQlFiU2RtYlVzZkMvNEQ1cGhkMDFIcE93aFFpVFdnN05zNVNKT2dWd2sz?=
 =?utf-8?B?azcvamc0OURvOFFzMm5xN1VOcmNGaE9vRFI4dlBCUUFCRHlHd1VJWGJpeGg1?=
 =?utf-8?B?Uklpazg5TEJhNHdVVDZ5NytreDVDQ1l1TThrZ0JaUk1qTStWTStVR25EK09G?=
 =?utf-8?B?RzFrMU04NFJEeDZCVmhWQlBWaW9FTzZPbU90NmNuRkw0dU5UVkhMSGxLYXdl?=
 =?utf-8?B?K0x1VmpOdmt3SjRlL1JzNVNHSU5oaDRlTlBKY3JoOFpEUXJhcEpvMGttcEdv?=
 =?utf-8?B?M09DWHByWGhwOU1NeWFoRGJxWmVHWmgyczEvRGFXYm1oTzJJTElMeTFvMmpM?=
 =?utf-8?B?MzNROHJLUmJsQ1lYRlpLL3F2enpiNVZkVmpmcUltZmNPOUhEUGZ1VFFYbFhK?=
 =?utf-8?B?VkU0L3BFOW13dElXSUJ6cWJna2hKZDFnM3RWY0o4T1FoUWZ1VW9PR2hGZCtW?=
 =?utf-8?B?QkJVa3FPenJQK2lnbE9SakVoOXBmSjFNSmJ4eTdhbVU0MmkzdTlYN2RQQ25i?=
 =?utf-8?B?bWpobUF3Y2tYaE5tRzl5cWdWTGdPU29mWmQxVUVwRG5OOXVVRHZIRWlNQld3?=
 =?utf-8?B?eGptOVE4Z01WUXdSR1Fra1VqK2lzZ3VFazdGdHVpa091VFljS2RtSjZ6MXl2?=
 =?utf-8?B?eDFoaHJTYlU5b24wenJOcHprUjMxbUFOZjBTWCtLaGNZVEVTSjA4K043aUNx?=
 =?utf-8?B?c0twZWRXNzRidGJ5allIRzZieVdUaUxBQlBEdWc3U2ZGbnBCZFdkNmJmZjV6?=
 =?utf-8?B?QmpaZTRUSjB4dFhJL2RmdWkyc1VaUUExeUlKM0Z6Nkw5VkI2RlNtTTYrNGti?=
 =?utf-8?B?TjI2NkVQK083Ni8vWTlPMURwU3lQR05RMzRPd1FNV1g1YWk2WldZTnlIRFpu?=
 =?utf-8?B?ZW9GaHV5RGxVTnQ5MFBIQStKYXJuYkJYVUJGVUI4R2lpYTNGK0hnWkRFTkc4?=
 =?utf-8?B?ZWFCQVRBS2hnNW9sODRzWmtwU1N3NTVteFcvb1VFbXZWRWUxY0tUOWthSjNN?=
 =?utf-8?B?SzhhUStTbHFvNnNINmRrME5xbzhiUWFkcUZzREpuN1M5bW55QjhjOHNzYk9H?=
 =?utf-8?B?QlptRDVJRW9xV2lVN0ZqUDdDSEZkc05yRzFPOE9aVzhsNjFXd2JtTzNPYmow?=
 =?utf-8?B?RWdtNEtubE5OR3BpbHpEa0owU2t5akl2dWxiSHVvSFh4dEpsS1BPRjVWbzBD?=
 =?utf-8?B?VVcvUGN1dVhOZW9DUlJZdXJhalZrWDBENzIyQ1lLYUoxN1NaK3NrUytwMXpY?=
 =?utf-8?B?d0VlcG9wajB1T3hvSUk1QTB0blJDTUxzVHRCVjhlWU5JSk9ZS3pTZk11eWZV?=
 =?utf-8?B?Y3B0WDAwTFJqSzIycVFQRkFldEV1b3RxQm5uUWlrNS95Ni9vd3hyWG1ZRFVK?=
 =?utf-8?B?MkhacWlwbEtWSjV5ZXQwTHpVMm5obzlKTk96REFOaWpMVmtIL0ltNnJMOTBO?=
 =?utf-8?B?QVQ1bWFMZEo1YUhkdEtkMWNaY3U0TFNoc2cwMGozT3JwaVpMTmJqVGd3UUNR?=
 =?utf-8?B?T2F4d0E2KzFJZXVCSGsvb3NXNGNreFJPYWRGZCs4THQ3YmhwajNyR0M3K05y?=
 =?utf-8?B?WFhiQTlDNjVLTFhvOUMxOHE0YXNyK1hmSVRvUjdnMkc0aS8zNkJEdzZqb0p0?=
 =?utf-8?Q?V30GjYi+1k/Ei3ai9/PabEIO9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d767ca02-35b3-41d9-1a39-08dd4f396934
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 09:56:55.6853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R8s359bKfjHQvEkd3oc8TlUgy9vg3pV1wVoEY7OTIVVP+4Z9PxibFjUEiGdQ+E4n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7522
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



On 2/12/2025 9:41 PM, Alex Deucher wrote:
> From: "chr[]" <chris@rudorff.com>
> 
> resume and irq handler happily races in set_power_state()
> 
> * amdgpu_legacy_dpm_compute_clocks() needs lock
> * protect irq work handler
> * fix dpm_enabled usage
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2524
> Fixes: 3712e7a49459 ("drm/amd/pm: unified lock protections in amdgpu_dpm.c")
> Signed-off-by: chr[] <chris@rudorff.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    | 19 ++++++++++++++----
>  .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    |  2 ++
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    | 20 +++++++++++++++----
>  3 files changed, 33 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> index 67a8e22b1126d..db0d3d4dba685 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> @@ -3042,6 +3042,7 @@ static int kv_dpm_hw_init(struct amdgpu_ip_block *ip_block)
>  	if (!amdgpu_dpm)
>  		return 0;
>  
> +	mutex_lock(&adev->pm.mutex);
>  	kv_dpm_setup_asic(adev);
>  	ret = kv_dpm_enable(adev);
>  	if (ret)
> @@ -3049,6 +3050,8 @@ static int kv_dpm_hw_init(struct amdgpu_ip_block *ip_block)
>  	else
>  		adev->pm.dpm_enabled = true;
>  	amdgpu_legacy_dpm_compute_clocks(adev);
> +	mutex_unlock(&adev->pm.mutex);
> +
>  	return ret;
>  }
>  
> @@ -3067,10 +3070,13 @@ static int kv_dpm_suspend(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  
>  	if (adev->pm.dpm_enabled) {
> +		mutex_lock(&adev->pm.mutex);
> +		adev->pm.dpm_enabled = false;
>  		/* disable dpm */
>  		kv_dpm_disable(adev);
>  		/* reset the power state */
>  		adev->pm.dpm.current_ps = adev->pm.dpm.requested_ps = adev->pm.dpm.boot_ps;
> +		mutex_unlock(&adev->pm.mutex);
>  	}
>  	return 0;
>  }
> @@ -3080,18 +3086,23 @@ static int kv_dpm_resume(struct amdgpu_ip_block *ip_block)
>  	int ret;
>  	struct amdgpu_device *adev = ip_block->adev;
>  
> -	if (adev->pm.dpm_enabled) {
> +	if (!amdgpu_dpm)
> +		return 0;
> +
> +	if (!adev->pm.dpm_enabled) {
> +		mutex_lock(&adev->pm.mutex);
>  		/* asic init will reset to the boot state */
>  		kv_dpm_setup_asic(adev);
>  		ret = kv_dpm_enable(adev);
>  		if (ret)
>  			adev->pm.dpm_enabled = false;

Need braces here as well since else part is with braces.
> -		else
> +		else {
>  			adev->pm.dpm_enabled = true;
> -		if (adev->pm.dpm_enabled)
>  			amdgpu_legacy_dpm_compute_clocks(adev);
> +		}
> +		mutex_unlock(&adev->pm.mutex);
>  	}
> -	return 0;
> +	return ret;

Possibility of returning unintialized value.

>  }
>  
>  static bool kv_dpm_is_idle(void *handle)
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> index e861355ebd75b..e06c25c945007 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> @@ -1012,6 +1012,7 @@ void amdgpu_dpm_thermal_work_handler(struct work_struct *work)
>  	if (!adev->pm.dpm_enabled)
>  		return;
>  
> +	mutex_lock(&adev->pm.mutex);

I think taking this lock should happen before the dpm_enabled variable
check. Otherwise, it could happen that part of this sequence might still
go through after a kv/si_dpm_suspend.

>  	if (!pp_funcs->read_sensor(adev->powerplay.pp_handle,
>  				   AMDGPU_PP_SENSOR_GPU_TEMP,
>  				   (void *)&temp,
> @@ -1033,4 +1034,5 @@ void amdgpu_dpm_thermal_work_handler(struct work_struct *work)
>  	adev->pm.dpm.state = dpm_state;
>  
>  	amdgpu_legacy_dpm_compute_clocks(adev->powerplay.pp_handle);
> +	mutex_unlock(&adev->pm.mutex);
>  }
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> index a87dcf0974bc1..c40ec4f74afb0 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> @@ -7786,6 +7786,7 @@ static int si_dpm_hw_init(struct amdgpu_ip_block *ip_block)
>  	if (!amdgpu_dpm)
>  		return 0;
>  
> +	mutex_lock(&adev->pm.mutex);
>  	si_dpm_setup_asic(adev);
>  	ret = si_dpm_enable(adev);
>  	if (ret)
> @@ -7793,6 +7794,7 @@ static int si_dpm_hw_init(struct amdgpu_ip_block *ip_block)
>  	else
>  		adev->pm.dpm_enabled = true;
>  	amdgpu_legacy_dpm_compute_clocks(adev);
> +	mutex_unlock(&adev->pm.mutex);
>  	return ret;
>  }
>  
> @@ -7811,11 +7813,15 @@ static int si_dpm_suspend(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  
>  	if (adev->pm.dpm_enabled) {
> +		mutex_lock(&adev->pm.mutex);
> +		adev->pm.dpm_enabled = false;
>  		/* disable dpm */
>  		si_dpm_disable(adev);
>  		/* reset the power state */
>  		adev->pm.dpm.current_ps = adev->pm.dpm.requested_ps = adev->pm.dpm.boot_ps;
> +		mutex_unlock(&adev->pm.mutex);
>  	}
> +
>  	return 0;
>  }
>  
> @@ -7824,18 +7830,24 @@ static int si_dpm_resume(struct amdgpu_ip_block *ip_block)
>  	int ret;
>  	struct amdgpu_device *adev = ip_block->adev;
>  
> -	if (adev->pm.dpm_enabled) {
> +	if (!amdgpu_dpm)
> +		return 0;
> +
> +	if (!adev->pm.dpm_enabled) {
>  		/* asic init will reset to the boot state */
> +		mutex_lock(&adev->pm.mutex);
>  		si_dpm_setup_asic(adev);
>  		ret = si_dpm_enable(adev);
>  		if (ret)
>  			adev->pm.dpm_enabled = false;

Same 'braces' comment.

> -		else
> +		else {
>  			adev->pm.dpm_enabled = true;
> -		if (adev->pm.dpm_enabled)
>  			amdgpu_legacy_dpm_compute_clocks(adev);
> +		}
> +		mutex_unlock(&adev->pm.mutex);
>  	}
> -	return 0;
> +
> +	return ret;

Possibility of returning unintialized value.

Thanks,
Lijo

>  }
>  
>  static bool si_dpm_is_idle(void *handle)

