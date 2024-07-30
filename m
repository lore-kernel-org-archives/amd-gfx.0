Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0366C3DA49
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 07:19:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6931310E4B7;
	Tue, 30 Jul 2024 07:19:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XiKjTQJb";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 092B010E4B7
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 07:19:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ec0zJ3qTy+5/rAISTuk86P2Ynfr0lsvMIrdV09uuYaDrQeUQLf/pT0Mb2sryBvn2nn5oojw5SEG5NKBkbbl4HJwAirk3qoRpY+lXIOLBrdxV9i+7C5ELc4IN9VTs+et7dfH6CJyuORbikIS9c+y+4bNQAMrHun7GUz4sKf9R0Q7aNLMs9ZfNu+RzA8iO0SvG+vKjcqKbSpfWV4thbUbEcVo+JEI+qwwYYpKwdkGDajVDglge3qaeWRZ2vuZims07z+kAv6aiZXyfSJWaJjMmUrkwxr7Wj4DEm0dZvBTWUY8gFKIdf36mGYeFfJURAtDtk3o0vSYag7ZvIkyChkasDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjyvUKR/lGfIok2atQ2pszeXGqO4wNiA8mEXRozjBuI=;
 b=hy7yvnO2vcv+75gXjd947AjpSLVlSyGxosPILtjDBxFSgsVFHM4XbV1wXYjZoYG2Dl6656gTz4j2i3+WobGFnFVV9ZywCJ4J4dmS60gWFqBuX5lIi0Q6oThkheINryw0HwWruAlNBPP5uaU2y6TQdgE5ItLPdYge6Ezm9cTgFA8pfP26AJLLGNFpwZaxCMv3DI4WsQZTGPlbEW3vRmsWSr3nhnNNT2Ih/zoKpbkJsPFqAzs3wuxWDgez+0+XrIN4Xv28wwcHyzWM5PxH5PPj2rPrrqQ0uPjfbJiQywQst8Ewim3qm/y4FXH/X133Az0tjvX28r0VhMcTcts/UY6Chw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjyvUKR/lGfIok2atQ2pszeXGqO4wNiA8mEXRozjBuI=;
 b=XiKjTQJbUQbxywXqywVDbHVxQw3GH6kXNvwMYNEAs4pm+DjG71dmTXrZlddnccymc7ZRE/qvPREx6d++zU/z36vKB5Zt3lZ3aXiut4bPoUUBpqDsLjwBtOzg4LJ7UbbuSLIc0YXchESF3ns+Gd1Xdm4nKOV5w7GnvVa9q5zWrew=
