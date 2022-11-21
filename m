Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB1CEC433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Nov 2022 22:14:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D054A10E33C;
	Mon, 21 Nov 2022 22:14:37 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2044.outbound.protection.outlook.com [40.107.212.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA25F10E33A
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Nov 2022 22:14:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wc3Z8eR7Bi0CPmUC/tNpcwi5cR8M4nMPb11S7m/jGTsjQpRlrY4uNh9QVYrX2n4RaibZe/JIOILRB7daLVup3hcX7tMLL0l0BZkDai0fSmtdrtvj2ACZGaInGAYWKoVH+XwMgF4ccdhffaUVkZgNZis4+1HSsnabyYbiBeq/hwIjXPk/9/oFX4XFxkSAQuWFvAvxwESZTqmyklxsRXlDdmuRiQL/cYxD7kNx6z/jgCpb9og93qnOU6K1ZWiswgFYiCXYHOrqg0BhTiTSZkJ3nBGxNXZpN9YrHWVBJi1TNTG9L5g8U0U8zIvEDZDpBYxG3A4vWkVVExotzW6f5JCvcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TE3X9GhQKMGPd6GIdkCUXl7zWAgWUt9FtEhxQ3+ayO8=;
 b=TvDx+f+Z+9RERgz5YSllLVrYI7ujht3BNkxuyLHV1Hl4Tt3ugdrwgQ6TfUDr3z9bJwnI4V4QkJGhR/riM0fpCeYRF7O/ERerFQszKczaFbDG5tMImSOwNi6iSgnTPLoJJ/YMAceoBaK0Pm5dT2vnU086t7e7/uPEyKE/4FAhIpufGE5/9uJ55PTBQ5CoEu9vDDtuBYzcX1RpWYnB4E4vMvFZhSDuw16huwKh0c4dWAE7BIdk26sfssnV2f+rLVWOCubQzSYiSjmyE5EcdQRir47/yiHxkUfPj3AE2dX5OhY3amF4t2YDKdX5+zCQZKDFaEJqxPlHnBZPHBMqk8dxMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TE3X9GhQKMGPd6GIdkCUXl7zWAgWUt9FtEhxQ3+ayO8=;
 b=VzSNOvbsyWRe6RT/Lz/FinOM90LYRx0CPo9p1gD3H6kJuLEKuoHOp3qY85LL2DfAyP18Da8HXSKHtgMZR3VMNzQg4/AOLHACUAEXe2kvBgPWS7Ip3whhGViPHiUxCmcYjCCMLU1692Zu7LEOovv45+eOdtBnSQzU+FFFp2IARcA=
Received: from MW4PR04CA0365.namprd04.prod.outlook.com (2603:10b6:303:81::10)
 by CY5PR12MB6453.namprd12.prod.outlook.com (2603:10b6:930:37::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Mon, 21 Nov
 2022 22:14:31 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::f6) by MW4PR04CA0365.outlook.office365.com
 (2603:10b6:303:81::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15 via Frontend
 Transport; Mon, 21 Nov 2022 22:14:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Mon, 21 Nov 2022 22:14:31 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 21 Nov
 2022 16:14:30 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 21 Nov
 2022 16:14:29 -0600
Received: from aaurabin-elitedesk-arch.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Mon, 21 Nov 2022 16:14:29 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: trigger timing sync only if TG is running
Date: Mon, 21 Nov 2022 17:14:29 -0500
Message-ID: <20221121221429.4040398-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT007:EE_|CY5PR12MB6453:EE_
X-MS-Office365-Filtering-Correlation-Id: c593a352-734f-4fcb-45a5-08dacc0dc36f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TdbF/agIHMY9XOqlrXQiOAqIC6Z1uMPyRO14vXIJedR46dm2gKYvV2d6YDdYI76yWEmEfzKRowxtN+PzQWMOi4kAogvKZZLQK0NC1yHmHs/Y4lyty2/CwnhUzT3lGsH/xFfdLxl5kjI069YTNFLOiQIcoJVQyR9icUrCdpCZyRW+I3292Cu6HZz4o7rcJcm/nqT/ZkYOpCxGHKYImyJ2F6vXPxAr3U+2qMYZ/uSnEZ6Y5XNStJeVhpelLWbsB2hin1AtPgIs0B+lRw0lrlGqyP13eT+Bj4K/r6IKP7k5B7ekSAmrqVWOywgq5vdfdp1j2bW1SPojYDC6rsCKWB9F+W0bV8mCNK8Ba++3SR7rHhUJXl/ZgYFse+522/Dz38YWk2nNtm5vXRGgKg2EOTgMoNHhMB+N5tOTGWFYsTSuAkHrdqHXBKIv4hN0B6GgOYwD14CuGBZt5dvH+9z36wQ/kMY0ho6H7ubs3hq4159tcKN7K8AU6EXZ3+L8sA7SKubmc7FWSlFh60qq3mOOz2HSMNu3svaAwXKShiQdaYIYLjrDVC+SVCcTx/hj3Oz2r265LCgeWRkTv6t8i6kFMRxiI/X1WpgdHbPpTcojFOpIzJab5SAQuQvTjbvy88T24rbxy2b9zf7GD/12hTlobfdmV5iTpV9gVaw2f2j1XrYnNQJ5JyAwgHlaS+CRBeMFNf3EZacVnaaGysHliJI/+BptnPLUWJpPCIY7Cebps44bX8Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199015)(36840700001)(40470700004)(46966006)(356005)(54906003)(7696005)(478600001)(81166007)(6916009)(2616005)(8676002)(426003)(70586007)(47076005)(41300700001)(40480700001)(70206006)(44832011)(36756003)(82310400005)(336012)(1076003)(8936002)(186003)(316002)(2906002)(26005)(83380400001)(82740400003)(40460700003)(5660300002)(4326008)(36860700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 22:14:31.0274 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c593a352-734f-4fcb-45a5-08dacc0dc36f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6453
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
Cc: harry.wentland@amd.com, aurabindo.pillai@amd.com, rodrigo.siqueira@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why&How]
If the timing generator isnt running, it does not make sense to trigger
a sync on the corresponding OTG. Check this condition before starting.
Otherwise, this will cause error like:

*ERROR* GSL: Timeout on reset trigger!

Fixes: 8c7924bdb0fe ("drm/amd/display: Disable phantom OTG after enable for plane disable")
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 587b04b8712d..0db02e76dcc5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2252,6 +2252,12 @@ void dcn10_enable_timing_synchronization(
 		opp = grouped_pipes[i]->stream_res.opp;
 		tg = grouped_pipes[i]->stream_res.tg;
 		tg->funcs->get_otg_active_size(tg, &width, &height);
+
+		if (!tg->funcs->is_tg_enabled(tg)) {
+			DC_SYNC_INFO("Skipping timing sync on disabled OTG\n");
+			return;
+		}
+
 		if (opp->funcs->opp_program_dpg_dimensions)
 			opp->funcs->opp_program_dpg_dimensions(opp, width, 2*(height) + 1);
 	}
-- 
2.38.1

