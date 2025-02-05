Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE52C02192
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 17:07:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5318810E0F6;
	Wed,  5 Feb 2025 17:07:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gs7oOLBj";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2054.outbound.protection.outlook.com [40.107.95.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3951510E375
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 16:50:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K2EMAYOBKxy3+TDpd8T32ARFYyxx8NKFZRxIX9FmQIrG13VOpwumQpt7ouGwG/Irv8Oi3Sc9GsRZ+qk7xwujG+xpuCEwUyCI0thPDLblrNolHh2ZQ2I9HAWq+vGlIEUQTZ752umGIVI50KIV/xwrHEC+PM93avG1yRctPtsziAYwfWLDPZJ5pICquBcrzgEOhR1MPakyQhGa9F6qtCHJtJ81CxyHVEOhe8IyrewmjS78jrg1NxlHiQcuNURlGijWLFTNsYeBRzN27QHtAl4qqrYwnTC8Dn6PGAyjRKx3jJQ5DKDCY09wZvkIh6hDWwtD+czTGnvE9RT4awBSc6ysfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJJUMmauMPKUuL/gGoWzg5laAOZ0FCIYeqa01HfNumU=;
 b=tPOEEPPE0qmOoeLJd5TpccCx9gWa7Kuq/9ADAqD/7q7LLZKDqBLtBKax5YKxStiFIemzjOTfaILk0mhdyx7dUTb7Zv9j2lAouwhsaziLzHm7R4hKDZRUsLk2BpbEt9ywEWRahqIdwrjy5xtuluCkwlOPzH1tunA1u7w1Uux7OFLVmSNm7e5Pk07tdaVKsu1/vjduG8hTLZOfK47laG31J8VXxakClzdNntORpmkWFDxLdWLY9XA0tPpH9rew/4Jg8D62x8B1+8jG/CsT0vDi0k1QET2x5dBfjIkRYThkTNNJc29HcYcN/zu/vYzugUoNLalJozeJN0RFVtD9p29e1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJJUMmauMPKUuL/gGoWzg5laAOZ0FCIYeqa01HfNumU=;
 b=gs7oOLBj6ZhGexKL1kq0cDVPCD/NhgqRuhY0knBQ/nJKpmYZmAmlWut8nqGQq/iVASeaR5eOxs9CP6bRMBKFLH1MecnkrTKwk0eCFRMTlyNHNAk6/B6/aXjLonFIjraYroUblbK6acN83DjBJ+dTkHqrneagRoKunNfdesKn17I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA1PR12MB6702.namprd12.prod.outlook.com (2603:10b6:806:252::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 16:50:01 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%7]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 16:50:01 +0000
Message-ID: <d77bc91e-0401-4f52-bb63-ded0b0930fac@amd.com>
Date: Wed, 5 Feb 2025 11:49:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdkfd: properly free gang_ctx_bo when failed to init
 user queue
