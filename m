Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C173DC5320E
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Aug 2024 08:58:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6305610E52A;
	Tue, 20 Aug 2024 08:58:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mTs74FqX";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2046.outbound.protection.outlook.com [40.107.212.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFB5F10E52A
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Aug 2024 08:58:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQz1OnTNEQTNg5uSEV+t2CqLKM7eQPPVBGeQWGxjNIiqui+GFa2BZuQwaOBJ5nHPAVHoQZX6+I+vy34esqXgdiOC4ZoqOdlZcQOq0Z5ml2hjJJ1gaCZ7pd3vE7zTeCfU/74Jdyjvy2xqLnJ+DxLw+TR4IkPxj+YpDxhzTNZhNE2eyPRwKvdu6E6mWSaUllzQ8ORe6GuMFlqHqc7Zz216QxBQRp3MAJRc8Y+hTApAQVRWjVYBlx2euStqm5xPT9RNskzAgYKGiLWdoiefVWN9Bzsit2sasMUYfVDjB9PW/Cqzm644bddE/NhGouODWVOAZd5MnDroUcNmieCQzUG7gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jyornFbV8Mzqa+vQojuA6aRReH1GaQnJCrxP7VivAg=;
 b=FuAPrLDyIGOjaPc1ERyP1Euqy0ew2mm6/lH5HK8kjxTMI8UxbCVucPFYbEStBaQpX+Gz0XlRN6RkM8oDV1TOffYe5Zzggsc/+oaIQFkgqrZOnx70FogXYM6hIdor4j2ROcaQq1Wm606wvLO7eAaEpC1gyl4ANyq+uwRxhNrZVihDcrkIxKUHq6UCPPiqsINxMR1sF6WB+7fsxEUhrx7yyqrx9MLgtfS1AhKfM2iX4WoGIik3Ng6xx2be4BMo7wsSnF/l6qHcJeGV1501cTemiq27sE+MZ8RGlSDKjLJwZNt2WhWbIQxW9ODqnHF9DR4tmiRkn6WiY7MdneaXtJBXNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jyornFbV8Mzqa+vQojuA6aRReH1GaQnJCrxP7VivAg=;
 b=mTs74FqXytgAbisJYQQj3+WwP+7GPF0QEvGAIDYPQ+pDnlgGLDHWNe8y7gSOMA3TugZrT6LECR1DY5HYpr/t+kfKmEOdI1fJepnedOFrZ68hAI+vJmIX57wQyb1NF4ZlexFShl+thfQpfqh0cFuNTUENxwFDh4fHcGacAKhnm1c=
