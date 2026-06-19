Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C768CD98F6
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 13:32:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06BBF10F5E1;
	Fri, 19 Jun 2026 13:32:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BHHJRWdf";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011027.outbound.protection.outlook.com [40.107.208.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 374DE10F5DE
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 13:32:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pDRPH141oN7vtjAMuKXAr5wGuYAv7oTRRp07BDOnsvS13o5xaTrhYbeaIMOCrKOVZ2VZR68YzpgduYTUEwd9unz37ysUdQOkN3g2pulxMRDNKwuI/tADobPoIdoVD9ZlpYX1d1fsjp+xBS6v5qbBRppowhLdvs9wZKG3BtKnExcbEJKYMgtjXV6fpa91ikzrBVEb4DGkmWyiEVAL+SIt4uOso9QSDdMZGlOpM+7rR6IEKyYCjGYLnT11r3o3EUjOdWq1AljwVZhFY+c5CDHwYrB3JWsL9s9w1EhfqU+jm3Bf7MKiR0Bz6HyJL6gnnrsxmU7jZw2SJkGRbXm+jyyzsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIkYvDwXIQ8gDhZh0UDk2dGd0AMb/o3za0zyd0cBl+4=;
 b=dyY+K2OtkJ3GIELc4eIOFPREi/ynDnIHXKMACrq3xV5J68yliCqQjQ95vt7zt7m/Ee2uiS9sUnDB7r6zHo41tsaq8ahtUJQNKRR8uALiJNlBAu9a2dhLLf6pzEG48JGUUPIOJetDFCxBDHg37p98vj0UvS8AQGPgjVBLXBmUSUId08/fnVKJSJb8/8VyFoqBNyScDYlKjDz28IhD2FryM/yzcvqRHL4PyFPfetMe9rLHrWaf+1+n2rBo+z32AQ1K5zWOuYsmbXcoWsa8qM5w7uwu8B8+Uv2c1ZYRjoEyJ19ByWxNjr1XA7fAZiHL6E2VooEJ61y8kOupwERSwIHwWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIkYvDwXIQ8gDhZh0UDk2dGd0AMb/o3za0zyd0cBl+4=;
 b=BHHJRWdfrVZbYsF8AD9q7ue+Lf0Sbmzv9g7MAuU+y4j4iMTJD537nDYY+OSYAJDfhCh4USTaOJkx6fzQc34c3csGq542OvntAqqNpcPu1s9I9McU6vaT4GPoxjrthm9vTQ5xbZD1kNofgkR4avAgxfz+amQUMvELlXbdDlk8N5g=
