Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C030DC7618E
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 23:50:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69EC910ED59;
	Thu, 20 Apr 2023 23:50:44 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D87B210ED58
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 23:50:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMEuqTyEqmjH1+9AKiLjQJf4dAbPPQ3qf97u/9TxHFrA5ojzDLhieRQD4ca/c570Y8+ksTJzuPgWZ1m42+RNSJDdW7dOaDN+DGZspbFVPhEeTlxjvyoCWE/Iu+M0dnKqrwU0/Ydo31aqHJhlpFd2+GTa+IzJ3cDtwadSsmkG4lvtso/47rFdTWpAIiEboivACxZCKP28FavLWdKl92y190OvCTMPN8J0iVuULcuRwOWncrh/2XWiGCsihPnNz7az+ULfzCXtIm7ZZ+Ucj8f+YD4WXkHxR9qi43UHC/gA2jrsVkv7xvKfXny2n9XE1Mq4VMQH7NeDVWzD10SCuL/fig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJXCmhOzyOGo9U0vN+m+82lV9gHlMID5qSq8cXHmiJE=;
 b=ihm7DzeHjBs5/zKzK89PPOvzoaG+phEqArOBON0OptIGD4DbwfF9TqtZjw1G33Snz9PfjwaF8vTYXNtFI2Zdt65v6PGQG08e6ehhg7FtB8Q7LnMozp/ELJc2v3RT12OHihssihrNg93p0pwfoHkEb6XFxHTF59HnvmXOCLxZ8lXTBzOkMMWNzW2IIDjWO3WShGQQUPGrQ44VeGYZl0oTcCV3GN2UTTjtl0OuTW8lrYGpcskbrROvbxiis/dUDMxLTT8NbSBp7oABnHqVbXd7I4ayjsmfmurAXE6JiIHvV9d5gTekZAsRL89xQwPVpWfcMTAfcqJchs91dr8Y1Fat+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJXCmhOzyOGo9U0vN+m+82lV9gHlMID5qSq8cXHmiJE=;
 b=N0Ip8FM1GDMg9L2/DzJoybKg2H28Rz68RyCmP8a4znWNW5wQk1GMYX/O2Byoc2S9DKFPl/64Lp8th675j5EuuAC8aX90LA5AZQu8g5M/Ug+tkkHwCJRv9jdiof51xHq2sf1ntO/3lFdCh4bFDEwlwBDlgx1KMXNUnF8bXVdcos4=
Received: from DM6PR10CA0019.namprd10.prod.outlook.com (2603:10b6:5:60::32) by
 MN0PR12MB6054.namprd12.prod.outlook.com (2603:10b6:208:3ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 23:50:39 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::71) by DM6PR10CA0019.outlook.office365.com
 (2603:10b6:5:60::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.25 via Frontend
 Transport; Thu, 20 Apr 2023 23:50:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.26 via Frontend Transport; Thu, 20 Apr 2023 23:50:39 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 20 Apr
 2023 18:50:36 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/21] drm/amd/display: Query GECC enable for SubVP disable
