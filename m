Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A53AFC3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 08:06:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27B7610E1EA;
	Wed,  3 Jan 2024 08:06:47 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2067.outbound.protection.outlook.com [40.107.212.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC90310E231
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 08:06:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUe9iXL2doD+xZwF0RRRKwOAUqc6+vq42QDuY8jbwwnW/9U2ezhWOJZxmAM4u91CufB2khLurff16JYf4icK/CKacNU/RnbHt36OI11Ivvf7Ro/oc+YF91N7ZX5B5b8my51tAhcA82O01zTBpqnQy2D0k2p5W9QNqrUbfeZEv1XTPW3xkHaOdhS5DzO4Vx8YQnRMrm+1BwY2VE5VZ++AjAgezcrMD3Fx3qBZor3zvNLhiI5eViJ1TEarJTOOu0o9JgsXt5QXufIhgaGwBtd4SqsdtTksiDZFTnfqqY5pZCgex6+s5weTLoikPeEmsSeDaxpBCmiM+yhIXkYfgIXlfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azLA1infoGavELbhizU9J7r7xgUreemMwGja7N/qV2s=;
 b=M20f5Azvmz64OS4tGJ3ea8RvX1ppc3j//Ay3m84fdRUI9UXZjQzDNuaUzgcqKq1IUYgorl1l8HSTDke5Vs1d7gYETgKTsTp7f/hM+cY+2+UhrtiY1O1jnxz0zZ8KAmTpcNwBBuEpaADv6DhRsjz0oeg7x8ysSsdhNIRnlhd1wXgd21can01IDYXWLSszFSLTsNGWOkr3kEyMOU/yQn6f1Zgka9soL883YUhusxA/VxbrHd9vDTKiJd8SNGrvBd02WeYXSV9RhP4NsLccuK8/zthWuz2WHX1SqTK2cds5Fvu1jjKBk/FW/jZFdAsy/Maac446orDQ3xZTjLMy71s+Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azLA1infoGavELbhizU9J7r7xgUreemMwGja7N/qV2s=;
 b=GLfWtjIbmvU9ixWGC6RiFrjXShCvqJPifq7qV80qlCW+6GXYK30T9qsiibkKw4oTbl/dP4Ru7lxxjcIk1Lc21Upk81AAtUK1JKF64jVRX4qSfLLxhk8zCFKS/EqugD7v0T8HdJp1yvJ2HsDJLSDzy5jPffrWvDp6IQAmjDxM/g0=
Received: from BY3PR03CA0002.namprd03.prod.outlook.com (2603:10b6:a03:39a::7)
 by IA0PR12MB7698.namprd12.prod.outlook.com (2603:10b6:208:432::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 08:06:43 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::47) by BY3PR03CA0002.outlook.office365.com
 (2603:10b6:a03:39a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13 via Frontend
 Transport; Wed, 3 Jan 2024 08:06:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Wed, 3 Jan 2024 08:06:42 +0000
Received: from lm-srdc-pc1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 3 Jan
 2024 02:06:40 -0600
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdgpu: add param to specify fw bo location for
 front-door loading
Date: Wed, 3 Jan 2024 16:06:32 +0800
Message-ID: <20240103080632.7365-1-le.ma@amd.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|IA0PR12MB7698:EE_
X-MS-Office365-Filtering-Correlation-Id: c15f18e2-5b23-4ec1-cd84-08dc0c32ec02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sxMqp2H6Egg73i8VWXfQU9lXp7MMbndE3lfsdMimTdO8bBcqTIRqKiyKppFgIpnti1U1MPkoNrA/LFffM6Yk6gvWhNmW2iLq2UVhSQRoMfvLzd3/bw9fW+G5NMMxMkigQ6bBvwt3PAJUJ3ZSg7lKYO/0sbOahxP7WFS4nen4EH5CcBDIF6IjAmf63J8z1wKm/KtmoorFESCPuG4xnxTlB1nu/J90Tdub5UUGm9oWXTniVOjBUH7RNmMF6R3/Jhcgn/RpSGZDW0WqMo264BRaOohyQ449gRvMd/qeSwSnqzc3oM8iqBvA4OvfcNv3xJwoHaOXb+kZXvNqlq1hMpcFgvwLpnTtMxgPYK6Qj84lJ/WpfZZRS7f+1yNWaWoUjiQvSDnS4A8vXhVibBXim+PdkfvzF3EI5S8GyLrjMH1EKoGE0QF4fr7b9CZeoOhzP9wsU4g2WfXLz6VWZanxZe3lmZ5BB/XNlv10KSxnLGuCCJmJXBoC3tdO3bDyv7lcs+Ykqq3ncjuGe/AwD6HhzRLW+Pscj9ls89jXpYKkTHYg1+XnVk0fXn1OFvKtWKhLpXlvzw3nwjJ3ssKl9zuqQ9LN5TmghgBObBqRAvKwHLZaudmeggIes10fntpEX+tYZAiAzhzSj6yZQiU7iDdmgCgvKrz4yFBKjWro4Jm5TXeHYl9n/15104xWLrgAOcW9iPViuooTBdhn5sVbZFrfZQ1ZlNlMH3JrT2PSe1E40zJl1Xqi/Gth8LgAilHKktxcleWM/kHsSjsC9MnkRF/axe75kA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(451199024)(1800799012)(82310400011)(64100799003)(186009)(40470700004)(36840700001)(46966006)(356005)(81166007)(36756003)(82740400003)(40460700003)(40480700001)(86362001)(2616005)(336012)(83380400001)(426003)(16526019)(36860700001)(1076003)(26005)(8676002)(41300700001)(7696005)(54906003)(316002)(70206006)(6916009)(478600001)(6666004)(47076005)(70586007)(8936002)(5660300002)(4326008)(44832011)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 08:06:42.5866 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c15f18e2-5b23-4ec1-cd84-08dc0c32ec02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7698
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
Cc: Lijo.Lazar@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This param can help isolating data path issues on new systems in early phase.

Change-Id: I0a972dd74fe2aad6b56628cea32ad72dcd17e283
Signed-off-by: Le Ma <le.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h       | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   | 5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 3 ++-
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 616b6c911767..9da14436a373 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -254,6 +254,8 @@ extern int amdgpu_agp;
 
 extern int amdgpu_wbrf;
 
+extern int fw_bo_location;
+
 #define AMDGPU_VM_MAX_NUM_CTX			4096
 #define AMDGPU_SG_THRESHOLD			(256*1024*1024)
 #define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS	        3000
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 880137774b4e..852cec98ff26 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -210,6 +210,7 @@ int amdgpu_seamless = -1; /* auto */
 uint amdgpu_debug_mask;
 int amdgpu_agp = -1; /* auto */
 int amdgpu_wbrf = -1;
+int fw_bo_location = -1;
 
 static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
 
@@ -989,6 +990,10 @@ MODULE_PARM_DESC(wbrf,
 	"Enable Wifi RFI interference mitigation (0 = disabled, 1 = enabled, -1 = auto(default)");
 module_param_named(wbrf, amdgpu_wbrf, int, 0444);
 
+MODULE_PARM_DESC(fw_bo_location,
+	"location to put firmware bo for frontdoor loading (-1 = auto (default), 0 = on ram, 1 = on vram");
+module_param(fw_bo_location, int, 0644);
+
 /* These devices are not supported by amdgpu.
  * They are supported by the mach64, r128, radeon drivers
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 1bf975b8d083..2addbdf88394 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -466,7 +466,7 @@ static int psp_sw_init(void *handle)
 	}
 
 	ret = amdgpu_bo_create_kernel(adev, PSP_1_MEG, PSP_1_MEG,
-				      amdgpu_sriov_vf(adev) ?
+				      (amdgpu_sriov_vf(adev) || fw_bo_location == 1) ?
 				      AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT,
 				      &psp->fw_pri_bo,
 				      &psp->fw_pri_mc_addr,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index b14127429f30..1f67914568f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -1062,7 +1062,8 @@ int amdgpu_ucode_create_bo(struct amdgpu_device *adev)
 {
 	if (adev->firmware.load_type != AMDGPU_FW_LOAD_DIRECT) {
 		amdgpu_bo_create_kernel(adev, adev->firmware.fw_size, PAGE_SIZE,
-			amdgpu_sriov_vf(adev) ? AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT,
+			(amdgpu_sriov_vf(adev) || fw_bo_location == 1) ?
+			AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT,
 			&adev->firmware.fw_buf,
 			&adev->firmware.fw_buf_mc,
 			&adev->firmware.fw_buf_ptr);
-- 
2.38.1

