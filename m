Return-Path: <SRS0=8txe=6Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36927C3A5A9
	for <amd-gfx@archiver.kernel.org>; Sat,  2 May 2020 21:35:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01D782072E
	for <amd-gfx@archiver.kernel.org>; Sat,  2 May 2020 21:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ig7gTPk5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01D782072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5D5C6E1D3;
	Sat,  2 May 2020 21:35:10 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A6706E1D3
 for <amd-gfx@lists.freedesktop.org>; Sat,  2 May 2020 21:35:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAZSSDdERjD2DzBPDRes8dHoyTJcJXm0bL0ZH3eQsJdpA17E+e7Ei8tArZrHZNxvthw5i8Y/RrWJb2ZzaYtdKTDWnkV+5QBKqva7697xnYSwWkxkH+VXdmAN1wAJeM6FuD9VAaVHIsOzeop/aZ2I+iHbOH0dC9GUNOinqNRWwiF37BsrF1o/AKZT0NCrbfwOBGP+c5JxSsPKOAXQnU2m46Z5tirzx5SGWRpdHqrQZ4aq9vMguBM4rEDdRNAAAEm330HxEn/GHYkcTqXsBY2i9DxYsQMVxM3wgF4BEDKQF0q+4yG0whAQ36a4zEMOZRci3q4++7N6BBTtw0sirKS8Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUJkNZ8XKUjYttwKJJb5bVHUUMeDQ/sJFCbTj+8Xrww=;
 b=LYixPsb/vQH8c5BO1lgVA6O2401fJURS7wlQNLUIc3C9WtVAQwHlQ+Mn6q8HUKbVlG7byJo3AO9aeql/rTbPphT8t1lOy1JOoSriS74dS5kiin7oEupqzP7d3tw01rugkPPjw7iZcYWHU3Htqf5Z9jDnIqMQsVBXe9CO7XoJsWBwUgo7k88/2Q+vCJeF/pH3ER6RXMq89NEoqbq5Ws68umzLVaa+taT81jb693ufXhDRarU0SGm7mLW3zz2ejFTNpyVgOWiwqo7oEqWqP3OrE0RE5nrainXWYzAtcwAcnh5plirlljEdqkhMWMck6JNR/ELyBeyGbLaEDhgXGls6hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUJkNZ8XKUjYttwKJJb5bVHUUMeDQ/sJFCbTj+8Xrww=;
 b=ig7gTPk5JiIkDsbI7LMoPVIb8EtrlmpiuzFUMm7qW8d7dRDJlGtcPk6TXhB5g2e/MzklBUR2yo/sL0G1g03LZe4NEvI+sEq0YlZW0s7Px0Yl5MqpE5d//dinZpmz6POQXVXQ6m1SplTOqZFO3BCCnNXfgdr15AB1InUbxhJTamA=
