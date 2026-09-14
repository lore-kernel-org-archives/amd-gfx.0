Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9D2C88E72
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2026 13:07:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8FEB10EC7E;
	Mon, 14 Sep 2026 13:07:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h73JGyOe";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010040.outbound.protection.outlook.com
 [52.101.193.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5485A10EC7E
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 13:07:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vh9+4jZWIl6Pj8ddiJKGMXxVUtN9KSLrFdkjyHrOBV7yns0AL5RVSlqh8kQxa10acMQRxKuVdL7h6l7kZCqpzU6owLC7NXyvBUQUhfXp+nPEdvWZ8UEg4z7Gi2jGBztoaSNAeBPkFYX3qh4n9VXQD4Adngtbr/nagwGO0Q3QpDL2QRmVKbmRxWprO6tFpa0vgbvVADJVsVhPdCeuetyyNa1/5OyLwGTQXSeeBIm3ngT1huqhUHhxrc6uoEKQ9Bqz35Og2XcHNwSBhRD1gkkklzF6wxLag7Iez0SmJbprBCMH+Ji/S7iIiSr4Q5GREPdW5TEHsk6kJt6zAK7eItZiXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFpTTnd/l+iyCzaqQuyYDiC8HxF0aIuDekomdOxdWU0=;
 b=EoI0JAFY4xjE4jX3QYrEGk89+57L50U2J0GitAQ2RLTVQlHEf9uIef/I2fCRhdInEH/XaJoSJyFjd9jYwxK0q0E9+fs/qXOrQcLr/5FQ9epYoNKo/7Hmwz1WiKulHUp/4W0vdTPghwzf4nbQrE5DNiePKUqYsKVsH6E4QS5S53GQ/dm2X3ERut5vvE7aBhRhVVHThxwOInZoDfO6AsSSifrRf/1ZB1cwZNX5axL3mU5lJc02TW0S9GheZBmtdJWrChoGujLjI/CbmVJ3pjwZk5vHeUD7JS0mneA/U4+t4qP9agBtZ4XOJRNMkRxd2+G/Yg8HpOtPBILrum0ujXd3TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFpTTnd/l+iyCzaqQuyYDiC8HxF0aIuDekomdOxdWU0=;
 b=h73JGyOe3BlgkL2ScLP5lD1aT8PGehGsS6W+LQ7vJmcQAsprLeeVAr7UV1qlZrjW5VzFGSg/7YNLpxFc4gTTDE77ClYrXwOCNv5KJuDyaa9cpdOngRyeaNU1Gec+rPvlEgMwef9OSSpnEYQjKryx+LByzypvXlL9aPSM4khe+yo=
Received: from BLAPR03CA0114.namprd03.prod.outlook.com (2603:10b6:208:32a::29)
 by MW4PR12MB6753.namprd12.prod.outlook.com (2603:10b6:303:1ec::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 13:07:07 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:208:32a:cafe::3c) by BLAPR03CA0114.outlook.office365.com
 (2603:10b6:208:32a::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 13:07:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 13:07:06 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 08:07:04 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH RESEND 02/10] drm/amdgpu: keep the userq manager alive as long
 as its queues
Date: Mon, 14 Sep 2026 21:07:16 +0800
Message-ID: <20260914130724.130794-3-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914130724.130794-1-lingshan.zhu@amd.com>
References: <20260914130724.130794-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|MW4PR12MB6753:EE_
X-MS-Office365-Filtering-Correlation-Id: e1c9b2c7-b687-4e85-c736-08df126113c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: F4jSff4uW0BmN+Sb4ieD8eGuve1bDaAg28oVvThwMmxCbbFEr1Rf1k6pPW6xeRu6bFlEwL8DP9r1sR/o/O8uI0ml3y5ICG6vXGC5honqnR+JXpSi8L261hiaXtibGP9qL5X1HmrffiS2jZ6pcX8ZpzVbL5zbH0DnEHda3fGlbKbm3v+CKpTHGw95hC6nUiEHSrqTgrVmbwkZiTRiW/cQ51GcXc92Mk9V4cHpzOYXPlEslWrGULiwNHS5PdUwWhU2p17ii/5oxTGpTOLMPTfi2a4bcE9cxHlTkFEBBNgab+VxjOds3PYk4HEHw/LZyxRUQn0moaNIuOCIJyqR7mq2wMH5BUukQOAIVUUu3DhgNBmloBkepuW8FfjK4XINCxdnXodZmHsdV1CISXvfCrxVdz/VG3Zq9XTrMQ9hioZBXjWmcP1jTUKkIMC2XriOzyPKDArDU2lVZ4MRXatBZara9mO/puIh0hfG9IqGL8Y7RMxUoVeWN1aEP7nuHkc4s0gsepPPsWyQalwypJnBJJqAfN5LGnF0C5emfzkTRTmZ0lZjnVtXBaXtmgDpyxS1jfXp+Rkp3P31GLveqq2M0BxUTPHR2xGQ4q6X2bWFB4K/5I3HL+08yx4WKykgc6MHFfdixADbScb+EzeHCFh3xG2mffhUJCPmHmZxhctWvrDXILg3K35/ObTwg9mCcqXqM1RzAJ+43DsRA7IJ97s58LHarQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BlLj3LW/yPOINP1lUdt4kZBuajO53rnZoWnBrOklm4x1zd88vtzgRxlI7IUS5GYbHiX/1etg9W9+b9+iusV7fbTFw0PlqRgdUlmEPljsm5IzZXbK0WAUqwocDHzZ7hkqRRFvljKn34f8yJCdQznGcfB7vOhKMKkJuQaF5dwwKJ9+2sFyCnznZYpLZ8tHy0zN5xsU9a5CNb58nnGeGCISXZgmG9iQIRY/L6TZDXl7Om95DyI9fcMbgckWFNkRSGaEY1dcd9POkF/sV0UzTMNVn7cILoyF2Bz18KojHmOUmS/VuH+DgmKsbcGSW2vLfh7a/IxYEkGLukfUMINkms1OsMkhijVVbtzMFM46cd3wRAsJV0IwO4sm0MNceGyITHKUMn3iwCvq54hHdFDiRe2NkNdInwASrYRZnuz+ghkEJYPGeIRR6xu8e9X/EzJ2LHk5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 13:07:06.2588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c9b2c7-b687-4e85-c736-08df126113c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6753
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

The life cycle of a user queue is managed by its
kref. However when destroy a userq manager,
the kref_put of its queues in amdgpu_userq_mgr_fini
may not be the last put, therefore the queues
could be still alive after the userq manager
has been destroyed, resulting in
userq->userq_mgr use-after-free issues.

This commit fixes this problem by introduce a new
counter refs representing for the number of its queues,
and only free the userq_manager when refs == 0

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 30 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  9 +++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index e0639f844a8e..f398986a61a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -27,6 +27,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/overflow.h>
 #include <drm/drm_drv.h>
+#include <linux/wait_bit.h>
 
 #include "amdgpu.h"
 #include "amdgpu_reset.h"
@@ -533,6 +534,17 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
 	return r;
 }
 
