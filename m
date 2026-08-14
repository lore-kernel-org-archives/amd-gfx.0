Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68106C5CFC1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 08:56:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAED410E0FC;
	Fri, 14 Aug 2026 08:56:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uoh8A80v";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010058.outbound.protection.outlook.com [52.101.56.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 959CB10E0FC
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 08:56:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GBFWz+u6BgPSxtMhRIAznXobRuV+JxWUySXkMalP29EeBhxNDyhgg1NvkCpmcomCti/NfTRdVyDWQr/Agt1XibPAKz7nOKHyi8/RtEXvClzcQUlW0S5pItJTUX0ClRDR75c71KBlQXCy1AruS/Of5F1UODCYxkZrbAlk02YzMFnaGepoLMOnBb589ZwlOAznF3Aq+yIW6tMdJs2IOhU+3x1JrzbVxIk2Gc8LoK72qkzbUoaQ8aEJabMw7ldinqoLDPxbR07b/kRBVyrkB4+M8gTilVRE3un6FA5RY0BUE4wy1YmN+LSQgOqJiFE17nuGW3xBySNzPkYwHz+PhdcALg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HU6xcd9EIyGksYuFlK479ZtNinStbosGmxgOwQdsNho=;
 b=JT9+oOufAipOHm0TkFWqZH9Tq/2RUh2tnuGUzYcpYBOw6NMeUzsBXjD/xf2gxCg4hrPUA4HW4k1WbSTpJTPK0IfdkOllQq32tvh+huFtZgFZ7W7wNXRW+EfdpawXBcLmMID7ZRymZU7JPHZgVSCU0XKQcjdN3OY9MjU1vf0EVJ7z6agNMkc9XrUYruNTUqPGr/VR8JMqe0hyZqm78VJGLON/8PrHmrjqo9ZdWqdS/S2HoBJ70dd0CzZF9ap4onuQr2FteSQitFqQgyhQkts2s71sXUYHeqWOf6tv1zunGllU1yz//fIsLY7a7ERd7ZA4GgMuaEjxHZMz1o/6gnRS0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HU6xcd9EIyGksYuFlK479ZtNinStbosGmxgOwQdsNho=;
 b=uoh8A80vn47Ieg8yKnQyUoLNZilaPmlxv7y5pG0NQ2Q1ZRLSsumewZGCJRc/lXs3uOHGjeL8CVLveEq2kGlGZMNDxCX4w25HINmPrZm8v1U5z8wlkUeIdm5V3XL9sB/utXjf4XvS84WQO8WgdX1r8lrL9mu8Ods25L/yJvpNRYI=
