Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD5BCE79AC
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 08:37:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1330310E45C;
	Wed, 20 Sep 2023 08:37:45 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BCEC10E45C
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 08:37:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fm3LIM6BNY5R2rRXTt7I7ryPvBrvSx5tAv4gXlspd7F/5o5BNkOUN3/TaqckxeHvO5Zk6lOgWeDDXPey9N9oMenshtuQH2u1P4vVXe8mtuxf6zWJl2w660yB84x2VICpPQ+zaLFjcaTqTuOowyrqY90K76yJjeeQGR52L07TeqrMVUfxxKPLYLvqRlU0Py9CJ2TKd2Sfqve96lSmtBXBbzvf7tEBV0kYGy1fA0faTkz/PKZzOdAWHKvkuF7Peupr/Onvk+YD4SGBZ8ereh9c6tKgIRszn9TTs4+fIIdilil/f4qCFiIrRg0q96Dm7gAu56R+OjyDqzc6hlayA/63cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vKcrzddlhkmz2qDMGyeimWSgtUf0SwlIUt5a/1bKwQ=;
 b=L6Nn45DFiustLuNNOW8MrnDF+MURswrK9xgQFLg1zHd1CtPurtxZQ6d9YqeFXJvlbNyQTRBM4yOnSws9JMfuQ6F0JO/fqyKfmG54rY6JHCEvSBuLAabewXZzNVVWTM5J/xTHG4ypGIQUpFJoiB2FBWDkv4GWWPpZ6eK92HHCmSdm8VEwveWEh2HQylt7IKOWAi7f2eRtMfZj2VUt08f4COi7y9V72e3Lnin2mn0bnQBlxBC/IK876yKBHs0Lrk4ul4n29FH+xt2fEsSNW6jsNIe+pErbNWdiVpBLOQva5AOFO4G4l1MYISjW1PbVhfv0d/5fKJuaDX9H6tgJ5FQwLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vKcrzddlhkmz2qDMGyeimWSgtUf0SwlIUt5a/1bKwQ=;
 b=e2D0KNMDIhozdu9dKTekUmMrhuWMRM3GEH/qi+G+dHn3bunEykeFeJ2KlgAe9laOI1GTgFqbHDrrpMxSDmR2ivbT/JBsGr9CyqzZnsuJjXV+XTI3UtuThTsbdzGnZ79xZYdKgaXnnFOKsSThPuHw1/WBrCaqYK9KhzaVfvsg+t8=
Received: from BLAPR03CA0129.namprd03.prod.outlook.com (2603:10b6:208:32e::14)
 by IA0PR12MB8086.namprd12.prod.outlook.com (2603:10b6:208:403::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 08:37:40 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:32e:cafe::1) by BLAPR03CA0129.outlook.office365.com
 (2603:10b6:208:32e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.29 via Frontend
 Transport; Wed, 20 Sep 2023 08:37:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 08:37:40 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Sep
 2023 03:37:08 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <candice.li@amd.com>, <kevinyang.wang@amd.com>,
 <yipeng.chai@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: print channel index for UMC bad page
Date: Wed, 20 Sep 2023 16:36:57 +0800
Message-ID: <20230920083659.8237-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|IA0PR12MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: a8aef92c-e634-44bf-9e74-08dbb9b4d9ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +dqvL+ayKYy2CifA03F79mDFqJd9z16lebM9fZ2FzGG5dUEMn72Yft6SWsUo82DCKioEyc8HEszJvKqAVXFu9MxqiVDgQZbkESB0s4hTpvufsGxVg11dKVFwf1yjMUvrjDo4oF/4mEIg1HQZfJ6AzJq3nHP0zrIjiOa2e/r3SA8Iq8ifptW///vpIqWWmrwOf1gooz2gvOyga5g+xWclZwAT6IJ9HFiLveH0tArCXsa+TThoaC1Cg7Z/RU1p9+J0c3jPJiVPfSjQ1dwz1XE6AAkH1y6xOIOvEOYmvsEGyM8Q/p1ol/Xz5Pi7bWcrtOWjxcCRlV+cb/t7np0uAdphH2mOPFqS1pqdHsRswPk392S9dRgwKUNGgAh0/I0H+kciv6v07SwmQHjRMUDpCNXiEbJjaXZ0eKGwdFD2toDP5FKpGmODawExPMyeDZ15dABToZYrSOXgN61JSSV4Sg1V8WYZhfaBxoXaFH18cWQfZg5unhjE0yXYImTB6fX9/WKRbg1xUbcFqCUhxb4QiH1claewh9bcjPR4cpVbd5+xBX8oI/xraPyAabNCRrQRa43ULkawcI5TBFO7B646tfXWUBfwcaYndMK9pUu+CImko4BdqSbiBHBe89iy4UhZcOd+rjKeSWLza23Mso0WzJMikublcjQIuI40NyvwjhNUPO+qOy2BN3OhQEhpJo3+9t739eYfcGSUrn28Z7A0QloQXm3OM0IZUmfH1zS3qQjhzWaEXsrdywc+cKwWZN7RemrIsWQxGMLQkCUmPFYY2/m+8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(82310400011)(186009)(451199024)(1800799009)(36840700001)(46966006)(40470700004)(40460700003)(16526019)(2616005)(1076003)(26005)(7696005)(36860700001)(82740400003)(47076005)(356005)(36756003)(81166007)(86362001)(426003)(336012)(83380400001)(40480700001)(110136005)(5660300002)(478600001)(2906002)(41300700001)(70206006)(70586007)(316002)(4326008)(8676002)(8936002)(6666004)(6636002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 08:37:40.1774 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8aef92c-e634-44bf-9e74-08dbb9b4d9ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8086
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Print channel index for UMC v12.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index c6742dd863d4..7714c2ef2cdc 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -240,15 +240,17 @@ static void umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 		/* include column bit 0 and 1 */
 		col &= 0x3;
 		col |= (column << 2);
-		dev_info(adev->dev, "Error Address(PA):0x%llx Row:0x%x Col:0x%x Bank:0x%x\n",
-			retired_page, row, col, bank);
+		dev_info(adev->dev,
+			"Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x Bank:0x%x Channel:0x%x\n",
+			retired_page, row, col, bank, channel_index);
 		amdgpu_umc_fill_error_record(err_data, err_addr,
 			retired_page, channel_index, umc_inst);
 
 		/* shift R13 bit */
 		retired_page ^= (0x1ULL << UMC_V12_0_PA_R13_BIT);
-		dev_info(adev->dev, "Error Address(PA):0x%llx Row:0x%x Col:0x%x Bank:0x%x\n",
-			retired_page, row_xor, col, bank);
+		dev_info(adev->dev,
+			"Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x Bank:0x%x Channel:0x%x\n",
+			retired_page, row_xor, col, bank, channel_index);
 		amdgpu_umc_fill_error_record(err_data, err_addr,
 			retired_page, channel_index, umc_inst);
 	}
-- 
2.35.1

