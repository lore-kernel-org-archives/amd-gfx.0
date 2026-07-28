Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB1FC54F52
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2026 12:53:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDD2510E8FC;
	Tue, 28 Jul 2026 12:53:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lWIq4L/M";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012019.outbound.protection.outlook.com [52.101.43.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6F2910E901
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2026 12:53:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0aEiD5E7wqF65DAwh1iowS4YgOLOrcIanXqmOkA81F6uycGa3sN2G4DJA+8Kbp59Z67H75HX9Py1oK+tB0tJmbeef85beZ8fz+jTQgU3V21iVYtCZrMQJJLWYWiexWXgh5Tox2La1I+D6me5AKx9QLj+zArDRxH+D86w3mkcRS2Abd6UlDLgSO+LVjob60hPM6CiHv6avAA+rhz7xIQ8eeYC8VbLPEVtmpAVFh1UTfII1QvFickqUFlQIxwyutK3pCLwqhmnMMosZ5mR6WAJncmghmQTOPxzxmf5I00tKLjtnQEwBTm4/nySJUfkQWEmCK2fXa+OGKAnPNTm5iELg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDuUhoHmgEB8Oh0Kl9UrzIR1TVjAO7XE7b5Yp4/9Iug=;
 b=t0/6sOf7D0Yp6b4fmAXo/XVPh3Nl0XIuYUiDBUBUbpMiGGBlvAuArnmV01ogrjqUJk7zK75Zp2PolRyd28fBpyGxVAf+kRrIfTcggAI5d7ZTMpuDNjlTu7XfTw7QS4wRU2CniVax+PxrUm1aqY0HuTGYOlZb27zH7jy1aRuQr3/+xY4b2WMIaEweab8SWouchOqZclWSMEXXh8n64kqcRbtXLLU1rI5bRNgrGMz/vM/BgHa9EzyJedGCr8w88C1g8ypE1RGO8yrECZvA0xU9NEbzewXsYucWzgOTo2/I+5r7Ued8Rru2EjPFSddTOqWvwFn/5bnJTn1/LOcVC8qiwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDuUhoHmgEB8Oh0Kl9UrzIR1TVjAO7XE7b5Yp4/9Iug=;
 b=lWIq4L/M097n1qzLhi7f8sEGpQZjLBfIpBJl1hi/TAFEzh/9p0axMR2wv39semrZUsrsuLg86YiXcdfT5PPDSUexSqz1fxpG09rTK++DEGZX0cYvSZkCPDfL99E8vfHDvwETeJtmGxks3mtgfIwp6wKN/V7g900UnmcperPf2JA=
