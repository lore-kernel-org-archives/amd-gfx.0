Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E08C54E65
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 14:36:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0854F10E7C5;
	Thu, 22 May 2025 14:36:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u8c7HWo7";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20E9710E7C5
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 14:36:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mf1tolPVbGvK2DqNzBqOPCfXL1pBqDE41jJNmUpDHHTt+S6BAUS88iOwR7AWB/SJlgxHNyv349jjfa3PjxJsQp9m9fjW3ZPAKD/PdYLcX4lp9drH4uSTMKxVCT8AOeDO5aPAXMVVzhlDT+DiuhcMo/pZ4AjODsT93mk5vVcaKfcwjC/oam85c5EIpMTZgD0P58oZm1KBoPlAuRFnKFwlsTy7DNS1Kl4x6W4xnf6xRoPSPjazPZ380+9dcrIrV5jEhep+t6t9H/Ecq0Q+ClNIfW0cZF1NtpGdr7xE/QYNkYCuCcpuorFVe4pCkr83/BKHPhO+ggufBe+puYQYllGfAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=paPPbxK08g+BTf9sD2hlvE4h+wtlQwnkZHvUv2yqyfs=;
 b=EJ7SPKiw34vZyYa3bLNGEjKy6zFUsP6yp6LuEdTTTB6v0tg91t4ID54qJN341g/JIKRHl/WEeiXYyg9dVo+NIdQN2/MaJomWurc7ILKbnLK9L31/fny8EkRUNrv+6qy0Z1gGQiarL6LdYNdQMp8nvE0/7IzmVjXSBbvgSmK4qnWgNgP6OGB7R4fO2gN+/uQVD1XhgEu0hTJnTek5BW2nOx5tPfNNlcvGhjrzrHNJShyLqnDxWLhXF7zgdmOqGypZlgB4ZiC5iWIcbJY0z7fL7xaey35G6U0oX02wpvOrR4/XkG1A0lLTvPjxh35ErU1zErd/efVDHHzuKZjeUmcEhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=paPPbxK08g+BTf9sD2hlvE4h+wtlQwnkZHvUv2yqyfs=;
 b=u8c7HWo7Ti3A3WdEHdbzbUNv1FSgtsM7IdpX7QBSp456NHHBbJcHBt6GjHNFwyWW0CFKgB1V9K29/4lTm9tqXTj0Fv84LubkEh/JJ1g5IRTtcvDNDmgmKzfgiLwknGoPs0UxAOTj0d5tmA3cZkU38d5cYBKksMbYJqiSb+BGXxM=
