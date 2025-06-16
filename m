Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78ABAC71135
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 03:46:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1529C10E276;
	Mon, 16 Jun 2025 03:46:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mDHAsIHK";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B6C910E276
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 03:46:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/F3eTXrW5IQBQM+LZVrcDYPaCykqkFz1BJJ01EpOJRt6aKxII8apIMnvAMzwCzr3A4hCyhwAU/9Uo2O45dRbjkdIOlH6BRynYZDXvIqtgLYrKM+lPp/yYTvPioVjhwTZjlqmxGyIVZNLVTTnj0pfXDitlkTYSwoQ4mf7VXM+ghditzT/PvgYgG31oun4VHl2Ge0JLZPTJAONVmVp58CAFfFf5CMQre7caauXPgQCGYrE5NX84Tp8YREAetDk+ZIpLlp6Znen5zL0bL82ZUpXang0kueRBi0ljsMd4Ee8eLwlbuELihmBbaYCefeoHUSpf8sIc2hOfGyfwT1z/U+kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hU+SWeD2GnekAI2Ws+CLpODvWe/2m4QBylV2O5D/Mc=;
 b=nujBU2ZV9p3AgJ+cbILMYzxgFrVS0T/RVo4pTi1ulcH2fAnPF22C11CP35C06o8/jGK4R7DRdhF4YJeaHaFNVCh33eOrs6NaGmvV1zM9k1ijHuz9kX3gwjr6zdMYcM/XG/ZwZCtYmKY0DQW78r+h+8WMrf0CH8UFH71B9WXbyXxR3UTO7WIizRZrxe4i/UkqF83FsEK/y1vFRhzUImwZDeD08j5t1xMioXrqN9gMF1/Ck/sbAJ7uRwPNHqlLmANg52cPaB/NnMHLrQGBcv4IBfpdwG4x65c2dPbjEhWTccUToGv8eLQ83BU8412f7cCAKBdxVqL4KCi9ZWiv2GWoKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hU+SWeD2GnekAI2Ws+CLpODvWe/2m4QBylV2O5D/Mc=;
 b=mDHAsIHKLOyt0u1NWU2nWPA8lVnVcL9uzi6rkJmiMafWHryfqFckRMQsJnG1wEya3th1hJsu8I8iIelsk3xRawYB18WRN9BZlZQlB452mAD5c3Sz55OGaDGAtJfpJP3GSr1L+y1PZ/+i+MuOgEkuLRsLiUCj0qMRUDUOSMwj1MM=
Received: from BN1PR10CA0010.namprd10.prod.outlook.com (2603:10b6:408:e0::15)
 by SA5PPF6CDAEAF48.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8cf) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Mon, 16 Jun
 2025 03:46:51 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:408:e0:cafe::ab) by BN1PR10CA0010.outlook.office365.com
 (2603:10b6:408:e0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.34 via Frontend Transport; Mon,
 16 Jun 2025 03:46:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 03:46:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 15 Jun
 2025 22:46:49 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Sun, 15 Jun 2025 22:46:43 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v2 8/9] drm/amdgpu/userq: add a detect and reset callback
Date: Mon, 16 Jun 2025 11:43:41 +0800
Message-ID: <20250616034605.2683434-8-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616034605.2683434-1-Jesse.Zhang@amd.com>
References: <20250616034605.2683434-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|SA5PPF6CDAEAF48:EE_
X-MS-Office365-Filtering-Correlation-Id: b0530c59-b085-4a58-beec-08ddac886d23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rIUTaFGo9QzVz+xS5pCwaTI+6DTKE64DbXbYfwha/E7sO56pGSExRm5e2FuU?=
 =?us-ascii?Q?QKFDKZ9loGG8vNH2u9jx0AgVpBIjL075+QMbAZcjTeWOTNU8ZCYEJNw3hpJk?=
 =?us-ascii?Q?likmQa30t+ZjK0AmCjQ8XocpELc6y1nMb43hIRzbnnIPm8c5D2hzO5J7yTca?=
 =?us-ascii?Q?8A6uKpWyIphwhJwnr5fqXBpfjK86PlAFMaPWRsN23kHJy1GHcBmYDplO4CXw?=
 =?us-ascii?Q?ppUcgaaoWIMZQG5vIjlyx2mmNpShsbVK3tcyp25cW9Gt3mJ3a4dTB16QJ8cN?=
 =?us-ascii?Q?VBAQavTHEBxe5wI1Kwjhn6C7QcbIe+qw/wNsp0MyJvlGvbrcFMuIwMm7XqX7?=
 =?us-ascii?Q?jQDYwujWfKh/Ldt9xmnWaFxf+JSZk8S9E2Lr3olurEyrupBEbytPBLIaT6Pv?=
 =?us-ascii?Q?h7Ph8YlZaF/JkZrBorG7LOWpWBqRztw2iCHcbRvlEXMIunwiv9zaRYy97vSF?=
 =?us-ascii?Q?t7c6/HIBBH5cV3kewt4YtB2Nw1MEw0TWk/gkq0ISEhxe1f0uqHGmz0tNJrvG?=
 =?us-ascii?Q?eca81hbkJTLvo9pkd462PMHpswXPLeH+tbI/iWBtOZ8Unwf9KvmsNhXgN8Uf?=
 =?us-ascii?Q?fQOh4Aepq72sJqQkMoFDJoAPF6vJyKT2fizdEmTH34rxCvdSqGI4ES4hTIK9?=
 =?us-ascii?Q?LxUl17ZY0eQkdydnD/bFxaXjaiQlY3qqa8xV8CQhtT82Mh3xLvGmbdpN8M5F?=
 =?us-ascii?Q?VojWXqvVOvkvgiaJ0B5Lwx+H0KmW8qIB1kxynhA5wX2ro7PtPGLgARXjHXkE?=
 =?us-ascii?Q?X5fA2d2pPDXCcjGypNuZ8thUOHCKDCiaOellmAlXfXK4yd6DsY+4N3ziGrOX?=
 =?us-ascii?Q?CvesFw9M0tG7o5XYEmWd6jIMzuYSnEjZJH4ejmu29xhhGaXcExCxEfAflUCL?=
 =?us-ascii?Q?cGQGjheFvOX2px3/AWsdk19UTkm9/B31KT8RfMuAYLF7S9ZbH139blB/o+fa?=
 =?us-ascii?Q?R+2N4vNGRnURkt3EeQRdUnyHsl9533BZNSsKBzgchRwKf0bBazeXukdqLM14?=
 =?us-ascii?Q?jGi6CskER3SgcljihGl+jSirKJjR6PtT1z7W2AAmzAKrHbcTHc4wIfLJMLx1?=
 =?us-ascii?Q?6ujZq44G5L2tJuobafwVq+kQ0KdcLeCT0THZj/Ccex5HxAj2j1f/mLH/6W+7?=
 =?us-ascii?Q?DS4ekmxzo3eIvGzDylU+YGut2UDxyf/ukdGa92BzWjOi6rkATtPVBDMSn03t?=
 =?us-ascii?Q?Sr/ODKh8CCqGki3EgZCkmCHTwsIWjnDEn3X1s/AK3eliBUjZgk3nTp21RsJi?=
 =?us-ascii?Q?63yR++AqFDn+t5Wy3qVCRCZzPt1N9tP9hKDMcKwOClU7ucyF+1/D5kxAnP9t?=
 =?us-ascii?Q?9wIN8pUMKTDTA74xOqbUHhk0L35OhXMAielxs8Rsz9OzKwhybQ6ue5KdPFS+?=
 =?us-ascii?Q?zPK9f8LAaAUiJOfq6Ott8MlchbR2jAIXpMbbHPmVflmncAaZ36E/13oIhfDL?=
 =?us-ascii?Q?b0SBL24ao6QT5jqCNcTTvWU3Er/Kt3wP9p1P7Koj4ikLxGytQRhtl9zw4cpS?=
 =?us-ascii?Q?pXzh/tMZHATSw2KF4UtrwGlOlpJ3JiDd/lFW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 03:46:50.2620 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0530c59-b085-4a58-beec-08ddac886d23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF6CDAEAF48
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

