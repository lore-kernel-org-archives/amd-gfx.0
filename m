Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A70F4C369C2
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 22:21:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2408610E9D3;
	Wed, 16 Apr 2025 22:21:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ThpIsGQ2";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C43010E9CE
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 22:21:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OM7LXdFiuhKpFVzDs2tQ+Xzslq6qZD7MCKhpgLsXE5KJs9l61ItNqFLhIIYTnRUqzq3b3p7/VMtTh+XbqtZ/9GWp3YETpVeFvRsFkFPieQ2EdUTHkIfE3uHJgTFtRZXiOM/bOCEUZdVwXiM4IBGV+jW37sDsblI9ZLmJUWC4LSH5eZJENJjXvp5Dr9cszpg0aEACO39VIzXzBiRNless0HDgsALPuOpIGhqbIwGEDmCURr2QyOOnMzkVh0pb5ll5IbhBazHHPTpGOXNJmOWcp+jvZThzu4MaX/kZdV65zPWnHy1WhSDRzQAe2pKSHkeJgiD5rfP8aqZLuwnlac/Bhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZlHku2MU1nvUs93U8DiTtgkADEmTp6OH2OXHffjdLDQ=;
 b=w5YOcQGH6G7ZQOWy4iXE8+N1fRJARv77oHS2EBU0aJZ4c2jzzbaKdy7C/4KkP3wNtPi+x5CMH8V8BvBbYfScst/s7AB2wgHhFO+waV5t+PNE46GSQSIMS9eF2jDlxcTWdzOolqz2fyOrbUxQshB59f9SH+y/hwwTav2Kh+NcePHNjQD9UbRezFF28xK3nidOeuISTEs/HDl9KiqQ23wc0T3HVyZC3lM2t9lnC3/TI6z8XcQ2w2EQl2WdCqk0vvG4+Lyc3oarMkQqJ6Hl8mMh73t6yVY8OMNeVqcPG1a120vA/IXzFN6daKiloDa4Oeo2BvyxsiX+fzEVYChgr5KMbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlHku2MU1nvUs93U8DiTtgkADEmTp6OH2OXHffjdLDQ=;
 b=ThpIsGQ2F1YRtjWwZr4+DVTo6MS7dIhvFXSrqgpBi0MNUAifJLWXmPFKImCYrfJw4Tl6hSXEDYpmZccag5TZJnbuYkL4XlCYfOT0KfBdXL7Cmk+9hA1M4X3zvHVTVCvxIkmdWEg96+Z++F+/7N2jCXTk2ReS2j6N0Trb3EAsILc=
Received: from BN9PR03CA0277.namprd03.prod.outlook.com (2603:10b6:408:f5::12)
 by IA1PR12MB8359.namprd12.prod.outlook.com (2603:10b6:208:3fc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Wed, 16 Apr
 2025 22:21:05 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:408:f5:cafe::5a) by BN9PR03CA0277.outlook.office365.com
 (2603:10b6:408:f5::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.33 via Frontend Transport; Wed,
 16 Apr 2025 22:21:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 16 Apr 2025 22:21:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Apr
 2025 17:21:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 7/7] drm/amdgpu/userq: use consistent function naming
