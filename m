Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F35CCC6B03
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 11:16:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D274210E7A9;
	Tue, 13 Oct 2026 11:16:21 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012025.outbound.protection.outlook.com [52.101.53.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 296EC10E7A9
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 11:16:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MxUuXWTnU7rbocXGhmndgH2C86+gk/foVDaPYi3Ui7ZMqKSGjS0i1iTC2S2dLYNFmdQ0kMvVzRYHM0Zqk+MkebwstSgZ4rHeThNdQmjNfLeA6xBWJMlr8U6lhbxBvAsuHbybwn9SFEltfskN9XNlB6z08vh+qKgEmMFvB3O2Cx9vXM2PFQnGehDwH5bP+O0iJ6+PtU8piwe7UOHggBpH5YsS6DwrCciRjhfKhgClPWtedMcBGqZ65+Ain+RVTTkPPXFUBGNLMvIbKs+Um4ykz1BAyBP/IdxqqrJL7SHhXAYT9chGbCSsueBGmVsNCzgN/t8q5hM19bcn1rk2Ab1eHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXlPInJlEFv4GpYxEEGL6XBw8+1NWH9OVvnHW0qI8yw=;
 b=S8bwcvz/AjW3AUNk4QmpI+v59dbfVaC2YGWRgKKkUC8ZE08q61C3QwBdYrOfqvdlPNQ+z5ejAVVFSG8nsOlXkGOZa4BN7ygkn8/y9o9rs97Y3IgWH7ZqA8U9nz/Kv7i3zqKC6TXVNaXnjwBZ21/kP5riUnI564EfJEnDtCzU0CokkFByACESOttW1Z8BJ23ItnhUYmHU08nV192hDnANEOiEcz2lah5Xin4d5EqbAQq6i8QT7eLx9/9W849lcIo/dieyIDadQcByYy7vcGvsgWUCJ2Y9WUHlznYZcrIwGWIyL6oKZVxvl6pMtdupTex5TFRPluh/h+8pFESXTN0VRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXlPInJlEFv4GpYxEEGL6XBw8+1NWH9OVvnHW0qI8yw=;
 b=KH+8Eg4yYuJ8pMSefFrNmWzDRDHsBJlUOxO0Yv/Q9xpBBR0kp6ZvRttMnNSC/rndqo5vdb6Es4yZF7keKMwlAgQcNp823ZKIAfvHgpjeX7Dhq5noxKBpqrBFbVWzNIzJoKIcAO7IRD3RINvQcwrSnRZ5hHYfD0Mn37NhJIE76V0=
Received: from CH0P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::14)
 by LV2PR12MB5944.namprd12.prod.outlook.com (2603:10b6:408:14f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 11:16:08 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::3b) by CH0P221CA0004.outlook.office365.com
 (2603:10b6:610:11c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue,
 13 Oct 2026 11:16:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 11:16:07 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:16:01 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:16:00 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 06:15:52 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ilya Bakoulin <Ilya.Bakoulin@amd.com>, Relja Vojvodic
 <relja.vojvodic@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 01/30] drm/amd/display: Fix HDMI FRL FFE compliance test
