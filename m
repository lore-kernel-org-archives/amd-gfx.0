Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B349C369DC
	for <amd-gfx@archiver.kernel.org>; Thu,  1 May 2025 21:19:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF89A10E101;
	Thu,  1 May 2025 21:19:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kybDEaZO";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E995410E101
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 May 2025 21:18:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRlJLyOTXS+YNVAeIN4+cRMZqwrDUz4KLiujry9nISQm6y/ESyS88yLwNKcuZlaDTdUJ2SN829bBy6WvnJJQlzH1wuknlaItfn5ulH9nirlOiiTPTf1WWRS+YIpYDCJLpnj9u0SaW4ZwPBDiVsHSQ3wX8cIGWXrdXzlccU0iyhOzwtypp9OEGcbJsl5pnKS/K/5dmCI3KuYpVKD03+5PpZCUmxrB6KQidHnwOnZwtEqXnwBjMQRAexqdNhOU/z0zJ8EVXQ7CktPHcIuZO9RG6o3Yyqvu7shO7Ll150jwheYotyGtz5YjZzzkElMD9JTlMo+Njl51mj4xJeUV/s0XBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSMUsMgzQET2A5srp/qssfppMhTIMwx3Mt51O6+uO0k=;
 b=uPYwpT5zC4KDexcxjP0QESGUXGv34XvcD9ctbYmYqY41OSPhhulTGtGj92HGnxlf0tcmHJ7BQw7I7SvLvIB0YrUb5yIa/eAh9itHTxyBR9ni+mMBr4DAJ/VsIlzO2Zz/e3RKUNXcIqUtn4Kd4z24vj7mUTnfuFmarkSu3AUO4qHqFcxntZpT1NkPpsCjKPC3tkg6M806wAM36xvlOVi9eEt1QCKivQl4S92mfoAM2NR3+L7u7Q8/I492fGTB39EwJyHgCm6LIvy10GEgb9hS1oTka91wyQuDeJb1IGnCShIfjBSvYogbX6fE5h8xa8juBSeP8KJeklPezG0bqPIq1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSMUsMgzQET2A5srp/qssfppMhTIMwx3Mt51O6+uO0k=;
 b=kybDEaZOkGfyLyogogGyyHUaVAgvZh5b3v6dgaLNvnkp66dGM3Rw5cQiMTdXX8O4Mv8CgDKfNGzds+aU9Ru4ccLUXG+zkcXbYFH0NGWE1p9ykjAVxLbxNGRy4tCDuy8C+8oCz95gbbW0ij6BPPPfMG+K3hHZTdZEom7w6M6+2qE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ1PR12MB6124.namprd12.prod.outlook.com (2603:10b6:a03:459::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.27; Thu, 1 May
 2025 21:18:50 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8678.028; Thu, 1 May 2025
 21:18:50 +0000
Message-ID: <591ce362-8150-4c81-a9b0-2752e0f27d15@amd.com>
Date: Thu, 1 May 2025 16:18:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: fix pm notifier handling
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250501200931.358989-1-alexander.deucher@amd.com>
 <20250501200931.358989-2-alexander.deucher@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250501200931.358989-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::7) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ1PR12MB6124:EE_
