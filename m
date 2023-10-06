Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB12E81E03
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Oct 2023 14:42:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6591410E50C;
	Fri,  6 Oct 2023 14:42:40 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45E4310E503
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Oct 2023 14:42:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H976IhBF1NcguPteqWMuNe+nxI8F/YlyiBkqQF+DrIz1fYP3TY9K35QsL555siq07ZmKrEcbKFm482DemAKdc7VLcOR8ucyWTyNYHACrJ6NGcg9GT3HOPvUxBOiwu9g40VlZ9E1ZTQmSa9L0I8WbU+idjpmQLiBqC6if2hm4fmLNhxf7a7NnIsla8CHozlIwbV+xf9JXvWD/xu22ewwMPcK/P2ohXFD724UCGtii+mqXaBSi/EazLIt9cx6D3dHg7Eq9zKYIcpBu4WxvZogb71bzagrJoWE++Y5G6xEV7T7LCVaNwkTcHHzn8FJAz+fgp7UO9oMhX/S8uFaGD1yygQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5pbKQt2Q4F67vNWHoLXvqoJDE7glUpaQPQkq4w0kus=;
 b=HYnbHOHCt3aQDOybJKRQqygM/ws3zT3JjhyRX61XdB+wSfIHwpHBYBHSp6yHyjv3vLNukhQ5pcxnU2R3IVuzWw6/kbwwPj8N0Mw1RGBClFcxEcJj/gPjkXWk6YHvogu7RGKWjgF+ECRGSm28NJsyRpAaOk/x5hWcRr1/0yi5a3/udYU3bOTnv12fX/ToUyHAD8vx1AarJ1eoqLkyVSJd+IadYWUALp/V6Na1zXlbDzzGYMzWghuVgN/ao9ARCY79SsnOREk6aNrSwWRmo0A8C5nm6hMw9NC67mYlmYVWPQOakR546rFX4DtDrmieVuWie5iEPElrnxYaYMn1jLXnTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5pbKQt2Q4F67vNWHoLXvqoJDE7glUpaQPQkq4w0kus=;
 b=kJV7gtXqQwTMZtUahXX1UQLQt4hhyDcvC6rgoOvLbnGje4hRRQd2BiUyzp8iXY2hz+Hsd/Zx+pEOZ3+honzk1uwxn8n//Mwq4ZqESnyqs/eHyUlGjif6VOYxTpPoM0+tabQbRKjqR1mWNwug/8tBBe9/neYselCjBGd/R8HvClk=
Received: from SJ0PR05CA0046.namprd05.prod.outlook.com (2603:10b6:a03:33f::21)
 by CYYPR12MB8872.namprd12.prod.outlook.com (2603:10b6:930:c8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22; Fri, 6 Oct
 2023 14:42:34 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:33f:cafe::ff) by SJ0PR05CA0046.outlook.office365.com
 (2603:10b6:a03:33f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.29 via Frontend
 Transport; Fri, 6 Oct 2023 14:42:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.17 via Frontend Transport; Fri, 6 Oct 2023 14:42:33 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 09:42:31 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/3] drm/amd/pm: Add gpu_metrics_v1_4
Date: Fri, 6 Oct 2023 22:41:39 +0800
Message-ID: <20231006144140.566546-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231006144140.566546-1-asad.kamal@amd.com>
References: <20231006144140.566546-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|CYYPR12MB8872:EE_
X-MS-Office365-Filtering-Correlation-Id: 98bb8de1-9aab-4f58-7eac-08dbc67a79f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zs1Ik8wbuqlAUxhZrChn3xAy/HrS8ELBzCgyIrtYzyVxOcJEM2RA3sgHibKRg7WHJ0+aIhLh2JA020Qz/ZESYUxhCsQssgOIBZwhqc7/VZWBA1As8BczbwNtOUsDYfHWCDQotgOxK0/JByMhGrEJ2tYwL8wkmOAM0weJAnygCQEoTgUC0LEYjPI1/xX6wV7aGI6kmqLNvW+Zz+dGpQnaAaMT2JzvjHnm0IDxZiXwgR12TIQ81iCkosphVws60C59tBYL6H5cdiKV9Civ44UeCAHkgiioy9830w0afSYrCvBx8TmHxTdVNZV8eJjVxmbfSjcAQSKfua2SEs1W2C8CO01B0+fsI69nXgOhIY2v9DnpAatJTP5X0vOSo0ZHxTubKXBeOnnyh44J+z7ghllgQBjUmWYRKd6so2CEX+SFt33WtWUKL+Ul3CrF/PR2Qk9n0YMbw1oHY/CEa8Eg4xpmR7d4SrXEx93OHFbfQCfDEq54phsWcAL/N9qKEjGZe9O/rbOFTiRIc2/bnrI8HNzua0bP/ZTqKNu1DP2uL6bmi0a+GhsKhEnzDzZV9G8ayONvLeKfK2CLf97FOcCLBBb4Hihp+mKdi36GczOpS1/lDvWpx3dP2QArwh2zdASz/78TS9fuj66NvaS15rJL4xYjrdmE7wxMdRTGUXdKy25tF2F8T1/J3wM7AOpvZcnyrEG+pEZmNIbz/hELEW0PAfQmaXw+Yk+hwGfN07j8QUU7vEsyraEB85nXsHZqq2hYSPJPZ99w0EXIKSGMjfvI6QLgdA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(64100799003)(186009)(82310400011)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(36860700001)(356005)(82740400003)(81166007)(40480700001)(86362001)(40460700003)(7696005)(478600001)(44832011)(1076003)(36756003)(4326008)(316002)(54906003)(6916009)(70206006)(47076005)(2616005)(2906002)(70586007)(5660300002)(16526019)(8676002)(8936002)(426003)(26005)(41300700001)(336012)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 14:42:33.5296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98bb8de1-9aab-4f58-7eac-08dbc67a79f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8872
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

