Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77125E936E7
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 21:21:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A70AE10E3C1;
	Wed,  4 Oct 2023 21:21:46 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A297310E3BD
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 21:21:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKZU8oQsuA0Bw4vSmtJ+dgXaFbCe4jqis2CaA0o8tfnqFx44U66Wsc4KoLRVJwz3e7LIbGzOyVFxiQMHuLOLe0dnBaRuzbPsPQ5VEnmh5In9b5yrU5jUoqSsSkKLBNgth9D1qq9xFAE9eDa0UVPpgdCC/1lycYH62Y+fBbOkhDV8XoH71bBJUiSx/ZR0aYVBYsnWHaEwGkTmwg0negZ0wKRO4gZOEp0E8X6iqMPDhbzbvwDCd2Bh0wnKCwHbjZpdWJRQTPDVWUuxO74YZ5EchlmqBF66zwMtOlbNVadUevlhuS0E2UFYg1fnDqVDGoiS0/bA52oMim/gEX4haizBrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3cB2CTbJZOryd3CmE0OnW4G0aUubTmWUGYoiI8ptik=;
 b=RcREgtscwVWx4L7ioCT39FjqwKUVstK03boO6IzTUYkPCOw/6IWdqt4FWyvK+WDkiUjqNLIji3OAu991vPkpBpgS7Hfjw99Z1reejqWmgG6SErElNTH5900D/EPnB/nmojxPL8qQASPI2TflFvu+W1lD1JEYxuoH9edNCSQ56PqEMTMiJNPwGvOjSyX4zg44yqztOaFVjqQgF9p1SKnsiKVQF9Q70bszJHCEjIqyUnFgSk5dNcnF77/SUva0E3VOf6MZM0DN+A0ZEin4w9uBBxiBXy3UrIiP8bzWtj3eCNi+pMYXR3qTe3b8nMCYIbko6MaWVcmB7iwvIe9dUjgQBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3cB2CTbJZOryd3CmE0OnW4G0aUubTmWUGYoiI8ptik=;
 b=FEliZ3OtG7sMa1yqwrLSxvBddI3lot2fesTawVoLN+ZFIdNQXshwhox3csCAZrgQAE8RJhg6ET1br0Oc0s8ALa8YpT+V1eOkqXS/fcUP8rmS2yiqddP0lfN7uHRkhO7iAVCWyEd7L2PQNCjsXMwwH2wrriYzcGMRUp/XT5inUj0=
Received: from MN2PR11CA0002.namprd11.prod.outlook.com (2603:10b6:208:23b::7)
 by PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 21:21:39 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:23b:cafe::ba) by MN2PR11CA0002.outlook.office365.com
 (2603:10b6:208:23b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25 via Frontend
 Transport; Wed, 4 Oct 2023 21:21:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 21:21:39 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 16:21:36 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 01/16] drm/amd/display: Move dce_calcs from DML folder