Add a detect and reset callback and add the implementation
for mes.  The callback will detect all hung queues of a
particular ip type (e.g., GFX or compute or SDMA) and
reset them.

v2: increase reset counter and set fence force completion (Jesse)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  3 ++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 51 ++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index ec040c2fd6c9..0335ff03f65f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -77,6 +77,9 @@ struct amdgpu_userq_funcs {
 		     struct amdgpu_usermode_queue *queue);
 	int (*map)(struct amdgpu_userq_mgr *uq_mgr,
 		   struct amdgpu_usermode_queue *queue);
+	int (*detect_and_reset)(struct amdgpu_device *adev,
+				int queue_type);
+
 };
 
 /* Usermode queues for gfx */
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index d6f50b13e2ba..52d438b5dcef 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -21,6 +21,7 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  *
  */
+#include <drm/drm_drv.h>
 #include "amdgpu.h"
 #include "amdgpu_gfx.h"
 #include "mes_userqueue.h"
@@ -198,6 +199,55 @@ static int mes_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
 	return 0;
 }
 
+static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
+				      int queue_type)
+{
+	int db_array_size = amdgpu_mes_get_hung_queue_db_array_size(adev);
+	struct mes_detect_and_reset_queue_input input;
+	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_userq_mgr *uqm, *tmp;
+	unsigned int hung_db_num = 0;
+	int queue_id, r, i;
+	u32 db_array[4];
+
+	if (db_array_size > 4) {
+		dev_err(adev->dev, "DB array size (%d vs 4) too small\n",
+			db_array_size);
+		return -EINVAL;
+	}
+
+	memset(&input, 0x0, sizeof(struct mes_detect_and_reset_queue_input));
+
+	input.queue_type = queue_type;
+
+	amdgpu_mes_lock(&adev->mes);
+	r = amdgpu_mes_detect_and_reset_hung_queues(adev, queue_type, false,
+						    &hung_db_num, db_array);
+	amdgpu_mes_unlock(&adev->mes);
+	if (r) {
+		dev_err(adev->dev, "Failed to detect and reset queues, err (%d)\n", r);
+	} else if (hung_db_num) {
+		mutex_lock(&adev->userq_mutex);
+		list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
+			idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
+				if (queue->queue_type == queue_type) {
+					for (i = 0; i < hung_db_num; i++) {
+						if (queue->doorbell_index == db_array[i]) {
+							queue->state = AMDGPU_USERQ_STATE_HUNG;
+							atomic_inc(&adev->gpu_reset_counter);
+							amdgpu_userq_fence_driver_force_completion(queue);
+							drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE);
+						}
+					}
+				}
+			}
+		}
+		mutex_unlock(&adev->userq_mutex);
+	}
+
+	return r;
+}
+
 static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 				struct drm_amdgpu_userq_in *args_in,
 				struct amdgpu_usermode_queue *queue)
@@ -352,4 +402,5 @@ const struct amdgpu_userq_funcs userq_mes_funcs = {
 	.mqd_destroy = mes_userq_mqd_destroy,
 	.unmap = mes_userq_unmap,
 	.map = mes_userq_map,
+	.detect_and_reset = mes_userq_detect_and_reset,
 };
-- 
2.49.0

