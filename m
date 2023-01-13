Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B683C71140
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jan 2023 06:25:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CA6C10E9A2;
	Fri, 13 Jan 2023 06:25:16 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B9FF10E9A0
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 06:25:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUrS84wtlymWQ8pO0hFnvzDeVrlm5UgJ37tYzb2+ziy0gtL1yrYNTpSMO9p4tN/EMWcwRofDaRYFkQmpUY/Ve3vkIjS0XECzXcdCetK5g7z8jcBuUGM/Qx5slUpBMsjJelKbeaXOjMbP0OLCCPWSKGZvxtB57QKSUAybO8xRZeYe9rRgky+Dt282fcNaQtZjvxMLmANQa1tbN9JmFvWhYd9ZfL/mgS6NgjFLfAD6x2vxRYjJnQXT2sSpXaNHfRjF4zOLx2fdUi15FHaEXHK7W1DcAJt8m29f+qNizjFyX8NO4B1Zc6wqqDkrg77F0hITLcPPygFVlKZbb2dpx8o0gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vJ3L3Cv4qiMuf7WRae4X+7fC9IhjZXk2On+612SEmI=;
 b=VIxnL6lB8XQhqcJ13B2K1Akw8whSyUk6DitoaRNPFULQrt9nvPY8rp8S5jTSaM+zw22hYTEavKxPoFAKqPJXQsaXR6blaz6Rc+qM5VOAZ6oSPD6Z+0xT7qjGJHezdc9g9wAEDwaEkgRLDZJtKGyaF+tCEcCGP3aut3r6gZktQSR4ZKVJC/sRGVFf0hq3vl7oVo3+aksOEpt43+77HX7w2RNPFLy26WwV6HkfBOXa8o9UNR+4n5u8KcK71Toh5yyxf1ZNEGnGzcXK4DwGjqgkcpyZty6wMj77FUBAEaxYz7r1UsoqbHJ5HREkQ/XhDA+MdWCqSVBMXo8Z4n6pkgARrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vJ3L3Cv4qiMuf7WRae4X+7fC9IhjZXk2On+612SEmI=;
 b=uu4on20glMsw45Xv8BCUDQwY8PjKKbc6NFnEf9q3LaRoFJwTUJlE4X5fgglEOVT3TKlm2r3bDSIMBoheiQoTYxnRkVo4xMUv1QmgXbWGB4ChRMoHeaZ3ya+PpSELfntsk+0H8zdFQxjNM2nUbHzSw3ttPX3gZU305WFgpimQCyM=
Received: from DM5PR07CA0080.namprd07.prod.outlook.com (2603:10b6:4:ad::45) by
 MN2PR12MB4142.namprd12.prod.outlook.com (2603:10b6:208:1dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Fri, 13 Jan
 2023 06:25:09 +0000
Received: from DM6NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::dd) by DM5PR07CA0080.outlook.office365.com
 (2603:10b6:4:ad::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13 via Frontend
 Transport; Fri, 13 Jan 2023 06:25:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT109.mail.protection.outlook.com (10.13.173.178) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 06:25:08 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 00:25:05 -0600
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/5] drm/amdgpu: Add gfx cp ecc error irq handling on gfx
 v11_0_3
Date: Fri, 13 Jan 2023 14:23:57 +0800
Message-ID: <20230113062358.1727355-4-YiPeng.Chai@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT109:EE_|MN2PR12MB4142:EE_
X-MS-Office365-Filtering-Correlation-Id: 49afedcd-8cda-4032-2f48-08daf52eeb44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0aScSdE3SFdAG2AKMsClghuqoOBneVN7/KyRS1kuBcR+hQbBG58YDpTo9byP0z5yhmMbvFrbOOTwqC+rykohxPPgcJHr+PAS4/G8mxk74sBbw4j0AwaXQvPClddnNxIWGojMGRti4lAGaDO/70T0k7OfQ5CJ5lhYFW3X/pKsJkOwCGnQxjy0Q4MJYhX4lUuMqXZYgsGv+no8Rhu6h8mPHuMIiFOcY0pouoVvoGKx/PhyTzCQfRRvAIVgY6cv6V9W9EFB/nHWmnMIkDCeYSK6ZHjKgW1zq03xU29ZZEBHLSxeZvl8ctF8THGMys+Pu7bexUuTfPQgfle9j558kFgGPTXgwrMDU5usdHHzdj/dQIRDu+Yu57DFLXyzwTL+JBtPTM1R2t9+ZMlVMNFd+H3mqY3NxblullQbT9ZcfHZAEVXY+jvWQJFDlGeckTtrBZmT9HRNgnnwEwnMmuigwNz+WuQ/ZoYf0guDNDAItadAMESAfw9QKLus09VnQocqxpfJFxaeEh+TrBUqbpnnNpFVuUlt7uKdasdKcZCftM2B264+Zb1LpGa8725xEedGln9ZU3kUhKGkRf+mnHKnSNbpw5+P3tlbijIhHGJGzUmbEnLAeikQ7xzfcEZc4PSaevb7c8pnnhBuJA1Ngcg9ZNpX8sq2nsul/fz2onbRjoXPE+aLz6C1kjc2h0IUrIMYCDltUtO7CmP9MRaoBa1P1G6myy/1ir7SVNdJ7lIu8n+OKts=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199015)(36840700001)(46966006)(40470700004)(2906002)(40460700003)(5660300002)(54906003)(316002)(36756003)(2616005)(82310400005)(1076003)(36860700001)(336012)(426003)(47076005)(7696005)(86362001)(40480700001)(26005)(356005)(81166007)(82740400003)(16526019)(186003)(478600001)(6666004)(8936002)(6916009)(4326008)(8676002)(70586007)(41300700001)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 06:25:08.9980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49afedcd-8cda-4032-2f48-08daf52eeb44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4142
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