Date: Wed, 16 Apr 2025 18:20:46 -0400
Message-ID: <20250416222046.1142257-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416222046.1142257-1-alexander.deucher@amd.com>
References: <20250416222046.1142257-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|IA1PR12MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: 785387fb-eb79-4d32-fbbe-08dd7d34fa68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?igW9dQIP5ow4Efb3AnEtnqN9dbh/09GztontkqK9APJNKf5Vk3clCBldKYr7?=
 =?us-ascii?Q?MKfODXQTfqVFZ5hRqSET+4NPI/gyQElany6BGrnn1vGrH2IKS5NHKko3Oafq?=
 =?us-ascii?Q?g/85q7f7bjnL8rZ8JRUIDGVFg1wCcu4wTajd7t5fQeJiSOJmNAezk7iPjwg1?=
 =?us-ascii?Q?XjPHNQKE3CoIsqPlhkS+6DeT16ieheGhS8+SHXdu10/JxeCVJ60nX6RZXkgr?=
 =?us-ascii?Q?8DY1Gq9el4RcSWsYsQgLOx+a03vsI8VQRkXYMXB/BRGi9fC8ISEPXk8FVhw0?=
 =?us-ascii?Q?QxP5KLhv1CShmaXZ3QlGyPQUEZcTGh5gBZ9+yMQ3fHSBf2vQXkzz1h+nKwgX?=
 =?us-ascii?Q?aiaL8hveUYjLfMbbGb7rtRKy1TXAPxB8OKckUd7PwVy4LQbHn1Z41b3pzv91?=
 =?us-ascii?Q?+sui7yodySNT8/938xRYW9C/ywMB1gS+ipBhWrLm1NSQ9JKWb4f9npzzaAfR?=
 =?us-ascii?Q?NAU58toRdboniQClbaZCsFLevq1API0hdU0qIfv56duKhKt5hI3q1vx0YkmO?=
 =?us-ascii?Q?yCQX33FEyRsaSCe74lieWEX7m6nkxmPyXS6gdnmp5hl71Te3voKvcLdIvboZ?=
 =?us-ascii?Q?90iNFmo+0avc/IqeQ2z4MYd6WVTWLRbm9qLaP0G5hIfXQ02ik/irf63ucZWE?=
 =?us-ascii?Q?T4elSq8nhEVgKzli8mGysSuNpLNHcdTl0JKLgatNt47hRf0pEclGGZ8kLY9P?=
 =?us-ascii?Q?kf6pAEHrztvGHFXAiA/QXlw7tJ9P21kQGS+sffHu2arAWufF2saV08YERlN3?=
 =?us-ascii?Q?QhU8mE2xA7Ygfk2iJxn7R3yWum0dZn6oDFUueiZkCxhVOGpOUVdaICpC0fEE?=
 =?us-ascii?Q?0fx4IboWUjJAGefaP5cO7iPc05QpGDKINYcun4e2ZEDJRZAFrFu1gZI7TFyY?=
 =?us-ascii?Q?/HH4iYBgF2ZnoPWte/JAu6WdlT5KPbzwBASBFXOrLYBth/XSsd2bX/xgNm1n?=
 =?us-ascii?Q?16o9EWOCh6qylktjcontwGRVGMEarxk1S0R9WjYCIhl1zl1IfSIKOLv2Ys6M?=
 =?us-ascii?Q?hZoLbQ7qzjn8wXSh3qNTDpvpMjTiALV4RT4khvYhL1TJOvdnqqHfFAwNDJ1g?=
 =?us-ascii?Q?pCEN5Kx8TsP3VLG/i/03aJU7JzEbV4wJ2LHnA1I/YzlDKoHk55JTOkEQ8qgy?=
 =?us-ascii?Q?2u/YbOiC/aCYRB8gZhsGFec/2/68Bqh5L6m076jZjcOfPAvfGpCwqv7sW4n/?=
 =?us-ascii?Q?RggEJDrSQE64gOKnLIvymOqEuwG6J9x5yuM5pKIL/CFf70aKnf15VugRLaRt?=
 =?us-ascii?Q?OeXp41dcGL0OZqQ9j2+6eO/DJ8cC5d8TJmb6pE7e+8alvaf6RzVZRRu4GBcI?=
 =?us-ascii?Q?vd3j3U/CgIkPwcK7xseGYpyYXAoc4nEcleKk7jos+Z/SDiHiBO3ppQl4cC2t?=
 =?us-ascii?Q?3TdM+vpnaWM9rsnEMjObB0TQTRfDLMEzPll7Jq+hqgdZuaPKAF7KA8YIYPvN?=
 =?us-ascii?Q?GsOJ82RIMrimM5pe9je5pnBHVX3FmtSHNuO03fGtAaj07q3F+ofJ0ju9cSXp?=
 =?us-ascii?Q?XPAwZv3TUYgUFD/Qe0EDbbITMyg1ynG+nADC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 22:21:04.9121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 785387fb-eb79-4d32-fbbe-08dd7d34fa68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8359
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

s/userqueue/userq/

