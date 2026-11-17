Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C99606A329
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 14:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Vvza4MP7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7335F10F772;
	Tue, 17 Nov 2026 14:17:29 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011043.outbound.protection.outlook.com [52.101.52.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A1F110F770
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 14:17:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBmcqTlGgseTq0+jidzLZPwBgncYi4DV74OIdEnBmGwRh8SIgkJh/XSndKFTUq5EaljfKPdiIgsFdhUCrHpJsaFx8WNso2Po+ZDlxNMCbwAWKpE3jsV0EOeb/MDB2EB6ohYRMBVmbJsvJzrXQr4LoO3BSJju9HpPCZQy2799j9/bUWbfayHp+ESCDMkKG/whz22CJ28YXHAslURYRppAIhnFCuru9unMqArxWqXeDyYRJngEIGwY/jlpY9MoHhSmy7yAf3NXtdRGiv1eLm2RFV9B2/z57W6v1EqtHs4j7YJh60N9d/lNnqk/MBtdvrru262O90IApQetFO7ydmYbsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3YhgBT6fr0hwumMymgvHBZKDfgqiXQQqtzLblMXHVA=;
 b=bBSkm1VaZIJ7VqPIhg53pwVPeflckL58sfh3DxawTX/xMcTNF+0vyIqbRAQ87HPTViJdDNVYLGwGU/ZEVURVbkXp+KQUA7ARnVnEr4JLPQpsSFamaoRQSIiVqsgfdGLqBiMCtk6yyPS+abTHaXhNny8qDkQ0qHgK0V0rvFvF+lVFFYi0cYfLcx333CZEn2tjAz5GTAQHcNjsRVw8RZhs61Eo4odkBvq+3dwkvzacj+iN1c4iDGFYPzNmrQU2j2LSJQOJ4w/2zTPF41ehZVTM0++FGg4JqpVN9WIMsefcabDBqGax3QzJQYA2a2eH6ZSg0hHQoGESyZpfwiy25rKN0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3YhgBT6fr0hwumMymgvHBZKDfgqiXQQqtzLblMXHVA=;
 b=Vvza4MP7Ie+LpBUuSK2srH1+w9iZDkmCAF3dtpRQc13KuTwP3bEq7/FJAMCb51TXyAJ2FUE5PXL09ZfpFv0y6iBSgsOq8qkxEBOncqsb+ED16p7bLTQV9NKi9zscp4Px1KpkRzVnHBtaDVchbRU3crhM7XmQMGc+llVwadb96DI=
Received: from SJ2PR07CA0021.namprd07.prod.outlook.com (2603:10b6:a03:505::23)
 by PH7PR12MB8794.namprd12.prod.outlook.com (2603:10b6:510:27d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 14:17:17 +0000
Received: from SJ1PEPF000037A3.namprd04.prod.outlook.com
 (2603:10b6:a03:505:cafe::92) by SJ2PR07CA0021.outlook.office365.com
 (2603:10b6:a03:505::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 14:17:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037A3.mail.protection.outlook.com (10.167.244.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Tue, 17 Nov 2026 14:17:17 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 17 Nov 2026 08:17:08 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Lijo Lazar <lijo.lazar@amd.com>, "Felix
 Kuehling" <felix.kuehling@amd.com>, Lancelot Six <lancelot.six@amd.com>,
 "James Zhu" <James.Zhu@amd.com>, Samuel Pitoiset <hakzsam@gmail.com>, Natalie
 Vock <natalie.vock@gmx.de>, =?UTF-8?q?Timur=20Krist=C3=B3f?=
 <timur.kristof@gmail.com>, Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: Add CWSR and second-level trap handler
 infrastructure
Date: Tue, 17 Nov 2026 19:46:46 +0530
Message-ID: <20261117141649.1658444-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261117141649.1658444-1-srinivasan.shanmugam@amd.com>
References: <20261117141649.1658444-1-srinivasan.shanmugam@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A3:EE_|PH7PR12MB8794:EE_
X-MS-Office365-Filtering-Correlation-Id: 122987c6-b3b3-4a4f-4a3d-08df44b57c36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|376014|36860700016|22082099003|18002099003|6133799003|261009223027099003|3023799007|260925021911599003|11063799006|260925021311599003|260925022911599003|56012099006|261102123227099003|261026130827099003|10067099003|261026135527099003|261022075727099003|261022113327099003|261022105027099003|261026140227099003|261021123027099003|261021121427099003|261021135927099003|261021133027099003|261026121527099003|261028144727099003|261022115727099003|261021130227099003;
X-Microsoft-Antispam-Message-Info: l35HExDdIKszJG7B3/9ts4ILyesp9Ggmm3nFBT5/KVsnjpcabux6TjJHu3VumR2nruvpTq6x6FWI5EVX/y3nGz6r0Fy6ewuWhDfJ8m16SDHCZjF8oUAhYgYgnodC4FH/aQ8pbYNxEhAPSXT9g8iODyzRKYF6C9GZLbS35K5z+yYMhDGdsJ3ZOImui58uYsahPtxtCz+6rBSJRtVvycWMh2WoVgOdXcBH/BSlNd7vVzFBTgR/YrbLiBNcqw+L2y9pxMkwIkCpj8ualx7D7W82MC/sfQ4tyfBPzv547cQ+qS4Tlg/GxcEjv5CCSMKA4tEVIxA3kMrzmigkKvJtWbf9EYOQL/0rxuaz2jM1kmN4Fd4+bwmlF4OcRlNG1M2cWgFjxcG+O/BUMhC1VHL+Vijj9f/ddB6GL2XI7+6QPT8SJXHws6WjFJfpjHRHeYz6iBmlyoR/Cs2rXNJa4bCoExfey8LqoSQGp9m2BeDdqQBZm33SNF/JCw+e6xHm1LxagkFptuq+Crm7SSPxFSfgh62BRohm0+3mOFLaJqXPiiaGOhnlslaEzjfRauRDoQS0XqgT/fpUj2hXIobIgYYKIjKKsBIC5p6vlIk/mgq7XoDkhcsR3f3Rmtvn3jVBqiv5Gl+qKF6krRK+5vqNay+5poD2EmfkWydTzY3nuTz0ySm5t+3zb1C4RMYHCusS2y+iURRiFRybp43ycXFAMjwfZyj3lg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(36860700016)(22082099003)(18002099003)(6133799003)(261009223027099003)(3023799007)(260925021911599003)(11063799006)(260925021311599003)(260925022911599003)(56012099006)(261102123227099003)(261026130827099003)(10067099003)(261026135527099003)(261022075727099003)(261022113327099003)(261022105027099003)(261026140227099003)(261021123027099003)(261021121427099003)(261021135927099003)(261021133027099003)(261026121527099003)(261028144727099003)(261022115727099003)(261021130227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eC6YuHOMTON1A/LLylyjwTRbjEkbaUQ1ykZMf6QSMlei9Ls1FIH1oeN+LE4cecRKKQdT5Zjaj+GnZl/sxbXKTN2it53WAYHBMFEWTg2uzyr8LIMQ/AvsWscdY/VUv0ocqYlRfnKKIJ4IJQreupEOn/lgheKsK4L8s62Z3ShGy39RxhmjKR0LrvOFO0SG+TvUbSjWUDF/yBCxwdJU5zhgIfD8crqIwtJREy695F10EQhORQVclz5xG3F8bSyr2LQ2VWwV2r5JN+OFsdIp1z7nWQ/HF5BbjFKcIRE44WgKzMtZmXpNAS/xtJgre1g1IInjQ9igL8IXWqcg9Iuf4rx2X4rXGmXkm6DbbNtU+NxQFHywQLmOv5M7+lbWFcDgx9sQ3hmJVCjup8MGqLtQwMWEV9q8z3JrROVNc8J6i6rEPDG7puf/g2HZZXpheUSctJRA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 14:17:17.2525 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 122987c6-b3b3-4a4f-4a3d-08df44b57c36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8794
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Lijo Lazar <lijo.lazar@amd.com>

Add the core trap handling infrastructure required for AMDGPU user
queues.

This includes support for Compute Wave Save Restore (CWSR),
integration with the user queue path, userspace interfaces required
for trap and save area configuration, and the infrastructure required
for second-level trap handlers (SLTH).

The implementation provides first-level trap handler management,
trap buffer allocation and validation, trap state allocation and
management, save area sizing and validation, and the infrastructure
required for second-level userspace trap handlers.

The common trap handling implementation is provided through
amdgpu_trap.c and associated helpers while preserving the CWSR
functionality required for user queue preemption and recovery.

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Lancelot Six <lancelot.six@amd.com>
Cc: James Zhu <James.Zhu@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Samuel Pitoiset <hakzsam@gmail.com>
Cc: Natalie Vock <natalie.vock@gmx.de>
Cc: Timur Kristóf <timur.kristof@gmail.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Co-developed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile        |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  10 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  31 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h    |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c   | 764 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h   | 143 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  |  24 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    |  22 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     |  14 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 107 ++-
 include/uapi/drm/amdgpu_drm.h              |  27 +
 15 files changed, 1163 insertions(+), 34 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 8687afc00c24..7dfc4902faba 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -72,7 +72,7 @@ amdgpu-y += amdgpu_device.o amdgpu_reg_access.o amdgpu_doorbell_mgr.o amdgpu_kms
 	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o amdgpu_lockdep.o \
 	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_dev_coredump.o \
 	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o \
-	amdgpu_wb.o
+	amdgpu_wb.o amdgpu_trap.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 5a32b54b1e9b..2f49da48aa90 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -332,6 +332,8 @@ struct amdgpu_reset_context;
 struct amdgpu_reset_control;
 struct amdgpu_coredump_info;
 struct amdgpu_video_codecs;
+struct amdgpu_trap_isa;
+struct amdgpu_trap_obj;
 
 enum amdgpu_cp_irq {
 	AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP = 0,
@@ -420,6 +422,7 @@ struct amdgpu_fpriv {
 	struct xarray		bo_list_handles;
 	struct amdgpu_ctx_mgr	ctx_mgr;
 	struct amdgpu_userq_mgr	userq_mgr;
+	struct amdgpu_trap_obj *trap_obj;
 
 	/* Eviction fence infra */
 	struct amdgpu_eviction_fence_mgr evf_mgr;
@@ -986,6 +989,8 @@ struct amdgpu_device {
 	 * Must be last --ends in a flexible-array member.
 	 */
 	struct amdgpu_kfd_dev		kfd;
+
+	struct amdgpu_trap_info *trap_info;
 };
 
 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 9326f811c500..213e34186531 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -81,6 +81,7 @@
 #include "amdgpu_reset.h"
 #include "amdgpu_virt.h"
 #include "amdgpu_dev_coredump.h"
+#include "amdgpu_trap.h"
 
 #include <linux/suspend.h>
 #include <drm/task_barrier.h>
@@ -2547,6 +2548,14 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	amdgpu_fru_get_product_info(adev);
 
 	r = amdgpu_cper_init(adev);
+	if (r)
+		goto init_failed;
+
+	r = amdgpu_trap_init(adev);
+	if (r == -EOPNOTSUPP)
+		r = 0;
+	else if (r)
+		goto init_failed;
 
 init_failed:
 
@@ -2951,6 +2960,7 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 {
 	int i, r;
 
+	amdgpu_trap_fini(adev);
 	amdgpu_cper_fini(adev);
 
 	if (amdgpu_sriov_vf(adev) && adev->virt.ras_init_done)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 5e0029530b79..e8f830be32b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -52,6 +52,7 @@
 #include "amdgpu_sched.h"
 #include "amdgpu_xgmi.h"
 #include "amdgpu_userq.h"
+#include "amdgpu_trap.h"
 #include "amdgpu_userq_fence.h"
 #include "../amdxcp/amdgpu_xcp_drv.h"
 #include "amdgpu_ualink.h"
@@ -764,6 +765,15 @@ MODULE_PARM_DESC(use_xgmi_p2p,
 	"Enable XGMI P2P interface (0 = disable; 1 = enable (default))");
 module_param_named(use_xgmi_p2p, amdgpu_use_xgmi_p2p, int, 0444);
 
+/**
+ * DOC: cwsr_enable (int)
+ * CWSR(compute wave store and resume) allows the GPU to preempt shader execution in
+ * the middle of a compute wave. Default is 1 to enable this feature. Setting 0
+ * disables it.
+ */
+int cwsr_enable = 1;
+module_param(cwsr_enable, int, 0444);
+MODULE_PARM_DESC(cwsr_enable, "CWSR enable (0 = Off, 1 = On (Default))");
 
 #ifdef CONFIG_HSA_AMD
 /**
@@ -787,16 +797,6 @@ module_param(hws_max_conc_proc, int, 0444);
 MODULE_PARM_DESC(hws_max_conc_proc,
 	"Max # processes HWS can execute concurrently when sched_policy=0 (0 = no concurrency, #VMIDs for KFD = Maximum(default))");
 
-/**
- * DOC: cwsr_enable (int)
- * CWSR(compute wave store and resume) allows the GPU to preempt shader execution in
- * the middle of a compute wave. Default is 1 to enable this feature. Setting 0
- * disables it as only in non-HWS mode.
- */
-int cwsr_enable = 1;
-module_param(cwsr_enable, int, 0444);
-MODULE_PARM_DESC(cwsr_enable, "CWSR enable (0 = Off (debugging only), 1 = On (Default))");
-
 /**
  * DOC: max_num_of_queues_per_device (int)
  * Maximum number of queues per device. Valid setting is between 1 and 4096. Default
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 14a72a406d37..201c167577c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -49,6 +49,8 @@
 #include "amdgpu_userq.h"
 #include "amdgpu_video_codecs.h"
 #include "amdgpu_ras_mgr.h"
+#include "amdgpu_vm.h"
+#include "amdgpu_trap.h"
 
 void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
 {
@@ -1453,6 +1455,27 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			return -EINVAL;
 		}
 	}
+	case AMDGPU_INFO_CWSR: {
+		struct drm_amdgpu_info_cwsr cwsr_info;
+		int num_xcc, r;
+
+		fpriv = (struct amdgpu_fpriv *)filp->driver_priv;
+		if (!amdgpu_trap_is_enabled(adev) || !fpriv->trap_obj)
+			return -EOPNOTSUPP;
+		num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->xcp_id);
+		cwsr_info.ctl_stack_size =
+			adev->trap_info->cwsr.xcc_ctl_stack_sz * num_xcc;
+		cwsr_info.dbg_mem_size =
+			adev->trap_info->cwsr.xcc_dbg_mem_sz * num_xcc;
+		cwsr_info.min_save_area_size =
+			amdgpu_trap_size_needed(adev, num_xcc);
+		r = copy_to_user(out, &cwsr_info,
+				 min((size_t)size, sizeof(cwsr_info))) ?
+			    -EFAULT :
+			    0;
+		return r;
+	}
+
 	default:
 		DRM_DEBUG_KMS("Invalid request %d\n", info->query);
 		return -EINVAL;
@@ -1580,6 +1603,13 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 			 r);
 
 	amdgpu_evf_mgr_init(&fpriv->evf_mgr);
+
+	r = amdgpu_trap_alloc(adev,
+			      &fpriv->vm,
+			      &fpriv->trap_obj);
+	if (r == -EOPNOTSUPP)
+		r = 0;
+
 	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
 
 	file_priv->driver_priv = fpriv;
@@ -1649,6 +1679,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	}
 
 	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
+	amdgpu_trap_free(adev, &fpriv->vm, &fpriv->trap_obj);
 
 	if (pasid)
 		amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 652cd0950453..9bd1c99ed29f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -552,6 +552,14 @@ struct amdgpu_mqd_prop {
 	uint32_t cu_mask_count;
 	uint32_t cu_flags;
 	bool is_user_cu_masked;
+	bool aql_queue;
+	u32 queue_percentage;
+	/* used in gfx9 and gfx12.1 */
+	u32 pm4_target_xcc;
+	/* cwsr params */
+	u64 ctx_save_area_addr;
+	u32 ctx_save_area_size;
+	u32 ctl_stack_size;
 };
 
 struct amdgpu_mqd {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
new file mode 100644
index 000000000000..cb3e5f26ee23
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
@@ -0,0 +1,764 @@
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+#include <linux/iosys-map.h>
+
+#include <drm/ttm/ttm_bo.h>
+#include <drm/drm_exec.h>
+
+#include "amdgpu.h"
+#include "cwsr_trap_handler.h"
+#include "amdgpu_trap.h"
+
+/*
+ * First-level TMA layout used by the second-level trap-handler ABI.
+ * The trap-handler ISA reads L2 TBA at offset 0 and L2 TMA at offset 8.
+ */
+#define AMDGPU_TRAP_L2_TBA_INDEX	0
+#define AMDGPU_TRAP_L2_TMA_INDEX	1
+#define AMDGPU_TRAP_DEBUG_FLAG_INDEX	2
+
+extern int cwsr_enable;
+
+#define AMDGPU_TRAP_TBA_MAX_SIZE (2 * AMDGPU_GPU_PAGE_SIZE)
+#define AMDGPU_TRAP_TMA_MAX_SIZE (AMDGPU_GPU_PAGE_SIZE)
+#define AMDGPU_TRAP_TMA_OFFSET (AMDGPU_TRAP_TBA_MAX_SIZE)
+
+#define SGPR_SIZE_PER_CU 0x4000
+#define LDS_SIZE_PER_CU 0x10000
+#define HWREG_SIZE_PER_CU 0x1000
+#define DEBUGGER_BYTES_ALIGN 64
+#define DEBUGGER_BYTES_PER_WAVE 32
+#define SIZEOF_HSA_USER_CONTEXT_SAVE_AREA_HEADER 40
+
+enum amdgpu_trap_region {
+	AMDGPU_TRAP_TBA,
+	AMDGPU_TRAP_TMA,
+};
+
+static inline uint64_t amdgpu_trap_tba_vaddr(struct amdgpu_device *adev)
+{
+	u64 addr = AMDGPU_VA_RESERVED_TRAP_UQ_START(adev);
+
+	addr = amdgpu_gmc_sign_extend(addr);
+
+	return addr;
+}
+
+static inline bool amdgpu_trap_is_supported(struct amdgpu_device *adev)
+{
+	u32 gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
+
+	if (!cwsr_enable || gc_ver < IP_VERSION(9, 0, 1))
+		return false;
+
+	return true;
+}
+
+uint32_t amdgpu_trap_size_needed(struct amdgpu_device *adev, int num_xcc)
+{
+	if (!amdgpu_trap_is_enabled(adev))
+		return 0;
+
+	return num_xcc *
+	       (adev->trap_info->cwsr.xcc_cwsr_sz + adev->trap_info->cwsr.xcc_dbg_mem_sz);
+}
+
+static void amdgpu_trap_cwsr_init_isa_details(struct amdgpu_device *adev,
+					      struct amdgpu_trap_info *trap_info)
+{
+	u32 gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
+
+	if (gc_ver < IP_VERSION(9, 0, 1)) {
+		BUILD_BUG_ON(sizeof(cwsr_trap_gfx8_hex) >
+			     AMDGPU_TRAP_TBA_MAX_SIZE);
+		trap_info->isa_buf = cwsr_trap_gfx8_hex;
+		trap_info->isa_sz = sizeof(cwsr_trap_gfx8_hex);
+	} else if (gc_ver == IP_VERSION(9, 4, 1)) {
+		BUILD_BUG_ON(sizeof(cwsr_trap_arcturus_hex) >
+			     AMDGPU_TRAP_TBA_MAX_SIZE);
+		trap_info->isa_buf = cwsr_trap_arcturus_hex;
+		trap_info->isa_sz = sizeof(cwsr_trap_arcturus_hex);
+	} else if (gc_ver == IP_VERSION(9, 4, 2)) {
+		BUILD_BUG_ON(sizeof(cwsr_trap_aldebaran_hex) >
+			     AMDGPU_TRAP_TBA_MAX_SIZE);
+		trap_info->isa_buf = cwsr_trap_aldebaran_hex;
+		trap_info->isa_sz = sizeof(cwsr_trap_aldebaran_hex);
+	} else if (gc_ver == IP_VERSION(9, 4, 3) ||
+		   gc_ver == IP_VERSION(9, 4, 4)) {
+		BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_4_3_hex) >
+			     AMDGPU_TRAP_TBA_MAX_SIZE);
+		trap_info->isa_buf = cwsr_trap_gfx9_4_3_hex;
+		trap_info->isa_sz = sizeof(cwsr_trap_gfx9_4_3_hex);
+	} else if (gc_ver == IP_VERSION(9, 5, 0)) {
+		BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_5_0_hex) > PAGE_SIZE);
+		trap_info->isa_buf = cwsr_trap_gfx9_5_0_hex;
+		trap_info->isa_sz = sizeof(cwsr_trap_gfx9_5_0_hex);
+	} else if (gc_ver < IP_VERSION(10, 1, 1)) {
+		BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_hex) >
+			     AMDGPU_TRAP_TBA_MAX_SIZE);
+		trap_info->isa_buf = cwsr_trap_gfx9_hex;
+		trap_info->isa_sz = sizeof(cwsr_trap_gfx9_hex);
+	} else if (gc_ver < IP_VERSION(10, 3, 0)) {
+		BUILD_BUG_ON(sizeof(cwsr_trap_nv1x_hex) >
+			     AMDGPU_TRAP_TBA_MAX_SIZE);
+		trap_info->isa_buf = cwsr_trap_nv1x_hex;
+		trap_info->isa_sz = sizeof(cwsr_trap_nv1x_hex);
+	} else if (gc_ver < IP_VERSION(11, 0, 0)) {
+		BUILD_BUG_ON(sizeof(cwsr_trap_gfx10_hex) >
+			     AMDGPU_TRAP_TBA_MAX_SIZE);
+		trap_info->isa_buf = cwsr_trap_gfx10_hex;
+		trap_info->isa_sz = sizeof(cwsr_trap_gfx10_hex);
+	} else if (gc_ver < IP_VERSION(12, 0, 0)) {
+		/* The gfx11 cwsr trap handler must fit inside a single page. */
+		BUILD_BUG_ON(sizeof(cwsr_trap_gfx11_hex) > PAGE_SIZE);
+		trap_info->isa_buf = cwsr_trap_gfx11_hex;
+		trap_info->isa_sz = sizeof(cwsr_trap_gfx11_hex);
+	} else if (gc_ver < IP_VERSION(12, 1, 0)) {
+		BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_hex) >
+			     AMDGPU_TRAP_TBA_MAX_SIZE);
+		trap_info->isa_buf = cwsr_trap_gfx12_hex;
+		trap_info->isa_sz = sizeof(cwsr_trap_gfx12_hex);
+	} else if (gc_ver == IP_VERSION(12, 1, 0) &&
+		   (adev->rev_id & 0xF) == 0) {
+		BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_1_0_rev_0_hex) >
+			     AMDGPU_TRAP_TBA_MAX_SIZE);
+		trap_info->isa_buf = cwsr_trap_gfx12_1_0_rev_0_hex;
+		trap_info->isa_sz =
+			sizeof(cwsr_trap_gfx12_1_0_rev_0_hex);
+	} else {
+		BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_1_0_rev_1_hex) >
+			     AMDGPU_TRAP_TBA_MAX_SIZE);
+		trap_info->isa_buf = cwsr_trap_gfx12_1_0_rev_1_hex;
+		trap_info->isa_sz =
+			sizeof(cwsr_trap_gfx12_1_0_rev_1_hex);
+	}
+}
+
+static uint32_t amdgpu_trap_cwsr_get_vgpr_size_per_cu(struct amdgpu_device *adev)
+{
+	u32 gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
+	u32 vgpr_size;
+
+	switch (gc_ver) {
+	case IP_VERSION(9, 4, 1): /* GFX_VERSION_ARCTURUS */
+	case IP_VERSION(9, 4, 2): /* GFX_VERSION_ALDEBARAN */
+	case IP_VERSION(9, 4, 3): /* GFX_VERSION_AQUA_VANJARAM */
+	case IP_VERSION(9, 4, 4): /* GFX_VERSION_AQUA_VANJARAM */
+	case IP_VERSION(9, 5, 0):
+		vgpr_size = 0x80000;
+		break;
+	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 2):
+	case IP_VERSION(11, 0, 3):
+	case IP_VERSION(12, 0, 0):
+	case IP_VERSION(12, 0, 1):
+		vgpr_size = 0x60000;
+		break;
+	default:
+		vgpr_size = 0x40000;
+		break;
+	}
+
+	return vgpr_size;
+}
+
+static uint32_t amdgpu_trap_cwsr_get_wg_ctxt_size_per_cu(struct amdgpu_device *adev)
+{
+	u32 lds_sz_per_cu;
+
+	lds_sz_per_cu =
+		(amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0)) ?
+			(adev->gfx.cu_info.lds_size << 10) :
+			LDS_SIZE_PER_CU;
+
+	return amdgpu_trap_cwsr_get_vgpr_size_per_cu(adev) + SGPR_SIZE_PER_CU +
+	       lds_sz_per_cu + HWREG_SIZE_PER_CU;
+}
+
+static uint32_t amdgpu_trap_cwsr_ctl_stack_bytes_per_wave(struct amdgpu_device *adev)
+{
+	u32 sz;
+
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(10, 1, 0))
+		sz = 12;
+	else
+		sz = 8;
+	return sz;
+}
+
+static void amdgpu_trap_cwsr_init_save_area_info(struct amdgpu_device *adev,
+						 struct amdgpu_trap_info *trap_info)
+{
+	struct amdgpu_gfx_config *gfx_info = &adev->gfx.config;
+	u32 gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
+	u32 ctl_stack_size, wg_data_size, dbg_mem_size;
+	u32 array_count;
+	u32 wave_num;
+	u32 cu_num;
+
+	if (gc_ver < IP_VERSION(9, 0, 1))
+		return;
+
+	array_count = gfx_info->max_shader_engines * gfx_info->max_sh_per_se;
+
+	cu_num = adev->gfx.cu_info.number / NUM_XCC(adev->gfx.xcc_mask);
+	wave_num = (gc_ver < IP_VERSION(10, 1, 0)) ? /* GFX_VERSION_NAVI10 */
+			   min(cu_num * 40,
+			       array_count / gfx_info->max_sh_per_se * 512) :
+			   cu_num * 32;
+
+	wg_data_size = ALIGN(cu_num * amdgpu_trap_cwsr_get_wg_ctxt_size_per_cu(adev),
+			     PAGE_SIZE);
+	ctl_stack_size =
+		wave_num * amdgpu_trap_cwsr_ctl_stack_bytes_per_wave(adev) + 8;
+	ctl_stack_size =
+		ALIGN(SIZEOF_HSA_USER_CONTEXT_SAVE_AREA_HEADER + ctl_stack_size,
+		      PAGE_SIZE);
+	dbg_mem_size =
+		ALIGN(wave_num * DEBUGGER_BYTES_PER_WAVE, DEBUGGER_BYTES_ALIGN);
+	/*
+	 * HW design limits control stack size to 0x7000.
+	 * This is insufficient for theoretical PM4 cases
+	 * but sufficient for AQL, limited by SPI events.
+	 */
+	if (IP_VERSION_MAJ(gc_ver) == 10)
+		ctl_stack_size = min(ctl_stack_size, 0x7000);
+
+	trap_info->cwsr.xcc_ctl_stack_sz = ctl_stack_size;
+	trap_info->cwsr.xcc_cwsr_sz = ctl_stack_size + wg_data_size;
+	trap_info->cwsr.xcc_dbg_mem_sz = dbg_mem_size;
+}
+
+int amdgpu_trap_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_trap_info *trap_info __free(kfree) =
+		kzalloc(sizeof(*trap_info), GFP_KERNEL);
+	void *ptr;
+	int r;
+
+	if (!amdgpu_trap_is_supported(adev))
+		return -EOPNOTSUPP;
+
+	if (!trap_info)
+		return -ENOMEM;
+	amdgpu_trap_cwsr_init_isa_details(adev, trap_info);
+
+	if (!trap_info->isa_sz)
+		return -EOPNOTSUPP;
+
+	r = amdgpu_bo_create_kernel(adev, AMDGPU_TRAP_TBA_MAX_SIZE, PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_GTT, &trap_info->isa_bo,
+				    NULL, &ptr);
+	if (r)
+		return r;
+
+	memcpy(ptr, trap_info->isa_buf, trap_info->isa_sz);
+
+	amdgpu_trap_cwsr_init_save_area_info(adev, trap_info);
+	adev->trap_info = no_free_ptr(trap_info);
+
+	return 0;
+}
+
+void amdgpu_trap_fini(struct amdgpu_device *adev)
+{
+	if (!amdgpu_trap_is_enabled(adev))
+		return;
+
+	amdgpu_bo_free_kernel(&adev->trap_info->isa_bo, NULL, NULL);
+	kfree(adev->trap_info);
+	adev->trap_info = NULL;
+}
+
+/*
+ * amdgpu_map_cwsr_trap_handler should be called during amdgpu_vm_init
+ * it maps virtual address amdgpu_trap_tba_vaddr() to this VM, and each
+ * compute queue can use this virtual address for wave save/restore
+ * operations to support compute preemption.
+ */
+static int amdgpu_trap_map_region(struct amdgpu_device *adev,
+				  struct amdgpu_vm *vm,
+				  struct amdgpu_trap_obj *cwsr,
+				  enum amdgpu_trap_region region)
+{
+	u64 cwsr_addr, va_flags, va;
+	struct amdgpu_bo_va **bo_va;
+	struct amdgpu_bo *bo;
+	u32 size;
+	int r;
+
+	if (!cwsr || !vm)
+		return -EINVAL;
+
+	cwsr_addr = amdgpu_trap_tba_vaddr(adev);
+
+	if (region == AMDGPU_TRAP_TBA) {
+		size = AMDGPU_TRAP_TBA_MAX_SIZE;
+		bo_va = &cwsr->tba_va;
+		bo = adev->trap_info->isa_bo;
+		va = cwsr_addr;
+		va_flags = (AMDGPU_VM_PAGE_READABLE | AMDGPU_VM_PAGE_WRITEABLE |
+			    AMDGPU_VM_PAGE_EXECUTABLE);
+	} else {
+		size = AMDGPU_TRAP_TMA_MAX_SIZE;
+		bo_va = &cwsr->tma_va;
+		bo = cwsr->tma_bo;
+		va = cwsr_addr + AMDGPU_TRAP_TMA_OFFSET;
+		va_flags = (AMDGPU_VM_PAGE_READABLE | AMDGPU_VM_PAGE_WRITEABLE);
+	}
+
+	*bo_va = amdgpu_vm_bo_add(adev, vm, bo);
+	if (!*bo_va)
+		return -ENOMEM;
+
+	va &= AMDGPU_GMC_HOLE_MASK;
+	r = amdgpu_vm_bo_map(adev, *bo_va, va, 0, size, va_flags);
+	if (r) {
+		dev_err(adev->dev, "failed to do bo map of %s region, err=%d\n",
+			(region == AMDGPU_TRAP_TBA ? "tba" : "tma"), r);
+		amdgpu_vm_bo_del(adev, *bo_va);
+		*bo_va = NULL;
+		return r;
+	}
+
+	r = amdgpu_vm_bo_update(adev, *bo_va, false);
+	if (r) {
+		dev_err(adev->dev,
+			"failed to do page table update of %s region, err=%d\n",
+			(region == AMDGPU_TRAP_TBA ? "tba" : "tma"), r);
+		amdgpu_vm_bo_del(adev, *bo_va);
+		*bo_va = NULL;
+		return r;
+	}
+
+	if (region == AMDGPU_TRAP_TBA)
+		cwsr->tba_gpu_va_addr = va;
+	else
+		cwsr->tma_gpu_va_addr = va;
+
+	return 0;
+}
+
+static int amdgpu_trap_unmap_region(struct amdgpu_device *adev,
+				    struct amdgpu_trap_obj *cwsr,
+				    enum amdgpu_trap_region region)
+{
+	struct amdgpu_bo_va **bo_va;
+	u64 va;
+	int r;
+
+	if (!cwsr)
+		return -EINVAL;
+
+	if (region == AMDGPU_TRAP_TBA) {
+		bo_va = &cwsr->tba_va;
+		va = cwsr->tba_gpu_va_addr;
+	} else {
+		bo_va = &cwsr->tma_va;
+		va = cwsr->tma_gpu_va_addr;
+	}
+
+	r = amdgpu_vm_bo_unmap(adev, *bo_va, va);
+	if (r) {
+		dev_err(adev->dev,
+			"failed to do bo_unmap on CWSR trap handler, err=%d\n",
+			r);
+		return r;
+	}
+
+	amdgpu_vm_bo_del(adev, *bo_va);
+	*bo_va = NULL;
+
+	return r;
+}
+
+int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+		      struct amdgpu_trap_obj **trap_obj)
+{
+	struct amdgpu_bo_param bp;
+	struct iosys_map map;
+	struct amdgpu_trap_obj *cwsr;
+	struct amdgpu_bo *bo;
+	struct drm_exec exec;
+	int r;
+
+	if (!amdgpu_trap_is_enabled(adev))
+		return -EOPNOTSUPP;
+
+	if (!vm || !trap_obj)
+		return -EINVAL;
+
+	cwsr = kzalloc_obj(*cwsr, GFP_KERNEL);
+	if (!cwsr)
+		return -ENOMEM;
+
+	bo = adev->trap_info->isa_bo;
+
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
+	drm_exec_until_all_locked(&exec) {
+		r = amdgpu_vm_lock_pd(vm, &exec, 0);
+		drm_exec_retry_on_contention(&exec);
+		if (unlikely(r))
+			goto err_exec;
+
+		r = drm_exec_lock_obj(&exec, &bo->tbo.base);
+		drm_exec_retry_on_contention(&exec);
+		if (unlikely(r))
+			goto err_exec;
+	}
+
+	/*
+	 * Create the TMA BO with the VM root reservation. The reservation is
+	 * already held by drm_exec, so creating the BO doesn't recursively
+	 * acquire another reservation_ww_class_mutex. The TMA remains
+	 * unpinned and is covered by the VM root reservation.
+	 */
+	memset(&bp, 0, sizeof(bp));
+	bp.size = AMDGPU_TRAP_TMA_MAX_SIZE;
+	bp.byte_align = PAGE_SIZE;
+	bp.domain = AMDGPU_GEM_DOMAIN_GTT;
+	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC |
+		   AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
+	bp.type = ttm_bo_type_kernel;
+	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
+	bp.resv = vm->root.bo->tbo.base.resv;
+
+	r = amdgpu_bo_create(adev, &bp, &cwsr->tma_bo);
+	if (r)
+		goto err_exec;
+
+	/*
+	 * The TMA BO is unpinned and movable. Map it only while accessing
+	 * its contents so that no CPU mapping can become stale across BO
+	 * migration. ttm_bo_vmap() and ttm_bo_vunmap() require the BO
+	 * reservation, which is the already held VM root reservation.
+	 */
+	r = ttm_bo_vmap(&cwsr->tma_bo->tbo, &map);
+	if (r)
+		goto err_tma;
+
+	/*
+	 * Finish initialization with a DMA write barrier before allowing
+	 * the GPU to observe the contents.
+	 */
+	iosys_map_memset(&map, 0, 0, AMDGPU_TRAP_TMA_MAX_SIZE);
+	dma_wmb();
+
+	ttm_bo_vunmap(&cwsr->tma_bo->tbo, &map);
+
+	r = amdgpu_trap_map_region(adev, vm, cwsr, AMDGPU_TRAP_TMA);
+	if (r)
+		goto err_tma;
+
+	r = amdgpu_trap_map_region(adev, vm, cwsr, AMDGPU_TRAP_TBA);
+	if (r) {
+		amdgpu_trap_unmap_region(adev, cwsr, AMDGPU_TRAP_TMA);
+		goto err_tma;
+	}
+
+	drm_exec_fini(&exec);
+
+	*trap_obj = cwsr;
+
+	return 0;
+
+err_tma:
+	amdgpu_bo_unref(&cwsr->tma_bo);
+
+err_exec:
+	drm_exec_fini(&exec);
+	kfree(cwsr);
+	*trap_obj = NULL;
+
+	return r;
+}
+
+static int amdgpu_trap_update_l2_handler(struct amdgpu_trap_obj *trap_obj,
+					 u64 tba, u64 tma)
+{
+	struct iosys_map map;
+	int r;
+
+	if (!trap_obj || !trap_obj->tma_bo)
+		return -EINVAL;
+
+	dma_resv_assert_held(trap_obj->tma_bo->tbo.base.resv);
+
+	r = ttm_bo_vmap(&trap_obj->tma_bo->tbo, &map);
+	if (r)
+		return r;
+
+	/*
+	 * Publish both descriptor fields before allowing the GPU to observe
+	 * the updated second-level trap handler.
+	 */
+	iosys_map_wr(&map, AMDGPU_TRAP_L2_TBA_INDEX * sizeof(u64),
+		     u64, tba);
+	iosys_map_wr(&map, AMDGPU_TRAP_L2_TMA_INDEX * sizeof(u64),
+		     u64, tma);
+	dma_wmb();
+
+	ttm_bo_vunmap(&trap_obj->tma_bo->tbo, &map);
+
+	return 0;
+}
+
+static int amdgpu_trap_clear_l2_handler(struct amdgpu_vm *vm,
+					struct amdgpu_trap_obj *trap_obj)
+{
+	if (!trap_obj || !trap_obj->tma_bo)
+		return -EINVAL;
+
+	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
+
+	return amdgpu_trap_update_l2_handler(trap_obj, 0, 0);
+}
+
+int amdgpu_trap_validate_params(struct amdgpu_device *adev,
+				struct amdgpu_trap_params *trap_params,
+				int num_xcc)
+{
+	u32 min_size, max_size;
+
+	if (!amdgpu_trap_is_enabled(adev))
+		return -EOPNOTSUPP;
+
+	if (!trap_params)
+		return -EINVAL;
+
+	min_size = amdgpu_trap_size_needed(adev, num_xcc);
+	max_size = 2 * min_size;
+	/*
+	 * Only save area size details checked. Address validation needs to be
+	 * carried out separately. User is expected to pass a cwsr buffer area
+	 * with size >= ctl stack size + wg data size + debug memory size
+	 */
+	if (trap_params->cwsr_sz < min_size ||
+	    trap_params->cwsr_sz > max_size) {
+		dev_dbg(adev->dev,
+			"queue cwsr size 0x%x should be within min %u : max %u\n",
+			trap_params->cwsr_sz, min_size, max_size);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+void amdgpu_trap_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+		      struct amdgpu_trap_obj **trap_obj)
+{
+	struct amdgpu_bo *tba_bo;
+	struct drm_exec exec;
+	int r;
+
+	if (!trap_obj || !*trap_obj)
+		return;
+
+	tba_bo = adev->trap_info->isa_bo;
+
+	drm_exec_init(&exec, 0, 0);
+	drm_exec_until_all_locked(&exec) {
+		r = amdgpu_vm_lock_pd(vm, &exec, 0);
+		drm_exec_retry_on_contention(&exec);
+		if (unlikely(r))
+			goto out_exec;
+
+		if (tba_bo) {
+			r = drm_exec_lock_obj(&exec, &tba_bo->tbo.base);
+			drm_exec_retry_on_contention(&exec);
+			if (unlikely(r))
+				goto out_exec;
+		}
+	}
+
+	if ((*trap_obj)->tba_va)
+		amdgpu_trap_unmap_region(adev,
+					 *trap_obj,
+				AMDGPU_TRAP_TBA);
+
+	if ((*trap_obj)->tma_va)
+		amdgpu_trap_unmap_region(adev,
+					 *trap_obj,
+				AMDGPU_TRAP_TMA);
+
+	drm_exec_fini(&exec);
+	amdgpu_bo_unref(&(*trap_obj)->tma_bo);
+	kfree(*trap_obj);
+	*trap_obj = NULL;
+
+	return;
+
+out_exec:
+	drm_exec_fini(&exec);
+}
+
+static int amdgpu_trap_validate_user_addr(struct amdgpu_device *adev,
+					  struct amdgpu_vm *vm,
+					 struct amdgpu_trap_usr_addr *usr_addr)
+{
+	struct amdgpu_bo_va_mapping *va_map;
+	u64 start, end, addr, last;
+
+	if (!usr_addr || !usr_addr->size)
+		return -EINVAL;
+
+	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
+
+	start = usr_addr->addr & AMDGPU_GMC_HOLE_MASK;
+
+	if (check_add_overflow(start, (u64)usr_addr->size - 1, &end))
+		return -EINVAL;
+
+	/*
+	 * amdgpu_vm_bo_lookup_mapping() expects a GPU VA,
+	 * not a page-shifted address.
+	 */
+	va_map = amdgpu_vm_bo_lookup_mapping(vm, start);
+	if (!va_map)
+		return -EINVAL;
+
+	addr = start >> AMDGPU_GPU_PAGE_SHIFT;
+	last = end >> AMDGPU_GPU_PAGE_SHIFT;
+
+	if (addr < va_map->start || last > va_map->last)
+		return -EINVAL;
+
+	return 0;
+}
+
+int amdgpu_trap_vm_set_l2_trap(struct amdgpu_device *adev,
+			       struct amdgpu_vm *vm,
+			       struct amdgpu_trap_obj *trap_obj,
+			       u64 tba_va, uint32_t tba_sz,
+			       u64 tma_va, uint32_t tma_sz)
+{
+	struct amdgpu_trap_usr_addr tba = {
+		.addr = tba_va,
+		.size = tba_sz,
+	};
+	struct amdgpu_trap_usr_addr tma = {
+		.addr = tma_va,
+		.size = tma_sz,
+	};
+	long timeout;
+	int r;
+
+	if (!amdgpu_trap_is_enabled(adev))
+		return -EOPNOTSUPP;
+
+	if (!vm || !trap_obj || !trap_obj->tma_bo)
+		return -EINVAL;
+
+	r = amdgpu_bo_reserve(vm->root.bo, false);
+	if (r)
+		return r;
+
+	timeout = dma_resv_wait_timeout(vm->root.bo->tbo.base.resv,
+					DMA_RESV_USAGE_BOOKKEEP,
+					true, MAX_SCHEDULE_TIMEOUT);
+	if (timeout <= 0) {
+		r = timeout < 0 ? timeout : -ETIMEDOUT;
+		goto out_unreserve;
+	}
+
+	r = amdgpu_trap_validate_user_addr(adev, vm, &tba);
+	if (r)
+		goto out_unreserve;
+
+	r = amdgpu_trap_validate_user_addr(adev, vm, &tma);
+	if (r)
+		goto out_unreserve;
+
+	r = amdgpu_trap_update_l2_handler(trap_obj, tba_va, tma_va);
+
+out_unreserve:
+	amdgpu_bo_unreserve(vm->root.bo);
+
+	return r;
+}
+
+int amdgpu_trap_vm_clear_l2_trap(struct amdgpu_device *adev,
+				 struct amdgpu_vm *vm,
+				 struct amdgpu_trap_obj *trap_obj)
+{
+	long timeout;
+	int r;
+
+	if (!amdgpu_trap_is_enabled(adev))
+		return -EOPNOTSUPP;
+
+	if (!vm || !trap_obj || !trap_obj->tma_bo)
+		return -EINVAL;
+
+	r = amdgpu_bo_reserve(vm->root.bo, false);
+	if (r)
+		return r;
+
+	timeout = dma_resv_wait_timeout(vm->root.bo->tbo.base.resv,
+					DMA_RESV_USAGE_BOOKKEEP,
+					true, MAX_SCHEDULE_TIMEOUT);
+	if (timeout <= 0) {
+		r = timeout < 0 ? timeout : -ETIMEDOUT;
+		goto out_unreserve;
+	}
+
+	r = amdgpu_trap_clear_l2_handler(vm, trap_obj);
+
+out_unreserve:
+	amdgpu_bo_unreserve(vm->root.bo);
+
+	return r;
+}
+
+int amdgpu_trap_set_trap_debug_flag(struct amdgpu_device *adev,
+				    struct amdgpu_vm *vm,
+				    struct amdgpu_trap_obj *trap_obj,
+				    bool enabled)
+{
+	struct iosys_map map;
+	int r;
+
+	if (!amdgpu_trap_is_enabled(adev))
+		return -EOPNOTSUPP;
+
+	if (!vm || !trap_obj || !trap_obj->tma_bo)
+		return -EINVAL;
+
+	r = amdgpu_bo_reserve(vm->root.bo, false);
+	if (r)
+		return r;
+
+	r = ttm_bo_vmap(&trap_obj->tma_bo->tbo, &map);
+	if (r)
+		goto out_unreserve;
+
+	iosys_map_wr(&map, AMDGPU_TRAP_DEBUG_FLAG_INDEX * sizeof(u64),
+		     u64, (u64)enabled);
+	dma_wmb();
+
+	ttm_bo_vunmap(&trap_obj->tma_bo->tbo, &map);
+
+out_unreserve:
+	amdgpu_bo_unreserve(vm->root.bo);
+
+	return r;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
new file mode 100644
index 000000000000..c70daaf8964c
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
@@ -0,0 +1,143 @@
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#ifndef AMDGPU_TRAP_H
+#define AMDGPU_TRAP_H
+
+#include <linux/types.h>
+
+struct amdgpu_bo;
+struct amdgpu_bo_va;
+struct amdgpu_device;
+struct amdgpu_vm;
+
+/**
+ * struct amdgpu_trap_obj - per-GPUVM CWSR trap-handler state
+ * @tma_gpu_va_addr: GPU virtual address of the first-level TMA
+ * @tba_gpu_va_addr: GPU virtual address of the first-level TBA
+ * @tma_bo: buffer object backing the first-level TMA
+ * @tba_va: VM mapping of the first-level TBA
+ * @tma_va: VM mapping of the first-level TMA
+ */
+struct amdgpu_trap_obj {
+	u64 tma_gpu_va_addr;
+	u64 tba_gpu_va_addr;
+
+	struct amdgpu_bo *tma_bo;
+	struct amdgpu_bo_va *tba_va;
+	struct amdgpu_bo_va *tma_va;
+};
+
+struct amdgpu_trap_info {
+	/* cwsr isa */
+	struct amdgpu_bo *isa_bo;
+	const void *isa_buf;
+	u32 isa_sz;
+
+	/* cwsr size info per XCC */
+	struct {
+		u32 xcc_ctl_stack_sz;
+		u32 xcc_dbg_mem_sz;
+		u32 xcc_cwsr_sz;
+	} cwsr;
+};
+
+struct amdgpu_trap_params {
+	u64 ctx_save_area_address;
+
+	/* cwsr size info */
+	u32 cwsr_sz;
+};
+
+struct amdgpu_trap_usr_addr {
+	u64 addr;
+	u32 size;
+};
+
+int amdgpu_trap_init(struct amdgpu_device *adev);
+void amdgpu_trap_fini(struct amdgpu_device *adev);
+
+int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+		      struct amdgpu_trap_obj **trap_obj);
+
+void amdgpu_trap_free(struct amdgpu_device *adev,
+		      struct amdgpu_vm *vm,
+		      struct amdgpu_trap_obj **trap_obj);
+
+static inline bool amdgpu_trap_is_enabled(struct amdgpu_device *adev)
+{
+	return adev->trap_info;
+}
+
+uint32_t amdgpu_trap_size_needed(struct amdgpu_device *adev, int num_xcc);
+
+int amdgpu_trap_validate_params(struct amdgpu_device *adev,
+				struct amdgpu_trap_params *trap_params,
+				int num_xcc);
+
+static inline bool amdgpu_trap_has_dbg_wa(struct amdgpu_device *adev)
+{
+	u32 gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
+
+	return gc_ver >= IP_VERSION(11, 0, 0) &&
+	       gc_ver <= IP_VERSION(11, 0, 3);
+}
+
+/**
+ * amdgpu_trap_vm_set_l2_trap - install the second-level trap handler
+ * @adev: AMDGPU device
+ * @vm: GPUVM owning the first-level trap state
+ * @trap_obj: first-level trap object
+ * @tba_va: GPU virtual address of the second-level TBA
+ * @tba_sz: size of the second-level TBA
+ * @tma_va: GPU virtual address of the second-level TMA
+ * @tma_sz: size of the second-level TMA
+ *
+ * The second-level trap handler is configured per GPUVM. The descriptor is
+ * stored in the per-GPUVM first-level TMA.
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+int amdgpu_trap_vm_set_l2_trap(struct amdgpu_device *adev,
+			       struct amdgpu_vm *vm,
+			       struct amdgpu_trap_obj *trap_obj,
+			       u64 tba_va, uint32_t tba_sz,
+			       u64 tma_va, uint32_t tma_sz);
+
+/**
+ * amdgpu_trap_vm_clear_l2_trap - clear the second-level trap handler
+ * @adev: AMDGPU device
+ * @vm: GPUVM owning the first-level trap state
+ * @trap_obj: first-level trap object
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+int amdgpu_trap_vm_clear_l2_trap(struct amdgpu_device *adev,
+				 struct amdgpu_vm *vm,
+				 struct amdgpu_trap_obj *trap_obj);
+
+int amdgpu_trap_set_trap_debug_flag(struct amdgpu_device *adev,
+				    struct amdgpu_vm *vm,
+				    struct amdgpu_trap_obj *trap_obj,
+				    bool enabled);
+
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index ccf0ff490ac2..1de823daf008 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -35,6 +35,7 @@
 #include "amdgpu_hmm.h"
 #include "amdgpu_userq_fence.h"
 #include "amdgpu_trace.h"
+#include "amdgpu_trap.h"
 
 u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 {
@@ -265,6 +266,29 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
 	return -EINVAL;
 }
 
+int amdgpu_userq_input_trap_params_validate(struct amdgpu_usermode_queue *queue,
+					    struct amdgpu_trap_params *trap_params)
+{
+	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(queue->userq_mgr);
+	struct amdgpu_device *adev = queue->userq_mgr->adev;
+	u32 cwsr_size;
+	int num_xcc;
+	int r;
+
+	num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->xcp_id);
+	r = amdgpu_trap_validate_params(queue->userq_mgr->adev, trap_params,
+					num_xcc);
+	if (r)
+		return r;
+	cwsr_size = amdgpu_trap_size_needed(queue->userq_mgr->adev, num_xcc);
+	if (!cwsr_size)
+		return -EOPNOTSUPP;
+
+	return amdgpu_userq_input_va_validate(
+		adev, queue, trap_params->ctx_save_area_address, cwsr_size,
+		&queue->userq_vas.va.cwsr);
+}
+
 static bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr)
 {
 	struct amdgpu_bo_va_mapping *mapping;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 488dc21d7c81..5eb0f3ee9b4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -41,6 +41,7 @@ enum amdgpu_userq_state {
 };
 
 struct amdgpu_mqd_prop;
+struct amdgpu_trap_params;
 
 struct amdgpu_userq_obj {
 	void		 *cpu_ptr;
@@ -97,8 +98,9 @@ struct amdgpu_usermode_queue {
 			u64 eop;
 			u64 shadow;
 			u64 csa;
+			u64 cwsr;
 		} va;
-		u64 va_array[6];
+		u64 va_array[7];
 	} userq_vas;
 
 	uint32_t	gang_ctx_array_index;
@@ -200,4 +202,7 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
 
 void amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
 					struct amdgpu_bo_va_mapping *mapping);
+int amdgpu_userq_input_trap_params_validate(struct amdgpu_usermode_queue *queue,
+					    struct amdgpu_trap_params *trap_params);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 06e0ddd60c7b..d8e17f493f61 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -178,10 +178,17 @@ struct amdgpu_bo_vm;
 #define AMDGPU_VA_RESERVED_TRAP_SIZE		(1ULL << 16)
 #define AMDGPU_VA_RESERVED_TRAP_START(adev)	(AMDGPU_VA_RESERVED_SEQ64_START(adev) \
 						 - AMDGPU_VA_RESERVED_TRAP_SIZE)
+/* TBD: Ideally, existing TRAP VA should do. There is a conflict with KFD mapping that needs to be
+ * resolved. Revisit later.
+ */
+#define AMDGPU_VA_RESERVED_TRAP_UQ_SIZE (3ULL << 12)
+#define AMDGPU_VA_RESERVED_TRAP_UQ_START(adev) \
+	(AMDGPU_VA_RESERVED_TRAP_START(adev) - AMDGPU_VA_RESERVED_TRAP_UQ_SIZE)
+
 #define AMDGPU_VA_RESERVED_BOTTOM		(1ULL << 16)
-#define AMDGPU_VA_RESERVED_TOP			(AMDGPU_VA_RESERVED_TRAP_SIZE + \
-						 AMDGPU_VA_RESERVED_SEQ64_SIZE + \
-						 AMDGPU_VA_RESERVED_CSA_SIZE)
+#define AMDGPU_VA_RESERVED_TOP                                            \
+	(AMDGPU_VA_RESERVED_TRAP_UQ_SIZE + AMDGPU_VA_RESERVED_TRAP_SIZE + \
+	 AMDGPU_VA_RESERVED_SEQ64_SIZE + AMDGPU_VA_RESERVED_CSA_SIZE)
 
 /* See vm_update_mode */
 #define AMDGPU_VM_USE_CPU_FOR_GFX (1 << 0)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
