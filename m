Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07B4CDB466
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 13:32:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DBDA10F5F4;
	Fri, 19 Jun 2026 13:32:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zXrqVeFs";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012038.outbound.protection.outlook.com [40.107.209.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88EFC10F5EB
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 13:32:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oj0i0Lmm9Nmnhdy7d+3U00AhViBEwFCoUNCeDQ00NqfRjJkOlxRialtPhed19nNUWG62ytTyeeExH1HFzIStIUi21AGKS0UTcfQ/Iv3baPpsrCyaE2FePnI52pOY3NAppfr+DbdtOpudbB4evN+7Drj7uIKNq3fYhh047dBwJAOyDNrQREfPXhlUEbaw2FnUmKxre7kLxJjZ+47s+lpDUiy6fBT8kOQb4bssr9LW7N2Gl7cfHFAI3e+XxtPO28TkDuCC+oYu3/cibfqZeeezT+DmsCtYKpZL7LHm2CeAqcsWjx/3OnrYLPn69BlvpF8SrRkf69p5TKFHjlpAIEnnPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjPdsIMAlwFSNuI+jCaPKuMgz8E4J3S2arGeKVSMQ6I=;
 b=uvH9PHjAFu5GroU8TvK1ihzXAaowK7bYUBKvpbB58R1EqC4Bzunmr3X/b33VBpaLXZy6Ml4Ap0iB6j1jbAc37f83Lj8w1vrsbK3qn9FTKt9djZGAz97rqBY2qgrVm/FJD4yg99WD7BxZ1nwyw3XhpovR+dV9NqBDiTVaqaa/U1VZcExE+owitehf5oZq3ZAQUTOju9DrUgFxtBvIhc1SKkZEjeVPhbJt7a7Aby36VfzlYYrkBtuJ+kNxFUrBgbiszTCtqIrPV4yrnPyFFMoHiRMNrCbo+vF80fPYO5ISZRiEy1gPyVJyoY7ELY5PjoJ/r1lDQkKq/9aN8VGLhO5QgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjPdsIMAlwFSNuI+jCaPKuMgz8E4J3S2arGeKVSMQ6I=;
 b=zXrqVeFsitSJlL/jFIgF8FNH34XKXJT4kfUYE9N+5yRIC06fjYVITdpKloJ+mtqF2GR8LeqxTY9aM76/GhlhEjBquCcPKercTR45Ki9siSPUnZUTXBH/x0bRkRgPjv5Kzgk0ONTuTdAjcH0Xh3fvUGMR/uhJsIf35KcEfjSpZK8=
