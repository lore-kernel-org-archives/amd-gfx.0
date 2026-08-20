Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA179C5DF88
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 10:16:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 397C310EFB6;
	Thu, 20 Aug 2026 10:16:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QWZMhzgF";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011032.outbound.protection.outlook.com [52.101.62.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BB8E10EFB6
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 10:16:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MuTzVCkQwYCNjGKJ2Z2Cba7fS/fi7pD5sKFRrCdfIiBQoD2f3zj7aR5KzwPgTM6G0q8c9odRFDM7B8GemjiWZEVgmFhgM8JiuIV88ZV6jGE6EB4+25GKtX9+bckff1W2rERScWMGFbshmLXEK9/Z37sNYJVNHliWpvJsz4aH1wT07/7UPZw2/IPT5jQxAF0SmMBhwWjffGtEBcnhszBK4RFcWkYLPGaT2SZR8bgcTaqSbmqSJVZItra27R+4epPRcgooentuVL0IjJaoWDFA6fh7o/EyHbAil1HhnxsIu+heaU88OOv7i7pYlcuwGuMvrFZzIKeqJfT378J6h8e7/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qrt+vil73wIhoUiZmudTQlMwKqSNHvPGJAoI2N1nYVw=;
 b=o/acB7Fwv0Z7gAtAVa2T8+sxS4rFDJZEUhFQIK+9UbSlOFas4RTn22Jc0eyaYzAzn/97dtrtRq1qXWMfk6D0OMzbTNorjwj6hif+nl0pxUSoBcXE0BzViTGiiRdGzEDcMqS+SCENvjnPy0tk6TTPlOPPD1MBluNko7I0vg5zIgT517vT8bnLuzh2j22F4OpS27xETxPt2dIZbSI3JYUYpUIrNiKL/dCMn8DHZK58UpU4z3spepGGRGuA1s7LArpkvFyRt3OmqQf6QEe6Az+bWUExzo76EVqC45tWC7Y4RxTnlWGYZhCEW94yxgHA/cN5u8TA2K4Q21iHpVlgU5C53w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qrt+vil73wIhoUiZmudTQlMwKqSNHvPGJAoI2N1nYVw=;
 b=QWZMhzgFWJ92YU0csHJSNviuoP9KBbw7BWvNHUyPwBDlxah6D/Cjgl4wKae63jrucddLmCWdINNK0mscGb7Nxh+AQjhZrWtEtGqUF93b9/hrm1gJHXrGZ5auOP3HHwhFL9SB2/kGdcltpLahCDi/FUBaXRK0G3PaUpUPsvplx6M=
