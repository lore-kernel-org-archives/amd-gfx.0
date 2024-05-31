Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C00C25B7E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 16:52:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C18B10E4AA;
	Fri, 31 May 2024 16:52:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OOH73SIT";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73D8B10E536
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 16:52:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ge8+kGgFTeclc1UPs9TbUkCQ8jm1HM8HzuGq0sq4ocDUUM0H2SbPTq6R+E8HpXc9/KzvMzi1yEg88gsrqYO2Z29BC5PnoyqH7xy4afMLGQ3d1lGF8N+2u/v70oV64nrq2pNnDynnI3eWnneeOc0Qb0u1FShoWjj4NqRPeGj9wQlItwKIMQ6gbZlkQMaW4g8b3BFJN8iFndmDiXQHtZ+pv4EJC1k3mvSywIYInnYaptMv1tdD/tYRP+UHfTKaqcQXyL0wkPWfyXdT1JW+hXwhdtFJWfRBHEnHdI5RE1WqEVvDmKRNjpEKdVUcRFBBMfo+t1ofeshGMer0zcbsFqL20Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jW2xtIu9OjKRQRD1WUUwspqA6ZEq7GqfVtS/7br5HpM=;
 b=oeZkukTfZwhk1911Yzpn1Ype9j6EBcKevHPKXqp1fMSddE7ljiDTCVKx+63p2fezWuuUoQdPcq32HNa3TvnONBgTNtrZropr9vYHWHG5scQlyEALsVr0MfgiEuUXucXGTKUd5ifPU3FYjyO5ioPeO+qZYSWUJgv5XD7nXOAv5rTjgqtwuhlbI9mluSV8LsqfpqNZwrpcqKHRjlUri6TJulRfQVvoJ7F9O52E+eckoZx6wU5Zv0qrnRDc/PX2mqLjEiLnVzi/wPGhwRmIK4F2wlOEx4jwrVb3KA7WdWZmN7W7JjeUgZ/K8LzB4nGXloQAsDQqAoqO2S6Z5Yht+dkNLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jW2xtIu9OjKRQRD1WUUwspqA6ZEq7GqfVtS/7br5HpM=;
 b=OOH73SITLSV1G6iBJetBoRpXRRLXU2Fnefx/atn+KzO8MBe7kKn4psptE7ZCP04lFta4daPElSankevjti/8n8vea4WKtuzPv3dO2qV1G1bo1yvv4ImvZ3kM9xs5uL4HUcey6GBk0xeu1/4m/cplyxYAe9rog7sPAlrYmWE5ePE=
Received: from PH7PR10CA0023.namprd10.prod.outlook.com (2603:10b6:510:23d::21)
 by IA0PR12MB8693.namprd12.prod.outlook.com (2603:10b6:208:48e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Fri, 31 May
 2024 16:52:35 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::1) by PH7PR10CA0023.outlook.office365.com
 (2603:10b6:510:23d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22 via Frontend
 Transport; Fri, 31 May 2024 16:52:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 16:52:35 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 11:52:31 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Samson Tam
 <samson.tam@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 10/32] drm/amd/display: Only program P-State force if pipe
 config changed
