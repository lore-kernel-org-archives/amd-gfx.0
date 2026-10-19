Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E314CCF2DA
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 06:49:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E452F10E7C6;
	Mon, 19 Oct 2026 06:49:20 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013044.outbound.protection.outlook.com
 [40.107.201.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6035D10E7C6
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 06:49:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JbCXKTCk8hiRaW963qsgtOzJAKbMk3IaVwQFajN7sqG0lg44i8b+0D+KpvmU4vU9ldLLG6Uajqs+S9C27hG3yXK60bYR6HQfCx89yJT8h4QkS8gPiZgrj2YQ7bJ9ZdjWX+NUvdlG2oSVCRUpbkAIWBQf/kNsYiGRezlce9PxluR0ns57iUlPqUX5smzDIotaW71OujPXS1KEZdOxsIpupUrp0DCXhdFYEcecHzmPCSWBPcxZFn799OQlmLUcAoxSDtT9++obKvlB2DoE5wI6YuZakooGIgxEzlwFzsjuDdjU6NQWCm+k2O8WRb4UWVOdHypGtISqa+jxKcHIq3+/Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12nrlpHNFLiAL/5GHektMOYAu3nUhlgVLSkZVNIWmlY=;
 b=GRyFHa9AMzGVmli3OF832UZZ/khujGgdGxf8ywcd5dQWq7yWOV8gOvkUW7WEGSMbZq5b8nGJTQP8ZSNS7uNbGMA+JtcDdA2fQ/0Y0LKVrtopvu0yRKt8wxvqUm/VfVQo8c6r0kuLZvkAUvWECqCjwGa5pTqdH1BotRVj11PToopyq0MRWee+Fb0TKos2S5ctnUi/PI7HKXatx23GKYqUpx528RnfvrXDjg8Qt42Z/CEp1LWSM5kGctkRkUyBNa070XQntG97W7enJpwhmMhTANEe7HQrHoTDrepr4Ajo0ojyb2ZBS9fkTe/30E2PfV5+/kNQ1H9DIEJRmrolo9sFIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12nrlpHNFLiAL/5GHektMOYAu3nUhlgVLSkZVNIWmlY=;
 b=S+iHLYkQTaI5uL7dJNliXN89pGw5MGwgcg69kwrV4GLJuptRzyUhg00ikAj2X8CGWg19ROieRf88Tg35bJ7ESa0807ohZlmbvs8E/o2b5fCTo4eG579nRlPWUrHLXUU7EfZFZ4TdLPjMY+k+4C77pIGLsiHdC1tkxuvvYNpvHL0=
Received: from SJ0PR03CA0345.namprd03.prod.outlook.com (2603:10b6:a03:39c::20)
 by MN0PR12MB6296.namprd12.prod.outlook.com (2603:10b6:208:3d3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 06:49:09 +0000
Received: from EA8PEPF00000007.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::b) by SJ0PR03CA0345.outlook.office365.com
 (2603:10b6:a03:39c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 06:49:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 EA8PEPF00000007.mail.protection.outlook.com (10.167.249.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 06:49:08 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 01:48:58 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Vitaly.Prosyak@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 08/10] drm/amdgpu/userq: wait for GPU reset before mapping or
 unmapping queues
Date: Mon, 19 Oct 2026 14:48:36 +0800
Message-ID: <20261019064838.2577746-8-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019064838.2577746-1-Prike.Liang@amd.com>
References: <20261019064838.2577746-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF00000007:EE_|MN0PR12MB6296:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b6400ce-9281-42fc-67a7-08df2dad1379
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3I934CHyXHujKTO325ADr40s82+lKmZqrQpe/iLDHWWNdzmPpTV/rp8iwzlw8W67VnC7gObgWgE6PKlyBaGaLb9npMDrXBUU8Qjr5Xeru9+0yaFdoB4Hz0VWDqn1oipVUmIn+ufrHtiqhCN85m50XiUUNN2S86LiHAgbdXmXwl2gzveG5y+rlXIKBHbEaBtgr3dP2G5nANqbSgEp5wsCM9Ru/6FNqNUM4tyV8QRofZihH9APq1tka9j0gBlMfjfYEuI4e4/GO1Aux4jDzmxys2TvSaV0RqT97lipaRAhYRbsHgIYJThpbKjdd8tOOt4z2Bn+Lz7M/bKTCU+IvQnuO1syYG/lhE/FzTKYc8iY5hBvB2WLdBIIIigpf6UrXxyg67DhQnNhD5WTHWLuVe4QLHTSXbpzKfwdNLIbszqSt0AzwAhOOUatiR33STxZEx676KGVIryVlbLM4xf3y/9imp5PTSKT+RVBZ9B2PTRAWQoRlFcCGDF8QIXeOWDFniwvdcUTPpj3i0kwMnnkBwIPS3O4yJbWzBlnivTreFPymXhNE4U1SrZZD376vO5BenbZSM0ylfBdklVZmcHX6/OyahQuNjxRg0xPpjyJMo3lgCnUmgfj2QVToKDPQtQ/E7XaC5YuSpJUXBcS9KyNYtM7E2EqdhnHI2Mv/SChTHKsox6SvyZFZHIcQPNdCcMkHx57Vdqe8l96cF97MKyRlj8F7w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bHCPRHlu2P1JOKL4BJtHNNNGX3MCcHz+1VgWFzGcb78v8qQDblcGCTdM4rDfHgkEF6cNu1X7mo4upMSM184w6EtwuyH2mDHWpGYX62q4XZPYPYkWCTLgSqQoq6796L9ioa+0isQgEU9bjtBXM1k2Obsh+HEq3I/aRsRfsdhZgMGxH/8iEgmwfcdj8eYb8G6xq9uPcEPo+BFnk/8KOiWNPtHEIL6ztCtEDvW3eZlUYdUtFb46MhrZysGqs+qgB5gxt3qnUXEaB+iZPNDHNfIxP0Q9hbijNlvHd5EfKXxEcMd+w7fHBHCAxrJhxjm3Kj87PA6tieKV/mkhO03cDX/3dwpsASxgM5+F8RSr/PAeh9l0yxmGV1r317O2I22OsTXJ02U09BYFNUofs9H6n+JibRSV11HpTXxJKleNRFk6Sq6wqYG+rGOW1D+UdEUos5BC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 06:49:08.7872 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b6400ce-9281-42fc-67a7-08df2dad1379
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: EA8PEPF00000007.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6296
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

The user queue map and unmap helpers talk to the MES, but only the
create path holds reset_domain->sem around them. The eviction, restore,
destroy and suspend paths can submit to the MES while a GPU reset is in
progress:

  WARNING: amdgpu_device.c:928 at amdgpu_device_skip_hw_access+0x73/0x90 [amdgpu]
  Workqueue: events amdgpu_eviction_fence_suspend_worker [amdgpu]
  Call Trace:
   amdgpu_mm_wdoorbell64+0x20/0x70 [amdgpu]
   mes_v11_0_ring_set_wptr+0x71/0x80 [amdgpu]
   amdgpu_ring_commit+0x5b/0xa0 [amdgpu]
   mes_v11_0_submit_pkt_and_poll_completion.constprop.0+0x207/0x520 [amdgpu]
   mes_v11_0_remove_hw_queue+0xd9/0x100 [amdgpu]
   mes_userq_unmap+0xc3/0x140 [amdgpu]
   amdgpu_userq_unmap_helper+0x67/0x280 [amdgpu]
   amdgpu_userq_evict+0x52/0xf0 [amdgpu]
   amdgpu_eviction_fence_suspend_worker+0x55/0xe0 [amdgpu]

Take the semaphore for read in the helpers instead, around both the MES
call and the queue state check and update. The reset changes the queue
state from amdgpu_userq_pre_reset()/post_reset(), so every caller now
waits for a running reset and acts on the state it left behind.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index c074b562fbee..96e338fa72e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -362,6 +362,8 @@ static int amdgpu_userq_unmap_helper(struct amdgpu_usermode_queue *queue)
 		adev->userq_funcs[queue->queue_type];
 	int r;
 
+	/* The reset changes the queue state and the MES is unusable meanwhile */
+	guard(rwsem_read)(&adev->reset_domain->sem);
 	if ((queue->state == AMDGPU_USERQ_STATE_MAPPED) ||
 	    (queue->state == AMDGPU_USERQ_STATE_PREEMPTED)) {
 		trace_amdgpu_userq_state_start(queue);
@@ -388,6 +390,8 @@ static int amdgpu_userq_map_helper(struct amdgpu_usermode_queue *queue)
 		adev->userq_funcs[queue->queue_type];
 	int r;
 
+	/* The reset changes the queue state and the MES is unusable meanwhile */
+	guard(rwsem_read)(&adev->reset_domain->sem);
 	if (queue->state == AMDGPU_USERQ_STATE_UNMAPPED) {
 		trace_amdgpu_userq_state_start(queue);
 
@@ -769,12 +773,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	if (!adev->userq_halt_for_enforce_isolation ||
 	    ((queue->queue_type != AMDGPU_HW_IP_GFX) &&
 	     (queue->queue_type != AMDGPU_HW_IP_COMPUTE))) {
-		/* Serialize the map against an in-progress GPU reset (MES is
-		 * unresponsive during recovery), matching amdgpu_userq_detach_doorbell().
-		 */
-		down_read(&adev->reset_domain->sem);
 		r = amdgpu_userq_map_helper(queue);
-		up_read(&adev->reset_domain->sem);
 		if (r) {
 			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
 			trace_amdgpu_userq_create_end(queue, r);
-- 
2.34.1

