Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFEC2C021B6
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 15:57:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F76410EAC3;
	Fri, 21 Feb 2025 15:57:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gi2hHWBe";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB2A010EAC3
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 15:57:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RGrtWp52xRq7lOxzZaNCD/5neoWM9s5RYhnvBwVx7MRah6ZOPzmg8wCd3Vqb7L0H8LJ1aKFed9NNLUgmdKI6n1C/5DN3vZ21PVBQA110R+zcRC/Bty02Euw706wHPazp8kQtMMHL2GnARty8FTSVb4Ia5k/BsccUK6Uxokhe0BMNR7WR5zwk5o2bbeFWOei6dAyGrjwq6Pp20l5KTtFL3qvlop38alY0PuruLQ3QZMpbxmcnqfZIGDeUlI1d8LHwlJ3lxapu1+Lnc+9LJVprq8TzIsZ+9SUWHll9/7YcDDpWdiaRt+aq572RF0U8Two78C81x1BQoeOC53nDu7WECg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJU4Wj+PbnCcc4nNQMDVV84D/B7KdwDu2rWt/Tuv04s=;
 b=Vn7zHhu46zAty7OEBMPI5svcwDElkXXCnkocaZVPRY9Wosxwb+BP1HyXRj2rR908V1ulPJcj+SSNpDgJQpUuAsaaxdrFfFUu/gUuQuxto08QNMdp57PxUXXm7UG9QmdRmMSvjNdrgrmWDbVcZqTmR4lNwiRE0LfPEe1bI71vDY2aLPPSzimadgBMoyx/Qo1kXUTB/11VD45BSvBlzFb9/pZeb7K7TncIYwEAeWtnf6DZKFzuSpK4yc5w5cH5cr2DJwEbRGmgHMyiIhU+kxHsmxDEIPTNRuCYeFb2XS0z710ZuwPDt41E96Pw6G3GxjL2t1uPIPDJ+hh0Ixqiw1zmzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJU4Wj+PbnCcc4nNQMDVV84D/B7KdwDu2rWt/Tuv04s=;
 b=Gi2hHWBegWiIbbB5XkixoQBnUS+jtjtg4hs9YQXQCi+JUiTw0uqQb68oxNXoYNpLowzFRjIc3vxEyXSE3Gw2jeubzB3oS4ZYLTvD3PHUUQcFqy71ldv4FGSCbL3h0SgR6EoRBvW3Wq1IXt+eQx9X7kFgq6KnA4jhmu4Mj4I3oNs=
Received: from BL1PR13CA0028.namprd13.prod.outlook.com (2603:10b6:208:256::33)
 by MN0PR12MB6248.namprd12.prod.outlook.com (2603:10b6:208:3c0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Fri, 21 Feb
 2025 15:57:50 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::2c) by BL1PR13CA0028.outlook.office365.com
 (2603:10b6:208:256::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.17 via Frontend Transport; Fri,
 21 Feb 2025 15:57:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 15:57:50 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 09:57:48 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 04/24] drm/amd/display: Apply DCN35 DML2 state policy for
 DCN36 too
