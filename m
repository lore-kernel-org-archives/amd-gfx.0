Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34AEAC35FF4
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 18:58:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0BBB10E7B3;
	Wed, 12 Mar 2025 18:57:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2TdwtH3l";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BEAC10E358
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 18:57:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rlK9DRIobd5R9eadSqsAozWyOUyowIZ0HxXm+Mix6951k0e9+rab/z5MjwwJNDxgViJz51ybZKyUlfCXiWeFZAjgxm08q/1NKsopUlEFkWUj+IMLv/w4f0wpZ3K48JF8eLnayIMTCDeVR1eytRqSbPBD/JkpTlJUwwyWInBYqZpEnfEv2v7c17IyWOzdLOHBsdo1Tjdxmp54MzBjoFwzMIIlYEhg2UZIf04rtin8/sSEd877TjF/Rohh5g4ZgUNacKG3W6JUQnl/XuTdE984gPVesxQmzXKRDTIhT+3ajdgK0MWyPjGS1nFdiZxcP0FeSpns0eZKiZOX6VSjW+qxpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLpCtqvAbft2cYbYONqC4yHRw/otChaFOMnPUaYHTM0=;
 b=hPSfrEtM9dF/MjVajzFNGbAEMsLLkjlLQHbdlbZIc44Dl7YzNsKd6w4Nd6XcyxqS7MJ/SSZyAUxnpvXJhu2+el5I5cELphb0XuDJQumPXSTB7zv4MdTsKNCJaVDS2aw5fZpKf0csh09wdH1kGdPKAD1ij0d8Sh1b3Td1ApOexv10M/zYCcj5Wj2x4SgVxDp1h3669xvHlS3BRGaV9dltBJxsVY9slNO0m0fqji+5yMdzyZDMxRYHE5ok6qP9UtjO+UpbVysUscrf4s3vdMKSqQRw0y9dWXnSbug6zRu03VVjEiazpH2KmgmpScEjZQwmHeV7/XT+MauwPeb43Aw4Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLpCtqvAbft2cYbYONqC4yHRw/otChaFOMnPUaYHTM0=;
 b=2TdwtH3l9lZb5NgjQlV7F1UmOvp99KR5sh7mSJjopmX8X4C7/U/Nd/OoBojpIqUOpXWv0CvUzMvdaBx0AJTNtpNyoTDZG+3+f0bigElkLZ/5dEOTBWLLa05QTb6ctX5Q/4xpN3u6rjAUlayhpVKbMKMxWoSVcpw2FFrzbRlQlr0=
Received: from DS7PR03CA0238.namprd03.prod.outlook.com (2603:10b6:5:3ba::33)
 by DM6PR12MB4236.namprd12.prod.outlook.com (2603:10b6:5:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 18:57:52 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:5:3ba:cafe::71) by DS7PR03CA0238.outlook.office365.com
 (2603:10b6:5:3ba::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.26 via Frontend Transport; Wed,
 12 Mar 2025 18:57:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8558.0 via Frontend Transport; Wed, 12 Mar 2025 18:57:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 13:57:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/11] drm/amdgpu/gfx11: add support for disable_kq
