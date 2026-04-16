Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0010AF433DD
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 03:45:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91FEF10E80B;
	Thu, 16 Apr 2026 03:45:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VuxIBw8w";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013001.outbound.protection.outlook.com
 [40.93.196.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01C1A10E803
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 03:45:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ThHwAIO/lwoniHGY50ZPPGrtu30XFQA9Cn9c4RrsG9OmUatwOil9p7g3bxU6L4huc1yEzRQzKB3zjZdlw32oFTWj9IQF7lnS4JUvpYxnJy+q8C600Yp15rWpquCykQmZRdB2hqm7d20GNiHGLRIbfDa8rNe56vf86ON4ahJwb5Ot3X7XgZghd9P82TS0roumtk/It2WorbG5P2YYRr+LRv/Fe4yV3AAC8OZHwXwLlxTQnWmnpeb97X4GxicwBxkHI78kLCNCmjhtoDXDmjQUVqXhS37TbTAPvNGqmCij2dhmKvMtjqsOurHGsii7xQUH2dSpRRb9/jaaVGhKqDHqwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQDll/tUFcRe9WqYI9QYTP4JqEP8rOiSjxfJRmqn6HQ=;
 b=JAL9q5l6wCmvaMJDkFc49y/UAYG/U6G+AYtYjox0GVTfYgqv9aWQ/CFKAuqh4wECKik7G34adtzY+z7HlhkR2x6xVRWImA7+Yc3F3nLB+Z24RMCT/3Tjd3+T5y+LQH0NR13HNMTVnTqK2H4LSWEoriHRfmiewGOMSbomoY/PavG14W/b6hs3ZPmX6d3Qn/RmVXonhqkEI+QfCv2JRnacsUc/080i2d1FA6Og7XM6r80mGBCfF1CLXjI/xt+zZz5831u2CgDClT1V4TKeV2hclqfHOPK4PIACoYOFKwrLVoKEoX/vN8KKCQoyzS08Z7HCB+oMrIzyJSo3lRAH56I0BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQDll/tUFcRe9WqYI9QYTP4JqEP8rOiSjxfJRmqn6HQ=;
 b=VuxIBw8wmpQ+o2H48Te0eqWn6BiVB9yFsDuivWdEcZGz3wwf7ioF5OpPrdTuqVuXR3AfUDQ+8P3wWb6v3wXUJIfH2/ArAWGel+8ruOMhWnQ0fQBSx7taaMoV2A2gefqGAarsZB/JhYfqwOZmhnd+Mcf6cao3CCmhn4/qaYPMD5Y=
Received: from BLAPR03CA0086.namprd03.prod.outlook.com (2603:10b6:208:329::31)
 by DM4PR12MB8452.namprd12.prod.outlook.com (2603:10b6:8:184::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 03:45:00 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:329:cafe::e0) by BLAPR03CA0086.outlook.office365.com
 (2603:10b6:208:329::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.51 via Frontend Transport; Thu,
 16 Apr 2026 03:45:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 03:44:59 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 15 Apr 2026 22:44:57 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH v4 10/11] drm/amdgpu: Add memory exception records to
 WAIT_EVENT
Date: Thu, 16 Apr 2026 09:14:19 +0530
Message-ID: <20260416034420.2368152-11-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416034420.2368152-1-srinivasan.shanmugam@amd.com>
References: <20260416034420.2368152-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|DM4PR12MB8452:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c8fb7d4-d78b-4a92-d83f-08de9b6a88cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 12IOWmMxo4mg/JwjBhz2hXYVrA0PWq1ev59OXa8bU0wERW+MDT9WwrQnZpw9GVfNlHRb033Xa/vJadNoNCRVkSEoYCTmufA5RlV02SJUcEy2nXNggk1ncH2Fj8MqUU3hcJ/6U+xyUlwRqYTRIkNavys0suj5ON1J5uujCzdepcN16ERVpkYLtUCbI3FtNXN6xu/iv4S8/LVGXql8r+vnDjk+SFzYFuNS1GoWXMjZ3Ym+7xzweN0NDv63eYmCo8wWcWrlpypKwrkFVdDwH879AWyBkIabjTlO3+0T7YaivDvD+6915PrK+FnQElHFjapZOgZaTOf4PtRi6cMn94T3gPzElSBhMTwzMXVt/tZ48K8oL0QQR/R8CzG8RQuIMa1hxlBHY+1wrQ44TkG3GOULiYNbncaBUS7NSCQUR+/0YsbWBcEPNmJOiV/EBhgvBsfbpm+0EjGBOqlYLxlU6TLSY4KQD+OgSRTmZ//bwTIT8xF+248ZmCm5+dVyF4Yi2l8HzQlzn9jC2JKngwV+f22cLmO0yhYsxyZ563LHGaHU9S2eBwXMGUlKgRU6CXTUcpThS3ez6dQ8nrnDdGJRdKvaXZCgCIcm8HmoYrjpWZWANVX7JMvhuszxQE4ko3vOpBTCwEAuaBLjfB6WPxUvxN84RhOYLCS+v6IfjL1db5ZgTnBrobjfpV4MbTlklVRonhe54fNIlIXusuMYPBFiQvkmw0vGoRRGvhp4pAB/NlM1XUyvmpMVTZFZhnSeQmlIlxc1wNVXgiFNkXQjYcFrIwmhfQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hszpEbqMlUxTtT0ho90j2gFpb/kdU1uZ96hHne2quuhDN0PNCcIncDYkfg6bPZ7+rfQ4WtaY8/KG1UK79jcKKX8ce9I+SCaT2+aVDu5qld9GI13Zv6iHbeiA77/1gwWUf//iFxuk4kYSRRo/FyG8KoWYt8aDX4Fi5qFJs3skBO4wvl1ntcqugmFMFoHJciGS6qEwf11Fm9omLU583psMNMmEMwX6Sie+9NKzma6CTnH8ltJV45QM/s5hejkB1umkDBCbivz8rCmJHAhXEsMVLkntlWYKhAXROfI0X2twdAOKe9VywLrb4pBRp5MI8EswBRPfA+83SVsNHEiqLgRxJz28Ejk0Kd0rseNP3uK2y6jZjLlyRLLEk0qNB1myGyQ2XuO3f26Vunfv8W11k9SNvkow7kiIVkw8+XvMMzScExSwti5IldtUaC5Xf1m8ifXL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 03:44:59.6731 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c8fb7d4-d78b-4a92-d83f-08de9b6a88cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8452
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

Queue memory exception records into the WAIT_EVENT path from the
KGD-side VM fault interrupt handler.

Reuse the existing VM fault interrupt handler which already decodes
fault address and status, avoiding any additional fault decoding or
KFD-side dependencies.

Emit events as GPU-scoped (queue_id = 0) since queue association is not
always available at this stage.

This does not change WAIT_EVENT UAPI semantics.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index d49fdb70045e..9d03921927c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -26,6 +26,7 @@
 #include <drm/drm_cache.h>
 
 #include "amdgpu.h"
+#include "amdgpu_wait_event.h"
 #include "amdgpu_atomfirmware.h"
 #include "gmc_v11_0.h"
 #include "umc_v8_10.h"
@@ -142,10 +143,16 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 			list_for_each_entry(file, &adev_to_drm(adev)->filelist, lhead) {
 				struct amdgpu_fpriv *fpriv = file->driver_priv;
 
-				if (fpriv)
-					amdgpu_eventfd_signal(&fpriv->eventfd_mgr,
-							      DRM_AMDGPU_EVENT_TYPE_MEMORY_EXCEPTION,
-							      0);
+				if (!fpriv)
+					continue;
+
+				amdgpu_eventfd_signal(&fpriv->eventfd_mgr,
+						      DRM_AMDGPU_EVENT_TYPE_MEMORY_EXCEPTION,
+						      0);
+
+				amdgpu_wait_event_push_memory_exception(
+					&fpriv->wait_event_mgr,
+					0, status, addr, 0);
 			}
 		}
 	}
-- 
2.34.1

