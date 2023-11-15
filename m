Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEBF8C072A2
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Nov 2023 19:45:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7608F10E598;
	Wed, 15 Nov 2023 19:45:00 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F16A810E58F
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Nov 2023 19:44:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6sPCM7B4P8PC5jZvZIrr/WQvydBdIvDVBwrQ9OryWycl/IYt7D8GGH8SlojVigUqrn84lyvglozRMMuFR7CnJy5V5bRO97mUS2jGjuPBGYuwUWF4c3OmrivcLAYodKCzkC206KbEz/LY/JCjVtQn4B2/1G0KHsoVYFgWqIkV6sPo9S8/S4KgMIr3aOns11foq6FQwyL8S+sTpOzFDcvkB0Hjb2lGBP+wnV8YTfBRRVjCsXJnh7J6iY66UO/JnVQu1yHI84zJ/HZV6A3lACk5k9Ou7D6s90iJGyP44kXnHMuPtzjLKggetcDM2yAdLzaBBHQWxk97UZPSsYDgCKqiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvZSHlR89Lii8sUBbwM8s/lvjzGarxLd9NAfQ1mXGCM=;
 b=ipJjFRmvgOJDUUguljEIySqfefnkCviPesVjzW2ZszRa8uoFytOv+VwUOYr/xcBLjJAv1zxBT4PmIRQytL/LV0GKjbF8VOnwZPe6GJjCxqDL7VN3FvlIQRMZ8fHEbpZM24iKKQLzVoKGh5quDpjpBRqzlttc0lBw+Kny5p8Clodaq54pE7kBae2p07mcHxymrUdtyF4GngMiBa3UuV2vTZOiCyvy+vSIXUVua5wzNBMgjWAaUsm3ROG87r8rQn+PvdmOPf4j0yXIjr82LYZyJJqyzY943YTibP9vQ9GJi6jyLhN1KfrW2sh7i34luZCjoBNMG4NovDwlPL2zxkQxBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvZSHlR89Lii8sUBbwM8s/lvjzGarxLd9NAfQ1mXGCM=;
 b=KpPeIR1a4qsWwltGrE5agSFbR9bh3A57BRzoW0/VO+qv4GfK4Gcmbp09HSLSWQcoj+5HQOjbUnvu7OZZthVe9A3+3yWDxXtIom950NEq2Nz7PaEL0h29zJrzIvjbJo5O5cqx1KrCtzzuOIqRZrsCWKluXux6vSaLjEjsnXMGOXk=
Received: from MN2PR14CA0008.namprd14.prod.outlook.com (2603:10b6:208:23e::13)
 by DS7PR12MB5957.namprd12.prod.outlook.com (2603:10b6:8:7c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.34; Wed, 15 Nov
 2023 19:44:40 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::29) by MN2PR14CA0008.outlook.office365.com
 (2603:10b6:208:23e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20 via Frontend
 Transport; Wed, 15 Nov 2023 19:44:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.19 via Frontend Transport; Wed, 15 Nov 2023 19:44:39 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 13:44:37 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 26/35] drm/amd/display: If P-State is supported try SubVP for
 smaller vlevel
