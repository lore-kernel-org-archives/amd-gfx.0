Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F1DEC2BB3F
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Nov 2023 02:47:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A35710E2A1;
	Thu, 16 Nov 2023 02:47:58 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C945C10E262
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Nov 2023 02:47:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4CO3fl19klL2JChXE9mr7lYYeRTpgIFT6Ie9w8RddRdLgfwPKA8ReFKG/MmrwaWbwZ104XbG5YEJS2gjat2zH29lDyQE6xWzUrHJDrM3sdZZg62c3w8EFDzKIpBQ0z39/SeA7LpM3fSyS11g4K/CEqYfHTPn+Z1wybm1HXd1XXqVIgmhNBgnbOjIUej4saovKwkUeGuJMAVpShY/Usg93M2T/vvklOTgWM4+VL39YtRkIuQOmqJv6vCRJUY+p/X157633cva/VfkXHQLP2CaHiT7uIMUkcDQ063b+O6rf7CuvceOKd74dxo6+Wn0q4+pw/7eBG0OCNeEq98MdMcgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zQIUD60D/F2e8lv46BqUaAxg4SxKQ3LY1NDO9AN1iI=;
 b=HDZbpZRadYTCSKd68xSl850DroWGY7zbKra032xtaVH4bUEDhrO4za0l/PhmRqWXWG9rpTMvGXC13vM/YOpyvRWUAUhKozmoEag11Ddju60gM3LIPfAMpfc6jjXuSAdMQ9S5cpdINNRhMQJPrM3SpUun+Mj0pbXB7rj9ZLpLUH5r6qsEnOHFVS6kaciOQ1M29kkut0ExJ5YIxO5E/d18xxn1kpHX+NGkpIFW4pmtQBPHITobEV7QqxVK3Fz5BRIiofhiXsVE8FhsEhKVmRezoxWZQIEt9nsrB3Io/BoDzsNpoEIRtfSZB+jcXTbVzRHDmF/+ebB4tP1i9zfZgw50fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zQIUD60D/F2e8lv46BqUaAxg4SxKQ3LY1NDO9AN1iI=;
 b=cdpdiV0LGOhxSEjA/rn+GrmuAIeue0pazdYu/t4TMB1oJfk3h7RnSfnWuWVylzLu1YJiLR7zMW5cIIkNXSITaqIAzuK6982H/AwZ+tTVJxrvUNNNwNpanDMcCVLCQvcAB+TAoQ8XyIfHhPT5huepotxZA+nFyQ2RpseJepCLsJ8=
Received: from CY5PR14CA0018.namprd14.prod.outlook.com (2603:10b6:930:2::18)
 by IA1PR12MB6529.namprd12.prod.outlook.com (2603:10b6:208:3a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 02:47:48 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:2:cafe::2b) by CY5PR14CA0018.outlook.office365.com
 (2603:10b6:930:2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21 via Frontend
 Transport; Thu, 16 Nov 2023 02:47:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Thu, 16 Nov 2023 02:47:48 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 20:47:41 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/6] drm/amdgpu: update lsdma headers
Date: Thu, 16 Nov 2023 10:47:00 +0800
Message-ID: <20231116024703.2838690-4-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231116024703.2838690-1-yifan1.zhang@amd.com>
References: <20231116024703.2838690-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|IA1PR12MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: 69903dac-b82a-413a-0157-08dbe64e6b20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CehA4+AsXvwWImyDjWtqS3zs5v7MvKtD78dQirjFYpHD8JPTxzn9XmMs7i8tdce1sLAMOwINkyZYKbDed6LAKR+gGypFT+cDr38E4ZsQ1sUnXMXpToPdlwibOg7S4ePnypxCjQ1CCiWQSG5L1g9oFbbt9l+rHHgtZgZZtL6YHJxc1fX/jzzycLr8hxFoGa7DWBwDtFs1UcdhAZ2GqXNFoo7DxSEyMlJIa2xhzSXSO78MgQOn4LEgGR/GoT7riLzVsHFJQgPUirKzkXt2gDR5HxayiYoUyoaOh9OeDQih/WcWl9Ouw3eHxQFlCZTDe1/B4QvVKIMr7viRSo0URdlOLjr1bqDtcXlmThdf/h2M61nhgmkIf1A81rwBqelVM2NVlj7r5ANUTyLqOyb0OgGrkOVTvIEHjxL9QH57QYI03wR7B4xAc5tEfqvZZkqhn2J0wlF78kj7iveE2LRJ7XdIao5uRck4CNkepS1NTI+PW002LZkiU/EM6tLN5LqQYvPP0A2AkbnYRGmqjTtaiyLEBK7EEW/PVxjofAFScglZHw443RyuG68gtAuhxfVyrhQLbLEInzWGq1TxedxM6dVe3qYBd2+FOWsbSkmdd8I931MB4QgpffiGEfz04VudCcjWFCce9fGanVRgYAGA55IZsz//KC6r6wJ+3cGTWcjeItLqYvIxiBmMqkMeV+ru8rJvGgAq/71NGEOT8CBjgXUyQ4pG7smag5YLxPQ/92JvIqRg6zHi/RoOaVjuyx1K0as0d3uH2o5hWqf9ZUE5oXt4rQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(82310400011)(1800799009)(64100799003)(186009)(451199024)(36840700001)(40470700004)(46966006)(15650500001)(30864003)(40480700001)(2906002)(36860700001)(41300700001)(8936002)(316002)(54906003)(6916009)(1076003)(36756003)(4326008)(8676002)(70586007)(70206006)(478600001)(47076005)(81166007)(86362001)(5660300002)(356005)(7696005)(83380400001)(40460700003)(82740400003)(426003)(336012)(26005)(16526019)(2616005)(6666004)(36900700001)(579004)(559001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 02:47:48.0748 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69903dac-b82a-413a-0157-08dbe64e6b20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
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
Cc: Tim.Huang@amd.com, Xiaojian.Du@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 Alexander.Deucher@amd.com, Lang.Yu@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to update lsdma headers.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
---
 .../asic_reg/lsdma/lsdma_6_0_0_offset.h       |  48 ++
 .../asic_reg/lsdma/lsdma_6_0_0_sh_mask.h      | 452 ++++++++++++++++++
 2 files changed, 500 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_6_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_6_0_0_offset.h
index af560359e340..45d43a82a0fa 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_6_0_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_6_0_0_offset.h
@@ -31,10 +31,46 @@
 #define regLSDMA_UCODE_ADDR_BASE_IDX                                                                    0
 #define regLSDMA_UCODE_DATA                                                                             0x0001
 #define regLSDMA_UCODE_DATA_BASE_IDX                                                                    0
+#define regLSDMA_MMHUB_CNTL                                                                             0x0002
+#define regLSDMA_MMHUB_CNTL_BASE_IDX                                                                    0
+#define regLSDMA_MMHUB_TRUSTLVL                                                                         0x0003
+#define regLSDMA_MMHUB_TRUSTLVL_BASE_IDX                                                                0
 #define regLSDMA_ERROR_INJECT_CNTL                                                                      0x0004
 #define regLSDMA_ERROR_INJECT_CNTL_BASE_IDX                                                             0
 #define regLSDMA_ERROR_INJECT_SELECT                                                                    0x0005
 #define regLSDMA_ERROR_INJECT_SELECT_BASE_IDX                                                           0
+#define regLSDMA_REGISTER_SECURITY_CNTL                                                                 0x000f
+#define regLSDMA_REGISTER_SECURITY_CNTL_BASE_IDX                                                        0
+#define regLSDMA_VM_CNTL                                                                                0x0010
+#define regLSDMA_VM_CNTL_BASE_IDX                                                                       0
+#define regLSDMA_VM_CTX_LO                                                                              0x0011
+#define regLSDMA_VM_CTX_LO_BASE_IDX                                                                     0
+#define regLSDMA_VM_CTX_HI                                                                              0x0012
+#define regLSDMA_VM_CTX_HI_BASE_IDX                                                                     0
+#define regLSDMA_ACTIVE_FCN_ID                                                                          0x0013
+#define regLSDMA_ACTIVE_FCN_ID_BASE_IDX                                                                 0
+#define regLSDMA_VM_CTX_CNTL                                                                            0x0014
+#define regLSDMA_VM_CTX_CNTL_BASE_IDX                                                                   0
+#define regLSDMA_VIRT_RESET_REQ                                                                         0x0015
+#define regLSDMA_VIRT_RESET_REQ_BASE_IDX                                                                0
+#define regLSDMA_VF_ENABLE                                                                              0x0016
+#define regLSDMA_VF_ENABLE_BASE_IDX                                                                     0
+#define regLSDMA_CONTEXT_REG_TYPE0                                                                      0x0017
+#define regLSDMA_CONTEXT_REG_TYPE0_BASE_IDX                                                             0
+#define regLSDMA_CONTEXT_REG_TYPE1                                                                      0x0018
+#define regLSDMA_CONTEXT_REG_TYPE1_BASE_IDX                                                             0
+#define regLSDMA_CONTEXT_REG_TYPE2                                                                      0x0019
+#define regLSDMA_CONTEXT_REG_TYPE2_BASE_IDX                                                             0
+#define regLSDMA_CONTEXT_REG_TYPE3                                                                      0x001a
+#define regLSDMA_CONTEXT_REG_TYPE3_BASE_IDX                                                             0
+#define regLSDMA_PUB_REG_TYPE0                                                                          0x001b
+#define regLSDMA_PUB_REG_TYPE0_BASE_IDX                                                                 0
+#define regLSDMA_PUB_REG_TYPE1                                                                          0x001c
+#define regLSDMA_PUB_REG_TYPE1_BASE_IDX                                                                 0
+#define regLSDMA_PUB_REG_TYPE2                                                                          0x001d
+#define regLSDMA_PUB_REG_TYPE2_BASE_IDX                                                                 0
+#define regLSDMA_PUB_REG_TYPE3                                                                          0x001e
+#define regLSDMA_PUB_REG_TYPE3_BASE_IDX                                                                 0
 #define regLSDMA_CONTEXT_GROUP_BOUNDARY                                                                 0x001f
 #define regLSDMA_CONTEXT_GROUP_BOUNDARY_BASE_IDX                                                        0
 #define regLSDMA_RB_RPTR_FETCH_HI                                                                       0x0020
@@ -57,6 +93,8 @@
 #define regLSDMA_HBM_PAGE_CONFIG_BASE_IDX                                                               0
 #define regLSDMA_UCODE_CHECKSUM                                                                         0x0029
 #define regLSDMA_UCODE_CHECKSUM_BASE_IDX                                                                0
+#define regLSDMA_F32_CNTL                                                                               0x002a
+#define regLSDMA_F32_CNTL_BASE_IDX                                                                      0
 #define regLSDMA_FREEZE                                                                                 0x002b
 #define regLSDMA_FREEZE_BASE_IDX                                                                        0
 #define regLSDMA_PF_PIO_STATUS                                                                          0x002c
