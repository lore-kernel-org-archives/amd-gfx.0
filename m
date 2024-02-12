Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8AE6C48297
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Feb 2024 15:34:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67DC710E5C5;
	Mon, 12 Feb 2024 15:34:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nWdFdhhk";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC8D210E5C5
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Feb 2024 15:34:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaiiNxrGu9fuAEwOYVNFCK+I55t1ZOPR22k+7ykm3CKAlFSCHvQqTgTd86x+s5kvEE4XFqPD3rA/mEfpQBu+49ycI5L4gDsurBVfU2DaZcaTTHafuxoOQHKJUaT66EHC94PEVHZ2mQ85B1ZMrQ2uAbVPtSJqfsckxaMEVvp9QjGKivOscgCEUbEzO10e7LFuNIIKyRI0y95Y/GGUBq8eKpfmrnKm6tHRXLjQuA7iz1xx0wAjbDkVAZJ5k85ElAxtyrGCDcvzwhc65tcrinaStz6CVgC35gg5uhDEFszEUM5rDcCQNGzs2/p4TiGLQy2JflC0lOB5kEhY5SuH74HiSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8kVAQo0/jdx2Xpbt+I125b+nW697PbddHkMVDN1A54=;
 b=FobWeVxWdg126xhs+PaqWHKKRMTLFmneOtGcg0IsQhDhogePAPdjKe4pXCQs6lj83JP8aGy8zCyjVeCJYY5VgF7xHANB9mpqsHdRqRdUl9cDfJGGdkfVlbiQSSw6ASdQ1k1sYtuPxXO3QtwZdBpkhm9YpxLzPpxFOd0Rep7VSOSHzq3hllAr4zLfLBGKzbOnJ4rPYS5ELvItRfuO84wCnjaMVCXtY8O4Wm0gIGIAVOksRtSIyhpJfO9LCAYNjKtsxifnjBZFgQPuC23x3mRvlSOTUuJU7KNJG8Z9vYuKuseV2uIjfbiZQXAERL0MwoMMOm7u/ehE8cba6YJ5lRk7sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8kVAQo0/jdx2Xpbt+I125b+nW697PbddHkMVDN1A54=;
 b=nWdFdhhkIZ6sUFOk8adTyEcPgS/Q0Eqqfu9mahrTiy4B5xC1X/aX65OKjyz/4P1im0M5vlLoAu98l3wZXOd5rk5Jev+0im0vYlcI0Wud/1JK8DT0UcwYnWSNYgIC023ykohXITCJvCv3cSzhYNN/K89QlTew5nrPonUV5V1XyQs=
Received: from DM6PR02CA0055.namprd02.prod.outlook.com (2603:10b6:5:177::32)
 by DM4PR12MB5264.namprd12.prod.outlook.com (2603:10b6:5:39c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.24; Mon, 12 Feb
 2024 15:34:24 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:177:cafe::12) by DM6PR02CA0055.outlook.office365.com
 (2603:10b6:5:177::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Mon, 12 Feb 2024 15:34:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 12 Feb 2024 15:34:24 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 09:34:21 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Bhawanpreet Lakha
 <Bhawanpreet.Lakha@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>
Subject: [PATCH v2] drm/amdgpu/display: Initialize gamma correction mode
 variable in dcn30_get_gamcor_current()
Date: Mon, 12 Feb 2024 21:03:47 +0530
Message-ID: <20240212153347.1175416-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|DM4PR12MB5264:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c8b71aa-569c-4d4f-ffae-08dc2be017a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UrX8Hdyc76ULcmSMA8tlzt4S5q1IX6ncwxiZ5LDbNasnMBwNhGMlbXPyD5vhvXFz4iXjJW1HeREvXc/PPn56GkQIz9Wmdqd0TT2tJV967yLb1qBmaM4//bAh2ZAcHSdbXmj4xAtWpMziMQWtS0UWmCJr1JCVUqSwneD3HieghqTwllhzkgxA9y3jp6QQ0cuRt2yR+NfmDmjmOX8PDC05WAibfYbfnqnBlPusOwn0KnUVzh+PmDfqjoo4AECdlU4wYNd7BoWmxM8qvPsE8FrQNbwmWtwb4iZS0WfprZe6aJjgMh/TY2Xbk4WHLKBUqg//+AXVOHh6w40QMJaO2TtO9dZuSWQXzIBjz0Ntb+zJd8MNq1EwVRK8PvQplQgpiyqpmMx6Khl2DnQ9oh8APnNKjR323Xv/0zkF5iYoqEl7rcVGnn7dv4+ECODfN8kvqZoKxWJNji3cqL5BdQoVx5KSiXmRwVDwbJ1TN2owDm/r/QIUPBg3zogvTbd3wTiv9JsvVvWxEE73GWJxgYAFwTtcNw8U1CVIh6kjW3xdY+o4P4x/JfCy53196/WZXBmI1mzzFB+M13q72KfuKUj3Lwy6REBl3Xn4E5WmJ/+36Orbqmw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(186009)(64100799003)(451199024)(82310400011)(1800799012)(46966006)(36840700001)(40470700004)(86362001)(81166007)(356005)(83380400001)(1076003)(82740400003)(478600001)(54906003)(6636002)(426003)(110136005)(70586007)(26005)(16526019)(2616005)(336012)(6666004)(7696005)(70206006)(316002)(36756003)(5660300002)(4326008)(8936002)(8676002)(2906002)(41300700001)(44832011);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 15:34:24.7028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8b71aa-569c-4d4f-ffae-08dc2be017a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5264
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

The dcn30_get_gamcor_current() function is responsible for determining
the current gamma correction mode used by the display controller.
However, the 'mode' variable, which stores the gamma correction mode,
was not initialized before its first usage, leading to an uninitialized
symbol error.

Thus initializes the 'mode' variable with a default value of LUT_BYPASS
before the conditional statements in the function, improves code clarity
and stability, ensuring correct behavior of the
dcn30_get_gamcor_current() function in determining the gamma correction
mode.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_dpp_cm.c:77 dpp30_get_gamcor_current() error: uninitialized symbol 'mode'.

Fixes: 03f54d7d3448 ("drm/amd/display: Add DCN3 DPP")
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Suggested-by: Roman Li <roman.li@amd.com>
---
v2:
 - removed the below redundant code (Roman)
   	if (state_mode == 0)
		mode = LUT_BYPASS; 

 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c
index 54ec144f7b81..2f5b3fbd3507 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c
@@ -56,16 +56,13 @@ static void dpp3_enable_cm_block(
 
 static enum dc_lut_mode dpp30_get_gamcor_current(struct dpp *dpp_base)
 {
-	enum dc_lut_mode mode;
+	enum dc_lut_mode mode = LUT_BYPASS;
 	uint32_t state_mode;
 	uint32_t lut_mode;
 	struct dcn3_dpp *dpp = TO_DCN30_DPP(dpp_base);
 
 	REG_GET(CM_GAMCOR_CONTROL, CM_GAMCOR_MODE_CURRENT, &state_mode);
 
-	if (state_mode == 0)
-		mode = LUT_BYPASS;
-
 	if (state_mode == 2) {//Programmable RAM LUT
 		REG_GET(CM_GAMCOR_CONTROL, CM_GAMCOR_SELECT_CURRENT, &lut_mode);
 		if (lut_mode == 0)
-- 
2.34.1

