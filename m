Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C376C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Nov 2023 14:42:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF4E310E8B1;
	Thu,  9 Nov 2023 14:42:16 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2052.outbound.protection.outlook.com [40.107.101.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2767110E221
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Nov 2023 14:42:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2HXFXe2QAwnX9g9PS87RSw/Zxqb8bZCxVjkawW5AujSfApL39/ZSXMM+Qt8TYnqdg/LYrovz/jE0yMRq49WHgzETXRpOWxiihY0Zbf9fQENalG9sUN8VRV9bUuPrLGdItdEDnDQfCC6oXXhWsYwMX+pR3Wcu8HiVXXVAmBaxljQNdSyDCoL9EACErZE92FIN/RVYh+EYBmvoyzufX6QOgoAx4WvamlYcvuAZJNJolzTvbowJFLHzGyoJL2Kf+9sq9ySRDytM7dDBe+6sVp1V6Y7bNI1KuOmNOFXnN9WItTmVOdzLtN3s6cPMRYmWbjf4bTlu2eoz4sMwpDkcsbLSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cE3ZQJaCyms6icgEsgyYIhKGMU3uBg1rwCk16Gqg7lM=;
 b=HXpBTdwvHrNzBm3PeHKt+S3yMoCxZ8tYBpsmR683qwUkvvtUY1d8hpGY8/La4F4iIIEWOENJUGpHwtaMDlK5mzcpf9rbQRFo3bEnave/DFF9xHOc1ikx8N3DAfwm0/TTjJXdi/rMi6i2YHtFX6IW2JsIYoxxcnaerZNmNjiGWHYSnbvQUweSAd5dwUrVIL86bog/Rx22oFbHepmcQfrXdqtTUeCoxpiyU0o/Z5nA0ikB9h6bnWpWcUHgVAV3ZcumtP3Bbod1aQkytpqhv5bYfz6BQSrpk7liS9RqsFgcJ+vfVqA7qpwV0EQZCD0ZMvnHIneYlk9dXtBwa17arHNBbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cE3ZQJaCyms6icgEsgyYIhKGMU3uBg1rwCk16Gqg7lM=;
 b=DvM9KUTZR8oE5Kw7fiQConb/I4UpQeUT3vbgprXgggjNWSF9hsqddni5PNBAgH3B9n5Zgarzeca0e/DA0B1v7oh/GFqkQ7ubX6l8WPIBl70yVBLwB3kJJsSNL4gwrAaJzOpZBf8aE2S9e5TEtSCqONODO77HeU4My5jU8uI3FuY=
Received: from BL0PR02CA0071.namprd02.prod.outlook.com (2603:10b6:207:3d::48)
 by IA1PR12MB8586.namprd12.prod.outlook.com (2603:10b6:208:44e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 14:42:01 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:207:3d:cafe::92) by BL0PR02CA0071.outlook.office365.com
 (2603:10b6:207:3d::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Thu, 9 Nov 2023 14:42:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Thu, 9 Nov 2023 14:42:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 9 Nov
 2023 08:42:00 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu/gmc10: disable AGP aperture
Date: Thu, 9 Nov 2023 09:41:42 -0500
Message-ID: <20231109144143.502132-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109144143.502132-1-alexander.deucher@amd.com>
References: <20231109144143.502132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|IA1PR12MB8586:EE_
X-MS-Office365-Filtering-Correlation-Id: c2403c88-c0a7-43bf-9562-08dbe13208f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OPuw78u6Bi85vEIdX6k2W84uMOJJyvOUCuDw9V7/PNqLqMW0I9e2rS97zAeKzt0aYSbb3u5IqfmeEgzrh9dK8jAwutJUi4DiQGlTWKnhafjAR68b6678y+oyjH72eyfLsssPq6nFD3duq583WFiltFSeIoSVGD1YcwKDnu+ntYrkrIHdOyJbDwzqPlBVvBP+a+s+SShI88VtLOWFSCUE6jSriCfu+Te54CSUi7tkRzEJuMzcfrtGRJ32H4bLk8K/CuZi0TtAIlnkT4dbfS1wx9rTAixTtD+rHGRZGd2ncEGodnnDIqU8saJg/bLfClVCALI6LXKJN1JdxYZv6soBSZso86h4s5FG7H0KklejpErwE6A9JEx+mny+1l4ZzpoG/h8OnIme3AY9nqgasltJ3eJxcDw4X7wTj/p/HbW17GOAIOwTQEn6O0BQObRp17MxJ72rCWNOT9D7R8bJXVBTDSntC3a/WHsPNjcFWZKd4W4YRmi8OwFHs3MZ1DG533Sv6lnai77xve1PxZibQZ+BvkFnxaCosBpXtCK1HHIRWOr+yCF6KnRLNd6it4LSA0y/xLltq5HGPcLTEl3hPlUFaWMJQCDDWAv5oS/4RtynzzX6brjZai46BLzx/CzJHTCaKoDgwzW4E4I/BPas1pepOUXswHAvqL9M3lWwDilk+tQy6ih1W/oOe0uvTFhH2lyY2SrUMSCTT+/H026rcf1hd+TdoJbTT7IvhKpoeChshFIHyNurMa8FobkFSyzaPAJgWPa1DHb4PJ7LjZQORW0fNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(64100799003)(82310400011)(451199024)(1800799009)(186009)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(36860700001)(83380400001)(47076005)(4326008)(8936002)(86362001)(4744005)(41300700001)(8676002)(36756003)(316002)(2906002)(6666004)(70206006)(7696005)(1076003)(6916009)(478600001)(82740400003)(81166007)(336012)(426003)(356005)(16526019)(5660300002)(2616005)(26005)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 14:42:01.7384 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2403c88-c0a7-43bf-9562-08dbe13208f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8586
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We've had misc reports of random IOMMU page faults when
this is used.  It's just a rarely used optimization anyway, so
let's just disable it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 0ec7b061d7c2..8eb4db3dd931 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -675,8 +675,6 @@ static void gmc_v10_0_vram_gtt_location(struct amdgpu_device *adev,
 	amdgpu_gmc_set_agp_default(adev, mc);
 	amdgpu_gmc_vram_location(adev, &adev->gmc, base);
 	amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
-	if (!amdgpu_sriov_vf(adev))
-		amdgpu_gmc_agp_location(adev, mc);
 
 	/* base offset of vram pages */
 	adev->vm_manager.vram_base_offset = adev->gfxhub.funcs->get_mc_fb_offset(adev);
-- 
2.41.0

