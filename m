Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D7CC0015E
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 15:09:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A965D10E45E;
	Wed,  9 Aug 2023 15:09:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::616])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3B6F10E460
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 15:09:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXOSdiP+9kfAmdhsS9avYmYy8b7uzAT1/2M043J+zLemf1sDzuw/sPqmHIL1PDVAkXyc7M3zbDr9lj43m0xcgudQqIAWbKfsz5UGLet4rxYAMefjNQgAPN2crb7mUJt0dy1SeH28Cqujo10O7F4JRfCeaCWc0TmD7jHQe03hZV5aE36okTdAOcImSgx039tzYe/eGA13vb1cxOLQseNMCR68AmZ8X/G4cO7UHT09sJDRap6djGXbMZuQ6iGpSBM4DNB6kQA9+h1jbOCtBmKhP2E7zeBZYIIViddpA7vKKrQPbeUJ+JxMKcUcL7O6XIe4spKkY7qer9uhLS+w4w4fCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AaN14K4pxAAK9XOLJ6mWftlDSNB/1AQQW3N0zcNIWwk=;
 b=JpbXPUwayuIi57/nJe2fcsKNF4aGZm20SJ6tngPBEmhmz/Jl4U2Vcyeozk/ClWOwKHiHoqChLhbX8tc4oVa+aLVDt5aHvm1DSpW8JvSuSU/xnN6TYS5/dAWDHSVsqOiG9GRnOk461ySMLrbuAueh0Q8neU1FxKMC9FM+5osWXz+yF8DMmlzo1SLGla9pv8sZUSQQufag+bOKuXRVxsX0FRy9QiS3FPOPKCpBCnM3ulJK8OOyoRkcm3YB0l91Cy3gnP0R6axCXqDZQOo06AgmmJl74jSK6i3Vp0yc9CVzX6fFG19y8m9DeTIwoOtBhn/WooUUVTnmR4kj5QOcDvEdpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AaN14K4pxAAK9XOLJ6mWftlDSNB/1AQQW3N0zcNIWwk=;
 b=d+OA6+6eXtxd6FxckIu41nNu5+TNROxhP0aUfTfoixNHw9MPgfccQQ19k40C0CbxPrYM9P93EqOLtJdlOCB9TfzgH8G6GYDNY+qNFiVXIxz1jpDNfdsdftAzNlVA0Q9PhcLOYX/YlWxk12sG1ekCqHDawwEvisrd3LNwPnOeBOg=
Received: from CYZPR02CA0014.namprd02.prod.outlook.com (2603:10b6:930:a1::16)
 by DM6PR12MB4058.namprd12.prod.outlook.com (2603:10b6:5:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 15:09:01 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:930:a1:cafe::ed) by CYZPR02CA0014.outlook.office365.com
 (2603:10b6:930:a1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Wed, 9 Aug 2023 15:09:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 15:09:01 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 10:08:56 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/15] drm/amd/display: Remove freesync video mode amdgpu
 parameter
