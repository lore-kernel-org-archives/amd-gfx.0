Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 741F2C77B73
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 14:48:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E954910EC7B;
	Thu, 20 Apr 2023 14:48:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7D0510EC7B
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 14:48:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsy2sL3v0Qg2BeD2hs+W/lx2gkZHfQIEgEPk51obEOBuVlZxPI0tWDR1wfQ8Fn5npPgZuVRPNxhEadskdAretgxhQxhQRhW//+qHzIXHeRtgBebnHh9l3pqhLhxrpbxm18LJPf9gUYzf5zAzX0x94jwgfPuslx4jyWrbMAO34afs8d+WzxCrfP5vfESrJ3rx/MDGZknOnO1v55pHRsqoBTB/AR7IOdlFYPdapnK5B4iV69RBlqYELjmlamh81FqdMNcgIhFXk+dPUVCi2Ynrh0KSIUgVwSEez4Eoardb3dKWPvtiK4MrQJO/CCVUa/wzt/wQCXJJKFg/jnIHGMO/qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/R0Bl6teh2z4q2vDL6YXcwx2Lv5GHGBbGzyez7kL8A=;
 b=MUh287tW0+/p+ZfIUUSIK8KD2PAzbLc2wkOvxkJ/dNCBGlJyK7uD7HEkASURJFC7G+G8iRioaOqlFGoo1w6PBMMIIH5oSwGiwMwLtAtgkX/aLMzCtM2emz2kW4vUIStOptWICSS97xRy1NOCkBTmYPj+40NLJ4eJFvPmqPcAOg6d68Dgfm1IKAts/WUwLsjl9epcHm4Wv8tFSQWRTmcbWnE5TLxjbmOrhBud6laylOz0yeJGTzmt8K9RubY02GgC+4TH28XoPTGbJm0X6Z22tRgdhfqIdNUmWHrzeqFSRP/WsXUFdzFeTKZe7mVkzEkhl4Is8amWjkBogpRzAc9V7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/R0Bl6teh2z4q2vDL6YXcwx2Lv5GHGBbGzyez7kL8A=;
 b=IhvmtPoX+7NhCJpXQmQ9to0KWnNaJJJzCR69fdmvDsxMq/OwVeotuTZDWsr7Ef5ErZCIaduR1/btLSN0lyiTkwLFBrbhsyKh0UfuqqylwlxC//e2ZV6PPcTUbb3pfe9fq/w61+VX1hAqEnnh34C1A/grCyqdiy0q31JntWHZOQc=
