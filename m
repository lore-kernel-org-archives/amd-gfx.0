Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD80C5478C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 18:43:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A291610E487;
	Wed, 28 Feb 2024 18:43:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OWnG+1k9";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2079.outbound.protection.outlook.com [40.107.100.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4031910E490
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 18:43:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHSsTPGbFOvZ2y9fD2rdri+7d7Ecb2LISBlLfaY/Nv3ZwGJgbp3fgft09+UfD5CaCpYTTdaLrpLTZdh6y/4SlATMZh+5G9ICwbMQBrKEgA04BVEt0BUG+N+CeqYT+bi79Yborh8TfVAwQovU0+lRhRWQYpaunWXiiPrSnqK25stoKHzKJ42NUlB11R4i1hYGU0EU9YNt8zsYrGOxrdBZvfe/j8qytD+2hxYjB91Tz/ah48hiJA8xpqvzXmAc08y6QS6uXNFoxG/2180wOpaoouzHZ7XQMtdapF/1hxpJkLvkr+2e29AdBzEsbWWW0GCEG8CsFsmBjCntKIXC+AH/8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RSWNbv0RYtWSMl1Fh95kZJO8A7bq6kMSJM0osiWzho=;
 b=O6EiLEmqGu8jqqO2wd+FO5JHlwZGwWzNDerKoDjVgCC1g+vCsBxwZ8/i7XYk5TaOqct3lLD3zCZntUmSkRz56olgEvPZFY0Yti/i093oVw0Q6wnvPQUbbxsvng8P2xwYGRVEterIfFjrXo4nn/WgmQGVJ6ciUhXjML5MxkPjR4Tey2oupitudfuHD1KJ9rFCpZeuN1eyJoPimKE5EACME090tM4g8B3a1dIcKat7TQCbRf5CLA87Q1T+VY3TtJd7lh5WTuP+C/NBI4aaLLFAlIu9g1sr7hUf3bFi84FsFN4NgzKuvH8qYYxzNtI7WvT9iEkZUJjwJzlVZkNLMeX/iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RSWNbv0RYtWSMl1Fh95kZJO8A7bq6kMSJM0osiWzho=;
 b=OWnG+1k9+uoQxzeQXN21YKOUv4ojrjuK4tyrYA6oiCGMz9iypvqU5tJ9+fdibMXYSNbyqgzipcDrQyoegwgmtBt6B7w47ZptZHgyUGlRU61DJdAVLnBBFwuYxLim/6vanDiQlHzFHGJfn0pXDKmkWb3IZPQ0RK/DX5F2kKdkiY8=
Received: from CH2PR12CA0014.namprd12.prod.outlook.com (2603:10b6:610:57::24)
 by SN7PR12MB7023.namprd12.prod.outlook.com (2603:10b6:806:260::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 18:43:16 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:610:57:cafe::53) by CH2PR12CA0014.outlook.office365.com
 (2603:10b6:610:57::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.50 via Frontend
 Transport; Wed, 28 Feb 2024 18:43:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.82) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 18:43:15 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 12:43:13 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, <stable@vger.kernel.org>, "Charlene
 Liu" <charlene.liu@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 11/34] drm/amd/display: Exit idle optimizations before HDCP
 execution
Date: Wed, 28 Feb 2024 11:39:17 -0700
Message-ID: <20240228183940.1883742-12-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228183940.1883742-1-alex.hung@amd.com>
References: <20240228183940.1883742-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|SN7PR12MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b01ec14-ed61-4b97-49f9-08dc388d2004
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T7dYv37Dbjwv7SyRMrBfQ/nhFEVH2Lp+GWzC9gSpUORJlqWitYXuhgLRYRcTXODOf4NP4fstePJLfEdyttuOSwA0HGRU+W7YnnYTh9YMnKeKh89kncDh/huBRJji6I5CpJqE25BStDmuu5Kgf043amba5h9emo+v0wexVvrX+ZgxkLgcBCUhK+oXCjcDxiwJortcGTBGhXoUG8OJ18yAidXYcUViFCdOCUbu76hreuSOjlukL30GbqAcst6iEUF4vF2t7obJVhdKjlmZ0jr1nJOgZ7dFwlGLqfsA4++71gpG+UbZhN6XQUkPKFq/mroRerniC54QwxTRYfCho6pE/jAFjKcEcX/7ftf419Rdv6N1pKUqncqeV2aKgBw08eDvgRjSzZHij9q5vB4B1+GTa1eN2aQWeHyA9/5dEv8qSHmyhTPzw1k+cGIBloUpyCys3gFTBSlnKOwFMK1z+MhdC7MLcOcQAvWbJ5smWUNzUuqkmMNIYqXhKXAeZM8v1ie6LEHqwI6SQWNHTx1eZdHMKoBaM+CIP6oUhkTPfCjW6Bl0pOdc6qsFCzM9fuepBhU1Okr1C0rhCZhb7Zq8i1162x69FyGpG98pcvoyK4RLITTuKAhIplhw2g/n5bzdJNtV2yIxt8Wugtrc8ycalA52Bq/luL2HmIRRMsnF/4C1FYEn6WbRR4awug6ruiphlYESdsbNCIBtt+RcYyUL9q55bdSJRNDUznGLYZsWFBnCTHkdEbol9nuFgKCtO5mA1l5X
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 18:43:15.7370 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b01ec14-ed61-4b97-49f9-08dc388d2004
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7023
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

[WHY]
PSP can access DCN registers during command submission and we need
to ensure that DCN is not in PG before doing so.

[HOW]
Add a callback to DM to lock and notify DC for idle optimization exit.
It can't be DC directly because of a potential race condition with the
link protection thread and the rest of DM operation.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c    | 10 ++++++++++
 drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
index 5e01c6e24cbc..9a5a1726acaf 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
@@ -88,6 +88,14 @@ static uint8_t is_cp_desired_hdcp2(struct mod_hdcp *hdcp)
 			!hdcp->connection.is_hdcp2_revoked;
 }
 
+static void exit_idle_optimizations(struct mod_hdcp *hdcp)
+{
+	struct mod_hdcp_dm *dm = &hdcp->config.dm;
+
+	if (dm->funcs.exit_idle_optimizations)
+		dm->funcs.exit_idle_optimizations(dm->handle);
+}
+
 static enum mod_hdcp_status execution(struct mod_hdcp *hdcp,
 		struct mod_hdcp_event_context *event_ctx,
 		union mod_hdcp_transition_input *input)
@@ -543,6 +551,8 @@ enum mod_hdcp_status mod_hdcp_process_event(struct mod_hdcp *hdcp,
 	memset(&event_ctx, 0, sizeof(struct mod_hdcp_event_context));
 	event_ctx.event = event;
 
+	exit_idle_optimizations(hdcp);
+
 	/* execute and transition */
 	exec_status = execution(hdcp, &event_ctx, &hdcp->auth.trans_input);
 	trans_status = transition(
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
index a4d344a4db9e..cdb17b093f2b 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
@@ -156,6 +156,13 @@ struct mod_hdcp_ddc {
 	} funcs;
 };
 
+struct mod_hdcp_dm {
+	void *handle;
+	struct {
+		void (*exit_idle_optimizations)(void *handle);
+	} funcs;
+};
+
 struct mod_hdcp_psp {
 	void *handle;
 	void *funcs;
@@ -272,6 +279,7 @@ struct mod_hdcp_display_query {
 struct mod_hdcp_config {
 	struct mod_hdcp_psp psp;
 	struct mod_hdcp_ddc ddc;
+	struct mod_hdcp_dm dm;
 	uint8_t index;
 };
 
-- 
2.34.1

