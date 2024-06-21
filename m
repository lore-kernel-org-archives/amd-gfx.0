Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A136C27C4F
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jun 2024 08:15:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBAA510EF8C;
	Fri, 21 Jun 2024 08:15:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tdgaC1+A";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17FF810EF8D
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jun 2024 08:15:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gh1jZVzpsBkdgTkzUh/Xcd7K8rz9H1ZuDg22EpnO+b4FsatfpnYljKCEO9mzD3v5a8cnw+HK3N9oy7Ni1cwtfdeA1WDjJF5jbiedCZ044m3SpKasn9J5xfpzmPqDvWq5edFlmGBQcDiPYT3tKGmPhQH9u7YqDxJLzoh8otDyCMUp+HHJ2ccdyawjadsrpDBAnx41xbTrNe+BJ0NPQrtGi2UXTpzMHN8X5pqvC4S3pCjrChxsHOeYlkqXZorGOMiHkSjUKt5ZA5G2iLaG5T2Q3nyPKHtmSFhMjZq1H5rH7LAdv+3XjmLSeuIa7AOIJLw4/T6X4EXzlbhuHDkHvLcCuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhU1/H4qlKz2miZPhZa/uOieDxG7wQ9WxDBZkUZ61bI=;
 b=ZN3RIsji775sGcQYP4gQeLFKxpRHvlE/x7Z9aoLo1ycV7fNLG96UorgdAEVowIYsYS4DNMrtO2KvWh5pslIfpW6w/z/97/U7P2x3F3SWirgaSamfQNCt5/rXy2M0xEl4LV7CuynfKESMllxL8iKBssTb9B50gdipI+qf6fiLpGle4LqnUFqN0EXwel/zFHU+EBeim6UrmhoW9kqJanLWqqtngWJOn/pP/7Aiwh4KzdysZJdvLCJ4YWvehB/e/SvP1jqs2te7xayU5kU6vjg7ctF0SFhQUAsAvFNn36VqeC2M09wurnzItgVRrQPp3vHYQrO8vOzIOtc69zkXODGcLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhU1/H4qlKz2miZPhZa/uOieDxG7wQ9WxDBZkUZ61bI=;
 b=tdgaC1+AkNElWEmUcgENrI/BsWn10HOiqFEb4M9MZPKqkP1u6qN7TabWOFkU21BvO3mB4nVs/gwoOM5ZpnOb8HjV5wIxR1hYhBpVgPI1lDfKlY8T1wjtPqTKBCwNLpgslDvy2/3KhmiXsHd8Hl1LKPHOm/JtwbcCqAuiGtwdZ7s=
