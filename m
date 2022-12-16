Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8832BC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Dec 2022 10:36:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD24010E145;
	Fri, 16 Dec 2022 10:36:13 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FEC110E145
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Dec 2022 10:36:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iw/TM0ni21gy7qvm8I3PshRHz0WwOPLGIBb6G0i3dMSF9MUQLRz1OArarflVfbIVbcaEr8KCIBo8mAehTV6rwS5GrQ9to/kF2/jO+0i4bxIYuLw/rRWZFQOjgxAMjpumxA+LQbSvT99We0k9YAmNnCJTH2WIHWHFSSrlmplubh4KrSpAZB+v9n/hRU3M2bV0oWKvcCEB7piAgLpXiDYxqVV02lC7hjkHYa4m1+WcX1NtGzN7KU/UJeb09I+JsS2nc8ZNF9Y8ZhOMT/hXc2y2zYDOLpojNUZH/GxGFTFCJJfDr1YEo1nTkXyLnT06fX34sIB8brd8WbX0y/wJ07BE0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2FxgnC/zBxldYI3Qx9+Ju1JAD+lzEOj3nDTM0Rtrpn0=;
 b=SW0EH1eCWFJzFp5oJ5x8Da4WFE42irbmW7alMcWU9ORvHtlaws2jvtenebHNfebmr1ostzOhHKZcQUYVqYtc8l7QZCfeby4/J4wDlMioijQDJ0ykPLW/pLYiz/fSTwNuCE3AYZ7Un+LT1efXYn+0xAg0GJv+8eoaoYIdgeVgt2mRiEjKKLE2FigKNLSsErcLxGN7JfVvK/a2/EtxEzSB2dP4JFCOBwrUF9vTw5uWIOpupy7+ZxuMbtaEmd0njBOoYefGbYYK3OooM+YxK2QdRN46i0qDMIbDVGqT9VlMlKIvnrmVfdZJbdgFttR8GkeXrRZRUQ9umEde76qOIUByMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FxgnC/zBxldYI3Qx9+Ju1JAD+lzEOj3nDTM0Rtrpn0=;
 b=mGbSHECkrs7ZcQPBwHxuSu7mNDb49D/XOShre37HBMOtsi0gPrxzVGPFT60ch3LKGS9B0WMSjs9fBm+FBjxCY0LcN2l91L6oxDk9W7ysRrpGFOkCfy358LFbpT048AhBeu+8wVxgcVa4PnzLh3Tfu7L1NvZdwThkxrJhJ+ewBt4=
