Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5405DC07E8E
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:52:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0C70113961;
	Wed, 24 Apr 2024 08:52:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0EbwqdCR";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30943113961
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:52:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqFag/+Z6GxcLDKMJdlzmLqeXmlGJy9zRyYZ5CTQW3u14FzkWbou38sD4LvTrkbqelp8USM+h59N6+PNsVpcGAS9p+GBIWDwiiYfFd0Qpivj6vsuOeC0EXXkVtOXmGePslERcDO37MAUWrbRnNiyLGAYiVRw6GgqVmS7YRZycb9spZOToPow8XAZWikp1dR5oBZ7aainRyajb5Y/8lowsgMhxd6EkMxlvOg5WEhewmITCcqXB9r/aUOAkLDdj5iws0fiGs8P6Uxwkv/kv9gYInLSZy6iNXT7OW9QGoEdiQ/7+sLueFLaOukV+JDuoJcN11Ep24mN1Hf4dw0O7bASpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkkgLTa/QA/3F+KEMIsD7fSh1YvPmnEFqcKkdCEoCiA=;
 b=b7Inpw761hRf6uppPWKXYImUn6nkNdUuhZpWZfQPGb+ZvBqYvlJYU6S8bQGmaG9DAQdfrm2KfKTcfQqRjVgCBBrBMhLjoU1iH8Rm2xwiLjscxLBLA0+Bfo0lWZMHp09lejThbI9VJ/KgV97O7zQkk8BmYPIwfVIc0JM719JWYOcINf3tDl1p9To5my6AvsBKqPBzfqbR+xytLOCAnR/GcOMMSYI4jgCASh97S6/sYRPkH/zikPyJpzha6FegCQhk+fMjHKcvAIHb2aJswREfH1khBEAh92zrIaiiPzxAdpo+61C2Keu2luMy61BEUbtZTrF+hm2e/EspY6rL59PkSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkkgLTa/QA/3F+KEMIsD7fSh1YvPmnEFqcKkdCEoCiA=;
 b=0EbwqdCRC5jENq16zq6HFOmniNxuiELEdZZeSIi9Ix8TsMBtKmHFd5amStjsqNafvk8sKWFA/2bTxt8vnO0CUhFVUR2EwuCwplxvt06otc+gp6FCzdVEPuuoJc4zLk9D+TDzIpEtoufN1/lkQ9JXNoIyCeVfFFc3vQVqQGwegPg=
Received: from BN9PR03CA0394.namprd03.prod.outlook.com (2603:10b6:408:111::9)
 by CY8PR12MB7146.namprd12.prod.outlook.com (2603:10b6:930:5e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:52:12 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:111:cafe::b6) by BN9PR03CA0394.outlook.office365.com
 (2603:10b6:408:111::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 08:52:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:52:11 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:52:08 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 01:52:07 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:52:04 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>
Subject: [PATCH 18/46] drm/amd/display: Remove legacy code in DC
Date: Wed, 24 Apr 2024 16:49:03 +0800
Message-ID: <20240424084931.2656128-19-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424084931.2656128-1-Wayne.Lin@amd.com>
References: <20240424084931.2656128-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|CY8PR12MB7146:EE_
X-MS-Office365-Filtering-Correlation-Id: 4efa805a-50e5-4cda-4f27-08dc643bd4e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L0z71+ccIaOARy6vrjppSPEm+fd//9lF1a93Vs0ZVe8e8gTel7lz/KqgIWHR?=
 =?us-ascii?Q?cXdhA+QI6mRO9rhMIyp+m/wimufSaAdSpiwRMjvyjzxR3E/F0/5K3vZOliFJ?=
 =?us-ascii?Q?dNeEbOvknQNAolg4zPmaWuFemUw+sop2tEPQMjoOKwoV9aH9tGeAfD/HAY58?=
 =?us-ascii?Q?1vBW3HklzKMLJ2bzYRbYuwhZms8XPRT1e/W4TQrONfA3xT1PaAqbz/Ue1mkQ?=
 =?us-ascii?Q?hjS705VCr52Aa+W8oxAr0kc3mL5RnUaqYH4BO/ZxRgmQIzHsENGAlEX61OjP?=
 =?us-ascii?Q?odijOh59hGUUKxSn27UcC/Hu0wOHOqbKBAe40SP8jNGsb8yZ7GCO3E0NAbzd?=
 =?us-ascii?Q?U19aFhGvWNbiBcaJYYEKxdFJM1JsZLHCryFljHXzp+kY1mfd8XTZtU7/+4jx?=
 =?us-ascii?Q?McS8+rIxYTwVnCxldlDpE0IFQ2UPee9ZTtvZzsuWyxN5ZrtS8rOJLwvpawnp?=
 =?us-ascii?Q?HuKzp9sIPe/rIjTVDUEs24mDfylFKRn4bBjEDuq1xeR3n0V6HeCuz/5ZvM7H?=
 =?us-ascii?Q?VNQDEav5nAvP012xFme4nG+lsWq3Ux0MQI9AxrKXCCV3BbcLJZ5TVb8ESgJ5?=
 =?us-ascii?Q?JAL85l81DMJj4oruPFzxn/1tec9VWwSXajOmKg9LyNpH66Bhpa+K6/Illtma?=
 =?us-ascii?Q?dwb0Pp86n2EwEIeugaQDzWT/CUcouU5d0m/QeuYd/ysIfEzZkt+JGPLBiSXE?=
 =?us-ascii?Q?Kngg1fMyivCDCJqfQFlbjAJUep8w9JTkgNT0FmhgnfQ1b/C1KksOGnYSjjWM?=
 =?us-ascii?Q?lvJOI7+AIpSoJqfLhg5L4iGamjiMsENT/kYw25suN6Cezuj2GYHrLE3/G8h+?=
 =?us-ascii?Q?QRMohq0iNWfoHaToy5kne24tx+EiRQT11EPKdScZvQTd3RDpPKO1OXZQRC3d?=
 =?us-ascii?Q?Xh24cteXs8rSAOi36Eadhz7soaIU9nP13ScNM1IM+w+c2KoWfqmU7J5SDGgO?=
 =?us-ascii?Q?4SgCBHs+BoNSEm5yq7OJ/4gy3Tcy7TpvWk41d3u9t0QJX6EycjuLd+OCdjqp?=
 =?us-ascii?Q?jHIyx/goDVqh7ox+BCSjo5IlrwlW9JUEFKKS4KKV3err5Rg5FBif415o1ESO?=
 =?us-ascii?Q?QEtF7i2r5x2wSeRQ6WE4HohZeBSYc9wadF2CO7FkGjBqmoM65nAlQkTjuATi?=
 =?us-ascii?Q?JZQqW+BarqgMd3UyB7cPtnVFezxGJ/6bM1ZsAbNAQgQ8CKVNPBqZ1fp7rjN1?=
 =?us-ascii?Q?Y9RhuMUfBjAbn7jWF23jAMyvGrAPrRB+KD9sY+96GcrvYw11BlkBJAlOeSKZ?=
 =?us-ascii?Q?eJua6yqbCeLKMUwfQuysMQvn7olKnKtDSHWf5JZ92vDVbzPjQ9a8lHofK4gn?=
 =?us-ascii?Q?XjAdIgHOheDcufYhRPdaqlkKoKSxYWLJRWUY3OcQBgmEAm1c+vG2R6BA1TCD?=
 =?us-ascii?Q?XUOemBnhfWFh/1WY/RTOCt65yIX1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:52:11.6657 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4efa805a-50e5-4cda-4f27-08dc643bd4e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7146
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

This commit just remove some trivial legacy code in some of the DC
files.

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c | 12 ------------
 drivers/gpu/drm/amd/display/dc/hwss/Makefile         |  6 ------
 .../gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h  |  2 +-
 .../gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c |  3 ---
 drivers/gpu/drm/amd/display/dc/os_types.h            |  2 --
 5 files changed, 1 insertion(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
index bfc042209007..17a21bcbde17 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
@@ -762,23 +762,11 @@ void dcn316_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 				break;
 			}
 		}