1. remove the mix of amdgpu_userqueue and amdgpu_userq
2. to be consistent with other amdgpu_userq_fence.c
3. it's shorter

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +-
 .../drm/amd/amdgpu/amdgpu_eviction_fence.c    |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   4 +-
 .../{amdgpu_userqueue.c => amdgpu_userq.c}    | 122 +++++++++---------
 .../{amdgpu_userqueue.h => amdgpu_userq.h}    |  34 ++---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |   4 +-
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |   2 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    |  12 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.h    |   2 +-
 11 files changed, 94 insertions(+), 94 deletions(-)
 rename drivers/gpu/drm/amd/amdgpu/{amdgpu_userqueue.c => amdgpu_userq.c} (86%)
 rename drivers/gpu/drm/amd/amdgpu/{amdgpu_userqueue.h => amdgpu_userq.h} (80%)

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 513c4d64f5542..8595e05c691b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -257,7 +257,7 @@ amdgpu-y += \
 amdgpu-y += amdgpu_amdkfd.o
 
 # add gfx usermode queue
-amdgpu-y += amdgpu_userqueue.o
+amdgpu-y += amdgpu_userq.o
 
 ifneq ($(CONFIG_HSA_AMD),)
 AMDKFD_PATH := ../amdkfd
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index decf66c2a7187..cc26cf1bd843e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -113,7 +113,7 @@
 #include "amdgpu_xcp.h"
 #include "amdgpu_seq64.h"
 #include "amdgpu_reg_state.h"
-#include "amdgpu_userqueue.h"
+#include "amdgpu_userq.h"
 #include "amdgpu_eviction_fence.h"
 #if defined(CONFIG_DRM_AMD_ISP)
 #include "amdgpu_isp.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index e24b0c730baf5..b9a1ef343c79c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -51,7 +51,7 @@
 #include "amdgpu_reset.h"
 #include "amdgpu_sched.h"
 #include "amdgpu_xgmi.h"
-#include "amdgpu_userqueue.h"
+#include "amdgpu_userq.h"
 #include "amdgpu_userq_fence.h"
 #include "../amdxcp/amdgpu_xcp_drv.h"
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index 02164bca51a7d..faa3f59b20c5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -112,7 +112,7 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
 	if (!ev_fence)
 		goto unlock;
 
-	amdgpu_userqueue_evict(uq_mgr, ev_fence);
+	amdgpu_userq_evict(uq_mgr, ev_fence);
 
 unlock:
 	mutex_unlock(&uq_mgr->userq_mutex);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 151366ecc0af6..8f992314c5a1e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -45,7 +45,7 @@
 #include "amdgpu_ras.h"
 #include "amdgpu_reset.h"
 #include "amd_pcie.h"
-#include "amdgpu_userqueue.h"
+#include "amdgpu_userq.h"
 
 void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
 {
@@ -1009,7 +1009,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			}
 		}
 
-		dev_info->userq_ip_mask = amdgpu_userqueue_get_supported_ip_mask(adev);
+		dev_info->userq_ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
 
 		ret = copy_to_user(out, dev_info,
 				   min((size_t)size, sizeof(*dev_info))) ? -EFAULT : 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
similarity index 86%
rename from drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
rename to drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index c7b215337d55a..cf5737b177b6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -28,10 +28,10 @@
 
 #include "amdgpu.h"
 #include "amdgpu_vm.h"
-#include "amdgpu_userqueue.h"
+#include "amdgpu_userq.h"
 #include "amdgpu_userq_fence.h"
 
-u32 amdgpu_userqueue_get_supported_ip_mask(struct amdgpu_device *adev)
+u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 {
 	int i;
 	u32 userq_ip_mask = 0;
@@ -45,8 +45,8 @@ u32 amdgpu_userqueue_get_supported_ip_mask(struct amdgpu_device *adev)
 }
 
 static int
-amdgpu_userqueue_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
-			      struct amdgpu_usermode_queue *queue)
+amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
+			  struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *userq_funcs =
@@ -64,8 +64,8 @@ amdgpu_userqueue_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
 }
 
 static int
-amdgpu_userqueue_map_helper(struct amdgpu_userq_mgr *uq_mgr,
-			    struct amdgpu_usermode_queue *queue)
+amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_mgr,
+			struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *userq_funcs =
@@ -84,8 +84,8 @@ amdgpu_userqueue_map_helper(struct amdgpu_userq_mgr *uq_mgr,
 }
 
 static void
-amdgpu_userqueue_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
-				     struct amdgpu_usermode_queue *queue)
+amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
+				 struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_device *adev = uq_mgr->adev;
 	struct dma_fence *f = queue->last_fence;
