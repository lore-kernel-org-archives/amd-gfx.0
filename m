Return-Path: <SRS0=qt+g=GW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C921BC433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 20:40:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B64523107
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 20:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B64523107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F5C689E14;
	Tue, 19 Jan 2021 20:40:38 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 681AD89E14
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jan 2021 20:40:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWUuTgysWltLslzINR/R0XgbZLNOh8C6wHV+eV7rRKClXm3K1v5IqsDy1Z62G3v/z+5CCJBm+x0yeMiLCckF/E6qjkUdkHwTVVfCrUldHHYqOEkbjp1Vz2Frsb7Xwn9SapAKYmZ6usxnbJA6vBwvT/orFgatE7ay+jkhhop6VIuyCJlUxJoYQY6QCFvBPuiwzLIcJ0/rihM83ifI5ndVFSK/RG6CVOo1b//hxBtE/i5QByNDU/fIAfNQSV/EuoHTl3pDAAwt9j+JJuXmD2i4Gl+E9mTwSHiFSLlvttCBEt8CtFMOALBP2p4SsLR8qlRQZIK2AUJyGpCqe5P/ApLBfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTyK4FhGeatxEVsGQ35gKa3Vxs19RoosLnw1t7KT0Ck=;
 b=f2xspdJvC090W13Dvl7h6g78oGxIj0QR0RhJSWUQtTUvTUh4HlPMFNizt9Byh/UF8sO+jFCfbMz0UwnDLwIgosWYtFswf1qRxhlk9nnoX7ltuTRqw3vM1B0NfPKSTyWwH8tMTVF/8Jvsi1jFwWdgBX2Vhc1TlAo+MU4wmC9wPzSekuhCDd0c+fz6cXNCJuO4xbEpS5rLujbsZ0nT3C5IlB0qREmjVhpp/cfJTIDZer/Wj0u43BAYtOrz8vu0l/SiURReetW+BgopN4arjN8MwVm2JwjBY7XaAREWfAx8jeMe+/nI3y01KDQllL+4G4P/hwVytQaAMK9jIXCdj0ukrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTyK4FhGeatxEVsGQ35gKa3Vxs19RoosLnw1t7KT0Ck=;
 b=uIupz5IIvORiGMSPL20pfkKy8COK9UOe1SwGWRiXCtao/DGWAXtgcMFbM9I0LtPzEHSO8dra8piskNEViUvB/j9JIAW9gkBJT3Nc+cOYDrtyumw1bpnkWsL35mCN8Wd7/Hah1K6WZ8u5P60ogPo5cpVqdf65ZgIRXw3VIP7Momc=
