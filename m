Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F37C369B4
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 14:12:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85F7B10EBD6;
	Fri, 11 Apr 2025 14:12:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bptd68al";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A455310EBD2
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 14:12:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KRHWWd7P376OBZ37r5fj5bh6rcRmaP+9dN8hqNv5iA+vodDC6WjBYh7XQdiWnUh+rbeM7RXJxC2DMa+lYzR9tFwCdX3nuSHCLirzRvCXWrVyI0+7wcnPcSMLih2FmwlRjFKgfLYbe6iuDfqlzAUKK8jy+zEEFznGukfTuVPIwAVWIaoMeYbH3T09hEOEyifsUiNZ/x4QSHY+gP6nWIQ9IUVHzkLZ8BnXfJJ35H9gZ2TabaXFfX6J8nV8KGv5B1sIs8WdKTuhmCrKyJD+KNClNRHyaxECPIXPVjbSqskNB1rZtuVc5Ls/e3USnHtzqmrsHpWMoejYZ0HYaJySRJaBfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wn7z8G5wHItL7ShjOcnmgVkZvkokt4PTEf/prTycMuc=;
 b=GyG1g23bGXknWl3y7uEucpYtGP6wCLVmkruEnZODseY+uwIoB9KchhxcSMi/jhCnt2F/odIN4HRX+Fl5ChcLvFe5dMqViMnP4EkG/x2ux1qUlGddeXY5HGrkiIEicAG8pCDxj11zSOTV98uadpVXfx2pGFm5Zv6q+NBHnEddvQ5zLUsqT+SAfZ1IuBh0//mhWg8sh8/qAoUcpItCJf95qZJY+TJU84gJwYzATu0aR8OaqaG4pvDPiyFMBoKYbzuDsda1xSma27csyDoD7om5ZjTlM4hbEhoba728UFFzEQzX//D/M7Rk2VlvajWHITMmhw6Qd0G1p4ytNoy+8Amiug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wn7z8G5wHItL7ShjOcnmgVkZvkokt4PTEf/prTycMuc=;
 b=bptd68alWFqCt6xYrGFhN0t5CpnwSOE9MoX2ASPqgqRMRqvW/AAZbr/zincom93lWlFAlJfb5cp4tASraVZfEFXf8eW+lAj/dAc2QA4MhrCsN/cphEVh+SO5SBAWMOjP6Autfdn9aFYsxBevqeH0mC2T9Ejp0YU6ox8f4WgVPyU=
Received: from BN9PR03CA0643.namprd03.prod.outlook.com (2603:10b6:408:13b::18)
 by PH7PR12MB6882.namprd12.prod.outlook.com (2603:10b6:510:1b8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Fri, 11 Apr
 2025 14:12:46 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:408:13b:cafe::94) by BN9PR03CA0643.outlook.office365.com
 (2603:10b6:408:13b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 14:12:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 14:12:46 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 09:12:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 8/9] drm/amdgpu/userq: add helpers to start/stop scheduling
