Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EFBDC04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 16:44:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F87610E359;
	Tue, 14 May 2024 16:44:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zndVReZK";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2082.outbound.protection.outlook.com [40.107.95.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25C8010E042
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 16:44:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWv7iuWwWmSPAo+tMb0orrwQbdlqrsJBcKmR5ZwwGOxpiOHSSw+DkA7VhkKLqkT5YwH2p0zLXfXPQQP7gZ/uNqfr9sIJLY1u+eKH7Y5g8/mipeEZhVK/vToS9QCwNxbgOcdh33gJlYUBGspNjZfb0V5B7ThaHU5o48TFf6GsvWA8vVaqOe/21x2YWF8adz8XXyLfkmY2tIYP/qsS2jVqWIFUOAuTIV8Sv0zlVq1+huwTCqXKrdwVO8rKIK2qe3KxMH0jEhdgWvZUAdoiGjpBSXFSMfdrAyFirWb0jHiI0+3vvym/y+Pm8FCeQptedcKMco+rInan06iE/6l1hJ6a9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azanlNbHxxGTsWhsYxUNNSNOfflFpkICpdHSRYd0Wlo=;
 b=nJCTH5YhUEd+v68ouPXnx/eSADuRgDgOVUO9K7ZDq6UUG6lE/8pwOeHw6Q6PwyXZUfeTQDpZ2GXyTQZtZyJs/+Tyg3FCJE/3TVcqtIWFN8mxIEHFcsLF1nA9R1LTK1C2en59S1/mhi2/nRqI6Ab9hZMGCsmL8G5SaTPd+RXgs2c/EwUr9WK4k91fBoJW9sz9lgynGbEf+5GHGYkgmF6OqlsX/fpzlrce4e2cQB5Nis9lUN9rXE+9wnNwiDoQkQ5NNgLeTbN68S/3ZYpOc2i2VlC41vQYhag7izh+YQR1qR7PKDj4gFdHSqUGOulhsfryl4BnVHbpuStCWMABlQaUsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azanlNbHxxGTsWhsYxUNNSNOfflFpkICpdHSRYd0Wlo=;
 b=zndVReZK28dZmE+U8iMPQ0Qbgq7vq3Xptv2w7sNyPaa2wp1sPtiFpjxydJ9Wqx2VpqNEGpgB+1K2lNyXiKtMLcrr5UD/sg/KVEJAaljVVcavrYlrEgBq8wTkM1m49y9LV2cXny7kSoeZaOVKsicumZeJTTQewFIsyJc+Wpz1Tio=