Received: from CH2PR14CA0055.namprd14.prod.outlook.com (2603:10b6:610:56::35)
 by SA1PR12MB7102.namprd12.prod.outlook.com (2603:10b6:806:29f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.24; Tue, 30 Jul
 2024 07:19:50 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::35) by CH2PR14CA0055.outlook.office365.com
 (2603:10b6:610:56::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Tue, 30 Jul 2024 07:19:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 07:19:49 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 02:19:49 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 02:19:48 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 30 Jul 2024 02:19:43 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>
Subject: [PATCH 05/22] drm/amd/display: Remove unused fields from dc_caps
Date: Tue, 30 Jul 2024 15:18:26 +0800
Message-ID: <20240730071843.880430-6-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240730071843.880430-1-Wayne.Lin@amd.com>
References: <20240730071843.880430-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|SA1PR12MB7102:EE_
X-MS-Office365-Filtering-Correlation-Id: 8385eb26-0534-4dc7-4780-08dcb067ffb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zZhxP+fpztaRCOx/JCaxHpgyHcp16j+9GOqQ+Pw/RSwcfM+nT8/6TOtsk/Oi?=
 =?us-ascii?Q?17NGpEbx1SbdPkcMnqrOeSb2fMBSez9jeIn9tg71PE8mwTD04VNYtNbzGYk6?=
 =?us-ascii?Q?yQJ648ka7Z7lxPgcj5v/DwbR6WgJCwqInfLrRRbQxC+PF5zK7tUuniOokJoS?=
 =?us-ascii?Q?BaXKktAQ0rCEuIsyFKmQlI7d14IeziSTqjF15KxzIeVh/3G4SZvIuhR/GAdh?=
 =?us-ascii?Q?XNCUeIYoRqHkwOxpadpidJDNFyXHnQ2rgspXOlgPj9u0zJ8LdPXkU8uAtY4W?=
 =?us-ascii?Q?bfPOnNzAwyFQhIqsEZ8l8eaQqRd4M/3KDpHXlhCSMeb4PLOKuBfH9NsmjUkq?=
 =?us-ascii?Q?1OXBRyGH+2mABUzPxe26Iz2CRI7Yr4JIhM9zoZ5oN1Nvc7WRrb7p76hYlPGA?=
 =?us-ascii?Q?xudgu/ziQLA9iRzixD52Rcgfnt3+hjyei7dxzOUE4CgcFtrI+oR9VQiX0MV2?=
 =?us-ascii?Q?VmBWSUmePnJwgZ001pX9LG0Q82X4rOma5NuKgpLJE5Dwu/wnrgHGLApfytiO?=
 =?us-ascii?Q?aZBYy5jkVQn3LD090sGHr0ORIVQ4yqo1wqS1ozjb3ZAk9eLQh0ygwG9raScs?=
 =?us-ascii?Q?3ys5scEwss0AUsnVBD1Wti27pF63HRtR6fNgh6Z6aC9SO/cyoTsuh+D+X1OS?=
 =?us-ascii?Q?rr/sQqEiE1p1fpY/6RcgVyji3CaE/jamc64Inox0oxxckOE47ZVEamET7Pm8?=
 =?us-ascii?Q?NWbFO6aJc/3hHiei6dPAsej3kBS7yUVx623kIJaURyrW+1/BZ6jobC4c5g6w?=
 =?us-ascii?Q?fvm0sVddKUXRQLX/H/jG4/xluM8kziA0UQfLGff2v9LLb0LWXcQ98qBhTXYU?=
 =?us-ascii?Q?lMS1RuoVlmeOJFZVzGM0jbgmI+eWTmYt7VxdXMQURGEG+ifXlVocmrsg+PL/?=
 =?us-ascii?Q?i9u8Y/Uz+F9qTFLS3eume6pTlmjpJ8K/G0ibQSxkuyoepYy2Cm5uo1VU3kWr?=
 =?us-ascii?Q?Uux/fuhq/I5OOuQRFE/5dAbxrfdO4HE44PWnFUoIynzd+G2Z4ZL1ugRU73s9?=
 =?us-ascii?Q?95iWKiQGKRlwQtW8/hzXcybJyHKfjMXH+Wt6opxagPKDRIbpaEXN/N/FhXBN?=
 =?us-ascii?Q?V/c/jdNbLpDYK8gxFk7OmkorleXa5T+RoZbKUEszYB8KK6yazFx+Z9tKepQ2?=
 =?us-ascii?Q?WUQ2FWD1G04hdr/f4qzqqZY792wDhe21Q1uHHBr1xzjO43GtmngHXx5Wtg/6?=
 =?us-ascii?Q?h0Z1o+nb4wXpb67djdvya4LpfBh6niETN7q1q6pQanI8D1SiYPEOLWGykC//?=
 =?us-ascii?Q?Q3e0tFm/fQG4zzMzc3rFK8xjZMYkGD/MmXkbOmWYMz1GzEW7H3auXs49wHeY?=
 =?us-ascii?Q?9i5moc+sqeOjcRIA+5UnriMzmoynClqHr0Z4lXStgcicvBIbPQeZfOvRXjh0?=
 =?us-ascii?Q?3msQRrmHkIIBd4+XvgmjVVyjuqSM2QHl7i+unf9eAGIPvZpOC1XLJVg+oR6X?=
 =?us-ascii?Q?w9aTQawclYbINxvstKD5WrvHrkeoyxQN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 07:19:49.6914 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8385eb26-0534-4dc7-4780-08dcb067ffb1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7102
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

[Why & How]
Identify few unused fileds in dc_caps. Remove them.

Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 250d5d48c2d3..95b0413e9f17 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -261,10 +261,7 @@ struct dc_caps {
 	bool zstate_support;
 	bool ips_support;
 	uint32_t num_of_internal_disp;
-	uint32_t max_dwb_htap;
-	uint32_t max_dwb_vtap;
 	enum dp_protocol_version max_dp_protocol_version;
-	bool spdif_aud;
 	unsigned int mall_size_per_mem_channel;
 	unsigned int mall_size_total;
 	unsigned int cursor_cache_size;
@@ -1370,7 +1367,6 @@ struct dc_plane_info {
 	int  global_alpha_value;
 	bool input_csc_enabled;
 	int layer_index;
-	bool front_buffer_rendering_active;
 	enum chroma_cositing cositing;
 };
 
-- 
2.37.3

