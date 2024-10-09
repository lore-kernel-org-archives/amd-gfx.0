Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E9ECEE346
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 19:26:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33B2510E7E3;
	Wed,  9 Oct 2024 19:26:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PySixTGv";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B654310E7E5
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 19:26:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MxSHC5JeLkY6TgDBHLNt4RIuE7KuRLmUkuwvG6riO6dIK9WjqmIMXsScwMIH2vqQ3fEK/rhmF1sBKcl5+8jAfDSJ4x7WcPTtRVyb8UpFp29t1UTZKUBfYv7pGCa1cV47SefKElm4c0+HN/0UoX9VZGbNPVL5hzQtmdcYV7f5zw4s/ho/MWkQ/OeQKtYB34JjnanG+rlOe0ixGJDesq32Z4020KxPP2pWxfjFnyNlkWNw/Ea+Q3JK6IAPxDvjjJHsqaGBM2eBRCbzbbpNW0/xgOlGesL9BTgpXdWN/ceH0l9zd0fsWfZiSvRkN4vv0VuqkwDTkqXDvVhTnUYAC+1AyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpvS5xHOAwM5wd/mI6Y+ipSalbXPL6U9uea1PZvBvbo=;
 b=R54M2zfP030CD7ImnI1lle3Pbox9TMVnCaaX5GZdAqbSHJGzfHMU8T13L571w0gGpGCUOr9D3mb1xp6bC1mnci1cl1yTaMzNxbxP+h2GHR75dPrPng6BEV5gAbfPuQEUvID6f8w/k6HXRW2EU27RNI644WfrSWInt8w98e/j5Eo8ha0ijwjUUaOIfzcCF54mHxyANob+dvsAltRVu7NM2WnAqj2Kg9Sdh6ILzkk4UtFxFMu39vq4b3BEJTLL7TnKqqmnb2kDFawm53pC3mx3DJgFjZBDlNaJJPH++D7B4ia+K7HhkcJuYWiesnvt0xBctArhYrp2Ukq/IrIPwmMCvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpvS5xHOAwM5wd/mI6Y+ipSalbXPL6U9uea1PZvBvbo=;
 b=PySixTGvQqvIq52ZpSfSYmCaZmzpg0T224hAI1berApiB7mmNMw7JDyglO0nQ1dqQNFMmZyt4PuRzEySEdbFMHbW/fBgXU4Ai64F2P6zoByNBpKFlDpqi8yZ49F1feaSYK+JN4WyFVQzzUZeB+58uFI0MwBR4buhb+lnoRUOOvs=
Received: from BN0PR04CA0107.namprd04.prod.outlook.com (2603:10b6:408:ec::22)
 by IA1PR12MB6529.namprd12.prod.outlook.com (2603:10b6:208:3a6::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Wed, 9 Oct
 2024 19:26:08 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:408:ec:cafe::1d) by BN0PR04CA0107.outlook.office365.com
 (2603:10b6:408:ec::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 19:26:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.0 via Frontend Transport; Wed, 9 Oct 2024 19:26:07 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 14:26:07 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 9 Oct 2024 14:26:06 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 14/16] drm/amd/display: Check returned status from
 core_link_read_dpcd
