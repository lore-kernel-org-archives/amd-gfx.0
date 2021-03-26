Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE09C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 22:06:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB53E61A2A
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 22:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB53E61A2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D12E6F4BB;
	Fri, 26 Mar 2021 22:06:12 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 283B36F4BA
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 22:06:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPWpx15zH+vNf6N25ghRWi0pvoKzrsaDtjybWvJ7rnLGtdd96BZ3vEEMsSIDXEzQECfi4E0VRlh8jaU5Kzx1SxeKBqZC3bN0MlgmgFghQ7Aae+HJYwIZj8EiCGqEwS0zf0FfanUlMY8WBx6FFuxdPpX1if/bbtafgP/foLVBlIkUQ3WufzQPLmCqe7Rgw8K8cLVl9uHhCWKz/zd8BCr2iNIxRk+3CrYkzt2rL8yuiDNo7keNQy2cu6l0N9FYLeLoefuNTKsQxIG0zaM3KtrmfJnLefID6xY76X+KdN9tKz9Wluxe6deRno/Han4zEDS7HbOSDw2709BHz/TLEhTAsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5TJGOlagIaW7LVbKb9sbo82/TY+nfcprdE6mSH6g20=;
 b=M+VOtbJ6fVsK7nTbe2sFyNIDt9VBrfVQN9iAJ011dOxv69BTkBvMYVEfvtQbRWCNP+FwlsFHsDzOBPftEN8B/4WK9/AD/gxowfPd+fZKPuWu7bo/PnLgDgJmwZDoJ6MXAFuRKegwHI4Kd3YEEpZ1qChQfkkOYiGLZeh2ILQ31KnYumfTXlxvW7cypHjCYSuQd/ZJlGBUV5DggJ5rmMG3QxIZ3o7wQe59/DNCWuzt34OlZxf0IVPWZEVVNSMHldLkUhkGAWkpDRvZQ3uU8tttfuLHxWhILBs1bFkLXyb6LiOd6Ttz6XdSPDsRLd3G/h5DrYQhT87IZCXOGH1Cgeo/lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5TJGOlagIaW7LVbKb9sbo82/TY+nfcprdE6mSH6g20=;
 b=Jy7F+x0Z9RFDiiCLsuGChy/3XeMb4GSLfcGT41gAoc1f4wGd8VDhZyRO41bqjHSpKRc/oCm4TPhjrCOlrothMExOIoRUGAuVZG3hPB0Q3Pg1uxxaKgWmW/Fe9pCEAc4N2yAf5CoB+X69Lt2DSOgbaKMosV8TJwF7ds+JOi5y+Lo=
Received: from DM5PR16CA0025.namprd16.prod.outlook.com (2603:10b6:4:15::11) by
 BL0PR12MB2481.namprd12.prod.outlook.com (2603:10b6:207:40::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Fri, 26 Mar 2021 22:06:07 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:15:cafe::f8) by DM5PR16CA0025.outlook.office365.com
 (2603:10b6:4:15::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend
 Transport; Fri, 26 Mar 2021 22:06:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Fri, 26 Mar 2021 22:06:06 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 26 Mar
 2021 17:06:05 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Fri, 26 Mar 2021 17:06:04 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/21] drm/amd/display: LTTPR config logic
Date: Fri, 26 Mar 2021 18:05:25 -0400
Message-ID: <20210326220534.918023-13-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326220534.918023-1-Anson.Jacob@amd.com>
References: <20210326220534.918023-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbf48a4a-0624-40c0-6333-08d8f0a35afb
X-MS-TrafficTypeDiagnostic: BL0PR12MB2481:
X-Microsoft-Antispam-PRVS: <BL0PR12MB248100E6C9031211B11C4F07EB619@BL0PR12MB2481.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m47UGe3u1nwszot5V2/1sEtWMi78pcvfTFoalkcb36wsNwrulWChH/gNQei6EtfVQSQhs42H7kmA3G5wz4ebiM26gXVMKhlk5f6jTVSm2gs2gDP74KvdzpfQY8EK/YQo7zlh5sXRUvWUefS/kiVWMRZswLBBf6O2KV/7Rb6B7HiLEFSx38oenRT+UUf4fZE5rgLJeWjarIZzlQy7LMldoPHjKuxzveub/zk3z0NYWi6ssSlftmW3AbfpsBAhYEItfQVGlqE9az7AKNRe39VhBx3218wlL15MhyuoqPh0m9A18ZRpCrjrQyWNRt2e6x/iVmfkJ2FuIM7KrTOHgfhYNeC3GusIHpgwqPZX1vXi7XKpKTYNEQ6TF5lDi8brCAU1HZecMApTEd0G22Om9YKPLUCrLHUIROVULWAo8G7JTh/rlRyWrKIBqA9PuVmwoQxjiox0pDcMo5MmXxQhQf4YPXMobf8hbACQ7Wz58bkt7G0nhf4y1Z6C5SOM/fedUUnkvDc87YsaWCcysVBUu2nELe7BJOtL14b9RjUdDUYqnp6Zi01UkstwHBqI/t9ZKA13E3eqoZKdgX02E0AmYGHOKIRAxP9ToDsUIv0UOKsOrPOkyBID8WmyV0lVYXaufpQlh1FnlgUCHZOnje4IsvbUNL4y3zaIxXep9R2z+aV8b8ypBds353WXc+MTNxzcVgwPSRKltTShnfJXJeSgnu5d8Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(54906003)(6666004)(70586007)(70206006)(426003)(83380400001)(498600001)(26005)(356005)(2616005)(81166007)(186003)(336012)(2906002)(82310400003)(5660300002)(47076005)(8676002)(36756003)(1076003)(86362001)(8936002)(7696005)(36860700001)(6916009)(4326008)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 22:06:06.8745 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf48a4a-0624-40c0-6333-08d8f0a35afb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2481
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
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
Some systems can enable LTTPR through bits in BIOS, while other systems
can be configured at boot to enable LTTPR. Some configs enable
Non-Transparent mode, while others enable Transparent mode.

Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 51 +++++++++++++++----
 1 file changed, 41 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 209286357867..cebf68200f43 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3447,6 +3447,9 @@ static bool retrieve_link_cap(struct dc_link *link)
 	struct dp_sink_hw_fw_revision dp_hw_fw_revision;
 	bool is_lttpr_present = false;
 	const uint32_t post_oui_delay = 30; // 30ms
