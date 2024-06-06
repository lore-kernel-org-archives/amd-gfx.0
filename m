Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C8FDC27C54
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:02:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C779310EAB1;
	Thu,  6 Jun 2024 21:02:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2GjrN4S1";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0172010EAAD
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:02:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwZmuEpF85alzsN/9Z+pqIi6HI0nN14X+PLoZfw/t6h9iu7LSzVWZH9lxmgNachGB2mlezsTz7qXFeqgWdS7C/qiN6OSjJZ+D7c/RK9z5U8Xb2WAyoKNlZT9QO2w/tG2jqQhj22xPKi/MsU4LGGCHcZtZkzbjIIFxNKXgffSHdcOrRtF9wD21XosFmJvGX4CcgGTzlYyCshRH6HlB6/+kpCmDKY5ItDzkiDdpKqw84MryQHtJoYqqWFFt1hOXRoazD2RXmcwd7eKBwOTv6uJHFOTwQRPZpA9kBYUxlBJb1JFmFYIlioT/9KkFJwfDlFlLvMmNWyHcJkSDT/GMty4sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6iZ0/6eRpAQQem8rqORnHUeOfKNVgxw1V+Q2S9BA9Pw=;
 b=oTMfTPDkLztUpeqGcwAZ7kNiF5PkJaCCUz5nNkvq8HeVNbOJ4+dRSQ23LwId21hASBWFnS2KOq5RWpjD8Yns0pD+2WedhEk9eWIKocTv4ZRwgkOwm34yqAGaeZNB9LHbWJ7PbC64E0fmeqeSFXXOvOxtpSrh1hG56dXWol+mCpNzhdQ0ev7OCj8JNk8/MizP9Qqo3yj7WyoCQQPI/H5gZ0SDEFAmoJQefA4tGn8Lr2VrhybBhOP34qvZqlx6DNb53Q3bHUWucUx9ckd7/2Q7gtmjD2gQwyg3KOVzOhGq/iY/mMKrzg458u/qqii6lSG83PXAUzMwJWzrvKrGU3mjlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iZ0/6eRpAQQem8rqORnHUeOfKNVgxw1V+Q2S9BA9Pw=;
 b=2GjrN4S1+f8Cv34iOtrFxSly+tsipL6/zL7DfF4Jxh0sHdI9JUtT4gyiiENJNgvYQdq4NCoAC28733kT2CQGc/rUmGXv06mMeZmenltnsD+Jfh9sAG5G9f0HmicHFOn757/7+CA8bkfb0SnmRaZTxBXiBNWu4veLrfQDVD/yUbo=
Received: from SN7PR04CA0199.namprd04.prod.outlook.com (2603:10b6:806:126::24)
 by IA0PR12MB7554.namprd12.prod.outlook.com (2603:10b6:208:43e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 21:02:08 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:126:cafe::48) by SN7PR04CA0199.outlook.office365.com
 (2603:10b6:806:126::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Thu, 6 Jun 2024 21:02:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:02:08 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:02:06 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Nicholas Choi
 <nicholas.choi@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 12/67] drm/amd/display: Remove NULL assignment for
 stream_status
