Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B45C25B08
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 18:00:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 871F5B92E6;
	Fri,  5 Aug 2022 18:00:02 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1229EB7C67
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Aug 2022 17:59:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTe+lgipnOOJd2jrutQSeVmS1FiD9QC3d2XJ4B0shs4CUK5Kwy4uEbISUbrhQP/qTU1HeRhK1KvelrcXVpKYf9Un5YFchGlasiozLDhEM0oeIsiLforuvJcZw6TkbRn6T1bgSa/SrpDT5uOfY/tvlAvN70IenRbBMi1L19BcRd29ltT0eDNhUm8XDfmuw9if8Bj+5eS7A9wz/ZaPPIWn494gM6OJBFosyMhD2OoOYfxd+qVI2pHwfVNwZZjLtyJ/0mR16JXDWGuHphBFG1h+eJZk8+N6H1zmKUT35HEkVVW8JzupGwjk4weSQXCtWOXQA5cV0LKMoxgzwE7xB/CLZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XibSS8YyZPPfk/gM8niaKLIMPxsPytXhXSitKKekjAQ=;
 b=gd7DNcuaQ/58yNALIqD1PB986E+ZuVy1L66u17EdUryMd9kEqM4u2bZxpv6KiPPUU5XB7MABIsTIVTru6mKDlRRptWg8Iwhno4bIYumyoPXk32qfxOnDhdXHmSoWzutYMTTqLEfKXuCuLfQqWomlxK91PfvVhAEMjjfUnl6x5626f4qbb5wpFPuiVnG9Hs1K0UyXsD4auztFXeUCOy2ZS+JoLmEwDTuI+DFu7yHofgCa/G0zghjLBgd9rvSo/pWqA4XgbrFpgUn9ijGxxbb2qLTYMIbQ0mbfdea7DIsIPkxojITWU4FN2X8bkua9HuI20plMVdGeQzu85xxxa/WMMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XibSS8YyZPPfk/gM8niaKLIMPxsPytXhXSitKKekjAQ=;
 b=TMXkcTAsLt1L5PwU0snKXtjxSvQ/t4ztcelvK0J++g1PbeQriI9cLwh78+iRBv3+fLc0V6d0jq9iu+j7fclsHJjoUTVLJ5eHyHLW4GLrI5PUGWERbFR9SqsHvAeNAfllc3n1j3lohlz1UYv1bsMQvkte3NlcWweviHe8Vew4244=
Received: from BN0PR04CA0055.namprd04.prod.outlook.com (2603:10b6:408:e8::30)
 by IA1PR12MB6556.namprd12.prod.outlook.com (2603:10b6:208:3a0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 17:59:44 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::95) by BN0PR04CA0055.outlook.office365.com
 (2603:10b6:408:e8::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Fri, 5 Aug 2022 17:59:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 17:59:43 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 12:59:42 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 12:59:41 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 5 Aug 2022 12:59:36 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/32] drm/amd/display: Device flash garbage before get in OS
Date: Sat, 6 Aug 2022 01:58:04 +0800
Message-ID: <20220805175826.2992171-11-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
References: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 222d5ad8-3e06-4520-45b5-08da770c46d4
X-MS-TrafficTypeDiagnostic: IA1PR12MB6556:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: abpSDTq6kLRZvhV2YMM/2YvMNPGBpH2zMzMFzq0UyKiJHgLtExCfRFt7SpvoGYgSD+E1+6vnqJpizKz08St+yIe+pKVHYO6pOm+IYAVrDAuyhuJJfJnI1jD+F8ZBu5ePI9uarRZFnokeiN5Pzx4CcU+Dt02WoZNfMqhyY7wS3vG3KtKHggBZ9zzcJq5UJgG+kRYufYmCv8vS/SX3UcgpOAbnuxBc4OGtRCtndUsaofbiEJc9l8OSxo/QIeylLCoFd0UOl86W9BfP/WysKkfgl3zHhsM/gAZetDotJDYaWCF5HvZIIx9FGS8oL9hIXZSaPb/R8PEcI7lgCjqKltdFIA9zBAeceOMXyn73Z80W7S7qJOEQYxvQhuz1Zl2/xDhapLklAAgh0RntsL/m1OkJUzRTKQuwpU1EHLJY115VZfSoNGUjEu6Z3BEzlEjF9d/bl8hIYGzGDGUP6m2jy76XqodRC49sTnlac8fS2cNgO3ta0Cy/Gk57PXaRZjqEhRwIfWh5qSR2vpU5io/IxbtLsvgMYEeOGJloTes/2v+ojOiLZdduuiue82kDPu7sAluh3ISLzcGH2qtTnFPpWdWp93dZro/xnqbXd98c1KkrparckIatAPGl6P0InBvuFXw/CglK6kikw2NjngjYFETeuuajfsriUpxjmvjwlZDaGEMOXROcEQnLVylyjPgDeBys6S768Olj9mGBoSUVNz8i19eMTVR+4kutQHSE9AhChgiWVZzOdylqJNcMl43BLQZsHfmn4g9LlyTv2/586YQbR9pGABslOaB9EazoTtixk5xa0O/6KaKk9CP334v+uTwUodvrgA5NLUqZR4j6SbUVnw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(396003)(346002)(136003)(36840700001)(46966006)(40470700004)(70586007)(2616005)(336012)(6916009)(40480700001)(8936002)(40460700003)(54906003)(426003)(1076003)(7696005)(36756003)(83380400001)(6666004)(36860700001)(478600001)(47076005)(316002)(86362001)(5660300002)(186003)(2906002)(82310400005)(26005)(4744005)(82740400003)(81166007)(41300700001)(356005)(4326008)(8676002)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 17:59:43.6569 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 222d5ad8-3e06-4520-45b5-08da770c46d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6556
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
Cc: stylon.wang@amd.com, Anthony Koo <Anthony.Koo@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Chiawen Huang <chiawen.huang@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chiawen Huang <chiawen.huang@amd.com>

[Why]
Enabling stream with tg lock makes config settings
pending causing the garbage until tg unlock.

[How]
Keep the original lock mechanism
The driver doesn't lock tg if plane_state is null.

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Chiawen Huang <chiawen.huang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index bed783747f16..5b5d952b2b8c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -110,6 +110,7 @@ void dcn10_lock_all_pipes(struct dc *dc,
 		 */
 		if (pipe_ctx->top_pipe ||
 		    !pipe_ctx->stream ||
+		    !pipe_ctx->plane_state ||
 		    !tg->funcs->is_tg_enabled(tg))
 			continue;
 
-- 
2.25.1

