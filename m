Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE4EBC41513
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 13:34:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8646010E4F6;
	Thu, 19 Oct 2023 13:34:50 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B798110E4EE
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 13:34:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUQaJ4Ct5+O/dCyz38gQFWqGhGZldhR26e/UCpOwYhOLIoYyTO0Z/G+c2rIxaVLUt1DuNj+nqKFBSnakaV3iGpQadxbs+M8mOnSMXlG7ZyougPZgr/ooQ3GYjfb934qKZGxsjgfqIZ604d6GqmKILtCNqWDEaoVcPnTemRdf1gzuvoVyA23BEv1dt+YOWxRPDNPx4lDJmTgHfkIziKGnWhtC0Xdi7X+bsgF/8CPQKCUCvuZ1KzGdcmzyrNgxU+W9GW0ayfLbGoon9Xi1V0cX742lo7bH7Ll0xdsSBV6mtufQyCFHBMA58sY2NSwJ+OYw7gUOhgP3OUkFQznkMsgomw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zyVOpqtWBqm3fmuLzBYsytDwOntui3cS1KPzyoJxqIs=;
 b=Fid5nY4DLocdF2i9FwCsMIIqx5CLidZvhr84qYjzOFJ6wWsyzbIVP9oi6C/7vBwwwOBNCY1F5E7NXVMnVnKZ2Uc3a5Y4mNx5gvIHdUJt1jrqvYp33uavVId77Ako8yAetaJsSPcvDPcLiJJDGSGwsTtNeG8oFca01wWzB8zP9PK0s/CcM8eReVNGDbflqdF5YYJIz/cp5yna0mxsn6ime2lEizO0cLFVqbjmZJfpMidfBGUsr8CpmBxbTwUHdePS6IhjydpVnmFmNg7ArwvHlYmSt6xytN+ASqRmGMTEMi3sVlJOcRBGEjw3cR0eTzdknrkBGuaHZuxX6l6R+wFTLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyVOpqtWBqm3fmuLzBYsytDwOntui3cS1KPzyoJxqIs=;
 b=0gu5uiAinJrO6SP+RVPdqXYShAFa2+YooQ5ER6onsnTIkGK4IJjXZaQ0iusduNiMEOgWSGMRhSu5bA7iEyW3rNRLJHAMTUbOFzjVjdiKNyh8yPXmr6aQM5K2qiGmPKKH2u4sndX5WlcEraC+781Dy1aUQPVTaunQ7TiD9i4VNjM=
Received: from SJ0PR03CA0205.namprd03.prod.outlook.com (2603:10b6:a03:2ef::30)
 by IA0PR12MB8694.namprd12.prod.outlook.com (2603:10b6:208:488::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Thu, 19 Oct
 2023 13:34:47 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::7a) by SJ0PR03CA0205.outlook.office365.com
 (2603:10b6:a03:2ef::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23 via Frontend
 Transport; Thu, 19 Oct 2023 13:34:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.21 via Frontend Transport; Thu, 19 Oct 2023 13:34:46 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 08:34:32 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 06:34:29 -0700
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 19 Oct 2023 08:34:23 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 24/24] drm/amd/display: add interface to query SubVP status
Date: Thu, 19 Oct 2023 09:32:22 -0400
Message-ID: <20231019133222.1633077-25-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019133222.1633077-1-Roman.Li@amd.com>
References: <20231019133222.1633077-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|IA0PR12MB8694:EE_
X-MS-Office365-Filtering-Correlation-Id: 239a569d-733a-44eb-2666-08dbd0a82940
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sHr509a12sEA1EXCza4f7oJCbiyQYp/EFnczXPHFn7F5XFqWl+4Pj3TJiTeuLRevQIzQTo7LvkKAnWXT0uWxGOQpr8vE2uCLc9dG6Jm1A8jBW2Z8dva1Ve8NiwpnepZf0xRjy8yjKOgqA6xSf860XNrcx985Pn46Dl0i/YtughH+Bme4KaZsB4/AHHbPi/TnmPHWGWdarBb54LZV3jXruFlqGvZeTZBsrKGPTH3NRj+Z2E527rPAqCizv7Qs1SFvkmPPU5RfkhOfy/Nj9dSWJKoty4uywp60HxYYXw1w9V5K4rqNZueqhKFKhJx0bKH+R3ngQo269OGrHIZ9A1Cf/tZGS3cOQurPGIzryQEDi8iIexZ2xKiRYDXu/dirouzR7m3GTY4Y8mYp8N8cQujr0KnMtC/ryJD1+usbXXhBomS5X5qcKdCuvS3O86V6ky3682dv64aJQY4x1DCjkf3IMOYlNyxsh3aNS8o6Kva4z9NPisxdHP+sSv3071gucqeDshBSUA0NVuUrzEPrtZPoFqm9yWrmVnMVm6NfUu+31HQcJAGe6y76SifnPQ9XtoRt1XbvZwL+d+qZG0GQWvddV+RPLj1xtAvWbwe8ctKJPsxtgOdaSQkY8K0DAL4olZrEZxt658KgyczIa+pwnmsg692J91ShS9hlcym1EGrAOM+ErtuFFwQkWkpXBeteV1BlGYACQaLMz/aaR5bAVd8Uhl3eXQ7egPJ396P96oVDwYp8zJGM8LMlp7FSaNWGreD+VSUweG3q6eq8K7/Y/89CAw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(2616005)(1076003)(2906002)(2876002)(5660300002)(4326008)(8936002)(8676002)(41300700001)(7696005)(70586007)(54906003)(70206006)(40460700003)(6916009)(316002)(478600001)(40480700001)(336012)(26005)(426003)(83380400001)(47076005)(82740400003)(36756003)(36860700001)(356005)(81166007)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 13:34:46.6647 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 239a569d-733a-44eb-2666-08dbd0a82940
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8694
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, hersenxs.wu@amd.com,
 Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why&How]
