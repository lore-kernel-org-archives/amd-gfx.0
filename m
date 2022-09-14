Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55DD6ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 05:16:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FB1710E83D;
	Wed, 14 Sep 2022 05:15:55 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06EF910E83A
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 05:15:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qgt/Zh4YUsYnG/T+x+Bt62OhFywjDQo2gbeVQ4ETebH6BJT2JQzSZpuxL6sdXoYWTJFYIDG+6kVYxadKU3GddAng1aKNA4Kp+1R/CCcH7k2c0a+j6ZcMfLjmeHV8VRmRfQgbz1KbLupmcy7803Jy3/dS4CnOV2jOKqOrud9Cnr4OUGA6R55RgvqYmBPLPJo0v/b9cc3FzQebkOokhs7SLDhSHLwv/w5GVjP4Da2NSMoMh2np/RGY1+MMCj12hGF6ioGWVRpMY10efMUg6K8iuoKctArHypOp5oF75DzNB6g/fxKN8lt4aCfjJNitpjc73sLaQDQbC7KU8mThNTlNyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpdw30ij4Fwu8LPqV26bibIITnnD9ShCLNuGUxOJp7A=;
 b=k92SezC7k25H4bJPkgD6Wj6RrRwfQyf5YxJPIUiWQZ1+uMl0EY2XHxeXHps/wRc+6o04ctNDiX945kho8d0Pn6uP5G3Vkd/0f+A++fuvFBkQUMeK/JwnpTFeEQe91QRXwrlsGJz9xT6tiJlL3Z0inhPxFPs8c/lmUIYcC5IP65I6+23Sx4v/WQLGqlXtMVpA2fd1eOGKlTMpYbcSYtmG2DgDS1A4jfQSmHfFT+PS+uArxHwlZLhPOd9qD0ADOLUQGopEE11w2rvZEskidu83pjAaPsG8Hcark4YzHatvrm93Z8Tg3sGKEn+nxXUHP2JRC9Ss9b9Ve50VcuNUgnVHcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpdw30ij4Fwu8LPqV26bibIITnnD9ShCLNuGUxOJp7A=;
 b=xziVfUdf9LXWFmaDbDVwzKBd5EIuAIVAbr/729CyA95aMgWWpJ4/UliYqPzxGnm804fyjH2afG45nzrcxYeu3XqDOJ0TBBoF6Gj49FNNawqLiEjff9dR3mNYZXmNCYIn4RsBxwSqb7uFgW2hoAwgu9w2fvjBA/1jNiJKR+LAxmQ=
