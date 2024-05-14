Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C64C25B75
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 06:23:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BD5A10E0C5;
	Tue, 14 May 2024 06:23:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V7tIclQ3";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF61C10E0C5
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 06:23:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=En7Wmcb9E3dZoZceTy5GRDGATQNrZSmr0fpPV5E5LFjW+9GbfWeGQcZOLJxwHRRNUjCVelNYzqH9+p0vd/mVfOVAkTNjw77SJPj8dDdzGhKe5Nz7gWE3tag7EISpCawwAu6iBazJslDmDx13gRDAe6/rAcrc1Q2gS8z0qFx6ZmpLwFLbmnNMsvzW1GjOIJRZPB/3GOfXCu5i0w3VEYPcDko+aSippwVSt9gAQcnoVnF9FidW2o7bLXW7+9DP9qvKVuUmdbblXJEuvDW7dixZlKr8IhfQ/gTqJewUIDhRFys4nkb9BOj6kdbvAdjgdSKVm5SzISAtIK5571gBmA1L5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlykI1eT5N6/r3D68MWsrAp/GDcfoSGsPOLJP/FQR7A=;
 b=Hi6CpCnto3reGV8DKxmKTyDhZKtWSYDThA9kyJI8ipSzsbz3r4Vy6JqsvSMlecUwXOVbNfiNhIMwBj2r6+AiN5hnzldMdFfIAdlN9npNqTOWJk2TuJ2xE/PIL/yenogeZlrjMQ4uyy8c+yArKAZ4kXqtManvuku7qCTb2lEqn2nDHfu4wZ8mRiKjKEp/H/SN/MrbNSmhMiyzrqN+XObGfZ0dPAxKc4gDJKxTj0wk7FNEFS16Q5BRRT+aenE63gl1cmoSkabZYh/oRq9EHPK967yFwQw9ruOg/RaqbKILsZ1zxNF7Z3hpiwDDmnACFNT9vEDscGLygGiMd7Mhy+2phQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlykI1eT5N6/r3D68MWsrAp/GDcfoSGsPOLJP/FQR7A=;
 b=V7tIclQ3HR03nEv5XcJ6gX6vHHx+ngS1IRzl3v6wNc2rjfGsHqyvtIz306F6Uynwh6kBPdbdTlUQM+PWKDQvlPPfJ+PGrztQHdisYT8zxys9HlULeYhzxtR6GiM/WKduuTur+u1/QkcEQnqvEJqf2B1cyxA5bOtyT8rG5kBN0pg=
