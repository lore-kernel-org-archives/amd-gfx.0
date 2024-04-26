Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E710C19F4F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 13:48:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE86E112407;
	Fri, 26 Apr 2024 13:48:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4dhjv0Zq";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2071.outbound.protection.outlook.com [40.107.102.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC3F4112407
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 13:48:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUZXGOU5kZp6HcIr12poToml/oqvx3WJpDqOocsp0fhB4RccuN939W+6eURK7HDf8e2pOR51ByEjjeOzSDMXaDk7eXwvSYDATOT1OWXaA/0MwKk9MsWmngiB3nRI0hasjMsUI7UCsvCCHOiK9hC8CP+tvgNMn0Kix+NY6ttA9OdRNUAv5GbJF+qK+S6en1xrQIj7tBkQmdVipqD/cfX1JadoDRcQo3XjwkhIF130awalyYLNdMv2Mms4i4yfWFkZpySjH4PbZgddyaOdPUaE6Py7UMwtl8VfTqdJMHSTy5nqS3XYAOhvkT3hzXOomBgtHWP8bnIayeaBMZr6U6pKHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0AfEMcZN/spc4fqJJz7vQTslYYFHem7XaOgFaHojCU=;
 b=cMR+QzglLqLqkwOWPwSJcrxX98kkCFGlGEWzNjkMyEevI/CwScwY4jo8SmqPSoloHlKIPuYzhZx5INliksnfd+KzkRvFsMW8aZGqkZlGeqKUDCHzYO77jQqKPoME6tiasr4NmOrpYwVU2/8NuX8GeHytDa2BFLb6yANn92KhnBUOzEaYh1Px98pdYoqZZsT7I2+2wD37JppdOfPj3p2WsWswsXLvW2rNjqjBfYQP8huZRCVewuddntJrWEkRaSeolDGKt7GMC63t2sAPHGILK/hXnAVMOFWD3srbLZfIC0ZS1t5wjDlOLoVhDl5Yy2jn5uuzTCrbVRk/ANHSfK/qng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0AfEMcZN/spc4fqJJz7vQTslYYFHem7XaOgFaHojCU=;
 b=4dhjv0ZqHLrtfEZ+2MyUgLzwlrSYiZQGlWaVsaNdLviHtQyA7zLHytuUylr42219TjDWo/XSfKoiYZIW0KWYBRnG+n2HpVP9D/dYRTrORq7LDlCtIuaU8G1e/8JfQnAVoflrqq5HkzQs3Ke+ngMlrLKN6CvIFr6jR31sDIGYyxI=
