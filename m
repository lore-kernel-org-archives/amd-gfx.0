Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2909C5DF7E
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 11:57:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4450410E4B8;
	Tue, 18 Aug 2026 11:57:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="426ioQvp";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012024.outbound.protection.outlook.com [40.107.209.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DF9010E4B8
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 11:57:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fugTnl2A/PZb9sRa0mLHC+EJR9qwqOYupf5nqNc0dbWVmxveapqJWD8a5L6oLYlctnSAmAIesVGnSm2ElFltbL4VyZ3+kmM/QL7IV7lOIu58zTp3bG2kkfU8WbdhyE0n5KteutkbhdgGYzxVUbhlM1L+725uu3wDSG6zMSgAXHrfjoMwofy89JiQ7zg9SEpU1f/NzbFocUSIWPRbPDqE5AS/KIiVWnZe9KMMo+v1H6HC+1/bPJkePh8h+SoAyNGLwXC4r21AYSIrfPcvUDe7a3zwbTXmORYJnQXO6D3uV4w50AvyX6BMXPuPP2XXyuKUVKwx9x+WtjqsfzggrYwsfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bh7qkudzdselXjx14aRskF6pWKQ6VxnHAf7HTBZ4cl0=;
 b=Vn4dH7XfcEqdMwdCHK4XJ8tGxYb5HY9dnfHQUGnJKXjMPKPmsAYs1PIM1pGHma74a9KVeIA7jT2Kqv6A+GjpEHRJQJXjSNMNzRB1Utt123N6v34QZ2GPZebOL5OG0oqMGQenj1F4T8qdJBeElizGEybqaL8NRDDTM5hN0Y1b4BXgirHL3yif75hEU918po5YhBFlufA3q4a/7VcQpQNP+GKgH+zYCWa+hcGDXfQuAlwklchKhfRRQbyAP6PF2DcTDjFZtEh/w8NNervRBA4YKoLr10gQioAApJr/PsCUUnDBllSZJN/CrZjes4ue3ZwWSbrRlKU3v4xifVXNeVj9uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bh7qkudzdselXjx14aRskF6pWKQ6VxnHAf7HTBZ4cl0=;
 b=426ioQvp5x/B7TfjvFdvpGy3GDQmYZKZ0e5pBafsTVtgvWOzT0bpp8zl9F3PtC8Ql4eG1CJw2Znly6+hXoZLghIeqygLyODLbvoAnHpucqeixFuPsbNFToJuJvgOmN8jN5DQXaiVqwgHRgWta8I7zek4cKnIzzQRupT2Q3DNk8k=
Received: from DS1PR06CA0022.namprd06.prod.outlook.com (2603:10b6:8:23e::9) by
 IA0PR12MB8421.namprd12.prod.outlook.com (2603:10b6:208:40f::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.17; Tue, 18 Aug 2026 11:57:48 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:8:23e:cafe::aa) by DS1PR06CA0022.outlook.office365.com
 (2603:10b6:8:23e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 11:57:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 11:57:47 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 06:57:45 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <felix.kuehling@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH] drm/amdgpu: keep the userq manager alive as long as its queues
Date: Tue, 18 Aug 2026 19:57:53 +0800
Message-ID: <20260818115753.127358-1-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|IA0PR12MB8421:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eef7551-3aac-42c9-f2ea-08defd1fec19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: ZhYmG4GV/86DsyL1jjirAm9dlKm9PlA2zJkggnzgO5NmpJWWXD8GgG++wyGlrQGCAhdUvixQ0+ENmOUwPpDvWtFogZG/eMogljcNgG5Tiga2W2+2TMy4PLweyuVITT6ilvwjYVo3wOdUQXBsgPEPYT37e6f1SjmlwNFNOtTKpOALTpu/OKYyxw5H+1hJG1SyQdHEaT3s0TfNubHzvUuEp/7vjrUW6+6C/dK6f5BjYfbdNS5/0Um1j4CaVYElvEoq7Axwec9ajGHrDG7YEBeMWCLUuG8zlDwr7oGgPknbEekQtgugsd5x2pTv8QuDYZ4ZtxXlxUMiTfwN2s3MsEHBN6HBNZmRTpLTiT2G/psmIs2LmKtcmqItjUKhJYj8wDXmMpdyzdgcxOlfWEqwwOJHJf6ij1+Uh6UNkav/sMSpvYIYYpNATMCS3OiwU3clt9NN06cSJdmniHj94LIrcj6sB1uRKiSFQTLzgIwqRdhfQ++zCFc1PXsJJZV5dArODLbumC1sQYn8JoxPlyL2JPFKhD7fekoGccMlt+fl6LibU1bRpRs8D1386qsv/GwtkHYxz5f1z9LaoFtj+nu9tYIEgWyRiOtLAQ1GLTNzSH76u97C5QiF2wXj3J3ErR2bqAWpmCKRpIjGKAmSKY0/Drf8jOF3nUS3t498G/opQVkLYp8MwbHaMMTsuK4chAFxSzq41rMiJOeD9XpAHti98lFhBQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tGCF42EdzHOlwu/U6SwmLwhKHK+sqecUpVpxctgoeJX+EjTHGykhiLuNRr6DQyXEnezXsAJp63YurQdA5N46OW5KZP6TpBoyM6Qx+tpulO9J7AngEZjhf4/rTvqcaKfwNBRa3dgwl4opr6Ac2sWq2GnAFz9KwjRno7fVpDpZGOPvsXvmWqeYfP+if2joEki6frA8/a8XDhF+N4bnCjp+RU7rHeMMW1FLrb7sxwl1AfbZAXmb7EDc2OHqCbUduKhAGK4S0n2sSLPosTMp/uUSPPjfgAikLPTf501G5b2PjLDKpasBjtAaTkp1IPJtWOMjbmN/eJ8p3lFwzms/PNTXxjMn7GNwVDiVPQ6AL0tELnKSRDdUbkIlHDRwwdnab4NR9blpN+KEssrW0v8ylxWq91AIbKp3V7sARVeMhrwUPIS1ltbN2U6R/vfzJM9P6SwA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 11:57:47.9392 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eef7551-3aac-42c9-f2ea-08defd1fec19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8421
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
resuting in userq->userq_mgr use-after-free issues.

This commit fixes this problem by introduce a new
counter refs representing for the number of its queues,
and only free the userq_manager when refs == 0

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 27 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 19 ++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 24adad7be251..434384b53b85 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -533,6 +533,17 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
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
+		wake_up(&uq_mgr->refs_wq);
+}
+
 static int
 amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
 {
@@ -594,6 +605,8 @@ static void amdgpu_userq_kref_destroy(struct kref *kref)
 	r = amdgpu_userq_destroy(uq_mgr, queue);
 	if (r)
 		drm_file_err(uq_mgr->file, "Failed to destroy usermode queue %d\n", r);
+
+	amdgpu_userq_mgr_dec_refs(uq_mgr);
 }
 
 struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid)