@@ -155,18 +193,28 @@
 #define regLSDMA_PERFCNT_PERFCOUNTER_HI_BASE_IDX                                                        0
 #define regLSDMA_CRD_CNTL                                                                               0x005d
 #define regLSDMA_CRD_CNTL_BASE_IDX                                                                      0
+#define regLSDMA_GPU_IOV_VIOLATION_LOG                                                                  0x005e
+#define regLSDMA_GPU_IOV_VIOLATION_LOG_BASE_IDX                                                         0
 #define regLSDMA_ULV_CNTL                                                                               0x005f
 #define regLSDMA_ULV_CNTL_BASE_IDX                                                                      0
 #define regLSDMA_EA_DBIT_ADDR_DATA                                                                      0x0060
 #define regLSDMA_EA_DBIT_ADDR_DATA_BASE_IDX                                                             0
 #define regLSDMA_EA_DBIT_ADDR_INDEX                                                                     0x0061
 #define regLSDMA_EA_DBIT_ADDR_INDEX_BASE_IDX                                                            0
+#define regLSDMA_GPU_IOV_VIOLATION_LOG2                                                                 0x0062
+#define regLSDMA_GPU_IOV_VIOLATION_LOG2_BASE_IDX                                                        0
 #define regLSDMA_STATUS4_REG                                                                            0x0063
 #define regLSDMA_STATUS4_REG_BASE_IDX                                                                   0
+#define regLSDMA_SCRATCH_RAM_DATA                                                                       0x0064
+#define regLSDMA_SCRATCH_RAM_DATA_BASE_IDX                                                              0
+#define regLSDMA_SCRATCH_RAM_ADDR                                                                       0x0065
+#define regLSDMA_SCRATCH_RAM_ADDR_BASE_IDX                                                              0
 #define regLSDMA_CE_CTRL                                                                                0x0066
 #define regLSDMA_CE_CTRL_BASE_IDX                                                                       0
 #define regLSDMA_EXCEPTION_STATUS                                                                       0x0067
 #define regLSDMA_EXCEPTION_STATUS_BASE_IDX                                                              0
+#define regLSDMA_CLK_STATUS                                                                             0x0068
+#define regLSDMA_CLK_STATUS_BASE_IDX                                                                    0
 #define regLSDMA_PIO_SRC_ADDR_LO                                                                        0x0069
 #define regLSDMA_PIO_SRC_ADDR_LO_BASE_IDX                                                               0
 #define regLSDMA_PIO_SRC_ADDR_HI                                                                        0x006a
diff --git a/drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_6_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_6_0_0_sh_mask.h
index d1324239b751..bf2416f2500c 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_6_0_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_6_0_0_sh_mask.h
@@ -31,6 +31,26 @@
 //LSDMA_UCODE_DATA
 #define LSDMA_UCODE_DATA__VALUE__SHIFT                                                                        0x0
 #define LSDMA_UCODE_DATA__VALUE_MASK                                                                          0xFFFFFFFFL
+//LSDMA_MMHUB_CNTL
+#define LSDMA_MMHUB_CNTL__UNIT_ID__SHIFT                                                                      0x0
+#define LSDMA_MMHUB_CNTL__UNIT_ID_MASK                                                                        0x0000003FL
+//LSDMA_MMHUB_TRUSTLVL
+#define LSDMA_MMHUB_TRUSTLVL__SECFLAG0__SHIFT                                                                 0x0
+#define LSDMA_MMHUB_TRUSTLVL__SECFLAG1__SHIFT                                                                 0x4
+#define LSDMA_MMHUB_TRUSTLVL__SECFLAG2__SHIFT                                                                 0x8
+#define LSDMA_MMHUB_TRUSTLVL__SECFLAG3__SHIFT                                                                 0xc
+#define LSDMA_MMHUB_TRUSTLVL__SECFLAG4__SHIFT                                                                 0x10
+#define LSDMA_MMHUB_TRUSTLVL__SECFLAG5__SHIFT                                                                 0x14
+#define LSDMA_MMHUB_TRUSTLVL__SECFLAG6__SHIFT                                                                 0x18
+#define LSDMA_MMHUB_TRUSTLVL__SECFLAG7__SHIFT                                                                 0x1c
+#define LSDMA_MMHUB_TRUSTLVL__SECFLAG0_MASK                                                                   0x0000000FL
+#define LSDMA_MMHUB_TRUSTLVL__SECFLAG1_MASK                                                                   0x000000F0L
+#define LSDMA_MMHUB_TRUSTLVL__SECFLAG2_MASK                                                                   0x00000F00L
+#define LSDMA_MMHUB_TRUSTLVL__SECFLAG3_MASK                                                                   0x0000F000L
+#define LSDMA_MMHUB_TRUSTLVL__SECFLAG4_MASK                                                                   0x000F0000L
+#define LSDMA_MMHUB_TRUSTLVL__SECFLAG5_MASK                                                                   0x00F00000L
+#define LSDMA_MMHUB_TRUSTLVL__SECFLAG6_MASK                                                                   0x0F000000L
+#define LSDMA_MMHUB_TRUSTLVL__SECFLAG7_MASK                                                                   0xF0000000L
 //LSDMA_ERROR_INJECT_CNTL
 #define LSDMA_ERROR_INJECT_CNTL__ENABLE_IRRITATION__SHIFT                                                     0x0
 #define LSDMA_ERROR_INJECT_CNTL__ENABLE_SINGLE_WRITE__SHIFT                                                   0x1
@@ -91,12 +111,382 @@
 #define LSDMA_ERROR_INJECT_SELECT__SPLIT_DATA_FIFO_MASK                                                       0x00800000L
 #define LSDMA_ERROR_INJECT_SELECT__MC_WR_ADDR_FIFO_MASK                                                       0x01000000L
 #define LSDMA_ERROR_INJECT_SELECT__MC_RDRET_BUF_MASK                                                          0x02000000L
