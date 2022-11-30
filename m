Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A6C4C4321E
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Nov 2022 06:40:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B44C310E296;
	Wed, 30 Nov 2022 06:40:52 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A236610E296
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Nov 2022 06:40:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQ684GzG8rv3wfLgiT6HpoZ7jpjqbm0w6NwJHkJAyfp1TpV1pLXAipdZwWOJjdWD51cZE2EHw9NP8IEzzXVVVXs9opmhJ2YrJzAdu13x0PEwGnrF4QlfI0k/PZ+6LFvUsO+kwmMUb1zas5nk7qPaCFGbYE9UbtcusNflVcyAzJ1H3J0p7x1/MOpOCj9NyEQdB2WGh9lGpHY6KeSDq1Mt+NGmSzCxt9R39RVtQFxd/6D6DBIWbd02/JQA3nXivLvoUB6UuCk6c+0NlgHphcVyMD5eQ/NOJwJs63jtiyW6PhnWClSNADK/EX/oEYDa5JbaFTsvgh/CKPvkpxo5lE7B5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHLdosuS8WKivoHPjdZE80I2uYpR36NiyW585fqIj8E=;
 b=JY0Jy3MY/X2aap+4Qsu4F/MlLCfLqp9UbtAiyuk7Sl43bDf0Y07xLlD0UhczJDQDhcQQ5w/DD6KJJWcU+jt+PZPju13HysywB/d+MsBzI6DX1HpGFlR2XHe5UHfETOuWwzic0CvRV9J24p/t2FDEzRzlbXTawMVCDWBj4J+tEHUlhcxpVtIPFSPqgK/crdUF+4xsS6j3hqfUPgYvzcWYge49jgHSlgvVQFSpkkRd4HyogFNjUhken29L3ofNIu7xnZijoRjqZ6xLvW32CZ/2PAu7uV0LdldKRs67CRI2bYn45KD2JqQwg7fAWGE9pp3Zes2UQyJLkuDXyTyocwP4eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHLdosuS8WKivoHPjdZE80I2uYpR36NiyW585fqIj8E=;
 b=fi9WBfvg1tX6d5qmlL3qqhb4gWsLsNl8VbbbqBYiTHPPuZ67YPqSqunVljDmRYMLc1kywyyExBFlUM555THp6/Iyc7lAmDHaxiPpteW2nJhErC0vxiBK7uO6thbjsSP4MlwBOOpWFLO271f2MaR3Pr2F/Bf/oF/4PVraqI7vBx4=
Received: from BN9PR03CA0760.namprd03.prod.outlook.com (2603:10b6:408:13a::15)
 by SN7PR12MB8130.namprd12.prod.outlook.com (2603:10b6:806:32e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 06:40:46 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::4e) by BN9PR03CA0760.outlook.office365.com
 (2603:10b6:408:13a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Wed, 30 Nov 2022 06:40:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Wed, 30 Nov 2022 06:40:46 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 30 Nov
 2022 00:40:42 -0600
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/14] drm/amd/display: Add debug option to skip PSR CRTC
 disable
Date: Wed, 30 Nov 2022 14:36:25 +0800
Message-ID: <20221130063627.2398341-13-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221130063627.2398341-1-stylon.wang@amd.com>
References: <20221130063627.2398341-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT021:EE_|SN7PR12MB8130:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c6e0a56-82cb-43c3-c2df-08dad29dcfe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3HwBqi56DLMWsDGiYWS0Cdt0Lbnv13+TCWoCLE7eogdu5esL9yS5W97TSY/tTVoqVwuLOhJNFJf78SwRzqN5v+rgjTkbcNhHy1bTlzxZX57EAoyRXxCPUbTdtUdz+MaUGE2JfCy3FWPMCNxN7Jck7nCKiw+OW6/+0tFIjf+yOSKDAmxdxUaK7LLTe87Yv2P5UNpEdzYj0cxlV3czWwjuTsz7iMmIINF2/fO4TFxJWXQkgKRcKAdqKj8gTYtRkzESzRdpQesrtRVPuqSz3tLVJ9tbREaWjP31AL2S9RYrlNegEhJsnlDFmW1Oni4qJKAlD9dhmiAA9cShEpZkIHTKJeJgBvrd/0i9h9Yi684loFQ9d5P9b2/MkjeJbg9WKs0X9cpK15Lqi4Nyh83RDxuSJSM81eE7lGx+kA49ZKbm6ssXYD9TEHcWyaQ3+wVQI+3+rqKwKW4BEfDeKEShgVdEtiNKjlWVyMyG4OZveExFNZtLY1xE3eA8fpKLTizL93a0UDDDNPdmv+CrU1CuPfE8W09w2uRb0hGFY2ss0AN1UiWHjhMmgZe0FqLvI27mJr7l+0qq8PTsP5/gkO4xLkeWDBOZNEAhkLr+npG/f8LDkv3I2TGTPw60GdENxWBvHJQ+6AooogtaH908f5DY+yhd2T+0wlRmX8B7bsBC4tPsShV+zZfbQNDWVTBUyz5PmCvG+J1ExU8U06etkKIDzJYNjOHDwEQrZR0yqGCB2j5nlOg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199015)(36840700001)(40470700004)(46966006)(8936002)(44832011)(5660300002)(8676002)(70206006)(70586007)(4326008)(2906002)(41300700001)(54906003)(1076003)(6916009)(316002)(2616005)(7696005)(36756003)(26005)(478600001)(186003)(82310400005)(336012)(83380400001)(6666004)(40480700001)(40460700003)(36860700001)(16526019)(356005)(47076005)(81166007)(426003)(82740400003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 06:40:46.5255 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6e0a56-82cb-43c3-c2df-08dad29dcfe1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8130
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Robin Chen <robin.chen@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
It's currently tied to Z10 support, and is required for Z10, but
we can still support Z10 display off without PSR.

We currently need to skip the PSR CRTC disable to prevent stuttering
and underflow from occuring during PSR-SU.

[How]
Add a debug option to allow specifying this separately.

Reviewed-by: Robin Chen <robin.chen@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c           | 2 +-
 drivers/gpu/drm/amd/display/dc/dc.h                     | 1 +
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 5304e9daf90a..342e906ae26e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3378,7 +3378,7 @@ bool dc_link_setup_psr(struct dc_link *link,
 		case FAMILY_YELLOW_CARP:
 		case AMDGPU_FAMILY_GC_10_3_6:
 		case AMDGPU_FAMILY_GC_11_0_1:
-			if (dc->debug.disable_z10)
+			if (dc->debug.disable_z10 || dc->debug.psr_skip_crtc_disable)
 				psr_context->psr_level.bits.SKIP_CRTC_DISABLE = true;
 			break;
 		default:
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 4a7c0356d9c7..3cb8cf065204 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -844,6 +844,7 @@ struct dc_debug_options {
 	int crb_alloc_policy_min_disp_count;
 	bool disable_z10;
 	bool enable_z9_disable_interface;
+	bool psr_skip_crtc_disable;
 	union dpia_debug_options dpia_debug;
 	bool disable_fixed_vs_aux_timeout_wa;
 	bool force_disable_subvp;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index 4fffc7bb8088..f9ea1e86707f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -886,6 +886,7 @@ static const struct dc_plane_cap plane_cap = {
 static const struct dc_debug_options debug_defaults_drv = {
 	.disable_z10 = false,
 	.enable_z9_disable_interface = true,
+	.psr_skip_crtc_disable = true,
 	.disable_dmcu = true,
 	.force_abm_enable = false,
 	.timing_trace = false,
-- 
2.25.1

