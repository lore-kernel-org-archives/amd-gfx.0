Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF342606A31A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 08:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uCM5Mys0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DDF310FA7C;
	Wed, 28 Oct 2026 08:57:58 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012059.outbound.protection.outlook.com [52.101.43.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E07910FA71
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 08:57:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UnsTBQmeVg4TfK3FcqVqdGAL+f9uL+Vmtb936MwVwNU0D8JLuaat4c+RQ+dPs8rcJnxoZUo7tpYR5g5e4wBvUih/ddEXgPnyAGD1wo8W5gOohxtD0NHwhuY6lZtLPjR5pqgygQATzjlpD1dKQ3G+mGGqsyJRkZX3HPRWMrqzSGdrYKWeRx1hiPzjjI2zIFd/7W1/DcYb1Y6KIVbTTAgjzn7ljw/Pk3MO2nWL51fOM7UTuJvhr00kHXpFsOinsyhDNV9mhv0DdTPJ+edn37UFyoC8rlCXxWjengwT9/EkXE+XJLtE+YvjrNwb9xGBLmEkcyq/BhVAPP50roIuBRS52g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKVY/3f4ZLk+eeL7iz9/U51BbpNdtob2KoaAsRvYQEY=;
 b=v3TkLEHRCgxbPA4oCwPzvkBtvDEnY9b9WklTghh+PJaNwOr2tZii6oI5oPTNFV8RG5A2ITfHDnHCC0Ox78kuExP94bWCqv0/trAm1tqNcjPBWnIi0ojP7D/QRyzu6vIoz0Ych2sa5wh5qjowIlDyA1Q28AgOpvZVxmNrPLbTz0fGX2TBDqA9uStJcEfysBCJZLXsEYNiiwXlGpQo4Ox84fCLBfmQv9N0VBRUxy4vZCFhwb6yLUnF07bgDUWTb0Sj+klgASeLtWTKiLg45+BSWxDjupVyOxgcdRhyQAoLA3zfNbPF/NFrJpoOBRFFOnO8hahUYWrdDMXY1Co6Fh2cyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKVY/3f4ZLk+eeL7iz9/U51BbpNdtob2KoaAsRvYQEY=;
 b=uCM5Mys0Ugr9TXjm1Pp8NyZZZ4XgXrEyX4+at06VIAqKDcPywze3jKKp7GdSPAa39u4JUc0v+d53qJAs4j70Lo4dGFbkMPZ+Bw7MnmEtOeWHGw088XA4IghldNvk82wzvP/sInIeChMloSv5RLMuLkas1bng0KQsk6nZn4a/2Dw=
Received: from MW4PR04CA0303.namprd04.prod.outlook.com (2603:10b6:303:82::8)
 by MN0PR12MB5787.namprd12.prod.outlook.com (2603:10b6:208:376::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 08:57:47 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:303:82:cafe::1f) by MW4PR04CA0303.outlook.office365.com
 (2603:10b6:303:82::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 08:57:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 08:57:46 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 03:57:44 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 28 Oct 2026 03:57:42 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <timur.kristof@gmail.com>, <Mario.Novales@amd.com>, 
 <Manu.Rastogi@amd.com>, <Jiongyu.Zhu@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH v3 03/15] drm/amdgpu: add an engine scope to the IP block soft
 reset
Date: Wed, 28 Oct 2026 16:56:34 +0800
Message-ID: <20261028085736.3808569-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
References: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|MN0PR12MB5787:EE_
X-MS-Office365-Filtering-Correlation-Id: 68cd04f5-1a0d-4431-0480-08df34d18953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|18002099003|22082099003|261026140227099003|261021121427099003|56012099006|11063799006|10067099003|261022105027099003|261009223027099003|261022115727099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: RyjrscaYr9P7NyRgo4+PkkktrYLgyB/dQKpIe3LqnMO+OFjelLWvb8UNkyLb9vLwrgLffSf0GXlRAb6p0Aefpa1iB1ZhqXEoTXMh9FB7We24v9SEQqpGhCEiFrliBsRcDIuOLEsKmbN3LloHboq7zmaadUXjNk6gYM5wz3sxPh6Q5LtEgHpqPRf2Qq8w6jF9hNIGUazuHF1YU//Knh9zQPaDk3b+KEZ2Z+GF4ctS39o7haVuzo/bLux2ot85DHLT/P+zwZO4VmixrMCb380FuZNz46Tdr+Fcdo2q9aI3O0LzCfFNYBFUnrVIZBjonX1KNwis0JU78w394mPNvUNuJCix9aXjKCcskutss7lGSmRkme8KloJIyqpYiwAg+FhSUXB6DGyL0QNv1r65lCYSff9M8Hd3Ui6b/OmY2KTMGQW3H/6Ux0KwjQlizJAwAHcSOOZKHEPM8fHk7zmLknJ1W9pkGmCQLeu/NveQT64eIrfMYWsyhZ+5W/taKWaEDDkirteODQina5sdcwLpKMnmpPEup1Y16PHG44PVUP5iQJHpBiuxBtRl86y4Lk6ge01JlH+ut5qWPAQ67lmJzr0skc9V7Xlnp/aRxMfn2n1uKOahyH2Nshqhx69FStMFm1Y57iGUS4x/6H2C3MGl/+Rp338DlpdnEnucCo5IL9pnqzZyLwKH83ZiIPiCOLSg7vb4LfdFMmbvumZhsDGkExqBag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(18002099003)(22082099003)(261026140227099003)(261021121427099003)(56012099006)(11063799006)(10067099003)(261022105027099003)(261009223027099003)(261022115727099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EBQRJddxkOAhbHc8YGw284xMsct6FW3/cohK6k2e23cS8LQi8dxAXdyZaWL1zhNTthRxgeV30MnBg6qkwoWMSxQpc6J9SnPAdKE5cwA/XTHaXZP9xF/7c2EzBJ/jcUd1s3/4aLkLqKtkZmam/c7VdG6553db4GejBJpRh22vGMSJAPBOTAk74H9xQgwHAc4Qoi+qSRecZtI1iwaSdkkSxd11awxGi25oLh8yzBAyJn/PbYGQGPYwfsC2o3zgzKxLPnZTTQANaZRWOXQKp098J/8jPghAm3wJy+JDejtoCL88RYn4gQC4HbPujmJUwNFGWeZTWFkRdEKJxi04+qavFu6hJQAaS3FSu/eO4qrYP8urqHIk5M83gfhYVxQDYEiIC26LNfwkJZ9IjZOcxVYz+E55JWSfiipZKoFl1mSpzYkarJYg8MRIJzdW63k0QWKb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 08:57:46.5625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68cd04f5-1a0d-4431-0480-08df34d18953
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5787
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

Some IP blocks have engines that the hardware can reset on their own,
eg. the graphics and compute engines of the GFX IP
(CP_SOFT_RESET_CNTL.GFX_ONLY_SOFT_RESET / CMP_ONLY_SOFT_RESET). Resetting
only the engine of a hung ring leaves the work on the other engines
alone, which the IP block soft reset can't do, as it resets every ring
of the IP block.

Add an optional soft_reset_engine() IP block callback, which resets one
engine of the IP block, or all of them, and recovers the user queues on
it, and amdgpu_device_ip_soft_reset_engine() around it. It only stops,
backs up and replays the rings of that engine, and it is also reachable
without a guilty kernel ring, for a hung user queue.

For a single engine, it only takes the reset domain for read: KFD only
try-locks it for read before it adds or removes queues, and would fail
those calls with the write lock although the other engines aren't
reset.

amdgpu_device_ip_soft_reset() uses it when the IP block implements it,
for the engine of the guilty ring.

v3: replaces the separate engine reset type and helper
    (Timur).

Suggested-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c   | 116 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h   |   6 ++
 drivers/gpu/drm/amd/include/amd_shared.h |  18 ++++
 3 files changed, 140 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
index 2eea18965fd1..e95f69dd3142 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
@@ -418,6 +418,111 @@ static u32 amdgpu_ring_mask_from_ip(const enum amd_ip_block_type ip_type)
 	}
 }
 
