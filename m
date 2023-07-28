Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2897C0015E
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 04:16:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43FEA10E634;
	Fri, 28 Jul 2023 04:16:41 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B354910E634
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 04:16:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PINqmASEx52MC7xAN44FFPj5JOqe/MLOBAjm2WULoBsP2vLbjzYQcT2E71exWBbFUecX7ik8eIO2quTVOXN3gkreqgpoo4gs4t8D+sLoV9ZONIuHiYz87JrOWirHuLktRURV5nDMuuVSiIU1XbTTqO7pRpFRB1N0XjlyJyYJhvEc15JKtuTYGFs5NB9oHEAUlGaVZCCvD1lovJbAh3Kh26vTfYo/iJMJItUJNUbuVPxlmFBNupHpde8ET4oaenGHAzXgrcBPkpzHwAq3R8/yEgnDucXUn19XxZiYZFlmItDIz4CMDeghdaP9D17CjAoRaSnHuD3wrjQ7gebmsVKlYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKJGgw/hUcm9HUo7cFTLBq3LQtMMoyjJtGhLjsFiKoc=;
 b=m24pDMPror5Vcm3EHrWZBkW3BV8ZEJj9CZaa36j6A9TlR4Mt35IvWsvJLR8GkWXGRDnXZ6PlUjpmr+wjYB2HkB2awtG/YjMhpaKVdzhfJBSnhFDPZGwSBQKRepFPCyP9ySEgLOfJmGj5rpxskdFg4pXR00O4N99cD/yYaWLviE9DyexVyHcxckWuabh9SQ+tUpp2Iksprz+JfBGzV/ghVk4ea1Yap8DQs3dFth6r6oE7lGMUXejLgg7jtpI5VBR9MbvKwPPXj4EVjnvrx/lSNznpywu37NZ8Q1WzIwVJTGKR953b9cRXwpX0CxwlpYjC7YQu43ekOEjgPK+kmAERBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKJGgw/hUcm9HUo7cFTLBq3LQtMMoyjJtGhLjsFiKoc=;
 b=KODZ6lkizMdjdQfUzbBtSdVbfJl7I++mJUbyR7iDCHuUe3fxX5B+oILJzOp5APZxvI0+h8kz2qUzv/kuOIGkme381qmLaYJbMlQh92htCxfdUS8aGGjQsojTl9c+iEl8D0KN+khLJfgFxLjzZoti4TgzY1xKeDiZoDfjW6xBc8A=
Received: from BYAPR11CA0108.namprd11.prod.outlook.com (2603:10b6:a03:f4::49)
 by IA0PR12MB7722.namprd12.prod.outlook.com (2603:10b6:208:432::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Fri, 28 Jul
 2023 04:16:36 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:f4:cafe::4a) by BYAPR11CA0108.outlook.office365.com
 (2603:10b6:a03:f4::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 04:16:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Fri, 28 Jul 2023 04:16:35 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 23:16:33 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH] drm/amdgpu: Sort the includes in amdgpu/amdgpu_drv.c
Date: Fri, 28 Jul 2023 09:46:15 +0530
Message-ID: <20230728041615.2670398-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT039:EE_|IA0PR12MB7722:EE_
X-MS-Office365-Filtering-Correlation-Id: efef44ab-d939-44bd-4dd1-08db8f216ed5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dkdOSmZCuSWiCEU1SOKXMQzNmq4mF9RroLuZm+5SEMyekAA97b+sLyiCCiniKJYhig0h3renUT/2a7iw/KsCiDWfbm6YnzKrNQ5CVZuqtg3RDJINfBI7VfbyXRcDwA3C4WDwJlQw60mUH7rJVQ2Zfrw+DhAC9U+Gzz5QeNn/XYDbGLXj47e09vnRv00RGKAmcLE1m/zA55I3AUYqiyMrJeOed3s0d6TTiC915fBVpnCkwxXGXfe60EGD3XOrUlTMPoVRF9SrUtnwB7mUcPi2Svo/oiEQYX7an9tAlqUoeN7H92gyt+8s5JJxFfrUDu+xDjtO4r8eryBiqHIuxWD8ZLokjy4N8taNUF3xQGEcp/lvrK02RHlO78mDipuPDuVAmM+o2BzuacubjFnyH1z5cXZFEUc5GqU0x8soNVQCEMOpLEZ2qZa5sgVHqS28TYp2RkES2K/2pf/dDBGExqQJFZsITLTzH1WI1TgeVTi5wDdEkLnxrRR6FGHp9HwZw/8+pMvbTtlnsIjJEJvXhEN2OvR4hEkZ6zrbFlrZANreiaY+HXR9nJ33GYLMFRpXiWjHTZoTD4iOggTcXOy2pxLH5jxDJ7qmuuqCTHTOcEZuLj5kUJ+WOmOwiaz7SMca0lI/TyNI9hEpERw//80gCH6Lc38vSEeHpuacCtVSgzl9vj/DoMRQya7ygSLQJEhRWYM8MeD3rg7nxUEicPWplUBoognfbGq9GnAUv2F3Egh605pVGRbAhZM7l9uESIFI8JMkYL755KRnXAlNfDcvUVhswg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(40460700003)(86362001)(82740400003)(356005)(81166007)(40480700001)(66574015)(26005)(7696005)(2906002)(6666004)(2616005)(426003)(336012)(47076005)(1076003)(16526019)(70206006)(70586007)(36756003)(5660300002)(41300700001)(316002)(186003)(6636002)(4326008)(478600001)(44832011)(8936002)(8676002)(110136005)(83380400001)(36860700001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 04:16:35.8441 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efef44ab-d939-44bd-4dd1-08db8f216ed5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7722
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Sort the include files that are included in amdgpu_drv.c alphabetically.

Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 900be3a62cdc..90faaf1eadcd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -26,30 +26,29 @@
 #include <drm/drm_drv.h>
 #include <drm/drm_fbdev_generic.h>
 #include <drm/drm_gem.h>
-#include <drm/drm_vblank.h>
 #include <drm/drm_managed.h>
-#include "amdgpu_drv.h"
-
 #include <drm/drm_pciids.h>
-#include <linux/module.h>
-#include <linux/pm_runtime.h>
-#include <linux/vga_switcheroo.h>
 #include <drm/drm_probe_helper.h>
-#include <linux/mmu_notifier.h>
-#include <linux/suspend.h>
+#include <drm/drm_vblank.h>
+
 #include <linux/cc_platform.h>
 #include <linux/dynamic_debug.h>
+#include <linux/module.h>
+#include <linux/mmu_notifier.h>
+#include <linux/pm_runtime.h>
+#include <linux/suspend.h>
+#include <linux/vga_switcheroo.h>
 
 #include "amdgpu.h"
-#include "amdgpu_irq.h"
+#include "amdgpu_amdkfd.h"
 #include "amdgpu_dma_buf.h"
-#include "amdgpu_sched.h"
+#include "amdgpu_drv.h"
 #include "amdgpu_fdinfo.h"
-#include "amdgpu_amdkfd.h"
-
+#include "amdgpu_irq.h"
 #include "amdgpu_ras.h"
-#include "amdgpu_xgmi.h"
 #include "amdgpu_reset.h"
+#include "amdgpu_sched.h"
+#include "amdgpu_xgmi.h"
 #include "../amdxcp/amdgpu_xcp_drv.h"
 
 /*
-- 
2.25.1

