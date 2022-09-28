Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F21C04A95
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 19:41:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B8A010E9BB;
	Wed, 28 Sep 2022 19:41:53 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DF3810E9B1
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 19:41:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gY13v77Jyn171zRgmO3u6QB7d3iZYA5cFUlfNsruk1QtXFHmzB2kylSc//ZtfXReYApOgboruqPzbLU7yozZhan02M7i//UXcXei5a9pe7X56U1aNPDEAp49kwCbTObxtG5J7bN8lSN3MIJu+qy23+lZ5VPY+XPKPil8AII9hReJcEs/uaIxcEc6I9Fh9S3qxrjcYXnw4t/TeVYx1iAshVp+yUFomAo8qC/MiJS/2ErahccKk3X+p62DCyPQc6MbFfeDvSfvysu5rc73OhOSbWXhS9mHezzWKWNChs8GDv+l06+XNcj9gJaG893F1HkrMGaD2czN7VxvaJZoWWT9sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09GOJvJFd0g7wq4LIU2LIfNYZjyUrvC56lKoGHTTeAk=;
 b=lXvM94XOVt8rioSOAXWy9ONnJ7tC/w4nYBBtbh7fNBG5Z7vtwa7JhpiIzLmhI114M/h0xqKhxnjAl3HJ8Uo00PsjcF2OFfD9vbzcdOflYRzxBhiglGNCrZHBhqamg1EDX8LHjIy/kr2Losg/e2hBDI7NZ38WwuGSTdmpYcaniAcAAMTVD0ebR9fB+ElmxpmUtJFIGfhED59CxcO/aNQd4VhoXn7u6nBAXwn47NuKTaZsvsy3srOl21YsXtEO/0emJlGCVFXVKAji4BGubyPdsjC0INQHXIVBHMrzZlyuPkxCIaLg8+JITW3VRTA9auuRF1buayYujQA26rp2M5iHhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09GOJvJFd0g7wq4LIU2LIfNYZjyUrvC56lKoGHTTeAk=;
 b=LIeLTeAQGGBKP3GKY3+Y7zeWMkfG8l/wzOvj7tKpqT2hJeCnUHMdCNy4+L9xxCJx/bbQwShVNxwz5nEqCVHQAIWzbLG6gK5G50Hd369hXG5zHqz9GYimE/LO6h7z5Isk0qvUsyphRrolSbds8uyTlzBf3D1DtjGRaXlRusl8lxY=