Date: Fri, 21 Feb 2025 10:57:01 -0500
Message-ID: <20250221155721.1727682-5-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221155721.1727682-1-zaeem.mohamed@amd.com>
References: <20250221155721.1727682-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|MN0PR12MB6248:EE_
X-MS-Office365-Filtering-Correlation-Id: 813c3677-f75c-4f8d-f0c2-08dd52907e6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7cjKN30IGFI0XaR0x8G1lAW8G0xcohyoVhbr2KtcKXMcqENUWDGiff6AtorA?=
 =?us-ascii?Q?WokhJyWBcSU0PY3ws0wIk2x9fk8YpWR1G0xqW29GwA86nza24TlBLNKnfa+I?=
 =?us-ascii?Q?RUSKlxW0Sgd72QQ8Fx1QzLlX1KdP7KpMLC1ZBmtBBHmZNDA/t2zjw2ugiJlB?=
 =?us-ascii?Q?eHEHbgYXeZ0o5WKs7mQtKt86gtt/4P/6Ed3+gCSivH/sElSRb9cjL4IjHMOc?=
 =?us-ascii?Q?l9MhyydOcNEHPX2R0GIkqIYvcvr4OkjzMdShMrHO0ZDJyqZFBgUda/1mlajS?=
 =?us-ascii?Q?7nN2Bwg0I50YX9qCRUDsyuip9NBgFonRM2Vfy0lifFKZdWsIRJXtkzUmEwAV?=
 =?us-ascii?Q?/pJujUJ0KAXcuKrBdF1DeJ1PiFm1Cl20ZX7x7EV1auMMzjHyG4uTSp7pm4vh?=
 =?us-ascii?Q?KmAUd7fwXPuin/TEoQ/pcEQ1S9PoeMGz03jNXhVv8Z2Ualcuw+qpaRGNbhFV?=
 =?us-ascii?Q?S/jGYE2FRA5VtIrkO0mIurH6/K3rZhjbrAy7ibhQN4DQZ37iiVSNwcCiv4Vo?=
 =?us-ascii?Q?UPHnpMIZZfZDh2RyNHGPg77OccjdNY2+l7rpOrd8Tw7FllC8NvtIKicI4iaj?=
 =?us-ascii?Q?SxvAZcqPjgwJ89U8fHdXn4d8m3zdcPX9tvmgkV/7l168nGfGr2epA5KnKBfs?=
 =?us-ascii?Q?5/C7lV4vE4Ir62nRGTTIDDx/nICsog1n4exG5wAfuf9EI5fVE128G84iZSu3?=
 =?us-ascii?Q?1bYXzn3BXAWslNeAB4DWhCA/MoZhH1Ro+EkL2WpKo1V5DDvU9sN8BDPEG90T?=
 =?us-ascii?Q?OinAeA5TfWYarKKCqZCf/bxb1ZlBs9ExR5YXVj5AJ7QxTHoi8/k7+dhmsjXN?=
 =?us-ascii?Q?QjF/QGZCiAQvQ/IYIGi7NjvbjgP1UxKcmRuLI8iquJ4ebe4jNN4mbuI4CNpe?=
 =?us-ascii?Q?gtdK+SJfc/rc89WAEEqIRKZ3Dn7a54OKw1K+px323siU+vFh5Y4qJglo0Nlw?=
 =?us-ascii?Q?9HTV9VZAMXl4ydXmX5fOP3ibnSYxNU0LKU70q3I2kHjqKtizUw3s8+7UO6bb?=
 =?us-ascii?Q?ouyvwqr6YbEOl01Scdxmj3pcfK7vSjze063OTVd4U/H2Mb1/kII7UnSwDMcO?=
 =?us-ascii?Q?izihmrCAd3z1yUsMGruLXBcM7xPLxq2U+KmFHKHmJ7U3MKi/EmiyR2MwT2UL?=
 =?us-ascii?Q?dOe5do9lVsz9B2sYJ+yUiX6NmPiUg9igUXJ0t+L0NSWyiY4or4JsARuOCgMD?=
 =?us-ascii?Q?UJLtXmlMJPTAB0hdz2Pmrnfbz3OIPRUINfGtlOxLMUzj0EmsC08xX1IaTfYA?=
 =?us-ascii?Q?PyxFNWZL2sKeqwiwHcrA/ltydmGixqc2K+r12LZU7x9bb9fz0PJnhb8/jMQq?=
 =?us-ascii?Q?VRoseEcpJY+73JmOuqvi6UhTUeaXbe5RmP84axQuYM3kHeFQWYyiWqR5Q1no?=
 =?us-ascii?Q?zbj7hqniIyhHt3Y0M9q59ixCeoqTh8IqncSba85nBApsUgUmlRHTrcXrY84j?=
 =?us-ascii?Q?Py2gdx7zTDMNqn9iuZhM2hg+rVtDFK34emgGP61LaoebwK2T8P/a4Yxlgiy1?=
 =?us-ascii?Q?Qd04PrPMDfnFONE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 15:57:50.5312 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 813c3677-f75c-4f8d-f0c2-08dd52907e6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6248
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
DCN36 should inherit the same policy as DCN35 for DML2.

[How]
Add it to the list of checks in translation helper.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index f829d5ac7c8e..2061d43b92e1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -557,6 +557,7 @@ void dml2_init_soc_states(struct dml2_context *dml2, const struct dc *in_dc,
 	}
 
 	if (dml2->v20.dml_core_ctx.project == dml_project_dcn35 ||
+	    dml2->v20.dml_core_ctx.project == dml_project_dcn36 ||
 	    dml2->v20.dml_core_ctx.project == dml_project_dcn351) {
 		int max_dcfclk_mhz = 0, max_dispclk_mhz = 0, max_dppclk_mhz = 0, max_phyclk_mhz = 0,
 			max_dtbclk_mhz = 0, max_fclk_mhz = 0, max_uclk_mhz = 0, max_socclk_mhz = 0;
-- 
2.34.1

