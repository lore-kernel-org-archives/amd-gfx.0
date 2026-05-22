Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD65CD5BB4
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2026 00:22:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1386D10F486;
	Fri, 22 May 2026 00:22:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H7B0l3XT";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010040.outbound.protection.outlook.com
 [40.93.198.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC56F10F483
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 00:22:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tzkqp9N2J6qTVIgC5mp7+Gonv3ToLLqrRlOt4IM3Y1Ck7FYzXSSkYW4Qr8P4aZXehIWbkWoawJGFQ2uUkSJGjaclT1ZRsm9Nuhsryn/+4Gm5HJp7glx8ux/crROotMtxHW6eOQP6WNWGQ/IhnKmEsOEyBVhnbTk0IWCDiXD2VZo9LJH1AkkQEmrscYOAfrfTmea4MLGD5DulTj+F15ssU8kJUt/1eN9cJ+4RYqREL+OFaUkE1BBXhfjzm8SIHc2K8uuBWRH8ZjFdbg0yAP3+1VpCU8YHNO5xAvrW2InYIRX/s2IAkLseVi3UmMJKMNAUfYMm7Sa2ZjJs9ipY2s/a7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zdw9Q528FlSvbD/fOkDygULgA3BQxSeMfAArJWoBRI=;
 b=UQEL4NUR8bKmaLONYRESQy9x3K3uR9keCPklMg+n5G6MGi0luBCjFEFqaW2p2Xi0z2X3TWn6nUuamiKY0tBOq1qtjEyj2SRI5Z2h+FsNpWPtWY0AHI8qu/lntWXwu7STAM9uGV8icjllANpaSLOqaQmyDQm3F1mIYTm7DqBrJ0kPGInc/+rrkrSzGKBs1ydlQuWbEgw3gqrzNBN9G3GrxZJiMpiXBt/ZrIS3/HMSgDK0nXPCRPpgjRpHdHN8961pz5HxsVAH0MMxJXiDTQCCd7o5eRAE2ZVAjgGNvl4c5/u3IKtKpswOUHgsJSn2cFP3bjaG7LieP3xglIViSuOa1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zdw9Q528FlSvbD/fOkDygULgA3BQxSeMfAArJWoBRI=;
 b=H7B0l3XTgqh17hFaVsZijfEwTbsrux1qmNucKqmTUW2+3J+oNAnNkzwxtxK+rm+yc4U0DEMciFwK8ga5Is5V9zEvtgLlsdTQv7+ZO6JehnjP2SP6ZV+6zp3rczGVEuXNuXXy9E5JxQfBrNf/T+DWm2CIGdGU/EaN/GqzHRqi8o4=
Received: from CH2PR15CA0018.namprd15.prod.outlook.com (2603:10b6:610:51::28)
 by LV8PR12MB9451.namprd12.prod.outlook.com (2603:10b6:408:206::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Fri, 22 May
 2026 00:22:17 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::4f) by CH2PR15CA0018.outlook.office365.com
 (2603:10b6:610:51::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Fri, 22
 May 2026 00:22:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 00:22:17 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Thu, 21 May
 2026 19:22:12 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 May
 2026 19:22:12 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 21 May 2026 19:22:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sunil.khatri@amd.com>, <Amber.Lin@amd.com>, <Jesse.Zhang@amd.com>,
 <Shaoyun.Liu@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 36/42] drm/amdgpu/userq: add MES userq reset helper
Date: Thu, 21 May 2026 20:20:42 -0400
Message-ID: <20260522002048.98506-37-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522002048.98506-1-alexander.deucher@amd.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|LV8PR12MB9451:EE_
X-MS-Office365-Filtering-Correlation-Id: b4cd4125-cd5c-4bda-e4ef-08deb7982e37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|11063799006|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9yOeMlqNODkJEQMLKo+Y3MLvHjKKCRbz0G2ZjdeJ6LmFPdV0ULyv8rcsvnCXq4M0626HW4i7dBqIIm5ZoMvzPJ+dlG5qhctUEHEDzpzF+SWXCGSiBiSXnUzSzJQ4Kcp0s+noWSx6n8h4CINF8xQF9Gq5vDheJrUVA6uMZ8LoMLMWtklk+aiIWU5KOU9GUb5IQo+g6STPP8SInND2mtfOiKmrFqOnlQTG8GvBR1MzQW4pAR80SZ/HPU4CRlt4aTdP7iVoVMmIhIy4Ihn4N4XYQVr+plvy6pTjulZJakukg1ac+sUFTGbDdLOHXxzxOg34/AIZnAO78FAHFzrN4tuvEjvCG06JX7xa07u7l0yO5PHn9hlVD7L/OGNLUjMbx0XHSsriGcqpplqAHmlD58wpDXMbAmzieFdooyj7fgoMJvGG3MxVCdfDCj877l1QXEiUMIx2NgSMP1qixMJBVqfMlh4nSrwLnxW3QaAj+vcmYYi8s4cYZYNjV3XeLhHkoUctPVNntm20o/Z+FzRseKUzl69EmXT8MWeplbVgJKU8czv1/Ev40NWdF2zOo7LJWGaP7LlOQ0m6lV8uhuhMlLX+zrUOLjDpddTQckUx9hnRTeMcKDkdIIwYmcIKnrU+M1T5PClOrYaW8jry/I7qyajg1b/p+gIqxEk7wA1nSnf+KD5J1TvPgRDGF345r7mhzJqTufECH63q6Ei3XsqoTQXC+W5m/67KBqPCqnRG1v7kV0U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(11063799006)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9RlrgiiBorl9EnFwmuVjoyZW9EYB6nHGgTY6ADZqh4FpAPllV7RpR6Qfge/kJXiZbLG79RXsy8gf0kbYsb67YalCnbyRvOJFFB/qsUq8Mul/NZHnEjvKL0c64u6ajO1Tlg0ne+h9KnX9jmKi5Yj5FQjIBlpSisyT2IV2vy1Huf+Viwp76vnxTzUpr5IHHsXgvKGAh2PNQCATjAzqYJCiRGr4kp6owfbjnEb8pOjr0XmFevVlC4E2Rr/mRqNymVevuRaBElbiATjUCKzfD+I3nwhrKak3/BSE4QLGjvpWicMzSdRrhvw3GDPVyFs3IjfvrS6MoyHFpb+r2iEDUs2ZAoJDwxCLyZuxsJK3DI3xkS7cr50Oum8DQt+5jXTL9l835sYSZDWXf0Ml+RSyAGaF23819VNtnX6ZrRe1uF+Nf/F5qbJWz8+5RenlJGwe6dYI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 00:22:17.1280 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4cd4125-cd5c-4bda-e4ef-08deb7982e37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9451
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

Will be used by the common compute queue reset handler.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 39 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.h |  9 +++++
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index cf7e2ab66d109..5e6a146109fc2 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -177,7 +177,7 @@ static int mes_userq_unmap(struct amdgpu_usermode_queue *queue)
 	return r;
 }
 
