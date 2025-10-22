Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D55BACCD1AB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 07:34:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ABBF10E6FD;
	Wed, 22 Oct 2025 07:34:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IoVHJniW";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013009.outbound.protection.outlook.com
 [40.93.201.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9937D10E6FD
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 07:34:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BrVT9ahunvwbISOVuPjcij75nHELxpYBdTUhuRfZn17v8Gnc3RPAcZ0xWzfvZQsv6QIFSHPehhvRXIZcaFav05dc9ZfxiNZQmqJU0meo30PIgozKVnrjr8Y/IJBYzE5cK+dxXHx+TbOs2ue5TyQXKuvg74faG5fQGWJ5xoW+i6AJtZN0Pqwdf+YGLNFF+72/DknEywXzP44qxJ7BpspmKWJrADR4Lrl+QfiVHUfe0hZu4VB2ZDPBTqLiVL7FvZudmfXLVmNxQk/pfDSMqQbe5K7ISO4ft6r8GToSJvjWN3O1C8gdxa6dpMja4gRZPmApWARAkrwNEWxerBK14Hhd7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+EGrzad4OJPgukEc+jJSnH4aVKwAr8miFV3BDf4RsRM=;
 b=KbY2XQvLjkgv+d9tWBRROZ7qpO1UM+F4IADcoqZ4D0sNTYJJmoxSD3U4zI9hSeQQT73ipYZahkjSE0BDUFHxRD6ZVZL5ITLuRBdREMrSR0D8cYDwj7g8D3PfdqsqH6+GeOsh4yZUvQNjrD1UorjoeuqC7na/rWLarxOCOysqiaJ956o++jKVtNZTnpWWsZe30l/uG7/5njZS2ht0hAgaAweWHCl75ReiSrQ6TNaMJ/nyLCLhdoGiL54WBJXgCe1WVyW1KK6tRdJI8+BKG69vt3ukyrHZWEKy5ZBs1F/i2Y5eQG5ZMVvUB2Y5KCGexFWPhcCi3RptAhHH2XGoKVtEEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+EGrzad4OJPgukEc+jJSnH4aVKwAr8miFV3BDf4RsRM=;
 b=IoVHJniWuw8iJoWlKWYMRRDQiatS76KUquHjQeWwJNFqN0uTfb11/Wa1WmIftCz6u8dIfCMSbpEasbwGQKiyVW/O0d9Z49mcfA4Qb2Uc3Wb0LApUAoQkDP6Ko5emXcX+Mc1sBCe5/mXO8kLjhNCgS1bKfsKjlRFgIH9mjjqymZs=
Received: from DS7PR07CA0012.namprd07.prod.outlook.com (2603:10b6:5:3af::20)
 by LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 07:34:48 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:3af:cafe::b6) by DS7PR07CA0012.outlook.office365.com
 (2603:10b6:5:3af::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 07:34:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 07:34:48 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 00:34:47 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 00:34:47 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 22 Oct 2025 00:34:44 -0700
From: waynelin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Meenakshikumar Somasundaram
 <meenakshikumar.somasundaram@amd.com>, PeiChen Huang <peichen.huang@amd.com>
Subject: [PATCH 10/20] drm/amd/display: update link encoder assignment
Date: Wed, 22 Oct 2025 15:30:22 +0800
Message-ID: <20251022073332.666119-11-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022073332.666119-1-Wayne.Lin@amd.com>
References: <20251022073332.666119-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|LV8PR12MB9207:EE_
X-MS-Office365-Filtering-Correlation-Id: 1957ec0a-9733-4539-95c2-08de113d7aa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OfM0jlaikCoRJ1ER06RmEjf0wXVA7qJeTwxeJSei2pRq8jmbMVoL4TpnaUWP?=
 =?us-ascii?Q?8Y0iUlQ2NADTHxfwBcmwE3HKoP/ZF9JueGKarDrwQkfmV6va3YpNUCXKkgYs?=
 =?us-ascii?Q?3M+DImpKt0Lsg3wZgcJ0syaSRLBLA0l76ArEJlNrqHGJeADvFzQ+Dz0CQh5n?=
 =?us-ascii?Q?nAkxBpEVcifEKx6yVKalicmKjz7/l0lbRXUFqT15tuMt0uqTgI4MvZkzbti1?=
 =?us-ascii?Q?+7g7b2vue87IJnbgm7wprfb7JogV26FWUvPEdhcJupxcvNFOEnnufMY6HP6b?=
 =?us-ascii?Q?WRESISzYWgL+lMO9Qao0yK5/kXUkewYX8fSei1hF/rRyqjCmN2k9Zh+g/hqR?=
 =?us-ascii?Q?mxjhbAgFoZHWLSwHzTmQXeoYcfeSptJqbQ/m/9lC5zhU7nLFqXwqyYjVp5R7?=
 =?us-ascii?Q?HSP2otn48FlPXAOBkmSk8oyYUS7C545tGNMSHWsGbh9oa3ckyU87w8YgHOQi?=
 =?us-ascii?Q?EgN4CfbX3cUTUehgl+aoJBRXdL4lD1H+NsSZczUaS872qHREU9kt/0Dq95xM?=
 =?us-ascii?Q?tV7Tl7c3Qh87AdBezOXpGfsAI3B74qc0u02kJJP3TDJrah6zSOpnO3zFvHxh?=
 =?us-ascii?Q?xyNf0cobPTZrgUjOyEtCClCM+Ong33ggOLLh4XMqRLT/UwewsiJr34mP/fAK?=
 =?us-ascii?Q?D8183Ko3CADWAuAJYsa6JeJiP5wMxDVNcuJ3JgYtoUfQVAfT3+v+T4Tj2/mL?=
 =?us-ascii?Q?T9ML8KFV4WstoQQBzaRKbEAWjBe4d8ptQWVPGHoZUxdYckYtmTC/h/w72Giz?=
 =?us-ascii?Q?w2+em3FrxeJAS9zW8IamPPKT/SMUm+ziLWMJ1T61FpPW5fnZTLh+e4cZwh4F?=
 =?us-ascii?Q?mrHl3eY1vK5UqOEU6sOnx1t8fr//gbv3K9K7WE0lpETba+lYmVFw5UY2pI9y?=
 =?us-ascii?Q?KR4wu82Df/kO8v7GvhwnR4XKqR6Yx0er8IPsxxUoh0RJkpGUBOrRSFNR0rMR?=
 =?us-ascii?Q?YnPkrYBo/tHiGx6F3j95/av/OQKZOyKy5bOscStXzFfFHoTLU+uYGIE1EC8B?=
 =?us-ascii?Q?+QXn0ppcg3NFICaHd/hySqaVpR8SgeGH6X8KC2RKwn8EV1miacBdI8LGpusB?=
 =?us-ascii?Q?N6mRYkwHbwhPl7n96ENCUs9/tFU7Nm1LmviV6QXd2aJdLM33Hd5xt86tUnHm?=
 =?us-ascii?Q?HspufosVnkcx6cE6V08f309Gnh9CiQzqBnS6QJmdAZSWncO3W43tIk3mylPJ?=
 =?us-ascii?Q?9oqQ1FVynZR0CKgDLFVZzKTlzyjhCTbeikwVE/LgnD2NlXImS8PcYAfnZWsk?=
 =?us-ascii?Q?WqM8w7j2PaW4uOUFUYKtTnAkmOaP6Gtnyu7gPf3YuG98s6s6272b+lCe7CPU?=
 =?us-ascii?Q?oPmJ2NknwSNizdCVZ0S1ZruJVa1rGWgqA30AFoPBWvmOCzevmPJ64oH9MDl2?=
 =?us-ascii?Q?bPB/TUjAPc4UeTkvEs2aoJ/s1nQXAF6a3zQdprUFJhRDb1fyi77erdx4KrE8?=
 =?us-ascii?Q?9SaspS7294zcL3Fs3TGPdPwrVyXInw/lPEk0VfwChs48VnPc9AnqiWRzpRCo?=
 =?us-ascii?Q?fz6gynt26bxoiGicx/Mvsc9+V1IQ/1hDIe3xDSm1724HseLdqhSvBv2kUvl1?=
 =?us-ascii?Q?Xh6hJTaLG6VC/bavOa2ZbaFwIZXcsirxbiTYYdVe?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:34:48.0405 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1957ec0a-9733-4539-95c2-08de113d7aa0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9207
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

From: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>

[Why]
Map a link encoder instance matching stream encoder instance
if possible.

[How]
Get the stream encoder instance and assign the same link
encoder instance if available.

Reviewed-by: PeiChen Huang <peichen.huang@amd.com>
Signed-off-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 43 ++++++++++++++-----
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 8d0cdbf14e17..89fe72820f6a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2690,17 +2690,40 @@ static inline int find_fixed_dio_link_enc(const struct dc_link *link)
 }
 
 static inline int find_free_dio_link_enc(const struct resource_context *res_ctx,
-		const struct dc_link *link, const struct resource_pool *pool)
+		const struct dc_link *link, const struct resource_pool *pool, struct dc_stream_state *stream)
 {
-	int i;
+	int i, j = -1;
+	int stream_enc_inst = -1;
 	int enc_count = pool->dig_link_enc_count;
 
-	/* for dpia, check preferred encoder first and then the next one */
-	for (i = 0; i < enc_count; i++)
-		if (res_ctx->dio_link_enc_ref_cnts[(link->dpia_preferred_eng_id + i) % enc_count] == 0)
-			break;
+	/* Find stream encoder instance for the stream */
+	if (stream) {
+		for (i = 0; i < pool->pipe_count; i++) {
+			if ((res_ctx->pipe_ctx[i].stream == stream) &&
+				(res_ctx->pipe_ctx[i].stream_res.stream_enc != NULL)) {
+				stream_enc_inst = res_ctx->pipe_ctx[i].stream_res.stream_enc->id;
+				break;
+			}
+		}
+	}
 
-	return (i >= 0 && i < enc_count) ? (link->dpia_preferred_eng_id + i) % enc_count : -1;
+	/* Assign dpia preferred > stream enc instance > available */
+	for (i = 0; i < enc_count; i++) {
+		if (res_ctx->dio_link_enc_ref_cnts[i] == 0) {
+			if (j == -1)
+				j = i;
+
+			if (link->dpia_preferred_eng_id == i) {
+				j = i;
+				break;
+			}
+
+			if (stream_enc_inst == i) {
+				j = stream_enc_inst;
+			}
+		}
+	}
+	return j;
 }
 
 static inline void acquire_dio_link_enc(
@@ -2781,7 +2804,7 @@ static bool add_dio_link_enc_to_ctx(const struct dc *dc,
 		retain_dio_link_enc(res_ctx, enc_index);
 	} else {
 		if (stream->link->is_dig_mapping_flexible)
-			enc_index = find_free_dio_link_enc(res_ctx, stream->link, pool);
+			enc_index = find_free_dio_link_enc(res_ctx, stream->link, pool, stream);
 		else {
 			int link_index = 0;
 
@@ -2791,7 +2814,7 @@ static bool add_dio_link_enc_to_ctx(const struct dc *dc,
 			 * one into the acquiring link.
 			 */
 			if (enc_index >= 0 && is_dio_enc_acquired_by_other_link(stream->link, enc_index, &link_index)) {
-				int new_enc_index = find_free_dio_link_enc(res_ctx, dc->links[link_index], pool);
+				int new_enc_index = find_free_dio_link_enc(res_ctx, dc->links[link_index], pool, stream);
 
 				if (new_enc_index >= 0)
 					swap_dio_link_enc_to_muxable_ctx(context, pool, new_enc_index, enc_index);
@@ -5201,7 +5224,7 @@ struct link_encoder *get_temp_dio_link_enc(
 		enc_index = link->eng_id;
 
 	if (enc_index < 0)
-		enc_index = find_free_dio_link_enc(res_ctx, link, pool);
+		enc_index = find_free_dio_link_enc(res_ctx, link, pool, NULL);
 
 	if (enc_index >= 0)
 		link_enc = pool->link_encoders[enc_index];
-- 
2.43.0

