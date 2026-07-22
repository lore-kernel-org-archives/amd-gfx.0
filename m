Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49F2C44539
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2026 10:17:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3812110ED02;
	Wed, 22 Jul 2026 10:17:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ezjg5XAX";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012067.outbound.protection.outlook.com [52.101.43.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F5C310ED02
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2026 10:17:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fbJQaUE47HJr9WEgzMnGH2NK+8Q6fN5JTQi3ZxG3a3ThmNvnlhoSCYQUPTmLUCqYdetWTckmEfY6bfuWSoxJ3BXMBtWACEPJmJcTEWwbzHsgMsD+Z19hQWKIeqzI2GNphEe45C6puGHHPX1FdMj409zjs56SVW3ogrOMnWqsUHX1SXgSe46TbF6A22VjTPCzkAtVMT8hMKh8dlJYbDqeROc5FXXJ8zYnmjT51TkG182HtZGQyCaNn2WvoJxbpxqInOGgBz0XF8WBPhW49p3+QzQL+YgwVFTh/w2VDdQlCU/dpZJLGDFRBKPsxPq9eh3xrTVt4+FWFxa7Imx/4aEcEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKOjdnCxmYnH7fNxUS8q/HQLnZ/sACg16odyV1zNtKc=;
 b=j0GW+tOyG8mQ63RfENXknCuZSQeFB96uXVuA41wiN8oeZb41NbOVYTyivl+lLXVxv0TYVgEef7+HesiD30R5NxNwrPUfRLklxhF608lAU5sPiUhXGEllQMDyx8JJ+4Op8Ki6x0Mm4zVIlkk3U/HwP0/DgsGWRMOslidQ8pVlQ6izx6zv6kTN3gKT3LuwA0O6iqIzKs1DE1N2l7rTJsbOFWsJ0BoeDuYh0vOzboNlg51/SErpzimPiF1yWto+g1Dxq2otc6sy0ZnSYFxwk4tHjMznfuwoTWAfwkNMk2/Asap+zIX9LnmEMu2c72rXJXAYhsY0r+ggdW8chKqxGa621g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKOjdnCxmYnH7fNxUS8q/HQLnZ/sACg16odyV1zNtKc=;
 b=ezjg5XAXHoaFjx4KjpCOba8gni6b7nqm+L2q/73CUoex9ZPQ5LfaH1rk+aar2cHWR0B9nDVWNJUslmE+h6t+3vzkWgfRSJi/7upmdgoIVfhaWKuArGNC5A+EMRK1N4EE7+AHKsTevnPtytDoCU54vIJBccQCzEKgzA4ppQ0OpkI=
