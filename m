Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E331CD98F2
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2026 12:24:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02C3010F2C2;
	Thu, 18 Jun 2026 12:24:59 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.217.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9A4510F2C0
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 12:24:55 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 65ICBBWh2794570; Thu, 18 Jun 2026 17:41:11 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 65ICBBbi2794569;
 Thu, 18 Jun 2026 17:41:11 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 2/2] drm/amdkfd: use pasid to drop non KFD irqs in v12 for
 sq intr
Date: Thu, 18 Jun 2026 17:41:09 +0530
Message-Id: <20260618121109.2794537-2-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618121109.2794537-1-sunil.khatri@amd.com>
References: <20260618121109.2794537-1-sunil.khatri@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

With KGD userqueues the VMID's could overlap for userqueues
and KFD queues and due to which SQ interrupts of KGD process
are routed to KFD interrupt handlers.

To avoid Noise of SQ interrupt for KGD user queues use the pasid
id's to identify the non KFD processes and return without any
interrupt processing in WQ.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v12_1.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v12_1.c
index 0da7e1db55c9..e02f63c0c845 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v12_1.c
@@ -296,6 +296,7 @@ static bool event_interrupt_isr_v12_1(struct kfd_node *node,
 static void event_interrupt_wq_v12_1(struct kfd_node *node,
 					const uint32_t *ih_ring_entry)
 {
+	struct kfd_process *p;
 	uint16_t source_id, client_id, ring_id, pasid, vmid;
 	uint32_t context_id0, context_id1;
 	uint8_t sq_int_enc, sq_int_priv, sq_int_errtype;
@@ -310,6 +311,14 @@ static void event_interrupt_wq_v12_1(struct kfd_node *node,
 	context_id0 = SOC15_CONTEXT_ID0_FROM_IH_ENTRY(ih_ring_entry);
 	context_id1 = SOC15_CONTEXT_ID1_FROM_IH_ENTRY(ih_ring_entry);
 
+	if (source_id == SOC15_INTSRC_SQ_INTERRUPT_MSG) {
+		p = kfd_lookup_process_by_pasid(pasid, NULL);
+		if (!p)
+			return;
+
+		kfd_unref_process(p);
+	}
+
 	/* VMC, UTCL2 */
 	if (client_id == SOC21_IH_CLIENTID_VMC ||
 	    client_id == SOC21_IH_CLIENTID_UTCL2) {
-- 
2.34.1

