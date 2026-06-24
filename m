Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D2FCDE002
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 15:14:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D625F10E09E;
	Wed, 24 Jun 2026 15:14:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ONjUj9Pm";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011060.outbound.protection.outlook.com [40.107.208.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80A4610E0A0
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 15:14:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YvQMZBWTpKRUXjEQ2/mUXTnPtToyo8hA7c+Zde5THehCnaPUcOnAgdv483dj9ST9tdoMR/aTu6+haDg2qTuvszPW+06SAchZH0hFjIA2lscsxE2Nek1gpkBKpSiNX016r+y5UbNADOe7SWC6NRzCY48lXgX8Ahnsy5WFXjAb5SRkBkK07UJW+aIyaZ9c70Y8Rj70wfkXmx/pvHER6dYr+5aP1RzMloGuJFajQuZEq0ozvk1ACBsZi6ccvQeLIa05Q+7fW6AkdSWvvbEaCPDCxMHrJPmT72DSiOmWt1Qul9ZnkuvCy08LHpRq1H7tOlmSjqke3yefLIYx+tHSy7/+CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLI8Ce1SyDKYb5LzV1n+rzqRpXvHEQrQ7QVcnHWyArY=;
 b=MOCoFT1Q8QpzY41cspTPNo9zEdNcmmQFb4+Z3g3TRNTBFyesjNYFPbpt0wXvH7/vlMlttprAv0t1A3U/WXDLPAtnA6CHzZHXehbN2EgJG8oFnsFGLmdTBchzQz2mANUZvMujy/N96A+XyY5DeSX2AMgp88QEHQBwJDmM2Qn/DxzPpCtsST19EzHGThhYL9c62nGFuT5LQcKs/V9rhRKuczRpCPYFCPImGjgA6zSCU1azJOjxmSbxTmkw9rUHEOOBckc1wJ5/nptIfwE3EwuJSueHtIZzq7Cwmm0diSPaVADRWVa6BPJVsGNtI8pjDZKAMxlaOQJjgZzcFUbRankJtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLI8Ce1SyDKYb5LzV1n+rzqRpXvHEQrQ7QVcnHWyArY=;
 b=ONjUj9Pm++fJOlDklETFsH1epzu44QDJPeuYuTPLPAQ7AqIoHs0X6KLAOGNM9y7WsjbeOqWZWYTfUN8MIbV9odPXd4fn31lICc7dC7DfRhklVggqqyb/yXhlFT+8j7PkTM9sk82RaYBTYjbMjwA6Xtb9Ki5N9lru4x0WfUDAQsM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CH3PR12MB7618.namprd12.prod.outlook.com (2603:10b6:610:14c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Wed, 24 Jun
 2026 15:14:04 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::8218:248d:58ec:8c81]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::8218:248d:58ec:8c81%6]) with mapi id 15.21.0159.014; Wed, 24 Jun 2026
 15:14:04 +0000
Content-Type: multipart/alternative;
 boundary="------------kqfaLqTpK01Pia5bduDDIgnB"
Message-ID: <1022cda1-2649-4914-a742-d692436c3ac2@amd.com>
Date: Wed, 24 Jun 2026 11:14:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amdkfd: support kfd map bo to kernel
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: philip.yang@amd.com, Hawking.Zhang@amd.com, Bob.Zhou@amd.com,
 Harish.Kasiviswanathan@amd.com, jamesz@amd.com,
 Vladimir Indic <vladimir.indic@amd.com>
