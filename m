Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D99CAC581
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 11:03:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1414910E268;
	Mon,  8 Sep 2025 11:03:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QhYKuNpo";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D5FF10E268
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 11:02:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1iJywc5I5ueSFcpp3ixzp7sfUdzRHt5r4G7mMJ7NUA3f3srWqNZx5xX9A+12xdCNI9FEKRo7Q4r2LngcyPUCznD0vh7kRmcEhEycyokZQ9xtJ94i6noguwdJkS+glQ4pv+SHuyD0b9s3gkEFdZtmAdvp+BJOQL9zUXLYkmIJ9RLEY+iSmH5ds7oNQbMikG1lhloMSwUmVYzmyy+04/qRyvbgrCYNRe05aMdv7uXa/wU3F4UXWqbgaO3cf/c7dZ6aaAIdmGoKwPdf7bMjYB0pMiIb6+zBmO/m32lskDoqLbWkapUJzjDfpeTg0Qr5ivY/olXS19lCGkkW3AMmHkWsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SkDI5VgH234w+iX00WytSDY0V8QW1sQxPmWihAu+1fc=;
 b=LuwLFHKIGAblO3h+47jbE2h318/d0Gb8Vzt3YNeOodml8HMKfwgySgP7RbIxqmTaq7Iczzs7FE39xEsB0UVi8I1N6CW2Jxe4AxcmQpE5ua42n1uP7mpWrAjLlBuY9a91CmcX8X9nyMN5k92Lcnh127InoIuVJLgDTsBgFi1vydCmjG8QrzA1aqIAuWYsdP25BVls1wCMkWeVxihRWGFYI/5sHon8MzZITDycrHJLc2WwasgDraWRi6dPU3ZdJQd+93DS1ZXhO5Y5aoGXoPvCg7yD/r316uvHu9hAGnzJjgdXQnNaMqSQ8sufuYB0b7avKvQ9kMF94ngZbN6QUUR9uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SkDI5VgH234w+iX00WytSDY0V8QW1sQxPmWihAu+1fc=;
 b=QhYKuNpoeMPgwL7ObonlEJjVTMm3SdA8n4NB93EPKY5FGdlmRZU57ZTswY9bjssX7xfhzZ4L7PuFKNNoHrmKU1nOhToWk/x4xG9zH2CERYISMo1wHba8pmHm282TJ17xglqrOhSWlDNUk9fjhmtIoy2XlFuQ4Uq9r27vkpJcuOM=