Received: from DS1P221CA0015.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:242::19) by
 MN0PR12MB6127.namprd12.prod.outlook.com (2603:10b6:208:3c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 12:53:49 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:8:242:cafe::9e) by DS1P221CA0015.outlook.office365.com
 (2603:10b6:8:242::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Tue,
 28 Jul 2026 12:53:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 12:53:48 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 28 Jul
 2026 07:53:45 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Michael.Chen@amd.com>, <Shaoyun.Liu@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/mes: refactor the
 amdgpu_mes_alloc/free_proc|gang()
Date: Tue, 28 Jul 2026 20:53:35 +0800
Message-ID: <20260728125336.213531-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|MN0PR12MB6127:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a7e0798-24a6-4152-87a9-08deeca74488
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: fHlEbSkCQxUDL4OisN+CrqLZ2kZ1pRhPp4W0zjFObOTdB2N/MsIFoizmjsG9kYvW9mINqk+ANSyoJ+V3u9ON12ys8ESyOOZBazeaQDMlbCVCmI/6CGnqwcbbp3f6Kt79pOrwPJkqKiQJ+lc/ujkodYavL1XcGBxZTBSyKkzlN7+eWrCM/TDyUNAZDQNG3RONEK3t3rwiEw/wCuoAOiK7RVf3I9MlnpMaQOcIDnaBL4hODyqikKihQja/WaJd18OB3wjB7UjydrThPFg4JVmUgJKlnhegH5WKRO9wm/3oTrkOICb9HRXnYujFO8upXt6cRdFkwg4K4QvLXIoyHUBiiCTFyKEM6lSHfxBMo0wNm5q6WdqPNnM9wQaP9Xf784EN3kLgW0XzltGP6xywfYDB8BDylYSlAJwuO1q7gHBiN75YdXmDxlEUjlqPJAdvyfW6rcKN4qD5a0m/bMhqgCda+2gmQnizYScn4lPWXA1Es585ROEBEq3ZiiPU55roJBI2jQMc43ZzfAXTV9OI06BUO0X6gW0QXdj4T6VqX1/UpqghyYIwCa/BdbcbWOl6ICgSW0xBG/lS2rQX/M9AtORrt9UabnoaY57OaX0NVwct1NTtfaBnyUxcLe9RG0nPlYI6JpDO/PmbrFS9bC+kBlUgS4HCmWOGvb6q+k9cJSyd02xFYz+UO3PVCswLc3Q6OcDVgITFwiNzC8RRoCiQg+D5QA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xOeJH31MiA9NFrEySHJp4l56vVBeKc6eu9d/ZbVIqmPAlBu3LXYCasSSba/mbp72YQyyJdQcH39wAFAyF6HPHro9GTepzKK+yP2lpKTXfkD464owHi4Pz96Z1nl30+ZqogWQlmVolq+Jdq8X505Z7nqpCrHB3gKdmRfkKij0avKk3ggo1+v34aH5pBlQZNCKyRSuImCvq6c6m/JE9dBvWm4cUD4cobn3VuDrPMbgD49Cc8iwfUtaRUKcz9hX0779ctT2lWV/BvK+PwJXwPatQS1nqpxiG1Cjuxn/wtP7sT7qneFb+f3Ke0cxJcdY0XMyAXzUnqtR21DlwEdR7FRZbmOMR7/tSl2kiDKQCOPXj0rZ/pzlVScO7hYM/HSTJTeHyLe+rLujyLB/B0Vf8/7RY4Lor1iV/p8U5XljRZClxqHq84VZRAn7rxYsarYLWl6C
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 12:53:48.6053 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a7e0798-24a6-4152-87a9-08deeca74488
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6127
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

Unify amdgpu_mes_alloc/free_proc|gang_ctx_index to provide
centralized RS64mem bitmap management for both KGD and KFD.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c    | 28 +++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h    |  8 +++----
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 12 ++++++----
 3 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 9af7c97af5be..e3862095ff99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1040,13 +1040,13 @@ int amdgpu_mes_rs64mem_setup_bitmaps(struct amdgpu_mes *mes)
  * amdgpu_mes_alloc_proc_ctx_index - allocate a process context slot
  *
  * @mes: MES instance
- * @queue: Usermode queue receiving the allocated process context index
+ * @index: the allocated process context index
  *
  * Returns 0 on success, -ENOSPC if all slots are used, or
  * -EOPNOTSUPP if RS64 local memory is unavailable.
  */
 int amdgpu_mes_alloc_proc_ctx_index(struct amdgpu_mes *mes,
-				    struct amdgpu_usermode_queue *queue)
+				    uint32_t *index)
 {
 	unsigned long bit;
 
@@ -1061,7 +1061,7 @@ int amdgpu_mes_alloc_proc_ctx_index(struct amdgpu_mes *mes,
 		return -ENOSPC;
 	}
 	set_bit(bit, mes->proc_ctx_bitmap);
-	queue->proc_ctx_array_index = (uint32_t)bit;
+	*index = (uint32_t)bit;
 	amdgpu_mes_unlock(mes);
 
 	return 0;
@@ -1071,18 +1071,18 @@ int amdgpu_mes_alloc_proc_ctx_index(struct amdgpu_mes *mes,
   * amdgpu_mes_free_proc_ctx_index - free a process context slot
   *
   * @mes: MES instance
-  * @queue: Usermode queue whose process context index is released
+  * @index: process context index is released
   */
 void amdgpu_mes_free_proc_ctx_index(struct amdgpu_mes *mes,
-				    struct amdgpu_usermode_queue *queue)
+				    uint32_t index)
 {
 	if (!mes->use_rs64mem || !mes->proc_ctx_bitmap)
 		return;
-	if (queue->proc_ctx_array_index >= mes->proc_ctx_array_size)
+	if (index >= mes->proc_ctx_array_size)
 		return;
 
 	amdgpu_mes_lock(mes);
-	clear_bit(queue->proc_ctx_array_index, mes->proc_ctx_bitmap);
+	clear_bit(index, mes->proc_ctx_bitmap);
 	amdgpu_mes_unlock(mes);
 }
 
@@ -1090,13 +1090,13 @@ void amdgpu_mes_free_proc_ctx_index(struct amdgpu_mes *mes,
   * amdgpu_mes_alloc_gang_ctx_index - allocate a gang context slot
   *
   * @mes: MES instance
-  * @queue: Usermode queue receiving the allocated gang context index
+  * @queue: the allocated gang context index
   *
   * Returns 0 on success, -ENOSPC if all slots are used, or
   * -EOPNOTSUPP if RS64 local memory is unavailable.
   */
 int amdgpu_mes_alloc_gang_ctx_index(struct amdgpu_mes *mes,
-				    struct amdgpu_usermode_queue *queue)
+				    uint32_t *index)
 {
 	unsigned long bit;
 
@@ -1111,7 +1111,7 @@ int amdgpu_mes_alloc_gang_ctx_index(struct amdgpu_mes *mes,
 		return -ENOSPC;
 	}
 	set_bit(bit, mes->gang_ctx_bitmap);
-	queue->gang_ctx_array_index = bit;
+	*index = bit;
 	amdgpu_mes_unlock(mes);
 
 	return 0;
@@ -1121,18 +1121,18 @@ int amdgpu_mes_alloc_gang_ctx_index(struct amdgpu_mes *mes,
   * amdgpu_mes_free_gang_ctx_index - free a gang context slot
   *
   * @mes: MES instance
-  * @queue: Usermode queue whose gang context index is released
+  * @queue: gang context index is released
   */
 void amdgpu_mes_free_gang_ctx_index(struct amdgpu_mes *mes,
-				    struct amdgpu_usermode_queue *queue)
+				    uint32_t index)
 {
 	if (!mes->use_rs64mem || !mes->gang_ctx_bitmap)
 		return;
-	if (queue->gang_ctx_array_index >= mes->gang_ctx_array_size)
+	if (index >= mes->gang_ctx_array_size)
 		return;
 
 	amdgpu_mes_lock(mes);
-	clear_bit(queue->gang_ctx_array_index, mes->gang_ctx_bitmap);
+	clear_bit(index, mes->gang_ctx_bitmap);
 	amdgpu_mes_unlock(mes);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index c67db2d6e122..977c057dcce8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -636,11 +636,11 @@ int amdgpu_mes_rs64mem_init(struct amdgpu_mes *mes);
 void amdgpu_mes_rs64mem_fini(struct amdgpu_mes *mes);
 int amdgpu_mes_rs64mem_setup_bitmaps(struct amdgpu_mes *mes);
 int amdgpu_mes_alloc_proc_ctx_index(struct amdgpu_mes *mes,
-				    struct amdgpu_usermode_queue *queue);
+				    uint32_t *index);
 void amdgpu_mes_free_proc_ctx_index(struct amdgpu_mes *mes,
-				    struct amdgpu_usermode_queue *queue);
+				    uint32_t index);
 int amdgpu_mes_alloc_gang_ctx_index(struct amdgpu_mes *mes,
-				    struct amdgpu_usermode_queue *queue);
+				    uint32_t *index);
 void amdgpu_mes_free_gang_ctx_index(struct amdgpu_mes *mes,
-				    struct amdgpu_usermode_queue *queue);
+				    uint32_t index);
 #endif /* __AMDGPU_MES_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index a914198a4d62..7369a8e05101 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -144,9 +144,13 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
 	queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
 	queue_input.wptr_mc_addr = queue->wptr_obj.gpu_addr;
 	if (mes->use_rs64mem) {
-		amdgpu_mes_alloc_proc_ctx_index(mes, queue);
+		uint32_t index;
+
+		amdgpu_mes_alloc_proc_ctx_index(mes, &index);
+		queue->proc_ctx_array_index = index;
 		queue_input.process_context_array_index = queue->proc_ctx_array_index;
-		amdgpu_mes_alloc_gang_ctx_index(mes, queue);
+		amdgpu_mes_alloc_gang_ctx_index(mes, &index);
+		queue->gang_ctx_array_index = index;
 		queue_input.gang_context_array_index = queue->gang_ctx_array_index;
 	}
 	amdgpu_mes_lock(&adev->mes);
@@ -180,8 +184,8 @@ static int mes_userq_unmap(struct amdgpu_usermode_queue *queue)
 	r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
 	amdgpu_mes_unlock(&adev->mes);
 	if (mes->use_rs64mem) {
-		amdgpu_mes_free_proc_ctx_index(mes, queue);
-		amdgpu_mes_free_gang_ctx_index(mes, queue);
+		amdgpu_mes_free_proc_ctx_index(mes, queue->proc_ctx_array_index);
+		amdgpu_mes_free_gang_ctx_index(mes, queue->gang_ctx_array_index);
 	}
 	if (r)
 		DRM_ERROR("Failed to unmap queue in HW, err (%d)\n", r);
-- 
2.34.1

