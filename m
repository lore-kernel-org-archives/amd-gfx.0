Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2791C6FA82
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:49:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A27D910E7FC;
	Wed, 14 Sep 2022 03:49:16 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55D8810E344
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:49:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOPIv1HqA53VauILQhrm+XlhpIKI+IF0QFMtty/b1HU+HxHOkI8HA+fLzvtSxafBxPf+6Mu7swoI0kOKU0bt95Y/B1AL4i8pHFHs4EpajPHTXAwU32r+ll236BI0haoy1zsTXLlh+NfzX7qzGTHGzTdOJMXh2uWG7k6Ydo0ZmRJ8o+Y6ofpVIfVivEW7vsA7WMRtiPO6F/D0Y5k0UoWeUk6ec+tK5xrsn6nElrHbpIrlkJzDMm85eoNjaip3sqRsslpx6NX3sokLDyQiLg66sxfSE515kG43NN0IYi82habcpC5YuPT2CFFF3tWms7vBpAIuKtErYc0R66bFJCBhug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Aq4TlKukSkX2KEP9xRHBKZPydJ9LJ0dVxC5V665cqM=;
 b=AXbYJPzjC3VLW0kFCpqIRHF4M3ucUn52xFjXtZYfbBrTAzlUcdxBs2XnLmgL1aCrHpsCyNPs0pZ8DIBT44eGh9OG+j/TtOPv9oPY/jlGYp9BCqZ3a+aUfHS9hX/oYc5h8oWGE9LGzecJyySwSh9zVceYUbE9n3jiTUY2f/KssEbLwF0Zzf2jhBPMJCePvDMn0/gc+zOaNWD9mAhsvNXjZwnDmARMY7o+gCktHWQOXMQ5D0RFWcq21k7So3aLyuCQqaW8N8ub9ibn48ZcQXriOSVp0wYv/BqSbuM/CFVyy5SFVNCLIO1DwGShPPf1Gyc1hSAzhCeOQh86zoSdjxN8Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Aq4TlKukSkX2KEP9xRHBKZPydJ9LJ0dVxC5V665cqM=;
 b=AGSAj+drbepYEYhu2f2V1KpPiWzDlCiIYyRcFiPMseWAWdEoE2iv+LS9m5TIW50bQIMd8xvvpgnvB40FZ7PrsD/3F3wtZqeUqi8sGmVwD7systZK/fdW7EwSLjW8219v7qi7KmgNnyyglG8shBjE1ZjdG+Eu+EaW5LmJxgAHmic=
Received: from DM6PR11CA0004.namprd11.prod.outlook.com (2603:10b6:5:190::17)
 by MW4PR12MB7357.namprd12.prod.outlook.com (2603:10b6:303:219::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Wed, 14 Sep
 2022 03:49:02 +0000
Received: from CY4PEPF0000B8EE.namprd05.prod.outlook.com
 (2603:10b6:5:190:cafe::af) by DM6PR11CA0004.outlook.office365.com
 (2603:10b6:5:190::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 14 Sep 2022 03:49:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000B8EE.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.12 via Frontend Transport; Wed, 14 Sep 2022 03:49:01 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:49:01 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:48:57 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 04/47] drm/amd/display: add debug option for
 dramclk_change_latency in apu
Date: Wed, 14 Sep 2022 11:47:25 +0800
Message-ID: <20220914034808.1093521-5-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914034808.1093521-1-Wayne.Lin@amd.com>
References: <20220914034808.1093521-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EE:EE_|MW4PR12MB7357:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b7c269d-3f9f-47e0-e3c7-08da96041024
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fWiUAgELWGedT9lqIFm3joDpZfEM5/U5EcCILAcaB1GNfqzjAwx1hgE4WHKI2mKkyAN+6Mn+zIdm7uQVlcyWa2Z5KcZO5A50MYmSBB3U2QKcXCnXyFUqc/oJMrgqsjxquCQU5aq7SY+nWnJ/N4LCliVEn2aGzIVs6dovpOZ8WGb5zwDGn6YUbd/zJYTwNUdPxa5wzwXRFiUK4LZoTQAr7+KLg44Ifjj47TP982AgzaWTIEXL84YAFSJHH/v5SZI7vuZM4IP0uO5NGFpoGx1hK3oLsHLVK9r7wSe+khcsapxSCVaqgRaFDrHXTpsR2iF+QQIdpA+nLKQWMdpHEYTe5AYjeAlcqqhIDDcX6Uui0jg2A8OVRPwbRnbez77k49bLQXaXzyJWKOReV14MSoTPCmlhbVMCALWX2eaQ5ENMK4gvLvHi2zdBc+inNAXvbIre1tsfbndwYP905iS5yYtg+GEVx5HkhCRvR5UTZmaVKVcwmWH24sCtuNXtOaDjI1Fhn32bmuX5BR1GXM0dvBW3AzPA4baloCAWUHcFcgQKFsALiovrbtbw0rWc8y+CUbiabBIUJbhC2cHPwcbp+WV4g8ptcQ5bjITDJrNLc/qaAd7/mDYW2GIj2zuzB64iyMKKs6Xkp8Yl04DYdrSNwViwzs98tkImiKDj0bx+xylycCoQG2p5d6ytdZOzZV59lHHgvBuB4Eg7GJwIApbZh+iNQ8QPZgLCT+6H6eRk9ZYrWsSMvV62fQKrMXoz0hgS/NZJn4UrbRbMf5F/6q1+ROysDKbddDojt87RKzrosmjsoZ1sJyeq1rQ87YeuSdFWV3mp
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199015)(40470700004)(36840700001)(46966006)(8936002)(8676002)(70586007)(36860700001)(426003)(7696005)(6666004)(54906003)(336012)(5660300002)(40480700001)(70206006)(186003)(82310400005)(1076003)(41300700001)(316002)(86362001)(356005)(82740400003)(4326008)(40460700003)(26005)(2906002)(6916009)(2616005)(478600001)(83380400001)(47076005)(81166007)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:49:01.9985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b7c269d-3f9f-47e0-e3c7-08da96041024
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7357
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[Why & How]
Support dramclk change latency change via debug option and add some
code isolation.

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
---
 .../drm/amd/display/dc/dml/dcn301/dcn301_fpu.c  |  5 +++++
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c    | 17 +++++++++++++++++
 .../drm/amd/display/dc/dml/dcn314/dcn314_fpu.c  |  5 +++++
 3 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
