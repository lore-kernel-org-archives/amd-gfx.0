Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B622C369CA
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 22:21:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73C1910E9D5;
	Wed, 16 Apr 2025 22:21:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S12AUKmc";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AA3410E0F0
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 22:21:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B5YvomOBnOE5rRyhJ1jIQ/1tgA1ud/1elNm1ogzuI08eVTbME+NFjlCSSCYZ5Y45Q7Sp6OIdp03x6LZo2qBQIzymfxhXMl8gM0sIDtCrwquNH57fQzydcN0bCnM51gOPQJLpgKYHivu77OYKPfQUJBIdN57q1EXJzMmsrmykGsD7gPB9cErERbLj7DLodz5i/gmPa1kNYdahKRMlhj8AhREr2AeYWq8KL3kHHFdJsQrKYrP8SASXQ8h6XsNpbPNqpqZMxHiPXt90/WZVe0yR/pbT6jjDdTXElCLxBpNYGB0KtodHfk7srXinSi3BGOvBKUeRiWaOOsfCAfkdk8HiAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRroFQaDm1TDVx+HODTVkYmOpfSVvyTIpMyl5/55NZo=;
 b=jFoQ7pziejlH2xuIUG1TFyH7lyO8k0GhG5Y9TL7gAXqTIkKcvN5La8hAsks7+reqVPeQVxjqb/iAxYA+t03gNsmM5sHNx93Vxt1G2DCgX3FR5SP2EihfzLa254EIhT4ZH1iEjDX8YMYMMuActYqyQlmrAi0RalyTVCXh7mLghiutGbzRt+jQN7RqjCPuRLMw80oawjIP/5Wag1iUZ0tiE3/ak5u+FVQCPDO6PuT2w6H18/s4IJ+ClfO1x9Yd/Fqne09HajrjIJrqeU6xMo2zFybkUfAliS/U5qK4LCfXg2/F1qhQE7HMrk1QqcfAE5Xa6kVSSwz1m5rvRqruMJTq8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRroFQaDm1TDVx+HODTVkYmOpfSVvyTIpMyl5/55NZo=;
 b=S12AUKmcRkSqpopkrbE2UY3dgKe1wyEYmDDaKX2Zgqlaqs5MVHI+nbsO9NYWTPj6nGXegC891UdctHeI+5IBeuktk23neQBiFppL/jQ6Fskh3lz8Layo84MAxMqgvR/+N4/5VA5Ca+TZOrE+zDLnqRJcjcYIq18eKG0vmGS8TKg=
Received: from BN9PR03CA0274.namprd03.prod.outlook.com (2603:10b6:408:f5::9)
 by PH7PR12MB6657.namprd12.prod.outlook.com (2603:10b6:510:1fe::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Wed, 16 Apr
 2025 22:21:02 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:408:f5:cafe::5a) by BN9PR03CA0274.outlook.office365.com
 (2603:10b6:408:f5::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.36 via Frontend Transport; Wed,
 16 Apr 2025 22:21:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 16 Apr 2025 22:21:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Apr
 2025 17:21:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/7] drm/amdgpu: switch from queue_active to queue state