+//LSDMA_REGISTER_SECURITY_CNTL
+#define LSDMA_REGISTER_SECURITY_CNTL__ENABLE__SHIFT                                                           0x0
+#define LSDMA_REGISTER_SECURITY_CNTL__SCRATCH_RAM_WRITE_ENABLE__SHIFT                                         0x1
+#define LSDMA_REGISTER_SECURITY_CNTL__ENABLE_MASK                                                             0x00000001L
+#define LSDMA_REGISTER_SECURITY_CNTL__SCRATCH_RAM_WRITE_ENABLE_MASK                                           0x00000002L
+//LSDMA_VM_CNTL
+#define LSDMA_VM_CNTL__CMD__SHIFT                                                                             0x0
+#define LSDMA_VM_CNTL__CMD_MASK                                                                               0x0000000FL
+//LSDMA_VM_CTX_LO
+#define LSDMA_VM_CTX_LO__ADDR__SHIFT                                                                          0x2
+#define LSDMA_VM_CTX_LO__ADDR_MASK                                                                            0xFFFFFFFCL
+//LSDMA_VM_CTX_HI
+#define LSDMA_VM_CTX_HI__ADDR__SHIFT                                                                          0x0
+#define LSDMA_VM_CTX_HI__ADDR_MASK                                                                            0xFFFFFFFFL
+//LSDMA_ACTIVE_FCN_ID
+#define LSDMA_ACTIVE_FCN_ID__VFID__SHIFT                                                                      0x0
+#define LSDMA_ACTIVE_FCN_ID__RESERVED__SHIFT                                                                  0x4
+#define LSDMA_ACTIVE_FCN_ID__VF__SHIFT                                                                        0x1f
+#define LSDMA_ACTIVE_FCN_ID__VFID_MASK                                                                        0x0000000FL
+#define LSDMA_ACTIVE_FCN_ID__RESERVED_MASK                                                                    0x7FFFFFF0L
+#define LSDMA_ACTIVE_FCN_ID__VF_MASK                                                                          0x80000000L
+//LSDMA_VM_CTX_CNTL
+#define LSDMA_VM_CTX_CNTL__PRIV__SHIFT                                                                        0x0
+#define LSDMA_VM_CTX_CNTL__VMID__SHIFT                                                                        0x4
+#define LSDMA_VM_CTX_CNTL__PRIV_MASK                                                                          0x00000001L
+#define LSDMA_VM_CTX_CNTL__VMID_MASK                                                                          0x000000F0L
+//LSDMA_VIRT_RESET_REQ
+#define LSDMA_VIRT_RESET_REQ__VF__SHIFT                                                                       0x0
+#define LSDMA_VIRT_RESET_REQ__PF__SHIFT                                                                       0x1f
+#define LSDMA_VIRT_RESET_REQ__VF_MASK                                                                         0x0000FFFFL
+#define LSDMA_VIRT_RESET_REQ__PF_MASK                                                                         0x80000000L
+//LSDMA_VF_ENABLE
+#define LSDMA_VF_ENABLE__VF_ENABLE__SHIFT                                                                     0x0
+#define LSDMA_VF_ENABLE__VF_ENABLE_MASK                                                                       0x00000001L
+//LSDMA_CONTEXT_REG_TYPE0
+#define LSDMA_CONTEXT_REG_TYPE0__LSDMA_QUEUE0_RB_CNTL__SHIFT                                                  0x0
+#define LSDMA_CONTEXT_REG_TYPE0__LSDMA_QUEUE0_RB_BASE__SHIFT                                                  0x1
+#define LSDMA_CONTEXT_REG_TYPE0__LSDMA_QUEUE0_RB_BASE_HI__SHIFT                                               0x2
+#define LSDMA_CONTEXT_REG_TYPE0__LSDMA_QUEUE0_RB_RPTR__SHIFT                                                  0x3
+#define LSDMA_CONTEXT_REG_TYPE0__LSDMA_QUEUE0_RB_RPTR_HI__SHIFT                                               0x4
+#define LSDMA_CONTEXT_REG_TYPE0__LSDMA_QUEUE0_RB_WPTR__SHIFT                                                  0x5
+#define LSDMA_CONTEXT_REG_TYPE0__LSDMA_QUEUE0_RB_WPTR_HI__SHIFT                                               0x6
+#define LSDMA_CONTEXT_REG_TYPE0__LSDMA_QUEUE0_RB_WPTR_POLL_CNTL__SHIFT                                        0x7
+#define LSDMA_CONTEXT_REG_TYPE0__LSDMA_QUEUE0_RB_RPTR_ADDR_HI__SHIFT                                          0x8
+#define LSDMA_CONTEXT_REG_TYPE0__LSDMA_QUEUE0_RB_RPTR_ADDR_LO__SHIFT                                          0x9
+#define LSDMA_CONTEXT_REG_TYPE0__LSDMA_QUEUE0_IB_CNTL__SHIFT                                                  0xa
+#define LSDMA_CONTEXT_REG_TYPE0__LSDMA_QUEUE0_IB_RPTR__SHIFT                                                  0xb
+#define LSDMA_CONTEXT_REG_TYPE0__LSDMA_QUEUE0_IB_OFFSET__SHIFT                                                0xc
+#define LSDMA_CONTEXT_REG_TYPE0__LSDMA_QUEUE0_IB_BASE_LO__SHIFT                                               0xd
+#define LSDMA_CONTEXT_REG_TYPE0__LSDMA_QUEUE0_IB_BASE_HI__SHIFT                                               0xe
+#define LSDMA_CONTEXT_REG_TYPE0__LSDMA_QUEUE0_IB_SIZE__SHIFT                                                  0xf
+#define LSDMA_CONTEXT_REG_TYPE0__LSDMA_QUEUE0_SKIP_CNTL__SHIFT                                                0x10
+#define LSDMA_CONTEXT_REG_TYPE0__LSDMA_QUEUE0_CONTEXT_STATUS__SHIFT                                           0x11
+#define LSDMA_CONTEXT_REG_TYPE0__LSDMA_QUEUE0_DOORBELL__SHIFT                                                 0x12
+#define LSDMA_CONTEXT_REG_TYPE0__RESERVED19__SHIFT                                                            0x13
+#define LSDMA_CONTEXT_REG_TYPE0__RESERVED31_20__SHIFT                                                         0x14
+#define LSDMA_CONTEXT_REG_TYPE0__LSDMA_QUEUE0_RB_CNTL_MASK                                                    0x00000001L
+#define LSDMA_CONTEXT_REG_TYPE0__LSDMA_QUEUE0_RB_BASE_MASK                                                    0x00000002L
+#define LSDMA_CONTEXT_REG_TYPE0__LSDMA_QUEUE0_RB_BASE_HI_MASK                                                 0x00000004L
+#define LSDMA_CONTEXT_REG_TYPE0__LSDMA_QUEUE0_RB_RPTR_MASK                                                    0x00000008L
+#define LSDMA_CONTEXT_REG_TYPE0__LSDMA_QUEUE0_RB_RPTR_HI_MASK                                                 0x00000010L
+#define LSDMA_CONTEXT_REG_TYPE0__LSDMA_QUEUE0_RB_WPTR_MASK                                                    0x00000020L
+#define LSDMA_CONTEXT_REG_TYPE0__LSDMA_QUEUE0_RB_WPTR_HI_MASK                                                 0x00000040L
+#define LSDMA_CONTEXT_REG_TYPE0__LSDMA_QUEUE0_RB_WPTR_POLL_CNTL_MASK                                          0x00000080L
+#define LSDMA_CONTEXT_REG_TYPE0__LSDMA_QUEUE0_RB_RPTR_ADDR_HI_MASK                                            0x00000100L
+#define LSDMA_CONTEXT_REG_TYPE0__LSDMA_QUEUE0_RB_RPTR_ADDR_LO_MASK                                            0x00000200L
+#define LSDMA_CONTEXT_REG_TYPE0__LSDMA_QUEUE0_IB_CNTL_MASK                                                    0x00000400L
+#define LSDMA_CONTEXT_REG_TYPE0__LSDMA_QUEUE0_IB_RPTR_MASK                                                    0x00000800L
+#define LSDMA_CONTEXT_REG_TYPE0__LSDMA_QUEUE0_IB_OFFSET_MASK                                                  0x00001000L
+#define LSDMA_CONTEXT_REG_TYPE0__LSDMA_QUEUE0_IB_BASE_LO_MASK                                                 0x00002000L
+#define LSDMA_CONTEXT_REG_TYPE0__LSDMA_QUEUE0_IB_BASE_HI_MASK                                                 0x00004000L
+#define LSDMA_CONTEXT_REG_TYPE0__LSDMA_QUEUE0_IB_SIZE_MASK                                                    0x00008000L
+#define LSDMA_CONTEXT_REG_TYPE0__LSDMA_QUEUE0_SKIP_CNTL_MASK                                                  0x00010000L
+#define LSDMA_CONTEXT_REG_TYPE0__LSDMA_QUEUE0_CONTEXT_STATUS_MASK                                             0x00020000L
+#define LSDMA_CONTEXT_REG_TYPE0__LSDMA_QUEUE0_DOORBELL_MASK                                                   0x00040000L
+#define LSDMA_CONTEXT_REG_TYPE0__RESERVED19_MASK                                                              0x00080000L
+#define LSDMA_CONTEXT_REG_TYPE0__RESERVED31_20_MASK                                                           0xFFF00000L
+//LSDMA_CONTEXT_REG_TYPE1
+#define LSDMA_CONTEXT_REG_TYPE1__RESERVED7_0__SHIFT                                                           0x0
+#define LSDMA_CONTEXT_REG_TYPE1__LSDMA_QUEUE0_STATUS__SHIFT                                                   0x8
+#define LSDMA_CONTEXT_REG_TYPE1__LSDMA_QUEUE0_DOORBELL_LOG__SHIFT                                             0x9
+#define LSDMA_CONTEXT_REG_TYPE1__LSDMA_QUEUE0_WATERMARK__SHIFT                                                0xa
+#define LSDMA_CONTEXT_REG_TYPE1__LSDMA_QUEUE0_DOORBELL_OFFSET__SHIFT                                          0xb
+#define LSDMA_CONTEXT_REG_TYPE1__LSDMA_QUEUE0_CSA_ADDR_LO__SHIFT                                              0xc
+#define LSDMA_CONTEXT_REG_TYPE1__LSDMA_QUEUE0_CSA_ADDR_HI__SHIFT                                              0xd
+#define LSDMA_CONTEXT_REG_TYPE1__LSDMA_QUEUE0_RB_PREEMPT__SHIFT                                               0xe
+#define LSDMA_CONTEXT_REG_TYPE1__LSDMA_QUEUE0_IB_SUB_REMAIN__SHIFT                                            0xf
+#define LSDMA_CONTEXT_REG_TYPE1__LSDMA_QUEUE0_PREEMPT__SHIFT                                                  0x10
+#define LSDMA_CONTEXT_REG_TYPE1__LSDMA_QUEUE0_DUMMY0__SHIFT                                                   0x11
+#define LSDMA_CONTEXT_REG_TYPE1__LSDMA_QUEUE0_RB_WPTR_POLL_ADDR_HI__SHIFT                                     0x12
+#define LSDMA_CONTEXT_REG_TYPE1__LSDMA_QUEUE0_RB_WPTR_POLL_ADDR_LO__SHIFT                                     0x13
+#define LSDMA_CONTEXT_REG_TYPE1__LSDMA_QUEUE0_RB_AQL_CNTL__SHIFT                                              0x14
+#define LSDMA_CONTEXT_REG_TYPE1__LSDMA_QUEUE0_MINOR_PTR_UPDATE__SHIFT                                         0x15
+#define LSDMA_CONTEXT_REG_TYPE1__LSDMA_QUEUE0_CNTL__SHIFT                                                     0x16
+#define LSDMA_CONTEXT_REG_TYPE1__RESERVED_23_23__SHIFT                                                        0x17
+#define LSDMA_CONTEXT_REG_TYPE1__LSDMA_QUEUE0_DUMMY1__SHIFT                                                   0x18
+#define LSDMA_CONTEXT_REG_TYPE1__LSDMA_QUEUE0_DUMMY2__SHIFT                                                   0x19
+#define LSDMA_CONTEXT_REG_TYPE1__RESERVED__SHIFT                                                              0x1a
+#define LSDMA_CONTEXT_REG_TYPE1__RESERVED7_0_MASK                                                             0x000000FFL
+#define LSDMA_CONTEXT_REG_TYPE1__LSDMA_QUEUE0_STATUS_MASK                                                     0x00000100L
+#define LSDMA_CONTEXT_REG_TYPE1__LSDMA_QUEUE0_DOORBELL_LOG_MASK                                               0x00000200L
+#define LSDMA_CONTEXT_REG_TYPE1__LSDMA_QUEUE0_WATERMARK_MASK                                                  0x00000400L
+#define LSDMA_CONTEXT_REG_TYPE1__LSDMA_QUEUE0_DOORBELL_OFFSET_MASK                                            0x00000800L
+#define LSDMA_CONTEXT_REG_TYPE1__LSDMA_QUEUE0_CSA_ADDR_LO_MASK                                                0x00001000L
+#define LSDMA_CONTEXT_REG_TYPE1__LSDMA_QUEUE0_CSA_ADDR_HI_MASK                                                0x00002000L
+#define LSDMA_CONTEXT_REG_TYPE1__LSDMA_QUEUE0_RB_PREEMPT_MASK                                                 0x00004000L
+#define LSDMA_CONTEXT_REG_TYPE1__LSDMA_QUEUE0_IB_SUB_REMAIN_MASK                                              0x00008000L
+#define LSDMA_CONTEXT_REG_TYPE1__LSDMA_QUEUE0_PREEMPT_MASK                                                    0x00010000L
+#define LSDMA_CONTEXT_REG_TYPE1__LSDMA_QUEUE0_DUMMY0_MASK                                                     0x00020000L
+#define LSDMA_CONTEXT_REG_TYPE1__LSDMA_QUEUE0_RB_WPTR_POLL_ADDR_HI_MASK                                       0x00040000L
+#define LSDMA_CONTEXT_REG_TYPE1__LSDMA_QUEUE0_RB_WPTR_POLL_ADDR_LO_MASK                                       0x00080000L
+#define LSDMA_CONTEXT_REG_TYPE1__LSDMA_QUEUE0_RB_AQL_CNTL_MASK                                                0x00100000L
+#define LSDMA_CONTEXT_REG_TYPE1__LSDMA_QUEUE0_MINOR_PTR_UPDATE_MASK                                           0x00200000L
+#define LSDMA_CONTEXT_REG_TYPE1__LSDMA_QUEUE0_CNTL_MASK                                                       0x00400000L
+#define LSDMA_CONTEXT_REG_TYPE1__RESERVED_23_23_MASK                                                          0x00800000L
+#define LSDMA_CONTEXT_REG_TYPE1__LSDMA_QUEUE0_DUMMY1_MASK                                                     0x01000000L
+#define LSDMA_CONTEXT_REG_TYPE1__LSDMA_QUEUE0_DUMMY2_MASK                                                     0x02000000L
+#define LSDMA_CONTEXT_REG_TYPE1__RESERVED_MASK                                                                0xFC000000L
+//LSDMA_CONTEXT_REG_TYPE2
+#define LSDMA_CONTEXT_REG_TYPE2__LSDMA_QUEUE0_MIDCMD_DATA0__SHIFT                                             0x0
+#define LSDMA_CONTEXT_REG_TYPE2__LSDMA_QUEUE0_MIDCMD_DATA1__SHIFT                                             0x1
+#define LSDMA_CONTEXT_REG_TYPE2__LSDMA_QUEUE0_MIDCMD_DATA2__SHIFT                                             0x2
+#define LSDMA_CONTEXT_REG_TYPE2__LSDMA_QUEUE0_MIDCMD_DATA3__SHIFT                                             0x3
+#define LSDMA_CONTEXT_REG_TYPE2__LSDMA_QUEUE0_MIDCMD_DATA4__SHIFT                                             0x4
+#define LSDMA_CONTEXT_REG_TYPE2__LSDMA_QUEUE0_MIDCMD_DATA5__SHIFT                                             0x5
+#define LSDMA_CONTEXT_REG_TYPE2__LSDMA_QUEUE0_MIDCMD_DATA6__SHIFT                                             0x6
+#define LSDMA_CONTEXT_REG_TYPE2__LSDMA_QUEUE0_MIDCMD_DATA7__SHIFT                                             0x7
+#define LSDMA_CONTEXT_REG_TYPE2__LSDMA_QUEUE0_MIDCMD_DATA8__SHIFT                                             0x8
+#define LSDMA_CONTEXT_REG_TYPE2__LSDMA_QUEUE0_MIDCMD_DATA9__SHIFT                                             0x9
+#define LSDMA_CONTEXT_REG_TYPE2__LSDMA_QUEUE0_MIDCMD_DATA10__SHIFT                                            0xa
+#define LSDMA_CONTEXT_REG_TYPE2__LSDMA_QUEUE0_MIDCMD_CNTL__SHIFT                                              0xb
+#define LSDMA_CONTEXT_REG_TYPE2__RESERVED__SHIFT                                                              0xc
+#define LSDMA_CONTEXT_REG_TYPE2__LSDMA_QUEUE0_MIDCMD_DATA0_MASK                                               0x00000001L
+#define LSDMA_CONTEXT_REG_TYPE2__LSDMA_QUEUE0_MIDCMD_DATA1_MASK                                               0x00000002L
+#define LSDMA_CONTEXT_REG_TYPE2__LSDMA_QUEUE0_MIDCMD_DATA2_MASK                                               0x00000004L
+#define LSDMA_CONTEXT_REG_TYPE2__LSDMA_QUEUE0_MIDCMD_DATA3_MASK                                               0x00000008L
+#define LSDMA_CONTEXT_REG_TYPE2__LSDMA_QUEUE0_MIDCMD_DATA4_MASK                                               0x00000010L
+#define LSDMA_CONTEXT_REG_TYPE2__LSDMA_QUEUE0_MIDCMD_DATA5_MASK                                               0x00000020L
+#define LSDMA_CONTEXT_REG_TYPE2__LSDMA_QUEUE0_MIDCMD_DATA6_MASK                                               0x00000040L
+#define LSDMA_CONTEXT_REG_TYPE2__LSDMA_QUEUE0_MIDCMD_DATA7_MASK                                               0x00000080L
+#define LSDMA_CONTEXT_REG_TYPE2__LSDMA_QUEUE0_MIDCMD_DATA8_MASK                                               0x00000100L
+#define LSDMA_CONTEXT_REG_TYPE2__LSDMA_QUEUE0_MIDCMD_DATA9_MASK                                               0x00000200L
+#define LSDMA_CONTEXT_REG_TYPE2__LSDMA_QUEUE0_MIDCMD_DATA10_MASK                                              0x00000400L
+#define LSDMA_CONTEXT_REG_TYPE2__LSDMA_QUEUE0_MIDCMD_CNTL_MASK                                                0x00000800L
+#define LSDMA_CONTEXT_REG_TYPE2__RESERVED_MASK                                                                0xFFFFF000L
+//LSDMA_CONTEXT_REG_TYPE3
+#define LSDMA_CONTEXT_REG_TYPE3__RESERVED__SHIFT                                                              0x0
+#define LSDMA_CONTEXT_REG_TYPE3__RESERVED_MASK                                                                0xFFFFFFFFL
+//LSDMA_PUB_REG_TYPE0
 #define LSDMA_PUB_REG_TYPE0__LSDMA_UCODE_ADDR__SHIFT                                                          0x0
 #define LSDMA_PUB_REG_TYPE0__LSDMA_UCODE_DATA__SHIFT                                                          0x1