References: <20260624142727.1946258-1-James.Zhu@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20260624142727.1946258-1-James.Zhu@amd.com>
X-ClientProxiedBy: YQZPR01CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::25) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CH3PR12MB7618:EE_
X-MS-Office365-Filtering-Correlation-Id: aa2c21d0-3a14-40ca-117b-08ded2033a7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|8096899003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 6EdIR+7Yyud0Gf7ZgHgSSyhLTEeb/3QNRWyC7D1ccIpw4fij36HuS6ZK21vwV/Zx2jMzCXimvUW6rGg+FBggPQdKg0Kn1shf3BTIB05jYp6fNJmvnxiBTtHycOjDB5NEF1qYAF6LeNNdW6ueZIAPd7IgElUo3C6I5vIynyIWyO7mEii6O5zuMuWGxnxBrwBBzTleP8BAznh+os58LAEvSWXO1Nv9q/OdtGWvAqjPWrqoXrL3z61umAki3tCPawmk0KuiqIfYMfGNcHyML09SbURXoDVJjMlJleu5txqTrtYY1g8xSCMUaUgmLG3kRdOZ+ab+/ODHW/Bl0hAANplnjVf33iQ/Ryf5wybTbBdNhIDA4vFbdH+6gjYIMFmfoSTWFow9CfCAY9U7fPDvytb4LY6bQh/82vHTxccY52PDE6X4RtLrbOY/znIZ4HK1OESl5FWlECmSykMx/PaeF+NM0ZjmhA8NFv14+tz1zq6bK0nYiS3WcmCeuw+14hMJJ/tEVUcwtmgR5lAKzms0/XgRWDfpfGnzZbyfuVt5oP148JoIbT5ZWPiZcc/Noru/gNSvafnx/w1fFPYk/pFmdH9Z8vEXpaiS5/vUbJtihZyvqM2kJhOP9x6rY3/KgYWjUcUPJq8jNDSV939Yh3/+WjMu4VIjbdZXt7J+5QAZzCP/IBI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(8096899003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHMxZHZHRHN4MEY3cmtsdHBYOGFESHJvYkp6YmVqSTRxQmdFUjBEdWJJUEt5?=
 =?utf-8?B?MGZ2VG5TYXFxTW9yRFEyTWVvQzFkZE9RZWhpZ3dhYW9RNG55a1JlNC9mbnR1?=
 =?utf-8?B?dmY4ZW1EVWY4WkJ4a2JOZWVXanFNU2xEYjkvbmpwZU84aEFOZDF6bXhXcW1X?=
 =?utf-8?B?c0NDM0JFL2doRTJmbW55WGZLcEhuOWgzeGtMY1Q0dWhHOFI3U2dLcUFHTkJz?=
 =?utf-8?B?Q1FFcURab0R2RzdhYmxaOE5ieWU0WnZjSXJGV05pSGk5WFZaOUhJTDJRNkUv?=
 =?utf-8?B?dDFHbzliZG15cWs5VHd2NThqY2VNaEhkV3lQUCtJUnpUV2RYKytvNnBvNVF5?=
 =?utf-8?B?cFFkV1NKR1gwOTZ3TEFTZzg4OUZOVk1Kd25kOSt6WW1WL2NaaWZYVUFjY1Q5?=
 =?utf-8?B?UUl5ZmhZT3pLMkVuazUrWGtkb1dXVFBrd2FpTFEwQm9adG5sVlEzUy9sM05x?=
 =?utf-8?B?bEVvUGRIaHM1bFpkR0o3RzdhV2tWSVdiTmtRRGt0czgveXlZc01oTU5OR3JT?=
 =?utf-8?B?ZHJ5Qm8yeVpBeTdpSk5NNG1zQXplakN2aDVoUndvbnQwWnE1RVRMY3o5L1hB?=
 =?utf-8?B?VTBIL1cwbkRBb2JVdSszV1EvamJjTmJTK0lBbm9DZjJYMkNDaFVpaHJaN3BE?=
 =?utf-8?B?Y3hxTHVjS3ViSjlFMkp4cnVPVnFvN1hHVXZ4T0FEVWpRWUpiSkNqdkF5YTI5?=
 =?utf-8?B?QUxacnh4ZzBEb2gya2dSVjJRWmJPYmtKY3p1eFhYR1d2N3h6ZGh2cStsUWcr?=
 =?utf-8?B?WlVXSkd4ZkhnZVJjT3FzRWJnK0xVb0YyemNsZ3hacXlMdGxaaXdQZGU3QWRX?=
 =?utf-8?B?WlZ3ZmxnSW5GOGNneEVCSS9uT2RqaC9wa2orUktNQWh0WUIxbXdTTFpmOFg1?=
 =?utf-8?B?L2V0Nml0Y3BscHNNSlhHeFF5OGNtSTNwdnBRU3NwM0Eva25ISzFJZDNoc2Vs?=
 =?utf-8?B?UnE1M3Z5NitTaHF2b0pTaktsZVpqR0hHcmVaU3p2QnNyRnNDb0xaVmVwQmVl?=
 =?utf-8?B?WmRzNStEdmh5ai9lejJaR3Vub09tUTBCbVA1M0krODEycWgxdGtlQ01XSE9M?=
 =?utf-8?B?Lzk4K2RZaVVCYWhabGhBVVRZTmZqd09pNlFqeHdnZDgza2IrNnorZ0hTMy9q?=
 =?utf-8?B?SnRpUUtNQnhYOFNSNUVZdVM3VitzQ3BwT2tHaXl3QVEvQzNoN0xySnFQemts?=
 =?utf-8?B?bW5uN3M5bjZaOTNQTFliRWVKNy9lTmQ0VmtSQTBkUlRWdlVYNFJEMDFCS2xn?=
 =?utf-8?B?bHhlYXFETU9tOFZxRU9CVkpjQXhQQnJZQWpFR1dvTm5xUndaa2RibTNoNldt?=
 =?utf-8?B?WFJoRmJmSSswTDBrUlRpSGcxZ0lVQzVpSHJSYUhzTDVlb1B4cUN0Z0VMbWpB?=
 =?utf-8?B?NkZJd0U5alB6L3lkYkxTeGVPWlBNbEg5QitxZVpmVFpnVERMaTZWd2JESkpj?=
 =?utf-8?B?OVdyNHZ6T2F1VFFWVTNmOFRPS1JSL202MTM4N25qMm1vbGhJZDRkb1B6Q0VC?=
 =?utf-8?B?L21wYlk5b2F4VTRaNU4wQzVHc29VMTlUb2hwcFl6aHhpT0g0bThod05ETmV4?=
 =?utf-8?B?SmlGbktZTldZMjlwZXlvbWtpWDhvc0IxVTRRR0ROSFR4MDNzQU9STTdZbUhS?=
 =?utf-8?B?SGZmQTJhN2FTMzZBYlg1VDlSa1o3TVRrZTg4ZG5pRFhaYWRFamJqdUJUYlhx?=
 =?utf-8?B?ZUxhMTBWUzViUmV0eHJ6dFZwamFZU09qOVNoQVVDUElScElqY1pMWGNxbVVu?=
 =?utf-8?B?RDZJckpVQ3NVTlllRUtWamtJWlhqTEE5YUtZbkZ5OHR0MVhqOWxRMy9mZ21i?=
 =?utf-8?B?YjVZQmNZT2R0cTRaYjdzZnYyRENKTkdrS0lNN1Jha09aNlZXbkVONm1CSzFV?=
 =?utf-8?B?bGNaTE54VGJJMGt0WkhZdVRialRJQ0p3YytVMThLMkhmdVhLMWNhcTZTNWdX?=
 =?utf-8?B?aTRFb2h2QjRVaW82SUI1eWNmRDJIdG40QjNaNjBOMDZOOXl5VDJNREsyejd6?=
 =?utf-8?B?Vk81Nk54dk4rZEFMdUo2N1dweHdIUUtrZmtLT1BmNExCbEpuZ1pYcmZlMlJC?=
 =?utf-8?B?REpFcVY5anNTaWN3Y0VaUFAzeEF6cE4va0VxU2M4aWIxaHFOQ3JRWXhNbmJy?=
 =?utf-8?B?Nlo5b24zZDRhcjl4MDRMZWpIeXA2dDMveWluTGgvY2JCWWVBYzJjZU9lZjBU?=
 =?utf-8?B?a2NJWW9pOEtSQWl1Ti94L2FvaGdXK3dyNzFOcVZxM2ZHeDM3dkx2aWNhcCs5?=
 =?utf-8?B?SEF4ZGhpdVBJa3QrQXhBVTdwUzNiN1BFM296YUpGVWs4WmJZdlhJYThMUXN4?=
 =?utf-8?Q?mzrU4Cf7JSQyfQ4Hgk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa2c21d0-3a14-40ca-117b-08ded2033a7a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 15:14:04.2349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R4rme07nR0TAJArxZX3y3vCvDcbuqm4LKa0JmObVCEqSYAzyVTYefnItPmBS5Nza
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7618
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

--------------kqfaLqTpK01Pia5bduDDIgnB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026-06-24 10:27, James Zhu wrote:
> with different domain.
>
> Signed-off-by: James Zhu<James.Zhu@amd.com>
> Reviewed-by: Vladimir Indic<vladimir.indic@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       |  6 +++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 13 +++++++------
>   drivers/gpu/drm/amd/amdkfd/kfd_events.c          |  5 +++--
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c         | 10 +++++-----
>   4 files changed, 18 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 5b49fa50a47d..e40e71f35bb9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -336,9 +336,9 @@ int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
>   int amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv);
>   int amdgpu_amdkfd_gpuvm_sync_memory(
>   		struct amdgpu_device *adev, struct kgd_mem *mem, bool intr);
> -int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
> -					     void **kptr, uint64_t *size);
> -void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem *mem);
> +int amdgpu_amdkfd_gpuvm_map_bo_to_kernel(struct kgd_mem *mem,
> +					     void **kptr, uint64_t *size, uint32_t domain);
> +void amdgpu_amdkfd_gpuvm_unmap_bo_from_kernel(struct kgd_mem *mem);
>   
>   int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo, struct amdgpu_bo **bo_gart);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 5bb3e28441a5..ec0901aa923c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2271,11 +2271,12 @@ int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo, struct amdgpu_bo **bo
>   	return ret;
>   }
>   
> -/** amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel() - Map a GTT BO for kernel CPU access
> +/** amdgpu_amdkfd_gpuvm_map_bo_to_kernel() - Map a GTT BO for kernel CPU access
Map a GTT or VRAM BO for kernel CPU access
>    *
>    * @mem: Buffer object to be mapped for CPU access
>    * @kptr[out]: pointer in kernel CPU address space
>    * @size[out]: size of the buffer
> + * @domain[IN]: domain of the buffer
>    *
>    * Pins the BO and maps it for kernel CPU access. The eviction fence is removed
>    * from the BO, since pinned BOs cannot be evicted. The bo must remain on the
> @@ -2284,8 +2285,8 @@ int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo, struct amdgpu_bo **bo
>    *
>    * Return: 0 on success, error code on failure
>    */
> -int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
> -					     void **kptr, uint64_t *size)
> +int amdgpu_amdkfd_gpuvm_map_bo_to_kernel(struct kgd_mem *mem,
> +					     void **kptr, uint64_t *size, uint32_t domain)
>   {
>   	int ret;
>   	struct amdgpu_bo *bo = mem->bo;
> @@ -2303,7 +2304,7 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
>   		goto bo_reserve_failed;
>   	}
>   
> -	ret = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
> +	ret = amdgpu_bo_pin(bo, domain);
>   	if (ret) {
>   		pr_err("Failed to pin bo. ret %d\n", ret);
>   		goto pin_failed;
> @@ -2336,7 +2337,7 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
>   	return ret;
>   }
>   
> -/** amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel() - Unmap a GTT BO for kernel CPU access
> +/** amdgpu_amdkfd_gpuvm_map_bo_to_kernel() - Unmap a GTT BO for kernel CPU access
>    *
>    * @mem: Buffer object to be unmapped for CPU access
>    *
> @@ -2344,7 +2345,7 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
>    * eviction fence, so this function should only be used for cleanup before the
>    * BO is destroyed.
>    */
> -void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem *mem)
> +void amdgpu_amdkfd_gpuvm_unmap_bo_from_kernel(struct kgd_mem *mem)
>   {
>   	struct amdgpu_bo *bo = mem->bo;
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index 3ffe9a52f3e1..d6fa5d71f581 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -314,7 +314,8 @@ int kfd_kmap_event_page(struct kfd_process *p, uint64_t event_page_offset)
>   		return -EINVAL;
>   	}
>   
> -	err = amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(mem, &kern_addr, &size);
> +	err = amdgpu_amdkfd_gpuvm_map_bo_to_kernel(mem, &kern_addr, &size,
> +						AMDGPU_GEM_DOMAIN_GTT);
>   	if (err) {
>   		pr_err("Failed to map event page to kernel\n");
>   		return err;
> @@ -323,7 +324,7 @@ int kfd_kmap_event_page(struct kfd_process *p, uint64_t event_page_offset)
>   	err = kfd_event_page_set(p, kern_addr, size, event_page_offset);
>   	if (err) {
>   		pr_err("Failed to set event page\n");
> -		amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(mem);
> +		amdgpu_amdkfd_gpuvm_unmap_bo_from_kernel(mem);
>   		return err;
>   	}
>   	return err;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 71b36a4613fa..21a90fc3adff 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -736,7 +736,7 @@ static void kfd_process_free_gpuvm(struct kgd_mem *mem,
>   	struct kfd_node *dev = pdd->dev;
>   
>   	if (kptr && *kptr) {
> -		amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(mem);
> +		amdgpu_amdkfd_gpuvm_unmap_bo_from_kernel(mem);
>   		*kptr = NULL;
>   	}
>   
> @@ -776,10 +776,10 @@ static int kfd_process_alloc_gpuvm(struct kfd_process_device *pdd,
>   	}
>   
>   	if (kptr) {
> -		err = amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(
> -				(struct kgd_mem *)*mem, kptr, NULL);
> +		err = amdgpu_amdkfd_gpuvm_map_bo_to_kernel(
> +				(struct kgd_mem *)*mem, kptr, NULL, domain);
>   		if (err) {
> -			pr_debug("Map GTT BO to kernel failed\n");
> +			pr_debug("Map BO to kernel failed\n");
print out err code

pr_debug("Map BO to kernel failed err %d\n", err);

With those fixed, this is Reviewed-by: Philip Yang <philip.yang@amd.com


>   			goto sync_memory_failed;
>   		}
>   	}
> @@ -1140,7 +1140,7 @@ static void kfd_process_kunmap_signal_bo(struct kfd_process *p)
>   	if (!mem)
>   		goto out;
>   
> -	amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(mem);
> +	amdgpu_amdkfd_gpuvm_unmap_bo_from_kernel(mem);
>   
>   out:
>   	mutex_unlock(&p->mutex);

--------------kqfaLqTpK01Pia5bduDDIgnB
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-06-24 10:27, James Zhu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260624142727.1946258-1-James.Zhu@amd.com">
      <pre wrap="" class="moz-quote-pre">with different domain.

Signed-off-by: James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>
Reviewed-by: Vladimir Indic <a class="moz-txt-link-rfc2396E" href="mailto:vladimir.indic@amd.com">&lt;vladimir.indic@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       |  6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 13 +++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_events.c          |  5 +++--
 drivers/gpu/drm/amd/amdkfd/kfd_process.c         | 10 +++++-----
 4 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 5b49fa50a47d..e40e71f35bb9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -336,9 +336,9 @@ int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
 int amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv);
 int amdgpu_amdkfd_gpuvm_sync_memory(
 		struct amdgpu_device *adev, struct kgd_mem *mem, bool intr);
-int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
-					     void **kptr, uint64_t *size);
-void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem *mem);
+int amdgpu_amdkfd_gpuvm_map_bo_to_kernel(struct kgd_mem *mem,
+					     void **kptr, uint64_t *size, uint32_t domain);
+void amdgpu_amdkfd_gpuvm_unmap_bo_from_kernel(struct kgd_mem *mem);
 
 int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo, struct amdgpu_bo **bo_gart);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 5bb3e28441a5..ec0901aa923c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2271,11 +2271,12 @@ int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo, struct amdgpu_bo **bo
 	return ret;
 }
 
