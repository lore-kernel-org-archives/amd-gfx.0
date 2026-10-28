Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C145B606A31A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 14:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=YyBCG54G
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59FAF10FCF8;
	Wed, 28 Oct 2026 14:38:30 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010061.outbound.protection.outlook.com [52.101.201.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC6A410FCE9
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 14:38:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kNLWlihvRhEGGk8ynHRJr5cPS7O/ngCQuq+aDRMqU1A9+IJ8M5RZ4vIRe8Aq4u6wF7v/jYdBlLjhLpb44AGO3lS1eSIIUmgbrSCPkdLUqFgsvvfCHmVCmd8uYEl9RFUZ0ycNqzbhIKzr7AyZhxbrA4tqCbpM8pUN2GL8piZjHJLDzfnyWvJnA1lmvXRtHWqpUu7SHIO7RAecPDshN3G4RkCgZWhDnJ9NJmE4JGNBXEoviAlW4S0N6DJpP0gKlXkocHvrQiBuDd+w4rceK84PcEWrJLvEQm9QaySMXyI1Zpf1n6bfMWct/bUYTVMRe7Mu++FDIzzeHdG6DFF88hN4HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ou71/ULVHvjJ31PLnDSlUoSyAQV1Vsy1oDKv9unHCTg=;
 b=V5HM3bFrXwC+TNe7/a8zbYRf/E3Gxcr6tGPgMxNJNVmp0QSQx4I6B3QbWgIXBQDAzjo8iD/IhwCKb4gCGHfEzyKv9Z2iXtrm8UkR66kSUWm2OS+qsRhFXEmsVBqINbaWKaMMKX10Yn1tXC+yBPp6uO4s92OEOPGKxtncS5rk+tvKGFCD/VX76OLns4nBwqTjRGSR8sUN+uH5JRxCx8uMC+/decbBhrpYI+meWA7Ga6VYi9lJCS6Z1NK/W2PWB835eS+gp0UTM8sFfP1xLgYWfTnnPwn0XYnBYCI53q31PIMwFckIJ1oeVs6jMN0urEDbbbrtnDSpdgQx7aQ4a7nhWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ou71/ULVHvjJ31PLnDSlUoSyAQV1Vsy1oDKv9unHCTg=;
 b=YyBCG54GELQ0JiLeZ8XWT4sNMO8Y0HwTY5wnAvr8Peb07E8iCDKcrYM4UqmOoUk+sLkWF9r3COtVMJks7WMOV+cXtKMXNTgnolZ8zHinHPKgOftLaWQRR+ZDBxxWt/SjJhOoiqoHAKfMRKd9Wz/JHV7t2tz5loAWI0TzwC207Xo=
Received: from PH8P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::17)
 by BL4PR12MB9533.namprd12.prod.outlook.com (2603:10b6:208:58f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 14:38:18 +0000
Received: from PH7PEPF00000006.namprd04.prod.outlook.com
 (2603:10b6:510:2d8:cafe::85) by PH8P221CA0012.outlook.office365.com
 (2603:10b6:510:2d8::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 14:38:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH7PEPF00000006.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 14:38:17 +0000
Received: from RSBMMILICEV01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 09:38:16 -0500
From: Milan Milicevic <Milan.Milicevic@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Milan.Milicevic@amd.com>, <Danijel.Slivka@amd.com>,
 <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: publish IH enabled before PSP programs IH_RB_CNTL
Date: Wed, 28 Oct 2026 15:38:04 +0100
Message-ID: <20261028143804.24239-1-Milan.Milicevic@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PEPF00000006:EE_|BL4PR12MB9533:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b0580c4-0d0c-4cc0-06c1-08df35011b0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|11063799006|56012099006|261009223027099003|261026121527099003|261026140227099003|261021121427099003|261021123027099003|10067099003|261022105027099003|18002099003;
X-Microsoft-Antispam-Message-Info: eLSw8dlr1gvo7HJccmw1iCd13RkdvzJ1xt0fkxiqZs2hedO8pKazKgJvjIKnZGR6JPPRJkP4B5dWhmxX0+WxWjyodOgIYdRDHbX5OyJRWcVfQqbyICeHCUdiCXJaTP5b0CEV+mBUh+MZbD7A7L1YzpQqMQf9e9y6V6/VnZ4mn0P2DOnkQRidiEBDlCQIfbHRyD5hXYy0eAKiTSq/rnlFCqkmYB0ZiF/UcnJogAAztIAWY+z0jY6sTeUKJichPGgl/3mXnMD89kGlxLL7FpMK2ZUx4OYS2IgY7/T8X6CjqFIHn0HSx9pjMSRR3/Qcg51XgpeCqOHjOJMiC8DzQx8yYxLMx1ymgRnNfOK30OJ1MDKHEfKnu2+n+fuW8xm9BAH0J/nQ+vHGAzEGWdBtGYpTG4Nc1AQ+ooy4OHsOsNa+P2v19mqYWAvOlUmTJHXwasQKD4c5XHCdCoCIGYP9vMbe0xHa0vVRg2pTaEhm2RRwqdmR3qNh70VmAdSjHOqH2/6kycrg0/3uOXPO13QSr5XfS3Bi2AHJF79zNhd818W9vMLcBwUfQPl98O4Q438qEfDSgmKxbuQdgqvUPuVsa9umCSVrswX6ipD+zclb1MtMmNMjK26X3XIjVmXmHGEHeUuOmZ1ykQH206ZlXODMcm23eRkJlplzn/wp/0NbwjhqRC4TShOKI336URWRbMdImoiOo/VtwUAuWLRTxMgWaoxbNA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(11063799006)(56012099006)(261009223027099003)(261026121527099003)(261026140227099003)(261021121427099003)(261021123027099003)(10067099003)(261022105027099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: T+lbSZ5tk5o9fi70Xb6a/WbZ2cjsA8uAkpYlSx7VkS/V8JzVeiiOeVg0jxmQoeDJZoMhZ0bJOUT5hcDxAR+mnJA4d+hd3bZ0/GjVqY9Mi305KsE9s3fX4yQW4A2iG9fCJZOJSElSBccGW4PbXHVP/wu9lqukmJesxmHAiKk7MsJOhRJ3egvO4ZrC0ISE/LtHDeQUrGuOrYGAJZ2PkrF3OZR0IZ2FeWIKyok9+MeodxozepC6PWSVCMw1B4v4Xg/jLapwvQaVJRam95wqCOcfldXngajYWJ2mFsZIi4UOdX2dARgSNxdeN9wzC3TjkIwLxZ5CzB8JrtJs0b1ExLkQgIwddHNsE5hJrfSQ3jVev6/shTNQljj7V6HB5+hxsucRxwhsvFZTu2IRSRVHHqnU8LN5Ad0sPXTPlqgEV2yECQe7zCq/jGnCzMhJASt0r9Ah
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 14:38:17.3922 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0580c4-0d0c-4cc0-06c1-08df35011b0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH7PEPF00000006.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9533
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On SR-IOV, programming IH_RB_CNTL through PSP is slow enough for the
first MSI to arrive before ih->enabled is set. amdgpu_ih_process()
then drops the interrupt, rptr stays at 0, and RPTR_REARM never
generates another edge, so every ring hits the fence fallback timer.

Set ih->enabled before psp_reg_program() on the indirect IH path for
Navi10 and IH v6.0, and clear it if programming fails.

Change-Id: Ifc89c858149df78f78888f5649118c77195c7463
Signed-off-by: Danijel Slivka <Danijel.Slivka@amd.com>
Signed-off-by: Milan Milicevic <Milan.Milicevic@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c   | 13 ++++++++++++-
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 13 ++++++++++++-
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
index 8dee48649650..478b7169f44c 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
@@ -168,8 +168,19 @@ static int ih_v6_0_toggle_ring_interrupts(struct amdgpu_device *adev,
 		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, ENABLE_INTR, (enable ? 1 : 0));
 
 	if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
-		if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp))
+		/*
+		 * PSP programming of IH_RB_CNTL is slow enough for MSI to
+		 * arrive before this call returns. Publish ih->enabled first
+		 * so amdgpu_ih_process() consumes that IV and rearms.
+		 */
+		if (enable) {
+			ih->enabled = true;
+			smp_wmb();
+		}
+		if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)) {
+			ih->enabled = false;
 			return -ETIMEDOUT;
+		}
 	} else {
 		WREG32(ih_regs->ih_rb_cntl, tmp);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index ab12ce8da3dc..fa5148ae526d 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -194,8 +194,19 @@ static int navi10_ih_toggle_ring_interrupts(struct amdgpu_device *adev,
 		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, ENABLE_INTR, (enable ? 1 : 0));
 
 	if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
-		if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp))
+		/*
+		 * PSP programming of IH_RB_CNTL is slow enough for MSI to
+		 * arrive before this call returns. Publish ih->enabled first
+		 * so amdgpu_ih_process() consumes that IV and rearms.
+		 */
+		if (enable) {
+			ih->enabled = true;
+			smp_wmb();
+		}
+		if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)) {
+			ih->enabled = false;
 			return -ETIMEDOUT;
+		}
 	} else {
 		WREG32(ih_regs->ih_rb_cntl, tmp);
 	}
-- 
2.43.0

