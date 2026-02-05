Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA514E9126B
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 06:51:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F43510E259;
	Thu,  5 Feb 2026 06:51:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="esW1/K7y";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010062.outbound.protection.outlook.com [52.101.56.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B2B610E221
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 06:51:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t0MQUZpNZpCQ2QkwyAGaIWBrZHhSAc0FI/6G7vJ/MXUD2s9MKlghMQdaae3WZLVVhHt8EBmCgimQ0lkXETKtCxL9KugsAyU42758USZsjkJssh68kDGoW++0rpmPe1CILU105WHXZBT2c6SEfSnj0pKxaRQ0Ez/ua3c23uIRU6naPyChk3kSDUqFqIgmhKZgJoA2ywj1N6Siw0M3FKchA6aSOr6HjdZMaN23+wJ3028tlFMvEneZHKg5CGqaRuMzfVlroZ9KarB+e1gcNJ5lpDZTXffC8OfixUOwsLSL9yy/sVJFe3qQZwqWef6wsetwvu/pt9kJNUyDThtw7Wb62Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67zalyJt8/IAbks0N8M4sCuiIVxPocub2j7cdBBDkow=;
 b=Ahb7JNkWRvGMJ4F3/pL2heR7+7bXzFm3m5PNdQWlpq0gpnVZ+kUdgl3ojBmDGbGPztUperk4z0cijsw6MFZsmKYaDOA5zwjSGND4C+hWGi9OQBQKfx7/NCg5RIRLr1n7vhvIM0Cos4I+DA4dKeo/xwzvEI8OjjK9GlanPv0mI7/7kCzTolBiD9Qc4a8MsJuT7O5H9jWCIoF35XJZf2awsvpPhE4+UX+O+6H3LT3qrzhDe8htADC95x3Q9dAEzPKMo3hAubYo18MCPkuFIGNewsat3LNszzV8y4tppyYHBGc18biTBFFe2lMSmKJF/kmbZk+Ifg1ke7noiZYpSAhIvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67zalyJt8/IAbks0N8M4sCuiIVxPocub2j7cdBBDkow=;
 b=esW1/K7yvi60oBAjVGjmXpur5uHbd5uvkSKEoWMmcqbcbbSGhg1vl7vBut9me4Nj9/pdBfsAQe6DKw0ltkpjtXHunYHZjAmbI9rZl+JHaiLqEKgi7Rru22gwwtcqaTTEGO8Kv0/bbkvnQ8tlWc1qq6nZIBjYRSWIqnQEtMP0VKM=
Received: from PH7PR17CA0015.namprd17.prod.outlook.com (2603:10b6:510:324::26)
 by DM6PR12MB4188.namprd12.prod.outlook.com (2603:10b6:5:215::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 06:51:42 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:510:324:cafe::68) by PH7PR17CA0015.outlook.office365.com
 (2603:10b6:510:324::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Thu,
 5 Feb 2026 06:51:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 06:51:42 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 5 Feb 2026 00:51:40 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <yifan1.zhang@amd.com>, <perry.yuan@amd.com>
Subject: [PATCH 03/22] drm/amdgpu: add PTL enable/query gfx control support
 for GC 9.4.4
Date: Thu, 5 Feb 2026 14:51:11 +0800
Message-ID: <20260205065130.654921-3-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260205065130.654921-1-perry.yuan@amd.com>
References: <20260205065130.654921-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|DM6PR12MB4188:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c205320-d877-4284-8284-08de64830533
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TsXrx6BbWtUCIEEDFQqMFB9U2vnkb1HlhOCUAvi6eMu0DDX4KnxGUIbvvZdE?=
 =?us-ascii?Q?VwYcYWNqWqbR4dJ6iuaz1Xtz7bkF8tpEf6v7S1G5lMbkemQX1yxto4vZ7MKW?=
 =?us-ascii?Q?JeHd4CaWv2DalwT8unCoPHglsV/tddGcB1w2BXKPQJ7MtMtUmXY80XubIz6i?=
 =?us-ascii?Q?THqnx8N682DLO4TYkDVtaRGgaNUqA9noSqKZQVlNIhxC80crMGgIfFk0p466?=
 =?us-ascii?Q?LomqNKwdj0w3ZrKTRUb9ZVJgXcXQLnO+1qJ8Y4zgihWtrPibyhd/BSMx+c1U?=
 =?us-ascii?Q?CmEt6XQ6I1I+eASLnaXG6xGZBx2l/Tlc02mjGPLrHiUqqY1/LBUuwnCHC9ox?=
 =?us-ascii?Q?l0I4Urdh57EPjCQKcK3A/tYIKAudEK6dN9P2I4hJ5Z5NhLZkY9/npjj67mVx?=
 =?us-ascii?Q?enNSzunTCLbHjAymB1B/LkJkl5tGqZwwS9xTdv2b7uZTVea8DkFUf0FqED1Q?=
 =?us-ascii?Q?dnYL4gE5tLoSgx1N63K7fyn38mbwP5Qwa4bAX895MEJrBP5LPZ6eNTuHDZS7?=
 =?us-ascii?Q?oQAO4e0WK4JlVT/IitKWg+Izoi9/KDpc7r8eZvKOILproNCxDgvHxcvPCtcC?=
 =?us-ascii?Q?5ZZbljoyOruH1r6pTeoudBbSHuQxDgI+l78uOPNds/SaiDdKZtafPTgDp8il?=
 =?us-ascii?Q?wNvTL9c/JstlLJ+T8ITODqbMk+U+uA98nptdsAUPqO3L8DFsBt8rgf09rzdA?=
 =?us-ascii?Q?n7Zdoj6wxze9I2c/KBOfiwNSy468j5n4wUL1Uv7Zzc4NMqK+LlSqovmcwhKY?=
 =?us-ascii?Q?qXXstRWnbD99prMlqXUoqPSzOYs2vfArY8QdHn+E4IcAh0YSCMh3Nk5Z68fM?=
 =?us-ascii?Q?v/QdST39Vbrz9xmX8PsTKD3vG+lOnYJVH15PdoHls3oZG1Ll8apciEhKbeNN?=
 =?us-ascii?Q?KGfMy6tLCioc1LAbQf8bkAv/TQtYpngK6Q3lTVptSxH7RT604+nWnkQuMEAv?=
 =?us-ascii?Q?/kxz3MWVKtN9+u86wjtbLTV2n0d+JibKg9QOUz9ZhsYR6t8cYyF5t/dA8vFu?=
 =?us-ascii?Q?sPb+eSHIc1JfYd/XAEYNFPCpbfQ1Z2qyxdFXaJY1UuDuUF9JjI3HyLpnSahu?=
 =?us-ascii?Q?pxotmEelJxFqKSDeosG6eWD2ue0E1W541yA++ziOg15LsQgcPXDJXLtWhbDp?=
 =?us-ascii?Q?56kwQVT/xlwdpWuK20t56Tt+hAeATwsyafBN6Ro+x+aIRwFiHI5+3lg/e2LC?=
 =?us-ascii?Q?72vqqou2Ra+J68fWUs5D95SIsJXzTLzghXfm7x6CoX5QKuTtr9i8gATG0gzT?=
 =?us-ascii?Q?qtDHMPs2TqDyPIeucKaIoAdxBvZUs7L67KT1ogimjxN80SrZ0gVh3ogdPgc5?=
 =?us-ascii?Q?Q2A+sQmwnnaPzvEt7z+QLs9CX30pG/g8K6MwpArB0EHhGLqgXpjrcZSDaTmm?=
 =?us-ascii?Q?9dJgKJS+onU/E0B43nwmL4745+zgFBXhD9c2a6LR/JZKewbGPmHzOpn1xVBh?=
 =?us-ascii?Q?03/v6sgN9GXJ56lk1Y7zZXfpAMvRBbZvoE6HO0Fp7DC9iH9DN+bXHFHWxVft?=
 =?us-ascii?Q?AiEA5CCzG0NKIslBamq57e4HQRrb1DKW2PYPTz92orQxFp9VdVfnLqvorXsq?=
 =?us-ascii?Q?MIiaB8BivGsuGKN3/GttKQtOmVhDi96LBFJKg5m4PGICuqVLM0gwSX/kip36?=
 =?us-ascii?Q?wLrfKcTge/ye12rJxja7ulOMOPaCko1rjpJJDvxUoHR+3nZxYPbDA6e3p81x?=
 =?us-ascii?Q?omc4xw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PdhTKqNTrakBv1FJW8krwm9WpZzASY7sor7pKstp4bQLluLNR03A3tdM+ReJobA+8tt/kFs7yzgo0/x7vI8fC7cKGbI2rP8RDMYkMcUtmBPzjHWkGLgTNS+7G5HRM4iqef81MNCc9IpJu9WlgqoOs0qIweGdKbQRcOYkRls6Xn9OrahziU8rtODfTAO5MSsbKwWdJBU3kY1aDZpjvA7DUOH6CSiBjLfVpmECg9s2tQtwJqGrR/alC3/HSVyJ8Wtotr/1M/lkNAzzniN9oEc7D1dOT0aB31Jo+m9H3W8AE6R3VBVppoM1u7/tKDng3ZPRA/Fm0+P7b4c/ZPoh4zQyVlBs1qEBhbyPqAWLCWyLdEMT3WjL45aFx0DMP+OLYZisU4hMADT+dEjyn0rRDGWVt9r6lfcWoZYcAaiXsFgwqUp4VMSPRuvUkHMgESColOIb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 06:51:42.3105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c205320-d877-4284-8284-08de64830533
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4188
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

Introduce hardware detection, runtime state tracking and a
kgd->ptl_ctrl() callback to enable/disable/query PTL via the
PSP performance-monitor interface (commands 0xA0000000/1).
The driver now exposes PTL capability to KFD and keeps the
software state in sync with the hardware.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 36 +++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index ad4d442e7345..a970913ec66c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2370,11 +2370,45 @@ static int gfx_v9_4_3_hw_init(struct amdgpu_ip_block *ip_block)
 	return r;
 }
 
+static int gfx_v9_4_3_perf_monitor_ptl_init(struct amdgpu_device *adev, bool state)
+{
+	uint32_t fmt1, fmt2;
+	uint32_t ptl_state = state ? 1 : 0;
+	int r;
+
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 4, 4))
+		return -ENOTSUPP;
+
+	if (!adev->psp.funcs)
+		return -EOPNOTSUPP;
+
+	if (!adev->psp.ptl_hw_supported) {
+		fmt1 = GFX_FTYPE_I8;
+		fmt2 = GFX_FTYPE_BF16;
+	} else {
+		fmt1 = adev->psp.ptl_fmt1;
+		fmt2 = adev->psp.ptl_fmt2;
+	}
+
+	/* initialize PTL with default formats: GFX_FTYPE_I8 & GFX_FTYPE_BF16 */
+	r = psp_performance_monitor_hw(&adev->psp, PSP_PTL_PERF_MON_SET, &ptl_state,
+							&fmt1, &fmt2);
+	if (r)
+		return r;
+
+	adev->psp.ptl_hw_supported = true;
+
+	return 0;
+}
+
 static int gfx_v9_4_3_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	int i, num_xcc;
 
+	if (adev->psp.ptl_hw_supported)
+		gfx_v9_4_3_perf_monitor_ptl_init(adev, 0);
+
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
@@ -2549,6 +2583,8 @@ static int gfx_v9_4_3_late_init(struct amdgpu_ip_block *ip_block)
 	    adev->gfx.ras->enable_watchdog_timer)
 		adev->gfx.ras->enable_watchdog_timer(adev);
 
+	gfx_v9_4_3_perf_monitor_ptl_init(adev, 1);
+
 	return 0;
 }
 
-- 
2.34.1

