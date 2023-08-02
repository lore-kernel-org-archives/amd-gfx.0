Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D65C001DE
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 06:52:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C009110E4A9;
	Wed,  2 Aug 2023 06:52:10 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C89D110E4A9
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Aug 2023 06:52:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHkGd/4rJDLmeJsnyDe3k9fxlL0O8N+XsqMS8KDuIl42LheBnFQB8r0JG8JdmWw0S+gAF3oDzCupfPnnzUtWVsVbV9k33SoGbtGMwqnc5E+s8evgfK9nj2RIM81kMREI+ZMOl56jmdEsMRvkb/HeJiHJHYCQsA9filajqfBm+T/7ou590ztfe0S1pydEKBrzdM1OhZCttDnpNgl4hBRaj3X3lTbHT+4hTsTUKgISaX2ZgupMf4xZ/s3Yc1lDVy+qO6ytXvr2+yFdl+TizTcOhLFFOiFmE57sXtFR6MKYsfB9kyidUlIB5F2kAx4TDnpGfNvSWbzezPVEeUKQV5bAsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9ShuwRRYHysB5UJmOefxrWlL5eUBi8RZ2PAwyHaQWM=;
 b=DVdWnoU8219PwNssnDzucaZcTyGP0UJuiUtjW+Ih9m6f0dalSwLe385CwPE4ATH9SpBGi7xQE/BW4cCZuhdUdPOQaSKL/wxIT6isQ/Vd4CYjQXv3EG1XsnNr9wbPK+jUWR2T6X6+oK3ckwMBP3/gMkh+rr/OqueG1JBEjxD8X55tYsTCBZMUvSykbAgydfcFEICbBb97l3opcfdOPkQ4u/rqW0Tx0gIxZRHwosqS/8RwRJlET+FV9EpGKmcOZKeqfjYjFixo6eZg32PuQTQUQ28/EtGvH4/eQSSRYYJGHgCS/yO7q5R/0vdnOmzl3cG/kArV/gcBJVsU+Wv/Q0DCIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9ShuwRRYHysB5UJmOefxrWlL5eUBi8RZ2PAwyHaQWM=;
 b=s8alRvsaasGxHrQXK5rkerQivMxYeUEaBzvxlJvJjtIDbhJyN8zXjwJkBM1Qg6l5XAojnrLzAmpFJhNstbhGZYqyINJKVC4S6js0zVnkZRTYA9r+1JTEjy2cuOFlYt1NizxBg0KTr643iHDratHNRwx1j6RRsIQyxop2fi5HZ4U=
Received: from PH8PR15CA0017.namprd15.prod.outlook.com (2603:10b6:510:2d2::7)
 by SN7PR12MB7022.namprd12.prod.outlook.com (2603:10b6:806:261::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 06:52:06 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:510:2d2:cafe::20) by PH8PR15CA0017.outlook.office365.com
 (2603:10b6:510:2d2::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Wed, 2 Aug 2023 06:52:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 06:52:05 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 01:52:05 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 1 Aug
 2023 23:52:04 -0700
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 2 Aug 2023 01:51:56 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/22] drm/amd/display: Add interface to enable DPIA trace
Date: Wed, 2 Aug 2023 14:51:12 +0800
Message-ID: <20230802065132.3129932-3-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
References: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|SN7PR12MB7022:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d9a354d-e92e-4971-58d1-08db9324fbce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f6MKVcpqXwhNTjcHQaYMh+wW26D2T9bYyNWgDKZXxdWrckMQqV7659zZv0OdeDLymMy0/8JZhQBdVRz125kj6dLS5rf9oJ6U8ZgyCFuFFFiCx7byq8CM2fkc45CjTUGf3JE8hsRltGjz1GFB/X7/y58PlfHftsrlDmjjXvIvUHRhOXL/sHR3GHJhr17aRayrmHEevahp1tjWDn78qLYz84pY3ujnUvY4MXgu95FpPR90MnXDP52n51vtUDchCiFYd0XEDoJ+Dvjc7NUtf83b2EPQeDGgApSGauqDkK/RXNxR18u/xSCDnM/QY8BRF6E7ag+RRbb8FRPyz2ByNho33vf2piKQUhZiN0XMXXIM6XiLSbEi3E/uw+hquWiJF95V30PinoYGBrWxDZvlOpsaqKAJM8B2WKQpN2b0sf+oo3oMlAnzghNuPdVVaib3Q82XL2U2ZQu9KqErFsvMgWohRrIwCz2DZ046mYx1g9BiwqxJF4Ui1g6oL57grBgajle5ZiX4HOJbZWnr5RB1WSDz71AB5I4+hdiWqfX0vBrBviX/ACYXdlEsh2ruhAdGUuvL9QCKaqhjOXtRVxSDobqwUjJacQ91NXtQZJt+R8p5ibQdpXsGgqOzPmAT9n1paz2NjJxXMcmZB+qfvQcI5OkRjrWQkKVciLO8fRan8zRFGLm2zgA6XIv13qLBnxXhNhetTlm+npsu/Tbq1V5jJi7vn/idpBvJVi/FzNQd5fUeFBUu8wnWGPZ/5nVMWwGbcVGFaaBx3kPmkJ0gw4RdG6EI/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(40480700001)(336012)(186003)(40460700003)(2616005)(36756003)(316002)(86362001)(478600001)(81166007)(54906003)(70586007)(70206006)(6666004)(7696005)(4326008)(6916009)(82740400003)(356005)(26005)(1076003)(41300700001)(8936002)(8676002)(426003)(47076005)(83380400001)(36860700001)(5660300002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 06:52:05.5299 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d9a354d-e92e-4971-58d1-08db9324fbce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7022
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Stylon Wang <stylon.wang@amd.com>

[Why]
DPIA traces from DMUB is not enabled by default, which is
less convenient to debug DPIA related issues because we have
to resort to other debug tools to enable DPIA trace.

[How]
Exposes interfaces to update trace mask from the DMUB GPING commands.
Also provides DC implementations to enable DPIA trace.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 29 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  3 ++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 18 ++++++++++++
 3 files changed, 50 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 24433409d7de..8c75f7510880 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1021,3 +1021,32 @@ bool dc_dmub_check_min_version(struct dmub_srv *srv)
 		return true;
 	return srv->hw_funcs.is_psrsu_supported(srv);
 }
