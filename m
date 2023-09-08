Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD294EE8015
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Sep 2023 16:06:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65B6C10E35A;
	Fri,  8 Sep 2023 16:06:16 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2086.outbound.protection.outlook.com [40.107.95.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F1E110E0C9
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Sep 2023 16:06:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2PpW5hB7stnCXqkuebCCD3dWZ7nuN4LGPElVpA1AUhlaAjQNodN9tK22hHyM10iKyctdw5RNEorXtrhoqVPpgI2qsD6rLd4S9ph1g4H/QOHtiNAr0e72OSKQYP2Dr69lXisOsv/AQiLkxe2OTdnI9EvzW7Z4xyrmv3TvfeZc8goWGC9ytQl06J/V3o2QTWDy1gsgulwD58UTe8299xzeazgxJ30rDPJWcWIhRMc+oKAYeR9sfvrintg3d32QO+uWLHapYs3zsZ2zX275NH5KguImeUhTMz8iX4fiBS1m8S9d2xv1NVYkuYd/c36d8oN0gdQzHKxb/uRK+xO1n8OSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ry1WbS0dCiwKaZrd23nsyC6T5xQzw4YWr4Cg3u4zeTc=;
 b=FEC/AAYpCSDQulKrp+m08kgqYX+wFnOq0IUMxUC+UV9FofFtzDGvihP3HZkOGK1uyng41nffwkAJWMo8h8Ek6t3YZN31v6TvucBuzhazG60FgpwUfBS87fae40C/W0DZ0KZbsYE2GjXTl5nbx9j7JAk+9zx5WkdB7P/H2URdnvzMEZgqR4RnHHIcCZLPNA6KzXdBWjdCL+nAlrYdg2eKtq8hfine8Pa1M0D1J7y9ljKseJt7kv6IhXiHTctbv9GumeLIyl1QWyv+QGUyNzteV02MmVYuwzo4ZEjap8o6ugqJJTeCAjZf2tC/oBBrwrR5cd356GQXLrjqbhOB+XvWxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ry1WbS0dCiwKaZrd23nsyC6T5xQzw4YWr4Cg3u4zeTc=;
 b=WTs9kGiOziXOtNvTGM99p2dDw/nlSn8SHVFdbA+mUQXBymn0LE+CzNr6+WEykTvPhHsLzPrjoO9Hs3rEjhEiuuITLjytHACL9T9QuySp7gVeON9v1FdNq8bWszv6l+pat24c+o0FbUWDDJXWnBgjFJ5LHJxzuMK8hnQAIh68Kc0=
Received: from CH0P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::21)
 by SA0PR12MB4368.namprd12.prod.outlook.com (2603:10b6:806:9f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 16:06:13 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::97) by CH0P221CA0020.outlook.office365.com
 (2603:10b6:610:11c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31 via Frontend
 Transport; Fri, 8 Sep 2023 16:06:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.11 via Frontend Transport; Fri, 8 Sep 2023 16:06:12 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 8 Sep
 2023 11:05:06 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v6 3/9] drm/amdgpu: add new IOCTL for usermode queue
