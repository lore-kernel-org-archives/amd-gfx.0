Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C9CF3D5FE
	for <amd-gfx@archiver.kernel.org>; Sun, 29 Mar 2026 09:57:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7CD210E42C;
	Sun, 29 Mar 2026 09:57:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N6zon90T";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011006.outbound.protection.outlook.com [52.101.52.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D894710E341
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Mar 2026 09:57:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFaiUNayfi7UD/f+41r0v+TTsvCEjrotlmw2Fi6WIyE4qoD7GM9ugl9dKMTTCdLjYVm4KMneKbPVF9Z3mMRHNXFEKui2KzJDlGECffGNWMd1jCVMoyo1jUMmukejqnxaH6AHlB5duoPX0TeyaOEMM3rtSW1q5qPZCvn9Ylm+ehQ73EBeKxuMTBgfI4Q+SNhIwxekFDm1YEqbFtbEOuNTPbqJjTrNUgg+ve8GUIIQYvIUiQDOQphQmEks5hBIPoPQePe+Kls5xNdtak7HYuGzJY2Uvn0Js6BS3J4T/V6q0sk5BQ1Cwh8oeZZLT358arBM+z2VOcjJ2gG9Y6GWX+LmSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IhkYUuFEAQmrxw9vU14Gyeu/fZ+83mJwMya/QCr430U=;
 b=Zz2cjwR+Jt3xSXqcly9H3G0i6/q5/W/bc6z6Wai3t1qw5TOoSaPuSiL5Ld1CCyRa7O94/AzAb0jpb5habxHq0t93kjGC0oExdUjT1ykvdzeZ2CXLmZYgRF3gHT4V1igwrP+9vlrayUzebv6oVzs8GogPRMiz71jIN8rlw+EcKXF9X8Ol3oyeBqZFYGZTzTvulc3TyjrsoFj7zb3mmQJUIW0fTRTGyDmuvbCbcqz4DXGdLZ4XNdpFLEMXQFhLCu6rTMGALJZ2HjD1jFdy2PTKqSGq5rbY8Gfvz8U9SvwbDLtubCwf2nTobvWf3KCreswRzDD3FvvtdTh6GSxq5B1Kqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IhkYUuFEAQmrxw9vU14Gyeu/fZ+83mJwMya/QCr430U=;
 b=N6zon90Tv81g3mlZQ5SiwDc91Oy4lBq64HYNaDa6/3KVvDm5EXYXdcjIccyf8dXO9YYoBlSguOruPkSBMDSPQaBJoLlbn9JmMCTBMNu7DJUvpAGo2GK6YvsF7SL54GQH9zbASS3mh+7Z/KlRKUN9I71n5a0NQsE8MiS33wYu0bE=
