Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C41F0C001B0
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jul 2023 19:27:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B58010E2C5;
	Mon, 10 Jul 2023 19:27:45 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4768D89D7C
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jul 2023 19:27:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hd6C6gEh+QfsrfQnz765XQfIuM4q5lyNj91eQPeY3v3cJlnKu0dcx7zzexo5HQDHfdVpmjnXvmPOjNSUydDvr2mNQDib4fP0spWDCayij2UsEB5nwvNv0OypbtkUbYOWKVgRSoYk3b72hAze8Wv5vUqEItlgSb2QInx2E6hW3k6DMRfBmCQgAzSbIuv4NgUHR6g/13PnesfXSQzhdRA4MmPNkr+qtwZtNqfmsxC4q3EdYT0oZ5D9J1XQfkIhLz0ImA2aoXc1QuLJeCynf1X8lnqhI7dGU82xiGbAlVrgwCVDHRwoWQdQIx6/k/yCUmd+x+z+DkeHVIPZhbvyklUHwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KxroRB6kAQ9irqSV/Gtoa4fDvFWV3MSHcH+v3ScsaoM=;
 b=TVTBfXxSPsw/6Wi2SVN3xDjJNFOAKE6j6qr6Dp2OLBqUwmTrW7xve5zNk7c/kuI/r9BjDU2uCWxPD5rb265DHUEeKqbreLnguIRsliac9hqChmRah1hCnJcTc15Xx94qEqFkFAAqN/Gna7ja2NqzbzalCALNI/b3o5ISksfq37dxfLk4cI8oEirvDSaLjsLJ1E0SwFHCeHZqGzXDlFE6tmTxDsDYy4WaW3lIpzZ+p6BroQf5cWk+rYHuvqMbLCEvRfyHFydpw5qni4324/vlYvkoZanFlsFC5aE48ODdpN8/N4WCXqcObRiHB+eYo7dMosWjumLuP0vTqrI+N/iJ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxroRB6kAQ9irqSV/Gtoa4fDvFWV3MSHcH+v3ScsaoM=;
 b=vSkSMCccY0Sz8aCKrEHNe/zQwcvqa9aBuVCaueWptr+cHVcfJa3fK3YofYBwILGFW8nUswOn6b/ivyrfAqa2vpLbU3RQ5SaWidMJTmfAO8BCrw/FKh9ghqk1D9ucSeqc2O/lC0oKyXGGO7D6nRvKRm6L3i01JS518nHYGBiraHE=
