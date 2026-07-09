Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7784CC43458
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 06:59:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E43EC10F3CD;
	Thu,  9 Jul 2026 06:59:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GxX6Czpo";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011037.outbound.protection.outlook.com [52.101.57.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8505510F3CD
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 06:59:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IpGeNWIhAznjEC3zZlOeZWLR2RfQNfmVxKy8eoy7y+slv6RxWKscQFyA44uux2inpzV2BKwAnB4Rz/KGNetzMbl5rBHoRY/6m5N5u2eli4qTe8F+hhct0qnuCJ3EuRrNdxZUfi80QaPxvG4Hjw4idmRu8vx8RffMz8Sr9K9Nn/W0Nop+Ot/88wzaibneP8pGdeQPgrkkIgSLuHqkqwtQcnu97D2x71M/vajGnt7ngUuBxMSB1JXECv+EnFkR5GGptbf5ddR8STG66xSd6KHCv8OR/716vExsOwPp40vZrrcZZwZj6oCDAgr/NGRjdRdhNlai0OP+DfTJGAJ3aRXbDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDVUqzPeYI1TJ9jbDanWv9fLhHukeTV3Xazyx/aw5uU=;
 b=JG9fNwDbL3Ze85XIQazLufIL86m79zjDyRGWIuWD7/jR+m9wMsiRYnfkAfp2sKokdCgTtMuVk7KOBpov68l60HQEadIvb7rhY6AmZyPXgGGpQhQ8hz0RT/j/SAzpGLvx6NEalarvHKL4pIVaghyB4OMMxIv5mfkwFEW4SOUdGCgLQN5Xz2kImWiPvMU+pzatpA0o74YErI4d4wp4BtAQwdENZyzGb5pp6Y/NPwgOYyI2mFM5xq7Y4Yxtimvfv6HrqL+85OnOuGfGFZA0ITAMbmMzSZRa4fgL7t/54fWSd8bG02E26s/PeT94Y1hnCLFlD/Pb9W+adYRE0Z67ghBMYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDVUqzPeYI1TJ9jbDanWv9fLhHukeTV3Xazyx/aw5uU=;
 b=GxX6CzpoRgwqKzhQk01Pf0p93IAV2VH7xJcinUBtk0gpjQOztsF+nDzEvwXvPy4NSBosSng2pYy2iSTuoP2Az2W9oqIYdfL74ZS8S88TxAkjjKwfgbJwBFmE7CXcdGoqruQzjx2o2nz3+BPqe5e9jUPdj6xDmP8GGfacWjl65Do=
Received: from MW4PR04CA0069.namprd04.prod.outlook.com (2603:10b6:303:6b::14)
 by IA1PR12MB6628.namprd12.prod.outlook.com (2603:10b6:208:3a0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.15; Thu, 9 Jul
 2026 06:59:10 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:303:6b:cafe::af) by MW4PR04CA0069.outlook.office365.com
 (2603:10b6:303:6b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 06:59:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 06:59:09 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 01:59:06 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <Michael.Chen@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 2/6] drm/amdgpu/mes: add MES process/gang context size and
 bitmap helper