-/** amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel() - Map a GTT BO for kernel CPU access
+/** amdgpu_amdkfd_gpuvm_map_bo_to_kernel() - Map a GTT BO for kernel CPU access</pre>
    </blockquote>
    Map a GTT or VRAM BO for kernel CPU access
    <blockquote type="cite" cite="mid:20260624142727.1946258-1-James.Zhu@amd.com">
      <pre wrap="" class="moz-quote-pre">
  *
  * @mem: Buffer object to be mapped for CPU access
  * @kptr[out]: pointer in kernel CPU address space
  * @size[out]: size of the buffer
+ * @domain[IN]: domain of the buffer
  *
  * Pins the BO and maps it for kernel CPU access. The eviction fence is removed
  * from the BO, since pinned BOs cannot be evicted. The bo must remain on the
@@ -2284,8 +2285,8 @@ int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo, struct amdgpu_bo **bo
  *
  * Return: 0 on success, error code on failure
  */
-int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
-					     void **kptr, uint64_t *size)
+int amdgpu_amdkfd_gpuvm_map_bo_to_kernel(struct kgd_mem *mem,
+					     void **kptr, uint64_t *size, uint32_t domain)
 {
 	int ret;
 	struct amdgpu_bo *bo = mem-&gt;bo;
@@ -2303,7 +2304,7 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
 		goto bo_reserve_failed;
 	}
 
