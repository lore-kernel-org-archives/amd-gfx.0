Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13F060A5BE9
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 22:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fCsnVr6H
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 387C11120AA;
	Wed, 18 Nov 2026 22:37:51 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011006.outbound.protection.outlook.com [52.101.57.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03F521120A0
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 22:37:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kp3AwMToXuEe6GbACMB4Gawm0DzOgC9SGuqbqbxDelVjv1+bRqajqJ4zLGb3y8kcctVCuWGtGoqnRI1jgpklps9jMtl5MJ4RvOapDGGlTzdHLryNChVQEOpkE5minsV1xObLGZ5VDZxr7cCBlkjCr+YybLUlMrjCFx0Dc8Igz22lAus0ijpvaT+1BWWWzObeKrT0VxzCMboyDt7xm8YbiD9rjvW9IOuDP/PelJmhebq6mlifP7I25lNqp6xkFW+TVl2h7tvyXDyygFK7W0BQCI5r4Lu4YjFQCVkLJURF5mkoImlARhfDE8N1VN2oyXuPYReWCLNede6/CkKBU6tnfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1VhL1P6zBQVeyuzZ9pcnX6GlcD3zZKsFb94YKx3lT8=;
 b=VIo56E17OpQflLCOsilkql6jJKu+1w/39kZpH+tbV++Jf0u3Zhx4HkNkZ0enu72P0qHAmf1jWjd8ngEfeqnVQyClRYzBolUg0hVv0H9I7XxyDys/wExebm1f/7IddcJvXDGnrKR3aCL/d6Mdzhd7/x/WOOxyqaHHxHg7NPO3ysRe/THy4pLPk7xltDLR/UJ97dSxyOjJdWhtygu6qwn1raAm5wnESlRlwN+S/zq4cYvYXfuoY2wJu/tJOv+1YfwFji6ggnjUoMATAL5VQJTQHP7lpJM/XnJUFZAnYfupr6NMaFrFEZRuhQfK/VKF6srfoNAxbPrMFLOUTsAXDNbccQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1VhL1P6zBQVeyuzZ9pcnX6GlcD3zZKsFb94YKx3lT8=;
 b=fCsnVr6H/z2TXUeIqU7YuINxDjaNMCItm0C2ol2q7JphEabVFj55u5Q6vaB9sTrQYr6dIn284hrOWjjGv2sOyNaOwOOc/n1qVbyq2XOWoLe+jwz0MR2PH1o7D3ZUlTSBpDS+v5B2y0s/Le/dwLCUr5YeGgoOr+DeguFsXWpkrsg=
Received: from BY5PR03CA0014.namprd03.prod.outlook.com (2603:10b6:a03:1e0::24)
 by IA0PR12MB8693.namprd12.prod.outlook.com (2603:10b6:208:48e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 18 Nov
 2026 22:37:30 +0000
Received: from EA8PEPF00000006.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::7b) by BY5PR03CA0014.outlook.office365.com
 (2603:10b6:a03:1e0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Wed,
 18 Nov 2026 22:37:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 EA8PEPF00000006.mail.protection.outlook.com (10.167.249.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 22:37:29 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 16:37:27 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 18 Nov 2026 16:37:27 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Yogesh Mohan Marimuthu
 <yogesh.mohanmarimuthu@amd.com>
Subject: [PATCH 07/11] drm/amdgpu/userq/mes: implement set gang submit
Date: Wed, 18 Nov 2026 17:37:08 -0500
Message-ID: <20261118223712.2518580-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118223712.2518580-1-alexander.deucher@amd.com>
References: <20261118223712.2518580-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF00000006:EE_|IA0PR12MB8693:EE_
X-MS-Office365-Filtering-Correlation-Id: b3ce09d1-e05c-4e43-6e10-08df45c48757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|22082099003|18002099003|10067099003|261021121427099003|56012099006|261022105027099003|11063799006|261026140227099003|261102123227099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: wt31c9QFh1nEDXRyvf49ZxrTJ1ppy8YxzjEncqQMKUCFZ6tYlPl+7Dp4qe9A/UpELadH/npCm/BBM31zs1+cS+VN94s+BnTNS0Wqk9X68p3uPyuZOXjGcuaGC1yhqxybGxL9MFSZ4L1WlDokuiOXkNrWZEYcjsShboQEPAZ48g65Zn7sUDczxzc8xWRHvQN9+2uax8J8WP+tS9lXkQuE/fBVmrLevD3sqSSjtJSbQmZj16n3oplLLJJiBAtmR5YVScB+Hn7H35LyCKQtcqjBQxsTXNLFCMu11Ts9D4oMCjXejVIpX2DobG4yq3EID5mtcv/HmbHQHny0NEt3HPiibA3/IbSnLoAGO1bcuRGBk+cVtK1q3siFSn4CIqF6iOa6SpxVvoEbaiKk/0DuKYOk1nhjDs+iqHQ66qClmt3IpI2RmvzjKtz2oTe3egc5G/BATrpTxReZSl6S49uJ5Y/N15fO+7N6OqhOPTr5oXUaUwZtqNQOAAw6xUaTx9sPAcP2DGfDg6In8XFTyKPJNrTTNN3JEA1Lfe/dQFSG+QRMW1uBn9W6X/szL/14yplym3nZM2q6Kuj31LUcWFqmssvSzglxmks96KI4euKEJrZ4Dma1Jm2E9zCqWeaCm8rR3YUI8HhyZoCoT4n8dQtZyks0SkUsCVX8Vxu9GMRu8N7hO9qqtkrroy3HGfMGFSXoVB4oDyD3NPBg1p6t15MWqoauuQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(10067099003)(261021121427099003)(56012099006)(261022105027099003)(11063799006)(261026140227099003)(261102123227099003)(261009223027099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3Q9SS3bpCMOAupT4AqatDv+OhnNl+eV8TBx6lQ9p1+z2DKtO7vyJi52Mhb/QgSjAv13snwM9FAPXrTNDeYwpEx6WXUsapv5TjQ3gFwbkUNrp3kdWPTrHHn4bgp/pr+/Bje01BrLeN8fGP5NC4jns5cD1Byi3PkJ7b5juvvE8cKdx7ZoEx4W4ZLMX4UfyYi1NecUgVaLPXfZOM952p7EAMXG0fyuG7/wCiHjyy6vaKN7yPqCW/Xmb8RNLC3WmXwtspZebEn1xqG2I7o0kumyeEuKjUpf2HJAelBR0BKxDVG83PAfYpqHqZV932JthM3OUFHB7ljZtiAVjnsXXMPLBqnP0K3+xfmorEFWFwmYq2aI9SWw7VKuZEHL2LTI3OwExDYV7ajgZDQKc4vcdgSE94xSOM9FNUXbfLGfE1c2I0sYhD7QW3UoZR1sR3dHiuITg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 22:37:29.5119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ce09d1-e05c-4e43-6e10-08df45c48757
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: EA8PEPF00000006.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8693
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

v2: fix context addr after rebase, array indices

Cc: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 7abb9d95ef59a..68c10a8adcd20 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -649,6 +649,36 @@ static int mes_userq_restore(struct amdgpu_usermode_queue *queue)
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
+	struct amdgpu_mes *mes = &adev->mes;
+	int r;
+
+	memset(&input, 0x0, sizeof(struct mes_set_gang_submit_input));
+
+	input.primary_gang_context_addr = primary_ctx->gpu_addr;
+	input.secondary_gang_context_addr = secondary_ctx->gpu_addr;
+	if (mes->use_rs64mem) {
+		input.primary_gang_context_array_idx =
+			primary_queue->gang_ctx_array_index;
+		input.secondary_gang_context_array_idx =
+			secondary_queue->gang_ctx_array_index;
+	}
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
@@ -657,4 +687,5 @@ const struct amdgpu_userq_funcs userq_mes_funcs = {
 	.preempt = mes_userq_preempt,
 	.restore = mes_userq_restore,
 	.reset = mes_userq_reset,
+	.set_gang = mes_set_gang,
 };
-- 
2.56.1

