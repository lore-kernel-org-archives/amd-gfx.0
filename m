Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E85606A322
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 11:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uKOMi4tG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 860AF10E241;
	Wed, 21 Oct 2026 11:09:41 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011049.outbound.protection.outlook.com [40.107.208.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8823F10E241
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 11:09:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dLJb2lMVomuRJObEPkfbYBegm65vaTlmKdzMkmZXEjM9I9bPqdcj5amLB8GUDyvpvazmTHlkpk9O/Z+6sOPoQFXTFH9jPlcCnkLWMNp+A3YUHjE+FGxwvAbKO4l6TRUxnCai6QBH0HajzstyZtJgU5sudpcgAYYc/+K/tz+L2kk9zlND+QtftdO3ndyPPUK7jgKUTm8iz9OXKPrJ6ypsslTPtj+o++3zP24l+JAPN0qM879MdgPb7CNRtDPt0z+Ap6JzhSO+Wi4UFES/Ly89x+EecWlX/BLR2JrF9uk996648e3MhmMCzc1se6HPzohN65vTgU9Mru7Q+QFkJj+HvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cub5LefgDqbBrBrPJWIvV2/hSqwKVq9+dVpcXIWUlGA=;
 b=SZa6I9NL26tMcXSPYbE0wfARZpNvSh6dEr0t2B9jDPiGkhRewFy6tkP8cbIS/x/BLwU/eIYXxtdRpM2XuWYVXXg1TyV3Ok9J5ZKzm1LF/VA38AieHlEv1psCRuWPzN9/XrF1EFTeen74yfuoXNjxHgOKLKx4xfaDqf10zpaHQCQlss+GFcruTt6layyZ2/qSeKbo/AUET5f4U5iTBSUm2r6OAxdhkkjKarsAQ/1hxwb6XaMxdZmY6ttNoekZBR+oIc1zBrVzc1WAHwMMpv/exQHedxxBgP1gHHG8R6oyYhSjg9NYHmNgW+Psi/Qlr/lGshXvcMX/2bpnBVsK4rOgLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cub5LefgDqbBrBrPJWIvV2/hSqwKVq9+dVpcXIWUlGA=;
 b=uKOMi4tGhctFZeqG40VCE7KOGSW2UQ5AxbP5eHP3b1D76nALW21bh5mh3SmIqKosguiOR90vgCWJN9gu+G5vRNk3fxklilmipACif4At8vtrRlb1Q/nov4s0WUe0nrDTnakM8EIQc9rz3ut/45Z/HZWrAr4rzRg6B5y2/wuGqPE=
Received: from BN0PR03CA0045.namprd03.prod.outlook.com (2603:10b6:408:e7::20)
 by DS5PPF482CFEB7D.namprd12.prod.outlook.com (2603:10b6:f:fc00::64a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 11:09:31 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::82) by BN0PR03CA0045.outlook.office365.com
 (2603:10b6:408:e7::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 11:09:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 11:09:30 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 06:09:28 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>
CC: <Benjamin.Welton@amd.com>, <Ray.Huang@amd.com>,
 <amd-gfx@lists.freedesktop.org>, Zhu Lingshan <lingshan.zhu@amd.com>,
 Benjamin Welton <benjamin.welton@amd.com>
Subject: [PATCH 04/12] drm/amdgpu: add device-wide PMC config
Date: Wed, 21 Oct 2026 19:09:55 +0800
Message-ID: <20261021111003.3371005-5-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021111003.3371005-1-lingshan.zhu@amd.com>
References: <20261021111003.3371005-1-lingshan.zhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|DS5PPF482CFEB7D:EE_
X-MS-Office365-Filtering-Correlation-Id: 322103df-c19e-460f-b6f0-08df2f63c78b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|22082099003|18002099003|11063799006|261009223027099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: ++YfEHXWML37mpLxpF2XPRv7BE6GkutT1J3qqz6dZFRcahFuGVz6U5dtEvJD+FU/JT6U9SaQRPiTdfE5SZ2Z4u4FzveGpHGgvEqRXd7k7GfUrLCPsNkSuNIQQyX/9qo0li1L6tjpNkOEGAe9xcl9dEkbKzFe8VIuUCxuXuxrFnOaqQn8F8buNQYhSyD6Io/vX7noIoWBkxZCfFaob7O2ZS3g4pp+k5pTGZLPx9FXb/rE0pB+Mcqo5+ZjDDSttcoLgzfAJ2FuSgcWsDoBo8UlG6SDBul/hmERvj+wG2jm5R47HtgngQ7ja2rOTq8qTZt/g7aMWe6RfymSC+KoKCGpVnCBjOVmj9s2w7ZbTvaVrMM0MyAnrzrOdGGE3IN/HCvK1vK9+ZdBqUH8umKL4AMskIcZLhZ2D9ulFwqBjxTBT4kTosGTpbakU54uDkHPe6AygbQvBJx+CcUpCBiHcgseZE1Yj4qTL+RedOVMXYFDLpeuZshOpRT9mHgNW4pP5aHfXO7yG3mXhvA/Bhmjl5ZvoOStlrslTIZIds4qdjpxZEaDR+Sp68FcnTRJUOAfdXhMcJz8HjQjP6kHEoudZFrsuMfPFcBd/ktrWYurWauSNbB6vckuM/kVbIZdWUqbTtWDrCw5Nb+DFMAXaE2pwCgBhuFoNpt35xb6BV4WeH0UvHbTx/wkRaOVQEJyG2gDz1Kbp5RgD8SDME2Kj22OGV9aPA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(22082099003)(18002099003)(11063799006)(261009223027099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3zR8iLbOBrXjEXC56K45zNu5VbyuHKZo9xVSW3YW3nvLNQ0GGzdcecwfJvcXIGmLA8uyRSdUQNgA0UJDc5eUozET16EMH+QJ16VRwki+1KALR/xdj7Nz0UbkPCC96TvkjqMxO9NTsq+kIpb5mYAhesOfhZegcP6dG4Iv+v6K5lpN0XXPOj9H0eWTCz5vD8xxFiHJjsCI8h3SU6XKEIFQURgKWfPcYR2s4YN0p1hU6f7BYTsq6nMVkaa0JCsNdAdcD3N/YUACkWnqDWe+DFDyfIOY26bet53fa5hmx/ZUyk3CEpBO3sr99xRfFB/PgBc8iTgNVdP9KXQnEYx/UxtZsYy6Rg0VEovZTbYTHTS+TLtU0ZgYEpfmvhZOmW3rSEH5qk1ALs+9F43L5Svj5ryoPcC0UqRbS0X+d0LTQxX4w0tJwpvPhfq2raevA/XBkrEQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 11:09:30.5573 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 322103df-c19e-460f-b6f0-08df2f63c78b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF482CFEB7D
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

This commit implements a device-wide PMC config
for amdgpu, which including the profiling owner,
and the profiling enablement indicator.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Benjamin Welton <benjamin.welton@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index e3763c197138..386d9e5d57c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -620,6 +620,12 @@ enum amdgpu_enforce_isolation_mode {
 	AMDGPU_ENFORCE_ISOLATION_NO_CLEANER_SHADER = 3,
 };
 
+struct amdgpu_pmc_profiler {
+	struct mutex		lock;
+	struct drm_file		*owner;
+	bool			enable;
+};
+
 struct amdgpu_device {
 	struct device			*dev;
 	struct pci_dev			*pdev;
@@ -818,6 +824,8 @@ struct amdgpu_device {
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

