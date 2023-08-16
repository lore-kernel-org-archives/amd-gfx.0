Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C06C001E0
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 06:08:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBD7610E2D4;
	Wed, 16 Aug 2023 06:08:55 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A12C10E2EA
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 06:08:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLCOlpANjnGbd/KmeD/ozBmvtjjAQEiGJmAmdpEIjEq8KTu2ALI+7r0N8KGSjyilLwqazP5IvKAUsOyhIMjE8KvtSaMytq+0kwjglWbrod2dhTym6+URg/utvv7gyx4U7APxpf4uoG8O1fsvVL+XA60SRSJFrz/EWs5UKMMsq9M8/TTfmfG/TxXbQUYt/jCRhdL0BzFDIO2nqRVU/7ionWHLGts8k3KuOtGZk7Ol8nzzg+hCjzjJrPSvBDcg/NSqPaOIiHoaAWFKxV+5AMhwRQr7PiRgqw6xwZGnPIxugf/ezJV/hzsBudbjPaTqEmKHEdLikLOfHSPidP5remjBFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Joe58ZITzVxwfqloV1l7hK2BvRKm/dZDrGY6r8ixoD0=;
 b=lxGy95HudueOvec5V2kJWPv2ZyQJ2dqJReeZ936VVesrr7ZGVqH8eFdvmhYJuyHZIUQ2obKhwoupFsEk9I/GFig1avIAGx6LaAwZqoEbAe3lTcOm0WtO7SIeDbG/JDgB6bz69KGBbAVS4sJ2I/3ogCKPQG0ose1w1ifyPcX2KemOvaSKXwvQglUQyYrdn8hvVYjyF2HHKsOV/fYRzDI4LddaNbor/IeI84puDd3Lb4OOf2Tpibn213T6QLmBYb/e2dajAZ8DKLzSk9bSMY9Z0c0KONhAb+vxvaqM/cmjxc5A+lH4N2vPJpuhWE0GTcW5Q/5QPPS9M+OSJKaUOkaktg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Joe58ZITzVxwfqloV1l7hK2BvRKm/dZDrGY6r8ixoD0=;
 b=c0juu2szprvcv2BSmN0wehLZ6ELk9pf+KhEVgmpIqweapjA1dT8fwOSvs9ZQssUTiCphD4X1zZqOraVzgkUo2cXSZWlREn4WFsjlA4Afq3V545ltnI6Qn16ylm9FSdRhepm985bz1v4wgkpEGVolxpOhbt6R6VEXOByOv147F3o=
Received: from DM6PR03CA0059.namprd03.prod.outlook.com (2603:10b6:5:100::36)
 by DS7PR12MB8084.namprd12.prod.outlook.com (2603:10b6:8:ef::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.26; Wed, 16 Aug 2023 06:08:51 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:5:100:cafe::c8) by DM6PR03CA0059.outlook.office365.com
 (2603:10b6:5:100::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 06:08:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 06:08:51 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 01:08:50 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 01:08:50 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 16 Aug 2023 01:08:44 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/16] drm/amd/display: Save addr update in scratch before flip
