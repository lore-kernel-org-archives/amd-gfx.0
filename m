Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FCA6CD98CC
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 22:57:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0E3010E8C7;
	Thu, 11 Jun 2026 22:57:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3yliZU+n";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010010.outbound.protection.outlook.com [52.101.61.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 728B910E8C7
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 22:57:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUD0lXoXg2roZNewY8C3TwppB7Q6JNPSn3Cu/kdD/IyQyYM+/F0bfJx82CG6R7DGtmKGaYSDnmyPASf/RPLpwsf/e2j8meLsYDTNSzcSqyG92gUw+VA/DHQMy3/SvTodA/aBXRRyoEukqURGgSGuEImCAtjDjLaTKjjeBGaKPKRg2zwCfXAF2FbA+XUzC3iXmd41uCSCAU2TKNgKQH2/75hTidBI3JjF8gEMO1LVtH16xZfGExpTtrvuEamQcafP94beBQ7NRpEAGxFPL+D5auTpcPVJa6MbJMvGySFlzrkQEkhZJp/JbGHA/SIUvpWnfkxUDad3hZw14X7WIwwo+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAxahBla1EHbV1CHY0ADDwAg5lfJExCL0TQdj08NQE8=;
 b=Ytuorf8e58oM932vQityInLOfWBq6AsN3IGe1bX6R32Uputkb0ivzyA8H4WHpAVEiCkz5SQ8obCvXp9008gWfx38OVGBpI9JRYO+cefm0V5Isen/WDRckzXvzYkTdDxurEOD/bbmlqnxbpHbnQonq3mWQxmesqSTVAxG+Q1Og+oJmEosWHcZspMmZO+55f7bGbRSjJtzqzjau1iYHLBYE9jTR2GClfSmRq+OVbbMHi5EU+AzngHHPCK3AMK/lb5zpFbY62155N6k4vBfBKHTdE2x3EwEbu4GMMZs9vqD7A/Jqax4IWVaUvHZBB/JnKG3kg5lJKJsp5URm8FxQAEbIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAxahBla1EHbV1CHY0ADDwAg5lfJExCL0TQdj08NQE8=;
 b=3yliZU+nIly8A8yl11ji4/Pl46UjqS71XqEsxyyZjeGBYccClGwbeXyesJZfX6A+0LZqvDlKbPIaNIy5MF31koLWnLhZgkTgh/Ew/iXT/EvycUVJgiOSr+8VkBT6X8Uys6ZZ3hgAq3/mlAMfAJUQ8Zz3uEIYhRBzy5b+c8IUC3k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8)
 by BN5PR12MB9461.namprd12.prod.outlook.com (2603:10b6:408:2a8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 22:56:59 +0000
Received: from IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525]) by IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525%5]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 22:56:58 +0000
Message-ID: <bd4aaf16-e2e6-475c-af8e-a696c1bb67a5@amd.com>
Date: Thu, 11 Jun 2026 17:56:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdkfd: Let driver decide buffer size at
 AMDKFD_IOC_GET_DMABUF_INFO ioctl