Received: from BN8PR07CA0021.namprd07.prod.outlook.com (2603:10b6:408:ac::34)
 by IA0PR12MB7698.namprd12.prod.outlook.com (2603:10b6:208:432::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 06:23:17 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:ac:cafe::ed) by BN8PR07CA0021.outlook.office365.com
 (2603:10b6:408:ac::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Tue, 14 May 2024 06:23:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Tue, 14 May 2024 06:23:17 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 14 May
 2024 01:23:14 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <asad.kamal@amd.com>, <donald.cheung@amd.com>,
 <sepehr.khatir@amd.com>, <daniel.oliveira@amd.com>, <charis.poag@amd.com>,
 <Shuzhou.Liu@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: Add gpu_metrics_v1_6
Date: Tue, 14 May 2024 14:22:54 +0800
Message-ID: <20240514062255.648187-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|IA0PR12MB7698:EE_
X-MS-Office365-Filtering-Correlation-Id: eff92cf4-75f3-43b4-2453-08dc73de57e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3v8V4PUDP/ertPQx/gIq9aKv3dDoC7cr5d+plhDuSSNtHfWrUShLt0nnrLnN?=
 =?us-ascii?Q?2NGbHFixsyR9RJ9iwvTtL4x4fyUJiNRzB5I9RyxzgYFngThTXQXr1x33d66d?=
 =?us-ascii?Q?rTdC/JpaEde0NQQlZ2vWeedf79xblg7RKifaCKpBNohcUh+vmUX41swt7Kug?=
 =?us-ascii?Q?NUbLTv7qi+n4JdC0DDLt23+uyTwCa+pfvUa93fuF4i3Ul/WxgZEQY1gfegNk?=
 =?us-ascii?Q?Wu/j7cJp8YWFOF+fgfb5FqBBNxuNYrUlBEG7e04ere9DjBUZ62P1dKGgnG0/?=
 =?us-ascii?Q?S4GTgZp8K+X1MozqMyL91/+qxI4qJG5QDhkn8dF3s4Qmdvkw0MhLHhIrKayi?=
 =?us-ascii?Q?1dOtXQo9i5ZKywKGlz+VKosB5xqP/CukNwy3G9KENA5GnR3ZPSLNuWufoPCe?=
 =?us-ascii?Q?squOprahrMuqnV264POZyRlqzNvRbOijv+6Ay0SziyXzi3xzz/5DCcfWEB3k?=
 =?us-ascii?Q?od1Vg0Ve/d6iezDIj7fW/OlXgXE/Wctr5VYLSxbbp8F7v+e3MzDg6YTQZAAi?=
 =?us-ascii?Q?IAFJfNAZBaWpTyH1/MHih4qCtM0PVDrG/WRII+2iGTuClYulpuwtxw3XtTbY?=
 =?us-ascii?Q?s1lnz4nnu+t7igJPAceKa8rK/6BLhNVtD7J0acCnfiUuxFIV+taY1Iv50Z+t?=
 =?us-ascii?Q?7QuABfG8NMFqQPcxJQYFFcS03o/mrLgFLaCMx4ymjWYaT6iAnrsCN51AwTt/?=
 =?us-ascii?Q?dmKnVzzgetZ+egWGrTOJb1wu5+O6WsCofl9Apq5ireNGdGCjeda6IU9aijPL?=
 =?us-ascii?Q?bMmI5Mfp905JFbaucsVYb0FZlQY1oBbXuERYLFZBcwO/SagU653vbaF8cFKd?=
 =?us-ascii?Q?6h4mbip2mNblr9Z+7beOYPRr6OnHTv/aLQ/xd+9BPcIbOzlE0e3RHcA3mTti?=
 =?us-ascii?Q?6P71CMCLyRVVqoraUr9ARICl9nxIh6ZzlFFZh1jZQLkGdEiH+qGiKPDzgWYm?=
 =?us-ascii?Q?3hGIuid7mpP8apnyOs87ahvHPbzTI8ivpdRtUOW8nY4hNhKTrUvgtCDqIdF8?=
 =?us-ascii?Q?9eyr/jeScMjn3N7i2aK91+jqQQDuedcUB/RUJ2pW8OBrjZWHtots9RzAuXlN?=
 =?us-ascii?Q?Je5/zgWlNzpXUJSoSNF8L4qVfLRjSFdjV1Le1IEbvTn3vri8nIjSQp1yq1vf?=
 =?us-ascii?Q?5MnpCQSl+undoNRHnRf9bOUgkkK97ZHuKz2pMsaK1BYhSfib5OCpmWFv2hYP?=
 =?us-ascii?Q?v/lp1Z7+OxMy6EV1E6KR7+FUuhotGOfQ0aJ810BJKQ1T4ZwqgQ/hf500ElQc?=
 =?us-ascii?Q?Hfwg6HdUgpAI3akxEyruK4EZbbl+jBJaIqMhxbZplmEXGlRVGbNGfkKdo31v?=
 =?us-ascii?Q?e95gdM/47d3eCbETeX9f46lPJnqFz+UPtZdB0zXqefEPvWSSdC1dI2LKgKcl?=
 =?us-ascii?Q?MNa++jBUO3ul4qe7ey2+xSVfQdOZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 06:23:17.3751 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eff92cf4-75f3-43b4-2453-08dc73de57e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7698
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

Add new gpu_metrics_v1_6 to acquire accumulated
throttler residencies

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    | 89 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  3 +
 2 files changed, 92 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 805c9d37a2b4..a0955cfe41ce 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -854,6 +854,95 @@ struct gpu_metrics_v1_5 {
 	uint16_t			padding;
 };
 
+struct gpu_metrics_v1_6 {
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
+	/* Accumulation cycle counter */
+	uint32_t			accumulation_counter;
+
+	/* Accumulated throttler residencies */
+	uint32_t			prochot_residency_acc;
+	uint32_t			ppt_residency_acc;
+	uint32_t			socket_thm_residency_acc;
+	uint32_t			vr_thm_residency_acc;
+	uint32_t			hbm_thm_residency_acc;
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
+	/*PCIE accumulated bandwidth (Mbps) */
+	uint64_t			pcie_bandwidth_acc;
+
+	/*PCIE instantaneous bandwidth (Mbps) */
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
index 602aa6941231..26d44a4370d2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1052,6 +1052,9 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev)
 	case METRICS_VERSION(1, 5):
 		structure_size = sizeof(struct gpu_metrics_v1_5);
 		break;
+	case METRICS_VERSION(1, 6):
+		structure_size = sizeof(struct gpu_metrics_v1_6);
+		break;
 	case METRICS_VERSION(2, 0):
 		structure_size = sizeof(struct gpu_metrics_v2_0);
 		break;
-- 
2.42.0

