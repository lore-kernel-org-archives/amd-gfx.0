Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE2DC433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 30 Apr 2022 15:14:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C410910E873;
	Sat, 30 Apr 2022 15:14:56 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A4DF10E873
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 Apr 2022 15:14:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNBfaSILHXGlKOuyyKX1QmshO5wZuJUG50XsvRLb6qPWl5LqShlv4c9Mitx9pH6Tpo/xlgSpxH+JyJ/EBO0mbN1+aGdWXqlZ7VWhJWgGuba+FT3PiaT39kVFGTqAWhe0UOAR4R6dz0R6J9MCsuZePU1qhOg7N7Qb1GJ6CrbfYP+WArgcdd2Gn4+EzaIY0Jy0wSOTNbL+GhQ/Iv+05QUM6Ic01HYriuBnSpLCSg9v/q7wWw0jEzoIxLiThZ1J8rwZ6VSojmNlGOdWD3NwNPD+QFrg7/AWyCWspi28Zlzua1+zx8Kdq8OamLt4SoawQu3J/wzqHjrcM6sRXIOXhGqY3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLpMByfTi4krL3zQyMFHE4NTyW+8I8fotHw5XQksHXw=;
 b=VfW2ASBnSGqeY0/H06121mLhAJCPruP2sCOQNuJtXIHCdGdrqURbiefx8u1uUyjli2odEnXWnz7Ms1DvBwul8GJVUXH7DMBgwo2tCqh0XRDaA1vrtflso1ve2LcpRip6gCJido3PrzTFV6jlTcyjzzudOSrO+XSHFTAUV/a/1/G/KgVUmzHIJ5elq+Pdjw5/7owPQa0rW3SuBYXIkMIXvoP3wWe5P+WVa07MMcie//lM1jzdi7g/pnzsrAUbUYM4ipH11vO15W9yvaja2thxjXvqrsYVWVIoCMYGagPTruIUn/lSdCAPt2sc+rRhzaO7Y6Xcyfq8RlV6lbx08MFvmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLpMByfTi4krL3zQyMFHE4NTyW+8I8fotHw5XQksHXw=;
 b=pn0nz4vdXFs0H7/T+NvDK1dWt+IWSf2JJ7pBDfWA6YT4VDO1qO4lS2yuIHZ/IZKq0fS8eA18+xVApPJ/AcjNDDcy4qidTe18WpoMHNJoMihJ9PzVYIzOBSRdobsRVoe83ODI2+b3aXkD6Es4lMxZbxFNtUzn/RXeVhG+r/33lyY=
Received: from MW4P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::18)
 by DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Sat, 30 Apr
 2022 15:14:52 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::14) by MW4P222CA0013.outlook.office365.com
 (2603:10b6:303:114::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Sat, 30 Apr 2022 15:14:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Sat, 30 Apr 2022 15:14:51 +0000
Received: from rmb-Lilac-RMB.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 30 Apr
 2022 10:14:48 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add out parameters to drm_amdgpu_sched
Date: Sat, 30 Apr 2022 08:14:28 -0700
Message-ID: <20220430151428.237089-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c005a7c8-52fd-4cbb-82c4-08da2abc2ca4
X-MS-TrafficTypeDiagnostic: DM6PR12MB3529:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3529782A12D066C7ABEF9F9DE4FF9@DM6PR12MB3529.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Err0Ixzd1+zZxMQ2VQHU6lvQXds0S5ls+c65mJ9t7Vdx9TmmpQqxn4fiV0XbQ7qlLQIgLRDBEA8djQwoEsQ7o5LftmVUsX+lZq1+fPY6K5qsoUkNDn1C5CgrzuntQrATzpePxp15CzFrnlKNHE6iQMbOvWDLeiLEvSBAFP3cxiHLEs+QoOevIGQMWyixP24GX3TCCm/f+AifZNHaAMWaPuBQfa9N1DpeyIHQkxE9ZRz5QMl3cZE6nD55e724Wg5te7cAvEcZ8oncGEizswKjWMkOtLtaTlCSlCBjES6yXyJi4S2TdG9Z8ca6DlIy9CWTFNFCrfgajf4rZjeBSV+CcLLVSSkbocr5fOdy17y9UpcFUqXJ7N68jChbZla4KVrNdn7Dejvw+eAWPRGAZ9Dd6H/hhpwv5GxphhaPna0OgWuoyI6ctEDCuBgoYw6AOsTTDbrOBrd0NYD0XMwD0zRrItDdb+6ax19fL54MaCodiNQ2SzW0EtVC12N5A2ZluTSw2HejP6MFUMx0gm1CEdQJ6Crnm9VzL73oBidlmhlLC9c0DN5NOvXUw2B0/5mgcHDjtg75Zi484sg3SMCA0Fh8i0HrbBczyaBXP4GCDgraOw/Uj5XxG7kgMpeAyHjS+sryZwm1L+mWV72njGy66E9My7dptMmf6tOZa+Mzwa5VnRVqR2vNrpLvjH8xRfEnyc1pu7HHtZn/UvIqpqokJGMuBg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36756003)(70586007)(70206006)(5660300002)(83380400001)(36860700001)(336012)(186003)(47076005)(26005)(86362001)(426003)(1076003)(2616005)(16526019)(2906002)(6666004)(7696005)(54906003)(966005)(508600001)(40460700003)(356005)(6916009)(316002)(8676002)(82310400005)(4326008)(81166007)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2022 15:14:51.3950 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c005a7c8-52fd-4cbb-82c4-08da2abc2ca4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3529
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

