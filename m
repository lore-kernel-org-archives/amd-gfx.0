Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC56CC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:44:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C0346101E
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:44:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8C0346101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EAEF6E8CC;
	Tue, 28 Sep 2021 16:44:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D071E6E8CC
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:44:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLKqezcTN+dYxnpZ+sioJLCvD3eweYfgvmsbguLfynIQBjMN9ocE8vRl/r+YQjT6e1T/h3ckfW1Yo0durjIoC+ZjDs7CHcFDyyI2C1+fN7lbgoBPPzj29/MCvmu7AdarcTmGqtdCzKDbWiKyyeYoQuu2Kvj4vOvVYn96inOsLLG97MTAKMGTtUd3F9tV0BVKsml3/3BdENPhyMqruLZbeWhw9ms0LY6WIQsvW3qb+tlS5mBr+8E/tAqCzisSn1CgxG76VLGBC6mc8EV5tD8Vr4o/xCaUb4d75D1z9gOCLyyPaSdfpL0/ogUrc9sQEbGPoelCFYQGZ9ApkjZiTf/PKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=elPFyz8Ssnzqgr6GZkRKDhElxFoyddOCdBiYx/9rwVo=;
 b=i+Qk0e6QFK/68iblGyaSJ9jvnKML96+LN1VgLMfP9S0pFXEOvhF382fXfCYD/EEhLC828HxhYR1eBc+mOwFX2V5Jz1fsYuhp+pd/IKLQnLDAM79MD2nwtf88z6QfgWquKJ0sjJWlcDo4D98c3eBgnTfyQ0uaSWP3SbDHxMqDFk0bUiWgqMLXQpM2TS7juTQM9eU993mVln/yBKnplUOWvz/ty0Oy3HGcq/a+FO3lAYtphY7QAv+mFrgtCigRUG39Muk+y1+6RMMOQfUCqPuu3TAwl5faRForlQjB+s54GEYaZiP4GSM6c18p5xtJkcnjLv7qJyGIa6jlyRCwGJz9Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elPFyz8Ssnzqgr6GZkRKDhElxFoyddOCdBiYx/9rwVo=;
 b=IiAqrCgUFn6PXCzScYIiry0hUskqES/E6ZXnQSdXX0klGIJEGahtTgcXQKo3xVTmCIo/5jkF0yNo8Xz8q7p6WCvADJVBC7Ytv8e3DtsVR5ITOAfWpLYIYas7YFVd9vJajZB6yT2gtIE5qGQUwYdzXl89r/3L3VL9xvhX1c3Vmzo=
Received: from DM6PR07CA0039.namprd07.prod.outlook.com (2603:10b6:5:74::16) by
 BY5PR12MB5512.namprd12.prod.outlook.com (2603:10b6:a03:1df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Tue, 28 Sep
 2021 16:44:31 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::80) by DM6PR07CA0039.outlook.office365.com
 (2603:10b6:5:74::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Tue, 28 Sep 2021 16:44:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:44:31 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:44:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 25/64] drm/amdgpu/navi10_ppt: convert to IP version checking
