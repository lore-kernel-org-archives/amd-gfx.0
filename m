Return-Path: <SRS0=Q5HU=6B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6C5C2BB1D
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 22:58:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D681214AF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 22:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hYjBRaMg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D681214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B898D6EC19;
	Fri, 17 Apr 2020 22:58:11 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770070.outbound.protection.outlook.com [40.107.77.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21F6D6EC19
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2020 22:58:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfDFiXsKDh1AtUUj+hTI4c91Yfy0GqtxmJ98Ds+yR9Rd7HKz0zw95vzEm4Aepun3MerXcM6I0lX4rFtIl5jAZVxlSmWFVzr6e7Fl9O0NIl7pEGGSTVWQREtoE56oRwJhDznFWsiXfge5iJXRBRCWX1RYh4Eue+OXIQprZdrWQ87RHf+7lcH42nDUCJBqSKNitwffQdWoyxus20tpx/Gw2fTceW350sL5iZUm7+lRFJu1l8zOYqu35DRzr+nyL7+RjM9Zwb54FKW0XiGp9nCOFYk+cET8jucpKOJWCglDxadEMTy3FRsDz2yeQlknNa3qI97pqaEIqOg+0CQKcNWU3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QgkL626cRkjN5d66tP0FXHBnrtoPbVfMpz0rLlxrB0=;
 b=TXqAv/V4kj+Cfl0JIzAjifKCDU4MMLyB8O2IOx3Zkjsa3DvlkD+pNwWuACMLYMux4+hqbnvvE3yRRFRAYnVaXSWgHXoHaEvNZrGUenfVrKpad56j4mHXaaF1MoDVRoOzEc+FHNuwyFHteaQG/P7kRcVW9WD9UhYE5kviUNDHEMjtVAQkwhMGHOUOGf0T/pcK7mvPtQ0mewhtjg/nxARePYNMvDVOCNXc8BwmDebXaOobSLG/VWnT+zdfWaBXBhGOsT3/QdGB8414xItG8fXz6T384bD03Edc5IsV1eahgsTndrU0sGynTC+ZIGJejrX2utgMn7GGiNhxOMon4HwZVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QgkL626cRkjN5d66tP0FXHBnrtoPbVfMpz0rLlxrB0=;
 b=hYjBRaMghNp9XqcSVYJiL6ykGaRZZLMQYF9tbM8XeJJw2WL+1OMkq/C/R5KlErZOo25c0z34yDCdSfsd1Be9agEP64+rr4NTdwKIeTg0stMCv8ARFIw8TQjkKCKAZp5FGxGoMeiBJ2SVVCW0Tajs501I2Tdj7x+KDPnWNV0wIOY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR12MB2407.namprd12.prod.outlook.com (2603:10b6:4:b4::24) by
 DM5PR12MB1932.namprd12.prod.outlook.com (2603:10b6:3:10e::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.26; Fri, 17 Apr 2020 22:58:07 +0000
Received: from DM5PR12MB2407.namprd12.prod.outlook.com
 ([fe80::7d36:4eac:2088:637f]) by DM5PR12MB2407.namprd12.prod.outlook.com
 ([fe80::7d36:4eac:2088:637f%3]) with mapi id 15.20.2900.028; Fri, 17 Apr 2020
 22:58:07 +0000
Subject: Re: [PATCH v2] drm/amdkfd: Put ASIC revision into HSA capability
To: Joseph Greathouse <Joseph.Greathouse@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <0f6d51ba-0247-c6a1-2a99-2b747754074a@amd.com>
 <20200417225432.529695-1-Joseph.Greathouse@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <0bca634f-407a-33ca-2fbd-75d3dadc5c39@amd.com>
Date: Fri, 17 Apr 2020 18:58:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200417225432.529695-1-Joseph.Greathouse@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YQBPR01CA0143.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::43) To DM5PR12MB2407.namprd12.prod.outlook.com
 (2603:10b6:4:b4::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by
 YQBPR01CA0143.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:1::43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Fri, 17 Apr 2020 22:58:06 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7d3cdd1a-c0b1-4ca1-70ff-08d7e322cae9
X-MS-TrafficTypeDiagnostic: DM5PR12MB1932:|DM5PR12MB1932:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB19324025BD80904E1BC9B52C92D90@DM5PR12MB1932.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0376ECF4DD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2407.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(478600001)(26005)(16576012)(956004)(86362001)(16526019)(31686004)(316002)(186003)(2616005)(6486002)(31696002)(66556008)(5660300002)(66476007)(44832011)(8936002)(66946007)(2906002)(52116002)(81156014)(36756003)(8676002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /PGn58LGpdWeA+3a8lkV7StK2b8CltSY4GlUxUGh/CuM0EXcvy/EQ4Q3DIiYE6W1zEr+5n6iRWEKM+qEMn0fbvUi2/NlDMfncfodaeT5dKLoATeZF00cJBQJo0mDaAkI3zqXSyht5FM6kfrWNpZVpB01sVgdzHoFiiNMV5uIPWKI4QoZCVAFJlpoqib7JjskEznankCgvb7i+oPw1b3WTne3Z3XnjBgr65pLVHbSA/BSWHwtnJBSNJXtwjDUvs0JhEK6xjZjpUCan1TbjQ7ykI3SVOJ/vvxyoyxjc7YghXCgSXytZ1X1IWcvA/90rg0YGNj3Q/7ySp4iqdBkLxR8jhT3/KFRnf7M9irPSZ5v/Vxq1Y2GuVDcj6NFlEPNVn6d7S0yIuO4w7KoN1IiYFOYDGAOjZAtgtYybxA1K5nIvfzBBQpCNWb+hkQ6ny79GzPD
X-MS-Exchange-AntiSpam-MessageData: yqEIJw1MgtPo+V7dTZX+s6fK4pX9ovu9COrFZTkhT1R79/Lk4Y+SQeLRdA6+8PtDziI2OIkAYjWfsOuFGKIsu5L5JFYgy6bEqYVGHyMLUdiqZDGFFo5isKsLzEhxZGJrOVrGJOL2qGqGsshdfIiEEg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3cdd1a-c0b1-4ca1-70ff-08d7e322cae9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 22:58:07.1392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5a62jlE6jLUXBoKDxpS2uny1k7t719iTsRsTkOBHub0BVVjzqeolxAoSEGEjJtL1BXCz+L8I3hR8rCJce0AVJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1932
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

Am 2020-04-17 um 6:54 p.m. schrieb Joseph Greathouse:
> In order to surface the ASIC revision to user level, we want
> to put it into the HSA topology. This can be because different
> ASIC revisions may require user-level software to do different
> things (e.g. patch code for things that are changed in later
> hardware revisions).
>
> The ASIC revision from the hardware is maximum of 4 bits at this
> time, so put it into 4 of the open bits in the HSA capability.
> Then user-level software can use this capability information to
> know -- for each ASIC -- what revision-based things must be done.
>
> Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 7 +++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c  | 4 ++++
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.h  | 5 ++++-
>  4 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index abfbe89e805e..ad59ac4423b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -564,6 +564,13 @@ uint32_t amdgpu_amdkfd_get_num_gws(struct kgd_dev *kgd)
>  	return adev->gds.gws_size;
>  }
>  
> +uint32_t amdgpu_amdkfd_get_asic_rev_id(struct kgd_dev *kgd)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
> +
> +	return adev->rev_id;
> +}
> +
>  int amdgpu_amdkfd_submit_ib(struct kgd_dev *kgd, enum kgd_engine_type engine,
>  				uint32_t vmid, uint64_t gpu_addr,
>  				uint32_t *ib_cmd, uint32_t ib_len)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 13feb313e9b3..d065c50582eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -175,6 +175,7 @@ uint64_t amdgpu_amdkfd_get_hive_id(struct kgd_dev *kgd);
>  uint64_t amdgpu_amdkfd_get_unique_id(struct kgd_dev *kgd);
>  uint64_t amdgpu_amdkfd_get_mmio_remap_phys_addr(struct kgd_dev *kgd);
>  uint32_t amdgpu_amdkfd_get_num_gws(struct kgd_dev *kgd);
> +uint32_t amdgpu_amdkfd_get_asic_rev_id(struct kgd_dev *kgd);
>  uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct kgd_dev *dst, struct kgd_dev *src);
>  
>  /* Read user wptr from a specified user address space with page fault
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 5db42814dd51..6e52c95ce8b0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1303,6 +1303,10 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>  
>  	dev->node_props.vendor_id = gpu->pdev->vendor;
>  	dev->node_props.device_id = gpu->pdev->device;
> +	dev->node_props.capability |=
> +		((amdgpu_amdkfd_get_asic_rev_id(dev->gpu->kgd) <<
> +			HSA_CAP_ASIC_REVISION_SHIFT) &
> +			HSA_CAP_ASIC_REVISION_MASK);
>  	dev->node_props.location_id = pci_dev_id(gpu->pdev);
>  	dev->node_props.max_engine_clk_fcompute =
>  		amdgpu_amdkfd_get_max_engine_clock_in_mhz(dev->gpu->kgd);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> index 46eeecaf1b68..0c51bd3dcd59 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> @@ -41,7 +41,6 @@
>  #define HSA_CAP_WATCH_POINTS_TOTALBITS_SHIFT	8
>  #define HSA_CAP_DOORBELL_TYPE_TOTALBITS_MASK	0x00003000
>  #define HSA_CAP_DOORBELL_TYPE_TOTALBITS_SHIFT	12
> -#define HSA_CAP_RESERVED			0xffffc000
>  
>  #define HSA_CAP_DOORBELL_TYPE_PRE_1_0		0x0
>  #define HSA_CAP_DOORBELL_TYPE_1_0		0x1
> @@ -51,6 +50,10 @@
>  #define HSA_CAP_SRAM_EDCSUPPORTED		0x00080000
>  #define HSA_CAP_MEM_EDCSUPPORTED		0x00100000
>  #define HSA_CAP_RASEVENTNOTIFY			0x00200000
> +#define HSA_CAP_ASIC_REVISION_MASK		0x03c00000
> +#define HSA_CAP_ASIC_REVISION_SHIFT		22
> +
> +#define HSA_CAP_RESERVED			0xfc078000
>  
>  struct kfd_node_properties {
>  	uint64_t hive_id;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
