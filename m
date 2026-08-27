Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B3E3C61DB9
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2026 15:19:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9936A10E852;
	Thu, 27 Aug 2026 15:19:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i4+R3/83";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010056.outbound.protection.outlook.com [52.101.85.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8816810E852
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2026 15:19:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqDG9rv6je2PUQDouyC+a7WmTddQKQegSqM1arqOILJb6jN+8oLo1bns89Y3j+Hr6IizGZ0NkkHErzrPUdc+zgtCvjzwX7ncKene9aU+w+DKKyGrhTDBz5ZzPAAVH85OT/yve5+vOc4/GUjkZfHjO7pUecFv5cYcy+m9w+XtlEOU8iU/bHWkPsgLJmYesKfnL0NfzLA4D9kaInRZfUCimISjGJSgefnB92ADPmXnctJ20+RBW3bJ+e8odKcHM0GF6f+p1RJOFyG/+XGE3JcZB6uTp/BclwDvx/qOlnOqAzZANEr10RL9ovfPXrbwqbbnfJ82MExH8Uv/wbk0fmn2mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YoXq2F5Q4OzqGoyMEYnYPjtAY+TJWaaOU/HE9qSHY0=;
 b=desE4PjGw3FTeBCj/if4RseN8+4hITItIzW5luh+O9TkMwl+XqRCrjqZD4oi0EFuHu/i5PrmoQwIwqVIHc5LJbl2eJs/o8vy1Yi2fnXn4dj09oS2TdzkHmQFIS95pnDVDc6czFxFdrFccdBJ4DG8PA75vqE3cCGt8CkIlamrDSRA1iLKF5hpS6mAJYppS0/yi9cJFOR+y7biDdZBrnIAUt00sXSxlTYNt3f2Xqei9WmhY5e5tElvSK0D8/WbSLfyrdIAmbmaj6Ysz1wh9qxmP2gzoqS5+fkMUEChFYwIZD6r4wp5rCvLry/PHXVTvpVbaX0ueyZZr2f/Vx+vGyMJAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YoXq2F5Q4OzqGoyMEYnYPjtAY+TJWaaOU/HE9qSHY0=;
 b=i4+R3/83hmq1IOBd8+8FERSn1gUpsZUiEtywBADt+AFwjhEXnAiN8g1oFB6G4kgOs57G/C1wbfKaGcmtedk8wLqn9BzJuZdU44e4SDWV0K82FiHg9PDeUxRPFqovvDQvntsPtHKdTW5o+f6YgrqxXGOc1bE5u8QlTpG4AWOxmCU=
