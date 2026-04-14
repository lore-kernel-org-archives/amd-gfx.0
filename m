Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C98B6F9D0F1
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 19:47:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 709A310E65A;
	Tue, 14 Apr 2026 19:47:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tuFJw5aF";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011024.outbound.protection.outlook.com [40.107.208.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9058810E65A
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 19:47:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Np3YMe8mSo4ge7+W9ILaYATgk+dK8iD1ZNSGvQeeiF9NluD1n3+hCt15SXO/BVmIeIzBhG0sCkF0dU4GCLdLZICqWFyHI5Ydm085/O3dOYS2uOahPr2K6+ghOBUPp2YvJe5kVMRnNcYh2WXA2acJYI6xKgtH1+MAowTNqd8HApvPUiSLQMbKGXykfUirzB65W4Sdib4KUNdr3IsYZ25gOaqORYhwbrtanNFmCFtBXK6I8+XYN11o6eYAVEyHADrrBYb/Q00YyBmqwvishenOHDQapQEi8r4wgBYQ3Jd2Kyyc+YU1TXF6fQFVPz1wF5IRaxoSiAm5haRviU1qH6Y7UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxPR6xvBy5tQIid5huwfBQb4AUIBMhnY8iWuVIv2ItA=;
 b=G0RA53qbnSU5BjTVxz1ogzO4rOQalMiZXow+e396KSTWwNaB5w+PqYipU6CGy22ucUWAmjQ6ly+4M1a0Fz9ZFY4AMfybTnp8ezCklmkltD5k/I1GOlgdMgFuuNclmxZx2yj81DKGis5C5YJ88RW5XmMZQTMGXr2sqNiCmhuCUhWGKu9moBT9XEKZGICUgGBUBBudEcLRJACvlfz2LlopMzQIjqUJViXi+dZpO13RaxqL1QA1MC5lWOzt6uf0yUcKl5jvzMgDWQhlbmllhBn87Bt6CNJzEOAtaozsjLNANhukg8E3ksFSjXEzeWr5R3RhBz/65RIjVKqtMpsKqpJGOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxPR6xvBy5tQIid5huwfBQb4AUIBMhnY8iWuVIv2ItA=;
 b=tuFJw5aFj6AqlIomf8v0fHsW1eFwHMG43a3PjzMmDHxJu2LGF7zog5lU/xf3M02HPUZUkXDmL/IlBERakOtHyGLRlYwuut/Dg5yvd+yPgt9Ae93PWCKOcIBhBqn8sPCUdh01Vaz/NApFC4YhX73gPrxsRCICzTVB+I/UUCEuYgA=
