Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39AE2CD8CB2
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 06:04:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4D4910E719;
	Wed, 10 Jun 2026 06:04:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3An81ZiZ";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013007.outbound.protection.outlook.com
 [40.93.201.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE3DD10E719
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 06:04:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UjfiX+NwBj/ZOOv8+1tu6UhL6mv5mK+EHTZI0pKuikiV29i6Dnmv8NazAM7MbKosFA53NPDbDoYeMd5Ibganq7Ma9HGnMfz5prKbPAxDic2s6oHfT+qzR3dmpQqZaBptH8nM/+XFRfSPm9wrfPEjPMYRDl5itu0sMyHemk8pyENZZlZ2ndmqvEMUNsVlGMsyxv6f7cd3KyrUyQqdx+ZZc2EuJOXB79aquQwxazo9iliErDl+N5usBX2e4YxRexX1pDNVO+jj8gEBN+z66pD14RHAbwmENvAQkvt9Swu6aZoU/qAfVOXQYmOBcZbAookQ1pBUJZDPSeFO2ySe/aFDEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0hSOhpyJNbMD6B4ldgXmu3PWU96mv5/vOupXhXwJrQ=;
 b=iCnaRQrqZn90oc6XQu0j1UJFkCG7AwrZXODTX7KQfBvDj52j4apydfMXi7RMu2A5cUVVi/1fdQJMPYWEySJOwoLXh1ONCiuFlWJRbg38AO4JScXShOhtuFBh96+d4cozC1qYKTA6o+xb2yM5aA4LR8KvYu+STSbRjiGV/6K1iTxe3Bl6ohpty4NK2IeUleUmmPBeV+9COgLpxEu9beYyN/41MZp0Kn7qnQfTbQLeuFfNsoLURnfV8JRmrM37ZofumB1h/QeybbKdmvRW01vOe7yO6Xgoe1VJSnURXIqEGeiwM8sTUQnUmvFNP6qwsO1+KL33Uxn59xzV6NiUEQM+gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0hSOhpyJNbMD6B4ldgXmu3PWU96mv5/vOupXhXwJrQ=;
 b=3An81ZiZMRHqVGu1Cl6oz1XwNM69WmUGvFv5dmeqBNtt6LjJF7q5RJnbchf1lqAqP0XfPfyBC2OP413ixR0S2TwsQBn6t10QbZOmfNLi6HEEHyCZdpJeGi6af46htylMug7/wed7X61U1u3fNi+Vs02jDJopSCWQxgvW896irjw=
Received: from IA4P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:558::12)
 by CY8PR12MB7315.namprd12.prod.outlook.com (2603:10b6:930:51::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 06:04:36 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:558:cafe::26) by IA4P220CA0003.outlook.office365.com
 (2603:10b6:208:558::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Wed,
 10 Jun 2026 06:04:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 06:04:35 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 10 Jun 2026 01:04:34 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v10 3/9] drm/amdgpu: Add helper to access the fpriv eventfd
 manager
