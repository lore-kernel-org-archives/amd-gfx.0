Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B2C5ECAAD4
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Aug 2022 02:51:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71D4A10EB6B;
	Sat, 27 Aug 2022 02:51:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3A2C10EB68
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Aug 2022 02:51:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INn30KV4h/vpGPhF4uPJIQ2/d3Kte52rp9LZ64RkSzNeGozAkyc81XZhUntKwwtcGvYdl2SO7Ecpa9ecmMQKUYfbrqgTsEe6MgCQX0nlVXcTP5QyE43QzYAPvgrm6Fg+gdZm76O41Q/aqwvbB8G3yh3MHRY+uD4JN6KCyW0YhLKPJ2PAQPwDQ+ksRFYlfvkvGJmlTre7Uicy+XNYieBEDvceF/r61p4EJQkNa+SfOG8Nc/z6T7S5AsN7h5LjldP36yLgbEK7dnarEs0PMX3KS2KFW9hmPa1Ji/Dgwjy8uvOufQ8kCAKOYxaWjV1ittV/j5dH+5NJuenF1JPlYofY3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xCw6rD6Fry/PfkUWkrnxiJQ8x0X4fQDsOM12OX65ZA=;
 b=EAxNSgBXbiqhtdohhgp3yj1AsJhpCSFz7RJurjfenRBmX3W2wSf3abi3EtWk6VpzZ7jw50VmL4NS3EaeLJCJKhdvALmtF0tz+Tvk4A/5ARZmKCQ7vciOupJ0FhvQzBMejV3xjw4/7hMDQTrTWt/z4JttdiejZadp5/twXZYiNlliGRUgnGZ2DRqONNs7NzjXrBlH6C9ah5OPe152dksO9+iIfl3TI/+szHXNE5ehO4N0pXacTHbXty1h+UTfqqoEyvon+5rePcx6iqa6Uzb1v71HaGhGIsh8fWLeu8EhwrajVLvwBqC6jR3cP7Hi77EmCQqKA2qBqP+u/dQqSSNSAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xCw6rD6Fry/PfkUWkrnxiJQ8x0X4fQDsOM12OX65ZA=;
 b=5FajIQWiDn9MPMqW6p6OQZpAsC/zDaCmzxk5HnHeHek+Gy+DBoyv79BF+aVStIxkT/DJHOYkWPk4p3qtqPYJhcLsFct60B2aI7YMO75j7F9eKRoQG07lw/UbGDcylG9R49FujFLq8bB7669BSCETmGq7YT3sPi+cnyQptCPmUuM=
Received: from DM6PR12CA0033.namprd12.prod.outlook.com (2603:10b6:5:1c0::46)
 by PH7PR12MB6720.namprd12.prod.outlook.com (2603:10b6:510:1b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Sat, 27 Aug
 2022 02:51:05 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::d1) by DM6PR12CA0033.outlook.office365.com
 (2603:10b6:5:1c0::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Sat, 27 Aug 2022 02:51:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 02:51:04 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:51:03 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 26 Aug 2022 21:50:59
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/33] drm/amd/display: Add DC debug option to force LTTPR mode
Date: Sat, 27 Aug 2022 06:50:31 +0800
Message-ID: <20220826225053.1435588-12-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826225053.1435588-1-Brian.Chang@amd.com>
References: <20220826225053.1435588-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1461cfb1-b1e3-446b-61bf-08da87d6fc2d
X-MS-TrafficTypeDiagnostic: PH7PR12MB6720:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kbv/4g2pW9SB7HAGebMLNvQ49RMzg9vws6a8MGrpGWPID9K+Keo1txAKp0atN01swTSpOWlg5Qfp5h4VaL7awB8Gzxaj3OE7j5mZBr7Ks4tRWbCZNZsRpiLXEUMzmvdhmrt2OMCwbFvx1DHejN0Vg5rBpRuktD1s/HzGVbno+w9euXbjvGuR+CrT95A/oN323sxU66/+vzcx8wOcB5JrhGM7b2NPbPHmV+eE34e0YcLfjdIdMB+5yPM6c7iXxMVOTfZnVIh1w333Xi8U6ZhskYREYqqsvmf9Epkrf2UV5korpxJa6YDGhzLftKVX4edyhFydmbeB5+RFEWpxjm55B8kouna+gzlMoj0t6MKxGcLxFgqpQDT+3vEJivNJOJL4N8WEgL+iHM6C0+Qpxo0gxPkSKi1ZqJM345/Hd6LzluZreICU/CSc3F9JuzKcKfqQQ4tofsfgUG45Mdeut6PlOU8xuFhW0VTB+h6cKqU2FoL2OxDf1mk9GvTXyV7f6m9vr1+HgRIH0GnseO+IxlGiTQliGrsqD7UIGWfqFYE08YEa1A7ZLyt2nlGDey91j5/kpSCFZVe7NjhKFOuCCiK/jeqfDzvPqzodqki2nTncBIzSs3OmylLAQ+/K+2ZAqWjiH6Ui7sbQkKFV78vGZ/zMxa4k6AnLBvJQjILAlFmFJUcKMXV3ICF94RfURX9PDaDmPPNYH+yqfH5cR2Z/7pfh9RuqlWU/SyXf4IrnQ1PBuz4boVl32X7aiv3yzjqXsEKEt6niqtOWPBUfqdgBRZqc1G2VJSgII7wmJLqJuBEvmrnfVznxfrQdYvxAB5SUbr6smlUGm2hJlPM7IqFwGszSBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(396003)(39860400002)(376002)(36840700001)(40470700004)(46966006)(36756003)(8676002)(82310400005)(4326008)(70206006)(70586007)(40460700003)(6916009)(54906003)(6666004)(478600001)(8936002)(316002)(5660300002)(2616005)(26005)(336012)(1076003)(186003)(426003)(2906002)(40480700001)(41300700001)(83380400001)(7696005)(36860700001)(356005)(82740400003)(81166007)(86362001)(47076005)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 02:51:04.8992 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1461cfb1-b1e3-446b-61bf-08da87d6fc2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6720
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 George Shen <George.Shen@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Michael Strauss <michael.strauss@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
Useful for external teams debugging LTTPR issues

Reviewed-by: George Shen <George.Shen@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 4 ++++
 drivers/gpu/drm/amd/display/dc/dc.h              | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 8617de559174..7e97265b76e8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -5032,6 +5032,10 @@ static void determine_lttpr_mode(struct dc_link *link)
 	bool vbios_lttpr_enable = link->dc->caps.vbios_lttpr_enable;
 	bool vbios_lttpr_interop = link->dc->caps.vbios_lttpr_aware;
 
+	if (link->ctx->dc->debug.lttpr_mode_override != 0) {
+		link->lttpr_mode = link->ctx->dc->debug.lttpr_mode_override;
+		return;
+	}
 
 	if ((link->dc->config.allow_lttpr_non_transparent_mode.bits.DP2_0 &&
 			link->dpcd_caps.channel_coding_cap.bits.DP_128b_132b_SUPPORTED)) {
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 2362d5ee2401..473e6a0c3310 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -846,6 +846,7 @@ struct dc_debug_options {
 	bool exit_idle_opt_for_cursor_updates;
 	bool enable_single_display_2to1_odm_policy;
 	bool enable_dp_dig_pixel_rate_div_policy;
+	enum lttpr_mode lttpr_mode_override;
 };
 
 struct gpu_info_soc_bounding_box_v1_0;
-- 
2.25.1

