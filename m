Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D0B5CD4F54
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 18:34:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AECE1123BF;
	Fri, 29 May 2026 18:34:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TjNM7MIz";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010038.outbound.protection.outlook.com [52.101.201.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D74C1123C7
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 18:34:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLYR5yEzsm5DriYROeJb/bH1iQlpZVj6q3hicq3DtDMSXVlDlJKpkhGpUU+Tb5mpphQU3a1EMSuRX/DWrfA7Z1P/GIQ9PyU6mwHoTg4cbWBNtYjFK8VEuhawm6z6P6Y7ht1FDNKsOB5/9uwbEaMeanqli9/odMFSlr5KU6iHJ2dQoTtGlrchPJwWZqfE61eIdLyr9wkQ0CXnJphnkF8bJQ8rlKjRRy7JDKMrRctuBdMG+BU4ARqjLl5V2f71rwYp5UONG+YdjyIFusjqDwU8JxvjDasqYtt+vIhltajhlUi8V9iL5iV0lP759HIG/BSHgPHzJkPVbFr3hP5cQNkT/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=090NYwXvJ0ubb9NEMWZ6zWKvw2ZI6J7cNwkf1OgUSso=;
 b=EtZXRQ+wuT7dV3OY+/fcCD8ZLc5Tk+kwt5hAG/C8B7I7oEWYD9iy3GgbB9q/9XAfT9JKfiVNd+QNd6hEHb7R+4WjgCg2a2Q3FDsRNjCHNaVczF2JNag19I8pZIBWGxoJVM7IxfQkMc8B0BgPXWgztzeSDK+RhVWp1Ch9caE4HVSq+dlpXanzkpAH2JxPtIle+Orj1lZUCtpLSB1TnmsCd/6J1qsPM22H48xoeYvkvgH3dF9jaE9sx7bZeIar1ZJZJid1zP3hCbR8QhMJ+FA5LbY5Sl4PvC0u5rQNMe3WPI9PdzgHYzkaxZM2Cs1BPMVxDvyiE/nlci09gQCwj4l0YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=090NYwXvJ0ubb9NEMWZ6zWKvw2ZI6J7cNwkf1OgUSso=;
 b=TjNM7MIztMKSQQkVjUngp6oMV9pw5B9ZrwTNucaZUTR4+w3zLcx3nfFFJarxRgNkqSEO4Ryf1pAw6hGSrVceOfYTTyLBcyZ0ntPm9AA3If6/R2ovIRtKIMVkKe/TSR1j+eMVOpez6v1rEte/tNFev+iEKwDP9trd2Z/gsyUjNN4=
