Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC96C98304
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 21:25:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DD3D10F1D1;
	Wed, 23 Sep 2026 21:25:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RktrCBGf";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010042.outbound.protection.outlook.com
 [52.101.193.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A6DF10F1C7
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 21:25:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKDRoSJKnRE05iVaer7aR6vBa+sfYfgHdARddYAW9ealVMz/+ZZRYT+/7Gk2HHRYRYGPK9xtD7eZnbdaX5+PzDsm8ZiPcWrhuI9+euzbL1dO79cJ/P1c4PXtZdFA4sGRnVd/WJF6yny3YBM1LtlLtFCDy6imHGIPuZdBUUxPDnU8l7YTtsujGgRrgE8uGxtr/ovm/GUK9yWB7c0ELfjVFUahha/JOsF9jrSnzJCu8YkQkXyIW1NfYZWk96ewPqFRD+0gcQAgKEwhPnDUhceUXSi11hwGAsz74z0B4VbyW9DvRAkCf9c4sv2uzW5rhbH0Fo8UsKLJIZ947yKB0FfzQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGrLYNbvjs0TKUiTaSKQLdtTgzgeIAQX+2eGDNRszXU=;
 b=JpfmrIwQhWnqZMC/Al3oZgSz1VzC1Yeu83gcaH5U3ItN8AAoamYa2+wkNa6B04DJU52eU3XeF0AQDH+N4k5x59NDXF/3OfC//pm4+wNvcHEGHaMkim8YTzuPOmM1JoFJe95g1FpVBxva+s/Vm3dOXUG4dFTOItEAP7OAhc+xFpR4XCmtxF1B2v4gMX+8x72xzm5iyYEl1ai/78uvhAsyD4bccuJN1cbQoKeAfgXeOBdw+MOHUzDZEYss8bvwpB6HS6hbsmrDhvf28ve22/Xa7xeBRiPK6OcxPUh8cDafGfpQu5nkp3JJkqFfmm2NiUKXfOpgpUSxKSAboJRQsZ2yuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGrLYNbvjs0TKUiTaSKQLdtTgzgeIAQX+2eGDNRszXU=;
 b=RktrCBGfoHNGyzKbdyK5uy/tIweV841R9b9iAA8cj6VBfKXmBz8GFPwSvhRKA1S7EsShOMoOsOIzJJxQdzABMn8owztTxiFYuvCcRkqBwo2+T8Uze56Uqj3dVv8J4XYukiwUEEd1Uk16fCigzhY2B8wOx49yf+LbhTDOaTcUako=
Received: from BY1P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::12)
 by CY5PR12MB6057.namprd12.prod.outlook.com (2603:10b6:930:2e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 21:25:47 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::95) by BY1P220CA0010.outlook.office365.com
 (2603:10b6:a03:59d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.17 via Frontend Transport; Wed,
 23 Sep 2026 21:25:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 21:25:46 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 16:25:43 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <philip.yang@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCHv2 4/5] drm/amdgpu: re-check connection state before sending
 NPA-REVOKE
Date: Wed, 23 Sep 2026 17:20:02 -0400
Message-ID: <20260923212515.1420047-4-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923212515.1420047-1-mukul.joshi@amd.com>
References: <20260923212515.1420047-1-mukul.joshi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|CY5PR12MB6057:EE_
X-MS-Office365-Filtering-Correlation-Id: 9218233d-ac31-4c8a-a497-08df19b93b7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|22082099003|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 4pKub/gq53Ff34ywmlGq2b5amDE5A2c8/fDxRP98mWq+OQVeLSSbF4i8jcd/fjF6fFkMtR2rELwm/35AE3smEQoz0PhyTYrUL1bk4j4eap2i6qaaxS/cnT7ZCaPhpsnHZ5rzhtWoFFc9t3ZjVaQSsplzWrB/04d86DwxhzeCjOToduF65A5KDi6bO7epZgSZiDz042bwmhNgSXswoUVvyIp69ytfPAFMdMOsMSc1KOTj04HSu7Ewa9WcGjRkqlS7YJycz8HPYWePndFPceKB/Sr79WponioVXhfGEMZEUxwOaKuW5c075lKUUomhcvUPmwjSzZVB9kWZsQTvf1JIaRNW4kfcgV8WCJF3J2zI+9u9bPTv27CVuR45dCEJZkkmpyZJHJKirqAl0B3M6goN3hKcxGoesBqTm/BEL9kIYf6GAFYkMnPaPYNLOLhxRkgyWBX3qja6b8MMRyVxlvM+yei8oJVwPO96jGlXzorXHtEZNUes7u7rydDHmAryZZHewioa2bRsHBf/IAyGnziL/BfhRqL1dZi8Wg82UPtgOYaPqFksGYaOTShgHmcCJH5AIRdF6McXxltEZBCIJKtaoLJ09efUFLPi3qvFNiBUcazCnk8DkYoLcuTDcj2ptXwv6AFA5rzbP+T8uNaQN5ARxkZ9FlXBKFkZv3xuoTW+1Q223FLrH13dUxos8mRxJXcjbjI8WoIWyIxzHfRfeV775A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SMJBTYFT9tILBRAvStiTj304GwpTIAF6XJDJmsCfNbZg3BCr99QSDyomEE1GHXfmlM/bQecSZbEfa6rqaNsvEx5+N6E7f2HO8TANImEv+nDnOjKpn1e8w196T5eEjlU2v7ReMiHtUusVC7Vf76biF6rLQn4ABkYamN0D5lz10cHrWlTd/yNGtlef4gE3o1iWOayEo3MYLF9xBXOlbmO92kJ45ySaTNnHyP4y4G0FT+E1gha9EGkbcGuD6gnlY+qsZwoMex1bzOif1kjFRK9JcTFfVBmsiUnWpHKqlDUlDrEiKtrYnPCVBOeQT5p9UBuUamLBsgmyl03/1WlKygGDREp6ugtViH1CK1MVnRemyPJoEYQht/yhHOp7sJNqhmZH+ZkNWRkU1p4LgjNroryBjZDvtZAZVPd4L/yQw2lwC+7maeAMr6dNoxUfNpKYWLEL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 21:25:46.6435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9218233d-ac31-4c8a-a497-08df19b93b7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6057
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

