Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A1AEB64DD
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 06:04:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C55CD10E659;
	Fri, 11 Aug 2023 06:04:21 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::60b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E436D10E65A
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 06:04:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+7zL8lmUvM4sJzz7WW5VcHXhaJtYI7kbl3NoRZi4HMJbk5dStbtXAmIN64J5bx0nQptK3kMnkyFkkiFRJgmlGohCUo0hHpGXLm2mYtOgnwXFRq+zZsjIhl9ZaRHM5nneCHQHINsZzx01aJr2it8KTPd4iDt8vkV2VJuAK25c5AYJSXcN2j0Eul/LHzFblgfbmfEX9JCShYZt2eX8zBxPNFhxgvqF2v0hVshwaM524IFpKgvMznubuigj+j8qoQDJnBV4l/JquCrgcK7cVFywh18y+1W40N+IgZMkA/J6G5JBtyDW1oci1QsKZwER8+PWHtm7sDzbuunG8hUC83kQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ml9S71WegmqgCT9xTamu8v1lbLPBtk93fZYz3wuUImw=;
 b=PvzDBmlNq0KZCty2L0AUqs+MSdyo9wUmuQdWPxlDaoTOIGgo9Ukkb5ILINaQ7C4tiJeTq/THoUKDVEVr9AV/geaJ4zCC/Zg5xHknn0waXSVGb+btjfKBwoWHWOg4SIQ9JtZOcPyTlmYE+5WjMwn4wlP5TiegJNVDZ0YO/bKSZo1BGem1nTOyWM7PFJMJVJfeONQwDQWKlOtd18ZPK+cf0FLenln4CRHKwQSfheCw2nQiAXLmmq7+z0m16gELcKYcwunvPVwowC7DhO6klmvVqjpXkKQE7MLsnrCKU6Volm+Le86wjvtWYv1d/Ydy1FRC9rEtHIfnxrG5AGIhLy2ULw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ml9S71WegmqgCT9xTamu8v1lbLPBtk93fZYz3wuUImw=;
 b=PuJG/yy+vHKItE5IOq+V4FuWWlrIuqldSvCNCbC90BvcNlfVH9BaHWX5z0/w/+7CI3L7kSlS4KOCd0c22Rt0V1Ui3NI/K9qiLIKE5wLOik2En4SD9eSs8nmBZ5An0j5Pa6qfLhVGY+aVJvaqsFl2hNKdxfVWLbSQgAK50L/eTzI=
Received: from SJ0PR13CA0057.namprd13.prod.outlook.com (2603:10b6:a03:2c2::32)
 by IA1PR12MB6043.namprd12.prod.outlook.com (2603:10b6:208:3d5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 06:04:09 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::83) by SJ0PR13CA0057.outlook.office365.com
 (2603:10b6:a03:2c2::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.8 via Frontend
 Transport; Fri, 11 Aug 2023 06:04:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 11 Aug 2023 06:04:08 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 01:03:44 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/5] drm/amdgpu: Add TDR queue for ring
