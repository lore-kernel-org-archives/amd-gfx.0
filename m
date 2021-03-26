Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A56C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 22:06:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA69A61A28
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 22:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA69A61A28
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 547EF6F4B5;
	Fri, 26 Mar 2021 22:06:00 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16BB36F4A8
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 22:05:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6tRE8QUjdmbUe1MVA2t13nNk4Ib7UjgafchLwVFpdKUm4A55YNSAAf3Isi2LDiUoXrhQ/8iqzCJV/kYPv1j6k0mW9296hcqubr/pjQ3o8UX5Ec6G0ECYcx4+s/Swq4K7Tu9+sAyzmWexpD8eqGoUuD7as1bmr526re7moosswbV7sxBwnEUfJXuJewzXvf10LH/uOOxeRM5VYLCxdFiCQWJ424nyFuvdYGtInMmfc0b4sLCyaG/PmvrPsXoC4LAk+aeaXaH5YMbZtwBMAlMCfGU757Lvr9hTcPyw5yWjD4n5kwXfpr/6rmEuLqtyH63icWM5PKCy0JPQlM2oNpYfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0orticHPlxrWsFzUxHhVa/fyu6zY2f0EpArUBqytkpA=;
 b=MzbpC1q45zvr11LvK4c0YDo4luCJs84OuEFE/Hs/rg+UaFLki7jq9C9/3yhfI4r1f5fWd8HSfx78Iduyr+toLmuIJW76UccZNU3+/7dn+qK/pNF39O7qg3emiaw7p9kYsKiRiN+geht0ePi+DbNSs9FQGHQ7bWPghC2US0gvsxg0anb3Ja1wh3Nsry/15rLSDzVuzAwSza8VBjz/fdy4gAnP3FNaLF1IKb7m3csUE9L0SZsxsQYs7kjHMhDE1nX4a/a1M9MmoDnvGlWvf1UMQK5uVXf7OSsq38hiVvMfaO0n7HzCZE1kteQqpfD78hpw2cA/LoDuxdLYNczo6IXvUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0orticHPlxrWsFzUxHhVa/fyu6zY2f0EpArUBqytkpA=;
 b=WHybfwpTq0sc8EK672VWIjVG8B7bV+EBfhXsSq5wIXnBPueJfLIj4y6m2Iqs+Zog9TfM082EC8iimshHAYjWw3rd+aEr/QH8/z0jJmyM8bcDpjIVZh/Gx7WwewqllQhdMVfJvmeo9mDj0J25VfUehaUfyWiqbjZfYlWUSOJ0yOw=
Received: from DM5PR04CA0028.namprd04.prod.outlook.com (2603:10b6:3:12b::14)
 by BN6PR1201MB0132.namprd12.prod.outlook.com (2603:10b6:405:4d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Fri, 26 Mar
 2021 22:05:55 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:12b:cafe::c9) by DM5PR04CA0028.outlook.office365.com
 (2603:10b6:3:12b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend
 Transport; Fri, 26 Mar 2021 22:05:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Fri, 26 Mar 2021 22:05:54 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 26 Mar
 2021 17:05:54 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 26 Mar
 2021 17:05:53 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Fri, 26 Mar 2021 17:05:52 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/21] drm/amd/display: add mod hdcp interface for supporting
 encryption state query
