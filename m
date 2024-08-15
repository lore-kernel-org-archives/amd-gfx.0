Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A02C531DF
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 22:45:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6BF010E545;
	Thu, 15 Aug 2024 22:45:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qr42VzBW";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 753E410E53F
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 22:45:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dtlkxpUpfrhkjvguc5yOE+cEAjJp1hhRRGXzysjGnhzpBHazYDCWhc/TnjH+sH4QJqbk8WJLASHaWoN18dkcOP7txltCtr9SeKavVYcM9Dfhy4Sgx4Vyl/iY5iyWwGbw0ccqpQBa203AJYtmoKgoE2hXD+x+JsxSkzZlZmQd56va7/18/yHMuXjhmt8fNTssCdCcAWRoM+cfLxZNtWmc4QzqOzSDnb/gm/AEhvqN0GvtSlT2EdQhfE3x7dSMYuWxNLykONl3VQIdOfWtOWHjieAiPAs7wVAorzxKl9WaJzuHR0VOMnF4G5DpjHSSGCZNPQSHFl0mVTnzAMY9FY3RDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+V22TFsTJrNqXseRGrYnc+J1l+5OSxHPLRO7E8wcdjc=;
 b=G4c8oOdcpwvXT7e82pkvQR+z2KiGoTqSyZBTiALHZ0VuN8mgTyVu+c6YnuCN8OPyBNScSquIyTn7xQq0+OGd+CeR5jy3+O28OdmmIKfSFIKlB3HhWJ422IuKCufzTHpUPLYEdiTarSonVU8qwky/ITps+6moU7PH9ugUqnp6bnE3h/5pAV7ohxLKLGSaRRZ/PGzJB3lAYI/1s7Y2vMtXMICeOVDZHd5/4JKx/GX4+oTHTrk2+N3Pzd0hKEhkk+VtnNsNPTX8bBml8qaZ/FV0/DHyIXb6byqBHdKJ91yvx/y/ksAwdIg8MKQMqH+4doBPOOcVLfffPENXejgbJMMy/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+V22TFsTJrNqXseRGrYnc+J1l+5OSxHPLRO7E8wcdjc=;
 b=Qr42VzBWDEityTMSQCmpZ6DDyhZOPZuS3q/CO/YqKdUhkR5R2G5qRvGcATlc1UKxVBxIwNw4Wz85OPrQgS/jGF+mHI4pVLpchi0Xp/NEb6Id3EKOu4w6ugpreSbugWtJCkwhZEofd3/oouZJKg57QoOkRgSlFR184nsW/ZpqgDM=
