Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006ACC48BD1
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C09F3611B0
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C09F3611B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 156E66ED94;
	Thu, 10 Jun 2021 16:29:34 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADE7D6ED99
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 16:29:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUlaM2KMVfEz8omIQRS83F5ABPmjtYsWuycQ6CdpeZRjOuKo/vp0/roiSKxs3o5FWVF63aRMVX7+U6m5C6MmDXA8TTbg1pcb0uWwTK3zNrRnNyi4vQYPKssO/GtLk3w5QFJ6oDaGfkc8oDewBIwGsWERpUD98b5ZqTr03ti8ABU4mp+kp7/ov6D1RgaZ4Nc93U6eEy2voFgM6MeNNXIKTFQNI4SCXknDviJSpSaU0/25OKuGjJd+ShXf0ioXdh3gKbQ9zEI4dA97G/aazrSsBkYDapZaZMMHZ8rAjXWym1Wu3gyb098JFzSSVqm5srjfdxNKkwdNwY2IHGwW48y5GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzNYBvOvvP29QzW89MKZD/YvHy3av/allCNIOpOPHog=;
 b=IagACMBoVeSmD6r2V/tO0vTPijeHVayg7J1mGkiVOlwcLjIbwja0BgMK4I8QrvpMjTmni3kSUzGpPlrr3VC8RrbtLqWi5PQt9X//pB6QC1TRrgAnMo/Qz9QARXtJo7qd46wqqXeCfT/iT+G1HvjWDlsrXTHLJ3cqUaMtoc+gTtnc2dXTN+9pToOFImyCQVWNleAX2SqtmYG8YZD6InvPqGSZ2VuabpKv4d873OR5u8B+sWEIvcpVwv8Qy+vF+JPJYnwnDHDy8erdo0x53hPYrstCcy+DnNEfue0FTWgKIBiAQf5XLeqh8bzhBvwOnCqN34dzcC7qI/Q5KlioXpQbww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzNYBvOvvP29QzW89MKZD/YvHy3av/allCNIOpOPHog=;
 b=RY8B8lv3tTJ0nPIyx4vx2iD7dewm4Bt1gh8kxwJCQcyTUKIkIv/Zy+E+vFBB/0Nm4tecFV6Ve04pkpOYXkHa/+/Tl3iIKJDlPiaADNxPnc8q1YAsKBPv0/iPs6xktQGrfT46pHJedp0HABGUHbOrdbPyjVXemYq2FFGg/tTYdYI=
