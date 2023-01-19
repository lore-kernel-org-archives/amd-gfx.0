Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ABFDC678D4
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Jan 2023 22:02:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A57D310E272;
	Thu, 19 Jan 2023 22:02:06 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D61D010E279
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Jan 2023 22:02:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hx0Z9tCm+cqW2v5LA1Xe1Et8t+fIaR+nJnbclUE/6QZ378hi/ajYw7EEkFiNDep3iB7RRkQHbQg35ch7IOPBFKP8pvL2yjuUfU46Ze5VIBKooNd1DmivfL+ZTaMrwBy6mxO6+oy2CZb2efpXqEHO+xZ5ICIGHkmaS8pQEOaxa/CzJUJGdI8FTwK/1zox15+yAsJ12q1sbEU4L5OxmvBXz45Tog9LiIXRR7bFDi9VMP/iwZ4lLdA1LvKRf3shnYNQ6/ZpALC3jv9SBFU05ABrQzm7a6VeXjvJMwi8FMUwchB7djJLwGYHtgZdh/Y11xiyjVDM6/VQvMz3qy44M37vww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDhiZVtVImAHFGqONBcSOzMlj9VKlepgP3S00Ziq/hE=;
 b=iVBjNFIOmQREcDXJoD6pdpcryYAzailH8XXpHNF29DTSuiQ9quQBKZRxSy3qxUgj4jppJEWR5Z/+uPzgEae/w1gg8njrF51gXOmiN8oNKeNJH7XKheL2AWZgU3bCOjiVrrVfXMSdTEdPskDOo4ACDj9J1bzba3WfSvLCfLphJ6vbO6Ao2EKZZJ0Y11JsK6sKy24iVykmmu/nTG3yNN28OTmpPoaH1/AYl0o1P7FWLzX4ylNn6c9vly2QEQAOD15kuHw2fH7VpAWNCtFuWKqrcYCjr1Ebr8rHW6WKn3GwfnRt2EDNBE5UAz7VpU2uxRGcHwcY4yh9rM6gzNxjhtixiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDhiZVtVImAHFGqONBcSOzMlj9VKlepgP3S00Ziq/hE=;
 b=1FstKsuAZ/B0nBUjdYPTKGv7AmTEH/oqwvDswEaN9LTHSYPBacaVVBT0l/QM5/XDtSA+3FOAiSWNKA9YNQDPEWtQasxJtc2j3by6qEWlqhjVRGTR3ik11lXnZKgHsKPjiflxZMlXBZUcOEksoHvdz/XwTZpYUdreUmhUgChi5Tg=
