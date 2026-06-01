Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D71CD6E4C
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 05:50:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF480112DB6;
	Mon,  1 Jun 2026 05:50:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R1gq+r9D";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010044.outbound.protection.outlook.com [52.101.201.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A036112DB6
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 05:50:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mVjT9zKK440acR2DeVqPhVzbZE5vnvf909BvstSSKLqfrZBhMgBk3wYA00I2BJzJBbwQvcvLlEf6pAxLuPlY8MTBQO/yUsm071iOh3XvC2uhw9EDoUmejT7kzbJe6UIL/xnZU9MahftocmVqSn3k4S5qndqoQ3e8UFORl0+sCrdzmG67HHPBjg8vrMCK0t5q/cRKjJ0NV17zYelq/+O5/flKwr7dE79DqAswGJ67jGAZ7B3IjShFAFnz1J0WiXATnKxtu1C+oMlZQUnnEbdNZhP2fgC6OuBBk13E4j0vlUPDn+3kxBK1Y9kM4jzsitRKL2O+lMtk/JLyaFdSegNo9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkG3AieA3ONgEmQV5VWfW4IzKB0XH4zyc4YtnjLDjLI=;
 b=KtWJqlx3Q9xtTvVXMznPDxypW6te7SK8aAnu3gu6RgZGNe4n0XveU+q2+fikQmcIQs2exUnZ5xVQZXrfa4mWjN0XgV+iccASmm0VR4i4JaUkKAR6zGavfMeFFupyCEWY3F2cSsZAJX/+jt2wF0Vg5uMmAGWI+H86QjWNmEXfsHsgq+VLvm/+Grrbom2NM5qI+c3z4y4pHG73MKESMY8VLc3LBOtmzxPmF5FnJsIgFAwURr5rVgEzg2igiCaJr8sEr9ZhdC1RLv+Jo6zuMp1UWyw2BJ6phKpuoSQs3iib59gU/wrRpNLipDOE3hp2r+ZQaDFC5Y0Vb99iE+ATFhZBPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkG3AieA3ONgEmQV5VWfW4IzKB0XH4zyc4YtnjLDjLI=;
 b=R1gq+r9DpQ0RlKE4l9lxUYRS9RNreM/A1dx5niwuLmAwI3kxo0YQmcHBf0fd/0oIYz3OKFhRFgP6Idh1naMJQWhLlRybxapa638MRCxzTAu2QI7QeYKYEpa8AgHpDjQMEgWnvqJsVFoF1TfwhvfQLYZCsvD22c0JgreFqUrns/o=
Received: from CH2PR15CA0017.namprd15.prod.outlook.com (2603:10b6:610:51::27)
 by MW4PR12MB5627.namprd12.prod.outlook.com (2603:10b6:303:16a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 05:50:49 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::a) by CH2PR15CA0017.outlook.office365.com
 (2603:10b6:610:51::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.15 via Frontend Transport; Mon, 1
 Jun 2026 05:50:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 05:50:48 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:50:47 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 00:50:41 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 02/42] drm/amdgpu: don't reemit if there is nothing to
 reemit
Date: Mon, 1 Jun 2026 13:48:48 +0800
Message-ID: <20260601055034.3700921-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
References: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|MW4PR12MB5627:EE_
X-MS-Office365-Filtering-Correlation-Id: 41a1915c-b369-49a7-27be-08debfa1bb26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|11063799006|6133799003|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: PLscqt2LZsQ4HHczZA1K1x/cDCg9JEM+GCMbxVvkBxGBUztM8I0uPvKKvr4HGzcUYGA7SFqo3yrXiwn9EgYkTi729r0LswuRt/DHhrSXxSuj3Hx6PNsK6guVLRnNcdmErycZCpCMoTc2r7vmcMoM76wikuF0ZRq1kq9Z5UX9Hb2/0Q7GUPMwd4qYtP+2DZ49+m5CpaQ6iL1MJa5/zzHalePQlV/J2KNVoatMe3TrSuMcnqaa7csuwVcjTvgT90uXcAROn/TjVqNXTIWZuZuKkkMsEcznIir/cpsy9TOiyWePYEdLOeKUedgpF5MbS2AHqWuXEdK4yBus1kER+4jQBONhev4eF7kEGtrQ4FsmGovGCG33zNaeQOePmY7ef0S23ep4yipsFI35Vt/j/pUzlOdw6rf9yBoQnxymnPu6HAuXB/IG1CwfPwiWG5dTxaKTaFbl37Pusw8vgI9z14vmbspZgdT2GBR/Z0CnaP2wG+KwVvbf4DRnl5mGyPL5JRPlghFhSZ6Ch2sQsefBiUr+7t+rYHuxJo5R9T9xkCaMFC9iD/i5K5HA+BNDB6f6jMBGnnlTFWs1tOf3822DgjcYIClYGQmoL5nakH10YIvAeVgmrd+/S4saZoNpXGUtg6wpVJvB/bsYbeqP1ZbQcllIBL/g/M2BmuhNyYdU65osMEJdfzMfNDRcyoa9YwFpFgcmH/J/s/RL3POzFr56lpxRzOpSzgxx9YcVTeyCY3Mf4qQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(11063799006)(6133799003)(5023799004)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bRZsWO4bbGECbUnZt1QSNBdl8o9x/OsM32XfOkTwAodu3pxT6d3IkglKNZGE/Cr8HK3rmL9IdSmDfYoB6KxQwgNkzBMQ46YzZXqfss9uFaxy/sGsvIZnJxic9VVs/lfJDkl9TSe+X7KT5RVTYAwUZOuFODWiMu1CQb8+8wwreWyNum2xfBE3dDbDiFiMgxe86q2Mjo0MtzhZ0gMRnjjj4xKmHjVeDsa1A6KCbLm7oGGwFsqExGgLekQQ0kQNrYdPHmEVuzo7AFyBrhsyyUpjTyF3aA1GWVEidEA8F2/K2pToQHdOJTdL1rpAlgCyNzg3ZQiey4xzGrCKfUgjobON3On11i8jObSKO9YXF4ffCLQ2w1Xtbb/zRrnVVpDBfRemBl2zQAT2dcYOXiEoAAKnvrmS/H5KPgao+xkXQIgiqLCLE+/AXmeXyYZy/vihQuN8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 05:50:48.3098 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a1915c-b369-49a7-27be-08debfa1bb26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5627
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

Return early in amdgpu_ring_set_fence_errors_and_reemit()
if ring_backup_entries_to_copy is 0.  That means that either
the ring is idle and there is nothing to reemit, or there
some reason why we should reemit, so return early and
signal the fences (if applicable).

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index ea69b1bac7c6..6a43c8494fa8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -727,6 +727,15 @@ void amdgpu_ring_set_fence_errors_and_reemit(struct amdgpu_ring *ring,
 	last_seq = amdgpu_fence_read(ring) & ring->fence_drv.num_fences_mask;
 	seq = ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
 
+	/* If there is nothing to reemit, return early and set an error on the fence
+	 * if applicable. If all of the fences are siganlled, this will be a nop.
+	 * if there are still fences and ring_backup_entries_to_copy is 0, then
+	 * we are skipping it on purpose.
+	 */
+	if (!ring->ring_backup_entries_to_copy) {
+		amdgpu_fence_driver_force_completion(ring, &guilty_fence->base);
+		return;
+	}
 	ring->reemit = true;
 	amdgpu_ring_alloc(ring, ring->ring_backup_entries_to_copy);
 	spin_lock_irqsave(&ring->fence_drv.lock, flags);
-- 
2.49.0