Date: Fri, 26 Mar 2021 18:05:20 -0400
Message-ID: <20210326220534.918023-8-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326220534.918023-1-Anson.Jacob@amd.com>
References: <20210326220534.918023-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19228b8e-4ba8-4d74-fd0a-08d8f0a353a7
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0132:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB01328BC3322080818950A89FEB619@BN6PR1201MB0132.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:153;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SzZIcW4KNxOAgpdODWR3bJWnfcRakFohb+yynx4uvmYRutg+ewqKAPC7gWJoM6YNjiuye5PLt5yslSZtKEhMlm3wbDCAWL2P6s2bedIcO//Q07rYlj25/v4/dxDu2HmSy9cyfUnwK6/eirZi7nSe/yhEx6SO0Fp5dUdE1A3az4mF2WIJj7fxp6W7ZCQCuYOWhII+nD2H/kbZBrCohVYThKkU4NcXzZllekiX4wKh2dzbOKruoOLGKUk65SVZ+dZxp2pD/IknmK6A1775wDpoOq89vC4jw3WRs/9Nfqb/6rM1Tq+XpzzwQ2+FER/f3yCqPkJyfVsb3bycjZyci9ttIJJ2SkLKmSjRwmSlZ5sh4Fze79UL1jQIDIoq0EcVC69cuMAtPalMxzmVX1RSaNpnDtfTCU0eG3Ll81SO1bnmvqkcsvTjJNnw7LPN2Z+cWjJOYdoYphsZ7txk4zyJ3pPsdCyjNZAwTdb0Qw1ZSZljvY2qjTiExbrYzq4+7WjtS+XClGJdp5JHwDu/st0H44mzxjo7IIljXMlizKgJnpRGUZ6wY897FN3/j61CvQG4C10yYbHPBhqwLHJ7Y3CE/W7Q1IxH8If67Hgpe1aiHuNfH3VH2xlnRgkedATO/J4jP2PXDjobqpWEUheh8L04/9xd+iNIQ4wPYAfD6U35FSDuV5EIOs/kr7b21To4Dpu360d2
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(46966006)(36840700001)(26005)(8936002)(70206006)(82740400003)(81166007)(82310400003)(356005)(70586007)(6916009)(6666004)(54906003)(478600001)(4326008)(7696005)(47076005)(2616005)(2906002)(83380400001)(86362001)(5660300002)(1076003)(186003)(426003)(36756003)(36860700001)(8676002)(316002)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 22:05:54.5839 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19228b8e-4ba8-4d74-fd0a-08d8f0a353a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0132
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, George Shen <George.Shen@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Reviewed-by: George Shen <George.Shen@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 .../gpu/drm/amd/display/modules/hdcp/hdcp.c   |  6 +++
 .../gpu/drm/amd/display/modules/hdcp/hdcp.h   |  4 +-
 .../display/modules/hdcp/hdcp1_execution.c    | 37 +++++++++++--------
 .../display/modules/hdcp/hdcp1_transition.c   |  6 +--
 .../display/modules/hdcp/hdcp2_execution.c    | 10 +++--
 .../display/modules/hdcp/hdcp2_transition.c   | 10 ++---
 .../drm/amd/display/modules/hdcp/hdcp_psp.c   | 10 +++++
 7 files changed, 54 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
index e7b841d960e7..68a6481d7f8f 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
@@ -314,6 +314,9 @@ enum mod_hdcp_status mod_hdcp_add_display(struct mod_hdcp *hdcp,
 		goto out;
 	}
 
+	/* save current encryption states to restore after next authentication */
+	mod_hdcp_save_current_encryption_states(hdcp);
+
 	/* reset existing authentication status */
 	status = reset_authentication(hdcp, output);
 	if (status != MOD_HDCP_STATUS_SUCCESS)
@@ -360,6 +363,9 @@ enum mod_hdcp_status mod_hdcp_remove_display(struct mod_hdcp *hdcp,
 		goto out;
 	}
 
+	/* save current encryption states to restore after next authentication */
+	mod_hdcp_save_current_encryption_states(hdcp);
+
 	/* stop current authentication */
 	status = reset_authentication(hdcp, output);
 	if (status != MOD_HDCP_STATUS_SUCCESS)
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
index 5c22cf7e6118..3ce91db560d1 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
@@ -331,6 +331,8 @@ enum mod_hdcp_status mod_hdcp_add_display_to_topology(
 		struct mod_hdcp *hdcp, struct mod_hdcp_display *display);
 enum mod_hdcp_status mod_hdcp_remove_display_from_topology(
 		struct mod_hdcp *hdcp, uint8_t index);
