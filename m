Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51C3C74A5B
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Mar 2023 07:57:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3901310E1FB;
	Sat, 18 Mar 2023 07:57:09 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::61c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF43C10E1FB
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Mar 2023 07:57:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AaL0gboCnGOT6EK0J1+RIH+rMSlZ5HB4GqznWngzv5icdiuDOenuDVL2FVK/ADJxGybODHlnp4ZmDPCUKymv1VoWfvzGGB5uXtFlHgluUX1m4h3uhqnN+e4SEKafUHOppfEpqkSTFdZIeW8JPK17zjvxyuG6Z2Srl9Hgdo6g5rs+QsbpYmz7rw/M8pVTSo4yPlo4PYhQ9N60gYQ0HGI8e6Ezf9r5B8UFyTBOrci9qA3oSUXCC2yr3vBgV0PcSfTji1EnPRIuX1c3jqmXmlq0Wl0fIGu+trEfekNBiRuqFN4UYYqBzxwueVlEQZcjNlhZU9r4gnBvsdIoEHAUS9bwaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZ1sn+qczYHQIY7NcV7bCVssAfp+WKrg0FRzP8kAZZg=;
 b=O/MMiS6Y/JkPIaMYmc0Eax4KjDEQos89tQjeOrHLOEUb/kxuEJWRtDczG9DlW5+hfMuSjO/Eofg+U+QrBgk2FbEAIcYxPyvLPECNtjQEq3/kh84ufNK+taIkyvMIAgcrt1NIKPGq4K6oAdC0/MabDuJMZI8+BsW3T5eSD8yLjgL5pTrE0/fGyzwEVnrLVnB/RXAFKxc57BdcAa2KGZ1YQp2GMjhZwkZDZO3Z8Yruvaij0r9Dz9QVGxjLOX0YcmKhZ0V9zX5sg9UiytdgxVoqeeNK3iYE8GIu8A+uO8u+7XR8kFvW9i70CY+7feTOKWg1cd9IwrMJ7MMyZ+59pq0otQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZ1sn+qczYHQIY7NcV7bCVssAfp+WKrg0FRzP8kAZZg=;
 b=t9epgPNsdjPtbuvKx2HOC+vNCp8MwHJrdFmQu/o8k2u8ObRh5W3D1N/pae0aLMAHgkrNZFsC32qPvx/e2ggvhutRkNFxn/qjDOzySVyfAejMdIadgQAM6NqsvWYC8S1GwdN/OegpuVKF9ynzIxYZNuglvrUXoyy/7TpJMGULGL0=
Received: from BN9PR03CA0975.namprd03.prod.outlook.com (2603:10b6:408:109::20)
 by MN2PR12MB4440.namprd12.prod.outlook.com (2603:10b6:208:26e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36; Sat, 18 Mar
 2023 07:56:59 +0000
Received: from BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::73) by BN9PR03CA0975.outlook.office365.com
 (2603:10b6:408:109::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35 via Frontend
 Transport; Sat, 18 Mar 2023 07:56:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT102.mail.protection.outlook.com (10.13.177.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6199.20 via Frontend Transport; Sat, 18 Mar 2023 07:56:59 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 18 Mar
 2023 02:56:54 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/19] drm/amd/display: skip wait vblank
Date: Sat, 18 Mar 2023 03:56:01 -0400
Message-ID: <20230318075615.2630-6-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230318075615.2630-1-qingqing.zhuo@amd.com>
References: <20230318075615.2630-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT102:EE_|MN2PR12MB4440:EE_
X-MS-Office365-Filtering-Correlation-Id: 30154476-7b30-4e16-535e-08db27865a45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QHgZMynHzGqra4LfC4C3xCrFDMSx9L+R8pvklzvcee5aFtPHmd5gijvnxWWj7qB+5vhotxtDPQKvJTOO5lgyIoE4UPVa+cR9i0A0GNEt47zXuF86zCUGX0ctfN3Flhadikg2bwfxPXk166evlb/1r9vu5ZngmRkgx/iRj+DmBPZv8aio8EOzVftpj9Y+ifXvQb8nUMII5S+uqrLQQ+ohg6NvfDk7sHuZoBNFYAVUoBoUOnlnoqyzEFbiOI2SkM0gu7La5veelbVkwkpsAeh+mg/t7ZcY+E5CbwSnXIvu6do57SbW+IyJFMPyYwdF4LcsaJ7UMzPJJgIRmuUMTEnvwPOH1Mp8yWZiZr/+6NWfng7AV519dLPM5V1oNWFmRTbBkRTv6Szv7s/Wm0K6jXyKp5cNX5t+Pw2s4quV0Ho2rcuIr2U4cE8sxdKuzOsq08sUR3+ZEegQ9OhHi7dzDnYboVH5iu5VCwmJOjAhdlwXRuSeMPwx0GNiJXqpKYAGBXH6cuSHtOcrmveflfA0y/3eRsSTxuT9g94Y8S39YfETUkT6O0zkaIWxbBR4hmGNOiNrkUxHU5Q6m+2zRuDPaFnDkhYmNAWPa0/8hqBtS/hKoxrn+qFP3Da1jbziiMs2vxJABllOYnhWGOuDXtyx9I0EF+esPz84zYE3awNT9lOeVMdKd5wnlVZ7mnk7PQfv7RbkVz+bjd9yUitSdwtm5vlsLaNi5R7jIH/dQNph1+NFdxg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199018)(40470700004)(46966006)(36840700001)(86362001)(40460700003)(82310400005)(40480700001)(36756003)(316002)(70586007)(70206006)(8676002)(6916009)(4326008)(83380400001)(478600001)(186003)(6666004)(16526019)(26005)(1076003)(2616005)(426003)(54906003)(336012)(47076005)(356005)(44832011)(8936002)(5660300002)(2906002)(41300700001)(81166007)(36860700001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2023 07:56:59.5557 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30154476-7b30-4e16-535e-08db27865a45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4440
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 Zhikai Zhai <zhikai.zhai@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Zhikai Zhai <zhikai.zhai@amd.com>

[WHY]
There is no need to wait vblank in the vupdate locked
region at a full type update

[HOW]
skip wait vblank when global sync change

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Zhikai Zhai <zhikai.zhai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 53669f832ba5..69ea1f4ea749 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1720,10 +1720,8 @@ static void dcn20_program_pipe(
 				pipe_ctx->pipe_dlg_param.vupdate_offset,
 				pipe_ctx->pipe_dlg_param.vupdate_width);
 
-		if (pipe_ctx->stream->mall_stream_config.type != SUBVP_PHANTOM) {
-			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VBLANK);
+		if (pipe_ctx->stream->mall_stream_config.type != SUBVP_PHANTOM)
 			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VACTIVE);
-		}
 
 		pipe_ctx->stream_res.tg->funcs->set_vtg_params(
 				pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing, true);
-- 
2.34.1

