Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD44EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 12:36:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E767110E48E;
	Thu,  6 Jul 2023 12:36:42 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::625])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4358310E45A
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 12:36:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETFnIWo5RK9r8xb3WaPwWiC/IIuQGxD8D10PvrzBbk4+4kwsiccuyC8NoxdsVlOhvHkcS2fBF8Nu4RYuen9hFeRXPJ6F++yUlfoNsQZ9Pv7bl0c110JomWgUorQPTtbFp8MKAwntvBgSLYKqh9J4kHsRKDPN+jCNbVC+ulPaZYOgUhUev4TmZN/RjfTm888N1FKKBhSeTQbeNrYAUn3vH1bSgSPdmrHakk//UevHrLYo5kKtZNQ5I+fbm+vY0wpDmMor/jtNJnSLGVDMt+XSpmjmxKm3TI8/2kZOsBBlzuC+HVtO5OmcsbB700oLuCE3YlPrzv5GsPbsZgVMDGo+9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9aFuRz2J36ROQfNBkzw7Iq5hScrlK1gBCyzwgOrp1g=;
 b=LpFDedbZVz5oD9eAcQojUPIsgZSjmRZPu/obGtk9nkanHzahXbV6kaSb43V/cEPfdt4HMXfKn0/w3hp41o6/n9o1gbwapQ59AYUb702HaYetJe5I1wbIJnZH0YzIYGUNB7nb2rR5kZWliPnuxiF2tUDLPPE/evAiPX3peLK0iQXUcVRqol7GrETUOnhiIGfpbwBrSNTJpt/wsdwitFPk7ezThR7cjmHG2gx1HTob4qMbl17eXy6Ntwq4p5sw3VBmLwZYQ1WVm/pCjad83/BJeoWVGipD+VaLskmIh1l8dQs3hKGp0ck/G7Pq5pynKmF+/1YoZCgEgoTP94g3UsORYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9aFuRz2J36ROQfNBkzw7Iq5hScrlK1gBCyzwgOrp1g=;
 b=ZqgZw1htmiM9v4YK4AjXAQMb4C32XpkQsLfgIne/r0y1cowOidOkPqhDeqk3sjeUsTa42Pr4HxR/UsYnaNQ5m0zIUfcxH34Lt0Z0Kuym3vNCWmbzvDAf2pzBLxHn57TB5MkwQh4qCPTJ8COKMbR+e+41RdKINjvY25Azow188Vc=
Received: from DS7PR03CA0089.namprd03.prod.outlook.com (2603:10b6:5:3bb::34)
 by CY8PR12MB7588.namprd12.prod.outlook.com (2603:10b6:930:9b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 12:36:35 +0000
Received: from DM6NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::3f) by DS7PR03CA0089.outlook.office365.com
 (2603:10b6:5:3bb::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24 via Frontend
 Transport; Thu, 6 Jul 2023 12:36:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT074.mail.protection.outlook.com (10.13.173.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Thu, 6 Jul 2023 12:36:34 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 6 Jul
 2023 07:36:33 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 05/10] drm/amdgpu: create context space for usermode queue
Date: Thu, 6 Jul 2023 14:35:57 +0200
Message-ID: <20230706123602.2331-6-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230706123602.2331-1-shashank.sharma@amd.com>
References: <20230706123602.2331-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT074:EE_|CY8PR12MB7588:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c4b7787-4f41-4744-6085-08db7e1da276
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QJckKgw7WsIQv9Fc9UWzYqvS8CnxdGi2YsStDbrtYq8LvAmy0CcRCJosJZL7/iy5BBBSsBfdqzSKs3LnA6RlloabCrYMhsKrbzIoDVOoOrGDLOHtbhTe+mTE5NEmxEhp2qJ5/Cdeh+aBib4LEErFS4apusY7whTiY/G55z0zWdwwQQ31q5CC4EA07w1f45GrSa0OorIFu+GRocNRu8m0VlZFAGD8RXDFb+ZKVrE4ZM7fGMtrA+TWn0B5TnDftq56ffQtpipRMKJEB6awGKt8VZeLftkhCSWeo804PpJ8WEvUs1gAeszGSKlZF5oX/BhcZypa8kTbDv7yx/ml1g/z3Prd196p693G9xkW0HmJmlz9jVfQN26NW6D00SXY2MuvoX6R335g2JqpNyBWml7XuY7fMAAgIVsAzLQBBDli0HT/E9Ca7wIVq/Xd7k7omEVu1VOpx3ZLJAE+/xNU/XURcDqCTMaVz3joArUlOv5ugcIx+BR27xQaDmrMsqvXtTPcS/J/7+WwU7q/DZ+cyt+LpCY0Zq4uJv4J7cxFnbKc193l9izQFHqjqVUvnEcQmIo+EGcedkxOl8NWo9QyYJBbKbKDJtVnjj9SymmxXfjFmxSKBkUe1Lp+zGhHd8LnkbgdxryoWgzFqWoQsVTm334k7Pm64U8/T7rE1CQpZVq8WVxAeOKNZ7brqAVfbwzEMJSrNM+dYRSqjjBdW9uD9kjqnaiou/PVNCmDHbf22IBaLFsJA/jWAZi6Y3zCU85J6IS6UHMwX2s1WdQfuPL1DNJnrg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199021)(40470700004)(36840700001)(46966006)(70586007)(2906002)(82310400005)(44832011)(5660300002)(336012)(2616005)(36860700001)(86362001)(40480700001)(36756003)(8676002)(8936002)(478600001)(1076003)(6666004)(7696005)(19627235002)(26005)(186003)(16526019)(356005)(81166007)(54906003)(40460700003)(47076005)(426003)(83380400001)(82740400003)(4326008)(6916009)(70206006)(316002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 12:36:34.7250 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4b7787-4f41-4744-6085-08db7e1da276
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7588
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The FW expects us to allocate at least one page as context
space to process gang, process, GDS and FW  related work.
This patch creates a joint object for the same, and calculates
GPU space offsets for each of these spaces.

V1: Addressed review comments on RFC patch:
    Alex: Make this function IP specific

V2: Addressed review comments from Christian
    - Allocate only one object for total FW space, and calculate
      offsets for each of these objects.

V3: Integration with doorbell manager

V4: Review comments:
    - Remove shadow from FW space list from cover letter (Alex)
    - Alignment of macro (Luben)

V5: Merged patches 5 and 6 into this single patch
    Addressed review comments:
    - Use lower_32_bits instead of mask (Christian)
    - gfx_v11_0 instead of gfx_v11 in function names (Alex)
    - Shadow and GDS objects are now coming from userspace (Christian,
      Alex)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 62 +++++++++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  4 ++
 2 files changed, 66 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index e76e1b86b434..7d3b19e08bbb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -61,6 +61,9 @@
 #define regCGTT_WD_CLK_CTRL_BASE_IDX	1
 #define regRLC_RLCS_BOOTLOAD_STATUS_gc_11_0_1	0x4e7e
 #define regRLC_RLCS_BOOTLOAD_STATUS_gc_11_0_1_BASE_IDX	1
+#define AMDGPU_USERQ_PROC_CTX_SZ   PAGE_SIZE
+#define AMDGPU_USERQ_GANG_CTX_SZ   PAGE_SIZE
+#define AMDGPU_USERQ_FW_CTX_SZ     PAGE_SIZE
 
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_pfp.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_me.bin");
@@ -6488,6 +6491,57 @@ const struct amdgpu_ip_block_version gfx_v11_0_ip_block =
 	.funcs = &gfx_v11_0_ip_funcs,
 };
 