Date: Wed, 12 Mar 2025 14:57:27 -0400
Message-ID: <20250312185731.211350-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312185731.211350-1-alexander.deucher@amd.com>
References: <20250312185731.211350-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|DM6PR12MB4236:EE_
X-MS-Office365-Filtering-Correlation-Id: 81d96e46-211a-4d32-9b8b-08dd6197ca6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xNM1a8JRCUkcyNB++RC2zpfo3IjbYnas/Zu4CMK44LHVbBdeeWIsK6M+/gNO?=
 =?us-ascii?Q?05dDJcwjBEBrscT/gSoqW4ErugxJ+M96Y6X42/AiGdnZx5A+nPrrK7zbn+Zc?=
 =?us-ascii?Q?Gx66XKLsjso21FZrh3sjkoSpmh2xOZEKCvPsqG5T5tjnl4YLF4WJjHQNdjHa?=
 =?us-ascii?Q?A2Lajxw1ZDCYDhlRgysL3Hf1VHy445TQ1SHL74o53OgGMBKsCD8x7iuz4DBS?=
 =?us-ascii?Q?btX/H2585T0Dtaf8YGWVLXVLuNusQqFEND4DaZmfpDeRW+/uuFAHbSP3AFcp?=
 =?us-ascii?Q?hib617hzQf/nGdrDtkM9sGXw8d0YLVKVBRggDsuctUIWLDvzwAqfYHgB4j25?=
 =?us-ascii?Q?pltAAQvAHSFFXXVj/qhVkDhhZ70YYfDco0UNubNc2RzmEaQz123YDnnhLHw/?=
 =?us-ascii?Q?SCYljzOfQNFKt3QJrvEhxzAdHMfF7WOZENBACW6NbEZ6uZPOi2rwT7muJQ0m?=
 =?us-ascii?Q?s9o+YeOUZnx4+G+F+hQsWO4/97RER8ZJv179EAztHg742kUQ3LGvWsp95nr4?=
 =?us-ascii?Q?5zo5gYzxkDD9zcTcS4HigJvJRzxV/Ed/ILiHxMkdGt72tXPHWp9U2gnJr7q6?=
 =?us-ascii?Q?BHTeX00wzM77e7ZVekkfcMUnifhab2xvVhjaxTf++4mpNajXe60lzghXbt5G?=
 =?us-ascii?Q?4ZbhRYV4a74qOCdBetJBm33A50HVU6Mvf4s3cGkt5JttxbJ1cZEk6mqwqkeH?=
 =?us-ascii?Q?6gALnyRIMecHh09JrZHk3y5jZXglFFJf19BOzMmZzs0gdJ2As5sl5VJjPm6n?=
 =?us-ascii?Q?Dhe5sW+3MEW854KpxZY/sBaMxb1iZHGQVWnstW6o7V16C9w8tACfB6mrKG8f?=
 =?us-ascii?Q?fjuVQ7KIXPjC3WOoh09EqA7AyM+aHnawP6KFc5UNmKe+yMNyBSwQDip9AuEx?=
 =?us-ascii?Q?lO66VTlZJKk7KB8+zWYTr2f+QupF4Lnkny1zG1aTBHJSUc9jvMdjvsOD8+R6?=
 =?us-ascii?Q?gedzIdROifMzpK1fB7EbVeg0iYXDC9R3TRYU+efpnbG/tpYEt7NoFPDfZEUR?=
 =?us-ascii?Q?sbTZ8wUFo4JcwD/JQfpX9T4qHXnm0El8IX6OQuivKhOmml7/pC+y1wTXrLW5?=
 =?us-ascii?Q?JVR/U26GTWdODYelLTbMWLeSR/wfkrOxfY8cSOOXgrraZbbdO/HJWxJp8q0Y?=
 =?us-ascii?Q?neK+hO4nKTUNazqjW3D+fRnnBn+stWwyVD9LnBmbGOwLbzSSWYSC2dwf939F?=
 =?us-ascii?Q?BS5TZ68eZQP1EQ9SbSfUFaTZzKXtN2+8oRqr8ZTy1Ap5Uv5WBzZlUxzh0wtL?=
 =?us-ascii?Q?M5ZawjB4BfEMNOS6qP4b9He8BYJNzpqKT8gTv4zoyr6cqD8Zd1W3h3/22Ztn?=
 =?us-ascii?Q?m+yLqr036HxMyMNi4DHGYwWfwxkD2xRmVv0b0gA42V7hGiraOYFCZxSZQ6cf?=
 =?us-ascii?Q?UL/2/45I/1VvkTESdCO6DX6+5AWrbyCrNEeenEIiKnWKHmDb+uZcWwz+8RGL?=
 =?us-ascii?Q?lz/OrFzLQrYIW+b2sCJAbH0mhVWPtAFbqYjiGpYhclNo7OpUWPb/XbP/wKJ9?=
 =?us-ascii?Q?B937ZWqGdyQVhaQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 18:57:51.9793 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d96e46-211a-4d32-9b8b-08dd6197ca6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4236
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

Plumb in support for disabling kernel queues in
GFX11.  We have to bring up a GFX queue briefly in
order to initialize the clear state.  After that
we can disable it.

