Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A292EC369B7
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 18:48:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EBA310EC63;
	Fri, 11 Apr 2025 18:48:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HAtPveWQ";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D367410EC61
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 18:48:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qjNsMOg4EdINFq49n4f/k53NuZtKkXDQui6VWQMBKbjE4C6uc+RfYt/dVQCmfOpSqgnEWN8NDzYm/2GtryC+OTUco/EyfZ7xAC8xkq3GfpMS6OnFnWjcdjD7kM2Zmuh45cShVkurKtC5IgeEBgywXgEoMIr5idjZt0Cw1RfizTPpK37pqPR1QJDaZXe1A07xZfUxtYtGTtQR4Rlu8kANQWWbPn+2q/OXAtbPYsd11ObKlx600Ff2RzDoLXvcLEY4kkZUjKHHuaGl5IAMxQiMUBT1h93fa1Un1ifkufefcSgH/rXjk/KC+xSw3+v5YE6RaHWeZOrtrihwIOLUNrRLjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGMZEpWRTUq3qsMB3004UW6/DnMjAwYDeMiDHAOMQfk=;
 b=n1rhbl1SGI5mfj5mqs5/j5LrYTjzKQ9n9hnSb51QJOPeFORqiKML5OIChhnaO+CoPSOmO5jsgnvn+N50cKqtkL0bFZ7Lzf/pRB1xn8cjQ4U9r8qgmMntS/3g/B0znK8CqE0SwK2WWgRukg9ZotVhPvvitLALuMtafbJcvr7sqCO8pHpgYFnez8gazc80Log+BiXzf5GbLFBFi7CPDF6Qp/wc40XohlAdDf6+FHk0mdzDyc+3IU9u2yt/17ZjH/y36O1C3fDV3GTRGWKlgtlJSnLLuoiojDpN0h/hg/qH7lFr4Fom1sT9SOgmMMRpTi3zR8iMMlTf2061w0yQZgaA6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGMZEpWRTUq3qsMB3004UW6/DnMjAwYDeMiDHAOMQfk=;
 b=HAtPveWQP1kOsZTsjKVpG1zGniLg588q6aFqikR5pWRLNZd1Q1asF52ae67PART/ZQeOIjVg7uSpuY4tpjZm3cICsZ5Zmn5o/RfpvAmar0Lw9/OIqUKIcrP1M6iF7cgMYDMbIzhyHrwZtlEbZo/M1saBxYnqoSQmex0o7tBpn1Q=
Received: from MN0P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::22)
 by SJ2PR12MB8881.namprd12.prod.outlook.com (2603:10b6:a03:546::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Fri, 11 Apr
 2025 18:48:45 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:52e:cafe::73) by MN0P220CA0005.outlook.office365.com
 (2603:10b6:208:52e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.29 via Frontend Transport; Fri,
 11 Apr 2025 18:48:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.0 via Frontend Transport; Fri, 11 Apr 2025 18:48:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 13:48:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH V2 09/10] drm/amdgpu/userq: add helpers to start/stop
 scheduling