Received: from CH2PR20CA0002.namprd20.prod.outlook.com (2603:10b6:610:58::12)
 by SN7PR12MB7226.namprd12.prod.outlook.com (2603:10b6:806:2a9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 13:48:46 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::b7) by CH2PR20CA0002.outlook.office365.com
 (2603:10b6:610:58::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.29 via Frontend
 Transport; Fri, 26 Apr 2024 13:48:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 26 Apr 2024 13:48:46 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 08:48:44 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Arvind Yadav <arvind.yadav@amd.com>, Shashank Sharma
 <shashank.sharma@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Subject: [PATCH v9 06/14] drm/amdgpu: create context space for usermode queue
Date: Fri, 26 Apr 2024 15:48:02 +0200
Message-ID: <20240426134810.1250-7-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240426134810.1250-1-shashank.sharma@amd.com>
References: <20240426134810.1250-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|SN7PR12MB7226:EE_
X-MS-Office365-Filtering-Correlation-Id: 33756251-764d-4509-7671-08dc65f7981c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BbGk2O8zjc44+ZAi+To+aKfMaZFotsOA8sHTIPfFLcNlrIBp5BG/xgXOYdUd?=
 =?us-ascii?Q?REheFAgILYsVGLmjNALNhD3VUR/qEKHlmTKU6Pb2876oJ4SlOUep+/2NWhWH?=
 =?us-ascii?Q?7vJuhLSs7tCb+prwfEn0DUC2h0kczXel0m6bSH23cwfkCzalViRKidgjy923?=
 =?us-ascii?Q?ZePXK1PEYRI655TnaM0Gf44SAjgD4R0R5DeByRyvf+HarKDnNUgRztTC99YO?=
 =?us-ascii?Q?85USdP775Y9rMexQw5bjjeoRfZa0yCozHcnJt9KEuiCylnq0ehCIBrkiAe0C?=
 =?us-ascii?Q?X19egkV+taxRG0eLj2G+LQYyv1XyDkOJ9EMp331LMOmnbR63avibPViHUkWq?=
 =?us-ascii?Q?pucwZst2mtu9yBq8eEuBjZjPBegqtnuStcU6vTsqNTNauWgruPsfV9Ok5kh9?=
 =?us-ascii?Q?iHjhi3vFDOMUKf7lzOpwtmW3rQjAk4TwwrimrzFt1IVJZMoEvsM1WB+Y7HCc?=
 =?us-ascii?Q?I5PNGTJuBmV55NdfRNBAcQJ8UVGj8kATY33s/V3ojoZpjEgeaIoR5E5hsMk9?=
 =?us-ascii?Q?RXxpCNfQ+M9qg6Rf5Rln2GTWloBZGWRnYgHOZ7x0y2ZjIMZUpJahLJtBgYgI?=
 =?us-ascii?Q?XVBiYtDtFUGxxxuhTaL/UvZV7zeKR1Zl0YWA83Rx4/EKH0IXtOlnKOppdCXc?=
 =?us-ascii?Q?K2wvScAjpSIJtNhbtEDsfTCZkFk63WHQSuTaK7HDFTWNYAnWM8F0ctP5v8yx?=
 =?us-ascii?Q?kQUDczW6F0O2KBXVq8sMk69ZiGa7mIwAZjX7wXqZBMF0MGn/y3LUz6TCkYI6?=
 =?us-ascii?Q?wH59Ny76OKK6Z2bxJuNQvpwQNwJz/DsGKNqKpLX6lOxbEH9n/Hf8eibhKR7Q?=
 =?us-ascii?Q?yzZHCDh6cg/6UyGRxYBHjsGkrXR2znoav5SjckyRhzovdr0k1jaj0xKUEvLy?=
 =?us-ascii?Q?aOeugUOfhM5yFyNcPW1rDis8idaahH+yTpKddGF/BFjfm6jvFXXK9Y2utp93?=
 =?us-ascii?Q?QoEMmrbUiW+lYSkCcdfm625xUkCQZrWX4J4gI/UUrrt9Xbi6S8xG0y8hTcPU?=
 =?us-ascii?Q?cBiZkiBmptPIRDSCKRCVZ6rXpE6ot1tC2Kf6B8xdK5zts1wFz9Oq/JkJ+OBe?=
 =?us-ascii?Q?FfBu36PLYh8SXSFgJcMuS3yzN8rkR0ISVrYVi56ulTx/bV3+qY9UKjmF8Mz1?=
 =?us-ascii?Q?/0CjFJbPa/yPUFDZxYE1dlBvlF0JK+TdeJ3iCaFCTQBqdkSl7tTmlCtDO4xY?=
 =?us-ascii?Q?MMWZitSxESylAU84F/M3JfAEpYkzY3/HQOtoRTPeK7SJ04MnpT9mSwBEJYRh?=
 =?us-ascii?Q?CjrnbsVxLmVX6he7sNRcG32gOKVc4t7G8goZis5HsAJnM+qrqnFtZn0ZfN1O?=
 =?us-ascii?Q?9OVow5NkJhCjlWUAANJ8oMh9wN3824MCeLNIVoKXZwLengoq0Ud0r4KPx/nO?=
 =?us-ascii?Q?1qs0dOYvZ6zcsGXxm7GyqGyqsyuV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 13:48:46.2003 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33756251-764d-4509-7671-08dc65f7981c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7226
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

V7:
   - Using helper function to create/destroy userqueue objects.
   - Removed FW object space allocation.

V8:
   - Updating FW object address from user values.

V9:
   - uppdated function name from gfx_v11_* to mes_v11_*

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c  | 43 +++++++++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  1 +
 2 files changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
index 9e7dee77d344..9f9fdcb9c294 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
@@ -27,6 +27,41 @@
 #include "mes_v11_0.h"
 #include "amdgpu_userqueue.h"
 
+#define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
+#define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
+
+static int mes_v11_0_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
+					    struct amdgpu_usermode_queue *queue,
+					    struct drm_amdgpu_userq_mqd *mqd_user)
+{
+	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
+	struct v11_gfx_mqd *mqd = queue->mqd.cpu_ptr;
+	int r, size;
+
+	/*
+	 * The FW expects at least one page space allocated for
+	 * process ctx and gang ctx each. Create an object
+	 * for the same.
+	 */
+	size = AMDGPU_USERQ_PROC_CTX_SZ + AMDGPU_USERQ_GANG_CTX_SZ;
+	r = amdgpu_userqueue_create_object(uq_mgr, ctx, size);
+	if (r) {
+		DRM_ERROR("Failed to allocate ctx space bo for userqueue, err:%d\n", r);
+		return r;
+	}
+
+	/* Shadow and GDS objects come directly from userspace */
+	mqd->shadow_base_lo = mqd_user->shadow_va & 0xFFFFFFFC;
+	mqd->shadow_base_hi = upper_32_bits(mqd_user->shadow_va);
+
+	mqd->gds_bkup_base_lo = mqd_user->gds_va & 0xFFFFFFFC;
+	mqd->gds_bkup_base_hi = upper_32_bits(mqd_user->gds_va);
+
+	mqd->fw_work_area_base_lo = mqd_user->csa_va & 0xFFFFFFFC;
+	mqd->fw_work_area_base_hi = upper_32_bits(mqd_user->csa_va);
+	return 0;
+}
+
 static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 				      struct drm_amdgpu_userq_in *args_in,
 				      struct amdgpu_usermode_queue *queue)
@@ -82,6 +117,13 @@ static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		goto free_mqd;
 	}
 
+	/* Create BO for FW operations */
+	r = mes_v11_0_userq_create_ctx_space(uq_mgr, queue, mqd_user);
+	if (r) {
+		DRM_ERROR("Failed to allocate BO for userqueue (%d)", r);
+		goto free_mqd;
+	}
+
 	return 0;
 
 free_mqd:
@@ -100,6 +142,7 @@ static void
 mes_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
 			    struct amdgpu_usermode_queue *queue)
 {
+	amdgpu_userqueue_destroy_object(uq_mgr, &queue->fw_obj);
 	kfree(queue->userq_prop);
 	amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
 }
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index bbd29f68b8d4..643f31474bd8 100644
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
2.43.2

