Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86BF8E7B5E1
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 09:25:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B58510E35F;
	Wed,  4 Oct 2023 09:25:12 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3186210E35F
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 09:25:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YenLlNR0D8cijGWLgSiTjGWjd72Jf8RE14VD9osMy/7TnTaojYtppur+w+ygjWk/a8I0fSrhh3Ejvf/mH+ApAPo5kDNhiYBTpVkfCD9nq8jOyYzP0AgiWFp1dtG6h8GG5w4nXJAg1o7F8xsJqmHzN9sr4fzFCdeEmXV+fHHJt7Jl2+XREz0gqujgdSP00poSdoRpoI66VVh4ypzIXU5aAclTuaptR3lIdlnlGXv2bpB65aIxtB1G4DxTyrkWTQS840ZFPcjHAW4qjZjOKJJevajIcpgnl/yJU3x5GwSENJeDRFzmuRj7GvowZ1tliHrBAA0hG1ZFX3ETrCsoW/wfmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93bpA+tSfMKDAs7Ojd/LaZAU64nRAMIYX5b5/iOMZnk=;
 b=kNGjSZZCnuhqDsnOHDNkqYjL4a0/mUjGo8lcIWnRFurEAlAIAJY7owv/+e7Ub6V8ZsvWOmdOWj7tmj1J2ohFXxcigxD7loOxnxO+sHvPIsIsE6ZmcGKzMba5ekw7P5OIz9VIAKNSAaO3G3D6chSiZHWG4cvHhKnj2W+VhO82TFhyrPujr1A/rWxlaYcM4AsW7HInICXJLmPxUUSpaOFpqUaX39nYAx+i49/JDrpRFBVtYoXbShZU1edOXyhEWh9UT1hCIJucWmz6wV8QUdrBLks2RAgkKXJagI16YmmGth0ey8uo46fTefJ1smYRkMJwZ3rttJeQPfrsFB62zBUbtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93bpA+tSfMKDAs7Ojd/LaZAU64nRAMIYX5b5/iOMZnk=;
 b=zEZHrCxN14YKfq2y9iMyyylK8yCZH6OmqUHr0onqGPYWYTFyR3BMse8DrrAyIea/QWEmmWlQvFU4YjwDklUIXuF7OedM5UoCD994UtEJy9LXFP3sT5wUWZFbyFXa7zcgc0KWLcldARLRUxruNYICsqy9u8OI+N9uQdhbm+9eDCg=
Received: from BYAPR11CA0097.namprd11.prod.outlook.com (2603:10b6:a03:f4::38)
 by PH7PR12MB6465.namprd12.prod.outlook.com (2603:10b6:510:1f7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Wed, 4 Oct
 2023 09:25:08 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:f4:cafe::62) by BYAPR11CA0097.outlook.office365.com
 (2603:10b6:a03:f4::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Wed, 4 Oct 2023 09:25:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Wed, 4 Oct 2023 09:25:07 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 04:25:03 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 4 Oct 2023 04:24:57 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/16] drm/amd/display: Disable SubVP if test pattern is
 enabled
