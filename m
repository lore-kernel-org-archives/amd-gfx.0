Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD72C7618E
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Apr 2023 17:39:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65F1A10E1C1;
	Mon, 24 Apr 2023 17:39:17 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::618])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0AC310E119
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Apr 2023 17:39:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTOQ+nLq3sirg5jIHByu+YmYjtPH0P/ufY6Ya7Wu0GapgDLS31l/eMBg0YLn+C8l06OjS71AJgyYTq+BU+EWLAdTIVVCjncCH/6Cqoy5HcEdmAHela0VmmQfM03iIl4/ODkcfmgK6Euy6Lj8vL7A8SUQ1+D1qdaGWgB2IYvQFqWZjCG8EDEf9uf9GcHaOh9g0MFX2zsBCElulVwkK+dbxAB6POuLVGUT1R/4PweXgL4HPCrQ1ZrkiU2GpkzXii3qp4+9Xxd/RAAT2cd00QsIFeHiSl3f83rSHmevKiBBoL/aLc/T0QhOUWI8v3uUWAPS1fCvI5p+0Bbkp6/510IM0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlOfG4ebDaB6ZhmGdOr9m0R8PgWIvsDt8j/C0tDOvpU=;
 b=N1e0pJAbREVxJzrVNJ9SILSGSXfn/53dqtacD+WFr9tL+OCpn+8+kZiOIVVfBBiEU5tspeuxa+5jn62vjBV6I8cNk4UjB2QwkuRxdYMhhrxqLf8ck1jE/QfveamXIzq4tpVt0ND4BGPaFi9OKOmLWf/e6dG83N80mD03PLiDp1XU2NCHM44mTH6D4rMHEHCUsekZpgnExipd+0DFpjhaj+2oeWeKVChCAYZqsFSh/j8jvFMpUEehBFetMWKcwNIL19ZAm4Yw5+Br0NqLhqs55PWaF4oZ5IQsw52/LRe0UdEQqPt+Z7Yqks++5H+JySKKSjgrYNcydcciv6nFaniStA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlOfG4ebDaB6ZhmGdOr9m0R8PgWIvsDt8j/C0tDOvpU=;
 b=lA1llAjb55G2ItSGtsU94EzCJ5G+zofqB6A2mEGRJvaTUjwNMIVcR4HsqYAtsZ/i0acZLBNac3ls235jZhbc+OBvtVL1oF0vmEgmIyGZ1V1UmagRP/Jj1FBr/09dMbrHi6YgdV51DgQ1r6PFP7IOire9o0J5H2jqlo1rDgEtxcg=
Received: from MW4PR03CA0003.namprd03.prod.outlook.com (2603:10b6:303:8f::8)
 by DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.33; Mon, 24 Apr 2023 17:39:13 +0000
Received: from CO1NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::ab) by MW4PR03CA0003.outlook.office365.com
 (2603:10b6:303:8f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33 via Frontend
 Transport; Mon, 24 Apr 2023 17:39:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT100.mail.protection.outlook.com (10.13.175.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.19 via Frontend Transport; Mon, 24 Apr 2023 17:39:13 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 24 Apr
 2023 12:39:10 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 05/10] drm/amdgpu: create context space for usermode queue
Date: Mon, 24 Apr 2023 19:38:30 +0200
Message-ID: <20230424173836.1441-6-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230424173836.1441-1-shashank.sharma@amd.com>
References: <20230424173836.1441-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT100:EE_|DS0PR12MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: e5177e21-fb8d-43da-7d36-08db44ead194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jPOiLS+8nug+n2RERA9D7R8HLbrWQk90EWDnI3Fkmpy7mD3BhToAXVAWt5u+05AcJu2alvkPhd8ha92N1exsbovoK1+L8ZmDDtm3SVWslswMbQcpu4IeuNQgIr1w5yEgFFJ++krUAg5ILFiZ2gCJTCgQzqUGTZqd7T5RZOzitaiSDEqJqc+6X/gXQbaCuCqO/ZdsD5otawQ1/uxvy0G28JfFj27AMZzmFvXrM7DsgWCIr7V05zTPFooAHeyZxptLR0JqKYCeFPYtFoUusxfVax69k+Uo7JSZXsIYFFOuCTaeUStDBWoXn96Attr3uSUC3q/FWxMkjxxips4bMTbNygfEUml4RLeMfZmLepFbRJIu/0VebpU26rMT3Py+8eLCQJ90n2z8m+E+0Oc7iE//CkBszZVEHnRZTXMy7aaw5hY67ond5GvL0K1rfuLK0A2hplwA06DOpGWkrTvZGbfsJcKteIlaDselpJZ7B3NBVY3hfZVaDtadynNYtluhnTerUFa7qciVzdhXkEr7kZuwUiLBqOOEnATgyD9exu0gSBPSxbm+UyDI5myQ2WyU0v8+M78u/C5dbiCZ2XnYlC3op8kQKnjEWwrry0tjIs1OhxljxkpHIOenMdpxHazLeqvUW3nOsthKvBNp59LqHukLfPtrsb2Ik6m0bi4+nQiSsuV5rpQpQw80T68mZyl+n65+mz4DNbPQS+qzlqOHdoAwuOrO9MGgG5BcTL29D7cjDTY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199021)(36840700001)(46966006)(40470700004)(356005)(82740400003)(81166007)(54906003)(7696005)(2616005)(47076005)(336012)(83380400001)(426003)(40480700001)(1076003)(36756003)(36860700001)(26005)(186003)(16526019)(40460700003)(82310400005)(478600001)(6666004)(8936002)(8676002)(41300700001)(6916009)(70206006)(70586007)(4326008)(316002)(2906002)(44832011)(86362001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 17:39:13.0387 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5177e21-fb8d-43da-7d36-08db44ead194
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6559
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
Cc: pierre-eric.pelloux-prayer@amd.com,
 Shashank Sharma <shashank.sharma@amd.com>, arvind.yadav@amd.com,
 Alex Deucher <alexander.deucher@amd.com>, contactshashanksharma@gmail.com,
 Christian Koenig <christian.koenig@amd.com>
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

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 57 ++++++++++++++++++-
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  6 ++
 2 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 9f7b14966ac8..f6b33faea86f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -53,6 +53,11 @@
 #define GFX11_NUM_GFX_RINGS		1
 #define GFX11_MEC_HPD_SIZE	2048
 
+#define AMDGPU_USERQ_PROC_CTX_SZ   PAGE_SIZE
+#define AMDGPU_USERQ_GANG_CTX_SZ   PAGE_SIZE
+#define AMDGPU_USERQ_FW_CTX_SZ     PAGE_SIZE
+#define AMDGPU_USERQ_GDS_CTX_SZ    PAGE_SIZE
+
 #define RLCG_UCODE_LOADING_START_ADDRESS	0x00002000L
 #define RLC_PG_DELAY_3_DEFAULT_GC_11_0_1	0x1388
 
@@ -6406,6 +6411,44 @@ const struct amdgpu_ip_block_version gfx_v11_0_ip_block =
 	.funcs = &gfx_v11_0_ip_funcs,
 };
 
