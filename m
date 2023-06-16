Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A12FEB64DA
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jun 2023 01:20:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70A8210E572;
	Fri, 16 Jun 2023 01:20:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 280B510E572
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jun 2023 01:20:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsI3EpSOBUOct+z9PE0dfzDPf0aU5yOTVqhr7sWhahDJmSzxAb3ejdkFpDyKtjJbgnS7BwuxRoJQiKPIDQz9AQps67WyL9lrft/oQskxSoP2Xh60uSZuur1zUptvyHHPoHq3vUcK5+flM2kt/UUs/CjzqWL/iH4F/V+mDisD/0B2/miS2L46MF8Pt1IboHcPFZC1hTq1RCGKxyQQjhqBOdRTZsw26v2pKKbRF05OnOUctqcI8NM+L60beOQ+ApJX+CrLLM/SrVEy1anbJdV32S9gVrUnAS75ffQtz7ugfO1n23/hp33DdKWuAlfMd0+wslMxetblBuvNxJNIE4A75Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MIs/wfZTN3NzUd2iA99337PSOqERmLUCOwcLnCcyxk=;
 b=YTipaNkkOGryeXjP1Jl68JgOooPMcrAH0JPyFdgZQhLn/zvJyYlc794FnX4k/1Bro0+Pqthq4aY/URGl+rpQEmrIStleigVep3hJ+wOvGhQe5yWunosTwdhA/kER5azYwoNdiRNEFF6hWkmp82c2/0hiCJfqOLwePYnfJOBXclhbTtECf2XzpS8ES8BePfKiTmB7M7V+k4vctR8qx+YWwE9O3uJImauP6X3UL2XBwS7Q+5TVCvvaQFCLrrG2On3EOXOcZjwg2ZwK9j37/1/mSOt2mkSO/Z989RJvWDooSutzffPXZYm9zdbqSBiKvoD42bQAOtSlxmkZgWi0l9r2kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MIs/wfZTN3NzUd2iA99337PSOqERmLUCOwcLnCcyxk=;
 b=Tg0rY17rYmQgDVYFW4qNBLoaxlSKO779ZM+MMxZVukEh16A7vM9hHs89pcYLh8uqJhvRYvrAV7PP95EpfeLiJE4v8arTeD9hA9kK3lUwBCtr4mkmM+yTLL+8D4kxYXJNHSuZmdPv4e3RKqGjNo+mQek0K/k3iE8XyLXmj7Ie8qk=
