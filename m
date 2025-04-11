Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC5FC369AE
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 14:12:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 829F410EBD5;
	Fri, 11 Apr 2025 14:12:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OC8HO1/5";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BBD310EBD4
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 14:12:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHKpS+15WpG4GKK8rA9sue06OGb+ZCMiGpAFgm8wuMHTcmsckE1U/AWnScNxmJj0EiecLhw8aijy5FbxAfMxHtRO2rilgnUJDLdPkOcvqkK3nhcRD4WnvL2gywDFZsOyBrbzAqv2uApjTPoHpo6xdjnAeOP7Wn8z9p/NOqpHZxQSRXBjpj578EPRstxawz8nwf2axH1Zte1PzhtXkJGNWN9S+FhSD1uP2ex5iAYBVl+/R1FvoFrHIjza5u43Pjx5N6MYGBZRyBosLOY1U9MMjyT2PlUVJ3WZeSgrRIh1PTGPAU35KevZ1LqBXFEpJ42md2CbvP9yvK9ZPi617P1b1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgCwZX/Wf8MGoVCGAJOJEuYyw/5OKKHazzVaZ20FDyI=;
 b=hKO2hHTPFEwwfQb7L+CnUk9vxyxVGcylmkaF2KPVHX7SCAiJrtL2zXnvLajw4wFhDflsmm0zgVMDJpb14ymyN8EUtnSRsRIJ9sWxea2ku7kflxrfirup/gEw1Xw0p3h3TvuQqRYoyX9ugUjWfq9Iykz8ccqfdEHMezvVbYl8ukGihQBgh8yUIgbsP0cv5JJufjBBIVDPg+jAFlfb41zGbm9rHLeLCnrMubHX3puIIsHkPhYg0blzd6tQI9cpoD+B4a3bWcOpA1S9zsIaXaWMQtUoaRhCC9T7T9Q9r54qeo37tQ0FMFSIS7AFsDSFS54as2J5t6mkxPv99d5cwCKtGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgCwZX/Wf8MGoVCGAJOJEuYyw/5OKKHazzVaZ20FDyI=;
 b=OC8HO1/5tTTfkNtkQKPxvvRKnESxXRD90RffuPuSWZd2uNeWlI/3gSCT8rXRsvGdumBG3pGHp2U8KsK9xeMVobGKJ9rupQ7IGc7TTvUElhIMXboFJsZ9Zv8+dyYO1u8YyFhKCKi4LW4khyMo+N1C4sRuEs//MU7FDpfRKOFL5ZM=
Received: from BN9PR03CA0643.namprd03.prod.outlook.com (2603:10b6:408:13b::18)
 by MN0PR12MB5929.namprd12.prod.outlook.com (2603:10b6:208:37c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 14:12:44 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:408:13b:cafe::44) by BN9PR03CA0643.outlook.office365.com
 (2603:10b6:408:13b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 14:12:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 14:12:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 09:12:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5/9] drm/amdgpu/userq: add suspend and resume helpers
