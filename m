Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6E3C7EE26
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:22:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CD5610E43D;
	Tue,  9 May 2023 22:22:58 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACB2810E435
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:22:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+C57qfxt5l5oqy7FziuKBTJw8JXYj2S5NN4/AzGvqXbuTK9vpQr90GNd3jNBY/kvwF/aUnQlg/pqlWmtAVQYpCRbSBVAnjOzTqOWa6K00M9HAP/GZfaaAlBoT9xc2mK2+F10hs1poKmdkRm3L78KsszvliUMtMCuT5ZASJYjhBZhv63O2QTLhUFq7lN/GYxto5xLW1tgaxnuY0pSGRqO8hJ8LixX3/TeOMDenvgCkhHdRgqrV87Lu3zk7FIgPUyV08LzPbJU/6i1Q8XcAfA9X791d5KOvR68MjAN0JtEB+6Rdm6OWikPh/sojSfQrrCe4dg1l52fZZD6s2MxCNizA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4izgC3mpT1g2EIWFFUMIJiufcEb55LHtf+bi3LTAqw=;
 b=MnNwmq+kIambtUAobh+01aRFeeaqUdWkA6mqTrMX3FGqP8QyzYynXIGuYEXSuQoEAmgV5UfN0494OHCPs4SDGrIdQJAZ+X6Sro5NFOhXa8QDoy+fjkL6hkvpWktOzq2SIqNWSgUxK+/IwcqxkdrVuK5LkWoWgACLRoL6Zedpm6M10EsinSti54Ks2rNJwufah5Lfewk6EYrg/Z/+R0Md38/F5rtIB8W0wKrHsyzN4EZvTlZrJGvRakwVrmWIZgLBIAqwatqZcq4CkcmiCy9ITG6ZbwyHO2tKAalX4TJ4jjWy9b6RsROfqqpdc8L2j9mkAOLc6Qp41HNnwV/eWNdwVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4izgC3mpT1g2EIWFFUMIJiufcEb55LHtf+bi3LTAqw=;
 b=BBLgM0jD2+aDJUBI6jKl0WjapBm/8e67s5sF4CHWkrAuKUUGD5gFgBoVhTkU9cGC858axyivUl01VGHTmCTIcZCJYEqkXG2rfguDcbYgdJWYJjmkEZ47k51R2eRmMmOdplYgtBt/j2rSbIob5gejJEwLOhPtaWZl1lQLKg8MC2M=
Received: from BN0PR04CA0076.namprd04.prod.outlook.com (2603:10b6:408:ea::21)
 by LV2PR12MB5822.namprd12.prod.outlook.com (2603:10b6:408:179::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 22:22:53 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::3c) by BN0PR04CA0076.outlook.office365.com
 (2603:10b6:408:ea::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 22:22:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:22:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:22:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/6] drm/amdgpu: For GFX 9.4.3 APU fix vram_usage value
Date: Tue, 9 May 2023 18:22:37 -0400
Message-ID: <20230509222237.478097-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509222237.478097-1-alexander.deucher@amd.com>
References: <20230509222237.478097-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT013:EE_|LV2PR12MB5822:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b2dce3d-ce99-498f-31d5-08db50dbeebb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HwQIcjQzuVLb4B1KdgnvgWpPODi7htK7f2ERvECdWSZ2k9xLMYYKq/XOa9+2UwJXWNKYJPPOtg+LchRXaP6jvvLzqGWzasrmIOSVVmpFFhtQXZbrx/jicoPJXtIrf8XVNSyBNGjXsLecbCGAGwL2y2r0fLK34w0AA810A3v2vmF/JsY0n+t+dPvs69pvLsfuknYMSuVH5sGIakQ0STlkA3nMSoA3IH/8ztF6HceBfzSnKhQXfT1p5/D5W9wm3ne+IZEySeORzjSXuZYh5dRLXYu1F2FDyrl+Aw+86iNhbtJHxc4W+Bwdfbt8MrinzuU07sUkGIaMQonH5T2wRszAFvMUCDjYVWuHOiptK+mQIixiSZ/PHPK/ghI6hD4NEiRZtZxvlb4fcmgxbhc0pRFs1207xg3h+8aM2D3TXzzX+Hb0u5551LFseQkxLtRU2wrduNJQLzjuGFrPWkEyV3MWlIr8AyRxa/Mm6LJhsJnI0sjLTh8i2jM/NIRCQQUWSUlGb2s/l+l69ElXFR9fxBXXwuT/C93GyRT8bSelIGJ5Wi91xbBde0ww6YocdfNKQuJxrJ2jq2VFDVRHoKgC0Ll6wooqnVq9eA6ki16trNQZE8lYRcY2Py1oMoyFN96vkBq7gI+x5x4p8scxjdC1OBTmtlZ5iHIaAQw1bkxz4iST3CIw49PGRyHNrzxooBO/gdHktiio+xm/1TVQzv2ywuJGHX+T88ylcqYbz8zyFrbto90=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(6666004)(6916009)(478600001)(4326008)(70586007)(7696005)(70206006)(54906003)(316002)(86362001)(36756003)(336012)(83380400001)(1076003)(36860700001)(26005)(2616005)(426003)(8676002)(8936002)(356005)(41300700001)(2906002)(47076005)(40480700001)(82310400005)(5660300002)(82740400003)(81166007)(16526019)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:22:53.5893 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b2dce3d-ce99-498f-31d5-08db50dbeebb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5822
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

For GFX 9.4.3 APP APU VRAM is allocated in GTT domain. While freeing
memory check for GTT domain instead of VRAM if it is APP APU

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 40078c0a5585..ca0d326b43c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1885,11 +1885,14 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 	}
 
 	/* Update the size of the BO being freed if it was allocated from
-	 * VRAM and is not imported.
+	 * VRAM and is not imported. For APP APU VRAM allocations are done
+	 * in GTT domain
 	 */
 	if (size) {
-		if ((mem->bo->preferred_domains == AMDGPU_GEM_DOMAIN_VRAM) &&
-		    (!is_imported))
+		if (!is_imported &&
+		   (mem->bo->preferred_domains == AMDGPU_GEM_DOMAIN_VRAM ||
+		   (adev->gmc.is_app_apu &&
+		    mem->bo->preferred_domains == AMDGPU_GEM_DOMAIN_GTT)))
 			*size = bo_size;
 		else
 			*size = 0;
-- 
2.40.1

