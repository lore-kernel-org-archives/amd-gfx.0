Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B3FCAC58E
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Sep 2025 08:01:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D151D10E326;
	Mon, 15 Sep 2025 08:01:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mC/zVCVH";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7280710E326
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 08:01:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ag/f5XWcDgb1QxIuG3ExZnUIL48/y+tH9csdVZd0HqnRhGGMTvIscNDreZIRX6/e+j63af/CvnH1dbpvU8DR87NlxAS2g6ky7aAqplhikV+WPDlmaXzXMJULOt3H8OipeHwAWfhbx4fZrYQdpJcfC9moZQSOrpNARbhw5B0X1Gy369LkTX28qUGm4jj/VJY3NvCfdKI6rrVNcW7slgYOKIqjkN2ugE/gpb46psJUA7IEd8uu3HN/4thvlkOHhJcmnAtvA4tz7YaykhQ80w4seo1bQGIGfVwF4SEyZMP/DwMf+g9SBRzwSKPmyZRXm7PV663aIDlZQN59dnSY2N79Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tX4xtHRfNgWPRjVuY2mlEBto+s4KpOwIe4uKUqaxvL8=;
 b=Sb8ELxnuiIq6PsTexWr6THUTMOg2nIm6B2TsqMTbCjBj0DlZ6x197Xxcq7BBJE1gEtl+fdOGUTiRMn2MxaGTPuXpu9baMCeFEqcGqg3A2/nH7l+AknfpTmYOMF/oHNNigXKgSXJIFit6l7HXqSPwpDgnY3J26yjJCn95XGZa8Pi5UVfmaiVGCjZ9LESGkoy/mvkIA0UHpQQ9A0ez0gqL6G5hvZu9f/0hOEpVbx0LHOS5XmLsCoiyOlvXm+jCRXyEw44P4Od6hE90o7r+6Wv1EJX40/AyD6Qh6nNzYAAt3MeYeW1ZZbPTpFEPyTTUARtpalFJMj/SxOQKV1fFvQ2gHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tX4xtHRfNgWPRjVuY2mlEBto+s4KpOwIe4uKUqaxvL8=;
 b=mC/zVCVHCcok6UrK0sUbFK95E0Vz+B//sEa476RgdyQzY695YkemRfX58qGUhzkOEZPNNPgvfmhH2eBy9Q2lZfskmPHsvu9RX3myZYuse25ECUWsxO1Z1qHuYq9bvdleigZ99kWd51TagpTgE5uFYdAgNXvCZiysbEmRghNhWVo=