+/**
+ * amdgpu_ring_mask_from_engine() - Find mask of ring types of an engine.
+ *
+ * @ip_type: The IP block type of the engine.
+ * @engine: The engine whose rings you are looking for.
+ */
+static u32 amdgpu_ring_mask_from_engine(const enum amd_ip_block_type ip_type,
+					const enum amd_ip_engine engine)
+{
+	switch (engine) {
+	case AMD_IP_ENGINE_GFX:
+		return BIT(AMDGPU_RING_TYPE_GFX);
+
+	case AMD_IP_ENGINE_COMPUTE:
+		return BIT(AMDGPU_RING_TYPE_COMPUTE);
+
+	default:
+		return amdgpu_ring_mask_from_ip(ip_type);
+	}
+}
+
+/**
+ * amdgpu_engine_from_ring() - Find the engine of a ring type.
+ *
+ * @ring_type: The ring type whose engine you are looking for.
+ */
+static enum amd_ip_engine amdgpu_engine_from_ring(const enum amdgpu_ring_type ring_type)
+{
+	switch (ring_type) {
+	case AMDGPU_RING_TYPE_GFX:
+		return AMD_IP_ENGINE_GFX;
+
+	case AMDGPU_RING_TYPE_COMPUTE:
+		return AMD_IP_ENGINE_COMPUTE;
+
+	default:
+		return AMD_IP_ENGINE_ALL;
+	}
+}
+
+static const char *const amdgpu_ip_engine_names[] = {
+	[AMD_IP_ENGINE_ALL] = "all",
+	[AMD_IP_ENGINE_GFX] = "gfx",
+	[AMD_IP_ENGINE_COMPUTE] = "compute",
+};
+
+/**
+ * amdgpu_device_ip_soft_reset_engine() - Soft reset one engine of an IP block.
+ *
+ * @adev: amdgpu device
+ * @ip_type: The IP block type.
+ * @engine: The engine to reset, or AMD_IP_ENGINE_ALL for the whole IP block.
+ * @guilty_ring: The ring which is guilty of causing a reset, or NULL.
+ * @guilty_fence: The fence which didn't signal on @guilty_ring.
+ * @guilty_queue: The user queue which is guilty of causing a reset, or NULL.
+ */
+int amdgpu_device_ip_soft_reset_engine(struct amdgpu_device *adev,
+				       enum amd_ip_block_type ip_type,
+				       enum amd_ip_engine engine,
+				       struct amdgpu_ring *guilty_ring,
+				       struct amdgpu_fence *guilty_fence,
+				       struct amdgpu_usermode_queue *guilty_queue)
+{
+	struct amdgpu_ip_block *ip_block;
+	u32 ring_type_mask;
+	int r;
+
+	ip_block = amdgpu_device_ip_get_ip_block(adev, ip_type);
+	if (!ip_block || !ip_block->version->funcs->soft_reset_engine)
+		return -EOPNOTSUPP;
+
+	dev_err(adev->dev, "Starting %s %s engine soft reset\n",
+		ip_block->version->funcs->name, amdgpu_ip_engine_names[engine]);
+
+	ring_type_mask = amdgpu_ring_mask_from_engine(ip_type, engine);
+
+	if (engine == AMD_IP_ENGINE_ALL)
+		amdgpu_device_lock_reset_domain(adev->reset_domain);
+	else
+		down_read(&adev->reset_domain->sem);
+	amdgpu_multi_ring_reset_helper_begin(adev, ring_type_mask, guilty_ring,
+					     guilty_fence);
+
+	r = ip_block->version->funcs->soft_reset_engine(ip_block, engine,
+							guilty_queue);
+
+	r = amdgpu_multi_ring_reset_helper_end(adev, ring_type_mask, guilty_ring,
+					       guilty_fence, r);
+	if (engine == AMD_IP_ENGINE_ALL)
+		amdgpu_device_unlock_reset_domain(adev->reset_domain);
+	else
+		up_read(&adev->reset_domain->sem);
+
+	if (r) {
+		dev_err(adev->dev, "Failed %s %s engine soft reset: %d\n",
+			ip_block->version->funcs->name,
+			amdgpu_ip_engine_names[engine], r);
+		return r;
+	}
+
+	dev_err(adev->dev, "Successful %s %s engine soft reset\n",
+		ip_block->version->funcs->name, amdgpu_ip_engine_names[engine]);
+	return 0;
+}
+
 /**
  * amdgpu_device_ip_soft_reset() - Perform a graceful soft reset on an IP block.
  *
@@ -430,6 +535,9 @@ static u32 amdgpu_ring_mask_from_ip(const enum amd_ip_block_type ip_type)
  * resets all rings that belong to the same device IP block
  * and re-initializes the device IP block.
  *
+ * IP blocks with engines that can be reset separately only reset the engine
+ * of @guilty_ring, see amdgpu_device_ip_soft_reset_engine().
+ *
  * The reset is handled gracefully, meaning that we try to
  * minimize collateral damage (ie. avoid rejecting non-guilty jobs)
  * as well as back up and restore the contents of all rings
@@ -441,6 +549,7 @@ int amdgpu_device_ip_soft_reset(struct amdgpu_ring *guilty_ring,
 	struct amdgpu_device *adev = guilty_ring->adev;
 	struct amdgpu_ip_block *ip_block;
 	enum amd_ip_block_type ip_type;
+	enum amd_ip_engine engine;
 	u32 ring_type_mask;
 	int r;
 
@@ -453,6 +562,13 @@ int amdgpu_device_ip_soft_reset(struct amdgpu_ring *guilty_ring,
 		return -EOPNOTSUPP;
 	}
 
+	if (ip_block->version->funcs->soft_reset_engine) {
+		engine = amdgpu_engine_from_ring(guilty_ring->funcs->type);
+		return amdgpu_device_ip_soft_reset_engine(adev, ip_type, engine,
+							  guilty_ring,
+							  guilty_fence, NULL);
+	}
+
 	if (!ip_block->version->funcs->soft_reset) {
 		dev_warn(adev->dev, "IP block soft reset not supported on %s\n",
 			 ip_block->version->funcs->name);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
index 5dd6273982c4..856297d1c8e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
@@ -160,5 +160,11 @@ bool amdgpu_device_ip_is_valid(struct amdgpu_device *adev,
 			       enum amd_ip_block_type block_type);
 int amdgpu_device_ip_soft_reset(struct amdgpu_ring *guilty_ring,
 				struct amdgpu_fence *guilty_fence);
+int amdgpu_device_ip_soft_reset_engine(struct amdgpu_device *adev,
+				       enum amd_ip_block_type ip_type,
+				       enum amd_ip_engine engine,
+				       struct amdgpu_ring *guilty_ring,
+				       struct amdgpu_fence *guilty_fence,
+				       struct amdgpu_usermode_queue *guilty_queue);
 
 #endif /* __AMDGPU_IP_H__ */
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index e81ce9d79009..95cdd0fc191e 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -29,6 +29,7 @@
 
 #define AMD_MAX_USEC_TIMEOUT		1000000  /* 1000 ms */
 struct amdgpu_ip_block;
