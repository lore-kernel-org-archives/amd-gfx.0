Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76069D5CCA5
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 09:58:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10FB210E5E0;
	Tue, 16 Dec 2025 09:58:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FmltTSQG";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013039.outbound.protection.outlook.com
 [40.93.201.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFEE710E58C
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 09:58:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SglRJcnE/mRyl1yfIqJ5vDvz0A4jY6G9YomKtlMB9LQxF1NhB0NfL+avcm09Z1le2js6ULzqLbfseMe7knyHTum+KqqLgn5VJ4AlxjmIQ93GPeNqNMHifXOIK7TfJdoyKJT2zJOp2vKRrduQxiOT7To98O72ycW+Z/aBy+MiFSs1g4cgd0j/ggPCNM+rahtBRtcjJ0BXE4PNGvk1uTz/ZIasMkGF/7PPAUGzGbN/EbzQ6CQaau4hBrwjPUjPD8/QDIfy5b+SguUVVoS/9HtN91LvM7v8eddUTZ6qqPDS46t4EXtTxDFiYaZKpt/leaHyMrwI+rjBnkTooQgqjSJ8tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MlTd8S0t/iUanPDYRAUi8PnFgzagpPZhZiAUsMndsE=;
 b=gwDGn3ITgC43f/iXjBMS4dMkrLH47ZltjHaiE2/Tawgz9h6+Bmq0cLZZPNp7txnl9AnTxHq9K2rJK5Zbq04Xcfj7969XqCvercDy/4lkHUOHUkFLpMnjvImIeHq+JGVhbgv0JVZPOnezv5gYrYys8wq33U5p7ZKKOPj6gP70E0qv3fOtpPFk5LLHNI2tKvwLEc9YC07Xw5N/W3fjDAVKF3RD2m2HqNV3FPIy8oe6silEKAakWomvHQjoClZ4ZuBy3oiomOi0k/ULRjfA85SvsSYRjuHgNLWg2yNBB7qSe1kfeVpOI2miFI2zWAqIJ+gEDUeL6K/vMZU9mgk9aYvUWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MlTd8S0t/iUanPDYRAUi8PnFgzagpPZhZiAUsMndsE=;
 b=FmltTSQGPlj19tsnVHQbpExFSq0KVqZGO9tp1Q2lejdb+euhLqZfyz6kMqaZnx7zeJEtIFuHDgOjtuh4UYvSnBEl0TRB0Al+kB7/QOkiF/8OLFYYGgUXP0dhKEzl2ymujnMxhBLs4h5E4xMcCv0/FQflkLiUqF1DN06Zh7hulRE=
Received: from SA1PR05CA0004.namprd05.prod.outlook.com (2603:10b6:806:2d2::29)
 by CH3PR12MB9121.namprd12.prod.outlook.com (2603:10b6:610:1a1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 09:57:57 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:2d2:cafe::bb) by SA1PR05CA0004.outlook.office365.com
 (2603:10b6:806:2d2::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Tue,
 16 Dec 2025 09:57:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 09:57:56 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 03:57:55 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 03:57:55 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Dec 2025 01:57:52 -0800
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 07/16] drm/amd/display: Consolidate dmub fb info to a single
 struct
Date: Tue, 16 Dec 2025 17:56:07 +0800
Message-ID: <20251216095723.39018-8-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251216095723.39018-1-chen-yu.chen@amd.com>
References: <20251216095723.39018-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|CH3PR12MB9121:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cdadf78-de93-445c-40d4-08de3c8996a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FDPev1fn3I1ZnDI+rZW+SXu0D2K1CVkUQSYuaMM9On9dLvwmqkvmmg8Lognu?=
 =?us-ascii?Q?fwiykGTt0yMw+vkM9GHbxRzagk21LJv6JzHhD1FiVmhvHfn/MoAJZ4ivSniQ?=
 =?us-ascii?Q?4vmVqgPS90/hy2H90r+8BspoEpKK73xprdgKmIxm4sBGQehoQmRaPg810JFQ?=
 =?us-ascii?Q?NfNU3BSj1s3HJoYUFsqMARtSopvKl/kYjwB2GZunzVO29B/qjbJXDd+ATsuj?=
 =?us-ascii?Q?JOaH2jeuEmcxT8JjwcVJp7YY0Hcwzluz162FVs9VrxNJYuwnYydnwmI92sce?=
 =?us-ascii?Q?qkUd5yobz51KJrYOK4ZU1utmgote+HyaBsM+FKzeHp9VvgemW6lGPn28Hhek?=
 =?us-ascii?Q?Piu01TRSqc7o2uwtgETuhkApZmjplk7UTEP1bMv2BjAGFRV81XSWrRdISZIt?=
 =?us-ascii?Q?IJIlRdUVPP7g2W/bfWSIii2b1GG8kn2DJ+XgKuOW/31/EvvqaRUFoVpWdnTb?=
 =?us-ascii?Q?S82bIpiqrb3iqhY048I1quRbgWiHTWsUEOwnB5s3NSuzjuAXq9KcfqyfF5xC?=
 =?us-ascii?Q?u2vd5jnt2+MuZ2N5Nh+NkVtka9mbGGDaLKjDPtRPnA1+FIEzwdFTkP7sz0Pu?=
 =?us-ascii?Q?Ae9BeFKSZYE5kpcYZp2BxcPAeWiUfk4vVJgq8IWpbejWKwNhGVs1bu88Bu50?=
 =?us-ascii?Q?hghZU78bcGFwcTfwXkF3Hat4Erp93vSfnU1FW8phsx5W9dhP6MlNcUbbI5xq?=
 =?us-ascii?Q?MxAbgrumiHrRSsaOQXkDZ8395p80xkgxky/V6oX7dFwHgOGEkgmaDbCjAHyj?=
 =?us-ascii?Q?PziP7X/AvIgup27ondqaWfrGOsMiG2n20BJSc0Z+rvOOkb/yAf/2bi7hlkIi?=
 =?us-ascii?Q?08RMfU4G1MmiaAdkgL3eRrhPCU0DZbRY4OfnrJ6BmJXkOrGPApF90oL8+nv9?=
 =?us-ascii?Q?XRc+VB3/045jDUv8PuLd8GY7uZ7R0FpaVmet5WHsrUbhSOWNT3N4Xle8Y/1L?=
 =?us-ascii?Q?LxNeFGDQ/8Khl0ztvrevhUkkXimbPF/O1vpYOex5y9ltW2SVu0HvtSspqeu9?=
 =?us-ascii?Q?dqFvHSvnPDHKjAWmUvpErqMrT65K5glpV+rk3kqtD8KgTZWeFjLdAL0HXVxc?=
 =?us-ascii?Q?6G+OGPup9dh2dyPuS8rJJqj0lyKqyZVxUwPTQi7YrL3FGamg4s+Z7L+ocBR9?=
 =?us-ascii?Q?B3FCRdCBjDtyldHWv1QkPibwNk2jUTL/PrH0bMVMmM1gZsqkzDI++1u8YDst?=
 =?us-ascii?Q?odwGVTC6H65UKNr6QYUBTM0NRJhLW5/LYDGp9iLGAf8h0ATNwksw8FupS812?=
 =?us-ascii?Q?STQjH0xvmh+dMnpNA1rRau+Yjh4WXzxpl1aAZncVDewkrDMKrIqZOSOnlR+t?=
 =?us-ascii?Q?vbviksF06uHBRZ6A3ftjHPnzyTG7gGEjEpVJgPI5I5bIJbRnRxZ7goORxXfG?=
 =?us-ascii?Q?+sBCgDQ4HVWJwadwRNtcX3xPIV99v7hz485Lfa50mlLWlQ21Foy3mtGH/3z/?=
 =?us-ascii?Q?K4sgmxu/uCl9F3qLT1YmmwYRLiaQADkdSpdSF01YX07BTvueDwMuIK0WMVCT?=
 =?us-ascii?Q?1KOeexdTIHjVSW72vzx0s8+eYkDYmn4oG3jYlcRsH1toPoLF/DDCXLDP6zhH?=
 =?us-ascii?Q?8mIYy5WG5tzscJfVGBo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 09:57:56.8547 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cdadf78-de93-445c-40d4-08de3c8996a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9121
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

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY&HOW]
Consolidate dmub fb info into a single structure to simplify translation
between components.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    |  4 ++--
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h      | 16 ++++++++++++----
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c    |  6 +++---
 .../gpu/drm/amd/display/dmub/src/dmub_dcn30.c    |  6 +++---
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c    |  6 +++---
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.c    |  6 +++---
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c    |  6 +++---
 .../gpu/drm/amd/display/dmub/src/dmub_dcn401.c   |  6 +++---
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c  |  3 +--
 9 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0346052f2e57..d66854e7f18f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1336,8 +1336,8 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 
 	/* Initialize hardware. */
 	memset(&hw_params, 0, sizeof(hw_params));
