Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B2ED2B931
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 14:31:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C861A10E5C2;
	Tue,  5 Nov 2024 14:31:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IvOIfGDl";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFE9B10E5C2
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 14:31:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HUFmc1jARSzmyB6VLHGdy0wa+w11RH/19vY5OFFYZvzXuQcMaRf7x34/yS+lnSvLA6lkaHEaXJCJENhk53tDeo9i4dD3prC5pZUuamkgSJzXgfNbew568vlYK3YXautARvBv5Jmnd+RjHd4XSw9vRcNBdvJ9KRW2SBrSJ/e8Av8PPYTjGBaaWxFb1tiyR898Oc2DakB3Q6Oko/ww6YXAhOuxDqItPHXiAcl4cVBKFvVQGG7NB1lTBtWjbI/mpU2Bt/QflEfbhqwA1cteTtYRONQHvc4LlN+sXkdlauu5UdTHkykvn4fpB2gNj2mMy2UzZwMQiCnVfSO4cMl+NfEOuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbziLfqSacxXgXWEObXK5AOVPozJ0K9C6rpz1kppJls=;
 b=Z3p8pbi+5RuiIhJxmIqKPCBdgV/GN5PMmWgRg2q0n7w4O2STmji0ag8zZXOR0GayQc33gK27SMkLs2ktYGPqQNziL8AdeA/Zutri7vEoHl/HbsOymIPmc7a/kMMaq91Gw2Up5JJavjruHDfhZlxWRmWA30snE59YTugyIHzq2bb3xAKGObuEqLasafel7n5SPY5eC/9Bv6faet8zBSe3AVDYmf9lUrT39776uSoavGJaH99smtuGuZ7L1DYY3/4jI0Vth9fT37APR3NZ9PFdg5hSL/zFP1tymi15feDj4zJpWKrDz4bgfxQsf3dP2eXDftDPNo29mx4j+Trf6p+gaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbziLfqSacxXgXWEObXK5AOVPozJ0K9C6rpz1kppJls=;
 b=IvOIfGDlwC/5jMbc0FiRScBrWq2J3/S52MvGpIld+sTHgBNJSggahqeD15t2QAkN/O0NLoluXvnZ8Xhr85pLlniuPW18clMD9hud1liyJ/x0kDZgiiK/9MPU7lNWpliONAWl3sk8rOKFzBZ4u98S9nWvQgCIyPnvfhZXAN7nb0s=