+#define LSDMA_PUB_REG_TYPE0__LSDMA_MMHUB_CNTL__SHIFT                                                          0x2
+#define LSDMA_PUB_REG_TYPE0__LSDMA_MMHUB_TRUSTLVL__SHIFT                                                      0x3
+#define LSDMA_PUB_REG_TYPE0__LSDMA_ERROR_INJECT_CNTL__SHIFT                                                   0x4
+#define LSDMA_PUB_REG_TYPE0__LSDMA_ERROR_INJECT_SELECT__SHIFT                                                 0x5
+#define LSDMA_PUB_REG_TYPE0__RESERVED_FOR_PSP_HYPERVISOR_ACCESS_ONLY__SHIFT                                   0x6
+#define LSDMA_PUB_REG_TYPE0__LSDMA_REGISTER_SECURITY_CNTL__SHIFT                                              0xf
+#define LSDMA_PUB_REG_TYPE0__LSDMA_VM_CNTL__SHIFT                                                             0x10
+#define LSDMA_PUB_REG_TYPE0__LSDMA_VM_CTX_LO__SHIFT                                                           0x11
+#define LSDMA_PUB_REG_TYPE0__LSDMA_VM_CTX_HI__SHIFT                                                           0x12
+#define LSDMA_PUB_REG_TYPE0__LSDMA_ACTIVE_FCN_ID__SHIFT                                                       0x13
+#define LSDMA_PUB_REG_TYPE0__LSDMA_VM_CTX_CNTL__SHIFT                                                         0x14
+#define LSDMA_PUB_REG_TYPE0__LSDMA_VIRT_RESET_REQ__SHIFT                                                      0x15
+#define LSDMA_PUB_REG_TYPE0__RESERVED3__SHIFT                                                                 0x16
+#define LSDMA_PUB_REG_TYPE0__LSDMA_CONTEXT_REG_TYPE0__SHIFT                                                   0x17
+#define LSDMA_PUB_REG_TYPE0__LSDMA_CONTEXT_REG_TYPE1__SHIFT                                                   0x18
+#define LSDMA_PUB_REG_TYPE0__LSDMA_CONTEXT_REG_TYPE2__SHIFT                                                   0x19
+#define LSDMA_PUB_REG_TYPE0__LSDMA_CONTEXT_REG_TYPE3__SHIFT                                                   0x1a
+#define LSDMA_PUB_REG_TYPE0__LSDMA_PUB_REG_TYPE0__SHIFT                                                       0x1b
+#define LSDMA_PUB_REG_TYPE0__LSDMA_PUB_REG_TYPE1__SHIFT                                                       0x1c
+#define LSDMA_PUB_REG_TYPE0__LSDMA_PUB_REG_TYPE2__SHIFT                                                       0x1d
+#define LSDMA_PUB_REG_TYPE0__LSDMA_PUB_REG_TYPE3__SHIFT                                                       0x1e
+#define LSDMA_PUB_REG_TYPE0__LSDMA_CONTEXT_GROUP_BOUNDARY__SHIFT                                              0x1f
 #define LSDMA_PUB_REG_TYPE0__LSDMA_UCODE_ADDR_MASK                                                            0x00000001L
 #define LSDMA_PUB_REG_TYPE0__LSDMA_UCODE_DATA_MASK                                                            0x00000002L