+bool mod_hdcp_is_link_encryption_enabled(struct mod_hdcp *hdcp);
+void mod_hdcp_save_current_encryption_states(struct mod_hdcp *hdcp);
 enum mod_hdcp_status mod_hdcp_hdcp1_create_session(struct mod_hdcp *hdcp);
 enum mod_hdcp_status mod_hdcp_hdcp1_destroy_session(struct mod_hdcp *hdcp);
 enum mod_hdcp_status mod_hdcp_hdcp1_validate_rx(struct mod_hdcp *hdcp);
@@ -339,8 +341,6 @@ enum mod_hdcp_status mod_hdcp_hdcp1_validate_ksvlist_vp(struct mod_hdcp *hdcp);
 enum mod_hdcp_status mod_hdcp_hdcp1_enable_dp_stream_encryption(
 	struct mod_hdcp *hdcp);
 enum mod_hdcp_status mod_hdcp_hdcp1_link_maintenance(struct mod_hdcp *hdcp);
-enum mod_hdcp_status mod_hdcp_hdcp1_get_link_encryption_status(struct mod_hdcp *hdcp,
-							       enum mod_hdcp_encryption_status *encryption_status);
 enum mod_hdcp_status mod_hdcp_hdcp2_create_session(struct mod_hdcp *hdcp);
 enum mod_hdcp_status mod_hdcp_hdcp2_destroy_session(struct mod_hdcp *hdcp);
 enum mod_hdcp_status mod_hdcp_hdcp2_prepare_ake_init(struct mod_hdcp *hdcp);
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
index 73ca49f05bd3..eeac14300a2a 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
@@ -256,10 +256,12 @@ static enum mod_hdcp_status authenticated(struct mod_hdcp *hdcp,
 		goto out;
 	}
 
-	if (!mod_hdcp_execute_and_set(mod_hdcp_hdcp1_link_maintenance,
+	mod_hdcp_execute_and_set(mod_hdcp_hdcp1_link_maintenance,
 			&input->link_maintenance, &status,
-			hdcp, "link_maintenance"))
-		goto out;
+			hdcp, "link_maintenance");
+
+	if (status != MOD_HDCP_STATUS_SUCCESS)
+		mod_hdcp_save_current_encryption_states(hdcp);
 out:
 	return status;
 }
@@ -425,19 +427,24 @@ static enum mod_hdcp_status authenticated_dp(struct mod_hdcp *hdcp,
 		event_ctx->unexpected_event = 1;
 		goto out;
 	}
-
-	if (!mod_hdcp_execute_and_set(mod_hdcp_read_bstatus,
-			&input->bstatus_read, &status,
-			hdcp, "bstatus_read"))
-		goto out;
-	if (!mod_hdcp_execute_and_set(check_link_integrity_dp,
-			&input->link_integrity_check, &status,
-			hdcp, "link_integrity_check"))
-		goto out;
-	if (!mod_hdcp_execute_and_set(check_no_reauthentication_request_dp,
-			&input->reauth_request_check, &status,
-			hdcp, "reauth_request_check"))
+	if (!mod_hdcp_is_link_encryption_enabled(hdcp))
 		goto out;
+
+	if (status == MOD_HDCP_STATUS_SUCCESS)
+		mod_hdcp_execute_and_set(mod_hdcp_read_bstatus,
+				&input->bstatus_read, &status,
+				hdcp, "bstatus_read");
+	if (status == MOD_HDCP_STATUS_SUCCESS)
+		mod_hdcp_execute_and_set(check_link_integrity_dp,
+				&input->link_integrity_check, &status,
+				hdcp, "link_integrity_check");
+	if (status == MOD_HDCP_STATUS_SUCCESS)
+		mod_hdcp_execute_and_set(check_no_reauthentication_request_dp,
+				&input->reauth_request_check, &status,
+				hdcp, "reauth_request_check");
+
+	if (status != MOD_HDCP_STATUS_SUCCESS)
+		mod_hdcp_save_current_encryption_states(hdcp);
 out:
 	return status;
 }
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c
index 24ab95b093f7..3dda8c1d83fc 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c
@@ -93,7 +93,7 @@ enum mod_hdcp_status mod_hdcp_hdcp1_transition(struct mod_hdcp *hdcp,
 		}
 		break;
 	case H1_A45_AUTHENTICATED:
-		if (input->link_maintenance != PASS) {
+		if (input->link_maintenance == FAIL) {
 			/* 1A-07: consider invalid ri' a failure */
 			/* 1A-07a: consider read ri' not returned a failure */
 			fail_and_restart_in_ms(0, &status, output);
@@ -243,8 +243,8 @@ enum mod_hdcp_status mod_hdcp_hdcp1_dp_transition(struct mod_hdcp *hdcp,
 		}
 		break;
 	case D1_A4_AUTHENTICATED:
-		if (input->link_integrity_check != PASS ||
-				input->reauth_request_check != PASS) {
+		if (input->link_integrity_check == FAIL ||
+				input->reauth_request_check == FAIL) {
 			/* 1A-07: restart hdcp on a link integrity failure */
 			fail_and_restart_in_ms(0, &status, output);
 			break;
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
index a0895a7efda2..f164f6a5d4dc 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
@@ -564,11 +564,13 @@ static enum mod_hdcp_status authenticated(struct mod_hdcp *hdcp,
 		event_ctx->unexpected_event = 1;
 		goto out;
 	}
-
-	if (!process_rxstatus(hdcp, event_ctx, input, &status))
-		goto out;
-	if (event_ctx->rx_id_list_ready)
+	if (!mod_hdcp_is_link_encryption_enabled(hdcp))
 		goto out;
+
+	process_rxstatus(hdcp, event_ctx, input, &status);
+
+	if (status != MOD_HDCP_STATUS_SUCCESS)
+		mod_hdcp_save_current_encryption_states(hdcp);
 out:
 	return status;
 }
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_transition.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_transition.c
index e738c7ae66ec..b0306ed6d6b4 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_transition.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_transition.c
@@ -245,8 +245,8 @@ enum mod_hdcp_status mod_hdcp_hdcp2_transition(struct mod_hdcp *hdcp,
 		HDCP_FULL_DDC_TRACE(hdcp);
 		break;
 	case H2_A5_AUTHENTICATED:
-		if (input->rxstatus_read != PASS ||
-				input->reauth_request_check != PASS) {
+		if (input->rxstatus_read == FAIL ||
+				input->reauth_request_check == FAIL) {
 			fail_and_restart_in_ms(0, &status, output);
 			break;
 		} else if (event_ctx->rx_id_list_ready && conn->is_repeater) {
@@ -562,11 +562,11 @@ enum mod_hdcp_status mod_hdcp_hdcp2_dp_transition(struct mod_hdcp *hdcp,
 		HDCP_FULL_DDC_TRACE(hdcp);
 		break;
 	case D2_A5_AUTHENTICATED:
-		if (input->rxstatus_read != PASS ||
-				input->reauth_request_check != PASS) {
+		if (input->rxstatus_read == FAIL ||
+				input->reauth_request_check == FAIL) {
 			fail_and_restart_in_ms(0, &status, output);
 			break;
-		} else if (input->link_integrity_check_dp != PASS) {
+		} else if (input->link_integrity_check_dp == FAIL) {
 			if (hdcp->connection.hdcp2_retry_count >= 1)
 				adjust->hdcp2.force_type = MOD_HDCP_FORCE_TYPE_0;
 			fail_and_restart_in_ms(0, &status, output);
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
index 904ce9b88088..9d7ca316dc3f 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
@@ -914,3 +914,13 @@ enum mod_hdcp_status mod_hdcp_hdcp2_validate_stream_ready(struct mod_hdcp *hdcp)
 	return status;
 }
 
+bool mod_hdcp_is_link_encryption_enabled(struct mod_hdcp *hdcp)
+{
+	/* unsupported */
+	return true;
+}
+
+void mod_hdcp_save_current_encryption_states(struct mod_hdcp *hdcp)
+{
+	/* unsupported */
+}
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
