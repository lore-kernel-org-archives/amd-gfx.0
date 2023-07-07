Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55852EB64DA
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 14:16:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0516610E59D;
	Fri,  7 Jul 2023 14:16:33 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B73D010E59D
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 14:16:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=igCRSnFYfjIeVl2tA1fPMoh4yM0RX90RaZNky3zGB/85x+ZMIrYIcn7POSuztaeu0Pp9Nk2TAjo5d+DZ6CZ640XPbCM4JD9wFe/zHEx6fNQB3V3wUScVXClqzEg0aGLMROzdnGbXwYXgmMsXkRlBk8YP9NPF19+Msjq0gg+grXIaXMZ/m2Q4f+OYAKXT+qR9XM1+UehlGdRxWkkaREa3U+9kD0b5L90YzyWEUYEbacsD+5VzGsbvuZqRUvBTlUxuNUvOaEbdXVX6orQdwSMsJ59V7AKYXWJHJIj6TX+bC0HQU+tIObZxKzNgme0MVNdjVFmwshnl7L8cXxvykFEEJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SL4p9H5RDxg+ykV7VAlXJfJtR4wZjw+Q+exiq2sr3Vk=;
 b=GoVDb5hJ4473RoWsz+Nv7+xtPNmmktKYTd1VY7Bh6k+XFk4GeUnBknNhSypco/+8MlBkOBRTwQ5qdYpZdiatB7+jJEfKyPX8XO7A7imTEyDaWRjP17uI/IIJ7LZlCrPPkzDPHl8Vs/pDenLIh96FHF6Xc94pZhsRuZH8P6MLcDzeajYy1n+PznRRbYhoFHgk9DetGg4bP9Dbamj2bmhT2WSWqFMCpGxyKfkfuTyxPmpu9g+f4RZlIn01hLsyn6BRjvCUESIQSa+gMhjFng4wCmPYlA1pz14QGjGAvuJmPeWHWvCxvii2ZODZUC8yXhCCg0d8QcN0F8bw76ZfqGpKvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SL4p9H5RDxg+ykV7VAlXJfJtR4wZjw+Q+exiq2sr3Vk=;
 b=mpx8E8f89wGxWacLMBin0Akj+qqWjm4XQKlcuyvwJ3uimVvskb1435zyOwDs/+SS0cjGGUgKBrWtfqjhF9O7RXe605DViJ1JDnS2abPt8uPaDyUrdC5oiTC20Mu7Uxd/uj6JZvLJBlCtkKZwZiBhfSrE6wr/YdP26eTGdCsRXDU=
