Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32B2D2E015
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2024 04:54:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92AB310E71C;
	Wed, 23 Oct 2024 04:54:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f0oGIdYD";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52BF310E725
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2024 04:54:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xmfjmiQUaHtQ24Gmbkfuboq2MazcKoJ2sIPcJQisF4XpZxGZkeySj8MLQpO63fPFjgttiX0BANztMnD3/VHGzIzLSTWdJFPj4pNPa8HSfNvpDeHDqZ72xMjz+5J7RsmUqglk0/INWCdOmhinNOHYMCTmWPmY2j1dFRJIgLn8pnC+AaQPAgu5jPsHMAB/8i04e+HqCpCOmeChQTOklfMZW8vWRNP4JDZ79A4ITdkZGQ1LzUV9uMHENewNpRzPf8GyKrpu4k+8Cc8369X+79+yvxkg8ib48nRgboygmhKfHA6bpux/Hr+9K1ujBW+pPfdXr2EVE3iMyg9Y3jaK9wZbjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JeY5/3jcD8srCOuUwRCXrQ+FCAejqicPLNH654GO46s=;
 b=MSA0D93J/yyJBxqYmOuppGKcn178Uquux19vcW1pz3n3GrK2tf7Yt66R5sr20NgfIXG4MexOI+xtD0t3RC2JwS3gAPbgpAgEF+UXovwVYYtPo2+UhRUuggK44Cxy/PXFTl8SSsIV0+PE/N9tchCi409bBMFVQxGuDs+6oF7/Hq1RHszCqX7YIfTIcuMuSRzL8flcFrpf7Taep6sMZZaoReXzZes6t/ofGAfZZxjCop1v0XD+Di6biM8EeL2HMXcvcWX7EOCfUowEuKr2w/z8B5z3180WpnIEqP3DOykOd4pMChwAMYQgaq7hf9BF9KDgNUq8b06iI0KBYfFTtz/28Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JeY5/3jcD8srCOuUwRCXrQ+FCAejqicPLNH654GO46s=;
 b=f0oGIdYDHDdOuDeppVtiX3150xR631PXUFN1rR6gcU5X6pdymNHLKsp5ZexZTpH0MjU1C971QIY+ZAi25WBOhL6DQmYMPTd3a2NrHGqG9N+ASsI2cK4jqvZkpw51XN+F5snQA+tRK9Pe6eW7wJrLQH4iwFIYJoN4TbcsG0jl+OE=
Received: from DS7PR03CA0076.namprd03.prod.outlook.com (2603:10b6:5:3bb::21)
 by CH2PR12MB4072.namprd12.prod.outlook.com (2603:10b6:610:7e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 04:54:22 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:5:3bb:cafe::95) by DS7PR03CA0076.outlook.office365.com
 (2603:10b6:5:3bb::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Wed, 23 Oct 2024 04:54:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 04:54:21 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 23:54:20 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Oct 2024 23:54:16 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Leo Ma <hanghong.ma@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 07/16] drm/amd/display: Fix underflow when playing 8K video in
 full screen mode
