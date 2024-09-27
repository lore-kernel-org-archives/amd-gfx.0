Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D719CDD1CF
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Sep 2024 17:02:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1020210ECFA;
	Fri, 27 Sep 2024 17:02:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uYQl7YNq";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34F6010ECF9
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 17:02:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bVAhszj1rQLgaRqPFAJ0KeFzdKGVbqr6q1PRlhEBS3KZ4GOtDWbaKXPzdKD2yZ0aYUfkMIjSCNNHxtu5aUE76AkAwX0x2iuWNv2+MIMFl/J4tL+vwY3uXe2c9NvMVlbumuv7Jto1e+K9Bt+qDfKcwQAkuUseLsaG7lYsACBQpe9gawZPvUZl824vgcgER5/saoupyH0tdKIhT2G+/JFZg9/LtKzLg8ken6GXyPhdUnLrJ8b5+HSFwSIKODVKffShzv6t5qKF4uFhOrmLrqt56wVkp55pBzfGeuIjCT3nPx0/LxLoM9+oiWtmPzK3ilHQKFjRRXjZTzXkLA3g8+19NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtul4dhxxfl4P+IzA24ZvnD5Y8a1cFP5pQadhL7BUo8=;
 b=DKivgR0sceUcg3PtoxqGncqIMjyvloWuWuCJRSIZNsQGvBQbJXSVdRunxUZjZeI15IrC5AYYk0mw5IXBcXG7hA9Ew86kbm58v/nMmBQvgsqi4NiU7iSGEeB+sva0UJPbbE4COC/Eei0axvGzLEr0iuum3yq2qIW96bUnlYguCmYp33FhDjynGKxveBAYoZmqntfsolrYqvxWryH//zOeexdxZrhGR9l65ZppFL/wxkYcmk28Eztl3uxVKLYVjpaxgTq0p6qKvqOvVkOK1v7J6YD92hB837LJDTL7/zM9bm4Eve+KwrssH209O3B/KG3uJWNMyFRoXaGEDuVTK8+JBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtul4dhxxfl4P+IzA24ZvnD5Y8a1cFP5pQadhL7BUo8=;
 b=uYQl7YNqMFWXebM+oGspFPfSbXHgBP0biYbE1V8K6DvzGYFkjDqQque/JB9N7g83aWHr6FiBosk3rQFv3YE7c1wdG9nz9V70mmbasR3bpICdGpa2MnytzJM8KoRLN8a7IkKdKrw6CtnxOIEWbeFglZa4K6Rl/Os0t2oy110xnF8=
Received: from PH0P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::29)
 by CYYPR12MB8701.namprd12.prod.outlook.com (2603:10b6:930:bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Fri, 27 Sep
 2024 17:01:56 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::b1) by PH0P220CA0024.outlook.office365.com
 (2603:10b6:510:d3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22 via Frontend
 Transport; Fri, 27 Sep 2024 17:01:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 17:01:56 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 12:01:47 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 27 Sep 2024 12:01:46 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 09/13] drm/amd/display: Removed unused assignments and
 variables