Date: Wed, 10 Jun 2026 11:33:56 +0530
Message-ID: <20260610060402.2769642-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610060402.2769642-1-srinivasan.shanmugam@amd.com>
References: <20260610060402.2769642-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|CY8PR12MB7315:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d165ac0-b3f9-4af8-f6c2-08dec6b6262a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7opMdO8QdF6fLXa6TR+1fulAhOQXfFGAT5P0PNEAb/FXvpcvuWKguAFPump+RzqUCDMrjkv/4L+YghQgeYOjDX5YvPzBhvQDz821XEDx+tbBPk6mURhyswSNAEw6AGKy1ZqXx4D8stwnMHi8A1HnVw7r58Fe/ncLizmu5+MY++Pod8KuF6V5U9EC5P6gwM2u0ZEFADKfslTTEn9WQK/4Wy6z1lPtRqk8nD6pc9LYmnuNtSl23/IjiwBbHSPvEu0MD0FtC5MHQ8wA0uWpUHPuF6VC5JrVeUDrepR258lSdCilTSaw68LITKb/f5EruyD5knw6G6MJuGOJ/rJ6ZRL78yPTFAIuWw3h1ZviiQU6ZE2OX1/KnVuuEaXfGAu8meFiO/lSFAZkOJhHLYpJ4kMyg7P/j0FzBfVUeQRhA6OnpWQKHTWkz3FiEmgmXG5ykLNxlq+9IBqHnxhV5akgTaQSE61DcXvhHX3eH7KeHFRIlW0vWH+7veW9wpmKclnpWwhq6Jf/xcircQgKrDMCctxwfZW7+ivA87ILv9tVDX2wSKlGK954R/2oaCYOeP/XugZtSLeDJDdjcWrrj+bN/ktMuQEczl52GyMNRRP2ZxUHm7+ezEZ7/5JzXuAbYLT+jPN/9+lRW0o5I98HuL/7WNj+oboMuOXy7Lbhx/aHcwF0+FUKo6rotAfRnDRPU8KXKe/wDzYOcsVOG3d/+6ZBA6MRHPsqzEsuYGZ+MvyOaj1YzGM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4ckmGP7YaCSyo2ePZQIH21nbppAKvAQ6BsYhc1xKJtzC6KyWePjDx6wwvCq1ekEvKH3cy5xIu/J4c3hY7vIAvK2nPC9Exub1eQdDdSDJyIfTMG/370zV9+JiUCBC6zOWxEkmU+b6wWFwn4lwsKjS9LTyh3D1V85T+YoieM7xqWYhhhkCHBJTWHsZ+qKZzf6Ows5jdIKNHeO38UR1zvV3Xecsu3WJT9AB1O7wQzmaFK10tB0yFt/MQDMLjGT0A7gkb8/uAQQmT99dUMikngrP+OmRkvjQq5gcbEXLhj9LCxvWf8GdZMKOZElZSz6URVben3AjOam/U5SHaS5e+CP7HCWtYMKQ+G6LLObZchhF2YGQO+aM/4tC1/BRG3RJZsM5+vWD8+t/vaqtkW769DW2SzaBL5sScTzIZP9/j736UgZKziGoYuDRSnY17h4Wxdsb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 06:04:35.9542 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d165ac0-b3f9-4af8-f6c2-08dec6b6262a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7315
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

Provide a helper to retrieve the per-file eventfd manager associated
with a user queue manager.

The helper resolves the eventfd manager through the existing drm_file ->
driver_priv link instead of storing an additional eventfd manager
pointer inside amdgpu_userq_mgr.

This keeps the ownership model unchanged and avoids maintaining
duplicate references between USERQ and EVENTFD state.

v10: (per Christian)
- Remove the extra eventfd_mgr pointer from userq_mgr.
- Use the existing drm_file link to access the eventfd manager when
  needed.

Cc: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 99c711ddf71e..376813e9623f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -34,6 +34,22 @@
 #include "amdgpu_hmm.h"
 #include "amdgpu_userq_fence.h"
 
+/*
+ * Get the per-file eventfd manager associated with this userq manager.
+ */
+struct amdgpu_eventfd_mgr *
+amdgpu_userq_eventfd_mgr(struct amdgpu_userq_mgr *userq_mgr)
+{
+	struct amdgpu_fpriv *fpriv;
+
+	if (!userq_mgr || !userq_mgr->file)
+		return NULL;
+
+	fpriv = userq_mgr->file->driver_priv;
+
+	return fpriv ? &fpriv->eventfd_mgr : NULL;
+}
+
 u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 {
 	int i;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index d1751febaefe..8c4b55517a0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -183,4 +183,6 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
 
 void amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
 					struct amdgpu_bo_va_mapping *mapping);
+struct amdgpu_eventfd_mgr *
+amdgpu_userq_eventfd_mgr(struct amdgpu_userq_mgr *userq_mgr);
 #endif
-- 
2.34.1

