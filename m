Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31072C55179
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B939022283
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="t5KrTtot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B939022283
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 215796EDC7;
	Wed, 21 Oct 2020 14:23:22 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B67F6EDB4
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 14:23:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWA/GzA4Xv/LdjLIp4+ulZiRG4LIw4aFL/6Lc+EweIcYuMZ1eBLehByiVgkuKswYlWjyBOj2Ofmo6QfDrMa5Qs1k3KhXA/Ht/oUChXdWmmA6o4ZMLiTcBFPsju7s6D3L/ETPsMlyc0XedYekc11vzjVAr7T2EIs6hRkrfEB6Bc7GyEnDPQ/4nn2PK1Ft3HUgpW7T2IXBe9Kg2Wme3rXvhZCDd51w8/UGyemKvb4q8hyZ54cBVkPhVmsTQSeoHoepLvfE7i3TPNhoj/cr5tlDenOfhpxHgWp2D1QhzUKZpKcaXKPYlbBR8WfiKAqUnZVSMcBrxAAv/WQoJfsm1WGTWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nn+xqLRPpTDI3S/vtGrkSHQ6eiqduhAJmgT+9N9LmoA=;
 b=VhdxNfKLZpzl+KfvRCLaJCXu4qWQs4Sb3VFoDRV6tg2pAtuOnzdsJJZwkOJEp/LPreqLSrHud1nvYALjUN6RBzgCxg431SZPmEhNNvWtqVVVLBC0SkKzRcMqqOHuIsddsozAFr/Xq55xKJ5Bd45YyFYZseDoaONxkAR9YMxdKUNuZ4Qls7s91Akvxao2T1mGsfoTfnSWCJOndBIWvD03VoNTkA0FSsD+1JCD+o/Oed30YAqY1u8TlIeKxKC+xpTxm+wJ0IfpuSPEJzfr/e4Q2kI3dMARtaw3vTcVXNGZt8kUDdt/+dzVgYR3qwq1ehjkuvB2h4aOU3xargcOzuKIlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nn+xqLRPpTDI3S/vtGrkSHQ6eiqduhAJmgT+9N9LmoA=;
 b=t5KrTtotAufaRCgz9eXITFNSQ33NuGhBi4Pb+VeAI1Ffh3QKjIjXlTeG+bt19Yk9f9MlVaWye4Lz9PB7WP2TEve0NDTjue+RPnGmHevAHyBAbQY43D1eZMOPknpVJDVf2USGUFWA5HQ67xnVsNqeV3PVJSmtD0yWR+jIKqPZCA4=
Received: from DM5PR21CA0005.namprd21.prod.outlook.com (2603:10b6:3:ac::15) by
 MW2PR12MB2378.namprd12.prod.outlook.com (2603:10b6:907:f::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.22; Wed, 21 Oct 2020 14:23:17 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ac:cafe::37) by DM5PR21CA0005.outlook.office365.com
 (2603:10b6:3:ac::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.17 via Frontend
 Transport; Wed, 21 Oct 2020 14:23:16 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:23:16 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:15 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:15 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 09:23:14 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/33] drm/amd/display: Refactor ABM_MASK_SH_LIST_DCN301 naming
Date: Wed, 21 Oct 2020 10:22:38 -0400
Message-ID: <20201021142257.190969-15-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021142257.190969-1-aurabindo.pillai@amd.com>
References: <20201021142257.190969-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0bf4d2f-6117-45e3-423f-08d875ccda4b
X-MS-TrafficTypeDiagnostic: MW2PR12MB2378:
X-Microsoft-Antispam-PRVS: <MW2PR12MB2378EA33D1F5FBBE34441A388B1C0@MW2PR12MB2378.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +XKnowoRaP0Jb4RXEnHXOZQHOpHUfJy0G/rp6alA7+NxwFgT5ayjS65dKnm+xIWEblMR/3ko7QAAa1saqwGRpCJVQJ9dihJp55iCzrixjzvGWJwRlUXlHMLheseQTV4seA7ynjnVOQx3QYAJh25z1a3jjByl+S7Rrn7dUZtPdxFjkc0y4oBPv1RRO/PEAsqo38z9194/mVKAbLrt2nvGx5T1wJUrB2GI3I9bkJIgVe5Bp1BW32ugid00GVh6KvVAxz0hP7U3Va3t4Fwxihf0U4aNyyPXJEDH92mTHnUSBBlFTlxZOh+nI2MReqX9QEWITreM4cDd9/l2qV3MqcQResL3yubRkv/wEBPKVn5Nlxht+WE7PQgNmSxTzyur+2rBml3d6Wba4CEv16a27uzdYg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(396003)(376002)(46966005)(8936002)(7696005)(44832011)(4326008)(5660300002)(186003)(70206006)(83380400001)(82310400003)(70586007)(1076003)(8676002)(2616005)(336012)(6916009)(86362001)(426003)(81166007)(478600001)(2906002)(316002)(36756003)(82740400003)(356005)(6666004)(26005)(47076004)(54906003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:23:16.8139 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0bf4d2f-6117-45e3-423f-08d875ccda4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2378
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Roman Li <roman.li@amd.com>,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <roman.li@amd.com>

[Why]
All DCN3x resources share ABM_MASK_SH_LIST_DCN301 definition.
The naming is misleading since it looks like DCN30 code
depends on next version DCN301, which in fact is vice-versa.

[How]
Refactor the naming to ABM_MASK_SH_LIST_DCN30.

Signed-off-by: Roman Li <roman.li@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.h          | 4 ++--
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.h b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.h
index 829cd9a93ba9..dee343f8beb0 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.h
@@ -189,8 +189,8 @@
 
 #define ABM_MASK_SH_LIST_DCN20(mask_sh) ABM_MASK_SH_LIST_DCE110(mask_sh)
 
-#if defined(CONFIG_DRM_AMD_DC_DCN3_0) || defined(CONFIG_DRM_AMD_DC_DCN3_01)
-#define ABM_MASK_SH_LIST_DCN301(mask_sh) ABM_MASK_SH_LIST_DCN10(mask_sh)
+#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
+#define ABM_MASK_SH_LIST_DCN30(mask_sh) ABM_MASK_SH_LIST_DCN10(mask_sh)
 #endif
 
 #define ABM_REG_FIELD_LIST(type) \
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index ec04d55d87f4..f227f4653a71 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -355,11 +355,11 @@ static const struct dce_abm_registers abm_regs[] = {
 };
 
 static const struct dce_abm_shift abm_shift = {
-		ABM_MASK_SH_LIST_DCN301(__SHIFT)
+		ABM_MASK_SH_LIST_DCN30(__SHIFT)
 };
 
 static const struct dce_abm_mask abm_mask = {
-		ABM_MASK_SH_LIST_DCN301(_MASK)
+		ABM_MASK_SH_LIST_DCN30(_MASK)
 };
 
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