Received: from DS7PR05CA0010.namprd05.prod.outlook.com (2603:10b6:5:3b9::15)
 by CH3PR12MB7642.namprd12.prod.outlook.com (2603:10b6:610:14a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 14:48:02 +0000
Received: from DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::7d) by DS7PR05CA0010.outlook.office365.com
 (2603:10b6:5:3b9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.11 via Frontend
 Transport; Thu, 20 Apr 2023 14:48:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT101.mail.protection.outlook.com (10.13.172.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.24 via Frontend Transport; Thu, 20 Apr 2023 14:48:02 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 20 Apr 2023 09:48:00 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 6/6] drm/amdgpu: Enable userqueue fence interrupt handling
 support
Date: Thu, 20 Apr 2023 07:47:14 -0700
Message-ID: <20230420144714.124377-7-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230420144714.124377-1-Arunpravin.PaneerSelvam@amd.com>
References: <20230420144714.124377-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT101:EE_|CH3PR12MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c681611-d88d-4417-fa7a-08db41ae3e29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q6M/ufdx1gMlrgMdyALu+56oPeMyroxpaOV7SELy2PCVx4+yCQ3nEAJayyZ9Mi7FOTwjDdQPH0pdPRvw3Vj9jAWhjshvkYO9XVrYXySx0B73asXdSiaNYgSkMe6AlI+7nyjIaLS0vrUNIoe2mpBiFpF0TFo44fOuzNXRil9wb8CBr4waxPYq5/iXKsjAYkZnc9X+uPZmQNYFUeaS4zNuI6FB/U8ZM7fJPpVkSHYnbrlY5ulUTHv2CNWdZSmNypFeC3AvvslI7j4yr3QYQ+E33G19ScEBksSBAvhVX61dM6PQh8pNeFeqddVap9GgT6B5u8GJUxpLzHLQyBDfdO4i7LM+wBOW3ArvisOF5O4mP7C0QKFYagLqV7I0cAZ7WVsWR2iCJx87cF0XmCLijpPJStvIwd/omD3/LfPZmK0c5x4nSyHGWPwPRDZ+g+foQ5L4JMxZGaUTlcko8o5mr5mCAyAeJYaEkWjoZQWAPhmiYYbrgf98DLuGpPq9xsTuh9i2nDmoDJ+xu66wc1cWQoVsroVKS/hyWh00a30ySu1g3QXdISFrkFo/+/GFwz981lE63ubIrHZ34IFD5b6iAn1Czm1PZzFnFKz3NQx7IRjuIzwyvrs0tVubqUG+5sP17QlqP0Qhafh5lH+0Pjh0dzhLNa6CGT++ij3KTd0Gro6UE31eFQ6+be1Xp3NDQKz6NVuZyrP/ZfZO789jbf4ITvqp5TISJKd2VzelFLGX5U7VjOw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199021)(36840700001)(46966006)(40470700004)(54906003)(83380400001)(47076005)(478600001)(2616005)(36860700001)(40480700001)(86362001)(1076003)(26005)(7696005)(6666004)(4326008)(316002)(70206006)(70586007)(6916009)(82740400003)(186003)(426003)(336012)(16526019)(8676002)(8936002)(2906002)(81166007)(356005)(41300700001)(5660300002)(40460700003)(36756003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 14:48:02.5173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c681611-d88d-4417-fa7a-08db41ae3e29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7642
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
index 1d8a762f43c6..58e8c72706a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -971,6 +971,7 @@ struct amdgpu_device {
 	struct amdgpu_mqd               mqds[AMDGPU_HW_IP_NUM];
 
 	struct amdgpu_userq_mgr         *userq_mgr;
+	DECLARE_HASHTABLE(userq_fence_table, 5);
 
 	/* df */
 	struct amdgpu_df                df;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 828d0dd1455b..c89d5fd4a23b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3431,6 +3431,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->mn_lock);
 	mutex_init(&adev->virt.vf_errors.lock);
 	hash_init(adev->mn_hash);
+	hash_init(adev->userq_fence_table);
 	mutex_init(&adev->psp.mutex);
 	mutex_init(&adev->notifier_lock);
 	mutex_init(&adev->pm.stable_pstate_ctx_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 1c455b7ebcd6..a183d04bb98e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -90,6 +90,9 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 	INIT_LIST_HEAD(&fence_drv->fences);
 	spin_lock_init(&fence_drv->fence_list_lock);
 
+	hash_add(adev->userq_fence_table, &fence_drv->node,
+		 fence_drv->gpu_addr);
+
 	fence_drv->adev = adev;
 	fence_drv->context = dma_fence_context_alloc(1);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
index 2b2f52296d76..cf714247dc05 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
@@ -41,6 +41,7 @@ struct amdgpu_userq_fence {
 
 struct amdgpu_userq_fence_driver {
 	struct kref refcount;
+	struct hlist_node node;
 	u64 gpu_addr;
 	u64 *cpu_addr;
 	u64 context;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index a56c6e106d00..b52b90bd6edd 100644
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
+			amdgpu_userq_fence_driver_process(f);
+		}
+	} else if (adev->enable_mes && (mes_queue_id & AMDGPU_FENCE_MES_QUEUE_FLAG)) {
 		struct amdgpu_mes_queue *queue;
 
 		mes_queue_id &= AMDGPU_FENCE_MES_QUEUE_ID_MASK;
-- 
2.25.1

