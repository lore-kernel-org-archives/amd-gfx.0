Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5905EC77B76
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 14:48:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D55AE10EC78;
	Thu, 20 Apr 2023 14:48:01 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A93F010EC78
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 14:47:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTLsIhi1neNMJNa6EveXD3sRxWmJFvzX3rC1sidBmuisDt9biusm3J9OV79toqHCH0ytXPSsocCXOp1hwqU3mIwTMfJkzkHO7cH98V4A8rPJT/DrkrQo7DcqcbGXbyD/K0oNPW9OLj3HvUkoz2tvuHD2oB/jv3WQEsz0DNl48uubKvT8cecdVvi0gdIbFt8hd0XvPWLPMJIVrNsFeibygAMSaphg8BHXMzX6dWlbUdHYWS05NSgzUNWYO4/gavA8qvz8Lr1MNTmYRmGXzshyMhSPsal2lmDzBPblUBGgKs+Su30DFkKOOyCBxEwEWZlS7OFfZNSogv0hvuxWx8rylg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAVVd6NqVbePF+YkB6ndI2Sqnkj+CNxShpo3u53upo8=;
 b=kqX5d2ST3NkxL4vycwLSjosezpGCZcIDa+glsPmAuuyUCmDxA2YjOPx7jBGLAntvWPaxNYBdDOYzWcRPPGQwiMOapFSAEuEnnWqbAWREByTc/ziVqSmBZROqyWn/sr3f4tgm4w9GF2C3Mj8dFJRIdVtOgUak0r8yAoBqSir850NNrRP0z1VawfB329LC6UuNSqyN4nlmsJgtLvAGOCw9ZlOzs/q2lT6jSvQPkWKiB1++hDktrXvV2x1KKhwWPUsYiTeu6NPbCT2Z0hNMji6rzmGrwt1xl2sidIlgHX7V4xnoK3GIm1U0kirBncN+DP1p5JpRx/lfSrx2ta/RhL4NXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAVVd6NqVbePF+YkB6ndI2Sqnkj+CNxShpo3u53upo8=;
 b=sAyp3xWofDrjZ3+BOGLJMejc7bwvXJ7RCIyveMUo45UKiy46URgfB/0zAz+4XPi2ZE1QZqSmbVu3527VZfcrChjEcE7l0nklUShTH5Q1qfCZlbrCuu3d4QAFK59J4k0Mq/HVcHNF6YBx3RURehgc/WnkTitilraFbQKq9z6+7Dg=
Received: from DM6PR06CA0010.namprd06.prod.outlook.com (2603:10b6:5:120::23)
 by PH7PR12MB6394.namprd12.prod.outlook.com (2603:10b6:510:1fe::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Thu, 20 Apr
 2023 14:47:57 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::5b) by DM6PR06CA0010.outlook.office365.com
 (2603:10b6:5:120::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.24 via Frontend
 Transport; Thu, 20 Apr 2023 14:47:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.26 via Frontend Transport; Thu, 20 Apr 2023 14:47:56 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 20 Apr 2023 09:47:54 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 3/6] drm/amdgpu: Add mqd support for the fence address
