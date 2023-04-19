Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC51C77B75
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Apr 2023 12:01:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5470010E163;
	Wed, 19 Apr 2023 12:01:04 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9252910E163
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Apr 2023 12:01:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eU63WfNRyF/QBoZgZlxoEETGmrIkwC6iOxavdsMGrtwm9cfC23SDITvriiPCRSbIypAua7vVhU7+YoH3lwwFeE0xY/bl/PLhj65jhzhGfnl2xLe+g8jfVB3mlZCt2IuOwI1mq7/rA4cemOOjsmp8RMIyO/wSNdvIJx7owzJdbTtt2x+xtFagiM3ELGu3KqaQ4DI3IV7xX2jkNH2WyGKzsgf4MaNU2nmW36JG57+HGZ2ThOTuwFX6xDcc410a3giNfWYhhkKB5/3P3L4jaCNtXbPnQSCwRWrRxMNDEz4zdd0/1miFnko9r2rQ7uqy326Y2mOXLnH/CqBffjTVBJCIJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4Q3cXuxuhGMb3qcFErjOgaJFLLPEoNTrIQiVXZB3qM=;
 b=isXByK0shUGRv6TaXKfho/lYwiaaR0PgGeLCCIiE4OCNwfpsR5NqypKwWmBgdP9cnmIR87T5FXxoTeeQokthP6loDxCIRjYU4y4xEkCf9HRVVvVesxMIUWOBVrIiUtM6RRGjnlQU5JfQxGpX/p+UHE8zTym9bzmJ0JzUU7ZXzC8gsIgpEDeRToQgZ072XvZsU4NZ+3Mq7tGayIxx5Jea5QBOR5SG9zggZGE/+AKvsVTYobP+rd+ceuGX5IFjl1JGq3Nu5RjVDtL4uPYwtgE1eShjOwzTNwcj4Ii1ulPIj8aB+H7NiLeh32x1IPLbjjuvuN6cD+nB4TckWBL1usoxow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4Q3cXuxuhGMb3qcFErjOgaJFLLPEoNTrIQiVXZB3qM=;
 b=OqQOLE9VQWyyEueKEFEr/hSv0gEG6XauuiAYjo97GhE3rVgHwM9YbfY50m+QJsYk5lKYnkWeU6D4WyDMrLXClFoIc0X2lZgtOELbhqxJHDtKiHeMkmQIUuHc1UgpZurkG38QKESCaQlA97Phwp3QD+O2bEQP2auT0Cm4NVtXF4Y=
