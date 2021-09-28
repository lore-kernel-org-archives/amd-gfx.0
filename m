Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BA9C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:43:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 942226101E
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:43:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 942226101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4105A6E0A6;
	Tue, 28 Sep 2021 16:43:09 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B75AF6E0A6
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:43:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1dR4naj8xhS8FE7ts8O5P6Jz9tcYgkcYyGnpHsQWWcGLMOoiY4TKNB8KpJupm41nZiSkTZysK4lUzTZE0f6MUWps6DuTavCiN0LmNKUldblvNEpwxAG/6d3FpHlqwHUPv2ZuoMuvSiemwPcebGr/MeOM3O0KynQbRJY+W8hiNU5aQLRJwgDWbZDBGmMdhM4sMRrHOY/5tu76Kz9d7aMuRvKbOxlC2Xq4FeX/ZYyNBvyiAvMKlsksAcHjo2ecfKi8ZIWFojDk4cgeXF2SMBODGu4BFPkpAcSxa3xexOAqjbQ1izI9DjJsZpyb0GCiQGWWXWepd2jJbh30zT3il8GKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=xnMQSgFJqSBHdAd4EvmbDSBg3N/3rVTFftjp8JAEn7U=;
 b=ahh60Tt4qv5DcQ6NrsI5au0VRTHd67ihUhiC+3ndvkNRgspc8xW+BMBss/yvIHb9lG32znphy8b416KnATbqLa/XzZNnyOKbYMjk/Y2V2fA4u///4C8XFniAsDfbILZ5roXNDjTGiOc7nnTyJbmpQIpTNfXe/JpGAVfQkiquPuiMubb4a6CXEagNw8bcjpWEsw00ahqqqqKbD+0liV5i2dSqZAP5EypyYIk3VWWfI002UQO5YqwGbwbHh+hFuScOQ3qLw41pMWJraRDPQJOpm+n4Kq+gJ6HnduKZBAvkaXd8Nwww4Am8FPpd7D1qwfYGtZILmAT9/radNJ8gxtF5Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnMQSgFJqSBHdAd4EvmbDSBg3N/3rVTFftjp8JAEn7U=;
 b=lcWiUkC9PR+ulVEwXezlsorrT1Wa+Wz7+kyfJoYHFKqJZQwYoxpEhLR9DD7ZDvhtzigJNX6U9YdxSkNbaS4vk/EtImI2roPMIb5Z5kGG4PkAF8IHvEnTspo64ZEUbWAUlSe2FYzykiTQHfcn1xgInrAOC4WFBJU7wWLVZRmdeTo=
Received: from DM5PR1101CA0023.namprd11.prod.outlook.com (2603:10b6:4:4c::33)
 by PH0PR12MB5482.namprd12.prod.outlook.com (2603:10b6:510:ea::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Tue, 28 Sep
 2021 16:43:06 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4c:cafe::21) by DM5PR1101CA0023.outlook.office365.com
 (2603:10b6:4:4c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Tue, 28 Sep 2021 16:43:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:43:05 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:43:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 01/64] drm/amdgpu: move headless sku check into harvest
 function
Date: Tue, 28 Sep 2021 12:41:34 -0400
Message-ID: <20210928164237.833132-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928164237.833132-1-alexander.deucher@amd.com>
References: <20210928164237.833132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d676c8bb-23f9-41c9-c00e-08d9829f0bab
X-MS-TrafficTypeDiagnostic: PH0PR12MB5482:
X-Microsoft-Antispam-PRVS: <PH0PR12MB5482515EF31E49DF8FC21DA5F7A89@PH0PR12MB5482.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:265;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F9HrtuXGnuyL7UBQPiYpt6rkwtWjubi0aWDF7cE2lYySH0pMZixwobo7h9ZT5OGbidGiiO7zRyrZ+NnI6nJtmV5C8efssuRyyFfntRSGePDn+oQpH76gmWyGVvMvROOmpXjhcF6XMvXWuMcPZCCemxpPbb3nSy0ohnPdxpn8EhQ1Fg9wPIDSX1ezHsLOzOGvazQFQ6d3dG+LjHh5N7/Oo96EQn6+1fkfJgNNGJn/PMzgN31863EafPeMClWWrcR4ymTBdVpMq5zSJ3IErjenIHjnl5im4L+PdjZOWZat0izPqC2OHVCIHOsadQQMWYiG29EBdm+vwBF0fJw3TaEuxQXSNnDWt9Fu+fphxjazmzQLBtJWFDiKpjOmNv+MLlO7Pug0N+GH5y7CcB6zUX9IZ1bIkgtW+utRO8XYaeNSY94n4rofa6c73jyeU4Q0lsKDTTF98/Tl5mcv3IdBDwrQ1j5wBNVuh5ypaJlPSzAPxlyJ/qyG331P//RIP0lHsS738IJsK8Amq5IBphX4gH+W8U5C11mT0GcwPMILdF2hbQ7BDjT+pm83LY/p4ZUZv4NhIABGwW0ZNPXSfFTxeT76+3TFVzPTGZBn09obsDGHtwbdtOPinPjUGenDwli/OFSUVG0jySKG7HWY0QSXahA1hzqr/jfYIQrEhB+ymsO8ynTgJgrnanKXfm2Yc8+8U+iPAlcTurfkAm5JLsocc8jLCadS7I+2Jtr+SFIzApbgZWI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(336012)(81166007)(7696005)(4326008)(6916009)(36860700001)(356005)(426003)(5660300002)(6666004)(47076005)(86362001)(82310400003)(54906003)(26005)(186003)(2616005)(8936002)(1076003)(83380400001)(316002)(70586007)(508600001)(8676002)(36756003)(2906002)(16526019)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:43:05.6062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d676c8bb-23f9-41c9-c00e-08d9829f0bab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5482
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

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  7 +++++++
 drivers/gpu/drm/amd/amdgpu/nv.c               | 14 --------------
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 34173be0749a..cbe817a5e7bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -434,6 +434,13 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
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