Received: from SA0PR11CA0157.namprd11.prod.outlook.com (2603:10b6:806:1bb::12)
 by IA1PR12MB6385.namprd12.prod.outlook.com (2603:10b6:208:38b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 15:19:47 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:1bb:cafe::6a) by SA0PR11CA0157.outlook.office365.com
 (2603:10b6:806:1bb::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Thu,
 27 Aug 2026 15:19:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 27 Aug 2026 15:19:46 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 10:19:46 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>
Subject: [PATCH] drm/amd/display: Enable HDMI FRL by default
Date: Thu, 27 Aug 2026 11:19:49 -0400
Message-ID: <20260827151949.1426104-1-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|IA1PR12MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: acd967a3-c378-4209-89f1-08df044ea151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: OZUkHKIcZXSDBFCsVKvMNCKyqejkpKJ4Y9kbJJYo4BGQEeP8p+22ajG5JXwvf8+hSe9cYupYCXY/4LU5AHPmS7czqP4D+9JkCC3axy5EKKUER3Le09EKF7Y3xCWW7ZtT8j85L0reQHSeqkNriffl9ZvAmVop0RinfHegKb8tTI0E27Wg3EZU5WwZC+4utanxiZLcGhNe6B3PhgQkcwuD24nRDrvQrcBGGwcewE1clqL5W/gdOmMeUK5rRS8beahvwy8PyCA/veuNY2asZZfHUgAOAiZQsTTlYt3ktLBHQVkPlgCYWHMGp0ASk7sy0EB5r2yUszEG3pcreVKWuf1OcfYIUL5Ok9SyLdsz+vJsYwkS/D21lsQxLIaLJ53ffZENjCbCWYssAM9+Wu0NXkf3GqUHlg93bjOiHu6Xbin7wHT43NCRARn4eGL9ipZeAyDyfXt50zJWTNXC1w2TI/rBwCa5Kb9sUlwUzcEvl6UmbS1rpr0qMG+yoGlsyV66DT1PY0y4Ast4szQzqXuBYrjXIUiR4ilCK8dXnH6Ih/iNoRAx7P/BSRW1SKsQbfE6yt+rJES+J4OcxSUv4MQo28DAhdLixxfrthiE4JtgUGz4RhiLGiyzna7YGkNunIeyg+MXSV85/q/yQBwWsE/7WdDjGgjckacucyT3msnfyN9+v65qfX1oAESzyAstLr2aQN9z0Ve7w/gWcD6fga1STghphQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dR66x9qIhE2dMGxB25QCtov70H0G3nrPPuLKGNKVHuOU3WIkBZZgzz5cw9/F5AZx7G//KRh7KwYvt9ZI/pUjxhVe1/h62gwEnBa76XvEaotudkJZvXor0vH6oM8NEEXbpnQHKSuaVbqbG9nidCxn42dkr6/7VjWE0JBVkxW/T41vstIq+DJ57V5/ERfOPtQKo5ePnqlkUXaigKvQmJ0M4/HSYmoXEYK5vtNqfIVq3myBm6dptsdtIaTEPZUUmdxT4SxnyPhKeni8XkgrPlEVsyLX7/w/uMAUQzqW2F0DM8AXjwrZQTxV5sknFy8sY6unmSJ2m9Yxq62f5fY1LTTDKo89l63erS4xY4D/VRvLPznr0fvrBKODtqiaRdhHybrKDe1KBduwYaqkgUY5+1GePpnYuJgAPYeRwHi90bIog0tUQtVqaOFKwHkA68wVoNN5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 15:19:46.9600 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acd967a3-c378-4209-89f1-08df044ea151
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6385
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

FRL (Fixed Rate Link) was gated behind the DC_FRL_MASK feature flag,
leaving it disabled unless a user explicitly opted in via the
amdgpu.dcfeaturemask module parameter.

Invert the DC_FRL_MASK check so init_data.flags.enable_frl defaults to
true, and repurpose the mask bit as an opt-out for users who need to
fall back to TMDS-only signalling. Update the DC_FEATURE_MASK
documentation accordingly.

Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 drivers/gpu/drm/amd/include/amd_shared.h          | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a27c1fa74994..bf5369cc8b13 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -555,7 +555,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	if (amdgpu_dc_feature_mask & DC_DISABLE_LTTPR_DP2_0)
 		init_data.flags.allow_lttpr_non_transparent_mode.bits.DP2_0 = true;
 
-	if (amdgpu_dc_feature_mask & DC_FRL_MASK)
+	/* FRL is enabled by default; DC_FRL_MASK can be set to opt out. */
+	if (!(amdgpu_dc_feature_mask & DC_FRL_MASK))
 		init_data.flags.enable_frl = true;
 
 	init_data.flags.seamless_boot_edp_requested = false;
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index e3baef809cd1..87eea3360450 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -287,7 +287,7 @@ enum DC_FEATURE_MASK {
 	 */
 	DC_REPLAY_MASK = (1 << 9),
 	/**
-	 * @DC_FRL_MASK: (0x400) disabled by default
+	 * @DC_FRL_MASK: (0x400) enabled by default; set to disable FRL
 	 */
 	DC_FRL_MASK = (1 << 10),
 };
-- 
2.53.0

