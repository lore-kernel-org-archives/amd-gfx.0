Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D60A2CD1288
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Apr 2024 02:58:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59EBF10F836;
	Tue,  2 Apr 2024 02:58:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iBa5RyEa";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6C1F10F836
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Apr 2024 02:58:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fALwA3CNjkumY946omrUEPkazXKNOgS+BcmF2sxEN0EkwjNtMZTNPSh+HEuVXhWQKZG9zaIZNJt+kqCQ/n8hyIrJxP/FMJuW5KkGI9Y2bD+UfDiFjmPArIHkvpsyJ9+N0igq50/05dw4FTb3EKxSA1Sy3HqPGctwdI80Azl45bzz3WC6RMj6+HiJ9q8KAesNWYvGnCDGRQ4g6p3UD/LHq7fIZTcg0YVuovEdUrKpN3JnE1hiZ2lA+2WrC1+5QWnhDvMNEdYk9fvRhlnmO4fWjBw8EA/JKjBAmGGG8r2kxHdPuIcHSTDVR1f516sQVW5nXnXtuSfXXS6gqO3cI0Bqxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNdNS6zVPgAFAtdznYWkdyTxQ+v1Dvn+0pflXXXBwJQ=;
 b=LdRsLQVHmMzbfwM5a094d3J6T5+V8FEUUk6fYN2/SGN2IOFIcRQxB0FNalKlFzlri37B+DR5i1vKa7LA1vViasumE1UZMfiCxNIFS0SRzyeKyT3XIZHWKUtgWFW4PA6Obp0iXN0+GnMy++an5jebrcRuAq40DqP8Rs1QgGMKBv4QdU7ZMToqoUqe/DVMOe9AxfImDed/7/bZYq3VHwtn/AXm8SvwsPuocBd+X2donac4oA7a/JxxgD4e1XISU3LN4cQa2LHtmdGgRwT73suzeMh/B5NBSWylcROxvyRbinCK1xFmZW+jUimVasOSbx7wpUUzxxXkivlOMyrs9JlLSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNdNS6zVPgAFAtdznYWkdyTxQ+v1Dvn+0pflXXXBwJQ=;
 b=iBa5RyEa1fAqGQzMmSoSptoEqPcWLxBddKJoAIc2Lt7j3aqd2oOG/+VsyRsFnpWWVT1UoGVoEUtF4gDaQBqRKzECiiIvFxI4RT35hXgU2JwsZpZ52TrEbTdSp8eS6rsmtnzUhLSpScOGqP+dd5j+TyRkLWl02AylIWSjGehSUj4=
