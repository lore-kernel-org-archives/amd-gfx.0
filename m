Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39147C54FB9
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Nov 2023 06:26:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9F5710E0BB;
	Tue, 21 Nov 2023 06:26:14 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::61e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2C3610E0BB
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Nov 2023 06:26:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O19g4zQRuAjqcbi7neVONeIJEcWXAZVb+Kr1UpAAcWLfZty4Le6tsA9QnAsPiUKr31Y+AgPjswh7KHIGs+ocASmkXkYOqIQkZAjFj7wH+sntLBJ6kjOd2hm7vkXwebjW7Cx2rT8/rS/G69vmypr7r3csOYJA0v5IGyFqnFy5M66HheNeGoTtX13g/zk5p7unfy1ckdYDeW+7KlZxe6RAP6V2IYXMs2a59BDv0wDywgnOz+sEb441FDOTv9tK3uxXil4aBMnuctXxllCMLuAxK3NhWTxTi6N6C/Y6BxkYJ1vbP02VTVo6Y+39zlQSKKUQmqM0RcamYK3MvALLCVrzMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9qORjSZ/8GGkiJK+wTqopM8ro9CuKBnv9vChR7vca4=;
 b=cc8vjakMV/wvomCXWSuQeuTM80XNFUbyH10RYFIUmnOv3vksYdo5qceeJWjKGnNBqO9jFru9J9ASc09jySLZvAJ8fslAYxAkf3HZFlQ9yubqyntWqAmc0/rqYGc6y/uUWpJ3hcJOfxAEa705AUAbbqmT9+iu4Z4ngnXGxnVmtz6rdSF+QBG+Oj4RYp4uWe2EuGVDT2L8t6E/sTxGcEaBlsbTysSwlYkOIbKQBw8qiEETJ72j00Sy7dIQXrkuv0pgJDr9aMgdPfCHfcptsxXErSCUqZqgYTwGh9mDXieicXCZl2rjSaHI7rLVLYopqRhkUvVXyJLOwX5MkkKcx2rSIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9qORjSZ/8GGkiJK+wTqopM8ro9CuKBnv9vChR7vca4=;
 b=WiBNGyaF7+Kox1zrAGxftL+lmRxmDuv92zLxXsutGFhns/V9mAxuZAzKzoJICntuYvHTB6f70QC8QyhS3tT19Ar6csn3sBfacYr1Sip2ENOfiepz98Exqixxpfaln3zH/jFyV9ewc2BYdmx6bxkOVUGOwhJB8qCRwjoODKFhc90=
