Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38AD8C6FD18
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Apr 2023 14:55:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 603EE10E0F4;
	Tue, 25 Apr 2023 14:55:08 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5561810E0F4
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Apr 2023 14:55:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5e3/JWJWqK6Hkz+iZNO7OTysMbKI+TEl6o2qEvRPs4/1jfbg1qimIOPRiHfvKt3AEiaMu76tBUEYccz+U7f54gmk3GD+IhjFxU5isa1ZZ1Ov4pyzVZd4pazlqwZZboHgSqoivLXXbKWy+uK5CI1GJ5JCyzgvNgjXQ8wcRXp1iKIn3Ehb5wN5LjiYHYs4aapjw/wdsXO3wSYuNxRnX7rmsET4cEmxIw9pOXtneL1NukIk220RqGXY2qAne6xnrVj6S9FeP6ivr/VWGDDr65NKLhvG6rqRLM4r1HChr3mCiHCzkt0r6Kt7u4rMelwElFsR9k4KbsjkVKObL13oDzozw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYvGO8OXs+SmOncy9isbcGXtiEIZrU2Hg/lFcPWsMlg=;
 b=iX5ki2kM/rcHpaIv3W8FbIP6Ls8+pPcelHCHNFIZON39YwFg/kkDEl6fog3RNVhLy/wXOsHt9d7AoossbA7ihAW/d0tBk2HfZtgwsv6fU6edhgUPwA3dJAdjPhhymRU1K0CzhgzEUkD0vcD7ORdRaz8HBysF1wnvKmz5beLLbEbslAStdOAbqu+ZoCEFpjQJv4+WwSSFGIk8FWNf6/qGWzzKgODpFdYbVu+Uc6gWzfTBu+I3YqEOZaesN+cNAV8X5QXUFLwuqDQe09gy1sabuvPftG61bmLG9hBQ/LiWWEdN3U1L1c5AbVw8JlJ9+iyw9yHXG3ahzat+3b4yCalm3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYvGO8OXs+SmOncy9isbcGXtiEIZrU2Hg/lFcPWsMlg=;
 b=3TSh5iJLTSn83BPrrFVgUeufPLjrYM33OWx+SKxM+rvzEaIT2waMwJ7sULaMjbl+69Ly/y0QCLsbmuwFPmKFYtJab7miWHMctixZTx7Cs6fo/PcpJWgrQTU7PxCnOh2jwd40q0Ko0SKn5pY2VhoPzMB6xb1j2SvHmDD9yDcfOpQ=