Date: Thu, 20 Apr 2023 17:49:47 -0600
Message-ID: <20230420234951.1772270-18-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230420234951.1772270-1-Rodrigo.Siqueira@amd.com>
References: <20230420234951.1772270-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT033:EE_|MN0PR12MB6054:EE_
X-MS-Office365-Filtering-Correlation-Id: 6707d095-deb0-4785-ea03-08db41fa0b59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0pXmD4oECCOE4QrtA//05zVs93RRBw1Wx/tu2QRjkDJKoVpavhzR+yIh9LbvKa+guMrDx6TnDZhpEBHMdJQk9jtOXBF6Oyk1I7irIcgFqGJTB1jFt0fz0zuHcKYqk6/bPTV0sqF0rzfhpInmpagL5okmL43Edp1r70j1ocIz3U2MkIdP97qTP9+nKa3CO2bAngbXRlePGUyqG2LuU42HesQCunLZOHHdZXfzgrtgJgIk/eJ+PErwj+VS9RIxN1MQqHgJWPa21WwC3qvs9wR4D+P60q+cgunrTvYNjSYCFe+GWwVkclksxtjXkTpqb6UX9XaT7/dCYLp4grLsxEEJXXL6lANdJOt1mYvTsV0WWQbKDlcf1Mk2HeR9/ozLxTntXiBpnhui829lIDpmB5MO8itfLAm8hE6ndBx+aBr7kTDWnQNb5JwS/geO6jLw0D01MHrtmOR+tcuntYY4aRWaWxqNwQpb5hRialo7NngAktmEyM+9aYd7HvGv625pEWZHk+xoh44N4Geff9V+otg4LklpD1hg/XEK+YZs2s965uK+/zvgxq0m5dTtqskPdTVyttMj+ipiDiuV4mtX3TAdb1rhcNz9g1nOpiOQxd7U4eBPjAWDmcy95DMwDZselcDZPbhhRjtVRTRxLEuZasJH0eVf9zaiAvJvXXjB2zzwH6RA36rss0/49yXrJUiepT7kgXBVcqNnGzoJXzwhXqpfzYzt9KCbGqxn6RX1Tc4wWCY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(70586007)(70206006)(316002)(6916009)(4326008)(40480700001)(6666004)(86362001)(54906003)(82310400005)(478600001)(5660300002)(36756003)(2616005)(8936002)(8676002)(81166007)(356005)(82740400003)(2906002)(83380400001)(47076005)(426003)(336012)(36860700001)(41300700001)(1076003)(26005)(186003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 23:50:39.0347 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6707d095-deb0-4785-ea03-08db41fa0b59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6054
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

- We want to disable SubVP if Graphics Error Correction/Correcting Code
  (GECC) is enabled.
- After reading feature caps from DMCUB during init, use the GECC
  enable/disable info to determine if SubVP can be enabled or not.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                  | 1 +
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 5268d98b96dc..17afe7915f48 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -210,6 +210,7 @@ struct dc_dmub_caps {
 	bool psr;
 	bool mclk_sw;
 	bool subvp_psr;
+	bool gecc_enable;
 };
 
 struct dc_caps {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 1e9ada8b131c..4950eaa4406b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -945,6 +945,7 @@ void dcn32_init_hw(struct dc *dc)
 		dc_dmub_srv_query_caps_cmd(dc->ctx->dmub_srv);
 		dc->caps.dmub_caps.psr = dc->ctx->dmub_srv->dmub->feature_caps.psr;
 		dc->caps.dmub_caps.subvp_psr = dc->ctx->dmub_srv->dmub->feature_caps.subvp_psr_support;
+		dc->caps.dmub_caps.gecc_enable = dc->ctx->dmub_srv->dmub->feature_caps.gecc_enable;
 		dc->caps.dmub_caps.mclk_sw = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch;
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 2624236d20d0..34ac5a1eb3ca 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1130,7 +1130,7 @@ static void dcn32_full_validate_bw_helper(struct dc *dc,
 	 * 4. Display configuration passes validation
 	 * 5. (Config doesn't support MCLK in VACTIVE/VBLANK || dc->debug.force_subvp_mclk_switch)
 	 */
-	if (!dc->debug.force_disable_subvp && dcn32_all_pipes_have_stream_and_plane(dc, context) &&
+	if (!dc->debug.force_disable_subvp && !dc->caps.dmub_caps.gecc_enable && dcn32_all_pipes_have_stream_and_plane(dc, context) &&
 	    !dcn32_mpo_in_use(context) && !dcn32_any_surfaces_rotated(dc, context) &&
 		(*vlevel == context->bw_ctx.dml.soc.num_states ||
 	    vba->DRAMClockChangeSupport[*vlevel][vba->maxMpcComb] == dm_dram_clock_change_unsupported ||
-- 
2.39.2

