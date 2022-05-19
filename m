Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE039C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 19 May 2022 23:09:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73D1610E43E;
	Thu, 19 May 2022 23:09:43 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA17C10E43E
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 May 2022 23:09:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lnod+/YkioOFVDCKxTwmKRIC3F0B7cwIyleZvtZDbYDlahXmLsqOPF3Qjk2XvsonlBP+D/aQbgDUZ7peoNsXVsdYdz9SV2Fvy2xDd8OX5vqWTztESC4MIYFrsAr0oxLZX2StpwaMBTZp5gGhOSDrycJEIoMoS5JgiXTW6aXykIiCKbzsf5cAlfgPB7ZKbpmOi+yJrDNnaTLcz7Uslq5tJ5QytIhqqol01PiSinifQxBAFGha9ykdv02K/ogTkXJxBAXjK1HkDv3Z3IF5a4r8KH6nkcjdAyH+D2k5TRk53W4yRgW/e9b7DDI761oAnDPHCnN6RcOzlR2Rk7VDc4t3yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQRR79dEyrXBnX+d2k+14L1brcjoKWSyN7+oM8oCNrE=;
 b=Jj9JPD4a/hRyfjIoTX8ack4uv/fjU1yg1v6Eb2rlM01sltTCUAeWLqX+gEAJiOUjAscf8x4qgGdXhiuuGg9dMDnkc5nvg8mpblGv0dURc+Asty9SNEeHvS9A/LibZW85uL5MYnxObVo2iyJAOwX1bv05AV2+NBYNCQfxhkYSyh8IRCOjMi5XtFyRIdDRG+QZo4I18PuRzr/2o9GGKEmzgDVr4JqMfUei1cJESsXW+wOOHrBGrTxR532UnJd6ODqnA6i7fPeV9amqy8R+kHztJO8Fwiz1msoflblPc+yx7BhWmNjZbMnyJJNNQaeLS05TgcbFtOf94ga6OOBU2Yfrpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQRR79dEyrXBnX+d2k+14L1brcjoKWSyN7+oM8oCNrE=;
 b=jGidZ/D+8oTg3HzeBQKChYjtcAIAIwabcUu7YxlIuTWD/obzIUNO42gsuTLy7sfPndq3TCSaLPRe8wL9zTo5vidVyy6qTGTiQJVjhIVS1tcaa/LAMxIl1ahra2q1t0ZL7J26qqe89HbOlbiC1Wd57v2FrU8SlODCWii8TjeSMRQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BY5PR12MB4965.namprd12.prod.outlook.com (2603:10b6:a03:1c4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Thu, 19 May
 2022 23:09:37 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5273.017; Thu, 19 May 2022
 23:09:37 +0000
Message-ID: <b82f7486-9e14-c060-73c1-37c5b8837c2a@amd.com>
Date: Thu, 19 May 2022 19:09:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] drm/amdgpu: remove acc_size from reserve/unreserve mem
Content-Language: en-US
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220519162153.6268-1-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220519162153.6268-1-alex.sierra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::24) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f82cbf50-8f7a-46d8-1ec2-08da39eca4f9
X-MS-TrafficTypeDiagnostic: BY5PR12MB4965:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB496503459629C7A87CD6F07092D09@BY5PR12MB4965.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hG4KZk9w5CaQjSP/iywVXP6G6/QyFoN7Tawaep5+os1O26w00cCpw7AbVITQJuRWTJD9FeucIrOFsV+8qcA9QDsrF2aNv8ztJNgSp4Gds2VJU0xUEIrFnyqqkerjHyFIsS6I+8H3mMGf8WCyhuI0vOc/HUjay23vuUYlA/k2aUZjHQYLDFlLkgZITW+foor3RM2JlH6Ap24CsiH/VhxGZIkD2KsfUtrgaMCpVWcLtQt44ogAGf62RIRqhTDjb4tYyVdoUrfRawygFpGj4AT4bia3n6zLoN5Fz6EnftYBVSK0Moj1YiwWvMN9EWvyXFux/IXYjIjiqhGxd5qgov5Cbb6u/LSPFU2fL+ncfgqM1/w91Pv/zhVOF/DYOfnowglVD0AzPo1fLiMXh3aqQXP2njU/NNbUQAU+M+cCJ92eP+RCLjB4hbZYP+rvo6Rp8l3yNFxT0K45+abjf+Fa+Q+hL4UXJb4LtClwIk6u41S4lMIkaHveHHMcSz9SR6UeT/bYeZYXdFnkQnunjkIolyCab9n/dZ3uEmBDCsJbXsrcj5ZUSdISpCymgNHLr+jQw6wZighU+D3IXFYk4IPhDvB/CK/pYPhMmpAbNXyoxtWKDGsJzp+4vWQQZGWDieCSIznaZ0zBGCWLyaBu396t4NG+lpQCDSp/rPVY9mxcmQa4UR1hChz6sY+EBCtcaLpVCth1fkC0fhF5qbD47PrawIFPiOVnFszM/OYZeRyBauUb3yNgNGpSutJhSB6/IRXR0hQG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(508600001)(5660300002)(31696002)(66476007)(86362001)(44832011)(2906002)(38100700002)(66556008)(66946007)(6506007)(2616005)(8676002)(83380400001)(186003)(316002)(8936002)(6512007)(26005)(4326008)(31686004)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFlRenREdzNNOFQzcXppMG1kbGpPa0hsdWNObzBCeDFJTDJHSHRvM0ZqRHJu?=
 =?utf-8?B?TVd0VitQc242eUtXTkxYL21TT2NoSzJtV1Z3RkdiZFczT2YwUHBKL0wvM2Zj?=
 =?utf-8?B?eGpWeTZJN00rRytuR0dZN0FpOEtaRENZVEhVdjRxZDhDdkRrRHNCMGMwcXFQ?=
 =?utf-8?B?Q1RxbU5DWkJMNVJkZ3hRd1pRTFR4TEtXM2ZBQ3Ixb3IwS09ZeWNLT0o0dmhu?=
 =?utf-8?B?cUQzSlBmdHBiRE9IcmkzZGdTTTZYQ1FSZUVTakR3WWZGZ2ZRNm1aVElSU3Jp?=
 =?utf-8?B?SHQzVjhpaUpUQ3FxWjVpQlZPM2NFZ21tVlgrMmJlYmI4VWQwK3owdWYxNUNP?=
 =?utf-8?B?dTZWUmxTblJQdXdTSS9kbGQxSHo4MDNmYWRkSy9iWHYrZVdDbnVTUTNrRjhU?=
 =?utf-8?B?OWtJWHQrZjFUejVJaHErNXBQbE1iY2JuTFZkdUZQOEI3TlhHL3dCTFlyQXJl?=
 =?utf-8?B?MTA5N0RUZnpvK2lpRWRUTVJ5dEtEL3JBSm5sSjJRV2RlK1lKZ2lDOXZOc2RO?=
 =?utf-8?B?ODRrbDZIV2NCZ3A2bGNobm0vUzE0TFY1RFRab0tUenp3MmU4MHh3cU41ZlE2?=
 =?utf-8?B?cUVtL2RONkZBSHluUEMrb3hPeVY4RVl5aUdPMHNHTVdOcmFRdDJzK3VKNWlr?=
 =?utf-8?B?SWxhRDdGTWQrSHg4RjV1V3RzQytSV1JuTlh4RFh6d3IwU3VPYSt1V1U4RmtM?=
 =?utf-8?B?VmUrWnlUclNoQTM2RmdZV2UwbC9ydmwrTnE2a0JOdjJPUjRVZFE3Q0o0RDVo?=
 =?utf-8?B?Vnc4dGhSaTZKdEV6SUk3L2VPQkJaZHFzdEQ0VmN2VEFTRmU3ZWlQWE13cnB2?=
 =?utf-8?B?RVp2VUMxdmNlVVA4V0w3NVB2Q0xJbW0wa2NzQm1QU0ovL2lGK3JUS01BWCtr?=
 =?utf-8?B?QnorcnRTZDFSL1A2eGdoVzJFM0dneG5RbHkwbUcwMnZXNThPS2tJV0dnN0lq?=
 =?utf-8?B?MXIzeUNHSHZBQ3FiQmZ3VXFoY2VZTUVOZW5jUWJ4aVAzYjhvTG5VeDhRQWxl?=
 =?utf-8?B?YlI2aW9ZZ1lIaHpqMTFCd2ZrQ2h5cGJZVnJ2UUc3TVV3NkQwT0srVFpLeXFC?=
 =?utf-8?B?cTJ1a05PZHJjeEp2S29zRFFxS2I5ZzB4L2o3dzc5TmlqeDNTY0MwVDZRbWxo?=
 =?utf-8?B?UmMwaTdYVUFPZkI1K1lUMmFEdnJ6MGRER3Bna2hkSXYvcGg2VjVwWE8rSlVq?=
 =?utf-8?B?NmFTYU5mMkJTZkd0UmpRbUFEZFgyRUN3L2RyNXhidWlxMzNEQ2FxYXFqVmRC?=
 =?utf-8?B?alk2MkVSbHdiRHBzZ2FWamlOSWZ6VmRQT0Vpa0tTekxqdjNDOEtSRGFINy91?=
 =?utf-8?B?cjFEb1JQRVlWK1pkcG92WWF2dnlEUTlxRHhFSnR6UFpJSklaUVBtWWRqQ0JR?=
 =?utf-8?B?aGpmVHVxTTZhTjJsTHN2MTFCcDNrUnVvM3ZGL081cUtwcHNKTDlhWVhMUTVR?=
 =?utf-8?B?YlhMS2J3VVYxTkRJRWdqWFZFVncvU1d6TS96SWR5SkxGT2RLRXJ1Q1dBbUk5?=
 =?utf-8?B?VUMzUk5DQkNMUWoyL28xR01CSS9oM3paU2RwRUlWbzdwbXQ0b3g2N3d5M0lC?=
 =?utf-8?B?QVJLc3FPVEpzREpXQnJnU3hRb1A3clkrZFdZSVFPZVlpbmM2dTNEUjlLTFpO?=
 =?utf-8?B?SU41aVE1QXhYSEJBaUV3T1l2T2d4UmNuTWZHODA1UklkRVJYcDl3WTB4YWZY?=
 =?utf-8?B?ejBBMS9kbUdGbWFNanJYLzFpL2xsaks4cEJoN21rYWs1Q1RWVi85K1UwSnc4?=
 =?utf-8?B?SmZjWnRTZjA4ZllEZjhpcndSUHh0b3JMOHdTL1ZGMENvaEdQYmVvZW1lbmR3?=
 =?utf-8?B?enRTbWtmaElicDZvTkFQSFhOSTBkVEFaQnllSk9IUkZPZndyK1RKOXdpbW1k?=
 =?utf-8?B?N1A2R1JjVTNEZnJ6RXoyTGo2UzNYTzVPYzQ5YnMxaUMvQ2NhTlIwYndicVpH?=
 =?utf-8?B?NmdoOG1SNE9PTUFCMU9zRkhVcXVMRkZBMG9GdVR5dW1MMlgzYVVOcnErUS9k?=
 =?utf-8?B?c2xYNUFqM09sNm5sQUlNT01ZMTRiNjlZUzN1NDFZaVBHVUV3SXBrQ0w4dXgw?=
 =?utf-8?B?SXZKSkpucXRHNXQxMzk2K2UxOHUyM1pFQ1JnL3BEYlQ2YWVJQnJtL0ZDWlRt?=
 =?utf-8?B?WjdRZzV5SmVwK05TaDdsU2kxTi95eXhUek9DKzg1QmVwT2J3aXNkOUlSaFdX?=
 =?utf-8?B?SUNRa0pscUxyUTJxQ3Z5TjFQTWZNN2YwOTJueFFSY2VzMThoblk1dHNKTDFC?=
 =?utf-8?B?c2xIQlJJbGNWRUN6Qnh4MXJhOEJlUEJUWmRrT0pmTVRidHlMRWZUT0dJNXVr?=
 =?utf-8?B?aVFZVDFITFlxTHUxOFdoUmsxektna2QxWlp1clFlVnMzM3VTOHdUZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f82cbf50-8f7a-46d8-1ec2-08da39eca4f9
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 23:09:37.0763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UjPP9crk7Y3MTZR6xh4xce22f+izkkthnf31pBLWCDTH8SGYVRt4uTgmJcTCKMAoAkmUsw9Mb194JUwJXrj16g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4965
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
Cc: Philip Yang <philip.yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2022-05-19 um 12:21 schrieb Alex Sierra:
> TTM used to track the "acc_size" of all BOs internally. We needed to
> keep track of it in our memory reservation to avoid TTM running out
> of memory in its own accounting. However, that "acc_size" accounting
> has since been removed from TTM. Therefore we don't really need to
> track it any more.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> Reviewed-by: Philip Yang <philip.yang@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 59 ++++++-------------
>   1 file changed, 17 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index fada3b149361..966714dd764b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -108,21 +108,12 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
>    * compromise that should work in most cases without reserving too
>    * much memory for page tables unnecessarily (factor 16K, >> 14).
>    */
> -#define ESTIMATE_PT_SIZE(mem_size) ((mem_size) >> 14)
> -
> -static size_t amdgpu_amdkfd_acc_size(uint64_t size)
> -{
> -	size >>= PAGE_SHIFT;
> -	size *= sizeof(dma_addr_t) + sizeof(void *);
>   
> -	return __roundup_pow_of_two(sizeof(struct amdgpu_bo)) +
> -		__roundup_pow_of_two(sizeof(struct ttm_tt)) +
> -		PAGE_ALIGN(size);
> -}
> +#define ESTIMATE_PT_SIZE(mem_size) ((mem_size) >> 14)