Received: from DS7PR03CA0149.namprd03.prod.outlook.com (2603:10b6:5:3b4::34)
 by CYYPR12MB8940.namprd12.prod.outlook.com (2603:10b6:930:bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Mon, 10 Jul
 2023 19:27:38 +0000
Received: from DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::22) by DS7PR03CA0149.outlook.office365.com
 (2603:10b6:5:3b4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31 via Frontend
 Transport; Mon, 10 Jul 2023 19:27:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT096.mail.protection.outlook.com (10.13.173.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.19 via Frontend Transport; Mon, 10 Jul 2023 19:27:38 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Jul
 2023 14:27:38 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Jul
 2023 14:27:37 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 10 Jul 2023 14:27:37 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <harry.wentland@amd.com>,
 <alexander.deucher@amd.com>
Subject: [PATCH 04/10] drm/amd/display: Read replay data from sink
Date: Mon, 10 Jul 2023 15:27:27 -0400
Message-ID: <20230710192733.1344403-5-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230710192733.1344403-1-Bhawanpreet.Lakha@amd.com>
References: <20230615203930.1715722-1-Bhawanpreet.Lakha@amd.com>
 <20230710192733.1344403-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT096:EE_|CYYPR12MB8940:EE_
X-MS-Office365-Filtering-Correlation-Id: 612f0f54-3627-42eb-e3d9-08db817bb8e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zGXxz9KFUr10TGUKX/WJA8GhjngC85pTjqOAQLPybId8Cxf44J/mKEV/qI+0NvC3lE2IervohhacXMZb2/LNvSqXWF6dGeUzfX0QzMcikU84h6VsvQ07eVXiFuGQFmHhOYBGoXO/5LEa4LWqUGzAnU6F6/peD8wQyNN3X8KGiB/8kOjZXwelPs0WhGi9LPxfM+aWe3xbcRTB4MDUeW72+Nr49mymymcazxDVp4keowz/r2UsjKOjN+dBJ25dlJVhA9k9lc6DcosBbJIVy7nl9CkUEnT31VdR59H2+Sf/uINwWMCUMoCvzY6AcryQdq9ycmRuKQGYgl8XymJiRko84K3hoFYReaAFc2cvypI/qsYP/tiTvLc5/hDWwpNRxSPMJ4gmFYicMaDFm1iTzkKA4KplLKNIXKYheLsvjNQZEAqq2R6dyqVuerupwCSU0/oZfI1oLI3uwaz/9wbuNTAE3y8Zm421epz/VAczYiVtHGA90q7a009wU77CDQnxq7/ORnQYahOZAEHjomRMDtjmM6KALo55JdgvzKSecwEvlw6PjZaujn2POgvc5yrB6I46oFW+DfEFRrm9r/wmIn7nlsJOTNsWXkCR2qjNdSzjtIM/Maz6jha3TWSlXcsl4wc2XDikuhXinYIq87C1QTVKbjXugbtAF3KoqMNE/jwxZCvfXpLZ6kKrHT4sPQNtDsMVLcXDKKrDVikEXNdNV+giDFUzfgilVYetdYWpZWmdga6nRzoUQWj0CazIISouFSohD33y4CPNPY55cWnfUF/K4A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(478600001)(7696005)(6666004)(110136005)(26005)(1076003)(186003)(70586007)(2906002)(82310400005)(4326008)(6636002)(41300700001)(5660300002)(8676002)(8936002)(70206006)(316002)(356005)(82740400003)(81166007)(86362001)(40460700003)(36756003)(36860700001)(47076005)(83380400001)(336012)(2616005)(426003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 19:27:38.5244 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 612f0f54-3627-42eb-e3d9-08db817bb8e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8940
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Read DP_SINK_PR_PIXEL_DEVIATION_PER_LINE  and
DP_SINK_PR_MAX_NUMBER_OF_DEVIATION_LINE

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../amd/display/dc/link/protocols/link_dp_capability.c | 10 ++++++++++
 drivers/gpu/drm/amd/display/include/dpcd_defs.h        |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 3a5e80b57711..5eec5d9bfd68 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -2008,6 +2008,16 @@ void detect_edp_sink_caps(struct dc_link *link)
 		core_link_read_dpcd(link, DP_RECEIVER_ALPM_CAP,
 			&link->dpcd_caps.alpm_caps.raw,
 			sizeof(link->dpcd_caps.alpm_caps.raw));
+
+	/*
+	 * Read REPLAY info
+	 */
+	core_link_read_dpcd(link, DP_SINK_PR_PIXEL_DEVIATION_PER_LINE,
+			&link->dpcd_caps.pr_info.pixel_deviation_per_line,
+			sizeof(link->dpcd_caps.pr_info.pixel_deviation_per_line));
+	core_link_read_dpcd(link, DP_SINK_PR_MAX_NUMBER_OF_DEVIATION_LINE,
+			&link->dpcd_caps.pr_info.max_deviation_line,
+			sizeof(link->dpcd_caps.pr_info.max_deviation_line));
 }
 
 bool dp_get_max_link_enc_cap(const struct dc_link *link, struct dc_link_settings *max_link_enc_cap)
diff --git a/drivers/gpu/drm/amd/display/include/dpcd_defs.h b/drivers/gpu/drm/amd/display/include/dpcd_defs.h
index f72023a296a0..914f28e9f224 100644
--- a/drivers/gpu/drm/amd/display/include/dpcd_defs.h
+++ b/drivers/gpu/drm/amd/display/include/dpcd_defs.h
@@ -174,5 +174,7 @@ enum dpcd_psr_sink_states {
 #define DP_SOURCE_BACKLIGHT_ENABLE	    0x32F
 #define DP_SOURCE_MINIMUM_HBLANK_SUPPORTED     0x340
 #define DP_SINK_PR_REPLAY_STATUS                0x378
+#define DP_SINK_PR_PIXEL_DEVIATION_PER_LINE     0x379
+#define DP_SINK_PR_MAX_NUMBER_OF_DEVIATION_LINE 0x37A
 
 #endif /* __DAL_DPCD_DEFS_H__ */
-- 
2.25.1

