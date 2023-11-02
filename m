Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3CB1C4167B
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Nov 2023 09:03:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B11C10E123;
	Thu,  2 Nov 2023 09:03:08 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 737FD10E123
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Nov 2023 09:03:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOyyfgolJY7UuugyXrW1ADuvLN8ORLkP/S06HTSF/M0ipvUdzCKYG0ydnoU/lYyoHhtSLSDC0YMnmdIEqoKENejBtpE2tgy8hrVXBgiV8HwcSFoz8OEffVOwdu8ZnCT1b7LGAYblRBd7u6z0oNbkfw8RdwmOIerv0W9ISq7wGj7fBT6ZVdg2DWzCGXCyBn+FFMYyohjoMnWnV6hrR6mHKRJGpvVfjvDlieRrcV1dE0T31si1K96GysFAALJmp1ML/rZ73H1NKeiuDhaP98vxoEKuk0dtcBQ3sHJhXYm51BiMYe/5Xb1t3z7Y1VUhsRZi+kvidm5W9o/eqshHrQ0TAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4W9LaGj5N8FMjfJWt/Cmkqj/vaKxnNmsJLfPc67dwGs=;
 b=mDzcp5SkKPCU08sO54VmczYHS3sg+30YrVc4HyCVb5i5envxojeA+PHJAlBakKatVP33ZsmEUD6PzIIKrh+ChP7QP8NA4EJkZWXdppq3anJI5Tm9jG1N0UApplCkk1x5AS/xUAE/29oaWqOtI932DtsRdZV0oWF9DNDH0pWQfkNLMkp5aIiZDaftrJnlapZI4KqBWq+Z8QGOrvn/V+QXmdQTxomIbz1jIBmjphW65N6lMSIxXreiyS/yHdPBECNkoSaPQSAaws0kih0YYGY1JelnTMMcqdLTv6r70XGjEadWPCMOOt6quSnouQi1XGMULrf2ekTdrkWSai3QlI+8aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4W9LaGj5N8FMjfJWt/Cmkqj/vaKxnNmsJLfPc67dwGs=;
 b=T2JyiZnDkTRr4avCv2i/qp1g9nWUtaYlM5254lWd1RX/g+aXjKi+9EkwBRqbcq70/hZupozMP4+4wWIMqv/mkziygvctZ1Vv5ZqC1Ne09RtTIwxTPJkxyPRgRP1L1d4rU/ASnAgWHd02Zv3VvXcFwE309wgvxT8vGUzIph34WMk=
