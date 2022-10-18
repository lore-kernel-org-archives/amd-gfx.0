Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E98FC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Oct 2022 12:28:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C95410EF26;
	Tue, 18 Oct 2022 12:28:37 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53BDB10EF2C
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Oct 2022 12:28:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QbnOTGO2J118ngJioGeH1ksgrlPRVObRpLFUEjYb4mz7R8HDpxjHb/ZFXebif5EYQ5NScCmoAdgwAO3Ws0RRqS2cGNrU8CPB+Jgbq8fZo92xD86gtz3Eud3WOOcVld+1jj5mwERGmtrbwtjEuZn/9bQhr4Mk8ZoErx0CYOdhjATQtVa0th7eO/f0/AwSTlHNh/4CfP4eI+pM0wCNESRDH1LFpzfLzR3uMdWk8MakefWjOAeyib+F09Hrd32vxM06neyUtGQqgwV9f0EznzqDpG8mdjY+uUX2zXcdacXy0TjNqAtdlTxVo9YogHtWp0246UBDA7vCdhXDGXO8X4oZng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+ZYamynkmR2IjcFtj74Am9IHgFa6tm4+rQqFAyzkJ8=;
 b=NvuCuTusxFWjTmpQSpqMLvizduThKzri07CStGDL45h61pRgRxwyEXA0RQfehMHSsoq9UKdo2kMMd7wWQ3BoPximAZaSI+0wBd4TPYdYgJcJ7SidG8lFSdfhjYE658dWB2YuT3akum5SQ0ba4O7gxnYF+bUHG7js4Op0cImagkgITeDnSISvRuJiEbE9O5QPu7OemkAyH+0vT6H4CD+pWAtsDM++UbYsu/pkN8bIOUqDZr+LaXJzXlaVyk8JaI6+pL6nGbvZZmpj4MhFMnmNaCpfQtKV9pm9YpPlEv52Vfg1EefujPuzlBQjSvT7/UDVvCZjR6ki6yzG8Ly5FVR/Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+ZYamynkmR2IjcFtj74Am9IHgFa6tm4+rQqFAyzkJ8=;
 b=gy4uMl8CJrsiZelmXuLLDZaEl5nRq28fiWvXx1Pt7GntpcRdhBHXPQSXS025dGteehkvhOy9z0VPXT8LDWeXHa0XNdrCXP4zaO52y4Rj8NSbHPvMOcoCAprUI1dhwJOThuBHLYown5mBFfDwSymgBQ5xd5uylzMSoAva+O6J4ng=
Received: from MW4PR04CA0096.namprd04.prod.outlook.com (2603:10b6:303:83::11)
 by LV2PR12MB5896.namprd12.prod.outlook.com (2603:10b6:408:172::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Tue, 18 Oct
 2022 12:28:28 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::c5) by MW4PR04CA0096.outlook.office365.com
 (2603:10b6:303:83::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34 via Frontend
 Transport; Tue, 18 Oct 2022 12:28:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 12:28:27 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 07:28:25 -0500
Received: from arch-sec.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via
 Frontend Transport; Tue, 18 Oct 2022 07:28:20 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 07/12] drm/amd/display: Add function for validate and
 update new stream
