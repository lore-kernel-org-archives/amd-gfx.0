Return-Path: <SRS0=oGIb=MQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC33EC4320A
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Jul 2021 04:11:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BDCE60EAF
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Jul 2021 04:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9BDCE60EAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53B176FE60;
	Sat, 24 Jul 2021 04:11:42 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2081.outbound.protection.outlook.com [40.107.102.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AF886FE5F
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Jul 2021 04:11:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkeWyLLdq4bggZc3wuOhGP66E2gYTksZENCB2F3a7S5wtaZvihQkfa85SOuxOsCYV5T1YvgqXkzgdM/GomIxeRRGMdD1/qjXu+p7QBDPpulyYgydQ+ziSIZBpGGUn7NDUDxSQ8P9+rkFEI8Ip12VWuPXtNMdMy/5Js5WPnUxj4HabnboHRkeLWjR6MWJZgJy14+8S1cPyAWbEtlpltoggpR+hwMUBGxt0HBFIcWkbRiRIQIyuRabfF0e0GkDM47YdyJ7GgHjynfUcaudcxRRdbQ3eHVapzpep0rlgLLSICd5IK4ysz42dm8r7V4RPlrou/NXgyhsqi/yOdlIt9QGoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDnqjaFUpB3bm7nVn74qMdDiYdfwRU0DO+/wui65ooo=;
 b=WHBNOBFvj+Rx2ZcHb6heL3Vzomst904LfJ1MSBdhUboVu09N/BjJ0PrgQqfO2iDubklpO5paawxltBlcTgHMCtIcbiJijZYypYHDf31cEzQt+F0+eYcwEv3iT4bov1r8THjY65s0QnBl36voedzB3wf/NSj7afHtErWbftwHF3BHQlNrO+p/BxV+V0YGHdQ61qKa0wwAEsE4rZqlvrMT2PAHz2H1Z8UMLsksn/TFQRKa5NpdDq+dhAkI7Z76PYEzhkabRm34Au0VxaiQXLs+IoOQy/uTOVp6l9ML4OC94T705RqaFsxfuWbrJE9RkDhsa2zbRJMUBOVpd4kWGXRpsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDnqjaFUpB3bm7nVn74qMdDiYdfwRU0DO+/wui65ooo=;
 b=tyzFpqJlgAXzg6HoPg9VZT/BkL8vjqsrSs/+uC5FzlyvAU2PUUobskgrZos48yXp1yHPkjWCeNs0KGA5aHsdkjlnbaFOIDcfZSoF+TlR9NT4F4/FTUXgsTwrG+VJOdB9e+iAxEQVUHJ3xOCgu2GNyEsn2NzDXSvnOrXuC0yb/gQ=
Received: from BN9PR03CA0637.namprd03.prod.outlook.com (2603:10b6:408:13b::12)
 by MWHPR1201MB2509.namprd12.prod.outlook.com (2603:10b6:300:e5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Sat, 24 Jul
 2021 04:11:34 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::4) by BN9PR03CA0637.outlook.office365.com
 (2603:10b6:408:13b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend
 Transport; Sat, 24 Jul 2021 04:11:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Sat, 24 Jul 2021 04:11:33 +0000
Received: from solomon-t14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 23 Jul
 2021 23:11:30 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/14] drm/amd/display: remove unused functions
Date: Sat, 24 Jul 2021 12:09:56 +0800
Message-ID: <20210724041001.3875757-10-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210724041001.3875757-4-solomon.chiu@amd.com>
References: <20210724041001.3875757-4-solomon.chiu@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fc83655-d1c7-47e0-bc36-08d94e591f98
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2509:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB25096B2D7F2CA56F784517C497E69@MWHPR1201MB2509.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 12QMlu6K9RA8QW4/hNk+Tz8bW0dg+H77mgr6PlMDIKX6hrEaWeAISNnaobT7kKv+kcKQd7lhJFoYL9YHQXnAtutPVvYJ6txMLTSwXZbfKLlcn7DCG7NGiJlIXrip7k1EhcW7PAq1j+i7Nc6Ebev6/5uOxdZDBKhyiQdCoE3DzAu8B/esDGQXq1oAthIizXiS7bxM72OhsVvIa27R3D6K/ig9jKQ49W5ACm+E4WEUrloIaSrTMMONkm+YT4bmrq+Moxg6p3D7Hc7UCoACA/S0rQ+ip6dvyDtixj6OfdYQskd/GjxUxE6g8ldf59kfJ5KV7pevs2G3oc+eTEZ6tSAGozQECC8sbN/FpjFJcuydt81gvP87o1mwenEw5iEOQr6bc/vxGq57/KTgq7xE0B/eNY0wy/pnwdLuSAGZvEh2/vSK3wudCUzrLUe/KDXntVDNUkJV3Dqe5MGscE9N05a7cktar3wYA7SSAGfZyISVNd1ieJLLzJoVsFHAFf05xDGhlr75RP94lL1d7Kz/OUQDYh0rZIC1kC7b4Lf5RSE59Ezd7tMIL/Sk9j+FGWYtyGBD8pqcilC4gOQPduK83cfHtH4ynt8DjbUOaE8udX1Q4lcfmn9PYDtAoHmT34iq8SHqngnrfNlP2p93v78CvKSRHIkn7JTkydn/QGXUGecziH/4ovH/SwtmgsGnOW6frpxB3drqUbvrVdKr+EgNc57U9nQDQ7OdS9w3kxWvJwoLQdk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(46966006)(36840700001)(54906003)(7696005)(8676002)(81166007)(2616005)(6916009)(5660300002)(4326008)(44832011)(316002)(86362001)(426003)(26005)(70586007)(6666004)(70206006)(36756003)(478600001)(47076005)(1076003)(2906002)(82310400003)(83380400001)(356005)(186003)(336012)(16526019)(82740400003)(36860700001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2021 04:11:33.8255 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc83655-d1c7-47e0-bc36-08d94e591f98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2509
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
Cc: Solomon Chiu <solomon.chiu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
It has been decided that opm state query support will be dropped.
Therefore link encryption enabled and save current encryption states
won't be used anymore and there are no foreseeable usages in the future.
We will remove these two interfaces for clean up.

Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |  4 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.c   |  6 ---
 .../gpu/drm/amd/display/modules/hdcp/hdcp.h   |  2 -
 .../display/modules/hdcp/hdcp1_execution.c    |  6 ---
 .../display/modules/hdcp/hdcp2_execution.c    |  3 --
 .../drm/amd/display/modules/hdcp/hdcp_psp.c   | 53 ++++++++-----------
 .../drm/amd/display/modules/inc/mod_hdcp.h    |  1 -
 7 files changed, 22 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index e63c6885c757..8e39e9245d06 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -655,10 +655,8 @@ struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev, struct
 		INIT_DELAYED_WORK(&hdcp_work[i].property_validate_dwork, event_property_validate);
 
 		hdcp_work[i].hdcp.config.psp.handle = &adev->psp;
-		if (dc->ctx->dce_version == DCN_VERSION_3_1) {
+		if (dc->ctx->dce_version == DCN_VERSION_3_1)
 			hdcp_work[i].hdcp.config.psp.caps.dtm_v3_supported = 1;
-			hdcp_work[i].hdcp.config.psp.caps.opm_state_query_supported = false;
-		}
 		hdcp_work[i].hdcp.config.ddc.handle = dc_get_link_at_index(dc, i);
 		hdcp_work[i].hdcp.config.ddc.funcs.write_i2c = lp_write_i2c;
 		hdcp_work[i].hdcp.config.ddc.funcs.read_i2c = lp_read_i2c;
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
index 2bcab9c9b96e..06d60f031a06 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
@@ -315,9 +315,6 @@ enum mod_hdcp_status mod_hdcp_add_display(struct mod_hdcp *hdcp,
 		goto out;
 	}
 
-	/* save current encryption states to restore after next authentication */
-	mod_hdcp_save_current_encryption_states(hdcp);
-
 	/* reset existing authentication status */
 	status = reset_authentication(hdcp, output);
 	if (status != MOD_HDCP_STATUS_SUCCESS)
@@ -364,9 +361,6 @@ enum mod_hdcp_status mod_hdcp_remove_display(struct mod_hdcp *hdcp,
 		goto out;
 	}
 
-	/* save current encryption states to restore after next authentication */
-	mod_hdcp_save_current_encryption_states(hdcp);
-
 	/* stop current authentication */
 	status = reset_authentication(hdcp, output);
 	if (status != MOD_HDCP_STATUS_SUCCESS)
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
index 3ce91db560d1..7123f0915706 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
@@ -331,8 +331,6 @@ enum mod_hdcp_status mod_hdcp_add_display_to_topology(
 		struct mod_hdcp *hdcp, struct mod_hdcp_display *display);
 enum mod_hdcp_status mod_hdcp_remove_display_from_topology(
 		struct mod_hdcp *hdcp, uint8_t index);
-bool mod_hdcp_is_link_encryption_enabled(struct mod_hdcp *hdcp);
-void mod_hdcp_save_current_encryption_states(struct mod_hdcp *hdcp);
 enum mod_hdcp_status mod_hdcp_hdcp1_create_session(struct mod_hdcp *hdcp);
 enum mod_hdcp_status mod_hdcp_hdcp1_destroy_session(struct mod_hdcp *hdcp);
 enum mod_hdcp_status mod_hdcp_hdcp1_validate_rx(struct mod_hdcp *hdcp);
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
index de872e7958b0..6ec918af3bff 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
@@ -266,9 +266,6 @@ static enum mod_hdcp_status authenticated(struct mod_hdcp *hdcp,
 	mod_hdcp_execute_and_set(mod_hdcp_hdcp1_link_maintenance,
 			&input->link_maintenance, &status,
 			hdcp, "link_maintenance");
-
-	if (status != MOD_HDCP_STATUS_SUCCESS)
-		mod_hdcp_save_current_encryption_states(hdcp);
 out:
 	return status;
 }
@@ -447,9 +444,6 @@ static enum mod_hdcp_status authenticated_dp(struct mod_hdcp *hdcp,
 		mod_hdcp_execute_and_set(check_no_reauthentication_request_dp,
 				&input->reauth_request_check, &status,
 				hdcp, "reauth_request_check");
-
-	if (status != MOD_HDCP_STATUS_SUCCESS)
-		mod_hdcp_save_current_encryption_states(hdcp);
 out:
 	return status;
 }
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
index 117c6b45f718..91c22b96ebde 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
@@ -571,9 +571,6 @@ static enum mod_hdcp_status authenticated(struct mod_hdcp *hdcp,
 	}
 
 	process_rxstatus(hdcp, event_ctx, input, &status);
-
-	if (status != MOD_HDCP_STATUS_SUCCESS)
-		mod_hdcp_save_current_encryption_states(hdcp);
 out:
 	return status;
 }
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
index 1b02056bc8bd..ade86a042398 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
@@ -45,7 +45,7 @@ static void hdcp2_message_init(struct mod_hdcp *hdcp,
 	in->process.msg3_desc.msg_size = 0;
 }
 
-static enum mod_hdcp_status mod_hdcp_remove_display_from_topology_v2(
+static enum mod_hdcp_status remove_display_from_topology_v2(
 		struct mod_hdcp *hdcp, uint8_t index)
 {
 	struct psp_context *psp = hdcp->config.psp.handle;
@@ -81,7 +81,7 @@ static enum mod_hdcp_status mod_hdcp_remove_display_from_topology_v2(
 	return status;
 }
 
-static enum mod_hdcp_status mod_hdcp_remove_display_from_topology_v3(
+static enum mod_hdcp_status remove_display_from_topology_v3(
 		struct mod_hdcp *hdcp, uint8_t index)
 {
 	struct psp_context *psp = hdcp->config.psp.handle;
@@ -107,7 +107,7 @@ static enum mod_hdcp_status mod_hdcp_remove_display_from_topology_v3(
 	psp_dtm_invoke(psp, dtm_cmd->cmd_id);
 
 	if (dtm_cmd->dtm_status != TA_DTM_STATUS__SUCCESS) {
-		status = mod_hdcp_remove_display_from_topology_v2(hdcp, index);
+		status = remove_display_from_topology_v2(hdcp, index);
 		if (status != MOD_HDCP_STATUS_SUCCESS)
 			display->state = MOD_HDCP_DISPLAY_INACTIVE;
 	} else {
@@ -120,20 +120,7 @@ static enum mod_hdcp_status mod_hdcp_remove_display_from_topology_v3(
 	return status;
 }
 
-enum mod_hdcp_status mod_hdcp_remove_display_from_topology(
-		struct mod_hdcp *hdcp, uint8_t index)
-{
-	enum mod_hdcp_status status = MOD_HDCP_STATUS_UPDATE_TOPOLOGY_FAILURE;
-
-	if (hdcp->config.psp.caps.dtm_v3_supported)
-		status = mod_hdcp_remove_display_from_topology_v3(hdcp, index);
-	else
-		status = mod_hdcp_remove_display_from_topology_v2(hdcp, index);
-
-	return status;
-}
-
-static enum mod_hdcp_status mod_hdcp_add_display_to_topology_v2(
+static enum mod_hdcp_status add_display_to_topology_v2(
 		struct mod_hdcp *hdcp, struct mod_hdcp_display *display)
 {
 	struct psp_context *psp = hdcp->config.psp.handle;
@@ -180,7 +167,7 @@ static enum mod_hdcp_status mod_hdcp_add_display_to_topology_v2(
 	return status;
 }
 
-static enum mod_hdcp_status mod_hdcp_add_display_to_topology_v3(
+static enum mod_hdcp_status add_display_to_topology_v3(
 		struct mod_hdcp *hdcp, struct mod_hdcp_display *display)
 {
 	struct psp_context *psp = hdcp->config.psp.handle;
@@ -220,7 +207,7 @@ static enum mod_hdcp_status mod_hdcp_add_display_to_topology_v3(
 	psp_dtm_invoke(psp, dtm_cmd->cmd_id);
 
 	if (dtm_cmd->dtm_status != TA_DTM_STATUS__SUCCESS) {
-		status = mod_hdcp_add_display_to_topology_v2(hdcp, display);
+		status = add_display_to_topology_v2(hdcp, display);
 		if (status != MOD_HDCP_STATUS_SUCCESS)
 			display->state = MOD_HDCP_DISPLAY_INACTIVE;
 	} else {
@@ -232,15 +219,28 @@ static enum mod_hdcp_status mod_hdcp_add_display_to_topology_v3(
 	return status;
 }
 
+enum mod_hdcp_status mod_hdcp_remove_display_from_topology(
+		struct mod_hdcp *hdcp, uint8_t index)
+{
+	enum mod_hdcp_status status = MOD_HDCP_STATUS_UPDATE_TOPOLOGY_FAILURE;
+
+	if (hdcp->config.psp.caps.dtm_v3_supported)
+		status = remove_display_from_topology_v3(hdcp, index);
+	else
+		status = remove_display_from_topology_v2(hdcp, index);
+
+	return status;
+}
+
 enum mod_hdcp_status mod_hdcp_add_display_to_topology(struct mod_hdcp *hdcp,
 					       struct mod_hdcp_display *display)
 {
 	enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
 
 	if (hdcp->config.psp.caps.dtm_v3_supported)
-		status = mod_hdcp_add_display_to_topology_v3(hdcp, display);
+		status = add_display_to_topology_v3(hdcp, display);
 	else
-		status = mod_hdcp_add_display_to_topology_v2(hdcp, display);
+		status = add_display_to_topology_v2(hdcp, display);
 
 	return status;
 }
@@ -1021,14 +1021,3 @@ enum mod_hdcp_status mod_hdcp_hdcp2_validate_stream_ready(struct mod_hdcp *hdcp)
 	mutex_unlock(&psp->hdcp_context.mutex);
 	return status;
 }
-
-bool mod_hdcp_is_link_encryption_enabled(struct mod_hdcp *hdcp)
-{
-	/* unsupported */
-	return true;
-}
-
-void mod_hdcp_save_current_encryption_states(struct mod_hdcp *hdcp)
-{
-	/* unsupported */
-}
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
index c1b485f5fb71..a6eb86de8d5c 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
@@ -123,7 +123,6 @@ enum mod_hdcp_display_state {
 
 struct mod_hdcp_psp_caps {
 	uint8_t dtm_v3_supported;
-	uint8_t opm_state_query_supported;
 };
 
 enum mod_hdcp_display_disable_option {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
