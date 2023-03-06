Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 714CBC61DA4
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Mar 2023 02:33:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0849510E0AA;
	Mon,  6 Mar 2023 02:33:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::620])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 042F610E0B1
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Mar 2023 02:33:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlMrGkmT7VlQHm1luxYoMxfD2nOJHvQItY6zrDowiTK3omI8ay13ZmNb6qy2/GtAJXnfyejtKhuqfhaSpD80lL6oS7XU/TdTOMS6f/++oPgRbmNUepXie46Skgaj08pSryCCgJQI+mnPS8ThLrTPEZV1zIHLQ4qTkSztl6kDIe93naCOCO0cx7n6PtcUxWfTtK/JvVC+L8ZJYirc05kBkbm+pJrArcW3UNcECcs+0JPh+qhxsYZQOCAn7LQXfeVWmDtD3GgoeGTxYcmY/BEZiR/XrKVwHFz9z9Ipzh8HTRNaFJi5e9qNJ3zSzr2b5xg8VhFwPqB1EYieURCl2730Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a70uHWXj0okfyAlhzBHkAn5ewWDSQL/VrOwL0nx588Q=;
 b=hirankwbtEl/vRqyiNn6HYnlTcNj2T4mejv3MpYPU4QzB9+6XUy100E3FLgz3dvY+qnyGCeVo81aTvDdS+nNUGYsFXvS+ysKXXzxr7RaphSuYzPDA0+AL+kqR61A1L4jRYL9D1YMXb0tL+eim3xJRbDMP3AhSMK2eN2piWD/UkV7ZOw6fqrcS6DTDYrMWoSjKiJcNp0VoS64HBYfDCRGjy4t39gfXC+3Kv2Q6237+MLAgmVeZGjx4nIHnE7sUStXEelzA1CzlVud+ZuL0hLr7tvNhv72GZjH08KQdQXIzAJLjZSjwhDXq12OJp+RyGzeMhg6wqOYDwObvqdKDWBRpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a70uHWXj0okfyAlhzBHkAn5ewWDSQL/VrOwL0nx588Q=;
 b=eaGc/xgLN6l28/OSatT4veNGn2zwDGqJAG2UuZYGB6ZGHQJy1T9mSYs0HoGjrgr8RfoR97zBpu3UaOXizI7StbpXxdXE5RgP6ykA6yTZ/K5Q0QSocWzYPahhWs1GfwG8qNK5ppWtBOtosVNag1dVVJlMOAQjtuSyc8VNGKKJl3M=
