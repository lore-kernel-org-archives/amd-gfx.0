Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD52FD41D51
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2024 19:58:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72DA910E63D;
	Tue, 12 Nov 2024 19:58:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OMSK0G9Z";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2062.outbound.protection.outlook.com [40.107.100.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52F8410E63E
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2024 19:58:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DDG+2YQQif0qZcR/RtWQtxzONuQwEMuQeEMXogXr3mwnCS/b1Z2yLL2Yg/kIVAgj6uK4MtsrBMxzmidCwK1XgW/gWF6IMNNcZroDhr0GswDT1lrVZlREP/JMGWk4lUAbc6CbiCEu42h7Oy6OIQwFaECaWUulbapwxEnyuohdGx2RBjqisNCfWJEw4tojDL2kyp9jm7eZpylPJzR3mt2HlWbknoTpYdN1y4ape0fsXdDNYBZly9c6geJJ3Z35ddIJofLO/Znl+ltIItQnRtH8B1heaDrbo8yyJP84oNzOfvgoNXrD5EVyqqBSnMwBp58OPM84Sx63jhXNaC/S2mEbXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3bnsBpNFRsnJoafeKVVusTNuP7n5xaIRm+gpebM2c4=;
 b=JK8fjyq44ZjpRG/21tW85lx6IRl5ena2xih8V7Ro3EhRsm6axycyrVeLn2tSOuN9Y6y8SOSTAa52j+xcedqZ9TVyYU4U86Z65lNLZ/iB9ASlwJz2RdLLOXyCHtAcPMzbfxmPkHUYRtV7r8clniegHJ0jR44SavM81R/VAFeKklyxSMPTMbFp4a8nGbJmWzFSCx/pwCKY+YEkwc2GrUbPV71rhK0yQLzy/06yg5BSfSmFDeNPuq3C25DNHdnM6NdsBfIHsyOnpUn7OeWKgDvxN3yWYti/TdQqDA4ya0AxTTbjRaZjmVQshGxY4BCPuMqrcFz30myPzWB5z/309+Ak+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3bnsBpNFRsnJoafeKVVusTNuP7n5xaIRm+gpebM2c4=;
 b=OMSK0G9ZM2XV8LMYh+hvmCuJbE7KE0mHZRqfcD0sRG7RwvqFKT5Y+bBuBXafA819lnFysWAJ/v1fWocYvDocSOqqlBbQ8hXaP4DJQFGw9/X2bldTbb6xOqgDAvOTCUka6pD/vc9UaUrSff1ana2fwy9O/gTGasbLJfoN4BLShLQ=
Received: from MW4PR03CA0274.namprd03.prod.outlook.com (2603:10b6:303:b5::9)
 by DM4PR12MB9069.namprd12.prod.outlook.com (2603:10b6:8:b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Tue, 12 Nov
 2024 19:58:28 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:303:b5:cafe::2a) by MW4PR03CA0274.outlook.office365.com
 (2603:10b6:303:b5::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27 via Frontend
 Transport; Tue, 12 Nov 2024 19:58:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.1 via Frontend Transport; Tue, 12 Nov 2024 19:58:27 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 13:58:24 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Ovidiu Bunea <Ovidiu.Bunea@amd.com>,
 <stable@vger.kernel.org>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 8/9] drm/amd/display: Remove PIPE_DTO_SRC_SEL programming from
 set_dtbclk_dto
