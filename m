Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D29E77188
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2025 18:31:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7584A10E470;
	Tue, 14 Jan 2025 18:31:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jiJkAxMK";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F0A410E46A
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 18:31:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cp6EylmV79IW0ASJhg8qomlIBb2G0cibGgmJEAqU3L0rC1DnP09qaruKMcUVOZOBnhH9us3CRSGCgRhogI906Sa/R7dhi93DKgVAjSGOgE7bD9ZLgDo3fxGTd85rMt8LuwDc9/jBldg0k5PTP6u7xKEhkAFrbABQElUb6lVRxHrqaCWaan4QGWDIhvPTMfc26wc9UWHMNIpn8RGmURrxXkyzWGPmdyyAkGMuPxABcFjjVubGyaR1ExQ526donY+Ll8ZX3KV151pmZMy6aW8vW3QYFBdlCEB7GzCu/x2rVj8mk+FS9SA0OL7SeczHFq7OvdESGL0ebTTb2fhzAF3yRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+zFTFQd8Eol1LWtjJ/U/PahYNZJeVkzpd/azTj+qrc=;
 b=HE1644Vc24O9kcC+MAd8eDhQF7qSBMhnCjT5tzel9igQRbgYwO6EDtP/WQZ4tFlorrhlEfoQTzju1w4j2yL4Lysvx9X/5IP9Wak1vZrXfCtJoSF1ebq4zyUsS998+Sl7s/wi0eqmN1hMZMDeIVsR2vNkSEuTeaNOGEBqR+PTCYpH/MrNjKboZMWCxbuB5vyR4y+BsA3iooEiBZUMQZ72RcxHsP6Tkwijo02xJszE3laT+EyEBx0cv1VaNw0PEJ5kIfkBxPxuI0AIyEaMBAL66iaAsbSNW/1pgJHjlfa1s4yY02cogtsUMN7SnWrZmBfQzE6GnzCZKThL4g9aTar78Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+zFTFQd8Eol1LWtjJ/U/PahYNZJeVkzpd/azTj+qrc=;
 b=jiJkAxMKjtjLbeGQcCFs++vzOd0kVkMCQ3e6MhzFyEsn1nGQPqJVLO03CKpHcC30V+y3JgcntsHDNn55Ja9lwqxXQ16Fv6684YutqPGbrubDHgTzVndVL2KCgtPPllHpD5m5bVcFESGlTb9wkyxsShzGM610SepNKVTFXmndFXA=
