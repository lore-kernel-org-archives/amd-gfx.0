Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E15606A319
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 13:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=cYZGzokX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 030D110F9BE;
	Wed, 21 Oct 2026 13:16:15 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013008.outbound.protection.outlook.com
 [40.93.196.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3875210F9C8
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 13:16:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+DhBuUdJAlAt/wejH+9DmOkFGmgHis6twnvm+z2QTbCZfLpq0LL0tAPco6eWiWYEemcCEjQC7f5KVmwcf9UoumYh1necmOFHryOwe/ADxu0DZwPbwodB7NwJS7AV+7ItOTc4+5eifCh+/McbNNc+D4nGVLECDhQUqgo81i+8wVP22LkbkAzNMJlvEKV4231YUEFEExv+Bg2iSfEpE+C/GEyF2foqyvG4CqF4FbWAPI1YiHE3EOuIGct++zCmg6anI2P3szlfEjGDQ3Z9G545IT3yRRB8bo/Pkvecjf7bHc1zCFRB50z4Zje7UB42DuXTvPeI7eSswhAuE3S4gvNhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hahuey5VQ7Yu38lRntGAgFaQ4CQHfY8fgr6FP0AdC6o=;
 b=piTev0YYUIBYbcXevBnQ8cGEV2/dRmJhOSQbend0FIiy6Zs7EOpNcmk+nl00ECQF+CMB2VPGy9zGVi3nanex2/LmYxPmoL4kd0OBXJ6VKuoryLt1nYv0CGY5H+vd/LHi9tU6vbu+k3B8AKiMYoZtYWfam+ZMzNwZmqlCrfXhD6fFm0drsYxfZh7e+/rkIT/7p3vc+m0+TZ3s0bYKfOeHEo4LahTAO/fI8AGJPFWU2KFddYDh7qhe+BL+c4HvlOnI/JybLVSlfyDBmtQ3fD3KT0rT+jQ4GxouYixX9S2sggb6kyuybpAtd/86sVDZZKu0z7rIyJN+YP+zkwPHF0ta9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hahuey5VQ7Yu38lRntGAgFaQ4CQHfY8fgr6FP0AdC6o=;
 b=cYZGzokXdoeLkWheJ08M4XH89YDI6G3sc/MIaEmSwQv8WQqJxl3BPxTfJJHM3w35Jjs6KtnDCjGrHZORMdGGYpLLu+QFszXwrT4jhq8aSphTKMBNuOTqNbgCOGKOLa+cWVuPlr1Tx8QMN2q6D5+L+zTC4f0LF1yZIQxVWPTJJHo=
Received: from BY1P220CA0042.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59e::17)
 by MN2PR12MB4237.namprd12.prod.outlook.com (2603:10b6:208:1d6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 13:16:04 +0000
Received: from CO1PEPF00018869.namprd03.prod.outlook.com
 (2603:10b6:a03:59e:cafe::33) by BY1P220CA0042.outlook.office365.com
 (2603:10b6:a03:59e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Wed,
 21 Oct 2026 13:16:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00018869.mail.protection.outlook.com (10.167.249.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 13:16:04 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 08:16:00 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 08:16:00 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 08:15:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 7/8] drm/amdgpu/gfx12.1: rework kernel queue priority handling
Date: Wed, 21 Oct 2026 09:15:44 -0400
Message-ID: <20261021131545.1962601-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021131545.1962601-1-alexander.deucher@amd.com>
References: <20261021131545.1962601-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00018869:EE_|MN2PR12MB4237:EE_
X-MS-Office365-Filtering-Correlation-Id: 708c262c-72e3-4c4d-58d2-08df2f7575c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|22082099003|18002099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 7DUOEXycBJ56Nyw/1gm1Ak4INYXTuS+g8I7dQ9VBWdqcDfyXN/YV748R8XYhBVRpod7bzRDey4wRyVunpxGBF3IEx+2JwR4dsEW6Ge5iBfA9ldAGgo1iqv2k86pISuWc5xd/GTpz4MSgmsb14ypnKolBHjrlbQGVbkiB6XgEODvz5L3bWngcHIX5X8/a25sRQKXVJS/KElFFh/ii3OVO2Fy6zVFcSy6I1Jq1WUjRyYWiJKkvLmuoHpT0WWn4OBf7DBtOVYUy1UhLxBeu5q5eB6ePbpUhL09V7gsp5FKNgRzA4XNEfIzlXjNv0slkUfqyizf8hOd5lwGBjckCwjZSHI3AbfDcnMc70wzTr7SRi5H35M7hRMdVvvurOUNwHPGvbjVMI8eVj+FuA43AP54prA2eG70YXIMobvqlF13SZsKC37w2rHRHXEO0KBMXdRqWXEhLfiXpuJKvzBWhs5FHCag15x0VjvVpNAJxVXDYPEvrD3AaFW9JjHWp2cnCUb1H3AKlkw1wD6X+S0d74wQOntyO8IWi7WhsJtB7JAyJ2lykKGJaMxmHHP6yFR/nJ0SWBRH7JN1HwQmIPxzoHRhDkbIrCmpHi+0PrSNWa3PbcbrpiZ0TyrxmOlBXnKgEcLL1hg/61CGucmbE1tDtJ9RG1wHKGeH1dfXtJbZq1YVEv9qGGEQV1lW7jktI9cVCVsXx
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(22082099003)(18002099003)(10067099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YMLVKFZW0ECgy59dW2PbT8PDdudJ0q+CyveVZGPGHhSiIt7fAqVwgTq5jiprSEnoz72a3VuOXno/McmEhZXxnmQwIZusfd9qkzk9KHbE3R6kGHkpSBYQLeCZ2rk2VBubWa/DDn07fFi8cWTlmsWLffBiFw+3bM6g8IumiBlQ6jliViuyr2RDW+mtO1qhVuo6fX1kKG3sfDorM6+uHn40JqLmXKpRQ1D9d2bOqsDi7/f7HIBzWyepkecy96h3vvFC3ZGUIMHjiyKPV1/HdJm1kZOEoCiWgaBEKc3UfruLsEH8nL0GoicnpNmnG51JzSHrCNGCr/FoYnZ7+gGG/Zlc1mKvCwFxfnKo5MJmBgafmgw+kF2c6H6+rxn5lSIr5U+1captIHBekQjZTYHv7VJl93ee+qjYDP+cLpmOcHvSItg649bMni90FEqVCVOvffPA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 13:16:04.2486 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 708c262c-72e3-4c4d-58d2-08df2f7575c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00018869.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4237
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

Rather than setting a higher queue priority which could
starve a lower priority queue, enable longer quantums
for high priority kernel queues. This will avoid
starvation, but provide longer runtime for high priority
queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 1589fc6413af5..e3d3ca8e7900c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -2362,7 +2362,12 @@ static int gfx_v12_1_compute_mqd_init(struct amdgpu_device *adev, void *m,
 
 	tmp = REG_SET_FIELD(0, CP_HQD_QUANTUM, QUANTUM_EN, 1);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_SCALE, 1);
-	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 1);
+	/* increase the duration of a high priority kernel queue */
+	if (prop->kernel_queue &&
+	    (prop->hqd_pipe_priority == AMDGPU_GFX_PIPE_PRIO_HIGH))
+		tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 2);
+	else
+		tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 1);
 	mqd->cp_hqd_quantum = tmp;
 
 	mqd->cp_hqd_active = prop->hqd_active;
-- 
2.56.0

