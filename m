Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A179E7718A
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 22:54:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B044E10E9DB;
	Tue, 10 Dec 2024 22:54:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4FFeIqXH";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10E8310E9D9
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 22:54:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mtu3YFxoi8BWfiOzy40Q4C2XiLc8V5x/1lNUmfcTSM4G7SnLOndQho52veLz2QP0CDi7WgyrTZnkrpspnI++s4HRPMMyB7YCsZ+8AD8Zh7EdzceXyfzp3QoeqTvlTN9sKLkWT4Y3ymQKSNTkPtK/R0hVRPflrYhcBCS9kyrY39pJUnTw6v2eEeC47ttVK63a0jlHAnY+rscbZ8cd7dmyYSN2EwLGn4BMtGJ+X7aZn5Bgsv5eY3ARZQoYcNIDQ01uNXnwDn81SHwD4k/XNAWC0OEy29rutjzFVodgn7DxfVYVcQrU1ZqihtWkPub6XSwLWiHsjKEWZ/D8sgbZOo3GoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGva5j8lY2Wsmaq1gAvjApOniFGQTw5PVcd7CIvDF6g=;
 b=SevsKEUE6QyY/YF8WmFfZhOl+UArum0aksyCUJoVpMCb/o27dLGrRCa5EUHHlD/9eiDrklE01T+5z261Rxwsx+qgthejNtor0Y7+gqDDPZmOc83A1T8Tar0KPgXRrsh5TR6+NdWtheKAYHfvmF9/Q3kBYZwokZUnczQWO8uGAHIKxY8BtwsJcH1HEpKJOjEjTpBAju/hsTB6mO8uDbHNHGMAAyIp+wWy/GkL64PkepI/gMyb45uGFGAmFHrA6Uzzu0fxMD+7ICIKm+WDknaC8fiDhr8AIfegoOMuKHDSqFnvtDF/aZiHTVFcz59n10gHoWZGUk9zw//FNdam9aCEIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGva5j8lY2Wsmaq1gAvjApOniFGQTw5PVcd7CIvDF6g=;
 b=4FFeIqXHsN5JzoIC9n0N9sI1kegLOtQ1oFQ6tNQboNG2WKmdVybY2YfdunSDLTQo9bs7IClplz4XszPEUUz+L7C/WmuCx4uqx5v1FlUv2+G9y/a8EVdv55MVoSJYlPMuFP7oz8H1Ka7y2RBXq97EmQfZhcqIlIRtvKakq8x4Sn4=
Received: from BN9PR03CA0230.namprd03.prod.outlook.com (2603:10b6:408:f8::25)
 by DS7PR12MB8372.namprd12.prod.outlook.com (2603:10b6:8:eb::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.14; Tue, 10 Dec 2024 22:54:17 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:f8:cafe::fe) by BN9PR03CA0230.outlook.office365.com
 (2603:10b6:408:f8::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Tue,
 10 Dec 2024 22:54:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 22:54:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 16:54:14 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 42/48] drm/amdgpu/vcn5.0.1: use generic set_power_gating_state
 helper
