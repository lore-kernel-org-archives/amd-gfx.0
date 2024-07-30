Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65078C3DA49
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 07:21:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1745710E4C1;
	Tue, 30 Jul 2024 07:21:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="novRQfAt";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 512BB10E4C4
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 07:21:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DYDLPZlDGYsZKJR6UKaHxYCXdz1ZtzkJ/FoWvuxMqY+B9g8OKVzqtnLDFQia03nJV9ebStuqBuN9ahOL5nnkjt5Eo1ZrLlFlHSrWt7e01kDXUMkmqg1d7Kw6lNXCIyL/uYVBSDBu49n8zTzufJRzAdfPVqO+/vTO26LwFc8XFaHIUGKs5Fn5al7dN5fDhXIE13N3Ptf29HS06yKwxrIM7QpTqDPWjZV7/ouBzG/9UHK8mPr35W0C7g4WUH4kpRpPg0Jemjv6JYTl+8xysv8KAe8WZOXl4Ti2XurWa+cbIKqDptOmQXimG2bYAILozeZAW2wGYr+XNKVleIAn/BV+aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQ5co74nfxBlmhKZyKWLNB3Mj1nTL0enkI+BYqAyahc=;
 b=cUgkG1omVyHLfRikHT9bdjABZ+Va25A6fHoUYhCzLiwdsc2g71RTAqqXNGLN8n0pwwhv5FKWMi3LTrKnRl0C2dQoAX+hLFQj9+zheSUdSic70ZJI35r96Qwtwn0bkDjG2oECgK0u5qbzqOaLQsY5LDuYf2hLA7wEvGbJu3MSH1R8NV9dN/4Va23i8+MpGeOyw5giDtthpx5b7ApVuE7fo8OdWWwFO0khappRwzDtyafYxTqOaKiQQFepEVhDdV0AP52M5qZgslxZCY4u8mNQqck5Q0LKdNthM/nyv9VMoatmEdzYQgTK1NM24HXw/YkmB1IBdlg1AYmSSfHWjRHZCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQ5co74nfxBlmhKZyKWLNB3Mj1nTL0enkI+BYqAyahc=;
 b=novRQfAt1+n5KNO5L3x1FrcnescCHg4tA9p3TBoH98Ji0tor83hEQktxYQKujw1FK4G7UwuotuaHbqyuLpsottsUf2EX1tb3U6KUxNZ+5dk17yMjCz6pXFdN/SXxGq5W+o4w4mS6falDveA8/jVM0KKLS/m9bQdJgzgDppTQwac=
Received: from CH0P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::8) by
 IA0PR12MB7580.namprd12.prod.outlook.com (2603:10b6:208:43b::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7807.28; Tue, 30 Jul 2024 07:21:06 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::fc) by CH0P220CA0005.outlook.office365.com
 (2603:10b6:610:ef::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30 via Frontend
 Transport; Tue, 30 Jul 2024 07:21:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 07:21:06 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 02:21:03 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 30 Jul 2024 02:20:57 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Joshua Aberback
 <joshua.aberback@amd.com>, Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 12/22] drm/amd/display: Assume 32 bpp cursor in DML21
