Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3345C77B61
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Apr 2023 17:39:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57C1B10E59A;
	Mon, 24 Apr 2023 17:39:21 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5424710E5B6
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Apr 2023 17:39:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzVdJu5/SJwsYti7EPSw5lh1aPT0ywWCJ7/P2x8n2+fODdJ8Yp3m4bsVSq1TRDCtlXH48gh5gVhXasvqIB7lGsejxEocTHAjCR43+4sDX3406qyHctifMmTypVmJxwsXRd6ySH1GeK42+Qzd10+QLhDq5SO+o71SZEn1Dd3S3lqTzcAVb9YZkAKoApWugQwXdSV2ulcUwk7CR1BAGHNPdyQuQ1e13HTV+ki2kOp8vucL/OglLRAhDxKrmhG00EAORn295YV/eGTcs8baI0ZmQW4nWoVr64S4/i0clc4bUFhdwByyAX3oQ8f3qq2dCkBNPVPrFClCBRLd16UTHUfGqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbDwKLybU6s/yUQlATQXObrHq3mXfh3mlhk0/SHOJ9Y=;
 b=Q7pAqQzx1FD4Q+cPF5lf3UmO0SB/di9eeTOQGdsoT4iZoc/c2ZBabQGJPARCdjxHfBlsaute7K0nVhm33QzXe+IkPOLx19XAErfPGyIo5EhVp0W0orLWIVk4iuuW+5k6BkDAlRP+s+o14/Xv3DbQyfFcQBlzu16YWSRbMBR1Nx2bUwpmtqDOgKOih5Dk7+bq2ASH8q1JFb2X/TK2Xe/Tyu8c9g0xe6DzNxMt+KBHwRWi5WJ0nUB+Nr9AwstAnUI6reMKjHda4vdZFJEjccOzWpFpjKiWLjzBqTUKA739qSbQDvFMJkK2x2LWR92lviacvGVDf9wVMPEPBJlkQoOZcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbDwKLybU6s/yUQlATQXObrHq3mXfh3mlhk0/SHOJ9Y=;
 b=QImS33GFOjSMy/jArkc7xReoA6/djq09ExhumdY41ZeYGPijdh8Zo2ZtIk4ch4d0qrw+LrGMCSUYM1ORglvCCI5kln3afVYSut611CHhKt7camBYDjp+TUlRqvtqreYzrjp4z0zZylz+rlh5w8uItW8kXEXmzwtvJzvhKfxWsJs=
Received: from MW4PR04CA0140.namprd04.prod.outlook.com (2603:10b6:303:84::25)
 by DM4PR12MB6399.namprd12.prod.outlook.com (2603:10b6:8:b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 17:39:12 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::55) by MW4PR04CA0140.outlook.office365.com
 (2603:10b6:303:84::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33 via Frontend
 Transport; Mon, 24 Apr 2023 17:39:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.19 via Frontend Transport; Mon, 24 Apr 2023 17:39:11 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 24 Apr
 2023 12:39:09 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 04/10] drm/amdgpu: create GFX-gen11 MQD for userqueue
