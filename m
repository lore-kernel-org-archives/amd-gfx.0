Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF57C001E0
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jul 2023 03:22:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06C3A10E26E;
	Mon, 24 Jul 2023 03:22:00 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55D7110E26E
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 03:21:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMl8QRg+ISJppQqZgBNj4INDs9JdyDrUmtwq+4KE9eO1RpGWQaDgsc1TAvl6V1C+h2OtXGcWcvmcBWYfJhm2vAXu5F/X8H3kwagiqfMw+dZkazvRtmdRNdQ7KJldMLCN+kBc4TDFnAdpAxLZNkibt16V0CgfOFpqMObRu6PnqKipRQBvHYamtsKrwfa9ZxB2Gd6yZDPPc/y+1gPILxipElURrfh8RTsjGxXjs5jAHKKc5tD+TyYb84ESeFA/ypGBz0UtSFLvPIoPXcroTi57xhcgROdt1AzWVyAYKqFydzP7NkpR5WypYq31vzZHt+zspFTepyeeVlDpkCE+EzsEcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXkOZLRxm1NqFyIqPnG16ik596QEi/fdKsQc+CrvL+o=;
 b=ar2tP23K3i4N3KJS7EKOwqQ1N2lZndS5/+sAY3k+SUD9yGzTgKym7DvEIoV9RYd17uzIrbEFGfq8yHCdptMYD+htwEL1cAxTpgj1g+k5loDwpuMiNyyeNNYtKnjbjhUBKvA0LiD9uoYA7g88MlM9zVslx+cCn+CRoOzWrbg3Ej6nyyJw6xYCIAk3eqU49rP0i6XKckseEG023hUSQlnBtz0aV7ZErOji1QPTfHG51C0+KdW4pvQM93IsJPmpgnUdtxUgDIviufY1ba4aUm1EQm7IhbzJON3gBdqXBTYgGpLSQ/4LGkIUmhgJHogG1i2cE1Ct1UYxCzb6QO/riWp1Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXkOZLRxm1NqFyIqPnG16ik596QEi/fdKsQc+CrvL+o=;
 b=I/bccWtEXzEG0cYZpRz3TnSdGGrEQI5xfbVVbbkQh2M/dMBdKcskyx4Al6QoaAO2Ug8Q4Qr5+09hEhp5r0ffxH78r5FyS4dLqmfxZ2dOohVWhtGmPAXWQXCBZ0rT3OrsvGkZKnfgYhhidlUw7MAOmZm2rkUY1YgkUAvdkQDHQjQ=
Received: from BY3PR04CA0012.namprd04.prod.outlook.com (2603:10b6:a03:217::17)
 by CY5PR12MB6573.namprd12.prod.outlook.com (2603:10b6:930:43::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 03:21:54 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:217:cafe::d0) by BY3PR04CA0012.outlook.office365.com
 (2603:10b6:a03:217::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32 via Frontend
 Transport; Mon, 24 Jul 2023 03:21:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.24 via Frontend Transport; Mon, 24 Jul 2023 03:21:53 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 23 Jul
 2023 22:21:50 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2] drm/amd/pm: disable the SMU13 OD feature support
 temporarily