Date: Tue, 13 Oct 2026 19:07:48 +0800
Message-ID: <20261013111616.2267344-2-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013111616.2267344-1-ray.wu@amd.com>
References: <20261013111616.2267344-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|LV2PR12MB5944:EE_
X-MS-Office365-Filtering-Correlation-Id: c514017c-0730-418b-0209-08df291b6100
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: VU43g63/n9nIcBjJN6ptRv26/B+DKPLQeQPO48i8BlaelScSNFu6fP0+2R93NsiBaHYY0UeD80W1Sh/z94NCguSwPp/2pQmNd//IAC6FaM6O3s+Xwu6kx1QAxGb60wHkYpzt0KTIN+lL9nJKKKl4QJUGCnc8qVlCzKF8qb81Nd48gq0r6OVk1R1zfDEtMDM7cuVyw6dV5FYQlFdWtMljiZBblP7xo1xm3N/im6XCAPYBmqrhGpRLHRv+zT0ldZkh3d5GyizyuwiPaPfCxpsRh+zFA2lvh2q7b+lJoA58POFCxv74sq2TrMxZ9qvP7CBb0YWHnLYHytV7+qRzWJc4cPigAhQvoHL22qgDWLbqpyArOMbxqg69vAc3wglQeKBrouwLCWdfhw5cUvMDA/aRDMiM1DnNsex50CIkEmkaW7uiwSXWBBgtZrx94SYy4pDvVTS9MV5G5GTWFsQM+VODXI45ND9henafxmLZGbuGmX6SA/ajxqJ3IfPy0pPZogIdiysphZoumFmdGCDO5VTsI1CyetYDMSKEua06GtPkWqa6MPnvcMHBzTHBcvv0jIOa3gjD80d72rPCeWWLQsc5dcKZxb83/amhF+Od/CJ1bv6PbD+tA5tzoaXST8xkL3ln76zarIzxKUl7zfIVikis2cPTXjKhkSwegEbdh5KjGKdHxIlUjWP5g0xDTE9/QFdZ1kxR8ytWmWnfuMGk3xIP+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: F/E8Yk1vW7wAg7VfYSHkM0TV5aNsyVzeoXC4zTCAIvYZM+CWIUOD/+uX3CuXrMrkFiatPbhu2Fg/LJxtAe0AQO/QTe2e85HFJEgJPbwHD+PkfoOYUT91kRNatQ0Jetmg5VN39bBuRaGlMJjHrtpsHm4QXaYukW0kh+VS0D+5kwyb0x3LRCoDT64yvptVRwMPS//lEnpCfk0hY23gH5LIar8gNAf1n1QwnM0K7R+63WQoJP/Vy6C+DdAw/OPDs8f6pQlsEP5PVs6m75o0zqdoBeaYX4RO66BLjt9jVgUq9QVG21FX0+UD0qrbjQFd/vNhZ8eJrfKSRF9DRX5ovosGSaJ/lXuXYzsLD907e8pUH8H3Fp161k7gnxxckOlrs7RZRu+m0g2J7oQcWnccAv1gmfYZvcPkGH6mijI4GSt6bffwc68rGhRJx9wU4V2GKRsA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 11:16:07.7692 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c514017c-0730-418b-0209-08df291b6100
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5944
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

From: Ilya Bakoulin <Ilya.Bakoulin@amd.com>

[Why & How]
The FFE electrical compliance test behavior is not correct. The driver
doesn't properly iterate over the FFE levels and select PS/DE based on
test request and/or cable-ID.

Fix the initialization of the link state so that when the polling loop
takes over, the test proceeds as described in the spec.

Reviewed-by: Relja Vojvodic <relja.vojvodic@amd.com>
Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../gpu/drm/amd/display/dc/dc_hdmi_types.h    |   4 +-
 .../display/dc/link/hwss/link_hwss_hpo_frl.c  |   3 +
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   2 +
 .../display/dc/link/protocols/link_hdmi_frl.c | 127 +++++++++++++-----
 4 files changed, 104 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h b/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h
