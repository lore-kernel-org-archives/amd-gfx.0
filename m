Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D64C43334
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jun 2022 22:30:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C143113915;
	Wed, 15 Jun 2022 22:30:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90EFB113915
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jun 2022 22:30:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dndJmFOnQfs1D57OnFJcV1f821sTDXlFlUd0lp1SNGXrP1Kxr3vv3bs8OLPLtZf1zoMQsbD072IL1dh2nT/yxcUnmaqDAp4acrrCyqp/peOwyj2qxDAhbzzsfdETSeNa7aCGvfB1uNc/WNRSDlt+WEsBsB2c/YfgVimPlJZoKdiOmeYLwmKj+dYRvRkhYCf1pUMdf9QvctaXXcFeXh+/732WD2iQY6c/T3TdbIurV1TVkrCcNTL9TZRQS3zQzk1X/ilg2zEW24B+XQNFReWu1ht/sEaiIeDL64cXk/OJRMCkMPSkxt35VbvzCKD+jDwCp7xejAv83Us1iUkIypNFYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivQjSprw7xB53FbujS1fR+Sc5MZa2NG5Zf3kDKKLXjk=;
 b=SW8j2SLF5Tg4sqULb387QoDDZlnuiL2Ua93wIiZoLfKfyD2NRN9w2yGK5ospG0TcvBv9h66M6P9qoh7lQcBevU2XdGjWON/RsJgMrZ5ic7hlZHi96fp6RocXJmOCPlBAjY/ilQ4xonTExokETyvbsoF28Tgp0OKw+/BafLIdcNvbhpEtwAeAJZHU4Ex5LFGKy25kRe7FF0NADk6BgF/yUZAzEWunIjomlnjYWl0k0+0yLIJUBAhYeaQpqucjGekmQ8mCGPLJ/NrDTE302FCob149RJLSTmGGmS+oFlPWNI0KxRWS/rwBSn5DtR4SVBD17dn+Ickru3bPLvXRNnXk2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivQjSprw7xB53FbujS1fR+Sc5MZa2NG5Zf3kDKKLXjk=;
 b=13DVom98SXwsU+7avsqaN726WwSqdsOAGIbPsTKleQCbu0uqa2XotxerNoCoqLyYBif3j2lS+lWWzhWHjGqmYZrSxcg3Vtn1Rmljv2l3lu4p0Bt8XdwmNLYZiayFJFkQSNwsPk0s6sj1iKwdGmGpOwdZ9WqGQQD6NNBO4Pfql1E=