Date: Wed, 4 Oct 2023 15:20:55 -0600
Message-ID: <20231004212110.3753955-2-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231004212110.3753955-1-Rodrigo.Siqueira@amd.com>
References: <20231004212110.3753955-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|PH0PR12MB5417:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fdac54e-2190-438a-2924-08dbc51fe5b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HzXlMFVkY2I+eq2hq2uNDY54WHlyLPXTu1a1x4Q8tkle8Enpn9nPe1d/dZIZEJ16FTW7GNPGW4fWHkv0MkVIb9WLqV17VndmfVEjHpv2ruBUzQ5uGOeo9AFO+ne6GbKBM0SOY/U4le0eS8yUk4aCtwdzMeiFqLasw0LHDrPgb6b1oua8dQYdEWhwZFPilQSkO6g22HrQQwIu4AkKM14hDRzodyI/j8BPNqD0uDlJC3ayt9PGGGjyFwoxwQI0HLzEZsp5hdt9m7bx0sBD/TUZ7fGNjGdqbKGsrnWgjO8+JLyJpQwYJDEQwxBYncSHcmJj51ow72sdiApR9/1MG8llvhpGM6nMwfwuuAWvdCb7lstg0TlUZ43lOEbToK+AjyoQIExDtSaokUKgPoxaVy5BWMqhg+7zrDF7ti1Wa1HJktbO49rAN6lG0ShMMx2DS2zxEx8kSWxeilcK0yXwb4WYqo3UWLcLc0CP4RabZUETzwcaGCuKRTxnaq75F0totjNOQak0zT+ByxzdFxeC5MPHkNNjDxsXuTkx5WSdEspXke5Oa/qepBW66eNAGtNfxhUt296KwS34k58vPnO5XdQKxqdbkGfCWMtD9itA8EaItzG5MWJc1ArQ7cA4GQWPK8T6JdOW7VtgqLcbklvM1bihKlxL6ttb0opZStMVGE0KeplOyy2l0YoeH/nXQK7rYOrFUNxQZBKzPIzPauLmUEHmORFZkxNfU8vD8Zs/9Paq+7Q2L0s1Ouo5CPFcP3ve3RlNjKqoHDKEKtsH+gLkuyTp/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(82310400011)(36840700001)(46966006)(40470700004)(40460700003)(40480700001)(1076003)(2616005)(478600001)(6666004)(36860700001)(86362001)(356005)(82740400003)(81166007)(8936002)(8676002)(4326008)(5660300002)(2906002)(47076005)(83380400001)(26005)(426003)(336012)(16526019)(36756003)(41300700001)(70586007)(316002)(6916009)(70206006)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 21:21:39.1035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fdac54e-2190-438a-2924-08dbc51fe5b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5417
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
Cc: Sunpeng.Li@amd.com, richard.gong@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Alex Deucher <alexander.deucher@amd.com>, Harry.Wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

dce_calcs does not have FPU operations, and it is required for DCE and
DCN. Remove this file from the DML folder and add it to the basic folder
visible for DCE and DCN.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/basics/Makefile             | 7 ++++++-
 .../amd/display/dc/{dml/calcs => basics}/calcs_logger.h    | 0
 .../drm/amd/display/dc/{dml/calcs => basics}/dce_calcs.c   | 0
 drivers/gpu/drm/amd/display/dc/dml/Makefile                | 2 +-
 4 files changed, 7 insertions(+), 2 deletions(-)
 rename drivers/gpu/drm/amd/display/dc/{dml/calcs => basics}/calcs_logger.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml/calcs => basics}/dce_calcs.c (100%)

diff --git a/drivers/gpu/drm/amd/display/dc/basics/Makefile b/drivers/gpu/drm/amd/display/dc/basics/Makefile
index 01b99e0d788e..ee611b03dc48 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/basics/Makefile
@@ -24,7 +24,12 @@
 # It provides the general basic services required by other DAL
 # subcomponents.
 
-BASICS = conversion.o fixpt31_32.o vector.o dc_common.o
+BASICS := \
+	conversion.o \
+	fixpt31_32.o \
+	vector.o \
+	dc_common.o \
+	dce_calcs.o
 
 AMD_DAL_BASICS = $(addprefix $(AMDDALPATH)/dc/basics/,$(BASICS))
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/calcs/calcs_logger.h b/drivers/gpu/drm/amd/display/dc/basics/calcs_logger.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dml/calcs/calcs_logger.h
rename to drivers/gpu/drm/amd/display/dc/basics/calcs_logger.h
diff --git a/drivers/gpu/drm/amd/display/dc/dml/calcs/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dml/calcs/dce_calcs.c
rename to drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index b06c3983af36..8621dfe9a68c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -134,7 +134,7 @@ CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := $(dml_rcflags)
 
-DML = calcs/dce_calcs.o calcs/custom_float.o calcs/bw_fixed.o
+DML = calcs/custom_float.o calcs/bw_fixed.o
 
 ifdef CONFIG_DRM_AMD_DC_FP
 DML += display_mode_lib.o display_rq_dlg_helpers.o dml1_display_rq_dlg_calc.o
-- 
2.40.1

