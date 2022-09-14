Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB63FECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:53:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97B3510E810;
	Wed, 14 Sep 2022 03:53:51 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9365D10E810
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:53:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNIs9PrTlMUl13nUy+mMxQzbMaJWypf7SyiRMEArgAoGBblLQgK1owqqaPBlHIxmyBIL0Y+fzR8DguGIxZx+MRnhCvdhmnOXfxHYsYX7r65seUVILQh2o+QtzZZYoqMU/JRuRdJUQguZE21V+08qKBDg/kT4VNF8+sPHwhz6CYzWnH/kv4TQ7+9x+ND7hW5Fd3byEGrwYIHw90LPd4ek6Vk1m+K8DrPLB+RudgjL7ams6UD/RnaMdYJd7ChdI61KyW6sPguGWbK0kg6B/NnVapye5xjqAwkzVIs35+UWxJQ4aumBxm/M78jUfAjNJpUg8UweTZ075KKA0/ItJckmsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DcHs1Y/YywvrNge4YAmsX4w+nyGXzTS5JJRKeExEzpE=;
 b=TuvDFz9hB3Q33FjR0iz9b4KwctDHYQrQ+6/fOTyYAJAcT0Zbns1Crp/vw2XlqwsaU8gg2dqFG0byn4gNip0vNAx9kU4lSYMHwNBWbiNrIYlps3TnHIMlFx90CTxrj95PU9hff+FRl/gnO2yuAfnubdvYERmKYm5h7rQ130536QBK+7ThU0iCqhITj5B6/15fUVUXMpuxm1f1KZhOKl1Axd2drAy1uRYBz2nE+AMCZqJkMut9DbdX9aH0H+iasPJTbPdY79Xncq30ZvbeR0Rt19AS0TqbKuDumZkD+2Zu5y3lY1ndQXk55lAlBNWe4WOK554E448EwwQ1VAxDkIrPog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcHs1Y/YywvrNge4YAmsX4w+nyGXzTS5JJRKeExEzpE=;
 b=lt/26TBNS9bnQOlrpVKgc6k9181MGHgRsS+y66yUbWASd5zUMXB84KXWQtgkNPcEg9INeKvyZVQdvYWRlhVNfQlcURyjTiwCrBsWQ2/U/voAnsKR0e2z7Ho/ViihIeUXgyTTbsLJ+AAfyKJj2Ri4xZD5fJAS0evOv4CcV+taOgQ=
Received: from DM6PR10CA0024.namprd10.prod.outlook.com (2603:10b6:5:60::37) by
 CH2PR12MB4328.namprd12.prod.outlook.com (2603:10b6:610:a6::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.14; Wed, 14 Sep 2022 03:53:44 +0000
Received: from DS1PEPF0000B079.namprd05.prod.outlook.com
 (2603:10b6:5:60:cafe::cd) by DM6PR10CA0024.outlook.office365.com
 (2603:10b6:5:60::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.15 via Frontend
 Transport; Wed, 14 Sep 2022 03:53:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0000B079.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.10 via Frontend Transport; Wed, 14 Sep 2022 03:53:44 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:53:43 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:53:39 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 24/47] drm/amd/display: correct hostvm flag
Date: Wed, 14 Sep 2022 11:47:45 +0800
Message-ID: <20220914034808.1093521-25-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914034808.1093521-1-Wayne.Lin@amd.com>
References: <20220914034808.1093521-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B079:EE_|CH2PR12MB4328:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f095202-f422-4812-bc66-08da9604b877
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /PrLcVoJg5AQzY/PFzwupI8+tkZRTXUXg26R6uzfyjG1jDiGXhj5d9pzRSAm+b4jJ31DMNDJl8ClfIGnT6Rx+XN3LNPp8UkVp4/pmhGkyKcOlH79bn6m2vOWL2XlgS1qV0s6BoVtzub+ItjCub+qC3THAkxagzAl34BgdyVw4V81KwGMGnScvshK7hsV2RIieAH83YZuE/31StP3SIhr8msmIIKNg8GaVLvRBTc2g1eTjNPQ7LXjsjgvHM8gPDCCUeuTut+Znm0fMdgIB9wVUgvoXmr+dDMuOwFT6YUGaF40adcp4gJ92HkEK+mAYfEzLLkT5FRUq9CI5QoJqHTOAZrVpOHx53PRT0K85PAuYTWgIlao+OCp9xOJRmY1PVfM31SwbNxrVk1tUZmIuyl2Ald9J500TkQ0M3x1aPKrKXsHmr3RvyfgluuFFuM03ZZlXucHVofkQcVjDpBFmbBTIEYL2uBOO7dJcH0bdenB6DXNJKB2frmXqeFmWxJ7DZcybedXNMekXXz2I8+OpQY42IjavheYynQFGG3VjtfkLnGhStkkijuULAiwnS6WMgBkLJmk7PKV+r0PZUpz3KHoYYGE3Ar+n1VjkeHJj2fxL7/0BWuKiJhYVh/gcur4l9Drm5ZJezpQzjQD0QFC0d6VriJhvnuVc65MBfT4PQHVFsRCiJVSsu9rOOE9aA5TMnzNtqyICYYuHvQJxi8doAmer3s+Afm10kipyE5ctaRp5KIzRIwQrfCdS6EvxqRYJYIo8d9smwaHak4D2V86vlId+XFxV7iHUwdSbLrFshbTkcvirij/ksq/vf8/KhkloVwY
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199015)(36840700001)(46966006)(40470700004)(6916009)(40480700001)(6666004)(54906003)(336012)(8936002)(7696005)(186003)(36860700001)(70586007)(82740400003)(41300700001)(40460700003)(478600001)(36756003)(81166007)(4326008)(426003)(83380400001)(26005)(356005)(2616005)(1076003)(2906002)(8676002)(5660300002)(47076005)(86362001)(70206006)(82310400005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:53:44.4143 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f095202-f422-4812-bc66-08da9604b877
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B079.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4328
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
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Sherry Wang <Yao.Wang1@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sherry Wang <Yao.Wang1@amd.com>

[Why]
Hostvm should be enabled/disabled accordding to
the status of riommu_active, but hostvm always
be disabled on DCN31 which causes underflow

[How]
Set correct hostvm flag on DCN31

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Sherry Wang <Yao.Wang1@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 8745132d6374..8c1a6fb36306 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -890,7 +890,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_z10 = true,
 	.optimize_edp_link_rate = true,
 	.enable_z9_disable_interface = true, /* Allow support for the PMFW interface for disable Z9*/
-	.dml_hostvm_override = DML_HOSTVM_OVERRIDE_FALSE,
+	.dml_hostvm_override = DML_HOSTVM_NO_OVERRIDE,
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
-- 
2.37.3

