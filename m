Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0D2D1D88B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Oct 2024 17:41:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80A3F10E5D3;
	Tue, 15 Oct 2024 17:41:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lXofJIvU";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAB6110E0D9
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 17:41:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zVYFU4M2Yks5ZeEFKLX418qUQuA1cf34lU7egw3naLiFmMG0Y+eq/aIIi48OZBaxLYyH6kss5vEV+SBdZxSq09lz48kOYPXvB/2X59XPDqJnKpwx57+cJttFr37mKivO/3zfM5bvVnL2dCgzVRCY/VyCq77zIwdxWSUfvEzy12uqv72h7H7mQu9CJSg9l0I93F+JLON6PfBJmp7TPcer98oJYTlUqw5BADrz7CBYWJoNC/jWS6MovBZnACF1GF2OsP9fhMdmDt9OLpyzddycM+BHZk7dYV0FfbaKx3PJEPUW68b/39TIt30FOMdlZBMY8JB5v0KzVW0c5vhPF4lBWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJ6s1Ih+WCDZ80sscdIDgeKCMB5J4tAwrheS6SUsv6s=;
 b=oZExj5w8nwNFhMicgmwdeuJQi0fFqcWLAOwKtq6nrXeBlbIUMDsjfcFJEjHOzjtxs9oU1G/0zaGA0R8kvsh8F4H8gxInCCwxm3jUst8jx5zeJ/7TAD/WdZGYK9Ym9ZpKXPbILIxxPVQjr1yn0s2XkJ5Kkr82yrAedkOBcreFoIsmQKeZeb7EEtCrXhCaxIAwQrWEx9AxVuOcRod7FJi+htyz+eCk/w5CRkN6mQXVaEplNgrrvzFz+qQXCKu2g7kfE/SJL0qBDvIoutiHWrSA771H+QYvNOMBdKWa/FcDRmegqzCUjIKxianH7WkfUzULgZAQ9z+tj2SA2k2txeUn4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJ6s1Ih+WCDZ80sscdIDgeKCMB5J4tAwrheS6SUsv6s=;
 b=lXofJIvUHMu9jFtKK1LGCeaT/9z5xV5UgaUuRQtHwUsMHCZeAdufiZJJgDBinsmrLf7Wei9KaQOiAuQ4V6x2e39KexZ/dWfrWlvE7zkSzYCURbNRSCHB4TJ4w33/PoE6pTHPF88yBnZKDfvWR96G3yLQawdXbY03kPz52zc+4ig=
