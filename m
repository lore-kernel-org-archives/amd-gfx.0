Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF882CC6B1A
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 17:56:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79B8210E2DE;
	Tue, 13 Oct 2026 17:56:21 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012012.outbound.protection.outlook.com
 [40.93.195.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A00DF10E2DE
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 17:56:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H3YYbJfM3R9VScM+xR+qCRFeQIYT1x2anr26sqkl5n/s/cx6OEPkTKSmK1tSC1bL+ukAbadYHCL8IzqwNlS2eAkqnhnJm2qX5nVoygd7vHnSxR3Km2v7HRaUo172Fs99cE4xqOpavuXEYvWJNGaHe77y1dq3E616s+N6Nt3eyMtDEeSgwDoSErOlUndVSuPC9P35C5xPUsfuXDb1vPW2TgWs5/ma1HQO0hdZ4LgH4pNooy8EbLyXHMq2+dlPfBcCbQ0/6V3Tog9awALm3i2mStCSik6WUSoxXj8ncy+YFN98Mr7MyRxtA42K+LlOxK8ZHCl7iFWnwhin3KYe9d+XtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkE7EeRuLUUBxQt6sn9/1BNNkIj70lpHlDkD1Q3dzd4=;
 b=X4wd+Dbnk3hm7N4/orlhnf/3vfNCmK9ZZG9GFX/c2gP8PuiCjfb1+bG78kD8PRvO50AFfNeCST27YKhV7NmoOCXjwZdyG5xu4pLibreK8gVUgrOoguRKhR3ut6zYvBo/ExAl322ccj5JdlYwFw251rnQkVzcI+GLff19uDvEMwUMcd5WpeGqX7lBcTD1TNZymFBQVpmg+RSr2fDFe6/GtWd6JnELCPbI6gf8WA7Un623LzSoVjKSakmGHg13D02XEY27548dbVIZejLSGpGngKjS32mc7AdpCIEen3DYqhBb4KYOlGJP5xp5IRhbqb+zd4zW9tj6cd74lJvbBW63Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkE7EeRuLUUBxQt6sn9/1BNNkIj70lpHlDkD1Q3dzd4=;
 b=c8/DiTfhmiWosmFCrQXeCC5R0LJDH/GrvYrQHBR2fK4uSsBwSESoc8tkIgXAj3+fzlLBFDc1mo5pl9FMz0Goc2xYL3LK8CPGZiTwY0RBit9daYo8ESecztUjYTNPfH1jBfsWIeRo0J3TD+mrQdyq/JFTt51wRE1CRdGxLVk72n4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by IA1PR12MB7542.namprd12.prod.outlook.com
 (2603:10b6:208:42e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.24; Tue, 13 Oct
 2026 17:56:10 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 17:56:10 +0000
Message-ID: <a533d7c3-8c86-4a40-8522-685532576818@amd.com>
Date: Tue, 13 Oct 2026 13:56:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: preempt KFD queues before taking the reset
 domain lock
To: William Palacek <William.Palacek@amd.com>, amd-gfx@lists.freedesktop.org
References: <20261010162734.2570564-1-William.Palacek@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261010162734.2570564-1-William.Palacek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0296.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::12) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|IA1PR12MB7542:EE_
X-MS-Office365-Filtering-Correlation-Id: 376f608d-2a7e-4dae-d64c-08df2953438a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|6133799003|10067099003|18002099003|22082099003|11063799006|261009221727099003|261009221227099003|261009223327099003|261009220027099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: b3vRWHN4LX8og9R9fTA37cC6y1Ju/gSdHa1zH3w86OGjooVv0Dn9GXvvQMmL3ElPwZufB5DYjrS6nfqr2W6XqwGuY7cVpWL4AeBFthawEff8ri4yMxD4dgPcsDZJ/02ODCarrs1rfnefK5kCF4cKJdrR7P40U+wEuKX25SChMvQGFIpP74AdnNl7BKVxTeSq1WoqefFsVmF9Q/DT4ZWr+mTQx72oE4NwmPqmcB1MRyxxGeQKehNxs/ncp/VXBWr66efa/3q5IIbS0tnjUMJlGH0Y9hOC9GrnWmB/XmJ+TSsesnziGDPLjoM7P61mpmeGxBiE/ozYNYlwFQ+qJsdJx/xSgumYFQXsYUmFc9cXoypjWPOEfzkonY12i4IXWYnRCIeOPesgTJb28cS6rwQUJCy7xWoVVjTk/OxdTQNV07TMmlfUl8CJ7kEQfRakS1Auax/z9YE5fz+38zmIQTMEB5Y60M2A/M0tIcJEq5B42WhoFEoNU+SLqVjSxcntLUK1KAO4WM5zy23/spHVVtAh+t5pa4E0nIA4xDlsiyYxCJJqJTo3IRPw0aCWcwZSqfY3kl68T8mF0ADDw4SD0BThUHnXlnGX6Egi0hV6+DuZPu06CY1FBLSLv5Gfot8op4n5K4M+H40r66Ni+eyNK/KmBFthF+C8oeQUX7sXTEyAdPI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(6133799003)(10067099003)(18002099003)(22082099003)(11063799006)(261009221727099003)(261009221227099003)(261009223327099003)(261009220027099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am50U1NveUhBYlVGazdBNWE2SkRINk5mRENVSU1yNHFKbHRNZkdCUExqMHZC?=
 =?utf-8?B?T0luTEttd2pRZmpjMlVZZ2ZSQllBY2Z6MXBtTzZRbjFSbTc4L1JaaER2UWpi?=
 =?utf-8?B?eEp5ZURpR1orcDJnSDVJTis5cks0QWNOaGZSL3NIMHNzY1RUb3E1Z3RTdk9O?=
 =?utf-8?B?TFZocWJMdlpGamN1YVBvdC8ySUZSVjY3bXo3NTd5ZDMrcmpxVllna0xkWTdr?=
 =?utf-8?B?am50SFFTeTUxZnpYUEhOT0ZDS0NXakpNb1lKaS9ycDl0b3UwaDBhemViSG4z?=
 =?utf-8?B?RkZ1eUVEQnk4UmQwZ3lXYk1VSmV0SjIxNVlvbUZCdUFrRUI5QUl0ZzZWYm95?=
 =?utf-8?B?bkNNQUNGRjJHamRWdFVhdFBUR0k5SHlMM0VBeHEyUUJwc0xQd2c5aDVHdmxD?=
 =?utf-8?B?SmVIaDNsb0RWV2NsbDREdVh1c0dDWitqSEpONGp6TUQwRDVoa3FobHNnUHlD?=
 =?utf-8?B?VWVTQUNjdVBhNGJGVHlDNUxwN3g0WkprcUpYS0xPa3BXWGdtTVIvWko4cXNG?=
 =?utf-8?B?NVBSWHRpTmd2VEZJQ0J0WjFOaDVYODRndFZIaDQrbHpHUGcyRDZwcUFwR1NL?=
 =?utf-8?B?d0xsRyt6MnFOYksvRDk0ckFHaHBxbURqUGt5QWRtNDlzZzZxVmlKS1JmMU1q?=
 =?utf-8?B?Vnh0SlRqelNCcEhsY29WSE5IWCt3YjNhVmZNK1luR1ZXQ1NsaHEyYlhBWEZV?=
 =?utf-8?B?ZWFKZzRESHd6MThDeXNLM25RNDdJYm5ha0ZkY0ZzbnZrTUJYTE5PRDF4NCtU?=
 =?utf-8?B?MDZFd2xPdzNnb1FNeFZhcUZIWFRxam0wQ294WFBUS1RPWHRHUHVGamNZQXRR?=
 =?utf-8?B?SVB6a051NEF6YjdsRnR5cXJXaHBGNXdSNFVHWmhCUmlFbURTWVFlcnY2NXMx?=
 =?utf-8?B?V1hUWjczNlNKaGVaZ1B1c3orOFBnaTBJb2FXOXRjK2pNcktQZU4xajZaTk8z?=
 =?utf-8?B?SmdPeU9Ucm1HM2hDbVRFcEZpanNiUmxHMGs1OGFacGdhZFplcjRRbUVBelM2?=
 =?utf-8?B?R01NRWZNNC80aHpZYzRKSFZEZEk5NHFLbmpjNGhobjVrMG9wWXlVaytYZERE?=
 =?utf-8?B?UDRNR2dHZHIvQ1hJeHVRTmtBb3FRcEVtUnl6TVZ1bWJUYnVmWWpxaEQzRzRz?=
 =?utf-8?B?SkZhdS9TK2wwUy8yclg4UHVJcDU1ZWhNN0VJSmFaS25sKytmNHhFdmRtOThj?=
 =?utf-8?B?ckdTZlVEeisyZ213bnlVWndkenY2MzQ5L3NydmdmOXN3Y1E4eHA4Smtvbzl2?=
 =?utf-8?B?NEJoYzNRbG1Kck1PS25hMkJEdE1KZ3VndjEwWVZ2TXpMdHEvcGVxa2ZXekpx?=
 =?utf-8?B?VDFLV0dwa21hb0NQYW1uRzUzQmRjaHBBQlVralQ1UndQTFNVdzYwUjZVMWhx?=
 =?utf-8?B?cS8waGhMTndoVStBc0w1bG9KWUVBcVJXazlIQUZoU2c3Skk2TksvS1lhQnM4?=
 =?utf-8?B?NFdsZ3JYbDlXVG9vVDNtSXJvMWkyUGlxd1c1OFZkTmlkbm5ITGZuUEJ3TTlH?=
 =?utf-8?B?VERwMnF4NjBtNkdTK2tzNi9rSlU0SGd1UmJYRzRCckgyL2txRUhGNU1IbEdD?=
 =?utf-8?B?RldIcjVaRmd0S25mWHpoTjMvQWFvN3ptSTYrV1ZPWmdOaHI3dVZnN1hzUmtG?=
 =?utf-8?B?YXpSZ25WL1JWc1p2TWwvcjl5NWNoQ25YYkx2UFN0cWhKZE9xZkQvbGQ5YllM?=
 =?utf-8?B?TEM1U3JkUkdnU2VSU1JIbnZWSTNRbWlsVy9OV2ZkemNCTUY1dFc2NXRWeXVX?=
 =?utf-8?B?RDBNcC9HdTRxcEpGNERMZk13SElTTndub2ttT0pSNzVadlo1VVpIRHh0cEMz?=
 =?utf-8?B?b01LeUl1ZExEYU5YbWNWU0JpNHRacG9OTXl1Q3RkNXF3MkhxYk5PbnhVUDBI?=
 =?utf-8?B?VCs2TjN0MWFEZWpLN2QzcG43dUtLWW9IeCtRYUZJR3ZQdmdObDZvVTZSRWdX?=
 =?utf-8?B?MGkyNmZTaGkvaVluaGpEd2pwdFlqdkJOZDA0d0RwUGZsbVhnYzNqZDRwY1Js?=
 =?utf-8?B?OU5mNkZPU0lFUzFxdndBbGhwNlZiaEo5ZEZIaDlmTFN2YkNVRDdwVXVXdkpp?=
 =?utf-8?B?V2dtem1SVjEwTHkvU0lZNUlvWHo4MG5lbWNHRGp4L0JHVlgzWU5oVE40Ykt0?=
 =?utf-8?B?V1NOQ2U2VEp1ZVhvbktmZ3NaN0g1MWNRaVRabVQ0VGk5bzZQekQ1RjAraDhL?=
 =?utf-8?B?ZW95SXlVNFhsR0t1L0hoUTZwcGI4QytJMk5EWEFCeS96L0t3Sld5b0Z6cDUr?=
 =?utf-8?B?dzl5alg3RktNdHFCaWs2VnMrOEhaZkIvVmtFREQ3UmJvN0FBM0FNVEs5VlM2?=
 =?utf-8?B?ajhLM1BoazhFdnJkT1p5c3ZNdUZ6anZxY0RFbHpXc2xkWm91V2pPZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 376f608d-2a7e-4dae-d64c-08df2953438a
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 17:56:10.5206 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AWb59Un+ddjzpDzEGF4qFW8ayopdZFbybMMRAL9sDR7KRwDwdw6U8Gtva20Vt03I1QbzJuRWrjxrdThdv1qRcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7542
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

On 2026-10-10 12:27, William Palacek wrote:
> A GPU reset issued while processes are using the device can Oops the
> host in munmap() (free_swap_cache) after SDMA write faults from a user
> queue whose process has already exited.
>
> amdgpu_device_gpu_recover() takes reset_domain->sem for write before
> amdgpu_amdkfd_pre_reset(), so the down_read_trylock() in
> unmap_queues_cpsch() and execute_queues_cpsch() fails with -EIO and no
> unmap is sent. stop_cpsch() still clears sched_running, so user queues
> keep running while their memory is freed.
>
> Make amdgpu_amdkfd_pre_reset() take the reset device list and call it
> once from gpu_recover() before the reset domain is locked. PCI error
> handling keeps calling it under the lock, as before. Return -EIO from
> unmap_queues_cpsch() when the HWS is already known to be hung, instead
> of waiting out the preemption timeout again.
>
> Signed-off-by: William Palacek <William.Palacek@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
> v3:
> - Make amdgpu_amdkfd_pre_reset() take the device list instead of adding a
>    similarly named wrapper (Felix)
> - Drop kfd_dqm_can_reach_hw(); pci_channel_state is only valid after
>    amdgpu_pci_error_detected() (Felix)
> - Return -EIO from unmap_queues_cpsch() when the HWS is hung (Felix)
> - PCI error handling keeps calling pre_reset under the reset lock
>
> v2:
> - Drop the SRC_USER gate and the helper; run for every reset source
> - Cover amdgpu_pci_error_detected() as well as gpu_recover()
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c          | 13 ++++++-------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h          |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c          |  6 ++++--
>   .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c   |  2 ++
>   4 files changed, 14 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index e023cc734ebc..fcd857fb7d09 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -314,15 +314,14 @@ int amdgpu_amdkfd_resume_process(struct amdgpu_device *adev)
>   	return r;
>   }
>   
> -int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev,
> -			    struct amdgpu_reset_context *reset_context)
> +void amdgpu_amdkfd_pre_reset(struct list_head *device_list,
> +			     struct amdgpu_reset_context *reset_context)
>   {
> -	int r = 0;
> -
> -	if (adev->kfd.dev)
> -		r = kgd2kfd_pre_reset(adev->kfd.dev, reset_context);
> +	struct amdgpu_device *adev;
>   
> -	return r;
> +	list_for_each_entry(adev, device_list, reset_list)
> +		if (adev->kfd.dev)
> +			kgd2kfd_pre_reset(adev->kfd.dev, reset_context);
>   }
>   
>   int amdgpu_amdkfd_post_reset(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index e3da382ceb3c..7419d3614c47 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -180,8 +180,8 @@ bool amdgpu_amdkfd_have_atomics_support(struct amdgpu_device *adev);
>   
>   bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid);
>   
> -int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev,
> -			    struct amdgpu_reset_context *reset_context);
> +void amdgpu_amdkfd_pre_reset(struct list_head *device_list,
> +			     struct amdgpu_reset_context *reset_context);
>   
>   int amdgpu_amdkfd_post_reset(struct amdgpu_device *adev);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e0014611f039..7e928d09db34 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5534,8 +5534,6 @@ static void amdgpu_device_halt_activities(struct amdgpu_device *adev,
>   
>   		cancel_delayed_work_sync(&tmp_adev->delayed_init_work);
>   
> -		amdgpu_amdkfd_pre_reset(tmp_adev, reset_context);
> -
>   		/*
>   		 * Mark these ASICs to be reset as untracked first
>   		 * And add them back after reset completed
> @@ -5784,6 +5782,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   	/* Cannot be called after locking reset domain */
>   	amdgpu_ras_pre_reset(adev, &device_list);
>   
> +	/* Dequeueing takes reset_domain->sem for read */
> +	amdgpu_amdkfd_pre_reset(&device_list, reset_context);
> +
>   	/* We need to lock reset domain only once both for XGMI and single device */
>   	amdgpu_device_recovery_get_reset_lock(adev, &device_list);
>   
> @@ -6233,6 +6234,7 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
>   
>   		amdgpu_device_recovery_prepare(adev, &device_list, hive);
>   		amdgpu_device_recovery_get_reset_lock(adev, &device_list);
> +		amdgpu_amdkfd_pre_reset(&device_list, &reset_context);
>   		amdgpu_device_halt_activities(adev, NULL, &reset_context, &device_list,
>   					      hive, false);
>   		if (hive)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 5e57576fba21..c2b069832dbe 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -2832,6 +2832,8 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
>   
>   	if (!dqm->sched_running)
>   		return 0;
> +	if (dqm->is_hws_hang)
> +		return -EIO;
>   	if (!dqm->active_runlist)
>   		return 0;
>   	if (!down_read_trylock(&dqm->dev->adev->reset_domain->sem))