Received: from DM5PR07CA0053.namprd07.prod.outlook.com (2603:10b6:4:ad::18) by
 MN0PR12MB6199.namprd12.prod.outlook.com (2603:10b6:208:3c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Sun, 29 Mar
 2026 09:57:09 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:4:ad:cafe::28) by DM5PR07CA0053.outlook.office365.com
 (2603:10b6:4:ad::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Sun,
 29 Mar 2026 09:57:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Sun, 29 Mar 2026 09:57:08 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 29 Mar 2026 04:57:05 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Ray Wu <ray.wu@amd.com>, Leo Li
 <sunpeng.li@amd.com>, Roman Li <roman.li@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Mario Limonciello <superm1@kernel.org>
Subject: [PATCH] drm/amd/display: Fix missing parameter details in
 amdgpu_dm_ism
Date: Sun, 29 Mar 2026 15:26:42 +0530
Message-ID: <20260329095642.2131849-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|MN0PR12MB6199:EE_
X-MS-Office365-Filtering-Correlation-Id: db37a6a6-58aa-43ae-9f08-08de8d798a75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: udoLHyDJtp+AzpGaxPWtYpPJv43ouNe5daTV9mGy/dqSDKD32S3ua77LpGXoqr/UyXI6+p3uTTqqhYlp/oUoPMxaJEWlrLER8taBaCSJniByM3qwkgJ5TLxCIKqdJ2DxbFIoewuwjAZNMePlxAeZHa6/5COKuhaVSYvXc2ZnWnaz6jmc/FpFPyahhRhmaHraHyIdlfO9yzYZ50F9FtHdhFb8auMWQ2N8w+eG3CLEKQz62UH7Qgy3kW0/gIj7T7fbKksPZqIDYBMNla0J2LEhKjzcTFAqQKKzGGwNJ9KuuIqOikql7i/OEqFyBHC/zmY+Ul4UslxQtFwTZtD1e2zfg4yIjVX8/TVpvS9FvR2rOXm60cmf1kw0WFFrH8ztlO7NhoHe45w0Owy+qCEBYYLWZktoe6AIgOqeWkpeG/48ce+Wq5EgJ6SCHdOvOIs1FNwaUQ/XlcLl7gOvv44KuaFPaIeSn9PtFpbnyTJahfUcFf4fj3T70oajeMBnvbFkHtHrUB+Q+WO/uuGmZ5z9ajLshk3WAFKsVLhHEHWMAcLs10Y6eYnIAK8wfMNQa6rYHNY+QHF73JkiLvJs+Ej7xYTuggLbpTYSgngWajavJQfp8w/C55++tou02thPSdT8LOoK2rt9A5HdNNsll7XSOsdyXCr6ocJNmLLag9/634E+MJSr41cY6z8wKmZOqG7Eer9qSTsuMjKmFTzWS/esJJ6vMLE9Ar/Dg9NgR0dompQ0rvd75TE8Avxbf6P9/gwhWLdRh4ghXbiPu/igrXB25jCshA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KaReoHcpvq9qk6YNUvzDA+CwFVOJ2vhXc4zy6RluoB/8L5YZDEAsSuHAWRMZmZ2HoTKnntnWYtuPz/hWWJqowSUHyxtNtTiLzZqgCo0UglOb0xvysgJHq9v1SzoOl2fnt7aDmFwRgxcMAQqTZfeMaxExMQ5L1KSkXVTkD47SZ1SCJ/Dbn3pWLvYx0pamT0EpFZG24Rah2LwUBKkGEXn+QprRgoXRgFUOPlSs7m2iHxs8o01TBHSZk4yM7fpEodFPinTSDaWKrzNEPjPiid29P86BF2mYFgtgHg2mqdyHdtZiBu6WxMcU82xbnONT8IOUduGw44sQfm2xqjGkVM9oHFeUEaTri1FxqGASerlmLLrsYV3qchwLMbODG9BWLJlD4maSt9hYkucHvNF/IvGNuPgCLIUgHQW38+1gIYMe3MnyfqHYG3qth97u5ex3jwSt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2026 09:57:08.5829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db37a6a6-58aa-43ae-9f08-08de8d798a75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6199
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

Update comments in dm_ism_get_idle_allow_delay() and
dm_ism_insert_record() to better reflect their behavior and inputs.

dm_ism_get_idle_allow_delay() computes the delay before allowing
idle optimizations based on history and stream timing.

dm_ism_insert_record() stores idle duration records in the
circular history buffer.

These functions explain what they do, but they do not explain what their
inputs mean.

Fixes the below with gcc W=1:
../display/amdgpu_dm/amdgpu_dm_ism.c:44 function parameter 'current_state' not described in 'dm_ism_next_state'
../display/amdgpu_dm/amdgpu_dm_ism.c:44 function parameter 'event' not described in 'dm_ism_next_state'
../display/amdgpu_dm/amdgpu_dm_ism.c:44 function parameter 'next_state' not described in 'dm_ism_next_state'
../display/amdgpu_dm/amdgpu_dm_ism.c:153 function parameter 'ism' not described in 'dm_ism_get_idle_allow_delay'
../display/amdgpu_dm/amdgpu_dm_ism.c:153 function parameter 'stream' not described in 'dm_ism_get_idle_allow_delay'
../display/amdgpu_dm/amdgpu_dm_ism.c:216 function parameter 'ism' not described in 'dm_ism_insert_record'
../display/amdgpu_dm/amdgpu_dm_ism.c:44 function parameter 'current_state' not described in 'dm_ism_next_state'
../display/amdgpu_dm/amdgpu_dm_ism.c:44 function parameter 'event' not described in 'dm_ism_next_state'
../display/amdgpu_dm/amdgpu_dm_ism.c:44 function parameter 'next_state' not described in 'dm_ism_next_state'
../display/amdgpu_dm/amdgpu_dm_ism.c:153 function parameter 'ism' not described in 'dm_ism_get_idle_allow_delay'
../display/amdgpu_dm/amdgpu_dm_ism.c:153 function parameter 'stream' not described in 'dm_ism_get_idle_allow_delay'
../display/amdgpu_dm/amdgpu_dm_ism.c:216 function parameter 'ism' not described in 'dm_ism_insert_record'

Fixes: 0b572a6bf04a6 ("drm/amd/display: Add Idle state manager(ISM)")
Cc: Ray Wu <ray.wu@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
index 65a5cfe1e106..a3ccb6fdc372 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
@@ -35,6 +35,9 @@
 
 /**
  * dm_ism_next_state - Get next state based on current state and event
+ * @current_state: current ISM state
+ * @event: event being processed
+ * @next_state: place to store the next state
  *
  * This function defines the idle state management FSM. Invalid transitions
  * are ignored and will not progress the FSM.
@@ -148,6 +151,11 @@ static uint64_t dm_ism_get_sso_delay(const struct amdgpu_dm_ism *ism,
 
 /**
  * dm_ism_get_idle_allow_delay - Calculate hysteresis-based idle allow delay
+ * @ism: ISM instance containing configuration, history, and current state
+ * @stream: display stream used to derive frame timing values for delay
+ *
+ * Calculates the delay before allowing idle optimizations based on recent
+ * idle history and the current stream timing.
  */
 static uint64_t dm_ism_get_idle_allow_delay(const struct amdgpu_dm_ism *ism,
 					    const struct dc_stream_state *stream)
@@ -212,6 +220,7 @@ static uint64_t dm_ism_get_idle_allow_delay(const struct amdgpu_dm_ism *ism,
 
 /**
  * dm_ism_insert_record - Insert a record into the circular history buffer
+ * @ism: ISM instance
  */
 static void dm_ism_insert_record(struct amdgpu_dm_ism *ism)
 {
-- 
2.34.1