Received: from BN7PR06CA0069.namprd06.prod.outlook.com (2603:10b6:408:34::46)
 by DM5PR12MB4662.namprd12.prod.outlook.com (2603:10b6:4:a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Wed, 15 Jun
 2022 22:30:11 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::1f) by BN7PR06CA0069.outlook.office365.com
 (2603:10b6:408:34::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12 via Frontend
 Transport; Wed, 15 Jun 2022 22:30:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Wed, 15 Jun 2022 22:30:11 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 15 Jun
 2022 17:30:10 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Revert "drm/amd/display: keep eDP Vdd on when eDP
 stream is already enabled"
Date: Wed, 15 Jun 2022 17:30:05 -0500
Message-ID: <20220615223005.11667-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8942856-fd1d-4591-7e09-08da4f1e9c1a
X-MS-TrafficTypeDiagnostic: DM5PR12MB4662:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB46623A04E3D5AB56CDB09A20E2AD9@DM5PR12MB4662.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Mpqc0WmccNSuiUFQCbrCfuL7TpimYf6yI1Zov91vwhVhGOKO6SQLjV+Z+QmhoE83DClRh5A/hr80pyJ99gyl2LN+DHo0rftlpS8y9DYBE1BaNprh8U3alGydd+aJnQF6SB+/ZBE0ivvUZCNry5tv5aQVbhwMwsIOdG0gpM4R9ughUUgY9Lkvot5raZUdU6A4St6HEgoO5BGxvDVVwX4MkdnNQaDymIIaBcBMXDafcCG5iencoXtCITuObdhrXjBAQm77T4NH1c+GHVBFtkFuGKVGXdD3lGIwSgP8ridfEV0SyjtWrE/mq1j5H7DUor4YFM5WZaL7v0wXlGDuw58C3l7SJN8uNUCUiuV38rVTcn2S/u/sJuKWQkBjqzZdZOQZIrIBJ0nOW7fCFJpgGtHTeoIVt+9MsKOHBQWeTpftUV55AKLL7gX7vMcKqC71cHUpxWzt6eS4QTBeqfmbAVpC8PVWpXD4t4Cw28O8OYT9/Ddg4PrYrjJTS38tthN19W3amlTgP0yjpoc8+5I1pV3BLW94Ulu/rci6MZ1D0r5ls0SOdjf46TrU822DkToTDvO54CDSrEggsOlXERXSKIhdQVGevUHbHSqx/JOLU82v320mnNBOKDrpFIFaQXbno5pzW3VOj7dNT7HtjTAHdFJJnnSoea50Vj1i/N964GDGl2tkKSsva/MKyyGvXODL5yRYwZ8oZrFCtfltp9meZPIkw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(46966006)(40470700004)(36840700001)(336012)(186003)(1076003)(47076005)(426003)(16526019)(7696005)(81166007)(6666004)(2616005)(86362001)(26005)(36860700001)(83380400001)(356005)(44832011)(508600001)(8936002)(5660300002)(8676002)(4326008)(82310400005)(36756003)(2906002)(54906003)(6916009)(316002)(966005)(40460700003)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 22:30:11.2160 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8942856-fd1d-4591-7e09-08da4f1e9c1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4662
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
Cc: Aaron Ma <aaron.ma@canonical.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

A variety of Lenovo machines with Rembrandt APUs and OLED panels have
stopped showing the display at login.  This behavior clears up after
leaving it idle and moving the mouse or touching keyboard.

It was bisected to be caused by commit 559e2655220d ("drm/amd/display:
keep eDP Vdd on when eDP stream is already enabled").  Revert this commit
to fix the issue.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2047
Reported-by: Aaron Ma <aaron.ma@canonical.com>
Fixes: 559e2655220d ("drm/amd/display: keep eDP Vdd on when eDP stream is already enabled")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../display/dc/dce110/dce110_hw_sequencer.c   | 24 ++-----------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 7eff7811769d..5f2afa5b4814 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1766,29 +1766,9 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 				break;
 			}
 		}
-
-		/*
-		 * TO-DO: So far the code logic below only addresses single eDP case.
-		 * For dual eDP case, there are a few things that need to be
-		 * implemented first:
-		 *
-		 * 1. Change the fastboot logic above, so eDP link[0 or 1]'s
-		 * stream[0 or 1] will all be checked.
-		 *
-		 * 2. Change keep_edp_vdd_on to an array, and maintain keep_edp_vdd_on
-		 * for each eDP.
-		 *
-		 * Once above 2 things are completed, we can then change the logic below
-		 * correspondingly, so dual eDP case will be fully covered.
-		 */
-
-		// We are trying to enable eDP, don't power down VDD if eDP stream is existing
-		if ((edp_stream_num == 1 && edp_streams[0] != NULL) || can_apply_edp_fast_boot) {
+		// We are trying to enable eDP, don't power down VDD
+		if (can_apply_edp_fast_boot)
 			keep_edp_vdd_on = true;
-			DC_LOG_EVENT_LINK_TRAINING("Keep eDP Vdd on\n");
-		} else {
-			DC_LOG_EVENT_LINK_TRAINING("No eDP stream enabled, turn eDP Vdd off\n");
-		}
 	}
 
 	// Check seamless boot support
-- 
2.34.1

