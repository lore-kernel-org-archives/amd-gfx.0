Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323AAC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 16:20:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E96D10E6BE;
	Wed, 25 May 2022 16:20:57 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECDC410F454
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 16:20:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AdsCpJpz7WdPyK5yDa5EGNm9yyg962uHpQgRjPQHbR25F0NB82DefobKVnot6PNUSt+C5UGFNogD9VKis+nbIoyV9fR9o3KXrsK+kyh7gE2ClJBYL3dZcaAyJUn3yFCM/oqHvhyRltkdComc36ApMzonLvYr0lqd3mqbQRK8OXGKMmytA3py0BGzhl/dSfwfSy8joy+IDCMjL361Z7JyK5hyOBYZyEANlqBvQLozZyFKZ68UcaMR+tEhzJLfK7baEKztDFqFAnhK4vLt++TGUn4Rsv98+qBDtqXT7kOykcQ+Bni2Gv6MWCPmVH2iwxaNGGG/li19zv1T6u0pOCX0SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4HEq4xwvhN1keogJz9vnyLIBDPzPoLCILiXfw3HWP8M=;
 b=NKfcbazIXwsQWkCMcuhf+1C2bnLWo9S3iwS8LVLuOU9LSSNsbYfrZN6XzfdqFu/STyizQEJktjEQpvpyUR6wY3DP2WRyoeDz5LZfg33scmsjoa1WfG92w/HuERfxyfsyl8dq0v9gZqQjAR6e7hlGzjYNQ9AfGExqDIi44TQjCzaeElph/BkTLR/Sn1WUhcPia8mw+HxOh/fGhGfiR3ax6rPPBVQHbRerNpHPcy63biti7c041k3y6RrLV4kQwisSBLoDl9KApbqNwx74qYcSDDYfJpluss0r60/4sLnnKe8KRP5OgKqIrYz0TBqJhVsGdQJBxmaPaVoMqUV4h3fXPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HEq4xwvhN1keogJz9vnyLIBDPzPoLCILiXfw3HWP8M=;
 b=IuCUBpQb905AU7awKQwtX+YOxnwlIaZJc4zP11xder7zIQ2HSwGxAGLqjM8ND8XJTRXgZ4bYuquy92E9i7saKgkeqFl9LgCiNbPO/UeTUnUU0oPrAvFxikgDD/cTOrMiOZLQE6nG+jVkCnQwjH8kbPdAJk51gzoHxaaskSs/rbY=
Received: from DM6PR06CA0085.namprd06.prod.outlook.com (2603:10b6:5:336::18)
 by CH0PR12MB5219.namprd12.prod.outlook.com (2603:10b6:610:d2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 25 May
 2022 16:20:30 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::6) by DM6PR06CA0085.outlook.office365.com
 (2603:10b6:5:336::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.21 via Frontend
 Transport; Wed, 25 May 2022 16:20:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 16:20:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 11:20:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 43/43] drm/amd/display: Drop unnecessary guard from DC resource
Date: Wed, 25 May 2022 12:19:41 -0400
Message-ID: <20220525161941.2544055-43-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220525161941.2544055-1-alexander.deucher@amd.com>
References: <20220525161941.2544055-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbc7661e-1c38-4ff2-4a23-08da3e6a7c59
X-MS-TrafficTypeDiagnostic: CH0PR12MB5219:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB52191B007F1F3D99905F421FF7D69@CH0PR12MB5219.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2cle2y7i5Rao9lg2ZkdsXXSLnvQL+Sj/4DWRQ16tZQfzrWSoEm2dAQpkCMJAs3kBGXJyo5WruFCPHfEnkUaMX0vTj1K3qjaepJtrng9C3SmzepeNRqv1/TWuSFXp8pfcL7mHx91g+VaHsWG4yTXGeppddQlUP0MP+ixCRSG+zp938YyMFnd2ALLpiIxoT/6UdnD2BlDZEzhQy269PCNKGgMYC4NvhHuxrW1r7zoJ9GJArzNAR0644q5YthWN8yspS6SnGEFH8KrXWdN86SrweNzraHCLzz9OYAiR4z21vdblQn4/YpUeuunqWH9Q6pfi9d5Z9/tGexBSLNEsJqvS2km6kYu+DoODn4ID9zeMKWMETwQRyv3geWirkxd/oPRi4qUkhRRZ6RLGS45KYOadAz/LEmMI/VwYk3UWYYpXVOGTtvzKk/N3RT2/i5W9+Bss+OzUp/KL+0Glivr2J6xcwGC81wATatlJOP0qF3ym8JoMhVv9zJNEsyz88X2sFsm7AzUsxRRxfCW2tgbl21mt9qhL4okSPBeLu1/B4aNEyFtIPeF2UbJlqLSaR/aHsUyftxCZLDlmx3xJvo922amcK0hu1P5+V2mVwc60GG1KaQewRA2DVIaLZxow/nyrs/+l3R2Ovg6LlaK4k9baK37zjkk9wTIzFV3e8K5YGq8susmCXeLD3F0jkg6/uYfaFQLD9e0p96cd5qTe9DXlQmTcOw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(1076003)(86362001)(26005)(82310400005)(6666004)(508600001)(16526019)(186003)(2616005)(5660300002)(8936002)(356005)(47076005)(40460700003)(36860700001)(2906002)(4326008)(336012)(81166007)(426003)(70206006)(70586007)(8676002)(83380400001)(54906003)(6916009)(36756003)(7696005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 16:20:29.8934 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc7661e-1c38-4ff2-4a23-08da3e6a7c59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5219
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 7072b79d1207..24a7c481d73d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1998,7 +1998,6 @@ enum dc_status dc_remove_stream_from_ctx(
 	if (dc->res_pool->funcs->link_enc_unassign)
 		dc->res_pool->funcs->link_enc_unassign(new_ctx, del_pipe->stream);
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	if (is_dp_128b_132b_signal(del_pipe)) {
 		update_hpo_dp_stream_engine_usage(
 			&new_ctx->res_ctx, dc->res_pool,
@@ -2006,7 +2005,6 @@ enum dc_status dc_remove_stream_from_ctx(
 			false);
 		remove_hpo_dp_link_enc_from_ctx(&new_ctx->res_ctx, del_pipe, del_pipe->stream);
 	}
-#endif
 
 	if (del_pipe->stream_res.audio)
 		update_audio_usage(
-- 
2.35.3