+#define LSDMA_PUB_REG_TYPE0__LSDMA_MMHUB_CNTL_MASK                                                            0x00000004L
+#define LSDMA_PUB_REG_TYPE0__LSDMA_MMHUB_TRUSTLVL_MASK                                                        0x00000008L
+#define LSDMA_PUB_REG_TYPE0__LSDMA_ERROR_INJECT_CNTL_MASK                                                     0x00000010L
+#define LSDMA_PUB_REG_TYPE0__LSDMA_ERROR_INJECT_SELECT_MASK                                                   0x00000020L
+#define LSDMA_PUB_REG_TYPE0__RESERVED_FOR_PSP_HYPERVISOR_ACCESS_ONLY_MASK                                     0x00007FC0L
+#define LSDMA_PUB_REG_TYPE0__LSDMA_REGISTER_SECURITY_CNTL_MASK                                                0x00008000L
+#define LSDMA_PUB_REG_TYPE0__LSDMA_VM_CNTL_MASK                                                               0x00010000L
+#define LSDMA_PUB_REG_TYPE0__LSDMA_VM_CTX_LO_MASK                                                             0x00020000L
+#define LSDMA_PUB_REG_TYPE0__LSDMA_VM_CTX_HI_MASK                                                             0x00040000L
+#define LSDMA_PUB_REG_TYPE0__LSDMA_ACTIVE_FCN_ID_MASK                                                         0x00080000L
+#define LSDMA_PUB_REG_TYPE0__LSDMA_VM_CTX_CNTL_MASK                                                           0x00100000L
+#define LSDMA_PUB_REG_TYPE0__LSDMA_VIRT_RESET_REQ_MASK                                                        0x00200000L
+#define LSDMA_PUB_REG_TYPE0__RESERVED3_MASK                                                                   0x00400000L
+#define LSDMA_PUB_REG_TYPE0__LSDMA_CONTEXT_REG_TYPE0_MASK                                                     0x00800000L
+#define LSDMA_PUB_REG_TYPE0__LSDMA_CONTEXT_REG_TYPE1_MASK                                                     0x01000000L
+#define LSDMA_PUB_REG_TYPE0__LSDMA_CONTEXT_REG_TYPE2_MASK                                                     0x02000000L
+#define LSDMA_PUB_REG_TYPE0__LSDMA_CONTEXT_REG_TYPE3_MASK                                                     0x04000000L
+#define LSDMA_PUB_REG_TYPE0__LSDMA_PUB_REG_TYPE0_MASK                                                         0x08000000L
+#define LSDMA_PUB_REG_TYPE0__LSDMA_PUB_REG_TYPE1_MASK                                                         0x10000000L
+#define LSDMA_PUB_REG_TYPE0__LSDMA_PUB_REG_TYPE2_MASK                                                         0x20000000L
+#define LSDMA_PUB_REG_TYPE0__LSDMA_PUB_REG_TYPE3_MASK                                                         0x40000000L
+#define LSDMA_PUB_REG_TYPE0__LSDMA_CONTEXT_GROUP_BOUNDARY_MASK                                                0x80000000L
+//LSDMA_PUB_REG_TYPE1
+#define LSDMA_PUB_REG_TYPE1__LSDMA_RB_RPTR_FETCH_HI__SHIFT                                                    0x0
+#define LSDMA_PUB_REG_TYPE1__LSDMA_SEM_WAIT_FAIL_TIMER_CNTL__SHIFT                                            0x1
+#define LSDMA_PUB_REG_TYPE1__LSDMA_RB_RPTR_FETCH__SHIFT                                                       0x2
+#define LSDMA_PUB_REG_TYPE1__LSDMA_IB_OFFSET_FETCH__SHIFT                                                     0x3
+#define LSDMA_PUB_REG_TYPE1__LSDMA_PROGRAM__SHIFT                                                             0x4
+#define LSDMA_PUB_REG_TYPE1__LSDMA_STATUS_REG__SHIFT                                                          0x5
+#define LSDMA_PUB_REG_TYPE1__LSDMA_STATUS1_REG__SHIFT                                                         0x6
+#define LSDMA_PUB_REG_TYPE1__LSDMA_RD_BURST_CNTL__SHIFT                                                       0x7
+#define LSDMA_PUB_REG_TYPE1__LSDMA_HBM_PAGE_CONFIG__SHIFT                                                     0x8
+#define LSDMA_PUB_REG_TYPE1__LSDMA_UCODE_CHECKSUM__SHIFT                                                      0x9
+#define LSDMA_PUB_REG_TYPE1__LSDMA_F32_CNTL__SHIFT                                                            0xa
+#define LSDMA_PUB_REG_TYPE1__LSDMA_FREEZE__SHIFT                                                              0xb
+#define LSDMA_PUB_REG_TYPE1__LSDMA_PF_PIO_STATUS__SHIFT                                                       0xc
+#define LSDMA_PUB_REG_TYPE1__LSDMA_VF_PIO_STATUS__SHIFT                                                       0xd
+#define LSDMA_PUB_REG_TYPE1__LSDMA_POWER_GATING__SHIFT                                                        0xe
+#define LSDMA_PUB_REG_TYPE1__LSDMA_PGFSM_CONFIG__SHIFT                                                        0xf
+#define LSDMA_PUB_REG_TYPE1__LSDMA_PGFSM_WRITE__SHIFT                                                         0x10
+#define LSDMA_PUB_REG_TYPE1__LSDMA_PGFSM_READ__SHIFT                                                          0x11
+#define LSDMA_PUB_REG_TYPE1__LSDMA_PIO_STATUS__SHIFT                                                          0x12
+#define LSDMA_PUB_REG_TYPE1__LSDMA_BA_THRESHOLD__SHIFT                                                        0x13
+#define LSDMA_PUB_REG_TYPE1__LSDMA_ID__SHIFT                                                                  0x14
+#define LSDMA_PUB_REG_TYPE1__LSDMA_VERSION__SHIFT                                                             0x15
+#define LSDMA_PUB_REG_TYPE1__LSDMA_EDC_COUNTER__SHIFT                                                         0x16
+#define LSDMA_PUB_REG_TYPE1__LSDMA_EDC_COUNTER2__SHIFT                                                        0x17
+#define LSDMA_PUB_REG_TYPE1__LSDMA_STATUS2_REG__SHIFT                                                         0x18
+#define LSDMA_PUB_REG_TYPE1__LSDMA_ATOMIC_CNTL__SHIFT                                                         0x19
+#define LSDMA_PUB_REG_TYPE1__LSDMA_ATOMIC_PREOP_LO__SHIFT                                                     0x1a
+#define LSDMA_PUB_REG_TYPE1__LSDMA_ATOMIC_PREOP_HI__SHIFT                                                     0x1b
+#define LSDMA_PUB_REG_TYPE1__LSDMA_UTCL1_CNTL__SHIFT                                                          0x1c
+#define LSDMA_PUB_REG_TYPE1__LSDMA_UTCL1_WATERMK__SHIFT                                                       0x1d
+#define LSDMA_PUB_REG_TYPE1__LSDMA_UTCL1_RD_STATUS__SHIFT                                                     0x1e
+#define LSDMA_PUB_REG_TYPE1__LSDMA_UTCL1_WR_STATUS__SHIFT                                                     0x1f
+#define LSDMA_PUB_REG_TYPE1__LSDMA_RB_RPTR_FETCH_HI_MASK                                                      0x00000001L
+#define LSDMA_PUB_REG_TYPE1__LSDMA_SEM_WAIT_FAIL_TIMER_CNTL_MASK                                              0x00000002L
+#define LSDMA_PUB_REG_TYPE1__LSDMA_RB_RPTR_FETCH_MASK                                                         0x00000004L
+#define LSDMA_PUB_REG_TYPE1__LSDMA_IB_OFFSET_FETCH_MASK                                                       0x00000008L
+#define LSDMA_PUB_REG_TYPE1__LSDMA_PROGRAM_MASK                                                               0x00000010L
+#define LSDMA_PUB_REG_TYPE1__LSDMA_STATUS_REG_MASK                                                            0x00000020L
+#define LSDMA_PUB_REG_TYPE1__LSDMA_STATUS1_REG_MASK                                                           0x00000040L
+#define LSDMA_PUB_REG_TYPE1__LSDMA_RD_BURST_CNTL_MASK                                                         0x00000080L
+#define LSDMA_PUB_REG_TYPE1__LSDMA_HBM_PAGE_CONFIG_MASK                                                       0x00000100L
+#define LSDMA_PUB_REG_TYPE1__LSDMA_UCODE_CHECKSUM_MASK                                                        0x00000200L
+#define LSDMA_PUB_REG_TYPE1__LSDMA_F32_CNTL_MASK                                                              0x00000400L
+#define LSDMA_PUB_REG_TYPE1__LSDMA_FREEZE_MASK                                                                0x00000800L
+#define LSDMA_PUB_REG_TYPE1__LSDMA_PF_PIO_STATUS_MASK                                                         0x00001000L
+#define LSDMA_PUB_REG_TYPE1__LSDMA_VF_PIO_STATUS_MASK                                                         0x00002000L
+#define LSDMA_PUB_REG_TYPE1__LSDMA_POWER_GATING_MASK                                                          0x00004000L
+#define LSDMA_PUB_REG_TYPE1__LSDMA_PGFSM_CONFIG_MASK                                                          0x00008000L
+#define LSDMA_PUB_REG_TYPE1__LSDMA_PGFSM_WRITE_MASK                                                           0x00010000L
+#define LSDMA_PUB_REG_TYPE1__LSDMA_PGFSM_READ_MASK                                                            0x00020000L
+#define LSDMA_PUB_REG_TYPE1__LSDMA_PIO_STATUS_MASK                                                            0x00040000L
+#define LSDMA_PUB_REG_TYPE1__LSDMA_BA_THRESHOLD_MASK                                                          0x00080000L
+#define LSDMA_PUB_REG_TYPE1__LSDMA_ID_MASK                                                                    0x00100000L
+#define LSDMA_PUB_REG_TYPE1__LSDMA_VERSION_MASK                                                               0x00200000L
+#define LSDMA_PUB_REG_TYPE1__LSDMA_EDC_COUNTER_MASK                                                           0x00400000L
+#define LSDMA_PUB_REG_TYPE1__LSDMA_EDC_COUNTER2_MASK                                                          0x00800000L
+#define LSDMA_PUB_REG_TYPE1__LSDMA_STATUS2_REG_MASK                                                           0x01000000L
+#define LSDMA_PUB_REG_TYPE1__LSDMA_ATOMIC_CNTL_MASK                                                           0x02000000L
+#define LSDMA_PUB_REG_TYPE1__LSDMA_ATOMIC_PREOP_LO_MASK                                                       0x04000000L
+#define LSDMA_PUB_REG_TYPE1__LSDMA_ATOMIC_PREOP_HI_MASK                                                       0x08000000L
+#define LSDMA_PUB_REG_TYPE1__LSDMA_UTCL1_CNTL_MASK                                                            0x10000000L
+#define LSDMA_PUB_REG_TYPE1__LSDMA_UTCL1_WATERMK_MASK                                                         0x20000000L
+#define LSDMA_PUB_REG_TYPE1__LSDMA_UTCL1_RD_STATUS_MASK                                                       0x40000000L
+#define LSDMA_PUB_REG_TYPE1__LSDMA_UTCL1_WR_STATUS_MASK                                                       0x80000000L
+//LSDMA_PUB_REG_TYPE2
+#define LSDMA_PUB_REG_TYPE2__LSDMA_UTCL1_INV0__SHIFT                                                          0x0
+#define LSDMA_PUB_REG_TYPE2__LSDMA_UTCL1_INV1__SHIFT                                                          0x1
+#define LSDMA_PUB_REG_TYPE2__LSDMA_UTCL1_INV2__SHIFT                                                          0x2
+#define LSDMA_PUB_REG_TYPE2__LSDMA_UTCL1_RD_XNACK0__SHIFT                                                     0x3
+#define LSDMA_PUB_REG_TYPE2__LSDMA_UTCL1_RD_XNACK1__SHIFT                                                     0x4
+#define LSDMA_PUB_REG_TYPE2__LSDMA_UTCL1_WR_XNACK0__SHIFT                                                     0x5
+#define LSDMA_PUB_REG_TYPE2__LSDMA_UTCL1_WR_XNACK1__SHIFT                                                     0x6
+#define LSDMA_PUB_REG_TYPE2__LSDMA_UTCL1_TIMEOUT__SHIFT                                                       0x7
+#define LSDMA_PUB_REG_TYPE2__LSDMA_UTCL1_PAGE__SHIFT                                                          0x8
+#define LSDMA_PUB_REG_TYPE2__RESERVED_9_9__SHIFT                                                              0x9
+#define LSDMA_PUB_REG_TYPE2__LSDMA_RELAX_ORDERING_LUT__SHIFT                                                  0xa
+#define LSDMA_PUB_REG_TYPE2__LSDMA_CHICKEN_BITS_2__SHIFT                                                      0xb
+#define LSDMA_PUB_REG_TYPE2__LSDMA_STATUS3_REG__SHIFT                                                         0xc
+#define LSDMA_PUB_REG_TYPE2__LSDMA_PHYSICAL_ADDR_LO__SHIFT                                                    0xd
+#define LSDMA_PUB_REG_TYPE2__LSDMA_PHYSICAL_ADDR_HI__SHIFT                                                    0xe
+#define LSDMA_PUB_REG_TYPE2__LSDMA_ECC_CNTL__SHIFT                                                            0xf
+#define LSDMA_PUB_REG_TYPE2__LSDMA_ERROR_LOG__SHIFT                                                           0x10
+#define LSDMA_PUB_REG_TYPE2__LSDMA_PUB_DUMMY0__SHIFT                                                          0x11
+#define LSDMA_PUB_REG_TYPE2__LSDMA_PUB_DUMMY1__SHIFT                                                          0x12
+#define LSDMA_PUB_REG_TYPE2__LSDMA_PUB_DUMMY2__SHIFT                                                          0x13
+#define LSDMA_PUB_REG_TYPE2__LSDMA_PUB_DUMMY3__SHIFT                                                          0x14
+#define LSDMA_PUB_REG_TYPE2__LSDMA_F32_COUNTER__SHIFT                                                         0x15
+#define LSDMA_PUB_REG_TYPE2__RESERVED_22_22__SHIFT                                                            0x16
+#define LSDMA_PUB_REG_TYPE2__LSDMA_PERFCNT_PERFCOUNTER0_CFG__SHIFT                                            0x17
+#define LSDMA_PUB_REG_TYPE2__LSDMA_PERFCNT_PERFCOUNTER1_CFG__SHIFT                                            0x18
+#define LSDMA_PUB_REG_TYPE2__LSDMA_PERFCNT_PERFCOUNTER_RSLT_CNTL__SHIFT                                       0x19
+#define LSDMA_PUB_REG_TYPE2__LSDMA_PERFCNT_MISC_CNTL__SHIFT                                                   0x1a
+#define LSDMA_PUB_REG_TYPE2__LSDMA_PERFCNT_PERFCOUNTER_LO__SHIFT                                              0x1b
+#define LSDMA_PUB_REG_TYPE2__LSDMA_PERFCNT_PERFCOUNTER_HI__SHIFT                                              0x1c
+#define LSDMA_PUB_REG_TYPE2__LSDMA_CRD_CNTL__SHIFT                                                            0x1d
+#define LSDMA_PUB_REG_TYPE2__LSDMA_GPU_IOV_VIOLATION_LOG__SHIFT                                               0x1e
+#define LSDMA_PUB_REG_TYPE2__LSDMA_ULV_CNTL__SHIFT                                                            0x1f
+#define LSDMA_PUB_REG_TYPE2__LSDMA_UTCL1_INV0_MASK                                                            0x00000001L
+#define LSDMA_PUB_REG_TYPE2__LSDMA_UTCL1_INV1_MASK                                                            0x00000002L
+#define LSDMA_PUB_REG_TYPE2__LSDMA_UTCL1_INV2_MASK                                                            0x00000004L
+#define LSDMA_PUB_REG_TYPE2__LSDMA_UTCL1_RD_XNACK0_MASK                                                       0x00000008L
+#define LSDMA_PUB_REG_TYPE2__LSDMA_UTCL1_RD_XNACK1_MASK                                                       0x00000010L
+#define LSDMA_PUB_REG_TYPE2__LSDMA_UTCL1_WR_XNACK0_MASK                                                       0x00000020L
+#define LSDMA_PUB_REG_TYPE2__LSDMA_UTCL1_WR_XNACK1_MASK                                                       0x00000040L
+#define LSDMA_PUB_REG_TYPE2__LSDMA_UTCL1_TIMEOUT_MASK                                                         0x00000080L
+#define LSDMA_PUB_REG_TYPE2__LSDMA_UTCL1_PAGE_MASK                                                            0x00000100L
+#define LSDMA_PUB_REG_TYPE2__RESERVED_9_9_MASK                                                                0x00000200L
+#define LSDMA_PUB_REG_TYPE2__LSDMA_RELAX_ORDERING_LUT_MASK                                                    0x00000400L
+#define LSDMA_PUB_REG_TYPE2__LSDMA_CHICKEN_BITS_2_MASK                                                        0x00000800L
+#define LSDMA_PUB_REG_TYPE2__LSDMA_STATUS3_REG_MASK                                                           0x00001000L
+#define LSDMA_PUB_REG_TYPE2__LSDMA_PHYSICAL_ADDR_LO_MASK                                                      0x00002000L
+#define LSDMA_PUB_REG_TYPE2__LSDMA_PHYSICAL_ADDR_HI_MASK                                                      0x00004000L
+#define LSDMA_PUB_REG_TYPE2__LSDMA_ECC_CNTL_MASK                                                              0x00008000L
+#define LSDMA_PUB_REG_TYPE2__LSDMA_ERROR_LOG_MASK                                                             0x00010000L
+#define LSDMA_PUB_REG_TYPE2__LSDMA_PUB_DUMMY0_MASK                                                            0x00020000L
+#define LSDMA_PUB_REG_TYPE2__LSDMA_PUB_DUMMY1_MASK                                                            0x00040000L
+#define LSDMA_PUB_REG_TYPE2__LSDMA_PUB_DUMMY2_MASK                                                            0x00080000L
+#define LSDMA_PUB_REG_TYPE2__LSDMA_PUB_DUMMY3_MASK                                                            0x00100000L
+#define LSDMA_PUB_REG_TYPE2__LSDMA_F32_COUNTER_MASK                                                           0x00200000L
+#define LSDMA_PUB_REG_TYPE2__RESERVED_22_22_MASK                                                              0x00400000L
+#define LSDMA_PUB_REG_TYPE2__LSDMA_PERFCNT_PERFCOUNTER0_CFG_MASK                                              0x00800000L
+#define LSDMA_PUB_REG_TYPE2__LSDMA_PERFCNT_PERFCOUNTER1_CFG_MASK                                              0x01000000L
+#define LSDMA_PUB_REG_TYPE2__LSDMA_PERFCNT_PERFCOUNTER_RSLT_CNTL_MASK                                         0x02000000L
+#define LSDMA_PUB_REG_TYPE2__LSDMA_PERFCNT_MISC_CNTL_MASK                                                     0x04000000L
+#define LSDMA_PUB_REG_TYPE2__LSDMA_PERFCNT_PERFCOUNTER_LO_MASK                                                0x08000000L
+#define LSDMA_PUB_REG_TYPE2__LSDMA_PERFCNT_PERFCOUNTER_HI_MASK                                                0x10000000L
+#define LSDMA_PUB_REG_TYPE2__LSDMA_CRD_CNTL_MASK                                                              0x20000000L
+#define LSDMA_PUB_REG_TYPE2__LSDMA_GPU_IOV_VIOLATION_LOG_MASK                                                 0x40000000L
+#define LSDMA_PUB_REG_TYPE2__LSDMA_ULV_CNTL_MASK                                                              0x80000000L
+//LSDMA_PUB_REG_TYPE3
+#define LSDMA_PUB_REG_TYPE3__LSDMA_EA_DBIT_ADDR_DATA__SHIFT                                                   0x0
+#define LSDMA_PUB_REG_TYPE3__LSDMA_EA_DBIT_ADDR_INDEX__SHIFT                                                  0x1
+#define LSDMA_PUB_REG_TYPE3__LSDMA_GPU_IOV_VIOLATION_LOG2__SHIFT                                              0x2
+#define LSDMA_PUB_REG_TYPE3__LSDMA_STATUS4_REG__SHIFT                                                         0x3
+#define LSDMA_PUB_REG_TYPE3__LSDMA_SCRATCH_RAM_DATA__SHIFT                                                    0x4
+#define LSDMA_PUB_REG_TYPE3__LSDMA_SCRATCH_RAM_ADDR__SHIFT                                                    0x5
+#define LSDMA_PUB_REG_TYPE3__LSDMA_CE_CTRL__SHIFT                                                             0x6
+#define LSDMA_PUB_REG_TYPE3__LSDMA_EXCEPTION_STATUS__SHIFT                                                    0x7
+#define LSDMA_PUB_REG_TYPE3__LSDMA_CLK_STATUS__SHIFT                                                          0x8
+#define LSDMA_PUB_REG_TYPE3__LSDMA_PIO_SRC_ADDR_LO__SHIFT                                                     0x9
+#define LSDMA_PUB_REG_TYPE3__LSDMA_PIO_SRC_ADDR_HI__SHIFT                                                     0xa
+#define LSDMA_PUB_REG_TYPE3__LSDMA_PIO_DST_ADDR_LO__SHIFT                                                     0xb
+#define LSDMA_PUB_REG_TYPE3__LSDMA_PIO_DST_ADDR_HI__SHIFT                                                     0xc
+#define LSDMA_PUB_REG_TYPE3__LSDMA_PIO_COMMAND__SHIFT                                                         0xd
+#define LSDMA_PUB_REG_TYPE3__LSDMA_PIO_CONSTFILL_DATA__SHIFT                                                  0xe
+#define LSDMA_PUB_REG_TYPE3__LSDMA_PIO_CONTROL__SHIFT                                                         0xf
+#define LSDMA_PUB_REG_TYPE3__LSDMA_INT_CNTL__SHIFT                                                            0x10
+#define LSDMA_PUB_REG_TYPE3__LSDMA_MEM_POWER_CTRL__SHIFT                                                      0x11
 #define LSDMA_PUB_REG_TYPE3__LSDMA_CLK_CTRL__SHIFT                                                            0x12