X-MS-Office365-Filtering-Correlation-Id: bd12cb1f-ba53-4c67-0a2a-08dd88f5c4bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VDJQVEhMZ1d0UmVKcmx5cEppK0I5bkRRR0lhVkIrNlBBVmRpWitHYWlkdGJP?=
 =?utf-8?B?UzNmeU5GZEpTNWtNWi84cExqUjJmR0Q3VEUxQWxBZmlmOUprT0lzeERDdXA3?=
 =?utf-8?B?SzJYREFUUWd4VGwwejgySUxBY0pMTXZoaGtxSlJzaVlWTXhHMXo5VzhnVUlq?=
 =?utf-8?B?NmJweUZzTG1tV0VjZ2dmenE0eFQ1ZmZZNFlpbHAxWFgzbTdkbFlkd1N5RWVP?=
 =?utf-8?B?bkNua1ZRQjAwV1FxMzF4dHZRVzBoekZibzl4N1ZHOUNVeHp1dVFPbUZWTTBm?=
 =?utf-8?B?ZHdUT0UzRWFFS0twSXdUK0RVOVdKT0VDNzZja3BnTW0yeDJOcHBCQzlxTy9n?=
 =?utf-8?B?N0Z0dTAwYjd5TVVZTEVreW1ybWVzbExzU1FCZnFwbnVweGxHbC9IVG1SSEhY?=
 =?utf-8?B?RU8rRUxaQXNBRWVqdzdOZDNzOEJOOFRZYnZ5d3huS3lwcWFFRURRZ0g0ei9y?=
 =?utf-8?B?OXRHZU1FUVNTK0ZyQ3gwek56d0RYUDlRKzB6RFZOcW9HaWo1cXl4eFdhSmtL?=
 =?utf-8?B?bUZ6eDV0RXNLd0cxUjFtNmVNcU96WVNZQk90NlZ0Q0ptZjhCL0JYbjc4VkNq?=
 =?utf-8?B?b25kV25Jc05sUmVUbGRqYms3SWhCaTZuTVVGYjlMOEFMbEpUSUZ1VE1HWWZr?=
 =?utf-8?B?QktyUUZtWEJMd2FQM3ZUUDhNOTVNb3FCUTJiUW1hUUtnZW1OOGNNdWVwMDg5?=
 =?utf-8?B?QXZhYmRndjBlUXNkK2dleG5WZEdnTFNPM2xCQWdpclY0eHNEZDNZWHN1YThj?=
 =?utf-8?B?TXFBd0FsY1B2UzRnUnQrQ3dWS2FlQ0F4R0xJSVM2Wmx3cnJYdCtVR2M4eUlv?=
 =?utf-8?B?aFlqdDRxVlVSRkxLd0JMSkswUFdHWWhLSEExMVZ0UjNQNVZBZFBvOWpSVkV1?=
 =?utf-8?B?YUVqYXZ5emMrdFVURlpYK1h6aVdPOEJNWlN4Y25GT3BSdldGNW15andkNlFB?=
 =?utf-8?B?VmpCZDVqTU1KcGZlQnRwYmFyaFkyVm4xWnU2M0xmUnlLR2tQR0NtVGlkUEJy?=
 =?utf-8?B?WHRYT1l2QjRYeDBxb0dPN3J3Yy9uZVhqUG5PSlRBa1JLa1JHdVNhQko3ZG1w?=
 =?utf-8?B?ZXZ4Z21teW5TLzdXby9uMHBucnZ6N2hsK3ZYZ3Z2a3A1c3RwK0M1ZE5TYm9V?=
 =?utf-8?B?WS84NU45bjBXejlxRnYzdDhqdmNuVEpFcUFkeHhrQXlHbzhVcmtBMUI0UmxR?=
 =?utf-8?B?blY5YnJpQ1l0amRPcTZtNUVyQll3TklZVzFWS20vbC9JVzRlRzBycDcvaVZW?=
 =?utf-8?B?cnVSaTZud1VxQWlVT2pKSWEyVndyVk9LaDZRVXN1MnM2VWFwWmxLcURURVBX?=
 =?utf-8?B?aDRIbUFlRVcxNHJLNzBZZE1VODhBNXdwdW5LSmRBMkRMLzZJODh4a0hCZUlW?=
 =?utf-8?B?cG8zdnhUUHR6S1lmYzloYml1SHRTd2YxWk90RWprSWxDZ1NMcnpJMVZFSytz?=
 =?utf-8?B?Y0pjL090bnVZVXZySkE1NXVMLzlSVUw2U1RuSlRQRzhNV2xsVlJWYlFaSDhq?=
 =?utf-8?B?ZzRUQnZKQXMrazZFQk92SGNFTlRuYVFSSW5nZkc4dysxNWw0TWdzK2tKM003?=
 =?utf-8?B?SE0vV3VhRFRMYThCRTI5V0o5eVhtR0ZTR2syNVFBMlR4VEI3YmlXRUdTV2Q4?=
 =?utf-8?B?c3hvR21uc05uWE85V3pHTmg1Y1c3UUNKQk8vY0hpYjJmcnBkR0xCdCtHS293?=
 =?utf-8?B?N1hHYm95ZnE0WTBLait6bkhHcEhkZER6dTZpVXBwbm5MM3BOSlRCUVpwNjl0?=
 =?utf-8?B?MG5md2crZXRDQXVvSmRleE00dzlaR09KSnVEelhzWXM0MXN5S203Y2ZaMTFG?=
 =?utf-8?Q?Tc6xtC3YbJpeEXBQ3CrgTeYxwcLn9sr2KZW3w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWd5Q1BKYnFjTTBkKzcvdDVQNmhaV3p4MlhEZzZKMjdxYU0vb2RJTkFEcmwx?=
 =?utf-8?B?SXA5Q1N1ZVJzVWxrQlNORzRNMEhXcVJWc3M5N1IzYUl1cS9rNjZjVkFZYnZF?=
 =?utf-8?B?ajk2ZkptdHYwdWRWRURPazVCdDArcnRNeVJwaFQvYWdtUVpZb09TeFAvcDhO?=
 =?utf-8?B?cDlQUUEycGUvUlllM2lZWlNWTHVSZmwrK3ViV1g5aStUSjFHV3ZkdVY5cHcv?=
 =?utf-8?B?SU5BTStOTkZ2ZnFGT2hjOVdhSVhpVDlBUmdZL3FKQWc3aGpqZ0NBQzVGWjdJ?=
 =?utf-8?B?MmhXYWxFZXlEbnRRdlBGQkxzd0VxVjdHYW1BL092cVFNRUM4UW1QbGhGUm5z?=
 =?utf-8?B?eHpoWHU3ZTdtZUJpT0F5bXgybUh3VnBQakl3Y0l4RDBaVGdWSDRBdFhUZkZh?=
 =?utf-8?B?UEo5WjZhWGZLR241VWZCYWdMQlBLWnZkZlVhcHZsdU8zc0xiMXdueDgvbUpB?=
 =?utf-8?B?S3d5N0xUMHp5eVBqTU40OXJEeVdST1ZKaUNnQXp3RTVZSkhkU09LbUd2VGFy?=
 =?utf-8?B?akxJT0t5V1dtMG9laU9jYXJIb2xuS2FIZmM3QXpMTFVCM2V0MlRhaW5yOTB6?=
 =?utf-8?B?YWJNSmcxaGdOWExodm55djlDV09IWlhJTzB6Q29YSGhRaUMzcWJubWc1Z3A2?=
 =?utf-8?B?d0lBRS9lU3pSQkNNMldudWVyMC8wWGVtcXZReE5XMGFTZm5xS05qQlRDeExE?=
 =?utf-8?B?MnJzamUvL0V6TnhFTUVwL0dpbENPWG1SZm5LVGExejQzT2U0VDBoZUJvYWRu?=
 =?utf-8?B?ejJoQnVBMFZoS1NpZFJxQ1ZNNTZVL3loRGlMTTVWQ2ZQR3B6dzRmVWNTek14?=
 =?utf-8?B?QVk1SlJueVpydDRqbHhqUWVZd2xwWE1sRHdFUWJvdzE3Nm03NllGODkrRE1V?=
 =?utf-8?B?Zld2SDBkeXR2TkI3ekZuODU5RFFBUjQyNlpaeW02NVJQclB4NEJjYjBqcnJX?=
 =?utf-8?B?bldCbUVENWZvZ2VKemJ5T1BKRVlEc3JHZFh0U0IrV2k0d3FmZkExQmdVQVJN?=
 =?utf-8?B?Nk50V3cxSVh0aFlYaUI0SWE4S09TTGEyNmtHMVVtV1RmWjNsTEkvT2Z5emNu?=
 =?utf-8?B?REM1RDMrdmxhOVRZVDZHeVNLdnAzSWc5V1M5S1F3WVZtdHl0Y2plbnlwOUNB?=
 =?utf-8?B?bUNsQ0MrM0l2M3NmWGdpYXloeER2MUt3TEh2bklsNGcvNTN0OURjRzdHellF?=
 =?utf-8?B?T2QwUHg3RkJUb0lrRUdXcEFTVHlxZ1dTcDArME4vejIvOXJHa2RPRlJvR0kw?=
 =?utf-8?B?SC9yVDQvWWdOZlF5QlNiMXpsSU0vU1ZTMEU4SFRHeXNZcEtoNHpXSlhJNWVw?=
 =?utf-8?B?eGE1ZmRreE1hQzVoOWRTTUE0T01Hdk9KVVZ5SUl3VjFkNzFyK0VEMmwyaUtM?=
 =?utf-8?B?amNSbUVMd0U4QVE4SitFU05iWHM3TnhuemRGU25reGtJSjZMVmplSitJWCtr?=
 =?utf-8?B?a3VIOWtFa3ArV05NM3pHUlZ2eUlWQlFISy9xKzlNdWlKYVM0ZmkwV0J2Zm1x?=
 =?utf-8?B?eFN0VUFrOHppcmYvSnRUOE1ybGNIRE9lazkvVUQ4ZEJUL0pra05XUXVZeERL?=
 =?utf-8?B?KzZUWWNKcWVIQ2tkcng5Vy9qRVMxendORGpROTlNRC9xNW55M3dNYmdQMWVn?=
 =?utf-8?B?bWhHYi9WRXN4Z1lvMldrNTAybVpydlgvc1VuUkNiOTUrMGlPb2JLbnNjcE4z?=
 =?utf-8?B?Ump1WFVid1NPN256M2tKNWt0cHVBaFhhOGFRTy93VFAxZzhVSVBBRjZXdEhI?=
 =?utf-8?B?Z0JhczZrajBiQTNDYUlBOVU4Y2tBcVBZRW8wei9NZ0FGQWRJLyttejdNNWFL?=
 =?utf-8?B?MzNialJwOUZzSDdNRFFoYzV2d1hpK0VoMUJ1SUpKYzhpYmRoL2dDVG5tT1o3?=
 =?utf-8?B?RmNqZ29JUG1sL0xwR2t4d3JGQmVieDcvUERxaDNIYXFEUjltTkJxV2pxbnlU?=
 =?utf-8?B?ZlM3eUxxUDgrUVJiODFPVHlMeU1LN0Z1WHdFNjlUQlV1U1FEZGlLUHkrOW1U?=
 =?utf-8?B?MTdTY29JcktDRHN3TFdJczFMSldHak5xWlg5T2swN0JpRlNFdVc2RHVHZkZL?=
 =?utf-8?B?bzcyR2dWbE9qMmFTOElEaXAxWjM5czRPV1hPWGpBbXJtaWhGcEZ2TTN1ZFc3?=
 =?utf-8?Q?ZRl1w4gap/nNUNE+nQTBhneIa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd12cb1f-ba53-4c67-0a2a-08dd88f5c4bd
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 21:18:50.6739 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pw68iBAYLTdRPwbWVigYGZO1qXyPhrX+ksCY42wj0dNrL8T/2lnfLO5zjnbnJc81wEqLWDhPDU/OluGSMcB/og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6124
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

