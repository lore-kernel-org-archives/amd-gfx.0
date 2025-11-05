Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE1ECCF9F8
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 06:16:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BECC610E27F;
	Wed,  5 Nov 2025 06:16:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ccpZ4vMp";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010034.outbound.protection.outlook.com [52.101.201.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4597D10E27F
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 06:16:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WWeY0Cr9AYtlKjVHa7nr0RTArnMXjtHC5JhiunIltHdjqQWwhvNpqJ6tjXhTLHhpo9EACZyhEwi3M3odttiovPi0ITegDKX1pAGDWHxwdj3TLDOc7gKwFxxIzab2S14UxrlTQDAn1KZZmve4ZC7qFVAoM4SNMZU3pC5uBQG2ecL5aFjb6UnF5mL5+a+jF8tMn9D82R7+fTAXIx3fG2uLu0yFptoPXbjh5jmEEv+8Pw6IN3nEiHfN+chUDMozWtvvX+4sj7xZuelNRiPKcJ5jX37p2ovNllKva9yZlPv9kIq2i+kGermXbVdEqmOKfuvtDnTG4Bkiu+nKJMW3C++0TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBMlFozXnnmi6f651K8TEHiKetTRXG1fkC8fMgjORrg=;
 b=kD/uohjS/fitYN0U98vwoPKbKTcSgvv6Catjdf8Mo+rCWBcAnxE2j/HuIlv3ZhX+Qz8EoeHe9A6TU894yUzArM2Zic3g0125N3sAlzBM5Bs7PUAAcEdXF/4x+EHB+4Vu1TzR5rsm6/PgGXIJVy9HpG9hLFpz03xwgnTzw/yKICq5mzrgRgxnSSPNOoQZ4gG4DuwVgWVilN7P9Qa5VRSf4iutrkHFP8vlJf029Z38BoxbnsYTdc8JMrrDac7cq8H/iVo78jLnavzTlzlWX9ww11udPcTitmyW4fUps504kaotuFSz/hSUbOLUgP2+Ph9Qz1rXc9Aq+lqomG2rlnYh/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBMlFozXnnmi6f651K8TEHiKetTRXG1fkC8fMgjORrg=;
 b=ccpZ4vMpZWmHDnj+1IDUQ+m5n24uXxeAJYVMMU58uBfgHWnQtBPKTSLc/TT7YnaE35iCPANlcp3Q/1K/qUknohiTJ+CrDOZpZjNnywE1cKYwkogGxrBaG+xZ80O/Yacap+sb9ffd2WRvSJzTtClDVkc9LBf+nPY4oJMntdwka+Q=
