Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D54FDC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 05:35:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55F1610E1EB;
	Fri, 14 Jan 2022 05:35:03 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3B5710E1EB
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 05:35:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XxV+sUbgS8uLva92/1+pOBEUt0mArzwRtmzf0yL9N5Kpyq7AfaK7JnRsbXVYU+InE3cieVMVv2NmpLPbVOKulYVL2CMXEyfMi3wMlmW+nqufZs8eZxtrBgFvLl1DKdkiGY0pdUoPy6wXLJuhHFOK2mAlepOZSyEOLmde9wbnulvCyryHy38OQYaFrUyjgSh+VaBtQX0H2FzguVj/dsQ7FNDo/w8lCvL/N4nAqUBc53mkhYmurdc1foU3GkyL1AbyqkPPv4iQeHCluDUcM0GYSNCmzuiMxHK4gIgJI/FDhW6smI0oGtkK7lRJ6CVxmpBWFFQRgVLBiMo6RqtzmtodDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8Ww0VLM1Gew0HfwIaIlXIdz9M1vALhCwacHv6OxrFU=;
 b=cmh2qJzG31UHOVkBJmqFsv6nSQGwtnI3TWyCA9O0wHjyq2JUzhmOOZkYKd+EhPuBstYHvrSKmmpxKMDN4PcDWg/luPMsQbBEs59kP3CptU9cyEPNphGdDg9T5kXSiiBVxzPBFITBiQMrWEE1lj2ZTr/lz/1JrYIuMU7tXbEK+BS9BqJOoN8V60bD8eVqp58NpctLXd4P4WACP2inC9XJNxUIomcMdF6igoJBuMLIhYBGTbqaoz0t2AxXvl0gu3fwNc3gwn4YKdO2ZTJVKCsD9P1ZVKxM+s8FEne31MZHynBTg8daeMZFjkKYYCyXGYd0tFosZ2n8bnA1BPDx+6uYjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8Ww0VLM1Gew0HfwIaIlXIdz9M1vALhCwacHv6OxrFU=;
 b=xBF8Ya7+vfwxgYI4x31RrRoL8RQTI+B3zo7XdFfRaWHTpwuKcV+p03Vjg3bBTxL72Y9TFgjMHSzz3HmT0YmkIuAzKcinQTArc6WRCWNPh5ZngyzABQzpo1oTdODJXs9/sLQKwsdpzB5S/nSp9uyYqWySa+/sMJbAfr7VkBOW82E=
Received: from DM5PR1101CA0021.namprd11.prod.outlook.com (2603:10b6:4:4c::31)
 by BY5PR12MB3667.namprd12.prod.outlook.com (2603:10b6:a03:1a2::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 05:34:59 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4c:cafe::10) by DM5PR1101CA0021.outlook.office365.com
 (2603:10b6:4:4c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Fri, 14 Jan 2022 05:34:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Fri, 14 Jan 2022 05:34:57 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 23:34:55 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 4/5] drm/amdgpu: Fix the code style warnings in sdma
