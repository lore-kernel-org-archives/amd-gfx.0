Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A36CF9C7C
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 18:18:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19BC910E7B2;
	Thu, 20 Nov 2025 18:18:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z64N+YNR";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012022.outbound.protection.outlook.com [40.107.209.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB52410E7B2
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 18:18:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wNpYipYrZpnVWVdC4ORleryDWNF3zSjmanqpuz5skD+AQruSkgkwJukOVwWJi8rvNKDMy2pArEBja+LtNwskFwq2oyAnZ6ToXFv47BIX0vY8UsYuCOhKqd4Y4EQH71mAusM58Dalt9nGxV1cKcRGY0/G2DY2HJqstAEFXZL4+oaXLhGEMoDjl+fbaBoQRdHe7vp4aB5F06ucxgol5JVHqwzn4Xme1WCN2qVRsmLEGwh6v3GBDD0r/1rPNwTWr7G00CHjk7hH6CXp+3UnU3oS3Wdjq4rdJV0Hkb0q3YEL5efbFmb0YpyFgJfCiPQ/oNKmlo9G7tnoI672Ob5OJcU7bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/EHq6JIKW7xDG3bCp4VKAf/fdzj+NwWqwgwojdfqYU=;
 b=q6dE3ch0RQEnRfnD9+mua9tW0nAI1uMfdjbLgeEPGM1JHJhlpZZJgr2M845EGh+2f2ObRUyXTMfA5RfontvmhQfpjoWCpL0tuENuGwbZf738E24Qixo//A5kIXtfSmZb1ivjJTvYrqbE3XLhL83474tJ2hcMpkiCI0tcFNDsWXoOE5iYZiWXPCZSbz+AOoqIsG4sugF84fpUApO2I5gUDHuBy9AZuBB/jqBJk3eP9bo5KR9SeWVj7MEjuWiznC1QgGfvexiXIivvjSpGSFXmmnl/2C2rozvpoIQ2zqp0qPCVuZ9L/kGuITLIJOrnWKtETeCWVi5R4t+xxjTbvwXlsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/EHq6JIKW7xDG3bCp4VKAf/fdzj+NwWqwgwojdfqYU=;
 b=z64N+YNRWQ4c8X+fqDcIjlLOohsEhGExxqION3/iwtM87AYlmE3l4psUWeR97w39K0nhznObuWn/maXByjrMRjV+A2Hi4pc8RufmNFAomh6Hi+ymD6qDy8TuGk/OeQ5fZynjW3NJfydLABxj0b3xDYm32e8NV/zsKHh+54N1d18=
