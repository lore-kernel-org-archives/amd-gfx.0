Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E01BC10F05
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:29:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A58A10E883;
	Fri,  1 Dec 2023 13:29:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBBF510E8A1
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:28:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gf+yAax9ViViQF1k4hsQwXenRJJE/sDTCJX+ucfm4NjhZ+cfJPgwM75xh4wQkmsHGrE6ltdqx1H79B44a4x8ZQgPgFDR6EaduyK/GWyjZT9S5jx63bDltMsP2gbJ5LTcBHXXDekO3Kn0uKl9ZII6we1pePWIatx5rAC5Tm926m3CspnyYM8bKRo8u1MCO9BMHXqzzItJOXy9p39L3EAM0cbe8HUwVfKArGmMM7e2sC2LP7+rq3coEMvO/zCTJMIR1X90njwdcyOI1wHfQXC/boDyEd8w8YIdiZf6T6kNOmSmIeeSh3FiOEHO66rzq+Z6G3QDfJ3FRPW4SyOkuK3lXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7E9dw03iUrkDSXFl1xXfQic19XS+jPzTCb83TeyOPs=;
 b=E5yqU0HOmXGPUj6MevdyRHMEt3CC55JT8+EBlwcsiYC0iC7+UQSMkVbHK1DGF1sRIx8AitWrwjT5Fg2RmqVVDsCzx8BYdgFpX29V5xtW0rSyXX837XhM5US/j85fBs4+ZrjzKXwpQ3uusC+Z5LhnRFcbVrHJ3ljCGrvjdBsg0PmOy91OkNjVZ6Gzp7qA2LnExs7pg5o7WeLafmfrtrIOTiZ9Sq5RX/UHkGQNz+qfmQwl8oHJJaDjundxuypMXLav6kduoGxqaZG6BBu8DKS0gh7MynR1A4rLjPxSb67kXfB3b2MQjSXTjGFJzxEKwGfK43YUHRCVoypkc4ORmoMTJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7E9dw03iUrkDSXFl1xXfQic19XS+jPzTCb83TeyOPs=;
 b=GuHkdUkxfEzD2Xfm13N38082FU5Jxt9uImd5izYf4GzcfMa2cjtths7ydq8KqhuxZQsKgfnJd8nr9Zj8isv/7o4gDT2BP5fsiNaI95I7UZCuLFZxolehZeC28kBriW2NWZJNBQtkLESd02tqb+QOBC4VHFVrkEUfye2AL3E9VMo=
Received: from CH2PR08CA0013.namprd08.prod.outlook.com (2603:10b6:610:5a::23)
 by BN9PR12MB5322.namprd12.prod.outlook.com (2603:10b6:408:103::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 13:28:30 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::7a) by CH2PR08CA0013.outlook.office365.com
 (2603:10b6:610:5a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27 via Frontend
 Transport; Fri, 1 Dec 2023 13:28:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:28:29 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:28:26 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/47] drm/amd/display: Pass debug watermarks through to DCN35
 DML2
