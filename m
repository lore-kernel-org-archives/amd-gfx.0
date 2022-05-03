Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF4B8C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:09:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B86410EA13;
	Tue,  3 May 2022 20:09:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BCB510EA13
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:09:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZEuZ0Y37V8KZaFPYKfYVUkXpVveZv+bqusNbak7wev3l5B1BpvkxLb6JpPh/zPLEZ3rNb9xtltY0E+NLSDS97s6uelgk9wlnX4G7gPPtni6XhxFoJJhNsYlh9R9awrqofqna029Kpa0KiQVpbrHSBFrvrmzpmYw8Un/hJfN11IMtDxb15lB7rDnI677yF3JF721ZtBihc7puHfJv0jv/wgE4QprtRROkIHk2TQaBz9ol5WDL5AaAy43UOkC4mPATzVBNVUtsbr1yLm5N7aoaESEk4J5gRo1hjutRtHmXYipNTGGvJ1GhK47xiVkPTrARfWdO4rCfVv67dh3ANiurA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAJgdZ1uxjEpR1q9ZHlzl1/h3wPKikykSadmuEDQLd8=;
 b=jUMeMw2nj15zi6PZkvFPQQsnyMibldcvdBCJMOCeToFgtFuc2Vh3riFlHskzcocy3Kr5hTyky/1m+vZ7NDrPsGhKxVveRsFFu1G8BZlBm6dvqySU/1MSfiTyreuiB7/4Y7d84FUvMkDtHIX+e8YG9g+JY5EchYJ7Frit6LiTmEbFNG0MSOfUPPjDrxyohpltcI5hV8b8utzl5r2erND670xgTimKngE5ky8I9DOaZD/MHOIYyjExyJr+plcme/aPWMJJIj3ZWOana7dokLeiGjbPxZoQjEmfNKaYq8y5IQNB5BourK2/U/Ln1t/XysJNfNTDu8j968M4JL+cDLpZXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAJgdZ1uxjEpR1q9ZHlzl1/h3wPKikykSadmuEDQLd8=;
 b=F5CWaiYvx+omlhpm24JIDS+gLepmGyLo1z2OLoVCUqWyotvglX6NicmSXyXTKXO8jo5Rw5KTK1Xusxu7rtfhDTQvXo2rwDr+KTS4/xEYMT2bbWqwIhcPKW+s1r7HLq8wGsdJnzNlAlo8QgocVHtzB+zdF0uTsxI2TEKFwK73ee8=
Received: from DM6PR07CA0058.namprd07.prod.outlook.com (2603:10b6:5:74::35) by
 MN2PR12MB3183.namprd12.prod.outlook.com (2603:10b6:208:101::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 20:09:15 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::96) by DM6PR07CA0058.outlook.office365.com
 (2603:10b6:5:74::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Tue, 3 May 2022 20:09:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:09:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:09:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: enable deep sleep features control for SMU 13.0.0
Date: Tue, 3 May 2022 16:08:40 -0400
Message-ID: <20220503200855.1163186-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503200855.1163186-1-alexander.deucher@amd.com>
References: <20220503200855.1163186-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a6e7a7d-a326-4c3e-fbae-08da2d40cc46
X-MS-TrafficTypeDiagnostic: MN2PR12MB3183:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3183AC54705095A78B34AC30F7C09@MN2PR12MB3183.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ff2v9FddGdR+sLdTEmXJylTQAb9R5RLxtNKAxVZBpEw+Gj/4R5RSJFagI6OH2SZRoO/VqAw8AUR/aBFU6lfGnxo359EyDk0vV90cyKyrdFsbSwvqbUces9+aokIvKuOY1zfdaR1ezIIeyQp2O6tfJsitMFz0etgIRqfEaYIICkocrWoiR3O6J9D7zNueiwlTUH1Mk1vvF6sUmU7YCxUYV31Yu1fNlnXWRkbmjIKS0yqUBMyLN5WVNymUW+ulKVPTpXHHBQsF7JWElKy8woLTtCRiA6BcoUDkFI0rfbo8wNdBSt1KI+rhKwe35VrTfTak0MLDZowVVNihd2zOETn9bUQpcj1a6UZxLIRsuYjupPvPXG7qhJS/fWD78jiMSfo8cyWnIoFcNWUhP6lagO56vhNvPOJzsUDWENZuJ54TXTuByO5CjiNNJv/MiplkzLRaTWZhoRSlgfDSQDq3haeeWfxloJ8oD1n0PmwvpPiqPaV+EsdWlWl3UGITGlELtmzjzBbNyI9Wfm1wtu+Mhj5nnMrNty7N502Ui9l3qLw6IHnk4o2joFCFaw1P4uFGLIpG32mau5Q2m2XZKguzwlWeDvovpnZ7Ndf/vXaAC18/DU+9zx+EsE2jDayWqqgvwiWjK8szvbT3b/6iUAmB9Y8rMf6IfuF+uTkHFCRf2bWrYi/J+95CvO6ZsDAEQEf8rt7GpKiwHvOrrr7uPhLYHOB5EA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36860700001)(1076003)(4326008)(8936002)(36756003)(2616005)(6916009)(70206006)(70586007)(6666004)(8676002)(2906002)(508600001)(54906003)(82310400005)(47076005)(26005)(66574015)(40460700003)(356005)(7696005)(81166007)(426003)(336012)(186003)(16526019)(316002)(86362001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:09:15.3613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a6e7a7d-a326-4c3e-fbae-08da2d40cc46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3183
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

Fulfill the interface for deep sleep features control.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |  3 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 73 +++++++++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  9 +++
 3 files changed, 85 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index f05ae0fe86e8..e33686a12df2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -275,5 +275,8 @@ int smu_v13_0_init_pptable_microcode(struct smu_context *smu);
 
 int smu_v13_0_run_btc(struct smu_context *smu);
 
+int smu_v13_0_deep_sleep_control(struct smu_context *smu,
+				 bool enablement);
+
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index eea7aee06af4..da458e146252 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2111,3 +2111,76 @@ int smu_v13_0_run_btc(struct smu_context *smu)
 
 	return res;
 }
