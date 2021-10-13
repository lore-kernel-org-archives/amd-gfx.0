Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC14C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 03:11:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 791FF60F92
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 03:11:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 791FF60F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39CC06E061;
	Wed, 13 Oct 2021 03:11:04 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 772ED6E060
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 03:11:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWKhikJaI2UGCFOpHWYN8FXea2CQuna17messje15nSxRy45rMOq4A252zBrWqSDRUNvPuF9d/+HyMXCXq5GS8t+JjvYghEw21SVk/kTAAfbwoy7s8QoF4Icot11eNYXXNUSM2p/2knZZFU9eMICDvDqIKJI4JpKLLhpmEY3hxH38RjVPKih6leL4uq079xJyVC7cDYBUa6Kdd/odj4m1tmqxQC7mK9/93jPpCJ/TxmhKT3GrV0gga+xgljbAArd+s+m/SvBBl/7iwqJImSIpR0b3jKfoERhQLOmwJN0q5I4j/BtFmSL7HB/djvHOzonggVS/qxlJQOaOPDYmWW1IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vsu8XSKqcuxD23JNLFGO5uQx8sk6qQI4r0gbDm5PtUQ=;
 b=hg6zZMfC2K1njrRZve8xlVrVLWLMfxnrOWgldl8PWY+lQsjAHekzCRiegutBqoz6bSdBEueBi2PnsdNU8T5tAZZ+O1x7xOTPB8t8IfqVOCUeKFh8AVRhCknlj/iq+0lwkQHploSsxSlI56huqMWFuvHP8xv0MKGdZQPVec03U44K+APzjMh58dwrjNvRc8YRyKJPbYvu5OOpisArUh2erKdEtX5XYcQ3pHhf4jRUyT6o/m40RA2+0+LzeLLWmwNnw+yfTTqHiwQqo+V1hwjJy8hJtl+2gVQeufhi9mP8z2ZwokOfOzUbvL7a2ueJvxCPQfcdAQT5gVP+KEPfBs1fSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vsu8XSKqcuxD23JNLFGO5uQx8sk6qQI4r0gbDm5PtUQ=;
 b=WB4GT+Xf5tKg0NQP25pVwhKzt2x/lrbVRQEFIAs4V1B4WQsqK+gX4dLgPutbc99RULLcChAiHOeRxNeF9CZXpjP2kJHT0y71dQ1eXIBn1HmvDI8qwL38bw6msWW6gnyFfaz9Mv/4I6rcM/TPMxqL8uCaaMz96lHlSypq/QiI7Ec=
Received: from DM5PR19CA0016.namprd19.prod.outlook.com (2603:10b6:3:151::26)
 by DM6PR12MB3642.namprd12.prod.outlook.com (2603:10b6:5:11f::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Wed, 13 Oct
 2021 03:11:00 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:151:cafe::3d) by DM5PR19CA0016.outlook.office365.com
 (2603:10b6:3:151::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Wed, 13 Oct 2021 03:11:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 03:11:00 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 12 Oct
 2021 22:10:58 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <Alexander.Deucher@amd.com>, Luben Tuikov
 <luben.tuikov@amd.com>
Subject: [PATCH 2/5] drm/amd/pm: Rename cur_value to curr_value
Date: Tue, 12 Oct 2021 23:10:39 -0400
Message-ID: <20211013031042.53540-3-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.33.1.558.g2bd2f258f4
In-Reply-To: <20211013031042.53540-1-luben.tuikov@amd.com>
References: <20211013031042.53540-1-luben.tuikov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f60fa20b-7a64-4f6a-c7cd-08d98df71568
X-MS-TrafficTypeDiagnostic: DM6PR12MB3642:
X-Microsoft-Antispam-PRVS: <DM6PR12MB36423F7C4FC7FA1D31C48AF299B79@DM6PR12MB3642.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:462;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yfO9nEUpCoIsSih2Hh9EP2eFBMl7teC+vQYa4FnsJYR3LVj1LEuviBbjqmWDqq04z/oNpj+7mvMnM0whMac8/jFqd3D/tfZG3sUrEGSZDLPAJzbcyQ+ha4pZE025307ccCl+bI9RAwBN8c7HnIH8vcecEdcB+Sk2jMleZow6ZmsBH9vcD2tv4or99HppxVb9u+xiKQ7Wnm1XoYYr582Zqmef7LRhtAJtjaycjQzUxvDmaSkt4slY5qpdwyTEyCxlMwJlN4xjFEk1dWxYQROX4BfwrDG3RQQreZlhdZW7v+P3qs/YQZkI9cX9bc2Tws4j7G4Umylslgi4xD6fgkh8mvqRgTNIEHaJOePXv2c+GQIm7tis2deGFHlM92T8/F2S5iaQSMFtrhp0DwaC4I3OnMncoRTAvu5eMND0IgMCeXIP8jRmnOxrxHzHT0oMZcS2AeewRkn6zd8A8r+SK+hjvWHnxrlZmi5ohLRzzCn9ZGHv5R3seoPeytai19dApWJ2/BgQ5+e+gCLUhRtL4S54FikeaTfa/JS7JjVZSr6lHYd6qZ8KCCUCQAR1Nv1UfXF2ZssQ7NGPBYSGWQyHUCMoiNA7Vh4hW4ixftO0eHD/azVQcqB4NAHlRwppjHpouFtjvD9vfjcv/uQELlm+6pnKmM9w2/8KQXUKGws1Zw2ZPvvtcaNGc45sknAF6PfPHuTKwwDyHOQDdoG3DxZJ0Gf/AUHl69CFLNs+BUdGM5VEjvM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(508600001)(82310400003)(44832011)(8676002)(70206006)(1076003)(83380400001)(6916009)(8936002)(5660300002)(36756003)(47076005)(86362001)(70586007)(2906002)(316002)(356005)(26005)(54906003)(81166007)(36860700001)(16526019)(6666004)(7696005)(336012)(2616005)(426003)(4326008)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 03:11:00.4453 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f60fa20b-7a64-4f6a-c7cd-08d98df71568
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3642
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

