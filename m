Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80817C44507
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2026 02:35:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F402410E288;
	Thu, 16 Jul 2026 02:35:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yxdyZOtn";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012021.outbound.protection.outlook.com [40.107.209.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93D9D10E284
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 02:35:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZEr2Wtmz8MG/Du0H0pcVeq/P6C8THLh9nD4Hj4S3VS2lFu5qB+HqgmxM6vdpygJefO9WJDoWzwsBSD0n0DePVoQa1+rrx/D6e8rea6iZJs0G0HOhGMDupyQQQ/zc535BGvbJhs2l6DacbOmpOctUn+OakuqVn5rHMg6u9Tp0wL0ebRXMCggcRVPujxaA/NOGzpPNUSeNoQageGESQUiT4qHonoLyxrzTbfUrDe1Kq5rXG2USv65EpJ6YkPM4FhgHYb5wmBQQcNvF/pKZmKx8b4SYPMymalxM38TX7UHg5iW9JMtRgI7U/1n7j81we0HVzfh4wrdAx8URtQPYFcubWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AiQ+iZX9wNdjl40SU36d7Mu3U1O0Ezct0Lg6QIBDT+8=;
 b=xBDpx2RiAB7JDsnkyS1DaRxjr7GC0vg6to8H6fN+dG6p/2GALCu2K1NuW6rYYKWhXLhRBUbd/YURhR4yiQnCRLgb1ekavHVtT0D9wDwt3hItklBWd1tVkC83CjAgikrS/1IpjPmO7hpvEeYvOcvFphqzHP2F3rMkkZkg9IIZrsjNrBdlM6dGokbusP19DpuiQBASl6Snx9DjyRJgI1rep8aQpsDzyEFhGH3S98QbSb7M0Bj1xgVR9mJzjMM1468tNPMCuYveFVuouRvvaTKJ/HL+LmvIvCmFo1VHlJQUFlA50p4KlVuem4lb+m2Pf7mWou1I7TTkp7TuIBNvKgrq6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiQ+iZX9wNdjl40SU36d7Mu3U1O0Ezct0Lg6QIBDT+8=;
 b=yxdyZOtnZInJsvP2V3QjONFu1hQT4EAnpiTu1dT2ncp6Wjpj5iQYX62DKgE9OOdtoAR0zVslV4YEST/SDpaIj7J5ZLMWT9spIUeRHbEb7MfPncKWNK0Ay1LPrKs6MKAS+1Goz3TMkwJx6annJTOjDgC+5Kigsxr2saG5jfqPrTg=
Received: from DS7PR06CA0007.namprd06.prod.outlook.com (2603:10b6:8:2a::25) by
 CH8PR12MB9790.namprd12.prod.outlook.com (2603:10b6:610:274::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Thu, 16 Jul
 2026 02:35:30 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:8:2a:cafe::a1) by DS7PR06CA0007.outlook.office365.com
 (2603:10b6:8:2a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 02:35:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Thu, 16 Jul 2026 02:35:29 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 21:35:29 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 21:35:28 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: track faulted gfx user-queue slots
Date: Thu, 16 Jul 2026 10:35:07 +0800
Message-ID: <20260716023527.2073603-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|CH8PR12MB9790:EE_
X-MS-Office365-Filtering-Correlation-Id: 53a7660f-5d67-4463-84ed-08dee2e2e717
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: X18p7Frp1+T3pP8sfF/09dZm0lB6B5q10JyRjwdlk+owbFDRTLqFTBfl7JQlzY9287ayd+E8sgEkyoy7BJ1rqhJiKMDWs2T4Qctst229LiWeKri7YAwKXQGltk55l/gScqD4uFAqV+tSgJwFLPFr8pPbj7fIuh47xhzIZRe7/u6NbZ8/P1ue4bZqyM+ckbKuJ7SLRzwTVMiYqh8STEdpCTtDli61LY+3BRpuRgIKgZMW8XRia4ggGFwU2m88u9mUmkwuKYgF7B/UN11N4JduAtNpVl4vdZ6p3TzoPnKiihRN1d1KZdiI/gEKi2Z9dH5JxH3Jo4yknA11NrGJ+5ZRSBBUqpL2K2mLUPWgDCX6G1L8QrSRUVMTUG7Nboji2W9F9Tcev03TGjixJCPyrhiGmPACydE2rJDZe8l2RiLNEEbgJCgDpgoiNb2gdImjUqaljE3ewrl5sR1dTNfg9otO7R6/78gVcfuQuSnoTD9kvWGv+AWt3dXirLEMU8BpiXfIXnhK06xVHTfEiqDIbFr8lyu48q18afVbCdXt8cM1HGe6gJcuA9zCl0Tl0kCfNyuuRkpeASakpdtxA0lUzBQ+hSK2zAXNhSUEjozUyyQisjHjC9KB9u8KTUDrqwGBR6QMEmJdv9JIecscro040PdU9ohLfrDRGq/M78l8Linvk47snmKL7kWLX1J49Q9eu+KuYHj8kj0n7TvA9MIicHMQIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 93ahNpL93J6sEz8FoF0MekeIe6QMreG6ONJncXVp6pZLKrtCfn5lBioQHNRuq1AORk52GoBFPJ6oFgwNLi8jD35Esygm0m6MTktUvIXLv0miXxtPH5nHZLu2JS6hn73C6rgeRq88la77yIXtg+W1bQ74+ve0OElR8lA0lLeRLtgDWseM8J6XKEyE4xe+QiSd1afyUTjoC6iAG8OpYr9DEd5TXUXkWHqfVD3MTJ+nbtQjD09sVM1Y5Bc+tZGRyWRNlYgSZe3Aco/DoGt5dTxDrhbo1r0JdyXvgXS1UjOnrzF7H9MzN7Z3hQ2IeNiZZ9MKpogiSstgDCO4cS/wsXpmV0gE64OvqVDyoT6zsuUsjo0QbPoXFPQPx4VrD4HejyX1O33ZF9b+ZPjZgHyDzK6qm7hhn/6aHUPSvuVF8EdY3z9gx0XPxbzQu1lbsflEuib1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 02:35:29.9887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a7660f-5d67-4463-84ed-08dee2e2e717
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9790
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

A gfx priv/bad-op fault IV carries only the HW slot (ring_id), not the
faulting user queue's doorbell. Add userq_priv_fault_slots (an atomic
bitmap of faulted slots, so concurrent faults are not dropped) and
userq_priv_fault_work to struct amdgpu_gfx; a worker drains the bitmap
and reads the doorbell back from each HQD to locate and reset the queue.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index aefd4f03b443..f83afa7e0aa5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -535,6 +535,9 @@ struct amdgpu_gfx {
 	struct mutex                    userq_sch_mutex;
 	u64				userq_sch_req_count[MAX_XCP];
 	bool				userq_sch_inactive[MAX_XCP];
+	/* atomic bitmap of faulted gfx UQ slots (index = pipe | queue << 2) */
+	unsigned long			userq_priv_fault_slots;
+	struct work_struct		userq_priv_fault_work;
 	unsigned long			enforce_isolation_jiffies[MAX_XCP];
 	unsigned long			enforce_isolation_time[MAX_XCP];
 
-- 
2.49.0