Date: Thu, 9 Jul 2026 14:58:52 +0800
Message-ID: <20260709065856.472296-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709065856.472296-1-Prike.Liang@amd.com>
References: <20260709065856.472296-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|IA1PR12MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: b03dc009-f516-44aa-2194-08dedd8793a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|23010399003|82310400026|6133799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: hZRkkwIePugTiHHXH0ZCee54eU4hMdk0Z40blPoP6vHbdqzPJ7RyL1VKi6uv2mWw64Voz0itvS0QPK78C2qgxCynyd3p1CruNnTiskK8EaZ1WgCG+t6bShYoRiek7vMYHg6Ww7r2JzgV3vX9jkM7jsrPS+/zb4HZ89cQg5KgKts8o47yfYVPGlclw07aZjYCLhSqFrUSVTt9epfJ5auIUdlGY34Vunzfp6pvjTU2S8u7K8tW3thdUVIhG+0/k8IVDEchQWgbuIJtndtGOdAX8f7Nf0qhzi9qCAowISGlw0Gn4YzxjdouY+YDxIlzAhPSFvwqbUK93WN54eAbo7xqUDb+ALVNMFKGqdd6XQ9mWA5S7DbiVtB5Sef4lzMDDx3xbH4sLC0OtSHPtQG0cdVSWJunQga2KRhfiK215LEWfgLldb9hBBl85OUIIPwwcgwD/zwTAc63/2fWs6Wz+UYkAEChVisGOqEUg89XNjjn9F/Tr1sIreWP22IQLVWofwD1AyotM0hHjGa14A2fME8ukjJymLqrgAsvYkgQBBxiaL7o9GhtuwbeC4CRaNzO4pavjhczvbgCd4lJLzTZny1jFuLN93TQDlb6nJYoMbDd3yOPSJep7Su+iaGIJVM5zGRzkCb0b6Eta4UinjNOS7BXxC5KOQpdyB2o2wggz5l+H35Ma8PAnuQn0XhynjCHa+cSY0G6MpCwA5aGAAt4ZsjP+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(23010399003)(82310400026)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Qa3eFNuioxSKRrmDW4PGNffeG3LMnemkI9rQs1ByWKKaVgW0M0+ljM4JBKHCk/wpuG8egeww6nV1FcPiNSUWsEJ6vkiJQWV5dDKZc0E4ZTXJaUcbyzYGOsX7FmIUMUjAW2vaKvOWW6UVdI8Gumu1hd3k28Zpc5lLE6gLa3z3wvp3gx9e93Drvfk4kUA4tAkiY4Qas9hIh1NLKIQ6bywTb9ACrw7pCKRW5FbPvrmmSkKBpkjUUzAS0aJPPZ7hg0yepEU93ZN3UOGdYk/D9JgFNQ1oxHvS5v0h+/A5TeDnZvQcslPrupxrIXBbWQHiScmQ1BMKxTkW2uPA4C6g37RXq30htfmRZ7wytPDcpJswi25ZS67ZptQ7cYzXX9Onis3Oud0Dtw7zuKo4mh8WMtndkVEtLdjg1gPaC+m0yEqjzhnrJvvBGZyc7cixW3n/4HKP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 06:59:09.9042 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b03dc009-f516-44aa-2194-08dedd8793a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6628
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

Allocating the MES context bitmap to track the process/gang index usage.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 70 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  9 +++-
 2 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 8ba1c941c03d..f65f2a30154d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -962,9 +962,79 @@ void amdgpu_mes_rs64mem_fini(struct amdgpu_mes *mes)
 				      &mes->ctx_array_size_gpu_addr,
 				      (void **)&mes->ctx_array_size_cpu_ptr);
 	}
+	
+	bitmap_free(mes->proc_ctx_bitmap);
+	bitmap_free(mes->gang_ctx_bitmap);
 	mes->use_rs64mem = false;
 }
 