Received: from BL1PR13CA0323.namprd13.prod.outlook.com (2603:10b6:208:2c1::28)
 by SJ0PR12MB5612.namprd12.prod.outlook.com (2603:10b6:a03:427::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Tue, 15 Oct
 2024 17:41:12 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:208:2c1:cafe::6) by BL1PR13CA0323.outlook.office365.com
 (2603:10b6:208:2c1::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.7 via Frontend
 Transport; Tue, 15 Oct 2024 17:41:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 17:41:11 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 12:41:10 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 12:41:10 -0500
Received: from debian.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 15 Oct 2024 12:41:09 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <rodrigo.siqueira@amd.com>, <hamza.mahfooz@amd.com>,
 <harry.wentland@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: [PATCH] drm/amd/display: Add debug option to disable idle
 optimizations
Date: Tue, 15 Oct 2024 17:41:09 +0000
Message-ID: <20241015174109.238518-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|SJ0PR12MB5612:EE_
X-MS-Office365-Filtering-Correlation-Id: ef3fcd1c-98b3-4e02-39e9-08dced408f70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XAPOBDo8960T5WcwI1je8cOWxv9WQP8wEG13vGe+B+Jfk6yJOmm3JeFBCh4p?=
 =?us-ascii?Q?OuzcP6tMY58OxDK0qC2asZJ9BauzXuKw8j5EFBj93B7Sgz/e5OP2uebBO5Hc?=
 =?us-ascii?Q?lqo7xfK8feBEH0csmD7VczWshIPdl8MeMlxP86jJxRoZFfxr8C3Dg3Ayx5jy?=
 =?us-ascii?Q?KcObAzcxVkSyVgcaq/htzTzZkKVNttU/Gl85djkEr6440Lz0jkz3ez0G5Ppr?=
 =?us-ascii?Q?rjknLaf4OgeIV1aRfsp3XfCKeKTBbxwxDT5AjGkX1ELTqZ6WI+QeHvNJfyxh?=
 =?us-ascii?Q?kTSS3l+Qp5xmhZ0B9bACl3tTZTDeazxdWJ5MneGbMmn41kCeahXjf7Nn1NKc?=
 =?us-ascii?Q?wMpaObDjMvDo3rSBao1NbbQwz69nyEz6bnh5paMQ7e8H9jHikXhhDw37MC6M?=
 =?us-ascii?Q?3L8GNkuwYj2rdNQF1x18ryHu0GhkIprxZM+9KaLcWe50jPFZQ4pm7AV9CG6S?=
 =?us-ascii?Q?AR6r4sx1pZbHwpVMFKhnygL+Tiargh+93VpMtwkQiS198kSoDPoAOCJFyROr?=
 =?us-ascii?Q?H8SSwEQ8tK3SaYyg+q6pSScrfFSD3DjBwJymYvwL+A+fwQ8L4XobVb+h/4Da?=
 =?us-ascii?Q?HmrTx+n7oPShWpD1E30J2lk63ymVMkLeuKChiR3FpZMmljARaLoZgvM+wiWQ?=
 =?us-ascii?Q?8ZnOY8sMOJlLgEos+MB1vrbFc1WWJZjeBPEYwE1nUSe4O0BNrA+CyHAvf1WG?=
 =?us-ascii?Q?xeYw7EhFfKGHsm7hvp9VIU0pS/Uul1jBLZHy/c41coNSi9cjkrdH0qy7pmBK?=
 =?us-ascii?Q?lMzrIfcwfA6lCNPZZZ8H0KUbqCvT+3z0KEU2bnBeUjBVbXglBW3s9A3jsw2C?=
 =?us-ascii?Q?hC1GJY81XkHPEZYqZZxkwpBb/itqPgOZTcdnYGRqXjP/qL3T1U4BDStQBzsZ?=
 =?us-ascii?Q?bn43vCvt1yRbysCn03O5ZEB7WPBVzZzdZ8s82dhchwRpKP5wa7bD7MupfD7p?=
 =?us-ascii?Q?lId5pkdofrLkN7QDoz6N03Z0NmtGyN9FEnvn2oZTrHc71yPJqtU0yuKcECyf?=
 =?us-ascii?Q?cLOeHrMaonUMjzpAOi98Wn5Rfh8s8B5o5GRoBMgEyzi0zb3RmLUwbEcfMGou?=
 =?us-ascii?Q?tWZZKvFMXN7D13HOtjTNx1nh/CVPdCrRnTwMp4gTAT+R/zigBbprPswT7bnL?=
 =?us-ascii?Q?u+RA+zPsJY1tsI6soFReiBtcHJUlWkMyk8uO3IRGnekdS6FIpSOYoz9g9jZM?=
 =?us-ascii?Q?KAH2tbQo/NT7uEDOJwvWs/IHgew+wWHBGNW2/AACs3J0o1mav2/pWKZcaMie?=
 =?us-ascii?Q?0EbNZxkFTieQFQPOdG3jOkb7S/xrWT0RKP6qJq1dDZl65UKJUm/lVFwNt1ER?=
 =?us-ascii?Q?TsuJdA5SnzR44aouLhMqhQk41818gYC0cGfZrM0ShJbyETbMV/1Za1hK9zE3?=
 =?us-ascii?Q?nWfpLCqoaXluNBhhWsO4mFGndtzK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 17:41:11.9173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3fcd1c-98b3-4e02-39e9-08dced408f70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5612
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

For debugging purposes, add a runtime override to disable display scanout
from MALL cache (MALL Static Screen) by disallowing the driver from
triggering the idle power optimizations when desktop is idle.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++++
 drivers/gpu/drm/amd/include/amd_shared.h          | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c5487bb7c6b8..bb0e9deebcc5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2012,6 +2012,10 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		adev->dm.dc->debug.using_dml21 = true;
 	}
 
+	if (amdgpu_dc_debug_mask & DC_DISABLE_IDLE_POWER_OPTIMIZATIONS) {
+		adev->dm.dc->debug.disable_idle_power_optimizations = true;
+	}
+
 	adev->dm.dc->debug.visual_confirm = amdgpu_dc_visual_confirm;
 
 	/* TODO: Remove after DP2 receiver gets proper support of Cable ID feature */
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 7eefcb0f5070..fba3f2f1327e 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -344,6 +344,11 @@ enum DC_DEBUG_MASK {
 	 * eDP display from ACPI _DDC method.
 	 */
 	DC_DISABLE_ACPI_EDID = 0x8000,
+	/**
+	 * @DC_DISABLE_IDLE_POWER_OPTIMISATION: Disables certain power
+	 * optimizations when desktop is in idle state
+	 */
+	DC_DISABLE_IDLE_POWER_OPTIMIZATIONS = 0x10000,
 };
 
 enum amd_dpm_forced_level;
-- 
2.39.5

