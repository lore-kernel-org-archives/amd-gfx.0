Return-Path: <SRS0=ctnh=QC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3747C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Nov 2021 19:59:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D18061B4A
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Nov 2021 19:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4D18061B4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B15CD6E055;
	Mon, 15 Nov 2021 19:59:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 174786E055
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Nov 2021 19:59:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L52to438P6lFJb8dbKW/wNtckCYSbljOEnU0iCbrIyZ/cT5uZqOaAn4CShsM02Ht5O2WhgHb/VW7nbVM2/8sCuBdkDEST96sXSjDlKHumj6xTQXlidursYQbn0yzn98Lswu9cMy9VGxTSgF/OPiTXT8NRUfFzsd80NtILIYKec+x04m7b5dHsLU2gR+5QeUYJgFPBAh31tHPP1MGCMhLQmXiY+iJGO4pcMT8O+jWSM6L9QeEhrfADRsx//lF87wNx0loBloHttkJVmgjRVO3XjlhJ2V9bI29tajLrYX7bt/xy70EmV5sIQMP2ICKbKG4ucT6iHO6lUcEMVuova0gDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2FPFkKNsXkq+j96gAUOaOQrhgcRvFMlWi/DOX1lV5A=;
 b=bikHXcYcoqxJXVldg4WR+W64c9TuWaIDkOjATV+5BDjyA7QpKiR1R3tclnA/GufgYbS1hPFmRCB6hxoiHjSBU/6S7TmNK6VIQfLq/2S2iaxhFi3Ekm2zMGoEJXtwtfFsQp8ek1/ea4Jx8nnq+lbsKdKawPEDYtacBzpT+x2/oX2b2crJIsMG4egCKQ3DhM6FxI2zB+jw8YW8z+K1pvsqm9I39/wLysERDD+8n0lvFP0DWedIRMhWpTY6O3TAYXmrZKy1gA3nErXFYd5gO/MSLeGFcCvJTKiNX2EK9c0NkQOIx/Q3Gs9Pq1tFvoPli5OzD/66+jP+3zELrMhUwW2zEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2FPFkKNsXkq+j96gAUOaOQrhgcRvFMlWi/DOX1lV5A=;
 b=flpUGkvOC/9dpDD8Ber/3GN8MYVXn5PCi3UbP3corTspwboR4FBnNUMJTD/rPKX58L6oIecAVat8Bz6XuhcVHjLiszWXfRfWhKtNQlDTsBwSaXczrsLBfBIjn7HZ8BAoj3/ioFUIwiwBAsqcfuOXN4qp6PEmbzQMYLIXdbffRl8=
