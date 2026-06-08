Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74054CD8C92
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2026 03:07:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10AA310EC6D;
	Mon,  8 Jun 2026 03:07:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RgJI+BUC";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010005.outbound.protection.outlook.com
 [40.93.198.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D7BC10EC6D
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2026 03:07:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oebo5NLoJvg04XUMJWapVtRNcNWKknj/OL+H3lYBuygjNM8p+7LNi7tdsU05dVYj7hKzWb0djSnNm4VTA4J8OMcV4BD93MDwZfdv6h0CPcsqBhFKIOh50S4Pq+DwItMvDba4dB7XbTi53LqV+nRKg/90/bnI3jAuacGXl/hOHWcUP5JPgk1ivTodl0hEM1d+h7ftux4MtPZ1nRfhk4Iptu7oGYjRNdmbi6hgZa1Tu/PZeAnVccn4AvIdPwWnSjETq8bphXw6eILYwghpaskZCcb398pYZ2baoCSdfiyfi00V3HdO2W5ftXjWhJA4CQMs/YqQgrnvAt6jO8GQz5rdqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcCBCx+wWO6SauV7V4xGjWumsbTB1JmWZ9YoohKKDXI=;
 b=trbhVDDIUPwuU5PAK0HrqZ6fdlY6iJ2GK1q1DmVd0/d34x/yenyP0+ABgsWjIDARZcNg0X2mfP+eNmIKjSaJUcz7fN0SMFw381s4DTTN7jkLXimHLoPkJcWauq6fI1dS9zG3jKQv7WGjwmTZnjKLgbCH7t7mpldepT6ZTxEQPrrYVjx+n15Xvi9qKawB+StS2lAUABl6oHbqXSfB7YiQ3rg5ILHRU/0yc1NfXWn6fOxs80gw5Ls3213eqa62af2uVtYVKyQ2KrdTosNgHD83pco3sY7ENDNi/pq/gOjFzAsE3uAsRiBm663Mmuvg+3wpYA5OHR+ZHGUb+gGsV9ZKfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcCBCx+wWO6SauV7V4xGjWumsbTB1JmWZ9YoohKKDXI=;
 b=RgJI+BUCiztUW/DFV7F0Mh46JHUwcd41aGywy0CGfGL8IrpgvLJhuzVA3kaRh/ZIUWQ3bBZtFYouxhFtBfTPbW6ZfWO9OOs4HcwnEHxlabnrifz+m2a8+BWAD6bPhYH9er3pwaP1ZDqh/PcKXMcU+A3YzxCMfwht7iPh+BmWeHQ=
Received: from SJ0PR03CA0032.namprd03.prod.outlook.com (2603:10b6:a03:33e::7)
 by DS0PR12MB8197.namprd12.prod.outlook.com (2603:10b6:8:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 03:07:35 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::a8) by SJ0PR03CA0032.outlook.office365.com
 (2603:10b6:a03:33e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.12 via Frontend Transport; Mon, 8
 Jun 2026 03:07:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 03:07:34 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 7 Jun
 2026 22:07:34 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 7 Jun
 2026 22:07:34 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Sun, 7 Jun 2026 22:07:27 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH] drm/amdgpu/gfx: defer per-queue helper_end until after MES
 resume
Date: Mon, 8 Jun 2026 11:05:48 +0800
Message-ID: <20260608030726.3396300-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|DS0PR12MB8197:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fffbf06-3910-4dad-9185-08dec50b1693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|11063799006|56012099006|3023799007|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 1P1jdpB7xxiuDmWG9rEW9c3hGfKZ0ans0ceyXBL3CURHqvaJ17bMDdXFHJyMGGZSsUPeFKT1F5BZ0Dr75YZZpjBNn0de+rxGdCCsss0atsSoX8gQOFxUAa2vZ05Yy5DxRwzWiAs11YQrBYbDles9h6VYrcPg+ihF8j9AfSBfv9L0SBf0etf+WbHK9bb7L84SPKoruuDn+yMPqhcCwzQ5OfBkjmeb/qnnhcnFEoKXuT/BGKfZMZsxpxDAnOWtpauwyARMIqnR2/NM8Koa9s+8+CcWTKriJLVjehGLafrUQMIH54+nJkandH5XzQ1XnqzcBviw/+8LYJr4mAvN5Xo3wMj2tP++iwFpXaWABXePg9MqEwu9YWh54fHnGIy2Dy2QF0qyMcqsKzvxP4xQPIZf5B8N5jc5SqeD/hwkl6ovsUh1VzQirbG8B/eS88SVKAuMOhdE7ic16HMS8aw+Kh+i7Xevuj28hF/hmX1/0dlAu/1UxT7Fayx8rGS4JwSUVAvpD6RqtlJGS+IQN53S5Les1YXtZR7aDhlkhGAf3RU4FEc2hmA/tKQhPK0tJBy2Y4q6NriwRuyVpd9Om+aufdWsD1aVMwfOmXtx9NAnXq5ziIWyyEZOc5Ii2lmeruYZz1b8+qRjEJV985VbdzDGTj2LwgF4HhokmG+a2UMT9NjC6Yh/z0vHVVU+Coo8wPUYeWpxxY/0AwjOcg3ET+oKN3N2Xlw3Ui8dx1apbBOrWCur/wM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(11063799006)(56012099006)(3023799007)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0fkmNe9A7jToET9UkDeIwQWPJztAlBwapZayGiJnqhTmXSZ2LTENm18QjBlX/nWn1Uat1vzo6PIvmkJG/hoo4ROMc+6SHI0PyuNzwIHSlcB/bTbKT8iBRxqrQ2cK6ZA4qELEo4edQN05jxwoBAAAq2dWtpO1+jou0nCyqiyLyX07gFA2PIm4tFZZgoKFOjqueJXMdNI9Xz1+33XF++8ZTSM73H5EgLHoRLsGZ97NShLqgK/DhOoGj8KLo2C/PtwZen7OKatjlsKNNt1Nt46fcod+UbFvK5bM8QoudmkT/YPNUjjRqd5qef9GAWK/BJOuHI/KpYIDI6aaJ5mODzABpIvblG6iJOs1LFS6zF++jqs0rjUi3cNP1Suo2IqR6c9QOayAW4qxV+FC7xnjpfn+1uu1WeF9PBpNx+VxjoYg9m9qra7XFmzxQduEetG8eba0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 03:07:34.5918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fffbf06-3910-4dad-9185-08dec50b1693
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8197
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

amdgpu_gfx_reset_mes_compute() runs amdgpu_mes_suspend(adev, 0) to
quiesce all gangs, resets the offending queue(s), then resumes. The
existing amdgpu_gfx_mes_reset_queue() called amdgpu_ring_reset_helper_end()
right after unmap/restore/map of the reset queue, which re-emits backed-up
commands and rings the doorbell. That doorbell hits a still-suspended CP:
on the subsequent resume the queue partially wedges -- the first new IB
after the reset may execute but later submissions stall, which surfaces
as repeated timeouts on the same ring under concurrent workloads.

Split out amdgpu_gfx_mes_reset_queue_no_end() (backup + MES reset +
unmap/restore/map only) and defer helper_end. amdgpu_gfx_reset_mes_compute()
collects the (ring, fence) pair for every queue it resets and runs
helper_end on each after amdgpu_mes_resume(), so the re-emit doorbells
land on a running CP. amdgpu_gfx_reset_mes_kcq() now reports the matched
ring/fence back to the caller for the same reason.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 68 ++++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  5 ++
 2 files changed, 65 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index ff5a55f5f3c9..b6202095f256 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1989,10 +1989,10 @@ static ssize_t amdgpu_gfx_get_compute_reset_mask(struct device *dev,
 	return amdgpu_show_reset_mask(buf, adev->gfx.compute_supported_reset);
 }
 
-int amdgpu_gfx_mes_reset_queue(struct amdgpu_ring *ring,
-			       unsigned int vmid,
-			       struct amdgpu_fence *timedout_fence,
-			       bool use_mmio)
+static int amdgpu_gfx_mes_reset_queue_no_end(struct amdgpu_ring *ring,
+					     unsigned int vmid,
+					     struct amdgpu_fence *timedout_fence,
+					     bool use_mmio)
 {
 	struct amdgpu_device *adev = ring->adev;
 	bool reinit_queue;
@@ -2026,7 +2026,20 @@ int amdgpu_gfx_mes_reset_queue(struct amdgpu_ring *ring,
 			return r;
 		}
 	}
+	return 0;
+}
 