index eb6e7f4043fd..9e0fe41f28a5 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h
@@ -235,7 +235,8 @@ enum link_result {
 	LINK_RESULT_SUCCESS,
 	LINK_RESULT_LOWER_LINKRATE,
 	LINK_RESULT_TIMEOUT,
-	LINK_RESULT_FALLBACK
+	LINK_RESULT_FALLBACK,
+	LINK_RESULT_NO_TIMEOUT
 };
 
 enum hdmi_frl_link_rate {
@@ -274,6 +275,7 @@ struct dc_hdmi_frl_flags {
 	bool force_frl_dsc;
 	bool force_frl_max;
 	bool apply_vsdb_rcc_wa;
+	bool no_timeout;
 };
 
 struct dc_hdmi_frl_link_training_overrides {
diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_frl.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_frl.c
index a2c0fa21ee94..62288133cd55 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_frl.c
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_frl.c
@@ -59,6 +59,9 @@ static void disable_hpo_frl_link_output(struct dc_link *link,
 		enum signal_type signal)
 {
 	(void)link_res;
+	if (link->frl_flags.no_timeout)
+		return;
+
 	if (dc_is_hdmi_frl_signal(signal))
 		link->hpo_frl_link_enc->funcs->disable_link_encoder(link->hpo_frl_link_enc);
 	link->link_enc->funcs->disable_output(link->link_enc, signal);
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 42a47d12d1f3..cde531dd1626 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2090,6 +2090,8 @@ static enum dc_status enable_link_hdmi_frl(struct pipe_ctx *pipe_ctx)
 		pipe_ctx->stream_res.hpo_frl_stream_enc->funcs->hdmi_frl_enable(
 			pipe_ctx->stream_res.hpo_frl_stream_enc,
 			pipe_ctx->stream_res.tg->inst);
+	} else if (link_stat == LINK_RESULT_NO_TIMEOUT) {
+		return status;
 	} else {
 		status = DC_FAIL_HDMI_FRL_LINK_TRAINING;
 		stream->link->frl_link_settings.frl_link_rate = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
index 5e0979ac3dcf..52a22b3e78af 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
@@ -451,11 +451,37 @@ static enum link_result hdmi_frl_perform_link_training(struct ddc_service *ddc_s
 	uint8_t FFE_Levels = hdmi_frl_get_max_ffe_level(ddc_service->link, link_settings);
 	uint8_t current_FFE = 0;
 	bool override_FFE = false;
-	bool flt_no_timeout = false;
 
 	DC_LOGGER_INIT(ddc_service->link->ctx->logger);
 	FRL_INFO("FRL LINK TRAINING:  Starting FRL Link Training.\n");
 
+	/*Test Condition - FLT_no_timeout avoid link training*/
+	offset = HDMI_SCDC_SOURCE_TEST_REQ;
+	link_query_ddc_data(ddc_service, slave_address, &offset,
+			sizeof(offset), &test_req.byte, sizeof(test_req.byte));
+	FRL_INFO("FRL TEST REQ:  FLT_no_timeout = %d \n", test_req.fields.FLT_NO_TIMEOUT);
+
+	if (test_req.fields.FLT_NO_TIMEOUT && ddc_service->link->frl_flags.no_timeout) {
+		bool de_emphasis_only = false;
+		bool pre_shoot_only = false;
+		bool no_ffe = false;
+
+		read_idcc_data(ddc_service, HDMI_IDCC_SCOPE_RW_CA,
+			ddc_service->link->hdmi_cable_id.raw, 0,
+			sizeof(ddc_service->link->hdmi_cable_id.raw));
+
+		hdmi_return_preeshoot_and_deemphasis(ddc_service->link, &test_req,
+			&de_emphasis_only, &pre_shoot_only, &no_ffe);
+
+		dio_link_enc->funcs->prog_eq_setting(dio_link_enc, 0,
+			de_emphasis_only,
+			pre_shoot_only,
+			no_ffe,
+			link_settings);
+
+		return LINK_RESULT_NO_TIMEOUT;
+	}
+
 	hdmi_frl_LTS_clear_Link_Setting(ddc_service);
 
 	offset = HDMI_SCDC_SINK_VERSION;
@@ -511,13 +537,68 @@ static enum link_result hdmi_frl_perform_link_training(struct ddc_service *ddc_s
 		}
 	} while (elapsed < poll_timeout_ns);
 
-	/*Test Condition - FLT_no_timeout avoid link training*/
-	offset = HDMI_SCDC_SOURCE_TEST_REQ;
-	link_query_ddc_data(ddc_service, slave_address, &offset,
-			sizeof(offset), &test_req.byte, sizeof(test_req.byte));
-	FRL_INFO("FRL TEST REQ:  FLT_no_timeout = %d \n", test_req.fields.FLT_NO_TIMEOUT);
-	if (test_req.fields.FLT_NO_TIMEOUT)
-		flt_no_timeout = true;
+	if (test_req.fields.FLT_NO_TIMEOUT) {
+		ddc_service->link->frl_flags.no_timeout = true;
+
+		/*Specify FRL rate*/
+		write_buffer[0] = HDMI_SCDC_CONFIG_1;
+		/*FRL_RATE*/
+		write_buffer[1] = (uint8_t)(link_settings->frl_link_rate | (FFE_Levels << 4));
+		link_query_ddc_data(ddc_service, slave_address,
+				write_buffer, sizeof(write_buffer), NULL, 0);
+		FRL_INFO("FRL LINK TRAINING:  Write link rate = %d.  Max FFE_Levels = %d\n",
+				link_settings->frl_link_rate, FFE_Levels);
+
+		offset = HDMI_SCDC_UPDATE_0;
+		/*Check FLT_update flag*/
+		link_query_ddc_data(ddc_service, slave_address,
+						&offset, sizeof(offset), &scdc_update.byte[0],
+						sizeof(scdc_update.byte[0]));
+
+		offset = HDMI_SCDC_LTP_REQ;
+		link_query_ddc_data(ddc_service, slave_address,
+						&offset, sizeof(offset), ltp_req.byte,
+						sizeof(ltp_req.byte));
+
+		ln0_pattern = ltp_req.fields.LN0_LTP_REQ;
+		ln1_pattern = ltp_req.fields.LN1_LTP_REQ;
+		ln2_pattern = ltp_req.fields.LN2_LTP_REQ;
+		ln3_pattern = ltp_req.fields.LN3_LTP_REQ;
+
+		hpo_frl_link_enc->funcs->set_hdmi_training_pattern(
+					hpo_frl_link_enc,
+					ln0_pattern - 1,
+					ln1_pattern - 1,
+					ln2_pattern - 1,
+					ln3_pattern - 1);
+
+		read_idcc_data(ddc_service, HDMI_IDCC_SCOPE_RW_CA,
+				ddc_service->link->hdmi_cable_id.raw, 0,
+				sizeof(ddc_service->link->hdmi_cable_id.raw));
+
+		bool de_emphasis_only = false;
+		bool pre_shoot_only = false;
+		bool no_ffe = false;
+
+		hdmi_return_preeshoot_and_deemphasis(ddc_service->link, &test_req,
+			&de_emphasis_only, &pre_shoot_only, &no_ffe);
+
+		dio_link_enc->funcs->prog_eq_setting(dio_link_enc, 0,
+			de_emphasis_only,
+			pre_shoot_only,
+			no_ffe,
+			link_settings);
+
+		write_buffer[0] = HDMI_SCDC_UPDATE_0;
+		/*FLT_update - bit 5*/
+		write_buffer[1] = (scdc_update.fields.FLT_UPDATE << 5);
+		link_query_ddc_data(ddc_service, slave_address,
+				write_buffer, sizeof(write_buffer), NULL, 0);
+
+		return LINK_RESULT_NO_TIMEOUT;
+	}
+
+	ddc_service->link->frl_flags.no_timeout = false;
 
 	if (status_data.fields.FLT_READY) {
 		/*Specify FRL rate*/
@@ -534,9 +615,7 @@ static enum link_result hdmi_frl_perform_link_training(struct ddc_service *ddc_s
 		/*Start FLT Timer = 200 ms, or 300ms if link rate >= 16Gbps*/
 		num_polls = 0;
 		if (link_settings->frl_link_rate >= HDMI_FRL_LINK_RATE_16GBPS)
-			poll_timeout_ns = 300 * 1000 * 1000;
-		if (flt_no_timeout)
-			poll_timeout_ns = 1000 * 1000 * 1000;
+			poll_timeout_ns = 320 * 1000 * 1000;
 
 		flt_poll_start = dm_get_timestamp(ddc_service->ctx);
 		uint8_t prev_flt_update = 0;
@@ -561,21 +640,9 @@ static enum link_result hdmi_frl_perform_link_training(struct ddc_service *ddc_s
 				prev_flt_update = scdc_update.fields.FLT_UPDATE;
 			}
 
-			if (flt_no_timeout) {
-				offset = HDMI_SCDC_SOURCE_TEST_REQ;
-				link_query_ddc_data(ddc_service, slave_address, &offset,
-						sizeof(offset), &test_req.byte, sizeof(test_req.byte));
-				if (test_req.fields.FLT_NO_TIMEOUT == 0) {
-					FRL_INFO("FRL TEST REQ:  FLT_no_timeout = %d \n", test_req.fields.FLT_NO_TIMEOUT);
-					return LINK_RESULT_SUCCESS;
-				}
-			}
-
 			/*Set TxFFE = TxFFE0*/
 			/*Program FFE_Levels - scdc_config has this field at 0 */
 			if (override_FFE) {
-				if (flt_no_timeout)
-					current_FFE = 0;
 				if (current_FFE == 0)
 					dio_link_enc->funcs->prog_eq_setting(dio_link_enc, current_FFE,
 							test_req.fields.TXFFE_DEEMPHASIS,
@@ -626,8 +693,7 @@ static enum link_result hdmi_frl_perform_link_training(struct ddc_service *ddc_s
 
 				if (ln0_pattern == 0x03 || ln1_pattern == 0x03 ||
 						ln2_pattern == 0x03 || ln3_pattern == 0x03)
-					if (!flt_no_timeout)
-						continue;
+					continue;
 
 				if (link_settings->frl_num_lanes == 3) {
 					ln3_pattern = 1;
@@ -651,8 +717,6 @@ static enum link_result hdmi_frl_perform_link_training(struct ddc_service *ddc_s
 						override_FFE = true;
 						if (current_FFE > FFE_Levels)
 							current_FFE = 0;
-						if (flt_no_timeout)
-							current_FFE = 0;
 					}
 				} else {
 					if (!ln0_pattern && !ln1_pattern && !ln2_pattern && !ln3_pattern) {
@@ -677,8 +741,6 @@ static enum link_result hdmi_frl_perform_link_training(struct ddc_service *ddc_s
 						override_FFE = true;
 						if (current_FFE > FFE_Levels)
 							current_FFE = 0;
-						if (flt_no_timeout)
-							current_FFE = 0;
 					}
 				}
 
@@ -733,7 +795,7 @@ enum link_result hdmi_frl_perform_link_training_with_retries(
 
 	/* FRL Link Training */
 	while (status != LINK_RESULT_FALLBACK) {
-		if (status == LINK_RESULT_SUCCESS) {
+		if (status == LINK_RESULT_SUCCESS || status == LINK_RESULT_NO_TIMEOUT) {
 			break;
 		} else if (status == LINK_RESULT_LOWER_LINKRATE) {
 			FRL_INFO("FRL LINK TRAINING:  Sink requested lower link rate during link enable. \n");
@@ -780,6 +842,9 @@ enum link_result hdmi_frl_perform_link_training_with_fallback(
 		status = hdmi_frl_perform_link_training(link->ddc,
 				&link->frl_link_settings);
 
+		if (status == LINK_RESULT_NO_TIMEOUT)
+			break;
+
 		link->dc->hwss.disable_link_output(link, link_res, SIGNAL_TYPE_HDMI_FRL);
 
 		if (status == LINK_RESULT_SUCCESS)
@@ -892,7 +957,7 @@ void hdmi_frl_verify_link_cap(struct dc_link *link,
 
 	status = hdmi_frl_perform_link_training_with_fallback(link, &link_res, frl_phy_clock_source_id);
 
-	if (status == LINK_RESULT_SUCCESS) {
+	if (status == LINK_RESULT_SUCCESS || status == LINK_RESULT_NO_TIMEOUT) {
 		cur->frl_link_rate = link->frl_link_settings.frl_link_rate;
 		cur->frl_num_lanes = link->frl_link_settings.frl_num_lanes;
 		success = true;
-- 
2.43.0

