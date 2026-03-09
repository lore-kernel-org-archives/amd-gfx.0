Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9A9F417E0
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2026 14:26:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DD7C10E503;
	Mon,  9 Mar 2026 14:26:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t2tMo1AI";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013030.outbound.protection.outlook.com
 [40.107.201.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B84C10E503
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2026 14:26:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z5LLHTFVQIz1TmDsN46DyihFhMsmwqLazE7vBY42orn5vBKjEMpnS0ZbmcVdGgItyoClMqVDMdr2Cf226zFQ8R2YkgNOiziMgeV85FkY0hQHb20ZHQeTQQhr31mZe9l0LqcCMLwXFal2WtyMV1eUilmALk5a9pAT5ko4iG4inmDPNAG7dQ99ZvzU4tx9JWQa3agfy9JDlT+3/l3EzLeZskfpjiAF3zxLTzOe/mk3/8GEPNX5SETAQsiIjObBeG2DEknUtfqJYLRJ3ZyHVholu5r4DNPJLCIfe06CCNBqkhwxTd+ezlkSTPJYN0e9O2QwdgRyVgIFxy4I3J2XvDH8KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvmOsv+bdZCxLKdv8Gtv9ghgvCgDt0WeWBiXq7oIBUw=;
 b=s/gd3UBaax0HgXwqc3QILZssk1RthzEJ6av9BfXj4mY6pjPWdZLudiUVxEPrmQIKckKIf/J8QypYNVJuj8jcfeqP0Do36kteFjCYhP6892Tc93mOWBk7Y11rwtAXhPxhJN0gOsEPntuaJlbnyvAdcN9T0K5C8kCOxOyIBjOsR5yPRJvU9Uxa2JQ13eLgdRJneyd1VrSHpikm7lRxH60UgaxH4wQvQuaH1uhtAyp/r+xFM8fdvLKB7NFkU9yyQOjhkwIgGjjBOTATSNY/58fZOTvyfwt0yumWwdkZgT2d6nzi4sniPKBvuJjDNcjXj9RbSMzhKXtCLDEGEuDUiw839Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvmOsv+bdZCxLKdv8Gtv9ghgvCgDt0WeWBiXq7oIBUw=;
 b=t2tMo1AIu8fKcqKu9KmKZeL0w/JKg4+RvNT57pGfPGQGq71FcB+mKQocwM0XsllcD85HyAkKujFIIzk3cqwXhp24SOxfRaSenjV2OQHHfsjs7ZHOj2xlPZsoCMAQF3fmJVkuRkZuoxw/ovFpNChlB4v9gE6/MOQ+hZbq+Ic9L+Q=
Received: from SN1PR12CA0076.namprd12.prod.outlook.com (2603:10b6:802:20::47)
 by MW6PR12MB8950.namprd12.prod.outlook.com (2603:10b6:303:24a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.6; Mon, 9 Mar
 2026 14:26:43 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:802:20:cafe::c5) by SN1PR12CA0076.outlook.office365.com
 (2603:10b6:802:20::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Mon,
 9 Mar 2026 14:26:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 14:26:43 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Mar
 2026 09:26:38 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 9 Mar 2026 09:26:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>, Felix Kuehling
 <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdkfd: Don't expect signal mailbox update
Date: Mon, 9 Mar 2026 10:26:21 -0400
Message-ID: <20260309142621.2843831-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309142621.2843831-1-alexander.deucher@amd.com>
References: <20260309142621.2843831-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|MW6PR12MB8950:EE_
X-MS-Office365-Filtering-Correlation-Id: e7421b67-df51-4b5f-3ecf-08de7de7e312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014; 
X-Microsoft-Antispam-Message-Info: O3nWcBYB6pf2DmPtyKj/0GBdCOCaIHl3tqC5LdlVC8RlQszofsh8ABdpjg2ddSg7JjSDpwgRFs+ICMfgcsu2J3v8d9dKmooKXBBNADOecYYeIyuWxznWykqfFoeAMKneTV0M03TWaGawE1s5AJr4d5DwTCLM+Puu77E0F8gT+gEXI2OYd3fRqTiqeiqY0jeo4mqYpBZRh7/NWq+RknG1jFUqtz8WBz0bHxsYCVpvDt7nluEfWJwdFH8OebPApNDkWdNzocQYb9m596urZwxxwqcJbvE46xL+W11fIrLuJpuJGS6HMxYRTDYmiSzHEOYRW54M+645d4bkniiZ5KFy8dUVUC/tN0WyhB0QZUq9PITAxEnNigkcUpm5rcVFBsv5fbvT6UyoCGL4DHNWbTpkuPbRsRiBJbpWiWNQumFWQMSxsubX2QFu/4yMFwuTFDU5rfX+m65Y4Cf3rx/aPEKZZVoxangEEvT2yBvU39U0pyQ1Z4YGzPQ9luCCqv0OI8eaowntpHyKRlicVuzE3U2Xj6P3cnOAqBcmR5YYl3rnHrblUTEVgtxY/3Y/r7DK0esTUzj1ev+2DTa1nizgymgjQc7H4mHHMIXfOQpfpY9WkZZyMJZPN0R8R7iq0DX6MIsIwtetp6Ij8q5DbGkp3XnZAGCkiV05DeNYmutJHZAcPpk3k2f6rIAPIRYwKrespNgH9BkkogZyInZpV2rZ1npCUW+VFrhsmSFjmOjBHqdOlyf4ah1sLeticv1oKE6D6GSFctXNB66r+7Tu0bhs85QqPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kq7XQyTyCbpQxN3iRAD+PXpKKvwUQ93go8xM8Xpq5k5QdIPhrZhxWu7eIcWctmdsP0rrNUjkcZbZ04HwapgI4fEucBCEp0TL9X+yuR+NQjabvB3dE5Zjz1zi8uUwvhYlEw0HjkL7kOn8F/r0iav21Vbaj/CzyM7W5Vme+2VEriOuS/gIZcq8X+H2AmuY+QP2Tk0KUD1z4Og1qO6u+hNKh9aOZ5O7uRdmYr8an2RqsuecPl9zfSLnaD7vWOLt0R0ZaDHGtXqpWoeCxwN5HDNwsODOaqz79jcQu2QiiQ7fj7mbxreqLKeUKwU/eIY6E/A6bBvjzrAuh368CGjFAZocIppqWu7Cs1SpsMq+yx/3CPtTVMxJeP7WwaRXHJ/ASSBnCVR8po3mFfNk9Z3tYwGCHyppaSoPHZwzAKrXJXaJ1m3ju3YGrTDckFTo0uBdMCbV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 14:26:43.3051 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7421b67-df51-4b5f-3ecf-08de7de7e312
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8950
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

From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

GFX12.1 CP to improve performance has removed updating event_id into
signal mailbox. In future, this optimization can be extended to older
ASICs. Update driver code to handle this case.

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c   |  6 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c            | 12 ++++++++----
 drivers/gpu/drm/amd/amdkfd/kfd_events.h            |  3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c   |  6 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c   |  6 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v12_1.c |  6 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c    |  6 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |  2 +-
 8 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
index 73acbe0b7c212..b799c70f5742a 100644
--- a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
+++ b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
@@ -97,11 +97,11 @@ static void cik_event_interrupt_wq(struct kfd_node *dev,
 		return;
 
 	if (ihre->source_id == CIK_INTSRC_CP_END_OF_PIPE)
-		kfd_signal_event_interrupt(pasid, context_id, 28);
+		kfd_signal_event_interrupt(pasid, context_id, 28, true);
 	else if (ihre->source_id == CIK_INTSRC_SDMA_TRAP)
-		kfd_signal_event_interrupt(pasid, context_id, 28);
+		kfd_signal_event_interrupt(pasid, context_id, 28, true);
 	else if (ihre->source_id == CIK_INTSRC_SQ_INTERRUPT_MSG)
-		kfd_signal_event_interrupt(pasid, context_id & 0xff, 8);
+		kfd_signal_event_interrupt(pasid, context_id & 0xff, 8, true);
 	else if (ihre->source_id == CIK_INTSRC_CP_BAD_OPCODE)
 		kfd_signal_hw_exception_event(pasid);
 	else if (ihre->source_id == CIK_INTSRC_GFX_PAGE_INV_FAULT ||
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 13416bff77636..ee70eb4b63193 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -142,6 +142,7 @@ static struct kfd_event *lookup_event_by_id(struct kfd_process *p, uint32_t id)
  * @p:     Pointer to struct kfd_process
  * @id:    ID to look up
  * @bits:  Number of valid bits in @id
+ * @signal_mailbox_updated: flag indicates if FW updates signal mailbox entry
  *
  * Finds the first signaled event with a matching partial ID. If no
  * matching signaled event is found, returns NULL. In that case the
@@ -155,7 +156,8 @@ static struct kfd_event *lookup_event_by_id(struct kfd_process *p, uint32_t id)
  * driver.
  */
 static struct kfd_event *lookup_signaled_event_by_partial_id(
-	struct kfd_process *p, uint32_t id, uint32_t bits)
+	struct kfd_process *p, uint32_t id, uint32_t bits,
+	bool signal_mailbox_updated)
 {
 	struct kfd_event *ev;
 
@@ -166,7 +168,8 @@ static struct kfd_event *lookup_signaled_event_by_partial_id(
 	 * and we only need a single lookup.
 	 */
 	if (bits > 31 || (1U << bits) >= KFD_SIGNAL_EVENT_LIMIT) {
-		if (page_slots(p->signal_page)[id] == UNSIGNALED_EVENT_SLOT)
+		if (signal_mailbox_updated &&
+		    page_slots(p->signal_page)[id] == UNSIGNALED_EVENT_SLOT)
 			return NULL;
 
 		return idr_find(&p->event_idr, id);
@@ -724,7 +727,7 @@ static void set_event_from_interrupt(struct kfd_process *p,
 }
 
 void kfd_signal_event_interrupt(u32 pasid, uint32_t partial_id,
-				uint32_t valid_id_bits)
+				uint32_t valid_id_bits, bool signal_mailbox_updated)
 {
 	struct kfd_event *ev = NULL;
 
@@ -742,7 +745,8 @@ void kfd_signal_event_interrupt(u32 pasid, uint32_t partial_id,
 
 	if (valid_id_bits)
 		ev = lookup_signaled_event_by_partial_id(p, partial_id,
-							 valid_id_bits);
+							 valid_id_bits,
+							 signal_mailbox_updated);
 	if (ev) {
 		set_event_from_interrupt(p, ev);
 	} else if (p->signal_page) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_events.h
index 52ccfd397c2b3..1dc21c13833b7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.h
@@ -85,6 +85,7 @@ struct kfd_event {
 #define KFD_EVENT_TYPE_MEMORY 8
 
 extern void kfd_signal_event_interrupt(u32 pasid, uint32_t partial_id,
-				       uint32_t valid_id_bits);
+				       uint32_t valid_id_bits,
+				       bool signal_mailbox_updated);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
index 3e1ad89747979..19406ab92c5bb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
@@ -211,7 +211,7 @@ static void event_interrupt_wq_v10(struct kfd_node *dev,
 	    client_id == SOC15_IH_CLIENTID_SE2SH ||
 	    client_id == SOC15_IH_CLIENTID_SE3SH) {
 		if (source_id == SOC15_INTSRC_CP_END_OF_PIPE)
-			kfd_signal_event_interrupt(pasid, context_id0, 32);
+			kfd_signal_event_interrupt(pasid, context_id0, 32, true);
 		else if (source_id == SOC15_INTSRC_SQ_INTERRUPT_MSG) {
 			encoding = REG_GET_FIELD(context_id1,
 						SQ_INTERRUPT_WORD_WAVE_CTXID1, ENCODING);
@@ -324,7 +324,7 @@ static void event_interrupt_wq_v10(struct kfd_node *dev,
 			default:
 				break;
 			}
-			kfd_signal_event_interrupt(pasid, context_id0 & 0x7fffff, 23);
+			kfd_signal_event_interrupt(pasid, context_id0 & 0x7fffff, 23, true);
 		} else if (source_id == SOC15_INTSRC_CP_BAD_OPCODE &&
 			   KFD_DBG_EC_TYPE_IS_PACKET(KFD_DEBUG_CP_BAD_OP_ECODE(context_id0))) {
 			kfd_set_dbg_ev_from_interrupt(dev, pasid,
@@ -344,7 +344,7 @@ static void event_interrupt_wq_v10(struct kfd_node *dev,
 		   client_id == SOC15_IH_CLIENTID_SDMA6 ||
 		   client_id == SOC15_IH_CLIENTID_SDMA7) {
 		if (source_id == SOC15_INTSRC_SDMA_TRAP) {
-			kfd_signal_event_interrupt(pasid, context_id0 & 0xfffffff, 28);
+			kfd_signal_event_interrupt(pasid, context_id0 & 0xfffffff, 28, true);
 		}
 	} else if (client_id == SOC15_IH_CLIENTID_VMC ||
 		   client_id == SOC15_IH_CLIENTID_VMC1 ||
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
index 2788a52714d10..12d81abed7481 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
@@ -353,7 +353,7 @@ static void event_interrupt_wq_v11(struct kfd_node *dev,
 
 		/* CP */
 		if (source_id == SOC15_INTSRC_CP_END_OF_PIPE)
-			kfd_signal_event_interrupt(pasid, context_id0, 32);
+			kfd_signal_event_interrupt(pasid, context_id0, 32, true);
 		else if (source_id == SOC15_INTSRC_CP_BAD_OPCODE &&
 			 KFD_DBG_EC_TYPE_IS_PACKET(KFD_CTXID0_CP_BAD_OP_ECODE(context_id0))) {
 			u32 doorbell_id = KFD_CTXID0_DOORBELL_ID(context_id0);
@@ -366,7 +366,7 @@ static void event_interrupt_wq_v11(struct kfd_node *dev,
 
 		/* SDMA */
 		else if (source_id == SOC21_INTSRC_SDMA_TRAP)
-			kfd_signal_event_interrupt(pasid, context_id0 & 0xfffffff, 28);
+			kfd_signal_event_interrupt(pasid, context_id0 & 0xfffffff, 28, true);
 		else if (source_id == SOC21_INTSRC_SDMA_ECC) {
 			event_interrupt_poison_consumption_v11(dev, pasid, source_id);
 			return;
@@ -404,7 +404,7 @@ static void event_interrupt_wq_v11(struct kfd_node *dev,
 			default:
 				break;
 			}
-			kfd_signal_event_interrupt(pasid, context_id0 & 0xffffff, 24);
+			kfd_signal_event_interrupt(pasid, context_id0 & 0xffffff, 24, true);
 		}
 
 	} else if (KFD_IRQ_IS_FENCE(client_id, source_id)) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v12_1.c
index 230e57dbcec58..5d8b5aa194da8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v12_1.c
@@ -326,7 +326,7 @@ static void event_interrupt_wq_v12_1(struct kfd_node *node,
 
 		/* CP */
 		if (source_id == SOC15_INTSRC_CP_END_OF_PIPE)
-			kfd_signal_event_interrupt(pasid, context_id0, 32);
+			kfd_signal_event_interrupt(pasid, context_id0, 32, false);
 		else if (source_id == SOC15_INTSRC_CP_BAD_OPCODE &&
 			 KFD_DBG_EC_TYPE_IS_PACKET(KFD_CTXID0_CP_BAD_OP_ECODE(context_id0))) {
 			u32 doorbell_id = KFD_CTXID0_DOORBELL_ID(context_id0);
@@ -339,7 +339,7 @@ static void event_interrupt_wq_v12_1(struct kfd_node *node,
 
 		/* SDMA */
 		else if (source_id == SOC21_INTSRC_SDMA_TRAP)
-			kfd_signal_event_interrupt(pasid, context_id0 & 0xfffffff, 28);
+			kfd_signal_event_interrupt(pasid, context_id0 & 0xfffffff, 28, true);
 		else if (source_id == SOC21_INTSRC_SDMA_ECC) {
 			event_interrupt_poison_consumption_v12_1(node, pasid, source_id);
 			return;
@@ -377,7 +377,7 @@ static void event_interrupt_wq_v12_1(struct kfd_node *node,
 			default:
 				break;
 			}
-			kfd_signal_event_interrupt(pasid, context_id0 & 0xffffff, 24);
+			kfd_signal_event_interrupt(pasid, context_id0 & 0xffffff, 24, true);
 		}
 
 	} else if (KFD_IRQ_IS_FENCE(client_id, source_id)) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index d76fb61869c75..1688d8e595f2f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -379,7 +379,7 @@ static void event_interrupt_wq_v9(struct kfd_node *dev,
 	    client_id == SOC15_IH_CLIENTID_SE2SH ||
 	    client_id == SOC15_IH_CLIENTID_SE3SH) {
 		if (source_id == SOC15_INTSRC_CP_END_OF_PIPE)
-			kfd_signal_event_interrupt(pasid, context_id0, 32);
+			kfd_signal_event_interrupt(pasid, context_id0, 32, true);
 		else if (source_id == SOC15_INTSRC_SQ_INTERRUPT_MSG) {
 			sq_int_data = KFD_CONTEXT_ID_GET_SQ_INT_DATA(context_id0, context_id1);
 			encoding = REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, ENCODING);
@@ -513,7 +513,7 @@ static void event_interrupt_wq_v9(struct kfd_node *dev,
 			default:
 				break;
 			}
-			kfd_signal_event_interrupt(pasid, sq_int_data, 24);
+			kfd_signal_event_interrupt(pasid, sq_int_data, 24, true);
 		} else if (source_id == SOC15_INTSRC_CP_BAD_OPCODE &&
 			   KFD_DBG_EC_TYPE_IS_PACKET(KFD_DEBUG_CP_BAD_OP_ECODE(context_id0))) {
 			kfd_set_dbg_ev_from_interrupt(dev, pasid,
@@ -530,7 +530,7 @@ static void event_interrupt_wq_v9(struct kfd_node *dev,
 		   client_id == SOC15_IH_CLIENTID_SDMA6 ||
 		   client_id == SOC15_IH_CLIENTID_SDMA7) {
 		if (source_id == SOC15_INTSRC_SDMA_TRAP) {
-			kfd_signal_event_interrupt(pasid, context_id0 & 0xfffffff, 28);
+			kfd_signal_event_interrupt(pasid, context_id0 & 0xfffffff, 28, true);
 		} else if (source_id == SOC15_INTSRC_SDMA_ECC) {
 			event_interrupt_poison_consumption_v9(dev, pasid, client_id);
 			return;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 9849b54f54ba0..27e4859e4ad7a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1525,7 +1525,7 @@ int kfd_wait_on_events(struct kfd_process *p,
 		       bool all, uint32_t *user_timeout_ms,
 		       uint32_t *wait_result);
 void kfd_signal_event_interrupt(u32 pasid, uint32_t partial_id,
-				uint32_t valid_id_bits);
+				uint32_t valid_id_bits, bool signal_mailbox_updated);
 void kfd_signal_hw_exception_event(u32 pasid);
 int kfd_set_event(struct kfd_process *p, uint32_t event_id);
 int kfd_reset_event(struct kfd_process *p, uint32_t event_id);
-- 
2.53.0

