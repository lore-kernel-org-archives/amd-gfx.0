Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A32D0E95A8F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 10:18:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31C9E10E339;
	Tue, 10 Oct 2023 10:18:54 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FC5810E336
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 10:18:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWQy+EfElu0HO5l7fDuLxF7PskNktIJx9otTGvYbK1DaNCo4GcXqjSh3k1SDcaSX/RAMaT7XSkS5FRM0FkwKXnNWc+R5d89JFpcB5IUSHeT6inuFyCr4BAZx3NXKSYyxRYNkxqNNpNhseYaVA/Jvto5dZwdKvvhembr2n9IiaF4fCrTKBKguYVoPDqArEFF6CMYpyQMEsu9ZNMO7y5DsHlBAz1lea6BhDMK+9XnuRIq2/q7Ykc5u/uTA/GtNS5o+kk+J20sQEx2bdGD6/hyjKGRBXFGIUMHLiH0RtyLwmU5raBsktJc7glGW9zn2L0VR77DlnWjCIYZwjZITDo09wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=od4V89cP75mqgJ0bqNXy75bu1El2fMkb6t3YoIo8ttU=;
 b=Rt9Ka8ZpEKEgBWlv9l+YZFzL76lNPvj/JjnE2hpOVMnWGCFRleVRTQiG2li7hlk7pQixZV+C3i6oJORVEdEX2dZziDbnPTTETjj1hWzxHNAK5pny2yvYAml1DVN2oIRCgi7J2NdTW5kAvVoOjdKJ+sBGNXo/LYYHT6R19pUGd8kMxA4F/N+clzwJ5q3Lbw4bfrtnSaC3OUBUvjUmxmEhVfLWvw6VOpvx2S95DdonIzcnQkWZKVj1Xu1ptZCSTqMjqVEFylpM3tllRyaG1rQf3jGeEBvJYOVDU/E9gR8qCInBVYKiezd8+YWyJHiWT2zykeJXllRhWOar01w6ffEIfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=od4V89cP75mqgJ0bqNXy75bu1El2fMkb6t3YoIo8ttU=;
 b=lljcjBf7Nu5yxGW7gzkIX9fer4kMVWLHtqGSQseDnZL63Q8S3Tgrs5DmwowMfA1wyFdyOF1X/7/qREG9ZwDpR3Ymk1UVzM/1pL9bgHj8yVyz2E+i5TNqYaog2Kw16mtGH0xnVmkr8s3QI2eHDCc3Q6jAS2Dx5e5Vm6zkA+gcm8I=
Received: from PH0P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::33)
 by DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.37; Tue, 10 Oct 2023 10:18:46 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::5) by PH0P220CA0018.outlook.office365.com
 (2603:10b6:510:d3::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Tue, 10 Oct 2023 10:18:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 10 Oct 2023 10:18:45 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 05:18:43 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v7 09/12] drm/amdgpu: generate doorbell index for userqueue
Date: Tue, 10 Oct 2023 12:17:49 +0200
Message-ID: <20231010101752.1843-10-shashank.sharma@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|DS0PR12MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: 31a324dd-b849-41d4-8716-08dbc97a4980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oHWoXvU5uL7+8luo17H4aiPEv3cMDSx5NpRh1nz/ddEUmoKC4ldntxhMAUZSF+AeL7548DvD6EZ685mi1IcN6Vb+EHFZqyduaK6oX9mY6z/aNBcQUw+XD82AzJyxpziWVuHOslAHoM06gBqSH82IOPfAyjqThzbAzdK0+kKIwKn1SYTKApFh5Vwe277zUrz1XYer23kuIDxvBkGal0epLllO9ySR3ANip9fOQzLDeVJgcDkHUw+MPxSOg05TGMcnSAIPqmsvGWKaHp9SJPP8MTGf202zFgu4mQN1P4Q2yIkOwoG6OwlVsq+//4iY8RupCs9SunbobqhCLsO/CRWAU8uXnlAGTG3uG1PbU6BCqeVf+WqFtV8/DeeSttVUj0Umrl0xeFw1yTwP76pfHGbAnLXLxsVhOUDNHDZ1VZwhVaUBJ6yAwgoRjujOUtNPqzPTjzW7aq3/7PZQrcyKR0EjKxDVPhPF7BS15mvNKUN/1fKlYjZKByIPF4NDJRcXIc7bZ8x7yQuQY1DTgz7nOctocUoqOMvpYzJ64/rFTxffVK4eVbUybkCLCxyckgJFTnfP9CTQIS2gK3Zej1xJssRgislvHmVuyrvIEibOsUvv0q1CxU0NnNMaz5Rxa+Du6Tb2cr6+5blcMbWvZJ3ezZiy6xbiwJiOFwdDwXQLjfIIhNyTHdAQAQFGmEFuOwp9px3voTEN+desGld+gQVGSWBCsYm3fngvV3n4jZM/RtLtVZNa/v+8oh7QKh4FkigBV5/y
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(396003)(376002)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(82310400011)(64100799003)(36840700001)(46966006)(40470700004)(40460700003)(36860700001)(70586007)(316002)(40480700001)(6916009)(70206006)(81166007)(356005)(54906003)(82740400003)(7696005)(336012)(426003)(2616005)(16526019)(26005)(1076003)(966005)(47076005)(83380400001)(478600001)(44832011)(2906002)(86362001)(41300700001)(5660300002)(8936002)(8676002)(4326008)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 10:18:45.8785 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31a324dd-b849-41d4-8716-08dbc97a4980
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6390
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