@@ -99,9 +99,9 @@ amdgpu_userqueue_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
 }
 
 static void
-amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
-			 struct amdgpu_usermode_queue *queue,
-			 int queue_id)
+amdgpu_userq_cleanup(struct amdgpu_userq_mgr *uq_mgr,
+		     struct amdgpu_usermode_queue *queue,
+		     int queue_id)
 {
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *uq_funcs = adev->userq_funcs[queue->queue_type];
@@ -114,7 +114,7 @@ amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
 }
 
 int
-amdgpu_userqueue_active(struct amdgpu_userq_mgr *uq_mgr)
+amdgpu_userq_active(struct amdgpu_userq_mgr *uq_mgr)
 {
 	struct amdgpu_usermode_queue *queue;
 	int queue_id;
@@ -131,14 +131,14 @@ amdgpu_userqueue_active(struct amdgpu_userq_mgr *uq_mgr)
 
 #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 static struct amdgpu_usermode_queue *
-amdgpu_userqueue_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
+amdgpu_userq_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
 {
 	return idr_find(&uq_mgr->userq_idr, qid);
 }
 
 void
-amdgpu_userqueue_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
-				 struct amdgpu_eviction_fence_mgr *evf_mgr)
+amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
+			     struct amdgpu_eviction_fence_mgr *evf_mgr)
 {
 	struct amdgpu_eviction_fence *ev_fence;
 
@@ -161,9 +161,9 @@ amdgpu_userqueue_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
 	}
 }
 
-int amdgpu_userqueue_create_object(struct amdgpu_userq_mgr *uq_mgr,
-				   struct amdgpu_userq_obj *userq_obj,
-				   int size)
+int amdgpu_userq_create_object(struct amdgpu_userq_mgr *uq_mgr,
+			       struct amdgpu_userq_obj *userq_obj,
+			       int size)
 {
 	struct amdgpu_device *adev = uq_mgr->adev;
 	struct amdgpu_bo_param bp;
@@ -216,17 +216,17 @@ int amdgpu_userqueue_create_object(struct amdgpu_userq_mgr *uq_mgr,
 	return r;
 }
 
-void amdgpu_userqueue_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
-				   struct amdgpu_userq_obj *userq_obj)
+void amdgpu_userq_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
+				 struct amdgpu_userq_obj *userq_obj)
 {
 	amdgpu_bo_kunmap(userq_obj->obj);
 	amdgpu_bo_unref(&userq_obj->obj);
 }
 
 uint64_t
-amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
-				     struct amdgpu_db_info *db_info,
-				     struct drm_file *filp)
+amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
+				struct amdgpu_db_info *db_info,
+				struct drm_file *filp)
 {
 	uint64_t index;
 	struct drm_gem_object *gobj;
@@ -293,7 +293,7 @@ amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
 }
 
 static int
-amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
+amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 {
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
@@ -304,17 +304,17 @@ amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
 	cancel_delayed_work(&uq_mgr->resume_work);
 	mutex_lock(&uq_mgr->userq_mutex);
 
-	queue = amdgpu_userqueue_find(uq_mgr, queue_id);
+	queue = amdgpu_userq_find(uq_mgr, queue_id);
 	if (!queue) {
 		DRM_DEBUG_DRIVER("Invalid queue id to destroy\n");
 		mutex_unlock(&uq_mgr->userq_mutex);
 		return -EINVAL;
 	}
-	amdgpu_userqueue_wait_for_last_fence(uq_mgr, queue);
-	r = amdgpu_userqueue_unmap_helper(uq_mgr, queue);
+	amdgpu_userq_wait_for_last_fence(uq_mgr, queue);
+	r = amdgpu_userq_unmap_helper(uq_mgr, queue);
 	amdgpu_bo_unpin(queue->db_obj.obj);
 	amdgpu_bo_unref(&queue->db_obj.obj);
-	amdgpu_userqueue_cleanup(uq_mgr, queue, queue_id);
+	amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
 	mutex_unlock(&uq_mgr->userq_mutex);
 
 	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
@@ -339,7 +339,7 @@ static int amdgpu_userq_priority_permit(struct drm_file *filp,
 }
 
 static int
-amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
+amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 {
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
@@ -388,7 +388,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	 *
 	 * This will also make sure we have a valid eviction fence ready to be used.
 	 */
-	amdgpu_userqueue_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
+	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
 
 	uq_funcs = adev->userq_funcs[args->in.ip_type];
 	if (!uq_funcs) {
@@ -414,7 +414,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	db_info.doorbell_offset = args->in.doorbell_offset;
 
 	/* Convert relative doorbell offset into absolute doorbell index */
-	index = amdgpu_userqueue_get_doorbell_index(uq_mgr, &db_info, filp);
+	index = amdgpu_userq_get_doorbell_index(uq_mgr, &db_info, filp);
 	if (index == (uint64_t)-EINVAL) {
 		DRM_ERROR("Failed to get doorbell for queue\n");
 		kfree(queue);
@@ -457,7 +457,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	else
 		skip_map_queue = false;
 	if (!skip_map_queue) {
-		r = amdgpu_userqueue_map_helper(uq_mgr, queue);
+		r = amdgpu_userq_map_helper(uq_mgr, queue);
 		if (r) {
 			mutex_unlock(&adev->userq_mutex);
 			DRM_ERROR("Failed to map Queue\n");
@@ -490,7 +490,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 		if (args->in.flags & ~(AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_MASK |
 				       AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE))
 			return -EINVAL;
-		r = amdgpu_userqueue_create(filp, args);
+		r = amdgpu_userq_create(filp, args);
 		if (r)
 			DRM_ERROR("Failed to create usermode queue\n");
 		break;
@@ -508,7 +508,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 		    args->in.mqd ||
 		    args->in.mqd_size)
 			return -EINVAL;
-		r = amdgpu_userqueue_destroy(filp, args->in.queue_id);
+		r = amdgpu_userq_destroy(filp, args->in.queue_id);
 		if (r)
 			DRM_ERROR("Failed to destroy usermode queue\n");
 		break;
@@ -529,7 +529,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 #endif
 
 static int
-amdgpu_userqueue_restore_all(struct amdgpu_userq_mgr *uq_mgr)
+amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 {
 	struct amdgpu_device *adev = uq_mgr->adev;
 	struct amdgpu_usermode_queue *queue;
@@ -538,7 +538,7 @@ amdgpu_userqueue_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 
 	/* Resume all the queues for this process */
 	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
-		r = amdgpu_userqueue_map_helper(uq_mgr, queue);
+		r = amdgpu_userq_map_helper(uq_mgr, queue);
 		if (r)
 			ret = r;
 	}
@@ -549,7 +549,7 @@ amdgpu_userqueue_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 }
 
 static int
-amdgpu_userqueue_validate_vm_bo(void *_unused, struct amdgpu_bo *bo)
+amdgpu_userq_validate_vm_bo(void *_unused, struct amdgpu_bo *bo)
 {
 	struct ttm_operation_ctx ctx = { false, false };
 	int ret;
@@ -564,7 +564,7 @@ amdgpu_userqueue_validate_vm_bo(void *_unused, struct amdgpu_bo *bo)
 }
 
 static int
-amdgpu_userqueue_validate_bos(struct amdgpu_userq_mgr *uq_mgr)
+amdgpu_userq_validate_bos(struct amdgpu_userq_mgr *uq_mgr)
 {
 	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
 	struct amdgpu_vm *vm = &fpriv->vm;
@@ -620,7 +620,7 @@ amdgpu_userqueue_validate_bos(struct amdgpu_userq_mgr *uq_mgr)
 		spin_unlock(&vm->status_lock);
 
 		bo = bo_va->base.bo;
-		ret = amdgpu_userqueue_validate_vm_bo(NULL, bo);
+		ret = amdgpu_userq_validate_vm_bo(NULL, bo);
 		if (ret) {
 			DRM_ERROR("Failed to validate BO\n");
 			goto unlock_all;
@@ -660,7 +660,7 @@ amdgpu_userqueue_validate_bos(struct amdgpu_userq_mgr *uq_mgr)
 	return ret;
 }
 
-static void amdgpu_userqueue_restore_worker(struct work_struct *work)
+static void amdgpu_userq_restore_worker(struct work_struct *work)
 {
 	struct amdgpu_userq_mgr *uq_mgr = work_to_uq_mgr(work, resume_work.work);
 	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
@@ -670,13 +670,13 @@ static void amdgpu_userqueue_restore_worker(struct work_struct *work)
 
 	mutex_lock(&uq_mgr->userq_mutex);
 
-	ret = amdgpu_userqueue_validate_bos(uq_mgr);
+	ret = amdgpu_userq_validate_bos(uq_mgr);
 	if (ret) {
 		DRM_ERROR("Failed to validate BOs to restore\n");
 		goto unlock;
 	}
 
-	ret = amdgpu_userqueue_restore_all(uq_mgr);
+	ret = amdgpu_userq_restore_all(uq_mgr);
 	if (ret) {
 		DRM_ERROR("Failed to resume all queues\n");
 		goto unlock;
@@ -687,7 +687,7 @@ static void amdgpu_userqueue_restore_worker(struct work_struct *work)
 }
 
 static int
-amdgpu_userqueue_evict_all(struct amdgpu_userq_mgr *uq_mgr)
+amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 {
 	struct amdgpu_device *adev = uq_mgr->adev;
 	struct amdgpu_usermode_queue *queue;
@@ -696,7 +696,7 @@ amdgpu_userqueue_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 
 	/* Try to unmap all the queues in this process ctx */
 	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
-		r = amdgpu_userqueue_unmap_helper(uq_mgr, queue);
+		r = amdgpu_userq_unmap_helper(uq_mgr, queue);
 		if (r)
 			ret = r;
 	}
@@ -707,7 +707,7 @@ amdgpu_userqueue_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 }
 
 static int
-amdgpu_userqueue_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
+amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
 {
 	struct amdgpu_usermode_queue *queue;
 	int queue_id, ret;
@@ -728,21 +728,21 @@ amdgpu_userqueue_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
 }
 
 void
-amdgpu_userqueue_evict(struct amdgpu_userq_mgr *uq_mgr,
-		       struct amdgpu_eviction_fence *ev_fence)
+amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
+		   struct amdgpu_eviction_fence *ev_fence)
 {
 	int ret;
 	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
 	struct amdgpu_eviction_fence_mgr *evf_mgr = &fpriv->evf_mgr;
 
 	/* Wait for any pending userqueue fence work to finish */
-	ret = amdgpu_userqueue_wait_for_signal(uq_mgr);
+	ret = amdgpu_userq_wait_for_signal(uq_mgr);
 	if (ret) {
 		DRM_ERROR("Not suspending userqueue, timeout waiting for work\n");
 		return;
 	}
 
-	ret = amdgpu_userqueue_evict_all(uq_mgr);
+	ret = amdgpu_userq_evict_all(uq_mgr);
 	if (ret) {
 		DRM_ERROR("Failed to evict userqueue\n");
 		return;
@@ -770,7 +770,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_devi
 	list_add(&userq_mgr->list, &adev->userq_mgr_list);
 	mutex_unlock(&adev->userq_mutex);
 
-	INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userqueue_restore_worker);
+	INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userq_restore_worker);
 	return 0;
 }
 
@@ -785,9 +785,9 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 
 	mutex_lock(&userq_mgr->userq_mutex);
 	idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
-		amdgpu_userqueue_wait_for_last_fence(userq_mgr, queue);
-		amdgpu_userqueue_unmap_helper(userq_mgr, queue);
-		amdgpu_userqueue_cleanup(userq_mgr, queue, queue_id);
+		amdgpu_userq_wait_for_last_fence(userq_mgr, queue);
+		amdgpu_userq_unmap_helper(userq_mgr, queue);
+		amdgpu_userq_cleanup(userq_mgr, queue, queue_id);
 	}
 	mutex_lock(&adev->userq_mutex);
 	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
@@ -804,7 +804,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 
 int amdgpu_userq_suspend(struct amdgpu_device *adev)
 {
-	u32 ip_mask = amdgpu_userqueue_get_supported_ip_mask(adev);
+	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
 	struct amdgpu_usermode_queue *queue;
 	struct amdgpu_userq_mgr *uqm, *tmp;
 	int queue_id;
@@ -817,7 +817,7 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
 	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
 		cancel_delayed_work_sync(&uqm->resume_work);
 		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
-			r = amdgpu_userqueue_unmap_helper(uqm, queue);
+			r = amdgpu_userq_unmap_helper(uqm, queue);
 			if (r)
 				ret = r;
 		}
@@ -828,7 +828,7 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
 
 int amdgpu_userq_resume(struct amdgpu_device *adev)
 {
-	u32 ip_mask = amdgpu_userqueue_get_supported_ip_mask(adev);
+	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
 	struct amdgpu_usermode_queue *queue;
 	struct amdgpu_userq_mgr *uqm, *tmp;
 	int queue_id;
@@ -840,7 +840,7 @@ int amdgpu_userq_resume(struct amdgpu_device *adev)
 	mutex_lock(&adev->userq_mutex);
 	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
 		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
-			r = amdgpu_userqueue_map_helper(uqm, queue);
+			r = amdgpu_userq_map_helper(uqm, queue);
 			if (r)
 				ret = r;
 		}
@@ -852,7 +852,7 @@ int amdgpu_userq_resume(struct amdgpu_device *adev)
 int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						  u32 idx)
 {
-	u32 ip_mask = amdgpu_userqueue_get_supported_ip_mask(adev);
+	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
 	struct amdgpu_usermode_queue *queue;
 	struct amdgpu_userq_mgr *uqm, *tmp;
 	int queue_id;
@@ -872,7 +872,7 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 			if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
 			     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
 			    (queue->xcp_id == idx)) {
-				r = amdgpu_userqueue_unmap_helper(uqm, queue);
+				r = amdgpu_userq_unmap_helper(uqm, queue);
 				if (r)
 					ret = r;
 			}
@@ -885,7 +885,7 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						   u32 idx)
 {
-	u32 ip_mask = amdgpu_userqueue_get_supported_ip_mask(adev);
+	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
 	struct amdgpu_usermode_queue *queue;
 	struct amdgpu_userq_mgr *uqm, *tmp;
 	int queue_id;
@@ -904,7 +904,7 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 			if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
 			     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
 			    (queue->xcp_id == idx)) {
-				r = amdgpu_userqueue_map_helper(uqm, queue);
+				r = amdgpu_userq_map_helper(uqm, queue);
 				if (r)
 					ret = r;
 			}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
