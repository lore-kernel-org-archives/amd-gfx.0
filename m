Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4413C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Nov 2022 16:03:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 268B010E4E5;
	Wed,  2 Nov 2022 16:03:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FBAA10E4E6
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Nov 2022 16:03:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0MiICsXtLecD+D6hiXpcluqgcXDxEjUrwAhoxObOfZ0aq8rUyHAZlXOE51xSFaaHAROakWAEMKMN4DmflzbU9LovSNSTvwamvWtq6uL9CHisXFQ7vImE8mqdmTOO1PfuEJ1RyvJfjwtX04SCxL0F//bNrRf8YjCCQISl6BvZ5Smcu9ZkButvd0rjXmzNXLxAje6vLo6ybzTaWkXngYP3OUDw5vdJGxijIDFbijlq0f5vL2zWVI9c8XKOiAayEdJy4kXhD+3qpxJ9jYm9spAG+XNfW0FHmJIqgkBHIIjI3wICAIPKZ7F6cIEOT8bKusdzJllEimkfykvWWzgAWdNaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOPMK79Ci4Oj5Z8yxOVLy1ofNY+VWmC7FLK5wy3OOhw=;
 b=UdmkN+yzsllomzfRqpeqplCwxDIaMJ/JrKbQJHEnbuxst+/NHjV05oIjT7msXR1j9IbPHa3d8NwDjXXylXm9xj0H2sGv7ZJC0fnXTDfUzUjNpH9bQG/T2F/uHhdyOqw4bnUXSFna7JOrPs3uT36kCygXFfoYwCUaeZXY3jiymhzsLmQU+auqHU2nYONV7HcRO3fgk73ZlTsClR4LyF3ENrYEcOf/I8z0Cx1HElvzssf9P7g5AEkScVXZYc2NR/qUjAKyYEUJQBOp/1D907axRRfppBO5Xv7TwuJt2XyL5899jWbo6YMoNM3oXcv/TU9iNTPXuKpd7Ec4tiBq4p4M6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOPMK79Ci4Oj5Z8yxOVLy1ofNY+VWmC7FLK5wy3OOhw=;
 b=WeVwyON3jhI2rLh24nQkd1lCHvqfj+06gWc37x7+nSjrhZYhF46q5PahVJwGCGd4r4/b6YkvWt6hSBrcWdDNfMiWVyyqb4SepzdlpiA9+js5jG4yyZhMdrtsHjjscHLO49UmiMTXM8h1y92eyIAjMQBIySeYIX+bfEWsklxK3PM=
Received: from DM6PR08CA0032.namprd08.prod.outlook.com (2603:10b6:5:80::45) by
 DM6PR12MB4169.namprd12.prod.outlook.com (2603:10b6:5:215::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.19; Wed, 2 Nov 2022 16:03:48 +0000
Received: from DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::5d) by DM6PR08CA0032.outlook.office365.com
 (2603:10b6:5:80::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Wed, 2 Nov 2022 16:03:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT096.mail.protection.outlook.com (10.13.173.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 16:03:47 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 11:03:47 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 2 Nov 2022 11:03:43 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/22] drm/amd/display: Disable DRR actions during state commit
Date: Thu, 3 Nov 2022 00:01:07 +0800
Message-ID: <20221102160117.506511-13-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102160117.506511-1-HaoPing.Liu@amd.com>
References: <20221102160117.506511-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT096:EE_|DM6PR12MB4169:EE_
X-MS-Office365-Filtering-Correlation-Id: 616512bb-549a-4f75-32c3-08dabcebd392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nSAeMCN5y9J96ONhKQCJ6pL2FMSaNAoI0JXiHwE3QuTS327xrtNs4M2yOsJahS+L+bUM/jz/MokujC/tpZgKG5CkpjXp6HKxz5XcOXyEnkq7b1oOdVi9cG8JUkwgjM6/vdv1MAs6Y3TIaKfIj2qEPN8FenftL9bW57ssFeIfPb/CStWudtQT/0tLpczV0L6EL4obOEyTyvyTnoE/QqbM7RT/TuoUbikxE8V94rTE9hN9k+AVLHSFyeN5G6/zas34QvFCyqqNI/R5P3aSxMRpo/VmcgVrxywMcDJtA7lH8d7Kix0z3hE3Ie00rDuz3OvW5r7Hfk66sE3pB/O6eqtsyf2ntsJyUsv2CRR7ucO8FK+xUX+aLJ/8ElfQH1yHd0uvEmRRQvf3VXn3RTr6JJSvrezeK5gXSODSfWGYwZ1NRmSbhhTfNfc7N1q90vpf3wD0+mQc2zkM+OSisvr0wVCWxyA7DvTJx6aoekkOer29u0O9XSF/95XJR/cuCUgcXtzqsjWkFwmFD2U6n+z60M3N3vuIqNnbsscd2iKdWWnQ2DQH+yFSLg22hafPTGSxNSy9ZOil6fYA455yFHEGFO6enEPdOJDYGyqzSXvJr4rJUAtc6SMhTjpTtiAPnPFSCpkCIUZ7l5NnLkaFelqCt0PfHTa13r3cz1XcQIAWR2k+D+YAmHWN/ATJSLKVIBfPsyIupxGyO5fNLNYdUAiS4pDDmtjEISaDoKoac+mXj5km29H9L6yxH3D1ohCF7pCYQZct7gsmBfd5HtNPhKeVBCFmdVwFUjCCrUyI6kfWlQ6wXgoaSLqEEKcahY2U5wtrU/OC
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199015)(36840700001)(40470700004)(46966006)(356005)(86362001)(36756003)(81166007)(82740400003)(8936002)(40480700001)(40460700003)(70206006)(2906002)(6666004)(7696005)(478600001)(6916009)(82310400005)(5660300002)(54906003)(41300700001)(36860700001)(1076003)(4326008)(70586007)(26005)(186003)(8676002)(316002)(2616005)(336012)(426003)(83380400001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 16:03:47.8475 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 616512bb-549a-4f75-32c3-08dabcebd392
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4169
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>,
 Wesley Chalmers <Wesley.Chalmers@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
Committing a state while performing DRR actions can cause underflow.

[HOW]
Disabled features performing DRR actions during state commit.
Need to follow-up on why DRR actions affect state commit.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 8c5045711264..c20e9f76f021 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -992,8 +992,5 @@ void dcn30_prepare_bandwidth(struct dc *dc,
 			dc->clk_mgr->funcs->set_max_memclk(dc->clk_mgr, dc->clk_mgr->bw_params->clk_table.entries[dc->clk_mgr->bw_params->clk_table.num_entries - 1].memclk_mhz);
 
 	dcn20_prepare_bandwidth(dc, context);
-
-	dc_dmub_srv_p_state_delegate(dc,
-		context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching, context);
 }
 
-- 
2.25.1

