Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD19C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 07:05:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A66310FA8E;
	Fri, 28 Jan 2022 07:05:45 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04C7C10FA88
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 07:05:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOy3REIURja6F/mYDiZQ44RPB6zCG4iPCRItcbnFv1CvvshDT1S2v1Wl90VKwUsyBMcukx2BsnAuoWo4jvjamGs7F9ZtOKzNaJxrwnHUhNGJ1O1wCIeLxRxVqfZDkK3uPuEqLcatpf/NLVEgODuBsRDNsZgADGlKIhDFJaLJRQwsuKjTXhPtynhqWpLxapOBeprFjzefJrRZmmBZatkjw9u/vLTtpos1ZUH66/o06k6vj2qS/YH4pMR4SxEPtPXMrDJN7PNPr5uDfT2GtYYlY2rcZ9xi3CxxOYGBwvWycpgcC0nI57VzMOW6OHKb3L8xlByK2nljeE6QPbftFf5CoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htt235OjLS0wf9++KUSI2FGO1NfWOd5FDvKj9EocB10=;
 b=Hpcgcr+TspeXeWAEg2/nRkHrrsxifFfDhO/7XonJI7i9o2qEdXhJ53BzRI8Hp1yV41J+FcNtjokbblsDqZOAbglLrh8ydpcRoL6dtbnNDsFdI06Zso+oWB37hQBLVKJxoZNBr9KwITzptiSRPQ6WpQ1Y44rmU/R/XqqF/bjwlpH/Je1PYglFA7piwJJJ94sTfAPhMSKmLnsQ7XOeICY/WPlYO4MCPUZz2MCsIp+dvvNjeiJufi58I7Dbt3Ml6EmsejNl7TFqt5QOYlJtdSQCUZLhkO0eKDjeoboN9ator2fznYhpksL4gvX0OcZzsWuTX6B/d1U5D5sy66ZBfAoF9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htt235OjLS0wf9++KUSI2FGO1NfWOd5FDvKj9EocB10=;
 b=Dw04PLm8dYnG18JfOnyGIT7Pf9QYesppqKncJlRvEqTEUPNBsJnIydlqqjAy1JscMFsGeOYfo1iEa9EX3KeVnMIDHnjbjNynWac/HhLm/zjcsvjpH68NPTOMi+1ZBaDv2Jarnfe+6OgPvdeoCboKEDFbSmann/7ng3qNsde0KV8=
Received: from MW4PR03CA0199.namprd03.prod.outlook.com (2603:10b6:303:b8::24)
 by DM6PR12MB2649.namprd12.prod.outlook.com (2603:10b6:5:49::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 07:05:40 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::a0) by MW4PR03CA0199.outlook.office365.com
 (2603:10b6:303:b8::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Fri, 28 Jan 2022 07:05:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 07:05:39 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 01:05:37 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 7/7] drm/amd/pm: revise the implementation of
 smu_cmn_disable_all_features_with_exception
