Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DBB4C19F21
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jul 2022 04:52:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E52D9A598;
	Wed, 27 Jul 2022 04:52:00 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2070.outbound.protection.outlook.com [40.107.101.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53A5DAA1A5
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jul 2022 04:51:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmAEwdUZXzVwI3m0hj6iMphSZsatnSwwV3g8g+lR+mTF1ei2QwG53oFTnZTPEDX9WEtfys/wAVs5eyJzZR0t9kx8+45eWfVmAdpc63ifa5BnkasZw86USR7LwB8MZ4TlQkYuFXBfdNu1MSxiEJb98tgyZhkfTCE7W6s2Nj0L9ZoOnUPWtJVEMSwDxuF0n27PxTmZSgnIBjh/ht5HaEqPvq2wl8l4XhDrR5EU0i4u1vZeCgQWaoCoMr86cH3cyiL9GD4Tm7mdY3tFTeV/r1bSlV+4Ch+rSA3kMdk4+XqZTyBA41awQ1WEfEBYh7rIA9ViLlP7ML9p4mZcsGu2VTR03g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDRWS5CRLRPcMNfKLwjoWy9zJla0Wds6Dh8QhjR3dwE=;
 b=j45iTEYFQM10vRRkE/TFWpItgfd2Ogmnt57r59rVyqs5PDhq/8VHIq0v7wglFt1RNuTIfHT6Q2J8I9QBqGvG0QaJbZsACdbZcEGkC+g1meiLDsCJpwkv+Q2Ma+8oXXwkZEtSr/WDxd7Q2wFtsfEprxTDH0B9t8HGInv2soU9dbEurrBA41cPvB3YTg3TBEAf2Gm+GF+2eHTfOaI8eJuP+MdXSQpNPjfm0mcHRvSsBiKReBcXZu/voxH2HTYomNDOG1snv5e/LbuOf3Wza/QkL2CYAUTWOo+I9XF6eOqPZvYO37OQxtSlXs1YSCHJ7AlIOeRkXmnv9u0jLJaGbtF3bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDRWS5CRLRPcMNfKLwjoWy9zJla0Wds6Dh8QhjR3dwE=;
 b=T0S69gunzoa38KNunTwwCeUP1C/6f73v6FrPyXtUXJLyvHgAJPhmNLrnF8tuQFuSz6AO07DI5RhifvGCDARJd1Pyd6NxlJ2uE79D685tQYNGPaAahCvLz+qHLU5m60+bKkKr1L3d7cRv4TF/kx4av2vnvdAWfSgw8D4hqSe2iQQ=
Received: from DM6PR02CA0092.namprd02.prod.outlook.com (2603:10b6:5:1f4::33)
 by DM6PR12MB4138.namprd12.prod.outlook.com (2603:10b6:5:220::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Wed, 27 Jul
 2022 04:51:55 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::7b) by DM6PR02CA0092.outlook.office365.com
 (2603:10b6:5:1f4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24 via Frontend
 Transport; Wed, 27 Jul 2022 04:51:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Wed, 27 Jul 2022 04:51:54 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 26 Jul
 2022 23:51:52 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/pm: update driver if header for SMU 13.0.0
Date: Wed, 27 Jul 2022 12:51:33 +0800
Message-ID: <20220727045134.499712-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08fd3016-e901-442b-1da9-08da6f8bbab8
X-MS-TrafficTypeDiagnostic: DM6PR12MB4138:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jGqgi9J5ppzxj8Kc8fL4GPnKcMLTjXqxVyYeCuoUWGX/GvE2ar73CMTjEt3EkAZRg18qxrCDNqLgScvD9e5K3WeR1Qi+GmAEAsK5jaiGyLKhCCwmYhmVefCqP/fETKB0He2HbSEwSco1yzDjAh2HkeMOUTn7v5z967ghSbA4MetEP4KDt3jDyOcqJ3pE0qF4JiYY5Gg61tSma0ZhD3HRn4/OdrCWRyrGaTXdyPVT84NCbkkSYyRIXNrkQMAHEh9Wb0bh7FDiuloYhSpJC60TutR8TepjIdza0sbEhMgxJH4oHxebLrXWrDzRGm31UyAC5VqBlhy6NmL0kf2gzwcWBJJEF8XwLp9u1RUymobC38Wgli7T6DVqLt37XVvI1qxDKI7X3/oT1MNceqcjCvAvoHZOr+bB7zNSOwyzayl0O2wTTmyVZ5z/qYVjgGJPipUhVJospTzLx+HVooeBQTUdtpMUvZJMGczZGb7ZnSPzlRuYNPeVyU+4PGIWztvFmlrvkFpm5r+DMMwlZvOkkS0/vensT82wlmuWUuxAwRX/P6r/8we6KMNSy35DKvJkdakWXVHRkGNt5AewW+fvsCK+lGIZSf+2dJarEhqESJCknAiuFvRGMpqbtBWq0zxa26aFeiXq2XWtQ1ZqM/GaHM+kGf9CmMagfu7gQLN6m5iP4bWTLRtgwrSHGz/YAzyttlX+y0w+VEFsnEm0eH6bwVecyCF/sqfPZBG8EIxCSkkVyVI+ASh4shdY3p51hVqX0N5b277ehWzkiR2g4qvPwFm5n/Di0tXVt4VY6ETpSH0N3cpmw3SW+UPoBM7hOy/FVkpE+w41+0cLm+bK313edyOtpQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(136003)(39860400002)(376002)(36840700001)(40470700004)(46966006)(8676002)(6666004)(36860700001)(70206006)(2906002)(7696005)(4326008)(70586007)(86362001)(82740400003)(26005)(41300700001)(356005)(5660300002)(40480700001)(81166007)(8936002)(44832011)(478600001)(83380400001)(2616005)(426003)(40460700003)(316002)(1076003)(36756003)(336012)(47076005)(82310400005)(54906003)(16526019)(186003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 04:51:54.9018 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08fd3016-e901-442b-1da9-08da6f8bbab8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4138
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

And get the version bumped to 0x2C to match the latest PMFW.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Change-Id: Ie4bc8fa0831ae6d1735c2dca27331ff6f6229e30
---
 .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h  | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h                    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
index 2b672d102c96..78620b0bd279 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
@@ -97,7 +97,7 @@
 #define FEATURE_MEM_TEMP_READ_BIT             47
 #define FEATURE_ATHUB_MMHUB_PG_BIT            48
 #define FEATURE_SOC_PCC_BIT                   49
-#define FEATURE_SPARE_50_BIT                  50
+#define FEATURE_EDC_PWRBRK_BIT                50
 #define FEATURE_SPARE_51_BIT                  51
 #define FEATURE_SPARE_52_BIT                  52
 #define FEATURE_SPARE_53_BIT                  53
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 72b553618116..c02e5e576728 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -30,7 +30,7 @@
 #define SMU13_DRIVER_IF_VERSION_ALDE 0x08
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_4 0x04
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_5 0x04
-#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0 0x2B
+#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0 0x2C
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_7 0x2C
 
 #define SMU13_MODE1_RESET_WAIT_TIME_IN_MS 500  //500ms
-- 
2.29.0