Received: from MW3PR05CA0013.namprd05.prod.outlook.com (2603:10b6:303:2b::18)
 by CY1PR12MB9674.namprd12.prod.outlook.com (2603:10b6:930:106::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Mon, 15 Sep
 2025 08:01:50 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:303:2b:cafe::4f) by MW3PR05CA0013.outlook.office365.com
 (2603:10b6:303:2b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.11 via Frontend Transport; Mon,
 15 Sep 2025 08:01:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 08:01:50 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Sep
 2025 01:01:48 -0700
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, Asad Kamal
 <asad.kamal@amd.com>
Subject: [PATCH v4 1/7] drm/amdgpu/pm: Add definition for gpu_metrics v1.9
Date: Mon, 15 Sep 2025 13:26:30 +0530
Message-ID: <20250915080123.3024297-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250915080123.3024297-1-lijo.lazar@amd.com>
References: <20250915080123.3024297-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|CY1PR12MB9674:EE_
X-MS-Office365-Filtering-Correlation-Id: 130d550b-32bb-400b-edbe-08ddf42e2063
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fqFixpm8zG3ywNlDawK0ERu2AIMPFsyW/6yBghd7oF5xqGbICNtZKg1vzDtp?=
 =?us-ascii?Q?p3jYPLekI3L3/lB8IrWv5EKDiVPeGxSUrmXUH29R369yU2cqN3kwPoOtehR0?=
 =?us-ascii?Q?ELrWz0HuCXqDxUZQOPUm2/FkU1mr+lvVUvW4HDCLXXwCG3ElQ4D3bFYpc0ho?=
 =?us-ascii?Q?zK4iniL72maoQ+T7RpM0dP6JzeravWVh7Mpv26skH923wVBabLJTGxeRDIt1?=
 =?us-ascii?Q?crhLPIQ9XplM/72LY2jyMUBd8r6SvWIyvKFNRyZ0Q97CAxpkW4U8ZvjQG2EN?=
 =?us-ascii?Q?N2s554lL6mUaU98oZnBbSFEccGxEJheh2kvBfUN4e+oLjJgcxWc8vQVSUfUi?=
 =?us-ascii?Q?2086Mc8oa7Ri9iY4FkfklOhFUXM27MiPPWvMnA2htvTA7L9b7Fs+ENl6yX/0?=
 =?us-ascii?Q?UkPbfL5QnHDEoe9RxnTrpEBJEaJuQzZ7DMGJtGGiOCmQIcbGBSqXsOVWjoP0?=
 =?us-ascii?Q?cYjQPTRxKvOO2dllNMV9z+gmR8p7BV33UbloazaOdH6GUF7IUh8ZYlcujz9G?=
 =?us-ascii?Q?kkeICNyt5zz16Gunlr5JDdQgbSvDfS/X21ZOtKdoAcRPsXUBLRjx4UpJkJI9?=
 =?us-ascii?Q?IKackHwawUkUw4GnYQO18ejbrjfU/vfw5xVpwa4P8M7u9cCW0CzcHMuZ+Gk6?=
 =?us-ascii?Q?ppH+8jbqL8hP95nBtrjsHuTc8rYz1gQOF+azoe6yFs5c7C+hXwQexX43Rjfk?=
 =?us-ascii?Q?5aaeJ6snRQzc2bsMEvLvLAEyp+7NS5pX4mnpeGxf4mex/j5DH3npqmsC2GOi?=
 =?us-ascii?Q?CEI0xqBzIICFsXgy8JRaRiFooXjfWt7fY9FXNYlH9jwpA+LWKtwPajcjNEFS?=
 =?us-ascii?Q?9u4jbMA78I2rVPEe+tSSj0OtjObApm1eXVo94eDFlHOnTA4wxY6HPAEW6l37?=
 =?us-ascii?Q?v6Butc6j7XCRmXggPmfTomvIq8q1TDosfjuo0rmRNP5pCN0YAb4Vsekj8jZl?=
 =?us-ascii?Q?s0T6OBQ5StX+z7vUfNvr3j8woBpoGrmBJ4Is2/tDWOw8zwx34vx0R7dAoR1e?=
 =?us-ascii?Q?hBA+d5tChkuPdcZ+kiONzDf+cfgYoZ22ORfRDI5C120/1iGGiW10z4dN2Maz?=
 =?us-ascii?Q?VuCjH5r0e68mfboSYnT7N0qRbHTsu7h2Sw68FMTOQp25MklAjn+sOE7DUg38?=
 =?us-ascii?Q?RJBHrJz8fAmTX+c7S/baTGGNrOgpnwQHGLQaNq4/RSzwNC197RSB3MnpcvED?=
 =?us-ascii?Q?URr1DiiJpc0Se5//mbTvSYz3Yl/4LFaMExqXK2ma3sR2OTnJZXGHoiLXOjLJ?=
 =?us-ascii?Q?dgWcBRe/YN0A84fVpwm9ybv2tfNKaejjFGRhKU3V5eCMMrLx+ZRvoWEcUs/o?=
 =?us-ascii?Q?Vll6wGOl0kdJbEzN8aa1rCT0FDhdKpIo9N3A7OHoLvyi6Q38KL0uk7vGbHj0?=
 =?us-ascii?Q?f0D+cP4m2T8YnuKHXZplWgTsjJWg6Gtjxz+qIl1BdUXHs1IOBPAJCtBFOEDh?=
 =?us-ascii?Q?iSfU/NKQErqDXzMUXjFtMfOqiZlMO5sowwoOlUvt1La3/2+R8aRtT5f7SZL8?=
 =?us-ascii?Q?EAIxUkvOgTAFluFvWaL05rwV/cKTQCGg4XAf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 08:01:50.4225 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 130d550b-32bb-400b-edbe-08ddf42e2063
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9674
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
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
v2: Add unit field and change encoding to 64-bit.
v3: Fix unit encoding
v4: Rename to ATTR_ID (Kevin)

 .../gpu/drm/amd/include/kgd_pp_interface.h    | 117 ++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 2f7e4b5bebf3..c98525b85d59 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -528,6 +528,110 @@ struct metrics_table_header {
 	uint8_t				content_revision;
 };
 
+enum amdgpu_metrics_attr_id {
+	AMDGPU_METRICS_ATTR_ID_TEMPERATURE_HOTSPOT,
+	AMDGPU_METRICS_ATTR_ID_TEMPERATURE_MEM,
+	AMDGPU_METRICS_ATTR_ID_TEMPERATURE_VRSOC,
+	AMDGPU_METRICS_ATTR_ID_CURR_SOCKET_POWER,
+	AMDGPU_METRICS_ATTR_ID_AVERAGE_GFX_ACTIVITY,
+	AMDGPU_METRICS_ATTR_ID_AVERAGE_UMC_ACTIVITY,
+	AMDGPU_METRICS_ATTR_ID_MEM_MAX_BANDWIDTH,
+	AMDGPU_METRICS_ATTR_ID_ENERGY_ACCUMULATOR,
+	AMDGPU_METRICS_ATTR_ID_SYSTEM_CLOCK_COUNTER,
+	AMDGPU_METRICS_ATTR_ID_ACCUMULATION_COUNTER,
+	AMDGPU_METRICS_ATTR_ID_PROCHOT_RESIDENCY_ACC,
+	AMDGPU_METRICS_ATTR_ID_PPT_RESIDENCY_ACC,
+	AMDGPU_METRICS_ATTR_ID_SOCKET_THM_RESIDENCY_ACC,
+	AMDGPU_METRICS_ATTR_ID_VR_THM_RESIDENCY_ACC,
+	AMDGPU_METRICS_ATTR_ID_HBM_THM_RESIDENCY_ACC,
+	AMDGPU_METRICS_ATTR_ID_GFXCLK_LOCK_STATUS,
+	AMDGPU_METRICS_ATTR_ID_PCIE_LINK_WIDTH,
+	AMDGPU_METRICS_ATTR_ID_PCIE_LINK_SPEED,
+	AMDGPU_METRICS_ATTR_ID_XGMI_LINK_WIDTH,
+	AMDGPU_METRICS_ATTR_ID_XGMI_LINK_SPEED,
+	AMDGPU_METRICS_ATTR_ID_GFX_ACTIVITY_ACC,
+	AMDGPU_METRICS_ATTR_ID_MEM_ACTIVITY_ACC,
+	AMDGPU_METRICS_ATTR_ID_PCIE_BANDWIDTH_ACC,
+	AMDGPU_METRICS_ATTR_ID_PCIE_BANDWIDTH_INST,
+	AMDGPU_METRICS_ATTR_ID_PCIE_L0_TO_RECOV_COUNT_ACC,
+	AMDGPU_METRICS_ATTR_ID_PCIE_REPLAY_COUNT_ACC,
+	AMDGPU_METRICS_ATTR_ID_PCIE_REPLAY_ROVER_COUNT_ACC,
+	AMDGPU_METRICS_ATTR_ID_PCIE_NAK_SENT_COUNT_ACC,
+	AMDGPU_METRICS_ATTR_ID_PCIE_NAK_RCVD_COUNT_ACC,
+	AMDGPU_METRICS_ATTR_ID_XGMI_READ_DATA_ACC,
+	AMDGPU_METRICS_ATTR_ID_XGMI_WRITE_DATA_ACC,
+	AMDGPU_METRICS_ATTR_ID_XGMI_LINK_STATUS,
+	AMDGPU_METRICS_ATTR_ID_FIRMWARE_TIMESTAMP,
+	AMDGPU_METRICS_ATTR_ID_CURRENT_GFXCLK,
+	AMDGPU_METRICS_ATTR_ID_CURRENT_SOCCLK,
+	AMDGPU_METRICS_ATTR_ID_CURRENT_VCLK0,
+	AMDGPU_METRICS_ATTR_ID_CURRENT_DCLK0,
+	AMDGPU_METRICS_ATTR_ID_CURRENT_UCLK,
+	AMDGPU_METRICS_ATTR_ID_NUM_PARTITION,
+	AMDGPU_METRICS_ATTR_ID_PCIE_LC_PERF_OTHER_END_RECOVERY,
+	AMDGPU_METRICS_ATTR_ID_GFX_BUSY_INST,
+	AMDGPU_METRICS_ATTR_ID_JPEG_BUSY,
+	AMDGPU_METRICS_ATTR_ID_VCN_BUSY,
+	AMDGPU_METRICS_ATTR_ID_GFX_BUSY_ACC,
+	AMDGPU_METRICS_ATTR_ID_GFX_BELOW_HOST_LIMIT_PPT_ACC,
+	AMDGPU_METRICS_ATTR_ID_GFX_BELOW_HOST_LIMIT_THM_ACC,
+	AMDGPU_METRICS_ATTR_ID_GFX_LOW_UTILIZATION_ACC,
+	AMDGPU_METRICS_ATTR_ID_GFX_BELOW_HOST_LIMIT_TOTAL_ACC,
+	AMDGPU_METRICS_ATTR_ID_MAX,
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
+#define AMDGPU_METRICS_ENC_ATTR(unit, type, id, inst)      \
+	(((u64)(unit) << AMDGPU_METRICS_ATTR_UNIT_SHIFT) | \
+	 ((u64)(type) << AMDGPU_METRICS_ATTR_TYPE_SHIFT) | \
+	 ((u64)(id) << AMDGPU_METRICS_ATTR_ID_SHIFT) | (inst))
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

