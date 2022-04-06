Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F532C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Apr 2022 14:03:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 271F110E14F;
	Wed,  6 Apr 2022 14:03:36 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2072.outbound.protection.outlook.com [40.107.95.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CEB310E14F
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Apr 2022 14:03:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqfYjYtRdWipK0RmplCwGje0FzTExwwvEy49wAG2vCNepswFob4Py0vQz0C/UmpinvJfJdt3e4f37AfP7DH9qpr1QFhwBLcZwQMFqTMUkJG4EiU+GCDCyfQJi951WkGj2igEm1yfTW3tqH800ClesX4dxiJ5S15aU+27RI8XXJ8eT4RlZsYmJcV4efZJnOrOdoiWa7ej5B+5keawPzuSfhe6+fEcv8yR9jqyVa1wCASZo9gMKSn0dVMBHpPP/d/J2vOnNOvIU2rbv8GZPwpqpCh1gybnstT+X1Ypl0vWGaQsZqPV8X+EDLq5hxZPv1bG8pszAPG4dHEpUNkUC4Ilrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTpZXD2GRa99pjDPWO2OpCkca2I7MRu2OeDX69kwvCk=;
 b=CNZHuhWqNBqksooyYwb+2yXI9q+JNFlJwSmha4cIQ1zNhQrLf2UZbV75W8u7C1gSr6tJV7hpFEpBR3lLqoWckASKHmlcDTrDFhEbGbj28QdiulmORoQJt8uVrJZeEY5A3GKwztGhYy/ZeB0AyKz1sTYoWwiFNDuns7jVxxir6QQT3D8l0F2A414NM2MJ6yEjxB1tcQOS1ixXweOOcttq3iTy5kpeyZA3n0Yjba1Sz+vXmMf4lRNUgCITNskGM0gRxDeKqj18z3tEJawwMQjb1x7sep0J3y2EA17emHAOiuiGRPKkTo33RqeuQIDXJkbPUU4VLXOHlWqTrJq8CwAfTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTpZXD2GRa99pjDPWO2OpCkca2I7MRu2OeDX69kwvCk=;
 b=xpNLiNmsQHySzZSH1J4KSQeVcUGy9fZhYbH94QFWoRjRy1GoNFmY7SkNub8tAKPgfJKhb78NpQlmf0WoO9MpKAJ30HmeMnvg1TFoO3gfT1DS4fV/SorukwXbu7iH2+hORGMTGkZ1/hUk2kX2yUIeiRbPHRCpEsGN+kMDWUkGsQA=
Received: from DM6PR02CA0152.namprd02.prod.outlook.com (2603:10b6:5:332::19)
 by DM4PR12MB5795.namprd12.prod.outlook.com (2603:10b6:8:62::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.29; Wed, 6 Apr 2022 14:03:33 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::c3) by DM6PR02CA0152.outlook.office365.com
 (2603:10b6:5:332::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.30 via Frontend
 Transport; Wed, 6 Apr 2022 14:03:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Wed, 6 Apr 2022 14:03:32 +0000
Received: from yonsun-E14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 6 Apr
 2022 09:03:31 -0500
From: Yongqiang Sun <yongqiang.sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: Only reserve vram for firmware with vega10
 Hyper-V host.
Date: Wed, 6 Apr 2022 10:03:20 -0400
Message-ID: <20220406140320.547463-1-yongqiang.sun@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 558ba19d-c08e-421f-1f82-08da17d63c3b
X-MS-TrafficTypeDiagnostic: DM4PR12MB5795:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB57956EA2D4A28C65C4321ED7F4E79@DM4PR12MB5795.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sYBtrWule0aw2oaEXbLUR2I6bSuHQNojC2nr4RkIADUw5LBJvBsEQlXH7baWnKH7uoR5W3N/XIKnljYTJiYEpcsOltAkzYjo8kZIp+WQ3scc1iy5Zi4agbJRnnyWOz1fMe6ZjZipQ/A+jisNQSqTkmEMiqIMGAzfPI7ZWQSF4WdhRCh/26LfafK/P5Px73/FktrPEXyWlo+VhmGm5wckb5EEbDmVHbNbkEGQUML2bUyyBTVu2xdazpfE20oVWzhQjWKfXAFlzhpVMgjtn641umRDuT4+6+HGLlXEmlWDJr3q4GRtPUtZw22/zZpxQEi3n3Zdho78xxUzp2jXtSC5Ve/TUbiUystEVmollFAR7icwzMQJ0gMbbRDzb1xEOmD105RcfyQLrzCjt9k5NofTpmVV++ZDPRRqANH4AL2+jiLZc+EKkURYOgAMw/zBnxMrp5HIpBUSc/ImURtRYUH1zxEn5Jn+WAKiomU98d8HDgnDk7mQq6MZziIW6oM6HVlAlHAdXWjYpdtPB6vkAxbDcTghToMjYB6GKfJHEB88KhWQOLJhcfVU7xcKxjeMPFxzDKpKbNIWKRwqTvS5KcF3+KgdtkzeTzbY/z1Pe8c399iRgbMcmmZihOcZxaqTMPxX3GLrV2PsaPRfbjFvT1LD6bxIkPBaSz3U5opSeRklbIKAdhxtmUemG6GzezjVjSVmfEvDbSozVH6ARSfENc/gug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(81166007)(1076003)(316002)(36860700001)(2616005)(44832011)(6916009)(54906003)(47076005)(356005)(36756003)(83380400001)(8676002)(16526019)(70206006)(336012)(82310400005)(186003)(426003)(70586007)(4326008)(7696005)(8936002)(5660300002)(26005)(2906002)(40460700003)(6666004)(86362001)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 14:03:32.5888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 558ba19d-c08e-421f-1f82-08da17d63c3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5795
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
Cc: alexander.deucher@amd.com, Yongqiang Sun <yongqiang.sun@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

driver loading failed on VEGA10 SRIOV VF with linux host due to a wide
range of stolen reserved vram.
Since VEGA10 SRIOV VF need to reserve vram for firmware with windows
Hyper_V host specifically, check high part of FB address
to only reserve memory for it, and the range of the reserved vram
can be limited to between 5M-7M area.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 9 +++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 3 +++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index a66a0881a934..324b43c1bc4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -647,11 +647,12 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev)
 	case CHIP_VEGA10:
 		adev->mman.keep_stolen_vga_memory = true;
 		/*
-		 * VEGA10 SRIOV VF needs some firmware reserved area.
+		 * VEGA10 SRIOV VF with hyper-v host needs some firmware reserved area.
 		 */
-		if (amdgpu_sriov_vf(adev)) {
-			adev->mman.stolen_reserved_offset = 0x100000;
-			adev->mman.stolen_reserved_size = 0x600000;
+		if (amdgpu_sriov_vf(adev) &&
+		    (adev->gmc.vram_start & AMDGPU_GMC_HYPERV_FB_BASE_MASK)) {
+			adev->mman.stolen_reserved_offset = 0x500000;
+			adev->mman.stolen_reserved_size = 0x200000;
 		}
 		break;
 	case CHIP_RAVEN:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 032b0313f277..906ec15e8dac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -61,6 +61,9 @@
  */
 #define AMDGPU_GMC_FAULT_TIMEOUT	5000ULL
 
+/* High part (33 - 47bit) FB address for VEGA10 HYPERV Host*/
+#define AMDGPU_GMC_HYPERV_FB_BASE_MASK 0xF400000000ULL
+
 struct firmware;
 
 /*
-- 
2.25.1

