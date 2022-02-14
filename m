Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5781AC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Feb 2022 20:49:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D67E310E259;
	Mon, 14 Feb 2022 20:49:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AD6910E259
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Feb 2022 20:49:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddFHNTClConw44KePWzfGWj++MV8a0ibEK78shd1EhQFi5sG+E9LqkeACNGcKytQ4WTulLHHZTPYt8hYEvs8QHKBwg/a1oAdqEVCjJdo7aY1ch+Xoa+uv+igQ/SF6emrgku2FCUmmoh4tbv6DFx7XC14tmLp2UZlpIogVF/jwfcjhuC/CYogZ5d7NTWpuFdN5cSmN/Y21/78KoBpiWj7bt7d9PN/eBrFbCxp36+4kiGtBqXuoc2LJob630mTs+I0gu0dhAb35lrgGpLNg3EyYFMtzUtIyi0UptMzrrHGAmVO/c0Jl8bsn/TmlY7pkHdb+r+SNKc5bEsJlTNGfXKTaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hq+dfgHcZeKsAKOngJQcUHK5H0xJWwWapoEkeg4RBOE=;
 b=Iso3wbJqpYXH5naECS5UpNMY1t2yf5wULxOpnMb1oO69c6E0KiJ4dDuF+vnMFeEfVnfYQVWaFlEVp3p8RRFVj6mJ57XD9qwS+oOsSgddevVgUpEW6lpQ2IGMpj5Sea4NCIlkadTBS86ZFmcG5mKwq5rKt+V7zocozx+9JsJbQNo2VgXFdrEfYp8RqnwSBxrIbbOisNJYwbRjwx5ZO0bXpsoGT2zpSw95DLHF+PpqLQIGi7BJz21lozkp2gbksoC1DXOe7Dj0WUb47tp2DpkKPHngrkdV5CJ5xNPdtrBuBrr+z4DK217oPoHgh+4g/xotYFOX8EqGmP7r6ZkL9dWl0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hq+dfgHcZeKsAKOngJQcUHK5H0xJWwWapoEkeg4RBOE=;
 b=5kGgZvNLnmVmwYnN+99/r55TZAbM6sOAqhqzR2b565VqFPbFNq0bcEdi+602PM930NEwzmY0LC5qLsddHWueKBBVEIQXrz4h/e6fTvG0e3tKmndnEyy3bgurfFvmzBnFnykhgg47BB4YgNfLAr7tVcDc0T0Y7rZa3JfF3efBOL4=
