Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FA0C07E94
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 09:59:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F17461418
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 09:59:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F17461418
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 241466F5F6;
	Fri,  4 Jun 2021 09:59:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D88E96F5F6
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 09:59:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPghblyHV0vZfA3+sn9c6TLHnJKdrE2FG7zBampmQSlGjvapsCqv7Zo3aSVPV+EQ+ehH9w7cKZKTRsnrOUK6ceOXIWatPCfbBhf883v/ApfLS6etxQzjj2IaeujWbluA/qlHcOVAAXXaCYuzKeWR/1BhN9sNof0SB8i2rCEH7C1+BBlR7VWJ8AKA68QbW1ldbxvnrc/st+Pa/qqdocSMnQ98YKQy/T79uU8dpVtOETeLqyL39xdYlP81orvx0/j/VVQQAzy8xj7ElYDBgR02i/2mOwjK9lgDoM/7vMu54xzrMlSC54uAZkO4obtBiZ7BreuGTKBvopAul8/agGMmNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1PNuxSNdfMqcKlgd+K41GKm0TJd/5MplpCewXG4wzU=;
 b=hgLoR7jdm3Y/YNpWIRNOuXq7N2Y7FlrPQBKN1iLXfd7MI3WlbCPJ9GOylW4T7EepPcaYny53rTTKTRX9mRoeJJrHnPcPanuPkyiGGExCXVqV3kVDSTlrDLLbZ2jTkX8EFZyP23ZSqvNa6wdz1npf8tky+qIpRM8LrxQaLobF+jSKbT5WkiZZ4g4yPWbMg8cKQQj+Eebb5YXikm7u6ldW59ZiixNaAxVGRGg9d19g2NRJ6wJv31o8okwV4I7+xvsBCn222HicpC/duufa10jQUkXWzj9ZyTIPDricXi10G/ZR2FWa1Z7IJrcgf6HC9u7VngZgFpuyWBoGgxN3sc2zog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1PNuxSNdfMqcKlgd+K41GKm0TJd/5MplpCewXG4wzU=;
 b=tJDtajixb5q1MzDcudppqnowCwolQi6ap6kdJprWn51OT0zJeckgSAPfRzztvUaS5i54Wb+Z2vQtWRzH4dryTbpEl10B7+4Htm/0Wf/8QIZcInf9ZstRTreLl/9XT0p2UsqNe9oOuzDdqNJWmdYnUE0SQBA8Po5ATk1V3J+Yrr0=
Received: from BN0PR04CA0110.namprd04.prod.outlook.com (2603:10b6:408:ec::25)
 by DM5PR12MB1867.namprd12.prod.outlook.com (2603:10b6:3:10d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Fri, 4 Jun
 2021 09:59:24 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::ae) by BN0PR04CA0110.outlook.office365.com
 (2603:10b6:408:ec::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend
 Transport; Fri, 4 Jun 2021 09:59:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Fri, 4 Jun 2021 09:59:23 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 4 Jun 2021
 04:59:21 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 4/5] drm/amd/pm: clear the cached dpm feature status
