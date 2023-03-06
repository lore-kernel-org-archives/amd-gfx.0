Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB26FC61DA4
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Mar 2023 11:38:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7847010E22E;
	Mon,  6 Mar 2023 11:38:23 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1909A10E22E
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Mar 2023 11:38:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DsDYD7VkNxq3uSBKDwJ2uIr2AYBwk6DQUTuiF53jd/WCaOOJ8Kb6KOJerieEWFdwptG5dG66H928Md2L1lsXbI2+//1KSuwB0XBuZAh0+6hrZ8sO4c0Vg8eomkEsh4fG9QmjcrcQPWaDbGXP0EZy85KaL0UV/5dDdAbr58WhvYayRPlGpecV3FogUatla5fhLIAOGfDBMZ5Lv4df4zRy1Xi2lsj7PgDOD6Es2LChyqtV5v5DNFDCpU6fT2S37KhXCFcBV6LhluaLgedMNGq0TpNs0HwS6mRZmLrTeEsR+B3JOpnuEkdkjn1/aBIslOfV+QexdwY1wGoeThLPKBFH3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNYaF7BjAkIiKf3T17yndoE9C0cO/ZkUGdC43+FXn1U=;
 b=WiqqtOixFlcYPfF6iOKD3y0gi6zUYiQ9Svj6jM3zCUHjjliA1COpGFMua1XxPOU1M1r+sR4CKodiW8yw0EmJOjqUpnIO+kplbPyQvQbDJ+Vzk1dIZr+KVkTWMtuT+dQiGAl1S6AZT7NW+LLOHl4H5r9zVIummp1SbWWNWHwQCPbecQ7KH4vbBDPeY16f4YuOqsRmTAdPkoqdSW6ZkM4fXdtSvjOYPoPHS+R2gySNCyeFQRj7gFdyikVeAvtqi4GT4P+81kBJDtLFFg7Uv8H+nWWgLI7X7cgyGHXj4ok+YpiyFDzFknrqI5l4x9Z1w1PoB5WLr+zoJXGFaiXf0D9aEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNYaF7BjAkIiKf3T17yndoE9C0cO/ZkUGdC43+FXn1U=;
 b=YLNbrvbgO4EmnGE1Lv4iGgxjHwaccYATN+CQRR64+tbNHtoKJQJW2XSYx0Zj0jWmWy8PJSQ58vfG7580LHUOCkX4UAVJy9lnjKAgErEz7t4wSCd/hPBRqFiKfedUdMMenteMnytGG2NmI3PxmZKTKRIRMLKKd96eWu2JXnp+3Io=
Received: from MW4PR04CA0046.namprd04.prod.outlook.com (2603:10b6:303:6a::21)
 by PH7PR12MB6883.namprd12.prod.outlook.com (2603:10b6:510:1b9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 11:38:19 +0000
Received: from CO1NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::7b) by MW4PR04CA0046.outlook.office365.com
 (2603:10b6:303:6a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27 via Frontend
 Transport; Mon, 6 Mar 2023 11:38:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT069.mail.protection.outlook.com (10.13.174.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.15 via Frontend Transport; Mon, 6 Mar 2023 11:38:18 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 6 Mar 2023 05:38:11 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>
Subject: [PATCH] drm/amdgpu: Retire pcie_gen3_enable function
Date: Mon, 6 Mar 2023 19:37:18 +0800
Message-ID: <20230306113718.25513-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT069:EE_|PH7PR12MB6883:EE_
X-MS-Office365-Filtering-Correlation-Id: e375874b-cb09-4bda-2b07-08db1e374837
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YqKqk7ktfZswivYPIIF9qWNpxCBkAY0AVS/D2NsTSoxbhLrKbAdc7kZ5aa0taIoAukrTFiJvi/lMKc1kq+CPGsmVTfkTzVSbzKHS6p4CvkQi4ipPpi/VdEVSdR6dCy8Hc35mXdRyZbJd3nolEyxaW4VdgrJp7vkRJGgeW2yZXfCH7yDutkBZO9TTVPgwWozdLWHlk2lc3ub5zg8l/irrch5FzP2qBuKWTPNqH5OMtint0yFMzTBiOc429IOVPRHoYQ2tOyuYqpO9c10pH2pncpU8WS4/cYNMbglGtSCXpRYqKQfa+a/yxHev/0dZF0a66b2LnVS6R6X0UTKGqkQO+LwGXBoZfAjc4rXho0fC+jYsEGRg4FJZzxMMFt3ffgCoasO/OQXmpQukabZw1usddHQdCcG5tsCA0rEPwYIpDjv06vV2O6JEA5FWUn5AdvF8oFOTfDVLrJG/laaA8k6QMrgcsTPB5lWsFuSnnfgsVVMjCyAJmiF6jCEQamlMkBRz6+NitH4hTq0HcpmJv5hGVhNSxGYyqbkejKxgl/837iGU3q+VcWdKMFuMSoOdjXtOCr10hwMYI4Op+1LOySUoZnOcYgBqvJfRC/8MlKpELDksb59V1fEu3SKQU3chrQHyNE2q8CVqMHTOWNEvK7wdFOhHTdcTVU/BMHFGxzs1p3tvMzm8Vkk3pmD/nTNMG4YbWNsymAhm9mTwMF78lTJb2+PDo5tj0mBD2Jfj4/MYpV4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199018)(36840700001)(40470700004)(46966006)(1076003)(36860700001)(36756003)(47076005)(426003)(82310400005)(356005)(40460700003)(83380400001)(86362001)(81166007)(40480700001)(82740400003)(16526019)(336012)(186003)(26005)(2616005)(41300700001)(70586007)(70206006)(4326008)(8676002)(2906002)(8936002)(5660300002)(7696005)(316002)(6636002)(110136005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 11:38:18.5104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e375874b-cb09-4bda-2b07-08db1e374837
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6883
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Not needed since from vi. drop the function so
we don't duplicate code when introduce new asics.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c    | 17 -----------------
 drivers/gpu/drm/amd/amdgpu/soc15.c | 20 --------------------
 drivers/gpu/drm/amd/amdgpu/soc21.c | 17 -----------------
 drivers/gpu/drm/amd/amdgpu/vi.c    | 20 --------------------
 4 files changed, 74 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 492a8b148227..d56cba10cd5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -519,21 +519,6 @@ static int nv_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk)
 	return 0;
 }
 