+static int gfx_v11_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
+					  struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct amdgpu_userq_ctx_space *ctx = &queue->fw_space;
+	int r, size;
+
+	/*
+	 * The FW expects at least one page space allocated for
+	 * process ctx, gang ctx, gds ctx, fw ctx each.
+	 */
+	size = AMDGPU_USERQ_PROC_CTX_SZ + AMDGPU_USERQ_FW_CTX_SZ +
+	       AMDGPU_USERQ_GANG_CTX_SZ + AMDGPU_USERQ_GDS_CTX_SZ;
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
+	queue->gds_ctx_gpu_addr = queue->fw_ctx_gpu_addr + AMDGPU_USERQ_FW_CTX_SZ;
+	return 0;
+}
+
+static void gfx_v11_userq_destroy_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
+					    struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_userq_ctx_space *ctx = &queue->fw_space;
+
+	amdgpu_bo_free_kernel(&ctx->obj, &ctx->gpu_addr, &ctx->cpu_ptr);
+}
+
 static int
 gfx_v11_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
 {
@@ -6426,10 +6469,16 @@ gfx_v11_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode
 	}
 
 	memset(mqd->cpu_ptr, 0, size);
+	r = gfx_v11_userq_create_ctx_space(uq_mgr, queue);
+	if (r) {
+		DRM_ERROR("Failed to create CTX space for userqueue (%d)\n", r);
+		goto free_mqd;
+	}
+
 	r = amdgpu_bo_reserve(mqd->obj, false);
 	if (unlikely(r != 0)) {
 		DRM_ERROR("Failed to reserve mqd for userqueue (%d)", r);
-		goto free_mqd;
+		goto free_ctx;
 	}
 
 	queue->userq_prop.use_doorbell = true;
@@ -6438,12 +6487,15 @@ gfx_v11_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode
 	amdgpu_bo_unreserve(mqd->obj);
 	if (r) {
 		DRM_ERROR("Failed to init MQD for queue\n");
-		goto free_mqd;
+		goto free_ctx;
 	}
 
 	DRM_DEBUG_DRIVER("MQD for queue %d created\n", queue->queue_id);
 	return 0;
 
+free_ctx:
+	gfx_v11_userq_destroy_ctx_space(uq_mgr, queue);
+
 free_mqd:
 	amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
 	return r;
@@ -6454,6 +6506,7 @@ gfx_v11_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermod
 {
 	struct amdgpu_userq_ctx_space *mqd = &queue->mqd;
 
+	gfx_v11_userq_destroy_ctx_space(uq_mgr, queue);
 	amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
 }
 
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index e7da27918bd2..11e8ad649f6e 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -38,11 +38,17 @@ struct amdgpu_usermode_queue {
 	int			queue_id;
 	int			queue_type;
 	uint64_t		doorbell_handle;
+	uint64_t		proc_ctx_gpu_addr;
+	uint64_t		gang_ctx_gpu_addr;
+	uint64_t		gds_ctx_gpu_addr;
+	uint64_t		fw_ctx_gpu_addr;
+	uint64_t		shadow_ctx_gpu_addr;
 	uint64_t		flags;
 	struct amdgpu_mqd_prop	userq_prop;
 	struct amdgpu_userq_mgr *userq_mgr;
 	struct amdgpu_vm	*vm;
 	struct amdgpu_userq_ctx_space mqd;
+	struct amdgpu_userq_ctx_space fw_space;
 };
 
 struct amdgpu_userq_funcs {
-- 
2.40.0

