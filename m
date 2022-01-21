Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D82C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jan 2022 07:45:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF6F910E941;
	Fri, 21 Jan 2022 07:45:26 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8599510E940
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jan 2022 07:45:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/s0Uy2XsX8Gr8pbka0uVaF7s0qSAwe6Jz7fp+Sx3I+5CuZ7KB7Wp0A5Pn6PfDLIIGTvkQCxMM3VUpO2prUTxIRxonN7i7srz1YdGBJiS8hApOF+Z7KfzCxS5GMUVYK4JPpljZGK2EHIYXyRY/WBNcI0BfbZ8CSLJS9I0D+Hv+de9maR6tBvHSnxArQujEfKjxhyBWh/DOni05icw1aOYt5o61LLAAJe5gn7GJxaA9DcIqMlrePW77ePWKN4DJSghp/S7gcemb61DCRoyc46AgF9GXB4cjJFxZDYqdBnpsmrL2lRRdl+eppzMPzOZjxqeGfYpX9ywmMxoIPcUO7uQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12KwaoVWxmQhi5xZqsIk3eplCn3tETFBII+nXdjeaqs=;
 b=lkAegyggTab1Vg/LQYIzG8ACEGxnor2dyLXZJnzjy7jFmGWXszwHBrU80lN367/O7IIwzKy7QgRXUxllFW4nsn48bVDaQOMz6Rd2XfDVs6pgB6c6CbiXPq40Xhc4a9uD6QYhxcz4OrUvzETbSoro1s69N38IKdo3bexKCoaPcEachtjaN/xArLlKwiD+NgzDremGNUI6MS++aWPLnAQTeSU4aFS84Ir2hh2EmahMNrg2hCz7SUlyJZCsJd/odwqmrAIEx31Spc8JuRzWdQPcVHGCb0oOFk+QYNwUwYaS5vYy8mvPqTV3EeUAA6/bmLArpf1nbhcSXOee0fg6b9aqSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12KwaoVWxmQhi5xZqsIk3eplCn3tETFBII+nXdjeaqs=;
 b=QnK2nz0oxU/gPk6WOYrgRLt16nmzwjZomHAju1kZGGcTCc4SjioXuBXSCnIYAMEdI1cboxbcG8aMQ3HL7wtyjPMHie4F5VLi8DGON3hbF/45eFmHs/G5MEouaD9KK32gMTNcx50ZTz334qBrqWEqivjsBBur4iS3/S6plvMMR8Q=
Received: from MW4PR03CA0088.namprd03.prod.outlook.com (2603:10b6:303:b6::33)
 by DM5PR12MB1132.namprd12.prod.outlook.com (2603:10b6:3:79::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Fri, 21 Jan
 2022 07:45:21 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::68) by MW4PR03CA0088.outlook.office365.com
 (2603:10b6:303:b6::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Fri, 21 Jan 2022 07:45:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Fri, 21 Jan 2022 07:45:20 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 21 Jan
 2022 01:45:17 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/7] drm/amd/pm: revise the implementation of
 smu_cmn_disable_all_features_with_exception
Date: Fri, 21 Jan 2022 15:44:43 +0800
Message-ID: <20220121074443.639392-7-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220121074443.639392-1-evan.quan@amd.com>
References: <20220121074443.639392-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc12f5ab-5ad9-4be2-c0e7-08d9dcb1f9a2
X-MS-TrafficTypeDiagnostic: DM5PR12MB1132:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1132AEA2951DE5FAF13C19EAE45B9@DM5PR12MB1132.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C3qe3ZzGGxjFGrHZnPeawQ/iXGpjUHBN9JK4cIfAXr0Li3tTzq3SszWTcSLHlaWWvUaQorAxivjzxjYJR0K5SJ7Ds7WTm7YYsXPAAcgyxcj7e15FJiLYDG5oKibGl4ToGtabpnX40aHXENL3MSAHgD4g9uqUvyNHi7OenNb1AKYyQPn/rBH13aP90XjXA7ixkKufHWoQHDev7IANEYX1nwEYxwb8U+fe2rtVfGE2mxZKWggcqwuBHkaQxXzBJ1FxTDySHGtWTG8DfeHXzSfA1gZXWukR31xqVI+PlI58TShyfQONNQ37ROmiss7lDIBoX/AsykB64wu9AGU/wuN1Gr2XKvqlo98O3U+wNFPSCFwZgGVS1Ia18WGAyifheEilv2xTvJ6Bd+gjNL+Il2xd9yWYgNXGdCJaRV6ireOXc306wzZ9broy+4135TNSCy2plJIifDES5GAtw21yVytU6jpaaaK8MXKDLPGZjlOtdhLFA0t8OP4Bmn7n1vQrxQ5tLclLPq/7i4rE3pfeyHX6HXItMTZFbUbMQHDYv+OCZX/4o0QNaheoai8D7V48RQsf78L49vk3We6oa0wCy8/ux/xD6Ab6d6ajMQIX3yI1Kg2Gkg3pmT+mYgoz76V0beGUhPXV1T1dDVjp/Bim8NcEE5RaW7/ZpYvWgXmlm9zA4HA+/yTkEy9TbVG5en97oHqsglz+94Q1iOrTTVaAnpvYYLc/0n8ycUKzm5Zp7NXa/ab2lKtZjH3uIThaj5ZF1nt96QRz7dIA204FF65hR4WtHxkYBb9VeQoWA/JeplxCNSE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(316002)(2906002)(1076003)(40460700001)(70206006)(508600001)(70586007)(7696005)(336012)(4326008)(426003)(8936002)(86362001)(47076005)(54906003)(6666004)(44832011)(81166007)(36860700001)(356005)(5660300002)(186003)(6916009)(83380400001)(2616005)(26005)(82310400004)(8676002)(36756003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 07:45:20.3432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc12f5ab-5ad9-4be2-c0e7-08d9dcb1f9a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1132
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com, ray.huang@amd.com,
 Evan Quan <evan.quan@amd.com>, Guchun.Chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As there is no internal cache for enabled ppfeatures now. Thus the 2nd
parameter will be not needed any more.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I0c1811f216c55d6ddfabdc9e099dc214c21bdf2e
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 9 ++-------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 1 -
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 7 -------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        | 1 -
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   | 2 +-
 5 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index aceb6e56bc6a..62c757c79f25 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1348,9 +1348,7 @@ static int smu_disable_dpms(struct smu_context *smu)
 		case IP_VERSION(11, 5, 0):
 		case IP_VERSION(11, 0, 12):
 		case IP_VERSION(11, 0, 13):
-			return smu_disable_all_features_with_exception(smu,
-								       true,
-								       SMU_FEATURE_COUNT);
+			return 0;
 		default:
 			break;
 		}
