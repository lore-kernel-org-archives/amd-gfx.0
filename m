Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FCF7CC6B34
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 15:03:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ABCA10E699;
	Thu, 15 Oct 2026 15:03:37 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012062.outbound.protection.outlook.com
 [40.107.200.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8487810E251
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 15:03:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1OUkeEOAuKqW+6M7rLjBp+8XzRkDOd7jhVlBO6EXjJggtw2LVqSz1ZQXuEM4Ou/XIRiFlqlzeqbJC+3J8e9vXgqUvPfwTqak7fbKQbkb9HLhzyAxLsNwkjvhwtD04/Z03p+ua1FgZvIi7aP29ww9M6FXcXAnH91IHUmcE30TG/4hoX+qwPJ7NxkynTMJh6huwt8gdgzI9r/VdjMCoKuc5RsZqL3NhbllcIIQsgnlFreBxxKssyEXdYBDJ/VuBrSwu1Wjn+4bx74Adk+/aJBF0ZVF4RzfXP1GB2Lg+e15MqduRTJ1ZSZ9ElCjWhSV12zVwyf8W5P2Jo+DC4Tmqs3vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGzwb471XluQnKNlIF1ZV0eabpoz5Gz1LuRPYtTl4EM=;
 b=b7IDOFVMY4SmqJ0U0Moa8RXS4J4DJoWuwyq6eFWTGLkRFCBIJ+ivd9NvBn3F1vrM2TCis7cTjJMYHKdMeAsbMYpeMKYJ4pKgT70Y/drJIwQw7T7i3rvUKko2uXYhDIbYp+Kpp+qi2qAQDcnBy/bXNNDRFEShImuM7O2SUiFLl4nQVWH91nNC/6hedT59WzcC/8n9VdBHuXu2iqWu7WjB2UQGjaqJ7c1cocwm1aAF3h436D0XHFfAHk/Y70u6UoPPozjnI58NxHS7r4aeFVsEAg3sZhcdvhxe8Njpav6RxuxyK0YPPn/V7JpU55py//cpn0RJSB0teOJIluhepeXDuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGzwb471XluQnKNlIF1ZV0eabpoz5Gz1LuRPYtTl4EM=;
 b=GSQxi7RNbE2gVwjd+GvyXwwQueJuC2XLitOuyd96KVsbnmKdM1tTbHojyvzjGuauNyDsdqeb7Br5yhtBKIQX1YknoHVJjBTykIS7PH6LOVge4X6BFB8gO7R3d6GDLwSitVr7mv+mnCVsZzNnIoq4U/khef41j/87C64/7ggZqH4=
Received: from MW4PR04CA0217.namprd04.prod.outlook.com (2603:10b6:303:87::12)
 by SN7PR12MB8769.namprd12.prod.outlook.com (2603:10b6:806:34b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Thu, 15 Oct
 2026 15:02:24 +0000
Received: from CO1PEPF00012E83.namprd03.prod.outlook.com
 (2603:10b6:303:87:cafe::a8) by MW4PR04CA0217.outlook.office365.com
 (2603:10b6:303:87::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 15
 Oct 2026 15:02:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E83.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 15:02:23 +0000
Received: from alysaliu-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 10:02:16 -0500
From: William Palacek <William.Palacek@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>,
 <Kent.Russell@amd.com>, <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH v4] drm/amdkfd: discard interrupts during a GPU reset
Date: Thu, 15 Oct 2026 11:02:11 -0400
Message-ID: <20261015150211.454709-1-William.Palacek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E83:EE_|SN7PR12MB8769:EE_
X-MS-Office365-Filtering-Correlation-Id: 2df8ce5b-c6ea-43a5-949d-08df2acd51b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|5023799004|56012099006|11063799006|261009223027099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: EHV3TdYVfPVDTKY5/LXYkBU1QvNirnUdY4KzviVDZxhF4DDbi6hmuyDtrE625iinJue/nZ9uRpkUaF0F3N1clO6aJOjMXw8WWyWnE/D4+PwMfY2Z1JaraV6xpRF5XIdeoZOOn0DLxfcwHRW92Rb+deBuGe8nXCd1KcHaMDbQtoM3l2PNjJzcfK90eCjefy2SBQ675CR+fyvLXRAR5NLOnT83kgFZqTtLJkPRX+X6bGQNFdh4haeL0JhjeCNtFfloYxBq74iy6jbmySeDbK61Ia99z5a8rGRp3h12bD1oijxswQjsUl4g5dVhGzjd8tYNhDDt+JN312nLZaZrFzuW+K27VKTg6WzZsDa8Js4UOE9cw28t2LEfJak/eGb6A/H2e7arZYcgLapxFIEsrb3WJCCYinwFrrNoGgvGkrqq3JpDrmTgVUuXMZhec5YGG0UwupvBvgBlR221ss3IdHZH69ZTC2E5hogHvhQ42hAbJ2+6e1KcIY9fUOFZAMX8c8v1Cyxo+jczrRQ0zSSKi6Cvnqaxuxufqmy+6fK9Q/IgteJaypA1qR7HsbVz33mLpSKKKaN50o7QRj/GOTrKASwfl1khHTczschCpKjRserBc3RFSm3URyx9B1VH77YtZMXVNiZvUj7yyqNpjobEwu3Wl9XLqYfn3Xdho7n/sOdxeMF4XFU5p+tx3EOz514S52hcVNZyQk5W4Ng7uJ0vlS7PFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(5023799004)(56012099006)(11063799006)(261009223027099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mbzPeXtOwT55nTHRALjOhrBolRQMC3yd3j4lGqOwLHsV4vFyhpxtqHzOjcKOgeViTxjh9j8QG3DKT84DtDsR5oEdYcEGcozLBa0BCDO/CUxuMfPRRP+bGMKynIx4dahrg7IMlGnyBk65HZrpm6bn0kEDYMKwk2bE7vmzAVy6ZbceLxCqOGyfnLyQ0CHQG2WiOwJX8aL2GcWrlmIPTkX1FMoR56IOzMOJLo7vhzlFKrDFX78h5qDQc1L4/f/+73X1QOV5m6A35g2UfgzpiZLaWgDdkXFCa1uWp6zpsUmE43UVyLIkNbZh1Bp/My4YxeItP6qi4mwowpzxjGAAIXTqGGgnOCRrAurzdHUzSepZF9h5jyL3EOGTJC9/7zwvuV2/gc9u3EQojSFq/xySTyQUxonvJM89NoWHQKoY2Wi6EwmdQ7BZfDi0pYdzodzEl/wf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 15:02:23.6394 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df8ce5b-c6ea-43a5-949d-08df2acd51b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E83.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8769
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

kgd2kfd_interrupt() only checks init_complete and the per-node
interrupts_active flag, and interrupts_active is cleared only in
kfd_interrupt_exit(). During a GPU reset KFD therefore keeps queueing
IH entries for its interrupt worker, and the worker processes them
together with entries queued just before the reset started. These
entries describe state that the reset is discarding, and processing
them can act on queues and processes that are being torn down.

Discard KFD IH entries while the reset domain is held, using the
existing amdgpu_in_reset() check:

- kgd2kfd_interrupt() drops new entries;
- the interrupt worker discards entries it dequeues;
- kgd2kfd_pre_reset() flushes the interrupt workqueue after suspending
  KFD, so entries queued before the reset are discarded before the
  ASIC is reset, rather than whenever the worker next runs.

Nothing is drained through the GPU, which may not respond at this point.

The only entry KFD waits for is the drain fence that
kfd_process_drain_interrupts() sends when a debugger disables traps or
detaches. If that happens during a reset, the fence is discarded and
the wait ends after AMDGPU_FENCE_JIFFIES_TIMEOUT (HZ/2) with a
ratelimited warning.

Suggested-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: William Palacek <William.Palacek@amd.com>
---
v4: new approach, replaces "drm/amdgpu: preempt KFD queues before taking
    the reset domain lock" (v1-v3)
    - Drop the queue preemption and every reset-ordering change: queues
      cannot be unmapped once a reset has started (Christian)
    - Ignore KFD interrupts while amdgpu_in_reset() (Felix)
    - Discard IH entries already queued when the reset starts: the worker
      drops them and kgd2kfd_pre_reset() flushes the KFD IH workqueue
      (Felix: drain or discard)
    - Drop the v3 amdgpu_amdkfd_pre_reset() device-list change and the
      unmap_queues_cpsch() -EIO path along with the approach
    - Retitle to drm/amdkfd, the change is KFD-only
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 7 +++++++
 drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c | 6 ++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index bb4c6695f3cf9..ceee52eee7a38 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1019,6 +1019,9 @@ int kgd2kfd_pre_reset(struct kfd_dev *kfd,
 
 	kgd2kfd_suspend(kfd, true);
 
+	/* Reset is in progress, so the worker discards what is still queued */
+	flush_workqueue(kfd->ih_wq);
+
 	for (i = 0; i < kfd->num_nodes; i++)
 		kfd_signal_reset_event(kfd->nodes[i]);
 
@@ -1176,6 +1179,10 @@ void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry)
 	if (!kfd->init_complete)
 		return;
 
+	/* IH entries raised while the ASIC is being reset are stale */
+	if (amdgpu_in_reset(kfd->adev))
+		return;
+
 	if (kfd->device_info.ih_ring_entry_size > sizeof(patched_ihre)) {
 		dev_err_once(kfd_device, "Ring entry too small\n");
 		return;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
index 783c2f5a04e4b..abc0e5c583cee 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
@@ -140,8 +140,10 @@ static void interrupt_wq(struct work_struct *work)
 	unsigned long start_jiffies = jiffies;
 
 	while (dequeue_ih_ring_entry(dev, &ih_ring_entry)) {
-		dev->kfd->device_info.event_interrupt_class->interrupt_wq(dev,
-								ih_ring_entry);
+		/* Discard entries queued before the reset started */
+		if (!amdgpu_in_reset(dev->adev))
+			dev->kfd->device_info.event_interrupt_class->interrupt_wq(dev,
+									ih_ring_entry);
 		kfifo_skip_count(&dev->ih_fifo, dev->kfd->device_info.ih_ring_entry_size);
 
 		if (time_is_before_jiffies(start_jiffies + HZ)) {
-- 
2.43.0

