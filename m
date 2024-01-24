Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A43C47422
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 07:03:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C4D410F656;
	Wed, 24 Jan 2024 07:03:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E07AD10F656
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 07:03:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/0iFpjH2ADODkms0mDyWbx5q+XM04RypH03OLTvzHrePZOimbRGmZqN4I2PcnUC/qcWWjonRmS1G2U1PwlE39gpqceIPCDW4N491TKh3JA01q+ckjvQ+V7/olWkcJwHiynBoPDZu7c8h/W7C6p4RTloveSE6jbFZbbgbK40kJ0hatPw6UDDEDF93W/bpbKod6cu2/xmlKuqT+G1ZXi0QdJzpx3TA63S/qUyDlZ5YB+nM9KCeLqpCaRWpM2sQdjq44gKxSyuE6MCJkCy49w1WgGR32uRc52OZQ9fhjYJiFWhw8C2zjAKSxzlyCSWL6FrWjiqMRP/VF4Kf5Eebwpc1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7PP+H8sSMUvzJOQYcEhpidqbDYro8vx8SoFdlnXwbA=;
 b=hHvnq/2zZFl3Y7UYEfWZFG8rM9DzAQxmFPIiDD8QxEjn/Lywt9dSp0uUhzDbRqNzeMBtLvAarQjpDODhjIctWTrFHV5+5Xv3nd0rQSMP8PGLNLSIj2LUoyvxfdTJ51/O3i9lTTPNjezA4olHMrmsC63IkfOTWRiSD1OLIg2HsqY3iH9COfmaOoh5t8MFXXSILVVXIE3ADrPosS0dw6t69JoSO8opewfRIl2QbD0aBsMCjBXdCSJBFzsagXcdKM8+pldmHI64TjVZk95xpPqqo1SlYZfeEqY2NRVUmWUCLihgl9c2WoPQtCZlp/9xkm+bRtSzF5iojzLLcjunBspSSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7PP+H8sSMUvzJOQYcEhpidqbDYro8vx8SoFdlnXwbA=;
 b=To/o1PEYUBLUH73JmbqSudmfX33x3/CqF4RMFAMhebK67fK099RRqvi+DalUAkoyGjShL/Z9+Kx+IMtvdsVKgcJpRVx8hYkaY3qXI2FhQg10VnLwkEATCKJI2SjfH7f/jaEoZa6n0bgov2vLkuVv2kMj+J4Gh9Pr8UuhQCTJDyc=
Received: from MW4PR04CA0106.namprd04.prod.outlook.com (2603:10b6:303:83::21)
 by CH2PR12MB4102.namprd12.prod.outlook.com (2603:10b6:610:a9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 07:03:10 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:83:cafe::8c) by MW4PR04CA0106.outlook.office365.com
 (2603:10b6:303:83::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Wed, 24 Jan 2024 07:03:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.0 via Frontend Transport; Wed, 24 Jan 2024 07:03:09 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 01:03:03 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 01:03:03 -0600
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 24 Jan 2024 01:03:00 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/22] drm/amd/display: use correct phantom pipe when
 populating subvp pipe info
Date: Wed, 24 Jan 2024 15:01:52 +0800
Message-ID: <20240124070159.1900622-16-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
References: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|CH2PR12MB4102:EE_
X-MS-Office365-Filtering-Correlation-Id: 18a8b324-9186-45b7-3017-08dc1caa8620
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ewncsqqvBZkujrlmoLB4tb9qXnASzKF1p77N7pridpYxxMSD0HWB9hgOo0DzqBdLRrRM/yhgCZi9rhIbLdGHHV7svgmMyr+zySkGqY7SyBpVhqz6M+D+zAJOH2yhZzwECTwRUPewu7Fp03txl+Lvg8VjY+wiiYw/gYVFekvBxMqYjZZ5y0W6Dk0DX6PcC3WWh/CoR89O0znuOCK8pGtEnaaNnkqohwIBjTdmf2hp1lRRf5fRsz8p/tsCVkscrk7xlheZZ8VfFsO3Ilxvo2uTmdLB5A7x1zuu8zuZ5pTzlJvWdffKUOCPplTeOMgOCGcQ5VL8UwR4Fl195w9bxALtRLLGpBWqKvvAEfAzAJu5i8X5z1QPMV7R69+NzGVrynodyPBc5IuOcY+uFXdlOUnCguRLVH/w0O3VuXKQ7DUm55kGE4on1BqeeGPdhh8KalVY51SyvY5Nwabpjg21eUJIlgOTrTYoI7uzOrIrVMUbV5gb9NoxEdvVdiMaqoZW4qFouppJxais1rlVrGAdD3fMSHln7awb/1VP/W1XnpskWxb3UgK5gY35DQUSefrGjK8HXJHHTgLcdDU/l1QFZCP5YlYDvLMPn7mlMZ8e3ECqS1BsJ0uggGi2251W/8MGM/qnfQaGLkgzSQ6fCPXzBn3sefpK+N0pM73Ok+gH4pej7ORG0oHxmP3GoxEYV6d2PoVgv/qLRGGR/Kcmr76DsswFdM43atb1ISlNBHL5MiL41wj0bU+ljMu/DYRUzdqK0/G09sYqF208R+MiARgU+Nff2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(36840700001)(46966006)(40470700004)(83380400001)(8936002)(4326008)(8676002)(356005)(82740400003)(81166007)(36860700001)(36756003)(41300700001)(2906002)(47076005)(86362001)(5660300002)(40460700003)(40480700001)(1076003)(316002)(2616005)(54906003)(6916009)(70206006)(70586007)(478600001)(7696005)(6666004)(26005)(336012)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 07:03:09.8636 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a8b324-9186-45b7-3017-08dc1caa8620
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4102
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
Cc: chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
In current code, we recognize a pipe as a phantom pipe if it references
the same phantom stream. However it can also a phantom split pipe.
If the phantom split pipe has a smaller pipe index than the phantom pipe
we will mistakenly use the phantom split pipe as the phantom pipe. This
causes an incorrect subvp configuration where the first half of the
screen is flashing solid white image.

[how]
Add additional check that the pipe needs to be an OTG master pipe.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index c365cca05718..3d7252218ea9 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -787,7 +787,8 @@ static void populate_subvp_cmd_pipe_info(struct dc *dc,
 	for (j = 0; j < dc->res_pool->pipe_count; j++) {
 		struct pipe_ctx *phantom_pipe = &context->res_ctx.pipe_ctx[j];
 
-		if (phantom_pipe->stream == dc_state_get_paired_subvp_stream(context, subvp_pipe->stream)) {
+		if (resource_is_pipe_type(phantom_pipe, OTG_MASTER) &&
+				phantom_pipe->stream == dc_state_get_paired_subvp_stream(context, subvp_pipe->stream)) {
 			pipe_data->pipe_config.subvp_data.phantom_pipe_index = phantom_pipe->stream_res.tg->inst;
 			if (phantom_pipe->bottom_pipe) {
 				pipe_data->pipe_config.subvp_data.phantom_split_pipe_index = phantom_pipe->bottom_pipe->plane_res.hubp->inst;
-- 
2.34.1

