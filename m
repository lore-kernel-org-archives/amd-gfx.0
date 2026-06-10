Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42837CD98C6
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 06:04:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D963E10E71B;
	Wed, 10 Jun 2026 06:04:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1o2rObIU";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011070.outbound.protection.outlook.com [52.101.52.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20C3B10E71B
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 06:04:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFhJtj54exMTbw54TFdOWCuLoEoPCJWzEskUhuFZGb50Ai/kuAMLvfKe4T5+ZeRuwSKwqPUGWfqX0RyuNNfM2vp3zLVHef+qKESCazO9CKeah7yRXkjxgiOMNxVO991XEJkRb4yOCEP1M7UY9n8ce1eFHKaiTvooOuoR5HsEgoWow53u5f79HjtF1jAsAF8E+gCDdWjm41FyzMrU69jfeBOlilu9KSJjvBkk3udkNJn+YhrTaLQUUAe0gFPyDGaCq8zhjPv+mLKdjlnNDlhgVPBW8AGPGM430F27uxleMjFQ/oRkvTjb4lJLjEr/f1mGrXzcaeQIF5lTtIVRYR14aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SmzqGrWtVFLgbVrZUplxnT2xwb08WNX4GEEMU3sUC8g=;
 b=xml1AkdpS4HsWFUp1R0Biu00GMzOpxa3r2iikJnxxSQ0Sxgv5z3bG+N+iBk8yl0B8+H5cp+umgSSzNs/bV3dPvBiNo7VXC8x9jKIPJNkmsgFOcLMQFl4iXW+MAb1QiC25sW2oExoGD0Ou4G/Qzk5ouMf3g5vjyYBfB8pyu1kVhww+Y3lmuF9TGmQ7xrFocosgT2aaVdrCqQHsKMmI0f8S4yM9t954ox3K9SxtSt7qDpMj03BJmzJDC17Sf/6TPSwCcqkSMBU3wLypwp3CvWyJBcskuoiJQwC9Xf2VchzMIiz+ive273Nars5ne+ImdM/MWXgWTtmcrRUWVobZeS1qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SmzqGrWtVFLgbVrZUplxnT2xwb08WNX4GEEMU3sUC8g=;
 b=1o2rObIUBeJ9Kpn9Nj7GXwy3N1kXhzHHCvgS9BzEheBYkgToSN5AzMbV/ZclKBxDeIq1DwFL3GNPfju3OGB3jGMpcxBaNYc4+HRTs2PB7mfKH031Jc0hQhsBdQD9I+W9Cd/CR11qwWlL16HMs9b7/0wTCsZwWcVRB8OMG9emgB8=
Received: from MN2PR11CA0025.namprd11.prod.outlook.com (2603:10b6:208:23b::30)
 by SN7PR12MB6743.namprd12.prod.outlook.com (2603:10b6:806:26d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 06:04:46 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:23b:cafe::13) by MN2PR11CA0025.outlook.office365.com
 (2603:10b6:208:23b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Wed,
 10 Jun 2026 06:04:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 06:04:45 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 10 Jun 2026 01:04:44 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v10 8/9] drm/amdgpu: Signal MEMORY_EXCEPTION eventfds
Date: Wed, 10 Jun 2026 11:34:01 +0530
Message-ID: <20260610060402.2769642-9-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610060402.2769642-1-srinivasan.shanmugam@amd.com>
References: <20260610060402.2769642-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|SN7PR12MB6743:EE_
X-MS-Office365-Filtering-Correlation-Id: 37c41420-ac61-427e-232f-08dec6b62c06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: M+BtG1UvAhl86p07JDERh/HEoR7S9EUc+Q690W34GkeiJZd57Hh6vCULZ45b2CxuzgTdWGX7iKh18ZnuG1IPjvi+dULYK3ER23Ibsl7uP10SZkbALLkqH3X5UuJbzB/dmcRCR5zGHOMmyHYmm+wk3ZxzPLRN32yEhq7+WqFm5hIEppViAVJLO1ode0CXk1WI1APf/2GE5AHrpzZJL7imccFvbBQQ6ggtNr9wgFyKmloMZyDensP4h4tfZPoJhR34l1n+1FdbmWXe4ovVOnuw2Unve2LySF/Qt0r+Z/0aYeNxMCw/xSGCNtR6Z0IwZ+JzaANd2x53Sfi6nT1D/Ls81JqPjnndOT87i3ZtNLYz/cdNnMWUG3+qjtzJQn3Ava+GKOqgO0EHfd2zRp17WLxy8IE2Ufcpg9owbuswNOzP7lw0ttEchrz4BP4x+r7MEMt25QXBQaTFZqSbkjWjsn3gy1ldz4UPRZJF+Y27LSRB/nNeBNi+Qp7Ohurbk3Pxi6Ff3SVJn8+Zt3vAU+PKDcylYNnukAUkdVDwGJKpWJMY1NYKpjtmI9xdpBX43KauBs5Zg7IQ90sl03NsmmZdh48XwPrJsTS23nvlRn0xyNjwQkwJyfmH12X2XygJNCzC2zUqJl2KHjI7kbZ6GmnQksLwnK2AYDsa4PprHdoZs3FiY1BVYgqghiqjxkIZzxniQycKsnTqdADlY1jrCEoAiKo6IEWKZHOv3oeKp/O1dA97mq4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: H/OSXDzgtD9EOYQMRVkr8qgl0S1aEjVygaQVqpFrqtLvl+Ai1D7kZ4OQp4TX/m2hd/6eDWQeas5kDG69D/wXCOuMS4oYXFcvu9w5ARiYmrVDjvQRuV1LuH2FznIoMOG6EMfedFhRp+NNsXBn0Mp1VVw1kLybQwiD8nBaaMQT92if6YKLeXoPrlFBXIP99EWRhHcp47vhKRBdMnZxd1t7cEqzX6YmmbVfH+PHkCGuTJogNvCHuSUI4wLAb8ufVRJo5fpvlmZgjSnb56zjLxi364SXxJ1YS5GxmU1OcoAiXhiDW8jW3UA/RyFXS2WPAVPG+bDugAz0fpaIQszjhiHcoLtXb/REy1tAW/0GcZc8ebbr/CbFsvT6bd5hCTlDLxtcEz/loKXumgpxv4mk0rJk6e1TkLrnsQMpQhqba4QJ4KOipdb9m1DW9YNuhSOqzdXa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 06:04:45.7765 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c41420-ac61-427e-232f-08dec6b62c06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6743
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

Signal MEMORY_EXCEPTION EVENTFD subscriptions from the KGD-side VM fault
interrupt handler.

Reuse the existing VM fault interrupt handler which already decodes the
fault address and status. MEMORY_EXCEPTION subscriptions are GPU-scoped,
so eventfd signaling does not use a queue object.

EVENTFD remains notification-only.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 8eb9847d9e1e..8b51b6f7617c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -135,6 +135,19 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 
 		amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status,
 					     entry->vmid_src ? AMDGPU_MMHUB0(0) : AMDGPU_GFXHUB(0));
+
+		if (adev_to_drm(adev)) {
+			struct drm_file *file;
+
+			list_for_each_entry(file, &adev_to_drm(adev)->filelist, lhead) {
+				struct amdgpu_fpriv *fpriv = file->driver_priv;
+
+				if (fpriv)
+					amdgpu_eventfd_signal(&fpriv->eventfd_mgr,
+							      DRM_AMDGPU_EVENT_TYPE_MEMORY_EXCEPTION,
+							      NULL);
+			}
+		}
 	}
 
 	if (printk_ratelimit()) {
-- 
2.34.1