To enable automated testing through IGT, expose an API that is
accessible through debugfs to query current status of SubVP feature.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 4 ++++
 drivers/gpu/drm/amd/display/dc/dc.h                       | 1 +
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c     | 3 ++-
 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c   | 3 ++-
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 1259d6351c50..13a177d34376 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -3645,7 +3645,9 @@ static int capabilities_show(struct seq_file *m, void *unused)
 	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
 	struct dc *dc = adev->dm.dc;
 	bool mall_supported = dc->caps.mall_size_total;
+	bool subvp_supported = dc->caps.subvp_fw_processing_delay_us;
 	unsigned int mall_in_use = false;
+	unsigned int subvp_in_use = dc->cap_funcs.get_subvp_en(dc, dc->current_state);
 	struct hubbub *hubbub = dc->res_pool->hubbub;
 
 	if (hubbub->funcs->get_mall_en)
@@ -3653,6 +3655,8 @@ static int capabilities_show(struct seq_file *m, void *unused)
 
 	seq_printf(m, "mall supported: %s, enabled: %s\n",
 			   mall_supported ? "yes" : "no", mall_in_use ? "yes" : "no");
+	seq_printf(m, "sub-viewport supported: %s, enabled: %s\n",
+			   subvp_supported ? "yes" : "no", subvp_in_use ? "yes" : "no");
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index aa4684be1d62..e6e6377a8ce3 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -382,6 +382,7 @@ struct dc_cap_funcs {
 	bool (*get_dcc_compression_cap)(const struct dc *dc,
 			const struct dc_dcc_surface_param *input,
 			struct dc_surface_dcc_cap *output);
+	bool (*get_subvp_en)(struct dc *dc, struct dc_state *context);
 };
 
 struct link_training_settings;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 0e1d395a9340..89b072447dba 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1993,7 +1993,8 @@ int dcn32_populate_dml_pipes_from_context(
 }
 
 static struct dc_cap_funcs cap_funcs = {
-	.get_dcc_compression_cap = dcn20_get_dcc_compression_cap
+	.get_dcc_compression_cap = dcn20_get_dcc_compression_cap,
+	.get_subvp_en = dcn32_subvp_in_use,
 };
 
 void dcn32_calculate_wm_and_dlg(struct dc *dc, struct dc_state *context,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index 9f6186be7cd8..be953cf8103d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -1570,7 +1570,8 @@ static void dcn321_destroy_resource_pool(struct resource_pool **pool)
 }
 
 static struct dc_cap_funcs cap_funcs = {
-	.get_dcc_compression_cap = dcn20_get_dcc_compression_cap
+	.get_dcc_compression_cap = dcn20_get_dcc_compression_cap,
+	.get_subvp_en = dcn32_subvp_in_use,
 };
 
 static void dcn321_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
-- 
2.34.1