Date: Mon, 24 Apr 2023 19:38:29 +0200
Message-ID: <20230424173836.1441-5-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230424173836.1441-1-shashank.sharma@amd.com>
References: <20230424173836.1441-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT033:EE_|DM4PR12MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: 5252866b-e0e5-4b9d-cebb-08db44ead0a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FW/gqeLflzd+mGbEcr9OVKfeNlzFKoU/AlwlPcwVHr7k4V3dmd+c/KdFEjNVJVS03rhNt7HeCxyQ46pPRDaKeJgK/FPdL3IJEIVkA+D4mlibd56vugSTqbL/7Utw/6j07UgpIMjhNsVVGJnxdzfBS5w+FiQLw9odGp+uZjAWEFWuhf5++lKuHyrPNPac1HfXT9oUALJW1kBesLboxgm/wnLjGlorOsFfxuMRsElavynIUX92mCWaqPIk4hx9QQhPAiBMCfm4TEWY94cCgg+nILWUjn+hCuuytZlCXL9/xzb0vsBnkuyKH3qqolHRNxT8e6UugdmYR7AC/n9i1C4yM5jyeDUMDic5076zj/KKuczXpcSMogzSL2pVUQKbIh/E76FAyJqhQ/AqSYsqVHlm0z+kYKowA0fFazNFQ82Z9ub6rR3IL1OpbP9EBS6AnqUTa7ULiOT5n+indz2rpO5ErdpXfc6Y64BkimniwQENNd2VB3zBdtISw1bXvS6CKZNxw7eLJqYY6sFUOvl20g/vC5OyqgPhWYDDZx+V5c5VDLZdkmDJGcoey1AORzoym5cPLQej3x4Lsz6r1lfW84/5sNaC4xYefJ3UhJPrDdlbovc40d+hXBx5RZxE+1kcbAm9SHlo2qvkGjUePcA+rW5ArSrm8jpg9s3hCx1Sd694cQhe5t6WMbN7Syq3SZS/iPKnpDGJ632KNLktdE4BoIpn8PW0mwRLJZOzAhfJM5Y2WJw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199021)(46966006)(36840700001)(40470700004)(2906002)(7696005)(2616005)(6666004)(16526019)(26005)(186003)(40480700001)(1076003)(70586007)(70206006)(8676002)(8936002)(41300700001)(6916009)(4326008)(316002)(478600001)(44832011)(5660300002)(54906003)(82740400003)(356005)(81166007)(36756003)(82310400005)(86362001)(40460700003)(36860700001)(47076005)(336012)(426003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 17:39:11.4861 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5252866b-e0e5-4b9d-cebb-08db44ead0a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6399
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
Cc: pierre-eric.pelloux-prayer@amd.com,
 Shashank Sharma <shashank.sharma@amd.com>, arvind.yadav@amd.com,
 Alex Deucher <alexander.deucher@amd.com>, contactshashanksharma@gmail.com,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

A Memory queue descriptor (MQD) of a userqueue defines it in
the hw's context. As MQD format can vary between different
graphics IPs, we need gfx GEN specific handlers to create MQDs.

This patch:
- Introduces MQD handler functions for the usermode queues.
- Adds new functions to create and destroy userqueue MQD for
  GFX-GEN-11 IP

V1: Worked on review comments from Alex:
    - Make MQD functions GEN and IP specific

V2: Worked on review comments from Alex:
    - Reuse the existing adev->mqd[ip] for MQD creation
    - Formatting and arrangement of code

V3:
    - Integration with doorbell manager

V4: Review comments addressed:
    - Do not create a new file for userq, reuse gfx_v11_0.c (Alex)
    - Align name of structure members (Luben)
    - Don't break up the Cc tag list and the Sob tag list in commit
      message (Luben)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 25 ++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 57 +++++++++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  7 +++
 3 files changed, 89 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 333f31efbe7b..e95fb35b0cb5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -81,6 +81,14 @@ static int amdgpu_userqueue_create_gfx(struct drm_file *filp, union drm_amdgpu_u
 		goto free_queue;
 	}
 
+	if (uq_mgr->userq_funcs[queue->queue_type]->mqd_create) {
+		r = uq_mgr->userq_funcs[queue->queue_type]->mqd_create(uq_mgr, queue);
+		if (r) {
+			DRM_ERROR("Failed to create/map userqueue MQD\n");
+			goto free_queue;
+		}
+	}
+
 	args->out.queue_id = queue->queue_id;
 	args->out.flags = 0;
 	mutex_unlock(&uq_mgr->userq_mutex);
@@ -119,6 +127,8 @@ static void amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
 	}
 
 	mutex_lock(&uq_mgr->userq_mutex);
+	if (uq_mgr->userq_funcs[queue->queue_type]->mqd_destroy)
+		uq_mgr->userq_funcs[queue->queue_type]->mqd_destroy(uq_mgr, queue);
 	amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
 	mutex_unlock(&uq_mgr->userq_mutex);
 	kfree(queue);
@@ -149,6 +159,20 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 	return r;
 }
 
