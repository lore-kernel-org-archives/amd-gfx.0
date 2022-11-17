Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A293DC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Nov 2022 06:09:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0082610E53A;
	Thu, 17 Nov 2022 06:09:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A80B10E539
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Nov 2022 06:09:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVW8wJgaydZtV5MAM7/9Lmejsd+RfD3/MiaVOhx6s4tPs7lg78rydz2dVh/NgFYBAn0EQjwAKiu2Koqhl7w1ndudHTvNfrigM2ZXMdGwnHD8myeyLyDnz6bSqWhL2FQ7C16jynutzMMPBnevQUdAVuvm9Eg8mVWLtS6xrDgOXIEp4IJMMKTXba7HwGs3H0FhEUz/4CvG3W89DimgM6pUWXCOAM3nsBChxn4HSW8xyh+kaarfuF8QYid1DJqnxvP5exwH6qe9pP8E8tOc7BA9jvUTDE8h+ckNHUl3jMoEMEl3N8YGbpIT4kaSGiUWo6U12elJ7rIjVH2D6gvVl80jzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FfbfT/OQBTZa+7XDOZ6IvrIg09xyleY5ZUIHuTG+RY=;
 b=KMbcLr5WVFJ5cpxy2WPKmbvkJyJImw3+OGW4gJzo5Aewz7kTIlX5WqnFE9dNaNyXSmg4Lfgvls56VB0QDipBcu54vQzfnrxwSE9gNa/a8SxnWDpNeJMs1pFU9vJk3ysIaOKfJOlJucYKhgjDB3zWkF2vXeYIk1qpgoCcss5Ws4+OrWXXWSaB6taKxyVGvJfN+Ovc4stKszYkC+EvUkLiJm+EKv6ijkQV9/euCGu0IxMQgwDtPAVmualXhJFoYs0l+9w1ptktkwL97ofWsdkhnrSqQna49qH/sjrByQX1jB+TV6d6oVUEW/D19HZCITuJMiwQRBVTc8DyuzVM5mtyZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FfbfT/OQBTZa+7XDOZ6IvrIg09xyleY5ZUIHuTG+RY=;
 b=mjF5pzkhIVTKkIYZcZ+r16x8FG0hbVKpvsKH43htv/Io1EXW1nqkpOI36tOTY0tSTDhNgH/vOc1hmg/x5hHsW0LmbuuRNk4oJ4ygZb5Fxxp4NEB/hUtxDxSEXt6x6W8PobaysadvSzbPyFXhE5Lt3NuekCCs3vI0E+JX6eH1p9I=
