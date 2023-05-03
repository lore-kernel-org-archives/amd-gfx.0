Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8093C77B75
	for <amd-gfx@archiver.kernel.org>; Wed,  3 May 2023 01:40:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 715AE10E185;
	Wed,  3 May 2023 01:40:03 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC2F410E187
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 May 2023 01:40:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/S03sSywz+MpLDmsvBXR4tE4g2Jdo8thUQOGA9b1TqRdAE9eSWOXqhPYs1dOEwURAPYk5TgNLGYg/J1veRJ+9kswyuNEzUkZ4BL/ZHyOfDT7wvQlp0q2MQNUfazsmNqywSLLKvkcyujHspjtByIoK0gyBBtd4CbXdWKuiQ1MTXwg7qTAqEjzbCewMnDWqBCd5IdQNWeeUYP6EcaGN628fyrE6wJ641xmre1AvtQIXefUS7osN47NVQevHdFOW6qMSip6w/Hes8ib0AQCEtG8/WSjysF4UKpcOkk1KMi/N6ucFBlTv2Eg8dp9+XeWjK9cXkNvmVO4CmKu5cDpJXsLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTqznawmFguJScU0JXVsKmD/rfm/l1NhF+5es+M0+nk=;
 b=JxHXOoEfVxgAm1DSct8j89BNWPtg+3EnGum59GnYczq2yJkrLoxzdK2AsomDZJpsJ3PXnOkrwKH/O/LrjAOmDy7XPgsWL3tMeXGvurhA3C4D2yn8xCq9jyOxwk6zEaSy1qn5Qu86HkKm8OzAhPUJvynThqrBsDzt9inJplUJp0wGPJ5h8BgvvbX3MjLAnPC1lzaXfXGkH/Qh4Lbag4zZrNRAklp5b3aKHh0TpnX+N3Dg+tAXb6In8M7+29A7IWJGi6sWhjPUP0H4R/Tu+ZN383Ft0VSDBhhtCHPel4qKqtiFCDNGiB1ABxcLHoBtAUeZkAf/Jy0KTnGmNYZbndgZqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTqznawmFguJScU0JXVsKmD/rfm/l1NhF+5es+M0+nk=;
 b=Ae9DCSYf0d2XkLg0hjR1nLhdkXKhEu5g25RfsogaLr2S3L9OS6XEO+YaACJhMDSi3L926QzDZp/eKPNV1sJpQCRO6yypHrIREoWa152RMxnSK5XGJZ9+9Djx9rme1mfH5H2jCSKzZig3UOZaB4Tr0XJ9pIEMPiK9MVczC5mp2dw=
Received: from DS7PR03CA0054.namprd03.prod.outlook.com (2603:10b6:5:3b5::29)
 by CY8PR12MB8243.namprd12.prod.outlook.com (2603:10b6:930:78::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 01:39:57 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::99) by DS7PR03CA0054.outlook.office365.com
 (2603:10b6:5:3b5::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31 via Frontend
 Transport; Wed, 3 May 2023 01:39:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.22 via Frontend Transport; Wed, 3 May 2023 01:39:57 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 20:39:54 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/8] drm/amd/display: Show the DCN/DCE version in the log
