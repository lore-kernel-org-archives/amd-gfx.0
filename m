Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49086C7618E
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 23:50:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B89B310ED45;
	Thu, 20 Apr 2023 23:50:14 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B1D410ED3F
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 23:50:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXhWTYjFBsu2R7KhnQ9iY1cvAUaBYT+LJidb0E5l4BpcGTAA/Ip8Ug015OU483ARCK2O3F0sBcAzHuk7QuR7AZmmCHglOnK5Wb+YfSyNuYii3SL2V7+B9OROgd+Q1ePUE7KjlD9BS183pp6tvzCkBG2RNwdCYM4b1iwssLnwx43hy8jeMSZouuurC7LSdiUEP7n9h5tPlFnTX6st1z846p7ZE+PTzFSSRomk4X3mZttQoukgZQZci7cweWhDHgBwdxZmAha0tnmqDJDX2JwU9xUcWwkWmKoU9VRHM0BvzeKzOq8dwzq5l0yhdMNslcOgXXNieftQ20NRVODFSc5EGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcmN0RE0tI0gOrVeszHYZ+MfgTr5VorxMjcI1aaoXBI=;
 b=Pq7yXI2laZtodi2oVyPk+Pq0Qz5zUknFXJsASTqmwuzsUBfTvG9wTMisyodRUwLHl1sYbceDzGHUnLX1SPIbYA5qRmPxARvMKDwx4BylrFmrfUHYcSZf/a3lm+QgV4NcTpcYQHSwaUvOagX+hfphopRewQNzw5deQx2qNzksD/siKDgCXagnIdvVbUHacUNtmRjK5resxAyxH3LVOOLr/8fbX4tY5TNk+RVMEXewILdIsDDFabe46EDbEpy8326BozzIpY7kTu01tRu3M3T3OhXi7za1Br9AkX7IWIXJaCtlvzReX54vylYckJJyvpvbQYekPHvSioOIkLwm74JgEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcmN0RE0tI0gOrVeszHYZ+MfgTr5VorxMjcI1aaoXBI=;
 b=SO/V2tHA82p0pY66R9XxOB243D4R4oY3iA6VrqhnRIqXjBEUMYB0xmUij580gus4quWxAgqFtk6KGgEcu5vgPzYStkYC0T3QZDw5Yju7J4wk/J2dzM8Ppqw76zgA0mGT+TBH63T1aDm0kqPFa2X5qpJLgi/AEgC08/OBKe4UHNE=
Received: from DM6PR01CA0019.prod.exchangelabs.com (2603:10b6:5:296::24) by
 BL0PR12MB4931.namprd12.prod.outlook.com (2603:10b6:208:17e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 23:50:09 +0000
Received: from DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::aa) by DM6PR01CA0019.outlook.office365.com
 (2603:10b6:5:296::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.25 via Frontend
 Transport; Thu, 20 Apr 2023 23:50:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT099.mail.protection.outlook.com (10.13.172.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.27 via Frontend Transport; Thu, 20 Apr 2023 23:50:08 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 20 Apr
 2023 18:50:06 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/21] drm/amd/display: assign edid_blob_ptr with edid from
 debugfs
Date: Thu, 20 Apr 2023 17:49:31 -0600
Message-ID: <20230420234951.1772270-2-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230420234951.1772270-1-Rodrigo.Siqueira@amd.com>
References: <20230420234951.1772270-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT099:EE_|BL0PR12MB4931:EE_
X-MS-Office365-Filtering-Correlation-Id: 07e4a83c-38c9-4714-3f57-08db41f9f96b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JlaqLe8VC85tBsRY09kBU21R2IbjaX8IrgV2l74Lv8gJncMdlHOmC/90fqGBIj3BrHoLgSW62826pybZZ2OfEmi+zFycuxmxHHGdOtRiMZfxvvg/zjScefDtr8NRgaBLm3d/ogKx15OtAehxGUqzk3ZeNUv8tbDNSArcOUiw2mCI+16UzWbJM8KXWWjKSh0nzurzX6KrdTa2W9b3jGgPQANimAazfYi61CvtjX9BcwR7ZJDn9FAkNMsnOxXUrUXVUSx8MT9RY4KWhCokfVFmtUqT28xi62YfuRSXtOeWDSgV36VRDQWJC6NVixF4qc9ZlRvMQj2/Vh0Ms683fWzpEz7njdTDBdZwZfJLo5441XehtJTgk5pyCGNFTci+fpI/K4GegbqgNrtkrLL14qo3iZQmARsnjSspa+a5k97LZ7V+Klw1z/WhL2A2uim38oETGYAFwmD+effBVU+P0XkaD5jhTjE2SM5IAHuvJbOSwCRKw0GdV7G1AOx1Xbz3WXG7XMHp8KS8pN9YJGvdokh+WwRjbP17h2D31N7avcDf7LDwhGTLLXw8YMW79u4UAPfsAtqaM+mLkkIbc4fSLAM5+3Jvdl3gPvDCWFkG3URrJdBfoUQHZWdfqAEEBphupLgBRg6GNNAJW5LCe0doein4RiR1Q+7o7cvo9PBzJQqF8ol8VG4u/JX459BGTU2MmIrkBEDOI1MyG/LMiA66AwI7sv66IqFDILRRrej6/qBhmj8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(40470700004)(46966006)(36840700001)(82310400005)(36756003)(40480700001)(40460700003)(478600001)(54906003)(6666004)(356005)(41300700001)(81166007)(8936002)(8676002)(70586007)(70206006)(316002)(6916009)(4326008)(82740400003)(36860700001)(2616005)(83380400001)(47076005)(426003)(336012)(186003)(16526019)(1076003)(26005)(86362001)(2906002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 23:50:08.9493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e4a83c-38c9-4714-3f57-08db41f9f96b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4931
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
Cc: Chao-kai Wang <Stylon.Wang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Hersen Wu <hersenxs.wu@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hersen Wu <hersenxs.wu@amd.com>

[Why] implementation change of drm_edid_override_set since linux
kernel 6.1, edid from debugfs is saved into connector->edid_override
immediatey, not saved to connector->edid_blob_ptr at the same time.

[How] call new drm_edid function drm_connector_update_edid_property
to assign connector->edid_blob_ptr with override edid from debugfs.

Reviewed-by: Chao-kai Wang <Stylon.Wang@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 76a776fd8437..e1565126ad2a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6372,11 +6372,20 @@ static void create_eml_sink(struct amdgpu_dm_connector *aconnector)
 	struct edid *edid;
 
 	if (!aconnector->base.edid_blob_ptr) {
-		DRM_ERROR("No EDID firmware found on connector: %s ,forcing to OFF!\n",
-				aconnector->base.name);
+		/* if connector->edid_override valid, pass
+		 * it to edid_override to edid_blob_ptr
+		 */
+		int count;
 
-		aconnector->base.force = DRM_FORCE_OFF;
-		return;
+		count = drm_edid_override_connector_update(&aconnector->base);
+
+		if (!aconnector->base.edid_blob_ptr) {
+			DRM_ERROR("No EDID firmware found on connector: %s ,forcing to OFF!\n",
+					aconnector->base.name);
+
+			aconnector->base.force = DRM_FORCE_OFF;
+			return;
+		}
 	}
 
 	edid = (struct edid *) aconnector->base.edid_blob_ptr->data;
-- 
2.39.2

