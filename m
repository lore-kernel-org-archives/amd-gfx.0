Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6582BC25B10
	for <amd-gfx@archiver.kernel.org>; Thu,  9 May 2024 19:36:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01E7C10F1A6;
	Thu,  9 May 2024 19:36:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SPrP/2x+";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62E5610F1A3
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 May 2024 19:35:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=liDmjvnZZYosFb7iYU4Ka9HGM0dc8U99V8XpyJY2RCka5FzNHabTwJ9J4smdr1V7kgTMW/QriptavnwOOAZhI1yGMnDeO0Cd9JnG9su38+w8d5HfUIErjxwVdpEtJK7Yd+AfHHDlWiSrJULcBaGDkqhBfl0pSZ3UdHSTYeXZcMtFNb7kKVzmCsRSgnshLd4yKEKvojXT9C+VXCLRR92HrNL/vVNKhLEhoSGkepbkoLFgdiMJiaLXQRI3KlRS3FObkUE6ionx3Kag3HRd7sAldMtJP9EskTVjDK1UA50iGwxzIindQGDrzw9DeKiME5H0A/GLfJb1QOovlNZFquqZlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJt9intR1aVDTOuVRPQzuiIzAgmdPHutS70t+f4pNB0=;
 b=YPt3xzNnaD1W4bamq9bbk2U4RiOl8z7YB+toL0YuoZkMlbPjakNS2w31QBQzRnAEMcyJxBFzzv8A1K8fjjxqpNrlM3qEtfn/N+iprKIa7EXmzAZF81mN5WCB5IukKFkDiTDDmab9kvymjZuWSneYWg17gu9Av2CuvYcyo3ISVPGny+m1Ah8NGLz5w2Xjltq4NQSVAf8xDNvOg+lCo3z4SxjyVIjHqN/boYlAo0LhwMTlwu5jyV7SPTRWvBJS373emQCyvKTpq1XhS2Pj9lfis+hxylc/Eg8Vxfv1WjxqAo2YKphOy0p12wEA14os3W9svQauNnmQkutExN1Alj+ZwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJt9intR1aVDTOuVRPQzuiIzAgmdPHutS70t+f4pNB0=;
 b=SPrP/2x+eUGMxMGfO+TA1gjMxegfdqcgWxxEIYfyq3xCv/gryUewQfH+hHVdscIgIBFV9TQVejdIlZymla+vZ4BX0dZAvV0BJ8LoZdmlfmSkYDnn8rXxU24RvKEBgOOuAyF8RuMFd9og1YRzeumEFQfXgHn1kyrXEAWKDWaHSHY=
