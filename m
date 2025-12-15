Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D66BDD5B863
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 18:16:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56E7210E4BA;
	Mon, 15 Dec 2025 18:16:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EZ1WdwFk";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012054.outbound.protection.outlook.com [52.101.53.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A65410E4C7
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 18:16:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n2R3ttpmo4NsCgUDusRKIjOKBikwh8lMXV8drTv7RDbYirBlZ8S/9uz+2KMg03YP7C0VhGu81JJ3VuP/8jkge6zn8u3prnPqLJaftuM6UhzFkczgCpQkk1dUWr4zX7gStc+9nlwdz76rQkVHk4LmnxHQOCzaVOaOP1PL0b2oCkWhI+8cbAmVTJ9VQqemL6zrD+QsovImLlNSpCszuqQF3G9ofwGlNcwGcWs0TaVrX1PckEhYytE7fExzWLcTHDQUFatir+2FUpLSe8KEObNTbcf6TT8UGtPuW2U/nc05mnFEQ6mO+236gZmIW75hcf9PtH8WvcvcmuLKdGYgKszl4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fa06+ZvW958bG4BV0Y6JcSE/HrOrpMP8kklNjjdl0Ss=;
 b=qyxxpTVvgYzlMAn4lvLTjtFORLuG9TpHvfa062UTDsu46oNMjUNHHYqYhdDeQK61ZsFj671/v6809CUBAWXUEPMyCkXhnwLcuDAq6YYZD+acInMQCzZZqT/TVx5rerc+r+q/j6+VL5AsC9wxajOt3ctsgxl+k+cBmaK5x2cXwfR7IwdmXrel9upMVfDdrneZLGc/bLmTtq77Em8wIMGJ8QeGTtFHdUdTRTEZvPAsgmIlZUtwqR6mEHZbX/2qaHwhf6YTasMt7mU26fnus8NwqNfM1DhyKTchxvJ8E+pMbYI6EVq4dwNxq76xqCHATB+1/iyriJmySoms86PGGq7K5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fa06+ZvW958bG4BV0Y6JcSE/HrOrpMP8kklNjjdl0Ss=;
 b=EZ1WdwFk2d0dcw+HRrkxZktgSJGrf2Bc2OPncXxa3qTellTVmQ1EhxN+Q08BfKkwn4Q3OzPkgCEW6vs85wZuPcqmjLrvG41wOnXZG84UdQglxO5+hlVrfWPz7xOsKyKmTO4Piu/EUk+hwnVN8AG6ZB2FQc2dkG0dxWbYEGaIxs0=
