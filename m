Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76A2C05027
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 21:54:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 055C410E91C;
	Fri,  3 Feb 2023 21:54:51 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2047.outbound.protection.outlook.com [40.107.102.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C69AD10E91F
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 21:54:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LH4olniuKqPI6RPNR1V6GnLj/uXmmVYIBTAwjzsLsmE6yaAy8jFogyPKmJQzAUvBFUcbtFTrbnwt2nfgcKfAgqOgEQqrvAcu0zL8ErwUQndjvc8436B6P+C7EzHdst0PF4uod1D5ZJFzqRj2yIUfh5wox55ovAFYGoMcBKEwJ0CyWKb77ccaF34a+idLMZXoYGaSJrDxvTjI37pm0IzqVQ8zweYd+KaIqzxzlHI0f/JRKouNHr1IdZJLENek4BsVxiU4SivOG8HbMToT3fp58njReG4NoEET5ywrB1u6QhKATSkM6osdenYu3DuUcU5j/E0K9HV4BjGE7+Vcso10iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2Wv4S1avYxurA/NGVppBMBY4ftqzN0MgdbeDBK7qLQ=;
 b=jfTd1TcyFC58DsSGcs/m8JF5BJbk8mDKX8YGAXCMWhMrVp3/iosfss0qBh0rr+OZGUtUmPBxgBfL/rXsB6Ux2jnkIMrzL9sgND17QiOhUPffKdAGIILpn7WoYGjDtt/LqxZUDaJYei+eSp14/wyv1RHz0WxBKBN+om618a49UOQr3ng2jOqpB0qBU1Ki8LRa0XntzGzBQBuqwIk/jWqn0Rv7pOnmw0pU+0zRCPQusu65v1RaFj2KG4bFpGXxOpqR1uU6/Zytm1JHwDKrV9IcH8BlME0TexFWqKVr0zCJtT8gKEDbSN1dU9MpZcNZSNRSo65ebl3fYjcAn9cRdjWJGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2Wv4S1avYxurA/NGVppBMBY4ftqzN0MgdbeDBK7qLQ=;
 b=ABCjgXM77wghkoVEi2+vTLBn/6/de4koZc5aIR+0GtVkatm7qR4PfZS8u4/wXS345qIvosxJkxdRH2/5fypiKs6mkX1oNVBfLw3RBxw56Kx2FedYQr8QBeCyn0QiQN2J3okAe6sBuZyBkmta2gydReKgpU3dp0ryJU6oDeOuia0=
Received: from DS7PR03CA0253.namprd03.prod.outlook.com (2603:10b6:5:3b3::18)
 by CY5PR12MB6227.namprd12.prod.outlook.com (2603:10b6:930:21::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Fri, 3 Feb
 2023 21:54:46 +0000
Received: from CY4PEPF0000C97D.namprd02.prod.outlook.com
 (2603:10b6:5:3b3:cafe::22) by DS7PR03CA0253.outlook.office365.com
 (2603:10b6:5:3b3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31 via Frontend
 Transport; Fri, 3 Feb 2023 21:54:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C97D.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.17 via Frontend Transport; Fri, 3 Feb 2023 21:54:46 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 15:54:44 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 8/8] drm/amdgpu: DO-NOT-MERGE doorbell hack
Date: Fri, 3 Feb 2023 22:54:09 +0100
Message-ID: <20230203215409.2021-9-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230203215409.2021-1-shashank.sharma@amd.com>
References: <20230203215409.2021-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97D:EE_|CY5PR12MB6227:EE_
X-MS-Office365-Filtering-Correlation-Id: 56f98ec0-4e89-471a-ae5d-08db063143ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o519bXv8sEaW6kz9n7/ShlOrIkd8xxjxpr+Ey+Is10c+2HdhfS0/35D5UHVw1yUWY/ngv8cBaU/zXcUNEVEJjORts4AUAJ4H725HQUEZ4ofwTyPCIcuR+VE537fPKkwQDO0uX3Mzs/HRb3AWhy1Gb+lA967LYGC6QNgLWwOlIJ1RSEKdJRj/+ItAkNUg15AuVasKRpSBcCw6TA4Zt84rOFdNbrar6zNZa+YLhN/Qad6nz5PQN7LOL9UaFJ4ETVMhrEEDDeX04dJNYr7KJD/3iw8RJJoRqFp9sguC7phAMoT9p6zWXzfVoUU9CQwxjQM/9gGV4TSwZv8+EAitI3KkMd82Pvcj38NUUkTo0sNP1n87AA9IDtx8966GceUMejSMdyN34avVELN7ByA+xSowU/KJp66XL7f1cukwKJApDHCKaYZVUVaStZRV+/5ALYUWUVpg/No+t5Mlx/HkwXCDwwhTnIYyR8X7yhMeRCeOwqnu9tc9ND1wtDhzLKyfDgrPdEgs5ly2kj15p74OsyUTneG6yZ4IPJO9X7T+RWWBaPxAdIKJ46QV1GMYVR3WaaAwPER53n5GZrrlNMc1UNvXC63d6YqcDX6kmr9hsVwE9zSHS0zYgEw+PrK2mGeZLN/P5DoCCBZetHZvPGeG8KwXsPSeQ4Np49IX1snFzf3ujetG76qKiZRDnGMd+fRlNf3T
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199018)(40470700004)(46966006)(36840700001)(47076005)(82310400005)(83380400001)(336012)(66574015)(426003)(86362001)(40460700003)(81166007)(356005)(36756003)(6916009)(36860700001)(41300700001)(8936002)(82740400003)(316002)(54906003)(70206006)(70586007)(4326008)(8676002)(966005)(26005)(478600001)(2616005)(1076003)(6666004)(40480700001)(5660300002)(44832011)(2906002)(186003)(7696005)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 21:54:46.4581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f98ec0-4e89-471a-ae5d-08db063143ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C97D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6227
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
Cc: alexander.deucher@amd.com,
 Shashank Sharma <contactshashanksharma@gmail.com>, christian.koenig@amd.com,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Shashank Sharma <contactshashanksharma@gmail.com>

The doorbell patches, being reviewed here, are requied for Usermode
queues:
https://patchwork.freedesktop.org/series/113669/

This hack patch adds a doorbell IOCTL just to test the usermode
queues functionality, and must not be merged.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>

Signed-off-by: Shashank Sharma <contactshashanksharma@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 19 +++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h                 |  6 ++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index a28ed8e98f7b..b8715dfe27bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -33,6 +33,8 @@ static inline void userqueue_busy_wait(unsigned long ms)
    }
 }
 