Date: Fri, 11 Apr 2025 14:48:24 -0400
Message-ID: <20250411184825.2890189-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411184825.2890189-1-alexander.deucher@amd.com>
References: <20250411184825.2890189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|SJ2PR12MB8881:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e588acb-6993-4564-72b1-08dd79297c75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jmOeR/8saC2qvNFCnp29dmhdPghv8WRrA/plGoOPgZwOl1oI3qha+g72owWh?=
 =?us-ascii?Q?pPT1vBu4wuLSwfRclPudtqp7IT1zlGMUmotAjJFz75/DtrjOnSU9xM7PwYo2?=
 =?us-ascii?Q?G4bN7HiiNmwTlZ78IwcNnDFSLtaU3LUw9HFi3Bm3YT8m3uVZJf2IC3HBGqY2?=
 =?us-ascii?Q?r//0u2Egh9yQgX5Eza8wpdf2hOX5zoXQw3GdHKPgMFuOMIBsVrFB8xd4EQKI?=
 =?us-ascii?Q?2Sll2+pL4vAgfYDCnVccDi9cJ5el8NSCR3fqgq3rpOQbnIpdotok7OxexQk0?=
 =?us-ascii?Q?AcMJoiCjoOMq5sitWPsr5gGGRnTL+7BJNaCE4eJvqJK1dKRntEhBLHPNvWNg?=
 =?us-ascii?Q?EyrFkbvHUF5a7OXqU4Yc9OdsfOi/Qa5HQ6wJYwbVOzdNNA524nBpEJGgMdoi?=
 =?us-ascii?Q?6FzG4zzjBwfZx1JDPCZZ9chEo7ShXyTn0WIsBU9weMBgSKNTdqujA7oqD857?=
 =?us-ascii?Q?jwraL/jrYy6uk+5JGJiXUCqhbI3LFkFvnEtYl/+Uq/Jn8DxllpMGrwizkI2T?=
 =?us-ascii?Q?q37YAjdvj0HMdxgoGm/f4fA6T34OeegdLvG7Sy0xJY4Embp9ctUV0CVazlny?=
 =?us-ascii?Q?vUOaFO9GD0jnmvdWtmijZB66As08tVBxJ0EpcarV6gsUxw0Y+iMayWSzHHYL?=
 =?us-ascii?Q?XjsRWgP8XKrl2RCF7ji1HtPZf8FO54grs4fhRpJiHOPe6VL0PZ5yKBi1nxw1?=
 =?us-ascii?Q?Ma5BkfkpNXu67ja4hH9g66o0CxP5nPHP7luJOFPCmdH/2wrhZ9FpkufHFWyv?=
 =?us-ascii?Q?x2gzy7b0C3uyWsLPZozxVMvSC81l2KhXSZrAL6nghceNwbtQflaCN5gpRC1V?=
 =?us-ascii?Q?dcEdcEbKWCp75u1iIaFjgTOvbNch94GOXntJhjGU5jSlGRVCTye1Ob3lPOP/?=
 =?us-ascii?Q?pGI1EJnzfdNjBsTFJHmX2ikdyX5ZMDAZs90n6rMh+6YWYUOZPdgu5mxH2fH+?=
 =?us-ascii?Q?xf5HcARtnoezbBvKz3yitNm6YOSXukTuZC6oD8vQM0wCMiiaz48gZMISzX6i?=
 =?us-ascii?Q?FHDZYK60aUYt/bWmX4fnk6v99b1xKf20WMkJVkweo0M+o/D0qXiWUA6UHMhs?=
 =?us-ascii?Q?bfKXTmVKpJ1lE1/Xm0Ziyzo7z0U74jQdzoK+WjGKjLHzHjMjRJU5erRrSoDL?=
 =?us-ascii?Q?zaQAuyCUsoXfyt6HFqLALKI7vEI91n/VH6f+S/RN5JAor8bwyTJeLI0OePXz?=
 =?us-ascii?Q?L1kN7wNdMM8zdbD59QAqrJMSNIf+hTgt96UAuYiiiBadJfwRWDHYnvhZsEuL?=
 =?us-ascii?Q?imVHUjaYiWN2BknSA894FrITVZCR+09wbYLoeqGjJ6waQHwqvCktDVwEJGPB?=
 =?us-ascii?Q?q91k+pSBrPX5gXSORLYb6KnFENZ+mN94y5xZUJsvRrsuvTXZ+QahKE51bqtZ?=
 =?us-ascii?Q?zCw30qZYViHuW3jBjn6eWPBcgCJO1QxRmSfVDdltEKh/PMEZNMDA2WEtdcKK?=
 =?us-ascii?Q?4SlrhLULm8UZxyGs5IoEb5g+LTJO/N5hazGN5bziFrLgSPqGIzFNx1fMrh8I?=
 =?us-ascii?Q?cTWQOaljynqGIFlfn7Tm1EZi6UkzlGVqipqM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 18:48:44.4747 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e588acb-6993-4564-72b1-08dd79297c75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8881
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

v2: use idx

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 72 ++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h |  3 +
 3 files changed, 68 insertions(+), 8 deletions(-)

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
index aa7222137c31d..5f02df239c5eb 100644
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
 
@@ -720,3 +727,52 @@ int amdgpu_userq_resume(struct amdgpu_device *adev)
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
+			if (queue->xcp_id == idx) {
+				userq_funcs = adev->userq_funcs[queue->queue_type];
+				ret |= userq_funcs->unmap(uqm, queue);
+			}
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
+			if (queue->xcp_id == idx) {
+				userq_funcs = adev->userq_funcs[queue->queue_type];
+				ret |= userq_funcs->map(uqm, queue);
+			}
+		}
+	}
+	mutex_unlock(&adev->userq_mutex);
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
index db79141e1c1e0..f9e6c4b728930 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
@@ -115,4 +115,7 @@ uint64_t amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
 int amdgpu_userq_suspend(struct amdgpu_device *adev);
 int amdgpu_userq_resume(struct amdgpu_device *adev);
 
+int amdgpu_userq_stop_sched(struct amdgpu_device *adev, u32 idx);
+int amdgpu_userq_start_sched(struct amdgpu_device *adev, u32 idx);
+
 #endif
-- 
2.49.0

