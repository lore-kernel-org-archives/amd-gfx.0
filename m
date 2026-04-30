Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DDFFF8873
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2026 16:13:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC58810F3B9;
	Thu, 30 Apr 2026 16:13:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R8KvrWSt";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010013.outbound.protection.outlook.com [52.101.56.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34E9D10F3B9
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 16:13:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P8QNMiNNpbhcvMhs8raizsn18Oy0T1VK1rt0tfkC/QG+Jlod7W/VCbqZbD2j7VGpL+4vdHyPTocLAeUe2Lf5RqFRzThsnHxVVdoUFq+lp/hXF5QJ0y9NvAsBUEe2Noew6CijzsFxKzJ17BB0SxMcy1c2fh44ANC1wkoeni/TCi6/ek8Zgb2k0V8YI2qIDj7G5wYEU5rOoBUT1e83AfrAuRz/WJjvAbaHInC+aTj8XPE/DuAWZr0FQi0wy7AOsfadysBGlRvzsrZE3TatpYYJr4D7h6Eqqg0+TvCYK6kksWMg2NYgX1UvPvdoNhuG13j3tB1p0rFuuRuGK3PAZUX9OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hU4VNF4i64dcWIjbskH/7dKCNMusUMdjoXsxHTO1WYk=;
 b=yPhL1El/u0twy6H0Aii/i8zBcTNAXDxFWFTbAjmTXAwMffT0svZ+7OotcJpFZOTNVCMRc8jD2MkqnVOgiaNISxo2gFCB1j8T3qGJFgQIrKLZuU3KWaYO73WtgJzMhcI7APt5jVvwjDjr1xqrzho+KYkf4OyL9nz1apVUK5lwuBSepP0h48dGduJUxVubRwEzBkvfSyzEGXmXO4CajCs6K8ecpNH21YvmUZnZK7Jsx+kr2grxxUjFUO8oVQ/Ywegkrh/rGg5BVxhI2lbxs+AQzueSa9R16vIA2xKC2QQd2fvAN75vp6Zrm08d+uUJsKf2aMehQfTf7Nksd7qd6qKadw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hU4VNF4i64dcWIjbskH/7dKCNMusUMdjoXsxHTO1WYk=;
 b=R8KvrWStXxDZVBF2KFBXUwRsH/TO+5z6VIx07wLjyBLsCaXkwHYsKRZtRO+WytxAa4W8zmWfGXPSy8WGGCWsMOE8I2bd9VnCbo972Zn69+4EhAcqCCMblHK3kTafkh0XJen57J8nxOrbC/Bhpr0BC9s2uCfycmLboHsCkgb2lfM=
Received: from CY5PR03CA0008.namprd03.prod.outlook.com (2603:10b6:930:8::13)
 by DM6PR12MB4265.namprd12.prod.outlook.com (2603:10b6:5:211::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.21; Thu, 30 Apr
 2026 16:13:03 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:930:8:cafe::fb) by CY5PR03CA0008.outlook.office365.com
 (2603:10b6:930:8::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.28 via Frontend Transport; Thu,
 30 Apr 2026 16:13:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.22 via Frontend Transport; Thu, 30 Apr 2026 16:13:03 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 30 Apr
 2026 11:13:00 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 30 Apr
 2026 11:13:00 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 30 Apr 2026 11:12:54 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.zhang <Jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v4 10/10] drm/amdgpu/userq_fence: NOTIFY MES on SDMA UMQ submit
