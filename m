Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD96C61DB9
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 09:53:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AAE410E367;
	Fri, 28 Aug 2026 09:53:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VoQyFX3h";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013018.outbound.protection.outlook.com
 [40.107.201.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BB3510E367
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 09:53:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+frNojqUtWuOxOqyRV5DEZMMWPLyeY1rI8HpXjUmreyB7YIF1bTnTe92Rc9cRDGRsd5In8wefBZBTdpv5MLdXShUma/VtQ4bKiJGHlz7YveFWWW/0HeOT0WEYgFojyvIjsbiL6qW4TImi6elsy+Vd25+Vr06GNnY59N6r+WlEs8H8aXTUkSQAyhVI2LKgaOpJ+oTbIeRP0ptEA5F/oX4WOFcQYHD0ZZKGSPazjbILODI5gY7N+8DDqSv/5Tr2lX9q2v6dabMOYGXZYcKNaGWVmBlPK63G4JqqaVkulpllSmbZsOr1H8C6ZWjaj/myhWdHqTlSB3CodveoXr3IVh3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFpTTnd/l+iyCzaqQuyYDiC8HxF0aIuDekomdOxdWU0=;
 b=knIjnbdjFHq2xBSxbX40LlCwc5OQ/gDe32b4XHJMeOK+dSwikRWY9TiUkPOVNhJFAlt8qwXFisf6NUZRgBJhf/+jKA06yxS6qWE2XdR2/2LXfHepQh1T8mJ3lsfI0vncdOYC5pm8UuH4lEAxfoFJySTokkLvW4RqydsJcH1whLsgIi9oh7TwvJWUU0GL02OP2MOPQQ1zq/O0UwSfSrFV/KjxhZWFz/zgxkvt/CfrvIYWyOzZJZciPnhnPiWiFxaO9pMiEo4HkyQiTwL3+5dv4Rd3n2nFnMwJNU6GADiDGTKIengeSNMRABInbAYwOZ44nS7C6/7qbGuMOU0Pw1zl7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFpTTnd/l+iyCzaqQuyYDiC8HxF0aIuDekomdOxdWU0=;
 b=VoQyFX3hUkvsZYXw9h59SpGGZFlTZNEnubrya8mVF7dipoJn90TnMJuXDaQi7OkvChuXsG98bgSlxl6mn1HAnSRSS4RsjKFLYmDGoKKTuetH/9/az6huXyQZZQJfWM+mcXDc9PZQ2RA9Rj1xFYET76M0eELMIaXwhC22EUuEWmw=
Received: from DS1P221CA0021.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:242::12) by
 MW4PR12MB7014.namprd12.prod.outlook.com (2603:10b6:303:218::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.11; Fri, 28 Aug 2026 09:53:45 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:8:242:cafe::7a) by DS1P221CA0021.outlook.office365.com
 (2603:10b6:8:242::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.11 via Frontend Transport; Fri,
 28 Aug 2026 09:53:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 28 Aug 2026 09:53:44 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 28 Aug
 2026 04:53:41 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <felix.kuehling@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH 02/10] drm/amdgpu: keep the userq manager alive as long as its
 queues
Date: Fri, 28 Aug 2026 17:53:41 +0800
Message-ID: <20260828095349.9797-3-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828095349.9797-1-lingshan.zhu@amd.com>
References: <20260828095349.9797-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|MW4PR12MB7014:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b77b3ef-f7a4-4238-9f8b-08df04ea3f62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: HI3/h4WdSCXWkBWCWL5tKL59PUC2bRKTARY+BQ9y/fRPYw61Gr7BMjaWSGNEjELAxBy1DaHKTobYqfV6UksYbs94IQus+BdepD2bMaTXOPkLhSDyjtr3NAR3B69T3U2CMkRz/IWMihU65hmdyjDhripJe6EdQhEc2KVj9RT/pU0hQ1VtMzo8mYZrHOfIaSiikXA57S+8VgNy8EVluRl8P5aar1JCrRdE21QhhSdB+yim/BTEQV4isbEA+qj7uvvtBxpXrDk7rAuboTTKF8D5Naj6q/BGMN4ZnHBeo4OssfGrfEBwBDMFEy56aIpR7p0KR0YTAS8vaH2Zg+hgXxzygk73XNBTX6pXkTo3vHi5VCWgTIghCEJqPvQC40tv+sbiYu1oT4QsGKxkvZT6F77YopwbX8s3+3kIQwVc6R4ynqPFef5sLkh/9i+Z3d8vK+QSs6y59nXvSheeeHjzxXYoCDkT0v1RHb6YfvBK7wt6vJ2GTd7vaTrntJI3cKv20JGcFvFxIJngK/NS8NBIcdfERyrSOkwlpwjeQSHdHpkuCO1RL41rM+5EzR8o2fWGxUuqTw1TzXvxuPGLy2fayvOLlTiIx/bcEx75/m+Sv2MAPoLCI5I/SlJge3dky6P/QcIQbeX6CkEPcg7t5NdL0KUFdu2Nm1xw5OaBe+f7Pq30m5xCiQf2MzKI7JXrgmi3S3JoVDRC9X1RfybE0aU1ArtLmg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ib2qjjB7lBjFIQS23je5DswrEnK5LcCVEnrrk+0wcHteIZV9UrtbpEra2KeJqY+KgQdD3oCjexak5MXH6+JkSeVMBPKHKy8ghd/XNgQ4FBpK0BC/YdF55tW0sN5VyI6OaVboApuSEMmv0GcawubKq0YsGRn5x1Yo+ztJMHGXYdOYYI5PQGX8uw93beAFWnRv1gBSMSf55k4pS0TshtsjlMwncff58wob5rvXL6dyLnQHufbh0p/T//pB/7vspeO2fdkKM0ZqZtI5lo6Jygy3DbMfBC9quXMvvo4cW5Gc1KnXulDboah3t1Ve0snykd19LO5DEIttRkSdhO5elfiJ1nkNw2NyPKXNrm67WxGjMAR2SThbSpmw3YylSjEgPFUMbA6eYBdK8uUPoF5JKyNlHrPHXee2SG/vty+YNLb5eIIcadsoHupjQuBIPA57uygn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 09:53:44.1435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b77b3ef-f7a4-4238-9f8b-08df04ea3f62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7014
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

