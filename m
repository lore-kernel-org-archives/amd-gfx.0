Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0BEFC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 17:26:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A5DA10EE32;
	Fri,  8 Apr 2022 17:26:26 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2047.outbound.protection.outlook.com [40.107.95.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AAE410EE26
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 17:26:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8ApBtNFiVi2BBy1lKccKwClcTdl6AmavPPqCnBA3PFyhMYxl3tHziVENL+Z4RMFQbGlwkFHmWj/JcEgYkZHJif5l63NG8DqX5j1si7F1odjFChGl8SAZVqUBZIlM/hEUeJpAVzkxRl6qbuj6OpO55eFxwClvqmmMaRUDbTTOJaPn5f5Q/oVLqUPkE+Quw7tWcc7e7tQOKbbwUePKSV3CWOm5DYJgXRrLpHAIR9mbQioD9A9Tlyjklq/pTqlLCaTdOQCeXGdMPIofefAjPg566lbPq92PB7ESPE2v7EBPIkV+eZ5ESD0ojrUmcmQFsFiyJdCfQbm5dj3yfQ31OGZpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pS9d+HcMbjIXSJQgN2c5HW4Nglsi4fn4wX9VRb6ILlg=;
 b=ObakqvyGacDbYpTA95FYEJTOcg4WsHsE7Kw6A2itZSrBNo5P7WaNFLEAB8FDqtg2ilg5U+iqLz0Y41PMldSLxUE2kW3gN4HJazEjsojYZ1hnGFNXFj+D5ShY2YAZIft/8BEeadoHrf6Y7UUsqfoX4AWP/7ByiWjHO7V/pz6MrpIBzuhO+D2e2ciiQmjMUlHmtFkC7JVevfJN6WrrR/n+SB5CfLt0jFVoyAqwhh18SHLTAH7fnteQNK5UA3kBNmsqvG+BtluydB3zJAIygIHHBcpyyjsagqsZscQXNb3pDepog2xXOHS5Mk4qrlB4yBeBsR+v14EVXLRpm8adxM5Xkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pS9d+HcMbjIXSJQgN2c5HW4Nglsi4fn4wX9VRb6ILlg=;
 b=467BFu74uGm0J4o4cxqJ8h6ENbMlm4yx1UVCSST/xoFFzuX4FPGI7xSk7DwwnF+Tw0tQX+GeM3GvMxsuHELIvDQRIL2vCwl4XyVkXzo/jnOmUq1jTmNRnaC+GKdA12U6Dgyeewn9QqqkXzXo1i4kr5jFH4fkiR+1yH13FszSVlk=
Received: from DM6PR18CA0022.namprd18.prod.outlook.com (2603:10b6:5:15b::35)
 by CY4PR12MB1816.namprd12.prod.outlook.com (2603:10b6:903:11c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Fri, 8 Apr
 2022 17:26:21 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::74) by DM6PR18CA0022.outlook.office365.com
 (2603:10b6:5:15b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Fri, 8 Apr 2022 17:26:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Fri, 8 Apr 2022 17:26:21 +0000
Received: from lnxpromo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 8 Apr
 2022 12:26:19 -0500
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/20] drm/amd/display: Disallow entering PSR when panel is
 disconnected
Date: Fri, 8 Apr 2022 13:18:55 -0400
Message-ID: <20220408171911.601615-5-Pavle.Kotarac@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220408171911.601615-1-Pavle.Kotarac@amd.com>
References: <20220408171911.601615-1-Pavle.Kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3683d3ef-3399-4ed3-8c2f-08da1984e65f
X-MS-TrafficTypeDiagnostic: CY4PR12MB1816:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1816A727B61BE64B75D16FDFFCE99@CY4PR12MB1816.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CXLsTi5hOMIQeuv8j2ytw6Tp/s4ZUiIZq1JmfvoIC728DveBTNI4wR7M7Im+D2X7QLKHbuHdeC2wMF8e2ycxm8YK9LEKrpjgF6wpWxaepuVoQAkWRNvS4dXkhmTBd8+yOcFLWMExiZUmvsBYjKsB4mLcrm8Zrwy+GqLL5c6c/aZQX2I/FcHsDuJ0l2LwZh6TuL1ai09GP9bomKDUldfLB6TcyIe2gljt/dWldYLSEsvSR+eWHN+adP5zmEZJEOEcTHnaBMqhMzCI+e/D2TIgJenqCqTtnC8CqLneS6Yc7LtCJwckTfiy3fb7KiWR5KAldgF/4Gh240XTQWLiEP4DcISI7xg8VkOIEVYWwCen2/47L4X2yd2O7uY1LsGTcmTkNMpe2Tcz96XS9znLvP0rBLDQblNiFAncOgrbNGHZJQSsdKcvVnCVaWzZbOCCngGL+7McRL6E4XzcYB1f9D+GmyBgtFPTJRDvXlIA+jpw2Mfg4zqwL6qw2nfOTnE6a5ZpOlMIx/ekc3EVJTcw2bfpg4IQ04Wgk92S2YOsIiPyLNtzfifezNCeHRrBQgNtSUyVyHlWwaa8F7uN94zwU6EpPHhiNBic0lLb4GVMmFEvssN7CTmTpSqXyzrYPuouBVdY/WYxO7ATGQ/uS5qpQ+irAeOGfoBOqLUe1dyu2QAY1Trso4BEtrxb+AidPfkP9YzX7qN7WgFSQ1xZ+evP+Zbpig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(16526019)(54906003)(6916009)(6666004)(82310400005)(70586007)(40460700003)(70206006)(508600001)(186003)(2616005)(336012)(426003)(8676002)(356005)(7696005)(26005)(1076003)(4326008)(316002)(81166007)(5660300002)(8936002)(36756003)(86362001)(2906002)(36860700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 17:26:21.6651 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3683d3ef-3399-4ed3-8c2f-08da1984e65f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1816
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
Cc: stylon.wang@amd.com, Evgenii Krasnikov <Evgenii.Krasnikov@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Max Erenberg <merenber@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Nicholas Choi <Nicholas.Choi@amd.com>,
 Harry Vanzylldejong <harry.vanzylldejong@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Max Erenberg <merenber@amd.com>

[WHY]
The dGPU cannot enter PSR when it is not connected to a panel.

[HOW]
Added a check to dc_link_set_psr_allow_active
which returns early if panel is disconnected.

Reviewed-by: Harry Vanzylldejong <harry.vanzylldejong@amd.com>
Reviewed-by: Evgenii Krasnikov <Evgenii.Krasnikov@amd.com>
Reviewed-by: Nicholas Choi <Nicholas.Choi@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Max Erenberg <merenber@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 47b67fd1e84c..22f2d88fab99 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3079,6 +3079,11 @@ bool dc_link_set_psr_allow_active(struct dc_link *link, const bool *allow_active
 	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
 		return false;
 
+	if (allow_active && link->type == dc_connection_none) {
+		// Don't enter PSR if panel is not connected
+		return false;
+	}
+
 	/* Set power optimization flag */
 	if (power_opts && link->psr_settings.psr_power_opt != *power_opts) {
 		link->psr_settings.psr_power_opt = *power_opts;
-- 
2.32.0