Received: from CH0PR03CA0418.namprd03.prod.outlook.com (2603:10b6:610:11b::19)
 by LV8PR12MB9153.namprd12.prod.outlook.com (2603:10b6:408:185::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 19:47:08 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::61) by CH0PR03CA0418.outlook.office365.com
 (2603:10b6:610:11b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 19:47:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 19:47:07 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 14:47:04 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Apr 2026 14:47:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: support toc_1 fw load for mp0 v15_0_8
Date: Tue, 14 Apr 2026 15:46:52 -0400
Message-ID: <20260414194652.2213734-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414194652.2213734-1-alexander.deucher@amd.com>
References: <20260414194652.2213734-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|LV8PR12MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: c04478ff-460e-4bba-8674-08de9a5e9c84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SUKpVTuAOQJhkOkrUy6Q039CknSFXCCAZYd4EYwB1+dvh69oPE25/inMQV0fmfFTL4H55eW+2j4EeG3cc1qZ0CB4HSsW3LewYb5QNS3Reg71+/O4DdyaSkk+reNTYVTKHHCQtITc5fkisqurUpmm3bPj4jGzhlfUDxNLFBv7H+DoWVfnWQJwo32sCeS7m4GLERsIDUg7ewNmK6WPxWs0PFMMogWjDtXCGCeagNAcZzeCrlXU22EmWcNIUE4JJ0op9+KzOaWMIn1ldPU3/l+NGk1mmcAcZYWFyRScjQkkyrfRF08NXpbSwiKBv0/Y+S2TbeTFcIHEPCTWn3vC4PkydpOE/WQVunFPH8ppHGcKojzPYs7CYzgJZyKbAedcr+fUUXrdBXB5a0GF1tRhfxgMZ4vjPN3rJmSQCx03mAd/lNSXZ2jMuheBfPxLSHPZDJoeU6PSUN7R/QidMvZgtgDL/vD+cP9uK2sDHwW3sp30eDVDBJc+aFK19ITAjnI09oVe599ZLZafgE6WUQ3ZZAsvPuZusuRW9jaSjziALUj4JuSsBRhhyk1CS4mYW0743UDlurxr8AUGp1gpCDqgVjSWUgN067YNqSVdEtF8hmCgLEuvaIZo1/gxTl8s8BmX1w9DNT1UOfKhCCMzdUG003yHRuyzEh977FhYYbLKZXiQXBm9C9tGAfysMZbcAsxwbXC6UT/fiSDsdrgDUbuGqd0IUE5Ki9a9F5m1PUbhL+XajjYypR2vwtGpJyZSA7M57u0GO4uu0Z+Qrw8Ki9w+zqPNLA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MormFUzmh62J2B41hUzByoUxZmdB3dB5VCx0vH/Ql+1kfbE601SpMDgwo5BgLM/xMwpMLsTNxqnWydFV0BK8Ctxxi1ldhsgWDrxHMqMkKsCCPUB52kS603TaBL3KFc/4h26sXBg2wvvCLQmtnuobkeaWwiCcInz1gdDE9AO9yi1RlRcHIv0ed2dZXawRTzvdKVo64XMT+88EWc2pdolifa2FjKvw5JGNUpPt5oPGq7p0gix35SmRlVgIdzk1e103H72dgcb8Rro1fAz6c+FtZSBH4VShNWCAtlPOqLm7YEDePUrAh7ruaJsMRK79Go47Yy5OWkCrYblXykEESBYHXw4e+GZya04GmrOSK8bU/um3rSDkbZb7BcVOarPpX9onxeTWx8tWXoS4qQ/5CPEBpDNlLvznxdTzTTsYyEGJWVEqA5THNGDs2Wz/4YT6VA9i
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 19:47:07.5971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c04478ff-460e-4bba-8674-08de9a5e9c84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9153
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

From: Likun Gao <Likun.Gao@amd.com>

Support for TOC fw load for psp v15_0_8 rev id 0.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  | 7 ++++++-
 drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index d1b9e3381e192..e48903df60118 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3899,7 +3899,12 @@ int psp_init_toc_microcode(struct psp_context *psp, const char *chip_name)
 	const struct psp_firmware_header_v1_0 *toc_hdr;
 	int err = 0;
 
-	err = amdgpu_ucode_request(adev, &adev->psp.toc_fw, AMDGPU_UCODE_REQUIRED,
+	if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(15, 0, 8) &&
+	    adev->rev_id == 0)
+		err = amdgpu_ucode_request(adev, &adev->psp.toc_fw, AMDGPU_UCODE_REQUIRED,
+				   "amdgpu/%s_toc_1.bin", chip_name);
+	else
+		err = amdgpu_ucode_request(adev, &adev->psp.toc_fw, AMDGPU_UCODE_REQUIRED,
 				   "amdgpu/%s_toc.bin", chip_name);
 	if (err)
 		goto out;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c b/drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c
index b2d7cbd894c03..ec20cd5eb7552 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c
@@ -32,6 +32,7 @@
 #include "mp/mp_15_0_8_sh_mask.h"
 
 MODULE_FIRMWARE("amdgpu/psp_15_0_8_toc.bin");
+MODULE_FIRMWARE("amdgpu/psp_15_0_8_toc_1.bin");
 
 static int psp_v15_0_8_init_microcode(struct psp_context *psp)
 {
-- 
2.53.0

