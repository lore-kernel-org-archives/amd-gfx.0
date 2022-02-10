Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2B7C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 01:47:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8836510E6C5;
	Thu, 10 Feb 2022 01:47:33 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53C8F10E6C5
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 01:47:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmZAQgFLImoFM2z6zPoVf+T90/yMj6g0eJK5d60Cta0TVaiHgCCJIaYnbGsWdecYXlRseRv218eI2YlczuEjKD5eIOOaL42LMBp5TOB8UTLTPIytiWvgsGyeh7Ra8t4F4QxNoV/DNPndDY4n4KLLuLBlj7TLFfEkT4TgLXLHQ4m4z+VDnCqhNgKCMjn5nBSPvUVgscLSVz7fa2F5talEL1xDtSFWBTdSetrOzs0LDAs5JFzkIR9HkSJZMJ/sHxWpQreiD97K/1oJOLEKqNFhYGGC1D8nUu9M3nlt3y/kK/egDWoU9M13mP9yOrj9rX+53JAGYc+D6ckgx0uG+2dOQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLTma83D9KdejFhq3qzfCXSg+J3MvHX2z5SU0DK+/58=;
 b=mEih95wiFCbThZ6ffrbZ+yXtlTy76BjRxCaCzyY3mObzvZrIFIgzpyN7mDcE+qnZH/NdtZc+VZ8G70NBMz97+CrooQGTbgNJ1jROQw1qBJ5BmZCWrGuBz1AwpQQodfSIVcDgb2XeFdWr6gPzABiHaFAd97yxysp8bj27nsEK9jaUuUSgzPN3scl+pB10uqer0YptxeIKuunsb3hEMly9HbteSoyFa4qppu3cZs/PUVkCh0GvBmDphs6HBDWIbO838RWFUsNZj90XPef5JfOa5pMQIZWzIOyU/NhrL12byLPlusmJlXJCK7QUzioA2diccbWKBvEkANZm5NQ7kWsTPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLTma83D9KdejFhq3qzfCXSg+J3MvHX2z5SU0DK+/58=;
 b=sSoflkLhCDHvTMNdQxnlFHgXXXHWt3X/n87jGnoI7XFJyzOBoM4BsaOwI3ZfnkFuXDcXM0VS/oUuo5wtivNo9M6PN6VUAhmqOzQZBJeUeNW7Q0fBvpejPg3SM7AVr7rU8D05Zo81ThSqYZpo+t42U124Ce7EziobXP3FwfhZeWU=