v2: use ring counts per Felix' suggestion
v3: fix stream fault handler, enable EOP interrupts

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 191 ++++++++++++++++++-------
 1 file changed, 136 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 95eefd9a40d28..03b9d656a0d3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1145,6 +1145,10 @@ static int gfx_v11_0_gfx_ring_init(struct amdgpu_device *adev, int ring_id,
 
 	ring->ring_obj = NULL;
 	ring->use_doorbell = true;
+	if (adev->gfx.disable_kq) {
+		ring->no_scheduler = true;
+		ring->no_user_submission = true;
+	}
 
 	if (!ring_id)
 		ring->doorbell_index = adev->doorbell_index.gfx_ring0 << 1;
@@ -1577,7 +1581,7 @@ static void gfx_v11_0_alloc_ip_dump(struct amdgpu_device *adev)
 
 static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	int i, j, k, r, ring_id = 0;
+	int i, j, k, r, ring_id;
 	int xcc_id = 0;
 	struct amdgpu_device *adev = ip_block->adev;
 
@@ -1710,37 +1714,42 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 		return r;
 	}
 
-	/* set up the gfx ring */
-	for (i = 0; i < adev->gfx.me.num_me; i++) {
-		for (j = 0; j < adev->gfx.me.num_queue_per_pipe; j++) {
-			for (k = 0; k < adev->gfx.me.num_pipe_per_me; k++) {
-				if (!amdgpu_gfx_is_me_queue_enabled(adev, i, k, j))
-					continue;
-
-				r = gfx_v11_0_gfx_ring_init(adev, ring_id,
-							    i, k, j);
-				if (r)
-					return r;
-				ring_id++;
+	if (adev->gfx.num_gfx_rings) {
+		ring_id = 0;
+		/* set up the gfx ring */
+		for (i = 0; i < adev->gfx.me.num_me; i++) {
+			for (j = 0; j < adev->gfx.me.num_queue_per_pipe; j++) {
+				for (k = 0; k < adev->gfx.me.num_pipe_per_me; k++) {
+					if (!amdgpu_gfx_is_me_queue_enabled(adev, i, k, j))
+						continue;
+
+					r = gfx_v11_0_gfx_ring_init(adev, ring_id,
+								    i, k, j);
+					if (r)
+						return r;
+					ring_id++;
+				}
 			}
 		}
 	}
 
-	ring_id = 0;
-	/* set up the compute queues - allocate horizontally across pipes */
-	for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
-		for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
-			for (k = 0; k < adev->gfx.mec.num_pipe_per_mec; k++) {
-				if (!amdgpu_gfx_is_mec_queue_enabled(adev, 0, i,
-								     k, j))
-					continue;
+	if (adev->gfx.num_compute_rings) {
+		ring_id = 0;
+		/* set up the compute queues - allocate horizontally across pipes */
+		for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
+			for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
+				for (k = 0; k < adev->gfx.mec.num_pipe_per_mec; k++) {
+					if (!amdgpu_gfx_is_mec_queue_enabled(adev, 0, i,
+									     k, j))
+						continue;
 
-				r = gfx_v11_0_compute_ring_init(adev, ring_id,
-								i, k, j);
-				if (r)
-					return r;
+					r = gfx_v11_0_compute_ring_init(adev, ring_id,
+									i, k, j);
+					if (r)
+						return r;
 
-				ring_id++;
+					ring_id++;
+				}
 			}
 		}
 	}
@@ -4578,11 +4587,23 @@ static int gfx_v11_0_cp_resume(struct amdgpu_device *adev)
 			return r;
 	}
 
-	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
-		ring = &adev->gfx.gfx_ring[i];
-		r = amdgpu_ring_test_helper(ring);
-		if (r)
-			return r;
+	if (adev->gfx.disable_kq) {
+		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
+			ring = &adev->gfx.gfx_ring[i];
+			/* we don't want to set ring->ready */
+			r = amdgpu_ring_test_ring(ring);
+			if (r)
+				return r;
+		}
+		if (amdgpu_async_gfx_ring)
+			amdgpu_gfx_disable_kgq(adev, 0);
+	} else {
+		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
+			ring = &adev->gfx.gfx_ring[i];
+			r = amdgpu_ring_test_helper(ring);
+			if (r)
+				return r;
+		}
 	}
 
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
@@ -4791,6 +4812,46 @@ static int gfx_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 	return r;
 }
 
