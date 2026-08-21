Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F40FDC5DF8E
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:51:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CA2110F401;
	Fri, 21 Aug 2026 19:51:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LGfr6Xza";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012036.outbound.protection.outlook.com [52.101.48.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B620910F40A
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:51:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eiW0RqFzvame9aRERJgQQAU2FBZavtPiciM5PN6Do6FfD76BakwSQ9UsWYXTGr5yhsyTFRBzCLS5ZwV4pnaGe5/l/bcZ0fXe41jiNBCyJJ/YC66JFHrzmfxfKDfceDorHSW5BQHy0mZP02N233zaG0vYANGuSbdhBH59zVvwcHaYoe20Gxt7a+GCuEbx4ByaD+a84HG8GnXZLh+3lJ4htq5m5NKFdb0WLUiuXR8ILURc815J8ccXJoGcsh5btnAlc99GFBp9tdKCLMlfaTRgJ1AZdV2HeMlpxLh/xK2UNx06UDen0j0/9yXIPf+Ex80AGYGYAzIjTbXI37sLJ7aDHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rk/pOHo7kxyg4tQqpHXigYZEOx3ZYam8JDO+qRMMlJ4=;
 b=iyKbIGR+saLa6lzd9HXGOUiB8GDXkWNmE8Em8fhI4J+Zon4sDH9Cgjw3yLgfIoYFZmCYh73g+39bD0mvbL4OZawqxHR1dSnyZ9ZIVhomh+bdFcycHReE9eKMMDvJWyc/HspQVO8/Im+USreySauB3JChaNR4hR7m0/PvIuuEBXLwKqk3dA601lEw9Z51pDD4enfvYuOzsh/3D1cbDEkQyso1KFG2xrqnAcX/9ssLmNPV/kIJx0aK2BWFyIpwsLVBKznXxqZKlQu8tiGpnhSvvXeTaQ/FI8nWVZk24jFPRLwK6ukcJjm7WKOhtrOfGejJwhRt3nJ7MDD7I+zFqDDb3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rk/pOHo7kxyg4tQqpHXigYZEOx3ZYam8JDO+qRMMlJ4=;
 b=LGfr6Xza16aTc02hTr1ZVKIjYrtvRzJdIIMidsKZ6ZXrsY6/WoD3H4Q+NuBsajsfPYU9Y13SpJ1x8NJEBdm+6oM7u/oZQyTw/Mfd2ndEvAJSzxVFBxQ5gtwurPC84kcTd5cwmgcq3aMuPQulq9oqm9Z0IfBKY2EuJAbqofLf+cU=
Received: from CH2PR10CA0023.namprd10.prod.outlook.com (2603:10b6:610:4c::33)
 by DSVPR12MB999171.namprd12.prod.outlook.com (2603:10b6:8:388::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 19:35:32 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::4c) by CH2PR10CA0023.outlook.office365.com
 (2603:10b6:610:4c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 19:35:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:32 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:27 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 26/95] drm/amdgpu: Rework VMID reservation logic
