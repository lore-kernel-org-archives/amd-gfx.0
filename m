Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85480CF34D5
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Oct 2024 23:36:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3562510E9A7;
	Thu,  3 Oct 2024 23:36:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cHq0Cg4x";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E226810E9A7
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Oct 2024 23:35:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2g4cB3xvhOLhPiLG7vdL8nxf3MLlot7f5+BWCtzgGkdwm+WqyKX5WtGnFJDRRNMwazxR3sDS6Daxlu8XaC2Xb2+q/3t1z+rHUDQwLQbmJSvnfc/XW/rqa3q5EBcjZLET4NK0xYUq0Nf+Iaw8ASp4Dczw+3vvjsb3rV9otpUKEGxG99PYm2X1vel5ZkjhVBlijW4lPTASQu2NYbm24IneEAFhlP3NHpFNON6ORXjRIHs17RIOzsXCgvxcxRWBX8KDrtRniJpODJtuMC0+9R40KwjW8oGNHQUVsBj93C/ifqYHYPE7a1wM51asBmHANqi9stXDq/t/8hPw5jDSqtD8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Yx+7T03+XqUEhLbMVijNPpOyxv3ZTnozmZOQ0uoElM=;
 b=A1EwEdvnX8fPJZ4SYxPMBR3ov7Vcl+DD5S1DRYFYfR+GoQTHZwAiDyAL3eEEZ5m9+oelRZe52+HNu3bBvtFj7zgDdCigt5Z8CIepkwT4HKe5/FjnyyKXrMgV+KupQ6kqCgbnBGcimnhGObW1wq0P7uE1rJJdNFkhgdm2I0tkWeP42zDDydXRSF/n/8Xx4I/wqtY5VS4me7axBk8NI6LORCnAk0fVIYMyXxQ5rp4xzeRDdmbJ4lpScp9PZvhoFCsQSKwbRxAZNUmx8aRzDhm0myiMlQnOsyag0YH9fIK2/SgIYSeQpQyNaiOMJXPpXf7IY/hvm/ePx/pbRdCWNAr+1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Yx+7T03+XqUEhLbMVijNPpOyxv3ZTnozmZOQ0uoElM=;
 b=cHq0Cg4xoC50AGrJmsAohPqYHqFIIBiaQn+RYZcZ3kp2s41bDbnx96JGMzUAe2j7VVcmoxQTea6H7UlASZKA6C+zUIu8m+fJyyJPN/CrvOzJma0nLSoKXgshqqXpcBv0cKg8iV4gPt4TmnmY1r+lgSlSHqBHwoXWR/vM3DAgsMk=
Received: from PH3PEPF000040A0.namprd05.prod.outlook.com (2603:10b6:518:1::51)
 by MN6PR12MB8513.namprd12.prod.outlook.com (2603:10b6:208:472::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 23:35:55 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2a01:111:f403:f912::2) by PH3PEPF000040A0.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16 via Frontend
 Transport; Thu, 3 Oct 2024 23:35:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Thu, 3 Oct 2024 23:35:54 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 18:35:51 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Peterson <peterson.guo@amd.com>, Krunoslav Kovac
 <krunoslav.kovac@amd.com>
Subject: [PATCH 10/26] drm/amd/display: Fix low black values by increasing
 error
Date: Thu, 3 Oct 2024 17:33:28 -0600
Message-ID: <20241003233509.210919-11-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
References: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|MN6PR12MB8513:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ec1328a-aac7-4ee6-0f8d-08dce4041ffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VBn1WCVYDFvOdNs2s59ABeFcCXbNdDvvxlJvpl2ZocayCSVImVReOPXzJQ1j?=
 =?us-ascii?Q?w9/xKxyUQ9UCc9y6+7GbkI/1cbL3J9jWBIi9s9WzHhsZQ6LawYE5xwG1plrO?=
 =?us-ascii?Q?6aBd6G7wg2eI2i0Kvut8BpROpbSROC2H/fWjIhKqFaQIYk66SdSn5uI6vcCJ?=
 =?us-ascii?Q?ZgbWw7uI/WJnGWt0dWRS4K0ua7geGoyUloMDLS0jVRApenL7zXd45XJ3ddyD?=
 =?us-ascii?Q?Q5hPSJS5pqpmLE+FAgjItc3mvZTiLL3bdXLq9mh1zZuSbA0+YfvZRYxPmHrs?=
 =?us-ascii?Q?QwUCK1744kjfU1VVxeT2+iPOPUHJ7P0NqAh8y0jcDM9kDbAC+WkymBCTuqbG?=
 =?us-ascii?Q?kkSq+SoqIUxHfgmc6LF7AxLRroBWaa5iM5pEHkvi3ayedYs5NfSCVnD3vLRB?=
 =?us-ascii?Q?Jxw1z1wD8gFclrHEhKVuEA2ApwWRXDLKgOVcyv/l2qWB8F+kcjK2dYtGrXQ6?=
 =?us-ascii?Q?oLeJpWyKJIdRNfe6zfNhAAOFj/Bq0AhECjvHF11VNs+k2StMbg1/II6vXUQf?=
 =?us-ascii?Q?7AUkgjfWv7V0ddxRPyqwe2toW/nwDmcr8kAXS2M5RPzj+RqzhQKD+SXx18KC?=
 =?us-ascii?Q?bhhhqABQtQ6HwPCxjjmQr7khZ/U7PVU7kT+st4pkVvosrifEkU6Hj3scES2q?=
 =?us-ascii?Q?7qIan8+pjgN0uFzQkyktQK98jR15R3mnIyjSmWYsy/j3+9nJj+9SXx6kQLQT?=
 =?us-ascii?Q?4jI4OSUCZRs5g85ayd/by4FUi7wdXeuTspo53Yz9v0OXyU4YeJtQ9fHNzukZ?=
 =?us-ascii?Q?cF4lDjdP+UCIhQ/5rtOe69HYYUbf8T9cWRnRe0A9g0TV7M7S3jSVoHxE6GJ8?=
 =?us-ascii?Q?0fSEMfJWH5QGyk8fUqLl1Wt23B6cKuU+3AJKsHiWPRaCXx59bC2gdtXV2MuW?=
 =?us-ascii?Q?OcTJZT7ppz+muLz/Yu0Inu+9xs0dz9dpgJ6IGakTBe9J6V6WZbR9jxtMnalU?=
 =?us-ascii?Q?i+uj+isJShRaZa/QMqxUmxgxL6chnn7m6q6NTsaCf5qPBA00PGCo30T4xZ5K?=
 =?us-ascii?Q?xYZuDxTXcmxemw1gmgISm5iWdrVaHyGprA7FYMH4DJINpOI3B7hqRKUqLARE?=
 =?us-ascii?Q?VkFFfwocPJQr+vRpfcdJCpGnM4RTRv6qtRsHSKSddGgbqlwdJT6I48KLCD54?=
 =?us-ascii?Q?2IsUq0v9q4kCQGmGph6M9F71ik4a+bWeVpKo80IMc71DJa+r1MChvwAoik7+?=
 =?us-ascii?Q?9h/Tlb6x18HmngV+zNKLhGv7AMKONIsdZ7z5sAnjnMmS7jbspWTrz3vGDxPM?=
 =?us-ascii?Q?YIxa4PRMEy/hr4ONTw32oL7Uxs/dUAdiW7jRgzn8zbuC47LOrP4E9NEp10uk?=
 =?us-ascii?Q?5dvWhbeDqXrYy3yhQtJth9Mpoaiai0YBqU9p2KA6uxWWHOrGRQe7Lvck8Mxc?=
 =?us-ascii?Q?hXKsQYRHoiGLQYwfHKsHXOnx3Ly5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 23:35:54.5507 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec1328a-aac7-4ee6-0f8d-08dce4041ffc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8513
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

