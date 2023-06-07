Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A3EC7EE2F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 12:17:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F58810E4D8;
	Wed,  7 Jun 2023 12:17:06 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::60b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B5AA10E4D5
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 12:17:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5vnRK/ze0YdwE7NJ4Ppb4pxz7BA8sJIjabw/Rqv2z/tmlTI5NH9M3213pLD3Lqghmm08NWsCE71dprOOtmP0OSGOyu6dKgMTAWyhtsmIEMaGnhaZytzgUiMeh3U/1H4u1LBeK0W5Ucwhz+wScIn6ZucV7cxtT4JaGXZsPH9fJhrRBoHoPevhJDTcHFNeInNfVi4X2bnpqEb1BV5RwiibqUydNnV8og8MkrkBRUOvoXgsH0A5iS/yOI5Z4sctpjQyvNaa7QIb/2QW8CbLXpu5l1/grR0bWu2tj8W0cAdsZ5Gv0BLGrnvfSC1SLzyxZ09VjBdyzrLpzWqT2b7PExrpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KRUMnGlpHVLMU4PvmLtf9b4NJLR2J/gWW6IIH77l0dk=;
 b=gGykifbsSsGB5DxptyNYofCRxcCdC/srSv1Gl6s9q8Z8Av1DSOJEQtcMT4/XFd1+dGIFc9oW79ehWC6mVpU6mnERKwnOuOw0X44NXymVLWvlhK46k2/pOm9yY9RUE9Q5UJRAJQnu8sNvuj4wIIY+HskWoAvYYPQpxqUZn+d5XcJI5wK2Tr+9ygKo4dq829Ox+XsU0E1yzb/0udUe7M6M/SL1+rGae+x5zDbAKKT+UbpXw4SKxP54EOr7nr37GivZrE3QdMeag5aCXHXqjm1X3lqK/K5Il2tEX5YckPGFqzf5Q7Gx4tDqAAqc92Rz4o344KCLxlXCicO4f2Ef3yTgXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRUMnGlpHVLMU4PvmLtf9b4NJLR2J/gWW6IIH77l0dk=;
 b=t1CH3k3pBC6+3h1NlOjAzwDXD4mUvrJUD6pQ/kEyBeGupIm7cKhHt3vmTyVkj+DBHO9oBZKObC20e3RsixSjC/RaS+y4CC9HHOfQMSy5meW0HCqCLv9CxJogSxiIcpJrSCAOje+ZIgcA6TloZrFMVntTT3p4jPxPCaxAYW6ss7U=
Received: from DS7PR03CA0068.namprd03.prod.outlook.com (2603:10b6:5:3bb::13)
 by DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.32; Wed, 7 Jun 2023 12:17:01 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:5:3bb:cafe::d4) by DS7PR03CA0068.outlook.office365.com
 (2603:10b6:5:3bb::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Wed, 7 Jun 2023 12:17:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 12:17:01 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 07:16:55 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/20] drm/amd/display: Block SubVP + DRR if the DRR is PSR
 capable
Date: Wed, 7 Jun 2023 20:15:40 +0800
Message-ID: <20230607121548.1479290-13-stylon.wang@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230607121548.1479290-1-stylon.wang@amd.com>
References: <20230607121548.1479290-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|DM4PR12MB6373:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fd5f831-0f17-44d2-a816-08db6751194e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zc/ji24pyywJLHtnCrdyvcs6u6DNvWso8uFP30pcxd4QAvJB+f8PpYCcr5/ZR5wqgfEXOMfbua4+hK2axEyAS6NutI+z7xnbAs81dy65ACfH//79ObXTAOkId7TBg3BY4EYq6dpPPps+0V+Rneoj3sriGC4H17T3UQcgAGedSH6AY4CrIHP6R04eDXQYOY/V6OMArwlDzqNzMbNr7PDQnPLSdw9suiTMdFuam+OZ6zwybQINZnXBrKMRNiB7nq5fKJd/5ZqEftCYEbAKA/Sx7YXZ1MYiAuDNA8K+7eoqibi9ULFh/UEtci4juY7Zpfckvfm3wZ01fsbaWRUYowSDIbTigsjg5rsYLGc0hNlH6m/N3oKgL6PHJ1EpU2p+VPB9I1vD7yRSIQ2+ZSiIrXnRa+Kt01wu1yb3O9V1P5yATzidEidhQyD2+WMTo2FwdXNlad5lcBPMT2+dQv4jKeCQLoEw+q/RZIbmj7ASkpQNsHwC26l5JEkeugxAKr7gwyQjAp8tLKJMoiVmnNw6wvCm/mdcMrddlizFsdDZ+Ew0QMvo8KJJsNEDdxN7P0c4SsGfirCi8RmHoUGZpp0a07oQU16UmSTknTT3J9Bk/8+W+54BScGmZxyL0prMtWpta1SXJazcRA/dye5uZMjLL+6BHshPKJNzTgfIaKNsgT9BP04edqHG+8fu7u8NFnuRjLPxjWAyj/D/ftWEko6JNGSF+bAKLqfqwurSJZzr+BkpCCVNdHmzUNMggGpgFYgZrBxaioi70L3EIWkhwCNX0cSHDA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199021)(46966006)(36840700001)(40470700004)(47076005)(83380400001)(336012)(426003)(44832011)(82740400003)(54906003)(4326008)(478600001)(8676002)(8936002)(70586007)(41300700001)(356005)(81166007)(316002)(40460700003)(5660300002)(6916009)(86362001)(70206006)(6666004)(36756003)(7696005)(2906002)(40480700001)(82310400005)(36860700001)(16526019)(186003)(26005)(1076003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 12:17:01.6560 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd5f831-0f17-44d2-a816-08db6751194e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6373
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <alvin.lee2@amd.com>,
 wayne.lin@amd.com, Saaem Rizvi <SyedSaaem.Rizvi@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
