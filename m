Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8FEBC5DF8C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 09:54:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 620C510F2C3;
	Fri, 21 Aug 2026 09:54:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g8Vxp43d";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010066.outbound.protection.outlook.com
 [40.93.198.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FF4810F2C8
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 09:54:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YyQvr6tg4G93kciU0MDbRLiGj9puhYVUsmf/QDo4o30xVPTU5nKJ5Kj46RmyvKG1Dsx0gfYADfBeh63I8/tGGWklCuPC//KwOLKAVk2YjebcbRVf5qZEPdpRxDOkkohxhB/Mg7bv5P4Da+sNbQMDRHoFwKJFb5q0QbwjVI4EvuVefIWDO77PbPJmtOSIMyy0PDH/6tTS6J+3HKHUCTpI3XK4KSjlg8qHElS2e/qI3uanU4pattGNnXyVCQFuig1Xp9VN1he7oCffdNsUy177Is10u3qjEttj2S57h3J75CJzYpSgqNOG0wUczg3FoY1GBSwXDXLtvhoPVacl4lkg6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOKNF01fwjTfMj3ttIoGohY4yoRzLRDoRWUpMk5E7G4=;
 b=tuObB9dZu4pCYYBve6aK3S+Sh1cUubyVCwOLQyPZ3v6xTaol5UDwsiKvNO/1M0CO/Pf9UBTjhwLxYH+X8v8Ha5tbnLPiEWV+Zd8TsC6plUpyFJfAeRdcwSDaeAlglUbHqusgJufpMrm9AnImSCEadAnWb/tYEN/OyxGHnHNHvvXGLqr4FY/5tcsCsXrkXeMTQeciGu25vbAYIwVXi3vFuF1NQyCQbW/NPOhslF5BBtB/HGSvKFE6tUEU+XIaLTHO+0X/I5LwGBTci13WVqrSWb96t5DsUHJhR07Zq4q+gIVynSPzcDauawphmF1ZzNYLE4ZOhqa+accFJlav1RR6/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOKNF01fwjTfMj3ttIoGohY4yoRzLRDoRWUpMk5E7G4=;
 b=g8Vxp43ddvblL0BeGoFXRZJCZkcL2UXZqVZmhoQwwwhH4frifqZlR8T+w5MxtV3GoJvqEWyELIllrK90iPfUrnPSTGCVwMerQLst8sR8XWuOSTokcJQYfkS80bXV7BQvyAyWx7ZKEpkphkp/pAVEdwHKR/pa4bfHvS9cgbrMXQU=
Received: from SJ0PR05CA0110.namprd05.prod.outlook.com (2603:10b6:a03:334::25)
 by IA0PPF7D094C5BF.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 09:54:45 +0000
Received: from SJ5PEPF000001F7.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::12) by SJ0PR05CA0110.outlook.office365.com
 (2603:10b6:a03:334::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3 via Frontend Transport; Fri, 21
 Aug 2026 09:54:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F7.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 09:54:44 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 04:54:43 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 04:54:43 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 04:54:42 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 10/10] drm/amdgpu/mes_userqueue: add SDMA MODIFY support
Date: Fri, 21 Aug 2026 17:52:19 +0800
Message-ID: <20260821095427.2361126-10-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260821095427.2361126-1-Jesse.Zhang@amd.com>
References: <20260821095427.2361126-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F7:EE_|IA0PPF7D094C5BF:EE_
X-MS-Office365-Filtering-Correlation-Id: 35a994d4-4902-4bea-f991-08deff6a3a4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|56012099006|11063799006|3023799007|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: LSd871Cv77K4f9J3LKy6EafdflfniHLAXwabSARHG1yentYdwKd1Nz0BFKlPSK/QcLF0I354KrzD+PGSkr93DW+y4OIUjvYTSHfV39QTibQx6Ic/b2Yf0jsxE5lMd90y3DvQ8xoFcC2ZzJfaKcypCnuTDF0KPUmLx97Yjl9W6VyevlBe5MDMOl/3SIo1SJB5GLypbnZl7FbxThK8Ni/wGuaW+j4JsCSGFAWyWboLd+mVM8WUXNlj/NInKUYygg3TmXiqQHKIAJ0YT2cpGMopF0ikz7kqABXfsnzN+BI7uZPoB1lWlE7rzQFiwOeh8ghjK56Jn8FtP4wsQWgI18qBblwWJLxlrN4FzJ0vAcZVUiGijG+LLTybA2yu1J5dFw43TfWlTuzIiT2EaH5pYXpiUzb22Edpe874hofkNouu1XqMX8+swmEZmiIel10pRIJigOGJyBhxF4Atck0hfZvToJCuXyzcY7u3EFu//JMk6SUaptZ5Md88BaN5RTQ6RPqr8WVRuLxf+ph+RJ0XL5sdXW/xe64N/xmqqI6i4vCsOml2twz1UicYCIssjrBxmH4yUSPpe4JpdKTWXkIvPv4nzDKl6yXs8d1KQaqGILJAX6jPP1MptXG4V0oLK4z0IXURPKOjVrvo6j/oJ110UFbykgiNrMFYgQHR6Da2cLFgaVxy49VMmU/UR8QgEJDQgw5V2bvr1FEXaN+seRtsH1rdbg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(56012099006)(11063799006)(3023799007)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: r74ytsLdw+zrHAIWRn15+sgzzds1EoaWMun7HItrLHhQz/BRT5jqeUsW0NjUQ45rmN+MZXZXWmoRYGwrQDBJQwYI/RXxxz0E6k0Vl6RruEWtZWwQtOgGfgFxa8Jc0H4cmnELhkMW4w0wgr3r06BidHRvUR6IoFmG8+ZRl/BkBanspIKPYN6toDHsufX0ouUauJfQlaHi+iZDdG17bNx75eRTbzu8JjHKQLAfm6R+UDo+MHg4x27hEI1frr6zVdWwdglJgUsjh6zH3Mmpofbqytj1r6yjmbxITtLFPpjLjqA7PYD4oAbici7IE9BmZ0k0IbBpYIg1i+mxtOgwVwFjXTPYQw5p2DARTvUMoMpkaqvSNRO0ebEN+h2ReH2Y+XAzlJ25Trg59p7BSWJu3wJRQObqVXgJ0o0uHcdHFKeoKEjnFKWrCMRozpcUvQyH828i
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 09:54:44.1810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a994d4-4902-4bea-f991-08deff6a3a4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF7D094C5BF
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

