Return-Path: <SRS0=770C=P7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21F6C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 00:55:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B731E61213
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 00:55:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B731E61213
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6970E6E9AC;
	Fri, 12 Nov 2021 00:55:16 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 579B86E9AC
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Nov 2021 00:55:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMAsCUVKFdDG1vc5gMGy8xy7IZgBcyB2Ay0dgzXnqlzUxbXmN6quvHni0a4PtxhEzUQ3cFuSlxAlKExjo9B30/i/GdhkbIr95lzne2XJYgH2l4GHAdDUW3kGYqI8xFh+XPmCGv8tGv0IethE7ebImE+ie4L5hgNjcSJMq5pdNcGIrFARth88j3TgN3wFBmWpfYu0q8X56eKOFRTa+P67c/hSe+NKZ6902hgYLeJQZnIAH0tmc6KpwUcGvsE5ynHF+q/mkriG7oQTVvt92v6V1TkRqLdjejfWvc4w5WYAFgFrjVDrn0zRk6RuC1JSWzpqOXFhFgS/c5obQq1uVrEuSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICy/mdGK8vHii/5dkn4qtnOM6QkYsHR1pePCGHLEd9c=;
 b=n62XuO2yTlesHwaQaDWMr6o3rlhABnKw9Tu7DKT7RyRqiosjMTPYgyQwjCLr469Yk6IQtUQGeT3mj5UVs8zd4DMGyo/DDRcO/lJSJsi2lS1YzU64YU8X4GCkleIYnYn3X4Z6wOQbScOkYPvEtJF/qT+ufJ5JDpRBzfm/OrPmlYeV0xQEmvRK1vq80WmSpIamzQ6tfJJBLa1S0rsW9C9/t0tz6X+f7xiFzVZmZF0n+yAfBbna2i+84liGUi0mo2KsvqeFwIgGwiEfrg2CSVIKC+IJB8y2cqZ2DDd1Y8bsVvgcseO50gcN4Ja9+uhq0SVlFmnbMiauLde4UlPAfoo7aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICy/mdGK8vHii/5dkn4qtnOM6QkYsHR1pePCGHLEd9c=;
 b=34e2oJaC6IHNmhYkeMGqo8DmlrVcHPJB8w1rKjBgWj7P72n1QqcIUcd3diApR8FgOztg56fVP6pNB6bmqj9kJvLuT3vuQ8QN9PhORBKvWm7+xzP1ijZUbpsIPQPJvpevH+5IbYbvLfJ4BvpPEYYToMpDKi2jZln4TmSRdkOa8ps=
Received: from MW4PR04CA0116.namprd04.prod.outlook.com (2603:10b6:303:83::31)
 by BN9PR12MB5321.namprd12.prod.outlook.com (2603:10b6:408:102::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.19; Fri, 12 Nov
 2021 00:55:12 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::9d) by MW4PR04CA0116.outlook.office365.com
 (2603:10b6:303:83::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16 via Frontend
 Transport; Fri, 12 Nov 2021 00:55:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Fri, 12 Nov 2021 00:55:11 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 11 Nov
 2021 18:55:10 -0600
Received: from wayne-Bilby-RV1.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.17 via
 Frontend Transport; Thu, 11 Nov 2021 18:55:07 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/14] drm/amd/display: set MSA vsp/hsp to 0 for positive
 polarity for DP 128b/132b
Date: Fri, 12 Nov 2021 08:54:28 +0800
Message-ID: <20211112005438.5505-5-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211112005438.5505-1-Wayne.Lin@amd.com>
References: <20211112005438.5505-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e22f63bf-7b74-45f9-f007-08d9a57714fa
X-MS-TrafficTypeDiagnostic: BN9PR12MB5321:
X-Microsoft-Antispam-PRVS: <BN9PR12MB53214975DF98256E7C094895FC959@BN9PR12MB5321.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EVe0htpfDglmZU/XljjZCHLaduYIMv3H6dSpf6YvN7hAS2cd5CnJBiTeGJIQYxikxpm/OZ0atByA+GkTGkBY5u7A7jLK5u7Gu6sDyBAG9WjHTTh9pa2bH3qlaqIDUVk3dzzOUOqViDysfUGpHCORHg6A16cKRkhVVHChzeLvwwd/JA2c5NfJJZnIIPeIRmTp8th2KiY4+jySQQ8TcEuYyaK3KTJrL6bEZhbH3+99hwAqMQyXbx7fdF4BKjl93AcMjqGKY9GPWuUA5IKVrstGt12/gSTv4SHP9zT5sXFAcg8UFE4y2jjNJo/a+1Z5s8UjeMWim/gdz29sOeuBd3O5xYAlQQdMQT27NJiYquJct3CKOrhHNyfLI7NuYUul8sj+aLvugjdgws1J56AsZOmtd1w/MijKuTkXPQVHs1JVvEgdVAwUFyrzPSod9LYvrO3nnTjpy61cBpsBc3PPjovvuHXvN6qfy2uS3udaoR/aNYREMgWvlCKnt+wR2oNfxJbAFDlWAawOvHXLd+brLoYLFjrZhYw+KqX3Td1uFmLA+BWBNPgLPY5BRtmhH0gp9ygR47eT/iyJ/g6/uvktNRLsJiTY1HZ5MNkTUZbBPy2JoROF+E3/m7R5T0rBS7VRvrVA/UqZuRPF2yvGRL2XNRz/s1TJd00/91FzuDBtxZ5R1VHBI/QgXMELMjm2zo5bqFI3dI9QXvd6RuUUQtJRCxCFqOEvSmGqR0yFtlmyikUwGH0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(54906003)(7696005)(508600001)(2616005)(82310400003)(316002)(6916009)(2906002)(5660300002)(86362001)(4326008)(36756003)(1076003)(36860700001)(8936002)(8676002)(6666004)(70206006)(70586007)(81166007)(356005)(47076005)(26005)(83380400001)(336012)(426003)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 00:55:11.9767 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e22f63bf-7b74-45f9-f007-08d9a57714fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5321
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
 Aurabindo.Pillai@amd.com, Ariel Bernstein <Eric.Bernstein@amd.com>,
 wayne.lin@amd.com, mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
There is a bug in MSA programming sequence that mistakenly set
MSA vsp/hsp to 1 for positive polarity. This is incorrect.

Reviewed-by: Ariel Bernstein <Eric.Bernstein@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c    | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
index 565f12dd179a..5065904c7833 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
@@ -358,8 +358,8 @@ static void dcn31_hpo_dp_stream_enc_set_stream_attribute(
 
 	h_width = hw_crtc_timing.h_border_left + hw_crtc_timing.h_addressable + hw_crtc_timing.h_border_right;
 	v_height = hw_crtc_timing.v_border_top + hw_crtc_timing.v_addressable + hw_crtc_timing.v_border_bottom;
-	hsp = hw_crtc_timing.flags.HSYNC_POSITIVE_POLARITY ? 0x80 : 0;
-	vsp = hw_crtc_timing.flags.VSYNC_POSITIVE_POLARITY ? 0x80 : 0;
+	hsp = hw_crtc_timing.flags.HSYNC_POSITIVE_POLARITY ? 0 : 0x80;
+	vsp = hw_crtc_timing.flags.VSYNC_POSITIVE_POLARITY ? 0 : 0x80;
 	v_freq = hw_crtc_timing.pix_clk_100hz * 100;
 
 	/*   MSA Packet Mapping to 32-bit Link Symbols - DP2 spec, section 2.7.4.1
-- 
2.25.1

