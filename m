Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084D9E95A91
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 14:53:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4985A10E136;
	Mon,  9 Oct 2023 14:53:39 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A38D10E279
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 14:53:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLuIsOullImUod3e2maGXKI616UeqI4eftYlGZ/Ga0QQJRsPVJU6a8K5m/ksDeIh3BYgo9swN42LAPrSh0uF9rvIiAYHIJiQzsgccmYorRbQJHzaf/A10k594ZBVOs6/7nLDc/jopZFe9Dbx/Jlp/IQIuM8QON4AnJE0fYujR5O/rQun+CGIfBt+TmTzHwZuDYy2unMvfQ59QSlxfBbK363QBb5dp6p4/aYY1Qarq90tpDPc2GSj++L+vKOTJyRfdELJsnF3SbPkStusnNGMPMZ+H3SKQhINUEkRDwcqKKx5FmmdkXS3Fliv+PYLgq7rCGTNk1MrCa+sqRomLwWktA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5pbKQt2Q4F67vNWHoLXvqoJDE7glUpaQPQkq4w0kus=;
 b=bhD5TARkNQSNYIjoPdXAaRLDDDvcGVhDfDg8j7hnC065YhqFVkYtU49wUbW4IchGDBThA0eLWRML5rh6VaNOV/avSFpAl3raWJjAcIryLgCraQsk4EWk54s3Mi54pL+pyeHvBdVtdYIUJ7QMa/LBE0xGSJyJP2RQydk4tMSxL30S3itrdkwKwHPzJEhW9OWy/6PdSykwSi48DNvAbZdJxq4fRotoXA8KCCkmHR/+n12FON8ZCd/ga3znKsrsEIjVnHR5dHTOy47+Q3y7KvNL+gaRR/9sJBwW76vCZlBOhyjDkviHG9/AU5u8ubTNkP4wcdKxe2zLS01bxGjz9cTjQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5pbKQt2Q4F67vNWHoLXvqoJDE7glUpaQPQkq4w0kus=;
 b=hFwS3wtDRPSJjFieB8DpT7hk7A3YXL2rROwxuMGBoNVYUnmW4a74kSYjrVOK/5E2cl8A3uiWRcl5zQ2ljBDn9ZHWgS6P/jNZ7ZfFtDqvhm564Kgc/iUpaoFseeyRb9xD/0/kv3dmgraHjKuXu0FOsZ/uD4lFiDqNmXz0KKGdJyM=
Received: from BLAPR03CA0001.namprd03.prod.outlook.com (2603:10b6:208:32b::6)
 by LV3PR12MB9117.namprd12.prod.outlook.com (2603:10b6:408:195::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 14:53:32 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::1) by BLAPR03CA0001.outlook.office365.com
 (2603:10b6:208:32b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Mon, 9 Oct 2023 14:53:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 9 Oct 2023 14:53:32 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 09:53:30 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 2/3] drm/amd/pm: Add gpu_metrics_v1_4
Date: Mon, 9 Oct 2023 22:53:14 +0800
Message-ID: <20231009145315.597629-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009145315.597629-1-asad.kamal@amd.com>
References: <20231009145315.597629-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|LV3PR12MB9117:EE_
X-MS-Office365-Filtering-Correlation-Id: b66bf510-98f1-42cc-fe6a-08dbc8d78208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VIsVlX/uv2bVcZa0nI1Wxt8bvPZLyGigeGCQ1fIfg89atDKMhoorO9fytxhR0ANnBs+ibRKtoUD6C3OCOeHJCEKuvypm2Ng2FMce4S02fM5tg/SM4HBnIldXr0NV7YhTnuyyghYMn9znzqdSM4nwPBr7DsYAQReboYnHG7NiJU0CPjQQSy+PMsZAQnvh/ai+zcK1ii5xAVxmV/gWaga4Atz68lsOIARwMPGT2qgGExKu/VL5AwFn15/CPRPQZf+rfTdPyF+mfxmgX9h/kESBuIzLpVYWKz/AghNG2d2rIWHsMqGmB1Vx/jo8vZk494zAGItaQ+n1XtMSFCymv84zfaT8Ebb9Y+E/qiI6brcYObhfggV2NCsfG35tkq7hGkHgjT0sncjDgFnggq3511sWXc9Z6QBctFYP1xR++65cPiXWSwRgJXfq8E1YiSHXY3KarDGwWd6+eurTuo8RivA2jEOTcb+pS7hSRyBTcsgDYg24J9heu7vmt24bZJdklIUg4koFKHpn0xr9usBKQpelpHhUbLBmXMHGlSLeeG+76Bt9x13JICW6Z/9j95oumPvc8VX38bModUkotMQ8YaXf7bsOu4xFyHfnexCAt9MkrHqTpv+l9KC07E6x72azoMPJvfYz2W4XKrlPC9ol2QD3iAalMGUmjY1L6yJXJ//xk3D1CuJ138N5Bxt+H/wbLZrJOgwpqCWfU3fj/KH5+jgorapqpv8cHTSTiuRKBjJyGoLs3c8rTFG6Fg+0a66poai0rzkJTScROnmydO7cDQQG7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(136003)(346002)(396003)(230922051799003)(82310400011)(64100799003)(1800799009)(186009)(451199024)(46966006)(40470700004)(36840700001)(336012)(26005)(1076003)(16526019)(426003)(2616005)(8936002)(7696005)(478600001)(36860700001)(6666004)(41300700001)(47076005)(8676002)(44832011)(83380400001)(4326008)(2906002)(54906003)(70206006)(70586007)(316002)(6916009)(5660300002)(81166007)(356005)(36756003)(86362001)(82740400003)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 14:53:32.7739 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b66bf510-98f1-42cc-fe6a-08dbc8d78208
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9117
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
Cc: le.ma@amd.com, Lijo.Lazar@amd.com, asad.kamal@amd.com, shiwu.zhang@amd.com,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add new gpu_metrics_v1_4 to acquire XGMI data transfer,
pcie bandwidth & Clock lock status