Received: from DM6PR10CA0015.namprd10.prod.outlook.com (2603:10b6:5:60::28) by
 BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Thu, 17 Nov
 2022 06:09:33 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::81) by DM6PR10CA0015.outlook.office365.com
 (2603:10b6:5:60::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20 via Frontend
 Transport; Thu, 17 Nov 2022 06:09:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 17 Nov 2022 06:09:32 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 17 Nov
 2022 00:08:46 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <Alexander.Deucher@amd.com>, <Lijo.Lazar@amd.com>
Subject: [PATCH 3/8] drm/amdgpu: define common jpeg_set_ras_funcs
Date: Thu, 17 Nov 2022 14:07:50 +0800
Message-ID: <20221117060755.13655-3-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221117060755.13655-1-tao.zhou1@amd.com>
References: <20221117060755.13655-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT017:EE_|BN9PR12MB5129:EE_
X-MS-Office365-Filtering-Correlation-Id: da8e0fa9-50bc-4d96-f8a8-08dac8624bcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rfwbmMBaaZxAEPm2eywoTDFoJGE2IHS49DfKsjB2VRex5P8bUKGRzaTXrN/0KGufCMCwaXIuq9DUkxb1f9v0RCS2n5wJmNPIjBoaOQtZAMCk2OfkiUfzM0M5rREgHJ6eb41tIR3DmOxD3hHGCES/fBsorV4oZ/XUMSSv6juef0hFFernvYw8CiDkPd2T7cczjxcmflSufcpJCve2WHWiLdoJzE3ylL3l9AAV3foWzdFZFqhWw/anBrEygNo5nGpyzFgzezA2z4ZMfo6O575YGN2LjBuJWSslOBamb5m+5L4cTGNYFbaVVPzTgbv9IMgZqahPKuepTzUTytAlG8aC5sP5vOp08FLNNaVxs/4W9T/D0s6jRvbjtcw93KMDHAu0Sb8J2HmLXNsu5C8/TMVw68MRAm8SyCX+pNzbfOX3wynnZ4i175RkR//j0PwR3oM5y2gy7EYyeyUxbWeuxcvbrX0l/xmqij2wEPrYBFHvXb4hlQ+md6tZfgZS6XLxQTavZhEBOROzMLDtXPSkuMxhKd1KqX6z2gYsY+0KArkMenqYfsXG6SzJ4bzY9ulBvf+RTX0ULfYvoOG9gYQxYK9GuyLnq9FeNTyAhJSdbr5k0iTIJ7urqESxaWNMh4nFeK6Nqa3JgppbB/E6OBwdJ6o2paXABvKGC32Acu6JbnJNS6+qpD/RA6FavaPZKHMTPGK0xbcvxqGK9XlRbvAqhKt7m0pHHjnVoD23+rbqTmpNx4g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199015)(40470700004)(46966006)(36840700001)(426003)(81166007)(36756003)(54906003)(6666004)(110136005)(40480700001)(356005)(26005)(83380400001)(2906002)(47076005)(41300700001)(336012)(82740400003)(478600001)(86362001)(8936002)(2616005)(316002)(1076003)(7696005)(36860700001)(4326008)(70586007)(82310400005)(6636002)(70206006)(5660300002)(40460700003)(186003)(16526019)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 06:09:32.8767 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da8e0fa9-50bc-4d96-f8a8-08dac8624bcd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5129
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
Cc: Tao Zhou <tao.zhou1@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Make the code reusable.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 17 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h |  1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   | 13 +------------
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 518eb0e40d32..8f472517d181 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -234,3 +234,20 @@ int amdgpu_jpeg_process_poison_irq(struct amdgpu_device *adev,
 
 	return 0;
 }
+
+void jpeg_set_ras_funcs(struct amdgpu_device *adev)
+{
+	if (!adev->jpeg.ras)
+		return;
+
+	amdgpu_ras_register_ras_block(adev, &adev->jpeg.ras->ras_block);
+
+	strcpy(adev->jpeg.ras->ras_block.ras_comm.name, "jpeg");
+	adev->jpeg.ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__JPEG;
+	adev->jpeg.ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__POISON;
+	adev->jpeg.ras_if = &adev->jpeg.ras->ras_block.ras_comm;
+
+	/* If don't define special ras_late_init function, use default ras_late_init */
+	if (!adev->jpeg.ras->ras_block.ras_late_init)
+		adev->jpeg.ras->ras_block.ras_late_init = amdgpu_ras_block_late_init;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
index 635dca59a70a..e8ca3e32ad52 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
@@ -72,5 +72,6 @@ int amdgpu_jpeg_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout);
 int amdgpu_jpeg_process_poison_irq(struct amdgpu_device *adev,
 				struct amdgpu_irq_src *source,
 				struct amdgpu_iv_entry *entry);
+void jpeg_set_ras_funcs(struct amdgpu_device *adev);
 
 #endif /*__AMDGPU_JPEG_H__*/
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index f87d0f6ffc93..f2b743a93915 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -807,16 +807,5 @@ static void jpeg_v2_5_set_ras_funcs(struct amdgpu_device *adev)
 		break;
 	}
 
-	if (adev->jpeg.ras) {
-		amdgpu_ras_register_ras_block(adev, &adev->jpeg.ras->ras_block);
-
-		strcpy(adev->jpeg.ras->ras_block.ras_comm.name, "jpeg");
-		adev->jpeg.ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__JPEG;
-		adev->jpeg.ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__POISON;
-		adev->jpeg.ras_if = &adev->jpeg.ras->ras_block.ras_comm;
-
-		/* If don't define special ras_late_init function, use default ras_late_init */
-		if (!adev->jpeg.ras->ras_block.ras_late_init)
-			adev->jpeg.ras->ras_block.ras_late_init = amdgpu_ras_block_late_init;
-	}
+	jpeg_set_ras_funcs(adev);
 }
-- 
2.35.1

