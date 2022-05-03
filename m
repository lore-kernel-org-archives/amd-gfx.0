Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E88C4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:09:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 843F010EA41;
	Tue,  3 May 2022 20:09:27 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2057.outbound.protection.outlook.com [40.107.212.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABE0B10EA3A
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:09:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGLJGTnZQy9BmGyVQo6xHmdSGJyKyUOo8IJSjsETAZKFKX5B44KUEcm62PoNnbHNKWmLeXAHx8BhL5LvsX2SCAaqnoDZkzIp8+cwsPwE1Agqk5DO5Dse82NO2c6g73hokmQkpafjuBJGb7ZYmFowlEVLwRWb/MRUkA/+lkjnIAa92mYg8PLwrvG4EvhF/CkD2BnRFB72nl76QbTsdMJhmXogwjOokkyT7fVSbA2ulPxrtINNlIlqMORrgt66NmnD9N0r/3APZk1gakrQdMExXRJnXqc8G6+zvh/rGUxKyJ/z1bp1NeS/54izZh06BoSN50JKJ6hpmsQsp8Pgsm77jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3McwjSQeMU6PZ8Vl0x89B61vkROCNM5en+rt8vlyOE4=;
 b=NsTkRF3AXYpKdy6Quch8amBCSGX2UaCmG1mmFHNJRGJUcoQrjwtdkDKtsCBjGNt7/6/W+oV/HvLIiNuHxbxsHlTmgT+1v62Sr9gU8W0nltPDS7rQjIirLb9abbaXGPuS6aQnj6I8NiLLLSEv4ZWmGMhKCLOZVFnfJuFDoOskbVuPtcApw82WuQhNj6DiX9yv5ZhyOmC4Ql9/Tpj1uM5Y9V8U97x4mb4ocr5YwboWYVk6NvSs6F4aoNyk1CMjqPUpYYurLR977hDOCrmLdmalrKzVJ2ALmmX8yKWPcpsJ1UEGaYRyspDaJN/pMT06iuHHsiQw665qxayJ+0Q8QYFI2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3McwjSQeMU6PZ8Vl0x89B61vkROCNM5en+rt8vlyOE4=;
 b=eCsDidHlA9GFQIbduM/6LwH4LYTsdR4FJgOgu4yz3i7M/rZOt3tlmIWHyrGJwsYXXyjKIwFYZIdKQi01kJBsmu9Cv1/s9MPGiImRGQmyYSskNjjxkMJmtEjzvonsEnBlQFbpMQNqC400dMoSkhurMneXetpSLckPUAsORSg+Eu4=
Received: from DM6PR07CA0052.namprd07.prod.outlook.com (2603:10b6:5:74::29) by
 MW2PR12MB2396.namprd12.prod.outlook.com (2603:10b6:907:9::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.15; Tue, 3 May 2022 20:09:18 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::b) by DM6PR07CA0052.outlook.office365.com
 (2603:10b6:5:74::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Tue, 3 May 2022 20:09:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:09:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:09:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: enable MGCG and LS for ATHUB 3.0
Date: Tue, 3 May 2022 16:08:43 -0400
Message-ID: <20220503200855.1163186-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503200855.1163186-1-alexander.deucher@amd.com>
References: <20220503200855.1163186-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca0abf6f-4108-49fc-1ff3-08da2d40cd97
X-MS-TrafficTypeDiagnostic: MW2PR12MB2396:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB239626D1D2B285F820A227C2F7C09@MW2PR12MB2396.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PTs5AF4+aXcJmqW19jq/Fciw6kyn685bhHk1X/ViRPWF+OMjz8qvT9Gy6ns63R7lg/ixU0GuPAfi7m7cXuTGXB0ByMgieJ3nmjY4sMS0RmybhTDou4sd3esPk91sqL0DmhI5ZEgQxbJin+DqTscjz/YaXq0uBTFTGMf91Afz7QKvsBHroajmjijTD/Hs0rp+a1Vrz1cRZ/DSO3sZcUi1LWkB1xuSuOo7pCnH1rG4JmYIOflASYRa9SUgqCsLM45usXlN/3xAYEkWgob2jLYDX0BAaD/uSZC/gYKih0S24SAypvjCbYVsTPmZT/vDAfpjSUgQY4J10dXSf4ryYsWWEBDt9prUClUlcFEiZPLwYeOaw5ZS/VCuytpTHJaLjzoLpFdjB87/D8k7JEVIdWMuvMY46rNJuqd+QcM0PwLvIrF0RS/B/m6FpcFS4KqxSgK93F8wcm4hVbslzt0dSXIrFim+IBECoxsp7g0BENJisW7613ffgp8Hst6T5RKNRZc0u6aUNkeAphBWmE7FgxBEAdm6rK9H6Egy4tsjkrcNyV50MGBv8VuXrUz97pG8lUaflIMC0PY5hWapRcwdRE8ABUouQ8PLIMEE9M1NznQQsrn7aneGusp8MJ2hRsznrNtTeycs2p6QYgbd4GhgslOTYo/X1EvYI1Wp5w7c3Ai8eG3ZfdQo4rdis3vAjy+kIXfdJZeOrtAI3DthRZlHvjkQdw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(508600001)(8676002)(316002)(2906002)(4326008)(7696005)(70206006)(70586007)(40460700003)(83380400001)(1076003)(6666004)(5660300002)(16526019)(186003)(8936002)(26005)(2616005)(36756003)(47076005)(86362001)(336012)(426003)(356005)(36860700001)(54906003)(81166007)(82310400005)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:09:17.5643 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca0abf6f-4108-49fc-1ff3-08da2d40cd97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2396
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

Enable ATHUB 3.0 MGCG and LS features.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/athub_v3_0.c | 5 ++---
 drivers/gpu/drm/amd/amdgpu/soc21.c      | 4 +++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/athub_v3_0.c
index 20ff228a8b4a..eda07cfe92bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/athub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/athub_v3_0.c
@@ -36,7 +36,7 @@ athub_v3_0_update_medium_grain_clock_gating(struct amdgpu_device *adev,
 
 	def = data = RREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL);
 
-	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_MC_MGCG))
+	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_ATHUB_MGCG))
 		data |= ATHUB_MISC_CNTL__CG_ENABLE_MASK;
 	else
 		data &= ~ATHUB_MISC_CNTL__CG_ENABLE_MASK;
@@ -53,8 +53,7 @@ athub_v3_0_update_medium_grain_light_sleep(struct amdgpu_device *adev,
 
 	def = data = RREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL);
 
-	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_MC_LS) &&
-	    (adev->cg_flags & AMD_CG_SUPPORT_HDP_LS))
+	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_ATHUB_LS))
 		data |= ATHUB_MISC_CNTL__CG_MEM_LS_ENABLE_MASK;
 	else
 		data &= ~ATHUB_MISC_CNTL__CG_MEM_LS_ENABLE_MASK;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index c618f2b8ece8..815b9cc8f9ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -533,7 +533,9 @@ static int soc21_common_early_init(void *handle)
 			AMD_CG_SUPPORT_GFX_FGCG |
 			AMD_CG_SUPPORT_GFX_PERF_CLK |
 			AMD_CG_SUPPORT_VCN_MGCG |
-			AMD_CG_SUPPORT_JPEG_MGCG;
+			AMD_CG_SUPPORT_JPEG_MGCG |
+			AMD_CG_SUPPORT_ATHUB_MGCG |
+			AMD_CG_SUPPORT_ATHUB_LS;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_JPEG |
-- 
2.35.1

