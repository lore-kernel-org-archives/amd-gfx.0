Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E119CC54764
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Feb 2024 11:19:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8366A10E238;
	Mon, 19 Feb 2024 11:19:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZvwgCsCR";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C195E10E238
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Feb 2024 11:19:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbCfCGRHaiwafjgsoDjTH4WKQEUJrVE7+ITOUOOkB9clH9lmehEQJH/kW0eJV+UR1Tyw7SgVS0PE0RT869Hg+otU2wMOx5fequicd6ckipcX3qZucieSb4tlFHy6ska3T3tMO/zcao43beZ43hu3HfXaedsyoCuR8nv5IIGwbMvWGF9D+/LkiBhzM30oBMGcvGVS2MLA0WLfya+n9sSSim7I148qS4rexh9jtdDH1bUgy8kVoBPJzmokrX07xQYvFrLZJ4ivjooFQkKdYm08yNv3WEOo0hN30IT713sR7hxTMQd9OeBjoIb95SPVzMwuC/lfHdLQPPPSywI9f0zXFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjr/1Nzy2ekmY3ZNAO4RXmCf5JtyJ67gdGi+jHE0+X8=;
 b=Y/etEE4Ewbcqzs/EcMdaiZsCzdmVxFBSMz1mAw7+6Km8mN6oQMod+Ft9Daf2edmh7Me3erXkMvwhhElLys/t27FCmCdBzx4gtF7DuLDEE/yS1ninelFL0CnKfnCwV9xzLCi9OTOklBXfw7bOTJliwIP8sRV/iikNjSV4qrpn1E9G1YQ+VHuKUxPJXzRtydKZ9wz2Q5EC38f6xp061heQM+pFiz9ombVERhDmufuGdTNO1rw7OuZe6cmIVQLacFJiTrjicMWdUa3LT+ntMNED39rucidCqQXSzbQM3pzVmzFU83lXLsFRZT9EsdQJ2mnlnq8qMmZG9x7mJyuEPtc9sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjr/1Nzy2ekmY3ZNAO4RXmCf5JtyJ67gdGi+jHE0+X8=;
 b=ZvwgCsCRXMC5M0cPuLaecHzetA7268gg+LnaeGCz2hHEvOkH/LT3Ul8s8QWINoqopYIAlocPUCkY7I3hWIN5Uuaalwmx6K+58kUCbaHTdywBcZLPsjwRgUS6nkrWznFbAap411YuWumj27UNdgZshhmtsaduUdY2IItZ4FthtUI=
