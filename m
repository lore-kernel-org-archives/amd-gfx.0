Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E9ACD6E74
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 10:32:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E79C911A70C;
	Fri,  5 Jun 2026 10:32:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T8AAMYMf";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010018.outbound.protection.outlook.com [52.101.56.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64AA911A70B
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 10:32:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=knnsToilZkmPM3waIqYYQpYRb5LtJDGUW5jkV01uyuRBFYWBEhBM4vfQ42WI6ucTgUJwNxHlkpq3G94uHYr4zsTwumUHApATSdj8Jti0zFV8zngKqhVJ01y4jncR4A6GWU8/kiEGw+Rmq/vAtPIAkio8sKlKEjEAE1DpnuWqdgseg/xMn7IfjmqSFZ94c2r5vo8VkyGuGz9MrANybSXQlao2CQUqMpYN8JBMln60XcligmQ5I5cpLyyPnqH9Ht3Y7K7MkWgFKwRCRVotbtZlBTPGHAWUIBlagZ921l5xi/LiYZQrONk4rXVnpaaUhukU0mbM7EDf1dbYWRpxWlSM1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKTompEvLrJI2af6LC9UnhFZQfpqy2URuomVALU09sE=;
 b=vdug4Ixu3ZffMZ00xD+lnUnW8O+MJAAIwKlaV8ygDzUjpkju/kbvn/yqPaC8KKz9ufY4LX25E7yWSkTZ0g9pRtgwTt69mdq+3yXv6L9IPfrCsqaFyMB8cpZxaG98RUqHuLllfy80cz6sT6d6nXg4sqGHWSUkOvjs+6OxF6RrOFsXmoBGCDW7BneGK9rHWPFX1xCkfsnBbPKgQrcRgyfYsFoQZcMaZ6yGZVEuo4fthBNMjCK7WfoYSQ5kr41fIJB09kiLC2MZaqhKLdyL9/0u2Df+MpN1bsLmsxEZ4TlF7h6n2XS0dDRTb7/iuCcjlA6L39gxJRPT0TyNDggQqc4/vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKTompEvLrJI2af6LC9UnhFZQfpqy2URuomVALU09sE=;
 b=T8AAMYMfxQ957AiZwmKwXb3nx3fs5VT7LEWvr05Wx8DxRTilPEBBmJjYWIBtq3Za4zb5kifxu3pnh/7Sq8Q+8mJzb//WeFdPABYtXmmOTf8ZGe/hjdEYPbYQpZbaT/wdnlb3kjhgX4PuEF8aeqbyoR0932ZWmJvg9Rde8uVdzXE=
Received: from SJ0PR03CA0183.namprd03.prod.outlook.com (2603:10b6:a03:2ef::8)
 by PH7PR12MB6934.namprd12.prod.outlook.com (2603:10b6:510:1b8::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 10:31:52 +0000
Received: from CO1PEPF00012E7F.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::7a) by SJ0PR03CA0183.outlook.office365.com
 (2603:10b6:a03:2ef::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.9 via Frontend Transport; Fri, 5
 Jun 2026 10:31:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E7F.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 10:31:52 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 05:31:51 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 05:31:51 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 5 Jun 2026 05:31:45 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/6] drm/amdgpu/user: add reset helpers for error interrupts