-static int mes_userq_reset(struct amdgpu_usermode_queue *queue)
+int mes_userq_reset(struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
 	struct amdgpu_device *adev = uq_mgr->adev;
@@ -197,6 +197,43 @@ static int mes_userq_reset(struct amdgpu_usermode_queue *queue)
 	return mes_userq_unmap(queue);
 }
 
+int mes_userq_reset_queue(struct amdgpu_device *adev,
+			  struct amdgpu_usermode_queue *guilty_uq,
+			  int queue_type,
+			  unsigned int pipe,
+			  unsigned int queue,
+			  unsigned int db)
+{
+	struct amdgpu_usermode_queue *uq;
+	bool use_mmio = false;
+	unsigned long uq_id;
+	int r;
+
+	xa_for_each(&adev->userq_doorbell_xa, uq_id, uq) {
+		if (uq->queue_type == queue_type) {
+			if (uq == guilty_uq)
+				continue;
+			if (uq->doorbell_index == db) {
+				uq->state = AMDGPU_USERQ_STATE_HUNG;
+				if (use_mmio)
+					r = amdgpu_mes_reset_queue_mmio(adev, queue_type, 0, 1, pipe, queue, 0);
+				else
+					r = amdgpu_mes_reset_user_queue(adev, queue_type, db, 0);
+				if (r)
+					return r;
+				r = mes_userq_unmap(uq);
+				if (r)
+					return r;
+				atomic_inc(&adev->gpu_reset_counter);
+				amdgpu_userq_fence_driver_force_completion(uq);
+				drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, NULL);
+				break;
+			}
+		}
+	}
+	return 0;
+}
+
 static int mes_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
 				      struct amdgpu_usermode_queue *queue,
 				      struct drm_amdgpu_userq_in *mqd_user)
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.h b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.h
index 090ae88977705..a473360d6a8b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.h
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.h
@@ -27,4 +27,13 @@
 #include "amdgpu_userq.h"
 
 extern const struct amdgpu_userq_funcs userq_mes_funcs;
+
+int mes_userq_reset(struct amdgpu_usermode_queue *queue);
+int mes_userq_reset_queue(struct amdgpu_device *adev,
+			  struct amdgpu_usermode_queue *guilty_uq,
+			  int queue_type,
+			  unsigned int pipe,
+			  unsigned int queue,
+			  unsigned int db);
+
 #endif
-- 
2.54.0