Date: Wed, 9 Oct 2024 15:23:42 -0400
Message-ID: <20241009192344.650118-15-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009192344.650118-1-Roman.Li@amd.com>
References: <20241009192344.650118-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|IA1PR12MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: abaab881-754a-4ae0-15c2-08dce89839b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4fXp6jPcmZK2yDKGUK+FdpkwWPG0FMJPcWGBOhZewyR7zxuBahZLLZkv4CAv?=
 =?us-ascii?Q?aLE3wmIWnawsVBOJPv2Ii10g5XBOHVBupRUWsA+nePE+eHKBtb2qTLWQvK9b?=
 =?us-ascii?Q?TMNMZX2EQZJx+LmwtNyvYPtZcfP/Y1XbkWk/YY+tycJaHEIeZ4Npo9/lpeHj?=
 =?us-ascii?Q?PfsEOoqFMv976+YHWbnLbAuJI8VkPRMxFjWPPefIsuDvEkzKlgA4gd44yc6b?=
 =?us-ascii?Q?fsvqzwE6zjIH9/uU8Gv+QxnXpHs+0Q950ByawJ+OgKpLMctxLbFxPLwj+sWe?=
 =?us-ascii?Q?DBdazmjphArww2zI2msArxbFtP1EGDa7kX37KVQMRoHC0yNj/Tt7x7ko7Z++?=
 =?us-ascii?Q?+tC2BYrIb6GPu0Y3yj3T0viTXnQ1LC/8pkObYjDGU49z0ittA6jw/tJdgQ3+?=
 =?us-ascii?Q?lM/WAMapxPHwWKjKRW+MRiLFL+DcD09yM+U37QF2q2rsVNmODREcj3HXCU/H?=
 =?us-ascii?Q?NmH7tSSmZr7j7+EzxYMSRg6n/ouJfNw9jCPJtlDOC/Tf4M3Vdf7ihmVlqtHz?=
 =?us-ascii?Q?agDFlaOV8Q63r1F36C4cn3vSrSbVDklaKwg3qD/c7jx0o6McaCqqLJnpXDV+?=
 =?us-ascii?Q?cDcgoNhuiifiWAHlph4dyMmXLeOiy+piQu1aCfqMSfYNvPipxROlmoK32dNL?=
 =?us-ascii?Q?xvV3TV7YJkXxYKeCIOrT9OGT3zUHs+NCeoLdHr0etMiwLI96BncS9G8skKA5?=
 =?us-ascii?Q?NceA2okPyS8OFKPi7u4n5GtQu6iLA9kCNLjMYMp2OKHUrd4d+wZurBJhLA1G?=
 =?us-ascii?Q?P/ZFwXr8VaiT19Q2xLEQu34zVDGpUUkNl5rOKSEK2Z1x5fFknxeyciIDimqt?=
 =?us-ascii?Q?z4xc0CHV5dJ/e+vAiZD+FdFo1SOijeJ9d/0fgfww1baDJ5mrrwId6Q5f64LY?=
 =?us-ascii?Q?ljtOqup8wZP0UOTeA1i0Cmn7QjCsS1qg8tS2OtUn+In4aW397K2J5SMxT430?=
 =?us-ascii?Q?962zYbmTzwBNYg1AsMEr6Po8FuIvaxjPfSatI7P6/L4sIatF6Vpv3nHcpr0H?=
 =?us-ascii?Q?jBM4uQzs4CWdhlPbRDn3t+UL3wDFnC+i2W77CD+PoaGDsDM6HtbcUm5oU6Ec?=
 =?us-ascii?Q?qWI99ZE98yH/uE//qIje5GxZIV2EskApetWrfReLzO5+ZRmsZbcC9jhlMxLK?=
 =?us-ascii?Q?5z5sXtsfuPZDcgF7cMK7HgRvr06LskMJSWU7WGAwTgyAKVCDq9ENM8j1nw3H?=
 =?us-ascii?Q?Hc9f292044K4grRwrpD2BuWcbE2kJe8ywDgYnziF6Ot1v70BbrQJcrTDLN6H?=
 =?us-ascii?Q?6tqmObUm5HUC1g3Qe3mwt/tosiCGNvscYw/YFEqZHGPi8XN/H/3/EnUS4CTk?=
 =?us-ascii?Q?icFUBezhn6NGARo4eB3+bTBuX/KZ48Lkd/E8f3Y/De4lM6Hf5Sh5HQDpgNKA?=
 =?us-ascii?Q?o6Cgs9w28DTgVSEUxTBNyZKKqV5s?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 19:26:07.9788 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abaab881-754a-4ae0-15c2-08dce89839b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6529
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
The function core_link_read_dpcd returns status which is not used at
all, making them useless assignments.

[HOW]
Print error messages if core_link_read_dpcd does not return DC_OK.

This fixes 2 UNUSED_VALUE issues reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../drm/amd/display/dc/link/protocols/link_dp_capability.c  | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 952e787493c4..518e5d1f3d90 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1854,6 +1854,9 @@ static bool retrieve_link_cap(struct dc_link *link)
 				DP_FEC_CAPABILITY,
 				&link->dpcd_caps.fec_cap.raw,
 				sizeof(link->dpcd_caps.fec_cap.raw));
+		if (status != DC_OK)
+			DC_LOG_ERROR("%s:%d: core_link_read_dpcd (DP_FEC_CAPABILITY) failed\n", __func__, __LINE__);
+
 		status = core_link_read_dpcd(
 				link,
 				DP_DSC_SUPPORT,
@@ -1876,6 +1879,9 @@ static bool retrieve_link_cap(struct dc_link *link)
 					DP_DSC_BRANCH_OVERALL_THROUGHPUT_0,
 					link->dpcd_caps.dsc_caps.dsc_branch_decoder_caps.raw,
 					sizeof(link->dpcd_caps.dsc_caps.dsc_branch_decoder_caps.raw));
+			if (status != DC_OK)
+				DC_LOG_ERROR("%s:%d: core_link_read_dpcd (DP_DSC_BRANCH_OVERALL_THROUGHPUT_0) failed\n", __func__, __LINE__);
+
 			DC_LOG_DSC("DSC branch decoder capability is read at link %d", link->link_index);
 			DC_LOG_DSC("\tBRANCH_OVERALL_THROUGHPUT_0 = 0x%02x",
 					link->dpcd_caps.dsc_caps.dsc_branch_decoder_caps.fields.BRANCH_OVERALL_THROUGHPUT_0);
-- 
2.34.1

