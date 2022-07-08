Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6392DC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jul 2022 16:36:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E10C010E203;
	Fri,  8 Jul 2022 16:36:42 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2080.outbound.protection.outlook.com [40.107.96.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC29610E203
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jul 2022 16:36:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWQ39K4M5tlW3on6zjGIL4u5MxiUWFanzUp/qRkXx2Xrr+Mhrxo6QZDkPnb6lkSniCwYT8XQPWCylLsUqLffZxSrAgEDORXqX7UFO1pv2hC/Ky8WchBO/RZAFn8KCf6+xVlbBHt8Ax52zOoV4TEGlDv1vmtd/QDv2QZrjXDxOo1wNe+XR7U6v79gaSx7+HZ3VY0E/dj0F7+Kadg3/W8Z15KQ99VI59bthR1ek19PLA25F7t8+2RMBUxGn2oXM4jlEy7ZI0rvrywq9ZixTb57QpcbzeYWuWWesklxF01oXFE+tMhUi79b0Dexr/qY1aCnpDcR/1dANhuTG7c8uBEvTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELur1XU1I/P3FU7XNj2QVcTk/kcqai+KoG+3XfbRsyE=;
 b=Uc+CNnAvevdFt96bmeOmJWoCP2uCgQ9KLKiJxIT55xXYLtTklwgcnfPT8SOArFJGlzPt8+wtKjoJGjBeaTMtvmgzH6xRjsHbF5q1qXu5MD1ahsQzLpowLWtZnFkTKHBfQsF0qYjQsrvoqprMbx1n2DYc5YZyt+w2/rlYgSyKi2jTV5Td3pVCNGCShNSKyeORbxBtApQPnKDn4+9Z/U7K+q6Ryiiw1dGbAdRK721jvfwPc9eESKqb8V7DP+d0yV+Iash0Ohlrw5vOOIu61pMdy+PXMXWuVsqwxcK6YT9GSeqxVCYfuJDEfkRIZJNIAvk9Wyi3V5aJFyZmUfPcbzlkaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELur1XU1I/P3FU7XNj2QVcTk/kcqai+KoG+3XfbRsyE=;
 b=uz5Np6L1lNuqoMlnXlK2eAAtrNW5zrgZjh1TE0yyuwrimWq1kzM/1qpf/oMw4jAAZp48woWF9uNzpkiCTegqWSN/7EMfKQc++Xl9ECCuFK/l8YHdrrOHiReMmWShJOSCh00WD4zTiUPfs8+aL6ARYN3XrSdnZGoNdxJnW0u4Z+4=
Received: from BN9PR03CA0910.namprd03.prod.outlook.com (2603:10b6:408:107::15)
 by BN8PR12MB3107.namprd12.prod.outlook.com (2603:10b6:408:46::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Fri, 8 Jul
 2022 16:36:39 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::11) by BN9PR03CA0910.outlook.office365.com
 (2603:10b6:408:107::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.17 via Frontend
 Transport; Fri, 8 Jul 2022 16:36:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Fri, 8 Jul 2022 16:36:39 +0000
Received: from ryzen32.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 8 Jul
 2022 11:36:32 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/21] drm/amd/display: Disable PSRSU when DSC enabled on the
 specific sink
Date: Sat, 9 Jul 2022 00:35:15 +0800
Message-ID: <20220708163529.3534276-8-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220708163529.3534276-1-solomon.chiu@amd.com>
References: <20220708163529.3534276-1-solomon.chiu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 425f17bd-ebcf-4bf7-baaf-08da61000850
X-MS-TrafficTypeDiagnostic: BN8PR12MB3107:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dGI54JVCnEbLBKZgU3ZJNr4oEWTTfKrkt/hmttkvggKR1LSWtZ/4vscctnYEkuKh0CKoG+uvB0oUl2O84guajXgU+HfMtXyyXtxOuGc3z7+U5eCkigZHFOZB/pj59J8WPhvUg5kAASTkiZwuJwxljny5OkTresa4u0vhW2XL1Y3eZUH0i53H6+O/hwOSrFZLPX8h7gSHAe/M7jGJYejA6pm7bKlo9RaWZZ/DSSqcpezdyDZUXKV1dRacvUR2Xd3+EA6nkxYSq0AGTKoJzil3Q3VKt8BAOYeYKLQyYo1yzdiMXaDWqrbcy8kdUNO7HYVcDfYcgy/BrmKenAm/ZwU71rMwLhF2td4m++h9EYN/XEDNRNW6r20Rsk2A6yMTydURznqr2r0Qpm1QrzkxacX8VuR9MTDgRxpHUtvdo6/mPLrcoktFPbNwnu1RKJI3fPGbTaFyKFJIQf0KoS5/Tw4sWBD3w2akbIEvHNztQFAAbVxvNb+93aeSK7Y6N3p7TC4BJgr6j5UZzFClG+92vDJSH112OTwtMttUqUaxLnwwWG/qCr5JbxhHvu9nyXRU4EMgwyv9iBi+h0c4O4+XgE3po6UCoYR/7XUl61hgG2ynZbUm5VogwwLrghRA1Jpzob0y47tDesO3ej1FEgbEAvHOHrwwNNvv4CnNz/HGux5hfkF227aJ8eX45Q+DvPmSISJepdgUDMRY1TpKTe0ag1j0WwXgtb1SC5ALioSbarJJ6b8+wexjCHkSBbk8JsjEA7G/DCfonebl3F9UQLpjuJaZTxG5btAP0NMu7SpNixsgNSBzAslQI7qXF7+7tR0c/IofzYZ4F6WfUtG2mxWHrGiAJeYO/g+lJRGGBAM0krtRYc12oAf0chOlJ2flqDJDPX+o
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(346002)(136003)(396003)(46966006)(40470700004)(36840700001)(81166007)(83380400001)(356005)(82740400003)(2906002)(186003)(34020700004)(1076003)(336012)(41300700001)(47076005)(36860700001)(36756003)(82310400005)(426003)(478600001)(8676002)(26005)(54906003)(40460700003)(8936002)(2616005)(4326008)(7696005)(70586007)(40480700001)(44832011)(70206006)(16526019)(6916009)(5660300002)(86362001)(316002)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 16:36:39.3124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 425f17bd-ebcf-4bf7-baaf-08da61000850
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3107
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
Cc: stylon.wang@amd.com, Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Robin Chen <po-tchen@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Robin Chen <po-tchen@amd.com>

[Why]
Some specific sink is not able to support PSRSU when DSC is turned on.
For this case, fall-back to use PSR1.

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Robin Chen <po-tchen@amd.com>
---
 .../amd/display/modules/power/power_helpers.c | 33 ++++++++++---------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index bc239d38c3c7..235259d6c5a1 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -794,33 +794,34 @@ bool dmcu_load_iram(struct dmcu *dmcu,
  */
 bool is_psr_su_specific_panel(struct dc_link *link)
 {
-	if (link->dpcd_caps.edp_rev >= DP_EDP_14) {
-		if (link->dpcd_caps.psr_info.psr_version >= DP_PSR2_WITH_Y_COORD_ET_SUPPORTED)
-			return true;
+	bool isPSRSUSupported = false;
+	struct dpcd_caps *dpcd_caps = &link->dpcd_caps;
+
+	if (dpcd_caps->edp_rev >= DP_EDP_14) {
+		if (dpcd_caps->psr_info.psr_version >= DP_PSR2_WITH_Y_COORD_ET_SUPPORTED)
+			isPSRSUSupported = true;
 		/*
 		 * Some panels will report PSR capabilities over additional DPCD bits.
 		 * Such panels are approved despite reporting only PSR v3, as long as
 		 * the additional bits are reported.
 		 */
-		if (link->dpcd_caps.psr_info.psr_version < DP_PSR2_WITH_Y_COORD_IS_SUPPORTED)
-			return false;
-
-		if (link->dpcd_caps.sink_dev_id == DP_BRANCH_DEVICE_ID_001CF8) {
+		if (dpcd_caps->sink_dev_id == DP_BRANCH_DEVICE_ID_001CF8) {
 			/*
-			 * FIXME:
 			 * This is the temporary workaround to disable PSRSU when system turned on
-			 * DSC function on the sepcific sink. Once the PSRSU + DSC is fixed, this
-			 * condition should be removed.
+			 * DSC function on the sepcific sink.
 			 */
-			if (link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_SUPPORT)
-				return false;
-
-			if (link->dpcd_caps.psr_info.force_psrsu_cap == 0x1)
-				return true;
+			if (dpcd_caps->psr_info.psr_version < DP_PSR2_WITH_Y_COORD_IS_SUPPORTED)
+				isPSRSUSupported = false;
+			else if (dpcd_caps->dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_SUPPORT &&
+				((dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x08) ||
+				(dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x07)))
+				isPSRSUSupported = false;
+			else if (dpcd_caps->psr_info.force_psrsu_cap == 0x1)
+				isPSRSUSupported = true;
 		}
 	}
 
-	return false;
+	return isPSRSUSupported;
 }
 
 /**
-- 
2.25.1

