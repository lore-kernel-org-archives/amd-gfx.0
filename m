Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0645AC76196
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Mar 2023 22:45:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A72610F342;
	Fri, 31 Mar 2023 22:45:00 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1F7910F33D
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Mar 2023 22:44:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8yCGN6PjQVKwZr1zTa+rNxp/SFE8sMiINhV1y1QXQ9I6pe7xdxodViFuiyHZGg/2WQIpfajoc5fy2juHb2emqeyCCinTvvY7OzbFuYZeBayqvO1m0xoz5yjodbiho+sCuY2PniLwi3b3B1FXaZVUIr/M+NSNY1UZqBO/XgrclOXNSP/Rr3kGIl1NU6TlB02zyKWLZe7c9C3VRLj2SFEGEEssynuQqUcVVfWNzhQWrkXikp3pvqXzJyGODZvMzJAZyGNShpcvJqtaY9hbu/jSM4suwRKoyWJJrvQKeKvkuNc/axp92pve6esIM9iQ7x2PTMOD1A0m/LGHQ2UDFMsmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34Wz8aHOsnrB1c7Fy1lvlIG5Uii33lZ9+1Pl0O63K5U=;
 b=BpW+443L0OdQ0D19hiTprkHRloE22r1ij8ju44KbGPnK8K8rB6VDbn7I2Woj0yfTI+sAF3NOOAuq0zUujQCHeGYu9Zy8iSAk7Sy61c5p34jZCr2o/8W8HdNbconCAuwcChtlrX8fOOdnWCV5rL44QZ/qvHGS8rXVg77tTERGnNLYOWBJ7aheyf8dT5xjIJLUvqBusHq8HXtfPG1C3UMIAnzRwRTeeMxc2CP+AU+QQOAobZ3te6Qt8j7XzFFRorOxOEA3XLfJ/3bIqs/ozVEVhoXD/5uf/+K/7CpZxCx0+P11ulxVVm/4GyKdHQr1oxde1JdmCBv1nCZa1HVrRY/8OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34Wz8aHOsnrB1c7Fy1lvlIG5Uii33lZ9+1Pl0O63K5U=;
 b=Sj4EBmXRZ3BgKArgGvrO0b1f5uZ0dOZz5X4vh66xHKs5L8yPtTmbxy/IwfRhquXQU1jtVtD3sG0hLDFN53UG83c627D3gT22lQ2qdQSxvJhBfhdl/UlonWXz+jAnv040JYK9bBkoSMei1D27JAbsT31Cs+9naFjinhv28+MCfwk=
Received: from MW4PR04CA0369.namprd04.prod.outlook.com (2603:10b6:303:81::14)
 by MW4PR12MB7285.namprd12.prod.outlook.com (2603:10b6:303:22e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.23; Fri, 31 Mar
 2023 22:44:45 +0000
Received: from CO1NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::e0) by MW4PR04CA0369.outlook.office365.com
 (2603:10b6:303:81::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Fri, 31 Mar 2023 22:44:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT094.mail.protection.outlook.com (10.13.174.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.15 via Frontend Transport; Fri, 31 Mar 2023 22:44:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 31 Mar
 2023 17:44:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/11] drm/amdgpu: Initialize sdma v4_4_2 ras function
Date: Fri, 31 Mar 2023 18:44:20 -0400
Message-ID: <20230331224425.8755-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230331224425.8755-1-alexander.deucher@amd.com>
References: <20230331224425.8755-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT094:EE_|MW4PR12MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: e74b3114-49f9-4822-790c-08db32398652
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VI++WCfsQxfD3IfexbhN9hSqa8IrXbMh4ug9zcb3TaTGJSYZuHS0dFb7R2XOZoF2mGnZHwUm09B1+u19mHCR0vmH505dFKIswrJgsv0Qs8A7Y3cg5mLo5/CZb5AEfXb02VYoBQ6PJDwtU0+KuBoZmVdqefgb6I0Fw8YX4x2wuJ/bIxW8jHA6rz4Q+2etaqK9LtcrtsLLeS5Ke5NoolVqH5eb2LBDEmRYaGCq1nObSA32fYSE5hkROQ9o6L1Qyvb87KGgJLqAKrbqHB6B04pLXiSWYSeOIRjoH8cQEgm1oLzwCPVX9sHxPIPXTlzOg9/RyVpmgvk9SsxQTXwiCZD+MMWcqNjjE+Njy63ghbZO/bTG1zQMkTP7OAp2BjkvyemQ6/6sH4g4RxeoWyMVbsve3lwnMIUgMpM97RllQL24jw6Ubu3RcpIt7J7ETOrj6xt5HlXTviTKT7eGonb/9tWRONtj0OY690nj/lnymEkdXfYrDw80iM3NFc8BcKjIR9WQJWdZT78nD29ELV5j2ePSlAV0+fq/VRnwUDq7VuWItadLhwjwTLMTOraZjLGHksb5RvamKnUy4t9fC3SAJK/O8SfyK3FqptEicvHEgHURrpcigwJlliJTnguZD+DqWTYMkhkv9qWEpEuU7Fxs9sijfaPDMQhTgPd2jqm/8Fj//e0n/LNl8L6x8UOXBwGoss7AQ74qI/ywxNHkedXgwTxGLSi63RL65KT+VVx+xZoWBD0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(40480700001)(1076003)(16526019)(186003)(6666004)(82310400005)(47076005)(26005)(83380400001)(82740400003)(2616005)(336012)(426003)(40460700003)(478600001)(70586007)(41300700001)(70206006)(316002)(4326008)(6916009)(8676002)(356005)(81166007)(2906002)(36756003)(7696005)(86362001)(5660300002)(8936002)(36860700001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 22:44:44.9571 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e74b3114-49f9-4822-790c-08db32398652
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7285
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Initialize sdma v4_4_2 ras function and interrupt
handler.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 48 +++++++++++++++++++-----
 1 file changed, 39 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index f0333822df78..570ea68c521f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -54,6 +54,7 @@ static void sdma_v4_4_2_set_ring_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_set_buffer_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_set_vm_pte_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_set_irq_funcs(struct amdgpu_device *adev);
+static void sdma_v4_4_2_set_ras_funcs(struct amdgpu_device *adev);
 
 static u32 sdma_v4_4_2_get_reg_offset(struct amdgpu_device *adev,
 		u32 instance, u32 offset)
@@ -1254,6 +1255,7 @@ static int sdma_v4_4_2_early_init(void *handle)
 	sdma_v4_4_2_set_buffer_funcs(adev);
 	sdma_v4_4_2_set_vm_pte_funcs(adev);
 	sdma_v4_4_2_set_irq_funcs(adev);
+	sdma_v4_4_2_set_ras_funcs(adev);
 
 	return 0;
 }
