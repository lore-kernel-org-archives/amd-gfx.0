Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D3AD42B85
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2024 14:31:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 452F110E5E0;
	Tue, 12 Nov 2024 14:31:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m4GafjbN";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2066.outbound.protection.outlook.com [40.107.212.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6371B10E5E0
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2024 14:30:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHmXiMjq26h//bA0MPtBuLZMgn0+wFFhktUjv+oyxLzZ1a09lhV7F5UKxwWQs+Q2PqM72qw+1BTVkdVDzyTU+w7Wa4ObwuYgvzvbldsleWXvWsUcpUOcvPR5b0mjumnGSY4uEkYUKJ0gAJT/cZRleGKD3tVvEcKlqLzbGkHl9eV4MaYm/2r3vU+4IoUKWEtmQos8ZBT8WQJDJJRt20k+N0ZbvpqqdkCYE2pDZvoW6fMYY6kmikCUmEV2X5/f4HadQ/SyYJ+HUqI+od7VvSeGBe1S1aP+rxuEmW7lIICHRBe3JmVSDZuS9xTWeOqYUBVGTrKGJVoPaUDOWbpeIUEdYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0Mzt+bSwg+EQJIXTVzVOJJbhNH9xqbx3ypmMhr72O8=;
 b=xDqHNM8Opy8ghKWd0vGeO1nlfGeWiZm1VNeXcKqDaSuSka27lBWY/YMjiDD0rJf979/ja7I+fnZeYYFi+MfwK2NY1WW/hj09KO7F6Ci3ntTRviCBmy4Mx8gqrGnBLQ0w74hKthfaIlqlPiboXBXKf/yzDdhvrebWaAgsJGwQwLin24jGV+qsgPCfRsHuExDB4K9eg5anSfiF4wAmC50taL17eJG1Rshug2KKk6C9A9Ku0632DeTM3PrFubumO3tUoMKA5NcaByGJxNxwd7ZbEG71utCboJIJYuyXNAwcTIkUV+wuMykMwVcjzE6eYEdtfA5fW1OSKSNZ8gUUaQgeVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0Mzt+bSwg+EQJIXTVzVOJJbhNH9xqbx3ypmMhr72O8=;
 b=m4GafjbN7ykqOC1pAfzLWyceN+9X/4tTc2W9tw9wnWly5Gl+YAX3/nnhLVHkjljn00mRAxGc+3VGG/leU/C9zo2plnfOG1htBFHEoafR2obkd2XZq+Ai++jvAYJPQxJGMYD2BY25VMf1QJnNctOA8yxFW2TFEA4IjGeBPXQm81k=