Received: from MW4PR04CA0169.namprd04.prod.outlook.com (2603:10b6:303:85::24)
 by MN0PR12MB5857.namprd12.prod.outlook.com (2603:10b6:208:378::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 22:02:00 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::33) by MW4PR04CA0169.outlook.office365.com
 (2603:10b6:303:85::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.26 via Frontend
 Transport; Thu, 19 Jan 2023 22:01:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Thu, 19 Jan 2023 22:01:59 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 19 Jan
 2023 16:01:58 -0600
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCHv2] drm/amdgpu: Enable IH retry CAM on GFX9
Date: Thu, 19 Jan 2023 16:59:18 -0500
Message-ID: <20230119215918.3629146-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT045:EE_|MN0PR12MB5857:EE_
X-MS-Office365-Filtering-Correlation-Id: cf4839e6-1bec-497b-85be-08dafa68ca09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: txrnFyyXiHhuAgDBl0VwUnO/EzA0hU19x+8njNl3D4QHudjw2hKFH1XJ8krIdnTYenURipMcCJEf+Ymx5bk4HtowMsjTufHO4t6lUVTIQHQoLvvHw8x+7ZXsBYMmt6Hy543oy9jNiYVy/kZQOqlaf287dcBlwEaqxOEsDCqZW24Y4E6VkOdyqkPE+5fyAbV8Clf7+ZVMJooDMhPEbkYLnC/GeuwN8cco4mimeZVgER8bUqmTk8GZfdn+0Ur0xZkAlRcPubA8PwM7lRR/6soqfC3dCNeDTDhSlmqm9OuEhJASdupG1aPApdLSjr/2lHvsS5yF01G510jGd85uOD4YDMfK8uDZ8l00eEDX810IYwTDRPQahBT4WJ/lXn5KTlqMdfqsTjaLStkmNDK27Smq7IqJsyLxndeaHghgWS50Mpw4/hU6QdLumYOB9E9MJaN/37X+BCQl8aEryjK2p40/yPYfh850v/fiED1LKSiStIVPcRtWyvY2KOreojDgA+JRiFydcWu5Vk9toiyCphm1NK8um8cGZxic9LMC5kZmW4pIcGilHFibhsPCEE4sjhzpfQGHmFddFguaf6wV2LJOaui93kN+plMhiocmHYwiQ035+5NWd2w5mBvDEoju13nPvEp+aR5hNfIUUX33+NPvgrl0qSwJN2D9AU5+Le22RR3yswdQTr2j/e0VGXBumUMAOqHJN8XF9ko9qb+RW46ZhuUA1dJAIalVxMEWBFGXYEU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199015)(40470700004)(36840700001)(46966006)(81166007)(36860700001)(40480700001)(82740400003)(316002)(70586007)(86362001)(2906002)(8936002)(44832011)(70206006)(30864003)(5660300002)(26005)(16526019)(8676002)(82310400005)(336012)(41300700001)(6916009)(83380400001)(40460700003)(2616005)(1076003)(186003)(426003)(7696005)(6666004)(47076005)(54906003)(356005)(478600001)(4326008)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 22:01:59.7792 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf4839e6-1bec-497b-85be-08dafa68ca09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5857
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch enables the IH retry CAM on GFX9 series cards. This
retry filter is used to prevent sending lots of retry interrupts
in a short span of time and overflowing the IH ring buffer. This
will also help reduce CPU interrupt workload.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
v1:
- Reviewed by Felix.

v1->v2:
- Update the CAM enable register offset for Aldebaran.
- Add new register defines for Aldebaran in vega20_ih.c.
- Drain IH0 ring also along with soft ring.
- Setup CAM doorbell register before enabling CAM.

 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h       |  2 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         | 51 +++++++++++------
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c        | 55 +++++++++----------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          | 10 +++-
 .../asic_reg/oss/osssys_4_2_0_offset.h        |  6 ++
 .../asic_reg/oss/osssys_4_2_0_sh_mask.h       | 11 ++++
 7 files changed, 88 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
