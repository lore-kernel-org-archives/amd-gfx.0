Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32307C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 13:39:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D977B10FB65;
	Tue, 17 May 2022 13:39:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 182F210FB65
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 13:39:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xtlv0MU4M2BoXKOOK3FSqFhBHBpe3QzIN3AXPgqq4UIXjRC6E+2xWx4n6lk1YFPHUS8DHaQfKvDfdTuKz+Rb9gEh2xi1tNsMrSn/jzczVCUrOyeZdnwgSPAjhjh4JN6+RlbipblcytKMr/zhoSrZiu7h2Y240pvp1TMg3J/L8n5TQf5AMR+jj7iDJx1qWyd0DiIubHjn2k7IFf/TT6GwWta16r0br8UV5r+2j28oY57JxB4ndchtRndASByO323pWTVg+8J0vzlTQVAmBmLiYH9jzL/ovwllTMOTpC05ljw9K4reBg/xeP+RGR6b3fJLF848ARqBINO6w+d1AOh4ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhoGqG8ZG+DjzQe38OXs+y3401C96P0g0JmAa6+MUwo=;
 b=WvRagKZ3Ok5VfUlPMeeyffLurGbpnnsXMbLGFYzTiheTb7nuURb/TM1TagcIUmpjCu43/W2phIrZc63PA6iouIYh4K5V0Bkizlw9ocuR49vnyvd/k5v59sWKGJx4l0F0mcy41fxskuHfV1Mi5lxhSKbH4pvyKZMiTAWabxzk75X84zCoLeEWCHZGNKOy1o4PfFJkgOKjVMItsg1vOebcHiPbgTAlAD8r1/V0urgjq7deIO3QLfHXEifzn5FA69dtVvwclGrWYKL+YydRA/BmEygtSgG2aTjDyXVOrt+pAbnTDBPazwDON41JS/oHfO/PidvXh5sfoB9NYba8h2zWcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhoGqG8ZG+DjzQe38OXs+y3401C96P0g0JmAa6+MUwo=;
 b=S4q9SdycSW79DIRRzg/x8n5c7miZ1Utk3+y8VdKFBDAtoNSiz2qFLf1B67raUIbfGcWH32HYZpwEvm7vkDEy/PlEjzyKppO0S0dAn4/icrbETLcYKw6vpmkTz+6PvSGiyBGIMY0Ykpk8V6u5cYkyHfN2ScWXPM9VFy7X/hvAG/w=
Received: from BN9PR03CA0105.namprd03.prod.outlook.com (2603:10b6:408:fd::20)
 by MWHPR1201MB2543.namprd12.prod.outlook.com (2603:10b6:300:e2::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Tue, 17 May
 2022 13:39:44 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::bd) by BN9PR03CA0105.outlook.office365.com
 (2603:10b6:408:fd::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18 via Frontend
 Transport; Tue, 17 May 2022 13:39:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Tue, 17 May 2022 13:39:43 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 17 May
 2022 08:39:42 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Don't reset dGPUs if the system is going to s2idle
Date: Tue, 17 May 2022 08:39:44 -0500
Message-ID: <20220517133944.25612-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 627329f4-6af8-43bc-bfe3-08da380ab31c
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2543:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB2543F554C37A43F5BCDBEFA0E2CE9@MWHPR1201MB2543.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: benqDN0LlFh/GH4j+SAHNSzLip/w7N6UfbRC2J/DuuKr4/heseiNU7VDWKZLbz82yMH66iohLcmZhfAwqp/BzGqPr/lcM49vG8JKBQY+YeWfRdhEw/qx5sHa7TVRXoQzj4hnfrwDIz7qA8h6BSkDUMqRVQ9pd1S1F6w+GW1wJgM7ovzNbDTwho7kmgug5YnFNoQLbUdpjNz2VMz14QWuCHxr3ybq+pp6ltBAjOFBOs0utQYK+CyBQxoRa4d0BS2dF6kjwzc5TLJr8aFdqGk0U0Kdz/lhOMI4vMA36Q+EAjgflJCOnsIdthrN+5qHNWwqNKKrGgOLvSAAddAqsPuxe82BVrFh6fme1OTbxk/l7WHAfECOucmEkJi6m3mxLmhnWD+Fx5kdx7LeondwOoEKAAGowIbNfVf0ZY6zHBUbf2RP0GHMVr1KxRBn0lrge8xf0yssIoaoKGVBDtPpAoOmDx2uCAu9dhcS7Puw7NiYUMubk1YP5Zck/zCfhvvwtt7+psEFa/Q9Z/ubkiRdjkQlf3C7i3bA3Oz/EBt1UuiQmcQA9dPnRPZ4w7BKd6jaHrlZQv6JbgXKaHbMxth6bvz91DFnDclGXMFPCEEGyW/666IuEp2HA0wkxkk2/0EwXrMAvJ5mW3Yed5slm/pCdYDfs5PkMnHA033f9YJTcdDqYpCwKf7ohd9Pr1Jy/gOD7SBdx/qSEBQ3fG8JIx4AqfuX4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(82310400005)(36860700001)(316002)(966005)(83380400001)(2906002)(336012)(186003)(47076005)(70206006)(70586007)(8676002)(4326008)(1076003)(44832011)(16526019)(86362001)(7696005)(5660300002)(426003)(81166007)(8936002)(6916009)(36756003)(356005)(508600001)(2616005)(40460700003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 13:39:43.1399 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 627329f4-6af8-43bc-bfe3-08da380ab31c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2543
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

An A+A configuration on ASUS ROG Strix G513QY proves that the ASIC
reset for handling aborted suspend can't work with s2idle.

This functionality was introduced in commit daf8de0874ab5b ("drm/amdgpu:
always reset the asic in suspend (v2)").  A few other commits have
gone on top of the ASIC reset, but this still doesn't work on the A+A
configuration in s2idle.

Avoid doing the reset on dGPUs specifically when using s2idle.

Fixes: daf8de0874ab5b ("drm/amdgpu: always reset the asic in suspend (v2)")
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2008
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |  2 +-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 3c20c2eadf4e..9cf3d65f17d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1378,6 +1378,7 @@ static inline int amdgpu_acpi_smart_shift_update(struct drm_device *dev,
 
 #if defined(CONFIG_ACPI) && defined(CONFIG_SUSPEND)
 bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);
+bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev);
 bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
 #else
 static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev) { return false; }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 0e12315fa0cb..98ac53ee6bb5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1045,6 +1045,20 @@ bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev)
 		(pm_suspend_target_state == PM_SUSPEND_MEM);
 }
 
+/**
+ * amdgpu_acpi_should_gpu_reset
+ *
+ * @adev: amdgpu_device_pointer
+ *
+ * returns true if should reset GPU, false if not
+ */
+bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev)
+{
+	if (adev->flags & AMD_IS_APU)
+		return false;
+	return pm_suspend_target_state != PM_SUSPEND_TO_IDLE;
+}
+
 /**
  * amdgpu_acpi_is_s0ix_active
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 16871baee784..a84766c13ac5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2315,7 +2315,7 @@ static int amdgpu_pmops_suspend_noirq(struct device *dev)
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 
-	if (!adev->in_s0ix)
+	if (amdgpu_acpi_should_gpu_reset(adev))
 		return amdgpu_asic_reset(adev);
 
 	return 0;
-- 
2.34.1