similarity index 80%
rename from drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
rename to drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index a9f0e46bcec05..4d3eb651acf1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -22,8 +22,8 @@
  *
  */
 
-#ifndef AMDGPU_USERQUEUE_H_
-#define AMDGPU_USERQUEUE_H_
+#ifndef AMDGPU_USERQ_H_
+#define AMDGPU_USERQ_H_
 #include "amdgpu_eviction_fence.h"
 
 #define AMDGPU_MAX_USERQ_COUNT 512
@@ -32,7 +32,7 @@
 #define uq_mgr_to_fpriv(u) container_of(u, struct amdgpu_fpriv, userq_mgr)
 #define work_to_uq_mgr(w, name) container_of(w, struct amdgpu_userq_mgr, name)
 
-enum amdgpu_userqueue_state {
+enum amdgpu_userq_state {
 	AMDGPU_USERQ_STATE_UNMAPPED = 0,
 	AMDGPU_USERQ_STATE_MAPPED,
 	AMDGPU_USERQ_STATE_PREEMPTED,
@@ -49,7 +49,7 @@ struct amdgpu_userq_obj {
 
 struct amdgpu_usermode_queue {
 	int			queue_type;
-	enum amdgpu_userqueue_state state;
+	enum amdgpu_userq_state state;
 	uint64_t		doorbell_handle;
 	uint64_t		doorbell_index;
 	uint64_t		flags;
@@ -101,26 +101,26 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_devi
 
 void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
 
-int amdgpu_userqueue_create_object(struct amdgpu_userq_mgr *uq_mgr,
-				   struct amdgpu_userq_obj *userq_obj,
-				   int size);
+int amdgpu_userq_create_object(struct amdgpu_userq_mgr *uq_mgr,
+			       struct amdgpu_userq_obj *userq_obj,
+			       int size);
 
-void amdgpu_userqueue_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
-				     struct amdgpu_userq_obj *userq_obj);
+void amdgpu_userq_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
+				 struct amdgpu_userq_obj *userq_obj);
 
-void amdgpu_userqueue_evict(struct amdgpu_userq_mgr *uq_mgr,
-			    struct amdgpu_eviction_fence *ev_fence);
+void amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
+			struct amdgpu_eviction_fence *ev_fence);
 
-int amdgpu_userqueue_active(struct amdgpu_userq_mgr *uq_mgr);
+int amdgpu_userq_active(struct amdgpu_userq_mgr *uq_mgr);
 
-void amdgpu_userqueue_ensure_ev_fence(struct amdgpu_userq_mgr *userq_mgr,
-				      struct amdgpu_eviction_fence_mgr *evf_mgr);
+void amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *userq_mgr,
+				  struct amdgpu_eviction_fence_mgr *evf_mgr);
 
