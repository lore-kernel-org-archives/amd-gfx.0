Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E0FC83F12
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Aug 2023 10:03:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55E3010E273;
	Mon, 28 Aug 2023 10:03:03 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::616])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A71910E273
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Aug 2023 10:03:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ftaDZgKouMMvu3RshFTa2Q4Fqlh2mlvC2Q+uRh+RkgjMbXVVITFn1o0zFWVFULpjnkvGT9Ix7nh6ULJ8kFZV9UV9koBTZXuJIHLyC23dnSRcJkMomoRYTKbmF+/pMIyeVzUQvuMoeL4ykiFcMsT8YvoSbfVGOVG/BsJOGFJHZMpmLMpT3CQH7v4XLHU2e7wQPaLDccs83fMSu/lJ1PTAigbueryNRe3S8N2JvqRCtrM8zu6VfzgVvTLx1+y2xWcyZU42cc2TsE1+05OVulMYlxOQbTKWlBWp2LSbLIN0WgvNn14P/zoSBh5SbYiufwXPCR/P4L30Qys7Ki4ad7p4ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJ4e+ZztJyzmMZpsbL6igjr1Epmj9fjoa7PF/54X9eM=;
 b=astQC5vhlL0fVl7j4xQf9AvWxCypCepiOBwsclGO0ga8Q5olbqUVy6TEDNXCa/U1JhCYqfXzpCSHQMsvNLtYNg+ajy80kapPMZ44Ym7hlIA4GsBfwdSbAfXK2Tp/ukEVsFvitcq4DyirGr1yESFH5GDLa80DQ4vF3Pt/B1NisLeZtJ1qySDwWAyYcZ+QxUfkszBUVTfLSRF/e1dd3VQ+rh4iMc5qwiJQPrgwBmp3HlIweIbw0C0rAj99kf61IoOcwbz2j+ZH1qBLcfAVpaUU/5ju4aM9faYH8+RUD558mzOhXUMwUAYoCB6WtVmcyBFYj/C8rJHKZKXmsxKvbgk9yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJ4e+ZztJyzmMZpsbL6igjr1Epmj9fjoa7PF/54X9eM=;
 b=5AICakzUvYcxzY6fOWNFsAzgKKN1j+r3gcjVW+Yx2Y0IS6STau69yUAtNgphANtwKA7ReSHCqh7b82rvCWHu7NQV+vCpPGPLxUXB+8J44VbUn4ZHaL+yRfIETb/3kbdigruTImzr5rfBbwERDVTrDrH+FrCt6hkYd63EpAOHvkw=
