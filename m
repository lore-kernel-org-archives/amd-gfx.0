Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C822CEE8019
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Sep 2023 16:06:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48B3310E913;
	Fri,  8 Sep 2023 16:06:24 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::603])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 203A010E914
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Sep 2023 16:06:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSWnmWOjbfX6XF/uV+oLqTNBOynP20NGgHG6LD81Y/vCSwWkDu0/scpNyyeylcSSX8C7ST1TwtBP0n1RxpdWrLS0gGRpK/GNsK3Jxk6MpspQVhs/sxpWPNe/QoUiuEba6RFu0XEttYzqI6iWF6qx5pwCEPfiicVinNB+vj4+RZEyqLx+RETM+oxDcnRYQIGlabxsaofyKBTcWRt5pBElPjzcW4vL1wThrmBYOki80es9yD7TP9vMOqqClEij0iUq+/RLw2WX3ACaR/t148keTExQ+gmaZGPRDydtH58Z6maM2nSIU9gWaw4u0UxDm+Bh+7zeVWV71IuXTMdUpVH2tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+i9/zuoOylxDF6deGUXlnhAsZMh4UQSTcmJPEBQLq0=;
 b=Ql4X0sy9b7XAiY/J+nCeveRsxpcqZh9okEcB500R3+Wyo6Z0Ccv2ECX9pafTNZURp6QfZqbpM/D4gbRRXdDWqcKNkSjJJ59AE6XxSNTP/tPXv3kMXYmNgdJ5l9+0BNRGDAUc3vcw0oqeHR8I67r+xT4xbhnqi0wqe53+3GIq7b3asqo44h7O5duBJ7vFDD5Xm65bNYSN8I1xZMNnh0htB5rrS90GplyGVOY1NbL6I7UoazoIELwTtQ18DzXZ6L0QroLo8PYBKyoG5Kk8cuIPvZ/5GTbf1rYGWGywJa2hGtxfsxCSTKTZQTFKdjw+f9GSo0/QrSj7R+gvjCaGRZvbuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+i9/zuoOylxDF6deGUXlnhAsZMh4UQSTcmJPEBQLq0=;
 b=dHlXWvMyO+EIgi1zntKKFreH5QKbCZe/rq8HFgFrLyj6ZlFRzE8KdSRXWKo1XtC2xXwgViwHUjUp1UQiKm7GvNr6rTO8GeHRuR0DklI3dvPQBbmUvNAKtdW00+4tWbNpGLqlV7LDACKHeBJjb/ZJNGrxMGb7JAJx1RdCjO6nUFk=
Received: from CH0PR03CA0223.namprd03.prod.outlook.com (2603:10b6:610:e7::18)
 by DM4PR12MB6302.namprd12.prod.outlook.com (2603:10b6:8:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 16:06:19 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::da) by CH0PR03CA0223.outlook.office365.com
 (2603:10b6:610:e7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31 via Frontend
 Transport; Fri, 8 Sep 2023 16:06:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.11 via Frontend Transport; Fri, 8 Sep 2023 16:06:19 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 8 Sep
 2023 11:06:16 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v6 8/9] drm/amdgpu: generate doorbell index for userqueue
Date: Fri, 8 Sep 2023 18:04:45 +0200
Message-ID: <20230908160446.2188-9-shashank.sharma@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|DM4PR12MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ff2821f-a162-47fe-763f-08dbb08589da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J1I+ImoVXRoHBy19WyJ1A8mQ8DbQxwp5URRB9TVHMgXe6ljJoFuGuR1vEpX7lIX9LP+4l/e+bnSilqHN3XkcEmttQ/pBxh79m3+z/7BvcvkdtM2ZlX9h+3vooqPQuIA5a0G7Nk3VZPzpN7MSprQFxmWf1cv17352Cm6DOEumbRXxptV22/GVILgJYGZq+koAkBZomU/BBfFegSPTSg6C7idYEJ1230tyk3iMsr9nRYzevZyRvMM4F4sJzBTEjlrqYPxfpg+gSoZlV2KZrIvk9F7eP00IuiuqJ5Eyb4VsAd5JBwmlikMytirQyhNPUtM4LtaGyadIC7MWODRQgYPnPO10CjAKQImKuvM2mLBGewxAkadTaRmSMvO4XkmvEhfgTjolhtonC2gQH6d+vEHBq9scqYI2jyY3IbKqIBgIE3UEh3ghLKW73nRC0XpI8tiZm4fqwV2iTCY6lia+M02wNL0x+pAvS1zMxQlKV/f0srs3mOh8GZYHBOWGsOnlrjLofTAT2OkupSxEZFct92g2otRH1vXTEPqjF3bIefv5nNbQ+Q++s4TxMTGYoHtGSEg5ivGnCPHR5SFWGc493/igYqkLp74czdOybad+ErDxtBnAZsjIh2/jK32syKoN/vCWv5sySzIFaVEliKc4p8H3gJtX2SRAzrOCatXnGFWRnT2DZBhJJHeH00tnezQPeDKqqJzGx9K+ARIZ0ypIrLgyb+HEhg9hb44PXe6zs8KqjTADe1m1kN+QSZ3aPBwaj4tr
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(39860400002)(396003)(376002)(186009)(82310400011)(1800799009)(451199024)(36840700001)(46966006)(40470700004)(7696005)(6666004)(40460700003)(83380400001)(2906002)(1076003)(2616005)(966005)(336012)(16526019)(426003)(26005)(6916009)(54906003)(44832011)(316002)(70586007)(70206006)(41300700001)(4326008)(5660300002)(8676002)(8936002)(478600001)(47076005)(40480700001)(36860700001)(86362001)(36756003)(82740400003)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 16:06:19.2210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff2821f-a162-47fe-763f-08dbb08589da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6302
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

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 40 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  1 +
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  1 +
 3 files changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 03fc8e89eafb..a311d4949bb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -32,6 +32,35 @@ amdgpu_userqueue_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
 	return idr_find(&uq_mgr->userq_idr, qid);
 }
 
