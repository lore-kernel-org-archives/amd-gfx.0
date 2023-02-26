Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A80C6FA8E
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Feb 2023 16:55:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E69F010E146;
	Sun, 26 Feb 2023 16:55:30 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BDAA10E13D
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Feb 2023 16:55:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zg/zzHDmROLiKKDz6Kr73UyjrIi38jls286aVVcyC/tDp5sxzMDH23pQCVmsxP2VeicPkbGtO2OcpPjDJNrae4tpfgG9e0OpNtt18hOL3aPiu0gu0syGlqETN81iJyh4pup/s6XFQxnx0WkCYwqGOeufrSR75NZHmm1qpByGvT05P7oqWF+OaWQPrthneYZDhAu8YTZZZBJTkp/dGil+fwXosqFsAuqXpO0tTmg4SBGNMp6IMVDbqJKZ7JMWP254AHgKwY0IZhnp1762T/5nZPUWrBpWdsW2nWOLz+AHTaQT0foX4etZEbDbgBs7MlX25bu9ADlhwPMDR3NJ3nR+/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVLIDgjkP/F9KHlKBHryvQPZEU8NtqNILDVanGyIjsw=;
 b=ceILsxDCTOtNIUp9qzmJ4JfnZUiC3/k7GhGId9W+mzfMCbryV9lzxHEFYeKA8iLnFVuGK4lNlktmd6FQkBjs8+UBilrjypi/OTj2YoURIM+VAeHWh5SBK0JV+LnT0X4E6qmeqUyHmtgv+KqzuPe9Fa+HhhD8DgwsZhbzCh4+vSdVcZMqGfqLLc/UhXoR4Z/WeyjR58BbAIMvjL+/oV4X5/CDpj/J/f+9ZRtDYuhcsO6PXwYaYcazWPknO035w5vaVBQXnhch5doXsyC6dI0dkN8QffO+Oey9umteihGHt4jmwOjWA/wjdSv0sNZcpwjth9sDvkfVSRmUyQHirVeXxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVLIDgjkP/F9KHlKBHryvQPZEU8NtqNILDVanGyIjsw=;
 b=VCTJBbs+fbzS9uQzyrIxyeYiiFxPCxJNmXonw9xlolvn9axXnPT4cg15SHN3dWyZzKaLFjyZqgSzNsPnI3FROehnSZ41W78+eXLtXL8xQBeZ+NGHpyQNgzfYWQbwiRQb76HnZy6ESEafn6nYucTu1O7coLp0Gx27yWoRwTKZtCA=
