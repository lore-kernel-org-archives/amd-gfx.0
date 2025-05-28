Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F76C5B559
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 04:19:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB15610E56E;
	Wed, 28 May 2025 04:19:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2AnMkoPf";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FF7210E161
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 04:19:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6HC/MdNOdD9oJlHMYju0aLzW5mOXY3xVwcfx+n6biSyq9oRJ4Fmk0airRiz8OXF8gBDpJ9rfDx7H3fHHl7KQUE6fWRuAZdzHuqBlpxsokt29Sphnf3CUjdNPlag3l2z2imw3RiSsXT+xm+NCUwNcBFfylr8cBhHJKyWX4qtdAxVmTYNculcZCl9O0hnSM/tkRk14pap6fz4nJeeBneyWISWQSHvFM1EBmVjn9FiLvo1CxC/ikrbYWmy1YSunNV6ExEhmeChoJj1vPXQ2o6NO1TctIRp/4s+WTUZS12h1wJsltJb/a8IGO20U/U6KE1OYXaoj24BR2xm1av1HYsLVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pyh3op5I4e7Ab0h6wjgyx7nGqEYMwDtB6TPLnNSz6rM=;
 b=J7DeXNgEIzj4C2klOFun2oa/mAe4OI8wBkSPcmAfO16RnETn8UGZPsj+4E6nbNw/A0hzTt6TnzJFe3IQqqygdPLXx3Yd52asHILATyM2l970HhRhFFisa+T+I/hRP7dtm0WH8+ZXAAI4t3/wlPiiIy9k2tabXnlg2pmEPkjcbLIbYJlj3dyUr91hKOdqudmGyx/OgduTdjtjo35uJoGyJFYzmialVvwPEEZrQys5J1r+zZqhHTAlo2AF/51JMJNpJP+QD7kWW0ftpLjfwaRT0W+UxGNUnhKmnqq/7SXFgaFXNbnzgeWH8BOvFlRYZzT2GIO2nPmxjJ2yxHZF4l2izA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pyh3op5I4e7Ab0h6wjgyx7nGqEYMwDtB6TPLnNSz6rM=;
 b=2AnMkoPfb7OhggwBoPtGA86uIUPO1cKShqaxDJe+vhDmUx+rtyQCcCEbHnMjfp1EJi8zXr/AFHvRTGPa01nPEp5LicVLXHxN4t9+qNYru0JkCKnYBbkoVA4wSwSa3XeBzibBgr52jbVmFnFrnKMMONBD4IGVUQ0NAmJQoQeUkn0=
Received: from DS7PR05CA0051.namprd05.prod.outlook.com (2603:10b6:8:2f::12) by
 DM3PR12MB9415.namprd12.prod.outlook.com (2603:10b6:8:1ac::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.27; Wed, 28 May 2025 04:19:39 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::79) by DS7PR05CA0051.outlook.office365.com
 (2603:10b6:8:2f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.15 via Frontend Transport; Wed,
 28 May 2025 04:19:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 04:19:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 23:19:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 17/19] drm/amdgpu/gfx10: re-emit unprocessed state on kcq reset
