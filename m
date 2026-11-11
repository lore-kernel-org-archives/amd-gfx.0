Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB52606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=f9tS35dv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0246610F8ED;
	Wed, 11 Nov 2026 01:44:13 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012023.outbound.protection.outlook.com
 [40.107.200.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90A2310F8EA
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:44:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JT657oASbueEvSjYCFPKD7/apM0/ec1bIdss0t5ycO0IT3HFIZkDWtMMG6rZ9yQ3hBiUWT3HBLX2GVlywHHT0YVjzkPhg/rcSO5fvfvDBCZD5LQxRHdewLfv1xO+95crk9meDnY5mKiVTaxP9VxDirSPYjQvHpVVG87UvfJWwk8Qw23nsNsirJzmhgNOTbbaM5C0jBg1R7j41uW+k+PclYaPLcSO8ZqIY09VqI1h8MC8wgiRxc98jziEAD53gCPauUpwLaMq4uxUvNaU6yLbGb7IwyefncBreJ6c4zMX685PSL6CHwIL1SSC2oqpG54SxwHVi5SpqcjuLl0j1TECXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MJtGSUZzLhbbt4E5sA3/icEF+xS1I7A73O5PbChgns=;
 b=oPj4ocXNGYBNJ7ekBFLQeHeEut70QyWTXGBt1MI3X4ofhdKuxs4Q6QzIrseB+QyofD5J0pYorSlhDGwn9aXoYBYopQ5u4IoR2p0Yxxk98dH0upUDzcO5De84Q9HF/vBKGaz8itXQEzEPFm1AEf+YmTStcu4IM9K0UZAm1XD2FjxLFDrJik6bNcurZoTB3XkVpzA49wQkumCNaDg7KZxt529AJqtMYuvClnFcNI4j/UbAJ21yu3EXAWcih9eTeAdYdhOly+3FRAHWB0Q4FXiGnmQTdHkvaYUuH28cboQ/w5LLN7A6pJ7sWzjJM9amdPbcgOVuEkIDPJbLAP9pN83Y2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MJtGSUZzLhbbt4E5sA3/icEF+xS1I7A73O5PbChgns=;
 b=f9tS35dvQFUv8PU/dOJ+M3ipCKcQ1OHexYZ2CWYwaFrX0ZhpDJqPeqgwhmn58J5hS5a74YmLVNIzjvap8i+jm09UucKerL9pPjtI3yRFPpkqoctJ1YdTu2qW/mVdPwMngXUxFmt4tkglYcj8nLkCdguxPQBcY7yCCh1fm2YuOSw=
Received: from SJ0PR03CA0051.namprd03.prod.outlook.com (2603:10b6:a03:33e::26)
 by SJ2PR12MB8845.namprd12.prod.outlook.com (2603:10b6:a03:538::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 01:43:58 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::5b) by SJ0PR03CA0051.outlook.office365.com
 (2603:10b6:a03:33e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Wed,
 11 Nov 2026 01:43:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:43:58 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:43:57 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:43:57 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:43:54 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 55/74] drm/amd/display: Read DCN6 SOP constraints from the
 idle row
Date: Wed, 11 Nov 2026 09:29:01 +0800
Message-ID: <20261111014100.3596072-56-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|SJ2PR12MB8845:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e6fc2e6-c550-419e-aa70-08df3f95413c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|30052699003|18002099003|22082099003|56012099006|261026140227099003|261028144727099003|261026121527099003|261022105027099003|261102123227099003|261021121427099003|261021123027099003|11063799006|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: 1LzHuCujkCuG8u6DDaH1Z1Pj5QhmWkaDInvXg6vc1YrrUMgRIDUbyqc3eO6/c6/P7ghge/2EvzhmJ6ZqpbN5SCSni4hP0sQzvIhlfPVn1HiFtxneT3wkfByyJeRQ9sXoVSIHUj+xFHP1/f8EGRZ+IckpadAPZ01u8g5MiLCN1/Hf9K6v1wJ7HVt6KgZtoDeekNIHRYpgaOxooEJWpu+Qw5AdL6epBn66Fed7x8bjIv93zwMTgsGXMfXnmG+UpALTZOq4kdbHUIBw/qhB7I0mUkzvcphZo5/5Y+KWyjEHCseZJTP4lpvw+4Tb3/rOXTuATf9mdZ3Y0cUTHHJ2qi7sePDlabaZc1AEePprmwkvLef7x1ym8twQzTNXbKU9/vNlMGWSqQaLMLq0/so15DtScODEIjMdPil7MFCn6zy3UpKrNWLb6qttFOPhXYdmiXVBdAUQaxKGTgjHdVlaG7Qywim2x1norI/RCe4HhcjJtdMQptOGTMwc+jjQAaNeuUm6FfTd5X8Hpl3kRoOBoSzUarBQFeWTGqQa/OOrRz9dayM6iX67zy224z+jHHTeT7t45s3+7Jbra52lWR8qcUw6dO37rfM5nFF5XGVl3f0XdEH10O5yQXwtN5+Ci3BcWGjBsW3RQrc79bfAVCQkUIIjyyNb3JUrO9ZkLHRWiStwEHhSV6g8iosNAsc8+JZkfXjtI19moubDLbB5R67Ovvql6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(30052699003)(18002099003)(22082099003)(56012099006)(261026140227099003)(261028144727099003)(261026121527099003)(261022105027099003)(261102123227099003)(261021121427099003)(261021123027099003)(11063799006)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pBrGpKzVHP+eptuhrgG2QpFbmT56o4no72q3OWE2iUqdk12mArZ9Z1B0uRBFwd4HB2DLuEA8x4CVxcyeM9BroT43fiyOPFGyde3q+ZfQItLjExgGP7Trr8EcJDfEVR05/P7upitwcHWtdxm+KRDNbzeOlK/L2dkSurGKvzcob6AS1482if2PJxnV+XdgkxYWrbG+MmprVLtXuJiZhljN9TyNfiQYOw5ZCspx7M/5p793RuY2mSkIWAfZhYZHYb7xjPJIbB471SuhOZeHF1AC8UqIha89DblAFywQEi3jWvZwYGFNDhf/OIFjL162zLNdIDzKwRhV+2OLv8DKefGeYWnE9gliFlWD4936VupHme2xqsak/Gb3bvkwwGFye+f5pywcoVremDD7oqwrbKNQuifKZsZgI2LdqNWPUGSEKnTyX06lN9u8LN8EYuwHdAG7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:43:58.5777 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e6fc2e6-c550-419e-aa70-08df3f95413c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8845
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Austin Zheng <Austin.Zheng@amd.com>

[Why]
The n-1 UTM model has 8 SOC operating points. It sets
sop_count to 8 and fills sops[0] through sops[7]. Mode
support copies latency and available bandwidth from the v3
constraint for one point. That constraint was taken from the
alternate-pstate row, so its latency and urgent bandwidth
did not match the idle row.

[How]
This change does not write sop_count. The v3 table length
stays UTM_QOS_MODEL_V3_MAX_SOP_COUNT, which is 5.
dcn6_v3_sop_table_get_sop_constraint_at_index() reads latency
from sops[IDLE][index]. dml2_utm_soc_bb_dcn6_v3_build_sop_table()
stores that row's urgent_bandwidth_KBps and
nominal_bandwidth_KBps as the minimum urgent and non-urgent
bandwidth. dcn6_v3_sop_table_is_bandwidth_supported_at_index()
still compares the highest alternate-pstate row as well.

Cc: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c    | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c
index 586618d7dd58..7a1b2492969e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c
@@ -157,8 +157,9 @@ static void dcn6_v3_sop_table_get_sop_constraint_at_index(const struct dml2_sop_
 		unsigned int index, struct dml2_sop_constraint *constraint)
 {
 	const struct utm_qos_model_dchub_v3 *dchub = table->model->dchub_v3;
+	// The mode support check is done based on the idle SOPs, not the active SOPs
 	const struct utm_qos_model_dchub_v3_sop_entry *entry =
-			&dchub->sops[UTM_QOS_MODEL_V3_LOAD_LEVEL_ACTIVE_ALTERNATE_PSTATE][index];
+			&dchub->sops[UTM_QOS_MODEL_V3_LOAD_LEVEL_IDLE][index];
 
 	DML_ASSERT_MSG(index < dchub->sop_count, "unsupported sop index\n");
 	constraint->dcn5.clocks.fclk_khz = 0;
@@ -174,6 +175,8 @@ static void dcn6_v3_sop_table_get_sop_constraint_at_index(const struct dml2_sop_
 	constraint->dcn5.latency.dcn5.avg_req_latency_non_urg = entry->avg_req_latency_non_urg_ps / 1000000.0;
 	constraint->dcn5.latency.dcn5.df_response_time_us = entry->df_response_time_ps / 1000000.0;
 	constraint->dcn5.min_available_urgent_bandwidth_KBps = table->sop_min_available_urgent_bandwidths_KBps[index];
+	// non urgent bandwidth needs to be plumbed for presentation in the spreadsheet
+	constraint->dcn5.min_available_non_urgent_bandwidth_KBps = table->sop_min_available_non_urgent_bandwidths_KBps[index];
 	constraint->dcn5.min_sop_index = index;
 }
 
@@ -267,14 +270,18 @@ static void dml2_utm_soc_bb_dcn6_v3_build_sop_table(struct dml2_sop_table *table
 
 	for (i = 0; i < dchub->sop_count; i++) {
 		const struct utm_qos_model_dchub_v3_sop_entry *idle_entry =
-				&dchub->sops[UTM_QOS_MODEL_V3_LOAD_LEVEL_IDLE][i];
-		const struct utm_qos_model_dchub_v3_sop_entry *active_entry =
-				&dchub->sops[UTM_QOS_MODEL_V3_LOAD_LEVEL_ACTIVE_ALTERNATE_PSTATE][i];
+			&dchub->sops[UTM_QOS_MODEL_V3_LOAD_LEVEL_IDLE][i];
 
 		table->sop_optimal_dcfclks_khz[i] =
-				dcn6_v3_sop_table_calculate_optimal_dcfclk_khz(utm_soc_bb, idle_entry);
+			dcn6_v3_sop_table_calculate_optimal_dcfclk_khz(utm_soc_bb, idle_entry);
+		// The mode support check is done based on the idle SOPs, not the active SOPs
 		table->sop_min_available_urgent_bandwidths_KBps[i] =
-				active_entry->urgent_bandwidth_KBps;
+			idle_entry->urgent_bandwidth_KBps;
+		// non urgent bandwidth needs to be plumbed for presentation in the spreadsheet
+		table->sop_min_available_non_urgent_bandwidths_KBps[i] =
+			idle_entry->nominal_bandwidth_KBps;
+		// TODO - remove min_available_urgent_bandwidth_KBps and move stutter efficiency calculation to populate informative.
+
 	}
 }
 
-- 
2.43.0

