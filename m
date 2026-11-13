Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D0D6074B2C
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 17:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=FWLdNMgD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 513E610E4D0;
	Fri, 13 Nov 2026 17:16:26 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010026.outbound.protection.outlook.com [52.101.61.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35A5D10E3A8
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 17:16:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEzDgigVHGOiSNvlR29T1kzZeD+NerPOLfYRN0wfTBAVSgfKLtKlUFw85W4O7uvya4ACMf4CPhFLgSaGi78MKRJc1McoG/Z5N8UMnMHiq9fwa+OQM/Y5cQZw/67FSmCgX9i7y2ZBH/3eniGcE7I1IwgB+H8Zg4GvljlX6KYQ7P9iwljPhh+eQxtKS6EpVUuW1zNpNgAsqhnPhvkTiYTnKhU3CzdgovBMkn6PX6PxvMg0+iguwuhdjtGDAqvbomiwttZWFcpe8ZepchP0yIXb4zyYDbgNsCJunP9zLRxF7hl+Wx9scqI+Rh0fmCagdtFNX8YMT//wLYAt5Z7TTmpZLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13nokFNMwwsjkQ8rv3ysngiejUHGK3HpBA7aFPNxKiU=;
 b=ivoQFkyGAAKk1X5QsUXId5lHu/ZarMm+DdN5KByb6xlM78qhgQK2dZCy12KUyuu10wXhnxActxpNu1KGsxUg0z5asiafyM1A0pd0f26PBJbRi8nPFY7AftWsPk2KkMn+ZlUiXDAo3gch2VyairIVy103cGrxT+P2Cp1VOgSVniDLho2f5+PFKZIg3O5iaA3RU6s+ujGQYMbuVeRxWjSCWRiluJQdzILJLJbkytR3yOsf2rhnwpS3rt184IUamfbexLoy09HxzW8UQxWkN/6xGBZuxH9P9mGcbo62NVfjg7bF3HJtKDU/qy/VcqE9vON+mlB4EMWuhg53G1bRqONZ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13nokFNMwwsjkQ8rv3ysngiejUHGK3HpBA7aFPNxKiU=;
 b=FWLdNMgDMxmqqUGgcsVTV+I02A14Ml15V4YlZqXXAA2cwjhT0KjI08Uhm4bkfHwUaPXFX/x9OVz1g51DkiKKyhlIHBTKF6RuJgJjSbOBwiGq5xfVC4lzdFGTsUtEPSUvYMkCw4rkqP8CjzXpcEY2KdnEJOR8GKzAmUYg6vvDFZk=
Received: from CH2PR15CA0015.namprd15.prod.outlook.com (2603:10b6:610:51::25)
 by DS5PPFFF21E27DC.namprd12.prod.outlook.com (2603:10b6:f:fc00::66b)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Fri, 13 Nov
 2026 17:15:23 +0000
Received: from BN2PEPF0000A803.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::2a) by CH2PR15CA0015.outlook.office365.com
 (2603:10b6:610:51::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Fri, 13
 Nov 2026 17:15:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A803.mail.protection.outlook.com (10.167.245.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 17:15:22 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 13 Nov
 2026 11:15:21 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>,
 <Harish.Kasiviswanathan@amd.com>, <Mukul.Joshi@amd.com>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v2] drm/amdgpu: Init UALink metadata only once
Date: Fri, 13 Nov 2026 12:15:03 -0500
Message-ID: <20261113171503.3873545-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A803:EE_|DS5PPFFF21E27DC:EE_
X-MS-Office365-Filtering-Correlation-Id: b28f3c08-2f04-4028-115c-08df41a9b37b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|10067099003|11063799006|56012099006|261022075727099003|261021123027099003|261026121527099003|261026140227099003|261022105027099003|261102123227099003|261028144727099003|261021121427099003|261009223027099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: I+/9eKT0rc8UTCZYEVHYdMoAE9wilz4LsccViFqHKUFbpOUCmF39/bkLcpdu+vxvgn+QvEMbi7O7XnUqr/CEYMzyXjW2jjANyRHFrKyI4/y/FoFv+0X44TnH9vuVv9GZNtfIm7yxowsOrsVFo6A5XzJSTv7mi93JpmXjKrp/ZE78+y5RQgh4p14hreUPJXp/XRLDMAy15hdnq6BgLoBV5zrK24Jfm8aw6BJAiLWoj/2eFYMiGAxkAkzIZ3/qviE620OGZZ/mGhPfkcwWtKvDl0aTDRXxs1BmNIdwRYVOXQvHbNN94/Sib3l4/6EEepn3dhXmdx6GNPaV96lYO+t8NIyaUlv17G9WKmqkg2bd5nqFWrw41zzY9arojynt5JEIU5HHM7zrqleWxw1PNZCmsjJiEwCtrL3N2nUfOog7+Tc1KzUjYEo7B9Ekl39zkPaY1vNNhqmkbY4HJ0fRVDRpfah+PB+JkaDgJZe+bKu5rDhnO907y9rqo8z/ueEFyJB2Ll7bNRXeL7u9UnIrFrDLuIAu32z4d6DFpgWplqkG6PmuOFny19Y9xE8wfhOxb9GdejVYZ+Nw8Dr6bUO1pDrlsY+omZbiiBVx5bso3NjMnIufqsc3NAcfcRoZwhOz7CIkT7C2qdemglpcqDzUa0sOD/e8AZy+o3hIeqF4mrpi4hZtCLjSO4Nyv02OZka2Dz83sADkTjP8b6LsucmCpVZsKA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(261022075727099003)(261021123027099003)(261026121527099003)(261026140227099003)(261022105027099003)(261102123227099003)(261028144727099003)(261021121427099003)(261009223027099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PTM4S0QrvfERYxFfZqgB24uu/5OGM3S4NpEQhn8lUFgZVjyMk0wC3E/Hc0PyDckXdNQ6azSaNqoXUyI0dM3SX01jGSckho/P+itZkePyrJOmmBGOHTafevA9LiBhiu0VwW/T8Nz0/IFrujzMw/PduobgLSBisQsuR/F9NB6PpiEb3WZaTCVlAEsh5T32ctd29rIDfy85QIRbVZQJwGTBMVz2+MSjfPD6gwXmSTS73fNIeFzSSw/Wm85h6Fqd/GKvcv4+94u1gYHIBONlvBZwJXCT4FKHYnROLmfdsYrrtUhSN4DR7NWfoDW0bH9L+do1AW2hqtM0Zpx0GIqYQ/XJl9H6mZIdJy64/CJA0tHU/1iNJY34IGf2cH+mH/sUtPTEeP6uX2XdRV2P6ZFKhEB8d3oY4yBlRajeSkG/WpvibMPHTI6ZU3D0MKhn3X3vv1FH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 17:15:22.5945 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b28f3c08-2f04-4028-115c-08df41a9b37b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A803.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFFF21E27DC
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

Metadata init sends the metadata to nHT FW, which resets it, so doing it
on every vpod activation forces all running applications to be killed on
each reconfig.

The layout only depends on the address mode and the local accelerator id,
not on which accelerators are active, so init it on the first activation
only and cover all accelerators. It stays allocated until the driver
unloads. Keep it on the activation path, the address mode is only known
after the vpod is activated.

The buffers now outlive a reconfig, so peer init no longer resets the
ring state on reactivation.

v2:
  - Keep the ring state on reactivation instead of resetting it

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 97 +++++++++++-----------
 1 file changed, 49 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index fbd647c5d320..36c2874ea1b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -57,6 +57,7 @@ static void amdgpu_ualink_reset_peer_rings(struct amdgpu_device *adev,
 					   u32 remote_accel_id);
 static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
 					  u32 remote_accel_id);
+static void amdgpu_ualink_metadata_fini(struct amdgpu_device *adev);
 
 #define STRIP_NPA(addr)						\
 	(((u64)(addr) & ~AMDGPU_UALINK_NPA_ADDR_GPUID_MASK))
@@ -1587,7 +1588,14 @@ int ualink_ip_sw_init(struct amdgpu_ip_block *ip_block)
 
 int ualink_ip_sw_fini(struct amdgpu_ip_block *ip_block)
 {
-	amdgpu_ualink_object_fini(ip_block->adev);
+	struct amdgpu_device *adev = ip_block->adev;
+
+	/* Halt FW and free remote when unloading driver */
+	if (adev->ualink.remote) {
+		adev->ualink.msg_ctl->send_halt(adev);
+		amdgpu_ualink_metadata_fini(adev);
+	}
+	amdgpu_ualink_object_fini(adev);
 	return 0;
 }
 
@@ -5244,6 +5252,9 @@ static void amdgpu_ualink_metadata_fini(struct amdgpu_device *adev)
 			      &remote->rb_cpu_addr);
 	amdgpu_bo_free_kernel(&remote->metadata_bo, &remote->metadata_gpu_addr,
 			      &remote->metadata_cpu_addr);