Date: Wed, 16 Apr 2025 18:20:42 -0400
Message-ID: <20250416222046.1142257-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416222046.1142257-1-alexander.deucher@amd.com>
References: <20250416222046.1142257-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|PH7PR12MB6657:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f901a49-1525-45ca-2043-08dd7d34f8e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0A2/c6VSsNqzMyB4axkTs/Wu21rL97tln09qY/0Y+nD/oi+GJYecRbJGDwsT?=
 =?us-ascii?Q?XnXsJsNYtvXdQT7BsDdpLtQNNGpIXfDZ575yFjqp3dxM2HFMr91capsQGsEb?=
 =?us-ascii?Q?8ee6mzSgnKAVJ/MntbRCulup9wYmHb3sGDLk4Fl+mybRZgmbR3MGAO6USBHS?=
 =?us-ascii?Q?NFjBlv1E9rOmU3iuIsEqBT7u9pVj3TgPCsxwaAlJEwmhlLelP2rUXM7f1hQc?=
 =?us-ascii?Q?6SSs+vDLwLcfKIkSNAV8pE7t8h8SOpilFAK1OI/GclYKtiQPgF4dhGd/ICoz?=
 =?us-ascii?Q?4RdMmBOkVAqXDI6x9ncWxIC0qKRWWi5525UfewWfT1PbhFyyuPdeLM2W9RAg?=
 =?us-ascii?Q?AjYzXlMp61fIiGg2RDX3u7Dfebw2VMv766cJvRtTwFPa3hyRgaoaW9/tDJGj?=
 =?us-ascii?Q?r4qjlC1Y3dby3NEVwWRExytE1Y2smZzzt0nXmUIzyvMJi9LNsNbG1DBCdI6S?=
 =?us-ascii?Q?+b4dGqEuOsdNnPWd6A5rnFxKC1LkODcXRRrFGQzkOIPOGRi5Asd08mTlcqxf?=
 =?us-ascii?Q?gAQwlN6qc+y2TriTnQ1ZiAz4AnjkqZpXXVOi3Mo1y9rnF28dV4zSW73VsTAM?=
 =?us-ascii?Q?Nw9tMdmcUzxCFglD5p6PoVYWXzkHaK8E2+OrAXFEkC+2dqGB3xyzEGFlJLml?=
 =?us-ascii?Q?MN2cJIQNjrI9SORxkxRlRX7MWYRLHJlebTKgzxUdKYBvZP5ruuD4VmFylT0W?=
 =?us-ascii?Q?tDkuHST0TxaLbCfW0q3Rbrsdx3JLrlTmoY0fyOGw27CK9ihRSyMY6ag8eqGK?=
 =?us-ascii?Q?rXfwnZ7rCxs4IxkHUiAOEAu8ehU9g8ICfZ+tv3xItR91lOC0h04qYiE7bQIM?=
 =?us-ascii?Q?eLclw7xAdDVqp+5X7lSph5yOSI8IqKlmYlHSsbHTCDWITa5ueBlFbkCdfseo?=
 =?us-ascii?Q?RZWlGT5l5kQoqt1+bDw6B+JfwaHOO74OYnpNhkQuildBCyRmE9JTCRTr//WF?=
 =?us-ascii?Q?THPb7IKT3FM3iCUlOpeqZMNbyYfPPMJk2y/gR4XNXZJ+LEJcNYmxTZ6lYtsN?=
 =?us-ascii?Q?7kAWoGb1PIBcSfaLT1c26ls8CxREMJ2dcUujwHC9G3cFVEZ/ItRINajEAwCD?=
 =?us-ascii?Q?XlkdCnLS8y4KdupesPdCwaKTeQ1pitMOJGMpB9T9j0MfW9/Rw1FiV+kHJtFQ?=
 =?us-ascii?Q?8Hjt+/HS7eqD9UN8RqWIpposDZnQwxe07S1uY15j1Sj6/EQVuOnHnp01f3nx?=
 =?us-ascii?Q?bwjIGIWXC4xB0JYXpaFrLi/HdXBbsea90Fc3iUng5/nIjKObwjJ/HXGN4mGK?=
 =?us-ascii?Q?Emd0KO2XpmYH7BqoEwDGLJ3ZDJrUGB8FxgSBeRLHKrKREkUz1OT8u8Ys61Ms?=
 =?us-ascii?Q?gVUynGEIF6amR5EmuRYKLVPqYOI7sGuZiCr0WGDUWGRyr+ijY/O9L90GqsqY?=
 =?us-ascii?Q?Gl9ocwGDHwytrY/iPQ5m4UVRRiBQZSwEPuIxTh/dwhVEWsCzOFsp7USocKTo?=
 =?us-ascii?Q?CcDoJ7eC3HgKx0W0hPtruQd6wZ0HU0fJTajeWXSWnrFsCYVgSw7pA6/7seus?=
 =?us-ascii?Q?HcIBSiWdHRaEdBgCof0MwvcfM2hDup0erqcd?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 22:21:02.3965 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f901a49-1525-45ca-2043-08dd7d34f8e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6657
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

