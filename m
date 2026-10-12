Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B55CA9ED1
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2026 14:32:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C159910E59B;
	Mon, 12 Oct 2026 14:32:26 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012045.outbound.protection.outlook.com [52.101.43.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9788310E59B
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Oct 2026 14:32:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iohZQJuySuyAOro9/+t7F4/20wJvLK4z7kEekSHKpsWNmEZyYLs+67Umgu/EVMdti4OFfuhBENYcc5kZ+Cz41y2ivtuZQAZ0SdE+eaSs52ziqPbuTXvJh9jiQmVTvbfjICxD2Mk+sjfJjxAFr+Oi4UjydjdjZC7CzAinenM/uKbtNmMzTM6DcDhYHv3gi5ElIW5w57o31lKjvuuY6ovqw4GKSlFhfBwTsqbMV3PF7IyHRK/ztiQkTYjWE21RDaxhkJJXkojclNXbfw+pfY5M/G7TiWdNT4KjE1FM9F7X7txuoRAS6+dXPb0pwQk7GpNfm6esqtq+5gjIa7A+X3oN9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oP3hNfMjxD7/Z7IFsO36GkkNWSgUbfQqiYDXSvxLw0M=;
 b=TBZwi0oiby6/zgpr2QvVrQIrLuSLIpaqs9aspg9z3Rm7tiEWeaGSAq8b0ozmsZtzh6YjWHdVqlCSMiONQRiJ0cBf6vEcppC6oMzJOVES0HZL+lF926baKebzyUQZ9xfy9e+ydM16HS/pNxRiSrYvAc7JGa2Ar/9DUX7UHkaaM2RVb/Rneg5Zp9l9eIjRkvYhj0NzoTMphTNyeEsUi7FQU2mYcVFQE4yPnhYaj52DiFPJ7jt9nreYKSHZazUrLwbrD9xuqwqYcmakGnyH3/PuJ/0YXbTL/sZEmNY9jv2ohsE0uQidS62b0tT0SvPlEeyqITs/wPfPWiOh5H/IWUbcbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oP3hNfMjxD7/Z7IFsO36GkkNWSgUbfQqiYDXSvxLw0M=;
 b=4D40wLcYu/MfU2rnXrXBKEBmhsrux99ZJm77RZegZV/jKaYIhd+ejPJPemRMJO10EXa/pYmnxEFlVmmNks2Kvo8Twi2D2Id0xRieD614/FIswAiCa9iY2Bp5Z8PykZ1f1JZdSDO3Y+CJxBBE7mBnVs32MDXlMz9L2FoAguSfFL4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8294.namprd12.prod.outlook.com (2603:10b6:8:f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 14:32:14 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 14:32:14 +0000
Message-ID: <c7583972-aab5-42dc-a121-e619ce2d2e03@amd.com>
Date: Mon, 12 Oct 2026 16:32:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] drm/amdgpu: Make first-level trap state GPUVM-owned
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Felix Kuehling <felix.kuehling@amd.com>,
 Lancelot Six <lancelot.six@amd.com>, James Zhu <james.zhu@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Samuel Pitoiset <hakzsam@gmail.com>,
 Natalie Vock <natalie.vock@gmx.de>, =?UTF-8?Q?Timur_Krist=C3=B3f?=
 <timur.kristof@gmail.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
References: <20261008070542.1111149-1-srinivasan.shanmugam@amd.com>
 <20261008070542.1111149-6-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261008070542.1111149-6-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8294:EE_
X-MS-Office365-Filtering-Correlation-Id: b3e52e42-ffbb-4d7b-a648-08df286d9bbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|10067099003|261009223027099003|11063799006|4143699003|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: I2rCu9LsgTC/+VHzahM5DDX9pqTTmwz/2qD59iykbPp5PmhLSFj1I+toKhY/LG5x8QztDA55AFamxEA3RSyo1u4Z+DiuJITt8vs65dau71pi+ZvBweQ1ucMK1hojZmbLGHt1dDs+yBcyd2qYEiUCuy/aCe5bssD6qKLueNwMa8cCcYeC3iji6i1yf9ZJuZb7qvd2K3N3Dh5ZtHsv2e900Ko7lgWJZRmS/wkcjyonLGinpXyE9WEyYS/32NVWeV/2tCoLNznjaaSZJpdUBlbW1sSRVRA+XABvdfnyhFTEeiw/VJS8qH3pOLfr40QtpA7XKTncYy4fcMmzv3UbKse1KMM58uhiUuN08idY1WbwTVcWbcAebMDkoncWYM2jvhhUSvI+nzAOb2spKBwmKVfzNS/RVOUT7uAz2Of/BhRrDkSZnoTrf9abxZWvhZOlulTGR8QcVbUiEWcxoneWWDs6gKHm3y6M3dEptedBrtHLc3iLlGPh2OTqyuIaI/L9QqdYG9DUdTff8aGNy7XWRM5bVfNo13vKk1CRRsR+QSeSiLQsA7nhfhJsx1UEVxRFxPzfBCisuEzNxnQNgy7aFYb+M50bldfiI3QrMKW4R908UUByAJQZuzbZ6S0nTfIBwWeMwd/jTG+HWVS2aj1cukjXDYgQUN59lAMW6IAF0Gs9Eso=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(261009223027099003)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDFBWjlJRVp6MmpjdmxSSnhtaXhEZjg2bVZ1WXVnOE52b1dPTkZSbEY2aDkv?=
 =?utf-8?B?NjdXSUJjZGpUOTNjRGEwcmljZ0RldmE5MWVXUUFOb1BaZFg2clcrTjVYSWNW?=
 =?utf-8?B?SjBTSGJGOUhOQzMwNjAwWVJmcDY1aG52WnkxKzIxTUIrc2tIUEMzdFp0TGZE?=
 =?utf-8?B?Qk5TUDF5OG5LVWlwTnJmSFhDM2U1Ums4WU53VWFzbHBaaW93dkhwZVdReUlu?=
 =?utf-8?B?QW5RNXU4d0tsMmtXVm9uUDlsLzlLTXdkVnB6c004dlV1T3p1ZmdWQms4cXNT?=
 =?utf-8?B?dG1LN3hDcXIva0NteUZiOHFITGRoM0MyV3NrTWNoamtiV09WRW10WUw0RUZZ?=
 =?utf-8?B?cDltc1FwRU00UUFJZXA0NFlpK3pUS2NHRndGdURVVGZyVWpNQTRhOGNxRXFJ?=
 =?utf-8?B?WXE2T0N4VHpCTGFlZlNsRXR4Z3JDL2xNUFkxTFRacTFlZi9mYWxJUzZPKzNo?=
 =?utf-8?B?Vng1cHNTYnlhOVpkenN6c1g0V1RVVWtxeHA1TjMwYUs0WUQ1SHkvWlY1aTlQ?=
 =?utf-8?B?eEJTVFExTUtNcnlBeGdjZmlEdkx3eWRmZGdPTGJ2aXp6Mk40cXZneVFOakJ2?=
 =?utf-8?B?bVZsZG1LdVUvUExuYnNnNmlHT3BHTUIzbHI0OEVENXczM096bG5CU08zcUdF?=
 =?utf-8?B?WkRwZTFhRGNtRndvcmtLR3BRRzFKM2RNK1ArU3FSOTB0cS9pdjFxTU1wNm5Y?=
 =?utf-8?B?S215MDJuTEhlbERLZHJlNThTMUFHUG0xTDI2VlRHL1pqUGtCT3hXWXUxRFNp?=
 =?utf-8?B?MVA4ZS9Tb2FoN0o1TUROZ2QvaUxpUVI1REJybE14SnFFYlhlZWpwRmFHbHQ4?=
 =?utf-8?B?cWtYRkkrWG1jYmpaWDRVcXJRZnZDZ3RRYWlTbC8vMUI4cjVLU25YeS9nVHh6?=
 =?utf-8?B?VUdzb003bUlwaDNFL21SeW9qVHNpclpDdFFDUFVPc1hzYjA1bFp5di94eVhr?=
 =?utf-8?B?Ny9Zam0rRTdyclF0bVRIZzg3ZWY2RHQxbDJZZkkxaEVmQVgrczU0dWRqOC9t?=
 =?utf-8?B?R0lnM3lxclJGWnhMem1TZHZSNVZTV2ZEL3ZEcnVuNGFYaU1hYmZjT0dJeHhq?=
 =?utf-8?B?WWtjR2g2MjFRQWlVQmc2cFgwNE5vdi82dU5oR1EwUWF6WVhFcVRLV05zWFZL?=
 =?utf-8?B?SXpBTmZxUnBPWkhTMXJHeExHazBqbGU3V1RoN3UwVnV5cmt6eEY4dXFuOWRk?=
 =?utf-8?B?dHdkSE9XbTVvQnhIVGJXZ2tHdFpNWnN0R0hzUkhxdU52UDl0VmJXa1I2djJm?=
 =?utf-8?B?YTBvV2RncVl3Si9kNVE3b1YvSmtmQXdpZDBzK2h4MUNUS1pTa1A1RlJFSkhJ?=
 =?utf-8?B?THlaOTBIMDRyZmpYUHRtaFpWZXYxeWdTYy9jL3BSY01rdzNYb3g0Uk5Ia0FM?=
 =?utf-8?B?aUs1WlFUdDBuc3ZDTGsvcjl3Zi9TNnljblFSZ2xUNmJUZ1FGL0dUZ0NQVDBx?=
 =?utf-8?B?WFUyd0ZMeVFjRUtObzc2TkRRcjB5MmJQOTMyR24rWnFLNlcyekgydTN6OHpm?=
 =?utf-8?B?aVZJZ1VlS1A0bHU5cmgxcGFxTUxaVUo0QnA3R3V1cGlFRW9KaDNzM3FDUDFV?=
 =?utf-8?B?SWR6cDVSaGdEZlNNZisvd1VFNS9XZ2VwakdDcXRYNHg2V3BLWm40UGtyUUVY?=
 =?utf-8?B?SWxua09oYUp4RERPMS9mbzQxZjVOb1N2NUs0c0huaU40dXFLcjB0bDN5OVpV?=
 =?utf-8?B?Z2N6NkF4K2lZZm9RaXlLazBPQWZkMjg1MUE0WHdvMjJwMU5nNUZncU5QYllO?=
 =?utf-8?B?MmpnRzV6ZVlGbFI2cW9TTmN5d1dhQUM1WkpNd2RoWDNNVzlxU1UyZm9xRTdQ?=
 =?utf-8?B?aUs5bDNxaTZ2ZDlHckpUMnBDQ1JkVm9hNFpWQUJwTTBUNVlHb0hRYlJENTJx?=
 =?utf-8?B?WWZBb3ZmdjZBb1V5U2FsWXRNdG9leWovUHJTbDZOREQ5aUtZT3ZlMVZ4WVBq?=
 =?utf-8?B?dUl3VFRtb2VuOVVSVklZZTkwWHR3NmVXNjhrQTVXZ1p1cUJwWXozcTRMc2hJ?=
 =?utf-8?B?aXBqRVFnWENUVDJXZTc4eFp2NGJqa2REczlxK2Z4QzRLUlB4dG94T0Jsak54?=
 =?utf-8?B?eGhYU1dNQ0JxVEhKaHFwa2xnMTBVbTZvTUlzS2xXdkUrYU40RlAyazZITEpa?=
 =?utf-8?B?K2dxcGhMcDYxQk1zMHE3V3NlYzlEMWlDeUNXeEMyTGhzc0hmSGhaV052UzhC?=
 =?utf-8?B?MjlqN0h2SEs5NVhhcDhuYk1XenhKdUppZ0NMVnlzRDF5UFBVOGUvTnhtOG9I?=
 =?utf-8?B?WERFR2dxOU9JbktYMlFDczhQSVh0Yjgyd3MyVno0SWYveS8rYXFVU3Zvdk9Y?=
 =?utf-8?Q?HX2BgJ2N8sKINUyrMA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e52e42-ffbb-4d7b-a648-08df286d9bbb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 14:32:14.2420 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dsdeppzy0WM1TZfEWes2H2evwrBcIYm9nnxt3JaQ9+uCQ//5IdA5oRwCUnTKzaZV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8294
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
> The first-level trap state belongs to the GPUVM because the TBA and TMA
> are mappings in that GPUVM.

Oh, that was actually not what I thought of.

The idea was to use the VM PDs root reservation object to allocate the trap handler and so simplify the handling.

Moving that into the amdgpu_vm structure was not part of this plan. It's not really a page table and so probably better suited in fpriv after all.

On the other hand we want to modify it through the VM IOCTLs and so making it part of the VM is probably not so bad.

I need to think about that a bit more when I have time.

Regards,
Christian.

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
> index e55496f5ecdd..acd27ff6e0e6 100644
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
> index 6839d92b9730..45fa77c924a3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1434,7 +1434,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  		int num_xcc, r;
>  
>  		fpriv = (struct amdgpu_fpriv *)filp->driver_priv;
> -		if (!amdgpu_trap_is_enabled(adev) || !fpriv->trap_obj)
> +		if (!amdgpu_trap_is_enabled(adev) || !fpriv->vm.trap_obj)
>  			return -EOPNOTSUPP;
>  		num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->xcp_id);
>  		cwsr_info.ctl_stack_size =
> @@ -1576,12 +1576,6 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  
>  	amdgpu_evf_mgr_init(&fpriv->evf_mgr);
>  
> -	if (amdgpu_trap_is_enabled(adev)) {
> -		r = amdgpu_trap_alloc(adev, &fpriv->vm, &fpriv->trap_obj);
> -		if (r)
> -			dev_dbg(adev->dev, "trap handler not enabled");
> -	}
> -
>  	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
>  
>  	file_priv->driver_priv = fpriv;
> @@ -1651,7 +1645,6 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
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
> index 7d3659ef11e5..de4071db94f5 100644
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
> @@ -2606,6 +2607,7 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
>  int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		   int32_t xcp_id)
>  {
> +	struct amdgpu_bo_va_mapping *mapping, *tmp;
>  	struct amdgpu_bo *root_bo;
>  	struct amdgpu_bo_vm *root;
>  	int r, i;
> @@ -2614,6 +2616,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++)
>  		vm->reserved_vmid[i] = NULL;
>  
> +	vm->trap_obj = NULL;
> +
>  	amdgpu_vm_bo_status_init(&vm->kernel);
>  	amdgpu_vm_bo_status_init(&vm->always_valid);
>  	spin_lock_init(&vm->individual_lock);
> @@ -2680,10 +2684,28 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
> @@ -2830,6 +2852,15 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
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
> index 226caa99f6ee..2750123dd7d0 100644
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
> index 07b653909943..8ffbf93ff0fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -116,7 +116,6 @@ static int convert_to_mes_priority(int priority)
>  static int mes_userq_map(struct amdgpu_usermode_queue *queue)
>  {
>  	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
> -	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
>  	struct amdgpu_device *adev = uq_mgr->adev;
>  	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
>  	struct amdgpu_mqd_prop *userq_props = queue->userq_prop;
> @@ -148,9 +147,9 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
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

