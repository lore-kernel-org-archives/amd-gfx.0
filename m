Return-Path: <SRS0=Mvn9=CB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C914C433E1
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Aug 2020 15:28:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E96B20706
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Aug 2020 15:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="M/beSRNs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E96B20706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDEA96E50D;
	Sun, 23 Aug 2020 15:28:51 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEB656E50D
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Aug 2020 15:28:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAQee08xgCzPKG03onbeF3A+q5poQCVdmCHNflpsvWKZUYIfI+I06Bzk2IVG7UDzvEUROI0OS4yxuu1/PTKidoF76aWZnjODjYlHMlIJflU3JTlwQR24o5Z6Mn4FAjXjUd1bcvKt0yHBTf2Xr8WOcih8eqntFBuzdFqpGfjFE0nmU3opFOhdnybwoNJAb8uxQRVUnglm5aRNBR0mrXFNmSblqZ2RFm1MQzyar+4eCzzHxs9iiDnPImVdzym96SETiUKRwLcDTmMFeQm1GmUwgCuMwVaIibu4zuVP+62ZFFjXGOvNFKRBPaY/IMfJFClqVQx+SKBm5ZscAgOMsUuprA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcgUQFEwggOKKuD8+e2FZi2m0NZ7+p+MybbbRfrV6Ts=;
 b=APKnGy8BKFA2Zld9HRWAdcLv4EAWbg8EhmFfI/TlmpCPLR8Y3hurF3IpitVAr+OtSAzPKcs8q0RGOldRESXuy9TA5GgEKE8kgVJXvYrYZ++kLCnci8ympnvvyE+bhhnmOH9zL1elGHqpdcg+MP+ONzDAkZcBHjSolCs5wd2hK7h2aLAfPPu/H/pAUq3eI3uWL7CKH0uklzJCMeGqDnWY0ZwGwRIqKN/fny9SWlRecKTADcDI490etNda+enJfM6SH8yyV0dwIdR8xs14cxF8JxhinpIVaw3uHNWEub91f5peddv6iravqO8pnKfbb3/U8PJGDfiWtIa+nzFbPnb4ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcgUQFEwggOKKuD8+e2FZi2m0NZ7+p+MybbbRfrV6Ts=;
 b=M/beSRNsjIW/fnvVC+HMM8/KK2HfdNkeuT2S9zpCDQQPfzAA42hlww5wgrvC9uTaa6o/3C+PaqAgK/9HUZhXykG3ommWHFxb4WFPWheKmsmfcaqnIkifni4SP45bMGRkdr4dEJHiMUnLuSePyyECsiZTv2DJublSgil616T231I=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (52.132.199.31) by
 SA0PR12MB4573.namprd12.prod.outlook.com (20.181.63.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.25; Sun, 23 Aug 2020 15:28:46 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9%7]) with mapi id 15.20.3305.026; Sun, 23 Aug 2020
 15:28:46 +0000
Subject: Re: [PATCH v6] drm/amdkfd: implement the dGPU fallback path for apu
 (v6)