Received: from BN8PR04CA0062.namprd04.prod.outlook.com (2603:10b6:408:d4::36)
 by PH8PR12MB7133.namprd12.prod.outlook.com (2603:10b6:510:22e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 11:02:55 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:d4:cafe::10) by BN8PR04CA0062.outlook.office365.com
 (2603:10b6:408:d4::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 11:02:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 11:02:55 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 04:02:53 -0700
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH v2 1/7] drm/amdgpu/pm: Add definition for gpu_metrics v1.9
Date: Mon, 8 Sep 2025 16:31:12 +0530
Message-ID: <20250908110231.2888628-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250908110231.2888628-1-lijo.lazar@amd.com>
References: <20250908110231.2888628-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|PH8PR12MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: f2c00639-e8a8-4698-d24c-08ddeec74375
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P0oGOS2mZb1w1+8P428U/9OApgVEWleQ2zSXSwQoKxjAoUS26MUo8IgZDIm1?=
 =?us-ascii?Q?awzn9/nBQKi72eOzLI2CJj+CnQwDDR2Ov8KaUD73ibY3CI8qDoBw6Ap6s25j?=
 =?us-ascii?Q?BONNCqPtG/MRSXGWcsRRi3PvHJWLNYjMxq2G2HrtM/HU7zpGrTzUb04RgYuz?=
 =?us-ascii?Q?juDjr9dOsqLU2Xtw7t3XfIA2DicCPM4azOANCuF7y4qXPfWlryWJY4XRYsKk?=
 =?us-ascii?Q?QEcKHd0SUqWzZZFWd++0MGZkE2H8co5sqpEgTaMguPGaij/VjmqTeAWm+6nV?=
 =?us-ascii?Q?4p43Wxi96vKK2U4z5gFTaJ8Z3CDOJ1mT22fCYvDCdGNkc0dUMp+8kQUpCLF1?=
 =?us-ascii?Q?nOWHX7J6oS6WmVZLBMJ5b1GELw2AFYRTgHnzER3HTBds3n8UEdYKjQRlluoF?=
 =?us-ascii?Q?PApmqFz6OaNCgPxX54P3AGqS54zpLkxRPa2Tk4gUvP8mmYLEZ8rBcnDgmkty?=
 =?us-ascii?Q?6/yAWCW7nAgaGUbWIXlG76fOjdvkomDShGUwElRxSah+QbMoWJMb7dP58NL5?=
 =?us-ascii?Q?Ti/coQpBumGhkryNcT9gUL7KaaaVJ/E2MOOyjWnbQ3c1nDsN7TKQK8vEXGbM?=
 =?us-ascii?Q?DnVfqH/yEx9S64/JYt83cEKKvAINu5uIOC0MHKQ+EAxMKTFBu5zTnJNy5v9u?=
 =?us-ascii?Q?7O1PmT+GxU0tDO4nr4+WxQm50SmkKm4n4/345Z/98ESCarqvmadsXfVSaqRZ?=
 =?us-ascii?Q?W1d3Y7AtLTU3chvRJJIYWt3roePZWAbtv3t6xjejYTEgL0Hx6wSIXdJ2cEls?=
 =?us-ascii?Q?5Rp+aNMXx6aGcDgZ1mqI2TrGGp2ZIHKNnEfGnC/vuV6qU7wL8gmK3SyVZgwT?=
 =?us-ascii?Q?tAhg1AWivnM6C9gw5dO6Pc0KQDE607FEmJ04QKTwmRlSu1o2nA/pAPuIL7I0?=
 =?us-ascii?Q?oG+PMhgypzhrxR50L2gbWlTLa1ywLexleXr3GlIxA6ChCUy1Gdg75uNKwB69?=
 =?us-ascii?Q?ks9EOYvw8m3BCFNkAd3BKcEK5sq8S0ISAvBMZ5f4jBslQfjkqdjztLHJqDwd?=
 =?us-ascii?Q?fLkAk0St4YwjlvMyR4GQYlTnzxDKaIDUj5Hw4k9TMJ14HDMJo38q8Yo30q2t?=
 =?us-ascii?Q?R8p/qnDNb2pJ9IKD9iHc40DZ5hKYNYNy0ztiYNk7RtkerSoLiKLZS3f8qoE1?=
 =?us-ascii?Q?1D4ubTs3gf8BSRkqTIR5kXHFw0ROIwhAzwWMqiciC4/Lf1Hciu/e6XMOpYQL?=
 =?us-ascii?Q?Bb7o5dTHsEiMAWGCf54e8G7QmJzvHCDInTsyU/2gd4F6QaTIlsPp043q/RG3?=
 =?us-ascii?Q?lj8dESEa7x8GZozV5ul6SL7DEkIx/qUmqCGcS+xlu02N9T/dx1Wuyyslc6SF?=
 =?us-ascii?Q?M5sd+6md36u2UVDjO0/EXFPdWlNY6IsdLsitxGo10nXg/VmtbwmOJuzCHwp8?=
 =?us-ascii?Q?iRHZWtEOwilaStAvKaahQD7/3YSXNtpkpJsjfLRIBbBUB4PVOw50i4kPjgGx?=
 =?us-ascii?Q?2G/ns1hFOwwPDQHb0yoeshOk+7MLHFG/zvJZgcLJ3li+zICVBqQy4NvODdu0?=
 =?us-ascii?Q?EM29YN4e6l9zzFgAc0q5rUlZWnLbTUmtUi50?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 11:02:55.3761 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c00639-e8a8-4698-d24c-08ddeec74375
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7133
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

Add gpu metrics definition which is only a set of gpu metrics
attributes. A field is encoded by its id, type and number of instances.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    | 117 ++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 2f7e4b5bebf3..424fd2f0cd51 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -528,6 +528,110 @@ struct metrics_table_header {
 	uint8_t				content_revision;
 };
 