Received: from BN9PR03CA0333.namprd03.prod.outlook.com (2603:10b6:408:f6::8)
 by PH7PR12MB5902.namprd12.prod.outlook.com (2603:10b6:510:1d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Fri, 16 Jun
 2023 01:20:37 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::17) by BN9PR03CA0333.outlook.office365.com
 (2603:10b6:408:f6::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29 via Frontend
 Transport; Fri, 16 Jun 2023 01:20:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.29 via Frontend Transport; Fri, 16 Jun 2023 01:20:36 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 20:20:35 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/pm: revise the ASPM settings for thunderbolt
 attached scenario
Date: Fri, 16 Jun 2023 09:20:14 +0800
Message-ID: <20230616012015.3699013-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT003:EE_|PH7PR12MB5902:EE_
X-MS-Office365-Filtering-Correlation-Id: 523d60da-22bd-41db-0549-08db6e07e396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LL3aWuJIcLBbsPe7UxyAldmvFS+2RCkH7Lw+wmVSV4b9NV5U+vhqlLwNxLHi7z1Nu/HWmAmID7rrCeR/0++5vzZGQnYBu/mpJajD4NM5A/C+X27zsgCI+eG4bPzgzG7g9FVkRhu1PRSJ/H/9LGwrZSpPIoThjGRBMv6spim+7cafzfLI5Z5BfQONTS93H2EI4ZFncTQn8yeIg+2EuQnCQ2Ht+Jzpn8VmpL28ebiA9JPcb3cRbEzzGkWEYUyyWP5bMA5JRH3fT08TlUslki8nZd2no/GX+pqtM6T+byxCBFQhBAkx7w6mpGGUe8XhJPQA6FW1FFoD0DgdLF8ZXIVXlpswBzRjeO1INU9o+HsUsC27m3OA5wcNfdLtYwW0E2h5RJLUvTON3VpXVgi0nXl6hKOhHT0uMvvt1qPz0oo2GyGnZxBMA0Q2XNfyf68PH1QyOQIV8X9ozoLCq6Q3BYCfPJ+55jnSoBJJbjzMhoKGMoe7fj8mBXFo1lMeCPQBRSTnVd8okz8ek6FKxk4i7Rlr4FBFOHb14CZeuNtOfAFAMmizvqNC/xJ0q7aFMGc0ZHUqv6NIuXFbPHJAgtjFc2Zv9OcZTs1zSORJDLxaLkIu/sGRAZbXZBwJpUyTPxDtqJ/VgQ+aMHw0N2QNxa10j17B2LNQPBSVipPAdyzGbiM3rW5j4nk6z+yq+G5PbderwvaaaCNJqHaRj0BMssRHBKGpUZAmQYSE3Z55mIOBFRmMElmcWpVZV3EarvMBJocwSGp0eQ81qIoFE5nHupHACI7mxQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(7696005)(8936002)(26005)(40460700003)(8676002)(41300700001)(36860700001)(36756003)(478600001)(81166007)(82740400003)(356005)(82310400005)(1076003)(70206006)(4326008)(86362001)(70586007)(6916009)(54906003)(316002)(6666004)(40480700001)(44832011)(83380400001)(5660300002)(336012)(186003)(426003)(2616005)(16526019)(47076005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 01:20:36.4674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 523d60da-22bd-41db-0549-08db6e07e396
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5902
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Also, correct the comment for NAVI10_PCIE__LC_L1_INACTIVITY_TBT_DEFAULT
as 0x0000000E stands for 400ms instead of 4ms.

Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
index aa761ff3a5fa..7ba47fc1917b 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
@@ -346,7 +346,7 @@ static void nbio_v2_3_init_registers(struct amdgpu_device *adev)
 
 #define NAVI10_PCIE__LC_L0S_INACTIVITY_DEFAULT		0x00000000 // off by default, no gains over L1
 #define NAVI10_PCIE__LC_L1_INACTIVITY_DEFAULT		0x00000009 // 1=1us, 9=1ms
-#define NAVI10_PCIE__LC_L1_INACTIVITY_TBT_DEFAULT	0x0000000E // 4ms
+#define NAVI10_PCIE__LC_L1_INACTIVITY_TBT_DEFAULT	0x0000000E // 400ms
 
 static void nbio_v2_3_enable_aspm(struct amdgpu_device *adev,
 				  bool enable)
@@ -479,9 +479,12 @@ static void nbio_v2_3_program_aspm(struct amdgpu_device *adev)
 		WREG32_SOC15(NBIO, 0, mmRCC_BIF_STRAP5, data);
 
 	def = data = RREG32_PCIE(smnPCIE_LC_CNTL);
-	data &= ~PCIE_LC_CNTL__LC_L0S_INACTIVITY_MASK;
-	data |= 0x9 << PCIE_LC_CNTL__LC_L1_INACTIVITY__SHIFT;
-	data |= 0x1 << PCIE_LC_CNTL__LC_PMI_TO_L1_DIS__SHIFT;
+	data |= NAVI10_PCIE__LC_L0S_INACTIVITY_DEFAULT << PCIE_LC_CNTL__LC_L0S_INACTIVITY__SHIFT;
+	if (pci_is_thunderbolt_attached(adev->pdev))
+		data |= NAVI10_PCIE__LC_L1_INACTIVITY_TBT_DEFAULT  << PCIE_LC_CNTL__LC_L1_INACTIVITY__SHIFT;
+	else
+		data |= NAVI10_PCIE__LC_L1_INACTIVITY_DEFAULT << PCIE_LC_CNTL__LC_L1_INACTIVITY__SHIFT;
+	data &= ~PCIE_LC_CNTL__LC_PMI_TO_L1_DIS_MASK;
 	if (def != data)
 		WREG32_PCIE(smnPCIE_LC_CNTL, data);
 
-- 
2.34.1