Received: from MW4PR04CA0063.namprd04.prod.outlook.com (2603:10b6:303:6b::8)
 by MW6PR12MB8736.namprd12.prod.outlook.com (2603:10b6:303:244::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 14:55:03 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::47) by MW4PR04CA0063.outlook.office365.com
 (2603:10b6:303:6b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34 via Frontend
 Transport; Tue, 25 Apr 2023 14:55:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.20 via Frontend Transport; Tue, 25 Apr 2023 14:55:03 +0000
Received: from shane-u20.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 25 Apr
 2023 09:55:00 -0500
From: Shane Xiao <shane.xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <felix.kuehling@amd.com>, <hawking.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Enable doorbell selfring after resize FB BAR
Date: Tue, 25 Apr 2023 22:54:44 +0800
Message-ID: <20230425145444.1309838-1-shane.xiao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT023:EE_|MW6PR12MB8736:EE_
X-MS-Office365-Filtering-Correlation-Id: d2aa0941-8049-4d46-b457-08db459d0d02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: afXP1SRf+K6qdu97H3ivjP/vTIISlODJTmUxk2oTf+6ELhynbx1W6r+B06V0TCXRt2iBt8MsIjjKH/Dp4zhvyBHyrisizNYNTWQBISgXVosBLzrfj2ySM0SyJ6YYbz1fur7//rFsldY20PZueYjqjVpwpUcw5d25U1XZaOf/CDvPLxomOkUdgIuj0r0GFSUZYI5G/oxzNL6Z7ZtHJeCXlKGg3s0yTrmZjv30qs3AF/7mKqOG8LFIgIbSoNdIINvL/cKxAC+vz2H0irfTm+8C3CpX0f9EbK7PhyyrQwJ+ehQDl55MiEpLSGYwWXQlX1HQYTePPjL8emyMu1Isx+xac/bQGz0qXLX40lgGzZG4ayTJ8nR/zXuF53O+V12i/CuCzuApPe3ID274Xny9yZrXWyThWcnpNRk7WUU4paRIWU1gTsiLNzvvSgZ2hMjFV+j4X2CbK9pa9SEFfdRljiodXtqWtEbILO51pvVAFaSjb+uG0JuEdPQ927p6Otye664UDvu5YeqLIG7JBlSm9Yqav36dxZMXX8dJgtRa05AWVj9c6dh3wd28RSUwem0xK7b22sqLgK8+2MaVvwy2Opl5Gak1zEgD1/3kaU9PfMW800rcor/0bdozxmwtVDdTWW1DR8GejvGi3hNS5MaRidGgK4Lsb7hIWvvFVywv0A3VdOkhHA0cgG+8/PsH1CWkMuVQa9KepX4sXsd2uzKR915g756yMgvZ1is2z5y31FlM3lpv0w348p7HnuofI09MtHqC
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(82310400005)(41300700001)(5660300002)(8936002)(8676002)(83380400001)(47076005)(186003)(16526019)(26005)(1076003)(336012)(426003)(40480700001)(2616005)(36860700001)(40460700003)(86362001)(356005)(81166007)(82740400003)(4326008)(316002)(7696005)(36756003)(70586007)(70206006)(478600001)(6636002)(110136005)(6666004)(54906003)(2906002)(44832011)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 14:55:03.1801 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2aa0941-8049-4d46-b457-08db459d0d02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8736
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
Cc: Xiaomeng Hou <Xiaomeng.Hou@amd.com>, Shane Xiao <shane.xiao@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
The selfring doorbell aperture will change when resize FB
BAR successfully during gmc sw init, we should reorder
the sequence of enabling doorbell selfring aperture.

[How]
Move enable_doorbell_selfring_aperture from *_common_hw_init
to *_common_late_init.

This fixes the potential issue that GPU ring its own
doorbell when this device is in translated mode when
iommu is on.

v2: Remove *_enable_doorbell_aperture functions (Christian)
v3: Add comments to note that why we need enable doorbell
    selfring late (Christian)

Signed-off-by: Shane Xiao <shane.xiao@amd.com>
Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Tested-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c    | 23 +++++++++++++----------
 drivers/gpu/drm/amd/amdgpu/soc15.c | 25 +++++++++++++++----------
 drivers/gpu/drm/amd/amdgpu/soc21.c | 23 +++++++++++++----------
 3 files changed, 41 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index dabeeab2f2ad..3cc068974bcd 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -531,13 +531,6 @@ static void nv_program_aspm(struct amdgpu_device *adev)
 
 }
 
-static void nv_enable_doorbell_aperture(struct amdgpu_device *adev,
-					bool enable)
-{
-	adev->nbio.funcs->enable_doorbell_aperture(adev, enable);
-	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, enable);
-}
-
 const struct amdgpu_ip_block_version nv_common_ip_block =
 {
 	.type = AMD_IP_BLOCK_TYPE_COMMON,
@@ -999,6 +992,11 @@ static int nv_common_late_init(void *handle)
 		}
 	}
 
+	/* Enable selfring doorbell aperture late because doorbell BAR
+	 * aperture will change if resize BAR successfully in gmc sw_init.
+	 */
+	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, true);
+
 	return 0;
 }
 
@@ -1038,7 +1036,7 @@ static int nv_common_hw_init(void *handle)
 	if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sriov_vf(adev))
 		adev->nbio.funcs->remap_hdp_registers(adev);
 	/* enable the doorbell aperture */
-	nv_enable_doorbell_aperture(adev, true);
+	adev->nbio.funcs->enable_doorbell_aperture(adev, true);
 
 	return 0;
 }
@@ -1047,8 +1045,13 @@ static int nv_common_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	/* disable the doorbell aperture */
-	nv_enable_doorbell_aperture(adev, false);
+	/* Disable the doorbell aperture and selfring doorbell aperture
+	 * separately in hw_fini because nv_enable_doorbell_aperture
+	 * has been removed and there is no need to delay disabling
+	 * selfring doorbell.
+	 */
+	adev->nbio.funcs->enable_doorbell_aperture(adev, false);
+	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, false);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 4d1487a9836c..3221522e71e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -619,13 +619,6 @@ static void soc15_program_aspm(struct amdgpu_device *adev)
 		adev->nbio.funcs->program_aspm(adev);
 }
 