Date: Wed, 4 Oct 2023 17:23:00 +0800
Message-ID: <20231004092301.2371458-16-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231004092301.2371458-1-chiahsuan.chung@amd.com>
References: <20231004092301.2371458-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|PH7PR12MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: 88613b64-aa4d-4aa8-097f-08dbc4bbccbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zkNhEA/Xwyb9Rq+aL7Iy6jzT6yKaiWErGRjnOHe2ZSIopDuPLvlNqnZB5phNz/R+qbp8W3F0Cs3zOYI8p4jpT5QAvUsjPq9t6N3GTuGzYgviDrXqr2AULXTAL9a6nCzlWxyVdT8UyGPLJPuZoi/WEo9MwnadeYkJBKC82viYAh9jYRAJz/hJqTtzFnN0rCrPTiJokxNGayZuUkHUIMZAWbxz9FpxyZoYHR02iEgmfx+2LHjoBbKZq0t0S7sdvgfd5ybgw3e4eOvSVpDkkhxAC9cPd5J6+hwSmQCV/ckf5w+OQPeKM6COoXV2KvqinaoQFI5FBMMQlBGIlk1frMIx/W0ZbKsSJQtoNukf0d5Suz1v+dOBxi0zaR6LdF6y8elQYbTDHBBwAG2tlbVmNgZP3S1mXKRcIqB+kA/SML/NGtPaHDMbNd+BwI9EW1W0ui7cYK6NnN3N+LSjsijFBHFERpBy9tmXh9aad6GG0Z/p2y9RA1CXWKv2PrAjQuROKyKYYtrrNqWaIKsfolLdzhONePrPKIgVSCuZSiyqfc7x6vB+1Ka1VBYayfqvxKSazNyyUH+qpfcy6Mhyp8ghEenfajfnxL4crXl6m2RfbcNN6RuDHXN5QH945TAAxLTZrTUA7bDcz/LJePG9luqwXBti7JyOn4/KfZN2PMkC9c1ph+YCXBnR7HvzCT3E+segUVxom1golZJOZZ+PLPl/wdiOSB6llHE0EcaH6RlQM8nPytRMrLCqCT5aKtzJy4iTjRuWcIsgp4yT0tbEydSzFDo0bQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(64100799003)(1800799009)(451199024)(82310400011)(186009)(40470700004)(46966006)(36840700001)(316002)(86362001)(36756003)(41300700001)(54906003)(2906002)(47076005)(8936002)(36860700001)(4326008)(8676002)(70206006)(70586007)(5660300002)(83380400001)(356005)(6916009)(336012)(40460700003)(426003)(2616005)(1076003)(478600001)(26005)(6666004)(82740400003)(81166007)(40480700001)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 09:25:07.4494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88613b64-aa4d-4aa8-097f-08dbc4bbccbf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6465
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
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 George Shen <george.shen@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Nevenko Stupar <nevenko.stupar@amd.com>, Alvin Lee <alvin.lee2@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
Enabling DPG causes HUBP to stay in blank constantly. If DPG is enabled
while an MCLK switch is taking place with SubVP, it will cause the MCLK
to never complete. This is because SubVP MCLK switch relies a HUBP
VLine interrupt, which will never occur when HUBP is constantly in
blank.

[How]
Disable SubVP when test pattern is enabled.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Reviewed-by: Nevenko Stupar <nevenko.stupar@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 7179c2b3b1b7..4c2c0e252867 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1383,6 +1383,19 @@ static void try_odm_power_optimization_and_revalidate(
 	}
 }
 
+static bool is_test_pattern_enabled(
+		struct dc_state *context)
+{
+	int i;
+
+	for (i = 0; i < context->stream_count; i++) {
+		if (context->streams[i]->test_pattern.type != DP_TEST_PATTERN_VIDEO_MODE)
+			return true;
+	}
+
+	return false;
+}
+
 static void dcn32_full_validate_bw_helper(struct dc *dc,
 				   struct dc_state *context,
 				   display_e2e_pipe_params_st *pipes,
@@ -1426,7 +1439,7 @@ static void dcn32_full_validate_bw_helper(struct dc *dc,
 	 * 5. (Config doesn't support MCLK in VACTIVE/VBLANK || dc->debug.force_subvp_mclk_switch)
 	 */
 	if (!dc->debug.force_disable_subvp && !dc->caps.dmub_caps.gecc_enable && dcn32_all_pipes_have_stream_and_plane(dc, context) &&
-	    !dcn32_mpo_in_use(context) && !dcn32_any_surfaces_rotated(dc, context) &&
+	    !dcn32_mpo_in_use(context) && !dcn32_any_surfaces_rotated(dc, context) && !is_test_pattern_enabled(context) &&
 		(*vlevel == context->bw_ctx.dml.soc.num_states ||
 	    vba->DRAMClockChangeSupport[*vlevel][vba->maxMpcComb] == dm_dram_clock_change_unsupported ||
 	    dc->debug.force_subvp_mclk_switch)) {
-- 
2.25.1

