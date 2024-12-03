Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E46E74ADB
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2024 21:41:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E546C10EB7A;
	Tue,  3 Dec 2024 21:41:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oKXeFMC1";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E1EA10EB6F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Dec 2024 21:41:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SWppbo4zzmvX308/f1NsG7QRWm0wNGDAvIfhVvPGEqRol+TUMQEGxWWsULkvK+gxE33O1ktCDv3oTnUHHrW7WfaGsMt8X2aZmQj0u6SMaCmEUb+KuR6f2r5CtxoeXpT65SxXJhghi2S0pus8TRkDD2ngnOtF1LSLiQi+3KA4JJa/X9AuJViLJFDLJEOyXoO1s1gKeW2j903f7aa4yybfSvAbnjaN9VtFLr/pYZqWIJCFWePlzz6iKjV6pmneKxspdMYKBXhzHzKlVhGAp0GS03koPaqhxkuqHVaEKtXHWDlG16pm8iYasGGvY0XebD69xW0xs356pXcpv8s0BzGTNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvuqxanj4hpSR/nWt9A0iBg6/qDOs08fGt5mSR5Q9Ls=;
 b=QF0I+cjhw4hQ+S/RJlKZe0wVdzuC1eVSlDOEGs3QATh9zhbg8Jh3L7r8OdbAWx0BKKYp3diSM1pyA9DecCc1xT6FWUnkSpHqAiEVIM2XK/30/kR+3Kr8fPQhsYPbTMjqUjrL8tXSXscGH8olZw9FLJJetj7qkG/x874DLYcDottED7+el6HYQaigletyzadFAB3/HHEn/osr4uhXhBG3XYekrmIT7tfGPep/YiDrINxGU7gH7Ycsocr7AFA9q+tkpa+UWpoQSc42TBrbP+9Aet8gnwfPGHIVTbeGJkmEFvjhX3RVDNHIzgqFRkDNZOwAnr+hw0RNxNi5VxMdk1Ts2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvuqxanj4hpSR/nWt9A0iBg6/qDOs08fGt5mSR5Q9Ls=;
 b=oKXeFMC1f9I6Ded06ij9r0hPQDGRX1UDyalX7FVfVKBwAAEL0HbchErCupbJ3VuwLR7aqN2ZNnWSapm7Qqsygu0bCJpLGGbgltBvU2AyRkmOEo7ztjNhA9d2I6+/z19UZLZ1STfYfzg2ieZXexX2oSfwkJ24ZS2j6pDgX3G29n4=