Track the state of the queue rather than simple active vs
not.  This is needed for other states (hung, preempted, etc.).
While we are at it, move the state tracking into the user
queue front end code.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 101 ++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h |   9 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    |   8 --
 3 files changed, 77 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 04583f9d134f1..8e703dc9dfbbc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -44,6 +44,45 @@ u32 amdgpu_userqueue_get_supported_ip_mask(struct amdgpu_device *adev)
 	return userq_ip_mask;
 }
 
+static int
+amdgpu_userqueue_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
+			      struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	const struct amdgpu_userq_funcs *userq_funcs =
+		adev->userq_funcs[queue->queue_type];
+	int r = 0;
+
+	if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
+		r = userq_funcs->unmap(uq_mgr, queue);
+		if (r)
+			queue->state = AMDGPU_USERQ_STATE_HUNG;
+		else
+			queue->state = AMDGPU_USERQ_STATE_UNMAPPED;
+	}
+	return r;
+}
+
+static int
+amdgpu_userqueue_map_helper(struct amdgpu_userq_mgr *uq_mgr,
+			    struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	const struct amdgpu_userq_funcs *userq_funcs =
+		adev->userq_funcs[queue->queue_type];
+	int r = 0;
+
+	if (queue->state == AMDGPU_USERQ_STATE_UNMAPPED) {
+		r = userq_funcs->map(uq_mgr, queue);
+		if (r) {
+			queue->state = AMDGPU_USERQ_STATE_HUNG;
+		} else {
+			queue->state = AMDGPU_USERQ_STATE_MAPPED;
+		}
+	}
+	return r;
+}
+
 static void
 amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
 			 struct amdgpu_usermode_queue *queue,
@@ -79,7 +118,7 @@ amdgpu_userqueue_active(struct amdgpu_userq_mgr *uq_mgr)
 	mutex_lock(&uq_mgr->userq_mutex);
 	/* Resume all the queues for this process */
 	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id)
-		ret += queue->queue_active;
+		ret += queue->state == AMDGPU_USERQ_STATE_MAPPED;
 
 	mutex_unlock(&uq_mgr->userq_mutex);
 	return ret;
@@ -254,9 +293,8 @@ amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
 	struct amdgpu_device *adev = uq_mgr->adev;
-	const struct amdgpu_userq_funcs *uq_funcs;
 	struct amdgpu_usermode_queue *queue;
-	int r;
+	int r = 0;
 
 	cancel_delayed_work(&uq_mgr->resume_work);
 	mutex_lock(&uq_mgr->userq_mutex);
@@ -267,8 +305,7 @@ amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
 		mutex_unlock(&uq_mgr->userq_mutex);
 		return -EINVAL;
 	}
-	uq_funcs = adev->userq_funcs[queue->queue_type];
-	r = uq_funcs->unmap(uq_mgr, queue);
+	r = amdgpu_userqueue_unmap_helper(uq_mgr, queue);
 	amdgpu_bo_unpin(queue->db_obj.obj);
 	amdgpu_bo_unref(&queue->db_obj.obj);
 	amdgpu_userqueue_cleanup(uq_mgr, queue, queue_id);
