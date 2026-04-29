Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05FA9FF887E
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 01:52:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9335310E39A;
	Wed, 29 Apr 2026 01:52:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T+ZUSzWD";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012057.outbound.protection.outlook.com [52.101.48.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02D6710E39A
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 01:52:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=telp9UZyKzvbsCMW8/YD/7Q1AktNfsGiX4ah5SuF1iBW4d4U+w+rARCXzi5THa9EAN6mJrqH2AONpVYAX1N9j5Qd60auDpUVvtE26lhe8XAgIxxJL70v+UHIt/ukatUocKqIVJIo9NzXd3UJOxahgc8v5eBnJwpOLWqpA1tQ/xchpKZ8H0xseyCCItKJqOAyfxwVgaTrFrWoj5Da2nzCkLUzgDRK3lBNfCslOSrvhGvtVN6XYQyso70UJ15uKT+rUjCv+m489pLjvAvxtR+2mfDocbYdr/iewmD/rTRZS6vgQpImMuLPw1jQcHfufR4XSeCBsaeFaoAX0PPB2RUPHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8v89vojTx/2wbzyS3z6NmsIZ3fTD2FfVeVQsgMEJErA=;
 b=goRbQ7DkcqlheOA+OsZ2g/rQknd63paL3CZWNw2yFlEwCipK1yYusxivaXb/WVTnXP9F8YR3dGCtiD3JX68s0HjOfqQgHnQigSmzuFUPtu6peb7rFjWdzgbVbKZd9ccdPOFxkXxR8SjyssPYQ3L4/6rBajI+srcppZO2/nnP+qgYw3yycvEZwE/fvXgg7XyiNipo3/QDHzQqPSYkqpHwxFZ2PBXBkp8A6vYToVo9heaJ2PhWoR9DKUCrqkZgUBWwM0r/RCi4/sTmW4IlhXKPMYX38j6INzKmuPgq+whPfmNPI3vSwT0NgxBtCTQi1JysTHeQhxk/rclOc2c1LJk5Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8v89vojTx/2wbzyS3z6NmsIZ3fTD2FfVeVQsgMEJErA=;
 b=T+ZUSzWDzr8YEu6UBA+tl0f7RPSiureRRpp5pKTPmjZA6e+lCICKQ909UkFfqhR2y95rBXKtWLQcUsCexhsY4aJvBxDqpDbN3oCn8rV2WDFAygFnbc9kkk2XEHWP/uMzUwrL7wsIEL+GOJkf8OMPnbX8bi7hTDTNRL4NjEMk5sc=
Received: from SJ0PR03CA0020.namprd03.prod.outlook.com (2603:10b6:a03:33a::25)
 by DS0PR12MB8296.namprd12.prod.outlook.com (2603:10b6:8:f7::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.17; Wed, 29 Apr 2026 01:52:31 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::8a) by SJ0PR03CA0020.outlook.office365.com
 (2603:10b6:a03:33a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.28 via Frontend Transport; Wed,
 29 Apr 2026 01:52:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 01:52:31 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 20:52:27 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via
 Frontend Transport; Tue, 28 Apr 2026 20:52:18 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Gaghik Khachatrian <gaghik.khachatrian@amd.com>,
 Dillon Varone <dillon.varone@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 04/17] drm/amd/display: Do DML float narrowing explicit
