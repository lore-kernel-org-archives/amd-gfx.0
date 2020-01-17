Return-Path: <SRS0=QkQq=3G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23133C33CB3
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 21:46:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4B692072B
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 21:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="p82osXR/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4B692072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E2BF6F93A;
	Fri, 17 Jan 2020 21:46:53 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93E896F93A
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2020 21:46:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdY9kaG/llqwu18iMglVNdPXHz+Ol93Au1PvJGWwbAuMUY0t3enhHuaH3PJIQXE0pS26a2E27509JYcoScb3HlWHMLjaHux+cKKKxVMO7gOrT11kV6ZwyatJVQxHh27CwbyNDva6MC17sBAXQPYF9q3S1s22n1GuPGdf3h+DBNksfi6N2tQDqmuOD797xzNwe2Hm4wmcQ7IrlDTyoDs2yq0gsUcoQy/mgUdWT7CKU5HiFi71jqP8QEysGQxZChyspiSZX4Qk0FY/ABUKMvQUIUEHoHLlNQ3E4Swu2Kg8Cm7+MsVMbqvGnNDdqgziHzp0jK9A0Rn49gW+OvEnw9jKEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6WIjCdrPPHV8ri05V56hSIs9MuRkSynHBVYRkJ5Yjw=;
 b=KjUg4EOSRHXXQKnEI5fYI5MmBOjIwwQQGTzpM7pQIGI+1VsTTJdjawbCclotIgAW6HqYRBU199e9bdGoOAgLXVPlHK23RdJMzG/fgg5h2jFKN9AK6EO3YBwUPD7oRUYtptEg+IAxSHHj1gr9a/JRmDj6SaPGSoJ1W095xIb6ck5CUoCogf1/jwOdxEtywHkbmVOH+oNco+h6ATFYUxgOmMsUM78AFRZ6Y6UlP/iRTerkFWQIAE/RwX+TKq6PnZcgSSxgm8Y9rOVkcffFyl0vlWxUCIA+c1KbP9sx6y+T4p8O7ZcSNukx5cPTHdHXPnTijSZELgA6NvcrzPDU+IZGqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6WIjCdrPPHV8ri05V56hSIs9MuRkSynHBVYRkJ5Yjw=;
 b=p82osXR/RCFoUnViC95Xs57W6+tb7zj+lmP6MjErezjqaVmxa85YNe9cXx9FUi0yAS37yNco43iN4b1cfR9xEsXraZVyOCuh8HSNVKGPVkon3PHwdz/eRqdOOjmQF4J+yAAQ9eI0Ni1N2CocfTzME5i1gCl1Zg7AxjhY+ohr/6E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (10.174.105.140) by
 DM5PR1201MB0044.namprd12.prod.outlook.com (10.174.106.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Fri, 17 Jan 2020 21:46:50 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c%4]) with mapi id 15.20.2644.023; Fri, 17 Jan 2020
 21:46:50 +0000
Subject: Re: [PATCH v2] drm/amdkfd: Enable GWS based on FW Support
To: Joseph Greathouse <Joseph.Greathouse@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20200117212446.65002-1-Joseph.Greathouse@amd.com>
 <20200117213901.85592-1-Joseph.Greathouse@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <c1176a76-779c-8776-59fd-267ceea69f34@amd.com>
