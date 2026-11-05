Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C178606A32D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 03:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=o6sSFOb6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BC0410F210;
	Thu,  5 Nov 2026 03:06:25 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010007.outbound.protection.outlook.com [52.101.46.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A57F10E0D3
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 03:06:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8N2k8qSNKqa/qsYAyRSnPU3JXKWHpgPO55OB849XorelZtf0I1naHzdqP9o/ZWgFzCeeRGPcmhJQKpVPBVJrLauhGQXdAf7xzBVydofrwVJk68gjNdi0mMZLo74ZQx7FQ6PdufCRDrDKFOb1/Xet7y3dgqum0IBFEawPWhFiiWRde1W/fWfmxf8JS4wR7S0MuKXY5XP+mG5ICJM4+i1t9vYT8ZayY+twfkqfRvqLChFTFFyDoWnPX6KomLm7Tal2GDnxWXYbOxghNd7S+QyrLPj8RFrOWV5YqLfJut/7BaoSg+F2tI30pG3dUAVB69kkyHQo24NIV5R0dO+rdT7XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GM4ydBx1gJTSGjyU8HDkuWE+uZHVsUq45ic+xsnjw2s=;
 b=uji3RTELTlnEfT1B9kj2OLMy/aZCvEFhQ+teoEdKt/kAYsgyiOHeQNTwchxvnlMthldppFt1382zLP1+SYHtIrpj9CTt9AGPzWXXPKCM90ibig0w4MAOIilqSjCO+2Cle2qs5kHiNrkK8XRAlcURWa4+pxIlrVPv5LTH2iHikuCq9Z2ymcohjUm7pQqFHnmgYB2hmXDavqTrWNbZFQgkqEQ0foOB39Qws3ZnQ+kh6kx3db+M3MCQsRE2QtEGaJJnWxKJXuSS7pZX1DUZYdbVE4ArIPAlhOiwXpeheMZMwadKHV16T/NLVWDk37X+GFE1Ppk3NXa4SA57avdj1Dw2mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GM4ydBx1gJTSGjyU8HDkuWE+uZHVsUq45ic+xsnjw2s=;
 b=o6sSFOb6vAd6BI+3k5ZSa6oJT4GXPjhgWKHpDR2CqFzEcMPOZdtW/Vos7SflHEfk5MRq2mYSLU6WrF2f5aXTEoCLX/6XazKvFAYJst76uCGPxAgGo6c0L1uQwtzM8VCs2flxmEGjPNrwy8IUV8HB2T33ocbuaObIUss315T8THM=
Received: from CH0PR13CA0035.namprd13.prod.outlook.com (2603:10b6:610:b2::10)
 by LV8PR12MB9208.namprd12.prod.outlook.com (2603:10b6:408:182::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 03:06:16 +0000
Received: from DM3PEPF000265BB.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::45) by CH0PR13CA0035.outlook.office365.com
 (2603:10b6:610:b2::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4 via Frontend Transport; Thu, 5
 Nov 2026 03:06:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM3PEPF000265BB.mail.protection.outlook.com (10.167.23.248) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 03:06:15 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 21:06:15 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 21:06:15 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 4 Nov 2026 21:06:13 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <timur.kristof@gmail.com>, <Mario.Novales@amd.com>, 
 <Manu.Rastogi@amd.com>, <Jiongyu.Zhu@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH v4 01/13] drm/amdgpu: pass the device to the multi ring reset
 helpers
Date: Thu, 5 Nov 2026 11:05:43 +0800
Message-ID: <20261105030612.726542-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BB:EE_|LV8PR12MB9208:EE_
X-MS-Office365-Filtering-Correlation-Id: 557754b5-50ce-4c85-d3a6-08df3ae9c1a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|11063799006|56012099006|261009223027099003|261021123027099003|261028144727099003|261021121427099003|261022105027099003|261026121527099003|261102123227099003|261026140227099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: xZpapu6uheaoVYEkWJ0scFI98b+yvRxmRCSq6za80FAyFiI4OU12JpDaZtj/hJhKAWBZkcDr7hzok9IIdNPLuB0IMCI5pz8pYDAoGdqqZEDK1iLua2m86eUDssFiy/WgioA45JBobnR7umNZ9W5C8K3KBe78UG+zBW4CQjBCuTr8wRzMsItogoU+2YVnMHV27HRdwyknFA7rUx8i6KOvWsQufb1QYVFT2CLsUQaSZn0zGkXZF8u7dGBM2djlTh+DQcjSX068Rg/3ObzvPn1oFbTyoCs/1L+lw7obbFJRdYfPfrpIe0TV8e8FOpXtXMqSBRGwXZezlsMiRYPYOB2Ii+zLqtGT2aa/YSySRcYHbzzV9tltVVOVE82unwrgUEdRINcKLoH/T7G8bmXDpQydgIeUw0bN+YJX/BMvvSaCEQ5Mw6zDLRArO/e4eMieqThhFtQFpOIwGH+OTPXvhuC5bfOpYjCaTguZaEmbTK6eCu4ZK5VttAvZy0lGz8XRfmNxyxUe+tC273CY8oa70vLO3utN37hVhuUp6vargJH2xt0BU+tHeisQS84Sn8I0CeEbE/REBRvfzLTgMRUA0oKju34aHJfCCwu7I/ozB9CdCSbLsRu33lr+/JzxuBnxJSYSVsUE0WVvl7jrDVPSLvQ0a5jOUEAtsLrLqTKxiIHAYAxMeye2kp6P22R2ZofqsJF+fM9NrZZo2dU1Y1hjiM6vvw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(11063799006)(56012099006)(261009223027099003)(261021123027099003)(261028144727099003)(261021121427099003)(261022105027099003)(261026121527099003)(261102123227099003)(261026140227099003)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: d/a0JKbTealADwIHpXlxKFlDtDHcXvedSj/etZJjPaD7anS0xDjZ6cfE1Q8n0phQI2EFOrfe6/E8o965uhU8eoTuXKZguA9rvw5KN9ycUR0+Wc25/TpKB9oZKrz1qgu+S56HQzFgFvxqNixSn4V/TjiwlSnnb2y2l+21pMzFFIudZpAOmHEvjFrugnLJC1x74XK9QR0kZkgbIV0xiwLLhGZdsRwqLMutZI/t5F3JhsW7YbpVYxf0Mw1ene2lg3IaRWiVmdrTyLglhcz6Y8eVtWA/7PGkyVBnQ9n9UueZAmFTnyg2WrOMKZUDwwe/XnDubyUac9wUnNCm9zy0qntavzvas+5FqIRldHxfCixLDHFurVAIpSe8BJeriZNWrOhjujjDgeAUXDGGb2judc+Mp7cLQMq9oFBYgsN/lJdjAQBZZBDnZ4KpWLr31QJZCGan
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 03:06:15.9504 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 557754b5-50ce-4c85-d3a6-08df3ae9c1a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265BB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9208
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