+static void gfx_v11_0_userq_destroy_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
+					      struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
+
+	amdgpu_bo_free_kernel(&ctx->obj, &ctx->gpu_addr, &ctx->cpu_ptr);
+}
+
+static int gfx_v11_0_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
+					    struct amdgpu_usermode_queue *queue,
+					    struct drm_amdgpu_userq_mqd_gfx_v11_0 *mqd_user)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
+	struct v11_gfx_mqd *mqd = queue->mqd.cpu_ptr;
+	int r, size;
+
+	/*
+	 * The FW expects at least one page space allocated for
+	 * process ctx, gang ctx and fw ctx each. Create an object
+	 * for the same.
+	 */
+	size = AMDGPU_USERQ_PROC_CTX_SZ + AMDGPU_USERQ_FW_CTX_SZ +
+	       AMDGPU_USERQ_GANG_CTX_SZ;
+	r = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_GTT,
+				    &ctx->obj,
+				    &ctx->gpu_addr,
+				    &ctx->cpu_ptr);
+	if (r) {
+		DRM_ERROR("Failed to allocate ctx space bo for userqueue, err:%d\n", r);
+		return r;
+	}
+
+	queue->proc_ctx_gpu_addr = ctx->gpu_addr;
+	queue->gang_ctx_gpu_addr = queue->proc_ctx_gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
+	queue->fw_ctx_gpu_addr = queue->gang_ctx_gpu_addr + AMDGPU_USERQ_GANG_CTX_SZ;
+
+	mqd->fw_work_area_base_lo = lower_32_bits(queue->fw_ctx_gpu_addr);
+	mqd->fw_work_area_base_lo = upper_32_bits(queue->fw_ctx_gpu_addr);
+
+	/* Shadow and GDS objects come directly from userspace */
+	mqd->shadow_base_lo = lower_32_bits(mqd_user->shadow_va);
+	mqd->shadow_base_hi = upper_32_bits(mqd_user->shadow_va);
+
+	mqd->gds_bkup_base_lo = lower_32_bits(mqd_user->gds_va);
+	mqd->gds_bkup_base_hi = upper_32_bits(mqd_user->gds_va);
+
+	return 0;
+}
+
 static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 				      struct drm_amdgpu_userq_in *args_in,
 				      struct amdgpu_usermode_queue *queue)
@@ -6540,6 +6594,13 @@ static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		goto free_mqd;
 	}
 
+	/* Create BO for FW operations */
+	r = gfx_v11_0_userq_create_ctx_space(uq_mgr, queue, &mqd_user);
+	if (r) {
+		DRM_ERROR("Failed to allocate BO for userqueue (%d)", r);
+		goto free_mqd;
+	}
+
 	return 0;
 
 free_mqd:
@@ -6552,6 +6613,7 @@ gfx_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_userm
 {
 	struct amdgpu_userq_obj *mqd = &queue->mqd;
 
+	gfx_v11_0_userq_destroy_ctx_space(uq_mgr, queue);
 	amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
 }
 
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index 240f92796f00..a5cdb319193d 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -40,10 +40,14 @@ struct amdgpu_usermode_queue {
 	uint64_t		doorbell_handle;
 	uint64_t		doorbell_index;
 	uint64_t		flags;
+	uint64_t		proc_ctx_gpu_addr;
+	uint64_t		gang_ctx_gpu_addr;
+	uint64_t		fw_ctx_gpu_addr;
 	struct amdgpu_mqd_prop	*userq_prop;
 	struct amdgpu_userq_mgr *userq_mgr;
 	struct amdgpu_vm	*vm;
 	struct amdgpu_userq_obj mqd;
+	struct amdgpu_userq_obj fw_obj;
 };
 
 struct amdgpu_userq_funcs {
-- 
2.40.1

