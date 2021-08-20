Return-Path: <SRS0=vXfK=NL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BC8C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 23:29:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EBD261178
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 23:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0EBD261178
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B430C6EB2B;
	Fri, 20 Aug 2021 23:29:48 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2048.outbound.protection.outlook.com [40.107.101.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3652A6EB2B
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Aug 2021 23:29:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+HBQhhXpcZksw2Y9PonUlkb3ZRZQhsaaNAJyqDPE6iaHQP4lGvENqknq9I4zmMFd5qXr/vBv8F/QhrCEs3LFv0k0SIvQ+DCbcq6InnfN+SOoOE5en7rhJ+Bn45mVzGrVqy2Ll8O96TUxblBJ1qb4C8w03Jguv3/YN01xESNX8VFUZNIHQteneGH9Wb2VnoqX59FdkdLhuNM1HDYOJ11/Bv4RshXY44IkRnw8VZBU7mPJXtx8/fVUIGFMEZBzXyicunqTWvoqdeBWE1T1fQhKIckHaUKec92qNJVBGH2QuXcLrdzAjrqBAPsOgYoO8biSLdMdpPZYmOlVs/flX9Evg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPJ/w+MuCtub0UQ9FEtsdqL4FGgVwmXt28sqbHTR04Q=;
 b=YAYf7RA7ln37v3hLJghzl30bluEiQlTA8gu0hwb1SDLA33fMVZOIbfcEYJe/sVfSaUsAaYA2ka4WMhXA+A7IjTOxO3B6944Yasi6/cfeam26t7rZ5djS4W/iEcoRYHcJcafGp/vV5nK3mGoSBHxSnkxmaO74U8zMwoJFRToTVCxl/SkTmydfAzAWNLZIvE7XgAT+0Gsnd1LACLFcTNsm29jfIxoW+oJtrNYdjBP8DbvrsY3pZcE2WEkzvD9reBZEGJO7u+C31vHvQEIHxZCSWoy7+FUTPJ3h3XdC3lXpHOJKsZbWb7GoiAKeQiOawR6+8pcp/1eE9d4kRHpUzB3liA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPJ/w+MuCtub0UQ9FEtsdqL4FGgVwmXt28sqbHTR04Q=;
 b=i0bTt7JdXiAC1f4SOVg5Q1Lvu6FtqkeW7B2p+qm5m+Pl0nVOrLZpTNKTVpPzUriNyClCuyQCaFS1w83fJ4rbb2PGt3mtTqs2MqcH5Qfp6UazkwDtkmgh69W6GwYUUB/V3SL+mfIGfYb95ipOIYrVtFW0aIF9kFLIkRDrmaOgaPI=
Received: from BN0PR04CA0172.namprd04.prod.outlook.com (2603:10b6:408:eb::27)
 by BYAPR12MB2600.namprd12.prod.outlook.com (2603:10b6:a03:69::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.24; Fri, 20 Aug
 2021 23:15:33 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::5a) by BN0PR04CA0172.outlook.office365.com
 (2603:10b6:408:eb::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Fri, 20 Aug 2021 23:15:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 23:15:33 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 20 Aug
 2021 18:15:31 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, Josip Pavic <Josip.Pavic@amd.com>, 
 Anthony Koo <Anthony.Koo@amd.com>
Subject: [PATCH 01/10] drm/amd/display: add missing ABM register offsets
Date: Fri, 20 Aug 2021 19:15:11 -0400
Message-ID: <20210820231520.1243509-1-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab8424a4-530e-459a-c8a2-08d964306949
X-MS-TrafficTypeDiagnostic: BYAPR12MB2600:
X-Microsoft-Antispam-PRVS: <BYAPR12MB26000A7F23697AC143B4B51EFBC19@BYAPR12MB2600.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WZoJ76b+jfzymm6ncV03l2n7/s1zGAOHjBqPlL+agkpY/YcXlbPiUoz8Vf02onsAeew3fNs8Of5rQt1v5rIxIrSuygKxH4P3IzMW4lf8j/0pQPqnifwdesJiatB1bbSX/+YVWQmSrL1Y81fsL0lF7EurDlgrMiwewIUDyLzSoayvOwhWbtEQx4N0lL9biVOXzSiVQO6ip3pw6EuzXcBPxK/tq52kY0Fz3DVVFyAp088/itWZrYIZmD1NqEi0IFh6m+BXnVtAh82yHSFOQsOujH2qUdk/LcVv9KYvTs3WGhxeBI6pR70/9kmgzq7CMdu7YzM/7YuqM31EklSbAGfx1Q5sb8ZIU78BHI7g+VW3xlftSl5ZANNhIkYdGDJj002jxP0reKd07Sq/DRqZ4AwGugqBiPeePEYo8/uO0JwHuU1kUJ8vUlVn/+3ODqXOTv2WADILj169VK3IxSb68BfjYAZF7/cAe/qE4N3JvHCa5Y/VHMqTUnIP1sPVeh+Ge7LZP9l5ogDneJPUsAx46fpTt/iUg1kWbkU+y2hHJQUbKmaOc0H1rSEvHTe5jZhCA1cbxiaFYBUMhw1cO9eKyRiNHdqchZCNk2+hzWJ2wiU6Xc1DImypUvR/0EhfryZ0HEvrnCANEj6EiLPzjyZhO6UdJIFPGGkFX143BMSF5XyOxGryj5ftEfehTWxdbgz/Zc9GBGKVIoSEG7gze+cAS6glvKNEJuC46Q7gtaldL5aALgTmynXMStl2mWVIEnhn1NRhQwYGedeQ0qXvDAJpemSlsg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(46966006)(36840700001)(70586007)(47076005)(5660300002)(6916009)(1076003)(426003)(70206006)(478600001)(336012)(186003)(26005)(16526019)(2616005)(4326008)(6666004)(54906003)(34020700004)(8936002)(44832011)(2906002)(82310400003)(83380400001)(36756003)(36860700001)(81166007)(356005)(316002)(82740400003)(86362001)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 23:15:33.6867 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8424a4-530e-459a-c8a2-08d964306949
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2600
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

From: Josip Pavic <Josip.Pavic@amd.com>

[Why]
Some ABM registers don't exist on DCN 3.01, so are
missing from its register offset list. However,
this list was copied to later versions of DCN that
do have these registers. As a result, they're
inaccessible from the driver on those DCN versions
even though they exist.

[How]
Add the missing ABM register offsets to DCN 3.02+

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Josip Pavic <Josip.Pavic@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.h     | 16 ++++++++++++++++
 .../drm/amd/display/dc/dcn302/dcn302_resource.c  |  2 +-
 .../drm/amd/display/dc/dcn303/dcn303_resource.c  |  2 +-
 .../drm/amd/display/dc/dcn31/dcn31_resource.c    |  2 +-
 4 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.h b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.h
index 456fadbbfac7..b699d1b2ba83 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.h
@@ -96,6 +96,22 @@
 	SRI(DC_ABM1_HGLS_REG_READ_PROGRESS, ABM, id), \
 	NBIO_SR(BIOS_SCRATCH_2)
 
+#define ABM_DCN302_REG_LIST(id)\
+	ABM_COMMON_REG_LIST_DCE_BASE(), \
+	SRI(DC_ABM1_HG_SAMPLE_RATE, ABM, id), \
+	SRI(DC_ABM1_LS_SAMPLE_RATE, ABM, id), \
+	SRI(BL1_PWM_BL_UPDATE_SAMPLE_RATE, ABM, id), \
+	SRI(DC_ABM1_HG_MISC_CTRL, ABM, id), \
+	SRI(DC_ABM1_IPCSC_COEFF_SEL, ABM, id), \
+	SRI(BL1_PWM_CURRENT_ABM_LEVEL, ABM, id), \
+	SRI(BL1_PWM_TARGET_ABM_LEVEL, ABM, id), \
+	SRI(BL1_PWM_USER_LEVEL, ABM, id), \
+	SRI(DC_ABM1_LS_MIN_MAX_PIXEL_VALUE_THRES, ABM, id), \
+	SRI(DC_ABM1_HGLS_REG_READ_PROGRESS, ABM, id), \
+	SRI(DC_ABM1_ACE_OFFSET_SLOPE_0, ABM, id), \
+	SRI(DC_ABM1_ACE_THRES_12, ABM, id), \
+	NBIO_SR(BIOS_SCRATCH_2)
+
 #define ABM_DCN30_REG_LIST(id)\
 	ABM_COMMON_REG_LIST_DCE_BASE(), \
 	SRI(DC_ABM1_HG_SAMPLE_RATE, ABM, id), \
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index 7d3ff5d44402..5cd55e8573f7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -1462,7 +1462,7 @@ static const struct dccg_mask dccg_mask = {
 };
 
 #define abm_regs(id)\
-		[id] = { ABM_DCN301_REG_LIST(id) }
+		[id] = { ABM_DCN302_REG_LIST(id) }
 
 static const struct dce_abm_registers abm_regs[] = {
 		abm_regs(0),
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
index dc7823d23ba8..4c4046eb20a3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
@@ -1390,7 +1390,7 @@ static const struct dccg_mask dccg_mask = {
 };
 
 #define abm_regs(id)\
-		[id] = { ABM_DCN301_REG_LIST(id) }
+		[id] = { ABM_DCN302_REG_LIST(id) }
 
 static const struct dce_abm_registers abm_regs[] = {
 		abm_regs(0),
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index a7702d3c75cd..3f92f27dac20 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -363,7 +363,7 @@ static const struct dce110_clk_src_mask cs_mask = {
 
 #define abm_regs(id)\
 [id] = {\
-		ABM_DCN301_REG_LIST(id)\
+		ABM_DCN302_REG_LIST(id)\
 }
 
 static const struct dce_abm_registers abm_regs[] = {
-- 
2.25.1

