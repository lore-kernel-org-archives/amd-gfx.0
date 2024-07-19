Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5BA3C3DA59
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jul 2024 09:17:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B29E10EB88;
	Fri, 19 Jul 2024 09:17:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eFirS/WP";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2064.outbound.protection.outlook.com [40.107.101.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 553C110EB85
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jul 2024 09:17:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YKpdf2v4f3BkEYoQjBa1wFH4HKHauPS+KmecbjeM9ftj7Zyk4wmhN0NDyzJVDx77fNsTTA3fVMQbQTfRPo2xjhENTHuh4D2wUyinW229+w726To8RgbeTPScmr2+FNDSS/DsO4uCJ2b9Mqrsb+30xpB8HGzKqtGNa3nY0blDKudSLORqYfxwoOf3drefOP087tfV3Q3kIoGCCjE/3RyqiHur73eG1l5Xltlc+87Dz61Rc1k+aRmoCKpV3hUpdri3T4H8Qfn7oNH85fn6fAR0sjCnLvdWWfrjDc5aSTeclsw4PNOw5M4hXtjmh3bsbRh3gUnRYcBUEG0S2jUkH/T6Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TnZAjqexFlzvINpA6QsvrSunCNWH0Q4YTgGG6k+IvU=;
 b=MLC1eZSZEHRcfERFnumrD0r/7ziXBJuOblgzAKEYtMtAUs0XXGfkKRIx1vF1m1jQLIDS69nzRl3662Iz9zFUlmaoFNAWay2Zw/xCa6VFge4GTrWUXkdKFns2HQbCZ0bnKI4Lk1PZxgkl0jmGFS1f44PDk7u9/TPNwfPwXxf7OlJB0/hubEV77H4nZQTXnG6V5pyNVsSdRA1hSRQPlSJ6HkT2lPFoxQz5zBRPQ9HLiN2uBeJLqGjE1pJt3Uzz/68vy63Ar1obYYhbbYTgKMlqBMkWKtzMpvI6JgqjPkkYoCJIlhI4aw+YCeB6f0JSDk7kbCGahVqwRnX8z2jx+CIrqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TnZAjqexFlzvINpA6QsvrSunCNWH0Q4YTgGG6k+IvU=;
 b=eFirS/WPvDAg7De4kizQ4vGwnuiBaQ2rsnljhaDtn9xw860CtZmojWuxAI+eSvBjgYzoeh7B3msgo9F+YwISZ9HiRQtNLVbOTtuAkB7G8nBiNUfOiiqmbG6pgij6sKdfZaama9UN+UnOHxzbX5hXDX9blmD/VasW6SmkDBmN2w0=
