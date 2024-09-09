Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D91DECE587
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 20:07:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1448310E685;
	Mon,  9 Sep 2024 20:07:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C/PKNlTP";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4837010E685
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 20:07:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g707NCarSpt9OI3GOSOsVLJs2rr3cJ/quMp6wkRp6oRR2MXw5/h+b+WfcTvFUU3Pt+72B2ZhOPaV7c5IYbRctTi/mklLG2guCNLmZ1Nphq5ya2ASSIRMYfCQ3C9iWJzpO0sjeev9LoRpE+ngm2OnfWFrPOdP62D+fkoMxZqyMsoxYdU7HPrYPCsGkqL7jIxmY6WtNDkdSw3M8uWDUSO+3QAzFiQSvdXNO2AV/nK8UZrH4HtCkjWrvY6b+62kIXap91Gnxgxk0+g+TiGaZtNL1fgcp+AAK4levz9rc7FrRn8ycNGSxTOSMW2R4+87FQNgz5KsBe1LO8rXNyjP8S2Alw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8gPiVMh2xlOClS836kmb6fxI+wkFCrgtJGDM2d9Ms8=;
 b=d19G+/ggUUy0L4eL67v24oCpeG8VI8lKgOJmghCgNiFrcxb+tvDjX/u9+/efy/R/JYa/mqH1P4NLnaOTOqovStebPH2jeclrFRKNAQyiG6ssdEANTmu2aS9AkDFEuFVzJizSVfNgtekXzhov522mQx29stIh5Bg6aVe2cN+f/pzrYSjLTpLsTRDRNpl4XxGZfSrZJ8YJMX6xWAK6yQXvLWbFj2Suzh9+lYL4KC4lzORn2YHNRXyBxWN6wxsFSbKhnfP6BlbYX1IiFP0M+V3ds707aqy2ehcHFwLdmpurtySK1ldqm3P9nLA3FJevgWQvlKo+YGmnJOguhKcNfkiLEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8gPiVMh2xlOClS836kmb6fxI+wkFCrgtJGDM2d9Ms8=;
 b=C/PKNlTPzYsFg0Q45ViGnAfuNubNQ8pFHMSSFSliJokVITK+BadwpxxaESZ1zuO6bepueYogPcExj+TqL6KSWFsT9KVbvBswxkmNAIqoguywk1xfg8wV8YJaVQzizihTQrrwwo/DfDd3DR0xBfc+Tu8/T5L7hpR+ZvolaRHPhQg=
