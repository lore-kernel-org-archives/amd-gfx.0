Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C92ACDE012
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2026 09:46:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0313610F52C;
	Fri, 26 Jun 2026 09:46:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ai8pCt9E";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012057.outbound.protection.outlook.com [40.107.209.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C3AA10F52C
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 09:46:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YIU2mod7LJeHOcHXBRgddSJR6YfUJYimdoJp+FfgCbYwpQc6iJK7UpQjiKFUXe2y8x8H0g7QnHs/62ae88R758RPUCXmz5l0mFGioO0LARjaLdmMKjbmUByBWY3dPBirxMyDoDyiTnA5xyHN0vxNcuxKQZUaVPv4x56lBxnYcA44SCbjbIHPezHYK+ajZighG3H55gTRgqZDwv/HVbrFllW27q+txNDvWng9sS46UUcHDJ/+fgTPZP614h1G35rzKYAmj77eSACaEpccD6NIHzSDF65YyzQLeO3SYst+LY8pYZjVR9FYrOyv8CkXePy/DjlWpJ0KONcp2rjcQsrOsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7OaWjqcRS3wfdTqeQiF42lLQbYigtOhFyv8g5Nyi+4=;
 b=eNqfaGnEDnHXbzILEJCiBwdYpGTSWDJx6Ts4iE4ndCQ9m/ixA9LfW8RIiWsJ0I56J+aOJyVitYxO3w2njRF0BfI1nilJWZTpEXjiQ7aeHCVrtRn2RwTMWATaVIwsXhm8rW1MA9Om7t4Rs90lAfVTzq+YlIpTY9vIWHGEHssqcR4utsL4a2gvMfixA/6W8mZZxlR4TjW/sGhHGFGT7p+oz0xPfW9O4XL31MKZsCgUOeJFrZ+GZH9/qqLvI4Xa0R983EkiX7wMeIh1hfUJFVoGHzYHu826t857+IdlfoKxUiylP3ARH1CFAhmQqepUFW2wWWbSW6D/N2opeeKyHWJDdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7OaWjqcRS3wfdTqeQiF42lLQbYigtOhFyv8g5Nyi+4=;
 b=ai8pCt9EN7WTuzjQAFm0PHVv7LxF92VExXH9v4I2WH5UwiWNyAlCTOu/8DJtMohznmd53PwfOACG+O4IWkpevSzp/KqezUVPKeswD0k5Tp18KInktFWWaswriP7i5Dp+M9sUclqb/Hb9FpCnnz+R59uedj7DZLPkWX/jMHxwOAg=