Received: from BN9PR03CA0760.namprd03.prod.outlook.com (2603:10b6:408:13a::15)
 by SN7PR12MB7021.namprd12.prod.outlook.com (2603:10b6:806:262::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 19:41:17 +0000
Received: from BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::3a) by BN9PR03CA0760.outlook.office365.com
 (2603:10b6:408:13a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 19:41:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT027.mail.protection.outlook.com (10.13.177.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 19:41:17 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 14:41:15 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/36] drm/amd/display: write all 4 bytes of FFE_PRESET dpcd
 value
Date: Wed, 28 Sep 2022 15:40:10 -0400
Message-ID: <20220928194028.144879-19-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220928194028.144879-1-hamza.mahfooz@amd.com>
References: <20220928194028.144879-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT027:EE_|SN7PR12MB7021:EE_
X-MS-Office365-Filtering-Correlation-Id: 58494979-d960-48a9-4746-08daa189693c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4cD51/BLuocgmwQN9JvOg3bHY4DocLTKYJkMmGdNlE7Fcdf08rgNLCkIpmwJeCsvmb46K+GFHYL0WC0Evb27VsuLAnG8VBCdfteY1xZE+f08WgQq6c7ZbKiiBi2u//L8xmJttfAtymcodNNHZu4b1FJNBCoi4IoevRdg29fpo9codE+PjQFkFf6DIdqciRMK0ZFksGq6qLYBB5+ytB0w3LRAM/Ox/MpMu/K77oj8yuSSKtWy5Ixblp/MP7xrwEfgL8NaJ8u8wM6nVwC+drvyN0G9HmPTVwTR0Pv6M5+yo5blrys+tEoJgewYoOaw51/YgHBxvttM2AsG79usVd7zLiKZjbfhzap1tB5EJyf4km5ODm9Ti79nbKm5lTVHeDlxMKzQLGnUzOkW48tQ1GR5huE4poS+3hFd+qjQODtf04kGYLB3uTIJy8AXgQrOR916LZdNOav7lCo+RSWMAH7RgRMOp1uIJVK390KV/a7YdOLb9GoYuKZ+VTMAabA0ghday2xZWFHW0YhBa2JVtHIU9Plhzm6Uz41UdR+m/oGhofSbvGisoc7cDFcuwKJJUTrdtI3Y0Wnd9RyRv4PD6CNbWjdOKjNTKtWWRZlnRPf3LoJGV1L87MYaoHU/DLJ40vpCz5Vr3YB2fafDs6ddD2Gb0X/NMU2mETjK3IeJUOQVzM2luK13KC5wQDPXTOGWQDKMKTishjaS8+QfpT1F1DYwKYVFbEzO76LHIcJQjy2xy39+aZRTcmUuTkLdJB65fAD0rj1/bA7u/cZbsVsogPoXPgT1VmAftnfa9uXtV5YGOt9Id2dk5he9/KkkuPGQ0Wto5HxrEzvKTiNv6JsHcGvgLA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(7696005)(36756003)(336012)(316002)(54906003)(82740400003)(16526019)(6916009)(1076003)(186003)(36860700001)(70206006)(8936002)(86362001)(26005)(70586007)(2906002)(41300700001)(40480700001)(83380400001)(8676002)(426003)(47076005)(4326008)(2616005)(81166007)(40460700003)(82310400005)(356005)(478600001)(44832011)(6666004)(5660300002)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 19:41:17.3714 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58494979-d960-48a9-4746-08daa189693c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7021
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
 qingqing.zhuo@amd.com, George Shen <George.Shen@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
According to specs, it expects us to write all 4 bytes even if
current lane count is less than 4.

Reviewed-by: George Shen <George.Shen@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 37 +++++++++----------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 4ea8acb16161..c4acadba78d6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -944,6 +944,23 @@ enum dc_status dp_get_lane_status_and_lane_adjust(
 	return status;
 }
 
+static enum dc_status dpcd_128b_132b_set_lane_settings(
+		struct dc_link *link,
+		const struct link_training_settings *link_training_setting)
+{
+	enum dc_status status = core_link_write_dpcd(link,
+			DP_TRAINING_LANE0_SET,
+			(uint8_t *)(link_training_setting->dpcd_lane_settings),
+			sizeof(link_training_setting->dpcd_lane_settings));
+
+	DC_LOG_HW_LINK_TRAINING("%s:\n 0x%X TX_FFE_PRESET_VALUE = %x\n",
+			__func__,
+			DP_TRAINING_LANE0_SET,
+			link_training_setting->dpcd_lane_settings[0].tx_ffe.PRESET_VALUE);
+	return status;
+}
+
+
 enum dc_status dpcd_set_lane_settings(
 	struct dc_link *link,
 	const struct link_training_settings *link_training_setting,
@@ -964,16 +981,6 @@ enum dc_status dpcd_set_lane_settings(
 		link_training_setting->link_settings.lane_count);
 
 	if (is_repeater(link_training_setting, offset)) {
-		if (dp_get_link_encoding_format(&link_training_setting->link_settings) ==
-				DP_128b_132b_ENCODING)
-			DC_LOG_HW_LINK_TRAINING("%s:\n LTTPR Repeater ID: %d\n"
-					" 0x%X TX_FFE_PRESET_VALUE = %x\n",
-					__func__,
-					offset,
-					lane0_set_address,
-					link_training_setting->dpcd_lane_settings[0].tx_ffe.PRESET_VALUE);
-		else if (dp_get_link_encoding_format(&link_training_setting->link_settings) ==
-				DP_8b_10b_ENCODING)
 		DC_LOG_HW_LINK_TRAINING("%s\n LTTPR Repeater ID: %d\n"
 				" 0x%X VS set = %x  PE set = %x max VS Reached = %x  max PE Reached = %x\n",
 			__func__,
@@ -985,14 +992,6 @@ enum dc_status dpcd_set_lane_settings(
 			link_training_setting->dpcd_lane_settings[0].bits.MAX_PRE_EMPHASIS_REACHED);
 
 	} else {
-		if (dp_get_link_encoding_format(&link_training_setting->link_settings) ==
-				DP_128b_132b_ENCODING)
-			DC_LOG_HW_LINK_TRAINING("%s:\n 0x%X TX_FFE_PRESET_VALUE = %x\n",
-					__func__,
-					lane0_set_address,
-					link_training_setting->dpcd_lane_settings[0].tx_ffe.PRESET_VALUE);
-		else if (dp_get_link_encoding_format(&link_training_setting->link_settings) ==
-				DP_8b_10b_ENCODING)
 		DC_LOG_HW_LINK_TRAINING("%s\n 0x%X VS set = %x  PE set = %x max VS Reached = %x  max PE Reached = %x\n",
 			__func__,
 			lane0_set_address,
@@ -2023,7 +2022,7 @@ static enum link_training_result dp_perform_128b_132b_channel_eq_done_sequence(
 			result = DP_128b_132b_LT_FAILED;
 		} else {
 			dp_set_hw_lane_settings(link, link_res, lt_settings, DPRX);
-			dpcd_set_lane_settings(link, lt_settings, DPRX);
+			dpcd_128b_132b_set_lane_settings(link, lt_settings);
 		}
 		loop_count++;
 	}
-- 
2.37.2