Received: from CH2PR05CA0037.namprd05.prod.outlook.com (2603:10b6:610:38::14)
 by SA1PR12MB6920.namprd12.prod.outlook.com (2603:10b6:806:258::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 08:15:19 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:38:cafe::67) by CH2PR05CA0037.outlook.office365.com
 (2603:10b6:610:38::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Fri, 21 Jun 2024 08:15:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 08:15:18 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Jun
 2024 03:15:17 -0500
Received: from jane-sm-stand.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 21 Jun 2024 03:15:16 -0500
From: Jane Jian <Jane.Jian@amd.com>
To: <Lijo.Lazar@amd.com>, <Alexander.Deucher@amd.com>, <Haijun.Chang@amd.com>, 
 <Victor.Zhao@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Jane Jian <Jane.Jian@amd.com>
Subject: [PATCH] drm/amdgpu: normalize registers as local xcc to read/write
 under sriov in TLB flush
Date: Fri, 21 Jun 2024 16:15:15 +0800
Message-ID: <20240621081515.2441125-1-Jane.Jian@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jane.Jian@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|SA1PR12MB6920:EE_
X-MS-Office365-Filtering-Correlation-Id: 1187562c-25bf-4992-0d82-08dc91ca49d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|36860700010|1800799021|376011|82310400023; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I+EVQfrQwZpq+yIBjbeQnTcA+GmB6UHBpn8gCendbptzEk93xVncIJpJWHS5?=
 =?us-ascii?Q?GJYGX8tyLog4swU3oihd0c72ks121/iajWCLQAgHVjftlfgrmayCOG7iZJhP?=
 =?us-ascii?Q?5mRFbbBw0FpUmLPTVy38SvMNgEH+ChMD9um3ZKMQlcmFSzgE21gIcyYsIW8y?=
 =?us-ascii?Q?QmIBswjF5TZSZVFVf+eDQun1xg5d5YPrCyNRwGlZPzp80IsqdiQIc3q9HNvP?=
 =?us-ascii?Q?654gASd+g3ERoo64dNFMpDHkuDS7WSNiTg1X0IimyXyYoGPqJXqtkNyHmq3A?=
 =?us-ascii?Q?pGZZs90U68DBzMXGiQLKF2r/XI6tXj7hXifB7AnnaqMqLXaGEY0My76MtHvv?=
 =?us-ascii?Q?xfC+Vs1cNUD/TuhsAbVRP/PW+VXU3kTAvcdaVj9cL9T0QD6/4To7tXVSJoAH?=
 =?us-ascii?Q?/P4a6yIQNq6wL8SYYqvzGKi98o2nAopw3iIgBAa+/Rk/FrSbnhjQEqQ4u3cG?=
 =?us-ascii?Q?icTAHqRFyz+iUfEtyHZAfAATcbat4I91B7xNme+CHrDvKEgIVU8G1+pLF4Ll?=
 =?us-ascii?Q?zuNUwcraTi0Btw4Qvigdr2sgAUpgqINbcRpwGvEuA9Kx339idjL6ODnk0lPT?=
 =?us-ascii?Q?jdhqgi6JBVKAT8wpf8ocpPaL4DRJSopBtcTwP2U6KGWnO4l4Ee3/foSJjWim?=
 =?us-ascii?Q?L2G722hJAbRM5pyc7/cUGBoTzcCF4hf9FeNJB77ppagKECILVtpm8NffhJ0s?=
 =?us-ascii?Q?pQXXanx7QIKvJ/XzZELAfc49cCA88A0r56G1mVrHjRkm5h5c3y/fpP5jcp4X?=
 =?us-ascii?Q?g9SpzCI9ziCYf6geAO+3hTJ+0gHamwfq2Ddth+Yrofh3DtIu7KzJcFA/OIcN?=
 =?us-ascii?Q?0Asfkpgpt8dpwNhN/Sp6VT5as7jDkRXhGAuAwOJQu9gCc8qXDnhuRHjo9CMI?=
 =?us-ascii?Q?5CwRapAZw88IZ7O07Y2q6z65lHJHowOmhv/xZuUtOotug7lKNj8I0gmPbjeO?=
 =?us-ascii?Q?SDqw/9+m/bwTJ0C5Y8LsOTVO+TgnXHIbg3IvKQwa6U/nUs65GIa9mbhJFoqm?=
 =?us-ascii?Q?qXg/0mEgdPAFflZTMN7cKjiTmkKALwjpTSKvP9CghpveuxBdlOL7IXnVn78j?=
 =?us-ascii?Q?nP+hr3Tahi+vBCMdt5vdxKEuWIu7l0B9+CRsUUk7OjgY333PlyeDHFmwO3vT?=
 =?us-ascii?Q?4yAx2D2WcxFspnurbmj3fqsex9xFQGM5YNBkgnVxcz8u7Vte66grU4IH3/jv?=
 =?us-ascii?Q?WzJpjlshUmBcjv6WkS8GSuY3fNAA5gsEl2NpsxnJJ9W0e/RqtQ9/DIjtEnAA?=
 =?us-ascii?Q?lA9kAD1JOIA8KPTa/aVWQb8GFAPFFVIUR4Hsh+P5bhimdxPQSLNYTI4iUdfW?=
 =?us-ascii?Q?dJoyJSTpFnxTrhnd6fbQQHcV4R25YfVW9YotQasJoezmX3fA9qAgE1cHzEsl?=
 =?us-ascii?Q?qWEGRwASpR1rKqGIe77uv7cSC+mFScDmqnl/UKC6dtKSEUZwiw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(36860700010)(1800799021)(376011)(82310400023); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 08:15:18.7238 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1187562c-25bf-4992-0d82-08dc91ca49d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6920
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

Signed-off-by: Jane Jian <Jane.Jian@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 112 +++++++++++----------
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c |  16 +++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  32 ++++--
 drivers/gpu/drm/amd/amdgpu/soc15.c         |   1 +
 drivers/gpu/drm/amd/amdgpu/soc15.h         |   1 +
 drivers/gpu/drm/amd/amdgpu/soc15_common.h  |   5 +-
 6 files changed, 101 insertions(+), 66 deletions(-)

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
index 2c9a0aa41e2d..98b00c0e522f 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -1085,3 +1085,19 @@ ssize_t aqua_vanjaram_get_reg_state(struct amdgpu_device *adev,
 
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
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 88b4644f8e96..7542a75f068b 100644
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
+			req = NORMALIZE_XCC_REG_OFFSET(GC, req);
+			ack = NORMALIZE_XCC_REG_OFFSET(GC, ack);
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
+		low_distance = NORMALIZE_XCC_REG_OFFSET(GC, low_distance);
+		high_distance = NORMALIZE_XCC_REG_OFFSET(GC, high_distance);
+		req_offset = NORMALIZE_XCC_REG_OFFSET(GC, req_offset);
+		ack = NORMALIZE_XCC_REG_OFFSET(GC, ack);
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
index 8d16dacdc172..e6e61fc77080 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -927,6 +927,7 @@ static const struct amdgpu_asic_funcs aqua_vanjaram_asic_funcs =
 	.query_video_codecs = &soc15_query_video_codecs,
 	.encode_ext_smn_addressing = &aqua_vanjaram_encode_ext_smn_addressing,
 	.get_reg_state = &aqua_vanjaram_get_reg_state,
+	.normalize_reg_offset = &aqua_vanjaram_normalize_reg_offset,
 };
 
 static int soc15_common_early_init(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.h b/drivers/gpu/drm/amd/amdgpu/soc15.h
index 282584a48be0..f1e974604e3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.h
@@ -124,4 +124,5 @@ ssize_t aqua_vanjaram_get_reg_state(struct amdgpu_device *adev,
 void vega10_doorbell_index_init(struct amdgpu_device *adev);
 void vega20_doorbell_index_init(struct amdgpu_device *adev);
 void aqua_vanjaram_doorbell_index_init(struct amdgpu_device *adev);
+u32 aqua_vanjaram_normalize_reg_offset(u32 hwip, u32 offset);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index 242b24f73c17..ddf0aad51821 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -210,4 +210,7 @@
 #define WREG64_MCA(ext, mca_base, idx, val) \
 	WREG64_PCIE_EXT(adev->asic_funcs->encode_ext_smn_addressing(ext) + mca_base + (idx * 8), val)
 
-#endif
+#define NORMALIZE_XCC_REG_OFFSET(ip, offset) \
+	((amdgpu_sriov_vf(adev) && adev->asic_funcs->normalize_reg_offset) ? \
+	adev->asic_funcs->normalize_reg_offset(ip##_HWIP, offset) : offset)
+#endif
\ No newline at end of file
-- 
2.34.1

