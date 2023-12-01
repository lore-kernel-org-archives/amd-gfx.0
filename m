Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAED7C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:29:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC0EC10E8A0;
	Fri,  1 Dec 2023 13:29:28 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8143310E889
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:29:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RK/s3doHExC/FzB+As2KLa59TA3KcWRlPJ9J+gTq+zqhfGVJuauMDRwDtJvKARGrpx1ITVul/QZricLmouvk3prUiYpCpUd+pBhIxejCsB4nChDnDwZLvq6UBH233dOEhxuwwr6oyX7DSSnVxBJEDygG8tRNSmcZkftw0fAC+aLMcf6WX4zu6XOecK5xMahsQPOz4oHCIg1DKVdhssgZAhrBYxvQnAkAaCKDPLxBESmGW74NfkC/QVSwknz0HsrTTJ2Dcm7v1ekKL1RgpJvm551hEfcopUn1WHCQCi4JXZLx5zNl/IDf6SeY3cjr4AmEPEBAj6pKOOKhCS6UszlfeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huvqNnXKFbRdfVn8ex1yubxEd+h3/ULgvmeiDXAU3+Q=;
 b=A8CkU6jhToHVwqt7UfiKDKu5bu3899KzvUytgMDrzzI19H9Uwz7j1TZYox0KO/6upI9LfkQs8hiCkN95K9XHT9N72fY2z4W+mwgAXgi1X81FKwm63a6C4+qqhSWHda6baJMossV0PxDStlncrnaHhQOJa1guh+ksf8PGxtzT+12PKElsS1+XNdAt24oeEkUeLKIiji2DfuwSymjs/oMb2WAR3xwDI+oZwxzZoUReoLa5AfJP1y6lWBZLh4O9dCWgCQ9ZzKtKwcey++3W1KzEqTuZP8iihU+TuoHm39FA9yFKyJQNzHE70GUnmuFDA+62wtHHC12pvPaPC8zjEkl8yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huvqNnXKFbRdfVn8ex1yubxEd+h3/ULgvmeiDXAU3+Q=;
 b=Yhifrox3FN52OKAm64+Fuczc5UmqaCOGyVAbOgfddvHVzbyqaCO6/e9Usp9riMFTxZTAZ8L3heoNLmEhRLEGi8e9cn2yiXKqQ78Wz2lnZt7NmZOsaRqngfIRqJrmDLeBY7+ilma5Bxq/l4TWn3fjXVD5Q4Ooe4ViunUGN0SU44o=
Received: from DS0PR17CA0007.namprd17.prod.outlook.com (2603:10b6:8:191::14)
 by SA1PR12MB7271.namprd12.prod.outlook.com (2603:10b6:806:2b8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Fri, 1 Dec
 2023 13:29:05 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:8:191:cafe::c5) by DS0PR17CA0007.outlook.office365.com
 (2603:10b6:8:191::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27 via Frontend
 Transport; Fri, 1 Dec 2023 13:29:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:29:05 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:29:00 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 27/47] drm/amd/display: Create one virtual connector in DC