Received: from DM6PR07CA0081.namprd07.prod.outlook.com (2603:10b6:5:337::14)
 by MW4PR12MB6780.namprd12.prod.outlook.com (2603:10b6:303:20e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Fri, 16 Dec
 2022 10:36:10 +0000
Received: from CY4PEPF0000C967.namprd02.prod.outlook.com
 (2603:10b6:5:337:cafe::8c) by DM6PR07CA0081.outlook.office365.com
 (2603:10b6:5:337::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16 via Frontend
 Transport; Fri, 16 Dec 2022 10:36:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C967.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.8 via Frontend Transport; Fri, 16 Dec 2022 10:36:09 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 16 Dec
 2022 04:36:07 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: correct the fan speed retrieving in PWM for some
 SMU13 asics
Date: Fri, 16 Dec 2022 18:35:50 +0800
Message-ID: <20221216103550.2063886-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C967:EE_|MW4PR12MB6780:EE_
X-MS-Office365-Filtering-Correlation-Id: 428c8d90-748a-4c81-05c5-08dadf515866
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ujrQCaEysJaT9HflHipUq85+GNPBFKbf2OeckZvnY6taIZ+xYi59jVnIxjCK2D7G/7G1yh+K6N/dkGE1A0zUeH8+TDLpaYM8aTJ+1pjY8SIIXNPYVTFhx2xewgqp2hGqo74E8RUDjS1MxCvuyzLS97zEZCJxpxDFZgsDpugn7wrhfev1xG5rH/OlKDq/jOz1kyd9JtjxXr5RTCAgFVVDBg3jxV5aOllTu3I+2qCmOL2ha09+63OOLZ1+r9+t6t1tsB8+h96AKmFJvAfAGMsVYHJ5oR5klRaOJHdmbieYVInc9FZ08U518Ugae0wmacs5/uDA5K5VsnNNOfr+6xHae/m5usA+Wn+F8wuaGQu0Fytn875C+RzvQxlM/gBpQyqM9zqtz+M3NOcBKBsVqzFktbz/XiJpMX4c5NedmDTSBsEMOJ33UmcqeeW78yEWVdILuGPcwLKoSZoznZgbqKmAuLzVym6Y9XPk7CNmDWqscXsSo4XG7+0dCwjEPxc/Y3hyZoM0T304yW/MIjD+j+8vqplpbrTy5Y3J6lZpq3iQNkPp6FSoLjk9FBQ8s3rCG3ZAcz3Rbq1EvcBu7BfmBwkM549cSpMOq/6+aM30jYNg3E2f4vTsdtwqqM3BHjNIFVgFsbetFy57SOi791rVCfkvnq06/cmj31flkRN/8rI/aC92/eWLYqLI83VsMZP7UnHfgQCCAjgf0wx4KpBfXLepAduvUSdcdM6SyrKRI3XOJns=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199015)(36840700001)(46966006)(40470700004)(2906002)(5660300002)(8936002)(356005)(316002)(426003)(8676002)(47076005)(41300700001)(70586007)(70206006)(36756003)(6916009)(40480700001)(81166007)(4326008)(82740400003)(54906003)(7696005)(6666004)(478600001)(26005)(44832011)(186003)(2616005)(336012)(36860700001)(82310400005)(1076003)(16526019)(86362001)(40460700003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 10:36:09.3679 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 428c8d90-748a-4c81-05c5-08dadf515866
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C967.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6780
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For SMU 13.0.0 and 13.0.7, the output from PMFW is in percent. Driver
need to convert that into correct PMW(255) based.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I7bbeae3c0d81c6cf6e0033aa28ca6d26f5b6d178
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 15 ++++++++++++---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 15 ++++++++++++---
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 636cb561fea9..283cf7cf95ab 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1445,12 +1445,21 @@ static void smu_v13_0_0_get_unique_id(struct smu_context *smu)
 static int smu_v13_0_0_get_fan_speed_pwm(struct smu_context *smu,
 					 uint32_t *speed)
 {
+	int ret = 0;
+
 	if (!speed)
 		return -EINVAL;
 
-	return smu_v13_0_0_get_smu_metrics_data(smu,
-						METRICS_CURR_FANPWM,
-						speed);
+	ret = smu_v13_0_0_get_smu_metrics_data(smu,
+					       METRICS_CURR_FANPWM,
+					       speed);
+	if (ret)
+		return ret;
+
+	/* Convert the PMFW output which is in percent to pwm(255) based */
+	*speed = MIN(*speed * 255 / 100, 255);
+
+	return 0;
 }
 
 static int smu_v13_0_0_get_fan_speed_rpm(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 5e937e4efb51..f207f102ed7e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1365,12 +1365,21 @@ static int smu_v13_0_7_populate_umd_state_clk(struct smu_context *smu)
 static int smu_v13_0_7_get_fan_speed_pwm(struct smu_context *smu,
 					 uint32_t *speed)
 {
+	int ret = 0;
+
 	if (!speed)
 		return -EINVAL;
 
-	return smu_v13_0_7_get_smu_metrics_data(smu,
-						METRICS_CURR_FANPWM,
-						speed);
+	ret = smu_v13_0_7_get_smu_metrics_data(smu,
+					       METRICS_CURR_FANPWM,
+					       speed);
+	if (ret)
+		return ret;
+
+	/* Convert the PMFW output which is in percent to pwm(255) based */
+	*speed = MIN(*speed * 255 / 100, 255);
+
+	return 0;
 }
 
 static int smu_v13_0_7_get_fan_speed_rpm(struct smu_context *smu,
-- 
2.34.1

