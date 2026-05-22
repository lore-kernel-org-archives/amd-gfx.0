Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E115CD5BAB
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2026 00:22:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D87010F474;
	Fri, 22 May 2026 00:22:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZOsBhFHA";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010004.outbound.protection.outlook.com [52.101.61.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C128210E58C
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 00:21:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RB9xYkaE37T5LVHDm+9QY5fmE070xOPu+WVOIi+gyBAZ9eIjXO/iJVIpOFsgIaeJmhGh7eFV0PuMqAWIJsyETbyD8LOSahvaFe/E9Ltn75pUj+m/xVFpTpjWaIUcd89yul+zjtUYFHdFbW08mzp20kI/pdJ1wrLBKs/ira+vn1tFZdj9gvNGotjOG20nZYFyrXJLX8J8rHnmtjQuO6ja4tNwBPuPbBVtFK9d3IbnzxYX3mRKHBoLEMzwxqHPxt3OfRu1RDrO7vYTZmsNoaeXBpgWYkjUx28WWySKm5DQ9T4WpjyYKc3gWIPbWNdrFCN5qtxr/VqJcxqFAprNZJJpwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9vvCKRiPFX7HdEif1DJKXBGF1iBEKZyB61k5iKWtTE=;
 b=VUhRFF+25RPU+I7Uv8d6OtIfwe0NeDWu1gczMr5KBvx3WXWVqPuNios2y3Ebs2Tyo1AKbGjl0RTYv8jHpqilxAOr/+ZpqWXoVj6WEqtInYS3GerVbhFbI5VIC6uaiG6kRbuXdm4FIlJN6EpnEPqHTralZo51LARWdiuQbvCglTyapN/HgW4SoACXMLNbtS2Umnb22ihEOAFnwmfY7TSJ1caWqDWxl8+uViRvLo7pLHckdETyUP4RxKkp9rF+KgYdcYmaNQPP2EQO0op+sq8gjB5IVtbLlVcTAksOuTyH/T4yeRokIND6T+RAkWVLsnjVwZHmGVPhhEb29GP6TynzIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9vvCKRiPFX7HdEif1DJKXBGF1iBEKZyB61k5iKWtTE=;
 b=ZOsBhFHA7dKJZRuzPMLwFlY7mEsjW5sqKiC+kMhsUbS3LLfoQ5lljlV8Q3+9qLVZR+85hNDe9Zh4e68PswrjmyvscZG8ZwfzOno+KFD3Kt9XQO7oTxXPsmguUY25ZAUoUvBtJipS8qhkYNwOQziEZ4tL2a1wrUdJyLQdWVVnlcQ=