Date: Mon, 24 Jul 2023 11:21:23 +0800
Message-ID: <20230724032123.504966-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT030:EE_|CY5PR12MB6573:EE_
X-MS-Office365-Filtering-Correlation-Id: 574c06d2-1983-4489-7d0a-08db8bf520f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KqRZuKxNShZ40wgKZ8tCNVYvzFSPsjVGrfaMNNw2B/4mA+yyL4S7aodi/58n6AhENSTJBax0wv43pd4BikEc83mm83DXX3j1UeILlrvMC31clH1nijyA/RRLOmES2htf1yM1cyxCrHmPQ1uzrokXBF1+9/wAM5bo7KRrA/qXFJrIivHCgHW1gcYk8dr62e7xDVc0cN7qcP/6tpn0fxLm11D1YccJnMukBm7BDDPIjba4A8lxPu4tNEVT9DOuvMaEI5UoNjAVKGZLoR9aUfsePmJhDBCNZPfVO81xPYJ500SqIIvTjfBA2wLfXtqBHTylifyT//knHzOQexgXQo1exa/QBp6abEeb8Q+mnUKYgqzgGnOEx/7067yxA9pNPJaPs23lXi1UFmnrWcvgOkWTW6cq1P8sNxcjwGNBWJp++mR0s0daj6HjM63Jf64X4lrPz37d6CyVgbxJiT5T6L+j0QJAH7WRjBPbspxYp061xOW1GB6GePrsbazbLg8tZBKmlCqfeXj1+gVFKGPZqHWBFUwU7JLFT+HD+pYCxPX3FzGIWByMxwr4oXsJCu1VswmtI+/bKotgvfDuQv1RMzgwuV23PZZDQ2ERGkHfo+tyflJvUxQau8HiltwISHYcJxwROvyi9ddgonHECYUfq66IvCWueSNLKeaDBHYgkF/ydXW9Sj8E6vxRoViQ1ekgaK2OesEdWWb5qxHzrGV1X8jAdp+jYAETZJm3DlV06NI+llnjn6yUgL4tN4dKyJLZoIFH3I4w+riqpU5wvJYpTuYeEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(7696005)(6666004)(478600001)(54906003)(16526019)(336012)(186003)(2616005)(1076003)(26005)(2906002)(44832011)(316002)(41300700001)(70586007)(70206006)(4326008)(6916009)(5660300002)(8676002)(8936002)(82740400003)(356005)(81166007)(36756003)(40460700003)(86362001)(36860700001)(426003)(47076005)(83380400001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 03:21:53.7742 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 574c06d2-1983-4489-7d0a-08db8bf520f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6573
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The existing OD interface cannot support the growing demand for more
OD features. We are in the transition to a new OD mechanism. So,
disable the SMU13 OD feature support temporarily. And this should be
reverted when the new OD mechanism online.

Signed-off-by: Evan Quan <evan.quan@amd.com>
--
v1->v2:
  - comment out other unneeded members altogether(Guchun)
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 15 ++++++++++++---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 10 +++++++---
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 60d2684478a0..160362540a03 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -348,18 +348,27 @@ static int smu_v13_0_0_check_powerplay_table(struct smu_context *smu)
 	if (powerplay_table->platform_caps & SMU_13_0_0_PP_PLATFORM_CAP_MACO)
 		smu_baco->maco_support = true;
 
+	/*
+	 * We are in the transition to a new OD mechanism.
+	 * Disable the OD feature support for SMU13 temporarily.
+	 * TODO: get this reverted when new OD mechanism online
+	 */
+#if 0
 	if (!overdrive_lowerlimits->FeatureCtrlMask ||
 	    !overdrive_upperlimits->FeatureCtrlMask)
 		smu->od_enabled = false;
 
-	table_context->thermal_controller_type =
-		powerplay_table->thermal_controller_type;
-
 	/*
 	 * Instead of having its own buffer space and get overdrive_table copied,
 	 * smu->od_settings just points to the actual overdrive_table
 	 */
 	smu->od_settings = &powerplay_table->overdrive_table;
+#else
+	smu->od_enabled = false;
+#endif
+
+	table_context->thermal_controller_type =
+		powerplay_table->thermal_controller_type;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index ebb961f60316..f12850acfa12 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -338,18 +338,22 @@ static int smu_v13_0_7_check_powerplay_table(struct smu_context *smu)
 	if (smu_baco->platform_support && (BoardTable->HsrEnabled || BoardTable->VddqOffEnabled))
 		smu_baco->maco_support = true;
 
+#if 0
 	if (!overdrive_lowerlimits->FeatureCtrlMask ||
 	    !overdrive_upperlimits->FeatureCtrlMask)
 		smu->od_enabled = false;
 
-	table_context->thermal_controller_type =
-		powerplay_table->thermal_controller_type;
-
 	/*
 	 * Instead of having its own buffer space and get overdrive_table copied,
 	 * smu->od_settings just points to the actual overdrive_table
 	 */
 	smu->od_settings = &powerplay_table->overdrive_table;
+#else
+	smu->od_enabled = false;
+#endif
+
+	table_context->thermal_controller_type =
+		powerplay_table->thermal_controller_type;
 
 	return 0;
 }
-- 
2.34.1