Date: Tue, 18 Oct 2022 08:28:21 -0400
Message-ID: <20221018122826.1790114-8-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221018122826.1790114-1-Rodrigo.Siqueira@amd.com>
References: <20221018122826.1790114-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT036:EE_|LV2PR12MB5896:EE_
X-MS-Office365-Filtering-Correlation-Id: 86834740-a9f8-46c8-77bf-08dab1044254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c8NxMLygc0bajSZ8jEAAfZVoH7JUds+ML+KXc6B+ay5OOFG48sji0Emjja0vGA4OfYqiHKqabg9A2XRACnOH+vDP/TT+WHNc4m6NKDWtssTx0HJlM4ue0OBveZ9ox/3zoYdeE1Ikeklzh5MUSIidalLddtrrhX7iF3BOiSbjB6P7wEWOnP2psc3q3VwjT/M3ihIK6z/AIXap+ALcrg2p5GQ0GPG91OQnV+Ib+S4UBMZjamLrmpCH6YOD65mSCnOHkpMvzWXeFiYL7KM4SvTWL6sWLi/Uaj7nIUiW2dy5uRp8Gpi9LyXyHRSVIRTU6tUOKf8zFlzLAYkICRaQtjF4yU9DqAqoC1lmXk3ayDE6bK1Ij2sgXv0ye3EC+qU+7oXiApzHDW9WOXVR3unvelcygBpWFMxHPFnxpAGBT72R1VTmdaK7B05V+xiWNKUZVpJhCxJ6dSLFDVP8GSCR+Q1wuXKaRuuXyGQPmbWOhgvaRVuEaYt2wkX2DDd61t6IqDF/Eq9IPWTvmOhVTdSeDpk47QH6qTynZveNCf+15oMULmADv1YM+ObK8Weg1xH9VugOIF7ClC658vzrxylSRJg03nJqmhUisrhCIjnoPc6a2PsYvhoE3vh87gaeXFJzAfPydz+UtwV9pvetGuGHL3R7h+UfY7Mi0cGpZ2+l7attGziYevm688uaNwoJTubb442b1P54OenVNB9L+CP4uuYjMQR5HFVkgdeR7Pv4sXVvKDr8NDnrhYq/SuPBEJjtZsxUUfHZ/PFa9Vw7OIusCF3JAt6quIaOtIvaTuid8hQZgQDtWgjaZNTHgk9q8JDfjeb4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(70586007)(47076005)(426003)(5660300002)(6916009)(54906003)(40460700003)(8936002)(40480700001)(81166007)(1076003)(356005)(186003)(2616005)(2906002)(41300700001)(86362001)(26005)(82310400005)(36756003)(336012)(82740400003)(15650500001)(478600001)(4326008)(83380400001)(8676002)(70206006)(316002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 12:28:27.4664 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86834740-a9f8-46c8-77bf-08dab1044254
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5896
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
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DC stream can be seen as a representation of the DCN backend or the data
struct that represents the center of the display pipeline. The front end
(i.e., planes) is connected to the DC stream, and in its turn, streams
are connected to the DC link. Due to this dynamic, DC must handle the
following scenarios:

1. A stream is removed;
2. A new stream is created;
3. An unchanged stream had some updates on its planes.

These combinations require that the new stream data struct become
updated and has a valid global state. For handling multiple corner cases
associated with stream operations, this commit introduces a function
dedicated to manipulating stream changes and invokes the state
validation function after that.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Co-developed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  16 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 219 +++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dc.h           |   6 +
 3 files changed, 227 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 61b574b9e736..d568387c4bda 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1941,21 +1941,17 @@ enum dc_status dc_commit_streams(struct dc *dc,
 
 	dc_resource_state_copy_construct_current(dc, context);
 
-	/*
-	 * Previous validation was perfomred with fast_validation = true and
-	 * the full DML state required for hardware programming was skipped.
-	 *
-	 * Re-validate here to calculate these parameters / watermarks.
-	 */
-	res = dc_validate_global_state(dc, context, false);
+	res = dc_validate_with_context(dc, set, stream_count, context, false);
 	if (res != DC_OK) {
-		DC_LOG_ERROR("DC commit global validation failure: %s (%d)",
-			     dc_status_to_str(res), res);
-		return res;
+		BREAK_TO_DEBUGGER();
+		goto fail;
 	}
 
 	res = dc_commit_state_no_check(dc, context);
 
+fail:
+	dc_release_state(context);
+
 context_alloc_fail:
 
 	DC_LOG_DC("%s Finished.\n", __func__);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index fd8db482e56f..e001b138b2ac 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2593,15 +2593,226 @@ bool dc_resource_is_dsc_encoding_supported(const struct dc *dc)
 	return dc->res_pool->res_cap->num_dsc > 0;
 }
 
+static bool planes_changed_for_existing_stream(struct dc_state *context,
+					       struct dc_stream_state *stream,
+					       const struct dc_validation_set set[],
+					       int set_count)
+{
+	int i, j;
+	struct dc_stream_status *stream_status = NULL;
+
+	for (i = 0; i < context->stream_count; i++) {
+		if (context->streams[i] == stream) {
+			stream_status = &context->stream_status[i];
+			break;
+		}
+	}
+
+	if (!stream_status)
+		ASSERT(0);
+
+	for (i = 0; i < set_count; i++)
+		if (set[i].stream == stream)
+			break;
+
+	if (i == set_count)
+		ASSERT(0);
+
+	if (set[i].plane_count != stream_status->plane_count)
+		return true;
+
+	for (j = 0; j < set[i].plane_count; j++)
+		if (set[i].plane_states[j] != stream_status->plane_states[j])
+			return true;
+
+	return false;
+}
+
+/**
+ * dc_validate_with_context - Validate and update the potential new stream in the context object
+ *
+ * @dc: Used to get the current state status
+ * @set: An array of dc_validation_set with all the current streams reference
+ * @set_count: Total of streams
+ * @context: New context
+ * @fast_validate: Enable or disable fast validation
+ *
+ * This function updates the potential new stream in the context object. It
+ * creates multiple lists for the add, remove, and unchanged streams. In
+ * particular, if the unchanged streams have a plane that changed, it is
+ * necessary to remove all planes from the unchanged streams. In summary, this
+ * function is responsible for validating the new context.
+ *
+ * Return:
+ * In case of success, return DC_OK (1), otherwise, return a DC error.
+ */
+enum dc_status dc_validate_with_context(struct dc *dc,
+					const struct dc_validation_set set[],
+					int set_count,
+					struct dc_state *context,
+					bool fast_validate)
+{
+	struct dc_stream_state *unchanged_streams[MAX_PIPES] = { 0 };
+	struct dc_stream_state *del_streams[MAX_PIPES] = { 0 };
+	struct dc_stream_state *add_streams[MAX_PIPES] = { 0 };
+	int old_stream_count = context->stream_count;
+	enum dc_status res = DC_ERROR_UNEXPECTED;
+	int unchanged_streams_count = 0;
+	int del_streams_count = 0;
+	int add_streams_count = 0;
+	bool found = false;
+	int i, j, k;
+
+	DC_LOGGER_INIT(dc->ctx->logger);
+
+	/* First build a list of streams to be remove from current context */
+	for (i = 0; i < old_stream_count; i++) {
+		struct dc_stream_state *stream = context->streams[i];
+
+		for (j = 0; j < set_count; j++) {
+			if (stream == set[j].stream) {
+				found = true;
+				break;
+			}
+		}
+
+		if (!found)
+			del_streams[del_streams_count++] = stream;
+
+		found = false;
+	}
+
+	/* Second, build a list of new streams */
+	for (i = 0; i < set_count; i++) {
+		struct dc_stream_state *stream = set[i].stream;
+
+		for (j = 0; j < old_stream_count; j++) {
+			if (stream == context->streams[j]) {
+				found = true;
+				break;
+			}
+		}
+
+		if (!found)
+			add_streams[add_streams_count++] = stream;
+
+		found = false;
+	}
+
+	/* Build a list of unchanged streams which is necessary for handling
+	 * planes change such as added, removed, and updated.
+	 */
+	for (i = 0; i < set_count; i++) {
+		/* Check if stream is part of the delete list */
+		for (j = 0; j < del_streams_count; j++) {
+			if (set[i].stream == del_streams[j]) {
+				found = true;
+				break;
+			}
+		}
+
+		if (!found) {
+			/* Check if stream is part of the add list */
+			for (j = 0; j < add_streams_count; j++) {
+				if (set[i].stream == add_streams[j]) {
+					found = true;
+					break;
+				}
+			}
+		}
+
+		if (!found)
+			unchanged_streams[unchanged_streams_count++] = set[i].stream;
+
+		found = false;
+	}
+
+	/* Remove all planes for unchanged streams if planes changed */
+	for (i = 0; i < unchanged_streams_count; i++) {
+		if (planes_changed_for_existing_stream(context,
+						       unchanged_streams[i],
+						       set,
+						       set_count)) {
+			if (!dc_rem_all_planes_for_stream(dc,
+							  unchanged_streams[i],
+							  context)) {
+				res = DC_FAIL_DETACH_SURFACES;
+				goto fail;
+			}
+		}
+	}
+
+	/* Remove all planes for removed streams and then remove the streams */
+	for (i = 0; i < del_streams_count; i++) {
+		/* Need to cpy the dwb data from the old stream in order to efc to work */
+		if (del_streams[i]->num_wb_info > 0) {
+			for (j = 0; j < add_streams_count; j++) {
+				if (del_streams[i]->sink == add_streams[j]->sink) {
+					add_streams[j]->num_wb_info = del_streams[i]->num_wb_info;
+					for (k = 0; k < del_streams[i]->num_wb_info; k++)
+						add_streams[j]->writeback_info[k] = del_streams[i]->writeback_info[k];
+				}
+			}
+		}
+
+		if (!dc_rem_all_planes_for_stream(dc, del_streams[i], context)) {
+			res = DC_FAIL_DETACH_SURFACES;
+			goto fail;
+		}
+
+		res = dc_remove_stream_from_ctx(dc, context, del_streams[i]);
+		if (res != DC_OK)
+			goto fail;
+	}
+
+	/* Add new streams and then add all planes for the new stream */
+	for (i = 0; i < add_streams_count; i++) {
+		calculate_phy_pix_clks(add_streams[i]);
+		res = dc_add_stream_to_ctx(dc, context, add_streams[i]);
+		if (res != DC_OK)
+			goto fail;
+
+		if (!add_all_planes_for_stream(dc, add_streams[i], set, set_count, context)) {
+			res = DC_FAIL_ATTACH_SURFACES;
+			goto fail;
+		}
+	}
+
+	/* Add all planes for unchanged streams if planes changed */
+	for (i = 0; i < unchanged_streams_count; i++) {
+		if (planes_changed_for_existing_stream(context,
+						       unchanged_streams[i],
+						       set,
+						       set_count)) {
+			if (!add_all_planes_for_stream(dc, unchanged_streams[i], set, set_count, context)) {
+				res = DC_FAIL_ATTACH_SURFACES;
+				goto fail;
+			}
+		}
+	}
+
+	res = dc_validate_global_state(dc, context, fast_validate);
+
+fail:
+	if (res != DC_OK)
+		DC_LOG_WARNING("%s:resource validation failed, dc_status:%d\n",
+			       __func__,
+			       res);
+
+	return res;
+}
 
 /**
- * dc_validate_global_state() - Determine if HW can support a given state
- * Checks HW resource availability and bandwidth requirement.
+ * dc_validate_global_state() - Determine if hardware can support a given state
+ *
  * @dc: dc struct for this driver
  * @new_ctx: state to be validated
  * @fast_validate: set to true if only yes/no to support matters
  *
- * Return: DC_OK if the result can be programmed.  Otherwise, an error code.
+ * Checks hardware resource availability and bandwidth requirement.
+ *
+ * Return:
+ * DC_OK if the result can be programmed. Otherwise, an error code.
  */
 enum dc_status dc_validate_global_state(
 		struct dc *dc,
@@ -3734,4 +3945,4 @@ bool dc_resource_acquire_secondary_pipe_for_mpc_odm(
 	}
 
 	return true;
-}
\ No newline at end of file
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 2555623b07df..54d34017e329 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1297,6 +1297,12 @@ enum dc_status dc_validate_plane(struct dc *dc, const struct dc_plane_state *pla
 
 void get_clock_requirements_for_state(struct dc_state *state, struct AsicStateEx *info);
 
+enum dc_status dc_validate_with_context(struct dc *dc,
+					const struct dc_validation_set set[],
+					int set_count,
+					struct dc_state *context,
+					bool fast_validate);
+
 bool dc_set_generic_gpio_for_stereo(bool enable,
 		struct gpio_service *gpio_service);
 
-- 
2.38.0

