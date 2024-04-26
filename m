Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2C7C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 13:48:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1459F112410;
	Fri, 26 Apr 2024 13:48:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JFmEfLJa";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2066.outbound.protection.outlook.com [40.107.102.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2960E112410
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 13:48:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LOHWTX4wB8P1TD1IbBumdyvqtVdzh544oB2P9T70cSs7DzWLNPitLercFsLOARLIYsKbUX4HPxqsmB3uMtXjrjEvJEsC6m3Mt6bPiyty1iojd+Lk70XirwKSSi/o0AAANuviKu7EvEefnsbFSOwGjO1TlKj2xh4LwIWkDhIknx4s8qIpzkUEfuG7TqUuFUrCLgvS6wjyt163L+l9k++Mx3vFnD70T1QYZWjEcoe/ZYp0tlJQUvGyKTY+YRTaLWpivXSe3broM/u3zkl3W8Vv8gGj2D15GlvfJUpg7K8q9zYl6dFAEDDIWcIkUrViJyN6RFi1LbZDkFJCPiY0QDZ+Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPsGCV+b1iRyBP+26ZPJFMtY0Vc4PjSQP8cSDk7Vwl4=;
 b=OVrmR+q28yV55qhVeoCcdXZ/8D2S0Pehh0zHxB64Tgnd9i9JoSbohEmxGMnHhDKCACHG1AxrNyJ2O6ToRJUSIIjwhxZllmBM6Zgcce0ZppBhahHRmBs4wUTUrp0PbTAcR5goXKGEc+NhiV+czMYP8u+7Kq1wfUwtv3FFk3qosq+GC/xlPC/JdO1rWU6qcrcP3pBGpt2+fnP2lK8rPtuC6WBwVM5z/L5DYn/jHVQReqXdg43SzJMbr/JMrR5sHC++9Nqt2TktV7eod6zow+HM23piA7xkPkwcZf9Sx43G9hgriALJvlP5DpO/1goh6A6VRRzrz8/WBD9akjZ8CBCVLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPsGCV+b1iRyBP+26ZPJFMtY0Vc4PjSQP8cSDk7Vwl4=;
 b=JFmEfLJaY3iD39rz/ODNJtKP2w5xbI1oU2cvvxhmKOC7WZjZCIG1NcfcoZu9DuOrFxCk2GfuXabPYP+mQu9Zk7vEP89uDdSa3ZmzRjIV7YOWX/JpjB8Bxz2PD8DVAian5AJxGvzZHO1QkHsEqhs95tBoNDXHETglFC55/DMEL88=
