Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF8EC54798
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Mar 2024 14:31:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF2F9112B49;
	Tue,  5 Mar 2024 14:31:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aRDICgC0";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99D9B112B4B
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Mar 2024 14:31:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4R20J8rI630FCAt2rEpGrIYJiwGrUoltbRG1TuAnt1DLiUW2P7oKN6I0oA+Kc+SmKNZeZCdHSzZUvaKhZqsqZOlPkMT4XmwnvcVEsSjmwvHz7JjtIbfQZju9fma25mrC9xelK9VTDmca+3rCFKLMgUya0I/IikvPuzJF9ZVGw7oru7O40DG26Ium/EQNwH+qUkxjYuUotclavsmdJHdTjKc/Sz8sF0/9fP8MhUfh1cySqngZ1jcNNUQdcKDYARkTGe/hGoJgcIPJrt8n6LFEWS2GWXmotKCBAPWa9RAK0xS6vv+Ds/6/Cj4criQ5FmoK6jntn88scUk7K9UFfniNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QvfbpkvUunPW9PbQJq3BD2I2ua7A4kLuBHtDP0Z64wc=;
 b=k2IMGuZ4sCQNNRSsFKkXVWWreEAPxTj0So1vmmC8YjHWQUcjAJwXwkwjnQc9shkeqIkaY07oXDPRB+k+KOWqqGgEf1xOfhZ5VShHVdDSBmiLuykEE9sfHm3XAPbcFwHP9G6gkcaLT9PKoTPqeY2tdjeRAUKdX8rAE5EAyZUIkkgykqkEi2OtRti43GeH4VnvV8ngda8Rs0RBSPVX1IrPgGywk5ZwAAl7w+GkhPALUYeopGKM3lPJ6XnsEs8+iRDZN3echUPj463Wyu3jnq7nGiet0ex8HvVKbBA+sTrzMKWc5LhCaPM1H5q2RtPwLgEli3sHGasJ9Gp59K59fdytSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvfbpkvUunPW9PbQJq3BD2I2ua7A4kLuBHtDP0Z64wc=;
 b=aRDICgC0BKNr4h6eMrkGMsBBTg3y8/iCwAMBuTHWqdc+p1/6TU3VZ7QfVBovzVM8uu3z9u/By4vRE+vHnWjFcXdFGDZlqXftGvpy9ITiadX/0qwVe7klldYZLJdK1/8OAsajLVPsG4Dhr3emk0NfY41DOPFXCEJ8ZOdMm6XvVUo=
Received: from BYAPR05CA0069.namprd05.prod.outlook.com (2603:10b6:a03:74::46)
 by CH0PR12MB8530.namprd12.prod.outlook.com (2603:10b6:610:188::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 14:31:17 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:74:cafe::a6) by BYAPR05CA0069.outlook.office365.com
 (2603:10b6:a03:74::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Tue, 5 Mar 2024 14:31:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Tue, 5 Mar 2024 14:31:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 5 Mar
 2024 08:31:13 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lang Yu <Lang.Yu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/6] drm/amdgpu/vpe: add collaborate mode support for VPE
Date: Tue, 5 Mar 2024 09:30:50 -0500
Message-ID: <20240305143053.1262593-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240305143053.1262593-1-alexander.deucher@amd.com>
References: <20240305143053.1262593-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|CH0PR12MB8530:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eb776a9-c733-476a-e56a-08dc3d20ead7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T1/pXPmR38DumCfibrNha2C5nggAm7vgFSZIn4JwRN6zbYvFCM52EcnDEAEhWdC94g0S5vosZBvhxLvk7gDUmwznf5A3mvo+9pGewjQFPtv3ckB+vU3GX8LDkYUrh4HGy4HfyKzSmnRO9hBBqCTGHkRaDozjNI9C4WMdJb3RPW+Kv4hmb6ecllUGkZWgYsqY7w6VOjRpoBUdzQuy48XWDwmjgwcrTKatMBf5iybiINx88EwIqDtMcRW+eFWvbi/knxiQXeds5XafswGqwFJqi5cmNah1qgiKM7IM0xGM0P/hcGR9gCAzBuK3P8ZGtAVNg00r//Mgk6beCvs8ZG4iDv5z3mhUfkNGOZJ5IsNaGMEqQVKFfBWrcW1yEeG3eCesCJcIu4ANQ6JNkO+CV8qwBhI6dGabj//dSM06PhR9xACAN5Gcm6P/baN50yCQaGq7klGFL6Y6RuDEeGv74feDstr9O8NeDFM2artAn+OgPMAI7x4Zv5VGjR1jE0CKmk1RIxEd9jVgjRQpUAV/kVqzRgZtJrRabXplAVHkD2uuTtVyQnS525g4WduQGd4ehPmGExkQW9hU4h1V44rfpoh2Y7khyrx9qfMf/cvAYhUAZfrXxD7rqM/hse0+Wt/jLAQSHF2Ry60Z+sz7uKsthyt1UaCyaiRUA0rDIGyZ0Rcv8klHM47sTm7NCutjDBYCxTbcjOLAdVeNpeerr5t3ZxCWd5JmYXmirhZNI0q5uSH39EIB9icrUo5SDwo+if+g/3Q9
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 14:31:16.6470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb776a9-c733-476a-e56a-08dc3d20ead7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8530
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

