Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2114AC021A4
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2025 11:50:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7F7B10E2BF;
	Mon, 24 Feb 2025 11:50:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FwORAiPW";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A11F410E2BF
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2025 11:46:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tjEnV15pqEgvaSQveEt0HphcnO3+Eo5bDb1B9pW59/vR1oTQggy6epE4547O0p8Db9RRBxa35uU/rc8Y2EUFImCNkcEY28pgBLpt835p+YpwlKPHq1tqzy0b/TfsmCZvFV6lGqmB7r2WJk/6+3aVa79lD0xCS8uUfqXuX7IxsKIK/mhtDiyvzbILWyumtWSYZxeVSQztMtt3vPbRAgkoLvjpeZ1uOW5lw9VPLbaNvkdxLv48Nd1BZv3LqtiDWAJCrnoomwbX03Z4EbK11Uul1S/hzFwSfHDqidTpxPZbUzzRFnMdQ7sLrk206kzdF6kh+xi/i9lUt+e0u/lQa79HMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vR13s7l3sNbagYww+Z+I3XK5Q6LxH5+UxFMrfFb9egw=;
 b=mWGJ+RCfijsLa5JJXj4GNBl5cZFZgSEPPeBEf8tPdTD1hAtMHOSIsZFNk+PCYwyoIY4n3enx68vE6vPxgbCfZLiErn+VCocXb17BM4qD13P5HPQFjRAPtAfUQ5uiZgN3xJiD0D3S4MucBVsOvULuAdz8/191dKO2n82EKI059arsKMpNcmy4dQqjl89DwskWfhxt4LGBhOSIb0QQteNzfNQG5Wvi5glRpaH0guMxXf2Xz2ZtBXQKYUTv2zu3PNx4Rhz1+8dA8+ypK1zaTpZBI6cEEGtSCntSYjFmX6RJ3aiXScR7tZ87geBECkWW5qfYc5n50LFZ84WbzFp3rcpCPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vR13s7l3sNbagYww+Z+I3XK5Q6LxH5+UxFMrfFb9egw=;
 b=FwORAiPWg1gGoVEHILnY+RZC2W0MZyA6Xdv0wt6VrS6sovClH6qR7+JdNAfDSBM2q/qu6tNojn9W4MJ5N56Tmaf//HuzUJZnV8ZQZ07tNgRAKBuqG7ASMlMaZSNto4wgi9aRWLBUwSy/roz26gckrpM1JTZ+Csz2TA/FBEhw2Ew=
