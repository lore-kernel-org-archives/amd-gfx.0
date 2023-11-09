Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC53C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Nov 2023 07:37:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6F7689266;
	Thu,  9 Nov 2023 07:37:29 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68FF110E1C3
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Nov 2023 07:37:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUeI1ccTqFH/bUPj4hz+2oRSWnhATzhsnHHYQlZ44MBZZKpUksYK3iC8da8PEe8akIMEHEDvy+/ghDphWwH/G/4o58C1jVrRI5vzVjx5nz2hpjztA4tovFwo+niBXSSzRoE5U7bZOzw7l9ZUrpbEcu/NQguxRKCLk62ze/gYmcy6nmv2zSSw7zrYZupeqET/1CVAwbUDGCYzodVoTpXHEAHCWph74hCWuxuXDEHlBLFxU28Xrv/EbfYNGuOSF8Xap3OTe/DaO2rE14X8pMFrOXUqB85pgWzIQCABEVncigwdwmSXt4EmAF9XNVHfkfWjda0UQeC+X0zkiML8TWsbfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oxup8KF/SQ9HBoiyWQvQEZ2DSzP4AbMaBPZtmzjgUSc=;
 b=QWRC/udPKU2rup5VidynSW7KmMKgUk2Y1uWV2uARXbxstnMt4/RZ+qKXC7uakPxAH/C4HPltk3QtJ793/omGIalb26fqV0Ln5PwuWGhXRia5tC3F/ZlVgPy8h2xDHa+9PcPX6L6QMYsfvpbf02ayqpDIXwqZSuzABXQNKfyeWA4eXi+8Eqv2FkmqxlR7hiPNb5aBs3qOxdhQDV4SAfVu9Kg25U+slYBNg8sUKh5g7A9HUQEDRf+KLgxA7QHmk6ESTnhR+cxz74swhpjNqFC51GqEhB6p/7QXZX4ljnVwO+uKf98MQcvKPQa30WyxV3Z5p9pDmJg7AWRB4Z3j9c2hJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oxup8KF/SQ9HBoiyWQvQEZ2DSzP4AbMaBPZtmzjgUSc=;
 b=uUzuXkHRBkUIt1OgB/klEnXJfDwRd3g6+HKatDCQteJtanx5nYeVXa3oWY9B0n5bDy1GI+1V8z+qMZT4hRaYfJ0uJaOWYOGVb81lSzab2TRw6/VmgLDwYRYl4tGzujNK1nbriNHO55El3jiBQFjpHBv3hED+3XAMGWEEJIdeUDU=
