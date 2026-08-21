Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E39C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 09:54:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D686510F2CC;
	Fri, 21 Aug 2026 09:54:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v+Y5Vx+V";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010061.outbound.protection.outlook.com
 [52.101.193.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CDD810F2C8
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 09:54:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QAp5HYmtevktg4kN0p3gw0kzvzi72H4oGlzBPRaU/y/2ctcPxZSduTDpM0oWVuHXuHFdHjCQdqCpyF63jCV+HJPML3VzeIYUGZAKaAVs1bNApHXKWm30AqtGCk1iTaPIxVAl5s6n5YE8XVQkZ6JfU2Nl2xpUZw+Tgd8AJ5E8wCGR0z1RK0hoB24iXt7XOfH6fUMCQH92wi6CbPVzkZvY88QGHTh6sFD+ShA8jSnjJ4QThGi3a7H6zApUg0pqsRN3n/XP7LKsHSyDT08ugjhEk5BXG3kMYHCH7tyEnIvjXDRPnJB/lBdUW1MQDMlXleHXcgPkv0pOGXLYfSLBpCPlng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nxFLaAX1n8hAxqJT4t1opZR5X0O8BIg3l+UVy49kJM=;
 b=fGn8PIdNEu2s9CoxUSlAmFG/4mERWeLwFhJInuR186HpPa8yL6l0aweI2Ezdc2KtpQLQO9VDlu6hnxqmm+XvtSf8xTx794c8v0pChuuLYWTL84AR1WwL/Jnx+ZTLOMUWaDkKzssYiZwWBQ0/x8DKra2aaj1yyCNI7khdDBh2BgI4P97A+YKKd39wj/jhKZNTVBien4bVgHCTz+1tK1s3w3mtI6sIPuudpEDmbSseTNRTYCpXSu3bkvErBtQ/GBy5o1D8OppTPTS7XMs5v3xU6wA4A3MK/66SG9N8X3+COL316dc/dgSsrMx0VThnKwyoLH5vLhxXF9yotlCmMvJesw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nxFLaAX1n8hAxqJT4t1opZR5X0O8BIg3l+UVy49kJM=;
 b=v+Y5Vx+VhREW4XU3gByXsixUaOnASRe4BnwohZFZOHeeC8Czvn46wc7tTmi6FK/DcOKzdbXTm5HTQaFuMtrYXeaPeEhHTu1ots+4biOM5IWcA758FMIPstbJCaPG1rAxJfv3dpZl3JAs1H54VJ1cTs3zmTl8QsLLqohoatuCx0c=
Received: from SJ0PR13CA0220.namprd13.prod.outlook.com (2603:10b6:a03:2c1::15)
 by DS0PR12MB9323.namprd12.prod.outlook.com (2603:10b6:8:1b3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 09:54:41 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::64) by SJ0PR13CA0220.outlook.office365.com
 (2603:10b6:a03:2c1::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.4 via Frontend Transport; Fri, 21
 Aug 2026 09:54:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 09:54:41 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 04:54:40 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 04:54:40 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 04:54:38 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 08/10] drm/amdgpu/mes_userqueue: route compute MODIFY through
 update_mqd
Date: Fri, 21 Aug 2026 17:52:17 +0800
Message-ID: <20260821095427.2361126-8-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260821095427.2361126-1-Jesse.Zhang@amd.com>
References: <20260821095427.2361126-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|DS0PR12MB9323:EE_
X-MS-Office365-Filtering-Correlation-Id: e56b4e5e-1f2d-493e-68a2-08deff6a3872
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: cpER7+s0EZbjPRDgir+HIJZ5V02qoFOOa7EWHSDpUvuvIGT5spcXKOVlCBj3Noav5/1o/3DMc9/62x65ng0JVoaJvx6Ztkz1CK8qOkX8WEnrtMeHGqhucQohyuuZAyliP1B+Cr+AXqvF8SEUo/fWFUo8Fna642v9JXT4zj5YzeJ7+COmlxag/QLgCVgVHlhCDW2PB2fgOhZWiFDz4UOLgNs8qh9k235cH5txc4y2pbQ0ida4HyXISIwI/NfyeOZN2s/RGyFcskiCDiLKIBwrwAq4iEhKmx+9hsvIoglgVn2jiCwiukUgoxAJogq7SRY5xo0lPWivJowTvoSIpVnA3EZ+xgNa1eqVCdsIZGNzcwNfLpzBBvbpi9UNOLyc8ZilqNO00b3Dita+HOlQIC3GDSDDMFoPecW2dkbTsApVEuNe2ZmU4Nngt9CVDN7IIJTPB+uTmG3NDFLAUcSAGwlzSJoInIYPbj2155igr4FepiYsLUSS0sPnG5v1E0QfAcJy+hb3P9vY/52WpjJOFdeBAM6Vl+GDf61Ys6vELR5fXnrIpbgZhkKsdAQrUQ2vFNsXG3QcwnxX8uiFj7geIgIIMQMW7miq3KbNJWyAMCDSNpD/7OE4XUVZQL96/rgp1NIJAWMcYvofj5LV/68tnACwP0hhVxTcV5Y8LQHrViDIDiGGlnFJYotUI5/M9m3sTs4uxyLp6AEaZLQ8gMzVtjL1sw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sJoG4W75ef0PHssytDkN96Qit9bYui/chM1G23YMZGTQncW/8o3ZHmK5Vt82sIPX1GzRdQDj8hJRC1YD9DoCS/NhFtOcmt0uiA1RbF0P/q0O+xevYigdP0yRIAs+563rbo8Ex+H6qZUK6seHBuaXXjnKrnyneGM5ozfVBf4RRIvbKA43BMyI5RslUFB2/AY2qnqj5+MM46nKIE0vEI1//nK78tbXqEvMopxyY/jMrwAfBNzs1+uGgaC2G/OJylzf5bGjFkLtBF6wg8QQSjSkOU7TR+/Wts05l1aM+XmeQql9ycG7meD7kVmty17ewGe6myaV4xiP2YmWc81gAdL6WIHl09qqZxQ4cG1yTZpf3nqur+a6VR+lfqPU7Mh0Raz0n3nIqxoMQ9DEJLtuIS7nSDOQh82voRowZKL65w2q5R1iszcTaSEx0pst8Z4lu1ZY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 09:54:41.0552 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e56b4e5e-1f2d-493e-68a2-08deff6a3872
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9323
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

Call the per-IP update_mqd callback instead of init_mqd for a compute
MODIFY, so a queue re-enabled after a queue_percentage == 0 disable keeps
its ring position instead of wedging into a GPU reset (see the update_mqd
callback commit for why). Add mes_userq_read_user_wptr() to read the
current user wptr and forward it to the callback.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 28 +++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 82bb4369451e..f2742fa28dc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -681,6 +681,25 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 	return r;
 }
 
