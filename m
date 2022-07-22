Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4ABBC43334
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 20:42:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25B428B3D6;
	Fri, 22 Jul 2022 20:42:36 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC8A38DF96
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 20:42:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YH0gt4Lvgo3ty5asAdigDMGU1LssbJpZ49Ppu/FoiEeqAPQFlA2RAEJnFWWE5sWHIOt0QrIo8sMBCK6DPV8OthSk67xxCAHa/1TjYgAy8Z04rnCBc18CfmycQUNDISgDZFZBJ8EnXNnEUUj2Yc3psHblJ32rNToVprklh9fZAlRpCP14rTV3P+qyyjCuZQFWtwNLCizr6UOY5irWEoVKFSeQbEbrNP4b4/10nwXwS3JfkuckScumBSvSV7qRkqRoy/6kJzjx8ODQ00PzFWALA0/OxuNnttLyqscVN3C5orBRJkd0n9da/cfAdWJx6poLnFALVMahO6nCgUoG4XsEdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXAVnT20/dCkDa5ln3KoQ+WCnXYvuRspsc5o7lzEiCw=;
 b=an8ND65XJM9ZLCmpHZFMZcHCS6GfZ8lzAly8J0uwRtwL6uOswF5+pmonzMUk3LRD1uQjQMw3hHZsSuY1EN19sTB7DI0bRU2nCWdBvq2o0NaF2Hvu/mQskzkxIyYDNduziNF757hgszgpLznaT/oX/P5I1NFeJ0PGzIqhZPbDCIt/wn6Y9AVaKFWwsdYNyc3SlNGZwPHfl9XAnyMaFXac1YNpzJhM92tEU62DD5fS2/hAyQ3lUHSHC9itMS4pR3Y+lc6+b/YFctvmx/HGnvOkUSWyABoNUpX8XQE+fstv2aDhSOzyLLANmRGsYAyRVmi2aB8VFJCeUHY23LnIQ3txWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXAVnT20/dCkDa5ln3KoQ+WCnXYvuRspsc5o7lzEiCw=;
 b=cvS8X+l2htIVR6/JJOUcn9QuArw5ymDOEZK6NR7oVyjgOHtbcyJFgMnZpoScSiW+7fncWZ51iaIHCBT9zHwgc7fwo5QtaZlBLS+jdtvfSgOi8p4WRMv8V7RvNbOcQkxjK1qOwUzzFIHtm3YSUEFJFaBA2XO80KZzUccYFGpFAbw=
Received: from DS7PR03CA0199.namprd03.prod.outlook.com (2603:10b6:5:3b6::24)
 by MWHPR12MB1741.namprd12.prod.outlook.com (2603:10b6:300:10f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 20:42:29 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::a6) by DS7PR03CA0199.outlook.office365.com
 (2603:10b6:5:3b6::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23 via Frontend
 Transport; Fri, 22 Jul 2022 20:42:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 22 Jul 2022 20:42:28 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 15:42:20 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/31] drm/amd/display: Add support for manual DMUB FAMS
 trigger
Date: Fri, 22 Jul 2022 14:31:28 -0600
Message-ID: <20220722203137.4043516-23-alex.hung@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220722203137.4043516-1-alex.hung@amd.com>
References: <20220722203137.4043516-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d3ac788-13fa-4630-3e13-08da6c22b16b
X-MS-TrafficTypeDiagnostic: MWHPR12MB1741:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8viSl9+RADMJ1pnf24sdecR4uw1VKwh7Xmc++FQkqOzfBiFG3IK1AUM14qTodONIjK+M3hymnbk6IfQ/YGBcBg/iflNUqPZqylUcCyF+7vqp8h+0bB1nzoyWdceGX6rqYw7LR0n7HYxDbroPnQvDQ+g6e7FCCa1pSuS5JGzxcUtlOM1eDN5bd9DzO2Z4J1sPe602+dcUe+kj71ToLnmadCK2UgTUS13n7se3osmFF07WF9JYYwvEuqqQPXvE1A9JRSwnJ/b4GsJaRDSm1NoqAs99vt3R5Q816sNdD5GS2yh+gRxjNNankPOz2eiAcMnUP3XKGxghlJ7q16ECZjsl3xE6wU1N19S6mo7uti9qZDslI8OePOGaLxANeSzPM6NRv5Q8+uapwgxO9gWdx6G6II7aE4rYYjVQ3hw6Ndz0w7B2uOrfRs93SuFqmGO2lRlYE1i0Il96Pn2glWar1ym0tgnfbfANemvctyf4Tz8GsQ/8xMYr+GmCCxB6dmRaaT9aH/9sfaMmf3lO4mUkxZjLRml5zv4hDxD4GGVm+4P+YpEbbyYB29dgaoy2PdDpclZnB3aIg3TWyiqsf+fMT7dv4xzWhyh1Wb5pw/g/mjKTCdix8M1Uy7devMlsof3owUgjJF4ARD2yti0MGOA11CkywasZoEc8iqr+prpAUgSOXdIYd+iQPKFFotOPDy1hnp0pVeyScHWHIE5KCoMLEud6Vt+h8knNMwXvW24ImELm26kPmvuO10TG0ipWqwfrviftu7MAbKEv31SrlsTLSckSLYsh1MM8GOCSoagHCgHhSGTvVNL/LH0hGlYRfzFw1Um6HuDddwCPWQohdggeDbepBg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(346002)(136003)(39860400002)(46966006)(36840700001)(40470700004)(8936002)(5660300002)(44832011)(40480700001)(70586007)(4326008)(70206006)(40460700003)(82310400005)(2906002)(83380400001)(8676002)(36860700001)(36756003)(356005)(86362001)(81166007)(478600001)(82740400003)(47076005)(316002)(2616005)(1076003)(6916009)(16526019)(426003)(186003)(41300700001)(54906003)(7696005)(26005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 20:42:28.6536 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d3ac788-13fa-4630-3e13-08da6c22b16b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1741
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
Cc: stylon.wang@amd.com, mark.broadworth@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, daniel.wheeler@amd.com, Aurabindo.Pillai@amd.com,
 Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

- Add is_drr parameter to indicate DRR is enabled on
the panel to determine whether SubVP MCLK switch
logic should be enabled

- Add DRR manual trigger in FW (instead of driver)
because manual trigger programming triggers DRR
update pending and can block SubVP MCLK switches
from taking place

Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index de193636d022..d7f3619352f0 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -976,7 +976,8 @@ struct dmub_cmd_fw_assisted_mclk_switch_pipe_data_v2 {
 			uint16_t vtotal;
 			uint8_t main_pipe_index;
 			uint8_t phantom_pipe_index;
-			uint8_t padding[2];
+			uint8_t is_drr;
+			uint8_t padding;
 		} subvp_data;
 
 		struct {
@@ -1579,6 +1580,12 @@ enum dmub_cmd_fams_type {
 	DMUB_CMD__FAMS_SETUP_FW_CTRL	= 0,
 	DMUB_CMD__FAMS_DRR_UPDATE		= 1,
 	DMUB_CMD__HANDLE_SUBVP_CMD	= 2, // specifically for SubVP cmd
+	/**
+	 * For SubVP set manual trigger in FW because it
+	 * triggers DRR_UPDATE_PENDING which SubVP relies
+	 * on (for any SubVP cases that use a DRR display)
+	 */
+	DMUB_CMD__FAMS_SET_MANUAL_TRIGGER = 3,
 };
 
 /**
-- 
2.37.1

