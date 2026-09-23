Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC23C9830D
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 21:48:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F008510F203;
	Wed, 23 Sep 2026 21:48:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="353YRU3F";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011002.outbound.protection.outlook.com [52.101.62.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E741010F1F6
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 21:48:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cACnDCwoBtS7dUh/5pAPHtsN06MMYMURDMrLIOojGmcpb4QVQiH8mlhwQvNAxHFVGXrDEWoUuQFkQ4ltR+qGbvziskbQZgXMMCpn4wTPieOnOBshK4KHo2LPLNUu8cdnSDS7JIQ6gb1Ct+117ku8WHm+AIIw/QmMMWu6Dy+eBirMha6HhbzL2SY7YLi602yqgYefxLIVnNSmwxxXSDx/Kq+8DmdpsPjs9HACoXa2Z/7wPPQNRWOqtRR4sRKUH2LRlmG5IKmaDJPYBIuqHa1eJNvVEk11agT8+KTv+PtDlq8ES98h7paVvBE+fe0/WX0UIZaSHFevQ3MhHH7A5ycmpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBTFqrAp5XSOo9GqDZmaGozB9RYpNZtyehhwCpA1kQM=;
 b=UBMoH7ye6sLS6bncwfelP3CPyxvDt+b0uBXWU3eQ/WyaDOToqgr3psx4viJ+eNJlwV+Xf49jR2Af7BcvCwH6tf3KkEFSFMpFpKtKWCt4jSS9c/EpuWXcX3xI7V7qpLQu6Dy7wBMDzGw0ENS+VtJiO5SfdaMBlUIyc8jJ3Scp8NZQpnpu4SKAl08JRHQl+IlnR2W36E//qW3yQhe0bOSFnGOOLOD7/gKHy/XNR6WkLIxF/ZG+mmzzibXsCuSrc0LlrUaHiaJ+sw65XQ18Z+EOWhz96noBAvbpWBN45AlQeJlM0Qa9OT5wgNmOuL586qMLdkPqppkJcxIw/HKUrAB1+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBTFqrAp5XSOo9GqDZmaGozB9RYpNZtyehhwCpA1kQM=;
 b=353YRU3FS10ep5DmiFrvIsi254tNzUg+ghtsPP+dkRzzoN25zh+7PoY7rDXJkk32KeNWK+79s4muIMPHt/WTgo+pG3VQr8lkoIKIJhociFzLu4ZB244pWoJNCQA4DkM0tr0SgzrLGVG0W0b8h5AwzTGosV9vUzSwHtaeBWQgNbA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by DS0PR12MB7972.namprd12.prod.outlook.com
 (2603:10b6:8:14f::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 21:48:02 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 21:48:02 +0000
Message-ID: <f23dc930-0c03-411b-884e-57de21f97f91@amd.com>
Date: Wed, 23 Sep 2026 17:48:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 3/5] drm/amdgpu: Fix race on ualink_handle_lo in UALink
 handle export
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harish.Kasiviswanathan@amd.com, philip.yang@amd.com,
 Sashiko-bot <sashiko-bot@kernel.org>
References: <20260923212515.1420047-1-mukul.joshi@amd.com>
 <20260923212515.1420047-3-mukul.joshi@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260923212515.1420047-3-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0181.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::11) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|DS0PR12MB7972:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a880f95-1dec-4573-de7a-08df19bc5777
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|10067099003|56012099006|5023799004|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1Zfw3YfCENCZYP2Iehg46dq/yBBaSKOfO805vecv6XPJ62Ydcl3wuTufugNy+fwx8D59kCVn15i3Duwu3t2y2Rg54VSObqnd3tydYFZ2QnkP/WO8Xw6+KEc3dTbcQojI5yu0YCpE9yMdFknUlVZjm5hUyfaAcu92JPjen/3Nr5l1Bx859uZz1o1NanXpmPIHi6bMHb+v678QjKRtNWOwTbu9nJYZOAIy4MUppvVmgttzZzGKxhoKSTYqJkvluZihAbNvxetyRmqBPH2YkY0WdWeRzVVhnncfEcmQPujdEreA8My7yPMrOX2ABr4uyDvnlCMkkXYPiG6S7ivJgTR4iPnb83z7Azk7JDrs+J5CivD9QwOxVF8m2Mxy97asAfvifREvtuJerzk5/3nL98MkUf/fgwUeuKpuIwCgUtDeovF8REzJrqbgg7abGPudyRXuHX8LNZHx+IBAKpZDiOTkDjk0o9QNH4HkKfo8Q2X6J95zpiRBVC6zhaP2iQgGSmEZ6oF9v7Z94HTFucvZjpGKmLX3/DMWIRh8nwawMvfYGSncdVK+4LLtEL+aqeETUAkBGLy3lHdnmP5oV3IJuXKTjMlRzsJPDEKxynRdYozzrqMmw2bsOAYMOPxNqFCq7bhX35K1ySIDHCnL+w3PdOOYdzjdWZ5k75mXC66QiVGlkJQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(56012099006)(5023799004)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTF4MG41eXZwMDRxOE1STkRlaTBMUXE3QkI3akIxSXo4NXFaVndXckdORDgv?=
 =?utf-8?B?cHl6bEJoOFVwK3FXb1MxNFNXWmdXSTNlUnppL3Zuc29IbkdpNUZPeXRsdjJw?=
 =?utf-8?B?MndkTmlTalk4NXR6SllNcnJVY0RzRGlIdWJJMjEzSXh6d21lSVVBOXIrSlNz?=
 =?utf-8?B?SHQ0V2daWHBsOER4S1hVajlMWElvcDBYaDgrYXRRTFZsVm9lR0JCVzNjVWZW?=
 =?utf-8?B?aDhxRzB2Q0ZweDhXM1dqQjNGQTFEbVFudlp1UXh2RUhRbS9sZ2pMOUd5cW1O?=
 =?utf-8?B?NDFLb3V6bUZXb2I0NDlMSDh4RDVOblR1elVzSmpoMnV3RHpjbFNzbHRJRDR2?=
 =?utf-8?B?TTVqUnljMjRIL2dVWVc2dFlSWFpEK2xDNGl4a3FWSXRzSHRqSnRiY0N0ZkRP?=
 =?utf-8?B?VVhaVm15cTdvOVNwTlZ6eVFobnEvRnEvM0dFbXhjOWRTVlNJZ1YwRzF2eWFa?=
 =?utf-8?B?ZDAwNERzbElwNW5BdHFMREZEKzRXMTdMWGRJSUdSaTFabllMUi83MmJLUjJX?=
 =?utf-8?B?MFZoUEVMK004OUQvaUYvUWFDK2srcUpkemdGcHZaWW5nTWNpY0tsNEQ2Q0ov?=
 =?utf-8?B?TUlzTnVzYkJwZEJXOEQvbEVsUXNEVHNsc082aXA0QXVCay85TGluU1NpeTB2?=
 =?utf-8?B?bFNQazNnTkl2TkVXWnl2U29SaGJwVGx2M1JBSG5aUGxFOU9YbDF1bEtQVkda?=
 =?utf-8?B?amN1akxjdThEaytzYWozZHRSMk8wenZER3M2QkhSdTNSMVZnZTQ5OHRPczYz?=
 =?utf-8?B?VE5iZGpmdHV5NnlrTGhJYkNJVmZJUmd5dm9FV2dPV0xlaGRrMFNqSlpjU2ZC?=
 =?utf-8?B?RVhJN3EwSzByQk5sZVI5c0VBenFJYndpckk5ZHEzMDUrUVFYelR5NnlJM2Fs?=
 =?utf-8?B?VWxYUmhaVUhmMnlQMUFBZ3ZpMUJjQXBDU2NUN1dMMytiOU4yclRhTi9pNHlN?=
 =?utf-8?B?cFh2UkpTL0hMSUV5VVBBbHVPaDZMZzhFaWJNSzVkNE1waG4rbVpPN2svbEt4?=
 =?utf-8?B?WXBRdVpraFVUQThrMzkwQVk1Y2Zib1hJcmp6KytjeG45dFdpZjZISnRtRmlG?=
 =?utf-8?B?SUFjYXhaZ1IzVDM0QjFYOVhpU1FpcFM2bUY4ekJvNVByWW5jSGlVVExKUzM4?=
 =?utf-8?B?aWR6Z0dhanJoL3NzRmR6cVJVcGd6UWhmSlE2KzVPayszczVsQ2ZMRHY0MjVI?=
 =?utf-8?B?SGdnc0JuYjRTVDVLcjYrVTlxYnJqbXZ5dU1MVUZRcUlFSXYwVWZ4Ym5BU21j?=
 =?utf-8?B?Y3RDS3pjS3MvclNZZFU3Q2RTbUpSbnMzdXpUZyttY0FGOGdvSEFHaEE1ZTRV?=
 =?utf-8?B?eDRybG5NenZKcFgrTThMUGtmT2Z4Qi9mVnk4OW5TNjhEdEgwaUI2VUM3ZzZS?=
 =?utf-8?B?ZU1kZkU2U29VM1k2eVE4TUp1REIvKzNmQlRtN213aEk4dmMvVDBHY3cxVDQ5?=
 =?utf-8?B?NU01TzZtd2g1bExlSmtyeTgxd05zV0RrTnlnVThKQ0pHQVhpUUdoMU5vcnpt?=
 =?utf-8?B?NTQ3SW1vdEtoWGVVZEcwcXNWM2RBRkZPWlU3ZkJHRmJFVW1VTzJyOFBVdk5I?=
 =?utf-8?B?LzZRWlhaUFJrdlVSQU9NOS8rL3NFV2ZTOEZrS213aFk5ZW81QTNLYzEzUVla?=
 =?utf-8?B?Ly84SC94KzR4QUI5bWVaTWp1OHpjaFdpMi94NmhmdHpKTTdEN0N6MDZiNTVP?=
 =?utf-8?B?bFE3d1hVZk1OOEZjQ1B5TFVnM1R5WUJaYXVUZTAxOTBlVmh5SkVXb1R2Smdr?=
 =?utf-8?B?MUVFNkNWWG9NUEpTbjY4SEpLbzVPaHlvV0VLaElIQlBMdFdrREk0SjRmcDMv?=
 =?utf-8?B?cnRhMVpxbE1USDNiZlowY25YWGFtS0E5aHFRME9vSDM3WEFTTDh0K0VBTFJI?=
 =?utf-8?B?azNEcHlwOUZBZ2R5M0prb0xQT0sxN2lpc1BKb2JLRVg0Vm9NbjF4WHZMMGY2?=
 =?utf-8?B?N2RGcUJJQmlBc1JlRFlIR3RUZFdrQnV4VDBySm42MWg4ZkxJQ1g5cEZjdzFh?=
 =?utf-8?B?KzJCQWU1amUwTWZTTThkZ1RmOG9JL1BpK0Q5cmZvWTJMMURiSG56bkVJcU5R?=
 =?utf-8?B?cGpvSU5wN2xQRCtqWEVTQmZZTzdvRDUrNDhjUjJLTFVuOFR5Q2pYSkFGQ2dJ?=
 =?utf-8?B?b2ZlWVc2b2dzTXlJR1g4TTRhajN1L0JjbTN2MGdxdkFFTlZrbzdpbVd5cHI5?=
 =?utf-8?B?alJiWXRuaHRGTy9IYlBHSEhjWVg1UC9reWxmaXB1UG1EcEQvQWVZME9yQm9o?=
 =?utf-8?B?ZXlwQ1c3SnhPTVYzYlpxcjBPZU1EZGlXSUR1bE95L0VBemp0SEFKa0ZMWko3?=
 =?utf-8?Q?UmS86ZB+XDtWnFD0l2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a880f95-1dec-4573-de7a-08df19bc5777
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 21:48:02.3009 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PhH23xY7HKudDsN/3uiWP/8QxoJN/aSu0jptIM9Cg6rufGoxSdJw86qvKtCtI9QS8yGnr157VWn53MYWwhlNyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7972
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