Date: Wed, 16 Aug 2023 14:06:54 +0800
Message-ID: <20230816060658.2141009-13-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230816060658.2141009-1-Wayne.Lin@amd.com>
References: <20230816060658.2141009-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|DS7PR12MB8084:EE_
X-MS-Office365-Filtering-Correlation-Id: 2719b63b-43f2-4a22-a452-08db9e1f4344
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qPJRp6zl6aLXHnFxCQ6NjB4dJ0IsHu0tOq8S3RA1Av7E2h6kqijCdv+7SX2C6TJoIunaI6lPbtCiXssXzRhHXNrVlWLeftTtbVx1q78ctSjBRX21PvIL4WvO9QFwhoTeIYTtVVF0JsiIx7us1gKX/5SmI6M8K0l9YAze/o2Y5HTuYrVGzobgKL3KkKD3RkhkReQlAKEtaxSvs225UB2F8TXAAqt0r1x+Peh+WvXOV2SDPd/DrfVVhDadRKNCcNVPfPgtwS4HCzkpj3bT3lfJ6bhVL5+06PIgbRxsHE8YCYzNe5l6hbbTmn4x6JRo/uGEwTklrYRQD6scxo5ATUqVDPjJhz+ND6VdK1K4hbD/apAwp43d94vfEQFLXnxRnFQUb0NMLl3Nc7u7Xx+qYcBKELyyb6JdRdHvQhXz/7K04LM1hS6RXu6Z/Cb5jR0W0ctNLFvu/YzoDdIAqWCWoqoNzFknHt5NGnhXHTisQ5e7Vqt9ECbZdEmYNEEqrvPrp0Hc+UlOQX/FPBGv18gsrFfQuhiN4S8/jEd/FevD+q0M11xMXbOfcIOkoP1tu/diQHQMG3T2ox8VUxBLg64diAjxaz/XiVpyw7eantrnMHYnGfd+43c1mVlYH85DTy/CKJsB8WvNzD8u3kRyx+v6YCBfeYqPtUvHEH7kLE/W2KhQNSrz8UvGSa7Zd2kM6/5T713WWY55vBKKTdx6iBWQ9NlcrU69lTitFwG1XXPx+/TT2WwIjgtlNCf+M1vDhLdnIm4TpJZAQ5AT3RWGLjRcVpQ9Qw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(1800799009)(82310400011)(451199024)(186009)(46966006)(36840700001)(40470700004)(6666004)(54906003)(70586007)(70206006)(7696005)(2906002)(478600001)(15650500001)(1076003)(336012)(426003)(26005)(6916009)(5660300002)(2616005)(83380400001)(41300700001)(316002)(47076005)(36860700001)(8936002)(4326008)(82740400003)(8676002)(81166007)(356005)(40460700003)(36756003)(86362001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 06:08:51.1710 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2719b63b-43f2-4a22-a452-08db9e1f4344
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8084
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
Cc: stylon.wang@amd.com, Austin Zheng <austin.zheng@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Why & How]
Fix a minor sequencing issue where the address update for
a subvp flip should be saved in scratch registers before
the actual flip

Reviewed-by: Austin Zheng <austin.zheng@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index a50df7126e39..fe07160932d6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -528,11 +528,6 @@ void hwss_build_fast_sequence(struct dc *dc,
 				(*num_steps)++;
 			}
 			if (dc->hwss.update_plane_addr && current_mpc_pipe->plane_state->update_flags.bits.addr_update) {
-				block_sequence[*num_steps].params.update_plane_addr_params.dc = dc;
-				block_sequence[*num_steps].params.update_plane_addr_params.pipe_ctx = current_mpc_pipe;
-				block_sequence[*num_steps].func = HUBP_UPDATE_PLANE_ADDR;
-				(*num_steps)++;
-
 				if (resource_is_pipe_type(current_mpc_pipe, OTG_MASTER) &&
 						current_mpc_pipe->stream->mall_stream_config.type == SUBVP_MAIN) {
 					block_sequence[*num_steps].params.subvp_save_surf_addr.dc_dmub_srv = dc->ctx->dmub_srv;
@@ -541,6 +536,11 @@ void hwss_build_fast_sequence(struct dc *dc,
 					block_sequence[*num_steps].func = DMUB_SUBVP_SAVE_SURF_ADDR;
 					(*num_steps)++;
 				}
+
+				block_sequence[*num_steps].params.update_plane_addr_params.dc = dc;
+				block_sequence[*num_steps].params.update_plane_addr_params.pipe_ctx = current_mpc_pipe;
+				block_sequence[*num_steps].func = HUBP_UPDATE_PLANE_ADDR;
+				(*num_steps)++;
 			}
 
 			if (hws->funcs.set_input_transfer_func && current_mpc_pipe->plane_state->update_flags.bits.gamma_change) {
-- 
2.37.3

