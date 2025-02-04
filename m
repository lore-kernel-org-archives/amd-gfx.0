Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53459C02198
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Feb 2025 07:14:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F405A10E59E;
	Tue,  4 Feb 2025 07:14:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GGa8rPE4";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAE8310E59E
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Feb 2025 07:14:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oUV7fg/V81q+0G5A1Pls+dvxOyupaitWCYM+0a0k/qZLI6fafaEow4GTKyY1R0ZMFMGzk4yIKkFOpA3NshMsnI9mF34Z9jVyk6dFUYRG+6ouNPKEZSNRWZ8Ve7GqPFcIYYjgnz/4fRMBAaG9pJoZRuGHmErLvT7EhwR3FO4bVKJocsQ0O7xEejOK1Hn8YO5jvk1b14flsFvx4GaEitNfgFkEJm4vBWlUK0xqHqIcD9WRxhOUopJDDw8uHSWgISunKGT+kO/dJgOIcJRFlIxei/gW4iXRu3qFQhOlgLdkzIOq0XmuFPwoOE0W9Q9XOxGHDi5Y7yECoz9vOJECQV1JSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5LFQ3WJhy1Db13JqDO8ZSMZPSmHyudEB/OG8RQbmb8=;
 b=aCRlWnhZcmqXXKwUI5Kt856mh+G93KFPBm1nx3k3q/q6P2KgYvMB76UNu+VvmigK4Li7rz2CmornZwhQhG6snvXBvSWi/hwmMLMYKgtTnkESg8hOXD1N0lgdSN4IRrnCWO55YSrTvsnoukiJF6H+OyPHuTnPR2/B+kHvr+COko9CespuI00OuyshmMrQXjQGbOHVcQRJ7UBQcoriGcEDFVj+QyI5d9kymuC55Jnf3dPJ4zay0bBjkwbZn372ZQ4rJ0005y1A9/tw2n569Md/gTTl9Lk2/B7Onu20csElbkTaH1C2m6onk5q7y2ddsmC7eTrcM6osO6iUU/ejyG1f2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5LFQ3WJhy1Db13JqDO8ZSMZPSmHyudEB/OG8RQbmb8=;
 b=GGa8rPE4piUDRBuwYU/4GjiCP9Ir9Xj1+q/FxJ4pLAJeFIopVGQ/wnCxHIGdq+LbEBmvez5lWBGHbvm0IT0gIGh7h7m2lB06pR4TQeGJiTk99wdKG8c0x5TzfZ2HXIfNIR2013i45loEk/qhMkBq64d49kTrzT2waoDAu982gkY=
