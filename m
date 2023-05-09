Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 999F4C7EE23
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:07:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2DFD10E3FE;
	Tue,  9 May 2023 22:07:40 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2919510E3FD
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:07:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4uNj062tXPcrrlAA7HxfZvEgxy8+2vPSM87rjA9YimSFdOw//AlPZw+4NQLzMUyi/KyR0z2CtM2uizvgu8etnrRojTnqwFNtuMEXNz7ImVxwH/Q0U6XVpod/DOj2yw4KQS2M/bBXEGYTAU7uep0rRdU5iWSTnoWgIbCDBYT/SwE5JiqidH628Iua2/AhW3AfdMs/+WwI0MGFNg4ZQEdZeijYmTuoLp9kqBDJaDEBl5RwhAGSSNd7I4S0/a7bFIXZ+vT6wyxd8Lc5eLJI28pcw3c2WscQPGCP8MSo+M0dnNdqurkF69zOJBV8MEa9jvuu2Y6MdkvNy/nL8kGZy0Vgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bo1Dra5ihYYG0C+bIhQ/BCUMasYQgg2JiB+gDfjJXwE=;
 b=c/jhLFQBMFLobzgWT8WN9OHXJhGSBfj0jYwc6IjK2wOv3NfDGVmai2S85fn/jr/JMBmtV3TDaRYmeqw5tKR9tNXOQmRLCRlR9f5iPbDzd5Q1NypOHFm1d8Y0WSODXkUhNfEJAJ7TQuBHLRYROneYQ3dv6fJIt4OsifxVPt1oxD/fAAFtdrM7NzTAYBXS6gETh5F2Wp0G4eWrz9/lWa2JvwJuyQvWfTlRR0XntIjYXhFTcZKZs9hXUj5u5IUAcXkF/nuCtko7VAMuawveDRImSbREAtyDKpBB8Hun4AtXT5JW09xQwoULEi0cwm79JEnTDPmgDaIyhvEXNney2B6qow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bo1Dra5ihYYG0C+bIhQ/BCUMasYQgg2JiB+gDfjJXwE=;
 b=1ERbxY3XuKe9CIFPR1Lykcs9oMMAylB0pPGzhVXgPUmwDZ3r3RGRo+9G+wcW+EUDOdokrNt5WFsQ+QLQ+UfwBtv1dXbsbgS4yFP/jsmmfwfOpwd17Qe4hrbkCENVOfj+xdrmCtgGskYr6IywFIVXD1jivKWEEjUlYyn+CJv+mnc=
Received: from BN9PR03CA0349.namprd03.prod.outlook.com (2603:10b6:408:f6::24)
 by CY5PR12MB6226.namprd12.prod.outlook.com (2603:10b6:930:22::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 22:07:33 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::a4) by BN9PR03CA0349.outlook.office365.com
 (2603:10b6:408:f6::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 22:07:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:07:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:07:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/12] drm/amdgpu: Add mode-2 reset in SMU v13.0.6
