Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B836BEE8015
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Sep 2023 16:06:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43E9F10E90F;
	Fri,  8 Sep 2023 16:06:19 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::611])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DB8A10E90F
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Sep 2023 16:06:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gpD8R/rA6tUGaVVqIZasx/H0mI6Tv3Kk+6pVj4eGJPAVS12kj+Z2yg+RIMka0Mz2/9lEHhX7NKz1avZdqjcYB1PFSP2wfK409GQ3eLdeHtYDbzkPXH3O9jExOyVRvhoUVgXXvdljq5uTegZ4sFGaPviwIyayAEgc/1ozhsGSbM/9bTELOur7ZT370g5guVtRvd6DM1qne8ydAlz/W/oZZf8bZDA5Tx2SLOaJNfcDBwbsxLKvqcAue6xU+wp+Z58rgDctElkO7+CJkg0rPRnKzvT/B8Cs54rxzNOZ7WETv1gvxmE8XRjQSzxHURe20udaoBmLgg8OQaJOXV4Fa0tjRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wf/HZ/Lr2rrelBpVV7xPt5mlKcH298RiXDH7N8C0coQ=;
 b=Wb5yAdJcSgTwntvWVX4nFuK0UnOhwdlorgJi/m+CPymuG4vGimw497YdQGLFTxJezNEU2tX3Ps99uyRFmpJCmtROcsf41JfHZkdLNMPVKt8bRHdqLTm8WUQqbbJIdOPsiwcJLCw//wl7bNvKqKFEZzQit6cCEyJhQ9KDYLqdY/LHB4jUosCxDPVVzPH+iSFOpG+B735gln1O1HooFIz+tc0rxepozNZWWKBvd+8AyxPRoSv8jxowuIPFjDxi6BEv3Y1k2JDKYmUTaXMPxzC020Y/Bw7d1f6GHmBHoscSfr6UVfww38CU3c2VApwHN1Ax5NNJEpskaSziyvQjBnnYlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wf/HZ/Lr2rrelBpVV7xPt5mlKcH298RiXDH7N8C0coQ=;
 b=VxrK4hthDWquxbgVpq8GLogSHfPQnh57I6Dzf1R0tzTqCzHSoGeCWQul6y502s1bTEQaG42NGt2l+FAFwWPPjVyxrIzosS/avOJhPgTu6k9i17tDnQ53VFUjDo1R3fnfp52btTq1khL+0y1vt6i+O3Ag4M+GWqaXePg5O9xz1Aw=
Received: from CH0P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::18)
 by IA0PR12MB8205.namprd12.prod.outlook.com (2603:10b6:208:400::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 16:06:14 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::ca) by CH0P221CA0016.outlook.office365.com
 (2603:10b6:610:11c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31 via Frontend
 Transport; Fri, 8 Sep 2023 16:06:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.11 via Frontend Transport; Fri, 8 Sep 2023 16:06:13 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 8 Sep
 2023 11:06:12 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v6 5/9] drm/amdgpu: create context space for usermode queue
Date: Fri, 8 Sep 2023 18:04:42 +0200
Message-ID: <20230908160446.2188-6-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230908160446.2188-1-shashank.sharma@amd.com>
References: <20230908160446.2188-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|IA0PR12MB8205:EE_
X-MS-Office365-Filtering-Correlation-Id: bf8d9ef6-2880-4780-3601-08dbb08586b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FdgZyxlPJbjtJ0pymmFhbtA086PuyAjWBOs4xKgadibm+Tl6enqk9+IZxldoxTwMPcUy8/tVQOIYLrwgVbJ4Qkc5rzkg7MIhFtrt6uMk5Si6tzMm5E/xk8btn6IajqA24pipUW406Ki7ArBa/o0wrdADGxaEtS9F5AjO7++xG3WGg/Q14TKJZrnhwUdpiHNZGJ2ou9v7+qaSaHEHW6heAA4ycSDeS1cW6DXXDsNF8Ebjv5pC00YS6+53461rFNmhE8HL3eExJm6Vfhmx5XIlKj+6nWH8aCo7Q1hX+puwPTvp2loQfPoRsRo09jUFo47wosvGf+Ed89gbykSxxnR2insXCM5MObtiuQGYtSDNQMwLIZ8S+OMvzOlkyJ7PK0jO25gi56mWgFbIgPRQ1+slC6HSoULf/0ZfUANpId06PHq5HbU2j+0SZbba1fbe8mW58xQVG2gwTLEjq9dBp6CBps9EMbMdSss0tptfEcx8t5N0UU/fENhumKoEQwrxF6omxuJ3K9XRboplRyi5CsbuEE9Lh/ipnN4418FIsKhastghhQ8on4inq+b0CgiNHHkArngmHFA+C/gTJ42iO00w3B1dIOWwTwK62oWsyCuLcgZWAxB1Du+B64YDJUli3q4ZSZB9R+iM46WOsx4Eau3Nl/H8sEINIrQ/ypR3vDkhfeiesDgkLq2bkTkIRTNlGbuv8T1muZWy4G1zmzz5CVYUSN8G/EZLXUxcVQF/b8P7UAyWMAx86Do5x2E+XgOrLnwR3Au4+KIDZyeHL6ny7dxpgg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(186009)(1800799009)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(4326008)(8676002)(8936002)(316002)(6916009)(70586007)(36756003)(70206006)(54906003)(44832011)(5660300002)(40460700003)(41300700001)(36860700001)(16526019)(47076005)(26005)(1076003)(7696005)(40480700001)(336012)(426003)(356005)(82740400003)(6666004)(81166007)(2616005)(83380400001)(2906002)(19627235002)(86362001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 16:06:13.9306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf8d9ef6-2880-4780-3601-08dbb08586b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8205
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
GPU space offsets of these spaces.

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

V6:
    - Add a comment to replace amdgpu_bo_create_kernel() with
      amdgpu_bo_create() during fw_ctx object creation (Christian).
    - Move proc_ctx_gpu_addr, gang_ctx_gpu_addr and fw_ctx_gpu_addr out
      of generic queue structure and make it gen11 specific (Alex).

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 61 +++++++++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  1 +
 2 files changed, 62 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 6760abda08df..8ffb5dee72a9 100644
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
@@ -6424,6 +6427,56 @@ const struct amdgpu_ip_block_version gfx_v11_0_ip_block =
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
+	uint64_t fw_ctx_gpu_addr;
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
+	fw_ctx_gpu_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ +
+			  AMDGPU_USERQ_GANG_CTX_SZ;
+	mqd->fw_work_area_base_lo = lower_32_bits(fw_ctx_gpu_addr);
+	mqd->fw_work_area_base_lo = upper_32_bits(fw_ctx_gpu_addr);
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
@@ -6480,6 +6533,13 @@ static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
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
@@ -6492,6 +6552,7 @@ gfx_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_userm
 {
 	struct amdgpu_userq_obj *mqd = &queue->mqd;
 
+	gfx_v11_0_userq_destroy_ctx_space(uq_mgr, queue);
 	amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
 }
 
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index 240f92796f00..34e20daa06c8 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -44,6 +44,7 @@ struct amdgpu_usermode_queue {
 	struct amdgpu_userq_mgr *userq_mgr;
 	struct amdgpu_vm	*vm;
 	struct amdgpu_userq_obj mqd;
+	struct amdgpu_userq_obj fw_obj;
 };
 
 struct amdgpu_userq_funcs {
-- 
2.42.0

