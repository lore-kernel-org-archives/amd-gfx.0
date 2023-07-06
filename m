Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB2AC0015E
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 12:36:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22F7710E3F5;
	Thu,  6 Jul 2023 12:36:45 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::616])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A77710E48E
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 12:36:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KVNVTU3nlxKm6RPczO6BdBDISxlvNIZkT25L4+RY6f0n6yPINzysc9gi/4t+Tjl2dWj564tJm2MmYgutx+KbkDPJpMPPjnY1ES9fc1wKuE0cUswjObeFO3UkWFe/Qrx/r2vSVmBE/yYiPLy7qc7n8qbwJMpC7Ei7kpot8suMDGVQgBpo/OBtgoo4Y1NkEifpU1tq27z4GaCyTaoSQ+hpJz+flgZidrUs6AA06/Xs/09OJ5e0wxTmuTcqxFKPBAXa/DxS70xkcmP9vmjLZW/6W+FDD+0vbjaKzcx3OwbNL1WeWWB3/RDn2XZgV7jZMEOhIrSXzdS4EowptpQEDpijzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sIwYKc4PPzckNsOc1w+6g/K8vw9xEcNcmZev9w3it+c=;
 b=FIPqSJ8QyRF/PFYe24wjJGKPuKPi3quvm/l94YNkZQYWXUYb5QZbtX41cZTU0wmuDzC0iqa0IS7EUAehGAVdto4mPt8R0py5/4Q1YBKNAJgWXmO20czhj55NJqMogdHNrYsof4bFAIuQGnmhrRh6d43OceP2y29FinyPdWEdgMwo1VuL0n8X+YaPUEPHbOw1V++Q/vJsI9LRTmNLbxKmhRtJA1iAjB1siEXHiZuw4bGVKL169YwCGVOBw8DQILMEUYno82OA0VTj3QKjL5SIj6rSm0qiSMMgbT+u1MTtuSMxQ8KaRhLmpsdflc/XIuQSo9Rszr8/5Cijl5z3IzShjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIwYKc4PPzckNsOc1w+6g/K8vw9xEcNcmZev9w3it+c=;
 b=Y0yDm/bzB+HhvWZGNphv+YQtSw7xYnf//6EMOoGm3QLt+t+6+Ryid8V5lfciPPN0hW/ZXDqC7ql5+uzBfEYHeZ6n5cn0+KRYZoQXrLRIIl26No1NiWTvo36uzpqauNsJaqTJZwTTWNrMIkNWyg5bvoYYPQsUmD8YmsN5B9hCSwo=
Received: from BYAPR03CA0020.namprd03.prod.outlook.com (2603:10b6:a02:a8::33)
 by SJ0PR12MB6855.namprd12.prod.outlook.com (2603:10b6:a03:47e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 6 Jul
 2023 12:36:39 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a02:a8:cafe::13) by BYAPR03CA0020.outlook.office365.com
 (2603:10b6:a02:a8::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Thu, 6 Jul 2023 12:36:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Thu, 6 Jul 2023 12:36:38 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 6 Jul
 2023 07:36:37 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 08/10] drm/amdgpu: generate doorbell index for userqueue
Date: Thu, 6 Jul 2023 14:36:00 +0200
Message-ID: <20230706123602.2331-9-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230706123602.2331-1-shashank.sharma@amd.com>
References: <20230706123602.2331-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT028:EE_|SJ0PR12MB6855:EE_
X-MS-Office365-Filtering-Correlation-Id: 75451e61-e674-4faf-e044-08db7e1da4fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vl4/gNPdY00leZhonoykvj+yY9JndREbxu0PtzyR/5IlTl67kXE/jnHQAyLQMjlGYwX0xDxccqWyNLDdRRqIjrZZ+bHcPgrFLy+KtNcVfX15Dw8Y/vhJAMmte0NtRTTGMvqS6JF+nXV/dwczNRKx6RMP/UtQrrEZ0+stNwgPUMc2b07HezOIDP64J3rPf89QiFjW5Erbi2h2A482R6fPNLKfoApEvemqZvk0NqJQqWnVAY1dpmp+L3RjGTipwmOg3CUsdeEijfcI4aOYIiswk29ANwraRPy8Fks7A948We0UUng2bRbMj3I7K4FfNebtFcKE9BW63ntbupcrp7bhPpuXo90fEM+C5FcsC/chsN+xbSdZMV0HKL5tdCq+y9zWONfVs3krMm7Y/8B81O01OZBscgYCZvWcbqe1fAYI2vzZFgWOGAbbVV2RnCxcFC9oQLiz7CMQi4sOBz3I70aooYvngqhzEJkCDylKvvMAeoeFx+FTCC5PWswiWzMDh/dLcBHsrYKkU5xLTzS/z88FGEG3TmPDUtYdU4iZTqFT12HgDIxI5UsXWpvkS3Cw0JSvF4ruOpfa//nAdxFj6Dx+PBZyuwz/7lJnD7pK8LFjy3/VtSCRwG/qtI4fz00R1kh3tBcnbquAv3d9+dp71VlNAHnoSqtL7+A3ENoMC0SmKOLXoic2NTk6o7en+yv/QM562Aa2FmHMokMrStNISVtV0UncuHpuPTUW5Y1rFM7iI3SCQUaTvzc/MxT7MgqHnKd+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199021)(46966006)(40470700004)(36840700001)(44832011)(478600001)(5660300002)(6916009)(4326008)(316002)(70206006)(36756003)(70586007)(8936002)(8676002)(40460700003)(2906002)(16526019)(6666004)(26005)(966005)(36860700001)(54906003)(186003)(41300700001)(40480700001)(82310400005)(7696005)(83380400001)(47076005)(426003)(336012)(1076003)(81166007)(86362001)(2616005)(356005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 12:36:38.9594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75451e61-e674-4faf-e044-08db7e1da4fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6855
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

This patch is dependent on the doorbell manager series:
Link: https://patchwork.freedesktop.org/series/115802/

V5: Fix the db object reference leak (Christian)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 34 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  1 +
 2 files changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index bb774144c372..61064266c4f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -32,6 +32,31 @@ amdgpu_userqueue_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
 	return idr_find(&uq_mgr->userq_idr, qid);
 }
 
+static uint64_t
+amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
+				     struct amdgpu_usermode_queue *queue,
+				     struct drm_file *filp,
+				     uint32_t doorbell_offset)
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
+	index = amdgpu_doorbell_index_on_bar(uq_mgr->adev, db_bo, doorbell_offset);
+	amdgpu_bo_unref(&db_bo);
+	DRM_DEBUG_DRIVER("[Usermode queues] doorbell index=%lld\n", index);
+	return index;
+}
+
 static int
 amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
 {
@@ -64,6 +89,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
 	const struct amdgpu_userq_funcs *uq_funcs;
 	struct amdgpu_usermode_queue *queue;
+	uint64_t index;
 	int qid, r = 0;
 
 	mutex_lock(&uq_mgr->userq_mutex);
@@ -87,6 +113,14 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
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
index afaeecb9940a..8edb020683a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6719,6 +6719,7 @@ static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 	userq_props.queue_size = mqd_user.queue_size;
 	userq_props.hqd_base_gpu_addr = mqd_user.queue_va;
 	userq_props.mqd_gpu_addr = queue->mqd.gpu_addr;
+	userq_props.doorbell_index = queue->doorbell_index;
 	userq_props.use_doorbell = true;
 
 	r = mqd_gfx_generic->init_mqd(adev, (void *)queue->mqd.cpu_ptr, &userq_props);
-- 
2.40.1

