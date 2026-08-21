Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE87C5DF87
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 09:54:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 710F110F2C7;
	Fri, 21 Aug 2026 09:54:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lhu3Ubl7";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012004.outbound.protection.outlook.com [52.101.53.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F26F10F2C7
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 09:54:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSNlU0vBhC9pHgZEvot2GFS3x+ej1XkTb87PSakklI/mUGP9Ah2kSpq+hgfExFq5el+dE5+jhADBRZ82DIAf87tMuYS+VEFt9h5OA6s2JIhdbKY3cGFjnAjdUQEiqO5U6es7KVbl9voa82tizgRWVYZCjqPG0n69mZDF1XhUf009HhVi/XKtt8enEemHVC7DqJ9NSdfAm+uSkgghqRkDeB7ulT3MKmHmfeX/1HTbiCqoPoJQIa9YPb8k8AQzOhw8UvkWWJRVRWHUOXU/VZ511NFZ4P1hx/15k9c6PPY5vcSQkUOVkIIsMHvzGkOyVal6UdeQqjPIiz9/HpmdjTW0Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbtFXNoQXj9MXV5hLrdbsSWVbZxDESV4LevFqt3Hghc=;
 b=Z4xr1fXN2vzxgekyP/7Hevixy8TuO7ScYmB1YaQz/UG2m85qwZ61ZiTfTO8ZfmpXl1hw56atyl6rF4FA1LPboRmjhcT+ubWgoCUIzw2S8JlOCQZCtPcOwlrrpv5z2xsf8s/Wk+ncx0E6YPrtqJWmxV9mgqxJYwQXQEYwUA3JtP7faP4Gj5V95y5XTAbFvNgId/mRFQ3YjkRK5wZwGII5aS/Fd6+/kmCUeDLFe1JQlWaQVvkBE59P0IfN1W3LkiF0ojQAzyhkgzx+o1qoD7aLFyC8Mb3hwbzg5dMHsypTVVCaXYwRzZvO41MZ/baPkCjA98w88bi++pYvKwv+DTp04g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbtFXNoQXj9MXV5hLrdbsSWVbZxDESV4LevFqt3Hghc=;
 b=lhu3Ubl7y2SiUWFhPk0iPpKsMU76tIK3b36zUH80dhxzBiMNadWUnVoF4C0Oq57XHpJxW9nJs3ne7yIWyZiGxAMvJHNaoKxBcNf+zVYDb6qYZ1uqluLdNjbs1VD6XTONGPilH8uYXOibDRH+Y1Z3Om3fe7k00/4EuOYDcSN/Imw=
Received: from CH0PR03CA0404.namprd03.prod.outlook.com (2603:10b6:610:11b::33)
 by SA1PR12MB9469.namprd12.prod.outlook.com (2603:10b6:806:45a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 09:54:42 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::67) by CH0PR03CA0404.outlook.office365.com
 (2603:10b6:610:11b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 09:54:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 09:54:42 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 04:54:41 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 04:54:41 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 04:54:40 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 09/10] drm/amdgpu/mes_userqueue: add GFX MODIFY support