Date: Fri, 1 May 2026 00:03:38 +0800
Message-ID: <20260430161146.2851078-10-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260430161146.2851078-1-Jesse.Zhang@amd.com>
References: <20260430161146.2851078-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|DM6PR12MB4265:EE_
X-MS-Office365-Filtering-Correlation-Id: 9708de8e-d0b2-48c8-1f7d-08dea6d35b41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: bvCptymzDjjtIlSajC2eypHySp0z+qEWfRC4ggapFaEPZ4ARND+AncJG0LiGpC2KCaO6e4srRCVOzGE5ciMKNv4rsz7QiRjtaM79Ej01L9VA+ryKYyWdCXJj1SduEt72ho8x/FL8LxvBe6ZY1aQdSVulFBUt3bmUZuXuOmXQqyHtBQrdCYiWqWdny8W4QlKHWkKz1/ufU8peQ4RLHUs4/2Rb3YhQ0XRFwd0Y8voo/AgLiaIf9pOSXcQbXjF18BkyIVi0clR1UBNk8vxuUIvzPTst77ZOcy/x+q320DNyI+f5WZZeNqYSB4Oz+2Y7941KVuyxFROA4zaR/cgxA568Q12VpdvbwnXZUxS5Atqm3S+eia/OPzO4Xa+6tfVNjC/D+UmIpM0Pdq+ON+MLM2ZPLpI4TD82sz28wXpzpKvzPQYp5Ck5LZP2eRE/u9iqogzbkfx9KRnpkAdqRCeWvyt2ENi0Lui4svMQsOhHOOSFlhX5XBIucrvyQDDjJi15kdX9w6mfk+rq4HjdrUWlySLpUhcWdXbm5TMm+yaR2UFfs+KRobv90xZuMNXPhTjJY62JSI98y9xiZ0R7jBRypbT12u7OpRaRVqf4WfnFanhrRHA+JGu2k/2UvtSFhk1ck+nCBWgTT7pqEKSdjzGMNur/JRMye08MIiuhPhPJ9ZZ/2xkjXh/L8nlPlPVOn8NjY7v14Gg/trEjsR68WmWhU2uBuxNi/UexyaKUuSuU9CT6jpXA8tvRGX3stwlU4fl1+um6RU6hC85ql4+1Xt00gAO+pQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: O+2aiwl/hdyjYy1ej/tak5bij7ilsBcLIo4Emzay27W69p9UzL2jI9la0S9+skcEspeEq6qgel5s20PJuEcukEKS/iPrcZOl3fpa663CELUi+95kymU0L1c0r2j/1aSuiWO1soB8/xow2Gox2WR3TPjzG1D1eV/GpO+LTeU5quTd+l86BPHfWV+/ndwtg139/ArzDC+yIRtncBt+sDpKvgM9b03vbGUPkeuUJlU7SGzFuIiYVdCHlvDz/szXFFvLeeph4Eg3xY+utMwx5RRNci3DmatQK/xn2GvHQp5vTicyOHomPmsJOT/oH6EWA9mEJnfSe4FNzhKXvvZ0AvSowNagNY6PEf87QuEtvR7S0YSmKwQwcE5JivKzKCerqUAZNL5QFffqoK2mvWGEmxswyo5milQ84DtYuJVLCeoQ2eb9fPyGYBT2Alvs34cgNwim
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 16:13:03.1998 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9708de8e-d0b2-48c8-1f7d-08dea6d35b41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4265
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

From: "Jesse.zhang" <Jesse.zhang@amd.com>

Pair the userspace aggregated-doorbell ring (added by the
AMDGPU_INFO_DOORBELL / AMDGPU_GEM_GLOBAL_AGGREGATED_DOORBELL ABI in
the previous patches) with a kernel-side
MES_MISC_OP_NOTIFY_WORK_ON_UNMAPPED_QUEUE in amdgpu_userq_signal_ioctl
for SDMA UMQs.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index a58342c2ac44..50e275b51c9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -598,6 +598,35 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	/* drop the reference acquired in fence creation function */
 	dma_fence_put(fence);
 
+	/*
+	 * SDMA UMQ wake: SDMA has no CP_UNMAPPED_DOORBELL HW intercept, so
+	 * once MES gangs the queue out (after the first IB's PROTECTED_FENCE
+	 * idles the queue), per-queue doorbell rings hit a mapped-out HW
+	 * slot and are silently dropped — FENCE IRQ never fires.
+	 *
+	 * Userspace rings the priority's MES aggregated doorbell directly
+	 * via the agdb_bo mmap (see AMDGPU_INFO_DOORBELL +
+	 * AMDGPU_GEM_GLOBAL_AGGREGATED_DOORBELL).  That alone, however, is
+	 * not enough on current MES12 firmware — MES will not scan the
+	 * priority's queue list unless its hasReadyQueues flag is set.
+	 * NOTIFY_WORK_ON_UNMAPPED_QUEUE flips that flag, so MES then
+	 * processes the doorbell ring and re-MAP_QUEUEs the SDMA UMQ.
+	 *
+	 * This is a kernel-side companion to the userspace agg doorbell
+	 * ring; remove once firmware learns to wake on bare aggregated
+	 * doorbell.
+	 */
+	if (queue && queue->queue_type == AMDGPU_HW_IP_DMA &&
+	    adev->enable_mes && adev->mes.funcs->misc_op) {
+		struct mes_misc_op_input op = { 0 };
+
+		op.op = MES_MISC_OP_NOTIFY_WORK_ON_UNMAPPED_QUEUE;
+		op.notify_work.priority_level = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
+		amdgpu_mes_lock(&adev->mes);
+		(void)adev->mes.funcs->misc_op(&adev->mes, &op);
+		amdgpu_mes_unlock(&adev->mes);
+	}
+
 exec_fini:
 	drm_exec_fini(&exec);
 put_gobj_write:
-- 
2.49.0

