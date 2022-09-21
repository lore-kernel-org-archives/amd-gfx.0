Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0874BECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Sep 2022 12:31:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2373E10E3FB;
	Wed, 21 Sep 2022 12:31:27 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D32310E3FB
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Sep 2022 12:31:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WgH0WBJGyoDZVwCnkBVa8jPdaPyrWaj2C5tdfFKE/YJecdITC41deg4TRWsYQVw6EPLT4vTpdZGCMKN6fxzhULKwa6jJO4j6/nxaJ1s2tJM9JRSX6TcsQenKRpFo8il7OH2EMnqcCxXpu5QbbK8lfc2zKrBZwaJWq43bWPwmsePEAk95zKvhmP0mFpGE40VOMsYn0ytQJJ+5Vqv70Kwcaj9Th3jWcW55rYSgS77AqupJYiBDasImpsnTfNuID0DNt9TKDlK1fRG83ucnxa0dKrUK42U6nuLJ1ZIxPT6re2dScqk+FgCKJytlSVOzXoygFxNqlPaK/16PM+wTaRoGGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJ9KSu4rR4UAlrHsUG1tgqlg+1dvLhcEcxuKKrFH4Oc=;
 b=BBKQ26qiCqxszLsMxu9PgwcE5vgbbclUksWWYOwEh8+1PuVxma9khFFfiME8E8YDgNWOXFte8E+cPIseujFhXV5Td+szsk0rBPL5rYm6+WoDvj+t02zuOPRPuQ9goAaJwxyyklWhyGRJWNgerQBDudqVJVMtaP2ia4BOnwZb9Ey5uKrDl7r9A6a2n9o9taivraBKjemWFF5ADSo/+jKtPIwGnFBYQBAkXl73+qvVJXp0uB3yfXBBMCUhWgaZfCsblp3SZbeYeKh3YJmtYq9wSsvPuXyWFeMBAIF5qkkOjP3v8t+st9fnuaFsR6JPsDeeMslUe1AWk2CMPL6KHpdqjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJ9KSu4rR4UAlrHsUG1tgqlg+1dvLhcEcxuKKrFH4Oc=;
 b=D5LK4elstCsZrV+tlMcmpTZfQfxeEdmFGUpvsbS1c7ZsOlxbyA6LQ8r74e9ZTrVuSn4wkTVHhcRfwXJDuJCC/ULsg7zmVKOWz6lzs24E3Z7mF9nmt/a75VORt4iWIeLpTVOw9T+NxBKR148kr98Wox97RnXnEeVbYxFSVcKuiH0=
Received: from BN9PR03CA0869.namprd03.prod.outlook.com (2603:10b6:408:13d::34)
 by SN7PR12MB7132.namprd12.prod.outlook.com (2603:10b6:806:2a4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 21 Sep
 2022 12:31:19 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::5a) by BN9PR03CA0869.outlook.office365.com
 (2603:10b6:408:13d::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16 via Frontend
 Transport; Wed, 21 Sep 2022 12:31:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Wed, 21 Sep 2022 12:31:19 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 21 Sep
 2022 07:31:16 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Disable verbose for p2p dist calc
Date: Wed, 21 Sep 2022 18:00:26 +0530
Message-ID: <20220921123027.2866204-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT061:EE_|SN7PR12MB7132:EE_
X-MS-Office365-Filtering-Correlation-Id: be7793b7-195c-4afb-87fa-08da9bcd2f66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yi/uuf+sSd5iLWS6THvxQlQLYSy3f/hXbsz/T3m/tB39iIQXJhgIN05t0kn/pqsXrYoBa3gf1CgGChHkysqs+OcDCU77uveofyJvC1wW5Kc6HdKXY/eyNNFIo0+sS/wqBEwELhQRxA9tAfX4zPYE8Pe53u5VFJ6lIESzEDQ0dv0Y8Nq8LwYySNfKSS2/WXtNxm75BdyQptSXOpJxMCSvNgnSeR7InGd7C2asl5hbZ8FWYwyAwccBrA9GTFwezdlnVngQnLW5HmZyGa7PbwCZZsVAPOOcH05u73mRpYy9bOCVVP7IbleZ8t5PrwfpWUIlE6ECRxCFqFidNooK5QJMVkUzRkl/9T8j7+ajYDGaZuHbHDvHcVJfwt/AcAgYW0IYoLIYXxydBQMLNN0J3R+ZATFqYnDM8c9ZF3ZyvtK2to91UgJ82er8AT/+uqlLnS0cWjdIa/TG8ujLsTrDdytZ7ZrNOqekk/67Q5iBUxTXOp1iGVQb10ymd4eATQ5ogXmeL1eDvmuz3FecURYEqT/5x+6qgH8EOKWU9gxjgEGJcEYmvsDbhPQBJn8ldXoXb4MuQ5G/tXCRb+ezCHTofZT0RpfhdffTeixwLbXzts1zr6fpqDL6Jnqlqizy5zbuWKVPkKsFM6bsdpF5GQv4cktBTGm5TwCTGsGfmy7PxFICYvu/RLT+RXigmofebYb/zk08Z/uAG/JMHU5VZKZYNBLUVgkxWi1p2JgwkufoU/yOGqXLU55UZnYQxQHC2fs/cxtxpyaCTZqvto87hiuHPnbTroIfg7kHjT8pqw+kj2xuJZxmDWpaG1JZXvOKOmzdH5Tu
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199015)(36840700001)(40470700004)(46966006)(316002)(83380400001)(36860700001)(426003)(47076005)(4326008)(44832011)(36756003)(70586007)(70206006)(82310400005)(86362001)(2906002)(40460700003)(8676002)(81166007)(356005)(82740400003)(478600001)(40480700001)(26005)(6916009)(186003)(54906003)(2616005)(16526019)(336012)(5660300002)(6666004)(1076003)(41300700001)(8936002)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 12:31:19.0946 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be7793b7-195c-4afb-87fa-08da9bcd2f66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7132
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

Disable verbose while getting p2p distance. With verbose, it shows
warning if ACS redirect is set between the devices. Adds noise
to dmesg logs when a few GPU devices are on the same platform.

Example log:

amdgpu 0000:34:00.0: ACS redirect is set between the client and provider (0000:31:00.0)
amdgpu 0000:34:00.0: to disable ACS redirect for this path, add the kernel parameter:
	pci=disable_acs_redir=0000:30:00.0;0000:2e:00.0;0000:33:00.0;0000:2e:10.0

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index c04ea7f1e819..f600f3a3fe50 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5578,7 +5578,7 @@ bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
 		adev->gmc.aper_base + adev->gmc.aper_size - 1;
 	bool p2p_access = !adev->gmc.xgmi.connected_to_cpu &&
 			  !(pci_p2pdma_distance_many(adev->pdev,
-					&peer_adev->dev, 1, true) < 0);
+					&peer_adev->dev, 1, false) < 0);
 
 	return pcie_p2p && p2p_access && (adev->gmc.visible_vram_size &&
 		adev->gmc.real_vram_size == adev->gmc.visible_vram_size &&
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 782cbca37538..9e2a4c552a4a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -58,7 +58,7 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	int r;
 
-	if (pci_p2pdma_distance_many(adev->pdev, &attach->dev, 1, true) < 0)
+	if (pci_p2pdma_distance_many(adev->pdev, &attach->dev, 1, false) < 0)
 		attach->peer2peer = false;
 
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
-- 
2.25.1

