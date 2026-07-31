Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C69C55174
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 21:15:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DD6010F3F0;
	Fri, 31 Jul 2026 21:15:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SRkj39mT";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010042.outbound.protection.outlook.com [52.101.61.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CA8310F3E9
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 21:15:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sOWsQSOQ5B7DdOfjrcmdXME5MMM7BkClEUrINEu0rjEsKOtsF3Y7krZTuoLs4RMa1ehZxnWHfK90LUbnxkNf3B7mbShW1beb3ioCyZ/X4NsRVm9NDRB5VMzqeGlX5HUFDW+DInCX7TYXHAmW0QUd9dfPSRmMpBPsgISf2eAFsPjqf2en50SDYB/ygbjKYx9YJnyICGc5NI4I/T6q+94AEXf9k0031Gx9fcqj+OsExON5+liTQNqmpL2vK2ZDOLbJ/gMasEU+rptKg6p0m0+3LqVnpbJ3Th/bx0yMANnjCdjT08avfgSg049VtOFQZM7mBi8nVgI3IxXNUe1fn8EEng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+6Vgr9EBwyuQ29HKcwnznMbiEHiQzXDSBSPhak725E=;
 b=n2f1vHQxeEWbQ0uIVAPRFJKcvPi4c6WDhRstDnU8S86D6txlaAx3M4jYXwSpR+g5zH9scPK1Kq0vS+73H5DxgOiGCdzQBbpM0Bs27tedmBO3STZwvahLI0oqWRqzCTqmaSE0d5dmsmmfyFYuAbDUhFSDrMWNDgy5gboKeXSTc5+2G40qu9HVgNVMSuieuI3U0JsrG9ZPtrNCNdg3ruVbxjW2yf4ZcYMXMcSMQWXKVNhU+2B+7YIXVfjIreyAjehUmNTvYIgu2GnkeTvQCKnGLxb0JIZdRss0BJUbshJ4aoZNwOnaf/4vEmd9D7lveEY/UvWBDooBT7IVNtGdEYNbiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+6Vgr9EBwyuQ29HKcwnznMbiEHiQzXDSBSPhak725E=;
 b=SRkj39mTAP3MFmpVaSpHbPNyUArsVsSK1LzOWiKv94pprjBW+SzBZ2kmBo0lcXcw/tV4ggj713vm+FSTlYZ5OjZPT0v5XKkf6+7RJz5WLAu6qfWnAXk2d527zPr0/Zx86RGz/kEe/0z9NAKBBkX223vr0frjOw/vwEv4lLImPno=
Received: from CH0PR04CA0017.namprd04.prod.outlook.com (2603:10b6:610:76::22)
 by DS2PR12MB9637.namprd12.prod.outlook.com (2603:10b6:8:27b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Fri, 31 Jul
 2026 21:15:32 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:76:cafe::5e) by CH0PR04CA0017.outlook.office365.com
 (2603:10b6:610:76::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.16 via Frontend Transport; Fri,
 31 Jul 2026 21:15:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 21:15:32 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:15:31 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:15:31 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 16:15:25 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Subject: [PATCH 06/41] drm/amd/display: Remove duplicate in tests/Makefile
Date: Fri, 31 Jul 2026 17:12:27 -0400
Message-ID: <20260731211302.3040343-7-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731211302.3040343-1-Roman.Li@amd.com>
References: <20260731211302.3040343-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|DS2PR12MB9637:EE_
X-MS-Office365-Filtering-Correlation-Id: f17e5fd1-0c89-4725-90e1-08deef48daf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|18002099003|10067099003|56012099006|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: ++ZRDiHH6C7ScLFRYwES3yChbwVt7dy5tq800o4uVFD1CChuCP3B6hjCQZlhSz0BEgV3zdE70O6/MA33ZX2ITw3yWx/BOH5OqZhUO1vBdGFhOOJAWIAPYqM24tk7PgxIVTPZ4JOz7qw8jjWEg78QvrhyRRt3UEQ4XgGhWiNALWcUNNO3/O93pO9EUNuk7KiCrSM8kyDCksTgd89fJzIDJGj61Z2yOT9py10wIdE9mnQYOQkV9x5JWeRLFreZDU6Dm5YekMY8ouy+hQrgISgipUsFSPuWSakS7bX5+wvO9q4oCJsozyLn+O9RoFceYzTS6WwSnUYcdbSPhgnKhBBkOupdDHHgc0PTdZIw6rNPoentdlitvE+PU1Eg5SA2uHr4ZGomt6shbx3hzJX0ZHJeZwMUjHia2TSTz2RpD2QnJwhILWGN5WX+nS4HG1HEAdId2PuAPjwB6b/WfWRnpms6y1Ffnu+NXHSAD0w8dMnAMmjYcVsisgJLBIxyQkghb1BcpIKAqGVKZb8Q3ami4/+moEvEwP2zUSLIDeTKbwADgFsShB2QKHWXMaiCv95fReUkfnMg8Io5gTqa6e2wKW0MQll/R/4STGNND+caFTy+8dVxLyD3pUpHTO+RAVEU6E/NB8vgpq2sy5PbaZpIdi6ge3/N9M74Qk1DQF6BrFGEElfeKXTNBwP1SaSVauwi1SXhag+IJqPmo148xEZK+ureRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(18002099003)(10067099003)(56012099006)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RUw+H1iHwzuOnueUapDveqiHC+M5ZQbMjCYn1eJHp4MvHiCmcgCWS20oiTZUkvpuB0pAKAzMxEqAk9REvUHcMD9R+GsMCrBhI6Fs5+JPI6VSStBqmDWS3PuLhAOQ+NhN79NcNCI1uJZpXtCoOVwrTZJgiqyZqqVPr71l6/0P4IwJfW1hWV7FQnhS/HbhGUyoM9tuVBLo2yETqFfrw0sN13KEnqj48rCLIBP1450s4F02bHLl1Y9JKUC74dk+wH5owBSHtRfisj/afvV4VAufPW5WjMlxPzyYuOn+LayZM1VtPzZ74LO3FvvEsCf3srLIHFHq5Mp2eRQk9D1H7D2rpnY24Gwyfa0NCfU5lgmB3qV9B+kX8pjj7FQ6iIHQLokLlHsxdQ2Dq/uG3nfdCFWCy8kq9MNtksPT7XJCyhLO+vYMYlxagArSzmfSBPSTLonO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 21:15:32.2709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f17e5fd1-0c89-4725-90e1-08deef48daf3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9637
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

From: Roman Li <roman.li@amd.com>

The duplicate amdgpu_dm_plane_test.o entry causes linker errors
during the arm-64 build.

Reviewed-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
index 3a51fccc2a5e..616881fcb9af 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
@@ -35,4 +35,3 @@ obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_crtc_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_services_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_helpers_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_quirks_test.o
-obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_plane_test.o
-- 
2.34.1