Received: from MWHPR02CA0003.namprd02.prod.outlook.com (2603:10b6:300:4b::13)
 by CH2PR12MB3782.namprd12.prod.outlook.com (2603:10b6:610:23::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Sat, 2 May
 2020 21:35:06 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:4b:cafe::60) by MWHPR02CA0003.outlook.office365.com
 (2603:10b6:300:4b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend
 Transport; Sat, 2 May 2020 21:35:06 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2958.19 via Frontend Transport; Sat, 2 May 2020 21:35:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 2 May 2020
 16:35:04 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 2 May 2020
 16:35:04 -0500
Received: from sudo.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sat, 2 May 2020 16:35:03 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/16] drm/amd/display: remove unused module/stats
Date: Sat, 2 May 2020 17:34:41 -0400
Message-ID: <20200502213443.39232-16-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200502213443.39232-1-aurabindo.pillai@amd.com>
References: <20200502213443.39232-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(46966005)(54906003)(2616005)(186003)(26005)(44832011)(356005)(86362001)(5660300002)(47076004)(81166007)(82310400002)(478600001)(82740400003)(4326008)(70206006)(70586007)(316002)(6916009)(30864003)(426003)(6666004)(2906002)(336012)(36756003)(7696005)(1076003)(8676002)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c259e2c-f401-4c61-749f-08d7eee0ae20
X-MS-TrafficTypeDiagnostic: CH2PR12MB3782:
X-Microsoft-Antispam-PRVS: <CH2PR12MB378212DAF9128FAACFBA4AEB8BA80@CH2PR12MB3782.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 039178EF4A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bpGs7Ya0IFjcAsG7VmBad6tC3EHW/cVkHcWEm7S3prbthwhIzM7vbdqPwXYQJ65DuwKATg8YERelgMVRJ59+kdpLzz0h6MOwH413AzSOjTlkiFjbPSEPIYf1O7C9yTzCwbfj7TEijsEJnLFCEHYHBYDqrfweyKShqxofa/mReOcz/DNyRlYYwOfoxi8+RXtDRNESvjHd6uVPJLvfiDZ1F3OCCmrEaiYtyCMhsba74S7E35FXlWpN7ZdIH83yTvzkWr4XjMCOPQMz+t9hE/XmUivbfenAGK5YtioJns91izxhjGIO7+CMvx8p1WoM1r9+9wNXObcXXlNEWxhdyXLvCbgIT4ZNH39rwOVRQyeJAzdsC9Ocnry/6t+GvsfhzfjWTFe5Ozl/Tq3TBvPM2HHhQEfqO+6muIXn0Bg1X+MjXpeBcEMEopxj77S+H2PxFC6QWt7Oc5c2KtZF7x6nnYAdFntSq8ANLRpz3O1geIIk7B0iv/w5TC782sEFebdAGOdT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2020 21:35:05.5933 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c259e2c-f401-4c61-749f-08d7eee0ae20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3782
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Rodrigo.Siqueira@amd.com,
 Harry.Wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/modules/stats/stats.c | 448 ------------------
 1 file changed, 448 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/modules/stats/stats.c

