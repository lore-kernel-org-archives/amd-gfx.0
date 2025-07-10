Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E338C83F1A
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jul 2025 21:31:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6E7910E973;
	Thu, 10 Jul 2025 21:31:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P4AFNDpY";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CF0110E973
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jul 2025 21:31:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aa7i2CZgE+DJu87922zFDPV8Fi2eBzIJ7T5gm1bYDA7lks8p20Fi2F2NxZKqcUvt3H5HGGxw2jq0DODILhz0P+/e8rDm+Ld9LdVDE+WrTSjqC4sBtXg/QyLK3fmXYjLt3wHyUslCFtPekTaKuIG3lY2VBLP6byl88hinY0TyVw/TMEAOzNy2Je9fBVkuzwC/BvpgvNZ959R7ZiB3VdlRVUQN9WWlJb/5xv3RayYAckJCBQMbKqKKAxODgBdQy+lHTxvS2HWCCWNE2wV6jJr2SxNzMgHxwHm0cXi4ohspUnOCcOQbIG5JOVjWZ460ote8+dteEGaW2LkLY+oNi7zTOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kpag3KqA6zNA9XHzbCKhNj/y8KLbrzr3Iz2FbeUSXE=;
 b=dtbP62SEiE2141wByakR/AS6epH0G+EPra/H/JGbTML/lQt3wp9UUJWlt8brg+mJPOoVXKd6hVY9BaWPURfJde/T3ND4vABN7t0b/FN57gugihBQmCbQk1UXvdrfsBqnCGQqaiVw4JFePx+cT6ISOp3xPGEaEDDufksVOscDVI7adz4p6/YtrZ7k1jIlxMinn2PQ3DS6OxD7kpzLDVW86YYUGFRYmyLBVeVdfxVBXOiumoXEs/LZdYZJfvg0jcl2H9MBEb6VK64YcCb620/DJW0W8SkmdKOzdHa/fu1Gi1mbVfvQdd8npc2RoP3094oRvEF3b0BIJRAjGLHfM06F9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kpag3KqA6zNA9XHzbCKhNj/y8KLbrzr3Iz2FbeUSXE=;
 b=P4AFNDpYz1OCw31iA3zM1jgTlqjoOeHtQrv4azclNIumunygoZbxuhKXqWmN6S9XUArX20wmZd95lPzX78HZx2zmwwy6J3Nz7D7/KiVMDRYkJoE8FRHSrsdcUTs9dRUoOgOsiP00Z5hu6wh+MCIzinSiJFdUvczeA5SEXehz7gM=