-	ret = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
+	ret = amdgpu_bo_pin(bo, domain);
 	if (ret) {
 		pr_err(&quot;Failed to pin bo. ret %d\n&quot;, ret);
 		goto pin_failed;
@@ -2336,7 +2337,7 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
 	return ret;
 }
 
-/** amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel() - Unmap a GTT BO for kernel CPU access
+/** amdgpu_amdkfd_gpuvm_map_bo_to_kernel() - Unmap a GTT BO for kernel CPU access
  *
  * @mem: Buffer object to be unmapped for CPU access
  *
@@ -2344,7 +2345,7 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
  * eviction fence, so this function should only be used for cleanup before the
  * BO is destroyed.
  */
-void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem *mem)
+void amdgpu_amdkfd_gpuvm_unmap_bo_from_kernel(struct kgd_mem *mem)
 {
 	struct amdgpu_bo *bo = mem-&gt;bo;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 3ffe9a52f3e1..d6fa5d71f581 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -314,7 +314,8 @@ int kfd_kmap_event_page(struct kfd_process *p, uint64_t event_page_offset)
 		return -EINVAL;
 	}
 
-	err = amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(mem, &amp;kern_addr, &amp;size);
+	err = amdgpu_amdkfd_gpuvm_map_bo_to_kernel(mem, &amp;kern_addr, &amp;size,
+						AMDGPU_GEM_DOMAIN_GTT);
 	if (err) {
 		pr_err(&quot;Failed to map event page to kernel\n&quot;);
 		return err;
@@ -323,7 +324,7 @@ int kfd_kmap_event_page(struct kfd_process *p, uint64_t event_page_offset)
 	err = kfd_event_page_set(p, kern_addr, size, event_page_offset);
 	if (err) {
 		pr_err(&quot;Failed to set event page\n&quot;);
-		amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(mem);
+		amdgpu_amdkfd_gpuvm_unmap_bo_from_kernel(mem);
 		return err;
 	}
 	return err;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 71b36a4613fa..21a90fc3adff 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -736,7 +736,7 @@ static void kfd_process_free_gpuvm(struct kgd_mem *mem,
 	struct kfd_node *dev = pdd-&gt;dev;
 
 	if (kptr &amp;&amp; *kptr) {
-		amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(mem);
+		amdgpu_amdkfd_gpuvm_unmap_bo_from_kernel(mem);
 		*kptr = NULL;
 	}
 
@@ -776,10 +776,10 @@ static int kfd_process_alloc_gpuvm(struct kfd_process_device *pdd,
 	}
 
 	if (kptr) {
-		err = amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(
-				(struct kgd_mem *)*mem, kptr, NULL);
+		err = amdgpu_amdkfd_gpuvm_map_bo_to_kernel(
+				(struct kgd_mem *)*mem, kptr, NULL, domain);
 		if (err) {
-			pr_debug(&quot;Map GTT BO to kernel failed\n&quot;);
+			pr_debug(&quot;Map BO to kernel failed\n&quot;);</pre>
    </blockquote>
    print out err code<br>
    <pre wrap="" class="moz-quote-pre">pr_debug(&quot;Map BO to kernel failed err %d\n&quot;, err);

With those fixed, this is Reviewed-by: Philip Yang &lt;<a class="moz-txt-link-abbreviated" href="mailto:philip.yang@amd.com">philip.yang@amd.com</a></pre>
    <br>
    <blockquote type="cite" cite="mid:20260624142727.1946258-1-James.Zhu@amd.com">
      <pre wrap="" class="moz-quote-pre">
 			goto sync_memory_failed;
 		}
 	}
@@ -1140,7 +1140,7 @@ static void kfd_process_kunmap_signal_bo(struct kfd_process *p)
 	if (!mem)
 		goto out;
 
-	amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(mem);
+	amdgpu_amdkfd_gpuvm_unmap_bo_from_kernel(mem);
 
 out:
 	mutex_unlock(&amp;p-&gt;mutex);
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------kqfaLqTpK01Pia5bduDDIgnB--
