Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5DCC07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2520610CC
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2520610CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 245CF6E436;
	Tue, 20 Jul 2021 15:44:23 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2065.outbound.protection.outlook.com [40.107.95.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 596426E43A
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 15:44:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPNiwmivVEjqCI+p+6/y2eF3qV2B1pLZgeIQmIKsv3fgUXu2jKWCxXyA4U+SJuCxiRJ0A8rSLbruHRCmjOhYA4xkQC8n/FvTx77pdAdAJjgl1YLZcRbEGd/vif0CO2CsgjlleMlDCY7tn8/AJ9ECwvBJ99cPsL6G50xhUthvI245KYqYZD2ooV/d4ekAoC8TX1CxyeFDmkV89j3W4IEyJTGjVoLYKRXlGXot8N8gYatZgetv+wyyQOjg2GeQS+SHvoXQ9Y3yJ5L+jNUF0rF26bg5JML9BI/RuCijgD1VIYjj/ll4wQSvucVV9YCo8GgggkM6Bu51hSv3+m3wlAapJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePjlpbM7c4ENRZ2+98MChOLfOYKvunJPdVDkiTshwtM=;
 b=dmB60mxu1lbM7az3QUwV7mFIQypy5dy4vnaAfUNbckHjGTbdQ1cF8XEi7/ht+5j0u5xM29kmpm9t+9z38S2tu4TyzZY4WAc+xPlVOw41lM5QxNz+TcZHiSeI3Re7FhLN434cTjOxPIVKquk+ge+fX0Ubf98Xif893rD8B1n1JLXxabuGld/xIPTuGxUfDVATdT3vXRhW28H8OECIKmcv6ZOXCntliOCe76rGT5Z8GY0qyReNdqpNT3IYERFQOhnloZLLf9Kr3UQSIqa2v4d79XQGKXajFG7BBREDzaUVSxfCGDPcRT3ubQHmSu9Xv2hFQoIarxs+s6RsO+jhtSb3Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePjlpbM7c4ENRZ2+98MChOLfOYKvunJPdVDkiTshwtM=;
 b=YrHrl3+Bx+L1Id3Gl9TnwKQx8VVqyXUmdHIdH27TKv7WT4XXhuvhEe1K5s58mGMBetFAPV7qqBdDZtI24BK1UTF78lxpuh2RFSPRdZedrWeR2lW+yxutseZ0J0fxM0Io3BKFnTx1DxFM88ZJ6Pa+W/N2cXE3EKst2jB/I1Qxoi4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Tue, 20 Jul
 2021 15:44:20 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 15:44:20 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 18/29] drm/amdgpu: add psp v11.0.8 driver for cyan_skillfish
Date: Tue, 20 Jul 2021 11:43:38 -0400
Message-Id: <20210720154349.1599827-19-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210720154349.1599827-1-alexander.deucher@amd.com>
References: <20210720154349.1599827-1-alexander.deucher@amd.com>
X-ClientProxiedBy: MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37)
 To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.22 via Frontend Transport; Tue, 20 Jul 2021 15:44:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f47f925-7b40-4b69-bd72-08d94b953d48