+static int gfx_v11_0_set_userq_eop_interrupts(struct amdgpu_device *adev,
+					      bool enable)
+{
+	if (adev->gfx.disable_kq) {
+		unsigned int irq_type;
+		int m, p, r;
+
+		for (m = 0; m < adev->gfx.me.num_me; m++) {
+			for (p = 0; p < adev->gfx.me.num_pipe_per_me; p++) {
+				irq_type = AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP + p;
+				if (enable)
+					r = amdgpu_irq_get(adev, &adev->gfx.eop_irq,
+							   irq_type);
+				else
+					r = amdgpu_irq_put(adev, &adev->gfx.eop_irq,
+							   irq_type);
+				if (r)
+					return r;
+			}
+		}
+
+		for (m = 0; m < adev->gfx.mec.num_mec; ++m) {
+			for (p = 0; p < adev->gfx.mec.num_pipe_per_mec; p++) {
+				irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
+					+ ((m - 1) * adev->gfx.mec.num_pipe_per_mec)
+					+ p;
+				if (enable)
+					r = amdgpu_irq_get(adev, &adev->gfx.eop_irq,
+							   irq_type);
+				else
+					r = amdgpu_irq_put(adev, &adev->gfx.eop_irq,
+							   irq_type);
+				if (r)
+					return r;
+			}
+		}
+	}
+	return 0;
+}
+
 static int gfx_v11_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -4800,9 +4861,11 @@ static int gfx_v11_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
+	gfx_v11_0_set_userq_eop_interrupts(adev, false);
 
 	if (!adev->no_hw_access) {
-		if (amdgpu_async_gfx_ring) {
+		if (amdgpu_async_gfx_ring &&
+		    !adev->gfx.disable_kq) {
 			if (amdgpu_gfx_disable_kgq(adev, 0))
 				DRM_ERROR("KGQ disable failed\n");
 		}
@@ -5128,11 +5191,22 @@ static int gfx_v11_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
+	if (amdgpu_disable_kq == 1)
+		adev->gfx.disable_kq = true;
+
 	adev->gfx.funcs = &gfx_v11_0_gfx_funcs;
 
-	adev->gfx.num_gfx_rings = GFX11_NUM_GFX_RINGS;
-	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
-					  AMDGPU_MAX_COMPUTE_RINGS);
+	if (adev->gfx.disable_kq) {
+		/* We need one GFX ring temporarily to set up
+		 * the clear state.
+		 */
+		adev->gfx.num_gfx_rings = 1;
+		adev->gfx.num_compute_rings = 0;
+	} else {
+		adev->gfx.num_gfx_rings = GFX11_NUM_GFX_RINGS;
+		adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
+						  AMDGPU_MAX_COMPUTE_RINGS);
+	}
 
 	gfx_v11_0_set_kiq_pm4_funcs(adev);
 	gfx_v11_0_set_ring_funcs(adev);
@@ -5163,6 +5237,11 @@ static int gfx_v11_0_late_init(struct amdgpu_ip_block *ip_block)
 	r = amdgpu_irq_get(adev, &adev->gfx.bad_op_irq, 0);
 	if (r)
 		return r;
+
+	r = gfx_v11_0_set_userq_eop_interrupts(adev, true);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -6548,27 +6627,29 @@ static void gfx_v11_0_handle_priv_fault(struct amdgpu_device *adev,
 	pipe_id = (entry->ring_id & 0x03) >> 0;
 	queue_id = (entry->ring_id & 0x70) >> 4;
 
-	switch (me_id) {
-	case 0:
-		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
-			ring = &adev->gfx.gfx_ring[i];
-			if (ring->me == me_id && ring->pipe == pipe_id &&
-			    ring->queue == queue_id)
-				drm_sched_fault(&ring->sched);
-		}
-		break;
-	case 1:
-	case 2:
-		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-			ring = &adev->gfx.compute_ring[i];
-			if (ring->me == me_id && ring->pipe == pipe_id &&
-			    ring->queue == queue_id)
-				drm_sched_fault(&ring->sched);
+	if (!adev->gfx.disable_kq) {
+		switch (me_id) {
+		case 0:
+			for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
+				ring = &adev->gfx.gfx_ring[i];
+				if (ring->me == me_id && ring->pipe == pipe_id &&
+				    ring->queue == queue_id)
+					drm_sched_fault(&ring->sched);
+			}
+			break;
+		case 1:
+		case 2:
+			for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+				ring = &adev->gfx.compute_ring[i];
+				if (ring->me == me_id && ring->pipe == pipe_id &&
+				    ring->queue == queue_id)
+					drm_sched_fault(&ring->sched);
+			}
+			break;
+		default:
+			BUG();
+			break;
 		}
-		break;
-	default:
-		BUG();
-		break;
 	}
 }
 
-- 
2.48.1

