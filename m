Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC33C27C78
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jun 2024 16:52:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDBF310E215;
	Tue, 11 Jun 2024 16:52:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GRhIpW5U";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2238510E6B9
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 16:52:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEpCaQBcVxPlIcUEDn1w8OElRh+BmRnVPINgsTvS0RmqtGUZYAaCSSMtBwTx6NrIIVoIKbXWCdxa+vvaBw6xHy8vFs1ubi11a44xb/OUq6OCRxkkkAggsV/EgSpnqJI+VBHp3daYDOCHaxmKvAtYuGXa4PzqQLtdw/rxw+vWHYYNXfvlvHvZ9TnIU+Z+kEoZ46wL9nwZZ4b5NJpxybONMiV4UsnDykFpVfsnJ6HMDIKt+VzezMTZfTT6f4eK3bEFoDngLBH+ZUrSJxmnqL/rqX6sHrT5FWpPCB9zhziPprzA8VX0Kf9X6Kkpb4i7FxDvGDTYeX/UnVdhpU/0dla27Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3D9WoluuVOQyH1H78vuZGFmLX/2B+DtBJYRqu1a148=;
 b=CSxgfuu1USBT0I7f8eEqtgvfzw00GIBMoWanGvUDnX2W/pqEmsqvoxXRf8VqHj70PJtHb8iOWMv9AsKP2GdN8KHy9NazHLv0geGSkD0w7KByPSMh4T85Ea66Km3BHR5x0qChwUxl2THmJZ9XhJNzmhBx3LCNB1dLAZeeAI1bQ3tmUJziAQgpIMTexmLUiGOyUu780/ralRC0HKbXgN3azSAEEUS9iCChMwy16SW+HOYYm8HGQcIYvVOf9tfOK5FeoFVtsdQDZMJOgCR/gIGQgduCOarWoySIx/8mqmr2s3lt4+r0crsT0UTk1aF+R6m8OJstbQdM7gf40eA36/c03g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3D9WoluuVOQyH1H78vuZGFmLX/2B+DtBJYRqu1a148=;
 b=GRhIpW5UyfdKEfqDUvum+7TwXJtRd4ct8/IftX2at/FxlCUbRe7q7L3JE0sFBkNKhtXjJlss+GPKn/oXVk67BZv1A833gTQn52ix61e7ZrW0bvf07WAd8idnBEmMqECkIZUpIbclpDgCS26qgGGNCgRhRJ7DA/UzJQ+of1SA/eo=
Received: from BN8PR07CA0012.namprd07.prod.outlook.com (2603:10b6:408:ac::25)
 by SJ1PR12MB6244.namprd12.prod.outlook.com (2603:10b6:a03:455::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 16:52:21 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:408:ac:cafe::58) by BN8PR07CA0012.outlook.office365.com
 (2603:10b6:408:ac::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.25 via Frontend
 Transport; Tue, 11 Jun 2024 16:52:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 16:52:20 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:52:19 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Bhawanpreet.Lakha@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
 <qingqing.zhuo@amd.com>, <roman.li@amd.com>, <wayne.lin@amd.com>,
 <solomon.chiu@amd.com>, <agustin.gutierrez@amd.com>, <jerry.zuo@amd.com>,
 <hamza.mahfooz@amd.com>, Relja Vojvodic <relja.vojvodic@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>
Subject: [PATCH 03/36] drm/amd/display: Add dcn401 DIG fifo enable/disable
Date: Tue, 11 Jun 2024 12:51:06 -0400
Message-ID: <20240611165204.195093-4-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611165204.195093-1-hamza.mahfooz@amd.com>
References: <20240611165204.195093-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|SJ1PR12MB6244:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bd6b85b-64c6-4e26-1234-08dc8a36dc38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230032|82310400018|36860700005|376006|1800799016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B4zSmtT3S5b2bz8kCh+fBxbh/G6lpgb74qadR42iOK9MJ7sFgRju9IRTEPp4?=
 =?us-ascii?Q?QG70gUUNAtRDLNOUAFzskWrT9TGv8sKU5krWqrEGWxUMGrGzixhb7l2Lg+LB?=
 =?us-ascii?Q?tRStBYJVoGNjPOoJ89yyTupZ9WOMfmsuUp8tSAWpCd27oU9k1G/aQ96AP4D0?=
 =?us-ascii?Q?YMiu7M0UUHo7UyhH/1kYz0LvUrsp9k9Ay0jS1egW7nXWuG4lgfytFOV5oX8B?=
 =?us-ascii?Q?TpgJqEtXdliBS+XP5Ftl588jZ/SuoajuwDlNp28t+BnRikPfODGsx+aT7Ui4?=
 =?us-ascii?Q?tgMOaI+oQWYlMA1gW8Y8Dv2xoJsrPgxu5uRl7kLaFH3qYpRbXeslrkkWeJi9?=
 =?us-ascii?Q?Hsys//Vsxkgq1FeoBjIckdL94+UbZtWLLXvahPQ/f1OL+8Nn1c1bYW+WFEEY?=
 =?us-ascii?Q?j5bVc5vD08/hUoDUR01L6dt8A1M+bF1pw94QyHQmXdNQtZQXkFY8hXHqzfQK?=
 =?us-ascii?Q?uBmBCsjzQhGDp3ImFDL5Rx6FNNQSaElwk41A5T7mSseryWxJ1/3NXTCmfuyJ?=
 =?us-ascii?Q?UrsvRwcjzXpLWFdleSqc2TnuDCZqhrNZL+aXS/Y1bt0AQBg/ugQzC/6LWALe?=
 =?us-ascii?Q?f26AFF9Z336IlBy5vfPDJQ9qMcY8Kmb9PDujkJ2yyI2uEaycj4Nj2HVNrkZV?=
 =?us-ascii?Q?9T73diYqfns3HKucQcrPOkKSaUDwl4NrlV6syktJgxAqOT7vlI3xf2+XZnaU?=
 =?us-ascii?Q?vjdlo5V6afKIVRysyZ6ORz8n6vznX/0LRp5y0c+c2KcTSV0PSZbjGHXNinp1?=
 =?us-ascii?Q?oKuYQFHh5y0YOJ3Sasjpg77eFcJ+m/8PzTZ/Ub7APgaGXQAd8IQVag/k9xd3?=
 =?us-ascii?Q?cEMBYjp3cGRnHXuW06Ppr1xHfawkgVSrPM7DzT2SHC3iQ4kR2nQumqjTQ+cO?=
 =?us-ascii?Q?cb0Asikmb98zRGFlq9p83AqULmoy7YlFaoR/1VzdKijEQs7TMyshRDhm9Mz1?=
 =?us-ascii?Q?dwVkSiAJDsT5I0c/69CdF5JiOIz373MQ58yyBedJbmGbSpCXVSDEXk2U6Nhx?=
 =?us-ascii?Q?v7msrw9gASXzFzgwy+qFCfEA10a727SSmtfAnM3hAN+CmbjqkjqQ5RdIeHfV?=
 =?us-ascii?Q?2uZdPF6n5y+/jG+7WpIvvMxmYHP042BI6zYIfAZhB1hheXmizkbyEDm6vyBZ?=
 =?us-ascii?Q?sGXHhQzMoFe/+IfqittGo3iwRQmSgnMDWui0yNX0iY94Ffc5qfw3KCfvr3n6?=
 =?us-ascii?Q?DMTXFkc9GdtCm3O46OD0TPh45qym0EDXZMX5AQbt4Tkw/wHD1KtYb6XO+GYv?=
 =?us-ascii?Q?TA98ffwThufiJAYcaikGCFFonRBhX+27Luohp992llofEne4uciEZpp0+Axj?=
 =?us-ascii?Q?7vJSqnDS6IsU0rby4MAV6oX0Mo6zcfqp9ePfEqtKv0REUadVx+oPSKIb2uOq?=
 =?us-ascii?Q?PlaefO3kMjZ4COFxCnZSbo1MTBkiDxf/C1unlcCqPjq0s87IKg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230032)(82310400018)(36860700005)(376006)(1800799016); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:52:20.6672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd6b85b-64c6-4e26-1234-08dc8a36dc38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6244
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