Date: Wed, 9 Aug 2023 23:05:03 +0800
Message-ID: <20230809150620.1071566-14-stylon.wang@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809150620.1071566-1-stylon.wang@amd.com>
References: <20230809150620.1071566-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|DM6PR12MB4058:EE_
X-MS-Office365-Filtering-Correlation-Id: 44285c69-4880-464d-1d73-08db98ea9026
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UpOxMDnTH6jIRzBOE312eSoagshJR0NxZ3fnh+zXElgiG8xaxqVmvPejVWk83Acr51nQlbIVOtXdl5yHWp6Hta5fawxdjgSkdle2HFSYarWLDT40ul4cvKxDXalt2aKWFTrL6W8p6sYd6+lCSjSePRvtNzl5jTkLLJ7dO++sh0SgMFkZjcWnbxpC6PfMzPQrHRhR7lNez+jbPIdhT7Yi8bfcZ/O9eMcEGLtaxbxNDnTFLXFd5Xe3FV6NDZmZpUB5kbV4/WKtr5tA5Ei/vaucMXLKXV9jM5gO66IeWSm3vpZYRG/Ysk2K+LyYPQC0mLz0m1obz8SwSqe0Upt5h/f3Z/SzWfz8hsb24Nbn1bh3QKED7JJy4SngBNnFVyq3MUGvn6mK+Yaso7bYZZ8bwKHrnu+V+ZWNrDdzTBch8KroXm+vfUhCpyco526yqxJBuNSeAb9kYq0YPvr6elfL9NrCzMzyPJTvhzTDFI3gpp3ruLWjFXqmzmv9ftVfPGt+Kt1HF7R3TzNKdEslV1VoJzwb46ga+tMDK4DTFP0fJymCb099zSvleJ9q3KoBdxF01zFhdiEBTM8bqvpewFEhg7G8U9qg8O7xe8ZNE34b+Pp2/tLKfX5reDpcuWLv3BX+VApIXCc01pfV6Xo2fU1WBAwEYMl4Wo4ins1Ke1bKOnLKueUxEqEe3npcsJgiLgmVIZBDpfkjNo9DbdYCXmaFwYPTHsS9xHtC+iwikWunG1zj2rnW8rKIU08AUlUtnsw+hwAZXKhEP3kyn3eSfasQ23XB7w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(1800799006)(186006)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(426003)(2616005)(478600001)(336012)(1076003)(26005)(16526019)(82740400003)(54906003)(356005)(81166007)(6666004)(83380400001)(70206006)(70586007)(7696005)(6916009)(4326008)(47076005)(36860700001)(44832011)(40460700003)(316002)(8676002)(8936002)(5660300002)(41300700001)(2906002)(86362001)(40480700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 15:09:01.0149 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44285c69-4880-464d-1d73-08db98ea9026
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4058
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why&How]
Freesync Video mode was enabled by default. Hence no need for the module
parameter, so remove it completely

Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 27 -------------------------
 2 files changed, 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 2e3c7c15cb8e..4de074243c4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -193,7 +193,6 @@ extern int amdgpu_emu_mode;
 extern uint amdgpu_smu_memory_pool_size;
 extern int amdgpu_smu_pptable_id;
 extern uint amdgpu_dc_feature_mask;
-extern uint amdgpu_freesync_vid_mode;
 extern uint amdgpu_dc_debug_mask;
 extern uint amdgpu_dc_visual_confirm;
 extern uint amdgpu_dm_abm_level;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 0fec81d6a7df..8f7d0f8e57ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -187,7 +187,6 @@ int amdgpu_mes_kiq;
 int amdgpu_noretry = -1;
 int amdgpu_force_asic_type = -1;
 int amdgpu_tmz = -1; /* auto */
-uint amdgpu_freesync_vid_mode;
 int amdgpu_reset_method = -1; /* auto */
 int amdgpu_num_kcq = -1;
 int amdgpu_smartshift_bias;
@@ -885,32 +884,6 @@ module_param_named(backlight, amdgpu_backlight, bint, 0444);
 MODULE_PARM_DESC(tmz, "Enable TMZ feature (-1 = auto (default), 0 = off, 1 = on)");
 module_param_named(tmz, amdgpu_tmz, int, 0444);
 
-/**
- * DOC: freesync_video (uint)
- * Enable the optimization to adjust front porch timing to achieve seamless
- * mode change experience when setting a freesync supported mode for which full
- * modeset is not needed.
- *
- * The Display Core will add a set of modes derived from the base FreeSync
- * video mode into the corresponding connector's mode list based on commonly
- * used refresh rates and VRR range of the connected display, when users enable
- * this feature. From the userspace perspective, they can see a seamless mode
- * change experience when the change between different refresh rates under the
- * same resolution. Additionally, userspace applications such as Video playback
- * can read this modeset list and change the refresh rate based on the video
- * frame rate. Finally, the userspace can also derive an appropriate mode for a
- * particular refresh rate based on the FreeSync Mode and add it to the
- * connector's mode list.
- *
- * Note: This is an experimental feature.
- *
- * The default value: 0 (off).
- */
-MODULE_PARM_DESC(
-	freesync_video,
-	"Enable freesync modesetting optimization feature (0 = off (default), 1 = on)");
-module_param_named(freesync_video, amdgpu_freesync_vid_mode, uint, 0444);
-
 /**
  * DOC: reset_method (int)
  * GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)
-- 
2.41.0

