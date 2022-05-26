Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 234FDC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 26 May 2022 18:01:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA05710E4C2;
	Thu, 26 May 2022 18:01:45 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB34810E4C2
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 May 2022 18:01:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQMHSinN72emojO5I75nCUo+bGDwaE82W5ik+loubQYqsHTzZnGG9advtUGTqJZfgdvMSqlxsNL1FQcsX3w5X6ZYqGnpXEt96Skbfj0W8VGb+19o6CpZZjifpOWeowk/eidXEgaz4XFeU4Rmo67FN+dQJxHJ5F/47oPS6rqXahXdZSpirGkAVPa5VIl5untg1+FDzJhzfyjlmE3xM0cWBJybvvHRBJs980w6paOrc++E98pF5XDjl4BZl5UVVB9lguMdQ7WXgFozc9LpHO4kcK50pqXNLW2wRN14QYuPZHu6wcxcQ0MbpYtGY2sv3cFrVJ/YqsBgtDFRKNQD29QK+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3FR+bHUv3ahYUkEIl4O+f2OJQYO3NJkCLB8QBeiRfM=;
 b=PCoLv4c0if3pPlZ1OO4PFY0QviWyb2iYRIJ9T8xQNZoxi0JnfBf1ugHGje4DyL8xZSQNgqltn6eLTilWVS0Piud39BtayXuSWTT1HiCDNzHY7o4+mEL5GAl7ND6HmIRNvxQ0LL81F8M+1W8F+S/VaLwnJhc+YWYgBsHOOF0cDeepaE3vntV6SNW0rU/0iMMXeRP04+bCLM/pkGo7dT+lhJpsRudxx8yY8hbl+MTT2WOe8B3pyVvwXGRMihrcMpOaD8mSeakWP1nea9zfpp4JiBMKEm0+iDxf0Ue1UHZ0Hm8rC2H/XmfpUO5VB5HQbVgDZChLZ8CKo0nuGfrFnACxlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3FR+bHUv3ahYUkEIl4O+f2OJQYO3NJkCLB8QBeiRfM=;
 b=Tt0tUYi0abMHxsP8bZi5MIQrnGIbrQDMSXCPqpPRp9PXx5Y8kdV91JZ5PKD6XFEzUwfyZpwTGV31vFiAXZSNV2Bu5clsiVB3SGGCSRwRz/O0aYI/OqnwEdascoTrSVd6ZUZkF+f0j43vtxhVt/E8TNRt6C/ZpqyF0pCz5cSLwvI=
Received: from BN6PR19CA0112.namprd19.prod.outlook.com (2603:10b6:404:a0::26)
 by DM6PR12MB3978.namprd12.prod.outlook.com (2603:10b6:5:1c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 18:01:43 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:a0:cafe::77) by BN6PR19CA0112.outlook.office365.com
 (2603:10b6:404:a0::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Thu, 26 May 2022 18:01:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Thu, 26 May 2022 18:01:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 26 May
 2022 13:01:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: add apu sequence in the imu v11
Date: Thu, 26 May 2022 14:01:23 -0400
Message-ID: <20220526180123.3044888-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220526180123.3044888-1-alexander.deucher@amd.com>
References: <20220526180123.3044888-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d4c06c5-8d3f-4c55-5f92-08da3f41ca83
X-MS-TrafficTypeDiagnostic: DM6PR12MB3978:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB397839B757B0D62C987F462FF7D99@DM6PR12MB3978.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fIhywqYY1RkKF1hyyllPq+QORketotQn9qdSVq6K1tmF5w9+A9RMo2z4YhZdgvpmR99AHRLhVYz8ZMyK4fI3UpkrWpWbHaNxe3IwDkHvPVIY1EEgUfaR03PtIWgXnL/ow9hXBtXPqqnsoUeYBkuXFSz35mpBmKXjAC/W1WgzmOkmgCDdbDE6HohiIrX42TrbP/fVgOkCoKztP7kRZ1rDICEPw2p8qUdz3salmIqYiQf9gbY6jFx4OYShnKN67yefJspMyBAEUlhBfxeBt8DcfVAXgu7o3W5NA98Rx52Ye7EBhF+hx4RthU9fEeYG5kSha4y+WSiZwgLYFck8gOQF/6whBnrwBTcZPHtvdgFn/uL/IoXk0FY9cbMgMW11AGXv8m7DPSxdr51uqoNECRX+XclhZVmuPqhd44rSudK10kuoJpCrfoXGUaLIvWX8IYtZUkqj8ClPFALka0fwM0hkEDlR+Kl+aGwLFFbWKC4tpWRVvxogsAXHqu8z31QHQRAqAbN/gOfJiFTMjX3fK99GT5zfmXBkS7EGGX7/c3HlE42YJUm1dNB03KuFAu5CFAs4YtMDyqJ3eiIX46O4D8nHUQr4Vnzc7kxyM8FXcEUddhby/gzQSAdXDoC141JjJGPzngxaoLHXVRsCgsLxCBeHvSi05Cpcrdws9cP3qX306jGwsKsn+thzbQ2zResdFWdQkIEL/vGsOS2c4UP6o3UTmA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(8676002)(70206006)(4326008)(5660300002)(47076005)(8936002)(70586007)(40460700003)(36860700001)(356005)(508600001)(83380400001)(81166007)(1076003)(316002)(7696005)(6666004)(6916009)(186003)(86362001)(54906003)(16526019)(36756003)(2906002)(82310400005)(26005)(426003)(336012)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 18:01:42.8752 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d4c06c5-8d3f-4c55-5f92-08da3f41ca83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3978
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tim Huang <Tim.Huang@amd.com>,
 Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Huang Rui <ray.huang@amd.com>

APU required to issue the enable GFX IMU message after IMU reset.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 6 +++++-
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c | 7 ++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index e331ea387ef0..d62e3c1efc7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6291,7 +6291,11 @@ static void gfx_v11_0_set_irq_funcs(struct amdgpu_device *adev)
 
 static void gfx_v11_0_set_imu_funcs(struct amdgpu_device *adev)
 {
-	adev->gfx.imu.mode = DEBUG_MODE;
+	if (adev->flags & AMD_IS_APU)
+		adev->gfx.imu.mode = MISSION_MODE;
+	else
+		adev->gfx.imu.mode = DEBUG_MODE;
+
 	adev->gfx.imu.funcs = &gfx_v11_0_imu_funcs;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
index fd053158abbd..76383baa3929 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
@@ -24,6 +24,7 @@
 #include <linux/firmware.h>
 #include "amdgpu.h"
 #include "amdgpu_imu.h"
+#include "amdgpu_dpm.h"
 
 #include "gc/gc_11_0_0_offset.h"
 #include "gc/gc_11_0_0_sh_mask.h"
@@ -165,10 +166,10 @@ static int imu_v11_0_start(struct amdgpu_device *adev)
 	imu_reg_val &= 0xfffffffe;
 	WREG32_SOC15(GC, 0, regGFX_IMU_CORE_CTRL, imu_reg_val);
 
-	if (adev->gfx.imu.mode == DEBUG_MODE)
-		return imu_v11_0_wait_for_reset_status(adev);
+	if (adev->flags & AMD_IS_APU)
+		amdgpu_dpm_set_gfx_power_up_by_imu(adev);
 
-	return 0;
+	return imu_v11_0_wait_for_reset_status(adev);
 }
 
 static const struct imu_rlc_ram_golden imu_rlc_ram_golden_11[] =
-- 
2.35.3

