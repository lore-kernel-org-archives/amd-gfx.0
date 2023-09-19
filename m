Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F23CD54AC
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Sep 2023 10:09:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D8EF10E363;
	Tue, 19 Sep 2023 10:09:53 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3C3510E363
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Sep 2023 10:09:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQKoj46IsWOEww9+zRSgCc8wKXj4ZsobvxKJ/Nky5WUYurOSGcL4OALzj3MDUWE4e01RyvMGmplY75W6lnSxFE4qWBX2sx2Htg1EMD3EkuA+YnnijvVMGbygsdwVD+cAHdPLxjmwinl3UEkjs6xZrEK9SvRcK9oufJ00rchOv8x+M8nL2j+9QoQy2PiYPwV8f1yfNN6qSQ3v0nLBgVY4LOxaQoiJnh7N1vwKV023MTdj7fRcSqvPHsj6b8yyiNcr1WDmm2en1el3RCiCNVDUd743jJGczfXBwnLi4/9ylqxfXevmA5+UKloDr0s++dYs9ueemFzKrKVEUrSpJSWmLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vKcrzddlhkmz2qDMGyeimWSgtUf0SwlIUt5a/1bKwQ=;
 b=jBBUYSrURq7wFD6KtmxVri78eT5EbklD6LcnPIGu6v2F8+Uh/Ais9YExVgxL2aWs5PTefSKVkEFcTiUXWX5DmgqBpZ3aTiyLcZIo10sPWH3LY3v38exy0T+pB1zkh+v8TufIAozhDwrIEWbbUXp2+yy5hQco/52vLzqFW+MwCtj3QP1b1zsZmJN0woq9ClR4p6KR4V4IuJToZSJgrQr1f73CJ1FFOkqIMzHlAYTXxkgqzH+xW8iVhkpiQpaEEx/JO1p2CqDbwPgUB6JZY9JYNnA0ptOIuEb4K1EUKQUkPK3J+RZiatR3kLghy6N1wVhkyqqFy3He4IBkFPaWZZiN+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vKcrzddlhkmz2qDMGyeimWSgtUf0SwlIUt5a/1bKwQ=;
 b=yBBP80/Y3ZoTVHbrRdPr9V3c2SX8v0mOc3MPbljcxFhXt0ZBzhtgz5aHvwSVnf6IcZp9FMd65isgstj96H5Nu11971HZ15sf/eIMTwTIAnAhMtGwneOx1nm+1ws+5Q3HldIiy2p1mxgGq/GQoWHgT7QUe3bAA7ZC9MMva1jG4sI=
Received: from DM6PR01CA0006.prod.exchangelabs.com (2603:10b6:5:296::11) by
 LV2PR12MB5821.namprd12.prod.outlook.com (2603:10b6:408:17a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.27; Tue, 19 Sep 2023 10:09:48 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:5:296:cafe::88) by DM6PR01CA0006.outlook.office365.com
 (2603:10b6:5:296::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Tue, 19 Sep 2023 10:09:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Tue, 19 Sep 2023 10:09:48 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 05:09:45 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <candice.li@amd.com>, <kevinyang.wang@amd.com>,
 <yipeng.chai@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: print channel index for UMC bad page
Date: Tue, 19 Sep 2023 18:09:34 +0800
Message-ID: <20230919100936.8810-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|LV2PR12MB5821:EE_
X-MS-Office365-Filtering-Correlation-Id: a60c508a-8791-4ebb-1dfc-08dbb8f88e59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: brfNISTaW8czN28LzoG+fxpQaKf3KX1RBKIk8zx16TKqbDX+E4PIR93XFeipVaA8+vWuOJIndQFbb6JwYfSyrdK0N1Zl29tp3y6PV7v4NQOk/1CL3qowi47aNheMUvqMuNNhMbpF3W/0UeBVts2cqgrNt2nuPQDdmTh29gtG3BGsPtnvwR4AtqQZYHiVmxr5Tu8odaP19IeMaKleDGLLoMNYf/v5gpqUjYKsi7kAp4SBFrMeGluIQAmzOcVyShAdn75ROzYLaMDB+ZjuDetUgkegP3GoL1u6w9E2yfToAMVMOJBMaQbrjd9AUlonR2GPKAInkVgjN+ExKU+IaZz0rNYpWdIQRManEdRTOjrGsGeHxmTgLYfDEydTpD46ld3/40TyrB4GfY2jMhC1VTL/xiKPk/zo5nek1OW+WkkVP9QxgvHrazUE6fQTHudKB+OTKE018oYbPswguK8gR2Wd2KyD1bDtLCqCAkJD2e1UASgou+MQTfrTS7tVNg/8t7sIewFP1ISvMN+4vyuQz95pkZmfo8R4pEms+Ps7TQMgNVCxH/a1F2D1DbmYZ0+qUXOZXw24WMM+1a0oNlB1Pd4BHNV9aKRivEGc2jHtHIs5VIpqFrVXrNzGIkmvUxFC721MUCruK0zYmTOHr+DXcrl3SFYxuzO7XVo/qgB1KivKifIF4Vxn9dRwR1glqFq6oBOudu68Vwv7NsoOlu3pb+dzB8YdHhJaIsXqiYPWzKR5w+c0qxGNOiUb1vC1k90zDc0L0RdAKE2DzbvsHAPZezcgAw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199024)(186009)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(4326008)(7696005)(16526019)(26005)(40480700001)(2616005)(336012)(426003)(1076003)(40460700003)(8936002)(8676002)(83380400001)(2906002)(356005)(81166007)(82740400003)(36860700001)(36756003)(41300700001)(86362001)(316002)(70586007)(6636002)(110136005)(70206006)(6666004)(47076005)(5660300002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 10:09:48.1256 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a60c508a-8791-4ebb-1dfc-08dbb8f88e59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5821
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

