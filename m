Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7315CDE002
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 15:01:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5483710EF78;
	Wed, 24 Jun 2026 15:01:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dhPAaGou";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012004.outbound.protection.outlook.com [52.101.53.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E619110EF78
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 15:01:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nl3A0ciQix6qfAk7kSUv9zUZkczlai5Xifre/BPyxmWiL1LmZuYa2x9I1uemR+nd5RWyszwU1V3Ram3ZDdHYW/4eNAL/w0PPRAMj+7GEfnRNtY2y7TyT4ESxdbxk/m4QnW7snZcP1UhSUiDaTxpfk1enX0ShXbPaUopIVKaa3MsZy+vXtlffnItOGJZoj4xsGBTaTi8H1ysetlqD7lEHvOlKnshPTS9505cbd9CxgXHglqZ6IIgem+fACKtKM/l5D2oP8Owf0Lyxkk71kjVq1wguM0DB7+68jawwsci2I343S/kkJRlutoMo44iQeu1c3q+xijsGCDJ7RN0psf4Riw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzeRj/6BVSvEqxSWmfBrT96OdiHzP5wbyOl2pJrFyAU=;
 b=sLj0iEIZB4RkQT+kke1v8/u2GCVyEC9LIzaABoJLNOcEFQnOuIIR4eEbkEElTXpVmgrShrylvJBp+vryZOZfN3bvcHYaxEnXQey8juEYSsbaq60uOZw5PlBmUTzIKzCuien+GsNvy1Kj3T8TgnqjmW0G7jezBl7PRkpVSJCog3to6QB5BSM9xTrzjQOB1olvmECOv3V6uVy/C6/OAUoBF0UBrhKQlRllHawDKMqSq0UGBnFNDhSWdyBVHRDVExm3CnjW+VBBwQmxuV/2b9DAsunQ8TABjEURVi0kexOWvqqHPC9rRuux/L1XOq6MQU12RQ6iogt40HHiHageZ1EkQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzeRj/6BVSvEqxSWmfBrT96OdiHzP5wbyOl2pJrFyAU=;
 b=dhPAaGou4CMnlHwGbstKvs5EuAQhOUdCEw38D2XA51sklomWFgbGjyE7rL6m/5OCht6est+As5N16PQXjSpD01Af2kdU0/UX1BJtaDpLMCYTeO5dybIQNmRQXVTy04dJKPyB7ZUaMBxxr2O9EN5OCVyaOT/r1Hk81ljyqMmgo58=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by MW4PR12MB7285.namprd12.prod.outlook.com (2603:10b6:303:22e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Wed, 24 Jun
 2026 15:00:48 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::8218:248d:58ec:8c81]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::8218:248d:58ec:8c81%6]) with mapi id 15.21.0159.014; Wed, 24 Jun 2026
 15:00:48 +0000
Content-Type: multipart/alternative;
 boundary="------------xajgAF50bCEfDJXLNqeAxgbE"
Message-ID: <d8ddd8b5-bddb-408b-89cd-e9409650eea5@amd.com>
Date: Wed, 24 Jun 2026 11:00:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amdgpu: move DGPU TBA/TMA from system to
 device memory
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: philip.yang@amd.com, Hawking.Zhang@amd.com, Bob.Zhou@amd.com,
 Harish.Kasiviswanathan@amd.com, jamesz@amd.com,
 Vladimir Indic <vladimir.indic@amd.com>
References: <20260624142727.1946258-1-James.Zhu@amd.com>
 <20260624142727.1946258-2-James.Zhu@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20260624142727.1946258-2-James.Zhu@amd.com>
