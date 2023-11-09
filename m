Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7393DC4167B
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Nov 2023 14:42:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F23A10E21B;
	Thu,  9 Nov 2023 14:42:06 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94ECB10E21B
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Nov 2023 14:42:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSEz4dbA5tEx4mhCrm/1CPjAwE0ht7eK7UM6xu8+97fyQsM9o+2bzitZe11WQvFIK0DcFZ2f5F5En9cMdQ1HFH6al4lcsehxzn6IMhNoBiXhFcAxDQd6kFqDmg0pLBMs/w9Az/zFXi33g3kj2uNsrZvAhG1L6YY4cQmDKWo4WOeH6Cs+nxlgrJfuDosQ67ei4XTNkWSw8T/KXunv248ql//4dGtq0wzwfh+99s+VMl09RsK6Zy386j0JjL7eEdqPo3xOJleFq0set6UTqBiRixnAPsEP4QsOplkkifTbdBDRDk5wxgn0MSSU/IK8xbaUaCEyRGVzQZGJtFnHK3RDCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cywQb4PN7y2iMtRk71dvPtWM3XHKyksND9vw5rVzHBA=;
 b=AX7N9erfM6qJfGNZCD1zKBNTJf+q3OmFyuLeuHGqfSYBkKcyGY8cTVycWW3Aca6Lsv58sYZOV9WBhttF237WYZmeV8xwjSKQW0oSPT7xiJimG1ujD61DUIfUYaBdoCBTPL33zdwUQtHUp/ZcWH06/X+3bVtRt/gZbsbnamg1by4DAK9gXYjwV3YMcGZv16MqohA9Cu/q9lawdVxd0QYVyFhTWWeeZ8OU9JM9PuwBkZAHiTqLu2xR8Coq17sFaV8piXL5zs3ANBq6T9hXkm7y/jWMH1hW55613wUZuFvNZjZKyfkqfgvbz5mWCccq943nPxkzeGHUWzvBIGkgJz4dUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cywQb4PN7y2iMtRk71dvPtWM3XHKyksND9vw5rVzHBA=;
 b=CSo6ufZ9Uw+HqfZiOR0gEZPaHKNU/YELcCmLRGCDgGmz8f7W9bVF2BQhw+JZz7m7FgtzTU+T+gXMmz3Ngt+SvAB6UaGpoFlcTO9uXdYoh07kbfO+p9lXh/Qmd04siQ8Ujh57L64Z+wFnn8KPanWzhB1itGE/rB8mTNon8ji5ih0=
Received: from BL0PR02CA0068.namprd02.prod.outlook.com (2603:10b6:207:3d::45)
 by IA1PR12MB6481.namprd12.prod.outlook.com (2603:10b6:208:3aa::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Thu, 9 Nov
 2023 14:42:02 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:207:3d:cafe::8) by BL0PR02CA0068.outlook.office365.com
 (2603:10b6:207:3d::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Thu, 9 Nov 2023 14:42:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Thu, 9 Nov 2023 14:42:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 9 Nov
 2023 08:42:01 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu/gmc9: disable AGP aperture
Date: Thu, 9 Nov 2023 09:41:43 -0500
Message-ID: <20231109144143.502132-3-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|IA1PR12MB6481:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ad5bb67-8732-450a-4476-08dbe1320923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NDwwh7dpXLrxN13QYpc+g6LMo8/uHrj4T7GeM1Nxd4ySEGwq/nwHKG4lZh2C6oNe7ytzy3x5sdirOJa8S8TZSE3TpiYuNsWHr57JN8UraFsN7Vz2cWlPFoyTde7dWHYK+oyWHTOgoQCUFHRbhSkJsBd2GaEy32WHVdNeOE25ngIk1sLVujnaaJNxghTiVWRleTtrT4vCX2b2dahskWrJ4xqe4LUw7Oj80qZ7YONHDcZKZ77ENzUqyNMa8RVBjI9Foesi2Xsp+ZNsWFVB1OulXHEaYlUSMUjAM6AfHjPvhNB+RvtlmSYACeF089PiMVyrn/Pec5hNyUZaUzFYAEczsgHv8Cikxnae85LURzkLOrnzwItJrp5MxldFirQAHzaYn5labxWiaoWnGcXwysFsLrg3CNDzR6wFssPsSF9ky9MJbHCJ2kk1doHXBimlufQ9vQJpqnt0nEwAt2O8sSyjtHoq6yZ5XGBeZDt8oXfvvWDKpFx5obQzQnOx5fthDg9KowTZWpfg/dEEmVz6VIOy963KBnO6pG/FYt/OrJ4aOMXge/TnnuBbBGsj2MAVqd9+9qfF984m9H+kG64aB1EIPWA9/ejNnh5ymRWLjEn3Ys3Kuk4rmdyA5zZ+rpPXCGPuEnzElpYpJjXXKznLoNZ4Sb2DerLDzVc90UO3sAzubvrOanlqNbMMtq6MojVw42F8KbUKo0p10JRI05v/gUVmRgR0t4DqtGxAKXS/PcTYdtDIY4LX4XfxRczZYKHgNrO4fRKEYRO1OHliXUaVldCM2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(136003)(346002)(396003)(230922051799003)(1800799009)(186009)(64100799003)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(4744005)(2906002)(36860700001)(8676002)(41300700001)(6916009)(316002)(1076003)(8936002)(4326008)(5660300002)(36756003)(70206006)(356005)(70586007)(47076005)(40480700001)(478600001)(86362001)(81166007)(83380400001)(7696005)(336012)(426003)(40460700003)(82740400003)(2616005)(26005)(16526019)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 14:42:02.0509 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad5bb67-8732-450a-4476-08dbe1320923
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6481
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
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 05fb57540e35..39a0251ba60e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1627,8 +1627,6 @@ static void gmc_v9_0_vram_gtt_location(struct amdgpu_device *adev,
 	} else {
 		amdgpu_gmc_vram_location(adev, mc, base);
 		amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
-		if (!amdgpu_sriov_vf(adev))
-			amdgpu_gmc_agp_location(adev, mc);
 	}
 	/* base offset of vram pages */
 	adev->vm_manager.vram_base_offset = adev->gfxhub.funcs->get_mc_fb_offset(adev);
-- 
2.41.0