Received: from BL0PR02CA0134.namprd02.prod.outlook.com (2603:10b6:208:35::39)
 by CH3PR12MB7523.namprd12.prod.outlook.com (2603:10b6:610:148::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 07:37:25 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:35:cafe::d4) by BL0PR02CA0134.outlook.office365.com
 (2603:10b6:208:35::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Thu, 9 Nov 2023 07:37:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Thu, 9 Nov 2023 07:37:25 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 9 Nov
 2023 01:37:23 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: add amdgpu runpm usage trace for separate
 funcs
Date: Thu, 9 Nov 2023 15:37:01 +0800
Message-ID: <20231109073701.1751965-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109073701.1751965-1-Prike.Liang@amd.com>
References: <20231109073701.1751965-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|CH3PR12MB7523:EE_
X-MS-Office365-Filtering-Correlation-Id: 61998318-6c47-4ff5-d748-08dbe0f6b7c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MPvPcbo6qa49Ouc7uDXn2na/d3wIuhZabWw88zK1uxHwKOoXL3hLPhcQH8AINXtoROmWEd+3YpscrsAnUQogRhy/GBZkuZ4Mr33XizveRBqZDpnM6OFmZAdyMRElk6jGsyd0NYUdWMKQOQvuYwuwfovl7TALFu4C6mE9FfE5AXrIFJPFoOvrMedhhN2M8aT01vhoYb83HnBA+gROOmO3N1c1vVvtC0DxdxxCoRGO+JVzAS8TX32j5xzb7QFZVskG06vVDPCsuWVOBMzb6lT+zYh1Jbfe4qG+0dBuFokeKHeDDS+HRyfLnIzkcEcIbxgzgzt+vw+VRiqbjXSv7DgUQcDPCsJ+nfuecrVolIBZyUf9kUoqDfqRpXIlCY0qHwCrmLlN6BrZByPMAzeGIAJc1R6EqI/UPCiBRxPLH6ONQukoSbp6Us/7saA/N3fX4rP2sEpS6kM98AMGKxGXnIUaS7miRQ/wtCSFAJiPj5+kwOeYpb0FYTdoknpQ/4620/nqgWoJm3BmgKP8X2vPpUbIn+/DxA4oD8xfrSvVLfRGUOmb1Hi5cb3Sg5ZyuO3iF57N94XojXK7BxjyOalDHAWOCezTvu3W00o2IKhmO3MmqnSf30xyjn9BZNYfsqrWb0yHLjbhgNqyng0qy+LafO+KNz/0OgUZxEki3pp/SijpmJMguAVhNA46zY1MUe2VgM/GK9K27mjqNFpG55b2KTraAUHH9vOIC8MaXJ88tlnjjvYsO9+Awpii1VUWWCfkiD4eZb9Ug3mrA3qbmFHLzrcvEg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(82310400011)(451199024)(64100799003)(186009)(1800799009)(36840700001)(46966006)(40470700004)(83380400001)(7696005)(6666004)(36860700001)(2616005)(478600001)(47076005)(26005)(426003)(336012)(41300700001)(2906002)(1076003)(70586007)(5660300002)(54906003)(4326008)(70206006)(8936002)(316002)(8676002)(6916009)(36756003)(86362001)(82740400003)(356005)(81166007)(16526019)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 07:37:25.2361 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61998318-6c47-4ff5-d748-08dbe0f6b7c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7523
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
Cc: Alexander.Deucher@amd.com, Prike Liang <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add trace for amdgpu runpm separate funcs usage and this will
help debugging on the case of runpm usage missed to dereference.
In the normal case the runpm usage count referred by one kind
of functionality pairwise and usage should be changed from 1 to 0,
otherwise there will be an issue in the amdgpu runpm usage
dereference.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   |  7 ++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h   | 15 +++++++++++++++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index e7e87a3b2601..decbbe3d4f06 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -42,6 +42,7 @@
 #include <linux/dma-fence-array.h>
 #include <linux/pci-p2pdma.h>
 #include <linux/pm_runtime.h>
+#include "amdgpu_trace.h"
 
 /**
  * amdgpu_dma_buf_attach - &dma_buf_ops.attach implementation
@@ -63,6 +64,7 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
 		attach->peer2peer = false;
 
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
+	trace_amdgpu_runpm_reference_dumps(1, __func__);
 	if (r < 0)
 		goto out;
 
@@ -70,6 +72,7 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
 
 out:
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+	trace_amdgpu_runpm_reference_dumps(0, __func__);
 	return r;
 }
 
@@ -90,6 +93,7 @@ static void amdgpu_dma_buf_detach(struct dma_buf *dmabuf,
 
 	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+	trace_amdgpu_runpm_reference_dumps(0, __func__);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 709a2c1b9d63..1026a9fa0c0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -183,6 +183,7 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amd
 	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
 			       seq, flags | AMDGPU_FENCE_FLAG_INT);
 	pm_runtime_get_noresume(adev_to_drm(adev)->dev);
+	trace_amdgpu_runpm_reference_dumps(1, __func__);
 	ptr = &ring->fence_drv.fences[seq & ring->fence_drv.num_fences_mask];
 	if (unlikely(rcu_dereference_protected(*ptr, 1))) {
 		struct dma_fence *old;
@@ -286,8 +287,11 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
 	    seq != ring->fence_drv.sync_seq)
 		amdgpu_fence_schedule_fallback(ring);
 
-	if (unlikely(seq == last_seq))
+	if (unlikely(seq == last_seq)) {
+		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+		trace_amdgpu_runpm_reference_dumps(0, __func__);
 		return false;
+	}
 
 	last_seq &= drv->num_fences_mask;
 	seq &= drv->num_fences_mask;
@@ -310,6 +314,7 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
 		dma_fence_put(fence);
 		pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+		trace_amdgpu_runpm_reference_dumps(0, __func__);
 	} while (last_seq != seq);
 
 	return true;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index 2fd1bfb35916..5d4792645540 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -554,6 +554,21 @@ TRACE_EVENT(amdgpu_reset_reg_dumps,
 		      __entry->value)
 );
 
+TRACE_EVENT(amdgpu_runpm_reference_dumps,
+	    TP_PROTO(uint32_t index, const char *func),
+	    TP_ARGS(index, func),
+	    TP_STRUCT__entry(
+			     __field(uint32_t, index)
+			     __string(func, func)
+			     ),
+	    TP_fast_assign(
+			   __entry->index = index;
+			   __assign_str(func, func);
+			   ),
+	    TP_printk("amdgpu runpm reference dump 0x%d: 0x%s\n",
+		      __entry->index,
+		      __get_str(func))
+);
 #undef AMDGPU_JOB_GET_TIMELINE_NAME
 #endif
 
-- 
2.34.1

