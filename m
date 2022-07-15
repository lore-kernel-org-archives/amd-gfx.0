Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 424F9CCA479
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jul 2022 14:38:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EE4110F801;
	Sat, 16 Jul 2022 14:35:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E6F910E2F8
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 18:17:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPwm5FefezNRF/JsmbeIpACzWdFfq+DQiW+rfckxXT9LfjNehzZEWS7p7HBlnsMi8V3a/ifnrBPfBlTXaW+1lQat1stSdVKNd4UadzGA+IU5+NuqTs965r+PTItUKCaHZrv6bSbXvLHDEbt/zI3eyCZSWuPRpiWB8XZM0VEXuJBmkBrOTEqPdhqgIiNhFXtpBQ+k+CEa/Zstmx6NrGg+7AOrw4U75pu9ZUvUvzJG3MJpadCIIQnw7S09mACVnpoQVBBi7A+ZEBMlsDol4XhCXAs8MUb+KQ85NHjlWvVSWbH2wR9irYovkf898hQ5UVuLBdekedZ0cZkY37QXDMn3Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7AqrqUeCa0kD03QQkiuevRSVNuWUmrS57UpeX77kl24=;
 b=PEcIQZtbl7M1W1vOxAFs8WXwNDLxz55bARbKpfUfPJ+VUDhU/L6mHeZIEju1DlLyw4sOZk5tXwvNUwyvVOHzI0vkQOc+aqyT8OQlIy2HNZ7IwXYqg4hymMonBPs1KruvlRlga40QiV3DrqKIqe7xlsdYA6kwWqNaAoJ30hs6LhcQFMP2KzjbenpGCoUKwpHQU9IgaI4vR0a6BL1j0KwUfdpiURhgGSF3Eui/pkfB5gO+qmObfYRhO5fSpWJwGhF8WvzNtmIZz5BIOoKj3QjGROiP/86MmtDW3o5G1qllEn6Cm2uzZKOx6fmXZN8xICA0Lq6Jy6a6RdGREamJRaEzyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7AqrqUeCa0kD03QQkiuevRSVNuWUmrS57UpeX77kl24=;
 b=1lAWjBhdbMgAIMdhnySUFRPGbtkjjnFMFd46DMjgeg1NzRJI1dc64hK1jhDuL3POx8hqhKDB+vMlGoHIYghXpz05uzKFjmcxgxmpOQ8ZXfOvMNmHhNH9JOpRL5O8ELNHsK/Y4UjiTZcqrCG789O0FlR9IQ+VpMwFPs2BaGXJuM8=
Received: from MW4PR03CA0023.namprd03.prod.outlook.com (2603:10b6:303:8f::28)
 by CY5PR12MB6600.namprd12.prod.outlook.com (2603:10b6:930:40::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Fri, 15 Jul
 2022 18:17:18 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::6d) by MW4PR03CA0023.outlook.office365.com
 (2603:10b6:303:8f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17 via Frontend
 Transport; Fri, 15 Jul 2022 18:17:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 18:17:17 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 13:17:16 -0500
Received: from arch-sec.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Fri, 15 Jul 2022 13:17:10 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/31] drm/amd/display: Expose function
 reset_cur_dp_mst_topology
Date: Fri, 15 Jul 2022 14:16:38 -0400
Message-ID: <20220715181705.1030401-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
References: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d05cf9a-c6b1-4fba-859c-08da668e4075
X-MS-TrafficTypeDiagnostic: CY5PR12MB6600:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZsvwpHls9dwNWtJ3tYinKE0mJtutYwhi6X8tDUw94EQKVFj0cfUDtX056GrEMy1rQIgKmOjTt+uucZ/2OThyip77VOpTbbND2FZxFBiMtYR1SInwHU4Yksbgvs2/HzYHQPJAQz2+T7DhUJSP5X+MsYeepuvipn1V0NoDMQfsbDft392dPEVVsVCRfXfQf9xrsAdCkLX/juMbOATrHIT6r7EmWcjNCVhy17rxrS+M4i52QDdmggJizGLM22NE9+shnn0IZMDG7JviB9V41bNvPSp6Eg9SRWWQNod+xabvZN+AU4A7uhQNZfvoNsThSPVRUn3cO8xRWQvtbz6K6LI1GIZ8lTbWSqxw0hYEzWLZkpaeVHS61w6bIXhtc5Znkk6/F+AfUIcZZUUhLKofIt0IkWMVYl/Si4mrTpTSj3TjvIkpY3jD2UBF60jz+25zZ49tbHqcwfTjg3qQg5/v7dpOlzz2Nfk9IAbZnivpZ2MGGqBWN2S8Gf5t4pOo/aUfAi5JxUOJTLZEPOznCK7dvR2UiR+wnegdZ1FjHVJQKRAkMCf2zpiFGnz+8dgb9Ix915z3InscDGFeraBuSv8p2Z6oIMspUrh/opHLY8SmenNnJIqB86TpcFCG9JxWc6yyXNs66akVNSAnCoAg9C/bmTF4zA1edXgCK1QdelsviW1VS7ObeggXMf+1PuG3MTrGKSJsmRvVRkVYKZlj9mJpT2Q6PTOaF6dFzKsECgqO6Tc+2vH7Z/JED5jSOQO5+Y+VKDXjOOT6+H3bhL4o9/pODJWIqxqdBuNGsashwLP5vSCJaiH1DmXLncEeyrp64PGt9F7FwgF945xlA0cRBzEL1YlEsQ6+DBMh5DxiMgfej8zm4wg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(376002)(396003)(39860400002)(46966006)(40470700004)(36840700001)(8936002)(40460700003)(36860700001)(1076003)(40480700001)(47076005)(316002)(2616005)(83380400001)(5660300002)(54906003)(6916009)(426003)(86362001)(186003)(41300700001)(336012)(356005)(2906002)(6666004)(36756003)(70206006)(4326008)(82310400005)(26005)(478600001)(81166007)(82740400003)(8676002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 18:17:17.7304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d05cf9a-c6b1-4fba-859c-08da668e4075
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6600
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Hersen Wu <hersenxs.wu@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wayne Lin <Wayne.Lin@amd.com>

[Why & How]
Need to leverage this function out of dc_link.c. Change it to public.

Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 858ee51f930a..ef54b96affa8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -845,7 +845,7 @@ static bool discover_dp_mst_topology(struct dc_link *link, enum dc_detect_reason
 	return link->type == dc_connection_mst_branch;
 }
 
-static bool reset_cur_dp_mst_topology(struct dc_link *link)
+bool reset_cur_dp_mst_topology(struct dc_link *link)
 {
 	bool result = false;
 	DC_LOGGER_INIT(link->ctx->logger);
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 023774b94da3..a0af0f6afeef 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -514,4 +514,7 @@ bool dc_dp_trace_is_logged(struct dc_link *link,
 struct dp_trace_lt_counts *dc_dp_trace_get_lt_counts(struct dc_link *link,
 		bool in_detection);
 unsigned int dc_dp_trace_get_link_loss_count(struct dc_link *link);
+
+/* Destruct the mst topology of the link and reset the allocated payload table */
+bool reset_cur_dp_mst_topology(struct dc_link *link);
 #endif /* DC_LINK_H_ */
-- 
2.37.0

