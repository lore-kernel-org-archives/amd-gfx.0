Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D9ECD98DE
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 21:17:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33FC410E730;
	Mon, 15 Jun 2026 21:17:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e6zdVo2O";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011068.outbound.protection.outlook.com [40.107.208.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C53C10E72C
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 21:17:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C8tEDK32MoBSVdvWIJNMjZtYHPyGVuVGc//Ig92omcLwdTrABa71K60LR4INqgZZBMd3wX5ZzaH0toNiTJZ0z7ghiS13B8KM/rxgEQYhB1NUpRCDi/i34u5j4lp1JQOYeHbhCSc/F/UotLe0zYphS0Z0ou55K3SVivgz+mzbezUjE7wOsMI9X/gJKje7oUp/DrHhuE4EaCNsTm8C18ZNfw9hXxCsDqLOJgXpg/0lPqnztsmodSnMebl5mJHlcHAJ2r0g0Dg4gqZg6VibPP1NrclpymBxH9kxKF0Wg73N7yhocOXf7bfc/1kknEUW+oEFTr4v9cg0wg0dwLGHjHZF0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2//i6NPhw9UJ7S2z/0VtZvml1NTzxACvJrg0jbN+FM=;
 b=vR4BxrrM+jQT7J2gg/mgW3NJ+nrFz9Zzs447Z+d5gREHxImyxkKW9zA5xN7l20tbgz/a2h3zVb2shuybnCMjnBdeLD/krt8fZ0bBmjdIZusAwj3xK0wc99O3QVuq5bl8SQd7h2iuqwXoHLho333Jolvx1xOKj3yTenKSKqH90nssisLDEGwlzBuoETzKRNa0a8Es0/uOI/zKJ1UhTi9BHdDkePyw28nAp9KjMmAcPEW8cUUQHYxsnj9wGDtRpRsqhaO/Cu3YxQEf5IhGjAjQz9d6etVpoai7x28TKsjCVi4NQvze8KW0ahffQLpKAO6NGLykU804CGkfQ9/QUpaWZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2//i6NPhw9UJ7S2z/0VtZvml1NTzxACvJrg0jbN+FM=;
 b=e6zdVo2Oe8i0jEX1NwUGRxC613uD9Bo7GfKhooq38lPO4wQXTX5ofjjjiOGj7YvVaK+r7RHP0lSZwqowdyhR9HAfNsHMmNBQ9ictFutkVivrzZ94CLqlQpjSav+OMqaP5Lz8cKbBD5K4cYGP3c8hcLw/Qm3vNHjABw/Y2gtJ4g0=
Received: from SJ0PR03CA0111.namprd03.prod.outlook.com (2603:10b6:a03:333::26)
 by LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 21:17:14 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::5f) by SJ0PR03CA0111.outlook.office365.com
 (2603:10b6:a03:333::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.16 via Frontend Transport; Mon,
 15 Jun 2026 21:17:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 21:17:13 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 16:17:12 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 16:17:12 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 16:17:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Kent.Russell@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 8/9] drm/amdgpu/gfx9.4.3: add support for disabling kernel
 queues