Date: Fri, 11 Aug 2023 11:32:34 +0530
Message-ID: <20230811060234.663789-6-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230811060234.663789-1-lijo.lazar@amd.com>
References: <20230811060234.663789-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|IA1PR12MB6043:EE_
X-MS-Office365-Filtering-Correlation-Id: de2da340-1a26-42d9-0de0-08db9a30c6fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GOvQSWOmohEWvVamwBkqjbU7ThnpHxVSvqm3jfRmioYuWfMJM++oeTlituQeJRIyRBHsN6YeI89NtyuWlPcjxiDOJJJKNy0ncAdvXTXdaksYxaSWswOuLfFgtYQH1c36RKWT5dOJfabYXV17qBf/VE4iNDZ+0WXFd2OSWu8IxPKMWFV5HOTqNv7SnKwJbfB4/D+Z6xHjwkaluNIMovb+iaUypnQWmkXIQQoYpJgRbEC9HLJat5XkVBgrjxNyLZ6fMwHK2WdXMQLgy+sPIDIaMx+6NlakzIThWQuYnX+//nNHW5EGhGrqM7hIV8JlRxU5stFZPxCpPSw03cR6uX7GDfe0PJh59PjDQbEYSWrh5iwomTw7SLszsIwjssgne4qkKyuI8RxSmrXrD2EC0HqQNUH63w9kVFg1ifoN6FL9fLIv9QlsJhmMkslEPMklRltpDv0Qh5wRV7mkvyUrRDWmZTYlJPL3B+QpZOA7Pw75Bb+PS+6DihsrLN3cIVrNIVnLsYT3gAV5U3MLvWjGgmA3x+nFZvb1nVCkf0FKBqPnu9FcrOCDLLERy+ZPmOCl1Hd2wZRoQWkuT+DUE17PYrTmQJlLI6qblwt64DbWCn7LtJZ+/sc6eOyN/9De+CV2+j33cnX/U2m9gLeBsrz5SPu6F7dZc3WjiF/3/MKGAZKvaRkkY2Cxs2TsXjrHvuT51Lth/oTEN3fmMp0hV/GNQRWlZWcsmAxZwq1wVRN87cSquBUx9Rwf3hAw2Kx9tzs9I5GXopsfttGMxebqYwwoSPthkg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(396003)(82310400008)(451199021)(1800799006)(186006)(40470700004)(36840700001)(46966006)(316002)(336012)(40460700003)(8676002)(8936002)(26005)(41300700001)(1076003)(356005)(82740400003)(81166007)(36756003)(478600001)(4326008)(40480700001)(70586007)(70206006)(6916009)(6666004)(7696005)(54906003)(426003)(44832011)(2616005)(47076005)(36860700001)(86362001)(83380400001)(5660300002)(2906002)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 06:04:08.8984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de2da340-1a26-42d9-0de0-08db9a30c6fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6043
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
Cc: Alexander.Deucher@amd.com, Asad.Kamal@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add a TDR queue for rings to handle job timeouts. Ring's scheduler will
use this queue to for running job timeout handlers. Timeout handler will
then use the appropriate reset domain to handle recovery.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 16 ++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   |  5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |  1 +
 4 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4aee867ec59f..78db74b7a49b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2307,7 +2307,7 @@ static int amdgpu_device_init_schedulers(struct amdgpu_device *adev)
 
 		r = drm_sched_init(&ring->sched, &amdgpu_sched_ops,
 				   ring->num_hw_submission, 0,
-				   timeout, adev->reset_domain->wq,
+				   timeout, ring->tdr_queue,
 				   ring->sched_score, ring->name,
 				   adev->dev);
 		if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 78476bc75b4e..e081c0056a60 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -31,6 +31,16 @@
 #include "amdgpu_trace.h"
 #include "amdgpu_reset.h"
 
+static void amdgpu_job_recover(struct amdgpu_reset_context *reset_context)
+{
+	int r;
+
+	r = amdgpu_device_gpu_recover(reset_context->reset_req_dev,
+				      reset_context->job, reset_context);
+	if (r)
+		DRM_ERROR("GPU Recovery Failed: %d\n", r);
+}
+
 static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 {
 	struct amdgpu_ring *ring = to_amdgpu_ring(s_job->sched);
@@ -38,7 +48,6 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	struct amdgpu_task_info ti;
 	struct amdgpu_device *adev = ring->adev;
 	int idx;
-	int r;
 
 	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
 		DRM_INFO("%s - device unplugged skipping recovery on scheduler:%s",
@@ -75,9 +84,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		reset_context.reset_req_dev = adev;
 		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
 
-		r = amdgpu_device_gpu_recover(ring->adev, job, &reset_context);
-		if (r)
-			DRM_ERROR("GPU Recovery Failed: %d\n", r);
+		amdgpu_reset_exec_work(ring->adev, &reset_context,
+				       amdgpu_job_recover);
 	} else {
 		drm_sched_suspend_timeout(&ring->sched);
 		if (amdgpu_sriov_vf(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 80d6e132e409..9b2e5e6e9388 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -357,6 +357,8 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 		num_sched = &adev->gpu_sched[hw_ip][hw_prio].num_scheds;
 		adev->gpu_sched[hw_ip][hw_prio].sched[(*num_sched)++] =
 			&ring->sched;
+
+		ring->tdr_queue = create_singlethread_workqueue(ring->name);
 	}
 
 	return 0;
@@ -399,6 +401,9 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
 
 	if (!ring->is_mes_queue)
 		ring->adev->rings[ring->idx] = NULL;
+
+	if (ring->tdr_queue)
+		destroy_workqueue(ring->tdr_queue);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index e3f98554bb3c..3c60af19ad05 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -299,6 +299,7 @@ struct amdgpu_ring {
 	bool            is_sw_ring;
 	unsigned int    entry_index;
 
+	struct workqueue_struct *tdr_queue;
 };
 
 #define amdgpu_ring_parse_cs(r, p, job, ib) ((r)->funcs->parse_cs((p), (job), (ib)))
-- 
2.25.1

