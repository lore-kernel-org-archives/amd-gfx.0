Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7BF606A328
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 08:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=k0xQ+J5v
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6385A1123DC;
	Thu, 22 Oct 2026 08:21:03 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011036.outbound.protection.outlook.com [40.107.208.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03C041123DC
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 08:20:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9LFn0DbZluIRlGrQBHzaeICZu65u0TyFybLHkHWgcaWFIRUqYMCijBxqOnEEhpApZN4rraON824pHlOHFf+Yj/PbbD32CqT4xhSIakx8TscO0nlES9Vsc+CvI6UDZWeg3oPuLqneEtsnSw5S9zMZP/qoyqlGIi144VvaRHp77tBp8clE7MsdRruEnDUxIOLzPj8R0gkFDSJBTVuOG7UNkBx/pvGh2ZAbt81aalQQsDWcOzQC2h5byVpcA44aropWLU7enoACg8dIw3vDCFsq3JZawIAOLyH/tcQS/cZ0sFZD16Q8CsqzaLOiFDj0dNX2U75TSKVqB99Ago2AamxVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXEbrVzNi4wkwrV13z7yorTV9EThdsSVcNmx0a3pors=;
 b=Nqfd0MUkDFwrrZqbb+ysaP1DchAge9BF2Qx+hi0CydGu2EU1bpNaRRYxTu2E1BLKbIQ6qYTb93Kqfxj98RfFk2//3F8r9fMGWAMrca3sLhppJFqf1dyTx/naIZYo3Rq7HJYWwEo3+MN1NDZmU/LJ4+VfWvE2v0h/8BCzFvVUERcsje7FUYXAHdiEVYrQdnBz+n74IKOGo4xrO6LgRlpzLBHit+J/NqNwBZa3SnDmGGV6S6PFPEm0Z3X7D9KMZRfce1Lm8W3Qr6Bq0ajx/Z80Ya7rky0JQphf26Rcd/QL0HsMpwBVTubk9OEiuTO+1MHjaYC3qLgd597QeSLcByXakg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXEbrVzNi4wkwrV13z7yorTV9EThdsSVcNmx0a3pors=;
 b=k0xQ+J5v0mCniYSZO80SOJbIMSWdVgnOfTUE63N2Bw0XySRdOYgO6cYI7l3D2eUdV0aAUhNkQ6NOQG5UAWfTatd0WELN0KRhnJ4LsM19jVfgKi3GiTgPTzOgtW+E1WAY5e5WLvEku4xwVwUNu6/K64IIh5DEyOsaIMKI468+1eY=
Received: from BN1PR12CA0002.namprd12.prod.outlook.com (2603:10b6:408:e1::7)
 by LV3PR12MB9213.namprd12.prod.outlook.com (2603:10b6:408:1a6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Thu, 22 Oct
 2026 08:20:53 +0000
Received: from BN2PEPF0000A803.namprd02.prod.outlook.com
 (2603:10b6:408:e1:cafe::94) by BN1PR12CA0002.outlook.office365.com
 (2603:10b6:408:e1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Thu,
 22 Oct 2026 08:20:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A803.mail.protection.outlook.com (10.167.245.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 08:20:52 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 03:20:32 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 22 Oct 2026 03:20:30 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, <Mario.Novales@amd.com>, <Manu.Rastogi@amd.com>,
 <Jiongyu.Zhu@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2 07/15] drm/amdgpu/userq: add a helper to signal the fences
 of a queue up to a point
Date: Thu, 22 Oct 2026 16:19:47 +0800
Message-ID: <20261022082011.331462-7-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261022082011.331462-1-Jesse.Zhang@amd.com>
References: <20261022082011.331462-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A803:EE_|LV3PR12MB9213:EE_
X-MS-Office365-Filtering-Correlation-Id: d91e75c0-96f1-4999-768f-08df30156367
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|376014|82310400026|261021121427099003|56012099006|261009223027099003|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Y4e0Xig+nd2oIA53ohrbB76pXICoYj6oxL5haxaeW7+JMs0rUIIjnvkCrzjZCsnlrQ81rSzyUDeTZM5/vtanyoszjawLXpZGOiSTZ9eTJ3AeJ3yN9MIz9LWuQRDTuYUPAme+m1yBqGUMH2f4VjkaSymjy3jzP8ionFcl+rvGPsyPzoBDnL0mLoBu+yh1PO8QApbgC2U2jfsEYdHR87X5JNyBpgjDvmjq6pQ/p9aWeExTRvtDeXnnBmD0+3sJ9G8J1yHHgLWFNm0TmxirBUiur+/PmyYgRMwvpy2fFOllPcEwMYY9pYKU4zHBJY0o+j0aog13Y8xZw9+gbMMWskNwrf5MwW0evWFMef4n6127sclRFf86mVvPBkZzPlL9nsm1W4BpmxmtiX9UyPjv9z8rAm19zNgBMteM7g+W7r2Y3TcddRmw9tN2PrDkWjVJ5E70tRqiV/0aRlDnlMvP1WQ9ZjaT+ndNv1bJ48JDJKR7bqQNJcqYOL+YwT5jhFLGKJhHjuFVkW/qidCIYu/qzDeEujcVi2cQlyR02BnQoV9pYXqQKQCAPKTFX2DqSVBAtQrfF+ek7nr9X4VX4PE59yGIOUKnoSipBZFTCNA4qzsy6sq3Bdxgc39EBDSBcW1tykIh5gpE9gdZ1ee0MSxhZ9tuVjDkfK+37T253K45ufI7107U/5lvEBKbrJ6ZHkneY6IZ6d/K77VM/bro1sBPTI9pYQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(376014)(82310400026)(261021121427099003)(56012099006)(261009223027099003)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oGd6vjIKdBY7r6DquAok/dm+loMJxZwYP5PzhRg7tgrHQ08YlRxRkl444rXF4pwlQP2kMO4Rrtwh/W6E+k88lN3AGpV9nW5KMc4fYpC4hnokOQrT9l9VECdq9upSzRnpMMXGn8uuO5+7NJj/yp3B6Iq2sQgeBG82YOU3SUNdYY3TUpfYteC1/SpncvPeQJsGCXmTggmjFuReWUkW7Y/E4yZtnHepYkS3iWS8wY3y+KpmQMqPtnEt1G8OCjiqbOzdKAyW+TcoG/iRv8FYsjJf+pLs348jCliw1u06XK8Gd/WvXjh0vdFVrAJ7xHOy+7ps1Cj03THy/jvzm94dGpdCNkJ0EU6dLkePL5kiS5tPMtR75EIGy+2wooGKwxR8NuTF/WOkWr/bhYXToWVNw0bRsNWWNB9Llx+1LMiQe2Mt4k1lZtjobqpVZDGeoLmpPSaE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 08:20:52.9672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d91e75c0-96f1-4999-768f-08df30156367
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A803.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9213
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The fence value of a user queue is the write pointer of the queue when
the work was submitted. amdgpu_userq_fence_driver_force_completion()
signals all the fences of a queue, as after a reset that dropped all its
work.

Add amdgpu_userq_fence_driver_force_completion_with_seqno(), which only
signals the fences of the work up to a write pointer, with an error, for
a reset that drops only part of the work of a queue: the work submitted
after that write pointer still runs.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 31 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  2 ++
 2 files changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index a2fa59a9609e..e76249c43b7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -459,6 +459,37 @@ amdgpu_userq_fence_driver_force_completion(struct amdgpu_usermode_queue *userq)
 	}
 }
 
+/*
+ * Signal the fences of @userq with a seqno up to @seqno with -ECANCELED, eg.
+ * when a reset dropped the work that would have signaled them.
+ */
+void
+amdgpu_userq_fence_driver_force_completion_with_seqno(struct amdgpu_usermode_queue *userq,
+						      u64 seqno)
+{
+	struct amdgpu_userq_fence_driver *fence_drv = userq->fence_drv;
+	struct amdgpu_userq_fence *fence;
+	unsigned long flags;
+
+	if (!fence_drv)
+		return;
+
+	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
+	list_for_each_entry(fence, &fence_drv->fences, link) {
+		if (fence->base.seqno > seqno)
+			break;
+		spin_lock(dma_fence_spinlock(&fence->base));
+		if (!dma_fence_is_signaled_locked(&fence->base))
+			dma_fence_set_error(&fence->base, -ECANCELED);
+		spin_unlock(dma_fence_spinlock(&fence->base));
+	}
+	if (amdgpu_userq_fence_read(fence_drv) < seqno)
+		amdgpu_userq_fence_write(fence_drv, seqno);
+	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
+
+	amdgpu_userq_fence_driver_process(fence_drv);
+}
+
 int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 			      struct drm_file *filp)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
index 0bd51616cef1..0407c8c2575f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
@@ -65,6 +65,8 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 void amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq);
 int amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv);
 void amdgpu_userq_fence_driver_force_completion(struct amdgpu_usermode_queue *userq);
+void amdgpu_userq_fence_driver_force_completion_with_seqno(struct amdgpu_usermode_queue *userq,
+							   u64 seqno);
 void amdgpu_userq_fence_driver_destroy(struct kref *ref);
 int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 			      struct drm_file *filp);
-- 
2.50.1

