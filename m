Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5872CD5BCF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 07:15:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D1A710E4C0;
	Tue, 26 May 2026 07:15:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tlXqCFzk";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012034.outbound.protection.outlook.com [40.107.209.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54D9710E4C0
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 07:15:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JNwGY5XxvpOq2YZtOeJflIvUpApT7WIEShJZZuxyIAcUGmg7Fdw28A4/SKWrey8jOU4j4vFtRizwjqiAHca5bcBCcRpSuD8pHtbyZ7ISOQEUrtsvgte2TJvhG64QuPpwtB3+OYUpF8m/6l43Rlz9Oc4XdEzvYvYZcviyuyNBL6omdZGecLiwi1X/U7rQVDJywLIIXkSyNRbPrmRtxaYHbvG3xcYEGRAAmcakgdwlz72CAGVSCMrMiIMgFcXDkF6qXkEItcV6QbODfyhoDtSJRSoHWJk0tmxu7k9zubsoocLW7CYwIXDGvc2l1DfGE3wn1IKhvy0FDXZ3DoQUFx7WyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChfYKPrvNKot5P1PMCNPuOTxU3goAYALk1Qb3rvBGdc=;
 b=ZGyE3AvrCwk6xj76EZhqXM+dV4QUp0sa+MSFgGSXoNhDYJGdmc9uPlW2KPCWW0TD2SvgZZJRNv3iaI136g9eUwT9IsGJeGHbiFJ+7UqhMhiDwFckfntShOy0BNWCZ8vPQYNPAQsdMsmVM1gmkK420rOQpxS+oFpvCYCxrcBuVCIvpNRESmWEjgnFmv7+JOyG8HybwvfhSch3fggSHXxK/0WIt4m+Xdk7+GBQ2VRhILmBvENQbcvLIReVLj4eagBxNFGoN1U7ct3GALpqZchREQq3xK2qKIvlvdVp/Gwair99gNthBLrD+XX0laK6IwF521le/Die4kbtd54MGQ7ZBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChfYKPrvNKot5P1PMCNPuOTxU3goAYALk1Qb3rvBGdc=;
 b=tlXqCFzkbUkAWfwpwSln990qFWv89Pl6T7EVP6m8GnBF8vwWKnYlmLgdWmz/kjRUAIyQNtK1fJDYcUOkiD+IB0Ud0Ymnca13JxQjrkFXP+bL69as9bOa1tzrzDYfnUZnHx9HHpZaXc1K4FkPIXUPlYAWtY1VlFQuq8sTEl8vDHU=
Received: from PH0PR07CA0079.namprd07.prod.outlook.com (2603:10b6:510:f::24)
 by CH3PR12MB9122.namprd12.prod.outlook.com (2603:10b6:610:196::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 07:15:32 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:510:f:cafe::39) by PH0PR07CA0079.outlook.office365.com
 (2603:10b6:510:f::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 07:15:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 07:15:31 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Tue, 26 May
 2026 02:15:19 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 May
 2026 02:15:19 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 26 May 2026 02:15:10 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 07/41] drm/amd/display: Add DRAM table fields to
 clk_mgr_internal
Date: Tue, 26 May 2026 15:01:30 +0800
Message-ID: <20260526071413.2181251-8-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526071413.2181251-1-ray.wu@amd.com>
References: <20260526071413.2181251-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|CH3PR12MB9122:EE_
X-MS-Office365-Filtering-Correlation-Id: c6707c54-c622-4898-e79f-08debaf692cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|56012099003|18002099003|22082099003|6133799003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: nyF/H8j1tX7pexhL6ANyhc7pIWmVmL1x7By5B57rRCWz9YnXUvkbIBT7k1ON3lb9uidAc/7FkFRAED3hBB9cKEjmQyWJ6wxE8ur6LU623S9NGeyjsd3b9Z7aUV8CsqslNJbwhT6gdarBU7nOCzpk9Kxs+F+7a68BTFM61m7Vt3rf+klpqjn/ZpdwRuozjUD/5gOx9zjiOhrBuCN9+DmeA3o6BuquffzNlVEbwMNp48uOAAG0gVHxv8fTBDRnH2bajcOq7t+LLgVZHhLncmu5G/Az57MBNlyJXae7h0Ojdk6A1hp5oCDLpV1gJoPdqM2D9eAIpOs2yaJN3SgYeUTp5/fnD8UTIHST6+NiFnEUvlEsNX58H3Mr6+PuZPuh1cdyEvCpg4NLBbDGbNE1YFo/D0KwinvBgQNpuNXMcfRFKVpWOeSl4WY4JmNyEVfTRJs/ySHMHQJ0saeuwuTR1dEqq7Ck+/9Hy8sCWAUybtZHdToU4ug04djC9he9JvPH4SuXrQ88uQofZ+w1T0aqzv7tRvVqX2/hl3haD9FC4NPTsxTrpD5er37jjfAZUr3ISoPRqVPT47NKk3cSYXfV4pSwj5mizfMpMKrIrIk6GJpw2jjKJfljJbMD8ScR4Bog5aJFKh4B+HMOMxnrRuZ/ujUn/CppRAYOwHAG/k2mnOa7+t2UPtLwBh6XENYMNIb1xNjhbneFKfcxF0WWFDtJ9s5Ymeb7xywPl5XVgFxihz4H/RE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(56012099003)(18002099003)(22082099003)(6133799003)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YkjEdgQEkeQHUeT8LPBijoJIxICfO3rLWvAS8kaZ16b1BXyQ3cU6lBWmyOiA375rjGJZEjBic+0wSQFHzdIhBElmCbPPn+9AEC+93/Bu94pqjD8jkH0/bI9iL8Jza41suii9AekUKFlXHOxYXxqCy4Y4VKg0flwE6Y2g3nw7RbMFDLYN7Z6CB3cUk464DEn1HMnhrbM3jjFbikwkJcRWN0UQCB2NN9oa9f96HtBfax2mRm4zaLgurqbs8LzzS/9eYpedof3W+sNV6M0cJIvaurG+Gwg9PtshjStSRJnc/f2xhzBaECesH/kJkBMRYfE/fZkP8B6BvADKD7IjoLB7MNJnvFmqZooBYadAddPo6Q/QFStoeJlTDu9gtnjqM4Q8uBZBsBdGe50bUOzScX3j0qv4co6dk8ePhfR6CcidC5gZen2e0DLOhcdrPh5uYMCi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:15:31.9972 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6707c54-c622-4898-e79f-08debaf692cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9122
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

From: Wenjing Liu <wenjing.liu@amd.com>

[Why]
Add GPU-accessible DRAM buffer fields for bulk data
transfer from PMFW during clock manager initialization.

[How]
Add dal_init_table and dal_init_table_addr fields to
struct clk_mgr_internal for TABLE_DAL_INIT DRAM transfer.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h  | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
index 450bce3d8e02..6ed1011457de 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
@@ -477,6 +477,17 @@ struct clk_mgr_internal {
 	void *wm_range_table;
 	long long wm_range_table_addr;
 
+	/**
+	 * @dal_init_table:
+	 *
+	 * GPU-accessible DRAM buffer for the DAL init table transferred
+	 * from PMFW via DALSMC_MSG_TransferTableSmu2Dram(TABLE_DAL_INIT).
+	 * Contains all static PMFW data needed at init: DPM clock tables,
+	 * UTM QoS parameters, and memory configuration.
+	 */
+	const void *dal_init_table;
+	long long dal_init_table_addr;
+
 	bool dpm_present;
 	bool pme_trigger_pending;
 };
-- 
2.43.0