Received: from PH7PR13CA0012.namprd13.prod.outlook.com (2603:10b6:510:174::18)
 by SJ0PR12MB6965.namprd12.prod.outlook.com (2603:10b6:a03:448::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Thu, 2 Nov
 2023 09:03:04 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:510:174:cafe::e5) by PH7PR13CA0012.outlook.office365.com
 (2603:10b6:510:174::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10 via Frontend
 Transport; Thu, 2 Nov 2023 09:03:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Thu, 2 Nov 2023 09:03:03 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 2 Nov
 2023 04:03:00 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Don't warn for unsupported set_xgmi_plpd_mode
Date: Thu, 2 Nov 2023 17:02:44 +0800
Message-ID: <20231102090244.12144-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|SJ0PR12MB6965:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a5acd6e-c825-4fa1-8226-08dbdb82859d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lz6WCCIe44z1i3F6Uek8bae7peSsuP8MTlo/vVTjnEwMfZl0mMXIy3u26Ix9mJoSX0S38oAx3RVoLl0pHBGwkWVA3lzPoikrf+Jkx0g7InxOSjscfoRj2EmPZSnzi59+cV8SbBqYagUhZmNicsOMOx8kWIDN3ixchZNETtrMEZeeFSLgbphA6z01FqD1ELkgbiVdajJKFbYmJ7FyDlhFogx1LjYP69LqLdhAYPOSizibn9LDk4i+iewF1R3FNLmfqtw3/hOUtgNcFcTjCLEVZOqT78M//J3lYNPf3stqE0G4cNiL0F+H/do9NmjjOGHYfv5zRt/kNYu2Uyg11RbjKwPtcSZBvVMoycnJeXO6tkQ6M4s16gTy/r4ElHhvmZ82daxncP5fN9E7Zh+JO0yg6b7ys9MP9I/NWgfFso7Vof64waHGHvp8vvlleypNmUwRkIq7ZdgH5R5E155d38uVUv36mM9QDIb7TtO+F9wdlXUaJQvqOUovWEQ7zGbrL1/tX/X8FMKuexuc2oyo8wkgaFOAWK9mblZV0gU+Hv5I45WhpaFupxKFsdfQBcErqNQ2ysnDXpUpjseWglPNniRUdiJHcECSJXijlpz1XEejOsM48JfVkazBlFa4u7imzCXza3ULqXtE36yV6a9ibCDawMwwUVURYU84bbQ6aepIHLrxYOntcRRmgoBnRT7cjWYFy3067rtyqERy+22n4CEZA+hyeeNLV3UsIB2xSa/xBOWBsStYulfVv2p9gn6yLAqBTS9jmBdNNuk8IwsucF+g2Qh63wTSJwiXLyBBrP1jUGc96eXSelfM4nCLk2ILzUId
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(230273577357003)(230173577357003)(230922051799003)(82310400011)(64100799003)(186009)(1800799009)(451199024)(40470700004)(46966006)(36840700001)(36756003)(86362001)(82740400003)(40480700001)(5660300002)(336012)(16526019)(41300700001)(8936002)(83380400001)(4326008)(8676002)(478600001)(7696005)(70586007)(26005)(2616005)(1076003)(6666004)(40460700003)(426003)(47076005)(316002)(54906003)(70206006)(2906002)(36860700001)(6916009)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 09:03:03.6043 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a5acd6e-c825-4fa1-8226-08dbdb82859d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6965
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
Cc: lijo.lazar@amd.com, Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

set_xgmi_plpd_mode may be unsupported and this isn't error, no need to
print warning for it.

v2: add ret2 to save the status of psp_ras_trigger_error.

Suggested-by: lijo.lazar@amd.com
Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 0533f873001b..a5a72e5aae94 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1131,28 +1131,30 @@ static void amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
 static int amdgpu_ras_error_inject_xgmi(struct amdgpu_device *adev,
 			void *inject_if, uint32_t instance_mask)
 {
-	int ret = 0;
+	int ret1, ret2;
 	struct ta_ras_trigger_error_input *block_info =
 				(struct ta_ras_trigger_error_input *)inject_if;
 
 	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
 		dev_warn(adev->dev, "Failed to disallow df cstate");
 
-	if (amdgpu_dpm_set_xgmi_plpd_mode(adev, XGMI_PLPD_DISALLOW))
+	ret1 = amdgpu_dpm_set_xgmi_plpd_mode(adev, XGMI_PLPD_DISALLOW);
+	if (ret1 && ret1 != -EOPNOTSUPP)
 		dev_warn(adev->dev, "Failed to disallow XGMI power down");
 
-	ret = psp_ras_trigger_error(&adev->psp, block_info, instance_mask);
+	ret2 = psp_ras_trigger_error(&adev->psp, block_info, instance_mask);
 
 	if (amdgpu_ras_intr_triggered())
-		return ret;
+		return ret2;
 
-	if (amdgpu_dpm_set_xgmi_plpd_mode(adev, XGMI_PLPD_DEFAULT))
+	ret1 = amdgpu_dpm_set_xgmi_plpd_mode(adev, XGMI_PLPD_DEFAULT);
+	if (ret1 && ret1 != -EOPNOTSUPP)
 		dev_warn(adev->dev, "Failed to allow XGMI power down");
 
 	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_ALLOW))
 		dev_warn(adev->dev, "Failed to allow df cstate");
 
-	return ret;
+	return ret2;
 }
 
 struct amdgpu_ras_block_hw_ops  xgmi_ras_hw_ops = {
-- 
2.35.1

