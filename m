Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA0DCA0EDB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 19:12:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CE9910E193;
	Tue, 12 Aug 2025 19:12:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rrtr1fAG";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3992610E193
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 19:12:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flwV+4yLTO4Ce/5EXt/oJc0DphmzswuwTfCP6JB0WaaNjee9ILyxLmTfbG/7oOa8+GtenMry0uNTEF9PCNDsRXtR1ogMszBaOIhD9bZDBp8cHAC99hh0QwQyTRzkD8NtryfE36MjYtnHl0nTUcwvQaUlt/Ok7wbd4KzeP9MktjbUMUBHlqJlYJHB3m1PN38sdVzNwLqWi2WO/Oc+QURSe9cgBCEfIPpq40JwC+iep2JruLtrH6zrnHzBWKwhZT8LN3i6B2g1WGYCSIsqF6JBSwwbgb9HDs9KpyX2Q47DYSKqb8Krd3tf9Rhn7PRtIRG3ylVQrklYExz5KH/bqeyHOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QgSxNasqiScsA7bJIrD9WRjmil1yHJNXZqyR9pEW1TM=;
 b=XFbtY07x/A8cf56YJP6+EZT+zqPIe9uh5AYOPHyz1JCUfv2EQFNLsvyl4jTUwVtcQR7XWiagPTpxUn5i8olsufqQ5BFlUQy3FwXny68XZPWhFq38hlH/Nt0lT5/VXN3AOxNsRRzZ5OLqFr+p7lJHKmdIpz4d/ZeShGkG98h6uIGRKdoqBqrs56DBw72oyUoC7O9Sl3BOa47rNar9ujRCO2bB/AVUJnA4rLIACVWiM4FF4TDToNPKNrFcyUhW5ZgMsc9N6hXl1E4/WDeZRfQJvmqpOvXozdPQyL+rmODcJPU5xvPtkzhZHa3jqokQGlbjdoDKpn8qH2HsU0fwqKVoBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgSxNasqiScsA7bJIrD9WRjmil1yHJNXZqyR9pEW1TM=;
 b=rrtr1fAGizULYie0UbkzztPCsUFGiTUT8s3nXDVCHwEUX65p3sBVpM8YVaj3uf/hTXC0bzMoh74Fyq9azVAr+6X4+UE4VXy8fumboMVFvuOWlVRh1t8Ba4c7FGrJ55sajZ/suRpq7KFosUOUj/iwbi1d3QdqlZnklkioNnaYApg=