The userspace sends us the doorbell object and the relative doobell
index in the object to be used for the usermode queue, but the FW
expects the absolute doorbell index on the PCI BAR in the MQD. This
patch adds a function to convert this relative doorbell index to
absolute doorbell index.

This patch is dependent on the doorbell manager series which is
expected to be merged soon:
Link: https://patchwork.freedesktop.org/series/115802/

V5: Fix the db object reference leak (Christian)
V6: Pin the doorbell bo in userqueue_create() function, and unpin it
    in userqueue destoy (Christian)
V7: Added missing kfree for queue in error cases
    Added Alex's R-B

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 58 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  1 +
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  1 +
 3 files changed, 60 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 141808e9296b..ec49c10f7511 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -94,6 +94,52 @@ void amdgpu_userqueue_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
 	amdgpu_bo_unref(&userq_obj->obj);
 }
 
+static uint64_t
+amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
+				     struct amdgpu_usermode_queue *queue,
+				     struct drm_file *filp,
+				     uint32_t doorbell_offset)
+{
+	uint64_t index;
+	struct drm_gem_object *gobj;
+	struct amdgpu_userq_obj *db_obj = &queue->db_obj;
+	int r;
+
+	gobj = drm_gem_object_lookup(filp, queue->doorbell_handle);
+	if (gobj == NULL) {
+		DRM_ERROR("Can't find GEM object for doorbell\n");
+		return -EINVAL;
+	}
+
+	db_obj->obj = amdgpu_bo_ref(gem_to_amdgpu_bo(gobj));
+	drm_gem_object_put(gobj);
+
+	/* Pin the BO before generating the index, unpin in queue destroy */
+	r = amdgpu_bo_pin(db_obj->obj, AMDGPU_GEM_DOMAIN_DOORBELL);
+	if (r) {
+		DRM_ERROR("[Usermode queues] Failed to pin doorbell object\n");
+		goto unref_bo;
+	}
+
+	r = amdgpu_bo_reserve(db_obj->obj, true);
+	if (r) {
+		DRM_ERROR("[Usermode queues] Failed to pin doorbell object\n");
+		goto unpin_bo;
+	}
+
+	index = amdgpu_doorbell_index_on_bar(uq_mgr->adev, db_obj->obj, doorbell_offset);
+	DRM_DEBUG_DRIVER("[Usermode queues] doorbell index=%lld\n", index);
+	amdgpu_bo_unreserve(db_obj->obj);
+	return index;
+
+unpin_bo:
+	amdgpu_bo_unpin(db_obj->obj);
+
+unref_bo:
+	amdgpu_bo_unref(&db_obj->obj);
+	return r;
+}
+
 static int
 amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
 {
@@ -114,6 +160,8 @@ amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
 
 	uq_funcs = adev->userq_funcs[queue->queue_type];
 	uq_funcs->mqd_destroy(uq_mgr, queue);
+	amdgpu_bo_unpin(queue->db_obj.obj);
+	amdgpu_bo_unref(&queue->db_obj.obj);
 	idr_remove(&uq_mgr->userq_idr, queue_id);
 	kfree(queue);
 
@@ -129,6 +177,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *uq_funcs;
 	struct amdgpu_usermode_queue *queue;
+	uint64_t index;
 	int qid, r = 0;
 
 	/* Usermode queues are only supported for GFX/SDMA engines as of now */
@@ -158,6 +207,15 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	queue->flags = args->in.flags;
 	queue->vm = &fpriv->vm;
 
+	/* Convert relative doorbell offset into absolute doorbell index */
+	index = amdgpu_userqueue_get_doorbell_index(uq_mgr, queue, filp, args->in.doorbell_offset);
+	if (index == (uint64_t)-EINVAL) {
+		DRM_ERROR("Failed to get doorbell for queue\n");
+		kfree(queue);
+		goto unlock;
+	}
+	queue->doorbell_index = index;
+
 	r = uq_funcs->mqd_create(uq_mgr, &args->in, queue);
 	if (r) {
 		DRM_ERROR("Failed to create Queue\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 8c62a51025af..33de65a0d974 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6605,6 +6605,7 @@ static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 	userq_props.queue_size = mqd_user->queue_size;
 	userq_props.hqd_base_gpu_addr = mqd_user->queue_va;
 	userq_props.mqd_gpu_addr = queue->mqd.gpu_addr;
+	userq_props.doorbell_index = queue->doorbell_index;
 	userq_props.use_doorbell = true;
 
 	r = mqd_gfx_generic->init_mqd(adev, (void *)queue->mqd.cpu_ptr, &userq_props);
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index ffe8a3d73756..a653e31350c5 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -44,6 +44,7 @@ struct amdgpu_usermode_queue {
 	struct amdgpu_userq_mgr *userq_mgr;
 	struct amdgpu_vm	*vm;
 	struct amdgpu_userq_obj mqd;
+	struct amdgpu_userq_obj	db_obj;
 	struct amdgpu_userq_obj fw_obj;
 	struct amdgpu_userq_obj wptr_obj;
 };
-- 
2.42.0