Received: from DS7PR05CA0107.namprd05.prod.outlook.com (2603:10b6:8:56::25) by
 SJ0PR12MB5422.namprd12.prod.outlook.com (2603:10b6:a03:3ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 14:16:28 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::fd) by DS7PR05CA0107.outlook.office365.com
 (2603:10b6:8:56::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.13 via Frontend
 Transport; Fri, 7 Jul 2023 14:16:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Fri, 7 Jul 2023 14:16:28 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 7 Jul
 2023 09:15:32 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Increase IH soft ring size
Date: Fri, 7 Jul 2023 10:14:52 -0400
Message-ID: <20230707141452.10908-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT010:EE_|SJ0PR12MB5422:EE_
X-MS-Office365-Filtering-Correlation-Id: f0b4bfda-5423-48a6-a5b3-08db7ef4c12c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 53Qg3IjJ5UhP4RL5BFy6WfyqW1rkdrub4TNXXLK7AMvBp25mbmOVpCxKr3xNPtiN6pmK7vYt3wbei5+Ph013gUa3jhH7KKX2H+WdBS4OVZdGMyh9R9uKYbBBmFvIeomBZGD2JefoR6Qu640aONkAI9zQAh/TLEHbWCD5gsGbLYgE7nD28bRj84tU/YMICCcp933IpE7Ag6jEH+GMgJJytTaUAn9sUHc86US45RTh/ZcFQyPHg/7+79YTOPl6rQkB3z1gs9urq0XATq/fDcyN+KyV1/b3OjOaXayAIU5yeulvUwFTIEuGMqEskuJ4Qb3OvJAyNRkMtqc2wXSFrhqmPEffafI5O2NP+tyuiaa2QucrdIyxTfwTxwY+vrAqDCB+fMJQhnwBgsk47F/ZUXYDF+8i2nuTA+fiKr4400ZrwRChcHlAV27O2JnLJpGOWnoBf4pxHz4BkgzJTIonNDkFxKd/QF3NsEJHyrqrqygiVyADrcOc25vDhcm7s9YvaNp2bLHB4CoTw9mDYpBgv5usna6hUSRw8sJZ5ejWHS4r98SoGNyRcOBKehjtJ5BzztGExJvD6MM1awNMtDe+xZYCKVFInGSPcgeBeIzFghxNJeW1AZutRpN9RAsAOHAmNXvwo/tWU6am4By1Je50mKfsvJA282oUBjL0ZzaI/cw8xnj1LdO9gb2xm/pAUPOorWtj/x/X6c4Wa2PVUoF06hKYyBoJzhpqXW+MuqUDF/4IeHIjMOuW0u65eiSs63eAZHW2u/lipFRJUxCsnx6aqYjGsw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(5660300002)(82310400005)(2906002)(86362001)(36756003)(40480700001)(186003)(47076005)(83380400001)(16526019)(36860700001)(26005)(336012)(6916009)(426003)(1076003)(81166007)(82740400003)(7696005)(356005)(70586007)(2616005)(54906003)(4326008)(478600001)(6666004)(41300700001)(316002)(70206006)(8676002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 14:16:28.0324 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b4bfda-5423-48a6-a5b3-08db7ef4c12c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5422
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
Cc: mukul.joshi@amd.com, Felix.Kuehling@amd.com,
 Philip Yang <Philip.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Retry faults are delegated to IH soft ring and then processed by
deferred worker. Current IH soft ring size PAGE_SIZE can store 128
entries, which may overflow and drop retry faults, causes HW stucks
because the retry fault is not recovered.

Increase IH soft ring size to the same size as IH ring, define macro
IH_RING_SIZE to remove duplicate constant.

Show warning message if IH soft ring overflows because this should not
happen any more.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c  | 8 ++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h  | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c    | 5 +++--
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c  | 5 +++--
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c  | 5 +++--
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c  | 5 +++--
 7 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
index fceb3b384955..51a0dbd2358a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
@@ -138,6 +138,7 @@ void amdgpu_ih_ring_fini(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
 /**
  * amdgpu_ih_ring_write - write IV to the ring buffer
  *
+ * @adev: amdgpu_device pointer
  * @ih: ih ring to write to
  * @iv: the iv to write
  * @num_dw: size of the iv in dw
@@ -145,8 +146,8 @@ void amdgpu_ih_ring_fini(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
  * Writes an IV to the ring buffer using the CPU and increment the wptr.
  * Used for testing and delegating IVs to a software ring.
  */
-void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
-			  unsigned int num_dw)
+void amdgpu_ih_ring_write(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
+			  const uint32_t *iv, unsigned int num_dw)
 {
 	uint32_t wptr = le32_to_cpu(*ih->wptr_cpu) >> 2;
 	unsigned int i;
@@ -161,6 +162,9 @@ void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
 	if (wptr != READ_ONCE(ih->rptr)) {
 		wmb();
 		WRITE_ONCE(*ih->wptr_cpu, cpu_to_le32(wptr));
+	} else {
+		dev_warn(adev->dev, "IH soft ring buffer overflow 0x%X, 0x%X\n",
+			 wptr, ih->rptr);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
index dd1c2eded6b9..a8cf67f1f011 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
@@ -97,8 +97,8 @@ struct amdgpu_ih_funcs {
 int amdgpu_ih_ring_init(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
 			unsigned ring_size, bool use_bus_addr);
 void amdgpu_ih_ring_fini(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
-void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
-			  unsigned int num_dw);
+void amdgpu_ih_ring_write(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
+			  const uint32_t *iv, unsigned int num_dw);
 int amdgpu_ih_wait_on_checkpoint_process_ts(struct amdgpu_device *adev,
 					    struct amdgpu_ih_ring *ih);
 int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 5273decc5753..fa6d0adcec20 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -493,7 +493,7 @@ void amdgpu_irq_delegate(struct amdgpu_device *adev,
 			 struct amdgpu_iv_entry *entry,
 			 unsigned int num_dw)
 {
-	amdgpu_ih_ring_write(&adev->irq.ih_soft, entry->iv_entry, num_dw);
+	amdgpu_ih_ring_write(adev, &adev->irq.ih_soft, entry->iv_entry, num_dw);
 	schedule_work(&adev->irq.ih_soft_work);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
index b02e1cef78a7..21d2e57cffe7 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
@@ -32,6 +32,7 @@
 #include "soc15_common.h"
 #include "ih_v6_0.h"
 
+#define IH_RING_SIZE	(256 * 1024)
 #define MAX_REARM_RETRY 10
 
 static void ih_v6_0_set_interrupt_funcs(struct amdgpu_device *adev);
@@ -535,7 +536,7 @@ static int ih_v6_0_sw_init(void *handle)
 	 * use bus address for ih ring by psp bl */
 	use_bus_addr =
 		(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) ? false : true;
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, 256 * 1024, use_bus_addr);
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, IH_RING_SIZE, use_bus_addr);
 	if (r)
 		return r;
 
@@ -548,7 +549,7 @@ static int ih_v6_0_sw_init(void *handle)
 	/* initialize ih control register offset */
 	ih_v6_0_init_register_offset(adev);
 
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, PAGE_SIZE, true);
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_RING_SIZE, true);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index eec13cb5bf75..df33db6fd07b 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -32,6 +32,7 @@
 #include "soc15_common.h"
 #include "navi10_ih.h"
 
+#define IH_RING_SIZE	(256 * 1024)
 #define MAX_REARM_RETRY 10
 
 #define mmIH_CHICKEN_Sienna_Cichlid                 0x018d
@@ -565,7 +566,7 @@ static int navi10_ih_sw_init(void *handle)
 		use_bus_addr = false;
 	else
 		use_bus_addr = true;
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, 256 * 1024, use_bus_addr);
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, IH_RING_SIZE, use_bus_addr);
 	if (r)
 		return r;
 