Date: Fri, 11 Apr 2025 10:12:27 -0400
Message-ID: <20250411141228.2722962-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411141228.2722962-1-alexander.deucher@amd.com>
References: <20250411141228.2722962-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|PH7PR12MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: 693ade09-20da-483a-6f0e-08dd7902eeda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4EiZWNkXSMflaHmKWnmmVtGwnMcixevad2i3PXZYqUJMjy6X38OuKs3LFvKe?=
 =?us-ascii?Q?A9dRb9CMKlQpGYbguM97jESDAZ/Qi87VkN5BvUZklipwURHTThkbcTemkKPj?=
 =?us-ascii?Q?aFlWJuD1x2gca2UpiFeRltCdTQlQWUW122X/+Y9TYMldPxBSaj0RxvpXywd8?=
 =?us-ascii?Q?CxLmJl1L7QwSz0OUdZGE/4Pkn8pzlQ08zYVN2paGamJ/KYiw7w0NS8dVRP9o?=
 =?us-ascii?Q?eXuCwj9tl1p1bpTrPzjGGH/lW77cv11VyVAIOLieQT947Jf4FBTqA2zGvpK6?=
 =?us-ascii?Q?LYMhZ88jV0kQT3g1fwpqcLD6oKmiGDXltp1CG99IFXW5pMqxeocudt7uN7Jy?=
 =?us-ascii?Q?9Rj7rJToguqihRMNs4lINliQ7jpJ1AHF8j5m2jCtGuAa1od+5/SmZatUoRm9?=
 =?us-ascii?Q?7VkmN5HWiFxQ8K3+kd/ZWzRkxW3v77HnhGaMQzWe1hr/uYYBhsFUlkOYNIxu?=
 =?us-ascii?Q?CqXPR2VzQFO9D6H/qfm4e2nI6rB2AA4aiwRfwQMSC1OxcXE01wSxu9tZrmEE?=
 =?us-ascii?Q?Cd4qkmVimhc9Ywecz7LBJzIFEf0sX/uGXnmbRUZOWouvbud6ERpc3aTQEgKH?=
 =?us-ascii?Q?m+LVVyf4QCHK4JwQZhb2RXpf1ve723gyT9qZ4MHsYzx6zBo+O64nt/gBvfCH?=
 =?us-ascii?Q?idf0KzHJ7gy8dJHxQFDSOf0dCXSChkaJbl+qSrMP4PZHUGgx2hJOTgr9yaMH?=
 =?us-ascii?Q?MXqQAd3NKWcObL2bIY3IIIyNp2cOl6CMVVr6IKhZu+tySzH9+NnUg976idj7?=
 =?us-ascii?Q?wfUrQ07ukl1Eq9Oz1zJ2YUFW0j7ybjYPC6fjnEs+6Ci/uKmSpE6GxtCLo7j8?=
 =?us-ascii?Q?xhovNY/AK+Z4iz6ROy4h+qlARoCoDan+qjro4TZ2XSGAEKhKY/Z/RqCHntoG?=
 =?us-ascii?Q?gV+mpM6ZguKdESGCAEtNIYpNmO8dU679sAaBMDKXB6KUW2ln97mvXZn6ML5b?=
 =?us-ascii?Q?aBuZh+qnyO+h7kIJDOAyMWYl4MZyF4y0zlDS4GY6kkmIuaDYO0wfL9TVdD21?=
 =?us-ascii?Q?SqGwBnO6Eg+KA/Hz3G/bEbEVfUaTNt0LU7A4qdPoDumzYWlLypCu0jd8zXNR?=
 =?us-ascii?Q?PaFN1IQwRy+fV2Alzgss26YQWeMDEQPmkHvFqy/U8RpueNHdTt5eOXBbcXaF?=
 =?us-ascii?Q?0B6eh6ftbKd3ZudD63IjyTKDDi3lB3rOa4/jA6QSZdm1iNhoswuoDofA0cVd?=
 =?us-ascii?Q?+9aru1fP9/tqQxGa25Qr53xq4fDEUpRdX+x+wK+xjYZG9Ftjygy+HfZzDwlh?=
 =?us-ascii?Q?874la2y9INx4lBXmO+pLmtieS430RbsxYTunD9BouxhB2p712b09J0tVo6Vr?=
 =?us-ascii?Q?K/itNwho3Vc8VJCwtMaKtttjT7Cq08143p1cbzlcF1hOGRqS+jFAVSzvxO15?=
 =?us-ascii?Q?Ovu25tV3GW4D6EwRs4doXUnB5dJ3XTETIUe5UnP/Hu5ohxPYfBh19uio8qPV?=
 =?us-ascii?Q?OLUkG56fS2+Bfby9k9VHBR0UKBr1S5OK4t9bQv368lcCZh//C/4whvsqAPhL?=
 =?us-ascii?Q?gRlq43AC9AWPV+vetHaHAG6mVyJ8fkzgYwMZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 14:12:46.0354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 693ade09-20da-483a-6f0e-08dd7902eeda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6882
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

