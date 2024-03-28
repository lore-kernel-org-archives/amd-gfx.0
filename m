Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A36CBCD1283
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 19:51:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1837A10FE3F;
	Thu, 28 Mar 2024 19:51:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J7oxn5le";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25F47112339
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 19:51:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/iGTG/JQD6xQ6Swu2fIlrLRtPVFkuBAVA79CgVHlbd5bleWHwThcAJhNZI5cFQ1MO9P45AjNvOYuEwoIW9wNs1ghaoK9CWBw9zEodyTkdgOZXB944GGkWgkgaCahl8rhLb5BnxNvQIquyNeqx9+8iQyIDH1XKdJ+4WX8Zu5/V0TtYk1Y4OQSMNLAdvVSQG8r+W4my3rNC840GGun2GGSQgwlIgFoLaTSjICqMH5u2OKZET4uqt6cKjkTPjI0t8Q5Rlx49hGH0G3f8MQ6me3GGfKgIOFeXJqepcJBZT3FgSfvMM68zE83Kjn0/KK+m1srhRzgZ3ncARlRLrsm+5ZoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28OnEC9Wtt1c+G+xT1VcVVW3Lp3h0YK6ooP2C8Nk93Q=;
 b=fAxcIFnCsEN7Atvbc3Mr0UvK2Z0iPZI4oGX5HqKxftvT0cPj2rzS1dyUDPLSr/lfZJgep9nsrLf82D17CXPoaShw9gWEuwbiXhB2LybBPnAWIVmG6os4kxsKCLn63DbTLfcyAA0BteVO9BupjfpR34O5ApG87rBXOgogf6XjwhW/1RRsuImSDIFgRRpS9/C93QdlmptEGvx0jVZONKLqDjOWUU/3Vv9v/Pmc3bUjB9jYKnCjSRqyBl2yMrQQRe+Q9i4gHPuHjMpOG6V5k3oN0PK4gb6fe1dVVkgWni/abySPZg0B2MigBIdcTEePwcVSDyisF05RcbuCMlYTlL1v1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28OnEC9Wtt1c+G+xT1VcVVW3Lp3h0YK6ooP2C8Nk93Q=;
 b=J7oxn5leGjd0xvkfUoW2lgiEOPtR4Mb6+6QomjV9GjKzRSLXMX+SAdYKt0xJoVpSQTvHo7mDIdkUf18HcSFdmx5PHybwSay+GYvoAkLIAN5+Stb4QuNXBRDGw+NfqqIAmoO0FlERTXf97CF4f4pc2D5kytv1rPwx0hSfCHD0m2M=
Received: from CH2PR11CA0020.namprd11.prod.outlook.com (2603:10b6:610:54::30)
 by DM3PR12MB9327.namprd12.prod.outlook.com (2603:10b6:0:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 19:51:52 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::7b) by CH2PR11CA0020.outlook.office365.com
 (2603:10b6:610:54::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26 via Frontend
 Transport; Thu, 28 Mar 2024 19:51:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 19:51:52 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:51:51 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:51:51 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 14:51:50 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, 
 <roman.li@amd.com>, <wayne.lin@amd.com>, <solomon.chiu@amd.com>,
 <agustin.gutierrez@amd.com>, <hamza.mahfooz@amd.com>, "Leo (Hanghong) Ma"
 <hanghong.ma@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 17/43] drm/amd/display: Add OTG check for set AV mute
Date: Thu, 28 Mar 2024 15:50:21 -0400
Message-ID: <20240328195047.2843715-18-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328195047.2843715-1-Roman.Li@amd.com>
References: <20240328195047.2843715-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|DM3PR12MB9327:EE_
X-MS-Office365-Filtering-Correlation-Id: 5199506a-acd4-4786-86c5-08dc4f60838a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: toq0r4Ya9hWqQoXeaLstA1sgQEkchymQH8kcOnWDkgAUCmZZSxDKjZf4hZG/aZTsfPS6LT6ZH4tk6HX+zofSd9LwPnCfdG4IMC5zTBTKh8XJOljEuH74RS3eTsYI2rYiSwZbgfudeglyNbdhGcHzdXaJmBRQkk6kZgFus5LRBTg3aWigZrj8bO45MhKQR8T/kM5IKC8dMgfS7K/wOAddmOCqSXd+y2mVmeDnbUEVGAHmH/8A/MqHqLdz6qKoZbqkhqzdx8df1QJH6w04qkq1NsU/LLLQocHFZypH4j0gX9LAcdPfzbQoayKiXPSx3x+wOvfvFrpxXhvevJkfIqUmT0DT+SPFAwgxJYR39DIT84fyaKv+O7dv7LkP1UITYUiAgNPM9HRlh7JX72bd1NE1hujChlwZb8F/sRuneIAJ5GcAsWuXKkn3Q9dE90yW52zcd45m0/yMgLf2vIJOZgy6rcMvgERT1ekbuR0ke6pGJLND6IamWgp/U4U4hR206NRs7A3tiLKdtOqXy9Sxc9aajSqX/B0VH5dyzqwizfBB4yJbyLjdFcDrIEgJa+40qwM/T6RJG02k6+5+u8oX33x2jY+hOmZBXdNM7cmv3L/WZJwFBQDUdxLSxnPm40Y7d36LiBdBhezPjj+8hZT54wV1MNnuG8csxczliPlryOL/Pl5ob5gJtdlMFO7PIvcZCPWElLt6jz7JCnRIx2RYRaH2GGBvopksf9VZbfCUxncLyATBn9acb66euLxfyMlQSeOJ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 19:51:52.0553 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5199506a-acd4-4786-86c5-08dc4f60838a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9327
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

From: "Leo (Hanghong) Ma" <hanghong.ma@amd.com>

[Why && How]
OTG can be disabled before setting dpms on. Add check to skip wait
when setting AV mute if OTG is disabled.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Leo (Hanghong) Ma <hanghong.ma@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index 1f3ddee1ec1b..774605a029e8 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -813,7 +813,7 @@ void dcn30_set_avmute(struct pipe_ctx *pipe_ctx, bool enable)
 				enable);
 
 		/* Wait for two frame to make sure AV mute is sent out */
-		if (enable) {
+		if (enable && pipe_ctx->stream_res.tg->funcs->is_tg_enabled(pipe_ctx->stream_res.tg)) {
 			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VACTIVE);
 			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VBLANK);
 			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VACTIVE);
-- 
2.34.1