Date: Fri, 27 Sep 2024 13:00:59 -0400
Message-ID: <20240927170103.102180-10-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240927170103.102180-1-Jerry.Zuo@amd.com>
References: <20240927170103.102180-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|CYYPR12MB8701:EE_
X-MS-Office365-Filtering-Correlation-Id: a2446b23-de9a-4eb6-3841-08dcdf1617e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?367FrSjmqFNHUvO5VprGTJsGREUVxKYS/XQRDtL1Z6fAi9JgVCq1DLCGo4iQ?=
 =?us-ascii?Q?CX2QQqgPwd4rgynfgNigKKiVSKac4NJfG9YvqwuK37wZM8YKoTZFhhwdIUg+?=
 =?us-ascii?Q?BW9xAS/c6vpbv8b6vDoc9NBPjDswJD8gqsiB2cHeuCQdyqJ3vzyN3U48ezLN?=
 =?us-ascii?Q?ZmtNNi3Zkm7kfcp6bInWN3uKfrcNCipxGFQDCTECWuJaZR71wzVHlDb+3lJi?=
 =?us-ascii?Q?ZJemRftPvmgO4P8csrOvk0OU0k497L1NaOxmIscCsVAnb67rRpxWSOhWHv7u?=
 =?us-ascii?Q?rkYlJorSgbnPMAp7uPuK/eZlHbbQREETtoTDVj5QopRBmv9curs/fXV3tIOQ?=
 =?us-ascii?Q?F8CHVXH04b5smu5+45SZlE9dP+blK91LvdxiXiCCSZrr1EAZcaR9SCIvqycn?=
 =?us-ascii?Q?Aasx0l9QAgtUplDRt/UbmGQ2Lc/vSWertsMpQhocOh8Jb0nNoJfFDAuRRZKA?=
 =?us-ascii?Q?A9yAFG+DMcKGY4KDy9KCXYXJcogEYw/QxndOvxbVGlW0qyYB3updwJ3Xq54+?=
 =?us-ascii?Q?nOQx7cBFxrJ1Ss8tC8FXnVoVI8J+C0iIc+gm6dpBmrDJHgLMXY4iiqUNT2lh?=
 =?us-ascii?Q?YKbraG8qIjz+gFBxI/N6UJRNdriZ0ZUmRDBxi4++oiiZA634sP+K2pW+h10E?=
 =?us-ascii?Q?8UNqriEzWZRrEhMfwI335zcSe1NfssxFzYTFgRqwullWETeYfqdSbqh3dOGS?=
 =?us-ascii?Q?iIEqF4XMoezLxX1c80k7jOZ07wrZKkcp15lMtp/Iar4PnmsmG9DvJYKomvhh?=
 =?us-ascii?Q?gdRcEAxdM61CpuStIL0ww3PjT2DhQNKO5EygyjwHBn+peZZQwJ9ubPpCsjxS?=
 =?us-ascii?Q?G1lqYBrVFoYt97eu/MXb1YVJ3sIxEyucI4jStFH8lMSutFQUI2vhBVl9TWiO?=
 =?us-ascii?Q?fB1zEJviIEnTY77Gw+OR1XkeA8l+/1bYQswUbyQkOOjLD3PQvHRTNZSwXAGy?=
 =?us-ascii?Q?tW2+Rhz6umydw95pPkHF06l+ykHyO1gEtWrOgEKrlOv409ODpPc1elvNpH0F?=
 =?us-ascii?Q?2KXcIrBj0XYMaScVl/Q20ghME9K5ooryint/4rZuxSQIVJs7CmCtTnTGU4JO?=
 =?us-ascii?Q?ew3N1IioHtS+WSnobtr3FDuq58Ehl2XqSs7I6bvh0O59abjjCW9m4P0ALO5w?=
 =?us-ascii?Q?u6Ep19X+t1EzdQS/HDw+09NXjk6xML0lc7xKSXytHzlyxxB4TsdDOnkHhCYk?=
 =?us-ascii?Q?ca/VglB7HCobqGEIZNgeRdJ45rBYxEfVR1DeLWGtKsZsgBh6sfjQQBcXxFJ1?=
 =?us-ascii?Q?NCjhdOteoFevdYzWPt/QGaIe/FCK0o7Q0hr3w92racPULbfFOS43SGOMp2Y0?=
 =?us-ascii?Q?/9o0rgC/lGQXxUOJAKn9nLI9CPqddedXrBZCFwMEdHdIu9tra1QJNgnPJlr+?=
 =?us-ascii?Q?SzX4BxE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 17:01:56.0868 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2446b23-de9a-4eb6-3841-08dcdf1617e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8701
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

From: Alex Hung <alex.hung@amd.com>

[WHAT]
A number of values are assigned to variables but the stored values are
not used afterwards.

[HOW]
The assignments are removed. If the variables are not used, they are
removed as well.

