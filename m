Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04877C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 08:13:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5356110E8A0;
	Tue, 14 Dec 2021 08:13:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC86E10E8A0
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 08:13:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ilDLu4ecM72wBBPCCAt3I6HrvDPb/Guz60hSl62ARaiod67rMZaA2AaepFMcO2lYuMdfPLs2RLv4w3OJBGLZ4OJMuZNQ+SmWBkwgbnvk0SDJN0gizeZo0NIBMgDuJUlQhFO7w325kmWiWlcLYPQVDA3adJ5VeSA4qT+RJtGDLmKkv1jsVRba+9jWyzMFoOzOK+XrvOqFip6ELFtGxcxFTdUZbUU36g9xK/Z8KJA/s0V7ePY6cKPEjccIYy9yag4c+PhcSJDr8Csp4OrjijL/9LntOym2Wcsxsw70DmMDpL0BNtbmBzR172t5KuTd05pCZxlf8BpBbkSiYnw9b/mZ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJ1H9ZFJBTKMYVoeEPWs65VOjIZaB6UoIhYEiop+8IE=;
 b=aHBAn2kmXo4kpVx6bamAUaUJFWJqBaEUzlsZBzNI+5JPwPYtLpT8c+YSG5wsAEFo3IFs25op3Br1INgyTkXX/k8MXdrxT7xDQG1XvSAHi7cMRtN/c24dpBWt5RuMiW1/gBmmpjQsER4gPt+te/VTD2xy+t7M2tpigUVmd5Spq4nC7vlSkfmWUF/Soe4GjZTFh0HT40pIeqlWM8PwHc9rz1DAsTgiIAWxIFb0rnOoX6/bRPEPP4qE/wFGshqtHDWx+rTBS+a20nCQ/8XiWrKPmYTx7oNJXx9d9QS054tXPRRsLYMor+LPPpJ+N31W6FfMlLmh+uR5UsGCXaB+wnI7qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJ1H9ZFJBTKMYVoeEPWs65VOjIZaB6UoIhYEiop+8IE=;
 b=f5L9YBSS3hYBaHhQjJiWFhjgonBuSuAauFpOYQGOPhC7fh1mO58nE3cC4+pGezG21RAfu7cQUlSWbWUr//8QbmJsEb+yOyNF36bywaVnTbYlqGUo+/dDD5I1gLQqKtuiBdkMKf+S8rZfm1NnvyPCKRP55nVFNqhKjW7aFFH+dX4=
