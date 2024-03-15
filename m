Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 831FEC54E58
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Mar 2024 09:16:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0698C112061;
	Fri, 15 Mar 2024 09:16:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EY3XnwzQ";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEE90112061
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Mar 2024 09:16:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y41oqMelxGPnHc7YpTeE5Qca6wQnNbcn4Wx0ZBD56TcZqYZ55VzRpviV7dCi/35/VNDt5Zi802IIX6q7LaG0fSdzZUQ23bH3DmsHCwF52jPVbDYAGxlOGPSJ0J2ZKUSES6RLnOrM1ThQiDPWdVEfb41APYnvbQpl+/Ic0o8JI472lEtw4PuTFeTAK9eakV66qvtl1Zj2M1Re5w1G2k0Tm7ah7pspMiyB5zAsDawlBV9uNz8dLdG6PyCLWSI5+za1dRv4EBusz/RAt/+fIFLUsYCYPKOcRQrhBz4LOu4zpEvYerNtZc3K2uVenFYSYI+Qul/MocrpSWXWpgvo5a9ucQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqmKn7EWiNRIqDDMFrN0+3FAJ7Sw+a5VXywK8h5ja6M=;
 b=Hqo1jiKypzqtP/drhthT8HCfr0Wl8IoD9XEoCeC743qai2oiM+GTa94XELRRfFMzh1wocGzDv8Nw+sHIGH7NVnJ6Fx2v6WepAYygMx4U9P4lJ6ntZFOqAO9tzmT7ywXX4PsiFi1hPgGl4yOV7N0yBCRMDYhwyJ1P1/jNRLwKmAiTy3IshIVsk3q/UNUpB+HPQFNgbooXLUqtjnWI59uFUs6JCNq0DowkawWJasa26/hhzQ4Njzgpuoo2IIkspenqWwkCqpxRpR6drrIJFgb3eqrrUmcKmK2NnVWTtChAGdu0Ks1T1nFdxHLe++Jkcv0QdE9a3wlpGx6eREZWdYX3Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqmKn7EWiNRIqDDMFrN0+3FAJ7Sw+a5VXywK8h5ja6M=;
 b=EY3XnwzQHNbkUb8msB2DFv3ZxTYm7R/3hegzcVqoVpq0ucWoHDWgp9XZZbO2ETXOnNCEEv8d5tNJp1ryOtM8rwSZFT0gw2LAmhhzUqsimdxHy2EUWMA+87g9ZxMCmcwvY/A5ewdoq/IdcO4dNanS/0iww580rpEcTBc8KvCsbzs=
