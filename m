Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30A7C4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Nov 2023 19:31:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5116610E667;
	Tue,  7 Nov 2023 19:31:28 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3CBE10E667
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Nov 2023 19:31:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ou4QkTqFM5PXONykt2qIEVqPh+MKT6XNNSVC6FmvnhRTN901O00WEwvMEFGJMeSjC35qOCTu1wopPAsJZlTlT2dj0EBtsNKS+VUXbg+o0MCT8mB1KkqfN4u3vb9I6nmcVKh1/s6ORqtLpgtx6L+Ro9hsVz4XiVzrYnkYGaOQdR5nqz8EQsvSacgndGpBouCQCtf/nEp7GITarewuWZXgFDZplZt1oK9HHPjnbEboiKzc12xBx2YVp8xAiPYRP2vLPDc+Hz7L5bonb1tznUbhJadFebkrUgO2Yh83BkyTk6A3+WJU1TLMcsbDJlorTsIowMtYE3rZ5ZcCUVm5QcdWAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hw8bt3C27p3wFshC9Ene4l9AGIuDxon+lUiuRcaF+68=;
 b=U47Kqv8JqjXmoM4sAxMFbHT/O50jKnELCOTt+KkE4fKoknPtGjY9QzXP2SMiXlhDUW1/7BTjOMRYb3VdQSCZr4xr64pujhsBt2I8I+liL/Shmzoe80o4uMBrdqHUzJooWi5MtSLMxDf2pLeO8OHFYjr8OB+e6oVNhk4isR6kUc69eP6AGzAgZ3opmWsqBSiepRxQxEDJPMNuuKYSsolTqjs/Rbl7eh09zyHgASZ3oxgH5v259posMbm3X4M5Im9bDqsdKl5kYz5CPNNWbQrou9wHnazPACNBj23azTaz74uFm5df3uFGCKOJIjJpSwFs1T2SUe6JTrAaF39JNnttgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hw8bt3C27p3wFshC9Ene4l9AGIuDxon+lUiuRcaF+68=;
 b=pMBWs5JDdeL/xm0WZPEpAkzCYZoQml4okcHo1AdjRJeWbqkBGEEvISiu3Jvw7T1WWN0Q6jhQAbDKx17q2b/RPRPvrkIDlY15GxyWhfLEMAttiY9TD8dG2Q32gOeLLBjYHhfGyGFY5p+juoNPJC34DIIh54QywvKPWpgd6r0OLKE=
Received: from CH2PR02CA0006.namprd02.prod.outlook.com (2603:10b6:610:4e::16)
 by DS7PR12MB8203.namprd12.prod.outlook.com (2603:10b6:8:e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 19:31:24 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::c8) by CH2PR02CA0006.outlook.office365.com
 (2603:10b6:610:4e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28 via Frontend
 Transport; Tue, 7 Nov 2023 19:31:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Tue, 7 Nov 2023 19:31:23 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 7 Nov
 2023 13:31:20 -0600
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Do not program VF copy regs in mmhub v1.8 under
 SRIOV
Date: Tue, 7 Nov 2023 14:30:34 -0500
Message-ID: <20231107193034.2345-1-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|DS7PR12MB8203:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f8e9a58-7e19-4a17-e84b-08dbdfc820d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VEpPA+0SKgCDfG2OgTElO8ZCmnXZq3QkNtuwYjEuwcwOdmZHFwwBtyzxSO6Yv/tsBqzykSTAqz4Hw/qge24KUCNMIdUXz8dY6WIMLBoXo+qop+GPOvv6SH4yGKJSz0hlfGwnem5jmZEdAEsUexFvJkRImvv74pQ+MGh/pMqV77bttnSh8zBG06TmmYEvbgIIVubO4T6uFWo08VSRoJWBT6HJveXgqjwif9a8ImZsyLIf67jwEsDuUe8FvZBV708KHVyjxFlU3AN1n+u6GlsfmMgxYI0bwydMq2PgOCyPttaDX/BHMef30lA4EY87o/dAc9nydAuyOWbFIw3CM9ddmzU+KAKHfBERuFQjagBDL1YH0NHQF4rVbxaqvhU+/Y4UswFm4vHDOsolFnarsXvquVEZOy/hT8fVjwthik4n7Au6+y72pWDdMUnPIK895Kc/+f7lDRASIm7V52FAlVqaUQPurFGwB95B6C9e9hqi6Jxz3l56php7rjgTO4/E6uDrhTrPRMqTZHeRHpfAUaiH4o3yE8VmC39q0sUvNiVa5tOePAQ4KcI9wuO+grkjI6hHbsqvZHnvTB7WORhY3jPur22Sc/GFY8b9Mgc3L0L683CtrM+F01wmT16CafRuIojy1qmZg+Buv64jW5B3jCi7yT3ZhkrJrgpOqfn/5om9Q8QNfhClql/Q0eb1njIbbtdw2dWpKDxrda1o9HxEEgyY5KnfzdWeXpM7Ls/i+IcEn3XeX44xGDrReyBAbjQZLwIWZHy4RzxTjST2X1cVOEn6fQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(1800799009)(451199024)(82310400011)(186009)(64100799003)(40470700004)(36840700001)(46966006)(40480700001)(41300700001)(8936002)(6916009)(8676002)(36756003)(4326008)(2906002)(36860700001)(5660300002)(356005)(316002)(54906003)(86362001)(47076005)(81166007)(70206006)(83380400001)(70586007)(336012)(40460700003)(26005)(16526019)(82740400003)(2616005)(1076003)(426003)(7696005)(6666004)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 19:31:23.9684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f8e9a58-7e19-4a17-e84b-08dbdfc820d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8203
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
Cc: samir.dhume@amd.com, Victor Lu <victorchengchi.lu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

MC_VM_AGP_* registers should not be programmed by guest driver.

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index ea142611be1c..125917c3cba1 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -132,6 +132,9 @@ static void mmhub_v1_8_init_system_aperture_regs(struct amdgpu_device *adev)
 
 	inst_mask = adev->aid_mask;
 	for_each_inst(i, inst_mask) {
+		if (amdgpu_sriov_vf(adev))
+			return;
+
 		/* Program the AGP BAR */
 		WREG32_SOC15(MMHUB, i, regMC_VM_AGP_BASE, 0);
 		WREG32_SOC15(MMHUB, i, regMC_VM_AGP_BOT,
@@ -139,9 +142,6 @@ static void mmhub_v1_8_init_system_aperture_regs(struct amdgpu_device *adev)
 		WREG32_SOC15(MMHUB, i, regMC_VM_AGP_TOP,
 			     adev->gmc.agp_end >> 24);
 
-		if (amdgpu_sriov_vf(adev))
-			return;
-
 		/* Program the system aperture low logical page number. */
 		WREG32_SOC15(MMHUB, i, regMC_VM_SYSTEM_APERTURE_LOW_ADDR,
 			min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
-- 
2.34.1