Date: Fri, 21 Aug 2026 15:33:49 -0400
Message-ID: <20260821193458.808626-27-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|DSVPR12MB999171:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f22a0a8-b416-425a-e216-08deffbb5d5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: BVgFPhMis3ykp52akl3GASgJoAASczzmxOPamUyXwkqYU7xPUFAMctZfLw9FG4Xp5QyyQj6bZ3w0UbDxyuxTBsLLQlIPUP7d7WUjrOQchkY9v81+78s475bKT9vymUqq9O8przDpvA23uPK/vkZLHZgZYapqlJpcW0fv529ZArJboQucTDihajBmBKfKrUirESQTckzOGGal+37lPuwI3aqj6jz7sJ4eCVInMhO9qTrEvg/AnneXP7qiVN5vhzoZinRVt/qTl6INyvSVtxyDgjt19Z7uciPb2Pab9UGuRgDl8PY1znbrxW7plS/5+LwHN0S+r7h3eTmgqsjjWA00ABFirwHWyEiLrvH6ofXj0z9bEURz7Ck4fsZ0+ICaaCGKvPZan40+RIsocWW+O8WtUBFvVvkLXnekgLxmn0AATR5IrHrWd+kzjkh1/D0oM1OFbi1NyUM8ai14lRZwGAYar6IaBczslb/qcIFkwi3t/M5/U7WR5jV6bEXecaHEXFaov+bkYMF1shZK0Cx7RGNsknFb6HcxGn+KpHMvGnwIKrOGXQKCz2fmFyQ+y6PLkH4x10TOlYLmK+IrB/Jf7ql/0HPndXFI/s+m9cC7Va6SMfySbY3cXm0XTCTmq0OHhEwWc8y7bDk2hNms3o9QZQg5cqiNHLod0/Tbg+pgKeEtQVNMnoTX76ySSLKnz5zh3kEiDc+SpKchUVlf7zLEIF/2Ug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VYHZJgKpNCigS1vKOrlPSiquVH/chw6Du7iMWRJideSi0ZTgiQSbpPO8SmuYSzOId9tZ5Cv3ZbigokqBtIgY/0qzN/HZngUzRWhHj0V2/Jp6gDAhbHpWB7yzNFhEXM3Roh4GNV9q4AVU/z++6WeS+00D4l89hOIAgd5Qk0tgPveUW3b4Wu/OfIOoHD39i8tL/5qWDuNAlXT/m8OIE3QL72odLEXSswtRRMDRVZ0i45nXRO26Sp2C2m+BGsoVTjsw31UAXDNRSXIBMJu4jDR6u19wcBcn5xJYVpvKJQ76Af8RwTdpv0pDoyjNyUyHdZXQw8kOU0V10KYtdnd7s/L7WOWjTuwrJIDdGOOI4XlY93hOH3bZbrWq7fhNqKc0JW3fkcwyP/N8u/+AGXyaBx5tvaPhpMFK8mYkuvFxwUltKX+qB0Hqw6xWalzWIYGL00ur
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:32.3355 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f22a0a8-b416-425a-e216-08deffbb5d5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999171
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

From: Mukul Joshi <mukul.joshi@amd.com>

Rework the VMID reservation logic by passing in the mask
of VMIDs (for both GFXHUB and MMHUB) available for it to
use. The VMID masks for both GFXHUB and MMHUB are initialized
in the respective ASIC specific files.
This also helps in reserving per-ASIC VMIDs. This is in
preparation for reserving a VMID for NPA added in the next
patch.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 33 ++++++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h | 27 +++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  4 +++
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  |  5 ++++
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  | 14 +++++++----
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c   |  6 +++++
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   |  6 +++++
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   |  6 +++++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  6 +++++
 17 files changed, 95 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 8a2d64f0ebc3f..8c32c69437645 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -625,12 +625,27 @@ void amdgpu_vmid_reset_all(struct amdgpu_device *adev)
 	for (i = 0; i < AMDGPU_MAX_VMHUBS; ++i) {
 		struct amdgpu_vmid_mgr *id_mgr =
 			&adev->vm_manager.id_mgr[i];
-
-		for (j = 1; j < id_mgr->num_ids; ++j)
+		for_each_set_bit(j, id_mgr->vmid_mask, AMDGPU_NUM_VMID)
 			amdgpu_vmid_reset(adev, i, j);
 	}
 }
 
+void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
+				   unsigned long vmid_mask, bool for_mmhub)
+{
+	unsigned int i;
+
+	BUILD_BUG_ON(AMDGPU_NUM_VMID > BITS_PER_LONG);
+
+	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++) {
+		bool is_mmhub = AMDGPU_IS_MMHUB0(i) || AMDGPU_IS_MMHUB1(i);
+
+		if (is_mmhub == for_mmhub)
+			bitmap_copy(adev->vm_manager.id_mgr[i].vmid_mask,
+				    &vmid_mask, AMDGPU_NUM_VMID);
+	}
+}
+
 /**
  * amdgpu_vmid_mgr_init - init the VMID manager
  *
@@ -649,19 +664,8 @@ void amdgpu_vmid_mgr_init(struct amdgpu_device *adev)
 		mutex_init(&id_mgr->lock);
 		INIT_LIST_HEAD(&id_mgr->ids_lru);
 
-		/* for GC <10, SDMA uses MMHUB so use first_kfd_vmid for both GC and MM */
-		if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(10, 0, 0))
-			/* manage only VMIDs not used by KFD */
-			id_mgr->num_ids = adev->vm_manager.first_kfd_vmid;
-		else if (AMDGPU_IS_MMHUB0(i) ||
-			 AMDGPU_IS_MMHUB1(i))
-			id_mgr->num_ids = 16;
-		else
-			/* manage only VMIDs not used by KFD */
-			id_mgr->num_ids = adev->vm_manager.first_kfd_vmid;
-
 		/* skip over VMID 0, since it is the system VM */
