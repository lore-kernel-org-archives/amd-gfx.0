Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4395ACD98F9
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2026 04:45:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9D6510EBFC;
	Thu, 18 Jun 2026 04:44:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5OjainiV";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010033.outbound.protection.outlook.com [52.101.46.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF08510EBFC
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 04:44:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8pSz14ZZV1suokOKi0hzwnmx+rK9jbY1S4mk1ilcVk2MTZgupQwGmMTjn2tEsGXUJOMZ2Qgt7Q+bkCWUB/uLFZD0syRI93LfAni8Dd2l78I2Hfe9vQrF7dcaVTFYOmsvJSkM3EUDc9VmqRQgQmTpPwx13bYi8lRs49R+BQDpRmVxKh0ApyUzCMFJgdDGNmdSsYNpsikhK5d9uc8parngT5qVnUaR99tKJkGrmaJCmqMiM9x0+6A3GoPA6WmVagnRbm/ylgENSeXhQbGiwG7TIbGlBFdWMk6ePx1vw55R2afsTuTdV8QuEMWAyusaxeGfPgxpdhdn6VVGpF5Hfbq8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLaWPLaqFRFMHheutJ+F78mp+WqQuudVIuqOuEWUo4I=;
 b=tA2wpKjogI+ZmfIg++0c4Dl9YHlbaRLfL6Op9SH1+gf8C7JSFliqeCHK7P29AQqo7xH57eijN3bd1oWbIOcFZS4PjVFiyUFh+L7AIDF/Dxl4y90Fc++ZfS0BoVTpUixkxZgMTbqmd8lKqxDG0JjefZTzQb6cEexGZPcYQEFPTz9eaApLW3oHWgfvQK2nDiCGGPQ3o88uLwySmWlVGIfn6JcfX0WUtKgd6lt6/goFnQAsD8NqNKSvNfa1MhMyFmRlVKCDtD+Da7yugCOe+Bl97Ylf3l3JbXuuK4XOiGb+jrRBwBxZQFetrrbCtq6Y7xDcdc95Pkb1bnbEq7mi7wdUQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLaWPLaqFRFMHheutJ+F78mp+WqQuudVIuqOuEWUo4I=;
 b=5OjainiV2X7wCxz4+IcOWh64XOrADe4KoKGQ8MDMJ8sXovRHVnfLgX8ksQ2ak5TmRn6GvW66k2T+4Noq0JCQrPQ47vQVAS6qGQ0KMztZLIaynh0dAw1CNbq9YFSAPmwH10unCxp9/d18ptkghe+e3+Xm5l+c0IrwRVNlqcLbf6A=
Received: from BN9PR03CA0887.namprd03.prod.outlook.com (2603:10b6:408:13c::22)
 by LV8PR12MB9153.namprd12.prod.outlook.com (2603:10b6:408:185::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 04:44:54 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:13c:cafe::ab) by BN9PR03CA0887.outlook.office365.com
 (2603:10b6:408:13c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Thu,
 18 Jun 2026 04:44:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Thu, 18 Jun 2026 04:44:54 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 23:44:54 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 21:44:54 -0700
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 17 Jun 2026 23:44:42 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v3 4/5] drm/amdgpu/gfx11: fix EOP interrupt routing for KQ and
 userq
