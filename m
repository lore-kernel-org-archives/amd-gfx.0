Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB70C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Mar 2022 21:48:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95B8610E1D2;
	Fri, 18 Mar 2022 21:48:33 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7A1210E1D2
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Mar 2022 21:48:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ft1Ko7NMaZS0LsqqVXRuXaqrLsPIcv6w7FSwTITjEASJfzexhUY9+ZIN95X7SZEF0mWxRMeDrq+DA7RH/UoPD5UPI+CMyMbebY26D8zHTMVR3P074LAyya0ZzDNYFgX0DgBpv75qbkpGCdaV15VLPSPjouSErB1dxgyi1kF8nM1Un5tDgIR1395DiN2vkoBOy6DhiHf4qVEpMJIZyIoKIZbucqOBjhEsXcpfQeseAcygi8JT1B13cxUIKCkHBDj6QI+CUWAbsvfzRCTOkj/kVAGywNEo/Snq9VQrcLezOfUrt6CLDKte3sccyEW259fpq0Iah1QQVKRLjKT+hkYyew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxG9ku428mte/18zGjoLkBZUr7K4kJegjdFJvsWDA3c=;
 b=lb5M7U0vFFcX6zAuxpJTZneObucuROBAK8dPd+BSmCvu//QpEqk7OJ4aqFWGGhSR1deIgWBGJNgkOCOoxOZqXExo/x7F67LFtVI+TSc21OLWNa5QNToAf01L6jYcS6ChCBjf/Qe4I3VxLEFz6zy8UI2uybinUIJTCR2k5BuP/d9JJ2v5ihLJAmKOKFTUj6OdsdJqtypghSZ0XoIvFHPeHVTiOamDuc0iEV8fdrc44jThjbfYUVpPikfDjwV+b75dMF2a9hcV0HfBHDb/Z1Q7hkU4D/8grpqi0tfc/1FfrtgHAvYSON/zz+4zJuevdmwF9b6Llr+P7DIgpzSp4xVLpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxG9ku428mte/18zGjoLkBZUr7K4kJegjdFJvsWDA3c=;
 b=IRD8v73BH6VtsMN3o3I/VFScdXG4AXvaOtzB7T9o+2SRUwnX5DoWm+Tid82Zfmgaz1UxXwIaiXOgMRe/OUjT41npcuCbV4BfKYo/Dd/jHsnadx9uqHY5bYoE/AR5/vwV9npgVMUBPlAPvziEFTyRNRDrBhd4DqRNGMdHEKJQDgM=
Received: from BN9P222CA0020.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::25)
 by BYAPR12MB4789.namprd12.prod.outlook.com (2603:10b6:a03:111::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Fri, 18 Mar
 2022 21:48:29 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::48) by BN9P222CA0020.outlook.office365.com
 (2603:10b6:408:10c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18 via Frontend
 Transport; Fri, 18 Mar 2022 21:48:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Fri, 18 Mar 2022 21:48:28 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 18 Mar
 2022 16:48:25 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/13] drm/amd/display: HDCP SEND AKI INIT error
Date: Fri, 18 Mar 2022 15:47:48 -0600
Message-ID: <20220318214800.3565679-2-alex.hung@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220318214800.3565679-1-alex.hung@amd.com>
References: <20220318214800.3565679-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c796fa29-132c-48dd-bb69-08da092909cd
X-MS-TrafficTypeDiagnostic: BYAPR12MB4789:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB4789CE26831637264C6F5EC7F7139@BYAPR12MB4789.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZPgl8IBdKxLrQYZQmIPzKkm5A8PK6RA/Wr+T4hsEOt3VmSJC/nZu27j3EqVcC7y02cKW+8s6n9QLQNVCI+7V7Jsp1RcEdRspghz21jXuufBgHSyHB/Ew0WRSaJ8eAW7sHpIGjWDyO1M6Gzi2z+XwyvjvfR34DuWyNsoVPeHPpxS7YsTu/I8ER4TKizRgSbng3cQyeOUeTkS3HawLMMOCiYVrDh7/eQEUQmlxWaMt/idHZQUjqjwCxV1e++MIinWHgxTtuapyPPKL2Ov27EiuNgMnVqqWZbdm/1UqSfvUpUGZdBMegpC9+oq1scyaY7YMjApA94W/t39YHYYxT1gyJHYvFuOABGgvrLZeeaYCIbcEuoSzlK029Dn9IhbCgs8PISdHNYprMV4ZD8ZIV4G4/ex9jF/wwZSG14jWQP2Qc/AGs/9OSGiTkXf9uo9bZPTPGX9q5CC3pF6ooQjBW9sdnGDe24xdwSZgU2MzWv+hwf7z2/wHAe7yA7HmHI8Pn8uwlOPuuyAqDgB/oR2wM3xSta+EXSjDinWeR+qWA4qIZBnYl1a0EXZBi2NT5yr2zCbM6B0BXRj8uZi3DfVVAotAAOz5p5Mh2SWJPHMyp35IW0vLOHwbzLvuVwGrEaTh3J9+fSh1AgpCOTFOnCH4OtVcG5HHTjnjwsYYFs251bjEgjXQ8BcbySSq/soC8tvtBZgnZfkWOmXQ/w4nQCqp8bJx2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(40460700003)(36860700001)(47076005)(2906002)(356005)(83380400001)(81166007)(1076003)(336012)(2616005)(426003)(186003)(26005)(8936002)(16526019)(44832011)(316002)(82310400004)(6666004)(7696005)(5660300002)(6916009)(54906003)(86362001)(36756003)(8676002)(70586007)(70206006)(508600001)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 21:48:28.8508 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c796fa29-132c-48dd-bb69-08da092909cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4789
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Ahmad Othman <ahmad.othman@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com,
 Wenjing Liu <Wenjing.Liu@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ahmad Othman <ahmad.othman@amd.com>

