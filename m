Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8EBC27C54
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:58:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C400610EAF8;
	Thu,  6 Jun 2024 21:58:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rdCJohRe";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59B3C10EAF8
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:58:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbHOka7bWblUVT7afekll7XVPyMNrMR/HsJahv2sh96gcOWQ9dDl5rJXpEzFFn3UlC7HHOqZNUrsaw61WYoHaqKqyQEMtQ65CX95iSKI/IN23nz/MCrKqS7kf4YGbpXCYUMdYqJXXl6Hwk2UjmGGuMw3H+wqEDp3eivSFOdzOCNF6Gx0udQUkDbNiyaj2cF6cXNEuOJFK7A2XUcHKkOR+xcQL2WOu9y5aSPeCKGWAEBfuMPAm8teu9PoSMObXvQYc7ClEtHEOid2kcwlhii+b/F5nN0AJ5vSuoi0rqG0Gaukw6x4dtyAQF2XMFuHQVMPelw5il4od6puhNzws0Luyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfp0hueRd8runsxlS0CQsAfBaUvPLs5iAcqMacnJGRM=;
 b=fP20Yi5qKtP5KUQoJYUlKBL0M2IWKRht21wNpIJCOuc5f68YEp6A7hVeF85nqlDMQwhjb4Gqs1tYqh9Cdt48060DF8KBEpDvMc90pfbbHasjYRCGS6NsPMg3jtBH2NA5ZqSPECZQIFiafLnlm1FbpnC9VkwCAgtTJ0ff9qOFgEThtLqgykP3gvbLRQI7BbZtCK4O7QmtAr2Ui1TXKrgyBpn7ssLdixyfl3RsVkjHmhLLGfuJVO1IXvFc83BJKGNkJ0pYhkOkBceEEudyI1l00D9yS9c3taB8lEhfgSrDhrnRyimI8N2rcZE2bNzufSOoCYG5fCO9LvaaFFnod6Z1qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfp0hueRd8runsxlS0CQsAfBaUvPLs5iAcqMacnJGRM=;
 b=rdCJohReHNlp09+fknl2hRRIo+NwS6ytCdO3scVAwSmuJ50wedFNcbQ+5FSdU/RBDcVoNeM+7uJIckstsmncTGt8Q8EiLSqXVUObOAKB8FoUuAgyuWfiSlEuoJkfugI2CHb5YtLwtpiXHv6a2+rT/9bxCbofh5inJ43C8qt/N+k=
Received: from MN2PR15CA0046.namprd15.prod.outlook.com (2603:10b6:208:237::15)
 by MN2PR12MB4287.namprd12.prod.outlook.com (2603:10b6:208:1dd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 21:58:41 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::65) by MN2PR15CA0046.outlook.office365.com
 (2603:10b6:208:237::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Thu, 6 Jun 2024 21:58:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:58:40 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:58:39 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 <ovidiu.bunea@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 46/67] drm/amd/display: Disable DMCUB timeout for DCN35