Received: from CY5PR19CA0015.namprd19.prod.outlook.com (2603:10b6:930:15::12)
 by CY5PR12MB6647.namprd12.prod.outlook.com (2603:10b6:930:40::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 14:36:46 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:930:15:cafe::11) by CY5PR19CA0015.outlook.office365.com
 (2603:10b6:930:15::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Thu,
 22 May 2025 14:36:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 22 May 2025 14:36:44 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 May
 2025 09:36:44 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 May
 2025 09:36:44 -0500
Received: from aaurabin-z5-cachy.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 22 May 2025 09:36:43 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <sunpeng.li@amd.com>, <harry.wentland@amd.com>, <alex.hung@amd.com>,
 <alexander.deucher@amd.com>, <aurabindo.pillai@amd.com>
Subject: [PATCH] drm/amd/display: Reuse Subvp debug option for FAMS
Date: Thu, 22 May 2025 10:36:43 -0400
Message-ID: <20250522143643.116897-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|CY5PR12MB6647:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d7096f9-bf8d-4589-1f44-08dd993e136d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H/iQmQRFAGFddUt0OK3qlIi5k30iRrqANsQ1LfcO0ZbEKilpxnwhW2bxS3G2?=
 =?us-ascii?Q?Eh2Hsje8ubRmP/VazobcDGb2jy6Gp4iZjkjYgKM+QaQPHVxuW5fs9+gCV5ym?=
 =?us-ascii?Q?r/32VNbCgEATwx1zMIXhmtrYI3//yP4LhSQ5172lGkVtnY0sEPCRfhjl2yAw?=
 =?us-ascii?Q?9P6EIuhG/fYMohpueHvLpmXWN3Pu9q9yn8XSR3A7WMOe2Wg30OvSWrKdH5kK?=
 =?us-ascii?Q?Rp6cvIOXAcauak5Q+lGFBp8piUrgziVfipeUDOGCrpIBmR9qD9zUJs2f+dVD?=
 =?us-ascii?Q?V7NJq+F33ZNKh13At5IOSR2oX53nk4v+FLkTps3s1tFXIo9xL0eQBYcMEGmg?=
 =?us-ascii?Q?fmI2FZvpoQXtrybYF0YVPv1ykdndWZdnmFHPQl9UKqV2h11gfTmlAWYKYR6u?=
 =?us-ascii?Q?eVrmCbv4RKM4VS+r2wGfAWFuhBPp3N/IMDE8fYwUmh94bcCm08KUJe6xNRHd?=
 =?us-ascii?Q?qwP9dMjiMjUQ9dD8lEExeeVGmBmmb291QfScCic6HE9aOBm0sjmvWCrjw2Mf?=
 =?us-ascii?Q?tVZrlS+nh78xUOGNsG9t9CVvkM+lBq25Xe8x38t+byZgs2E+uPOWPr6zpwGX?=
 =?us-ascii?Q?38OJGfcrKOknsVrTpS7OfZ1++gbA/+BM6vIj7bn+y0slDAlII0dsrSXpHiZw?=
 =?us-ascii?Q?WAcjl3IVKY5tN83ic6upHc4exaQVHKoTqigGgDLfvA6cphkW3FVkgaym2UoR?=
 =?us-ascii?Q?4BxeOZRhCq2qX7RFeTXnYeDqyw5qhxzU7o0XPPlZIneGmN3YPDQeLB6oKszq?=
 =?us-ascii?Q?1E009bRssZIdt3f3GJvrERFuy8mbu76vAKQKc7t5/yIMAsRZGpNCtMAR3bHC?=
 =?us-ascii?Q?bpZOqfw5IY9v7QwwcYPKd8e64pQeyCeqCA801RecnX53kVGqcJ0IG/m0RYpL?=
 =?us-ascii?Q?8TPDHJNMijFqD0yAq2ot7LdqTF0nIleOXSfw5GVxNlOuBe3UvJci2x6rRv/K?=
 =?us-ascii?Q?/eBa3m2KBiRpVMfT/iZ20C/S3t6hA+KHrLSYHiIdi6oFSCNHWDcGyzlUOPyk?=
 =?us-ascii?Q?cwL8sMq2Mifs/uH9XS8Qiiht81DwpeKrVFctdsr4dvLQXs3Zk9geom6a0EZb?=
 =?us-ascii?Q?Kp/4S3cDobY9Z0msWOatdD1J9+QbPa5o1eeHoJ5BMBCtgbRjAfXkcBNirJRk?=
 =?us-ascii?Q?lSs9mYrSsmJ6ZIEJXyjG5/w0rriJJjIsshPeojmLeFvltmsf6EzUes5h9XrG?=
 =?us-ascii?Q?MoI5Hlun0J7YXa+XFoXLpvyJWK+eGkht8kGe5jTonOmCmGIGAkL6+oIN0odA?=
 =?us-ascii?Q?llSuR7PlQ/Fkfb3P3zDfTYJ1TIWbD5T+BajNkx/hvBOmRc6faRHAxB1WiNH1?=
 =?us-ascii?Q?yqiDvjxAZDTWURllP8yYUs602yvw0IqIN61+/I7rA7XBQphihCJba0I62wwL?=
 =?us-ascii?Q?y1H0sAUimfZxWXXasjCyuUp29910MLUtHD/xxnLLQyCMfk6ZaS2YlVhLS2VQ?=
 =?us-ascii?Q?K9d+oNrWaBzLuCBA7NeeK9va+aPATHy8DSb8/68v/XhNjj+oeYNEUJ+v70qG?=
 =?us-ascii?Q?uewxbm72nfjkcvNFFnsebXx7zTzahZSNu7G3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 14:36:44.8434 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7096f9-bf8d-4589-1f44-08dd993e136d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6647
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

FAMS is the successor to SubVP starting with DCN4x. Reuse the same
debug option to disable FAMS for debugging purposes.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 +++-
 drivers/gpu/drm/amd/include/amd_shared.h          | 5 +++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index acb5a6baabf4..8a1bf7ab8570 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2000,8 +2000,10 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	if (amdgpu_dc_debug_mask & DC_FORCE_SUBVP_MCLK_SWITCH)
 		adev->dm.dc->debug.force_subvp_mclk_switch = true;
 
-	if (amdgpu_dc_debug_mask & DC_DISABLE_SUBVP)
+	if (amdgpu_dc_debug_mask & DC_DISABLE_SUBVP_FAMS) {
 		adev->dm.dc->debug.force_disable_subvp = true;
+		adev->dm.dc->debug.fams2_config.enable = false;
+	}
 
 	if (amdgpu_dc_debug_mask & DC_ENABLE_DML2) {
 		adev->dm.dc->debug.using_dml2 = true;
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 31de36c9156f..11374a2cbab8 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -351,9 +351,10 @@ enum DC_DEBUG_MASK {
 	DC_DISABLE_HDMI_CEC = 0x10000,
 
 	/**
-	 * @DC_DISABLE_SUBVP: If set, disable DCN Sub-Viewport feature in amdgpu driver.
+	 * @DC_DISABLE_SUBVP_FAMS: If set, disable DCN Sub-Viewport & Firmware Assisted
+	 * Memory Clock Switching (FAMS) feature in amdgpu driver.
 	 */
-	DC_DISABLE_SUBVP = 0x20000,
+	DC_DISABLE_SUBVP_FAMS = 0x20000,
 	/**
 	 * @DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE: If set, disable support for custom brightness curves
 	 */
-- 
2.49.0

