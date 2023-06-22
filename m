Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D1AAEB64DA
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jun 2023 21:29:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8BEC10E09B;
	Thu, 22 Jun 2023 21:29:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BE3210E09B
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jun 2023 21:29:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0Z633U1paJ85p5KCIcgtEszYG8THuz6WAYRhKhcE0A4XcOKkiyQjcupAeB0hGJQ4YkSbrcTIGjGNkPfLDUx96imtx8IeIsHK0t5W79faTgYHQ8kr+w3v58xHT2kAIfl5rY3wMkAQDRQJf720UJGMz4sSjDyySdg+01SMOFrcZdwa9/W9GuLI6RQBMViQwxoX7/lMWL2S5B8CEsmG7jNVT73VOUeNYhe27oUFXdAHZQl8MulN1sKyeGezMSAXlj55ZkR9Z5ccjsRqQDlkEv/qiYcgdI3nuubszQFGbZxo4Mz3atdR3jcwflDHkFUW3l5OSXA/6c+xOJyNCtBe8y8XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jsj5uAr2hUyJDe7+CcIxb7TLEbBUetmAzyF1tpqGnQU=;
 b=jWkezU0npGnAHK4kz4Egg625yatH5h2jnJi9K7pmEAtAYY92vurEL5UKkvHaRkmgtwbabuHPYG5P+8ylQhu6IiEGOovn9v74Rx5GwbCUE+1Mp8u8XVQtinh1VF/2QRrrEuaxeksLN0FFL7H9Vht99cs/dE7EJeotuFdoAIEtr4r6spS84ssgv+uEdahx2XwKl6Fk2DnK4e3pDcKFTsjUNa5L8IB4Y+MGSM0QqOggLdesZEpqjmSxmp7KUetVcEQhPd8aww7uYHXi86BXk889AFi3VQlAl8uP9Pbw+UZWHBSZXJ80pvZ9NQaainIZ1DlkG8RW1UgznZmN0YOydj3RIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsj5uAr2hUyJDe7+CcIxb7TLEbBUetmAzyF1tpqGnQU=;
 b=aB8WIcRASEbrhnFzOY1X+R493vi3GYsGd9F0VEKwZhLegJI3a5G7ygC7doEZteT1R3G35aaB+tWf+8m0/aV36UKad1kQ0V1ZJY5zEeux1srKW1FEMu6XETDzPsLaqIOkMkNz7CfGY2w0jsUrmNSr2/CYVPVASqKlpQ9sulmkYLg=
Received: from SJ0PR05CA0173.namprd05.prod.outlook.com (2603:10b6:a03:339::28)
 by IA1PR12MB6529.namprd12.prod.outlook.com (2603:10b6:208:3a6::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 21:28:58 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::82) by SJ0PR05CA0173.outlook.office365.com
 (2603:10b6:a03:339::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26 via Frontend
 Transport; Thu, 22 Jun 2023 21:28:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.23 via Frontend Transport; Thu, 22 Jun 2023 21:28:57 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 16:28:55 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdkfd: Update interrupt handling for GFX 9.4.3
Date: Thu, 22 Jun 2023 17:28:42 -0400
Message-ID: <20230622212843.1595336-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|IA1PR12MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f9bf3b7-4101-416b-8910-08db7367afdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5RVQp2lqjkMD+dUusiKheXnve7AVPbbiXcsehjupt3u/a+9jdmcu7nZNaWkytI1IxPO7ejlOUG23xH82kU9hAWWrVHlys13c2oKUWl2b/udWilqWpzNXRq9nWQpigN8LWr9GDahygr9ZYe05T6kHpicg9jMgnEM73jIIkPyLdrfDkRVidSlM4on+JqIqeAdlSJSFB5Tz3eQfCuFGqf3iXkYHby1WxUPj3MLyo0gptJ/kVTMTXfUAXHvVFDHKBcXYhGwW+tBP17z7akJ/zfhxsn5KcF4EMG6xGAIiFYGgiJnxzZEj6iXSvZxk/ZfYTw7nD676p3oA89wkZBHN40fE84dqHxJQ1y+Lbhtfxdz7bh4E49CdB6lKjLwLflZmkVJI4Pof8XDFFCeI4+3R/wmKAf52N6z6lUo3PDOBXHZAD9mzJVeeKhp4n733hYC7y2ay3FP8E1JlaO1gbuIVO1ax60608VctNEOY4Z7wulDfV0G3E+oruso0vw8uVrW39gFWsbatLlGJ8r+c91Ho3dPWLruGHY1nHc4xfHIzgGtcqEFgAdmhk5jcmdeplcr0nRyAaiKbwpfEaqs8dwGnjenHApde4RIYVBuDrY+1EaEQ35DQi+Jx2eeaTM3OL5AfL+uUdwCh7m8VQ5VZDfJjX2TT6w7UBrjHmgkLdTwebI5s59zH2KTznV4pG/HV0E+pLKPPMioJW3H4ZkTGr1ycPkUAxga5lrldagzbAXPE67Lgxz9BkYqTfooM3CF9FcSYvpntvx1bEu/0x7FQLEsdpyWgPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199021)(40470700004)(36840700001)(46966006)(82740400003)(356005)(5660300002)(81166007)(47076005)(1076003)(26005)(83380400001)(336012)(2616005)(186003)(16526019)(36860700001)(44832011)(40480700001)(15650500001)(41300700001)(2906002)(8936002)(6666004)(36756003)(6916009)(70206006)(7696005)(4326008)(478600001)(70586007)(426003)(86362001)(40460700003)(316002)(54906003)(82310400005)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 21:28:57.0786 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f9bf3b7-4101-416b-8910-08db7367afdc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6529
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
Cc: amber.lin@amd.com, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For GFX 9.4.3, interrupt handling needs to be updated for:
- Interrupt cookie will have a NodeId field. Each KFD
  node needs to check the NodeId before processing the
  interrupt.
