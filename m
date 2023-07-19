Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C783DC001B0
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 18:35:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6261310E4E8;
	Wed, 19 Jul 2023 18:35:49 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 243E810E4E8
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 18:35:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAkeeg06LIKgdib5hEu9E0vazEVa+47BVe99B0xrIOrBbEwYpoNI9ilqp4cfRstXZMAkXxve0bko9IA7NuV+7htKQOjcfRweumYcljJLtDND/lzDkXs3rj5/fbH6JJV/n9MYpykNxf45qEIjuoJYAkGTaoPZLVy3YyZFJzAawti/iq5DA77B1wUblF96cWjhMxIE5JssnYPuyuqMJrpdALWlmHKwIAN8Cp1DZa4+w7YFCzwkplHF/2mXtFLdFiT/AqJEez9ObOBHMTkRiBRieTLyxInZeWnSAVoxyHl5dAY5lwj6BSV20fhtx+2h9Lm3B6ds3cXXIwpZS5IDe6VjXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAEbLNAqKAjMS8YBvI4Q3xio47af0BYvned6Z7PueYA=;
 b=YPbwVJ0a8AvP0Cz3TbAJYMVJkXdqcK8VGGRNlh5peSJPwT3B6g7COJlODUxLdPDL2SkJtdlCRw7hQor1KoMPehbW7jgtT7gfd+/KhmU0F/yI2m0JDF4U4lbTVYzsXWTN8j+6bZYaCe9+OPqGy9/V/Q+la2b5CR0GodSqOUW8qGZdzRZNlse0kAr7VwQpEN8tWg0yN1RDv9okW/yTF64gD86izbQb0Jbwxazuq0tQ9ZILxzyF71mbI1JnBI+cOIqf6glpO0lRQzY37qPdmnzEEFxrK8AOrULTX8qFD+7KMXUF8jG6j6DWnYoxYDeW24yiN/moAvdOrZOJ5FrC+aXqVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAEbLNAqKAjMS8YBvI4Q3xio47af0BYvned6Z7PueYA=;
 b=5MhMc0s0j0uDQx/LBqhWBB86NKykVCNzMz7rxi7Dg6+YB7EamgTxr4QxsU8YmwAQPl50eZ6jpzfxEb9g8rEERBOE2l7lvEy4EsRKefman02FcyJW+Fa7xsCwmPy/S/B1mjvnFKv78DUKFaTV2lfxFRDmkFCBSxgndEN0UbECY68=
