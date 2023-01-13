Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A24C678DB
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jan 2023 06:25:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 452E010E99D;
	Fri, 13 Jan 2023 06:25:13 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3E1010E993
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 06:25:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEfXTnIbJIF8wsOK5PEZYSgW5bKD9dzBLVRidU8fBnQhUrzCsjaG8foNLActBqtb7lsf4tuam2QMK2NNdLJS6Lbnrwl9DS5gySSyKidouDDKDGzYjhPmNYKqlF37OyU9DllzDgmD4kk+cMak2QogJ3dZEMaZFls0jRQMLRMaTlQHi6XrGBtlAjlGYrUS2x1rpKM4cKlXbSPzqLRP3HYdjf7R7B/yCcz/n4AjeS9g7IoocMlOizOUV524IgEqe2KHYgBSOkeM8wqTcGF4yapfFSZlKgdXrhXwUGIGAW6rbLpdo2YACuD9PSmOdjlYnfJUGd7hCC2TeHKIPdM3uTnsIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aoHtTcKUbMsJfJUuHsfyekak//crcMLlqwntjlsxl2s=;
 b=h/01bfZkRAJv9rctvQdA4NdIdScztjDK8httNrbt8xPQReLalkmSrRsDtzmwnpX3ObFpBlY6i0Z8dKFL6jwbcS+wjlnGI4LjufCiH8uCW89LRBgIr36QBx7V0OYhVsZnS33ooAJXN5PDRX6VWPdfXONYrLvXc1gIFj3sJnx5Eg+i/5GJVEOm5Idkr31spQICEtyjm6Ws8+lzlv36mwGbxpfFxwk0bETB6/TBMoKM09dv1Pc9FGHzswwJsFammGClBBukPFetqBljwkH6jSH1tgGsbg8QxPLsLyaw/FxVedSL5b+Q6NEcvOySmvTRV6EqXLcwahlQviOGx0UshKAxPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aoHtTcKUbMsJfJUuHsfyekak//crcMLlqwntjlsxl2s=;
 b=Ad9Q9Iq4VsQwd2bYyopga0T7x7nDWDNmdrJfnzOt4p2H30BH//YHg6b8hVmY37NKCD80vAsQ5J1Nu2iC6CWWRx67SKG5msuuTUFrtc1VQGG5fudwlkm/h/lLloWLyh4XYp3lSQwnRHyE+ztDCO8Y6nX1ZkHOl8skUdWBKHAFmdA=
Received: from DM6PR06CA0018.namprd06.prod.outlook.com (2603:10b6:5:120::31)
 by SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 06:25:06 +0000
Received: from DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::6d) by DM6PR06CA0018.outlook.office365.com
 (2603:10b6:5:120::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.14 via Frontend
 Transport; Fri, 13 Jan 2023 06:25:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT079.mail.protection.outlook.com (10.13.173.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 06:25:06 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 00:25:02 -0600
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/5] drm/amdgpu: Add gfx ras poison consumption irq handling
 on gfx v11_0_3
Date: Fri, 13 Jan 2023 14:23:56 +0800
Message-ID: <20230113062358.1727355-3-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230113062358.1727355-1-YiPeng.Chai@amd.com>
References: <20230113062358.1727355-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT079:EE_|SA1PR12MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: 23f87c43-1d4f-4d42-d1f3-08daf52ee98b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iW/Xd6vDNKjguyuxYFzOmaiVUFcfuR4wR1JL52RWO0392XMGkt8O1/Z4Y9403tWfaGpahpnFvretCHs3kiy4zMU5QnWncHL5WzEHjo81rmpY+6pfrvqLTj8BWDCVYCK8Bc3SvtmLbkhE3dMuH3obOrF8r5Iyb0N+FyuzqVfu2Ihf7isZ+EUBUAJYutwVoakRZwuSgeESc17Juv9Vnqdlg4WNtw6i9PHXDjerfq5uB9A1o3FDqctJzIDY3c62nxqkPXlpFix1ILQbN6Odf2luoBCrVo2DtWKixeVvtKiezYE5JnYzDsGr67t5Ok9/cMvZJkdiKmNlol62pNa4y91URRSnPMYT6HMjL2TyYHrqY6BDit87K6gzla8J/Pc9rZqLvS0uYMVd43rJq5FPaa7/Oru+c7M0i14gMO1BA6q2ekbIfnOINhA+OST1xcigGZziC7nloBUCbxYedZD+Ja3bjEspxPv5qQnvvmoI20/zgeTwZG1cb7CwtE7SL1JLJMbZSJfyYhjnwMO0IR4XvIW/QWg3rMYgib/LySB6crFJEX1qxI8Q3i+BHxABHHbLe3VRKydxHTeKTMEhTt8BNsQmNchldtFkwvRKMRl1Yixfe28vkS+GOvitr9vopxfKu38Izls1/PNV85yCaaVAK3hIiolFCYXztu47CPQ0rP2MosVs/xDUkzJuvCdTWffRoziDC0pkGvzJoiOX6L2c0EZ+z+LfXrCsOsQCzIRg4aColO8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199015)(40470700004)(36840700001)(46966006)(36756003)(86362001)(70206006)(8676002)(83380400001)(4326008)(54906003)(70586007)(41300700001)(40460700003)(81166007)(356005)(82740400003)(6916009)(36860700001)(26005)(186003)(6666004)(316002)(5660300002)(8936002)(478600001)(426003)(2906002)(7696005)(40480700001)(2616005)(82310400005)(1076003)(16526019)(336012)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 06:25:06.1120 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f87c43-1d4f-4d42-d1f3-08daf52ee98b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7442
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
Cc: Tao Zhou <tao.zhou1@amd.com>, Hawking.Zhang@amd.com,
 YiPeng Chai <YiPeng.Chai@amd.com>, Candice.Li@amd.com, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add gfx ras poison consumption irq handling on gfx v11_0_3.

