Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A08AC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:52:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEEED61207
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DEEED61207
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B90DA73798;
	Thu,  4 Nov 2021 20:52:37 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2084.outbound.protection.outlook.com [40.107.212.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA9D973795
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 20:52:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfCc93zNsQxEyQ/wpCMFlYz92xtUXGetdQlP1WedjfEJI2z+Z3ZUM+We6CSMu9GEcmpOVDNucaDS3O8rGW/JwE8J9u6LF8mRYDKPnDdPQOrB8jeukVNWujAz5jKthpMOfFIc8RAdgPVBCXvtlCrfsorxixMAn6j/x8pjoFjUs/XY2OS8SIQx567ov4pT9gn9xwaBld8vIWTDiyI4SyoTrI8JQu8EvopIhcJ+6jnJYoisjE5inbwpEspOL14Z03epHlx9tLVXJ0sy2sYgEH9EhtzlUF5jXOx9ksKOwfek/l5IN2fTMdXBxS2yHN5HkGKbXAz1KSyTwy7akpt9+0VPpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbOxnp/62MMSWPlD9wadY+lsaXiitvp74eFzCaHXEwI=;
 b=jNVY9rUmytMJj40aDj1/+kHSNF5vlqRRq/HBfVvQD+H/Kc2Lsfj7WkOsrFki8yewFLcw/1ICjov8qXj+GOuGZh8Kw4F2zADyLu5N+Jx0O83qepPfLXH8rlRNgLx/6SxWkhd0TZappIusskrU4BDj86pbjU68TB8MFDToaxsPgRmsD85PIr2kwlGsp4RgiI8KAkDO2t8dnE5MHWU5Es8aoW8JpX8NWz1UExZanWdwurrCPxp5/1jEkZVSRkNKsZmNYRmQ89w5Hvvu0nJaP/8YFzNXaoQIyjFo26rgvPhdRV2zGIjtc9XZNl0DM/p3CWA7fel8+bAgOy6/sWm17DdgmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbOxnp/62MMSWPlD9wadY+lsaXiitvp74eFzCaHXEwI=;
 b=tAfRSSSpzYKHRPAKGCbkQLypnfGTMh/9oOGiBvyfsoJ0mzkTtRW0h+P14KcK2b+zqbxRAD0ur5UBscVbhFY/8KvZJY8iofHsVSPEyMFWoPtfRwUtE8wZ5pS+uZiaXJnGb0K6qOzmfH9dWKhft+Rg1nSRsSQTF5wz92YgR7GoC5I=
Received: from DM5PR12CA0006.namprd12.prod.outlook.com (2603:10b6:4:1::16) by
 MN2PR12MB3936.namprd12.prod.outlook.com (2603:10b6:208:16a::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Thu, 4 Nov
 2021 20:52:27 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:1:cafe::9c) by DM5PR12CA0006.outlook.office365.com
 (2603:10b6:4:1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Thu, 4 Nov 2021 20:52:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 20:52:26 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 15:52:25 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 15:52:25 -0500
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Thu, 4 Nov 2021 15:52:24 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/22] drm/amd/display: Fix RGB MPO underflow with multiple
 displays
Date: Thu, 4 Nov 2021 16:51:58 -0400
Message-ID: <20211104205215.1125899-6-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211104205215.1125899-1-Anson.Jacob@amd.com>
References: <20211104205215.1125899-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2540e80-ceb7-4787-00d5-08d99fd5029b
X-MS-TrafficTypeDiagnostic: MN2PR12MB3936:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3936392605D24D928CA4DFFEEB8D9@MN2PR12MB3936.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VHOcNDWI/+VXfYV3niQ53AfuDEOUqRSgebpFrvOxjsaEpbtEq/A+M5AvDuuEoTUugJ1PAn5oPMpJavrRW1ilxfmlSpnJ6dOmWBRTTDRtnZX7PhHrWwnH0dj4brCjAOUyts+mFtSwRWfh6RXeLI6uxNYhydVEatiTMZ7wKeFS0uNEcyqBgiFMmTQbll1YwtkJ1nnkqUw++uzvWHrWaO2BBgFPdCWWcpUbLzLwWubBir6O6VPRccoa78gxO2yeVIEy5RX2hWg0/jvma1Lj5XNHqDoIaS7H6HiW/9SeWi096cy4D60sTe5wf0LNjJSK6OlOnHOTk3DpcunZoz/M9WBMF0zFP6f03UxP+BwgPT/fchAntMkw03Z/Who0XQucw8i/dtNlxokncVZGQdKsKHLTJGJXZ8o19zKQpyxADoEvNfPCs4pNPTRGxWgFexzhTxjNe/3AFZ4I4X93OgWVoW1jyvX7I7uxhOUAoge/3bzknLWsLovDdiJL8i+bauYyQ/GOtZNO5Fv1ugnpqFhHbTw6jODpHbi1DVcwzoiYOxu5DsJWHJFdNywNZO2dUkGs5ebV1EESG0wxh8USJmidK4FEHGUW76DJI6Fra0Jc/evgqymhWpMTWLpvLtwCh8oPiSA566KsRE+Y3a0uE1bn4EKc0okth7KR98pgAG6wFTjKIaZdHDhhW7uWh6u0wCIOWSK29UthFjYNsZrFxYC7osCUc2gvy/IcXrg93wV+Oc3NyEg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(7696005)(426003)(36860700001)(8676002)(6666004)(83380400001)(70206006)(8936002)(5660300002)(336012)(508600001)(36756003)(70586007)(2906002)(86362001)(356005)(26005)(47076005)(82310400003)(4326008)(186003)(54906003)(81166007)(316002)(2616005)(1076003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 20:52:26.9409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2540e80-ceb7-4787-00d5-08d99fd5029b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3936
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>, solomon.chiu@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Angus Wang <angus.wang@amd.com>, wayne.lin@amd.com,
 mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Angus Wang <angus.wang@amd.com>

[WHY]
With RGB MPO enabled, playing a video with multiple displays
connected results in underflow when closing the video window

[HOW]
Reverted the old change to fix this problem, which prevented
pipe splits for multiple display configurations and caused
high MCLK speeds during idle. Added a two step call to
dc_update_planes_and_stream, first time with pipe split
disabled and the second time with pipe split enabled, which
fixed the underflow issue

Change-Id: I2d6fcc146242a30849096f08c52afa13bf4f9225

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Angus Wang <angus.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 3883f918b3bb..83f5d9aaffcb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -1069,7 +1069,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.timing_trace = false,
 		.clock_trace = true,
 		.disable_pplib_clock_request = true,
-		.pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
+		.pipe_split_policy = MPC_SPLIT_DYNAMIC,
 		.force_single_disp_pipe_split = false,
 		.disable_dcc = DCC_ENABLE,
 		.vsr_support = true,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 79a66e0c4303..98852b586295 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -840,7 +840,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.timing_trace = false,
 	.clock_trace = true,
 	.disable_pplib_clock_request = true,
-	.pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
+	.pipe_split_policy = MPC_SPLIT_DYNAMIC,
 	.force_single_disp_pipe_split = false,
 	.disable_dcc = DCC_ENABLE,
 	.vsr_support = true,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index fcf96cf08c76..16e7059393fa 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -211,7 +211,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.timing_trace = false,
 		.clock_trace = true,
 		.disable_pplib_clock_request = true,
-		.pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
+		.pipe_split_policy = MPC_SPLIT_DYNAMIC,
 		.force_single_disp_pipe_split = false,
 		.disable_dcc = DCC_ENABLE,
 		.vsr_support = true,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
index 4a9b64023675..87cec14b7870 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
@@ -193,7 +193,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.timing_trace = false,
 		.clock_trace = true,
 		.disable_pplib_clock_request = true,
-		.pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
+		.pipe_split_policy = MPC_SPLIT_DYNAMIC,
 		.force_single_disp_pipe_split = false,
 		.disable_dcc = DCC_ENABLE,
 		.vsr_support = true,
-- 
2.25.1