Received: from DM6PR07CA0076.namprd07.prod.outlook.com (2603:10b6:5:337::9) by
 MW4PR12MB6999.namprd12.prod.outlook.com (2603:10b6:303:20a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Tue, 4 Feb
 2025 07:14:02 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:337:cafe::1c) by DM6PR07CA0076.outlook.office365.com
 (2603:10b6:5:337::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Tue,
 4 Feb 2025 07:14:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 07:14:02 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Feb
 2025 01:14:02 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Feb
 2025 01:14:01 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 4 Feb 2025 01:14:00 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Wayne Lin <wayne.lin@amd.com>, Leo Li <sunpeng.li@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>
Subject: [PATCH] Revert "drm/amd/display: Use HW lock mgr for PSR1"
Date: Tue, 4 Feb 2025 15:13:06 +0800
Message-ID: <20250204071306.11682-1-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|MW4PR12MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: 6695bfe4-2c16-4315-6d7f-08dd44eb80ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u8BZROXCS1qs7U3XAYioeTuO1XBrV61+RxqU2TTEFn5/7SkV0IyBvdxwOgBp?=
 =?us-ascii?Q?oVqHp4lcv2QIF1a6ng7HTCvY9UcAJXbj3xEWsctEmBPgiUU3ZtvZxnQLwrRD?=
 =?us-ascii?Q?/wA4vAkcnx4mOSrUEhjso9MmaUzQA4xt4B5xc+ZJ2e4MDv+npnJnX7DryHLG?=
 =?us-ascii?Q?PfpGHt4Mso9p1U2b/KdfHWeH8j4fsy5as08emCvzPpLHh0zri39KsFD8oys8?=
 =?us-ascii?Q?tFYw0oFjAyJuleGOTTNkWGemX33faSV/jdev3PfhodsP6DyDGPBLqJNjZhQa?=
 =?us-ascii?Q?NZt+xWz0gpJEI/AruCFGlSaA8j/aYRYBSHVpBXWCU2QaVsrTR3zEkoi7gwPF?=
 =?us-ascii?Q?87MHuWXFpmf5WFjc+1i978yIvUC/DjxjFo6XdwpU2Ci242cfSZdquGc8HVsC?=
 =?us-ascii?Q?HdhzM5THIe/DGiFlXSUVc/SbHJbnUJayXuCg0AsMTjSMm6gPas/ieY7HAaU5?=
 =?us-ascii?Q?7vnzx953RrADiEtdQ428mJTXvH3lCSFslGxshUCPoF3WGA4GVWIxcYLUxSIs?=
 =?us-ascii?Q?y9eSreVIv4iD3eiM3pT1Bh9mbtI89XiczO14FaXK24p3HkJFkP4nHhAxqxOX?=
 =?us-ascii?Q?ZuS4YaFqoqCnpUTSezGvhV78kgRhttDoWLTJddZdf8OmJLNpuppuSGfXk9hY?=
 =?us-ascii?Q?T+EZQ9C6AYrAfXqJQGxQUSpMtM1p3ujOV59hb4gGb3nsbo7+tq4ycmdAPvPB?=
 =?us-ascii?Q?uk04iy2gESc7JfTjlKuLf4Ojk4SltCkip/jati7d/HSpxeHX5jjm5cRhRfjg?=
 =?us-ascii?Q?WTkWrEIZMrIT12MtSFuiN0fxlDFzC7//R1LR8EzG6+jcOow7wjz7bJ8Feh+6?=
 =?us-ascii?Q?SOB39YSVZU0gvE8GLU6hIJFHmQ8aDT1aj1oGsyRFkzgDReCHO64XtQjJtQoq?=
 =?us-ascii?Q?Fp4azrMKzuTmsLd5cYf0JfJBhYsI55aZ+Tiu/eKF18CIrmYsGyaUUVVs3hc6?=
 =?us-ascii?Q?2Zj2A1KSynad8N4fh6nsuGYz4t4APJsoqIABn7Y8YBgJZV5KKBJoBCoJv8bu?=
 =?us-ascii?Q?BqEXZOHzDxMCte0SKYg2vjLVGEIWcJ7Xgj1VdR0mVOfAyNwxlnDZ9kpvozyK?=
 =?us-ascii?Q?SfZZ3zUyOiuw2AaD9JxkLkMf6B3hgucRW5P+oWVV0pKwbKkDkNhvd5Gnjb/R?=
 =?us-ascii?Q?xWK+tEtc7behPzjZtf7CIVYoDJeUFp+2mIMHmG0etFcBr49IjDCqE2iYRaDI?=
 =?us-ascii?Q?l7bRs6QbdmoibNSeaaNfe+0HYaRsM8ZY6VsfMIH+g9+kkRWh6I261Hy5BuhG?=
 =?us-ascii?Q?6aU4L3B2urx6B283x5Ilf7ikK6QV3uuxomfOOXHNhmfc4KOAmgHEkBqoN93B?=
 =?us-ascii?Q?sW31vIluATqTYOO7LC3WEv9/VPeiuOB6T42lJbwoWcIaRVDSa+B55BXMUd6j?=
 =?us-ascii?Q?G7v2P5RN84m78oTsFksghUkLOdM6eAbRmyF1WPfNo/SvURp8xVfTzWOKIXTh?=
 =?us-ascii?Q?ujAhIgR3wiPoe71dwkLMFYJgxBocmh21Gm5M/EoaDzaGPnqroaGMnyeKT9wK?=
 =?us-ascii?Q?RIXSdb4Xke2scrQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 07:14:02.6235 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6695bfe4-2c16-4315-6d7f-08dd44eb80ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6999
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

This reverts commit
2a69ae1e1354 ("drm/amd/display: Use HW lock mgr for PSR1")

Because it may cause system hang while connect with two edp panel.

Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
index 5bb8b78bf250..bf636b28e3e1 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
@@ -63,8 +63,7 @@ void dmub_hw_lock_mgr_inbox0_cmd(struct dc_dmub_srv *dmub_srv,
 
 bool should_use_dmub_lock(struct dc_link *link)
 {
-	if (link->psr_settings.psr_version == DC_PSR_VERSION_SU_1 ||
-	    link->psr_settings.psr_version == DC_PSR_VERSION_1)
+	if (link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
 		return true;
 
 	if (link->replay_settings.replay_feature_enabled)
-- 
2.34.1

