Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19279CA0EEB
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Aug 2025 02:18:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD50510E310;
	Fri, 22 Aug 2025 02:18:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4gXy2edM";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B76CF10E310
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Aug 2025 02:18:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YB7Nkr48K3RunqbxKS8hYPtf6jMgJUe/MjGHx6YCGfd9b+3SLBr0WtjVWUeCngVMlJuN1xXMZ/bYYeX4HAOjrHQIMD7mXVOsqxjYaujO1ugcZeYWkufF1RTBkZhIobgdXJkb4cVAcKNKYtn+GhxMcQO/VkIGVFkcQY+MwT6FGwv6f19w8erVjIP194GjCH3dvk1G7jm5w3olvaW1Am8YzhXSa6pE6FJ5evYn49R9UUv1U3WX4Jw8In/dgOul/I0P4MUwzR3c4haS3UlFZtcWONVE7ml/E5u/fFv7BSx9FyzLWcpUDTueN2sL+AFA2rQ81txr9sVNoH0D/hgLJx3ZtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9JEHYbZpX14QATKwr9ckp5W2aJlZ5M2RIQ1ERA8TYU4=;
 b=biJDBsLhsQlouloFBjz4UfoyJzy/meQ5tc2/KBhoFplIGAMomWB55xWOQrGEv5xbQ9g11M2zOId8yL56j1n7YqCbCaZ/X5Vwmgg6otq9dJqZdRUXSpkEm2XS4+VzQpAkaQUb0i8IufoPnsHJoRCPHMrGBSEYtanzmCiDBsPP+ck/KmsyFQ4vv0fUsH6Z7CkWz4kS5QKXoFHPPmrYEwYg7VLCf0SYDuvuD/RCZgW/jH8GDFcnqdf/7dLrqWiozpcYbV2f8/yV08VU1Pq2VEp/vLYiRgPiIqNP3OJvLppzrmY6SEmx8peEbTN3Nml5BGb/HZ5aHnNnWCbsL77JPxoU0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JEHYbZpX14QATKwr9ckp5W2aJlZ5M2RIQ1ERA8TYU4=;
 b=4gXy2edMrPtut0helX6Ej49DjTlP6K8lrEK4dz1v2Qqa0JjjMMV5MV2f0c/NOsM9+YFFu9kikoSTzAsmLVr0u7K0/rzeN+7xgn3hhzQ+N0chmiBXt1hVeBs3q+ZGwm5rXsBbA02a7lrqNa0/JjDcE38a8SejPyvFw58tPdmnEyw=