Received: from BN9PR03CA0351.namprd03.prod.outlook.com (2603:10b6:408:f6::26)
 by IA1PR12MB6412.namprd12.prod.outlook.com (2603:10b6:208:3af::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 21:41:48 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::8e) by BN9PR03CA0351.outlook.office365.com
 (2603:10b6:408:f6::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Tue,
 3 Dec 2024 21:41:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 21:41:48 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Dec
 2024 15:41:45 -0600
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 3 Dec 2024 15:41:44 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Gabe Teeger
 <Gabe.Teeger@amd.com>, Dennis Chan <dennis.chan@amd.com>
Subject: [PATCH 13/19] Revert "drm/amd/display: Revised for Replay Pseudo
 vblank"
Date: Tue, 3 Dec 2024 16:39:51 -0500
Message-ID: <20241203214120.1161810-14-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203214120.1161810-1-aurabindo.pillai@amd.com>
References: <20241203214120.1161810-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|IA1PR12MB6412:EE_
X-MS-Office365-Filtering-Correlation-Id: 78d61ab4-8219-4e8a-af83-08dd13e34a56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oLm/Wf9qq9E963b931CzU8hscSEDt67mT2387mBaRpUSPr2hvMyMUnm/PjfT?=
 =?us-ascii?Q?bg8aNhPLqYJXasOfvjSogX4Jcm7I4ZHY7gD7P70Heb4gYcg5kKb/Gi2V0Ou5?=
 =?us-ascii?Q?F20WQJUFXcXxhrh2aRBC5+tza/C/DKtbwEYy5PTPt+ezUMpGTV0abC/0hKDo?=
 =?us-ascii?Q?QInk2XWYyVy4NBfo6ayaJzhKZ3oMU3QUB0R4GWhxyX1o95gUehyG12iuOR6+?=
 =?us-ascii?Q?YZNlMXyM/dYAproT03HJs3/7sT9pKta/VP0kvlUbXm6mb3dxlqGmOxsOVcYt?=
 =?us-ascii?Q?ha5nyBF22PcZ7wTFoH/Ga7CP3ZAP12eX9MMjwX5tJpTJJXvSbSdX+mOEIctA?=
 =?us-ascii?Q?xSrgYI6or04b4KDu9JmcxzHCKlbVQNcPzUpC71FJlpwDAGS7zKEXyE1bwHZZ?=
 =?us-ascii?Q?ur2Laq0/jmrCkDWPYxitVK2NF+WzvBAZPx9zDGfxispq6KINvWbonEzCnXIL?=
 =?us-ascii?Q?D4FGc+51VYuP28Tp6Te1jdD96mTIrTS0i4VPq6gNaBF9hY7/UH++4ikNPahv?=
 =?us-ascii?Q?92jGvlgALJCBDhi3uGZZBAj0PsiDdd5AHqsvYUO9LD0EFMQJ4eYpVIlU6mrC?=
 =?us-ascii?Q?DOdqdKNGplwrX/q9+9Rdbhh1g8tJEQQDVM3X1xSar+kWKd2glq/3uftxUWkM?=
 =?us-ascii?Q?XeovxwVu7Aodss3ABNeNif3QgTl4wXZcHjzPx3DKIyJNAJm6RSW6asyCTNm9?=
 =?us-ascii?Q?pLuTaAbd0s/YBwk5AcFdw/jlMuigny+PrZbc31fORXSpQVkdS0da7BDqrN/M?=
 =?us-ascii?Q?5YfGpT+vuEJwJmvF6bxmk/wAYFOK5EsXG/Cg8fimlKFc64uwZJXR7Z7BfSw1?=
 =?us-ascii?Q?Kq7no+mVZDw1VLwFl90mFOlRof3WWznKR2mCKqSLlMytRIpGZs7A1Ma+v339?=
 =?us-ascii?Q?5txWR1eb29VZTTSgLP93eqO0HFN2/pFiaSt/3+YFWLwpJAxzcQ+8zh+znidK?=
 =?us-ascii?Q?ZHE74JqDpobM2vMd8uLDcBG3WJEwLwwsDtP2/wJnJOn6cDhhuYRACG4PLSQb?=
 =?us-ascii?Q?V02MXfy/YhvzFGqo9EGp5qQrvATmTHtiiz55TX/dP0pWLBnRY8k0DopicJMK?=
 =?us-ascii?Q?j1HWt1HsrQKtOb24COqFalYvLe/3gxaMPHquIdT27UnroY2/U/omI9jtjLxn?=
 =?us-ascii?Q?SnU1UIV1XizmWCpgq/wpDGXaw0yr0QlAGvre7qhWhxp88dt4ClQorSAUuqLg?=
 =?us-ascii?Q?4sWX1lDCDQZQY/mQpHmnhiY0EUDtJvQ1NvVMD9allGgpsPxfRhC7eZw0FaM0?=
 =?us-ascii?Q?ATFFUD+MuBJuCnGUKK/PfpH6YVAt9KRKRuRGD6w3MeZjpPBo0W9yd6DZ56F7?=
 =?us-ascii?Q?s1Cbvst7MWF5k3+7VLYyPcnISERAwsAcdrHaWl/Q04EmH3fRlxRA926F4dL3?=
 =?us-ascii?Q?OZb4jlLokSD8WBbOOg6FJJ8C50+cnNmRgiVmKUTB8ROdIKF3NQxmHM0SS+Ua?=
 =?us-ascii?Q?LTmPqdf6eODJgJ9DuHMMe6yFpuCKgi6C?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 21:41:48.1552 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d61ab4-8219-4e8a-af83-08dd13e34a56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6412
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

From: Gabe Teeger <Gabe.Teeger@amd.com>

This reverts commit 69e9ce2a572b
Due to a replay regression.

Fixes: 69e9ce2a572b ("drm/amd/display: Revised for Replay Pseudo vblank control")
Reviewed-by: Dennis Chan <dennis.chan@amd.com>
Signed-off-by: Gabe Teeger <Gabe.Teeger@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h                 | 4 ++--
 drivers/gpu/drm/amd/display/modules/power/power_helpers.c | 4 ++--
 drivers/gpu/drm/amd/display/modules/power/power_helpers.h | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 025ab521be25..edf4df1d03b5 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1126,8 +1126,8 @@ struct replay_settings {
 	uint32_t defer_update_coasting_vtotal_table[PR_COASTING_TYPE_NUM];
 	/* Maximum link off frame count */
 	uint32_t link_off_frame_count;
-	/* Replay pseudo vtotal for low refresh rate*/
-	uint16_t low_rr_full_screen_video_pseudo_vtotal;
+	/* Replay pseudo vtotal for abm + ips on full screen video which can improve ips residency */
+	uint16_t abm_with_ips_on_full_screen_video_pseudo_vtotal;
 	/* Replay last pseudo vtotal set to DMUB */
 	uint16_t last_pseudo_vtotal;
 };
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index 85400ef5013a..95838c7ab054 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -996,9 +996,9 @@ void set_replay_coasting_vtotal(struct dc_link *link,
 	link->replay_settings.coasting_vtotal_table[type] = vtotal;
 }
 
-void set_replay_low_rr_full_screen_video_src_vtotal(struct dc_link *link, uint16_t vtotal)
+void set_replay_ips_full_screen_video_src_vtotal(struct dc_link *link, uint16_t vtotal)
 {
-	link->replay_settings.low_rr_full_screen_video_pseudo_vtotal = vtotal;
+	link->replay_settings.abm_with_ips_on_full_screen_video_pseudo_vtotal = vtotal;
 }
 
 void calculate_replay_link_off_frame_count(struct dc_link *link,
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
index 43ceeec417f5..cac302e8fa10 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
@@ -62,7 +62,7 @@ void set_replay_defer_update_coasting_vtotal(struct dc_link *link,
 	uint32_t vtotal);
 void update_replay_coasting_vtotal_from_defer(struct dc_link *link,
 	enum replay_coasting_vtotal_type type);
-void set_replay_low_rr_full_screen_video_src_vtotal(struct dc_link *link, uint16_t vtotal);
+void set_replay_ips_full_screen_video_src_vtotal(struct dc_link *link, uint16_t vtotal);
 void calculate_replay_link_off_frame_count(struct dc_link *link,
 	uint16_t vtotal, uint16_t htotal);
 
-- 
2.47.1

