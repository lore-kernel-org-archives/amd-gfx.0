Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45CA0EB64DA
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jul 2023 18:08:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C059310E3AC;
	Wed,  5 Jul 2023 18:07:59 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2067.outbound.protection.outlook.com [40.107.95.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94FD710E3AB
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jul 2023 18:07:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5G19XTzA+tJPzk0T38HQV17ZdHuEhfgq+A6r+XvewacvwM8u2u6O2Nmly7bCCDpMipFJYRpe4GAqPkyayqYj0TbHizUmI/jwvjYlorpDxx2lXPvVoBhVq05+3NJfCvTx1yI2rUa399LRa35A32sZBh+0uNkZG8nL7QbXshBeIst5tIiADngdkzPZhBPgY30fRXjYSje49WRXfwt6vwS7NRaCvUT6S5v671+rlzecnpMsAfWAd3Nq+ru9SyP+dlFtftc5WdCdIpNKoMlBBf1W8CWc5kYtY/LzAZs5m51Iu6AlO8ZwshkL/bjbCjvBxpHDALU+0Blqme/aNsSwC5uJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLCuVabEJhtZGJZ4UUQJDWKg9M0TTz1ccyf6XxdR9KA=;
 b=JHq2jLgnVDEYhD2vOIe0NBl+6OIB3Ywnu5GPinUuTbh3gmX5PHPBC4Mm8RMXaBcQOAN4ErU/hVoueLwwFJXpgX1uaq6hpndeLDotH9pbrXIwux+tyesc/fL3sqlkQlcsAT9kQ2XZK3dbp2BmdqO4d0P/Yz477zozNPZHFQnqZgLC5MlALoqyM8EuMke1yUdmzzIxyecDNYnZ2Zc4Fkv9JnxQF7p/ir0m6MNq38+fmpGy1+vqxY7pqc9R4qhYMhGhZNuKwzH61dFuzX5j2dJwHTwJTQgcqJ8AL63tItFIgd2RZPVe/LEgVEecJLNTX0J0hzGY8Ojit77YQjRWiK6UDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLCuVabEJhtZGJZ4UUQJDWKg9M0TTz1ccyf6XxdR9KA=;
 b=GteTCUuSu6NqvrjpAI5yR7V0cKPQvybcrVJYgxyxpMjlr9qIQ7NeJUD0xNbeFXTP9z+ab+QveuZU8rzCrf1S26/ebzoUVL0ftVxQRYCJL8cVTZWfTrukeGFyseOP7lyocko2Y0VhmWOy8fUxUpxtpLcT45o7xpekycljSbIG/Ag=
Received: from BN9P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::23)
 by MW4PR12MB7383.namprd12.prod.outlook.com (2603:10b6:303:219::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 18:07:54 +0000
Received: from BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::28) by BN9P221CA0024.outlook.office365.com
 (2603:10b6:408:10a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Wed, 5 Jul 2023 18:07:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT074.mail.protection.outlook.com (10.13.176.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Wed, 5 Jul 2023 18:07:53 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 5 Jul
 2023 13:07:53 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 5 Jul
 2023 11:07:53 -0700
Received: from fedaura-ryzen.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 5 Jul 2023 13:07:52 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/display: Do not set drr on pipe commit
Date: Wed, 5 Jul 2023 14:07:51 -0400
Message-ID: <20230705180752.2813978-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT074:EE_|MW4PR12MB7383:EE_
X-MS-Office365-Filtering-Correlation-Id: eda5f97a-7c6b-4635-f875-08db7d82c0eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qjFJJp2gnx0mHZGcH5EqdfEuB3o2n07IjRF9i1El7eR6fJDxgmV62tJzw0T4L8/r0IRhNDcmoh2XmIyztEy/JonAzWN9hWyBmWWBG23AN/SX98fqVy/HyrW71ZmIlt+yvHZbZXNueZris6gS47mVczefk+G/rsdSyOS0iddbEjS1gNO/Z7clT+jhYppYilBgGjih5CD3IqF/UTfgoESlHm1AIItKmrK8gmlaaytUsJBWyFgXPBTMJhjRL6VCTL6iq/EVPkU6A/miPxWS9h4b4AL/AjYaQ2PQz4n4VhL7CETGFBHe/ecl5tZYXtEePMdTXXxeJWGdQppXwXNuZclIi1qg4n2LscxFae5UwkRfYe5TojBTGY60alR46DyMD/YW7O1XRjoxKgEqjHP2ZB0Tro+Bo1jKrrZta0+VZL4+la/ohlj8Dltz3yvIIjS9K5Z8QvkyUo5YoarfRhAQHNp01IQNYNHWjgJld3EXB19UzmAs6BZmGKjDZ5VunQ2C4KkPsVjY/0lZ9SjMCW10Bp/K7S2QTjJh0Xu/uKT5LHagZXunhgaOiFAt6oGFd6bnr53/KOezDj4WjhsM2insnvyNb5ba9xvz+cBsAvtuS93GtWGiNx3l05k4BaXvxfI5NDAA0gbd82rAz6eV+dZeLdAUAnJIH/cI8bJCNXEwVln+C2gSwZWcTqQaDqEzV2pUtiHNFeHBeIndFnaysguLj0lIIuLqNv4B+kChLzZ+1otGJNjWQPRsR82vPPIq+IeauBjjZ5/MxQi00xVuMgwQUBIPGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199021)(40470700004)(46966006)(36840700001)(2906002)(7696005)(8936002)(40480700001)(8676002)(40460700003)(82310400005)(54906003)(36756003)(41300700001)(336012)(36860700001)(44832011)(426003)(5660300002)(478600001)(70206006)(70586007)(4326008)(86362001)(6916009)(26005)(186003)(1076003)(47076005)(316002)(356005)(81166007)(2616005)(83380400001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 18:07:53.8498 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eda5f97a-7c6b-4635-f875-08db7d82c0eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7383
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
Cc: Wesley Chalmers <Wesley.Chalmers@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>, aurabindo.pillai@amd.com,
 hamza.mahfooz@amd.com, Alex Deucher <alexander.deucher@amd.com>,
 harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
Writing to DRR registers such as OTG_V_TOTAL_MIN on the same frame as a
pipe commit can cause underflow.

[HOW]
Move DMUB p-state delegate into optimze_bandwidth; enabling FAMS sets
optimized_required.

This change expects that Freesync requests are blocked when
optimized_required is true.

Fixes: de1da2f7fe25 ("drm/amd/display: Add monitor specific edid quirk")
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 6 ++++++
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 4492bc2392b6..dba7eab9a2c4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2123,6 +2123,12 @@ void dcn20_optimize_bandwidth(
 	if (hubbub->funcs->program_compbuf_size)
 		hubbub->funcs->program_compbuf_size(hubbub, context->bw_ctx.bw.dcn.compbuf_size_kb, true);
 
+	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching) {
+		dc_dmub_srv_p_state_delegate(dc,
+			true, context);
+		context->bw_ctx.bw.dcn.clk.p_state_change_support = true;
+	}
+
 	dc->clk_mgr->funcs->update_clocks(
 			dc->clk_mgr,
 			context,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index bf8864bc8a99..7d38977f09a6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -951,11 +951,18 @@ void dcn30_set_disp_pattern_generator(const struct dc *dc,
 void dcn30_prepare_bandwidth(struct dc *dc,
 			     struct dc_state *context)
 {
+	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching) {
+		dc->optimized_required = true;
+		context->bw_ctx.bw.dcn.clk.p_state_change_support = false;
+	}
+
 	if (dc->clk_mgr->dc_mode_softmax_enabled)
 		if (dc->clk_mgr->clks.dramclk_khz <= dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000 &&
 				context->bw_ctx.bw.dcn.clk.dramclk_khz > dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000)
 			dc->clk_mgr->funcs->set_max_memclk(dc->clk_mgr, dc->clk_mgr->bw_params->clk_table.entries[dc->clk_mgr->bw_params->clk_table.num_entries - 1].memclk_mhz);
 
 	dcn20_prepare_bandwidth(dc, context);
+
+	dc_dmub_srv_p_state_delegate(dc, false, context);
 }
 
-- 
2.41.0