Received: from CH0PR03CA0037.namprd03.prod.outlook.com (2603:10b6:610:b3::12)
 by LV2PR12MB6015.namprd12.prod.outlook.com (2603:10b6:408:14f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 14:30:59 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::75) by CH0PR03CA0037.outlook.office365.com
 (2603:10b6:610:b3::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.32 via Frontend
 Transport; Tue, 5 Nov 2024 14:30:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 14:30:58 +0000
Received: from mkmvskvorts01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 08:30:58 -0600
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <zhigang.luo@amd.com>,
 <tao.zhou1@amd.com>, <hawking.zhang@amd.com>
CC: Victor Skvortsov <victor.skvortsov@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: VF Query RAS Caps from Host if supported
Date: Tue, 5 Nov 2024 09:30:06 -0500
Message-ID: <20241105143007.274828-3-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105143007.274828-1-victor.skvortsov@amd.com>
References: <20241105143007.274828-1-victor.skvortsov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|LV2PR12MB6015:EE_
X-MS-Office365-Filtering-Correlation-Id: 3093a5f8-ff24-4704-7977-08dcfda6776a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?naMKlbkp6orfAtP/IdEFGKYXklCG/NpdZD+2/dcT31CtaOXzUZys/q4oHbr1?=
 =?us-ascii?Q?OM6tAmYORL676+WrmFp1KiqczoUdIwZbJhM87q9qZpusugSLvrJ8ZHELiX5A?=
 =?us-ascii?Q?H2kvm6BGLOeZDZDFh3EH8EqlL0kbpQlQhfl8H0wcb0xq2CZpD6p/xo9a+m8P?=
 =?us-ascii?Q?4s9mom82wsjAq0bqoWHA5n4MBp+rzp0XYVyUOmDh8JM4B2UE6Iw+vnby9Knp?=
 =?us-ascii?Q?NEgUX4mcq2E1F5MLfXuydlBTuuCnWCkxG2UvO1zhNpZ9xD4uaWAovSDJXRvb?=
 =?us-ascii?Q?nczY560zodcuoE8z89JrqGCBPBy3oNvHMWswL9miNnSeX3VRtmyII8Ywoudc?=
 =?us-ascii?Q?aKEb8fICKpYP31K4SYeK2cxTDV2EUvfEekIp5PKWkaygxCOSFZYTsIOWb6i4?=
 =?us-ascii?Q?MAZk/Q7P4SzrZPnyaNIwJjuLfDg11pg9zdsKmtxqqGLf4XZ9cqkEwTDrT35K?=
 =?us-ascii?Q?0ddICJUIwpWyXhrLreZ6GL9EkKrI3BUY5ToRDJBiH0dAoYdIvnLYnpCI3Mrv?=
 =?us-ascii?Q?elyGEf2csRTEkhVO7MjHsAt+TFRoolZ3devGdmhzu+zgHnrwdWj/CuWvLv/j?=
 =?us-ascii?Q?E12fct4qEeltwp5OSIm3FggUdvsRZcpQ1dWbsCCh2DkOkWMiw4wt2PXXzA4U?=
 =?us-ascii?Q?XalTjOyuE3U6D0K/Jhh88DWFU3HQPE+Ng2DFdsZWKl0ychc4piY8PtZUUsD/?=
 =?us-ascii?Q?AoS/vuub8Z10dglPP2px3AGLpsYtXMeB6OCVM9F+D9Xvq4hOgIvU8XS5uHTl?=
 =?us-ascii?Q?t+pWqMyOixrc70QXfLR4E4rNpbHGlHh2rWVIe9/ahHlXzZqS3DZVaHkmbOoB?=
 =?us-ascii?Q?BLZsyDtWe0dzaqb6EqXqsFaNZxpuR9qb0WUZur+ryrvlqnsdK6IMj7vYJr6r?=
 =?us-ascii?Q?/ZESNjjHWDdNEverdme1svfV78tBmET9WiPftXqbcaz7gxqB7kfuoGpTWC4p?=
 =?us-ascii?Q?MXOMJIb1BuoBVx7/wAQ8nsaw/5ZJm4Euzzy6oEsU/hNFywbq1fKX34ohzd9B?=
 =?us-ascii?Q?vWESGTpKv7wyZCRf3Fs4Tjwy6gfCUC1t58v+UqozA4OFbRB4kqN6/3DN9ofO?=
 =?us-ascii?Q?NwpTYS3/xYGfNdIAWIFVDiBNYVEetkNR6bG5EmwE1lkxtKWoNPUqMf0R4hn5?=
 =?us-ascii?Q?6R+rv8IGBegFGzGFIzXaWmns5Apmg1cr3pUZL/pOaIMKQVbHPS2JnkuZ2/2m?=
 =?us-ascii?Q?pxAXGKJ03LLeREcjMt/hElgYeShtKpeZl73NwKu1xSzVIK4sIPzV4CR9/uGj?=
 =?us-ascii?Q?ii7Zj3b9odQ0o2/cdG4owf506C6vs6fpNUqadOWP8OqjVy3DhKjxvO/PtDdV?=
 =?us-ascii?Q?+IrYhuHAo8oUJBCH5fcXy2h0vaVuhMbVq/houcTzcev4ncpTKOWeOWjdLnB7?=
 =?us-ascii?Q?Gjjbaqbg2bzBoomBQtp+eWksfgA/P5rkFPIcBdgnBadXv2f5jg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 14:30:58.8851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3093a5f8-ff24-4704-7977-08dcfda6776a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6015
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

If VF RAS Capability support is enabled, guest is able to
retrieve the real RAS support from the host.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  |  5 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 53 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  7 ++++
 3 files changed, 65 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 1d9eda883bb8..89d87dc17ac1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3452,6 +3452,11 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
 	if (!amdgpu_ras_asic_supported(adev))
 		return;
 
+	if (amdgpu_sriov_vf(adev)) {
+		if (amdgpu_virt_get_ras_capability(adev))
+			goto init_ras_enabled_flag;
+	}
+
 	/* query ras capability from psp */
 	if (amdgpu_psp_get_ras_capability(&adev->psp))
 		goto init_ras_enabled_flag;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index b6397d3229e1..53297c40f09c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -523,6 +523,7 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 
 		adev->unique_id =
 			((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->uuid;
+		adev->virt.ras_en_caps.all = ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->ras_en_caps.all;
 		break;
 	default:
 		dev_err(adev->dev, "invalid pf2vf version: 0x%x\n", pf2vf_info->version);
@@ -1144,3 +1145,55 @@ bool amdgpu_sriov_xnack_support(struct amdgpu_device *adev)
 
 	return xnack_mode;
 }
+
+bool amdgpu_virt_get_ras_capability(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+
+	if (!amdgpu_sriov_ras_caps_en(adev))
+		return false;
+
+	if (adev->virt.ras_en_caps.bits.block_umc)
+		adev->ras_hw_enabled |= BIT(AMDGPU_RAS_BLOCK__UMC);
+	if (adev->virt.ras_en_caps.bits.block_sdma)
+		adev->ras_hw_enabled |= BIT(AMDGPU_RAS_BLOCK__SDMA);
+	if (adev->virt.ras_en_caps.bits.block_gfx)
+		adev->ras_hw_enabled |= BIT(AMDGPU_RAS_BLOCK__GFX);
+	if (adev->virt.ras_en_caps.bits.block_mmhub)
+		adev->ras_hw_enabled |= BIT(AMDGPU_RAS_BLOCK__MMHUB);
+	if (adev->virt.ras_en_caps.bits.block_athub)
+		adev->ras_hw_enabled |= BIT(AMDGPU_RAS_BLOCK__ATHUB);
+	if (adev->virt.ras_en_caps.bits.block_pcie_bif)
+		adev->ras_hw_enabled |= BIT(AMDGPU_RAS_BLOCK__PCIE_BIF);
+	if (adev->virt.ras_en_caps.bits.block_hdp)
+		adev->ras_hw_enabled |= BIT(AMDGPU_RAS_BLOCK__HDP);
+	if (adev->virt.ras_en_caps.bits.block_xgmi_wafl)
+		adev->ras_hw_enabled |= BIT(AMDGPU_RAS_BLOCK__XGMI_WAFL);
+	if (adev->virt.ras_en_caps.bits.block_df)
+		adev->ras_hw_enabled |= BIT(AMDGPU_RAS_BLOCK__DF);
+	if (adev->virt.ras_en_caps.bits.block_smn)
+		adev->ras_hw_enabled |= BIT(AMDGPU_RAS_BLOCK__SMN);
+	if (adev->virt.ras_en_caps.bits.block_sem)
+		adev->ras_hw_enabled |= BIT(AMDGPU_RAS_BLOCK__SEM);
+	if (adev->virt.ras_en_caps.bits.block_mp0)
+		adev->ras_hw_enabled |= BIT(AMDGPU_RAS_BLOCK__MP0);
+	if (adev->virt.ras_en_caps.bits.block_mp1)
+		adev->ras_hw_enabled |= BIT(AMDGPU_RAS_BLOCK__MP1);
+	if (adev->virt.ras_en_caps.bits.block_fuse)
+		adev->ras_hw_enabled |= BIT(AMDGPU_RAS_BLOCK__FUSE);
+	if (adev->virt.ras_en_caps.bits.block_mca)
+		adev->ras_hw_enabled |= BIT(AMDGPU_RAS_BLOCK__MCA);
+	if (adev->virt.ras_en_caps.bits.block_vcn)
+		adev->ras_hw_enabled |= BIT(AMDGPU_RAS_BLOCK__VCN);
+	if (adev->virt.ras_en_caps.bits.block_jpeg)
+		adev->ras_hw_enabled |= BIT(AMDGPU_RAS_BLOCK__JPEG);
+	if (adev->virt.ras_en_caps.bits.block_ih)
+		adev->ras_hw_enabled |= BIT(AMDGPU_RAS_BLOCK__IH);
+	if (adev->virt.ras_en_caps.bits.block_mpio)
+		adev->ras_hw_enabled |= BIT(AMDGPU_RAS_BLOCK__MPIO);
+
+	if (adev->virt.ras_en_caps.bits.poison_propogation_mode)
+		con->poison_supported = true; /* Poison is handled by host */
+
+	return true;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index f6eee57338df..f0ff84add692 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -137,6 +137,7 @@ enum AMDGIM_FEATURE_FLAG {
 	AMDGIM_FEATURE_VCN_RB_DECOUPLE = (1 << 7),
 	/* MES info */
 	AMDGIM_FEATURE_MES_INFO_ENABLE = (1 << 8),
+	AMDGIM_FEATURE_RAS_CAPS = (1 << 9),
 };
 
 enum AMDGIM_REG_ACCESS_FLAG {
@@ -277,6 +278,8 @@ struct amdgpu_virt {
 	uint32_t autoload_ucode_id;
 
 	struct mutex rlcg_reg_lock;
+
+	union amd_sriov_ras_caps ras_en_caps;
 };
 
 struct amdgpu_video_codec_info;
@@ -321,6 +324,9 @@ struct amdgpu_video_codec_info;
 #define amdgpu_sriov_vf_mmio_access_protection(adev) \
 ((adev)->virt.caps & AMDGPU_VF_MMIO_ACCESS_PROTECT)
 
+#define amdgpu_sriov_ras_caps_en(adev) \
+((adev)->virt.gim_feature & AMDGIM_FEATURE_RAS_CAPS)
+
 static inline bool is_virtual_machine(void)
 {
 #if defined(CONFIG_X86)
@@ -384,4 +390,5 @@ bool amdgpu_virt_get_rlcg_reg_access_flag(struct amdgpu_device *adev,
 					  u32 acc_flags, u32 hwip,
 					  bool write, u32 *rlcg_flag);
 u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag, u32 xcc_id);
+bool amdgpu_virt_get_ras_capability(struct amdgpu_device *adev);
 #endif
-- 
2.34.1

