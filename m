Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 810D4107639C
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2026 19:15:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10B9510ECF4;
	Wed,  1 Apr 2026 19:15:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Lj8QXGXR";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011017.outbound.protection.outlook.com
 [40.93.194.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60CD010EB1D
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2026 19:15:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FthDMDKjqSQmrOMlxRf8Qu4voTasXW9jqWqJLwuwBFVktYLOnQcPsPFewP1iFk70XEuXTY5XhPyOsQKFFqEg8TT2p32f/EVd7THMtmkk2eeQ7yeAu6BkTI3x5MySZJVe4gkMnZbFTbKyutLMhNzavmUeiSZ5D6Ro9Zt0uMoNnbjZGvkx7KfGjTKr8V8w+ebMGXnjnSagsk5KQcw5jrCB4KK2VmGs8bko1cG8ssE7aFxGWqOy57L0x9enWDuwbvr0T6pvhBsY5iWS66BOIG7lErpRX9NSoYufb9BljEqLsbyud/ck0ri/8UPgG91a+M0zHVxzDphtVL7yJdGlLNpccg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDXg+VvOdooZ1mPQtw6CSaVxBMqThg5qjRN/Qgbhrsk=;
 b=QotRqnuxUUQZwFabrq3sXH0SNOghjxLTXzBlPGIINVO1ODaQCn++w4Z++DJaKhzv5Bzco0woyQJV1F0yIrrZcBGPO1nTehZTRtuDB/NjWxQ5lth3DUI1oluvE7iE3Nnue4b7ae90JZFbOQjo/zxFcJIiV0dNdD++/2o5M+Eno9yP7A0+leYvHyzqvnv7iFw7yIjl7dckP16ajtm97iBYSu2/wBQ+279Bho/WmiUfi11D+pBjmpX8csfjxVW5TIOQUVnRv1ekTAaYi5gnYcMlMvCk8qb1qqoZI2RYS4dq4KZrRqC3eMZU6YIxdZXp5mRXSeGjAVXUJ14d2iqOPALwjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDXg+VvOdooZ1mPQtw6CSaVxBMqThg5qjRN/Qgbhrsk=;
 b=Lj8QXGXRHs1QDcYTi68WMg/ySiNfkKw4Uom80kgPZnH4sdAdaadgrxNHTZcRGlzSq5jaxmyxvMePS+wgbJSOtwzmuo3sW+kTiWto0QzMNZky5T4DGC9GSmzB5/tAUHyud6fJXu1KGZYdo1i4mpcM6iBuEb72thQfJh6xThKQSuI=
Received: from SJ0PR03CA0233.namprd03.prod.outlook.com (2603:10b6:a03:39f::28)
 by LV8PR12MB9264.namprd12.prod.outlook.com (2603:10b6:408:1e8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 19:15:50 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:a03:39f:cafe::b) by SJ0PR03CA0233.outlook.office365.com
 (2603:10b6:a03:39f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.29 via Frontend Transport; Wed,
 1 Apr 2026 19:15:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.0 via Frontend Transport; Wed, 1 Apr 2026 19:15:46 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Apr
 2026 14:15:45 -0500
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexdeucher@gmail.com>
CC: Amber Lin <Amber.Lin@amd.com>, Jonathan Kim <jonathan.kim@amd.com>
Subject: [PATCH v4 04/10] drm/amdgpu: Create hqd info structure
Date: Wed, 1 Apr 2026 15:15:09 -0400
Message-ID: <20260401191510.1685652-1-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|LV8PR12MB9264:EE_
X-MS-Office365-Filtering-Correlation-Id: c6959954-a2a0-4181-7543-08de90231417
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Uqgo8pd8dJiS+jqOYtkDKGM0kADpQ8A6V898F34kUzQB8iuxAmY8WmPnIgpuzd/vRPSef9fY9OEPS8sX/tlnxGXQhvvBZAjGvhlnGylUxOeg8hjMXn7y+u7D6M+ou61OCqec6JTId2FrAWbR5w1t+d8eosh5w9gwPX1d1uDDvkKlrswAG+9cs2K6A/EI6eXA7x9A4e3OZQPmYRhpTucMM9CPueZ63728WZi4p1sjiblZ6fyOunbsqcKngS6CKLi4a2Bb2n0mMPrHwXlZbRCM7XIUJbxAmi75A75M/xozNKYnWrsN+0kYF4FeAS4ibQZHKtDCqcYFrtRRJNJz3ErTCerosuwPFYn9gdMZgIV/YZy3iyyJChvR2GpxBM9hYkIhOq+ycwQIt4gCHBnf/D5nDy6shUD/9FYFaNBOWMEZOtuI1HcySGRDH4Hb8xRmDyrY7t2l0TxJSCCWwcXLJGD+WX+oX9fMka+kGZENLegi4nGymHX+yGHrEeR87vcD4xzbOwkzNTQqUQBkqJbzr7biHoXWJb/dK6xsFt2VtuwxIcryevYZmqe5xhL130njFVhNEMG9HK+aAbfXsvC7jgQRb9WaYL/wCoXkPCZ5BgLTW+HZhPul7lTUHJUIdBB1uK65kU+ziHnaChlhJQwI0pgqmZSz8/bUkjJ8GMdOAOltVYYoq9QuIdhJNLUzeBudh6xj/vmr3I3YN9JI3YRWxmMW8newuFx1tN+rk+eXcSNjppxzQu0ExHoqYvrLNdetk4X3T0ok2Uq1OEgM7PT1HGWP4A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vipgFRCu96anVfBKtDjryGkAhEyZp/p6todgi0FP5Xejc994JpyMlpNEubKa8phUcQlaz48cVAaoPdPjUdVNQTUiT0rx2G+7vRihdT64uu0z4mLtL0hgjVgo+uKzR6658KQo1tt/hTX7SNpZbpEsT/dtHAOwFLYOYe9uqgsALU4a1aNbh/iqSAsy/7NvhQzjPGfQzgleHbLT6ZU4cXMqchLyPPJhWWUsOPX2uL8nltLHpye9BvbAJ1XiHvgdTBlcHTIfCAvqgMXuhK/gD1iGRZouJv2l5jZwTX2J/FWx1XImNVkaeNVH9QZ3aivpi4f3WfIF2Rto3tvAn1J2TaWXug+dQaWYBwTa2Ww1t9+Dzu68hKa3UnFoGqD+EzipxRx98a5ieJ2pijVrWmN+OzHal++KiTQbywZ9pfqISvx3up+LIYzeaAx8lVuVZRrJ6U5h
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 19:15:46.7179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6959954-a2a0-4181-7543-08de90231417
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9264
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

Create hung_queue_hqd_info structure and fill in hung queses information
passed by MES, including queue type, pipe id, and queue id.

Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 20 ++++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 13 +++++++++++++
 2 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index f1f8bbfc31e0..47c989980824 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -447,7 +447,7 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
 {
 	struct mes_detect_and_reset_queue_input input;
 	u32 *db_array = adev->mes.hung_queue_db_array_cpu_addr[xcc_id];
-	int r, i;
+	int hqd_info_offset = adev->mes.hung_queue_hqd_info_offset, r, i;
 
 	if (!hung_db_num || !hung_db_array)
 		return -EINVAL;
@@ -466,8 +466,9 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
 	r = adev->mes.funcs->detect_and_reset_hung_queues(&adev->mes,
 							  &input);
 
-	if (r && detect_only) {
-		dev_err(adev->dev, "Failed to detect hung queues\n");
+	if (r) {
+		dev_warn(adev->dev, "Failed to %s hung queues\n",
+			detect_only? "detect" : "reset");
 		return r;
 	}
 
@@ -481,18 +482,13 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
 		}
 	}
 
-	if (r && !hung_db_num) {
-		dev_err(adev->dev, "Failed to detect and reset hung queues\n");
+	if (!hung_db_num) {
+		dev_warn(adev->dev, "No hung queues info from MES\n");
 		return r;
 	}
 
-	/*
-	 * TODO: return HQD info for MES scheduled user compute queue reset cases
-	 * stored in hung_db_array hqd info offset to full array size
-	 */
-
-	if (r)
-		dev_err(adev->dev, "failed to reset\n");
+	for (i = hqd_info_offset; i < hqd_info_offset + *hung_db_num; i++)
+		hung_db_array[i] = db_array[i];
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index f80e3aca9c78..2e6ae9f84db0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -170,6 +170,19 @@ struct amdgpu_mes {
 	uint64_t            shared_cmd_buf_gpu_addr[AMDGPU_MAX_MES_INST_PIPES];
 };
 
+struct amdgpu_mes_hung_queue_hqd_info {
+	union {
+		struct {
+			uint32_t queue_type: 3; // queue type
+			uint32_t pipe_index: 4; // pipe index
+			uint32_t queue_index: 8; // queue index
+			uint32_t reserved: 17;
+		};
+
+		uint32_t bit0_31;
+	};
+};
+
 struct amdgpu_mes_gang {
 	int 				gang_id;
 	int 				priority;
-- 
2.43.0

