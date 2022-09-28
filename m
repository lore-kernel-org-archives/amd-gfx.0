Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2754C04A95
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 19:42:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0512510E9BE;
	Wed, 28 Sep 2022 19:41:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E805110E9B1
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 19:41:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQm6heWpm8KCLsV6eqkJx/UcX7ez2tC2nIJBRX/ZEen/UPQGxhHeDUzkujbPzxOpVBHAhs2k71CIEBG7AQBA8Br0Q8Qh9FhbfVFyh2zQ7x7ippXk5lCG5CIObE2kWcZBl3ZafNneIegGl9HXTeTxPsmX9mJGnfWhPX6Uzjr8A9hcPHJcMBtxZGv7XDe4Y/VEnFycsHL+SNX+dd5zzs1UjD4pZCI88Q0T3GliZYPy7+JYil+Qn4GzSJXpXT0/nj3UAG5KW1HCKmjaqGsvIn/BL2bphocRvyGenuNpjKcM4F43KJX2tuBzrn16IGV9A3oDcWsE5SVOLjCNhQu0/h/htw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yARt9iEN34DIn+okFzv9iwE7enHYNV7vO+fxwacgGl0=;
 b=e+pGXVEuaIG19njnpAf4c6e/x3rHnKOaB3D1yK322qS3IMsF5URYbp9m4u0h5Jyy/1krygb4Ag4k+bQ3Un6PYAMkV7xmcaHPauI6QWRCWCO+nS2/F1V9/zIMtNsmXrxZpjvKTyTidUctp+iKd3+JBqlcZ+TCncQrumywX+m9kPIr+9KxMh0JrN800TodoDMtoBg8DaXbTtjay6uDiwp9baIrPUtnKen4NxMV+ivxkTJqEKcU/djJD9uPUCf8Mm7xHCOl9p/e7H34uUF17B68k/Ug5QIc2VuTGWBId/ddyT7iudj8JPl7haEgU/C783+yDRgk2USqBwEQH63QY8kqhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yARt9iEN34DIn+okFzv9iwE7enHYNV7vO+fxwacgGl0=;
 b=oqDda/QL2mOYzrGVJTmx4PAgiCvt315xvmKY37zrEmnGiNnxNl/YkkyO9wFR3vnbE3fl4QUbdguJZSzEiXRsV2f7k4IMsE/2MqMeaNHKZ5Q8QmoLMrdU9wehd2A7ojFLgjU3ol1kaw8PPlUvFbigHKeHVnwWdObbg5bvZISZnbQ=
Received: from BN9PR03CA0919.namprd03.prod.outlook.com (2603:10b6:408:107::24)
 by PH8PR12MB6769.namprd12.prod.outlook.com (2603:10b6:510:1c4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Wed, 28 Sep
 2022 19:41:15 +0000
Received: from BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::36) by BN9PR03CA0919.outlook.office365.com
 (2603:10b6:408:107::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 19:41:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT078.mail.protection.outlook.com (10.13.176.251) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 19:41:15 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 14:41:13 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/36] drm/amd/display: fix integer overflow during MSA V_Freq
 calculation
Date: Wed, 28 Sep 2022 15:40:09 -0400
Message-ID: <20220928194028.144879-18-hamza.mahfooz@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT078:EE_|PH8PR12MB6769:EE_
X-MS-Office365-Filtering-Correlation-Id: 715d8cb3-ecd8-4a7a-55df-08daa18967f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xNUg+zsV7vqdN5Gze/fmSlEbv9G40Tm5/bxVyRv7wvOX67PhytTcg4NIp3smW8yH5jgPG6E94zT2jBKA16mnkdW3M2YVdHmtnECEuP5rRfojtNBl58O7dUQrH0+JomMVftGcST09cQU47/XLBTbN5/6ziITMB4p+78oQ8bIlH8xA8E4bF/fd5eVeyWYXfVtQFGBQ+5stidKjxZ0LvTbcStghBKBuZAZmo88d9oMOld6HKdriHWwvzRu5YN1yurBXOR+PlDbUYzQranVzzmXP2xgvktXTW564qsS1UWDqghzF8Eg0/MqRJoLH0yJJ37JYrYFZeMu1w4AmehPo0hJk1760RrnWVEZSF4tpcsucpUFi4IAJQNoyAYyCc6x7gCgh11emJ6d9aY5S5P3P5aGaspm2eMdFB7ibLe3fiL8uV8qLzDhrtKnLU/PFbEv94aLhh+rSfpWSIo/qFlYwaT9vB2WraOwQ/QxfjjH7Q0Xi4o5RnpT7Hw+tonW4zz/VjygGykfz1G4EdqcCfy+ff3sCHQvFU+wZWVS6BmEIlEBaPQsVJ/x97EJUo47KghHbovU/Lh4xDP+0k3tZJuyHlAWFoFm7feaUZNUaBQf+GowNDW2tfT5U5r937l1uKp7vNZg6JJLPqeAKvWcqGAt6blU0w/v9qKGbSBhXiio5go84Z2aXKzVnvsO2x5xo6XpO86Cq5Vi3ApRj9UB2Frg+f4b6E+kgRMxMuGDjz8bLCdk1DtUrKyvGBgrUfaQJ8dpCzvIq1Q4R+tJSmalqdXPMw3EY1n/D/DIzHyfODXxspEKLM9bV6f0DjbqVYonCNN0QxT3gWyBxU6mlUaAWRBCdMPWqDQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199015)(40470700004)(36840700001)(46966006)(86362001)(81166007)(36756003)(36860700001)(356005)(82740400003)(2906002)(186003)(1076003)(16526019)(336012)(40480700001)(40460700003)(82310400005)(5660300002)(44832011)(26005)(41300700001)(7696005)(478600001)(426003)(47076005)(83380400001)(6666004)(316002)(2616005)(4326008)(70586007)(54906003)(8676002)(8936002)(6916009)(70206006)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 19:41:15.2157 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 715d8cb3-ecd8-4a7a-55df-08daa18967f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6769
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
 Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Ariel Bernstein <Eric.Bernstein@amd.com>, Hamza
 Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
Analyzer shows incorrect V freq in MSA for some large timing.

[how]
Cast an 32 bit integer to uint64_t before multiplication to avoid
integer overflow for a very large timing.

Reviewed-by: Ariel Bernstein <Eric.Bernstein@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c    | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
index 52fb2bf3d578..d71d89268a07 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
@@ -197,7 +197,7 @@ static void dcn31_hpo_dp_stream_enc_set_stream_attribute(
 	uint32_t h_back_porch;
 	uint32_t h_width;
 	uint32_t v_height;
-	unsigned long long v_freq;
+	uint64_t v_freq;
 	uint8_t misc0 = 0;
 	uint8_t misc1 = 0;
 	uint8_t hsp;
@@ -360,7 +360,7 @@ static void dcn31_hpo_dp_stream_enc_set_stream_attribute(
 	v_height = hw_crtc_timing.v_border_top + hw_crtc_timing.v_addressable + hw_crtc_timing.v_border_bottom;
 	hsp = hw_crtc_timing.flags.HSYNC_POSITIVE_POLARITY ? 0 : 0x80;
 	vsp = hw_crtc_timing.flags.VSYNC_POSITIVE_POLARITY ? 0 : 0x80;
-	v_freq = hw_crtc_timing.pix_clk_100hz * 100;
+	v_freq = (uint64_t)hw_crtc_timing.pix_clk_100hz * 100;
 
 	/*   MSA Packet Mapping to 32-bit Link Symbols - DP2 spec, section 2.7.4.1
 	 *
-- 
2.37.2