Date: Thu, 18 Jun 2026 12:43:39 +0800
Message-ID: <20260618044405.1724370-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260618044405.1724370-1-Jesse.Zhang@amd.com>
References: <20260618044405.1724370-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|LV8PR12MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: 50e7c92b-e1b3-40c1-553c-08deccf4578b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: BYDDobhZvqF8YJX26xO+Vxz5Jso0VKqlh/kJiii4GEnCKjsTzgp/MSzflXC0XqNrR+x3LzYMwfVaNLdaIHNJFMo61oqRW8l2DSCCcxt3YAW9Q3COxPUgCs/6AwFbG08loayf9HIe1e6vNfixqIj5CYldRqRN16D7raSkuMmdZT+NmKGTcFV/ZsdMysouWg70KtdVg42QiJRsnhVXev7L9g4e4ChjcW1UhDcMKSUFPw53Cmv0RIAAk5Y6UL3UqogOsOuJTwJ05bnGQ4Roa3f+cT/cAeDrhzVKTW0M6ysGZLu2CT140ghlwXm5yQkVzOBZ1+aKshzmXjsLF1YnpBf05EzLCiptQBiK/3lhcRVCLqEbq5Nh8bEMQyJ3CN7BDaiN/1uRA4s2BE/y7iXHJyrZtTryR7FjfR1zeDx5N+ekBjzDVrEpHKrhsTmEZPk4VBsGma+Z7fQ4lvr0J2fzj2aJIQ8TlabOWMSBlzOryU4Q74BrHmGN1jx364ZfOtXWJus+/mij6msWvG+798r5F+X8x5H7IS4RiZ+CYVopsK7dHR4/wOhT2456i0CHc97Lh9542RUjdtiCZsmKRHopxxqC09up6HSAiCVxC5YIcEkRAfCxVIIxcAiq78nXYq18BFx3JpDp5QlUY+n0GsSSvQ7PB3gx6LpoZma/CN6bXwkkYSArgm+ZFFCRL7S4lDXB+mEtuSG4TYtQlyO+emKH1dLrEvyg3unxTx3ej3eVoTFgJf0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9tHyKHod9emMQHC4Wm3EDFltkCMWcwXI+o3K5X7pHSxlbFrzxKCrQUmvxOXs98lzQ83WUkkGrnYry884Q1OwQHNaVAhzdWHaU1+Mb66ZTbVozgFeB4KKdIucsqDK2n89NaftSjfAcHHbiVvLjIKSIYoXkrRvLUsN20fyc11Moin1NiIaysd03335bnylfaSlYUlVu9bv9NNPmFawiskGESABEIbTwGI8EslFVua5+cSK1vXVCfyWBhDkmVoeVT+sSQ89dqyJ0gIAXrK3/w2X4tgdzjgTXBsDaleAw+O+jR+68SeDhVGHWEmQxPWj3mWkwofNoUMkR4kaNJVdCpzesIMXhOO3PvM1xtGLiBFxX/4aYgcqTe1eibgB8KoWvlCucTxDgWbP6Im1oArQmLS6uLPosfrNvlTaliTUAQt98nFFTK5dnszKhpOHLwSWo+IG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 04:44:54.5617 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e7c92b-e1b3-40c1-553c-08deccf4578b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFE.namprd05.prod.outlook.com
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

Try KQ by ring_id first (KCQ and UQ never share a HW slot); fall back
to amdgpu_userq_process_fence_irq() on miss, since KQ EOPs were
misrouted into the userq fence path when enable_mes is true.

Require a strict (me,pipe,queue) match in the gfx case, then userq gfx
EOPs fall through to amdgpu_userq_process_fence_irq().

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 43 +++++++++++++++++---------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 7c86beeb058c..c8b0971320d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6517,25 +6517,33 @@ static int gfx_v11_0_eop_irq(struct amdgpu_device *adev,
 			     struct amdgpu_iv_entry *entry)
 {
 	u32 doorbell_offset = entry->src_data[0];
-	u8 me_id, pipe_id, queue_id;
-	struct amdgpu_ring *ring;
-	int i;
 
 	DRM_DEBUG("IH: CP EOP\n");
 
-	if (adev->enable_mes && doorbell_offset) {
-		amdgpu_userq_process_fence_irq(adev, doorbell_offset);
-	} else {
-		me_id = (entry->ring_id & 0x0c) >> 2;
-		pipe_id = (entry->ring_id & 0x03) >> 0;
-		queue_id = (entry->ring_id & 0x70) >> 4;
+	if (!adev->gfx.disable_kq) {
+		u8 me_id = (entry->ring_id & 0x0c) >> 2;
+		u8 pipe_id = (entry->ring_id & 0x03) >> 0;
+		u8 queue_id = (entry->ring_id & 0x70) >> 4;
+		struct amdgpu_ring *ring;
+		int i;
 
 		switch (me_id) {
 		case 0:
-			if (pipe_id == 0)
-				amdgpu_fence_process(&adev->gfx.gfx_ring[0]);
-			else
-				amdgpu_fence_process(&adev->gfx.gfx_ring[1]);
+			/*
+			 * MES splits gfx HQDs per (me,pipe): KGQ owns queue=0,
+			 * userq gfx owns queue>=1 (see amdgpu_mes_get_hqd_mask).
+			 * Require a strict (me,pipe,queue) match so userq gfx
+			 * EOPs fall through to amdgpu_userq_process_fence_irq().
+			 */
+			for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
+				ring = &adev->gfx.gfx_ring[i];
+				if ((ring->me == me_id) &&
+				    (ring->pipe == pipe_id) &&
+				    (ring->queue == queue_id)) {
+					amdgpu_fence_process(ring);
+					return 0;
+				}
+			}
 			break;
 		case 1:
 		case 2:
@@ -6547,13 +6555,20 @@ static int gfx_v11_0_eop_irq(struct amdgpu_device *adev,
 				 */
 				if ((ring->me == me_id) &&
 				    (ring->pipe == pipe_id) &&
-				    (ring->queue == queue_id))
+				    (ring->queue == queue_id)) {
 					amdgpu_fence_process(ring);
+					return 0;
+				}
 			}
 			break;
+		default:
+			break;
 		}
 	}
 
+	if (adev->enable_mes && doorbell_offset)
+		amdgpu_userq_process_fence_irq(adev, doorbell_offset);
+
 	return 0;
 }
 
-- 
2.49.0