To: Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200823120728.387671-1-ray.huang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <a1ed0b23-c117-b37b-1d59-00127e1a71ff@amd.com>
Date: Sun, 23 Aug 2020 11:28:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200823120728.387671-1-ray.huang@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::14) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 YTXPR0101CA0037.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Sun, 23 Aug 2020 15:28:45 +0000
X-Originating-IP: [142.116.113.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 340e63ec-d206-45bc-bddd-08d847793982
X-MS-TrafficTypeDiagnostic: SA0PR12MB4573:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4573C475EF8EDB0F4B148A3792590@SA0PR12MB4573.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J5sN4o9tXDRZGaLtdbPOKUe3K0PhT3tqW+9V9kj8mo6Wd593Q7ujNMux35zJys927vii2F7fQZR786kmh5fpwEXutdqc4tPybBAVp4BT/gkRzklZ3up6J9tVMFP246wUsQq5gVq3SDvagEYpbspMFno6IeBLRSKtvjDrqvFsTU3D0A8UT3ksOB6Y4oFd/1U0xO3sYim0GpKScGbk8mKv1rbUCT1RknQpPrx2YqBpmqRtEM5JcYTX9FHMw0pfAdJ/+8613QrlldhfneZ7JTTZs6/1gFbv81QwyQVHJTt/2Fw0MZDKXVvj2ut/FfZGeDcau7hqy8rLl8G/xEV9lRM05J+UT7W3EVuZSAqmJtdxLnLcBHxS4or75wtJT4IfAaWE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(186003)(26005)(36756003)(30864003)(52116002)(66556008)(44832011)(2906002)(31686004)(66476007)(5660300002)(956004)(66946007)(2616005)(6486002)(83380400001)(86362001)(8936002)(16576012)(8676002)(31696002)(316002)(478600001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: p1946KtpP5rzntAqOZITyURCdZFCp4Srd0DbgQmFh5XSgE5vqD4/vCTvdFGG0CfPAXC+0Cd1QrgYztYwU8bptiyo2HyZJ6/CUXuoXYeGykqau0OeuXU30zHzMCekzwqggUfZSpLqMFwHKR/5VNgh9Q8r6MDE4zQp7un+RzmKs1i9rfBx/6Lr2oWJ8QZevXxQCtp45XgLqkjiu0GQOlPxKM2MM28pHNXmuloPuDXk6iPXuTIkGva26KYnQ5eXxFqYuk93cvuc2KxyaCg+47HSwW6htB1sAlyEk9e4vnmSMjq0I3W1rV/6zvq7fsFaN1398+Qi1NVmU0cN3mKM0IrziTBMzILesRcjyg0DUfUMczude4lDtmleqo3CKwN7mB+GtB4gHG8b/y1p05eE6hlW8ZNlJmJcr9RoyVIxxgct40DYwg4rvJ7xFvc7O+7ciicsDzN5erQ3Fzl9lsoLP6kvoVRdLxstc9l3PwytpZ5v7xSqlM7p9+DOt7Pc+6fN82yBLgEakrfWcJt5TPTm/iq5HGB9q33kJzeg5qG1tJrrLLox7I/Zp+ph5LOyEAX2a0FpLZjeX9pmdUZkHz/WyUEDlvrYY5hviKmnced8746IqgCAZH+2bjRRH8xTy3CPWrtwJbGZscp5b0yNnagM9hn/vw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 340e63ec-d206-45bc-bddd-08d847793982
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2020 15:28:46.1765 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IMTpSRfm0AXFBwfUg5VGNug4GVXwNkS/QCx59CZOdfORQ+TV7mRdEq0ClSQrO3AfLYh+ZBHGnD0ou6MelKwG1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4573
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2020-08-23 um 8:07 a.m. schrieb Huang Rui:
> We still have a few iommu issues which need to address, so force raven
> as "dgpu" path for the moment.
>
> This is to add the fallback path to bypass IOMMU if IOMMU v2 is disabled
> or ACPI CRAT table not correct.
>
> v2: Use ignore_crat parameter to decide whether it will go with IOMMUv2.
> v3: Align with existed thunk, don't change the way of raven, only renoir
>     will use "dgpu" path by default.
> v4: don't update global ignore_crat in the driver, and revise fallback
>     function if CRAT is broken.
> v5: refine acpi crat good but no iommu support case, and rename the
>     title.
> v6: fix the issue of dGPU initialized firstly, just modify the report
>     value in the node_show().
>
> Signed-off-by: Huang Rui <ray.huang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  5 ++-
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c         | 22 +++++++++++--
>  drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c       |  4 +--
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  5 ++-
>  .../amd/amdkfd/kfd_device_queue_manager_v9.c  |  2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c  |  4 +--
>  drivers/gpu/drm/amd/amdkfd/kfd_iommu.c        | 10 +++---
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  5 ++-
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c     | 31 ++++++++++++++++---
>  10 files changed, 70 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index a9a4319c24ae..189f9d7e190d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -684,11 +684,14 @@ MODULE_PARM_DESC(debug_largebar,
>   * Ignore CRAT table during KFD initialization. By default, KFD uses the ACPI CRAT
>   * table to get information about AMD APUs. This option can serve as a workaround on
>   * systems with a broken CRAT table.
> + *
> + * Default is auto (according to asic type, iommu_v2, and crat table, to decide
> + * whehter use CRAT)
>   */
>  int ignore_crat;
>  module_param(ignore_crat, int, 0444);
>  MODULE_PARM_DESC(ignore_crat,
> -	"Ignore CRAT table during KFD initialization (0 = use CRAT (default), 1 = ignore CRAT)");
> +	"Ignore CRAT table during KFD initialization (0 = auto (default), 1 = ignore CRAT)");
>  
>  /**
>   * DOC: halt_if_hws_hang (int)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 1b60e0ed6b5c..3ec5322ba88d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1258,7 +1258,7 @@ bool kfd_dev_is_large_bar(struct kfd_dev *dev)
>  		return true;
>  	}
>  
> -	if (dev->device_info->needs_iommu_device)
> +	if (dev->use_iommu_v2)
>  		return false;
>  
>  	amdgpu_amdkfd_get_local_mem_info(dev->kgd, &mem_info);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 59557e3e206a..aba40df189d9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -740,6 +740,25 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
>  	return 0;
>  }
>  
> +
> +#ifdef CONFIG_ACPI
> +
> +static bool kfd_ignore_crat(void)
> +{
> +	bool ret;
> +
> +	if (ignore_crat)
> +		return true;
> +
> +#ifndef KFD_SUPPORT_IOMMU_V2
> +	ret = true;
> +#else
> +	ret = false;
> +#endif
> +
> +	return ret;
> +}
> +
>  /*
>   * kfd_create_crat_image_acpi - Allocates memory for CRAT image and
>   * copies CRAT from ACPI (if available).
> @@ -751,7 +770,6 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
>   *
>   *	Return 0 if successful else return error code
>   */
> -#ifdef CONFIG_ACPI
>  int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
>  {
>  	struct acpi_table_header *crat_table;
> @@ -775,7 +793,7 @@ int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
>  		return -EINVAL;
>  	}
>  
> -	if (ignore_crat) {
> +	if (kfd_ignore_crat()) {
>  		pr_info("CRAT table disabled by module option\n");
>  		return -ENODATA;
>  	}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c b/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
> index 3e5904f8876a..e4159b5f83d5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
> @@ -309,7 +309,7 @@ static int dbgdev_address_watch_nodiq(struct kfd_dbgdev *dbgdev,
>  	for (i = 0; i < adw_info->num_watch_points; i++) {
>  		dbgdev_address_watch_set_registers(adw_info, &addrHi, &addrLo,
>  				&cntl, i, pdd->qpd.vmid,
> -				dbgdev->dev->device_info->needs_iommu_device);
> +				dbgdev->dev->use_iommu_v2);
>  
>  		pr_debug("\t\t%30s\n", "* * * * * * * * * * * * * * * * * *");
>  		pr_debug("\t\t%20s %08x\n", "register index :", i);
> @@ -399,7 +399,7 @@ static int dbgdev_address_watch_diq(struct kfd_dbgdev *dbgdev,
>  	for (i = 0; i < adw_info->num_watch_points; i++) {
>  		dbgdev_address_watch_set_registers(adw_info, &addrHi, &addrLo,
>  				&cntl, i, vmid,
> -				dbgdev->dev->device_info->needs_iommu_device);
> +				dbgdev->dev->use_iommu_v2);
>  
>  		pr_debug("\t\t%30s\n", "* * * * * * * * * * * * * * * * * *");
>  		pr_debug("\t\t%20s %08x\n", "register index :", i);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 2c030c2b5b8d..fdf64d361be3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -112,6 +112,7 @@ static const struct kfd_device_info carrizo_device_info = {
>  	.num_xgmi_sdma_engines = 0,
>  	.num_sdma_queues_per_engine = 2,
>  };
> +#endif
>  
>  static const struct kfd_device_info raven_device_info = {
>  	.asic_family = CHIP_RAVEN,
> @@ -130,7 +131,6 @@ static const struct kfd_device_info raven_device_info = {
>  	.num_xgmi_sdma_engines = 0,
>  	.num_sdma_queues_per_engine = 2,
>  };
> -#endif
>  
>  static const struct kfd_device_info hawaii_device_info = {
>  	.asic_family = CHIP_HAWAII,
> @@ -688,6 +688,9 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>  		goto gws_error;
>  	}
>  
> +	/* If CRAT is broken, won't set iommu enabled */
> +	kfd_double_confirm_iommu_support(kfd);
> +
>  	if (kfd_iommu_device_init(kfd)) {
>  		dev_err(kfd_device, "Error initializing iommuv2\n");
>  		goto device_iommu_error;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
> index 95a82ac455f2..309f63a0b34a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
> @@ -62,7 +62,7 @@ static int update_qpd_v9(struct device_queue_manager *dqm,
>  				SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
>  					SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
>  		if (amdgpu_noretry &&
> -		    !dqm->dev->device_info->needs_iommu_device)
> +		    !dqm->dev->use_iommu_v2)
>  			qpd->sh_mem_config |=
>  				1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> index 78714f9a8b11..798303c3c7ac 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> @@ -321,7 +321,7 @@ static void kfd_init_apertures_vi(struct kfd_process_device *pdd, uint8_t id)
>  	pdd->lds_base = MAKE_LDS_APP_BASE_VI();
>  	pdd->lds_limit = MAKE_LDS_APP_LIMIT(pdd->lds_base);
>  
> -	if (!pdd->dev->device_info->needs_iommu_device) {
> +	if (!pdd->dev->use_iommu_v2) {
>  		/* dGPUs: SVM aperture starting at 0
>  		 * with small reserved space for kernel.
>  		 * Set them to CANONICAL addresses.
> @@ -423,7 +423,7 @@ int kfd_init_apertures(struct kfd_process *process)
>  				return -EINVAL;
>  			}
>  
> -			if (!dev->device_info->needs_iommu_device) {
> +			if (!dev->use_iommu_v2) {
>  				/* dGPUs: the reserved space for kernel
>  				 * before SVM
>  				 */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
> index 4d3b4188b9a1..0c0269497e51 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
> @@ -41,7 +41,7 @@ int kfd_iommu_check_device(struct kfd_dev *kfd)
>  	struct amd_iommu_device_info iommu_info;
>  	int err;
>  
> -	if (!kfd->device_info->needs_iommu_device)
> +	if (!kfd->use_iommu_v2)
>  		return -ENODEV;
>  
>  	iommu_info.flags = 0;
> @@ -63,7 +63,7 @@ int kfd_iommu_device_init(struct kfd_dev *kfd)
>  	unsigned int pasid_limit;
>  	int err;
>  
> -	if (!kfd->device_info->needs_iommu_device)
> +	if (!kfd->use_iommu_v2)
>  		return 0;
>  
>  	iommu_info.flags = 0;
> @@ -109,7 +109,7 @@ int kfd_iommu_bind_process_to_device(struct kfd_process_device *pdd)
>  	struct kfd_process *p = pdd->process;
>  	int err;
>  
> -	if (!dev->device_info->needs_iommu_device || pdd->bound == PDD_BOUND)
> +	if (!dev->use_iommu_v2 || pdd->bound == PDD_BOUND)
>  		return 0;
>  
>  	if (unlikely(pdd->bound == PDD_BOUND_SUSPENDED)) {
> @@ -284,7 +284,7 @@ static void kfd_unbind_processes_from_device(struct kfd_dev *kfd)
>   */
>  void kfd_iommu_suspend(struct kfd_dev *kfd)
>  {
> -	if (!kfd->device_info->needs_iommu_device)
> +	if (!kfd->use_iommu_v2)
>  		return;
>  
>  	kfd_unbind_processes_from_device(kfd);
> @@ -304,7 +304,7 @@ int kfd_iommu_resume(struct kfd_dev *kfd)
>  	unsigned int pasid_limit;
>  	int err;
>  
> -	if (!kfd->device_info->needs_iommu_device)
> +	if (!kfd->use_iommu_v2)
>  		return 0;
>  
>  	pasid_limit = kfd_get_pasid_limit();
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 60243798cce2..641b964387ec 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -308,12 +308,14 @@ struct kfd_dev {
>  
>  	/* xGMI */
>  	uint64_t hive_id;
> -    
>  	/* UUID */
>  	uint64_t unique_id;
>  
>  	bool pci_atomic_requested;
>  
> +	/* Use IOMMU v2 flag */
> +	bool use_iommu_v2;
> +
>  	/* SRAM ECC flag */
>  	atomic_t sram_ecc_flag;
>  
> @@ -1009,6 +1011,7 @@ struct kfd_dev *kfd_device_by_pci_dev(const struct pci_dev *pdev);
>  struct kfd_dev *kfd_device_by_kgd(const struct kgd_dev *kgd);
>  int kfd_topology_enum_kfd_devices(uint8_t idx, struct kfd_dev **kdev);
>  int kfd_numa_node_to_apic_id(int numa_node_id);
> +void kfd_double_confirm_iommu_support(struct kfd_dev *gpu);
>  
>  /* Interrupts */
>  int kfd_interrupt_init(struct kfd_dev *dev);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index cbb8535abf0c..cf1cd7ec0457 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -466,7 +466,7 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
>  	sysfs_show_32bit_prop(buffer, "cpu_cores_count",
>  			dev->node_props.cpu_cores_count);
>  	sysfs_show_32bit_prop(buffer, "simd_count",
> -			dev->node_props.simd_count);
> +			dev->gpu ? dev->node_props.simd_count : 0);
>  	sysfs_show_32bit_prop(buffer, "mem_banks_count",
>  			dev->node_props.mem_banks_count);
>  	sysfs_show_32bit_prop(buffer, "caches_count",
> @@ -545,7 +545,7 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
>  		 * If the ASIC is APU except Kaveri, set local memory size
>  		 * to 0 to disable local memory support
>  		 */
> -		if (!dev->gpu->device_info->needs_iommu_device
> +		if (!dev->gpu->use_iommu_v2
>  			|| dev->gpu->device_info->asic_family == CHIP_KAVERI) {
>  			amdgpu_amdkfd_get_local_mem_info(dev->gpu->kgd,
>  				&local_mem_info);
> @@ -1197,7 +1197,7 @@ static struct kfd_topology_device *kfd_assign_gpu(struct kfd_dev *gpu)
>  		/* Discrete GPUs need their own topology device list
>  		 * entries. Don't assign them to CPU/APU nodes.
>  		 */
> -		if (!gpu->device_info->needs_iommu_device &&
> +		if (!gpu->use_iommu_v2 &&
>  		    dev->node_props.cpu_cores_count)
>  			continue;
>  
> @@ -1452,7 +1452,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>  	* Overwrite ATS capability according to needs_iommu_device to fix
>  	* potential missing corresponding bit in CRAT of BIOS.
>  	*/
> -	if (dev->gpu->device_info->needs_iommu_device)
> +	if (dev->gpu->use_iommu_v2)
>  		dev->node_props.capability |= HSA_CAP_ATS_PRESENT;
>  	else
>  		dev->node_props.capability &= ~HSA_CAP_ATS_PRESENT;
> @@ -1579,6 +1579,29 @@ int kfd_numa_node_to_apic_id(int numa_node_id)
>  	return kfd_cpumask_to_apic_id(cpumask_of_node(numa_node_id));
>  }
>  
> +void kfd_double_confirm_iommu_support(struct kfd_dev *gpu)
> +{
> +	struct kfd_topology_device *dev;
> +
> +	gpu->use_iommu_v2 = false;
> +
> +	if (!gpu->device_info->needs_iommu_device)
> +		return;
> +
> +	down_read(&topology_lock);
> +
> +	/* Only use IOMMUv2 if there is an APU topology node with no GPU
> +	 * assigned yet. This GPU will be assigned to it.
> +	 */
> +	list_for_each_entry(dev, &topology_device_list, list)
> +		if (dev->node_props.cpu_cores_count &&
> +		    dev->node_props.simd_count &&
> +		    !dev->gpu)
> +			gpu->use_iommu_v2 = true;
> +
> +	up_read(&topology_lock);
> +}
> +
>  #if defined(CONFIG_DEBUG_FS)
>  
>  int kfd_debugfs_hqds_by_device(struct seq_file *m, void *data)
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
