Return-Path: <SRS0=OT/I=BY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE11C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 16:57:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A5F9205CB
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 16:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="X2L5dI1e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A5F9205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0385F6E174;
	Fri, 14 Aug 2020 16:57:24 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C488E6E174
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2020 16:57:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9kjoC/RbdR9DXDRu9EI3H0ElpmkUwREDp6jKWECEIu6d/t4XR+7QOR1GSNhuWkAZDrdoYz4wmHtXKXlP8VDSrvQ3epw7I1IXh3kbe4Npp1AkMBK89NmnUtbxicB6CM1gbZpC0ToqgmPPZ3i9oLUpMqusCGo01gSwudtijmskcaymo6a2ca6IKVfUQG2mieA930ItoFSKBT+rJqAR0MIIYhIrpx+tsk1QlwaWecvIWqtpR/a3RQXXZ8HY/Q+/FnnU3M4GHnyy5tb5U07r6rEtSxt3WdBMz7warc3hpRIj9TJ5d8LVwdS8yUTEy7LGB2lCVMb+K8hXjRdLGVWSNvO+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sgBA80oZuiadsOxpPjEjQ3TDnQCWdkVr97GTnkK9ns=;
 b=WXiWEKWLM604zXyXuM5J0pf+DWP9xkLCuAKqRhkAPi9fCc5W3QjyEo8NeLZK+6ihTbZfKmNRxhOSWnm3eR2EJmOzY0OBU2zozggZB1VdgzdfPfpw6UBBuMC9h60STgZ64ZngBDisRF/0QPXrw1VNMW+t/hB14+uPtz5nzo9m98VogNHVZg0p1ouuMTbtDMz5BQuZeDhDEOrnSbczyFtXjSewyawuIuMNzowX33NI0tqCatpjp19ART4WUuL+IpRWw/ITpghgg5zQK5qhaQ6ZL7gSf2DSE0EM4wrxK+FrBGxIXSvXuPwlgZb+QWHBw+xmIRoUG/NyCOc3lyBJtPCl5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sgBA80oZuiadsOxpPjEjQ3TDnQCWdkVr97GTnkK9ns=;
 b=X2L5dI1eksCRISvLiuovqa87/QSjXnYbourflue4VRPIQjElxuqxUBQPfkUC6E2j088Gr83H0wTwnRZfcu5iBfCLu3SoPZVhlye+XnXMLnGi/kSpQiviIbghMyc+Od+4USFdwMd1AXK75KfXWs/YcDdQcTybhbKoHUt8PuVpnYg=