From: Peterson <peterson.guo@amd.com>

[WHY]
Regamma resolution for the first few black levels can have problems for
calibration.

[HOW]
HW LUT is divided into N power-of-2 regions each with K segments.  For
SDR mode we set min point at 2^-10 and increments of 2^-13. It's
generally more than 8-bit SDR needs, but some calibration tools and API
use 12-bit curves.
The fix shifts starting point to 2^-12 and starting increments at 2^-16.

Reviewed-by: Krunoslav Kovac <krunoslav.kovac@amd.com>
Signed-off-by: Peterson <peterson.guo@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 .../amd/display/dc/dcn10/dcn10_cm_common.c    | 25 ++++++++-----------
 .../amd/display/dc/dcn30/dcn30_cm_common.c    | 25 ++++++++-----------
 2 files changed, 20 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
index eaed5d1c398a..dcd2cdfe91eb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
@@ -365,23 +365,18 @@ bool cm_helper_translate_curve_to_hw_format(struct dc_context *ctx,
 		region_start = -MAX_LOW_POINT;
 		region_end   = NUMBER_REGIONS - MAX_LOW_POINT;
 	} else {
-		/* 11 segments
-		 * segment is from 2^-10 to 2^1
+		/* 13 segments
+		 * segment is from 2^-12 to 2^0
 		 * There are less than 256 points, for optimization
 		 */
-		seg_distr[0] = 3;
-		seg_distr[1] = 4;
-		seg_distr[2] = 4;
-		seg_distr[3] = 4;
-		seg_distr[4] = 4;
-		seg_distr[5] = 4;
-		seg_distr[6] = 4;
-		seg_distr[7] = 4;
-		seg_distr[8] = 4;
-		seg_distr[9] = 4;
-		seg_distr[10] = 1;
-
-		region_start = -10;
+		const uint8_t SEG_COUNT = 12;
+
+		for (i = 0; i < SEG_COUNT; i++)
+			seg_distr[i] = 4;
+
+		seg_distr[SEG_COUNT] = 1;
+
+		region_start = -SEG_COUNT;
 		region_end = 1;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
index f31f0e3abfc0..1e1038fb04e8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
@@ -140,23 +140,18 @@ bool cm3_helper_translate_curve_to_hw_format(
 		region_start = -MAX_LOW_POINT;
 		region_end   = NUMBER_REGIONS - MAX_LOW_POINT;
 	} else {
-		/* 11 segments
-		 * segment is from 2^-10 to 2^0
+		/* 13 segments
+		 * segment is from 2^-12 to 2^0
 		 * There are less than 256 points, for optimization
 		 */
-		seg_distr[0] = 3;
-		seg_distr[1] = 4;
-		seg_distr[2] = 4;
-		seg_distr[3] = 4;
-		seg_distr[4] = 4;
-		seg_distr[5] = 4;
-		seg_distr[6] = 4;
-		seg_distr[7] = 4;
-		seg_distr[8] = 4;
-		seg_distr[9] = 4;
-		seg_distr[10] = 1;
-
-		region_start = -10;
+		const uint8_t SEG_COUNT = 12;
+
+		for (i = 0; i < SEG_COUNT; i++)
+			seg_distr[i] = 4;
+
+		seg_distr[SEG_COUNT] = 1;
+
+		region_start = -SEG_COUNT;
 		region_end = 1;
 	}
 
-- 
2.45.2

