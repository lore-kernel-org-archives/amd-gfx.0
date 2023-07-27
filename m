Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE81C001DC
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jul 2023 16:32:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 890E510E190;
	Thu, 27 Jul 2023 16:32:05 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0434810E190
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 16:32:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCzsVKyOvuaI55f1kMdoh5Wn/IaQeepgsIGAOhvoCVUkIOQ90RaZpw3MFUc6g+uwCKiDaWVTKoiwOTwWePepMHnmwUESXKPDGHH2yyp5nnLwSjG+JNMcU+02pmuc7uqUdjqGXH9pvzDDB0A2p/nbGoaRd8ztiXLXb9e6vmySLIEiE2igI8PHnCYoKf0MA+LxcDH1hu05EREEqW+fIWN3r10TFsnzX3v78trCgx5h2EOKDWdgABUbBSxdbI/XrTXsVGWnBd6wgSZT/rpOVnq3je0I06s4ak1k0eCMkYfbcexzsPBhf9G13joMJcFbVzmSSe0wx3liQ03FAzQldFVCag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKOwt89rakEVkNWJFc9tE8m+JLWE/QZoSqZXjA/jch0=;
 b=mxR3tzUVhS7RxPR/oROOPePSCF84ca/aVEw/XvMyCLwwA+OHIbgBS78iuxvh1Bxg/AJ4q/XyvDrfjDKXwGfXjjiwdwHKVZLSoHm00mC/znc6XX6jRpvXu6jUkFf10cmQCMENIju9YR+6qbJrvnq3P8/NeculdUz3HM1iu01EZ1Zu/7VDZp/CZjRW0jopN0F0WcVsi5Oxe8T4DOLv0uziKCk+1z4WlrnGYMAETUQytGwoRGGfI0PUYFg3O+jwda+hzZwnuSfUAG46oRXL6SBNdDX2vDN5OLKksN1Y2tmK6XWFOO0qd/A/xUN9GnAnZbUe91hVaWiGTyFBiQ9K8eYf/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKOwt89rakEVkNWJFc9tE8m+JLWE/QZoSqZXjA/jch0=;
 b=df9azKJJ6F96kB2qrZpZW+DUpyPA8mhSNH+q7zEJJE9ERSKCB4hsSFHQzQLM/RATjsxU1j7e5VJzlS4RxSNoSFa3wcHSjmUoNnm91pSbQf7WGhnF5na+ptg3d5ZnsC9TOteTxnSi18wdhxbOsclJVmQ1VVn86/rJJ1ylWdg9Rws=
Received: from BN9PR03CA0153.namprd03.prod.outlook.com (2603:10b6:408:f4::8)
 by PH7PR12MB8780.namprd12.prod.outlook.com (2603:10b6:510:26b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 16:32:00 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::4b) by BN9PR03CA0153.outlook.office365.com
 (2603:10b6:408:f4::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 16:32:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 16:32:00 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 11:31:58 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH] drm/amdgpu: Move vram,
 gtt & flash defines to amdgpu_ ttm & _psp.h