Received: from MN2PR07CA0029.namprd07.prod.outlook.com (2603:10b6:208:1a0::39)
 by CH2PR12MB4069.namprd12.prod.outlook.com (2603:10b6:610:ac::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 10:16:53 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:1a0:cafe::a1) by MN2PR07CA0029.outlook.office365.com
 (2603:10b6:208:1a0::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 10:16:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 10:16:53 +0000
Received: from shubhankar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 22 Jul 2026 05:16:50 -0500
From: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
To: <Alexander.Deucher@amd.com>, <Mario.Limonciello@amd.com>,
 <Christian.Koenig@amd.com>, <Sunil.Khatri@amd.com>,
 <Arunpravin.PaneerSelvam@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Pratik.Vishwakarma@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>,
 Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
Subject: [PATCH V2 2/2] drm/amdgpu: Fix NBIO 7.11.5 offsets
Date: Wed, 22 Jul 2026 15:44:05 +0530
Message-ID: <20260722101555.2092421-2-Shubhankar.MilindSardeshpande@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722101555.2092421-1-Shubhankar.MilindSardeshpande@amd.com>
References: <20260722101555.2092421-1-Shubhankar.MilindSardeshpande@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|CH2PR12MB4069:EE_
X-MS-Office365-Filtering-Correlation-Id: 61551718-a4b0-47fd-d017-08dee7da5a09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|3023799007|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: CoNoV7KJYsVbWLv24qfSekTSLuGAdEYJ7kTEKtZupK9BzPgXerjzQmykGRQ+wBOSLlaB/NdgVNPsGH+Gyn54z+LTrb1ibhnsMNXDAuGa0qgGQdn4mfIILAjEWFo6y6HUcRicRL3vXVLyahZ/LDaOLBbUVbaCxM0DHqQyIHET0gwxGYtHUS31Oxctn5GHMtri+zhYZ31zwCoGYR0xmVc+sWylPpNw2O7KMYEYEjbUn5Nhozt+TgUAYVvrUHwVuvGCSFkwngVljXyUHt2JezdXoqewHAQa8yXvyXlU+INviScs5MxdyLsD9kfAqSSGdliTd4iUj0TbD7oKz8yxVDL589OpFEhpiSCmyrYRCeCuZxlFAcZld/OB81UN8jBEtofwjE10Flos4AsgdKdMhSqhtgeln6EMqYQUcdsCNAts1icPlOqB8iyFQvBEeMje9PsV+GeTlfTVQPTt9/vnm/BoJKF0auWH9bjCL+b9OUmOeNNErAOvL7MDwa5AWGBXX/doUoWm4SNGayuj6YcS3EtdlxQ/g5nSJ8ZZWKqZb5j7A56vbUtO0aZ6hjGDmelq+OG2f9aS9Mn8agHhGVywb7MX0rNfHo6v9E6l01W0E3XgYqNYVxkqVd/Qu3GyuI2DUOX7qkWv7VdiONlUIqTvBsd8npLDDaNRQg5y4/seFFJuIW+ceoQnoUnje3LILym/KaFBwzseSU5iyT/1zCbfaSlViQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(3023799007)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 68RSPJhpUW/5AQqGIeYNQG69FTS0ZVFsHbu8ApE+cyuvoPlhwvdaPJ+hgyA12DpPz5doVloT6ciq01fycRZCgXHZq1N/X/8ETVkkx2eKmXUZaX2fxWIbo254Bg08S3dlnvyEb1XWkPu3z04V4S7e0Mt3JrcKnK0le7hjdw5+WWRDEn6xkc1srq9bvlhgPA81MhNlR6NVv/7jmZfHbC2v1HcbzeEfdO0B4EUqPvsF47aGybO4lApsMcqH2weZaVdaTghRpgYZ6rOKfRgxUhOnRtaf1AjRd+xHznemjhTmB7M4M5HGyMlnHeedVfNS6MJbh4DCBGKizWyFrUUDgJW32ot5pD2RL5xhwS3pqotGiPkdihL/K1qrF1AXl1/Hr3/0XgXuHAOPifpmBtpPZJ4MlNU5F1WIugpVPqzjS0S0v10yNrmBhcMfVGDqfjrvaRoh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 10:16:53.2234 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61551718-a4b0-47fd-d017-08dee7da5a09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4069
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

Fix NBIO 7.11.5 related offsets

Signed-off-by: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c | 146 ++++++++++++-----------
 1 file changed, 76 insertions(+), 70 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
index c78f0598637f..000516b5845a 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
@@ -30,70 +30,76 @@
 #include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
 #include <uapi/linux/kfd_ioctl.h>
 
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL_nbif_4_10                                                           0x4f0aeb
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL_nbif_4_10_BASE_IDX                                                  3
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL1_nbif_4_10                                                          0x4f0aec
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL1_nbif_4_10_BASE_IDX                                                 3
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL_nbif_4_10                                                           0x4f0aed
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL_nbif_4_10_BASE_IDX                                                  3
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL1_nbif_4_10                                                          0x4f0aee
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL1_nbif_4_10_BASE_IDX                                                 3
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL_nbif_4_10                                                           0x4f0aef
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL_nbif_4_10_BASE_IDX                                                  3
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL1_nbif_4_10                                                          0x4f0af0
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL1_nbif_4_10_BASE_IDX                                                 3
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL_nbif_4_10                                                           0x4f0af1
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL_nbif_4_10_BASE_IDX                                                  3
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL1_nbif_4_10                                                          0x4f0af2
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL1_nbif_4_10_BASE_IDX                                                 3
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL_nbif_4_10                                                           0x4f0af3
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL_nbif_4_10_BASE_IDX                                                  3
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL1_nbif_4_10                                                          0x4f0af4
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL1_nbif_4_10_BASE_IDX                                                 3
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL_nbif_4_10                                                           0x4f0af5
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL_nbif_4_10_BASE_IDX                                                  3
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL1_nbif_4_10                                                          0x4f0af6
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL1_nbif_4_10_BASE_IDX                                                 3
-#define regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_nbif_4_10                                                              0x0021
-#define regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_nbif_4_10_BASE_IDX                                                     2
-
-#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH_nbio_7_11_5                                      0x8e13
-#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH_nbio_7_11_5_BASE_IDX                             5
-#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW_nbio_7_11_5                                       0x8e14
-#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW_nbio_7_11_5_BASE_IDX                              5
-#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL_nbio_7_11_5                                           0x8e15
-#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL_nbio_7_11_5_BASE_IDX                                  5
-
-#define regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL_nbio_7_11_5                                                     0x8e4d
-#define regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL_nbio_7_11_5_BASE_IDX                                            5
-#define regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL_nbio_7_11_5                                                     0x8e4e
-#define regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL_nbio_7_11_5_BASE_IDX                                            5
-
-#define regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_nbio_7_11_5                                                      0xd000
-#define regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_nbio_7_11_5_BASE_IDX                                             5
-
-#define regBIF_BX0_BIF_FB_EN_nbio_7_11_5                                                                    0x8e20
-#define regBIF_BX0_BIF_FB_EN_nbio_7_11_5_BASE_IDX                                                           5
-
-#define regBIF_BX0_INTERRUPT_CNTL_nbio_7_11_5                                                               0x8e11
-#define regBIF_BX0_INTERRUPT_CNTL_nbio_7_11_5_BASE_IDX                                                      5
-#define regBIF_BX0_INTERRUPT_CNTL2_nbio_7_11_5                                                              0x8e12
-#define regBIF_BX0_INTERRUPT_CNTL2_nbio_7_11_5_BASE_IDX                                                     5
-
-#define regBIF_BX_PF0_GPU_HDP_FLUSH_REQ_nbio_7_11_5                                                         0x8e26
-#define regBIF_BX_PF0_GPU_HDP_FLUSH_REQ_nbio_7_11_5_BASE_IDX                                                5
-#define regBIF_BX_PF0_GPU_HDP_FLUSH_DONE_nbio_7_11_5                                                        0x8e27
-#define regBIF_BX_PF0_GPU_HDP_FLUSH_DONE_nbio_7_11_5_BASE_IDX                                               5
-
-#define regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL_nbio_7_11_5                                              0x8e17
-#define regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL_nbio_7_11_5_BASE_IDX                                     5
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL_nbif_4_10                                 0x4f0aeb
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL_nbif_4_10_BASE_IDX                        3
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL1_nbif_4_10                                0x4f0aec
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL1_nbif_4_10_BASE_IDX                       3
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL_nbif_4_10                                 0x4f0aed
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL_nbif_4_10_BASE_IDX                        3
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL1_nbif_4_10                                0x4f0aee
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL1_nbif_4_10_BASE_IDX                       3
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL_nbif_4_10                                 0x4f0aef
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL_nbif_4_10_BASE_IDX                        3
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL1_nbif_4_10                                0x4f0af0
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL1_nbif_4_10_BASE_IDX                       3
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL_nbif_4_10                                 0x4f0af1
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL_nbif_4_10_BASE_IDX                        3
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL1_nbif_4_10                                0x4f0af2
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL1_nbif_4_10_BASE_IDX                       3
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL_nbif_4_10                                 0x4f0af3
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL_nbif_4_10_BASE_IDX                        3
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL1_nbif_4_10                                0x4f0af4
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL1_nbif_4_10_BASE_IDX                       3
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL_nbif_4_10                                 0x4f0af5
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL_nbif_4_10_BASE_IDX                        3
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL1_nbif_4_10                                0x4f0af6
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL1_nbif_4_10_BASE_IDX                       3
+#define regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_nbif_4_10                                    0x0021
+#define regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_nbif_4_10_BASE_IDX                           2
+
+#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH_nbio_7_11_5                  0x8e13
+#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH_nbio_7_11_5_BASE_IDX         5
+#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW_nbio_7_11_5                   0x8e14
+#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW_nbio_7_11_5_BASE_IDX          5
+#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL_nbio_7_11_5                       0x8e15
+#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL_nbio_7_11_5_BASE_IDX              5
+
+#define regBIF_BX1_REMAP_HDP_MEM_FLUSH_CNTL_nbio_7_11_5                                 0x012d
+#define regBIF_BX1_REMAP_HDP_MEM_FLUSH_CNTL_nbio_7_11_5_BASE_IDX                        2
+#define regBIF_BX1_REMAP_HDP_REG_FLUSH_CNTL_nbio_7_11_5                                 0x012e
+#define regBIF_BX1_REMAP_HDP_REG_FLUSH_CNTL_nbio_7_11_5_BASE_IDX                        2
+
+#define regRCC_STRAP1_RCC_DEV0_EPF0_STRAP0_nbio_7_11_5                                  0x0021
+#define regRCC_STRAP1_RCC_DEV0_EPF0_STRAP0_nbio_7_11_5_BASE_IDX                         2
+
+#define regBIF_BX1_BIF_FB_EN_nbio_7_11_5                                                0x0100
+#define regBIF_BX1_BIF_FB_EN_nbio_7_11_5_BASE_IDX                                       2
+
+#define regBIF_BX1_INTERRUPT_CNTL_nbio_7_11_5                                           0x00f1
+#define regBIF_BX1_INTERRUPT_CNTL_nbio_7_11_5_BASE_IDX                                  2
+#define regBIF_BX1_INTERRUPT_CNTL2_nbio_7_11_5                                          0x00f2
+#define regBIF_BX1_INTERRUPT_CNTL2_nbio_7_11_5_BASE_IDX                                 2
+
+#define regBIF_BX_PF1_GPU_HDP_FLUSH_REQ_nbio_7_11_5                                     0x0106
+#define regBIF_BX_PF1_GPU_HDP_FLUSH_REQ_nbio_7_11_5_BASE_IDX                            2
+#define regBIF_BX_PF1_GPU_HDP_FLUSH_DONE_nbio_7_11_5                                    0x0107
+#define regBIF_BX_PF1_GPU_HDP_FLUSH_DONE_nbio_7_11_5_BASE_IDX                           2
+
+#define regBIF_BX_PF1_HDP_MEM_COHERENCY_FLUSH_CNTL_nbio_7_11_5                          0x00f7
+#define regBIF_BX_PF1_HDP_MEM_COHERENCY_FLUSH_CNTL_nbio_7_11_5_BASE_IDX                 2
+
+//BIF_BX1_BIF_FB_EN
+#define BIF_BX1_BIF_FB_EN__FB_READ_EN__SHIFT_nbio_7_11_5                                0x0
+#define BIF_BX1_BIF_FB_EN__FB_WRITE_EN__SHIFT_nbio_7_11_5                               0x1
+#define BIF_BX1_BIF_FB_EN__FB_READ_EN_MASK_nbio_7_11_5                                  0x00000001L
+#define BIF_BX1_BIF_FB_EN__FB_WRITE_EN_MASK_nbio_7_11_5                                 0x00000002L
 
 static void nbif_v6_3_1_remap_hdp_registers(struct amdgpu_device *adev)
 {
 	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 5)) {
-		WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL_nbio_7_11_5,
+		WREG32_SOC15(NBIO, 0, regBIF_BX1_REMAP_HDP_MEM_FLUSH_CNTL_nbio_7_11_5,
 			adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
-		WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL_nbio_7_11_5,
+		WREG32_SOC15(NBIO, 0, regBIF_BX1_REMAP_HDP_REG_FLUSH_CNTL_nbio_7_11_5,
 			adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
 	} else {
 		WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
@@ -110,7 +116,7 @@ static u32 nbif_v6_3_1_get_rev_id(struct amdgpu_device *adev)
 	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 4))
 		tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_nbif_4_10);
 	else if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 5))