This will be used to stop/start user queue scheduling for
example when switching between kernel and user queues when
enforce isolation is enabled.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 68 ++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h |  3 +
 3 files changed, 64 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index b156e31ac86ac..30c485f529d17 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1249,6 +1249,7 @@ struct amdgpu_device {
 
 	struct list_head		userq_mgr_list;
 	struct mutex                    userq_mutex;
+	bool                            userq_halt;
 };
 
 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index aa7222137c31d..e93e390f4e301 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -335,6 +335,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto unlock;
 	}
 
+
 	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
 	if (qid < 0) {
 		DRM_ERROR("Failed to allocate a queue id\n");
@@ -345,15 +346,21 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto unlock;
 	}
 
-	r = uq_funcs->map(uq_mgr, queue);
-	if (r) {
-		DRM_ERROR("Failed to map Queue\n");
-		idr_remove(&uq_mgr->userq_idr, qid);
-		amdgpu_userq_fence_driver_free(queue);
-		uq_funcs->mqd_destroy(uq_mgr, queue);
-		kfree(queue);
-		goto unlock;
+	/* don't map the queue if scheduling is halted */
+	mutex_lock(&adev->userq_mutex);
+	if (!adev->userq_halt) {
+		r = uq_funcs->map(uq_mgr, queue);
+		if (r) {
+			DRM_ERROR("Failed to map Queue\n");
+			mutex_unlock(&adev->userq_mutex);
+			idr_remove(&uq_mgr->userq_idr, qid);
+			amdgpu_userq_fence_driver_free(queue);
+			uq_funcs->mqd_destroy(uq_mgr, queue);
+			kfree(queue);
+			goto unlock;
+		}
 	}
+	mutex_unlock(&adev->userq_mutex);
 
 	args->out.queue_id = qid;
 
@@ -720,3 +727,48 @@ int amdgpu_userq_resume(struct amdgpu_device *adev)
 	mutex_unlock(&adev->userq_mutex);
 	return ret;
 }
+
+int amdgpu_userq_stop_sched(struct amdgpu_device *adev, u32 idx)
+{
+	const struct amdgpu_userq_funcs *userq_funcs;
+	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_userq_mgr *uqm, *tmp;
+	int queue_id;
+	int ret = 0;
+
+	mutex_lock(&adev->userq_mutex);
+	if (adev->userq_halt)
+		dev_warn(adev->dev, "userq scheduling already stopped!\n");
+	adev->userq_halt = true;
+	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
+		cancel_delayed_work_sync(&uqm->resume_work);
+		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
+			userq_funcs = adev->userq_funcs[queue->queue_type];
+			ret |= userq_funcs->unmap(uqm, queue);
+		}
+	}
+	mutex_unlock(&adev->userq_mutex);
+	return ret;
+}
+
+int amdgpu_userq_start_sched(struct amdgpu_device *adev, u32 idx)
+{
+	const struct amdgpu_userq_funcs *userq_funcs;
+	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_userq_mgr *uqm, *tmp;
+	int queue_id;
+	int ret = 0;
+
+	mutex_lock(&adev->userq_mutex);
+	if (!adev->userq_halt)
+		dev_warn(adev->dev, "userq scheduling already started!\n");
+	adev->userq_halt = false;
+	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
+		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
+			userq_funcs = adev->userq_funcs[queue->queue_type];
+			ret |= userq_funcs->map(uqm, queue);
+		}
+	}
+	mutex_unlock(&adev->userq_mutex);
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
index 381b9c6f0573d..fd0542f60433b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
@@ -114,4 +114,7 @@ uint64_t amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
 int amdgpu_userq_suspend(struct amdgpu_device *adev);
 int amdgpu_userq_resume(struct amdgpu_device *adev);
 
+int amdgpu_userq_stop_sched(struct amdgpu_device *adev, u32 idx);
+int amdgpu_userq_start_sched(struct amdgpu_device *adev, u32 idx);
+
 #endif
-- 
2.49.0