Date: Wed, 29 Apr 2026 09:19:13 +0800
Message-ID: <20260429012055.2065869-5-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429012055.2065869-1-PingLei.Lin@amd.com>
References: <20260429012055.2065869-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|DS0PR12MB8296:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e3d5f54-1477-47e4-8429-08dea591f9ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: IAaSh1GsCeYnTyTz3YAoNio5uG+zxPfM+U0lCtOPBseP9Y90x88QalOeGfnI+verCyiH6jRLscg+PqCSlvO2hfnLZdQo1/d4AH9n5GP/UnHFy4hbwnbLyXD7oNYia9+Qfvv/Wg8yI/a1eoae4RjIbhLk/oDJX6weQBg4NFyGHd1RDU/b1v2C526nz7NdvrgmecWA5C8v2CBs0jvfI1ZFuo4fQhcXl70rBTnUnVUOHavTDTGVMePUGByjb10OyR+ZyYnKiN4BTEz+bYDuAvbXSPChgPolb02c8JSwWYDR/ldGpGXbU2nk6oLb/Y3AdO3ho45ccCr6SoowhmO3uXRCCNaUI7UbPrRW3i46UeUaI9KvOaqdWcx1OzrUWc+YB8QopEt9qy9lxbiAETjFvM1NCi/anz6beoWoXjAe9MJrNauDzpkiunEkuXXbRim+85tgnPCBaXmAh1+XByr6HKrLsuaxhZ/hCPHm4vKFxSiBRiI5gE/oHexiaOSGbZbXm5xkI7Yb8PHJX1HVT0/c1wTmhP/yZ5Eyp0un5TjiWgVO6B+7LRHLgZgHhm0SCFjSf/J+EwjDVuC+LN2Cy2DGiuZ92e6e6/or75Y5n3U43vzspGNE+1HxL2yAt9kml1tgGvLqZWoa0MA2beOeeLx4Qp2u7Lurw22t/l1Ja4OZPTlZEgWg30R1ueE/SJsOy3vDUiLGM1YcjGEWqPO5cTGizZrbcsL8QiOawUuI9eD0oR8Heev1+OdREcy7+WiUZycynuF2EiZl3hPscxtcEO3N2Fgg9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZEddnLNFQo80eLRzjA1G4qY+GP+GdzsOFx1hon0PYWx1Jvny4FJZrBIkmIoPXReJmgS+qr+MDcyhkho2jqwSk9Dou/l/4O501sUticK3CHYs2szjUjYAlSdvQo50sV9iPSXz7YWBJG+BfHgySlKd8Jp6o2YWYnhQrItAfHELBBfwEVftoJ+eE2ai+uHfFTumRnVnhj0pHLaiQ2WWLeSLHZLOmttPdJcHaCH//rsxVnios7uZJDXR58pvoSWMMn3CworGUr2WFeyW2hShfSOCERcAtRYOIGf84GJvkk2frqf7okIVKhtX9zjFzoOx3lDffmvaPJ9WwaoRJ4MFYZLF4wUgF8F6wbFYZN7Vclj5dFnDilYj0wHo3Q8/9H6Rx8idTJG17kzl0S8eb+4y5Z4kzn+/1lZH1oQYjRQhbTDec+1wUHh9hJ6zo6/IYQl0yNZz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 01:52:31.4966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e3d5f54-1477-47e4-8429-08dea591f9ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8296
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
Shared DML wrapper helpers in [dc/dml/dml_inline_defs.h](dc/dml/dml_inline_defs.h)
pass double and int values to float-based dcn_bw_* helpers. Make these
intentional narrowing boundaries explicit to reduce warning noise
without changing behavior.

[How]
Add explicit C-style casts at the float API boundary in the shared DML
inline wrappers used by the DCN DML paths.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Gaghik Khachatrian <gaghik.khachatrian@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../drm/amd/display/dc/dml/dml_inline_defs.h   | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h b/drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h
index 6b2ab4ec2b5f..be6ebf53d9a2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h
@@ -31,7 +31,7 @@
 
 static inline double dml_min(double a, double b)
 {
-	return (double) dcn_bw_min2(a, b);
+	return (double)dcn_bw_min2((float)a, (float)b);
 }
 
 static inline double dml_min3(double a, double b, double c)
@@ -46,7 +46,7 @@ static inline double dml_min4(double a, double b, double c, double d)
 
 static inline double dml_max(double a, double b)
 {
-	return (double) dcn_bw_max2(a, b);
+	return (double)dcn_bw_max2((float)a, (float)b);
 }
 
 static inline double dml_max3(double a, double b, double c)
@@ -68,14 +68,14 @@ static inline double dml_ceil(double a, double granularity)
 {
 	if (granularity == 0)
 		return 0;
-	return (double) dcn_bw_ceil2(a, granularity);
+	return (double)dcn_bw_ceil2((float)a, (float)granularity);
 }
 
 static inline double dml_floor(double a, double granularity)
 {
 	if (granularity == 0)
 		return 0;
-	return (double) dcn_bw_floor2(a, granularity);
+	return (double)dcn_bw_floor2((float)a, (float)granularity);
 }
 
 static inline double dml_round(double a)
@@ -103,31 +103,31 @@ static inline int dml_log2(double x)
 
 static inline double dml_pow(double a, int exp)
 {
-	return (double) dcn_bw_pow(a, exp);
+	return (double)dcn_bw_pow((float)a, (float)exp);
 }
 
 static inline double dml_fmod(double f, int val)
 {
-	return (double) dcn_bw_mod(f, val);
+	return (double)dcn_bw_mod((float)f, (float)val);
 }
 
 static inline double dml_ceil_2(double f)
 {
-	return (double) dcn_bw_ceil2(f, 2);
+	return (double)dcn_bw_ceil2((float)f, 2.0f);
 }
 
 static inline double dml_ceil_ex(double x, double granularity)
 {
 	if (granularity == 0)
 		return 0;
-	return (double) dcn_bw_ceil2(x, granularity);
+	return (double)dcn_bw_ceil2((float)x, (float)granularity);
 }
 
 static inline double dml_floor_ex(double x, double granularity)
 {
 	if (granularity == 0)
 		return 0;
-	return (double) dcn_bw_floor2(x, granularity);
+	return (double)dcn_bw_floor2((float)x, (float)granularity);
 }
 
 static inline unsigned int dml_round_to_multiple(unsigned int num,
-- 
2.43.0

