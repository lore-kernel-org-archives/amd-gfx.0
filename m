Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF971C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:53:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EE1110FE1A;
	Wed, 24 Apr 2024 08:53:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vVODAHj8";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E9DD10FE1A
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:53:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DWQnZKDFhFqxu2v1VdY84wFZ+SOaJfNQWTdIa06FC0M7TB32EPoBemPvXpkB847hIwdIkO2EawIzbtJh5CXRIU1cthECLFfxNDimgXKYJ34DXukguORWIJ1eZrN1FzrXpks6MkUr6lmctoRCrQl6EZgRya2yzoaaViOvi/yvcUKaidL1WmAizH2JLQtN5SKk/siDNeAKl7IpZI0FxVKrPDV2gReF3DEjNhx+2EAfYD4V7F5n69Rt+00qr5h7a3bUdVUc+MzrOzjgmGABHADxG6LiZ3KhUBMiQm/oIGt2BAUXj275M8/s8jsBX+geIpMl1dcSx9v8VRQecq89ra4J3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T88mrWJ45K2J7otP3Iak7bUXdCg5WZtE7HZ5Y47lWS4=;
 b=ZZF9zbSJAfOsc95e7GbM3CrSZk3OBJ48iNy0ew5WItuE8aAVASi+VPNUedNYrMaq0riQpLHyWSG2hJwBUNEeZX6G1Lcrnm0fdGUQ7K60dNec08jdUrY1uMBAL7E/BbXuortBGc1SsOnpb+qZ2FGigvy6LtSeszNQSk99uTSfw4xPeInyL+FVprrogO8MIeER/FQ5JmS8/5sOV8cdyK6cuv3PBivE9i4N2GTbSrn6YTgN2zvH0JUNlKiS8mjrHqntnhP3IdcP1K3BotoJ9H+gyEJl+WbibTBW0TWucxJFOLhhCvYwPu5fIbhZzKcpYPENMQArTIjSudPrTcdtdWR97Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T88mrWJ45K2J7otP3Iak7bUXdCg5WZtE7HZ5Y47lWS4=;
 b=vVODAHj8pRMDbn4gr4sFCVwXsYVHWQMKtYfrf6pXlU+YkRnkNToEenkma97QzKNEyvRakanhrMCmDkDV8YiLmLLnZMa4vgaBQGbMTvewsIJWVykID/w+3bO5prvscsDWy17KOaihjCTrR99+tzdSsaOmf5JXBAHfHsTA6ALM+ag=