Received: from MWHPR15CA0043.namprd15.prod.outlook.com (2603:10b6:300:ad::29)
 by BN6PR12MB1569.namprd12.prod.outlook.com (2603:10b6:405:6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 01:47:23 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::7a) by MWHPR15CA0043.outlook.office365.com
 (2603:10b6:300:ad::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19 via Frontend
 Transport; Thu, 10 Feb 2022 01:47:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Thu, 10 Feb 2022 01:47:22 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Feb
 2022 19:47:19 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: fix enabled features retrieving on Renoir and
 Cyan Skillfish
Date: Thu, 10 Feb 2022 09:47:00 +0800
Message-ID: <20220210014700.856667-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 437fad68-661a-49d4-8ef0-08d9ec374858
X-MS-TrafficTypeDiagnostic: BN6PR12MB1569:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB15698C462C2C8F528FD9BA69E42F9@BN6PR12MB1569.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MHD8PuSr1BRdOA+rpPRXRPulyq7tKieyo7plf2kgYt7iQoumUxOJQHCVCfPkWFA2Z7zyRpini+ybcs55yEc7cic7DGZWGOBIxsiDH0R1T/Li8a4dKi2pfp1IsPswbdD+aaGVc9jWxz9fD3+O/QxEM3I5xsgwVEhpp0hBBYn1+oUhFA4BZNbaq//vVmCt3zTFy2h5/6GF1aCNI7WbfHyhEJP+TmP1Pc9/244WvJmnbRyneRNfaszITgseEHBNe+0Dpdk9n/c5JLZLjeQdFDWMseMLo40H++ZX2qpHf4tQFTi2SMJfbtRBvwtxWfezI3dAnxJJaEptnibh765tmnZaPESPS0PHdWNPpBfghqHDbwu5rnbW77hb3iDyyngRz/KiC4fEY+lLRxPrEM3hr8R+TV/vusU19VFjW2MRwbIKG/aDF3UYlREA4XGjWcknV4pJqXD1MN6qlhiqh2DXP7TNlbcUmkDrFsLVGvrlvC4hHeakeONVO1eRMjK5rOYa5sVyxnteiIAFlUx78gyT4hsE97nvqEm5o6cPuYMi94fZpM9vw7/hNRR5NyajOGyxR8RErDRcK6MAOkdKtuOhYEp6wxFctJXnbD9iy80WYtZeP/mXixuQKYhryC7oa40RZJTKJROQL344le800etDmy5qHLT888cHQzkeq3SV4NqGKv7Xma7GYXecc3KI+EdH4zDJDhLNJWf6y9GyOZS1in49/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(8936002)(8676002)(7696005)(47076005)(4326008)(82310400004)(54906003)(2616005)(16526019)(2906002)(1076003)(6666004)(40460700003)(186003)(336012)(426003)(70586007)(36860700001)(36756003)(508600001)(81166007)(316002)(70206006)(44832011)(86362001)(356005)(6916009)(83380400001)(26005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 01:47:22.8880 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 437fad68-661a-49d4-8ef0-08d9ec374858
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1569
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
Cc: Alexander.Deucher@amd.com, nathan@kernel.org, Lijo.Lazar@amd.com,
 Roman.Li@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For Cyan Skillfish and Renoir, there is no interface provided by PMFW
to retrieve the enabled features. So, we assume all features are enabled.

Fixes: 7ade3ca9cdb5 ("drm/amd/pm: correct the usage for 'supported' member of smu_feature structure")

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I1231f146405a229a11aa7ac608c8c932d3c90ee4
--
v1->v2:
  - add back the logic for supporting those ASICs which have
    no feature_map available
v2->v3:
  - update the check for smu_cmn_feature_is_enabled to use a more
    generic way instead of asic type

Change-Id: I7dfa453ffc086f5364848f7f32decd57a5a5b0e6
---
 .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   |  1 +
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 27 ++++++++++++++-----
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |  2 +-
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
index 2b38a9154dd4..b3a0f3fb3e65 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
@@ -562,6 +562,7 @@ static const struct pptable_funcs cyan_skillfish_ppt_funcs = {
 	.fini_smc_tables = smu_v11_0_fini_smc_tables,
 	.read_sensor = cyan_skillfish_read_sensor,
 	.print_clk_levels = cyan_skillfish_print_clk_levels,
+	.get_enabled_mask = smu_cmn_get_enabled_mask,
 	.is_dpm_running = cyan_skillfish_is_dpm_running,
 	.get_gpu_metrics = cyan_skillfish_get_gpu_metrics,
 	.od_edit_dpm_table = cyan_skillfish_od_edit_dpm_table,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 2a6b752a6996..4c12abcd995d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -500,7 +500,17 @@ int smu_cmn_feature_is_enabled(struct smu_context *smu,
 	uint64_t enabled_features;
 	int feature_id;
 
-	if (smu->is_apu && adev->family < AMDGPU_FAMILY_VGH)
+	if (smu_cmn_get_enabled_mask(smu, &enabled_features)) {
+		dev_err(adev->dev, "Failed to retrieve enabled ppfeatures!\n");
+		return 0;
+	}
+
+	/*
+	 * For Renoir and Cyan Skillfish, they are assumed to have all features
+	 * enabled. Also considering they have no feature_map available, the
+	 * check here can avoid unwanted feature_map check below.
+	 */
+	if (enabled_features == ULLONG_MAX)
 		return 1;
 
 	feature_id = smu_cmn_to_asic_specific_index(smu,
@@ -509,11 +519,6 @@ int smu_cmn_feature_is_enabled(struct smu_context *smu,
 	if (feature_id < 0)
 		return 0;
 
-	if (smu_cmn_get_enabled_mask(smu, &enabled_features)) {
-		dev_err(adev->dev, "Failed to retrieve enabled ppfeatures!\n");
-		return 0;
-	}
-
 	return test_bit(feature_id, (unsigned long *)&enabled_features);
 }
 
@@ -559,7 +564,7 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,
 	feature_mask_high = &((uint32_t *)feature_mask)[1];
 
 	switch (adev->ip_versions[MP1_HWIP][0]) {
-	case IP_VERSION(11, 0, 8):
+	/* For Vangogh and Yellow Carp */
 	case IP_VERSION(11, 5, 0):
 	case IP_VERSION(13, 0, 1):
 	case IP_VERSION(13, 0, 3):
@@ -575,8 +580,16 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,
 						      1,
 						      feature_mask_high);
 		break;
+	/*
+	 * For Cyan Skillfish and Renoir, there is no interface provided by PMFW
+	 * to retrieve the enabled features. So, we assume all features are enabled.
+	 * TODO: add other APU ASICs which suffer from the same issue here
+	 */
+	case IP_VERSION(11, 0, 8):
 	case IP_VERSION(12, 0, 0):
 	case IP_VERSION(12, 0, 1):
+		memset(feature_mask, 0xff, sizeof(*feature_mask));
+		break;
 	/* other dGPU ASICs */
 	default:
 		ret = smu_cmn_send_smc_msg(smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
index 530be44e00ec..15bcf72b8e56 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -55,7 +55,7 @@
 #define smu_send_smc_msg(smu, msg, read_arg)				smu_ppt_funcs(send_smc_msg, 0, smu, msg, read_arg)
 #define smu_init_display_count(smu, count)				smu_ppt_funcs(init_display_count, 0, smu, count)
 #define smu_feature_set_allowed_mask(smu)				smu_ppt_funcs(set_allowed_mask, 0, smu)
-#define smu_feature_get_enabled_mask(smu, mask)				smu_ppt_funcs(get_enabled_mask, 0, smu, mask)
+#define smu_feature_get_enabled_mask(smu, mask)				smu_ppt_funcs(get_enabled_mask, -EOPNOTSUPP, smu, mask)
 #define smu_feature_is_enabled(smu, mask)				smu_ppt_funcs(feature_is_enabled, 0, smu, mask)
 #define smu_disable_all_features_with_exception(smu, mask)		smu_ppt_funcs(disable_all_features_with_exception, 0, smu, mask)
 #define smu_is_dpm_running(smu)						smu_ppt_funcs(is_dpm_running, 0 , smu)
-- 
2.29.0

