Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16DCC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 16:12:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACBEC610C9
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 16:12:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ACBEC610C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9AAD89F9F;
	Wed, 13 Oct 2021 16:12:19 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D341089F9F
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 16:12:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PaQbWcoUnORL8CvPGmEGOKkCPQTgQd51bVP53xwqJcwE8Zu6JzhqxvIdWBghNz+Dlbdj/ntF7TUIWo6UcERCRCppclKs17nOplBnea5jm/+Flrc1qB/4XwmM/EhZM1NniL+35i8Rmd/jPEmWU8+XemGnyGEU1mdE5DSYiqgbQkG92c5hX7tN4gHFK1PNez8jOi4VLjpv+yFrYX42TGKcAg4W1ckonn7YkKbt/FVlip1eqmguT896mCCX5SK0SpqAZ+xgOn5kUp7wEcW/z4LAaMDsds8WB7T4KOf2NpzKb7mwbf3MCqLRvASNBSKd5pSJmpUemLk4//S50qeWEXdATA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7b3pVjcNy278O64Hkedl0GRLT3wWf9iX9PJporhw7yE=;
 b=ayfKR9d8E6Ti+YrKcwLP9zLwjQ3Db3dXQkMPRD9r8oxS78vR4vdSHQ3FFcZsDpEAHALlpLAFL2AVPt+gAIaqQ0FPW0ZYkk+vLiyvbGcVkARj9wz3HZUU6Q61x9kL0bTxlaD+WkBMYCO7tlq+VR56YXWaPtbcyZbQWO4oruNtZkyc4qpq+c6yTimWvoR9MVSlQg/JzasPDkKIgWTXG9EBJDHe0RhvryRDCy/lLmPcfwuj3FVmbE3gMmC0iNuWyQxzSUWBOKdJ/zXxGTI4wEW4Oq7ZHsmxWwNwXchSYMdl4noDUodUQwar7cR7cRNQ90ap+GvukawWuG7AJ3EaCLMdIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7b3pVjcNy278O64Hkedl0GRLT3wWf9iX9PJporhw7yE=;
 b=EC4KqF7g96gLPrcFvG82W3Vim75i6T+Wb3UZYBc6EFwVGmWJ3NGUrRJFHjKaW9xWSXMuX++pzyknPIp2NbWDXuC6+aV5/nkBXnkY+HLSgaaypB+vswAumq678Xj90jMPeGLyEg62L5ilUWkYdph0tKzO6X6DudEA9YQtn8zN6CY=
Received: from MW4PR04CA0054.namprd04.prod.outlook.com (2603:10b6:303:6a::29)
 by BN6PR12MB1155.namprd12.prod.outlook.com (2603:10b6:404:1b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Wed, 13 Oct
 2021 16:12:16 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::56) by MW4PR04CA0054.outlook.office365.com
 (2603:10b6:303:6a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend
 Transport; Wed, 13 Oct 2021 16:12:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 16:12:15 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 13 Oct 2021 11:12:12 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Luben Tuikov <luben.tuikov@amd.com>, Alex Deucher
 <Alexander.Deucher@amd.com>
Subject: [PATCH 2/5] drm/amd/pm: Rename cur_value to curr_value
Date: Wed, 13 Oct 2021 12:11:57 -0400
Message-ID: <20211013161200.9052-3-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.33.1.558.g2bd2f258f4
In-Reply-To: <20211013161200.9052-1-luben.tuikov@amd.com>
References: <20211013161200.9052-1-luben.tuikov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be15cc26-12f2-4b39-76a6-08d98e643940
X-MS-TrafficTypeDiagnostic: BN6PR12MB1155:
X-Microsoft-Antispam-PRVS: <BN6PR12MB115558F05F7150657E542A5099B79@BN6PR12MB1155.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:462;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XnAjcPkihjkNRoi6Lm6sNPDUFS+2OKEdEEI/ZTe0/eY3QTq5vJoFmOE6tI23SyjH6/Tc5fW6WS2W/GUOJH6bPS1iRMBItfPb2Rn8PTaaiuySHIqtv/8XFvetGO1UO2yvcte5AwZnCy1ZnHeXNjPd0U4kN7XhpB3xtkZS8Vt7Xdp+zkEPTjQEu24+PO1qDzexjy3i+tAk6+l3/afQ3gapVaBInAvhvtwQGZ3GMNM71lrDJAR8TVnLCP/W7lSuVyJMoSqwiXYedPKY3hE5+F4RE1iZ5Z5DiVHe4iHW+xbLnz4swLQ2hD0SvgMxUkHfgzip1A/62fWyis9Y5SSmbgMjOkX7R4dNYbsJ26lYAkZ9Nr29SOsYNrU1LTj3gTVLiMyI6THEL+LcIMTkfeB5LznAJxfHYfdpgI2XkwJRl68mFZRsfFp4NiDdGkGK2DBkmf/roNUyse/v6YHFCdGhsruOjtagRD0sJYnhdz22QTACQluIOdnRa3XwRhooVZhcAWqZX1ZQpZQHY7Kfu1jY6tGrFAtLu8oF7/cWeygpTiCxoySrDmqL9QEphAegW6MqdVQw/XiVhXGtkzY1BcvcZLsSuLuU1pwxgZ70YCKQIMbcvV+KcY+oVjeH3/P5141QNeCJG+pMfY/EeL2YwvkCANk6CKwm6T78sbFSrXlDpEdiiihdVKs6WwcW4DSySsAmW5VpvI3JEDeUeygsSWawg3POT9aKn1mQlGvIPU3/Md+3R98=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(5660300002)(426003)(70586007)(86362001)(1076003)(2616005)(336012)(6916009)(508600001)(47076005)(44832011)(54906003)(82310400003)(4326008)(26005)(83380400001)(316002)(70206006)(8676002)(81166007)(2906002)(186003)(36860700001)(356005)(36756003)(6666004)(7696005)(8936002)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 16:12:15.6576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be15cc26-12f2-4b39-76a6-08d98e643940
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1155
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

Rename "cur_value", which stands for "cursor
value" to "curr_value", which stands for "current
value".

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 12 ++++++------
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 15 ++++++++-------
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 0fe9790f67f5af..f810549df493d5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1267,7 +1267,7 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 {
 	uint16_t *curve_settings;
 	int i, size = 0, ret = 0;
-	uint32_t cur_value = 0, value = 0, count = 0;
+	uint32_t curr_value = 0, value = 0, count = 0;
 	uint32_t freq_values[3] = {0};
 	uint32_t mark_index = 0;
 	struct smu_table_context *table_context = &smu->smu_table;
@@ -1292,7 +1292,7 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 	case SMU_VCLK:
 	case SMU_DCLK:
 	case SMU_DCEFCLK:
-		ret = navi10_get_current_clk_freq_by_table(smu, clk_type, &cur_value);
+		ret = navi10_get_current_clk_freq_by_table(smu, clk_type, &curr_value);
 		if (ret)
 			return size;
 
@@ -1307,7 +1307,7 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 					return size;
 
 				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, value,
-						cur_value == value ? "*" : "");
+						curr_value == value ? "*" : "");
 			}
 		} else {
 			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, 0, &freq_values[0]);
