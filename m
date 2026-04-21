Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A32F94CA3
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 18:08:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD10C10E931;
	Tue, 21 Apr 2026 18:08:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RqjYdBRm";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010040.outbound.protection.outlook.com [52.101.61.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 868FF10E930
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 18:08:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HIIK2m6II8ot1vpimHISKILqHDyJREs7RL2mIE/5c+Tul387bYOmdqyhO4OAQdsWsdfKCkXCFd+dhx0QZnYARswrDsO7Wya22nZ6LEOTQlDaoZkOnDXhGZ1tA9omb2bbGcZUNYyuJFX5aOPhyBOdKaVaQhUXU0vtxhFGanVjFJzvs/NPoN4c+/P7Egs05bnfZ05dJe7sluTo/4oggK2fukpK2+IMiACWiP+4rZPoY13O34Ph6f657XWY0ZMCYJPj2QPFYVhQARzHVh/qDx9TdA3sc7Pl3MchghSUiancHqZ1V+jteaRPSGZ6l9L1QkE+RRDbC7EMHd68vcPtkOKy2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cm82KRHryr5AFjspdbfuHHwZGkWDB7ntRXQQpSu/h64=;
 b=KTMpT9DdQynVkLPcrECahxuzczneVS2dx+iRw05uILeRo7k8CgvrxQ16HuZR/O3Dl7BLAMt5Zda+WxWT2jk2fAX2qPI0Ui31g9MjxlzfBnn7AQ6tVhAQpyGdoADH9m1lUCbheUaW9Fa43axvjKRHBAVwxlRHUU+n1MoEYzyZZhM7nYPtJLDUHkRZsZC48Tg7qsVG+BwVb0PwVFH4QckH/SAb4ONHoJiW0UlgfPKrToU1ky5WrBo1aKijwJ5KC3/M4iXyYDFDlJYnQOminZVNkip7vPBOXwS5/bMqq5bpIulVDvE8iqgB7Zjm8wcXGYgx+caG1GQjN7H8fYU/CO+8+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cm82KRHryr5AFjspdbfuHHwZGkWDB7ntRXQQpSu/h64=;
 b=RqjYdBRm0TE/iNx3YpmVOkKVGvlQiwpDx4p/zGc6ARQ1AAwMRSSeBeDgus0BcL6SUE8DTPn1H5Eng07csEqSH/fQX+Ep1YFeeeLdo6XOHXBrQZNIzLfUo2SOU0e87Q+l4qWP5M5wXAWJ7JusKLHcfr4Oll+iUR8MniFFH91IG1w=
Received: from BN9PR03CA0453.namprd03.prod.outlook.com (2603:10b6:408:139::8)
 by PH7PR12MB9104.namprd12.prod.outlook.com (2603:10b6:510:2f3::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 18:07:52 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:408:139:cafe::29) by BN9PR03CA0453.outlook.office365.com
 (2603:10b6:408:139::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 18:07:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 21 Apr 2026 18:07:52 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 21 Apr 2026 13:07:50 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v5 09/11] drm/amdgpu: Detect queue reset in WAIT_EVENT
Date: Tue, 21 Apr 2026 23:36:25 +0530
Message-ID: <20260421180627.2402093-10-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260421180627.2402093-1-srinivasan.shanmugam@amd.com>
References: <20260421180627.2402093-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|PH7PR12MB9104:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dd9c857-46cd-4b0b-9f8f-08de9fd0e7e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: XfFSWM0c+yIjPEJpN5Z3I/XXX7w5SfDFe90ICfccSSZv2F2zCvslYOkftqh46RipLMt9F3jcQGCziXPP9mST621hH3ghDIl4NoSA22yMWK7K1je5k4Zgr0gn0rFngnLy641meQ5jV4+zRn3e7SO+reqGyxvREP8AM8iL7IpSaP+D/475UbYex+SsEm0Ltc0GjCP1DfoJswavd/mMtCNLOvSbiRji+VPN15w4JyREPggIhrTJo2eXWSod8KwV9yxP/Y4TWxaUIo+Q5Kqqf0z2rwrP2Wvoj3HdP99C9JkNAHIgSNpdE/Z4bpk65i3dvm4GU0fyu1nQ4vsPx+Fsn14VfxWXKRDcq6d+8PwORRW42oVNcUtiTSyMtwFDU9OdiwOdL6OCJJ3BGutDRTZaZvq0Yp252P8150AqntThV8BFPubISCTprGLgiY1xyl6589CvqfY6oWsb6j3974K0qiP8urXsJR9DBR2A93is1fjHOeRtZor8cKUrpcfdwp4ouCixwninQLORd3LXE6uGxtZh4eS6J0qlZcwONc3KR9R/USBYqpv5k1253kgsUJIioMaaqzkXDHUvQD6eNoaTLgox+WcmSjy5Urz++97CUQkF6cs5F7HDhlkbZiIuZRGneTvfXSs+zw4L+yvlhwnxbxfWXT7SNjUqSu9PR98/9EHMSkBA87ksI9Ub8L+UZTlqEqJbSOXVQpM2np4bgjsB6Xvvxw/3nokkoOIdJDuujBrdvmw/y/HovsxwBoahMgozOCPchKw7+sVqhdIQJs0UxD+8Tw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vI+D8fe8PKinY/FR79EmB9KzKorPwd1RO9BsADHJou71Aar0ssScQr8zJXV0y/Fx+O42mp4KMlx0xZUfSsZsyGQQXHcNcFrnNDv2Gf1LdqAlyzcOgAyeSwdHsDFEKizo29OzqR9esUVm0FHzeD6nWtA/jOoIOtgBuubnSy3jns1M5wBQg3rUDqJ1z1SZzqRMsqMFNojuUfkrIyYGIDXmwPXYw6OBTkTGwj7mgvO2qB2iVYfP8ykb/g+6DzJoZj7hSt7nNC6VPao39skbihzOXr9DAqBeke7mElkqJMmQ+klmd9n7wg+R5iL3zn5RlFXoomQib14S5gNjKqyeTOikCw2ilC3QZp48qEte64athBCtAXCqJgM5ZRoDHowLYQdF1BiEYc9pXOkCT7rp0MhgBr+1Bb2mRaE86sYPN0NhZQQ9flfG4CSLVeLTZLRrGYk0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 18:07:52.5550 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd9c857-46cd-4b0b-9f8f-08de9fd0e7e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9104
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

