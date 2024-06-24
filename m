Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2856AC2BD05
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jun 2024 09:13:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABC1D10E3C4;
	Mon, 24 Jun 2024 09:13:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QbpmuOx9";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2FCF10E3C4
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 09:13:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgYF8Q5utxsIbn4OveHnCPhpfMc/A8at/gPw9YzPSSMmTS67XOybJxofP71pnottoQTp9NIKdAFuK2JLVsGiQnS4QGTP3AlhrvwpW9jPaCDzgOy90O7EqZH/G5uVw3qZn8GEA93yDyRizlpRm/RIJbEqk7I4ms4X5KqGwSmJklZZ7jKGkdJ9c2rZsXK2UlGaY64S1beJ0MpZ10KmaWj2rcky1nz5O8/lc4ZzrKG2FEMVmePqpuo+c+GsM6CPfBNDiIjqgOl9AgsK6566cRiJQc37X6HLvk5Mh9M6HNkNMlPX8rh2GeZJK0oNDjDrdmL0I4h/N4+qvz0KWl4Y0732/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9YzU6289Pxa7ALS6w6VCBsJYx91uXKa0FK0Ec+4SUk=;
 b=BEIcP3JwVs/+4AyCbovbWALQnt4YzlkFgLYMDvo4K29KUEjGpZmtaN8Km1lrHF8ftUPFGmI0pugGvjw+nYGi/885yimJh+IqauTvmDrCl7nuBeAhvQm0Y7/ClmI9uotAWbcxEgqKMyzfYa0I06y9W+PPjrcT7Odq0j8/K9xrpKQZa7sVzXeQaL07HsHnzP6qThv4fxVmPXRTOUY8fPPx60Kl9I00NFtwKJcWRrLOj5OJgJzFbgQP58FD8PsOH3LAo8LV9wW2qAagwQnT2H1Wk5K8zWbKUKMOXdkZEl3zh/9of0ToKMVwDCGkeSweJf1wwPFDgfCAPaSaLICg0DQcgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9YzU6289Pxa7ALS6w6VCBsJYx91uXKa0FK0Ec+4SUk=;
 b=QbpmuOx92+02ndwFe4iHcI8A8povMHY2gUgSoo82zSLlA9d2gUo4mspeX0QMfN+8e0HySTXvL4RzYmt6bYn7fDAYfEBmQEp8wBbp+5i4nu3XWYZt2TRwtZKIjU6cMALrnSxse9Al+DL53hnYr9fk/BSMM998EbFzqFIpKDiGGMw=