Received: from BYAPR05CA0049.namprd05.prod.outlook.com (2603:10b6:a03:74::26)
 by SA0PR12MB4415.namprd12.prod.outlook.com (2603:10b6:806:70::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:53:07 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:74:cafe::c3) by BYAPR05CA0049.outlook.office365.com
 (2603:10b6:a03:74::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 08:53:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:53:07 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:53:06 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:53:05 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:53:01 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alvin Lee <alvin.lee2@amd.com>,
 Samson Tam <samson.tam@amd.com>
Subject: [PATCH 30/46] drm/amd/display: Only program P-State force if pipe
 config changed
Date: Wed, 24 Apr 2024 16:49:15 +0800
Message-ID: <20240424084931.2656128-31-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424084931.2656128-1-Wayne.Lin@amd.com>
References: <20240424084931.2656128-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|SA0PR12MB4415:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f6c03fb-44a1-4d37-dd07-08dc643bf5fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CCNFM+yFxV+HXVLf6mfKf29LLWWu7efGsiWmHPwfQVFMJWmAr57zrybEO7ux?=
 =?us-ascii?Q?HmZE0hUvkWRbkROeS1V7S49m97fXsx/YQkxpmqc4Ly6DNansDNm37pgE3vvA?=
 =?us-ascii?Q?VzFSjzssGriLnq3HYF07YPEityZvwOYKfUKbSw3Z8oqVILSbBCjX7dfC6HGn?=
 =?us-ascii?Q?/Kk2N//7LFb1zLbH9sHzs7bAgzzOuCCvu3/1u2ZKgmBH/8Jugc1rmNy2KIV1?=
 =?us-ascii?Q?6/j/vzyHHkuQ565wt3WS5SUipFZIBixgYi+kDe415MhgtRS4amje34FKWeKH?=
 =?us-ascii?Q?Rv4Sitr8ACTjBMQkDltGHeO2j1/0CSxrlbchzaaKbZ9YQo8HDwlPWcTqZbLW?=
 =?us-ascii?Q?Kz2u7WlhPw56zSnIRWQvvAtZPFb4uD5BD6hvM+S1tl/n+yWARaYQGQOapGTv?=
 =?us-ascii?Q?PEoPYIuACQo3tUWBTKMBGOrnuCOvkd61D1VwcK/83DZcTApPFrnmcUYevP7o?=
 =?us-ascii?Q?h7QHdJBZhSD6pbWtVXN/B/I6KNPuG6YjBKbDzMs8Es5lnjIafI3cVMRYh/Ml?=
 =?us-ascii?Q?mhhbfAGDmvXJ4ydK+EKp1YHxRDXraD7lZwp3+uzA86N9Ijam30hBKfnYpCUn?=
 =?us-ascii?Q?WJxLQ5R/qLX2I+Zh7dg6w4tv3+ttD6qwYMBYgc/5NBxKjPuUVQMDfS9Jp+R5?=
 =?us-ascii?Q?0VLU5WAJbRvOIZm5jx53nHJ5cvM7mfVxjEjaIBLUDf1W6xuruBsCkXxrettJ?=
 =?us-ascii?Q?IRceekL5bAcHyloF7E1Os/CoUD/zO0uuL5qkVaVyuOQff9zuZq4JLOBgss30?=
 =?us-ascii?Q?LKUi+Tsdst92AAB/LqU0KGYoLrMPdwXTXwfGUN1r1zSEpoTYN2sKhwAwd9Fh?=
 =?us-ascii?Q?cSQnDjO8atL8PW4GMseb2VOiKSIcj+NC3jpmAUhk/m7SbxXDRfNYPbRIuAMv?=
 =?us-ascii?Q?XsqLkMMP8QHReEODMdg30a1Xj0Wp/6loDR68M+ve1XE9D4ZDeOKU6bh5AshR?=
 =?us-ascii?Q?JmLl7z1UIy8FHFBuLRuILaQgnkPFiTFyI6hBt0O3zy4opueergGa4a/ntVZ5?=
 =?us-ascii?Q?phKyBzgXwo65gfsIkDk6oEHn6Ro5oPk/Y09cT0HZQ/iN81PgxXuopBdrYPpq?=
 =?us-ascii?Q?BBPfmDfcGvRzoXmxxXfz1rULfYiR5gxx/VF2cm9TkhKqxqGPhSI3RoDWlg5m?=
 =?us-ascii?Q?vYoEUu13CnxsDs1NM2Q2tRDTRJ+c9hVBA8kiz1kj5aop7VwP1QxibAb7kEXm?=
 =?us-ascii?Q?NBwuI8Kus/NE3j0E5EtT3h6JeHxfN3OvkBcGvODPLCA6VTjU7+Iv5ZwX5tEh?=
 =?us-ascii?Q?56Go46xM5IgRNrFhW7oOuvv0Yc3ydLzAeEUoMp+/rlRGjAC3VEReseiDSxl/?=
 =?us-ascii?Q?/ps8VsiXb2ogkCFnrU2gvbeOGTBdua/ExNwF/OMgQMlMunPp7V6sPlpeGK6o?=
 =?us-ascii?Q?A2Jdg3aRdF9jfjls+ar6pQeXg2/5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:53:07.1017 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6c03fb-44a1-4d37-dd07-08dc643bf5fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415
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
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c    | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 9f1a86ddadb5..272c4cdfbfe3 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -614,10 +614,26 @@ void dcn32_update_force_pstate(struct dc *dc, struct dc_state *context)
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
2.37.3