Date: Thu, 20 Apr 2023 07:47:11 -0700
Message-ID: <20230420144714.124377-4-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230420144714.124377-1-Arunpravin.PaneerSelvam@amd.com>
References: <20230420144714.124377-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT059:EE_|PH7PR12MB6394:EE_
X-MS-Office365-Filtering-Correlation-Id: 55e5e280-f0a0-43ba-e324-08db41ae3abd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /RMBqCVy6/SSsGxWaYDRXjFhkPcO2pRp+dMr6WijQC6PHyAsJb13p9pCY8nh38LJpJTeN8vSWpAkbQO0ekek2y0M5Fa9k1i02J1dzLfRieKxLyXJP1yFv5NLttIW5WBOeaVsHoywntddB/D45Yk/3jpoMqBgVscnzNyW6kqJ//aamOuc8N6wbj72S7twOspgrvfD5zkuBY8GEHnqt6NP4WD/1pPYFn2Mk3La03uTrBo2/0pvFbQ+j2X90WRB+Z9UD7IegukVLU9bjTC9lXccPetVPDW/07BWayYW8RC7VjYhqWZ6kImyQ103KVBnE50GUkgpji3AIGkeviRNRBCTbSZhTBomY0weet2hIRQMpuXYAGB24p8dv82AwNxfac8gV1Jh2m2d6aHcuM+1oHktgIqoABY0/+jAvx3jXLj0wJEWK+zbGE/yZ/E2cA11yoRBNCsYkvAfhNUKniyHvPZtr7jucKN4V4JMEgGelSb5Xu2FblREnsgLM4PToeyJAEgd0xNQPvSVQ1KEBUW8JVXivQxcFzngOMuufqJhIzQ1WL3+XMC1EqRVcx3PvBGn9ASVW29dkd6yNpuC7rnjHgyuJDdMYty76g9ikq2edZrj+EJhMi4UdudLzguOm46BU/5b4dJ7vqS5skKOL5PmbLr3oEtikvcwj9lh42dNCGzKI1D3rJ9nvS51AGP2VBLqYQN/cFssiwOSnbW0YOeFtW5E2LXlyoYBJQnsPdxBYWwy0gA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199021)(46966006)(40470700004)(36840700001)(478600001)(6666004)(8936002)(8676002)(316002)(41300700001)(82740400003)(6916009)(4326008)(70206006)(70586007)(40480700001)(54906003)(81166007)(356005)(186003)(40460700003)(2906002)(16526019)(36756003)(426003)(83380400001)(1076003)(26005)(86362001)(336012)(47076005)(82310400005)(36860700001)(5660300002)(2616005)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 14:47:56.7913 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55e5e280-f0a0-43ba-e324-08db41ae3abd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6394
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

- Add a field in struct v11_gfx_mqd for userqueue
  fence address.

- Assign fence gpu VA address to the userqueue mqd
  fence address fields.

v2: Remove the mask and replace with lower_32_bits (Christian)

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c    | 12 ++++++++++++
 drivers/gpu/drm/amd/include/v11_structs.h            |  4 ++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
index 274e78826334..a9d41407bab1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
@@ -22,6 +22,7 @@
  */
 #include "amdgpu.h"
 #include "amdgpu_userqueue.h"
+#include "amdgpu_userq_fence.h"
 #include "v11_structs.h"
 #include "amdgpu_mes.h"
 
@@ -131,6 +132,16 @@ static void amdgpu_userq_gfx_v11_destroy_ctx_space(struct amdgpu_userq_mgr *uq_m
                           &ctx->cpu_ptr);
 }
 
+static void
+amdgpu_userq_set_fence_space(struct amdgpu_userq_mgr *uq_mgr,
+		             struct amdgpu_usermode_queue *queue)
+{
+    struct v11_gfx_mqd *mqd = queue->mqd.cpu_ptr;
+
+    mqd->fenceaddress_lo = lower_32_bits(queue->fence_drv->gpu_addr);
+    mqd->fenceaddress_hi = upper_32_bits(queue->fence_drv->gpu_addr);
+}
+
 static void
 amdgpu_userq_set_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
                            struct amdgpu_usermode_queue *queue)
@@ -190,6 +201,7 @@ amdgpu_userq_gfx_v11_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_u
     }
 
     amdgpu_userq_set_ctx_space(uq_mgr, queue);
+    amdgpu_userq_set_fence_space(uq_mgr, queue);
     amdgpu_bo_unreserve(mqd->obj);
 
     /* Map the queue in HW using MES ring */
diff --git a/drivers/gpu/drm/amd/include/v11_structs.h b/drivers/gpu/drm/amd/include/v11_structs.h
index f8008270f813..797ce6a1e56e 100644
--- a/drivers/gpu/drm/amd/include/v11_structs.h
+++ b/drivers/gpu/drm/amd/include/v11_structs.h
@@ -535,8 +535,8 @@ struct v11_gfx_mqd {
 	uint32_t reserved_507; // offset: 507  (0x1FB)
 	uint32_t reserved_508; // offset: 508  (0x1FC)
 	uint32_t reserved_509; // offset: 509  (0x1FD)
-	uint32_t reserved_510; // offset: 510  (0x1FE)
-	uint32_t reserved_511; // offset: 511  (0x1FF)
+	uint32_t fenceaddress_lo; // offset: 510  (0x1FE)
+	uint32_t fenceaddress_hi; // offset: 511  (0x1FF)
 };
 
 struct v11_sdma_mqd {
-- 
2.25.1

