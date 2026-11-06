Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA345606A328
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 07:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=34v9fbf/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5254310E3A7;
	Fri,  6 Nov 2026 07:48:46 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013018.outbound.protection.outlook.com
 [40.107.201.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 118B610E3A7
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 07:48:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7vehIvn7zUwa28CxlgLgsxt1N9mQ32foyKbTJln6FyK6yQ8Nes7cvbM1sOEi+CmIfeGRUEWysbc4/SHFwpM/QNzBKhUoRBrh63M9h1bWmhdAO6dudVURQ1RzDagREkvyW0hKJeq5Dz/BICrgEit3y7AsYW3vjmelYqsHXbuyERbadyiOXhaUCVE6+Y4I0RrOhDEURICbeS6XQgCRo9ENmZQHki77CU24UflEJNBd+s6BnGde9eCtOtHNNganCEA+iulol40en8ufTB4lzlqywzTUQs2W9CM5p1wE+/Z02xy1B4OApp12nEbC+NNyBn2LZpJ03KWsypd3lGf2zRtXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XB3U4i533Hq+LRA1mQiqUEj+M3sXBuTKgNRd85GNePQ=;
 b=sFP1EJOP+Ro7QCFQUfa8ChCA5Ei2kGXbw6h8es01oDM7qgiIge/v3bogmFDRhY8/HrFxZFrisWZgQOUHj373xKa9e21TcT2Xl08FF1pYCfWE/pIrZavapTiOd2Ewy+J2BF/Trbfn9aSoeiteN/VoNw1f/XpTXUXLX0AJj5lZ0cHFyxUZ3ZmKhzeYWmmIk7NlZBB5kK2njn/scpT7brxI+O34VKQ1DxAvEw7OoilR48tuEcA9bj7EtV8esmXWyt4LPYgBvZftqqPyGRIIML2lPnHJzmbxsWcPhqkqijx3g9afqdycK4w+wypyuQiDyczLFqVCf7sc5E7gZemL30ujEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XB3U4i533Hq+LRA1mQiqUEj+M3sXBuTKgNRd85GNePQ=;
 b=34v9fbf/rI3spIvCubfuUXAeX3d/C/ksmEXJZFaz04HSKF1zgBcowIE1Sq7LpuaWlQ1cCuJnhXIA7zlofjY/k2fWzhShRsLH6Asdjp+l9k5IJtaKBjWCAgy1La7jPvpCClIIe54+JPWN2j6P9WmuehOCqu/TMOzrBJQzDK2NnWA=
Received: from CH2PR15CA0008.namprd15.prod.outlook.com (2603:10b6:610:51::18)
 by SA1PR12MB6948.namprd12.prod.outlook.com (2603:10b6:806:24f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Fri, 6 Nov 2026
 07:48:35 +0000
Received: from CH01EPF000BE943.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::9b) by CH2PR15CA0008.outlook.office365.com
 (2603:10b6:610:51::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 07:48:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH01EPF000BE943.mail.protection.outlook.com (10.167.244.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 07:48:34 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 01:48:34 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 01:48:33 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 6 Nov 2026 01:48:32 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: fix memory leak open when CWSR allocation fails
Date: Fri, 6 Nov 2026 15:48:09 +0800
Message-ID: <20261106074831.1466472-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE943:EE_|SA1PR12MB6948:EE_
X-MS-Office365-Filtering-Correlation-Id: c75c19fa-1a89-4c85-ef33-08df3bda5c33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|18002099003|10067099003|11063799006|261022105027099003|261026121527099003|261102123227099003|261009223027099003|261028144727099003|56012099006|261021121427099003|261021123027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: jryA59RRHsiX2HD6XK8JRPgGSdtLhuCRlwS5S7mx8qfBKnsgtc18bRsClViQLtiFR3B/+F0/mUP5oIDw0j7LB9JyT19c9nA9ui/CXXiMwxAyV1OpN+JToJHJI/9xYeWNsrzNPUde2wgGvj56UtBLdcIc8C5Cjn79ZA75+AkjTYGtrILnKJPod53yz70Lpv7ox/PFUI0Gmt0Wbg5Z2CsBVXpllddjOBn271Tgrq99Jdei/317VbawKGinpFlsBSoTommGEvAH6lgrKIleIXnXRsXAWct/+8e8GLAuOkcuYfGa4pxfdLqakpOzZfq035jbBDwxnJTRMeSskVIKK2RDVyS7BJXbAbhtRehRYfctbCCHQCkdmdlZE5bLNm/5rXdPUfe/hcn+0q1URjQ7+xjVc/iElpPFlc9Pn27S4VitmvAVpTHsTaqD0zDXfpuxmxX2RHTzIK7RaLL9ZLjk3K0aSxfhkXSsiTURYouwih/EReMq6xO+DDu+R5n3qxpMxlzbsrWFnKJxTH0/HoARUqVlrD1/uWJKWFOsVXt5khJDbIzwn4gxHSgbNZ7wgAfpGbqLAqrOcbRBgepR6ADrsy2so01XO5XfYBiRqKvblRNGpSCFh8ky+C0Kpu6lKDDLINxMsdVkfgqWWZ+oKgUl56tV4UxkiCefupDITtohdsjrUW6PYvZfP045AI3bF1wa8WNmIenMEzJ5qmEmL+s8NwChIQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(18002099003)(10067099003)(11063799006)(261022105027099003)(261026121527099003)(261102123227099003)(261009223027099003)(261028144727099003)(56012099006)(261021121427099003)(261021123027099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4Q+SssO2NFpx6CmbWKWt8xnF+F8/gOuNbsGTE8OTOV2mDqMBIwTSwYu1LkQPyrrXpkf9IN5zRmKdvKsa56PjszPUQRy0t0Q/KUQqlJArjCXduC1MUeaVbGqIOJObeUmq4743ukIbqoMyJDQzsTCAH1HC2YfTYsMf31FrUq6mf4Q+itNn3f3w8lAHNdJfy4ZrMVKqPxjEUIs/t70w5La0WXq2UK/2iP+FyPUef9t+dtbdkYv7XHqkbt/8l4lArLuCNnkD6g4pejWCUOBFKWowccjLHeutp7rYfoIODPjEvLuXlK6vgS5j3vaQZhu1LLTic4RhxoJdeNjGbNQ3ccGXDJVbCpfLMwfSLLt3epm6qzvx3rFSiitaRGsPfTFn9HFfx7YXa5rtFWJbNG4oOJX2MLO68avKEXJ8IfJn8QlJQVUoLmuYyXbH4xzeYouxZzBc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 07:48:34.5146 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c75c19fa-1a89-4c85-ef33-08df3bda5c33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE943.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6948
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

amdgpu_driver_open_kms() returns CWSR allocation errors without
releasing previously allocated resources. The DRM core does not call
postclose after a failed open, so these resources leak.

Allocate CWSR before mapping seq64 and initializing the managers,
and use the VM cleanup path on failure. Free CWSR if seq64 mapping
fails. Keep ignoring -EOPNOTSUPP.

Fixes: eed183d63b1f ("drm/amdgpu: Integrate CWSR with user queues")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index fe5e505c6f2b..e18b19f14a1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1569,10 +1569,17 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 			goto error_vm;
 	}
 
-	r = amdgpu_seq64_map(adev, &fpriv->vm, &fpriv->seq64_va);
-	if (r)
+	r = amdgpu_cwsr_alloc(adev, &fpriv->vm, &fpriv->cwsr_trap);
+	if (r == -EOPNOTSUPP)
+		r = 0;
+	else if (r)
 		goto error_vm;
 
+	r = amdgpu_seq64_map(adev, &fpriv->vm, &fpriv->seq64_va);
+	if (r) {
+		amdgpu_cwsr_free(adev, &fpriv->vm, &fpriv->cwsr_trap);
+		goto error_vm;
+	}
 	xa_init_flags(&fpriv->bo_list_handles, XA_FLAGS_ALLOC1);
 
 	r = amdgpu_userq_mgr_init(&fpriv->userq_mgr, file_priv, adev);
@@ -1583,11 +1590,6 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 
 	amdgpu_evf_mgr_init(&fpriv->evf_mgr);
 
-	r = amdgpu_cwsr_alloc(adev, &fpriv->vm,
-			      &fpriv->cwsr_trap);
-	if (r == -EOPNOTSUPP)
-		r = 0;
-
 	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
 
 	file_priv->driver_priv = fpriv;
-- 
2.50.1