Date: Fri, 21 Aug 2026 17:52:18 +0800
Message-ID: <20260821095427.2361126-9-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260821095427.2361126-1-Jesse.Zhang@amd.com>
References: <20260821095427.2361126-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|SA1PR12MB9469:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a22a818-d76e-43f7-1875-08deff6a3928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|18002099003|22082099003|11063799006|56012099006|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info: Zyp9ajl3ukaoxslj+wrf1r/ADXaWwcZTZHu5XTbulCHxDQrOFhCR+6FR+/Sly+Hi3PWEHUBQyooH8DDe53HSey1kJVjmINgGYwchno8gPaIFjtcMs0KS7Lt5p1tHHVr0KmRbQMEH+sMnbgjKs8qmSSONfFxYUnb4bkljahgOfvToLoH2LhKzjBi/pNjV0js0pkrO0Hp0+Czo/clKz7K4AEMumOHSzwaDqs0H1+bhRBLG9OKKr7Z/fNeZqAuo+JP3+0ROyCdQ5zWpGswkRiChOLehP+L8zDbY7XYWnrtUv/X7WQXcK/jyVPLKBUmFsYbbjYQhgyD26+Iaq5E/MslvtwN/6oXQffO9CJdWs2sc5RyV/oHCTTr7dZERNH+Qw5cy/UAz7LzsBRhMaqTe/0UmOCLWaz/id0aKYdotLSZ2HGU6783uETL9sFhls3YzsrqfkymBaJxIy9VoSYZalrxGFkRoHOikqDsLgub4FdcmV3wuL9gboDF8j9OR8WsNo0tG0rzjEMsdG3wdApS/fk0nGPlRt4t644wXZKAa1+jcAm3IYmOJZijgj0jE0OHw5tfqheegRBaBKMHJFjS+n6Vly2oPGkDFFEWub49GXAln1HnS7Ggc3hKNnHsSVa07cAnVCkmSCLRpnrodrAGFxXFN5Yc8l4NCZ3Atp6YwPjHLCcR3aKlZ2PrvmWxl/jAzDG6bKw9zAEdhyeNq0IoSWnH2lg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(22082099003)(11063799006)(56012099006)(3023799007)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iMC2BjFFC1G6jbWtFaShb5ZTxOZHvhoxLXvqD+LX7YbWpuZjGOfzVTCpV4mNqi953yoe4xUeYXGpspGa2FHENx1t1tnHAMhM6aUgDVRFy+QWhaw50y1HMqsDgWj0F30nTHUW3GYxEbcCiT2HyXSZf6e430JMMfHlObN67pJOa1bZais8m56AG6nDftPzBQy8ybf9AEbKunGwg54PeAEixuyQj2f/FG4T0KQDvxt+Ox4C10jm3QtwxSo4GmFyZ//tMZxU3qHuSu5V/mUfyGEVOuMsEsrLZFW7d5cim2ia9TOyvrjiXNK+z1L9bpLbb+7ncuU7RTbFaYhxmmT4a+XII4Nk1ZQKveZw5cLdKtxdkq3c9dLe2fX927aXhNxowC2NiWA1OXsWlb8zmyDsTMSpvzhMVu6yomEMTQ97w3d9Ynu/RMhFuJEyogLOgzfBANHj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 09:54:42.3180 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a22a818-d76e-43f7-1875-08deff6a3928
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9469
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

Add the GFX case to the mqd_update dispatcher, routing it through the
per-IP update_mqd callback like compute. Add a queue_percentage field to
drm_amdgpu_userq_mqd_gfx11 and plumb it through create; 0 marks the queue
inactive so it is not remapped, aligning KGD GFX user queues with KFD.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 55 ++++++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h              |  6 +++
 2 files changed, 61 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index f2742fa28dc6..3059224dd9ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -573,8 +573,16 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
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
 
@@ -700,6 +708,51 @@ static u64 mes_userq_read_user_wptr(struct amdgpu_usermode_queue *queue)
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
+	if (!mqd_hw_default->update_mqd) {
+		DRM_ERROR("GFX MQD update not supported on this IP\n");
+		return -EOPNOTSUPP;
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
+
+	retval = mqd_hw_default->update_mqd(adev, (void *)queue->mqd.cpu_ptr,
+					    userq_props,
+					    mes_userq_read_user_wptr(queue));
+
+	kfree(gfx_mqd_v11);
+	return retval;
+}
+
 static int mes_userq_compute_mqd_update(struct amdgpu_usermode_queue *queue,
 					struct drm_amdgpu_userq_in *args_in)
 {
@@ -749,6 +802,8 @@ static int mes_userq_mqd_update(struct amdgpu_usermode_queue *queue, struct drm_
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

