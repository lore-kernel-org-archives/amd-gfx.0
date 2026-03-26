Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B3F8109E542
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 03:02:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF10E10E943;
	Thu, 26 Mar 2026 03:02:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TkEmLrhd";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013037.outbound.protection.outlook.com
 [40.107.201.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C769310E943
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 03:02:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fanfhCSifUebTbTySqhGgjSrvvR90GIgPaCbEnqw7LemCkBa+PcFU67jE14RFx4zjBqYGxbW2DpzeJH+idUxj6KnBiU8jGtlj8dzUlB+ghMasuxyNEa+ngskoQvZuH2HtKgtAheDuJXD3A1IQsFb+zFWnDBhuRTJh5wh5VZ709+NOQFy/Je1ODjvLQmQ33ffl0Y11ESkkxgQ73gI2tXfpk+xkJIUIQgUzFX6OXu4jEsyYAsLDX4gZ9JkpSps5hiC8BqNhwnmOsJfAl4DCvL1gir2FvDg8kaScMUYldpoGV+EwbPMv1EZDWTi4r7EjX/FRU/KBlgGVuq4zPyH3vmc1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hajlKTjqs9j8bZ47/7IMr7nEmDdUMpDk61Py+WNLzV0=;
 b=m49F/J7MXc0D5iQp9p7dMVILT4HaiuzirgQwtxtCGpTSZnyhmYgLIV6kdn8psUREmGMObGqm2scxyDNdwklg8gPlOtOL/4d4TMTq3JHS0akRXSQlkDaocOvtj1QvrZ4hpkA5Nmr4wwBztxjkLLRhPZ9JayrT1pzJ3Y/y7qhmlL+RQoenQ3YuJ7SeSWC4zP7ZH+9tH8V3zkFEzGyS2V5L/mVpljGZ6CbtK0ly2YQNH+R7u/tw7Rk9c935U9I/g5r+4whgoueY6Bbp0KnldqGzIGkyb76ojEMRf4PZogmhjbpEP7TDNpcV3CPBRyTvIeCorWIAt2BBcQ4PhExcYwClJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hajlKTjqs9j8bZ47/7IMr7nEmDdUMpDk61Py+WNLzV0=;
 b=TkEmLrhdzZ7VVPW75dwgk1ekjGEuqBlQ6aTqEmf5cdvvoyylwWpR61GHF03+orwO/vs8Y/iY0S5qOKQX6le8v5bmSsOKH56r0IygeDh7qHwvB9TZv7p98nx5euOtYq0G9Ca2MVnxkuC8j9cyPV4ShMUSsLNUAEMbvU0sBVyvNSY=
Received: from MN2PR01CA0022.prod.exchangelabs.com (2603:10b6:208:10c::35) by
 CH3PR12MB7764.namprd12.prod.outlook.com (2603:10b6:610:14e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Thu, 26 Mar
 2026 03:02:48 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:10c:cafe::8f) by MN2PR01CA0022.outlook.office365.com
 (2603:10b6:208:10c::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Thu,
 26 Mar 2026 03:02:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 03:02:48 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 22:02:44 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Gaghik Khachatrian <gaghik.khachatrian@amd.com>, "Aric
 Cyr" <aric.cyr@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH v2 27/30] drm/amd/display: Fix Compiler warnings in dmub
Date: Thu, 26 Mar 2026 10:57:18 +0800
Message-ID: <20260326030153.406612-28-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
References: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|CH3PR12MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ba706bf-5eae-4cdb-152e-08de8ae42998
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0BmJ2bJ6L8h3jTCwPDfquM6/zVYf7adaMgqvxtAu8+1jNx6+mqtFc2BtvRAAVG2VzPymrlDHxI0cPXQiKO4Y8co/DdqTIccVJlntsBuWajZXBuYJCzdHmph4te2c7iusiPPowjnIVur1+XJ1dHSJbSxzsNjorhfXWjbGYXLwKjiuLMoFEntf/GtM8hj7BwA89XLKo5pivRmj1wEBCTKChEE6TOO3JTFUiwIMTERz42cVi3U27C23AYBPSpoXzgfUXI8qsO2Cx2kfYVHRKeHGkXX39Q6/SIeAVAnkOakA+aT8+PQzBvUCt1pK9RNnyftt2OxctKGs50gm1npDFuPxYIIGwNu6cLFjOK18ImL2wyDqypuvTRUmP2yoeeF7ijfFvsCBO27e4LRXN1wZX1CCf/6yYQOt7lq4m/BQNzZR2gEEUV3pi3ZMrkP0d/x2s+1HawhyYwvQcirg46yaVT+PNHkGq3t9Jodipe3AnyfXJ+RKjhk5bOX19sVGp0FD+OQMzF42V2zgSuUEf+q3/qdZxCDd4GkeyvjRChkGCsqg0nhLyp43MhgT6cbtbiXJV9/DVTsJ3oHVDnhrJodqzTA2eYZdz1pLKm9fUBsAAeSLSkvSvPZZYHEt0k6aLPeTSusAVvY0c1ZVx2OYV54ClHH9HT8Eg9pzGzXyPNkv09/LeCb1mPuf89q7Z8QV1Ik1f9k3Shwf2Z/RTMB8ID6qWwN64uoBPN2yANfAfGMvL8VwgO5PG56DEMxMe2yXzScSK5v3T3+MDfuVgmZPb1vPCQEl9Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cK6Wwtz+3u04G0kSQq3I1nae+TRQkSLBG3kz08enbjAzwja2RqP4FDH82oJT7/4m+MoT4WFPLImQ7nFSAgSOHGrvaDgYqjtOQr/oF3Cypi5+ScGiwmeRxFFuTBc3pf4uPVb70cX9F9HhOrqnEYjBRKX5anDwDTnVIb9nDP/aCvT8BAWGcyPRQ96ePCWaOHcoS1xwmYUk56LzrC6dlS90fH0KDQM9e/jnJJPk2YHN3V6E9/fW9lZ7uPQiNIsKWcwyZMJRR/w7Mj+y58xyDmlPxyKaw5kcKY2cQD02ebrVB0dSqCqmYbT2TPZ5Dnw12AxeWwz3reG2lWMw0WkVwhEiCXxSFM59AwJlSh4J1+X8W8WJ+yjErql2AMDoRRBiNY1z0VG28fybu9A4Ut7P+4c+2XmAbW7QFRjwSiAvVhprqpfmbQ0pbv1aPcuSOeJsh+N3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 03:02:48.7842 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba706bf-5eae-4cdb-152e-08de8ae42998
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7764
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

From: Gaghik Khachatrian <gaghik.khachatrian@amd.com>

[Why]
Resolve compiler warnings by marking unused parameters explicitly.

[How]
In .c and .h files, keep parameter names in signatures and add a
line with`(void)param;`  inside the function body

Preserved function signatures and avoids breaking code paths that
may reference the parameter under conditional compilation.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Gaghik Khachatrian <gaghik.khachatrian@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c  | 2 ++
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c  | 1 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c  | 2 ++
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c  | 2 ++
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c  | 1 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c | 1 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c  | 1 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_reg.c    | 1 +
 8 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
index 73221ca53b7d..0b152926f75b 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
@@ -194,6 +194,7 @@ void dmub_dcn20_setup_windows(struct dmub_srv *dmub,
 			      const struct dmub_window *cw6,
 			      const struct dmub_window *region6)
 {
+	(void)region6;
 	union dmub_addr offset;
 	uint64_t fb_base, fb_offset;
 
@@ -396,6 +397,7 @@ union dmub_fw_boot_status dmub_dcn20_get_fw_boot_status(struct dmub_srv *dmub)
 
 void dmub_dcn20_enable_dmub_boot_options(struct dmub_srv *dmub, const struct dmub_srv_hw_params *params)
 {
+	(void)params;
 	union dmub_fw_boot_options boot_options = {0};
 
 	REG_WRITE(DMCUB_SCRATCH14, boot_options.all);
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c
index 84a6eb3f677d..23a33db07edc 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c
@@ -127,6 +127,7 @@ void dmub_dcn30_setup_windows(struct dmub_srv *dmub,
 			      const struct dmub_window *cw6,
 			      const struct dmub_window *region6)
 {
+	(void)region6;
 	union dmub_addr offset;
 
 	/* sienna_cichlid  has hardwired virtual addressing for CW2-CW7 */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
index 244244f3df80..478d79a6e246 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
@@ -195,6 +195,8 @@ void dmub_dcn31_setup_windows(struct dmub_srv *dmub,
 			      const struct dmub_window *cw6,
 			      const struct dmub_window *region6)
 {
+	(void)cw2;
+	(void)region6;
 	union dmub_addr offset;
 
 	offset = cw3->offset;
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
index 5d86f649db4b..3f9fb9e05b79 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
@@ -237,6 +237,8 @@ void dmub_dcn32_setup_windows(struct dmub_srv *dmub,
 		const struct dmub_window *cw6,
 		const struct dmub_window *region6)
 {
+	(void)cw2;
+	(void)region6;
 	union dmub_addr offset;
 
 	offset = cw3->offset;
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
index f9b16eb8ef8e..69fb6084232e 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
@@ -222,6 +222,7 @@ void dmub_dcn35_setup_windows(struct dmub_srv *dmub,
 			      const struct dmub_window *cw6,
 			      const struct dmub_window *region6)
 {
+	(void)cw2;
 	union dmub_addr offset;
 
 	offset = cw3->offset;
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c
index 3d2307d0ce49..e5a78df80d72 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c
@@ -213,6 +213,7 @@ void dmub_dcn401_setup_windows(struct dmub_srv *dmub,
 		const struct dmub_window *cw6,
 		const struct dmub_window *region6)
 {
+	(void)cw2;
 	union dmub_addr offset;
 
 	offset = cw3->offset;
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c
index 7b870b831199..a09aa19ad379 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c
@@ -229,6 +229,7 @@ void dmub_dcn42_setup_windows(struct dmub_srv *dmub,
 			      const struct dmub_window *cw6,
 			      const struct dmub_window *region6)
 {
+	(void)cw2;
 	union dmub_addr offset;
 
 	offset = cw3->offset;
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_reg.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_reg.c
index 94f4931d3d44..b5566ef8d4f3 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_reg.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_reg.c
@@ -45,6 +45,7 @@ static void set_reg_field_values(struct dmub_reg_value_masks *field_value_mask,
 				 uint32_t mask1, uint32_t field_value1,
 				 va_list ap)
 {
+	(void)addr;
 	uint32_t shift, mask, field_value;
 	int i = 1;
 
-- 
2.43.0