-uint64_t amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
-					     struct amdgpu_db_info *db_info,
+uint64_t amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
+					 struct amdgpu_db_info *db_info,
 					     struct drm_file *filp);
 
-u32 amdgpu_userqueue_get_supported_ip_mask(struct amdgpu_device *adev);
+u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev);
 
 int amdgpu_userq_suspend(struct amdgpu_device *adev);
 int amdgpu_userq_resume(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 0a3032e01c342..c622832fff755 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -293,7 +293,7 @@ static int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
 
 static const char *amdgpu_userq_fence_get_driver_name(struct dma_fence *f)
 {
-	return "amdgpu_userqueue_fence";
+	return "amdgpu_userq_fence";
 }
 
 static const char *amdgpu_userq_fence_get_timeline_name(struct dma_fence *f)
@@ -514,7 +514,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 		goto put_gobj_write;
 
 	/* We are here means UQ is active, make sure the eviction fence is valid */
-	amdgpu_userqueue_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
+	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
 
 	/* Create a new fence */
 	r = amdgpu_userq_fence_create(queue, userq_fence, wptr, &fence);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
index 7bbae238cca0b..527fb7f7299a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
@@ -27,7 +27,7 @@
 
 #include <linux/types.h>
 
-#include "amdgpu_userqueue.h"
+#include "amdgpu_userq.h"
 
 struct amdgpu_userq_fence {
 	struct dma_fence base;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 4c01c3a030956..d6f50b13e2ba0 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -189,7 +189,7 @@ static int mes_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
 	 * for the same.
 	 */
 	size = AMDGPU_USERQ_PROC_CTX_SZ + AMDGPU_USERQ_GANG_CTX_SZ;
-	r = amdgpu_userqueue_create_object(uq_mgr, ctx, size);
+	r = amdgpu_userq_create_object(uq_mgr, ctx, size);
 	if (r) {
 		DRM_ERROR("Failed to allocate ctx space bo for userqueue, err:%d\n", r);
 		return r;
@@ -222,7 +222,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		goto free_props;
 	}
 
-	r = amdgpu_userqueue_create_object(uq_mgr, &queue->mqd, mqd_hw_default->mqd_size);
+	r = amdgpu_userq_create_object(uq_mgr, &queue->mqd, mqd_hw_default->mqd_size);
 	if (r) {
 		DRM_ERROR("Failed to create MQD object for userqueue\n");
 		goto free_props;
@@ -327,10 +327,10 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 	return 0;
 
 free_ctx:
-	amdgpu_userqueue_destroy_object(uq_mgr, &queue->fw_obj);
+	amdgpu_userq_destroy_object(uq_mgr, &queue->fw_obj);
 
 free_mqd:
-	amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
+	amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
 
 free_props:
 	kfree(userq_props);
@@ -342,9 +342,9 @@ static void
 mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
 		      struct amdgpu_usermode_queue *queue)
 {
-	amdgpu_userqueue_destroy_object(uq_mgr, &queue->fw_obj);
+	amdgpu_userq_destroy_object(uq_mgr, &queue->fw_obj);
 	kfree(queue->userq_prop);
-	amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
+	amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
 }
 
 const struct amdgpu_userq_funcs userq_mes_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.h b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.h
index d0a521312ad4b..090ae88977705 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.h
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.h
@@ -24,7 +24,7 @@
 
 #ifndef MES_USERQ_H
 #define MES_USERQ_H
-#include "amdgpu_userqueue.h"
+#include "amdgpu_userq.h"
 
 extern const struct amdgpu_userq_funcs userq_mes_funcs;
 #endif
-- 
2.49.0