Date: Mon, 15 Jun 2026 17:16:53 -0400
Message-ID: <20260615211654.676386-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615211654.676386-1-alexander.deucher@amd.com>
References: <20260615211654.676386-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|LV2PR12MB5968:EE_
X-MS-Office365-Filtering-Correlation-Id: 86c0fa9b-d708-41e4-73c4-08decb23787e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 0zLlpQTVWxrDM8TvpXO/Tk5euWuChIFsZa5sXUY5e4h+V1/5p0Twt1p1B11yBBBv9PPbzqoIwdYpdO3RUExJ9z+MooroNQ0xFnnUt8BLQ6jDYJ5c8hY8VuhV99751QM7kK1oP1uBlbKAvIAnXBDby9vWvWhLpv/rgMEerMstAGCDujFlGhLMZo8jnUdkdHIELkWJNHdC+Q9pUzMJ1AD2cTJW1eKBRUCvvS9sJtC1QBRBZ6cGuubgXjvsZpLhQYC2/PPAcAurtdnCd60102KZ5UhVKhK/Ad279mLSy3Yh0x0zF5PI2uk/oyft2T1TG5mEotlIbrfypGIMmLShNisoGY87XLSG/TbyDI9j+FmGYZSRDnTQARTOS8q5+FgwfpuXym6W5ibSX6oFJfpZPqGQag3c4fwz11PlkP9ITULrrxZd3ATCsjBqxpyNzJ9S+0MqMBNdGZ9shdbTofdqkcAl9puh44+6B2zHDh/1TJFJt7WifEX7M+G15KheLDMBDV+EEUR8xmFqBi4xh6buJwZOri2FgyPUr2jebw4bJAe7AgmcMzKLvyoTauzeat8+iyYo+A5LzyXO22qZOU6+Xq9WPmJw/PcYQlq6S6+kaTKkTMOXZI5HcjRiSnKLEvEHubxMZE5o+HaQTavXcij2HzXV9zEXzGulS3O+84KB7sbKrl1sQJhmhTf2JQnT9+S16x3ka2MJ7X1SEfLXD8+Jyp4imHFtFUclXtNkowhw6llnPC4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OUG18z8NyshEUvmq2qt3Mtu6eZl2acf/EjSpJz6nVp7QX0W8QMI2GkfD3BLTWFUphcB5lWb56bjY7ILq2tsmjDzp2NHbVL1h1aesRHiJ8eC5eR2cwKpHFcK7JF2URz9CkZqNlIN7hgN5Ld9DNQ7/IT8HnIkf24iChBin8a+9imvR9Z+xn6VlqypRdzReyYo3paf1XDvC2EW7i/vvEAlk1zV14mg/WHlHYkeJbbK/RZMOA37vA+pnO50hWH1e6w1v+B0+qxKenALXkmuU6DshfxR+F//vwmjmuMkdvtCiMq1D5oloUVQUDQDDx12O2HFJ86VJAOwLiDA5ZkRSRuUl9pTzZMAFWTPCzIxIOpv3d8Vw1sb6M6NbFGIkVjkOEvVOBm41vXeDrL/yzNkMv1/HLpAlcsKL7wvsZvYrzH5MrFl/p+glMp2sF+8UR1hiERZA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 21:17:13.7706 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c0fa9b-d708-41e4-73c4-08decb23787e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5968
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

Allow the user to disable kernel queues.  This can be used
to free up vmid and HQD resources if kernel queues are not
needed.

Set amdgpu.user_queue=2 to disable kernel queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 117 ++++++++++++++++++++----
 1 file changed, 99 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 510266ba0c388..c7117ea6eec71 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1107,22 +1107,24 @@ static int gfx_v9_4_3_sw_init(struct amdgpu_ip_block *ip_block)
 	/* set up the compute queues - allocate horizontally across pipes */
 	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
 		ring_id = 0;
-		for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
-			for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
-				for (k = 0; k < adev->gfx.mec.num_pipe_per_mec;
-				     k++) {
-					if (!amdgpu_gfx_is_mec_queue_enabled(
-							adev, xcc_id, i, k, j))
-						continue;
-
-					r = gfx_v9_4_3_compute_ring_init(adev,
-								       ring_id,
-								       xcc_id,
-								       i, k, j);
-					if (r)
-						return r;
-
-					ring_id++;
+		if (!adev->gfx.disable_kq) {
+			for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
+				for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
+					for (k = 0; k < adev->gfx.mec.num_pipe_per_mec;
+					     k++) {
+						if (!amdgpu_gfx_is_mec_queue_enabled(
+							    adev, xcc_id, i, k, j))
+							continue;
+
+						r = gfx_v9_4_3_compute_ring_init(adev,
+										 ring_id,
+										 xcc_id,
+										 i, k, j);
+						if (r)
+							return r;
+
+						ring_id++;
+					}
 				}
 			}
 		}