Received: from BN8PR03CA0026.namprd03.prod.outlook.com (2603:10b6:408:94::39)
 by PH7PR12MB5595.namprd12.prod.outlook.com (2603:10b6:510:135::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Wed, 19 Jul
 2023 18:35:44 +0000
Received: from BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::c9) by BN8PR03CA0026.outlook.office365.com
 (2603:10b6:408:94::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Wed, 19 Jul 2023 18:35:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT095.mail.protection.outlook.com (10.13.176.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.35 via Frontend Transport; Wed, 19 Jul 2023 18:35:44 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 13:35:35 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/16] drm/amd/display: Remove check for default eDP panel_mode
Date: Wed, 19 Jul 2023 12:28:02 -0600
Message-ID: <20230719183211.153690-13-alex.hung@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719183211.153690-1-alex.hung@amd.com>
References: <20230719183211.153690-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT095:EE_|PH7PR12MB5595:EE_
X-MS-Office365-Filtering-Correlation-Id: c90c1444-9c2a-43fd-887f-08db8886f643
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k2FuRRbVQ9tRTy7w4cOOVdOP1FMRAtVV0GWOEuc8idhtsWmnGKcXfIw1lyg43aDb3s+P2I2uNSI362hm3rCGXQm4ROk2934QuntGS6CNnUGobpXr0XPHrVi+6S1/u3m2u7KZ+mCBdcMuWUFDe/dXlGZwCzk5faQWs4lZZ1edxvxuRUziAG/k3HnjqCdfQaerM64dcDUue1jt93583G5Jzk17/FE1gsjHhVJUZSUiUjmHTuoJFJ1/XuzdcbaopLdNI3Mh3c9Kc86MyU8ockA6moHPsVdAUNH33bkkUDdRpdjwdBDb2s7lsDFGl0AbTwScryoJBfiHMZRpJ0YaEvi59fhqYzdIknbOLiY89NActUx+f84SnSustytshxtl9UV/7PSDAu3WRpaTJFFKs07OUeCZZ8furDVjLtjA4Lg0HUHTfJPcTWtpIf5mlBxDw1qG21ayxss/gYV43+sGH055x2gYG5C1Bu08/P9Xa9eulI8XCeZS1vEyQRidF80Wjs66FYUlsjUqjCxu1l1CWGWZpJ2AmFGBHqcm7VcFGxbBnba+G+LId8nlMTIvhdLgnQLXe4AJpKwsQgECHFaYkDwb3JrL5Tt8Lke54K4DvVvMrlT75OBW4Q5cEecx07u+GJSAq1dL2L0nfArpcXd+4ji+v1uioOnCSJ3/ncuAETdRWy3O+kweDwUJvMJWtRebaQJnQXAfxDkgWND3MM4ka0dBfjpL2qxCXJ99pLwAAo09NByKuAJzeFp/KNNnYLKPxqk9DQWxXvEw/et3XZqFLuolCQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(4326008)(7696005)(54906003)(6666004)(478600001)(82740400003)(36860700001)(83380400001)(426003)(47076005)(2616005)(40460700003)(86362001)(40480700001)(356005)(2906002)(70586007)(44832011)(186003)(1076003)(16526019)(26005)(316002)(70206006)(336012)(81166007)(6916009)(5660300002)(8676002)(41300700001)(8936002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 18:35:44.1360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c90c1444-9c2a-43fd-887f-08db8886f643
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5595
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Taimur Hassan <syed.hassan@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Taimur Hassan <syed.hassan@amd.com>

[Why]
DPCD read is skipped first time after driver initialization.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Taimur Hassan <syed.hassan@amd.com>
---
 .../link/protocols/link_edp_panel_control.c   | 49 +++++++++----------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 5add2360fc94..8b360c09e0e8 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -46,43 +46,42 @@ void dp_set_panel_mode(struct dc_link *link, enum dp_panel_mode panel_mode)
 {
 	union dpcd_edp_config edp_config_set;
 	bool panel_mode_edp = false;
+	enum dc_status result;
 
 	memset(&edp_config_set, '\0', sizeof(union dpcd_edp_config));
 
-	if (panel_mode != DP_PANEL_MODE_DEFAULT) {
+	switch (panel_mode) {
+	case DP_PANEL_MODE_EDP:
+	case DP_PANEL_MODE_SPECIAL:
+		panel_mode_edp = true;
+		break;
 
-		switch (panel_mode) {
-		case DP_PANEL_MODE_EDP:
-		case DP_PANEL_MODE_SPECIAL:
-			panel_mode_edp = true;
-			break;
+	default:
+		break;
+	}
 
-		default:
-				break;
-		}
+	/*set edp panel mode in receiver*/
+	result = core_link_read_dpcd(
+		link,
+		DP_EDP_CONFIGURATION_SET,
+		&edp_config_set.raw,
+		sizeof(edp_config_set.raw));
+
+	if (result == DC_OK &&
+		edp_config_set.bits.PANEL_MODE_EDP
+		!= panel_mode_edp) {
 
-		/*set edp panel mode in receiver*/
-		core_link_read_dpcd(
+		edp_config_set.bits.PANEL_MODE_EDP =
+		panel_mode_edp;
+		result = core_link_write_dpcd(
 			link,
 			DP_EDP_CONFIGURATION_SET,
 			&edp_config_set.raw,
 			sizeof(edp_config_set.raw));
 
-		if (edp_config_set.bits.PANEL_MODE_EDP
-			!= panel_mode_edp) {
-			enum dc_status result;
-
-			edp_config_set.bits.PANEL_MODE_EDP =
-			panel_mode_edp;
-			result = core_link_write_dpcd(
-				link,
-				DP_EDP_CONFIGURATION_SET,
-				&edp_config_set.raw,
-				sizeof(edp_config_set.raw));
-
-			ASSERT(result == DC_OK);
-		}
+		ASSERT(result == DC_OK);
 	}
+
 	link->panel_mode = panel_mode;
 	DC_LOG_DETECTION_DP_CAPS("Link: %d eDP panel mode supported: %d "
 		 "eDP panel mode enabled: %d \n",
-- 
2.41.0

