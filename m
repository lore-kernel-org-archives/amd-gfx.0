Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12823C43334
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jul 2022 18:01:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A14D118A6BF;
	Wed, 13 Jul 2022 18:01:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E11218A6D7
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 18:01:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nss2lpMxwFvrXYxSlYoOtjdcJBPZTBL1Ff2U0fo6IBn3rxe3QTFwJxcsnLqr5xfVd40nwDBUpL0XuXpw+ciJpYxpmc/7D5DlcUCm1a7EmfcEJI7QzDiB2oxnCECMK4WaE+MyKS73czw+08gMlMtopLblH7Go2kUD+gEJJRA4AinTo9YKEMlv86kv3ik8tsQ66agmhhvgGRYopYdljhxN5aI8HoGTIQY+H7G7PQPuIINdtxqI5bFmtTV9nuYW3z8ydYfxsxkUkFtr9XQfbAea7phrVAlO0PDxfRHzSahPruZRqybcU5S6uJ6x+O0WqvWEVXB2D0ascux2aGzZCYuwmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvXzrqUyek1HJFG9kMtI75DTpfF0XV+FAVmLFeA3Gp4=;
 b=c55D/AT5xqDfPiyFTM9XhC353IC4e4QEOwQkOcA0KM3wtDHtepEzlCfHFqLpKnjfOM2+Q01J3fEN0qQkWcBxN3hwHjVaHPgCAr2Xi5ywtLZ+hRbw/55Solxdp0vqvmgbu8AepztBT5UaY/Z2NICxB/v9XUjSngfSX7marje1mF5pV5mJuooodE8Hn81gz5CzlFLn2uJIeWDhZMDdfSwZHteLtwHDU8jTzUErFWYADB/MR5TSOsitFfhFQbaoFIAcYg9BxOSdczbZ5BsfwxLgFluw4l3vMhlGSwH0b7840s6zGlUxe8OhUfapM88rmLgJ1b8dlbBwrUq5pV8BY7n9tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvXzrqUyek1HJFG9kMtI75DTpfF0XV+FAVmLFeA3Gp4=;
 b=dM10It09I3G+dvT6y2d8nofsdcaGThFTIxOytusS+Uf1qf4zPfIEApAjqGJrEzeLNHSCoiK0J4F+rBHcdlswZN4/Jj0nkVH+QxrXA78qvBnFKVYT+fvMXexEoZWhufzcYbenTXg/LZnSB3G8X0hskNm/XhH+qC2PAnsTmBZq4hU=
