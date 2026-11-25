Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3C4606A31E
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 06:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=dB/GID8W
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFAD210EF25;
	Wed, 25 Nov 2026 06:56:01 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012059.outbound.protection.outlook.com [52.101.53.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E61510EF25
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 06:55:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fUfBuVtr9S6/xNzqDnq538ZiAvOyQwGI6w2RZgYDJbiM7y7sFE+ED++RsoG9bfPTo1NxWzxzDVus4u29L30qUZDROHMBajHiFsLi2HieQz6eXilcNDJ2/wGtN4FyjKagD2dKvIDBkPX1JroKASl4225hEyYT7CerYFMkQJgmFlgVBUT0cQWZ6ktnfmDUfvcr5A4kIW9AYXhGFuYFZA/+kLYn5asTkebBAjWdlKXcEodW4FE6wdiAjsFZgZkUhEFxDXWqEBRgUbKEcLfeNCEnyjUURIjYZ9m7Xx/6PIDBuBRZCr9mN/kylRT6LdpKIByTvphMFzHfL7VDPjxC3K2enQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUhe1fKmrOCcXqM988QzzLfbnzGujMmBF0il3JJYdtY=;
 b=vYuTwT5x8CyLm0UNl4kDNaFsMnRAUiuqJAdyrOgKnoHJqRIAg7yDEUuDDAlzkZ5FT0DPCK2UeJo9MkIau5STuU+xx8JmlWtVxeRX2c+Stkz8X4txE7fWUwSCYg9FdMBjef982HAg5H3Q4Ya2X/FJEXQgbvyxG47m5VVgABDQO1oMzGUh2mrrKHh9tVsdHl6sfumXVxqNM0K0INksh/+gc/dxqMI75dfPb4CqbDucx0kZzmQuyk8jbEGqPszIHkTa6sVb7Hw3STjOvpNzxAxoYOov8eV8Z+d7+ifpxL6uumC/ScHheAUEozMNKf+8IByETfiTlXgQRfPZEa0fbpBZyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUhe1fKmrOCcXqM988QzzLfbnzGujMmBF0il3JJYdtY=;
 b=dB/GID8WzQsyHo+0ANEzK71wFLQnZX3xZHsytLIGmz2bzFgmbBZHnr1Xb/LP0lBOwRg0z+fkt/9Kv686hF1HLk/oHZ8ruI74ln8yTiKFiek0dH5SIvQIzRhZq9pphAVq1+sNFlNXYqiHnGeT1cv5mj1cJf0vt48igJaJBgDqb80=
Received: from SJ2P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5da::7)
 by BL3PR12MB6475.namprd12.prod.outlook.com (2603:10b6:208:3bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 06:55:48 +0000
Received: from BY1PEPF0001AE18.namprd04.prod.outlook.com
 (2603:10b6:a03:5da:cafe::a6) by SJ2P220CA0010.outlook.office365.com
 (2603:10b6:a03:5da::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 06:55:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE18.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 06:55:47 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:55:47 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:55:46 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 00:55:38 -0600
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Harry VanZyllDeJong <hvanzyll@amd.com>, Ian Chen
 <ian.chen@amd.com>, Aric Cyr <aric.cyr@amd.com>, Chenyu Chen
 <chen-yu.chen@amd.com>
Subject: [PATCH 04/27] drm/amd/display: Reject Replay activation on an
 inactive link
Date: Wed, 25 Nov 2026 14:54:53 +0800
Message-ID: <20261125065631.3889665-5-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125065631.3889665-1-chen-yu.chen@amd.com>
References: <20261125065631.3889665-1-chen-yu.chen@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE18:EE_|BL3PR12MB6475:EE_
X-MS-Office365-Filtering-Correlation-Id: e749d1bb-c062-4302-1a58-08df4ac122a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|10067099003|56012099006|11063799006|261022105027099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 2i8MkL4bbzsuJus7M11mlz6DhhpZHX4JWCmwVqSvBS+61VwUFcjspnkJE/tbzeDniEL/retuG6lLXvGHhh4Ct4/HRAdj2RUEWwUJwC3AOOEJc8BGOX8PG8qyW3BDj9eXLsyiKrYdVnRfrHBqe/FpBoj+UXAxW3mMBJeFictf2aHamlsBYSxtmu45sciRbBuduxGWkrmqFpC47F6G05ULqyIgR9EZEDaVi0uinprdtD3q98RfzRbEls4M+j9LpgS8eN0q8VMUA0igWxyva5rddbzRcTVXgRdcrMHLxeKrilvE0l58P2G8WNM91nkQMkNOsaSBgkUf6neWgM2vA+54dREQp5soobqgJ1jrzF4ms87QxyG67Caxgn+IfsTTTiRcL2QjeA93jFaPQDXw6vaSALilMqLgbBa6x8Xt+u2CMbD5F3MnXUAV35njOl52UbWlmXWCwaOpJ71eGu70HHt6k6gIcNGFeYQIvN2i8Yu4jTJE68GEGX52vK5hGJllXtLtsTPrSnQyUEpyjnmPPGNFvfBcZmRTEwvkKZUAyNDFLhLt/U0T5BiRnRLixQXFiqkEO95jTLEfKKM+3rLemV2OPDpZ4GE/4Q5Q596gILUz6sDJbq2U9kNDGhd8pmVNtgI8Yy41GBYBGSGII5xPQsUYEoYEZAFUgFX2CtLw5vI/qB1Qp/CSkiHjYnYO0ivZmfSnlMAJA7G8KH5MDfMFZGhLEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(10067099003)(56012099006)(11063799006)(261022105027099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iwl29wWHdVl32hPaExZrqIhNGzYEFCPNDKgTVTGHEKZif0Th1WtNLo1n2z8U+XT7e/BNb1PCr37Ke/Myur9viDnW0Gj1ibxWOHZicwgqArY7BXmnw6tirUS4S/oqPYTqP+qEXiIqsr/Ub58BoUy21G18yiEXdaz9uP67GcKJg0o6sj00yvNzeAZejcJWEZmc2ouR5EmQ0CfhAseE9FnyyRRpqeCc2bBvHVjdTwKg7CzJ/CycFGJX3s16g5Kvg5l92KL6D2qKq/60y9l6wAT2f6zsmbqnmzzLMyhyF9EkuER29ikh/CcNo3QOQ3HMijEgborI3ooGXZRmXdtAI3ZGWGA7fFDPZewTxLq+lbvBAwVGZxlNtFZp+xekx4Tlw1SGmO0X/HOfVwmKDaQh/NIh9c5cGSfSAK2MgTaxW0H3sCHuNWYoVH0cIlpcxhFZFmEW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 06:55:47.9025 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e749d1bb-c062-4302-1a58-08df4ac122a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE18.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6475
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Harry VanZyllDeJong <hvanzyll@amd.com>

[Why]
Replay can attempt PHY power management on an untrained link with no
frontend connected to its backend. The resulting ALPM handshake can
stall firmware and block display recovery.

[How]
Reject Replay enable requests while the link is inactive without
blocking disable requests.

Cc: Ian Chen <ian.chen@amd.com>
Cc: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Harry VanZyllDeJong <hvanzyll@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../amd/display/dc/link/protocols/link_edp_panel_control.c  | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 0e9b2b675eac..3f8063f6f06c 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -956,6 +956,12 @@ bool edp_set_replay_allow_active(struct dc_link *link, const bool *allow_active,
 		}
 	}
 
+	/* Replay drives the PHY/ALPM and hangs DMCUB if the link was never trained,
+	 * e.g. on the GPU that does not own the panel after a mux switch.
+	 */
+	if (allow_active && *allow_active && !link->link_status.link_active)
+		return false;
+
 	/* Activate or deactivate Replay */
 	if (allow_active && link->replay_settings.replay_allow_active != *allow_active) {
 		// TODO: Handle mux change case if force_static is set
-- 
2.43.0