@@ -677,6 +690,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	queue->xcp_id = (fpriv->xcp_id != AMDGPU_XCP_NO_PARTITION) ?
 				fpriv->xcp_id : 0;
 	queue->userq_mgr = uq_mgr;
+	amdgpu_userq_mgr_inc_refs(uq_mgr);
 	INIT_DELAYED_WORK(&queue->hang_detect_work,
 			  amdgpu_userq_hang_detect_work);
 
@@ -789,6 +803,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 free_queue:
 	trace_amdgpu_userq_create_end(queue, r);
 	kfree(queue);
+	amdgpu_userq_mgr_dec_refs(uq_mgr);
 err_pm_runtime:
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 	return r;
@@ -1277,6 +1292,8 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
 {
 	mutex_init(&userq_mgr->userq_mutex);
 	xa_init_flags(&userq_mgr->userq_xa, XA_FLAGS_ALLOC);
+	atomic_set(&userq_mgr->refs, 0);
+	init_waitqueue_head(&userq_mgr->refs_wq);
 	userq_mgr->adev = adev;
 	userq_mgr->file = file_priv;
 	userq_mgr->proc_ctx_allocated = false;
@@ -1326,6 +1343,16 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
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
+	wait_event(userq_mgr->refs_wq, !atomic_read(&userq_mgr->refs));
+
 	xa_destroy(&userq_mgr->userq_xa);
 
 	/*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 6412a7f7b6ef..7141383ea2ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -24,6 +24,8 @@
 
 #ifndef AMDGPU_USERQ_H_
 #define AMDGPU_USERQ_H_
+#include <linux/wait.h>
+
 #include "amdgpu_eviction_fence.h"
 
 #define AMDGPU_MAX_USERQ_COUNT 512
@@ -126,6 +128,23 @@ struct amdgpu_userq_mgr {
 	 */
 	struct xarray			userq_xa;
 	struct mutex			userq_mutex;
+
+	/**
+	 * @refs:
+	 *
+	 * Each queue increase this counter when join this manager,
+	 * and decreash this counter when leave this manager.
+	 */
+	atomic_t			refs;
+
+	/**
+	 * @refs_wq:
+	 *
+	 * Waited on by amdgpu_userq_mgr_fini() until @refs drops to zero.
+	 * This wait prevents userq->userq_mgr UAF
+	 */
+	wait_queue_head_t		refs_wq;
+
 	struct amdgpu_device		*adev;
 	struct delayed_work		resume_work;
 	struct drm_file			*file;
-- 
2.53.0