+static void amdgpu_userq_mgr_inc_refs(struct amdgpu_userq_mgr *uq_mgr)
+{
+	atomic_inc(&uq_mgr->refs);
+}
+
+static void amdgpu_userq_mgr_dec_refs(struct amdgpu_userq_mgr *uq_mgr)
+{
+	if (atomic_dec_and_test(&uq_mgr->refs))
+		wake_up_var(&uq_mgr->refs);
+}
+
 static int
 amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
 {
@@ -594,6 +606,8 @@ static void amdgpu_userq_kref_destroy(struct kref *kref)
 	r = amdgpu_userq_destroy(uq_mgr, queue);
 	if (r)
 		drm_file_err(uq_mgr->file, "Failed to destroy usermode queue %d\n", r);
+
+	amdgpu_userq_mgr_dec_refs(uq_mgr);
 }
 
 struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid)
@@ -707,6 +721,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	queue->xcp_id = (fpriv->xcp_id != AMDGPU_XCP_NO_PARTITION) ?
 				fpriv->xcp_id : 0;
 	queue->userq_mgr = uq_mgr;
+	amdgpu_userq_mgr_inc_refs(uq_mgr);
 	INIT_DELAYED_WORK(&queue->hang_detect_work,
 			  amdgpu_userq_hang_detect_work);
 
@@ -819,6 +834,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 free_queue:
 	trace_amdgpu_userq_create_end(queue, r);
 	kfree(queue);
+	amdgpu_userq_mgr_dec_refs(uq_mgr);
 err_pm_runtime:
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 	return r;
@@ -1331,6 +1347,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
 {
 	mutex_init(&userq_mgr->userq_mutex);
 	xa_init_flags(&userq_mgr->userq_xa, XA_FLAGS_ALLOC);
+	atomic_set(&userq_mgr->refs, 0);
 	userq_mgr->adev = adev;
 	userq_mgr->file = file_priv;
 	userq_mgr->proc_ctx_allocated = false;
@@ -1380,6 +1397,19 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 		amdgpu_userq_put(queue);
 	}
 
+	/*
+	 * The above amdgpu_userq_put() may not be the last put
+	 * of the kref of a user queue, therefore there could
+	 * be some queues still alive even when the userq manager
+	 * has been destroyed. This wait_evet() blocks
+	 * amdgpu_userq_mgr_fini(), so keep userq_mgr alive
+	 * while any queues holding it.
+	 *
+	 * This prevents queue->userq_mgr use-after-free issues.
+	 */
+	wait_var_event(&userq_mgr->refs,
+		       !atomic_read_acquire(&userq_mgr->refs));
+
 	xa_destroy(&userq_mgr->userq_xa);
 
 	/*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 8fc73862f64e..a13d8d4dd5c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -126,6 +126,15 @@ struct amdgpu_userq_mgr {
 	 */
 	struct xarray			userq_xa;
 	struct mutex			userq_mutex;
+
+	/**
+	 * @refs:
+	 *
+	 * Each queue increases this counter when join this manager,
+	 * and decreases it when leave this manager.
+	 */
+	atomic_t			refs;
+
 	struct amdgpu_device		*adev;
 	struct delayed_work		resume_work;
 	struct drm_file			*file;
-- 
2.53.0