Received: from BN0PR03CA0004.namprd03.prod.outlook.com (2603:10b6:408:e6::9)
 by SA1PR12MB8744.namprd12.prod.outlook.com (2603:10b6:806:38c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27; Mon, 6 Mar
 2023 02:33:16 +0000
Received: from BN8NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::79) by BN0PR03CA0004.outlook.office365.com
 (2603:10b6:408:e6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Mon, 6 Mar 2023 02:33:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT108.mail.protection.outlook.com (10.13.176.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.15 via Frontend Transport; Mon, 6 Mar 2023 02:33:16 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 5 Mar 2023 20:33:14 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Candice Li <Candice.Li@amd.com>, Thomas Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH 09/11] drm/amdgpu: Rework xgmi_wafl_pcs ras sw_init
Date: Mon, 6 Mar 2023 10:31:58 +0800
Message-ID: <20230306023200.29158-10-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230306023200.29158-1-Hawking.Zhang@amd.com>
References: <20230306023200.29158-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT108:EE_|SA1PR12MB8744:EE_
X-MS-Office365-Filtering-Correlation-Id: 27e89143-43c8-4241-c7c8-08db1deb243e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2YUembnw4h6RIUP4vc+pq5W+IvU7ITDYf9QRn9EIFdB4N/SnsAfgqf58ckrzprldeRH3Pu9jXR9VKHxSwHcUjICi1Jp50YI5RryaXmY/ODytKH/OBcMX8qaVC6AfHfuZxjN7Dp4OJM8dMpv43ZlElW2GNlQVVWgw9zz47ynk2fMMu4cS8O/XBKSDHs7A7zpi7IjXQi3cmiWPh12KizCmh6Zn9VqPmUHApBbiG+D958xILinnbdcJPPtrC/pw07ymFIamo4zsrOhulCjeROb3ilKkkruPstBNgZ+8qCZYp+v9RczWbOsufcT8n5NyYrUlWdQfqQBOKA+eMvngBmhcXMqk1CRbj3vSsr3lqs+lvjk1T48WPwsdisTFOofFy5nAbuCUUlU69pEwqbHl6U6kQbWE1ltJL/GveQTX3q968/Dkt+gsso2YgOJBwC/rDwWFjMPhLBWEgx+Z8XZasIkw3PCXbP/xuBFNhvkmsa8iWjglG/XJmk4VQMKWgyCwMiS9RFgLNPbWZnGe4cJj633md9dlvKgzpDpsuAXrFw6UI1+ReOaJKWQlpJtAmtujWYNhAsX6KYvC54GiZCQAFqkqz6xRCG0ObdJrWOsjxJ4ByhpVfL6zVrHUN6xWkhwkRx6A+6UHs4hgaE7OIfPdNPe62zYfjfRhdk1ZCmQDz7PyiclinQdVN2DJS7+8oV2iyeHW6DOe6W4EVLcwETO4HqgjBzhHoApBkAgf2Goe68RkLIQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199018)(46966006)(40470700004)(36840700001)(36756003)(426003)(83380400001)(47076005)(478600001)(36860700001)(1076003)(6666004)(40460700003)(7696005)(336012)(2616005)(16526019)(26005)(186003)(70586007)(8936002)(2906002)(86362001)(8676002)(40480700001)(4326008)(70206006)(41300700001)(5660300002)(110136005)(81166007)(6636002)(82740400003)(356005)(316002)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 02:33:16.5358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e89143-43c8-4241-c7c8-08db1deb243e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8744
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To align with other IP blocks.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  |  9 +++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 28 +++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    |  7 ++++++
 4 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 524e2c9b3012..d4685d22be60 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -500,9 +500,12 @@ int amdgpu_gmc_ras_sw_init(struct amdgpu_device *adev)
 
 	/* xgmi ras block */
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__XGMI_WAFL)) {
-		adev->gmc.xgmi.ras = &xgmi_ras;
-		amdgpu_ras_register_ras_block(adev, &adev->gmc.xgmi.ras->ras_block);
-		adev->gmc.xgmi.ras_if = &adev->gmc.xgmi.ras->ras_block.ras_comm;
+		r = amdgpu_xgmi_ras_sw_init(adev);
+		if (r) {
+			dev_err(adev->dev, "Failed to initialize xgmi_wafl_pcs ras block!\n");
+			return r;
+		}
+
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index fef1575cd0cf..3fe24348d199 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1048,12 +1048,30 @@ struct amdgpu_ras_block_hw_ops  xgmi_ras_hw_ops = {
 
 struct amdgpu_xgmi_ras xgmi_ras = {
 	.ras_block = {
-		.ras_comm = {
-			.name = "xgmi_wafl",
-			.block = AMDGPU_RAS_BLOCK__XGMI_WAFL,
-			.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
-		},
 		.hw_ops = &xgmi_ras_hw_ops,
 		.ras_late_init = amdgpu_xgmi_ras_late_init,
 	},
 };
+
+int amdgpu_xgmi_ras_sw_init(struct amdgpu_device *adev)
+{
+	int err;
+	struct amdgpu_xgmi_ras *ras;
+
+	if (!adev->gmc.xgmi.ras)
+		return 0;
+
+	ras = adev->gmc.xgmi.ras;
+	err = amdgpu_ras_register_ras_block(adev, &ras->ras_block);
+	if (err) {
+		dev_err(adev->dev, "Failed to register xgmi_wafl_pcs ras block!\n");
+		return err;
+	}
+
+	strcpy(ras->ras_block.ras_comm.name, "xgmi_wafl_pcs");
+	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__XGMI_WAFL;
+	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
+	adev->gmc.xgmi.ras_if = &ras->ras_block.ras_comm;
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index 30dcc1681b4e..86fbf56938f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -73,5 +73,6 @@ static inline bool amdgpu_xgmi_same_hive(struct amdgpu_device *adev,
 		adev->gmc.xgmi.hive_id &&
 		adev->gmc.xgmi.hive_id == bo_adev->gmc.xgmi.hive_id);
 }
+int amdgpu_xgmi_ras_sw_init(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 67c2a5186b8a..2a8dc9b52c2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1381,6 +1381,12 @@ static void gmc_v9_0_set_mca_ras_funcs(struct amdgpu_device *adev)
 	}
 }
 
+static void gmc_v9_0_set_xgmi_ras_funcs(struct amdgpu_device *adev)
+{
+	if (!adev->gmc.xgmi.connected_to_cpu)
+		adev->gmc.xgmi.ras = &xgmi_ras;
+}
+
 static int gmc_v9_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -1404,6 +1410,7 @@ static int gmc_v9_0_early_init(void *handle)
 	gmc_v9_0_set_gfxhub_funcs(adev);
 	gmc_v9_0_set_hdp_ras_funcs(adev);
 	gmc_v9_0_set_mca_ras_funcs(adev);
+	gmc_v9_0_set_xgmi_ras_funcs(adev);
 
 	adev->gmc.shared_aperture_start = 0x2000000000000000ULL;
 	adev->gmc.shared_aperture_end =
-- 
2.17.1

