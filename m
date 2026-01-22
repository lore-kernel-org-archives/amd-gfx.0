Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3AF3D62615
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 10:41:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7309910E972;
	Thu, 22 Jan 2026 10:41:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R+AsbfD5";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013043.outbound.protection.outlook.com
 [40.93.196.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1888310E1EE
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 10:41:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oXvb1XU/xGuTWmqywMuBdQQv1gm0rMyu4mcnnVs5oJj7leY2L1Yrz5Lg6l3TpRoFxROAXJL8+GyEqEbMbVdx0aN5PQL6hGqpdXEEt77ej2EFLZLCZNoiVobtulkydi90+gBEzWHcWlbg6n6brS6/aqPl6y+8IV5mnfA8d+HUVYT5Mk7hbZ5uD7hgq+CDojQmrLeWhk67ZEVQtmZic0Vfe8jK3oaZEZFNQOfmcfCl4tMmYzeMtGhIvA7UmAd7Iq2r6mLqwqpPMHszPv1fczt8M0jgWqG6wjTQKpuVdy5+8nLSooznsW7KcZ7gS3NTSnhVyy31uCroYA81fk12hve15Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgYcAk5xWQHBk/rdhTtAv5pCrBxDvu61xLEu9Z5I6Ns=;
 b=P0XBeZpw0+ibwQLqeFVyYj/H6EZeCIC9O0+OpX8XrzE4vSRDr4aBwmuVfVFcy71XNuAzmVX8R2ESnKQGT0u31hpy5poah514MHmKHmALHK7DY7gpEfhbojLbfa8Iv59KFywnPdshO83edUuXpFSo0h17HRPJk3y7rjPznG4zXf4j7hBDH8ljPt7DvcpvRdNgSKy1ReeblN02Ppl/UfNxBZg2ZUm/Cc8B8r3WZJA48Ozrvm/KJFgFp+8lg2siSRnpYoYhQTatoy9pr/8HJ9dUL4vM/lzmtNSOd+tKiUY3w9C+hlvLTO4i2Eaw+yjyFHH+RLh6/zdNZiHS85gUXGcixw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgYcAk5xWQHBk/rdhTtAv5pCrBxDvu61xLEu9Z5I6Ns=;
 b=R+AsbfD53A8p6gq27UkBs8pktgyflwldq2xDLEOMtmyj7uhZlgrkC0BH6gVV0Hr9yz1Zefb9jqrP1XuOF9ypA5mogKELO8TIDLGR7OzEbSzm5wb1LGitK07aFFgdGR/pPImMIY0Uq6gA5LQCx3D6s/7H+zNvLwUANZSIiYtgZug=
Received: from DM6PR08CA0059.namprd08.prod.outlook.com (2603:10b6:5:1e0::33)
 by DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 10:41:52 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:5:1e0:cafe::60) by DM6PR08CA0059.outlook.office365.com
 (2603:10b6:5:1e0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Thu,
 22 Jan 2026 10:41:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 10:41:52 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 22 Jan
 2026 04:41:50 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <Jesse.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH v4 05/11] drm/amdgpu: Add cwsr to device init/fini sequence