diff --git a/drivers/gpu/drm/amd/display/modules/stats/stats.c b/drivers/gpu/drm/amd/display/modules/stats/stats.c
deleted file mode 100644
index 03121ca64fe4..000000000000
--- a/drivers/gpu/drm/amd/display/modules/stats/stats.c
+++ /dev/null
@@ -1,448 +0,0 @@
-/*
- * Copyright 2016 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- * Authors: AMD
- *
- */
-
-#include "mod_stats.h"
-#include "dm_services.h"
-#include "dc.h"
-#include "core_types.h"
-
-#define DAL_STATS_ENABLE_REGKEY			"DalStatsEnable"
-#define DAL_STATS_ENABLE_REGKEY_DEFAULT		0x00000000
-#define DAL_STATS_ENABLE_REGKEY_ENABLED		0x00000001
-
-#define DAL_STATS_ENTRIES_REGKEY		"DalStatsEntries"
-#define DAL_STATS_ENTRIES_REGKEY_DEFAULT	0x00350000
-#define DAL_STATS_ENTRIES_REGKEY_MAX		0x01000000
-
-#define DAL_STATS_EVENT_ENTRIES_DEFAULT		0x00000100
-
-#define MOD_STATS_NUM_VSYNCS			5
-#define MOD_STATS_EVENT_STRING_MAX		512
-
-struct stats_time_cache {
-	unsigned int entry_id;
-
-	unsigned long flip_timestamp_in_ns;
-	unsigned long vupdate_timestamp_in_ns;
-
-	unsigned int render_time_in_us;
-	unsigned int avg_render_time_in_us_last_ten;
-	unsigned int v_sync_time_in_us[MOD_STATS_NUM_VSYNCS];
-	unsigned int num_vsync_between_flips;
-
-	unsigned int flip_to_vsync_time_in_us;
-	unsigned int vsync_to_flip_time_in_us;
-
-	unsigned int min_window;
-	unsigned int max_window;
-	unsigned int v_total_min;
-	unsigned int v_total_max;
-	unsigned int event_triggers;
-
-	unsigned int lfc_mid_point_in_us;
-	unsigned int num_frames_inserted;
-	unsigned int inserted_duration_in_us;
-
-	unsigned int flags;
-};
-
-struct stats_event_cache {
-	unsigned int entry_id;
-	char event_string[MOD_STATS_EVENT_STRING_MAX];
-};
-
-struct core_stats {
-	struct mod_stats public;
-	struct dc *dc;
-
-	bool enabled;
-	unsigned int entries;
-	unsigned int event_entries;
-	unsigned int entry_id;
-
-	struct stats_time_cache *time;
-	unsigned int index;
-
-	struct stats_event_cache *events;
-	unsigned int event_index;
-
-};
-
-#define MOD_STATS_TO_CORE(mod_stats)\
-		container_of(mod_stats, struct core_stats, public)
-
-bool mod_stats_init(struct mod_stats *mod_stats)
-{
-	bool result = false;
-	struct core_stats *core_stats = NULL;
-	struct dc *dc = NULL;
-
-	if (mod_stats == NULL)
-		return false;
-
-	core_stats = MOD_STATS_TO_CORE(mod_stats);
-	dc = core_stats->dc;
-
-	return result;
-}
-
-struct mod_stats *mod_stats_create(struct dc *dc)
-{
-	struct core_stats *core_stats = NULL;
-	struct persistent_data_flag flag;
-	unsigned int reg_data;
-	int i = 0;
-
-	if (dc == NULL)
-		goto fail_construct;
-
-	core_stats = kzalloc(sizeof(struct core_stats), GFP_KERNEL);
-
-	if (core_stats == NULL)
-		goto fail_construct;
-
-	core_stats->dc = dc;
-
-	core_stats->enabled = DAL_STATS_ENABLE_REGKEY_DEFAULT;
-	if (dm_read_persistent_data(dc->ctx, NULL, NULL,
-			DAL_STATS_ENABLE_REGKEY,
-			&reg_data, sizeof(unsigned int), &flag))
-		core_stats->enabled = reg_data;
-
-	if (core_stats->enabled) {
-		core_stats->entries = DAL_STATS_ENTRIES_REGKEY_DEFAULT;
-		if (dm_read_persistent_data(dc->ctx, NULL, NULL,
-				DAL_STATS_ENTRIES_REGKEY,
-				&reg_data, sizeof(unsigned int), &flag)) {
-			if (reg_data > DAL_STATS_ENTRIES_REGKEY_MAX)
-				core_stats->entries = DAL_STATS_ENTRIES_REGKEY_MAX;
-			else
-				core_stats->entries = reg_data;
-		}
-		core_stats->time = kcalloc(core_stats->entries,
-						sizeof(struct stats_time_cache),
-						GFP_KERNEL);
-
-		if (core_stats->time == NULL)
-			goto fail_construct_time;
-
-		core_stats->event_entries = DAL_STATS_EVENT_ENTRIES_DEFAULT;
-		core_stats->events = kcalloc(core_stats->event_entries,
-					     sizeof(struct stats_event_cache),
-					     GFP_KERNEL);
-
-		if (core_stats->events == NULL)
-			goto fail_construct_events;
-
-	} else {
-		core_stats->entries = 0;
-	}
-
-	/* Purposely leave index 0 unused so we don't need special logic to
-	 * handle calculation cases that depend on previous flip data.
-	 */
-	core_stats->index = 1;
-	core_stats->event_index = 0;
-
-	// Keeps track of ordering within the different stats structures
-	core_stats->entry_id = 0;
-
-	return &core_stats->public;
-
-fail_construct_events:
-	kfree(core_stats->time);
-
-fail_construct_time:
-	kfree(core_stats);
-
-fail_construct:
-	return NULL;
-}
-
-void mod_stats_destroy(struct mod_stats *mod_stats)
-{
-	if (mod_stats != NULL) {
-		struct core_stats *core_stats = MOD_STATS_TO_CORE(mod_stats);
-
-		kfree(core_stats->time);
-		kfree(core_stats->events);
-		kfree(core_stats);
-	}
-}
-
-void mod_stats_dump(struct mod_stats *mod_stats)
-{
-	struct dc  *dc = NULL;
-	struct dal_logger *logger = NULL;
-	struct core_stats *core_stats = NULL;
-	struct stats_time_cache *time = NULL;
-	struct stats_event_cache *events = NULL;
-	unsigned int time_index = 1;
-	unsigned int event_index = 0;
-	unsigned int index = 0;
-	struct log_entry log_entry;
-
-	if (mod_stats == NULL)
-		return;
-
-	core_stats = MOD_STATS_TO_CORE(mod_stats);
-	dc = core_stats->dc;
-	logger = dc->ctx->logger;
-	time = core_stats->time;
-	events = core_stats->events;
-
-	DISPLAY_STATS_BEGIN(log_entry);
-
-	DISPLAY_STATS("==Display Caps==\n");
-
-	DISPLAY_STATS("==Display Stats==\n");
-
-	DISPLAY_STATS("%10s %10s %10s %10s %10s"
-			" %11s %11s %17s %10s %14s"
-			" %10s %10s %10s %10s %10s"
-			" %10s %10s %10s %10s\n",
-		"render", "avgRender",
-		"minWindow", "midPoint", "maxWindow",
-		"vsyncToFlip", "flipToVsync", "vsyncsBetweenFlip",
-		"numFrame", "insertDuration",
-		"vTotalMin", "vTotalMax", "eventTrigs",
-		"vSyncTime1", "vSyncTime2", "vSyncTime3",
-		"vSyncTime4", "vSyncTime5", "flags");
-
-	for (int i = 0; i < core_stats->entry_id; i++) {
-		if (event_index < core_stats->event_index &&
-				i == events[event_index].entry_id) {
-			DISPLAY_STATS("==Event==%s\n", events[event_index].event_string);
-			event_index++;
-		} else if (time_index < core_stats->index &&
-				i == time[time_index].entry_id) {
-			DISPLAY_STATS("%10u %10u %10u %10u %10u"
-					" %11u %11u %17u %10u %14u"
-					" %10u %10u %10u %10u %10u"
-					" %10u %10u %10u %10u\n",
-				time[time_index].render_time_in_us,
-				time[time_index].avg_render_time_in_us_last_ten,
-				time[time_index].min_window,
-				time[time_index].lfc_mid_point_in_us,
-				time[time_index].max_window,
-				time[time_index].vsync_to_flip_time_in_us,
-				time[time_index].flip_to_vsync_time_in_us,
-				time[time_index].num_vsync_between_flips,
-				time[time_index].num_frames_inserted,
-				time[time_index].inserted_duration_in_us,
-				time[time_index].v_total_min,
-				time[time_index].v_total_max,
-				time[time_index].event_triggers,
-				time[time_index].v_sync_time_in_us[0],
-				time[time_index].v_sync_time_in_us[1],
-				time[time_index].v_sync_time_in_us[2],
-				time[time_index].v_sync_time_in_us[3],
-				time[time_index].v_sync_time_in_us[4],
-				time[time_index].flags);
-
-			time_index++;
-		}
-	}
-
-	DISPLAY_STATS_END(log_entry);
-}
-
-void mod_stats_reset_data(struct mod_stats *mod_stats)
-{
-	struct core_stats *core_stats = NULL;
-	struct stats_time_cache *time = NULL;
-	unsigned int index = 0;
-
-	if (mod_stats == NULL)
-		return;
-
-	core_stats = MOD_STATS_TO_CORE(mod_stats);
-
-	memset(core_stats->time, 0,
-		sizeof(struct stats_time_cache) * core_stats->entries);
-
-	memset(core_stats->events, 0,
-		sizeof(struct stats_event_cache) * core_stats->event_entries);
-
-	core_stats->index = 1;
-	core_stats->event_index = 0;
-
-	// Keeps track of ordering within the different stats structures
-	core_stats->entry_id = 0;
-}
-
-void mod_stats_update_event(struct mod_stats *mod_stats,
-		char *event_string,
-		unsigned int length)
-{
-	struct core_stats *core_stats = NULL;
-	struct stats_event_cache *events = NULL;
-	unsigned int index = 0;
-	unsigned int copy_length = 0;
-
-	if (mod_stats == NULL)
-		return;
-
-	core_stats = MOD_STATS_TO_CORE(mod_stats);
-
-	if (core_stats->event_index >= core_stats->event_entries)
-		return;
-
-	events = core_stats->events;
-	index = core_stats->event_index;
-
-	copy_length = length;
-	if (length > MOD_STATS_EVENT_STRING_MAX)
-		copy_length = MOD_STATS_EVENT_STRING_MAX;
-
-	memcpy(&events[index].event_string, event_string, copy_length);
-	events[index].event_string[copy_length - 1] = '\0';
-
-	events[index].entry_id = core_stats->entry_id;
-	core_stats->event_index++;
-	core_stats->entry_id++;
-}
-
-void mod_stats_update_flip(struct mod_stats *mod_stats,
-		unsigned long timestamp_in_ns)
-{
-	struct core_stats *core_stats = NULL;
-	struct stats_time_cache *time = NULL;
-	unsigned int index = 0;
-
-	if (mod_stats == NULL)
-		return;
-
-	core_stats = MOD_STATS_TO_CORE(mod_stats);
-
-	if (core_stats->index >= core_stats->entries)
-		return;
-
-	time = core_stats->time;
-	index = core_stats->index;
-
-	time[index].flip_timestamp_in_ns = timestamp_in_ns;
-	time[index].render_time_in_us =
-		(timestamp_in_ns - time[index - 1].flip_timestamp_in_ns) / 1000;
-
-	if (index >= 10) {
-		for (unsigned int i = 0; i < 10; i++)
-			time[index].avg_render_time_in_us_last_ten +=
-					time[index - i].render_time_in_us;
-		time[index].avg_render_time_in_us_last_ten /= 10;
-	}
-
-	if (time[index].num_vsync_between_flips > 0)
-		time[index].vsync_to_flip_time_in_us =
-			(timestamp_in_ns -
-				time[index].vupdate_timestamp_in_ns) / 1000;
-	else
-		time[index].vsync_to_flip_time_in_us =
-			(timestamp_in_ns -
-				time[index - 1].vupdate_timestamp_in_ns) / 1000;
-
-	time[index].entry_id = core_stats->entry_id;
-	core_stats->index++;
-	core_stats->entry_id++;
-}
-
-void mod_stats_update_vupdate(struct mod_stats *mod_stats,
-		unsigned long timestamp_in_ns)
-{
-	struct core_stats *core_stats = NULL;
-	struct stats_time_cache *time = NULL;
-	unsigned int index = 0;
-	unsigned int num_vsyncs = 0;
-	unsigned int prev_vsync_in_ns = 0;
-
-	if (mod_stats == NULL)
-		return;
-
-	core_stats = MOD_STATS_TO_CORE(mod_stats);
-
-	if (core_stats->index >= core_stats->entries)
-		return;
-
-	time = core_stats->time;
-	index = core_stats->index;
-	num_vsyncs = time[index].num_vsync_between_flips;
-
-	if (num_vsyncs < MOD_STATS_NUM_VSYNCS) {
-		if (num_vsyncs == 0) {
-			prev_vsync_in_ns =
-				time[index - 1].vupdate_timestamp_in_ns;
-
-			time[index].flip_to_vsync_time_in_us =
-				(timestamp_in_ns -
-					time[index - 1].flip_timestamp_in_ns) /
-					1000;
-		} else {
-			prev_vsync_in_ns =
-				time[index].vupdate_timestamp_in_ns;
-		}
-
-		time[index].v_sync_time_in_us[num_vsyncs] =
-			(timestamp_in_ns - prev_vsync_in_ns) / 1000;
-	}
-
-	time[index].vupdate_timestamp_in_ns = timestamp_in_ns;
-	time[index].num_vsync_between_flips++;
-}
-
-void mod_stats_update_freesync(struct mod_stats *mod_stats,
-		unsigned int v_total_min,
-		unsigned int v_total_max,
-		unsigned int event_triggers,
-		unsigned int window_min,
-		unsigned int window_max,
-		unsigned int lfc_mid_point_in_us,
-		unsigned int inserted_frames,
-		unsigned int inserted_duration_in_us)
-{
-	struct core_stats *core_stats = NULL;
-	struct stats_time_cache *time = NULL;
-	unsigned int index = 0;
-
-	if (mod_stats == NULL)
-		return;
-
-	core_stats = MOD_STATS_TO_CORE(mod_stats);
-
-	if (core_stats->index >= core_stats->entries)
-		return;
-
-	time = core_stats->time;
-	index = core_stats->index;
-
-	time[index].v_total_min = v_total_min;
-	time[index].v_total_max = v_total_max;
-	time[index].event_triggers = event_triggers;
-	time[index].min_window = window_min;
-	time[index].max_window = window_max;
-	time[index].lfc_mid_point_in_us = lfc_mid_point_in_us;
-	time[index].num_frames_inserted = inserted_frames;
-	time[index].inserted_duration_in_us = inserted_duration_in_us;
-}
-
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