Received: from SJ0PR05CA0023.namprd05.prod.outlook.com (2603:10b6:a03:33b::28)
 by IA0PPFA8EB66EE9.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bde) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 12 Aug
 2025 19:12:52 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:a03:33b:cafe::51) by SJ0PR05CA0023.outlook.office365.com
 (2603:10b6:a03:33b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.13 via Frontend Transport; Tue,
 12 Aug 2025 19:12:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 19:12:51 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 14:12:49 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tvrtko.ursulin@igalia.com>, <Felix.Kuehling@amd.com>,
 <David.YatSin@amd.com>, <Chris.Freehill@amd.com>, <Christian.Koenig@amd.com>, 
 <dcostantino@meta.com>, <sruffell@meta.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <Alexander.Deucher@amd.com>, David Francis
 <David.Francis@amd.com>
Subject: [PATCH v13 1/4] drm/amdgpu: Allow WIPE_ON_RELEASE to be set on gem
 create.
Date: Tue, 12 Aug 2025 15:12:28 -0400
Message-ID: <20250812191231.3534982-2-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812191231.3534982-1-David.Francis@amd.com>
References: <20250812191231.3534982-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|IA0PPFA8EB66EE9:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ace8f81-1bae-4a65-9afd-08ddd9d43b94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tlzuKx/PfqiKj2HHseB4dAzXozYVIaI6/E0MHqZ/JjNJTuVbow178GKijv+D?=
 =?us-ascii?Q?u52orNPV1goRZYamMGtMC4KWTxDhW+BIlBEG5Jp4KuUMOR+8FCHRryU7SCRl?=
 =?us-ascii?Q?HzfpYZHjQo57lLRytBI899ZEdWrKvCpYan5n04sfclFuwNbAypsPkLHPw28a?=
 =?us-ascii?Q?pNZgKdf4fvconVa3pRyLI/CtgganUMN8tpPI767/+hJYjZRqu3+tgLzs5aR4?=
 =?us-ascii?Q?Bsg7BdledIZCFNexLBZVeAy9+D+YiWVvQ50yGbVhRq2Mhjz9SYiNeQF8Z2b+?=
 =?us-ascii?Q?9vxYksPMLr/gMSwP79AxxoPPnxMuX3/z4I0hpE/RsHaD0wo59a0K46P3Uh3h?=
 =?us-ascii?Q?HQY6VgWTv6SNmZIVgTQsI3JViHcWvGuXOXJZPJJlwPVTM+EYxUBPYLOv4Ax/?=
 =?us-ascii?Q?OiDs6aYvHCN6hr86eRFFOESIG/tj9nmLgLLspiXj4oIo+NWUzJPE4mKRZVmI?=
 =?us-ascii?Q?Qt8U2HW/iYjIGdC420Di+TS/I/kp2vUsMB1/7frDkUqnjFnPuYdhDXYs8yEX?=
 =?us-ascii?Q?ONJEmUXhdOhYRKD30rc7qMLBAMb/Zjk1xwfq+QR0A6lW6LtP627CJ65SQWHF?=
 =?us-ascii?Q?UN0kc3aB7oKO9ozb0sh+pG7QRsxVAOTHHV3jC7uMoJ4nNG3FAE3QSLCxispL?=
 =?us-ascii?Q?0AnP6LDgiUwbOHzecfUEJ91rVcjviB19Lf0Hqph5qgLO1yQ1ETjuMsXwdHjk?=
 =?us-ascii?Q?s5IQlRqQozPqK3BLDciOgVuep464j9EBbqPMyKFkL3gGZo+3r/5gWarVqiuv?=
 =?us-ascii?Q?VV6Ms7H8XTxAsU7BePhD4mbw7cNshbIkk83CkOOEUUGzoCz5WbIT8rlZnLF2?=
 =?us-ascii?Q?QY2fUFqH4pCXAMCLFKelCD+F42RsATIdmcCKt1oc29d+OBnQNEMFndTswhwa?=
 =?us-ascii?Q?MZ8lofbq3ujnQMnZ9X5jDV6K5UAW4qf+0wxNRMPAAMwOtcaXz4SuEK8DnCXz?=
 =?us-ascii?Q?uW9ZYG/IIe5tG3d+EhZoLQBqGyBbVpckxuAixBpctrD/njSEhTMbRo6YTXxO?=
 =?us-ascii?Q?oOxrI1xv3AqEaAvn3Kxj4TB8UOWHRBTRiPWmvYoMn/aFZlcBKBTgY8S5h06t?=
 =?us-ascii?Q?I8yg91o8/vOPz1292Hd9dA5YqMYC/04mD8Dguqsmypm1NU1TxGUnuH1BmMXv?=
 =?us-ascii?Q?xtrtElgo7rwL9LW3ugMnVI6pOVqHGNS/69kZBEgeXTmzBLzo11tkUL9aoRT4?=
 =?us-ascii?Q?+ao9uWjiTFfz9tQCRy6N4R2Ws2m1GCIj3nbF9guKPA3ljU8EYnePBCvhASuM?=
 =?us-ascii?Q?dere7D6wHr3ZCCc+mJgTzpzGKqSMNbnetsoTa30NPkNcjZkrs1OTJlQvvvkS?=
 =?us-ascii?Q?+JeAw+yYQGAsJKOTS+fm/54USdepgNWekedQEKBYe3f8Q5c9A9j6uhySnQNO?=
 =?us-ascii?Q?n12ixm+mdbAIt4WLxIesuw5k7giEP5fWogJu7IDKL4xoSls4epp4hLWnCuMN?=
 =?us-ascii?Q?zdjzekb6xu3s9flEelOmcWl7faWWDh4N/HaStCPKSRmL/7tsG+ZqdoPlRi3Z?=
 =?us-ascii?Q?s1FfBwqTIGAhhrtYktwLS5FXOp80r+K30KgG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 19:12:51.1021 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ace8f81-1bae-4a65-9afd-08ddd9d43b94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFA8EB66EE9
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

AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE is a flag that
specifies that gem memory contains sensitive information and
should be cleared  to prevent snooping.

It was meant to be settable in GEM_CREATE_IOCTL but wasn't.

Make a new define AMDGPU_GEM_CREATE_SETTABLE_MASK to
track which gem flags can be used with gem create, and add
wip on release to it.

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 10 +---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h | 11 +++++++++++
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index e3f65977eeee..aefae3a9e6f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -442,15 +442,7 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 	int r;
 
 	/* reject invalid gem flags */
-	if (flags & ~(AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
-		      AMDGPU_GEM_CREATE_NO_CPU_ACCESS |
-		      AMDGPU_GEM_CREATE_CPU_GTT_USWC |
-		      AMDGPU_GEM_CREATE_VRAM_CLEARED |
-		      AMDGPU_GEM_CREATE_VM_ALWAYS_VALID |
-		      AMDGPU_GEM_CREATE_EXPLICIT_SYNC |
-		      AMDGPU_GEM_CREATE_ENCRYPTED |
-		      AMDGPU_GEM_CREATE_GFX12_DCC |
-		      AMDGPU_GEM_CREATE_DISCARDABLE))
+	if (flags & ~AMDGPU_GEM_CREATE_SETTABLE_MASK)
 		return -EINVAL;
 
 	/* reject invalid gem domains */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
index b51e8f95ee86..948449e46e90 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
@@ -71,4 +71,15 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
 				struct drm_file *filp);
 
+#define AMDGPU_GEM_CREATE_SETTABLE_MASK	(AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED | \
+	AMDGPU_GEM_CREATE_NO_CPU_ACCESS | \
+	AMDGPU_GEM_CREATE_CPU_GTT_USWC | \
+	AMDGPU_GEM_CREATE_VRAM_CLEARED | \
+	AMDGPU_GEM_CREATE_VM_ALWAYS_VALID | \
+	AMDGPU_GEM_CREATE_EXPLICIT_SYNC | \
+	AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE | \
+	AMDGPU_GEM_CREATE_ENCRYPTED | \
+	AMDGPU_GEM_CREATE_GFX12_DCC | \
+	AMDGPU_GEM_CREATE_DISCARDABLE)
+
 #endif
-- 
2.34.1

