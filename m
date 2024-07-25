Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD1A1C3DA5D
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 18:04:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FDD210E8B0;
	Thu, 25 Jul 2024 18:04:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e2izr6AD";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 003E310E8B0
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 18:04:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BhBQogE2/1tZnvpE6VTLcQAneqUHEUISdtWLdYHeQy8DaGQmkdh7UDZbiDoFxFoZTdsJqqQG3hOB83rVGX0g+biwjKuBLJ3ZZczGmvbx7lH7avG3tBMCtaYQKZiVbqoAPi42i4cB329JZHEklzlDhP7KAAsTWaRz+l1AAUhPP4yKhsEsKZZyc5DXpSbxbORNRgfdxvfrl380omLm0LKqmeMirSwfJY1WDX7jXQflsNYlPF+oxvlUPVPBOwoYLAhkj+seyLbdmXqrKYwVGy5XTepCyRdy7ZNtfU4p1z/w5+8OfILLvGW85Tv2+OWtugkoI8hxWuIC6kV0qHxH5N1kdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47jlXnduQh0Nr0v8zvccNVa9dO6sOINMogPXL3/P3qI=;
 b=u/+zxoIH1BDSc7lndU90Dmrs2ZJvLuU5PCiXykxf3D+ZULsrR/gVC4sFgJNbyEannM2WjctJoWGCaxlMhN1MS7NrOoxhaAYU+DgvhrI53VX/mKrvHgepaGNlDdlpaav95PXLcxdJdMgq0uOovjrCnDGTp6Tm7DKsZnOanELDuYgv5fN8UHMM2abB97AyAInEeL2BiggW4awwWvmAgy+ZunaABUVhLjFloSu6pG6drhXEdB++IZgNw+sZ4YDw4l0v6gSUe/ZbL01jFjvZN/Wlr+/tWodcYGKVHF7PCokbbASImH1oX0jTOvcfi5sbaFYg4G1k86vprv59pKBaIt1QFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47jlXnduQh0Nr0v8zvccNVa9dO6sOINMogPXL3/P3qI=;
 b=e2izr6ADWTLQTzrezrRtchBapcYJFe5+lNwGz7XQNDrSq0Hb0l1gU06C/Uqf2+ni4w6LonXQgJbyH9JWSCjn2C9fxwB7MW1groyfawSAfNsDLXnssAfBaFlso5Pr+FsZnZAZISpHm5FRTwsPiX5tXBCdsdW1xh1bwhNiCxxt/gY=