Date: Fri, 4 Jun 2021 17:58:22 +0800
Message-ID: <20210604095823.1403271-4-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210604095823.1403271-1-evan.quan@amd.com>
References: <20210604095823.1403271-1-evan.quan@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7bc92c1-f052-4d1e-1390-08d9273f6e4a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1867:
X-Microsoft-Antispam-PRVS: <DM5PR12MB186719A21AE33B54EE640F09E43B9@DM5PR12MB1867.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qA/MQfaxONJwcbeCyEgZiEsB3Bkpo7cB73ru8z7PYdVORYdYwxnNeL/pgNT/7tJPAMgZ1es1wLzeuc2oCuERH2jUaqNLOTpXqqjIOuQl3r9zbxfFYJjWGavoISOS0Nulmkj1eTqv36rhulicJHFIPKnlpJAb4vQYCl+AvEcLR4OOh2I3iSA1w8YEwa2lPxbfOezSGyDE2ScWoonGiDmZmHgJR3w//ytjvU+JAzEqXo0UGUmmGF5k/ahrGQIbE8CYRkKOoBy+fqWsTvRWZyYgyUze/u2jPeDrNCXbVEDOd7TKYJnN01R/hK1I7cx/pL48f3uT+oIuWegkHZVANg5RHHX8SHkrN+DyUvEkn3UL6VifzDjPnnKBtDhQdv6e5g6IVIZi88NesWTtadOy+MN9FOf69w8zZzHF6zB2dg0jqv8q5fNnPgNGxbi0paXoZNFB9cmd3iWQqserCJ1jpRhtIAnrLQL7Hh4V0p9sb+iTS/IR969CWGumaUej5J7AwvDI/gNIMz5J17bV+RNETbCIvpBSWUajkvf9fifUwbDOGSVPnJtp/3mNBzx4MCmZ5sIwqf2GU7X16PKEAYTLB5zIZbKZjQWIhU9i0mBHz/2t1D9GGTtsINot+4nxv87NidacOGe3jscS/Nnbwxw0NdJfFr6799NSO348wDs4EbrkWDXCJvlBiNfwSWSRAdNsLiAk
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39850400004)(396003)(346002)(46966006)(36840700001)(2906002)(1076003)(5660300002)(82740400003)(54906003)(82310400003)(8936002)(81166007)(316002)(47076005)(26005)(336012)(356005)(36860700001)(426003)(4326008)(186003)(7696005)(16526019)(2616005)(70206006)(44832011)(70586007)(83380400001)(86362001)(6916009)(8676002)(478600001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 09:59:23.5987 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7bc92c1-f052-4d1e-1390-08d9273f6e4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1867
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For some ASICs, the real dpm feature disablement job is handled by
PMFW during baco reset and custom pptable loading. Cached dpm feature
status need to be cleared to pair that.

Change-Id: I9e37d80e13599833301c04711b097fb37c2e41f9
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
V1->V2:
  - correct the setting for baco bit(pointed out by Lijo)
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  6 +++++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 19 ++++++++++++--
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  1 +
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  1 +
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 25 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  3 +++
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |  1 +
 7 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index fb7438224872..3f9b2a839a37 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -937,6 +937,12 @@ struct pptable_funcs {
 	 */
 	int (*disable_all_features_with_exception)(struct smu_context *smu, enum smu_feature_mask mask);
 
+	/**
+	 * @clear_cached_dpm_feature_status_with_exception: Clear cached dpm feature status with
+	 *                                                  exception to those in &mask.
+	 */
+	int (*clear_cached_dpm_feature_status_with_exception)(struct smu_context *smu, enum smu_feature_mask mask);
+
 	/**
 	 * @notify_display_change: Enable fast memory clock switching.
 	 *
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index c9a31556e077..aba475d06507 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1352,6 +1352,16 @@ static int smu_hw_init(void *handle)
 	return 0;
 }
 
+static void smu_reset_cached_dpm_feature_status(struct smu_context *smu)
+{
+	struct smu_feature *feature = &smu->smu_feature;
+
+	mutex_lock(&feature->mutex);
+	bitmap_zero(feature->enabled, feature->feature_num);
+	bitmap_zero(feature->supported, feature->feature_num);
+	mutex_unlock(&feature->mutex);
+}
+
 static int smu_disable_dpms(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -1374,16 +1384,21 @@ static int smu_disable_dpms(struct smu_context *smu)
 	 */
 	if (smu->uploading_custom_pp_table &&
 	    (adev->asic_type >= CHIP_NAVI10) &&
-	    (adev->asic_type <= CHIP_DIMGREY_CAVEFISH))
+	    (adev->asic_type <= CHIP_DIMGREY_CAVEFISH)) {
+		smu_reset_cached_dpm_feature_status(smu);
 		return 0;
+	}
 
 	/*
 	 * For Sienna_Cichlid, PMFW will handle the features disablement properly
 	 * on BACO in. Driver involvement is unnecessary.
 	 */
 	if ((adev->asic_type == CHIP_SIENNA_CICHLID) &&
-	     use_baco)
+	     use_baco) {
+		smu_clear_cached_dpm_feature_status_with_exception(smu,
+								   SMU_FEATURE_BACO_BIT);
 		return 0;
+	}
 
 	/*
 	 * For gpu reset, runpm and hibernation through BACO,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index afd4bd850c63..8c3ea20fb0f6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -3083,6 +3083,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.get_enabled_mask = smu_cmn_get_enabled_mask,
 	.feature_is_enabled = smu_cmn_feature_is_enabled,
 	.disable_all_features_with_exception = smu_cmn_disable_all_features_with_exception,
+	.clear_cached_dpm_feature_status_with_exception = smu_cmn_clear_cached_dpm_feature_status_with_exception,
 	.notify_display_change = smu_v11_0_notify_display_change,
 	.set_power_limit = smu_v11_0_set_power_limit,
 	.init_max_sustainable_clocks = smu_v11_0_init_max_sustainable_clocks,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index b4a2bb0f3f4c..14a14c30ee5e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3886,6 +3886,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.get_enabled_mask = smu_cmn_get_enabled_mask,
 	.feature_is_enabled = smu_cmn_feature_is_enabled,
 	.disable_all_features_with_exception = smu_cmn_disable_all_features_with_exception,
+	.clear_cached_dpm_feature_status_with_exception = smu_cmn_clear_cached_dpm_feature_status_with_exception,
 	.notify_display_change = NULL,
 	.set_power_limit = smu_v11_0_set_power_limit,
 	.init_max_sustainable_clocks = smu_v11_0_init_max_sustainable_clocks,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 0ceb7329838c..b9c38abc9d37 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -594,6 +594,31 @@ int smu_cmn_disable_all_features_with_exception(struct smu_context *smu,
 						   0);
 }
 
+int smu_cmn_clear_cached_dpm_feature_status_with_exception(struct smu_context *smu,
+							   enum smu_feature_mask mask)
+{
+	struct smu_feature *feature = &smu->smu_feature;
+	uint64_t features_to_disable = U64_MAX;
+	int skipped_feature_id;
+
+	skipped_feature_id = smu_cmn_to_asic_specific_index(smu,
+							    CMN2ASIC_MAPPING_FEATURE,
+							    mask);
+	if (skipped_feature_id < 0)
+		return -EINVAL;
+
+	features_to_disable &= ~(1ULL << skipped_feature_id);
+
+	mutex_lock(&feature->mutex);
+	bitmap_andnot(feature->enabled, feature->enabled,
+			(unsigned long *)(&features_to_disable), SMU_FEATURE_MAX);
+	bitmap_andnot(feature->supported, feature->supported,
+			(unsigned long *)(&features_to_disable), SMU_FEATURE_MAX);
+	mutex_unlock(&feature->mutex);
+
+	return 0;
+}
+
 int smu_cmn_get_smc_version(struct smu_context *smu,
 			    uint32_t *if_version,
 			    uint32_t *smu_version)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index da6ff6f024f9..12ad07132d15 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -77,6 +77,9 @@ int smu_cmn_set_pp_feature_mask(struct smu_context *smu,
 int smu_cmn_disable_all_features_with_exception(struct smu_context *smu,
 						enum smu_feature_mask mask);
 
+int smu_cmn_clear_cached_dpm_feature_status_with_exception(struct smu_context *smu,
+							   enum smu_feature_mask mask);
+
 int smu_cmn_get_smc_version(struct smu_context *smu,
 			    uint32_t *if_version,
 			    uint32_t *smu_version);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
index 33101dc93bcc..b12dcfab55fe 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -58,6 +58,7 @@
 #define smu_feature_get_enabled_mask(smu, mask, num)			smu_ppt_funcs(get_enabled_mask, 0, smu, mask, num)
 #define smu_feature_is_enabled(smu, mask)				smu_ppt_funcs(feature_is_enabled, 0, smu, mask)
 #define smu_disable_all_features_with_exception(smu, mask)		smu_ppt_funcs(disable_all_features_with_exception, 0, smu, mask)
+#define smu_clear_cached_dpm_feature_status_with_exception(smu, mask)	smu_ppt_funcs(clear_cached_dpm_feature_status_with_exception, 0, smu, mask)
 #define smu_is_dpm_running(smu)						smu_ppt_funcs(is_dpm_running, 0 , smu)
 #define smu_notify_display_change(smu)					smu_ppt_funcs(notify_display_change, 0, smu)
 #define smu_populate_umd_state_clk(smu)					smu_ppt_funcs(populate_umd_state_clk, 0, smu)
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
