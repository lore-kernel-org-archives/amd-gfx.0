Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A092C54EE9
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 18:13:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A369510E81A;
	Wed,  7 Sep 2022 18:12:54 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EDE110E469
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 18:12:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+z0webs+HhmjGhEsOB7BjMkrLVXwEkFUkb49+GNlugkwv7/BYPyJ+MxkFObZXNNziy4rrleqsg0iSGcJZSjXJ+ZvlmNk9V1V2NNhRBt3BOpV0qucnatQDa3B1xtZLbLSP9/hcfRmPnRMMsXeOud4ClMfAbeb8NZ9M69qQjAOdZ8+ntbQYSwBoGFd9xiNRvREfth6vf5LY0JSu5KN20nNo7hC3wNv4/WLbP1/HMGtFLFBsUDg5LNAO/GYYzcwaqip3NglMCEOdJoIX9auTZxAny+Rvwwp58MXlTADSznZoifTWrXEqHyAlbWltDg7J2YPod9OMeBuo53bIL09Dqq7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYo7EPVP9m9giSxQwMpzPVvaxb5iap1oZDVatl2wJNg=;
 b=Osp6heQBV2NhTB4JfPTV+HrIHYujHMhpZX1x73VStXmiBreX6RTwzBuLMEy50RU9ZFlqcHNaAUatQcyT8qzq4asMA5cu5FzNZ1F+eUDmpCMzfEPEp0KOwBtllxZOtiwECiokR07u3QLC4GdvseKI1MT+CdkvGPJsYm44fbVcoNgUJcjbh7Hy7YI/9JlyItfyncT8URQI17pB/9lDr0j4JteKJcIdy4TT8ff/wkc7Lk37j7fosBn8vyfSyveRN3GnOgH2lmT5a2T04PcAZrNpBKDjnA8p0YSzBMlUvLjcvj1Vzp3T7g2KrVbkbfVURUuys0eoLNWpQSMzJHi0/2YFxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYo7EPVP9m9giSxQwMpzPVvaxb5iap1oZDVatl2wJNg=;
 b=iKn4fwis4Fk2fmSR9VhZkIqJ/gDag5czi4zuo8YmQEGnIz1oGw2etSg0Ph8d94VxO2fCIcnbc8te738PRg1F+QZMhxrpCy+BiLC9aoyqshKbo9XsKwIe0oG0+huCiUv8p6o4YthLbiak6FO2vk4u4/LTqtcs3MKJKgQzh6Gsa4k=
Received: from DS7PR03CA0212.namprd03.prod.outlook.com (2603:10b6:5:3ba::7) by
 MN0PR12MB6341.namprd12.prod.outlook.com (2603:10b6:208:3c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Wed, 7 Sep
 2022 18:12:24 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::75) by DS7PR03CA0212.outlook.office365.com
 (2603:10b6:5:3ba::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17 via Frontend
 Transport; Wed, 7 Sep 2022 18:12:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 18:12:24 +0000
Received: from promo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 13:12:22 -0500
From: Pavle Kotarac <pavle.kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/21] drm/amd/display: Hook up DCN314 specific dml
 implementation
