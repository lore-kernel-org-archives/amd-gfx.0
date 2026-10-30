Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F259B606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 06:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5mv1Wu3e
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 884A5112653;
	Fri, 30 Oct 2026 06:31:45 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010053.outbound.protection.outlook.com [52.101.61.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B63F210E84E
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 06:31:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kjdKf8ixjO6jm8DqZGoocFb19jXrLLkdqEm7dk0ybTs0zhUXTxd+4Gim3xRCN8z7W/YT3I1Mr3CB7Y1yRqG0fNAUxagLYJCzCL1fufLPTyf240iN5q9dwCLvmaDFVNBpQM7gbrCEbLZC/3KNyav2Ilm59zdi7I6KMl4UFTaXzoNn8l3yfu9faJxBlG74XeM57gtl8wcanahDbqMGgs7TYNQsthhD7G+KIQ/HPkIccoeBIhmlX8Pbl5aJKuB7xAGRVxQfneDdI0Db3UEQjM++phwO8KA0ANw6odI4Yoqzl7CnGNEq2u1irjBvYWElPjEbj8qIboKqg791sFusOQGKzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoIcJC+0GTfjpk66pgXEbHLaq/eL5qi40yXNXdIS5V0=;
 b=HEm3/+6mpN8fDaSxu3N9CYygLr72jjJdaX/Gp+Wp36493s3SUqSNuPe4D0VHgUPe4rlBrW8MYtT01PbG6gBHoVfkQUNFKt/sHyWiA6rjCw5t64ofNQL7amkk/ltpAUeeUS5mL69JMXzBrw5vNw9VDZ6azQQMn4xpK6Ft6E2WQ3iEIfSU482J8+HpDP4kEFfOjf/A+SIJwqcjOJa660wjsWLDqd3nC3AqilXkeyLqCMbXLiGH6B8D8ABVnB9uNeA5Warsrcu1XgDNp3j1IBbaER28g+4A0Xl0RBXsUd0kj3dAGN2ysW36nDmhAeJ2i6GgQm+hiFo67B7fs8BCuB4i5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoIcJC+0GTfjpk66pgXEbHLaq/eL5qi40yXNXdIS5V0=;
 b=5mv1Wu3eYCuEfKNLNRCtLDL5tWxeEt5hGm5EH+TYF5kXKpd9Z6nF1xjyVTk9E6tNNIFRJimjvSxwpbAsqx8Q30fwM2uZVEYefUWWhYIuEBi2YGrHl1f7qZlERuER6ukG1smblO+EpvvrFo2MIKMZGzH5MoZwcwLfhBAcOQZXWcA=
Received: from CYZPR10CA0002.namprd10.prod.outlook.com (2603:10b6:930:8a::6)
 by LV8PR12MB9261.namprd12.prod.outlook.com (2603:10b6:408:1ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 06:31:06 +0000
Received: from MWH0EPF000D8950.namprd05.prod.outlook.com
 (2603:10b6:930:8a:cafe::92) by CYZPR10CA0002.outlook.office365.com
 (2603:10b6:930:8a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.10 via Frontend Transport; Fri,
 30 Oct 2026 06:31:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000D8950.mail.protection.outlook.com (10.167.249.216) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 06:31:05 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 01:31:02 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>,
 <Benjamin.Welton@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>, Benjamin Welton <benjamin.welton@amd.com>
Subject: [PATCH V2 RESEND 02/13] drm/amdgpu: add device-wide PMC config
Date: Fri, 30 Oct 2026 14:31:30 +0800
Message-ID: <20261030063141.2773032-3-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030063141.2773032-1-lingshan.zhu@amd.com>
References: <20261030063141.2773032-1-lingshan.zhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000D8950:EE_|LV8PR12MB9261:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fec2f04-7609-458c-be69-08df364f6048
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|11063799006|56012099006|261009223027099003|261026121527099003|261021121427099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: /kVIUY9tYBWJIyvqyCRdPF6U+3MRQbQvWaixeApvaT4jQcsxyi22dwFZmthowDy7T0s0EdXThSQQBWOfxzs8C8QgiDj8AyOj52dJFirg2gtJhma+wXD3/82UMKY5byBeVUjv2udDkpJYgR6SQxf0Ki3swrl7UqPoeys8sZBUlcbvY4dPEWjIyMbOXBc1N+0IoKsmNQKTQ5HWZv2qM3PgQlPY0Ongevw6i7qAS1ILoJni8jdAgaVaHmrZGzZQgYhVMgATRJfFCQz/wjiOx3q5mzIfuZVHFZNetW1BDA4FV02BnHMo5g3k0Y/O9/H/Z2tw5LprhvQSUaOmFhk9eetBQnIheJQWmolkzXu/X1WgyROGXHj3fEF3zXYWNIa7jgUEn/aJvxZSxhKapVrHxK8vXxOonlYGjVepPDeRQzRgWKPwvuuajV6/KCEwraZwlk7K3iGxJ2mlnkqQnAqv6VA0mTez4PJHeEzpea/QM+bRHO+hY4K0TH3Wt0JkT07Jr3KN0MoYT/fms9xXORNn6ZQerZw5mmUpw0AMSEGABUsBBvrX8U4W+IQF27Nr3hxYo08JM7J7qWur66/rAsPbIxKKjjvsiz8BKql7eXo6lRTlUKDLFRNkqLKd4ligLCjL7irfA11iDoRA6ylEJj0QxSRV0Ubrd0uezm8B/C0Qij/u8LdwwY7ktvFtaiD1dmzf9QzIPOjIsSv61rB8qjx3yKfplw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(11063799006)(56012099006)(261009223027099003)(261026121527099003)(261021121427099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3EMMq/iQD1YSJZbuCgBj2osFkBHNspRcrUcT523DxFicorHKMpJxDFVXYmGeyFzSuUxbMAULyfb+gpf0qj0mxPsC0zQR1ezMRCXAV7reNLhw+hFE7FyR5FLtj9wbteixeue3cpv2jPWiflim/gnvtrg2sAzRC+UXmpiuWI1liYUYbxI0iTC0NoATMuJ+onNH2E0hvso6uaGrE2DaJzcGNy45vdqW4W82lyNGxdZ2qjNpmSdhmVjP0NuKsYRqqpNCXVMqhkNgwLcx6gPVebFXGUmoDVnOZGL7NAszjwoepKPQku+mE7Wo9q4bGpfGpyV+upLR9kOe/8z8EpxK20FLz/0FdH680ObEt/F/PganKyr81OwCfpAA5PUOXniE3UCV4dbx4KnvupKcobGIrJ6TQ+I5hputjKZAoJPZOrMiJuEGQTK3B2Kep6QHAIQhQIO4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 06:31:05.4255 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fec2f04-7609-458c-be69-08df364f6048
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000D8950.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9261
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

This commit implements a device-wide PMC config
for amdgpu, which including the profiling owner,
and the profiling enablement indicator.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Benjamin Welton <benjamin.welton@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 9 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index e3763c197138..f1db089921a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -620,6 +620,13 @@ enum amdgpu_enforce_isolation_mode {
 	AMDGPU_ENFORCE_ISOLATION_NO_CLEANER_SHADER = 3,
 };
 
+struct amdgpu_pmc_profiler {
+	struct mutex		lock;
+	struct drm_file		*owner;
+	bool			supported;
+	bool			enable;
+};
+
 struct amdgpu_device {
 	struct device			*dev;
 	struct pci_dev			*pdev;
@@ -818,6 +825,8 @@ struct amdgpu_device {
 	 */
 	struct xarray userq_doorbell_xa;
 
+	struct amdgpu_pmc_profiler	pmc_profiler;
+
 	/* df */
 	struct amdgpu_df                df;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 380989f4c965..c466f67c6556 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3673,6 +3673,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->pm.stable_pstate_ctx_lock);
 	mutex_init(&adev->benchmark_mutex);
 	mutex_init(&adev->gfx.reset_sem_mutex);
+	mutex_init(&adev->pmc_profiler.lock);
 
 	/* Associate locks with lockdep classes for ordering validation */
 	amdgpu_lockdep_set_class(adev);
@@ -4244,6 +4245,8 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 	kfree(adev->pci_state);
 	kfree(adev->pcie_reset_ctx.swds_pcistate);
 	kfree(adev->pcie_reset_ctx.swus_pcistate);
+
+	mutex_destroy(&adev->pmc_profiler.lock);
 }
 
 /**
-- 
2.53.0

