Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B956C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 20:13:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7180E10F853;
	Fri, 12 Apr 2024 20:13:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sIwzwffK";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2052.outbound.protection.outlook.com [40.107.101.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9DF410F84F
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 20:13:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NwqzwrLQEGOzriKxx6gIOCgXT1Zw9FiH+5tgvCOY2IwrbuOYNtCPatlv4cp5Xrr/sBxG3/vNu3fk1+83FjGAhWOztbrL+3YRBrt8WbpkOCD75s3Px4W0pWoa3HhpRuPmrhGBEzJU8icWndb26PKi3Fdn6MmRbP1mVw5G4O9IVaXWMsQAXzC3RD+BqWl6WTzTlFVnOpTD0K06gUlK9MJBCvHPSURAYDVztVRo5o+jK6RX3V9+71l7oF/5vHxMaXnJLW84nsPw0wD8yZaSMwG1hyl7SwX6zmIIHy8IaCfd2vZwc4p7LoFGz+xoGUJCYhezK9nVRdDE5oqDIZkwmY9OCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12brV5sxRqL7W4lmjvJab0oqA9fm6y7lJaPZQEeFOG8=;
 b=OVQq6LogRjj7gw33jprhsL/Bw+eVp0GqrbjfKzavJIo6wMh7AN+yNsGjfEuH6stxvYsqlL1bhiE6xblAkeiA/OGOlltD5Y5DrSfVOy6wovDO1p4xYRKXzlS9fSnsAhdyew5qsi1jfgJvaUAEsVKBMT2B2p/y6y7BYsDZlR83Fx+N8JgUulm34ovNTbNtvOEZwKkWp2YVOxv30+GkJzsGfcGtiitQqGIYojxqMFdQSjcckFq9vAIV0+FAsw9sweWFApZ4OJq4SfvPdzGfXWQA/hAdTh+kCxTNn6kx6mWDxgusnMNrlzIM4Yixis+zuIIMOguzXR5Na1vF5LbDdakHCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12brV5sxRqL7W4lmjvJab0oqA9fm6y7lJaPZQEeFOG8=;
 b=sIwzwffKPZc96S1VfhjoF5LnsgsxUyT0hfIDv7lkrskqu5/8ch8jLbEF5D5EJReOKwjBbxgvNc60qb1wzalXVVo0KIetQjUPMGOK+MgP12oOvJf3YQbfE1VMhjoC1+NXK6KcmsPpV3yA2Pm12m3kI5AJQDndYn7Tj2qPhwU2Gas=
Received: from BY5PR04CA0005.namprd04.prod.outlook.com (2603:10b6:a03:1d0::15)
 by SN7PR12MB6959.namprd12.prod.outlook.com (2603:10b6:806:261::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 20:13:41 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::97) by BY5PR04CA0005.outlook.office365.com
 (2603:10b6:a03:1d0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.27 via Frontend
 Transport; Fri, 12 Apr 2024 20:13:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 20:13:41 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 12 Apr
 2024 15:13:39 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Arunpravin.PaneerSelvam@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH 2/6] drm/amdgpu: Evict BOs from same process for contiguous
 allocation
Date: Fri, 12 Apr 2024 16:12:57 -0400
Message-ID: <20240412201301.14154-3-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240412201301.14154-1-Philip.Yang@amd.com>
References: <20240412201301.14154-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|SN7PR12MB6959:EE_
X-MS-Office365-Filtering-Correlation-Id: c515af96-c143-4272-a49c-08dc5b2d0bf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OJ6nSygYUCYyusN9MvbxxezDnk/Dt0lr+myi+AiptH66Qj6nA29Fn4RAmlfNbiyswa2ZPWPB34Vo0cSvKud9wwYLecNgQni0OWE+raZNr+H1XGZuG92Z34rYSp7QY5DlxvDGlb1ljnxgzDVnwDS+CMCvRMBgUQw1fxKr4Ih0NBLVUF5LbJaJX21QLCZyOtjZ1URrtsaPY/q1dQiBWSiDhb0V47PP0yGzMIN9q/Zdt1SFh+Tnj5hyDDwAIfB3zzvQDvepCw3i3A+EnLMGvVYNs8YHWkyBRW+kEYtuUnDpjFwN4NP7J3awdgAQ94Ey4AyYWSYQC40Z6sSK0sSsQHpGx2OmfMtIe2RaaNQpQVCaf5fQZmS/yL+W8kKHCVpnAkInz2RVUC4DXTOzUykop3NId1oikirmQZBS3ZXY92LTfLklU1TW1ZSJ2TgAFgxJybECHOuT2xIMWLBcsN35Ioyd3GVJkb1Tx40M/LFYJfk3w0eeWliVeII4m/lAQM0dMWI5B3mqsH7YHas4GoE1ndWaFxiGMq4BMZztmhwShY/fnNqCrRXFFoO/fbdCdOG+8MA5obQ3ey2JomIrOHEQ4j2ITEqKxmBWt2leVJdd3SLj+LD+YAhsxHqNtbPn3MKOWq+AmbJ0phFheqzA/6rxm3JokC44skSVJXTtE6XRhzZUo90HlgRlFoykDdmtdGcuOszMCvBgPGGHP7z9FbKUiWsTooXb4d8NA/acT0tr5H+jwQNPk/eMXQM0u66E9TlT8Y+T
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 20:13:41.0796 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c515af96-c143-4272-a49c-08dc5b2d0bf7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6959
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

When TTM failed to alloc VRAM, TTM evict BOs from VRAM to system memory
then retry the allocation, this currently skips the KFD BOs from the
same process because KFD requires all BOs are resident for user queues.

If TTM BO with TTM_PL_FLAG_CONTIGUOUS flag to alloc contiguous VRAM,
allow TTM evict KFD BOs from the same process, this will evict the user
queues first, and restore the queues later after contiguous VRAM
allocation.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index a5ceec7820cf..00b8603d73e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1383,7 +1383,8 @@ static bool amdgpu_ttm_bo_eviction_valuable(struct ttm_buffer_object *bo,
 	 */
 	dma_resv_for_each_fence(&resv_cursor, bo->base.resv,
 				DMA_RESV_USAGE_BOOKKEEP, f) {
-		if (amdkfd_fence_check_mm(f, current->mm))
+		if (amdkfd_fence_check_mm(f, current->mm) &&
+		    !(place->flags & TTM_PL_FLAG_CONTIGUOUS))
 			return false;
 	}
 
-- 
2.43.2

