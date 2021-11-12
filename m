Return-Path: <SRS0=770C=P7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC49C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 00:55:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A69861213
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 00:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0A69861213
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A68276EA87;
	Fri, 12 Nov 2021 00:55:44 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59E156EAC9
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Nov 2021 00:55:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1FyzGJaGM+NuhE6JlwpSUJ5gl4QFqt6OjXS7UjZC/skEgBkWePlxhbvMU5rSyMf7VGsH80nZFCFsaDAx1bzAeqvid6nm6b11SyNH1XjIbNdT4gwhD7wjNnRBQmgzf0rSiCYWTsHD6NkuicVwsT+eq26XxqVy5Pg1Y62YKXlyWSNGfj9urQZiTrtz8Z7dZUqOPYhsnIOlG2Fe2lDm5sLP2hSOgMitQNNLG1Qqkz1sMD7M+/TTqNeUrvtmW7jCEa33K5m9ftdctnRk7AjK8PsuplAyc2w8bf7JDAeRLr4+DO5QMDySMC+uuuGt9qO/Y+rZ66R2yZuMHbnanVQKvSckw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nlKnPThYcePZ7t0xTdetvmyDiiLLx8O87WhDigUT3wQ=;
 b=KBEmwMeV9WpR7fq7yl1/d4RpJQaulcJxnPomhmT5eywEyLvxXyspGHzJu5O2wbBfm8UuvTM2pctMHhGfa7u1iW+6OO8VLe5uihaJxEq6QVAsU5s4/F6w6s9bwZ2uHMXs1AjdvNrlk58aYDdFaeZyDRYlFduM4JyfSW5JIQsjHZCh4xmHIcqILc2qjLYvSSUrXXnthJaK5aUTmUfVTEhzk2DU551KBIEM+sLUH5tbGSsZvSqLkHpFqeBzu0hf4zW7rJTVSf52gtkyx05Yu3hFUPGr7a13icFWe33RWc8jgV93OfhNZ+8rGTCmE0DzNE/SbfzZ5iaCdLIQxb7ZYARqnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlKnPThYcePZ7t0xTdetvmyDiiLLx8O87WhDigUT3wQ=;
 b=1aWXwY8lMfZSQkKiA6IVeZiE020cJTOWAv6y3N3VVuohCoKD6o5OiRhiBt164Pp4PxRIvuGu0m9CsTn1HZXfa3jRfDiwkfPz2lSfw49aKGhOJuzLuEUYwFAadARH4Q2AqFlcPm37oUqZ9TO2xE8afrK2rudONslZOwVl7DTO97M=
Received: from BN6PR11CA0053.namprd11.prod.outlook.com (2603:10b6:404:f7::15)
 by BN8PR12MB4979.namprd12.prod.outlook.com (2603:10b6:408:75::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Fri, 12 Nov
 2021 00:55:37 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f7:cafe::4b) by BN6PR11CA0053.outlook.office365.com
 (2603:10b6:404:f7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend
 Transport; Fri, 12 Nov 2021 00:55:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Fri, 12 Nov 2021 00:55:36 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 11 Nov
 2021 18:55:36 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 11 Nov
 2021 18:55:35 -0600
Received: from wayne-Bilby-RV1.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.17 via
 Frontend Transport; Thu, 11 Nov 2021 18:55:32 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/14] drm/amd/display: Fix eDP will flash when boot to OS
Date: Fri, 12 Nov 2021 08:54:32 +0800
Message-ID: <20211112005438.5505-9-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211112005438.5505-1-Wayne.Lin@amd.com>
References: <20211112005438.5505-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a808f591-5bca-4184-6f33-08d9a57723b3
X-MS-TrafficTypeDiagnostic: BN8PR12MB4979:
X-Microsoft-Antispam-PRVS: <BN8PR12MB4979DD40BF1D8962F10D6213FC959@BN8PR12MB4979.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lrAkoOtv1Wp9eOKNNXaNrNu2FLj0CXD8JFrzOoYm5XGWG+cSHQHCu9/I9zIdX+bEvnGR2udmQeyr+42pcLDxwTvR09ruK6RILxSbsElnT1zqlV3dUeXm6HpNI4UM6qiVkmOK/x2uDlAfQY9pFc+XTNK49DdAu2JXTXOt3YGxKK/QA+3G4WtXh9gWKcLqrcFb3UdKx+9lG/88FlbphZds7KDR0+xL0aZq/zGe1oqkLch6TsHG5cNOHawSxomdXY+a+rebl9/cDfA8mOX33w3KPdibaquOTShhC/wjBF1uFyEzsMVq1U4ohcrEPD03VaupVRD+FQMSxOMId5m7MVjfAgylzAcViaw9cIn8iRnqS7o6W7c3+Xs6WQ7E7N/OMs7I5gTwpG/t+E4BnEvOlGsWTq9SEOem2weK9xnjglFTuXOD9XKNTGo+mTe9jqqbsryWVcLrl4T/9vlghDdp04ccAMhCbxB/5QHa0pEVVDmJ7TNVn0emrLHNDqfyAeSPAcu2vFQr5lWuOj9sgm9jwcieUhWcS9pEWII9IzTjdHrBfinj04kWtkGm+oZkHKfZ8IMP7dxHf6C7KsTqd/L0y+FK3mLySzbvHMQs3CLJXFCGZgm6wcRm/NHql4F7C6dfFYK87tl1cpE4EzzvAbsfFhUaswkBze5ofLZvkmLyXNmx5K/WoZyS2CFde3F+07M0oQaGJvRKMlIXNWrdAJVMypTboosERTrc34hz9s329J9PzrM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(36860700001)(5660300002)(2906002)(70206006)(508600001)(26005)(8676002)(4326008)(54906003)(70586007)(186003)(6916009)(336012)(356005)(82310400003)(36756003)(316002)(83380400001)(7696005)(8936002)(426003)(2616005)(81166007)(86362001)(1076003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 00:55:36.7839 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a808f591-5bca-4184-6f33-08d9a57723b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4979
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
 Brandon Syu <Brandon.Syu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, mikita.lipski@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Brandon Syu <Brandon.Syu@amd.com>

[WHY]
With eDP DSC enabled and set 4K 60Hz, there would be screen
corruption when booting to OS or enabling the driver.

[HOW]
Avoid powering down VDD when we cannot apply eDP fast boot.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Brandon Syu <Brandon.Syu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c            | 5 ++++-
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 2910188ba514..6379b4a4757a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -6045,7 +6045,10 @@ bool is_edp_ilr_optimization_required(struct dc_link *link, struct dc_crtc_timin
 
 	req_bw = dc_bandwidth_in_kbps_from_timing(crtc_timing);
 
-	decide_edp_link_settings(link, &link_setting, req_bw);
+	if (!crtc_timing->flags.DSC)
+		decide_edp_link_settings(link, &link_setting, req_bw);
+	else
+		decide_edp_link_settings_with_dsc(link, &link_setting, req_bw, LINK_RATE_UNKNOWN);
 
 	if (link->dpcd_caps.edp_supported_link_rates[link_rate_set] != link_setting.link_rate ||
 			lane_count_set.bits.LANE_COUNT_SET != link_setting.lane_count) {
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 665cf58b0724..3d421583e9ca 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1833,7 +1833,7 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 			}
 		}
 		// We are trying to enable eDP, don't power down VDD
-		if (edp_stream_num)
+		if (edp_stream_num && can_apply_edp_fast_boot)
 			keep_edp_vdd_on = true;
 	}
 
-- 
2.25.1