From: Lang Yu <Lang.Yu@amd.com>

Under clollaborate mode, multiple VPE instances share a ring buferr
and work together to finish a job.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 20 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 8cedee059c8a2..9d2415f26b7c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -457,6 +457,18 @@ static uint64_t vpe_get_csa_mc_addr(struct amdgpu_ring *ring, uint32_t vmid)
 	return csa_mc_addr;
 }
 
+static void vpe_ring_emit_pred_exec(struct amdgpu_ring *ring,
+				    uint32_t device_select,
+				    uint32_t exec_count)
+{
+	if (!ring->adev->vpe.collaborate_mode)
+		return;
+
+	amdgpu_ring_write(ring, VPE_CMD_HEADER(VPE_CMD_OPCODE_PRED_EXE, 0) |
+				(device_select << 16));
+	amdgpu_ring_write(ring, exec_count & 0x1fff);
+}
+
 static void vpe_ring_emit_ib(struct amdgpu_ring *ring,
 			     struct amdgpu_job *job,
 			     struct amdgpu_ib *ib,
@@ -481,6 +493,8 @@ static void vpe_ring_emit_fence(struct amdgpu_ring *ring, uint64_t addr,
 {
 	int i = 0;
 
+	vpe_ring_emit_pred_exec(ring, 0, 10);
+
 	do {
 		/* write the fence */
 		amdgpu_ring_write(ring, VPE_CMD_HEADER(VPE_CMD_OPCODE_FENCE, 0));
@@ -505,6 +519,8 @@ static void vpe_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
 	uint32_t seq = ring->fence_drv.sync_seq;
 	uint64_t addr = ring->fence_drv.gpu_addr;
 
+	vpe_ring_emit_pred_exec(ring, 0, 6);
+
 	/* wait for idle */
 	amdgpu_ring_write(ring, VPE_CMD_HEADER(VPE_CMD_OPCODE_POLL_REGMEM,
 				VPE_POLL_REGMEM_SUBOP_REGMEM) |
@@ -520,6 +536,8 @@ static void vpe_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
 
 static void vpe_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32_t val)
 {
+	vpe_ring_emit_pred_exec(ring, 0, 3);
+
 	amdgpu_ring_write(ring, VPE_CMD_HEADER(VPE_CMD_OPCODE_REG_WRITE, 0));
 	amdgpu_ring_write(ring,	reg << 2);
 	amdgpu_ring_write(ring, val);
@@ -528,6 +546,8 @@ static void vpe_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32_t
 static void vpe_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
 				   uint32_t val, uint32_t mask)
 {
+	vpe_ring_emit_pred_exec(ring, 0, 6);
+
 	amdgpu_ring_write(ring, VPE_CMD_HEADER(VPE_CMD_OPCODE_POLL_REGMEM,
 				VPE_POLL_REGMEM_SUBOP_REGMEM) |
 				VPE_CMD_POLL_REGMEM_HEADER_FUNC(3) | /* equal */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h
index ee6db04cf27be..231d86d0953e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h
@@ -78,6 +78,7 @@ struct amdgpu_vpe {
 	bool				context_started;
 
 	uint32_t			num_instances;
+	bool				collaborate_mode;
 };
 
 int amdgpu_vpe_psp_update_sram(struct amdgpu_device *adev);
-- 
2.44.0

