Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2ABAECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Sep 2022 12:31:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C00E710E3FD;
	Wed, 21 Sep 2022 12:31:44 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2084.outbound.protection.outlook.com [40.107.96.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3730110E3FD
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Sep 2022 12:31:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+MCeUh4Vh26aVSiLkP9hLApdom7Is2Rz2ekvUGgLds3Z1WSKLyJwsj14XeVLCPq/+9ryQ6ShgMAFR6XdgeUOks4QOv0Q4rW1MTBC5AvFyGHjO0jkGs9TrcyR9LZi3pRxK9Auaa9VjsFy5uRVo3+N41q0CkGPHtsz9SmEOzMthQoOxqALUscLxh5LSAGVp0s8zbvmP5hdkGFv2uZ24chXIuqKMIAgfKqKyp1BM+bBQhTi5julzxxwDvajTPZiGWclyVzH8PtRgSdMeykbpX7zC9RV9mJtU80QapfW4y+vX5wFLEX12yamgZAtnTIpzF2cTtCdw2DPNvkEiclVgAYeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Ke7tgc0I8Fec6F1WNYrATEVyKJMfB0gBEUg2+W/Wl8=;
 b=AVD2xaHBmLYipNO4dgG6lDe7ZLB4cHPLlcEgq77oRyebOScfEOmE3j+ZucnHaWs6CJxEPrJ00d5p+8DC7E5YsYIGiNsyGbiYASp/sLAZZlCET2jy6iSsMCLDg+f61MIj8JJazjdVLj8btdu+20PAvX6c8tvlundubvBHW7HWHlXUI3u/HJnrhxCzbnvUIaRvOAYYzp+g0+CBB/ZXHX0jyGUhcW1NE5zZQBwElp/8ObCtigPZgvFVakbgIPQ7uHmlj9EilqDbG86qweFb5oZq+giq9UgiWxa0QORT6Tqc6FaeQxcoh7La7nYqD59zD8zc4re56kyXr7pisoyFFJ95Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Ke7tgc0I8Fec6F1WNYrATEVyKJMfB0gBEUg2+W/Wl8=;
 b=LRx99j19frfed4VPoP6g0uqgIx3trURBwjGEQwmpP8l08FDDY0ZJo9DrTftc38WcfBVoW2rKrl/KQO3dtv4/RQf5jzpNOc3jOPeoFSK+bWmaYF+TRwzJVQNjayqioSHktF8ZnQVOIOeVFXHRyJdFpUYd7nEqh8nqBgpEA3gFCv0=
Received: from BN0PR03CA0047.namprd03.prod.outlook.com (2603:10b6:408:e7::22)
 by DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Wed, 21 Sep
 2022 12:31:36 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::5d) by BN0PR03CA0047.outlook.office365.com
 (2603:10b6:408:e7::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17 via Frontend
 Transport; Wed, 21 Sep 2022 12:31:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Wed, 21 Sep 2022 12:31:36 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 21 Sep
 2022 07:31:18 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Use simplified API for p2p dist calc
Date: Wed, 21 Sep 2022 18:00:27 +0530
Message-ID: <20220921123027.2866204-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220921123027.2866204-1-lijo.lazar@amd.com>
References: <20220921123027.2866204-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT009:EE_|DM6PR12MB4297:EE_
X-MS-Office365-Filtering-Correlation-Id: bbbadbb0-9e91-42d9-f92e-08da9bcd39df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0aAvPjIkGzrbTBKmMF/u5nalzrbAzQqf08SkXlge5p7RTsT6d7yLUUDFFLg75MGDwxCvONfYj8LkY6sQjyjHYsB9CHaPA3p/+1zkM4MK6SMDvhkmHnlWFQpUDtGoSDTOOY56xrB6Cr7CR37sMWLF1wwFTR4egXPdzbwsDxVoe26hou2InGJGNbpetqpKtfYtWKTi7wXN+DNJ92ba6yMaV5gRsRnSN/uFfz9ag1DAApZTVKofwrdoy/sPDFcWYO21ijeg5RQ+Cq8yydZLuHT6XSm3dSPs02erWQua0Ufbxsdl3GFoYYKjOgCcyA92nTyWku/9VlX/8KyPLCgQG+UknRy/uAEgQVhv85yv+4etSEC5jWE/O7mLS7TiSqgyMPclwhIYmL0/Gx96gKiUoex3E+BCjvN+pxQmmfpynaz9dAMF/0mcxHUwVXi7oOFzwVZVwNTxGESY76XRFIeFTxxtvz+YHjkWlir7hh5F6dNRHHXT6gc3WM9Fs1eOq9L+lZQryOMsRGqcFNBO9axRivc+Sxlz4tZ6vVr3YNvoXJ7nYUQgRQ7vmfN23H4+yrNmIB1+n9//DH4FYawmnKN0JH42DnIbjSXkFU+jPDAHRuVdLohA2B3Qs0Qxyb8i9pssiy/jjBZQE+ZCHdlu8KG//vKQBF7x5vAOYwbjLMsN7kz4CWrGtEo/V73HKSfdSZgCg9r8LAJ36NcGma53kZHI6vn4bfKkDISnTVGO2fj70l5mBd6xFj9cQOjwANDOFpDFan6lx4yjjcYDlIeMc7NOjPll1Bk0dpHnScIrEf4lvoQT6s52An0NCi+Fxr90l7GFYKmg
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199015)(36840700001)(40470700004)(46966006)(40480700001)(2906002)(44832011)(36756003)(6666004)(316002)(36860700001)(47076005)(82740400003)(4326008)(8676002)(426003)(5660300002)(70586007)(82310400005)(70206006)(6916009)(8936002)(86362001)(81166007)(336012)(1076003)(186003)(478600001)(2616005)(16526019)(356005)(26005)(41300700001)(83380400001)(54906003)(7696005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 12:31:36.7145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbbadbb0-9e91-42d9-f92e-08da9bcd39df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297
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
Cc: Alexander.Deucher@amd.com, zoy.bai@amd.com, Christian.Koenig@amd.com,
 Guchun.Chen@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use the simpified API that calculates distance between two devices.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f600f3a3fe50..ec1023e7b0cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5576,9 +5576,9 @@ bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
 		~*peer_adev->dev->dma_mask : ~((1ULL << 32) - 1);
 	resource_size_t aper_limit =
 		adev->gmc.aper_base + adev->gmc.aper_size - 1;
-	bool p2p_access = !adev->gmc.xgmi.connected_to_cpu &&
-			  !(pci_p2pdma_distance_many(adev->pdev,
-					&peer_adev->dev, 1, false) < 0);
+	bool p2p_access =
+		!adev->gmc.xgmi.connected_to_cpu &&
+		!(pci_p2pdma_distance(adev->pdev, peer_adev->dev, false) < 0);
 
 	return pcie_p2p && p2p_access && (adev->gmc.visible_vram_size &&
 		adev->gmc.real_vram_size == adev->gmc.visible_vram_size &&
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 9e2a4c552a4a..7bd8e33b14be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -58,7 +58,7 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	int r;
 
-	if (pci_p2pdma_distance_many(adev->pdev, &attach->dev, 1, false) < 0)
+	if (pci_p2pdma_distance(adev->pdev, attach->dev, false) < 0)
 		attach->peer2peer = false;
 
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
-- 
2.25.1