+static uint64_t
+amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
+				     struct amdgpu_usermode_queue *queue,
+				     struct drm_file *filp,
+				     uint32_t doorbell_offset)
+{
+	uint64_t index;
+	struct drm_gem_object *gobj;
+
+	gobj = drm_gem_object_lookup(filp, queue->doorbell_handle);
+	if (gobj == NULL) {
+		DRM_ERROR("Can't find GEM object for doorbell\n");
+		return -EINVAL;
+	}
+
+	queue->db_bo = amdgpu_bo_ref(gem_to_amdgpu_bo(gobj));
+	drm_gem_object_put(gobj);
+
+	/* Pin the BO before generating the index, unpin in queue destroy */
+	if (amdgpu_bo_pin(queue->db_bo, AMDGPU_GEM_DOMAIN_DOORBELL)) {
+		DRM_ERROR("[Usermode queues] Failed to pin doorbell object\n");
+		return -EINVAL;
+	}
+
+	index = amdgpu_doorbell_index_on_bar(uq_mgr->adev, queue->db_bo, doorbell_offset);
+	DRM_DEBUG_DRIVER("[Usermode queues] doorbell index=%lld\n", index);
+	return index;
+}
+
 static int
 amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
 {
@@ -50,6 +79,8 @@ amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
 	}
 	uq_funcs = uq_mgr->userq_funcs[queue->queue_type];
 	uq_funcs->mqd_destroy(uq_mgr, queue);
+	amdgpu_bo_unpin(queue->db_bo);
+	amdgpu_bo_unref(&queue->db_bo);
 	idr_remove(&uq_mgr->userq_idr, queue_id);
 	kfree(queue);
 
@@ -64,6 +95,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
 	const struct amdgpu_userq_funcs *uq_funcs;
 	struct amdgpu_usermode_queue *queue;
+	uint64_t index;
 	int qid, r = 0;
 
 	/* Usermode queues are only supported for GFX/SDMA engines as of now */
@@ -93,6 +125,14 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	queue->flags = args->in.flags;
 	queue->vm = &fpriv->vm;
 
+	/* Convert relative doorbell offset into absolute doorbell index */
+	index = amdgpu_userqueue_get_doorbell_index(uq_mgr, queue, filp, args->in.doorbell_offset);
+	if (index == (uint64_t)-EINVAL) {
+		DRM_ERROR("Failed to get doorbell for queue\n");
+		goto unlock;
+	}
+	queue->doorbell_index = index;
+
 	r = uq_funcs->mqd_create(uq_mgr, &args->in, queue);
 	if (r) {
 		DRM_ERROR("Failed to create Queue\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index c0eb622dfc37..d855df9b7b37 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6660,6 +6660,7 @@ static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 	userq_props.queue_size = mqd_user.queue_size;
 	userq_props.hqd_base_gpu_addr = mqd_user.queue_va;
 	userq_props.mqd_gpu_addr = queue->mqd.gpu_addr;
+	userq_props.doorbell_index = queue->doorbell_index;
 	userq_props.use_doorbell = true;
 
 	r = mqd_gfx_generic->init_mqd(adev, (void *)queue->mqd.cpu_ptr, &userq_props);
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index ae155de62560..b5600cff086e 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -44,6 +44,7 @@ struct amdgpu_usermode_queue {
 	struct amdgpu_mqd_prop	*userq_prop;
 	struct amdgpu_userq_mgr *userq_mgr;
 	struct amdgpu_vm	*vm;
+	struct amdgpu_bo	*db_bo;
 	struct amdgpu_userq_obj mqd;
 	struct amdgpu_userq_obj fw_obj;
 };
-- 
2.42.0

