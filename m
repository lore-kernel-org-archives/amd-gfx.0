Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FA0C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Apr 2024 18:14:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A53A113EBC;
	Thu, 18 Apr 2024 18:14:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mfzF4+OD";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3BEE113EBC
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Apr 2024 18:14:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6LAZNF+7tu5bPzwljZPmtVSYydXK6+XVI+T+bP0gBVz1bnkrYrC2ZSXdJwUUZzE0PXAw+ifQ3xpvzBKDkd91ozbF9RJBzX2Up1o2w5C8K7hm1ruNp4L/uTJ0Lv3NdckkXhn/JNEQX9ZTYZOt9Thsjt6XZj7MnpPynq9hvvmeBn3esWj3/px8icH3HGsywfLDZ+sDvAnsaXVhOiQf3NPHVe4ukjEpDg44PdgVtwg071RHUkPmpdcb368BG33I/Hjd9F6JhYhczME/7RcczQWm4ly79prErnQfQ/ioL1/bM9FjlLNvhMKsOTfg9wUBn9ME+quJF0n3bjrWOKtP2qowQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEEHc75gIVozUvDwiVUY4ASI2BqqJNEiCEQS7j6JDwk=;
 b=FqixCZnQVGXt5B5aRax0499lVpSoMkpbbnDeu0I8vTFnXb055sNus7PxWGRatsbqFfpAldj7nzcfv8vAss6nWnuh4UH2Sy0TI8OMrQVL6RTrZZnEYhfdW+xneStQvheaTZ9NIYe7l2+85NT/fP7ZnPDyt0OZExZGTA9v50qQXz5PyX6Jq+UtChZyDDKtZnTRvUtsmUj5QxZZf6nQatV9qdwJrdpGlMLmaA4tafAYkd8ahqHBtpXaOP7nGMMX+3RrRL4y5/Bt99tWcNmQYloqDrHWhpHpQqnMTZy/1S8NpAI4O3+GlYehwQkPKhr+29o63Wcd5+Dnlj69swqY5j1FPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEEHc75gIVozUvDwiVUY4ASI2BqqJNEiCEQS7j6JDwk=;
 b=mfzF4+ODHDH5xmTIyiYAEsgzYSEPHsoFHk6GPKT9l1Dn9nt3c8PmTKYQDXPxiZ9Ang0ZBcgZ/ejg6kE6IQnuzdHO0JC4SYWguIYF9eYyIDPHneyUdKugswiyiSD62mNyqN84znyQNfiaAkiI3LoupFSCR1hquSHnbO6ogHiIGn8=
Received: from BL1PR13CA0361.namprd13.prod.outlook.com (2603:10b6:208:2c0::6)
 by MW3PR12MB4443.namprd12.prod.outlook.com (2603:10b6:303:2d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 18:14:18 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::7b) by BL1PR13CA0361.outlook.office365.com
 (2603:10b6:208:2c0::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.17 via Frontend
 Transport; Thu, 18 Apr 2024 18:14:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 18:14:17 +0000
Received: from patedamande.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Apr
 2024 13:14:15 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH] drm/amdgpu/vcn: fix unitialized variable warnings
Date: Thu, 18 Apr 2024 20:07:03 +0200
Message-ID: <20240418180807.240782-1-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|MW3PR12MB4443:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ccc60d4-b9fe-4b86-ef4e-08dc5fd35cba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NBoEbkVBY0ZvRtHTLgu2q5wAACBVWRibW+ITFivLCZVrqSZda+uATkexCqz4eM71QqK9D53qJPYiDMzIA85yejouCy6OYzc5BAvpmvRhovheFtdAX6OZ1d8KbysmIYiTfRtOUS2WLIKSx4xuHpz9b2CiCrWvRkwytYt7dDMi4b2r8rUq2sEtjEiT3QLVfl2UveEOYjRt8ZkDJfGM3/MoirC7DI6fbbx/wOxXI4LADjE1TN6aN7GvLiWMGbIlOxy4V6bBNmyQA61HNHCnZZlaWRIl0sMLLGLAFaTcdFgkYdv47eRqs7pT0/3lMr2452Pt4TurU+kX23VFXgQsJljSZMPyiZfSYFLVpxruXtILkQYlDkPByl8sk7+pz9bXdV1ud2SfoGbEHCSma2Egr89FqygegIz0XRQIQTqx30m9ygaUsZxHE5WmwO5KT4byXGnrwcYO9s2KknYv25sA1Ng0hBJJf7JZaAMAI//Wk1Ql0SVBaRb9ysmZ00cUQt4buOQrz7VFihkQlaSl/wYDLTimufGFPHSeFtUQFN7p9joFwcrKOaL8E7pojggnobbM7qXIb/UJ0m8OC5w6AjIxjlbl8rptr+jKzFIk4mK18lIA3O0iWx061DOHNVh/3TFGul4KGBvT+pwfhdpETxCGXwQW8r8YpuFAdHWB4FyrugWYUZ/LLYX4OQKpEcvSoUj7WR2Zz0PIXiGvsVRkPgKxfv5xcBs4JVkfI5Yb/wpYp1p58JOJKSUtPCB3fD9OtlE+m8bt
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 18:14:17.7792 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ccc60d4-b9fe-4b86-ef4e-08dc5fd35cba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4443
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

Init r to 0 to avoid returning an uninitialized value if we never
enter the loop. This case should never be hit in practive, but
returning 0 doesn't hurt.

The same fix is applied to the 4 places using the same pattern.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 8f82fb887e9c..724445545563 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -298,7 +298,7 @@ static int vcn_v3_0_hw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct amdgpu_ring *ring;
-	int i, j, r;
+	int i, j, r = 0;
 
 	if (amdgpu_sriov_vf(adev)) {
 		r = vcn_v3_0_start_sriov(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 832d15f7b5f6..9be7ae7af4b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -253,7 +253,7 @@ static int vcn_v4_0_hw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct amdgpu_ring *ring;
-	int i, r;
+	int i, r = 0;
 
 	if (amdgpu_sriov_vf(adev)) {
 		r = vcn_v4_0_start_sriov(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 501e53e69f2a..593c64e4b8ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -221,7 +221,7 @@ static int vcn_v4_0_5_hw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct amdgpu_ring *ring;
-	int i, r;
+	int i, r = 0;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index bc60c554eb32..246f967e2e7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -187,7 +187,7 @@ static int vcn_v5_0_0_hw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct amdgpu_ring *ring;
-	int i, r;
+	int i, r = 0;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
-- 
2.41.0

