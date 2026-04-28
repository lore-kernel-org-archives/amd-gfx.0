Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63571FF8868
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 10:03:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 013D410EAF7;
	Tue, 28 Apr 2026 10:03:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AMVR1f1k";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012065.outbound.protection.outlook.com [52.101.43.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8D7810EAF7
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 10:03:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b9zHVFXimJtdpyGz5tWc55akS2gzU8guXLncghXEAZiSLbfpN7ueHvJ+Ijz2WRqorldfGFv5WTxizUQ9djVTRBo7XcBQF0hpGoQ0M3k8N7G7VujtbyW+9Rp7exA38BXMx1UZCEXBDQyn1N1ysG4dhs2LtkjdVBuTch8iPs13RYNufDRtrec3qh1N7LPHZ+3nm4zrH0V7wOYUF5GuNnIzGaDVJS+FzpGUIXWhv8RH4In1xOO62jql4Mv9mZhjblbX7eScKe1um1nQqR+XVsYUv34MNjvC5Zq+B6KIynam8FTeyQ6UK9xj1PjvdneoHf46P/yDafHM5IOfzbDWb68RfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESlLt5eC4/oj1gVbtDBKHxKWRzjq8JcKOmVRpa3QCWg=;
 b=WHeJYHgcdOhzDqOejNbmARDkVYVm/5d4RWgZIdIIjLNgYp7Za5t3TFvtKBycJKMtpVmfaR7B0yx9TzvJPI51UY4tBVGjXtqqNVav/kxHz0658OhndGGz/mtXGC5vuecWvVP8nyXOrPTvwQFs+JN0PclP11ErawfMHjpyyPL0AR+KJ2AqkoGGEp2CGZgnqbPHDKcjoYFZu5rkx2/1INz2xabi+5aSoOVVbkPA/fI8p+joRs6faZTsM6GToBMBNFYfnlaRN1qMG7iTt6ONtPAxQjvQJD5kSke+CclUEsfN/iKrrFC5j4vlLL3XgQFtIN86vOlS8lz3ie72R5pcJhMkpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESlLt5eC4/oj1gVbtDBKHxKWRzjq8JcKOmVRpa3QCWg=;
 b=AMVR1f1kBJOS+YUZ0ndOg2kMukp3ZDX3Ll/uZQwqhwo1K0DR9ndAGd7xLz98JTvNxGdpmcd+oYU9Ga6qwklj0OX8Wv/FeR8Fa5nlGo1gDhz5Xc9tgV7O2cNik8w4eTwciPnm80sy+suCDdumhOrN9lHm5oqNkxitqmKhr8kGm04=
Received: from CH0PR03CA0430.namprd03.prod.outlook.com (2603:10b6:610:10e::15)
 by IA1PR12MB6481.namprd12.prod.outlook.com (2603:10b6:208:3aa::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Tue, 28 Apr
 2026 10:03:48 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::47) by CH0PR03CA0430.outlook.office365.com
 (2603:10b6:610:10e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.28 via Frontend Transport; Tue,
 28 Apr 2026 10:03:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 10:03:45 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 05:03:43 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 03:03:42 -0700
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 28 Apr 2026 05:03:36 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.zhang <Jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v3 10/11] drm/amdgpu/userq_fence: wake gangs-out SDMA UMQs via
 NOTIFY