-		for (j = 1; j < id_mgr->num_ids; ++j) {
+		for_each_set_bit(j, id_mgr->vmid_mask, AMDGPU_NUM_VMID) {
 			amdgpu_vmid_reset(adev, i, j);
 			amdgpu_sync_create(&id_mgr->ids[j].active);
 			list_add_tail(&id_mgr->ids[j].list, &id_mgr->ids_lru);
@@ -685,6 +689,7 @@ void amdgpu_vmid_mgr_fini(struct amdgpu_device *adev)
 			&adev->vm_manager.id_mgr[i];
 
 		mutex_destroy(&id_mgr->lock);
+
 		for (j = 0; j < AMDGPU_NUM_VMID; ++j) {
 			struct amdgpu_vmid *id = &id_mgr->ids[j];
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
index 4b55d0d9703a3..46b2c21601263 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
@@ -26,6 +26,8 @@
 #include <linux/types.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
+#include <linux/bitops.h>
+#include <linux/find.h>
 #include <linux/dma-fence.h>
 
 #include "amdgpu_sync.h"
@@ -33,6 +35,27 @@
 /* maximum number of VMIDs */
 #define AMDGPU_NUM_VMID	16
 
+/**
+ * for_each_vmid_and_zero - iterate over VMID 0 plus every VMID set in a hub's
+ *                          vmid_mask
+ * @vmid:	loop cursor (int / unsigned int)
+ * @adev:	struct amdgpu_device *
+ * @hub:	vmhub index into adev->vm_manager.id_mgr[]
+ *
+ * Equivalent to OR-ing BIT(0) into id_mgr[hub].vmid_mask and walking the
+ * result with for_each_set_bit(). Used by the gfx_v*_constants_init() paths
+ * which must always touch VMID 0 (system) in addition to the regular VMIDs
+ * owned by the hub.
+ *
+ * Relies on AMDGPU_NUM_VMID (16) fitting in a single unsigned long, i.e.
+ * vmid_mask[] being a 1-element bitmap.
+ */
+#define for_each_vmid_and_zero(vmid, adev, hub)				\
+	for (unsigned long __vmid_mask =				\
+		(adev)->vm_manager.id_mgr[(hub)].vmid_mask[0] | BIT(0);	\
+	     __vmid_mask; __vmid_mask = 0)				\
+		for_each_set_bit((vmid), &__vmid_mask, AMDGPU_NUM_VMID)
+
 struct amdgpu_device;
 struct amdgpu_fpriv;
 struct amdgpu_vm;
@@ -65,10 +88,10 @@ struct amdgpu_vmid {
 
 struct amdgpu_vmid_mgr {
 	struct mutex		lock;
-	unsigned		num_ids;
 	struct list_head	ids_lru;
 	struct amdgpu_vmid	ids[AMDGPU_NUM_VMID];
 	bool			reserved_vmid;
+	DECLARE_BITMAP(vmid_mask, AMDGPU_NUM_VMID);
 };
 
 int amdgpu_pasid_alloc(unsigned int bits, struct amdgpu_fpriv *fpriv);
@@ -95,5 +118,7 @@ void amdgpu_vmid_reset_all(struct amdgpu_device *adev);
 
 void amdgpu_vmid_mgr_init(struct amdgpu_device *adev);
 void amdgpu_vmid_mgr_fini(struct amdgpu_device *adev);
+void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
+				   unsigned long vmid_mask, bool for_mmhub);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index f9154421c2d5f..f91e693de60a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -5364,7 +5364,7 @@ static void gfx_v10_0_constants_init(struct amdgpu_device *adev)
 	/* XXX SH_MEM regs */
 	/* where to put LDS, scratch, GPUVM in FSA64 space */
 	mutex_lock(&adev->srbm_mutex);
-	for (i = 0; i < adev->vm_manager.id_mgr[AMDGPU_GFXHUB(0)].num_ids; i++) {
+	for_each_vmid_and_zero(i, adev, AMDGPU_GFXHUB(0)) {
 		nv_grbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
 		WREG32_SOC15(GC, 0, mmSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index a447562977abe..743fe1bd39e86 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -2213,7 +2213,7 @@ static void gfx_v11_0_constants_init(struct amdgpu_device *adev)
 	/* XXX SH_MEM regs */
 	/* where to put LDS, scratch, GPUVM in FSA64 space */
 	mutex_lock(&adev->srbm_mutex);
-	for (i = 0; i < adev->vm_manager.id_mgr[AMDGPU_GFXHUB(0)].num_ids; i++) {
+	for_each_vmid_and_zero(i, adev, AMDGPU_GFXHUB(0)) {
 		soc21_grbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
 		WREG32_SOC15(GC, 0, regSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index fdfee88e41e33..d65ff3e551189 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1852,7 +1852,7 @@ static void gfx_v12_0_constants_init(struct amdgpu_device *adev)
 	/* XXX SH_MEM regs */
 	/* where to put LDS, scratch, GPUVM in FSA64 space */
 	mutex_lock(&adev->srbm_mutex);
-	for (i = 0; i < adev->vm_manager.id_mgr[AMDGPU_GFXHUB(0)].num_ids; i++) {
+	for_each_vmid_and_zero(i, adev, AMDGPU_GFXHUB(0)) {
 		soc24_grbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
 		WREG32_SOC15(GC, 0, regSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index cc4e939cb3f37..aae5ab9c338c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -1725,7 +1725,7 @@ static void gfx_v12_1_xcc_constants_init(struct amdgpu_device *adev,
 	/* XXX SH_MEM regs */
 	/* where to put LDS, scratch, GPUVM in FSA64 space */
 	mutex_lock(&adev->srbm_mutex);
-	for (i = 0; i < adev->vm_manager.id_mgr[AMDGPU_GFXHUB(0)].num_ids; i++) {
+	for_each_vmid_and_zero(i, adev, AMDGPU_GFXHUB(0)) {
 		soc_v1_0_grbm_select(adev, 0, 0, 0, i, GET_INST(GC, xcc_id));
 		/* CP and shaders */
 		WREG32_SOC15(GC, GET_INST(GC, xcc_id),
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index a1e00be54005d..fa209fd6d4ac9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -1938,7 +1938,7 @@ static void gfx_v7_0_constants_init(struct amdgpu_device *adev)
 	WREG32(mmSH_STATIC_MEM_CONFIG, sh_static_mem_cfg);
 
 	mutex_lock(&adev->srbm_mutex);
-	for (i = 0; i < adev->vm_manager.id_mgr[0].num_ids; i++) {
+	for_each_vmid_and_zero(i, adev, 0) {
 		if (i == 0)
 			sh_mem_base = 0;
 		else
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index f7c2b149acd0a..4c79e594cf8be 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -3758,7 +3758,7 @@ static void gfx_v8_0_constants_init(struct amdgpu_device *adev)
 	WREG32(mmSH_STATIC_MEM_CONFIG, sh_static_mem_cfg);
 
 	mutex_lock(&adev->srbm_mutex);
-	for (i = 0; i < adev->vm_manager.id_mgr[0].num_ids; i++) {
+	for_each_vmid_and_zero(i, adev, 0) {
 		vi_srbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
 		if (i == 0) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index a4365e26120a5..c220a1cea7d73 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2682,7 +2682,7 @@ static void gfx_v9_0_constants_init(struct amdgpu_device *adev)
 	/* XXX SH_MEM regs */
 	/* where to put LDS, scratch, GPUVM in FSA64 space */
 	mutex_lock(&adev->srbm_mutex);
-	for (i = 0; i < adev->vm_manager.id_mgr[AMDGPU_GFXHUB(0)].num_ids; i++) {
+	for_each_vmid_and_zero(i, adev, AMDGPU_GFXHUB(0)) {
 		soc15_grbm_select(adev, 0, 0, 0, i, 0);
 		/* CP and shaders */
 		if (i == 0) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 99732056c58f6..4a7e7e1500300 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1237,7 +1237,7 @@ static void gfx_v9_4_3_xcc_constants_init(struct amdgpu_device *adev,
 	/* XXX SH_MEM regs */
 	/* where to put LDS, scratch, GPUVM in FSA64 space */
 	mutex_lock(&adev->srbm_mutex);
-	for (i = 0; i < adev->vm_manager.id_mgr[AMDGPU_GFXHUB(0)].num_ids; i++) {
+	for_each_vmid_and_zero(i, adev, AMDGPU_GFXHUB(0)) {
 		soc15_grbm_select(adev, 0, 0, 0, i, GET_INST(GC, xcc_id));
 		/* CP and shaders */
 		if (i == 0) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 75a552782c979..9a8a7921ce982 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -869,6 +869,10 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdkfd will use VMIDs 8-15
 	 */
 	adev->vm_manager.first_kfd_vmid = 8;
+	amdgpu_vmid_mgr_set_vmid_mask(adev,
+				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
+				      false);
+	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(AMDGPU_NUM_VMID - 1, 1), true);
 
 	amdgpu_vm_manager_init(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index f454aff831b03..ed75da48ce963 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -852,6 +852,11 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 */
 	adev->vm_manager.first_kfd_vmid = adev->gfx.disable_kq ? 1 : 8;
 
+	amdgpu_vmid_mgr_set_vmid_mask(adev,
+				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
+				      false);
+	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(AMDGPU_NUM_VMID - 1, 1), true);
+
 	amdgpu_vm_manager_init(adev);
 
 	r = amdgpu_gmc_ras_sw_init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 3add79c474f3b..cc4eb05215ea1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -952,13 +952,17 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * number of VMs
 	 * VMID 0 is reserved for System
 	 * amdgpu graphics/compute will use VMIDs 1-7
-	 * amdkfd will use VMIDs 8-15
+	 * amdkfd will use VMIDs 8-15.
+	 * On GFX 12.1, amdkfd will use VMIDs 3-15.
 	 */
 	adev->vm_manager.first_kfd_vmid =
-		 amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0) ?
-		3 : 8;
-	adev->vm_manager.first_kfd_vmid =
-		adev->gfx.disable_kq ? 1 : (adev->vm_manager.first_kfd_vmid);
+		adev->gfx.disable_kq ? 1 :
+		(amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0) ?
+		3 : 8);
+	amdgpu_vmid_mgr_set_vmid_mask(adev,
+				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
+				      false);
+	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(AMDGPU_NUM_VMID - 1, 1), true);
 
 	amdgpu_vm_manager_init(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index ca7afb9b7d0ae..cdd11587b12ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -864,6 +864,12 @@ static int gmc_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdkfd will use VMIDs 8-15
 	 */
 	adev->vm_manager.first_kfd_vmid = 8;
+	amdgpu_vmid_mgr_set_vmid_mask(adev,
+				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
+				      false);
+	amdgpu_vmid_mgr_set_vmid_mask(adev,
+				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
+				      true);
 	amdgpu_vm_manager_init(adev);
 
 	/* base offset of vram pages */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 1c1eccfe383fd..c9cc55e18893b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -1045,6 +1045,12 @@ static int gmc_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdkfd will use VMIDs 8-15
 	 */
 	adev->vm_manager.first_kfd_vmid = 8;
+	amdgpu_vmid_mgr_set_vmid_mask(adev,
+				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
+				      false);
+	amdgpu_vmid_mgr_set_vmid_mask(adev,
+				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
+				      true);
 	amdgpu_vm_manager_init(adev);
 
 	/* base offset of vram pages */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index bf089595e5dac..8d8a0775878ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1122,6 +1122,12 @@ static int gmc_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdkfd will use VMIDs 8-15
 	 */
 	adev->vm_manager.first_kfd_vmid = 8;
+	amdgpu_vmid_mgr_set_vmid_mask(adev,
+				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
+				      false);
+	amdgpu_vmid_mgr_set_vmid_mask(adev,
+				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
+				      true);
 	amdgpu_vm_manager_init(adev);
 
 	/* base offset of vram pages */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index b46b87291c512..633772fa71fda 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2038,6 +2038,12 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 			3 :
 			8;
 
+	amdgpu_vmid_mgr_set_vmid_mask(adev,
+				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
+				      false);
+	amdgpu_vmid_mgr_set_vmid_mask(adev,
+				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
+				      true);
 	amdgpu_vm_manager_init(adev);
 
 	gmc_v9_0_save_registers(adev);
-- 
2.55.0