Received: from MN2PR15CA0028.namprd15.prod.outlook.com (2603:10b6:208:1b4::41)
 by DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.25; Tue, 12 Nov 2024 14:30:53 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:208:1b4:cafe::13) by MN2PR15CA0028.outlook.office365.com
 (2603:10b6:208:1b4::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Tue, 12 Nov 2024 14:30:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 14:30:53 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 08:30:52 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 12 Nov 2024 08:30:50 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <vitaly.prosyak@amd.com>, <Tim.Huang@amd.com>, "Jesse.zhang@amd.com"
 <jesse.zhang@amd.com>
Subject: [PATCH 1/2] drm/admgpu: fix vcn sw init failed
Date: Tue, 12 Nov 2024 22:30:49 +0800
Message-ID: <20241112143050.1931822-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|DM3PR12MB9416:EE_
X-MS-Office365-Filtering-Correlation-Id: f0816be4-ac53-4698-10e6-08dd03269cd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YbDLoGPvdK45whA/4e/R6HrbheC2vIQ4lSlrKFmRxZNZOeOFSCz9WNxzUtOb?=
 =?us-ascii?Q?pJXgg7wstjBYc+piOYPTFWBJpPmjBh2QlVoNyKLLNsI07leNJ4XuKMRr+th7?=
 =?us-ascii?Q?d2v7wNNgqDJ6Qa9+e667xcQkWeQAvM6ggTERY/aryKiII9uzsT7k0qvYi8Xh?=
 =?us-ascii?Q?SyLoloqu4nEW9YYV07RIrVJ0W2VZyI779B1jX+5C1/ORfk9j9yseoL3O0oZz?=
 =?us-ascii?Q?iQKDlHpzaJyZkEWqcjnlTXEqlniRsG+MtGCfWRU/jH4EjB0kH3rtEOh/TyKm?=
 =?us-ascii?Q?khH/6SnbLs8+JEQYZ5wld1tJhrE9+uMCNFhuPJpZVYAXSnHJ/Pb3FBJZYaDT?=
 =?us-ascii?Q?qzN8vh5B34wz7j9oe15olHXJJNAIH21Vkjp7ohI3Vz+CAbvW5JQJ6yjhPDww?=
 =?us-ascii?Q?aZ3ebT6DhSm16Pxwv43hvfkUa6QcuuqbWaGdTAj3t1Co9eRbQNXjv5TqVzqL?=
 =?us-ascii?Q?sDxTo6WshGG8ejKXmoTD/EkvJXP44ktSXY+0WcmLv+eLKFghDk74Qe8rqhvI?=
 =?us-ascii?Q?hiI8gifBFmvZSlY+Y/LNJSlS/7Hwh3xt/TOkwxSwv1zbcsVKHyL3+t21OaCV?=
 =?us-ascii?Q?cjXOJ+ylSHyGXFvL2goiA0ZSoDgsl/46vFXnUsACa3RaYraRWVBgeJ0BDe5h?=
 =?us-ascii?Q?nONTtCNrtxjvkY/N3Q0KEssz214VuHthKJuLJ2Z9xz3b5qlYeX6d4txO81xz?=
 =?us-ascii?Q?A2v641Pp+aT63ZfMbbi+FL5iVpOZYKw9tCX20mFCirkk/oXi1rplAoX155XV?=
 =?us-ascii?Q?zYHw23DrwVa5yvx3gMXvPyBrfHGpL1tkxEwjOrkXRZcEWYmeAQWpaDlACz1c?=
 =?us-ascii?Q?OE2m/EuosRJfeVpoo1SbqJUt5ScIEQ9NNNv5abJeWVlcnFw+aMM9wBnPpFpb?=
 =?us-ascii?Q?Txf/Wff+3Y4BECLAU41sD1MkAva8v3196XScx7ka/w4kNAPscBCRBBspyndW?=
 =?us-ascii?Q?AAHynUr3QTde4vEydUhXZxg6kr0vCEnRGNPPxaEw3wW92b+MR68VgUF3QWxO?=
 =?us-ascii?Q?LqproMG5Lf4IKa8CSvhKpJ74pToCEsSjAIXeuCpc5/2OTylgR7d/pPm9gH0g?=
 =?us-ascii?Q?5TCvxGNuaRni1k1Sb+GRI46D+TJpwth2CoA+p1bhAf21z3Qmq/ffEook34uP?=
 =?us-ascii?Q?2lCvmtnx4tPEHTKGMHyJsXyBkmdmARPzWWZJs3CTwCf5VfkikbHe5lUL2/I6?=
 =?us-ascii?Q?fvhONkukQBoyiumdQ3qopQXbEByiVReqiCAjE9xf6JG9cYjKNJX0wUpMZmtR?=
 =?us-ascii?Q?wnuTZXxavfB9Cd87CFU4B3PDeeJU5RqiqUA7Mh0AJoidifkCqaYjpb5YMGEu?=
 =?us-ascii?Q?emcpbjjl4iM565T661j2XSuCO9l4HLQLSZ5pWF2F6eAK96QBFQl9Ce3lMpje?=
 =?us-ascii?Q?QeTP1XTJgBG9ajAATRLeJtbdwLsyVJNQcBSIDCwwYDxB/TSz0A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 14:30:53.0612 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0816be4-ac53-4698-10e6-08dd03269cd6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9416
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

For multiple vcn instances, to avoid creating reset sysfs multiple times,
 add the instance paramter in reset mask init.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 10 ++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  4 ++--
 5 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 25f490ad3a85..1d4eda649845 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1295,11 +1295,11 @@ static ssize_t amdgpu_get_vcn_reset_mask(struct device *dev,
 static DEVICE_ATTR(vcn_reset_mask, 0444,
 		   amdgpu_get_vcn_reset_mask, NULL);
 
-int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev)
+int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev, int inst)
 {
 	int r = 0;
 
-	if (adev->vcn.num_vcn_inst) {
+	if (inst == 0) {
 		r = device_create_file(adev->dev, &dev_attr_vcn_reset_mask);
 		if (r)
 			return r;
@@ -1308,12 +1308,12 @@ int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev)
 	return r;
 }
 
-void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev)
+void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev, int inst)
 {
 	int idx;
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-		if (adev->vcn.num_vcn_inst)
+		if (inst == 0)
 			device_remove_file(adev->dev, &dev_attr_vcn_reset_mask);
 		drm_dev_exit(idx);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 7ff4ae2a0432..9b10044c61a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -519,7 +519,7 @@ int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev);
 int amdgpu_vcn_psp_update_sram(struct amdgpu_device *adev, int inst_idx,
 			       enum AMDGPU_UCODE_ID ucode_id);
 int amdgpu_vcn_save_vcpu_bo(struct amdgpu_device *adev, int inst);
-int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev);
-void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev);
+int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev, int inst);
+void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev, int inst);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 59f83409d323..109b27904984 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -250,11 +250,9 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 		ip_block->ip_dump = ptr;
 	}
 
-	if (inst == 0) {
-		r = amdgpu_vcn_sysfs_reset_mask_init(adev);
-		if (r)
-			return r;
-	}
+	r = amdgpu_vcn_sysfs_reset_mask_init(adev, inst);
+	if (r)
+		return r;
 
 	return 0;
 }
@@ -292,7 +290,7 @@ static int vcn_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	amdgpu_vcn_sysfs_reset_mask_fini(adev);
+	amdgpu_vcn_sysfs_reset_mask_fini(adev, inst);
 	r = amdgpu_vcn_sw_fini(adev, inst);
 
 	kfree(ip_block->ip_dump);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index e9b869f373c9..ef3dfd44a022 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -217,7 +217,7 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 		ip_block->ip_dump = ptr;
 	}
 
-	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
+	r = amdgpu_vcn_sysfs_reset_mask_init(adev, inst);
 	if (r)
 		return r;
 
@@ -254,7 +254,7 @@ static int vcn_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	amdgpu_vcn_sysfs_reset_mask_fini(adev);
+	amdgpu_vcn_sysfs_reset_mask_fini(adev, inst);
 	r = amdgpu_vcn_sw_fini(adev, inst);
 
 	kfree(ip_block->ip_dump);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 96ec01cffea3..8f9c19c68d88 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -186,7 +186,7 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
 		ip_block->ip_dump = ptr;
 	}
 
-	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
+	r = amdgpu_vcn_sysfs_reset_mask_init(adev, inst);
 	if (r)
 		return r;
 
@@ -223,7 +223,7 @@ static int vcn_v5_0_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	amdgpu_vcn_sysfs_reset_mask_fini(adev);
+	amdgpu_vcn_sysfs_reset_mask_fini(adev, inst);
 	r = amdgpu_vcn_sw_fini(adev, inst);
 
 	kfree(ip_block->ip_dump);
-- 
2.25.1

