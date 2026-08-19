Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC23C5DF81
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2026 02:21:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 577C010E013;
	Wed, 19 Aug 2026 02:21:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zKhXFjFV";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012051.outbound.protection.outlook.com [52.101.48.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BC9B10E013
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2026 02:21:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qHRC87Ufl7Nr3e5vf2S7cmM5TuMw2clLhMSx/pFiGweR+gsdMXxbK+XduhX8tIw+owPGujSamWqTFJTC2jAJnqfuuYNEZhzRS78VxJhk72CVTmI4vDc75fifcuNP1VQBKK3Me4X6tJsiOZRReFdcOWm++e2fpPHn+RjM55wgml/XxmqNsMp06nLMv+W0g2kvwD92rhcwTZH44HrBo1b0gNKS3+TljLHo369vBdGB17TYKsXvL9Q+pfigYXeA//cIkv4v8lWMPGPHIKtm+o+CZUgWgnzGg497qagDwLsXnmBCZfL/Z8w5fkj9nN0/ezl69yxOTDK4ZP01gNuFeYnMHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOCTwS8Sx8QSzM9LWxU/vW0YQ+dSquy4XfUZD32d7YE=;
 b=Dba1r6GeZM+XxeYhu5NpTANWcfH0KZ0AYItPliZlaJ0zcomDjoD5oN1hxctZcJ1QajFvNVq8pQc4pO3JHW0JrpRlhb5zq+Y7E6ZwZmU0m0Uh5Q4EXWO4IRh43CeXPLqyIFNoXmAzhVhjQznZlA8Y4Wx/4YqU+fjodFlR3Phq+G242Qu+wyK4QBFka8kpsA26SKsqEgKfoJjoHmxDZHYDlZounDEHyjMn+KtrlVO8eag6lJlCKEXfc22GQaNCo3NT5ayKmbcaUgU5VIPk5S/oJA6JNBl8PQn9Njk35O47IjOBQWP3fprQfLwp7QYXdr4wre56yQP7SUiPbiaoyRwgWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOCTwS8Sx8QSzM9LWxU/vW0YQ+dSquy4XfUZD32d7YE=;
 b=zKhXFjFVkQJYX30YJN1q5jF4qWIEB+iFgFO1pGDyqNcNXmmvvVkonc9GG32Wyz/i6W9XzADZ7KGU/fNjlrauQZtcdkNwAbpTVqNKCeZRl/gN7URC32pQxcZLubT404hMmepEAYrJzSNog56pcyCxpso+HBX6rVqdCu1XUJlV7xk=
Received: from CH2PR16CA0004.namprd16.prod.outlook.com (2603:10b6:610:50::14)
 by CY8PR12MB7196.namprd12.prod.outlook.com (2603:10b6:930:58::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 19 Aug
 2026 02:21:47 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::a5) by CH2PR16CA0004.outlook.office365.com
 (2603:10b6:610:50::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Wed, 19
 Aug 2026 02:21:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Wed, 19 Aug 2026 02:21:46 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 21:21:45 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 21:21:44 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <prike.liang@amd.com>, Sunil Khatri <sunil.khatri@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH v2] drm/amdgpu/userq: lock and validate wptr BOs before
 reading their GPU offset on restore
Date: Wed, 19 Aug 2026 10:21:08 +0800
Message-ID: <20260819022138.3908141-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|CY8PR12MB7196:EE_
X-MS-Office365-Filtering-Correlation-Id: c07e9fec-b98c-4c08-2013-08defd989e20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: aL2wInZtIPeXKsa5iirlM3/qdCgwvcg9A+8A2NW+5fg2Aw4OUyN2ebC+U50R2LZWOAfHkdNBl/RgbOQwW2SCFHxWRUKq328Ck3JXlJNxlXtmQH91fuPyNYNTC7nKAdZJIBpaHBJAthRyYtybjKR/a2yIMdCt3MlSaTEO8LZB/zEyWRnuKrJ9eZaIAni+m87E3WJxEWYTrtKXvSpH0UQyaPo4bGWjr3rgyF8JqM8gz7QGiMmHnwswDau/+0mJeoN/1ULe9FvH0nryLlcxNb13GutyyZGQAFFJesn3LeoO4x7CEx6CZSnpQ6BHF6MDzseFu4MBIcF/cgT4LvsDoXjKC04AQAPQNxAphILPED8QTSfV4W2OFVDydoXeU+a4PPTyB6p3q6KUao/Fy2dyAbr+GzZwbDJAN1UnqoQ7XruuOi2rxU42RbToTRndXr0ysxBJyxujfyxHuLdOlDJt4zzEZ5dg1WU2ZzL4BQuuT24YNXaiKu6qIKKwGtqjYRAerRU3dMo2j+cWGR+c/OCcvRUUwI8B7wgM4sHE7HRXYAQVLyHdG8xbtqNc70WtLJQPOdeL9DWGgeEvvYNHkXOCvvhFEK6Mk1ngRZeedDyfjuu9RvYef9DYnk1wAQ4gSHgJkV4HQQObgOj1feBVdngf6Ov81xU2nUNI4nL5iriMs/jg/3cZ0rMGeuCrNr5e5oJ6gKqL6znHxOYgkWawk6XazbrUBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NO51WPaturr3hlCqyxDuiq/x7+aKrSy4fncjLEE+jA+rjy1q6ieE1Cad0QhYBXHOZkPTZdMcc2+iFnrZxcoqM/KUyag/siAXHX0T1W9Pg4GcX1RlQ7mMZNzFyld7QnV1bKluEGWen/ibHLVorcDdpwLlPkV07knGafjW4/zX7z7IS7jTgwAQ4i1FdQu86WQlVEA/6jEBsCgAtmh7AueML+sClNqf+ipogrJny/Ag2d0u9okXnx0LvWw7o1JFb5aVp49QoYOAjfs6HZ/C9f8f/XviuudEQ1uz4TjuBKNFmMRdxNzN/Kbm9JCDL5wRZkpAHLZe3J/uWgjgvQik1j7sToTaxARtR1A7gUUrVrKdUt9HFNC5laVU0l/2Simzi6RG0CAv1DsqBZSt1aX4ASj5mQPiI25tcOmuf8I4ruluSLhzJrVesYcRGrP9H5JuzMkn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 02:21:46.2183 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c07e9fec-b98c-4c08-2013-08defd989e20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7196
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

On resume, amdgpu_userq_vm_validate_and_restore_queue() updates each queue's
wptr GPU address via amdgpu_bo_gpu_offset().

WPTR BOs are VM-mapped, but each BO has its own reservation object and is not
implicitly covered by the VM validation path here. This can leave offset reads
without proper BO locking/placement state and trigger WARN_ONs.
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

Add each queue's WPTR BO to the drm_exec ww context and validate it to its
allowed placement before the later offset update.

v2:
- Clarify that WPTR BOs are VM-mapped (fix incorrect "not part of VM" wording). (Christian)
- Describe both parts of the fix: lock BO reservations in drm_exec and
  validate BO placement before offset reads.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 24 +++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 17cc48d87c4d..ab8fc14a235b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1054,6 +1054,30 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
 		drm_exec_retry_on_contention(&exec);
 		if (unlikely(ret))
 			goto unlock_all;
+
+		/*
+		 * WPTR BOs are VM-mapped, but each BO has its own reservation
+		 * object. Lock them into this drm_exec ww context so the later
+		 * amdgpu_bo_gpu_offset() reads are done with the BO resv locked.
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

