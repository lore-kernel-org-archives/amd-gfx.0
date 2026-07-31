Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EE7C55172
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 21:16:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2F1410F426;
	Fri, 31 Jul 2026 21:16:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sAdd1rqA";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010051.outbound.protection.outlook.com [52.101.61.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B44710F41B
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 21:16:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=duFO+JBUFuhGOQrSUsR4oCpL91AairMxh6DYyP+Z69r3mA/EavdCjMBxBnW4QQLeUTsy8nbV6yQ3I8RLQXJ2sqm9OotEhA3cvBpl4MFZtBgavOFDKttcm+SLVfN+6QfsssIfLyjQvCN3hfEoNwgiNv+VkTY1vFXiA4V4y7XEQspVEpHSRJynLdJdSyjA1BWZqwqQFG2tFkaXNEmvOseT14C6Vq+Wph69sKdw4B1+kPdPZ2vlD7QY7L4VvquhBvuZFxW52t0rYlB0Jq3fSflQQj5GGzX9kiN3JEZ55CMWQdmxZB2xJJIeGwhTPyZYyhfjsP81Fs5gs8vzB4W5NDbksw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sv79mfzX1CbPpyXOi33WX8gQMOvXQppc+PG5d+e1Y8A=;
 b=PYGCJPmbVZ2VFiFFo/EzzUuPOtV0oC8EwdMi9m82kslhmk54Q6awTIBwxs0uCpvLWrziibTuXNq8lW7os1tspaCSsOoe511X/aZE4x7YKYIPz2oIIEjLv4gzBs54h89KQmCmzVMijGC2USK6i0qeg5OcZP/NSjKdlL8sWGDtMNdqKIY2hWXoXFss05S2NnoJv7nOuR5MPf6PhQ2k7aRmAN12MfPdiNqYXY4waNnOpAc/hHuXIB52xIywwnpwj/fWYEyt4Hv4BBKzfSHZ2C0R38AYKkbWuf+qKaKXrPQQGgViS6KbelYGz5eyhJRhqq0iTa4+3caWM6iysG4l/EI4HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sv79mfzX1CbPpyXOi33WX8gQMOvXQppc+PG5d+e1Y8A=;
 b=sAdd1rqA6C5snW67tG4H7KeI7QHIRHC1farT3hRCphOgiOHggrFJMBmEnYpP3489cV9dVPp096EKkZ2CIqbOmwmvgJVXf65ZAbRSmScHv3HoE0eHpvvPyrgWnZ0oBgwmZFwMaaJ+EM38HHkHAoz979UZs3AWE1DwOGJMla3XKE8=
Received: from CH0PR07CA0018.namprd07.prod.outlook.com (2603:10b6:610:32::23)
 by DS0PR12MB8043.namprd12.prod.outlook.com (2603:10b6:8:14d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 21:16:21 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::3) by CH0PR07CA0018.outlook.office365.com
 (2603:10b6:610:32::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.15 via Frontend Transport; Fri,
 31 Jul 2026 21:16:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 21:16:21 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:16:21 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 16:16:20 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Relja Vojvodic <Relja.Vojvodic@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>
Subject: [PATCH 38/41] drm/amd/display: switch max FFE level cap based on FRL
 link rate
Date: Fri, 31 Jul 2026 17:12:59 -0400
Message-ID: <20260731211302.3040343-39-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731211302.3040343-1-Roman.Li@amd.com>
References: <20260731211302.3040343-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|DS0PR12MB8043:EE_
X-MS-Office365-Filtering-Correlation-Id: f10cfb9d-f39b-4d34-9cda-08deef48f841
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: P3CWOXrjBzoeFUNG0T16btDj9x11CAA4/oZh6q67lGsXV50g34PyiXaq2/9ejywLyVslj7gQrntWEG2Ow8WRkLnBmZHlE6Hd6+902nV0pi+Uq3Nw7PLlCNCQrWP1FkixAQJUGM3dkovIPkl83JuVouVDcANFrJDmvw5V6gRtVGwqZVJ8RpPhZ4R83uwpuY+ZVxb3pIBEeoT+8X5w5vEk20sPderv4QFG+CsbHS3gvASqyMohnJT7DJLW7w5z+QKCb3uLyQqHLAST/umdBOq7a4z96NqXj2Dh/N0DsTivh5BugkEPGyRNILmR0OkUkkky7ftykHam8s40ffH2nNLRhT5nJX896+rDp6GfiIrW129M28p8XA1yRTsgf7n08T51zl4GaN6ALrqq9HhAlMZoOe8NFyX9AcaNOJ2eX9I3+db5E7EoXGwmQlZz8spbvfWvz0ZA5BO6Ppm8zamfC1lxA5OoQrDpduhmrb9B1K0tSSjgB/JhytrmpYuTbEwNm9naA5OfEmfQ5rTSGqa/qosW+I68irAYC80lJR7acuBCjFwPxtB0q21CljJGPQIeNPxzJinaGcSk3cEjF+kVXih0Tb5/7GYLPH5inZIys9lF7S1Zi0IRtiwsmIrB1xZmIjl7jPZaFmrg3hfR/OqSAYluROpgctYLNiZEzdUfdZ9+lgRznw2gDQamQn7o/MPpNDc1zbPJlT8eXHyDt8Wu3ilQ0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FQM18LOqKClRmgd+mAZbdv53cf8zPc5dwDofUSMgJd+liKIgvUmTfmlszGWFyRGvc4DE7LiQ4TuS7aK+KvENMruMXT/62pCCnq8B8H2C5kF7nG919+gADnJzVLA/vQEW6BI+yQZmODo1z3oTCKyIc7khugz9KbCfxCX/4NLqMnWKJYwWU4XFWd9R05xxgwnik/QdM7SLpqTDrFDeIQbCS8InnJjGHq0Q36VwwCctfXpviO73h9LP2/H8uZrHOLcmU3e7747aJz4tl9iYfNeHyT3MUBBtfo+Qo2iwoR3LMSdd5Z0C+bZz85colZyNjcwgA1dhR+yzplSXOFqe7c/+BGza4ZKZJ0/vPqV+i0FaRpmBUpKiYVX08wsUrtTM5mzs3rORUkTImNZnH4PAe18+L32ujSGlDWP9VANNdROhUoF4stLqC3kFInowAr6vDvNf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 21:16:21.4370 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f10cfb9d-f39b-4d34-9cda-08deef48f841
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8043
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

From: Relja Vojvodic <Relja.Vojvodic@amd.com>

[How & Why]
- Add support for dynamic FFE levels based on debug config and link rate

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Relja Vojvodic <Relja.Vojvodic@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../gpu/drm/amd/display/dc/dio/dcn60/dcn60_dio_link_encoder.c  | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn60/dcn60_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn60/dcn60_dio_link_encoder.c
index 86ac881879cf..6fe15324ea50 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn60/dcn60_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn60/dcn60_dio_link_encoder.c
@@ -139,7 +139,8 @@ void dpcs60_program_eq_setting(
 		bool no_ffe,
 		const struct dc_hdmi_frl_link_settings *link_settings)
 {
-	const uint8_t max_ffe_level = 0x7;
+	const uint8_t max_ffe_level =
+			(link_settings->frl_link_rate > HDMI_FRL_LINK_RATE_12GBPS) ? 0x7 : 0x3;
 	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
 	struct bp_transmitter_control cntl = { 0 };
 
-- 
2.34.1

