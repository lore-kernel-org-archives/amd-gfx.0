Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 568F3EB64DA
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jul 2023 17:12:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF2FB10E59F;
	Wed, 12 Jul 2023 17:12:16 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::608])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE49810E59F
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jul 2023 17:12:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgrvsctKmpEGVSP4fVjaI1QpJ9JW6vaAOq8wqDS6TC3Vt1gZBIPfpwz8RqIGOL/alNizEGcQfIMW6VnU5Z7H95F2qHVwypsb3d+xmRH/6a/BWSTcjKIvkyYj9bZ8aU4J1iYGjeg+iGaB0xAt5J+oEsHCIIGKjEuXwPeEjFoc3g3ZLX3PIfYZ5+b+4bu3MiTX+76tT+IUgCpHcErMW+mhS3i5oOufbEL7WH0WCopdJaSjjtbZzeGojCphJHjet8LRFYnz8d2nA8Kn68Szw6gGUZVxBRxM4AmZvnej//FGWgEZA2m4j2QJlU0q+tJ4Z6laV7tz3J/KA7F+S8PzbxXCoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQBSl9e+OMEeozvZm0QsARpsmBo8/XK6HV4DmQ8rROI=;
 b=Dir+1DdChdyXjtyoaBq9YA64gLrkY0HY62NYkg+uUtAz+wk8FBxyYeoeThOl7ISe+sk9aC1164yLWH17989uYhJr8wBVYjNQFF5m+oCsemmssXuRofhCZJkrzorTjZmuwuqdxjEEK9YIMLuJTyEQB1mOh1q0CLkwaJiZCKT8cNYmx1CA1UOlmDL3ZzWWwcnAotn6FDNirYQzTMQm6dI3G5Ohmwrpxk87aoGxm7n6UHyz+KdE64PKBW476g3Ok06qYsKc5rBndJD1QiTZFDnaNyF4aGFZRebo2CqCNVTYJLfKt1HrC8dZvcT/HHqelRgr4UHMuQGaMhOr+k/dnd7MpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQBSl9e+OMEeozvZm0QsARpsmBo8/XK6HV4DmQ8rROI=;
 b=x96UkU/1piMZIpo55kw8AQgXZc9Dgi2BztqGHJtvdt/aKQpXtqV949DIwIbevtwQEV5n+jYA5Pe8EJJFpv3ItVPX0H+JM/Go/6LSg4LjaICIf/Qgq+9etrPp83wBRR4gq9zRzJkA6iZWuZUh/7Sxk0mwOu53bfF7QXHgMbqy0Kc=
Received: from BN9P223CA0003.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::8)
 by DM6PR12MB4433.namprd12.prod.outlook.com (2603:10b6:5:2a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 17:12:09 +0000
Received: from BN8NAM11FT116.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::c7) by BN9P223CA0003.outlook.office365.com
 (2603:10b6:408:10b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Wed, 12 Jul 2023 17:12:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT116.mail.protection.outlook.com (10.13.176.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 17:12:09 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:12:05 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 12 Jul 2023 12:12:02 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/33] drm/amd/display: Use is_dig_enable function instead of
 dcn10 hardcode
Date: Thu, 13 Jul 2023 01:11:06 +0800
Message-ID: <20230712171137.3398344-3-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
References: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT116:EE_|DM6PR12MB4433:EE_
X-MS-Office365-Filtering-Correlation-Id: d598785f-fa1f-447e-e2a2-08db82fb203b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ihPfFf2TCTX75LQbS+0rjqcGDoI1PoAe8oj8SnKOHgClKWaHYieZNFwlYcwM1fuMEolJAJnd17utt+syMMrH2btv4W819Ly9rAXVxQK0AZc3XEJzWzOlVqmWBXU05tx2W0/lHXwfe0pVpU/q3V2N62Z8nhs9X8IhtX0d95BhHD/Q813d9tIu+EDbPpEFWNOu1GZYKkaY4C18RKOfGLKV4d1T9jbluB6W0Ca72N27bMxobfSNAxBDwj5K635ZekqJjq5KfKkinqak6jDru5D+ljRDXuoQ5bg0GZe9kksMBlI+JLqYABHspa7NM3SUBJv44VGAou6aiYWFTpIRjdOnYVgJKart5bU9EwcfvHQ7NWCsrbPf1NWboCsOPDB3w/YpjNJKfHqPrhuootLW22rIcIjhUfhIWech0d7JPArSS9jctr6yRR3Em1qCmKifFRLODJRdh8qIEftyuktdnvNCT3WPf2P8ge2wuuKSyEkcFRtMbFQqVDTn4SbiamdHT8StORJsyHYi0Ib4YvmnDNrPdYXBXXN+THfOZZplX+fBKG16smaNl7yRsGOSkb2XH4eat5QF/2ZdXBD0IYa/H5hIK1bAel/1NfU+i7gtVULoGy/yYy/VzsuuyQdOYRBk0GweGAocB9SKR/25EtW48SPT5IYTb8d/Z7rEaVV8tmKke7ur4hZyuVS4KTl3o69C7E7vPH8gDVwqSbO8wCfm9fwyn1z6sBmLiIO9azkKkufk0DMEVfeUG0j7zjm1jsQ9pyhlY/FLyWU9jhu/+cUS0XFwQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(47076005)(83380400001)(36860700001)(2616005)(2906002)(336012)(426003)(36756003)(82310400005)(86362001)(82740400003)(356005)(81166007)(40480700001)(41300700001)(6916009)(4326008)(7696005)(316002)(5660300002)(8676002)(8936002)(478600001)(70586007)(70206006)(54906003)(186003)(1076003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 17:12:09.1786 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d598785f-fa1f-447e-e2a2-08db82fb203b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT116.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4433
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
Cc: stylon.wang@amd.com, Alan Liu <haoping.liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Syed Hassan <syed.hassan@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
This can differ depending on ASIC and we can end up skipping all
transmitter control if we're relying on the wrong bit as a shortcut
for whether link is on/off.

[How]
The ASIC table itself provides the correct DIG check, use that instead
of the dcn10 hardcode.

Reviewed-by: Syed Hassan <syed.hassan@amd.com>
Acked-by: Alan Liu <haoping.liu@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c     | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
index ee08b545aaea..377f1ba1a81b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
@@ -1056,7 +1056,7 @@ void dcn10_link_encoder_disable_output(
 	struct bp_transmitter_control cntl = { 0 };
 	enum bp_result result;
 
-	if (!dcn10_is_dig_enabled(enc)) {
+	if (enc->funcs->is_dig_enabled && !enc->funcs->is_dig_enabled(enc)) {
 		/* OF_SKIP_POWER_DOWN_INACTIVE_ENCODER */
 	/*in DP_Alt_No_Connect case, we turn off the dig already,
 	after excuation the PHY w/a sequence, not allow touch PHY any more*/
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
index bd62502380d8..4596f3bac1b4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
@@ -558,7 +558,7 @@ void dcn31_link_encoder_disable_output(
 		struct dmub_cmd_dig_dpia_control_data dpia_control = { 0 };
 		struct dc_link *link;
 
-		if (!dcn10_is_dig_enabled(enc))
+		if (enc->funcs->is_dig_enabled && !enc->funcs->is_dig_enabled(enc))
 			return;
 
 		link = link_enc_cfg_get_link_using_link_enc(enc->ctx->dc, enc->preferred_engine);
-- 
2.34.1