Received: from MW4PR04CA0215.namprd04.prod.outlook.com (2603:10b6:303:87::10)
 by SJ0PR12MB6709.namprd12.prod.outlook.com (2603:10b6:a03:44a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 05:15:42 +0000
Received: from CO1PEPF00001A5E.namprd05.prod.outlook.com
 (2603:10b6:303:87:cafe::2d) by MW4PR04CA0215.outlook.office365.com
 (2603:10b6:303:87::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12 via Frontend
 Transport; Wed, 14 Sep 2022 05:15:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A5E.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.12 via Frontend Transport; Wed, 14 Sep 2022 05:15:42 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:15:06 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:15:02 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 00:14:57 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 23/47] drm/amd/display: Fix urgent latency override for
 DCN32/DCN321
Date: Wed, 14 Sep 2022 13:10:22 +0800
Message-ID: <20220914051046.1131186-24-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914051046.1131186-1-Wayne.Lin@amd.com>
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A5E:EE_|SJ0PR12MB6709:EE_
X-MS-Office365-Filtering-Correlation-Id: 85faf13a-b2c9-49de-78ba-08da96102bff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hCGINudDcE9Fl8RQGBwil0llEGFfMIEsHp2qYHD99Ipi4RnHAg2j0AuecybjV1nGxaVmEG4i0Dk4Qr1IptiBFsCzMYZ0bdSbkF2iOmd64Xy5qpp1KERUY1QElSeanNUbj0nsTWqLs4OUnqnTJF8Vnq26hPb0dfF+yMcWu3UoYuff2LLl36dLefentrb3/vGY0+cPxkZVOJBZ5ywwdOg2tjyVm6Hcv4ZSRAlSDFh/D/4jlAiJR1hxcz6qf7hT9qnixPGopqbCb3OpnkBjk1Io2NxYYdTKVpUJDSH4g7nmyp4HrAf48LmEOTwhqH8Z6j32IkIyecZWYEBBVvOKCnbxKns9ItaI2jcNgsRBKV+EJubcfEH6Kpf2ACJ5nnsm99bmVg1Jm+oJpMHOIIPwjgyhKW4+WC/GQX/5E+m5auCB64T8Dhrok7eZrGXvxm7vhU+nw6yoAf9N0ivnAZkcrOX7IebyC2uQVQcV3pUKjWMEtgUufVfq+9UBX5KyP/uRmuGl0ye9f2jMPkk0ydLgsAKyeOOyH9NWJUA0sstOPYLyZu82fArYfhJ7qlJTnlWB0A59X+SCopZ7vxBoSBTjwEtOsmat7I9PC2JgSUiaq6mgIPsBIF6RS1BZjvbWn3UsmJFW1Vo/HrQ2WwwCmEd+s12UnVuAWZs/hvJ3hPpySIiMn174SALPwcdsaI3Yw8b1R4oKMPj0szdZquHzf/pzErhHQosfUU5vbOYdtE6/qFImtfhJgYCTTgbPMgaNiCkjwdZukRlrGaDmpw8p56WW0sL4I5lr0Q5jSM305mcUIsx6NseVIHpDobxrV001Ar5LdpNx
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199015)(40470700004)(36840700001)(46966006)(426003)(47076005)(5660300002)(6666004)(36756003)(54906003)(40460700003)(316002)(86362001)(2616005)(6916009)(26005)(2906002)(336012)(82740400003)(1076003)(8936002)(186003)(41300700001)(81166007)(7696005)(82310400005)(4326008)(478600001)(8676002)(70206006)(356005)(40480700001)(70586007)(36860700001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:15:42.6277 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85faf13a-b2c9-49de-78ba-08da96102bff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A5E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6709
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
 qingqing.zhuo@amd.com, George Shen <george.shen@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Nevenko Stupar <Nevenko.Stupar@amd.com>,
 Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
The urgent latency override is useful when debugging issues
relating to underflow.

Current overridden variable is not correct and has no effect
on DCN3.2 and DCN3.21 DML calculations.

[How]
For DCN3.2 and DCN3.21, override the correct urgent latency
variable when bounding box override is present.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Reviewed-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 7ff7cd8b5c93..b8d4547a885f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -2197,6 +2197,7 @@ void dcn32_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_pa
 		if ((int)(dcn3_2_soc.urgent_latency_us * 1000) != dc->bb_overrides.urgent_latency_ns
 			&& dc->bb_overrides.urgent_latency_ns) {
 			dcn3_2_soc.urgent_latency_us = dc->bb_overrides.urgent_latency_ns / 1000.0;
+			dcn3_2_soc.urgent_latency_pixel_data_only_us = dc->bb_overrides.urgent_latency_ns / 1000.0;
 		}
 
 		if ((int)(dcn3_2_soc.dram_clock_change_latency_us * 1000)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
index 7ebf25e87933..dd90f241e906 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
@@ -489,6 +489,7 @@ void dcn321_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_p
 		if ((int)(dcn3_21_soc.urgent_latency_us * 1000) != dc->bb_overrides.urgent_latency_ns
 			&& dc->bb_overrides.urgent_latency_ns) {
 			dcn3_21_soc.urgent_latency_us = dc->bb_overrides.urgent_latency_ns / 1000.0;
+			dcn3_21_soc.urgent_latency_pixel_data_only_us = dc->bb_overrides.urgent_latency_ns / 1000.0;
 		}
 
 		if ((int)(dcn3_21_soc.dram_clock_change_latency_us * 1000)
-- 
2.37.3

