Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441E0C3DA63
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 19:40:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95F5710E3AF;
	Wed, 17 Jul 2024 19:40:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pAL2r43x";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E40F110E3AE
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 19:40:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RCSQGhpkVc3Ywhfzj3h6gaTD2m2LHnBBc2FZ724BpkbKQrIAgMbVUkjXf6BE3z+dAJ3I7N+FS4dMeQrfrMdbjyPVvZ9wRrI/yHG5dUOB+7t0Ay06an/+Y+KYlOeKfZKcm7gq1qApPv2DaWdxNgMxpgGwmD+HiKVZzHcroCo1sI+4w/vzRkt5/0NhK51sskHEfKHRzSnp3T9F6XZlzRz51ACRSWXFRal3xxldWZp7U2Ik+QIl8KF3/dXr6pwdcoOcy1DgfTOUqbwswkFFzY4MEDvhRWw2Ci8P+xyFK4U7xDCeR4D+0A04SCHj+ZA0Cg2Tdbf/h9ozRgvJ/b65dJ500Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17r35P/LLTgsc2fyokq3wPSaID0Eape2l0KUSPXCjJ0=;
 b=FgialMG+bh+wtDq2C6FPhUVIWdrndK+4e1vSBGdc6xEgPkZi3EHDI3SCsZtg8CZ7lqb4QSC6zHc0KU1GWRlWBrbMDjY5WLYOtJ3NWfVgerHU26QCJW+alQjOENP0L/kjRA3iXv1OlpJt3usAqF4UbtkhvhhW/zcMBPhyu1amLzVwktP7hVpfUojA5cgSeKsiT870rqDPaoFASQOD1LQn1a1DRQuL75yVgkXYonckTdlM9QM9ulNxkcMqHh/fpwiVyquqqzcMo3V173ElsvxR23a14H0rXFJa9k64BuljY46G4E/YKo3DC57LoUwsfUgLKtm5IhV0LFtjjI8OkO/27g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17r35P/LLTgsc2fyokq3wPSaID0Eape2l0KUSPXCjJ0=;
 b=pAL2r43x3LZq8BYXV7+GR+IB8VbTSu8FS7Eq5O2mw2EDAEZdsiMktuVMPpZojiHI2lE9fLbiVlWvNZow0ZQSwh4ZfkO1sL8mifxeGN8OCqCwNStd11HZ2BVbU8oLdE/YQiKl9kPHaHaS8Hm3PL72aNYUEs6DVHXcOpLd3jwo76E=
