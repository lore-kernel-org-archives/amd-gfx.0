Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 823E6EB64DD
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jun 2023 21:58:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF2F210E5B1;
	Thu, 22 Jun 2023 21:58:28 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2047.outbound.protection.outlook.com [40.107.102.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E64210E5B1
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jun 2023 21:58:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jIZei2OVI4Hj8gI7XVHc+sNtTASgr0/7s/49Ke36h+Yy3BA67uwi5A3/xPeTbsqDvFQDRs3u0X5Epq31Q4GQGO9dGIWSx6uBaNyGwbFnvtusD3vabQDpbdboRqNpw6QzcONaOTn/rdvvxwXNnb4cJfjL9SQlLtEQ7SMQ2kks7GxTWevnEZK8emZ3iIdSCmZPsngR4ZwR/A9jW+GVEoJbbkKufFTXz1RZ0aIbER+WTX5ZKE5XGOC++rslNbnOT5aXerp6E2F8HlUwekobyU+6plijYstd9d5ssvuieAMBRItxNRZoe3NlTbeA0P9PEWLYlJV6jjaHi4oA1plbQwGngw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6lkKA2vzU5CwobYwc/tmzKWtNEazKnijmhO94etKo8=;
 b=mzQsSQ+Bm9Cb1bH9wS3JzRGQtDMBA/bti40xtSDth9aV5o/ED+mW+wxCy09FahTTTAR+XzqtHtVUzeGxutPAa4EJszZv/rVP6G93Sh2EB3r2dxRCvxv0Tw/pZkr75bleaiTgbbxDBINnCkv9Au3JEMieeijOZQ4nYNQQAcxNT8WKCvOrQjceF+0yUf0WYoWxU5AkNkZR7/T7+ckq3Do+NDu1SCmgyJ4mOR37yHNpzHzF14jsfIf0+eR5V5qV+FkE/tySg8VSAsohO71FlalsXSq11xhFpV2PgNdVyD3Kef26/T/fAjFjp6mmWgt5w/fGUF6aeCvBqOW1+bIfSdU5ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6lkKA2vzU5CwobYwc/tmzKWtNEazKnijmhO94etKo8=;
 b=aIDHXfGtVSn58e0g0aNHBcCOCwMByiU1JuEJKn+MV3dJkA+F8SEXy9XKQvaGVwKOmkytFhejDf0rAhmltZAGXeRiOp/MQuZAH50wnafb0HRjeajG1+VgfVfxl7fwue7RkhK8XIoEixoqgTrxPAb2dThF/qXxGkWJDu9bcS0XSQc=
Received: from DM6PR06CA0087.namprd06.prod.outlook.com (2603:10b6:5:336::20)
 by MW3PR12MB4428.namprd12.prod.outlook.com (2603:10b6:303:57::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 21:58:21 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:5:336:cafe::6f) by DM6PR06CA0087.outlook.office365.com
 (2603:10b6:5:336::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 21:58:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 21:58:21 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 16:58:17 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/11] drm/amd/display: Create debugging mechanism for Gaming
 FAMS
Date: Thu, 22 Jun 2023 15:57:33 -0600
Message-ID: <20230622215735.2026220-10-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230622215735.2026220-1-Rodrigo.Siqueira@amd.com>
References: <20230622215735.2026220-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|MW3PR12MB4428:EE_
X-MS-Office365-Filtering-Correlation-Id: fac5a25d-6e0d-4924-c056-08db736bcb4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z8/qGUG6rpjfN+ysUNvet9pBsVVMWr+ztgtCygSucJWfFcKds1lLDA+ofHOTYwgRjWUudGM6gLsa8T9sCfbyi6Sq/F9ypIlNcXuH0YMvvWn9/zqFlhdoEzqF5GXj0NeIO5i334Hg0YcQoil6ielj9sfV4X9MW/pOjOa1usyb0fjCSLDRYotSVY0/L9bKI2yONEROG+EUbCfUAWpMlH9DqQJC7QwhcbClbhkj67vUbNqu7A0fhNOErOf1yGAdEqDyUDTckomOXF4spPEMkEBTUmK1OBWrGBFwrcZ9cBCH9QJoAxQdX6ZLAfUFANeq8kbE2OLP7aEftPsq7AKj3qtvbL4EUyjXb/TCrsefc71gxw0WWBP0wyPZnyCjODXhGhtOG8ZxpPWXMagjImL5dt8zb8abFZTk6ZoBcuC2+KWQA8lY5HjalpSF6/cXKukehJ2KVgGXRwbfx4oDc406fMztKYzijCVza0DkoOsrmNppTKbVKk/9TRUw/ZnB80c7cdGXpCAQJu5xDFuGH8lVD7Jr6ZLJaNoxBPWurlImqI8tY2krJHQQSEhUKUQlcFoU0p3sjA8Y0IRUnS9vWMuIudE9uBgImaQQ7YqpdaJSr41dZZao5BkCpgdS4DSmJ6G6OOj9mIaVj/gmzbHvvnxiLM205MFGxuZ3FQdzZWqPFxPJkmSbFp1975Gw2JqUB+qhZHUuLTeARp+QYvL3B/GQ/33+7MnmUfHfeT6CR/i2zFyAv4rD7Y2sHIrRuMh9KNBIfHVMnMMD2Jhe6t6bhvX989F5Ug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(36860700001)(8936002)(36756003)(5660300002)(8676002)(82740400003)(356005)(81166007)(2906002)(40480700001)(478600001)(16526019)(186003)(6666004)(54906003)(2616005)(86362001)(83380400001)(26005)(1076003)(70206006)(70586007)(336012)(6916009)(426003)(316002)(4326008)(41300700001)(47076005)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 21:58:21.1866 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fac5a25d-6e0d-4924-c056-08db736bcb4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4428
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
Cc: stylon.wang@amd.com, Felipe Clark <felipe.clark@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo
 Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Gianna Binder <gianna.binder@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Gianna Binder <gianna.binder@amd.com>

[WHY]
To enable FAMS even during gaming sessions.

[HOW]
By leveraging a new dc.debug parameter.

Reviewed-by: Felipe Clark <felipe.clark@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Gianna Binder <gianna.binder@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                           | 1 +
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c         | 3 +--
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c | 3 +--
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 90e71c3e766f..110ef14445d9 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -850,6 +850,7 @@ struct dc_debug_options {
 	/* Enable dmub aux for legacy ddc */
 	bool enable_dmub_aux_for_legacy_ddc;
 	bool disable_fams;
+	bool disable_fams_gaming;
 	/* FEC/PSR1 sequence enable delay in 100us */
 	uint8_t fec_enable_delay_in100us;
 	bool enable_driver_sequence_debug;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index a8cb066bc138..abe4c12a10b5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -1987,11 +1987,10 @@ bool dcn30_can_support_mclk_switch_using_fw_based_vblank_stretch(struct dc *dc,
 	if (!is_refresh_rate_support_mclk_switch_using_fw_based_vblank_stretch(context))
 		return false;
 
-	// check if freesync enabled
 	if (!context->streams[0]->allow_freesync)
 		return false;
 
-	if (context->streams[0]->vrr_active_variable)
+	if (context->streams[0]->vrr_active_variable && dc->debug.disable_fams_gaming)
 		return false;
 
 	context->streams[0]->fpo_in_use = true;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index a9c41ef0751f..5be242a1b82c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -595,11 +595,10 @@ struct dc_stream_state *dcn32_can_support_mclk_switch_using_fw_based_vblank_stre
 	if (!is_refresh_rate_support_mclk_switch_using_fw_based_vblank_stretch(fpo_candidate_stream, fpo_vactive_margin_us))
 		return NULL;
 
-	// check if freesync enabled
 	if (!fpo_candidate_stream->allow_freesync)
 		return NULL;
 
-	if (fpo_candidate_stream->vrr_active_variable)
+	if (fpo_candidate_stream->vrr_active_variable && dc->debug.disable_fams_gaming)
 		return NULL;
 
 	return fpo_candidate_stream;
-- 
2.39.2

