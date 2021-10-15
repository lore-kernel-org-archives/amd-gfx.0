Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FF6C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:44:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 084B261041
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 084B261041
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04F4D6EDC3;
	Fri, 15 Oct 2021 18:44:02 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 797316EDB2
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 18:43:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ko33xXPR7bVubzEXo+0aHYU1pu0HAiTscmQ2EZ9o+fUhO0iSCrhhkQHqeuAMRcAPHzzHcNgH1ts2wX7IXz71Ky4aXq5HsB2IZ4x09uT1JdebsFTGssge3QXeRkE/IaTyvWiGcOWDzQEvpnaVF+fvlllSk1+zg1Av98vrKE6R9JT+7JetGuPhTKI37msq2tnZyw5XqJC2h8nLL7akq7XEa5a5QhHEbjf1frXp8+G7XeDVyZQFxHPWVHBum4wV2G7JSi5fB1PQnoFosfMUY6mR8VcxlAzHRDF3oHQwmzZxcOcKIG3SJ8pCHVfRA9j7SkLWPrYpT9Ns1zS8cNCOmuwOJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJAPNRIvnoHBlF469L6vDpekVdYWmDxzC6l0aLA/v9E=;
 b=Fu1eYkaqLFLwHU6f3oz6Vigfsr/wxgC8CTyHr/RiamjiYhmeZezC5RMAEcOJ0128L8ti8nYYKmV9UD1+CnwsLMYZuFQ7MiXhZ0fk4YbgwnyKqrJ1glitq2bdz0qPY+Bd7MKA6RuCAnbj4e4S5RGU+f4rY6PHyJBiZuU1/legVlRU97W2/F3NvRX2Gea58dctFKAkndEZE0PgNeM/YYQzioqi2Wcp0o3V9eGjNexdqcv6KZOrhZY88zRvqDtcNm5PXiKhbnqiwDPQJ9sCbKJ9VB+L/D1YxqywnFsTtsBrrKwudx5uDexGh+z3ivlcyQHxx6TcfM+ESsBSBJ4EZUkeaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJAPNRIvnoHBlF469L6vDpekVdYWmDxzC6l0aLA/v9E=;
 b=gYKQFd0kPjzftaK64B0+KSBAyYW//8Ih1768ntTDmhOm8UwWT/U4QfPjylfrz5qgXwxpW6+r4Hanr/2yxrJCfhO2vkxm74o8KZW3a6doZeCq6wF4fSs+9rXEReehmaBF6bPj27ZTr4IjC4po+cYFXPavRsb+9455tCLO0+4dgRs=
