Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB84C5DF8C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:50:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7D0710E34A;
	Fri, 21 Aug 2026 19:50:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hVZBZFYj";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010052.outbound.protection.outlook.com
 [52.101.193.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A42E10E34A
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:50:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNKnmQ7rfCTSWiyWpo27CCAQBnICEzL9FABnPgHISXduODxGCMuaopmAnYGaBXP2LZNYmTh/teQAGwwWJT1egK5iC3BitNdd+L3IEiRsQkug4dXFxJszipDQfcoglW2Vl7XqtwuKXorYKHtIcqXiPXBxOG9yUECXKvlTayrSOAYdwnSV+H/Hjdj9r6e8ZmdaWY7uJPRWB0aKpXvwEtgfF1u1K+aK5QcQxH4gv6KCVkAUk03f5NBZiWD0cHe7mr7xUBnm8Wd8xgtgCoqvjLO3mYyNj82tL6Ls0GvYzwzBEidqllOHqOl4/MapuPCe95k82Lke7RCQ7o0Pm3PwLv9QbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJ6wwHaregBxFnNv2CbViQhqQgzl/7u5JpjfsZ9aceU=;
 b=x5PF2q99pot1sso8YIEiO07vV3mbeVMKZvo5cwdpXqhc+xj25DTn2ssVV+/p7zmIpGJU1ZUMenDIq/bNdpgi3DlmBJqCZjk0AKqkMxmf3qXhefnr0QaURoMAF1EjDRx0M4m23KhdGobH5VoDC7FEQPGO57CosgePZt9V2RVPbALuyKm1AJPlypMaxBM+Ku8ftneXvtxW57sxLheT4jMd9SVPkJwJ7QiTfuO3HwHEophiUn7muZ/rny7DvAi/YWNbrVCYAzH81GwpSjB92q5Etb9iAUPzv1ZajBdch4VLBaYtoAQU0wUbPURt3+bCOIjj2VgfZTjhDaVsCDOjEi1Pjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJ6wwHaregBxFnNv2CbViQhqQgzl/7u5JpjfsZ9aceU=;
 b=hVZBZFYjxFNgKIgyx0vMu8JhuprJgXfbQ/nOAp1Ue/S/hCawhr20UjMBI8q9oLW1/8WYq0JBA49khXp8e5JB6RavzHcxQgqJDHWNZoQHML/HEHYRBhaL3E2PwA8qU7xlvN3+idPtjgZT8zzwR8VHDbLJMMGUSc5NIIFrcPKU09k=
Received: from CH5P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::28)
 by SN7PR12MB8792.namprd12.prod.outlook.com (2603:10b6:806:341::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 19:35:32 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::a4) by CH5P222CA0010.outlook.office365.com
 (2603:10b6:610:1ee::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:31 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:26 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 25/95] drm/amdgpu: Initialize VM for NPA addr management
