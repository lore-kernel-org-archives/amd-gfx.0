Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF02C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Dec 2021 07:27:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E3B88BB1C;
	Tue,  7 Dec 2021 07:27:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DE138BB1C
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Dec 2021 07:27:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNeFyWTzKw6/MK5QtssMwWc8Z2H4GYkYJ7Kp5cju1/orDJVX6VqKsY8q3rjenR3udRq3DZwPqmnf4Td8q64O0Aq/QeVZILnUNv/SuvuYGf+q0+CNZ98D9ztZdbHD/A4orDyvMLXMizPWwSlekDu2Bn8K6fOIH29P7dGfbxWvv5fLcFeuVRZ5ncKYtwuaHURhEzY+zdzDbxzqN/xzAY7tDupgg/UkYlJZMJ6BtkrduxHGURxCRUg3VSANDeOrhXQSyY3+2yxOzlsGYk8qfJIH2AODGK6i6Ud4mZwHGqJUqC5jkRfzUhdiadITK6a2ZlnWO0yAodGi3U/x5sU8EuD0Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTbZjlTaCRbRNvloRITn3l7kjEsnlz7ech0sISOS7b0=;
 b=UXwfELIJupw38gstSsi9gaBUo/Uu8mV1VUk3BE5ycqYRTbiLPke/BmVdRU+uKH0A+wc/ILPHm5grYC94/lzvosuOFgW4BZum8aXZj40cdPvlTBaUaUf1BoqxkgwWPvy6kJhSDIXtgra4X9cRl67zazk0mlAEqpKLqB8zkkZwNtzj1vgwWEPSVuObVT3cr8POjtNlkascYHpDKMdJVDVjEd5Wlr9nE9XRxxV/v62XOzDqt9OCR4LZtg85BX92h0+61HBiPIQLqYTAl5FbhBzLAdB+kMlIurx6WZ91P8auudb+dDdG+CXEbuiAL+PaUARGgoLx95q4udImvNrQsBmc6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTbZjlTaCRbRNvloRITn3l7kjEsnlz7ech0sISOS7b0=;
 b=qtyx3+YQYMvpw0VyoKYpOJdmLQaMXPUnXl0g7yvnayxb1qfJrk2Oz1IlMyGz6yQwl4K3lhxvZgpvZbVVqyFTY4ZHL9vaGad598MvSkIW5X7JgoH9AAEmj2m/BFRZTI/o7aNrxlKfDn0oEk5fws0+AMJgvx0qhpKiOZlOVUhpr38=
Received: from BN9PR03CA0867.namprd03.prod.outlook.com (2603:10b6:408:13d::32)
 by DM5PR12MB1596.namprd12.prod.outlook.com (2603:10b6:4:d::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Tue, 7 Dec 2021 07:12:39 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::7) by BN9PR03CA0867.outlook.office365.com
 (2603:10b6:408:13d::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend
 Transport; Tue, 7 Dec 2021 07:12:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Tue, 7 Dec 2021 07:12:39 +0000
Received: from flora.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 7 Dec
 2021 01:12:37 -0600
From: Flora Cui <flora.cui@amd.com>
To: <guchun.chen@amd.com>, <perry.yuan@amd.com>, <yuliang.shi@amd.com>,
 <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix drm_plane alloc in amdgpu_vkms
Date: Tue, 7 Dec 2021 15:11:34 +0800
Message-ID: <20211207071134.157327-1-flora.cui@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6629d6d7-0291-43d3-9902-08d9b950f43d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1596:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1596F01A549EAF5F2894B321FA6E9@DM5PR12MB1596.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:255;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8rFmA1rZ7o2uy4IJmQwfp9SSWD1zzqkLhDDjPvwKAt6ZHQSYYFJttSNORkY0gdqAkcrht42pi3leEmhOnEFKuYI0hB+0JkwsPuuNGBHrCsVsqJ/RvbsmImkh4hYjIiWKI3q99G9ilv50RFfQIqNmO/cAsY/is+avekmo8Mmb9ccpISyIKT9P7FMYWQRDHBzVebInDK7O1FP5BF7tI+o6wqrhcKn5YVH4e72ueMnrvvEX6g7jxotLd7um9CurmvUrkW//I0bi8HxZb6BmnjSncDFzJqR2Cdxj6gzChA1odBZfRu6eZoK3U31DUcEBPwsOq+3A/WNmgLGflyMbeItyHQvk+L2FYDzBwkqHtM9PoXoPJy/PaRbsDDu5dY7aTY+yxXs+MuJe+x74uG/rV8O2Vrmzh10CMdek2WQfDjIMixXtVzwCh09VSr9b+MHLDeDivXOexhvLryfl+7pPujSdVu9Huh89y4xU/v+kNJ4yaoENIVuzFvtYw8baw6Bxttv3fh3xZUgf82AGHxBgcFUktOc4P+1/ZaDg+Re3WfpMavD9WSZ0dubUUrb8Wm/VajNiXaCkNGJhaE7RsIaPz2dFZlX+NES9GeBEl7rudVIfLVy7Q7Mpsk/dm06lasZHwHiKqqx/uAw5rSFYlsyw7bTuFp+oZkz1Tx3wDcPAmCSG1lJndbx5CBc6vjdFiXBY0yEmFCB+yiy3M3Xz1/aOTjecD4Guwkr1h9GCszJB99j7WJii1PJyT2lDABnsXSmUYZQO4w1IX/FPTNMmjDpoNlGFhty+n5qYCeE4t5aP98ciUDw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(7696005)(2906002)(36860700001)(186003)(16526019)(5660300002)(336012)(82310400004)(426003)(70586007)(83380400001)(356005)(86362001)(70206006)(47076005)(81166007)(2616005)(40460700001)(8936002)(8676002)(1076003)(36756003)(26005)(316002)(44832011)(4326008)(508600001)(110136005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 07:12:39.5366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6629d6d7-0291-43d3-9902-08d9b950f43d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1596
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
Cc: Flora Cui <flora.cui@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

otherwise the drm_plane is not released

Signed-off-by: Flora Cui <flora.cui@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index af3a2f8c12b4..0bf697b72ad0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -392,19 +392,14 @@ static struct drm_plane *amdgpu_vkms_plane_init(struct drm_device *dev,
 	struct drm_plane *plane;
 	int ret;
 
-	plane = kzalloc(sizeof(*plane), GFP_KERNEL);
-	if (!plane)
-		return ERR_PTR(-ENOMEM);
-
-	ret = drm_universal_plane_init(dev, plane, 1 << index,
-				       &amdgpu_vkms_plane_funcs,
-				       amdgpu_vkms_formats,
-				       ARRAY_SIZE(amdgpu_vkms_formats),
-				       NULL, type, NULL);
-	if (ret) {
-		kfree(plane);
-		return ERR_PTR(ret);
-	}
+	plane = __drmm_universal_plane_alloc(dev, sizeof(*plane), 0, 1 << index,
+					   &amdgpu_vkms_plane_funcs,
+					   amdgpu_vkms_formats,
+					   ARRAY_SIZE(amdgpu_vkms_formats),
+					   NULL, type, NULL);
+
+	if (IS_ERR(plane))
+		return plane;
 
 	drm_plane_helper_add(plane, &amdgpu_vkms_primary_helper_funcs);
 
-- 
2.25.1

