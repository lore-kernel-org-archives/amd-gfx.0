Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68993C44500
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2026 08:40:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05C7610F245;
	Thu,  2 Jul 2026 08:40:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YmjvWz2O";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010049.outbound.protection.outlook.com [52.101.56.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2004110F245
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2026 08:40:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4rNus+Ch9roq3bzk/VC8NshXCPG9hTDWIpZxRvJxMJCSCA0YUdZe+byK9N5d/tAwMp5NzdggAa8URe8IsF6HEKP9CWLUtOnBy3F3X8kaAlpIgK7SN9w3/66owfR8N0M+BHTl3ga2fjLG3yZm62UCwOl5xanBaG1e4OWQ2m6WRc7YYA2LXB4Y+6VaXXObKteHAskPQRtrWjZh9CNvvroN27Tw35GsyCuKU36zDKIU9S5+EC33mVcy8NbAHTzCgzGlFUvLkKHehUPiOpEuY2UukzuxCK5ms4FFvycDEtyuOAy2kSwu17rOUzXrcov0gFfhX5Okm3Z08BBI2/N3XX2Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTyHqFzQMM1guTI198xmkkGtFxbM5DknJ41TdyFgol0=;
 b=PrAzDYSgIOJv573iuPl/vcioy6iMK4Pt6sZ5w37plHRiLq7aIJ7L8sNit4KbyV67Xung3QoR/fzOANW6zpGKh2nGwbYkcZuSrAEf0ZXoLfP3zzxv4zYKvZhwe0YJ04eiaF0wAtAYdBctYlsGl35LJw7HxjP0aoAGQBNFnKSN/Zslp2lfV1h9FmXOa5dI4poH8oNfU7U4Xz8deCNpDTMWTpfzNLKp9/OBNtTicsO8sC0S6rllz4hxnaZNB2LYgV9LzCTevquddjRfX3TSdr35y/1C90K+PYA4C1u54el8h7ex+uWv/+zRdhJI7IlYTgzxpBkiLl+gotKER9Ers30wjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTyHqFzQMM1guTI198xmkkGtFxbM5DknJ41TdyFgol0=;
 b=YmjvWz2Ofz0Wg17NzQ8cAxcFTWpWjqK9PZY7J2sNWRp7uD36KDUh7OM31uhcyZCsWvUU74VQj8gWIFf0q+u4FNSIowOtYQoU5nJLSh+7KzK+DHjOgz2zezoEXr4nVE63PeaFFyppVr/zzuX+etrb4MivsOx1Bj3MZVZm6uFblKE=
Received: from BN9PR03CA0222.namprd03.prod.outlook.com (2603:10b6:408:f8::17)
 by DM4PR12MB6133.namprd12.prod.outlook.com (2603:10b6:8:ae::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.8; Thu, 2 Jul 2026 08:40:45 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:f8:cafe::70) by BN9PR03CA0222.outlook.office365.com
 (2603:10b6:408:f8::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Thu, 2
 Jul 2026 08:40:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 2 Jul 2026 08:40:45 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 2 Jul 2026 03:40:43 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v3 1/4] drm/amdgpu: Add PASID fpriv ownership helpers