Date: Wed, 23 Oct 2024 12:53:27 +0800
Message-ID: <20241023045336.1557443-8-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023045336.1557443-1-chiahsuan.chung@amd.com>
References: <20241023045336.1557443-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|CH2PR12MB4072:EE_
X-MS-Office365-Filtering-Correlation-Id: b7241a1e-6a25-4cfa-1f14-08dcf31ec291
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LhYbqMfMEDnnhHej9IbbBtBCLIcm5w4UCOfwuSxASg6vJTh+aHXy1zKInSiO?=
 =?us-ascii?Q?ae2f4Rd7cIXGq/l/g/4Xyf8p16TDxmFbuiZulUxPsxr+YUsOvBi+t2K2oWD5?=
 =?us-ascii?Q?9zsqGCBwB/Sc8VsbuXBx3f3n4eM2J0rltFmVxaySeyG1ZVFvIAB8HaJa6EgF?=
 =?us-ascii?Q?lLqGVqpmvlZiOzll+xSROIF56At13l35R28+7vzFU3aw84P5+DX17FJM3oRG?=
 =?us-ascii?Q?LcIzTt+P3Vr0UEc0btf5+YS5ZflaJxLXFhi3RksWUaUO2jHYO2Db8Q4qXBKy?=
 =?us-ascii?Q?re+C+BSw0UYDdIWiQPcfdaEgcWSYRqZRq7XuQpIvJomXgUx7xENIvKsQ9i+T?=
 =?us-ascii?Q?b+DoIl9b+XBebUxS5dMpV0LGVsILwv8fWhfd08NR3/63pDQpYbwY1w9dHi7B?=
 =?us-ascii?Q?DHHqfY7K5QAaMRFmP/Ps/AWVP8ioEskypVFeuAVUiRIU8hWnQO51jfWdxxIo?=
 =?us-ascii?Q?HpPBhghEiwGxTgaxTYg7Cm1TVOLsdMCkcxsBhDQ4FjBeIrNj3DyJnFE0fQec?=
 =?us-ascii?Q?VMAKfemNcjxJu1i6METpkzs5nBSMu6HMQUTseKZ2y57NHaqjdH/eJbhXjMqL?=
 =?us-ascii?Q?7Y+iRR8RWa+3TKqlkQEGdlbmXPCfili+QGJZguddHl/NCV5Fv+CWpSSFL9B5?=
 =?us-ascii?Q?Qrwv7e+z79Eo8Oo0AjHY2Z7i/mcjlTorewjV+ekqpOt7KaHMi1Ag1yx+mDob?=
 =?us-ascii?Q?bUNBxZKxNXrIbznU94g5GEN4E4s2B1gxLuNVKjyiK+tlupomUjYh3QXxo8Kw?=
 =?us-ascii?Q?457BDPwmBJJj8ucHCyCcMGjBdzQP0iiZ1SDzlY8ZW6K0v8rYqoKl6v/SjP+X?=
 =?us-ascii?Q?LHsqYDc/dp6ka/h+072wT0JahQst1asANmvNNbpJ7Hiy1/gCBYCzcl3Rt9nG?=
 =?us-ascii?Q?PoqYuap2GCzGr20BXHqInVds0AH2jCOLOXirgecCg4E4cJ6GX3AgY+Kpfc7t?=
 =?us-ascii?Q?g5sNobELThorxUfpMCQneYSuQewguMwKVLVHDcA63KRVaIhpI3dYz7Nyc0Fk?=
 =?us-ascii?Q?/+1pr2Oyr7bDhUy6Qn/o28HM74XwUcu+Z+ulFvwNoszOA3oK1UhXjUjvMmPu?=
 =?us-ascii?Q?NKcVhJIzPWjZX68AO83pw7KQAIfQfy4sBDMyljnrkPiQHGFn5cCntYYmMPbT?=
 =?us-ascii?Q?XvaXQ7Y0YUgUqL2RcbO5CuH2DID0seO064SpLi63yC8/fJG4M8q3jPo9DIgW?=
 =?us-ascii?Q?DrKPZzb1ArgdoxIzm2HFQdNbZoDqXbmLbd39tQZhmAMaF1pNEB8TUoawEAwI?=
 =?us-ascii?Q?R8VjmoEvpSZuJT0gUxkV3XRV0qdayy2jWyVxKAhMXyH40dOjyYdhUn/uUCTt?=
 =?us-ascii?Q?eNwkAT/zgKCsxDii8kogl2RJ51zLZf+gUd3hrHTO54Fmws/p83MgpOLShbuy?=
 =?us-ascii?Q?sgQtiYD8LTbdqb32dgc16KZtLGnPTaoudSodb08LMu3HasUKIw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 04:54:21.6908 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7241a1e-6a25-4cfa-1f14-08dcf31ec291
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4072
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

From: Leo Ma <hanghong.ma@amd.com>

[Why&How]
Flickering observed while playing 8k HEVC-10 bit video in full screen
mode with black border. We didn't support this case for subvp.
Make change to the existing check to disable subvp for this corner case.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Leo Ma <hanghong.ma@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
index 7a01a956e4bb..138b4b1e42ed 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -859,7 +859,7 @@ static void populate_dml21_plane_config_from_plane_state(struct dml2_context *dm
 	plane->immediate_flip = plane_state->flip_immediate;
 
 	plane->composition.rect_out_height_spans_vactive =
-		plane_state->dst_rect.height >= stream->timing.v_addressable &&
+		plane_state->dst_rect.height >= stream->src.height &&
 		stream->dst.height >= stream->timing.v_addressable;
 }
 
-- 
2.34.1

