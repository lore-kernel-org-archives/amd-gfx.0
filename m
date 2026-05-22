Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0996CD5BB4
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2026 00:21:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01B2310E555;
	Fri, 22 May 2026 00:21:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KUj2RbcL";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012063.outbound.protection.outlook.com [52.101.43.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7491010E551
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 00:21:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fu7P6h44aIfKoJx7S8VWjduusYuiH3KB53FC6BWHKmqqzYpdlkSvoAhcGrh/EaSkXUVcutWIrvu2wxLhNb8aRNfz0oMujHOYg/mPczi3hB45dxlkcQAEeK84t6kO2wvFYU+PNFZE39nybAD81qvzKaFpUq8Z1f6OLZW/v96iasnUwCGhOrEPoo4XGFjyv+3ZXKTo1MirDVzhXagmLgaJBj/L7FNbkz2V8jjBQ+jd5bo7S4Wr4zasoVcztr2ZN/3Endxncyu0VaI+9Uy3SV/0ZzhzkQJ4Mx/gAuDt4hZAIhSRTvyYqGc03zVHPMib7aZwTN1cKh6o5yoXbzWs2m8sjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozWPuUPXlIYFoUnOGBkf/37/XiLP3RhlSMCo91FM5vo=;
 b=j9thO2qdDnI7fqrPRDztGxSkVI4xqQ4N3bNoNkNUvlFWSiRC4Vab/u+yzMi7rDdbdlqfZJ+NS+pL4TvI/kvreU6NSbsdo70kkhRxtlh4MuNQXZC1f1rmmcr4rsoxoQog3kII8EdGUOni3c4CzoCRXAIWhVBs3ZwnLAA6B7Q+tEyb19WFEgjAJigTXoS4TF1PikirquZPTyJxf5CkUoFmtF6FL/erDzgqJhQdKS0uzahYs3QS321xa7bysU3nq91Qpb2I/KTnn6sfpO2aKRi4vsnhjHhbukkMhGjc1wsPyyfk8JdzvqflBI1NJDP5kq0jVbSJ2uqPKsw/90oMCwpPRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozWPuUPXlIYFoUnOGBkf/37/XiLP3RhlSMCo91FM5vo=;
 b=KUj2RbcLm7HoRKtKb8manqywYwPdjtMlA5Ekr19OtgFr+NBh1h7eejI7pvUKVbnua5+NIWKiVmKD/RoXqFYjAUB48tw7dxXsLzRcvNAkT7U7u91k9v42ipM739iM+vA+B4kzFWvZxy8onJ1x2MjumUWQijnOBe0TnS54M6gP5AU=
Received: from SJ0PR13CA0162.namprd13.prod.outlook.com (2603:10b6:a03:2c7::17)
 by PH7PR12MB7020.namprd12.prod.outlook.com (2603:10b6:510:1ba::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Fri, 22 May
 2026 00:21:22 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::17) by SJ0PR13CA0162.outlook.office365.com
 (2603:10b6:a03:2c7::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.15 via Frontend Transport; Fri, 22
 May 2026 00:21:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 00:21:21 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 19:21:16 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 19:21:16 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 21 May 2026 19:21:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sunil.khatri@amd.com>, <Amber.Lin@amd.com>, <Jesse.Zhang@amd.com>,
 <Shaoyun.Liu@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 10/42] drm/amdgpu/gfx12: only need to remap KCQs when reset
 via MMIO
