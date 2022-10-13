Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2034BC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Oct 2022 08:29:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3006E10E054;
	Thu, 13 Oct 2022 08:29:05 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B82C10E054
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Oct 2022 08:29:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OT44aw+BD3Qwqk7XiidZOOe2ZgXKzzhP3d4+VmhIUGSO8s6ufy/qA6BJYHiNMUrX8QzYH7aRZOIP0GaouBNSVYgVIP/nhTBu4+7bvdbcphknVNTKkojwIQP6+L7x9qL8vFZVTEbhtunJoydeUd03HQaqnXmGW0N+feUp5DyzOZOjIGQUjDwRBmcXIo2kmOcnmsD5R0ovIKOIR26NXhsftX40JjZRnlg08kAA4NkuCyr8tDidx99zRNKZDFAg/JUI9IvbusSdnHFc9GtaOslmeSbN0LssAlYvHho8cREr52Pxdh0fOK9vsvzS1qBZE7/9bPteDtteonQseUw2KysXYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQdgGLCKWvnG00USPkK18qOmXPXnURVBqU1aGAX2/ag=;
 b=QNSOhbDS/6j5iq2lg6etxpcF0N5oQVhWFKSkinkB1ytz9ihO+smJXsXoyISXo2JiB4ZLvXqufiFKc3KmcBNQvH6vZ3MGYqPojQbyGZM1N4LsTGbRadIWWbX8slxYM0jngwfI5x0ky2ZYc8DoNz0zOWQgKrhwkspdmy+BPw5ay6XbO6STS7WEHG6QK7jgcgxRHwTC3ya+8yanE5dL1PcfiTQd51SKMiYz3QKj/m/xK29/LszgAPjxk0dBQdZXWBoQRVlVzbtlsRiHc/kYWm5sB50Iaw+DoAglMf94rJRnwTn7ZWd8MnizoqctOUUE+rJ4a4/bK2FkZTaCgyLRHjYQHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQdgGLCKWvnG00USPkK18qOmXPXnURVBqU1aGAX2/ag=;
 b=nH6KaNDrWOuVH17ioNEg/XftMB+ic5NDih8Ab0hfmB+mL1xfOfzbIB2tYdHvfY2HlMpo3D+W1ZI39qoQTBAop1qv44274GUOdUM3iroKYs2wTC0gyKuX3JtKBj9oN/OeV2oKuj3bX4Bg+6gwJZ7iDb0LMrtJlQOoB6DLLokObOw=