Received: from PH7P223CA0014.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::24)
 by CH0PR12MB8551.namprd12.prod.outlook.com (2603:10b6:610:186::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Mon, 9 Sep
 2024 20:07:13 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:510:338:cafe::c8) by PH7P223CA0014.outlook.office365.com
 (2603:10b6:510:338::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Mon, 9 Sep 2024 20:07:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 20:07:13 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 15:07:05 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shashank Sharma <shashank.sharma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>
Subject: [PATCH v11 09/28] drm/amdgpu: generate doorbell index for userqueue
Date: Mon, 9 Sep 2024 22:06:00 +0200
Message-ID: <20240909200614.481-10-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240909200614.481-1-shashank.sharma@amd.com>
References: <20240909200614.481-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|CH0PR12MB8551:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d7a9236-a308-4e0b-3448-08dcd10afea7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VA8vbGjSzhtyuUMWrfGrk9HONpnW2qEDYNAsrGnm9qqBsrEnZrDsW705UKtB?=
 =?us-ascii?Q?SuO4IrRFUVIVcgGHlece+5Puv1d3s60nvB66OwVk5x/cW6SPOBRlll1HxpcE?=
 =?us-ascii?Q?sbN1iep1CEYRyQcWpESmuywwqFoVkWJfsS1B6vuMqXqk6GFCYjkKgs8qmEb4?=
 =?us-ascii?Q?l5yVVQnvDg43cSKJlbZcYtZp/sMDjI16iXxK/QFRWuvaHkf0Kl3rs0i5L+6M?=
 =?us-ascii?Q?Rr+DMMdtg3nm5PngjIm2WsXffccsYdOoUi/axS+FUmZAnnfRpmkvAbH5aaYY?=
 =?us-ascii?Q?oqxMPk0TjXxYP3VQJWSiTsGM8j685daad0sH9VejAldUR//X8Lar3xvEO1ek?=
 =?us-ascii?Q?x+i4NKgmWZb0pXX71oeK8ffS5N+ErVyHZQhHk1HcRleRIhc6TGLbrd2u5MdU?=
 =?us-ascii?Q?VqssGQrzIPgqp+rrR+pNculPebBaAXMo5Wml7Spv6Xys95iyCcKFIJ5bunuq?=
 =?us-ascii?Q?DZxqo3WCpq6/vlz8ccf/2MXpV2O/1XmLuWozByI1+q8G3VcguInH4q53nFgg?=
 =?us-ascii?Q?Phwyw1CXGO86r1Np/zgTxUYlBfcYZ9AzJwb204u5vMNaX/E8a12TVbknfl+p?=
 =?us-ascii?Q?GFgtWktpIV0itWSqKbgYzSU8epAHD2vhm+PCcgeOcOQfFA8foCwMXwtakEGd?=
 =?us-ascii?Q?dahHWF4xph5etx62Tmssb6sc0fsmyGUSnyU7NhLMK0XY+dFntQEPVdfJXH3G?=
 =?us-ascii?Q?84t+8XS2vMu6F6iIEpy3f/PSpbQuAIL/m6hGl+zkOjyGJZSLvrT5Sv/lgpAE?=
 =?us-ascii?Q?TVVVttIKoKoFYmfViIRHG3R7+sLSNAJluzMtYQk8a0stI5+jwCTuDXkE69QN?=
 =?us-ascii?Q?+MpqDC6wHNypbsdkjhWwn2MIyVaM0kH3hqnObodGI41ok+ek+67mdN+ydgSQ?=
 =?us-ascii?Q?jGj4NOTWycFvvW+jl66fhxFh77mhaOhpjZiSLGBAvjoFxlfVyVRy6ihtdLVz?=
 =?us-ascii?Q?5To0QqIEskme2uIc5h1b5DeH7JrbPna3LK9I7roEIH6JYHcORyplpvNAAqlZ?=
 =?us-ascii?Q?guSZWGF+KmZg4Sbm62RDkhme6uzyD9FPNWK4H8VeqrwWKMlrK0gSLLfwblc2?=
 =?us-ascii?Q?3khN2xE3Axf2DNnAFn2KB3dDFJ0L0eqmu/9DxVIEYhFsyrQJ3keOlgx7BE6R?=
 =?us-ascii?Q?9BfUKW4TU/4opifjiZqLsqF1cS8MrWDn3hZo0Wnq/dfBmftTWFrh74hpqVRU?=
 =?us-ascii?Q?NlvoaKVt4xCRSVboMaMnXWcSEHg4ABQV98d9NDsusiQMixQ8GrPx8Lfaf+K8?=
 =?us-ascii?Q?0x+LmV0RNiG09VB8GCgYQo3C5f1rt25uJGjB34X4Or94+UpOZkSqB6skKpxd?=
 =?us-ascii?Q?xLRoQVIOxm/AYPkRgujWq4/rlz+wVEvvThu4xSXgheyhyeRifysVQyfh/lrD?=
 =?us-ascii?Q?+b5/AxC1iWykO6TeeIlBI5Pb7MEfxqIwaMByGpr9wwjAgNeaEb9yxZwitoD4?=
 =?us-ascii?Q?slRpWkS+wKb2WqzHT/iCD7OgbyRSKsvv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 20:07:13.1235 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d7a9236-a308-4e0b-3448-08dcd10afea7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8551
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

V5:  Fix the db object reference leak (Christian)
V6:  Pin the doorbell bo in userqueue_create() function, and unpin it
     in userqueue destoy (Christian)
V7:  Added missing kfree for queue in error cases
     Added Alex's R-B
V8:  Rebase
V9:  Changed the function names from gfx_v11* to mes_v11*
V10: Rebase

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
index 501324dde343..3c9f804478d5 100644
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
 
 	if (args->in.flags) {
@@ -157,6 +207,15 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
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
index 90511abaef05..bc9ce5233a7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
@@ -220,6 +220,7 @@ static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
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
2.45.1