Date: Fri, 14 Jan 2022 13:34:06 +0800
Message-ID: <20220114053407.4035049-4-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220114053407.4035049-1-YiPeng.Chai@amd.com>
References: <20220114053407.4035049-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4b8d1b9-d668-4140-090a-08d9d71f9a2d
X-MS-TrafficTypeDiagnostic: BY5PR12MB3667:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3667240ED844305CC6C0AEA4FC549@BY5PR12MB3667.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FHRYlxv1DQgPtoX/oPQvndXR2S77anMGEoDiFB/93iZFdU3l0dr4laUxnDQpeflOAX1mJYUHfOLrWVNa+jz7gzdObfqij9OcB95YFkGIweb1d/o8LTujJ9zoAiJn9oP5thBXrj9hkF64XgT1P2yCwWpdrxlPpmcS1w1bXWNjxNicUKKDz08otjHbmI0U1gGDz1Li60cFNbuKdAWkuCBxHIzjUPVLVejEFfRoVdu6OiVSNnHS8qVsOhjtyL754hBbNRX88qUOxwhjgTx5i5mkZR9UjXLtEoltO+lMNsmsSr3TvGs25XfIrwYVYjn0coWJBLOQTpy2tFLqeTgXe+wNeITDOjxJlk7ROr0MWvvnzkdNPy69S4UtTmO45S89dBZFny3DQGoCW6U6UsVHEIWU2ncW+p3iy1HLZ0wBsGxJ90eUZECGjS7+3SDiDgvCh2m/vTW7w9wEBGPKxASOoiQgppScwMbRZ2zLkgW5+6XnngJu54DHFA3IhXRHZXlz6c+5iliF+TrosYTWHYcFp+LNhvRNaumC3yDjWrgkcbES+AFtlziancpQmWrRrkJlm239LErOc3ba6b7O2qjBLR6Lugglag8bUJPCt5k+XNKZC2NQEzwzSkW9E3LzPbVQBg82XtI0pv5zxR1zioHMXrcamXTcboZZw/BNtFTwlzTFLid/rGaM94Sgd7F4PUc68QHom4k6lE7EFLap7C7yQgidPEjJjXE7MHza3d044KBWFS1/uTexHdIOBZOyB96PTmUgumVgiDev+ACO+m8qp3GcYo1wZufhjhGC79vCnE9oSHNDfKvZT3GPRNV7leS987Wt
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(54906003)(7696005)(36756003)(316002)(2906002)(6916009)(8936002)(8676002)(70586007)(70206006)(1076003)(26005)(6666004)(508600001)(81166007)(336012)(36860700001)(86362001)(82310400004)(47076005)(83380400001)(356005)(2616005)(40460700001)(16526019)(4326008)(426003)(186003)(5660300002)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 05:34:57.9455 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4b8d1b9-d668-4140-090a-08d9d71f9a2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3667
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the code style warnings in sdma:
1. WARNING: Missing a blank line after declarations.
2. ERROR: that open brace { should be on the previous line.
3. WARNING: unnecessary whitespace before a quoted newline.
4. ERROR: space required after that ',' (ctx:VxV).

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 3c1483dc113e..06a7ceda4c87 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2766,10 +2766,10 @@ static int sdma_v4_0_query_ras_error_count_by_instance(struct amdgpu_device *ade
 static void sdma_v4_0_query_ras_error_count(struct amdgpu_device *adev,  void *ras_error_status)
 {
 	int i = 0;
+
 	for (i = 0; i < adev->sdma.num_instances; i++) {
-		if (sdma_v4_0_query_ras_error_count_by_instance(adev, i, ras_error_status))
-		{
-			dev_err(adev->dev, "Query ras error count failed in SDMA%d \n", i);
+		if (sdma_v4_0_query_ras_error_count_by_instance(adev, i, ras_error_status)) {
+			dev_err(adev->dev, "Query ras error count failed in SDMA%d\n", i);
 			return;
 		}
 	}
@@ -2814,7 +2814,7 @@ static void sdma_v4_0_set_ras_funcs(struct amdgpu_device *adev)
 	if (adev->sdma.ras) {
 		amdgpu_ras_register_ras_block(adev, &adev->sdma.ras->ras_block);
 
-		strcpy(adev->sdma.ras->ras_block.name,"sdma");
+		strcpy(adev->sdma.ras->ras_block.name, "sdma");
 		adev->sdma.ras->ras_block.block = AMDGPU_RAS_BLOCK__SDMA;
 
 		/* If don't define special ras_late_init function, use default ras_late_init */
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c
index 5c1ba1116e5c..6f9895cdddb1 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c
@@ -248,10 +248,10 @@ static void sdma_v4_4_reset_ras_error_count(struct amdgpu_device *adev)
 static void sdma_v4_4_query_ras_error_count(struct amdgpu_device *adev,  void *ras_error_status)
 {
 	int i = 0;
+
 	for (i = 0; i < adev->sdma.num_instances; i++) {
-		if (sdma_v4_4_query_ras_error_count_by_instance(adev, i, ras_error_status))
-		{
-			dev_err(adev->dev, "Query ras error count failed in SDMA%d \n", i);
+		if (sdma_v4_4_query_ras_error_count_by_instance(adev, i, ras_error_status)) {
+			dev_err(adev->dev, "Query ras error count failed in SDMA%d\n", i);
 			return;
 		}
 	}
-- 
2.25.1