Date: Wed, 15 Nov 2023 14:40:39 -0500
Message-ID: <20231115194332.39469-27-hamza.mahfooz@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|DS7PR12MB5957:EE_
X-MS-Office365-Filtering-Correlation-Id: a79c9e89-e637-44d1-a4b9-08dbe6134e63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ZiMnB5oK9XKyVEy32ESKyVApitiWs0sjj7chk4tJH9cb7RnU+TlDljgqnKqoX1sTncBap5WcytvzyD7psFOZiS8UjD48O4OlHB6M4MreRXGK4zyx2UHJ1jK5To4Tu7BIgnWEV9juQj3LFPqNzwVaUqFPgeCoha5XSbSTmFXEbzbvpAtRmYHF1acH73c5MAXAwIrN8v1TuSuve9hJDFbn2KBF+nv6U0m+smggTuex7AgFSmrrPAvpTLDYn7tPF3f4kWgBHU/lEp339suh7hEEZje6AhLsge0Iu59wBm+8JMXZz10mqt56VObaIwQOXWPSMilO2t+hjLaRML8BRXo8Q036fFHDIwDAr3A5bHUzxj9zen8kj9Mra+jWh9BC56JXNEvf0wW1WH2PXApZvrIK69vXCfyZS7d42TKe+Eu1cDYKLGl8j0NSo2cg29nmJ3uDbx5BkLQeiHBfuwF4Gddjlns+RBZzSvHD4pMPJc8N668oSrfP9osewdpKcurD9+PqsTTSFhTxLfmnWfdVY1zbxaBrk2H68MAW0+Ut1i1pidFQcZDbpbSOS8CRZ7vR6m6zAMslx8CS8jtPb1+cjNj9ya+6tsvzB0qPZDQ5TMfcQnZSHQxnUjxiDQNSI4rITeYL7wamV9dBWScuVziKzquiHMlJY+zPbVBfjYjpPJiqdlFVvw+YL+hvf7l+JYoa2Igaf+vFNDPypwVpP2EEf5B0J9KtRX4zidE4gBI+mTrCPCX5ppfzkLR+xBv8qqsLxEoX2CauqJ9b/Vvte3+uYjbMXN+DfQ0t2GaPfJKMwGAlC55JqwMeK9HjMlhq1LoT1Op
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(451199024)(1800799009)(82310400011)(186009)(64100799003)(46966006)(36840700001)(40470700004)(36756003)(81166007)(356005)(2906002)(36860700001)(40460700003)(47076005)(41300700001)(5660300002)(83380400001)(40480700001)(8676002)(8936002)(4326008)(86362001)(316002)(70206006)(478600001)(70586007)(6916009)(54906003)(336012)(2616005)(16526019)(426003)(26005)(1076003)(44832011)(82740400003)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 19:44:39.6664 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a79c9e89-e637-44d1-a4b9-08dbe6134e63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5957
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
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Samson Tam <samson.tam@amd.com>,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, Alvin
 Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com, Hamza Mahfooz <hamza.mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
- To reduce vlevel further, we can try to apply subvp on
  configs that already support p-state since the natural
  p-state support may not allow for DPM0.
- Add code to try subvp to reduce UCLK DPM level further
  if already supported, but don't use subvp if it does not
  optimize the DPM level even lower

Reviewed-by: Samson Tam <samson.tam@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index c4ffb4b92b56..26411d4e9730 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1416,6 +1416,7 @@ static void dcn32_full_validate_bw_helper(struct dc *dc,
 	unsigned int dc_pipe_idx = 0;
 	int i = 0;
 	bool found_supported_config = false;
+	int vlevel_temp = 0;
 
 	dc_assert_fp_enabled();
 
@@ -1448,13 +1449,15 @@ static void dcn32_full_validate_bw_helper(struct dc *dc,
 	 */
 	if (!dc->debug.force_disable_subvp && !dc->caps.dmub_caps.gecc_enable && dcn32_all_pipes_have_stream_and_plane(dc, context) &&
 	    !dcn32_mpo_in_use(context) && !dcn32_any_surfaces_rotated(dc, context) && !is_test_pattern_enabled(context) &&
-		(*vlevel == context->bw_ctx.dml.soc.num_states ||
+		(*vlevel == context->bw_ctx.dml.soc.num_states || (vba->DRAMSpeedPerState[*vlevel] != vba->DRAMSpeedPerState[0] &&
+				vba->DRAMClockChangeSupport[*vlevel][vba->maxMpcComb] != dm_dram_clock_change_unsupported) ||
 	    vba->DRAMClockChangeSupport[*vlevel][vba->maxMpcComb] == dm_dram_clock_change_unsupported ||
 	    dc->debug.force_subvp_mclk_switch)) {
 
 		dcn32_merge_pipes_for_subvp(dc, context);
 		memset(merge, 0, MAX_PIPES * sizeof(bool));
 
+		vlevel_temp = *vlevel;
 		/* to re-initialize viewport after the pipe merge */
 		for (i = 0; i < dc->res_pool->pipe_count; i++) {
 			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
@@ -1523,6 +1526,9 @@ static void dcn32_full_validate_bw_helper(struct dc *dc,
 			}
 		}
 
+		if (vba->DRAMSpeedPerState[*vlevel] >= vba->DRAMSpeedPerState[vlevel_temp])
+			found_supported_config = false;
+
 		// If SubVP pipe config is unsupported (or cannot be used for UCLK switching)
 		// remove phantom pipes and repopulate dml pipes
 		if (!found_supported_config) {
-- 
2.42.0