-		// Ported from DCN315
-		if (clk_table->num_entries == 1) {
-			/*smu gives one DPM level, let's take the highest one*/
-			closest_clk_lvl = dcn3_16_soc.num_states - 1;
-		}
 
 		s[i].state = i;
 
 		/* Clocks dependent on voltage level. */
 		s[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
-		if (clk_table->num_entries == 1 &&
-		    s[i].dcfclk_mhz <
-		    dcn3_16_soc.clock_limits[closest_clk_lvl].dcfclk_mhz) {
-			/*SMU fix not released yet*/
-			s[i].dcfclk_mhz =
-				dcn3_16_soc.clock_limits[closest_clk_lvl].dcfclk_mhz;
-		}
 		s[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
 		s[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
 		s[i].dram_speed_mts = clk_table->entries[i].memclk_mhz *
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/Makefile b/drivers/gpu/drm/amd/display/dc/hwss/Makefile
index ba55050be161..40ecebea1ba0 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/hwss/Makefile
@@ -110,10 +110,6 @@ AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCN21)
 
 ###############################################################################
 
-###############################################################################
-
-###############################################################################
-
 HWSS_DCN30 = dcn30_hwseq.o dcn30_init.o
 
 AMD_DAL_HWSS_DCN30 = $(addprefix $(AMDDALPATH)/dc/hwss/dcn30/,$(HWSS_DCN30))
@@ -188,8 +184,6 @@ AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCN351)
 
 ###############################################################################
 
-###############################################################################
-
 HWSS_DCN401 = dcn401_hwseq.o dcn401_init.o
 
 AMD_DAL_HWSS_DCN401 = $(addprefix $(AMDDALPATH)/dc/hwss/dcn401/,$(HWSS_DCN401))
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h
index 76b16839486a..6a153e7ce910 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h
@@ -27,7 +27,7 @@
 #define __DC_HWSS_DCN30_H__
 
 #include "hw_sequencer_private.h"
-#include "dcn20/dcn20_hwseq.h"
+
 struct dc;
 
 void dcn30_init_hw(struct dc *dc);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c
index 6477009ce065..0e5c037e82a6 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c
@@ -53,9 +53,6 @@ static const struct hw_sequencer_funcs dcn301_funcs = {
 	.enable_stream = dcn20_enable_stream,
 	.disable_stream = dce110_disable_stream,
 	.unblank_stream = dcn20_unblank_stream,
-#ifdef FREESYNC_POWER_OPTIMIZE
-	.are_streams_coarse_grain_aligned = dcn20_are_streams_coarse_grain_aligned,
-#endif
 	.blank_stream = dce110_blank_stream,
 	.enable_audio_stream = dce110_enable_audio_stream,
 	.disable_audio_stream = dce110_disable_audio_stream,
diff --git a/drivers/gpu/drm/amd/display/dc/os_types.h b/drivers/gpu/drm/amd/display/dc/os_types.h
index 6c4578d347af..f2ba76c1e0c0 100644
--- a/drivers/gpu/drm/amd/display/dc/os_types.h
+++ b/drivers/gpu/drm/amd/display/dc/os_types.h
@@ -29,8 +29,6 @@
 
 #include <linux/slab.h>
 #include <linux/kgdb.h>
-#include <linux/kref.h>
-#include <linux/types.h>
 #include <linux/delay.h>
 #include <linux/mm.h>
 
-- 
2.37.3