Date: Tue, 30 Jul 2024 15:18:33 +0800
Message-ID: <20240730071843.880430-13-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240730071843.880430-1-Wayne.Lin@amd.com>
References: <20240730071843.880430-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|IA0PR12MB7580:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d9f4714-2545-452e-42d1-08dcb0682d94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RLQcL9ju96MCQ+BfpKMUQAZoX/RT1y6fXD+UtHERBvMH+PjoJ4ALtE/4MKAq?=
 =?us-ascii?Q?wBlnw6SzKOpcRyl4c57Mv89E5nLzD+2iS41t4ywEI6uvJbG0pP4S3V7ouEJv?=
 =?us-ascii?Q?48+1VpF+QoUFwsOtJvWdYUvXlLds/RHSHICRbYv6uXk5wLY4APu/ulM2mlTu?=
 =?us-ascii?Q?Qk7iKCcVS3o2nZ7zN//9grJ7u+wqe+iT8MKdK3hYAaWRVSGE/JU6Y9BDKC4j?=
 =?us-ascii?Q?wQlEfUzCxXnl4lIdu6Kb8IVZ5Oww1ARniWrw/0ku/2EvJTn56x0U3z/HLy6g?=
 =?us-ascii?Q?fUxfXOwNLQ/hBnlAJQ8HIfNGE7Mse/y4CKQju81daMUltodr0BQFukN385LN?=
 =?us-ascii?Q?7Q7XzZBJvGMfunm8W/xMCxlwaZ/mks0isfGDKIhyIQspcI65hzVDsRsm02hk?=
 =?us-ascii?Q?czCaQAEMym4bQrOu0loXPQGazYWg2ShXBGndCT9T86rw6L1eGAU3f3+29Eor?=
 =?us-ascii?Q?A1V+JUQDz2y/XRlaAUpRbzr2Xq6rRQvZTpZY5vkyYAJNPos40r7mDosHAhaL?=
 =?us-ascii?Q?FysecmxRmY5HmaMTV4zcX92nYsb7o00OVv+mrGrbrLQWdjA4ic1HC5LAZryK?=
 =?us-ascii?Q?Jky8gjZEhiyoj8qtMZR4O607i1io+xP8OTO8Nki4CNXyufBYt8jhM6JJJtEp?=
 =?us-ascii?Q?J1XNymezoF10GQ0ByXMkRFd7nAtjv5tgFTGtpY5Dr8jHS+lVMAj5w+Ppk+VJ?=
 =?us-ascii?Q?mP/wwqtEY8/KAMXA+9ZJ3lkegb3+hUa8t02rmjETwsBsgJ54Xabt7pgghGHX?=
 =?us-ascii?Q?AmvNup2JLEZRYC76nxp3KeVbjYR/TV3qIHGxU/Noi1TpPza6leuFEnexZPg2?=
 =?us-ascii?Q?OZYmCT+HxrXDldN9Hm22ulpPcFVH99ImM94H+Henp16BrAjEX3PIu6cXm5AF?=
 =?us-ascii?Q?TzTU8cwe03aDBxuss8uXkH4AkQRT2j64X3e6cYZJCOD7C+qN7hrYvVdoCUCT?=
 =?us-ascii?Q?50M+toBl7LVoKph6ZK+0WUP1Fxw7378rbLKwP9kpKB2M9ho7cTJZip9Ypaq5?=
 =?us-ascii?Q?qV/Ivz56blP5sdOhYERqqAqIpDEDF1X29ND3iA+Zl7/zTK9eBjKfHCnG2Gqp?=
 =?us-ascii?Q?LlG1CaB0UE1+SF2jW3f30kXA+hqJK0ptFWw8926u/b27xtFOyHnGbi/AZ31k?=
 =?us-ascii?Q?3P+G32yAOu4iethhhKd2tGKncM5Galfy365f0BLCZaHau9sPR6elah7fQzHl?=
 =?us-ascii?Q?LD5kgW/q+6W086euRTBglzEraxoJNb1BHUXC0zUBkRupdzE+Wqv2NCYyCeB4?=
 =?us-ascii?Q?AxcndUUspTNPidQOvLZH7rUrnkPiA6EBfmv7bZqHSbJqnsPSi8lVB09PDawy?=
 =?us-ascii?Q?WHEksXMLYHqu5dMtFEd6yxJiRsHkjVm2zTUzQf5ipaJhHWIuw4h/lPoK1WuD?=
 =?us-ascii?Q?C+tv3KnyGZCJKmeOILY8NyGJpdoTVdVGvCE/KyQycnYSuuuk4N+G+tQ7mPAU?=
 =?us-ascii?Q?v5wn3Y1kd15xSJKtwbS+R71DNL1ghg1O?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 07:21:06.6608 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d9f4714-2545-452e-42d1-08dcb0682d94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7580
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

From: Joshua Aberback <joshua.aberback@amd.com>

[Why]
Cursor size can change dynamically at runtime without re-validation,
so DML should calculate with the max size cursor to cover all cases.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../dc/dml2/dml21/dml21_translation_helper.c        | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
index 65776602648d..b0de8920f7e7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -725,18 +725,7 @@ static void populate_dml21_plane_config_from_plane_state(struct dml2_context *dm
 	const struct scaler_data *scaler_data = get_scaler_data_for_plane(dml_ctx, plane_state, context);
 	struct dc_stream_state *stream = context->streams[stream_index];
 
-	if (stream->cursor_attributes.color_format == CURSOR_MODE_MONO)
-		plane->cursor.cursor_bpp = 2;
-	else if (stream->cursor_attributes.color_format == CURSOR_MODE_COLOR_1BIT_AND
-		|| stream->cursor_attributes.color_format == CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA
-		|| stream->cursor_attributes.color_format == CURSOR_MODE_COLOR_UN_PRE_MULTIPLIED_ALPHA) {
-		plane->cursor.cursor_bpp = 32;
-	} else if (stream->cursor_attributes.color_format == CURSOR_MODE_COLOR_64BIT_FP_PRE_MULTIPLIED
-		|| stream->cursor_attributes.color_format == CURSOR_MODE_COLOR_64BIT_FP_UN_PRE_MULTIPLIED) {
-		plane->cursor.cursor_bpp = 64;
-	} else
-		plane->cursor.cursor_bpp = 32;
-
+	plane->cursor.cursor_bpp = 32;
 	plane->cursor.cursor_width = 256;
 	plane->cursor.num_cursors = 1;
 
-- 
2.37.3

