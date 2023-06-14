Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29386EB64DB
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jun 2023 17:58:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6214010E15C;
	Wed, 14 Jun 2023 17:58:50 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B452F10E15A
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jun 2023 17:58:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jipzHWJQrckjhJHcLXE+AtNjX9P50EG8DW112ua1ksEMH3478oOzG5CccHYRK1f/yHSYxo+VXojRDEIPPEFpAP8rBhFNjeqphE9LxL29rJhRuGnQo10S3dW9XY8cdSr1913S2bIV/vSJ/SoTT5Dgb1z+jzP8S3hVgq/3ChcNNWSj8OnjEEKbgPOQDCgK3DvzaOpP84joFoBXbJ/4ezV++rpxd3OVH88r/BtjOMJGf1N0zeiquWDNSs3x6gJuSsxvGdYjSi7zzYiZjQspBaZtBFu9S/AtY3QaDpy7ysE8TQgodXCxkt5Re4TpdU4/TOpkWxfgsDuIU7lpclG79/Y+qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mcVdwCO+qcYKk/tbE9/RWLAG+1Ycbf0DNKeb6UHjc4=;
 b=m6npIIi7O7p9J6Yt/vRNPqsSvu/s2y3RpjifP6XZrGCTtx8c1IRdu+NsLgLGPBcK/BQSugNaz5bBr7OjZXL3oCArNXuJlaRGAZ9aZOH2KjsbmwisrGwCmAB5LYjR/Ip7nYuMFneL/bY+x1OGl8S+POpSXOf4QMehkqUFpQTSjP9kf5xGQHWDBvbyYNbK78/PP3Znplfnj5cxhOg74eiDdqrGB9yYWAG8YDPVsC4thS/ZJxZRbUMyJsji64aYeHkFunmBWP2OLBtosa3/O7MTqor+7NVLBXgprur8D9rs+1eczZ2Gtow9KcbMA10QFbOIuwWPFnsnhhp1bRQ1m54o6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mcVdwCO+qcYKk/tbE9/RWLAG+1Ycbf0DNKeb6UHjc4=;
 b=SizaZbAg/zOGlN1Rj97s4YzVJ0XSquGDr/fT/oCyAd+1BY3/lbTgqJlBpvMB7JcgJ+p7CWYk3O2aqL7s3PB9ls4+AZxsT+XV3FjI/spRPvgPtms8hIR2YvBupJFUr9NmSUoYNNWlzxRJLM7KdAF8R4m+jygbTUOtv+PJT7gsQas=