Date: Wed, 28 May 2025 00:19:12 -0400
Message-ID: <20250528041914.5844-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250528041914.5844-1-alexander.deucher@amd.com>
References: <20250528041914.5844-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|DM3PR12MB9415:EE_
X-MS-Office365-Filtering-Correlation-Id: 709589b8-20d9-4a42-a166-08dd9d9edcef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rYid2m6u71odcJdqQFUfo+C3CiEFg1eJ9L+b904p4m/KkdoxHxJKPhxXSvyU?=
 =?us-ascii?Q?4KUegh6ci14Rf2WdRsLQbU04jM8S9h54GbhKht+irS9eoN0vtHPhiOjVQvK3?=
 =?us-ascii?Q?rQILDbw0F5poqCigrqWBzvDqjWFXGGrJI1+m8K4Y2hHjJF0z5xD94CMjAyDu?=
 =?us-ascii?Q?JXwiSqNYHfyjTcLXFuSRKPFKE5LrZ5g8HQAryvnTSRtBpOeqgcjP1yzyCPtD?=
 =?us-ascii?Q?erVcl/66jFLLvRZP9YHFpbI0lVhhmG3MsTw0EsASiYmGNO2SbaYCWyBa0RE3?=
 =?us-ascii?Q?IRNOQjUF+mez2bLT55EHC2IDPxR9v4LVv7KPqOjagtFhFfjceFa8lEzPZiOY?=
 =?us-ascii?Q?0dRRjxkgaqt7UNBq+41oqUTwjegznn49bylWoSlEM9dR4AjuS5SeYxTtMZ3V?=
 =?us-ascii?Q?4g7c9ryXeQNkFIzniOWfckB0uyUsp8j04W9dGPdNvnTvSe4tnXAP/sOSTi/n?=
 =?us-ascii?Q?pe1pSNWYyW8ZkGr5OSA+PqkxiNQTzi0XuLV4TCefSreteviYXGdcSXMjNA7w?=
 =?us-ascii?Q?FOl/Ft8Qg6foZ5mgwPLzZtD2W7jKcgOwtbdTXRnkCj4S1uCXJK7MzoBXuw0K?=
 =?us-ascii?Q?vj7i0E9dAdWAjZGJwShicqfaaXHQD/cL9HT6FgrVqJBYiqpDjSctBANm/WkA?=
 =?us-ascii?Q?D8q9T2ynMYM7cWq5q3enIEXsA86KJhLIlC9FEKsXamZ/VSdQqYi1Yk/XVJAw?=
 =?us-ascii?Q?D9F9xXzKM6d43k1kb8etyAQ5JVGlsrOH3M0TpHCx4l93qbZ9ocMkWjNY7/84?=
 =?us-ascii?Q?qL28Im7LXQbZGDVR3rRta7dHx5bF5uH+4dYt8akOuisvYCXDAYKgt+Ve87iy?=
 =?us-ascii?Q?OihWu7V/gLoHvnEcL01IjpzaZXIXiu+Z/yCp631Ssi2qOVyi3MGSZotZqpVL?=
 =?us-ascii?Q?2ZByOncu3UQ52ucbn/FySgViYWdfT4anVH4SdPKXbznEA3WNX+A9kGGSY1EJ?=
 =?us-ascii?Q?LCIYtDzyehIMcQIBuBCojHV2GuCm6FLoKsCVGcfDgENQbFAxEO7SNSrbJwhY?=
 =?us-ascii?Q?H+alK70uamMsZkWj17/Unv7ZpIETRtBJ5R5AnPFJiRgMQLlK1km6xSIWZzgG?=
 =?us-ascii?Q?cZRuShEwzHo9QdVP8pQHwKg2Y03o/iWEtkDDAC8m1aeN5CGTq9id1wYrhVYA?=
 =?us-ascii?Q?/26mXoboL/vKQfUumUQ+O5OTX+4MWDnKdFyUdHfL0qCDIYA67bxyq75OaRXm?=
 =?us-ascii?Q?4DPvls0LyqPqJINQgU81udfnP1vzMdcfUYDJgM+kfj/tQtiUdkrBypTMXcGj?=
 =?us-ascii?Q?QfC9r6XIEdlaBWCaVxtOxZ1RyPOqEHUqjSCcuuLK0KxHoT8XpxxZ6vjbDLrb?=
 =?us-ascii?Q?rxWQkFf64+MHtqMJ+yuaxC4Uips4TKMYBfPu9jSyiYFpiOnjwQPPuY3nDmiA?=
 =?us-ascii?Q?cBfSgCx9o0s9NlvnxIhyzIwlUEgE3n3kku0+NG+ZvvULsqR7kEj71a/U4HLj?=
 =?us-ascii?Q?ya+jVaQyXT4+0ScFBkmgIEJMe0XKgn8W9q3dJxYMtEJgFQtKNbUkG4S20p/T?=
 =?us-ascii?Q?DF8QgVsM9JIszWk5PZj/DjTrI09hIY23sRcq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 04:19:39.2757 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 709589b8-20d9-4a42-a166-08dd9d9edcef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9415
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
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 29 +++++++++-----------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index f6e04cf21abcc..329059c683cb6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9055,21 +9055,6 @@ static void gfx_v10_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
 							   ref, mask);
 }
 
-static void gfx_v10_0_ring_soft_recovery(struct amdgpu_ring *ring,
-					 unsigned int vmid)
-{
-	struct amdgpu_device *adev = ring->adev;
-	uint32_t value = 0;
-
-	value = REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
-	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
-	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
-	value = REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
-	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
-	WREG32_SOC15(GC, 0, mmSQ_CMD, value);
-	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
-}
-
 static void
 gfx_v10_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
 				      uint32_t me, uint32_t pipe,
@@ -9656,13 +9641,20 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	}
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r)
 		return r;
 
-	return amdgpu_ring_test_ring(ring);
+	if (amdgpu_ring_alloc(ring, 8 + ring->ring_backup_entries_to_copy))
+		return -ENOMEM;
+	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
+			       ring->ring_backup_seq, 0);
+	for (i = 0; i < ring->ring_backup_entries_to_copy; i++)
+		amdgpu_ring_write(ring, ring->ring_backup[i]);
+	amdgpu_ring_commit(ring);
+
+	return gfx_v10_0_ring_test_ib(ring, AMDGPU_QUEUE_RESET_TIMEOUT);
 }
 
 static void gfx_v10_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
@@ -9937,7 +9929,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v10_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
 	.reset = gfx_v10_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v10_0_ring_emit_cleaner_shader,
-- 
2.49.0