Date: Thu, 21 May 2026 20:20:16 -0400
Message-ID: <20260522002048.98506-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522002048.98506-1-alexander.deucher@amd.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|PH7PR12MB7020:EE_
X-MS-Office365-Filtering-Correlation-Id: f99f3f0e-e5a3-40c2-bc0f-08deb7980d54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|11063799006|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1DVIx8aTYQ+uBCSLK77nXdraqNSrQCFym1SJVywCFtQXEcMUR9TxL7Oap48DpxLv8S5nLJGKKP1Inx+k95w6SCXZoKIpv4UT8HBloGmyiba5JLkN55cuUPwZYNQhM2wjIKkZXYCBfTZni44btxFlXZNf+0GWJEFl7sx5NRn/7vhI1BNLJgLUS9ZmyHsANYH2ltW/+uaw1VTPKyCik49tAAx+XvyM0s+c8LNFdOuoL0GRylzYva/1GwRi/dFeQVHKdUYNnRPNRH+HIin8g2KvrLWlkwdIaUxDG1SSBNqIwAuuq4u1Ydd/1FbAZ+npzf0ZdU85AfXo6nWdq9eJpR9Te5Htv86Jl3L/6A/bnsQHmuGW4wLEGpEljgUuok7yeMpNj36eGAPrlgyqDn/BUy2fMqwC7cDFC6rWa8jR/EScIEr3XBFJPYMqOv9LQetVZzxNmqyqjZnIAAmlwZEcJt6fy1hrfryH21EflKCAzxTaKpUrbT7hj96twvTki7B4FteNCOWS5CodL9OBlOIaTZIoH4000HVJLF68+Xuj6vVX1tET2K+8MFNF8fKF1PtthdvZIc/p9CKLg5nOfUIO29gcN/gLD1w5VNqGzcFfuwApIZIqAagEO7rKK+O5Cbj1eOHCeVTE+KbBrjxrXqRREIxJzYpJGly85Vx5GssyOQ3v62eqcXlIaMDlYzQD9z0n2BMHxdhUgvGAaOCyXLgPkb2tOwEOiqCcIvZZ08ok/LKqFaU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(11063799006)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PoztCB4N6yFe/E6AtrVXYcWlbDT6ffHv0uqJkwSrB75hfbE1UPEZvq9W6/kI+ssTr+rd59AmFUln9w/Y4mRtzq/dWmeIhjNNgJwiWhG5OKsBGyHy2G3MJADzkORTL3gZPGV3kTtcU0hyXw5UMEnYFnNxphWBONgT7vOni5YXNTOB4LOB9aRSfX9fLl3M9wjZM+gaZMj1VMcxL2Ms1PCERpagPERqM+mJFPEzzJApXcCx/XO6EtVjBGKtdaaJGtY8jFtAtAu7BnhydGT2ewinngrfFBsuGyENlBrk/ku9wr4Whda23b0oAZMDSBC8wsrqGXWBgCZcJBS0c3eAS7JPBi35vLRoCIR4LtaQN/YiBeos7KIMSqtkLcd32oXHfr+QVF1VmlkcgeVsaPiY64MepvEXiw0aLhBtxgwI0lgIfNe/5ZwqwTw4ad/kxM/x3vJX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 00:21:21.8403 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f99f3f0e-e5a3-40c2-bc0f-08deb7980d54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7020
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

MES remaps kernels queues as part of it's reset sequence.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index f47928dcd8480..4be650ce1fba7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5397,11 +5397,12 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 			       struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
+	bool use_mmio = true;
 	int r;
 
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
-	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true, 0);
+	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, use_mmio, 0);
 	if (r) {
 		dev_warn(adev->dev, "fail(%d) to reset kcq  and try pipe reset\n", r);
 		r = gfx_v12_0_reset_compute_pipe(ring);
@@ -5409,15 +5410,17 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 			return r;
 	}
 
-	r = gfx_v12_0_kcq_init_queue(ring, true);
-	if (r) {
-		dev_err(adev->dev, "failed to init kcq\n");
-		return r;
-	}
-	r = amdgpu_mes_map_legacy_queue(adev, ring, 0);
-	if (r) {
-		dev_err(adev->dev, "failed to remap kcq\n");
-		return r;
+	if (use_mmio) {
+		r = gfx_v12_0_kcq_init_queue(ring, true);
+		if (r) {
+			dev_err(adev->dev, "failed to init kcq\n");
+			return r;
+		}
+		r = amdgpu_mes_map_legacy_queue(adev, ring, 0);
+		if (r) {
+			dev_err(adev->dev, "failed to remap kcq\n");
+			return r;
+		}
 	}
 
 	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
-- 
2.54.0