Received: from DM6PR08CA0030.namprd08.prod.outlook.com (2603:10b6:5:80::43) by
 PH7PR12MB6667.namprd12.prod.outlook.com (2603:10b6:510:1a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 13:48:52 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:5:80:cafe::ea) by DM6PR08CA0030.outlook.office365.com
 (2603:10b6:5:80::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.29 via Frontend
 Transport; Fri, 26 Apr 2024 13:48:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 26 Apr 2024 13:48:51 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 08:48:49 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Arvind Yadav <arvind.yadav@amd.com>, Shashank Sharma
 <shashank.sharma@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Subject: [PATCH v9 09/14] drm/amdgpu: generate doorbell index for userqueue
Date: Fri, 26 Apr 2024 15:48:05 +0200
Message-ID: <20240426134810.1250-10-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240426134810.1250-1-shashank.sharma@amd.com>
References: <20240426134810.1250-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|PH7PR12MB6667:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c0643ea-c4b9-4203-5887-08dc65f79b39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QeBdvnYAqen8u0GXCzJHuSDU58YXGueYSjo0oEmzQ+RKViVoe0BQ12OQyrEW?=
 =?us-ascii?Q?OCTaKPrVaK5X5auFamwQWX34Lzucnp7yAG3lTMF6x1u7Acx42Oc9iWLnMMJ2?=
 =?us-ascii?Q?3gZs/VQv95B7AEvoEAa9xwor0aMVFkWD18+VM7Et8Qmu7DtBS5btXL5TRrXb?=
 =?us-ascii?Q?vA9vHPhsVyEVRuJmopIMXyE4NkVzoXobgn9mgMdAsOyyUAIHciCUp3/7yqxW?=
 =?us-ascii?Q?kzoqh+1grat1Lp5hZmT/M7j8xlYa0bG66+vSA8GtU6LMQpO/zYW4l1IsnR3T?=
 =?us-ascii?Q?vIIx4iFH6SiXsliUrAWrS4fmvDIl0syYKKn9kbOKOPyoc2jsxQbDGs+Gj1a9?=
 =?us-ascii?Q?o9XunGGrTNfK7yfc5N16vUIGT6w4okq8yipvIFqJG2fx6UQMqrs85/uhU3IP?=
 =?us-ascii?Q?lE6cTd1vsLhyUHAD68UVcqsTHNbL4jx+kMK4KFYKm0NhB9SfvSAlsOA40aKo?=
 =?us-ascii?Q?wcnRh+lcwr8XhNp+weXKiDhK5ZVFKLC/juyLZTfMO5xqJdOjHLUuun1gZ/Me?=
 =?us-ascii?Q?/FYfJomZCWCFR3YmZzW9IP4q0ZuOrda+egyi7+oNCDQVURhs3xh+k8TWkC9U?=
 =?us-ascii?Q?aqN8ggxJPelwAgvWqzS+1QOZa6P0sDBs9zTspxYLXsDG/5xpeN68izTegBkV?=
 =?us-ascii?Q?+DxGcpuIHTFtH+CL2TY8uT35A4cIxJAhNOZAsfzWVtumAIsxAcCSJ8euttXB?=
 =?us-ascii?Q?10Aq/ZOLHb3ONeqCjzGdpPmDaLGuC/wmGVgtmCSraYd2ZJqO8k8ucIFS8dM3?=
 =?us-ascii?Q?+fIJ/CIQ0PL056JPxsToblWR5Cx3QNxlgnYw5Y7YnmU8xHBHrbJRqIyfpLHn?=
 =?us-ascii?Q?CguuMl09MR5DsoxGRPa1ppdXWY7C//2ldm0SglJ9RpRRjoLsSjEzuPRN13uw?=
 =?us-ascii?Q?WLRym+Tvv1m8ny5apJtSwM+Ia5R2jeY9N4l+4wP/0LNfOCgvNUR1jm2j18vF?=
 =?us-ascii?Q?0d8reDBd14ye0PNxhe1eMli6Ay8gFm/s0HP8Fm/sQJYhpt3gHputK1Wht585?=
 =?us-ascii?Q?H2DvTmMeErtPQmnsjoHT8cB11iW/6uvm1/Mp9FyGvq0vpmQzubidCtOBsHR5?=
 =?us-ascii?Q?VWFF3LfLYyvXll3q4y+C+1uGzt30GZl2SlGSLZlPZECaijKJlBZr4JS70Sxz?=
 =?us-ascii?Q?Lp0eJDoHmKGOlqy7Qv3HsfcrqRhzCb1+piGw8du0obmmYkgQuEyUVlN9o2wC?=
 =?us-ascii?Q?zxCwNOzZxawogeES21Rl6Ox/WOXhDSlAFnmRhhw4EpGT8QuO2O5vesHMCW1F?=
 =?us-ascii?Q?EPfwZqLHTCDcZkuTE4EmXPPnfveQ+bAUu14+B2Lop8ZdAac9W2/oHeF1qku1?=
 =?us-ascii?Q?wlMip6PkxaNG+t1XM3UAP4o1jSzbPFGxhLFkiH4Ml6VbuoTRdykuPV75AHFf?=
 =?us-ascii?Q?uVjAWHM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 13:48:51.4072 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0643ea-c4b9-4203-5887-08dc65f79b39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6667
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

The userspace sends us the doorbell object and the relative doobell
index in the object to be used for the usermode queue, but the FW
expects the absolute doorbell index on the PCI BAR in the MQD. This
patch adds a function to convert this relative doorbell index to
absolute doorbell index.

V5: Fix the db object reference leak (Christian)
V6: Pin the doorbell bo in userqueue_create() function, and unpin it
    in userqueue destoy (Christian)
V7: Added missing kfree for queue in error cases
    Added Alex's R-B
V8: Rebase
V9: Changed the function names from gfx_v11* to mes_v11*

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 59 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c  |  1 +
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  1 +
 3 files changed, 61 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 65cab0ad97a1..fbc7313710f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -94,6 +94,53 @@ void amdgpu_userqueue_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
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
+	index = amdgpu_doorbell_index_on_bar(uq_mgr->adev, db_obj->obj,
+					     doorbell_offset, sizeof(u64));
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
@@ -114,6 +161,8 @@ amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
 
 	uq_funcs = adev->userq_funcs[queue->queue_type];
 	uq_funcs->mqd_destroy(uq_mgr, queue);
+	amdgpu_bo_unpin(queue->db_obj.obj);
+	amdgpu_bo_unref(&queue->db_obj.obj);
 	idr_remove(&uq_mgr->userq_idr, queue_id);
 	kfree(queue);
 
@@ -129,6 +178,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *uq_funcs;
 	struct amdgpu_usermode_queue *queue;
+	uint64_t index;
 	int qid, r = 0;
 
 	/* Usermode queues are only supported for GFX/SDMA engines as of now */
@@ -158,6 +208,15 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
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
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
index 37b80626e792..a6c3037d2d1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
@@ -240,6 +240,7 @@ static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 	userq_props->hqd_base_gpu_addr = mqd_user->queue_va;
 	userq_props->mqd_gpu_addr = queue->mqd.gpu_addr;
 	userq_props->use_doorbell = true;
+	userq_props->doorbell_index = queue->doorbell_index;
 
 	queue->userq_prop = userq_props;
 
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
2.43.2