- For CPX mode, there are additional checks of client ID
  needed to process the interrupt.
- Add NodeId to the process drain interrupt.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 43 ++++++++++++++++++-
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   | 29 +++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  9 ++++
 drivers/gpu/drm/amd/amdkfd/soc15_int.h        |  1 +
 5 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 226d2dd7fa49..0b3dc754e06b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -138,9 +138,12 @@ static void kfd_device_info_set_event_interrupt_class(struct kfd_dev *kfd)
 	case IP_VERSION(9, 4, 0): /* VEGA20 */
 	case IP_VERSION(9, 4, 1): /* ARCTURUS */
 	case IP_VERSION(9, 4, 2): /* ALDEBARAN */
-	case IP_VERSION(9, 4, 3): /* GC 9.4.3 */
 		kfd->device_info.event_interrupt_class = &event_interrupt_class_v9;
 		break;
+	case IP_VERSION(9, 4, 3): /* GC 9.4.3 */
+		kfd->device_info.event_interrupt_class =
+						&event_interrupt_class_v9_4_3;
+		break;
 	case IP_VERSION(10, 3, 1): /* VANGOGH */
 	case IP_VERSION(10, 3, 3): /* YELLOW_CARP */
 	case IP_VERSION(10, 3, 6): /* GC 10.3.6 */
@@ -599,6 +602,41 @@ static void kfd_cleanup_nodes(struct kfd_dev *kfd, unsigned int num_nodes)
 	}
 }
 
+static void kfd_setup_interrupt_bitmap(struct kfd_node *node,
+				       unsigned int kfd_node_idx)
+{
+	struct amdgpu_device *adev = node->adev;
+	uint32_t xcc_mask = node->xcc_mask;
+	uint32_t xcc, mapped_xcc;
+	/*
+	 * Interrupt bitmap is setup for processing interrupts from
+	 * different XCDs and AIDs.
+	 * Interrupt bitmap is defined as follows:
+	 * 1. Bits 0-15 - correspond to the NodeId field.
+	 *    Each bit corresponds to NodeId number. For example, if
+	 *    a KFD node has interrupt bitmap set to 0x7, then this
+	 *    KFD node will process interrupts with NodeId = 0, 1 and 2
+	 *    in the IH cookie.
+	 * 2. Bits 16-31 - unused.
+	 *
+	 * Please note that the kfd_node_idx argument passed to this
+	 * function is not related to NodeId field received in the
+	 * IH cookie.
+	 *
+	 * In CPX mode, a KFD node will process an interrupt if:
+	 * - the Node Id matches the corresponding bit set in
+	 *   Bits 0-15.
+	 * - AND VMID reported in the interrupt lies within the
+	 *   VMID range of the node.
+	 */
+	for_each_inst(xcc, xcc_mask) {
+		mapped_xcc = GET_INST(GC, xcc);
+		node->interrupt_bitmap |= (mapped_xcc % 2 ? 5 : 3) << (4 * (mapped_xcc / 2));
+	}
+	dev_info(kfd_device, "Node: %d, interrupt_bitmap: %x\n", kfd_node_idx,
+							node->interrupt_bitmap);
+}
+
 bool kgd2kfd_device_init(struct kfd_dev *kfd,
 			 const struct kgd2kfd_shared_resources *gpu_resources)
 {
@@ -798,6 +836,9 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 		amdgpu_amdkfd_get_local_mem_info(kfd->adev,
 					&node->local_mem_info, node->xcp);
 
+		if (KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 3))
+			kfd_setup_interrupt_bitmap(node, i);
+
 		/* Initialize the KFD node */
 		if (kfd_init_node(node)) {
 			dev_err(kfd_device, "Error initializing KFD node\n");
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index d5c9f30552e3..f0731a6a5306 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -446,7 +446,36 @@ static void event_interrupt_wq_v9(struct kfd_node *dev,
 	}
 }
 