@@ -414,7 +451,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	else
 		skip_map_queue = false;
 	if (!skip_map_queue) {
-		r = uq_funcs->map(uq_mgr, queue);
+		r = amdgpu_userqueue_map_helper(uq_mgr, queue);
 		if (r) {
 			mutex_unlock(&adev->userq_mutex);
 			DRM_ERROR("Failed to map Queue\n");
@@ -489,19 +526,19 @@ static int
 amdgpu_userqueue_resume_all(struct amdgpu_userq_mgr *uq_mgr)
 {
 	struct amdgpu_device *adev = uq_mgr->adev;
-	const struct amdgpu_userq_funcs *userq_funcs;
 	struct amdgpu_usermode_queue *queue;
 	int queue_id;
-	int ret = 0;
+	int ret = 0, r;
 
 	/* Resume all the queues for this process */
 	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
-		userq_funcs = adev->userq_funcs[queue->queue_type];
-		ret |= userq_funcs->map(uq_mgr, queue);
+		r = amdgpu_userqueue_map_helper(uq_mgr, queue);
+		if (r)
+			ret = r;
 	}
 
 	if (ret)
-		DRM_ERROR("Failed to map all the queues\n");
+		dev_err(adev->dev, "Failed to map all the queues\n");
 	return ret;
 }
 
@@ -647,19 +684,19 @@ static int
 amdgpu_userqueue_suspend_all(struct amdgpu_userq_mgr *uq_mgr)
 {
 	struct amdgpu_device *adev = uq_mgr->adev;
-	const struct amdgpu_userq_funcs *userq_funcs;
 	struct amdgpu_usermode_queue *queue;
 	int queue_id;
-	int ret = 0;
+	int ret = 0, r;
 
 	/* Try to unmap all the queues in this process ctx */
 	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
-		userq_funcs = adev->userq_funcs[queue->queue_type];
-		ret += userq_funcs->unmap(uq_mgr, queue);
+		r = amdgpu_userqueue_unmap_helper(uq_mgr, queue);
+		if (r)
+			ret = r;
 	}
 
 	if (ret)
-		DRM_ERROR("Couldn't unmap all the queues\n");
+		dev_err(adev->dev, "Couldn't unmap all the queues\n");
 	return ret;
 }
 
@@ -759,11 +796,10 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 int amdgpu_userq_suspend(struct amdgpu_device *adev)
 {
 	u32 ip_mask = amdgpu_userqueue_get_supported_ip_mask(adev);
-	const struct amdgpu_userq_funcs *userq_funcs;
 	struct amdgpu_usermode_queue *queue;
 	struct amdgpu_userq_mgr *uqm, *tmp;
 	int queue_id;
-	int ret = 0;
+	int ret = 0, r;
 
 	if (!ip_mask)
 		return 0;
@@ -772,8 +808,9 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
 	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
 		cancel_delayed_work_sync(&uqm->resume_work);
 		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
-			userq_funcs = adev->userq_funcs[queue->queue_type];
-			ret |= userq_funcs->unmap(uqm, queue);
+			r = amdgpu_userqueue_unmap_helper(uqm, queue);
+			if (r)
+				ret = r;
 		}
 	}
 	mutex_unlock(&adev->userq_mutex);
@@ -783,11 +820,10 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
 int amdgpu_userq_resume(struct amdgpu_device *adev)
 {
 	u32 ip_mask = amdgpu_userqueue_get_supported_ip_mask(adev);
-	const struct amdgpu_userq_funcs *userq_funcs;
 	struct amdgpu_usermode_queue *queue;
 	struct amdgpu_userq_mgr *uqm, *tmp;
 	int queue_id;
-	int ret = 0;
+	int ret = 0, r;
 
 	if (!ip_mask)
 		return 0;
@@ -795,8 +831,9 @@ int amdgpu_userq_resume(struct amdgpu_device *adev)
 	mutex_lock(&adev->userq_mutex);
 	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
 		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
-			userq_funcs = adev->userq_funcs[queue->queue_type];
-			ret |= userq_funcs->map(uqm, queue);
+			r = amdgpu_userqueue_map_helper(uqm, queue);
+			if (r)
+				ret = r;
 		}
 	}
 	mutex_unlock(&adev->userq_mutex);