@@ -1317,9 +1317,9 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 			if (ret)
 				return size;
 
-			freq_values[1] = cur_value;
-			mark_index = cur_value == freq_values[0] ? 0 :
-				     cur_value == freq_values[2] ? 2 : 1;
+			freq_values[1] = curr_value;
+			mark_index = curr_value == freq_values[0] ? 0 :
+				     curr_value == freq_values[2] ? 2 : 1;
 			if (mark_index != 1)
 				freq_values[1] = (freq_values[0] + freq_values[2]) / 2;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 3f5721baa5ff50..3ebded3a99b5f2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1052,7 +1052,7 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 	OverDriveTable_t *od_table =
 		(OverDriveTable_t *)table_context->overdrive_table;
 	int i, size = 0, ret = 0;
-	uint32_t cur_value = 0, value = 0, count = 0;
+	uint32_t curr_value = 0, value = 0, count = 0;
 	uint32_t freq_values[3] = {0};
 	uint32_t mark_index = 0;
 	uint32_t gen_speed, lane_width;
@@ -1073,10 +1073,11 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 	case SMU_DCLK:
 	case SMU_DCLK1:
 	case SMU_DCEFCLK:
-		ret = sienna_cichlid_get_current_clk_freq_by_table(smu, clk_type, &cur_value);
+		ret = sienna_cichlid_get_current_clk_freq_by_table(smu, clk_type, &curr_value);
 		if (ret)
 			goto print_clk_out;
 
+
 		/* no need to disable gfxoff when retrieving the current gfxclk */
 		if ((clk_type == SMU_GFXCLK) || (clk_type == SMU_SCLK))
 			amdgpu_gfx_off_ctrl(adev, false);
@@ -1092,7 +1093,7 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 					goto print_clk_out;
 
 				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, value,
-						cur_value == value ? "*" : "");
+						curr_value == value ? "*" : "");
 			}
 		} else {
 			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, 0, &freq_values[0]);
@@ -1102,9 +1103,9 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 			if (ret)
 				goto print_clk_out;
 
-			freq_values[1] = cur_value;
-			mark_index = cur_value == freq_values[0] ? 0 :
-				     cur_value == freq_values[2] ? 2 : 1;
+			freq_values[1] = curr_value;
+			mark_index = curr_value == freq_values[0] ? 0 :
+				     curr_value == freq_values[2] ? 2 : 1;
 
 			count = 3;
 			if (mark_index != 1) {
@@ -1114,7 +1115,7 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 
 			for (i = 0; i < count; i++) {
 				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, freq_values[i],
-						cur_value  == freq_values[i] ? "*" : "");
+						curr_value  == freq_values[i] ? "*" : "");
 			}
 
 		}
-- 
2.33.1.558.g2bd2f258f4

