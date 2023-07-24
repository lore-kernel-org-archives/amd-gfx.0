Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC854C0015E
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jul 2023 19:42:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C53110E054;
	Mon, 24 Jul 2023 19:42:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1670410E054
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 19:42:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D64G0NN5pPGkAcNAEiYXzpsAMjYwExj9taeUQegN6dbpCbt9vLj2Mxv0uIa8vt4w9htz8VR56bp9wjnLEzt3c0T14k89psWKf6NxtQRxxuiT4R82lK4Kb6BA1V/+5HulebQxZt4aHNYIIXIqRrdsXUMJnY/q7+wAicF/7tZF4DoZmzsHSQNa+l326uwznWm3LyPE6x5dUZyXTutC05mLCNP9WBwmI+w766v2UokwJR3x9QqxYNREBgqiY/5ln5bcewY1Qp7yls2qB9N7z3RmzXezMaD5I6AfX72hNzE6RLbbROmevuxkdbS+WLLDyiGk2drq+GBC9M+ixFK5yoF/aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGJn8i4auP6g7O5+Hcw/Jojo4pxVLZCaTXiuGUOFN8k=;
 b=c5zO73i9dqXqfxYaGYGbaLdSd4/VQJXU1RCov2j81p7D34c92/H5l7rWusSGJsnO3G8X4A0CmAL4KXBKVc4h+QbL1l0KQ4WwCg2KSKe0gRwo/QrhCBGaCD8mU94QLRFg0QrMgwhCNygViOXojpAJEtnMx+njRnkS0obxiwY/vHhDdS9hzrBfCqZdvHlIdwjCdKi+eOogHr/vUUoJA1nsZny27+uQkWrLbs9VePeSp+79NApSE1ztgVtMTicbTJQCiW7Zbu0IziW4u/FMESQBef3M9H2LXAPsxUIzxA5nEbWg+ZRmZU1sj8wa+k2jXdzz/T+dVxdV7mLAidxqKAuJWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGJn8i4auP6g7O5+Hcw/Jojo4pxVLZCaTXiuGUOFN8k=;
 b=VPJ4gAoOGO6v5EusUhtwila0/BbkLRaZKuWpw2X6/y+frALwfLT2Kd2cjm/ayb0t0efAwI3lNs5p2g8CA7J4/ziMzhOFknL8RhjteAEqLOLHr0iNrOZEB+6Ons4cPzykRL/bieJ6utwJBenDDi186DSYcRfScTqpZvVvcOqSqfI=
Received: from BN9PR03CA0382.namprd03.prod.outlook.com (2603:10b6:408:f7::27)
 by CH0PR12MB5233.namprd12.prod.outlook.com (2603:10b6:610:d0::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 19:42:06 +0000
Received: from BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::22) by BN9PR03CA0382.outlook.office365.com
 (2603:10b6:408:f7::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28 via Frontend
 Transport; Mon, 24 Jul 2023 19:42:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT073.mail.protection.outlook.com (10.13.177.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.24 via Frontend Transport; Mon, 24 Jul 2023 19:42:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 14:42:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu/discovery: enable PSP 14.0.0 support
Date: Mon, 24 Jul 2023 15:41:46 -0400
Message-ID: <20230724194146.763713-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230724194146.763713-1-alexander.deucher@amd.com>
References: <20230724194146.763713-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT073:EE_|CH0PR12MB5233:EE_
X-MS-Office365-Filtering-Correlation-Id: d3a054ea-b590-405c-60fd-08db8c7e0ff6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K3MRJQ+jfXfSF5HlvEKMTQbGJvtaG8mzrR6TT9Ha06OAcCN71rkAZk2zNnXRnfq9CYAyJxNDL6ImtHbLwRJt2gCvgMXp764X6W2gE1KkG+sUg55bs/8Y0xT2bcaCge6BSYM/SHbnQN+sx/ZbEp/e780UuBFlHbkRFn0xSGVVw6UghA+X/rs+dOO//Urmb7TLHDf9YPGjUL38xbzrVGLSUhRipDcSTK+oZDMRpVmftQDJQjTjpZZgJDoZDlCO4xBXf1PWW2bB/WFXoGYPsCcI08ILjB4xWcuSw7eKtaSlgVGEB61eT3OLxuGbURybztrlb15bMKpfoG0I6Zj00WKnpM6gqEu7UAzGIaw1QqykimI99ggvKVyWsvR1LZ8W3QVZSKAksV4vrXNSWGDX4Fi41aKogXcCdCrXVGOEgPxqnZpqKNme+EOsAuleOwv/YTC5Ay9QY9FbmAE4y4eA50lEUAsNsV9mNGjV2Z3v9LhD5tVzYw1ZsCVqHplUi4TLhcaiZtFQ0JqsVV0Ko3sgftmvkMR/KgRHuSySAjNhGksY4WGycqb/217lCAWnm3nVDCNNW0g71TE+8boMSy4jRjvYnpsqhQrC91HQxsCvOlmNqsIb0C8z3nZ73Dq0fOaZ1t/VaWWTYQJnhlZzGHALGrmHyLccavU4GTYrIaU5xdnGcdpHKntiHKEaH2IQs3Q9aiexJNDC6wgfs92RO62gc7ROFGQ10hWu91DRw2rLR1t2vWaJK+FE3+88J9wTuZgbWhi1gEPPFIhBTNfFicidt4e8lcxG3NBDmISbxk/MrAxR8zowag4FwPvPjWu2NTLVjWCf
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(2906002)(40480700001)(81166007)(82740400003)(356005)(16526019)(83380400001)(426003)(47076005)(186003)(2616005)(336012)(36860700001)(1076003)(26005)(40460700003)(86362001)(5660300002)(8936002)(36756003)(4744005)(478600001)(6666004)(7696005)(70586007)(4326008)(8676002)(70206006)(6916009)(316002)(54906003)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 19:42:06.4317 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a054ea-b590-405c-60fd-08db8c7e0ff6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5233
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Li Ma <li.ma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Li Ma <li.ma@amd.com>

Add it to IP discovery.

Signed-off-by: Li Ma <li.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 16cf7b199457e..13686f194d104 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1750,6 +1750,7 @@ static int amdgpu_discovery_set_psp_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 8):
 	case IP_VERSION(13, 0, 10):
 	case IP_VERSION(13, 0, 11):
+	case IP_VERSION(14, 0, 0):
 		amdgpu_device_ip_block_add(adev, &psp_v13_0_ip_block);
 		break;
 	case IP_VERSION(13, 0, 4):
-- 
2.41.0

