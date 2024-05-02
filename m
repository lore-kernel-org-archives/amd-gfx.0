Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D96FC4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 16:32:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D2AF11258A;
	Thu,  2 May 2024 16:32:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AIvY8FA+";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3B30112587
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 16:32:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMGFPHP/SFputsLBKz1MnZfvBrhQFfG/1jnvdiT7WZjKEkFYFuJF/f1Vp2xL1NE3/RQMzWUVyPjxYzntDJtl/O4ugmw8D7tMhjYZtRExBUHFBs2ZyXoPjIa6VHdxJwMs2LOKSemMvfxLrSFgRmCa2cdfIjwhuVwtSggt2N9zlhgtW1vmfe2Vk+TJu/ddHp6odONe4CfPPKr6u7qQJjtTD6deOobPzuzqwNMrmmCJTKGSFpS5SaVyoIGUxYHe//SDUykC1KMGnO/fLkznhqQvRYYPG30PsqElgw/ecWdGHNBGXP33+64OsVdnEgZcqp8MDxHK1oFYNlZ9atIYt3PlqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tI+5gxRAXHtxoLkY02hDJC8XS+KCgYCV4aeuKbAH6Uw=;
 b=kltOUlNIofiDxPNB38TFujRDXraAkInSL6pihtYWelpwOsal9pVhHmbtHB5oL7VSE2m/elUCzWtA9ILACdjWRK6t2rck4/xETE2INeW5GTOsSVt8SaSwDhWhmHBDGGCYpOhPd+k56Y6fZyh1e6R6vVSOH9lKkmlxRkt0zx5eAhcdp7Jw8XQ0SxaBvDconb0r9enrpIj8y3mC6XsASaHvIsKTOSBWmO9U1osF9Q/sCgzskVFbMN/bmMuTtKjSJq6na6VlBRE9YDjqueqU7ms6d67yQfGAvMU991PzpnRnYrOeg+kImmM4zuFFE4IBFNkwtGHJVE7IsYjUFbxDm7A/9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tI+5gxRAXHtxoLkY02hDJC8XS+KCgYCV4aeuKbAH6Uw=;
 b=AIvY8FA+ZAnicrAZImh3RIDY6nNDVgWMq5XwBRANPgdt6grOvnfXLGGgetE63qha+wK7peb/I+GmbMXalHiphot26PLZ3IAyNhXHBFmsGSnWYqvkMAwH/8LrGLBe/JH9UpDmurIgNTzhxG87bWjsTO2Vqct/q9YZQlOmxdcZluA=