+/*
+ * Read the queue's current user wptr from its wptr poll BO. Packets queued
+ * while the queue was disabled advanced this value but not the MQD; the per-IP
+ * update_mqd callback forwards it back into the MQD so a re-enabled queue picks
+ * the work up. Returns 0 if the BO is not mapped.
+ */
+static u64 mes_userq_read_user_wptr(struct amdgpu_usermode_queue *queue)
+{
+	u64 user_wptr = 0;
+	void *wc = NULL;
+
+	if (queue->wptr_obj.obj &&
+	    !amdgpu_bo_kmap(queue->wptr_obj.obj, &wc) && wc) {
+		user_wptr = *(volatile u64 *)wc;
+		amdgpu_bo_kunmap(queue->wptr_obj.obj);
+	}
+	return user_wptr;
+}
+
 static int mes_userq_compute_mqd_update(struct amdgpu_usermode_queue *queue,
 					struct drm_amdgpu_userq_in *args_in)
 {
@@ -695,6 +714,11 @@ static int mes_userq_compute_mqd_update(struct amdgpu_usermode_queue *queue,
 		return -EINVAL;
 	}
 
+	if (!mqd_hw_default->update_mqd) {
+		DRM_ERROR("Compute MQD update not supported on this IP\n");
+		return -EOPNOTSUPP;
+	}
+
 	compute_mqd_v11 = memdup_user(u64_to_user_ptr(args_in->mqd), args_in->mqd_size);
 	if (IS_ERR(compute_mqd_v11)) {
 		DRM_ERROR("Failed to read user MQD\n");
@@ -708,7 +732,9 @@ static int mes_userq_compute_mqd_update(struct amdgpu_usermode_queue *queue,
 	userq_props->queue_size = args_in->queue_size;
 	userq_props->hqd_base_gpu_addr = args_in->queue_va;
 
-	retval = mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr, userq_props);
+	retval = mqd_hw_default->update_mqd(adev, (void *)queue->mqd.cpu_ptr,
+					    userq_props,
+					    mes_userq_read_user_wptr(queue));
 
 free:
 	kfree(compute_mqd_v11);
-- 
2.49.0

