Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 776B8D2E010
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2024 04:54:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E98E10E727;
	Wed, 23 Oct 2024 04:54:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VDDmtjSE";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCB2D10E727
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2024 04:54:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lubsMaaYKn+gxOzYZiCzQun16ZFuTtJ9768PK7z36NzUgJwUxhjgi+WTN0LsQhDLepkKoEptyXTn8RxFc0VkzrrrcNm7slRdw9ZK5cjUVxgQad2Od7Ie/q5ngkOhvLYWtFkDtPO67/Ow/o07Zhzl7XgnuYm55+pjmHhwDP8Z9elvNLWZLpbGcCxUpiX/kCFrKVHjhn8pCUDI0m8eLYe2/iTieQiCQc7/3AuZVx23JEzRKgaRJTHhPBNr1bP0soWdTKTCoY0XqPSbxP2cfwMxi2uL+fzoEVVkRgV5uljvrL8BKeQITtjEq335mGuYIEfsuP45tF4O4FSrnd47/J9aWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDzumMgVuxAzjm65f52jzw7doOW3eBWEZ4NOV9JPUec=;
 b=gaaDOeBWFYfa5UdhTQfySCCvo8v7bnnD71doPl5itNsuvNP2zQ3t/lBbjx3A/fVQxu5lECuCVtsVC8dofJ7wMzZyCH8ZkaE41BWdc+qE1WIqIZbZEC9uM1WmelMZnM7nDUyd//LmoZxiiL5hJ4WGQZ0lEEtXO0a1Gdq9hya4ZuFuk2WYvwaUk4D0muZ1eaHrwFhGQ7TQ0SeWu/i/Iy2Se2bysfyW+PCy9IzKmUwBuGVQ7Wh8bk0Og+BXXmEe72CilC57hIh8RtKcM0LWFcpVbIFj5BU3FEG2e0Fv3gHtjM75yuDGJirk3l8RSE4DwxEeAxE+K+5B1xyCX+BIdsOS4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDzumMgVuxAzjm65f52jzw7doOW3eBWEZ4NOV9JPUec=;
 b=VDDmtjSE95/AQhjVYPYA3GycuzxUaj7xystdxpq4zkMEWIy8uExDZgXT6hq5XoINVawK2jjcsFR79b/XGAy8Pg55vSp8XQG+ko0MYhebN3FU8wJNHoTD+oUszAU35OnTq/abcOVzgSVE3O0vVTOij3N82MWt45Tlyk9ck8U0d4s=
Received: from DS7PR03CA0089.namprd03.prod.outlook.com (2603:10b6:5:3bb::34)
 by DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.17; Wed, 23 Oct 2024 04:54:54 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:5:3bb:cafe::3e) by DS7PR03CA0089.outlook.office365.com
 (2603:10b6:5:3bb::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Wed, 23 Oct 2024 04:54:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 04:54:54 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 23:54:53 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 23:54:40 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Oct 2024 23:54:36 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 12/16] drm/amd/display: Fix idle optimizations entry log