Date: Fri, 8 Sep 2023 18:04:40 +0200
Message-ID: <20230908160446.2188-4-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230908160446.2188-1-shashank.sharma@amd.com>
References: <20230908160446.2188-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|SA0PR12MB4368:EE_
X-MS-Office365-Filtering-Correlation-Id: 539cfb4b-7205-4acf-7a2f-08dbb08585f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jtEQSAoeflmV944f4sL+Y3XtFsG5hnMZf1P6L9rwvzvLSyqnxZBdp8fgyMux7r3oOBXgY0kYNdwI4Kjir+E5P7JhQb557rAPTTZk230r/IWjv4HMeajEciLBmmVDFzR7AMLdI0O31CEDu8sVCHi7/BkCCTEoHO9C8fek+ZSJyjDux/HqpXkjjBNgD6x1/4V58j+IKWQm8stM3Uu+MFVUtjVp8MPDuYUF5eIGhwjQGs8J5VQRjvG0oT9JQ/PDo+1oHHSjYfMzRfreJmfnKi5Nh8g/thPs4iCprqpruT5io0Tg01as3wcBaqVF6ineC4okz5nrABOZKTM5TdyjHYyZvsLJwmBu2RNiccUXYb5EQU+4CJh77V/9f5RZa5wEz/wAc2HfA2+rpFrQM471Adi/Qu2D/dWtYLHcuZt9DCFYXweCSSpk6rgz8nVRJ69glBKfF5gRBUJrCBBmlcv5WI8FpbnqKLV0+J8MBWZ87r43ym4bdO14keRNQ8++6TpvVqYgHz8zsQ/HCxyj8N2SpfY1wIesnZ/W7Ub1kj0MK/rcgj+nUi00VTkHSq8zs8bweHpo9y80G6bJ7LYB3NezZbyLThAofWaQt71ZDYdz5cGA+YAk8b7Ur8EyyBg7x53NjQafJ9GZQwye99Tw7v2l0CVpiVR31KQ5xG7FcEUzwCpzgvC2N46TJJ8Ypnf+l4JWXENPNhFmZrz09jrdw10jcOogoA4X4zmxsOH4ULjMpkeQSyIeqCQQNZ+fG1RfbP2Em3B2k3hyX8N99uLPCYfINn4u6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(82310400011)(186009)(1800799009)(451199024)(36840700001)(46966006)(40470700004)(40460700003)(2906002)(86362001)(2616005)(1076003)(426003)(336012)(26005)(16526019)(36756003)(6666004)(478600001)(7696005)(36860700001)(83380400001)(47076005)(356005)(82740400003)(81166007)(40480700001)(4326008)(41300700001)(8936002)(8676002)(44832011)(6916009)(70206006)(70586007)(316002)(5660300002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 16:06:12.6806 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 539cfb4b-7205-4acf-7a2f-08dbb08585f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4368
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch adds:
- A new IOCTL function to create and destroy
- A new structure to keep all the user queue data in one place.
- A function to generate unique index for the queue.

V1: Worked on review comments from RFC patch series:
  - Alex: Keep a list of queues, instead of single queue per process.
  - Christian: Use the queue manager instead of global ptrs,
           Don't keep the queue structure in amdgpu_ctx

V2: Worked on review comments:
 - Christian:
   - Formatting of text
   - There is no need for queuing of userqueues, with idr in place
 - Alex:
   - Remove use_doorbell, its unnecessary
   - Reuse amdgpu_mqd_props for saving mqd fields

 - Code formatting and re-arrangement

V3:
 - Integration with doorbell manager

V4:
 - Accommodate MQD union related changes in UAPI (Alex)
 - Do not set the queue size twice (Bas)

V5:
- Remove wrapper functions for queue indexing (Christian)
- Do not save the queue id/idr in queue itself (Christian)
- Move the idr allocation in the IP independent generic space
  (Christian)

V6:
- Check the validity of input IP type (Christian)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 116 ++++++++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |   2 +
 3 files changed, 119 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 2a89e303c3db..214a66b33dfa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2830,6 +2830,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_VA, amdgpu_gem_va_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index effc0c7c02cf..44769423ba30 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -23,6 +23,122 @@
  */
 
 #include "amdgpu.h"
+#include "amdgpu_vm.h"
+#include "amdgpu_userqueue.h"
+
+static struct amdgpu_usermode_queue *
+amdgpu_userqueue_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
+{
+	return idr_find(&uq_mgr->userq_idr, qid);
+}
+
+static int
+amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
+{
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
+	const struct amdgpu_userq_funcs *uq_funcs;
+	struct amdgpu_usermode_queue *queue;
+
+	mutex_lock(&uq_mgr->userq_mutex);
+
+	queue = amdgpu_userqueue_find(uq_mgr, queue_id);
+	if (!queue) {
+		DRM_DEBUG_DRIVER("Invalid queue id to destroy\n");
+		mutex_unlock(&uq_mgr->userq_mutex);
+		return -EINVAL;
+	}
+	uq_funcs = uq_mgr->userq_funcs[queue->queue_type];
+	uq_funcs->mqd_destroy(uq_mgr, queue);
+	idr_remove(&uq_mgr->userq_idr, queue_id);
+	kfree(queue);
+
+	mutex_unlock(&uq_mgr->userq_mutex);
+	return 0;
+}
+
+static int
+amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
+{
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
+	const struct amdgpu_userq_funcs *uq_funcs;
+	struct amdgpu_usermode_queue *queue;
+	int qid, r = 0;
+
+	/* Usermode queues are only supported for GFX/SDMA engines as of now */
+	if (args->in.ip_type != AMDGPU_HW_IP_GFX && args->in.ip_type != AMDGPU_HW_IP_DMA) {
+		DRM_ERROR("Usermode queue doesn't support IP type %u\n", args->in.ip_type);
+		return -EINVAL;
+	}
+
+	mutex_lock(&uq_mgr->userq_mutex);
+
+	uq_funcs = uq_mgr->userq_funcs[args->in.ip_type];
+	if (!uq_funcs) {
+		DRM_ERROR("Usermode queue is not supported for this IP (%u)\n", args->in.ip_type);
+		r = -EINVAL;
+		goto unlock;
+	}
+
+	queue = kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNEL);
+	if (!queue) {
+		DRM_ERROR("Failed to allocate memory for queue\n");
+		r = -ENOMEM;
+		goto unlock;
+	}
+	queue->doorbell_handle = args->in.doorbell_handle;
+	queue->doorbell_index = args->in.doorbell_offset;
+	queue->queue_type = args->in.ip_type;
+	queue->flags = args->in.flags;
+	queue->vm = &fpriv->vm;
+
+	r = uq_funcs->mqd_create(uq_mgr, &args->in, queue);
+	if (r) {
+		DRM_ERROR("Failed to create Queue\n");
+		goto unlock;
+	}
+
+	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
+	if (qid < 0) {
+		DRM_ERROR("Failed to allocate a queue id\n");
+		uq_funcs->mqd_destroy(uq_mgr, queue);
+		r = -ENOMEM;
+		goto unlock;
+	}
+	args->out.queue_id = qid;
+
+unlock:
+	mutex_unlock(&uq_mgr->userq_mutex);
+	return r;
+}
+
+int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
+		       struct drm_file *filp)
+{
+	union drm_amdgpu_userq *args = data;
+	int r = 0;
+
+	switch (args->in.op) {
+	case AMDGPU_USERQ_OP_CREATE:
+		r = amdgpu_userqueue_create(filp, args);
+		if (r)
+			DRM_ERROR("Failed to create usermode queue\n");
+		break;
+
+	case AMDGPU_USERQ_OP_FREE:
+		r = amdgpu_userqueue_destroy(filp, args->in.queue_id);
+		if (r)
+			DRM_ERROR("Failed to destroy usermode queue\n");
+		break;
+
+	default:
+		DRM_ERROR("Invalid user queue op specified: %d\n", args->in.op);
+		return -EINVAL;
+	}
+
+	return r;
+}
 
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev)
 {
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index 79ffa131a514..55ed6512a565 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -55,6 +55,8 @@ struct amdgpu_userq_mgr {
 	const struct amdgpu_userq_funcs *userq_funcs[AMDGPU_HW_IP_NUM];
 };
 
+int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
+
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev);
 
 void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
-- 
2.42.0

