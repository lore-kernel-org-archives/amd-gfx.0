Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF07E95A97
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 10:18:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD1CB10E1CF;
	Tue, 10 Oct 2023 10:18:41 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A569E10E1CC
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 10:18:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlGjgot15gVhgKu6KIuWNw+XBluhYw1kd2nEzXhikm+4d9MmnzZEBczSU3gP4QDM144SVCsx32ppm59s6YGRiOPVV5C68HXcvcBLxnFgXdDA5xy32OxHc1w76vZ+dmuh3SpeNWB2Dx5hEbopuXGqJm0WnzhyveTkQMSwPZMsWEPoRI8ALP0xLiWZ0nOhqG16NvA7w/JsMaaERsjkabeWMHjytPSR7vBBFjtOlMz7asu7jRZpwUO92ppaOoy37rUxwsM9aKwIXYQywrpkfOIvH7gDiNefOYNxFea0V6yst2k9gWgfiJyahAp7LdvUJpvvnhO5NlQI4m+vsxxD9eAZMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ul22wCUwqvNVCmsniLMB+oeg195PD9TpeZXCoGDMbs=;
 b=GACi595d72qhdbRZDahRuHevec9PcRQDFug3nE74A1ozQO0dxwPvw6kkcONgSlDrUH7xFwoKWEZ7I5emH1JaYT/Vq0nI4yKa/dErvmIrttCrAA6fT3mgyalGZLFVdlTreRmBBgreZOCeEkoxwR3L7tLBDTceaoaK0RnVNBPAFMox+zA1WZLpdia3jz+2YIZ74zru+MyNUQAlPAZTt9KyBQHS6MyYhAzVJ9uXo9FWoKfVD9tEMlK5ubQPabbh58RmO+nn+0MyVHBCY2DNoNyopRgcsKbk7ujl9O8niZwefR9APKzg+bUZzHrZ4qNHnjA1t2r51DDGHBybMHIkE9JMWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ul22wCUwqvNVCmsniLMB+oeg195PD9TpeZXCoGDMbs=;
 b=lnbEohV9lVHLvExDGmco5HWMpt+tF2wpvKoxSjv4oaEcpn7wvH1Xa5HBI2QYoZQ2ljZonDc3yp4VeGExTLuDRHRJimnoN0Y+YtytLK4d37wYnfiBcLJZVESYr2mp3f5ghP84jzV8zrtJ9AgRIpqbY7eVG8GWGzxX945g+quUcJo=
Received: from PH0P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::33)
 by LV3PR12MB9257.namprd12.prod.outlook.com (2603:10b6:408:1b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Tue, 10 Oct
 2023 10:18:37 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::e2) by PH0P220CA0018.outlook.office365.com
 (2603:10b6:510:d3::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Tue, 10 Oct 2023 10:18:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 10 Oct 2023 10:18:36 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 05:18:34 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v7 03/12] drm/amdgpu: add new IOCTL for usermode queue
Date: Tue, 10 Oct 2023 12:17:43 +0200
Message-ID: <20231010101752.1843-4-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20231010101752.1843-1-shashank.sharma@amd.com>
References: <20231010101752.1843-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|LV3PR12MB9257:EE_
X-MS-Office365-Filtering-Correlation-Id: ab7cd3bb-4875-4356-29f3-08dbc97a4410
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lweN8xXdwhlw2kVrK6Y3SlExX34lTdolqnuJQUTcCI66K2LvNLdFJjDQPlCm5tbQEzCIhBgVaRZXr5QE3D4uRUA8iQ7dAxPDwc+IKC5e0TWmJGxO78JA752v9Bx9/4A4H3jEasJnCePeoMSSTZuStIFKrVnpPUsv8yewifcIUR4RAwUp09uQuAT7sMYp/La38evCTP5BAJK7OWog9Cb440TWRaKa83OIj9RkaFBNpW8qevmvYDyk2xWHL/UYtmKK9cMXfDpk9q8jT7edfkohy1hlKNM35cmaq0GY31KETitjncK+YTRQe1kETnb9aMMEz95LxnRkZKmv2WxZeJNpNvHRX2D5H4Rn7nzE9mPoWVZxJ+UEQbyM0sc0PEUDc3iLA9ypPMp2NgVaWhp6uKOBV56hNSFCQdfQ2hOoYQqCLq6/zAF6+vrIJyc/jtjHLUe49gGoHXKpvFBR72rBUk64MTrfmNc82PFhrVE84BNdetVyyrbqA58Mpzwn1gxO16etXh8SE6f3xfGcbMJ1TFg0OY7oJAWqiRXLYOHglGsLB2uyO/9zDc3TB8GkeZnS+Y5hq6/gBh77v845GmZMP77xFbMi31XbEd79X7KPfCfXiuupysSrMhKUfUBpfi6pxjR2B8+TVWlH+3Pcbi4Ibin1cnp76oy1CALrEKbKJJA+ZwfIKUVPg4grwmr6uqnR33Mh790tFq2HVNohHG0QTOKhdlrFRLEt527p0h+thjcFWB3MsLBo4/WQTnwX9ciUDpNtZzbCDJdPHKfsCzRBrn08Qw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(82310400011)(186009)(40470700004)(46966006)(36840700001)(81166007)(356005)(86362001)(36756003)(40480700001)(44832011)(478600001)(4326008)(82740400003)(8936002)(8676002)(41300700001)(7696005)(2906002)(6666004)(426003)(83380400001)(336012)(1076003)(2616005)(40460700003)(47076005)(6916009)(70586007)(54906003)(316002)(70206006)(5660300002)(36860700001)(16526019)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 10:18:36.7535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab7cd3bb-4875-4356-29f3-08dbc97a4410
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9257
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

V7:
- Move uq_func from uq_mgr to adev (Alex)
- Add missing free(queue) for error cases (Yifan)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 121 ++++++++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |   2 +
 3 files changed, 124 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index e809859de388..7c540842b2c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2789,6 +2789,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_VA, amdgpu_gem_va_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index effc0c7c02cf..88f0a85e6e17 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -23,6 +23,127 @@
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
+	struct amdgpu_device *adev = uq_mgr->adev;
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
+
+	uq_funcs = adev->userq_funcs[queue->queue_type];
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
+	struct amdgpu_device *adev = uq_mgr->adev;
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
+	uq_funcs = adev->userq_funcs[args->in.ip_type];
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
+		kfree(queue);
+		goto unlock;
+	}
+
+	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
+	if (qid < 0) {
+		DRM_ERROR("Failed to allocate a queue id\n");
+		uq_funcs->mqd_destroy(uq_mgr, queue);
+		kfree(queue);
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
index 93ebe4b61682..b739274c72e1 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -54,6 +54,8 @@ struct amdgpu_userq_mgr {
 	struct amdgpu_device		*adev;
 };
 
+int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
+
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev);
 
 void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
-- 
2.42.0