Received: from BN9PR03CA0922.namprd03.prod.outlook.com (2603:10b6:408:107::27)
 by DM4PR12MB8498.namprd12.prod.outlook.com (2603:10b6:8:183::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Tue, 20 Aug
 2024 08:58:22 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:408:107:cafe::c6) by BN9PR03CA0922.outlook.office365.com
 (2603:10b6:408:107::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Tue, 20 Aug 2024 08:58:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Tue, 20 Aug 2024 08:58:22 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 20 Aug
 2024 03:58:20 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu/gfx9.4.3: Implement compute pipe reset
Date: Tue, 20 Aug 2024 16:58:10 +0800
Message-ID: <20240820085810.2831063-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|DM4PR12MB8498:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cb3bd22-32a8-469f-51a0-08dcc0f63e99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2dSLZLgGH7jA6rTF00KKgxJG3w/joldK+4jhDNtt34/8g9UYW81Jt0DvG8en?=
 =?us-ascii?Q?D/B9Nf3jy8d7NcTh2c80QaWP95+MOEMwGe3KRgsFzDkJReRBaIJSYsS7CfHp?=
 =?us-ascii?Q?j3wj9hhIcjBnrV1h20YF1KdZ171fCyM7/RqyT7wHn+AF4cXkbKhyxilUqJsZ?=
 =?us-ascii?Q?VtaUEX65Q7gRTkG2S513F08US9KivujnpnLhSnRMHXfPOYAG6Kp/uAzMGUE0?=
 =?us-ascii?Q?BtynvWCVio0ABCZF0l/5KQXZRK/nll5D8c0MqwUYFltsSgQ7+ycG6Lr7z2Rx?=
 =?us-ascii?Q?ML2OXwokcZEBoF6B6/Bx4O+hxp/+eQLQmefdoqc9EgroYsEDbheLrYsOUemP?=
 =?us-ascii?Q?NhjvtkBFh0L8eeILJJ5qBPXd1YQ2PKcyDrpa1Yrzu86xj7vyoGSL+ouhl2BQ?=
 =?us-ascii?Q?3ITqlTzCAlZbMS48dgb1cdhVfRB+xfnmq/K+TAvQOzkfWAjsvlFjAXJt3Ugp?=
 =?us-ascii?Q?jIDYfxXkDRUJRMs6En+Q8fJpGMM3P7oVlfUfKE1hXNKn/4PfspZcgEhu3VkU?=
 =?us-ascii?Q?TZ8zOZaX5lqQiDQwwMskwOeBt4SBRb3mn9I9zeEVhItDoR3Kjigw0V5HiTf9?=
 =?us-ascii?Q?TFL28Pwci916ztuGe4wU0sJ6qusJ0PVK1if5aDWeYf5F3GWJYSy34Uv2J9fc?=
 =?us-ascii?Q?Al2S0pUALPMiTlgJH+EelmE7VgcRP/HM95qv0475MH0XO6lwBrqy4TZ0feKt?=
 =?us-ascii?Q?bqQoBLXTnSmZnn16UhmQgDlHE8yZoK08eVjdYW2pBx/wIqHaH5mqaETRAJtA?=
 =?us-ascii?Q?xr5TMAPabbJw7k3kcdzGJYXXbTS8cziOlGgZOwlKkApUoJkAacQELmFzUPLF?=
 =?us-ascii?Q?9D0sp/vUD+J1tRXK1sodsgjk1HoovY1pXYmoi0kY8FYVBHjQTMnBHgaznzKc?=
 =?us-ascii?Q?epoFjIBpRXQhrKHzDOskKZKGwtzgS+9bWlM8LXYfFEYTMW9H/uNx7mgEw2ML?=
 =?us-ascii?Q?itCU2sC9XSwSmMDv6kDYMjvyvqKlvAWdnQBBAWqB2PbvYp7oExAxrpDSGt8A?=
 =?us-ascii?Q?/qm2lsQUD8+YyH8KH4x5RxVorQD57KGuafHYglM3xnTgzYv5Z1XOlgGEVQeC?=
 =?us-ascii?Q?MduigeoJDHPXkpIkd/gsuAuRz3QZBENpQ03eyE1nScnoXFuj+fvt/05sR52t?=
 =?us-ascii?Q?uJk2K/yi9MWWMCKMeHw6yHkL2bKqiTMpXNt0LG8GpI81rmFgDspmv5uC/51k?=
 =?us-ascii?Q?5AYjMUHOO4QZzb+UPiPc+0SbLmUBi4UQHAnto3nWzuqOpUPdjL9RhDjMidPz?=
 =?us-ascii?Q?WkJyngAR5atKQbE/dFUHGpjUuvK2jCwg9/WE40eeAn02TzJOe27xMfbaFR3U?=
 =?us-ascii?Q?1soJmgx77hQxn+JfhD2iEDwAXE70kQeB4Wq0KdjaXota+EimhYCodl2A+JMh?=
 =?us-ascii?Q?UqVL+H2QtBnIkttMyLhgPwIlHnYe5BMc13MYtLS5AzW6qcubqQ0+hO1u3RQ0?=
 =?us-ascii?Q?nZHaZAtYTAt6xKPxgtcKWBQciw+zON//?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 08:58:22.3865 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb3bd22-32a8-469f-51a0-08dcc0f63e99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8498
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

Implement the compute pipe reset and driver will
fallback to pipe reset when queue reset failed.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |   5 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 153 ++++++++++++++++++++----
 2 files changed, 138 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index e28c1ebfa98f..d4d74ba2bc27 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -143,6 +143,11 @@ struct kiq_pm4_funcs {
 				   uint32_t queue_type, uint32_t me_id,
 				   uint32_t pipe_id, uint32_t queue_id,
 				   uint32_t xcc_id, uint32_t vmid);
+	int (*kiq_reset_hw_pipe)(struct amdgpu_ring *kiq_ring,
+				   uint32_t queue_type, uint32_t me,
+				   uint32_t pipe, uint32_t queue,
+				   uint32_t xcc_id);
+
 	/* Packet sizes */
 	int set_resources_size;
 	int map_queues_size;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 2067f26d3a9d..09caa5a1842b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -166,6 +166,10 @@ static int gfx_v9_4_3_get_cu_info(struct amdgpu_device *adev,
 				struct amdgpu_cu_info *cu_info);
 static void gfx_v9_4_3_xcc_set_safe_mode(struct amdgpu_device *adev, int xcc_id);
 static void gfx_v9_4_3_xcc_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
+static int gfx_v9_4_3_kiq_reset_hw_pipe(struct amdgpu_ring *kiq_ring,
+					uint32_t queue_type, uint32_t me,
+					uint32_t pipe, uint32_t queue,
+					uint32_t xcc_id);
 
 static void gfx_v9_4_3_kiq_set_resources(struct amdgpu_ring *kiq_ring,
 				uint64_t queue_mask)
@@ -323,6 +327,7 @@ static const struct kiq_pm4_funcs gfx_v9_4_3_kiq_pm4_funcs = {
 	.kiq_query_status = gfx_v9_4_3_kiq_query_status,
 	.kiq_invalidate_tlbs = gfx_v9_4_3_kiq_invalidate_tlbs,
 	.kiq_reset_hw_queue = gfx_v9_4_3_kiq_reset_hw_queue,
+	.kiq_reset_hw_pipe = gfx_v9_4_3_kiq_reset_hw_pipe,
 	.set_resources_size = 8,
 	.map_queues_size = 7,
 	.unmap_queues_size = 6,
@@ -3466,6 +3471,115 @@ static void gfx_v9_4_3_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
 	}
 }
 
