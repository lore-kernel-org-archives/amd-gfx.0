Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B3BFC02198
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 08:08:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB6A810EBED;
	Fri, 14 Feb 2025 08:08:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2hjR8dB9";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 388A010EBF0
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 08:08:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IRq6ExoBTeR+aSL95gKxZLWHqTl+ImjwmND66UTSugE14Ma3gNG7h0ce6qMImzDQYCdv+hMEdp57saAQ6ao2/RaP0bGJxJRlyMfNL1frqUeZtR4srHAO9omsjbZXZ4zl0RZyE8fQUauCyNMEAUG1V8pZ+oLn0WUzGv18ap2md6EhDXCQKVkOa2GVC+l1ly2/yE3A0xYbXPyEf3oyikD8TS6hrata5X17jF5Y5sEPmpYtsR9txJBBuf7dJmOPdVumSOPIG0MLVeFlNM2FWrc4qTPt8O3c+QE0lrpuw1jVi0VIbBZ3EjTn5ePoPQuWl30PYQ6NEr9yzFJpifvc7S5yBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DsDdQz4oxWkR1OTOo7bpFVzIUPVAFEeuTKzviTUj4bY=;
 b=pY4roFnkK/TRjQGVjm3mMTYqpWFFu+APLHzERF8wpE2U2UElfXZi9OIkuy/jl/1RYwpDJr68G3w67uxbASnrdRpwqIl8omjlZNzk+m7kPeuU76IuFkKha0FIg7Al9fOeci/XytGNWgsugk/9MO6z3L/+XKm8zE+WQBgNEK3NWBIjVuqxez7WEFjIYqOMRX/KXuxuSwTlIowWCOB1XyapIMGDymF/KcTjyZ41AV9GCHWeg4lImcihgkK90DhfX8nkuajcXwZCmn43HWXmvGkMk+UWw6hQTy0MCMrf7YYmDDfnF8EEb34spyZyBMDbH4S0HKLPAKlA6RVe4Z9rqy7r5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsDdQz4oxWkR1OTOo7bpFVzIUPVAFEeuTKzviTUj4bY=;
 b=2hjR8dB95GMbUEhNIpy1OKUQwy616P/XNo87xbF4Z+fl3BXRpHj8r8LTbtUzGe97gHQtqCr3+Elouxv/r2V7o3SXwl0tI1Et+U8lyhm+nXgGlx367cIUxdXBPzFPRSJXY5wqXqBmyrKdebXjw5lA6hJipC35bPd+DXXMoI6jbbs=
