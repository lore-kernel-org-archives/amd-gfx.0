Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD79606A326
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 09:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=k8mw+RnD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F90310E366;
	Thu, 22 Oct 2026 09:36:21 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012022.outbound.protection.outlook.com
 [40.93.195.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32A3D10E366
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 09:36:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EgQg9+kLHFdSri5tSCC7Qsh76MPpsWaqLhC+dX6UdS8ExMEWOXJpX3ux3/R33Gsuzq+ZVZNOyy7+M2rNn7M7QKbh6nbunat7rN8fXkVW8sdu5F1zGiINJWWsec4Zm+ZoGjfk4MGgn53l8Z2c1wQjm5/ZjWjVV5KoDpk5ITYeGlkIOxRe9EiDLnccFWMJ8rERFslW4Aj/pZmjcPfnU1azd1bvz9sDBP7yoH6/o6CeAaqlFcip/Slk/D5e/0+c0jVibrCUFnNw4L3kvE7cAFU/KOfP6hxGCcpTmDGorh8n3/kgijfF6hDE8WN1x3I50Ni3g9idUdk5ME5LZ6kfLN+eCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckWJ34Y+EGny6n7oXI0Ne4hYqWEj8D+Pt0ax/q+UT/E=;
 b=N613LR7QeI8aWhe27pjQn5x2YigVCD2dyrDiVeCUkxKypQ/CvJWrVRscnCEsBorgLUpjc0qnlB3ne1GuTb+yDvmYDMCYXFXcIfo5H4xdqcTBCA0j7Dyc9Zr90S2hI3TvpfrqBUd6XGt1D4D/uLOZ3mWS+DaoAKk4j7zIcbxQiiJs1sVcJMzyqn+sK7BT7SsSGB0NyFuzEB2QBs/rsBpZ5FYMGmoaR6j5eirKdmzfuBP8XakQ9jJF2yre4RluozPC5oLGWfoUdjK3PzhUBNDQXOuSBE9/8BFNUjhgNPSAAEtlqx700L8v/VNGlPSR8noTL9TBifn+6uonRQdSLGjaOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckWJ34Y+EGny6n7oXI0Ne4hYqWEj8D+Pt0ax/q+UT/E=;
 b=k8mw+RnD4VnANuHUvRNCAfGwcQvtkQw/mT7dXef/pQGXOSCtMOI7j/jbirEK1G0+GmJc+wLnaEOYMezyoVLrAHSxim4Q1owyzP0O/WEdZrQfn05X9qR5w6zq4PX/lc/UANZGqNBlGTAM/9Tt8i1MHoiY/b9RdZUKS2cqRdNyAt8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV8PR12MB9407.namprd12.prod.outlook.com (2603:10b6:408:1f9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 22 Oct
 2026 09:36:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 09:36:12 +0000
Message-ID: <5581b93b-6076-4769-9c1e-9d2848ead2fe@amd.com>
Date: Thu, 22 Oct 2026 11:36:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] drm/amdgpu: Make first-level trap state GPUVM-owned
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Felix Kuehling <felix.kuehling@amd.com>,
 Lancelot Six <lancelot.six@amd.com>, James Zhu <james.zhu@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Samuel Pitoiset <hakzsam@gmail.com>,
 Natalie Vock <natalie.vock@gmx.de>, =?UTF-8?Q?Timur_Krist=C3=B3f?=
 <timur.kristof@gmail.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
References: <20261021065603.1329111-1-srinivasan.shanmugam@amd.com>
 <20261021065603.1329111-6-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261021065603.1329111-6-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0259.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV8PR12MB9407:EE_
X-MS-Office365-Filtering-Correlation-Id: f4d35914-bbb5-468f-9226-08df301fe912
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|6133799003|18002099003|22082099003|4143699003|11063799006|261009223027099003|261021123027099003|261021121427099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: Kvq/PZHFPwLAPsySoJdF5KYkoIxMc0jHhL24JjKEEMExdqr3g+LNv66xvOs9vrO48S0FaQzJY6/Gs65EO93+SZHjTCqMZx79n3lN7UEMdMDZ2YUq1ICBHpnxX23l04uW1Te8JtV71KQjW/k9G7J/jhyrqIQ7kB58vdq81BstYqu/Os1x9ZvZb+SWcvVMqWIlF4ZYVfjcdjNOt77VtEW3iBK6VMGlwEI4HWcICH/k7F0EZRbyA7LFnoMwM7I+LXageGLWggD0t9b25aHC0m3xuBrviYoLHr73YwwE8YxVf4YDjbKFJhglH3bUQzdUY6VSWnrQkiaSAaru/W2offHiAH2+g7ouskOn3Bh/GWmF/qEgCZXCQLLnLwM5Q1ciYyVUtbdAaSP35PM5FmsXHuXKv2wVwpyYQr4AibYXmAx21mm3egGMC1nI8z/mekcIbNUmtGImHKzJGfFnM+beOjQ14vS5jA1WzJEdMDrnHOS0YTRFoy5z/rITLl+iSYJMgR1gtMFacLfoSJUaFXuYj/Ls783EkQ8fAb9bxNr1X+ZsCEfAqSHucO1fOz72GcYpDRyhFdzG4hgmpuJ4ilHj120NdWc+6pltEVBypEO818k0YRsP+/as8E5Z5L09PuPcXuFT6eK51QnzA4cOUX+d6Wurc1RJuT3/npyYdjl5JpHd/R8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006)(261009223027099003)(261021123027099003)(261021121427099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGt4Yk1VUU9ZUVo0MGJDK01ma3plRlM4STM5VHhHczc4c04rV1FIZFNnY0hK?=
 =?utf-8?B?RVVOUFhOM0NobUxTWmZyZU9rYis0UXpxZlBkSTNLbGJpQjJMakxPQmdrMXRs?=
 =?utf-8?B?dEMzU3hlSGxGN2hnVHdTQlEwYzBGaUIycHhYLzFQNWwvbUc2eEVaZkhDRG8z?=
 =?utf-8?B?VEE4Zmd1VnRVL25IQUttUis0ZzBXYmRLMldYV2JOUUtqemNpdnFkRlNYb01O?=
 =?utf-8?B?Ykt2UFBPdi9ya3VybXh0SWM3cXI2TDN4cXF5SDl5eURCSDJCU3c2MWRxV1k0?=
 =?utf-8?B?c3U5K2ZGZTNlbG9lUGcvRS96RkFjME0zcU1hcUVBbWhYVVh1N3c4cVZRUnJX?=
 =?utf-8?B?YldpMFFUcTZZdzNFdWNvNDNoMUNEc2JCUmFVV1JnWHdNLytQUUtSeTBFd1Vq?=
 =?utf-8?B?MERDRXV4aWZuTmxvZWxaNHg2R2dOSFAzVFdhcTh4cUtpTW54SFR4dXllYk50?=
 =?utf-8?B?V2wzem1zelBwT1h6VWh4ejVXRWpnVGY3R1Q3N1JLSjBVZ1o3aTNuY2RscWxz?=
 =?utf-8?B?cGJyOS83bUZKVjlaRzh5d2N6WElZMCtJV28rcEIyckRzSjJ4Y2NLNFlaNGow?=
 =?utf-8?B?dTRFTGs1NUx2OEIySUZNMy85SDV3TW9uczdsZExVeHBXNWcrYnJEcUlMdnFo?=
 =?utf-8?B?cDh5alFYTGhUbmJKbVpKR3VRNXVVcnl3WDhqbWk5L3RmeHlFVDRLL0dlQ1cv?=
 =?utf-8?B?Yk1oM21IY3MvRXd3cmFWNThDYmplb0lqR09NQnZtbTVENzJLTEl5U2E3NDFI?=
 =?utf-8?B?ZjJaY3JvVXQ0c2M1RldUb3JvTVdIUmdLZUs5UTI1Q3dycEVmZUhkQWhpUmgv?=
 =?utf-8?B?MVd5ZTFPMTVzM2FjamNHZzVad2VpT3A5emNBZzdXV0xIVDJCaFlsUWlPNXBZ?=
 =?utf-8?B?RjFFaHlBQTZZZWNBeGYyRlV4a2JYV1dyUldRMzlzWkZxNkNQc0J4d2RJNG9C?=
 =?utf-8?B?dmQrazRHVWRRYVZTUmpWY2NYcDVnSHYxVFdMeE5MSFhiemR5elpZQ0ovMW1h?=
 =?utf-8?B?bW0rWkppcFYxdkVHQ1RYc00vRUl3YlloV2dadFl4Z05seCtSWHl5OGl2NS8y?=
 =?utf-8?B?VG5uUndFV1N0WVQ3NGx2ZHQ3THlFandBQ2JkaTdLV3FnV3ZaR0tSeHV1VG5I?=
 =?utf-8?B?Y1RZdVhxRHRyMkVHR0RLc3VvdEpiUlpFT0FJcjc1SVo3SFF6d1hrSGF5VExQ?=
 =?utf-8?B?Wko3ejJEQlFxYkw2TVl0TUlKKzloZmRNRDhJZEZubkIyQjJibDArYmZpbmI5?=
 =?utf-8?B?WURUTVM2WkwxektJdTFFbUNCZ0VmODAzU1FENWowNmdhWXVOREpMRDNpeTRi?=
 =?utf-8?B?cmNJV1ZvcVB6Nkw2NzVHUENnTTBINGxkUk1QRnhGZVUvem9NOGUzVGtjRkQw?=
 =?utf-8?B?T1Y4N0F6eU5qVXdzc2lURzV5Y0FpQUFOSC9vYVpGNnRQcVZNUGhyVS91TXJ0?=
 =?utf-8?B?WDNwUW53aHNpY2RoaDJLTkk3UU0vMVRNOTJLMldRYUVmWlJ1MXVWS2hqd0pR?=
 =?utf-8?B?eGV2NkFRdWZwVU1NU3ZaeHhHbnBudVNWMDNBMkp1d2NHbmxrUkEzUnM0UVI2?=
 =?utf-8?B?NjlaWXVTWHN1Zjc1d0Y5Z3RSbVNFY2FyREFwUGR6QnZUck5pOGR5VlVBSUZE?=
 =?utf-8?B?OFI5VElvcld4UXpOcTlmc1BVT2hRNzRWWWNWb2MxTkozcFp1bUpYdXp0eGpC?=
 =?utf-8?B?OVZvdk4yQzdpVkJsY2RDMHZybSt5anU2ZldXc1FCOTluZWl3enNCUkYzRjFE?=
 =?utf-8?B?Q3h1VkthNWVmUG1LWnZadk5wVkMvbU5PR0F0cVZ6RWdqdGMwZGhTaVBKL3Mz?=
 =?utf-8?B?Uk1VL2srSXBQWXZxdE1wSkVFejU1SXg5Y2ZBaWkrVnJFRnhlODNVdkx5OG1m?=
 =?utf-8?B?QjJrVDBKTHRCNmsxN1pHUXVEVTRNM045YkZZOVovSEplOE5oNjlTWkkxdmNl?=
 =?utf-8?B?K3VjVkk2R1lRZExkdXNvcXJyMDdydVVFbzMxT29QM2U1RkNySXcwREk5U3VW?=
 =?utf-8?B?MVplOFNia3lwMVhaKzRNZzIzTlkwcHBkaE9oNnNlUXJLa2dKUWZSV0ludEo0?=
 =?utf-8?B?emdOdjJsL3ZlQlhKaXI2V0pIWjI3Rko1dnEwdVNNb2pOeUNvRlF6RFl5MTFZ?=
 =?utf-8?B?T1lXNHBzdS8ydzdvbVBlKytKcGpVc0hiNXhRV01sNDhrUUdyZkdEWUh2VGNU?=
 =?utf-8?B?OTRBd2g2RUVaTWVEcytqMlZtMkh5dkQ1clhNV2wvcVNDK3k4SmtuRCsrN1Z4?=
 =?utf-8?B?bDhjN1h6dHNIbTZjUHd4bE4zRlVvc2QxLzJRU3QvcUliR1AvY1dEcUl0emVp?=
 =?utf-8?Q?BHaEPx0BsumadDlyrb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d35914-bbb5-468f-9226-08df301fe912
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 09:36:12.4777 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sRaPD9Kh33C6cSN27Mq1iEKuFCmVRNfsFKcRVZoUayOnjVeDCMZoM6e20ESo7GtE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9407
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/21/26 08:56, Srinivasan Shanmugam wrote:
> The first-level trap state belongs to the GPUVM because the TBA and TMA
> are mappings in that GPUVM.
> 
> User queues and kernel queues using the same GPUVM use the same
> first-level trap state. There is no need to keep a separate trap object
> in the file-private data.
> 
> Move the trap object into struct amdgpu_vm. Create it when the GPUVM is
> initialized and free it when the GPUVM is destroyed.
> 
> Create the trap state after releasing the initial VM root reservation.
> The trap allocation locks the VM internally, so doing this while the VM
> root is already reserved could lock the same reservation again.
> 
> For the same reason, free the trap state before reserving the VM root
> during VM cleanup.
> 
> Keep the first-level trap ISA buffer shared at the device level. The ISA
> is the same for all GPUVMs on the same device, while each GPUVM keeps
> its own trap mapping and TMA state.
> 
> Update the user queue path to get the first-level TBA and TMA from its
> GPUVM.
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Cc: Lancelot Six <lancelot.six@amd.com>
> Cc: James Zhu <james.zhu@amd.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Samuel Pitoiset <hakzsam@gmail.com>
> Cc: Natalie Vock <natalie.vock@gmx.de>
> Cc: Timur Kristóf <timur.kristof@gmail.com>
> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Change-Id: If9f3516fe1f8ec5ebec5365f77655f0d1b928dd0

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 --
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  9 +----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c   | 41 ++--------------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 31 ++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  4 +++
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  7 ++--
>  6 files changed, 41 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 2f49da48aa90..001d44206836 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -333,7 +333,6 @@ struct amdgpu_reset_control;
>  struct amdgpu_coredump_info;
>  struct amdgpu_video_codecs;
>  struct amdgpu_trap_isa;
> -struct amdgpu_trap_obj;
>  
>  enum amdgpu_cp_irq {
>  	AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP = 0,
> @@ -422,7 +421,6 @@ struct amdgpu_fpriv {
>  	struct xarray		bo_list_handles;
>  	struct amdgpu_ctx_mgr	ctx_mgr;
>  	struct amdgpu_userq_mgr	userq_mgr;
> -	struct amdgpu_trap_obj *trap_obj;
>  
>  	/* Eviction fence infra */
>  	struct amdgpu_eviction_fence_mgr evf_mgr;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 201c167577c6..bc623eeee4bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1460,7 +1460,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  		int num_xcc, r;
>  
>  		fpriv = (struct amdgpu_fpriv *)filp->driver_priv;
> -		if (!amdgpu_trap_is_enabled(adev) || !fpriv->trap_obj)
> +		if (!amdgpu_trap_is_enabled(adev) || !fpriv->vm.trap_obj)
>  			return -EOPNOTSUPP;
>  		num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->xcp_id);
>  		cwsr_info.ctl_stack_size =
> @@ -1604,12 +1604,6 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  
>  	amdgpu_evf_mgr_init(&fpriv->evf_mgr);
>  
> -	r = amdgpu_trap_alloc(adev,
> -			      &fpriv->vm,
> -			      &fpriv->trap_obj);
> -	if (r == -EOPNOTSUPP)
> -		r = 0;
> -
>  	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
>  
>  	file_priv->driver_priv = fpriv;
> @@ -1679,7 +1673,6 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>  	}
>  
>  	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
> -	amdgpu_trap_free(adev, &fpriv->vm, &fpriv->trap_obj);
>  
>  	if (pasid)
>  		amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> index 12e37d0467f9..89968b5b7ecb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> @@ -326,8 +326,6 @@ static int amdgpu_trap_map_region(struct amdgpu_device *adev,
>  	va &= AMDGPU_GMC_HOLE_MASK;
>  	r = amdgpu_vm_bo_map(adev, *bo_va, va, 0, size, va_flags);
>  	if (r) {
> -		dev_err(adev->dev, "failed to do bo map of %s region, err=%d\n",
> -			(region == AMDGPU_TRAP_TBA ? "tba" : "tma"), r);
>  		amdgpu_vm_bo_del(adev, *bo_va);
>  		*bo_va = NULL;
>  		return r;
> @@ -335,9 +333,6 @@ static int amdgpu_trap_map_region(struct amdgpu_device *adev,
>  
>  	r = amdgpu_vm_bo_update(adev, *bo_va, false);
>  	if (r) {
> -		dev_err(adev->dev,
> -			"failed to do page table update of %s region, err=%d\n",
> -			(region == AMDGPU_TRAP_TBA ? "tba" : "tma"), r);
>  		amdgpu_vm_bo_del(adev, *bo_va);
>  		*bo_va = NULL;
>  		return r;
> @@ -351,39 +346,6 @@ static int amdgpu_trap_map_region(struct amdgpu_device *adev,
>  	return 0;
>  }
>  
> -static int amdgpu_trap_unmap_region(struct amdgpu_device *adev,
> -				    struct amdgpu_trap_obj *cwsr,
> -				    enum amdgpu_trap_region region)
> -{
> -	struct amdgpu_bo_va **bo_va;
> -	uint64_t va;
> -	int r;
> -
> -	if (!cwsr)
> -		return -EINVAL;
> -
> -	if (region == AMDGPU_TRAP_TBA) {
> -		bo_va = &cwsr->tba_va;
> -		va = cwsr->tba_gpu_va_addr;
> -	} else {
> -		bo_va = &cwsr->tma_va;
> -		va = cwsr->tma_gpu_va_addr;
> -	}
> -
> -	r = amdgpu_vm_bo_unmap(adev, *bo_va, va);
> -	if (r) {
> -		dev_err(adev->dev,
> -			"failed to do bo_unmap on CWSR trap handler, err=%d\n",
> -			r);
> -		return r;
> -	}
> -
> -	amdgpu_vm_bo_del(adev, *bo_va);
> -	*bo_va = NULL;
> -
> -	return r;
> -}
> -
>  int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		      struct amdgpu_trap_obj **trap_obj)
>  {
> @@ -464,7 +426,8 @@ int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  
>  	r = amdgpu_trap_map_region(adev, vm, cwsr, AMDGPU_TRAP_TBA);
>  	if (r) {
> -		amdgpu_trap_unmap_region(adev, cwsr, AMDGPU_TRAP_TMA);
> +		amdgpu_vm_bo_del(adev, cwsr->tma_va);
> +		cwsr->tma_va = NULL;
>  		goto err_tma;
>  	}
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 3f19d03fd7d8..6fafd29ae25e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -45,6 +45,7 @@
>  #include "amdgpu_xgmi.h"
>  #include "amdgpu_dma_buf.h"
>  #include "amdgpu_res_cursor.h"
> +#include "amdgpu_trap.h"
>  #include "kfd_svm.h"
>  
>  /**
> @@ -2628,6 +2629,7 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
>  int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		   int32_t xcp_id)
>  {
> +	struct amdgpu_bo_va_mapping *mapping, *tmp;
>  	struct amdgpu_bo *root_bo;
>  	struct amdgpu_bo_vm *root;
>  	int r, i;
> @@ -2636,6 +2638,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++)
>  		vm->reserved_vmid[i] = NULL;
>  
> +	vm->trap_obj = NULL;
> +
>  	amdgpu_vm_bo_status_init(&vm->kernel);
>  	amdgpu_vm_bo_status_init(&vm->always_valid);
>  	spin_lock_init(&vm->individual_lock);
> @@ -2702,10 +2706,28 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		dev_dbg(adev->dev, "Failed to create task info for VM\n");
>  
>  	amdgpu_bo_unreserve(vm->root.bo);
> +
> +	if (amdgpu_trap_is_enabled(adev)) {
> +		r = amdgpu_trap_alloc(adev, vm, &vm->trap_obj);
> +		if (r)
> +			goto error_free_trap;
> +	}
> +
>  	amdgpu_bo_unref(&root_bo);
>  
>  	return 0;
>  
> +error_free_trap:
> +	amdgpu_bo_reserve(root_bo, true);
> +
> +	list_for_each_entry_safe(mapping, tmp, &vm->freed, list) {
> +		list_del(&mapping->list);
> +		amdgpu_vm_free_mapping(adev, vm, mapping, NULL);
> +	}
> +
> +	amdgpu_vm_put_task_info(vm->task_info);
> +	dma_fence_put(vm->last_update);
> +
>  error_free_root:
>  	amdgpu_vm_pt_free_root(adev, vm);
>  	amdgpu_bo_unreserve(vm->root.bo);
> @@ -2850,6 +2872,15 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>  
>  	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
>  
> +	/*
> +	 * Free trap state before reserving root. amdgpu_trap_free()
> +	 * uses drm_exec to lock the page directory internally; calling
> +	 * it after amdgpu_bo_reserve(root) would deadlock on the same
> +	 * ww_mutex.
> +	 */
> +	if (vm->trap_obj)
> +		amdgpu_trap_free(adev, vm, &vm->trap_obj);
> +
>  	root = amdgpu_bo_ref(vm->root.bo);
>  	amdgpu_bo_reserve(root, true);
>  	dma_fence_wait(vm->last_unlocked, false);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index f55239b5bc06..3242d2fa0c8f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -43,6 +43,7 @@ struct amdgpu_bo_va;
>  struct amdgpu_job;
>  struct amdgpu_bo_list_entry;
>  struct amdgpu_bo_vm;
> +struct amdgpu_trap_obj;
>  
>  /*
>   * GPUVM handling
> @@ -385,6 +386,9 @@ struct amdgpu_vm {
>  
>  	/* cached fault info */
>  	struct amdgpu_vm_fault_info fault_info;
> +
> +	/* First-level trap state for this GPUVM; NULL if unavailable. */
> +	struct amdgpu_trap_obj *trap_obj;
>  };
>  
>  struct amdgpu_vm_manager {
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 67fccdb64f14..951fa302a5fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -121,7 +121,6 @@ static int convert_to_mes_priority(int priority)
>  static int mes_userq_map(struct amdgpu_usermode_queue *queue)
>  {
>  	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
> -	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
>  	struct amdgpu_device *adev = uq_mgr->adev;
>  	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
>  	struct amdgpu_mqd_prop *userq_props = queue->userq_prop;
> @@ -153,9 +152,9 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
>  	queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
>  	queue_input.wptr_mc_addr = queue->wptr_obj.gpu_addr;
>  
> -	if (fpriv->trap_obj) {
> -		queue_input.tba_addr = fpriv->trap_obj->tba_gpu_va_addr;
> -		queue_input.tma_addr = fpriv->trap_obj->tma_gpu_va_addr;
> +	if (queue->vm->trap_obj) {
> +		queue_input.tba_addr = queue->vm->trap_obj->tba_gpu_va_addr;
> +		queue_input.tma_addr = queue->vm->trap_obj->tma_gpu_va_addr;
>  		queue_input.trap_en = !amdgpu_trap_has_dbg_wa(adev);
>  	}
>  