Received: from CH0PR03CA0369.namprd03.prod.outlook.com (2603:10b6:610:119::22)
 by DS0PR12MB9038.namprd12.prod.outlook.com (2603:10b6:8:f2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Thu, 25 Jul
 2024 18:04:26 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:119:cafe::c7) by CH0PR03CA0369.outlook.office365.com
 (2603:10b6:610:119::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29 via Frontend
 Transport; Thu, 25 Jul 2024 18:04:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 18:04:26 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 13:04:24 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
Subject: [PATCH 29/39] drm/amd/display: Setup two pixel per container
Date: Thu, 25 Jul 2024 12:01:13 -0600
Message-ID: <20240725180309.105968-30-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
References: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|DS0PR12MB9038:EE_
X-MS-Office365-Filtering-Correlation-Id: 56a32b0d-fb67-44c0-c0db-08dcacd438aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DSwl4RIJbm5PPS6+9V2J/nIb5JcrlyzDj9QQ5y93myJoDW29uD23kT+DjTxe?=
 =?us-ascii?Q?u9OLQHTMTgUr+IUG2D61HGkxS+Kt/cHuv61uyQVmFCx3IHYQ5dYAu55qvdgw?=
 =?us-ascii?Q?PT7op96+lj88l/JFWf74pPkXyyZyF9Bxi3SP3t/Bk8hg7Vy1yUIgz6yaRAhW?=
 =?us-ascii?Q?fmcVKsS7g99tAUSxTBNsVpFlgc82InSiGKwl9yh1cevgF/FtsJNeY2hoRILn?=
 =?us-ascii?Q?oaUju5qgYiQrGGTXzmmXL9pEQgjvA0Jcsv616lXvz2au7amCcI2aL3kkjjiC?=
 =?us-ascii?Q?SdEpFUfgU04OhWDei481U3OT40Yp72uOheRBi/p0XdtXUkYjos/Jy50pZH2d?=
 =?us-ascii?Q?LxhpCJeVzXjHFfjlg013DH44o95m4j+Oe5yXsL9rlUbXRXepsXQiZFhQZb5Z?=
 =?us-ascii?Q?IOHzkXgaPuHRT40vlK3AmmzT4w/tfd2VXxIlpl4vllLIuWqqTDtASjAXA33n?=
 =?us-ascii?Q?CUGXD/+2s2UxwyTZfeTf1+slSvMuZ8t3TzGucVck+TkzsLCUHrC9AA7TkdU1?=
 =?us-ascii?Q?hBqPuo6jkWQD/gVjt/QpUvhr07DUG2p1MDKfPJwDlcueQzap1dK4+6d5R3a1?=
 =?us-ascii?Q?9QeL+Bb0IZ1R3TKHhtrFUXOMSu+GCTgIG77x07F5AJRkluhQMbk+g0YQjfrF?=
 =?us-ascii?Q?sfQD66hi1DLmWpmudVR5WeI8TXpudp8yzch+5dQbU2LGB79yfEWEQtKl9Gne?=
 =?us-ascii?Q?qFLndx6Z5fSLTBtgXEnmfFoD9Od9TuRt1mbVvt9PkIsU2wU+dIkJZqQUKT3A?=
 =?us-ascii?Q?1ZDCbGKn7pOdtm0YTHNRSsDMfT1jLELrQirnX/NtqZkxLQrjWYi6gNs6yqqj?=
 =?us-ascii?Q?MDCJSrieY5npryaITxOTjxsihk8e+b00oDqzNLXseEtZE7YtD5ztJWR8UTx0?=
 =?us-ascii?Q?wJtk+srueSGhNqxuko86CWgwWymKs2cJ+4wsJHEnaXiP43JPQNFVTlm7qMcQ?=
 =?us-ascii?Q?Bqx6DNRQQZsF4vpWwHyvETz2nXxeJpcz4+Jg+eQhUU0wPRezyrO2lwOT3Mup?=
 =?us-ascii?Q?8azGYGoULRztIRppXFpyU+UWBit7QOiY4k2nu6d1IlbISznR/udmhTB4wA0E?=
 =?us-ascii?Q?iKkXKrkcr0dYiDlbDZV2qN9lMiD2NnoUVmu9jq9ZCENtdyUuYgSUPEBqAREJ?=
 =?us-ascii?Q?3hHUOVjNPfvVh+sRSIo5OE6QCtHjLg1n5vcSRGeoxsWVHY7CLiE2JYx6DYTW?=
 =?us-ascii?Q?Tgnfe/pArAMWeQoDncr3tW60HJqjMX/sR1VHbSNtP1NVU2fWhoDXx7Kf8KyF?=
 =?us-ascii?Q?Pf6q4pkCwX8kks0XZ9gdnggOVn4PKWsQR4mDoonirx700DHHx4J6yJzCOYRm?=
 =?us-ascii?Q?TGlrB1tDXuCtlMzVyEMZTr36lFrDMTYYct7i+biA+xRYLGtikw0zlDNyErhb?=
 =?us-ascii?Q?jxBnCkcZCJ5BbiaooVYnRgxfkOETWEQRQkvO/cCNE+B8hB8x7fTUXWlAeFix?=
 =?us-ascii?Q?Bfu+rcWDDMOYhfgF59HC8+bHVZw4yC5D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 18:04:26.1026 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a32b0d-fb67-44c0-c0db-08dcacd438aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9038
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

SPL has a control field for controlling the two pixels per container
that is not in use yet. This commit adds a proper initialization for
this feature.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_spl_translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
index bcc596724a4f..8f85a1db5eba 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
@@ -128,6 +128,7 @@ void translate_SPL_in_params_from_pipe_ctx(struct pipe_ctx *pipe_ctx, struct spl
 	spl_in->basic_out.always_scale = pipe_ctx->stream->ctx->dc->debug.always_scale;
 	// Make spl input basic output info alpha_en field point to plane res scl_data lb_params alpha_en
 	spl_in->basic_out.alpha_en = pipe_ctx->plane_res.scl_data.lb_params.alpha_en;
+	spl_in->basic_out.use_two_pixels_per_container = pipe_ctx->stream_res.tg->funcs->is_two_pixels_per_container(&stream->timing);
 	// Make spl input basic input info scaling quality field point to plane state scaling_quality
 	populate_spltaps_from_taps(&spl_in->scaling_quality, &plane_state->scaling_quality);
 	// Translate edge adaptive scaler preference
-- 
2.43.0