Received: from MW2PR2101CA0023.namprd21.prod.outlook.com (2603:10b6:302:1::36)
 by CH3PR12MB7764.namprd12.prod.outlook.com (2603:10b6:610:14e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 17:58:27 +0000
Received: from CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::95) by MW2PR2101CA0023.outlook.office365.com
 (2603:10b6:302:1::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.15 via Frontend
 Transport; Wed, 14 Jun 2023 17:58:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT112.mail.protection.outlook.com (10.13.174.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.26 via Frontend Transport; Wed, 14 Jun 2023 17:58:26 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 14 Jun
 2023 12:58:24 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/17] drm/amd/display: enable the new fast update path for
 supported ASICs
Date: Wed, 14 Jun 2023 13:57:43 -0400
Message-ID: <20230614175750.43359-11-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614175750.43359-1-hamza.mahfooz@amd.com>
References: <20230614175750.43359-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT112:EE_|CH3PR12MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: b66c4091-46e0-4f71-b1c6-08db6d00f447
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KwLLlJNAhQG4/EiJnaw3kSKseqtOTjeAZyI2hS6kKSdKlwVjhcSuHxDw3bT8+cWb8tmnYnJG+gchEWutpBhiFtsa3KYWlT7tlEETJ610Pmh1w+1nCJ/hn3PRLmdJqJA0EllBQJsY0HhfEyHDVD8EPDxZ+QMB/zoEPfPloVyIfRyU5PadMQcun8us1BMJMO4hRdX8DsjlP7uIR2ZV1jMmBmTWsEM99jukvtInOpp/1/F/+G667fMByYMa/ktJpW+GGo0n3bWHTyOm9iq8yHF7NkXAMZQFzEi84jdBia2s6t6DVH1isXSkyw7xorXFfi81tkg143EtU2LdwFTV8UZAtCu7veh2xA9Nl6HniFoZHzsRlZno26gk+4BmODfbS56Irmb4OfOEGmgW9tXoiWYYairWRXg4EjhOOrtrH+YXV+CXfk+i82RID0gdGweEWsun99m7diwkGXqV+eejVTOQaiiFQYV+EB3H4TbniKUZ+JJdHDO5Pj+0DqG46Q0lHVoyBfQO0KQ3NrU4rvTBFTfMKDawkVUHm3LQjqFwI5pPAG2FI1pxE5Pi/F1qsvJhAEEq3QBcKO48gbnviSfVMcAjQCR+Ooz/a79D6+mnfxUBNu6QbX0iBjFEVzFJ2isEIFfXraYWBPQ9rdNhbSLi4q3cMHaYbHFZvHXxSlhr0rwUUJIMaAWYhvKxsSk3K8sR2j3bB8mzBdRB3zjrM19pNmIVGBIWb0/ItC6R3+7OH1jeSl6DC5bJyxtb/vrKe6uXg/yc6buBzqjPEkB/o4Xj9KqNAwNEY4lAqAaSeo6e17CJhrXByYwqmZKF2ZoEGY9WWrgp
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199021)(40470700004)(46966006)(36840700001)(86362001)(40460700003)(36860700001)(8676002)(82310400005)(41300700001)(316002)(83380400001)(26005)(82740400003)(5660300002)(40480700001)(81166007)(356005)(1076003)(6666004)(8936002)(44832011)(336012)(36756003)(70586007)(54906003)(4326008)(70206006)(47076005)(478600001)(186003)(16526019)(6916009)(426003)(15650500001)(2906002)(2616005)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 17:58:26.7417 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b66c4091-46e0-4f71-b1c6-08db6d00f447
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7764
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Samson Tam <samson.tam@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

The new fast update sequence is now supported on some ASICs. So, enable
it by default for all applicable ASICs.

Reviewed-by: Samson Tam <samson.tam@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c   | 3 ++-
 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 3 ++-
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c | 1 +
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 1a0284a068b2..a8cb066bc138 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -725,7 +725,8 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.dwb_fi_phase = -1, // -1 = disable,
 	.dmub_command_table = true,
 	.use_max_lb = true,
-	.exit_idle_opt_for_cursor_updates = true
+	.exit_idle_opt_for_cursor_updates = true,
+	.enable_legacy_fast_update = false,
 };
 
 static const struct dc_panel_config panel_config_defaults = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index 7dc065ea247a..5ad6a22ee47d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -95,7 +95,8 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.dwb_fi_phase = -1, // -1 = disable,
 		.dmub_command_table = true,
 		.use_max_lb = true,
-		.exit_idle_opt_for_cursor_updates = true
+		.exit_idle_opt_for_cursor_updates = true,
+		.enable_legacy_fast_update = false,
 };
 
 static const struct dc_panel_config panel_config_defaults = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 19f134caa8ad..c94dec042cc3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -732,6 +732,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_dp_plus_plus_wa = true,
 	.fpo_vactive_min_active_margin_us = 200,
 	.fpo_vactive_max_blank_us = 1000,
+	.enable_legacy_fast_update = false,
 };
 
 static struct dce_aux *dcn32_aux_engine_create(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index ea204742ad35..28320c608aeb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -730,6 +730,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_subvp_high_refresh = false,
 	.fpo_vactive_min_active_margin_us = 200,
 	.fpo_vactive_max_blank_us = 1000,
+	.enable_legacy_fast_update = false,
 };
 
 static struct dce_aux *dcn321_aux_engine_create(
-- 
2.40.1