Received: from CH2PR15CA0011.namprd15.prod.outlook.com (2603:10b6:610:51::21)
 by DS7PR12MB6285.namprd12.prod.outlook.com (2603:10b6:8:96::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.36; Fri, 15 Mar 2024 09:16:26 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::78) by CH2PR15CA0011.outlook.office365.com
 (2603:10b6:610:51::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20 via Frontend
 Transport; Fri, 15 Mar 2024 09:16:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Fri, 15 Mar 2024 09:16:25 +0000
Received: from lm-srdc-pc1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 15 Mar
 2024 04:16:23 -0500
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <Asher.Song@amd.com>,
 <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>
Subject: [PATCH 1/1] drm/amdgpu: drop setting buffer funcs in sdma442
Date: Fri, 15 Mar 2024 17:16:07 +0800
Message-ID: <20240315091607.1070927-1-le.ma@amd.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|DS7PR12MB6285:EE_
X-MS-Office365-Filtering-Correlation-Id: 79e72bd6-95dc-4a5c-dda8-08dc44d0971c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kjA3xRLJtkp8ow9ywtDj0IvMdAUB7MfItFqM+Cn1GvVBID7rM+qJ/xmXxDbfuxPi2edID722hkP2h5gDaTzKSRCSyyuNIUYYkJVKPLi8L246/8D1+WkPhxYWsm3kOvSLaOHhf+rOmvMWBiOuBBpdVBXPoPdsHz+fj+GcFbPLid1VxrNdx42EapaquK1sK4LUs+I925EwsHW3iEtiAxPQko6SXK//DbOjDVdDwA0srzqgeO6Ex0/SXsv4S0G6RXD6e8iPAPeLbbuDQ4zilwdTf+8h4VLgKKTtXFxVhLvSup5JpL3kApoZ1yl7dYzCkM2asGGSrx/lKhUZFFccenR2KjY3k6zFQMlxO2HRfZXC0uZOT8F2AhgtRo9+bmePM7MhnVYfpFGymwdug+Kbaw18iVsBhUWBoo9hSsXOtuziBbiQTaOCWzXuop6InRhgw94iCWE+6ZUBf3eK17pVFRM+yNtjpehrAiHJfJP8jX7F9lk4IMsrnO9O/gS/QBMr4XTNLqY6wsT94vxYMlzYI4N6RurUpk/qMyVqZLWBpRfBjyhddZI44CBgDDe6do7/ACiosnvDxnZCSW8eEQARnm5mX8ydgGQ5Q3n8qI0G+toW8YzJSTs8/I9sbyS1jFKASV9Ueawn22CTlKNDCYCazDkrBnM59Q3fsjvmbpfdpZbC3R+vV6kvfkFSdlEhe1JtEq4UGYyG1ZnzyySH8668wsrWp0TibVvEPzH6aTeWF37UG+Kz+UfIX1UKUzqioLlOUkp4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 09:16:25.8280 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e72bd6-95dc-4a5c-dda8-08dc44d0971c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6285
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

To fix the entity rq NULL issue. This setting has been moved to upper level.

Fixes b70438004a14 ("drm/amdgpu: move buffer funcs setting up a level")

Signed-off-by: Le Ma <le.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index eaa4f5f49949..589a734982a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -431,16 +431,11 @@ static void sdma_v4_4_2_inst_gfx_stop(struct amdgpu_device *adev,
 	struct amdgpu_ring *sdma[AMDGPU_MAX_SDMA_INSTANCES];
 	u32 doorbell_offset, doorbell;
 	u32 rb_cntl, ib_cntl;
-	int i, unset = 0;
+	int i;
 
 	for_each_inst(i, inst_mask) {
 		sdma[i] = &adev->sdma.instance[i].ring;
 
-		if ((adev->mman.buffer_funcs_ring == sdma[i]) && unset != 1) {
-			amdgpu_ttm_set_buffer_funcs_status(adev, false);
-			unset = 1;
-		}
-
 		rb_cntl = RREG32_SDMA(i, regSDMA_GFX_RB_CNTL);
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA_GFX_RB_CNTL, RB_ENABLE, 0);
 		WREG32_SDMA(i, regSDMA_GFX_RB_CNTL, rb_cntl);
@@ -490,17 +485,10 @@ static void sdma_v4_4_2_inst_page_stop(struct amdgpu_device *adev,
 	struct amdgpu_ring *sdma[AMDGPU_MAX_SDMA_INSTANCES];
 	u32 rb_cntl, ib_cntl;
 	int i;
-	bool unset = false;
 
 	for_each_inst(i, inst_mask) {
 		sdma[i] = &adev->sdma.instance[i].page;
 
-		if ((adev->mman.buffer_funcs_ring == sdma[i]) &&
-			(!unset)) {
-			amdgpu_ttm_set_buffer_funcs_status(adev, false);
-			unset = true;
-		}
-
 		rb_cntl = RREG32_SDMA(i, regSDMA_PAGE_RB_CNTL);
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA_PAGE_RB_CNTL,
 					RB_ENABLE, 0);
@@ -950,13 +938,7 @@ static int sdma_v4_4_2_inst_start(struct amdgpu_device *adev,
 			r = amdgpu_ring_test_helper(page);
 			if (r)
 				return r;
-
-			if (adev->mman.buffer_funcs_ring == page)
-				amdgpu_ttm_set_buffer_funcs_status(adev, true);
 		}
-
-		if (adev->mman.buffer_funcs_ring == ring)
-			amdgpu_ttm_set_buffer_funcs_status(adev, true);
 	}
 
 	return r;
-- 
2.43.2