+extern const struct amdgpu_userq_funcs userq_gfx_v11_funcs;
+
+static void
+amdgpu_userqueue_setup_ip_funcs(struct amdgpu_userq_mgr *uq_mgr)
+{
+	int maj;
+	struct amdgpu_device *adev = uq_mgr->adev;
+	uint32_t version = adev->ip_versions[GC_HWIP][0];
+
+	/* We support usermode queue only for GFX IP as of now */
+	maj = IP_VERSION_MAJ(version);
+	if (maj == 11)
+		uq_mgr->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_gfx_v11_funcs;
+}
 
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev)
 {
@@ -156,6 +180,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_devi
 	idr_init_base(&userq_mgr->userq_idr, 1);
 	userq_mgr->adev = adev;
 
+	amdgpu_userqueue_setup_ip_funcs(userq_mgr);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index a56c6e106d00..9f7b14966ac8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -30,6 +30,7 @@
 #include "amdgpu_psp.h"
 #include "amdgpu_smu.h"
 #include "amdgpu_atomfirmware.h"
+#include "amdgpu_userqueue.h"
 #include "imu_v11_0.h"
 #include "soc21.h"
 #include "nvd.h"
@@ -6404,3 +6405,59 @@ const struct amdgpu_ip_block_version gfx_v11_0_ip_block =
 	.rev = 0,
 	.funcs = &gfx_v11_0_ip_funcs,
 };
+
+static int
+gfx_v11_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct amdgpu_userq_ctx_space *mqd = &queue->mqd;
+	struct amdgpu_mqd *gfx_v11_mqd = &adev->mqds[queue->queue_type];
+	int size = gfx_v11_mqd->mqd_size;
+	int r;
+
+	r = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_GTT,
+				    &mqd->obj,
+				    &mqd->gpu_addr,
+				    &mqd->cpu_ptr);
+	if (r) {
+		DRM_ERROR("Failed to allocate bo for userqueue (%d)", r);
+		return r;
+	}
+
+	memset(mqd->cpu_ptr, 0, size);
+	r = amdgpu_bo_reserve(mqd->obj, false);
+	if (unlikely(r != 0)) {
+		DRM_ERROR("Failed to reserve mqd for userqueue (%d)", r);
+		goto free_mqd;
+	}
+
+	queue->userq_prop.use_doorbell = true;
+	queue->userq_prop.mqd_gpu_addr = mqd->gpu_addr;
+	r = gfx_v11_mqd->init_mqd(adev, (void *)mqd->cpu_ptr, &queue->userq_prop);
+	amdgpu_bo_unreserve(mqd->obj);
+	if (r) {
+		DRM_ERROR("Failed to init MQD for queue\n");
+		goto free_mqd;
+	}
+
+	DRM_DEBUG_DRIVER("MQD for queue %d created\n", queue->queue_id);
+	return 0;
+
+free_mqd:
+	amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
+	return r;
+}
+
+static void
+gfx_v11_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_userq_ctx_space *mqd = &queue->mqd;
+
+	amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
+}
+
+const struct amdgpu_userq_funcs userq_gfx_v11_funcs = {
+	.mqd_create = gfx_v11_userq_mqd_create,
+	.mqd_destroy = gfx_v11_userq_mqd_destroy,
+};
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index 8d8f6b3bcda5..e7da27918bd2 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -28,6 +28,12 @@
 #include "amdgpu.h"
 #define AMDGPU_MAX_USERQ 512
 
+struct amdgpu_userq_ctx_space {
+	uint64_t	 gpu_addr;
+	void		 *cpu_ptr;
+	struct amdgpu_bo *obj;
+};
+
 struct amdgpu_usermode_queue {
 	int			queue_id;
 	int			queue_type;
@@ -36,6 +42,7 @@ struct amdgpu_usermode_queue {
 	struct amdgpu_mqd_prop	userq_prop;
 	struct amdgpu_userq_mgr *userq_mgr;
 	struct amdgpu_vm	*vm;
+	struct amdgpu_userq_ctx_space mqd;
 };
 
 struct amdgpu_userq_funcs {
-- 
2.40.0