Date: Fri, 1 Dec 2023 06:25:12 -0700
Message-ID: <20231201132731.2354141-17-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|BN9PR12MB5322:EE_
X-MS-Office365-Filtering-Correlation-Id: 48bfd98c-d616-46d3-98cf-08dbf2716855
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XdAeVFAHRhj4N0sSlHf4yeCu+vD1gc0b7+eI30NSJsaR1eYkECN3KypbkwDvuoYoZBt35xGw/A893nLIvzJHgPZ6iwbJzOcNR5xnOrCjAs0E7zpkvdCrESxGVpTKaB7ssS+7VmHKksH1Ds+1hgUTSRgZ57QkxttX9GF8FZ1BUgE/sIS3Cx7d141hXWF6f9kCyyqV2bhB6UsASwbhJRNYaqNMAbte7y3KwMP8cNZbYli0Pf/Ijjwsz9arB7jAJSuqRnxyfkArqfkJcJZgQJ976pl/D+5Y2njC/iGm3tvBC+yc/cHox/ORmhcZLOZTY1qSPthHIvv1zmwsdEpB43alnkVpIEeoemF7qStbjGoxha7E/ecjm8gLHYD3ZkxFqlyCqZAn0KVHoCGd82cougD+efKHH+19hfRdGepl0NPqhCSwmQm0FoPLARCyAGwJfbWLHexvaiGgQTRWVrR8jMbuulsou/R22yZ+Tjj2cOYYVvUXZG4m8hIpRs6ZzFdXjw93vwDMhe6Kfq1PtOoouHbNSI8rQITh4H32RW3ZkUY+H/Co5lqpuBRfFuaVY8ZASaH4oARn7m6XYsrjzmsWxfIug2fj7E91OaIK8XkQ+ef0lA1Y6eJxxOviym5lu+lc4PHw7O44I6cK28OuSaGAWcFhQXzZWXnp0J8ba9zg8R2GjRBvzBJ5NDPzvwSNR63xH+HOgkKBIYWDqjmbirODcoGhX+Rwyl3bRNvQFaZpadHLUXbnmPeyLg2+7nWVv7iup9ytE8pv1nKA+CwLPiJ5UODroQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(451199024)(1800799012)(82310400011)(186009)(64100799003)(46966006)(36840700001)(40470700004)(426003)(336012)(83380400001)(82740400003)(16526019)(26005)(478600001)(6666004)(2616005)(1076003)(40480700001)(8936002)(70586007)(70206006)(4326008)(316002)(54906003)(6916009)(8676002)(36860700001)(81166007)(356005)(47076005)(5660300002)(2906002)(86362001)(36756003)(41300700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:28:29.7942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48bfd98c-d616-46d3-98cf-08dbf2716855
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5322
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>, jerry.zuo@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 solomon.chiu@amd.com, Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo.Pillai@amd.com, Michael Strauss <michael.strauss@amd.com>,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
The DC debug options currently do not function for dynamically adjusting
our watermarks.

[How]
Hook them up before passing them to DML2.
Also make sure we're using dc->bb_overrides since dc->debug isn't
populated during dc_construct.

Reviewed-by: Michael Strauss <michael.strauss@amd.com>
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
index 39cf1ae3a3e1..e9d88f52717b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
@@ -326,6 +326,25 @@ void dcn35_update_bw_bounding_box_fpu(struct dc *dc,
 		dcn3_5_soc.dram_clock_change_latency_us =
 			dc->debug.dram_clock_change_latency_ns / 1000.0;
 	}
+
+	if (dc->bb_overrides.dram_clock_change_latency_ns > 0)
+		dcn3_5_soc.dram_clock_change_latency_us =
+			dc->bb_overrides.dram_clock_change_latency_ns / 1000.0;
+
+	if (dc->bb_overrides.sr_exit_time_ns > 0)
+		dcn3_5_soc.sr_exit_time_us = dc->bb_overrides.sr_exit_time_ns / 1000.0;
+
+	if (dc->bb_overrides.sr_enter_plus_exit_time_ns > 0)
+		dcn3_5_soc.sr_enter_plus_exit_time_us =
+			dc->bb_overrides.sr_enter_plus_exit_time_ns / 1000.0;
+
+	if (dc->bb_overrides.sr_exit_z8_time_ns > 0)
+		dcn3_5_soc.sr_exit_z8_time_us = dc->bb_overrides.sr_exit_z8_time_ns / 1000.0;
+
+	if (dc->bb_overrides.sr_enter_plus_exit_z8_time_ns > 0)
+		dcn3_5_soc.sr_enter_plus_exit_z8_time_us =
+			dc->bb_overrides.sr_enter_plus_exit_z8_time_ns / 1000.0;
+
 	/*temp till dml2 fully work without dml1*/
 	dml_init_instance(&dc->dml, &dcn3_5_soc, &dcn3_5_ip,
 				DML_PROJECT_DCN31);
-- 
2.42.0

