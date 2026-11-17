Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0C4606A32A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 19:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5ju1fg5i
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 290B710F8C5;
	Tue, 17 Nov 2026 19:24:42 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013066.outbound.protection.outlook.com
 [40.93.201.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66F5E10E45C
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 19:24:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7wWTTATIjGq7P6xnf6nLkjsSLXMKm0GIUGUr8T9IruEOI/P+cEfjUL48QqrLvHnmmYgX6CSR5FxIfdizSlvhmUu0945rIkPxtVMCKaYsNCOc6UGVWZZk/69eu9UyRbAwu9e/QqCbl102ue3kRZDUdKR/PV9W9IdZ30J4nUF3lu/9B4UT6dExPFlaoClDf0eBGd2JPX+44i9I25Zy90sXHzn+nAtxkQU01JKUmqkzOFIYVgNuCLIKCMcWxmME2xuJskjbJmHj1gKf2/V/6tdAyc3MUtCjgGzYgz0mBmczmYMJBbwZ/l/W9Soc2B/hOl1xkA4frQixop4vvcD7MDG2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEcKh/WV2UEW9FS7yrWWOhLVK8K0cIn7YE3N++8vj/w=;
 b=YYm40N5msE5g/Yq7iNd8iyzMf9nDhIAHnD1B9Py8xeo5bcnNNLWbABYbjIfqo91QH0R/JYmQFUGxq8oL8j0AXgHaoYyZNBAvqD5xL35F9mG1ru/saCGx4pCqEFb16noOR2wHKOemgNUeWwQZ+wPnhZSqqbZONqX9+7V2rWJTa4pZYBoBEs778qeVaXyH2HSC9bI/4ag+PpcMWTUtiXg3FffgJY8or+DJnG07UZ1Sye5Cad3MyQSIQxAIHpjD6CscB8HseP/1g3gy2+4yLyo60RHq/3FnAOhkHSiuQRdh9YwyGldt0ZCLFcbWB3yRr6zvOtj/EVJSFvl3koqjFf+ckA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEcKh/WV2UEW9FS7yrWWOhLVK8K0cIn7YE3N++8vj/w=;
 b=5ju1fg5iB0ilNzqmPCagYfIdclugQTACRSeo7wn6suuzKF9Lsdgha2vGotYATCe9JAiyrjjMtMnzq67cYHPUlHO307ZQaD89kpsoMFcYRznh1iviMjGh5MzrRl+fmSHK6uJmSWZlAo/kewloRaUtDn1B3fK5rlOnvdXIj6TR2PM=
Received: from MW4PR04CA0052.namprd04.prod.outlook.com (2603:10b6:303:6a::27)
 by SJ2PR12MB8034.namprd12.prod.outlook.com (2603:10b6:a03:4cb::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 19:24:30 +0000
Received: from CO1PEPF00012E61.namprd05.prod.outlook.com
 (2603:10b6:303:6a:cafe::5c) by MW4PR04CA0052.outlook.office365.com
 (2603:10b6:303:6a::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 19:24:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E61.mail.protection.outlook.com (10.167.249.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 19:24:30 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 13:24:29 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 13:24:29 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 17 Nov 2026 13:24:29 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Yogesh Mohan Marimuthu
 <yogesh.mohanmarimuthu@amd.com>
Subject: [PATCH 6/9] drm/amdgpu/userq/mes: implement set gang submit
Date: Tue, 17 Nov 2026 14:24:12 -0500
Message-ID: <20261117192415.810117-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117192415.810117-1-alexander.deucher@amd.com>
References: <20261117192415.810117-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E61:EE_|SJ2PR12MB8034:EE_
X-MS-Office365-Filtering-Correlation-Id: d031b9f8-df70-42fa-74bf-08df44e06723
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|22082099003|18002099003|261009223027099003|11063799006|56012099006|261102123227099003|261026140227099003|10067099003|261021121427099003|261022105027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: hGNvOTyVGR+iYvuvjxAHKJY19JrOKFPF+mTiizRzRbaduIDyxeKRhdb/lXIGHMG/t7h437deIdlVZfLGAjIZYhGX6dXaxVBbM+Gbkgk68VVB4c0jUU8yWZmaJEW48sZBvly2viAcOuqob9IWiJhQy2f5tEKEBxU1bkYCeLuU5oQQS38I6quz2gSh+qXpHset62LGA2GSyo2T753ELlltfAGOgxoXYzTo/M2vhbANfN+r0HiFa9w/VQ5QY5muX1FPCRCsv2RSyAFOLQcwffNN0Fp6XrAEO2Spz4ZnkwNv8p2hwyAgEi0ERk4YR2BZMwm9Ub0Ko97mx0aCymc2qk43g+VtIAxH/oepodpGToxnNUxGFvUDYDP3Qf48DaVjZGXMu6usH6TKg2IVZgTtPoRUmXWugvlOnLylwROeT8mTEoC2gJfH3+v9il8q7WFFDecdR+OuCeWEyGABI2vvEE8X2tmkutNk1TbrPNc1Ovv6YQSkvLOVzoMujKXhIV3NxyOezQFHbejSJJiXunu+ry0PjkW2pDjrUxzrkDS2+wP+QUq3FxLsjEZEHNTfVqUM3THvv1DJx0Y87921/4E7itRC/JtZ5TqzRyxDptutSfx1g8Dbz2AElTf7KFJ5+SwnBr8gamOSrilFVo5L4oQ6DH6KmUtdE+iWHTUH6zab/Sw27mhcEexPL+Anp2iO0d30fC6fabLGuiHei6mrHrsulVr5+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(22082099003)(18002099003)(261009223027099003)(11063799006)(56012099006)(261102123227099003)(261026140227099003)(10067099003)(261021121427099003)(261022105027099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 05Gf8N18m27AdRdfC+TwOl/DLJo5Pv31SVnJV1Oa7b0eNbKRVNrRb/NAPLFkxfrjBBO8z8/vZRlJl1dVVLZpUcXGgNx88yWuz1gJH8aHthQj2PmO2QaujYm6C1uFNuDjPChz3doDm4qVA7SBr68COpjJKNrpIcIPY/DrNlV3khNsCPcpMkhf7MzKj6Jpc2ufqvul7XmPPGA0+UMvuDWCbH1BcC2zS4121zcwYmN2lhXYS8yQvMyJJy8INJgGLmOc7o13wBNvbLo5mNc38i1/nWWtZoJjfxMWUIKzcS0de6lzOzvYyFkxNZUY2p8GLMYK17enG26JTp8bO/dpwuyQnWYdb2duiaNABLYukyvtyUe+UtvrbcRjXzDOLK+9XVDHYAVBdujJ6X2x5ugZ5FNfDxiVB540B0AswylsLuD1MO0aA4JLYDVQ5wW2O0qlhgel
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 19:24:30.2319 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d031b9f8-df70-42fa-74bf-08df44e06723
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E61.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8034
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable the userq callback for setting up gang submission.

Cc: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 7abb9d95ef59a..e186ebd08b8d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -649,6 +649,31 @@ static int mes_userq_restore(struct amdgpu_usermode_queue *queue)
 	return r;
 }
 
+static int mes_set_gang(struct amdgpu_usermode_queue *primary_queue,
+			struct amdgpu_usermode_queue *secondary_queue)
+{
+	struct amdgpu_userq_obj *primary_ctx = &primary_queue->fw_obj;
+	struct amdgpu_userq_obj *secondary_ctx = &secondary_queue->fw_obj;
+	struct amdgpu_userq_mgr *uq_mgr = primary_queue->userq_mgr;
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct mes_set_gang_submit_input input;
+	int r;
+
+	memset(&input, 0x0, sizeof(struct mes_set_gang_submit_input));
+
+	input.primary_gang_context_addr =
+		primary_ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
+	input.secondary_gang_context_addr =
+		secondary_ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
+
+	amdgpu_mes_lock(&adev->mes);
+	r = adev->mes.funcs->set_gang_submit(&adev->mes, &input);
+	amdgpu_mes_unlock(&adev->mes);
+	if (r)
+		dev_err(adev->dev, "Failed to set gang submit, err (%d)\n", r);
+	return r;
+}
+
 const struct amdgpu_userq_funcs userq_mes_funcs = {
 	.mqd_create = mes_userq_mqd_create,
 	.mqd_destroy = mes_userq_mqd_destroy,
@@ -657,4 +682,5 @@ const struct amdgpu_userq_funcs userq_mes_funcs = {
 	.preempt = mes_userq_preempt,
 	.restore = mes_userq_restore,
 	.reset = mes_userq_reset,
+	.set_gang = mes_set_gang,
 };
-- 
2.56.1

