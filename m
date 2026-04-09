Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5BFF31E28
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 15:04:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27AB410E818;
	Thu,  9 Apr 2026 15:04:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ULUqOcGR";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012032.outbound.protection.outlook.com [52.101.53.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C92710E815
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 15:04:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qLgbNXvBYtfrcufBsg4oRw5ZgENYXLzF6rXAc8GFjx2i/9m4wTSJI5QHnLMTiA9R7Uv7mcxYfiyrLhQykCzHTaAFlqgGREBwZyW4xldR4TXXs7GV++m5ZxMmp4Rnq6RGS3qCNnJW4PWAyREyscReK11W+OkEF17VQhZQBnNxXC5Z/XJorGhyaCzlz9r8cmPjW0oQOvgyICswwJYFQKLngYSWbXN+iucSAZFCuknm+fXANe4ZuQEcfrdRI2Cg2e+PFe54xzKZtU/G0/5sBBvxX0kXvRxb7jnxKmqrBJO+SEh86tjU1RvBlGuMGxuOHahhWfLg19ZLK4wEMJlF7JL7bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJHRJvomZWx81CaYNyjRCvOwm9d6o8s025UAxvgOZuA=;
 b=O/a7PnGUW7BVLM2hiP+jnw/B9FnfPRRBDCAjhEzgl0j2EJbSTE2pTd04wZFC0ytzyIkxOfrwGAQpMwWv8FY/5E5OaTVxG4kLfK1nF1NAYBWYnXY8L9QMA2EksvNhr5+DkVptMYQTTvtjJZfdoDtqAWVzSQyNTX4RN4PuNAnmKKvk+rA6t4/+Dz2F7TYSPOzy6IHne2RFgHw8yRaofc4/nFr2MajO5qITC8huDd1rhAzZhzNSwtPEtll9rfp/iBEF6zoy0m72TqSGayX7SngBh8qy+fRZfPDME5nqcSkhsyH8WetjeatIXSbLl8vBgqbIJeF2xkl3JBBKerYII3r1Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJHRJvomZWx81CaYNyjRCvOwm9d6o8s025UAxvgOZuA=;
 b=ULUqOcGRey1CWrLI8z1Q68giXlvzmM6H8SfYApnaNWUqrL02/9uSW+Pv9PDA44AynMNYC2pxc9OUsb8SqJCN1d3lrcMwPjE9twRQL0Q30mEfIhWgAgEGglxMx3oBphFVgVtgX21JJIMte3EXr1vh7LuVxsvKPaD9z73woxOHyPM=
Received: from SJ0PR13CA0040.namprd13.prod.outlook.com (2603:10b6:a03:2c2::15)
 by DS7PR12MB6045.namprd12.prod.outlook.com (2603:10b6:8:86::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 15:04:24 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::cd) by SJ0PR13CA0040.outlook.office365.com
 (2603:10b6:a03:2c2::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.37 via Frontend Transport; Thu,
 9 Apr 2026 15:04:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 15:04:24 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 9 Apr
 2026 10:04:18 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 9 Apr
 2026 10:04:18 -0500
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Thu, 9 Apr 2026 10:04:17 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>, Taimur Hassan
 <Syed.Hassan@amd.com>
Subject: [PATCH 6/6] drm/amd/display: Promote DC to 3.2.378
Date: Thu, 9 Apr 2026 11:03:14 -0400
Message-ID: <20260409150413.34779-7-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409150413.34779-1-aurabindo.pillai@amd.com>
References: <20260409150413.34779-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|DS7PR12MB6045:EE_
X-MS-Office365-Filtering-Correlation-Id: b14c3299-9903-4b9a-5680-08de96494999
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: CY+/hwrxxpG5VstHCm/VNuDgVwthDlWA41Uamqk1q/9LK+cb2odMmhv56xxbAYjjNZD3JvsBDlyYFDVzScOg2iKr9+gXNTEOVLb1ZZuwxOM3uru51aAxA8GfVpQJvpk44Xm3bF/ZZz7QHab+INn5iIqYkigCNr573PDx3lJFAIdbeRoCD4w0NBmIvsDpRqI9uFH+MeyBjXQhTQgxrfxtc/78ySBLKo9+w1SSJ+o8HdpRnBk0idkEnpR6NLbYM8L/7ogLUxLVkTVrIXzsJHjDGOOExoXwBPHQWVot83nbufyQEg8j7mLO1OMPSTwH7I2/SMISSja9xTxvXph50/9/1boe/KigYLKgUc8XNZXbq0SiKKLdK2BPxa9yv9HK9dI0rpAeAdFkbok8QPYEIZr4IGDtSgVe5Dq8Bqz4VD5lcmqqhIcHygNdL9GHPDcxqeuwxcYAYUk9tmHge4Wl0F9311ofigdya0Q00WkC6zu4ns4GUB6fDYmfP7VHbl9onEdIAy0QWQ0++siAyY68O1Y8mEMouNA7S0BEd7P/WutY2245kkpcziltsBBj7LS7FqvbY5EGR12zdlziVX7Qf5UG1pZpG+Ib3++6GS66JP28SomwysEC2PYye/eLwU6YpHedB3HyCSWp1pVmeZh+H+bERkMQTJ1abofGjvJz/HT31UX+LfYKuYcvcAzlKfhGf+SAg+eVdSQby+nzd4re6t1baE4gmI8ng/5hMYyQ/11uJLQAHRPmqL6Va2f1sOf1lPqPXscjAJQyzP5InERWXtVTGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8DgkNSUztjxAhQsadIrWkGwb4hCwf0dtMjxsXjy1NPxDuKOmTlTzyXFSUlWlgMYt3HtOMNmHneFGqO5WgItuozL5YgYG3Vbm4Z+AX72JWh9yw5VkvLOMdipuQ/lJqD6taa2f/4SC1yc40oPgQ6SS/a3/X+oaSkskUEMkhUnIpwK4bSgwK2EXULK2r16vbubwz3sht+YdpKBhnkC73BGzlt5sTqlVEZmgprEYYNJ5qQ7rAsF6w0yeSpSI/nHgwalIQdXKDIdHwjC59HP9VHL/jHeEaFep2XLKBsDvZatDq0YuBvlmMiLu/mgLQ2y1KN2XprzMDHedLOuUex5ZTDbtBvA2rtUYqMnwoHDvIcZxqDKPOuqilUhpz0am/3IHZszGqc39HHb6SnErD6/qWC/mK1XtrI/Q6k4cd2keMN76pHL8CwfjyLzQMkbzxb/Bk0S7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 15:04:24.3644 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b14c3299-9903-4b9a-5680-08de96494999
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6045
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

DC v3.2.378 summary:

New:
   - Add p-state schedule admissibility flags and frame-time utility

Fixes:
   - Fixed incorrect math_mod() result due to wrong variable in fmod implementation (Cc: stable)
   - Use overlay cursor when a color pipeline is active to avoid incorrect rendering
   - Constrain vblank_nom to bounding box value instead of entire blank
Cleanups:
   - Add const qualifiers to watermark params struct
   - Fix C4242 narrowing-conversion warnings

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c94e532ac4a4..7f55ba09b191 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -63,7 +63,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.377"
+#define DC_VER "3.2.378"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.53.0