Received: from CY8PR12CA0052.namprd12.prod.outlook.com (2603:10b6:930:4c::27)
 by CH3PR12MB8404.namprd12.prod.outlook.com (2603:10b6:610:12d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 10:02:59 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:4c:cafe::89) by CY8PR12CA0052.outlook.office365.com
 (2603:10b6:930:4c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34 via Frontend
 Transport; Mon, 28 Aug 2023 10:02:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Mon, 28 Aug 2023 10:02:59 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 28 Aug
 2023 05:02:56 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <Alexander.Deucher@amd.com>
Subject: [PATCH v2] drm/amd: Simplify the bo size check funciton
Date: Mon, 28 Aug 2023 18:02:18 +0800
Message-ID: <20230828100218.1629093-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|CH3PR12MB8404:EE_
X-MS-Office365-Filtering-Correlation-Id: 92f20a66-7586-4dfb-111f-08dba7adf58e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LXRTmvhbXs2L+LpijIvqka5ESnySvFkZu7ATZzD4CO4N1M6C422j1JOApeitSwO5cIkBaCmHJoLVQBkLye1dMAHL2uyFyu4UCX0yI2qzga5M+XNiN5NNqxnbo4mtR4U5Qi3pq0tx3eyF+m6phgdIFiUmwExPvkqHnpRKX7KQMT/kwz2rY8xW7uDsXzg76lTKoZqn4u2OEoYNd8tZdp5muD186L18dLPOtOH22MVzV7H4eVddKuonrM/+830ktCpjrdY1SgLhgGhxrL5ryeJ6x67wOmKegYahZ/MY2bLR6R3tlb+GOcobgk016mS1sznobmLnw35Bo4KGyd4cCb2avf0KtpY9RPLvRWe4NL6985nZQREZJcaUHgV1IO2PSEetOvNdpCcT1pfgaRxQkyI+v7giLSwXB/9XWD1bmDZHWtWpWJoPc/ui48ZJMApg8SUrOxquQvKFOx5ZxBIlxRUpzM4u2CyoiuAbRJPK19ixgqS7ACw2Dr5v2QabXlq8QfcyoYUhJlFeSw39oRtZLJez4dKlPB+tie/TjUdsL6x09VGCDqqnZcR1ta9ZqvLatWmVgFLPqzc1GKOZlrFVbMl1/QP5FYi6XP8Ui+1ijbXHOaHiAQVvERxANCMhNMqO6pznJnAukB99Fko3+Y29CrqGmYssWKgW6VD+JuqHWBQodP8XYkdiCF+5PXQLzyI4eqB7YRzH9vRWwre207XgrAD8JOCGOwmzCZZBhhbCdcyuLUXIxAEfeyE5geQOx8afFL8rQp022owFMJfD978cVSN/Lw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199024)(1800799009)(82310400011)(186009)(40470700004)(46966006)(36840700001)(83380400001)(356005)(478600001)(81166007)(82740400003)(16526019)(336012)(426003)(36860700001)(47076005)(26005)(1076003)(2616005)(40480700001)(7696005)(6666004)(5660300002)(86362001)(2906002)(54906003)(8936002)(316002)(6636002)(70586007)(8676002)(41300700001)(4326008)(36756003)(110136005)(70206006)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 10:02:59.3028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f20a66-7586-4dfb-111f-08dba7adf58e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8404
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
Cc: Ma Jun <Jun.Ma2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Simplify the code logic of size check function amdgpu_bo_validate_size

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 29 +++++++++-------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 807ea74ece25..e603ca062fcc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -480,7 +480,7 @@ void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,
 		*cpu_addr = NULL;
 }
 
-/* Validate bo size is bit bigger then the request domain */
+/* Validate bo size is bit bigger than the request domain */
 static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
 					  unsigned long size, u32 domain)
 {
@@ -490,29 +490,24 @@ static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
 	 * If GTT is part of requested domains the check must succeed to
 	 * allow fall back to GTT.
 	 */
-	if (domain & AMDGPU_GEM_DOMAIN_GTT) {
+	if (domain & AMDGPU_GEM_DOMAIN_GTT)
 		man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
-
-		if (man && size < man->size)
-			return true;
-		else if (!man)
-			WARN_ON_ONCE("GTT domain requested but GTT mem manager uninitialized");
-		goto fail;
-	} else if (domain & AMDGPU_GEM_DOMAIN_VRAM) {
+	else if (domain & AMDGPU_GEM_DOMAIN_VRAM)
 		man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
+	else
+		return true;
 
-		if (man && size < man->size)
-			return true;
-		goto fail;
+	if (!man) {
+		if (domain & AMDGPU_GEM_DOMAIN_GTT)
+			WARN_ON_ONCE("GTT domain requested but GTT mem manager uninitialized");
+		return false;
 	}
 
 	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU, _DOMAIN_DOORBELL */
-	return true;
+	if (size < man->size)
+		return true;
 
-fail:
-	if (man)
-		DRM_DEBUG("BO size %lu > total memory in domain: %llu\n", size,
-			  man->size);
+	DRM_DEBUG("BO size %lu > total memory in domain: %llu\n", size, man->size);
 	return false;
 }
 
-- 
2.34.1