Add the SDMA case to the mqd_update dispatcher, routing it through the
per-IP update_mqd callback like compute and GFX. Add a queue_percentage
field to drm_amdgpu_userq_mqd_sdma_gfx11 and plumb it through create; 0
marks the queue inactive so it is not remapped, aligning KGD SDMA user
queues with KFD (which controls activeness the same way via
update_mqd_sdma).

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 54 ++++++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h              |  6 +++
 2 files changed, 60 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 3059224dd9ad..d9ddc0085d44 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -626,6 +626,13 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 			goto free_mqd;
 		}
 
+		if (mqd_sdma_v11->queue_percentage > AMDGPU_USERQ_MAX_QUEUE_PERCENTAGE) {
+			DRM_ERROR("Queue percentage must be between 0 to AMDGPU_USERQ_MAX_QUEUE_PERCENTAGE.\n");
+			r = -EINVAL;
+			kfree(mqd_sdma_v11);
+			goto free_mqd;
+		}
+
 		r = amdgpu_bo_reserve(queue->vm->root.bo, false);
 		if (r) {
 			kfree(mqd_sdma_v11);
@@ -641,6 +648,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 		}
 
 		userq_props->csa_addr = mqd_sdma_v11->csa_va;
+		userq_props->queue_percentage = mqd_sdma_v11->queue_percentage;
 		kfree(mqd_sdma_v11);
 	}
 
@@ -708,6 +716,50 @@ static u64 mes_userq_read_user_wptr(struct amdgpu_usermode_queue *queue)
 	return user_wptr;
 }
 
+static int mes_userq_sdma_mqd_update(struct amdgpu_usermode_queue *queue,
+				     struct drm_amdgpu_userq_in *args_in)
+{
+	int retval = 0;
+	struct amdgpu_device *adev = queue->userq_mgr->adev;
+	struct amdgpu_mqd_prop *userq_props = queue->userq_prop;
+	struct amdgpu_mqd *mqd_hw_default = &adev->mqds[queue->queue_type];
+	struct drm_amdgpu_userq_mqd_sdma_gfx11 *sdma_mqd_v11;
+
+	if (args_in->mqd_size != sizeof(*sdma_mqd_v11)) {
+		DRM_ERROR("Invalid SDMA IP MQD size\n");
+		return -EINVAL;
+	}
+
+	if (!mqd_hw_default->update_mqd) {
+		DRM_ERROR("SDMA MQD update not supported on this IP\n");
+		return -EOPNOTSUPP;
+	}
+
+	sdma_mqd_v11 = memdup_user(u64_to_user_ptr(args_in->mqd), args_in->mqd_size);
+	if (IS_ERR(sdma_mqd_v11)) {
+		DRM_ERROR("Failed to read user MQD\n");
+		return -ENOMEM;
+	}
+
+	if (sdma_mqd_v11->queue_percentage > AMDGPU_USERQ_MAX_QUEUE_PERCENTAGE) {
+		DRM_ERROR("Queue percentage must be between 0 to AMDGPU_USERQ_MAX_QUEUE_PERCENTAGE.\n");
+		kfree(sdma_mqd_v11);
+		return -EINVAL;
+	}
+
+	userq_props->csa_addr = sdma_mqd_v11->csa_va;
+	userq_props->queue_size = args_in->queue_size;
+	userq_props->hqd_base_gpu_addr = args_in->queue_va;
+	userq_props->queue_percentage = sdma_mqd_v11->queue_percentage;
+
+	retval = mqd_hw_default->update_mqd(adev, (void *)queue->mqd.cpu_ptr,
+					    userq_props,
+					    mes_userq_read_user_wptr(queue));
+
+	kfree(sdma_mqd_v11);
+	return retval;
+}
+
 static int mes_userq_gfx_mqd_update(struct amdgpu_usermode_queue *queue,
 				    struct drm_amdgpu_userq_in *args_in)
 {
@@ -804,6 +856,8 @@ static int mes_userq_mqd_update(struct amdgpu_usermode_queue *queue, struct drm_
 		return mes_userq_compute_mqd_update(queue, args_in);
 	case AMDGPU_HW_IP_GFX:
 		return mes_userq_gfx_mqd_update(queue, args_in);
+	case AMDGPU_HW_IP_DMA:
+		return mes_userq_sdma_mqd_update(queue, args_in);
 	default:
 		return -EINVAL;
 	}
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index da2016f42a2e..94497d1217b8 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -465,6 +465,12 @@ struct drm_amdgpu_userq_mqd_sdma_gfx11 {
 	 * to get the size.
 	 */
 	__u64   csa_va;
+	/**
+	 * @queue_percentage: Queue resource allocation percentage (0-100)
+	 * Defines the percentage of GPU resources allocated to this queue.
+	 * A value of 0 marks the queue inactive and it will not be mapped.
+	 */
+	__u32   queue_percentage;
 };
 
 /* GFX V11 Compute IP specific MQD parameters */
-- 
2.49.0