@@ -578,7 +579,7 @@ static int navi10_ih_sw_init(void *handle)
 	/* initialize ih control registers offset */
 	navi10_ih_init_register_offset(adev);
 
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, PAGE_SIZE, true);
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_RING_SIZE, true);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
index 1e83db0c5438..c9b37983a18d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -33,6 +33,7 @@
 #include "soc15_common.h"
 #include "vega10_ih.h"
 
+#define IH_RING_SIZE	(256 * 1024)
 #define MAX_REARM_RETRY 10
 
 static void vega10_ih_set_interrupt_funcs(struct amdgpu_device *adev);
@@ -485,7 +486,7 @@ static int vega10_ih_sw_init(void *handle)
 	if (r)
 		return r;
 
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, 256 * 1024, true);
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, IH_RING_SIZE, true);
 	if (r)
 		return r;
 
@@ -510,7 +511,7 @@ static int vega10_ih_sw_init(void *handle)
 	/* initialize ih control registers offset */
 	vega10_ih_init_register_offset(adev);
 
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, PAGE_SIZE, true);
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_RING_SIZE, true);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index 4d719df376a7..06d4176e4c68 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -33,6 +33,7 @@
 #include "soc15_common.h"
 #include "vega20_ih.h"
 
+#define IH_RING_SIZE	(256 * 1024)
 #define MAX_REARM_RETRY 10
 
 #define mmIH_CHICKEN_ALDEBARAN			0x18d
@@ -539,7 +540,7 @@ static int vega20_ih_sw_init(void *handle)
 	    (adev->ip_versions[OSSSYS_HWIP][0] == IP_VERSION(4, 4, 2)))
 		use_bus_addr = false;
 
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, 256 * 1024, use_bus_addr);
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, IH_RING_SIZE, use_bus_addr);
 	if (r)
 		return r;
 
@@ -565,7 +566,7 @@ static int vega20_ih_sw_init(void *handle)
 	/* initialize ih control registers offset */
 	vega20_ih_init_register_offset(adev);
 
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, PAGE_SIZE, use_bus_addr);
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_RING_SIZE, use_bus_addr);
 	if (r)
 		return r;
 
-- 
2.35.1

