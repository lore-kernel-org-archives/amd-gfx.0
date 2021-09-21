Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B32EC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:07:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12B5561168
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 12B5561168
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 445906EA30;
	Tue, 21 Sep 2021 18:07:44 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E24046EA16
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:07:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VooBa3Zgld+PzYpdhF3z0lg8xw1R3iA2W52zVTKv3AR5uIBMxQ6u8tZPR8HjipLzEw2JFgTihTK9FHLa+yfF8TDt4+z6axGgYPokmIFBc5YSjLS46I0mMshVFSSJfjZN7ydsYz0KMOHdMvBMGhoVcQfZtJmxmmazBVh6A+tjI4r5UwedY9722HxfZLyRddQqnJCQnAYsDVD8iBWSU/25AsgPwLeY+FbQBAau4Tq/UhG8QDylTiBwHmytTpDfWY/3vd7tP1GRJ6b3wdbQb5Gnhoqz1r21aRCdk/sqLHNDmIv8m+xE8oDaf2fb/2HNAEvnrVJSItLZm1Oh/j8GT9qHRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Q89IXJyGZfE2c6/CeGroPgnCjtAAXEVGGgBM1fFhXq0=;
 b=XvjZCD/TZV7M91VzkEF7Wy1b3HG8nxp7t39EKPbvp8QmbUVX5VUOxRWPSRZby6q15uq6gY1+UiBKdyvQDTQhAg4bRMpUAJpGPukmxypPF1XbZd8GDChpG7Z6vcN0nyQ4zlBYE9uNdzMvdM49XxMg+Wxwyjjah2KxBZm71TtMnqDZSaOAh47fYsCyBpLkqzjN2fTMRB3U9PA+hvlA0xfw/td1M4jTnLZ+Zqb49tCURfVdiGcti+j/Qjt2on/l8UlJ8bbQt8hSYtTzMvGcJ2UCsFuQXmQT/pWORLgDrInrBG4ONiqitEHB0oDPcVuatOFQsDyKyuagwxyRoDHp7UH4oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q89IXJyGZfE2c6/CeGroPgnCjtAAXEVGGgBM1fFhXq0=;
 b=axR7xtVgOLVETH7O0flzvNpjaZa5b7dNtzlnRCQJBrGMWTUPYm9HO/YLARdxTsDxeO0rGRg/5r4CDxqkmLZM1TNBu4981AGTzKJZNu7UfHq1H1q+O7clVL+2vTjugonvN7ZvQjX8ge9DXGw7aOqeYRgC+TeqAXkfXhdNhRZB21k=
Received: from DM5PR11CA0004.namprd11.prod.outlook.com (2603:10b6:3:115::14)
 by DM6PR12MB3802.namprd12.prod.outlook.com (2603:10b6:5:1c5::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 21 Sep
 2021 18:07:41 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:115:cafe::7) by DM5PR11CA0004.outlook.office365.com
 (2603:10b6:3:115::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Tue, 21 Sep 2021 18:07:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:07:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:07:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 01/66] drm/amdgpu: move headless sku check into harvest
 function
