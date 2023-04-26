Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B975DC77B73
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Apr 2023 03:11:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F8F810E12F;
	Wed, 26 Apr 2023 03:11:57 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::61e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2633710E12F
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Apr 2023 03:11:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7YhF63qK93dQrroKXcWQ92P8zqRC0tJC7F0pRGZst5atJfBe7Gn93JQQ18D7tGTohvEHKiJ8SUxbp5G6L5NvSoW+Sg8j5XESKyrp1uwvQlhKNhsoF9wAg2z7cSF0+ok6ikjGI5KKtBQMPPhUCIugIFCNsNaXcN5a4iNbK/BvgWw0hUPWmHS5YL0PeiTFoXaJA8g7wjgi6Ncw4JoM5RJsELlCTpqzYbMXLQxjBsi2il64vQz2wsbUNCCIr3nF8ucfZXB9X+/C9S+B5r6BKJUQB+GaKpwQyne+wCqHEd4Gpd9hczyFliWV0cVA0Ro8c1fmEfbStnH1kCuo/6cc6FY5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e589D42kLnynkaZEKZiu2CIelce9L16v2xDcVuhn7qU=;
 b=QQzeXsfJCI/pykhQxyaxl8gfWLhFA+9ilJHkkQ6Vz/s0cgpWKCKFqFVKNRotyBEPfCB4ZwLkO4tE/s0CbfUb/n1zXwv/JyNWQSOWeVZYezOGDKjgM8LKb6ntS+cyjhFkvsnqHMkafrCs5EXTpGsRVkBimm/jm40W69fSnSehxbd5pWlnH0QVoCYx+hsiPo/e0C1vj9TX8WFNlr/8zcFxQchu2cwojl5MS3ellxFSJDgdsm4TRrysF5MZuWzBtrk6QZhp6KWGaMWUN6iWiTgXhp8PJKL18rb1z7OwMmIrQDrg74G7zW3YchcUPQDRGvIPFzmLKr3aYfYfZGfQulXYuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e589D42kLnynkaZEKZiu2CIelce9L16v2xDcVuhn7qU=;
 b=XzOh5a7YvpnJkH0zSEm+gms9x0bwJCozWxizwo0jK6e1qOk0J4pHD6eXy/OqK1s08wmvTeqn4gpQlQqT0g7xNxNC1DkHZiqLtmTTaLjUBSa/MX0gYPc2p2p3XeDWTWOrSDU9au7ecH29JwE6OGbgiOd8Mk9yZUWRRLICuv1W7nQ=
Received: from DS7PR03CA0234.namprd03.prod.outlook.com (2603:10b6:5:3ba::29)
 by CH2PR12MB4134.namprd12.prod.outlook.com (2603:10b6:610:a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Wed, 26 Apr
 2023 03:11:51 +0000
Received: from DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::a9) by DS7PR03CA0234.outlook.office365.com
 (2603:10b6:5:3ba::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34 via Frontend
 Transport; Wed, 26 Apr 2023 03:11:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT084.mail.protection.outlook.com (10.13.172.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.21 via Frontend Transport; Wed, 26 Apr 2023 03:11:51 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 25 Apr 2023 22:11:48 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <le.ma@amd.com>
Subject: [PATCH] drm/amdgpu: fix a build warning by a typo in amdgpu_gfx.c
Date: Wed, 26 Apr 2023 11:11:30 +0800
Message-ID: <20230426031130.147291-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT084:EE_|CH2PR12MB4134:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d2d3deb-5125-4909-d601-08db4603faef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Wp2VH4gnHDGHl7WqVzOKqRf1kymCjnZrkpWZ3PsQg+h/5pm9y9UyZOkCO1ERhdt931bZk0bvhDspiV+g38kvfs+z0xWaOFjATg8hnsJ0ABfDY0p/RcQekRoawgokuRnt5ItvcaMTA8yHUaCtE46/FqDPNN+fKP0y0Ekfx3ygYH8E3cXBzvem/S+j5/cVp51MLLysTCUbqd1zf2+96bCQrUtWB02Ir2eFIbK4ipWEBKnaPrupiK/qBkmopIlyZf257LB5+bBNpI5aNSMgZ2fQ7Iex4RQDiIkZ7YwV6LuiuZV7BHneSUJKwlHokKZTuKYAgRxDp4zLhvJO25FAQqtRL8Blp0Ri9pIvwWJe919Dcb9LtkBhbrW/wJoXWVipvJRQfny660gcbw10DXe9sPNfGCP7/oXeHP/Ud/f4CDggL4lfJkQYrxB/HQqbImy5PiSNdCSsdcpMT6bKX0ZArZXxDRmJNRNZQMDa3SME5dXJMtc9ZmHBV714isvfVhdME/fWl3Ah9aiM1bPi/wIwNHNIjqNnbW4JvNsDnAn9D/vqtSqI9Tnj8q/WctmEmw3UaVDH4WKM/RDUvOrYCgyg2stE/ZYdPsV1YhW6b/u63G2187VjAQbS4qB6Ta02krXstkjy1Xywq55vTUEpUetwn4/wZioGMgJup8ec0xXF/gecS2gEDwvLyQ5fgh3M2TdQSLrYVUhKxCSd89ajBwTBP+VE8LJu2qUhXEeK0KK5A/j4wErxvEXjxqylwJySZ3NkPhh
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199021)(46966006)(40470700004)(36840700001)(40460700003)(54906003)(110136005)(478600001)(5660300002)(8936002)(8676002)(36756003)(2906002)(4744005)(86362001)(70586007)(82310400005)(44832011)(40480700001)(70206006)(6636002)(82740400003)(4326008)(316002)(356005)(41300700001)(81166007)(336012)(426003)(186003)(16526019)(2616005)(36860700001)(1076003)(26005)(83380400001)(7696005)(47076005)(6666004)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 03:11:51.1144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d2d3deb-5125-4909-d601-08db4603faef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4134
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
Cc: kernel test robot <lkp@intel.com>, Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This should be a typo when intruducing multi-xx support.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Cc: Le Ma <le.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 60bb4bba1994..2cf1f88fde48 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -470,8 +470,8 @@ void amdgpu_gfx_mqd_sw_fini(struct amdgpu_device *adev, int xcc_id)
 
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
 		j = i + xcc_id * adev->gfx.num_compute_rings;
-		ring = &adev->gfx.compute_ring[i];
-		kfree(adev->gfx.mec.mqd_backup[i]);
+		ring = &adev->gfx.compute_ring[j];
+		kfree(adev->gfx.mec.mqd_backup[j]);
 		amdgpu_bo_free_kernel(&ring->mqd_obj,
 				      &ring->mqd_gpu_addr,
 				      &ring->mqd_ptr);
-- 
2.25.1