index e9f2c11ea416..be243adf3e65 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
@@ -98,6 +98,8 @@ struct amdgpu_irq {
 	struct irq_domain		*domain; /* GPU irq controller domain */
 	unsigned			virq[AMDGPU_MAX_IRQ_SRC_ID];
 	uint32_t                        srbm_soft_reset;
+	u32                             retry_cam_doorbell_index;
+	bool                            retry_cam_enabled;
 };
 
 void amdgpu_irq_disable_all(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index d65c6cea3445..4847117d67a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -553,32 +553,49 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	const char *mmhub_cid;
 	const char *hub_name;
 	u64 addr;
+	uint32_t cam_index = 0;
+	int ret;
 
 	addr = (u64)entry->src_data[0] << 12;
 	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
 
 	if (retry_fault) {
-		/* Returning 1 here also prevents sending the IV to the KFD */
+		if (adev->irq.retry_cam_enabled) {
+			/* Delegate it to a different ring if the hardware hasn't
+			 * already done it.
+			 */
+			if (entry->ih == &adev->irq.ih) {
+				amdgpu_irq_delegate(adev, entry, 8);
+				return 1;
+			}
+
+			cam_index = entry->src_data[2] & 0x3ff;
 
-		/* Process it onyl if it's the first fault for this address */
-		if (entry->ih != &adev->irq.ih_soft &&
-		    amdgpu_gmc_filter_faults(adev, entry->ih, addr, entry->pasid,
+			ret = amdgpu_vm_handle_fault(adev, entry->pasid, addr, write_fault);
+			WDOORBELL32(adev->irq.retry_cam_doorbell_index, cam_index);
+			if (ret)
+				return 1;
+		} else {
+			/* Process it onyl if it's the first fault for this address */
+			if (entry->ih != &adev->irq.ih_soft &&
+			    amdgpu_gmc_filter_faults(adev, entry->ih, addr, entry->pasid,
 					     entry->timestamp))
-			return 1;
+				return 1;
 
-		/* Delegate it to a different ring if the hardware hasn't
-		 * already done it.
-		 */
-		if (entry->ih == &adev->irq.ih) {
-			amdgpu_irq_delegate(adev, entry, 8);
-			return 1;
-		}
+			/* Delegate it to a different ring if the hardware hasn't
+			 * already done it.
+			 */
+			if (entry->ih == &adev->irq.ih) {
+				amdgpu_irq_delegate(adev, entry, 8);
+				return 1;
+			}
 
-		/* Try to handle the recoverable page faults by filling page
-		 * tables
-		 */
-		if (amdgpu_vm_handle_fault(adev, entry->pasid, addr, write_fault))
-			return 1;
+			/* Try to handle the recoverable page faults by filling page
+			 * tables
+			 */
+			if (amdgpu_vm_handle_fault(adev, entry->pasid, addr, write_fault))
+				return 1;
+		}
 	}
 
 	if (!printk_ratelimit())
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index 19455a725939..685abf57ffdd 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -238,7 +238,7 @@ static void nbio_v7_4_ih_doorbell_range(struct amdgpu_device *adev,
 
 	if (use_doorbell) {
 		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range, BIF_IH_DOORBELL_RANGE, OFFSET, doorbell_index);
-		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range, BIF_IH_DOORBELL_RANGE, SIZE, 4);
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range, BIF_IH_DOORBELL_RANGE, SIZE, 8);
 	} else
 		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range, BIF_IH_DOORBELL_RANGE, SIZE, 0);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index 1706081d054d..6a8fb1fb48a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -38,6 +38,11 @@
 #define mmIH_CHICKEN_ALDEBARAN			0x18d
 #define mmIH_CHICKEN_ALDEBARAN_BASE_IDX		0
 