index e2fd32af9932..30e546885e03 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
@@ -227,4 +227,26 @@ amdgpu_get_next_xcp(struct amdgpu_xcp_mgr *xcp_mgr, int *from)
 	for (i = 0, xcp = amdgpu_get_next_xcp(xcp_mgr, &i); xcp; \
 	     ++i, xcp = amdgpu_get_next_xcp(xcp_mgr, &i))
 
+static inline int amdgpu_xcp_get_num_xcc(struct amdgpu_xcp_mgr *xcp_mgr,
+					 int xcp_id)
+{
+	struct amdgpu_xcp *xcp;
+	u32 xcc_mask;
+	int i, r;
+
+	if (!xcp_mgr || xcp_id == AMDGPU_XCP_NO_PARTITION)
+		return 1;
+	for_each_xcp(xcp_mgr, xcp, i) {
+		if (xcp->id == xcp_id) {
+			r = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX,
+							&xcc_mask);
+			if (unlikely(r))
+				return 1;
+			else
+				return hweight32(xcc_mask);
+		}
+	}
+
+	return 1;
+}
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index cb15dad0e57b..914bba4a553a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3233,6 +3233,20 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	/* set CU mask */
 	gfx_v12_0_compute_mqd_set_cu_mask(adev, mqd, prop);
 
