Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D8C9C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jan 2022 16:00:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7591C10E8EC;
	Wed, 12 Jan 2022 16:00:00 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9730C10E78B
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 15:59:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlQ8Bzn1+JWTYTNOK/0bJqNaINcPJ9wh7vPPb/v5MACgMWUDUrbe47znIz3A72fpD/gQfrkN7Oi1MdH2l0N+kEbfdrm2f2l+Hc/AipKhApNamYVGp1OLHTHpk7xLlVcQm+ETJag3ibE+L0ercLuJIYc7eWS6Lw91pnHz6nGNW0ufFKyHLfoVQlWbgVMv5j635hu4qbdTzelkNRbtxT1pRdAEEiWKI7KXfbvcIEl6B8dsUq3VAPC0wyaFLOok0TBln496/pr8Dc/YDdKc6XCm/GPz1X4mQ2eXb9O0IRIuMShmv5Lm+r9EfUif/vkaFTZ7yjKwDyAQtUOtGG8v5/N5tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRkZcXKz+9l8baOp4Q3HifhtjpVehS7PwvZfht6p3Qk=;
 b=n6AnN9FjJkVKXaFKtGvy7uklUmR9wiEPJh87Zpx5vBmmzp+krMS8aCZb1/aYHx7OTGLAFllFLcs5Fs8XP16alRNSFyy/92Q9YfSlTz867VNJfBDvtLDmd5UoK2YSSZzV9DcCd6ncSGhUcOJHn67yY2esLJxpBNLKxiKLs2Hg9tUVzBrArSXKuyTxK3gs70MATvcmomb9p6cTuX48+HeG1uE+mJwDH/ioYv+Lh39m1v3WH+JNqULvwdyGQPLlhYVOvR9qQD9YDfxayF6iiUu6HF95NBi/N9mhX/tIIqQyOQhkp9VLDJ21Uqh7w6Ic7rANDoBlpxskPWHp3TnNwm5Dug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRkZcXKz+9l8baOp4Q3HifhtjpVehS7PwvZfht6p3Qk=;
 b=LCkDYNawL+uPsBCMpCsqMflrkaGjjaJ332tu9PjexO9gKfsmjDqbUAiVoR1wsNcSchLlBf0ioxiQmX5B0OvOk6YatPHzS+rcYslLQy5qPl1Dsfi6WAvaaO7JqhkwFeUjVMFGbjmD1G7eYwKPsNX7T0TFDBmZAUed5fsOPtyyu8M=
