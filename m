Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B9BC3DA62
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 19:41:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8393D10E3BF;
	Wed, 17 Jul 2024 19:41:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E/zoTUb7";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D58A10E3C8
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 19:41:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=htpglrOKkljUekGAaj3+U1CYAnH16sPIKUBsgCku+HFr+F5EhteZvbR90Q8eVkshJMAHNIj5x7ZWUjNfkubyhE47SX+R5lK6dDCv2AlgYHIqwwoZxYi7kSzjl7iogWwzjwwWiq2Q+QybwDAbhcRqWf8/+W0PJoW/HOmoGALtsAYYqSlP9d8jpvnDvNXnx2LJs8kPi29jmnX4ksyhtvyHTnKyfHuXKlj2xTWXko3p+6WGYl+4BET2p+frHk7oF1s7/m5Xjc1tl6z0hS9vb7Nbl8nCmUp1u6MD4sCu6rSAwzckK9Urhc071hxq+jOBlRJg+jUKDFiCF+9G5ihGt7i3Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZntmgnStVEkwMDmfpp7T6Dzh7SGHvyodZZndQS7HvB0=;
 b=jn3TVwobUC+BnGXc+Na4LGsi4MhXHVUpnnY2NNIH41kNBifpiZsWyGu5yVJfY/HBU8ACA6KPcMe5n0cDTxvtCJqUdm6tkK+/tS3pNe3yv+dHbq8KTwB/pGbJzpApPHwU5zw6C26wwWf9LcsszprVxIRgkCGIvkF4nCrPpOl99ph6Cl3M+q+EMvN88eKu5wYeF2FmdKhSWXuglsPRgfhlD+28odQsItF6QgTLDgmsCAe9oRN1GOhiii54t2nQ+6/FcKEzryN34zmOHa7fjkzD1IvdNlrWfwwnA8UzOlFIlJC8gaBZQSfG2YfJoKKQSt0ez1zIn+0wbRG7C3GymglZ7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZntmgnStVEkwMDmfpp7T6Dzh7SGHvyodZZndQS7HvB0=;
 b=E/zoTUb7goUB4e4FGyogdajBgry7Kxl/BHmCDc4HKz1r6f8Q6ZXv/bHcrjxHDzx6EQ4X0Y4iohG9bCx3dkGFVMDSFE4jifn1tcTaJk5/OZfbE7u9PFAClmQKBjer6vtgdeofv9Xj2Hi9ZtP/9E366QUZTAiiOC0Bxnt2/t2eUMc=