Received: from CH0PR03CA0391.namprd03.prod.outlook.com (2603:10b6:610:11b::10)
 by LV3PR12MB9329.namprd12.prod.outlook.com (2603:10b6:408:21c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 09:46:10 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::71) by CH0PR03CA0391.outlook.office365.com
 (2603:10b6:610:11b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.17 via Frontend Transport; Fri,
 26 Jun 2026 09:46:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 26 Jun 2026 09:46:10 +0000
Received: from granthali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 26 Jun
 2026 04:46:08 -0500
From: Granthali Vinodkumar Dhandar <Granthali.VinodkumarDhandar@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <Pratik.Vishwakarma@amd.com>
CC: Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>,
 Granthali Vinodkumar Dhandar <granthali.vinodkumardhandar@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: add support for SMU version 15.0.9
Date: Fri, 26 Jun 2026 15:15:43 +0530
Message-ID: <20260626094543.1195245-4-Granthali.VinodkumarDhandar@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260626094543.1195245-1-Granthali.VinodkumarDhandar@amd.com>
References: <20260626094543.1195245-1-Granthali.VinodkumarDhandar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|LV3PR12MB9329:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b711ebf-49e7-4017-c9c9-08ded367c0aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: z9AyZ6v31CTnAF8ou4QPbnnHtn7jvGnHjIJsipSB1duFrzkP2PKvQTSNKAkTXeb79QxywxzK1aP/N9+pqqg2DSzFCojWHsT0faTqEjSM8MyA1b+KYKCR2Uu76xvBNFF0rG/otoyzuGuclemBJ7TBWHwUoiTx0crHxJ+dELHYHRruZFWJEMs6Ec+v/FULxGkIJEk4rF6w91nD+c9/ZJnCLBosqD7yTZczIRRFL0Oxpl8EC2AkB1EQChBwT+DF1LGg6kSoMCqHAbFCUCXSiZms2xkIMX9IoHQS/hsORb9y1Lc1gqMfpYdsdBX/cSAUhZ06aG+4WxjcPJoIZzao5mkc8hYOqoH9TRyHQq+ZNP5wugFF8rsBYWb4SaknC9MS0or5mjv/eBZc0TBunQDo9IXdACPHYb4b8hYIcTAds24vvqWboImQP6rEHJxlCvO5976a9e/9gRF0FAdgBsVR8rxNMR5N+fHK63ZlsN5XWvyitwJypN0uACoo9t4Sp5KbSP21DLzMuJa/hHr7qIzPM47KuN5zADQ2bnPYbR1kA8gVIuys/bUvk71kqg1I9AsT7lf4RRhhdwYYCb8o/kfGvYC3xrMB+vJstzcIzKbPYcBUk8AO88BhZASqGXrGV+9DoAGP+zyy2JW8YImInglZB7Gbvjd4aZ0+kaB7mkxZEzzN3flYUrn0r1r/jrpnPj0KiWnVZZv5MGssjpI8XpX6aUP+6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vOd210YIkTMPr5G0mtOsbeRP1YPshQxVCdQPAaoSQrFnN8ZVswki5QLywYmPPWzIETuQ6tT8B4YT+iHEhRsVrcEZZ7KLurIWcCG3B+vJutLn2IQU3lLsX0zUKIoyFRlXjTvhvGSMJC51c905EpVW2IcwZVmuaEbXCIWbzP1Xbpb2ieHYNl7AuKR6D4YBoxH2zZtEEcZa8MlanQ3FPGlx/3cqO+B4e/CLfOCPBTYM1l2waKylleYpanKseLLY3oHr7DFRzkgzwNL3rih8xaDxOLJcWcc+2Rs7Ifd9m0iKIDtqjoty9J6V+fKuihHCpMnN9kcGmvFT5nRWCvrGxmdNE5XlWB/uQIjpw6BUxJD4B/X9f6RTECesNFvS2s/0MIOtX0ReUMxlNtFEZUuq3wI+3nbiS0/Q2C3F3nBsrujI3sZfFG3lVrKF3ZyvALEcnCi5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 09:46:10.0364 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b711ebf-49e7-4017-c9c9-08ded367c0aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9329
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

From: Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>

Initialize SMU Version 15_0_9

Signed-off-by: Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>
Signed-off-by: Granthali Vinodkumar Dhandar <granthali.vinodkumardhandar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c        | 1 +
 drivers/gpu/drm/amd/amdgpu/soc21.c                   | 1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c            | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c       | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c | 3 ++-
 5 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 16606155a92e..b309c9fabeaf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2593,6 +2593,7 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(15, 0, 0):
 	case IP_VERSION(15, 0, 5):
 	case IP_VERSION(15, 0, 8):
+	case IP_VERSION(15, 0, 9):
 		amdgpu_device_ip_block_add(adev, &smu_v15_0_ip_block);
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 1677e88a4e36..a2733d1637f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -406,6 +406,7 @@ soc21_asic_reset_method(struct amdgpu_device *adev)
 	case IP_VERSION(14, 0, 4):
 	case IP_VERSION(14, 0, 5):
 	case IP_VERSION(15, 0, 0):
+	case IP_VERSION(15, 0, 9):
 		return AMD_RESET_METHOD_MODE2;
 	default:
 		if (amdgpu_dpm_is_baco_supported(adev))
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index ae44437af86b..c0699741e711 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -802,6 +802,7 @@ static int smu_set_funcs(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(15, 0, 0):
 	case IP_VERSION(15, 0, 5):
+	case IP_VERSION(15, 0, 9):
 		smu_v15_0_0_set_ppt_funcs(smu);
 		break;
 	case IP_VERSION(15, 0, 8):
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
index 4a61e900131f..ec7c72983224 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
@@ -665,6 +665,7 @@ int smu_v15_0_gfx_off_control(struct smu_context *smu, bool enable)
 
 	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
 	case IP_VERSION(15, 0, 0):
+	case IP_VERSION(15, 0, 9):
 		if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
 			return 0;
 		if (enable)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index 3cf47ecdffda..4033012fa39c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -1177,7 +1177,8 @@ static int smu_v15_0_common_get_dpm_profile_freq(struct smu_context *smu,
 			smu_v15_0_common_get_dpm_ultimate_freq(smu, SMU_SOCCLK, NULL, &clk_limit);
 		break;
 	case SMU_FCLK:
-		if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(15, 0, 0))
+		if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(15, 0, 0) ||
+			amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(15, 0, 9))
 			smu_v15_0_common_get_dpm_ultimate_freq(smu, SMU_FCLK, NULL, &clk_limit);
 		else
 			clk_limit = SMU_15_0_UMD_PSTATE_FCLK;
-- 
2.43.0