On 2026-09-23 17:20, Mukul Joshi wrote:
> amdgpu_ualink_export_handle() tests robj->ualink_handle_lo and stores
> the generated handle into it without any lock; xa_lock only covers
> handle generation and the xarray insert.
>
> Two threads can therefore both observe a zero handle for the same BO and
> both allocate an exporter node, take an amdgpu_bo_ref() and insert into
> exp_xa, with the last store to ualink_handle_lo winning. Teardown only
> erases the handle recorded in the BO, so the losing node keeps its BO
> reference and pinned VRAM until device teardown.
>
> Each racing thread still generates its own handle and inserts its own
> node, but the handle is published to the BO under the BO reservation
> lock after re-checking that ualink_handle_lo is still zero. Exactly one
> thread makes that transition; the others find a non-zero value, roll
> back their node (erase from exp_xa, drop the DMABuf and BO references,
> free it) and return -EAGAIN so the caller retries and picks up the
> winning handle. This keeps a single exporter node per BO.
>
> Fixes: 6b1a5ad90778 ("drm/amdgpu: Implement UALink handle export")
> Reported-by: Sashiko-bot <sashiko-bot@kernel.org>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
> v1->v2:
> - Use amdgpu_bo_reserve() to update the ualink_handle_lo in the BO.
>    If it is not zero, then roll back the changes.
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 31 +++++++++++++++++-----
>   1 file changed, 24 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index 6e937f31a5b1..39b7cc8bc1c5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -4023,9 +4023,7 @@ int amdgpu_ualink_export_handle(struct drm_device *dev, struct drm_file *filp,
>   		if (IS_ERR(exp_xa_node->dmabuf)) {
>   			r = PTR_ERR(exp_xa_node->dmabuf);
>   			dev_err(adev->dev, "Failed to generate DMABuf for the BO\n");
> -			amdgpu_bo_unref(&exp_xa_node->bo);
> -			kfree(exp_xa_node);
> -			goto out;
> +			goto err_unref_bo;
>   		}
>   
>   		xa_lock(&adev->ualink.exp_xa);
> @@ -4036,13 +4034,22 @@ int amdgpu_ualink_export_handle(struct drm_device *dev, struct drm_file *filp,
>   		xa_unlock(&adev->ualink.exp_xa);
>   		if (r) {
>   			dev_err(adev->dev, "Failed to insert exp_xa_node into XA: %d\n", r);
> -			dma_buf_put(exp_xa_node->dmabuf);
> -			amdgpu_bo_unref(&exp_xa_node->bo);
> -			kfree(exp_xa_node);
> -			goto out;
> +			goto err_put_dmabuf;
> +		}
> +
> +		r = amdgpu_bo_reserve(robj, false);
> +		if (r)
> +			goto err_erase_xa;
> +
> +		if (robj->ualink_handle_lo) {
> +			amdgpu_bo_unreserve(robj);
> +			r = -EAGAIN;
> +			goto err_erase_xa;
>   		}
>   
>   		robj->ualink_handle_lo = handle.handle_lo;
> +		amdgpu_bo_unreserve(robj);
> +
>   		/* Return the generated handle back to the caller */
>   		*handle_out = handle;
>   	} else {
> @@ -4059,6 +4066,16 @@ int amdgpu_ualink_export_handle(struct drm_device *dev, struct drm_file *filp,
>   			handle_out->handle_hi = exp_xa_node->handle.handle_hi;
>   	}
>   
> +	drm_gem_object_put(gobj);
> +	return 0;
> +
> +err_erase_xa:
> +	xa_erase(&adev->ualink.exp_xa, handle.handle_lo);
> +err_put_dmabuf:
> +	dma_buf_put(exp_xa_node->dmabuf);
> +err_unref_bo:
> +	amdgpu_bo_unref(&exp_xa_node->bo);
> +	kfree(exp_xa_node);
>   out:
>   	drm_gem_object_put(gobj);
>   	return r;