Received: from SJ0PR03CA0003.namprd03.prod.outlook.com (2603:10b6:a03:33a::8)
 by DS7PR12MB8204.namprd12.prod.outlook.com (2603:10b6:8:e1::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.25; Wed, 17 Jul 2024 19:41:19 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:33a:cafe::61) by SJ0PR03CA0003.outlook.office365.com
 (2603:10b6:a03:33a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17 via Frontend
 Transport; Wed, 17 Jul 2024 19:41:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 19:41:19 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 14:41:18 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 14:41:17 -0500
Received: from debian.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 17 Jul 2024 14:41:12 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: [PATCH 19/22] drm/amd/display: Various DML2 fixes for FAMS2
Date: Wed, 17 Jul 2024 19:38:58 +0000
Message-ID: <20240717193901.8821-20-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240717193901.8821-1-aurabindo.pillai@amd.com>
References: <20240717193901.8821-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|DS7PR12MB8204:EE_
X-MS-Office365-Filtering-Correlation-Id: 75be09a6-9538-4f3c-2200-08dca6986e25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M2pLbUUs1yyvSmN4WlVifmh3FSrRAdRIpku4vFL2v6PvX5oCftmEh8PaSeJK?=
 =?us-ascii?Q?7cCwiHgO0O+lK66blIcHCUyDcuPsnkJArt5QEhf/2RpiF6m3pJ56BFM/ekzy?=
 =?us-ascii?Q?DSHLTBprkkejUpbaSzSuP4sPwc4q7Vv8Rd4Y/MGo8fIUeTNq94OhDZNX2DPR?=
 =?us-ascii?Q?5VUHykTx5eEekJTaPkD877Gi1/dtD34LOS0t7bAY0F6M58v5HzqZOUSjLgXq?=
 =?us-ascii?Q?Gy9kA/ybhdsyKchYQ8jv5ZlQwFvxDsMQSqXyhluAq7ZqiW5iEG2pCS1Cgj92?=
 =?us-ascii?Q?f/Tp7qx05xwuMd/WpFkBqXHvQBJfPNXlsowoyao90NF0Huu9unZPyqTE1Xhk?=
 =?us-ascii?Q?ntMefnXA1Vi4o1XmeWwMCbaALZBPSi5Ls9MD6TmkOm7ILpL6hvxlgpG3yWAn?=
 =?us-ascii?Q?Vs+MYTEPQJprgNrcJbRBIHSgnJS9WRh8ir0cmGlwkFRHceM/k528ZRHsp0SI?=
 =?us-ascii?Q?7s+Whff5GjV1lipo98ZpxquUMUM+YIWhrlvKtOB+CGvamyQerpT1b+iRvTzU?=
 =?us-ascii?Q?Z5WGVwCLu8LLOMhJFY17ckPdIzF3uvsAxhOY+XJtDGL05KF7VUz4FhFGvRII?=
 =?us-ascii?Q?ZFm+QbEgNFKOpKjnCt0MAQzObAKdNeazW6nFLktYzDtUOLe1BDXhcRiJNeDZ?=
 =?us-ascii?Q?UDKeUV0+QXb7xR5gy6bu+wjz64Jwb2NCRfY1SSdJ/UMh6BPTV2ly61qrhnkN?=
 =?us-ascii?Q?jvneuaWSqBtXr2ZCOzv/jEkgSZJoPDD3D3BgNVVYn2KPfYhweP+eYLtEFkT2?=
 =?us-ascii?Q?9fPHQsD7/x02DUGfuLctNWL8mNLPL4Ja5GLr/YvEkJ0mABcFviPXKSnHsKXO?=
 =?us-ascii?Q?IAd8F030BlM83JkUdHzGc+fJagM+K4uw7V/BB4YFbQtXkrFmUaX3mOU5Gd2R?=
 =?us-ascii?Q?DSLXDl/SSewjDAg++qT0uwpFXn6iNEQY97GO7Zj/tHIK4yhWaHPgexp5GP/0?=
 =?us-ascii?Q?vML5oVN69qqpqGonzTIx7J2+bRwg3pOMO4lp4YdFnhhA9RQAxWdIPAMiWYUT?=
 =?us-ascii?Q?tNcT63VGFuT6t85y++Jnkiu3iORbftsZpmMmu3FVehNPMOws9eVR0pn/U2mJ?=
 =?us-ascii?Q?Ytop2Qh/j6/rFqFOnOsdry2SwV8/qg6h7/5kEKA9+b/kUQ2BWnSpzP76jtya?=
 =?us-ascii?Q?OdYfK2SdfUFm9qvmw4uZjqf8W2ZlzLtGief3Lalz7UFN28c2iMxm/0iuWOOA?=
 =?us-ascii?Q?wPPXuNMc4dE8WnYoBT9jLr2ehL1XFh9FOo7JGpbUsM3liEQwTNLAx57RET8a?=
 =?us-ascii?Q?pNpEWhzsv+tgksdFU1+Xol4sGoV6nC1TskgB0Il3Hhdnsxw/AEBcBYwDjrAa?=
 =?us-ascii?Q?W/wY2ejU958izXD6RDaouw1EntKaXxfCX/MUg85c3REdR/+Xp8RsyO/0U1KU?=
 =?us-ascii?Q?+uBHwNP17PzY2S9GnBsf2CTLYe1bMBgbE+ekHD1nVVCC7N1n3d9SOirxFXBl?=
 =?us-ascii?Q?AKK0qjdS6ywtMLpbn+W36zxbnd4CKCw8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 19:41:19.1216 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75be09a6-9538-4f3c-2200-08dca6986e25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8204
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

From: Dillon Varone <dillon.varone@amd.com>

The disable fams2 operation was reworked, but some of the old code
remained. This commit removes the disable_fams2_drr from the
dml2_stream_parameters.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../amd/display/dc/dml2/dml21/inc/dml_top_display_cfg_types.h   | 1 -
 .../display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c    | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_display_cfg_types.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_display_cfg_types.h
index fe153f4edaf5..b132f676a68d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_display_cfg_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_display_cfg_types.h
@@ -410,7 +410,6 @@ struct dml2_stream_parameters {
 		enum dml2_odm_mode odm_mode;
 		bool disable_dynamic_odm;
 		bool disable_subvp;
-		bool disable_fams2_drr;
 		int minimum_vblank_idle_requirement_us;
 		bool minimize_active_latency_hiding;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
index fa445067782e..dddb21818f8a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
@@ -1012,7 +1012,7 @@ static bool all_timings_support_drr(const struct dml2_pmo_instance *pmo,
 			stream_descriptor = &display_config->display_config.stream_descriptors[i];
 			stream_fams2_meta = &pmo->scratch.pmo_dcn4.stream_fams2_meta[i];
 
-			if (!stream_descriptor->timing.drr_config.enabled || stream_descriptor->overrides.disable_fams2_drr)
+			if (!stream_descriptor->timing.drr_config.enabled)
 				return false;
 
 			/* cannot support required vtotal */
-- 
2.39.2