Date: Thu, 2 Jul 2026 14:10:18 +0530
Message-ID: <20260702084021.3140071-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260702084021.3140071-1-srinivasan.shanmugam@amd.com>
References: <20260702084021.3140071-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|DM4PR12MB6133:EE_
X-MS-Office365-Filtering-Correlation-Id: 788c8a58-d6a7-4e30-3b92-08ded8159bb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|18002099003|56012099006|11063799006|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info: b8CU5x1geElayFEeyDUfY18wX9EQFgElUXbF3el3McjkCyRrfGZSXisU3U3BAm/nO02zvfd8PsqqN4/UQMQyOX2a5eBw2F8LPJbJnI9436jhYqxiXLV9MCKaVv8ozyhNMw1CN0DgETEunzCNsrmuaF7koa/Y7LOOji4AQBdqd9HfSyHPFx4A62WYx+ueowYPp9stNzuQnFQbrCax9K6H6YOWOILfVkyd1q/xWC0ejFWIQRTZBI9lNbh9bg51iFZj8PizFHFxA9mg2COt4n58vN+37LsQOJCqGYxWJlSQy6Lu0ycPUhLjkc8e8xlw73BGZvhydoFqXxeSJre0TLSNri4uMN9V9CuRyQMnVz9qzI2AiMFQB/jwYeXK7PWqvjCg7V0h3aeuHm7rzV1sQChPNUFcqRhsYX+nbNw/IljrU1GK0cLaoOt6UzR0M1pntKdIPA8SVGA890K/sWo8zSewzTBsLYPaOiMG5Zy+yIFBX1aZ1YQxkSO7F5G9eiH3yR5xkVWJhJWwhptxyBwvxD9/qXzi1iz6IHpFltcetSGnaQc5HYnG6KMiAGj1XKZegKm9DHgoHxFJi4a0dQ2vFYmLEPu46xM2em0hkAXG2NKMdSQoOhasaq01M3G2qigZumwQNDFuKExCQZG6SYYleSfBOvYQmys4dj01BOX2KkpRhSP1JZzfTZyXjrmHzAqRfqcAu9zlNJ+fGBoCUeyweaVw+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(18002099003)(56012099006)(11063799006)(6133799003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BN2sHqJUgYuA7Op/WNT0O/RlMQaRoAdGg1UzEuUoOrZ/EvjIdLXuWAAeQjfniC/yec7kKxXbh4k3QJZZDPuijeR0fua0hrp9YsxC9PydPfE8I+1Ix9QFT3SKjdnjduNZbxrGd/zDFnVL3pVPtnAMYCHcwvELyBJlhCP4gQ11WCVgABsCqYesp8JK5Wx1h5mhKN8/8PQk3tvY/v8C5LB71Y1s3D/vCGFG87Vt7B+hRNMJ+kNKHZxeG/W8Fe/PV1CayCebZFUOBiVamocQfPGL9J3i//hwLyZTTqqu2IV1CFb6xGCa8b73lIURUqKWRmuHe4arHQQ6WRbAbMCXwkus9NlYKiJOsumHlykRtID2UvTQStNLC0g1TIhycVsTAaJQqoJF83/7Xmk9p28wxsg7uEwJ6Kd/zv8YyWzkPX8BR//1u5yRLovsgjTiOat7uv7S
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 08:40:45.0701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 788c8a58-d6a7-4e30-3b92-08ded8159bb0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6133
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

AMDGPU already has a global PASID xarray used by the PASID allocator.

Currently allocated PASIDs store a dummy value in that xarray.

Add helper functions so DRM-owned PASIDs can store and retrieve their
owning DRM file-private object.

This prepares for using:

	PASID -> fpriv -> vm

instead of the separate per-device:

	PASID -> vm

mapping.

v3: (per Christian)
- Document that PASID allocation is intentionally kept separate
  from fpriv registration because fpriv is not fully initialized
  when the PASID is allocated.

Cc: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 126 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h |  13 +++
 2 files changed, 139 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 684f40fce73f..5333937f0d04 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -78,6 +78,132 @@ int amdgpu_pasid_alloc(unsigned int bits)
 	return pasid;
 }
 