v2:
Add pcie error counter to gpu metric table v1_4

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    | 76 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  3 +
 2 files changed, 79 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index e0bb6d39f0c3..eeb547d79eac 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -313,6 +313,10 @@ enum pp_xgmi_plpd_mode {
 #define XGMI_MODE_PSTATE_D0 1
 
 #define NUM_HBM_INSTANCES 4
+#define NUM_XGMI_LINKS 8
+#define MAX_GFX_CLKS 8
+#define MAX_CLKS 4
+#define NUM_VCN 4
 
 struct seq_file;
 enum amd_pp_clock_type;
@@ -696,6 +700,78 @@ struct gpu_metrics_v1_3 {
 	uint64_t			indep_throttle_status;
 };
 
+struct gpu_metrics_v1_4 {
+	struct metrics_table_header	common_header;
+
+	/* Temperature (Celsius) */
+	uint16_t			temperature_hotspot;
+	uint16_t			temperature_mem;
+	uint16_t			temperature_vrsoc;
+
+	/* Power (Watts) */
+	uint16_t			curr_socket_power;
+
+	/* Utilization (%) */
+	uint16_t			average_gfx_activity;
+	uint16_t			average_umc_activity; // memory controller
+	uint16_t			vcn_activity[NUM_VCN];
+
+	/* Energy (15.259uJ (2^-16) units) */
+	uint64_t			energy_accumulator;
+
+	/* Driver attached timestamp (in ns) */
+	uint64_t			system_clock_counter;
+
+	/* Throttle status */
+	uint32_t			throttle_status;
+
+	/* Clock Lock Status. Each bit corresponds to clock instance */
+	uint32_t			gfxclk_lock_status;
+
+	/* Link width (number of lanes) and speed (in 0.1 GT/s) */
+	uint16_t			pcie_link_width;
+	uint16_t			pcie_link_speed;
+
+	/* XGMI bus width and bitrate (in Gbps) */
+	uint16_t			xgmi_link_width;
+	uint16_t			xgmi_link_speed;
+
+	/* Utilization Accumulated (%) */
+	uint32_t			gfx_activity_acc;
+	uint32_t			mem_activity_acc;
+
+	/*PCIE accumulated bandwidth (GB/sec) */
+	uint64_t			pcie_bandwidth_acc;
+
+	/*PCIE instantaneous bandwidth (GB/sec) */
+	uint64_t			pcie_bandwidth_inst;
+
+	/* PCIE L0 to recovery state transition accumulated count */
+	uint64_t			pcie_l0_to_recov_count_acc;
+
+	/* PCIE replay accumulated count */
+	uint64_t			pcie_replay_count_acc;
+
+	/* PCIE replay rollover accumulated count */
+	uint64_t			pcie_replay_rover_count_acc;
+
+	/* XGMI accumulated data transfer size(KiloBytes) */
+	uint64_t			xgmi_read_data_acc[NUM_XGMI_LINKS];
+	uint64_t			xgmi_write_data_acc[NUM_XGMI_LINKS];
+
+	/* PMFW attached timestamp (10ns resolution) */
+	uint64_t			firmware_timestamp;
+
+	/* Current clocks (Mhz) */
+	uint16_t			current_gfxclk[MAX_GFX_CLKS];
+	uint16_t			current_socclk[MAX_CLKS];
+	uint16_t			current_vclk0[MAX_CLKS];
+	uint16_t			current_dclk0[MAX_CLKS];
+	uint16_t			current_uclk;
+
+	uint16_t			padding;
+};
+
 /*
  * gpu_metrics_v2_0 is not recommended as it's not naturally aligned.
  * Use gpu_metrics_v2_1 or later instead.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 12618a583e97..6e57c94379a9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -986,6 +986,9 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev)
 	case METRICS_VERSION(1, 3):
 		structure_size = sizeof(struct gpu_metrics_v1_3);
 		break;
+	case METRICS_VERSION(1, 4):
+		structure_size = sizeof(struct gpu_metrics_v1_4);
+		break;
 	case METRICS_VERSION(2, 0):
 		structure_size = sizeof(struct gpu_metrics_v2_0);
 		break;
-- 
2.42.0

