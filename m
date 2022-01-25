Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D8F3C43217
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jan 2022 09:00:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3A9510E8F6;
	Tue, 25 Jan 2022 09:00:48 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E40B10EE30
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 09:00:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aaeJhuj7bSiqWazm9adYPwWf9ayBdU5IJFmArqTdK6krGb+8MW2eDJubRlmaablnRtUTEp2Cv6iO4+DR26q/7WcQomaJED01/DPLH25ECt7YKHEUbgl6R7gGX9f0joNioRRnvo/ZWnCE+w+8j5WTsTGA82sDOd+l91x0mKaqkytFNo7vXsc47yCd0A7fJug3yXHMVZTQoxFTzOUgzq0Cu1Z8HFfvelqw77lHOl5yaS7La8Rh4f9+pBejSud/hi5AbrTVvS8GVH6V3I2ynakZipEonk/eOyadz/I8nrPJ9ffK0mKliqDgEGJ4d6a3i5thXTsykj/sJEENxhqWR3q4zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBF15cV9jfbCOELcVZeXfqqxpcXBoy/Ie1dPOmFX5i0=;
 b=COZRNXAT6y0bvFiRSAoKNaOppg7UeNd0hYReqjki8BfpG6dHLeT7JTzNyXCgbUXeLodvZ7Qo2BTc7hxNILrHwy2N6oHRPFVFPLjFYCq+FI+z+d4zFwgkHqTPdSfGC5L+OzyRD/ba4DFyObWpepTPNWc2asq7IihYRCj0eIQAPqlriLzbOHKL4MjLywB4cA2ca1VdUmfB3hyF00TnfxkluSTapfFRoyy+XQidkqFZattqTD2qvHIsGNuU1zAhMg/D5a6/k2RdZ9LFsBwFLxNZ7xsFxraZHPm2I1ecQ5JpshdFXu5rZh4Wq8Or+ZnX/wHIu+fL2xX6FWALu2s0XgH3GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBF15cV9jfbCOELcVZeXfqqxpcXBoy/Ie1dPOmFX5i0=;
 b=DCnA9MU/ozwHNFz1cHFdED+LVtSmLdFpP6N/+Pn8238eBKdLJYsyQg22P9dpi1luqEOoT/gsmidotFRfVxsGcSwMkISXrYAejJDyvhQpJg/sHPcMj+VtmffVwGOqw1khnfL38wY9E6KYv+iUHjXHiYXa9SybfFAK5m8/SdVzwPM=
Received: from MW4PR03CA0253.namprd03.prod.outlook.com (2603:10b6:303:b4::18)
 by MW2PR12MB2569.namprd12.prod.outlook.com (2603:10b6:907:11::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Tue, 25 Jan
 2022 09:00:42 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::95) by MW4PR03CA0253.outlook.office365.com
 (2603:10b6:303:b4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Tue, 25 Jan 2022 09:00:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Tue, 25 Jan 2022 09:00:42 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 25 Jan
 2022 03:00:41 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 7/7] drm/amd/pm: revise the implementation of
 smu_cmn_disable_all_features_with_exception
Date: Tue, 25 Jan 2022 17:00:13 +0800
Message-ID: <20220125090013.102080-7-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220125090013.102080-1-evan.quan@amd.com>
References: <20220125090013.102080-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92894a04-5261-4c32-aff3-08d9dfe12ad9
X-MS-TrafficTypeDiagnostic: MW2PR12MB2569:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB256907330CC705B480A30FF6E45F9@MW2PR12MB2569.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oSvJmokUVo8AkyPH4o0GxcpEokhrPi5btB7VQOgbBEAvkwlvgTnfvD8+kG53/2zywKp6Cn0fgugtopIj3ABomnW9jLMwoHJ8+oQ1HKcBPa4mBmjqOpjLgVkQI07Vio+SkVSZJoAcs5xHjTDpOydaLhyuhJ1aQXN4yGhuoFBuYMe+CIgC65fW/MKIpHkMGV10IhCiZbJZzSaDiykkz2ixvGznsps9MLUzwjaKZC9XF198+lwMnfMX5DTEVC3TjQ4vqA32TG7lvBUR1cZICZsdHstrvSt5gELkusOVaT2sjWqITmnQDVC8HPx9v1KFSiWx8HLeZ6JMP+jZmlZm5nJiYLOHCogDW6bl6I5V6rh4V5eR/NzGOivwwxiVS/lEbygR7B3msvilfXs1uhUbU8cwxyCXYFqmNmMqn2qNEtVCDNw2x61Xq/Et7kVQvaEeUrtxPMLYGvGbiWR+qRURUTK9ffPHvTH8+tWuKva9H6wcUHg+Z+Mae/KMDafOgeqLDfX+4AQCoHh5idZjIki0KYwdapKrFIuPX0ULm0JrM8nTlECZRAIR0j5cayInLV309VUIqmFTlIUGuA6wnOiFJCWpBkc4rWy3kQzzYZcB8vGdn6tIskncmdCWwmcS45W/53hMTXUlJ4WKcWBWpFtc2lKfpvtp8OSyT9kHQnmCXEIkPM6iEcyFuZt5P7i8ml5lLTbgfKzxDUwOUAaRRl4D3Xxhb658WGHXuduFUHJmGSj3KT9tcOCyGu8+nF+ofbF173nVrd93120MIGhbEqCB5KuxeKc6waJR8MrHtDwLBtxv8iM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700004)(6916009)(5660300002)(83380400001)(508600001)(54906003)(36756003)(82310400004)(86362001)(186003)(2616005)(1076003)(2906002)(70206006)(44832011)(4326008)(70586007)(6666004)(36860700001)(7696005)(426003)(81166007)(16526019)(8676002)(26005)(40460700003)(316002)(336012)(47076005)(8936002)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 09:00:42.7462 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92894a04-5261-4c32-aff3-08d9dfe12ad9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2569
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
index 1e552c083e87..af8e2d7ff52c 100644
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
index 33355bf0f557..608e6115bf42 100644
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
index 2717f6abfe0c..e731d37b85a5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -765,9 +765,6 @@ int smu_cmn_set_pp_feature_mask(struct smu_context *smu,
  *                                               @mask
  *
  * @smu:               smu_context pointer
- * @no_hw_disablement: whether real dpm disablement should be performed
- *                     true: update the cache(about dpm enablement state) only
- *                     false: real dpm disablement plus cache update
  * @mask:              the dpm feature which should not be disabled
  *                     SMU_FEATURE_COUNT: no exception, all dpm features
  *                     to disable
@@ -776,7 +773,6 @@ int smu_cmn_set_pp_feature_mask(struct smu_context *smu,
  * 0 on success or a negative error code on failure.
  */
 int smu_cmn_disable_all_features_with_exception(struct smu_context *smu,
-						bool no_hw_disablement,
 						enum smu_feature_mask mask)
 {
 	uint64_t features_to_disable = U64_MAX;
@@ -792,9 +788,6 @@ int smu_cmn_disable_all_features_with_exception(struct smu_context *smu,
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