Received: from CH2PR15CA0009.namprd15.prod.outlook.com (2603:10b6:610:51::19)
 by MN2PR12MB4127.namprd12.prod.outlook.com (2603:10b6:208:1d1::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 00:21:56 +0000
Received: from DM2PEPF00003FC6.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::a0) by CH2PR15CA0009.outlook.office365.com
 (2603:10b6:610:51::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Fri, 22
 May 2026 00:21:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC6.mail.protection.outlook.com (10.167.23.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 00:21:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Thu, 21 May
 2026 19:21:53 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 May
 2026 19:21:53 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 21 May 2026 19:21:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sunil.khatri@amd.com>, <Amber.Lin@amd.com>, <Jesse.Zhang@amd.com>,
 <Shaoyun.Liu@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 18/42] drm/amdgpu/mes: add a MMIO queue reset helper
Date: Thu, 21 May 2026 20:20:24 -0400
Message-ID: <20260522002048.98506-19-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522002048.98506-1-alexander.deucher@amd.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC6:EE_|MN2PR12MB4127:EE_
X-MS-Office365-Filtering-Correlation-Id: 87072447-1a64-40d8-d068-08deb79821ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|11063799006|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 76eUIdlijrVu8wZb/zFhf/OjM7VeF/j3PN7Cs2MVi5jGaSb2WDn6Cd0gFHekxHTi2+8DF4bCko/EeR52xtWxrww4KXJXVIGmXaxIXFl8X9GluKQuthhWf4J+x85ACHpsNKT9c4xml75ZTr21kvlHR5E2iyt/JkuL0y0lB1XlE6xLil3kdbC281qzntMj3MiIugNd8uLmQ3Kbdzl2TcGNGZTtMoiyFq/tCT9ydMH0TQhN+oRooYrhQQ0X37ma0gp6JgZNJQ6xQcH4wBYNLZPdXXGpwbztO/CgVzzSE1OCiOm0ym8uHUQcEYnzRvgQ7HZ0iHPM/7ddalUlS3IZbwq1jH0ycKvT4Ygb4Y777ui3pqfDZ6n6G27b883y++cYSvNHHEJ6FnQm4BxT7RAxG4W/XNaqmUe+KJvSet1Qnu9ddMhG7j1jWKmUuK7EsuwuJZnTt+B5Mw6NkNR1qwO6Tpj2NKB2DAACQixq0jSxVf337qtz1L5IkKPQRHh77yJDCgohz2lOku/VY6qSYer46MiPudLNYo2wjLpGZXAkBpMd/oGz45Fb446iHA5PjjBe0YbzVnXrT9m2DB8h1U4XvSOLOWwoyN7lPEOSA/Cw/yiFnWGvV5s2Dsxe0J9sGromr1wouCbCX5TevtQBBq0PhH1WMcTc9cNTq3SXc6AyFVU0nidsCtZjgCeO3/ERnyiGRNZkSkgslcGdnh9hyOQ/24YsolCO4N/biyBPCCLUwzMJwTY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(11063799006)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fM6s0bsZE7EkOHlrlYvOvEFjLTJ1edpWCckeGmyDAtfzYo2ujIm3rndYEWYdAqij9SzjyG9N1f0XmNZdy6XBKYejGlRw/lqFoKrWnlsHO33eo28PRhEAVVCw3QoWGKijmyFKeA2J3wEbeiBs56wbzZ7vKRMO2z7b2P/PbI/3zA3PPueUGQjf87F+Al0ksRPpTYo48puOGwZL8yL4hQteqbeg30tJacjSoqapqM5wlcmC6+FBuO76EjZ8cDwCBej2nb0CLCgkgmrFzt3uwR0UDWC8lQ2lD3g3QWyQhlKkaXoI4imWIgqYTFodk6M8smX+0/Utzftol7cp9f0f9SfcPVRztiBPO1Je378qNFK1m1SSnkfLYRgC2+uP4Bi5ke6geDGSae6n1fJ/9aPZjUev2xKmGJHG5yi+6jUNAVAIHIvGGKwMSQgtQ6NPOpyIVxsc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 00:21:56.0390 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87072447-1a64-40d8-d068-08deb79821ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4127
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

Will be used by KFD for MMIO based resets.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 30 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  7 ++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 00682bcf40193..ad1b620230a95 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -439,6 +439,36 @@ int amdgpu_mes_reset_legacy_queue(struct amdgpu_device *adev,
 	return r;
 }
 
+int amdgpu_mes_reset_queue_mmio(struct amdgpu_device *adev,
+				int queue_type,
+				unsigned int vmid,
+				unsigned int me,
+				unsigned int pipe,
+				unsigned int queue,
+				uint32_t xcc_id)
+{
+	struct mes_reset_queue_input queue_input;
+	int r;
+
+	memset(&queue_input, 0, sizeof(queue_input));
+
+	queue_input.xcc_id = xcc_id;
+	queue_input.me_id = me;
+	queue_input.pipe_id = pipe;
+	queue_input.queue_id = queue;
+	queue_input.vmid = vmid;
+	queue_input.queue_type = queue_type;
+	queue_input.use_mmio = true;
+
+	amdgpu_mes_lock(&adev->mes);
+	r = adev->mes.funcs->reset_hw_queue(&adev->mes, &queue_input);
+	amdgpu_mes_unlock(&adev->mes);
+	if (r)
+		dev_err(adev->dev, "failed to reset legacy queue\n");
+
+	return r;
+}
+
 int amdgpu_mes_reset_user_queue(struct amdgpu_device *adev,
 				int queue_type,
 				unsigned int doorbell_index,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index e0d4abfeb27b8..de7307ef60c13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -458,6 +458,13 @@ int amdgpu_mes_reset_legacy_queue(struct amdgpu_device *adev,
 				  unsigned int vmid,
 				  bool use_mmio,
 				  uint32_t xcc_id);
+int amdgpu_mes_reset_queue_mmio(struct amdgpu_device *adev,
+				int queue_type,
+				unsigned int vmid,
+				unsigned int me,
+				unsigned int pipe,
+				unsigned int queue,
+				uint32_t xcc_id);
 int amdgpu_mes_reset_user_queue(struct amdgpu_device *adev,
 				int queue_type,
 				unsigned int doorbell_index,
-- 
2.54.0