Date: Tue, 28 Sep 2021 12:41:58 -0400
Message-ID: <20210928164237.833132-26-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928164237.833132-1-alexander.deucher@amd.com>
References: <20210928164237.833132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b543c737-2376-45c8-68a5-08d9829f3ed2
X-MS-TrafficTypeDiagnostic: BY5PR12MB5512:
X-Microsoft-Antispam-PRVS: <BY5PR12MB551239242958B2675FF48F15F7A89@BY5PR12MB5512.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QzDLrp3yTzodvnKzNxD6E7/zSIr4804Jp3JjqMow8JjLRzx1/JMBm4x5hO36+64eWHrejqR3LAKr7h7vC7XEMTlbeQ1da7txBXh/kcunNojsCDWf3E5hpOiaSgXnruBtrtdau11lytit2bCjktVHNP7sUXIbZlUjrdMeMdwq7xIbfQz+duxZlRrJxmigNhQ8bcdgEpEKSrjWrJU0ypYVP375jDhXweLc0IY7oaT3JiitYpPXjfoN4jUrvutdsn0Tk9mxh3X7nvFbKJT0W6my2JpG1H4ixgE0JFSLUlSU9n/WdhgOWqb8u5p07vIeMOvuWoGbvGAZureofCy0ijOtaYW9Zd6JCn3fsX8wpT5K5KHa577qyl6mNZ64DYTDCGn3rSvPoeh7FzRD7hFudqnRZc4ZLGCURiJGjT/HPLFhQga2oqqBqBoX9s/hfn9ThO+vDMcGG/o7OPWcATY2oM2LcHpWTo7t2UXrUjV2efET0Hx/go7zfRTr4ymLz4lZMXKtggfqJg8b3p4+/gV+p8gTNwvFSb2Z60HmSCMZcHEenoK5L4sidqkDKByl/QeD0qh2cWKjNnHPq9He7eL+OKhKWJVyv57KyaKCRUoOXWq4Bdc3eQ5WoMsPAIq2vfaO++CbDcX5JPD19aDxmNsVFQrE+opCSvi6DAxC7b5jMnmEArWn4tni8motIdnInV4HrUMvDN2IQvGMSnrdrrrO7/98hFf2UM1pj5Q6DyLbQECZMas=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(54906003)(4326008)(26005)(5660300002)(36860700001)(16526019)(86362001)(2616005)(316002)(8936002)(8676002)(186003)(6666004)(7696005)(508600001)(2906002)(426003)(336012)(356005)(70206006)(1076003)(6916009)(36756003)(83380400001)(47076005)(81166007)(82310400003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:44:31.4273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b543c737-2376-45c8-68a5-08d9829f3ed2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5512
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

Use IP versions rather than asic_type to differentiate
IP version specific features.

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 50 +++++++++----------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index ae11f5ed7a97..d96f904a765b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -345,7 +345,7 @@ navi10_get_allowed_feature_mask(struct smu_context *smu,
 
 	/* DPM UCLK enablement should be skipped for navi10 A0 secure board */
 	if (!(is_asic_secure(smu) &&
-	     (adev->asic_type == CHIP_NAVI10) &&
+	     (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 0)) &&
 	     (adev->rev_id == 0)) &&
 	    (adev->pm.pp_feature & PP_MCLK_DPM_MASK))
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_UCLK_BIT)
@@ -354,7 +354,7 @@ navi10_get_allowed_feature_mask(struct smu_context *smu,
 
 	/* DS SOCCLK enablement should be skipped for navi10 A0 secure board */
 	if (is_asic_secure(smu) &&
-	    (adev->asic_type == CHIP_NAVI10) &&
+	    (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 0)) &&
 	    (adev->rev_id == 0))
 		*(uint64_t *)feature_mask &=
 				~FEATURE_MASK(FEATURE_DS_SOCCLK_BIT);
@@ -925,18 +925,18 @@ static int navi1x_get_smu_metrics_data(struct smu_context *smu,
 		return ret;
 	}
 
-	switch (adev->asic_type) {
-	case CHIP_NAVI12:
+	switch (adev->ip_versions[MP1_HWIP]) {
+	case IP_VERSION(11, 0, 9):
 		if (smu_version > 0x00341C00)
 			ret = navi12_get_smu_metrics_data(smu, member, value);
 		else
 			ret = navi12_get_legacy_smu_metrics_data(smu, member, value);
 		break;
-	case CHIP_NAVI10:
-	case CHIP_NAVI14:
+	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 5):
 	default:
-		if (((adev->asic_type == CHIP_NAVI14) && smu_version > 0x00351F00) ||
-		      ((adev->asic_type == CHIP_NAVI10) && smu_version > 0x002A3B00))
+		if (((adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 5)) && smu_version > 0x00351F00) ||
+		      ((adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 0)) && smu_version > 0x002A3B00))
 			ret = navi10_get_smu_metrics_data(smu, member, value);
 		else
 			ret = navi10_get_legacy_smu_metrics_data(smu, member, value);
@@ -1509,8 +1509,8 @@ static int navi10_populate_umd_state_clk(struct smu_context *smu)
 	uint32_t sclk_freq;
 
 	pstate_table->gfxclk_pstate.min = gfx_table->min;
