Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE9EC48BEB
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Feb 2024 12:59:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCD2210E875;
	Fri, 16 Feb 2024 12:59:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vNGD9EGZ";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2060.outbound.protection.outlook.com [40.107.212.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8978310EB33
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Feb 2024 12:59:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dc7QeuOFBgu9d0DimhExi6/PNBO64f+NTnG59KCrPEm0w3Eb/SC5TAmy9Z4yQNqQbPPgb6GXRnlf40ehtrF2SS0pADThn8JUoYz9ItYB0KBr/o/k7mQqlzLibDTW7kq5ZtKFtOqCaQorGIRpeipk74SvikUx323R63jQsHpUAk5kEUh33hoMJXph7Sahe2ZEHr7x7taEC4pk4f3JQJ1n2nioMSmOPqiP33YEn1Vm55pJLZlBoNycG3xMO4Aa6H9lRu+3VZdWpoVpvSpqFawPl4uwJjs1v5GoGJuplA2QXNar8OQOYJfL2AmiEXMak2V8p+MrwD3J0Hgnna55Od7ZaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJlJjc86BqY+6FOq3irb5Qm4BCZFY1khn4TPSYrrHgI=;
 b=GYdakRziRH5Od7TUJtqMbfmwYbseui8dqQHNwomvmo2zqV4UuJRMCKWJftzfcXKU1b2TE0mNS977+SZA1gj6D/96YMtN5oY7XTeKlZWKfsAfKOFnacndNjrrZ8+cOGVDYJA23JRKpggeJ087dI5BJKgfaQbNVyb1MPzano8Lwav4cEB+iSKjrawO2kZYOrTDcBrWREWeaOKGJ7C0oxDVbU9xthDc1rDVV0t9do4NliMNmO4lYNGK6vUJWJ+dyySC0XA7UstMEFkwTPAkb47N3xrnnTmKuDTTD0vn2tZzHyu1t91Yr3nHmYkQ+17b1JW9AUz5syd++lXXuyzaq+vb7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJlJjc86BqY+6FOq3irb5Qm4BCZFY1khn4TPSYrrHgI=;
 b=vNGD9EGZ8UKo0//hU91UDkH/iJghy2Xs8K3dtxyKDHr89lhtjqNdr/7tAoG7cUmoIykQpfs+Dtb0umcaBoZ5Q5MVgEbsiV+rYCKM66DWzWwooF/qpbhNQSTR0rnzw9zy67XQKNGVkpEKGbMY1noKNCyE6DU/YjrAjvjPP/7npCo=
Received: from BN9PR03CA0394.namprd03.prod.outlook.com (2603:10b6:408:111::9)
 by PH0PR12MB5677.namprd12.prod.outlook.com (2603:10b6:510:14d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Fri, 16 Feb
 2024 12:59:44 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:111:cafe::c0) by BN9PR03CA0394.outlook.office365.com
 (2603:10b6:408:111::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Fri, 16 Feb 2024 12:59:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 16 Feb 2024 12:59:44 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 16 Feb
 2024 06:59:42 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <asad.kamal@amd.com>
Subject: [PATCH 2/3] Revert "drm/amdgpu: Add pcie usage callback to nbio"
Date: Fri, 16 Feb 2024 20:59:25 +0800
Message-ID: <20240216125927.1821169-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240216125927.1821169-1-asad.kamal@amd.com>
References: <20240216125927.1821169-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|PH0PR12MB5677:EE_
X-MS-Office365-Filtering-Correlation-Id: 26fb8881-20cb-474f-21ce-08dc2eef25ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 30TrWKq7QYUM6/dmaEcJ/zBId4wZbYC4bBsegmaZnAz9aTud55Up6oiMttUqAaEZHIrp7tibuP3TFtOYfeu+INPxn+XsuPUx9R6WaF1QKsBRGLm2s96XHXKPMn7Rq7rSIhb1rGn0GwyPxMWlkRmYAEyXtJsUyUtekaqxx/oD1/mpWU9Pq5jIfJBXXwlQeFgNhJFUTbq3vVyIsjZya7TfXIXVW7UL+bHR9QlJlVSwezyhz4WiPrAWE5VCm8PJbkXOtaGGxmWAJhuK1xGJEOUnwYIL04nZw9EO1H2INeY+mAIaB1lpU41NVOqrUQVRFcwL1ke78k/Si97sdpWnvOERZGgX+B2tLAsqWJ36myXVuigF0rc97gPsRDZegMI0rbGXm3pHpGYauQ8djPyiLUU0LFqnOdZ6sg9h6sWyZ/HuFVD2WliWmxQxvTGeauImJ04FvZa3rY/N1FrL2sk/JJ4TV4V069inrsZ9UiEfYwugSYhQ3fXKM8ylIQ5ozwSd3EXBeoWtDGk0eSkAKFmHBnXmKwSLkvcKOtFPsOxjV7+wgenSt7eQov+FU6mm0C4Kq7ZjWI0SaJFK04gx3EG3Y4rm8KBnRXG2GGKgpNLj43zTzwJvM3B1XrTBQ3eQy+RoHYcyWa06h59nO0ZVGBkWYCUJPTAFA3lnnoTST6LIIXL8o0s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(39860400002)(376002)(396003)(230922051799003)(64100799003)(82310400011)(451199024)(36860700004)(186009)(1800799012)(40470700004)(46966006)(478600001)(41300700001)(44832011)(5660300002)(8676002)(2906002)(8936002)(4326008)(6666004)(7696005)(86362001)(336012)(70206006)(54906003)(6916009)(316002)(70586007)(426003)(81166007)(2616005)(83380400001)(356005)(1076003)(26005)(16526019)(82740400003)(36756003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 12:59:44.3398 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26fb8881-20cb-474f-21ce-08dc2eef25ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5677
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

pcie usage is now handled by fw

This reverts commit 8d759dc6644df4141a151293cb0e77fd8ca379ed.

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c | 8 --------
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h | 3 ---
 2 files changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
index 51ca544a7094..d085687a47ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
@@ -53,14 +53,6 @@ u64 amdgpu_nbio_get_pcie_replay_count(struct amdgpu_device *adev)
 	return 0;
 }
 
-void amdgpu_nbio_get_pcie_usage(struct amdgpu_device *adev, uint64_t *count0,
-				uint64_t *count1)
-{
-	if (adev->nbio.funcs->get_pcie_usage)
-		adev->nbio.funcs->get_pcie_usage(adev, count0, count1);
-
-}
-
 int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	int r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
index 65e35059de40..7b8c03be1d9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -102,8 +102,6 @@ struct amdgpu_nbio_funcs {
 	u32 (*get_memory_partition_mode)(struct amdgpu_device *adev,
 					 u32 *supp_modes);
 	u64 (*get_pcie_replay_count)(struct amdgpu_device *adev);
-	void (*get_pcie_usage)(struct amdgpu_device *adev, uint64_t *count0,
-					uint64_t *count1);
 };
 
 struct amdgpu_nbio {
@@ -116,7 +114,6 @@ struct amdgpu_nbio {
 };
 
 int amdgpu_nbio_ras_sw_init(struct amdgpu_device *adev);
-void amdgpu_nbio_get_pcie_usage(struct amdgpu_device *adev, uint64_t *count0, uint64_t *count1);
 int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 u64 amdgpu_nbio_get_pcie_replay_count(struct amdgpu_device *adev);
 
-- 
2.42.0