PSR implementation in FW has inline polling which can poll for up
to 1ms. This will interfere with SubVP because SubVP is timing
sensitive and can't tolerate up to 1ms worth of delay before
handling vertical or VLINE interrupts. Therefore block SubVP + DRR
cases if DRR is PSR capable

Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Reviewed-by: Saaem Rizvi <SyedSaaem.Rizvi@amd.com>
---
 .../drm/amd/display/dc/dcn32/dcn32_resource_helpers.c  | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index 578070e7d44b..7eec39576e2c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -672,6 +672,7 @@ bool dcn32_check_native_scaling_for_res(struct pipe_ctx *pipe, unsigned int widt
  * - Config must have 2 displays (i.e., 2 non-phantom master pipes)
  * - One display is SubVP
  * - Other display must have Freesync enabled
+ * - The potential DRR display must not be PSR capable
  *
  * @return: True if admissible, false otherwise
  *
@@ -684,6 +685,7 @@ bool dcn32_subvp_drr_admissable(struct dc *dc, struct dc_state *context)
 	uint8_t subvp_count = 0;
 	uint8_t non_subvp_pipes = 0;
 	bool drr_pipe_found = false;
+	bool drr_psr_capable = false;
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
@@ -696,6 +698,7 @@ bool dcn32_subvp_drr_admissable(struct dc *dc, struct dc_state *context)
 				subvp_count++;
 			if (pipe->stream->mall_stream_config.type == SUBVP_NONE) {
 				non_subvp_pipes++;
+				drr_psr_capable = (drr_psr_capable || dcn32_is_psr_capable(pipe));
 				if (pipe->stream->ignore_msa_timing_param &&
 						(pipe->stream->allow_freesync || pipe->stream->vrr_active_variable)) {
 					drr_pipe_found = true;
@@ -704,7 +707,7 @@ bool dcn32_subvp_drr_admissable(struct dc *dc, struct dc_state *context)
 		}
 	}
 
-	if (subvp_count == 1 && non_subvp_pipes == 1 && drr_pipe_found)
+	if (subvp_count == 1 && non_subvp_pipes == 1 && drr_pipe_found && !drr_psr_capable)
 		result = true;
 
 	return result;
@@ -722,6 +725,7 @@ bool dcn32_subvp_drr_admissable(struct dc *dc, struct dc_state *context)
  * - One display is SubVP
  * - Other display must not have Freesync capability
  * - DML must have output DRAM clock change support as SubVP + Vblank
+ * - The potential vblank display must not be PSR capable
  *
  * @return: True if admissible, false otherwise
  *
@@ -735,6 +739,7 @@ bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int
 	uint8_t non_subvp_pipes = 0;
 	bool drr_pipe_found = false;
 	struct vba_vars_st *vba = &context->bw_ctx.dml.vba;
+	bool vblank_psr_capable = false;
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
@@ -747,6 +752,7 @@ bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int
 				subvp_count++;
 			if (pipe->stream->mall_stream_config.type == SUBVP_NONE) {
 				non_subvp_pipes++;
+				vblank_psr_capable = (vblank_psr_capable || dcn32_is_psr_capable(pipe));
 				if (pipe->stream->ignore_msa_timing_param &&
 						(pipe->stream->allow_freesync || pipe->stream->vrr_active_variable)) {
 					drr_pipe_found = true;
@@ -755,7 +761,7 @@ bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int
 		}
 	}
 
-	if (subvp_count == 1 && non_subvp_pipes == 1 && !drr_pipe_found &&
+	if (subvp_count == 1 && non_subvp_pipes == 1 && !drr_pipe_found && !vblank_psr_capable &&
 			vba->DRAMClockChangeSupport[vlevel][vba->maxMpcComb] == dm_dram_clock_change_vblank_w_mall_sub_vp)
 		result = true;
 
-- 
2.40.1