Received: from DM6PR02CA0083.namprd02.prod.outlook.com (2603:10b6:5:1f4::24)
 by DM6PR12MB4041.namprd12.prod.outlook.com (2603:10b6:5:210::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 18:18:52 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:5:1f4:cafe::78) by DM6PR02CA0083.outlook.office365.com
 (2603:10b6:5:1f4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 18:18:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 18:18:52 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 10:18:50 -0800
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Jack Chang <jack.chang@amd.com>, Robin Chen
 <robin.chen@amd.com>
Subject: [PATCH 08/26] drm/amd/display: Refactor panel replay dc libs
Date: Thu, 20 Nov 2025 11:03:04 -0700
Message-ID: <20251120181527.317107-9-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120181527.317107-1-alex.hung@amd.com>
References: <20251120181527.317107-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|DM6PR12MB4041:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ce46faa-bc23-49ea-a6e4-08de2861426b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4kTA4eHsL8tb0MnrhhefxGPU+/cqMNxGp3LZDeYiZ4VeWw0JK8zT1HKklqCY?=
 =?us-ascii?Q?EstAu0B7FJ8BJgnO98ifO1JkujeKaTvqIIf3tGis3tSEPWi5XHxdF6YzsB6D?=
 =?us-ascii?Q?6cqkfGluatfTSBvCIwB92+0aCROt1YVg2kYR6yWS2ByFD1X1X02/jGNx/Bd7?=
 =?us-ascii?Q?PWhYh6j2W5+fWo/DrA1LWW0+e/xyNwOd4HvlEbU0J7Ich0hVlQluGPSf0noP?=
 =?us-ascii?Q?F5csZtv9dDLgL+SbRSaAK7tfpkfxzNUddJtqsQzHvciViEytG1JJwl0heSjT?=
 =?us-ascii?Q?uVvGFFhNFRTYkhZdTeVQozZhiqGHTJJOuZT0InTEbi2jxsB9E9uFdnzO4niT?=
 =?us-ascii?Q?UQ6SWUQfKjwO3cb+FxDHxXMZC5e1DuzpUVvuWMaO1WxnIX7dpi18h5u+IqCT?=
 =?us-ascii?Q?ICK8YBMuswNdCbtjmm68Anv8lxX4i61bcs/x8D3WFnag2NM+jn3nNjbFbpLE?=
 =?us-ascii?Q?OHOT2l1xBzhzHnti5ekAB+/RJyOtshm6rMmYwqrn9HkjTuHjV3u8BzK8sPnH?=
 =?us-ascii?Q?ZkHYjqsryk1hsgt5SRnYwbAnG6MLqobzBEL+QyfqVVPE/LHcjhhPNfaHNyCC?=
 =?us-ascii?Q?8eEMT1IDpuK2u9YbZfPoQq/ZfYojh4AtZaobMv6WvbSKRKsIVTtYBhcGnzU7?=
 =?us-ascii?Q?5wDoQKQni8NS4d6SGGfOLHH7jlqA3sVT73zCVrDLAjyZienzjOkqdFuPnM0K?=
 =?us-ascii?Q?JWjAgUroANf6bfaE5kRNN1ytpBwiMNA+ttPbMhlx5SOZG3UUquTwmuFl2Fqi?=
 =?us-ascii?Q?zW3mhY2eACl8RsDdR3+M1u3wxiGL8J5DJQYAyEGm39+E3gNOhFsEg0vvGjlr?=
 =?us-ascii?Q?1v8yv/hqzX8TU4xeH6fUb3nozImQdeGvcRw0+zEwSCP2K9IgKZM1AHXtUVBa?=
 =?us-ascii?Q?LJkFxjNzNBpJL6T2y0E0GtkFFmAdQY9XaSZPf7XvbKTeBecJH22/HiK2Y0Xf?=
 =?us-ascii?Q?weKUfvVILJyHQOYdhXPJw3NiLeXDqYOW++XKZgSNQq6thAF8LU3wzyrgRVqM?=
 =?us-ascii?Q?JRBIxMLC2uoShHOtZiyCN8wfVctmshCaHTbj0uYjApOn/ZTHf0xi7Wpn4FVp?=
 =?us-ascii?Q?GlPCSY0NuysKabrXX1qTpjjWBhgPtB+nuJGt5g0WhCaGl7zZ3xtBlNV3lQ5A?=
 =?us-ascii?Q?mOBeOL3Bxk12Tb6DXdvy1qme4poMMkYRkwVI2Gf4jm7lwM5JodVndQaN3Dl/?=
 =?us-ascii?Q?PJlxb+wpTRpwK7z+urdx+ErkjdIysClhbntEb4DcL24sXMYaajHi/jDJbf5H?=
 =?us-ascii?Q?0yJEbfrfM77PTqYoBqcJo+zFAwiPdJWn02jpElGEEnV4TEpHBnrsxgc7ZTjI?=
 =?us-ascii?Q?altA2lD6pP5aX4OAeo28O0wRVpH7KMt+4M5wd6c+koqQ6DlX+OdNQEAlSXcS?=
 =?us-ascii?Q?+FWksYVCDI4WSKphI7IKeucfuIXU6LmtNfl+daN6iEDq89WFRDRPsHqj8H66?=
 =?us-ascii?Q?KcnOrsQmK155btvUx2HZ2HdGHjiRnyyg8hm/qCo3kG3rE/y/ivsvAHo2WvU3?=
 =?us-ascii?Q?zv5ZWnVmlWFYIioXczIfzefmJnwGxz1VJp2ctV326EjiGPAQ79DiEzWTCrM0?=
 =?us-ascii?Q?x3UusGfk9fb/fx7JQvQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 18:18:52.3759 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce46faa-bc23-49ea-a6e4-08de2861426b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4041
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

From: Jack Chang <jack.chang@amd.com>

[WHY]
Add dc interface to export link service libs for setting PR dmub command.

Reviewed-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: Jack Chang <jack.chang@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../drm/amd/display/dc/core/dc_link_exports.c | 22 ++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           | 42 +++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
index 9acd30019717..a8d7228907c2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
@@ -491,6 +491,28 @@ bool dc_link_get_replay_state(const struct dc_link *link, uint64_t *state)
 	return link->dc->link_srv->edp_get_replay_state(link, state);
 }
 
