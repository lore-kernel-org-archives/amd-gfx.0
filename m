Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96A4C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Nov 2023 17:37:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A27410E8EA;
	Thu,  9 Nov 2023 17:37:56 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8183610E8EA
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Nov 2023 17:37:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQfXZLRfyaX+3N0pxEcaCe5Z8TofWfySzcyVlBp58It2RTGXmdWKgR2in7/TIPbK2zlBkYQRLpNTlVLF6Jbkk6PNt+J0S+uxQyKZSHA1C1Kqe6hNsJiTBbqx2dvtRAM83RX0w9TEJXxcxSXm+RRKTz6kPXfb2CnJDnX3Ft9tT+B7G0oKrqkjEFZ/gTtFC7cdD2T4VrwgtOHGXUlpya7ncYIkF+Osf1i5dzVFtQNUHVt8zUpXDG0cnBXHcNt5VO7YyKS7PBn1DIeKZ3PJJR4Qwg3qMbf2xSk8V7SY+TWuJhVKH/SeSSo7iJ3dQz1LSHOfDmtIalD8ovRDtyepx9xQvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sIsWutcQ1jEJ6SOQ13KCZMhVpG0uAHRZcO5qZwPQnN4=;
 b=AVQ2wZzIZhSLOSWmGyZVEhU8Z0mOj42RBTutqoOoDxelwiFVjoL6axs64lzzdjDtdAMpsdzPuZcYG9DRooonHLmbFIQgAhUqYlAnjCQyGpenZRBY/s/KyizTecEVGvxFn9F4NcK6jOMH7mYKU/Jpo9ApcvY2asjtf7sYAw89MfmRl9OUVoY1hmtQjc+P9sbg6HKU0PTgJk4A4N7rB8O2Qo93uuJ0/lpAKvfAG7wMILvIIGJpenLi5UQx2MHE1IFeHsKGAFeoAJZ0K1HZG9yiCr5sf2tNvBqkWhdaOLOqByebg1zW9KEMLKV8AUTQMMj04Mum79E211idy2efE30Csg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIsWutcQ1jEJ6SOQ13KCZMhVpG0uAHRZcO5qZwPQnN4=;
 b=ZtNZvv6BlXBep0PyovyvND/beku4xKF8+GvH8PDO7blEc+dUn5rpT8eNPWdAPrHI2RpZ0f4JSRCqPdTyzbHKjMG5gbvhRrsVrskefnRZqNC+3ejCFw/kHucIJlQrabJJz4w5DF3Ohl4lOptEtC/ROOAhw4A7hjvyvN71WYfSRKw=
Received: from MN2PR16CA0033.namprd16.prod.outlook.com (2603:10b6:208:134::46)
 by PH7PR12MB5808.namprd12.prod.outlook.com (2603:10b6:510:1d4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 17:37:48 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:134:cafe::28) by MN2PR16CA0033.outlook.office365.com
 (2603:10b6:208:134::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.30 via Frontend
 Transport; Thu, 9 Nov 2023 17:37:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Thu, 9 Nov 2023 17:37:47 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 9 Nov
 2023 11:37:46 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Explicitly check for GFXOFF to be enabled for s0ix
Date: Thu, 9 Nov 2023 10:27:49 -0600
Message-ID: <20231109162749.38632-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|PH7PR12MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dd332f1-03d9-49f0-d709-08dbe14a96f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4zKJTieFfboz6kHvU2Cd9yW9KHZi5RYhl8p9evsjAdgiXizEgIZNgqcsEooE+7/Tu3JH24lVYsUSkFEhS+04tv6thbAXmoEahZffba0S19b61svcMbXPKsvbxhxEYoR18kUlzOHIFepLR4VippWs8hYmDkuWSE+TClWYz/J3rqPQAJrXYzjRCFrIxCjAcVtHoLnZtn8zXSreWe5ARu1bkYnpaUuzUVAfyp8oztlF1L1tNsJPeyuNl9XNmqykswgwowMd/GTdGteYaI4EUW7Np6y9jAf/Myc/Dx1qbKAM0VoAq9YIIs7rlTbBqxHCypciTzq6atJZKXmMZOII3fBr17mjNy+A8DiHF4WIUN0kXQi+YRSOEonneX6ZYlqLn1DXIECtWPbvnIM1gxL5rEteJHxPCcuO/KxUpshJZWKsCVrwA9gfdL8fiKz95+jAwghJm2S1xF6arld4FCyqOCo9eFsfZk7JLTgdF842ctk/jj3mbUVPsFRsQ8+nnn6DkFZDtm9p3Yl1zPAV2fU0Bs8COVkPyrw2XR70ipCgzzoLAn1n+yLPt70Zk4zKJT+6N12WSr0qWUEPcXQUc0yNSL15t8s2rTX2zaquK6fU3Y62bIPugwQ1aGpmRwtdgcCJzKEfGMIqlLQm90qY9WQr9dMeaEqlE2EVkRLkFX38dFpYFR3GlDDmsXvsGBMkeZq051B13UGnRnJpiYhlfIkyQbD2/Ejpj1DrJ359q/AHn+2YSil3ju1lwzaOK1nMHFs2e3HpU1FVolvXFoNwzHV36BlkllB2vbimkLqAb1gKxO2sRxc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(82310400011)(46966006)(36840700001)(40470700004)(41300700001)(36860700001)(5660300002)(40460700003)(4744005)(2906002)(86362001)(36756003)(356005)(82740400003)(81166007)(336012)(16526019)(426003)(478600001)(83380400001)(70206006)(2616005)(1076003)(70586007)(26005)(316002)(6916009)(47076005)(7696005)(44832011)(8676002)(4326008)(40480700001)(8936002)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 17:37:47.8849 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd332f1-03d9-49f0-d709-08dbe14a96f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5808
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If a user has disabled GFXOFF this may cause problems for the suspend
sequence.  Ensure that it is enabled in amdgpu_acpi_is_s0ix_active().

The system won't reach the deepest state but it also won't hang.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index d62e49758635..e550067e5c5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1497,6 +1497,9 @@ bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
 	if (adev->asic_type < CHIP_RAVEN)
 		return false;
 
+	if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
+		return false;
+
 	/*
 	 * If ACPI_FADT_LOW_POWER_S0 is not set in the FADT, it is generally
 	 * risky to do any special firmware-related preparations for entering
-- 
2.34.1