Received: from MN2PR01CA0059.prod.exchangelabs.com (2603:10b6:208:23f::28) by
 SA1PR12MB6752.namprd12.prod.outlook.com (2603:10b6:806:259::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Fri, 29 May
 2026 18:34:02 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::6f) by MN2PR01CA0059.outlook.office365.com
 (2603:10b6:208:23f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 18:34:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 18:34:02 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 13:34:00 -0500
Received: from AB350-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 29 May 2026 13:34:00 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Vitaly Prosyak <vitaly.prosyak@amd.com>, Christian Koenig
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Felix
 Kuehling" <felix.kuehling@amd.com>
Subject: [PATCH] drm/amdgpu: set noretry=1 as default for GFX 10.1.x
 (Navi10/12/14)
Date: Fri, 29 May 2026 14:32:07 -0400
Message-ID: <20260529183353.64803-1-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|SA1PR12MB6752:EE_
X-MS-Office365-Filtering-Correlation-Id: 61237880-f9b1-488e-ca82-08debdb0db3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|6133799003|18002099003|3023799007|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: oKlIGEoyt7vrygg4+Yf+l8OrdnTcCJz1gXTTotklsocWpqBKc7ASrXigwwoNhAqAyQf3tOPYvKE7nIvWfY0K5+tAQbvg6igYFNx9Nu9QHYnWsFMn9lADWeB1EZ85xNwB5xBMW4+NvAtnxcdRcAQeY4xZllTkFyd1HzdrxgaYbGqcAWOdhjspnhhkI6pXGCrtjmqcNBrOut9mVHCyvQQSTtCg/nSvyWWMQLgup+UX/5C5pW18v2ENkatQeUE1L16CSFsamqlzvZuxq746VlIdoj0r4LOrTeVR4IZwMEX0JjSwoHmBt9nYwAhW/TvHLFwYVZraewbHLmlES6XzotQIoQhHSr5X5q7oX7BEh5ueqpOznRlF9q+sffSS1pqcCGaFsZmaWnl+y0cEFZE271+TSzyAxaO0XYWg+B1JW7n5VrNsCuBg6HKKm7WApC99dssvZykwTB6tSmR4X5PuUOy9uvPmsPq/s9OPDlhK1PYW+fJCVhaoD83exm6/4ZBowojhulWxPWtKJJ9phuNSWmA80LQMx4D0BfpMIn8Z7N9i07JOCr7knpAFbF7Uag7vm7NTnTPU0DEtRkMIuN2T/6xLPvrKGrHC1nkcuyOXsVuZxKVWaq83zhWOrhgVtMu/AJ03UR0tEzp6sRD4rM3jaPqAu0qxr76FGH1UAB/CZnNC7G0cIF05ih4W7M2hfzFl6cG9bkt3FW5zoWXHoUCsG6o3fBN1Rhb5YCI2f1ft5+7epKM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(6133799003)(18002099003)(3023799007)(5023799004)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: K6HqBg/gsx8xCeQQiL/QHn9VH7YYlW8WFsMqmKeSJGlEbtFIdVmtd5eKguJZrRT5QdWoyJXj0+EgVI/zOn5df1BLkVCFHRUUZESJdTNV6OFEPaZlOsar1y6MxG/Ez4onA/7WF1eaxJPAsEWvposZk6xC8+ltUrBt8EZzEgJVtXcrW9g6uvYYxqgTp6H6GPjD1KPgukZsvpn7m5PHULSdGORi5eN6xZt9xNYfmKZ8gyy4aeefpWRUVwsi/qxyWNS/ayvJgVpynGfamMy871hfEfEAstileCSm3gHxbR5P93N0IAbPda5pdd5vTwA4F2ysd9AcqJ7bhf73vrJmEaGpBJnf06LgQydFlDT2SNYmTqae2xGUhVzbmdbbD2Qy6np4yfmGUq5whoJI+O+nsLFHFJGyTifReUnL908zpozx/GQHsAU2lbVZNhAP46RfBl9e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 18:34:02.2659 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61237880-f9b1-488e-ca82-08debdb0db3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6752
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

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

Problem:
While developing the amd_close_race IGT test (which intentionally triggers
execute permission faults by removing VM_PAGE_EXECUTABLE from GPU page table
entries), we discovered that on Navi10 (GFX 10.1.x) these faults produce
zero diagnostic output. The GPU simply hangs silently for ~10s until the
scheduler timeout fires. There is no way to distinguish an execute
permission fault from any other type of GPU hang.

Root cause:
GFX 10.1.x defaults to noretry=0, which sets
RETRY_PERMISSION_OR_INVALID_PAGE_FAULT=1 in the GFXHUB UTCL2 registers
(gfxhub_v2_0.c line 313). With this bit set, permission faults (valid PTE,
wrong R/W/X bits) are handled entirely within the UTCL1/UTCL2 hardware
loop: UTCL2 returns an XNACK to UTCL1, and UTCL1 re-requests the
translation indefinitely, expecting software to eventually fix the
permission bits (as happens in SVM/HMM recovery). No interrupt of any kind
reaches the IH ring.

This is different from invalid-page faults (V=0) which DO generate a retry
fault interrupt that the driver can escalate to a no-retry fault. Permission
faults with valid PTEs loop silently forever in hardware.

GFX 10.3+ already defaults to noretry=1, which makes permission faults
generate immediate L2 protection fault interrupts. GFX 10.1.x was
inadvertently left out of this default.

Fix:
Change the noretry=1 threshold from IP_VERSION(10, 3, 0) to
IP_VERSION(10, 1, 0) in amdgpu_gmc_noretry_set(). This is a one-line
change that aligns GFX 10.1.x behavior with GFX 10.3+ and all newer
generations.

With noretry=1, the existing non-retry fault handler
(gmc_v10_0_process_interrupt) already decodes and prints the full
GCVM_L2_PROTECTION_FAULT_STATUS register including PERMISSION_FAULTS,
faulting address, VMID, PASID, and process name. No additional logging
code is needed — the fix is purely routing permission faults to the
existing, fully-capable non-retry interrupt handler.

v2: Dropped GFX10-specific logging from gmc_v10_0.c and
kfd_int_process_v10.c (Felix Kuehling). v1 added logging in the retry
fault handler, but with noretry=1 permission faults take the non-retry
path — the v1 retry handler code was dead and would never execute.

Tested on Navi10 (GFX 10.1.10):
- Execute permission faults now produce immediate, clear output:
    [gfxhub] page fault (src_id:0 ring:64 vmid:4 pasid:592)
     Process amd_close_race pid 13380 thread amd_close_race pid 13384
      in page at address 0x40001000 from client 0x1b (UTCL2)
    GCVM_L2_PROTECTION_FAULT_STATUS:0x00700881
         PERMISSION_FAULTS: 0x8
- No regressions with properly-mapped GPU workloads

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 13bec8461cde..a9bb01c6cb58 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1014,7 +1014,7 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
 				gc_ver == IP_VERSION(9, 4, 3) ||
 				gc_ver == IP_VERSION(9, 4, 4) ||
 				gc_ver == IP_VERSION(9, 5, 0) ||
-				gc_ver >= IP_VERSION(10, 3, 0));
+				gc_ver >= IP_VERSION(10, 1, 0));
 
 	/* For GFX12.1 B0, set xnack (retry) on as default */
 	if (gc_ver == IP_VERSION(12, 1, 0) && (adev->rev_id & 0xf) == 0x1)
-- 
2.54.0

