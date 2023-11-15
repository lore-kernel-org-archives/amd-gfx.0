Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B5BC5AE4A
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Nov 2023 19:44:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66EDC10E57B;
	Wed, 15 Nov 2023 19:44:29 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A589A10E579
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Nov 2023 19:44:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cy/Vi8moSSquQz8/8xmcE1O3hx0TfX3q+t8D9YnBj+d5fVq8269zq1KKSbiT6+nffmbBQL7gjVSNyIuBheOBn9J32Wln9ksNj3xv5c48SbhCnM0MVsDqQ9RTwQc2GJGBPa9JqaJsM+rYmq27LuXr2utcglulNleZFdFs3PGKAcNZ62FaDL5wzPKZ/yHXBSrunXsG/e9wcFcLzfULjqNLiyS4/bzREVpTieRSB6wFKNNTA6jBpZyd4uTuFnAzFhj5+mfge6sMKZyO8Py/kettTLWwu28uJ1x8+ee68Jc+602hQXswccttXSzcB5OzkC598UAm+21oJOPIyy9WkQZczQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41tWPEkCdKllUBVGDI1FAosLgRO5PHqEJNvdm5KVBl8=;
 b=RPP4UlxQXXHhEq5hrqlE0MhnvxMkSvdc2rj/T7s0Y5Gi4UQGQs/vlg75tLp0Pfig8yMJjTqta/yI2qBf2SS3QSVs/D1A0Fbv9nZa6NTeQkVzKn7OWXVMeRERtMqr1QoES01+a1bMvNqKnJAWBQZjps4RPD4Sc6S11g6tXQepnGz/jbBhHZBUL1CcpUeaOeZ84gkBYr67nq6wsmOuMVl+aJWiciSpDB1rQN0B6EzEFXUH5lxx1Ggj2I3ftWN2vljvUMempx6Kr+sFUIghgCFE+HEKTSmiIeJZUhIurd/Z9Yl2b1PELVy/gZRixuo7g98j/ZnWoZJntXvKt/uev7Kqew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41tWPEkCdKllUBVGDI1FAosLgRO5PHqEJNvdm5KVBl8=;
 b=J3khrYt0m8Hhx7NxseEe+w6fO2QwyQO/BvkmfCdetcIsuaS3oNyHSypkq6Z2XxIWZYA6OHbfRDSGXbQh0B21nA822MyH1hD2sz2VTXY3ulVtrx1FaN1G0SsdLR0olohlB7ZEm0Gf+zLeOy08H+I37cF7vseF9zSwjw/Dl/mfY2Y=
Received: from BL1PR13CA0267.namprd13.prod.outlook.com (2603:10b6:208:2ba::32)
 by CY8PR12MB8243.namprd12.prod.outlook.com (2603:10b6:930:78::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Wed, 15 Nov
 2023 19:44:24 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::84) by BL1PR13CA0267.outlook.office365.com
 (2603:10b6:208:2ba::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.8 via Frontend
 Transport; Wed, 15 Nov 2023 19:44:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 19:44:23 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 13:44:22 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/35] drm/amd/display: Refactor DSC into component folder
Date: Wed, 15 Nov 2023 14:40:26 -0500
Message-ID: <20231115194332.39469-14-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115194332.39469-1-hamza.mahfooz@amd.com>
References: <20231115194332.39469-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|CY8PR12MB8243:EE_
X-MS-Office365-Filtering-Correlation-Id: 2730d368-d487-4ac5-5d15-08dbe61344f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J9ZjDtcCLADk/M2Zb2XeqCmvBJbLpRa4vqx7MXPWvn+Zw2LkxXQ6AU9y6rUAmm7f5KJoI00fkEjfLMf0NmYeYZFy5zIOxqh81CqtvICK1fLagHpqAHFEhsEBRMmPqxJwvSZ7fsCgktUOGWNTVpyFjHQPDq/wYftX1sdj2uM7jXCfUBiBZu6E7JUX4WP5qPMWxIqLapHEPVTPHhlUgNCQ64Z+XP/N8MLELlXFnAJ4eW7xlrcVM/SbanF4T1ZZhf7wYnUXB8DlV27W+9E1UFvEUiI1zdAlFGc2ioUoT/JuyzBBvTK+BNWHJDG1Pn0q0X18EhITesVdeRjUoK+xHi4tLdcLWFbDgZyBtWRIIcr4llD9kTEPUYC4+q/D3+FHYhuEVyK0s2sSwOKK9WCTxZP9uQxB+h+wWgmsX12TlNvBhEppczBXnCM4ux1SB7WDvCNC9YjHVRFLucY6+rIF22oFBac8IQepG0bH2D52baKKrka8QBkvIwKfivDkIE0hFFTePcvf7Mrol/AT//V3VTfxbjjqFFkufmdoWHiCsTBpmvQ6sPxSkknmBU0JF7zGUWR0t6PjfP4fnzbR5TIs5ZZP8iC4mF0oG5uYfu/sTPWC6se7wq1Wx31kQqPiN6h5z2Iesr2ipxokFTXZzDSCFf5nswcTAjFuMnUjyNYm31oia47S/F8pKsWG+nw7qGLeV5rOPzchk1wRfdE3ZoWDmQWZFthmIgkKTFzIDe4Hxl2qV1ssYdOIrJlETc9dBaKi9EPe4Vg+EXYFas8q35n/X9QnpSvb11Y1RT+j8B4Uu8x8CvYwwaUF+9YMn/14D8aBFTVZ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799009)(36840700001)(40470700004)(46966006)(356005)(40480700001)(81166007)(83380400001)(36860700001)(54906003)(8936002)(8676002)(4326008)(70586007)(70206006)(336012)(426003)(36756003)(41300700001)(47076005)(1076003)(16526019)(26005)(2616005)(478600001)(2906002)(40460700003)(44832011)(82740400003)(6916009)(316002)(5660300002)(86362001)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 19:44:23.7555 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2730d368-d487-4ac5-5d15-08dbe61344f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8243
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Bhuvana Chandra Pinninti <bhuvanachandra.pinninti@amd.com>, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Bhuvana Chandra Pinninti <bhuvanachandra.pinninti@amd.com>