Date: Wed, 23 Oct 2024 12:53:32 +0800
Message-ID: <20241023045336.1557443-13-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023045336.1557443-1-chiahsuan.chung@amd.com>
References: <20241023045336.1557443-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|DS7PR12MB6288:EE_
X-MS-Office365-Filtering-Correlation-Id: c6a24084-5e97-42d9-3a51-08dcf31ed60f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hiTlI0cuskuiH6t2JffB605Ut4mUZhHVOxmnQycORJpNeN/yx06KqtLbQSgp?=
 =?us-ascii?Q?pGS8/e4PBsSNdQODh6mHJKyu6z2lWWRXWCKWt5wvzXD9WaDippF/CXT6vNKv?=
 =?us-ascii?Q?YOVdZCq/fiq6WQdzPu4Dgt867K//wx/s7bg0icPX/dYikbFRNchasgd5KbYZ?=
 =?us-ascii?Q?6l1iHSQMcT3n07tKqzqkm77UzEVa3Cu94TpfmhrLsCkDFdjqy9EaX0TaOo4E?=
 =?us-ascii?Q?L/qqnFbpxqHiM8QGpe2zIS1qaqFrwaHZDhldE0hOaG6VLSLldRKfMlRouZkQ?=
 =?us-ascii?Q?x0Xfb9U6dDJmugb6Hz8cEFiyG0Epibr0K1nAzI5fUOOx+xU8mwYNTsJL5rkr?=
 =?us-ascii?Q?wrMO34LFx4ldsotYvdZn8TsC5O9EnY5SefCnrzj/CbrctW/lVz1KlXerRbbG?=
 =?us-ascii?Q?TJsfPPS3ypol6tqovf0eneJfJd18DcFhE9/60kz9jkiet4PGk55nVET+lAKq?=
 =?us-ascii?Q?SJJVuQnuZsVaiWVdwZPJ6cmhDX9HrCp0og8eyWchWR7huCCXPFU4A9nn/xWn?=
 =?us-ascii?Q?lqa2h+BqqY3JDgP8/4qHjxUmxyRo0kEvWeUd620ZG0yik76xNzO8sPdc6IlQ?=
 =?us-ascii?Q?Rrhpn4OEHeGphepYRg8pWONr3oG+h8TC3OMrAXZIWkN2PYKtNc6n77zLAQ48?=
 =?us-ascii?Q?whRrHTRO7znxUjBoXrGM6nt+FyWkdIjm0q5Q7g+0gxsMeySYn13Fji1NRquK?=
 =?us-ascii?Q?iJh25hsI/YLPCYDA9z2bJEYiN/pKF+ayY+oxoMfQugwDIolwY3H4krPIwToe?=
 =?us-ascii?Q?+CL4mFijKpU0eERDrEMCmfhaQlfF6yD+qZlA1nlwHZamCbmrzQ1czIjHNtos?=
 =?us-ascii?Q?0e9hipuk0zu7TkBW417Uh/IKVFDdyKlFjmY9A5dCc9G6IOUoUgcoKgv2JHpK?=
 =?us-ascii?Q?Es/XHcjGVOIfi4Nq7CtasSx6Tds82BmIUoWBokarYXTPAwLXSwpl2YErtD5U?=
 =?us-ascii?Q?WWCNRO4sN+ISZBvIBa0MAC48iH3q/L/ApmoSOocf16nbbXfkE4qnUVDQM9SZ?=
 =?us-ascii?Q?QNfz2jHsfRda1Oo7Mfpq2x0l6zoqTjJXtmSnqeN3GrglOUvUYdK9WsjG69Fs?=
 =?us-ascii?Q?q5kadHtS15szPRL0oYILYkaOm9FVuMOlNpvRDjoU3Q1Zu5SrretgmZ/V00BX?=
 =?us-ascii?Q?AnjKqdTeFpfNcEpX+bYvGc83dBo9SexRY/enIb5stxRFPzHCA2igAOUDPsH/?=
 =?us-ascii?Q?mwNGIleCo0n64HZGggoAPCm8h7XaSQmlz5CfVq5UejD+XayE184q4t8l/HKq?=
 =?us-ascii?Q?ymASIl0e1YRtjp5U7sTWGuJji/I3K59ixzoaewZ1yQZ81UtfVVWyphomDpya?=
 =?us-ascii?Q?/6CZenx+poYJRu57wnWnCTWLjJz5YyzEeL/6KobVi9+QKqhDYrWQXGUH3qRq?=
 =?us-ascii?Q?K1cXf8Z2fqHiWlSwD6ouspTQmC4ngwojnx0w5FUPQF/M3zoLnA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 04:54:54.3627 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a24084-5e97-42d9-3a51-08dcf31ed60f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6288
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

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why & How]
Whether we really enter idle optimizations are decided within DC.
Printing into dmesg before calling the DC API gives an incorrect
indication that we are entering idle optimization in cases where its
disabled manually.

To fix this, remove the print in DM and add them in DC

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 8 ++------
 drivers/gpu/drm/amd/display/dc/core/dc.c               | 8 ++++++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 171099a3ea05..8b5bea799a24 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -252,10 +252,8 @@ static void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
 	else if (dm->active_vblank_irq_count)
 		dm->active_vblank_irq_count--;
 
-	if (dm->active_vblank_irq_count > 0) {
-		DRM_DEBUG_KMS("Allow idle optimizations (MALL): false\n");
+	if (dm->active_vblank_irq_count > 0)
 		dc_allow_idle_optimizations(dm->dc, false);
-	}
 
 	/*
 	 * Control PSR based on vblank requirements from OS
@@ -274,10 +272,8 @@ static void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
 			vblank_work->stream->link->replay_settings.replay_feature_enabled);
 	}
 
-	if (dm->active_vblank_irq_count == 0) {
-		DRM_DEBUG_KMS("Allow idle optimizations (MALL): true\n");
+	if (dm->active_vblank_irq_count == 0)
 		dc_allow_idle_optimizations(dm->dc, true);
-	}
 
 	mutex_unlock(&dm->dc_lock);
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 5a12fc75f97f..8a52fef46785 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -5429,8 +5429,10 @@ bool dc_set_ips_disable(struct dc *dc, unsigned int disable_ips)
 
 void dc_allow_idle_optimizations_internal(struct dc *dc, bool allow, char const *caller_name)
 {
-	if (dc->debug.disable_idle_power_optimizations)
+	if (dc->debug.disable_idle_power_optimizations) {
+		DC_LOG_DEBUG("%s: disabled\n", __func__);
 		return;
+	}
 
 	if (allow != dc->idle_optimizations_allowed)
 		DC_LOG_IPS("%s: allow_idle old=%d new=%d (caller=%s)\n", __func__,
@@ -5447,8 +5449,10 @@ void dc_allow_idle_optimizations_internal(struct dc *dc, bool allow, char const
 		return;
 
 	if (dc->hwss.apply_idle_power_optimizations && dc->clk_mgr != NULL &&
-	    dc->hwss.apply_idle_power_optimizations(dc, allow))
+	    dc->hwss.apply_idle_power_optimizations(dc, allow)) {
 		dc->idle_optimizations_allowed = allow;
+		DC_LOG_DEBUG("%s: %s\n", __func__, allow ? "enabled" : "disabled");
+	}
 }
 
 void dc_exit_ips_for_hw_access_internal(struct dc *dc, const char *caller_name)
-- 
2.34.1

