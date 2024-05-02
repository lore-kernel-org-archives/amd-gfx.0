Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C622C4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 16:32:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00054112582;
	Thu,  2 May 2024 16:32:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fGE+2XUg";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBB23112582
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 16:32:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMoKx39hLI9ZuL9RnAhhwkAg+/AnAEEmGqcDy50hPazKWwy7Du6RLoaYCFrvr1xZe63vnok4nY3AJUtOpqoywK9+b7lhA/lbljd7VwJmoyUDuW+7XDBYJiZUlhalX6QCoz8v1d4wUT48ymGJ9zQxuOt952CPzY8nSdZ6b314ulh23XxlAEWswZ2iHlig01IMCUOZjUEkxemTfbO6zSrF97IeNtCDRSaGJztn1lt6t+zfm6/jbEH3FfwvqsXEr+9xcknLC8An1IXHAlNuHad7UiIo3Ek+KXzlCnUggiFZsjzDCGLCwvFGV7j4LBIBooUidJbAcLS+xV2NR9CBrxDTYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ua0vJXzr7bJImowqppGrM7k7+qZjQDFeytiLU4Mb+dY=;
 b=h2oUlRgCeQo6i0/yzGyF7CmWOdFVHEbF1arQ7pINQiHLbNicubB3ejDGqryNqOi+OcPQFMy7KUAiPz0WzRKDBS9oHutZzjuCNicGRJ7D7i66bGoPHgjY7DfRkjW0h325evUO6KX3faHU4uE5uwW3mEVkw1Ub4KK1enXggNhICn7+2AEPXfmZwf5exEqgtsOdBZedVE4pcTKxd9x7ElNbDyRiTZmyYYSBRiNZ7NffpBqmS81hwAuRKCErVzmY/LzHxwQgKImwMXsBtZ0ZcI0qIp/2HyIw7dOadVwZCcFcPwIk12yr4UZrdAQizhl3TCQj1BDgKNml/0JHjb8m+CK6kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ua0vJXzr7bJImowqppGrM7k7+qZjQDFeytiLU4Mb+dY=;
 b=fGE+2XUgRaKR8X7NuTyuIMR9g7kJFC0FQZOtllg5dPPsj8GXdTiS2nLJqW7SwZi+5n1ningHEyIY6wFUZg+VQvvhDvjMVQyg49WDbLEPBKX5U9Zhziq5WlKy8rAmiaxtfk+lVHpFXcVKtMhKhqU8QiGPkuCt/fTbt4em76nW28E=
