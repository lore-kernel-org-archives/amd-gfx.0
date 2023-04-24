Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB85C7618E
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Apr 2023 17:39:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9A2610E58F;
	Mon, 24 Apr 2023 17:39:30 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64C5110E5B8
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Apr 2023 17:39:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUkqBqPq0qNpNkwOanRAXKqVjzTzm5GHTrz0a5BhHyKDJJjTJim4uKAnb6oyydwEeE21XbeA6xXWfj0hzGNdRHpOsZx8BxyKa3oXn57H2Wno8W1hzsr/Y9iN3Z467VnUl+InVhIZ9nFx9Z/fZ5Rq3blLvBfNFrYi4AhjnqWmu4ht0+BK+kQvnu9zK5eIFaB8JHHDlbRFJzTiG2ym1LdKbuzgn/Z325swP6JtNzv8MFS5K0TV2xp1DDMggXGeEsko0iP20+jSq5CjtGP7LVac5MaRA+biHdU9wfQketKv3bqagCfa1rqKSUkffXKMk8X8kDZPKXeItuw39rY3VZ+bBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3kOnfUEHZVu7DW5f0kXtGeLYqDqSWZpC9FrGsu1F/U=;
 b=jAcgdi24l3TbGeNqJnNKfvW8tLzsrcba9spTZGK6LgSm5xkFWJLXRUv8IRq+d2Nu+2VjcrF2owk1eYDby+WNJ9TYTXFCqSQv6jamHjXGQelbF9dOYasoZr+fJFA7aNX6phtBf+uoNERFxKNoInYjiHTLD8Nq7EVMlyKrRyVbw6gknoy+56Y+TnY6enqgJ/JKKvUEQVGLECGbEGy0NaadPHY8eLPK8v3H9LdunnTh3Jh6OS943SypHB7Fl30YihA05v5r7p9t8n3m6dU7lDcplzeKWWkQwAVyU/+ixUsG09SJW5RUoym9O/qiLyVlgSRC0GtzH+z6Ro/QUhtqRYPaRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3kOnfUEHZVu7DW5f0kXtGeLYqDqSWZpC9FrGsu1F/U=;
 b=MrUqiwp9nYmfj/dl1tx8S5OtGGqLlqF3leOYFIu9iwmTGLqj6N/7TI3AkoYKcWkftxLBFvXeS0lRS/+/mCLdKosYYy5kNf/MkDhMoE03M4NJTOHJsAxXBqwqPn4kLHqj1efmzjA+BQWEnnOFGPk8CaaZaWGGQGaPbYLHTLHQGbM=
Received: from MW4PR04CA0310.namprd04.prod.outlook.com (2603:10b6:303:82::15)
 by DS0PR12MB7558.namprd12.prod.outlook.com (2603:10b6:8:133::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.32; Mon, 24 Apr
 2023 17:39:20 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::76) by MW4PR04CA0310.outlook.office365.com
 (2603:10b6:303:82::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33 via Frontend
 Transport; Mon, 24 Apr 2023 17:39:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.19 via Frontend Transport; Mon, 24 Apr 2023 17:39:20 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 24 Apr
 2023 12:39:18 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 09/10] drm/amdgpu: generate doorbell index for userqueue