Received: from MWHPR11CA0028.namprd11.prod.outlook.com (2603:10b6:300:115::14)
 by MN2PR12MB4254.namprd12.prod.outlook.com (2603:10b6:208:1d0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Mon, 14 Feb
 2022 20:49:01 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:115:cafe::f0) by MWHPR11CA0028.outlook.office365.com
 (2603:10b6:300:115::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14 via Frontend
 Transport; Mon, 14 Feb 2022 20:49:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Mon, 14 Feb 2022 20:49:00 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 14 Feb
 2022 14:48:59 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: make cyan skillfish support code more consistent
Date: Mon, 14 Feb 2022 15:48:47 -0500
Message-ID: <20220214204847.2096329-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2596144c-6fd5-43cd-8a46-08d9effb6de4
X-MS-TrafficTypeDiagnostic: MN2PR12MB4254:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB42545CD2838815A084F32909F7339@MN2PR12MB4254.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l4PjmN734ywOfmHFKDl0OZc0F0hdWHnDMXaJSJJAf5wJM/9BO93Ps2JnZE7doutQ0nkOt7SK4KV0yBTiujtfsfaGZDMP+Q0NHiNPNH/rHjxaDSsvGss60kvEFiCk+T9t1UKRqdJ8VHV4tS1d0uFp8yeqoCi92YO4i2z0HT0976OQ3jh+zWz/0s7YQ555KB4SOYLcvtwX01BroFNBW54ixvfo0VebeUkLlLy9XVIkJ/9p7X3fRlCz2I+8t1j+aNTwmTiQJNUXM8cxmkz+XE6vW5qPG7eXhFukNDSdo5g6DTBth4IONhDutjJhY4gtnP831RkTrogCOqD213d/R6dTd78tmbBuGl83bSZYrYWJ3rg3YIRx9X9vNuXgnBCpeeph1EX2mcQhoJjIF2RDkwVu4OF5mGiOX8JYlzzJPfs3SGtILTw2AlLbkFVOSVm8LRrcKaoUi9/wtgm0816FDg9OnNCNtzt66OWzKhI2v7Z1jMRpGbrNr4TdwiljntbQD798qUp4JCub9hRzdyLz3zVxm533l7bWjd7Da+nDzLwi9NPV5p2pe25WMzUWKr02AZ+/tQxMfnvsxmLiNoZ0glG1wuvHuuz4GBQPxuZAailhbks1sIHaGJYRM8MQrqS/qgVpx5SPAliYELqRYcBmDOKg/r1QrCDph9QB+MrjoSMA6c66ctZDmsROlvk8cPi1tztF4VG54k4h5Pua9VpjRjdk5A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(4326008)(186003)(70206006)(2906002)(8936002)(5660300002)(82310400004)(86362001)(36756003)(356005)(81166007)(16526019)(70586007)(8676002)(1076003)(47076005)(426003)(336012)(36860700001)(83380400001)(2616005)(40460700003)(26005)(508600001)(6666004)(316002)(6916009)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 20:49:00.7597 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2596144c-6fd5-43cd-8a46-08d9effb6de4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4254
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Since this is an existing asic, adjust the code to follow
the same logic as previously so the driver state is consistent.

No functional change intended.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 3 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 4 +---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c     | 3 +--
 5 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ff3b57fe5232..9f1b2ee54706 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1452,7 +1452,8 @@ static int amdgpu_device_init_apu_flags(struct amdgpu_device *adev)
 	case CHIP_YELLOW_CARP:
 		break;
 	case CHIP_CYAN_SKILLFISH:
-		if (adev->pdev->device == 0x13FE)
+		if ((adev->pdev->device == 0x13FE) ||
+		    (adev->pdev->device == 0x143F))
 			adev->apu_flags |= AMD_APU_IS_CYAN_SKILLFISH2;
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 5cdafdcfec59..a0b5cf9a41cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1923,6 +1923,7 @@ static const struct pci_device_id pciidlist[] = {
 
 	/* CYAN_SKILLFISH */
 	{0x1002, 0x13FE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_CYAN_SKILLFISH|AMD_IS_APU},
+	{0x1002, 0x143F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_CYAN_SKILLFISH|AMD_IS_APU},
 
 	/* BEIGE_GOBY */
 	{0x1002, 0x7420, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BEIGE_GOBY},
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 9bc9155cbf06..f2806959736a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -137,8 +137,7 @@ static int psp_early_init(void *handle)
 		psp->autoload_supported = true;
 		break;
 	case IP_VERSION(11, 0, 8):
-		if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2 ||
-		    adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 1, 4)) {
+		if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2) {
 			psp_v11_0_8_set_psp_funcs(psp);
 			psp->autoload_supported = false;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 8fb4528c741f..dfbe65c1ae0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3956,14 +3956,12 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 		chip_name = "yellow_carp";
 		break;
 	case IP_VERSION(10, 1, 3):
+	case IP_VERSION(10, 1, 4):
 		if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2)
 			chip_name = "cyan_skillfish2";
 		else
 			chip_name = "cyan_skillfish";
 		break;
-	case IP_VERSION(10, 1, 4):
-		chip_name = "cyan_skillfish2";
-		break;
 	default:
 		BUG();
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 45e10d5028c5..81e033549dda 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -264,8 +264,7 @@ static int sdma_v5_0_init_microcode(struct amdgpu_device *adev)
 		chip_name = "navi12";
 		break;
 	case IP_VERSION(5, 0, 1):
-		if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2 ||
-		    adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 1, 4))
+		if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2)
 			chip_name = "cyan_skillfish2";
 		else
 			chip_name = "cyan_skillfish";
-- 
2.34.1