Received: from CH0PR07CA0020.namprd07.prod.outlook.com (2603:10b6:610:32::25)
 by CH2PR12MB4134.namprd12.prod.outlook.com (2603:10b6:610:a7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 16:32:39 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:610:32:cafe::43) by CH0PR07CA0020.outlook.office365.com
 (2603:10b6:610:32::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30 via Frontend
 Transport; Thu, 2 May 2024 16:32:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 2 May 2024 16:32:39 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 2 May
 2024 11:32:33 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Arvind Yadav <arvind.yadav@amd.com>, Shashank Sharma
 <shashank.sharma@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Subject: [PATCH v10 09/14] drm/amdgpu: generate doorbell index for userqueue
Date: Thu, 2 May 2024 18:31:46 +0200
Message-ID: <20240502163152.1382-10-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240502163152.1382-1-shashank.sharma@amd.com>
References: <20240502163152.1382-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|CH2PR12MB4134:EE_
X-MS-Office365-Filtering-Correlation-Id: d2116b9a-cc37-4364-ae6c-08dc6ac57b82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?whDTOkex608bRgPuo4A2pVLaLMC2Z3oZ4/PAUU+hu8+aO84dH0aZoF+9UdIA?=
 =?us-ascii?Q?jii09sb+BLNSwfMH5YID7u+IQyrlgJj6jWnIfhwbDhoDREV50iorOT9xGlC8?=
 =?us-ascii?Q?sUd1HmXflhRB4+QOPPV6K5/NB+g1cENYjjD/GjC8e6H1Yv8itiKu1m0UFQ34?=
 =?us-ascii?Q?fNvqEq7l1QZEE3U1xYl9sjfJMJW09RClwx/HI0umhHbQpNGmS55eNhJqZdHz?=
 =?us-ascii?Q?cg5Lu5uZcFyAJ+lUjaza3IZASsDUqTHP80S13WhCMq9/J0xhl+wmfHYzDZL6?=
 =?us-ascii?Q?mpCxQ8jIvUqrwjBRpc0Q/W53+hm68u+wVvD46BPKQQOk91Fc34bSNf4YuJ3i?=
 =?us-ascii?Q?wVhEC7K44w1Lg1nDXkcYY+517KtOOJLdI3CnIfrQPNchQRpco7ixWZvjjWqW?=
 =?us-ascii?Q?gYzeHfiuRguB+CR3IO6MwM0NQiypeKi7Oz9XqIO1UZ3RS8oxMNplZdzUUChF?=
 =?us-ascii?Q?hCVVbhzyCcrwnJ8wgJV39VwbRE7HeXYeUfP9UgO0iW91Ym33rCFBq7qBH76G?=
 =?us-ascii?Q?8U7iwI0GbYi7wCroyVJUDBZlCLzbSpwbTCu69CbcnhXiTfWRcjKL0YQl9U2H?=
 =?us-ascii?Q?7EA8fKNllvl+g63NWqf9fgNvKaTK4FadxhcZ37K8U0fw+zek1EhtWWJZrajN?=
 =?us-ascii?Q?9mltGUp2NtQm4aKunHbM/N0J8GGI8hJd3FHcVpgsUbqOaSOhhAE3JlTs0ZKD?=
 =?us-ascii?Q?fZgngNTsgPb9CcZwpRo7UREPhanU1e7zuq1Sxam19VZjzo2s+ux2cHmJaDJK?=
 =?us-ascii?Q?UF1bX7LUWoyatW5ffIxhnB9iVetStnzPi/wi55SwyRzUu97l9WVG6rkvlxMu?=
 =?us-ascii?Q?CFXVw++kTwsEcMg2hpj5VOQZ7FBuDtpdc1ef9RKZM1S7bj04lK/Jd0/ZBjew?=
 =?us-ascii?Q?QYxRy7NZeBcV9iaALXnhhOF4eBNvt5uVn8hdH6YSXAYOAPURQJs42I6/oUL6?=
 =?us-ascii?Q?QEeHtaiUk9IoKc+eoXQdfUzSTdTZmt9W7+aOrkiSwE3C+nCjeRK4rhg66JyB?=
 =?us-ascii?Q?bfmQs1uyqxuwnb3QIrIJemIOpJmSzLQ//BdQNXNm2LLyaXi9UWHrzbKBppTf?=
 =?us-ascii?Q?a0k1yZIf2DcnuXtlvGE/clo8FI2tO072AtjhsUpHxfA+6CGQUf5bnQbki7Kd?=
 =?us-ascii?Q?q5RdeuXluEtrSmRvXqz8pwYm0Q7LTmmvw6D8FJ51EJJkj+6xHip+XTZrtang?=
 =?us-ascii?Q?XEKBBeMwN3XdAomfD2UzrFCUflBjZpyD8krGaw4R+qNBmCUKoQLuMsfEgY2P?=
 =?us-ascii?Q?Qm1/mR72aFyaQdY9vA7C7VEEcNUcFAQmfBhDhjyHo7Hb9uGdPdSv9luwGOp4?=
 =?us-ascii?Q?0FdPnV1EN+3O+mZAPUAmBGsIfwvK3tpLOVVZ5Pp9k9SqtLfFV+LstLgHWAb+?=
 =?us-ascii?Q?4q5VSJM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 16:32:39.1156 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2116b9a-cc37-4364-ae6c-08dc6ac57b82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4134
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
index edbcb0f4c898..fbf6235cfea0 100644
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
index 6ff04647b62e..d084c5754273 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
@@ -236,6 +236,7 @@ static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
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