Received: from BN0PR03CA0034.namprd03.prod.outlook.com (2603:10b6:408:e7::9)
 by SJ0PR12MB6759.namprd12.prod.outlook.com (2603:10b6:a03:44b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Thu, 15 Aug
 2024 22:45:42 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::16) by BN0PR03CA0034.outlook.office365.com
 (2603:10b6:408:e7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Thu, 15 Aug 2024 22:45:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 22:45:42 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 15 Aug
 2024 17:45:41 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 15 Aug 2024 17:45:41 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Nevenko Stupar
 <Nevenko.Stupar@amd.com>, Chris Park <chris.park@amd.com>
Subject: [PATCH 06/13] drm/amd/display: Hardware cursor changes color when
 switched to software cursor
Date: Thu, 15 Aug 2024 18:45:18 -0400
Message-ID: <20240815224525.3077505-7-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815224525.3077505-1-Roman.Li@amd.com>
References: <20240815224525.3077505-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|SJ0PR12MB6759:EE_
X-MS-Office365-Filtering-Correlation-Id: 612c2eb1-409b-480f-d120-08dcbd7bfe4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mV9R74tWkMGyCC0e+xIAz8V3FGsUyzJY/d2K7rCcx3r3wos+E+QYdNRUsheJ?=
 =?us-ascii?Q?woS25qQss3xZ/ze2B8qa3UuDU0J7iUmg+9pxPLUJcFVk9XgaYyr0zVexyXUb?=
 =?us-ascii?Q?YAuPKew9g8CuHr6DvHFHnV9Zy9J6FfaJ87khSTiAbV+OJjwP+GDCPXtanKpQ?=
 =?us-ascii?Q?IdPcvUQM8wN8U+PaOeP5I+nq710K/EfQi6eyvMagyd0NMzamN1bEr7nooWR3?=
 =?us-ascii?Q?BqMWPDc1uHw4q+W3jtBYiv7ucbbr6ZVAqyrIXBrdFktxGAODopuWVuuT7tTM?=
 =?us-ascii?Q?bfNqAE2xfMUE09p1cbYD6Lrr7ipIMj4TtzpWSPuRxi3/wpXNA57jAjcHFHuz?=
 =?us-ascii?Q?jBWwAWh136/0hdl3LuU+M+I07vxf27eQecwZeoyNtusv1f0KSCqadkV7ODs3?=
 =?us-ascii?Q?+MxBy7FRMPo+5LOj4skjvQoWy3FuZ8e236O2ietWdN0xT3U5SvDIYj0ESWAB?=
 =?us-ascii?Q?jErVZO0RovfZIt6/ilTuQFvNjATR4CQGFVSnmFdLs+E7S0oBMGGF2eVehbpi?=
 =?us-ascii?Q?bQ+iAohgDJ3MfGaeOv2EBFRCm7iAeJCAg35EeZaDgqOEPiYyRpk1I3kTMqck?=
 =?us-ascii?Q?grvRxa4n85+mPjmEBq7N0ViCCs4GCvSMYz6UAvYBcqdgrI6LiMY5LiR7ath3?=
 =?us-ascii?Q?E7oWYGEDHIWaRppik75Z1Vg5EhWezwrRQLem6WECmEinGB0K72TtMje41b76?=
 =?us-ascii?Q?gaeqvAPu5qNIOTSym4FfNHtxlZvs1ckyW1wneE/+978pG8SwXHl83Eaeku06?=
 =?us-ascii?Q?+wWi836M8jeiQrRCVvyyCJ5k45ye+Lp+eh260D+gmUQafhAlHVKSEWhq6atz?=
 =?us-ascii?Q?0XyxDvaIFCILnAFDxIfZarfwqHtfdGXbE5JDykG7rbkBOobyAWubPnpR4cxO?=
 =?us-ascii?Q?cDrSKaEuc+5+eoW/d+zIgjMNZrzAAbCrzmT/UFkQBHKj6luRQ/U6HrHdCZdp?=
 =?us-ascii?Q?KYMx6wxVz6sPvV6hFqTunL67ifje/PyJ3JMwlUqiZyvKNTLUwMtl2phIvRyg?=
 =?us-ascii?Q?N3Hoi1i/BwK38u4SFwCu5Cb1Sm6+5P9B8x97JR0wvZEL4+BMp3JvkNclv1Dx?=
 =?us-ascii?Q?4UybScwP4fYaQR4nh6UOKNScVNb9cDubVxUpEEjWgWBHbLSZsh409KMI6bSJ?=
 =?us-ascii?Q?Bv4ojmZsVDzlNHlGifb+7Ct3JFwsHH0Fccfj5K7BRWsqASAGg9vioBanfpfm?=
 =?us-ascii?Q?GCdyeh+naMKcFdsyBLkD4t/t83Uyal+xlGAbZwhgQEOu6LAz8FF47S95zgla?=
 =?us-ascii?Q?rvBAholNu91+24ks3k6jicJQq3gAW7+e2KtxQkpaLciNRIOtDPywl/TdCO5r?=
 =?us-ascii?Q?7V1+1niVTt7gha9KUMb221GlZnk1rqAmw7Zrg61EsZYYL+sWBKdeUVvh/gqB?=
 =?us-ascii?Q?Dg0HI50qh/PvIl981E/K+R0dx64oiyYEbHuf4d9j0bd/Z0t3dLC9kqVVPLHJ?=
 =?us-ascii?Q?swKMaa1d8qN7NJGyiPqkpcEFsJmS1Wui?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 22:45:42.4150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 612c2eb1-409b-480f-d120-08dcbd7bfe4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6759
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

From: Nevenko Stupar <Nevenko.Stupar@amd.com>

[Why & How]
DCN4 Cursor has separate degamma block and should always
do Cursor degamma for Cursor color modes.

Reviewed-by: Chris Park <chris.park@amd.com>
Signed-off-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
index 92b34fe47f74..3b6ca7974e18 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
@@ -120,11 +120,10 @@ void dpp401_set_cursor_attributes(
 	enum dc_cursor_color_format color_format = cursor_attributes->color_format;
 	int cur_rom_en = 0;
 
+	// DCN4 should always do Cursor degamma for Cursor Color modes
 	if (color_format == CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA ||
 		color_format == CURSOR_MODE_COLOR_UN_PRE_MULTIPLIED_ALPHA) {
-		if (cursor_attributes->attribute_flags.bits.ENABLE_CURSOR_DEGAMMA) {
-			cur_rom_en = 1;
-		}
+		cur_rom_en = 1;
 	}
 
 	REG_UPDATE_3(CURSOR0_CONTROL,
-- 
2.34.1