This is weird, ESTIMATE_PT_SIZE looks unchanged, but the diff is 
removing and adding it anyway.

Anyway, the patch is
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>   
>   /**
>    * amdgpu_amdkfd_reserve_mem_limit() - Decrease available memory by size
> - * of buffer including any reserved for control structures
> + * of buffer.
>    *
>    * @adev: Device to which allocated BO belongs to
>    * @size: Size of buffer, in bytes, encapsulated by B0. This should be
> @@ -136,28 +127,22 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>   {
>   	uint64_t reserved_for_pt =
>   		ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
> -	size_t acc_size, system_mem_needed, ttm_mem_needed, vram_needed;
> +	size_t system_mem_needed, ttm_mem_needed, vram_needed;
>   	int ret = 0;
>   
> -	acc_size = amdgpu_amdkfd_acc_size(size);
> -
> +	system_mem_needed = 0;
> +	ttm_mem_needed = 0;
>   	vram_needed = 0;
>   	if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_GTT) {
> -		system_mem_needed = acc_size + size;
> -		ttm_mem_needed = acc_size + size;
> +		system_mem_needed = size;
> +		ttm_mem_needed = size;
>   	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
> -		system_mem_needed = acc_size;
> -		ttm_mem_needed = acc_size;
>   		vram_needed = size;
>   	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
> -		system_mem_needed = acc_size + size;
> -		ttm_mem_needed = acc_size;
> -	} else if (alloc_flag &
> -		   (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
> -		    KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
> -		system_mem_needed = acc_size;
> -		ttm_mem_needed = acc_size;
> -	} else {
> +		system_mem_needed = size;
> +	} else if (!(alloc_flag &
> +				(KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
> +				 KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))) {
>   		pr_err("%s: Invalid BO type %#x\n", __func__, alloc_flag);
>   		return -ENOMEM;
>   	}
> @@ -193,28 +178,18 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>   static void unreserve_mem_limit(struct amdgpu_device *adev,
>   		uint64_t size, u32 alloc_flag)
>   {
> -	size_t acc_size;
> -
> -	acc_size = amdgpu_amdkfd_acc_size(size);
> -
>   	spin_lock(&kfd_mem_limit.mem_limit_lock);
>   
>   	if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_GTT) {
> -		kfd_mem_limit.system_mem_used -= (acc_size + size);
> -		kfd_mem_limit.ttm_mem_used -= (acc_size + size);
> +		kfd_mem_limit.system_mem_used -= size;
> +		kfd_mem_limit.ttm_mem_used -= size;
>   	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
> -		kfd_mem_limit.system_mem_used -= acc_size;
> -		kfd_mem_limit.ttm_mem_used -= acc_size;
>   		adev->kfd.vram_used -= size;
>   	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
> -		kfd_mem_limit.system_mem_used -= (acc_size + size);
> -		kfd_mem_limit.ttm_mem_used -= acc_size;
> -	} else if (alloc_flag &
> -		   (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
> -		    KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
> -		kfd_mem_limit.system_mem_used -= acc_size;
> -		kfd_mem_limit.ttm_mem_used -= acc_size;
> -	} else {
> +		kfd_mem_limit.system_mem_used -= size;
> +	} else if (!(alloc_flag &
> +				(KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
> +				 KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))) {
>   		pr_err("%s: Invalid BO type %#x\n", __func__, alloc_flag);
>   		goto release;
>   	}