Received: from CH0PR07CA0026.namprd07.prod.outlook.com (2603:10b6:610:32::31)
 by DS7PR12MB8323.namprd12.prod.outlook.com (2603:10b6:8:da::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.29; Thu, 2 May 2024 16:32:36 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:610:32:cafe::de) by CH0PR07CA0026.outlook.office365.com
 (2603:10b6:610:32::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30 via Frontend
 Transport; Thu, 2 May 2024 16:32:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 2 May 2024 16:32:35 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 2 May
 2024 11:32:29 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Arvind Yadav <arvind.yadav@amd.com>, Shashank Sharma
 <shashank.sharma@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Subject: [PATCH v10 06/14] drm/amdgpu: create context space for usermode queue
Date: Thu, 2 May 2024 18:31:43 +0200
Message-ID: <20240502163152.1382-7-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240502163152.1382-1-shashank.sharma@amd.com>
References: <20240502163152.1382-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|DS7PR12MB8323:EE_
X-MS-Office365-Filtering-Correlation-Id: 88ee64a0-7d81-412f-ec6f-08dc6ac5797a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|36860700004|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/MmW7dbbq1S5yJFPS+UvW97vPaWf8ouZUNakykaNvic3yaM0gB6+PGYiaSAr?=
 =?us-ascii?Q?H2QVGtnjPNpg8Sjd06myIGTTSbQaBZCu0ZflNbFQdnpza6c6pXHXqnmmVoeA?=
 =?us-ascii?Q?06FtJTFbIyUjoaYjlT+rJy0B+F9iuAZ6V7yIo9KtrfAVBjGYAqeLfJc7sHDk?=
 =?us-ascii?Q?SKw1motYiLKBvoo53x6u7H8YUlpmmhoEeDimR8wdbo9FxL33l4qJrP5hZA97?=
 =?us-ascii?Q?E33V4Hl5pZzHtUUU/rgoM7T0A2YbZZTT1V27YNE5uMKDNd1mS9NI2jIM+IJT?=
 =?us-ascii?Q?4zfBmFX5fUXCydzpeTckNCjgwK+EBxXSmSEF70L1LPTNEf2dwAesdjU669zg?=
 =?us-ascii?Q?PgtcG5P/zNdadGHcekeXvKGaiRbLAamzLjGiIa/sOM5XePcSUaZKaLpu6V14?=
 =?us-ascii?Q?FdSi8KohtYZj7ga0hEIIuNJMcCPJ6AQBl7LTL3BWo+JdVj5Q/t13HEyi1Ano?=
 =?us-ascii?Q?/CZ1PHD2H8H3ZdZ3WM5HlzGtB/3TwaIHcTbfv/1sOyBP3ad2MN+WKCzf0Wnk?=
 =?us-ascii?Q?qN/eGPPyyTre9D8GkUXRkXwnMnYzOfvY9XUCkbVpu5JUU4fuj+JKNAkHhfWH?=
 =?us-ascii?Q?EUHYvsLkZRJd2knCnLGKpumQ68etHLvLbm5regxXwcZ7H1RZb24jtL1Aj2e8?=
 =?us-ascii?Q?BwktuI48SjK2hhk4FE8oqFn00e0S2h6IiY//LgqFJRDJVD7oWOyoFXQFexUn?=
 =?us-ascii?Q?9rOgelGfHzdot5YsuPwkqBicUDRRl5XgNKWKKzlOxKrrv5oILoDmZYqRcPFB?=
 =?us-ascii?Q?73aw2Fxikw0Rj+Te+XUK1+4Zb5M5gSg3T1RM/tVSoehTxbtQ3FTTSOQ50BuJ?=
 =?us-ascii?Q?gnm2C0HNPF1lxQ7Gxt0J3zS73oxO4CUu6xEfVgGnaruF+aiphdoGTDjqlaSK?=
 =?us-ascii?Q?9K3OcNRCGvZx0I21BnO9RZU+dOH6GtVHi7Trkg+T0ms18FhQ8h+GJkv6TLzV?=
 =?us-ascii?Q?PdaNLfQrEvBwFujKISa2WBdy5+GDy+0XJrbxynNQvaFUMo8ZIHQIKPdxJZx7?=
 =?us-ascii?Q?GCMgDRyW60WLGrJw16iQ6D9aE6WiJ0k0iimCDgTgdAvufBNZJO+j0eAXanba?=
 =?us-ascii?Q?qZo1+MKvAPAGAV07IAs3VFCvO2wZB1VBBHiefkZFR5x/5bDYKP2bIK9o/k0w?=
 =?us-ascii?Q?QQrBfpaUnM3TIcF0bFKkOUfhzQDvvMkuZAvObb1QfoeXZoqsLHjW44vUE3ZC?=
 =?us-ascii?Q?iOHB3F8M7BneNbFr6XrZupAhadSzvz1hr+iTXiZVkq7Xv1RhepTGN5Qu0Wjz?=
 =?us-ascii?Q?C8Qq19ihWcC8U86YBJkpGSB5yECSw/9FaCZDRrP7hMPmUHbEiGdhQQP1Nj/O?=
 =?us-ascii?Q?6ehLpbbD+iD+QwRsItYtdJA+bgIogGpKRkXDcJRa0KJHoZ495LAIoNMvox/8?=
 =?us-ascii?Q?eG1TKhQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 16:32:35.7249 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ee64a0-7d81-412f-ec6f-08dc6ac5797a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8323
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

The MES FW expects us to allocate at least one page as context
space to process gang and process related context data. This
patch creates a joint object for the same, and calculates GPU
space offsets of these spaces.

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

V10:
   - making this patch independent of IP based changes, moving any
     GFX object related changes in GFX specific patch (Alex)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Acked-by: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c  | 33 +++++++++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  1 +
 2 files changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
index 75d7c58418c8..58cfc956cddd 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
@@ -27,6 +27,31 @@
 #include "mes_v11_0.h"
 #include "mes_v11_0_userqueue.h"
 
+#define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
+#define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
+
+static int mes_v11_0_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
+					    struct amdgpu_usermode_queue *queue,
+					    struct drm_amdgpu_userq_in *mqd_user)
+{
+	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
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
+	return 0;
+}
+
 static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 				      struct drm_amdgpu_userq_in *args_in,
 				      struct amdgpu_usermode_queue *queue)
@@ -89,6 +114,13 @@ static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
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
@@ -107,6 +139,7 @@ static void
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