Received: from DM5PR07CA0116.namprd07.prod.outlook.com (2603:10b6:4:ae::45) by
 IA0PR12MB7531.namprd12.prod.outlook.com (2603:10b6:208:43f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Fri, 19 Jul
 2024 09:17:12 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:4:ae:cafe::dd) by DM5PR07CA0116.outlook.office365.com
 (2603:10b6:4:ae::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Fri, 19 Jul 2024 09:17:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Fri, 19 Jul 2024 09:17:11 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 19 Jul
 2024 04:17:09 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>
CC: Jack Xiao <Jack.Xiao@amd.com>
Subject: [PATCH] drm/amdgpu/mes: fix mes ring buffer overflow
Date: Fri, 19 Jul 2024 17:16:15 +0800
Message-ID: <20240719091615.1534436-1-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|IA0PR12MB7531:EE_
X-MS-Office365-Filtering-Correlation-Id: ff4be871-57e8-4297-a181-08dca7d3927f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PjNZkAHQI+wXJGwByFsF+1AtLHJJ5Spfc5dUf8svbqkdoWg2mPfdX6B8rHKp?=
 =?us-ascii?Q?SNlxewrxxFbU5vmWbBtxMkGp3KCwG+iXfRvOmgE5wBfN2PCvL6tfVWZ/73K3?=
 =?us-ascii?Q?GtHaTNCswKn5fXI4XBinjGyKLrejwyyawzw8rHjeR0rfEud6Dwae/ToMN5uN?=
 =?us-ascii?Q?dHLlamLBCNvIJ5eHRwjvI2Wk1OnTVN9zbJDsOkTxKOCFYTznRv/y8m8s1O7f?=
 =?us-ascii?Q?4x6kRJ9cNpkbLvMudo5KTJwdiZCSDv7s+ohbWAtbokA8GlN0bmmRgfhCePl8?=
 =?us-ascii?Q?jYTorKgukSpL+rp2p8wl9EMt8kTYWowWqav6v/X2FfPFxRmYAK9T7KXnLP0l?=
 =?us-ascii?Q?WUxCH9Q8ua1HRxStsndHoXZ+iDsat1stCTf2kJlINSdsm1srorQ1WLCeejDV?=
 =?us-ascii?Q?PWr4KgP3jzNufebKN/bvwDZTWiKNMNkyo02zK3v2qskDMXOTRO6mx3b8lNt0?=
 =?us-ascii?Q?4RjbtcmJsIlq1VmXvcPMUNmoVhshD1c46UIgOYFdQt/7jGBK2W8Ss5/GWnTs?=
 =?us-ascii?Q?hSuuXckU1VfBqj+fvXHMvNHS2AFLUxLIsuP6S55cnT2LCJ7bMTWtPgUmoZe9?=
 =?us-ascii?Q?BCt6mUVHlXVwtvAlXBMabvBTdjEJtra59dacqdoJEAPEHQFKdmXqSZ7nCsSf?=
 =?us-ascii?Q?B0GFGOQ2fC4RSGfmfgxb6eKqNC+34UdGL84s+ce/MiwfS+MFvlyVDSIJtEIT?=
 =?us-ascii?Q?AmdB/92zy/s3E7gD2Yzz9OXSX4Wz2PLbBwJVzWRuMwXU5usOlLrWpEfk2js/?=
 =?us-ascii?Q?MOId0qYkCBGby3h4qKJ8PTFs1hues4fyrmnnS37J9hvi+SQywoyyphE9HWPk?=
 =?us-ascii?Q?PpZgyHepNWrWW5LFSLScjCVQP6pAsnKf613/Cg9YrxNn6jwJATWAW0CKmkWF?=
 =?us-ascii?Q?/ws4zMeoD81q/Bzw7BX+hk+fvL1hJ0rgtCzXYtd7DymCtCvCrjPDJNgaCR9a?=
 =?us-ascii?Q?Ltwi6AAkMtvUiZg7gRvhXDa/I2cFG8ONQAW+af1GrCwYl41L06/hL/SNOVbD?=
 =?us-ascii?Q?Zo1QcyNbuaxuh3raxARw+cH+YYtrhQrEEPDfxI0www9wple65gVXuZo/mQe0?=
 =?us-ascii?Q?uFhl3glsMk6pdNSu22nE5cap5AyvIa9Aoc4Qewdk0WwWUaE4wlVT/OeJATV5?=
 =?us-ascii?Q?XmQYHpnunfMyvfWNZxmwNlTclgnF2+zb/uU3h4dVXES9sJpY6VYy1WAGrovh?=
 =?us-ascii?Q?x9YdFjHVyuQqdmXmyvulQNNrnCjlkDvfQ3hktPXmREQT+VwVlC+TFQcvM+fv?=
 =?us-ascii?Q?SSL+0M1zvdgVWkOyqt7rzFLi7Ai7FR5LywmdZbAFC6Bk4wM1swLxAXvsRbPe?=
 =?us-ascii?Q?xqcHJj4zlk2keo5wO+g0poUoo6cwcgZ4boN7XTYiwNCKS+TxsnI9q8O9KWkD?=
 =?us-ascii?Q?0kwlKCm/WHEeO5E9bft6/i4xvtNmsgKgcERl/OLchYPYVMABf7oKOOcyjDRf?=
 =?us-ascii?Q?E/sdMgdbr+Pj742mvmZzzrzzyjBeK/oN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 09:17:11.5200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4be871-57e8-4297-a181-08dca7d3927f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7531
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

wait memory room until enough before writing mes packets
to avoid ring buffer overflow.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 18 ++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 18 ++++++++++++++----
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 8ce51b9236c1..68c74adf79f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -168,7 +168,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	const char *op_str, *misc_op_str;
 	unsigned long flags;
 	u64 status_gpu_addr;
-	u32 status_offset;
+	u32 seq, status_offset;
 	u64 *status_ptr;
 	signed long r;
 	int ret;
@@ -196,6 +196,13 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	if (r)
 		goto error_unlock_free;
 
+	seq = ++ring->fence_drv.sync_seq;
+	r = amdgpu_fence_wait_polling(ring,
+				      seq - ring->fence_drv.num_fences_mask,
+				      timeout);
+	if (r < 1)
+		goto error_undo;
+
 	api_status = (struct MES_API_STATUS *)((char *)pkt + api_status_off);
 	api_status->api_completion_fence_addr = status_gpu_addr;
 	api_status->api_completion_fence_value = 1;
@@ -208,8 +215,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	mes_status_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
 	mes_status_pkt.api_status.api_completion_fence_addr =
 		ring->fence_drv.gpu_addr;
-	mes_status_pkt.api_status.api_completion_fence_value =
-		++ring->fence_drv.sync_seq;
+	mes_status_pkt.api_status.api_completion_fence_value = seq;
 
 	amdgpu_ring_write_multiple(ring, &mes_status_pkt,
 				   sizeof(mes_status_pkt) / 4);
@@ -229,7 +235,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 		dev_dbg(adev->dev, "MES msg=%d was emitted\n",
 			x_pkt->header.opcode);
 
-	r = amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq, timeout);
+	r = amdgpu_fence_wait_polling(ring, seq, timeout);
 	if (r < 1 || !*status_ptr) {
 
 		if (misc_op_str)
@@ -252,6 +258,10 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	amdgpu_device_wb_free(adev, status_offset);
 	return 0;
 
+error_undo:
+	dev_err(adev->dev, "MES ring buffer is full.\n");
+	amdgpu_ring_undo(ring);
+
 error_unlock_free:
 	spin_unlock_irqrestore(&mes->ring_lock, flags);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index c9f74231ad59..48e01206bcc4 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -154,7 +154,7 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	const char *op_str, *misc_op_str;
 	unsigned long flags;
 	u64 status_gpu_addr;
-	u32 status_offset;
+	u32 seq, status_offset;
 	u64 *status_ptr;
 	signed long r;
 	int ret;
@@ -182,6 +182,13 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	if (r)
 		goto error_unlock_free;
 
+	seq = ++ring->fence_drv.sync_seq;
+	r = amdgpu_fence_wait_polling(ring,
+				      seq - ring->fence_drv.num_fences_mask,
+				      timeout);
+	if (r < 1)
+		goto error_undo;
+
 	api_status = (struct MES_API_STATUS *)((char *)pkt + api_status_off);
 	api_status->api_completion_fence_addr = status_gpu_addr;
 	api_status->api_completion_fence_value = 1;
@@ -194,8 +201,7 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	mes_status_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
 	mes_status_pkt.api_status.api_completion_fence_addr =
 		ring->fence_drv.gpu_addr;
-	mes_status_pkt.api_status.api_completion_fence_value =
-		++ring->fence_drv.sync_seq;
+	mes_status_pkt.api_status.api_completion_fence_value = seq;
 
 	amdgpu_ring_write_multiple(ring, &mes_status_pkt,
 				   sizeof(mes_status_pkt) / 4);
@@ -215,7 +221,7 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 		dev_dbg(adev->dev, "MES msg=%d was emitted\n",
 			x_pkt->header.opcode);
 
-	r = amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq, timeout);
+	r = amdgpu_fence_wait_polling(ring, seq, timeout);
 	if (r < 1 || !*status_ptr) {
 
 		if (misc_op_str)
@@ -238,6 +244,10 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	amdgpu_device_wb_free(adev, status_offset);
 	return 0;
 
+error_undo:
+	dev_err(adev->dev, "MES ring buffer is full.\n");
+	amdgpu_ring_undo(ring);
+
 error_unlock_free:
 	spin_unlock_irqrestore(&mes->ring_lock, flags);
 
-- 
2.41.0

