Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D157C3ABB2
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 17:28:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BAA610E6AE;
	Wed, 28 May 2025 17:28:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LiHNPAh/";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1404210E65E
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 17:28:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IlaocVY1c1mDsJOPBZqFvDBVry0YTylsX6Se9TmKfd0Vb3ZcQvTdg2K2Cw2fwHEnVIHS5CKwSZC/dl31XVnAPKZLrDYzqSsdehKnAGBBP1DtrmHxk8HIE6yS+3JS8dSunEGPlHuRIsN4SSsQqI2xjWH1s2NOF+Wcx5Ft1FBznve9/1INCpgMfdlCFSKoFOv6LHKFj77Ua7BT0V/vOJUei3cwCwRszJEJTA/rCCCZBR8OhsNmqhzAZn81MoQrD2CVDXun7E/Yi2XbvOvMhSpy1bqz3+JTMqzrdD6qT2E87aFKGKjF3WXKejEZVrWrY/ft3VEa7NBx/Pw3Uo0MtmRTbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uM0XkviJlzIzDZZmDBd6PxQ1IWlw3a1IPi7pTAZWcCI=;
 b=BV8GiMF4+oAHQjO02ZqO0PfirxHEEc+Yrci1K+F5B5Pw+kYCLEvIKHob8rB64u6KbgwMLAKVtRQmpRqmNsWgkjfy+Sy7P6psLOHd2T3rBM9cYBsB+yb6z3eOWYDksKP8MA5Aoq4kNBOJ1WPLTmFjIsHci3W2KOTMQxxZ3C6WOMb10w39cWnJLcW8diR8c7zUV6dWqooN5nkgU8BaCo3juJkr2uUa5W2E7AAby0LBRF1jInza5lacam5jVjVCKcZV57BYxc0wj6jr43Gv5znmFex0SuAOcNEnE4Tsli8ulo4NcPwdVRObJHDsyF5fQMA09hPpKFQOZYb0WSMUBS1Ezw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uM0XkviJlzIzDZZmDBd6PxQ1IWlw3a1IPi7pTAZWcCI=;
 b=LiHNPAh/tjv4i/3kGWENMok3apgJdfXkObeenWFsfNqGLXAKkjx+CP3+TWhClBgOZZ06Wzto6q4dHRSkEDYlna6PUDzB8gmSkbi29VGZvrkXDeF0d+8+sikdXpA8QxUTZvOrPThB6cmMnx+RI2r+DLeTH56FtobV0aISkRLG/lc=
Received: from MN2PR18CA0005.namprd18.prod.outlook.com (2603:10b6:208:23c::10)
 by CY5PR12MB6573.namprd12.prod.outlook.com (2603:10b6:930:43::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Wed, 28 May
 2025 17:28:26 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:23c:cafe::c6) by MN2PR18CA0005.outlook.office365.com
 (2603:10b6:208:23c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Wed,
 28 May 2025 17:28:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 17:28:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 May
 2025 12:28:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 16/16] drm/amdgpu/gfx12: re-emit unprocessed state on kcq reset