Received: from DM5PR13CA0035.namprd13.prod.outlook.com (2603:10b6:3:7b::21) by
 DM6PR12MB4451.namprd12.prod.outlook.com (2603:10b6:5:2ab::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15; Fri, 14 Aug 2020 16:57:16 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:7b:cafe::e5) by DM5PR13CA0035.outlook.office365.com
 (2603:10b6:3:7b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.16 via Frontend
 Transport; Fri, 14 Aug 2020 16:57:16 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3283.16 via Frontend Transport; Fri, 14 Aug 2020 16:57:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 14 Aug
 2020 11:57:14 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 14 Aug
 2020 11:57:14 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 14 Aug 2020 11:57:14 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <mikita.lipski@amd.com>, <nicholas.kazlauskas@amd.com>,
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: Add DSC_DBG_EN shift/mask for dcn3
Date: Fri, 14 Aug 2020 12:57:11 -0400
Message-ID: <20200814165711.26394-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 393062ba-9686-49f3-6d0f-08d84073196d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4451:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4451EA3DB496FA303E435AA0F9400@DM6PR12MB4451.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZgHJJoX3JEgoTTnZlKx3is/Qt8+lzV1fh7F+ABpynaPcby+y4F9I7fDMPP/szMteQWJOVJREYGyLo8H07A/x8K2zNybtVWC3iBpJO3IfyjOf3U73FcGs1QwF+ibYb8995LagLAa4Z2oPQW47hAySCixTJ2pVyZKSYquJTJ/FQWdPESXOaT+4LFwyrtZxjyN9CEuMSqG5hDh7AGA9kjx1IAjMCJRbwgnQcyesdUmNId7Dc6QkTmcMfSpoam8ZiLOn9LqTl3flFzBt76Jgq9tt61FI62/jO5M/Mfy1HVE4kQKOB2GvZ+vc69nfcVLZ4VZQfppm84UjvDWzf7vObqdbvkqWYAcgXntb/PuwylmuSZKP9iVSpLQJYIiXmjGD4pRPKGLYfA0gu0Yf6uxfdqiJmg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(46966005)(2906002)(36756003)(86362001)(70206006)(54906003)(336012)(426003)(2616005)(478600001)(6666004)(8676002)(110136005)(316002)(4326008)(81166007)(1076003)(82310400002)(356005)(7696005)(8936002)(47076004)(5660300002)(6636002)(70586007)(82740400003)(26005)(83380400001)(186003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 16:57:16.4104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 393062ba-9686-49f3-6d0f-08d84073196d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4451
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This field is not defined for DCN3

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dsc.h  |  1 +
 .../include/asic_reg/dcn/dcn_3_0_0_sh_mask.h  | 22 +++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.h
index 667640c4b288..1118e33aaa2c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.h
@@ -94,6 +94,7 @@
 	DSC_SF(DSC_TOP0_DSC_TOP_CONTROL, DSC_CLOCK_EN, mask_sh), \
 	DSC_SF(DSC_TOP0_DSC_TOP_CONTROL, DSC_DISPCLK_R_GATE_DIS, mask_sh), \
 	DSC_SF(DSC_TOP0_DSC_TOP_CONTROL, DSC_DSCCLK_R_GATE_DIS, mask_sh), \
+	DSC_SF(DSC_TOP0_DSC_DEBUG_CONTROL, DSC_DBG_EN, mask_sh), \
 	DSC_SF(DSCC0_DSCC_CONFIG0, ICH_RESET_AT_END_OF_LINE, mask_sh), \
 	DSC_SF(DSCC0_DSCC_CONFIG0, NUMBER_OF_SLICES_PER_LINE, mask_sh), \
 	DSC_SF(DSCC0_DSCC_CONFIG0, ALTERNATE_ICH_ENCODING_EN, mask_sh), \
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h
index 0e0319e98c07..ea683f452bb3 100755
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h
@@ -50271,6 +50271,10 @@
 #define DSC_TOP0_DSC_TOP_CONTROL__DSC_CLOCK_EN_MASK                                                           0x00000001L
 #define DSC_TOP0_DSC_TOP_CONTROL__DSC_DISPCLK_R_GATE_DIS_MASK                                                 0x00000010L
 #define DSC_TOP0_DSC_TOP_CONTROL__DSC_DSCCLK_R_GATE_DIS_MASK                                                  0x00000100L
+//DSC_TOP0_DSC_DEBUG_CONTROL
+#define DSC_TOP0_DSC_DEBUG_CONTROL__DSC_DBG_EN__SHIFT                                                         0x0
+#define DSC_TOP0_DSC_DEBUG_CONTROL__DSC_DBG_EN_MASK                                                           0x00000001L
+
 
 // addressBlock: dce_dc_dsc0_dispdec_dsccif_dispdec
 //DSCCIF0_DSCCIF_CONFIG0
@@ -50789,6 +50793,9 @@
 #define DSC_TOP1_DSC_TOP_CONTROL__DSC_CLOCK_EN_MASK                                                           0x00000001L
 #define DSC_TOP1_DSC_TOP_CONTROL__DSC_DISPCLK_R_GATE_DIS_MASK                                                 0x00000010L
 #define DSC_TOP1_DSC_TOP_CONTROL__DSC_DSCCLK_R_GATE_DIS_MASK                                                  0x00000100L
+//DSC_TOP1_DSC_DEBUG_CONTROL
+#define DSC_TOP1_DSC_DEBUG_CONTROL__DSC_DBG_EN__SHIFT                                                         0x0
+#define DSC_TOP1_DSC_DEBUG_CONTROL__DSC_DBG_EN_MASK                                                           0x00000001L
 
 
 // addressBlock: dce_dc_dsc1_dispdec_dsccif_dispdec
@@ -51308,6 +51315,10 @@
 #define DSC_TOP2_DSC_TOP_CONTROL__DSC_CLOCK_EN_MASK                                                           0x00000001L
 #define DSC_TOP2_DSC_TOP_CONTROL__DSC_DISPCLK_R_GATE_DIS_MASK                                                 0x00000010L
 #define DSC_TOP2_DSC_TOP_CONTROL__DSC_DSCCLK_R_GATE_DIS_MASK                                                  0x00000100L
+//DSC_TOP2_DSC_DEBUG_CONTROL
+#define DSC_TOP2_DSC_DEBUG_CONTROL__DSC_DBG_EN__SHIFT                                                         0x0
+#define DSC_TOP2_DSC_DEBUG_CONTROL__DSC_DBG_EN_MASK                                                           0x00000001L
+
 
 // addressBlock: dce_dc_dsc2_dispdec_dsccif_dispdec
 //DSCCIF2_DSCCIF_CONFIG0
@@ -51826,6 +51837,9 @@
 #define DSC_TOP3_DSC_TOP_CONTROL__DSC_CLOCK_EN_MASK                                                           0x00000001L
 #define DSC_TOP3_DSC_TOP_CONTROL__DSC_DISPCLK_R_GATE_DIS_MASK                                                 0x00000010L
 #define DSC_TOP3_DSC_TOP_CONTROL__DSC_DSCCLK_R_GATE_DIS_MASK                                                  0x00000100L
+//DSC_TOP3_DSC_DEBUG_CONTROL
+#define DSC_TOP3_DSC_DEBUG_CONTROL__DSC_DBG_EN__SHIFT                                                         0x0
+#define DSC_TOP3_DSC_DEBUG_CONTROL__DSC_DBG_EN_MASK                                                           0x00000001L
 
 
 // addressBlock: dce_dc_dsc3_dispdec_dsccif_dispdec
@@ -52346,6 +52360,10 @@
 #define DSC_TOP4_DSC_TOP_CONTROL__DSC_CLOCK_EN_MASK                                                           0x00000001L
 #define DSC_TOP4_DSC_TOP_CONTROL__DSC_DISPCLK_R_GATE_DIS_MASK                                                 0x00000010L
 #define DSC_TOP4_DSC_TOP_CONTROL__DSC_DSCCLK_R_GATE_DIS_MASK                                                  0x00000100L
+//DSC_TOP4_DSC_DEBUG_CONTROL
+#define DSC_TOP4_DSC_DEBUG_CONTROL__DSC_DBG_EN__SHIFT                                                         0x0
+#define DSC_TOP4_DSC_DEBUG_CONTROL__DSC_DBG_EN_MASK                                                           0x00000001L
+
 
 // addressBlock: dce_dc_dsc4_dispdec_dsccif_dispdec
 //DSCCIF4_DSCCIF_CONFIG0
@@ -52864,6 +52882,10 @@
 #define DSC_TOP5_DSC_TOP_CONTROL__DSC_CLOCK_EN_MASK                                                           0x00000001L
 #define DSC_TOP5_DSC_TOP_CONTROL__DSC_DISPCLK_R_GATE_DIS_MASK                                                 0x00000010L
 #define DSC_TOP5_DSC_TOP_CONTROL__DSC_DSCCLK_R_GATE_DIS_MASK                                                  0x00000100L
+//DSC_TOP5_DSC_DEBUG_CONTROL
+#define DSC_TOP5_DSC_DEBUG_CONTROL__DSC_DBG_EN__SHIFT                                                         0x0
+#define DSC_TOP5_DSC_DEBUG_CONTROL__DSC_DBG_EN_MASK                                                           0x00000001L
+
 
 // addressBlock: dce_dc_dsc5_dispdec_dsccif_dispdec
 //DSCCIF5_DSCCIF_CONFIG0
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
