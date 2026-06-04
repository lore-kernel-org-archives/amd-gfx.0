Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE81CD6E4A
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2026 14:54:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DC6911283B;
	Thu,  4 Jun 2026 14:54:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z6CV3pIy";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011008.outbound.protection.outlook.com [52.101.57.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19B4311283B
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2026 14:54:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ouLGazZ+/5idggAKrzcvNfFiZ1SAneaxh4OFs13Xyf/27wQXdR6VWvPx+VNdrNP1WZFWgO86k7mFjWzIx56Z8VYV9vgwmcGp3dSafN0HFKOXHI6ngnqGRknnXN/UFAgyEVqEzmmXy02eIkxVun98X8vF7I3ADVRq9JWhHHrSkHmma7ZWB7XUuax831SY/355OwEDg7ghlv0cMTG7uPMM8fCN1mTbpmtpp6Fs2RQNUPHhhQQD5HBMUcAYLPBENk1jLdcWt4fcbpWjm0pbwtgJ1f69daUHrdmQ8lMHZU0rDn7R2gx9/2AyMa+ZMhtlGkF88Pce8Bl9dqsVf2m2TBb/ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DKTw8GZ3E/I0IxvEaakqrHz2NBITBKLGJBJ+thsUCk=;
 b=PyMEa9Lp+X50/fgTew6+PQ5QlUnPMBPorCbFKQcIAMLJ/QegJ15ApG79egElLQAr2H+t5wC5bpEej6c0uf6cCr1jgVnEC5I/jrRVz3wMnawDCyPfONrkzPqctmLTr/7fwKUVm2O4jNdeK+TMIdJ9PPerzhix33H/Fd68kR1oUKBQPUjMHtmGUCJnNwHPwKcssO+XxWuIO/aoVPUEvGakxdtBBX+HGkqovx38C2ZrjlWfmJ/euSNh+BElGqUGJAFVpqc7viQewh/bF4dzEHuUSvZgvfRbCqH5tX0Xt1SdT7KGfbB8+xUTweqSk5HOH2dbOrxIRKM0ltgosxb1dpQi/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DKTw8GZ3E/I0IxvEaakqrHz2NBITBKLGJBJ+thsUCk=;
 b=Z6CV3pIyqWbnbV5xzDUGznX1KPQsekbXg1RvA1mzAJUGyIvaXN2rdvRVQ47bEkIgweCRiFj9eHtkcy5RMwnwrB6rXwcLHm0Xxrtjeujcke3gTVuZTqWILyBK/MiC8O3D5D6GzFsTnPwZ+gfuCu2jMNOkhfNjEb5/SPo+wtABg+0=