+struct amdgpu_usermode_queue;
 
 
 /*
@@ -422,6 +423,18 @@ enum DC_DEBUG_MASK {
 
 enum amd_dpm_forced_level;
 
+/**
+ * enum amd_ip_engine - the engines of an IP block that can be soft reset
+ * @AMD_IP_ENGINE_ALL: all the engines of the IP block
+ * @AMD_IP_ENGINE_GFX: the graphics engine of the GFX IP block
+ * @AMD_IP_ENGINE_COMPUTE: the compute engine of the GFX IP block
+ */
+enum amd_ip_engine {
+	AMD_IP_ENGINE_ALL,
+	AMD_IP_ENGINE_GFX,
+	AMD_IP_ENGINE_COMPUTE,
+};
+
 /**
  * struct amd_ip_funcs - general hooks for managing amdgpu IP Blocks
  * @name: Name of IP block
@@ -441,6 +454,8 @@ enum amd_dpm_forced_level;
  * @complete: handles IP specific changes after resume
  * @wait_for_idle: poll for idle
  * @soft_reset: soft reset the IP block
+ * @soft_reset_engine: soft reset one engine of the IP block, or all of them,
+ *                     and recover the user queues on it
  * @set_clockgating_state: enable/disable cg for the IP block
  * @set_powergating_state: enable/disable pg for the IP block
  * @get_clockgating_state: get current clockgating status
@@ -469,6 +484,9 @@ struct amd_ip_funcs {
 	void (*complete)(struct amdgpu_ip_block *ip_block);
 	int (*wait_for_idle)(struct amdgpu_ip_block *ip_block);
 	int (*soft_reset)(struct amdgpu_ip_block *ip_block);
+	int (*soft_reset_engine)(struct amdgpu_ip_block *ip_block,
+				 enum amd_ip_engine engine,
+				 struct amdgpu_usermode_queue *guilty_queue);
 	int (*set_clockgating_state)(struct amdgpu_ip_block *ip_block,
 				     enum amd_clockgating_state state);
 	int (*set_powergating_state)(struct amdgpu_ip_block *ip_block,
-- 
2.50.1