+	bool vbios_lttpr_enable = false;
+	bool vbios_lttpr_interop = false;
+	struct dc_bios *bios = link->dc->ctx->dc_bios;
 
 	memset(dpcd_data, '\0', sizeof(dpcd_data));
 	memset(lttpr_dpcd_data, '\0', sizeof(lttpr_dpcd_data));
@@ -3494,13 +3497,45 @@ static bool retrieve_link_cap(struct dc_link *link)
 		return false;
 	}
 
-	if (link->dc->caps.extended_aux_timeout_support &&
-			link->dc->config.allow_lttpr_non_transparent_mode) {
+	/* Query BIOS to determine if LTTPR functionality is forced on by system */
+	if (bios->funcs->get_lttpr_caps) {
+		enum bp_result bp_query_result;
+		uint8_t is_vbios_lttpr_enable = 0;
+
+		bp_query_result = bios->funcs->get_lttpr_caps(bios, &is_vbios_lttpr_enable);
+		vbios_lttpr_enable = (bp_query_result == BP_RESULT_OK) && !!is_vbios_lttpr_enable;
+	}
+
+	if (bios->funcs->get_lttpr_interop) {
+		enum bp_result bp_query_result;
+		uint8_t is_vbios_interop_enabled = 0;
+
+		bp_query_result = bios->funcs->get_lttpr_interop(bios, &is_vbios_interop_enabled);
+		vbios_lttpr_interop = (bp_query_result == BP_RESULT_OK) && !!is_vbios_interop_enabled;
+	}
+
+	/*
+	 * Logic to determine LTTPR mode
+	 */
+	link->lttpr_mode = LTTPR_MODE_NON_LTTPR;
+	if (vbios_lttpr_enable && vbios_lttpr_interop)
+		link->lttpr_mode = LTTPR_MODE_NON_TRANSPARENT;
+	else if (!vbios_lttpr_enable && vbios_lttpr_interop) {
+		if (link->dc->config.allow_lttpr_non_transparent_mode)
+			link->lttpr_mode = LTTPR_MODE_NON_TRANSPARENT;
+		else
+			link->lttpr_mode = LTTPR_MODE_TRANSPARENT;
+	} else if (!vbios_lttpr_enable && !vbios_lttpr_interop) {
+		if (!link->dc->config.allow_lttpr_non_transparent_mode
+			|| !link->dc->caps.extended_aux_timeout_support)
+			link->lttpr_mode = LTTPR_MODE_NON_LTTPR;
+		else
+			link->lttpr_mode = LTTPR_MODE_NON_TRANSPARENT;
+	}
+
+	if (link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT || link->lttpr_mode == LTTPR_MODE_TRANSPARENT) {
 		/* By reading LTTPR capability, RX assumes that we will enable
-		 * LTTPR non transparent if LTTPR is present.
-		 * Therefore, only query LTTPR capability when both LTTPR
-		 * extended aux timeout and
-		 * non transparent mode is supported by hardware
+		 * LTTPR extended aux timeout if LTTPR is present.
 		 */
 		status = core_link_read_dpcd(
 				link,
@@ -3540,10 +3575,6 @@ static bool retrieve_link_cap(struct dc_link *link)
 			CONN_DATA_DETECT(link, lttpr_dpcd_data, sizeof(lttpr_dpcd_data), "LTTPR Caps: ");
 	}
 
-	/* decide lttpr non transparent mode */
-	/*This is a temporary placeholder for LTTPR logic. More comprehensive logic will be added in a future change*/
-	link->lttpr_mode = is_lttpr_present ? LTTPR_MODE_NON_TRANSPARENT : LTTPR_MODE_NON_LTTPR;
-
 	if (!is_lttpr_present)
 		dc_link_aux_try_to_configure_timeout(link->ddc, LINK_AUX_DEFAULT_TIMEOUT_PERIOD);
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