@@ -807,11 +844,10 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						  u32 idx)
 {
 	u32 ip_mask = amdgpu_userqueue_get_supported_ip_mask(adev);
-	const struct amdgpu_userq_funcs *userq_funcs;
 	struct amdgpu_usermode_queue *queue;
 	struct amdgpu_userq_mgr *uqm, *tmp;
 	int queue_id;
-	int ret = 0;
+	int ret = 0, r;
 
 	/* only need to stop gfx/compute */
 	if (!(ip_mask & ((1 << AMDGPU_HW_IP_GFX) | (1 << AMDGPU_HW_IP_COMPUTE))))
@@ -827,8 +863,9 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 			if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
 			     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
 			    (queue->xcp_id == idx)) {
-				userq_funcs = adev->userq_funcs[queue->queue_type];
-				ret |= userq_funcs->unmap(uqm, queue);
+				r = amdgpu_userqueue_unmap_helper(uqm, queue);
+				if (r)
+					ret = r;
 			}
 		}
 	}
@@ -840,11 +877,10 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						   u32 idx)
 {
 	u32 ip_mask = amdgpu_userqueue_get_supported_ip_mask(adev);
-	const struct amdgpu_userq_funcs *userq_funcs;
 	struct amdgpu_usermode_queue *queue;
 	struct amdgpu_userq_mgr *uqm, *tmp;
 	int queue_id;
-	int ret = 0;
+	int ret = 0, r;
 
 	/* only need to stop gfx/compute */
 	if (!(ip_mask & ((1 << AMDGPU_HW_IP_GFX) | (1 << AMDGPU_HW_IP_COMPUTE))))
@@ -859,8 +895,9 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 			if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
 			     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
 			    (queue->xcp_id == idx)) {
-				userq_funcs = adev->userq_funcs[queue->queue_type];
-				ret |= userq_funcs->map(uqm, queue);
+				r = amdgpu_userqueue_map_helper(uqm, queue);
+				if (r)
+					ret = r;
 			}
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
index b49f147eb69cb..8f392a0947a29 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
@@ -32,6 +32,13 @@
 #define uq_mgr_to_fpriv(u) container_of(u, struct amdgpu_fpriv, userq_mgr)
 #define work_to_uq_mgr(w, name) container_of(w, struct amdgpu_userq_mgr, name)
 
+enum amdgpu_userqueue_state {
+	AMDGPU_USERQ_STATE_UNMAPPED = 0,
+	AMDGPU_USERQ_STATE_MAPPED,
+	AMDGPU_USERQ_STATE_PREEMPTED,
+	AMDGPU_USERQ_STATE_HUNG,
+};
+
 struct amdgpu_mqd_prop;
 
 struct amdgpu_userq_obj {
@@ -42,7 +49,7 @@ struct amdgpu_userq_obj {
 
 struct amdgpu_usermode_queue {
 	int			queue_type;
-	uint8_t			queue_active;
+	enum amdgpu_userqueue_state state;
 	uint64_t		doorbell_handle;
 	uint64_t		doorbell_index;
 	uint64_t		flags;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index b3157df8ae107..4c01c3a030956 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -120,9 +120,6 @@ static int mes_userq_map(struct amdgpu_userq_mgr *uq_mgr,
 	struct mes_add_queue_input queue_input;
 	int r;
 
-	if (queue->queue_active)
-		return 0;
-
 	memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
 
 	queue_input.process_va_start = 0;
@@ -155,7 +152,6 @@ static int mes_userq_map(struct amdgpu_userq_mgr *uq_mgr,
 		return r;
 	}
 
-	queue->queue_active = true;
 	DRM_DEBUG_DRIVER("Queue (doorbell:%d) mapped successfully\n", userq_props->doorbell_index);
 	return 0;
 }
@@ -168,9 +164,6 @@ static int mes_userq_unmap(struct amdgpu_userq_mgr *uq_mgr,
 	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
 	int r;
 
-	if (!queue->queue_active)
-		return 0;
-
 	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
 	queue_input.doorbell_offset = queue->doorbell_index;
 	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
@@ -180,7 +173,6 @@ static int mes_userq_unmap(struct amdgpu_userq_mgr *uq_mgr,
 	amdgpu_mes_unlock(&adev->mes);
 	if (r)
 		DRM_ERROR("Failed to unmap queue in HW, err (%d)\n", r);
-	queue->queue_active = false;
 	return r;
 }
 
-- 
2.49.0