Date: Tue, 10 Dec 2024 17:53:31 -0500
Message-ID: <20241210225337.75394-43-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210225337.75394-1-alexander.deucher@amd.com>
References: <20241210225337.75394-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|DS7PR12MB8372:EE_
X-MS-Office365-Filtering-Correlation-Id: 52bb67fd-d493-45a6-b1f5-08dd196d93af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Xh83y49P+PDwSJ8eAEDhkwx7f1epihh3VngiFhM8tGR+nXnb7N/lhjNKyENY?=
 =?us-ascii?Q?9ANdR92aIx/0J619Zr3URmc68as+8hd2MtsZfVfvzByC8RX/mB5ox5rBfSui?=
 =?us-ascii?Q?mHzE76L7fOhtgp4+yIow6jCnkhqhY/5bGkEPiaYIgbiGVm8yjj1voLO0c80M?=
 =?us-ascii?Q?ZIbW2NtQI4B4vO9w/g+pqXFrZ3PrQLaZBGrSK9AQTCMVe7+ZGtfQNe3o8vGL?=
 =?us-ascii?Q?d+pDB1Zss70l8jwIrMbfb7PsadzLhJJhIM+uyMZN8AFcVxlioJ5oBboqsd2K?=
 =?us-ascii?Q?ZrtksHrqFx4q/xPfirk0BC41xqx2N5EfgQ/LpWcqovFsSmER6tQ1sGb/0U+u?=
 =?us-ascii?Q?Z7ddGqfZjl5O86XZ8K1MBNdPMoLtY1npmAm8rRUC+wfQbD0K7B+sqC5V2z9j?=
 =?us-ascii?Q?pJPczrb2ZdnTFqFtyy9ruAU4GbuHaJDhpdya/12cA53lMmVqCGEOzHWnU/eV?=
 =?us-ascii?Q?lWfhGiD6bu6B176hMyWCsj5QpY62+8EBcio8Vd+BU+a8aAApw8iCeGk61EF4?=
 =?us-ascii?Q?GHP7bVlPN8rrroXs+RvlfkjNawUgS3FLGMrzdZGCobJFku75EOVHpU0XbJ3e?=
 =?us-ascii?Q?Wfi0XJS4fP+KawPnBOyAxErKbZMarQBOf7+5lGdTKlFNxE/ER5XA+sZ5v+GC?=
 =?us-ascii?Q?HZIZKyeLyo96ow9b5JM0kNhYgIjYJmHD61D0gpCBrAhVA/ADcpK69XKrtqz0?=
 =?us-ascii?Q?ezCBfhUqmL8yWvqRwS1kdIbBhrsWEqtgrFksftA+jlOgoQOgIUGzUTwEH7Sr?=
 =?us-ascii?Q?aRdSS6Mq04gMbtuw5ku2qjX9jcUPX39wYi/yIrfdQKMYtGbN3mNWXuAOU+HX?=
 =?us-ascii?Q?tEUiJp4Pp8bLtpJqDEZOTgh0Vw+Brlnd2pA+fTmvbqULKv1h+SLtE+ENsEdS?=
 =?us-ascii?Q?HD7CQNJg2xUmjWtnUnlO6kqpdGkq4EiUsHidmsBvrEnSvQXUnafMZf48Xlpc?=
 =?us-ascii?Q?PW06Sck4hvXuw9Nh8Hz6HubgzBjwQHZqCNnfl6nRBVBFLvgBMwhW/LJZBMXu?=
 =?us-ascii?Q?KCMdERdXywXvmFQDAGgLUie+4f6MM5lsiiPZh6JxS3nWUXjhDVJ7zT/IqVmr?=
 =?us-ascii?Q?79ZrolfQJhQssjWN/Hh28E/1pUJg7AxBEnOIEBjaHjQxJXUfUj5Kov+ftQPR?=
 =?us-ascii?Q?Q/3WIWhGz/KEEE6HRNjlqiaRCaQOwg1/SdNRrWmsbRfjiIiwGNggFMJTK6Bb?=
 =?us-ascii?Q?EZcCNyKcX6CxpHcKumYWYwkN0BwF9LwtEY0TFpL2caxi21iIFUSc2dFRx71S?=
 =?us-ascii?Q?Rb9ZhTXCNCMMgOPYQEujTcOzUApb8WUi+JEnJADWkF0+gCHUsui45p6Qi6sW?=
 =?us-ascii?Q?APCdKIVhck71Kr8LuDo8ASaM/i9C+v8f6YArEJY4B38LcNbe2TMsfEVqxqTk?=
 =?us-ascii?Q?38a6I0xtCnteHFgQuv6FgNUwQSvDyyi3XYjh39b7R9BSHfz1AA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:54:17.5591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52bb67fd-d493-45a6-b1f5-08dd196d93af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8372
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

No need for an IP specific version.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 27 +------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 586cdef6f663e..bd79d88c9ed36 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -42,8 +42,6 @@ static void vcn_v5_0_1_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v5_0_1_set_irq_funcs(struct amdgpu_device *adev);
 static int vcn_v5_0_1_set_pg_state(struct amdgpu_vcn_inst *vinst,
 				   enum amd_powergating_state state);
-static int vcn_v5_0_1_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					    enum amd_powergating_state state);
 static void vcn_v5_0_1_unified_ring_set_wptr(struct amdgpu_ring *ring);
 
 /**
@@ -1051,29 +1049,6 @@ static int vcn_v5_0_1_set_pg_state(struct amdgpu_vcn_inst *vinst,
 	return ret;
 }
 
-/**
- * vcn_v5_0_1_set_powergating_state - set VCN block powergating state
- *
- * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
- * @state: power gating state
- *
- * Set VCN block powergating state
- */
-static int vcn_v5_0_1_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					    enum amd_powergating_state state)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	int ret = 0, i;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
-
-		ret |= vinst->set_pg_state(vinst, state);
-	}
-
-	return ret;
-}
-
 /**
  * vcn_v5_0_1_process_interrupt - process VCN block interrupt
  *
@@ -1152,7 +1127,7 @@ static const struct amd_ip_funcs vcn_v5_0_1_ip_funcs = {
 	.soft_reset = NULL,
 	.post_soft_reset = NULL,
 	.set_clockgating_state = vcn_v5_0_1_set_clockgating_state,
-	.set_powergating_state = vcn_v5_0_1_set_powergating_state,
+	.set_powergating_state = vcn_set_powergating_state,
 	.dump_ip_state = vcn_v5_0_0_dump_ip_state,
 	.print_ip_state = vcn_v5_0_0_print_ip_state,
 };
-- 
2.47.1

