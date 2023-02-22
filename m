Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D447C64EC4
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Feb 2023 06:41:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCECA10E3DC;
	Wed, 22 Feb 2023 06:41:39 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2077.outbound.protection.outlook.com [40.107.96.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2105110E3DC
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Feb 2023 06:41:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bf6cmZBqHqYn6T57AM4pzMD8BhNXd3sidzhmCvjYekK2R7GvzenaRZ8OhX13jIUXbNz4Fq+2WJSWqe1Fs9S2u4wQvl28wxAN1fblf9Ss1w+R1HY4uB27XJ7NrGm8xOTG17zTQ/mr4bXudULagzZIuJ4P6fWjJdcQvdLmPx00a4Fy1mKetldGRxTTs9EfG+TcyHRGNGWp6I/GBmrCi8HH0Tjjo5r3V6HGdTe8XLwiaT0CEPYNuXMraY80Ng1rg5RUrnV+5+IjGInFjkz0vLCpGQtrrBSecgWYn0PgGw7gRlAfOz+YV3HpPXvpFc4oTxPjyCF9GLVgMq5O6LtSzCoUjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptZyPAl5NeeHE3BJRoI+hr799ZjEdY+LY63Zbjss94s=;
 b=csQBaaHZIPZ+/iAmV53+AVPswBtwmh0PFtLh89L+JOeIjhtvX7BXA3f31wZGivFcJcdLztJSQjxhq5GXUtDDvHodcI0NaihVjnAvhule5NKVOWc81CL7cAbE3mTwsWU1p4h6RF2lPh++T4Yx6v4m5oZ9ZZheUUB3WJEGy0Uw3ZCOEABUx+aLSrz7XkUM9jKdfZGqyMvIu91/L0CEhZro1Mz+YmVbtTjWp+OE1lYBKPaZ4/vamlJIDhW1uNerPW2ArbtWDdaF29mAPFBNHCOu+GPmscKQIvDhxDTqAeSp/8Pa6aqIJmW7XHy4nSSh0lTkBXoUlhRCim6U3l/cH0HSKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptZyPAl5NeeHE3BJRoI+hr799ZjEdY+LY63Zbjss94s=;
 b=qCCANPLcpHCy1HXnCYdsQQEYlZ9Iq3RawkbP0BibKzObEqGNz6IdDCIG6SwF9BjjqEiGqTTK9Fv15MylKoJMjzXzI7vPSi8HkE1THtp05xHp1PWIyUH+BqpUeKdcg3n5z5sB+yvOXQKaV//3AMHYmM21Ot+cDiw77Nh67LGd/FM=
Received: from DS7PR03CA0052.namprd03.prod.outlook.com (2603:10b6:5:3b5::27)
 by DM4PR12MB5295.namprd12.prod.outlook.com (2603:10b6:5:39f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Wed, 22 Feb
 2023 06:41:36 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::82) by DS7PR03CA0052.outlook.office365.com
 (2603:10b6:5:3b5::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21 via Frontend
 Transport; Wed, 22 Feb 2023 06:41:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.17 via Frontend Transport; Wed, 22 Feb 2023 06:41:35 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 22 Feb
 2023 00:41:28 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/20] drm/amd/display: Updating Video Format Fall Back Policy.
Date: Wed, 22 Feb 2023 01:40:25 -0500
Message-ID: <20230222064041.2824-5-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230222064041.2824-1-qingqing.zhuo@amd.com>
References: <20230222064041.2824-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT025:EE_|DM4PR12MB5295:EE_
X-MS-Office365-Filtering-Correlation-Id: e85a5d6f-d066-4620-20f4-08db149fd809
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BaFPb5JqjzuvKlhUaoHYBNfbeX26grK10+CHwvB0N3cTgMuZUtl+9HTuEcSVWFo3FP8Hq3LRjG6mlav/tMMvvzUYMmpCCtH/jV9NWdXI2hE+Vv4tkEkHja/u/PKqt57sf4ZrXVbL0N+ejVhgJIfWVGsM+ooHBVGTthOLIFhhEpKmrXf1RjUmuyjYTMnHqtEjq/ggi7knNcvCOpY7DsFrNotHYrcZG2OqfVs9EnzNItLuwzqGmDp3VqXp4WjSPL3KaumoKvYTk8HbtCm5radmcPvPUtSSF8zbYUGYMa2MuZKZ/HhlbSfhw2XsDR6Bn2Hkrzj5kr6RQo8uRVaAQMSt0eeNg7UhFP4c0iVUZ7t9CHab9afWgbLgBcNJnBRIjgYAxYwZMo2ol1QxqDJmsEvoRKyBiLRIknXRFDbNcs/0R1qqFd5ZuPIGISZWPtdAy9Xihv5DjMYfRbt3mk/ZWkI9h4hC1uUpSjhLNp6bexi84raEqhebgMQ6TgrquhwtD1SU3eUUW2qBbgR4ezQ50yGfEF+Kzdz4pCBRgiFKPOeIYrlSTh5GgD8VP9mL0rFORj/HMc25+GxJJkDQQDRH4viD9wn24YJqN5ltQBtk3PJi9x1B56sodiJMcpEcze/C3bimUj+Jxbd2hrsAPovR7ksGDy12RNKTIVdkxXUqmybRybYpMCmPw1M+OX2juNuvvmtAFfIe0b4u6tTb5WAInpsXSSs1CO7TdhbkK6Athxky5m0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199018)(46966006)(40470700004)(36840700001)(356005)(82740400003)(81166007)(36860700001)(41300700001)(8676002)(6916009)(36756003)(4326008)(5660300002)(44832011)(70586007)(2906002)(8936002)(70206006)(40480700001)(1076003)(2616005)(83380400001)(336012)(26005)(16526019)(40460700003)(186003)(47076005)(6666004)(426003)(316002)(54906003)(82310400005)(478600001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 06:41:35.9108 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e85a5d6f-d066-4620-20f4-08db149fd809
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5295
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
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Jerry Zuo <Jerry.Zuo@amd.com>, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jasdeep Dhillon <jdhillon@amd.com>

[WHY]
Adding 1920x1080 as fail safe mode for
Video Format Fall Back Policy.

Reviewed-by: Jerry Zuo <Jerry.Zuo@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Jasdeep Dhillon <jdhillon@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c      | 5 +++++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 1 +
 drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h     | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8be9fb8ada55..790d4910c009 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7160,12 +7160,17 @@ static int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
 			to_amdgpu_dm_connector(connector);
 	struct drm_encoder *encoder;
 	struct edid *edid = amdgpu_dm_connector->edid;
+	struct dc_link_settings *verified_link_cap =
+			&amdgpu_dm_connector->dc_link->verified_link_cap;
 
 	encoder = amdgpu_dm_connector_to_encoder(connector);
 
 	if (!drm_edid_is_valid(edid)) {
 		amdgpu_dm_connector->num_modes =
 				drm_add_modes_noedid(connector, 640, 480);
+		if (link_dp_get_encoding_format(verified_link_cap) == DP_128b_132b_ENCODING)
+			amdgpu_dm_connector->num_modes +=
+				drm_add_modes_noedid(connector, 1920, 1080);
 	} else {
 		amdgpu_dm_connector_ddc_get_modes(connector, edid);
 		amdgpu_dm_connector_add_common_modes(encoder, connector);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 8e572f07ec47..125012426a92 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -559,6 +559,7 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	link->dp.rev = aconnector->dc_link->dpcd_caps.dpcd_rev.raw;
 	link->dp.assr_enabled = config->assr_enabled;
 	link->dp.mst_enabled = config->mst_enabled;
+	link->dp.dp2_enabled = config->dp2_enabled;
 	link->dp.usb4_enabled = config->usb4_enabled;
 	display->adjust.disable = MOD_HDCP_DISPLAY_DISABLE_AUTHENTICATION;
 	link->adjust.auth_delay = 0;
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
index 3348bb97ef81..a4d344a4db9e 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
@@ -104,6 +104,7 @@ struct mod_hdcp_displayport {
 	uint8_t rev;
 	uint8_t assr_enabled;
 	uint8_t mst_enabled;
+	uint8_t dp2_enabled;
 	uint8_t usb4_enabled;
 };
 
-- 
2.34.1