To: amd-gfx@lists.freedesktop.org
References: <20260528184656.123149-1-xiaogang.chen@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20260528184656.123149-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:610:b0::22) To IA1PR12MB8517.namprd12.prod.outlook.com
 (2603:10b6:208:449::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8517:EE_|BN5PR12MB9461:EE_
X-MS-Office365-Filtering-Correlation-Id: fdfcd552-6df8-4155-c944-08dec80cbe0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: bC7rMSPbLnXBusX4VevJhzA2mg7LTh4sF9eYCnilJbFaL7payqYRcKkN99KM6+DwgEPo8vzH6PAYgF8sezQLVgF8xzEkZIk4QVVN3744pPB2C2Kv0BjfnN2+AmkTF1G8LRLatcBkg0Jg3FqW60ktMBq9cR2PTU31uqNTlPFpo8Ops335khmP4PIv3OoeFEYv92aKi6oB2T27ZG6NyKLq0PKljnlRF/T5BhJyWrEAbwNxFUMzIkUKIUk14oEC1cLAG44uc71B8CcumEfmwy9QAjVfUeqOxUqQR+UKg/o+qVROGupf6ATgv5XKT28RzQDPK6+eIs6qB7TteaEy+DKlBZRo3BKQ+E8cnqwywybmz2o4XxU2yL75jPayptAvA8PfM6mCh1+oGap6X23ficVEU5mldH1LJFYp2J57RP0zkfJv6lYsOCYVt6kQfGCIsNtgBGxAWX1qGVGxjz8t1gIagqzrIYt2dc+AFpjKFnhUbT+tXioKI7b2oJtuDEdzzoNS6SgaB32u4/5FoON1huVuAvq7NTGnvC7rA4b+wN0guXOPsrLYkXGVZXSEsql3EKiiTKXx0m8lAlMWjAhFHGzR8TeMADkzIArv7dMPMC28hKXUCFZFpH/e2M/GkJCLZTa8qp0Y5ndjb1LPuFx8KfCL//U2EIi3m85ot5o3TLGw1Bhvb5RaTLV5taCVB8iFpUlU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmEyZlNUODJXV25CZEZwem9BcFo1UG5ZNWduUHE1OHp6a0Fja0h2MExlNmJn?=
 =?utf-8?B?eWhmdmFUY015bDE4VDIva2FwRUlFU2RZTmdWSlEvTzMxMWNUNVV3bWc4cmtw?=
 =?utf-8?B?UkJCOHZGN0FpWmFpSi9QQWRZbFhVVTcvaFROaksrZVg2bjJiVHZEZkh1d3Bj?=
 =?utf-8?B?OWhzb0hCRGF4b0xudzFnUXZ6blp3djRIL1liNXNCMkh0cS90TzBuMVc4VzY3?=
 =?utf-8?B?amJTMEFyYVA2OHVKT0tSc2xUcHF4RDJEMGIrWXA1NVVtUkhOZmkwV1djaXE2?=
 =?utf-8?B?WTFwa1dSNTZSbG1tVDRhT1Q4Q29TWUxUT2s4dUJxKzZBMEhYREpYbE9TT1NS?=
 =?utf-8?B?OVd3TjVLZXlOamxmM2g2bWNNS2hBS2ZEM2EyWUZWQ2NWMmRHRGR0bktXZGxF?=
 =?utf-8?B?NDd6RlRwTkhmZEp1YmYzVmExdVB6WVpLRzlxeExLUFdBQ1hkRm5GamNZUEh0?=
 =?utf-8?B?Skp1Z1lrMnVIenA4dnM1eVZXNld1bmhaVFlSdnQ5RTBFbFpld3JDVC94SGEw?=
 =?utf-8?B?NnRvd2M5Q3BZZUEvUWFlSXJ2Y0dBQm94WTFwLzhVM3VGT3JoR1d5Z3RpL1M3?=
 =?utf-8?B?dU9aWWR3UjNTUmtZV0ZmcW5vdzJUSG9hQU9sQWNTNjN0bXVFK3IrRUdHZmwv?=
 =?utf-8?B?NnhwVDdzVnBIdlkzQjRuQ1dBeUJmeUZ4NmpwWFZkQk9qNkU1T1hrZXpTajAw?=
 =?utf-8?B?OUYxLzF1UFZrZmtxL3F2V0QzdVhYWkVDZnhJcXV4Q3NPa0t2di81K3NrWDdD?=
 =?utf-8?B?YUJvRlBaWHR4SzFZWUxoZ1UzRTFVVmxjeGM2MkN2cVJxdjVtVjdPN2tRVWFN?=
 =?utf-8?B?d09NQitwbFZaeXJyZnpYeE1LU3hRbWdReC9hUkc2YVNqaXJCaVhiU05paG9l?=
 =?utf-8?B?Qkp0V3h2M29OSURzZ3pOcG9SYldVNmVzVkI1WlhUUWlNWnVYMXQyYXBpdHRD?=
 =?utf-8?B?YVNiUTdremxmeGlGd1gyaXE3dkxBVmRwMG0xS2hVc3lXZ2w0NGFMaDYwQzBq?=
 =?utf-8?B?VFFMZWoxQzBlOStoU241UlEzK2hHZVc4bE5uQzJnc2pNQ0YzTnBpd014aWxG?=
 =?utf-8?B?WDFFRE1sSXJKL201MFowZko1SmxEV1NiYVBrS0I3SmFIMjBsZWxyVkdIMGRn?=
 =?utf-8?B?Y3E1Z1FoM3g3b0x4NXA0NDZBZ1JMRUpFTEFjN2krWHlSU1IxeHlmK0ZrRFBK?=
 =?utf-8?B?L1lKK3grZzB4Qjc3UThzbDhtNE1BM3pMYngySU00Q3k5V2VHU1lwbmIwaGtr?=
 =?utf-8?B?VHgxN3FXTXNCL3BhK0NUQkRTTS83R3AzUEZRZXZjV3ZLenZCTXdpQVBXcmFW?=
 =?utf-8?B?S2g5dGt5YWFmemdTZ3RlSi9LQlZvbUY0dSt6OVRNN2s1aXpUalRqcVNQbmoy?=
 =?utf-8?B?ZkZhMlNab3VzcWJqWlk5b0o1dTRsVW1ldng3d2E4UkdvUE5ob1RtQmFVcFZE?=
 =?utf-8?B?UVo4L0VkMENzY3pzcEt3N1NEd3ovbndydFBOdHVQVHlGSUUzVEIvVS9nSk40?=
 =?utf-8?B?dDhwU0ZVc2NuUWM2bmJtVnlWYlBJMzBVL1ovRFk1V2dxQkJUZFZYNkhCRmp3?=
 =?utf-8?B?MWpXM3Axa2hJOUZmSDJGS3BVNE9SdTArNUlkYjRSbGI1VTh1bGtKbGU3MkMx?=
 =?utf-8?B?Z2ViNUN0MXVmMmduU3I0MmhKcEZqNzJ2aitmRFRlSVN2bzRUSDNVZ2xpWjh4?=
 =?utf-8?B?ZjlPMFNheDBiN2RJZytiVHBaVGFQZnplM0o3RVUralloV29McndNa21DWXBH?=
 =?utf-8?B?QnpRand2bTVHN0c5dXVtZGtkRitEMHc3L3ppa0hZLzB3UDhtRUVkMXhIRXUv?=
 =?utf-8?B?V3dhd200Z0Q1N0ErTk9LSXZGNkNiUjRvMTY3U3hmUTdwb0Y5LzgwTzFRbWFG?=
 =?utf-8?B?WW1LYjYxUjMzQmVuUENGTHpnR09LQVhKTFAxSGR2RUhIVjRtR1Jhb280am0r?=
 =?utf-8?B?SlZPcmlxSnp4TGtzdVlwTCtQWnIvNitxcUdqbW16UkREbXlqSlBNb3pKbGJS?=
 =?utf-8?B?Y0pvbENaMDZzbmFoNUhoZTJhRDBXWDRCajBYQ3BhcnVHZHduTnFoQmdIZnk3?=
 =?utf-8?B?RmZYL2p3am1EdmU5NThrbXZRZ3NrMU00VFBocUhjTGxNUWoyd3FYaTR5K0t4?=
 =?utf-8?B?M2tjTTlQczdBNWt4QzZackRrQUd5Q25DYkgreHZDMWw1Sk9hT1N6L2VTTTNM?=
 =?utf-8?B?TDVHaUpOZDBST3p6akU0YnNxNU84Z05HR3E5MTA1T1p0WU0rWndlZzU2MlA2?=
 =?utf-8?B?RlRvOGZFSnNHVE40aVdWL3lxeWhLVit1RVZkU2dGYWxOS3Z2RWg5bEVJemlO?=
 =?utf-8?Q?oCEysRDK09t3OHpjWa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdfcd552-6df8-4155-c944-08dec80cbe0d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 22:56:58.9400 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+jUvYsmVBivfjN4QMDnOCUWKY2mRUk1U+bhCPAMTplGJbeXnTRr4TjNKfkKskRX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9461
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


ping

On 5/28/2026 1:46 PM, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> amdkfd driver needs allocate buffer to return bo metadata to user space. The
> buffer size is controlled by user currently. It is a potential security issue
> that hostile value (e.g. 2 GiB) lets any render-group user trigger order-MAX
> allocation / OOM in kernel context.
>
> This patch first finds bo metadata size. If the size is smaller than user
> provided value drive can safely allocate buffer in kernel space and copy to
> user space buffer. If not, driver will let user know, not allocate and copy.
> User will redo with new buffer in user space.
>
> This patch lets driver decide buffer allocation size to avoid potential hostile
> size from user space.
>
> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 23 ++++++++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c   | 10 ++--------
>   3 files changed, 22 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 7b10bbe28caf..1b4d1a974143 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -533,7 +533,7 @@ uint32_t amdgpu_amdkfd_get_max_engine_clock_in_mhz(struct amdgpu_device *adev)
>   
>   int amdgpu_amdkfd_get_dmabuf_info(struct amdgpu_device *adev, int dma_buf_fd,
>   				  struct amdgpu_device **dmabuf_adev,
> -				  uint64_t *bo_size, void *metadata_buffer,
> +				  uint64_t *bo_size, void **metadata_buffer,
>   				  size_t buffer_size, uint32_t *metadata_size,
>   				  uint32_t *flags, int8_t *xcp_id)
>   {
> @@ -568,9 +568,24 @@ int amdgpu_amdkfd_get_dmabuf_info(struct amdgpu_device *adev, int dma_buf_fd,
>   		*dmabuf_adev = adev;
>   	if (bo_size)
>   		*bo_size = amdgpu_bo_size(bo);
> -	if (metadata_buffer)
> -		r = amdgpu_bo_get_metadata(bo, metadata_buffer, buffer_size,
> -					   metadata_size, &metadata_flags);
> +	if (metadata_buffer) {
> +		/* first get metadata_size by buffer = NULL */
> +		r = amdgpu_bo_get_metadata(bo, NULL, 0,
> +					   metadata_size, NULL);
> +
> +		/* user buf_size is bigger than bo metadata_size
> +		 * allocate a buf at kernel space and copy */
> +		if (*metadata_size <= buffer_size) {
> +			*metadata_buffer = kzalloc(*metadata_size, GFP_KERNEL);
> +
> +			if (!*metadata_buffer)
> +				return -ENOMEM;
> +
> +			r = amdgpu_bo_get_metadata(bo, *metadata_buffer, *metadata_size,
> +						   NULL, &metadata_flags);
> +		} else
> +			r = -EINVAL;
> +	}
>   	if (flags) {
>   		*flags = (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) ?
>   				KFD_IOC_ALLOC_MEM_FLAGS_VRAM
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 2bf6a31c194d..7b67367a9a53 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -262,7 +262,7 @@ uint64_t amdgpu_amdkfd_get_gpu_clock_counter(struct amdgpu_device *adev);
>   uint32_t amdgpu_amdkfd_get_max_engine_clock_in_mhz(struct amdgpu_device *adev);
>   int amdgpu_amdkfd_get_dmabuf_info(struct amdgpu_device *adev, int dma_buf_fd,
>   				  struct amdgpu_device **dmabuf_adev,
> -				  uint64_t *bo_size, void *metadata_buffer,
> +				  uint64_t *bo_size, void **metadata_buffer,
>   				  size_t buffer_size, uint32_t *metadata_size,
>   				  uint32_t *flags, int8_t *xcp_id);
>   int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct amdgpu_device *adev, bool is_min);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 881ea252b3ad..fc75d0009a57 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1545,16 +1545,10 @@ static int kfd_ioctl_get_dmabuf_info(struct file *filep,
>   	if (!dev)
>   		return -EINVAL;
>   
> -	if (args->metadata_ptr) {
> -		metadata_buffer = kzalloc(args->metadata_size, GFP_KERNEL);
> -		if (!metadata_buffer)
> -			return -ENOMEM;
> -	}
> -
>   	/* Get dmabuf info from KGD */
>   	r = amdgpu_amdkfd_get_dmabuf_info(dev->adev, args->dmabuf_fd,
>   					  &dmabuf_adev, &args->size,
> -					  metadata_buffer, args->metadata_size,
> +					  &metadata_buffer, args->metadata_size,
>   					  &args->metadata_size, &flags, &xcp_id);
>   	if (r)
>   		goto exit;
> @@ -1566,7 +1560,7 @@ static int kfd_ioctl_get_dmabuf_info(struct file *filep,
>   	args->flags = flags;
>   
>   	/* Copy metadata buffer to user mode */
> -	if (metadata_buffer) {
> +	if (metadata_buffer && args->metadata_ptr) {
>   		r = copy_to_user((void __user *)args->metadata_ptr,
>   				 metadata_buffer, args->metadata_size);
>   		if (r != 0)