@@ -1377,6 +1379,11 @@ static int sdma_v4_4_2_sw_init(void *handle)
 		}
 	}
 
+	if (amdgpu_sdma_ras_sw_init(adev)) {
+		dev_err(adev->dev, "fail to initialize sdma ras block\n");
+		return -EINVAL;
+	}
+
 	return r;
 }
 
@@ -1558,7 +1565,7 @@ static int sdma_v4_4_2_process_ras_data_cb(struct amdgpu_device *adev,
 	 * be disabled and the driver should only look for the aggregated
 	 * interrupt via sync flood
 	 */
-	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA))
 		goto out;
 
 	instance = sdma_v4_4_2_irq_id_to_seq(entry->client_id);
@@ -1597,15 +1604,22 @@ static int sdma_v4_4_2_set_ecc_irq_state(struct amdgpu_device *adev,
 					unsigned type,
 					enum amdgpu_interrupt_state state)
 {
-	u32 sdma_edc_config;
+	u32 sdma_cntl;
 
-	sdma_edc_config = RREG32_SDMA(type, regCC_SDMA_EDC_CONFIG);
-	/*
-	 * FIXME: This was inherited from Aldebaran, but no this field
-	 * definition in the regspec of both Aldebaran and SDMA 4.4.2
-	 */
-	sdma_edc_config |= (state == AMDGPU_IRQ_STATE_ENABLE) ? (1 << 2) : 0;
-	WREG32_SDMA(type, regCC_SDMA_EDC_CONFIG, sdma_edc_config);
+	sdma_cntl = RREG32_SDMA(type, regSDMA_CNTL);
+	switch (state) {
+	case AMDGPU_IRQ_STATE_DISABLE:
+		sdma_cntl = REG_SET_FIELD(sdma_cntl, SDMA_CNTL,
+					  DRAM_ECC_INT_ENABLE, 0);
+		WREG32_SDMA(type, regSDMA_CNTL, sdma_cntl);
+		break;
+	/* sdma ecc interrupt is enabled by default
+	 * driver doesn't need to do anything to
+	 * enable the interrupt */
+	case AMDGPU_IRQ_STATE_ENABLE:
+	default:
+		break;
+	}
 
 	return 0;
 }
@@ -2158,3 +2172,19 @@ static void sdma_v4_4_2_reset_ras_error_count(struct amdgpu_device *adev)
 		dev_warn(adev->dev, "SDMA RAS is not supported\n");
 	}
 }
+
+static const struct amdgpu_ras_block_hw_ops sdma_v4_4_2_ras_hw_ops = {
+	.query_ras_error_count = sdma_v4_4_2_query_ras_error_count,
+	.reset_ras_error_count = sdma_v4_4_2_reset_ras_error_count,
+};
+
+static struct amdgpu_sdma_ras sdma_v4_4_2_ras = {
+	.ras_block = {
+		.hw_ops = &sdma_v4_4_2_ras_hw_ops,
+	},
+};
+
+static void sdma_v4_4_2_set_ras_funcs(struct amdgpu_device *adev)
+{
+	adev->sdma.ras = &sdma_v4_4_2_ras;
+}
-- 
2.39.2

