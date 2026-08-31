Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED1BC61DD3
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 05:25:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93FD310E5E3;
	Mon, 31 Aug 2026 05:25:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FXTz+3DW";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013024.outbound.protection.outlook.com
 [40.93.196.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C04F410E5DB
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 05:25:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZDM0jI4MYLJ8IJRARihdsEclWY3UMG5zINkGteHQs9oIQ4YeWHwO78NJ6Tgs7iaE8CfGT9racSh+bD2PE955/cA6dN83+bdvmUDfj0VOf3bl8gDjwx0+0QCw2i2M6TTLysqzRys5xI47SConzipEKACkgGxnfJcaSzCkQKT3NKl3DUxOt4K1ppFqq6bC27ftO4ao3R23jZ5gQnnu0toCj+vyuJnPCqS+HuBRgb0Gf9XtZrdDwypOsCZ2JSPt06sw3Em3g6sN34eKsKhIf0GFwoCkEYrpWwYgxoR8xf2YZi+JTcFRgJyyu/casRJj5FsBQaZdLieku9RGh8iXKtq89Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEn9m7dCeDfJEuPoBXThfpHEIMLZlOUDQ+c92jSNEmY=;
 b=K2zRvNa2vFscXJGQ3sDTFObJNWcb5geng2lUfP9UAlaPvczc5XwKTkK2KkEptwqMIMFnm5dsruzy7KFtqDg8wOkw4XzvU3JtuijP7DvLRmDkg2N1rOryQr10oHISrk+OfiAyiBhBXaODPGpjp/5aI/BdVsq7C2ObU0W2NL2pRlN2bAAx7sMq3aJgNd7RGOEXPwx/AulRB8s3ozBe5OV4xBCs+PcD5w9EuSb3lCeMxCq43J2OIlU2wf0812zUw2AIu72zTEpSpW3DDWEL6+bDR92ekFX0JDGndYAUOOS7ANQNRAeHPpp/PZ810rUWvxoROlH99CBCORLrVTr2RTrJ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEn9m7dCeDfJEuPoBXThfpHEIMLZlOUDQ+c92jSNEmY=;
 b=FXTz+3DWseBmXy3t5f1AS7jNp/13ebqEnQP0rsXXugLo5rHRX9+Dy+laQwZpXzUqSxWHFvE2zVdVh7pHMQr396UEghmFjzvD2tRenckfvk527JFf72Fe9nifcP+qZ179acQBxFiJvVeLJu7NTAPgCW83DOqlTdHCI7ALPzs5oAI=
Received: from BN9PR03CA0573.namprd03.prod.outlook.com (2603:10b6:408:10d::8)
 by DS2PR12MB9616.namprd12.prod.outlook.com (2603:10b6:8:275::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 05:25:29 +0000
Received: from BN2PEPF0000A891.namprd04.prod.outlook.com
 (2603:10b6:408:10d:cafe::ae) by BN9PR03CA0573.outlook.office365.com
 (2603:10b6:408:10d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 05:25:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A891.mail.protection.outlook.com (10.167.248.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 05:25:29 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 00:25:28 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 00:25:27 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH V3 09/10] drm/amdgpu/mes_userqueue: add GFX MODIFY support
Date: Mon, 31 Aug 2026 13:24:21 +0800
Message-ID: <20260831052513.1518180-9-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260831052513.1518180-1-Jesse.Zhang@amd.com>
References: <20260831052513.1518180-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A891:EE_|DS2PR12MB9616:EE_
X-MS-Office365-Filtering-Correlation-Id: fc3ad14a-374e-41b1-264f-08df07204532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|56012099006|10067099003|11063799006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: f9tzAb4RpQqGRnGpgvczbNO/DcATbBlOZZpGg5iKhe+mY1A0+Ew4+TBjjfdbHOw5UjBxYeElqGj7VP1H2Uvn27yxyWXDujEZ5kwoF7hZkypcczlSZ0agk+BoHZBAjhqqe5oMVl72X4TRDOGmsZKKUFqJYsqHBPQrXV38mMbDcXvDbYZHaeWq2+2mwNckmBY5Yuj5/P5PuRAP1sUqb3WShOB0WsadpWL7CehqHypqWZTlqCbafrwVgl3GOuQzCwHWas6X8X+xT8pgwjdlMC02ZfyXiKs/hQ1/yi+OiGQxTwhArrXMbKqV8msH2adcIXUEFmgzqcmfZzOxnW405Fvf4xj0yRGSAmqeBduCK8fSB+uJSyb1ER7UhE/tJ8nHihnLZTHnk3JleMtb8zes8J9Ct0CSVGiP+lPBLtpLi4yMUBRkHzn0Ao/ic7oDR+r2h2Nhk420APf4eKTxyPlGRHMafQ6pNJ8V67A/mxYw5YZy1EK3bHXiQ+LMabbK3FPNYEen0pl/Zdks5pTkrS/A53diEz/TdtE71VvJ/Is+niVW3bYOZ7VOV7SMyJu9AXoYRknDwIUfv72yyJrW2SrrfmYVAZvtPtuSNekrxOJPKD8B5Tr3mDUcVmrRmHe/h8G4NWwhkfYfW60V4kV+rx/rULW5KXWOs7WAuyMcp55FgRzkvwZ7zTaTUAcBoLsLFB/vi3BeNsMzARCIh9dP5GMTdswMDA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(56012099006)(10067099003)(11063799006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eeE7QXMjFAj8/OmY/a6Oo8pzAQgoR9z6AK64c5e+oeGuqXJcFhd/8uxvc33rD8cLyUiP0fR++2kUNB3vJU2uWYetI9brRnJGzB5LtTRNpR1qsHALxsoJ+fY9vETv37nt1EKDYozFaNaXDW5B5dUFm13wqh7xfLmxObUjrELZD2XXdhmz1WtAkduuPKthl/SG7rGfgysZq0pkCUXp82T2sOzl9knpDrT5eN4WxEYW+aVaCB1N+FJl/FeR0SqmOyuaZhsS2NBtJdaKiMbHFCd2zhwWr0KS2ZGBoRNHONQzLbO4v7uEyVMrLIBzRrEpTdMvTlLHBniAVAG2BWvUoiItEjq5+rZajY7iJ8yM+wfM/ocBwidd3Od0sdFV+/C4M/ccM9y8ON/rsnBJ9HQex455cOAxhSGyXrEcbNCZ9PKRomgmplpxiRiw51lS2qgM3HXN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 05:25:29.0749 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc3ad14a-374e-41b1-264f-08df07204532
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A891.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9616
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

Add mes_userq_gfx_mqd_update() to update a GFX queue's MQD from a
drm_amdgpu_userq_mqd_gfx11 (shadow/csa address, queue size, ring base),
re-init it in place via prop->modify + prop->user_wptr, and wire it into
the queue_type dispatcher.

v3: re-init the MQD via the mqd_prop modify flag instead of a separate
    update_mqd callback, per review.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 51 ++++++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h              |  6 +++
 2 files changed, 57 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index c6ac3194e4da..99da719ecffb 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -574,8 +574,16 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 			goto free_mqd;
 		}
 
+		if (mqd_gfx_v11->queue_percentage > AMDGPU_USERQ_MAX_QUEUE_PERCENTAGE) {
+			DRM_ERROR("Queue percentage must be between 0 to AMDGPU_USERQ_MAX_QUEUE_PERCENTAGE.\n");
+			r = -EINVAL;
+			kfree(mqd_gfx_v11);
+			goto free_mqd;
+		}
+
 		userq_props->shadow_addr = mqd_gfx_v11->shadow_va;
 		userq_props->csa_addr = mqd_gfx_v11->csa_va;
+		userq_props->queue_percentage = mqd_gfx_v11->queue_percentage;
 		userq_props->tmz_queue =
 			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
 
@@ -696,6 +704,47 @@ static u64 mes_userq_read_user_wptr(struct amdgpu_usermode_queue *queue)
 	return user_wptr;
 }
 
+static int mes_userq_gfx_mqd_update(struct amdgpu_usermode_queue *queue,
+				    struct drm_amdgpu_userq_in *args_in)
+{
+	int retval = 0;
+	struct amdgpu_device *adev = queue->userq_mgr->adev;
+	struct amdgpu_mqd_prop *userq_props = queue->userq_prop;
+	struct amdgpu_mqd *mqd_hw_default = &adev->mqds[queue->queue_type];
+	struct drm_amdgpu_userq_mqd_gfx11 *gfx_mqd_v11;
+
+	if (args_in->mqd_size != sizeof(*gfx_mqd_v11)) {
+		DRM_ERROR("Invalid GFX IP MQD size\n");
+		return -EINVAL;
+	}
+
+	gfx_mqd_v11 = memdup_user(u64_to_user_ptr(args_in->mqd), args_in->mqd_size);
+	if (IS_ERR(gfx_mqd_v11)) {
+		DRM_ERROR("Failed to read user MQD\n");
+		return -ENOMEM;
+	}
+
+	if (gfx_mqd_v11->queue_percentage > AMDGPU_USERQ_MAX_QUEUE_PERCENTAGE) {
+		DRM_ERROR("Queue percentage must be between 0 to AMDGPU_USERQ_MAX_QUEUE_PERCENTAGE.\n");
+		kfree(gfx_mqd_v11);
+		return -EINVAL;
+	}
+
+	userq_props->shadow_addr = gfx_mqd_v11->shadow_va;
+	userq_props->csa_addr = gfx_mqd_v11->csa_va;
+	userq_props->queue_size = args_in->queue_size;
+	userq_props->hqd_base_gpu_addr = args_in->queue_va;
+	userq_props->queue_percentage = gfx_mqd_v11->queue_percentage;
+	userq_props->modify = true;
+	userq_props->user_wptr = mes_userq_read_user_wptr(queue);
+
+	retval = mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr,
+					 userq_props);
+
+	kfree(gfx_mqd_v11);
+	return retval;
+}
+
 static int mes_userq_compute_mqd_update(struct amdgpu_usermode_queue *queue,
 					struct drm_amdgpu_userq_in *args_in)
 {
@@ -741,6 +790,8 @@ static int mes_userq_mqd_update(struct amdgpu_usermode_queue *queue, struct drm_
 	switch (queue->queue_type) {
 	case AMDGPU_HW_IP_COMPUTE:
 		return mes_userq_compute_mqd_update(queue, args_in);
+	case AMDGPU_HW_IP_GFX:
+		return mes_userq_gfx_mqd_update(queue, args_in);
 	default:
 		return -EINVAL;
 	}
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 2de47ff7c4d0..da2016f42a2e 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -449,6 +449,12 @@ struct drm_amdgpu_userq_mqd_gfx11 {
 	 * Use AMDGPU_INFO_IOCTL to find the exact size of the object.
 	 */
 	__u64   csa_va;
+	/**
+	 * @queue_percentage: Queue resource allocation percentage (0-100)
+	 * Defines the percentage of GPU resources allocated to this queue.
+	 * A value of 0 marks the queue inactive and it will not be mapped.
+	 */
+	__u32   queue_percentage;
 };
 
 /* GFX V11 SDMA IP specific MQD parameters */
-- 
2.49.0