+
+	kfree(adev->ualink.remote);
+	adev->ualink.remote = NULL;
 }
 
 /**
@@ -5257,18 +5268,17 @@ static void amdgpu_ualink_metadata_fini(struct amdgpu_device *adev)
  */
 static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
 {
-	struct amdgpu_ualink_remote *remote = to_remote(adev);
+	struct amdgpu_ualink_remote *remote;
 	struct amdgpu_ualink_metadata *metadata;
 	u32 size, rb_size, wptr_size, rptr_size, metadata_size;
 	u64 rb_gpu_addr, wptr_gpu_addr;
 	u32 status, accel_id;
 	int r;
 
-	bitmap_copy(remote->active_accel_bits,
-		    adev->ualink.info->vpod.active_accel_bits,
-		    AMDGPU_UALINK_ACCEL_MAX);
-	dev_dbg(adev->dev, "%d active accelerators config in vpod\n",
-		bitmap_weight(remote->active_accel_bits, AMDGPU_UALINK_ACCEL_MAX));
+	remote = kzalloc_obj(struct amdgpu_ualink_remote);
+	if (!remote)
+		return -ENOMEM;
+	adev->ualink.remote = remote;
 
 	/*
 	 * allocate metadata entries and ring buffer for all remote GPUs,
@@ -5280,8 +5290,10 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
 	if (status != AMDGPU_NHT_FW_ST_PREINIT &&
 	    status != AMDGPU_NHT_FW_ST_HALT) {
 		dev_dbg(adev->dev, "fw status 0x%x not preinit or halt\n", status);
-		if (!adev->ualink.selftesting)
-			return -ENODEV;
+		if (!adev->ualink.selftesting) {
+			r = -ENODEV;
+			goto out;
+		}
 	}
 
 	dev_dbg(adev->dev, "accel_id %u addr_mode %d fw status 0x%x\n",
@@ -5360,9 +5372,7 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
 	if (ualink_addr_mode(adev) == AMDGPU_UALINK_ADDR_MODE_SOURCE_ALIAS)
 		wptr_gpu_addr = remote->rb_gpu_addr + rb_size * ualink_accel_id(adev);
 
-	for_each_set_bit(accel_id, remote->active_accel_bits, AMDGPU_UALINK_ACCEL_MAX) {
-		dev_dbg(adev->dev, "init for accel_id %u\n", accel_id);
-
+	for (accel_id = 0; accel_id < remote->num_accel; accel_id++) {
 		if (accel_id == ualink_accel_id(adev))
 			continue;
 
@@ -5388,11 +5398,9 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
 		metadata[accel_id].tailptr_tlb_inv = wptr_gpu_addr +
 						     ualink_tlb_wptr_offset(adev, accel_id);
 
-		dev_dbg(adev->dev, "init from accel_id %u to accel_id %u, rb_size 0x%x\n",
-			accel_id, ualink_accel_id(adev), metadata[accel_id].rb_size);
-		dev_dbg(adev->dev, "rb 0x%llx tlb rb 0x%llx\n",
-			metadata[accel_id].ri_rb, metadata[accel_id].tlb_inv_rb);
-		dev_dbg(adev->dev, "rb wptr at 0x%llx tlb wptr at 0x%llx\n",
+		dev_dbg(adev->dev, "accel %u to %u, rb 0x%llx tlb 0x%llx wptr 0x%llx tlb 0x%llx\n",
+			accel_id, ualink_accel_id(adev),
+			metadata[accel_id].ri_rb, metadata[accel_id].tlb_inv_rb,
 			metadata[accel_id].tailptr_ri, metadata[accel_id].tailptr_tlb_inv);
 	}
 
@@ -6258,15 +6266,15 @@ static int amdgpu_ualink_peer_remote_init(struct amdgpu_device *adev)
 		dev_dbg(adev->dev, "tlb doorbell npa 0x%llx mapped on gart 0x%llx\n",
 			npa, shootdown->doorbell_npa_gart);
 
+		/*
+		 * A vpod reconfig does not reboot the peer, the FW and the
+		 * metadata are unchanged, so keep seq, wptr, rptr and ready. A
+		 * resync would not move the wptr anyway, and keeping seq lets the
+		 * next command increment it so the wait on the writeback seq
+		 * still completes.
+		 */
 		interrupt->rb_size = AMDGPU_UALINK_RB_SIZE / 64;
-		interrupt->wptr = 0;
-		interrupt->rptr = 0;
-		interrupt->seq = 0;
-
 		shootdown->rb_size = AMDGPU_UALINK_RB_SIZE / 64;
-		shootdown->wptr = 0;
-		shootdown->rptr = 0;
-		shootdown->seq = 0;
 	}
 
 	dev_dbg(adev->dev, "peer remote init done r=%d\n", r);
