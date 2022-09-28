Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24441C32771
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 19:42:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3413210E9CC;
	Wed, 28 Sep 2022 19:42:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B41D10E9B1
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 19:41:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FgFzysLVUxskHDEbhK4JJmU1I+FIEiIjICpA0Ka80pXrnkQIYWXWnWzLe/kTFOGcqjL3J175iukYeZi3XOXVsx7K/BuSgouLZObdrboV+6y4FSlzTyPlBY/T5JYPFecWr0I3kDZTQH7tS00ZOgBSeE08S6sfKfHtnfVnlQnl3Y3LcTSD+FvePrG9EmrquLgyoSMnTJCghwtk0ceeGqonM2Oz3fNK2T7wOWX0ZclGapNDJao8pTJBwkEnSCYsJp/jnWuaDtMmq4tqV26VhfIdZFfTdoHSKAw4f/sx9tl9pCCqYOiqZUFzA7ky0LuLaU9+cOny65hMWi9i5RcuXVyTbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWwe50VHBGiA6G5aRcFah89BUR1n0VI4eQV7LUVqffY=;
 b=MTZc/sBxj2FAEk6CQI3HPyfKZ6wIWO+1qPZ4gQWE954/tBI/Cyh54ffMcJWhnSdZhdBr2PtSiLO5v7qvy9MhlIcY7ATDqrbvIJbTYoAs7FChOOqkEX/MX2pIUAnGQw1lmG670hhuyPe5dcdRgwnwQbNH6eqKpa2UjLFFwxS6Trb3mgTpO0e8/9WMMe+H7S0rTShpBVKRjypMjeDPJ9E6guY8HhKTChaFprzkSVJZyYJv4mtk9ZEo2o3msFeyYfCERskEELExkwFwR50cSGA78gI5hKh7Bt48bdr2lHHNCOH5jUkGfFmFOaCKloWS240bJjoMHlKibddhqhGPxb6oYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWwe50VHBGiA6G5aRcFah89BUR1n0VI4eQV7LUVqffY=;
 b=o87DsX3Evl0jQIx/0rTAPab8tE+zEsVjSgimXKbPvLuBTQRAL8oHf+gYz7uaaBhGjow9Mi3NphJOVyJHfaRjH59Pe6posWp5hh/5U6UkE0xOgEaWAED+WEiakaBwR3J5k+FeH9b0v2NjDw5spJF6jFKgBxcS57vA9Z73FCa/5Yk=
Received: from BN9PR03CA0746.namprd03.prod.outlook.com (2603:10b6:408:110::31)
 by PH8PR12MB6721.namprd12.prod.outlook.com (2603:10b6:510:1cc::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Wed, 28 Sep
 2022 19:41:34 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::2b) by BN9PR03CA0746.outlook.office365.com
 (2603:10b6:408:110::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 19:41:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 19:41:34 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 14:41:30 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 26/36] drm/amd/display: Remove OPTC lock check
Date: Wed, 28 Sep 2022 15:40:18 -0400
Message-ID: <20220928194028.144879-27-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220928194028.144879-1-hamza.mahfooz@amd.com>
References: <20220928194028.144879-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT031:EE_|PH8PR12MB6721:EE_
X-MS-Office365-Filtering-Correlation-Id: d84a7d79-7a7b-441c-86f5-08daa1897352
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HJVmu0By3yfdc5PPRN9Xvq4pw/BBrFbdw8b37Tydisw5tT2RZQqPrflxPPJ4D9Kz4zYdjBbkvXOsgCTH/nK9uibVost2zjcKTQ3jJbkVeY3jLSHdId1IltVipgUwa5KTJfClWXh17x1gzdCXjOYPAHLrYCf5pWEx8xsQXyvDkxdWKwyZKNeAqmRnQUzT/a9AaqDXPBvI1v7vjZtKyn8BuQ6wnxwxTmKHhnbupk3oThwp2ml8TJZvtuXaEgrsMqoJTTdgopn4IlLJ4vO7FLNpYItDYqJN1a0exmkiPONdXdyMg65BEsr+RZqq+2O0p2wpYXUGVjrv8PPn5WEwHTsNrWZp3jvZXaPA4fsDrh0jjlX7mVXsWLcJYOeCJWPIC25r+8EI0l09ioG19nbi+f2kM8M3BHZG/e/uvCrZT9g5RovBL9ZS37Vio6rORkKi3LAFaTYR1wnwZBpnWAzzc68TolpBEZ5q+ZvjBW9TTCqWquVzRckg4a1iOC+6wH8T7yJlVg2+RXz1lb0WCdVX63myO69IlvC4k/fgwoy9iOcuepT3SMXdM9t3uoSNkqRJoCw+XDDwYY98xEziPbiBRz4sQ0PbtlmfckypmsYK2DqkUsPrpUoBmaFH8yGq4GBzGuuaTbb8Qe+Ev0wWzfD05XeodFs45NWBm0XarHk8QN0k0PNcizFjBgRTHaNu4I75Sa50okB1pVFR3aTS3b3Y6lhYO6Blc9hAZiVTIG9sOrWhIswzwUPVOnNt5Us6zpdYuVSZ8clbJOA+MdDd9SDAXHjsn2m3F3NekPTr14DOaFhTtqm4lWK3LV17ZrV5BBAH8qz1/keefMWJjuSpqoxNZrdeNQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199015)(40470700004)(36840700001)(46966006)(316002)(86362001)(82310400005)(54906003)(478600001)(8936002)(36756003)(70586007)(70206006)(6916009)(4326008)(5660300002)(8676002)(41300700001)(83380400001)(40480700001)(81166007)(40460700003)(26005)(36860700001)(44832011)(1076003)(356005)(7696005)(16526019)(186003)(82740400003)(336012)(47076005)(2616005)(426003)(6666004)(2906002)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 19:41:34.2945 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d84a7d79-7a7b-441c-86f5-08daa1897352
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6721
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

