Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15325C982D3
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 09:05:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72F6410E681;
	Thu, 17 Sep 2026 09:05:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r9SZz6RN";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010023.outbound.protection.outlook.com [52.101.46.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B77D610E681
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 09:05:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RmORUpnMScFtbGmsvuDMP9Z20rtFaXXwMQ7Xmra/F9HnUljN2TbMq9fLH6+/TTSMW/lsFPaf4uXTdZBdJQF1w4Rks05RUGvCELjMR3/pdQpWN931X9fQNfIld9YTIyxo2JhFaxoR2/S6Pfy6EV97zMUQ7JBAUMP+fRvm5rBtTXE+VnTP/xji/DTm+Gw1Mltm2r7vuiYP15t1TQ6nrs9n7uqkItv2xlwK1qgsvhSTh1Wtq+PomNRQoYDBLezf6IMz2rpFc7hv5rC0mwIsRQv82Iqw3AcAQajxczbgeGw+z0jA/Ry9+RXlu2saLWU3E+KPrridUE3k2y5cGVXuSid9Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoonfbTkDLN/7YpWX3cCy2z8RCm0RK+MOMzvGCy4cmE=;
 b=BwIQT3QptHgUYgCp+PndKcJ3hzMROufWOpB3Fw+tdmzKusAkvyvqzC8ZWnYcOREHcNu9lvFfNYG4ki7PE/d714rkYo1JhGx04rxrrTqUL1Wr/Se+eUkPQhnG3D3ahrZh43Huj4a6w12sSpNKIGkkSxBhuxXzu8q0xifoJg7JAvNGKsuDWw1ywXdvYPiDPJn18Ny83ohmnd/DfQKKx6FIbylPPpqpeo/Hqk6nDR+kPkLULDsN7feR8cSjznDDUbwX9w3mSqqlDBSZ7EHBtWmABJsTRUoPPxw1V5ygsLCv7TLm2qpZOL+BmQsVp1fqKivQ4brwRa2Qm5NNQ6O8zFlIhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoonfbTkDLN/7YpWX3cCy2z8RCm0RK+MOMzvGCy4cmE=;
 b=r9SZz6RNSaJ9Z43GcCINM9z7duaYEqXkyyIHT3832b1vpGOTIZS5Zz84xGKQnfTNRgkVwpvO2NOOqhdlmEj48xP3O+EEG5aqsnkB6QOWBZTx7FT7LripppJg2Q8fnQnuHCy1H9XqytAwN/RJDTC9ASFBF/I6oQPNG7hnKAgOH2g=