Received: from DM3PR12CA0102.namprd12.prod.outlook.com (2603:10b6:0:55::22) by
 MN2PR12MB3406.namprd12.prod.outlook.com (2603:10b6:208:c9::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.11; Tue, 19 Jan 2021 20:40:34 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:55:cafe::a2) by DM3PR12CA0102.outlook.office365.com
 (2603:10b6:0:55::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend
 Transport; Tue, 19 Jan 2021 20:40:34 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3763.12 via Frontend Transport; Tue, 19 Jan 2021 20:40:33 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 19 Jan
 2021 14:40:33 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 19 Jan
 2021 14:40:33 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Tue, 19 Jan 2021 14:40:32 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: Implement functions to let DC allocate GPU
 memory
Date: Tue, 19 Jan 2021 15:40:30 -0500
Message-ID: <20210119204030.2794877-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e78ac283-8f2b-482f-51db-08d8bcba7828
X-MS-TrafficTypeDiagnostic: MN2PR12MB3406:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3406C6173BC5C70D48C3AE19F9A30@MN2PR12MB3406.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cNRRro0fBm+byuAG/fOBoYuZiKsYfUzRBmugDggvlcxrQ7LtXopdgOtST8w6kmsJabGn+TzR5mGAUlUfZMkzzbRtXmruM6ZnngOxhVPxhh5Y24jY7Q4bjCV/+MDk/3rOL3d6k44d0jfxAGTv977SXraSORcobYNnYlc+4LT7RftiH6P0mLQfJAny0BDlrOOnrQaOKaVsFfBkAlQS9Y4tPZ3A+rpkYotX+RbLlzuAA6bMIqiIUD8Y0lvFawVVfb0zdZUdbEH04T7eQBKr8zg60V8LI67RX4KX+jU47cmFGRHronzDsjtA0dYUf0XPLR8joWbablKumhOn5n195EZVFUd6kyZNKFF0/a3N8iJgU7gBKOUZVuXTeeT6x8yfjCePlF4CBrZoEzdC/TIzSFSnP2FMs0s0QmrtD9pUpkjwp3MMrgG3Z/jafIxblL/Ih3zHzONf6hCeTz1Ma/dQoV1s0A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(39850400004)(136003)(396003)(346002)(376002)(46966006)(86362001)(478600001)(82740400003)(1076003)(82310400003)(7696005)(6862004)(54906003)(5660300002)(36756003)(47076005)(2906002)(2616005)(6636002)(316002)(356005)(426003)(8676002)(81166007)(83380400001)(8936002)(70586007)(4326008)(37006003)(26005)(186003)(70206006)(336012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2021 20:40:33.7832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e78ac283-8f2b-482f-51db-08d8bcba7828
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3406
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
Cc: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Harry Wentland <harry.wentland@amd.com>

[Why]
DC needs to communicate with PM FW through GPU memory. In order
to do so we need to be able to allocate memory from within DC.

[How]
Call amdgpu_bo_create_kernel to allocate GPU memory and use a
list in amdgpu_display_manager to track our allocations so we
can clean them up later.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  9 +++++
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 40 +++++++++++++++++--
 3 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e490fc2486f7..83ec92a69cba 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1017,6 +1017,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	init_data.soc_bounding_box = adev->dm.soc_bounding_box;
 
+	INIT_LIST_HEAD(&adev->dm.da_list);
+
 	/* Display Core create. */
 	adev->dm.dc = dc_create(&init_data);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 38bc0f88b29c..49137924a855 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -130,6 +130,13 @@ struct amdgpu_dm_backlight_caps {
 	bool aux_support;
 };
 
+struct dal_allocation {
+	struct list_head list;
+	struct amdgpu_bo *bo;
+	void *cpu_ptr;
+	u64 gpu_addr;
+};
+
 /**
  * struct amdgpu_display_manager - Central amdgpu display manager device
  *
@@ -350,6 +357,8 @@ struct amdgpu_display_manager {
 	 */
 	struct amdgpu_encoder mst_encoders[AMDGPU_DM_MAX_CRTC];
 	bool force_timing_sync;
+
+	struct list_head da_list;
 };
 
 enum dsc_clock_force_state {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 3244a6ea7a65..5dc426e6e785 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -652,8 +652,31 @@ void *dm_helpers_allocate_gpu_mem(
 		size_t size,
 		long long *addr)
 {
-	// TODO
-	return NULL;
+	struct amdgpu_device *adev = ctx->driver_context;
+	struct dal_allocation *da;
+	u32 domain = (type == DC_MEM_ALLOC_TYPE_GART) ?
+		AMDGPU_GEM_DOMAIN_GTT : AMDGPU_GEM_DOMAIN_VRAM;
+	int ret;
+
+	da = kzalloc(sizeof(struct dal_allocation), GFP_KERNEL);
+	if (!da)
+		return NULL;
+
+	ret = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
+				      domain, &da->bo,
+				      &da->gpu_addr, &da->cpu_ptr);
+
+	*addr = da->gpu_addr;
+
+	if (ret) {
+		kfree(da);
+		return NULL;
+	}
+
+	/* add da to list in dm */
+	list_add(&da->list, &adev->dm.da_list);
+
+	return da->cpu_ptr;
 }
 
 void dm_helpers_free_gpu_mem(
@@ -661,5 +684,16 @@ void dm_helpers_free_gpu_mem(
 		enum dc_gpu_mem_alloc_type type,
 		void *pvMem)
 {
-	// TODO
+	struct amdgpu_device *adev = ctx->driver_context;
+	struct dal_allocation *da;
+
+	/* walk the da list in DM */
+	list_for_each_entry(da, &adev->dm.da_list, list) {
+		if (pvMem == da->cpu_ptr) {
+			amdgpu_bo_free_kernel(&da->bo, &da->gpu_addr, &da->cpu_ptr);
+			list_del(&da->list);
+			kfree(da);
+			break;
+		}
+	}
 }
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
