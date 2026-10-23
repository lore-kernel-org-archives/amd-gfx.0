Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89962606A31D
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 09:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=FlNHAuD+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20DD9112A4D;
	Fri, 23 Oct 2026 09:09:14 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012002.outbound.protection.outlook.com [40.107.209.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCB4B112A4D
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 09:09:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kyF7pB6KUEQXeOMrSvNCpjKvQlcqdW0npeTLyAN3q4ELzeOJqQ0+VujuSTR+Gl8uMjgWcVIAAwTZBg7PWcySXdi4qzMlJzzNlhpQPzXoxdWOXhr2L8tW7TAkzPDmakIIyhuUtLYrvn6XPihmQ+nzjunMvUHgLjdGCkauD9fZpQ2J5L0jHYu85RfJ/kh49DyHgrq+96e/v8T/IFBt0GhA23z8Hd+alkFwLQn0TzaMN9H9ZAd/OV5ux7HHEE0X8A4+wHXYhmj8/lPBDRlM7vnBTMr76dYsp9+76yO+JT+GNLIE9L9IXMPqV8tm24nXJyP6mul8PtvtxNLvLOTlkuA5pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtSKFcwLKv8Eh7bt1zgRA06SdMsSBFfsNWhe+UAxBjc=;
 b=KsYGYmaHNEiutXq8PXF8zc57TKfCoQzJ/C1sEsjqeq2dDnhgT6VjcIRtQPaQKAhOvN4fW6SyMfa4e6DOQZGX6PeLGLIYZnkSasC3aM9a8SDO5+95UxeAOJ7e04ny3kNs0p5kxuZVOjaIJclT7kTgTXvR62U5kQfCdcX8wtxagiG2fSERR6SL0VoYZ8m047xgFPtUCDb9ZCmlw40Xol6jgGJeAV5YFMMtkGtAr4ATYE2f24mF27VrRBzh5f6N3MnwKFj+Hhh0/0+8QgIABfG9cNwGr2xgB7efa7F4qh16M2FG9AXv+v80mXuQLfM8/9dJ2Gb6fBl+3VnM7dlXER/SOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtSKFcwLKv8Eh7bt1zgRA06SdMsSBFfsNWhe+UAxBjc=;
 b=FlNHAuD+VKxYnBxYGWDtQE8hwE0zxshMZVHpSi2vO5WD9TyU4sycneYCgzfGCyUfngbqDs5Fsv+BKwv/+m++wYxQP7GpdUAtfUIp0oSGCrg3ewFkwkd4hPTAS64HjBxYME5vi8PxydWoyRyLm9PowjOOc1aPqKY6cOyUXpjOieQ=
Received: from MN2PR07CA0022.namprd07.prod.outlook.com (2603:10b6:208:1a0::32)
 by MN0PR12MB6103.namprd12.prod.outlook.com (2603:10b6:208:3c9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Fri, 23 Oct
 2026 09:09:04 +0000
Received: from IA0PEPF00000045.namprd04.prod.outlook.com
 (2603:10b6:208:1a0:cafe::89) by MN2PR07CA0022.outlook.office365.com
 (2603:10b6:208:1a0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 23
 Oct 2026 09:09:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF00000045.mail.protection.outlook.com (10.167.249.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 23 Oct 2026 09:09:04 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 04:09:02 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>,
 <Benjamin.Welton@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH v2 13/13] drm/amdgpu: set userq perf state before publish it
Date: Fri, 23 Oct 2026 17:08:45 +0800
Message-ID: <20261023090845.670581-14-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023090845.670581-1-lingshan.zhu@amd.com>
References: <20261023090845.670581-1-lingshan.zhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000045:EE_|MN0PR12MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bbaa8c6-de9e-452c-1a87-08df30e5490c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|261022105027099003|56012099006|11063799006|261021123027099003|261009223027099003|261021121427099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: drXZfmp1JoxfHXBq8/W2WbMiraIwrgWyYI+rveImZIzSt8BjveCyr3NuNrEAQbEXY8xHtC8FE61nhPTZUZyfQCnACyToCi9x8ANxZZ2i6V5tAUSK6MIannZC4indb3MnjuRUbmfWwHQDNEuV1WPMFGYWDkPN0zT+88Gb6cuQ8DUHp11AMNmq45Y//XGEa2Q0vbPhWwm9WuOwZL8odtQHLw/s+2I8UwcSvXdhpxXxI/y08MLTQHnn3sqavo9V9VtbsM8990kDZBzsWLJxtSGv1Gi/pbdt2m5S+J40b5ppL9iC9z0//50LKb3fZhSad/i/B96Gjhcxq4hSdkyjYzCPY4tPcl2yB/BRsolee5bPTPH54nBn9iuSr1ODYks6jnET4+p+ZbIFifjnrU1qj3/AhziH5Uh/J1zw+9hHLK0+S43uyB2seW3/I11ip/gh0WyxwMTDjK8SLBQVyYnY4m4nwkPBj8V5v8LSa8SDdXSVInyFAw9/CK7Z5nAXik4EuA9iK/xJsNvawmJpAyQqN9CG2X9BVpFfIBvA2v8X/gj6zIkSFakRrF7fuQY/9lu+NA6DRrgxBR8GkZrF98MgjqPqsyNaMlnwReK9/cT0yfRy8wXVMis1rar9WdMiHyYUvy2se/NjXztoeA5tJ5W0ajKDjT7j050y7ZNcsZaDft7fQeq5JNQp1myhyI3joFB/meZ1/WcTBTTQlPPNkDTjqC6A4w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(261022105027099003)(56012099006)(11063799006)(261021123027099003)(261009223027099003)(261021121427099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zUhT7ucGm/KOpEaKsFVJnyXosh5U1j5GjcXbjHakHUHSxqwA/XwW3NrvcWHlwjlGUMTeUCPizpX/S+XlGD4YgrEnAFcqX9zh846U0o70FXRtiaq6R+umzwSbPMPPBJ/58fbLX1Y9wG2ij2THFfVveyBzoTohEN7VnTK6i00Dnk+8eDeV8nqBwFX0CdZsJ28/uEZHinRGmAx4ovmnRPaEP2THR/6N3by2gA8A/FcSZNk1M46tJnfwkOvvrZg7O57SqiNsiwCOQ9HPxIvClyA+aChlZttgbY23FzuB5rNA3Ac/JfPXyH0/RN7Dtm9crFL75ffV8Q+T7vUxY8ysa1XSH2n0V2ZCipID5OMPhfAfuF3NUAdaSahmFJY74wBR6es8J/XMps91QKlHwOhah/dNsN7kiSIPt9AHcSeWBonVKNib7sMHnhljhVi0YjpUyuDH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 09:09:04.0698 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bbaa8c6-de9e-452c-1a87-08df30e5490c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF00000045.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6103
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

This commit sets the perf state of a user queue
before publish it.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 30 +++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index b4a2164068e3..140f1bbbc39f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -686,6 +686,33 @@ static int amdgpu_userq_priority_permit(struct drm_file *filp,
 	return -EACCES;
 }
 
+static int amdgpu_userq_attach(struct amdgpu_device *adev,
+			       struct amdgpu_usermode_queue *queue,
+			       u64 index)
+{
+	struct amdgpu_mqd *mqd_funcs = &adev->mqds[queue->queue_type];
+	int r = 0;
+
+	mutex_lock(&adev->pmc_profiler.lock);
+
+	if (adev->pmc_profiler.enable &&
+	    queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
+		queue->userq_prop->perfcount_enable = true;
+		r = mqd_funcs->init_mqd(adev, queue->mqd.cpu_ptr,
+					queue->userq_prop);
+	}
+
+	if (r)
+		drm_dbg_driver(adev_to_drm(adev), "Failed to init mqd for user queue %llu\n", index);
+	else
+		r = xa_insert_irq(&adev->userq_doorbell_xa, index, queue,
+				  GFP_KERNEL);
+
+	mutex_unlock(&adev->pmc_profiler.lock);
+
+	return r;
+}
+
 static int
 amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 {
@@ -785,8 +812,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	/* Update VM owner at userq submit-time for page-fault attribution. */
 	amdgpu_vm_set_task_info(&fpriv->vm);
 
-	r = xa_insert_irq(&adev->userq_doorbell_xa, index, queue,
-			  GFP_KERNEL);
+	r = amdgpu_userq_attach(adev, queue, index);
 	if (r)
 		goto clean_mqd;
 
-- 
2.53.0