+int amdgpu_gfx_mes_reset_queue(struct amdgpu_ring *ring,
+			       unsigned int vmid,
+			       struct amdgpu_fence *timedout_fence,
+			       bool use_mmio)
+{
+	int r;
+
+	r = amdgpu_gfx_mes_reset_queue_no_end(ring, vmid, timedout_fence,
+					      use_mmio);
+	if (r)
+		return r;
 	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
@@ -2216,24 +2229,37 @@ static void amdgpu_gfx_reset_stop_compute_scheds(struct amdgpu_device *adev,
 	}
 }
 
+/*
+ * Match the MES-reported hung doorbell against a compute ring and run
+ * the core reset (no helper_end). On hit, the matched ring and its guilty
+ * fence are returned via *out_ring / *out_fence so the caller can defer
+ * helper_end until after MES has resumed all gangs.
+ */
 static int amdgpu_gfx_reset_mes_kcq(struct amdgpu_device *adev,
 				    struct amdgpu_ring *guilty_ring,
-				    unsigned int db)
+				    unsigned int db,
+				    struct amdgpu_ring **out_ring,
+				    struct amdgpu_fence **out_fence)
 {
 	bool use_mmio = adev->gfx.mec.use_mmio_for_reset;
 	struct amdgpu_fence *fence;
 	struct amdgpu_ring *ring;
 	int i, r;
 
+	*out_ring = NULL;
+	*out_fence = NULL;
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
 		ring = &adev->gfx.compute_ring[i];
 		if (ring == guilty_ring)
 			continue;
 		if (ring->doorbell_index == db) {
 			fence = amdgpu_ring_find_guilty_fence(ring);
-			r = amdgpu_gfx_mes_reset_queue(ring, 0, fence, use_mmio);
+			r = amdgpu_gfx_mes_reset_queue_no_end(ring, 0, fence,
+							      use_mmio);
 			if (r)
 				return r;
+			*out_ring = ring;
+			*out_fence = fence;
 			break;
 		}
 	}
