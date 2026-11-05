Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BC9606A326
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 03:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=yYTFuxd0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE34610E924;
	Thu,  5 Nov 2026 03:06:46 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012017.outbound.protection.outlook.com [52.101.48.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE93610E924
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 03:06:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+fctLqiN5QDWP96Ev9OALCWZpettIXcF4R++BINPFYVvgMEUNMnIXR8Pb8xJ8KJzrjfJ2UPN99JLu3UpvHKm7dU5MRMfsRGOgap5knfIl6M/NEjN4mVKJJ3LBLZeWcJjnn7bhKYdjomvQcGTEs9bWY00R9Ll2gx1R8uELmb09qGxZHLw3kR48KaI9M/roZAofe33hQ0bI19qjBUAR3YvAUcRujF/UPGznyJ+rBIoJo45dogy0hS71lw71cLbY6owyllxJzZ/qfayIPfajkUyVy1RuzDMK1vSyvgZrdPESFSbo6sYEok0+N1MMl82h79bMud8VhlPS+agFDUxIKixw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwAP66XDrJOBUwgnZiX9ZxL1RcFet9nARVyFxy2l5zw=;
 b=ki1035z11AtYas3tqfWnTgO/g4BAzdL64d+LRf+dT3ySdsTIW3fMrPEeaqLtp09bCWgUSWiwejTFGgcqHp1awAeDTtKRvpsG1GnxiPJ1kSdTKY9bVyAPnqpLsxutE8RmbNt6CQpRrcxImH55iRU2oc5/TDQe9QA+GR0iOoSgU4CVv14GNfOP3Vo1RzzAxiO+6+o73njtvGKcFUBTt8pzWR2eLzNIc2oEOEt8tXW4Y0N5daUtVyvhuM4/+MI0GffFhDrSdXGymT4gidy35X03jTN6ws7jYWmEVnRuTlY5z2zSCy8UFizF9pc/s+USLXAmolGdxKPwUpSd7loVLBgo/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwAP66XDrJOBUwgnZiX9ZxL1RcFet9nARVyFxy2l5zw=;
 b=yYTFuxd0bK0gdK2SyEdus2lTFp5pi7xBdg80n032PouUuq9VrWjNPaguGCvDyKntEVzHllCSgNtXWHblkL3i4fQ7f4YiJfL3oI+lJGCKIQJSzU6a7lpGHISOoYOCfEhrlhE7OHWNy/F5mGwhvBI0qjyGHrwqcacje/B5lOHVCS0=
Received: from CH2PR14CA0033.namprd14.prod.outlook.com (2603:10b6:610:56::13)
 by LV3PR12MB9095.namprd12.prod.outlook.com (2603:10b6:408:1a6::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 03:06:37 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::3f) by CH2PR14CA0033.outlook.office365.com
 (2603:10b6:610:56::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 03:06:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 03:06:36 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 21:06:31 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 21:06:30 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 4 Nov 2026 21:06:28 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <timur.kristof@gmail.com>, <Mario.Novales@amd.com>, 
 <Manu.Rastogi@amd.com>, <Jiongyu.Zhu@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH v4 07/13] drm/amdgpu/userq: add a helper to signal the fences
 of a queue up to a point
Date: Thu, 5 Nov 2026 11:05:49 +0800
Message-ID: <20261105030612.726542-7-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261105030612.726542-1-Jesse.Zhang@amd.com>
References: <20261105030612.726542-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|LV3PR12MB9095:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fc41a78-bc71-40de-0d6f-08df3ae9cdf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|11063799006|56012099006|261021121427099003|261009223027099003|261102123227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: AIDBWVZX7tcHdZT11io2nLGjgppGKVP0mHzpGQwz5oX+l/ziAoX+MKdLuIvgBthSLfKyc3phL2r+7YH4g+0JLQ2E0Fy+Dh0YJ9CXecZKjc53tB/iXGOtAXQcOgIrXVU48y9Aw/eGsFbdoiPITIZCWkH2LWlgcQq9FUdQsWWyZtDN4tRc2Hu1lO0cvHmNb7UqLvmraal3NPH3rfSHQUgkcTtRBZS+XyErHw7xZGvWqcv/ysSMgTva68RK2F5tELTMWB1RFg2U96jBm8lJaRFy7EvQgKDt27pZ2xxAWq+hrNdcb3nZvhU0qGYVCxG0HBK5Ei/A+jGxqDkWDjvs1ZT0gqAQjZ5inTgzhcYrLjftQzHk7oFSY+GfThNylMQ+7xVI9ahFp2hZLu+wBiSNxeUQNPGzGyri/EKTv6VKi7aqWmLOlQp1nbR0OyzpBCd/pb40rySx79xksLUzsk1cwxV9ndwvuhC4q+2f35So2/OhyTygVuaMAwN92PDT33Aoc0ehvcb+jhf3GmkNFZOYJtOtupyHpawHnujlsn1cbp7XdLJCDB/Y72jZh7punvOE1gvHuQnR3j+OO+vuPmoxcTE6LPYhej2bfDdlHytQ0cANVy3RALh09aWbmRFlHGNk0aZKCIODChn5SxvRtFQsOb92+2UOs1mU2E25ZII2FYBkrqcc9ceqx/uDAefZdj5SS9G/pZ6L1L/DJH2qyjI5WWYLzw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(261102123227099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WRzcQELqoNyFmXpIZ6P2Ad3C7DUUo8gEdakOlRlkvvVApSyhfGLOMrekev91e5BNk1+ghnCgUCd7zo2mIXxLmHphDJpr3xcdpPJpa/vLu+j4CSVNsjUPrK7Zo9qL9Zs7MPwmUZPEfzTQvJpCH97BCqMTx/xG7NL/2x3yIpMasOE6jciHGMUwcnqkE99I4NEZdI3AjjumiwgzbdmJ7/8Fqxf2wbUdhaY5rwGE8aoXUemmnL035tU2hfEKjxh5DxODZiknMhYuaNzZ/9CdNkD054LKMnQGf713GIlkR2ao28wjLk/XST9AMWH3dYfthhRdz8IPrgiJxE/tg/lAu+m/X6lGYur7GEYN8lyiBSL9OFFH32IBLp0T2bXX99sAj6Qg9paHLPL9K/OEq1wSl0ITBTPwFhHR/0IsKkX68EHGB2NxscBXkNID77A1GzAtyYLm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 03:06:36.6524 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc41a78-bc71-40de-0d6f-08df3ae9cdf3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9095
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
index dd976a50e053..d20dce32168b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -460,6 +460,37 @@ amdgpu_userq_fence_driver_force_completion(struct amdgpu_usermode_queue *userq)
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

