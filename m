Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EFD3C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Mar 2022 21:48:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1DE510E205;
	Fri, 18 Mar 2022 21:48:58 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2072.outbound.protection.outlook.com [40.107.95.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57F9410E205
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Mar 2022 21:48:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vg7ODB7PNoxOg4ZU/KURHmwl0dIop6oYKc4N9zSoWuDSYJVtb8SG4vBEfZ878N+xBjmRnGBJay91t11AQaIEIJxqgrg/YD2P6Qixyb2QOWjx0GfyyWtcWF7iuzGxwtDVtLUJfzT2Ty70vs5aCNJf2my7OYKG180D7UzIaUZoxKldCqKQ/5tLY3jWh36Ear8jaRSlU8Hi6F00PpxU98iS/9VSlIZ2mBwtZeKy0volECHHNkueASdEQpmxJf2Kp3e1cXZZ7pNF5w9bK8168yF9b7m6IAhmZxSDnnLKKIO6mlvwM9Ct/lf8czywz/01/n2z2SxLLz+pOVzVxQf/+SAPHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVSnYSnhlEiNe8wlULNNJeGy0WDVolMPONv0leOdlv4=;
 b=kwW3OMbhXpa2CNOeWfLyeZNXdavgvKRJqQoz6aXObaeQ67VH3aZgjYseLCcZB86W8SHD9AQJOqNHMmIlu3SBMDa+Lb4s5Zdn3huRADhVoKwrhm0/44rMf74KrNxYSrc5CISQaXVDoKodKyoXSBmyTP5Hb5l9Nt6jSAxaTUFmgheHxstBhLTqEwBmT/zcgahQY4NxpjiYtltYcOPA8ByL+yinDdMQDzd8sGb2DnQRae9yHW0F+RWoKBIiQr8UCh3lndUHpT5esjoO8LhOxltOXmr3n3r48h2t7J3wd1PR9rl9zdgQcQCGWL28i67qhA3SyJygZ1NuhgS0c1aiMGN/4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVSnYSnhlEiNe8wlULNNJeGy0WDVolMPONv0leOdlv4=;
 b=qgYYZvkk2d04on5SOfrgsBob8/YslsOnaUDCKx3Xhe41OLBSCuv455ud+C1L+cEFers2WqvwTCKhLrVN6Z/C2EzEycwHg8oyX4BxwpECUv50r27/9fKgPnMxpK/firYnYIWgSBl8riF+S3ircwSEAPD/XV/wBh7TKeXg6kKYwd8=
Received: from BN9P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::11)
 by BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Fri, 18 Mar
 2022 21:48:55 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::91) by BN9P223CA0006.outlook.office365.com
 (2603:10b6:408:10b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17 via Frontend
 Transport; Fri, 18 Mar 2022 21:48:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Fri, 18 Mar 2022 21:48:55 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 18 Mar
 2022 16:48:52 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/13] drm/amd/display: Reduce stack size
Date: Fri, 18 Mar 2022 15:47:50 -0600
Message-ID: <20220318214800.3565679-4-alex.hung@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220318214800.3565679-1-alex.hung@amd.com>
References: <20220318214800.3565679-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1bcb756-5cf0-4031-edd3-08da0929197e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5144:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB51446EC6E7E2B13B92D3C991F7139@BL1PR12MB5144.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cfEcdfw0tAdJ3AACpLzgeyZ02Au2h4iTQGfGOm2kd5Gx+D8pQFTGqoOS7buizBQHOotXsiERjT5JcCxO/Z/raKs4EKLnmD7tiVv91el7FqKML2cRUZmGVXGzBIu/3T4A0O7Fg72CPSgKosOhGdkXNcvVhzT4bjgj43TwnK21PihnNqHSFjxeinIMVHSO5VC9PjB2g1MckVCWxAoH7AGhnXBuWou6aY/h7VpBuqqWJGlZCMZEeU6+IXgP3aFfuRZtK5NmazUXlf1ghh3IC4MPhA9YAYH0innrcR58DYGqhmmrB/MAZkYqnhMs64HgwFNgH80UhA/UYRgUtUX4A0bdTGWarMKh0I5U9yRnUZwrtmsrDMP/AMS72Z4mEeLCxoZ9HjVhKRoM5irVCakLtu1lS3LfsxISmi5RLWSyaQb/3ZqLc9VMP55TJUFnULedlOAeu9SiUCVws1d9oHNAKSNZZUuLVv/MkgrUPt3iLG8kUuxYmdc4AYV5dG9ncSzZL3lWGmx7NV8RLvPPZt4wykziN1zhpjNNbozfJFEiiQCyYxSeC+7Oe4W48creQoxpGrFgay/vOGu5z+cu+/Ujm280UsGc12ZWbMNy6PhUFmm9yZmmnQ1wx1aBL1smmkIphhigoEuHeuQEUqelrKmadmadNx2Da6U12RkQm6bY3d3arIlRIpBzhFL2KsuvsVF4NddoBRGePJJNis2Xrx1UvApUAA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(44832011)(2906002)(356005)(5660300002)(36860700001)(316002)(86362001)(2616005)(7696005)(82310400004)(81166007)(4326008)(8676002)(508600001)(70206006)(70586007)(186003)(47076005)(36756003)(426003)(336012)(40460700003)(6916009)(54906003)(83380400001)(1076003)(16526019)(26005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 21:48:55.1779 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1bcb756-5cf0-4031-edd3-08da0929197e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5144
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Linux kernel enabled more compilation restrictions related to the stack
size, which caused compilation failures in our code. This commit reduces
the allocation size by allocating the required memory dynamically.

Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index c3e141c19a77..ad757b59e00e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2056,7 +2056,7 @@ static int dcn10_align_pixel_clocks(struct dc *dc, int group_size,
 {
 	struct dc_context *dc_ctx = dc->ctx;
 	int i, master = -1, embedded = -1;
-	struct dc_crtc_timing hw_crtc_timing[MAX_PIPES] = {0};
+	struct dc_crtc_timing *hw_crtc_timing;
 	uint64_t phase[MAX_PIPES];
 	uint64_t modulo[MAX_PIPES];
 	unsigned int pclk;
@@ -2067,6 +2067,10 @@ static int dcn10_align_pixel_clocks(struct dc *dc, int group_size,
 	uint32_t dp_ref_clk_100hz =
 		dc->res_pool->dp_clock_source->ctx->dc->clk_mgr->dprefclk_khz*10;
 
+	hw_crtc_timing = kcalloc(MAX_PIPES, sizeof(*hw_crtc_timing), GFP_KERNEL);
+	if (!hw_crtc_timing)
+		return master;
+
 	if (dc->config.vblank_alignment_dto_params &&
 		dc->res_pool->dp_clock_source->funcs->override_dp_pix_clk) {
 		embedded_h_total =
@@ -2130,6 +2134,8 @@ static int dcn10_align_pixel_clocks(struct dc *dc, int group_size,
 		}
 
 	}
+
+	kfree(hw_crtc_timing);
 	return master;
 }
 
-- 
2.35.1

