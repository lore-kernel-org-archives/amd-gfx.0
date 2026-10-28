Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0297606A31A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 08:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=S/Ph95IL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D4C110FA7F;
	Wed, 28 Oct 2026 08:57:52 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010012.outbound.protection.outlook.com [52.101.46.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C324D10FA7C
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 08:57:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OX89RxT6no+udW1di7C03+jcDScYLAec9ELLDpNxkrrIhp3+74waS3Hj+nnWjeWt2ViJWZ7eIxjGBMGuH4llr3k4WTRqb394D6QE33tWCfOzODNXADHwDwM21eBXogkLQm0k5/qQEB8Z5zcSnxCUKvR2WFtaUztNbvvCiZcwleLNRAlzfC5oIVhUHPadw5dOUap+mgkYeBLStQUv2kEoPiNt6fNawX+W3pbWqEnbGHcXXz2J6Q26jCcctdk0sku4KPkJjEz328Br/KKfyuRm/9brqzKAKBMjORkz5XoektWC5MNkbdgORrwToPvb0FZWc15cOsJwHCWhkgPh5ANutA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GM4ydBx1gJTSGjyU8HDkuWE+uZHVsUq45ic+xsnjw2s=;
 b=smsW8t6iJjje/KF2EGX8qHV9/axSiS62HMMVPhXuybLZ1TEd/lZ6peX1r50vkJLSazC1dJzaSC9pUQ7nWwMMzRw8NLV63ozuV1HltkmuBQRdWwN7QV8Rzep9LjDO5yLhVV1tmsQV03D6sITNXzvRQl1pYX4ikXf0q1dEgyFSi+7JXIZLfsrpfUVEF576QfDcSoSO7FYey2ja7EQoGNTEVf7ijy2azQj5IxA58hyqpMCbP7qXBJ3hbHGHfud2IhS9V4EzHt0VYykkeUka010ROK8A/k/b6WDSXo2MWbk6rN9xRJ13BLM98hL1XNUg4b2pVKhcWOIO2aQox+RaGdDYlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GM4ydBx1gJTSGjyU8HDkuWE+uZHVsUq45ic+xsnjw2s=;
 b=S/Ph95IL0EuwqG5SMpy5ctekZrj/M98UybVKPDvSJNBi3VmJtc546Jcn8UIC9cHTEHiqahRbdrpFm/sTtimJQx7XL/xNWxmdi0ZJMZia2I8YMaRu7LZ/BKf7LHvff4XGyx0nM91KFkG5nTUtLh0qp2/n7KOXHbO425EUr7LbvtY=
Received: from MW4PR04CA0275.namprd04.prod.outlook.com (2603:10b6:303:89::10)
 by CY8PR12MB7563.namprd12.prod.outlook.com (2603:10b6:930:96::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 08:57:40 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:303:89:cafe::98) by MW4PR04CA0275.outlook.office365.com
 (2603:10b6:303:89::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 08:57:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 08:57:39 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 03:57:39 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 28 Oct 2026 03:57:36 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <timur.kristof@gmail.com>, <Mario.Novales@amd.com>, 
 <Manu.Rastogi@amd.com>, <Jiongyu.Zhu@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH v3 01/15] drm/amdgpu: pass the device to the multi ring reset
 helpers
Date: Wed, 28 Oct 2026 16:56:32 +0800
Message-ID: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|CY8PR12MB7563:EE_
X-MS-Office365-Filtering-Correlation-Id: a53a0f1b-9b02-49f1-9ca0-08df34d18568
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|11063799006|56012099006|261009223027099003|261022105027099003|261026121527099003|261026140227099003|261021121427099003|261021123027099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: t/0JThK+U9aku9+cFXjmpez6EDoHzfbU1KB80eb2jrSoMyK0Q4yHSnsmutQZn/8jdPlZxst7++UOnFaCBuNI/QqPLwvf0Gw1CJAswB1+CxeodmfZU3PBcoafjkqqFMuwEnQPL+yLpVjuGCRX85Jz/lSXvtdOZ7OZ7+Bcnm2Xv1ecDyB3L2MIf21w8M2xzNlNAqlfshksPilZhXNtxT+enVLxxqImYx9hkbNUHJdfswfrDZiawDnlAtzEqfku1qfOFfrnNqNSStqbdbJWCkXeeO07/TRN5P8B///ckkXKqtNWtwQ48Wlze2xs+yzei77NpzukCGpXCxkciNFbqyW5u1tvYhLBMgYJ5xMfV8nzJa4mZ2xeikwfGDmgLqu4H6uQtUIhr2nrKdrFbkwIMek3pDV96oYYff95N7QM7nR3EkNE1nLLAZqxsaZqSrsRTIyLUTmrN/Glfj5bEgac/qI6FZmt2nyLtQf6bSqDMHTld3kiIUJztntvJf3yfKzb78pmiAYUt2TOMhIKueQG2F1fqLelpaLKEc1UqF7AvAps9dr/z6iTRnQAhwcCoCm3AniJwDmRC0kKAtTD+L6AmPw/sPi0DamgyI/nJDiiLXuHk1qILMF4vOo8oVooVFgSLrhr5+I65LoIzh56J3Cj1Esh59CiAICdqBYFgwohJ1CZ08sIRn3nPSoUZleoSjebtjSqhMf9tBgnYlkGFx2ZUf+Frg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261026121527099003)(261026140227099003)(261021121427099003)(261021123027099003)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: T8aJEQrjuXz91+wz5j1iqS2OFOFH0mh/mECKY+VgYizi4VkE5VFElZQ9IFbFEvdFqK2v8clGINyo/oiSZh3u0L8mbJKf5NvmyPFVTBk04AGfq2VUf988DSYT8pZSc3+DWs/s1cLUTPB4LG6GZNAaaGaRYuhWZQ5fmuxNBb+IVl8BKzVjsF1l60bjdVXiQRYiCsixRN2SswyL7yO/HesEP2HmCUdCkQ5SdjapDmtXE8MAoERBi23lVzjbiVpbA8sXXiGz+46HpnURtbH71Z7n/aStlRDG1R9CmdzbymylOveG7ntq3Y/c3igveuMRXZhyV+9nTCN2p3qNkfA+8ijHCkXw9Wb4PKL83b1nEYRr4KWOpuZvQV/XdVceglC++t/+P+3eyz9WN6T20y/cq4OW0n0bQXbsrKfU8Ycej6A8jFDIvqnvsM0Yltifnf7t+O9j
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 08:57:39.9649 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a53a0f1b-9b02-49f1-9ca0-08df34d18568
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7563
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

amdgpu_multi_ring_reset_helper_begin() and _end() take the device from
the guilty ring. A reset triggered by a hung user queue has no guilty
kernel ring, so pass the device explicitly and allow a NULL guilty ring.

No functional change.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c   |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 14 ++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  6 ++++--
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
index 734f2a0bc79a..d0b0d3eaffc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
@@ -465,11 +465,11 @@ int amdgpu_device_ip_soft_reset(struct amdgpu_ring *guilty_ring,
 	ring_type_mask = amdgpu_ring_mask_from_ip(ip_type);
 
 	amdgpu_device_lock_reset_domain(adev->reset_domain);
-	amdgpu_multi_ring_reset_helper_begin(ring_type_mask, guilty_ring, guilty_fence);
+	amdgpu_multi_ring_reset_helper_begin(adev, ring_type_mask, guilty_ring, guilty_fence);
 
 	r = ip_block->version->funcs->soft_reset(ip_block);
 
-	r = amdgpu_multi_ring_reset_helper_end(ring_type_mask, guilty_ring, r);
+	r = amdgpu_multi_ring_reset_helper_end(adev, ring_type_mask, guilty_ring, r);
 	amdgpu_device_unlock_reset_domain(adev->reset_domain);
 
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 7b67e8cecca2..edae764eb0c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -919,8 +919,9 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
 /**
  * amdgpu_multi_ring_reset_helper_begin() - Prepare multiple rings for a reset.
  *
+ * @adev: amdgpu device
  * @ring_type_mask: Bitmask of affected ring types
- * @guilty_ring: The ring which is guilty of causing a reset.
+ * @guilty_ring: The ring which is guilty of causing a reset, or NULL.
  * @guilty_fence: The fence which didn't signal on the guilty ring.
  *
  * Useful when performing a GPU reset method that affects
@@ -938,11 +939,11 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
  * After the reset is complete, the caller should then call
  * amdgpu_multi_ring_reset_helper_end() to restore the rings.
  */
-void amdgpu_multi_ring_reset_helper_begin(const u32 ring_type_mask,
+void amdgpu_multi_ring_reset_helper_begin(struct amdgpu_device *adev,
+					  const u32 ring_type_mask,
 					  struct amdgpu_ring *guilty_ring,
 					  struct amdgpu_fence *guilty_fence)
 {
-	struct amdgpu_device *adev = guilty_ring->adev;
 	struct amdgpu_fence *ring_guilty_fence;
 	struct amdgpu_ring *ring;
 	bool rings_busy;
@@ -1034,8 +1035,9 @@ void amdgpu_multi_ring_reset_helper_begin(const u32 ring_type_mask,
 /**
  * amdgpu_multi_ring_reset_helper_end() - Prepare multiple rings for a reset.
  *
+ * @adev: amdgpu device
  * @ring_type_mask: Bitmask of affected ring types
- * @guilty_ring: The ring which is guilty of causing a reset.
+ * @guilty_ring: The ring which is guilty of causing a reset, or NULL.
  * @ret: Return code from the reset function.
  *
  * After calling amdgpu_multi_ring_reset_helper_begin()
@@ -1046,10 +1048,10 @@ void amdgpu_multi_ring_reset_helper_begin(const u32 ring_type_mask,
  * be called to restore preemption state, but it won't attempt to
  * fully restore the ring contents.
  */
-int amdgpu_multi_ring_reset_helper_end(const u32 ring_type_mask,
+int amdgpu_multi_ring_reset_helper_end(struct amdgpu_device *adev,
+				       const u32 ring_type_mask,
 				       struct amdgpu_ring *guilty_ring, int ret)
 {
-	struct amdgpu_device *adev = guilty_ring->adev;
 	struct amdgpu_ring *ring;
 	int i, r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index b2040f80b7f2..7e6ed43771f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -637,10 +637,12 @@ void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
 				    struct amdgpu_fence *guilty_fence);
 int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
 				 struct amdgpu_fence *guilty_fence);
-void amdgpu_multi_ring_reset_helper_begin(const u32 ring_type_mask,
+void amdgpu_multi_ring_reset_helper_begin(struct amdgpu_device *adev,
+					  const u32 ring_type_mask,
 					  struct amdgpu_ring *guilty_ring,
 					  struct amdgpu_fence *guilty_fence);
-int amdgpu_multi_ring_reset_helper_end(const u32 ring_type_mask,
+int amdgpu_multi_ring_reset_helper_end(struct amdgpu_device *adev,
+				       const u32 ring_type_mask,
 				       struct amdgpu_ring *guilty_ring, int ret);
 bool amdgpu_ring_is_reset_type_supported(struct amdgpu_ring *ring,
 					 u32 reset_type);
-- 
2.50.1