To: Zhu Lingshan <lingshan.zhu@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20250205080802.1162861-1-lingshan.zhu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20250205080802.1162861-1-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0300.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::29) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SA1PR12MB6702:EE_
X-MS-Office365-Filtering-Correlation-Id: b99d7457-e342-4151-e63e-08dd460521c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UFZHRS9yeEIzNFpYVWJyUGlDVVpmbUpDbTBDSWNWdDJiQTlmZzlqS0hwQ2Rl?=
 =?utf-8?B?UVJOb0ZEanRqUUI2empqWUhIaTFMN3g2N1o1WU1ySnpEcWpMWE9pcVZTY0FM?=
 =?utf-8?B?aERrMkwrb3dNa2lSNVRQdGxJSXk1MWxDVnpjQWpRV3VqQ1lDY0srbG9YU2RK?=
 =?utf-8?B?Z1ZRYyszS1puVGV5ek1jei9CUkRYNDVzWEZVWE4yZlpic2szNnl4SFc5YjEx?=
 =?utf-8?B?RWVtaWkwcU4rZHYvMHprWWszYkV5MndFd1NPOGhXNzBTUllHQlFCMm1hY3hu?=
 =?utf-8?B?aE1NZFJHNDFib3JrZjRJeHBtR05KWmlMNXJyWXBKTVQzVCtwUTgvUFJ6Y2N0?=
 =?utf-8?B?a1Qweks1NUphcVdPM2lCaDU0ZGt4THduY3V1YzJzb3FSYWtseWtIOGFGZUxI?=
 =?utf-8?B?R2FKUlZ6MXVYN2lRT3VRcklZOWlXbUo2TStmem5ZQnkwUVBGK091L24rNGVY?=
 =?utf-8?B?SmRoejRrTmdJSDZWaHp3M0RrNm9YNWZ6UGw1Sk5ZeGhCdnBnbGNldThkYkdu?=
 =?utf-8?B?NkNlM2xTenI1czdjYURKT2NnOTZOSFdGclpRckFZOE8zamJHUnB3QWVUYTFl?=
 =?utf-8?B?MTM1UXdRVGlGOWd5bWMra1dsTjkxN05FcVJuYnFGbDE0MW9qcU4ybE1vVE1I?=
 =?utf-8?B?WE5LL0pUWitPNU02emFPMDVXSDhVbTg5dzZZM2pxQTY0MFhrdGZLMWxKNzdO?=
 =?utf-8?B?UnNRdkFDTWhCUis5TmVmaWorajhadkhHcEZyeFUwTWlLWXlpZG12cjlBOHZr?=
 =?utf-8?B?bUk4TEpHblIwRTluQTZnMjZsVDA1VzZ0NFMwQm43YVFyMmFieTJSUXQrOGlk?=
 =?utf-8?B?QWhQaDNjM0VyZVNyVmFwYlV2aDlHNnh1RmZUamtzNVBicGhVcGxVYmtaYXpD?=
 =?utf-8?B?Z1ltWEl0bzMycVBjNWRjaXNEUlJSVVFJdmtxdmVPYXlmUzhOZkh5YTJpU09D?=
 =?utf-8?B?dldwaHQyVUF5ZlVpbXBVY25RZTdnNzl3Q3IvTllpOTVmdFdXSzJJeEZMZ0Ew?=
 =?utf-8?B?Mk1qSXJUVUs0TE5XU3A3TEpXLzRMamJQMVJlY01BMnA0aEg0SUZFb0puMitp?=
 =?utf-8?B?UEp2Q1pFTDhKa0RkMzlCaG5nYi8wS0Jzb3BBMERDaXFaWTJIODNaZnlaZWlM?=
 =?utf-8?B?WVVobk9iSkw2TnAxc3Q5UzlCZWQvODJKTzdqL01JMC9TVDNSa1VpTjVub0dv?=
 =?utf-8?B?bGpFM2R5dVRHQzVKWUlRU3ZKZ3Z3UTN2cC82dUp0TGJ0djhQcHZwRUt4anVm?=
 =?utf-8?B?MmxHU3FOWmVxbmZodzVHY3pBY0Fibkk5QkNUdVQyVFQ4UjB6MTkrNktsQ1Rh?=
 =?utf-8?B?OUp3VXJpeTlRTW9CWDA1R3hyTittOGNWSjJvME8yU0t4YWNrUFFObVBMZlY4?=
 =?utf-8?B?V3lneEFLbk5xZVpVUHFLVWozUEw0eXZNdGxDa0Fxb29zeHhZbUxIZDNvNE1l?=
 =?utf-8?B?angvQnM3cW94cEJHOEhjbzZ6Z0hZTU9BRW92alhDVVZWYU51STlUVVNWZ1ZX?=
 =?utf-8?B?RHZaYnZIazgxVjRlSFRvUG9DcGI1YkY0MlQ1bTc1MjY1dnZQbE81dERXT0FI?=
 =?utf-8?B?Z2RYQmFqNytwQVhza0hiNUYrYXhMU0FBL2VVRHBGWG9IaUpzWUxPUXQ5U1Mx?=
 =?utf-8?B?NzFqejNhbGFibm1paE5LMkJWMmczQXpVaXNGcFphMTdEeG4zZzkzZGdydjJ2?=
 =?utf-8?B?dmNiN293cGhpcFpDdmRpUW9VR1BWRE9DWjRYeUJIR0swWnFGb0ErTzJueGk2?=
 =?utf-8?B?RFdjOGNXYU1TOFlUcm1sZFRJd3BQaDg3MFVvZFBZZWo3cm9Kd3NuSjFNTTZx?=
 =?utf-8?B?ZGgvQVVoL21VaEhBa1hyYkVoM09ia2ZCeDNoSkJPT1loNTlDNEptM0xhWnE3?=
 =?utf-8?Q?/cRHXC7xn3gzw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VC9SRzMxeW1NNUV4SldFVktCWHRkVVJiVHJlQzM5VklQSW9LRkpsWTJPT0o5?=
 =?utf-8?B?QTY5OURZRDlVZ3gvWlkrY283WnZ6UWhjdUhGd1VPcGxYRkpaQndOaGhXSTRF?=
 =?utf-8?B?OXdoaEZNMWRYUlBZckRULytKbHlaSkVjZWc0SVNhRjYzT2gzdS9qSTFGbkc2?=
 =?utf-8?B?T1FFVkVLNEIwOUN6N2tSMU44WlgvY1NITzNsV1JZbGVOMXliSVBFdi9oRS9I?=
 =?utf-8?B?b3F2OUVnd202Sko2UVZLa1duTzJaUjEzRzl5V0VXMHVvOGpBRDNYVUY3N2RQ?=
 =?utf-8?B?STEwTlhkL2xjbmY0ejBTeC9RcHdTem01akRUUXJyTGR6MjZDdFYyVVhjRmJq?=
 =?utf-8?B?TUhNWGlmVHVtZGpLQjdOZm9IYUJMMXhtcldiQkFoZjRNM2VjNG51SzJTVm0w?=
 =?utf-8?B?Y3U2cDltbC9BTE5jMFJkR3FVdE0yUmFTTTBoWXB0MksrR0FsTyttRG1tWmhx?=
 =?utf-8?B?NC9WSUNzZmhWUE1LL3hVY0tSUElFTEJwNTltaU5BYXRzQWVoSTl4TDd2cFNa?=
 =?utf-8?B?N1hZNlJqQm9VMDF2M0o0ZU1jWmpMUEpKVGlXdHJ0Si82akxCckhjZ1pMNG9O?=
 =?utf-8?B?RndFTkN0L1lqNHRyTFZISWt6ZndBZXhUQUhPMzdwUnV0NHFqblBndDJJLzla?=
 =?utf-8?B?eVVCbmFxV2Z1bER5NlNkZzJoKzNtN0JXUVdyTmgxTjN6dFFWTk5XdWJLanRy?=
 =?utf-8?B?K1lmeXZIMjZMOGtBME1CMk43Z1VUTHVJMUl0UnVrZXBqa1Y1THNtUmpyMGJw?=
 =?utf-8?B?dzVtZ2t2UkMwZmk5OWt5VEY2cUhlNGR0cmhsNnUvMnlzRTJuSjkyS25ValFu?=
 =?utf-8?B?ejUwc1NIUFc0Q25xbi9TRWlzc0pXT25MUlViRFRlM2lVbEJJeHpSSDlia3Rp?=
 =?utf-8?B?bWFCUGpMOTA2aEwyWTRYbUZpNGZtUTI5M3F3d0JyTHZtcVRxSEx2aGUvRlA2?=
 =?utf-8?B?YVNMMmYydmVPSlIvVlk0SE02NjB0MkRWa2hvUjBUYmM1STRnMlZ5amlxWFpB?=
 =?utf-8?B?TnppeG80MzV2S2ZiZzhjNWZYcythdU1UbjFHVVQrSDlTSG0vN3FweFdPSitm?=
 =?utf-8?B?bi9VUkVnbzlEMm1YVDd4TVJUZ3hUbHA0SHU2eDJoWm5xYS9yazg3WDlEWXlV?=
 =?utf-8?B?ZUxmUU5jZ0RGckQzWXBYUnIySDB3TGN5bXZES3lhemVsd0hmbitYYWRPc2s3?=
 =?utf-8?B?TVZRWTNtdlUyMkh0R1FDN2pUSzBMejlVWkJPZFRIa1B4eGlDWlFnR05Yc3N3?=
 =?utf-8?B?eTUvSHFya28zcjBwOTVqdjZYZjdMVURDbitvNUpvcXI1L0VXNW02bjdVQXhL?=
 =?utf-8?B?SFllRG1SRnlrcWJhR04vNTlERW15TjJBWVFpbUhWNG41RnFpeHdZeEI2aTM0?=
 =?utf-8?B?Um1qMlBnTTdyWnZjRVkzMUg4WGUvdVlSKy9QOXJNQ0ZZbCtZQlFnSjl5cTlO?=
 =?utf-8?B?QUhIZFFPL2lRVklycVgyZVFKWmJER0YyNGRxcW5ES25ZZ2U2V083YlhhWHRG?=
 =?utf-8?B?Szhza3dMcG4yUkI4UTlVOC96am4wVjBQMmp3ejI5Tm1XT2daWEUxdUpHY3BK?=
 =?utf-8?B?YnpHN1ZEcTZSMWltWDk2alR6MWlOTWs5ZlB0dzFhbjBCZFhTQjMwV2JYYWlU?=
 =?utf-8?B?NEVuKzdsdDVwOGxYc2ZvSWNkTUk4bDdPTVl5ZVMwSkIxemk2eEtPeUlRWCtk?=
 =?utf-8?B?Vzh4anVyQzlXVXhzTHYwVzZOZ0pPdW9uZXRpbXQrRlpCblVDZURhK3hxeDBw?=
 =?utf-8?B?bUVUSzdkN0hZNVZsNkNSbzFoRGh0Z1lySzNScFRESklDdzN4VmdpUTdxWHVn?=
 =?utf-8?B?K3hPUGFlOTVNcGhpRjcySGhlYVo5YmpLcm9heWNkbTI5RzZkdFpNSVlOZHVl?=
 =?utf-8?B?M3p3a0MxdmpnUCtza1lJM3Q3dTVTWGUyTVJTM3p5N0NzaUdVK2JtdEtrNkoz?=
 =?utf-8?B?aXIyYUNoTDNoZS9lbmdLUjZQT3MvdWd5TGdMRS9GNUpscElWUUt4MGdodEZT?=
 =?utf-8?B?d25Qb3FaUDV5OGdkVnA4bkJpS3dCZyttQmtYc3UzaHFKTkw1dFZsZUF0SmtH?=
 =?utf-8?B?YXpVWmJIaTVxYk01UXluL1IzdFp2WVozaWpDRFpJTWkzY3hWdVhZQndmd1FN?=
 =?utf-8?Q?u30tbJp8TXu8ITtRHbnMQZshk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b99d7457-e342-4151-e63e-08dd460521c3
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 16:50:01.3384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BG3uegaFS3xD82kGe7Bfwux5P4k3oXto6Snv4KRIk035N3uR1WvcfKMWgmgDdU1sjS9qS7a8cyM8jO0PEZvZOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6702
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



On 2025-02-05 3:08, Zhu Lingshan wrote:
> The destructor of a gtt bo is declared as
> void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void **mem_obj);
> Which takes void** as the second parameter.
> 
> GCC allows passing void* to the function because void* can be implicitly
> casted to any other types, so it can pass compiling.
> 
> However, passing this void* parameter into the function's
> execution process(which expects void** and dereferencing void**)
> will result in errors.
> 
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
> Fixes: fb91065851cd ("drm/amdkfd: Refactor queue wptr_bo GART mapping")

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 750f967fecf5..0ce8d49ca16e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -295,7 +295,7 @@ static int init_user_queue(struct process_queue_manager *pqm,
>  	return 0;
>  
>  free_gang_ctx_bo:
> -	amdgpu_amdkfd_free_gtt_mem(dev->adev, (*q)->gang_ctx_bo);
> +	amdgpu_amdkfd_free_gtt_mem(dev->adev, &(*q)->gang_ctx_bo);
>  cleanup:
>  	uninit_queue(*q);
>  	*q = NULL;