Date: Fri, 31 May 2024 12:51:23 -0400
Message-ID: <20240531165145.1874966-11-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
References: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|IA0PR12MB8693:EE_
X-MS-Office365-Filtering-Correlation-Id: d27936e0-cf68-4616-76e5-08dc81921270
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+3KjEEIBEgd9J8HKU7/eIBJXAtpzwtMNIapXb1eG31atSGJB2VyCJfNWK94A?=
 =?us-ascii?Q?fqIA6CMzzBnwgm/b8pBilYMoDlXp0OW/JuOPbJppGmGxPfkOKkkrN4jURi2D?=
 =?us-ascii?Q?ruLqf5FXmoIK+LnMJskeR4EHQs7RfJbyU+yuzIcvFIzkcqkTHkPZszFwhLDs?=
 =?us-ascii?Q?lYvpssN6Ak0rmSz3xPbE2oOLCXYG1dJF6u4fOGMU1VWWstrfInwOegAZsU9g?=
 =?us-ascii?Q?CGmx9jehhd+4uwekjK92efiDPwNwkxN7PLHCnmGSF1cpBhQupmFbq4ybPxjV?=
 =?us-ascii?Q?HLoydE1AAvtXPAYtPlPhpPzilTQlUAUE/ksqUl9rLnI+lwwKAQcxyBVLRoPK?=
 =?us-ascii?Q?Ah6P+3grqTBzaZt6wQ5t15xDI2v7MbVZ8zi7jYFuKudm3GvRVja4lMCXfr/f?=
 =?us-ascii?Q?1NaxePebMU5Bwz4ruey6rBgIJC7FNihAYryXot62eIlPi9BZBw77TQp7jsEJ?=
 =?us-ascii?Q?/LbQ8AGaOrcnZ5IrEo2WOs7q69YXilwDbA1r0+B2nKH13o2AABAbpSWn/pU5?=
 =?us-ascii?Q?Wx/0a3swVWvCfTye3yv/lY/n8d5gA5xWdeh9ArD5r/abYjiO0EW0UzTxk2db?=
 =?us-ascii?Q?WIZJI5OL285x/KRt81GtCulDpJ/3W0FqWaDhFUveYNJIbTnPRcwKtaDiEIFO?=
 =?us-ascii?Q?3tOYyNl4eo+0mH3DjGUIozPMGdMrncg3b2AoWKJbXxJLtQ20LDc9hqJaKiBu?=
 =?us-ascii?Q?26sclVLJLgnrcOOwWZOVW20kIS6rqZI2voNHh1dHvjbcr3f6ykAM4roQzySu?=
 =?us-ascii?Q?cPzYrSoin3CJEMh7bACzbHBwHvjn8LSH/jI8WdirbjFA492SRuB49weD3cTr?=
 =?us-ascii?Q?mf0GNANihss2Hy+tXaaf/UEapvskQkeb0klWFLIaJc17MPSEtMJCMCU6oYrz?=
 =?us-ascii?Q?fWQ9eon9iABW7iksg4RVloAwBWU+Og75Z38Bo5HIaNzHNU5apDvToQl2u5Sj?=
 =?us-ascii?Q?wkJfZHbWm/sL+AKf8GMfV0YkqJYaJAzYbCP909/tDNLzE81HPzD5dJ/uv2bP?=
 =?us-ascii?Q?BhP0b9oTl2P2zwrJhssVH6zWeJ84pBvWS8GYTsH2JK1yQNfDCLZsyPvsEjHd?=
 =?us-ascii?Q?KBBph28t7GLuAl+3ViEmMWd3w6Z6wRMtvcBE5isgg4Zn1mY9usrEEt52hS1v?=
 =?us-ascii?Q?wmTHncVUEwgUnhRdOFLCuva3Aq6MFUApGiQe1g/tXfdex/macGxRc0xXRW2F?=
 =?us-ascii?Q?LIOZe7O1kjTPl2qwvwUn7MVDLRfLp2hE0sr7DOIepZtcMd1GKWF0QHXwfGVa?=
 =?us-ascii?Q?xEpTZjFIR1CQaUbJI5TJj4Q49NruJie2uWU7cH97TiEd4rG/oHhHMW7L7lgB?=
 =?us-ascii?Q?jzpnLhN83MOsP71k6PeyTp0ZkfE0XDsMvOnLqWQQx5buRc8iS8OM+VMJH0Ix?=
 =?us-ascii?Q?iq0f0s8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:52:35.3242 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d27936e0-cf68-4616-76e5-08dc81921270
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8693
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

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
Today for MED update type we do not call update clocks. However, for FPO
the assumption is that update clocks should be called to disable P-State
switch before any HW programming since FPO in FW and driver are not
synchronized. This causes an issue where on a MED update, an FPO P-State
switch could be taking place, then driver forces P-State disallow in the below
code and prevents FPO from completing the sequence. In this case we add a check
to avoid re-programming (and thus re-setting) the P-State force register by
only reprogramming if the pipe was not previously Subvp or FPO. The assumption
is that the P-State force register should be programmed correctly the first
time SubVP / FPO was enabled, so there's no need to update / reset it if the
pipe config has never exited SubVP / FPO.

Reviewed-by: Samson Tam <samson.tam@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c    | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 7330f9d79600..2626ef8f3292 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -615,10 +615,26 @@ void dcn32_update_force_pstate(struct dc *dc, struct dc_state *context)
 	 */
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+		struct pipe_ctx *old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
 		struct hubp *hubp = pipe->plane_res.hubp;
 
+		/* Today for MED update type we do not call update clocks. However, for FPO
+		 * the assumption is that update clocks should be called to disable P-State
+		 * switch before any HW programming since FPO in FW and driver are not
+		 * synchronized. This causes an issue where on a MED update, an FPO P-State
+		 * switch could be taking place, then driver forces P-State disallow in the below
+		 * code and prevents FPO from completing the sequence. In this case we add a check
+		 * to avoid re-programming (and thus re-setting) the P-State force register by
+		 * only reprogramming if the pipe was not previously Subvp or FPO. The assumption
+		 * is that the P-State force register should be programmed correctly the first
+		 * time SubVP / FPO was enabled, so there's no need to update / reset it if the
+		 * pipe config has never exited SubVP / FPO.
+		 */
 		if (pipe->stream && (dc_state_get_pipe_subvp_type(context, pipe) == SUBVP_MAIN ||
-				pipe->stream->fpo_in_use)) {
+				pipe->stream->fpo_in_use) &&
+				(!old_pipe->stream ||
+				(dc_state_get_pipe_subvp_type(context, old_pipe) != SUBVP_MAIN &&
+				!old_pipe->stream->fpo_in_use))) {
 			if (hubp && hubp->funcs->hubp_update_force_pstate_disallow)
 				hubp->funcs->hubp_update_force_pstate_disallow(hubp, true);
 			if (hubp && hubp->funcs->hubp_update_force_cursor_pstate_disallow)
-- 
2.34.1