Received: from BL1PR13CA0415.namprd13.prod.outlook.com (2603:10b6:208:2c2::30)
 by SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 16:44:51 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:2c2:cafe::d8) by BL1PR13CA0415.outlook.office365.com
 (2603:10b6:208:2c2::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.25 via Frontend
 Transport; Tue, 14 May 2024 16:44:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Tue, 14 May 2024 16:44:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 14 May
 2024 11:44:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: fix documentation errors in sdma v7.0
Date: Tue, 14 May 2024 12:44:19 -0400
Message-ID: <20240514164420.1111568-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|SJ2PR12MB8109:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bbce0a6-7b30-45b3-75a6-08dc74352ce0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400017|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mx4H76+qA3NKZzNS36a6gLCEhTtds3w3tOuDuziJifmTNKLYsBlOe7aw2TRm?=
 =?us-ascii?Q?AU7xbqMKCh360rOVsO/GBLlLBgS13Psjia0Gga6vfSeHvFwfIXtx+K0Rlwo7?=
 =?us-ascii?Q?zBz5mmKhE6yqtBmZzNUhDZasI4X2AcAeuBK0m+vJs5DkAa+aVf68jyFK+WL5?=
 =?us-ascii?Q?mima6n+j2I00rSVErkPxtwdzW18QYb37FRFlUFYD55sjwkhZ+qLbJGUsEroM?=
 =?us-ascii?Q?CyE6zS2x4ppcQnD4PGwaZYHHtKjXL5D3x5DGCM/GU6HhzwTZK2xzVtR9nSHW?=
 =?us-ascii?Q?L9rMohhbvLULuRvaDY3CTIlUHNEPVuXM5P+0foY8WVSOwDpkDg9Qbn+sIiQ+?=
 =?us-ascii?Q?F5Cq2ZO2+eaKFw55vFuMtUTq+IxwRuYf8LRrx2ZJe9WvaH/vqKyqK37cZXXl?=
 =?us-ascii?Q?eyjFISDrScMmLqEjiypgnyovu4GVc+5FrxulOsHtUwlbtQWzp2hfsVicRRnZ?=
 =?us-ascii?Q?xlMJxF0S9vBXJ+PX84IOTA2aymW7zAzp59ead2szc+7H6ba71GAsord6KOjX?=
 =?us-ascii?Q?ZtoeOoZOsGpXwqRh6Y+x+oqLljvCedsfiFXTYpvCHqVlZHqCreRJi/cYUUkN?=
 =?us-ascii?Q?T5yeNLctK+S7gdMjst1/O7tBcCmyXtVPvHGdWHo6YN73unF2xBl/JOVtLJO9?=
 =?us-ascii?Q?GyfmqJEpT5+ritLjNUvE5MK5VfsDRcHWFneRcJuEmggF3Tna+MLTJmB1y50i?=
 =?us-ascii?Q?YhzXY1PSh6i978Mrzw9mDjRlGnmaaT/GmOa2bJBfOA8qW1UxMQ4Ls/O1N51j?=
 =?us-ascii?Q?75UZ5ns3offWhzDKSR3/+99mQwD+QpVHn9+mJfXNzTZjARrMJwsrMJ1bNJZt?=
 =?us-ascii?Q?lTVU+AV2pYVZ0bpxni+Q+Ef0MSUXhrahNZbIR4gbm3XtwQ4QWmj5ex5do9Sd?=
 =?us-ascii?Q?koX8mowjXZxvWaWt+O9Ae2Y21doHT8vNBLBcKf/x4rJMlGHPutxK9gg/iWYC?=
 =?us-ascii?Q?0rgvfOFF4oeT8cmhLEUYsvQ6eaQJcBLbT3B/EWxaTna2x1R4iYTfyHPmT7WP?=
 =?us-ascii?Q?rHlzI3LYRFm6AjnAQQZe+6xr88BoNg2AkKNqI9hwbU3oXEef/nE0ABXCxJTC?=
 =?us-ascii?Q?/Fe2oNR4U4Ir53u26HV8SSGeD+8EMfhustAvQj/8mbH3IqWOo+HRaKs9u+Rv?=
 =?us-ascii?Q?WYKi371JWyh2NlJJ2ndqe/lLIbc2rXDVA04ryHwU3e54rccv97CwbUd6h257?=
 =?us-ascii?Q?99G48H8n6jIWRP2fpVILgj63CStjyt6Jubgzk6U/9rlasQsdW8yy5DlRbPal?=
 =?us-ascii?Q?hBaCwTts7l8rOnr/MfF2wWX6QX1H05/L52bEuuDlMUyBjlRxTx0XesnyUawg?=
 =?us-ascii?Q?yRwDIH951K6JyrdIHWwOQuxzHWzc7ikDNBnjEvhW+A+khFipEv7C9QZ9GdV/?=
 =?us-ascii?Q?B/HFHzS4ss5yqsw/a1EiwYp2X5zU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400017)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 16:44:51.4295 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bbce0a6-7b30-45b3-75a6-08dc74352ce0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8109
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

Fix up parameter descriptions.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 7db53a96cff0a..4a5252e088838 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -224,7 +224,9 @@ static void sdma_v7_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
  * sdma_v7_0_ring_emit_ib - Schedule an IB on the DMA engine
  *
  * @ring: amdgpu ring pointer