Date: Thu, 22 Jan 2026 16:09:54 +0530
Message-ID: <20260122104118.1682154-6-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260122104118.1682154-1-lijo.lazar@amd.com>
References: <20260122104118.1682154-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|DS2PR12MB9750:EE_
X-MS-Office365-Filtering-Correlation-Id: b7c5aac3-e9e5-4088-e192-08de59a2daf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C8IyqHLrUhWD0Z22op7QlSRtVhuFvI3DDmHVF0xKqQ6ZkshOGzl4c4wwtsg2?=
 =?us-ascii?Q?KijSfdynl7O2x2sgy7FzN2a7Wj9SM6Oten0b4xLHdAfWCtLwI3hYv5pbMllF?=
 =?us-ascii?Q?6rDWq05+sg2pH2qmhZA9E28xFxmN/qdUsymhCvFIYoTDn+ldJ3foW9MAMfHs?=
 =?us-ascii?Q?4H6RvAQMDpjZfeEsvLqWfcIkvSWw0vC1hx2iig956SdNPDBhQy6Luvkp6WV2?=
 =?us-ascii?Q?7OR+sqydC3ToyQjYiPTA9abekexfHk9tPouSqk70vkqtMp4XE8HfpLXiFuw9?=
 =?us-ascii?Q?tkxtVY1OH2KVrYzI3UmRR0DgzB7pSRqwOg/qSu3H1N/aDm33wQ2OTrN5LDTV?=
 =?us-ascii?Q?F7cOfCBxwrE8qtQNeXXFAXbWVHuqbpU5ye/8lgiAU14TT10wE9zA1KOJTb8+?=
 =?us-ascii?Q?d8kGRwy2VDCx14zVH5EKo3HgYeQUuaMOsBnGDDBgxUWiDUKzajtkCjkei8tu?=
 =?us-ascii?Q?mKn0FiWj/GuxVm2bJUXypX2SaoKQUsjB84ZHmmbIasUz8E0+UJxnMGUsBPHY?=
 =?us-ascii?Q?sdf3i/+AGowPoycSrxpj+491te/klGBdkv2SrWmg0UbXf4EnHbjRNO1kPHTW?=
 =?us-ascii?Q?oeI3dxPxAOz2LDc1k0iMLFeSbEt4xOjR4ESVMmKD7tBXufpcOSfpqfSzk0JT?=
 =?us-ascii?Q?TwNKBT3dduFm/7BHIP+5lj75+9ZlzO0nLvPrKevcIdaaNCMpPoTaZZ3AmBzO?=
 =?us-ascii?Q?lJ/05wY2K+bNJ03mTT9xuVxG2YeyggwZ/MyJkcSWvMo0vGE0CzmzYv4pbC69?=
 =?us-ascii?Q?X6lJ0z/NgSfTBVorR9r/rMUDdtIdwthjrbkL0Own2NeLbULjO1qPvJl52erj?=
 =?us-ascii?Q?ej2GQb6rux+QrFPdHNUJ7kRlEyGbGVtu0jfQq+3XCoh/lGue0QHF6wdmsGon?=
 =?us-ascii?Q?6W9pH+gSp0RLo42VjiXLA0XK5S3CmwIZONwYhCZsdfIWyUmBc9gtQjKMxfb5?=
 =?us-ascii?Q?gjOeg3tG5zhKHqpUQS9QrQ795xUflSST3XnRLt0En4PEreSNfpLOXuNCrC28?=
 =?us-ascii?Q?Lul9uic1joaDtjJpu1nkQ/AouAB1w7bmVY4tslxysQ1vv1Rt4a4w51MH/o/z?=
 =?us-ascii?Q?1mCeHi8no5wXgL9mfMQii99MdvoBoBkIGRtvxA6+5ji07awF0v7nA2ZcCqbq?=
 =?us-ascii?Q?vx3SHZ9T0v5R6RrZFq00/UDYsNSMAm0rrFp+3NwsAtJ8HkIQ4hkYUWTO3ec3?=
 =?us-ascii?Q?AgB8bRDPtTiRdmkW56z3xLJjsoAq/Cziy6UsOxUfS4hJft0Fk2gjxgP2OnOT?=
 =?us-ascii?Q?jzno1ZViAaoMteRDJQ6JTacbIEEubWXGX1gv8pL7UUpWeN9sjSulZi7aPVgZ?=
 =?us-ascii?Q?0DvQboyZ4kt+IvpupzNC8V7ew3XNHFIOmF2LkiH38SAPmr0DjA1TVJV4xaWj?=
 =?us-ascii?Q?t9waD1Av+QcovIadac1ao/JBYb8wnME0uvHYs3RoFyB+1HvYe71A7o4wC0QZ?=
 =?us-ascii?Q?fbeub3nV6OL4pu5Oyph4Z7MmeHHFFJyL+LEdTJAzBT0XecUZeTGg7xAAp0VF?=
 =?us-ascii?Q?3FpR7nWZ7gOR0+Cbr3JvnO3eKdLl8fDbYNWJVaVmF6r570de/m+2i9vnCVz2?=
 =?us-ascii?Q?Zlyk0XueWj38DpUt2Tgj5ssEikB1N25MQtDe1Ja3dNK1giAuWLL5G/T+Jsmw?=
 =?us-ascii?Q?YbACyHMo27WHceF8hh42xH2SZ8h/uB/w8/4zsu5Ten0fnx9Uytc2cufsbyfG?=
 =?us-ascii?Q?/MW7nw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:41:52.5714 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c5aac3-e9e5-4088-e192-08de59a2daf9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9750
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

Initialize cwsr handler related info during device initialization.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 362ab2b34498..d84e513613d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -78,6 +78,7 @@
 #include "amdgpu_reset.h"
 #include "amdgpu_virt.h"
 #include "amdgpu_dev_coredump.h"
+#include "amdgpu_cwsr.h"
 
 #include <linux/suspend.h>
 #include <drm/task_barrier.h>
@@ -3171,6 +3172,12 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 
 	r = amdgpu_cper_init(adev);
 
+	if (!r) {
+		r = amdgpu_cwsr_init(adev);
+		if (r == -EOPNOTSUPP)
+			r = 0;
+	}
+
 init_failed:
 
 	return r;
@@ -3561,6 +3568,7 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 {
 	int i, r;
 
+	amdgpu_cwsr_fini(adev);
 	amdgpu_cper_fini(adev);
 
 	if (amdgpu_sriov_vf(adev) && adev->virt.ras_init_done)
-- 
2.49.0