+/**
+ * amdgpu_pasid_set_fpriv - register the DRM owner of a PASID
+ * @pasid: PASID allocated for the DRM client
+ * @fpriv: owning DRM file-private object
+ *
+ * PASID allocation is intentionally kept separate from owner
+ * registration because the DRM file-private object is not fully
+ * initialized when the PASID is allocated.
+ *
+ * This helper replaces the temporary allocation marker with the
+ * initialized DRM owner.
+ */
+int amdgpu_pasid_set_fpriv(u32 pasid,
+			   struct amdgpu_fpriv *fpriv)
+{
+	unsigned long flags;
+	void *entry;
+	int r = 0;
+
+	if (!pasid || !fpriv)
+		return -EINVAL;
+
+	xa_lock_irqsave(&amdgpu_pasid_xa, flags);
+
+	entry = xa_load(&amdgpu_pasid_xa, pasid);
+
+	if (!entry) {
+		r = -ENOENT;
+		goto unlock;
+	}
+
+	if (!xa_is_value(entry)) {
+		r = -EBUSY;
+		goto unlock;
+	}
+
+	entry = __xa_store(&amdgpu_pasid_xa, pasid,
+			   fpriv, GFP_ATOMIC);
+	r = xa_err(entry);
+
+unlock:
+	xa_unlock_irqrestore(&amdgpu_pasid_xa, flags);
+
+	return r;
+}
+
+/**
+ * amdgpu_pasid_clear_fpriv - unregister PASID ownership
+ * @pasid: PASID whose owner is being removed
+ * @fpriv: DRM file-private object owning the PASID
+ *
+ * Restore the PASID entry back to the allocation marker before the
+ * DRM file-private object is destroyed.
+ */
+void amdgpu_pasid_clear_fpriv(u32 pasid,
+			      struct amdgpu_fpriv *fpriv)
+{
+	unsigned long flags;
+	void *entry;
+
+	if (!pasid || !fpriv)
+		return;
+
+	xa_lock_irqsave(&amdgpu_pasid_xa, flags);
+
+	entry = xa_load(&amdgpu_pasid_xa, pasid);
+
+	if (entry == fpriv)
+		__xa_store(&amdgpu_pasid_xa,
+			   pasid,
+			   xa_mk_value(0),
+			   GFP_ATOMIC);
+
+	xa_unlock_irqrestore(&amdgpu_pasid_xa, flags);
+}
+
+/**
+ * amdgpu_pasid_lock - acquire the global PASID xarray lock
+ * @flags: storage for interrupt state
+ *
+ * Acquire the global PASID xarray lock with interrupts disabled.
+ * The saved interrupt state must be passed to
+ * amdgpu_pasid_unlock().
+ */
+void amdgpu_pasid_lock(unsigned long *flags)
+{
+	xa_lock_irqsave(&amdgpu_pasid_xa, *flags);
+}
+
+/**
+ * amdgpu_pasid_unlock - release the global PASID xarray lock
+ * @flags: interrupt state returned by amdgpu_pasid_lock()
+ *
+ * Release the global PASID xarray lock and restore the previous
+ * interrupt state.
+ */
+void amdgpu_pasid_unlock(unsigned long flags)
+{
+	xa_unlock_irqrestore(&amdgpu_pasid_xa, flags);
+}
+
+/**
+ * amdgpu_pasid_get_fpriv_locked - get fpriv from PASID
+ * @pasid: PASID to resolve
+ *
+ * Caller must hold the PASID XA lock.
+ *
+ * The returned pointer is only protected by the PASID XA lock.
+ * Callers must not continue using it after dropping the lock
+ * unless additional lifetime protection exists.
+ *
+ * This intentionally does not add kref/RCU lifetime handling.
+ */
+	struct amdgpu_fpriv *
+amdgpu_pasid_get_fpriv_locked(u32 pasid)
+{
+	void *entry;
+
+	entry = xa_load(&amdgpu_pasid_xa, pasid);
+
+	if (!entry || xa_is_value(entry))
+		return NULL;
+
+	return entry;
+}
+
 /**
  * amdgpu_pasid_free - Free a PASID
  * @pasid: PASID to free
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
index a57919478d3b..220a0ba0cfb6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
@@ -38,6 +38,7 @@ struct amdgpu_vm;
 struct amdgpu_ring;
 struct amdgpu_sync;
 struct amdgpu_job;
+struct amdgpu_fpriv;
 
 struct amdgpu_vmid {
 	struct list_head	list;
@@ -92,4 +93,16 @@ void amdgpu_vmid_reset_all(struct amdgpu_device *adev);
 void amdgpu_vmid_mgr_init(struct amdgpu_device *adev);
 void amdgpu_vmid_mgr_fini(struct amdgpu_device *adev);
 
+int amdgpu_pasid_set_fpriv(u32 pasid,
+			   struct amdgpu_fpriv *fpriv);
+
+void amdgpu_pasid_clear_fpriv(u32 pasid,
+			      struct amdgpu_fpriv *fpriv);
+
+void amdgpu_pasid_lock(unsigned long *flags);
+void amdgpu_pasid_unlock(unsigned long flags);
+
+struct amdgpu_fpriv *
+amdgpu_pasid_get_fpriv_locked(u32 pasid);
+
 #endif
-- 
2.34.1