+#define LSDMA_PUB_REG_TYPE3__LSDMA_CNTL__SHIFT                                                                0x13
+#define LSDMA_PUB_REG_TYPE3__LSDMA_CHICKEN_BITS__SHIFT                                                        0x14
+#define LSDMA_PUB_REG_TYPE3__LSDMA_GB_ADDR_CONFIG__SHIFT                                                      0x15
+#define LSDMA_PUB_REG_TYPE3__LSDMA_GB_ADDR_CONFIG_READ__SHIFT                                                 0x16
+#define LSDMA_PUB_REG_TYPE3__RESERVED__SHIFT                                                                  0x17
+#define LSDMA_PUB_REG_TYPE3__LSDMA_EA_DBIT_ADDR_DATA_MASK                                                     0x00000001L
+#define LSDMA_PUB_REG_TYPE3__LSDMA_EA_DBIT_ADDR_INDEX_MASK                                                    0x00000002L
+#define LSDMA_PUB_REG_TYPE3__LSDMA_GPU_IOV_VIOLATION_LOG2_MASK                                                0x00000004L
+#define LSDMA_PUB_REG_TYPE3__LSDMA_STATUS4_REG_MASK                                                           0x00000008L
+#define LSDMA_PUB_REG_TYPE3__LSDMA_SCRATCH_RAM_DATA_MASK                                                      0x00000010L
+#define LSDMA_PUB_REG_TYPE3__LSDMA_SCRATCH_RAM_ADDR_MASK                                                      0x00000020L
+#define LSDMA_PUB_REG_TYPE3__LSDMA_CE_CTRL_MASK                                                               0x00000040L
+#define LSDMA_PUB_REG_TYPE3__LSDMA_EXCEPTION_STATUS_MASK                                                      0x00000080L
+#define LSDMA_PUB_REG_TYPE3__LSDMA_CLK_STATUS_MASK                                                            0x00000100L
+#define LSDMA_PUB_REG_TYPE3__LSDMA_PIO_SRC_ADDR_LO_MASK                                                       0x00000200L
+#define LSDMA_PUB_REG_TYPE3__LSDMA_PIO_SRC_ADDR_HI_MASK                                                       0x00000400L
+#define LSDMA_PUB_REG_TYPE3__LSDMA_PIO_DST_ADDR_LO_MASK                                                       0x00000800L
+#define LSDMA_PUB_REG_TYPE3__LSDMA_PIO_DST_ADDR_HI_MASK                                                       0x00001000L
+#define LSDMA_PUB_REG_TYPE3__LSDMA_PIO_COMMAND_MASK                                                           0x00002000L
+#define LSDMA_PUB_REG_TYPE3__LSDMA_PIO_CONSTFILL_DATA_MASK                                                    0x00004000L
+#define LSDMA_PUB_REG_TYPE3__LSDMA_PIO_CONTROL_MASK                                                           0x00008000L
+#define LSDMA_PUB_REG_TYPE3__LSDMA_INT_CNTL_MASK                                                              0x00010000L
+#define LSDMA_PUB_REG_TYPE3__LSDMA_MEM_POWER_CTRL_MASK                                                        0x00020000L
 #define LSDMA_PUB_REG_TYPE3__LSDMA_CLK_CTRL_MASK                                                              0x00040000L