+ * @job: job to retrieve vmid from
  * @ib: IB object to schedule
+ * @flags: unused
  *
  * Schedule an IB in the DMA ring.
  */
@@ -260,8 +262,6 @@ static void sdma_v7_0_ring_emit_ib(struct amdgpu_ring *ring,
  * sdma_v7_0_ring_emit_mem_sync - flush the IB by graphics cache rinse
  *
  * @ring: amdgpu ring pointer
- * @job: job to retrieve vmid from
- * @ib: IB object to schedule
  *
  * flush the IB by graphics cache rinse.
  */
@@ -313,7 +313,9 @@ static void sdma_v7_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
  * sdma_v7_0_ring_emit_fence - emit a fence on the DMA ring
  *
  * @ring: amdgpu ring pointer
- * @fence: amdgpu fence object
+ * @addr: address
+ * @seq: fence seq number
+ * @flags: fence flags
  *
  * Add a DMA fence packet to the ring to write
  * the fence seq number and DMA trap packet to generate
@@ -915,6 +917,7 @@ static int sdma_v7_0_ring_test_ring(struct amdgpu_ring *ring)
  * sdma_v7_0_ring_test_ib - test an IB on the DMA engine
  *
  * @ring: amdgpu_ring structure holding ring information
+ * @timeout: timeout value in jiffies, or MAX_SCHEDULE_TIMEOUT
  *
  * Test a simple IB in the DMA ring.
  * Returns 0 on success, error on failure.
@@ -1038,10 +1041,9 @@ static void sdma_v7_0_vm_copy_pte(struct amdgpu_ib *ib,
  *
  * @ib: indirect buffer to fill with commands
  * @pe: addr of the page entry
- * @addr: dst addr to write into pe
+ * @value: dst addr to write into pe
  * @count: number of page entries to update
  * @incr: increase next addr by incr bytes
- * @flags: access flags
  *
  * Update PTEs by writing them manually using sDMA.
  */
@@ -1095,6 +1097,8 @@ static void sdma_v7_0_vm_set_pte_pde(struct amdgpu_ib *ib,
 
 /**
  * sdma_v7_0_ring_pad_ib - pad the IB
+ *
+ * @ring: amdgpu ring pointer
  * @ib: indirect buffer to fill with padding
  *
  * Pad the IB with NOPs to a boundary multiple of 8.
@@ -1145,7 +1149,8 @@ static void sdma_v7_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
  * sdma_v7_0_ring_emit_vm_flush - vm flush using sDMA
  *
  * @ring: amdgpu_ring pointer
- * @vm: amdgpu_vm pointer
+ * @vmid: vmid number to use
+ * @pd_addr: address
  *
  * Update the page table base and flush the VM TLB
  * using sDMA.
@@ -1549,11 +1554,11 @@ static void sdma_v7_0_set_irq_funcs(struct amdgpu_device *adev)
 /**
  * sdma_v7_0_emit_copy_buffer - copy buffer using the sDMA engine
  *
- * @ring: amdgpu_ring structure holding ring information
+ * @ib: indirect buffer to fill with commands
  * @src_offset: src GPU address
  * @dst_offset: dst GPU address
  * @byte_count: number of bytes to xfer
- * @copy_flags: flags for the copy
+ * @copy_flags: copy flags for the buffers
  *
  * Copy GPU buffers using the DMA engine.
  * Used by the amdgpu ttm implementation to move pages if
@@ -1579,7 +1584,7 @@ static void sdma_v7_0_emit_copy_buffer(struct amdgpu_ib *ib,
 /**
  * sdma_v7_0_emit_fill_buffer - fill buffer using the sDMA engine
  *
- * @ring: amdgpu_ring structure holding ring information
+ * @ib: indirect buffer to fill
  * @src_data: value to write to buffer
  * @dst_offset: dst GPU address
  * @byte_count: number of bytes to xfer
-- 
2.45.0