Received: from CH2PR03CA0002.namprd03.prod.outlook.com (2603:10b6:610:59::12)
 by DS2PR12MB9752.namprd12.prod.outlook.com (2603:10b6:8:270::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Thu, 10 Jul
 2025 21:31:33 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::17) by CH2PR03CA0002.outlook.office365.com
 (2603:10b6:610:59::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Thu,
 10 Jul 2025 21:31:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 21:31:33 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 16:31:16 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 16:31:15 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 10 Jul 2025 16:31:15 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Melissa Wen
 <mwen@igalia.com>, Ivan Lipski <ivan.lipski@amd.com>
Subject: [PATCH 18/18] drm/amd/display: Disable CRTC degamma LUT for DCN401
Date: Thu, 10 Jul 2025 17:25:51 -0400
Message-ID: <20250710212941.630259-19-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710212941.630259-1-IVAN.LIPSKI@amd.com>
References: <20250710212941.630259-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|DS2PR12MB9752:EE_
X-MS-Office365-Filtering-Correlation-Id: b05d0522-10b0-4d64-022c-08ddbff92426
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EVvdUB0He7hyytzjtRo0KjIyBC0K1K+R3YOBKIO9N5Th85g7r2OyxGuI22PU?=
 =?us-ascii?Q?13bqWlvZNbiLZBKndAHzN87m3TxBGq2TSrYs23tTn/cpJKbkQ0D8QqQXVlYp?=
 =?us-ascii?Q?xhsr7og9XfyDbT7ZhMgSaMw0TrHaTbTY1+aU/F1QmjJ+5J7tdQYiSkk7XtGH?=
 =?us-ascii?Q?v+7AD/tw+OR6AUQAFlVKlQCWcnOIiy+N2+hpRFyIPH3wQYUQMJDY529lmLXW?=
 =?us-ascii?Q?LA4cq8+ZN4u7aeWoQ3Urpy/SknwUVb92MGw/f2hKMrPHtm5XKQsilFNyN6oi?=
 =?us-ascii?Q?V1rRPcPph2Ck+8kAIh+LMBgi83Qb5Xc8gpimaGg3aEa4QpH47SGA/9bVu1t4?=
 =?us-ascii?Q?NLr2s55oaVSM41owss6FeqFcE/0LLqLoPestPxT/Un/v3N5TZAypLu5oaT2P?=
 =?us-ascii?Q?QGVeqaKQjJWT2Ae17UQfOCkhLULFiquZmsdOiTGbbbEv3OEKWADN4pCivVL+?=
 =?us-ascii?Q?td4bT0HS2Apwi/QIc7kRch5reWP0InAauB8K5sPt18BAXl01Nibytj8WQmIu?=
 =?us-ascii?Q?72vi7RTzSnoJq/gnGcIdXHvJ28SGgYxqkNhpHSLnoeuMBGqOzGZa6I1IqBt+?=
 =?us-ascii?Q?NkvVDpLwgXnzJxtm7dHuNMHaMhFo3dHBiHT5LGMFCHztOw5q64eCgZD1sfMm?=
 =?us-ascii?Q?XRVyYt1Rupse/TVmcIhjJrezBVZqF2PYFA1u8E5L+SmrLSX4Plfj9UbxW2VF?=
 =?us-ascii?Q?GfAPFOrpUouoFDxLVZfDFl4N3XRS20xRqtO3OErX+To4P6HNSPKSPtHIVN4a?=
 =?us-ascii?Q?yv669ZLS7Hd99xPeoMUJjWwOQ81vpzPPcxyTTZ7RajhLDa6Yyd/wfmB9OWvq?=
 =?us-ascii?Q?roeZNQp3JDSc9K6MTjNAeU6Gtz1CpV2iwGIfmNasrBETCrODMuRdRVD3+v9P?=
 =?us-ascii?Q?PfhxiHpo5Mz1FQBeXfMWk7ibKHh+2/x3+Mgt7ju/VdbeNKgLf2zIrMw7WT85?=
 =?us-ascii?Q?5YFG+FrfMJGPIR8mKo4YsvR2iRHgl3rZo9c58NDETN/6XYx6+aW9os8TSPF/?=
 =?us-ascii?Q?DAhH0g1RLzqp6YkTIMpgKXfQnYqxCMik12tK1SNvsArz1hExjl77BIEzZwHe?=
 =?us-ascii?Q?H/pxKetst8M1OF87+Jh/eVfP7Dcx/zdw+xWkPt5U6v+StROFJMG6NrCTNPIu?=
 =?us-ascii?Q?7l8Gj4WJsl7c6hb2V1U44zgbw5Kh+O7jX19Br5Zmsjv8w0RvPgfcogi7v1V4?=
 =?us-ascii?Q?C8Zg90RsxQ4c2RE/TJZKpmn8TCqp1SxKgE9qsDn26M8u2WaSuCOnakIhuPvw?=
 =?us-ascii?Q?1eRuf7UYw1hJ88A8Ft+joFqLqqLFB0Bt2QJKw0hlIEeMXhBw1NRr7Ad/1XnY?=
 =?us-ascii?Q?t3gW9q4+D545iNnlfnje8BqtPKbPldxQPkKMsITlOVpEAXtEbOqLZkTgR5AX?=
 =?us-ascii?Q?lpkgnjqro0/Awvsnn3lLAQM9fgfYvJtmVX9TAwEBeyzguKDZLfjXG4qu0PSC?=
 =?us-ascii?Q?YV2NVb6o7hVwmfWgn4l+FqQW+oAok0HKO4xvTwI7QXkcgHe6MaqsPQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 21:31:33.0170 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b05d0522-10b0-4d64-022c-08ddbff92426
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9752
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

From: Melissa Wen <mwen@igalia.com>

In DCN401 pre-blending degamma LUT isn't affecting cursor as in previous
DCN version. As this is not the behavior close to what is expected for
CRTC degamma LUT, disable CRTC degamma LUT property in this HW.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/4176
---

When enabling HDR on KDE, it takes the first CRTC 1D LUT available and
apply a color transformation (Gamma 2.2 -> PQ). AMD driver usually
advertises a CRTC degamma LUT as the first CRTC 1D LUT, but it's
actually applied pre-blending. In previous HW version, it seems to work
fine because the 1D LUT was applied to cursor too, but DCN401 presents a
different behavior and the 1D LUT isn't affecting the hardware cursor.

To address the wrong gamma on cursor with HDR (see the link), I came up
with this patch that disables CRTC degamma LUT in this hw, since it
presents a different behavior than others. With this KDE sees CRTC
regamma LUT as the first post-blending 1D LUT available. This is
actually more consistent with AMD color pipeline. It was tested by the
reporter, since I don't have the HW available for local testing and
debugging.

Melissa
---

Signed-off-by: Melissa Wen <mwen@igalia.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 87058271b00c..2551823382f8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -728,7 +728,16 @@ int amdgpu_dm_crtc_init(struct amdgpu_display_manager *dm,
 	 * support programmable degamma anywhere.
 	 */
 	is_dcn = dm->adev->dm.dc->caps.color.dpp.dcn_arch;
-	drm_crtc_enable_color_mgmt(&acrtc->base, is_dcn ? MAX_COLOR_LUT_ENTRIES : 0,
+	/* Dont't enable DRM CRTC degamma property for DCN401 since the
+	 * pre-blending degamma LUT doesn't apply to cursor, and therefore
+	 * can't work similar to a post-blending degamma LUT as in other hw
+	 * versions.
+	 * TODO: revisit it once KMS plane color API is merged.
+	 */
+	drm_crtc_enable_color_mgmt(&acrtc->base,
+				   (is_dcn &&
+				    dm->adev->dm.dc->ctx->dce_version != DCN_VERSION_4_01) ?
+				     MAX_COLOR_LUT_ENTRIES : 0,
 				   true, MAX_COLOR_LUT_ENTRIES);
 
 	drm_mode_crtc_set_gamma_size(&acrtc->base, MAX_COLOR_LEGACY_LUT_ENTRIES);
-- 
2.43.0