+#define LSDMA_PUB_REG_TYPE3__LSDMA_CNTL_MASK                                                                  0x00080000L
+#define LSDMA_PUB_REG_TYPE3__LSDMA_CHICKEN_BITS_MASK                                                          0x00100000L
+#define LSDMA_PUB_REG_TYPE3__LSDMA_GB_ADDR_CONFIG_MASK                                                        0x00200000L
+#define LSDMA_PUB_REG_TYPE3__LSDMA_GB_ADDR_CONFIG_READ_MASK                                                   0x00400000L
+#define LSDMA_PUB_REG_TYPE3__RESERVED_MASK                                                                    0xFF800000L
 //LSDMA_CONTEXT_GROUP_BOUNDARY
 #define LSDMA_CONTEXT_GROUP_BOUNDARY__RESERVED__SHIFT                                                         0x0
 #define LSDMA_CONTEXT_GROUP_BOUNDARY__RESERVED_MASK                                                           0xFFFFFFFFL
@@ -139,6 +529,7 @@
 #define LSDMA_STATUS_REG__DELTA_RPTR_EMPTY__SHIFT                                                             0x14
 #define LSDMA_STATUS_REG__MC_RD_RET_STALL__SHIFT                                                              0x15
 #define LSDMA_STATUS_REG__MC_RD_NO_POLL_IDLE__SHIFT                                                           0x16
+#define LSDMA_STATUS_REG__DRM_IDLE__SHIFT                                                                     0x17
 #define LSDMA_STATUS_REG__Reserved__SHIFT                                                                     0x18
 #define LSDMA_STATUS_REG__PREV_CMD_IDLE__SHIFT                                                                0x19
 #define LSDMA_STATUS_REG__SEM_IDLE__SHIFT                                                                     0x1a
@@ -169,6 +560,7 @@
 #define LSDMA_STATUS_REG__DELTA_RPTR_EMPTY_MASK                                                               0x00100000L
 #define LSDMA_STATUS_REG__MC_RD_RET_STALL_MASK                                                                0x00200000L
 #define LSDMA_STATUS_REG__MC_RD_NO_POLL_IDLE_MASK                                                             0x00400000L
+#define LSDMA_STATUS_REG__DRM_IDLE_MASK                                                                       0x00800000L
 #define LSDMA_STATUS_REG__Reserved_MASK                                                                       0x01000000L
 #define LSDMA_STATUS_REG__PREV_CMD_IDLE_MASK                                                                  0x02000000L
 #define LSDMA_STATUS_REG__SEM_IDLE_MASK                                                                       0x04000000L
@@ -184,11 +576,14 @@
 #define LSDMA_STATUS1_REG__CE_OUT_IDLE__SHIFT                                                                 0x4
 #define LSDMA_STATUS1_REG__CE_IN_IDLE__SHIFT                                                                  0x5
 #define LSDMA_STATUS1_REG__CE_DST_IDLE__SHIFT                                                                 0x6
+#define LSDMA_STATUS1_REG__CE_DRM_IDLE__SHIFT                                                                 0x7
+#define LSDMA_STATUS1_REG__CE_DRM1_IDLE__SHIFT                                                                0x8
 #define LSDMA_STATUS1_REG__CE_CMD_IDLE__SHIFT                                                                 0x9
 #define LSDMA_STATUS1_REG__CE_AFIFO_FULL__SHIFT                                                               0xa
 #define LSDMA_STATUS1_REG__CE_INFO_FULL__SHIFT                                                                0xb
 #define LSDMA_STATUS1_REG__CE_INFO1_FULL__SHIFT                                                               0xc
 #define LSDMA_STATUS1_REG__EX_START__SHIFT                                                                    0xd
+#define LSDMA_STATUS1_REG__DRM_CTX_RESTORE__SHIFT                                                             0xe
 #define LSDMA_STATUS1_REG__CE_RD_STALL__SHIFT                                                                 0xf
 #define LSDMA_STATUS1_REG__CE_WR_STALL__SHIFT                                                                 0x10
 #define LSDMA_STATUS1_REG__CE_WREQ_IDLE_MASK                                                                  0x00000001L
@@ -198,11 +593,14 @@
 #define LSDMA_STATUS1_REG__CE_OUT_IDLE_MASK                                                                   0x00000010L
 #define LSDMA_STATUS1_REG__CE_IN_IDLE_MASK                                                                    0x00000020L
 #define LSDMA_STATUS1_REG__CE_DST_IDLE_MASK                                                                   0x00000040L
+#define LSDMA_STATUS1_REG__CE_DRM_IDLE_MASK                                                                   0x00000080L
+#define LSDMA_STATUS1_REG__CE_DRM1_IDLE_MASK                                                                  0x00000100L
 #define LSDMA_STATUS1_REG__CE_CMD_IDLE_MASK                                                                   0x00000200L
 #define LSDMA_STATUS1_REG__CE_AFIFO_FULL_MASK                                                                 0x00000400L
 #define LSDMA_STATUS1_REG__CE_INFO_FULL_MASK                                                                  0x00000800L
 #define LSDMA_STATUS1_REG__CE_INFO1_FULL_MASK                                                                 0x00001000L
 #define LSDMA_STATUS1_REG__EX_START_MASK                                                                      0x00002000L
+#define LSDMA_STATUS1_REG__DRM_CTX_RESTORE_MASK                                                               0x00004000L
 #define LSDMA_STATUS1_REG__CE_RD_STALL_MASK                                                                   0x00008000L
 #define LSDMA_STATUS1_REG__CE_WR_STALL_MASK                                                                   0x00010000L
 //LSDMA_RD_BURST_CNTL
@@ -216,6 +614,17 @@
 //LSDMA_UCODE_CHECKSUM
 #define LSDMA_UCODE_CHECKSUM__DATA__SHIFT                                                                     0x0
 #define LSDMA_UCODE_CHECKSUM__DATA_MASK                                                                       0xFFFFFFFFL
+//LSDMA_F32_CNTL
+#define LSDMA_F32_CNTL__HALT__SHIFT                                                                           0x0
+#define LSDMA_F32_CNTL__STEP__SHIFT                                                                           0x1
+#define LSDMA_F32_CNTL__DBG_SELECT_BITS__SHIFT                                                                0x2
+#define LSDMA_F32_CNTL__RESET__SHIFT                                                                          0x8
+#define LSDMA_F32_CNTL__CHECKSUM_CLR__SHIFT                                                                   0xa
+#define LSDMA_F32_CNTL__HALT_MASK                                                                             0x00000001L
+#define LSDMA_F32_CNTL__STEP_MASK                                                                             0x00000002L
+#define LSDMA_F32_CNTL__DBG_SELECT_BITS_MASK                                                                  0x000000FCL
+#define LSDMA_F32_CNTL__RESET_MASK                                                                            0x00000100L
+#define LSDMA_F32_CNTL__CHECKSUM_CLR_MASK                                                                     0x00000400L
 //LSDMA_FREEZE
 #define LSDMA_FREEZE__PREEMPT__SHIFT                                                                          0x0
 #define LSDMA_FREEZE__FREEZE__SHIFT                                                                           0x4
@@ -777,10 +1186,25 @@
 #define LSDMA_PERFCNT_PERFCOUNTER_HI__COUNTER_HI_MASK                                                         0x0000FFFFL
 #define LSDMA_PERFCNT_PERFCOUNTER_HI__COMPARE_VALUE_MASK                                                      0xFFFF0000L
 //LSDMA_CRD_CNTL
+#define LSDMA_CRD_CNTL__DRM_CREDIT__SHIFT                                                                     0x0
 #define LSDMA_CRD_CNTL__MC_WRREQ_CREDIT__SHIFT                                                                0x7
 #define LSDMA_CRD_CNTL__MC_RDREQ_CREDIT__SHIFT                                                                0xd
+#define LSDMA_CRD_CNTL__DRM_CREDIT_MASK                                                                       0x0000007FL
 #define LSDMA_CRD_CNTL__MC_WRREQ_CREDIT_MASK                                                                  0x00001F80L
 #define LSDMA_CRD_CNTL__MC_RDREQ_CREDIT_MASK                                                                  0x0007E000L
+//LSDMA_GPU_IOV_VIOLATION_LOG
+#define LSDMA_GPU_IOV_VIOLATION_LOG__VIOLATION_STATUS__SHIFT                                                  0x0
+#define LSDMA_GPU_IOV_VIOLATION_LOG__MULTIPLE_VIOLATION_STATUS__SHIFT                                         0x1
+#define LSDMA_GPU_IOV_VIOLATION_LOG__ADDRESS__SHIFT                                                           0x2
+#define LSDMA_GPU_IOV_VIOLATION_LOG__WRITE_OPERATION__SHIFT                                                   0x14
+#define LSDMA_GPU_IOV_VIOLATION_LOG__VF__SHIFT                                                                0x15
+#define LSDMA_GPU_IOV_VIOLATION_LOG__VFID__SHIFT                                                              0x16
+#define LSDMA_GPU_IOV_VIOLATION_LOG__VIOLATION_STATUS_MASK                                                    0x00000001L
+#define LSDMA_GPU_IOV_VIOLATION_LOG__MULTIPLE_VIOLATION_STATUS_MASK                                           0x00000002L
+#define LSDMA_GPU_IOV_VIOLATION_LOG__ADDRESS_MASK                                                             0x000FFFFCL
+#define LSDMA_GPU_IOV_VIOLATION_LOG__WRITE_OPERATION_MASK                                                     0x00100000L
+#define LSDMA_GPU_IOV_VIOLATION_LOG__VF_MASK                                                                  0x00200000L
+#define LSDMA_GPU_IOV_VIOLATION_LOG__VFID_MASK                                                                0x03C00000L
 //LSDMA_ULV_CNTL
 #define LSDMA_ULV_CNTL__HYSTERESIS__SHIFT                                                                     0x0
 #define LSDMA_ULV_CNTL__ENTER_ULV_INT_CLR__SHIFT                                                              0x1b
@@ -800,6 +1224,9 @@
 //LSDMA_EA_DBIT_ADDR_INDEX
 #define LSDMA_EA_DBIT_ADDR_INDEX__VALUE__SHIFT                                                                0x0
 #define LSDMA_EA_DBIT_ADDR_INDEX__VALUE_MASK                                                                  0x00000007L
+//LSDMA_GPU_IOV_VIOLATION_LOG2
+#define LSDMA_GPU_IOV_VIOLATION_LOG2__INITIATOR_ID__SHIFT                                                     0x0
+#define LSDMA_GPU_IOV_VIOLATION_LOG2__INITIATOR_ID_MASK                                                       0x000003FFL
 //LSDMA_STATUS4_REG
 #define LSDMA_STATUS4_REG__IDLE__SHIFT                                                                        0x0
 #define LSDMA_STATUS4_REG__IH_OUTSTANDING__SHIFT                                                              0x2
