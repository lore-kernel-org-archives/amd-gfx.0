Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90CB7C433EF
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Feb 2022 01:51:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08A0A10E3C0;
	Sat,  5 Feb 2022 01:51:05 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1398A10E31D
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Feb 2022 01:51:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/KvQLmlYzGr6Pk3vhPbfxQWqfbU+0Sa2PqjV7SPc2p8f6QYCZ7rkMgkQKAHenxD/FZnLs0ygQdXR41Du2tbL6Fxzlyp65UBgTMEEss6v5DVnstNvCk0bz+qdjpzV3ouEZ8b6ivpAcoafKsbI/oSRBkicPOhocv4bZK6braQgUF12oGRfvvK73ApTuSsSy4beRE/6FW2lKtinw6KqP4HTKpJKHaG0DYkerJ/pdEppCQTnq1o/5H/n/1kQjI0UWIJRZuHqWCO9LxRhkMSdvMpIP9Arz/ZeLiGtGk+xfqsbLxpy+R6+aszswT6V6hNgWCaL/s30S4Vu+OHyR7gUMGHlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIJ1En4g4buQ0lCRkRyt7He0arc6cYNWZQLwFKqO89M=;
 b=Qsby0RAenyWewhM36g/VFfeq3PqjCo87u20jeu7oLbknCRUPHg5oKmdV2taWA6r+J6svstXYWpicMYFK1RSN+nyGoDrJduI4IUxBh9NuGMwKExBfHVCnMUhJwerENOynVaXS8VN6/7szE8rRIFXHTqca6lmlLwiJX6F0phE5M6NqS0b+XZ1ZAE38XmAaLs/B1b27WYRK7hw+kMJbm8/K7kxkwdUSaqMOtQp7JZe1gvoxwiRVE8UvZdVZtw6Ceq7GXxrACZ/2bARCNjCPqLipfLzf2/NpAADnR7oorEXZ/IwWAqlw4D2XDCy1vlsC1rfIcWP6klwVpstczrZxHh1puw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIJ1En4g4buQ0lCRkRyt7He0arc6cYNWZQLwFKqO89M=;
 b=zf2VBruxStBu6il7z+QrWXXoQMaPVwCZc6M/VilFlHqQZYRuqYo8eOPWkdRpYD0Shz7kq/RWkaZ+CcsWmdT85UcK+wtNB3bZjYHdsanNR53Zgs5rLfZeBFABlne9eE+NTj2tzzpoH2Z6ly1cEs5D3JSetjOV1zCKabr+72bWQEY=
Received: from MW4PR04CA0350.namprd04.prod.outlook.com (2603:10b6:303:8a::25)
 by CY4PR12MB1160.namprd12.prod.outlook.com (2603:10b6:903:38::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Sat, 5 Feb
 2022 01:50:56 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::9) by MW4PR04CA0350.outlook.office365.com
 (2603:10b6:303:8a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Sat, 5 Feb 2022 01:50:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Sat, 5 Feb 2022 01:50:55 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 4 Feb 2022 19:50:53 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/14] dc: do blocked MST topology discovery at resume from
 S3/S4
Date: Fri, 4 Feb 2022 20:50:21 -0500
Message-ID: <20220205015029.143768-7-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220205015029.143768-1-jdhillon@amd.com>
References: <20220205015029.143768-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b2dad80-b658-4a39-96ac-08d9e849f32b
X-MS-TrafficTypeDiagnostic: CY4PR12MB1160:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1160C7B69E0169D41834231BFB2A9@CY4PR12MB1160.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BqgM1V7WlHZ9rJ7lIMYqNYlkpY3jGMegvHyaL8JUONSNH3ividoRZut38KBGT0lhEpUxXJia7nbyb+SWOx7LPX4m5vC0rTKfbWxuNG+hkw/EdrLcRtxozGsU4vwEG0p01BKA4K6Xz33ANDSamzp1LKKiwEy1SKtdmJDNdxhrTsuQ2swtbGGOrodXCRv47ZQJwgGU+7u02MWVEIyMQVCu1a6t3pqrmedksmXk3qqSaVZJ/Q6Yz9wba5rSTLoM389SjuEd5ZpQ4e0dO7CzQHu9/ho/wwlk7HYa67Zx7JcYiWnq8MCdgnqdpWgr3bgb+zkENFtOQEvtbJ4WIwmIPmxx7MVZQFM50e76XsXmXvm61LTe9UWCb1wt0UzMqnoRbNXl0rgoe2TBQv6TVSjNJoGOd70m5476zzXaFZ6Y+ZDiMdd2k+FQVA3xKcdM9Htio80U7wuPSSloNbzixjO9iL2i3LzJMgNsitBuqyLzM6v9nNG4ytgUTTu/jZYx7Gr35Tw7DY1Omktf7Y3RhGQjvmRcH2yAXcrqY187eMaFwAPGuHergyjhxocsgrRHePHx9K+oNYaC6lHWxiCoFcVVpW3n/N4mGsRjRJ49hxZx8E1NDhwNkxsm95PvtLMy2RqTrowaKOnEOmQcDIKKy29EnfWGX+ntolJw6M4fpEcpC7V7qtgpuYl5Nw6qly3SvkxgOlvFe/K+lNaRSjXY9yTg6krrNA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(82310400004)(26005)(36860700001)(508600001)(83380400001)(336012)(40460700003)(15650500001)(426003)(1076003)(6666004)(2616005)(186003)(4326008)(70586007)(8936002)(70206006)(6916009)(316002)(5660300002)(36756003)(356005)(47076005)(16526019)(8676002)(81166007)(2906002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 01:50:55.7737 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2dad80-b658-4a39-96ac-08d9e849f32b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1160
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
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <Wenjing.Liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com, "Guo,
 Bing" <Bing.Guo@amd.com>, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Guo, Bing" <Bing.Guo@amd.com>

Why:
When resume from sleep or hiberation, blocked MST Topology discovery might
need to be used.

How:
Added "DETECT_REASON_RESUMEFROMS3S4" to enum dc_detect_reason; use it to
require blocked MST Topology discovery.

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: "Bing Guo" <Bing.Guo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index cb6c91cd6e83..ec4b300ec067 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -831,7 +831,7 @@ static bool discover_dp_mst_topology(struct dc_link *link, enum dc_detect_reason
 	link->type = dc_connection_mst_branch;
 	dm_helpers_dp_update_branch_info(link->ctx, link);
 	if (dm_helpers_dp_mst_start_top_mgr(link->ctx,
-			link, reason == DETECT_REASON_BOOT)) {
+			link, (reason == DETECT_REASON_BOOT || reason == DETECT_REASON_RESUMEFROMS3S4))) {
 		link_disconnect_sink(link);
 	} else {
 		link->type = dc_connection_sst_branch;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index e7ead9e25318..9ad3ee4079c3 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -312,6 +312,7 @@ void dc_link_blank_dp_stream(struct dc_link *link, bool hw_init);
  */
 enum dc_detect_reason {
 	DETECT_REASON_BOOT,
+	DETECT_REASON_RESUMEFROMS3S4,
 	DETECT_REASON_HPD,
 	DETECT_REASON_HPDRX,
 	DETECT_REASON_FALLBACK,
-- 
2.25.1

