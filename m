Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A87C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jan 2022 15:33:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DDC810E37F;
	Tue,  4 Jan 2022 15:33:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 538E410E37F
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jan 2022 15:33:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uq4lLVWE83pQMZ9G9dIXHIeecXFUChaSh4/CQkcB909fOdprAZP4co1agfm1ItkuzBntE7KO45nLbuGxCC2dwfHdsCJM36Dn78/jG3ubBETFtNMWt4o4vquSLIV023BYPoe4gEZBSpl1kut3laZZStudmm0JrCA8r6GReM+kk/5CtfWMHYB+jEQLKOYuZgfBT+JecQjN4m247sUH22//t6p+XuF1PzT2g8m+13wtXm5KflACy8dahCz0EuyOtZ8ZvzgJZbCf/9Vj37z8HsiOb/mbUovrAAStAShClonJRIbMLZ4OxnCooarPTDVmtB839QcHlIXlruBbNgbOunJLhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+HRplnjxVUvosAkMaCMTh3ymXMfN4wDBpXDVjv2NyiA=;
 b=JgiVZbpv6MhY7kad+gKwiUmJMMMZ800w3Z6QX7xcwQn2r2x2xovXgc8Z9zCUtQZ3YEiGyg8R1wRE2Z5/8VEFBxGcLIvLQh39mdyeljMigOihPBTfchE4wieyupvtgas28gr8S7avqodxikHMMVgYbndi3cpWKadm5M6GizTFaBEkcnNjwC7vsb1LMPRZwBKazmp60iqWuVV3vDdCkMA7AoVmFOStpeHO0SDj6dS++l6smAP3Gn4PLW+q6sTust1cWzfPJ/cYb2tpBGg01Ch1Sc5Hd98gKS8yEa331x4Hn4hunN2x8KDeJw7TkZ8AOOgdUgT8DI3tKN5mftscys2a+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HRplnjxVUvosAkMaCMTh3ymXMfN4wDBpXDVjv2NyiA=;
 b=iv6SRYwsYZQ0W6JoL/8z+TUgvLr8YKTTAwLN9U6SR6uCyZZygIM/tDnQUS23FK+5ET8HTJN3zMp7v7GtZkTINO7SWurkQ2GUllFhvSgnuwzC+4cz53Mo9QbrPWJBm/37ujgq+DN8051fwZ8RznDzeRqadQUKdU2rt/Rd0eADxDI=
Received: from BN9PR03CA0575.namprd03.prod.outlook.com (2603:10b6:408:10d::10)
 by MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 15:33:37 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::60) by BN9PR03CA0575.outlook.office365.com
 (2603:10b6:408:10d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14 via Frontend
 Transport; Tue, 4 Jan 2022 15:33:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4844.14 via Frontend Transport; Tue, 4 Jan 2022 15:33:37 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 4 Jan
 2022 09:33:36 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: explicitly update clocks when DC is set to D3
Date: Tue, 4 Jan 2022 09:33:26 -0600
Message-ID: <20220104153326.19408-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7233b11-3ca2-4eee-aafb-08d9cf9793ce
X-MS-TrafficTypeDiagnostic: MN2PR12MB3775:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB377548BBA49CC62099BBAE2BE24A9@MN2PR12MB3775.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DmParb++3IAEOWFE9Yq36Y4f1k0ejLk/A3Sgf1qqL82cMVpvr9ciDGnu5/R7zm0XXuZ60WYyyo2PHkfjZqnd2V9vCMydLkDHswZqZGv0vlNYIctz+yO7PNurWpRsL1xyS6nv+lVwMqpUyIaK4JHUBpFjjReeoscFLQKSY8GsowD+FNEguoypMnNrwLmU1FBCSxzghn4aWim3cKfNX538Y9Pl4pLuQQnATpug/WHL/ueDg1Q544tAZsXoH2M+WTn5xkPOLVbvzcwxFG60MAYwCoyph8Kusnn3P3O2ARB9ckoSYfhrmlH+X4vouAmhJl6J4eG1gIVqtRYV95MbZ6QwuC/CPv45PsR6W8F2ogFXPja8bjFziLW8NbXTWlPTQWkTpNaQVQhTjA6Z3E/NHhAAZCWXt6xCsY1Jcg5vDR1L1aryT/poQAGSPW0jEtHf1GT55Jlhz1rTnoOomqg736QVkGeorgFFkMbwEnJyX3wVwe2aWnwHFXF7lOfPS6kwvv+qqune3VUopY3xaTY6JYKHjkiwHZP5tKwT88KehUK2In2MGeq0gwgkPSub1f1q94iNvHN9kpRa4W/bKFhYel4JYhPZHKQJ6bMD4lHWyObqrZCB/ENXXCld9+pV4hwJg/CGNBEc/VWexsLX5SX2TPGEIbAOPXh8bIc3T4SWs7NFTONxUpChDd2TsCAvo4KhJ9ZUxbXhLyDbsC5KpHeBogbHUNPAVaagEZNmX1a6B3CCf0dXhN2TY7ZLOspUV6cVeSVjZuXuRib5bOnRi4pCUbuf9CPnaBqiMUBsfOLftTtA1tDclQjGhztM8K+Qs4HcnuAqREt6955iEvxq3xird2kllCyF441SPmA0gIvViKbOn098aY2+PWMjGJEIfzRrzAlP
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(82310400004)(2616005)(36860700001)(336012)(1076003)(6666004)(54906003)(8936002)(81166007)(966005)(508600001)(83380400001)(47076005)(44832011)(186003)(16526019)(7696005)(70206006)(70586007)(36756003)(8676002)(26005)(2906002)(15650500001)(426003)(5660300002)(40460700001)(6916009)(356005)(86362001)(316002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 15:33:37.6129 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7233b11-3ca2-4eee-aafb-08d9cf9793ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3775
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
Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The WA from commit 5965280abd30 ("drm/amd/display: Apply w/a for
hard hang on HPD") causes a regression in s0ix where the system will
fail to resume properly.  This may be because an HPD was active the last
time clocks were updated but clocks didn't get updated again during s0ix.

So add an extra call to update clocks as part of the suspend routine:
dm_suspend->dc_set_power_state->clk_mgr_optimize_pwr_state

Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=215436
BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1821
Fixes: 5965280abd30 ("drm/amd/display: Apply w/a for hard hang on HPD")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 91c4874473d6..6968ad6c5a64 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3299,6 +3299,8 @@ void dc_set_power_state(
 		}
 
 		break;
+	case DC_ACPI_CM_POWER_STATE_D3:
+		clk_mgr_optimize_pwr_state(dc, dc->clk_mgr);
 	default:
 		ASSERT(dc->current_state->stream_count == 0);
 		/* Zero out the current context so that on resume we start with
-- 
2.25.1

