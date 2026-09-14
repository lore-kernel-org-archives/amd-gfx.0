Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E0DC88E64
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2026 02:20:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86D4810E06B;
	Mon, 14 Sep 2026 02:20:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QzqRWAA/";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010029.outbound.protection.outlook.com
 [40.93.198.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 646E010E06B
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 02:20:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xtpcZ3XwrV6mRfxkwBQQTxgQwDf09c5fFQQdLz0FuAvepZ6rgp9GVGnQbU4K1QYpqlP/suASNyfzS1DGrK2wcNsOTolM2M/LVN3iq9ibPNk5Ls02aQt+hKOhDKbF8LC9oMmG0dGKmZSpaJFgSqpKI9IuJAnPIdMrUlXRSoIF/McdjnMn1PIAep+QjTFRIQ21ONLN5iy7FQij7uNnQfw3OjQ1AKRq0N8+BEA8kuZRbrI17kfFTBkqN+/PA3R8bt7tfQ9huE2BWF3WFDpMB7I5uT/L2CC2Cp31AyxHYfmGFVaVIiGPehaEIASOPcuAkrztyka17Kh7y/ou8eSudsJWhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMI9nNVZK/4yBhcy2SbTdb7yc74RRzBz5oMy5PbAckE=;
 b=deUzHPZUs5WL6yRaA7bpH+/t73qXW++iLQCEp17RUiaq6dUNANIQb6FiQXFmfcKcubhOxiFZYtp5YSa13Y5CV0AW6Jh3h98FFe8FGIkJEgqdqZ3npnikvVy0oJaUCaLRgmJQkI9Ox6MjsmtYfR3auwGae5q5g3mSBCC5X9e3jWk6l6AlgvSeyClp5F4LQlCUGhLK7IrNwyIzJ73ysXh0nvpXIyeDNBumF/7fJN69l0+x70VaYlBCZbJQVTUDZumJ73piD/RWsRqnGfdwc+yc3axEO5FnUXmWbtxV9pzFv3KVSDAZxOrdkwO9wtA0udsZ3L+dc8lJSxSxdfYoZmuPRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMI9nNVZK/4yBhcy2SbTdb7yc74RRzBz5oMy5PbAckE=;
 b=QzqRWAA/HQYNPyT3BbXVdLVLYSG2TLIb9pt/L7XvOYpxxI7Kv5fEy5AzniP9rE0gdL+cs2fjBUXGznW0Acw/DGP6o3jOuHZefUzBvt+r46gxvvCRj7tGAcN0hIIHySY+Y0XHfxzcqv+Zli7jvbnBOJj5lN38n49VacNkmZU36LE=
Received: from DS7PR03CA0258.namprd03.prod.outlook.com (2603:10b6:5:3b3::23)
 by CHXPR12MB999221.namprd12.prod.outlook.com (2603:10b6:610:2fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 02:20:33 +0000
Received: from BN3PEPF00022BBA.namprd04.prod.outlook.com
 (2603:10b6:5:3b3:cafe::8e) by DS7PR03CA0258.outlook.office365.com
 (2603:10b6:5:3b3::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 02:20:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BBA.mail.protection.outlook.com (10.167.248.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 02:20:33 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 13 Sep
 2026 21:20:32 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] drm/radeon: restore eDP panel power sequencer on Apple DCE3.2
 iMacs
Date: Sun, 13 Sep 2026 21:20:02 -0500
Message-ID: <20260914022002.2005150-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBA:EE_|CHXPR12MB999221:EE_
X-MS-Office365-Filtering-Correlation-Id: afddc6a2-518c-4677-cbec-08df1206c139
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|56012099006|11063799006|10067099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: kPMgMspTMZwuLKkL/li2nFrXs+q5620yHOeBfI9YAAbGWvRQdbYcmlwAOkWjHa2c1KceQAgRtcQcTInYWiliEvafVol5xV2CQC/MCee5mduSpOmRgm4LiCNB+KRsHIqcD1uxAswSETZrl5rNPLo/904hTCnTodVf/C8EggKEn8a230GEojh7cptUSeirr4iQVneCBEjQP12rjisXcnezNpb6X0WU4yvrbVxji14gNOo4iWIZjNJgWDo+YTNuKT5hGiVx2JE1vQ0kkbT0k3dafd1LnPYSjh2LGxqf3/Mbqf3v3ZFfxhTDsFv0nIFzWqf3lkaqiqb0eooDP8gt7BZo8pCiBf7sK+7zRaAvTVfto0KkO9pc0UypsWqnauRW0eIdkj23awsU9ifne8cB56ZgNHpWH4LuEwkUGytH0JA+7wrJn6xfEK/d3pz4r6ICJs4sz8vOaLa1cI4+jQ3Vdd+uaHeJz29Vu4fSniZLPss7hE3jx0KX/7TsmTtVzu+T8ODT0fcLRnSy2/4qMdrY78xM7GhbhXQopwkG1/ANtvlg6g9uylvtdEH9DViuUStIPUSJFWUWXZ/eeCX6cG2UEjJaULz2Ku8gNCq9BNATRxJzHYluZE0E//n8Bs4PqLJB03d/GWSLGdsPxh4kt86eFBLlYQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(56012099006)(11063799006)(10067099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: M6Qf3xs5DviY0tvUXjG1RlchqVEX1jjCL+frkK9uLq890rSogJqHU8e7b/UnX5nvT5C7BhoiQT6WE4NarG13iBRL3D2zSiFtXv13XOFvJQ06InEBecx6EiUh3jeeLZZUNY3ke/t8Q53MO1/A4aSLabH4RvTfu9H0HMaMGTUjQNVX8IQyIGoN0XVejnFxB8yyOcB1ZmPwSQQiRsutkdbD7ig+hCr4KYVaFNjIlmRjKcUh/yNrc4F/94GF8BE4xwyP+cYvQS+2mwv14R6QpMnDyPfTLiJAibV5pu0CFgknuUtukyBiNby8bmWRSCboMSg0mXo3zPMD5sI9ERj1GFI1wdbTiGIQnVxAjj4gPoN+E40pycvRiiEBkqP5sQG6f+u9QlRlOFeMevX8/MoCc2NvTN4+Eb9ftKKqxN+w1JM+zMRKLfVau9ac16qXbHdnlD8N
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 02:20:33.0360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afddc6a2-518c-4677-cbec-08df1206c139
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR12MB999221
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

The Apple iMac10,1 and iMac11,2 (RV730/DCE3.2) drive their internal eDP
panel through an LVTMA power sequencer whose enable bit (PWRSEQ_EN in
LVTMA_PWRSEQ_CNTL) is programmed exactly once, by EFI at cold boot.
Apple's minimal ATOM tables never touch it afterwards, so any GPU
re-initialisation - S3 resume or a GPU-lockup reset - clears PWRSEQ_EN
and the panel comes back dark while the rest of the GPU resumes fine.

The driver never programs this register itself; on every other radeon
board the platform firmware maintains it across a re-POST, which is why
this only bites the Apple machines. Re-assert PWRSEQ_EN in the eDP
DPMS-on path when it is found cleared; the hardware then runs the
DIGON->DE->VARY_BL->BLON power-on sequence on its own. Both failure
paths pass through here, as radeon_gpu_reset() restores the modeset
state via radeon_resume_kms(), so a single site covers resume and reset.

The write is gated to Apple parts and to exactly DCE3.2 (ASIC_IS_DCE32
is >= RV730, so DCE4+ must be excluded - Apple also shipped DCE5, e.g.
the 2011 MacBook Pro, where the register lives at a different offset).
It is skipped when the sequencer is already enabled, so lit panels,
DCE4+ boards and non-Apple boards are untouched. DCE3.2 places the
register 0x18 above the documented R600 offset.

Only iMac11,2 is verified on hardware; iMac10,1 shares the same RV730
design and Apple EFI behaviour.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5719
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/radeon/atombios_encoders.c | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu/drm/radeon/atombios_encoders.c
index 8b3f8303a967e..5b9c72bf40994 100644
--- a/drivers/gpu/drm/radeon/atombios_encoders.c
+++ b/drivers/gpu/drm/radeon/atombios_encoders.c
@@ -1646,6 +1646,38 @@ radeon_atom_encoder_dpms_avivo(struct drm_encoder *encoder, int mode)
 	}
 }
 
+/*
+ * Apple's EFI enables the internal eDP panel power sequencer
+ * (LVTMA_PWRSEQ_CNTL) exactly once, at cold boot, and its minimal ATOM tables
+ * never touch it afterwards.  Any GPU re-initialisation - S3 resume or a GPU
+ * reset - clears PWRSEQ_EN, so the panel comes back dark on the DCE3.2 iMacs
+ * (iMac10,1 / iMac11,2, RV730).  Re-assert PWRSEQ_EN when we find it cleared;
+ * the hardware then runs the DIGON->DE->VARY_BL->BLON power-on sequence itself.
+ * DCE3.2 places the register 0x18 above the R600 offset.
+ *
+ * This is restricted to Apple DCE3.2 parts: the register lives at a different
+ * offset on DCE4+ (which Apple also shipped, e.g. the 2011 MacBook Pro), and
+ * non-Apple boards program the sequencer from their own firmware.  The
+ * read-modify-write only fires when the sequencer is actually disabled, so a
+ * lit panel is never disturbed.
+ *
+ * https://gitlab.freedesktop.org/drm/amd/-/issues/5719
+ */
+static void radeon_atom_apple_edp_pwrseq_restore(struct radeon_device *rdev)
+{
+	u32 pwrseq_cntl = R600_LVTMA_PWRSEQ_CNTL + 0x18;
+
+	if (rdev->pdev->subsystem_vendor != PCI_VENDOR_ID_APPLE)
+		return;
+	if (!ASIC_IS_DCE32(rdev) || ASIC_IS_DCE4(rdev))
+		return;
+
+	if (!(RREG32(pwrseq_cntl) & AVIVO_LVTMA_PWRSEQ_EN))
+		WREG32(pwrseq_cntl, AVIVO_LVTMA_PWRSEQ_EN |
+				    AVIVO_LVTMA_SYNCEN_OVRD |
+				    AVIVO_LVTMA_DIGON);
+}
+
 static void
 radeon_atom_encoder_dpms_dig(struct drm_encoder *encoder, int mode)
 {
@@ -1711,6 +1743,10 @@ radeon_atom_encoder_dpms_dig(struct drm_encoder *encoder, int mode)
 				atombios_dig_encoder_setup(encoder, ATOM_ENCODER_CMD_DP_VIDEO_ON, 0);
 		}
 		if (radeon_encoder->devices & (ATOM_DEVICE_LCD_SUPPORT)) {
+			/* restore the panel power sequencer on Apple eDP iMacs
+			 * that lose it across resume/reset (see helper above)
+			 */
+			radeon_atom_apple_edp_pwrseq_restore(rdev);
 			if (rdev->mode_info.bl_encoder)
 				atombios_set_backlight_level(radeon_encoder, dig->backlight_level);
 			else
-- 
2.43.0