Received: from MW4P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::23)
 by SN7PR12MB7836.namprd12.prod.outlook.com (2603:10b6:806:34e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 02:58:34 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:303:115:cafe::29) by MW4P220CA0018.outlook.office365.com
 (2603:10b6:303:115::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Tue, 2 Apr 2024 02:58:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 02:58:34 +0000
Received: from [10.65.150.118] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 1 Apr
 2024 21:58:32 -0500
Message-ID: <9def23fd-7356-4ec8-805c-c5a0bbc434d8@amd.com>
Date: Tue, 2 Apr 2024 10:58:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/amd/amdgpu: support MES command SET_HW_RESOURCE1
 in sriov
To: chongli2 <chongli2@amd.com>, <amd-gfx@lists.freedesktop.org>
References: <20240327035210.3985-1-chongli2@amd.com>
 <20240327035210.3985-2-chongli2@amd.com>
From: JingWen Chen <jingwech@amd.com>
In-Reply-To: <20240327035210.3985-2-chongli2@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|SN7PR12MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: 41e8321b-3074-4ff2-804a-08dc52c0c938
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xwkrR+lOkQFX89vE9U7GrDIWJbTYRrY8HPVYnzKq4xsak4FURNfnot6s+I0VPxFc3ORm4v0wKGG+daPvYZS/WJL1N8bThebl3BGpYrAoK1/0vasultfWzsiaUYTUINDM+ue3dmAPa3ULLjY7yaTQd4RhXsGJJsxdS9j5K400dDXFkupx42pMXBBimVFcCMrhwEt4h7PRSGk80GSsSU1DxP7G9auuQ8gwEw/A8Ss6wJVaTVa7TpzyYic1YsrqHovcsHb8CXQtKGX5IGGPjYhaqfWEn/do+b/RjxZL9P+6IqPhc8MYgjmPNzTkCLM3w6C2hZeOVrx/RoOx7kIgWhsFywMa68u4ZfpKTAsN/cbjHz8So+RTBwoYhj5vID5eUWO3uhH1f2aIvF8V6eEErDY4nGCOyFW9XzK9+oopGqjwovj1+kmXRqyb91eZiWvEB5yOr9AbrCIf8aOHf0bPckXaQYhW/nyS19ojEvgTwf4YuDZByGz8gDuXpfhpPp4LnukY/UwUC+8zwbWmKmlgySsFDWoavivGq8mHjf/bAkJFJJeEljWgWkkiabnjtCarABULmk8hJrSVPgt1ZL/OI6KVzBxku3mMlnjUeXM3wsXQ075jqGLoyKOheIdWxdrL8887HkjkQTTZcPeQqRdJF1flEAv23SjRWF85csYzEDQNmoFEutAH538fN8jP6VvXusEFXZ+IjE3vRx6UOL6T5GIljL0UOoYoCVj/9Q6Wu0dOflLIgmgQtb8ROxuv/rz0QxLo
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 02:58:34.1483 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e8321b-3074-4ff2-804a-08dc52c0c938
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7836
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

Acked-by: Jingwen Chen <Jingwen.Chen2@amd.com>

On 2024/3/27 11:52, chongli2 wrote:
> 	support MES command SET_HW_RESOURCE1 in sriov
>
> Signed-off-by: chongli2 <chongli2@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |  6 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |  5 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |  4 ++
>  drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h   |  9 ++--
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        | 43 +++++++++++++++++++
>  drivers/gpu/drm/amd/include/mes_v11_api_def.h | 21 +++++++++
>  6 files changed, 85 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index 7d4f93fea937..3774148f3e5d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -140,6 +140,12 @@ struct amdgpu_mes {
>  
>  	/* ip specific functions */
>  	const struct amdgpu_mes_funcs   *funcs;
> +
> +	/* mes resource_1 bo*/
> +	struct amdgpu_bo    *resource_1;
> +	uint64_t            resource_1_gpu_addr;
> +	void                *resource_1_addr;
> +
>  };
>  
>  struct amdgpu_mes_process {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index aed60aaf1a55..52f01efde2fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -576,6 +576,11 @@ static int amdgpu_virt_write_vf2pf_data(struct amdgpu_device *adev)
>  	vf2pf_info->decode_usage = 0;
>  
>  	vf2pf_info->dummy_page_addr = (uint64_t)adev->dummy_page_addr;
> +	vf2pf_info->mes_info_addr = (uint64_t)adev->mes.resource_1_gpu_addr;
> +
> +	if (adev->mes.resource_1) {
> +		vf2pf_info->mes_info_size = adev->mes.resource_1->tbo.base.size;
> +	}
>  	vf2pf_info->checksum =
>  		amd_sriov_msg_checksum(
>  		vf2pf_info, vf2pf_info->header.size, 0, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index a858bc98cad4..a9f2f0c4f799 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -132,6 +132,8 @@ enum AMDGIM_FEATURE_FLAG {
>  	AMDGIM_FEATURE_AV1_SUPPORT = (1 << 6),
>  	/* VCN RB decouple */
>  	AMDGIM_FEATURE_VCN_RB_DECOUPLE = (1 << 7),
> +	/* MES info */
> +	AMDGIM_FEATURE_MES_INFO_ENABLE = (1 << 8),
>  };
>  
>  enum AMDGIM_REG_ACCESS_FLAG {
> @@ -335,6 +337,8 @@ static inline bool is_virtual_machine(void)
>  	((adev)->virt.gim_feature & AMDGIM_FEATURE_AV1_SUPPORT)
>  #define amdgpu_sriov_is_vcn_rb_decouple(adev) \
>  	((adev)->virt.gim_feature & AMDGIM_FEATURE_VCN_RB_DECOUPLE)
> +#define amdgpu_sriov_is_mes_info_enable(adev) \
> +	((adev)->virt.gim_feature & AMDGIM_FEATURE_MES_INFO_ENABLE)
>  bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev);
>  void amdgpu_virt_init_setting(struct amdgpu_device *adev);
>  int amdgpu_virt_request_full_gpu(struct amdgpu_device *adev, bool init);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> index 51a14f6d93bd..0de78d6a83fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> @@ -94,7 +94,8 @@ union amd_sriov_msg_feature_flags {
>  		uint32_t reg_indirect_acc  : 1;
>  		uint32_t av1_support       : 1;
>  		uint32_t vcn_rb_decouple   : 1;
> -		uint32_t reserved          : 24;
> +		uint32_t mes_info_enable   : 1;
> +		uint32_t reserved          : 23;
>  	} flags;
>  	uint32_t all;
>  };
> @@ -221,7 +222,7 @@ struct amd_sriov_msg_vf2pf_info_header {
>  	uint32_t reserved[2];
>  };
>  
> -#define AMD_SRIOV_MSG_VF2PF_INFO_FILLED_SIZE (70)
> +#define AMD_SRIOV_MSG_VF2PF_INFO_FILLED_SIZE (73)
>  struct amd_sriov_msg_vf2pf_info {
>  	/* header contains size and version */
>  	struct amd_sriov_msg_vf2pf_info_header header;
> @@ -265,7 +266,9 @@ struct amd_sriov_msg_vf2pf_info {
>  		uint32_t version;
>  	} ucode_info[AMD_SRIOV_MSG_RESERVE_UCODE];
>  	uint64_t dummy_page_addr;
> -
> +	/* FB allocated for guest MES to record UQ info */
> +	uint64_t mes_info_addr;
> +	uint32_t mes_info_size;
>  	/* reserved */
>  	uint32_t reserved[256 - AMD_SRIOV_MSG_VF2PF_INFO_FILLED_SIZE];
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 072c478665ad..78ec170cfeef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -419,6 +419,36 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
>  			offsetof(union MESAPI_SET_HW_RESOURCES, api_status));
>  }
>  
> +static int mes_v11_0_set_hw_resources_1(struct amdgpu_mes *mes)
> +{
> +	int size = 128 * PAGE_SIZE;
> +	int ret = 0;
> +	struct amdgpu_device *adev = mes->adev;
> +	union MESAPI_SET_HW_RESOURCES_1 mes_set_hw_res_pkt;
> +	memset(&mes_set_hw_res_pkt, 0, sizeof(mes_set_hw_res_pkt));
> +
> +	mes_set_hw_res_pkt.header.type = MES_API_TYPE_SCHEDULER;
> +	mes_set_hw_res_pkt.header.opcode = MES_SCH_API_SET_HW_RSRC_1;
> +	mes_set_hw_res_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
> +	mes_set_hw_res_pkt.enable_mes_info_ctx = 1;
> +
> +	ret = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
> +				AMDGPU_GEM_DOMAIN_VRAM,
> +				&mes->resource_1,
> +				&mes->resource_1_gpu_addr,
> +				&mes->resource_1_addr);
> +	if (ret) {
> +		dev_err(adev->dev, "(%d) failed to create mes resource_1 bo\n", ret);
> +		return ret;
> +	}
> +
> +	mes_set_hw_res_pkt.mes_info_ctx_mc_addr = mes->resource_1_gpu_addr;
> +	mes_set_hw_res_pkt.mes_info_ctx_size = mes->resource_1->tbo.base.size;
> +	return mes_v11_0_submit_pkt_and_poll_completion(mes,
> +			&mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt),
> +			offsetof(union MESAPI_SET_HW_RESOURCES_1, api_status));
> +}
> +
>  static const struct amdgpu_mes_funcs mes_v11_0_funcs = {
>  	.add_hw_queue = mes_v11_0_add_hw_queue,
>  	.remove_hw_queue = mes_v11_0_remove_hw_queue,
> @@ -1200,6 +1230,14 @@ static int mes_v11_0_hw_init(void *handle)
>  	if (r)
>  		goto failure;
>  
> +	if (amdgpu_sriov_is_mes_info_enable(adev)) {
> +		r = mes_v11_0_set_hw_resources_1(&adev->mes);
> +		if (r) {
> +			DRM_ERROR("failed mes_v11_0_set_hw_resources_1, r=%d\n", r);
> +			goto failure;
> +		}
> +	}
> +
>  	r = mes_v11_0_query_sched_status(&adev->mes);
>  	if (r) {
>  		DRM_ERROR("MES is busy\n");
> @@ -1223,6 +1261,11 @@ static int mes_v11_0_hw_init(void *handle)
>  
>  static int mes_v11_0_hw_fini(void *handle)
>  {
> +	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	if (amdgpu_sriov_is_mes_info_enable(adev)) {
> +		amdgpu_bo_free_kernel(&adev->mes.resource_1, &adev->mes.resource_1_gpu_addr,
> +					&adev->mes.resource_1_addr);
> +	}
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> index ec5b9ab67c5e..410c8d664336 100644
> --- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> +++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> @@ -61,6 +61,7 @@ enum MES_SCH_API_OPCODE {
>  	MES_SCH_API_MISC			= 14,
>  	MES_SCH_API_UPDATE_ROOT_PAGE_TABLE      = 15,
>  	MES_SCH_API_AMD_LOG                     = 16,
> +	MES_SCH_API_SET_HW_RSRC_1               = 19,
>  	MES_SCH_API_MAX				= 0xFF
>  };
>  
> @@ -238,6 +239,26 @@ union MESAPI_SET_HW_RESOURCES {
>  	uint32_t	max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
>  };
>  
> +union MESAPI_SET_HW_RESOURCES_1 {
> +	struct {
> +		union MES_API_HEADER				header;
> +		struct MES_API_STATUS			   api_status;
> +		uint64_t							timestamp;
> +		union {
> +			struct {
> +				uint32_t enable_mes_info_ctx : 1;
> +				uint32_t reserved : 31;
> +			};
> +			uint32_t uint32_all;
> +		};
> +		uint64_t							mes_info_ctx_mc_addr;
> +		uint32_t							mes_info_ctx_size;
> +		uint32_t							mes_kiq_unmap_timeout; // unit is 100ms
> +	};
> +
> +	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
> +};
> +
>  union MESAPI__ADD_QUEUE {
>  	struct {
>  		union MES_API_HEADER		header;

-- 
Best Regards,
JingWen Chen