+#define mmIH_RETRY_INT_CAM_CNTL_ALDEBARAN		0x00ea
+#define mmIH_RETRY_INT_CAM_CNTL_ALDEBARAN_BASE_IDX	0
+#define IH_RETRY_INT_CAM_CNTL_ALDEBARAN__ENABLE__SHIFT	0x10
+#define IH_RETRY_INT_CAM_CNTL_ALDEBARAN__ENABLE_MASK	0x00010000L
+
 static void vega20_ih_set_interrupt_funcs(struct amdgpu_device *adev);
 
 /**
@@ -251,36 +256,14 @@ static int vega20_ih_enable_ring(struct amdgpu_device *adev,
 	return 0;
 }
 
-/**
- * vega20_ih_reroute_ih - reroute VMC/UTCL2 ih to an ih ring
- *
- * @adev: amdgpu_device pointer
- *
- * Reroute VMC and UMC interrupts on primary ih ring to
- * ih ring 1 so they won't lose when bunches of page faults
- * interrupts overwhelms the interrupt handler(VEGA20)
- */
-static void vega20_ih_reroute_ih(struct amdgpu_device *adev)
+static uint32_t vega20_setup_retry_doorbell(u32 doorbell_index)
 {
-	uint32_t tmp;
+	u32 val = 0;
 
-	/* vega20 ih reroute will go through psp this
-	 * function is used for newer asics starting arcturus
-	 */
-	if (adev->ip_versions[OSSSYS_HWIP][0] >= IP_VERSION(4, 2, 1)) {
-		/* Reroute to IH ring 1 for VMC */
-		WREG32_SOC15(OSSSYS, 0, mmIH_CLIENT_CFG_INDEX, 0x12);
-		tmp = RREG32_SOC15(OSSSYS, 0, mmIH_CLIENT_CFG_DATA);
-		tmp = REG_SET_FIELD(tmp, IH_CLIENT_CFG_DATA, CLIENT_TYPE, 1);
-		tmp = REG_SET_FIELD(tmp, IH_CLIENT_CFG_DATA, RING_ID, 1);
-		WREG32_SOC15(OSSSYS, 0, mmIH_CLIENT_CFG_DATA, tmp);
-
-		/* Reroute IH ring 1 for UTCL2 */
-		WREG32_SOC15(OSSSYS, 0, mmIH_CLIENT_CFG_INDEX, 0x1B);
-		tmp = RREG32_SOC15(OSSSYS, 0, mmIH_CLIENT_CFG_DATA);
-		tmp = REG_SET_FIELD(tmp, IH_CLIENT_CFG_DATA, RING_ID, 1);
-		WREG32_SOC15(OSSSYS, 0, mmIH_CLIENT_CFG_DATA, tmp);
-	}
+	val = REG_SET_FIELD(val, IH_DOORBELL_RPTR, OFFSET, doorbell_index);
+	val = REG_SET_FIELD(val, IH_DOORBELL_RPTR, ENABLE, 1);
+
+	return val;
 }
 
 /**
@@ -332,8 +315,6 @@ static int vega20_ih_irq_init(struct amdgpu_device *adev)
 
 	for (i = 0; i < ARRAY_SIZE(ih); i++) {
 		if (ih[i]->ring_size) {
-			if (i == 1)
-				vega20_ih_reroute_ih(adev);
 			ret = vega20_ih_enable_ring(adev, ih[i]);
 			if (ret)
 				return ret;
@@ -346,6 +327,20 @@ static int vega20_ih_irq_init(struct amdgpu_device *adev)
 
 	pci_set_master(adev->pdev);
 
+	/* Allocate the doorbell for IH Retry CAM */
+	adev->irq.retry_cam_doorbell_index = (adev->doorbell_index.ih + 3) << 1;
+	WREG32_SOC15(OSSSYS, 0, mmIH_DOORBELL_RETRY_CAM,
+		vega20_setup_retry_doorbell(adev->irq.retry_cam_doorbell_index));
+
+	/* Enable IH Retry CAM */
+	if (adev->ip_versions[OSSSYS_HWIP][0] == IP_VERSION(4, 4, 0))
+		WREG32_FIELD15(OSSSYS, 0, IH_RETRY_INT_CAM_CNTL_ALDEBARAN,
+			       ENABLE, 1);
+	else
+		WREG32_FIELD15(OSSSYS, 0, IH_RETRY_INT_CAM_CNTL, ENABLE, 1);
+
+	adev->irq.retry_cam_enabled = true;
+
 	/* enable interrupts */
 	ret = vega20_ih_toggle_interrupts(adev, true);
 	if (ret)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 859159093ffd..5c67f177dc6c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2171,7 +2171,15 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
 		pr_debug("drain retry fault gpu %d svms %p\n", i, svms);
 
 		amdgpu_ih_wait_on_checkpoint_process_ts(pdd->dev->adev,
-						     &pdd->dev->adev->irq.ih1);
+				pdd->dev->adev->irq.retry_cam_enabled ?
+				&pdd->dev->adev->irq.ih :
+				&pdd->dev->adev->irq.ih1);
+
+		if (pdd->dev->adev->irq.retry_cam_enabled)
+			amdgpu_ih_wait_on_checkpoint_process_ts(pdd->dev->adev,
+				&pdd->dev->adev->irq.ih_soft);
+
+
 		pr_debug("drain retry fault gpu %d svms 0x%p done\n", i, svms);
 	}
 	if (atomic_cmpxchg(&svms->drain_pagefaults, drain, 0) != drain)
diff --git a/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_2_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_2_0_offset.h
index bd129266ebfd..a84a7cfaf71e 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_2_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_2_0_offset.h
@@ -135,6 +135,8 @@
 #define mmIH_RB_WPTR_ADDR_LO_BASE_IDX                                                                  0
 #define mmIH_DOORBELL_RPTR                                                                             0x0087
 #define mmIH_DOORBELL_RPTR_BASE_IDX                                                                    0
