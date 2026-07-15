Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE75BC4450B
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 14:28:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26F4E10F0E7;
	Wed, 15 Jul 2026 14:28:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nHbtbp/Y";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012023.outbound.protection.outlook.com
 [40.107.200.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DE3F10F0E7
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 14:28:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g9pqNv76y49kE6pTDcSbx4ZWdDlCf/9cybVj3jAsDCTZedKh6h9vvtUmJZi27YOAM/JLn/gNOw2faHkejT78ao20tf12YxE86BY3oT6SnPFxmzpXNckbktLOTO9SS31KL51FkXvYSe3fmbdTR/uJjIKk/XiPB8D7TZqq5wA660LhEjN7sBjYrhwVBHiIYL9NLuwxnj7brndmH0NCfWOVwMitAUou/iCbb6oynMzz/h9sxx7yw90cQkmBp7E56yZ6ziwsGMUo8uQMZHqNB267KM0OTuYheV/D3j/9IV/jnyOElt3ZEDpjxZpV0kIkOmQzdOud3U8H47lEq17CcLPdaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbJWK6hqbXIWDn+CI+b1HtO1OgUcrbc8HMOpsOFqvuY=;
 b=Zj0wXP5Nqhscqvf9Gx1DyYjg+ALtpxpFzKmXGDKM/5ehNXLSO/sG6OSI9P5sbG9lKShOk81LsvDW7Ww9XMu+dkBd5xEo9BG6SSjciH2R/ZXwidikZX0aODFZbyfYux4AEVIg5CiqnKtUpSq/X7uld4W5QkRxONuUG11ZlR3/pDge5xNvyFVcw85Y0hTHImlzsNmr0CESqoqYkRgaYfMqvGfXh7GvBk1OxsYMLPHnPgNlptWdxqCroe6aZwKUsJtPhxQlP6LE/CzknIwJtxrYqBkOtXK1mwv1N3WcV+0FjN70R5+XHBBsoWvHR+UlBj85EAH9Nvl2x6oG4UxofxXjuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbJWK6hqbXIWDn+CI+b1HtO1OgUcrbc8HMOpsOFqvuY=;
 b=nHbtbp/Y4DtulXLJSQ+bGDnVv4//95V+YJ2xv6oSipgnayA9LSKn9ePJGb9hkDqqpKoD2555bnxl5y8unLTCdTfDeUFzoL7x9ERNXGFmzxgTJ1OuECDRZuu7R/xnaItbQIcczxAUna4DAT+jqqzhhHe1HnPWTCERpmDY7mmhdvo=
Received: from SJ0PR03CA0334.namprd03.prod.outlook.com (2603:10b6:a03:39c::9)
 by SN7PR12MB7132.namprd12.prod.outlook.com (2603:10b6:806:2a4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 14:28:44 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::ae) by SJ0PR03CA0334.outlook.office365.com
 (2603:10b6:a03:39c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 14:28:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 14:28:43 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 15 Jul 2026 09:28:40 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Prike Liang <Prike.Liang@amd.com>, "Sunil
 Khatri" <sunil.khatri@amd.com>, Lazar Lijo <lijo.lazar@amd.com>
Subject: [PATCH v5 2/4] drm/amdgpu: properly account for resets with user
 queues
Date: Wed, 15 Jul 2026 19:58:22 +0530
Message-ID: <20260715142824.3475418-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260715142824.3475418-1-srinivasan.shanmugam@amd.com>
References: <20260715142824.3475418-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|SN7PR12MB7132:EE_
X-MS-Office365-Filtering-Correlation-Id: b3a1dc6a-d765-4d49-f275-08dee27d5fc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: cHHf5fnuARtUkGMcAz+LikDaC9/xVLWkdHMKl4DmgUhs/c57BlqH6p3FMgPkTj2+owDj++ZLxHufY8HCw8T036uNGJjpk5gYHyl8nqujsDuul6BDDkPZBuqT0AC4D0tkYZ8dTfHoSbQUUV41LB48gHjmbh5yMRYNC0kh2UbXUBU+fnr5ex86Kjql50bE26oxM6k8sP8xrYY0XxgApgmbmZJCpmTq+bMLjqC/lbZzWTPPyGqff10wpGAXg8yXCcW43YO/YUlg/qgF9mbbobEgSQ+as5J9/7mOyJFtRsXpuz5/winVmLc2zbjTvEStHvpGCqM+lOF89qkzcZT5O3vyWMdrjydI/5nzCnnc8BJmiW7rwlZ8cqL7YQDxT6Um4H8eW8x8DyEUxeCbA7ZVJ+R6UyNy54EAj/oZHPIRLWlSRrtCHSzeE7keeeyhyK4MkGSCdkQcKBsHqm6E22svnzeeASqYoYTsm1Xh2sO/onnqWH0+tfRTEt0G2/cBpOVH+k1I7iVoTrhKaJ87QfLtwcKz5mEYxfJSAP5xA3bRHnNWJIS+wXFO3x6x/ZrqhjQcBL8hXU52NoBnQ3Imt4lgws6/g92mi/BRQRaaNojFjh6FqCPoiAw/b516rrZcrnNe1a34WF/1SPqBRTmh5CoCMGP7SICXyIM+37YTjkeWmdBX7ICU+blZQmN+pYSVSB2LBam8RgrLbE68BjibPveLeBXgXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: N0+edDRy8Nyt1IueJlO6gWNXl/1/Cins/t+W6LUEwTShxF0pB4hwvTV4RUWv/Q56Oe2K6uS8X4bbTEJbz5ox15DeNz6X+Lc2Pb9F0jgBR77+bFkUUhMU2fkLf1C97qapDjk2U3ztGQ0ZYUf1Eo4qjk4YYrh8f7cE4gtVbJ0i1DH75mY6skx1rkodlth6iHRaa2aoZGYiCsw++yDfFNa/pNusPHYq0e0+VsliMigXVbfuOumjHZHt027sjOY7qGxwiQQw7XBRorVeaRLEL1jHkoRSaz343FDVZNHrTSN3PPcRiXawmNsMcMw3eIdHIQ+S6Kg2YhSL/a3+VZUc7uBS7U0PdBMOCmsC1Tz7MAg9DvCzLVl5XoB3q184CsrhyBv8pQzS7oc3lrrp1Pj9vDaPOgt52Z0zdLnonJIBVPyW7cno1nhcyefZX09B3xz3Wfno
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 14:28:43.7785 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a1dc6a-d765-4d49-f275-08dee27d5fc9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7132
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

From: Alex Deucher <alexander.deucher@amd.com>

We need to increment the reset counter, force fence completion,
and set the wedged event when a user queue is reset, but only
for the guilty queue.  We don't want additional events for
collateral damage.

Only increment the reset counter and set the wedged event
in the top level userq reset callers (both KGD and KFD).
This aligns with how this is managed for kernel queue resets.

v2: fix task info refcount handling, align with
    kfd error reporting.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: Prike Liang <Prike.Liang@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
Cc: Lazar Lijo <lijo.lazar@amd.com>
Reviewed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c      | 18 +++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c     |  2 --
 .../drm/amd/amdkfd/kfd_device_queue_manager.c  | 17 ++++++++++++++++-
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index ab3ef3a9f655..20bc15ad55f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -144,6 +144,8 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *userq_funcs =
 		adev->userq_funcs[queue->queue_type];
+	struct drm_wedge_task_info *info = NULL;
+	struct amdgpu_task_info *ti = NULL;
 	bool gpu_reset = false;
 
 	if (unlikely(adev->debug_disable_gpu_ring_reset)) {
@@ -158,6 +160,14 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
 	if (!amdgpu_gpu_recovery)
 		return;
 
+	if (queue->vm && queue->vm->pasid) {
+		ti = amdgpu_vm_get_task_info_pasid(adev, queue->vm->pasid);
+		if (ti) {
+			amdgpu_vm_print_task_info(adev, ti);
+			info = &ti->task;
+		}
+	}
+
 	if (amdgpu_userq_is_reset_type_supported(adev, queue->queue_type,
 						 AMDGPU_RESET_TYPE_PER_QUEUE)) {
 		int r;
@@ -167,11 +177,17 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
 							 queue, NULL, NULL);
 		else
 			r = userq_funcs->reset(queue);
-		if (r)
+		if (r) {
 			gpu_reset = true;
+		} else {
+			atomic_inc(&adev->gpu_reset_counter);
+			amdgpu_userq_fence_driver_force_completion(queue);
+			drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, info);
+		}
 	} else {
 		gpu_reset = true;
 	}
+	amdgpu_vm_put_task_info(ti);
 
 	/*
 	 * Don't schedule the work here! Scheduling or queue work from one reset
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 3fad95199e0c..3d27d2aa2cd0 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -258,9 +258,7 @@ int mes_userq_reset_queue(struct amdgpu_device *adev,
 				r = mes_userq_unmap(uq);
 				if (r)
 					return r;
-				atomic_inc(&adev->gpu_reset_counter);
 				amdgpu_userq_fence_driver_force_completion(uq);
-				drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, NULL);
 				break;
 			}
 		}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index f6a749fbdd8e..ebab66e1a6c1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -448,6 +448,9 @@ int kfd_reset_queue_mes(struct device_queue_manager *dqm, int queue_type,
 static int reset_queues_mes(struct device_queue_manager *dqm, struct queue *q)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
+	struct drm_wedge_task_info *info = NULL;
+	struct amdgpu_task_info *ti = NULL;
+	struct kfd_process_device *pdd;
 	unsigned int num_hung = 0;
 	int r = 0;
 	struct mes_remove_queue_input queue_input;
@@ -476,13 +479,25 @@ static int reset_queues_mes(struct device_queue_manager *dqm, struct queue *q)
 	r = amdgpu_gfx_reset_mes_compute(adev, NULL, NULL, NULL, &num_hung, &queue_input);
 	if (r)
 		goto fail;
+	pdd = kfd_get_process_device_data(q->device, q->process);
+	if (pdd) {
+		ti = amdgpu_vm_get_task_info_pasid(adev, pdd->pasid);
+		if (ti) {
+			amdgpu_vm_print_task_info(adev, ti);
+			info = &ti->task;
+		}
+	}
 
 	dqm->detect_hang_count = num_hung;
 	/* When MES doesn't detect any queue hang, no reset happens. Don't signal reset
 	 * event.
 	 */
-	if (dqm->detect_hang_count)
+	if (dqm->detect_hang_count) {
 		kfd_signal_reset_event(dqm->dev);
+		atomic_inc(&adev->gpu_reset_counter);
+		drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, info);
+	}
+	amdgpu_vm_put_task_info(ti);
 
 fail:
 	dqm->detect_hang_count = 0;
-- 
2.34.1

