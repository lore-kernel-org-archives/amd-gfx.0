Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7AF3C433F5
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Jan 2022 18:21:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE34310E3DB;
	Sun, 23 Jan 2022 18:21:04 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40BF510E29F
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Jan 2022 18:21:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abOnrcnpMAxBL3mV4gtaVYM0cdXQug+gVdYMCpsBDrb+LNG7gE5IvgTXKVuk3Lj2MSjF954gbxm2gw8G1BPd8a7l/YKA0CmQC+LW3fj8hSRchz6vbGs2yEHJK0c6vXDP4V1z5GpUoaA1V6pKnLW0Hd1+ft4uHxfF2lYr2bJn3GKd52X287/w8DpavajKBcIIltC4lpMCydIgLaRAIkWw3cRovIcBUspc/LHajnUX1gEPlwCNJirkkdCYOKSsEyY7TFu4ye7uDc5YrGVO+vp6v2AhYhocept4Sr0aXKv8iU5oevKdYrgbAhwgE/58w0ppTx9etsT+yBq/S+Lqt4Aa2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uj9hVoq/BDLlVEzT/SUMHTO4qCglK0Plj2u4Yss6lIM=;
 b=d3xU+nvZPHAJyGsB7QiLU4EAN+YmT6DGeA++eoH3Oz4UUzYUsBOh2FqJYsqsV+2g5+Sy6lOIObDIMzgts+lCIYj+ngGg/dlJDBRKK/2N+DZDHKDKgxM/Z9+nZFZSSy+y/wW62BGxsVUtT8o1qjCDMttO4gZa5KpqWkevyU7hMBG+J+00Vo+sPktegC78oIOVO7Mu0GWoxIYTXdv5dIIQJXECmiIu9tD58BEO9c3E4xaB4wZgxOzHWGShytfOIFgkQbXHFZdkoieuk22N/O0OKVDEiDVoLpBQu8QVBFa6AbEUEOszdHVubN4uAv7t+vGgMDpfIwoz73NYUp48s/TnmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uj9hVoq/BDLlVEzT/SUMHTO4qCglK0Plj2u4Yss6lIM=;
 b=SFnLTmkvW099ovL2pupnzuyQKphKHd4ZqeqysazO7UY18rmXqN6MvTGHua3ZT2BIkqewXDHKVjw5lOGTifOqqwuwh3LHKGVYr4LKDPt/BaS8mww7fNXw9xV1IwkE61rWQyPfsFrUyg8+vkhJiAuU5vt8DSME+JBV6XzP5+UrjWI=
Received: from BN6PR14CA0004.namprd14.prod.outlook.com (2603:10b6:404:79::14)
 by BYAPR12MB3144.namprd12.prod.outlook.com (2603:10b6:a03:d6::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Sun, 23 Jan
 2022 18:20:58 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:79:cafe::c9) by BN6PR14CA0004.outlook.office365.com
 (2603:10b6:404:79::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10 via Frontend
 Transport; Sun, 23 Jan 2022 18:20:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Sun, 23 Jan 2022 18:20:57 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 23 Jan
 2022 12:20:55 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/24] drm/amd/display: Driver support for MCLK query tool