+bool dc_link_set_pr_enable(struct dc_link *link, bool enable)
+{
+	return link->dc->link_srv->edp_pr_enable(link, enable);
+}
+
+bool dc_link_update_pr_state(struct dc_link *link,
+		struct dmub_cmd_pr_update_state_data *update_state_data)
+{
+	return link->dc->link_srv->edp_pr_update_state(link, update_state_data);
+}
+
+bool dc_link_set_pr_general_cmd(struct dc_link *link,
+		struct dmub_cmd_pr_general_cmd_data *general_cmd_data)
+{
+	return link->dc->link_srv->edp_pr_set_general_cmd(link, general_cmd_data);
+}
+
+bool dc_link_get_pr_state(const struct dc_link *link, uint64_t *state)
+{
+	return link->dc->link_srv->edp_pr_get_state(link, state);
+}
+
 bool dc_link_wait_for_t12(struct dc_link *link)
 {
 	return link->dc->link_srv->edp_wait_for_t12(link);
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 4205f896aadc..a1fb5ed653a9 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2455,6 +2455,48 @@ bool dc_link_set_replay_allow_active(struct dc_link *dc_link, const bool *enable
 
 bool dc_link_get_replay_state(const struct dc_link *dc_link, uint64_t *state);
 
+/*
+ * Enable or disable Panel Replay on the specified link:
+ *
+ * @link: pointer to the dc_link struct instance
+ * @enable: enable or disable Panel Replay
+ *
+ * return: true if successful, false otherwise
+ */
+bool dc_link_set_pr_enable(struct dc_link *link, bool enable);
+
+/*
+ * Update Panel Replay state parameters:
+ *
+ * @link: pointer to the dc_link struct instance
+ * @update_state_data: pointer to state update data structure
+ *
+ * return: true if successful, false otherwise
+ */
+bool dc_link_update_pr_state(struct dc_link *link,
+		struct dmub_cmd_pr_update_state_data *update_state_data);
+
+/*
+ * Send general command to Panel Replay firmware:
+ *
+ * @link: pointer to the dc_link struct instance
+ * @general_cmd_data: pointer to general command data structure
+ *
+ * return: true if successful, false otherwise
+ */
+bool dc_link_set_pr_general_cmd(struct dc_link *link,
+		struct dmub_cmd_pr_general_cmd_data *general_cmd_data);
+
+/*
+ * Get Panel Replay state:
+ *
+ * @link: pointer to the dc_link struct instance
+ * @state: pointer to store the Panel Replay state
+ *
+ * return: true if successful, false otherwise
+ */
+bool dc_link_get_pr_state(const struct dc_link *link, uint64_t *state);
+
 /* On eDP links this function call will stall until T12 has elapsed.
  * If the panel is not in power off state, this function will return
  * immediately.
-- 
2.43.0