Received: from BL1PR13CA0218.namprd13.prod.outlook.com (2603:10b6:208:2bf::13)
 by SA1PR12MB7270.namprd12.prod.outlook.com (2603:10b6:806:2b9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 18:16:30 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::7c) by BL1PR13CA0218.outlook.office365.com
 (2603:10b6:208:2bf::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Mon,
 15 Dec 2025 18:16:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 18:16:30 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 12:16:27 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Alex Sierra <alex.sierra@amd.com>,
 Michael Chen <michael.chen@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdkfd: Send MES packets on correct XCC on GFX 12.1
Date: Mon, 15 Dec 2025 13:16:01 -0500
Message-ID: <20251215181607.29132-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215181607.29132-1-alexander.deucher@amd.com>
References: <20251215181607.29132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|SA1PR12MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e4afed3-f92f-475f-a65a-08de3c061216
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D4MMMto0t9vLYcHbYTVKkFybVUs7o2YL0BqpMSU37NujpVPL0X2aRL6eRzkG?=
 =?us-ascii?Q?pYdX+XfrKYtpOFkqTfxcIYlRllNnoOLa6MVA46XSXRXDoMq7zY/4oOh7eJ+d?=
 =?us-ascii?Q?7Ioh3IlCcF6TMwyM4U3SyYuOxoYZfmNMtdFEtRAX7AUEhm+ruBSCwKt+++ko?=
 =?us-ascii?Q?RVzMbVP3/4JUX95amlLKNl8vzS2Ncduae1wRg4+cvqvfLm7jUIH7Kg+vyqh2?=
 =?us-ascii?Q?SgdWUYiXsaIVkscHZnx8D0qZHmxJ9WRTJ1iJ7MUqfx6fxx4LkytXAl6C4R76?=
 =?us-ascii?Q?m+7N7E55MVhB3wUt1WEMkmcApBhpaNdpzCJLVZDKiDrQrjSvGX7RdD2ecP1I?=
 =?us-ascii?Q?W2fKK+eyUxcbKq24F1UZAnzmfAo1Q59qIxtSugX9T15Vzunm+GMbITyzIqYp?=
 =?us-ascii?Q?7Ihqw0nhf2XVPnarEVei6UXcePssZVPEoUDHxgxdsjlTClz8ui9cwig3Royy?=
 =?us-ascii?Q?ZNHEsTpRVETLfwglDItvTKbDt/JcqxZXl5ngh3qNrbETBIxUOmHGZWk56Jx1?=
 =?us-ascii?Q?UehOl7BLkQMBTaKwQ3ewu3TH/BTM7DouZbIvA9+my2lGfCJJz1pxjTgBOI9f?=
 =?us-ascii?Q?f+siHhQJHm/BrwIrG0nlzzBnCn963bhI39D6vzPsfYs5cuJ/soaZ5dXvpT2h?=
 =?us-ascii?Q?52IGcMFxAdDw4RF0uv8/Mx+BG2g/dKDxKaszFbK7rrFCkrek6wVVlWn1lTyz?=
 =?us-ascii?Q?fDy7eE4sVSXH9yQyrUel1J71hHjoxW/0SXr0WjIbedUn6jjxQHOR85KlQf6k?=
 =?us-ascii?Q?xUwxdv8GGtw6fKV4Nw4kG8s4NIrxHVeTnbDXP0d0ofJNz+AGLtQCfDXSsqlp?=
 =?us-ascii?Q?wmFO/Ug+eLBGMXzY/ScHryhC2Dir1wzCUNe7TdxtU5RKBI3Q/dKcg8TuSNas?=
 =?us-ascii?Q?EoyCAKVGxRlHK5TSApxFlqpXaq43nzEh6BspAzX24Vt0T6Pfg5dazH6yVBXv?=
 =?us-ascii?Q?fd/OTjswwRargvpEd2TTliU3dsVpxzYJI6lxDdTM/Z3/mBb97cDOf1qVM1N+?=
 =?us-ascii?Q?YHLYKLDR/SA6LJOm8R0sFsJcazErIOO6bwgBTFNfCsfpBdyX67BF2L5LxnXV?=
 =?us-ascii?Q?cYACXDSjN6F2SIWS/aCuT2qSoFGp7sWzmzjEx+n69Nd8gT9KPWEw6tyAGUqa?=
 =?us-ascii?Q?046uPmdbbaS50vDyp9iPjNQegSPYwe2tmnhSO+M6o5l2xNMfIMqU2VN0smTh?=
 =?us-ascii?Q?H7JUSUcpEJcXgcLjob084cSuKGbQH1Z0kqEPq5QFTHGwhPTAqt5POTkA8OXY?=
 =?us-ascii?Q?5NngHtloGW354O981/ULoQj2TqQ1fH/UaU9C4ZqgT9HMqyI93Qkjy6XvmOxZ?=
 =?us-ascii?Q?r+g4FVo9r7hmEaLLaycPwflckkShMU/xUXK6pL2ZzT8cIJV4pJMuOCB9aqO7?=
 =?us-ascii?Q?pRATEAH42wD6melkmT8boj/k5pieovv7jJfkmKshptIpAZs2cRh/jEJF7ypC?=
 =?us-ascii?Q?4V5Ql1dp+corGMY4RdFdLCvrQW13c3xO5nZ1aed/3TAqyIEJHvxDOZpTPwDJ?=
 =?us-ascii?Q?sljor06VWBR+LbCkKbAl9N3nqjU0ik4OrrtAy1lbbCLbI6YYd5eaABRfqE2T?=
 =?us-ascii?Q?WiMKMeSLz2gJ6dLbOK0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 18:16:30.3693 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e4afed3-f92f-475f-a65a-08de3c061216
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7270
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

From: Mukul Joshi <mukul.joshi@amd.com>

Send the Set_Shader_Debugger packet on the correct MES pipe when
partition mode is set to non-SPX mode.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Michael Chen <michael.chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c                 | 6 ++++--
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index f83e1238c1b3d..cd5a0b58c7d17 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -371,8 +371,10 @@ int kfd_dbg_set_mes_debug_mode(struct kfd_process_device *pdd, bool sq_trap_en)
 		memset(pdd->proc_ctx_cpu_ptr, 0, AMDGPU_MES_PROC_CTX_SIZE);
 	}
 
-	return amdgpu_mes_set_shader_debugger(pdd->dev->adev, pdd->proc_ctx_gpu_addr, spi_dbg_cntl,
-						pdd->watch_points, flags, sq_trap_en, 0);
+	return amdgpu_mes_set_shader_debugger(pdd->dev->adev,
+					pdd->proc_ctx_gpu_addr, spi_dbg_cntl,
+					pdd->watch_points, flags, sq_trap_en,
+					ffs(pdd->dev->xcc_mask) - 1);
 }
 
 #define KFD_DEBUGGER_INVALID_WATCH_POINT_ID -1
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 5f8cda4733f9c..2a949c15e0180 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -94,7 +94,8 @@ void kfd_process_dequeue_from_device(struct kfd_process_device *pdd)
 	if (dev->kfd->shared_resources.enable_mes && !!pdd->proc_ctx_gpu_addr &&
 	    down_read_trylock(&dev->adev->reset_domain->sem)) {
 		amdgpu_mes_flush_shader_debugger(dev->adev,
-						 pdd->proc_ctx_gpu_addr, 0);
+						 pdd->proc_ctx_gpu_addr,
+						 ffs(pdd->dev->xcc_mask) - 1);
 		up_read(&dev->adev->reset_domain->sem);
 	}
 	pdd->already_dequeued = true;
-- 
2.52.0