+
+void dc_dmub_srv_enable_dpia_trace(const struct dc *dc)
+{
+	struct dc_dmub_srv *dc_dmub_srv = dc->ctx->dmub_srv;
+	struct dmub_srv *dmub;
+	enum dmub_status status;
+	static const uint32_t timeout_us = 30;
+
+	if (!dc_dmub_srv || !dc_dmub_srv->dmub) {
+		DC_LOG_ERROR("%s: invalid parameters.", __func__);
+		return;
+	}
+
+	dmub = dc_dmub_srv->dmub;
+
+	status = dmub_srv_send_gpint_command(dmub, DMUB_GPINT__SET_TRACE_BUFFER_MASK_WORD1, 0x0010, timeout_us);
+	if (status != DMUB_STATUS_OK) {
+		DC_LOG_ERROR("timeout updating trace buffer mask word\n");
+		return;
+	}
+
+	status = dmub_srv_send_gpint_command(dmub, DMUB_GPINT__UPDATE_TRACE_BUFFER_MASK, 0x0000, timeout_us);
+	if (status != DMUB_STATUS_OK) {
+		DC_LOG_ERROR("timeout updating trace buffer mask word\n");
+		return;
+	}
+
+	DC_LOG_DEBUG("Enabled DPIA trace\n");
+}
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index 099f94b6107c..bb3fe162dd93 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -87,4 +87,7 @@ void dc_dmub_srv_log_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv);
 
 void dc_send_update_cursor_info_to_dmu(struct pipe_ctx *pCtx, uint8_t pipe_idx);
 bool dc_dmub_check_min_version(struct dmub_srv *srv);
+
+void dc_dmub_srv_enable_dpia_trace(const struct dc *dc);
+
 #endif /* _DMUB_DC_SRV_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index adde1d84d773..f849d0159720 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -658,6 +658,24 @@ enum dmub_gpint_command {
 	 * DESC: Notifies DMCUB detection is done so detection required can be cleared.
 	 */
 	DMUB_GPINT__NOTIFY_DETECTION_DONE = 12,
+	/**
+	 * DESC: Updates the trace buffer lower 32-bit mask.
+	 * ARGS: The new mask
+	 * RETURN: Lower 32-bit mask.
+	 */
+	DMUB_GPINT__UPDATE_TRACE_BUFFER_MASK = 101,
+	/**
+	 * DESC: Updates the trace buffer lower 32-bit mask.
+	 * ARGS: The new mask
+	 * RETURN: Lower 32-bit mask.
+	 */
+	DMUB_GPINT__SET_TRACE_BUFFER_MASK_WORD0 = 102,
+	/**
+	 * DESC: Updates the trace buffer mask bi0~bit15.
+	 * ARGS: The new mask
+	 * RETURN: Lower 32-bit mask.
+	 */
+	DMUB_GPINT__SET_TRACE_BUFFER_MASK_WORD1 = 103,
 };
 
 /**
-- 
2.25.1