X-ClientProxiedBy: YT4PR01CA0041.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::18) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|MW4PR12MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: 085e0709-c811-44fa-59a9-08ded2015fcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|4143699003|8096899003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: CSbTcbyHjFstDU69KGYAxrkE8psQT6iVI9jkbMTXXyA4iKjkR36Y4ybz2z4H8NjjS8RPTCYM0AN9viZR7Yb78F38Gm2EjEMO6oiVA4u9uAligd4Dheyo/Y3VZR85kPsX9mgt0xxH1AxVaqLcQL1bA5blh/wnU3XerZMT5nlYYoetbolxAjMf+Rqj2icnXOy+WL3Nzjfyy+mX19CcgmMd86i1Jx0pTa+IW9sO5nbbWpasRVwakGAZkNaEeTyi5G2YRRKrmA442O6H8p7oxFiCrB++HOldeXa86oIdVT2w3WvfPAOTfa+guoxzeqK/qhodLiLfrF2wEf+TRgOMJoSWdI4SfcLBTc4moXUHmm6PRN59z5faqQj4cBU7O0BEil2Rq8URiSPqC03QOSfSXcX+0IfWJvOC8A7Ofe/IBIbUGlFjW2pnKzjDrX4pi9rj5Fll5q/iqA+vNwWU9NNQgCNBBScAwraxMN4XbxubhpvoWNlFzbKfllCVG7dUzZuxXHQOMv9QGaTHQ7fcgYipDf4Pk0HBag8xdp3fHgOK78qcO7rK4UGSMnzKMZ+haVQc72izdi+ndoMLBPOQRfQUysqrbYJiYokSEsWiWYGa2/ZEmLTVPN10I1oPbt7ROkK02X1eqX3dhAvM3zXat+J/nnM9lfR6eXTVvu/jzrAQQ7tFv3o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(4143699003)(8096899003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3VUcTlacWJ5MjgzYU9WdmlCZTVyUXhHcS9oUFVUTmxIV2ZJMlVTVHhEVllO?=
 =?utf-8?B?ZjBCYXJqNnFNWXNaZ3BTNUhQbUxnMmgvOVlOcjVjd09QQlVUaU1GaHhOY3Vl?=
 =?utf-8?B?NmhuRmo4TllKekNBQWRnVU1pSTlMWFQ5MlM0MzB4bytLT3luZVFNOW1aR0ls?=
 =?utf-8?B?N2NNNFdPRnMvR1lma0dBUG11VCtFTVA1by9acDZJSzBzeGNjdnV6T0dIWGcv?=
 =?utf-8?B?b3VPZUlnd0wzeTRsdEFJejd5SDFRczd3S1I4clVaZmFtR3N6WDhOMURRVmNk?=
 =?utf-8?B?WlBla2hSUlh1Nm5RWWE2L0lyNnBxcndjUi9KZlU0dUtzTUlTQnpoeHJ0UjRz?=
 =?utf-8?B?aXoxUnZkMTVwSGU0dTdnYXlmV3Q2MnFaL1QwN3Z1bGJaOUpZTnN2VlFsQ082?=
 =?utf-8?B?TStTMEltQ1ZScERzc3dodU1UdlE5bGJobG5NTzQraFROMG1rNjlLc3c0czdC?=
 =?utf-8?B?VWhjQ2p5dTNjcWtVb05tbC9ZN3cvRU5TVm5wOHA4NnhRYk1uWUJ3LzFXb3RV?=
 =?utf-8?B?b0VGOFUza2toTk43Y0dkQzNaZzdJaTExeEprNUZaN3FUdm5xeXpNNC9FdmZN?=
 =?utf-8?B?R3hjTHdYTDRnblMxaUZCSVlhL0RJemlpNnYvWEZBSDFYNzVybVYyWDJ5Z0tw?=
 =?utf-8?B?aHdMUFJmTFV3TWhTTk9KTnIranRuNnFpcjdDMWQ0MlA3eFI0WFRVZlh1eDI4?=
 =?utf-8?B?TmFLUGloK0tXU0FveEpZcHRyQk9QTERxNVRXbkM2TXU4NkxrRnRhZWtnUTZE?=
 =?utf-8?B?YXF1R3R0K3J5RTIrWGF5Y0oyZ0FJcndTamJYMTdXQTNyYVJWaGtoODBmUXhw?=
 =?utf-8?B?NUN6eWhkbG1ZOWdkWHk4OW4wWUltU1VQMW92c2xKbTBWNDJ1a0tlR2h0Zzk5?=
 =?utf-8?B?SVVaQUpTMVQvOC82a01McmVWSzB1SDI1VHhxN2xtSExMR3RBK3dJVWtnVUxy?=
 =?utf-8?B?Y2hkVVJXTVNmcGEzN1gzMVZack8rSzBkcENnQ2YwUXRnY2hzRzhqdHBqVnpy?=
 =?utf-8?B?QlBXUXdLeWVJSEZQdEQrMWZybUhQdkFObS8yRGhKUExpaTYvenFqTGNlenBV?=
 =?utf-8?B?Ynh2enVEWVpHZmh0NGdwUGEwc2lqcll6eGFUYisvRk5tWXY4WGFSTFoyczJz?=
 =?utf-8?B?ZkNVb1dJVjh4OGdCOEhCM09tVjlBQ05RZG9rdUsrbDdYOGMzazBLeTRNT2lp?=
 =?utf-8?B?QVh3SlBVNFZzd0QyLzdCemVsaVMyYS9tVUNZbjFkZmRVcG85K1JTckppQUta?=
 =?utf-8?B?dmZaN2F3UlNGa1lhMGhucFE3d2dsakd5K3hKTWhzUzB3K2srYWJJZTZsS05U?=
 =?utf-8?B?SjRtcTBNQmJCYVluVHFzTm93SEl6aHF4WTg0WkU3UEU1Zm5mVDd1NHMwOXRC?=
 =?utf-8?B?cE1lajFOODZqbW1hRUdzWDEvZ2oweG9ueDIyQzEyL3pMYlRib2lQQ0FOcnFx?=
 =?utf-8?B?NXlNaDNpemxxc1BpNXE0RXlLMCsxUWx5WFk3K041Q0c5SGpTMzRVdG9OTlBW?=
 =?utf-8?B?emgwTVJGUnBES3N5R0VQNFVYN3NKZ0ZvbG5KenhZUzlOcENaQVNkWkFOWFdV?=
 =?utf-8?B?YVRZSmVzdjJVVUhlNmxuaTJ0bFc3dW9GZlMvQ0QrMlF0a0NnSlhhdlEzTi9u?=
 =?utf-8?B?b2xRRmlZS0V4NFovUGRBSnMzM29VS2ZmOVVGdkRCK09ZNlFWTnREMWRXSHVJ?=
 =?utf-8?B?QUoxOEVoR1lnbjd3ay95SmZ6M0pNdzljZGF0MlNkSGh0eHlyZ0hpZ2gvSnRn?=
 =?utf-8?B?elZiNy83Y0Q1L1VIZmxRd0pvUGNxYWN0eEZlWktQbERCM2prN3hUU3NySDZX?=
 =?utf-8?B?Q1RBbUhnc3JPdlp4TE5xd2htUFBtMDJrZDFtQXo4N3BzNlpsaGVNMXZpMFpj?=
 =?utf-8?B?Z0lRYnRqTXJyNHFiZm9pRjFtbzBuWDluMnJVYTRGc0VKMmRKTTN3L0tHemhk?=
 =?utf-8?B?Q1lrcW5la1lxWTU4VHNKYUdYU3VTYy81V1Z3Q1VaSmsxenp2Z1I0Q3RvMFJC?=
 =?utf-8?B?QUdBbHlVVzBrQmV0eHdwb0p6dGVOZmhyY3AvVVQ0R1pRV2RxcFdseVdxdjB6?=
 =?utf-8?B?QjRtd2xULzhuODdMTkpOMGp6NG5iQm14Tk1FNU9KZU4wY09rWXMrWnk0UmV6?=
 =?utf-8?B?Vmo4KzhHK3c1RWNoSmZoejJ1R3JUWGlPcnh3ZDBzdktYN1RJV1ArUlNWb1d2?=
 =?utf-8?B?ZlByRGZXVTdicUliYUZKOWFJOFo0bG81WmpDS3ptcVo0N2Fsc01oZmV4ampi?=
 =?utf-8?B?cm1Wczc1K3hlQzQ1VmRPSDB6ZkpwNE9VUVN4cTQxc2VkWmhIeDFZaTI5NElF?=
 =?utf-8?Q?24ZfUOtMlCISkTv/8K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 085e0709-c811-44fa-59a9-08ded2015fcf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 15:00:48.1022 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NOJRyJahi6Te8v4bowX3ZPHxDRhJqwvPfvkMsVggM8LM/s/J/D3BuuShdv+g3jfl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7285
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

--------------xajgAF50bCEfDJXLNqeAxgbE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026-06-24 10:27, James Zhu wrote:
> for GFX9.4.2 and above.
>
> -v2: keep APU with GTT allocation
>
> Signed-off-by: James Zhu<James.Zhu@amd.com>
> Reviewed-by: Vladimir Indic<vladimir.indic@amd.com>
> Reviewed-by: Harish Kasiviswanathan<Harish.Kasiviswanathan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 21a90fc3adff..a69e278f7aee 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -776,6 +776,12 @@ static int kfd_process_alloc_gpuvm(struct kfd_process_device *pdd,
>   	}
>   
>   	if (kptr) {
> +		uint32_t domain;
> +
> +		if (flags & KFD_IOC_ALLOC_MEM_FLAGS_GTT)
> +			domain = AMDGPU_GEM_DOMAIN_GTT;
> +		else
> +			domain = AMDGPU_GEM_DOMAIN_VRAM;
>   		err = amdgpu_amdkfd_gpuvm_map_bo_to_kernel(
>   				(struct kgd_mem *)*mem, kptr, NULL, domain);
>   		if (err) {
> @@ -1489,8 +1495,7 @@ static int kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
>   {
>   	struct kfd_node *dev = pdd->dev;
>   	struct qcm_process_device *qpd = &pdd->qpd;
> -	uint32_t flags = KFD_IOC_ALLOC_MEM_FLAGS_GTT
> -			| KFD_IOC_ALLOC_MEM_FLAGS_NO_SUBSTITUTE
> +	uint32_t flags = KFD_IOC_ALLOC_MEM_FLAGS_NO_SUBSTITUTE
>   			| KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE;
>   	struct kgd_mem *mem;
>   	void *kaddr;
> @@ -1499,7 +1504,13 @@ static int kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
>   	if (!dev->kfd->cwsr_enabled || qpd->cwsr_kaddr || !qpd->cwsr_base)
>   		return 0;
>   
> -	/* cwsr_base is only set for dGPU */
> +	if (KFD_GC_VERSION(dev) >= IP_VERSION(9, 4, 2) &&
> +	    !(dev->adev->flags & AMD_IS_APU))
use !adev->apu_prefer_gtt

With this fixed, this patch is Reviewed-by: Philip Yang 
<philip.yang@amd.com>
> +		flags |= KFD_IOC_ALLOC_MEM_FLAGS_VRAM;
> +	else
> +		flags |= KFD_IOC_ALLOC_MEM_FLAGS_GTT;
> +
> +	/* Allocate CWSR TBA/TMA buffers */
>   	ret = kfd_process_alloc_gpuvm(pdd, qpd->cwsr_base,
>   				      KFD_CWSR_TBA_TMA_SIZE, flags, &mem, &kaddr);
>   	if (ret)

--------------xajgAF50bCEfDJXLNqeAxgbE
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
    <blockquote type="cite" cite="mid:20260624142727.1946258-2-James.Zhu@amd.com">
      <pre wrap="" class="moz-quote-pre">for GFX9.4.2 and above.

-v2: keep APU with GTT allocation

Signed-off-by: James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>
Reviewed-by: Vladimir Indic <a class="moz-txt-link-rfc2396E" href="mailto:vladimir.indic@amd.com">&lt;vladimir.indic@amd.com&gt;</a>
Reviewed-by: Harish Kasiviswanathan <a class="moz-txt-link-rfc2396E" href="mailto:Harish.Kasiviswanathan@amd.com">&lt;Harish.Kasiviswanathan@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 21a90fc3adff..a69e278f7aee 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -776,6 +776,12 @@ static int kfd_process_alloc_gpuvm(struct kfd_process_device *pdd,
 	}
 
 	if (kptr) {
+		uint32_t domain;
+
+		if (flags &amp; KFD_IOC_ALLOC_MEM_FLAGS_GTT)
+			domain = AMDGPU_GEM_DOMAIN_GTT;
+		else
+			domain = AMDGPU_GEM_DOMAIN_VRAM;
 		err = amdgpu_amdkfd_gpuvm_map_bo_to_kernel(
 				(struct kgd_mem *)*mem, kptr, NULL, domain);
 		if (err) {
@@ -1489,8 +1495,7 @@ static int kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
 {
 	struct kfd_node *dev = pdd-&gt;dev;
 	struct qcm_process_device *qpd = &amp;pdd-&gt;qpd;
-	uint32_t flags = KFD_IOC_ALLOC_MEM_FLAGS_GTT
-			| KFD_IOC_ALLOC_MEM_FLAGS_NO_SUBSTITUTE
+	uint32_t flags = KFD_IOC_ALLOC_MEM_FLAGS_NO_SUBSTITUTE
 			| KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE;
 	struct kgd_mem *mem;
 	void *kaddr;
@@ -1499,7 +1504,13 @@ static int kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
 	if (!dev-&gt;kfd-&gt;cwsr_enabled || qpd-&gt;cwsr_kaddr || !qpd-&gt;cwsr_base)
 		return 0;
 
-	/* cwsr_base is only set for dGPU */
+	if (KFD_GC_VERSION(dev) &gt;= IP_VERSION(9, 4, 2) &amp;&amp;
+	    !(dev-&gt;adev-&gt;flags &amp; AMD_IS_APU))</pre>
    </blockquote>
    use !adev-&gt;apu_prefer_gtt<br>
    <br>
    With this fixed, this patch is Reviewed-by: Philip Yang
    <a class="moz-txt-link-rfc2396E" href="mailto:philip.yang@amd.com">&lt;philip.yang@amd.com&gt;</a>
    <blockquote type="cite" cite="mid:20260624142727.1946258-2-James.Zhu@amd.com">
      <pre wrap="" class="moz-quote-pre">
+		flags |= KFD_IOC_ALLOC_MEM_FLAGS_VRAM;
+	else
+		flags |= KFD_IOC_ALLOC_MEM_FLAGS_GTT;
+
+	/* Allocate CWSR TBA/TMA buffers */
 	ret = kfd_process_alloc_gpuvm(pdd, qpd-&gt;cwsr_base,
 				      KFD_CWSR_TBA_TMA_SIZE, flags, &amp;mem, &amp;kaddr);
 	if (ret)
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------xajgAF50bCEfDJXLNqeAxgbE--