+#define AMDGPU_USERQ_DOORBELL_INDEX (AMDGPU_NAVI10_DOORBELL_GFX_USERQUEUE_START + 4)
+
 static inline int
 amdgpu_userqueue_index(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
 {
@@ -208,6 +210,7 @@ static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq
     queue->queue_gpu_addr = mqd_in->queue_va;
     queue->flags = mqd_in->flags;
     queue->use_doorbell = true;
+    queue->doorbell_index = AMDGPU_USERQ_DOORBELL_INDEX;
     queue->queue_id = amdgpu_userqueue_index(uq_mgr, queue);
     if (queue->queue_id < 0) {
         DRM_ERROR("Failed to allocate a queue id\n");
@@ -276,6 +279,22 @@ static void amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
     kfree(queue);
 }
 
+int amdgpu_userq_doorbell_ring_ioctl(struct drm_device *dev, void *data,
+		       struct drm_file *filp)
+{
+    struct drm_amdgpu_db_ring *in = data;
+    struct amdgpu_fpriv *fpriv = filp->driver_priv;
+    struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
+    struct amdgpu_device *adev = uq_mgr->adev;
+
+    mutex_lock(&uq_mgr->userq_mutex);
+    WDOORBELL32(AMDGPU_USERQ_DOORBELL_INDEX, in->val);
+    mutex_unlock(&uq_mgr->userq_mutex);
+
+    DRM_DEBUG_DRIVER("Doorbell rung\n");
+    return 0;
+}
+
 int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 		       struct drm_file *filp)
 {
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 6c5235d107b3..2d94cca566e0 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -55,6 +55,7 @@ extern "C" {
 #define DRM_AMDGPU_FENCE_TO_HANDLE	0x14
 #define DRM_AMDGPU_SCHED		0x15
 #define DRM_AMDGPU_USERQ		0x16
+#define DRM_AMDGPU_USERQ_DOORBELL_RING		0x17
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -73,6 +74,7 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FENCE_TO_HANDLE, union drm_amdgpu_fence_to_handle)
 #define DRM_IOCTL_AMDGPU_SCHED		DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
 #define DRM_IOCTL_AMDGPU_USERQ		DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
+#define DRM_IOCTL_AMDGPU_USERQ_DOORBELL_RING		DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_DOORBELL_RING, struct drm_amdgpu_db_ring)
 
 /**
  * DOC: memory domains
@@ -350,6 +352,10 @@ struct drm_amdgpu_userq_out {
 	__u32	flags;
 };
 
+struct drm_amdgpu_db_ring {
+	__u64 val;
+};
+
 union drm_amdgpu_userq {
 	struct drm_amdgpu_userq_in in;
 	struct drm_amdgpu_userq_out out;
-- 
2.34.1

