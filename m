Return-Path: <SRS0=MFBU=NC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9001DC4320E
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 08:33:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53FBD6108C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 08:33:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 53FBD6108C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 425786E0CD;
	Wed, 11 Aug 2021 08:33:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32E8C6E0CD
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Aug 2021 08:33:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gu2GUHlkLycjLEMCR5hJA6V3d09ahFrMHTiG18Wwr78C9YqzABp9yVsW8fosh4KGwOFhVIcyzenTujuhC12qUcW/aVRftUJGj5vzJB7/slCrFatzX2VftkAY+XnLB/FvC2MgMMrneimSFnSF3OM/Y1nKUEgL4z6TZcWbMwE+npX2thpH6IsDmCghKPdWumde7PZm4Scnq4bqKwSnGsOwX1TKq7PAFiEZ+Ww2tM8iQ1z+9In4IMJzhQ8sTOyvsR9xTtxcv1wAkY+v0pRgXRg1c4lzGivSZWulW2CmAtm+sKWtqIknf/S2ES3tM3HKA2oqyR4YgtHgTpFXN3a1ard4YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aLUJvWfx9N+pNh4GfHWIjil+6aksGLG7GOA/WiTV8U=;
 b=AFdxSDkAURPix9g1CLHVAuWdHwrjGVQYG9lpdV5cZy8nfan2asz7PIO5jCiNd3ZHbZPKUH2IIwOZyCr55sufpA/sNzcJtxjOQJznYKFwooHkRm4ay8278d5vQnF7PNmQpswzBmFkSEoh1+lXWRjwrt3DvozW2XHLHhTK7Yn7visalUkEZPvn0Rw1ZkMYZ60sjPcQ/J0XIJzLqXFN0JaCX1YNZpSShwnXByovz2oXSFrykinVisQhg7TjhVLeuCpI1rM6OF+64sfs20Ke3ybQv/u3C5Dvouhb+wsQ9pGpTyip2qFV+ud6JHwWsqp314Mp9ASoBs7Z3i0skgegeLAmxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aLUJvWfx9N+pNh4GfHWIjil+6aksGLG7GOA/WiTV8U=;
 b=pEN474bL3RhastOGcCh5lNhrRsc7zyXwybdbi55mZxyDJW5sc/rX9HtCGgpXeJq7QVisyrln+rVu2PvmoqGMkn3du84m0osKftHDg6I7iy7Uuc+dWClvSIRIPjJJdbsQPFaHzz3Qgp5di3a0iR614/hcTgojLaBdOOfIxio+NmM=