Received: from DM6PR06CA0047.namprd06.prod.outlook.com (2603:10b6:5:54::24) by
 MN2PR12MB4341.namprd12.prod.outlook.com (2603:10b6:208:262::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 13 Oct
 2022 08:28:58 +0000
Received: from DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::24) by DM6PR06CA0047.outlook.office365.com
 (2603:10b6:5:54::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26 via Frontend
 Transport; Thu, 13 Oct 2022 08:28:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT084.mail.protection.outlook.com (10.13.172.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Thu, 13 Oct 2022 08:28:58 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 13 Oct
 2022 03:28:56 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 13 Oct
 2022 03:28:41 -0500
Received: from victor-test02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Thu, 13 Oct 2022 03:28:40 -0500
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] Revert "drm/amdgpu: add debugfs amdgpu_reset_level"
Date: Thu, 13 Oct 2022 16:27:43 +0800
Message-ID: <20221013082745.46143-1-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT084:EE_|MN2PR12MB4341:EE_
X-MS-Office365-Filtering-Correlation-Id: 00580820-6f3f-4898-7e34-08daacf4f9a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CKlJeYBvDXpkhVu7kMe95HATedeWHZZgtW5dwvtVefAqHLQnSvrQ25lENAwn3o/SG5nJv60epUsjPlqP94rOzgEFW2M5LcXr1A8UPhroKzOOR7WOCgLSstXnOhZaVojl+UhzOL2Hd0Rclo/TnmktS7YK4m+qXbFS/XnXftKQ1KZA1J5euLyUukrkWwjqWaJToatQHnb8BXrDl+kIcCYUG9H28gUpF9uZNejzlS4Fv755REYtbrf0/pDyTYEDwgnpAP6vRJFPPbqe18RPmJ6mpKUXVOY5HDPBNHyBb+EXS3nnO166vH/sX5flfpwmmt/KSkAdcQbwSp3WsKH1Jk2XF2m4nXAR+lgsy3s/a5aIV4G1N/oyfxCr8mCvlUWJ8lOiqPYdJxjJ2UfUodLl7sM8QN6VL63BO0Mt2wxMT7k4YGRNVDmNhtBXz1R/YqpJJBt1jDYOIGS1Aq1cFEaRObqdkb5PS5RsHqQ9JMk8IPKfOqj76c4kpZsHUeEzwKr5L1ISPiOw/fVkRLldvE9P4Fd9OYOvau1GD05F1eq9ce2Auxeu4/eJV64F8Z8a++NasgF9JqdiD31FhCJbHImlZDVtyCly2hXOEU88isSGgctB3pHC5ifSQG/M0nUdsKTwvFCw2/+igsYCd5IRWmanl5wypIqhU6/gVKwRPJ+BmlUVTrTgFonhm4pJZlhyHUJ+4XsjU7ORc5xN+tvl89bruxNgfcdOp2I4oZ5G/JeLfFiIxl8Sfot55I5DvUVPPjpwFNayGer8QiBaLezafFPd3ehz/vbU5KoZGB9ZxJa9ScrISVk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(2616005)(426003)(47076005)(186003)(1076003)(336012)(83380400001)(356005)(81166007)(86362001)(36860700001)(82740400003)(5660300002)(2906002)(41300700001)(4326008)(8936002)(82310400005)(40480700001)(40460700003)(8676002)(478600001)(26005)(7696005)(316002)(70206006)(70586007)(6916009)(54906003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 08:28:58.5869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00580820-6f3f-4898-7e34-08daacf4f9a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4341
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
Cc: Andrey.Grodzovsky@amd.com, Lijo.Lazar@amd.com,
 Victor Zhao <Victor.Zhao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 3ae992d5e1194a16e3d977076eb5722fa6e410d8.

This commit breaks the reset logic for aldebaran, revert it for now.
Will move the mask inside the reset handler.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         | 4 ----
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c   | 8 --------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    | 3 ---
 4 files changed, 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 3ce91f660c3f..0e6ddf05c23c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -274,9 +274,6 @@ extern int amdgpu_vcnfw_log;
 #define AMDGPU_RESET_VCE			(1 << 13)
 #define AMDGPU_RESET_VCE1			(1 << 14)
 
-#define AMDGPU_RESET_LEVEL_SOFT_RECOVERY (1 << 0)
-#define AMDGPU_RESET_LEVEL_MODE2 (1 << 1)
-
 /* max cursor sizes (in pixels) */
 #define CIK_CURSOR_WIDTH 128
 #define CIK_CURSOR_HEIGHT 128
@@ -1065,7 +1062,6 @@ struct amdgpu_device {
 
 	struct work_struct		reset_work;
 
-	uint32_t						amdgpu_reset_level_mask;
 	bool                            job_hang;
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 6066aebf491c..de61a85c4b02 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1954,8 +1954,6 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 		return PTR_ERR(ent);
 	}
 
-	debugfs_create_u32("amdgpu_reset_level", 0600, root, &adev->amdgpu_reset_level_mask);
-
 	/* Register debugfs entries for amdgpu_ttm */
 	amdgpu_ttm_debugfs_init(adev);
 	amdgpu_debugfs_pm_init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index 9da5ead50c90..831fb222139c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -37,8 +37,6 @@ int amdgpu_reset_init(struct amdgpu_device *adev)
 {
 	int ret = 0;
 
-	adev->amdgpu_reset_level_mask = 0x1;
-
 	switch (adev->ip_versions[MP1_HWIP][0]) {
 	case IP_VERSION(13, 0, 2):
 		ret = aldebaran_reset_init(adev);
@@ -76,9 +74,6 @@ int amdgpu_reset_prepare_hwcontext(struct amdgpu_device *adev,
 {
 	struct amdgpu_reset_handler *reset_handler = NULL;
 
-	if (!(adev->amdgpu_reset_level_mask & AMDGPU_RESET_LEVEL_MODE2))
-		return -ENOSYS;
-
 	if (test_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context->flags))
 		return -ENOSYS;
 
@@ -98,9 +93,6 @@ int amdgpu_reset_perform_reset(struct amdgpu_device *adev,
 	int ret;
 	struct amdgpu_reset_handler *reset_handler = NULL;
 
-	if (!(adev->amdgpu_reset_level_mask & AMDGPU_RESET_LEVEL_MODE2))
-		return -ENOSYS;
-
 	if (test_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context->flags))
 		return -ENOSYS;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 3e316b013fd9..d3558c34d406 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -405,9 +405,6 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring, unsigned int vmid,
 {
 	ktime_t deadline = ktime_add_us(ktime_get(), 10000);
 
-	if (!(ring->adev->amdgpu_reset_level_mask & AMDGPU_RESET_LEVEL_SOFT_RECOVERY))
-		return false;
-
 	if (amdgpu_sriov_vf(ring->adev) || !ring->funcs->soft_recovery || !fence)
 		return false;
 
-- 
2.25.1