Received: from BN1PR14CA0025.namprd14.prod.outlook.com (2603:10b6:408:e3::30)
 by CH3PR12MB9148.namprd12.prod.outlook.com (2603:10b6:610:19d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Fri, 14 Feb
 2025 08:07:59 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:408:e3:cafe::d5) by BN1PR14CA0025.outlook.office365.com
 (2603:10b6:408:e3::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.15 via Frontend Transport; Fri,
 14 Feb 2025 08:07:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.0 via Frontend Transport; Fri, 14 Feb 2025 08:07:58 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 02:07:57 -0600
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>
Subject: [PATCH v2 06/12] drm/amdgpu: add RAS CPER ring buffer
Date: Fri, 14 Feb 2025 16:07:13 +0800
Message-ID: <df6f2d02df550e4fbcc3229295707eee9177574e.1739519672.git.xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1739519672.git.xiang.liu@amd.com>
References: <cover.1739519672.git.xiang.liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|CH3PR12MB9148:EE_
X-MS-Office365-Filtering-Correlation-Id: c7689d6c-54a1-4604-16eb-08dd4cceb1f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?shvdw18Uh+zRhb+oY2i5e37zJn9/8ZXil6RiqXV2XHGS/M2VuEDvU1hVkmMG?=
 =?us-ascii?Q?umDEDwoOFhaMueVLapPZogBCRmhsKhtI5qa7Xrjy/n+OJRTH9rVVLUuzAAAe?=
 =?us-ascii?Q?HAQsaReYLgRWdWpyu6n63fDnyWCVWmR6jSI6gS5osfvVNnhfdnUcUbof1Yg1?=
 =?us-ascii?Q?jEHKVSSjKDWOWtc4mADo0bCNARNd5+1z5C57BtCAt1SGjjegyDt06GemlU9a?=
 =?us-ascii?Q?PLuVUz3GdKk2yycBrxb0FIqQz+5K+IMbc7cXdJDIP+aN+P+C2nf7EiqXIKzW?=
 =?us-ascii?Q?GSyoioDjPZdVMBrbb/15Hh7NiEe3OsQTYJiZw5HHqLHqk05hZCWFaUHlU/nf?=
 =?us-ascii?Q?Ta3UNOb7nZeLi6Qb92n6SQcDi5GEIssjE78w1KvBXRblJ0AdSeKpnlwNZbkm?=
 =?us-ascii?Q?b3RxQSYuVSwMmkLZUN43ezOSvbfnK9KbH2oxvfhTzG9qAHhFcbv4g2CByvfn?=
 =?us-ascii?Q?TBDaYtJuiJKdoQuBQPU8Tr+zSv7AMNyfPsiWKVb3yrx4Ou+2jOz1LECVIXfg?=
 =?us-ascii?Q?BRP6Q7bhVvm4tuO3pdlrj5XnmYHTo1pMh4tpxRD0lbpx0z2o+Cd2Hm5smw30?=
 =?us-ascii?Q?5yApSHDw+KAfPuVruxRxJE7BkjcfY5vZfsldjtIsfSPH05/ZXK2xsxFQAsgf?=
 =?us-ascii?Q?aMaeCNGUPEzJ3iftMPVh5fgVvSCBQQ7EnTOqAcI5IWqsfjBViLaQ4T+Pzq4X?=
 =?us-ascii?Q?xQXIMk6fSoer5RlUzI7VhxmBiQ567paIkVKWqrhZvmgQeAQlxiHhA8zahRbV?=
 =?us-ascii?Q?QK89s27HddPN7HSPL83XwVAaMQPgUFMvE+TBqai/cH9v85mIReAyXhbPix6K?=
 =?us-ascii?Q?gYe5K/u38FltYCNQC5Nk+6Rd/4AviD9ne9VqVa6iq4SfuCoXwxmNwBfvYVE5?=
 =?us-ascii?Q?1Eq+eDgnZgmvOePQvpLjAQqigUCQj0KuxBiU2/hfdJ/eeCmVu6KtWtPa8Ak8?=
 =?us-ascii?Q?+D+2PVK5r1R3SfxCEyFR5ZlXPNB4YZslwOJ0ZuFih7wWoYhmg9rmdtjaCvbp?=
 =?us-ascii?Q?iVM8UNHpvwHBRNb0vxtNbciFKJPx2ScgagNan7GXuNnQW0dLwiGo4o/yaSPi?=
 =?us-ascii?Q?asqqsbteAzic4zSbcSqc+akPe+CyC7xw/9xgpoV0XIdRHsUgzOLpULoFLEoL?=
 =?us-ascii?Q?4j6d1oZZNUIRYv9arbORr68MrCUb67Es7KbC09Y3NezSjzMJbpr1QgV0OE+X?=
 =?us-ascii?Q?xpjN2g+Ryx6x+7UkoJdx/ArIjpX+rmxbrEhNQEPubPoQV7DEGcKzqqAyTTi6?=
 =?us-ascii?Q?l/VqzSPirLDHI180YgePMcxuBcKQYdKs03FATbU4e9+bA6Ue7UgGNOKjS2KC?=
 =?us-ascii?Q?pkYxPClPrJWy60mmXb+yxzpGcdgroLsQzcyDnh+aS2nK1Vgbgronj2+PZnPX?=
 =?us-ascii?Q?BpYEP+RWxZ3emA2kV5TJKs96eDuAFjfPUpdDAWclRoCbkEeLYVR3GlKPDWMM?=
 =?us-ascii?Q?o1maZPQMow32E/jiV04ytvjmsI2wZNipVv+zy956K9IUK7Vupyd9xwzoNKCi?=
 =?us-ascii?Q?W8tpUD9SXTfaotI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 08:07:58.8587 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7689d6c-54a1-4604-16eb-08dd4cceb1f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9148
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

From: Tao Zhou <tao.zhou1@amd.com>

And initialize it, this is a pure software ring to store RAS CPER data.

v2: update the initialization of count_dw of cper ring, it's dword
variable.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c   | 39 +++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h   |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   | 29 ++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |  1 +
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c |  3 +-
 5 files changed, 57 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
index f82aa12a88f4..cef7c1ec0d7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
@@ -365,6 +365,39 @@ int amdgpu_cper_generate_ce_records(struct amdgpu_device *adev,
 	return 0;
 }
 
+static u64 amdgpu_cper_ring_get_rptr(struct amdgpu_ring *ring)
+{
+	return *(ring->rptr_cpu_addr);
+}
+
+static u64 amdgpu_cper_ring_get_wptr(struct amdgpu_ring *ring)
+{
+	return ring->wptr;
+}
+
+static const struct amdgpu_ring_funcs cper_ring_funcs = {
+	.type = AMDGPU_RING_TYPE_CPER,
+	.align_mask = 0xff,
+	.support_64bit_ptrs = false,
+	.get_rptr = amdgpu_cper_ring_get_rptr,
+	.get_wptr = amdgpu_cper_ring_get_wptr,
+};
+
+static int amdgpu_cper_ring_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_ring *ring = &(adev->cper.ring_buf);
+
+	ring->adev = NULL;
+	ring->ring_obj = NULL;
+	ring->use_doorbell = false;
+	ring->no_scheduler = true;
+	ring->funcs = &cper_ring_funcs;
+
+	sprintf(ring->name, "cper");
+	return amdgpu_ring_init(adev, ring, PAGE_SIZE, NULL, 0,
+				AMDGPU_RING_PRIO_DEFAULT, NULL);
+}
+
 int amdgpu_cper_init(struct amdgpu_device *adev)
 {
 	mutex_init(&adev->cper.cper_lock);
@@ -372,16 +405,14 @@ int amdgpu_cper_init(struct amdgpu_device *adev)
 	adev->cper.enabled = true;
 	adev->cper.max_count = CPER_MAX_ALLOWED_COUNT;
 
-	/*TODO: initialize cper ring*/
-
-	return 0;
+	return amdgpu_cper_ring_init(adev);
 }
 
 int amdgpu_cper_fini(struct amdgpu_device *adev)
 {
 	adev->cper.enabled = false;
 
-	/*TODO: free cper ring */
+	amdgpu_ring_fini(&(adev->cper.ring_buf));
 	adev->cper.count = 0;
 	adev->cper.wptr = 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h
index 6860a809f2f5..80c8571cff9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h
@@ -62,6 +62,7 @@ struct amdgpu_cper {
 	uint32_t wptr;
 
 	void *ring[CPER_MAX_ALLOWED_COUNT];
+	struct amdgpu_ring ring_buf;
 };
 
 void amdgpu_cper_entry_fill_hdr(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index cfbc18c12113..005cdaee9987 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -324,20 +324,27 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 	/* always set cond_exec_polling to CONTINUE */
 	*ring->cond_exe_cpu_addr = 1;
 
-	r = amdgpu_fence_driver_start_ring(ring, irq_src, irq_type);
-	if (r) {
-		dev_err(adev->dev, "failed initializing fences (%d).\n", r);
-		return r;
-	}
+	if (ring->funcs->type != AMDGPU_RING_TYPE_CPER) {
+		r = amdgpu_fence_driver_start_ring(ring, irq_src, irq_type);
+		if (r) {
+			dev_err(adev->dev, "failed initializing fences (%d).\n", r);
+			return r;
+		}
 
-	max_ibs_dw = ring->funcs->emit_frame_size +
-		     amdgpu_ring_max_ibs(ring->funcs->type) * ring->funcs->emit_ib_size;
-	max_ibs_dw = (max_ibs_dw + ring->funcs->align_mask) & ~ring->funcs->align_mask;
+		max_ibs_dw = ring->funcs->emit_frame_size +
+			     amdgpu_ring_max_ibs(ring->funcs->type) * ring->funcs->emit_ib_size;
+		max_ibs_dw = (max_ibs_dw + ring->funcs->align_mask) & ~ring->funcs->align_mask;
 
-	if (WARN_ON(max_ibs_dw > max_dw))
-		max_dw = max_ibs_dw;
+		if (WARN_ON(max_ibs_dw > max_dw))
+			max_dw = max_ibs_dw;
 
-	ring->ring_size = roundup_pow_of_two(max_dw * 4 * sched_hw_submission);
+		ring->ring_size = roundup_pow_of_two(max_dw * 4 * sched_hw_submission);
+	} else {
+		ring->ring_size = roundup_pow_of_two(max_dw * 4);
+		ring->count_dw = (ring->ring_size - 4) >> 2;
+		/* ring buffer is empty now */
+		ring->wptr = *ring->rptr_cpu_addr = 0;
+	}
 
 	ring->buf_mask = (ring->ring_size / 4) - 1;
 	ring->ptr_mask = ring->funcs->support_64bit_ptrs ?
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 04af26536f97..7372e4aed6b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -82,6 +82,7 @@ enum amdgpu_ring_type {
 	AMDGPU_RING_TYPE_KIQ,
 	AMDGPU_RING_TYPE_MES,
 	AMDGPU_RING_TYPE_UMSCH_MM,
+	AMDGPU_RING_TYPE_CPER,
 };
 
 enum amdgpu_ib_pool_type {
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index 16d924acb788..83a07309a538 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -77,7 +77,8 @@ static void aqua_vanjaram_set_xcp_id(struct amdgpu_device *adev,
 	ring->xcp_id = AMDGPU_XCP_NO_PARTITION;
 	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE)
 		adev->gfx.enforce_isolation[0].xcp_id = ring->xcp_id;
-	if (adev->xcp_mgr->mode == AMDGPU_XCP_MODE_NONE)
+	if ((adev->xcp_mgr->mode == AMDGPU_XCP_MODE_NONE) ||
+	    (ring->funcs->type == AMDGPU_RING_TYPE_CPER))
 		return;
 
 	inst_mask = 1 << inst_idx;
-- 
2.34.1