Date: Fri, 17 Jan 2020 16:46:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20200117213901.85592-1-Joseph.Greathouse@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0023.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::36) To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 YTXPR0101CA0023.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20 via Frontend Transport; Fri, 17 Jan 2020 21:46:50 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c6178b9a-bc01-4491-7568-08d79b96c24d
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0044:|DM5PR1201MB0044:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB00448EB6D74006675BE66E4692310@DM5PR1201MB0044.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0285201563
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(199004)(189003)(36756003)(2906002)(316002)(44832011)(81166006)(2616005)(8936002)(31686004)(86362001)(66476007)(8676002)(16576012)(31696002)(36916002)(81156014)(956004)(52116002)(16526019)(186003)(6486002)(53546011)(5660300002)(66556008)(66946007)(478600001)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0044;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KIzr22GWDIseIk5Mpg3Y3jVkxJk7afc/c0WU3AjluAHvTcbATaHSm3w7Sodt5KY1CJwKC5LTO8SvRMDy5HalRuWfBpy41UKrw71hYjcUgSxp7UnU1VDpHoHBOeV2baL0SKZeQxiAHhBYG2miucker3SYE15M2pEuyuxJSM2N4XdQIyqRvFINLQC6e7FEK3qJvcWsuGK2KsOfB/1Cmph9itsyWdy3meyDNJsO+SLySCPB6DJRGOalFl6lq2aAY4ieGdER4TKsNMg7642h2OOqDsb5V6MfZ+QAnSWH5C2u3D7bU5DqZ9nHh6/Zdi7Az1kL1W8wO2/wfCxeENSOVISGLnkmLjiGtxL/2Ad3vMlnZsAOBZlrGEHgZELDO11s8V6Qn6yKvs7rDr6S7LH4sEwD+cJ7dmrr+iSxfmHa/aaLdWwWWoVzksCSI2xQN2vzUwxG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6178b9a-bc01-4491-7568-08d79b96c24d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2020 21:46:50.6029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9QUHl6ofE987rl9vyNc3YLqzfiMOhmWc1RgIG655pBmHqiP71K+HUVEnPKtgVinkROCm/zxUm/hLTFYKjnVcgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0044
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-01-17 4:39 p.m., Joseph Greathouse wrote:
> Rather than only enabling GWS support based on the hws_gws_support
> modparm, also check whether the GPU's HWS firmware supports GWS.
> Leave the old modparm in place in case users want to test GWS
> on GPUs not yet in the support list.
>
> v2: fix broken syntax from the first patch.
>
> Change-Id: Ife6833c2d571f5e7fe0726f9340649ce0ef10443
> Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   |  7 ++--
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c  |  8 +++--
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c   | 40 ++++++++++++++++++-----
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |  1 +
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c |  2 +-
>   5 files changed, 41 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 137e76f0e3db..f28d040de3ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -688,13 +688,12 @@ MODULE_PARM_DESC(halt_if_hws_hang, "Halt if HWS hang is detected (0 = off (defau
>   
>   /**
>    * DOC: hws_gws_support(bool)
> - * Whether HWS support gws barriers. Default value: false (not supported)
> - * This will be replaced with a MEC firmware version check once firmware
> - * is ready
> + * Assume that HWS supports GWS barriers regardless of what firmware version
> + * check says. Default value: false (rely on MEC2 firmware version check).
>    */
>   bool hws_gws_support;
>   module_param(hws_gws_support, bool, 0444);
> -MODULE_PARM_DESC(hws_gws_support, "MEC FW support gws barriers (false = not supported (Default), true = supported)");
> +MODULE_PARM_DESC(hws_gws_support, "Assume MEC2 FW supports GWS barriers (false = rely on FW version check (Default), true = force supported)");
>   
>   /**
>     * DOC: queue_preemption_timeout_ms (int)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 1aebda4bbbe7..275f79ab0900 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1590,9 +1590,6 @@ static int kfd_ioctl_alloc_queue_gws(struct file *filep,
>   	struct queue *q;
>   	struct kfd_dev *dev;
>   
> -	if (!hws_gws_support)
> -		return -ENODEV;
> -
>   	mutex_lock(&p->mutex);
>   	q = pqm_get_user_queue(&p->pqm, args->queue_id);
>   
> @@ -1603,6 +1600,11 @@ static int kfd_ioctl_alloc_queue_gws(struct file *filep,
>   		goto out_unlock;
>   	}
>   
> +	if (!dev->gws) {
> +		retval = -ENODEV;
> +		goto out_unlock;
> +	}
> +
>   	if (dev->dqm->sched_policy == KFD_SCHED_POLICY_NO_HWS) {
>   		retval = -ENODEV;
>   		goto out_unlock;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 2a9e40131735..798ad1c8f799 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -569,6 +569,23 @@ static void kfd_cwsr_init(struct kfd_dev *kfd)
>   	}
>   }
>   
> +static int kfd_gws_init(struct kfd_dev *kfd)
> +{
> +	int ret = 0;
> +
> +	if (kfd->dqm->sched_policy == KFD_SCHED_POLICY_NO_HWS)
> +		return 0;
> +
> +	if (hws_gws_support
> +		|| (kfd->device_info->asic_family >= CHIP_VEGA10
> +			&& kfd->device_info->asic_family <= CHIP_RAVEN
> +			&& kfd->mec2_fw_version >= 0x1b3))
> +		ret = amdgpu_amdkfd_alloc_gws(kfd->kgd,
> +				amdgpu_amdkfd_get_num_gws(kfd->kgd), &kfd->gws);
> +
> +	return ret;
> +}
> +
>   bool kgd2kfd_device_init(struct kfd_dev *kfd,
>   			 struct drm_device *ddev,
>   			 const struct kgd2kfd_shared_resources *gpu_resources)
> @@ -578,6 +595,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>   	kfd->ddev = ddev;
>   	kfd->mec_fw_version = amdgpu_amdkfd_get_fw_version(kfd->kgd,
>   			KGD_ENGINE_MEC1);
> +	kfd->mec2_fw_version = amdgpu_amdkfd_get_fw_version(kfd->kgd,
> +			KGD_ENGINE_MEC2);
>   	kfd->sdma_fw_version = amdgpu_amdkfd_get_fw_version(kfd->kgd,
>   			KGD_ENGINE_SDMA1);
>   	kfd->shared_resources = *gpu_resources;
> @@ -598,13 +617,6 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>   	} else
>   		kfd->max_proc_per_quantum = hws_max_conc_proc;
>   
> -	/* Allocate global GWS that is shared by all KFD processes */
> -	if (hws_gws_support && amdgpu_amdkfd_alloc_gws(kfd->kgd,
> -			amdgpu_amdkfd_get_num_gws(kfd->kgd), &kfd->gws)) {
> -		dev_err(kfd_device, "Could not allocate %d gws\n",
> -			amdgpu_amdkfd_get_num_gws(kfd->kgd));
> -		goto out;
> -	}
>   	/* calculate max size of mqds needed for queues */
>   	size = max_num_of_queues_per_device *
>   			kfd->device_info->mqd_size_aligned;
> @@ -659,6 +671,15 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>   		goto device_queue_manager_error;
>   	}
>   
> +	/* If supported on this device, allocate global GWS that is shared
> +	 * by all KFD processes
> +	 */
> +	if (kfd_gws_init(kfd)) {
> +		dev_err(kfd_device, "Could not allocate %d gws\n",
> +			amdgpu_amdkfd_get_num_gws(kfd->kgd));
> +		goto gws_error;
> +	}
> +
>   	if (kfd_iommu_device_init(kfd)) {
>   		dev_err(kfd_device, "Error initializing iommuv2\n");
>   		goto device_iommu_error;
> @@ -688,6 +709,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>   kfd_topology_add_device_error:
>   kfd_resume_error:
>   device_iommu_error:
> +gws_error:
>   	device_queue_manager_uninit(kfd->dqm);
>   device_queue_manager_error:
>   	kfd_interrupt_exit(kfd);
> @@ -698,7 +720,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>   kfd_gtt_sa_init_error:
>   	amdgpu_amdkfd_free_gtt_mem(kfd->kgd, kfd->gtt_mem);
>   alloc_gtt_mem_failure:
> -	if (hws_gws_support)
> +	if (kfd->gws)
>   		amdgpu_amdkfd_free_gws(kfd->kgd, kfd->gws);
>   	dev_err(kfd_device,
>   		"device %x:%x NOT added due to errors\n",
> @@ -717,7 +739,7 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
>   		kfd_doorbell_fini(kfd);
>   		kfd_gtt_sa_fini(kfd);
>   		amdgpu_amdkfd_free_gtt_mem(kfd->kgd, kfd->gtt_mem);
> -		if (hws_gws_support)
> +		if (kfd->gws)
>   			amdgpu_amdkfd_free_gws(kfd->kgd, kfd->gws);
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 8ac680dc90f1..c0b0defc8f7a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -281,6 +281,7 @@ struct kfd_dev {
>   
>   	/* Firmware versions */
>   	uint16_t mec_fw_version;
> +	uint16_t mec2_fw_version;
>   	uint16_t sdma_fw_version;
>   
>   	/* Maximum process number mapped to HW scheduler */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 203c823d65f1..43a82cf76628 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1315,7 +1315,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>   				gpu->device_info->num_xgmi_sdma_engines;
>   	dev->node_props.num_sdma_queues_per_engine =
>   				gpu->device_info->num_sdma_queues_per_engine;
> -	dev->node_props.num_gws = (hws_gws_support &&
> +	dev->node_props.num_gws = (dev->gpu->gws &&
>   		dev->gpu->dqm->sched_policy != KFD_SCHED_POLICY_NO_HWS) ?
>   		amdgpu_amdkfd_get_num_gws(dev->gpu->kgd) : 0;
>   	dev->node_props.num_cp_queues = get_queues_num(dev->gpu->dqm);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