+
+int smu_v13_0_deep_sleep_control(struct smu_context *smu,
+				 bool enablement)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int ret = 0;
+
+	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_GFXCLK_BIT)) {
+		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_GFXCLK_BIT, enablement);
+		if (ret) {
+			dev_err(adev->dev, "Failed to %s GFXCLK DS!\n", enablement ? "enable" : "disable");
+			return ret;
+		}
+	}
+
+	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_UCLK_BIT)) {
+		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_UCLK_BIT, enablement);
+		if (ret) {
+			dev_err(adev->dev, "Failed to %s UCLK DS!\n", enablement ? "enable" : "disable");
+			return ret;
+		}
+	}
+
+	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_FCLK_BIT)) {
+		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_FCLK_BIT, enablement);
+		if (ret) {
+			dev_err(adev->dev, "Failed to %s FCLK DS!\n", enablement ? "enable" : "disable");
+			return ret;
+		}
+	}
+
+	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_SOCCLK_BIT)) {
+		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_SOCCLK_BIT, enablement);
+		if (ret) {
+			dev_err(adev->dev, "Failed to %s SOCCLK DS!\n", enablement ? "enable" : "disable");
+			return ret;
+		}
+	}
+
+	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_LCLK_BIT)) {
+		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_LCLK_BIT, enablement);
+		if (ret) {
+			dev_err(adev->dev, "Failed to %s LCLK DS!\n", enablement ? "enable" : "disable");
+			return ret;
+		}
+	}
+
+	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_VCN_BIT)) {
+		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_VCN_BIT, enablement);
+		if (ret) {
+			dev_err(adev->dev, "Failed to %s VCN DS!\n", enablement ? "enable" : "disable");
+			return ret;
+		}
+	}
+
+	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_MP0CLK_BIT)) {
+		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_MP0CLK_BIT, enablement);
+		if (ret) {
+			dev_err(adev->dev, "Failed to %s MP0/MPIOCLK DS!\n", enablement ? "enable" : "disable");
+			return ret;
+		}
+	}
+
+	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_MP1CLK_BIT)) {
+		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_MP1CLK_BIT, enablement);
+		if (ret) {
+			dev_err(adev->dev, "Failed to %s MP1CLK DS!\n", enablement ? "enable" : "disable");
+			return ret;
+		}
+	}
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index b43884cf939c..eda0f59f07ae 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -141,6 +141,14 @@ static struct cmn2asic_mapping smu_v13_0_0_feature_mask_map[SMU_FEATURE_COUNT] =
 	[SMU_FEATURE_DPM_DCLK_BIT] = {1, FEATURE_MM_DPM_BIT},
 	[SMU_FEATURE_FAN_CONTROL_BIT] = {1, FEATURE_FAN_CONTROL_BIT},
 	[SMU_FEATURE_PPT_BIT] = {1, FEATURE_THROTTLERS_BIT},
+	[SMU_FEATURE_DS_GFXCLK_BIT] = {1, FEATURE_DS_GFXCLK_BIT},
+	[SMU_FEATURE_DS_SOCCLK_BIT] = {1, FEATURE_DS_SOCCLK_BIT},
+	[SMU_FEATURE_DS_UCLK_BIT] = {1, FEATURE_DS_UCLK_BIT},
+	[SMU_FEATURE_DS_FCLK_BIT] = {1, FEATURE_DS_FCLK_BIT},
+	[SMU_FEATURE_DS_LCLK_BIT] = {1, FEATURE_DS_LCLK_BIT},
+	[SMU_FEATURE_DS_VCN_BIT] = {1, FEATURE_DS_VCN_BIT},
+	[SMU_FEATURE_DS_MP0CLK_BIT] = {1, FEATURE_SOC_MPCLK_DS_BIT},
+	[SMU_FEATURE_DS_MP1CLK_BIT] = {1, FEATURE_BACO_MPCLK_DS_BIT},
 };
 
 static struct cmn2asic_mapping smu_v13_0_0_table_map[SMU_TABLE_COUNT] = {
@@ -1571,6 +1579,7 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
 	.set_tool_table_location = smu_v13_0_set_tool_table_location,
+	.deep_sleep_control = smu_v13_0_deep_sleep_control,
 };
 
 void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
-- 
2.35.1