At some point, we decided to blank HUBP during pixel data blank, and to
handle that, we added some OPTC lock checks. Later, we realized that
this change caused multiple regression, and we removed it. Nevertheless,
we still have some leftovers that might affect some ASIC behavior, and
this commit drops those changes to keep the code consistent.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c     | 11 -----------
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h     |  1 -
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c     |  1 -
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c     |  1 -
 drivers/gpu/drm/amd/display/dc/inc/core_types.h       |  1 -
 .../gpu/drm/amd/display/dc/inc/hw/timing_generator.h  |  1 -
 6 files changed, 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
index ea7739255119..143a900d4d3d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
@@ -679,16 +679,6 @@ void optc1_unlock(struct timing_generator *optc)
 			OTG_MASTER_UPDATE_LOCK, 0);
 }
 
-bool optc1_is_locked(struct timing_generator *optc)
-{
-	struct optc *optc1 = DCN10TG_FROM_TG(optc);
-	uint32_t locked;
-
-	REG_GET(OTG_MASTER_UPDATE_LOCK, UPDATE_LOCK_STATUS, &locked);
-
-	return (locked == 1);
-}
-
 void optc1_get_position(struct timing_generator *optc,
 		struct crtc_position *position)
 {
@@ -1583,7 +1573,6 @@ static const struct timing_generator_funcs dcn10_tg_funcs = {
 		.enable_crtc_reset = optc1_enable_crtc_reset,
 		.disable_reset_trigger = optc1_disable_reset_trigger,
 		.lock = optc1_lock,
-		.is_locked = optc1_is_locked,
 		.unlock = optc1_unlock,
 		.enable_optc_clock = optc1_enable_optc_clock,
 		.set_drr = optc1_set_drr,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
index 6323ca6dc3b3..88ac5f6f4c96 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
@@ -654,7 +654,6 @@ void optc1_set_blank(struct timing_generator *optc,
 		bool enable_blanking);
 
 bool optc1_is_blanked(struct timing_generator *optc);
-bool optc1_is_locked(struct timing_generator *optc);
 
 void optc1_program_blank_color(
 		struct timing_generator *optc,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
index 1782b9c26cf4..02459a64ee21 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
@@ -319,7 +319,6 @@ static struct timing_generator_funcs dcn30_tg_funcs = {
 		.enable_crtc_reset = optc1_enable_crtc_reset,
 		.disable_reset_trigger = optc1_disable_reset_trigger,
 		.lock = optc3_lock,
-		.is_locked = optc1_is_locked,
 		.unlock = optc1_unlock,
 		.lock_doublebuffer_enable = optc3_lock_doublebuffer_enable,
 		.lock_doublebuffer_disable = optc3_lock_doublebuffer_disable,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
index 2f7404a97479..d873def1a8f9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
@@ -260,7 +260,6 @@ static struct timing_generator_funcs dcn31_tg_funcs = {
 		.enable_crtc_reset = optc1_enable_crtc_reset,
 		.disable_reset_trigger = optc1_disable_reset_trigger,
 		.lock = optc3_lock,
-		.is_locked = optc1_is_locked,
 		.unlock = optc1_unlock,
 		.lock_doublebuffer_enable = optc3_lock_doublebuffer_enable,
 		.lock_doublebuffer_disable = optc3_lock_doublebuffer_disable,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 4ff1392633a7..1fd7ad853210 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -439,7 +439,6 @@ struct pipe_ctx {
 	union pipe_update_flags update_flags;
 	struct dwbc *dwbc;
 	struct mcif_wb *mcif_wb;
-	bool vtp_locked;
 };
 
 /* Data used for dynamic link encoder assignment.
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index 72eef7a5ed83..25a1df45b264 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -209,7 +209,6 @@ struct timing_generator_funcs {
 	void (*set_blank)(struct timing_generator *tg,
 					bool enable_blanking);
 	bool (*is_blanked)(struct timing_generator *tg);
-	bool (*is_locked)(struct timing_generator *tg);
 	void (*set_overscan_blank_color) (struct timing_generator *tg, const struct tg_color *color);
 	void (*set_blank_color)(struct timing_generator *tg, const struct tg_color *color);
 	void (*set_colors)(struct timing_generator *tg,
-- 
2.37.2