Received: from DS7PR05CA0037.namprd05.prod.outlook.com (2603:10b6:8:2f::24) by
 CH2PR12MB3976.namprd12.prod.outlook.com (2603:10b6:610:28::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.21; Wed, 13 Jul 2022 18:01:34 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::43) by DS7PR05CA0037.outlook.office365.com
 (2603:10b6:8:2f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.8 via Frontend
 Transport; Wed, 13 Jul 2022 18:01:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Wed, 13 Jul 2022 18:01:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 13 Jul
 2022 13:01:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: use the same HDP flush registers for all nbio
 7.4.x
Date: Wed, 13 Jul 2022 14:00:55 -0400
Message-ID: <20220713180056.529423-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e337d0e-8dca-4128-0bdc-08da64f9b6cf
X-MS-TrafficTypeDiagnostic: CH2PR12MB3976:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hwcn9sgRqqDrufZHx2Zp06MHiTDF64QYHbvN5KfVTGRUt6NQ/aM5fSSqeC0dIL0KIvaPvwk+7bRLwbnl35DVXBcAvspIExPO2wFlSaDiX2J6TaYYwJjW+I/Z4YCGPBGszm5xUvsjTc9l/xBY4XOCB0wy+kZu6z/kl0Lkm4HbJTbV8wRhI8m5gZZrv5Zc3tk8eLQf7JUPrwIPiMvzBegDg8SlW3QdAfL/NKITRQnkICjMhvyzHSIzvsM/tKYWXCBbYSCVEGLw4JDerlS0B0S1z40wmK8vmAMo7V/2f5hcxAYcso8DM5+i4bqd75SjOl7Gug4mHvnkrE1Zpfdt3Kgv//Aextg42kVy4h34LvfMQVixXPjYgYegfGy00ArTxWswmdxPL5nzT3ZpHobqx+HnieWNvaUtxv3ej7agm6DMeQUkDsgHgm0pNPTYsX9tIyHMvrhkOLa5zpY+sOQWi54Bq9pNv5aDW/LOFcgquSlp98dBCFipXNwwIBUqbxjojHYcOjDa7zUb+kRdGhEg8BNa60QwfLplVmywFrpLuduwF2mbYghT2mhildlq/2z0llMgKRN7UIc54gNmQSqpaQ/DdGhmt2wlBxNlDtswKz1B9invyA3MrdMlNYhAtIiuUioM79fb1dhd1yBo+XU4i74R6SoipTPPe3bk1LKkRBOKBqrr8FDFr218m1mqw7AOk7uL7JfUrgFbfoRQCWuVlFrxUYg23SUBKIdX1PuMOyyM6J5uIhG7EtE6g2aWgTFzfLDEu2aof71fHwAkeLeGSQ0MJ7Rp8Tp9Zbn6kGg9AWJHbYCzs+8U4sy8IBr1c33JIkFPm2gkg+Y/B5dbgtezUqT1GPtBJs1+CgMpVuSOnsVf8ns=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(39860400002)(396003)(346002)(36840700001)(46966006)(40470700004)(426003)(186003)(70206006)(86362001)(6666004)(82740400003)(70586007)(7696005)(47076005)(8936002)(16526019)(6916009)(1076003)(8676002)(26005)(41300700001)(4326008)(40480700001)(478600001)(356005)(2616005)(336012)(83380400001)(36860700001)(36756003)(81166007)(2906002)(40460700003)(5660300002)(82310400005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 18:01:30.2065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e337d0e-8dca-4128-0bdc-08da64f9b6cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3976
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Align aldebaran with all other asics.  One HDP bit per
SDMA instance, aligned with firmware.  This is effectively
a revert of
commit a0f9f8546668 ("drm/amdgpu/nbio7.4: don't use GPU_HDP_FLUSH bit 12").
On further discussions with the relevant hardware teams,
re-align the bits for SDMA.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  5 +----
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c        | 21 -------------------
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.h        |  1 -
 3 files changed, 1 insertion(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 9c5f29159a2d..4f83897a54a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2213,12 +2213,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(7, 4, 0):
 	case IP_VERSION(7, 4, 1):
-		adev->nbio.funcs = &nbio_v7_4_funcs;
-		adev->nbio.hdp_flush_reg = &nbio_v7_4_hdp_flush_reg;
-		break;
 	case IP_VERSION(7, 4, 4):
 		adev->nbio.funcs = &nbio_v7_4_funcs;
-		adev->nbio.hdp_flush_reg = &nbio_v7_4_hdp_flush_reg_ald;
+		adev->nbio.hdp_flush_reg = &nbio_v7_4_hdp_flush_reg;
 		break;
 	case IP_VERSION(7, 2, 0):
 	case IP_VERSION(7, 2, 1):
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index 4531761dcf77..11848d1e238b 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -339,27 +339,6 @@ const struct nbio_hdp_flush_reg nbio_v7_4_hdp_flush_reg = {
 	.ref_and_mask_sdma1 = GPU_HDP_FLUSH_DONE__SDMA1_MASK,
 };
 
-const struct nbio_hdp_flush_reg nbio_v7_4_hdp_flush_reg_ald = {
-	.ref_and_mask_cp0 = GPU_HDP_FLUSH_DONE__CP0_MASK,
-	.ref_and_mask_cp1 = GPU_HDP_FLUSH_DONE__CP1_MASK,
-	.ref_and_mask_cp2 = GPU_HDP_FLUSH_DONE__CP2_MASK,
-	.ref_and_mask_cp3 = GPU_HDP_FLUSH_DONE__CP3_MASK,
-	.ref_and_mask_cp4 = GPU_HDP_FLUSH_DONE__CP4_MASK,
-	.ref_and_mask_cp5 = GPU_HDP_FLUSH_DONE__CP5_MASK,
-	.ref_and_mask_cp6 = GPU_HDP_FLUSH_DONE__CP6_MASK,
-	.ref_and_mask_cp7 = GPU_HDP_FLUSH_DONE__CP7_MASK,
-	.ref_and_mask_cp8 = GPU_HDP_FLUSH_DONE__CP8_MASK,
-	.ref_and_mask_cp9 = GPU_HDP_FLUSH_DONE__CP9_MASK,
-	.ref_and_mask_sdma0 = GPU_HDP_FLUSH_DONE__RSVD_ENG1_MASK,
-	.ref_and_mask_sdma1 = GPU_HDP_FLUSH_DONE__RSVD_ENG2_MASK,
-	.ref_and_mask_sdma2 = GPU_HDP_FLUSH_DONE__RSVD_ENG3_MASK,
-	.ref_and_mask_sdma3 = GPU_HDP_FLUSH_DONE__RSVD_ENG4_MASK,
-	.ref_and_mask_sdma4 = GPU_HDP_FLUSH_DONE__RSVD_ENG5_MASK,
-	.ref_and_mask_sdma5 = GPU_HDP_FLUSH_DONE__RSVD_ENG6_MASK,
-	.ref_and_mask_sdma6 = GPU_HDP_FLUSH_DONE__RSVD_ENG7_MASK,
-	.ref_and_mask_sdma7 = GPU_HDP_FLUSH_DONE__RSVD_ENG8_MASK,
-};
-
 static void nbio_v7_4_init_registers(struct amdgpu_device *adev)
 {
 	uint32_t baco_cntl;
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.h b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.h
index 7490022d79d4..f27c41728822 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.h
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.h
@@ -27,7 +27,6 @@
 #include "soc15_common.h"
 
 extern const struct nbio_hdp_flush_reg nbio_v7_4_hdp_flush_reg;
-extern const struct nbio_hdp_flush_reg nbio_v7_4_hdp_flush_reg_ald;
 extern const struct amdgpu_nbio_funcs nbio_v7_4_funcs;
 extern struct amdgpu_nbio_ras nbio_v7_4_ras;
 
-- 
2.35.3