@@ -2350,6 +2352,63 @@ static void gfx_v9_4_3_xcc_fini(struct amdgpu_device *adev, int xcc_id)
 	gfx_v9_4_3_xcc_cp_compute_enable(adev, false, xcc_id);
 }
 
+static int gfx_v9_4_3_set_userq_eop_interrupts(struct amdgpu_device *adev,
+					       bool enable)
+{
+	int num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	unsigned int irq_type;
+	int m, p, xcc_id, r;
+
+	if (adev->gfx.disable_kq) {
+		for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
+			for (m = 0; m < adev->gfx.mec.num_mec; ++m) {
+				for (p = 0; p < adev->gfx.mec.num_pipe_per_mec; p++) {
+					irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
+						+ (m * adev->gfx.mec.num_pipe_per_mec)
+						+ p;
+
+					if (enable)
+						r = amdgpu_irq_get(adev, &adev->gfx.eop_irq,
+								   irq_type);
+					else
+						r = amdgpu_irq_put(adev, &adev->gfx.eop_irq,
+								   irq_type);
+					if (r) {
+						if (!enable)
+							return r;
+						goto err_compute;
+					}
+				}
+			}
+		}
+	}
+
+err_compute:
+	for (p--; p >= 0; p--) {
+		irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
+			+ (m * adev->gfx.mec.num_pipe_per_mec) + p;
+		amdgpu_irq_put(adev, &adev->gfx.eop_irq, irq_type);
+	}
+	for (m--; m >= 0; m--) {
+		for (p = adev->gfx.mec.num_pipe_per_mec - 1; p >= 0; p--) {
+			irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
+				+ (m * adev->gfx.mec.num_pipe_per_mec) + p;
+			amdgpu_irq_put(adev, &adev->gfx.eop_irq, irq_type);
+		}
+	}
+	for (xcc_id--; xcc_id >= 0; xcc_id--) {
+		for (m = adev->gfx.mec.num_mec - 1; m <= 0; m--) {
+			for (p = adev->gfx.mec.num_pipe_per_mec - 1; p >= 0; p--) {
+				irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
+					+ (m * adev->gfx.mec.num_pipe_per_mec) + p;
+				amdgpu_irq_put(adev, &adev->gfx.eop_irq, irq_type);
+			}
+		}
+	}
+
+	return r;
+}
+
 static int gfx_v9_4_3_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r;
@@ -2382,9 +2441,14 @@ static int gfx_v9_4_3_hw_init(struct amdgpu_ip_block *ip_block)
 	r = amdgpu_irq_get(adev, &adev->gfx.bad_op_irq, 0);
 	if (r)
 		goto err_bad_op;
+	r = gfx_v9_4_3_set_userq_eop_interrupts(adev, true);
+	if (r)
+		goto err_bad_eop;
 
 	return 0;
 
+err_bad_eop:
+	amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
 err_bad_op:
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
 err_priv_inst:
@@ -2467,6 +2531,7 @@ static int gfx_v9_4_3_hw_fini(struct amdgpu_ip_block *ip_block)
 	amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
+	gfx_v9_4_3_set_userq_eop_interrupts(adev, false);
 
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	for (i = 0; i < num_xcc; i++) {
@@ -2612,8 +2677,24 @@ static int gfx_v9_4_3_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
-					  AMDGPU_MAX_COMPUTE_RINGS);
+	switch (amdgpu_user_queue) {
+	case -1:
+	case 0:
+	default:
+		adev->gfx.disable_kq = false;
+		adev->gfx.disable_uq = true;
+		break;
+	case 2:
+		adev->gfx.disable_kq = true;
+		adev->gfx.disable_uq = true;
+		break;
+	}
+
+	if (adev->gfx.disable_kq)
+		adev->gfx.num_compute_rings = 0;
+	else
+		adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
+						  AMDGPU_MAX_COMPUTE_RINGS);
 	gfx_v9_4_3_set_kiq_pm4_funcs(adev);
 	gfx_v9_4_3_set_ring_funcs(adev);
 	gfx_v9_4_3_set_irq_funcs(adev);
-- 
2.54.0