Received: from BN9PR03CA0239.namprd03.prod.outlook.com (2603:10b6:408:f8::34)
 by BY5PR12MB4084.namprd12.prod.outlook.com (2603:10b6:a03:205::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Thu, 4 Jun 2026
 14:54:43 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:f8:cafe::a) by BN9PR03CA0239.outlook.office365.com
 (2603:10b6:408:f8::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 14:54:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 14:54:42 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 09:54:40 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 09:54:40 -0500
Received: from aaurabin-tumbleweed.king-squeaker.ts.net (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Thu, 4 Jun 2026 09:54:34 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Roman Li <Roman.Li@amd.com>
Subject: [PATCH 01/24] drm/amd/display: Skip PHY SSC reduction on some 8K
 panels
Date: Thu, 4 Jun 2026 10:51:55 -0400
Message-ID: <20260604145428.809959-2-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604145428.809959-1-aurabindo.pillai@amd.com>
References: <20260604145428.809959-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|BY5PR12MB4084:EE_
X-MS-Office365-Filtering-Correlation-Id: edf3385b-8ef3-4c29-f523-08dec24935b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: +fEaX3ceEnug+oIEL7O4NEyR2oSekeLeSB1+9plymE1pTPaFZdytzOANYKgQPHYah9A8B6Avhro4/d7A+zDGU6GVa8vGPb5AIfhpGSrPov6yzbWZQgvfYkkbmUw6FF/lDhFhPXE9rPFsjDQqVoktFnUufdFZmXgQ5SCEfuXq3JnLBHkmdga2RAhC/S3cSaSL2AqyeEtDafV9WEHd8glLBwZLoRu9k9gUhgirQ8Uo54T9APp/RIyJBElFV3bmmkF0GpRMwHJS8j85IGTGGDp/S8vKFiiGEGwYjfAqzmzDSED8b3o/IqZRNnzRQGXcBCoep+l0wc+qSrOLF5sNah0j8DMCVKEu3OSoAUzsg8IY5PY4BncaXpMs1O7JxCIsTTA8LCJtvyiIFtdYak7imCVD/OWrNAnBRRjSwSS4Yy+r3bOG3eFfcCbo9kk1ufFlk58evGElLsQGMHCqqvfLjZsERSpdmPlpDBUrz0S3ytGP5E8jULYVjioAfEWNfl2Oh8GF/BRrX9+D96ohs/tTjDEPZ1PiffHrOiUfFT4HWS9hYvOC3uBVEkkE4VEclV55o9JdBIm30Bnl+zAecAh+2flkyGLTeppc3KA3CaOcbH/7fTQvuhhFm5mNf3PKWS8Wt5DdGcN7R31YD+EKlz57gFq6JESbQFytUyWOfP5w+ChWfwXF7MqbAt4NRsX9V4LVBW7E1hsjsBc2DMCcluIDhoXugvQkAbJ4zaHHeTlu/JKkwgs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: M2Va6j3mFK8+ejDz5gg97AwVRU/y1o4OS1JLNSggcMiFcGIjuJVNgvneEEavKDh0cWVTfaM8zcjCuD+MlmfM0bt4Q7ls8pPoq3jcHOGMCVRRCEWURwZDuX30QD0GO/A9KQcHE2IXHWFxRhAC4hnbyTAoPkfnzC3ruK9Vz+xh6qr7TAJA6spV0ohIYXSNZyQiWev7za5pTWWF9pOWhUiwx/6tYsHhJazLqVAcKYN238EzcWWotgyfm0KzeQ+vgMrOdev2YqO3B5Wzkg7VBqqVzzIgeMLGi5dBzJzbHwEUyh8VMoxjVLqKq/8Sxnc/KcWH8sU7isu/GWQDuOu0qs5z1N0DpChxliWD1oZuVN0PJ5e7h8dIkqWmsYgpvdiewJgj0ayF7I1DG/++bXaK26uoTrta8BBNfNoe5qLj03RX3/secPNUnkg7nkkSFFmb6wba
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 14:54:42.2207 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edf3385b-8ef3-4c29-f523-08dec24935b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4084
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

From: Roman Li <Roman.Li@amd.com>

[Why]
Some 8K displays cannot tolerate the reduced phy ssc value
at high link utilization and show corruption or black screen.

[How]
Add an EDID panel-id quirk to utilize existing skip_phy_ssc_reduction flag.

To pass the link into the quirk handler, change the signature of
apply_edid_quirks() to take link as an argument. The dev local in
dm_helpers_parse_edid_caps() becomes unused and is removed.

Fixes: 5fa62c87cffd ("drm/amd/display: Add option to disable PHY SSC reduction on transmitter enable")
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c   | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 844fd403795d..a2d0bb34e639 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -95,8 +95,11 @@ static u32 edid_extract_panel_id(struct edid *edid)
 	       (u32)EDID_PRODUCT_ID(edid);
 }
 
-static void apply_edid_quirks(struct drm_device *dev, struct edid *edid, struct dc_edid_caps *edid_caps)
+static void apply_edid_quirks(struct dc_link *link, struct edid *edid,
+			      struct dc_edid_caps *edid_caps)
 {
+	struct amdgpu_dm_connector *aconnector = link->priv;
+	struct drm_device *dev = aconnector->base.dev;
 	uint32_t panel_id = edid_extract_panel_id(edid);
 
 	switch (panel_id) {
@@ -126,6 +129,11 @@ static void apply_edid_quirks(struct drm_device *dev, struct edid *edid, struct
 		drm_dbg_driver(dev, "Disabling VSC on monitor with panel id %X\n", panel_id);
 		edid_caps->panel_patch.disable_colorimetry = true;
 		break;
+	/* Workaround for monitors that get corrupted by the PHY SSC reduction */
+	case drm_edid_encode_panel_id('D', 'E', 'L', 0x4147):
+		drm_dbg_driver(dev, "Skip PHY SSC reduction on panel id %X\n", panel_id);
+		link->wa_flags.skip_phy_ssc_reduction = true;
+		break;
 	default:
 		return;
 	}
@@ -147,7 +155,6 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 {
 	struct amdgpu_dm_connector *aconnector = link->priv;
 	struct drm_connector *connector = &aconnector->base;
-	struct drm_device *dev = connector->dev;
 	struct edid *edid_buf = edid ? (struct edid *) edid->raw_edid : NULL;
 	struct cea_sad *sads;
 	int sad_count = -1;
@@ -188,7 +195,7 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 					edid_caps->frl_dsc_max_frl_rate, edid_caps->frl_dsc_total_chunk_kbytes);
 	}
 
-	apply_edid_quirks(dev, edid_buf, edid_caps);
+	apply_edid_quirks(link, edid_buf, edid_caps);
 
 	sad_count = drm_edid_to_sad((struct edid *) edid->raw_edid, &sads);
 	if (sad_count <= 0)
-- 
2.54.0