On 5/1/2025 3:09 PM, Alex Deucher wrote:
> Set the s3/s0ix and s4 flags in the pm notifier so that we can skip
> the resource evictions properly in pm prepare based on whether
> we are suspending or hibernating.  Drop the eviction as processes
> are not frozen at this time, we we can end up getting stuck trying
> to evict VRAM while applications continue to submit work which
> causes the buffers to get pulled back into VRAM.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4178
> Fixes: 2965e6355dcd ("drm/amd: Add Suspend/Hibernate notification callback support")
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Rather than removing the callbacks (and thus introducing the "other" 
bugs with memory pressure), I've sent an alternative series.  LMK what 
you think of this instead.

https://lore.kernel.org/amd-gfx/20250501211734.2434369-1-superm1@kernel.org/T/#m6cdc075af911868667ea6fc849bcd196477d6c20

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 25 +++++++++++-----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 22 ++-----------------
>   2 files changed, 15 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 71d95f16067a4..d232e4a26d7bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4974,28 +4974,29 @@ static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
>    * @data: data
>    *
>    * This function is called when the system is about to suspend or hibernate.
> - * It is used to evict resources from the device before the system goes to
> - * sleep while there is still access to swap.
> + * It is used to set the appropriate flags so that eviction can be optimized
> + * in the pm prepare callback.
>    */
>   static int amdgpu_device_pm_notifier(struct notifier_block *nb, unsigned long mode,
>   				     void *data)
>   {
>   	struct amdgpu_device *adev = container_of(nb, struct amdgpu_device, pm_nb);
> -	int r;
>   
>   	switch (mode) {
>   	case PM_HIBERNATION_PREPARE:
>   		adev->in_s4 = true;
> -		fallthrough;
> +		break;
> +	case PM_POST_HIBERNATION:
> +		adev->in_s4 = false;
> +		break;
>   	case PM_SUSPEND_PREPARE:
> -		r = amdgpu_device_evict_resources(adev);
> -		/*
> -		 * This is considered non-fatal at this time because
> -		 * amdgpu_device_prepare() will also fatally evict resources.
> -		 * See https://gitlab.freedesktop.org/drm/amd/-/issues/3781
> -		 */
> -		if (r)
> -			drm_warn(adev_to_drm(adev), "Failed to evict resources, freeze active processes if problems occur: %d\n", r);
> +		if (amdgpu_acpi_is_s0ix_active(adev))
> +			adev->in_s0ix = true;
> +		else if (amdgpu_acpi_is_s3_active(adev))
> +			adev->in_s3 = true;
> +		break;
> +	case PM_POST_SUSPEND:
> +		adev->in_s0ix = adev->in_s3 = false;
>   		break;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index cec041a556013..6599fb6313220 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2572,10 +2572,6 @@ static int amdgpu_pmops_suspend(struct device *dev)
>   	struct drm_device *drm_dev = dev_get_drvdata(dev);
>   	struct amdgpu_device *adev = drm_to_adev(drm_dev);
>   
> -	if (amdgpu_acpi_is_s0ix_active(adev))
> -		adev->in_s0ix = true;
> -	else if (amdgpu_acpi_is_s3_active(adev))
> -		adev->in_s3 = true;
>   	if (!adev->in_s0ix && !adev->in_s3) {
>   		/* don't allow going deep first time followed by s2idle the next time */
>   		if (adev->last_suspend_state != PM_SUSPEND_ON &&
> @@ -2608,7 +2604,6 @@ static int amdgpu_pmops_resume(struct device *dev)
>   {
>   	struct drm_device *drm_dev = dev_get_drvdata(dev);
>   	struct amdgpu_device *adev = drm_to_adev(drm_dev);
> -	int r;
>   
>   	if (!adev->in_s0ix && !adev->in_s3)
>   		return 0;
> @@ -2617,12 +2612,7 @@ static int amdgpu_pmops_resume(struct device *dev)
>   	if (!pci_device_is_present(adev->pdev))
>   		adev->no_hw_access = true;
>   
> -	r = amdgpu_device_resume(drm_dev, true);
> -	if (amdgpu_acpi_is_s0ix_active(adev))
> -		adev->in_s0ix = false;
> -	else
> -		adev->in_s3 = false;
> -	return r;
> +	return amdgpu_device_resume(drm_dev, true);
>   }
>   
>   static int amdgpu_pmops_freeze(struct device *dev)
> @@ -2643,13 +2633,8 @@ static int amdgpu_pmops_freeze(struct device *dev)
>   static int amdgpu_pmops_thaw(struct device *dev)
>   {
>   	struct drm_device *drm_dev = dev_get_drvdata(dev);
> -	struct amdgpu_device *adev = drm_to_adev(drm_dev);
> -	int r;
>   
> -	r = amdgpu_device_resume(drm_dev, true);
> -	adev->in_s4 = false;
> -
> -	return r;
> +	return amdgpu_device_resume(drm_dev, true);
>   }
>   
>   static int amdgpu_pmops_poweroff(struct device *dev)
> @@ -2662,9 +2647,6 @@ static int amdgpu_pmops_poweroff(struct device *dev)
>   static int amdgpu_pmops_restore(struct device *dev)
>   {
>   	struct drm_device *drm_dev = dev_get_drvdata(dev);
> -	struct amdgpu_device *adev = drm_to_adev(drm_dev);
> -
> -	adev->in_s4 = false;
>   
>   	return amdgpu_device_resume(drm_dev, true);
>   }