-	hw_params.fb_base = adev->gmc.fb_start;
-	hw_params.fb_offset = adev->vm_manager.vram_base_offset;
+	hw_params.soc_fb_info.fb_base = adev->gmc.fb_start;
+	hw_params.soc_fb_info.fb_offset = adev->vm_manager.vram_base_offset;
 
 	/* backdoor load firmware and trigger dmub running */
 	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP)
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 12c1f9f7115a..3b6bba017040 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -307,6 +307,16 @@ struct dmub_srv_fb_info {
 	struct dmub_fb fb[DMUB_WINDOW_TOTAL];
 };
 
+/**
+ * struct dmub_soc_fb_info - relevant addresses from the frame buffer
+ * @fb_base: base of the framebuffer aperture
+ * @fb_offset: offset of the framebuffer aperture
+ */
+struct dmub_soc_fb_info {
+	uint64_t fb_base;
+	uint64_t fb_offset;
+};
+
 /*
  * struct dmub_srv_hw_params - params for dmub hardware initialization
  * @fb: framebuffer info for each region
@@ -317,8 +327,7 @@ struct dmub_srv_fb_info {
  */
 struct dmub_srv_hw_params {
 	struct dmub_fb *fb[DMUB_WINDOW_TOTAL];
-	uint64_t fb_base;
-	uint64_t fb_offset;
+	struct dmub_soc_fb_info soc_fb_info;
 	uint32_t psp_version;
 	bool load_inst_const;
 	bool skip_panel_power_sequence;
@@ -610,8 +619,7 @@ struct dmub_srv {
 	bool hw_init;
 	bool dpia_supported;
 
-	uint64_t fb_base;
-	uint64_t fb_offset;
+	struct dmub_soc_fb_info soc_fb_info;
 	uint32_t psp_version;
 
 	/* Feature capabilities reported by fw */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
index 73888c1bea93..54df2147e4dc 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
@@ -63,9 +63,9 @@ static void dmub_dcn20_get_fb_base_offset(struct dmub_srv *dmub,
 {
 	uint32_t tmp;
 
-	if (dmub->fb_base || dmub->fb_offset) {
-		*fb_base = dmub->fb_base;
-		*fb_offset = dmub->fb_offset;
+	if (dmub->soc_fb_info.fb_base || dmub->soc_fb_info.fb_offset) {
+		*fb_base = dmub->soc_fb_info.fb_base;
+		*fb_offset = dmub->soc_fb_info.fb_offset;
 		return;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c
index a4abe951c838..84a6eb3f677d 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c
@@ -63,9 +63,9 @@ static void dmub_dcn30_get_fb_base_offset(struct dmub_srv *dmub,
 {
 	uint32_t tmp;
 
-	if (dmub->fb_base || dmub->fb_offset) {
-		*fb_base = dmub->fb_base;
-		*fb_offset = dmub->fb_offset;
+	if (dmub->soc_fb_info.fb_base || dmub->soc_fb_info.fb_offset) {
+		*fb_base = dmub->soc_fb_info.fb_base;
+		*fb_offset = dmub->soc_fb_info.fb_offset;
 		return;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
index cd04d7c756c3..a0cefc03b21d 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
@@ -59,9 +59,9 @@ static void dmub_dcn31_get_fb_base_offset(struct dmub_srv *dmub,
 {
 	uint32_t tmp;
 
-	if (dmub->fb_base || dmub->fb_offset) {
-		*fb_base = dmub->fb_base;
-		*fb_offset = dmub->fb_offset;
+	if (dmub->soc_fb_info.fb_base || dmub->soc_fb_info.fb_offset) {
+		*fb_base = dmub->soc_fb_info.fb_base;
+		*fb_offset = dmub->soc_fb_info.fb_offset;
 		return;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
index 7e9856289910..2f99a2772599 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
@@ -65,9 +65,9 @@ static void dmub_dcn32_get_fb_base_offset(struct dmub_srv *dmub,
 {
 	uint32_t tmp;
 
-	if (dmub->fb_base || dmub->fb_offset) {
-		*fb_base = dmub->fb_base;
-		*fb_offset = dmub->fb_offset;
+	if (dmub->soc_fb_info.fb_base || dmub->soc_fb_info.fb_offset) {
+		*fb_base = dmub->soc_fb_info.fb_base;
+		*fb_offset = dmub->soc_fb_info.fb_offset;
 		return;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
index e13557ed97be..6a2d35756c8c 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
@@ -63,9 +63,9 @@ static void dmub_dcn35_get_fb_base_offset(struct dmub_srv *dmub,
 	uint32_t tmp;
 
 	/*
-	if (dmub->fb_base || dmub->fb_offset) {
-		*fb_base = dmub->fb_base;
-		*fb_offset = dmub->fb_offset;
+	if (dmub->soc_fb_info.fb_base || dmub->soc_fb_info.fb_offset) {
+		*fb_base = dmub->soc_fb_info.fb_base;
+		*fb_offset = dmub->soc_fb_info.fb_offset;
 		return;
 	}
 	*/
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c
index 95542299e3b3..16ed07f0e96d 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c
@@ -39,9 +39,9 @@ static void dmub_dcn401_get_fb_base_offset(struct dmub_srv *dmub,
 {
 	uint32_t tmp;
 
-	if (dmub->fb_base || dmub->fb_offset) {
-		*fb_base = dmub->fb_base;
-		*fb_offset = dmub->fb_offset;
+	if (dmub->soc_fb_info.fb_base || dmub->soc_fb_info.fb_offset) {
+		*fb_base = dmub->soc_fb_info.fb_base;
+		*fb_offset = dmub->soc_fb_info.fb_offset;
 		return;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index be893531ae7d..019eb005bba8 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -709,8 +709,7 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 		}
 	}
 
-	dmub->fb_base = params->fb_base;
-	dmub->fb_offset = params->fb_offset;
+	memcpy(&dmub->soc_fb_info, &params->soc_fb_info, sizeof(params->soc_fb_info));
 	dmub->psp_version = params->psp_version;
 
 	if (dmub->hw_funcs.reset)
-- 
2.43.0