Received: from BN9PR03CA0574.namprd03.prod.outlook.com (2603:10b6:408:10d::9)
 by CH0PR12MB5386.namprd12.prod.outlook.com (2603:10b6:610:d5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13; Tue, 14 Dec
 2021 08:13:38 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::d7) by BN9PR03CA0574.outlook.office365.com
 (2603:10b6:408:10d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Tue, 14 Dec 2021 08:13:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Tue, 14 Dec 2021 08:13:38 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 14 Dec
 2021 02:13:33 -0600
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/display: refine error handling for
 dm_dmub_sw_init()
Date: Tue, 14 Dec 2021 16:13:17 +0800
Message-ID: <20211214081317.337359-2-lang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211214081317.337359-1-lang.yu@amd.com>
References: <20211214081317.337359-1-lang.yu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 897921d7-8fb8-477a-f02f-08d9bed9a1e2
X-MS-TrafficTypeDiagnostic: CH0PR12MB5386:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB53869852DD3754C3AFC10B9FFB759@CH0PR12MB5386.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CM9haSTfpGUj6JDebXBOSEd/pViftPHuhdbDJiRCZp/w3d3ua8YKlUmb1qB3qG/OSrId0ih63QAB1ZQoEOd3WwOVHVj/dNYXAtHAnqhKWbkshnz8waGrEwVIgjNdrnrcFojbzYQLXRHiqTWt3rmpeDlUUURDV0FXlGynxhPJ6OVGZUQ1mnmF3FilKgZC+KDReBSdKq4qi2oR5iyA4xY96ITWO1chAxRHoXxdwJ6zgmlzoc2W5lB74ex8nAuM1TpECzroaKdWhqvpgU0bNoN2tA83ELJNxm6L4yGEtPi73lXU4C8yLBJ6M8z0jJwph7CE2aXRM0WtBGRrQN8HjImRJ3bvtgD2jzupIT54FnQU1hVqdyx5J+xOwTXoiwIlaqKmE+ZmrkVnk6B+m/vvOxuFzUp305yicI5ElfGhpxoSvmAUf8pKsMouKOv4vVrCPMK7+QcTV9/SmNb1oI2Pl1rvBCFeFEYfWquEvxOxeKeZENdRdOlIZacTLheRR844iJGC1gFGukDOv2DfIXAWcXtSk5joCim0oKDnqf9oL8u/PI/GxjiqEJcupil3gENogNaQCrAJ4L1BXmy42bWtEz3J7/EMSxknCI6Du9NPihNurcxUdVXUY5Ho81ROmLMBsEv0BJnZaQCdRvQ6WRCnbtD/HUrwgb088uXp5xS1/RyQsVtN8zhrYhlvo/Vuerk2u/vt8TYqrLx4EzoIMUPSN0fmxUf0xLiHvi8uah3o4e+TXjQRwqf9PKahpRPCoy4FH1fYN8sjjKgnt6gSSMDuVGrtNzyUOmIZ7iKwS6rGDuu5p90=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(186003)(2616005)(54906003)(16526019)(83380400001)(336012)(2906002)(5660300002)(81166007)(47076005)(1076003)(26005)(426003)(6916009)(4326008)(8936002)(316002)(6666004)(36860700001)(86362001)(44832011)(82310400004)(70206006)(7696005)(70586007)(36756003)(356005)(8676002)(508600001)(40460700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 08:13:38.2241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 897921d7-8fb8-477a-f02f-08d9bed9a1e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5386
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lang Yu <lang.yu@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To avoid potential memory leaks, refine error handling for
dm_dmub_sw_init().

Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 37 ++++++++++++++-----
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8f6766542c73..ef6800dc0215 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1890,19 +1890,19 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 
 	default:
 		/* ASIC doesn't support DMUB. */
-		return 0;
+		return -EINVAL;
 	}
 
 	r = request_firmware_direct(&adev->dm.dmub_fw, fw_name_dmub, adev->dev);
 	if (r) {
 		DRM_ERROR("DMUB firmware loading failed: %d\n", r);
-		return 0;
+		return r;
 	}
 
 	r = amdgpu_ucode_validate(adev->dm.dmub_fw);
 	if (r) {
 		DRM_ERROR("Couldn't validate DMUB firmware: %d\n", r);
-		return 0;
+		goto release_firmware;
 	}
 
 	hdr = (const struct dmcub_firmware_header_v1_0 *)adev->dm.dmub_fw->data;
@@ -1926,7 +1926,8 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 
 	if (!dmub_srv) {
 		DRM_ERROR("Failed to allocate DMUB service!\n");
-		return -ENOMEM;
+		r = -ENOMEM;
+		goto release_firmware;
 	}
 
 	memset(&create_params, 0, sizeof(create_params));
@@ -1939,7 +1940,8 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 	status = dmub_srv_create(dmub_srv, &create_params);
 	if (status != DMUB_STATUS_OK) {
 		DRM_ERROR("Error creating DMUB service: %d\n", status);
-		return -EINVAL;
+		r = -EINVAL;
+		goto free_dmub_srv;
 	}
 
 	/* Calculate the size of all the regions for the DMUB service. */
@@ -1963,7 +1965,8 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 
 	if (status != DMUB_STATUS_OK) {
 		DRM_ERROR("Error calculating DMUB region info: %d\n", status);
-		return -EINVAL;
+		r = -EINVAL;
+		goto free_dmub_srv;
 	}
 
 	/*
@@ -1975,8 +1978,7 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 				    &adev->dm.dmub_bo_gpu_addr,
 				    &adev->dm.dmub_bo_cpu_addr);
 	if (r)
-		return r;
-
+		goto free_dmub_srv;
 	/* Rebase the regions on the framebuffer address. */
 	memset(&fb_params, 0, sizeof(fb_params));
 	fb_params.cpu_addr = adev->dm.dmub_bo_cpu_addr;
@@ -1990,16 +1992,31 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 	if (!fb_info) {
 		DRM_ERROR(
 			"Failed to allocate framebuffer info for DMUB service!\n");
-		return -ENOMEM;
+		r =  -ENOMEM;
+		goto free_dmub_bo;
 	}
 
 	status = dmub_srv_calc_fb_info(dmub_srv, &fb_params, fb_info);
 	if (status != DMUB_STATUS_OK) {
 		DRM_ERROR("Error calculating DMUB FB info: %d\n", status);
-		return -EINVAL;
+		r = -EINVAL;
+		goto free_dmub_bo;
 	}
 
 	return 0;
+
+free_dmub_bo:
+	amdgpu_bo_free_kernel(&adev->dm.dmub_bo,
+			      &adev->dm.dmub_bo_gpu_addr,
+			      &adev->dm.dmub_bo_cpu_addr);
+free_dmub_srv:
+	kfree(adev->dm.dmub_srv);
+	adev->dm.dmub_srv = NULL;
+release_firmware:
+	release_firmware(adev->dm.dmub_fw);
+	adev->dm.dmub_fw = NULL;
+
+	return r;
 }
 
 static int dm_sw_init(void *handle)
-- 
2.25.1