Received: from MN2PR12CA0003.namprd12.prod.outlook.com (2603:10b6:208:a8::16)
 by SA3PR12MB9158.namprd12.prod.outlook.com (2603:10b6:806:380::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Thu, 9 May
 2024 19:35:55 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:a8:cafe::24) by MN2PR12CA0003.outlook.office365.com
 (2603:10b6:208:a8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46 via Frontend
 Transport; Thu, 9 May 2024 19:35:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 19:35:55 +0000
Received: from birman-stx1-09-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 14:35:52 -0500
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <mlimonci@amd.com>, <benjamin.chan@amd.com>, 
 <king.li@amd.com>, <bin.du@amd.com>, Pratap Nirujogi
 <pratap.nirujogi@amd.com>
Subject: [PATCH v2 3/3] drm/amd/amdgpu: Enable ISP in amdgpu_discovery
Date: Thu, 9 May 2024 15:35:31 -0400
Message-ID: <20240509193531.129092-4-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240509193531.129092-1-pratap.nirujogi@amd.com>
References: <20240509193531.129092-1-pratap.nirujogi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|SA3PR12MB9158:EE_
X-MS-Office365-Filtering-Correlation-Id: ccb5c805-2101-4307-6d80-08dc705f3e7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?547sPQutZDplI5iquMWbON0rxvkRVHWIdRbnQfXo7HBaDHmncN2kXsQfhRvw?=
 =?us-ascii?Q?eDCrN9KMOWIrMD9dUgZtVpGC8vi4pBIiNX+/e31KOjKOT4UFEJhFtQEatzxT?=
 =?us-ascii?Q?TLpBGTCv9U5vX9N+a2uEalHjDpQZZ9WND6kRVPCFHN0y6kSglJfawUQcHS8q?=
 =?us-ascii?Q?0YqF9BonwvjcNMlg/RwPCpyEhVzRhyUH/5DivmKxnNWhFKCZ8DABrX2SOoLF?=
 =?us-ascii?Q?7B29lUTH9GZzLeCutIYF2/2WzPsDWPW0MN4Cndz5Ghwom/QUDNn41qrh2r4N?=
 =?us-ascii?Q?bipgRfzlDEbGqoDvq1gqf4bnJ9Rn/1pz3ckcMbpnOxBKtYDDLmTClypC1Mmu?=
 =?us-ascii?Q?m8oSJMec8Woxc5S/7ItOZDkmkX2g5D8t4BrV0TUdk3QFikJwRobrPJahOlQ4?=
 =?us-ascii?Q?7gpUgjtgB/CYwQCDrPmL1MomWD/v5QVP1UIwKVZNMVKKV/TNow3KJtPrEFQQ?=
 =?us-ascii?Q?cP9yM6mTKuZBZ79usiD730zCYYsQ4OKl8iI/TTDe2arDBkfxFiHx7dAGdXX/?=
 =?us-ascii?Q?thbEN6BPvGpDLZFLtQCHjWNyIb+hxFxT0/Vaygt6t8CI0ry9fGDPK6R+Juv6?=
 =?us-ascii?Q?3HFQz+9RAfs8FrutPBnNSSYzqqAfEIGx3MlYrm6Mva3zCWA8lE8beoj7qLQn?=
 =?us-ascii?Q?4bmHUjocD3VniazEPX5mjLgoCm4MjsuzwWIWhL/H/X96z3SkHQQXF6r1IlVY?=
 =?us-ascii?Q?fE5OWbMXy3/L2vBF9wS54lWaHJ8ig3Tw72aUB67FdnXe28J39yX/uHTBdDXp?=
 =?us-ascii?Q?wTaH2wtGMnozx9zj0ldIHb29eAUcsYMwc/WoIJ/pmzbsOLmZBkmKwnq7jqvM?=
 =?us-ascii?Q?QmRjk1NuJKeT/xOSNRut2J5CbipHMdSMSNtazA9YjyWdhaJxH8dVJPtnGDTZ?=
 =?us-ascii?Q?XT0mnaiXJMJOmSmwV+Rof0rggFAsuSw7ialAJWRrGuldWLm+BXzQ6Wh7dAuB?=
 =?us-ascii?Q?pSplvdoV+wJkpJ4z+5kK2clTf9grfqJ8xfWbm1uWL0ecq3UEdEPYA09R2E1i?=
 =?us-ascii?Q?vNswAXy14zxSDabFdUJbm20A8zATWVEqBgV34V7Usm5MKCVF37Zyi21YPuY9?=
 =?us-ascii?Q?iJV+ixFZUfyJvUNwsDk7VUvWxhFLM9ht6c6aXeaZVkKSAwh3rfn7KR8oAc1s?=
 =?us-ascii?Q?LgU32cg+nWhD0/yKk44EDL/+z4NkRKUZyzIxu/GHVlce1ZgAFHSx2Hr/tAUF?=
 =?us-ascii?Q?vXtAPbdTiD9787jfBSuo0qHXV2Q4HM3/h+CZamCAid8IRRg+UV1G8rqdgYbb?=
 =?us-ascii?Q?zphMFtNSh/RWPIigUH4JYPOwd/whSTomP5+qvR1kXLVq9WJi9SzzuzYQpeTg?=
 =?us-ascii?Q?Q5cziwOwhJKQZCYvNu5LJymPZwQINxPZnawwsWqe595JB/zkfqBSkBugvyE1?=
 =?us-ascii?Q?xKC+X54=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 19:35:55.1910 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb5c805-2101-4307-6d80-08dc705f3e7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9158
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

Enable ISP for ISP V4.1.0 and V4.1.1 in amdgpu_discovery.

Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 6586feab8c2c..82d064adaa49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -107,6 +107,7 @@
 #include "jpeg_v5_0_0.h"
 
 #include "amdgpu_vpe.h"
+#include "amdgpu_isp.h"
 
 #define FIRMWARE_IP_DISCOVERY "amdgpu/ip_discovery.bin"
 MODULE_FIRMWARE(FIRMWARE_IP_DISCOVERY);
@@ -682,6 +683,10 @@ static void amdgpu_discovery_read_from_harvest_table(struct amdgpu_device *adev,
 			adev->sdma.sdma_mask &=
 				~(1U << harvest_info->list[i].number_instance);
 			break;
+		case ISP_HWID:
+			adev->isp.harvest_config |=
+				~(1U << harvest_info->list[i].number_instance);
+			break;
 		default:
 			break;
 		}
@@ -2303,6 +2308,20 @@ static int amdgpu_discovery_set_umsch_mm_ip_blocks(struct amdgpu_device *adev)
 	return 0;
 }
 
+static int amdgpu_discovery_set_isp_ip_blocks(struct amdgpu_device *adev)
+{
+	switch (amdgpu_ip_version(adev, ISP_HWIP, 0)) {
+	case IP_VERSION(4, 1, 0):
+	case IP_VERSION(4, 1, 1):
+		amdgpu_device_ip_block_add(adev, &isp_ip_block);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 {
 	int r;
@@ -2829,6 +2848,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
+	r = amdgpu_discovery_set_isp_ip_blocks(adev);
+	if (r)
+		return r;
 	return 0;
 }
 
-- 
2.34.1

