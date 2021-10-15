Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A899CC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 00:51:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65F4E6108B
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 00:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 65F4E6108B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D487A6ECB7;
	Fri, 15 Oct 2021 00:51:17 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6ED06ECB3
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 00:51:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkAkKg2CTzQD3biHnE1sAV10o5zUF5cdTcnw+ow+JWxgJ1mIOlXgxTRsyURWsPsmcr4/ch28LWMaCocVUFxth8w6F4l+FoViebOk/GxkcKs/s0//fxaWm+l0sPrx7++gTK5qU5fXtGcVt+gTgfXL/SYAg2HbumyPPqLxkf4Yi7euwGv5GHeYieOKrMyfBGV+0qRXmr4Hj5QwhKXbmMwAyBCm1xHkK855Cs4GDgfx3BwkX4eEJoiHRfoXT/tNlnh3UIyy7HKO2fA5pzv0znXmPea+QPO980gR0p+Xc+ZD+mRJFd6uN6koH6XaBcckvQXMosvQuOI/waKG3rTKnA6AUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7b3pVjcNy278O64Hkedl0GRLT3wWf9iX9PJporhw7yE=;
 b=UwskF6w+j5bzfB4ENplIe4qpQcT4TZzbkjXb4kDF610soBp1RggQYXF4+1XEpCwSwLTQco/lo1MZ0BM2HzB8/JfaZq+BJgwUyz9H7YgW2KtznWSbm9OhewB/2Tk9c3gMFMp+j10/I9gv7PhsRoSTHrEvp5o1ON+fZS6DyqtTnBM2MaXwhcGQkDTUbMv66F2f99L/fSpHWaqPNGKRcXhMiZEXi8u0IKQLxiTdt5xs53veS+aryG1MNXGVBjnp0dJl/nnvJBjSLMB8vyiSSFdsjynBRm7QqEeTcdWR1GYn8v5hut0WIAljym0aQDWJn7yfneE28d8PRPJfEaVNIxDthw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7b3pVjcNy278O64Hkedl0GRLT3wWf9iX9PJporhw7yE=;
 b=Qod647kMppxAoQQC71dipW1+L+T2fqwwc+cu+Pe71iyO93ddILWYe6c3rVRdXb8kCfTjZM+O4ldpboOI4YCgWXtIG3gLTBN6LITSm/ZRQ7h85eCayJh6+TeZqJnC0KPyopFTKOSUUV4L9JzbJGz+o37TajJbFXmgqfZgnlCmhFI=
Received: from MW4PR03CA0283.namprd03.prod.outlook.com (2603:10b6:303:b5::18)
 by MWHPR12MB1455.namprd12.prod.outlook.com (2603:10b6:301:10::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.24; Fri, 15 Oct
 2021 00:51:09 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::58) by MW4PR03CA0283.outlook.office365.com
 (2603:10b6:303:b5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Fri, 15 Oct 2021 00:51:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 00:51:09 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 14 Oct 2021 19:51:05 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Luben Tuikov <luben.tuikov@amd.com>, Alex Deucher
 <Alexander.Deucher@amd.com>
Subject: [PATCH 2/5] drm/amd/pm: Rename cur_value to curr_value
Date: Thu, 14 Oct 2021 20:50:43 -0400
Message-ID: <20211015005046.43486-3-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.33.1.558.g2bd2f258f4
In-Reply-To: <20211015005046.43486-1-luben.tuikov@amd.com>
References: <20211015005046.43486-1-luben.tuikov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1899e699-c134-449a-d0e0-08d98f75e0b6
X-MS-TrafficTypeDiagnostic: MWHPR12MB1455:
X-Microsoft-Antispam-PRVS: <MWHPR12MB14551D748F940671952FB33B99B99@MWHPR12MB1455.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:462;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6XAitnbs3t3kMoPrds0l/vGmPHEZsyC3PfUMpnfTOXf6cKdl+1O8vgivYJgAJV/Yar140IhwC63GtaxIagmrkK+ugOa5Vax7M6CTrUQCKIVDpGexSxN9cizEgM5y+OUUMOa56go6Bj+Wq1XRnMVDBmKax/nHZR/3LZQ9MVcc6XiwGh4GnhJRNtFqHoeOA13hc5dcR6pGhV0RQNEuEjV+FeWjjQNzRxUTgrPBayW4Wziy2QwB66aCSCTjJRYBYOGzUohM8JVvmmHdZH5AR1djaJfyHoBUl8fKtB/ISaPC/OP3bMZcKlEoNWT32lJTSz5ZMfXs3jnyHUxj70puem5i9Bd5showKCR15ZB/Ujw7jfpbogGihdnzJDK+SFdKRd7THCyt36DLJwi4PQxkHS+GAhmpBiblbB2Pce1kgjWpx3W12xfIfKIMlIXfoPisaF4R9Nn6VBfn6Cfc6lg4PilJ84qtruvPqP68Aqz7+HmDUaDbchbtqVHDmkByqF42VEfhhasRd/GbC4ln5Uv9QGhI4GheBXNyB3IsGcx7WKmVe+XEo3JqFr1SCcq4SaeeD3InP7MCG6gPOXWD86x2/odoisVZyGzPAHpG5A6YZkTb2kh6YTtcTiEFDaMCYAmDe1f41UYBJ91Taz9mki7+UcaULwOuz5DnF9h8qFFZfF/eNbAOvH89+5rMbWz4f4hbPkAt/jzAEINip82g8/YxE9KS0mhLxLG8XKLfDIZiJCIfWTA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(16526019)(8676002)(336012)(26005)(356005)(8936002)(6916009)(70586007)(7696005)(186003)(86362001)(426003)(83380400001)(1076003)(47076005)(81166007)(2906002)(6666004)(36756003)(316002)(82310400003)(44832011)(5660300002)(36860700001)(2616005)(508600001)(70206006)(4326008)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 00:51:09.1480 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1899e699-c134-449a-d0e0-08d98f75e0b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1455
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