Received: from BN0PR04CA0073.namprd04.prod.outlook.com (2603:10b6:408:ea::18)
 by SA0PR12MB4573.namprd12.prod.outlook.com (2603:10b6:806:9c::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Wed, 11 Aug
 2021 08:33:32 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::c0) by BN0PR04CA0073.outlook.office365.com
 (2603:10b6:408:ea::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend
 Transport; Wed, 11 Aug 2021 08:33:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.14 via Frontend Transport; Wed, 11 Aug 2021 08:33:31 +0000
Received: from kevin-ws.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 11 Aug
 2021 03:33:29 -0500
From: Kevin Wang <kevin1.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <kenneth.feng@amd.com>, <frank.min@amd.com>,
 <hawking.zhang@amd.com>, Kevin Wang <kevin1.wang@amd.com>
Subject: [PATCH 1/5] drm/amd/pm: correct DPM_XGMI/VCN_DPM feature name
Date: Wed, 11 Aug 2021 16:33:19 +0800
Message-ID: <20210811083323.1084225-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b818ed01-e61a-4c38-5015-08d95ca2b3b2
X-MS-TrafficTypeDiagnostic: SA0PR12MB4573:
X-Microsoft-Antispam-PRVS: <SA0PR12MB45733D418784CB15A1DF4D82A2F89@SA0PR12MB4573.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0/obyUbZ+SBqK8EQwKcqPRnakRgJEthClZz0xi/6zRsxofPff5HM5YyHj1JUdNXwuSr7L9WFNMuDOlMn6ddNCGfDZNYvINBz6OEL12X4+7WHRqkGIqgxr/bs4Q8OdgUonWKg9pAcCh2GSk1kbFU4dYSwFy6H4nsoHh5t/E3E8hDToKvuIW/vZzR7/G7sanJUIdabVwdXtiZujRUO+pNJtRoaD/SIA6/SIMc5UkVqsmIZrSSUqM3Wg8wZ8LxjTk9IB32jimbUVkf4LpWJ9PSClfwpME3Vu0+eO113iv8eeyKqka/8/rOAF1gDvjD8excNcVLlAoDdp1eCKEK0d0l42lZ66aEbPL4li15qhtnjUKwzV+Zi3W6XbAg6/E1gf/N2c7+z7gvXckGt81/zDiaXV5Yj2HFCaNRFbkeIohOk5EUv/XIbLedP7MjfSs+eiKFIP5lrIAmIptCVkMyG/ScGG+iiQVhXCklHrzAQcbt6nSqEjlKhNDlV8OidOYgIRQml1EtPr906cRGpfm7X25lNPNJC6+aeNGhqlTUP+8ssdF+ymxewjZ+8E4GuB3l1oj42IIntkLof6xf0ayuV1CFAZZaBs1EklGgbIMP314F+WmqKSZ+DUtW0g986p2ePdGWKlpkWyxkbKnxbdShTsQ/c7VBORowzalgJan25YQWbu2etTQlqhvDCGWovnyCrZUUzldG0fEiedoX2DKWdL+U2/tPbk1BfrP8mssHjBsKpUbihT6+QB1XNqjOnONULyTiitb/p0xIuDxlcM+h+vyx8JQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(346002)(136003)(36840700001)(46966006)(36756003)(336012)(426003)(34020700004)(70586007)(26005)(8676002)(2906002)(1076003)(478600001)(82310400003)(2616005)(86362001)(186003)(16526019)(70206006)(316002)(81166007)(5660300002)(6666004)(54906003)(82740400003)(7696005)(47076005)(356005)(8936002)(6916009)(83380400001)(36860700001)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2021 08:33:31.8471 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b818ed01-e61a-4c38-5015-08d95ca2b3b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4573
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

the following feature is wrong, it will cause sysnode of pp_features show error:
1. DPM_XGMI
2. VCN_DPM

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_types.h           |  1 -
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c    | 16 ++++++++--------
 .../gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c   |  4 ++--
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/pm/inc/smu_types.h
index 1d3765b873df..3fdee6cf01ed 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
@@ -297,7 +297,6 @@ enum smu_clk_type {
        __SMU_DUMMY_MAP(DS_FCLK),                       	\
        __SMU_DUMMY_MAP(DS_MP1CLK),                     	\
        __SMU_DUMMY_MAP(DS_MP0CLK),                     	\
-       __SMU_DUMMY_MAP(XGMI),                          	\
        __SMU_DUMMY_MAP(XGMI_PER_LINK_PWR_DWN),          \
        __SMU_DUMMY_MAP(DPM_GFX_PACE),                  	\
        __SMU_DUMMY_MAP(MEM_VDDCI_SCALING),             	\
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 6ec8492f71f5..b4d98465bb36 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -163,14 +163,14 @@ static const struct cmn2asic_mapping arcturus_feature_mask_map[SMU_FEATURE_COUNT
 	FEA_MAP(DPM_SOCCLK),
 	FEA_MAP(DPM_FCLK),
 	FEA_MAP(DPM_MP0CLK),
-	ARCTURUS_FEA_MAP(SMU_FEATURE_XGMI_BIT, FEATURE_DPM_XGMI_BIT),
+	FEA_MAP(DPM_XGMI),
 	FEA_MAP(DS_GFXCLK),
 	FEA_MAP(DS_SOCCLK),
 	FEA_MAP(DS_LCLK),
 	FEA_MAP(DS_FCLK),
 	FEA_MAP(DS_UCLK),
 	FEA_MAP(GFX_ULV),
-	ARCTURUS_FEA_MAP(SMU_FEATURE_VCN_PG_BIT, FEATURE_DPM_VCN_BIT),
+	ARCTURUS_FEA_MAP(SMU_FEATURE_VCN_DPM_BIT, FEATURE_DPM_VCN_BIT),
 	FEA_MAP(RSMU_SMN_CG),
 	FEA_MAP(WAFL_CG),
 	FEA_MAP(PPT),
@@ -721,13 +721,13 @@ static int arcturus_get_current_clk_freq_by_table(struct smu_context *smu,
 			member_type = METRICS_AVERAGE_SOCCLK;
 		break;
 	case PPCLK_VCLK:
-		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT))
+		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_DPM_BIT))
 			member_type = METRICS_CURR_VCLK;
 		else
 			member_type = METRICS_AVERAGE_VCLK;
 		break;
 	case PPCLK_DCLK:
-		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT))
+		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_DPM_BIT))
 			member_type = METRICS_CURR_DCLK;
 		else
 			member_type = METRICS_AVERAGE_DCLK;
@@ -1916,16 +1916,16 @@ static int arcturus_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
 	int ret = 0;
 
 	if (enable) {
-		if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
-			ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_VCN_PG_BIT, 1);
+		if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_DPM_BIT)) {
+			ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_VCN_DPM_BIT, 1);
 			if (ret) {
 				dev_err(smu->adev->dev, "[EnableVCNDPM] failed!\n");
 				return ret;
 			}
 		}
 	} else {
-		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
-			ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_VCN_PG_BIT, 0);
+		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_DPM_BIT)) {
+			ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_VCN_DPM_BIT, 0);
 			if (ret) {
 				dev_err(smu->adev->dev, "[DisableVCNDPM] failed!\n");
 				return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 856eeaf293b8..97cc6fb9b22b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -156,14 +156,14 @@ static const struct cmn2asic_mapping aldebaran_feature_mask_map[SMU_FEATURE_COUN
 	ALDEBARAN_FEA_MAP(SMU_FEATURE_DPM_SOCCLK_BIT, 			FEATURE_DPM_SOCCLK_BIT),
 	ALDEBARAN_FEA_MAP(SMU_FEATURE_DPM_FCLK_BIT, 			FEATURE_DPM_FCLK_BIT),
 	ALDEBARAN_FEA_MAP(SMU_FEATURE_DPM_LCLK_BIT, 			FEATURE_DPM_LCLK_BIT),
-	ALDEBARAN_FEA_MAP(SMU_FEATURE_XGMI_BIT, 				FEATURE_DPM_XGMI_BIT),
+	ALDEBARAN_FEA_MAP(SMU_FEATURE_DPM_XGMI_BIT, 				FEATURE_DPM_XGMI_BIT),
 	ALDEBARAN_FEA_MAP(SMU_FEATURE_DS_GFXCLK_BIT, 			FEATURE_DS_GFXCLK_BIT),
 	ALDEBARAN_FEA_MAP(SMU_FEATURE_DS_SOCCLK_BIT, 			FEATURE_DS_SOCCLK_BIT),
 	ALDEBARAN_FEA_MAP(SMU_FEATURE_DS_LCLK_BIT, 				FEATURE_DS_LCLK_BIT),
 	ALDEBARAN_FEA_MAP(SMU_FEATURE_DS_FCLK_BIT, 				FEATURE_DS_FCLK_BIT),
 	ALDEBARAN_FEA_MAP(SMU_FEATURE_DS_UCLK_BIT,				FEATURE_DS_UCLK_BIT),
 	ALDEBARAN_FEA_MAP(SMU_FEATURE_GFX_SS_BIT, 				FEATURE_GFX_SS_BIT),
-	ALDEBARAN_FEA_MAP(SMU_FEATURE_VCN_PG_BIT, 				FEATURE_DPM_VCN_BIT),
+	ALDEBARAN_FEA_MAP(SMU_FEATURE_VCN_DPM_BIT, 				FEATURE_DPM_VCN_BIT),
 	ALDEBARAN_FEA_MAP(SMU_FEATURE_RSMU_SMN_CG_BIT, 			FEATURE_RSMU_SMN_CG_BIT),
 	ALDEBARAN_FEA_MAP(SMU_FEATURE_WAFL_CG_BIT, 				FEATURE_WAFL_CG_BIT),
 	ALDEBARAN_FEA_MAP(SMU_FEATURE_PPT_BIT, 					FEATURE_PPT_BIT),
-- 
2.25.1

