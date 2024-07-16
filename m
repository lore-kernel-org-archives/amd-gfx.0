Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B46C3DA49
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jul 2024 17:33:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB5E410E813;
	Tue, 16 Jul 2024 17:33:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WEvXj0b8";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A71B10E813
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jul 2024 17:33:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P5SarppCyqtQ9+MM0IUVxUEl19j2nH2MIlZ+D8D9xLLEFKa572tUeBo3j7OCr2WN1gjDsy+AJzWydRWyMF0ytcphCEJxsozP1+z9dUjbjXuDdC0orPCld+cm7ebldBjnK21VV29DezfukLkQkwP+D9GRpEnua1vgUgjuIm+VpKLdfaW6bT3M3KndYho+elYJsu0oPg5Ct25RYEHoynh3xndjzaXaUJtAvQA9IgpbNtVu5qr1Vevke7J1CJzkltRUTHRmKYXmB3xUgsWPOpTHVo+rGNjSu1cqWZ6ABR97TcB9XKmwe3pLyZgwMnznOgQEDz2LqJYSPIKKT/tw3CPPiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQswMtPZE4Rvm9sJaSpzlQBHfegW5S3AXszbODPH6Ks=;
 b=k/OLjyKlQZCLLRB/SIMk2m2Zpy3rMMaw2eyTvkVaA+2LfBbCagygSRaUMIS0h0e6X02wJwhVZQvbMGsczkfo+3NwcLkkXU2/o3/PngrOuw+MSNperR/8AZYqnisurnkuLfV/LHGN3jhuYAsafEh7pYcpCfGlaJ698a05CEl7zSMPpZ6a3qU/C4/MX6natlz403G2xr0HlmmdmG/+fSVXbCBgPBJ/jI4xH1mWQH3fPMxa6bbwvD4h8e6wc/SW8jlDf6/1J2rco4ku0Fk3HYqxPJRW1puEeNqaRR9kZq8Fz74LK0HMSCp/+G+TY/3eullG5Md2F9o+fJntK0A0tyPI7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQswMtPZE4Rvm9sJaSpzlQBHfegW5S3AXszbODPH6Ks=;
 b=WEvXj0b8lBSltKKDV9WymAEYmWNmZBNfY5ZJ7SE7vhWlVE+EFl0Gz8N0opvz+lR1koj9QR64Hv4NycVEUJzMKUi3KF4a4u3bhwmlXPqY/JNvjm+sG3U+wbpDCddC6Ichp5C4+FmkFZTijQ0e3wkqWKjtY7RBOJr4LgCvwOIMbG8=