This fixes 9 UNUSED_VALUE issues reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 --
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 48 ++++---------------
 2 files changed, 8 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 054608d4a0db..96a8b9b79267 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -12214,9 +12214,6 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	} else if (edid && sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A) {
 		i = parse_hdmi_amd_vsdb(amdgpu_dm_connector, edid, &vsdb_info);
 		if (i >= 0 && vsdb_info.freesync_supported) {
-			timing  = &edid->detailed_timings[i];
-			data    = &timing->data.other_data;
-
 			amdgpu_dm_connector->min_vfreq = vsdb_info.min_refresh_rate_hz;
 			amdgpu_dm_connector->max_vfreq = vsdb_info.max_refresh_rate_hz;
 			if (amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfreq > 10)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index db56b0aa5454..6a97bb2d9160 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1529,7 +1529,6 @@ static ssize_t dp_dsc_clock_en_read(struct file *f, char __user *buf,
 				    size_t size, loff_t *pos)
 {
 	char *rd_buf = NULL;
-	char *rd_buf_ptr = NULL;
 	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
 	struct display_stream_compressor *dsc;
 	struct dcn_dsc_state dsc_state = {0};
@@ -1543,8 +1542,6 @@ static ssize_t dp_dsc_clock_en_read(struct file *f, char __user *buf,
 	if (!rd_buf)
 		return -ENOMEM;
 
-	rd_buf_ptr = rd_buf;
-
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
 		if (pipe_ctx->stream &&
@@ -1558,10 +1555,9 @@ static ssize_t dp_dsc_clock_en_read(struct file *f, char __user *buf,
 	if (dsc)
 		dsc->funcs->dsc_read_state(dsc, &dsc_state);
 
-	snprintf(rd_buf_ptr, str_len,
+	snprintf(rd_buf, str_len,
 		"%d\n",
 		dsc_state.dsc_clock_en);
-	rd_buf_ptr += str_len;
 
 	while (size) {
 		if (*pos >= rd_buf_size)
@@ -1719,7 +1715,6 @@ static ssize_t dp_dsc_slice_width_read(struct file *f, char __user *buf,
 				    size_t size, loff_t *pos)
 {
 	char *rd_buf = NULL;
-	char *rd_buf_ptr = NULL;
 	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
 	struct display_stream_compressor *dsc;
 	struct dcn_dsc_state dsc_state = {0};
@@ -1733,8 +1728,6 @@ static ssize_t dp_dsc_slice_width_read(struct file *f, char __user *buf,
 	if (!rd_buf)
 		return -ENOMEM;
 
-	rd_buf_ptr = rd_buf;
-
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
 		if (pipe_ctx->stream &&
@@ -1748,10 +1741,9 @@ static ssize_t dp_dsc_slice_width_read(struct file *f, char __user *buf,
 	if (dsc)
 		dsc->funcs->dsc_read_state(dsc, &dsc_state);
 
-	snprintf(rd_buf_ptr, str_len,
+	snprintf(rd_buf, str_len,
 		"%d\n",
 		dsc_state.dsc_slice_width);
-	rd_buf_ptr += str_len;
 
 	while (size) {
 		if (*pos >= rd_buf_size)
@@ -1907,7 +1899,6 @@ static ssize_t dp_dsc_slice_height_read(struct file *f, char __user *buf,
 				    size_t size, loff_t *pos)
 {
 	char *rd_buf = NULL;
-	char *rd_buf_ptr = NULL;
 	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
 	struct display_stream_compressor *dsc;
 	struct dcn_dsc_state dsc_state = {0};
@@ -1921,8 +1912,6 @@ static ssize_t dp_dsc_slice_height_read(struct file *f, char __user *buf,
 	if (!rd_buf)
 		return -ENOMEM;
 
-	rd_buf_ptr = rd_buf;
-
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
 		if (pipe_ctx->stream &&
@@ -1936,10 +1925,9 @@ static ssize_t dp_dsc_slice_height_read(struct file *f, char __user *buf,
 	if (dsc)
 		dsc->funcs->dsc_read_state(dsc, &dsc_state);
 
-	snprintf(rd_buf_ptr, str_len,
+	snprintf(rd_buf, str_len,
 		"%d\n",
 		dsc_state.dsc_slice_height);
-	rd_buf_ptr += str_len;
 
 	while (size) {
 		if (*pos >= rd_buf_size)
@@ -2091,7 +2079,6 @@ static ssize_t dp_dsc_bits_per_pixel_read(struct file *f, char __user *buf,
 				    size_t size, loff_t *pos)
 {
 	char *rd_buf = NULL;
-	char *rd_buf_ptr = NULL;
 	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
 	struct display_stream_compressor *dsc;
 	struct dcn_dsc_state dsc_state = {0};
@@ -2105,8 +2092,6 @@ static ssize_t dp_dsc_bits_per_pixel_read(struct file *f, char __user *buf,
 	if (!rd_buf)
 		return -ENOMEM;
 
-	rd_buf_ptr = rd_buf;
-
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
 		if (pipe_ctx->stream &&
@@ -2120,10 +2105,9 @@ static ssize_t dp_dsc_bits_per_pixel_read(struct file *f, char __user *buf,
 	if (dsc)
 		dsc->funcs->dsc_read_state(dsc, &dsc_state);
 
-	snprintf(rd_buf_ptr, str_len,
+	snprintf(rd_buf, str_len,
 		"%d\n",
 		dsc_state.dsc_bits_per_pixel);
-	rd_buf_ptr += str_len;
 
 	while (size) {
 		if (*pos >= rd_buf_size)
@@ -2270,7 +2254,6 @@ static ssize_t dp_dsc_pic_width_read(struct file *f, char __user *buf,
 				    size_t size, loff_t *pos)
 {
 	char *rd_buf = NULL;
-	char *rd_buf_ptr = NULL;
 	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
 	struct display_stream_compressor *dsc;
 	struct dcn_dsc_state dsc_state = {0};
@@ -2284,8 +2267,6 @@ static ssize_t dp_dsc_pic_width_read(struct file *f, char __user *buf,
 	if (!rd_buf)
 		return -ENOMEM;
 
-	rd_buf_ptr = rd_buf;
-
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
 		if (pipe_ctx->stream &&
@@ -2299,10 +2280,9 @@ static ssize_t dp_dsc_pic_width_read(struct file *f, char __user *buf,
 	if (dsc)
 		dsc->funcs->dsc_read_state(dsc, &dsc_state);
 
-	snprintf(rd_buf_ptr, str_len,
+	snprintf(rd_buf, str_len,
 		"%d\n",
 		dsc_state.dsc_pic_width);
-	rd_buf_ptr += str_len;
 
 	while (size) {
 		if (*pos >= rd_buf_size)
@@ -2328,7 +2308,6 @@ static ssize_t dp_dsc_pic_height_read(struct file *f, char __user *buf,
 				    size_t size, loff_t *pos)
 {
 	char *rd_buf = NULL;
-	char *rd_buf_ptr = NULL;
 	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
 	struct display_stream_compressor *dsc;
 	struct dcn_dsc_state dsc_state = {0};
@@ -2342,8 +2321,6 @@ static ssize_t dp_dsc_pic_height_read(struct file *f, char __user *buf,
 	if (!rd_buf)
 		return -ENOMEM;
 
-	rd_buf_ptr = rd_buf;
-
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
 		if (pipe_ctx->stream &&
@@ -2357,10 +2334,9 @@ static ssize_t dp_dsc_pic_height_read(struct file *f, char __user *buf,
 	if (dsc)
 		dsc->funcs->dsc_read_state(dsc, &dsc_state);
 
-	snprintf(rd_buf_ptr, str_len,
+	snprintf(rd_buf, str_len,
 		"%d\n",
 		dsc_state.dsc_pic_height);
-	rd_buf_ptr += str_len;
 
 	while (size) {
 		if (*pos >= rd_buf_size)
@@ -2401,7 +2377,6 @@ static ssize_t dp_dsc_chunk_size_read(struct file *f, char __user *buf,
 				    size_t size, loff_t *pos)
 {
 	char *rd_buf = NULL;
-	char *rd_buf_ptr = NULL;
 	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
 	struct display_stream_compressor *dsc;
 	struct dcn_dsc_state dsc_state = {0};
@@ -2415,8 +2390,6 @@ static ssize_t dp_dsc_chunk_size_read(struct file *f, char __user *buf,
 	if (!rd_buf)
 		return -ENOMEM;
 
-	rd_buf_ptr = rd_buf;
-
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
 		if (pipe_ctx->stream &&
@@ -2430,10 +2403,9 @@ static ssize_t dp_dsc_chunk_size_read(struct file *f, char __user *buf,
 	if (dsc)
 		dsc->funcs->dsc_read_state(dsc, &dsc_state);
 
-	snprintf(rd_buf_ptr, str_len,
+	snprintf(rd_buf, str_len,
 		"%d\n",
 		dsc_state.dsc_chunk_size);
-	rd_buf_ptr += str_len;
 
 	while (size) {
 		if (*pos >= rd_buf_size)
@@ -2474,7 +2446,6 @@ static ssize_t dp_dsc_slice_bpg_offset_read(struct file *f, char __user *buf,
 				    size_t size, loff_t *pos)
 {
 	char *rd_buf = NULL;
-	char *rd_buf_ptr = NULL;
 	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
 	struct display_stream_compressor *dsc;
 	struct dcn_dsc_state dsc_state = {0};
@@ -2488,8 +2459,6 @@ static ssize_t dp_dsc_slice_bpg_offset_read(struct file *f, char __user *buf,
 	if (!rd_buf)
 		return -ENOMEM;
 
-	rd_buf_ptr = rd_buf;
-
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
 		if (pipe_ctx->stream &&
@@ -2503,10 +2472,9 @@ static ssize_t dp_dsc_slice_bpg_offset_read(struct file *f, char __user *buf,
 	if (dsc)
 		dsc->funcs->dsc_read_state(dsc, &dsc_state);
 
-	snprintf(rd_buf_ptr, str_len,
+	snprintf(rd_buf, str_len,
 		"%d\n",
 		dsc_state.dsc_slice_bpg_offset);
-	rd_buf_ptr += str_len;
 
 	while (size) {
 		if (*pos >= rd_buf_size)
-- 
2.34.1

