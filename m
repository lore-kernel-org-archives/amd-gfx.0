Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7EFFDEE25
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 16:42:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C31310E36F;
	Thu, 23 Apr 2026 16:42:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tAz7Ux+N";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011062.outbound.protection.outlook.com [40.107.208.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C36410E36F
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 16:42:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=msuBtwBpLMxuCDE5ei4uG+IXk9QBRlZh1WIRC7kbPpOOcsXc81Lq+7cZfS2bLk10q9rp9ImJv2nrHknoGqBrcppXfjkGLA7eJ3U8uOulq+ef7NdUXzYgThZQUMPkEPe/0t3XJRlXGzYrBH7XCERlR5jVJ73NoAPadZDCADrscepEc8Ap0NcHczYU6CP+eylfyX+v99tGtiB1T1z29mWGkALswqv/VSQAqsIaU92Hd75/LJyUv4eanwFxNHAhKGmTsRhFLbeQ2/z/qXjDfhJ/z/vf/9LI0gnDab2pNuBBNkNEn1IuRgT6gQZuJlCkf+E9PkPefuGwBaaxrjBGaBuu3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A5+BeW/g+Eo8QnutBr8spRVQWqW9qf06xwnSD8bWasQ=;
 b=hQKMwmX07Hat5Ok8NkniteCWfa7oh+yQ4UXBpsSJj/ZqcCfG2uuaJXhNU6YSGcWKpqct4WPFY+rA2zrM4yJOkWe1+mpRFcHadpzvQOV+/9BAZJ0kceim3gVPV4cR1XFPeGV/9z8tkMGmwrTu+UMDWcGfwRh5GHVsrw1JWqjEHUuMXG1eGpfPuIrY3dgGaeQ4UNiinR2rRhLge/hOohzUeidF5DO2MljHYbXeXmgdiPZOm34ou7tY7MUERO+7OMxzRo0DMoQouSu+9Kf4oLwgduLPLl+2OKQB7Cx6Wvu+YoVnrPKDuxKiGCMLFu7ujjQd0Jq5sxLST1KPmkhkNe57Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5+BeW/g+Eo8QnutBr8spRVQWqW9qf06xwnSD8bWasQ=;
 b=tAz7Ux+NGXmFstky6ZX5hkhYomQV/BYpLYm3L/CyL7WzRhOsSGy1r5Hl22RwzBOhJ9RvDAEvsPIMe7TSVGDt3cjopgtMAimb+DCx+S5SQp1nuDAhe+XiL++UEsAzIQPWrDJNwOW+Usn/B3zPQzaEq5+Fojsx7GJGldb7K6Z7gqg=