Date: Tue, 21 Sep 2021 14:06:20 -0400
Message-ID: <20210921180725.1985552-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24a014ec-fc29-43f7-bd0a-08d97d2ab407
X-MS-TrafficTypeDiagnostic: DM6PR12MB3802:
X-Microsoft-Antispam-PRVS: <DM6PR12MB380220E3A6DC5E3D46C8087AF7A19@DM6PR12MB3802.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:265;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZAEipw/AggE7nh4sZPDPpJnjdw9Js2+NIKq86HANd++4GwZ/axB9/a1sQ6l91zcoSE2pn6yQmLRbiaakW9+7oLDC5jpW3AO5PhnGfQUCAsEqdRPNsBGFnU3NuVqtA1kOGP6Q6kxXLyt4xcT+MIsrm4a+i1onCKOvhh/k65pYDwd/aYxlk6ukiTOE9xxEoxhWkZczNE9RpG0P+WhyFDD1Z0wpY09oD59FHTwbZWGbjXpine71qgR+Pb/7h7zyXTNj1YQb5NhwiskC1ccFP2YMYCpTbnpLtVDNMSsaHkIwcehicvDJa1FCxJefwPG4yowFjkBiYxbzuX+kkfS/XgjZGKrBWGJBnuxuJNj26vBkE/CbA1gNR8b3Y62Iur7n/ZsO/WD42ZR827R5MFle/oME6CVMCHwy+k0t3aJ2vnV81N3XDV38mC6lxJtLyoee9ulk5tVh4Xl/pZNsbRTQQEfzqt2TCFiTxl7B0qwv+6M0VpIB/pD1ByMMkhE+uXtYKbdWPT42dOvcfavVIBMevsBouDqsze+K5axU+LE+G2es9J1CmnnbMOUXMw2hEL44O1VUO56kHniy2EfCTy0MuIdOfxUtlYVgR/8fp3u3vHe1xO387jfHKea/QGhfWNJ8hDSmV85DXD3btJsiyOIFxH0sGPUTYT5+PkI+2OoFj9BUUlGsqAflbijxNJwrdMKkb6iukqJpVVcqumkBQVURcBudLk78rTIuQ34UFZ7bgpQyJSw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(5660300002)(6916009)(36860700001)(7696005)(2906002)(1076003)(426003)(356005)(36756003)(83380400001)(2616005)(6666004)(16526019)(508600001)(47076005)(26005)(4326008)(81166007)(316002)(8936002)(8676002)(70206006)(86362001)(82310400003)(70586007)(186003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:07:41.1150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24a014ec-fc29-43f7-bd0a-08d97d2ab407
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3802
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Consolidate harvesting information.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  7 +++++++
 drivers/gpu/drm/amd/amdgpu/nv.c               | 14 --------------
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index ada7bc19118a..f55613611a02 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -413,6 +413,13 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
 		adev->harvest_ip_mask |= AMD_HARVEST_IP_VCN_MASK;
 		adev->harvest_ip_mask |= AMD_HARVEST_IP_JPEG_MASK;
 	}
+	if ((adev->pdev->device == 0x731E &&
+	     (adev->pdev->revision == 0xC6 || adev->pdev->revision == 0xC7)) ||
+	    (adev->pdev->device == 0x7340 && adev->pdev->revision == 0xC9)  ||
+	    (adev->pdev->device == 0x7360 && adev->pdev->revision == 0xC7)) {
+		adev->harvest_ip_mask |= AMD_HARVEST_IP_VCN_MASK;
+		adev->harvest_ip_mask |= AMD_HARVEST_IP_JPEG_MASK;
+	}
 }
 
 int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index ff80786e3918..726975caf4be 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -608,16 +608,6 @@ static const struct amdgpu_ip_block_version nv_common_ip_block =
 	.funcs = &nv_common_ip_funcs,
 };
 
-static bool nv_is_headless_sku(struct pci_dev *pdev)
-{
-	if ((pdev->device == 0x731E &&
-	    (pdev->revision == 0xC6 || pdev->revision == 0xC7)) ||
-	    (pdev->device == 0x7340 && pdev->revision == 0xC9)  ||
-	    (pdev->device == 0x7360 && pdev->revision == 0xC7))
-		return true;
-	return false;
-}
-
 static int nv_reg_base_init(struct amdgpu_device *adev)
 {
 	int r;
@@ -631,10 +621,6 @@ static int nv_reg_base_init(struct amdgpu_device *adev)
 		}
 
 		amdgpu_discovery_harvest_ip(adev);
-		if (nv_is_headless_sku(adev->pdev)) {
-			adev->harvest_ip_mask |= AMD_HARVEST_IP_VCN_MASK;
-			adev->harvest_ip_mask |= AMD_HARVEST_IP_JPEG_MASK;
-		}
 
 		return 0;
 	}
-- 
2.31.1