Received: from MW4PR03CA0185.namprd03.prod.outlook.com (2603:10b6:303:b8::10)
 by SA1PR12MB8093.namprd12.prod.outlook.com (2603:10b6:806:335::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 12:01:00 +0000
Received: from CO1NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::8f) by MW4PR03CA0185.outlook.office365.com
 (2603:10b6:303:b8::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.47 via Frontend
 Transport; Wed, 19 Apr 2023 12:01:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT113.mail.protection.outlook.com (10.13.174.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.23 via Frontend Transport; Wed, 19 Apr 2023 12:01:00 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 19 Apr
 2023 07:00:57 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Jerry Zuo <jerry.zuo@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: [PATCH v4] drm/amd/display: Add logging when DP link training Channel
 EQ is Successful
Date: Wed, 19 Apr 2023 17:30:39 +0530
Message-ID: <20230419120039.162313-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT113:EE_|SA1PR12MB8093:EE_
X-MS-Office365-Filtering-Correlation-Id: 085d5133-478c-4c24-7c33-08db40cdbe00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G2JuwGl5/kNdSD4IW8vSHc2ljWlB380tnGgYbO6VVU/br0g7EqyOoQ+6azf9JQ5wJCvaLPmiHR19w7lGaNgH1sOEUhGpQcBmbEHxLWTgz6Ld+mnTjKNiDSLwqJMrH7m/tRAnFjyBYguMxM/QPUtc3qzUk8Q+riSmOMEV/HzIKDoFbIm8uMiVuPyAs7Cq6fIEFKCBTym0r7YswSJrPUrio3RY81/3BhS+ztyNhsgjdIL+si91+ozIG2mKvW9FfaHiKudthgWF8iOHrcoqYXL0Be/0FMoQWZ3faWCjC6jn6ZLs9UVR4+YtgxGs7uNGMjQ9nFuch+khz7DW5ncqof5pWxxoFeApIqNJ1NEOiRGtSkdFY5giKltVMUAktqGv5+2ZKgQNXMdn2tzw+vfl1lfRydgkJRSCGuBik219rfi2QHUpEa99oFgStKI/Pav1xbLgHA/9gpDG/pnNWnuuo+U3v6S2T2i0eysxFMjkWfLKaJ2PwOShz9TnZKovXBSS+J5b/jVi3Tm9YhjauMN4w3ON2Gzkry58Pqqg/Uc11dCcd10nGZ698XRCkOYHoxyAWIGUOcy8We7kLcqE7Yvz7vRRFYZknXZhkDI/HgGzj+8KEJgwvOO3OamuUih+NOlcE/D/HfdzE24aX3J9bINnUjvP/D+CSg5cm9d18TkozlYxZQGAyFXXRyayx5TE3KEr/8XcS2LoNxbCqUv3Q6z3fykXDG3gGRHRozJkzgHzIKMEnss=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199021)(46966006)(36840700001)(40470700004)(478600001)(6666004)(8936002)(8676002)(316002)(82740400003)(4326008)(6636002)(41300700001)(70586007)(40480700001)(70206006)(81166007)(54906003)(110136005)(356005)(16526019)(40460700003)(186003)(36756003)(2906002)(1076003)(426003)(83380400001)(26005)(86362001)(336012)(47076005)(82310400005)(2616005)(36860700001)(5660300002)(7696005)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 12:01:00.1670 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 085d5133-478c-4c24-7c33-08db40cdbe00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8093
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
Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Log when Channel Equalization is successful.

Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>

Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---

v2:
 - For consistency of the printed messages, either drop or keep  %s for both the
   lines - it is dropped (Aurabindo)
 - For 128b/132b, moved the statements after EQ interlane alignment
   is done.

v3:
 - retained %s for both the lines, useful for better debugging

v4:
 - move eq/cds messages after dp_perform_128b_132b_channel_eq_done_sequence
   dp_perform_128b_132b_cds_done_sequence (Jerry)
   

 .../dc/link/protocols/link_dp_training_128b_132b.c     | 10 ++++++++--
 .../dc/link/protocols/link_dp_training_8b_10b.c        |  4 ++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_128b_132b.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_128b_132b.c
index 23d380f09a21..db87cfe37b5c 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_128b_132b.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_128b_132b.c
@@ -211,11 +211,17 @@ enum link_training_result dp_perform_128b_132b_link_training(
 
 	dpcd_set_link_settings(link, lt_settings);
 
-	if (result == LINK_TRAINING_SUCCESS)
+	if (result == LINK_TRAINING_SUCCESS) {
 		result = dp_perform_128b_132b_channel_eq_done_sequence(link, link_res, lt_settings);
+		if (result == LINK_TRAINING_SUCCESS)
+			DC_LOG_HW_LINK_TRAINING("%s: Channel EQ done.\n", __func__);
+	}
 
-	if (result == LINK_TRAINING_SUCCESS)
+	if (result == LINK_TRAINING_SUCCESS) {
 		result = dp_perform_128b_132b_cds_done_sequence(link, link_res, lt_settings);
+		if (result == LINK_TRAINING_SUCCESS)
+			DC_LOG_HW_LINK_TRAINING("%s: CDS done.\n", __func__);
+	}
 
 	return result;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
index 3889ebb2256b..2b4c15b0b407 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
@@ -388,6 +388,8 @@ enum link_training_result dp_perform_8b_10b_link_training(
 					link_res,
 					lt_settings,
 					repeater_id);
+			if (status == LINK_TRAINING_SUCCESS)
+				DC_LOG_HW_LINK_TRAINING("%s: Channel EQ done.\n", __func__);
 
 			repeater_training_done(link, repeater_id);
 
@@ -409,6 +411,8 @@ enum link_training_result dp_perform_8b_10b_link_training(
 					link_res,
 					lt_settings,
 					DPRX);
+			if (status == LINK_TRAINING_SUCCESS)
+				DC_LOG_HW_LINK_TRAINING("%s: Channel EQ done.\n", __func__);
 		}
 	}
 
-- 
2.25.1

