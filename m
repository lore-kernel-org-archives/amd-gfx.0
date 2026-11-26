Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84EC606A333
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 09:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zKy1qxOm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15F8811222C;
	Thu, 26 Nov 2026 09:35:06 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010061.outbound.protection.outlook.com [52.101.46.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 995151121E3
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 09:34:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ygFrH9dXaunqP2PkwQw4y+r50iEQNaKWfMkEXJhd2Gt+nv6HtlgUozw6vEG7kDGOaj+uoYh/bpnHk3E7gJs3b+7p6WiLU3GU54XHD6RPIoWQLQV7d42vr54ADA68h/ZYly1iVMW+84x5GUKakDMf7TW80Bl/Xq+ggQ+orsThgxjTdHNSIo9a8vK7P4RjzwIYmVGV0RBnBReuiVUvPp/0iDJc+OQaMnTCTW2z4W2YY6EyP9bhT86ujrft7ZgOrkcJwtN5CMO1ca1GX+gMKsm1o95RpaLV5XcBGxZ1e0YAMtIBgnE3mgqAwUhXhO5jQLcs3TxYJGdomLVtLIR33U/XDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iX7UniYFmMts4Mm+kuEXjLCwTvFX2HAIalaP92p2eGI=;
 b=KIBXSlMH/xJn/UXPo/re4ygPBVhmpL5JumZTpJwEEqICuv0rV3nP58u1XaXL6vTi34xi66m+E3fKKAvt9UZGkSLIqHaAZ5giMDYwX/UQnfE0Ce31oQgRBrho+bkBWxOYJ1JkGLaofuC2rdKMZA76LqmqPIqLy8GcUEbK1SuUMFIGzlo4slnF8fJjOR3Nr541nKRyD3d+pCS9Wdfp4TBsJE9w2d9af43z1ayAs7NykmdnBm3RgIMwPZsxPdUw+SloCH/ChTKlByqVrKVptQKpXEpKm3MvwV6mP9lUwDXjmQ0pwdzp2wZ+GMD20QXGXdDrNoMACC8uYFO4ND7dSwfiZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iX7UniYFmMts4Mm+kuEXjLCwTvFX2HAIalaP92p2eGI=;
 b=zKy1qxOmzZ1N8KMN77ce95Qa8Kcym2KA6N2FcqPRbfBZDCJTwl1PAmOa9irlQ5L+ncOLD+FvjUtQsyTJTyemi7Cs83TITRqjujXGk9JVGYHXCksULok7XlLX9Yx7vGRHauENF0ejmWaWHXqlJMBVdy3goMAub9VrccfS8YOObQA=
Received: from DS7PR03CA0210.namprd03.prod.outlook.com (2603:10b6:5:3b6::35)
 by PH8PR12MB999321.namprd12.prod.outlook.com (2603:10b6:510:40e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 09:34:56 +0000
Received: from CH7PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:5:3b6:cafe::7d) by DS7PR03CA0210.outlook.office365.com
 (2603:10b6:5:3b6::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 09:34:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH7PEPF00000017.mail.protection.outlook.com (10.167.244.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.2 via Frontend Transport; Thu, 26 Nov 2026 09:34:56 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 03:34:55 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 26 Nov 2026 03:34:53 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <timur.kristof@gmail.com>, <Mario.Novales@amd.com>, 
 <Manu.Rastogi@amd.com>, <Jiongyu.Zhu@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH v5 13/15] drm/amdgpu/userq: reset the gfx engine when a gfx
 user queue reset fails
Date: Thu, 26 Nov 2026 17:33:49 +0800
Message-ID: <20261126093417.192538-13-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261126093417.192538-1-Jesse.Zhang@amd.com>
References: <20261126093417.192538-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH7PEPF00000017:EE_|PH8PR12MB999321:EE_
X-MS-Office365-Filtering-Correlation-Id: b9ebdedb-501e-43c9-0454-08df4ba0885c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|261009223027099003|22082099003|18002099003|11063799006|10067099003|56012099006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021123027099003|261021121427099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: +H3bj8C6Y02yMbjn1PgNGcw1iBxdt5wI/0S69PKReaQqCZ0JEdKNmu/PCOOMmtP47wT49Tn8AyXjPuHrOkO5b18VfOR1P/BPDhcjlZc9KXFVNN+opY/X6ysZUtbchFLvfFmRpIMy8gEIeuIjcVJNykq+8DHZ6mz2ZxgSQ5vOUOd/88ceXDzfbSHb8CFwVa7xuhkw83TT48mABDT+4UvhDRIiGw2l/On2DaL6tiEpcOSEIDol2ZKlw/5lxpJDMBJq5i6Bga1quD9gCos9xGLW6I6RJ21cFlICCUsA4zxJGnu6H+fUQwCc0FV+ktZryLf0a7xORaNoLpRTHxU382NN6/W9EqPJ6McpiwCmzRSGfqfndz+2yV7NFtnXgJ+TqQePFEgbkjpwK18TWdHrOwPzCZNSqxw0JbXRwcoMndWNCh3WRAXAeXTV5IO7GDUqmMoCQRy2aMqaL5v6WVlQHlpIjImFWP56Yb1V7IR7NjE4arUATYp6yHMe4Bl9wrATDzz69Zsr4tyr0dT6F44CZhZBCbETQbIuTA4svwuN4D7nq87VLHwbOBloAJ4tlhc/BPX1Qqwz5yJrnry712Xi7H4UvaaC25RVlLwgVDz++1ykz8+zhoxDBPBGZZU5Uga4OHs3GpzcVmpKsBu5ayY0Blt2oOwnEn8B9iFLFXqkbWRvP7KqPy8qoKTczaGDnT2NZZyoR4jArCxqp39ddXRYtkghKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(261009223027099003)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261021121427099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /uCwwnQygWmCkwwnj1wts+lg64tslFu6A/tQxRn9Q9XbE6O6bfvmfiBYhdz0agq+rnJ0tVyQ0nSi3b1ZgCiezDXQfYts+MzqnO+0yRFJLpwS1RcOHMCAK5TyZFjwlvNrJjLmi3583QCyfW/BXsyGiJkKJOQhioPNur59yWy39ggkvhHnXm+yWvdaJssrvOJbZnXTr75JOgcmcER/xBfxSpkABw2KHLd8wQ9uoaBYEgxwWsC7IAiY/RePkGEM9MYZexRmkfKM2fqGx88hoezRUGId0TpzFfeKUyfnLmPdZNxij9Q/TILW1eRWSobfWQWWKcjD5iXlg1sOqqYaH/qpP5lBaftESjQW69kX4wgmHiKw4pcYyW5pnbj+Er8KT8nRaOaB4eAOE1nZksus5tn+kb/UcvCdS903GUegmUYtSdK3Rzyd/UKttuhvL+kL1bmL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 09:34:56.3924 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ebdedb-501e-43c9-0454-08df4ba0885c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH7PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB999321
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When neither the queue nor the pipe reset recovered a gfx user queue,
fall back to a soft reset of the gfx engine before a full reset, when
the GFX IP supports it. A hung kernel gfx queue gets there through the
IP block soft reset of the job timeout handler; a user queue has no
kernel ring, so call amdgpu_device_ip_soft_reset() directly, with the
gfx ring type, the master XCC of the queue partition as the engine
instance, and no guilty ring.

The hung queue can't be unmapped before the reset: pass it to the engine
reset, which unmaps it once the reset cleared its HQD, and hangs it,
while the other gfx user queues keep their state.

v4: Call amdgpu_device_ip_soft_reset(), which now takes the ring type
    (Timur).
v5: Pass the XCC of the queue partition as the engine instance (Lijo).

Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 42 ++++++++++++++++++++--
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 7abb9d95ef59..8d0cd4575844 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -235,11 +235,40 @@ int mes_userq_reset_hw(struct amdgpu_usermode_queue *queue,
 	return 0;
 }
 
+/* The master XCC of the queue partition */
+static u32 mes_userq_gfx_inst(struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = queue->userq_mgr->adev;
+	u32 xcc_mask;
+
+	if (!adev->xcp_mgr ||
+	    amdgpu_xcp_get_inst_details(&adev->xcp_mgr->xcp[queue->xcp_id],
+					AMDGPU_XCP_GFX, &xcc_mask) || !xcc_mask)
+		return 0;
+
+	return ffs(xcc_mask) - 1;
+}
+
+static int mes_userq_reset_gfx_engine(struct amdgpu_usermode_queue *queue)
+{
+	return amdgpu_device_ip_soft_reset(queue->userq_mgr->adev,
+					   AMDGPU_RING_TYPE_GFX,
+					   mes_userq_gfx_inst(queue), NULL,
+					   NULL, queue);
+}
+
+static bool mes_userq_gfx_engine_reset_supported(struct amdgpu_device *adev)
+{
+	return adev->gfx.gfx_supported_reset &
+	       AMDGPU_RESET_TYPE_IP_BLOCK_SOFT_RESET;
+}
+
 int mes_userq_reset(struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
 	struct amdgpu_device *adev = uq_mgr->adev;
 	struct mes_reset_queue_input queue_input;
+	int r;
 
 	/* already reset by an earlier job's hang-detect; just signal and bail */
 	if (queue->state == AMDGPU_USERQ_STATE_HUNG)
@@ -248,8 +277,10 @@ int mes_userq_reset(struct amdgpu_usermode_queue *queue)
 	/* A GFX pipe reset also affects the kernel rings on that pipe. */
 	if (queue->queue_type == AMDGPU_HW_IP_GFX &&
 	    adev->gfx.funcs->detect_hung_queue &&
-	    amdgpu_gfx_me_pipe_reset_supported(adev))
-		return amdgpu_gfx_reset_mes_gfx(adev, NULL, NULL, queue, 0, true);
+	    amdgpu_gfx_me_pipe_reset_supported(adev)) {
+		r = amdgpu_gfx_reset_mes_gfx(adev, NULL, NULL, queue, 0, true);
+		goto out;
+	}
 
 	memset(&queue_input, 0x0, sizeof(struct mes_reset_queue_input));
 	queue_input.doorbell_offset = queue->doorbell_index;
@@ -277,7 +308,12 @@ int mes_userq_reset(struct amdgpu_usermode_queue *queue)
 		}
 	}
 
-	return mes_userq_reset_hw(queue, &queue_input);
+	r = mes_userq_reset_hw(queue, &queue_input);
+out:
+	if (r && queue->queue_type == AMDGPU_HW_IP_GFX &&
+	    mes_userq_gfx_engine_reset_supported(adev))
+		r = mes_userq_reset_gfx_engine(queue);
+	return r;
 }
 
 int mes_userq_reset_queue(struct amdgpu_device *adev,
-- 
2.50.1