Received: from BY1P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::14)
 by CH2PR12MB4055.namprd12.prod.outlook.com (2603:10b6:610:78::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Thu, 20 Aug
 2026 10:16:17 +0000
Received: from CO1PEPF00012E64.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::37) by BY1P220CA0022.outlook.office365.com
 (2603:10b6:a03:5c3::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Thu,
 20 Aug 2026 10:16:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E64.mail.protection.outlook.com (10.167.249.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 20 Aug 2026 10:16:16 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 05:16:13 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <error27@gmail.com>, Roman Li
 <roman.li@amd.com>, Tom Chung <chiahsuan.chung@amd.com>
Subject: [PATCH] drm/amd/display: Fix redundant GPUVMEnable checks in dcn6
 flip schedule
Date: Thu, 20 Aug 2026 15:46:01 +0530
Message-ID: <20260820101601.3942853-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E64:EE_|CH2PR12MB4055:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e6de832-1f3b-43ac-ac69-08defea411f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: ZQ8Mn3rKhil8HtN2F6/W0KN8N32h7uQb/A3azub01JP9IE8gPXfVxLQETRk2ugz4rgXqAGFDDU3bpFeAWtyR/haXoOmVDbbHpYgOk7HbcdOMf03RkSErzf+ingXcMv/cmi2Qf+Ue0+aEIiJz6qxpdOFsoP79K4imZHvc5xDkbnDXJTFX9WowIw7e4TXYZxobZT32T1ANpBb9mrHPMipxZoQabO0tgKpUHk5IuBm/j68SX9O9WGyCHOQEdZnxl35u0kpP5b42JmsW2O4FHxp3R4VPpRj9NrMAqepAWxSuDDsQK8BcLckeCb8sGqVejrxbkC0J3O9FJdv2+nP+sfwCYwb9aM9hVEcmsk6CdNKaA8kvMwIi0VGfDpHdxqhtRSaBjREZSScV3J4oCse4LxHFjuBpGuuuNaDCd8YxnacaMMKW5U0Nlu5p8lND2PGSPeL70VhpHzfqO5uUH+RLHm/shqalM7135hPYkr4cEO9EZ4v/qzaxtxY8zidF1gKreLCrZfesAGnb2QNo8PlDajarWRNqAm5XzD8ewwr2ihWDL8+9OCHEAj+qOwWmNGfyQNMrsuO4LAthbKireyQ8x57KoKSxRXtOhpk4rQV64K8HQMMrepK4fIuKFUEvJA+UOwJgFaE6MgXicpOpRuR6Ue1bEiFxboOQjdrGR12jZF8HQiWTokWvGB2QUsAqc+rwHTpl
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PFfNr/GzEGXUnux5oDTxBowSnVUUUgevamPTncOjurXfj7XM6ElOtLxMqizahl8a++G0MGzCVleIs6jjRxCqcr04qdfqTbyTW7QHtPnQPEXLPlDh2nwx1SL2FEal4S9kaxOX/vpGA3NhtCGDxa9ct8g3G40Oio506frYkEXNAMYveDKuawcrxLwafcttLl52z37dA8RZU6FWKa/XKNuUxdX01GeJPlWX+VkTxTRNKbzVXRH1RoVFOgU9gp4OFUBHZtJCLrCUgVN8aiWjkUWat52zDz7meSOUMlZg402UqsNfMX7wCdAsRXOpyA6rZUYlSIji+opwtXSRAGe00x81kafCW4G77QpF6PdhNswacmPvzZUKMTxMII+sWDlGNkE4P/KySBC4oaEWZs6foOmFxKohTN3OFxwuDzt7K1Qdzr4VFO03tI554pQh0bfWp5+3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 10:16:16.1636 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e6de832-1f3b-43ac-ac69-08defea411f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E64.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4055
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

Inside dcn6_calculate_flip_schedule(), GPUVMEnable is already checked in
the outer if block. But the same GPUVMEnable is checked again in two
inner if blocks inside it. Since GPUVMEnable is always true at that
point, the inner else branches that assign meta_row_height are never
reached.

Remove the redundant inner GPUVMEnable checks and directly assign
dpte_row_height, which is always the correct value here.

Fixes: 04d9a88decbc ("drm/amd/display: Add new sources for DCN6")
Reported-by: Dan Carpenter <error27@gmail.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../src/dml2_core/dml2_core_dcn6_calcs_dchub.c    | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c
index cae6bee93fe3..a4e2f8604650 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c
@@ -569,20 +569,11 @@ void dcn6_calculate_flip_schedule(
 
 	if (GPUVMEnable) {
 		if (l->dual_plane) {
-			if (GPUVMEnable) {
-				l->min_row_height = dpte_row_height;
-				l->min_row_height_chroma = dpte_row_height_chroma;
-			} else {
-				l->min_row_height = meta_row_height;
-				l->min_row_height_chroma = meta_row_height_chroma;
-			}
+			l->min_row_height = dpte_row_height;
+			l->min_row_height_chroma = dpte_row_height_chroma;
 			l->min_row_time = math_min2(l->min_row_height * LineTime / VRatio, l->min_row_height_chroma * LineTime / VRatioChroma);
 		} else {
-			if (GPUVMEnable)
-				l->min_row_height = dpte_row_height;
-			else
-				l->min_row_height = meta_row_height;
-
+			l->min_row_height = dpte_row_height;
 			l->min_row_time = l->min_row_height * LineTime / VRatio;
 		}
 		DML_LOG_VERBOSE("DML::%s: min_row_time = %f\n", __func__, l->min_row_time);
-- 
2.34.1

