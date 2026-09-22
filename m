Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D39C982F1
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 09:34:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABC2510EC21;
	Tue, 22 Sep 2026 09:34:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E42mv+GN";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012009.outbound.protection.outlook.com [52.101.53.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE37410EC1A
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 09:34:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kI1/3Dyg4ieCzbAyzxFLpVF5HjMdTEjNLvknNmyHnOP4tCoW5D9ZoyBQHLoDPIbTX9a6Fsl6YjEC4moaTd5zoFRo9RGhFEbERMRVkAgVSC6yu0FvpII9paV11BqUga/d9d1fvI6AU1+QtsQXZLNLRy+W1s1iUH4m7rhN5VW0JC5B9ua2I6/FvNLo0nRaaDEStJSEViYz3Ttg9yr49r7pIMDK8RvYhUuuF4hCBy8Yq+nqp06QDwUzYkpjTlBrRB1uVjeRnvDFQ5JFkebyNsqTKQoC8/CceRACXjz1x+3CF6JyHA/hyJzzEqE+5mYJDdkvRrEP5oKyEigApC1NZPIXIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fz8iu5KNG1GwICOaGFVC6DIuC7AO3e8lvYpozIPxjg=;
 b=sNvfHvitdwneYCjAqa7nU+RcKI2rFs6EDqFHm/X0k0mO50wjyhxUjECT2ywNrmFMQjsVht9kKXiWvV3gEMgasNwojLqDkmqfoK0OtjNBJI3mkDJdQzfwwhTqoRgqsS2dCagzUdZanAvZtU4F/qGd7wFMGCHjjjp5ZmxUYAsjWr/bBLY1btWfN9eaUl19bW8ISqQWODJKlRp0lZmc8cXK1xVp5EzoMqPRfna1WWpbmUMvfHXgf2lW0dG082eC5Ar86MelMFhUOqUgSYBKriB3O6ShOi9krJRAzgL0vJLIUwbP6+xuMQnTRVQ4gPHYLdstK6hkB2egP8eqjw0zAClSdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fz8iu5KNG1GwICOaGFVC6DIuC7AO3e8lvYpozIPxjg=;
 b=E42mv+GNOVI+3YmHbTt6vPt4mxGHvV67PHSxwxn0Xo1SLf/5vewu7KkQXj0D11sM6bWAtO3Wafh2BAKW2JhsFvqEoyLqixXJRPry3S5ZbgNkfxmI6TUtkac4t6qHPYLHCKLl22rvaE6f72xExKRkHp/uXYZCbEX1tbQTa6Obcw0=