@@ -2254,6 +2280,8 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
 	unsigned int num_hung = 0;
 	bool use_mmio = adev->gfx.mec.use_mmio_for_reset;
 	struct mes_remove_queue_input *queue_input = (struct mes_remove_queue_input *)faulty_queue_input;
+	struct amdgpu_gfx_deferred_entry deferred_end[AMDGPU_MAX_COMPUTE_RINGS + 1];
+	int n_deferred = 0;
 
 	guard(mutex)(&adev->gfx.mec.reset_mutex);
 	/* stop the drm schedulers for all compute queues */
@@ -2278,9 +2306,13 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
 fence_reset:
 	/* reset the queue this came from if specified */
 	if (ring) {
-		r = amdgpu_gfx_mes_reset_queue(ring, 0, guilty_fence, use_mmio);
+		r = amdgpu_gfx_mes_reset_queue_no_end(ring, 0, guilty_fence,
+						      use_mmio);
 		if (r)
 			goto out;
+		deferred_end[n_deferred].ring = ring;
+		deferred_end[n_deferred].fence = guilty_fence;
+		n_deferred++;
 	}
 	if (uq) {
 		r = mes_userq_reset(uq);
@@ -2288,15 +2320,24 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
 			goto out;
 	}
 	for (i = 0; i < num_hung; i++) {
+		struct amdgpu_ring *hr = NULL;
+		struct amdgpu_fence *hf = NULL;
+
 		pipe = hqd_info[i].pipe_index;
 		queue = hqd_info[i].queue_index;
 		queue_type = hqd_info[i].queue_type;
 
 		/* reset any KCQs */
 		r = amdgpu_gfx_reset_mes_kcq(adev, ring,
-					     adev->gfx.mec.mes_hung_db_array[i]);
+					     adev->gfx.mec.mes_hung_db_array[i],
+					     &hr, &hf);
 		if (r)
 			goto out;
+		if (hr) {
+			deferred_end[n_deferred].ring = hr;
+			deferred_end[n_deferred].fence = hf;
+			n_deferred++;
+		}
 		/* reset any KFD queues */
 		r = amdgpu_amdkfd_reset_mes_queue(adev, 0, queue_type, pipe, queue,
 						  adev->gfx.mec.mes_hung_db_array[i]);
@@ -2325,6 +2366,17 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
 out:
 	/* resume all will enable the non-hung queues */
 	amdgpu_mes_resume(adev, 0);
+
+	/* Now CP is running again — replay backed-up commands and ring
+	 * doorbells on each reset queue.
+	 */
+	for (i = 0; i < n_deferred; i++) {
+		int er = amdgpu_ring_reset_helper_end(deferred_end[i].ring,
+						      deferred_end[i].fence);
+		if (er && !r)
+			r = er;
+	}
+
 	if (!r)
 		amdgpu_gfx_reset_start_compute_scheds(adev, ring);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 4003360c7d9a..381fc17274b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -549,6 +549,11 @@ struct amdgpu_gfx {
 	bool				disable_uq;
 };
 
+struct amdgpu_gfx_deferred_entry {
+	struct amdgpu_ring	*ring;
+	struct amdgpu_fence	*fence;
+};
+
 struct amdgpu_gfx_ras_reg_entry {
 	struct amdgpu_ras_err_status_reg_entry reg_entry;
 	enum amdgpu_gfx_ras_mem_id_type mem_id_type;
-- 
2.49.0

