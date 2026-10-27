Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED19606A31B
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 07:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=J88qxXKr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81C2910F2C3;
	Tue, 27 Oct 2026 07:51:28 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011065.outbound.protection.outlook.com
 [40.93.194.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4173A10F2C2
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 07:51:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N1tK94hqUiW2gK/jMEF4GAk4uxUo/jENzcc3BxPAVM4Ae42ccjpEBmQD1jgUDBnwNfkz4M01YXIEYjqcFQl9SH8dWrVJs24Q6/m6ZQMfWMiLuCqRAWUmVXvv8UadPCEApXO5YTbqb7K0rBPTqY/bDE1METHayFr7zaQ54QpLb0jOqOKR8giUI4buyq/Nt1kIAHGSpt3v/89SlJl8h6ARMu5M82VzWRoKxNkACaDBI8si6MmABokvqRe/wJnrQdEgJY0bXCqIhR5bouqxGtbL+mCjZRcCGF/R0wQi2E5knexos5AQ+XxkmIeoiKwUNMgWxTtWVTvw3QncrscAKooFcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+eLyshoyy1gK/pmLH0viQfjRge79b6GAOU5qCZr4Fg=;
 b=hdQhT91FSkZusHnbWnQ4A+X3o+JGHSCVpI6udGeif2QSbcSpbuPs8/2cdkGgzi8w1nXryryleyGBshwIRuuxVkfqs4l9zf8bHBNvSfq+X8/2eOZmnQFzIRrpJpjRLjwI95zog35SbLWm75mJu0WDh83gt9v3GGoCOlrVLNQl4LTsNkjrccKGFFNxmc2CezVSKKSPIFDIvJCYWfS9pbIJgjACcX6ON3mCt6UKH3sGQ/uIMFKWr/AlfyNXRDLEADdmh5kqG7A6uiTpz7uemZWJh3yLETsli52HuIgn2301XKoxETcIPKdovAeaKRJECpHSZ+xgKiXbZj/77KaZTrXVsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+eLyshoyy1gK/pmLH0viQfjRge79b6GAOU5qCZr4Fg=;
 b=J88qxXKrpQryLco2lx0sxjv96sFeXWOT0shIjEicTI4nJ2M2Sc+Pop5sAk6beRYNRcPAIEQN3TyE60Wf9ocfm6qYIxEIsXU5T+o/llkhiCeyF4HVcG11HKrXASZtWwpWhssldUyazgnEguFoDm02fZmPlsRj+6D3wGFeEElaQGg=
Received: from BY5PR04CA0004.namprd04.prod.outlook.com (2603:10b6:a03:1d0::14)
 by DS0PR12MB6391.namprd12.prod.outlook.com (2603:10b6:8:cd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 07:51:14 +0000
Received: from CO1PEPF00012E80.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::3) by BY5PR04CA0004.outlook.office365.com
 (2603:10b6:a03:1d0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 07:51:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E80.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 07:51:13 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 02:51:11 -0500
From: Amber Lin <amber.lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Amber Lin <amber.lin@amd.com>
Subject: [PATCH v2 3/4] drm/amdgpu: No need of mutiple hung_queue_db_array
Date: Tue, 27 Oct 2026 03:50:06 -0400
Message-ID: <20261027075017.121456-3-amber.lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027075017.121456-1-amber.lin@amd.com>
References: <20261027075017.121456-1-amber.lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E80:EE_|DS0PR12MB6391:EE_
X-MS-Office365-Filtering-Correlation-Id: c16e7968-d4c8-496e-71b0-08df33ff1301
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|261026121527099003|5023799004|11063799006|56012099006|261021123027099003|261021121427099003|261022105027099003|261009223027099003|10067099003|18002099003|22082099003|6133799003|261026140227099003;
X-Microsoft-Antispam-Message-Info: XeivQJnNMlqaD62JQ3cNu1qRFykEwSGKbDeBGEfimTsAqc6E/6vh9Sr/RMIVL9kSxNkxOduIIjCYv0FUg8IbIl39UyyhDfGZdz5pzvYzu0IL5icOryX0SwZmKnAbVTsQIwTKb2B7eQxTEny7A1gEai8saNEs0FnhJ96wfwjFr9G6rd+6D0keskdk0C4mDqEbWSqi3BcNmd+wMuNwRm92ay0/3mxiTijI4ka/xNnRPSB9knvgYptF4HXtKcH5Y8mRjuGVxtWtXsQEEFsMYSusYMzcj6ma9AZRvhVeiJvSgQRAOf/usCs/aaFaq5F03b22XhKgw5vu5iQ/n8MvPplX5nbaBlHuwE1/FukwDiju1KmSg8asf526YDhhVwF4ulDt/LWJN3hz4JEnhXbtrwxiJjJ7+h94mSkzIfZDCM9OnPz7f9mrzj3qwptPgxymWciuM3VTq/GAIhkaZh/mbLBwAVVPhRjJQrG4YoXYn7qtRe7itZphjf7DqbC+k4BgmwZEu0BneDxQ5ZZgzccWzrTnb5ynS1KKTdo0T2ZxwJg9ROA++03/NdoQNGxZ2Vq3ragylzcYxdjzmzuIq8bZ24ZnTJbCIDM/ts5ak+Jk3hyTZ/ivhOoI1/tax2okIw8bamzDZ6lGgjT66Hl4QULpV2y0QKUqORmDWu2eyoBTE1Y4YPh2bE1+sLiap4+D7SNIxO1UjuLL6YPSpJ/+Uvd4KqvlhA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(261026121527099003)(5023799004)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aCmPcKs26kusrQLdoDi0Fo24g33MFeBt5nE281mhxRQiTBDxdMimtnRC8O3yl+QzM/OJszmxiWyqJ+RpDjvNxcJ0YwiYshz7POrJPJf8TN0wHJODdv/4SrwchtSJxmzzYGm3mhHGc6Mq6Z4iNx08p+DTXhyakC8uCs+mE5lK2qgN4Q6W5kc3NXo3bRES88kaJyk6eFmfw33VUIqeS8UBSg3hcUxk6u7QSVa5f0rXrCpX1lgROGe0kVKJ4SaL2UnYeRjURbJat9MWJ/8T6ZzHERMp6dj/2DDATRdVlkQuFwXHO1LAD9tMcLVeoJ7V85lWIZPo6jkRw0F7MPAUwSJf7u4PgeFXpdm0KL8pQIW0uln/C+yhdMwibhQ4zopoh+0whlk9RinHsZMES1TL1XA1KR+R4n0pmh2uOOI54rkCI1YwHy9IG+1Qb7I3IJ7wD8pp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 07:51:13.7105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c16e7968-d4c8-496e-71b0-08df33ff1301
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E80.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6391
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

All queue resets (KCQ, user compute queue, and gfx user queue) are
coordinated in amdgpu_reset_mes_compute function. The guard guarantees
only one XCC can execute hung queues detection and reset at one time, so
we don't need the number of XCCs copies of hung queue doorbell array.

Only MES pipe 0 performs the hung queue detection, so we also don't need
to allocate multiple pipe copies of hung queue doorbell array.

One hung queue doorbell array is sufficient.

Signed-off-by: Amber Lin <amber.lin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 43 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  6 ++--
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c  |  2 +-
 5 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 58766b27e150..b58a9ffef4e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -241,18 +241,16 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 	}
 
 	if (adev->mes.hung_queue_db_array_size) {
-		for (i = 0; i < AMDGPU_MAX_MES_PIPES * num_xcc; i++) {
-			r = amdgpu_bo_create_kernel(adev,
-						    adev->mes.hung_queue_db_array_size * sizeof(u32),
-						    PAGE_SIZE,
-						    AMDGPU_GEM_DOMAIN_GTT,
-						    &adev->mes.hung_queue_db_array_gpu_obj[i],
-						    &adev->mes.hung_queue_db_array_gpu_addr[i],
-						    &adev->mes.hung_queue_db_array_cpu_addr[i]);
-			if (r) {
-				dev_warn(adev->dev, "failed to create MES hung db array buffer (%d)", r);
-				goto error_doorbell;
-			}
+		r = amdgpu_bo_create_kernel(adev,
+					    adev->mes.hung_queue_db_array_size * sizeof(u32),
+					    PAGE_SIZE,
+					    AMDGPU_GEM_DOMAIN_GTT,
+					    &adev->mes.hung_queue_db_array_gpu_obj,
+					    &adev->mes.hung_queue_db_array_gpu_addr,
+					    &adev->mes.hung_queue_db_array_cpu_addr);
+		if (r) {
+			dev_warn(adev->dev, "failed to create MES hung db array buffer (%d)", r);
+			goto error_doorbell;
 		}
 
 		adev->gfx.mec.mes_hung_db_array =
@@ -276,11 +274,11 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 		if (adev->mes.query_status_fence_ptr[i])
 			amdgpu_wb_free(adev,
 				      adev->mes.query_status_fence_offs[i]);
-		if (adev->mes.hung_queue_db_array_gpu_obj[i])
-			amdgpu_bo_free_kernel(&adev->mes.hung_queue_db_array_gpu_obj[i],
-					      &adev->mes.hung_queue_db_array_gpu_addr[i],
-					      &adev->mes.hung_queue_db_array_cpu_addr[i]);
 	}
+	if (adev->mes.hung_queue_db_array_gpu_obj)
+		amdgpu_bo_free_kernel(&adev->mes.hung_queue_db_array_gpu_obj,
+				      &adev->mes.hung_queue_db_array_gpu_addr,
+				      &adev->mes.hung_queue_db_array_cpu_addr);
 
 	ida_destroy(&adev->mes.doorbell_ida);
 	mutex_destroy(&adev->mes.mutex_hidden);
@@ -300,11 +298,12 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
 			      &adev->mes.event_log_gpu_addr,
 			      &adev->mes.event_log_cpu_addr);
 
+	if (adev->mes.hung_queue_db_array_gpu_obj)
+		amdgpu_bo_free_kernel(&adev->mes.hung_queue_db_array_gpu_obj,
+				      &adev->mes.hung_queue_db_array_gpu_addr,
+				      &adev->mes.hung_queue_db_array_cpu_addr);
+
 	for (i = 0; i < AMDGPU_MAX_MES_PIPES * num_xcc; i++) {
-		if (adev->mes.hung_queue_db_array_gpu_obj[i])
-			 amdgpu_bo_free_kernel(&adev->mes.hung_queue_db_array_gpu_obj[i],
-					 &adev->mes.hung_queue_db_array_gpu_addr[i],
-					 &adev->mes.hung_queue_db_array_cpu_addr[i]);
 		if (adev->mes.sch_ctx_ptr[i])
 			amdgpu_wb_free(adev, adev->mes.sch_ctx_offs[i]);
 		if (adev->mes.query_status_fence_ptr[i])
@@ -526,7 +525,7 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
 					    uint32_t xcc_id)
 {
 	struct mes_detect_and_reset_queue_input input;
-	u32 *db_array = adev->mes.hung_queue_db_array_cpu_addr[xcc_id];
+	u32 *db_array = adev->mes.hung_queue_db_array_cpu_addr;
 	int hqd_info_offset = adev->mes.hung_queue_hqd_info_offset, r, i;
 
 	if (!hung_db_num || !hung_db_array)
@@ -538,7 +537,7 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
 		return -EINVAL;
 
 	/* Clear the doorbell array before detection */
-	memset(adev->mes.hung_queue_db_array_cpu_addr[xcc_id], AMDGPU_MES_INVALID_DB_OFFSET,
+	memset(adev->mes.hung_queue_db_array_cpu_addr, AMDGPU_MES_INVALID_DB_OFFSET,
 		adev->mes.hung_queue_db_array_size * sizeof(u32));
 	input.queue_type = queue_type;
 	input.detect_only = detect_only;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 0f368fbd2c80..2baada2276a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -190,9 +190,9 @@ struct amdgpu_mes {
 
 	int				hung_queue_db_array_size;
 	int				hung_queue_hqd_info_offset;
-	struct amdgpu_bo		*hung_queue_db_array_gpu_obj[AMDGPU_MAX_MES_INST_PIPES];
-	uint64_t			hung_queue_db_array_gpu_addr[AMDGPU_MAX_MES_INST_PIPES];
-	void				*hung_queue_db_array_cpu_addr[AMDGPU_MAX_MES_INST_PIPES];
+	struct amdgpu_bo		*hung_queue_db_array_gpu_obj;
+	uint64_t			hung_queue_db_array_gpu_addr;
+	void				*hung_queue_db_array_cpu_addr;
 
 	/* cooperative dispatch */
 	bool                enable_coop_mode;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index fa5810209f37..b72cfc9a8104 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1235,7 +1235,7 @@ static int mes_v11_0_detect_and_reset_hung_queues(struct amdgpu_mes *mes,
 	mes_reset_queue_pkt.queue_type =
 		convert_to_mes_queue_type(input->queue_type);
 	mes_reset_queue_pkt.doorbell_offset_addr =
-		mes->hung_queue_db_array_gpu_addr[0];
+		mes->hung_queue_db_array_gpu_addr;
 
 	if (input->detect_only)
 		mes_reset_queue_pkt.hang_detect_only = 1;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 496ac632c3e5..b930a6b46b85 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -1260,7 +1260,7 @@ static int mes_v12_0_detect_and_reset_hung_queues(struct amdgpu_mes *mes,
 	mes_reset_queue_pkt.queue_type =
 		convert_to_mes_queue_type(input->queue_type);
 	mes_reset_queue_pkt.doorbell_offset_addr =
-		mes->hung_queue_db_array_gpu_addr[0];
+		mes->hung_queue_db_array_gpu_addr;
 
 	if (input->detect_only)
 		mes_reset_queue_pkt.hang_detect_only = 1;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index 5573fe981a22..d9e6a2407d2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -901,7 +901,7 @@ static int mes_v12_1_detect_and_reset_hung_queues(struct amdgpu_mes *mes,
 	mes_reset_queue_pkt.queue_type =
 		convert_to_mes_queue_type(input->queue_type);
 	mes_reset_queue_pkt.doorbell_offset_addr =
-		mes->hung_queue_db_array_gpu_addr[0];
+		mes->hung_queue_db_array_gpu_addr;
 
 	if (input->detect_only)
 		mes_reset_queue_pkt.hang_detect_only = 1;
-- 
2.43.0