Date: Wed, 28 May 2025 13:28:01 -0400
Message-ID: <20250528172801.34424-17-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|CY5PR12MB6573:EE_
X-MS-Office365-Filtering-Correlation-Id: 65a226b0-d3c2-4f5b-1e41-08dd9e0d0e06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L9fn5z6r1HUXsasjM4uBJg96wTpNjLgeih4oLVcaZlms6g/4jH+eMazd4Rpw?=
 =?us-ascii?Q?xM9t5xxaqt35JvHSc/muY5W8i1lxTcYZB7CpTVhu06IzWNzoz3NraLVF4ojE?=
 =?us-ascii?Q?XpixmgEBsXqSuIGtir56MlWZNsS7GLPnpY51iku5k2quE+Mh2efiqaHSeezq?=
 =?us-ascii?Q?IZt3/CHrKJSZl/kbx3kHCkdV9dEz3pGt+BYSancHB8dQ7iwZZJnyo8qGxRLi?=
 =?us-ascii?Q?UDkrxF6Je7AuY89cojfeZJNsLprfewenfC6EJPeVRuc/ydv0DPa3rx7JbJKo?=
 =?us-ascii?Q?QzJzSnX7kyCdJaKmgHTvRMNQisjmrN8VcRIM3X9EG9ZuWX2dZpHs4dbq1yZA?=
 =?us-ascii?Q?Zhsuvtz6lVoir9A/vFaHygMZ0gZt0h9uH9Ds8MgEx6+ITwDE7a9CdFDqIEZe?=
 =?us-ascii?Q?G8zyS61RTFd8NNC1bQcbe5EtPAMTekIoWQg4UHpHBqrkFE3epjvqhW1a1kL9?=
 =?us-ascii?Q?PcR50riVx6M/lrENW6jwDJ5kbrEnqXlDBm1+iJX/O0rQjLrNSa8QQf+EeXUJ?=
 =?us-ascii?Q?6P5Mt6Rg+FGSF5h6H+0FIkhLV5DJ7j5767V+/w/yrzxPl9q5IDRnNZNQXril?=
 =?us-ascii?Q?iOHiu//gENjoU4g+K/3xoURmreX6/WdAIOJY4VLKJ46S8Sn7nMFYA1xwFhcO?=
 =?us-ascii?Q?b/5EVdkFsbg9fJyf2C++v/itxQ+OuLfmHWdjDn2WjDLZ3P1laA4ElfhhOxy8?=
 =?us-ascii?Q?hkSA7K5F9wkYLFuicsn3KrUm60je6hOGj/rdjuAF3Ph1rzMYnf4ey3xoDxxW?=
 =?us-ascii?Q?k5k51Ut3j8BSYcUOgLUjgrbw1O/I4ESxdtmS/GR72mhfGEY/NZBQauUYbEaB?=
 =?us-ascii?Q?It4TCVZsibb8BmrM9zdSizMl/XN0gcaj3dsQD6q1yI+upWi0OLqc/T648g48?=
 =?us-ascii?Q?OEYhp1nQev2TAw3HWPSv3/jN/i2uSw1w+/+Gie/c9XAQVVjKbFk64kZjklY0?=
 =?us-ascii?Q?rna3FmM32WXExIvX8vsvpPShp8JVP/MF53+cjASWfvMNbCGzyUMxSWuj2zd6?=
 =?us-ascii?Q?JoSLQohUDz3c0TUVUhxfFPNVu9sNZ6YWgWZLSssSVUBTQfh2K/JCelXbu9W2?=
 =?us-ascii?Q?rBEZORm3qbmf8LTOThzcJEX6w2oO+TFyqqHHd/6I91qJQvRWdTf3BipG4y4G?=
 =?us-ascii?Q?1nB72+AlGufcqcjI90mvRVTbnOT7ooEmZ0qqyVos2f6XhwA27FmPkeh5CwzU?=
 =?us-ascii?Q?7JrejQNctb2KqAFyLp64/Ij2gyhzTE/rodlzcX9vRpAwGqAyxVvRZISt+8Js?=
 =?us-ascii?Q?5zrrDsqtPOX61DZJ4ayoufJDJqdfdflBsmq6gzjqmEB8Se5SShjKFMtdcLyk?=
 =?us-ascii?Q?YmFlMtJvgHtoLu7vTcjKoAD9H7FM71uUUEYCLCWS/6AFF7fmFKYznI7U0Lpz?=
 =?us-ascii?Q?P+UM14hthBQH3C54e/fwmrSPGYe7RZ7qc3dSZnqaIFVWY5EU7GQf0Nq9IBkA?=
 =?us-ascii?Q?8NpPuqfNHJd4UurVbBpONkAoGx816hc/hpwwVA+IeiWXF4Tdeve19r+17LWS?=
 =?us-ascii?Q?96vA82cx+Ub1rOF95m/AUmUIa5j4hwLm+TuZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 17:28:26.2842 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a226b0-d3c2-4f5b-1e41-08dd9e0d0e06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6573
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
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 33 +++++++++++++-------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index bac81de0a1712..28ed5ffbad6da 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -4699,21 +4699,6 @@ static void gfx_v12_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
 			       ref, mask, 0x20);
 }
 
-static void gfx_v12_0_ring_soft_recovery(struct amdgpu_ring *ring,
-					 unsigned vmid)
-{
-	struct amdgpu_device *adev = ring->adev;
-	uint32_t value = 0;
-
-	value = REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
-	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
-	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
-	value = REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
-	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
-	WREG32_SOC15(GC, 0, regSQ_CMD, value);
-	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
-}
-
 static void
 gfx_v12_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
 				      uint32_t me, uint32_t pipe,
@@ -5448,6 +5433,7 @@ static int gfx_v12_0_reset_compute_pipe(struct amdgpu_ring *ring)
 static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
+	unsigned int i;
 	int r;
 
 	if (amdgpu_sriov_vf(adev))
@@ -5472,7 +5458,21 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
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
 
 static void gfx_v12_0_ring_begin_use(struct amdgpu_ring *ring)
@@ -5588,7 +5588,6 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v12_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v12_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v12_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v12_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v12_0_emit_mem_sync,
 	.reset = gfx_v12_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v12_0_ring_emit_cleaner_shader,
-- 
2.49.0

