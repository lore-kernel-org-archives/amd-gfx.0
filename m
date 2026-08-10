Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B1D7C5B56A
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 15:52:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9473110ECB0;
	Tue, 11 Aug 2026 15:51:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="foM8tPy+";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011030.outbound.protection.outlook.com [52.101.52.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA1B510ECAE
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 15:51:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AhFqWzbqj+54W3x6G+f1o14xZWgxLZAU6MSPHsPx+7k2VDe5hpG0KQhQUa/hcv02cPACuWQ/JknY7bc4ghOqeHU7XitUc0zTzBVDx7vMjs+5pNSgjQE137SUQUYMlkpeIeKxZ9qZAbt25c1bIB5Z0QKHKTkhLq1/u2hOlx0c3jn+h63rvYg6dqiPuny/KFuAVahDikE28JxH3RWTQUl4gQWDItvtIa1OATQle4ICg1J8SvEhEcuv5fYPut4uPtXhKkefXwEnCAgxlsfqyejdBOUZfU+4mxG7g0N4SKe6JJeJouIL+J0LXuyRtS18s6lBMvKNIdFkJybHkaE+xR4A4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1DL9CI1xrlii1Ea99KoHjjN14/XUmMViOiDNKM0mrY=;
 b=nBuM0Bw1Ahd3VFN11d35fNKS5J88sWKwHrFWacdAhnU+PRT2DdEoY6/N0DmfAUQsgH+E37eX3dPOJXjqRVzJJC4YhvtQDaWF9cGCC0po9Gmn8XTlc182Mo2BoGd80zxh6CJvX4FUQ41VkhnKw9lmOUtZZa/4ZroP/gNeuc725nha0EbWOtPkUyKdl4yZXhIXXjFn174cFRcHp/d2XIk0f0PYoliaKmSRBzYw1EG7Jv1t8r01IkCm1jNxWrgXADo7T3AM3YhRQ0S6I2XiCSd/oAFqJDAa/uy5HAM2dEQrvlvqb6N7aa6TrVvAaq9huttAAHnMeAwvSF1tXVhcTHHxAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1DL9CI1xrlii1Ea99KoHjjN14/XUmMViOiDNKM0mrY=;
 b=foM8tPy++GxuCu1hgzfyJMcKPMGnv8IFmm3SIM3CImWyC+JJHnjVBFInaOpGQhWoUXte4i+T9YCSJJVIYeuTXZ/QVKUZ71QrjS6wLh5i7FMTkC2N/HhcmyCBNtgSK4hTCgsH76OcmEN3lw7ld1uZJRDQqkfT+dE0EsQd8dA6nlY=
Received: from CH2PR18CA0051.namprd18.prod.outlook.com (2603:10b6:610:55::31)
 by CH3PR12MB7547.namprd12.prod.outlook.com (2603:10b6:610:147::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 15:51:50 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:55:cafe::96) by CH2PR18CA0051.outlook.office365.com
 (2603:10b6:610:55::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.11 via Frontend Transport; Tue,
 11 Aug 2026 15:51:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 15:51:49 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 10:51:48 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 10:51:48 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via
 Frontend Transport; Tue, 11 Aug 2026 10:51:39 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>, James Lin
 <pinglei.lin@amd.com>
Subject: [PATCH 24/24] drm/amd/display: Promote DC to 3.2.394
Date: Tue, 11 Aug 2026 05:28:58 +0800
Message-ID: <20260810213010.1703162-25-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810213010.1703162-1-PingLei.Lin@amd.com>
References: <20260810213010.1703162-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|CH3PR12MB7547:EE_
X-MS-Office365-Filtering-Correlation-Id: 67a1a64a-8dc7-4605-6eb9-08def7c074d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|6133799003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8+7xRXqat4WeWf+D34EZvlz0ufl9HtCUGZz6L/AVPUR/4zvEImuOMmZmS+94pXNx13cRyIJ2Wks/Lrl451n/gvGIy6pCT3iAACZ92L08N9jNcJcBpt21Vh07N+kOjG9qf/1N92lnl1XlhtWW6/yvbCm3wDrKqGGhw1lXo327rlp8ZiAcwGc6FOJop1lzRxYzz6kVs6qrvoxLDQIhblkt6RnE8tPqScfIyM6UmKAfHsuBOIBbJXTI8X7yfKJKzHWzL6+lArK/HfWovbJVdb4O4bySRy0OfhQIhykQpOpyxwfPMn7UhvF12ESeFZUela0wu9ikm5l04Hqc6DNDjm8wJABOHlsoxx7KOATUdi9TykIDpN4w1FFFYZSa1rHiRje7f9sB3lK7CrG4+Yj1ZYwvA/ATcbglwfLqe6oAnbj4AQVKjfeLrpyLJSAY7bsDfHW1r+EN7et9wQ8TJPB3idzgV/Tm9Fb/zTqsaBtIAg71RyGZW7KKiJ0GQazgQhnMzo/Log88W2CMXWqYGpuMDzSDH3sId0TYBvftzVO0L2ARu/tQRDhPWtofEZd5XgVH3HumyynfcsAdhyX7TNsm7k5tD/QrWqGiXeABMo6tGV/NqFA5P0IsKk8OpACZIZpe6lWc6a+grY2I7AsSfRYOokcFJhl+2348UfqVyVA5EZJKnsCHIxWudHHDqFElieLB9pLSSthTz9kZ0GyaLr9ziENcwA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bfUegGxNg+bBj5qC5D3WW9uEN/xGWiSo3ndjHY3tsP8JkAwbUZvQpCDafb6oqgbnMY8HAA8W3niXzAL5vXrt235GdJ3fi3g+G/4TRio3hCkxpRQZBEN+47fWey0ie5Lmyi3qBfynlnY9PBcWl4d/bSb+WU1z489uB5r2Ife6cljwdZBiIFEivF7G5pVc108BtjTvgvc7OHeqKZjVrBJXiGjL7elk6aia6MdUhtsp0e3qasV8pmh5Zox6nj+2KXv3oSBKT0NdZDFlCndNS25jWuzA2puxM0zdh0mbj/0EkVw/no0QD70zSiFa7T0NCFhLjh6dIopyH7qNQ+PeVvCrAgQjjK/ia422wwGBTZ/kCgPNWK/DvOa7vnPMqDbJGFQxX0uo+pSwBpBD2jSsgkyqLVFo+irlmMZL2f+j8uZzuNbavb+p7od4OWAkr7hZs9Pk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 15:51:49.8440 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67a1a64a-8dc7-4605-6eb9-08def7c074d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7547
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

From: Taimur Hassan <Syed.Hassan@amd.com>

This DC patchset brings improvements in multiple areas. In summary, we
have:

* Reworked per-DPM derate handling: refactor the per-DPM derate logic,
  update derates with default per-DPM values, and move the
  soc_and_ip_translator onto the new per-DPM organization
* DCN6 mode-support and UTM work: opt-out for the OutstandingRequests
  check, a utm_support capability flag, and a guard against an empty
  DCN6 UTM QoS table
* More DMU/DMUB offload: send DPM0 clock values for Z8 retention, allow
  DCHVM<->rIOMMU SDP port disconnection on DCN42, and add the DC_BLS
  command
* HWSS block-sequence cleanups: move periodic interrupt calculations
  to HWSS, drop pipe_ctx from HUBP_WAIT_FOR_DCC_META_PROP, use mpcc_id
  instead of the hubp instance, and add a wait stream regen event
* DML updates: unify CalculateFlipSchedule logic and relax the frame
  size limit for the dcn5/6 core funcs files
* clk_mgr refactor renaming carried DCE clock manager functions for
  dcn10, plus a missing-prototype build fix and a static DCN42 SOC BB
  struct
* Expanded IGT/KUnit validation: CACP ACE curve area debugfs and cursor
  mode tests on disabled CRTCs
* eDP fix to skip teardown while a forced PSR is active


Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index edd6a113cfee..1355ce2b4970 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -66,7 +66,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.393"
+#define DC_VER "3.2.394"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