Received: from BN9PR03CA0106.namprd03.prod.outlook.com (2603:10b6:408:fd::21)
 by BN8PR12MB3219.namprd12.prod.outlook.com (2603:10b6:408:9b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 12 Jan
 2022 15:59:56 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::30) by BN9PR03CA0106.outlook.office365.com
 (2603:10b6:408:fd::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9 via Frontend
 Transport; Wed, 12 Jan 2022 15:59:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Wed, 12 Jan 2022 15:59:56 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 12 Jan
 2022 09:59:55 -0600
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: cleanup ttm debug sdma vram access function
Date: Wed, 12 Jan 2022 10:59:45 -0500
Message-ID: <20220112155945.2466798-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2cb8b1e-203e-490d-e75a-08d9d5e49400
X-MS-TrafficTypeDiagnostic: BN8PR12MB3219:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3219C159A6A6D8E455C3B62685529@BN8PR12MB3219.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ke40DQeXBUqp04qp+SzQ64XDVdMZ4HMUqLfwh/XP1XzITLukHYkHyP8KRhK8XTdT75BBXYm4pK7jP19GzS2xIyv4ga2J+5ib75WIUkXT2nnkau+GW9ZIZehwF9RGUy+MtOcvTFD5k9To7YcOiL4CAgclT0lW5TLBiT42b5N00mvUNofLSyjw9myOutgrnNWLIVRetoVVYh+hPFeRXhPKTnwn/9Wv8L06c6JstOe1bLvoFbmTDoUKnirwCt8nQRlcVpTm8O/IkiNV19OsRVhVWxOmpxzQ39nB8BXpWz3Ph7dX36wtYWaKtSmMRcAAR3kF84VMPtzkOXA/KjhsQPfUVbKLicmj7zqN28lYLdGn+rJEqEhs77pD9J94t5XPakj/gecCZkV8l90OBGibzU/GNO1zwhB3eD1w/h811h03SzbzyrX8D7CKwcAbgtWsAvvFhRaYen+LRccJnRQ8BKUf7XqRF0VaaLFcN/AT8m13IIlBxWEJq9mB4Ctr4se9rsyCi7xcTWc+ktOQzHkhyvglkL3vz0YaAKNqMXnZxOyUAtLZ+8AhqaUWQ3u5PY9VR2GZpWpo48E0lAXOEM8zqIvAIrTOV99FdeA9Jd/dzmQ1VcARaWIxMPHV/v8XAwA+C1nmKCoDrS0v7QoFHOGY6kRe1lCfwXVYTbQ0NBxRpfcWYDKYZKLjl1xYKPAm+lTE/Ci6c2dVnJKlcEKmxOBc9q9YGWNVSQU9Elz1oNQO3jrR6L8daIqcgo9VauHB1vokw3EkEtV92S14ZkX0ohLZeY9o10TT0bG8LkjYD1odrso26j0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(46966006)(36840700001)(336012)(2906002)(8936002)(2616005)(36860700001)(70206006)(508600001)(8676002)(426003)(186003)(4326008)(70586007)(16526019)(36756003)(54906003)(1076003)(356005)(82310400004)(40460700001)(5660300002)(44832011)(316002)(47076005)(6666004)(26005)(86362001)(83380400001)(6916009)(7696005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 15:59:56.1670 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2cb8b1e-203e-490d-e75a-08d9d5e49400
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3219
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
Cc: Jonathan Kim <jonathan.kim@amd.com>, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some suggested cleanups to declutter ttm when doing debug VRAM access over
SDMA.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  9 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 23 +++++++----------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index a675dde81ce0..4d77842f2183 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1448,6 +1448,15 @@ int amdgpu_device_set_cg_state(struct amdgpu_device *adev,
 int amdgpu_device_set_pg_state(struct amdgpu_device *adev,
 			       enum amd_powergating_state state);
 
+static inline bool amdgpu_allow_post_mortem_debug(struct amdgpu_device *adev)
+{
+	return amdgpu_gpu_recovery == 0 ||
+		adev->gfx_timeout == MAX_SCHEDULE_TIMEOUT ||
+		adev->compute_timeout == MAX_SCHEDULE_TIMEOUT ||
+		adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT ||
+		adev->video_timeout == MAX_SCHEDULE_TIMEOUT;
+}
+
 #include "amdgpu_object.h"
 
 static inline bool amdgpu_is_tmz(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 33781509838c..02515f1ea5fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1460,10 +1460,11 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
 	if (r)
 		goto out;
 
-	src_addr = write ? amdgpu_bo_gpu_offset(adev->mman.sdma_access_bo) :
-			amdgpu_bo_gpu_offset(abo);
-	dst_addr = write ? amdgpu_bo_gpu_offset(abo) :
-			amdgpu_bo_gpu_offset(adev->mman.sdma_access_bo);
+	src_addr = amdgpu_bo_gpu_offset(abo);
+	dst_addr = amdgpu_bo_gpu_offset(adev->mman.sdma_access_bo);
+	if (write)
+		swap(src_addr, dst_addr);
+
 	amdgpu_emit_copy_buffer(adev, &job->ibs[0], src_addr, dst_addr, PAGE_SIZE, false);
 
 	amdgpu_ring_pad_ib(adev->mman.buffer_funcs_ring, &job->ibs[0]);
@@ -1486,15 +1487,6 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
 	return r;
 }
 
-static inline bool amdgpu_ttm_allow_post_mortem_debug(struct amdgpu_device *adev)
-{
-	return amdgpu_gpu_recovery == 0 ||
-		adev->gfx_timeout == MAX_SCHEDULE_TIMEOUT ||
-		adev->compute_timeout == MAX_SCHEDULE_TIMEOUT ||
-		adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT ||
-		adev->video_timeout == MAX_SCHEDULE_TIMEOUT;
-}
-
 /**
  * amdgpu_ttm_access_memory - Read or Write memory that backs a buffer object.
  *
@@ -1519,7 +1511,7 @@ static int amdgpu_ttm_access_memory(struct ttm_buffer_object *bo,
 	if (bo->resource->mem_type != TTM_PL_VRAM)
 		return -EIO;
 
-	if (!amdgpu_ttm_allow_post_mortem_debug(adev) &&
+	if (!amdgpu_allow_post_mortem_debug(adev) &&
 			!amdgpu_ttm_access_memory_sdma(bo, offset, buf, len, write))
 		return len;
 
@@ -1909,8 +1901,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_OA);
 	ttm_device_fini(&adev->mman.bdev);
 	adev->mman.initialized = false;
-	if (adev->mman.sdma_access_ptr)
-		amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
+	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
 					&adev->mman.sdma_access_ptr);
 	DRM_INFO("amdgpu: ttm finalized\n");
 }
-- 
2.25.1