+	/* If non-zero, assume cwsr is enabled */
+	if (prop->ctx_save_area_addr) {
+		mqd->cp_hqd_persistent_state |=
+			(1 << CP_HQD_PERSISTENT_STATE__QSWITCH_MODE__SHIFT);
+		mqd->cp_hqd_ctx_save_base_addr_lo =
+			lower_32_bits(prop->ctx_save_area_addr);
+		mqd->cp_hqd_ctx_save_base_addr_hi =
+			upper_32_bits(prop->ctx_save_area_addr);
+		mqd->cp_hqd_ctx_save_size = prop->ctx_save_area_size;
+		mqd->cp_hqd_cntl_stack_size = prop->ctl_stack_size;
+		mqd->cp_hqd_cntl_stack_offset = prop->ctl_stack_size;
+		mqd->cp_hqd_wg_state_offset = prop->ctl_stack_size;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 7abb9d95ef59..a80d4dba758e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -27,6 +27,7 @@
 #include "mes_userqueue.h"
 #include "amdgpu_userq_fence.h"
 #include "amdgpu_trace.h"
+#include "amdgpu_trap.h"
 
 #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
 #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
@@ -120,6 +121,7 @@ static int convert_to_mes_priority(int priority)
 static int mes_userq_map(struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
+	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
 	struct amdgpu_device *adev = uq_mgr->adev;
 	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
 	struct amdgpu_mqd_prop *userq_props = queue->userq_prop;
@@ -151,24 +153,37 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
 	queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
 	queue_input.wptr_mc_addr = queue->wptr_obj.gpu_addr;
 
+	if (fpriv->trap_obj) {
+		queue_input.tba_addr = fpriv->trap_obj->tba_gpu_va_addr;
+		queue_input.tma_addr = fpriv->trap_obj->tma_gpu_va_addr;
+		queue_input.trap_en = !amdgpu_trap_has_dbg_wa(adev);
+	}
+
 	if (mes->use_rs64mem) {
 		if (!uq_mgr->proc_ctx_allocated) {
-			r = amdgpu_mes_alloc_proc_ctx_index(mes, &uq_mgr->proc_ctx_array_index);
+			r = amdgpu_mes_alloc_proc_ctx_index(mes,
+							    &uq_mgr->proc_ctx_array_index);
 			if (r) {
-				DRM_ERROR("Failed to allocate userq process index err:%d\n", r);
+				DRM_ERROR("Failed to allocate userq process index err:%d\n",
+					  r);
 				return r;
 			}
 			uq_mgr->proc_ctx_allocated = true;
 		}
 
-		r = amdgpu_mes_alloc_gang_ctx_index(mes, &queue->gang_ctx_array_index);
+		r = amdgpu_mes_alloc_gang_ctx_index(mes,
+						    &queue->gang_ctx_array_index);
 		if (r) {
 			DRM_ERROR("Failed to allocate userq gang index err:%d\n", r);
 			return r;
 		}
-		queue_input.process_context_array_index = uq_mgr->proc_ctx_array_index;
-		queue_input.gang_context_array_index = queue->gang_ctx_array_index;
+
+		queue_input.process_context_array_index =
+			uq_mgr->proc_ctx_array_index;
+		queue_input.gang_context_array_index =
+			queue->gang_ctx_array_index;
 	}
+
 	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
 	amdgpu_mes_unlock(&adev->mes);
@@ -179,7 +194,9 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
 
 	amdgpu_mes_userq_queue_mapped(adev);
 
-	DRM_DEBUG_DRIVER("Queue (doorbell:%d) mapped successfully\n", userq_props->doorbell_index);
+	DRM_DEBUG_DRIVER("Queue (doorbell:%d) mapped successfully\n",
+			 userq_props->doorbell_index);
+
 	return 0;
 }
 
@@ -403,6 +420,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 
 	if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
 		struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
+		struct amdgpu_trap_params trap_params;
 
 		if (mqd_user->mqd_size != sizeof(*compute_mqd)) {
 			DRM_ERROR("Invalid compute IP MQD size\n");
@@ -410,7 +428,8 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 			goto free_mqd;
 		}
 
-		compute_mqd = memdup_user(u64_to_user_ptr(mqd_user->mqd), mqd_user->mqd_size);
+		compute_mqd = memdup_user(u64_to_user_ptr(mqd_user->mqd),
+					  mqd_user->mqd_size);
 		if (IS_ERR(compute_mqd)) {
 			r = PTR_ERR(compute_mqd);
 			goto free_mqd;
@@ -421,6 +440,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 			kfree(compute_mqd);
 			goto free_mqd;
 		}
+
 		r = amdgpu_userq_input_va_validate(adev, queue,
 						   compute_mqd->eop_va, 2048,
 						   &queue->userq_vas.va.eop);
@@ -432,29 +452,68 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 
 		userq_props->eop_gpu_addr = compute_mqd->eop_va;
 		userq_props->hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_NORMAL;
-		userq_props->hqd_queue_priority = AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM;
+		userq_props->hqd_queue_priority =
+			AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM;
 		userq_props->hqd_active = false;
 		userq_props->tmz_queue =
 			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
+
+		if (amdgpu_trap_is_enabled(adev)) {
+			struct amdgpu_fpriv *fpriv =
+				uq_mgr_to_fpriv(queue->userq_mgr);
+			int num_xcc;
+
+			num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr,
+							 fpriv->xcp_id);
+			trap_params.ctx_save_area_address =
+				compute_mqd->ctx_save_area_va;
+			trap_params.cwsr_sz =
+				compute_mqd->ctx_save_area_size;
+
+			r = amdgpu_bo_reserve(queue->vm->root.bo, false);
+			if (r) {
+				kfree(compute_mqd);
+				goto free_mqd;
+			}
+
+			r = amdgpu_userq_input_trap_params_validate(
+				queue, &trap_params);
+			amdgpu_bo_unreserve(queue->vm->root.bo);
+			if (r) {
+				kfree(compute_mqd);
+				goto free_mqd;
+			}
+
+			userq_props->ctx_save_area_addr =
+				compute_mqd->ctx_save_area_va;
+			userq_props->ctx_save_area_size =
+				compute_mqd->ctx_save_area_size;
+			userq_props->ctl_stack_size =
+				adev->trap_info->cwsr.xcc_ctl_stack_sz * num_xcc;
+		}
+
 		kfree(compute_mqd);
 	} else if (queue->queue_type == AMDGPU_HW_IP_GFX) {
 		struct drm_amdgpu_userq_mqd_gfx11 *mqd_gfx_v11;
 		struct amdgpu_gfx_shadow_info shadow_info;
 
 		if (adev->gfx.funcs->get_gfx_shadow_info) {
-			adev->gfx.funcs->get_gfx_shadow_info(adev, &shadow_info, true);
+			adev->gfx.funcs->get_gfx_shadow_info(adev,
+							     &shadow_info, true);
 		} else {
 			r = -EINVAL;
 			goto free_mqd;
 		}
 
-		if (mqd_user->mqd_size != sizeof(*mqd_gfx_v11) || !mqd_user->mqd) {
+		if (mqd_user->mqd_size != sizeof(*mqd_gfx_v11) ||
+		    !mqd_user->mqd) {
 			DRM_ERROR("Invalid GFX MQD\n");
 			r = -EINVAL;
 			goto free_mqd;
 		}
 
-		mqd_gfx_v11 = memdup_user(u64_to_user_ptr(mqd_user->mqd), mqd_user->mqd_size);
+		mqd_gfx_v11 = memdup_user(u64_to_user_ptr(mqd_user->mqd),
+					  mqd_user->mqd_size);
 		if (IS_ERR(mqd_gfx_v11)) {
 			r = PTR_ERR(mqd_gfx_v11);
 			goto free_mqd;
@@ -470,7 +529,9 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 			kfree(mqd_gfx_v11);
 			goto free_mqd;
 		}
-		r = amdgpu_userq_input_va_validate(adev, queue, mqd_gfx_v11->shadow_va,
+
+		r = amdgpu_userq_input_va_validate(adev, queue,
+						   mqd_gfx_v11->shadow_va,
 						   shadow_info.shadow_size,
 						   &queue->userq_vas.va.shadow);
 		if (r) {
@@ -479,7 +540,8 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 			goto free_mqd;
 		}
 
-		r = amdgpu_userq_input_va_validate(adev, queue, mqd_gfx_v11->csa_va,
+		r = amdgpu_userq_input_va_validate(adev, queue,
+						   mqd_gfx_v11->csa_va,
 						   shadow_info.csa_size,
 						   &queue->userq_vas.va.csa);
 		amdgpu_bo_unreserve(queue->vm->root.bo);
@@ -492,13 +554,15 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 	} else if (queue->queue_type == AMDGPU_HW_IP_DMA) {
 		struct drm_amdgpu_userq_mqd_sdma_gfx11 *mqd_sdma_v11;
 
-		if (mqd_user->mqd_size != sizeof(*mqd_sdma_v11) || !mqd_user->mqd) {
+		if (mqd_user->mqd_size != sizeof(*mqd_sdma_v11) ||
+		    !mqd_user->mqd) {
 			DRM_ERROR("Invalid SDMA MQD\n");
 			r = -EINVAL;
 			goto free_mqd;
 		}
 
-		mqd_sdma_v11 = memdup_user(u64_to_user_ptr(mqd_user->mqd), mqd_user->mqd_size);
+		mqd_sdma_v11 = memdup_user(u64_to_user_ptr(mqd_user->mqd),
+					   mqd_user->mqd_size);
 		if (IS_ERR(mqd_sdma_v11)) {
 			r = PTR_ERR(mqd_sdma_v11);
 			goto free_mqd;
@@ -509,7 +573,9 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 			kfree(mqd_sdma_v11);
 			goto free_mqd;
 		}
-		r = amdgpu_userq_input_va_validate(adev, queue, mqd_sdma_v11->csa_va,
+
+		r = amdgpu_userq_input_va_validate(adev, queue,
+						   mqd_sdma_v11->csa_va,
 						   32,
 						   &queue->userq_vas.va.csa);
 		amdgpu_bo_unreserve(queue->vm->root.bo);
@@ -524,7 +590,8 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 
 	queue->userq_prop = userq_props;
 
-	r = mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr, userq_props);
+	r = mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr,
+				     userq_props);
 	if (r) {
 		DRM_ERROR("Failed to initialize MQD for userqueue\n");
 		goto free_mqd;
@@ -533,7 +600,8 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 	/* Create per-process MES process context BO */
 	r = mes_userq_create_proc_ctx_space(uq_mgr);
 	if (r) {
-		DRM_ERROR("Failed to allocate MES process context space bo, error: %d\n", r);
+		DRM_ERROR("Failed to allocate MES process context space bo, error: %d\n",
+			  r);
 		goto free_mqd;
 	}
 
@@ -545,7 +613,8 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 	}
 
 	/* FW expects WPTR BOs to be mapped into GART */
-	r = mes_userq_create_wptr_mapping(adev, uq_mgr, queue, userq_props->wptr_gpu_addr);
+	r = mes_userq_create_wptr_mapping(adev, uq_mgr, queue,
+					  userq_props->wptr_gpu_addr);
 	if (r) {
 		DRM_ERROR("Failed to create WPTR mapping\n");
 		goto free_ctx;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 29009f6aabde..9317018330ec 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -470,6 +470,17 @@ struct drm_amdgpu_userq_mqd_compute_gfx11 {
 	 * to get the size.
 	 */
 	__u64   eop_va;
+	/**
+	 * @ctx_save_area_va: Virtual address of the GPU memory for save/restore buffer.
+	 * This must be from a separate GPU object, and use AMDGPU_INFO IOCTL
+	 * to get the size. This includes control stack, wave context and debugger memory.
+	 */
+	__u64 ctx_save_area_va;
+	/**
+	 * @ctx_save_area_size: Total size (in bytes) allocated for save/restore buffer.
+	 * Use AMDGPU_INFO IOCTL to get the size.
+	 */
+	__u32 ctx_save_area_size;
 };
 
 /* userq signal/wait ioctl */
@@ -1289,6 +1300,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
 #define AMDGPU_INFO_GPUVM_FAULT			0x23
 /* query FW object size and alignment */
 #define AMDGPU_INFO_UQ_FW_AREAS			0x24
+/* query CWSR size and alignment */
+#define AMDGPU_INFO_CWSR			0x25
 
 #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT	0
 #define AMDGPU_INFO_MMR_SE_INDEX_MASK	0xff
@@ -1668,6 +1681,20 @@ struct drm_amdgpu_info_uq_metadata {
 	};
 };
 
+/**
+ * struct drm_amdgpu_info_cwsr - cwsr information
+ *
+ * Gives cwsr related size details. User needs to allocate buffer based on this.
+ */
+struct drm_amdgpu_info_cwsr {
+	/* Control stack size */
+	__u32 ctl_stack_size;
+	/* Debug memory area size */
+	__u32 dbg_mem_size;
+	/* Minimum save area size required */
+	__u32 min_save_area_size;
+};
+
 /*
  * Supported GPU families
  */
-- 
2.34.1