Received: from DS7PR03CA0153.namprd03.prod.outlook.com (2603:10b6:5:3b2::8) by
 PH7PR12MB7869.namprd12.prod.outlook.com (2603:10b6:510:27e::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.19; Mon, 19 Feb 2024 11:19:17 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:3b2:cafe::cf) by DS7PR03CA0153.outlook.office365.com
 (2603:10b6:5:3b2::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39 via Frontend
 Transport; Mon, 19 Feb 2024 11:19:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Mon, 19 Feb 2024 11:19:16 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Feb 2024 05:19:13 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, "JinZe . Xu" <jinze.xu@amd.com>, Hersen Wu
 <hersenxs.wu@amd.com>, Josip Pavic <josip.pavic@amd.com>, Qingqing Zhuo
 <Qingqing.Zhuo@amd.com>, Harry Wentland <Harry.Wentland@amd.com>
Subject: [PATCH] drm/amd/display: Fix potential null pointer dereference in
 dc_dmub_srv
Date: Mon, 19 Feb 2024 16:48:55 +0530
Message-ID: <20240219111855.3802366-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|PH7PR12MB7869:EE_
X-MS-Office365-Filtering-Correlation-Id: 86740863-1301-4c07-201a-08dc313c9c39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g0LlWfjxmxJ3leu323KTa6Nup2m02RqsraFM5oZsBnNy6t7uJXAdM2+HOGDVYtIK+acL53rHEA8sDvfM8tpA5OOMGNyiKCUp/TDHPvs5IjoUvp7dowHgAdMxHsNuNZvyFWKF3uP9/xxkB5nL+CEeQ2BeOnEDSN60IlZN/pR8ghJlT0P6rAVJs5WoJsYfYwtovrtB/aXFs99IPk32vahB/uuScIvUs/hxvScZywKNZmMDPCEgru4YWKt3S/cTApxu/WfG2VY6sm6Muk5ownDpHeNhiQe6GlyxyjWCf9r18LhM4g98TxLBXHiff2WjHpCw8RwzH4VX5p5aBghcMLw/WcCEOuTrETyabG1ThP2EM2nczIZ81m/G1DVEYF7WFiB2EU7C363QZsRVPoBQEzkhMA0oQb+q69nYhrvuSXrVi4a5xz0QeEE8w3khCz+/G6TjBX6yvG5TGbh08koQCnbe8WK18ASD+R7psrJtxtAXKA8aPyLcb4B+hbKtOi7vDXfXGUDxU0rd1NYZxJDzs0aq/+FQRURitrjVT6UWm5LG4WJQjdkrBsKzwATbfmk6rXtq6pU8CaVtLIKHy0h7Jzo1cjO7e6JOxV0/TUTP2evhpuSd/G5BtuBpmF8KIcTtyMcSkkDMaJPop9KBJ8mEkvRnO5W3Zw1ehV7XZ++ANwxMheU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(230273577357003)(36860700004)(40470700004)(46966006); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 11:19:16.7462 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86740863-1301-4c07-201a-08dc313c9c39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7869
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

Fixes potential null pointer dereference warnings in the
dc_dmub_srv_cmd_list_queue_execute() and dc_dmub_srv_is_hw_pwr_up()
functions.

In both functions, the 'dc_dmub_srv' variable was being dereferenced
before it was checked for null. This could lead to a null pointer
dereference if 'dc_dmub_srv' is null. The fix is to check if
'dc_dmub_srv' is null before dereferencing it.

Thus moving the null checks for 'dc_dmub_srv' to the beginning of the
functions to ensure that 'dc_dmub_srv' is not null when it is
dereferenced.

Found by smatch & thus fixing the below:
drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:133 dc_dmub_srv_cmd_list_queue_execute() warn: variable dereferenced before check 'dc_dmub_srv' (see line 128)
drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:1167 dc_dmub_srv_is_hw_pwr_up() warn: variable dereferenced before check 'dc_dmub_srv' (see line 1164)

Fixes: 01fbdc34c687 ("drm/amd/display: decouple dmcub execution to reduce lock granularity")
Fixes: 65138eb72e1f ("drm/amd/display: Add DCN35 DMUB")
Cc: JinZe.Xu <jinze.xu@amd.com>
Cc: Hersen Wu <hersenxs.wu@amd.com>
Cc: Josip Pavic <josip.pavic@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Cc: Harry Wentland <Harry.Wentland@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 0bc32537e2eb..8bc361e0f404 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -128,7 +128,7 @@ bool dc_dmub_srv_cmd_list_queue_execute(struct dc_dmub_srv *dc_dmub_srv,
 		unsigned int count,
 		union dmub_rb_cmd *cmd_list)
 {
-	struct dc_context *dc_ctx = dc_dmub_srv->ctx;
+	struct dc_context *dc_ctx;
 	struct dmub_srv *dmub;
 	enum dmub_status status;
 	int i;
@@ -136,6 +136,7 @@ bool dc_dmub_srv_cmd_list_queue_execute(struct dc_dmub_srv *dc_dmub_srv,
 	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
 		return false;
 
+	dc_ctx = dc_dmub_srv->ctx;
 	dmub = dc_dmub_srv->dmub;
 
 	for (i = 0 ; i < count; i++) {
@@ -1169,12 +1170,14 @@ void dc_dmub_srv_subvp_save_surf_addr(const struct dc_dmub_srv *dc_dmub_srv, con
 
 bool dc_dmub_srv_is_hw_pwr_up(struct dc_dmub_srv *dc_dmub_srv, bool wait)
 {
-	struct dc_context *dc_ctx = dc_dmub_srv->ctx;
+	struct dc_context *dc_ctx;
 	enum dmub_status status;
 
 	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
 		return true;
 
+	dc_ctx = dc_dmub_srv->ctx;
+
 	if (dc_dmub_srv->ctx->dc->debug.dmcub_emulation)
 		return true;
 
-- 
2.34.1