+static bool event_interrupt_isr_v9_4_3(struct kfd_node *node,
+				const uint32_t *ih_ring_entry,
+				uint32_t *patched_ihre,
+				bool *patched_flag)
+{
+	uint16_t node_id, vmid;
+
+	/*
+	 * For GFX 9.4.3, process the interrupt if:
+	 * - NodeID field in IH entry matches the corresponding bit
+	 *   set in interrupt_bitmap Bits 0-15.
+	 *   OR
+	 * - If partition mode is CPX and interrupt came from
+	 *   Node_id 0,4,8,12, then check if the Bit (16 + client id)
+	 *   is set in interrupt bitmap Bits 16-31.
+	 */
+	node_id = SOC15_NODEID_FROM_IH_ENTRY(ih_ring_entry);
+	vmid = SOC15_VMID_FROM_IH_ENTRY(ih_ring_entry);
+	if (kfd_irq_is_from_node(node, node_id, vmid))
+		return event_interrupt_isr_v9(node, ih_ring_entry,
+					patched_ihre, patched_flag);
+	return false;
+}
+
 const struct kfd_event_interrupt_class event_interrupt_class_v9 = {
 	.interrupt_isr = event_interrupt_isr_v9,
 	.interrupt_wq = event_interrupt_wq_v9,
 };
+
+const struct kfd_event_interrupt_class event_interrupt_class_v9_4_3 = {
+	.interrupt_isr = event_interrupt_isr_v9_4_3,
+	.interrupt_wq = event_interrupt_wq_v9,
+};
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 7364a5d77c6e..d4c9ee3f9953 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1444,6 +1444,7 @@ uint64_t kfd_get_number_elems(struct kfd_dev *kfd);
 /* Events */
 extern const struct kfd_event_interrupt_class event_interrupt_class_cik;
 extern const struct kfd_event_interrupt_class event_interrupt_class_v9;
+extern const struct kfd_event_interrupt_class event_interrupt_class_v9_4_3;
 extern const struct kfd_event_interrupt_class event_interrupt_class_v10;
 extern const struct kfd_event_interrupt_class event_interrupt_class_v11;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index e3a27c31f61d..ba04a4baecf2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -2142,6 +2142,7 @@ void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type)
 int kfd_process_drain_interrupts(struct kfd_process_device *pdd)
 {
 	uint32_t irq_drain_fence[8];
+	uint8_t node_id = 0;
 	int r = 0;
 
 	if (!KFD_IS_SOC15(pdd->dev))
@@ -2154,6 +2155,14 @@ int kfd_process_drain_interrupts(struct kfd_process_device *pdd)
 							KFD_IRQ_FENCE_CLIENTID;
 	irq_drain_fence[3] = pdd->process->pasid;
 
+	/*
+	 * For GFX 9.4.3, send the NodeId also in IH cookie DW[3]
+	 */
+	if (KFD_GC_VERSION(pdd->dev->kfd) == IP_VERSION(9, 4, 3)) {
+		node_id = ffs(pdd->dev->interrupt_bitmap) - 1;
+		irq_drain_fence[3] |= node_id << 16;
+	}
+
 	/* ensure stale irqs scheduled KFD interrupts and send drain fence. */
 	if (amdgpu_amdkfd_send_close_event_drain_irq(pdd->dev->adev,
 						     irq_drain_fence)) {
diff --git a/drivers/gpu/drm/amd/amdkfd/soc15_int.h b/drivers/gpu/drm/amd/amdkfd/soc15_int.h
index e3f3b0b93a59..10138676f27f 100644
--- a/drivers/gpu/drm/amd/amdkfd/soc15_int.h
+++ b/drivers/gpu/drm/amd/amdkfd/soc15_int.h
@@ -40,6 +40,7 @@
 #define SOC15_VMID_FROM_IH_ENTRY(entry) (le32_to_cpu(entry[0]) >> 24 & 0xf)
 #define SOC15_VMID_TYPE_FROM_IH_ENTRY(entry) (le32_to_cpu(entry[0]) >> 31 & 0x1)
 #define SOC15_PASID_FROM_IH_ENTRY(entry) (le32_to_cpu(entry[3]) & 0xffff)
+#define SOC15_NODEID_FROM_IH_ENTRY(entry) (le32_to_cpu(entry[3]) >> 16 & 0xff)
 #define SOC15_CONTEXT_ID0_FROM_IH_ENTRY(entry) (le32_to_cpu(entry[4]))
 #define SOC15_CONTEXT_ID1_FROM_IH_ENTRY(entry) (le32_to_cpu(entry[5]))
 #define SOC15_CONTEXT_ID2_FROM_IH_ENTRY(entry) (le32_to_cpu(entry[6]))
-- 
2.35.1