Date: Fri, 11 Apr 2025 10:12:24 -0400
Message-ID: <20250411141228.2722962-5-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|MN0PR12MB5929:EE_
X-MS-Office365-Filtering-Correlation-Id: c4f53ac9-f2af-4f29-6517-08dd7902edee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B127hlvl0OVFOXaCuQWtUIh9IYy6hJVW96IudY8SbM8iOjJhK8s5/C7eVJfD?=
 =?us-ascii?Q?tDGPFRjlvbf91nHiX4eOtXdBJh0GIbWbTLK2NiVoGm8Q3zp1Iw+uxZsnuR55?=
 =?us-ascii?Q?pRn1ZeBJY+93nARnxAnl8pmDiik3a/IvFAo+hyUwDgr52OLZALcwhZ200Q6T?=
 =?us-ascii?Q?O/T/TpZakQeK/1UxW5unSY/K0FLDmhqGIkCe4DkIZv6Wz2mcGnC7b/HR/gmE?=
 =?us-ascii?Q?dAh1s78IuvMOfnYVN2da7VU86+SXk7U24elkUzN+hn8QKlhEssR+kUPva9zR?=
 =?us-ascii?Q?XqMpPJrGCl9JidH/xoRr7B7ZFU84ulfBSso13ZSOEf+AkBwk6ftAzEZnWZB9?=
 =?us-ascii?Q?oN732VOC3mx7pWJTzF2oKay8Wy2aAWCcCpfAoUw07/Gc91oqena46PxcR0J9?=
 =?us-ascii?Q?AYrJhls0cd72hri1gEiGs4PfwaeZIC8AONeR9SJMJHUVOJTPNIhoINNq9R0S?=
 =?us-ascii?Q?bTWOEtov2Jg1CFbC9y6Wm8RDeu6huTZ+bI7yrAjXJNhOEL47NVuauzC1ABgH?=
 =?us-ascii?Q?3rmXdjiSG+gla7YvGzINSLNcNap449+kbNOZFRUw2gfTniIR79xc0ZKWzonH?=
 =?us-ascii?Q?6I8HNrLt+LtiCp+8H+7Ex51uR1Fkl9KTlwm0YMvES4/zlhyqxtnlWewB67WP?=
 =?us-ascii?Q?4rT23nRRa9ko6Ohyk8RnX3shYFysxra/S8HgHoB5JIWfhrx5cLtXG9OpHKxH?=
 =?us-ascii?Q?tTXBEYRKacHCH7RARXEYpLiMdgRSZFiGIAXbuIMDrfRGGZ9vpxQXyulRK0FO?=
 =?us-ascii?Q?cKM2yO/B9OG6sSfmZDPyDj2xX0uFaDmniwruaHPNIebwuvM8qKPNGtUwRPyJ?=
 =?us-ascii?Q?vjJxboqZtkEX0lrg/LkSVNTt9vnYPJkIEtA4dKs4WXufGpdzPcOc2uVbnuet?=
 =?us-ascii?Q?pBa2lG7YhoQxjLMkStVPn93FG9zQkJcoKLs7GrslSGuP4aHxyYtnK4Qebaiq?=
 =?us-ascii?Q?3MOKNh2X+uLTXu0RsutP3qrJcbBlLe+LhnGleUoNjaCfyvbE4a2arvimg3ur?=
 =?us-ascii?Q?SViFfwkEaSM2PY0CZWQXez6hEBPUsdujDuktcM2FjBLXsYXIitWg+yX5eEvL?=
 =?us-ascii?Q?htllH1x1xc8J1KHA+0aDqYoilVpNTOL1I7hpXoo+bxfP5KmbMa6tKjIoAgz5?=
 =?us-ascii?Q?8cpmxrjzaPnmnoaCBOpRbaYHE3vawguhPUzWYoy7XVGsyDo3hF/yeeQqaGSD?=
 =?us-ascii?Q?7yNxKNtDUXZI5VNxacQRl3pnGaSWeeY3j6XVQe03HmfySkmUqlp1xzZ2FXb7?=
 =?us-ascii?Q?kRBJLpX1ONL+T+wAYhdLR3URV8Ktk0BCJa6kQTZ6ExoSEmRDLZBYZ1UL7SDO?=
 =?us-ascii?Q?RIO+BsnwDnFXI5gTHli2VNZ2q88CcYQfhGk4aTtNDAX2T0jcV17BQhOtNjRu?=
 =?us-ascii?Q?ToPdozsASDdqDgLHlX2vj1nKlCv02+3Sl/3/pS8TeppwAHq0Hw1qknJSHHX8?=
 =?us-ascii?Q?XzjE8qEPBC6OcQj0GzkP601AtV5CDCsBsAytW1gV4d6aT6VYiRtxQMI/7HsU?=
 =?us-ascii?Q?3jIJ0c1x9Ege0OBq2MTcsyEaaV2H/F6Ld4i2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 14:12:44.4885 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f53ac9-f2af-4f29-6517-08dd7902edee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5929
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

Add helpers to unmap and map user queues on suspend and
resume.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 39 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h |  3 ++
 2 files changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 41a095c12f956..f5c2489baae43 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -681,3 +681,42 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 	mutex_unlock(&userq_mgr->userq_mutex);
 	mutex_destroy(&userq_mgr->userq_mutex);
 }
+
+int amdgpu_userq_suspend(struct amdgpu_device *adev)
+{
+	const struct amdgpu_userq_funcs *userq_funcs;
+	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_userq_mgr *uqm, *tmp;
+	int queue_id;
+	int ret = 0;
+
+	mutex_lock(&adev->userq_mutex);
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
+int amdgpu_userq_resume(struct amdgpu_device *adev)
+{
+	const struct amdgpu_userq_funcs *userq_funcs;
+	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_userq_mgr *uqm, *tmp;
+	int queue_id;
+	int ret = 0;
+
+	mutex_lock(&adev->userq_mutex);
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
index a0cf6978f2ba8..381b9c6f0573d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
@@ -111,4 +111,7 @@ uint64_t amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
 					     struct amdgpu_db_info *db_info,
 					     struct drm_file *filp);
 
+int amdgpu_userq_suspend(struct amdgpu_device *adev);
+int amdgpu_userq_resume(struct amdgpu_device *adev);
+
 #endif
-- 
2.49.0