index 241d28d0b7fb..422f17aefd4a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
@@ -379,6 +379,11 @@ void dcn301_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 	dcn3_01_soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
 	dc->dml.soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
 
+	if ((int)(dcn3_01_soc.dram_clock_change_latency_us * 1000)
+				!= dc->debug.dram_clock_change_latency_ns
+			&& dc->debug.dram_clock_change_latency_ns) {
+		dcn3_01_soc.dram_clock_change_latency_us = dc->debug.dram_clock_change_latency_ns / 1000.0;
+	}
 	dml_init_instance(&dc->dml, &dcn3_01_soc, &dcn3_01_ip, DML_PROJECT_DCN30);
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
index 0e62eb823e34..43230709bd11 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
@@ -667,6 +667,12 @@ void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
 	dcn3_1_soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
 	dc->dml.soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
 
+	if ((int)(dcn3_1_soc.dram_clock_change_latency_us * 1000)
+				!= dc->debug.dram_clock_change_latency_ns
+			&& dc->debug.dram_clock_change_latency_ns) {
+		dcn3_1_soc.dram_clock_change_latency_us = dc->debug.dram_clock_change_latency_ns / 1000;
+	}
+
 	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment))
 		dml_init_instance(&dc->dml, &dcn3_1_soc, &dcn3_1_ip, DML_PROJECT_DCN31);
 	else
@@ -721,6 +727,12 @@ void dcn315_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 	 */
 	dcn3_15_soc.dispclk_dppclk_vco_speed_mhz = max_dispclk_mhz * 2;
 
+	if ((int)(dcn3_15_soc.dram_clock_change_latency_us * 1000)
+				!= dc->debug.dram_clock_change_latency_ns
+			&& dc->debug.dram_clock_change_latency_ns) {
+		dcn3_15_soc.dram_clock_change_latency_us = dc->debug.dram_clock_change_latency_ns / 1000;
+	}
+
 	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment))
 		dml_init_instance(&dc->dml, &dcn3_15_soc, &dcn3_15_ip, DML_PROJECT_DCN31);
 	else
@@ -813,6 +825,11 @@ void dcn316_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 		dcn3_16_soc.dispclk_dppclk_vco_speed_mhz = max_dispclk_mhz * 2;
 		dc->dml.soc.dispclk_dppclk_vco_speed_mhz = max_dispclk_mhz * 2;
 	}
+	if ((int)(dcn3_16_soc.dram_clock_change_latency_us * 1000)
+				!= dc->debug.dram_clock_change_latency_ns
+			&& dc->debug.dram_clock_change_latency_ns) {
+		dcn3_16_soc.dram_clock_change_latency_us = dc->debug.dram_clock_change_latency_ns / 1000;
+	}
 
 	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment))
 		dml_init_instance(&dc->dml, &dcn3_16_soc, &dcn3_16_ip, DML_PROJECT_DCN31);
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index 4bb3b31ea7e0..ce477c090987 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -264,6 +264,11 @@ void dcn314_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_p
 		dc->dml.soc.dispclk_dppclk_vco_speed_mhz = max_dispclk_mhz * 2;
 	}
 
+	if ((int)(dcn3_14_soc.dram_clock_change_latency_us * 1000)
+				!= dc->debug.dram_clock_change_latency_ns
+			&& dc->debug.dram_clock_change_latency_ns) {
+		dcn3_14_soc.dram_clock_change_latency_us = dc->debug.dram_clock_change_latency_ns / 1000;
+	}
 	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment))
 		dml_init_instance(&dc->dml, &dcn3_14_soc, &dcn3_14_ip, DML_PROJECT_DCN314);
 	else
-- 
2.37.3