Date: Tue, 2 May 2023 19:38:47 -0600
Message-ID: <20230503013853.2266793-3-alex.hung@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230503013853.2266793-1-alex.hung@amd.com>
References: <20230503013853.2266793-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT021:EE_|CY8PR12MB8243:EE_
X-MS-Office365-Filtering-Correlation-Id: cfe5c917-bbab-48e7-d41e-08db4b774d7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2yxLoTxEGh/a/p/7QiVDzQvraOSsLyTH1pYowhIWUain4phcXFdfWCtreHxooDzC5SLNLazhZcBapKwpT1znB3epN1RcOHnrgsinh3Yaayvqk3kaIj0xvDaz1/tyMeuAP82KS8/DXXe7d6h0+6Zn+aG78rXxCCzlreyG8mQbJVKD465Jzl9UXLS4U/ytEULpqP3j9ECCTWmDRF0V7hfqbDwaoCLZW65R1ELxCtFfmPJ7MKb9bc54zj/HlQ/IOn6ozWQctDxf26bYaU0XlZWAAA/zR2oS4Ly7uxqM3bLJFIsKixleu+VcdjcwOxKyxMYCw2ekEMM/8RMl019+osYnGskaA+MG53KXamDSf6AJZWVrhpb91MhQFL8zYO2GGDxMyW1f/IV5jeZR2zSrA7yNjMZaA8EVFZQ5SbGl7zQKODKbOnSMDELlibbk0tOZ0ckKA49CgO9LKqalvkG/cc4STsMgDUpS9WZc4FSYlb+6klYha7y1i/U7mC08I2mD7s8K7oWp/RaIgKNV3NNwJSciDONoGB/+LFQmnQdGPXtykyuFl+rrBO7bAFZiJwuOJSYmcqv64h8aIBupliucAnujWcM+g0j8q+dJIJ+vaGifrr7srbIJ4rSU7UafqF3bQHzOg0XO+99ryfnl4iwVVRg2IaRARHzC6PbXCPkGGjehW26Eo2xB3dg83vwdUUCZrPDxa0kdXfyS3vO7EBfb9QTqPAKuDp3ypHjit1pSHGWM0EU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(6666004)(186003)(7696005)(47076005)(336012)(426003)(83380400001)(36860700001)(26005)(1076003)(16526019)(54906003)(82310400005)(2616005)(36756003)(478600001)(6916009)(4326008)(70206006)(316002)(70586007)(81166007)(356005)(8676002)(8936002)(5660300002)(41300700001)(44832011)(40460700003)(86362001)(2906002)(82740400003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 01:39:57.5846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfe5c917-bbab-48e7-d41e-08db4b774d7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8243
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 Hamza Mahfooz <Hamza.Mahfooz@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Some times people send their dmesg log for debugging, and one common
task is to check the modesetting line to catch which DCN/DCE we need to
debug. This commit introduces a simple conversion from the DCN/DCE
version to a string shown in the dmesg log.

Reviewed-by: Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 +-
 drivers/gpu/drm/amd/display/dc/dc_helper.c    | 56 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dm_services.h  |  2 +
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5d850b473356..14b296e1d0f6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1666,7 +1666,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	adev->dm.dc = dc_create(&init_data);
 
 	if (adev->dm.dc) {
-		DRM_INFO("Display Core initialized with v%s!\n", DC_VER);
+		DRM_INFO("Display Core initialized with v%s! %s\n", DC_VER,
+			 dce_version_to_string(adev->dm.dc->ctx->dce_version));
 	} else {
 		DRM_INFO("Display Core failed to initialize with v%s!\n", DC_VER);
 		goto error;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_helper.c b/drivers/gpu/drm/amd/display/dc/dc_helper.c
index a21948267c0f..3db7a2e11af5 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_helper.c
@@ -690,3 +690,59 @@ void reg_sequence_wait_done(const struct dc_context *ctx)
 		dc_dmub_srv_wait_idle(ctx->dmub_srv);
 	}
 }
+
+char *dce_version_to_string(const int version)
+{
+	switch (version) {
+	case DCE_VERSION_8_0:
+		return "DCE 8.0";
+	case DCE_VERSION_8_1:
+		return "DCE 8.1";
+	case DCE_VERSION_8_3:
+		return "DCE 8.3";
+	case DCE_VERSION_10_0:
+		return "DCE 10.0";
+	case DCE_VERSION_11_0:
+		return "DCE 11.0";
+	case DCE_VERSION_11_2:
+		return "DCE 11.2";
+	case DCE_VERSION_11_22:
+		return "DCE 11.22";
+	case DCE_VERSION_12_0:
+		return "DCE 12.0";
+	case DCE_VERSION_12_1:
+		return "DCE 12.1";
+	case DCN_VERSION_1_0:
+		return "DCN 1.0";
+	case DCN_VERSION_1_01:
+		return "DCN 1.0.1";
+	case DCN_VERSION_2_0:
+		return "DCN 2.0";
+	case DCN_VERSION_2_1:
+		return "DCN 2.1";
+	case DCN_VERSION_2_01:
+		return "DCN 2.0.1";
+	case DCN_VERSION_3_0:
+		return "DCN 3.0";
+	case DCN_VERSION_3_01:
+		return "DCN 3.0.1";
+	case DCN_VERSION_3_02:
+		return "DCN 3.0.2";
+	case DCN_VERSION_3_03:
+		return "DCN 3.0.3";
+	case DCN_VERSION_3_1:
+		return "DCN 3.1";
+	case DCN_VERSION_3_14:
+		return "DCN 3.1.4";
+	case DCN_VERSION_3_15:
+		return "DCN 3.1.5";
+	case DCN_VERSION_3_16:
+		return "DCN 3.1.6";
+	case DCN_VERSION_3_2:
+		return "DCN 3.2";
+	case DCN_VERSION_3_21:
+		return "DCN 3.2.1";
+	default:
+		return "Unknown";
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dm_services.h b/drivers/gpu/drm/amd/display/dc/dm_services.h
index d33d595405a9..d0eed3b4771e 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_services.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_services.h
@@ -292,4 +292,6 @@ void dm_dtn_log_append_v(struct dc_context *ctx,
 void dm_dtn_log_end(struct dc_context *ctx,
 	struct dc_log_buffer_ctx *log_ctx);
 
+char *dce_version_to_string(const int version);
+
 #endif /* __DM_SERVICES_H__ */
-- 
2.40.0