Date: Tue, 12 Nov 2024 14:56:03 -0500
Message-ID: <20241112195752.127546-9-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241112195752.127546-1-hamza.mahfooz@amd.com>
References: <20241112195752.127546-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|DM4PR12MB9069:EE_
X-MS-Office365-Filtering-Correlation-Id: 379d431e-475c-4fdb-5645-08dd03545fcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eLc+zMJjKCee+uEwZDcLi+VV1ht+vlhKSyAoRN61NfnkCFfBqK/rlFsMZeuq?=
 =?us-ascii?Q?100aPrxKH2C7I7xcEK5Bs6rTJ5gH5SYBAAVBxCQOCiXg7Tv7PhDdXTCAej7s?=
 =?us-ascii?Q?hNbQxzx0Evy+7X09tcRjnXOrG/4Khxt+PuNevEUwOAT0G6H2ES/6WP7SKyOe?=
 =?us-ascii?Q?eIblbR1an0X1c5CHkHpxqzzGU1aJA3KYW275FNnUpy63ZfuutnsZkGG6zfRi?=
 =?us-ascii?Q?6CCsK/vIfv4wkqu99xCgunNqSKYg3egwQ3V3rGUMPKbB9VL5lJfBnHz3U715?=
 =?us-ascii?Q?WdLE5ERt2enhOOnJwv7/faQHjAYdJeft5SymuV9MC11+rpLqf0Y2znPV7R4m?=
 =?us-ascii?Q?/SCYj/aYidt8DieRaN4QPAWYqj7QQGgC4UmA2R3elAB1QuyKmxa1c58Tu+2T?=
 =?us-ascii?Q?TkRuiiBGoM7edZQlYlA/apQyQQ57EHakY3NH6LOTQeE/Khp8UV8+C/BPvRAY?=
 =?us-ascii?Q?bXiC3AoMM4fRokv/eT+iKSa0lmUpIUIT+2YEHr9gW//TdrsxNFU6BEcAFTBQ?=
 =?us-ascii?Q?AEdxCPEZAGPOV2whKzcllkzkGBIJrNmWtbO4PUqtBSGUQfSrgOaT6OYXAUil?=
 =?us-ascii?Q?RfF3G4Yx62LJ1LLTFEZu1dHQzE0a+fPT4pDxnBwEtJAO+hKqb4T+GodkreK/?=
 =?us-ascii?Q?JKlZ60iYu6Rtne6Uft50yy/M3oiyoX70vtyZyCC4YbfiE5HsRW4gIZKAAhoX?=
 =?us-ascii?Q?JHeKm3WFZ5pZ7y3/HLH/BpWWk6N2F5rMWODGuM1NLlaPfbqrj9h6Jh/ciWN3?=
 =?us-ascii?Q?uJBYfL2BNPyYhp5y+ZLSeGVQxKxhvSgE01QYoqU0bDDafxnRpPTN4CDe36Bz?=
 =?us-ascii?Q?q2WIgSS48W6w4h/+tDSg0DbSKir8QAAyqnYiXOUpr8cW8vRQW93Qt59ahZCl?=
 =?us-ascii?Q?nB48ULMi65662Q3tj811bpLnnal8aK3yBRRWsSpEyzcB8zzBCI+tPHlbV6hG?=
 =?us-ascii?Q?7IVUxa1ggXCEWT1c8TbdITxcQBwwno72aBSrr3AALSsKWMx0XTlv3hGR6oP4?=
 =?us-ascii?Q?paegCmOENgtdy3r7hipWX+uF+CUUXaA+dr97foZiEuZXe4mSaS8mRvqKv6l5?=
 =?us-ascii?Q?46E7il3xRZRWR+MJua8h49awaPjz2l2/uMw2xIkIhNZKxEOE2dmEmtFxWLk4?=
 =?us-ascii?Q?rFNT59UZzFfChW5rUUY7Hv0+zN6p1c6Ph7F5lEElqBn4cZS3Nr1H0WtvlZ2n?=
 =?us-ascii?Q?i0ToxwPYTpzBImSJ2YEJ8mqQIzEexYg7hBz53OklOMNJLx30e1bD9ZEO6Evo?=
 =?us-ascii?Q?abYQCqQISeMZtOrJhwEOHXdAHtp5/aa4Ukx6EDCwhpPdObPS4VpSPkvmlRfA?=
 =?us-ascii?Q?/e/UvOzY8piYcg/iTGSu5zuCXDXqf2VInvOT144Xh3AGPpMOfo6aIQuEsBE+?=
 =?us-ascii?Q?2nunVuiIKJQxG1/ljIaMKwVTMg6jQlZCHx29rNvNMuKrka16gQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 19:58:27.4319 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 379d431e-475c-4fdb-5645-08dd03545fcf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9069
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

From: Ovidiu Bunea <Ovidiu.Bunea@amd.com>

There are cases where an OTG is remapped from driving a regular HDMI
display to a DP/eDP display. There are also cases where DTBCLK needs to
be enabled for HPO, but DTBCLK DTO programming may be done while OTG is
still enabled which is dangerous as the PIPE_DTO_SRC_SEL programming may
change the pixel clock generator source for a mapped and running OTG and
cause it to hang.

Remove the PIPE_DTO_SRC_SEL programming from this sequence since it is
already done in program_pixel_clk(). Additionally, make sure that
program_pixel_clk sets DTBCLK DTO as source for special HDMI cases.

Cc: stable@vger.kernel.org # 6.11+
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Ovidiu Bunea <Ovidiu.Bunea@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 .../drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c    | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
index 838d72eaa87f..b363f5360818 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
@@ -1392,10 +1392,10 @@ static void dccg35_set_dtbclk_dto(
 
 		/* The recommended programming sequence to enable DTBCLK DTO to generate
 		 * valid pixel HPO DPSTREAM ENCODER, specifies that DTO source select should
-		 * be set only after DTO is enabled
+		 * be set only after DTO is enabled.
+		 * PIPEx_DTO_SRC_SEL should not be programmed during DTBCLK update since OTG may still be on, and the
+		 * programming is handled in program_pix_clk() regardless, so it can be removed from here.
 		 */
-		REG_UPDATE(OTG_PIXEL_RATE_CNTL[params->otg_inst],
-				PIPE_DTO_SRC_SEL[params->otg_inst], 2);
 	} else {
 		switch (params->otg_inst) {
 		case 0:
@@ -1412,9 +1412,12 @@ static void dccg35_set_dtbclk_dto(
 			break;
 		}
 
-		REG_UPDATE_2(OTG_PIXEL_RATE_CNTL[params->otg_inst],
-				DTBCLK_DTO_ENABLE[params->otg_inst], 0,
-				PIPE_DTO_SRC_SEL[params->otg_inst], params->is_hdmi ? 0 : 1);
+		/**
+		 * PIPEx_DTO_SRC_SEL should not be programmed during DTBCLK update since OTG may still be on, and the
+		 * programming is handled in program_pix_clk() regardless, so it can be removed from here.
+		 */
+		REG_UPDATE(OTG_PIXEL_RATE_CNTL[params->otg_inst],
+				DTBCLK_DTO_ENABLE[params->otg_inst], 0);
 
 		REG_WRITE(DTBCLK_DTO_MODULO[params->otg_inst], 0);
 		REG_WRITE(DTBCLK_DTO_PHASE[params->otg_inst], 0);
-- 
2.46.1