[why]

To refactor DSC and make DSC files unit testable.

[how]

moved the dcnxx_dsc.c and .h files
into corresponding dcn folders inside
the dsc and cleared the linkage errors.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Bhuvana Chandra Pinninti <bhuvanachandra.pinninti@amd.com>
---
 drivers/gpu/drm/amd/display/Makefile          |  1 +
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile |  2 --
 drivers/gpu/drm/amd/display/dc/dcn35/Makefile |  2 +-
 drivers/gpu/drm/amd/display/dc/dsc/Makefile   | 26 +++++++++++++++++++
 .../display/dc/{ => dsc}/dcn20/dcn20_dsc.c    |  0
 .../display/dc/{ => dsc}/dcn20/dcn20_dsc.h    |  0
 .../display/dc/{ => dsc}/dcn35/dcn35_dsc.c    |  0
 .../display/dc/{ => dsc}/dcn35/dcn35_dsc.h    |  0
 .../drm/amd/display/dc/{inc/hw => dsc}/dsc.h  |  0
 9 files changed, 28 insertions(+), 3 deletions(-)
 rename drivers/gpu/drm/amd/display/dc/{ => dsc}/dcn20/dcn20_dsc.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dsc}/dcn20/dcn20_dsc.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dsc}/dcn35/dcn35_dsc.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dsc}/dcn35/dcn35_dsc.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{inc/hw => dsc}/dsc.h (100%)

diff --git a/drivers/gpu/drm/amd/display/Makefile b/drivers/gpu/drm/amd/display/Makefile
index 71192fc81a20..7b0959da2cac 100644
--- a/drivers/gpu/drm/amd/display/Makefile
+++ b/drivers/gpu/drm/amd/display/Makefile
@@ -31,6 +31,7 @@ subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/inc/hw
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/clk_mgr
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/hwss
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/resource
+subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/dsc
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/modules/inc
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/modules/freesync
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/modules/color
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
index 1cac1eca8111..93ac45802e44 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
@@ -7,8 +7,6 @@ DCN20 = dcn20_init.o dcn20_dpp.o dcn20_dpp_cm.o dcn20_hubp.o \
 		dcn20_stream_encoder.o dcn20_link_encoder.o dcn20_dccg.o \
 		dcn20_vmid.o dcn20_dwb.o dcn20_dwb_scl.o
 
-DCN20 += dcn20_dsc.o
-
 AMD_DAL_DCN20 = $(addprefix $(AMDDALPATH)/dc/dcn20/,$(DCN20))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_DCN20)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/Makefile b/drivers/gpu/drm/amd/display/dc/dcn35/Makefile
index 719afb5a3b12..85a307babab9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/Makefile
@@ -12,7 +12,7 @@
 
 DCN35 = dcn35_init.o dcn35_dio_stream_encoder.o \
 	dcn35_dio_link_encoder.o dcn35_dccg.o dcn35_optc.o \
-	dcn35_dsc.o dcn35_hubp.o dcn35_hubbub.o \
+	dcn35_hubp.o dcn35_hubbub.o \
 	dcn35_mmhubbub.o dcn35_opp.o dcn35_dpp.o dcn35_pg_cntl.o dcn35_dwb.o
 
 AMD_DAL_DCN35 = $(addprefix $(AMDDALPATH)/dc/dcn35/,$(DCN35))
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/Makefile b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
index a2537229ee88..b183ba5a692e 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
@@ -1,8 +1,34 @@
 # SPDX-License-Identifier: MIT
 #
 # Makefile for the 'dsc' sub-component of DAL.
+
+ifdef CONFIG_DRM_AMD_DC_FP
+
+###############################################################################
+# DCN20
+###############################################################################
+DSC_DCN20 = dcn20_dsc.o
+
+AMD_DISPLAY_FILES += $(addprefix $(AMDDALPATH)/dc/dsc/dcn20/,$(DSC_DCN20))
+
+
+
+
+###############################################################################
+# DCN35
+###############################################################################
+
+DSC_DCN35 = dcn35_dsc.o
+
+AMD_DISPLAY_FILES += $(addprefix $(AMDDALPATH)/dc/dsc/dcn35/,$(DSC_DCN35))
+
+
+
+endif
+
 DSC = dc_dsc.o rc_calc.o rc_calc_dpi.o
 
 AMD_DAL_DSC = $(addprefix $(AMDDALPATH)/dc/dsc/,$(DSC))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_DSC)
+
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
rename to drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.h b/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.h
rename to drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dsc.c
rename to drivers/gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dsc.h b/drivers/gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dsc.h
rename to drivers/gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.h
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h b/drivers/gpu/drm/amd/display/dc/dsc/dsc.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h
rename to drivers/gpu/drm/amd/display/dc/dsc/dsc.h
-- 
2.42.0