Received: from SA1PR04CA0023.namprd04.prod.outlook.com (2603:10b6:806:2ce::27)
 by SA0PR12MB4445.namprd12.prod.outlook.com (2603:10b6:806:95::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 11:46:36 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:806:2ce:cafe::2c) by SA1PR04CA0023.outlook.office365.com
 (2603:10b6:806:2ce::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Mon,
 24 Feb 2025 11:46:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Mon, 24 Feb 2025 11:46:36 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Feb 2025 05:46:19 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Add missing parameter for
 amdgpu_sdma_register_on_reset_callbacks
Date: Mon, 24 Feb 2025 17:15:50 +0530
Message-ID: <20250224114550.2289805-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|SA0PR12MB4445:EE_
X-MS-Office365-Filtering-Correlation-Id: 04ce908f-22da-48de-0afe-08dd54c8e4b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SE1lb2UxM0NMWnpyMzVPOTVxK1B0NlBpa1RycXBXSjQxbDIwbjNodStzU3o5?=
 =?utf-8?B?dURGcFVkeEFYY2Q4YVBEYXBCNnFybDNlRGxhRWRqMXN4REJOOFdUTnRDdGZm?=
 =?utf-8?B?djNDRm9QazdabDBDR1UzU1Y2aUJiUUxJUWVYZDhWeVJySURIRGlYL2o0WW5Y?=
 =?utf-8?B?K2Y0eWNkMHR1YTdOcE5IV0pJZE1OWW0zT2hQRkk2ZkExRDZBTGVMNDF0dlJ6?=
 =?utf-8?B?TEY1YmJJYjJ5dzduZm9jOU9rZ0ZDb1RvUmszQzRNTEFMQzJickhqOEltc1oy?=
 =?utf-8?B?L083ZlkzenozdXJCNWZFV3dEOXRnbUdzYjBYb3ZOQVc5QVN5SXlOSzloVUtJ?=
 =?utf-8?B?TEFuaE0xZFEvMVRPdElxeUNqRGo5QlBWTEFJWWdBVVlWVzVUU1BNYnVwUWVs?=
 =?utf-8?B?Z2dETXpvMXBTOGppU0ZRR0hpYVB6NjIrRFplUThYdTFaQWs4aW9qd2tkT2Vt?=
 =?utf-8?B?dUhDYS9rWmtuOGprWWVXNnN6RjVIWjZNYUNXcDBFT0hvOTM2ZDAxVTBJNmFr?=
 =?utf-8?B?cVpIYTlPYmh2RnJUSnlVeVVreDBJZjdMMUFjNThYTE9IVmRING03bmhGSmF0?=
 =?utf-8?B?dkdWQUJFKzJaS0I3Sk1pSEhFVktRZnY5dDc4UWZLOU5JQk1pUHdOblNlKy9h?=
 =?utf-8?B?STloVE1jY0ZSTjEzNzRCbjVEcEpLWjF3azNuakU2d3lmbzdxRUUxVENtSCtY?=
 =?utf-8?B?emtlZ202TGVuQW4raklTQ0dKYVZwdjRuUURqTW93UzJPMFF0Q3RYYjhHUnRz?=
 =?utf-8?B?bGJkSGJLNXlxUE9Ja0YydTFORW1SYnh6L3BqSjF6K3FYcHNtYUVIeEs3YVlD?=
 =?utf-8?B?RHZyNWZyYk9McGFMQ0RKTDM1RGlvb2I0STVWWEJ0cTlUTDh3UW9FZnlPcTE3?=
 =?utf-8?B?RjdWQ0RQRHhBSisvOW5HMEhSZC9lbE1JUW4yVlRLWE44ZDA3UGlYdVcrbHhk?=
 =?utf-8?B?L3pia1lsYU5zUWZoMnNtdFNKaUJVbkF2WS9VTjZTTzRHeWVSUHJabkpXRWxP?=
 =?utf-8?B?eDBPRHcxK2lRb09IRnJzLzZjem9Qc3QyWFJrVWd4SFlsbTczaTV1T0p0ZTBl?=
 =?utf-8?B?MmJjbUhHRW9yZ0R2YkdjVjk2RHJ5VlZMVm5HcnVHZTNvQUs1dTNSSGNjM3la?=
 =?utf-8?B?c01SYStQZkxPU2V5VWpHK0V5TjdjWklJVk53YTBWTUhaeXJaWU9ENjI3WnpF?=
 =?utf-8?B?RDZ5TXEzM0V6Q3c1NkxVMW9YOEs0NVZJcHc1aVpRa0lSWHc1cEI3dkZnR2wy?=
 =?utf-8?B?aUFqa1BPYjRPZWQ1VUEyMHYwemdJME5iU0c5eVcrMVptK25jNC9uV2ozNnp2?=
 =?utf-8?B?V2JodytMZ1RqNUZETnVEQXJvTmxHSVBhLzBSYW1kNnF4ZXdUQU94ZlR5ZG4z?=
 =?utf-8?B?ZWQ0ZytYUmlyVlRSenhsejV0WDVVT0VGR004Z3AwRWFGZXR0NWdvTnBTUlVW?=
 =?utf-8?B?U09lWHEycjRRWk11ekdzOGtDejExYXp6aDlDYnh0bmdlZmVIL2RGTkxGM2hF?=
 =?utf-8?B?ZnRXSndjVEVLWEJ5a1llK3AyWW5LUjVjWklLV1diZFFJWXVkRWRKNHJodXla?=
 =?utf-8?B?YlllVU5uUXV1NTY1SGxFN0hLUFQxVHlJOUVJVHNCem9FRjgvY2N3UEVJVVBn?=
 =?utf-8?B?VTJkQVRrTDUzdWZENEZYN1hsZkxQbkM4SXo3bUs3SU50RG9IZ2pqR0JsQytj?=
 =?utf-8?B?RURXQmtUYmY3clB1aDZpL1FpSXoyUEtBQ3NvdSsxbzRNZ25xSVZUaUdhMktH?=
 =?utf-8?B?ZmVoYkhDYWhQeUlVRDV4VXhGa0dXTjd1MmpRYmUzQjA0RDRKbFpaY1BQdnho?=
 =?utf-8?B?NXR2R0NsMmR2RlkvRHFJamUyYk5oazl6RnA1MnhPZWpTNHlqaGRGR0FBRFpY?=
 =?utf-8?B?MnBBTHRwZHdUakxJcStWSTBkZCtxNkpBajNJRnV2cUVRclRkQWx2Nzd2ZlNX?=
 =?utf-8?B?SERqakNPT2FtQTgvM0NOLzEwbXRDTnBDeFJiczM1WWk4cmJNRDI5bVkwZnN1?=
 =?utf-8?Q?HfYvZZ+e4SR0nddQd+MKarY++pUZqU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 11:46:36.2934 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ce908f-22da-48de-0afe-08dd54c8e4b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4445
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

This commit updates the documentation for the function
amdgpu_sdma_register_on_reset_callbacks to include a description
for the 'adev' parameter.

The 'adev' parameter is a pointer to the amdgpu_device structure,
which is necessary for registering SDMA reset callbacks.

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c:474: warning: Function parameter or struct member 'adev' not described in 'amdgpu_sdma_register_on_reset_callbacks'

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 42a7b86e41c3..82856592039b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -464,6 +464,7 @@ void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev)
 
 /**
  * amdgpu_sdma_register_on_reset_callbacks - Register SDMA reset callbacks
+ * @adev: Pointer to the amdgpu_device structure
  * @funcs: Pointer to the callback structure containing pre_reset and post_reset functions
  *
  * This function allows KFD and AMDGPU to register their own callbacks for handling
-- 
2.34.1