- Add pipe and queue as out parameters to support high priority
  queue test enabled in libdrm basic test suite.

- Fetch amdgpu_ring pointer and pass sched info to userspace

- Improve amdgpu_sched_ioctl() function

The related merge request for enabling high priority test case are
libdrm - https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/235
mesa - https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/16262

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c | 114 ++++++++--------------
 include/uapi/drm/amdgpu_drm.h             |  14 ++-
 2 files changed, 53 insertions(+), 75 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
index e9b45089a28a..fc2864b612d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
@@ -32,106 +32,72 @@
 #include "amdgpu_sched.h"
 #include "amdgpu_vm.h"
 
-static int amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
-						  int fd,
-						  int32_t priority)
+int amdgpu_sched_ioctl(struct drm_device *dev, void *data,
+		       struct drm_file *filp)
 {
-	struct fd f = fdget(fd);
+	union drm_amdgpu_sched *args = data;
+	struct amdgpu_ctx *ctx, *ctx_ptr;
+	struct drm_sched_entity *entity;
 	struct amdgpu_fpriv *fpriv;
-	struct amdgpu_ctx *ctx;
-	uint32_t id;
-	int r;
-
-	if (!f.file)
-		return -EINVAL;
-
-	r = amdgpu_file_to_fpriv(f.file, &fpriv);
-	if (r) {
-		fdput(f);
-		return r;
-	}
-
-	idr_for_each_entry(&fpriv->ctx_mgr.ctx_handles, ctx, id)
-		amdgpu_ctx_priority_override(ctx, priority);
-
-	fdput(f);
-	return 0;
-}
-
-static int amdgpu_sched_context_priority_override(struct amdgpu_device *adev,
-						  int fd,
-						  unsigned ctx_id,
-						  int32_t priority)
-{
+	struct amdgpu_ring *ring;
+	u32 fd = args->in.fd;
 	struct fd f = fdget(fd);
-	struct amdgpu_fpriv *fpriv;
-	struct amdgpu_ctx *ctx;
+	u32 id;
 	int r;
 
 	if (!f.file)
 		return -EINVAL;
 
 	r = amdgpu_file_to_fpriv(f.file, &fpriv);
-	if (r) {
-		fdput(f);
-		return r;
-	}
+	if (r)
+		goto out_fd;
 
-	ctx = amdgpu_ctx_get(fpriv, ctx_id);
+	ctx = amdgpu_ctx_get(fpriv, args->in.ctx_id);
 
 	if (!ctx) {
-		fdput(f);
-		return -EINVAL;
-	}
-
-	amdgpu_ctx_priority_override(ctx, priority);
-	amdgpu_ctx_put(ctx);
-	fdput(f);
-
-	return 0;
-}
-
-int amdgpu_sched_ioctl(struct drm_device *dev, void *data,
-		       struct drm_file *filp)
-{
-	union drm_amdgpu_sched *args = data;
-	struct amdgpu_device *adev = drm_to_adev(dev);
-	int r;
-
-	/* First check the op, then the op's argument.
-	 */
-	switch (args->in.op) {
-	case AMDGPU_SCHED_OP_PROCESS_PRIORITY_OVERRIDE:
-	case AMDGPU_SCHED_OP_CONTEXT_PRIORITY_OVERRIDE:
-		break;
-	default:
-		DRM_ERROR("Invalid sched op specified: %d\n", args->in.op);
-		return -EINVAL;
+		r = -EINVAL;
+		goto out_fd;
 	}
 
 	if (!amdgpu_ctx_priority_is_valid(args->in.priority)) {
 		WARN(1, "Invalid context priority %d\n", args->in.priority);
-		return -EINVAL;
+		r = -EINVAL;
+		goto out_ctx;
 	}
 
 	switch (args->in.op) {
 	case AMDGPU_SCHED_OP_PROCESS_PRIORITY_OVERRIDE:
-		r = amdgpu_sched_process_priority_override(adev,
-							   args->in.fd,
-							   args->in.priority);
+		/* Retrieve all ctx handles and override priority  */
+		idr_for_each_entry(&fpriv->ctx_mgr.ctx_handles, ctx_ptr, id)
+			amdgpu_ctx_priority_override(ctx_ptr, args->in.priority);
 		break;
 	case AMDGPU_SCHED_OP_CONTEXT_PRIORITY_OVERRIDE:
-		r = amdgpu_sched_context_priority_override(adev,
-							   args->in.fd,
-							   args->in.ctx_id,
-							   args->in.priority);
+		/* Override priority for a given context */
+		amdgpu_ctx_priority_override(ctx, args->in.priority);
 		break;
 	default:
-		/* Impossible.
-		 */
+		DRM_ERROR("Invalid sched op specified: %d\n", args->in.op);
 		r = -EINVAL;
-		break;
+		goto out_ctx;
 	}
 
+	r = amdgpu_ctx_get_entity(ctx, args->in.ip_type, 0, args->in.ring,
+				  &entity);
+	if (r)
+		goto out_ctx;
+
+	/* Fetch amdgpu_ring pointer */
+	ring = to_amdgpu_ring(entity->rq->sched);
+
+	/* Pass sched info to userspace */
+	memset(args, 0, sizeof(*args));
+	args->out.info.pipe = ring->pipe;
+	args->out.info.queue = ring->queue;
+
+out_ctx:
+	amdgpu_ctx_put(ctx);
+out_fd:
+	fdput(f);
+
 	return r;
 }
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 1d65c1fbc4ec..e93f1b6c4561 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -70,7 +70,7 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_WAIT_FENCES	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_WAIT_FENCES, union drm_amdgpu_wait_fences)
 #define DRM_IOCTL_AMDGPU_VM		DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_VM, union drm_amdgpu_vm)
 #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FENCE_TO_HANDLE, union drm_amdgpu_fence_to_handle)
-#define DRM_IOCTL_AMDGPU_SCHED		DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
+#define DRM_IOCTL_AMDGPU_SCHED		DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
 
 /**
  * DOC: memory domains
@@ -308,6 +308,11 @@ union drm_amdgpu_vm {
 #define AMDGPU_SCHED_OP_PROCESS_PRIORITY_OVERRIDE	1
 #define AMDGPU_SCHED_OP_CONTEXT_PRIORITY_OVERRIDE	2
 
+struct drm_amdgpu_sched_info {
+	__u32 pipe;
+	__u32 queue;
+};
+
 struct drm_amdgpu_sched_in {
 	/* AMDGPU_SCHED_OP_* */
 	__u32	op;
@@ -315,10 +320,17 @@ struct drm_amdgpu_sched_in {
 	/** AMDGPU_CTX_PRIORITY_* */
 	__s32	priority;
 	__u32   ctx_id;
+	__u32   ip_type;
+	__u32   ring;
+};
+
+struct drm_amdgpu_sched_out {
+	struct drm_amdgpu_sched_info info;
 };
 
 union drm_amdgpu_sched {
 	struct drm_amdgpu_sched_in in;
+	struct drm_amdgpu_sched_out out;
 };
 
 /*
-- 
2.25.1