Received: from CH2PR17CA0003.namprd17.prod.outlook.com (2603:10b6:610:53::13)
 by SN7PR12MB7024.namprd12.prod.outlook.com (2603:10b6:806:26e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.15; Wed, 17 Jul
 2024 19:40:40 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::d0) by CH2PR17CA0003.outlook.office365.com
 (2603:10b6:610:53::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Wed, 17 Jul 2024 19:40:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 19:40:39 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 14:40:38 -0500
Received: from debian.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 17 Jul 2024 14:40:32 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Ilya Bakoulin
 <ilya.bakoulin@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
Subject: [PATCH 13/22] drm/amd/display: Add helper function to check for
 non-address fast updates
Date: Wed, 17 Jul 2024 19:38:52 +0000
Message-ID: <20240717193901.8821-14-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240717193901.8821-1-aurabindo.pillai@amd.com>
References: <20240717193901.8821-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|SN7PR12MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: 206c27d7-109a-441a-c7c3-08dca69856bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1aCnxd/1KqGp+L+R9AT/YpR9c7rWaKm366lO4tZPtCeNMLfGsOzZptvwuwQ4?=
 =?us-ascii?Q?MhFQJfy6xTs6WyEaokOgigMWfR8VqtP5bIwbCJ6TQWc5d6FEVNS9rV/F+afX?=
 =?us-ascii?Q?GrYPqwy9pJezoEQLPG3/QEAIFWcDIcqx58KXJWKLzsPfzAiaeAVzdnc4NKN5?=
 =?us-ascii?Q?WrVFtDpjV9sdA+uIXdfLJakDDpwgxZuApGeU5BITi++a5uz+dsXCQMizj17c?=
 =?us-ascii?Q?wkf6JkBPdWtIU4ScJVxUHywuuhC7FBZqtdyCUJJUxmB3abdaXllXMZhJowhq?=
 =?us-ascii?Q?tw72tRJF8URB9OcRRlqkopk9DAVZyhN7xVYHirNJ50E0kqjRVL3XlKyk9gTh?=
 =?us-ascii?Q?DyZY+EoodZcvGG6Mwf+IFw5R//v4bCShs5lQxZcLqwFU6nDzlmBwZ7tGiVaK?=
 =?us-ascii?Q?GtZ62w8QdxTryFb26WKfuiuyHymkSVPZhcy9GM7vrzl+FLztI9dyXvkoFiDJ?=
 =?us-ascii?Q?R8zFIBP3jmdJ4I3HRmqq1VmSrrXsE81WBK3SZ/edh/U9PjTcax0HnBH+2JHx?=
 =?us-ascii?Q?NXtUV7uIaS+9twRXmJxA+MY5oEdS5VsNSvr9IV/m843KFgZj2rvi2syMWgzO?=
 =?us-ascii?Q?rxMvk9zEd71ou+unY7IuXzvA5EjgU5zLQpM+TAvXRD0vQ9So2247N32RHsTL?=
 =?us-ascii?Q?jaI1XiBmPT35ktPBZ6a5+MKAFJ6EdQ0C/uhlh3kboBsW9WG8NX2LyQ5sUIi+?=
 =?us-ascii?Q?NLtB19Ig3l4/ogxBhObLH+IFYjJB1ITie5Jsic3g0NqFln8NdTOKAM8Ly006?=
 =?us-ascii?Q?OGGDeRIJMdqXqHupgJNbSmHwD2ocMbIWbPG7gGOch4a5bKAarDfSzt/tBQjc?=
 =?us-ascii?Q?oM5S3h2LEG08CAJKmz6zsUGF9OruxHAT+jqmqwWEZPt9j38nbCKvxptKbYlI?=
 =?us-ascii?Q?NsZ+Lye0zsxL94RoboMov63p6X4guuhR15PxLyfy+NSG0dQW6hMUQC12imSN?=
 =?us-ascii?Q?fStKIqpFUO1QGmqTk9hhLYc4qW10MUA/Ak21vNhTiJ+87tpeEzaOmXGmtSP5?=
 =?us-ascii?Q?MaQX6iNdtE4ZQp6cOoNnnZWoTemft2/s+oumMPEkER/X6yaFAQlXkQkCg9m8?=
 =?us-ascii?Q?CiWkbg23CQpfzh+UUn7l/I1T3iEOwgzGfAVokgRwN9brnOrHjKIxBk9hqQiO?=
 =?us-ascii?Q?pI4CbtoLw9kxAg7msNqeMC+P7LaSlrMH1WSkUODVxIH9Mx+OT6upuGBiW1Xz?=
 =?us-ascii?Q?UkUZU4PcQF11ZBkVn6XmGvb8wSp6G53A0c7wXdVpe4cIBId0wJdXRZk7XPY0?=
 =?us-ascii?Q?eGxTqJNjs50KdXNt9DOMt2U6PfAzqKyp8BPufhdYsCg3cA9YjI2rSroUfQxP?=
 =?us-ascii?Q?l5Op3DLMabpkyL7PR4O/61yEzGGR8Z5zb6NPmn6dRvzvvmj3lOmB0Nj6ha5S?=
 =?us-ascii?Q?XnSbxgDOzzEIwMEk3sV9/Se9sdG9cWAMbUAgxiLphnf9vmZdJNcJDuVEmTMY?=
 =?us-ascii?Q?59cjvOA2+RHH4HPUgu/UvFk74m9ByQ4z?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 19:40:39.9348 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 206c27d7-109a-441a-c7c3-08dca69856bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7024
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

From: Ilya Bakoulin <ilya.bakoulin@amd.com>

[Why/How]
Need to identify which fast updates will update more than just the
address.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Ilya Bakoulin <ilya.bakoulin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 25 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dc.h      |  6 ++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index b71c4d8e73dd..b8a6c062426d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4697,7 +4697,7 @@ static bool commit_minimal_transition_state(struct dc *dc,
 	return true;
 }
 
-static void populate_fast_updates(struct dc_fast_update *fast_update,
+void populate_fast_updates(struct dc_fast_update *fast_update,
 		struct dc_surface_update *srf_updates,
 		int surface_count,
 		struct dc_stream_update *stream_update)
@@ -4707,6 +4707,9 @@ static void populate_fast_updates(struct dc_fast_update *fast_update,
 	if (stream_update) {
 		fast_update[0].out_transfer_func = stream_update->out_transfer_func;
 		fast_update[0].output_csc_transform = stream_update->output_csc_transform;
+	} else {
+		fast_update[0].out_transfer_func = NULL;
+		fast_update[0].output_csc_transform = NULL;
 	}
 
 	for (i = 0; i < surface_count; i++) {
@@ -4740,6 +4743,26 @@ static bool fast_updates_exist(struct dc_fast_update *fast_update, int surface_c
 	return false;
 }
 
+bool fast_nonaddr_updates_exist(struct dc_fast_update *fast_update, int surface_count)
+{
+	int i;
+
+	if (fast_update[0].out_transfer_func ||
+		fast_update[0].output_csc_transform)
+		return true;
+
+	for (i = 0; i < surface_count; i++) {
+		if (fast_update[i].input_csc_color_matrix ||
+				fast_update[i].gamma ||
+				fast_update[i].gamut_remap_matrix ||
+				fast_update[i].coeff_reduction_factor ||
+				fast_update[i].cursor_csc_color_matrix)
+			return true;
+	}
+
+	return false;
+}
+
 static bool full_update_required(struct dc *dc,
 		struct dc_surface_update *srf_updates,
 		int surface_count,
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 036b23a6e324..272ae1bdc57f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1587,6 +1587,12 @@ bool dc_acquire_release_mpc_3dlut(
 bool dc_resource_is_dsc_encoding_supported(const struct dc *dc);
 void get_audio_check(struct audio_info *aud_modes,
 	struct audio_check *aud_chk);
+
+bool fast_nonaddr_updates_exist(struct dc_fast_update *fast_update, int surface_count);
+void populate_fast_updates(struct dc_fast_update *fast_update,
+		struct dc_surface_update *srf_updates,
+		int surface_count,
+		struct dc_stream_update *stream_update);
 /*
  * Set up streams and links associated to drive sinks
  * The streams parameter is an absolute set of all active streams.
-- 
2.39.2

