Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2838DC41535
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Dec 2023 15:27:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C156F10E7E1;
	Fri, 22 Dec 2023 15:27:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D93CD10E7E1
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Dec 2023 15:27:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jb2JwQU1W+IHoxGiFa3zYegNs49KxEVJupO15pxK9jr3BXgknjhUTyS4hlZHd/1d54b0mnHK7N0t1qdgQffoZ0difhSC/JFuNYPxubDbp1XZOMZDuCCIDtSTwNA9nem0OmkPXFncHjv8/mfeECWv8hJC/er2+OrqCn4R84iorvNU0O+M/sK/n5VdeX9AN8tuj7cfpU1ce19DaTAy/E9nkAI2cc6rOPMG8UUjxCzQgPS8U4lBsmF0OWlXIZfRzIjX601FZo74jHLE/IHNw87DQ26ihs79qA7dkJWeTqBw06w9aglULRGNzHsbo2zbMMHZE8cicMWIvbiplOgWQxTzAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFpLwGfOTCvxir8sNmIevSAe46BUmgD3Wve+a1b6hVQ=;
 b=UoJvn0lrqM0lnZ8rKBqaRpT8Wv4zOmycyaSCh7KsQHJ6gR0XqiNRSy+/aMISRNR1cKhMYvqIyH4cdl6q+rfPFBMRr8TNgudikiOdklpEJ45S98WrzPSkiNp0q3RglnIj6BeD5zW46N0cy7JkeRdXY/lBBoPj/44PHQ9oZwACbUr8HGy8nYIzfVkGxTBSPrvQLu6vCdrZYAu7brvG47xzbFv1fd6Fqn4wtnLDmbY7/87OuRTsPnp9PmDwdFXaMp6ReW63afaVBlGhoukiNa2Wglx0nBfGgsExyyc/t8T0GVxl/6BmoMVoXixB5X2a8kE23OPekewCGgxgDZFjl9aT5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFpLwGfOTCvxir8sNmIevSAe46BUmgD3Wve+a1b6hVQ=;
 b=KNTMDB+e2KkTga/V20Ii+ZOG9ImHQEMBnlpBW103wZKYLhzCr7Pgg/itJs9axS4RRtBPZCJD/mY6PL1C2ZudYssF0Pe7xChSfOQr9IDS8NotFWwOa6I65DqdZBY6WK303D8wZV0aDVHx0C88IEGg4oviY0rdgn/C2SvX57CBK98=
Received: from MW4PR03CA0028.namprd03.prod.outlook.com (2603:10b6:303:8f::33)
 by IA1PR12MB7590.namprd12.prod.outlook.com (2603:10b6:208:42a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 15:27:48 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:303:8f:cafe::99) by MW4PR03CA0028.outlook.office365.com
 (2603:10b6:303:8f::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21 via Frontend
 Transport; Fri, 22 Dec 2023 15:27:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.21 via Frontend Transport; Fri, 22 Dec 2023 15:27:48 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 22 Dec
 2023 09:27:45 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
Subject: [PATCH 3/4] drm/amd/pm: Add gpu_metrics_v1_5
Date: Fri, 22 Dec 2023 23:27:26 +0800
Message-ID: <20231222152727.411440-3-asad.kamal@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231222152727.411440-1-asad.kamal@amd.com>
References: <20231222152727.411440-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|IA1PR12MB7590:EE_
X-MS-Office365-Filtering-Correlation-Id: 97d34258-dc54-4ed6-f08d-08dc03028de6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P3d0GQV7AuUp7+8ffjMZrS8ynimxyABRK46XAcspRS3H5Dphejcvvr4aIaBEmmjGhOO5mcoeJXXh2OStB5dOW/e06U6Ixx8krqzFpTqdy7eUeSp2clxy27vER1rfRsOBHT4wkQMNewJmEK5TNo/ySsQsRzahpAiYv9r3nD80IQIxn04Lj3B1wamBMdBrPpYJNGEUf64xI80lEfl/5dyj1lCHI6nVM0Cf7NDrW30G/1b2rdRXmacaR7XBgseNJxMdIZEmxHabw2SYwORMstqR5xZ6UJP72Jgu3pzHH51/stt3VEi57R5LehYtjxdcyWoqrDJ9vg0QC4wvER8m8Uct1TDVTsyy98i1lZ/U/8Tlv0bbsQZdkLJoOa+caOjkP3rWQj5xay5CcQBLF3uF+MDUTDz9ZxGkzB9mg3aFSn+zt+KBAm+f+aSe6RC5Vxxsn432HmDA3Ad2c/QHRk1VsKdEfIR/bBA3v9iruiywJ6ROjvG1hI4Oee0fc+D9Fiy+kFeu2gLJFvq01s9TjL+AuurAlWTg7UAVdiNPcq5mRyCRNWzXZkbdPYJtkXIvAFSt8Nscr6xkr1CRWZgzv2KiBI3n5IiDFgk/QXSqwoEnvhATEQXW12DlrYscQxttYwI6kAoymgPqtykmSt9E8K1IKKFazIhne4JqvdfMomCM4poWn2IZhYnNgDx/v1Ca4mbgynCUG2ZruLyxj1JAMtZ4DsmK9m476ngRnbB2JNXmQTZhpYOSo4T0SzxerKcq7UmRWZ6XP1mOpQqjhqrxSFz+6K9UOw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(346002)(396003)(136003)(230922051799003)(1800799012)(82310400011)(64100799003)(186009)(451199024)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(26005)(2616005)(16526019)(7696005)(8936002)(478600001)(6636002)(4326008)(8676002)(54906003)(110136005)(70206006)(316002)(6666004)(1076003)(70586007)(2906002)(36860700001)(81166007)(41300700001)(336012)(426003)(47076005)(44832011)(356005)(82740400003)(5660300002)(83380400001)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 15:27:48.3589 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d34258-dc54-4ed6-f08d-08dc03028de6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7590
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
Cc: sepehr.khatir@amd.com, shiwu.zhang@amd.com, daniel.oliveira@amd.com,
 le.ma@amd.com, donald.cheung@amd.com, asad.kamal@amd.com,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add new gpu_metrics_v1_5 to acquire vcn/jpeg activity
& pcie nak error counters

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    | 80 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  3 +
 2 files changed, 83 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 36a5ad8c00c5..edcb85560ced 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -318,6 +318,7 @@ enum pp_xgmi_plpd_mode {
 #define MAX_GFX_CLKS 8
 #define MAX_CLKS 4
 #define NUM_VCN 4
+#define NUM_JPEG_ENG 32
 
 struct seq_file;
 enum amd_pp_clock_type;
@@ -775,6 +776,85 @@ struct gpu_metrics_v1_4 {
 	uint16_t			padding;
 };
 
+struct gpu_metrics_v1_5 {
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
+	uint16_t			jpeg_activity[NUM_JPEG_ENG];
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
+	/* PCIE NAK sent  accumulated count */
+	uint32_t			pcie_nak_sent_count_acc;
+
+	/* PCIE NAK received accumulated count */
+	uint32_t			pcie_nak_rcvd_count_acc;
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
index 001a5cf09657..00cd615bbcdc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -989,6 +989,9 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev)
 	case METRICS_VERSION(1, 4):
 		structure_size = sizeof(struct gpu_metrics_v1_4);
 		break;
+	case METRICS_VERSION(1, 5):
+		structure_size = sizeof(struct gpu_metrics_v1_5);
+		break;
 	case METRICS_VERSION(2, 0):
 		structure_size = sizeof(struct gpu_metrics_v2_0);
 		break;
-- 
2.42.0