Date: Fri, 1 Dec 2023 06:25:23 -0700
Message-ID: <20231201132731.2354141-28-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
References: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|SA1PR12MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: 216909ab-2366-48cc-b970-08dbf2717da7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tic89sA2z7w8gN73XwRhCIHEFO7RQ46PkmFqEnytxJjI4qFYJy8ax7ezpbXEd/wDRW+C1MuCf0aoYsQQK+eL+qTCTRjcJIwA/6H2DIHLqYt7UmLRmMm0CD6wlQpBHV7Bw8eiPgJV9E6XtT1txGbm2UtbrL073ykk8y/Io3egG0VutqjKep2kDm7Fp+sX+Z/EahvS/oL2kg8o9BftZjiQhsJUaeV3NZuWNX6vMKDlSGNj39/giUbTYYHLkzpU6HQ3ZPMPdymJOqko+rJAzbKNZ6LPqzgfUI5I8eC0IblUpZ2fFOFU+VWy02LpHwLffgvx8jDbq2wJYiI01Eff8Y2djULRXI4sPuYbAk0ajAA8XZrYYgITDS5foqOkXwbb2L6imoruunZ/Yo12NkqI1yQljP8cDATqmW39uEGgLFlzANpsql7jTQLFa6ejqByZ/QcjVtM1N7Jeq+gnGd167k3ITs+o0x6Gh0g+MOSB80Hoo+n6acI1TB495A3Fw8w2ySKs/XlvozQqXlYHfur5Tx3IDSnHx9IpIJTzyaW7Wa8Wu18veOu/HG6WCzqks30x+3gxNgyym5V5sB0K1hVcc9HDbrboDIAvTBr0oAiOK/NtAOSM9Omq8s/q0HK/WKK08T13WVw7PJ8WOZydPzrN4ueVAM4o50J8wISlXj4Ci+j4APf03ZV7+J7tpq/vpX00Tx2YMemkdGzK3bVg73kxSibwFiweQTbA9i+mAxdN6JdeyGqSwOJjYAOpP66iguegBroJTDtvccinRu1tc17jphBJYw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(346002)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(82310400011)(1800799012)(186009)(40470700004)(46966006)(36840700001)(6666004)(36860700001)(40480700001)(8676002)(36756003)(356005)(47076005)(81166007)(5660300002)(82740400003)(8936002)(41300700001)(478600001)(83380400001)(70206006)(54906003)(70586007)(2616005)(1076003)(40460700003)(4326008)(26005)(86362001)(6916009)(316002)(16526019)(336012)(426003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:29:05.5646 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 216909ab-2366-48cc-b970-08dbf2717da7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7271
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
Cc: stylon.wang@amd.com, jerry.zuo@amd.com, Sunpeng.Li@amd.com,
 Harry Wentland <harry.wentland@amd.com>, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 Alex Hung <alex.hung@amd.com>, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Harry Wentland <harry.wentland@amd.com>

[WHAT]
Prepare a virtual connector for writeback.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c     | 11 +++++++++--
 .../gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |  3 ++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8cb92d941cd9..21a7db337d8c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1672,6 +1672,10 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	init_data.nbio_reg_offsets = adev->reg_offset[NBIO_HWIP][0];
 	init_data.clk_reg_offsets = adev->reg_offset[CLK_HWIP][0];
 
+	/* Enable DWB for tested platforms only */
+	if (adev->ip_versions[DCE_HWIP][0] >= IP_VERSION(3, 0, 0))
+		init_data.num_virtual_links = 1;
+
 	INIT_LIST_HEAD(&adev->dm.da_list);
 
 	retrieve_dmi_info(&adev->dm);
@@ -4447,6 +4451,11 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 			continue;
 		}
 
+		link = dc_get_link_at_index(dm->dc, i);
+
+		if (link->connector_signal == SIGNAL_TYPE_VIRTUAL)
+			continue;
+
 		aconnector = kzalloc(sizeof(*aconnector), GFP_KERNEL);
 		if (!aconnector)
 			goto fail;
@@ -4465,8 +4474,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 			goto fail;
 		}
 
-		link = dc_get_link_at_index(dm->dc, i);
-
 		if (!dc_link_detect_connection_type(link, &new_connection_type))
 			DRM_ERROR("KMS: Failed to detect connector\n");
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
index 97798cee876e..5d62805f3bdf 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
@@ -96,7 +96,8 @@ static void enable_memory_low_power(struct dc *dc)
 	if (dc->debug.enable_mem_low_power.bits.vpg && dc->res_pool->stream_enc[0]->vpg->funcs->vpg_powerdown) {
 		// Power down VPGs
 		for (i = 0; i < dc->res_pool->stream_enc_count; i++)
-			dc->res_pool->stream_enc[i]->vpg->funcs->vpg_powerdown(dc->res_pool->stream_enc[i]->vpg);
+			if (dc->res_pool->stream_enc[i]->vpg)
+				dc->res_pool->stream_enc[i]->vpg->funcs->vpg_powerdown(dc->res_pool->stream_enc[i]->vpg);
 #if defined(CONFIG_DRM_AMD_DC_FP)
 		for (i = 0; i < dc->res_pool->hpo_dp_stream_enc_count; i++)
 			dc->res_pool->hpo_dp_stream_enc[i]->vpg->funcs->vpg_powerdown(dc->res_pool->hpo_dp_stream_enc[i]->vpg);
-- 
2.42.0

