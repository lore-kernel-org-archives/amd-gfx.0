Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F60FCC6B1C
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 19:47:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B82C410E974;
	Tue, 13 Oct 2026 19:47:47 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010043.outbound.protection.outlook.com [52.101.85.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3674810EA26
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 19:47:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t0kLkPA3D3/7+GpmrJcz56RkcZ4O39LkAnHICDG+NxBuemRk/NrKqJR1oq3AYPF3tysmx0K5iyssCNN3tLUAD/Yg4imbfA7z9w09m+TvVgQ/nMYdj+UEsGf2U7eraeK3xq9M8I+WOi0qq4WTQ7ugqu3fiRmlcsmMZxyO9xonHdYpr746+/sUn45fKSViYi5BSBY9P65UAKjY1yiZnU2axTwLKjrA2KZgte7ehywG+yfSoNbZKMFYr0UV1ZEAcdgnOKYZlakkReZePifLjPF4WMUJVEtuiEFz76urVathJ8qqFO+lguBgbild8vy/RqpAPOVzNZtOslgQR4YOwudrJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+uMeFOGgCrDbqtKuLsDdcPO/UpIjqOp1uWO/IYqXm8=;
 b=N5yYJLAgbgJdvboOkv21sd9KzS6YOWYCb2EFgOSQpsw5/hhAi8VxABiBLMjhpQ/5MimN5osSc1sl6k//ldCP551ucIBMJ2lO6vFrg3GAjejHKub8S/nmPAuBzq+Nsrg9pisRacSUwADefbJB3ldmqL0yM9WjVWf9+n8rbhZAWKfa20PrXhmqCbchHCILGBlahdFiEr0ZYL/w58WDP/k/bPd0fOd05PQZRiyEgTJqMbiVjE8Jlb+K03+mR/LayMWyS4LdJvDP6ODyoGyjFNp8dUIUtrUuvihrtHu5I04r4Z+ZBborEU881a9C0RYekf6MuY9x6BSyAfNf8Na3QRLm6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+uMeFOGgCrDbqtKuLsDdcPO/UpIjqOp1uWO/IYqXm8=;
 b=fVPYqEZEBpma+UlF5kDjfwSLGqtKosTNHTenGWzlsNn5WAUAdcFT60D7TgCs4psoLq4p30m5Q0BNHGiGPVJ2/2kEjlHniVCdld8XKHcqb+7WNQCV+40JymIAmRC7EkLmsYuHLsZiBMdibwxOAdJdE0pa5ZMTyuVzZ4PC0Q9qTqU=
Received: from MN0PR03CA0008.namprd03.prod.outlook.com (2603:10b6:208:52f::15)
 by PH9PR12MB174847.namprd12.prod.outlook.com (2603:10b6:510:415::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 19:47:29 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:208:52f:cafe::66) by MN0PR03CA0008.outlook.office365.com
 (2603:10b6:208:52f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 19:47:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 19:47:28 +0000
Received: from alysaliu-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 14:47:20 -0500
From: William Palacek <William.Palacek@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <William.Palacek@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <Felix.Kuehling@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 2/4] drm/amdkfd: Set the v9 checkpoint control stack bound
 after topology
Date: Tue, 13 Oct 2026 15:47:03 -0400
Message-ID: <20261013194705.3687960-3-William.Palacek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013194705.3687960-1-William.Palacek@amd.com>
References: <20261013194705.3687960-1-William.Palacek@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|PH9PR12MB174847:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f27802a-2ab8-4134-b091-08df2962d057
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|11063799006|22082099003|56012099006|18002099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: 27bKS4G2qvhf2zDO20IAnrtsB/lCb8nIiWIbc4+pG+t5e4c1azlGCiLuxvjjtXCrThl7i7WdIUHtIV6XAH+6RbcYdpMZaD7k5hG213gF7OrC/1dDpQxKhKTjVTCLxqk8W5Qlzym1z/+53nircvol/UlG+NfEl09lXiQPCrx8SE25dX+sLW0UqUawruOKue5e70XBVBab7FxChg4oie8PbRMYvcMDaIkOQo5ugHJohVdVmVeUEyjcX2c/Tabh/KoV7dgLQpLnQOPIWYxD1seQhQi8bluNFqL7woB20D7t9vKd8FQ/hI6txuJmhmsW2W0k7nZI7cCOmWyP2GBGG51r2RT14sXratJZ8x+pxknd1qq09D6cL4aLGUyFiwezg7EDqI06TvO66kw9VvnBXfPRpGLnp9YJls7kW5+AYZgsK7qQwAHgbnV1V89lWAu9e5tSCNE6vVGfx0U6SKZQunuvfrvJutkF/N5FbYFA/zLBB50i4wnrVYjrRT0L0aOCmn7vLGUcjGuEn1cKFrAPgpPeYEX7AqmZyXM08S4br3zsc9FHRALjSd30CNbjz1XUTjzv0PWLoFA3AJqb18DuwOTa7Od9gVY2Lcobi+3XPXnHGUbtDvwQrI1jDX6IrXE+QSqgIa/qtv+asIUlTSVDPNA9b9nCD0tr8mVkDZ0nU+on7C6FENWv2Zk3SFdihIbKh3aW
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(11063799006)(22082099003)(56012099006)(18002099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OO/duOV0kbMrGVQZCFBVEbHccj0i0V/tbMJQ36Wli5kG19Xg0NcjBlmAwhgNEYFl+hlfplaRK/APNC834zteXuOD74vCXybtDnHVMvJTe5ZBSqxSevuWUMhcTUq5TTlJGQ0CxW/L+LdXB/R8p7o5WMdZ9tEMhDROiKJXQNpLp46CKGbBmO5oCGV7urldMteKgBvgKr5SeEF/45p/Fv7or1xY5DdJ5h6DoGZLuygq+MgGg4OPCT4wZH9n4zcQ+0GsfjdwcNaDjX45VpQX3W/Z406nSM2QGqpkE+LY5L4kQ4SQVbL3k6e42KOdLxvtKpumpuX0tEmZ4AQ1f5ybNv8Q3sjhJ9bFe6E4Qjh3n68A6Xd2Z/i0rWpfVea1uWoCfjyHux+Cw/yWeg5W5ZkoepJEjDERZOllkHgNGTSrAOo3doURc7hdO76OYB1ERfd7K24r
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 19:47:28.8408 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f27802a-2ab8-4134-b091-08df2962d057
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR12MB174847
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

mqd_manager_init_v9() looks up the node in topology to set
mm->ctl_stack_size, the bound for the control stack copy at CRIU
checkpoint. The device queue manager, and with it the MQD managers, is
created before kfd_topology_add_device() assigns the node its id, so the
lookup never finds the node and the bound stays 0. Every gfx9 checkpoint
then reports and copies an empty control stack.

Set the bound in kfd_topology_add_device(), right after topology
computes the control stack size.

Fixes: 575ebd79a819 ("drm/amdkfd: clamp v9 CRIU control stack checkpoint copy to BO size")
Signed-off-by: William Palacek <William.Palacek@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 10 ----------
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c       |  4 ++++
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index c02dd9abc3ad..35c36b6dc212 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -27,7 +27,6 @@
 #include <linux/uaccess.h>
 #include "kfd_priv.h"
 #include "kfd_mqd_manager.h"
-#include "kfd_topology.h"
 #include "v9_structs.h"
 #include "gc/gc_9_0_offset.h"
 #include "gc/gc_9_0_sh_mask.h"
@@ -1039,15 +1038,6 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
 		mqd->is_occupied = kfd_is_occupied_cp;
 		mqd->get_checkpoint_info = get_checkpoint_info;
 		mqd->mqd_size = sizeof(struct v9_mqd);
-		if (dev->kfd->cwsr_enabled) {
-			struct kfd_topology_device *topo_dev;
-
-			topo_dev = kfd_topology_device_by_id(dev->id);
-			if (topo_dev)
-				mqd->ctl_stack_size =
-					ALIGN(topo_dev->node_props.ctl_stack_size,
-					      AMDGPU_GPU_PAGE_SIZE);
-		}
 		mqd->mqd_stride = mqd_stride_v9;
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 35b3abe57b80..1fdec20a9609 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2203,6 +2203,10 @@ int kfd_topology_add_device(struct kfd_node *gpu)
 		dev->node_props.capability |= HSA_CAP_FLAGS_COHERENTHOSTACCESS;
 
 	kfd_queue_ctx_save_restore_size(dev);
+	/* dqm is created before the node has an id to look up in topology */
+	if (gpu->kfd->cwsr_enabled)
+		gpu->dqm->mqd_mgrs[KFD_MQD_TYPE_CP]->ctl_stack_size =
+			dev->node_props.ctl_stack_size;
 
 	kfd_debug_print_topology();
 
-- 
2.43.0