Received: from BN1PR10CA0010.namprd10.prod.outlook.com (2603:10b6:408:e0::15)
 by LV9PR12MB9760.namprd12.prod.outlook.com (2603:10b6:408:2f0::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 09:34:27 +0000
Received: from BN7PEPF00000093.namprd03.prod.outlook.com
 (2603:10b6:408:e0:cafe::7a) by BN1PR10CA0010.outlook.office365.com
 (2603:10b6:408:e0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.13 via Frontend Transport; Tue,
 22 Sep 2026 09:34:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF00000093.mail.protection.outlook.com (10.167.245.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 09:34:27 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 04:34:25 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [RFC 10/10] drm/amdgpu: set userq perf state before publish it
Date: Tue, 22 Sep 2026 17:34:36 +0800
Message-ID: <20260922093436.596947-11-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922093436.596947-1-lingshan.zhu@amd.com>
References: <20260922093436.596947-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF00000093:EE_|LV9PR12MB9760:EE_
X-MS-Office365-Filtering-Correlation-Id: 89160de0-da0b-4093-6440-08df188cb236
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|22082099003|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: +ArCBWD1E9XQ2VjnyI/BW7XvxIn4xKpCdcu49E7T7Cd77SaVvG0D23MoEUNP/dHq46LcUTAFo+BrGMhxOvBdZgiPZXCvI5lV4fN9lJFNPT8XVXYjLDCVL+OXFIZVLXvfYZwkE0P49IokYS2OgnFG9o0rEmfPlzNrGuydNhdReB9tJT/WeAPqY/m9XGua+flC+zE+ampYEvBHVhAFML2xe8G2ZJeG0PROdJYoyAy2vfhs/lCcP6WWKNRzf0s5PUR0uXz9lAW0oCUeI3gulXNDbTdM9ozcJVGLXcExUHppmUGPcz19paxtoa31ErzGqZwcq+4kHwwnXgXq5PzP6eUAlymQPf/ZxBomIyliP67LN2ATWExKPYTX008mLYKdBnVGj+yXSPvFvtUhS9RBHoAwuTGEqrG56SGtQe7cOG/5ycHZqgF8NZtCmzv/DfE326kF/IP0p/5fc8OtyVDyDTvu4EHxTMJepwWdrXYYZ8T2JfSyneiTTyKu2CLVPYeTiadoDsmr321NlOvsdK8F7LKlJP7Uak+nHvjBxbB4RycH3njpIZ0bxTUR++JtC3XXpS8V/vMtPLZ+9djKu8M8y42sdiA+pcABk8pDNGIeIPxUWaA4QeL+Y1IoUs65BSXxd8UXi+jVpJFm9Jh30FZQjI875e83ctWkS4ad7GTVGRgbrsOoP23JSJ94T5EoCjfg4tEo0rDZ7RSaJoGWGCsWQKaWIQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 754je3dj3hrjB/snNEzUd0O9N6b1ixLzp2pL6QcCa+/u9GrKCj+n7iWbSrQ6XasInHXv19jSccKWrbtb8MRtzkk5F2pnEXOEC/oMJkqqBo3/MR5uxaBb7CgJfz/5QdRi+n7fSvEGxgN6gNiycvh3VjwwSttWiLd7WEsjyqfQh7UDGraUyB/gwNycEGRQMuzlbH6yxaraS3wLC9YSUlaFCtLB70PCbOJ9XnUfW6+upjG7OaDhzu++jrOrX+KAz23m6pVQlq9ud3hJ2zcm9J2t5AcMybUmgnHmJ9L0DGwuO3cCGfwmVzd0itY+tEKb4ga9M3GUoYz3n3J4zn6UCgjNybQlzYbYGY9j3nrH3NNhEF4YSA/T0WgSnfn7/7hxwYQB1wHdt2jf2s5vBgHydAdLaM1L1jEA1Fev+ft4HJRfslw/g1zQE63CqI2NuwVdlZZ1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 09:34:27.3870 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89160de0-da0b-4093-6440-08df188cb236
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF00000093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9760
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

This commit sets the perf state of a user queue
before publish it.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 27 +++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 8a1f0841e8e7..fb4d8c8c6eef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -731,6 +731,30 @@ static int amdgpu_userq_priority_permit(struct drm_file *filp,
 	return -EACCES;
 }
 
+static int amdgpu_userq_attach(struct amdgpu_device *adev,
+			       struct amdgpu_usermode_queue *queue,
+			       u64 index)
+{
+	struct amdgpu_mqd *mqd_funcs = &adev->mqds[queue->queue_type];
+	int r;
+
+	mutex_lock(&adev->pmc_profiler.lock);
+
+	/* set the queue PMC state based on the device PMC state */
+	if (mqd_funcs->set_mqd_perfcount) {
+		queue->userq_prop->perfcount_enable = adev->pmc_profiler.enable;
+		mqd_funcs->set_mqd_perfcount(queue->mqd.cpu_ptr,
+					     queue->userq_prop);
+	}
+
+	/* attach the queue to the xarray */
+	r = xa_insert_irq(&adev->userq_doorbell_xa, index, queue, GFP_KERNEL);
+
+	mutex_unlock(&adev->pmc_profiler.lock);
+
+	return r;
+}
+
 static int
 amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 {
@@ -831,8 +855,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	/* Update VM owner at userq submit-time for page-fault attribution. */
 	amdgpu_vm_set_task_info(&fpriv->vm);
 
-	r = xa_insert_irq(&adev->userq_doorbell_xa, index, queue,
-			  GFP_KERNEL);
+	r = amdgpu_userq_attach(adev, queue, index);
 	if (r)
 		goto clean_mqd;
 
-- 
2.55.0