Received: from CY5P221CA0107.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:9::34) by
 LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 06:26:09 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:930:9:cafe::2f) by CY5P221CA0107.outlook.office365.com
 (2603:10b6:930:9::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26 via Frontend
 Transport; Tue, 21 Nov 2023 06:26:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Tue, 21 Nov 2023 06:26:08 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 21 Nov
 2023 00:26:05 -0600
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix memory overflow in the IB test
Date: Tue, 21 Nov 2023 14:25:33 +0800
Message-ID: <20231121062533.664725-1-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|LV8PR12MB9207:EE_
X-MS-Office365-Filtering-Correlation-Id: 232bb09f-e4e2-4700-d1fc-08dbea5abfd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cnwW5hvbQZEEIsbKjTvSoXdHNowlTwqIeEdw2cK41DjRwr9giHjNeQcFeyP0aiAJgSXfQXJPk5pmDB2dU9a4fPX+AUK+Z2E20sDhoIrCSedNUT2CmamXpksfMNw9dICGXl1ZDoZuB8JairI+swUeJiy0+2tHsk48mSi9jCpilJIfq/q96yVFPQufkQUBIJ1wvqj2DHugo3YH/eATP9/p8qoDjm5ldmWYFtpgUBZ6Q3yfpBUQM7eFIgez1RWbXULkvI4AvCZmH/LOFwy3moY/QrL7Q+mNCPytJwlhJyCTlwclHB+12AMl4NKDhseU7Km/HED+DKQc7zAgOGx3D84VwNGfh03H3XW3Pm84Va5fXYci+FUrLNYg/Z817/Y4JtcaZ4U2G4g0CW2H8OEHDCd7zqD3vBi5ta9iQaGt+HlskCPJ2DghlyeqPG7vOxhFMC2pp+6QjJdvCF4fAi0lU/lAQvNNq8UmyvZnS9KDlNHqV5FdfQXFCwTK24u6t4SFCo+MsSkuINCxs0+y6XCKh9QN5a40rIA93D33ie1fBTTOtzqv2EIneC/1FPWbdkci1CiWlWfjadnxVzRNts5Rx56f3r9yJxf/1wMh2bxeduo9UmRPIGJ9avTs0nNldynbf5DBh3gXKq8Bb+5vThlZqXB9TbQ8CRZ5EOg3gtG2Pi/6WJLKtT5cExkowuyi0iJ3zZKm6vHTwOqdgUjr6m4y6pqWcktPtsqBv+e/vXTEBOVjD+VSkDi1NvZRf/Rsfjc9dh1WFoD/SBaKeyZVVLLl21K09A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(1800799012)(82310400011)(451199024)(186009)(64100799003)(46966006)(36840700001)(40470700004)(40480700001)(5660300002)(2906002)(8676002)(4326008)(8936002)(41300700001)(70586007)(70206006)(316002)(6916009)(54906003)(40460700003)(47076005)(86362001)(356005)(26005)(1076003)(16526019)(6666004)(7696005)(36756003)(2616005)(336012)(426003)(478600001)(36860700001)(83380400001)(82740400003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 06:26:08.8209 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 232bb09f-e4e2-4700-d1fc-08dbea5abfd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9207
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com,
 Tim Huang <Tim.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix a memory overflow issue in the gfx IB test
for some ASICs. At least 20 bytes are needed for
the IB test packet.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 0c6133cc5e57..f281eecaeeec 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -419,7 +419,7 @@ static int gfx_v11_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
 		cpu_ptr = &adev->wb.wb[index];
 
-		r = amdgpu_ib_get(adev, NULL, 16, AMDGPU_IB_POOL_DIRECT, &ib);
+		r = amdgpu_ib_get(adev, NULL, 20, AMDGPU_IB_POOL_DIRECT, &ib);
 		if (r) {
 			DRM_ERROR("amdgpu: failed to get ib (%ld).\n", r);
 			goto err1;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 885ebd703260..4b0eda46405f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -883,7 +883,7 @@ static int gfx_v8_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	gpu_addr = adev->wb.gpu_addr + (index * 4);
 	adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
 	memset(&ib, 0, sizeof(ib));
-	r = amdgpu_ib_get(adev, NULL, 16,
+	r = amdgpu_ib_get(adev, NULL, 20,
 					AMDGPU_IB_POOL_DIRECT, &ib);
 	if (r)
 		goto err1;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index e3ff6e46f3f7..a55710bf6e01 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1039,7 +1039,7 @@ static int gfx_v9_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	gpu_addr = adev->wb.gpu_addr + (index * 4);
 	adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
 	memset(&ib, 0, sizeof(ib));
-	r = amdgpu_ib_get(adev, NULL, 16,
+	r = amdgpu_ib_get(adev, NULL, 20,
 					AMDGPU_IB_POOL_DIRECT, &ib);
 	if (r)
 		goto err1;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 40d06d32bb74..603988e49cd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -297,7 +297,7 @@ static int gfx_v9_4_3_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	gpu_addr = adev->wb.gpu_addr + (index * 4);
 	adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
 	memset(&ib, 0, sizeof(ib));
-	r = amdgpu_ib_get(adev, NULL, 16,
+	r = amdgpu_ib_get(adev, NULL, 20,
 			  AMDGPU_IB_POOL_DIRECT, &ib);
 	if (r)
 		goto err1;
-- 
2.39.2

