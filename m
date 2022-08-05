Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031C6C00140
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 18:01:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7AD2B9427;
	Fri,  5 Aug 2022 18:01:34 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE0EB10FB2F
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Aug 2022 18:01:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBNbEMhLknvRMjvRU2FAWRqEKDGcq5DrSLppQslOdD0tUfH1ArU/Fo8kGYl48E0Ib0olKFjRD4GqNpDy6TBRlLC2dDMOMtW/OR2vyCJqWrGi2ceVFEfTVpwssKWVRFX1gkih67IiSCdtKvpHb9T7TWDnhGTK76qDwmdk/NKLWd/9Q595y3f7iwDGbIEWMAo3qHgzDE3vsO+Pxf6zTbhokd4SeiYS9uai93dwu4yYG+KCHo+m5GazsY4OlTE76HhE/yVnHBQ882h9IaB5U0OyXqluqIKNe7YXVOSi5LxDyoRkVxGqRi4peuW80tXpnxw0wyMcJ8oksUFgGxneq3TBMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QDGTIGCj7jtGIr9gE9VlwXdut7Ps3OfdKbL53V6E94=;
 b=HMawbAsnRImhKjWlXxVuhVdZM1NKBw1/+fDTaMl0ZV96yt8ccAFp045XCveULsEaGoVUorJX6/dw2dZV++clT5FbPWNDrAVwLlnyjM8SRYRxGiSHgjhZOMnu+Qe0ab4dHy7XSPeCEF91aB+pdxGQ47g//azhDG6Mt7mVcZNdyBTDdzSzw8cXtVVa9lIZ54mpcKbXMkbDm8OzjiEx3U8S+CWSyJYhlNNPDqbLqXMnVpqm6d9PAoGW44TZ1GeAVjCJtzIcyJJQq5Q9GWuynjKgoT2Z9l/31JgetZKHbG4jdYn1ljfcnoCWUPTaa17qzMRdn7DZPD5ibgWGVJ2fLyWSoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QDGTIGCj7jtGIr9gE9VlwXdut7Ps3OfdKbL53V6E94=;
 b=EyBqpSg3bOPtHnPkLvRdbF33YK/MwS9Z2lqVVqr2iqsVR4wDXVGPePP5+AdV44rN3I/hJlFkZ1RgkHsTEierGNeOnHh59B5yTm7xjn3m7N2HYO5cx+LGmyGghJYH/Z5kgjbxSeK3jiwMkMTZqrPsnvN6aB2LX3mpmVwp7z/1ep0=
Received: from DM6PR03CA0031.namprd03.prod.outlook.com (2603:10b6:5:40::44) by
 BL0PR12MB2467.namprd12.prod.outlook.com (2603:10b6:207:4c::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.16; Fri, 5 Aug 2022 18:01:21 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::d) by DM6PR03CA0031.outlook.office365.com
 (2603:10b6:5:40::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15 via Frontend
 Transport; Fri, 5 Aug 2022 18:01:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 18:01:20 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 13:01:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 13:01:18 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 5 Aug 2022 13:01:08 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 25/32] drm/amd/display: Enable SubVP by default on DCN32 &
 DCN321
Date: Sat, 6 Aug 2022 01:58:19 +0800
Message-ID: <20220805175826.2992171-26-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
References: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40ab8284-aba6-4808-3da0-08da770c80b3
X-MS-TrafficTypeDiagnostic: BL0PR12MB2467:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I2aqXGEd6jv6Rynvm15aN05lfYo6nWlb0Iikcsrsd5A73hsz+riI18DY9pIiz6bCoXPVMVu7SPvKqjvPQD1wQlgXhHgYp8xss/HGocWOmKQVGaPEMHpmJ0CVxcwdpsVUCB+Bd6DQxs92LC3HNJiJr9gZvyf42JPzm/LMRMqJShoQZBf+qgPga/laH3zRk73jgoqtNr0YVCKCqvp9dVuB3rOrkoLseVndMd4d9wBFyFwFGjHxt3bqibhoMkmBoirIuTyOY4Xd8dPMBR5TywE5bei48lKciip77V4yvD2w2oxfhPBjSCYot2M0XQtBZkJBpY6JqiG0Hyoj1IjVW59nTAhDGtCRKCdTtSfneA6jz3gyRXsg50l+kN7aR6HsZzx/jmFEJ2KHRkshWC9rjDc+40Vmd8V4bt4HkJPKhaOBV4dI75wRMF8jMxEAxcCymx+m0bTXWEhb7Yl7DzZNfP3av1Qnetwna18ZXb14xYl3MiRV5EQZPygI5/6Z7TkCl6387CVo2Oy6+7+uMCGojreQXTlJiXQLaoiDwIC5De8sSBzpYGHsvjG1xJL/OH4OIQD4C04JByXNeN3Cuak5qYITvEas4IaEtIMeq7llBy4SyehnHNOYRcgkLfsGTQYW6Ya3BagnyUeUkBzmKEtWLMzSRqXNnJzXzW+H86cpP1a5KltdJM5QuMBEt+mIqD2EmVvf+qfGTtPB30v21sDityjhgFluDEjyKPtjC9l3Spqihvf9OwfeBx2wfrcIzRJNdV764351StqZnpyYE9GEe6MCZVVpNiIP/M99ebxaktug9bqhJSPz5aD2lzit0xCnsDVBLQWKbt744A//bqbZEvMoFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(376002)(136003)(346002)(46966006)(40470700004)(36840700001)(6916009)(316002)(54906003)(36756003)(41300700001)(7696005)(6666004)(26005)(478600001)(2906002)(86362001)(82310400005)(70586007)(40460700003)(4326008)(70206006)(40480700001)(8676002)(8936002)(426003)(336012)(5660300002)(1076003)(186003)(2616005)(47076005)(81166007)(356005)(82740400003)(36860700001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 18:01:20.7952 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ab8284-aba6-4808-3da0-08da770c80b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2467
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Alvin Lee <alvin.lee2@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why&How]
Set the debug options to enable SubVP feature

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 96076d633273..8b887b552f2c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -867,7 +867,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		}
 	},
 	.use_max_lb = true,
-	.force_disable_subvp = true,
+	.force_disable_subvp = false,
 	.exit_idle_opt_for_cursor_updates = true,
 	.enable_single_display_2to1_odm_policy = true,
 	.enable_dp_dig_pixel_rate_div_policy = 1,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index f627b494737a..e9db5f8b6fdc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -868,7 +868,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		}
 	},
 	.use_max_lb = true,
-	.force_disable_subvp = true,
+	.force_disable_subvp = false,
 	.exit_idle_opt_for_cursor_updates = true,
 	.enable_single_display_2to1_odm_policy = true,
 	.enable_dp_dig_pixel_rate_div_policy = 1,
-- 
2.25.1