Date: Fri, 21 Aug 2026 15:33:48 -0400
Message-ID: <20260821193458.808626-26-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|SN7PR12MB8792:EE_
X-MS-Office365-Filtering-Correlation-Id: ee3ed5df-1de7-442f-bb3a-08deffbb5d09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|23010399003|82310400026|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: ykbcEsOSzeyJnGFohYezw6f43LlRzA+UFahQLAAlE4HqW6lqji4rfMsoNeUwjAK8jf/cGSsdNUT3iwj9JWiXyVDzJaZ/u/fVExYngXZwlkoZf02dKfOUWPNfRLwwkkW/1za/26oiXkUG8XRJ/O1rkmCVLue7KznJVQ2xISwNY20XTln2Y2w6ZNAUzUg+JqOGYmy0orY0vobzpo5cCszf6rpJjWGBkD95eAok+s49dre1RMU4slGWrSFysSrB5Dd6CgMK/D7eEDZKB2mRdZTcgnBrcVzS7QAeTBu0j5VaO5edXtqBVGoQmWuiohed9B6wUv7j/nPn9mjlDonb5ZtDQypCpTh0k5YyBe8UEqSSRQv0xh5Z2au6tJUMII7en8Vt+lIepKW39pHhPloKnERb/gkt2FBFKWKXfKGi9xfTzQPSyztN0c4D1q6GjZTyRo0mqQRD8Wc3yJYfVReXCKJnjtptoDOTZbSeHTVrXS/sfsyZ1IrpTmvv+ZrWnEdO79I42yUip1WsZ45wRCJOQWqYt2KqGiY5dntof4Qw1r6mYxzpePVZddGaTg0Y7i4GFI+V4L4wxTgtj+4dbWq97OtALusrp84K++f2w/llzNIGsYzd2gM9nSM8coPBvs+eAcXTL2UMr633OUSPZWv/Lcno+WRyTFN7ZlzJK3ZarHVL7i8tjmNQ6K6zXYIZPahMgDfU5mTNnsUEr5I/cA8ShZnYFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(23010399003)(82310400026)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8vC2cCLdZhxsM/XA8i58Andx+PieyIyltssSK0WQUnk7HfkOjHCvBdS0ceDIb4p0/PQZh7ukSQ/Jwt/Ntbra+QU0zvIlm4CbmgZ2C0pRn6e2DSWy11dCVUMqfU5FmFMA0C2LUGclvIy6wrsZr7ZHK4k1+h0FNYRP5dPlBvtUEzuxso8SPIe3GJ8PxcsxdlCHbUOo/u31O2nZUZH1slp6Ivm8s4sQyctxKDLro07Y+KBnACWV4OujLVAk2dw0cBt8lvgrde2ie81Y4A4bEUZYWGu+GLt7aHVCu8hS3W4J4+3nDWByfenUxqFiRbZMOLElroyfjCM/fFC/sOH8tA0PXawNo0cYjYgiBO4CCNyzNrg4jc2bxHNYqsqAsbX9wyIVl3OptT51VApA4GZ+69jD1RcuuxfzZQOUFuHNTeR9cuGwWF/Q9cJ0jyE+bh2HTN99
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:31.7490 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee3ed5df-1de7-442f-bb3a-08deffbb5d09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8792
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

From: Mukul Joshi <mukul.joshi@amd.com>

Initialize a NPA VM for managing NPA addresses on the exporter
GPU.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 18 +++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  3 +++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 9c8601f4d16be..db9dce8fa8708 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -1111,10 +1111,20 @@ int amdgpu_ualink_manager_start(struct amdgpu_device *adev)
 {
 	int i, r;
 
+	r = amdgpu_vm_init(adev, &adev->ualink.npa_vm, 0);
+	if (r)
+		goto out;
+
+	/* For using CPU for page table updates. */
+	r = amdgpu_vm_make_compute(adev, &adev->ualink.npa_vm);
+	if (r)
+		goto uninit_vm;
+
 	adev->ualink.npa_wq = alloc_workqueue("NPA WQ", WQ_UNBOUND, 0);
 	if (unlikely(!adev->ualink.npa_wq)) {
 		dev_err(adev->dev, "Failed to allocate NPA WQ\n");
-		return -ENOMEM;
+		r = -ENOMEM;
+		goto uninit_vm;
 	}
 
 	xa_init_flags(&adev->ualink.exp_xa, XA_FLAGS_LOCK_BH);
@@ -1132,6 +1142,11 @@ int amdgpu_ualink_manager_start(struct amdgpu_device *adev)
 	amdgpu_ualink_npa_mm_init(adev);
 
 	return 0;
+
+uninit_vm:
+	amdgpu_vm_fini(adev, &adev->ualink.npa_vm);
+out:
+	return r;
 }
 
 void amdgpu_ualink_manager_stop(struct amdgpu_device *adev)
@@ -1148,4 +1163,5 @@ void amdgpu_ualink_manager_stop(struct amdgpu_device *adev)
 		mutex_destroy(&adev->ualink.conn_state[i].lock);
 
 	destroy_workqueue(adev->ualink.npa_wq);
+	amdgpu_vm_fini(adev, &adev->ualink.npa_vm);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index 95e770b69a48b..506335b56c3b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -170,6 +170,9 @@ struct amdgpu_ualink_mgr {
 
 	/* Memory-manager for managing NPA address space. */
 	struct amdgpu_ualink_npa_mm npa_mm;
+
+	/* NPA-VM used on the exporter.*/
+	struct amdgpu_vm npa_vm;
 };
 
 int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev);
-- 
2.55.0