-static void nv_pcie_gen3_enable(struct amdgpu_device *adev)
-{
-	if (pci_is_root_bus(adev->pdev->bus))
-		return;
-
-	if (amdgpu_pcie_gen2 == 0)
-		return;
-
-	if (!(adev->pm.pcie_gen_mask & (CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2 |
-					CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)))
-		return;
-
-	/* todo */
-}
-
 static void nv_program_aspm(struct amdgpu_device *adev)
 {
 	if (!amdgpu_device_should_use_aspm(adev))
@@ -1041,8 +1026,6 @@ static int nv_common_hw_init(void *handle)
 	if (adev->nbio.funcs->apply_l1_link_width_reconfig_wa)
 		adev->nbio.funcs->apply_l1_link_width_reconfig_wa(adev);
 
-	/* enable pcie gen2/3 link */
-	nv_pcie_gen3_enable(adev);
 	/* enable aspm */
 	nv_program_aspm(adev);
 	/* setup nbio registers */
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 2c37b49f5c00..1064972dc558 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -609,24 +609,6 @@ static int soc15_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk
 	return 0;
 }
 
-static void soc15_pcie_gen3_enable(struct amdgpu_device *adev)
-{
-	if (pci_is_root_bus(adev->pdev->bus))
-		return;
-
-	if (amdgpu_pcie_gen2 == 0)
-		return;
-
-	if (adev->flags & AMD_IS_APU)
-		return;
-
-	if (!(adev->pm.pcie_gen_mask & (CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2 |
-					CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)))
-		return;
-
-	/* todo */
-}
-
 static void soc15_program_aspm(struct amdgpu_device *adev)
 {
 	if (!amdgpu_device_should_use_aspm(adev))
@@ -1183,8 +1165,6 @@ static int soc15_common_hw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	/* enable pcie gen2/3 link */
-	soc15_pcie_gen3_enable(adev);
 	/* enable aspm */
 	soc15_program_aspm(adev);
 	/* setup nbio registers */
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 21e271877c4c..e56f2bc73930 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -370,21 +370,6 @@ static int soc21_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk
 	return 0;
 }
 
-static void soc21_pcie_gen3_enable(struct amdgpu_device *adev)
-{
-	if (pci_is_root_bus(adev->pdev->bus))
-		return;
-
-	if (amdgpu_pcie_gen2 == 0)
-		return;
-
-	if (!(adev->pm.pcie_gen_mask & (CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2 |
-					CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)))
-		return;
-
-	/* todo */
-}
-
 static void soc21_program_aspm(struct amdgpu_device *adev)
 {
 	if (!amdgpu_device_should_use_aspm(adev))
@@ -714,8 +699,6 @@ static int soc21_common_hw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	/* enable pcie gen2/3 link */
-	soc21_pcie_gen3_enable(adev);
 	/* enable aspm */
 	soc21_program_aspm(adev);
 	/* setup nbio registers */
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 12ef782eb478..2512b70ea992 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1105,24 +1105,6 @@ static int vi_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk)
 	return 0;
 }
 
-static void vi_pcie_gen3_enable(struct amdgpu_device *adev)
-{
-	if (pci_is_root_bus(adev->pdev->bus))
-		return;
-
-	if (amdgpu_pcie_gen2 == 0)
-		return;
-
-	if (adev->flags & AMD_IS_APU)
-		return;
-
-	if (!(adev->pm.pcie_gen_mask & (CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2 |
-					CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)))
-		return;
-
-	/* todo */
-}
-
 static void vi_enable_aspm(struct amdgpu_device *adev)
 {
 	u32 data, orig;
@@ -1743,8 +1725,6 @@ static int vi_common_hw_init(void *handle)
 
 	/* move the golden regs per IP block */
 	vi_init_golden_registers(adev);
-	/* enable pcie gen2/3 link */
-	vi_pcie_gen3_enable(adev);
 	/* enable aspm */
 	vi_program_aspm(adev);
 	/* enable the doorbell aperture */
-- 
2.17.1