@@ -829,6 +1256,12 @@
 #define LSDMA_STATUS4_REG__ACTIVE_QUEUE_ID_MASK                                                               0x0003C000L
 #define LSDMA_STATUS4_REG__SRIOV_WATING_RLCV_CMD_MASK                                                         0x00040000L
 #define LSDMA_STATUS4_REG__SRIOV_LSDMA_EXECUTING_CMD_MASK                                                     0x00080000L
+//LSDMA_SCRATCH_RAM_DATA
+#define LSDMA_SCRATCH_RAM_DATA__DATA__SHIFT                                                                   0x0
+#define LSDMA_SCRATCH_RAM_DATA__DATA_MASK                                                                     0xFFFFFFFFL
+//LSDMA_SCRATCH_RAM_ADDR
+#define LSDMA_SCRATCH_RAM_ADDR__ADDR__SHIFT                                                                   0x0
+#define LSDMA_SCRATCH_RAM_ADDR__ADDR_MASK                                                                     0x0000007FL
 //LSDMA_CE_CTRL
 #define LSDMA_CE_CTRL__RD_LUT_WATERMARK__SHIFT                                                                0x0
 #define LSDMA_CE_CTRL__RD_LUT_DEPTH__SHIFT                                                                    0x3
@@ -871,6 +1304,15 @@
 #define LSDMA_EXCEPTION_STATUS__NON_COPY_CMD_NACK_PRT_MASK                                                    0x00080000L
 #define LSDMA_EXCEPTION_STATUS__RPTR_WB_NACK_PRT_MASK                                                         0x00200000L
 #define LSDMA_EXCEPTION_STATUS__VM_HOLE_MASK                                                                  0x01000000L
+//LSDMA_CLK_STATUS
+#define LSDMA_CLK_STATUS__DYN_CLK__SHIFT                                                                      0x0
+#define LSDMA_CLK_STATUS__PTR_CLK__SHIFT                                                                      0x1
+#define LSDMA_CLK_STATUS__REG_CLK__SHIFT                                                                      0x2
+#define LSDMA_CLK_STATUS__F32_CLK__SHIFT                                                                      0x3
+#define LSDMA_CLK_STATUS__DYN_CLK_MASK                                                                        0x00000001L
+#define LSDMA_CLK_STATUS__PTR_CLK_MASK                                                                        0x00000002L
+#define LSDMA_CLK_STATUS__REG_CLK_MASK                                                                        0x00000004L
+#define LSDMA_CLK_STATUS__F32_CLK_MASK                                                                        0x00000008L
 //LSDMA_PIO_SRC_ADDR_LO
 #define LSDMA_PIO_SRC_ADDR_LO__SRC_ADDR_LO__SHIFT                                                             0x0
 #define LSDMA_PIO_SRC_ADDR_LO__SRC_ADDR_LO_MASK                                                               0xFFFFFFFFL
@@ -972,6 +1414,7 @@
 #define LSDMA_CNTL__MIDCMD_EXPIRE_ENABLE__SHIFT                                                               0x6
 #define LSDMA_CNTL__MIDCMD_WORLDSWITCH_ENABLE__SHIFT                                                          0x11
 #define LSDMA_CNTL__AUTO_CTXSW_ENABLE__SHIFT                                                                  0x12
+#define LSDMA_CNTL__DRM_RESTORE_ENABLE__SHIFT                                                                 0x13
 #define LSDMA_CNTL__UTC_L1_ENABLE_MASK                                                                        0x00000002L
 #define LSDMA_CNTL__SEM_WAIT_INT_ENABLE_MASK                                                                  0x00000004L
 #define LSDMA_CNTL__DATA_SWAP_ENABLE_MASK                                                                     0x00000008L
@@ -980,6 +1423,7 @@
 #define LSDMA_CNTL__MIDCMD_EXPIRE_ENABLE_MASK                                                                 0x00000040L
 #define LSDMA_CNTL__MIDCMD_WORLDSWITCH_ENABLE_MASK                                                            0x00020000L
 #define LSDMA_CNTL__AUTO_CTXSW_ENABLE_MASK                                                                    0x00040000L
+#define LSDMA_CNTL__DRM_RESTORE_ENABLE_MASK                                                                   0x00080000L
 //LSDMA_CHICKEN_BITS
 #define LSDMA_CHICKEN_BITS__STALL_ON_TRANS_FULL_ENABLE__SHIFT                                                 0x1
 #define LSDMA_CHICKEN_BITS__STALL_ON_NO_FREE_DATA_BUFFER_ENABLE__SHIFT                                        0x2
@@ -1034,6 +1478,7 @@
 #define LSDMA_QUEUE0_RB_CNTL__RPTR_WRITEBACK_ENABLE__SHIFT                                                    0xc
 #define LSDMA_QUEUE0_RB_CNTL__RPTR_WRITEBACK_SWAP_ENABLE__SHIFT                                               0xd
 #define LSDMA_QUEUE0_RB_CNTL__RPTR_WRITEBACK_TIMER__SHIFT                                                     0x10
+#define LSDMA_QUEUE0_RB_CNTL__RB_PRIV__SHIFT                                                                  0x17
 #define LSDMA_QUEUE0_RB_CNTL__RB_VMID__SHIFT                                                                  0x18
 #define LSDMA_QUEUE0_RB_CNTL__RB_ENABLE_MASK                                                                  0x00000001L
 #define LSDMA_QUEUE0_RB_CNTL__RB_SIZE_MASK                                                                    0x0000003EL
@@ -1041,6 +1486,7 @@
 #define LSDMA_QUEUE0_RB_CNTL__RPTR_WRITEBACK_ENABLE_MASK                                                      0x00001000L
 #define LSDMA_QUEUE0_RB_CNTL__RPTR_WRITEBACK_SWAP_ENABLE_MASK                                                 0x00002000L
 #define LSDMA_QUEUE0_RB_CNTL__RPTR_WRITEBACK_TIMER_MASK                                                       0x001F0000L
+#define LSDMA_QUEUE0_RB_CNTL__RB_PRIV_MASK                                                                    0x00800000L
 #define LSDMA_QUEUE0_RB_CNTL__RB_VMID_MASK                                                                    0x0F000000L
 //LSDMA_QUEUE0_RB_BASE
 #define LSDMA_QUEUE0_RB_BASE__ADDR__SHIFT                                                                     0x0
@@ -1084,10 +1530,12 @@
 #define LSDMA_QUEUE0_IB_CNTL__IB_SWAP_ENABLE__SHIFT                                                           0x4
 #define LSDMA_QUEUE0_IB_CNTL__SWITCH_INSIDE_IB__SHIFT                                                         0x8
 #define LSDMA_QUEUE0_IB_CNTL__CMD_VMID__SHIFT                                                                 0x10
+#define LSDMA_QUEUE0_IB_CNTL__IB_PRIV__SHIFT                                                                  0x1f
 #define LSDMA_QUEUE0_IB_CNTL__IB_ENABLE_MASK                                                                  0x00000001L
 #define LSDMA_QUEUE0_IB_CNTL__IB_SWAP_ENABLE_MASK                                                             0x00000010L
 #define LSDMA_QUEUE0_IB_CNTL__SWITCH_INSIDE_IB_MASK                                                           0x00000100L
 #define LSDMA_QUEUE0_IB_CNTL__CMD_VMID_MASK                                                                   0x000F0000L
+#define LSDMA_QUEUE0_IB_CNTL__IB_PRIV_MASK                                                                    0x80000000L
 //LSDMA_QUEUE0_IB_RPTR
 #define LSDMA_QUEUE0_IB_RPTR__OFFSET__SHIFT                                                                   0x2
 #define LSDMA_QUEUE0_IB_RPTR__OFFSET_MASK                                                                     0x003FFFFCL
@@ -1238,6 +1686,7 @@
 #define LSDMA_QUEUE1_RB_CNTL__RPTR_WRITEBACK_ENABLE__SHIFT                                                    0xc
 #define LSDMA_QUEUE1_RB_CNTL__RPTR_WRITEBACK_SWAP_ENABLE__SHIFT                                               0xd
 #define LSDMA_QUEUE1_RB_CNTL__RPTR_WRITEBACK_TIMER__SHIFT                                                     0x10
+#define LSDMA_QUEUE1_RB_CNTL__RB_PRIV__SHIFT                                                                  0x17
 #define LSDMA_QUEUE1_RB_CNTL__RB_VMID__SHIFT                                                                  0x18
 #define LSDMA_QUEUE1_RB_CNTL__RB_ENABLE_MASK                                                                  0x00000001L
 #define LSDMA_QUEUE1_RB_CNTL__RB_SIZE_MASK                                                                    0x0000003EL
@@ -1245,6 +1694,7 @@
 #define LSDMA_QUEUE1_RB_CNTL__RPTR_WRITEBACK_ENABLE_MASK                                                      0x00001000L
 #define LSDMA_QUEUE1_RB_CNTL__RPTR_WRITEBACK_SWAP_ENABLE_MASK                                                 0x00002000L
 #define LSDMA_QUEUE1_RB_CNTL__RPTR_WRITEBACK_TIMER_MASK                                                       0x001F0000L
+#define LSDMA_QUEUE1_RB_CNTL__RB_PRIV_MASK                                                                    0x00800000L
 #define LSDMA_QUEUE1_RB_CNTL__RB_VMID_MASK                                                                    0x0F000000L
 //LSDMA_QUEUE1_RB_BASE
 #define LSDMA_QUEUE1_RB_BASE__ADDR__SHIFT                                                                     0x0
@@ -1288,10 +1738,12 @@
 #define LSDMA_QUEUE1_IB_CNTL__IB_SWAP_ENABLE__SHIFT                                                           0x4
 #define LSDMA_QUEUE1_IB_CNTL__SWITCH_INSIDE_IB__SHIFT                                                         0x8
 #define LSDMA_QUEUE1_IB_CNTL__CMD_VMID__SHIFT                                                                 0x10
+#define LSDMA_QUEUE1_IB_CNTL__IB_PRIV__SHIFT                                                                  0x1f
 #define LSDMA_QUEUE1_IB_CNTL__IB_ENABLE_MASK                                                                  0x00000001L
 #define LSDMA_QUEUE1_IB_CNTL__IB_SWAP_ENABLE_MASK                                                             0x00000010L
 #define LSDMA_QUEUE1_IB_CNTL__SWITCH_INSIDE_IB_MASK                                                           0x00000100L
 #define LSDMA_QUEUE1_IB_CNTL__CMD_VMID_MASK                                                                   0x000F0000L
+#define LSDMA_QUEUE1_IB_CNTL__IB_PRIV_MASK                                                                    0x80000000L
 //LSDMA_QUEUE1_IB_RPTR
 #define LSDMA_QUEUE1_IB_RPTR__OFFSET__SHIFT                                                                   0x2
 #define LSDMA_QUEUE1_IB_RPTR__OFFSET_MASK                                                                     0x003FFFFCL
-- 
2.37.3