Received: from BLAPR03CA0108.namprd03.prod.outlook.com (2603:10b6:208:32a::23)
 by PH7PR12MB5806.namprd12.prod.outlook.com (2603:10b6:510:1d2::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.12; Fri, 19 Jun
 2026 13:32:23 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:208:32a:cafe::55) by BLAPR03CA0108.outlook.office365.com
 (2603:10b6:208:32a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Fri,
 19 Jun 2026 13:32:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 13:32:23 +0000
Received: from georzhanmkm (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 19 Jun
 2026 08:32:22 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Michael Strauss <michael.strauss@amd.com>, "George
 Shen" <george.shen@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 05/24] drm/amd/display: Add 12bpc Color Ramp Support
Date: Fri, 19 Jun 2026 09:21:20 -0400
Message-ID: <20260619133154.116746-6-george.zhang@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619133154.116746-1-george.zhang@amd.com>
References: <20260619133154.116746-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|PH7PR12MB5806:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ff56168-f92e-4cc3-d2df-08dece0731fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: QB449Z0oPbjg+DtMaBec1QPobGcVNZ5uyNO16nSwCwD2C5pnA9Y1FCChviqnBaF0vOnDFCcTSYhntJHyS0emgrmw6dZRdIdKzhk59htTtUor0r3py95I2ErzJV9Ehil9DLcmv9ScoURu8Gyh/QiKyQt7/NrL+wL6QP4IDSA8/tUCLLS9y08RrXsO5XAGRohC/7+Q8PZRgy5VXZ0RwIf6uFhNEvR7kAIqcFSu0Xtsk1SGuwPBXNCVu2RQgho19wajZk0TE3j3Doje8giZpx8oZczu4kAm+5/tqFrXoZnav20VEftc+9v00+z45Fe8+IWHtIGWwpD2DVr9CACX7bQda6fQslkMEiyBig9j12yAJpTqL9F9jLz1xHHlgfwVKZOexasyVCIvK21VAjWuOdnW1evyK3eH3IAEO447kZibvShszDbRDv3WvA6pFgP3HOGaPCzbZZrGlUHg8lHHoDFEtxXZydxBMxZYV4k72jrW6VaE/Hhjih3+ZqUSIbakXKuiv9VU8WdvlRFZhQM32nXL/n5ZyjjrGC8ZDTueR2tCHg8P+WZYC5RYl09dWn5khr0/euOE7rlSZ4FcEnVHa7SRXKJlv2l7y4kh6F+7LPqFFd7G41Y9hAve71JlXjOVK87r/VcKT6uxmMz5q4YSeYFdmno5rShpvZoXaDheQOTY0vAjOP7dEoIW8FyyUltX9HgvEUwAksaeBWpMK00r3rSFUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: M2ESs+jTZX/oXEsvAeMHcXziG6JgHOpaLdCkDQqCaeZ0mgfRaRnXo0u+Em7may+NnminYy/CCxHPzGHDqCtbWKZYdbVTuF1qgZ8K+dji8tSHkbr2hgo0JiLUGOkUIHgXsyuwKsDAlubyY0l2ygGvVsSFFcrFzmoevq6iWxTv6mNAv7cEZY0B2Cudd/P2+2LLbeJA7NfC7XgdskrGaVNRrU3RKli9UyLk4ZUV5Em4RkZx/o0/CAq+TFOlsY1Kk/Bg7QiIkKE7FnrNydE+X5AeL8tdemEmt7niQkO9xAqwSX37KfhS1o27ywNZCyI/UhEzhqyxP9Bvk1Mboxrq5pl1AUanO6h7OllRfbHOYSIbprLCJ7rohFCCySr/mWdCJP/a9hnwj8fUOf/lVfMZurLknMwbVOZwyUGj4i1g5JY/47fCVVXHno8f6wvwUNlKnPwO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 13:32:23.1353 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff56168-f92e-4cc3-d2df-08dece0731fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5806
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

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
12bpc color ramp pattern was never implemented.

[HOW]
Add correct DPG_RAMP_CONTROL programming to match DP color ramp spec.

Reviewed-by: George Shen <george.shen@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../drm/amd/display/dc/opp/dcn20/dcn20_opp.c  | 33 ++++++++++++++-----
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.c b/drivers/gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.c
index 83730bbe26a8..50b6973ef123 100644
--- a/drivers/gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.c
+++ b/drivers/gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.c
@@ -149,6 +149,9 @@ void opp2_set_disp_pattern_generator(
 		case TEST_PATTERN_COLOR_FORMAT_BPC_10:
 			dst_bpc = 10;
 		break;
+		case TEST_PATTERN_COLOR_FORMAT_BPC_12:
+			dst_bpc = 12;
+		break;
 		default:
 			dst_bpc = 8;
 		break;
@@ -192,22 +195,25 @@ void opp2_set_disp_pattern_generator(

 	case CONTROLLER_DP_TEST_PATTERN_COLORRAMP:
 	{
-		mode = (bit_depth ==
-			TEST_PATTERN_COLOR_FORMAT_BPC_10 ?
-			TEST_PATTERN_MODE_DUALRAMP_RGB :
-			TEST_PATTERN_MODE_SINGLERAMP_RGB);
-
 		switch (bit_depth) {
 		case TEST_PATTERN_COLOR_FORMAT_BPC_6:
+			mode = TEST_PATTERN_MODE_SINGLERAMP_RGB;
 			dst_bpc = 6;
 		break;
 		case TEST_PATTERN_COLOR_FORMAT_BPC_8:
+			mode = TEST_PATTERN_MODE_SINGLERAMP_RGB;
 			dst_bpc = 8;
 		break;
 		case TEST_PATTERN_COLOR_FORMAT_BPC_10:
+			mode = TEST_PATTERN_MODE_DUALRAMP_RGB;
 			dst_bpc = 10;
 		break;
+		case TEST_PATTERN_COLOR_FORMAT_BPC_12:
+			mode = TEST_PATTERN_MODE_DUALRAMP_RGB;
+			dst_bpc = 12;
+		break;
 		default:
+			mode = TEST_PATTERN_MODE_SINGLERAMP_RGB;
 			dst_bpc = 8;
 		break;
 		}
@@ -244,9 +250,20 @@ void opp2_set_disp_pattern_generator(
 		case TEST_PATTERN_COLOR_FORMAT_BPC_10:
 		{
 			REG_SET_3(DPG_RAMP_CONTROL, 0,
-				DPG_RAMP0_OFFSET, 384 << 6,
-				DPG_INC0, inc_base,
-				DPG_INC1, inc_base + 2);
+				DPG_RAMP0_OFFSET, 384 << inc_base, // 384 start point
+				DPG_INC0, inc_base, // step size of 1
+				DPG_INC1, inc_base + 2); // step size of 4 (1 << 2)
+			REG_UPDATE_2(DPG_CONTROL,
+				DPG_VRES, 5,
+				DPG_HRES, 8);
+		}
+		break;
+		case TEST_PATTERN_COLOR_FORMAT_BPC_12:
+		{
+			REG_SET_3(DPG_RAMP_CONTROL, 0,
+				DPG_RAMP0_OFFSET, 1920 << inc_base, // 1920 start point
+				DPG_INC0, inc_base, // step size of 1
+				DPG_INC1, inc_base + 4); // step size of 16 (1 << 4)
 			REG_UPDATE_2(DPG_CONTROL,
 				DPG_VRES, 5,
 				DPG_HRES, 8);
--
2.54.0