@@ -6312,30 +6320,32 @@ static void amdgpu_ualink_peer_remote_fini(struct amdgpu_device *adev)
  * amdgpu_ualink_sw_init - Initialize UALink software resources
  * @adev: amdgpu device pointer
  *
- * Performs full UALink software initialization including metadata allocation,
- * NPA address mapping, SDMA scheduler entity setup, and remote peer GPU
- * connection initialization. On failure, all previously initialized resources
- * are cleaned up.
+ * Performs full UALink software initialization including NPA address mapping,
+ * SDMA scheduler entity setup, and remote peer GPU connection initialization.
+ * On failure, all previously initialized resources are cleaned up.
  *
  * Return: 0 on success, negative error code on failure
  */
 int amdgpu_ualink_sw_init(struct amdgpu_device *adev)
 {
-	struct amdgpu_ualink_remote *remote;
 	int r;
 
-	remote = kzalloc(sizeof(*remote), GFP_KERNEL);
-	if (!remote)
-		return -ENOMEM;
-	adev->ualink.remote = remote;
+	/* Sending metadata resets the nHT FW, only do it on the first activation. */
+	if (!adev->ualink.remote) {
+		r = amdgpu_ualink_metadata_init(adev);
+		if (r)
+			return r;
+	}
 
-	r = amdgpu_ualink_metadata_init(adev);
-	if (r)
-		goto out;
+	bitmap_copy(adev->ualink.remote->active_accel_bits,
+		    adev->ualink.info->vpod.active_accel_bits,
+		    AMDGPU_UALINK_ACCEL_MAX);
+	dev_dbg(adev->dev, "%d active accelerators config in vpod\n",
+		bitmap_weight(adev->ualink.remote->active_accel_bits, AMDGPU_UALINK_ACCEL_MAX));
 
 	r = amdgpu_ualink_metadata_npa_mapping(adev);
 	if (r)
-		goto out_metadata_fini;
+		goto out;
 
 	r = amdgpu_ualink_sdma_entities_init(adev);
 	if (r)
@@ -6352,11 +6362,7 @@ int amdgpu_ualink_sw_init(struct amdgpu_device *adev)
 	amdgpu_ualink_sdma_entities_fini(adev);
 out_npa_unmap:
 	amdgpu_ualink_metadata_npa_unmapping(adev);
-out_metadata_fini:
-	amdgpu_ualink_metadata_fini(adev);
 out:
-	kfree(adev->ualink.remote);
-	adev->ualink.remote = NULL;
 	dev_dbg(adev->dev, "ualink sw init failed %d\n", r);
 	return r;
 }
@@ -6366,21 +6372,16 @@ int amdgpu_ualink_sw_init(struct amdgpu_device *adev)
  * @adev: amdgpu device pointer
  *
  * Cleans up all UALink software resources in reverse order of initialization:
- * remote peer connections, SDMA entities, NPA mappings, and metadata.
+ * remote peer connections, SDMA entities, NPA mappings.
  */
 void amdgpu_ualink_sw_fini(struct amdgpu_device *adev)
 {
-	dev_dbg(adev->dev, "halt accel_id %u addr_mode %d\n", ualink_accel_id(adev),
+	dev_dbg(adev->dev, "accel_id %u addr_mode %d\n", ualink_accel_id(adev),
 		ualink_addr_mode(adev));
 
-	adev->ualink.msg_ctl->send_halt(adev);
-
 	amdgpu_ualink_peer_remote_fini(adev);
 	amdgpu_ualink_sdma_entities_fini(adev);
 	amdgpu_ualink_metadata_npa_unmapping(adev);
-	amdgpu_ualink_metadata_fini(adev);
-	kfree(adev->ualink.remote);
-	adev->ualink.remote = NULL;
 }
 
 /* byte offset of the local interrupt ring a remote GPU writes to */
-- 
2.50.1