+static int gfx_v9_4_3_unmap_done(struct amdgpu_device *adev, uint32_t me,
+				uint32_t pipe, uint32_t queue,
+				uint32_t xcc_id)
+{
+	int i, r;
+	/* make sure dequeue is complete*/
+	gfx_v9_4_3_xcc_set_safe_mode(adev, xcc_id);
+	mutex_lock(&adev->srbm_mutex);
+	soc15_grbm_select(adev, me, pipe, queue, 0, GET_INST(GC, xcc_id));
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1))
+			break;
+		udelay(1);
+	}
+	if (i >= adev->usec_timeout)
+		r = -ETIMEDOUT;
+	else
+		r = 0;
+	soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
+	mutex_unlock(&adev->srbm_mutex);
+	gfx_v9_4_3_xcc_unset_safe_mode(adev, xcc_id);
+
+	return r;
+
+}
+
+static bool gfx_v9_4_3_pipe_reset_support(struct amdgpu_device *adev)
+{
+
+	if (unlikely(adev->gfx.mec_fw_version < 0x0000009b)) {
+		DRM_WARN_ONCE("MEC firmware version too old, please use FW no older than 155!\n");
+		return false;
+	}
+
+	return true;
+}
+
+static int gfx_v9_4_3_kiq_reset_hw_pipe(struct amdgpu_ring *kiq_ring,
+					uint32_t queue_type, uint32_t me,
+					uint32_t pipe, uint32_t queue,
+					uint32_t xcc_id)
+{
+	struct amdgpu_device *adev = kiq_ring->adev;
+	uint32_t reset_pipe, clean_pipe;
+	int r;
+
+	if (!gfx_v9_4_3_pipe_reset_support(adev))
+		return -EINVAL;
+
+	gfx_v9_4_3_xcc_set_safe_mode(adev, xcc_id);
+	mutex_lock(&adev->srbm_mutex);
+	soc15_grbm_select(adev, me, pipe, queue, 0, GET_INST(GC, xcc_id));
+
+	reset_pipe = RREG32_SOC15(GC, 0, regCP_MEC_CNTL);
+	clean_pipe = reset_pipe;
+
+	if (me == 1) {
+		switch (pipe) {
+		case 0:
+			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
+						   MEC_ME1_PIPE0_RESET, 1);
+			clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
+						   MEC_ME1_PIPE0_RESET, 0);
+			break;
+		case 1:
+			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
+						   MEC_ME1_PIPE1_RESET, 1);
+			clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
+						   MEC_ME1_PIPE1_RESET, 0);
+			break;
+		case 2:
+			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
+						   MEC_ME1_PIPE2_RESET, 1);
+			clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
+						   MEC_ME1_PIPE2_RESET, 0);
+			break;
+		case 3:
+			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
+						   MEC_ME1_PIPE3_RESET, 1);
+			clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
+						   MEC_ME1_PIPE3_RESET, 0);
+			break;
+		default:
+			break;
+		}
+	} else {
+		if (pipe) {
+			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
+						   MEC_ME2_PIPE1_RESET, 1);
+			clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
+						   MEC_ME2_PIPE1_RESET, 0);
+		} else {
+			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
+						   MEC_ME2_PIPE0_RESET, 1);
+			clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
+						   MEC_ME2_PIPE0_RESET, 0);
+		}
+	}
+
+	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_CNTL, reset_pipe);
+	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_CNTL, clean_pipe);
+	soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
+	mutex_unlock(&adev->srbm_mutex);
+	gfx_v9_4_3_xcc_unset_safe_mode(adev, xcc_id);
+
+	r = gfx_v9_4_3_unmap_done(adev, me, pipe, queue, xcc_id);
+	return r;
+}
+
 static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 				unsigned int vmid)
 {
@@ -3473,7 +3587,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[ring->xcc_id];
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
 	unsigned long flags;
-	int r, i;
+	int r;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
@@ -3495,26 +3609,25 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 
 	r = amdgpu_ring_test_ring(kiq_ring);
-	if (r)
-		return r;
-
-	/* make sure dequeue is complete*/
-	amdgpu_gfx_rlc_enter_safe_mode(adev, ring->xcc_id);
-	mutex_lock(&adev->srbm_mutex);
-	soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0, GET_INST(GC, ring->xcc_id));
-	for (i = 0; i < adev->usec_timeout; i++) {
-		if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1))
-			break;
-		udelay(1);
-	}
-	if (i >= adev->usec_timeout)
-		r = -ETIMEDOUT;
-	soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, ring->xcc_id));
-	mutex_unlock(&adev->srbm_mutex);
-	amdgpu_gfx_rlc_exit_safe_mode(adev, ring->xcc_id);
 	if (r) {
-		dev_err(adev->dev, "fail to wait on hqd deactive\n");
-		return r;
+		DRM_ERROR("kiq ring test failed after ring: %s queue reset\n",
+				ring->name);
+		goto pipe_reset;
+	}
+
+	r = gfx_v9_4_3_unmap_done(adev, ring->me, ring->pipe, ring->queue, ring->xcc_id);
+	if (r)
+		DRM_ERROR("fail to wait on hqd deactive and will try pipe reset\n");
+
+pipe_reset:
+	if(r) {
+		r = gfx_v9_4_3_kiq_reset_hw_pipe(kiq_ring, ring->funcs->type,
+						ring->me, ring->pipe,
+						ring->queue, ring->xcc_id);
+		DRM_INFO("ring: %s pipe reset :%s\n", ring->name,
+				r ? "failed" : "successfully");
+		if (r)
+			return r;
 	}
 
 	r = amdgpu_bo_reserve(ring->mqd_obj, false);
-- 
2.34.1

