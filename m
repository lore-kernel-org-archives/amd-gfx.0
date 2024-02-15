Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA0AC48BC4
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Feb 2024 13:32:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CE4D10E852;
	Thu, 15 Feb 2024 13:32:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k1qQjhiw";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2052.outbound.protection.outlook.com [40.107.212.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C085810E887
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Feb 2024 13:31:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQyJ+fcVOxiHPWpZ+EsJQoCyv2/7zCCP3Vz9VacMA1XAtz2HjxmXl3caf6fhmI1kv2KrzgKYimIU5o2K3idD4PTq4Yk0moXY0mMdPwIcfOhjfNs+IpbNXPZBJNf0V19ofYzESQQVm5z9EvREiG+9rGPbr38PgAvWYBk4eY/ApHhFVeLY9EM5Bl+QJYev8hRlk3PHpVU4qPUtfB5GW9xqn/aV8IUTD3HGQI9fejfWRPl58kFs2HDgcMCwqExRgCkf8j+FJbZ4Gn8mDZcFQYRXGOif+YQU82DzemzTPYDruE1FmtfwqqaBKBS9bHBRIaG8+x3bFupMvYzzLnJ1P6d04w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9t5fI9lzB9W8sTkWBfRNZQT5UKlx7Ue4PRpL+ceW/bY=;
 b=XYr65dPzmreJ4jVXOmBxKDzF89Yje1MREvxdX5goA5Uvjy3kmVEox0OC9AYHE4pPZh8tPnfXoWilV94X3hF5uXZxvfbMgd5m8FdM84tPBz7lQaBVZRViEAVenl03i/2Rdv17GlrCM1gAC+laWxB9sRuYRRG2U+FjRS53ndy66TWZy6LNVkaVTGnFDE9TUR270tukJ8LslDAj0qxPpm2A2Mbm82lVJ96qL15MLIKuX5CxfPCMIXi6dzaSRoF0yMg09E7QTXNUuCOoTJHFoiOz/ME5kR+6dIZkrp2UABosNGF2CgMNn7Ws5CADzyQVJ1iq/eMTdhgejqJnvsOyyycHVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9t5fI9lzB9W8sTkWBfRNZQT5UKlx7Ue4PRpL+ceW/bY=;
 b=k1qQjhiwwElp2jbopnIafHhMj8uTWg9sX2SuXYTSD+VNE5YBCfCBu+AdNtDG4fsLe0FH2mTgUdpBZHIVWDObz9bz80OjrDwyTBK0c4ph+bOSG9wuMcnsEWRDEP4FHiMHSsTC42Tgro9PWpDkJA9dtNFS+BChkQLFdoD3dNMwjLY=
Received: from SA1P222CA0196.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::23)
 by DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.30; Thu, 15 Feb 2024 13:31:52 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:3c4:cafe::4b) by SA1P222CA0196.outlook.office365.com
 (2603:10b6:806:3c4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40 via Frontend
 Transport; Thu, 15 Feb 2024 13:31:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 15 Feb 2024 13:31:51 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 07:31:48 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Subject: [PATCH] drm/amd/display: Add 'replay' NULL check in
 'edp_set_replay_allow_active()'
Date: Thu, 15 Feb 2024 19:01:29 +0530
Message-ID: <20240215133129.2345398-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|DS7PR12MB8252:EE_
X-MS-Office365-Filtering-Correlation-Id: cbf50739-d061-443f-f4c2-08dc2e2a77fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iyjf+8aMOav9sEDeH+jDpIl+QZHV+6iY1/yCWS9kEG52eHCOmH3K6KyJgUTUjqDAPWRJecXaWPSbaYKip4+3w3vQVzuI+JLiW0NyIIItHs4z4nsw3Ro5Gj9nShNk7Eui0WR8SU4eOnr3TT8s4Zi2fk2/6dsEN+BWMqnpmX4bQr73YmOlL4v0WGHmY6LeE6E3riO5sW4XoUxYXdtuPL6U8UfX3vslBeNd04zPysQZ7oBnc19YJdw/7RyolqAo+1alpVVr9VDkOWvbQmcByanpFbiULWL3ODXLvEQTMVlL7R8CCQQj0VFh8bVWkBcMBYZkbOEfAXkHn2KVTPfvaNiPkpyKPhC37OyPAjydgi94ysHssShCGJ0QXjRUUwUFtRQt2wWAArjl+pxW07Jt1iJAm32q5U9FJbY2Enl+Sh5mi0TGWTxY/ebRJk74j92zDQ00nIT5enVHyBueVaWhdblRuIrUM5AesRcZYINwhxSuu5pY2Ezln6gYxllZT4IHqn82NovwDqF6w2Y2mblpewCXnfANXDEhzMWhxhru/B6RqTIjuE5BLVugjzuTYXwBdFzwppuCxVM+IO1k6Aba+xMZROHSh3TpKlwMGJOKjZF6vy81Z5VqBUM1AsESRAlrRFRWj/bQBN+uSJTnR0u/YjQrGA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(36860700004)(1800799012)(186009)(451199024)(64100799003)(82310400011)(40470700004)(46966006)(6666004)(478600001)(41300700001)(8676002)(2906002)(4326008)(8936002)(44832011)(5660300002)(7696005)(6636002)(70586007)(110136005)(316002)(54906003)(70206006)(83380400001)(2616005)(1076003)(426003)(86362001)(336012)(81166007)(356005)(26005)(36756003)(82740400003)(16526019);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 13:31:51.5778 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf50739-d061-443f-f4c2-08dc2e2a77fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8252
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

In the first if statement, we're checking if 'replay' is NULL. But in
the second if statement, we're not checking if 'replay' is NULL again
before calling replay->funcs->replay_set_power_opt().

if (replay == NULL && force_static)
    return false;

...

if (link->replay_settings.replay_feature_enabled &&
    replay->funcs->replay_set_power_opt) {
	replay->funcs->replay_set_power_opt(replay, *power_opts, panel_inst);
	link->replay_settings.replay_power_opt_active = *power_opts;
}

If 'replay' is NULL, this will cause a null pointer dereference.

Fixes the below found by smatch:
drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_edp_panel_control.c:895 edp_set_replay_allow_active() error: we previously assumed 'replay' could be null (see line 887)

Fixes: c7ddc0a800bc ("drm/amd/display: Add Functions to enable Freesync Panel Replay")
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Suggested-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../drm/amd/display/dc/link/protocols/link_edp_panel_control.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 443215b96308..acfbbc638cc6 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -892,7 +892,8 @@ bool edp_set_replay_allow_active(struct dc_link *link, const bool *allow_active,
 
 	/* Set power optimization flag */
 	if (power_opts && link->replay_settings.replay_power_opt_active != *power_opts) {
-		if (link->replay_settings.replay_feature_enabled && replay->funcs->replay_set_power_opt) {
+		if (replay != NULL && link->replay_settings.replay_feature_enabled &&
+		    replay->funcs->replay_set_power_opt) {
 			replay->funcs->replay_set_power_opt(replay, *power_opts, panel_inst);
 			link->replay_settings.replay_power_opt_active = *power_opts;
 		}
-- 
2.34.1

