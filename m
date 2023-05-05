Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C69C7EE21
	for <amd-gfx@archiver.kernel.org>; Fri,  5 May 2023 03:47:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 889F010E54F;
	Fri,  5 May 2023 03:47:18 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::60d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BC1710E550
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 May 2023 03:47:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZbcEcPL7WBzYhCyTyciAqL5Wf8c6c0JBpAPdAVOaumhC2/bYMJdpEu/UgO/B++xkMiUzJ2w7nuEf0Mb2wg6V0mrE1X67upF5AjYcH3cngXvy18asb1AE5yx/MtZ5DIRk1AE0m4h1nnSdgPt48S+cQPG7z+H+G19RLZTtrm47YVQrsMTA17bY+3rCaOIvC1QdzzQKOIceyiJGEhgdduQtAUGFsBvEE92eHUmXAMAblq4OLYnuR8FFdFPDVnhvG4uvqkwQBYfYk+klOCOjyX9ceQv2AZ9x81T3IH0YNYI1OBj5jOUsAPbTKzM7usyMVOfav6ZI/mJZOCalnzmUXcpaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kiiYs+jw3gT6LiMPCgjJkLNhOwa/9qJhgKqMpoaSWuw=;
 b=aWiIHzyb47IWEfdlnaswxUVTldfbNId1l1uHjszlMAa5nLVacswaFk1DWESYcAta6H2JOfhvWm2AG8wxg83oBlWUpYEwCBuj7D1fruZ8yru4v55GKmEruL35xS1luJNxMdUA/z1i+XayIL6sFdmeqIvh65JzLn2E4NHBOnu8WwVFBCWV+szqJvB4qRAHITPUSwhkrBrMYxu31fV/gMMelbC9GILdyjBaWjRCSB2Qk0pLj945ki5Qpa2VY6MYlmP0iehmqEy6zD3d1X0P6576+MFaUUnV11QG/iSZYdnxF572CQd7OVgSxD2p3NlamIXxt0+XIxuyIKR98bfCQmrMfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kiiYs+jw3gT6LiMPCgjJkLNhOwa/9qJhgKqMpoaSWuw=;
 b=ntWv5f766dNLe5X7QGePH5yA2kQFJe1msjEEIl5/TpXqpLPicZKRpG40iuB0RDlAC+ng6wJyeSG6c3ilHukHT8i3tSJ5WY6Dy/0QbUN0z2DJS4Jh8aLcDZxTRnE5xfHDIaBVaGEAWZFhlr3d2AhE1Rk4LlemUofnNrH+Mw6nimg=
Received: from BN9PR03CA0681.namprd03.prod.outlook.com (2603:10b6:408:10e::26)
 by CY5PR12MB6383.namprd12.prod.outlook.com (2603:10b6:930:3d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Fri, 5 May
 2023 03:47:12 +0000
Received: from BL02EPF000145BA.namprd05.prod.outlook.com
 (2603:10b6:408:10e:cafe::8d) by BN9PR03CA0681.outlook.office365.com
 (2603:10b6:408:10e::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26 via Frontend
 Transport; Fri, 5 May 2023 03:47:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000145BA.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.21 via Frontend Transport; Fri, 5 May 2023 03:47:11 +0000
Received: from primary-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 4 May
 2023 22:47:09 -0500
From: Lin.Cao <lincao12@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix vram recover doesn't work after whole GPU
 reset
Date: Fri, 5 May 2023 11:46:55 +0800
Message-ID: <20230505034655.1077755-1-lincao12@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145BA:EE_|CY5PR12MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c2632ff-5744-42e8-4b36-08db4d1b689a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NgruzFtyFRB7KbiH0S5O9CwcYt8t4EAfhmZHBn54TyypEQstCHCJ5XeM6Sq97Oc0j8ooe7CiX772rTP0SsYlTPyS16rSzmwjo3bPRownC9QiOBbQPZO/qBetpBsPAP9bpFSpYj8zizMAYVVVT+Q3D3IJk0UYYT9e66Oekf3z93BfSYu1JwTUfTpWHW68ddiMKXlGUpoau2GtTPCIsAQOnkwhQ2mzaLZ2SXCHKwJK33EjzhZapximrwx0yaqfORq2bKP1zxEF1cJqsJAknhzHFqJ1BKuDK3ZNdMZ9yrVY9yKnrV/mHVlP4Mkkn4U8wiZO82+lDrsqSWlxWjAIRmG8ZWTdrYRnPXMkD3u2QknXr4g7i7xxzG7I+qa9RTFPMmswcgJseUFXNSyVc3FMiI6MBaelHWFasN5/D3vhxWSypWvP4PTJcuwbCQ+s/KHXT+cNRMhpPQajgyPrwsygEac2wNm8EkUgKrpFNrGEBiJXaB4xluBW0ClOEcXhq1o7EQo+/u6srlvDplYsRYvm1QOcvVUy4uSbcpWBEsJrxwy9ZI+nqU4sLuBg5vntBcWlgCgbbaCgoP1k641FdYR3s1nWNaXmRevSIQecL+h4ATz2xXlL5dXXzxQj+yffwIRWvGm9KjgpbszmFK7dBEB1ubKE60DnssW2C9nAYSoV2lvCv4zkmRraU7bpGtHXY0plZWr7sfOzLHLF2xWxUk5rKR5SAjLeGP1r3ZvQE4r57C/JxE4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(82310400005)(83380400001)(47076005)(426003)(36860700001)(54906003)(6666004)(336012)(4326008)(6916009)(356005)(81166007)(41300700001)(82740400003)(316002)(70586007)(26005)(478600001)(1076003)(2906002)(70206006)(2616005)(5660300002)(36756003)(16526019)(7696005)(8676002)(40480700001)(186003)(40460700003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 03:47:11.6986 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c2632ff-5744-42e8-4b36-08db4d1b689a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145BA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6383
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
Cc: zhenguo.yin@amd.com, jingwen.chen2@amd.com, christian.koenig@amd.com,
 "Lin.Cao" <lincao12@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

v1: Vmbo->shadow is used to back vram bo up when vram lost. So that we
should set shadow as vmbo->shadow to recover vmbo->bo
v2: Modify if(vmbo->shadow) shadow = vmbo->shadow as if(!vmbo->shadow)
continue;

Fix: 'commit e18aaea733da ("drm/amdgpu: move shadow_list to amdgpu_bo_vm")'
Signed-off-by: Lin.Cao <lincao12@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 750eaffa81ba..0581b4fec001 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4514,7 +4514,12 @@ static int amdgpu_device_recover_vram(struct amdgpu_device *adev)
 	dev_info(adev->dev, "recover vram bo from shadow start\n");
 	mutex_lock(&adev->shadow_list_lock);
 	list_for_each_entry(vmbo, &adev->shadow_list, shadow_list) {
-		shadow = &vmbo->bo;
+
+		/* If vm is compute context or adev is APU, shadow will be NULL */
+		if (!vmbo->shadow)
+			continue;
+		shadow = vmbo->shadow;
+
 		/* No need to recover an evicted BO */
 		if (shadow->tbo.resource->mem_type != TTM_PL_TT ||
 		    shadow->tbo.resource->start == AMDGPU_BO_INVALID_OFFSET ||
-- 
2.25.1