Date: Fri, 28 Jan 2022 15:04:55 +0800
Message-ID: <20220128070455.202014-7-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220128070455.202014-1-evan.quan@amd.com>
References: <20220128070455.202014-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbe24411-6b7d-4ca9-4445-08d9e22c97a3
X-MS-TrafficTypeDiagnostic: DM6PR12MB2649:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB264962DC07E20ED242EB921AE4229@DM6PR12MB2649.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iZvkzxH7gkzF5uVm2NsinnfhlnVaadPlV+RVCK/Pp9VLZpsO4xpVIoqMTDGTooZHc86SPdxZ+KmuyRgFPGH9DMmXGgM9YgwiQhG/RsXMnVwI/2E0wAR5BdSRGHenlAxxlsEa2lp0rEX5vmsqxSZbNJU+kMF/jrcAS6IxZ12anACCQmXRtTlVBTiJuinnTjVCAIw7MDsq5+UO8g+qRnC5EZBoFG65491DxWOoenfSqSocTlT2hV6qiKCl6yvEbTVwKyyIYcAk/PaKG8W4lIR6kWcNA1HQWzq4NSbyS8LAOjbwxkFRHmU+gZGcd1ZyJBQe58IqcUuW7k89al8y5TvA66mZejnf6fncOXlUuHaT1rYHUITp54y73dkodwEAYz8/YZ7Pajd6dRXIlTJTQ7BpskJ5XL+CaKWEVt/AB0dsQfcrh56qN3/a/g3M6yQn735u+9R/8CIhPafQnhZD9MI7A5OZ1JjUyK5DyzATdPJZlmvhAUqJXo93SSuHmvWdEmVKEo69U5f9UKZUEbnn+tCm12D+9GvcCfMxXV6NyrJOjX4m24hFC6W/bWW3LLxB9fJ2RGTKKN9ZZ2MWIPawM4057rxbFvBRd7zq9VpDAdmPyRkcl2p1hbJSWzmqZFaUyjyLYrNFWBSowAkaWxF/strWIcXW/kSi+xx/EMNolWjIfr3vyGxn8kxyVEYuoxCRmUvGj552uGOAKWfiIW7mt/G2LA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(7696005)(356005)(81166007)(6666004)(86362001)(44832011)(82310400004)(70206006)(8936002)(2906002)(5660300002)(8676002)(4326008)(47076005)(2616005)(336012)(1076003)(26005)(6916009)(16526019)(508600001)(83380400001)(36756003)(426003)(54906003)(70586007)(40460700003)(186003)(316002)(36860700001)(36900700001)(20210929001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 07:05:39.8415 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe24411-6b7d-4ca9-4445-08d9e22c97a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2649
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
index 59be1c822b2c..1c9c11a92d42 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1360,9 +1360,7 @@ static int smu_disable_dpms(struct smu_context *smu)
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
@@ -1378,9 +1376,7 @@ static int smu_disable_dpms(struct smu_context *smu)
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
@@ -1392,7 +1388,6 @@ static int smu_disable_dpms(struct smu_context *smu)
 	 */
 	if (use_baco && smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT)) {
 		ret = smu_disable_all_features_with_exception(smu,
-							      false,
 							      SMU_FEATURE_BACO_BIT);
 		if (ret)
 			dev_err(adev->dev, "Failed to disable smu features except BACO.\n");
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 721b4080d3e6..55b24988455d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -990,7 +990,6 @@ struct pptable_funcs {
 	 *                                       exception to those in &mask.
 	 */
 	int (*disable_all_features_with_exception)(struct smu_context *smu,
-						   bool no_hw_disablement,
 						   enum smu_feature_mask mask);
 
 	/**
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index acb9f0ca191b..2a6b752a6996 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -767,9 +767,6 @@ int smu_cmn_set_pp_feature_mask(struct smu_context *smu,
  *                                               @mask
  *
  * @smu:               smu_context pointer
- * @no_hw_disablement: whether real dpm disablement should be performed
- *                     true: update the cache(about dpm enablement state) only
- *                     false: real dpm disablement plus cache update
  * @mask:              the dpm feature which should not be disabled
  *                     SMU_FEATURE_COUNT: no exception, all dpm features
  *                     to disable
@@ -778,7 +775,6 @@ int smu_cmn_set_pp_feature_mask(struct smu_context *smu,
  * 0 on success or a negative error code on failure.
  */
 int smu_cmn_disable_all_features_with_exception(struct smu_context *smu,
-						bool no_hw_disablement,
 						enum smu_feature_mask mask)
 {
 	uint64_t features_to_disable = U64_MAX;
@@ -794,9 +790,6 @@ int smu_cmn_disable_all_features_with_exception(struct smu_context *smu,
 		features_to_disable &= ~(1ULL << skipped_feature_id);
 	}
 
-	if (no_hw_disablement)
-		return 0;
-
 	return smu_cmn_feature_update_enable_state(smu,
 						   features_to_disable,
 						   0);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index bfe3430829c7..a4c593ed8b03 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -79,7 +79,6 @@ int smu_cmn_set_pp_feature_mask(struct smu_context *smu,
 				uint64_t new_mask);
 
 int smu_cmn_disable_all_features_with_exception(struct smu_context *smu,
-						bool no_hw_disablement,
 						enum smu_feature_mask mask);
 
 int smu_cmn_get_smc_version(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
index 0063346ed163..530be44e00ec 100644
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