Date: Tue, 9 May 2023 18:07:13 -0400
Message-ID: <20230509220714.475369-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509220714.475369-1-alexander.deucher@amd.com>
References: <20230509220714.475369-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT028:EE_|CY5PR12MB6226:EE_
X-MS-Office365-Filtering-Correlation-Id: edf2b44b-45fe-4881-23e2-08db50d9ca29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hQHijPgwrFR5LB+9IYhieWYvHoxg5Txf3zkC8NUctqORnwxpzx5Wmb3pC8yGUXkn/0hYS6HQZV4LTAhh337/8rFK136DtHkAqh4mKM9+tQZSg6eYIOPiDXFddpVDsqHnh9VFfupA627ycbMZrTdDdxNKL4/A44hGCxX6+HtIyPuVNI237bf0qjBAAZn+9W+LVppd/Q0epWzuAPjI262Au6wuGdAo5vcWRqVM+1y+nea68cR6XUAF/qHo5jeEBF/JF1X65NpAHu1hkJeein8eITqLSeshwgNNeRzo+jV5Zv4LCui8lEu5CrK6u5RDxETFg8QSnb5UyKm5T3NJ+/u1X71XxIYwWoosdAylCNXoVz06nq/J8lxykALFZIBlpxKJ1/2Sz+ThEUdFFftVOmx+0Iv/BMoI8UILX+Wri8Rvd/usr93Y2+N2kHmyXVyCjPvegmYdwNGEhVm5mxtmY+V19iEyRLUc3uHyJGFfI9sbWUrt/dKBgQ1GjB2OwJUd5HxfAh4VRdjfCWLkMTVWjLuojhyi68Sdizrf1ApukJ8ZLPQkPGy1kOtFpogY/HBUVzYyypqe8JDZ0qs8FIo/j4C9TkneG07j7YnQiEKlybJxCgaCsmy6PjTVyPcZd0+ZQwvTmpJTsPfG+Rf0pBEHIVUWakE7p7CUgsFwVNnAPGiUCiYT/oPIB5os9lH3Vp6BqJEx8kM+QBCjhn+CshMZtbXKdtUt+4LHLhH5yIT3Ectyom0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199021)(46966006)(36840700001)(40470700004)(356005)(81166007)(26005)(1076003)(82740400003)(7696005)(6666004)(2616005)(426003)(83380400001)(186003)(16526019)(36756003)(36860700001)(2906002)(40460700003)(70206006)(86362001)(70586007)(40480700001)(5660300002)(54906003)(41300700001)(478600001)(8936002)(8676002)(4326008)(336012)(316002)(6916009)(82310400005)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:07:33.2563 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edf2b44b-45fe-4881-23e2-08db50d9ca29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6226
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Asad Kamal <asad.kamal@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Modifications to mode-2 reset flow for SMU v13.0.6 ASICs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c               |  9 +++++++++
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 16 +++++++---------
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 9fbfd0811d06..082c1e9308d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -556,6 +556,15 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
 		if (connected_to_cpu)
 			return AMD_RESET_METHOD_MODE2;
 		break;
+	case IP_VERSION(13, 0, 6):
+		/* Use gpu_recovery param to target a reset method.
+		 * Enable triggering of GPU reset only if specified
+		 * by module parameter.
+		 */
+		if (amdgpu_gpu_recovery == 4 || amdgpu_gpu_recovery == 5)
+			return AMD_RESET_METHOD_MODE2;
+		else
+			return AMD_RESET_METHOD_NONE;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 6dcafd04c98d..4b808c0addc2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2024,27 +2024,27 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 
 static int smu_v13_0_6_mode2_reset(struct smu_context *smu)
 {
-	u32 smu_version;
 	int ret = 0, index;
 	struct amdgpu_device *adev = smu->adev;
 	int timeout = 10;
 
-	smu_cmn_get_smc_version(smu, NULL, &smu_version);
-
 	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
 					       SMU_MSG_GfxDeviceDriverReset);
 
 	mutex_lock(&smu->message_lock);
+
 	ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index,
 					       SMU_RESET_MODE_2);
+
 	/* This is similar to FLR, wait till max FLR timeout */
 	msleep(100);
+
 	dev_dbg(smu->adev->dev, "restore config space...\n");
 	/* Restore the config space saved during init */
 	amdgpu_device_load_pci_state(adev->pdev);
 
 	dev_dbg(smu->adev->dev, "wait for reset ack\n");
-	while (ret == -ETIME && timeout) {
+	do {
 		ret = smu_cmn_wait_for_response(smu);
 		/* Wait a bit more time for getting ACK */
 		if (ret == -ETIME) {
@@ -2053,16 +2053,14 @@ static int smu_v13_0_6_mode2_reset(struct smu_context *smu)
 			continue;
 		}
 
-		if (ret != 1) {
+		if (ret) {
 			dev_err(adev->dev,
-				"failed to send mode2 message \tparam: 0x%08x response %#x\n",
+				"failed to send mode2 message \tparam: 0x%08x error code %d\n",
 				SMU_RESET_MODE_2, ret);
 			goto out;
 		}
-	}
+	} while (ret == -ETIME && timeout);
 
-	if (ret == 1)
-		ret = 0;
 out:
 	mutex_unlock(&smu->message_lock);
 
-- 
2.40.1