V2:
  Move ras poison consumption irq handling code of gfx
     v11_0_3 to gfx_v11_0_3.c.
V5:
  Create dedicated irq handler for RLC_GC_FED_INTERRUPT.

V6:
  Remove invalid function call.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  4 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 24 +++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c      | 50 ++++++++++++++++++-
 .../include/ivsrcid/gfx/irqsrcs_gfx_11_0_0.h  |  2 +
 4 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 6b26597217ed..0b39fe3cd624 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -210,6 +210,9 @@ struct amdgpu_gfx_ras {
 	struct amdgpu_ras_block_object  ras_block;
 	void (*enable_watchdog_timer)(struct amdgpu_device *adev);
 	bool (*query_utcl2_poison_status)(struct amdgpu_device *adev);
+	int (*rlc_gc_fed_irq)(struct amdgpu_device *adev,
+				struct amdgpu_irq_src *source,
+				struct amdgpu_iv_entry *entry);
 };
 
 struct amdgpu_gfx_funcs {
@@ -323,6 +326,7 @@ struct amdgpu_gfx {
 	struct amdgpu_irq_src		priv_inst_irq;
 	struct amdgpu_irq_src		cp_ecc_error_irq;
 	struct amdgpu_irq_src		sq_irq;
+	struct amdgpu_irq_src		rlc_gc_fed_irq;
 	struct sq_work			sq_work;
 
 	/* gfx status */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 82beb46788cf..cc634cae77d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1338,6 +1338,13 @@ static int gfx_v11_0_sw_init(void *handle)
 	if (r)
 		return r;
 
+	/* FED error */
+	r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_GFX,
+				  GFX_11_0_0__SRCID__RLC_GC_FED_INTERRUPT,
+				  &adev->gfx.rlc_gc_fed_irq);
+	if (r)
+		return r;
+
 	adev->gfx.gfx_current_status = AMDGPU_GFX_NORMAL_MODE;
 
 	if (adev->gfx.imu.funcs) {
@@ -6034,6 +6041,16 @@ static int gfx_v11_0_priv_inst_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int gfx_v11_0_rlc_gc_fed_irq(struct amdgpu_device *adev,
+				  struct amdgpu_irq_src *source,
+				  struct amdgpu_iv_entry *entry)
+{
+	if (adev->gfx.ras && adev->gfx.ras->rlc_gc_fed_irq)
+		return adev->gfx.ras->rlc_gc_fed_irq(adev, source, entry);
+
+	return 0;
+}
+
 #if 0
 static int gfx_v11_0_kiq_set_interrupt_state(struct amdgpu_device *adev,
 					     struct amdgpu_irq_src *src,
@@ -6264,6 +6281,10 @@ static const struct amdgpu_irq_src_funcs gfx_v11_0_priv_inst_irq_funcs = {
 	.process = gfx_v11_0_priv_inst_irq,
 };
 
+static const struct amdgpu_irq_src_funcs gfx_v11_0_rlc_gc_fed_irq_funcs = {
+	.process = gfx_v11_0_rlc_gc_fed_irq,
+};
+
 static void gfx_v11_0_set_irq_funcs(struct amdgpu_device *adev)
 {
 	adev->gfx.eop_irq.num_types = AMDGPU_CP_IRQ_LAST;
@@ -6274,6 +6295,9 @@ static void gfx_v11_0_set_irq_funcs(struct amdgpu_device *adev)
 
 	adev->gfx.priv_inst_irq.num_types = 1;
 	adev->gfx.priv_inst_irq.funcs = &gfx_v11_0_priv_inst_irq_funcs;
+
+	adev->gfx.rlc_gc_fed_irq.num_types = 1; /* 0x80 FED error */
+	adev->gfx.rlc_gc_fed_irq.funcs = &gfx_v11_0_rlc_gc_fed_irq_funcs;
 }
 
 static void gfx_v11_0_set_imu_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
index 5966d984a30a..a18e09de31dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
@@ -22,6 +22,54 @@
  */
 
 #include "amdgpu.h"
+#include "soc21.h"
+#include "gc/gc_11_0_3_offset.h"
+#include "gc/gc_11_0_3_sh_mask.h"
+#include "ivsrcid/gfx/irqsrcs_gfx_11_0_0.h"
+#include "soc15.h"
+#include "soc15d.h"
+#include "gfx_v11_0.h"
 
 
-struct amdgpu_gfx_ras gfx_v11_0_3_ras;
+static int gfx_v11_0_3_rlc_gc_fed_irq(struct amdgpu_device *adev,
+				  struct amdgpu_irq_src *source,
+				  struct amdgpu_iv_entry *entry)
+{
+	uint32_t rlc_status0 = 0, rlc_status1 = 0;
+	struct ras_common_if *ras_if = NULL;
+	struct ras_dispatch_if ih_data = {
+		.entry = entry,
+	};
+
+	rlc_status0 = RREG32(SOC15_REG_OFFSET(GC, 0, regRLC_RLCS_FED_STATUS_0));
+	rlc_status1 = RREG32(SOC15_REG_OFFSET(GC, 0, regRLC_RLCS_FED_STATUS_1));
+
+	if (!rlc_status0 && !rlc_status1) {
+		dev_warn(adev->dev, "RLC_GC_FED irq is generated, but rlc_status0 and rlc_status1 are empty!\n");
+		return 0;
+	}
+
+	/* Use RLC_RLCS_FED_STATUS_0/1 to distinguish FED error block. */
+	if (REG_GET_FIELD(rlc_status0, RLC_RLCS_FED_STATUS_0, SDMA0_FED_ERR) ||
+	    REG_GET_FIELD(rlc_status0, RLC_RLCS_FED_STATUS_0, SDMA1_FED_ERR))
+		ras_if = adev->sdma.ras_if;
+	else
+		ras_if = adev->gfx.ras_if;
+
+	if (!ras_if) {
+		dev_err(adev->dev, "Gfx or sdma ras block not initialized, rlc_status0:0x%x.\n",
+				rlc_status0);
+		return -EINVAL;
+	}
+
+	ih_data.head = *ras_if;
+
+	dev_warn(adev->dev, "RLC %s FED IRQ\n", ras_if->name);
+	amdgpu_ras_interrupt_dispatch(adev, &ih_data);
+
+	return 0;
+}
+
+struct amdgpu_gfx_ras gfx_v11_0_3_ras = {
+	.rlc_gc_fed_irq = gfx_v11_0_3_rlc_gc_fed_irq,
+};
diff --git a/drivers/gpu/drm/amd/include/ivsrcid/gfx/irqsrcs_gfx_11_0_0.h b/drivers/gpu/drm/amd/include/ivsrcid/gfx/irqsrcs_gfx_11_0_0.h
index 9e8ed9f4bb15..3a4670bc4449 100644
--- a/drivers/gpu/drm/amd/include/ivsrcid/gfx/irqsrcs_gfx_11_0_0.h
+++ b/drivers/gpu/drm/amd/include/ivsrcid/gfx/irqsrcs_gfx_11_0_0.h
@@ -49,6 +49,8 @@
 #define GFX_11_0_0__SRCID__SDMA_SEM_INCOMPLETE_TIMEOUT          65      // 0x41 GPF(Sem incomplete timeout)
 #define GFX_11_0_0__SRCID__SDMA_SEM_WAIT_FAIL_TIMEOUT           66      // 0x42 Semaphore wait fail timeout
 
+#define GFX_11_0_0__SRCID__RLC_GC_FED_INTERRUPT                 128     // 0x80 FED Interrupt (for data poisoning)
+
 #define GFX_11_0_0__SRCID__CP_GENERIC_INT				        177		// 0xB1 CP_GENERIC int
 #define GFX_11_0_0__SRCID__CP_PM4_PKT_RSVD_BIT_ERROR		    180		// 0xB4 PM4 Pkt Rsvd Bits Error
 #define GFX_11_0_0__SRCID__CP_EOP_INTERRUPT					    181		// 0xB5 End-of-Pipe Interrupt
-- 
2.25.1