Received: from BN9PR03CA0859.namprd03.prod.outlook.com (2603:10b6:408:13d::24)
 by CH3PR12MB7641.namprd12.prod.outlook.com (2603:10b6:610:150::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 13:32:39 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:408:13d:cafe::a5) by BN9PR03CA0859.outlook.office365.com
 (2603:10b6:408:13d::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Fri,
 19 Jun 2026 13:32:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 13:32:39 +0000
Received: from georzhanmkm (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 19 Jun
 2026 08:32:36 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>, George Zhang
 <george.zhang@amd.com>
Subject: [PATCH 24/24] drm/amd/display: Remove redundant IPS mode case for DCN
 4.2
Date: Fri, 19 Jun 2026 09:21:39 -0400
Message-ID: <20260619133154.116746-25-george.zhang@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619133154.116746-1-george.zhang@amd.com>
References: <20260619133154.116746-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|CH3PR12MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: d85f7d25-7078-4b78-9007-08dece073bed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: GLJRYICoUHjWWe4AY1uE5xV7/RxNj+3qV07Oycwf9wQ1CA/6gKOzEwISXiFDPcprQcrBUDIFl1cywpadt1LPMykDtEyr/iv76m1Cb4Epl8ZzecY5CiN93/L0LeoQ4r5JDWpH9fPyQDnVyla9YA0OiTt4BZRFBEw0q1MSKrwWH3rUw0kDcGksT5oUooc2A0xLxiLlvc3f7UTfCK8g4iJ3hrPzwGm+/FeGWfgaPiLSGulmmTT7nTzqkyHjsiZPSNMhXsDTp4kYCLFRIR/sMcbBdrNJN5GeILrbqwFlYcx8KglfVlKOfhcp0OdHIgd5Mtj39ZQzsjwNVecJzOKP/JPCEVb34GnB5gA6oxNchefCeY0Qs+0ckSTMBXfu1sAEO+O9/MMKoZJ6BSKq7Skwuh92oEQCSRie8wfbjteExt7twnHZILmjsQrCWna/HUgCLmFB7EC3gIzJTFH7S69XXKVrbGWfjoMGw5aYmMy7ctB5nx70Vh1CdKX1srLr1nnxZEhMtu/advwnfl47PEti/UWAupixi88ogRR6gvCtxtHqInncjG3D5Vy0SdeRzlWvqa1XmgFAYsggi77LyzG+yUKipw9LzDHjSfqp9ck8ONE5p1GuPVm2PdQdAaNERpwYCHuutFPNFzDnM3DtjBvb+rgUVgTWJSd/AFsbKhKcKWQ97hdjuq8aZshNvoFSNSfrLYHmtZXwuF/R8OwZmRfo3vyROQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Co6rguHBJANtbralYaMDCrcChjKGCy/tqpSv/JsR6261iiTjlSpQKs4tsPISo6VUYiEJjfqrcIWNJtHSn6Tenuh/gjbvqkGEcszNWaO2VJfJRISdWuOTJsOwAyl3kWWchP/S8VYcU9udP1eo3wf8Qcz+jpg67t2GSyzdzWDhLdg1fxnhyPxC5uPW4xVzOgY2rNZk54qKMya8rKMo/FK6SI3VLb78xmSfoNhLNE+xVE0bPZfYnCN6i3SQTOE9BIXelKXp88DTm7CmqcFD/tVMfCiNhfSoqA3b36gEnCo6afkHfGgomqwEaluST3iE+OUgQLUWIuUGnpvw0GK8n6zkqFDOZyZ+43mbKphVzSCdbRXu+Qh7BTmcSUo7jgQWkt8tg8a28BYAQrjdcgUzmGnjWijwd1hQFPYCz0f1rhC9zbZhAHhNCf6vzAm2TEDygVi8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 13:32:39.8310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d85f7d25-7078-4b78-9007-08dece073bed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7641
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

From: Alex Hung <alex.hung@amd.com>

[WHAT]
Remove the redundant IP_VERSION(4, 2, 0) case from
dm_get_default_ips_mode() since it only reassigns the same
DMUB_IPS_ENABLE value already set at initialization.

Also remove the corresponding KUnit test.

Reviewed-by: Chenyu Chen <chen-yu.chen@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c |  4 ----
 .../amdgpu_dm/tests/amdgpu_dm_dmub_test.c      | 18 ------------------
 2 files changed, 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
index 579a435dcefc..4f5dd2158417 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
@@ -453,10 +453,6 @@ enum dmub_ips_disable_type dm_get_default_ips_mode(
 	case IP_VERSION(3, 5, 1):
 		ret =  DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF;
 		break;
-	case IP_VERSION(4, 2, 0):
-	case IP_VERSION(4, 2, 1):
-		ret =  DMUB_IPS_ENABLE;
-		break;
 	default:
 		/* ASICs older than DCN35 do not have IPSs */
 		if (amdgpu_ip_version(adev, DCE_HWIP, 0) < IP_VERSION(3, 5, 0))
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
index b82dd301a896..bf90ccfbf431 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
@@ -350,23 +350,6 @@ static void dm_test_get_default_ips_mode_dcn36(struct kunit *test)
 			DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF);
 }

-/**
- * dm_test_get_default_ips_mode_dcn42 - Test Get default ips mode dcn42
- * @test: The KUnit test context
- */
-static void dm_test_get_default_ips_mode_dcn42(struct kunit *test)
-{
-	struct amdgpu_device *adev;
-
-	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
-
-	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(4, 2, 0);
-
-	KUNIT_EXPECT_EQ(test, dm_get_default_ips_mode(adev),
-			DMUB_IPS_DISABLE_ALL);
-}
-
 /**
  * dm_test_get_default_ips_mode_older_than_dcn35 - Test Get default ips mode older than dcn35
  * @test: The KUnit test context
@@ -572,7 +555,6 @@ static struct kunit_case amdgpu_dm_dmub_tests[] = {
 	KUNIT_CASE(dm_test_get_default_ips_mode_dcn35),
 	KUNIT_CASE(dm_test_get_default_ips_mode_dcn351),
 	KUNIT_CASE(dm_test_get_default_ips_mode_dcn36),
-	KUNIT_CASE(dm_test_get_default_ips_mode_dcn42),
 	KUNIT_CASE(dm_test_get_default_ips_mode_older_than_dcn35),
 	KUNIT_CASE(dm_test_get_default_ips_mode_newer_default),
 	/* dm_dmub_hw_init() */
--
2.54.0