Date: Sun, 23 Jan 2022 13:20:00 -0500
Message-ID: <20220123182021.4154032-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
References: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 742d4413-d24f-461c-d768-08d9de9d19e9
X-MS-TrafficTypeDiagnostic: BYAPR12MB3144:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB314400A6CC260D12E4677C71985D9@BYAPR12MB3144.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EuSUXpGO+Ytmyd/j+ZlT9DaHleuAYfqHSgvMrMa4FYxTeZis5d969VBg2sMw5XZJ2rEfPwk3sruBYAld4sAKidlKnd1RAkTw5t5kLQz8/FGIcKQs8wfiSIcf3bOIcA3zFRyb113uaiSRj02Y8RJ1ohGYrqck6+XtcqDbA6Ryjvr2y21TbGVjoPuFUoWB4IMlumYQtYvyZEveIQRBoRECc+YYpx4pu09M0FqjEwOYJXHOAggAwyGKiEmwhNBW8jGrPN4yBlJPMDKLbHhebDPrkvNkgLpT+0bhdT7wdSQ4IRv1ztq3SPkMhtnaeqZkYzQdIwSInT9IFGizR/Hh+P28335AeCJ+MtuYkx69s6Pxhpvp4M5idhWd0qu6YI8IGQEXjp2mLkMyc81UP42Gl9QkQnHM3/sWbYWyJWva/+tTh8lREZ+a6I87NqsWlWGzq+E2e+93EQb35c1QKbn49wunRX2TrHHebB97DVfgUBuQ9hYVsCedpAUH50QLgwSlTiRWT2pZU4twsktMqOQoB7Ci9DpwIZztzWSvQnmVknLTxhkdevrZtKpLDoIRBNZcZF50mIYgXwjOwy64O0otL+llbTfBI5bFYd2Wj71K5oKq4FsTH16dpm26LaWAC1MoT2yiYb5/pOlsU+D+RCiskSNeNFB6ZzOshVeKqopJV6Q+KN374ekWphof/mbM1PE4prOq646bJiJmkefl59Jnu02doZ00Icq+ch6DLOQ5l4C83CvdCU2Ft63sJ0om9JDTuR0BNj9VsMTr/4nRtKBmalqOLIR4dp4PPA5+EpNZwKCiy6UzqSaNSQ77pF3BY9Aetyk1q5PrrI/X/b9/V7S69/w7mA+UCkPA88FWDGGL4Fhz90Wl2vPehfqiHTxrvTUl7/Ki
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700004)(46966006)(70206006)(8936002)(5660300002)(54906003)(336012)(2616005)(47076005)(2906002)(36756003)(70586007)(1076003)(83380400001)(26005)(86362001)(36860700001)(6916009)(356005)(40460700003)(16526019)(4326008)(186003)(316002)(82310400004)(6666004)(426003)(8676002)(508600001)(81166007)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2022 18:20:57.5154 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 742d4413-d24f-461c-d768-08d9de9d19e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3144
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

Implement handling for escape call to query the MCLK switch support for
the current display config.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 .../drm/amd/display/dc/dml/display_mode_vba.c | 24 +++++++++++++++++++
 .../drm/amd/display/dc/dml/display_mode_vba.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index 0fad15020c74..c0740dbdcc2e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -47,6 +47,7 @@ static void recalculate_params(
 		unsigned int num_pipes);
 
 static unsigned int CursorBppEnumToBits(enum cursor_bpp ebpp);
+static void cache_debug_params(struct display_mode_lib *mode_lib);
 
 unsigned int dml_get_voltage_level(
 		struct display_mode_lib *mode_lib,
@@ -73,6 +74,7 @@ unsigned int dml_get_voltage_level(
 		PixelClockAdjustmentForProgressiveToInterlaceUnit(mode_lib);
 	}
 	mode_lib->funcs.validate(mode_lib);
+	cache_debug_params(mode_lib);
 
 	return mode_lib->vba.VoltageLevel;
 }
@@ -745,6 +747,28 @@ static void fetch_pipe_params(struct display_mode_lib *mode_lib)
 	mode_lib->vba.HostVMEnable = mode_lib->vba.HostVMEnable && !!ip->hostvm_enable;
 }
 
+/**
+ * ********************************************************************************************
+ * cache_debug_params: Cache any params that needed to be maintained from the initial validation
+ * for debug purposes.
+ *
+ * The DML getters can modify some of the VBA params that we are interested in (for example when
+ * calculating with dummy p-state latency), so cache any params here that we want for debugging
+ *
+ * @param [in] mode_lib: mode_lib input/output of validate call
+ *
+ * @return: void
+ *
+ * ********************************************************************************************
+ */
+static void cache_debug_params(struct display_mode_lib *mode_lib)
+{
+	int k = 0;
+
+	for (k = 0; k < mode_lib->vba.NumberOfActivePlanes; k++)
+		mode_lib->vba.CachedActiveDRAMClockChangeLatencyMargin[k] = mode_lib->vba.ActiveDRAMClockChangeLatencyMargin[k];
+}
+
 // in wm mode we pull the parameters needed from the display_e2e_pipe_params_st structs
 // rather than working them out as in recalculate_ms
 static void recalculate_params(
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 8fe74a3b39a8..0603b32971a6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -195,6 +195,7 @@ struct vba_vars_st {
 	unsigned int LBLatencyHidingSourceLinesY;
 	unsigned int LBLatencyHidingSourceLinesC;
 	double ActiveDRAMClockChangeLatencyMargin[DC__NUM_DPP__MAX];
+	double CachedActiveDRAMClockChangeLatencyMargin[DC__NUM_DPP__MAX]; // Cache in dml_get_voltage_level for debug purposes only
 	double MinActiveDRAMClockChangeMargin;
 	double InitFillLevel;
 	double FinalFillMargin;
-- 
2.25.1