@@ -1366,9 +1364,7 @@ static int smu_disable_dpms(struct smu_context *smu)
 		case IP_VERSION(11, 0, 0):
 		case IP_VERSION(11, 0, 5):
 		case IP_VERSION(11, 0, 9):
-			return smu_disable_all_features_with_exception(smu,
-								       true,
-								       SMU_FEATURE_BACO_BIT);
+			return 0;
 		default:
 			break;
 		}
@@ -1380,7 +1376,6 @@ static int smu_disable_dpms(struct smu_context *smu)
 	 */
 	if (use_baco && smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT)) {
 		ret = smu_disable_all_features_with_exception(smu,
-							      false,
 							      SMU_FEATURE_BACO_BIT);
 		if (ret)
 			dev_err(adev->dev, "Failed to disable smu features except BACO.\n");
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 4ba579cdd203..76849c0d8df6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -989,7 +989,6 @@ struct pptable_funcs {
 	 *                                       exception to those in &mask.
 	 */
 	int (*disable_all_features_with_exception)(struct smu_context *smu,
-						   bool no_hw_disablement,
 						   enum smu_feature_mask mask);
 
 	/**
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index e54c59f3e8c2..90fd722cbaef 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -748,9 +748,6 @@ int smu_cmn_set_pp_feature_mask(struct smu_context *smu,
  *                                               @mask
  *
  * @smu:               smu_context pointer
- * @no_hw_disablement: whether real dpm disablement should be performed
- *                     true: update the cache(about dpm enablement state) only
- *                     false: real dpm disablement plus cache update
  * @mask:              the dpm feature which should not be disabled
  *                     SMU_FEATURE_COUNT: no exception, all dpm features
  *                     to disable
@@ -759,7 +756,6 @@ int smu_cmn_set_pp_feature_mask(struct smu_context *smu,
  * 0 on success or a negative error code on failure.
  */
 int smu_cmn_disable_all_features_with_exception(struct smu_context *smu,
-						bool no_hw_disablement,
 						enum smu_feature_mask mask)
 {
 	uint64_t features_to_disable = U64_MAX;
@@ -775,9 +771,6 @@ int smu_cmn_disable_all_features_with_exception(struct smu_context *smu,
 		features_to_disable &= ~(1ULL << skipped_feature_id);
 	}
 
-	if (no_hw_disablement)
-		return 0;
-
 	return smu_cmn_feature_update_enable_state(smu,
 						   features_to_disable,
 						   0);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index 98190ed5360f..c1423784ab96 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -76,7 +76,6 @@ int smu_cmn_set_pp_feature_mask(struct smu_context *smu,
 				uint64_t new_mask);
 
 int smu_cmn_disable_all_features_with_exception(struct smu_context *smu,
-						bool no_hw_disablement,
 						enum smu_feature_mask mask);
 
 int smu_cmn_get_smc_version(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
index 2f9aff89f667..be473478b45a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -57,7 +57,7 @@
 #define smu_feature_set_allowed_mask(smu)				smu_ppt_funcs(set_allowed_mask, 0, smu)
 #define smu_feature_get_enabled_mask(smu, mask)				smu_ppt_funcs(get_enabled_mask, 0, smu, mask)
 #define smu_feature_is_enabled(smu, mask)				smu_ppt_funcs(feature_is_enabled, 0, smu, mask)
-#define smu_disable_all_features_with_exception(smu, no_hw_disablement, mask)		smu_ppt_funcs(disable_all_features_with_exception, 0, smu, no_hw_disablement, mask)
+#define smu_disable_all_features_with_exception(smu, mask)		smu_ppt_funcs(disable_all_features_with_exception, 0, smu, mask)
 #define smu_is_dpm_running(smu)						smu_ppt_funcs(is_dpm_running, 0 , smu)
 #define smu_notify_display_change(smu)					smu_ppt_funcs(notify_display_change, 0, smu)
 #define smu_populate_umd_state_clk(smu)					smu_ppt_funcs(populate_umd_state_clk, 0, smu)
-- 
2.29.0

