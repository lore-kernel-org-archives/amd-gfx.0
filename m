Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D94BC433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02F8720801
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZnStnlP1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F8720801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C67366E492;
	Mon,  8 Jun 2020 04:59:48 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CF786E48B
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 04:59:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2PouX3xsi03jSeIJMwM9Ss39g+KRCrVXPEqqoScoZi3hqPbF1ynhBg5PdQCiiJwC+I4jF0Od3EP8kPrvoLerAoXf05XTftViXx1XPSPV6yoxvPTuLwXoGf9EUuhAbkrEuenTpVg8S24Dc/tCI6NKvtW3UGeIkMEVnksCnEol8uhS8g6Q4xUXpbjJ95frafp0vupXdRdOFPWWIaKS4oYMSjjx9EEtKlKbmlfpIREltyEeEpvRjRaACLz7QYGRaPGipCKYQFYcmMpG3Mp4vkbMmEXE0J6VfMImc1hIvTXVD7UKBPcdkEAfBwTKLGqm+VGzAGsWjTE6ryZzcEKtUF1vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RT+KZHo/i4zqZdeeUOCGPBND6PU+mHLBohYZWeYb9fU=;
 b=AKGGnCClE1bIf2LDu4vRPRsMnx3B6YaiCoRFhtj3W2UU8vtdx29T8LHvUXFKAilWH0ZBBavAM0kr1jMktxwS4kxgzNe+7Eaj4ZUOwDuariGKcg0Xb4hcDoleXOBSQZouGrY41NZIL142RlKInrLpHLDLv5PFLV6KOd9hnCuiaXj66KOE8fKX5lQfAI0y/+C3McNz9A82P17jtE5ehYI8VZBToFLMf+v/dOGfecefOTX+10ifgolj2Sc1BNgjrggSu8q6GgQFS5bHtnvrZ6NkxsbRgd+VN/bQlhV5tBdDmL+cVd9lLc+d7wrET5g9ZE1glFC/rp5Loy9Nzsw+Jv5exg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RT+KZHo/i4zqZdeeUOCGPBND6PU+mHLBohYZWeYb9fU=;
 b=ZnStnlP1cSK8C8cGOYiP4cNQYnl+5AbLXOytQ1xl8yrwakrUptZIpeoE1HU7Zpy99dx66e6YrrlfhW0KkIEUxgQkMNk2a3nRMPf8wid+rE+Q4Vez9j9WoA8xW2S/zLQqUkR1MN/ttMfXBcxZuSg9v0Z9pzQebtSK/Ho93y+Tk3w=
Received: from MWHPR22CA0014.namprd22.prod.outlook.com (2603:10b6:300:ef::24)
 by BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.22; Mon, 8 Jun
 2020 04:59:42 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ef:cafe::8a) by MWHPR22CA0014.outlook.office365.com
 (2603:10b6:300:ef::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Mon, 8 Jun 2020 04:59:41 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 04:59:41 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 7 Jun 2020
 23:59:38 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sun, 7 Jun 2020 23:59:38 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/28] drm/amd/display: add support for per-state dummy-pstate
 latency
Date: Mon, 8 Jun 2020 00:59:16 -0400
Message-ID: <20200608045926.17197-19-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608045926.17197-1-qingqing.zhuo@amd.com>
References: <20200608045926.17197-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(46966005)(8936002)(186003)(26005)(70586007)(86362001)(70206006)(4326008)(1076003)(356005)(8676002)(6666004)(6916009)(82310400002)(426003)(83380400001)(54906003)(478600001)(2616005)(5660300002)(2906002)(82740400003)(47076004)(316002)(336012)(36756003)(81166007)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b780a029-380e-4a14-41c2-08d80b68c120
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3108ACED10667C32D5457F21FB850@BN8PR12MB3108.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FleaLov1AcXdAO6VizwOYQdnYWAESiSjqDQaVBLc8Cdscnb2l9OeK4/sQWYP65jYhq+PfnbpLC3wN+nKEi1Zkoqgl+VOBMV0QQqRb3AjMcMvHaT82+gK+HN/ODQ11mafpgWQ0DldccHe8nw6dM+o1AYYSkc27VdJIRz+ipaUAkX8IgETdDRtxmSh4mVd1Czd3s9Ilz3WGy59eeUuaQQ6pWVrXOGyo3L/fxviteaG24AO2JEhwRRkDTbx7MiQVjza5P8DWeCFwTAhPIhsH8AFdxE5qM7ihNyoAAN5cqAxgwInVpZTqEOkmw1fpkUWGeyKXpMeeS2fBdoEhLIthQY3PBWOSXwfbGrT0frSngb0zixkY/TlxsGgnQDeuBgWeNeFucHz/QeMuvZGegmLMPx8Wg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 04:59:41.5837 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b780a029-380e-4a14-41c2-08d80b68c120
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3108
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Jun Lei <jun.lei@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jun Lei <jun.lei@amd.com>

[why]
Dummy pstate latency actually varies between different
UCLK frequencies, when calculating watermark C, if DAL
always assumes worst case, then it can lead to dummy
pstate not supported scenarios.

[how]
Rather than statically calculating dummy pstate using
worst case, we store the entire table of UCLK to dummy
pstate relationships.  On a per mode basis, we calculate
the actual UCLK lower limit, and use the dynamic worst
case dummy pstate latency.  This prevents the situation
where we don't support full p-state (which will force
high DPM), but still use low DPM dummy pstate latency.

Signed-off-by: Jun Lei <jun.lei@amd.com>
Reviewed-by: Joshua Aberback <Joshua.Aberback@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
index 49c50af9cd9e..505357597603 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
@@ -198,11 +198,17 @@ struct wm_table {
 #endif
 };
 
+struct dummy_pstate_entry {
+	unsigned int dram_speed_mts;
+	unsigned int dummy_pstate_latency_us;
+};
+
 struct clk_bw_params {
 	unsigned int vram_type;
 	unsigned int num_channels;
 	struct clk_limit_table clk_table;
 	struct wm_table wm_table;
+	struct dummy_pstate_entry dummy_pstate_table[4];
 };
 /* Public interfaces */
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
