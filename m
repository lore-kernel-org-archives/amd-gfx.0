Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD692C88E75
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 02:05:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F3DC10F857;
	Tue, 15 Sep 2026 02:05:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IZmo/AKj";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012057.outbound.protection.outlook.com
 [40.107.200.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EAFC10F857
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 02:05:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kTgm4ilV6u6ftf9VB9mWAuusulxiO5jFBEoFs2L79zD6O0WsOCmHpntyw92oMW1l1lqUoYa0H5Ruccy4yLm+2BSKZ/6yHrHkCGsA/jQT49PI0a8IhHlKw8cZzlZegxuYbC0WJFmycJbr6ny6Znp29gTjdXz9aB+h2LnWCua+NNS+C6WBIU6R6NdiWRYXl8n1gEkBJIlmvoHPohpJO+tNi0Gzt77h6rOjq/Bmrhs3aKy7nHvbJ7HFsiDfht+WHatJCyzVQDYlEJfjp+JiW4Xt7N7MNnk1R+36gsN9Ayb8lQ3pJiKUP06CAIEYmdHdpKa1fIm+jnQLs5FxFtmxZhiW0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0q/9tipAGDFhPUZr5dWK44Ww+qoGiRNu3RmJySYDeE=;
 b=Yq6N6QCKvdu/bvEdslby8+SEZaOuGcGjLmEygicf2d3wdStuRYsu+p/42Iw56b8QCyZiNW7t98Ty4MwM9oojFGvl/cr5e30mwX5WEvozUCE5PsmTCiZk1DtfG+5d6vEcN99RhCQOHjQAqpIPJIOObADSWzEbURVfeO0hemPkS6edzE+urX7YqhGuNUYFK/78jt8nMZ+ejzyaxIQFpO6JSITgZO6zfLLo9alw6iCz+TLUn8g2ljd0c2J/zvlZGOdcr4ikk1/v2ei+aPz3aKc7XPkvcpPutTJtoEHu7qmOPuQ4zG+QRIcwxUnjaXILVraCfen+QOyS3HpridvhkpK7gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0q/9tipAGDFhPUZr5dWK44Ww+qoGiRNu3RmJySYDeE=;
 b=IZmo/AKjCmpcftJiSHtTA+0JogTpbGDY2NGSB7WjcAUeH5oGmm47Zlqvmg4SqAg4Om1flVfvAP7iQ8c5cpSvajttLZdUkkKO8I4/Q6A/srDDqKnqnsQlF9xYn9f1s+R2+l2ELmc3hGTr+O4cpek94Ja8DuNr3e6mXj8Yng573bU=
Received: from MW4P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::26)
 by DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 02:05:16 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:303:115:cafe::4) by MW4P220CA0021.outlook.office365.com
 (2603:10b6:303:115::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Tue, 15
 Sep 2026 02:05:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 02:05:15 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 21:05:15 -0500
Received: from AB350-desktop.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 14 Sep 2026 21:05:14 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Vitaly Prosyak <vitaly.prosyak@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Prike Liang <prike.liang@amd.com>
Subject: [PATCH] drm/amdgpu: reserve eviction slot during userq rearm
Date: Mon, 14 Sep 2026 22:04:58 -0400
Message-ID: <20260915020513.151888-1-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|DM4PR12MB8476:EE_
X-MS-Office365-Filtering-Correlation-Id: f5e3ea09-ebe4-42a4-e13d-08df12cdc8b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|10067099003|6133799003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: nwqagMpmXq8gsyEhRuV0WEMKRUic+4l1vOd/5P/l6mXCtRkpbzH99j9S2LFXe69s0cNXHcQbWPb0UxcynJWAh7qW00T7Vi5YcHdMGm4DD1sqW5DHM4J30odFl00lZnS2C/qxtzVvdS3zARK2z7UPXi0W92k0m6ToILzHyrJWVMM33oY0RsAkl1BCSNwK5HIxmXMHkBukVs/UHsN/CGyPxtPflJP0UmNfLgOTag2Ik2oJkXtU/Ao2yvYtKUwr+wAqdlr/WC9WoUdH2PVqt6zYtBEDHpvQ7PdAGU9PGKGHALeW8DrbihYvb9gkUMSq8UnalphD6fuWxLRjtav4L/3g3dNYxl6M3/4uEacxCL6a45cTig9pljlmL4oRnvTaNbVb+xi0PGGH/q0/qwiqe5afQmnWphwY0ye9PgbQL7Fh4Q8mkF5gLdAoovDz9BJABZlPcDpBoe67saTFNlp8N5c8SUCldlAfN9hybbDwSrnfcVNV8htOcyrhjC+7bI1PODePSnGYMOdB8uyUF/B13F/cTMNGa2sbblId0yfdtXOs1q90E4SAcaBSM+SjYt4Ze8IL8NR/FOH6HeoXGQp50L18rMgeJYylhjAspTsCTkYHkC/3bz3Bo3PiSLMobMYtWIuqtUfPIZFjRIGqOwxvp2G7kk5WzwXff0gCpR6Gynhgq4k6RoHe9GJEyrGaAFJg/nMXWiPmeYU554+L7L24gQ9J8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(10067099003)(6133799003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cUIxdkqwsFo1QscCj34VN5peyblBwBRbn86/+lhfB15166aX4xFJbICsR1fk2ysD4e1VLUOqQfBFg+Rnvp7KoUOXaiRFKDgrCRaxgj+1YOU87ICVIkwAR3qw3jnfJ7XBPdIoOWeZlz4XNat/UvMtfeKlJx5MvkefRT8CAapsCBRF2gDY16PGtROpJwBjrfCOXyTdVPV8Jm0HBswdJz5wTWbAk+4EyBtZuDj1ftkTfTazakU0dDeF/VYx24CjeMwv45boVnP2QDcBiqbEPYLJv2fy/Ea+2KT3tNt1N5mz+v0CGSdS/gICXl9UsJfeniEYThajYGcTLOjumuka8k3Pzk7XJ7GSTabyI+dnXkYswgZkYaGZueQpcX5wAc7Z7VtC1ucA+xl8O+DsYwaOa3CRBwvimMDc4JR4KGsj9S2sgmhQACP2PdXmU2JCry4aVXgF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 02:05:15.3962 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e3ea09-ebe4-42a4-e13d-08df12cdc8b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8476
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

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

Problem:

    kernel BUG/CRASH at drivers/dma-buf/dma-resv.c:319!
    BUG_ON(fobj->num_fences >= fobj->max_fences)
    Workqueue: events amdgpu_userq_restore_worker

During userqueue restore, amdgpu_evf_mgr_rearm() attaches a replacement
BOOKKEEP eviction fence after the BO reservation may already have been
unlocked. dma_resv_unlock() discards unused pre-reserved capacity, so a BO
with no remaining fences can reach rearm with max_fences equal to zero.
The subsequent dma_resv_add_fence() then triggers BUG 319.

Reserve one slot in the caller-side rearm transaction immediately before
attaching the replacement fence. The BO is already locked by the drm_exec
context, so the reservation remains valid for dma_resv_add_fence(). Keep the
reservation out of amdgpu_evf_mgr_attach_fence() so caller-side accounting
remains explicit.

The earlier allocation patches do not address this reservation-lifetime root
cause and are no longer required:

Fixes:
- 00af92666f29 drm/amdgpu: reserve root PD fence slots for userq eviction-fence rearm
- 118037152820 drm/amdgpu: reserve eviction-fence slot at WPTR caller

Those commits should therefore be reverted.

Validated with repeated amd_deadlock runs, including the userqueue restore
reproducer.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Prike Liang <prike.liang@amd.com>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index 4c5e38dea4c2..636d9fc819c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -122,6 +122,7 @@ int amdgpu_evf_mgr_rearm(struct amdgpu_eviction_fence_mgr *evf_mgr,
 	struct amdgpu_eviction_fence *ev_fence;
 	struct drm_gem_object *obj;
 	unsigned long index;
+	int ret;
 
 	/* Create and initialize a new eviction fence */
 	ev_fence = kzalloc_obj(*ev_fence);
@@ -142,6 +143,13 @@ int amdgpu_evf_mgr_rearm(struct amdgpu_eviction_fence_mgr *evf_mgr,
 	/* And add it to all existing BOs */
 	drm_exec_for_each_locked_object(exec, index, obj) {
 		struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
+
+		ret = dma_resv_reserve_fences(bo->tbo.base.resv, 1);
+		if (ret) {
+                    pr_err("userq evf rearm attach failed index=%lu bo=%p ret=%d\n",
+                           index, bo, ret);
+                    return ret;
+                }
 
 		amdgpu_evf_mgr_attach_fence(evf_mgr, bo);
 	}
-- 
2.43.0