Received: from MN2PR03CA0010.namprd03.prod.outlook.com (2603:10b6:208:23a::15)
 by DS0PR12MB7996.namprd12.prod.outlook.com (2603:10b6:8:14f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Thu, 23 Apr
 2026 16:42:43 +0000
Received: from BN2PEPF000055E0.namprd21.prod.outlook.com
 (2603:10b6:208:23a:cafe::5c) by MN2PR03CA0010.outlook.office365.com
 (2603:10b6:208:23a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.21 via Frontend Transport; Thu,
 23 Apr 2026 16:42:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055E0.mail.protection.outlook.com (10.167.245.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.4 via Frontend Transport; Thu, 23 Apr 2026 16:42:42 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 23 Apr
 2026 11:42:42 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 23 Apr
 2026 11:42:41 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 23 Apr 2026 11:42:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Pratik Vishwakarma
 <Pratik.Vishwakarma@amd.com>, Roman Li <Roman.Li@amd.com>, Mario Limonciello
 <superm1@kernel.org>
Subject: [PATCH] drm/amd/display: properly handle family setting for early GC
 11.5.4
Date: Thu, 23 Apr 2026 12:42:25 -0400
Message-ID: <20260423164225.2345139-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E0:EE_|DS0PR12MB7996:EE_
X-MS-Office365-Filtering-Correlation-Id: b2cab363-320e-47b7-9927-08dea15756c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Xf7kUmkUZYGwEG5JfUnx1cTIuFkTnXDMuSVk9tjgJC/bwuUYlEtLW4ceLhup3B0mRYmxFDNO6t/lgn9poxGUd/aK1RezrMlg9Tcpcv1xt8pn43YgreRUhKjQIThPL3kqT+0oxrMhJKPgR8n0QVK4Th/Rc2N8k76Zbm7UPMqaaZtB0umFoA0JbYIK/6Z6E7uXtcbJgoq0XEsgdI7Sf4gJBD/3/C9aItohmncdfP3GRFbOz53ebAnQBZrY0CHaMCT7mmE2PJeuHEwKwGvBW/rTsAPxg3jmi+MMat0VEzKJt8NGYhoY4zrjqfcJwnYAjAp9p2gGJXyRjeWwSUbZyMMEtnlElnELtkYxpI4aOrIDmAO5KVNYT50B4Pkvf3g1e3pH4G0c+ailfWqkOQn4MZ5d4G9Bwr9P4btoV9K9v+st+aH7QbHjuRm7eKUqAKiPrLZk4/J81BPsGb0IsNnOefNk16kgfaIVVdFSH6XmrLxfDVFMA5o7hey+I3Du17dm3XJs2A/FfjuYbHAEhmp3H4pSfAFCKR4CnrAGmlLCxGglMFOiS6tBLYVsjAEqDFPZNoNTsVS94B1Nvg0iyEL8FhyNNbEaGpo4IxRpdwa/BOX9GkIlJy/3V2elosuyU6olNGnTo1kDRH4ccSIrOk5R6t62KIEoI4hxJ7CyCDObi1Bcdt9bbWXModFYEGyvqAfthfFurvXjyzcT33iqipKLggHmQ94ZpBOXjDN28qcCJAmkxyS6LS3HM3WOWbxLnT1m5VvtbPvaEUB51Qf2RlGaVtXe/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +RtuM589LvAXgWhzxDmwutQv3i8L/lrabEtS74TKtXFarX9j5e/2guQX/9fTl6XlxuG4V1C8Av4qnOw/9ArDFkCFGCfyqCPqBPHjDPBEqbl1nq11EdqH4Dlw+3MD5p+mbFROq0kMpnj0D8gvs/F/AgNFvjbPi7rnkPDVoTeeS7BhlZ/MeMJUDspr2PMKoxDWeeLacJnJxe7rE5tR0LXnDfGEuY6AJYntN2tBH3kdam6/OwWdGrcGS7fXCln6gVO/L6NkJft4SFcPu+WveaHUdpsKW+w9hJ4uqgq+OAlcfDz2VG8Q4shpeR7Q+pjGVIpqQf/AKGP4XIoguCF0wSk7Hh/h7WIQUPFUR5cz6YH0evaHI1aQai3rP1meHNQmDMOCC6PsJmIREZLR28D5W9tDJHnY/WuGaMeevvlAJBwJmDU9M8TuB5CVdhzuhaBu18Ma
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 16:42:42.2949 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2cab363-320e-47b7-9927-08dea15756c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E0.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7996
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

Early variants need an override.

Fixes: 57d00816c6a9 ("drm/amdgpu: set family for GC 11.5.4")
Cc: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Cc: Roman Li <Roman.Li@amd.com>
Cc: Mario Limonciello <superm1@kernel.org>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c     | 4 +---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +++++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 31d85606d31b5..5dbe3d6963b9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -3091,10 +3091,8 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 1):
 	case IP_VERSION(11, 5, 2):
 	case IP_VERSION(11, 5, 3):
-		adev->family = AMDGPU_FAMILY_GC_11_5_0;
-		break;
 	case IP_VERSION(11, 5, 4):
-		adev->family = AMDGPU_FAMILY_GC_11_5_4;
+		adev->family = AMDGPU_FAMILY_GC_11_5_0;
 		break;
 	case IP_VERSION(12, 0, 0):
 	case IP_VERSION(12, 0, 1):
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3fa4dbda4517c..a8e6bf3e116e4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1967,7 +1967,11 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		goto error;
 	}
 
-	init_data.asic_id.chip_family = adev->family;
+	/* special handling for early revisions of GC 11.5.4 */
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 4))
+		init_data.asic_id.chip_family = AMDGPU_FAMILY_GC_11_5_4;
+	else
+		init_data.asic_id.chip_family = adev->family;
 
 	init_data.asic_id.pci_revision_id = adev->pdev->revision;
 	init_data.asic_id.hw_internal_rev = adev->external_rev_id;
-- 
2.53.0