Received: from BL0PR0102CA0026.prod.exchangelabs.com (2603:10b6:207:18::39) by
 BL1PR12MB5778.namprd12.prod.outlook.com (2603:10b6:208:391::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Fri, 22 Aug
 2025 02:18:15 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:207:18:cafe::64) by BL0PR0102CA0026.outlook.office365.com
 (2603:10b6:207:18::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.16 via Frontend Transport; Fri,
 22 Aug 2025 02:17:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 02:18:14 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 21:18:14 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 21 Aug
 2025 19:18:13 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 21 Aug 2025 21:18:11 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>, Jesse.Zhang
 <Jesse.Zhang@amd.com>, Ruili Ji <ruiliji2@amd.com>
Subject: [v4 3/4] drm/amdgpu: Move VCN reset mask setup to late_init for VCN
 5.0.1
Date: Fri, 22 Aug 2025 10:17:34 +0800
Message-ID: <20250822021801.630568-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250822021801.630568-1-Jesse.Zhang@amd.com>
References: <20250822021801.630568-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|BL1PR12MB5778:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c783436-b164-4489-f947-08dde1222659
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d0axC7jDsdIyeDhYPXnUVrybMCFuA3Bj0/Kcal8E6IRWQ9QGYPdFL1Slt5nE?=
 =?us-ascii?Q?Sr6hvSohge7C8LxT/D7MDOASIVNSKacpqcd+4sj/SpXADQjboY+tGXI21fg0?=
 =?us-ascii?Q?lcLTh1tXlBN/vKscysdEY0HfiI8CpaH4PgcbJWbzDorlxtrQGUVte6PJSVR7?=
 =?us-ascii?Q?xFfnUvDLxJNXMOLJOM+VEpruNdyIayIAwfPMpXHOpc9UOW3KVcnhuzFDxs8a?=
 =?us-ascii?Q?mgtN1TYKikKZGM1ZeK+LGIXnyT5Tyi+ZuhPAmwIMPNi5brHTNM5pWm0WWAlC?=
 =?us-ascii?Q?xAjw5ZOp12NdPJpZzsvoC8fxBj39/vqSzH+/w84EurS6fH+OJr6kbEBZCkUr?=
 =?us-ascii?Q?m9L9w1gymPrA1b7wodX8xPL3Meiw/UEIYQ7uFqIwwLCMjuzgrDyTZzG3Fh1e?=
 =?us-ascii?Q?xLT+LFLzEhJ7uvaH3m3V2oj/YWGLVdIH0/Y5S8MBFoguMLJZ72A9+1UpB0Xx?=
 =?us-ascii?Q?H6i54e26eE/Fv4gXXlN69mzSXnXDRA8CzSpf2StK5yzq11EuoNWkWNOq8ELQ?=
 =?us-ascii?Q?u+f7Kl0MBeu5P6bwIW0z5q4NZon8gHh9IRkhqyY9GBmnvNR2djcajku+9pyP?=
 =?us-ascii?Q?WLJiubmIFOLgoOYGRZa/eP0aulxfhR9VNvHH+d6lHw1/5cJKhgfxVN+lsGVv?=
 =?us-ascii?Q?VQFU5FC1tcqbCCafF4gHC0w1WJIF34fjwK2yrb0nRRDDv8AWD//xQJUyB5eX?=
 =?us-ascii?Q?RQyVcstsY+dDz4R6x7CuhQB7IR7QJu/YQwkMBxHlC6Ou/1Ha22PdWM2S4Gf2?=
 =?us-ascii?Q?JUsxvdYKbXXDINep0Fu6d3VgKVxacFv7gjjPpXMYZN9wnYykWt0EStkdVIJE?=
 =?us-ascii?Q?Nzkprzt0/Bk7Irobj8hFhBG+eD9O+8extG2UrO7DITSR4OlF29pfvJMGhQME?=
 =?us-ascii?Q?GGymPZy5zjeclKyqfAzMoo+GoH9eIWFE4Tnp6/onZF3kaJFGRVjbGfkaBvaM?=
 =?us-ascii?Q?hRRwSB9kkp4bptUBPUJ7l4xzzUmKvwJCqzxMy975AeMAoYn27jT64472WGfL?=
 =?us-ascii?Q?bsLxwl8wTYu76rAeqS299DglCKWmY66Ay9eheYfy+NH9u8d/YYBus4xzLyAJ?=
 =?us-ascii?Q?/GpI2PN60vNhNyaylccGW5y3/n4RPzYF4eV9HlL34ix5ARe4Ue65TRObVQ55?=
 =?us-ascii?Q?EwhUlqmkTJfTJNRe150etIgvXjGx+uF5H8Rt2cHYyshPLQtutNhowo04PqhJ?=
 =?us-ascii?Q?pw/KW+RfujIYpbr8Wp3XceL3UZ+up95/e028VMHKbNPkRO3NLQyIixTWt8A5?=
 =?us-ascii?Q?LX7ZjtwR3crVAtp8pKZ8EuQtv1lC90Kr2zk3rDWCVYhBbPwbIz4VzynyX/9+?=
 =?us-ascii?Q?Qp5yCss7nmp6QR5QUXqfLOpht+n0GQUn89wAKI4EmPyL3hmAFCSFXz3Bk/Yz?=
 =?us-ascii?Q?8hL2MuB7ierh/UgLHlxpxcXDgq1zXVuJXKZ2U2iywTdlP0qe7TuH4uq1Ydmw?=
 =?us-ascii?Q?zKczZ09arHn8y+bmU2q4Vr/HClhkH4LyOmk1eBjfnX2ugQ97WcYncc+0ZzbF?=
 =?us-ascii?Q?+/kZaCZ9FnlBKNsLyfiBiVWWtV5azLcBxU/7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 02:18:14.4611 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c783436-b164-4489-f947-08dde1222659
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5778
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

This patch moves the initialization of the VCN supported_reset mask from
sw_init to a new late_init function for VCN 5.0.1. The change ensures
that all necessary hardware and firmware initialization is complete
before determining the supported reset types.

Key changes:
- Added vcn_v5_0_1_late_init() function to handle late initialization
- Moved supported_reset mask setup from sw_init to late_init
- Added check for per-queue reset support via amdgpu_dpm_reset_vcn_is_supported()
- Updated ip_funcs to use the new late_init function

This change helps ensure proper reset behavior by waiting until all
dependencies are initialized before determining available reset types.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Signed-off-by: Ruili Ji <ruiliji2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 60fb50a03a63..677261e8d629 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -113,6 +113,19 @@ static int vcn_v5_0_1_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
+static int vcn_v5_0_1_late_init(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+
+	adev->vcn.supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
+
+	if (amdgpu_dpm_reset_vcn_is_supported(adev))
+		adev->vcn.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+
+	return 0;
+}
+
 static void vcn_v5_0_1_fw_shared_init(struct amdgpu_device *adev, int inst_idx)
 {
 	struct amdgpu_vcn5_fw_shared *fw_shared;
@@ -187,10 +200,6 @@ static int vcn_v5_0_1_sw_init(struct amdgpu_ip_block *ip_block)
 		vcn_v5_0_1_fw_shared_init(adev, i);
 	}
 
-	/* TODO: Add queue reset mask when FW fully supports it */
-	adev->vcn.supported_reset =
-		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
-
 	if (amdgpu_sriov_vf(adev)) {
 		r = amdgpu_virt_alloc_mm_table(adev);
 		if (r)
@@ -1541,7 +1550,7 @@ static void vcn_v5_0_1_set_irq_funcs(struct amdgpu_device *adev)
 static const struct amd_ip_funcs vcn_v5_0_1_ip_funcs = {
 	.name = "vcn_v5_0_1",
 	.early_init = vcn_v5_0_1_early_init,
-	.late_init = NULL,
+	.late_init = vcn_v5_0_1_late_init,
 	.sw_init = vcn_v5_0_1_sw_init,
 	.sw_fini = vcn_v5_0_1_sw_fini,
 	.hw_init = vcn_v5_0_1_hw_init,
-- 
2.49.0