Received: from BYAPR05CA0028.namprd05.prod.outlook.com (2603:10b6:a03:c0::41)
 by LV3PR12MB9216.namprd12.prod.outlook.com (2603:10b6:408:1a5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 06:16:43 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a03:c0:cafe::41) by BYAPR05CA0028.outlook.office365.com
 (2603:10b6:a03:c0::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Wed, 5
 Nov 2025 06:16:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 06:16:41 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 22:16:39 -0800
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: add user queue vm identifier
Date: Wed, 5 Nov 2025 14:16:28 +0800
Message-ID: <20251105061630.4146604-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|LV3PR12MB9216:EE_
X-MS-Office365-Filtering-Correlation-Id: a45dc128-ae15-4ee6-a795-08de1c32e330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gORHh+kJVVwnybrHykXc5LSXzuvCUiKL2ha1sq3ZqEZD/D0elhPXTggrRNYj?=
 =?us-ascii?Q?5speCl3Tr095SND7wSReTJDhVK3qSy7ULQomEZ8f8Sqk74DvYcJg5WQ6uFYF?=
 =?us-ascii?Q?ab312SFV0YTmwl+Q6AHtKItuiwcJcF2rlcm+QCkKcEu9tfivcnXVu/6HQrTw?=
 =?us-ascii?Q?bk2SW8etjONz09F0sji4HiS+Dz/7H+Qxo/xoMmqdCWtZGtGC1CA4yaxAyaV6?=
 =?us-ascii?Q?oFcDTtVHwOd30XDEYsNjPw6GIaz218WZ3RYWvvCSKtJuSSoJ67RVR588XJav?=
 =?us-ascii?Q?DJ+IQ+BgMjLh1RmVl9o+JlH+UixEXky5+tmrRgoITQvai9soS8Oxy4NBP0Mo?=
 =?us-ascii?Q?R1YHKRJzJUjjZpjcays11t4Hmj+LqVsdgk6lnRKMzJa3eDuJL337yzsc6g9S?=
 =?us-ascii?Q?Ymt5vVxZXFb+ulEJh3H5dKPfpTeDWYRt1t/4+sv6/bO8jAcdPmXBBcja8FEV?=
 =?us-ascii?Q?j77fNRhGG+b630HgbSfhdZrak2NrptcdiAUUVtQUeH2Rv9sxOpYvzIyDymsm?=
 =?us-ascii?Q?Vqy+Uj/bwrMgZQruURjuSx/rVdlR2B6C7kL+c/hZX2/KQAunTj3S+L/ARPIX?=
 =?us-ascii?Q?YqAVTIGdApYCvnNWbtBEFauLock47KBRCS3hR+FRZY+zedllRffBpSQdadtk?=
 =?us-ascii?Q?kPM7wIizlsbe51kN5cwveoEjMq/pxubcMo/ieR8+o+m3mEvzVFlrf+v0N/pQ?=
 =?us-ascii?Q?cwDD7bI8BjIjhtAi5krmh9WUQ5IR6gIcZkEHU0VJ2DY4vbCbZUWSb/cUINa0?=
 =?us-ascii?Q?R3QkrWEAfVY7Yr4vbLQSujE00+HWJsE0876a81HsAH47ZrYf0oXx3qkARV4v?=
 =?us-ascii?Q?OcrPQTH8n1rQGrxAzU8HvzvHAq5T6Oxq9QcUMLEcJo5qm/KGOhaPldhWA8eB?=
 =?us-ascii?Q?yhNBWqXYnBmkLfJDH3uTpZBrJJJuzyCxqlnC41Vm3wMARBLexX2BUATOthBd?=
 =?us-ascii?Q?2lC0G0W85umNAUQ8nrLi5vjXe8YiwIKo8Jr6bIZ4HjAi9Vp9F3cKE0YvYbWb?=
 =?us-ascii?Q?hi/cZefTI5TSekeXWXymV4yaSTUmjhcSFoeHyZRWYBXhvNvhrysTwJOvRBtt?=
 =?us-ascii?Q?gB+/J8XhAL77fUB1YHkkkwj+ay9OfVRA/NYe/gqu4BQmzN68ANQShH5/+rzX?=
 =?us-ascii?Q?O+4pxzN7R+GBpOaY9G5JBXlb7oOa2+CsGG6Ct3tpgZAe9rpkBgR9+CvchN5Y?=
 =?us-ascii?Q?H8h3oqM38AJTggZgXDvRU5Hv1UtdR39oogCzBjjwBUR06yH+xH8e7x0UDYcA?=
 =?us-ascii?Q?Xxh91UeRwciJTTB6Re7FHanjRuZu40jgV977eMGhmdC8gIEGPsafHN2BvGSt?=
 =?us-ascii?Q?AdMMKR8yKt32LkMCcUPIErGY3c2lZgyv5XvCyJqSdMAcNho6H/P6aYy3ieXF?=
 =?us-ascii?Q?vPD2IsbRlybf8mvGx4R+utmB6RTNDTovUoBmAGNuOhwsz/FIkHFNIwb/9yS8?=
 =?us-ascii?Q?ut2f5uTPVint/nbERFcvEUtJDpSBKJqCD5OkSlbiR0j0NQAHJOgoL5mXyFCQ?=
 =?us-ascii?Q?hIfysS9kuXdpaSK0qNFPO5/g8UE5utRQxytrn0OQpk4zFj+Vl6jzm9JKg+SW?=
 =?us-ascii?Q?sjykETc7IiQMfQ9f8+o=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 06:16:41.7402 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a45dc128-ae15-4ee6-a795-08de1c32e330
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9216
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

Add a user queue vm identifier for each userqueue
kms opt accessing.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 8888be4e758c..a8bb3f1b8649 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1249,10 +1249,13 @@ amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
 			  struct amdgpu_device *adev)
 {
+	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(userq_mgr);
+
 	mutex_init(&userq_mgr->userq_mutex);
 	xa_init_flags(&userq_mgr->userq_mgr_xa, XA_FLAGS_ALLOC);
 	userq_mgr->adev = adev;
 	userq_mgr->file = file_priv;
+	fpriv->vm.is_userq_context = true;
 
 	INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userq_restore_worker);
 	return 0;
@@ -1262,6 +1265,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 {
 	struct amdgpu_usermode_queue *queue;
 	unsigned long queue_id;
+	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(userq_mgr);
 
 	cancel_delayed_work_sync(&userq_mgr->resume_work);
 
@@ -1276,6 +1280,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 	xa_destroy(&userq_mgr->userq_mgr_xa);
 	mutex_unlock(&userq_mgr->userq_mutex);
 	mutex_destroy(&userq_mgr->userq_mutex);
+	fpriv->vm.is_userq_context = false;
 }
 
 int amdgpu_userq_suspend(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index db66b4232de0..48a64d828eb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2591,7 +2591,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	ttm_lru_bulk_move_init(&vm->lru_bulk_move);
 
 	vm->is_compute_context = false;
-
+	vm->is_userq_context = false;
 	vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
 				    AMDGPU_VM_USE_CPU_FOR_GFX);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 77207f4e448e..cbe7dfa4ffcb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -439,7 +439,7 @@ struct amdgpu_vm {
 	struct ttm_lru_bulk_move lru_bulk_move;
 	/* Flag to indicate if VM is used for compute */
 	bool			is_compute_context;
-
+	bool			is_userq_context;
 	/* Memory partition number, -1 means any partition */
 	int8_t			mem_id;
 
-- 
2.34.1