Received: from BN8PR15CA0023.namprd15.prod.outlook.com (2603:10b6:408:c0::36)
 by SA3PR12MB7923.namprd12.prod.outlook.com (2603:10b6:806:317::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Sun, 26 Feb
 2023 16:55:23 +0000
Received: from BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::57) by BN8PR15CA0023.outlook.office365.com
 (2603:10b6:408:c0::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27 via Frontend
 Transport; Sun, 26 Feb 2023 16:55:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT089.mail.protection.outlook.com (10.13.176.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.15 via Frontend Transport; Sun, 26 Feb 2023 16:55:21 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 26 Feb 2023 10:55:19 -0600
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/6] drm/amdgpu: Enable userqueue fence interrupt handling
 support
Date: Sun, 26 Feb 2023 08:54:35 -0800
Message-ID: <20230226165435.41641-7-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230226165435.41641-1-Arunpravin.PaneerSelvam@amd.com>
References: <20230226165435.41641-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT089:EE_|SA3PR12MB7923:EE_
X-MS-Office365-Filtering-Correlation-Id: e5af6850-8853-498a-5285-08db181a3f6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W5Tv53rcvkKAQkke9ufVWZ6bqYz5aeKgTxnZ2CrvGK4eNIXOtuAx6HLui2iODiylOU+XW2lG2MLw9k2a+6i1Wb6jY0wPCshvBKPtrjQKmnrjixyGPsUz3CQ7gBIcGs1mhuX2WketI1onlh/Wj8EAaoLNAaqMK0tsxLDygmiJlwoqwHuZvC1jy5wwdwl650d6DYn6O0hi7UAd/MFKr4d3EbtNUzHWyg2HbpI2rXgcgD7Of4Avgk6qXhGKgDuX+Q0piyUCRX+d/Do5hxYv0zW/LOhn3ljsI2N0ZRst6PdETgRwqjiR9LZfYzSrX3kA4XUMwPJ/Xm7N5APIaYcT1FD/UtmpjgjhJdrfC3AAwV0eipSVniHl/OlTNOMwtF8G2/RrKVpr5JCl4p7k3bHjg+63YQtNok05hv5ze+7YlqaBH4G0epd5dSVp+Tmj+MrVsiVj0YsNK5HHhVA5gQFMhBuMTPoTT/EQPScIGPtPbRKtNdx0JoOD3Erz4RGQV+YlhvN31AEdz6znIWBD2EzjA89z2KhCBQXKy3W7CxE3H4/Ojb6ar3ID/h0NtpomwlBcVIAcGLcMsqfGmNBTU7/t2Q4vOdXyopkm8aQbypriMkZefQG5tY8PH3vZabIlMjL9IAeUfwm0tkwfYpjDXxsYLtyEfJ51sfmhnI+SMINDI0Cxjs4avwma8nx/W9k+CA9ey8JPH9sEdPIZKLIsHylrt2t2oguC2lyqg3kTA4nRwH5eFvg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199018)(46966006)(40470700004)(36840700001)(40460700003)(36860700001)(83380400001)(47076005)(2616005)(82740400003)(356005)(81166007)(82310400005)(40480700001)(6916009)(4326008)(41300700001)(2906002)(70586007)(8676002)(70206006)(8936002)(186003)(16526019)(26005)(6666004)(5660300002)(7696005)(336012)(316002)(36756003)(426003)(1076003)(86362001)(478600001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2023 16:55:21.4802 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5af6850-8853-498a-5285-08db181a3f6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7923
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Arunpravin
 Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

- Added support to handle the userqueue protected fence signal
  hardware interrupt.

- Create a hash table which maps va address to the fence driver.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  1 +
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  3 +++
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 20 ++++++++++++++++++-
 5 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 255d73795493..3380bf66dd66 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -965,6 +965,7 @@ struct amdgpu_device {
 	struct amdgpu_mqd               mqds[AMDGPU_HW_IP_NUM];
 
 	struct amdgpu_userq_mgr         *userq_mgr;
+	DECLARE_HASHTABLE(userq_fence_table, 5);
 
 	/* df */
 	struct amdgpu_df                df;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 88097d12ced3..4caed7cc848d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3595,6 +3595,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->mn_lock);
 	mutex_init(&adev->virt.vf_errors.lock);
 	hash_init(adev->mn_hash);
+	hash_init(adev->userq_fence_table);
 	mutex_init(&adev->psp.mutex);
 	mutex_init(&adev->notifier_lock);
 	mutex_init(&adev->pm.stable_pstate_ctx_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 26fd1d4f758a..91c0ab2c9370 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -90,6 +90,9 @@ int amdgpu_userq_fence_driver_get(struct amdgpu_device *adev,
 	INIT_LIST_HEAD(&fence_drv->fences);
 	spin_lock_init(&fence_drv->fence_list_lock);
 
+	hash_add(adev->userq_fence_table, &fence_drv->node,
+		 fence_drv->gpu_addr);
+
 	fence_drv->adev = adev;
 	fence_drv->context = dma_fence_context_alloc(1);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
index 999d1e2baff5..ceab0ccf68a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
@@ -39,6 +39,7 @@ struct amdgpu_userq_fence {
 
 struct amdgpu_userq_fence_driver {
 	struct kref refcount;
+	struct hlist_node node;
 	u64 gpu_addr;
 	u64 *cpu_addr;
 	u64 context;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index a56c6e106d00..425ecf58b343 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -30,6 +30,7 @@
 #include "amdgpu_psp.h"
 #include "amdgpu_smu.h"
 #include "amdgpu_atomfirmware.h"
+#include "amdgpu_userq_fence.h"
 #include "imu_v11_0.h"
 #include "soc21.h"
 #include "nvd.h"
@@ -5870,10 +5871,27 @@ static int gfx_v11_0_eop_irq(struct amdgpu_device *adev,
 	u8 me_id, pipe_id, queue_id;
 	struct amdgpu_ring *ring;
 	uint32_t mes_queue_id = entry->src_data[0];
+	struct hlist_node *tmp;
+	struct amdgpu_userq_fence_driver *f;
+	u32 upper32 = entry->src_data[1];
+	u32 lower32 = entry->src_data[2];
+	u64 fence_address = ((u64)upper32 << 32) | lower32;
 
 	DRM_DEBUG("IH: CP EOP\n");
 
-	if (adev->enable_mes && (mes_queue_id & AMDGPU_FENCE_MES_QUEUE_FLAG)) {
+	if (adev->enable_mes && fence_address) {
+		hash_for_each_safe(adev->userq_fence_table, i, tmp, f, node) {
+			if (fence_address == f->gpu_addr) {
+				hash_del(&f->node);
+				break;
+			}
+		}
+
+		if (f) {
+			DRM_DEBUG("user queue fence address %llu\n", fence_address);
+			amdgpu_userq_fence_process(f);
+		}
+	} else if (adev->enable_mes && (mes_queue_id & AMDGPU_FENCE_MES_QUEUE_FLAG)) {
 		struct amdgpu_mes_queue *queue;
 
 		mes_queue_id &= AMDGPU_FENCE_MES_QUEUE_ID_MASK;
-- 
2.25.1