X-MS-TrafficTypeDiagnostic: BL1PR12MB5349:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB53495F320C68D07FF80B2795F7E29@BL1PR12MB5349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:62;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4WAlCJ0PbYj5AR+F7GAcX8KHGIxnIzooleCz39HXJ4c+kQ4aF8ui3q5QWAa6Zxk1VUN3Vljh8o//9nSZQDK/+f0zrV1z0fEpNz1KEoxWBJna8O5ufFJpvfK9kROaBHeMPKGuVSl023n08TprN+KzHS6srvqToFLb3mASyleLq0JYNzb0fUD2352635OZIcniiA/D6RkCqBtk4h8kymxjll91PPvhlk24kEd9GJMORnQK3xII5NsUAlrLXR3ZWQ3rkMO1TR7l1FEitwikL+0huwkiSXoJ0EfA/D3A0XkHqJ0xtZKnUmzjMQLdEmrilzWfB8M2UlLNo+DscETQF/QaMadvdczQ9TjugMXM9D7FFRfzNhGsqIInxmIvkUwryc87P9xag7GaCKl78KlwOfi3PEjXUaIW1qoeeHn0aJ/h5oS3U2442L5qD6dDpRMEd+GGQSEQnjkq+iYsc5OzkgT4ZHBCELOCXmfJDytN/966b1wGoFHVTzpUDb4BMynh+D9r60Ve8NgVCzEoPyiyUPTmShxtSVfUn853HzD92+rtGU7mpOlru6KDHD+4ljsg95afMXYt18uhrlS2gXnWE2Rdmpwroz2kxMTw8p3viyJ9K7NDE2Q4sXG38bHjhpADPeZIqHRQ0vKTWfLwJAWHzDCCon64JCnp9DwdeEGEpFBpVE+1fTy9qVYT7uAyszukQWUyjIXGnYye2jrs9MD3qkxEiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(2616005)(86362001)(6916009)(38100700002)(6486002)(83380400001)(54906003)(6666004)(956004)(478600001)(316002)(1076003)(4326008)(52116002)(2906002)(66946007)(38350700002)(66476007)(5660300002)(8936002)(36756003)(7696005)(66556008)(8676002)(26005)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zkGXCe4gnkDo/n49sE+ZEz2Vk6uYSdxpmybaRCNxyKWBZigYAGNFnO2CPuWr?=
 =?us-ascii?Q?UcZS5X/dLMyaxqDhMyvSuYgAfVZjB4JrSvAJhOrtRmHMmwdz01xxZDl6PKPD?=
 =?us-ascii?Q?Re94WT/IBx7i2LqCEEBnu1j0K60m/2Sft5MSsFxq/DleW3OaMyZzUXUa5tzV?=
 =?us-ascii?Q?JhaUxgbikWbtZITOMuMMgGhobGc7psa1yDqyoZIFU9MLI181g0+35OpNK240?=
 =?us-ascii?Q?2q6C5qD1AbOPH7zHm7SPgYuHpl4u2Tf4OKqPKjZPyYySp/dznl5EdNwItoEy?=
 =?us-ascii?Q?DlM5RoqvQfXPrbE5tWtb3EJhGSyBUu/46twCkudQ/X5z5wFaHllx87HWMmjL?=
 =?us-ascii?Q?R0pV9Q2klsvIJkV39u5/ubi/qWEPnmUV6B711l0f9Z8JXAlCMKRdiLQtYbqD?=
 =?us-ascii?Q?npkMHhtKe448h0YmGqbDPYH9audWLBy4aJtcoxBUaOzAmWjyGbpe+y2UbrGt?=
 =?us-ascii?Q?N2f/aZTgViNdWYRPgqdBgXanmrPBmxnGIMc5PX0KbunYR6wzVdtK9QqQhcMi?=
 =?us-ascii?Q?0VAnDSOhqmknJo+KUxKTjlIBKeaPDcA0pa0apy6Cvb3f39qa4NokxwgAOZ8Z?=
 =?us-ascii?Q?y12jRxsEVu6Ye0bm2u+UunK6sL7eiSabKOzTD0P3FGJIMpAlD8N3ddoVyQjh?=
 =?us-ascii?Q?/0u99f+7coL/SbtlbnTUn2ifH6ArI6uoznqQbZPsbrsErumfIU2PglOt5UFB?=
 =?us-ascii?Q?LRlLfmzVXZUfRzXbV1Vz3mghqzBRPcuBqC/b+mFpBXUZcrxl3o/CcT4RqanW?=
 =?us-ascii?Q?XM1fVXFv5Kbrq+NE5rbRbO44OfC4yCGH2qNRosDiTQUP6dahERZj4TyQS/DP?=
 =?us-ascii?Q?ZlDDbn6OP6gAlpfwFU+C26qQDdWGYsMdyfyPyR8OGWLTvUuMSf4uZpdn9IQ0?=
 =?us-ascii?Q?0kiK5hSQjzvWmJownk1DixrW6LKIkGk07EoDDcwQWkotlT5hfu+J5phLHeGE?=
 =?us-ascii?Q?clyFj28BMpo30WF1FGj5N7hSbkgUJhdaUXTUOOq+DqUtALPCbopr9n1gTmZQ?=
 =?us-ascii?Q?uiBPQY0jXPLUqKp/cq8IUBWD9sfpdfPxn0vjhPl9Sbtwj7YMyyctS2mpdHX7?=
 =?us-ascii?Q?njHpDPfxEzS/kQfFgdjPycfmkKszZ96T75JpHbrCOM++I8+zSjsv0bg+X0su?=
 =?us-ascii?Q?ieU+eaocALviXolpncyjemy8DEJmO49znNnjGwEn56M7/EdzGlbVN2TbeRF8?=
 =?us-ascii?Q?zkWZLXGuGYXq25Ruxqzema1MnipJSwG97FYqNOk6RJVkom7C5/HCLj3qMQRu?=
 =?us-ascii?Q?ot5hPFzxojmP/RlCz/s+N9l/YCQF8JFx9WLowlqnPf8jvfLgtLpneaGbE1oC?=
 =?us-ascii?Q?LQnZ4cEZl5g2VXZVyVDiseki?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f47f925-7b40-4b69-bd72-08d94b953d48
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 15:44:20.2472 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xfoaxHXRrBJr/uUhWT1w+2JqLF7n/mCdNWglWff5vtMzURg6t6hN12oR+pB2Io7TLDM4keMb8/ul8rIuGDJwmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5349
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lang Yu <lang.yu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <lang.yu@amd.com>