+/**
+ * amdgpu_mes_rs64mem_setup_bitmaps - allocate bitmaps after querying MES
+ *
+ * Called after QUERY_SCHEDULER_STATUS returns and MES has written
+ * the array sizes to the GPU buffer. Reads the sizes and allocates
+ * the tracking bitmaps.
+ *
+ * @mes: MES instance
+ *
+ * Returns 0 on success, negative errno on failure.
+ */
+int amdgpu_mes_rs64mem_setup_bitmaps(struct amdgpu_mes *mes)
+{
+	struct amdgpu_device *adev = container_of(mes, struct amdgpu_device, mes);
+
+	if (!mes->use_rs64mem || !mes->ctx_array_size_cpu_ptr)
+		return 0;
+
+	/*
+	 * MES FW wrote the sizes to the GPU buffer:
+	 *   ctx_array_size_cpu_ptr[0] = proc_ctx_array_size (N)
+	 *   ctx_array_size_cpu_ptr[1] = gang_ctx_array_size (M)
+	 */
+	mes->proc_ctx_array_size = mes->ctx_array_size_cpu_ptr[0];
+	mes->gang_ctx_array_size = mes->ctx_array_size_cpu_ptr[1];
+
+	/* Sanity check - MES FW typically returns N=50, M=300 */
+	if (mes->proc_ctx_array_size == 0 || mes->gang_ctx_array_size == 0) {
+		dev_warn(adev->dev,
+			 "MES returned zero ctx array sizes (proc=%u, gang=%u), "
+			 "disabling RS64 local memory optimization\n",
+			 mes->proc_ctx_array_size, mes->gang_ctx_array_size);
+		mes->use_rs64mem = false;
+		return 0;
+	}
+
+	/* Cap to safety limits */
+	if (mes->proc_ctx_array_size > AMDGPU_MES_PROC_CTX_ARRAY_MAX)
+		mes->proc_ctx_array_size = AMDGPU_MES_PROC_CTX_ARRAY_MAX;
+	if (mes->gang_ctx_array_size > AMDGPU_MES_GANG_CTX_ARRAY_MAX)
+		mes->gang_ctx_array_size = AMDGPU_MES_GANG_CTX_ARRAY_MAX;
+
+	dev_info(adev->dev,
+		 "MES RS64 local memory: proc_ctx_array_size:%u, "
+		 "gang_ctx_array_size:%u\n",
+		 mes->proc_ctx_array_size, mes->gang_ctx_array_size);
+
+	/* Allocate bitmaps */
+	mes->proc_ctx_bitmap = bitmap_zalloc(mes->proc_ctx_array_size,
+					     GFP_KERNEL);
+	if (!mes->proc_ctx_bitmap) {
+		mes->use_rs64mem = false;
+		return -ENOMEM;
+	}
+
+	mes->gang_ctx_bitmap = bitmap_zalloc(mes->gang_ctx_array_size,
+					     GFP_KERNEL);
+	if (!mes->gang_ctx_bitmap) {
+		bitmap_free(mes->proc_ctx_bitmap);
+		mes->proc_ctx_bitmap = NULL;
+		mes->use_rs64mem = false;
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 static int amdgpu_debugfs_mes_event_log_show(struct seq_file *m, void *unused)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 520bcd8ee202..5c50bc9616b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -54,7 +54,8 @@ enum amdgpu_mes_priority_level {
 
 #define AMDGPU_MES_PROC_CTX_SIZE 0x1000 /* one page area */
 #define AMDGPU_MES_GANG_CTX_SIZE 0x1000 /* one page area */
-
+#define AMDGPU_MES_PROC_CTX_ARRAY_MAX  128
+#define AMDGPU_MES_GANG_CTX_ARRAY_MAX  512
 struct amdgpu_mes_funcs;
 
 enum amdgpu_mes_pipe {
@@ -176,6 +177,11 @@ struct amdgpu_mes {
 	struct amdgpu_bo		*ctx_array_size_bo;
 	uint64_t			ctx_array_size_gpu_addr;
 	uint32_t			*ctx_array_size_cpu_ptr;
+
+	uint32_t			proc_ctx_array_size;
+	unsigned long			*proc_ctx_bitmap;
+	uint32_t			gang_ctx_array_size;
+	unsigned long			*gang_ctx_bitmap;
 };
 
 struct amdgpu_mes_hung_queue_hqd_info {
@@ -624,4 +630,5 @@ int amdgpu_mes_update_enforce_isolation(struct amdgpu_device *adev);
 
 int amdgpu_mes_rs64mem_init(struct amdgpu_mes *mes);
 void amdgpu_mes_rs64mem_fini(struct amdgpu_mes *mes);
+int amdgpu_mes_rs64mem_setup_bitmaps(struct amdgpu_mes *mes);
 #endif /* __AMDGPU_MES_H__ */
-- 
2.34.1