V2:
  Optimize gfx_v11_0_set_cp_ecc_error_state function.

V3:
  Define macro constant for me pipe instance address interval.

V5:
  Register and handle gfx cp ecc error irq on gfx v11_0_3.

V6:
  Remove invalid intermediate function call.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 47 ++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index cc634cae77d7..39f48227bcf8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1338,6 +1338,13 @@ static int gfx_v11_0_sw_init(void *handle)
 	if (r)
 		return r;
 
+	/* ECC error */
+	r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_GRBM_CP,
+				  GFX_11_0_0__SRCID__CP_ECC_ERROR,
+				  &adev->gfx.cp_ecc_error_irq);
+	if (r)
+		return r;
+
 	/* FED error */
 	r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_GFX,
 				  GFX_11_0_0__SRCID__RLC_GC_FED_INTERRUPT,
@@ -4434,6 +4441,7 @@ static int gfx_v11_0_hw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int r;
 
+	amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
 
@@ -5865,6 +5873,36 @@ static void gfx_v11_0_set_compute_eop_interrupt_state(struct amdgpu_device *adev
 	}
 }
 
+#define CP_ME1_PIPE_INST_ADDR_INTERVAL  0x1
+#define SET_ECC_ME_PIPE_STATE(reg_addr, state) \
+	do { \
+		uint32_t tmp = RREG32_SOC15_IP(GC, reg_addr); \
+		tmp = REG_SET_FIELD(tmp, CP_ME1_PIPE0_INT_CNTL, CP_ECC_ERROR_INT_ENABLE, state); \
+		WREG32_SOC15_IP(GC, reg_addr, tmp); \
+	} while (0)
+
+static int gfx_v11_0_set_cp_ecc_error_state(struct amdgpu_device *adev,
+							struct amdgpu_irq_src *source,
+							unsigned type,
+							enum amdgpu_interrupt_state state)
+{
+	uint32_t ecc_irq_state = 0;
+	uint32_t pipe0_int_cntl_addr = 0;
+	int i = 0;
+
+	ecc_irq_state = (state == AMDGPU_IRQ_STATE_ENABLE) ? 1 : 0;
+
+	pipe0_int_cntl_addr = SOC15_REG_OFFSET(GC, 0, regCP_ME1_PIPE0_INT_CNTL);
+
+	WREG32_FIELD15_PREREG(GC, 0, CP_INT_CNTL_RING0, CP_ECC_ERROR_INT_ENABLE, ecc_irq_state);
+
+	for (i = 0; i < adev->gfx.mec.num_pipe_per_mec; i++)
+		SET_ECC_ME_PIPE_STATE(pipe0_int_cntl_addr + i * CP_ME1_PIPE_INST_ADDR_INTERVAL,
+					ecc_irq_state);
+
+	return 0;
+}
+
 static int gfx_v11_0_set_eop_interrupt_state(struct amdgpu_device *adev,
 					    struct amdgpu_irq_src *src,
 					    unsigned type,
@@ -6281,6 +6319,11 @@ static const struct amdgpu_irq_src_funcs gfx_v11_0_priv_inst_irq_funcs = {
 	.process = gfx_v11_0_priv_inst_irq,
 };
 
+static const struct amdgpu_irq_src_funcs gfx_v11_0_cp_ecc_error_irq_funcs = {
+	.set = gfx_v11_0_set_cp_ecc_error_state,
+	.process = amdgpu_gfx_cp_ecc_error_irq,
+};
+
 static const struct amdgpu_irq_src_funcs gfx_v11_0_rlc_gc_fed_irq_funcs = {
 	.process = gfx_v11_0_rlc_gc_fed_irq,
 };
@@ -6296,8 +6339,12 @@ static void gfx_v11_0_set_irq_funcs(struct amdgpu_device *adev)
 	adev->gfx.priv_inst_irq.num_types = 1;
 	adev->gfx.priv_inst_irq.funcs = &gfx_v11_0_priv_inst_irq_funcs;
 
+	adev->gfx.cp_ecc_error_irq.num_types = 1; /* CP ECC error */
+	adev->gfx.cp_ecc_error_irq.funcs = &gfx_v11_0_cp_ecc_error_irq_funcs;
+
 	adev->gfx.rlc_gc_fed_irq.num_types = 1; /* 0x80 FED error */
 	adev->gfx.rlc_gc_fed_irq.funcs = &gfx_v11_0_rlc_gc_fed_irq_funcs;
+
 }
 
 static void gfx_v11_0_set_imu_funcs(struct amdgpu_device *adev)
-- 
2.25.1

