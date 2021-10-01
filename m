Return-Path: <SRS0=Ip3g=OV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7A1C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 14:42:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B18E461507
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 14:42:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B18E461507
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 695D46ED8A;
	Fri,  1 Oct 2021 14:42:11 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D1CC6ED8E
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Oct 2021 14:42:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnOThvuqaK+yYNDR9DD81X9CdJlJdFZJnzDlSU7lCBdP3Rwryhr0/K6rxEtGdU7JhKm3InoJgBRBUscdEhNGnNYeP0S++AyvHrE56isuKS0a75i703udZBT/KvIvMWN3LS5gOFe/hAJbHdw81UCs2k+9vL9c1Qrv4XRp+8M24KaM4i/ezBKsa0LKHJXj5xZTjBPcmcTR+lqyA5A1P220houPonT2ZSrn6VZr1mfFPhxUTM/YyFNl8fGsw0CVaSF96NljW2h7UNz5AOMbHfikDr1PQ6IP8U7K6hxYB6bTStV1g/QFqR19vlygblJNPI5Vp9wwm9qpvBdIOQXETThupA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtMFdFuU0818LWBYXEsd8VYB7UNJz8l3olNMBDEevlA=;
 b=DL5lzu/T/k4rNLmUkUh5pgV5TR/945Df3KeDN0KlNUmezuMt/qijSsNpB45S+cbo8oaQGcpmcCH1SrdgKN4w1AhYzA7/piNnHvCAGj620/HeeZb48QeEnBAJizn8WXnrMnUpeBlKvPHS0EarjJV3zqwFBbDslhRPGRqOUVzMJvNTuYXd1P+8lEaPYsayWAHy0G8RpWB+7SvDhrFwoMutSQqTPaQMY1ux0a5Rw34oelz6poicDkVdMcmp0o8dl2qQDqcV15jFJkTiE/qgFKyqRJuKMsIDduIf/3QVeLgvw6bkVLpieVqIHZVa3p1P/dO/6fln+9QqSb5ZBBCkRjX85g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtMFdFuU0818LWBYXEsd8VYB7UNJz8l3olNMBDEevlA=;
 b=m28XM1FLozatE1tss5gfYTaRm6ExcWj2VdT2GS9i56InNysU+YaJyg5DHj0pl7tCqmujNpoDcYBeEVRnz3SVan20AYBYkzES/fSxix/zm+3jeID2C/JIv0YodrQs3PQWs9M6guGRBfEA0I0CXowVVNKdSMCzIL5bSbTx8qC0S+U=
Received: from MWHPR10CA0011.namprd10.prod.outlook.com (2603:10b6:301::21) by
 MWHPR12MB1632.namprd12.prod.outlook.com (2603:10b6:301:10::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.19; Fri, 1 Oct 2021 14:42:07 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:0:cafe::ef) by MWHPR10CA0011.outlook.office365.com
 (2603:10b6:301::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Fri, 1 Oct 2021 14:42:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Fri, 1 Oct 2021 14:42:06 +0000
Received: from solomon-t14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 1 Oct 2021
 09:42:00 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, "Leo (Hanghong) Ma"
 <hanghong.ma@amd.com>, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Subject: [PATCH 14/14] drm/amd/display: Fix error in dmesg at boot
Date: Fri, 1 Oct 2021 22:36:20 +0800
Message-ID: <20211001143620.192679-15-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211001143620.192679-1-solomon.chiu@amd.com>
References: <20211001143620.192679-1-solomon.chiu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18ba07b0-5dcc-4f78-38b4-08d984e9a445
X-MS-TrafficTypeDiagnostic: MWHPR12MB1632:
X-Microsoft-Antispam-PRVS: <MWHPR12MB16324A8E328B21F8128E006097AB9@MWHPR12MB1632.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ganDk1eOAN9pvCOyFoXGFe0thaLcN/3EsybgwgRSiQxo28/JCa3prGmDWrZ+GDdcrzY8Z/mX5gt269J34urEN75AR+3bQfAfH90+HuslHJUrt+yGLImYRAXKfrUIFhTGQD9DRicdieAILpnohMY1IqbMh5mXfdwI66SQ/WqazTP4MQEFXveNnXDj9GnyMadSXPZxitInd7CsjHAyDsq2mptI3eBE5KOjwS1103BzUO/XGy3Dicn95cfcUcv8xtwXINbfPO+R4/mMXLp3pUVBh4QD/unYavrah8WIf/iVLczAad1oiMOl/142VW2HQyZlb51q6wOBFTrG918yWELSyDwLBxR5uwuAY62kN5S0jIHCVROV77pZWZAc6YCHqp4LlANoP0qwBZ6qCp/y/IiQBL24E3W/pCJM5rQ9shiLoUoSYtq3lds7ftJcO2b3Rm5n2V6xAyTyDUxnJwQCt75AEqrqUOPuI48z6Sq+cN/RI0+2xDTIDP+yl5RAY94BFGldPpprhkPRHSJlpVYSAgQbQ49KuZ6EmJnD9mpdhhcSmGBfJKPjudimNAaCVCGtdNer6vE2D0LBhS8yBZPid31Qj66NdSWBJtatFaFyCyyGBrL6BL9cLzhkn5Nz5FuNFyL2iHn8Axf/mJuQKY4EPFaufCHspIrAzKNb+MPOxV3nNtvZecw17qUYRaeKhLoapdsvzSeQGsrV3R1sB54A4z1ulXQbTfyRTgocUyPJiQT0RIo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(356005)(36756003)(316002)(8936002)(81166007)(36860700001)(44832011)(4326008)(54906003)(47076005)(8676002)(1076003)(7696005)(508600001)(70586007)(336012)(26005)(70206006)(2616005)(426003)(2906002)(83380400001)(86362001)(6916009)(5660300002)(16526019)(6666004)(82310400003)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 14:42:06.6223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ba07b0-5dcc-4f78-38b4-08d984e9a445
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1632
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Leo (Hanghong) Ma" <hanghong.ma@amd.com>

[Why]
During DQE's promotion test, error appears in dmesg at boot
on dcn3.1;

[How]
Add NULL pointor check for the pointor to the amdgpu_dm_connector;

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Leo (Hanghong) Ma <hanghong.ma@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 81bf1e5a64c8..64b9c493dce2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1917,7 +1917,7 @@ void blank_all_dp_displays(struct dc *dc, bool hw_init)
 
 		if ((signal == SIGNAL_TYPE_EDP) ||
 			(signal == SIGNAL_TYPE_DISPLAY_PORT)) {
-			if (hw_init && signal != SIGNAL_TYPE_EDP) {
+			if (hw_init && signal != SIGNAL_TYPE_EDP && dc->links[i]->priv != NULL) {
 				/* DP 2.0 spec requires that we read LTTPR caps first */
 				dp_retrieve_lttpr_cap(dc->links[i]);
 				/* if any of the displays are lit up turn them off */
@@ -1943,7 +1943,7 @@ void blank_all_dp_displays(struct dc *dc, bool hw_init)
 				}
 
 				if (!dc->links[i]->wa_flags.dp_keep_receiver_powered ||
-					(hw_init && signal != SIGNAL_TYPE_EDP))
+					(hw_init && signal != SIGNAL_TYPE_EDP && dc->links[i]->priv != NULL))
 					dp_receiver_power_ctrl(dc->links[i], false);
 			}
 		}
-- 
2.25.1