Date: Wed, 7 Sep 2022 14:11:47 -0400
Message-ID: <20220907181200.54726-8-pavle.kotarac@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907181200.54726-1-pavle.kotarac@amd.com>
References: <20220907181200.54726-1-pavle.kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT051:EE_|MN0PR12MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: 67709c43-3a5e-45c6-7197-08da90fc8404
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wRb/gC/EDiout7WXhpLCCZe06sJohQv9kYM5Ij6RvkEidN6ibdOUgWv3mu5f9goiBrn/o4XA1b12of1i51R05RwsnS+E+GCVXUc7XuOnsmC8r4bAf/u9Gbo7ktkNQiqLzblT2Bu+qBLpjDcLZqcajirorfQjVkVakGPyO0v/4aoQYh3Nv5+e2BhHmMaW12usnCs7Ta+5puPZJquxk2hIc6nPrGkl4lMJqTD5RV0aPdKj9xYtesTsUllXeEdn6/NQjTeb5TDyzYsJwYoVYnWr83hay/iSGI+WVwouhOes5Lsm9HjeRxbbSe/4J/t+1mB4fzO84bZDftFEpIK3d21jdimZykGl6+1vkk+wgBx/jnoKXdik2T35eNYubSua36jFFSIty5ekNwUp9LnI2gNNPHaoD8yQFtuwqa3G5k1806CEs9Q16xtR7jvZ0YdWJxYsScPMuVhwYHwizTAfcbeTrc6o6fswYSvBT7LqA7jqXT+HB5WsmUO5WnqH9OlfuO23tTW3dEycYFrMVKfmG4QE3Mb6zgfy5aMGnYQFMyH8ltJKLCHBroqif7dsXTc8d2cFbnZVVvQRoKQRb2a0RHzdz6yky4XlRdlw2BA9Amm4unAZCyxI6vAYHLGviOIGmyWg+U4sZ+LMEkxfAjnyX0pemh9ptVitBkeZGUJYEDAO+N6Q7wrC9Sd3UAvqFAhMRPMMLwdTiFvrR/9k6e9DvB7qYzuSL6RMPe9w7u+Yj+PPWAkD7s+1kfpuWjVoKUyKva+8KvLfpHSypcMUESLUNrJVPKEjFKLv1C0G556+so6D/4UmcUxCcf/Awq3ynCeGPTg4JeZlkJr+q9XFoD3pJa+JEEYUn7sSvHB9y9eJ2CiVcIk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(346002)(136003)(376002)(46966006)(36840700001)(40470700004)(70586007)(70206006)(478600001)(316002)(6916009)(54906003)(356005)(36756003)(82740400003)(86362001)(2906002)(81166007)(426003)(47076005)(5660300002)(36860700001)(186003)(6666004)(1076003)(41300700001)(26005)(2616005)(16526019)(8676002)(7696005)(40480700001)(82310400005)(336012)(44832011)(40460700003)(4326008)(8936002)(83380400001)(52103002)(158003001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 18:12:24.6451 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67709c43-3a5e-45c6-7197-08da90fc8404
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6341
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
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why & How]
Add support for the DML314 functions and hook up DCN314 to use them.

This has some necessary additions for calculating Max VSTARTUP for
future features, but there's also some changes that we have to make
for pixel format/swizzle support.

That will come in a following patch to make this transition easier to
bisect.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c   |  2 +-
 .../gpu/drm/amd/display/dc/dml/display_mode_lib.c    | 12 ++++++++++++
 .../gpu/drm/amd/display/dc/dml/display_mode_lib.h    |  1 +
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index 34a5d0f87b5f..fc5529fa51b3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -262,7 +262,7 @@ void dcn314_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_p
 	}
 
 	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment))
-		dml_init_instance(&dc->dml, &dcn3_14_soc, &dcn3_14_ip, DML_PROJECT_DCN31);
+		dml_init_instance(&dc->dml, &dcn3_14_soc, &dcn3_14_ip, DML_PROJECT_DCN314);
 	else
 		dml_init_instance(&dc->dml, &dcn3_14_soc, &dcn3_14_ip, DML_PROJECT_DCN31_FPGA);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.c
index 5d27ff0ebb5f..f5400eda07a5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.c
@@ -35,6 +35,8 @@
 #include "dcn30/display_rq_dlg_calc_30.h"
 #include "dcn31/display_mode_vba_31.h"
 #include "dcn31/display_rq_dlg_calc_31.h"
+#include "dcn314/display_mode_vba_314.h"
+#include "dcn314/display_rq_dlg_calc_314.h"
 #include "dcn32/display_mode_vba_32.h"
 #include "dcn32/display_rq_dlg_calc_32.h"
 #include "dml_logger.h"
@@ -74,6 +76,13 @@ const struct dml_funcs dml31_funcs = {
 	.rq_dlg_get_rq_reg = dml31_rq_dlg_get_rq_reg
 };
 
+const struct dml_funcs dml314_funcs = {
+	.validate = dml314_ModeSupportAndSystemConfigurationFull,
+	.recalculate = dml314_recalculate,
+	.rq_dlg_get_dlg_reg = dml314_rq_dlg_get_dlg_reg,
+	.rq_dlg_get_rq_reg = dml314_rq_dlg_get_rq_reg
+};
+
 const struct dml_funcs dml32_funcs = {
 	.validate = dml32_ModeSupportAndSystemConfigurationFull,
     .recalculate = dml32_recalculate,
@@ -107,6 +116,9 @@ void dml_init_instance(struct display_mode_lib *lib,
 	case DML_PROJECT_DCN31_FPGA:
 		lib->funcs = dml31_funcs;
 		break;
+	case DML_PROJECT_DCN314:
+		lib->funcs = dml314_funcs;
+		break;
 	case DML_PROJECT_DCN32:
 		lib->funcs = dml32_funcs;
 		break;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.h
index 2bdd6ed22611..b1878a1440e2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.h
@@ -41,6 +41,7 @@ enum dml_project {
 	DML_PROJECT_DCN30,
 	DML_PROJECT_DCN31,
 	DML_PROJECT_DCN31_FPGA,
+	DML_PROJECT_DCN314,
 	DML_PROJECT_DCN32,
 };
 
-- 
2.34.1