[why]
HDCP sends AKI INIT error in case of multiple display on dock

[how]
Added new checks and method to handfle display adjustment
for multiple display cases

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ahmad Othman <ahmad.othman@amd.com>
---
 .../gpu/drm/amd/display/modules/hdcp/hdcp.c   | 38 ++++++++++++++++++-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.h   |  8 ++++
 .../drm/amd/display/modules/inc/mod_hdcp.h    |  2 +-
 3 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
index 3e81850a7ffe..5e01c6e24cbc 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
@@ -251,6 +251,33 @@ static enum mod_hdcp_status reset_connection(struct mod_hdcp *hdcp,
 	return status;
 }
 
+static enum mod_hdcp_status update_display_adjustments(struct mod_hdcp *hdcp,
+		struct mod_hdcp_display *display,
+		struct mod_hdcp_display_adjustment *adj)
+{
+	enum mod_hdcp_status status = MOD_HDCP_STATUS_NOT_IMPLEMENTED;
+
+	if (is_in_authenticated_states(hdcp) &&
+			is_dp_mst_hdcp(hdcp) &&
+			display->adjust.disable == true &&
+			adj->disable == false) {
+		display->adjust.disable = false;
+		if (is_hdcp1(hdcp))
+			status = mod_hdcp_hdcp1_enable_dp_stream_encryption(hdcp);
+		else if (is_hdcp2(hdcp))
+			status = mod_hdcp_hdcp2_enable_dp_stream_encryption(hdcp);
+
+		if (status != MOD_HDCP_STATUS_SUCCESS)
+			display->adjust.disable = true;
+	}
+
+	if (status == MOD_HDCP_STATUS_SUCCESS &&
+		memcmp(adj, &display->adjust,
+		sizeof(struct mod_hdcp_display_adjustment)) != 0)
+		status = MOD_HDCP_STATUS_NOT_IMPLEMENTED;
+
+	return status;
+}
 /*
  * Implementation of functions in mod_hdcp.h
  */
@@ -391,7 +418,7 @@ enum mod_hdcp_status mod_hdcp_remove_display(struct mod_hdcp *hdcp,
 	return status;
 }
 
-enum mod_hdcp_status mod_hdcp_update_authentication(struct mod_hdcp *hdcp,
+enum mod_hdcp_status mod_hdcp_update_display(struct mod_hdcp *hdcp,
 		uint8_t index,
 		struct mod_hdcp_link_adjustment *link_adjust,
 		struct mod_hdcp_display_adjustment *display_adjust,
@@ -419,6 +446,15 @@ enum mod_hdcp_status mod_hdcp_update_authentication(struct mod_hdcp *hdcp,
 		goto out;
 	}
 
+	if (memcmp(link_adjust, &hdcp->connection.link.adjust,
+			sizeof(struct mod_hdcp_link_adjustment)) == 0 &&
+			memcmp(display_adjust, &display->adjust,
+					sizeof(struct mod_hdcp_display_adjustment)) != 0) {
+		status = update_display_adjustments(hdcp, display, display_adjust);
+		if (status != MOD_HDCP_STATUS_NOT_IMPLEMENTED)
+			goto out;
+	}
+
 	/* stop current authentication */
 	status = reset_authentication(hdcp, output);
 	if (status != MOD_HDCP_STATUS_SUCCESS)
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
index 399fbca8947b..6b195207de90 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
@@ -445,6 +445,14 @@ static inline uint8_t is_in_hdcp2_dp_states(struct mod_hdcp *hdcp)
 			current_state(hdcp) <= HDCP2_DP_STATE_END);
 }
 
+static inline uint8_t is_in_authenticated_states(struct mod_hdcp *hdcp)
+{
+	return (current_state(hdcp) == D1_A4_AUTHENTICATED ||
+	current_state(hdcp) == H1_A45_AUTHENTICATED ||
+	current_state(hdcp) == D2_A5_AUTHENTICATED ||
+	current_state(hdcp) == H2_A5_AUTHENTICATED);
+}
+
 static inline uint8_t is_hdcp1(struct mod_hdcp *hdcp)
 {
 	return (is_in_hdcp1_states(hdcp) || is_in_hdcp1_dp_states(hdcp));
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
index f7420c3f5672..3348bb97ef81 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
@@ -294,7 +294,7 @@ enum mod_hdcp_status mod_hdcp_remove_display(struct mod_hdcp *hdcp,
 		uint8_t index, struct mod_hdcp_output *output);
 
 /* called per display to apply new authentication adjustment */
-enum mod_hdcp_status mod_hdcp_update_authentication(struct mod_hdcp *hdcp,
+enum mod_hdcp_status mod_hdcp_update_display(struct mod_hdcp *hdcp,
 		uint8_t index,
 		struct mod_hdcp_link_adjustment *link_adjust,
 		struct mod_hdcp_display_adjustment *display_adjust,
-- 
2.35.1

