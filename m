Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D63C0C5DF6D
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2026 11:43:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E2C110EE06;
	Wed, 19 Aug 2026 11:43:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="APwUDXGX";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011018.outbound.protection.outlook.com [52.101.57.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45F3810EE06
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2026 11:43:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TfTqAMLgF9S1y8pzyRVQ3fT4Cq2ZQiUdI18wjXAlW/6I78YmwZt+gsdRWsoBY0UOWhOB+8fgKcpuBZo27vHpFxsIGYtesWlmrzobbh0IzuI7scc2WtcLupFoaD/E/xFZ1+CjhszIPbTyDUC1WR3YxATSl8ZRPtesKJMBu5dYJcp1EBrTA0YH2+lKyDNbpeZ3TS7f5z3RIyHseO5ti06BJLfXUo+/jf/aC55lo69lsM0FX2zYDiej4mOzIqV/bC+n9kp7EQZNP6z9CYAFuXyxjP97IIBZGdqkruPHzUie+LZ4uWGXVTdqmeyj13O+q3l+ZO2D7pnCPy+Ypmv/9s4DUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIiMk9MZIy9gq8DqhqZdesyiRU8FuQAl/O8xGFkcvFU=;
 b=ah7zyJH4oC748MXSw0S/lzqgEzqzEMrojhcCNLr02DfscuPylcKHSSaz5IbmIGhJtysTRibvrXjSxr/dIV9JllV1lmbFQ2XREWu+N2t/WDqBOQVMCUCWhq8TvG1vWzHTDEU5Fst0pXtwJOUikAUv8pE1JuL6Mx0yK/FKvqLHBNHgRy3rS1LJYCe35XmEwI/GyfUvPII5oYM9cKCU4nvub2GM/PxHhznL28FCvlvAbi7AgmosJz27oUf+hoat1aMoCGqJJgqIiPmIF1ig0KDOhDzqRCM67NV1oi99I9EdCcGjLXt3dPY/pzDLg/aU0Y+midIC8oG2jk/YFrZ91oYIQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIiMk9MZIy9gq8DqhqZdesyiRU8FuQAl/O8xGFkcvFU=;
 b=APwUDXGXUiTu/goA6tUSj2vTKtkOMe5XxhKkg6InEI9N8LNqioe/ShbsL2bONOOvrx8LSDW4LCPY9toCJwP7oMQr6UfN5+n+23XwNurFHPA1uKL6XSxNPpMazGzjMPjeEXsNk/vOPbnp6o6+gwu/dFDiBWhEtJ2ulLQzKW2LBSE=
Received: from BN9PR03CA0601.namprd03.prod.outlook.com (2603:10b6:408:106::6)
 by PH8PR12MB6891.namprd12.prod.outlook.com (2603:10b6:510:1cb::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 19 Aug
 2026 11:42:57 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:408:106:cafe::5f) by BN9PR03CA0601.outlook.office365.com
 (2603:10b6:408:106::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Wed, 19
 Aug 2026 11:42:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Wed, 19 Aug 2026 11:42:56 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 06:42:52 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <felix.kuehling@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V2] drm/amdgpu: keep the userq manager alive as long as its
 queues
Date: Wed, 19 Aug 2026 19:43:02 +0800
Message-ID: <20260819114302.177921-1-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|PH8PR12MB6891:EE_
X-MS-Office365-Filtering-Correlation-Id: eef344dc-f103-42c3-0d35-08defde70319
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|10067099003|6133799003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: aDreO8G8yQVCaDeGN/cYCOLROLO5yNjWDQ+G7AYsHYE65VOpBf8mZ1Lm/x5qZTxN37VeqAAoiHMAJeDclrPYKV1owZw9S2F3mSsZS4/Lb7LGY7x2qKtDGZ1zrq6Nydlz5O3ZTsvneJCx8+yIbfx9xiMwEumoElRVINIGlow8YFFH4dzEbAG3COaU2pPF+AHuFiV/phnEQONl3M6YNwSbOjvtiYlUO9wNx2WiV9Pt/DxQgSC1vLmuPzz94uHNcMwnoVbblUWn7RztjrB9OrK1NPNU6CHlBnmqi/VqWDGf+hPAFM7K/hDc+avar6sESqTtjft0sDHaFE8+hUSxLtoBbmAmlHK7irJ/P5hn+c+LFmCLGGLLfXiWt11GkmF3QiGgUiRCsTWBn9bN5qQ+UcVF7R2a2KgFVuRQso8M8isBnYfGShfHjYBFJPyXTJAseNavvt2A8vl8atdse2f37fAIsMeIgo/Npj3gjEXyG6RTEjQg2D6SM7/FUh2A2bVO6hERZHivjkPc2sysXht2+z0tVt2zwgh7bVEa5CXlW92HnTg2kbWB0kSA3Fei7JC4698mp6vkPUiNs+wds8MfIqY7jqCSnjQG1vRtwk0JLgIZDu1d+QwOPQxG6v4XL+bvXOHpixFdR01Gwy6oNQMLrFbbmpELm8x398dZ/nck7JMR+KH4TH3oqHnU5dgZZtosth862rxH2OSnEUkGehKLkAujhw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(10067099003)(6133799003)(56012099006)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +qWqrpVJo/yBnT8V+vYL+cDVdQ72EXe8y0XRNzoOco+emRulrYBtJte7h995p4ACi1PQKpyRN7V0LybKJFUI/fjdDHny539lH0XeFrrPlcwaKVXoCMbG6v4mZP22xGNOrmhlLR20MY/EN1xVbocIOQKWJWZK8jsSNXSclX+B2ryjyQPAgWAj2vtICcBgubsEY/jzRTimK0rpJy55GkJTlbJ6aeL2AseIAKESfZjVuHB0D5DlKoW09BWeNBJwYjwiaHDaGu7WAeF2Qs90dDBAi54Q6bdJLormhym2q2IR3jFoe2Uj+2SDMGkMyvlpyKBCZMUiteeTNLaKc+xbpRYGSGc3bkwXkT/QIeIErkRK4UmMZDhRGRgLTKyhgtBkxIGCrxjFGkvecWTe2RxvwptrgfuFVMdNTmU0SY3XYioKj8nGYJKueVlLhV0jh9e3jd5R
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 11:42:56.3993 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eef344dc-f103-42c3-0d35-08defde70319
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6891
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

The userq manager is embedded in fpriv, so any code
paths trigger kfree(fpriv) would destroy the userq_mgr,
even some of its queues are still alive,
resulting in userq->userq_mgr use-after-free issues.

This commit fixes this problem by introduce a new
counter refs representing for the number of its queues,
and only free the userq_manager when refs == 0

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 28 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  9 ++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 24adad7be251..b7d1b973df6b 100644
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
@@ -677,6 +691,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	queue->xcp_id = (fpriv->xcp_id != AMDGPU_XCP_NO_PARTITION) ?
 				fpriv->xcp_id : 0;
 	queue->userq_mgr = uq_mgr;
+	amdgpu_userq_mgr_inc_refs(uq_mgr);
 	INIT_DELAYED_WORK(&queue->hang_detect_work,
 			  amdgpu_userq_hang_detect_work);
 
@@ -789,6 +804,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 free_queue:
 	trace_amdgpu_userq_create_end(queue, r);
 	kfree(queue);
+	amdgpu_userq_mgr_dec_refs(uq_mgr);
 err_pm_runtime:
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 	return r;
@@ -1277,6 +1293,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
 {
 	mutex_init(&userq_mgr->userq_mutex);
 	xa_init_flags(&userq_mgr->userq_xa, XA_FLAGS_ALLOC);
+	atomic_set(&userq_mgr->refs, 0);
 	userq_mgr->adev = adev;
 	userq_mgr->file = file_priv;
 	userq_mgr->proc_ctx_allocated = false;
@@ -1326,6 +1343,17 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 		amdgpu_userq_put(queue);
 	}
 
+	/*
+	 * userq_mgr is embedded in struct amdgpu_fpriv and get
+	 * freed when kfree(fpriv). This wait_evet() blocks
+	 * amdgpu_userq_mgr_fini() which is drm_release path,
+	 * so keep userq_mgr alive while any queues holding it.
+	 *
+	 * This prevents queue->userq_mgr use-after-free issues.
+	 */
+	wait_var_event(&userq_mgr->refs,
+		       !atomic_read_acquire(&userq_mgr->refs));
+
 	xa_destroy(&userq_mgr->userq_xa);
 
 	/*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 6412a7f7b6ef..e65426410cba 100644
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