Received: from BN0PR03CA0037.namprd03.prod.outlook.com (2603:10b6:408:e7::12)
 by DM4PR12MB5086.namprd12.prod.outlook.com (2603:10b6:5:389::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Mon, 15 Nov
 2021 19:59:08 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::d5) by BN0PR03CA0037.outlook.office365.com
 (2603:10b6:408:e7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend
 Transport; Mon, 15 Nov 2021 19:59:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Mon, 15 Nov 2021 19:59:07 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 15 Nov
 2021 13:59:07 -0600
Received: from elite-desk-aura.lan (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 15 Nov 2021 13:59:06 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Fix LTTPR not Enabled on HP ZBook G8 laptop
Date: Mon, 15 Nov 2021 14:59:06 -0500
Message-ID: <20211115195906.822218-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8ad96ad-c222-4357-3853-08d9a8726260
X-MS-TrafficTypeDiagnostic: DM4PR12MB5086:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5086F1DA64D0ED8AA6DEB07C8B989@DM4PR12MB5086.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SqRf3+3wGelhWMJRjnzWNIfZ6H4Krjteh7uYVJRuEw/M6JlN5m/Eus6iSbm7gA7QPcEr3UhGWZe8nXICilUwTfzTVV3lY+rwprPhyZGUBrKHoh0jCz1I5Yg3XO/wspBkSc2Doz8KHRwxI9TUEJGpBKj9/Ium0yOc/u+edhgeNLo8DqUHI9xDM6jMXk9KmQRcAy2EEax5Uvw/tbJNsN5rdO+BjXKDG0P6COWLgq/qZBfXOSQYpkyKh1iIYmLS55IF8G42aGCnbune4rXhK8S87N858peE4GLtpmHbLmB77pXPCdJ3U49f7/1MKpEOjL2mj8sBW703ywgJGqfWqF0/DHiYti8Nr/7fLVfesb/yn40FknHK7Zs4yndEW3BKw1Sk1vH5EcLg1sg0+MR2XX87V5QvpXxZuDmP4eVjAntNkdptvuzYj5/2tX40AWV6gjM09Bm0l14WMZ+nCP7kkLRMQ9Nmu+ZnwkSWSw8KKQoIFpoE9jE8ewtOX2RTd8HF8bHGVqzVTwXIt9d7ty06d1p47owQypRW0tJt2X+jVRq1tzQvHEtjtlXqcxMXBPqKzV5rov+X69gOLHsAdo2Tk0wY3+XhoNY2SYjdPbz0MdD6HL9RfP+FDfZpXB4tzPkUIR0xATMEkvpuvUiiurCntXgGPKy6XFPjMfFQXIzcEyTXawz6xKaUNmfMDL6QmzIJquB7ZPHe22One1MOlkGqFkyrt9w6wmi7r0luK9BiUT/m+nikOzsFmNOfMXNdhCedowWdSOvqVRkEuiDJNITWOnNkmNfVBYzXSAnmjP8RZKYMHzQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(36756003)(36860700001)(86362001)(26005)(82310400003)(508600001)(8676002)(8936002)(426003)(336012)(186003)(1076003)(83380400001)(5660300002)(4326008)(70586007)(2616005)(2906002)(70206006)(54906003)(44832011)(6916009)(356005)(316002)(47076005)(81166007)(117716001)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 19:59:07.9097 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ad96ad-c222-4357-3853-08d9a8726260
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5086
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
Cc: Wesley Chalmers <wesley.chalmers@amd.com>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Angus Wang <angus.wang@amd.com>,
 Martin Leung <Martin.Leung@amd.com>, Bhawanpreet.Lakha@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Angus Wang <angus.wang@amd.com>

[WHY]
Previous LTTPR change has caused a regression that led to an
issue where LTTPR is disabled

[HOW]
Extended changes from previous fix to DCN30X

Reviewed-by: Wesley Chalmers <wesley.chalmers@amd.com>
Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Angus Wang <angus.wang@amd.com>
---
 .../amd/display/dc/dcn301/dcn301_resource.c    | 18 ++++++++++++++++++
 .../amd/display/dc/dcn302/dcn302_resource.c    | 18 ++++++++++++++++++
 .../amd/display/dc/dcn303/dcn303_resource.c    | 17 +++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index 2650d3bd50ec..9cc1610360bd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -1485,6 +1485,24 @@ static bool dcn301_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
 
+	/* read VBIOS LTTPR caps */
+
+	if (ctx->dc_bios->funcs->get_lttpr_caps) {
+		enum bp_result bp_query_result;
+		uint8_t is_vbios_lttpr_enable = 0;
+
+		bp_query_result = ctx->dc_bios->funcs->get_lttpr_caps(ctx->dc_bios, &is_vbios_lttpr_enable);
+		dc->caps.vbios_lttpr_enable = (bp_query_result == BP_RESULT_OK) && !!is_vbios_lttpr_enable;
+	}
+
+	if (ctx->dc_bios->funcs->get_lttpr_interop) {
+		enum bp_result bp_query_result;
+		uint8_t is_vbios_interop_enabled = 0;
+
+		bp_query_result = ctx->dc_bios->funcs->get_lttpr_interop(ctx->dc_bios, &is_vbios_interop_enabled);
+		dc->caps.vbios_lttpr_aware = (bp_query_result == BP_RESULT_OK) && !!is_vbios_interop_enabled;
+	}
+
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
 		dc->debug = debug_defaults_drv;
 	else if (dc->ctx->dce_environment == DCE_ENV_FPGA_MAXIMUS) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index fcf96cf08c76..058f5d71e037 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -1557,6 +1557,24 @@ static bool dcn302_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
 
+	/* read VBIOS LTTPR caps */
+	if (ctx->dc_bios->funcs->get_lttpr_caps) {
+		enum bp_result bp_query_result;
+		uint8_t is_vbios_lttpr_enable = 0;
+
+		bp_query_result = ctx->dc_bios->funcs->get_lttpr_caps(ctx->dc_bios, &is_vbios_lttpr_enable);
+		dc->caps.vbios_lttpr_enable = (bp_query_result == BP_RESULT_OK) && !!is_vbios_lttpr_enable;
+	}
+
+	if (ctx->dc_bios->funcs->get_lttpr_interop) {
+		enum bp_result bp_query_result;
+		uint8_t is_vbios_interop_enabled = 0;
+
+		bp_query_result = ctx->dc_bios->funcs->get_lttpr_interop(ctx->dc_bios,
+				&is_vbios_interop_enabled);
+		dc->caps.vbios_lttpr_aware = (bp_query_result == BP_RESULT_OK) && !!is_vbios_interop_enabled;
+	}
+
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
 		dc->debug = debug_defaults_drv;
 	else
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
index 4a9b64023675..7024aeb0884c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
@@ -1500,6 +1500,23 @@ static bool dcn303_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
 
+	/* read VBIOS LTTPR caps */
+	if (ctx->dc_bios->funcs->get_lttpr_caps) {
+		enum bp_result bp_query_result;
+		uint8_t is_vbios_lttpr_enable = 0;
+
+		bp_query_result = ctx->dc_bios->funcs->get_lttpr_caps(ctx->dc_bios, &is_vbios_lttpr_enable);
+		dc->caps.vbios_lttpr_enable = (bp_query_result == BP_RESULT_OK) && !!is_vbios_lttpr_enable;
+	}
+
+	if (ctx->dc_bios->funcs->get_lttpr_interop) {
+		enum bp_result bp_query_result;
+		uint8_t is_vbios_interop_enabled = 0;
+
+		bp_query_result = ctx->dc_bios->funcs->get_lttpr_interop(ctx->dc_bios, &is_vbios_interop_enabled);
+		dc->caps.vbios_lttpr_aware = (bp_query_result == BP_RESULT_OK) && !!is_vbios_interop_enabled;
+	}
+
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
 		dc->debug = debug_defaults_drv;
 	else
-- 
2.30.2