The export cleanup worker checks amdgpu_ualink_check_conn_ready() once
when building npa_release_bitmap, but not again in the send loop. Cleanup
workers run concurrently on the unbounded NPA WQ (one per exported
handle), so when a peer's egress dies many workers have already seeded
npa_release_bitmap from a connection that was still ESTABLISHED and all
issue an LSDMA copy to the dead peer, flooding the log with repeated
NPA-REVOKE send failures.

Re-check the connection immediately before each send, as the tlb
shootdown, force_retry_rpcs and unmap_all_npa_addr loops already do, so
once the first worker marks a peer NOT_READY the rest skip it. With the
re-check in place, seed npa_release_bitmap with a single bitmap_copy() of
importers_bitmap instead of a separate build loop; peers that fail the
re-check or the send are dropped from the bitmap in the send loop.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
v1->v2:
- We were using 2 for loops, once for building the npa_release_bitmap,
  and another for sending the NPA-REVOKEs. 
- Replace it by using a single loop instead.

 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 31 +++++++++++++---------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 39b7cc8bc1c5..f6ad64be4349 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -2936,26 +2936,34 @@ static void amdgpu_ualink_exp_cleanup_worker(struct work_struct *work)
 	amdgpu_bo_unref(&bo);
 	exp_xa_node->bo = NULL;
 
-	/* Build the full npa_release_bitmap before sending any NPA-REVOKE. */
+	/* Seed npa_release_bitmap with all importers before any NPA-REVOKE, so
+	 * the release IRQ only sees it empty once every responder has replied.
+	 * Dead peers are dropped from it in the send loop below.
+	 */
+	bitmap_copy(exp_xa_node->npa_release_bitmap,
+		    exp_xa_node->importers_bitmap, AMDGPU_UALINK_ACCEL_MAX);
+
+	/* Send NPA-REVOKE to all importers which have imported this memory.
+	 * On send failure clear the bit (no response will arrive) and mark the
+	 * connection NOT_READY so other cleanups skip this unreachable peer.
+	 */
 	for_each_set_bit(remote_acc_id, exp_xa_node->importers_bitmap,
 				 AMDGPU_UALINK_ACCEL_MAX) {
 		imp_entry = &exp_xa_node->importer_entries[remote_acc_id];
+
+		/* Re-check the connection right before the send: concurrent
+		 * cleanup workers all seed the bitmap while the peer is still
+		 * ESTABLISHED, so once its egress dies and the first worker
+		 * marks it NOT_READY, this skips the rest instead of flooding
+		 * the log with failed LSDMA sends to the same dead peer.
+		 */
 		if (!amdgpu_ualink_check_conn_ready(adev, remote_acc_id,
 					imp_entry->generation_count)) {
 			clear_bit(remote_acc_id,
-				  exp_xa_node->importers_bitmap);
+				  exp_xa_node->npa_release_bitmap);
 			continue;
 		}
 
-		set_bit(remote_acc_id, exp_xa_node->npa_release_bitmap);
-	}
-
-	/* Send NPA-REVOKE to all importers which have imported this memory.
-	 * On send failure clear the bit (no response will arrive) and mark the
-	 * connection NOT_READY so other cleanups skip this unreachable peer.
-	 */
-	for_each_set_bit(remote_acc_id, exp_xa_node->importers_bitmap,
-				 AMDGPU_UALINK_ACCEL_MAX) {
 		dev_dbg(adev->dev,
 			"EXP-CLEANUP: Sending NPA-REVOKE to remote:%u\n",
 			remote_acc_id);
@@ -2966,7 +2974,6 @@ static void amdgpu_ualink_exp_cleanup_worker(struct work_struct *work)
 				remote_acc_id);
 			clear_bit(remote_acc_id, exp_xa_node->npa_release_bitmap);
 
-			imp_entry = &exp_xa_node->importer_entries[remote_acc_id];
 			amdgpu_ualink_handle_connection_reset(adev, remote_acc_id,
 						AMDGPU_UALINK_CONN_NOT_READY,
 						imp_entry->generation_count);
-- 
2.55.0

