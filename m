Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB9CC5DF7D
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C001210EC95;
	Tue, 18 Aug 2026 20:22:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WbxLsdrg";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013030.outbound.protection.outlook.com
 [40.107.201.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA5F910EC93
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kN0CRQ2nsZVQpDw9Ih+JCLb+6bS6AVyZ47MQsG5xphuA22xpy9K4OzeK2V0t3RVja9JDm4cbXyrGq3ei10olr6QxSd40/RRVy8YLip9Pa2MLxrzrWBvvhATn4ks36fc7xO1oLPTDWjzXy8L9iqyh58ttOaBSvbPAZKSVnDwzIP7uBPEakz5f7cnOoFsNhDz8/BwxZS2W7562yyI2ch4OtmfE9L6zJi4tXQsmmuiddSKjiNS+XvzhHzhwoQVsyagSH8VCYhQHJcV7inVs3Cfy9guigUyUi1gNvDIc9Ly6hV31Ij9+RY7992pziF6TTBPFBYFBXRY2TjDuAEteaMhyTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpmsU88AQ3sg2stZOYM9FC11wqw5gpZ4k5hxauWVDGg=;
 b=dLvE7qf5ZfX45O23AgWej0O6k7jy5OqxGRtJ6g4o38WfUSn6XblAEiJU8dm3ryZjyTZToUKSKmdtp0Go9da0iuARIP87FZeFSXQl+5DtxJrk7GTcebqk5n39EMIROnUONuNz+rbXcz8MuMsFpvoQ4mKD9xFRO9lHXNTzfoQK4A0NSx57KtJrfHhph/ErSwR2tVZX7sxjlA6s2Tsdku7RmSpYwXVmlPtkMGe6qa2zSFoQZuTWl/+LejKkp8+DOjk1ZI8ZnALtuwVnjWLs77xu9xyxcWT4DxHUHd7i2hPMeIVYwd9ek1/mGiVuClPYNEmpFzccLR3mIFII8zvTD7o7rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpmsU88AQ3sg2stZOYM9FC11wqw5gpZ4k5hxauWVDGg=;
 b=WbxLsdrgfYVDjigQyixQQXmYkF/w1Pw+fIEi4D4jWQ4FbsAcrG01m5fnVrg4YMcfy/bBZh9IBkvNHWHZcuPAtw6ASuDu3Ap84Z+Tn4Yn9OQTY+4MFO7QBHZOho1TEPekZzcDtYLXfVhG3oguadyMiEWA8RtrI96Zlu5Bt5ro3FQ=
Received: from BN9PR03CA0868.namprd03.prod.outlook.com (2603:10b6:408:13d::33)
 by CY8PR12MB7314.namprd12.prod.outlook.com (2603:10b6:930:52::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:22:04 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:408:13d:cafe::85) by BN9PR03CA0868.outlook.office365.com
 (2603:10b6:408:13d::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 20:22:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 20:22:03 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:21:58 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:21:58 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 07/82] drm/amd/display: Test writeback connector
Date: Tue, 18 Aug 2026 16:14:59 -0400
Message-ID: <20260818202139.4172592-8-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|CY8PR12MB7314:EE_
X-MS-Office365-Filtering-Correlation-Id: 329b1dbb-2776-46cb-35ee-08defd665e0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|6133799003|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Fr2KPbVvqvkQj4QS1eOJUqBisNp8BVOfRA9692AcOL1N3p+bCaYOuSgpWpt3SmtNgFc+YBdhivzGkpnwWVptx4ZyCKeTtC/p/LeEcVaT0ofTayA8vIcgR1U4WI07b9PWzUlZD2MoFz8367GMQbk0Jq0shsQqZiaqHF2TxuR/K8UehzJ4OZvMMp5XXd6NRMaTtt2ddvlrGkR+vAtExMv5T9TROFsgzkk3mZeL53jpU7jKZvVmbeoUOw/z+x/7HjkEoEcLNh9mUH6WGWkTNOi/uU7ahTync/x1Be5b3ki30WSTfC+cWZZjijf5+0xcMdr4oq+eBfET1+c4KaRg8O+Ayu41zslYi3Lu1dTW3OYH80F6nSla4Td57+bkThDzgG1FlD+/f5kraOmUdWI1PhdoyymLTuq3qacj7fLkdcf4LZqRGFF0QDGXBhEYXi/bcJMHCIAfMirtOsWEwWCJq4mCgnBrWVhI9EAgMttn0hnOZPV2ooJ+8edZSQUrqB1ZWUNqH/oXfk77bCIktFRkMl60U73d5ZN6FdHSR6cIi1rXKbnvFmJTqPbxDptBvhi3WuF9x9TfNQG99Rtv7VeiI8dQC0x6y2YMXnZS8jLTBKb5SOYa/f9TBGhiBTxF/X/cuB7iUmkmtvDzp7zaciIbVJOLqqDgh/Mt12SYsOzWfYlzbhpuGoUcoqpT2mbOpA5FCKzKwvZ9OqOSE1u52Zpxgziw3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(6133799003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: A0fOJwSzu8FpHcmopPXEmQaMU3DRBET6jroQEoLYJITfAsLOSE+0yIaT2hw/2ScqM3pt1ur3sV5UAJxVx0TFkW/zQHKPVr/zLQDc4Pao98Zcphu2rmyuIvnM+VmQWAW03xyNd11HBW/+jNN1XU4g2A0SbOAWk4mVL7609cWXpQafdiAnlrGYNgykHmWa2aC+CayXq10xe1K0yGlgBscsz8VurCXfCeBTwkcoXo90GQJB6NhrBYik00gSqCjvsVS2HrXTKQVOblZR2AMZmTxPWlsWtdBpB2AXxKddbjh1jwgxE0a1FEzUrjknoj+zTGXrhzwBtHN7ijDjPu+8HoNBZsJorFnzkOygAGeloknTdv4kOM0reCc5YrCMGiG0XKQszIKy6dDXzNaGLA4fremsGGf6F6JbRFhF0RPNzYwm5MjtAP/quDHxqCkk5vy4TfT+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:03.9048 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 329b1dbb-2776-46cb-35ee-08defd665e0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7314
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

From: Alex Hung <alex.hung@amd.com>

[WHAT]
Add KUnit tests for the writeback connector. The tests cover the
encoder atomic check (missing job, missing framebuffer, matching mode,
width, height and combined size mismatches, and an unsupported pixel
format), mode enumeration and its 3840x2160 bound, connector
initialization, and buffer object preparation and cleanup including
the reserve, fence slot, pin and GART allocation failure paths.

[HOW]
Add struct amdgpu_dm_wb_kunit_ops, a KUnit-only indirection table for
the buffer object calls that would otherwise need a live TTM device.
Tests install their own table to force error returns and to count
calls, which makes the failure and cleanup ordering paths reachable in
the UML test environment. The default table points at the existing
AMDGPU, TTM and DMA reservation functions, so no test-only wrapper is
introduced.

Route the affected calls through wb_* wrappers, so the KUnit build
dispatches through the table while non-KUnit builds call the same
functions directly.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c  |  72 +++-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h  |  16 +
 .../amdgpu_dm/tests/amdgpu_dm_wb_test.c       | 330 ++++++++++++++++++
 3 files changed, 405 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
index a7594012a0b2e..6f91a992d43f8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
@@ -41,6 +41,52 @@ static const u32 amdgpu_dm_wb_formats[] = {
 	DRM_FORMAT_XRGB2101010,
 };
 
+#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+static const struct amdgpu_dm_wb_kunit_ops amdgpu_dm_wb_default_ops = {
+	.reserve = amdgpu_bo_reserve,
+	.reserve_fences = dma_resv_reserve_fences,
+	.pin = amdgpu_bo_pin,
+	.alloc_gart = amdgpu_ttm_alloc_gart,
+	.unreserve = amdgpu_bo_unreserve,
+	.gpu_offset = amdgpu_bo_gpu_offset,
+	.ref = amdgpu_bo_ref,
+	.unpin = amdgpu_bo_unpin,
+	.unref = amdgpu_bo_unref,
+};
+
+static const struct amdgpu_dm_wb_kunit_ops *amdgpu_dm_wb_ops =
+	&amdgpu_dm_wb_default_ops;
+
+void amdgpu_dm_wb_kunit_set_ops(const struct amdgpu_dm_wb_kunit_ops *ops)
+{
+	amdgpu_dm_wb_ops = ops ? ops : &amdgpu_dm_wb_default_ops;
+}
+EXPORT_IF_KUNIT(amdgpu_dm_wb_kunit_set_ops);
+
+#define wb_bo_reserve			amdgpu_dm_wb_ops->reserve
+#define wb_dma_resv_reserve_fences	amdgpu_dm_wb_ops->reserve_fences
+#define wb_bo_pin			amdgpu_dm_wb_ops->pin
+#define wb_ttm_alloc_gart		amdgpu_dm_wb_ops->alloc_gart
+#define wb_bo_unreserve			amdgpu_dm_wb_ops->unreserve
+#define wb_bo_gpu_offset		amdgpu_dm_wb_ops->gpu_offset
+#define wb_bo_ref			amdgpu_dm_wb_ops->ref
+#define wb_bo_unpin			amdgpu_dm_wb_ops->unpin
+#define wb_bo_unref			amdgpu_dm_wb_ops->unref
+
+#else
+
+#define wb_bo_reserve			amdgpu_bo_reserve
+#define wb_dma_resv_reserve_fences	dma_resv_reserve_fences
+#define wb_bo_pin			amdgpu_bo_pin
+#define wb_ttm_alloc_gart		amdgpu_ttm_alloc_gart
+#define wb_bo_unreserve			amdgpu_bo_unreserve
+#define wb_bo_gpu_offset		amdgpu_bo_gpu_offset
+#define wb_bo_ref			amdgpu_bo_ref
+#define wb_bo_unpin			amdgpu_bo_unpin
+#define wb_bo_unref			amdgpu_bo_unref
+
+#endif
+
 STATIC_IFN_KUNIT int amdgpu_dm_wb_encoder_atomic_check(struct drm_encoder *encoder,
 					struct drm_crtc_state *crtc_state,
 					struct drm_connector_state *conn_state)
@@ -105,13 +151,13 @@ STATIC_IFN_KUNIT int amdgpu_dm_wb_prepare_job(struct drm_writeback_connector *wb
 	rbo = gem_to_amdgpu_bo(obj);
 	adev = amdgpu_ttm_adev(rbo->tbo.bdev);
 
-	r = amdgpu_bo_reserve(rbo, true);
+	r = wb_bo_reserve(rbo, true);
 	if (r) {
 		drm_err(adev_to_drm(adev), "fail to reserve bo: %pe\n", ERR_PTR(r));
 		return r;
 	}
 
-	r = dma_resv_reserve_fences(rbo->tbo.base.resv, TTM_NUM_MOVE_FENCES);
+	r = wb_dma_resv_reserve_fences(rbo->tbo.base.resv, TTM_NUM_MOVE_FENCES);
 	if (r) {
 		drm_err(adev_to_drm(adev), "reserving fence slot failed: %pe\n", ERR_PTR(r));
 		goto error_unlock;
@@ -120,32 +166,32 @@ STATIC_IFN_KUNIT int amdgpu_dm_wb_prepare_job(struct drm_writeback_connector *wb
 	domain = amdgpu_display_supported_domains(adev, rbo->flags);
 
 	rbo->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
-	r = amdgpu_bo_pin(rbo, domain);
+	r = wb_bo_pin(rbo, domain);
 	if (unlikely(r != 0)) {
 		if (r != -ERESTARTSYS)
 			DRM_ERROR("Failed to pin framebuffer: %pe\n", ERR_PTR(r));
 		goto error_unlock;
 	}
 
-	r = amdgpu_ttm_alloc_gart(&rbo->tbo);
+	r = wb_ttm_alloc_gart(&rbo->tbo);
 	if (unlikely(r != 0)) {
 		DRM_ERROR("%p bind failed: %pe\n", rbo, ERR_PTR(r));
 		goto error_unpin;
 	}
 
-	amdgpu_bo_unreserve(rbo);
+	wb_bo_unreserve(rbo);
 
-	afb->address = amdgpu_bo_gpu_offset(rbo);
+	afb->address = wb_bo_gpu_offset(rbo);
 
-	amdgpu_bo_ref(rbo);
+	wb_bo_ref(rbo);
 
 	return 0;
 
 error_unpin:
-	amdgpu_bo_unpin(rbo);
+	wb_bo_unpin(rbo);
 
 error_unlock:
-	amdgpu_bo_unreserve(rbo);
+	wb_bo_unreserve(rbo);
 	return r;
 }
 EXPORT_IF_KUNIT(amdgpu_dm_wb_prepare_job);
@@ -160,15 +206,15 @@ STATIC_IFN_KUNIT void amdgpu_dm_wb_cleanup_job(struct drm_writeback_connector *c
 		return;
 
 	rbo = gem_to_amdgpu_bo(job->fb->obj[0]);
-	r = amdgpu_bo_reserve(rbo, false);
+	r = wb_bo_reserve(rbo, false);
 	if (unlikely(r)) {
 		DRM_ERROR("failed to reserve rbo before unpin: %pe\n", ERR_PTR(r));
 		return;
 	}
 
-	amdgpu_bo_unpin(rbo);
-	amdgpu_bo_unreserve(rbo);
-	amdgpu_bo_unref(&rbo);
+	wb_bo_unpin(rbo);
+	wb_bo_unreserve(rbo);
+	wb_bo_unref(&rbo);
 }
 EXPORT_IF_KUNIT(amdgpu_dm_wb_cleanup_job);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h
index 5fd616bc43b5c..8d39a37e80f0a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h
@@ -31,6 +31,9 @@
 
 struct amdgpu_display_manager;
 struct amdgpu_dm_wb_connector;
+struct amdgpu_bo;
+struct dma_resv;
+struct ttm_buffer_object;
 
 int amdgpu_dm_wb_connector_init(struct amdgpu_display_manager *dm,
 				struct amdgpu_dm_wb_connector *dm_wbcon,
@@ -40,6 +43,18 @@ int amdgpu_dm_wb_connector_init(struct amdgpu_display_manager *dm,
 #include <drm/drm_connector.h>
 #include <drm/drm_crtc.h>
 
+struct amdgpu_dm_wb_kunit_ops {
+	int (*reserve)(struct amdgpu_bo *bo, bool interruptible);
+	int (*reserve_fences)(struct dma_resv *resv, unsigned int num_fences);
+	int (*pin)(struct amdgpu_bo *bo, u32 domain);
+	int (*alloc_gart)(struct ttm_buffer_object *tbo);
+	void (*unreserve)(struct amdgpu_bo *bo);
+	u64 (*gpu_offset)(struct amdgpu_bo *bo);
+	struct amdgpu_bo *(*ref)(struct amdgpu_bo *bo);
+	void (*unpin)(struct amdgpu_bo *bo);
+	void (*unref)(struct amdgpu_bo **bo);
+};
+
 int amdgpu_dm_wb_encoder_atomic_check(struct drm_encoder *encoder,
 				      struct drm_crtc_state *crtc_state,
 				      struct drm_connector_state *conn_state);
@@ -48,6 +63,7 @@ int amdgpu_dm_wb_prepare_job(struct drm_writeback_connector *wb_connector,
 			     struct drm_writeback_job *job);
 void amdgpu_dm_wb_cleanup_job(struct drm_writeback_connector *connector,
 			      struct drm_writeback_job *job);
+void amdgpu_dm_wb_kunit_set_ops(const struct amdgpu_dm_wb_kunit_ops *ops);
 #endif
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
index 3454cf3714148..03036f9063854 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
@@ -23,6 +23,151 @@
 #include "amdgpu_dm_wb.h"
 #include "amdgpu_dm_kunit_test_helpers.h"
 
+struct dm_wb_test_bo {
+	struct amdgpu_bo bo;
+	struct amdgpu_device *adev;
+	int reserve_ret;
+	int reserve_fences_ret;
+	int pin_ret;
+	int alloc_gart_ret;
+	u64 gpu_offset;
+	unsigned int reserve_count;
+	unsigned int reserve_fences_count;
+	unsigned int pin_count;
+	unsigned int alloc_gart_count;
+	unsigned int unreserve_count;
+	unsigned int ref_count;
+	unsigned int unpin_count;
+	unsigned int unref_count;
+	unsigned int call_seq;
+	unsigned int reserve_seq;
+	unsigned int unreserve_seq;
+	unsigned int unpin_seq;
+	unsigned int unref_seq;
+};
+
+static struct dm_wb_test_bo *to_dm_wb_test_bo(struct amdgpu_bo *bo)
+{
+	return container_of(bo, struct dm_wb_test_bo, bo);
+}
+
+static int dm_wb_test_reserve(struct amdgpu_bo *bo, bool interruptible)
+{
+	struct dm_wb_test_bo *test_bo = to_dm_wb_test_bo(bo);
+
+	test_bo->reserve_count++;
+	test_bo->reserve_seq = ++test_bo->call_seq;
+	return test_bo->reserve_ret;
+}
+
+static int dm_wb_test_reserve_fences(struct dma_resv *resv,
+				     unsigned int num_fences)
+{
+	struct dm_wb_test_bo *test_bo;
+
+	test_bo = container_of(resv, struct dm_wb_test_bo, bo.tbo.base._resv);
+	test_bo->reserve_fences_count++;
+	return test_bo->reserve_fences_ret;
+}
+
+static int dm_wb_test_pin(struct amdgpu_bo *bo, u32 domain)
+{
+	struct dm_wb_test_bo *test_bo = to_dm_wb_test_bo(bo);
+
+	test_bo->pin_count++;
+	return test_bo->pin_ret;
+}
+
+static int dm_wb_test_alloc_gart(struct ttm_buffer_object *tbo)
+{
+	struct dm_wb_test_bo *test_bo = to_dm_wb_test_bo(ttm_to_amdgpu_bo(tbo));
+
+	test_bo->alloc_gart_count++;
+	return test_bo->alloc_gart_ret;
+}
+
+static void dm_wb_test_unreserve(struct amdgpu_bo *bo)
+{
+	struct dm_wb_test_bo *test_bo = to_dm_wb_test_bo(bo);
+
+	test_bo->unreserve_count++;
+	test_bo->unreserve_seq = ++test_bo->call_seq;
+}
+
+static u64 dm_wb_test_gpu_offset(struct amdgpu_bo *bo)
+{
+	return to_dm_wb_test_bo(bo)->gpu_offset;
+}
+
+static struct amdgpu_bo *dm_wb_test_ref(struct amdgpu_bo *bo)
+{
+	to_dm_wb_test_bo(bo)->ref_count++;
+	return bo;
+}
+
+static void dm_wb_test_unpin(struct amdgpu_bo *bo)
+{
+	struct dm_wb_test_bo *test_bo = to_dm_wb_test_bo(bo);
+
+	test_bo->unpin_count++;
+	test_bo->unpin_seq = ++test_bo->call_seq;
+}
+
+static void dm_wb_test_unref(struct amdgpu_bo **bo)
+{
+	struct dm_wb_test_bo *test_bo = to_dm_wb_test_bo(*bo);
+
+	test_bo->unref_count++;
+	test_bo->unref_seq = ++test_bo->call_seq;
+	*bo = NULL;
+}
+
+static const struct amdgpu_dm_wb_kunit_ops dm_wb_test_ops = {
+	.reserve = dm_wb_test_reserve,
+	.reserve_fences = dm_wb_test_reserve_fences,
+	.pin = dm_wb_test_pin,
+	.alloc_gart = dm_wb_test_alloc_gart,
+	.unreserve = dm_wb_test_unreserve,
+	.gpu_offset = dm_wb_test_gpu_offset,
+	.ref = dm_wb_test_ref,
+	.unpin = dm_wb_test_unpin,
+	.unref = dm_wb_test_unref,
+};
+
+static void dm_wb_test_reset_ops(void *unused)
+{
+	amdgpu_dm_wb_kunit_set_ops(NULL);
+}
+
+static struct drm_writeback_job *dm_wb_test_alloc_job(struct kunit *test,
+						      struct dm_wb_test_bo **test_bo)
+{
+	struct amdgpu_framebuffer *afb;
+	struct drm_writeback_job *job;
+
+	*test_bo = kunit_kzalloc(test, sizeof(**test_bo), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, *test_bo);
+	(*test_bo)->adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_NOT_NULL(test, (*test_bo)->adev);
+
+	/* Let the driver's real BO and device lookups resolve to the fake BO. */
+	(*test_bo)->bo.tbo.bdev = &(*test_bo)->adev->mman.bdev;
+	(*test_bo)->bo.tbo.base.resv = &(*test_bo)->bo.tbo.base._resv;
+
+	afb = kunit_kzalloc(test, sizeof(*afb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, afb);
+	afb->base.obj[0] = &(*test_bo)->bo.tbo.base;
+
+	job = kunit_kzalloc(test, sizeof(*job), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, job);
+	job->fb = &afb->base;
+
+	amdgpu_dm_wb_kunit_set_ops(&dm_wb_test_ops);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dm_wb_test_reset_ops, NULL), 0);
+
+	return job;
+}
+
 
 /* Helper functions */
 
@@ -387,6 +532,134 @@ static void dm_test_wb_prepare_job_no_fb(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, ret, 0);
 }
 
+/**
+ * dm_test_wb_prepare_job_success - Verify successful BO preparation
+ * @test: KUnit test context
+ *
+ * The writeback BO should be reserved, pinned, mapped into GART, referenced,
+ * and assigned its GPU address.
+ */
+static void dm_test_wb_prepare_job_success(struct kunit *test)
+{
+	struct dm_wb_test_bo *test_bo;
+	struct drm_writeback_job *job;
+	struct amdgpu_framebuffer *afb;
+	int ret;
+
+	job = dm_wb_test_alloc_job(test, &test_bo);
+	afb = to_amdgpu_framebuffer(job->fb);
+	test_bo->gpu_offset = 0x12340000;
+
+	ret = amdgpu_dm_wb_prepare_job(NULL, job);
+
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, test_bo->reserve_count, 1);
+	KUNIT_EXPECT_EQ(test, test_bo->reserve_fences_count, 1);
+	KUNIT_EXPECT_EQ(test, test_bo->pin_count, 1);
+	KUNIT_EXPECT_EQ(test, test_bo->alloc_gart_count, 1);
+	KUNIT_EXPECT_EQ(test, test_bo->unreserve_count, 1);
+	KUNIT_EXPECT_EQ(test, test_bo->ref_count, 1);
+	KUNIT_EXPECT_EQ(test, afb->address, test_bo->gpu_offset);
+	KUNIT_EXPECT_TRUE(test, test_bo->bo.flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS);
+}
+
+/**
+ * dm_test_wb_prepare_job_reserve_failure - Verify reserve errors are returned
+ * @test: KUnit test context
+ *
+ * A BO reserve failure should stop preparation without attempting cleanup on
+ * a BO that was never reserved.
+ */
+static void dm_test_wb_prepare_job_reserve_failure(struct kunit *test)
+{
+	struct dm_wb_test_bo *test_bo;
+	struct drm_writeback_job *job;
+	int ret;
+
+	job = dm_wb_test_alloc_job(test, &test_bo);
+	test_bo->reserve_ret = -EBUSY;
+
+	ret = amdgpu_dm_wb_prepare_job(NULL, job);
+
+	KUNIT_EXPECT_EQ(test, ret, -EBUSY);
+	KUNIT_EXPECT_EQ(test, test_bo->reserve_count, 1);
+	KUNIT_EXPECT_EQ(test, test_bo->reserve_fences_count, 0);
+	KUNIT_EXPECT_EQ(test, test_bo->unreserve_count, 0);
+}
+
+/**
+ * dm_test_wb_prepare_job_fence_failure - Verify fence reservation cleanup
+ * @test: KUnit test context
+ *
+ * Failure to reserve fence slots should release the BO reservation without
+ * attempting to pin the BO.
+ */
+static void dm_test_wb_prepare_job_fence_failure(struct kunit *test)
+{
+	struct dm_wb_test_bo *test_bo;
+	struct drm_writeback_job *job;
+	int ret;
+
+	job = dm_wb_test_alloc_job(test, &test_bo);
+	test_bo->reserve_fences_ret = -ENOMEM;
+
+	ret = amdgpu_dm_wb_prepare_job(NULL, job);
+
+	KUNIT_EXPECT_EQ(test, ret, -ENOMEM);
+	KUNIT_EXPECT_EQ(test, test_bo->reserve_fences_count, 1);
+	KUNIT_EXPECT_EQ(test, test_bo->pin_count, 0);
+	KUNIT_EXPECT_EQ(test, test_bo->unreserve_count, 1);
+}
+
+/**
+ * dm_test_wb_prepare_job_pin_failure - Verify pin failure cleanup
+ * @test: KUnit test context
+ *
+ * A pin failure should release the BO reservation without trying to unpin a
+ * BO that was not successfully pinned.
+ */
+static void dm_test_wb_prepare_job_pin_failure(struct kunit *test)
+{
+	struct dm_wb_test_bo *test_bo;
+	struct drm_writeback_job *job;
+	int ret;
+
+	job = dm_wb_test_alloc_job(test, &test_bo);
+	test_bo->pin_ret = -EINVAL;
+
+	ret = amdgpu_dm_wb_prepare_job(NULL, job);
+
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+	KUNIT_EXPECT_EQ(test, test_bo->pin_count, 1);
+	KUNIT_EXPECT_EQ(test, test_bo->alloc_gart_count, 0);
+	KUNIT_EXPECT_EQ(test, test_bo->unpin_count, 0);
+	KUNIT_EXPECT_EQ(test, test_bo->unreserve_count, 1);
+}
+
+/**
+ * dm_test_wb_prepare_job_gart_failure - Verify GART allocation cleanup
+ * @test: KUnit test context
+ *
+ * A GART allocation failure should unpin and unreserve the BO.
+ */
+static void dm_test_wb_prepare_job_gart_failure(struct kunit *test)
+{
+	struct dm_wb_test_bo *test_bo;
+	struct drm_writeback_job *job;
+	int ret;
+
+	job = dm_wb_test_alloc_job(test, &test_bo);
+	test_bo->alloc_gart_ret = -ENOMEM;
+
+	ret = amdgpu_dm_wb_prepare_job(NULL, job);
+
+	KUNIT_EXPECT_EQ(test, ret, -ENOMEM);
+	KUNIT_EXPECT_EQ(test, test_bo->alloc_gart_count, 1);
+	KUNIT_EXPECT_EQ(test, test_bo->unpin_count, 1);
+	KUNIT_EXPECT_EQ(test, test_bo->unreserve_count, 1);
+	KUNIT_EXPECT_EQ(test, test_bo->ref_count, 0);
+}
+
 /**
  * dm_test_wb_cleanup_job_no_fb - Verify cleanup_job early return without a framebuffer
  * @test: KUnit test context
@@ -406,6 +679,56 @@ static void dm_test_wb_cleanup_job_no_fb(struct kunit *test)
 	amdgpu_dm_wb_cleanup_job(NULL, job);
 }
 
+/**
+ * dm_test_wb_cleanup_job_success - Verify successful BO cleanup
+ * @test: KUnit test context
+ *
+ * Cleanup should reserve, unpin, unreserve, and drop the writeback BO
+ * reference in order.
+ */
+static void dm_test_wb_cleanup_job_success(struct kunit *test)
+{
+	struct dm_wb_test_bo *test_bo;
+	struct drm_writeback_job *job;
+
+	job = dm_wb_test_alloc_job(test, &test_bo);
+
+	amdgpu_dm_wb_cleanup_job(NULL, job);
+
+	KUNIT_EXPECT_EQ(test, test_bo->reserve_count, 1);
+	KUNIT_EXPECT_EQ(test, test_bo->unpin_count, 1);
+	KUNIT_EXPECT_EQ(test, test_bo->unreserve_count, 1);
+	KUNIT_EXPECT_EQ(test, test_bo->unref_count, 1);
+
+	/* The BO stays reserved across the unpin, and is released last. */
+	KUNIT_EXPECT_LT(test, test_bo->reserve_seq, test_bo->unpin_seq);
+	KUNIT_EXPECT_LT(test, test_bo->unpin_seq, test_bo->unreserve_seq);
+	KUNIT_EXPECT_LT(test, test_bo->unreserve_seq, test_bo->unref_seq);
+}
+
+/**
+ * dm_test_wb_cleanup_job_reserve_failure - Verify cleanup reserve failure
+ * @test: KUnit test context
+ *
+ * If cleanup cannot reserve the BO, it should leave the pin and reference
+ * untouched for a later cleanup attempt.
+ */
+static void dm_test_wb_cleanup_job_reserve_failure(struct kunit *test)
+{
+	struct dm_wb_test_bo *test_bo;
+	struct drm_writeback_job *job;
+
+	job = dm_wb_test_alloc_job(test, &test_bo);
+	test_bo->reserve_ret = -EBUSY;
+
+	amdgpu_dm_wb_cleanup_job(NULL, job);
+
+	KUNIT_EXPECT_EQ(test, test_bo->reserve_count, 1);
+	KUNIT_EXPECT_EQ(test, test_bo->unpin_count, 0);
+	KUNIT_EXPECT_EQ(test, test_bo->unreserve_count, 0);
+	KUNIT_EXPECT_EQ(test, test_bo->unref_count, 0);
+}
+
 static struct kunit_case dm_wb_test_cases[] = {
 	/* amdgpu_dm_wb_encoder_atomic_check */
 	KUNIT_CASE(dm_test_wb_atomic_check_no_job),
@@ -422,7 +745,14 @@ static struct kunit_case dm_wb_test_cases[] = {
 	KUNIT_CASE(dm_test_wb_connector_init_success),
 	/* amdgpu_dm_wb_prepare_job / amdgpu_dm_wb_cleanup_job */
 	KUNIT_CASE(dm_test_wb_prepare_job_no_fb),
+	KUNIT_CASE(dm_test_wb_prepare_job_success),
+	KUNIT_CASE(dm_test_wb_prepare_job_reserve_failure),
+	KUNIT_CASE(dm_test_wb_prepare_job_fence_failure),
+	KUNIT_CASE(dm_test_wb_prepare_job_pin_failure),
+	KUNIT_CASE(dm_test_wb_prepare_job_gart_failure),
 	KUNIT_CASE(dm_test_wb_cleanup_job_no_fb),
+	KUNIT_CASE(dm_test_wb_cleanup_job_success),
+	KUNIT_CASE(dm_test_wb_cleanup_job_reserve_failure),
 	{}
 };
 
-- 
2.43.0

