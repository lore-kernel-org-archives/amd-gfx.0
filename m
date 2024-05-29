Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F74CC25B75
	for <amd-gfx@archiver.kernel.org>; Wed, 29 May 2024 21:07:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68F5911354F;
	Wed, 29 May 2024 21:07:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oz/mQcSa";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1C60112614
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 May 2024 21:07:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OsxPOTpwflX4gjnZDrY00cv0U+/U8dzOs4ORsy5Cxi+l696g9vLBJpGkjOk/aUq0OJLjAz/Ozf60pohrMxDhZdoqsmmGe16vMFkOTD07qZcqCIG1uHvigWPTDtGVVPnwHukk2g1nO3LQZWc57lbg9NY+X/2Dz8UKGRftgpdCYtXsD/ILJHtBC2aSrCFJiXKOm1bGWT1ggCb1x9PUg5q4rw56UviqP3hvxz2a+kH7TcGmRCkGwLj5Rt/LEvyITM18aa2oNqk+YJwtqin7JqFe1snHZDvKuJPT1j2xpwBAyayxTe9nWf/dF4T6uD9rv6sROhy6JlidU9oQoI0pO5nYjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9sA5nZXbQRxcCSguq2g6eM9b/ObSZ5I0crPgsnE8xI=;
 b=d63lDyfvvOiHOkoToA1573b7XEHgapt0Gbp66SQ1VADRSZ4q3E/ehDjP+rZh7P1f8xBPQwfvFhS2YcFDz42Tq9J3EU+j03XpGDaP2GDasQFHSrqdUdE/TRfHjuh2L9DBBekoMOhBXfWWUkmxdzEBiaWyxIR5NdhADge4+i+5owJiQWCqi0DbsuwcNI/8wVd4up8ORJzJyaL2JNIT0djiSI6llUJ0Fmkqw1Wv1D89nvNUmc5lU7Et/jmB8JGC3x555SJl81FOKu1l5I8is88fNKdUOMluoQsuj30dfLKaF1Ehin4//FV+rBElKKcBxrRbxsTYvWsDjSgaAfV7b38G/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9sA5nZXbQRxcCSguq2g6eM9b/ObSZ5I0crPgsnE8xI=;
 b=oz/mQcSaXEW2WqO3N/guuw/m5a5VIP6z0owgkT7OQhWugqypIjEZfjCLA0hfJeb/j288OQRpYgzQCuFAK9+k8M2NBIyoXZ5XmNI5UM15tpn9kGpulyZJURiWARx/nDtkwv+bpKT4K12bEBWUN/B8NCIJOIdqSkDRmMJIk0d/Los=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9)
 by IA1PR12MB6041.namprd12.prod.outlook.com (2603:10b6:208:3d7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 21:07:41 +0000
Received: from CH3PR12MB9079.namprd12.prod.outlook.com
 ([fe80::8c67:8cec:7c4a:ccaa]) by CH3PR12MB9079.namprd12.prod.outlook.com
 ([fe80::8c67:8cec:7c4a:ccaa%4]) with mapi id 15.20.7611.030; Wed, 29 May 2024
 21:07:41 +0000
Message-ID: <8e841161-f811-4758-a279-fe1c1f261cfa@amd.com>
Date: Wed, 29 May 2024 22:07:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Handle deallocated VPGRs in gfx11+ trap
 handler
To: Jay Cornwall <jay.cornwall@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240529193546.817200-1-jay.cornwall@amd.com>
Content-Language: en-US
From: Lancelot SIX <Lancelot.Six@amd.com>
In-Reply-To: <20240529193546.817200-1-jay.cornwall@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::7) To CH3PR12MB9079.namprd12.prod.outlook.com
 (2603:10b6:610:1a1::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9079:EE_|IA1PR12MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: 81da8bb5-1607-448c-b2ac-08dc80236084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHBnTGFJR1prMDRXdVV0TzVWb0l5QmlQTGM4WVU0MytqRTRucjk3b21rVngz?=
 =?utf-8?B?WDVab3AwOGg0U2RzQkV2cjJIVGFTaGJRMHd1RlNFYzdYSlN6ektRODNFMUV0?=
 =?utf-8?B?NXJlQmFVUnp5N2xpc1phMnQ4Q250N25vUHNYdXFqNkVTTFVPdzA3ZTdxTUdY?=
 =?utf-8?B?dnUxOGE1UHltdXpOYW9HeTQ4ajJac0g1amFCRzBsR0pobUdCKzZQeTdqRFBX?=
 =?utf-8?B?c2lVWnVjaHFBclI2RlB5ajJtTk15eGh5dkE1N0NtQWc2Mmk2UDVTaUtRSXJz?=
 =?utf-8?B?VnlZbTlZVXQvbWR5Ti9DZStBY1AzT1Z3amU2djMyMmdQZVV4b0tHM1FUaTdr?=
 =?utf-8?B?eVhBWDJYVS9XNWJqcExXOG9LQnMyTkVjVkcxdDQzMUZhYndrYXZtdFBWWkxZ?=
 =?utf-8?B?T3piOFVVSDVlTjM1NlgzRE1oWUwwc3pxOXAxa0ZweFp4SmFZWk96cEdqMkdS?=
 =?utf-8?B?UUw5U0R5N1ZDMUFvQmdUb04zNUw2aUNKbmk2WE9VbXhHNW9RTlRYQ0ZsNW41?=
 =?utf-8?B?TEFrb3RIOVBOeGxidkFqeVQvcjJaTnBSaW1OOFNvYVNTRTBpYVVFVVgwaTQz?=
 =?utf-8?B?T0NBSTlTRXNCYytQRjkycUhQN0J6OXQyUzA3YzhTSXVaL1B1Zjg2dFVzWkYw?=
 =?utf-8?B?V3JTbE5GaW8rQ0JhTS9CUURHSGJ5d2hsRGhGSWRrOFJuOE5sRDZhZDNyb2Zr?=
 =?utf-8?B?c1VIMmZWTWhmWkxIQk9wVDM3NVQ4N2taYjN3ZmM1cGR4c2tmdVBJT3FWQVVV?=
 =?utf-8?B?TmhmUHdJZnNFSFVpV2hBenh6S1oyeXBsaEQ1RjY4T1AyRE9aQUlwMWZ4MzBo?=
 =?utf-8?B?a0wzRDVMdEt2WFQwSVpySmpZQzFVNjZmb2ZwaGdFMDZDVjBtcVZ2NWs3TzFK?=
 =?utf-8?B?RGx1bUd4MTlQM0RwWUN2K1JTakxuWkxyaVF6VWF0R09kQisrNHMvZDc5NCt1?=
 =?utf-8?B?YjhkSis5QVJHVjRtSjdaYld1aWRzWnNaeGMvTW1NTnFTZGZ1eTBDcWJUU2Rx?=
 =?utf-8?B?VC9ScWVnSXgzZ091N2dFVnlEVkhhSU42L0FxZ21pS3Q1Mm11V1RpTmJ1MUY3?=
 =?utf-8?B?N2o2K2l1YUxtNmM0bzArS3lyNXZhTnB0YVUzTEdLUlkrNHZCUU9tRUNwMG5N?=
 =?utf-8?B?cmJTU2pLK2dneXcybHIySDZMS210ckk5cFJ1cDB3dWxmRzYyaGh1WWdWblJZ?=
 =?utf-8?B?amc3b2w4RzBXTHkrd2NYdzNzemM4TjZxTC9pYlVaU0k2Ti9rS3FHSHF0MFNl?=
 =?utf-8?B?dlJvWEMyc1ZFaWJYR0hMdjFQZXcyazE5cDZEeS9BMWI0QnBHUFJxWVRkQWlH?=
 =?utf-8?B?OTRyTjJ3bUVHT3hPWkNQUGtSY0NWRlhHdHB3cGcxVFl4aG82SXpYVFJDL2g2?=
 =?utf-8?B?WnhwMlpvQWdFTVZZZEc1VUx1OTQ5d2YyNGk0WTFHTS9GRDNlVVpLK0g3YUF5?=
 =?utf-8?B?YVVZeUdkVHdJSmExaFRXSklEZm95QjI3MWp3RTZ4WExxek42dTY3UWowN1pI?=
 =?utf-8?B?SEtycHpwNGtrTWl6bzd5L1F6VXJjQ0tHOGlYZVpiNkhxOVdGR0M2SWxla3gy?=
 =?utf-8?B?cndsR1k1dkFIS1dWNnVMTGtCa29XZ3pPTG0zbnBiaGpKdXNWQWQvYzlKYmNU?=
 =?utf-8?B?cDVCd3lWb0IvRXoxZnZlNlJJR1BxZ3o1eWVtRW1KL0FNQ2M5ZmxpMiszdzNi?=
 =?utf-8?B?WG16R3UxR09Cb1U0UCsrWFBSYnBIdnA2UDZoWnFLQndVZktLYks0WWtBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB9079.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zml1NWZrUHNpQkx2Q0ZiVzhORzlVRnFwdEk4aTJOelhKWHhPT3BZTU90dDlM?=
 =?utf-8?B?V1dRV0NzYTVWVVZzdTJTR1c3MHJ1V253RmlQbWlGdkdRV0NFbnI1U0doeFZy?=
 =?utf-8?B?bjh3QUdlcmkrZkZuK21YK2EyeXhvWlpQVHlzVWc4MTExYnhTV09PQjk4Tllv?=
 =?utf-8?B?S0I5UW1OQ1c0RFdqY0gweXR1OXBwT3d6eEYxR1RPN2w1ckJhSkNVbWdOWEh4?=
 =?utf-8?B?OTR3Z2c0Rk1QMW01SXRuUWFNR1UrWTJOTzNZeFIyY01mYVZsaWd5UVdJZWJx?=
 =?utf-8?B?dmNBdG80cnpRRzNPeHQwT3ZKSU1KOWh1V09wUXJnN2hGQ3VoMGhQaHJ2MXZx?=
 =?utf-8?B?SGk1bFVLYzljR29aVjd5TVdwemZPTm4wK0FGVG1lTHdWWG1XeGRtNEtub2hi?=
 =?utf-8?B?UUhEeXJhZEwwS0kvT0l3aS9IYmxxaFVFdXJGRUFtSTh4U2o4RnVQSnRNaER2?=
 =?utf-8?B?YVhIUGpxdE4vUXkrWEhKTDNvbzJHaWFhVXVZTWFkOFZKNDBHQnNQSnFaenNW?=
 =?utf-8?B?SjFCeVVBQ1AzQXVwcndocTVqVU5oTEUxc3lGWXhIYTNPT0RYK2xXdkNWU25h?=
 =?utf-8?B?WUx3VDNHdWZiMHFFQWp0NExJbEJISGhXZHdOdFVkZENRemhZZGFRQ0p2bW1C?=
 =?utf-8?B?SGQ5WWNRK2FleE1YYXZ0WHNkR2Q2WlY4V2dGbWJOWWlVRlNMSm5adWNQMlVO?=
 =?utf-8?B?WUFXalNwbDdZdnkzQnNKZkRERzVCNWloRWozcHVrNjdFOVpkRU8wbXVkL2pi?=
 =?utf-8?B?aW1XWHErWThMRkJIVEVHMjIyeGtrTkg3RE1mVVdXYkxPQy9Tc1FHRWd6c01M?=
 =?utf-8?B?a01PQVFiL1ZTWHVOUVdLbC80SGZuOUZxNU52aGhaK2ZRaWh6Y3dYK2FONVBh?=
 =?utf-8?B?RVlNY202YkpLckVyenVSYWVENlhGd09Kb0k0bC9LelRxb2hPRE9lK1k3c2x4?=
 =?utf-8?B?b0l5NE10Ujk3VS85UThKNEQ5WHErZHQvWnlzOGRZMGNOQ3hqb28ra1krUyts?=
 =?utf-8?B?RHJLczAwRmlWVmtZbTVJaHJ2a2MvUGNWaFVrWlU1NnNDT2lUTC9Ma1JtQ1dw?=
 =?utf-8?B?Yy9pV0krc2VHUjdCQk5JUFBTVzZ2bjViNGQ4RW9Lcmgxazd5MTYyR0N6Ykcy?=
 =?utf-8?B?djlHbzRMRWRJMkR3MFNuNzh4cW5kSGh2ZExzWUZFbnU3WHZwOCtubDMzRjlj?=
 =?utf-8?B?WUdjZXVPZEFXZ2srdlFoR0xBTWMxRmtxMXhhWUNsZW05T3RvSnNYUXcxc3pE?=
 =?utf-8?B?a0JJYU55a1N1N2w2SnpJc1UycnJ4L3l4Mk9qcWgwL1owdHN3TVAxa3ZrQ0N6?=
 =?utf-8?B?U2Z5aVZsUmFDQVlwUFhtdW11Q1NxWlFxOFpMZWdlL1lvTzRYbkJieGhRZ2dz?=
 =?utf-8?B?L1dqU2tYTHJIR2N1RTg5dHFSeDJwWHF0VTM3TzBnbUpYWVlJRFdFWm9Kc0hC?=
 =?utf-8?B?NGVablYwSmlNc24wazMxK0lJZjhhNHdTcjcyTU93TStjKzNkQkxGZStFNFRQ?=
 =?utf-8?B?UFgwZnZJb3BGWHNQMUkzdC9LYzI2U01NQ2g5M1R6QTg3b0RuTURMblVJQncv?=
 =?utf-8?B?L3VrZ1lLZGk3T1U4UytUUkllSkJ6V2NMSGxxYnRnZ282VWVZdTczN2J2YnU1?=
 =?utf-8?B?MFpQVkZza3FZRHpNeGNzamExRjlrZ25pWkkwcitUc0psUUUzQTdtc1pPeHFL?=
 =?utf-8?B?eUtDTkxDNTU4UEx0K3FCYWFvTG5lT3QzSVJuVVM0QXYvRVd6eDVtS1BrSnJj?=
 =?utf-8?B?ckNnUHlMTnJUaHRyYXc1YjAwcS9tcFM1Y3R3ejZ3N2dmNW1HeXVGVEFmZndF?=
 =?utf-8?B?d2F1MDU1T1ZSSjJKZUZsNk52OGdkYk5HY0x3UkozS2pvazczYU4renJSUHdt?=
 =?utf-8?B?WXZDY3pVcjNmZllXallsOWlUMFpYUSsyVllQNW5KMzU5elI5S1hHbldDZ1VY?=
 =?utf-8?B?MytxT2ExQzU2Q3lIdGhzZERPNGxPZmJ5LzBJVVhjeFVMZDk0QmxseXJDZXlH?=
 =?utf-8?B?OHdWbS9YSThRMTdGYzJ0R28vWVFRZk5KTmRMVWRESnMyZWFuWjkzQmNXa0xX?=
 =?utf-8?B?cjZvMy84SHY0K1VYZkVTWEJvZ3JhR3hiOSswaVRjNFN0S2xSaDZhTTY0bTBv?=
 =?utf-8?Q?5S8P96WMita5ZPzLeebl990sp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81da8bb5-1607-448c-b2ac-08dc80236084
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9079.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 21:07:41.3559 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GzveVJR3vV0kZ/Sovd5rnPAWijo8fG4s5NX+jfPVy3Z1jQWz/6YdGxfsFAt6FBDFNyXDHLLrDxqwEoQY4ohD5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6041
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



On 29/05/2024 20:35, Jay Cornwall wrote:
> A wavefront may deallocate its VGPRs at the end of a program while
> waiting for memory transactions to complete. If it subsequently
> receives a context save exception it will be unable to save,
> since this requires VGPRs. In this case the trap handler should
> terminate the wavefront.
> 
> Fixes intermittent VM faults under context switching load.
> 
> V2: Use S_ENDPGM instead of S_ENDPGM_SAVED for performance counters

Hi Jay,

Thanks for the V2.

FYI,as far as I can see, the .h part of the patch does not seem to apply 
directly on current amd-staging-drm-next, but I guess we just have a 
different bases.

> 
> Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
> Cc: Lancelot Six <lancelot.six@amd.com>
> ---
>   .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 695 +++++++++---------
>   .../amd/amdkfd/cwsr_trap_handler_gfx10.asm    |  17 +
>   2 files changed, 366 insertions(+), 346 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
> index 18e012e04493..ac3702b8e3c4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
> +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
> @@ -97,6 +97,7 @@ var S_STATUS_HALT_MASK				= SQ_WAVE_STATE_PRIV_HALT_MASK
>   var S_SAVE_PC_HI_TRAP_ID_MASK			= 0xF0000000
>   #endif
>   
> +var SQ_WAVE_STATUS_NO_VGPRS_SHIFT		= 24
>   var SQ_WAVE_LDS_ALLOC_LDS_SIZE_SHIFT		= 12
>   var SQ_WAVE_LDS_ALLOC_LDS_SIZE_SIZE		= 9
>   var SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SIZE		= 8
> @@ -451,6 +452,22 @@ L_EXIT_TRAP:
>   	s_rfe_b64	[ttmp0, ttmp1]
>   
>   L_SAVE:
> +	// If VGPRs have been deallocated then terminate the wavefront.
> +	// It has no remaining program to run and cannot save without VGPRs.
> +#if ASIC_FAMILY == CHIP_PLUM_BONITO
> +	s_bitcmp1_b32	s_save_status, SQ_WAVE_STATUS_NO_VGPRS_SHIFT
> +	s_cbranch_scc0	L_HAVE_VGPRS
> +	s_endpgm
> +L_HAVE_VGPRS:
> +#endif
> +#if ASIC_FAMILY >= CHIP_GFX12

This is mostly cosmetic, but you could use

     #elif ASIC_FAMILY >= CHIP_GFX12

instead on #endif + #if.  Those 2 blocks are not independent, they 
achieve the same goal for different configurations.

I do not mind if you prefer to keep this as it is.  Either way, the 
change look good to me:

Reviewed-by: Lancelot Six <lancelot.six@amd.com>

Best,
Lancelot.

> +	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_STATUS)
> +	s_bitcmp1_b32	s_save_tmp, SQ_WAVE_STATUS_NO_VGPRS_SHIFT
> +	s_cbranch_scc0	L_HAVE_VGPRS
> +	s_endpgm
> +L_HAVE_VGPRS:
> +#endif
> +
>   	s_and_b32	s_save_pc_hi, s_save_pc_hi, 0x0000ffff			//pc[47:32]
>   	s_mov_b32	s_save_tmp, 0
>   	s_setreg_b32	hwreg(S_TRAPSTS_HWREG, S_TRAPSTS_SAVE_CONTEXT_SHIFT, 1), s_save_tmp	//clear saveCtx bit
