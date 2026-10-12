Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFACCA9ED1
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2026 11:47:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F27010F048;
	Mon, 12 Oct 2026 11:47:33 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010068.outbound.protection.outlook.com [52.101.46.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FC5210E375
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Oct 2026 11:47:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wj5gb9q8X4P2Lfb3tK0RIQ0QXm4cPmAaj1pg+cgPCBBEBixjN4+hNCQA3ljvzT1akCJNVWtLfmk1snJzDBEGXKpBbh1401GrtuYwPCaAd8Sxm7howmjC/cc4amiwCCjJKPYqvOc1QW4pSmk8M+oL/wASNFG7thb/eH5M7+pRX5Ul8nAKSN0cMRjrCMICVWFcxmD1mFE9XtRaKgL85u3dVUIViOKMQYMPcwssq1QU1fy8pyQTgU12tm4M6XVpCL5WpXTWtVsWBGzTf5OrtvLl5o4wQRJoa+MJ1fY5L2D8qooqH6AJeQUtU/PbUgCdHSAdULO2Vs+anD3CjKeQb+YfNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsUEaOvqhzNcJkcoJJVMCZns+cCX5hJAQJtnpBd6pkA=;
 b=WiNj+9WfOyA+yzwwTPdijCZYU15Xmk7At0EV/VwiACjeoFfVkefJg6mlhLxjm95f7GLLTEZLDX+U9OGzSHKgL3KgUB/Ug5pwJ1QkEk7HZCxg2lZVQQIYjOWQy9OByxr2kLppRSBXEwVr5oSF4H9Zd1Nk0nuzL+7L47g3jRUY80w6t9li1GqN/NHIAiqsbCdiIKg7WLeJwmDWiIQIPUS6Xkaqv8Z7X2649xOjdd00wMoPFyRLSWH2A7WoATmdr7pFTnTPHYua5xF/jD7tOnNQF6PZd8s++eeRGYFwh3XwD7H27lQvGFbDqBCIK+708wB0T2H/oNOQ4Xrs7WP9ZYwc/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsUEaOvqhzNcJkcoJJVMCZns+cCX5hJAQJtnpBd6pkA=;
 b=3hsUNOSTgXzcRfQP3LNVXeKWgxNJbt4pceLnsEkgKfNJSMc/YIEwtEmIBA598PPM+qePCC590SeFwjiP7NVu8cXK55aWCwlffvCeUIwJY6W6grsUbbmNzvYlWIhfX1dYrZ8GGM6g9tYxWUKxDf8/4zCFyFzu4OGifnHjf+W2jIY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7212.namprd12.prod.outlook.com (2603:10b6:510:207::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.18; Mon, 12 Oct
 2026 11:47:23 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 11:47:23 +0000
Message-ID: <0d769725-04da-4360-9615-c858ee621776@amd.com>
Date: Mon, 12 Oct 2026 13:47:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] drm/amdgpu: Add CWSR infrastructure for user queues
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Lijo Lazar <lijo.lazar@amd.com>
References: <20261008070542.1111149-1-srinivasan.shanmugam@amd.com>
 <20261008070542.1111149-2-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261008070542.1111149-2-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0211.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: bf3dc706-78ba-40f0-1512-08df28569466
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|261009223027099003|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: Lxw6PzYYUuEpNqRF6LwkDCEG80rZBLQw53My4fg4HprdB6W31J+YYCBeuI6bHdQ+DziExQqTsvwfhO+9nnePH45f2//ZjkblxncyfzEz2V2OH5eniX+fU0DCY2An27jn+AOPtNwCuW5f+1gbBsgEWlX8AtC90EVg8QKqkqayeQQBlhVPHBv7gStohhrorw5robFWVvT7QeFEIDGmCMxCyKHsLd94BUdNMRAYSQ3Zh2FpGMR6KtunvZTLVzBR3ISbv4bRvD3kFSk2LvrBsIGer1o0UNKhjUneearRln1XVqn00O0C+iQqpVLLpq/12LA6wIlQLJ0qlrfZKCgDb2ecrietCroH35czlUcuRzU/+x9PtFyEMtmPR6KX41l+gmDKOvBSZ86Nfxed1nZkxb0F3bS1OfxTwD8KUz4WUvZGEi4cu6TJB0beJBKJG+lLdyRkdohTl2vfKH8U6SD1ngVbRcC9h8K83xKivB1VtoA33iq0lX2BTnizYB0BKYnnrrF4ZZxnQq4I58L3rZAbQcf3kQUP2Q0ZG0z8bXlYqafJDoYPwIGDpiVEJsr5hp6mhVTDY6NTVmaWWF3DCEVLaINHXP+BvWlkEqQFCFCn0mlXl1WFdfhuwjN+YHqu8qIn4c5KjZHfC8ZZEqXpvnBSFWoCkrx+CdE6j1UpeLAsAdNbnJ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261009223027099003)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elJFcDF6M2RYOXlrNjU3L2l5cUtkWUd5aHRsdzdaOEd4MGV1VVI3OHU5djBy?=
 =?utf-8?B?NjBpWmVreVVuVHZkRHg2bW9hYndLMVVhN2pGbDNVbCtmeXNPNS9la3d0NEJJ?=
 =?utf-8?B?VllhRzI3TzJreDY4WmxqZ2ttQnpVUXZrZnl5ZTFYaEYxSXI3RUJqTWNWSlpk?=
 =?utf-8?B?aTFRK0NHTUxLbkMxZzY5ekRWU0NzV0xoemFkOTdWNXFEMmMxZDczQm5idzZa?=
 =?utf-8?B?SWx3a09CMEVaMXBiTEZDU0NTWnhuYU9WSjJaQS9uSU1LYS9jK1RQZzlYblJR?=
 =?utf-8?B?bkNQSlJKRjB5NXJkeHZVSkdPRTJzVmVwTnVXdTZUYXZwZjRBVDVhV2NGVith?=
 =?utf-8?B?cmtWK0dmckVFZ1RVRHF3cDJVQWZ6NmhRalZoU1FMVEFlNER1aDdHTmwwbEtS?=
 =?utf-8?B?SHNsSzNIMHlESFR6d2dwVlZ6ckxZOC96ZXVUQm1VL3dSYXlzTmtWbkI1dVha?=
 =?utf-8?B?ZXBscnZNNXp3aFlwQ09nZUZSekM2VFlSUXB4bXdXbnByeVdRQmpocmp3YVRs?=
 =?utf-8?B?dWxLQlNjL3dhMS8zbE15QmNFSFF1ZTNSWGlQWE9SZFVJS1ZRMnBudkZzR2hI?=
 =?utf-8?B?SUhTWi9OUExWV2ordzZvNWdLT3BoUVh6TE54MEFGYm95WTZBTmpwcDNYV2ZG?=
 =?utf-8?B?MVVWSUxtUll2ei9XSEhBZXNNYlF1MFZlTEJraFRQUnE1dk04OUVucTQyZTBY?=
 =?utf-8?B?c1d1VXdtUjVuZSsxRG84Ky8rN0o3elBTQWFxTFBWSVgzeFRmeE1KanN2c3BS?=
 =?utf-8?B?WmNGbDVsdUtuc3dDOG9OTnU1SnFNZlJqL1kvYnVzekx4ZE9ZSGlWS1FyWTZq?=
 =?utf-8?B?MEpTdWhzdExxbFd0b29oUWM3M3lUeFV2Q0FMaC92bU5LNXU1cDh2YTQveEJ5?=
 =?utf-8?B?cTU4NkhpYk5LYzROSlc2N2oyTHdhVEtOZ0xPcE1aSkkwcHU5R29aeWJHajFy?=
 =?utf-8?B?aFUwRjBEUlhGWVZvbXdFR2VIeTRJYUcwZmpQcVhWaWlVQ3N5Zkd1Wi83TTBW?=
 =?utf-8?B?UDNjMjV6R0pZNG9Vc1UzRWRlaDFQK1V6UVZ3b2dOdmFHQ1JWOG1xMjB2WGxm?=
 =?utf-8?B?cWhneTZIRFpHRysyTkpOajJUQm16T2hBQUVxYkRNUzNWR0ZZcHlGNkhUVG5u?=
 =?utf-8?B?OE9ienJHcXRvNTJjMHNRY2JHWGtYQkxqbDlhR0JhbmVGVytXdjFlMjVXR2FS?=
 =?utf-8?B?UFV4Q2hadnFGVTI4M0ZwTTZGeU90R2U2VWZ3ZVp2d1ROaHpvemJERXZ6ZWc5?=
 =?utf-8?B?WUVHeWg4VWFjb0FncHcwdUNyR3VDOUlHOFB2UlArZFQzYVluczZPQmtWMm5n?=
 =?utf-8?B?MkcrVkVlNGpFbjg3YVJWY3dDUkpNZTA4RUJQT2ZxVFU4aVlGVmd1eEJMamor?=
 =?utf-8?B?TDEyUWVpWnJyWEJVN1l5T1pJaXJpYVBrMzNpV2cyY29EWmFPVTI4V3FlL1pC?=
 =?utf-8?B?bWk3S2RqckJqb1NER0pkTXBEOHh5ZEJaN3lTNkRYcjlhOEF0Uy9GbzlwcDll?=
 =?utf-8?B?RTZtUXd5bVlpdDl1cWQ2V2RhT1hFc2pjTjBreEtWelUxUC94ZTFoTDFIb0FI?=
 =?utf-8?B?NTdQZ3FON0RHSFFlbkpRQVpuenpxUmx5NXdiakRocE9RMlR2czhYZElhWndh?=
 =?utf-8?B?SzgvVUNBdmNRNzhvN2dDOGdWL3FLRVFCWGdHVk96V0Z2ck5GZEowaTMrZHlw?=
 =?utf-8?B?NDJMWXVnS0FvbEU1QmhTVTNnMW1XVXdLbW1YQmdmQ0VmSjJxM3FKU2d1V0tr?=
 =?utf-8?B?R2RhZW45eFJCYVBETzRBSldrNkNoNDBkUVhHMGpRTE0yeTdRR2JVeDFDd25F?=
 =?utf-8?B?eFhjd2U3bnZFU1BUaWpCbzhRNzJTSE9Va2liWTM1c3FlaHN5bGM5SitxN2xi?=
 =?utf-8?B?MkRaYldxRUZxYk9jbldtLzYwaS9Ea3FLREdJd0pteU5QaHJpQTh4dWhTRWlF?=
 =?utf-8?B?bS9kdElpaGdJSitXQVJuSy9Ca0R3QWUrcjN4enJmM2R6VlJrcjVBalBUWlJ6?=
 =?utf-8?B?N0ZiTEp1b3Jyb0NaWFV0dVdmSEN5ZEhQNStCNGIrd2pCeXZwV1ZNa090bEJ2?=
 =?utf-8?B?a0N3amZxZ1ZSblJldWtpUytCTXVodFh0TmdCWVZQZW5iY2hRZlRCSFMwWWRq?=
 =?utf-8?B?eGJSdldYclVBY0hRMUk0YjVPZ0xwVk9CTHJlaERHOEtnQVdSQXcxeWJPT1JY?=
 =?utf-8?B?UlUzeG83Z2p3RGtjSkFzWkNQdEFNV1lUdEgyK3pPUVZySFZablk0VFU0UWsy?=
 =?utf-8?B?R3hUYTYzd1Zvem1BL1NpSG8xeVUzbDJIOHorN2tjWDJsbnNFUnd5aW44UTlE?=
 =?utf-8?Q?xHtyLc7MoZ7n5UMtDy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf3dc706-78ba-40f0-1512-08df28569466
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 11:47:23.5524 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nbkdtJ3y2ZkG5kNC9e8EeU1Bii+ngHPVlQie34KRheDPP6t94vU8R7Gaahq5AyuX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7212
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

On 10/8/26 09:05, Srinivasan Shanmugam wrote:
> From: Lijo Lazar <lijo.lazar@amd.com>
> 
> Add a helper to get the number of XCCs for a partition, defaulting to
> one when no partition manager is available.
> 
> Add the core CWSR handling infrastructure for user queues, including
> the first-level trap handler objects and save area sizing.
> 
> Calculate the control stack, wave context and debugger memory sizes
> required for CWSR, and provide validation for userspace supplied save
> area parameters. Address validation is handled separately by the
> caller.
> 
> Create the per-VM TMA BO using the VM root BO reservation object. This
> avoids recursively acquiring reservation_ww_class_mutex while the VM
> reservation is already held through drm_exec. The TMA BO is not pinned
> and is covered by the VM reservation while being added to the VM.
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> Co-developed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

I only skimmed over it and don't know some of the technical background to full judge.

So only Acked-by: Christian König <christian.koenig@amd.com> for now.

> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile      |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h      |   3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c | 534 +++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h |  81 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |  19 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h   |  13 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h  |  22 +
>  7 files changed, 660 insertions(+), 14 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 55b5d11f1938..5086a482daf1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -72,7 +72,7 @@ amdgpu-y += amdgpu_device.o amdgpu_reg_access.o amdgpu_doorbell_mgr.o amdgpu_kms
>  	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o amdgpu_lockdep.o \
>  	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_dev_coredump.o \
>  	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o \
> -	amdgpu_wb.o
> +	amdgpu_wb.o amdgpu_cwsr.o
>  
>  amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index ce671731b700..26561a4f4db8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -332,6 +332,7 @@ struct amdgpu_reset_context;
>  struct amdgpu_reset_control;
>  struct amdgpu_coredump_info;
>  struct amdgpu_video_codecs;
> +struct amdgpu_cwsr_isa;
>  
>  enum amdgpu_cp_irq {
>  	AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP = 0,
> @@ -974,6 +975,8 @@ struct amdgpu_device {
>  	 * Must be last --ends in a flexible-array member.
>  	 */
>  	struct amdgpu_kfd_dev		kfd;
> +
> +	struct amdgpu_cwsr_info *cwsr_info;
>  };
>  
>  static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
> new file mode 100644
> index 000000000000..6b6c11bb5fd7
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
> @@ -0,0 +1,534 @@
> +/*
> + * Copyright 2025 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +#include <drm/drm_exec.h>
> +
> +#include "amdgpu.h"
> +#include "cwsr_trap_handler.h"
> +#include "amdgpu_cwsr.h"
> +
> +extern int cwsr_enable;
> +
> +#define AMDGPU_CWSR_TBA_MAX_SIZE (2 * AMDGPU_GPU_PAGE_SIZE)
> +#define AMDGPU_CWSR_TMA_MAX_SIZE (AMDGPU_GPU_PAGE_SIZE)
> +#define AMDGPU_CWSR_TMA_OFFSET (AMDGPU_CWSR_TBA_MAX_SIZE)
> +
> +#define SGPR_SIZE_PER_CU 0x4000
> +#define LDS_SIZE_PER_CU 0x10000
> +#define HWREG_SIZE_PER_CU 0x1000
> +#define DEBUGGER_BYTES_ALIGN 64
> +#define DEBUGGER_BYTES_PER_WAVE 32
> +#define SIZEOF_HSA_USER_CONTEXT_SAVE_AREA_HEADER 40
> +
> +enum amdgpu_cwsr_region {
> +	AMDGPU_CWSR_TBA,
> +	AMDGPU_CWSR_TMA,
> +};
> +
> +static inline uint64_t amdgpu_cwsr_tba_vaddr(struct amdgpu_device *adev)
> +{
> +	u64 addr = AMDGPU_VA_RESERVED_TRAP_UQ_START(adev);
> +
> +	addr = amdgpu_gmc_sign_extend(addr);
> +
> +	return addr;
> +}
> +
> +static inline bool amdgpu_cwsr_is_supported(struct amdgpu_device *adev)
> +{
> +	u32 gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
> +
> +	if (!cwsr_enable || adev->gfx.disable_uq ||
> +	    gc_ver < IP_VERSION(9, 0, 1))
> +		return false;
> +
> +	return true;
> +}
> +
> +uint32_t amdgpu_cwsr_size_needed(struct amdgpu_device *adev, int num_xcc)
> +{
> +	if (!amdgpu_cwsr_is_enabled(adev))
> +		return 0;
> +
> +	return num_xcc *
> +	       (adev->cwsr_info->xcc_cwsr_sz + adev->cwsr_info->xcc_dbg_mem_sz);
> +}
> +
> +static void amdgpu_cwsr_init_isa_details(struct amdgpu_device *adev,
> +					 struct amdgpu_cwsr_info *cwsr_info)
> +{
> +	u32 gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
> +
> +	if (gc_ver < IP_VERSION(9, 0, 1)) {
> +		BUILD_BUG_ON(sizeof(cwsr_trap_gfx8_hex) >
> +			     AMDGPU_CWSR_TBA_MAX_SIZE);
> +		cwsr_info->isa_buf = cwsr_trap_gfx8_hex;
> +		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx8_hex);
> +	} else if (gc_ver == IP_VERSION(9, 4, 1)) {
> +		BUILD_BUG_ON(sizeof(cwsr_trap_arcturus_hex) >
> +			     AMDGPU_CWSR_TBA_MAX_SIZE);
> +		cwsr_info->isa_buf = cwsr_trap_arcturus_hex;
> +		cwsr_info->isa_sz = sizeof(cwsr_trap_arcturus_hex);
> +	} else if (gc_ver == IP_VERSION(9, 4, 2)) {
> +		BUILD_BUG_ON(sizeof(cwsr_trap_aldebaran_hex) >
> +			     AMDGPU_CWSR_TBA_MAX_SIZE);
> +		cwsr_info->isa_buf = cwsr_trap_aldebaran_hex;
> +		cwsr_info->isa_sz = sizeof(cwsr_trap_aldebaran_hex);
> +	} else if (gc_ver == IP_VERSION(9, 4, 3) ||
> +		   gc_ver == IP_VERSION(9, 4, 4)) {
> +		BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_4_3_hex) >
> +			     AMDGPU_CWSR_TBA_MAX_SIZE);
> +		cwsr_info->isa_buf = cwsr_trap_gfx9_4_3_hex;
> +		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx9_4_3_hex);
> +	} else if (gc_ver == IP_VERSION(9, 5, 0)) {
> +		BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_5_0_hex) > PAGE_SIZE);
> +		cwsr_info->isa_buf = cwsr_trap_gfx9_5_0_hex;
> +		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx9_5_0_hex);
> +	} else if (gc_ver < IP_VERSION(10, 1, 1)) {
> +		BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_hex) >
> +			     AMDGPU_CWSR_TBA_MAX_SIZE);
> +		cwsr_info->isa_buf = cwsr_trap_gfx9_hex;
> +		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx9_hex);
> +	} else if (gc_ver < IP_VERSION(10, 3, 0)) {
> +		BUILD_BUG_ON(sizeof(cwsr_trap_nv1x_hex) >
> +			     AMDGPU_CWSR_TBA_MAX_SIZE);
> +		cwsr_info->isa_buf = cwsr_trap_nv1x_hex;
> +		cwsr_info->isa_sz = sizeof(cwsr_trap_nv1x_hex);
> +	} else if (gc_ver < IP_VERSION(11, 0, 0)) {
> +		BUILD_BUG_ON(sizeof(cwsr_trap_gfx10_hex) >
> +			     AMDGPU_CWSR_TBA_MAX_SIZE);
> +		cwsr_info->isa_buf = cwsr_trap_gfx10_hex;
> +		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx10_hex);
> +	} else if (gc_ver < IP_VERSION(12, 0, 0)) {
> +		/* The gfx11 cwsr trap handler must fit inside a single
> +			   page. */
> +		BUILD_BUG_ON(sizeof(cwsr_trap_gfx11_hex) > PAGE_SIZE);
> +		cwsr_info->isa_buf = cwsr_trap_gfx11_hex;
> +		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx11_hex);
> +	} else if (gc_ver < IP_VERSION(12, 1, 0)) {
> +		BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_hex) >
> +			     AMDGPU_CWSR_TBA_MAX_SIZE);
> +		cwsr_info->isa_buf = cwsr_trap_gfx12_hex;
> +		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx12_hex);
> +	} else {
> +		BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_1_0_hex) >
> +			     AMDGPU_CWSR_TBA_MAX_SIZE);
> +		cwsr_info->isa_buf = cwsr_trap_gfx12_1_0_hex;
> +		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx12_1_0_hex);
> +	}
> +}
> +
> +static uint32_t amdgpu_cwsr_get_vgpr_size_per_cu(struct amdgpu_device *adev)
> +{
> +	u32 gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
> +	u32 vgpr_size;
> +
> +	switch (gc_ver) {
> +	case IP_VERSION(9, 4, 1): /* GFX_VERSION_ARCTURUS */
> +	case IP_VERSION(9, 4, 2): /* GFX_VERSION_ALDEBARAN */
> +	case IP_VERSION(9, 4, 3): /* GFX_VERSION_AQUA_VANJARAM */
> +	case IP_VERSION(9, 4, 4): /* GFX_VERSION_AQUA_VANJARAM */
> +	case IP_VERSION(9, 5, 0):
> +		vgpr_size = 0x80000;
> +		break;
> +	case IP_VERSION(11, 0, 0):
> +	case IP_VERSION(11, 0, 2):
> +	case IP_VERSION(11, 0, 3):
> +	case IP_VERSION(12, 0, 0):
> +	case IP_VERSION(12, 0, 1):
> +		vgpr_size = 0x60000;
> +		break;
> +	default:
> +		vgpr_size = 0x40000;
> +		break;
> +	}
> +
> +	return vgpr_size;
> +}
> +
> +static uint32_t amdgpu_cwsr_get_wg_ctxt_size_per_cu(struct amdgpu_device *adev)
> +{
> +	u32 lds_sz_per_cu;
> +
> +	lds_sz_per_cu =
> +		(amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0)) ?
> +			(adev->gfx.cu_info.lds_size << 10) :
> +			LDS_SIZE_PER_CU;
> +
> +	return amdgpu_cwsr_get_vgpr_size_per_cu(adev) + SGPR_SIZE_PER_CU +
> +	       lds_sz_per_cu + HWREG_SIZE_PER_CU;
> +}
> +
> +static uint32_t amdgpu_cwsr_ctl_stack_bytes_per_wave(struct amdgpu_device *adev)
> +{
> +	u32 sz;
> +
> +	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(10, 1, 0))
> +		sz = 12;
> +	else
> +		sz = 8;
> +	return sz;
> +}
> +
> +static void amdgpu_cwsr_init_save_area_info(struct amdgpu_device *adev,
> +					    struct amdgpu_cwsr_info *cwsr_info)
> +{
> +	struct amdgpu_gfx_config *gfx_info = &adev->gfx.config;
> +	u32 gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
> +	u32 ctl_stack_size, wg_data_size, dbg_mem_size;
> +	u32 array_count;
> +	u32 wave_num;
> +	u32 cu_num;
> +
> +	if (gc_ver < IP_VERSION(9, 0, 1))
> +		return;
> +
> +	array_count = gfx_info->max_shader_engines * gfx_info->max_sh_per_se;
> +
> +	cu_num = adev->gfx.cu_info.number / NUM_XCC(adev->gfx.xcc_mask);
> +	wave_num = (gc_ver < IP_VERSION(10, 1, 0)) ? /* GFX_VERSION_NAVI10 */
> +			   min(cu_num * 40,
> +			       array_count / gfx_info->max_sh_per_se * 512) :
> +			   cu_num * 32;
> +
> +	wg_data_size = ALIGN(cu_num * amdgpu_cwsr_get_wg_ctxt_size_per_cu(adev),
> +			     PAGE_SIZE);
> +	ctl_stack_size =
> +		wave_num * amdgpu_cwsr_ctl_stack_bytes_per_wave(adev) + 8;
> +	ctl_stack_size =
> +		ALIGN(SIZEOF_HSA_USER_CONTEXT_SAVE_AREA_HEADER + ctl_stack_size,
> +		      PAGE_SIZE);
> +	dbg_mem_size =
> +		ALIGN(wave_num * DEBUGGER_BYTES_PER_WAVE, DEBUGGER_BYTES_ALIGN);
> +	/*
> +	* HW design limits control stack size to 0x7000.
> +	* This is insufficient for theoretical PM4 cases
> +	* but sufficient for AQL, limited by SPI events.
> +	*/
> +	if (IP_VERSION_MAJ(gc_ver) == 10)
> +		ctl_stack_size = min(ctl_stack_size, 0x7000);
> +
> +	cwsr_info->xcc_ctl_stack_sz = ctl_stack_size;
> +	cwsr_info->xcc_cwsr_sz = ctl_stack_size + wg_data_size;
> +	cwsr_info->xcc_dbg_mem_sz = dbg_mem_size;
> +}
> +
> +int amdgpu_cwsr_init(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_cwsr_info *cwsr_info __free(kfree) =
> +		kzalloc(sizeof(*cwsr_info), GFP_KERNEL);
> +	void *ptr;
> +	int r;
> +
> +	if (!amdgpu_cwsr_is_supported(adev))
> +		return -EOPNOTSUPP;
> +
> +	if (!cwsr_info)
> +		return -ENOMEM;
> +	amdgpu_cwsr_init_isa_details(adev, cwsr_info);
> +
> +	if (!cwsr_info->isa_sz)
> +		return -EOPNOTSUPP;
> +
> +	r = amdgpu_bo_create_kernel(adev, AMDGPU_CWSR_TBA_MAX_SIZE, PAGE_SIZE,
> +				    AMDGPU_GEM_DOMAIN_GTT, &cwsr_info->isa_bo,
> +				    NULL, &ptr);
> +	if (r)
> +		return r;
> +
> +	memcpy(ptr, cwsr_info->isa_buf, cwsr_info->isa_sz);
> +
> +	amdgpu_cwsr_init_save_area_info(adev, cwsr_info);
> +	adev->cwsr_info = no_free_ptr(cwsr_info);
> +
> +	return 0;
> +}
> +
> +void amdgpu_cwsr_fini(struct amdgpu_device *adev)
> +{
> +	if (!amdgpu_cwsr_is_enabled(adev))
> +		return;
> +
> +	amdgpu_bo_free_kernel(&adev->cwsr_info->isa_bo, NULL, NULL);
> +	kfree(adev->cwsr_info);
> +	adev->cwsr_info = NULL;
> +}
> +
> +/*
> + * amdgpu_map_cwsr_trap_handler should be called during amdgpu_vm_init
> + * it maps virtual address amdgpu_cwsr_trap_handler_vaddr() to this VM, and each
> + * compute queue can use this virtual address for wave save/restore
> + * operations to support compute preemption.
> + */
> +static int amdgpu_cwsr_map_region(struct amdgpu_device *adev,
> +				  struct amdgpu_vm *vm,
> +				  struct amdgpu_cwsr_trap_obj *cwsr,
> +				  enum amdgpu_cwsr_region region)
> +{
> +	u64 cwsr_addr, va_flags, va;
> +	struct amdgpu_bo_va **bo_va;
> +	struct amdgpu_bo *bo;
> +	u32 size;
> +	int r;
> +
> +	if (!cwsr || !vm)
> +		return -EINVAL;
> +
> +	cwsr_addr = amdgpu_cwsr_tba_vaddr(adev);
> +
> +	if (region == AMDGPU_CWSR_TBA) {
> +		size = AMDGPU_CWSR_TBA_MAX_SIZE;
> +		bo_va = &cwsr->tba_va;
> +		bo = adev->cwsr_info->isa_bo;
> +		va = cwsr_addr;
> +		va_flags = (AMDGPU_VM_PAGE_READABLE | AMDGPU_VM_PAGE_WRITEABLE |
> +			    AMDGPU_VM_PAGE_EXECUTABLE);
> +	} else {
> +		size = AMDGPU_CWSR_TMA_MAX_SIZE;
> +		bo_va = &cwsr->tma_va;
> +		bo = cwsr->tma_bo;
> +		va = cwsr_addr + AMDGPU_CWSR_TMA_OFFSET;
> +		va_flags = (AMDGPU_VM_PAGE_READABLE | AMDGPU_VM_PAGE_WRITEABLE);
> +	}
> +
> +	*bo_va = amdgpu_vm_bo_add(adev, vm, bo);
> +	if (!*bo_va)
> +		return -ENOMEM;
> +
> +	va &= AMDGPU_GMC_HOLE_MASK;
> +	r = amdgpu_vm_bo_map(adev, *bo_va, va, 0, size, va_flags);
> +	if (r) {
> +		dev_err(adev->dev, "failed to do bo map of %s region, err=%d\n",
> +			(region == AMDGPU_CWSR_TBA ? "tba" : "tma"), r);
> +		amdgpu_vm_bo_del(adev, *bo_va);
> +		*bo_va = NULL;
> +		return r;
> +	}
> +
> +	r = amdgpu_vm_bo_update(adev, *bo_va, false);
> +	if (r) {
> +		dev_err(adev->dev,
> +			"failed to do page table update of %s region, err=%d\n",
> +			(region == AMDGPU_CWSR_TBA ? "tba" : "tma"), r);
> +		amdgpu_vm_bo_del(adev, *bo_va);
> +		*bo_va = NULL;
> +		return r;
> +	}
> +
> +	if (region == AMDGPU_CWSR_TBA)
> +		cwsr->tba_gpu_va_addr = va;
> +	else
> +		cwsr->tma_gpu_va_addr = va;
> +
> +	return 0;
> +}
> +
> +static int amdgpu_cwsr_unmap_region(struct amdgpu_device *adev,
> +				    struct amdgpu_cwsr_trap_obj *cwsr,
> +				    enum amdgpu_cwsr_region region)
> +{
> +	struct amdgpu_bo_va **bo_va;
> +	u64 va;
> +	int r;
> +
> +	if (!cwsr)
> +		return -EINVAL;
> +
> +	if (region == AMDGPU_CWSR_TBA) {
> +		bo_va = &cwsr->tba_va;
> +		va = cwsr->tba_gpu_va_addr;
> +	} else {
> +		bo_va = &cwsr->tma_va;
> +		va = cwsr->tma_gpu_va_addr;
> +	}
> +
> +	r = amdgpu_vm_bo_unmap(adev, *bo_va, va);
> +	if (r) {
> +		dev_err(adev->dev,
> +			"failed to do bo_unmap on CWSR trap handler, err=%d\n",
> +			r);
> +		return r;
> +	}
> +
> +	amdgpu_vm_bo_del(adev, *bo_va);
> +	*bo_va = NULL;
> +
> +	return r;
> +}
> +
> +int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +		      struct amdgpu_cwsr_trap_obj **trap_obj)
> +{
> +	struct amdgpu_bo_param bp;
> +	struct amdgpu_cwsr_trap_obj *cwsr;
> +	struct amdgpu_bo *bo;
> +	struct drm_exec exec;
> +	int r;
> +
> +	if (!amdgpu_cwsr_is_enabled(adev))
> +		return -EOPNOTSUPP;
> +	if (!vm || !trap_obj)
> +		return -EINVAL;
> +
> +	cwsr = kzalloc_obj(*cwsr, GFP_KERNEL);
> +	if (!cwsr)
> +		return -ENOMEM;
> +
> +	bo = adev->cwsr_info->isa_bo;
> +	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
> +	drm_exec_until_all_locked(&exec) {
> +		r = amdgpu_vm_lock_pd(vm, &exec, 0);
> +		if (likely(!r))
> +			r = drm_exec_lock_obj(&exec, &bo->tbo.base);
> +		drm_exec_retry_on_contention(&exec);
> +		if (unlikely(r)) {
> +			dev_err(adev->dev,
> +				"failed to reserve for CWSR allocs: err=%d\n",
> +				r);
> +			goto err_exec;
> +		}
> +	}
> +
> +	/*
> +	 * Create TMA BO using the VM's already-locked resv so no new
> +	 * reservation_ww_class_mutex acquisition is needed, avoiding the
> +	 * recursive ww_mutex deadlock. Unpinned; eviction is handled via
> +	 * amdgpu_vm_bo_add() inside amdgpu_cwsr_map_region().
> +	 */
> +	memset(&bp, 0, sizeof(bp));
> +	bp.size = AMDGPU_CWSR_TMA_MAX_SIZE;
> +	bp.byte_align = PAGE_SIZE;
> +	bp.domain = AMDGPU_GEM_DOMAIN_GTT;
> +	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC |
> +		   AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
> +	bp.type = ttm_bo_type_kernel;
> +	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
> +	bp.resv = vm->root.bo->tbo.base.resv;
> +
> +	r = amdgpu_bo_create(adev, &bp, &cwsr->tma_bo);
> +	if (r)
> +		goto err_exec;
> +
> +	/* VM resv already held, kmap directly, no separate reserve needed. */
> +	r = amdgpu_bo_kmap(cwsr->tma_bo, &cwsr->tma_cpu_addr);
> +	if (r)
> +		goto err_tma;
> +
> +	memset(cwsr->tma_cpu_addr, 0, AMDGPU_CWSR_TMA_MAX_SIZE);
> +
> +	r = amdgpu_cwsr_map_region(adev, vm, cwsr, AMDGPU_CWSR_TMA);
> +	if (r)
> +		goto err_kmap;
> +
> +	r = amdgpu_cwsr_map_region(adev, vm, cwsr, AMDGPU_CWSR_TBA);
> +	if (r) {
> +		amdgpu_cwsr_unmap_region(adev, cwsr, AMDGPU_CWSR_TMA);
> +		goto err_kmap;
> +	}
> +
> +	drm_exec_fini(&exec);
> +	*trap_obj = cwsr;
> +	return 0;
> +
> +err_kmap:
> +	amdgpu_bo_kunmap(cwsr->tma_bo);
> +err_tma:
> +	amdgpu_bo_unref(&cwsr->tma_bo);
> +err_exec:
> +	drm_exec_fini(&exec);
> +	kfree(cwsr);
> +	*trap_obj = NULL;
> +	return r;
> +}
> +
> +int amdgpu_cwsr_validate_params(struct amdgpu_device *adev,
> +				struct amdgpu_cwsr_params *cwsr_params,
> +				int num_xcc)
> +{
> +	u32 min_size, max_size;
> +
> +	if (!amdgpu_cwsr_is_enabled(adev))
> +		return -EOPNOTSUPP;
> +
> +	if (!cwsr_params)
> +		return -EINVAL;
> +
> +	min_size = amdgpu_cwsr_size_needed(adev, num_xcc);
> +	max_size = 2 * min_size;
> +	/*
> +	 * Only save area size details checked. Address validation needs to be
> +	 * carried out separately. User is expected to pass a cwsr buffer area
> +	 * with size >= ctl stack size + wg data size + debug memory size
> +	 */
> +	if (cwsr_params->cwsr_sz < min_size ||
> +	    cwsr_params->cwsr_sz > max_size) {
> +		dev_dbg(adev->dev,
> +			"queue cwsr size 0x%x should be within min %u : max %u\n",
> +			cwsr_params->cwsr_sz, min_size, max_size);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +void amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +		      struct amdgpu_cwsr_trap_obj **trap_obj)
> +{
> +	struct amdgpu_bo *tba_bo;
> +	struct amdgpu_bo *tma_bo;
> +	struct drm_exec exec;
> +	int r;
> +
> +	if (!trap_obj || !*trap_obj || !(*trap_obj)->tma_bo)
> +		return;
> +
> +	tba_bo = adev->cwsr_info->isa_bo;
> +	tma_bo = (*trap_obj)->tma_bo;
> +
> +	if (!tba_bo || !tma_bo)
> +		return;
> +
> +	drm_exec_init(&exec, 0, 0);
> +	drm_exec_until_all_locked(&exec) {
> +		r = amdgpu_vm_lock_pd(vm, &exec, 0);
> +		if (likely(!r))
> +			r = drm_exec_lock_obj(&exec, &tba_bo->tbo.base);
> +		drm_exec_retry_on_contention(&exec);
> +		if (unlikely(r)) {
> +			dev_err(adev->dev,
> +				"failed to reserve CWSR BOs: err=%d\n", r);
> +			goto err;
> +		}
> +	}
> +
> +	amdgpu_cwsr_unmap_region(adev, *trap_obj, AMDGPU_CWSR_TBA);
> +	amdgpu_cwsr_unmap_region(adev, *trap_obj, AMDGPU_CWSR_TMA);
> +
> +err:
> +	drm_exec_fini(&exec);
> +
> +	/* TMA BO not pinned, release CPU mapping and free. */
> +	amdgpu_bo_kunmap((*trap_obj)->tma_bo);
> +	amdgpu_bo_unref(&(*trap_obj)->tma_bo);
> +	kfree(*trap_obj);
> +	*trap_obj = NULL;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> new file mode 100644
> index 000000000000..7f922559e297
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> @@ -0,0 +1,81 @@
> +/*
> + * Copyright 2025 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +#ifndef AMDGPU_CWSR_H
> +#define AMDGPU_CWSR_H
> +
> +#include <linux/types.h>
> +
> +struct amdgpu_bo;
> +struct amdgpu_bo_va;
> +struct amdgpu_device;
> +struct amdgpu_vm;
> +
> +/**
> + * struct amdgpu_cwsr_obj - CWSR (Compute Wave Save Restore) buffer tracking
> + * @bo: Buffer object for CWSR area
> + * @bo_va: Buffer object virtual address mapping
> + */
> +struct amdgpu_cwsr_trap_obj {
> +	u64 tma_gpu_va_addr;
> +	u64 tba_gpu_va_addr;
> +
> +	struct amdgpu_bo *tma_bo;
> +	struct amdgpu_bo_va *tba_va;
> +	struct amdgpu_bo_va *tma_va;
> +	void *tma_cpu_addr;
> +};
> +
> +struct amdgpu_cwsr_info {
> +	/* cwsr isa */
> +	struct amdgpu_bo *isa_bo;
> +	const void *isa_buf;
> +	u32 isa_sz;
> +	/* cwsr size info per XCC*/
> +	u32 xcc_ctl_stack_sz;
> +	u32 xcc_dbg_mem_sz;
> +	u32 xcc_cwsr_sz;
> +};
> +
> +struct amdgpu_cwsr_params {
> +	u64 ctx_save_area_address;
> +	/* cwsr size info */
> +	u32 cwsr_sz;
> +};
> +
> +int amdgpu_cwsr_init(struct amdgpu_device *adev);
> +void amdgpu_cwsr_fini(struct amdgpu_device *adev);
> +
> +int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +		      struct amdgpu_cwsr_trap_obj **cwsr_obj);
> +void amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +		      struct amdgpu_cwsr_trap_obj **cwsr_obj);
> +static inline bool amdgpu_cwsr_is_enabled(struct amdgpu_device *adev)
> +{
> +	return adev->cwsr_info;
> +}
> +
> +uint32_t amdgpu_cwsr_size_needed(struct amdgpu_device *adev, int num_xcc);
> +int amdgpu_cwsr_validate_params(struct amdgpu_device *adev,
> +				struct amdgpu_cwsr_params *cwsr_params,
> +				int num_xcc);
> +#endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index ab6f9131ac11..b2a8a8b37006 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -764,6 +764,15 @@ MODULE_PARM_DESC(use_xgmi_p2p,
>  	"Enable XGMI P2P interface (0 = disable; 1 = enable (default))");
>  module_param_named(use_xgmi_p2p, amdgpu_use_xgmi_p2p, int, 0444);
>  
> +/**
> + * DOC: cwsr_enable (int)
> + * CWSR(compute wave store and resume) allows the GPU to preempt shader execution in
> + * the middle of a compute wave. Default is 1 to enable this feature. Setting 0
> + * disables it.
> + */
> +int cwsr_enable = 1;
> +module_param(cwsr_enable, int, 0444);
> +MODULE_PARM_DESC(cwsr_enable, "CWSR enable (0 = Off, 1 = On (Default))");
>  
>  #ifdef CONFIG_HSA_AMD
>  /**
> @@ -787,16 +796,6 @@ module_param(hws_max_conc_proc, int, 0444);
>  MODULE_PARM_DESC(hws_max_conc_proc,
>  	"Max # processes HWS can execute concurrently when sched_policy=0 (0 = no concurrency, #VMIDs for KFD = Maximum(default))");
>  
> -/**
> - * DOC: cwsr_enable (int)
> - * CWSR(compute wave store and resume) allows the GPU to preempt shader execution in
> - * the middle of a compute wave. Default is 1 to enable this feature. Setting 0
> - * disables it as only in non-HWS mode.
> - */
> -int cwsr_enable = 1;
> -module_param(cwsr_enable, int, 0444);
> -MODULE_PARM_DESC(cwsr_enable, "CWSR enable (0 = Off (debugging only), 1 = On (Default))");
> -
>  /**
>   * DOC: max_num_of_queues_per_device (int)
>   * Maximum number of queues per device. Valid setting is between 1 and 4096. Default
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 8e478d3bda1a..226caa99f6ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -178,10 +178,17 @@ struct amdgpu_bo_vm;
>  #define AMDGPU_VA_RESERVED_TRAP_SIZE		(1ULL << 16)
>  #define AMDGPU_VA_RESERVED_TRAP_START(adev)	(AMDGPU_VA_RESERVED_SEQ64_START(adev) \
>  						 - AMDGPU_VA_RESERVED_TRAP_SIZE)
> +/* TBD: Ideally, existing TRAP VA should do. There is a conflict with KFD mapping that needs to be
> + * resolved. Revisit later.
> + */
> +#define AMDGPU_VA_RESERVED_TRAP_UQ_SIZE (3ULL << 12)
> +#define AMDGPU_VA_RESERVED_TRAP_UQ_START(adev) \
> +	(AMDGPU_VA_RESERVED_TRAP_START(adev) - AMDGPU_VA_RESERVED_TRAP_UQ_SIZE)
> +
>  #define AMDGPU_VA_RESERVED_BOTTOM		(1ULL << 16)
> -#define AMDGPU_VA_RESERVED_TOP			(AMDGPU_VA_RESERVED_TRAP_SIZE + \
> -						 AMDGPU_VA_RESERVED_SEQ64_SIZE + \
> -						 AMDGPU_VA_RESERVED_CSA_SIZE)
> +#define AMDGPU_VA_RESERVED_TOP                                            \
> +	(AMDGPU_VA_RESERVED_TRAP_UQ_SIZE + AMDGPU_VA_RESERVED_TRAP_SIZE + \
> +	 AMDGPU_VA_RESERVED_SEQ64_SIZE + AMDGPU_VA_RESERVED_CSA_SIZE)
>  
>  /* See vm_update_mode */
>  #define AMDGPU_VM_USE_CPU_FOR_GFX (1 << 0)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
> index 33157409eda0..e7c84b50ccf4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
> @@ -226,4 +226,26 @@ amdgpu_get_next_xcp(struct amdgpu_xcp_mgr *xcp_mgr, int *from)
>  	for (i = 0, xcp = amdgpu_get_next_xcp(xcp_mgr, &i); xcp; \
>  	     ++i, xcp = amdgpu_get_next_xcp(xcp_mgr, &i))
>  
> +static inline int amdgpu_xcp_get_num_xcc(struct amdgpu_xcp_mgr *xcp_mgr,
> +					 int xcp_id)
> +{
> +	struct amdgpu_xcp *xcp;
> +	u32 xcc_mask;
> +	int i, r;
> +
> +	if (!xcp_mgr || xcp_id == AMDGPU_XCP_NO_PARTITION)
> +		return 1;
> +	for_each_xcp(xcp_mgr, xcp, i) {
> +		if (xcp->id == xcp_id) {
> +			r = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX,
> +							&xcc_mask);
> +			if (unlikely(r))
> +				return 1;
> +			else
> +				return hweight32(xcc_mask);
> +		}
> +	}
> +
> +	return 1;
> +}
>  #endif