-		tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_nbio_7_11_5);
+		tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP1_RCC_DEV0_EPF0_STRAP0_nbio_7_11_5);
 	else
 		tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0);
 
@@ -124,11 +130,11 @@ static void nbif_v6_3_1_mc_access_enable(struct amdgpu_device *adev, bool enable
 {
 	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 5)) {
 		if (enable)
-			WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN_nbio_7_11_5,
-				     BIF_BX0_BIF_FB_EN__FB_READ_EN_MASK |
-				     BIF_BX0_BIF_FB_EN__FB_WRITE_EN_MASK);
+			WREG32_SOC15(NBIO, 0, regBIF_BX1_BIF_FB_EN_nbio_7_11_5,
+				     BIF_BX1_BIF_FB_EN__FB_READ_EN_MASK_nbio_7_11_5 |
+				     BIF_BX1_BIF_FB_EN__FB_WRITE_EN_MASK_nbio_7_11_5);
 		else
-			WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN_nbio_7_11_5, 0);
+			WREG32_SOC15(NBIO, 0, regBIF_BX1_BIF_FB_EN_nbio_7_11_5, 0);
 	} else {
 		if (enable)
 			WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN,
@@ -383,12 +389,12 @@ static void nbif_v6_3_1_ih_control(struct amdgpu_device *adev)
 
 	/* setup interrupt control */
 	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 5))
