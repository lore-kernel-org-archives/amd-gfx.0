Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E33C5B552
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 17:28:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDCE010E6BD;
	Wed, 28 May 2025 17:28:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bLnkFZ8Q";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCB3110E693
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 17:28:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZ3EHs6coPkJT6F4TYWAWER5Q8fT4ZnY/i27o/cI6bW63recbCgBnkAVOJoFrMLFfIdbQMH3F6ctqmXGqD6b3hHcDTiDGBUXX70ExaDaJSUAUXaNwIJrG/aZaIl2jM0PLVd5+1fZP1aW8qu7M6gP/Fx+Yr5h/8EXQ0GhE12NsqoGKe/H7mCXmjuPjiOjSTAnL4MzZgDeIwMkcI0qlv2asA6PW43VRj4wKlI1LVyrly32Ymj47SNajZDQHTEEMq2m4CzGIr0ghOTcG7Tfme7oP5Trqblkluz6ngp3ruonq/fQTKSAuCJfaTUFbHteg3W9NdQcJYrH63pV9JdPv67ECg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iI2p+oPsJdqRqDVjDD2AKs6hafM7iZEgbYTpfOYQAuw=;
 b=DuEjLsGcfKHXTbEnMCgkhNm/UQKyjRQFZcXhiiWB+da7xC4Wvw5exrPCPsT6diYooIYCxN68boTm+F0UDqWlRXlXqhhcBzMANhw5DBNrwocnlQ/XtFJHe7YlqrA8bYazGw3+/k3f9Wvym6aYE/C5qPAYS1ZA1PtLH0iu972zchQ8FIep0WhNa7/8bL8jbMy4EySrf7odqSKRHgU1kv1EDLjmvaOzkpi8cX34KRO4JFRNaax8PtMhMc/1+LlMR+pZhB0mopWGpajS77sT5+sqKVR3XMdKkFfqe1Ji8BptlIKT/VGsL+pJyBWu+h1XaqfIlsUX1zOzuLqbVJQe/PnubQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iI2p+oPsJdqRqDVjDD2AKs6hafM7iZEgbYTpfOYQAuw=;
 b=bLnkFZ8QbxBnARzLaCxHTbTBL+oELu62H1veEDQ8soGbWwWZ6BWTcLepN3moqCIB6t/qgz5LUNNQdbPPriA3Ds1QUipyyEaVosuvJlrxYgs9kT2zS3GgIHslfu68yrYb9OWncbKs2Ab/N40l4M69jpQnXY4QE+TOYBUT+z7qJxE=
Received: from BL1P222CA0027.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::32)
 by MW5PR12MB5650.namprd12.prod.outlook.com (2603:10b6:303:19e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Wed, 28 May
 2025 17:28:24 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::b4) by BL1P222CA0027.outlook.office365.com
 (2603:10b6:208:2c7::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 28 May 2025 17:28:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 17:28:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 May
 2025 12:28:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 11/16] drm/amdgpu/gfx12: re-emit unprocessed state on kgq reset