-	switch (adev->asic_type) {
-	case CHIP_NAVI10:
+	switch (adev->ip_versions[MP1_HWIP]) {
+	case IP_VERSION(11, 0, 0):
 		switch (adev->pdev->revision) {
 		case 0xf0: /* XTX */
 		case 0xc0:
@@ -1525,7 +1525,7 @@ static int navi10_populate_umd_state_clk(struct smu_context *smu)
 			break;
 		}
 		break;
-	case CHIP_NAVI14:
+	case IP_VERSION(11, 0, 5):
 		switch (adev->pdev->revision) {
 		case 0xc7: /* XT */
 		case 0xf4:
@@ -1548,7 +1548,7 @@ static int navi10_populate_umd_state_clk(struct smu_context *smu)
 			break;
 		}
 		break;
-	case CHIP_NAVI12:
+	case IP_VERSION(11, 0, 9):
 		sclk_freq = NAVI12_UMD_PSTATE_PEAK_GFXCLK;
 		break;
 	default:
@@ -2562,8 +2562,8 @@ static bool navi10_need_umc_cdr_workaround(struct smu_context *smu)
 	if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT))
 		return false;
 
-	if (adev->asic_type == CHIP_NAVI10 ||
-	    adev->asic_type == CHIP_NAVI14)
+	if (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 0) ||
+	    adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 5))
 		return true;
 
 	return false;
@@ -2671,8 +2671,8 @@ static int navi10_run_umc_cdr_workaround(struct smu_context *smu)
 	 * - PPSMC_MSG_SetDriverDummyTableDramAddrLow
 	 * - PPSMC_MSG_GetUMCFWWA
 	 */
-	if (((adev->asic_type == CHIP_NAVI10) && (pmfw_version >= 0x2a3500)) ||
-	    ((adev->asic_type == CHIP_NAVI14) && (pmfw_version >= 0x351D00))) {
+	if (((adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 0)) && (pmfw_version >= 0x2a3500)) ||
+	    ((adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 5)) && (pmfw_version >= 0x351D00))) {
 		ret = smu_cmn_send_smc_msg_with_param(smu,
 						      SMU_MSG_GET_UMC_FW_WA,
 						      0,
@@ -2691,13 +2691,13 @@ static int navi10_run_umc_cdr_workaround(struct smu_context *smu)
 			return 0;
 
 		if (umc_fw_disable_cdr) {
-			if (adev->asic_type == CHIP_NAVI10)
+			if (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 0))
 				return navi10_umc_hybrid_cdr_workaround(smu);
 		} else {
 			return navi10_set_dummy_pstates_table_location(smu);
 		}
 	} else {
-		if (adev->asic_type == CHIP_NAVI10)
+		if (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 0))
 			return navi10_umc_hybrid_cdr_workaround(smu);
 	}
 
@@ -3151,18 +3151,18 @@ static ssize_t navi1x_get_gpu_metrics(struct smu_context *smu,
 		return ret;
 	}
 
-	switch (adev->asic_type) {
-	case CHIP_NAVI12:
+	switch (adev->ip_versions[MP1_HWIP]) {
+	case IP_VERSION(11, 0, 9):
 		if (smu_version > 0x00341C00)
 			ret = navi12_get_gpu_metrics(smu, table);
 		else
 			ret = navi12_get_legacy_gpu_metrics(smu, table);
 		break;
-	case CHIP_NAVI10:
-	case CHIP_NAVI14:
+	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 5):
 	default:
-		if (((adev->asic_type == CHIP_NAVI14) && smu_version > 0x00351F00) ||
-		      ((adev->asic_type == CHIP_NAVI10) && smu_version > 0x002A3B00))
+		if (((adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 5)) && smu_version > 0x00351F00) ||
+		      ((adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 0)) && smu_version > 0x002A3B00))
 			ret = navi10_get_gpu_metrics(smu, table);
 		else
 			ret =navi10_get_legacy_gpu_metrics(smu, table);
@@ -3180,7 +3180,7 @@ static int navi10_enable_mgpu_fan_boost(struct smu_context *smu)
 	uint32_t param = 0;
 
 	/* Navi12 does not support this */
-	if (adev->asic_type == CHIP_NAVI12)
+	if (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 9))
 		return 0;
 
 	/*
-- 
2.31.1