-		WREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL2_nbio_7_11_5,
+		WREG32_SOC15(NBIO, 0, regBIF_BX1_INTERRUPT_CNTL2_nbio_7_11_5,
 				adev->dummy_page_addr >> 8);
 	else
 		WREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL2, adev->dummy_page_addr >> 8);
 
-	interrupt_cntl = RREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL_nbio_7_11_5);
+	interrupt_cntl = RREG32_SOC15(NBIO, 0, regBIF_BX1_INTERRUPT_CNTL_nbio_7_11_5);
 	/*
 	 * BIF_BX0_INTERRUPT_CNTL__IH_DUMMY_RD_OVERRIDE_MASK=0 - dummy read disabled with msi, enabled without msi
 	 * BIF_BX0_INTERRUPT_CNTL__IH_DUMMY_RD_OVERRIDE_MASK=1 - dummy read controlled by IH_DUMMY_RD_EN
@@ -401,7 +407,7 @@ static void nbif_v6_3_1_ih_control(struct amdgpu_device *adev)
 				       IH_REQ_NONSNOOP_EN, 0);
 
 	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 5))
-		WREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL_nbio_7_11_5, interrupt_cntl);
+		WREG32_SOC15(NBIO, 0, regBIF_BX1_INTERRUPT_CNTL_nbio_7_11_5, interrupt_cntl);
 	else
 		WREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL, interrupt_cntl);
 }
@@ -427,7 +433,7 @@ nbif_v6_3_1_get_clockgating_state(struct amdgpu_device *adev,
 static u32 nbif_v6_3_1_get_hdp_flush_req_offset(struct amdgpu_device *adev)
 {
 	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 5))
-		return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FLUSH_REQ_nbio_7_11_5);
+		return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF1_GPU_HDP_FLUSH_REQ_nbio_7_11_5);
 	else
 		return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FLUSH_REQ);
 }
@@ -435,7 +441,7 @@ static u32 nbif_v6_3_1_get_hdp_flush_req_offset(struct amdgpu_device *adev)
 static u32 nbif_v6_3_1_get_hdp_flush_done_offset(struct amdgpu_device *adev)
 {
 	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 5))
-		return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FLUSH_DONE_nbio_7_11_5);
+		return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF1_GPU_HDP_FLUSH_DONE_nbio_7_11_5);
 	else
 		return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FLUSH_DONE);
 }
@@ -622,7 +628,7 @@ static void nbif_v6_3_1_set_reg_remap(struct amdgpu_device *adev)
 	} else {
 		if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 5))
 			adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
-				regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL_nbio_7_11_5) << 2;
+				regBIF_BX_PF1_HDP_MEM_COHERENCY_FLUSH_CNTL_nbio_7_11_5) << 2;
 		else
 			adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
 				regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
-- 
2.43.0