Introduce the psp v11.0.8 driver for cyan_skillfish.

Signed-off-by: Lang Yu <lang.yu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile      |   1 +
 drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c | 208 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.h |  30 ++++
 3 files changed, 239 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index aa5ca7e227e6..f089794bbdd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -112,6 +112,7 @@ amdgpu-y += \
 	psp_v3_1.o \
 	psp_v10_0.o \
 	psp_v11_0.o \
+	psp_v11_0_8.o \
 	psp_v12_0.o \
 	psp_v13_0.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c
new file mode 100644
index 000000000000..ff13e1beb49b
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c
@@ -0,0 +1,208 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+#include "amdgpu.h"
+#include "amdgpu_psp.h"
+#include "amdgpu_ucode.h"
+#include "soc15_common.h"
+#include "psp_v11_0_8.h"
+
+#include "mp/mp_11_0_8_offset.h"
+
+static int psp_v11_0_8_ring_init(struct psp_context *psp,
+			      enum psp_ring_type ring_type)
+{
+	int ret = 0;
+	struct psp_ring *ring;
+	struct amdgpu_device *adev = psp->adev;
+
+	ring = &psp->km_ring;
+
+	ring->ring_type = ring_type;
+
+	/* allocate 4k Page of Local Frame Buffer memory for ring */
+	ring->ring_size = 0x1000;
+	ret = amdgpu_bo_create_kernel(adev, ring->ring_size, PAGE_SIZE,
+				      AMDGPU_GEM_DOMAIN_VRAM,
+				      &adev->firmware.rbuf,
+				      &ring->ring_mem_mc_addr,
+				      (void **)&ring->ring_mem);
+	if (ret) {
+		ring->ring_size = 0;
+		return ret;
+	}
+
+	return 0;
+}
+
+static int psp_v11_0_8_ring_stop(struct psp_context *psp,
+			       enum psp_ring_type ring_type)
+{
+	int ret = 0;
+	struct amdgpu_device *adev = psp->adev;
+
+	if (amdgpu_sriov_vf(adev)) {
+		/* Write the ring destroy command*/
+		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_101,
+			     GFX_CTRL_CMD_ID_DESTROY_GPCOM_RING);
+		/* there might be handshake issue with hardware which needs delay */
+		mdelay(20);
+		/* Wait for response flag (bit 31) */
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101),
+				   0x80000000, 0x80000000, false);
+	} else {
+		/* Write the ring destroy command*/
+		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64,
+			     GFX_CTRL_CMD_ID_DESTROY_RINGS);
+		/* there might be handshake issue with hardware which needs delay */
+		mdelay(20);
+		/* Wait for response flag (bit 31) */
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
+				   0x80000000, 0x80000000, false);
+	}
+
+	return ret;
+}
+
+static int psp_v11_0_8_ring_create(struct psp_context *psp,
+				 enum psp_ring_type ring_type)
+{
+	int ret = 0;
+	unsigned int psp_ring_reg = 0;
+	struct psp_ring *ring = &psp->km_ring;
+	struct amdgpu_device *adev = psp->adev;
+
+	if (amdgpu_sriov_vf(adev)) {
+		ret = psp_v11_0_8_ring_stop(psp, ring_type);
+		if (ret) {
+			DRM_ERROR("psp_v11_0_8_ring_stop_sriov failed!\n");
+			return ret;
+		}
+
+		/* Write low address of the ring to C2PMSG_102 */
+		psp_ring_reg = lower_32_bits(ring->ring_mem_mc_addr);
+		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_102, psp_ring_reg);
+		/* Write high address of the ring to C2PMSG_103 */
+		psp_ring_reg = upper_32_bits(ring->ring_mem_mc_addr);
+		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_103, psp_ring_reg);
+
+		/* Write the ring initialization command to C2PMSG_101 */
+		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_101,
+			     GFX_CTRL_CMD_ID_INIT_GPCOM_RING);
+
+		/* there might be handshake issue with hardware which needs delay */
+		mdelay(20);
+
+		/* Wait for response flag (bit 31) in C2PMSG_101 */
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101),
+				   0x80000000, 0x8000FFFF, false);
+
+	} else {
+		/* Wait for sOS ready for ring creation */
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
+				   0x80000000, 0x80000000, false);
+		if (ret) {
+			DRM_ERROR("Failed to wait for trust OS ready for ring creation\n");
+			return ret;
+		}
+
+		/* Write low address of the ring to C2PMSG_69 */
+		psp_ring_reg = lower_32_bits(ring->ring_mem_mc_addr);
+		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_69, psp_ring_reg);
+		/* Write high address of the ring to C2PMSG_70 */
+		psp_ring_reg = upper_32_bits(ring->ring_mem_mc_addr);
+		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_70, psp_ring_reg);
+		/* Write size of ring to C2PMSG_71 */
+		psp_ring_reg = ring->ring_size;
+		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_71, psp_ring_reg);
+		/* Write the ring initialization command to C2PMSG_64 */
+		psp_ring_reg = ring_type;
+		psp_ring_reg = psp_ring_reg << 16;
+		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64, psp_ring_reg);
+
+		/* there might be handshake issue with hardware which needs delay */
+		mdelay(20);
+
+		/* Wait for response flag (bit 31) in C2PMSG_64 */
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
+				   0x80000000, 0x8000FFFF, false);
+	}
+
+	return ret;
+}
+
+static int psp_v11_0_8_ring_destroy(struct psp_context *psp,
+				  enum psp_ring_type ring_type)
+{
+	int ret = 0;
+	struct psp_ring *ring = &psp->km_ring;
+	struct amdgpu_device *adev = psp->adev;
+
+	ret = psp_v11_0_8_ring_stop(psp, ring_type);
+	if (ret)
+		DRM_ERROR("Fail to stop psp ring\n");
+
+	amdgpu_bo_free_kernel(&adev->firmware.rbuf,
+			      &ring->ring_mem_mc_addr,
+			      (void **)&ring->ring_mem);
+
+	return ret;
+}
+
+static uint32_t psp_v11_0_8_ring_get_wptr(struct psp_context *psp)
+{
+	uint32_t data;
+	struct amdgpu_device *adev = psp->adev;
+
+	if (amdgpu_sriov_vf(adev))
+		data = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_102);
+	else
+		data = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_67);
+
+	return data;
+}
+
+static void psp_v11_0_8_ring_set_wptr(struct psp_context *psp, uint32_t value)
+{
+	struct amdgpu_device *adev = psp->adev;
+
+	if (amdgpu_sriov_vf(adev)) {
+		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_102, value);
+		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_101,
+			     GFX_CTRL_CMD_ID_CONSUME_CMD);
+	} else
+		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_67, value);
+}
+
+static const struct psp_funcs psp_v11_0_8_funcs = {
+	.ring_init = psp_v11_0_8_ring_init,
+	.ring_create = psp_v11_0_8_ring_create,
+	.ring_stop = psp_v11_0_8_ring_stop,
+	.ring_destroy = psp_v11_0_8_ring_destroy,
+	.ring_get_wptr = psp_v11_0_8_ring_get_wptr,
+	.ring_set_wptr = psp_v11_0_8_ring_set_wptr,
+};
+
+void psp_v11_0_8_set_psp_funcs(struct psp_context *psp)
+{
+	psp->funcs = &psp_v11_0_8_funcs;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.h b/drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.h
new file mode 100644
index 000000000000..890377a5afe0
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+#ifndef __PSP_V11_0_8_H__
+#define __PSP_V11_0_8_H__
+
+#include "amdgpu_psp.h"
+
+void psp_v11_0_8_set_psp_funcs(struct psp_context *psp);
+
+#endif
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