-static void soc15_enable_doorbell_aperture(struct amdgpu_device *adev,
-					   bool enable)
-{
-	adev->nbio.funcs->enable_doorbell_aperture(adev, enable);
-	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, enable);
-}
-
 const struct amdgpu_ip_block_version vega10_common_ip_block =
 {
 	.type = AMD_IP_BLOCK_TYPE_COMMON,
@@ -1125,6 +1118,11 @@ static int soc15_common_late_init(void *handle)
 	if (amdgpu_sriov_vf(adev))
 		xgpu_ai_mailbox_get_irq(adev);
 
+	/* Enable selfring doorbell aperture late because doorbell BAR
+	 * aperture will change if resize BAR successfully in gmc sw_init.
+	 */
+	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, true);
+
 	return 0;
 }
 
@@ -1182,7 +1180,8 @@ static int soc15_common_hw_init(void *handle)
 		adev->nbio.funcs->remap_hdp_registers(adev);
 
 	/* enable the doorbell aperture */
-	soc15_enable_doorbell_aperture(adev, true);
+	adev->nbio.funcs->enable_doorbell_aperture(adev, true);
+
 	/* HW doorbell routing policy: doorbell writing not
 	 * in SDMA/IH/MM/ACV range will be routed to CP. So
 	 * we need to init SDMA doorbell range prior
@@ -1198,8 +1197,14 @@ static int soc15_common_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	/* disable the doorbell aperture */
-	soc15_enable_doorbell_aperture(adev, false);
+	/* Disable the doorbell aperture and selfring doorbell aperture
+	 * separately in hw_fini because soc15_enable_doorbell_aperture
+	 * has been removed and there is no need to delay disabling
+	 * selfring doorbell.
+	 */
+	adev->nbio.funcs->enable_doorbell_aperture(adev, false);
+	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, false);
+
 	if (amdgpu_sriov_vf(adev))
 		xgpu_ai_mailbox_put_irq(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 7d59303ca2f9..0f82b8e83acb 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -450,13 +450,6 @@ static void soc21_program_aspm(struct amdgpu_device *adev)
 		adev->nbio.funcs->program_aspm(adev);
 }
 
-static void soc21_enable_doorbell_aperture(struct amdgpu_device *adev,
-					bool enable)
-{
-	adev->nbio.funcs->enable_doorbell_aperture(adev, enable);
-	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, enable);
-}
-
 const struct amdgpu_ip_block_version soc21_common_ip_block =
 {
 	.type = AMD_IP_BLOCK_TYPE_COMMON,
@@ -764,6 +757,11 @@ static int soc21_common_late_init(void *handle)
 			amdgpu_irq_get(adev, &adev->nbio.ras_err_event_athub_irq, 0);
 	}
 
+	/* Enable selfring doorbell aperture late because doorbell BAR
+	 * aperture will change if resize BAR successfully in gmc sw_init.
+	 */
+	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, true);
+
 	return 0;
 }
 
@@ -797,7 +795,7 @@ static int soc21_common_hw_init(void *handle)
 	if (adev->nbio.funcs->remap_hdp_registers)
 		adev->nbio.funcs->remap_hdp_registers(adev);
 	/* enable the doorbell aperture */
-	soc21_enable_doorbell_aperture(adev, true);
+	adev->nbio.funcs->enable_doorbell_aperture(adev, true);
 
 	return 0;
 }
@@ -806,8 +804,13 @@ static int soc21_common_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	/* disable the doorbell aperture */
-	soc21_enable_doorbell_aperture(adev, false);
+	/* Disable the doorbell aperture and selfring doorbell aperture
+	 * separately in hw_fini because soc21_enable_doorbell_aperture
+	 * has been removed and there is no need to delay disabling
+	 * selfring doorbell.
+	 */
+	adev->nbio.funcs->enable_doorbell_aperture(adev, false);
+	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, false);
 
 	if (amdgpu_sriov_vf(adev)) {
 		xgpu_nv_mailbox_put_irq(adev);
-- 
2.25.1