Date: Wed, 28 May 2025 13:27:56 -0400
Message-ID: <20250528172801.34424-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250528172801.34424-1-alexander.deucher@amd.com>
References: <20250528172801.34424-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|MW5PR12MB5650:EE_
X-MS-Office365-Filtering-Correlation-Id: fac81e06-7ebe-40d7-c24b-08dd9e0d0cf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HgeHzSM/4dJL6eZ+gHUtzNjAGOxuALE0dxCelj99KZHPGNNz0bQRjAVeeqBD?=
 =?us-ascii?Q?6HV4uTysOG39pVjSGB0mUq+tkpTS/H96z/7dpKkZMj2voF1t4FFc2U0yd3dY?=
 =?us-ascii?Q?SyCjPDyUu4VMKbCyvaX4jCJR/2HqX6rMgrxCFQH0cR1vt6ATU5f9jmjcMGbT?=
 =?us-ascii?Q?78o46gHhZuxcWvOhJzpm46yJzkRDxzReoNNZtM00PVo2f7UMJhGIubkQb8OT?=
 =?us-ascii?Q?00QwRXyMEyTLOS2kag7EK/gN8Un2AOK+1uxspMgQ7QoOatD9aDHYziVQw3bF?=
 =?us-ascii?Q?vSOtAf4S1n1M87U+Vttl2JBNs2vqySyyIbxAmeUyponhV4KT7YiWehHXBctZ?=
 =?us-ascii?Q?uvC3EBElj+ZZ2ayvV1c+OC9IeHje9TH+ojsMN3jOTTdQ378kPXn3H+vHhdrF?=
 =?us-ascii?Q?iEBgO8OSTpkDJlJoblAwdm4dxzPmQ63PGqrUOT7MhQUDG36ys5RV0ZejBvZn?=
 =?us-ascii?Q?Zph1eTwxbUIFtQyzGO5yV0ie0MjyiPe1oHVFngO8xrsZrj+eNqvg+K6loS8D?=
 =?us-ascii?Q?V1OAzPhZ3sszyifTV6MTFY+fnKMAgjjoXBHIH0BLnZf0dr7NLlRkWoZmdP5O?=
 =?us-ascii?Q?E53Ja0oR+kJZAzjg+sFB9+wcM0cKkd63BS3Ccz/KkQJPi18d5Ff81qZpLyFL?=
 =?us-ascii?Q?5GK2/ZZLac009Kn57t40FkUMDbnKzv1Ili36r9wX02osOlWPtCLdnMds1/Ns?=
 =?us-ascii?Q?X8oRbQ/0UXO5GsRXSt3Pn0VsCI09E2KWcjFXPlCp3u0ubcQ6aBBk8pdsZfqB?=
 =?us-ascii?Q?Q/zsi5coraBXs38CouAq5b36r0qqkgcIW0X1++Cu8Wwdyg4y/9OqyeRlZEO4?=
 =?us-ascii?Q?+sspF4/+UM3nrRn+n7zpFxePwejy42P09CV11mo9jN+qGTowf8VL0fC2l5Af?=
 =?us-ascii?Q?StzrUucub+HeC/p71tJTXvFe982+8L7QKYk3dE09r+O6BDKo/4DwE+9k35Fa?=
 =?us-ascii?Q?bGpPBP/uGCsm2iiEJjx01yLhgX5pGb5maOAYc19lZDDB9OMhfW6Ue9Zwfq9N?=
 =?us-ascii?Q?gyyKEGIJ68tiPDOoUBElylGOhHn56re3LuXjl/eEIHuKcPpCmr/nY/IPK8+L?=
 =?us-ascii?Q?eKga8kVU2qAveIS0Jn8jEYYSDJE/uS4Z1cctCk0evzOOdkUcaKO5OSPq0RXF?=
 =?us-ascii?Q?183yuHNUEL8MynepYTA/9I/MntBrRXyM0xS3xDBMd7ab94aOFV5obiZt0yZW?=
 =?us-ascii?Q?VZfh7e6vRu/T8ji/iU84ndj5ic7HKoFR5EX9VR52juhEASjQnE3M+HtUv7gv?=
 =?us-ascii?Q?3l1hgs5c82fOMSqgIWsgvh6RgmDggG55nHNDOTwInrW06s1tuoM7li1flRrJ?=
 =?us-ascii?Q?2NsPV0HfcYw2NSWdSZJ1d70w52r6i9l6Tcxk/wR3cjwzmYEzJEk5QtsHK6e6?=
 =?us-ascii?Q?Ad/3F5L5wKZUDoxYbU5YPzkz1cjZ1PHsQ3vGY7/cvCCheqeusdXyIOBh8vbn?=
 =?us-ascii?Q?JyldNqh9h3MTcCSiJB9rx0b5IUH0clixOk9P6C+l5LALYWdLQyiFnvZsUKzv?=
 =?us-ascii?Q?Etk1xO2Q8a/P9GzUxT5mPoLfza525qW2EZm8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 17:28:24.5247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fac81e06-7ebe-40d7-c24b-08dd9e0d0cf9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5650
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 855aeb7b1a89d..bac81de0a1712 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5319,6 +5319,7 @@ static int gfx_v12_reset_gfx_pipe(struct amdgpu_ring *ring)
 static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
+	unsigned int i;
 	int r;
 
 	if (amdgpu_sriov_vf(adev))
@@ -5344,7 +5345,21 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 		return r;
 	}
 
-	return amdgpu_ring_test_ring(ring);
+	if (amdgpu_ring_alloc(ring, 8))
+		return -ENOMEM;
+	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
+			       ring->ring_backup_seq, 0);
+	amdgpu_ring_commit(ring);
+	r = amdgpu_ring_test_ring(ring);
+	if (r)
+		return r;
+	if (amdgpu_ring_alloc(ring, ring->ring_backup_entries_to_copy))
+		return -ENOMEM;
+	for (i = 0; i < ring->ring_backup_entries_to_copy; i++)
+		amdgpu_ring_write(ring, ring->ring_backup[i]);
+	amdgpu_ring_commit(ring);
+
+	return r;
 }
 
 static int gfx_v12_0_reset_compute_pipe(struct amdgpu_ring *ring)
@@ -5535,7 +5550,6 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v12_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v12_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v12_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v12_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v12_0_emit_mem_sync,
 	.reset = gfx_v12_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v12_0_ring_emit_cleaner_shader,
-- 
2.49.0