Received: from MW3PR05CA0002.namprd05.prod.outlook.com (2603:10b6:303:2b::7)
 by CY1PR12MB9560.namprd12.prod.outlook.com (2603:10b6:930:fd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 09:05:51 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:303:2b:cafe::59) by MW3PR05CA0002.outlook.office365.com
 (2603:10b6:303:2b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Thu, 17
 Sep 2026 09:05:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Thu, 17 Sep 2026 09:05:50 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 17 Sep 2026 04:05:48 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu: Use iosys_map for trap TMA BO mappings
Date: Thu, 17 Sep 2026 14:35:30 +0530
Message-ID: <20260917090530.666757-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|CY1PR12MB9560:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ea86855-0431-49d6-7aeb-08df149adef4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|10067099003|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: FcqIH6BYST6aYVXpwVdiafLO+DV0q4QCugac3OV+nmeB3k0i6qTj+FSFwYr5fVXq1lHY86nvgcWy46urcajfu7F/SwqgJ089RR9ca5x+2ouqADLR6j2aOnTU992o/a/ASzeMM+jbzQfEKaOjxjA86zKiLAGaAcFm94H4jsywUNPj7pcmNZCynU+zBTDT1TePNj3u9+pcNn6B3G+JuKetFD/h264TlUyqUUfj8tCpkqx2WrjD37oUeXIDgo3z1ZE1XpWKwpeEof0h28kBxooFQm4OynveXBZGMfcsYdGjPbTwtWpSBtP8ETZdSxhcObRnhA1zv2Gho0Z8xLFt5fEhEqZWU5DDwAusA7RosiDwm4MNAzHi9BHvTvUIYmftv63IEVVtJEDHZ1xxDuqs+tRtKozlA8jE7rv5Cex8OXWlgX01xivJI727ounbvxACP9tPrVtkgZgnaVyY6FNGOsP7upSnj4SKsbhwb4vRuPE6tj5+4rdlHCBvzLpdygO72hr3pCfCWCet//gRS6ZYxPpXt4GKErAxXXfhPfZziDf5HC6HRi18BvO8VMhOIQpb8zlJ5PvLamIjs5afPRVOrICZgfEnBOqBp8rzuva43xKkpdHfSgsoYqrwO6WMkjyVny5GBXwVhaXCR460kkcLk8ZYiKYhcTIGE4rb/EbPef7FQgBAsQqQRXBo7rbmoKzJLkhDlKSOHbjMP8hRkSZU0LkNTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(10067099003)(11063799006)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0Dovma3qotKKQvpFF8NGAs/w/gCed/UftAjU4fpQyXU0DNXfShFpmmZzsg8vfznOwf2zljenSOpuZ8aYX1KtyfGARrxDaEuN62VVe50Gtk/tc+7fTkJuiszqX4Qz6cVsOyjxaQ4DxdjWOKOasQEUFPV2qsTUUfmZXy2IpZdKYlXre75u63yPQ3cZC9YpnEq9H15KRMbAJyOQqwQIz0xE0zlnBeLjlbNbX44sis14g/su1HRlofaabHA7DYNyRrhVVqcrGPuGcm0uisDrxI3U43OJbD6LMPTSRYXUEqZjZeU9mhjOrbAdUbsTqVPlAS03rv8O08ccwLeOwkMtNu7Aw0RD3kUfA2nLkOAcfX26Ka/tPZU1oHhpLzw73/qoIWf6lNyEc/74a1pMe1lcufCRHR1G/9C4fkOMJXNMS+UABaFqAwa6tIlS4ZMQbBDX3g/1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 09:05:50.6945 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea86855-0431-49d6-7aeb-08df149adef4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9560
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

Replace amdgpu_bo_kmap()/amdgpu_bo_kunmap() in the trap handler code
with ttm_bo_vmap()/ttm_bo_vunmap().

Store the mapping as struct iosys_map and use iosys_map helpers for
memory access. This aligns the trap code with the modern DRM/TTM mapping
interfaces.

Using iosys_map allows the code to use common DRM mapping helpers
instead of directly accessing memory through raw CPU pointers.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c | 31 +++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h |  2 +-
 2 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
index 29eba2968350..eb842fe8aed1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
@@ -427,29 +427,29 @@ int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		goto err_exec;
 
-	/* VM resv already held — kmap directly, no separate reserve needed */
-	r = amdgpu_bo_kmap(cwsr->tma_bo, &cwsr->tma_cpu_addr);
+	/* VM resv already held, vmap directly without a separate reserve */
+	r = ttm_bo_vmap(&cwsr->tma_bo->tbo, &cwsr->tma_map);
 	if (r)
 		goto err_tma;
 
-	memset(cwsr->tma_cpu_addr, 0, AMDGPU_TRAP_TMA_MAX_SIZE);
+	iosys_map_memset(&cwsr->tma_map, 0, 0, AMDGPU_TRAP_TMA_MAX_SIZE);
 
 	r = amdgpu_trap_map_region(adev, vm, cwsr, AMDGPU_TRAP_TMA);
 	if (r)
-		goto err_kmap;
+		goto err_vmap;
 
 	r = amdgpu_trap_map_region(adev, vm, cwsr, AMDGPU_TRAP_TBA);
 	if (r) {
 		amdgpu_trap_unmap_region(adev, cwsr, AMDGPU_TRAP_TMA);
-		goto err_kmap;
+		goto err_vmap;
 	}
 
 	drm_exec_fini(&exec);
 	*trap_obj = cwsr;
 	return 0;
 
-err_kmap:
-	amdgpu_bo_kunmap(cwsr->tma_bo);
+err_vmap:
+	ttm_bo_vunmap(&cwsr->tma_bo->tbo, &cwsr->tma_map);
 err_tma:
 	amdgpu_bo_unref(&cwsr->tma_bo);
 err_exec:
@@ -524,7 +524,7 @@ void amdgpu_trap_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 err:
 	drm_exec_fini(&exec);
 	/* TMA BO not pinned — release CPU mapping and free */
-	amdgpu_bo_kunmap((*trap_obj)->tma_bo);
+	ttm_bo_vunmap(&(*trap_obj)->tma_bo->tbo, &(*trap_obj)->tma_map);
 	amdgpu_bo_unref(&(*trap_obj)->tma_bo);
 	kfree(*trap_obj);
 	*trap_obj = NULL;
@@ -569,24 +569,24 @@ static int amdgpu_trap_set_l2_trap_handler(struct amdgpu_device *adev, struct am
 					   struct amdgpu_trap_usr_addr *tma,
 					   struct amdgpu_trap_usr_addr *tba)
 {
-	uint64_t *l1tma;
 	int r;
 
 	if (!amdgpu_trap_is_enabled(adev))
 		return -EOPNOTSUPP;
 
-	if (!cwsr_obj || !cwsr_obj->tma_cpu_addr || !tma || !tba)
+	if (!cwsr_obj || iosys_map_is_null(&cwsr_obj->tma_map) || !tma || !tba)
 		return -EINVAL;
+
 	r = amdgpu_trap_validate_user_addr(adev, vm, tma);
 	if (r)
 		return r;
+
 	r = amdgpu_trap_validate_user_addr(adev, vm, tba);
 	if (r)
 		return r;
 
-	l1tma = (uint64_t *)(cwsr_obj->tma_cpu_addr);
-	l1tma[0] = tma->addr;
-	l1tma[1] = tba->addr;
+	iosys_map_wr(&cwsr_obj->tma_map, 0, u64, tma->addr);
+	iosys_map_wr(&cwsr_obj->tma_map, sizeof(u64), u64, tba->addr);
 
 	return 0;
 }
@@ -638,16 +638,13 @@ int amdgpu_trap_set_trap_debug_flag(struct amdgpu_device *adev,
 				    struct amdgpu_trap_obj *cwsr_obj,
 				    bool enabled)
 {
-	uint64_t *l1tma;
-
 	if (!amdgpu_trap_is_enabled(adev))
 		return -EOPNOTSUPP;
 
 	if (!cwsr_obj)
 		return -EINVAL;
 
-	l1tma = (uint64_t *)(cwsr_obj->tma_cpu_addr);
-	l1tma[2] = enabled;
+	iosys_map_wr(&cwsr_obj->tma_map, 2 * sizeof(u64), u64, enabled);
 
 	return 0;
 }
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
index 6d4664469bad..57e338c91f0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
@@ -42,7 +42,7 @@ struct amdgpu_trap_obj {
 	struct amdgpu_bo *tma_bo;
 	struct amdgpu_bo_va *tba_va;
 	struct amdgpu_bo_va *tma_va;
-	void *tma_cpu_addr;
+	struct iosys_map tma_map;
 };
 
 struct amdgpu_trap_info {
-- 
2.34.1