Received: from DM6PR07CA0062.namprd07.prod.outlook.com (2603:10b6:5:74::39) by
 LV2PR12MB5943.namprd12.prod.outlook.com (2603:10b6:408:170::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.14; Tue, 16 Jul 2024 17:33:37 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:5:74:cafe::62) by DM6PR07CA0062.outlook.office365.com
 (2603:10b6:5:74::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28 via Frontend
 Transport; Tue, 16 Jul 2024 17:33:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Tue, 16 Jul 2024 17:33:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Jul
 2024 12:33:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, <mikhail.v.gavrilov@gmail.com>, 
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: [PATCH] drm/amd/display: fix corruption with high refresh rates on
 DCN 3.0
Date: Tue, 16 Jul 2024 13:33:22 -0400
Message-ID: <20240716173322.4061791-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|LV2PR12MB5943:EE_
X-MS-Office365-Filtering-Correlation-Id: 505d3b7f-54bb-409f-6a8e-08dca5bd6cc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qnQW3ex66upzTYXAxFsn666nRZEDerW0hSySVf85SGSgJs57Rv6goK8ZmUqa?=
 =?us-ascii?Q?iFzI6vp33xuFAX6V+pPxBzZor586xObArvimHka2fMOSAs7UgbThEOv+2AZa?=
 =?us-ascii?Q?WDb9B6eo1clIYeRCj0CdlkhekOe2AA/p1pKRXsfFv7ddgzjD4tbTZL/6T9gf?=
 =?us-ascii?Q?klh35296y7hGpNiSgfuwiMEVLAef/lduXEHPdt2deSfoCIAvs0HEwwyoROtD?=
 =?us-ascii?Q?X47I6KQdJ4lOMdgWgs70xjgUlrjw7yoaeu/2I+I57Fg2h3WRE2T1kcUDLdj1?=
 =?us-ascii?Q?NVF4qI12ZsZ3IY/Vd+JMoEG4/Sq3jlXePLiRokVdhg7IcHML8W2TjeG8/Qwg?=
 =?us-ascii?Q?3a1XCSYf2QIbQkThpJCnpJZCcoqmyal01EflKdzHrJd/qTqZSr2Dw6HMLggU?=
 =?us-ascii?Q?bqpCclBf5JPvFV2axmw1PkAq3CQ4H+zVnLCYgMBdWLhyFXqpYICQD8AzfWIU?=
 =?us-ascii?Q?ULntaIKaxd6512WUDQfB+NvZZg+PBO1hMLzlKwF3CHqQLHJExULCZQkJ7ene?=
 =?us-ascii?Q?Y7Ai9fcXIo9vwFcdNDNgLLBXmXzd9Du2lT9C61F9ZYDjBf9hEYji04qkRqL7?=
 =?us-ascii?Q?1a935Ir5ULV08+ClDNKy/3/mgdi12eFXdpNejfXRXTEgNvMDtw04fH89F9Py?=
 =?us-ascii?Q?geTKDUkqbdXspgsgcZVx/ANzfUwSveBR7o215HVh8vfmCA38P7a/rMmiXapz?=
 =?us-ascii?Q?aWJYc6/7nfd0IWQrz3A+8dL/aa7Gx46gvZyPd6dlJIBi0C9dMU++eLMPZ6aE?=
 =?us-ascii?Q?DJFIYB7W5Axhrmaz8N09zG+QPAg2cQjpd5pzd40wmR7sh1qZJ68JcwEE3nET?=
 =?us-ascii?Q?Bnx3FLJZtEazth89SlaUjk8O+b4zFgoj3SeIzzytvuuwv93CW+zh4nemeWhP?=
 =?us-ascii?Q?GZHpFmeDEQ/XVZrmf8AJUI8zrCxA85f8rp5n67TGrfQdm78iH9P5V4EUjVk9?=
 =?us-ascii?Q?pqJJ/kYdtpn0yZnUQqLovsIRyWNsxrihylcXo55KVo4Osz7RGYPp/kgak8oc?=
 =?us-ascii?Q?miL+IT/8kTrT8+gtyfFqWAdmBjtx4DCupfplnboZFBFJtKn3lOu/Qifndtpy?=
 =?us-ascii?Q?ruPk61M8FXjflmzN0VFmEvGghvWc8ttJbQS3txMnHymFNnDjpXvDRpXgQEYF?=
 =?us-ascii?Q?KukjXjkLnVyOdtez4IXvVLfg+Ca6Qp2mYVp+ecIQHQgtsO6lRhn/5z9XIr9a?=
 =?us-ascii?Q?MTjwDyGka0wZmcjfwBVgWmyiUxoHJS7cTBRgT1mQqA7W1n5wwnRayiiIX//G?=
 =?us-ascii?Q?+jh536t+/d1WBmgsypBZ5N+uDKDSCBUKibmLsXe2aig8XL0m1VngDAQy8i2Q?=
 =?us-ascii?Q?P5O+ieGaFXSxEsVJoUs+vo5rO55xQckFL7x7OFT3lLXof+OjX0AFoZvAl/s3?=
 =?us-ascii?Q?rJKFpw1FXd7kIDeyKpVY+fKa3lPf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 17:33:37.0887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 505d3b7f-54bb-409f-6a8e-08dca5bd6cc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5943
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

This reverts commit bc87d666c05a13e6d4ae1ddce41fc43d2567b9a2 and the
register changes from commit 6d4279cb99ac4f51d10409501d29969f687ac8dc.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3478
Cc: mikhail.v.gavrilov@gmail.com
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/display/dc/optc/dcn10/dcn10_optc.c    | 15 +++------------
 .../drm/amd/display/dc/optc/dcn20/dcn20_optc.c    | 10 ++++++++++
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
index 4f82146d94b1..f00d27b7c6fe 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
@@ -950,19 +950,10 @@ void optc1_set_drr(
 				OTG_FORCE_LOCK_ON_EVENT, 0,
 				OTG_SET_V_TOTAL_MIN_MASK_EN, 0,
 				OTG_SET_V_TOTAL_MIN_MASK, 0);
-
-		// Setup manual flow control for EOF via TRIG_A
-		optc->funcs->setup_manual_trigger(optc);
-
-	} else {
-		REG_UPDATE_4(OTG_V_TOTAL_CONTROL,
-				OTG_SET_V_TOTAL_MIN_MASK, 0,
-				OTG_V_TOTAL_MIN_SEL, 0,
-				OTG_V_TOTAL_MAX_SEL, 0,
-				OTG_FORCE_LOCK_ON_EVENT, 0);
-
-		optc->funcs->set_vtotal_min_max(optc, 0, 0);
 	}
+
+	// Setup manual flow control for EOF via TRIG_A
+	optc->funcs->setup_manual_trigger(optc);
 }
 
 void optc1_set_vtotal_min_max(struct timing_generator *optc, int vtotal_min, int vtotal_max)
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c
index 43417cff2c9b..b4694985a40a 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c
@@ -453,6 +453,16 @@ void optc2_setup_manual_trigger(struct timing_generator *optc)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 
+	/* Set the min/max selectors unconditionally so that
+	 * DMCUB fw may change OTG timings when necessary
+	 * TODO: Remove the w/a after fixing the issue in DMCUB firmware
+	 */
+	REG_UPDATE_4(OTG_V_TOTAL_CONTROL,
+				 OTG_V_TOTAL_MIN_SEL, 1,
+				 OTG_V_TOTAL_MAX_SEL, 1,
+				 OTG_FORCE_LOCK_ON_EVENT, 0,
+				 OTG_SET_V_TOTAL_MIN_MASK, (1 << 1)); /* TRIGA */
+
 	REG_SET_8(OTG_TRIGA_CNTL, 0,
 			OTG_TRIGA_SOURCE_SELECT, 21,
 			OTG_TRIGA_SOURCE_PIPE_SELECT, optc->inst,
-- 
2.45.2