Date: Fri, 5 Jun 2026 18:30:47 +0800
Message-ID: <20260605103144.2537331-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7F:EE_|PH7PR12MB6934:EE_
X-MS-Office365-Filtering-Correlation-Id: b81e598d-2bbd-4899-0da5-08dec2eda876
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: +CcJq14MRGPDtbxIgoQeUM+5KTsTc7OoyV9rWk5CGpeIU7mMbCTM7xCS6muPtKybCFAkRMrYF9o9jK089peA8TNw/f3b6TdK3+9OImsKmaIANTeyyl1NHTV1sdanDNl0jE9OrNYmod24uQrhcfLQTDC+SUy4v3FUxnvg3ugcS7HuGG0JXNu8xquHcIU9i7II/N3+F0BcMPO/2FZZFwlSP7EBSMtxezcqCZRl1miSAUyAAsVgpeD1qatottVkSfjXwwlKLip6matJt31gITBXCgG71Ba+Ga2YlDmuE1GMpLj//CHZ3U2A43258EIcoKGUaLl7t+Tx4jJDmoJ/Rq0yHG4WYOY8iWLypTFJcAO4oXORXa4sZMeedijPJM5il7TzScozRFVRc7catAj4fx7jjoVqiZjZWwYKl742zdS09GXMPF5cq0QrC3xcDTCmnD0L1uVt7ZbLcRNdbvQtdmqhd+7SPUQCH7rHlwC9TLDGFgQ+BdqD9sEVEorw4VA2NVJLD+PE3yXZyjNCRB0rHzEHD/NVLh0Q6a4RT2Q7WXXVe3OjpuciNl53421DxHSKyv4MytQB5bokdMo1Xv9uThM7jNiSjR48ApOla8jGRgD5UqNax9BfBEt2IvfygFps6gBc0/26DGAhelH/HwN225BxI626ilGO+LfQ6qGit9ftklEbz/iDZa1l9VhOLlZEOPopWh8tZPccCo76zTy2hp7qwvUKHXTfSaKyGi9HvMNlnF0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1T4S9oyywlxNtEScCj3vD0EOrxvZJ14Ro/4kueIW78wE1V0cBxBTvhwLUWKvtKPPut7fCIVqccKSP1w9Sx9w6ur1RxiqcFZKdqtXW80mhkiC6rq0ev4vG//OqLqcUWIglMbtJ1yei4jiz3+/xKDmLktvAYgxz0UjgBPwbF0wmR5ysfHhJMbqOi7ccRDH75vwivR+oO6cqeqB8C4qt5+bD75ssweTNQYXwZWXzgJKydA7QQ6a1j7+b5JrmZQX2Ugr3D/jEdrtdwmD6IkDUXaqg/O0WA+nNiL11Y6P+/FpTsnCMzfg0T9cTYNTVesrPJRYN5owyVeTGpkg3b99mgp7F41alEtIeYLiNUSOnA1NaoLwfJWz1AITlMi2g7Y/Ey9FT9qaNRnTyFO+hzAeZaDSTArMOvzfit2PxhRY7XIrcQzZSzYXSPFBMIDpxrQ60GuU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 10:31:52.1799 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b81e598d-2bbd-4899-0da5-08dec2eda876
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E7F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6934
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

From: Alex Deucher <alexander.deucher@amd.com>

If we get an interrupt for a bad user queue (bad opcode, etc.),
add a helper to handle the reset for user queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 13 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index de6848b4fd67..99c5adf3cb24 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1111,6 +1111,19 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
 	dma_fence_put(ev_fence);
 }
 
+void amdgpu_userq_process_reset_irq(struct amdgpu_device *adev, u32 doorbell)
+{
+	struct xarray *xa = &adev->userq_doorbell_xa;
+	struct amdgpu_usermode_queue *queue;
+	unsigned long flags;
+
+	xa_lock_irqsave(xa, flags);
+	queue = xa_load(xa, doorbell);
+	if (queue)
+		amdgpu_userq_start_hang_detect_work(queue);
+	xa_unlock_irqrestore(xa, flags);
+}
+
 static int
 amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 9df1b78407f5..5a2ae33135da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -175,6 +175,7 @@ void amdgpu_userq_pre_reset(struct amdgpu_device *adev);
 int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost);
 void amdgpu_userq_start_hang_detect_work(struct amdgpu_usermode_queue *queue);
 void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell);
+void amdgpu_userq_process_reset_irq(struct amdgpu_device *adev, u32 doorbell);
 
 int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
 				   struct amdgpu_usermode_queue *queue,
-- 
2.49.0

