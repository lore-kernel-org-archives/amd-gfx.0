Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F23C5AE4A
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Nov 2023 19:44:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5384A10E584;
	Wed, 15 Nov 2023 19:44:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 755D410E579
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Nov 2023 19:44:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXKeeImrmoCufeiatlMLQSH19sdDa2XfZx1H5+4L2kS9slm2yKAW1ezlKhriaBAwQ2ZXH5Rp/KxcStr92XP23kNcID2hQwSanWT0+Bh8KGTK0mwUl5BjpHb5xyGkt9vkHhvfwGNzGusg2uqdqzvGwD3N+aEphsz4UJyxwXuLfm+nerY1JqTb0+fSMZzBGz5FHX2pfwzuphNAVqo9I7yszSoQMdyGTpAeFdj3mxWHTUFOtI/9Vx2WDeF2b3oO9AK5VfLXqbmbrC5MD0qKBVoJnJGMKfEaUNZiob/7a9z9MRlvrM5kCvWdh32zsiMrvBXHDrDPaMURIbc7HEdVxjqnUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vektdcGsImPRrmBtuGFgMc14IhNCh2HPNhQMx9aILTw=;
 b=T8k2HM+oK5NaStMi2It/qAyyPTrcjKlO7aK2foBKipEHIowQBgrauUAlOqXt/UaTjP/dQuGxmKaetsCKmrsxw2wRhSGGaYdjMH83BXJLO/n0uvkmA82jIBQ449PpslPPgNT7138uXLSJUwQ0vuLx9sYGG29I1IkbrRLh0TGmLR0T/YUSo0GA1Y6wtxhknqe6md/yJs3dTs9R8ckOHBcvfV1BKR9II6BMOfXKAWtM/EpYuQQNEnUg0saGGaLj1Ku16WAG5pJQbuEmpdX1bDuB6YMves31Q1swh1oo7yFBl3qxC47DNz+EnlJTjzUcSYPw1AC9nUHNgkHxRI0H0zwoag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vektdcGsImPRrmBtuGFgMc14IhNCh2HPNhQMx9aILTw=;
 b=5dd/aHMHj4rfzLnkyaJMl/J82bSvT2rxYXD9I/USgK8B0AIghhawNev8xelHFYhPoBTmSCsOhm3KgRIpEaDV9gygfVLmN4NV4L6hZyYzKqheYgVRG1gnPJPyI1CHGDyFEtR3QM0HSc/yUWU0Fuia3atQK/z/Z6TvEHXkqcnREDI=
Received: from MN2PR14CA0010.namprd14.prod.outlook.com (2603:10b6:208:23e::15)
 by DM4PR12MB5745.namprd12.prod.outlook.com (2603:10b6:8:5c::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.31; Wed, 15 Nov 2023 19:44:20 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::31) by MN2PR14CA0010.outlook.office365.com
 (2603:10b6:208:23e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20 via Frontend
 Transport; Wed, 15 Nov 2023 19:44:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.19 via Frontend Transport; Wed, 15 Nov 2023 19:44:20 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 13:44:18 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/35] drm/amd/display: Feed SR and Z8 watermarks into DML2
 for DCN35
Date: Wed, 15 Nov 2023 14:40:23 -0500
Message-ID: <20231115194332.39469-11-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115194332.39469-1-hamza.mahfooz@amd.com>
References: <20231115194332.39469-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|DM4PR12MB5745:EE_
X-MS-Office365-Filtering-Correlation-Id: 12ff8bef-e7c5-49f1-b8a2-08dbe61342ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lzJ5ExO++lWpICOcndSZ6I74uT3cenksqEU96FscQ8KrED4BtRIUtBL+ivEup2WEdACUkiN/kRAswBGizbaa0Phudrj/ET0MtPK060XOG71y+Htt3kFpZOdgXf2q2LozSPrFVlXT+JVOtZcLel/uzUUc5tJVrcCo9Kx8PLXD8gujZtSADVSsP9ED4+yt4M6rgthc1OgABDHSLYKCO49dnAP3lXt7Mzxcm1FmZOD6YL5XWGmvfzg1gU5HVia8ygsP3jF5bghY1Czxqm8+oksB4sCFbhEALv+wu+2QNH8QggC44g15mIUP4/WAoPUgO25oPHVnhuudX+fV+WFyZUcrwYM33t4o7PKn7a6oUBwMv+0e6HpNKFztcBArHQ5UI/EjLY93BxOyjwbS1UjWoh6A/UxEZJYmRwR3dThgS8FNbpNmp9xU4HBwbTs27x7in/UDc5ANa9mnCRzrO/i6qNML/1acoFFpjJq7ig2Rq1H/LFkU5TQ98gSn3DOH0/4ZCHaU5pZUFow8QRgevFmUKKN+GydazrLoTzEkbgf4N+TA8l0rht/BX4YX3wSV4OF8ceDSL5y14+KwMex35OXNs3OoXcHiIcp5TVcsKSk0y1IOT7gzO0ZwtjnIA/06YL0Pek1Kqx216Jz8Cs96Gkcd85aHjH9gNSKBOomHuE+O7PVucPI55nluk3GKNzw5edm7sTWt391pdVsDzrGV+UkUJdZm0/8GPRpdr/mI/X6PnF93l5b+AkniwbtfoJ4ClHB1GwoP7t17HBwbbTYtEAdgjyBVZIl8/mjVhuErRlOVsr+m+WKw0doOjHhIclIE04R099xh
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(451199024)(82310400011)(64100799003)(1800799009)(186009)(40470700004)(36840700001)(46966006)(40480700001)(356005)(6666004)(83380400001)(81166007)(47076005)(36860700001)(82740400003)(40460700003)(336012)(426003)(1076003)(2616005)(2906002)(4326008)(41300700001)(5660300002)(8936002)(36756003)(8676002)(44832011)(54906003)(6916009)(70206006)(70586007)(316002)(16526019)(26005)(86362001)(478600001)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 19:44:20.0258 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ff8bef-e7c5-49f1-b8a2-08dbe61342ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5745
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
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com,
 Jun Lei <jun.lei@amd.com>, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
We've updated the table but the values aren't being reflected in DML2
calculation.

[How]
Pass them into the bbox overrides.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
index 30d78ad91b9c..21c17d3296a3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
@@ -329,6 +329,15 @@ void dcn35_update_bw_bounding_box_fpu(struct dc *dc,
 	/*temp till dml2 fully work without dml1*/
 	dml_init_instance(&dc->dml, &dcn3_5_soc, &dcn3_5_ip,
 				DML_PROJECT_DCN31);
+
+	/* Update latency values */
+	dc->dml2_options.bbox_overrides.dram_clock_change_latency_us = dcn3_5_soc.dram_clock_change_latency_us;
+
+	dc->dml2_options.bbox_overrides.sr_exit_latency_us = dcn3_5_soc.sr_exit_time_us;
+	dc->dml2_options.bbox_overrides.sr_enter_plus_exit_latency_us = dcn3_5_soc.sr_enter_plus_exit_time_us;
+
+	dc->dml2_options.bbox_overrides.sr_exit_z8_time_us = dcn3_5_soc.sr_exit_z8_time_us;
+	dc->dml2_options.bbox_overrides.sr_enter_plus_exit_z8_time_us = dcn3_5_soc.sr_enter_plus_exit_z8_time_us;
 }
 
 static bool is_dual_plane(enum surface_pixel_format format)
-- 
2.42.0