Received: from BL1PR13CA0004.namprd13.prod.outlook.com (2603:10b6:208:256::9)
 by PH7PR12MB6585.namprd12.prod.outlook.com (2603:10b6:510:213::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 18:31:18 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:256:cafe::d0) by BL1PR13CA0004.outlook.office365.com
 (2603:10b6:208:256::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.11 via Frontend Transport; Tue,
 14 Jan 2025 18:31:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Tue, 14 Jan 2025 18:31:16 +0000
Received: from aaurabin-cachy.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 14 Jan
 2025 12:31:16 -0600
From: <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <harry.wentland@amd.com>, <alex.hung@amd.com>, <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: [PATCH] drm/amd: Add debug option to disable subvp
Date: Tue, 14 Jan 2025 13:30:45 -0500
Message-ID: <20250114183045.23341-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.48.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|PH7PR12MB6585:EE_
X-MS-Office365-Filtering-Correlation-Id: 479069e7-1720-44fd-d7eb-08dd34c9a22f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kWSnECORndYZpZQofZSE24kDI470ftkLTAximucyfkByPkWwD3HJui5LP7Yb?=
 =?us-ascii?Q?JjCxdNBYNfdJCnhBSutBimfqSChNd78qdhs67X86/d8GRrFJ+xn3MngXmwSU?=
 =?us-ascii?Q?3SeRZQ9sh/gj4LrRDA2YvbhybiUk5ldZbFhtKl4y7re0FszUaOKrP6CTzkuj?=
 =?us-ascii?Q?RXc2RRlTY5buqojNN+6/0FeyhPzdjur4bZMqbMXndd90CmqLTuFnWs1PBZzP?=
 =?us-ascii?Q?23XRxujnFO7YE3/pzXkPWvNfG0Wo2PhOpF275m+Lwl3HyF4AEyWIMtv4k+XT?=
 =?us-ascii?Q?fTjETc8Ya/ubbfilspDcOIRIMpJo/Uf74tVaxGxyTWLdP4DeANj6XCNE9lrR?=
 =?us-ascii?Q?CuLY6lkthX0YZCBY5cKh9KHTKQGqiFpjNDEV7HsEQr3F/qNxmLvjqX2lpPfX?=
 =?us-ascii?Q?BoFKuA9MN2XA9MZhnPwTS9HacfZKcrOXl6E+S9vWxUQPCiFtMLZJmi1bhORl?=
 =?us-ascii?Q?V+kZh02dfG3jYK0BHb1HTYOiCHexe/vX7rjiiX7Pwdu12PlckXiB8e8lCjoL?=
 =?us-ascii?Q?qlwJCfz1CabMrtU8ZN8eleLnzLs1XMj9mpe7bISlrzh//nxoL7MJFL951kF+?=
 =?us-ascii?Q?ycekScw3n6Y/xbH7dDB18Nv50vIpl8x8QQ913Zehbc3pXJyh4V1+sFW4jS9/?=
 =?us-ascii?Q?fOKzdZIisXc96ILOlyAhUv9WO0SFZKPTkb3yt8FZWPWa3+GOWwgtwZT17xCW?=
 =?us-ascii?Q?yLXH0bGpz+rgizWZlES9hXoIzDvbZCK3iTd8ByfVgSTd+/v+ojJhV1PrTxUr?=
 =?us-ascii?Q?ft4+VcGm4rczpMm6fXtJWhYbo3STxyHXMvY9dO8LgbNYuK+KEF0VlHM6p9PF?=
 =?us-ascii?Q?lYHVaPlsYRVIeZuP6YrEVOxMWf7Pi564AKtJ+XcqwWr5NYEu+PsQzspsa5Qu?=
 =?us-ascii?Q?NWEbbRs7/YUzYgETd8EEzLQsLjBSFyiKXXxcyQpmTGp/dnApNd+8SMI9jNPT?=
 =?us-ascii?Q?yaPE1yI4c0mQDNpuhvGtk7Y5Ql/cNbOq92qD/owmyaXYdvz1EG8apyZs76M6?=
 =?us-ascii?Q?449bXSFJxyTk4Mde8PbwGW3+FVAAecMg77fqO5u2IOgc38yAqEB2P+N1gocB?=
 =?us-ascii?Q?daVK7RUXMXEFQv7q59OMLUDYqnKkBsRn8J871XOgWSStwx+ispWAErWQTKTM?=
 =?us-ascii?Q?GtVa1H+HVUbLgEMvUTfFMLL/JRiX+2ARPBu+jVFJbXknflmJ/hpAvfcSH3ca?=
 =?us-ascii?Q?zqILM5JcmmaHROzDGD24eQIGkYiPqDRdFwUTU52nKu8GI22CZVwVVHtxdztC?=
 =?us-ascii?Q?mN1/NOogU5BA5edA722QC2OnF9UW5oHshXJGrShj9wKSceRMdkXCiWr/l8lJ?=
 =?us-ascii?Q?geyLeRiSHAq6ZMr5TxFuK23RKQ3NJ/fhlbXhlPXADNKmAGGmrytCFCXQ2VN+?=
 =?us-ascii?Q?HM9xkygZLBDcKLffkxP3CPodEpnfNTSlJ6MrjLrPP1SwIYEH6NlNhwlMMKot?=
 =?us-ascii?Q?v5tTo2xHxXjk25C8ux2bmnOeiJytPO58TNUiNoKa4YlHZhOTguKeEQGad80G?=
 =?us-ascii?Q?AhiB+rcG9fg+Ofc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 18:31:16.9812 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 479069e7-1720-44fd-d7eb-08dd34c9a22f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6585
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

Some monitors flicker when subvp is enabled which maybe related to
an uncommon timing they use. To isolate such issues, add a debug
option to help isolate this the issue for debugging.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
 drivers/gpu/drm/amd/include/amd_shared.h          | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e0c977e28626..fe75fbced027 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2033,6 +2033,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	if (amdgpu_dc_debug_mask & DC_FORCE_SUBVP_MCLK_SWITCH)
 		adev->dm.dc->debug.force_subvp_mclk_switch = true;
 
+	if (amdgpu_dc_debug_mask & DC_DISABLE_SUBVP)
+		adev->dm.dc->debug.force_disable_subvp = true;
+
 	if (amdgpu_dc_debug_mask & DC_ENABLE_DML2) {
 		adev->dm.dc->debug.using_dml2 = true;
 		adev->dm.dc->debug.using_dml21 = true;
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 05bdb4e020ae..c3e6dd4f4e00 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -349,6 +349,11 @@ enum DC_DEBUG_MASK {
 	 * @DC_DISABLE_HDMI_CEC: If set, disable HDMI-CEC feature in amdgpu driver.
 	 */
 	DC_DISABLE_HDMI_CEC = 0x10000,
+
+	/*
+	 * @DC_DISABLE_SUBVP: If set, disable DCN Sub-Viewport feature in amdgpu driver.
+	 */
+	DC_DISABLE_SUBVP = 0x20000,
 };
 
 enum amd_dpm_forced_level;
-- 
2.48.0