Received: from MW4PR04CA0292.namprd04.prod.outlook.com (2603:10b6:303:89::27)
 by CH2PR12MB4908.namprd12.prod.outlook.com (2603:10b6:610:6b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Thu, 10 Jun
 2021 16:29:30 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::f3) by MW4PR04CA0292.outlook.office365.com
 (2603:10b6:303:89::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Thu, 10 Jun 2021 16:29:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 16:29:30 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 10 Jun
 2021 11:29:29 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 10 Jun
 2021 09:29:29 -0700
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 10 Jun 2021 11:29:28 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/24] drm/amd/display: Read LTTPR caps first on bootup
Date: Thu, 10 Jun 2021 12:28:27 -0400
Message-ID: <20210610162838.287723-14-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610162838.287723-1-Anson.Jacob@amd.com>
References: <20210610162838.287723-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11c1ffb5-db48-4af4-398a-08d92c2cec5d
X-MS-TrafficTypeDiagnostic: CH2PR12MB4908:
X-Microsoft-Antispam-PRVS: <CH2PR12MB490885AF389CB35DD05902B2EB359@CH2PR12MB4908.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QJ7/aDhSMrJLQGtlC8Zbhjm7evq8HmqqCu/SX3r6Itj2ANKP9xL+I4zFR2/sh658cr7DKJHRy8SmHAhhxfn2uI3LvT506SfCfIbGMapRHb88sa28/O8viXdfItSnGwxk0DfYmW9s/CtmU6qRc9ANt5UEA5NTQrIy2S4FVxY1TDCLSbVWt8cDp3wz01BMi5i5EK8KJbiEkLKbN4Nwf+O7++dFZdfsq7ETksjwzj+0k2RruHV8EyEVHXZmtrwT1YBz0gPenmSZbUUVfwVxCUbab2XKaNGBiR+pm+XITDZr4Q4AXASObMqdfpSpL7mOgil/cAbQ2+U7CqEcOMMcCVkKL+8M2I+ka8JZ2Q9D02aj2RiaiAKNr2hV9n7HVSRRJ39m0bwO0sh8MRS+OA9WzrUNZUBNrP1CSxTRWzDi1F5eYLRlHMgwW/g22D6CIZ539AJhjwg+BbbSx7DaAJgS3YBcVeTHCJkLq9naUzyyPaPf7qSG8seoNb0XFGwm2jYZLAlUs/lLiZ6kKx/t4T/hL3roFkI4E+RKss4fitg8pVtXqNszD6XcRoydJ07Htr+NPT9e/s7GSg6f21uf5SDgV9j03zRxz65QXZjGf4ILiJzkdHImw9woD1rSEqguFkkgIClC5FNnWGySp1j/h66XOc6TWw7uMojVO12q8Hho6U1pYsLZUwDJnDFr4qFhzyFiJgfX
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(136003)(39850400004)(46966006)(36840700001)(36756003)(478600001)(81166007)(186003)(86362001)(356005)(82310400003)(5660300002)(6916009)(7696005)(336012)(82740400003)(47076005)(26005)(4326008)(36860700001)(2616005)(8936002)(70586007)(8676002)(83380400001)(1076003)(54906003)(426003)(2906002)(70206006)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 16:29:30.3802 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c1ffb5-db48-4af4-398a-08d92c2cec5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4908
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
Cc: Wesley Chalmers <Wesley.Chalmers@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
SCR for DP 2.0 requires that LTTPR caps be read first on hotplug.
For the sake of consistency, this should also be the case on bootup.

Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 4 ++++
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c        | 3 +++
 drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h           | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 3b175af97388..711ba953a99b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -54,6 +54,7 @@
 #include "dce/dmub_hw_lock_mgr.h"
 #include "dc_trace.h"
 #include "dce/dmub_outbox.h"
+#include "inc/dc_link_dp.h"
 
 #define DC_LOGGER_INIT(logger)
 
@@ -1403,6 +1404,9 @@ void dcn10_init_hw(struct dc *dc)
 			if (dc->links[i]->connector_signal != SIGNAL_TYPE_DISPLAY_PORT)
 				continue;
 
+			/* DP 2.0 requires that LTTPR Caps be read first */
+			dp_retrieve_lttpr_cap(dc->links[i]);
+
 			/*
 			 * If any of the displays are lit up turn them off.
 			 * The reason is that some MST hubs cannot be turned off
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index ef5d0b778a72..6c88c5f236a7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -48,6 +48,7 @@
 #include "dc_dmub_srv.h"
 #include "link_hwss.h"
 #include "dpcd_defs.h"
+#include "inc/dc_link_dp.h"
 
 
 
@@ -529,6 +530,8 @@ void dcn30_init_hw(struct dc *dc)
 		for (i = 0; i < dc->link_count; i++) {
 			if (dc->links[i]->connector_signal != SIGNAL_TYPE_DISPLAY_PORT)
 				continue;
+			/* DP 2.0 states that LTTPR regs must be read first */
+			dp_retrieve_lttpr_cap(dc->links[i]);
 
 			/* if any of the displays are lit up turn them off */
 			status = core_link_read_dpcd(dc->links[i], DP_SET_POWER,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
index dd38dd63697f..e2b58ec9912d 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
@@ -190,4 +190,5 @@ enum dc_status dpcd_configure_lttpr_mode(
 		struct link_training_settings *lt_settings);
 
 enum dp_link_encoding dp_get_link_encoding_format(const struct dc_link_settings *link_settings);
+bool dp_retrieve_lttpr_cap(struct dc_link *link);
 #endif /* __DC_LINK_DP_H__ */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
