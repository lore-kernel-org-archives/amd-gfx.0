Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87237ECAAD4
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Aug 2022 02:28:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E01E910EB50;
	Sat, 27 Aug 2022 02:27:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B28E210EB50
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Aug 2022 02:27:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFZUQIVDopVlnXeJrjGp5PB31065AQmFWijQHOOrSV1sr4+Ff3Wea3sfyluxNQOxJroF2N9qwZEcX2ZsyB1jSOP6zybKNmi/lO/KNJj42ntcY8nq0188ddSMlknSoQr7PuWdPh79IDG8ayjv5pSc6wqWJ61q+rb9mlyU0rsrK6c8b4kttzF5xsgxtqIT2wGVh/wAwWD4A7GIWvZ0apyzjw5CvN+QXtPHDlrdskjUiSxqxMmjNCjO3dU49A7zQGQjH/pcB5eTGMTAcJwB1CHPbOtNT2PPClBcGqHb0xt5UbhBOJGSjcCB+ohk6w06qmuoz04R4tvaxzlkfCugtC9Tbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xCw6rD6Fry/PfkUWkrnxiJQ8x0X4fQDsOM12OX65ZA=;
 b=ehjWVzEp2BCxJ6xC2KpBZBuelVCFHcdir6bUUbXvP7AHGCc8N4Tc/0mvDwkS899/YYkkqxorDHbEmo5KYJjvw/sY0Nxrnr/64MkTE7eZVB/uLjXkTrmIYH2SQbVNmkCs3rsrniiSd3wWR+c7YbDR042r/z6GlF1miQG7gD/xU+7z+F7MHcEPxm7qvmyXdt3kjhQx1NebrVVyVveOKA+8NPPOOWtfMvwftu1rBCq9nJk7CXf4u45yqZcz4a8orrMO5x7dGaPQ+m7eToOL8LJGzOZlSs8IAoZtO3FG80jewSryeUYg49amYmxppF9BaRHG95FRsQryZfRyJQZ2Q6CqHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xCw6rD6Fry/PfkUWkrnxiJQ8x0X4fQDsOM12OX65ZA=;
 b=EkDQl1BnzdJZIHkOk6MIIErUTh+rPJI844prUS1PMudK3sFT04OAXO/qYZM6xSa+x+/s6mveSH4ytafLN3SZYw1axS1/mgbB3Nk5+DlzFcWf2EiAKz5M8kjFAlSxJ7TT+0QIFWjRn1yF8c0KP9q9SZe4/JaazXDwTZAstjaQESg=
Received: from MW4PR03CA0306.namprd03.prod.outlook.com (2603:10b6:303:dd::11)
 by CY5PR12MB6250.namprd12.prod.outlook.com (2603:10b6:930:22::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Sat, 27 Aug
 2022 02:27:40 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::74) by MW4PR03CA0306.outlook.office365.com
 (2603:10b6:303:dd::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14 via Frontend
 Transport; Sat, 27 Aug 2022 02:27:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 02:27:40 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:27:38 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 26 Aug 2022 21:27:35
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/33] drm/amd/display: Add DC debug option to force LTTPR mode
Date: Sat, 27 Aug 2022 06:27:00 +0800
Message-ID: <20220826222722.1428063-12-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826222722.1428063-1-Brian.Chang@amd.com>
References: <20220826222722.1428063-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf0d9f9f-27c4-41fb-f53f-08da87d3b723
X-MS-TrafficTypeDiagnostic: CY5PR12MB6250:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iMJPV/sPe620/mwB27w3SXHeMkfG5d1F7W2T/YFQ0BDv+zPqyscVVB/xCMHYNGejlxIBlc8m84X+E1lXkNS/pAXYEAh4KbTk0fiu998S9Mkj7fJbhjkirpb2llSfTQTWekySP0Gbyw0wPgq3A2W4x6NFCcP7rb93ELOeyqWhuzr+BsuAh2GsTnHXRqICiuIahBqgrN3HYoq5dwpduUlvRtJFqAgWgEDS3jOH3bIaV8EYzk5YphoN+Jk9AaK9+jR66zrxWC+TW3FqkSmuzBbPz+v+4gknsMpIQFTTgS9a5yKg3wbOd18EYrIJaUVhWRIblDnr46ZuS226eqXVU21xp4WWJ86qdkfpD3XNy7tnhrmcOY58GRQINuGgxGhfsrR8RJbGEX6Ssu+wpdBhQ28WqJsjdimGMpYAdtJXTJZiIG8qXdYzlUHUvNJHg0xN811AA8nafadIdnF24dWhoGSRgQnKwqpes2tZNLnlytSwGnKpeLYCOH5Bdan2oYPdp3LKp7L/NUlPeXmbUEzU2w6CtEQyQpHxMzoRJQD+JnEOvx6xl99qgbbSV9sPcoe809LVvnqBvgdlblLhdHuIbheXAnVzD11SPQL8mr6MC3rkwdLe7zaxuCLj5RG3e04SgyJuDHXqh5+d2+dgsYHxwLhXJNKXp/6uGZvrUijsSoTDruJq4BCbnEF6imRcvwMUXO8WHWzN5X8QEBzZEjpJf6SETSY/IE/iWvSxHIN4fRzmpmFw481BOFEJ3uxdaD/vQfmr9grBaULWCz34L8fGdfJhjWYfKB8ZapdSPXJhdX4QppfG1qhou5yGS1eyO4LLSsUDqilh22DpLwHnAIu3dlrtmA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(376002)(396003)(39860400002)(46966006)(36840700001)(40470700004)(336012)(54906003)(6916009)(70586007)(70206006)(8676002)(4326008)(86362001)(82740400003)(36756003)(356005)(5660300002)(81166007)(41300700001)(8936002)(478600001)(7696005)(36860700001)(6666004)(82310400005)(2906002)(83380400001)(40460700003)(316002)(186003)(1076003)(26005)(40480700001)(2616005)(47076005)(426003)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 02:27:40.4907 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf0d9f9f-27c4-41fb-f53f-08da87d3b723
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6250
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

