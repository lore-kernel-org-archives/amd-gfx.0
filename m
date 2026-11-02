Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDD6606FB4A
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 16:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=s/54bS6i
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8937510E646;
	Mon,  2 Nov 2026 16:02:25 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011021.outbound.protection.outlook.com [52.101.57.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A1F610E646
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 16:02:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ui9BOqFPuTOY5jU7C0an0t7w+b0rjzC3jpmAsXhMHL9dO19CHWBeH3G3qCTaW9d8cLV1Krualoo21pgULCs/A5Cg+u6mPfG72PpmIi21pHaD1xxqDiHRSAvh6JL30SjSJhZ5ZLGmwWmyroaScdSvjRXpKSdIGum7lyGeEkYB0LPjrmWVEWsPssRM4xgW5jMssIX09gCZasIrIAUpy4F8zWdisLD61GvvzSJgnDzI8UbRe+q5yNmek/SyHIvqS0tTH0iApJ5ep5po977JQGiGTrF0s6eQ/RaGrmR21+BD+kbAsDa694WH2L7bjLlzVvcQmCEvbJqCdi7dU9RlYhvl0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqhjy5yfNtLRtrti01JdpZl+ta9GmTZKs15YReDjru0=;
 b=M44AV4bSLXp/Uyyo6JAWMMunAoTzOqZKNsG540TA2EoNdoVT3Rjjxqdk16kEaEUgITXMpYydzwXz3OgOYzdx9mXWWOWRqO7IgfIpnHFWyoECXDvGjJ3p25PKjAHEiM0+GX9LtJX40TXmZUkw+OVovRh7h68NS+PTKG6oGQkqfmMB/FcBgzx9mPq15AD0ujlbXUdxy4jfrG7jR3v4Fg8XagPpkYMiJekJezTTnYDGccaYGoVopNjJasfumULYJ8JKi15XJa5ZSPDPf2w8l6Kk4/w/2r2rcaMl0ud0TuCPCAmtUurx8VBTiX7VsgbUIBxI1Ln5/fbqwN+hnydtIi85jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqhjy5yfNtLRtrti01JdpZl+ta9GmTZKs15YReDjru0=;
 b=s/54bS6iIM9Mc+Tan4/mpXKLrFkal+8AerFr62JMiY7W7iLHuotn0U7ostrI1BdhV0I/cm0n50Zc5+gy7ThfV3etWqNBG9UX2EuFwkvwO1u0RtPwHyHxxkC1MAWA+dbo8OZ8l7rFyL2w4MR/a1LA1Nn5zciZ2zrnPV+C58M8cI4=
Received: from BYAPR21CA0015.namprd21.prod.outlook.com (2603:10b6:a03:114::25)
 by LV8PR12MB9644.namprd12.prod.outlook.com (2603:10b6:408:296::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 16:02:15 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a03:114:cafe::6e) by BYAPR21CA0015.outlook.office365.com
 (2603:10b6:a03:114::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.3 via Frontend Transport; Mon, 2
 Nov 2026 16:02:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 16:02:14 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 2 Nov
 2026 10:02:14 -0600
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <philip.yang@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCHv3 5/8] drm/amdgpu: Set up UALink rings and metadata for
 loopback
Date: Mon, 2 Nov 2026 10:47:51 -0500
Message-ID: <20261102160125.2743750-6-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102160125.2743750-1-mukul.joshi@amd.com>
References: <20261102160125.2743750-1-mukul.joshi@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|LV8PR12MB9644:EE_
X-MS-Office365-Filtering-Correlation-Id: 61b6af7a-5f1a-43e8-ea67-08df38faa98a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|10067099003|18002099003|22082099003|261102123227099003|261102130727099003|56012099006|11063799006|261026140227099003|261021121427099003|261022105027099003|261026121527099003|261028144727099003|261009223027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: /k3fPxwJvzD1Aw9eu2EPoiF2Z6oEJ95B8k3528cTdyxFNi6JMfoudr7Ns/S0rEnt4jErRG8F5KcPK0D/e9JjcNDzcGMYRKdTtlBHzd26Bzjyb4KpP+VZ+WkSEiMBZ2fff4Hxac7CrHfetd6hz4QoHW+VLFIsFLp2WACVy7WYNK1aKkP07Wt9m+7uFU/ngVjpQfDX8Vx3auYYs/IHdtTyamgMxNrhmcsmJSYFplpYBorn/3IEo/dqYqsDxuuBXGccxWw6Aenr5UF4e5nwS7ceOhAFVKWdHITvX6sux7VMK6pTgor06kpgXffHrXELVWAIgthUxA/B3uG5UXQYqR7/CLvDXrl2KoQEljM2fHhypSv5Quj7Z2YWDlL+h6IUGPHNnyTJX6gI8B9t0X/Uizb3OwP/gyiqv84cVwozu+c0nL4S2e9OeTgN6N8v2hO6tN28fhWBXVqdqxo5/Xa1o/zVhFpmqN0AFTkEXy4nZ20YZ1XKsGblvxk/omHJUWfa/j4l7UrDbtezlUJP3cNDTddVnYSGzu1E68V/jiVBgfc1RzFzgcM+2zexdFfi/qPfF7gCICtGx/IycZ8DOOH6D6sT73ctnr5/iEVcJrLmf6fqnRLHpTYS4WaNER7ZGGgKQetfIs3EorrQbTmNLWHwpWdvwGMc50hyFiq7SQGMoR8Tra6WocwDey8rrDlsIKFdsn26EbYP1CPy9AVDw0Gk9k/2Wg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(10067099003)(18002099003)(22082099003)(261102123227099003)(261102130727099003)(56012099006)(11063799006)(261026140227099003)(261021121427099003)(261022105027099003)(261026121527099003)(261028144727099003)(261009223027099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nKZtiiT6kxH209P/MM20dzS/lGKU8Q6IhsF7rcC2XF6VgTuSoETTbx2RJlhQJdYX2DBmgk13X0ipHAd9LBKZbmuWZCf967sMVbL8LAdNmWpQ262j9ZoxZTcSCBzOsNMCAVlhoWJ0mrIWluQg1AFPO7uN6UYRk9N45S1a8C1DJFFdVxg/2IkRiZhDZWGzPEQUszV0NY8MHIhH/3iQ+gdg9oktU4CmgEqgA1XsOtNCdo3zcOKwK4KK4YJijzEONXLY7bz7hBlqbGPzwwg6gxtSUPXO7iqulOCTZ7pQNCRSeyzbZ98f5jtaDtJ0BSILYla+0jlIKOf+zWOuLreKxW3xhnwsRUQISbkkfN5A5XAB5j8EhHmmLzyer6VUI30x/4pPR0Ro3HFpBHast+nd+02+qiT5FEHmmAxqJ8NbsitGOxc+oUHHPgTWPZl64nlChsBJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 16:02:14.6212 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b6af7a-5f1a-43e8-ea67-08df38faa98a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9644
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

In UALink loopback mode a single GPU acts as both the exporter and the
importer, and the only path the HW serves is importer -> exporter.
Adjust the per-peer setup accordingly:

- The importer's doorbell reaches the MP nHT stamped with the GPU ID of
  the exporter, and the FW looks up the metadata entry by that ID. So
  publish the importer's rings and tail pointers in metadata[exporter].

- Skip the ring pointer resync. Both ends of every ring are on this
  GPU, so there is no remote peer that can reboot and leave the
  pointers stale.

- Do not take the local dma-buf shortcut on import. It would bypass
  the NPA path that loopback is meant to exercise.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
v2->v3:
- Move updating src_accel_id in peer_remote_init and fini to patch 1.

 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 54 ++++++++++++++++------
 1 file changed, 41 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 8558dc1a9e84..74bc8a907f5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -3976,7 +3976,13 @@ int amdgpu_ualink_import_handle(struct drm_device *dev,
 		return -EINVAL;
 	}
 
-	if (amdgpu_ualink_is_local_accel(adev, remote_acc_id))
+	/* In loopback mode the exporter and importer are the same GPU, but the
+	 * import must still go through the full cross-domain NPA path (the
+	 * dma_buf shortcut in amdgpu_ualink_local_import() bypasses NPA). Only
+	 * take the local shortcut for genuine same-pod local accelerators.
+	 */
+	if (!adev->ualink.loopback.enabled &&
+	    amdgpu_ualink_is_local_accel(adev, remote_acc_id))
 		return amdgpu_ualink_local_import(adev, remote_acc_id,
 						  &handle, fd_out);
 
@@ -5452,11 +5458,28 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
 		wptr_gpu_addr = remote->rb_gpu_addr + rb_size * ualink_exp_accel_id(adev);
 
 	for_each_set_bit(accel_id, remote->active_accel_bits, AMDGPU_UALINK_ACCEL_MAX) {
+		struct amdgpu_ualink_metadata *md;
+
 		dev_dbg(adev->dev, "init for accel_id %u\n", accel_id);
 
 		if (accel_id == ualink_exp_accel_id(adev))
 			continue;
 
+		/* In loopback the single MP nHT services the exporter half:
+		 * the only messages delivered over HW are importer -> exporter
+		 * (source = importer accel_id), while the exporter -> importer
+		 * direction is emulated in SW and never reaches the MP nHT.
+		 *
+		 * The importer's doorbell reaches the MP nHT stamped with the
+		 * GPU ID of the single physical station, the exporter, so the
+		 * FW looks up metadata[exporter]. Publish the importer's rings
+		 * and tail pointers in that entry.
+		 */
+		if (adev->ualink.loopback.enabled)
+			md = &metadata[ualink_exp_accel_id(adev)];
+		else
+			md = &metadata[accel_id];
+
 		rb_gpu_addr = remote->rb_gpu_addr + rb_size * accel_id;
 
 		if (ualink_addr_mode(adev) == AMDGPU_UALINK_ADDR_MODE_SOURCE_IDENT) {
@@ -5464,27 +5487,26 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
 			wptr_gpu_addr += wptr_size * accel_id;
 		}
 
-		metadata[accel_id].header = AMDGPU_UALINK_METADATA_HEADER;
-		metadata[accel_id].rb_size = fls(AMDGPU_UALINK_RB_SIZE / 64) - 1;
+		md->header = AMDGPU_UALINK_METADATA_HEADER;
+		md->rb_size = fls(AMDGPU_UALINK_RB_SIZE / 64) - 1;
 
 		/*
 		 * remote shootdown type is 0, remote command type is 1
 		 * with 2MB ring buffer mapping, remote shootdown ring NPA is before interrupt
 		 */
-		metadata[accel_id].ri_rb = rb_gpu_addr + AMDGPU_UALINK_RB_SIZE;
-		metadata[accel_id].tlb_inv_rb = rb_gpu_addr;
+		md->ri_rb = rb_gpu_addr + AMDGPU_UALINK_RB_SIZE;
+		md->tlb_inv_rb = rb_gpu_addr;
 
-		metadata[accel_id].tailptr_ri = wptr_gpu_addr +
-						ualink_wptr_offset(adev, accel_id);
-		metadata[accel_id].tailptr_tlb_inv = wptr_gpu_addr +
-						     ualink_tlb_wptr_offset(adev, accel_id);
+		md->tailptr_ri = wptr_gpu_addr + ualink_wptr_offset(adev, accel_id);
+		md->tailptr_tlb_inv = wptr_gpu_addr +
+				      ualink_tlb_wptr_offset(adev, accel_id);
 
-		dev_dbg(adev->dev, "init from accel_id %u to accel_id %u, rb_size 0x%x\n",
-			accel_id, ualink_exp_accel_id(adev), metadata[accel_id].rb_size);
+		dev_dbg(adev->dev, "init from accel_id %u to accel_id %u, metadata entry %td, rb_size 0x%x\n",
+			accel_id, ualink_exp_accel_id(adev), md - metadata, md->rb_size);
 		dev_dbg(adev->dev, "rb 0x%llx tlb rb 0x%llx\n",
-			metadata[accel_id].ri_rb, metadata[accel_id].tlb_inv_rb);
+			md->ri_rb, md->tlb_inv_rb);
 		dev_dbg(adev->dev, "rb wptr at 0x%llx tlb wptr at 0x%llx\n",
-			metadata[accel_id].tailptr_ri, metadata[accel_id].tailptr_tlb_inv);
+			md->tailptr_ri, md->tailptr_tlb_inv);
 	}
 
 	r = adev->ualink.msg_ctl->send_metadata(adev,
@@ -6069,6 +6091,12 @@ static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
 	u64 int_wptr, tlb_wptr;
 	int r;
 
+	/* UALink loopback: both ends of every ring live on this GPU, so there
+	 * is no remote peer that can reboot and leave the pointers stale.
+	 */
+	if (adev->ualink.loopback.enabled)
+		return 0;
+
 	/* ring->wptr and ring->rptr are owned by the send path. */
 	guard(mutex)(&peer->lock);
 
-- 
2.56.0