Detect queue reset while a queue-scoped WAIT_EVENT waiter is blocked.

If the selected queue enters the AMDGPU_USERQ_STATE_HUNG state while a
queue-scoped WAIT_EVENT wait is in progress, return -EIO instead of
waiting indefinitely.

The queue lookup uses the same doorbell-index keyed user queue mapping
used by the existing USERQ_EOP path.

This does not change WAIT_EVENT UAPI semantics.

Changes in v5:
- Use queue->qid instead of doorbell_index for queue-scoped event
  handling (Alex)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c      | 18 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h      |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c | 14 ++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index f0deb44e9845..6fb656f42690 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -170,6 +170,24 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
 	mutex_unlock(&uq_mgr->userq_mutex);
 }
 
+int amdgpu_userq_wait_event_check_queue_reset(struct drm_file *file_priv,
+					      u32 queue_id)
+{
+	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
+	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
+	struct amdgpu_usermode_queue *queue;
+
+	rcu_read_lock();
+	queue = xa_load(&uq_mgr->userq_xa, queue_id);
+	if (queue && queue->state == AMDGPU_USERQ_STATE_HUNG) {
+		rcu_read_unlock();
+		return -EIO;
+	}
+	rcu_read_unlock();
+
+	return 0;
+}
+
 /*
  * Start hang detection for a user queue fence. A delayed work will be scheduled
  * to check if the fence is still pending after the timeout period.
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 4c67f86984cb..d3f63cc6e118 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -160,6 +160,9 @@ void amdgpu_userq_pre_reset(struct amdgpu_device *adev);
 int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost);
 void amdgpu_userq_start_hang_detect_work(struct amdgpu_usermode_queue *queue);
 
+int amdgpu_userq_wait_event_check_queue_reset(struct drm_file *file_priv,
+					      u32 queue_id);
+
 int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
 				   struct amdgpu_usermode_queue *queue,
 				   u64 addr, u64 expected_size);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
index f900a7f5f90e..3bdf5b4e40ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
@@ -29,6 +29,9 @@
 #include "amdgpu.h"
 #include "amdgpu_wait_event.h"
 
+int amdgpu_userq_wait_event_check_queue_reset(struct drm_file *file_priv,
+					      u32 queue_id);
+
 static int amdgpu_wait_event_do_compare(u64 addr, u64 value, u64 mask, u16 op)
 {
 	u64 rvalue;
@@ -282,6 +285,13 @@ void amdgpu_wait_event_push_gpu_reset(struct amdgpu_wait_event_mgr *mgr,
 	amdgpu_wait_event_push_common(mgr, &data);
 }
 
+static int amdgpu_wait_event_check_queue_reset(struct drm_file *file_priv,
+					       const struct drm_amdgpu_wait_event *args)
+{
+	return amdgpu_userq_wait_event_check_queue_reset(file_priv,
+							 args->queue_id);
+}
+
 int amdgpu_wait_event_drm_ioctl(struct drm_device *dev, void *data,
 				struct drm_file *file_priv)
 {
@@ -348,6 +358,10 @@ int amdgpu_wait_event_drm_ioctl(struct drm_device *dev, void *data,
 		if (signal_pending(current))
 			return -ERESTARTSYS;
 
+		ret = amdgpu_wait_event_check_queue_reset(file_priv, args);
+		if (ret)
+			return ret;
+
 		if (!timeout) {
 			rec = amdgpu_wait_event_peek_match(mgr, args);
 			if (rec) {
-- 
2.34.1

