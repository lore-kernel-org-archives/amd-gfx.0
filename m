Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D571DC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Apr 2022 18:35:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C7EC10EC5B;
	Thu,  7 Apr 2022 18:35:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75ABD10EC57
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Apr 2022 18:35:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HL26mJH00ekdw1FSUtAe9vd0oerSQ5AF2tAMBhFFQndwV9+84moFFoLCJhlH3yiiR0A2bk+j9wRWmKj/wy5iICFdxcC1m+IkbP7cL7EA4GRAx9NXK740QIP+B1NHwdbzplCfL6bItXtDFcdcoToiUj9waugH0gp3KBJQock/9PRl5C/IMwlwrgEOooAPCwjnl5zGqZKXayctEKSisUia/khLz0cYTObGiWGPBwVhCATdo32hcQWwRrYUe84SPiUh9q4AeIb434qQENiQegRnheRmC1jSylh7mYwf6XHjGhm1qUYfcEm2QtFwep6f9Omrs4mtugQeXvIoqjuK1Rcp3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldshTNwOEqT7Uukw4bwzkOsu3J7+NDOAw08PF21bz0s=;
 b=IYmHM9AIV53mFkY61xEoa0KmBrT+S4W4p0CkdzPMeQGFvJesOI3BkCrKkVCXArtY3xo0Pdw3piY9SrLHCnj2uGKQQiJPByp2WtrJ8WiJVEZ7a7TW+AFHVjVOw+CYbuqW1ZUOy0EpWwyBKnY+AzRWXreQWlQVRA4GyzVwFSShRAIzFL4azbrQSdgVF3/Wi+ygRyGG3E0BQdKottWHltIJttofarst28TIDdgc3Up7wiEx3ntvvS1cSodAIpMVDAO8+sSWXcD2KC8MzavNsm1jloWIimPXUOWcLmhuuU4dVafpvztzIh7YNfecpyu+D5v6cfAdX9iSLi6o1ze2su34jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldshTNwOEqT7Uukw4bwzkOsu3J7+NDOAw08PF21bz0s=;
 b=mp62sLkytZ9gAjczUvHitiILeYOkEvxPhLhEZVdZXxmSBq2buNEBvRs4gE6FXKC46iqIY8sxByTLZyZtT1ajJn7N2CgntkSkZuMuRUX85iwmVf4BfW7kmrg/s53JKNR3Xz9B5yikaq7CR7gbzGB/mWldWxzaQ5hMQB1KbRwpvXc=
Received: from DM6PR11CA0063.namprd11.prod.outlook.com (2603:10b6:5:14c::40)
 by BY5PR12MB5512.namprd12.prod.outlook.com (2603:10b6:a03:1df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Thu, 7 Apr
 2022 18:35:04 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::e4) by DM6PR11CA0063.outlook.office365.com
 (2603:10b6:5:14c::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.29 via Frontend
 Transport; Thu, 7 Apr 2022 18:35:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Thu, 7 Apr 2022 18:35:04 +0000
Received: from yonsun-E14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 7 Apr
 2022 13:35:03 -0500
From: Yongqiang Sun <yongqiang.sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Only reserve vram for firmware with vega10
 MS_HYPERV host.
Date: Thu, 7 Apr 2022 14:34:51 -0400
Message-ID: <20220407183451.21223-1-yongqiang.sun@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f9f41e1-cdb2-47c8-a370-08da18c55524
X-MS-TrafficTypeDiagnostic: BY5PR12MB5512:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB55123D03F5BDAE4C9E685AA2F4E69@BY5PR12MB5512.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qMANMSczmk3T+R8m9uDAZqi9adgOcCvsgRHhKMSYYbdjDDfkWdlTIfbx1T7UH+zWv5Zx9NTmpksE++7BCB8C4M4hKeB35KXL+EU1lC9P8VqEfe/GuNEqf99D9tDXOoOMOYg5C6xpQK+EGYLWk2O568lPpKDlvL7xaKIo7avLugl3zqj7hpZa+oataOwqYsu1hFHaN4tPdlhWcXztO0Pbug3Xo2sm7AryR5pR/c+TiVOfR2fJwQLg7tYv2+2hsKtBh4tBHYyFj3MOcfMbb1cP01wLrRojonI95InWeDL2PJxWH5Pd022IPSMawCbPUmfv67R4joqPB90blwPJ+taX9/dBt+doMlQVSC2Aa39XjH4qNmBd/CaYId5lddBpK8l7+fEGoF1iyRrVk067qpP+lNvNZO5Ld4pdyUeoFnYtLfWF7vBLv1szdVb1Ct51I16XYEC9XqYzb0A5WAuplC5zjb6qXbDv/OktTFzvJaseGC9yrfWqFAj6WwLiY0wT6GBwADdNFcGqRbXKXxmFrdz70dxqMzDIp0DF6DYtFWJEjnOrJ0JkXwNp5eZb8NNchsJO9aX3Y2VGo/1ZX2woh8ZXtyPo5LpAKwdRrltXdtKa6ujuPHewG9l1idZE9KU9VRxhxBZSYfuTGqFcym6GWXI/q34wAGTzrnEwcGlrZWoX0/nQ/soc6jTj60YlSJndMV/XFB6GFzOQWf6eDpc50tRIXrUd1owptTRYD8iyvT9jBkQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(7696005)(5660300002)(8936002)(6666004)(1076003)(16526019)(186003)(26005)(426003)(336012)(86362001)(8676002)(4326008)(2616005)(83380400001)(70206006)(44832011)(70586007)(316002)(110136005)(356005)(81166007)(2906002)(6636002)(82310400005)(47076005)(40460700003)(36756003)(508600001)(36860700001)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 18:35:04.1341 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f9f41e1-cdb2-47c8-a370-08da18c55524
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5512
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
Cc: Yongqiang Sun <yongqiang.sun@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes: 8011a76ad370
("drm/amdgpu: Add stolen reserved memory for MI25 SRIOV.")

driver loading failed on VEGA10 SRIOV VF with linux host due to a wide
range of stolen reserved vram.
Since VEGA10 SRIOV VF need to reserve vram for firmware with windows
Hyper_V host specifically, check hypervisor type to only reserve
memory for it, and the range of the reserved vram can be limited
to between 5M-7M area.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index a66a0881a934..3e9582c245bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -25,6 +25,7 @@
  */
 
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <asm/hypervisor.h>
 
 #include "amdgpu.h"
 #include "amdgpu_gmc.h"
@@ -647,11 +648,11 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev)
 	case CHIP_VEGA10:
 		adev->mman.keep_stolen_vga_memory = true;
 		/*
-		 * VEGA10 SRIOV VF needs some firmware reserved area.
+		 * VEGA10 SRIOV VF with MS_HYPERV host needs some firmware reserved area.
 		 */
-		if (amdgpu_sriov_vf(adev)) {
-			adev->mman.stolen_reserved_offset = 0x100000;
-			adev->mman.stolen_reserved_size = 0x600000;
+		if (amdgpu_sriov_vf(adev) && hypervisor_is_type(X86_HYPER_MS_HYPERV)) {
+			adev->mman.stolen_reserved_offset = 0x500000;
+			adev->mman.stolen_reserved_size = 0x200000;
 		}
 		break;
 	case CHIP_RAVEN:
-- 
2.25.1

