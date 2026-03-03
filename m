Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 132F3EDA693
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2026 16:19:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA80C10E842;
	Tue,  3 Mar 2026 16:19:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f0iAdTR1";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013048.outbound.protection.outlook.com
 [40.93.201.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA86B10E842
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2026 16:19:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+IFGzbmZSAUEJliST1Z4tlQ/34/SHdcjqXvA2abvZ0QQhtMgiPNC0+lfiTOGoSikidrX47AyUNGo6yR5E6nEqUpvVo0t2/8OncSaiLhLOn3Z+hmLvjlQgjunXyKgmOeYwq+frCgdaWpSEiKGyYZbsB6pVQyhFOf19JB48NP/WcU/W4UuRfu5eUn7joRoaBHuUIef6/p60zKuJxhcZlnWp4te2D1NFu9v7SfItTPCQju9psoNOUQf1bA84JizDZYEuC7MJMRazqIpuvtDjL/HocujWV1FkRhEf3+DTyy8LH5xHBmxDfDJ2CezoVwK11gGO1oNNWn+YE5zImskGip4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXWhbR68vV/P9W4YDE6G4YKo2gzPgvt0kKjuaavAA/M=;
 b=aX1VhrZMTWSVkBLY9Qxty0v6HP35DxtK3XTwJsPEc+E4uTO3XEfZ4+E+FM6XqR8oL+uAZ4WXMlSd3niocDd3Y8P25Lm5JHURG2os8AaDR/o4O0Rb5XGE0yzVbITkIQwn/je5C4ER9eZST9hMPhATcG6oFw2gtWPjF7xJlz0CmHOD38uZI++vOoADm/N2+uYmvB5bO4ffoSun5glR6WZwjE0zKXMF4iNqpGKDcNdt09lOvN/WSQKK5iK8kGK32/FdEZ3fVW4ky4VK7ADx5VMb/QXUMotawxwpnLE0zYZ1HIq60buq15Eqc012KizMZ0DHYjF0lpxJvdy68xHz+RaFEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXWhbR68vV/P9W4YDE6G4YKo2gzPgvt0kKjuaavAA/M=;
 b=f0iAdTR1DFyxGIztu1PuuO23mIkG0KO4+Ohsvvk2N3alQg5EqwqK+QRjSKVNrH3CWXFAM+slWGtegh28ft/IrjLimrPt1XW9PuPUA97JebylUAfjFLmlr9EcsNqb/Sn4YKRR6Fc3B46BD3Vl9X9oozO1by166mK6znlUqqSuzQg=
Received: from PH7PR17CA0064.namprd17.prod.outlook.com (2603:10b6:510:325::21)
 by BN5PR12MB9487.namprd12.prod.outlook.com (2603:10b6:408:2aa::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Tue, 3 Mar
 2026 16:19:29 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::73) by PH7PR17CA0064.outlook.office365.com
 (2603:10b6:510:325::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Tue,
 3 Mar 2026 16:19:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 16:19:28 +0000
Received: from MKM-D1-FRANKSU9.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Mar
 2026 10:19:27 -0600
From: Chenglei Xie <Chenglei.Xie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Jeffrey.Chan@amd.com>, <Zhigang.Luo@amd.com>, <Hawking.Zhang@amd.com>,
 <Chenglei.Xie@amd.com>
Subject: [PATCH] drm/amdgpu: Fix KIQ fence timeout after GPU reset on GFX
 v9.4.3
Date: Tue, 3 Mar 2026 11:19:21 -0500
Message-ID: <20260303161921.435188-1-Chenglei.Xie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|BN5PR12MB9487:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d3c9fff-8917-4932-28e6-08de7940a4ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: yw8qDY2OBf+IjB5WvJJ9I68j5g/p8LiI86P875tZac7TcYRinmfgB55o6kX8qPMdediZlKl11hdXdsmWsg1SuyQKf2YBUbO3yHk+7Mlx6B6NuckbQaPiCllWu4pfChPD8g1MBQKdw4tbe9V96AjjCSb0UV0AIiuF1cBNnHDhyfAODwWs7oFwnSzY4e8QjvgKqieIwj2MAgbD6UMfM28fvmzu/xoeHbwaWwP2gHwGzq6pYYfIIWZL3lsUwNNbFyMbBaSYgVwXTv27F0BguxwBFAdEac8BK8vDxBYIQ+pY+dgZa1fO7v0b6MZtgwbCGBPABBybAECYWJwD7d7USFmvEQW3P8NYU/iBynZ5UpIMZgqfXTr5U+zW2oLBDoVPiqS8X3c5qb0aycMKwYBtxttZteEPSADJZUL8pBSltn/nnzKrWq25QWQWkXO1/meTLorRGQnIGMsKK0zzGN/58KNXbY0YjojryR1lp0dPFXOUEkAIiWut7eO7BO7NIb/D3/XyKku0525ZJX42e9LbUSeFoEKsewVh+G0G+V9CYdqDH049pWh5ABqxcu6s5/7XKN2HLkRfpMV8PZnEHsN9ke6IACz3V2i79pspQY2f4v++Ps9O2144V9Q94T2gg73cwznIeB6cHO4R3n4ChkSCq+DdlRJJ+jOIsPUKS1DXIgjdmUH2du7wzrrws8QwY/RV5mv1bwM6M+cIe2+Rd/DH5UDMF2gli2JhvlyTSsn8N9zv0wTcWFgQJJUZ+IR7x/5PSzhwHTwrqBaPdPMJ1HTTNA5ZhIXSbZZAVcKxQiKIxPhi42uBHPahtY7XCcdS3Ky+L6dFwUBlmHeIsWqCMeBGUGr2cQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Jal5Lw1Cge0Y2b35V3wQoR0FXW18HX7QgmaOiki8fYduKpMSQZnJTJiECAl8AtZJNLpYt0W3C16CZvCYDpeM3EDTsmGtTBBmZJ4rfMJ94D3ktMkgTurOzxRlF9x6dBQTHdWCwFWpGGolZTsXs5u++ssOShgq+5vsDCauTfXrUi5WHlruJ9vX83arZOssmyGADgI7dHdxt+EPY2UQ0FIkHa+G++1K2WluuQwczBEAysBI22A7FkJMKNyhe5whmdQFQA9RpLgr67pP4sWLa7dpHqPpySJzvEk1bgVW7ivkXAweMDfQkA7IEOzOjoKJ1PKF5Lz2fvdDb8+pThJLSPNnAwarcy/d+iDKH0qkSCMT1RZvILhJ/qojnb/BXIWNEb/XhtXqhKj2/wgBfxzhRrFLM9gn7gPRxUsWxyrI52I5MlfPOhKOmhDutDa+Jm9ehq2e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 16:19:28.0518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3c9fff-8917-4932-28e6-08de7940a4ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9487
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

After GPU reset, the hardware queue is cleared and all pending fences
are lost. However, the fence writeback memory remains stale from before
reset, while software continues emitting fences and sync_seq keeps
incrementing. This causes amdgpu_fence_emit_polling() to wait for
fences that were lost during reset, resulting in -ETIMEDOUT errors.

Fix this by updating the fence writeback memory to match sync_seq after
GPU reset in gfx_v9_4_3_xcc_kiq_init_queue(). This aligns the hardware's
view of completed fences with software's view of emitted fences,
preventing timeouts when waiting for fences that no longer exist.

Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
Change-Id: I717df52ed0ef0bb51a6901f218191d9837a77f6f
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index ad4d442e7345e..6b5fcdd987693 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2135,6 +2135,15 @@ static int gfx_v9_4_3_xcc_kiq_init_queue(struct amdgpu_ring *ring, int xcc_id)
 		gfx_v9_4_3_xcc_kiq_init_register(ring, xcc_id);
 		soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
 		mutex_unlock(&adev->srbm_mutex);
+
+		/* Update fence writeback memory to align with software state after reset.
+		 * After GPU reset, the hardware queue is cleared and all pending fences
+		 * are lost. The fence writeback memory may be stale from before reset. To prevent
+		 * waiting for lost fences, update writeback memory to match sync_seq.
+		 * This avoids waiting for lost fences and prevents timeouts.
+		 */
+		 if (ring->fence_drv.cpu_addr)
+			*ring->fence_drv.cpu_addr = cpu_to_le32(ring->fence_drv.sync_seq);
 	} else {
 		memset((void *)mqd, 0, sizeof(struct v9_mqd_allocation));
 		((struct v9_mqd_allocation *)mqd)->dynamic_cu_mask = 0xFFFFFFFF;
-- 
2.34.1