+#define mmIH_DOORBELL_RETRY_CAM                                                                        0x0088
+#define mmIH_DOORBELL_RETRY_CAM_BASE_IDX                                                               0
 #define mmIH_RB_CNTL_RING1                                                                             0x008c
 #define mmIH_RB_CNTL_RING1_BASE_IDX                                                                    0
 #define mmIH_RB_BASE_RING1                                                                             0x008d
@@ -159,6 +161,8 @@
 #define mmIH_RB_WPTR_RING2_BASE_IDX                                                                    0
 #define mmIH_DOORBELL_RPTR_RING2                                                                       0x009f
 #define mmIH_DOORBELL_RPTR_RING2_BASE_IDX                                                              0
+#define mmIH_RETRY_CAM_ACK                                                                             0x00a4
+#define mmIH_RETRY_CAM_ACK_BASE_IDX                                                                    0
 #define mmIH_VERSION                                                                                   0x00a5
 #define mmIH_VERSION_BASE_IDX                                                                          0
 #define mmIH_CNTL                                                                                      0x00c0
@@ -235,6 +239,8 @@
 #define mmIH_MMHUB_ERROR_BASE_IDX                                                                      0
 #define mmIH_MEM_POWER_CTRL                                                                            0x00e8
 #define mmIH_MEM_POWER_CTRL_BASE_IDX                                                                   0
+#define mmIH_RETRY_INT_CAM_CNTL                                                                        0x00e9
+#define mmIH_RETRY_INT_CAM_CNTL_BASE_IDX                                                               0
 #define mmIH_REGISTER_LAST_PART2                                                                       0x00ff
 #define mmIH_REGISTER_LAST_PART2_BASE_IDX                                                              0
 #define mmSEM_CLK_CTRL                                                                                 0x0100
diff --git a/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_2_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_2_0_sh_mask.h
index 3ea83ea9ce3a..75c04fc275a0 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_2_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_2_0_sh_mask.h
@@ -349,6 +349,17 @@
 #define IH_DOORBELL_RPTR_RING2__ENABLE__SHIFT                                                                 0x1c
 #define IH_DOORBELL_RPTR_RING2__OFFSET_MASK                                                                   0x03FFFFFFL
 #define IH_DOORBELL_RPTR_RING2__ENABLE_MASK                                                                   0x10000000L
+//IH_RETRY_INT_CAM_CNTL
+#define IH_RETRY_INT_CAM_CNTL__CAM_SIZE__SHIFT                                                                0x0
+#define IH_RETRY_INT_CAM_CNTL__BACK_PRESSURE_SKID_VALUE__SHIFT                                                0x8
+#define IH_RETRY_INT_CAM_CNTL__ENABLE__SHIFT                                                                  0x10
+#define IH_RETRY_INT_CAM_CNTL__BACK_PRESSURE_ENABLE__SHIFT                                                    0x11
+#define IH_RETRY_INT_CAM_CNTL__PER_VF_ENTRY_SIZE__SHIFT                                                       0x14
+#define IH_RETRY_INT_CAM_CNTL__CAM_SIZE_MASK                                                                  0x0000001FL
+#define IH_RETRY_INT_CAM_CNTL__BACK_PRESSURE_SKID_VALUE_MASK                                                  0x00003F00L
+#define IH_RETRY_INT_CAM_CNTL__ENABLE_MASK                                                                    0x00010000L
+#define IH_RETRY_INT_CAM_CNTL__BACK_PRESSURE_ENABLE_MASK                                                      0x00020000L
+#define IH_RETRY_INT_CAM_CNTL__PER_VF_ENTRY_SIZE_MASK                                                         0x00300000L
 //IH_VERSION
 #define IH_VERSION__MINVER__SHIFT                                                                             0x0
 #define IH_VERSION__MAJVER__SHIFT                                                                             0x8
-- 
2.35.1