Date: Thu, 6 Jun 2024 16:58:33 -0400
Message-ID: <20240606205928.4050859-13-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606205928.4050859-1-zaeem.mohamed@amd.com>
References: <20240606205928.4050859-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|IA0PR12MB7554:EE_
X-MS-Office365-Filtering-Correlation-Id: 8635ffab-47f3-4c25-74a4-08dc866bed76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400017|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rfQ3RYMunuFsiaZNkshGdObmReo2W44vvPjspJqlOu5MS/97CtBlLXQ5EW+x?=
 =?us-ascii?Q?f9D5zE5ZRk/FwnnqhptmYUEDSvzdJ3RgQhCg3sGPeSG2zgrHT1S84rWRmmTS?=
 =?us-ascii?Q?mXLLQGglExnsl/GDV5KNA55BBgx3NFRiZqNU3Z7OjGyez+/h2XS7V/8Yu0Fn?=
 =?us-ascii?Q?gee4Yxa5Hzg3ypZ51f4K7U66VkhF59h1m9msvcQWY+TaSNQIcgV+ISsKzUjo?=
 =?us-ascii?Q?TB+ZNOggsHV/N1smB+D2qNw6EUP7ni6fkVZyzt+Jo5HF4JxW/YON2RprOAk+?=
 =?us-ascii?Q?rv2dSepoanJL0GixieDdTnAAQTpuPNkOJe0MbXavV+xbBISLk2kQCu8yOnvc?=
 =?us-ascii?Q?loiJzNxS9Hs8TNUG2I+yD8KUJvqvW9gJ+k4Q8Mn9Mo1vlmz7KaVCrJVwRdqi?=
 =?us-ascii?Q?gGWQspU5sHWLB3kU21Ycl4IERMlbqMVWUR9r6pFE7Nx07uBf+du1qMToeLDQ?=
 =?us-ascii?Q?PqyPPzKW32WLdCsGpT6FO6S0rlpwrNLz1bZRArOwomBYFmd6c5bmZsFZVTtQ?=
 =?us-ascii?Q?CoJtQWiUvMfG5/AgbuluN0rRcn8ODQHc7rAlUKMbwDp3PBFbaPq8zQZi4MMq?=
 =?us-ascii?Q?a3Hx0oSsL6PQq8f3t4CIwpJgQUD9VsjpwKI3piCebDnWHQgtmWRNo8LHb0ZH?=
 =?us-ascii?Q?WiEqTkzOUzhz0qxExExI659Tx7M8Wna7QRJ7c81ZJHBeuGJ7ifUxU6o0Pn4u?=
 =?us-ascii?Q?QeuA8tbKR4NVGmeGabqbomcI3Td7Qzcn7Sx7CV9qNLzQiTpSKimP3ztzc1cZ?=
 =?us-ascii?Q?jnl/uANYiVM4YgB/TE5cQLDQYuChP2v2b7TpEtDGTaCdcADknp17PLUMC+s0?=
 =?us-ascii?Q?JYSQibLkUyc9LcuppBGkd7TB+Zme/klRqufng9i5Fs+LuWZGvLdpKG9a+yY9?=
 =?us-ascii?Q?WYBzLqs/8kd6AhRHCLi2R2GB1++BScqFEroQtCfhjb8/ankMIZnqA0LCTtM0?=
 =?us-ascii?Q?r3PE3N3EtM1osChGmbdhGfTauTo5LS0Rfq7zbsPGtf5pqFzoeXHTjGgsegfJ?=
 =?us-ascii?Q?43K6aZHCCQh119slOH2n6V0LYq6QVyDiCYg2jXfpKCOUIMADznPowALuuuzW?=
 =?us-ascii?Q?3U+BYoxwXS5IdTy5+42e9263K6bBA1V0Zb6VOtD/I07DS+SnWq/52l4PfiKt?=
 =?us-ascii?Q?fn3g/OInSLIEf4U4e07MK3adyAuTKXr2lgWTvRvWsVTg6T8aZZ5qzPAbYsNR?=
 =?us-ascii?Q?zmaPBkURF5VOUpo8UeoeG+PnrRsucrifEHF5SR8pBzrR9/qAImUfhfRgrKRK?=
 =?us-ascii?Q?IDvrtpNWNzvT6iorKbm00ezYkrmPBemj6E2gTRlf/ET0fmOwHvWDBTBbrsdp?=
 =?us-ascii?Q?GAxaiTNWUGznL42xhwsiqtlRYQEuUQXyhpSODUgJMyw/FAF+oMbEAtL3dFUO?=
 =?us-ascii?Q?VzMFh0p+a4QM5uV6bF3Jr802Dqw4PElIU5SyeSt4b7SZqh8eEA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400017)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:02:08.2572 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8635ffab-47f3-4c25-74a4-08dc866bed76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7554
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
No need to assign stream_status NULL because it is always
re-assigned before usage. This change is to fix coverity
errors.

Reviewed-by: Nicholas Choi <nicholas.choi@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 873993a6513c..12687d400092 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -444,7 +444,6 @@ bool dc_dmub_srv_p_state_delegate(struct dc *dc, bool should_manage_pstate, stru
 		for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
 			struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
-			stream_status = NULL;
 			if (!pipe->stream)
 				continue;
 
@@ -464,7 +463,6 @@ bool dc_dmub_srv_p_state_delegate(struct dc *dc, bool should_manage_pstate, stru
 	for (i = 0, k = 0; context && i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
-		stream_status = NULL;
 		if (!resource_is_pipe_type(pipe, OTG_MASTER))
 			continue;
 
-- 
2.34.1