Date: Thu, 27 Jul 2023 22:01:44 +0530
Message-ID: <20230727163144.2626054-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230725045159.2246417-1-srinivasan.shanmugam@amd.com>
References: <20230725045159.2246417-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT039:EE_|PH7PR12MB8780:EE_
X-MS-Office365-Filtering-Correlation-Id: 248ab65a-e195-4c32-8281-08db8ebf00d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E4Zg3g5fDMNxpJsbMFWURqRzGkz2uOLBwVjWCz/sHod+SjJy3AoGyNOo43mks7cR97RntjXDS40z3PlV/tUao4jrSNOCb/c+2Gtx8PS7dCkX+wkHfo/DjBeRzG06RE6HJa64xrSQ2VT3Fs4e7QeYHmKPfd5LYwFd8FkKaKShpGvfaJy2K1uJWA2NEBEy1+x4CR+Petwk9JoXHsZtMpuklsMSvOS7YobcgC4PQDc4e+oQHw14bjUaGM7pzCGgUf9E8Q9jPW5yQR24JEgB7t3EiOtBVl+zdB+c0hWHDe+CA6VJVF0414cbYy8CBjXfGmK1dtzvJNOmZ8k1iLIdLwpzSoB08+Els7Qd8O9qRQOAwoLapSinUCxmKZ5gJf0Te+QDTOi4HelMcOXiP5Ldq/+uA67PusmFiXdCfeZ+lybGhy0E5FgRq4mIOyZeidVCStrwaZbPN3vSsizXCaYqBWGQLHfOx6gM3zwOm6upa1IBloWF1Nz6+1Am5fWoMqpvNh7VRFDEGIxTQJDFmcxtUpglNB/bDUUo+C9KaUVsgKWvplcL8pR8aawM19dnqC4f/ZhQeRN5rbgfhI0unQRt3AlrRjeDU5advriMmgJy1q76LFXwEUOK4f58qJuzPp5dXP+Lj3yzxb+D2x0XxHcIny6Gzd7upSEkOfm7RbqxMUgr54t4a6LlopNtswh9ikxahFQZbRdYuWlqBPdICpnQwvOUD7O7JAlFsKEjjJ6565E6hYEZkJUf0lwsCI3jVOfC5BFs7YCAnXyb8nFhS3fUwQeWeQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(2616005)(26005)(336012)(426003)(186003)(1076003)(47076005)(16526019)(36860700001)(6636002)(4326008)(70206006)(70586007)(83380400001)(8936002)(5660300002)(44832011)(41300700001)(316002)(8676002)(7696005)(6666004)(110136005)(54906003)(478600001)(2906002)(40480700001)(82740400003)(81166007)(356005)(36756003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 16:32:00.6307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 248ab65a-e195-4c32-8281-08db8ebf00d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8780
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As amdgpu.h is getting decomposed, move vram and gtt extern defines into
amdgpu_ttm.h & flash extern to amdgpu_psp.h

'Fixes: 35488e44ed48 ("drm/amdgpu: Move externs to amdgpu.h file from
amdgpu_drv.c")'
Suggested-by: Christian König <christian.koenig@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 4 ----
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h | 3 +++
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 93d0f4c7b560..a046160b6a0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1524,8 +1524,4 @@ static inline bool amdgpu_is_tmz(struct amdgpu_device *adev)
 
 int amdgpu_in_reset(struct amdgpu_device *adev);
 
-extern const struct attribute_group amdgpu_vram_mgr_attr_group;
-extern const struct attribute_group amdgpu_gtt_mgr_attr_group;
-extern const struct attribute_group amdgpu_flash_attr_group;
-
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 900be3a62cdc..ea4951c08a7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -51,6 +51,7 @@
 #include "amdgpu_xgmi.h"
 #include "amdgpu_reset.h"
 #include "../amdxcp/amdgpu_xcp_drv.h"
+#include "amdgpu_psp.h"
 
 /*
  * KMS wrapper.
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index c3203de4a007..e8cbfacb5ac1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -39,6 +39,8 @@
 #define PSP_TMR_ALIGNMENT	0x100000
 #define PSP_FW_NAME_LEN		0x24
 
+extern const struct attribute_group amdgpu_flash_attr_group;
+
 enum psp_shared_mem_size {
 	PSP_ASD_SHARED_MEM_SIZE				= 0x0,
 	PSP_XGMI_SHARED_MEM_SIZE			= 0x4000,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 6d0d66e40db9..96732897f87a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -39,6 +39,9 @@
 
 #define AMDGPU_POISON	0xd0bed0be
 
+extern const struct attribute_group amdgpu_vram_mgr_attr_group;
+extern const struct attribute_group amdgpu_gtt_mgr_attr_group;
+
 struct hmm_range;
 
 struct amdgpu_gtt_mgr {
-- 
2.25.1