Date: Tue, 28 Apr 2026 17:58:51 +0800
Message-ID: <20260428100239.1609179-10-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260428100239.1609179-1-Jesse.Zhang@amd.com>
References: <20260428100239.1609179-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|IA1PR12MB6481:EE_
X-MS-Office365-Filtering-Correlation-Id: fdfe66de-8687-4c4a-2492-08dea50d6f2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: GRfNDrzsyaeuomQ1npMM48W3pUqOXE8HBi/d8TDRgAI1iR6Fs5TPtRBjT4QdY3MMjMfhjgS0QTuhap9P+z+z6KhuE2ZhZ6QlL98N9vq6adR1XgD2BOJx0kxrgqzHMBENMViv2fx4Ogjv8/kjfUERhcr1iAfbu66Oz28ZGAnOgM/uRaZAEXSvOzklbFT93y+MogYCXe8/Xrgs9ujGutHnISXloJMRg0H7PLjfA3BMJa/monookorcYj2X4yV/+GzT9L7Wbw0LIPGRPq/WqOMu6Twgt+kEzmX1YJCm9XV6rP3Hw1y5eF1R0OQhJArwv2MRy4vPtIq1iapJtfaA9m6OXxH47086h4HkGX2DNSlSsFnVgXhySH8WvnU7MvyPibU5frDQBgAo6qQE050Is6Z+QGE/pIF+/c+Zzt4TvCxB0TtaxrVxV6fzSAV6nHSB0dSGPZpzkuFkabLP1m8cy6nOojq0t9X38ent8JNf39PSjP5A7SRyU6xhYd9cOlKDcCykKqCAdYfy7NaKDN+IwB2i9Jqf3Gro48mVrsHKcXetKOm78DHSxXmjKH3Ey4bnlP7so+j5t07c+EkPZvILIL7FxyNtYufop59EfEGiFWTuMUd5cEjWG40bg3CHU9TKCPQPmr92Jl32HeBrVch3s5HG1zibOVUMri+/8PFpmIx6zADqjbh4nEi9CQg9WuoOFoqVhIKRqsCyj+h+T1oQKu3zlW3kEon+wug5iF3gYP8wI7pDR8HlCEVxehhOv5BrTAmjT0mODSAJiGsqIKj4Jxkjkg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MiMf2wRCE7ikElZUdl7noL0voS4Y8N2buQ38QDRwzOqzO+uMVpMI9l2lApco5st2Wj+yeI4zcY0F4SQBKDGXWLY4UuSU+PFHNjQbvEFUeknKL5eRU0XJwqWS08fGPh6D01G97KdHNwahKawtPBGRofnPAM4TVsw2jNvfERVuh62dUxH30mNy1IkoARP3Su3jEofzx3izh3peG6FEaUrWQYeYvjlWJCZj5mPnYoQSf0hg3IbLyV6QffCw+LdBj9lELHO3XZ/TzkzH62UujxoluynMR018av0SkmCzBg+SjhI1uoQM0zpo94vS3SDQAln6LYBVhiCF7VJn8vRj17ZyEUVjkqE/Ia2J4wFdK6KO8o1YEM6u3iIN+SO/N7sYF8IG68eKt3aGLxhD37xEnT4QAUDgnRLmRUVzuQhwFEofy0JyTKZsXhzjK2FvqA40hscN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 10:03:45.1074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdfe66de-8687-4c4a-2492-08dea50d6f2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6481
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

SDMA has no CP_UNMAPPED_DOORBELL HW intercept, so once MES gangs the
queue out (after the first IB idles it) per-queue doorbell rings from
userspace hit a mapped-out HW slot and are silently dropped: rptr
stops advancing and FENCE IRQ never fires.

After the SDMA UMQ's first IB has actually completed
(fence_drv->cpu_addr != 0), issue
MES_MISC_OP_NOTIFY_WORK_ON_UNMAPPED_QUEUE and ring the priority's
aggregated doorbell so MES re-evaluates scheduling and re-maps the
queue for the next IB.  The first submission is intentionally skipped
— the queue is still mapped from MAP_QUEUE then, and an extra notify
would race the initial scheduling.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index a58342c2ac44..6ef4cbd5d5da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -598,6 +598,39 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	/* drop the reference acquired in fence creation function */
 	dma_fence_put(fence);
 
+	/*
+	 * SDMA UMQ wake: SDMA has no CP_UNMAPPED_DOORBELL HW intercept, so
+	 * once MES gangs the queue out (after the first IB's PROTECTED_FENCE
+	 * idles the queue), subsequent per-queue doorbell rings hit a
+	 * mapped-out HW slot and are silently ignored — rptr stops
+	 * advancing, FENCE IRQ never fires.  The MES MISC API
+	 * NOTIFY_WORK_ON_UNMAPPED_QUEUE flips MES's hasReadyQueues flag for
+	 * the queue's priority level, which makes MES re-evaluate
+	 * scheduling and re-map our SDMA UMQ for the next IB.
+	 *
+	 * Skip on the very first submission (fence_drv->cpu_addr == 0
+	 * means SDMA hasn't completed any IB yet, so MES still has the
+	 * queue mapped from MAP_QUEUE — calling NOTIFY here would race the
+	 * initial scheduling and starve the first IB).
+	 */
+	if (queue && queue->queue_type == AMDGPU_HW_IP_DMA &&
+	    adev->enable_mes && adev->mes.funcs->misc_op &&
+	    queue->fence_drv && queue->fence_drv->cpu_addr &&
+	    le64_to_cpu(*queue->fence_drv->cpu_addr) != 0) {
+		struct mes_misc_op_input op = { 0 };
+		u32 agg_db = adev->mes.aggregated_doorbells[
+				AMDGPU_MES_PRIORITY_LEVEL_NORMAL];
+
+		op.op = MES_MISC_OP_NOTIFY_WORK_ON_UNMAPPED_QUEUE;
+		op.notify_work.priority_level = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
+		amdgpu_mes_lock(&adev->mes);
+		(void)adev->mes.funcs->misc_op(&adev->mes, &op);
+		amdgpu_mes_unlock(&adev->mes);
+
+		if (agg_db)
+			WDOORBELL64(agg_db, queue->doorbell_index);
+	}
+
 exec_fini:
 	drm_exec_fini(&exec);
 put_gobj_write:
-- 
2.49.0