Date: Thu, 6 Jun 2024 17:56:11 -0400
Message-ID: <20240606215632.4061204-47-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|MN2PR12MB4287:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e4d5cb8-3f07-4b58-5dd1-08dc8673d3af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d4jcm5+QVlCRS+WYuBDR9HhK0xJCTzN0Rjk9GtaZMt9wsc4VhcPg4J5oZ2Vy?=
 =?us-ascii?Q?yv7XN5bwRY1ifwxLS8CSJSu6R4vmIXqd4v9uJmIozhwX7QKmquUeHMn8b6q5?=
 =?us-ascii?Q?OUF+/oBWBfxSqrZ6ys9mqNx1LJl0Ebwxsg2m/kYhIY7HP4rdeq0HmK5mNytC?=
 =?us-ascii?Q?GeUh8Unh8I5QrCjgUOw2xPS1HylrzWdfd1MpOw/MEFelYhDQ+B7vWha2dLHL?=
 =?us-ascii?Q?5HsnIRcRtP4Z71K5NvljhM2B7+tvgJuowEIyJ5hn7IAw6f/nPhgXEOvDtafF?=
 =?us-ascii?Q?XqFFQxuUvC2I2AoqQz9jhZ42N/DmjWnsWBsGrz2EK7UFi+OD3XZqqXZrTlCP?=
 =?us-ascii?Q?fWIV5rXBTPRJjlBGdaiBeO3PV4n2I2UvKL/gr2kI079MneCQSy3QGwxwPVt9?=
 =?us-ascii?Q?r/5cYEQW6K0xLa+GqMn0GxtMfBJGOkVB+kJDJCRsKtBYE9+ZO7x3V1pylnAg?=
 =?us-ascii?Q?rAg1kiy7yw4lIdG6hhKxW2flb+LBLirbtc48uTuJh30JIko0NmwZIb8ufgwL?=
 =?us-ascii?Q?ZlxwQw2yIKhh71AXfZiMebbVX0ND5p2Dn/X7YUYGNaJI63bjX05292aDIDuF?=
 =?us-ascii?Q?1XJJHwTmHXIZy0P1lfy6ewTOYDOscB303C6iOZZWCulXy+XoKRmRX8AfrZci?=
 =?us-ascii?Q?AVOZy2Lt2OOvFA6U3v9BO1rXmzugWUERwKi1L25ggtSzRUQoErVeYyaF8aWW?=
 =?us-ascii?Q?ig0TrvetEcfuImIrn556CfUO1qKCC5aK+cDS9p5eiZAx8WhD7btjQnG2rX5v?=
 =?us-ascii?Q?q/LIoBY592ogqx6xQ4JV90aLhPgb5l5THSGVO14UeTsdtBNY9edjvfj0kGso?=
 =?us-ascii?Q?rEGaQAScxSZGtnoWKmppQkGnVg3VSA3AzbIDOmHjiINtkcfS+sevevenRC4d?=
 =?us-ascii?Q?+pTztyBs+p1vLrE2hAt82VcFgtK1fhJPisNv+sRYAZXy62XIX5Vr6f6TkMpg?=
 =?us-ascii?Q?6NsC64I65qy3fE3qUu1mnRCjWuLAH1Rc1pGPZBjEbPLvHusdENQr+mCVv0/F?=
 =?us-ascii?Q?126iRw6tdLAZq8a4yv6J+zYQiXBEhzfqBDOvuMUsr4N8nM9w9kXOPvOaKIcc?=
 =?us-ascii?Q?LljQfRuUH0OsmsHYg5orvEXiCX5XEE1MDsTP5BnJWc9ov0sj4IdPexyMD/J1?=
 =?us-ascii?Q?olfMsSFOjZqTWUXTS/QChJO/dWiFm4Gne5TSdYGARiRAR/pEOUnWfNVyKLxB?=
 =?us-ascii?Q?+RkO2Xylo5d3UiIVgOZwyN6Vr+fshHVWEkiI7tYEZUx690LxT6KaJQ4+9uyr?=
 =?us-ascii?Q?KNLyxT3ey409QorqpoOKFhRVinoJyVKlMQ5oHhB4usyf67/5Tqv+DpGeIavb?=
 =?us-ascii?Q?G7hR6KLMDVNhdcXYX3QADcA+qDhDTsKJe0LYazwDsan2N992tfQDevxAo8y+?=
 =?us-ascii?Q?naygK07ILDsKdlVnCf+0lSon43R/OfnGp6JxSLbosg72klwRwQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:58:40.9989 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4d5cb8-3f07-4b58-5dd1-08dc8673d3af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4287
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
DMCUB can intermittently take longer than expected to process commands.

Old ASIC policy was to continue while logging a diagnostic error - which
works fine for ASIC without IPS, but with IPS this could lead to a race
condition where we attempt to access DCN state while it's inaccessible,
leading to a system hang when the NIU port is not disabled or register
accesses that timeout and the display configuration in an undefined
state.

[How]
We need to investigate why these accesses take longer than expected, but
for now we should disable the timeout on DCN35 to avoid this race
condition. Since the waits happen only at lower interrupt levels the
risk of taking too long at higher IRQ and causing a system watchdog
timeout are minimal.

Reviewed-by: Ovidiu Bunea <user did not set an email>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 391f9f69a923..5edccd565b05 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -785,6 +785,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.ips2_entry_delay_us = 800,
 	.disable_dmub_reallow_idle = false,
 	.static_screen_wait_frames = 2,
+	.disable_timeout = true,
 };
 
 static const struct dc_panel_config panel_config_defaults = {
-- 
2.34.1