Date: Mon, 24 Apr 2023 19:38:34 +0200
Message-ID: <20230424173836.1441-10-shashank.sharma@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT052:EE_|DS0PR12MB7558:EE_
X-MS-Office365-Filtering-Correlation-Id: 8609a47a-7ccd-4ed1-e7e9-08db44ead5fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8u8b8RKYv0jVwk3thvKRfquKHKoUDWLtO/BDJD2GIfu/iimsjr7SDdBVVj1yM7BNXBu5QUK7j6I9wKpxhEIMVXUZal/4X7I3eGTUGSlXzdtj9LxKA8azr5lA06W5fEP4+OQxY7mfzzYGuPlxadx0SqX7PTKVTjEY6bVnX4eyykaL3k29NgQK+S0NE5c1byJWmGwcvl+tgXs+qOrezOBYOuprKdD+EqvpenbH35HmU/qKFOTgazZ46k7lk8eULkSuSRVkh89WnapGwqMuHBP5KTfjelprgx5IUBQsD11pNlC+aBr5+mxjgDTk/j4GaKuq0K1CGVtxcrfJUS2ANlLW7eF83vV2PR9bhHk1b01Jevaz+iERtPFhgaq0GEgq7bLjvrYh9wOKQmP57qye0kU0AiQh8KN+NTWliJUcpjciXJqqxxMzY32maDopfC+vcDdoaYLRqLj6uvbucDWRphQIqAx9pj8Phhmsf7z0mqlZobjE6a0M7760WflGQXspGBujfz/Wg6SXAzSq7BEDCPY/gBkRxbZyF8lFnlrUJfvFCbzjvfuFBAqyvFrtlqSIYfP7wv+8P4sgiFzrwA/leFDube7a0EP4EkVU975cXUn6Wo5h42lYstOU+IopDc7j0BP6Y3YsBryddWkKwiKuXfrkUls0lBTGcvXz62erk29w3GtCsO3LePeu+hQ5ZeybRnSd
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199021)(36840700001)(46966006)(40470700004)(26005)(1076003)(186003)(16526019)(40460700003)(40480700001)(6666004)(336012)(426003)(54906003)(86362001)(478600001)(8936002)(47076005)(8676002)(44832011)(82740400003)(5660300002)(316002)(70206006)(70586007)(4326008)(6916009)(81166007)(356005)(41300700001)(2906002)(2616005)(7696005)(966005)(82310400005)(36756003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 17:39:20.4939 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8609a47a-7ccd-4ed1-e7e9-08db44ead5fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7558
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

The userspace sends us the doorbell object and the doobell index
to be used for the usermode queue, but the FW expects the absolute
doorbell index on the PCI BAR in the MQD. This patch adds a function
to convert this relative doorbell index to the absolute doorbell index.

This patch is dependent on the doorbell manager series being reviewed
here: https://patchwork.freedesktop.org/series/115802/

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 385cd51b6c96..fbc9cb5c24ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -44,6 +44,30 @@ amdgpu_userqueue_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
 	return idr_find(&uq_mgr->userq_idr, qid);
 }
 
+static uint64_t
+amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
+				    struct amdgpu_usermode_queue *queue,
+				    struct drm_file *filp,
+				    uint32_t doorbell_index)
+{
+	struct drm_gem_object *gobj;
+	struct amdgpu_bo *db_bo;
+	uint64_t index;
+
+	gobj = drm_gem_object_lookup(filp, queue->doorbell_handle);
+	if (gobj == NULL) {
+		DRM_ERROR("Can't find GEM object for doorbell\n");
+		return -EINVAL;
+	}
+
+	db_bo = amdgpu_bo_ref(gem_to_amdgpu_bo(gobj));
+	drm_gem_object_put(gobj);
+
+	index = amdgpu_doorbell_index_on_bar(uq_mgr->adev, db_bo, doorbell_index);
+	DRM_DEBUG_DRIVER("[Usermode queues] doorbell index=%lld\n", index);
+	return index;
+}
+
 static int
 amdgpu_userqueue_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_bo *bo)
 {
@@ -133,6 +157,7 @@ static int amdgpu_userqueue_create_gfx(struct drm_file *filp, union drm_amdgpu_u
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
 	struct drm_amdgpu_userq_mqd_gfx *mqd_in = &args->in.mqd.gfx;
+	uint64_t index;
 	int r;
 
 	/* Do we support usermode queues on this GFX IP ? */
@@ -154,6 +179,14 @@ static int amdgpu_userqueue_create_gfx(struct drm_file *filp, union drm_amdgpu_u
 	queue->userq_prop.hqd_base_gpu_addr = mqd_in->queue_va;
 
 	queue->doorbell_handle = mqd_in->doorbell_handle;
+	index = amdgpu_userqueue_get_doorbell_index(uq_mgr, queue, filp, mqd_in->doorbell_offset);
+	if (index == (uint64_t)-EINVAL) {
+		DRM_ERROR("Invalid doorbell object\n");
+		r = -EINVAL;
+		goto free_queue;
+	}
+
+	queue->userq_prop.doorbell_index = index;
 	queue->queue_type = AMDGPU_HW_IP_GFX;
 	queue->flags = mqd_in->flags;
 	queue->vm = &fpriv->vm;
-- 
2.40.0

