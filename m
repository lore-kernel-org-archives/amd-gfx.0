Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1759AF36B9A
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2026 01:36:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9103810E884;
	Fri, 10 Apr 2026 01:36:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bkk8S5Ab";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011064.outbound.protection.outlook.com
 [40.93.194.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D2D010E884
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2026 01:36:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F1NUJnep5MDvUGqDnS/ntK70IxAkp08gUVsbz/XBGpZgNf+lzC8qLW+ulOATMB1JrCieUK4WzO6h21KguV2Fwqxw5DMWpxGF9Y/ou3xnpT2WY+o47GQVJDRl7vcY4Q6LhaG2zOAlzaWqUNuqksGT9H4sKeE1o/FilTU+LEyLLDGRPtWZBpdID0evNCt5lJSlSVr/TCfNavNgAqPq5XAw94C3Qrto6wpivOuVKyai/VHYk80Mov408PtoxJ9K27w6uaPaP2RUD4sPDsB3AZBsP0UMABVP8AwUFmQ3v0nlzXg+eQa0lYlP9EcPsiiFS3Lqhyd4IBNJnxkerVHuxgViLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AnHiTfbV2ruDGF5sg4RuGWnYCJV0ciTIt2zxnJXBWas=;
 b=s+gVRZrZwPGZXFjNxy2eckQ+5IUHWM5gC8M102GNsBhQL3vAWCK9XKErIkW6EoiNQJKy+43OKuST9rcEPP0rWFR757WsmAKFleY20dSXvb43a8+PfTu8eVpRc8E5LBS/RWUSKzrJvMy3Fll42VY7NpBIC+bju4aYvdW7MOm+ETDO41/JOV540FPYYb6UIjnq7ivCLdk8o8YJJQe7wAH9CNwJQ5ByhPhF8gc79L5fBJMiLgYDB7MtaRWapj1chWsGZn1/dAb8Zgs/W7S3Fl1VkvBgjnj5jP/4BnFwTpOFqz8YbVWlDi8/90ZwTPPKRe8zTzQPiJFJjYk98mIbOAagcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnHiTfbV2ruDGF5sg4RuGWnYCJV0ciTIt2zxnJXBWas=;
 b=bkk8S5Ab8JS2MrqXKwBkl6GBFANKJC1ZZNx4vGRp5RaoicW3ikCyUH9dvdKl9ALx/1CDEnjdFuce3UWFx308Y1/5RLKV7apdpHNwGhT/dtF/zZeRl7MgUm1bUWRcjUsRsIlwkOLiBNqbpKnfOF+38FMDM64x1Ky+1ZiSkBzKVHc=
Received: from BL1PR13CA0450.namprd13.prod.outlook.com (2603:10b6:208:2c3::35)
 by CH2PR12MB9518.namprd12.prod.outlook.com (2603:10b6:610:27e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.33; Fri, 10 Apr
 2026 01:36:50 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:2c3:cafe::b9) by BL1PR13CA0450.outlook.office365.com
 (2603:10b6:208:2c3::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.41 via Frontend Transport; Fri,
 10 Apr 2026 01:36:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 10 Apr 2026 01:36:50 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Apr
 2026 20:36:48 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Apr
 2026 20:36:48 -0500
Received: from AB350-desktop.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 9 Apr 2026 20:36:47 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Vitaly Prosyak <vitaly.prosyak@amd.com>, Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Jesse
 Zhang" <jesse.zhang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: fix NULL pointer dereference in
 amdgpu_devcoredump_format
Date: Thu, 9 Apr 2026 21:35:52 -0400
Message-ID: <20260410013639.129917-2-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410013639.129917-1-vitaly.prosyak@amd.com>
References: <20260410013639.129917-1-vitaly.prosyak@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|CH2PR12MB9518:EE_
X-MS-Office365-Filtering-Correlation-Id: d578ae00-99a3-4370-5273-08de96a1a338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: WBgMLxYycVu7pYRUUhwKe4wZx279Uh36HFjpjwIjggyN4GPqN6V7b+E+grErxnLR613iS+quxvqApPc+gR6iwn63e8NgmKEDX4Xcwjwn5Sf8kXkoSJrS1WFXnyqPCzSTGGnAtkaLOJ1A5kfcip1gNdG0EMUlKEa3lnA5KmaB36CByO1fGuvq09ge350UFg078DVkrz9JIolfVAPHz5GbLEizyq0au+bcSKz9EmDVVPYurG+3wCqe5YAMPDDCQZIvw9cBrBCtO2dzcHmQyZFPJxF4DSJzY9kgHWnjqKP2QHEv1oUqWqW5N8emKciYI6PpFiHUBK/kd2WLkps3FtE0Y2FmwpDs+TWQBRP3HwoPW5AD2P6Z99Y6gJ31QUVQy4Ml7neen6AeZWK/973X3i06hpIc+gbqL+j67BR4oRV57xf8t6E7atXe0QRcYzkaadriA6YbvpUJ+y04R2fHNabL6Zi0e9r3FufyehgcIfBGIdXdHU6I3q/qyN5c+naGI4Zm5PdZtGSv/1pt8D/bbFE59Hw+01D4e0wT2orgxGjBVItRm1DI0TTo3C9cQOEiCgnrGJ0oGX6rh6u1i0r29+fTn67M7r2za0t8CZkFvw/B+BrflkZnoAtOlz4HCWb2cDTSLgKcEcxzX9oSD7ZXI38lIB0hHw2883RbPHt5N7xidB18SKWwIEGogmQpt972FNe2rqfke9O9zNzNFIdlnKRBrHSjsnyuyQuh5y0qwP+B9Feh0EeKlz2olySVACzx3iBuO9iD796M30h9VvGG1ERfiQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: o13L/XIJql5tSTJkYMw4qHPQcuRUOkKgsp5nxr4nmpTtgWV2oIYAEG7KLwJGIfKmWa0u/8fj2wNNn1o+5UdRcHYGjsD8MG83NjcvnRPDOXTsvkI8qMTFV5FQLGkGmnUcGZf87f6DBBDI0eDvemx9LvL2WXjVDQOZA56h0A0gFhwuHwFvrqKEKGFPBqWB+5p9zGq2Ajcr3Hqy0WP007KSdmohejuA5orST3GDtRS3b2JEEJtrFNuXQTWpR8dRbbGGssA/y/NvH9odAZnci8/vUxP1uHI0HOJoS3V7/9mU1Xu8oLZxZgWDGEJIeXvVCa71s6T7FENRJFn+B1R9ACpN8M6ytB0pjkirKB7vt447d83NQU85yo0AqsdBTPXyFHXy9TKoNZHpzQeH25KQecZhfjjVsTydrV3aqhH7z+RsjpOPUYPSJIu+ZC5I1BWFOfw1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 01:36:50.5034 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d578ae00-99a3-4370-5273-08de96a1a338
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9518
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

A race condition in the devcoredump code causes a NULL pointer
dereference in amdgpu_devcoredump_format() when two GPU resets occur
in quick succession.

The sequence of events:

1. First reset calls amdgpu_coredump(), creates coredump1, sets
   adev->coredump = coredump1, and queues the deferred work.
2. The deferred work begins executing (work_pending() returns false
   since the work is now running, not just queued).
3. A second reset calls amdgpu_coredump(). work_pending() returns
   false because the work is running, so amdgpu_coredump() proceeds:
   creates coredump2, overwrites adev->coredump = coredump2, and
   re-queues the deferred work with queue_work().
4. The first deferred work finishes and unconditionally sets
   adev->coredump = NULL, destroying the reference to coredump2.
5. The re-queued deferred work starts and reads
   adev->coredump = NULL. It then passes this NULL into
   amdgpu_devcoredump_format() which dereferences coredump->adev
   (offset 0 in the struct), triggering:

   KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
   RIP: 0010:amdgpu_devcoredump_format+0xa6/0x36b0 [amdgpu]

This was observed during the amd_deadlock IGT test where multiple
subtests trigger rapid ring resets. The dmesg log shows four
coredumps created within 120ms (at 102.377s, 104.424s, 104.492s,
and 104.497s), with the crash occurring 13ms after the last one.

Fix this with three changes:

- Replace work_pending() with work_busy() in amdgpu_coredump() to
  also reject new coredumps while the deferred work is executing,
  not just when it is queued. This closes the main race window.

- Add a defensive NULL check for adev->coredump at the start of
  amdgpu_devcoredump_deferred_work() to prevent the crash if the
  race still occurs (work_busy() is advisory, not a full barrier).

- Guard the unconditional coredump->pasid = job->pasid assignment
  with a NULL check on job, since callers can pass job=NULL (as
  evidenced by the existing if (job && job->pasid) pattern).

Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index 8edec416fe2b..5cfd9ecccdf2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -464,6 +464,9 @@ static void amdgpu_devcoredump_deferred_work(struct work_struct *work)
 	struct amdgpu_device *adev = container_of(work, typeof(*adev), coredump_work);
 	struct amdgpu_coredump_info *coredump = adev->coredump;
 
+	if (!coredump)
+		goto end;
+
 	/* Do a one-time preparation of the coredump output because
 	 * repeatingly calling drm_coredump_printer is very slow.
 	 */
@@ -499,7 +502,7 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
 	int i, off, idx;
 
 	/* No need to generate a new coredump if there's one in progress already. */
-	if (work_pending(&adev->coredump_work))
+	if (work_busy(&adev->coredump_work))
 		return;
 
 	if (job && job->pasid)
@@ -511,7 +514,8 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
 
 	coredump->skip_vram_check = skip_vram_check;
 	coredump->reset_vram_lost = vram_lost;
-	coredump->pasid = job->pasid;
+	if (job)
+		coredump->pasid = job->pasid;
 
 	if (job && job->pasid) {
 		struct amdgpu_task_info *ti;
-- 
2.53.0