From: Relja Vojvodic <relja.vojvodic@amd.com>

[Why]
Found while hotplugging MST daisy chain displays. Changing dispclk
during this sequence caused SMU hang due to DIG fifo not being disabled
correctly (caused by missing functions).

[How]
Adding disable/enable DIG fifo functions for dcn401

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Relja Vojvodic <relja.vojvodic@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.c | 4 ++--
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.h | 6 ++++++
 .../drm/amd/display/dc/dcn401/dcn401_dio_stream_encoder.c   | 4 +++-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.c
index 1325db3a4ed0..6a179e5ab417 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.c
@@ -392,7 +392,7 @@ static void enc35_reset_fifo(struct stream_encoder *enc, bool reset)
 		udelay(10);
 }
 
-static void enc35_disable_fifo(struct stream_encoder *enc)
+void enc35_disable_fifo(struct stream_encoder *enc)
 {
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
 
@@ -401,7 +401,7 @@ static void enc35_disable_fifo(struct stream_encoder *enc)
 	REG_UPDATE(DIG_FE_CLK_CNTL, DIG_FE_CLK_EN, 0);
 }
 
-static void enc35_enable_fifo(struct stream_encoder *enc)
+void enc35_enable_fifo(struct stream_encoder *enc)
 {
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.h
index 1212fcee38f2..ddb33fdfb4ee 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.h
@@ -322,5 +322,11 @@ void enc3_dp_set_dsc_pps_info_packet(
 	uint8_t *dsc_packed_pps,
 	bool immediate_update);
 
+void enc35_disable_fifo(
+	struct stream_encoder *enc);
+
+void enc35_enable_fifo(
+	struct stream_encoder *enc);
+
 
 #endif /* __DC_DIO_STREAM_ENCODER_DCN35_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn401/dcn401_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn401/dcn401_dio_stream_encoder.c
index 2ebfca4769aa..0a27e0942a12 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn401/dcn401_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn401/dcn401_dio_stream_encoder.c
@@ -27,6 +27,7 @@
 #include "dc_bios_types.h"
 #include "dcn30/dcn30_dio_stream_encoder.h"
 #include "dcn32/dcn32_dio_stream_encoder.h"
+#include "dcn35/dcn35_dio_stream_encoder.h"
 
 #include "dcn401_dio_stream_encoder.h"
 #include "reg_helper.h"
@@ -764,7 +765,8 @@ static const struct stream_encoder_funcs dcn401_str_enc_funcs = {
 	.enable_stream = enc401_stream_encoder_enable,
 
 	.set_input_mode = enc401_set_dig_input_mode,
-	.enable_fifo = enc32_enable_fifo,
+	.enable_fifo = enc35_enable_fifo,
+	.disable_fifo = enc35_disable_fifo,
 	.map_stream_to_link = enc401_stream_encoder_map_to_link,
 };
 
-- 
2.45.1