Received: from DM6PR08CA0003.namprd08.prod.outlook.com (2603:10b6:5:80::16) by
 CY4PR12MB1829.namprd12.prod.outlook.com (2603:10b6:903:11d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Fri, 15 Oct
 2021 18:43:57 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::8b) by DM6PR08CA0003.outlook.office365.com
 (2603:10b6:5:80::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Fri, 15 Oct 2021 18:43:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 18:43:57 +0000
Received: from ubuntu.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 15 Oct
 2021 13:43:55 -0500
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, "Lai, Derek" <Derek.Lai@amd.com>, Anthony Koo
 <Anthony.Koo@amd.com>, Derek Lai <derek.lai@amd.com>
Subject: [PATCH 09/27] drm/amd/display: Removed power down on boot from DCN31
Date: Fri, 15 Oct 2021 14:43:14 -0400
Message-ID: <20211015184332.221091-10-agustin.gutierrez@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211015184332.221091-1-agustin.gutierrez@amd.com>
References: <20211015184332.221091-1-agustin.gutierrez@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be861d1c-44e1-475a-edb4-08d9900bbf09
X-MS-TrafficTypeDiagnostic: CY4PR12MB1829:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1829E8382E6A89E886818D77F5B99@CY4PR12MB1829.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gPprFFbH0aSuRvwQs1q+1H6c/FZi9pdN++pFWdfMfWAvZp3vWgfp8mxqtDSz4iDcm5AkjUYiGHNt6qdFlyw9l9837lN5Kyb76jf87rKdln3smky7Dfzg/+e0YJrRbX1r9ki4DySiVkQ/rlBTkUdzHam7vFgiCWX2JlAsv5zBcDq3IjnHX54OZwSHuiIlAyQerU+fxBF0C4LwHOWs/VzUXcRmOUSyT+Zbd5vlmLuzoTSsfVgAMUBaE2LUyo8v4ZV6AA3UWchB/oCV3yBVMhqpS+ii2zoUHDxYvyTtqpYaUFsmqpr177kLzptyN3tg7kaMBboAgq424tWkU5WkW7RYSSJ5brz70cYMG/z7D+plmlbP1SLmtBxs7B5Pu8mnhtueo7z75r0Nkz4/SUlmkW5y4/0EzBJMYCj0B4P8Jdw4c6am7Uk4SqJrCip3zBCUJNSwCVgyNCfzVYDrsYn9uIMmG/xGdOyy5afE0ZqEM+ViE/61819jWWCkqkeKRVtXMq0IfBwcTyoRTMMOk8wi0/a9gTBdmVSZt7D5KVk54ASzfpFlNOPTp8ANL1YMQzCnSqGaanvebcIfii/DG7028wiUB/6MCGa+1uNnQ+jwAUymoAGSSU5XAEg5EuO2y2wJVHwi14J5fZbV5qx1ZwzUZI5+JfxHK4ez/AndqDQgB62c/UIZlf8dHNpwVzk9PBaxDTvvzlNVD5NEcib3AUo5gpBrPpGwb0YE+BNi+K1oILwL/oM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(5660300002)(8936002)(8676002)(336012)(44832011)(4326008)(36756003)(1076003)(316002)(54906003)(70206006)(2616005)(82310400003)(70586007)(83380400001)(36860700001)(81166007)(6666004)(16526019)(47076005)(426003)(186003)(2906002)(508600001)(356005)(6916009)(86362001)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 18:43:57.2965 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be861d1c-44e1-475a-edb4-08d9900bbf09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1829
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

From: "Lai, Derek" <Derek.Lai@amd.com>

[Why]
Error message on Linux when booting.

[How]
Removed power down on boot from DCN31 HW init
to match DCN10 HW init.

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Agustin Gutierrez Sanchez <agustin.gutierrez@amd.com>
Signed-off-by: Derek Lai <derek.lai@amd.com>
---
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    | 43 -------------------
 1 file changed, 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index 968b8825dec7..52947c03be31 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -73,7 +73,6 @@ void dcn31_init_hw(struct dc *dc)
 	struct resource_pool *res_pool = dc->res_pool;
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
 	int i;
-	int edp_num;
 
 	if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks)
 		dc->clk_mgr->funcs->init_clocks(dc->clk_mgr);
@@ -209,48 +208,6 @@ void dcn31_init_hw(struct dc *dc)
 					!dc->res_pool->hubbub->ctx->dc->debug.disable_stutter);
 	}
 
-	/* In headless boot cases, DIG may be turned
-	 * on which causes HW/SW discrepancies.
-	 * To avoid this, power down hardware on boot
-	 * if DIG is turned on and seamless boot not enabled
-	 */
-	if (dc->config.power_down_display_on_boot) {
-		struct dc_link *edp_links[MAX_NUM_EDP];
-		struct dc_link *edp_link;
-		bool power_down = false;
-
-		get_edp_links(dc, edp_links, &edp_num);
-		if (edp_num) {
-			for (i = 0; i < edp_num; i++) {
-				edp_link = edp_links[i];
-				if (edp_link->link_enc->funcs->is_dig_enabled &&
-						edp_link->link_enc->funcs->is_dig_enabled(edp_link->link_enc) &&
-						dc->hwss.edp_backlight_control &&
-						dc->hwss.power_down &&
-						dc->hwss.edp_power_control) {
-					dc->hwss.edp_backlight_control(edp_link, false);
-					dc->hwss.power_down(dc);
-					dc->hwss.edp_power_control(edp_link, false);
-					power_down = true;
-				}
-			}
-		}
-		if (!power_down) {
-			for (i = 0; i < dc->link_count; i++) {
-				struct dc_link *link = dc->links[i];
-
-				if (link->ep_type == DISPLAY_ENDPOINT_PHY &&
-						link->link_enc->funcs->is_dig_enabled &&
-						link->link_enc->funcs->is_dig_enabled(link->link_enc) &&
-						dc->hwss.power_down) {
-					dc->hwss.power_down(dc);
-					break;
-				}
-
-			}
-		}
-	}
-
 	for (i = 0; i < res_pool->audio_count; i++) {
 		struct audio *audio = res_pool->audios[i];
 
-- 
2.25.1