Received: from PH8PR02CA0005.namprd02.prod.outlook.com (2603:10b6:510:2d0::13)
 by CY5PR12MB6573.namprd12.prod.outlook.com (2603:10b6:930:43::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Mon, 24 Jun
 2024 09:13:22 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:510:2d0:cafe::45) by PH8PR02CA0005.outlook.office365.com
 (2603:10b6:510:2d0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 09:13:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 09:13:21 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 04:13:20 -0500
Received: from jane-sm-stand.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 24 Jun 2024 04:13:19 -0500
From: Jane Jian <Jane.Jian@amd.com>
To: <Lijo.Lazar@amd.com>, <Haijun.Chang@amd.com>, <Victor.Zhao@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Jane Jian <Jane.Jian@amd.com>
Subject: [PATCH] drm/amdgpu: normalize registers as local xcc to read/write
 under sriov in TLB flush
Date: Mon, 24 Jun 2024 17:13:18 +0800
Message-ID: <20240624091318.2487733-1-Jane.Jian@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jane.Jian@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|CY5PR12MB6573:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d8624cb-f778-4aee-3c91-08dc942de51d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|376011|36860700010|1800799021|82310400023; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WFHb3KHGswg7ji0vVpj1YZu046MB20/dIxMAtTAnKxDjdog5Dml+fq6/lxBY?=
 =?us-ascii?Q?eTdIH6O7WgzdtZg776tIIiHkS3y+34fh7knywh9FgnZ4B1uKrGyI6N13DKLu?=
 =?us-ascii?Q?I97qdiX8iARynrVxobXkWwAkt8eDjQZeCgWsifUNcOPTVS+hMXa0yfwsvMpN?=
 =?us-ascii?Q?Hr0g7d7ImGhmD9OAA8mjPMYS4fgLRONmsPIgTVIFt4rjnw5AqsFHNFXLuQoM?=
 =?us-ascii?Q?WZWW3QVKFOLFoNbQAJWiNaIQdb8PnArNPoA/r5q3JteOq7wPrdJqm0gRXSko?=
 =?us-ascii?Q?B4CRdB26IK9kg4rFaaFKL18/62jn9jOnhMHCVA4nf2tHvltTOzYUjQnIIYPy?=
 =?us-ascii?Q?eCDrnlMOKHuyGv2w+fSoiw7LgGfAfUHUuck8x5lidcMBDPPFBvag2rRfTrd8?=
 =?us-ascii?Q?Py961gm78pVquSiA3fp9Nq8gcfznGXmHSc6yTN3/6Stfh85qQ4q5B0GRMfdj?=
 =?us-ascii?Q?1LMyPza+mC0w9iR33UtvNnP5FUXP12z+0PEP9mFuCdp9sR4/wndXVf6Paqt4?=
 =?us-ascii?Q?uUJKbX3MR7TIFdiPrjCbH6gNUbVyczzdOgsfyhlJPc/R2sIwnCDiSrqTecFC?=
 =?us-ascii?Q?rGH+EPOFup4/cRBoleDhzJkCoox3T5eRtLy80PNKPjVu7u77b27pPvqyOD+G?=
 =?us-ascii?Q?eeZbPqcw2zANtip/80EDLkYZowIoJywqRrqf0heyXnRtdvrd9TyLI6WJj9Ju?=
 =?us-ascii?Q?bHnKzHLr7TbrmfBlD385cn+I3l+xM2zAB/n+09dSsc5ZXiIdWcsvcThekZjC?=
 =?us-ascii?Q?XUuuw54uBW62iaCjsOans2pFNg1ZlOQG0qOY2Me3I5e0BMT0zqteiOxO/qAG?=
 =?us-ascii?Q?iygeHxKXOsBblV1HLfgSOfzLUy06OLJZjzy6qOy638+cGmgTLeijiapXGeAv?=
 =?us-ascii?Q?ifHlVj99WeP4JGFPAmfTEbdHeW5j0332gAFnAAWW+r9yrOObJqpkXoOWnN+L?=
 =?us-ascii?Q?8bVDDREmz8moPUFNjn1eU8cR1JMf/c7jWiBT+6pnA6zo/zwrwbCEKbHJTD3J?=
 =?us-ascii?Q?wCV1nNKejH9OvNE3ip6XWuyn9LRKrBai4EW8PC5teoN3BCVKaQskqHza4aZr?=
 =?us-ascii?Q?5OczIE+BET8YX3KK+ZA7/9nlEA9l9+ci+21TwOKrAeybPtUiOOC7WsXW+zx1?=
 =?us-ascii?Q?+cyMbVx5SbnV8KF4CvTeMw97a6L68YydJoeqFKgmv11rzlJ3f6cLxdgM22sF?=
 =?us-ascii?Q?HvEH/P3t040D+YcQwyX/a2zoT0TzS/23lu78o3PWPnL3M8EO8+KTNkpEU54w?=
 =?us-ascii?Q?dm99b+bC/4zqnqlwUnqyfCdQj60wfZMO9hgMkZ0vStmoy1EPsfA3Q7LFfuoc?=
 =?us-ascii?Q?kUOivDKaEsMjlN4e45v+qaCisa0Da0t3wOhagUNJaRnyYTvYLWyI8uTQglti?=
 =?us-ascii?Q?EySmyWF5F9mEmfJhOI1/gHOY0Zk1qsU4tBZpT/ZeQQ6/Ak2I6w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(376011)(36860700010)(1800799021)(82310400023); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 09:13:21.6855 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8624cb-f778-4aee-3c91-08dc942de51d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6573
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

[WHY]
sriov has the higher bit violation when flushing tlb

[HOW]
normalize the registers to keep lower 16-bit(dword aligned) to aviod higher bit violation
RLCG will mask xcd out and always assume it's accessing its own xcd

[TODO]
later will add the normalization in sriovw/rreg after fixing bugs

v2
rename the normalized macro, add ip block type for further use
move asics func declaration after ip block type since new func refers ip block type
add normalization in emit flush tlb as well

v3
declare the new func in the asic specific header

Signed-off-by: Jane Jian <Jane.Jian@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 112 +++++++++++----------
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c |  17 ++++
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.h |  28 ++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  32 ++++--
 drivers/gpu/drm/amd/amdgpu/soc15.c         |   2 +
 drivers/gpu/drm/amd/amdgpu/soc15_common.h  |   5 +-
 6 files changed, 130 insertions(+), 66 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 083f353cff6e..070fd9e601fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -583,61 +583,6 @@ struct amdgpu_video_codecs {
 	const struct amdgpu_video_codec_info *codec_array;
 };
 
-/*
- * ASIC specific functions.
- */
-struct amdgpu_asic_funcs {
-	bool (*read_disabled_bios)(struct amdgpu_device *adev);
-	bool (*read_bios_from_rom)(struct amdgpu_device *adev,
-				   u8 *bios, u32 length_bytes);
-	int (*read_register)(struct amdgpu_device *adev, u32 se_num,
-			     u32 sh_num, u32 reg_offset, u32 *value);
-	void (*set_vga_state)(struct amdgpu_device *adev, bool state);
-	int (*reset)(struct amdgpu_device *adev);
-	enum amd_reset_method (*reset_method)(struct amdgpu_device *adev);
-	/* get the reference clock */
-	u32 (*get_xclk)(struct amdgpu_device *adev);
-	/* MM block clocks */
-	int (*set_uvd_clocks)(struct amdgpu_device *adev, u32 vclk, u32 dclk);
-	int (*set_vce_clocks)(struct amdgpu_device *adev, u32 evclk, u32 ecclk);
-	/* static power management */
-	int (*get_pcie_lanes)(struct amdgpu_device *adev);
-	void (*set_pcie_lanes)(struct amdgpu_device *adev, int lanes);
-	/* get config memsize register */
-	u32 (*get_config_memsize)(struct amdgpu_device *adev);
-	/* flush hdp write queue */
-	void (*flush_hdp)(struct amdgpu_device *adev, struct amdgpu_ring *ring);
-	/* invalidate hdp read cache */
-	void (*invalidate_hdp)(struct amdgpu_device *adev,
-			       struct amdgpu_ring *ring);
-	/* check if the asic needs a full reset of if soft reset will work */
-	bool (*need_full_reset)(struct amdgpu_device *adev);
-	/* initialize doorbell layout for specific asic*/
-	void (*init_doorbell_index)(struct amdgpu_device *adev);
-	/* PCIe bandwidth usage */
-	void (*get_pcie_usage)(struct amdgpu_device *adev, uint64_t *count0,
-			       uint64_t *count1);
-	/* do we need to reset the asic at init time (e.g., kexec) */
-	bool (*need_reset_on_init)(struct amdgpu_device *adev);
-	/* PCIe replay counter */
-	uint64_t (*get_pcie_replay_count)(struct amdgpu_device *adev);
-	/* device supports BACO */
-	int (*supports_baco)(struct amdgpu_device *adev);
-	/* pre asic_init quirks */
-	void (*pre_asic_init)(struct amdgpu_device *adev);
-	/* enter/exit umd stable pstate */
-	int (*update_umd_stable_pstate)(struct amdgpu_device *adev, bool enter);
-	/* query video codecs */
-	int (*query_video_codecs)(struct amdgpu_device *adev, bool encode,
-				  const struct amdgpu_video_codecs **codecs);
-	/* encode "> 32bits" smn addressing */
-	u64 (*encode_ext_smn_addressing)(int ext_id);
-
-	ssize_t (*get_reg_state)(struct amdgpu_device *adev,
-				 enum amdgpu_reg_state reg_state, void *buf,
-				 size_t max_size);
-};
-
 /*
  * IOCTL.
  */
@@ -728,6 +673,63 @@ enum amd_hw_ip_block_type {
 	MAX_HWIP
 };
 
+/*
+ * ASIC specific functions.
+ */
+struct amdgpu_asic_funcs {
+	bool (*read_disabled_bios)(struct amdgpu_device *adev);
+	bool (*read_bios_from_rom)(struct amdgpu_device *adev,
+				   u8 *bios, u32 length_bytes);
+	int (*read_register)(struct amdgpu_device *adev, u32 se_num,
+			     u32 sh_num, u32 reg_offset, u32 *value);
+	void (*set_vga_state)(struct amdgpu_device *adev, bool state);
+	int (*reset)(struct amdgpu_device *adev);
+	enum amd_reset_method (*reset_method)(struct amdgpu_device *adev);
+	/* get the reference clock */
+	u32 (*get_xclk)(struct amdgpu_device *adev);
+	/* MM block clocks */
+	int (*set_uvd_clocks)(struct amdgpu_device *adev, u32 vclk, u32 dclk);
+	int (*set_vce_clocks)(struct amdgpu_device *adev, u32 evclk, u32 ecclk);
+	/* static power management */
+	int (*get_pcie_lanes)(struct amdgpu_device *adev);
+	void (*set_pcie_lanes)(struct amdgpu_device *adev, int lanes);
+	/* get config memsize register */
+	u32 (*get_config_memsize)(struct amdgpu_device *adev);
+	/* flush hdp write queue */
+	void (*flush_hdp)(struct amdgpu_device *adev, struct amdgpu_ring *ring);
+	/* invalidate hdp read cache */
+	void (*invalidate_hdp)(struct amdgpu_device *adev,
+			       struct amdgpu_ring *ring);
+	/* check if the asic needs a full reset of if soft reset will work */
+	bool (*need_full_reset)(struct amdgpu_device *adev);
+	/* initialize doorbell layout for specific asic*/
+	void (*init_doorbell_index)(struct amdgpu_device *adev);
+	/* PCIe bandwidth usage */
+	void (*get_pcie_usage)(struct amdgpu_device *adev, uint64_t *count0,
+			       uint64_t *count1);
+	/* do we need to reset the asic at init time (e.g., kexec) */
+	bool (*need_reset_on_init)(struct amdgpu_device *adev);
+	/* PCIe replay counter */
+	uint64_t (*get_pcie_replay_count)(struct amdgpu_device *adev);
+	/* device supports BACO */
+	int (*supports_baco)(struct amdgpu_device *adev);
+	/* pre asic_init quirks */
+	void (*pre_asic_init)(struct amdgpu_device *adev);
+	/* enter/exit umd stable pstate */
+	int (*update_umd_stable_pstate)(struct amdgpu_device *adev, bool enter);
+	/* query video codecs */
+	int (*query_video_codecs)(struct amdgpu_device *adev, bool encode,
+				  const struct amdgpu_video_codecs **codecs);
+	/* encode "> 32bits" smn addressing */
+	u64 (*encode_ext_smn_addressing)(int ext_id);
+
+	ssize_t (*get_reg_state)(struct amdgpu_device *adev,
+				 enum amdgpu_reg_state reg_state, void *buf,
+				 size_t max_size);
+	/* normalize offset to keep in lower 16-bit */
+	u32 (*normalize_reg_offset)(enum amd_hw_ip_block_type hwip, u32 offset);
+};
+
 #define HWIP_MAX_INSTANCE	44
 
 #define HW_ID_MAX		300
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index 2c9a0aa41e2d..7cdd4b9d08ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -29,6 +29,7 @@
 #include "gfx_v9_4_3.h"
 #include "gfxhub_v1_2.h"
 #include "sdma_v4_4_2.h"
+#include "aqua_vanjaram.h"
 
 #define XCP_INST_MASK(num_inst, xcp_id)                                        \
 	(num_inst ? GENMASK(num_inst - 1, 0) << (xcp_id * num_inst) : 0)
@@ -1085,3 +1086,19 @@ ssize_t aqua_vanjaram_get_reg_state(struct amdgpu_device *adev,
 
 	return size;
 }
+
+u32 aqua_vanjaram_normalize_reg_offset(enum amd_hw_ip_block_type hwip, u32 offset)
+{
+	u32 normalized_offset;
+
+	switch (hwip) {
+	case GC_HWIP:
+		normalized_offset = offset & 0xffff;
+		break;
+	default:
+		normalized_offset = offset;
+		break;
+	}
+
+	return normalized_offset;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.h b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.h
new file mode 100644
index 000000000000..8d1b7a89cb71
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.h
@@ -0,0 +1,28 @@
+/*
+ * Copyright 2024 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+#ifndef __AQUA_VANJARAM_H__
+#define __AQUA_VANJARAM_H__
+
+u32 aqua_vanjaram_normalize_reg_offset(enum amd_hw_ip_block_type hwip, u32 offset);
+
+#endif
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 88b4644f8e96..19e4429db37c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -853,8 +853,12 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	 */
 	if (adev->gfx.kiq[inst].ring.sched.ready &&
 	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
-		uint32_t req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
-		uint32_t ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
+
+		/* Select lower 16 bits to write in local xcc */
+		if (AMDGPU_IS_GFXHUB(vmhub)) {
+			req = NORMALIZE_XCC_REG_OFFSET(req);
+			ack = NORMALIZE_XCC_REG_OFFSET(ack);
+		}
 
 		amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
 						 1 << vmid, inst);
@@ -979,6 +983,7 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
 	struct amdgpu_vmhub *hub = &adev->vmhub[ring->vm_hub];
 	uint32_t req = gmc_v9_0_get_invalidate_req(vmid, 0);
 	unsigned int eng = ring->vm_inv_eng;
+	u32 low_distance, high_distance, req_offset, ack;
 
 	/*
 	 * It may lose gpuvm invalidate acknowldege state across power-gating
@@ -986,7 +991,18 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
 	 * release after invalidation to avoid entering power gated state
 	 * to WA the Issue
 	 */
+	low_distance = hub->ctx0_ptb_addr_lo32 + (hub->ctx_addr_distance * vmid);
+	high_distance = hub->ctx0_ptb_addr_hi32 + (hub->ctx_addr_distance * vmid);
+	req_offset = hub->vm_inv_eng0_req + hub->eng_distance * eng;
+	ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
 
+	/* Select lower 16 bits to write in local xcc */
+	if (AMDGPU_IS_GFXHUB(ring->vm_hub)) {
+		low_distance = NORMALIZE_XCC_REG_OFFSET(low_distance);
+		high_distance = NORMALIZE_XCC_REG_OFFSET(high_distance);
+		req_offset = NORMALIZE_XCC_REG_OFFSET(req_offset);
+		ack = NORMALIZE_XCC_REG_OFFSET(ack);
+	}
 	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
 	if (use_semaphore)
 		/* a read return value of 1 means semaphore acuqire */
@@ -994,18 +1010,14 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
 					  hub->vm_inv_eng0_sem +
 					  hub->eng_distance * eng, 0x1, 0x1);
 
-	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_lo32 +
-			      (hub->ctx_addr_distance * vmid),
+	amdgpu_ring_emit_wreg(ring, low_distance,
 			      lower_32_bits(pd_addr));
 
-	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_hi32 +
-			      (hub->ctx_addr_distance * vmid),
+	amdgpu_ring_emit_wreg(ring, high_distance,
 			      upper_32_bits(pd_addr));
 
-	amdgpu_ring_emit_reg_write_reg_wait(ring, hub->vm_inv_eng0_req +
-					    hub->eng_distance * eng,
-					    hub->vm_inv_eng0_ack +
-					    hub->eng_distance * eng,
+	amdgpu_ring_emit_reg_write_reg_wait(ring, req_offset,
+					    ack,
 					    req, 1 << vmid);
 
 	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 8d16dacdc172..3a1fa2797f02 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -78,6 +78,7 @@
 #include "mxgpu_ai.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_xgmi.h"
+#include "aqua_vanjaram.h"
 #include <uapi/linux/kfd_ioctl.h>
 
 #define mmMP0_MISC_CGTT_CTRL0                                                                   0x01b9
@@ -927,6 +928,7 @@ static const struct amdgpu_asic_funcs aqua_vanjaram_asic_funcs =
 	.query_video_codecs = &soc15_query_video_codecs,
 	.encode_ext_smn_addressing = &aqua_vanjaram_encode_ext_smn_addressing,
 	.get_reg_state = &aqua_vanjaram_get_reg_state,
+	.normalize_reg_offset = &aqua_vanjaram_normalize_reg_offset,
 };
 
 static int soc15_common_early_init(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index 242b24f73c17..01afd1a24e8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -210,4 +210,7 @@
 #define WREG64_MCA(ext, mca_base, idx, val) \
 	WREG64_PCIE_EXT(adev->asic_funcs->encode_ext_smn_addressing(ext) + mca_base + (idx * 8), val)
 
-#endif
+#define NORMALIZE_XCC_REG_OFFSET(offset) \
+	((amdgpu_sriov_vf(adev) && adev->asic_funcs->normalize_reg_offset) ? \
+	adev->asic_funcs->normalize_reg_offset(GC_HWIP, offset) : offset)
+#endif
\ No newline at end of file
-- 
2.34.1