Received: from MN0PR05CA0004.namprd05.prod.outlook.com (2603:10b6:208:52c::10)
 by SJ5PPF2CD49510F.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::98f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Fri, 14 Aug
 2026 08:56:35 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:208:52c:cafe::91) by MN0PR05CA0004.outlook.office365.com
 (2603:10b6:208:52c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.6 via Frontend Transport; Fri, 14
 Aug 2026 08:56:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 08:56:34 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 03:56:34 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 03:56:33 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 03:56:32 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <prike.liang@amd.com>, Sunil Khatri <sunil.khatri@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu/userq: lock and validate wptr BOs before reading
 their GPU offset on restore
Date: Fri, 14 Aug 2026 16:55:56 +0800
Message-ID: <20260814085626.80716-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|SJ5PPF2CD49510F:EE_
X-MS-Office365-Filtering-Correlation-Id: 58504431-be71-459c-fd18-08def9e1f158
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|56012099006|18002099003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: s4rgF5ThPn2GyImpaQTvW4tExS9RQAITfi07c88MR30G+BViasK0LRXcdkt7l0e2UaMSiZs0gz0+iGiQtGvaqGW9TiRpzqjOg01hnqKZunw/DR6ZhnOGHACJcNoW5/ze0lO7Ugd1sOsOxe+SB6Wx40+U3+uboxgCt4blPa3VzyViYKS8anx7XCEZySCVF2p/bG8VhMesJIIg+frLPjwqRcAuFuLuYRpUvhm9UH27iyGEZhSZoMSBBMK6F8nraNMzcHRioLz4yx+P4Br6G1OqZogEj7uWxtKYOyIyVVVRn8MUmcv19vmEngOgWFRbrzp6zFenxukbu2d06LAlEDXYLgT45plLCSDpEJ6DbfojtFFo0iHSYLIlVdwW1x9ZG3W/GtE5QoaGYZc5HmuyO2TAJLRJ2GewuTi0G2ZkATZ3DY9GOnEUSd/s9gHe0tBjANjsckuUqywngA1Ypu0DVNddm8pjWcWTHeG107INkAFaMjXGX5EfPZA6dQdIPkpU7Shf7yWb8XfzFNOn0o+LM/xM0BJs4m4Y785rU62bStychsKDrF/xudcZOFJtQKKlAjaxj2pV8AK3Nmw0HGwuZ1RgLAIygX1/Sv2EvG7BG/sNBub1wp1jaXXpKUWPFxGhc7Vx/Wkd4QsZEk0uJq3gokANXe/Co4h2zoq1aMVZ05Xw49IyhyMbTqRnQycekVM2nhCtaN2OPjFPJ0l+mUCmo14OPQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(56012099006)(18002099003)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: b8S3alVm8gwHZtLXC2HlyvZNziRlDOdLubdXhma5v8M/8Gm+lHUYwdl1hsrCJIQEdMsTgodmI679I0gk2d2u8V3WOLIG01VnSRHZjhc4KAQYIJCoa2nkYSZbCanvQtwxhd26AV/oGCSm56FEbQ3pTxbz642fQ/F4UXI9JabtQS0yu3/m8oJ4Gz2ejKUJYma4wt7IuyocXKiygSEF+vNefhCadol672X/uJZK9TIGExPyhf44BNLSRv94Nb8D7aPfwcQQ+iUwH/xkKwVmoFUT0yywRj++jR1dcEHAHw7XLY8BnZCIGAUWqmJahYgms9M29JuYlBKL0m/oxMNqyTI1M2yV3NzMlreHkjPZqPT/iJNBBrIsoDeB05Ci3Eg0nxtf7LFqa2D2Pu3RB0Gz3gslAED2M1lEdGl9Qqfm+XAjVDP71EA0HWzuWOaU4gmDJzE+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 08:56:34.4849 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58504431-be71-459c-fd18-08def9e1f158
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF2CD49510F
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

amdgpu_userq_vm_validate_and_restore_queue() reads each queue's wptr BO
GPU offset via amdgpu_bo_gpu_offset() after only calling
amdgpu_ttm_alloc_gart() on it. But the wptr BOs are not part of this VM
(their reservation object is their own, not vm->root), so neither
amdgpu_vm_validate() nor amdgpu_userq_bo_validate() (which only handles
the VM's evicted list) covers them. As a result a wptr BO can still be in
TTM_PL_SYSTEM and unreserved when its offset is read, tripping the
amdgpu_bo_gpu_offset() sanity checks from the restore worker:

  ------------[ cut here ]------------
  WARNING: amdgpu_object.c:1486 at amdgpu_bo_gpu_offset+0x75/0xa0 [amdgpu], CPU#3: kworker/3:1/116
  Workqueue: events amdgpu_userq_restore_worker [amdgpu]
  RIP: 0010:amdgpu_bo_gpu_offset+0x75/0xa0 [amdgpu]
  Call Trace:
   <TASK>
   amdgpu_userq_vm_validate_and_restore_queue+0x629/0x960 [amdgpu]
   amdgpu_userq_restore_worker+0xa6/0x180 [amdgpu]
   process_scheduled_works+0xa6/0x460
   worker_thread+0x13c/0x290
   kthread+0xfb/0x140
   ret_from_fork+0x1b6/0x2b0
   ret_from_fork_asm+0x1a/0x30
   </TASK>
  ---[ end trace 0000000000000000 ]---
  ------------[ cut here ]------------
  WARNING: amdgpu_object.c:1485 at amdgpu_bo_gpu_offset+0x9a/0xa0 [amdgpu], CPU#2: kworker/2:1/127
  Workqueue: events amdgpu_userq_restore_worker [amdgpu]
  RIP: 0010:amdgpu_bo_gpu_offset+0x9a/0xa0 [amdgpu]

amdgpu_ttm_alloc_gart() only creates the GART mapping; it does not migrate
the BO out of system memory, so the offset read is bogus (the queue would
resume with a wrong wptr address).

Lock each wptr BO into the drm_exec context and validate it into GTT
inside the drm_exec_until_all_locked() block, mirroring what the create
path (mes_userq_create_wptr_mapping) already does, so that the offset read
later is safe and correct.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 26 +++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 17cc48d87c4d..59aa4802c111 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1054,6 +1054,32 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
 		drm_exec_retry_on_contention(&exec);
 		if (unlikely(ret))
 			goto unlock_all;
+
+		/*
+		 * The per-queue wptr BOs are not part of this VM (their resv is
+		 * their own, not vm->root), so the validation above does not
+		 * cover them. Lock and validate each into GTT here so that
+		 * reading its GPU offset below is safe - matching what the
+		 * create path (mes_userq_create_wptr_mapping) does.
+		 */
+		xa_for_each(&uq_mgr->userq_xa, tmp_key, queue) {
+			struct ttm_operation_ctx wptr_ctx = { false, false };
+
+			bo = queue->wptr_obj.obj;
+			if (!bo)
+				continue;
+
+			ret = drm_exec_prepare_obj(&exec, &bo->tbo.base,
+						   TTM_NUM_MOVE_FENCES + 1);
+			drm_exec_retry_on_contention(&exec);
+			if (unlikely(ret))
+				goto unlock_all;
+
+			amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
+			ret = ttm_bo_validate(&bo->tbo, &bo->placement, &wptr_ctx);
+			if (unlikely(ret))
+				goto unlock_all;
+		}
 	}
 
 	if (invalidated) {
-- 
2.49.0