+enum amdgpu_metrics_attr_id {
+	AMDGPU_METRICS_ATTR_TEMPERATURE_HOTSPOT,
+	AMDGPU_METRICS_ATTR_TEMPERATURE_MEM,
+	AMDGPU_METRICS_ATTR_TEMPERATURE_VRSOC,
+	AMDGPU_METRICS_ATTR_CURR_SOCKET_POWER,
+	AMDGPU_METRICS_ATTR_AVERAGE_GFX_ACTIVITY,
+	AMDGPU_METRICS_ATTR_AVERAGE_UMC_ACTIVITY,
+	AMDGPU_METRICS_ATTR_MEM_MAX_BANDWIDTH,
+	AMDGPU_METRICS_ATTR_ENERGY_ACCUMULATOR,
+	AMDGPU_METRICS_ATTR_SYSTEM_CLOCK_COUNTER,
+	AMDGPU_METRICS_ATTR_ACCUMULATION_COUNTER,
+	AMDGPU_METRICS_ATTR_PROCHOT_RESIDENCY_ACC,
+	AMDGPU_METRICS_ATTR_PPT_RESIDENCY_ACC,
+	AMDGPU_METRICS_ATTR_SOCKET_THM_RESIDENCY_ACC,
+	AMDGPU_METRICS_ATTR_VR_THM_RESIDENCY_ACC,
+	AMDGPU_METRICS_ATTR_HBM_THM_RESIDENCY_ACC,
+	AMDGPU_METRICS_ATTR_GFXCLK_LOCK_STATUS,
+	AMDGPU_METRICS_ATTR_PCIE_LINK_WIDTH,
+	AMDGPU_METRICS_ATTR_PCIE_LINK_SPEED,
+	AMDGPU_METRICS_ATTR_XGMI_LINK_WIDTH,
+	AMDGPU_METRICS_ATTR_XGMI_LINK_SPEED,
+	AMDGPU_METRICS_ATTR_GFX_ACTIVITY_ACC,
+	AMDGPU_METRICS_ATTR_MEM_ACTIVITY_ACC,
+	AMDGPU_METRICS_ATTR_PCIE_BANDWIDTH_ACC,
+	AMDGPU_METRICS_ATTR_PCIE_BANDWIDTH_INST,
+	AMDGPU_METRICS_ATTR_PCIE_L0_TO_RECOV_COUNT_ACC,
+	AMDGPU_METRICS_ATTR_PCIE_REPLAY_COUNT_ACC,
+	AMDGPU_METRICS_ATTR_PCIE_REPLAY_ROVER_COUNT_ACC,
+	AMDGPU_METRICS_ATTR_PCIE_NAK_SENT_COUNT_ACC,
+	AMDGPU_METRICS_ATTR_PCIE_NAK_RCVD_COUNT_ACC,
+	AMDGPU_METRICS_ATTR_XGMI_READ_DATA_ACC,
+	AMDGPU_METRICS_ATTR_XGMI_WRITE_DATA_ACC,
+	AMDGPU_METRICS_ATTR_XGMI_LINK_STATUS,
+	AMDGPU_METRICS_ATTR_FIRMWARE_TIMESTAMP,
+	AMDGPU_METRICS_ATTR_CURRENT_GFXCLK,
+	AMDGPU_METRICS_ATTR_CURRENT_SOCCLK,
+	AMDGPU_METRICS_ATTR_CURRENT_VCLK0,
+	AMDGPU_METRICS_ATTR_CURRENT_DCLK0,
+	AMDGPU_METRICS_ATTR_CURRENT_UCLK,
+	AMDGPU_METRICS_ATTR_NUM_PARTITION,
+	AMDGPU_METRICS_ATTR_PCIE_LC_PERF_OTHER_END_RECOVERY,
+	AMDGPU_METRICS_ATTR_GFX_BUSY_INST,
+	AMDGPU_METRICS_ATTR_JPEG_BUSY,
+	AMDGPU_METRICS_ATTR_VCN_BUSY,
+	AMDGPU_METRICS_ATTR_GFX_BUSY_ACC,
+	AMDGPU_METRICS_ATTR_GFX_BELOW_HOST_LIMIT_PPT_ACC,
+	AMDGPU_METRICS_ATTR_GFX_BELOW_HOST_LIMIT_THM_ACC,
+	AMDGPU_METRICS_ATTR_GFX_LOW_UTILIZATION_ACC,
+	AMDGPU_METRICS_ATTR_GFX_BELOW_HOST_LIMIT_TOTAL_ACC,
+	AMDGPU_METRICS_ATTR_MAX,
+};
+
+enum amdgpu_metrics_attr_type {
+	AMDGPU_METRICS_TYPE_U8,
+	AMDGPU_METRICS_TYPE_S8,
+	AMDGPU_METRICS_TYPE_U16,
+	AMDGPU_METRICS_TYPE_S16,
+	AMDGPU_METRICS_TYPE_U32,
+	AMDGPU_METRICS_TYPE_S32,
+	AMDGPU_METRICS_TYPE_U64,
+	AMDGPU_METRICS_TYPE_S64,
+	AMDGPU_METRICS_TYPE_MAX,
+};
+
+enum amdgpu_metrics_attr_unit {
+	/* None */
+	AMDGPU_METRICS_UNIT_NONE,
+	/* MHz*/
+	AMDGPU_METRICS_UNIT_CLOCK_1,
+	/* Degree Celsius*/
+	AMDGPU_METRICS_UNIT_TEMP_1,
+	/* Watts*/
+	AMDGPU_METRICS_UNIT_POWER_1,
+	/* In nanoseconds*/
+	AMDGPU_METRICS_UNIT_TIME_1,
+	/* In 10 nanoseconds*/
+	AMDGPU_METRICS_UNIT_TIME_2,
+	/* Speed in GT/s */
+	AMDGPU_METRICS_UNIT_SPEED_1,
+	/* Speed in 0.1 GT/s */
+	AMDGPU_METRICS_UNIT_SPEED_2,
+	/* Bandwidth GB/s */
+	AMDGPU_METRICS_UNIT_BW_1,
+	/* Data in KB */
+	AMDGPU_METRICS_UNIT_DATA_1,
+	/* Percentage */
+	AMDGPU_METRICS_UNIT_PERCENT,
+	AMDGPU_METRICS_UNIT_MAX,
+};
+
+#define AMDGPU_METRICS_ATTR_UNIT_MASK 0xFF000000
+#define AMDGPU_METRICS_ATTR_UNIT_SHIFT 24
+#define AMDGPU_METRICS_ATTR_TYPE_MASK 0x00F00000
+#define AMDGPU_METRICS_ATTR_TYPE_SHIFT 20
+#define AMDGPU_METRICS_ATTR_ID_MASK 0x000FFC00
+#define AMDGPU_METRICS_ATTR_ID_SHIFT 10
+#define AMDGPU_METRICS_ATTR_INST_MASK 0x000003FF
+#define AMDGPU_METRICS_ATTR_INST_SHIFT 0
+
+#define AMDGPU_METRICS_ENC_ATTR(unit, type, id, inst) \
+	((unit) << AMDGPU_METRICS_ATTR_TYPE_SHIFT |   \
+	 (type) << AMDGPU_METRICS_ATTR_TYPE_SHIFT |   \
+	 (id) << AMDGPU_METRICS_ATTR_ID_SHIFT | (inst))
+
 /*
  * gpu_metrics_v1_0 is not recommended as it's not naturally aligned.
  * Use gpu_metrics_v1_1 or later instead.
@@ -1217,6 +1321,19 @@ struct gpu_metrics_v1_8 {
 	uint32_t			pcie_lc_perf_other_end_recovery;
 };
 
+struct gpu_metrics_attr {
+	/* Field type encoded with AMDGPU_METRICS_ENC_ATTR */
+	uint64_t attr_encoding;
+	/* Attribute value, depends on attr_encoding */
+	void *attr_value;
+};
+
+struct gpu_metrics_v1_9 {
+	struct metrics_table_header common_header;
+	int attr_count;
+	struct gpu_metrics_attr metrics_attrs[];
+};
+
 /*
  * gpu_metrics_v2_0 is not recommended as it's not naturally aligned.
  * Use gpu_metrics_v2_1 or later instead.
-- 
2.49.0

