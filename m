Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D17C25B74
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 18:46:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0D8E11230E;
	Mon,  6 May 2024 18:46:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e7aI2x0f";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40236112309
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 18:46:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0lmAWAfx822OePEYFv/Tc+WOo5aDo3ve4mrplTXZEJYc4xNxpEnVdRSeFVv8CZfj3lBuAfAXLsbLkQMPKIe8NJUVuGsjrnMUkmszF0FEn+G7ptm8rkfVaCfg9I5lMDur/NjWXw3PpatQtiwApQbKXpr6uTdOmm2Uo5FQWf35huTmRF/5P8ezyD8ivvvqhn/JA2pEWOU9u4j7QO+qnJA3Kq/6lntpNgSbUyrVCjgN3VEJBcNvkmvchyW2uqsYflAOw5rqe6G0rnpWUOsiBFqgqpNm6OqohtOFm2t+MW2y3nH0uClKZZtys/K7WWzU3ckxV+CIDDQ7x3yh98O5BZPeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keeqPeFt78LYhmIOSrb1TKyTr2J+pj9EAHSGFFIJuvg=;
 b=Bn3i9BPAUifDWXqnrSFn4Q6BqOJ5fJSW6ur0+jSI9AutXe6sU0HYAmQa126Ck8TlJmiFDW3OWwWg1e3BOW0v+wfpkGSSUnQWENTSM3v14i99udplF5cIoI0v5QgcyESYew5qVX3Rio3sfa9E837UoTwb5CRwEtzAz7X3XyE23OQE/M1ApMQ4f3ImiPGY3Br8VVVuvkiFQEmgpD0+HijbME9+tDsjHiCu4FTNh0igzgC9RLsSswsDHMwXUmMb7DNaRy+gN755TLSiP7s36q/dfCNAMX9aN6gUT8OH8pTrEGYH0wRdImclU8t2g26d8oblpXOFspbeOfzwKh5Zl5/zOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keeqPeFt78LYhmIOSrb1TKyTr2J+pj9EAHSGFFIJuvg=;
 b=e7aI2x0fRV1Oa75XBh5plEmDYWrK9IcTz877yl6hIYTHK3nxPMJ1XKRZrIF2TERUM0SPH8j+7KdEffsx6uLGG/SYPcaYcQg/mzjeWmXL2KDGVdril3C1EGleAV7BhFgRV+zZ+QpT9VhepmEra8Ey+vXxEEqLZpCLxZO49ge3D/c=
Received: from PH0P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::24)
 by SJ2PR12MB9139.namprd12.prod.outlook.com (2603:10b6:a03:564::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 18:46:06 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::34) by PH0P220CA0017.outlook.office365.com
 (2603:10b6:510:d3::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Mon, 6 May 2024 18:46:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 18:46:05 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 6 May
 2024 13:45:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>
Subject: [PATCH 09/14] drm/amdgpu: add set_reg_remap callback for NBIO 4.3
Date: Mon, 6 May 2024 14:45:34 -0400
Message-ID: <20240506184539.1669157-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240506184539.1669157-1-alexander.deucher@amd.com>
References: <20240506184539.1669157-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|SJ2PR12MB9139:EE_
X-MS-Office365-Filtering-Correlation-Id: 89a7edbb-a955-496e-6160-08dc6dfcc975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400017|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GSN0uZHI2QiCnn5YaOG4jqpylj5B6X1y7GyKwQqL/Ua/FIOGlyALgF+I9ygh?=
 =?us-ascii?Q?1T0zj2EHXjhbQMfqLXcYbStHp1iTWpCT3JMxGoA7ZUA44/IHzz8PY/JsKOKA?=
 =?us-ascii?Q?1otM70HiVNH+fcTaPUPSziSVAjFVr3LpApUCrMx40X06Fr3/1Zqk8dUFqYUE?=
 =?us-ascii?Q?97jxCAcY9+h5rcgC1QaPUW3pmlhEdgRsSVHv4GXYuo7KPsoPLWv35J4aX3P9?=
 =?us-ascii?Q?tyomXz0rJ7d0JnuSaih663wrSK2f4NVumCNK7qmCn9NtV+ApPicOyautan6a?=
 =?us-ascii?Q?S+VKXOX5mu1cMvCTi9RoslltyB29ZQF03CB7qeDPbAlXpu/FU0w2ql50BKIt?=
 =?us-ascii?Q?iSui5C18mPnyAEHSGcMEx4Or4G8fs/Zk6n4VUAsbqnV+P6qZaKR9JUWWWc8D?=
 =?us-ascii?Q?gGVhUuSO+b6qXhXZOEtPM2hGUpJLCXEpCqo7n6S7uz+a8vTuRssQeFBFcK8i?=
 =?us-ascii?Q?HkHmP8m+eGxMlUd0OAxM53QSszDvWxw/TZz0+Gy7ChrPEdO2kQJYaDSCgZMD?=
 =?us-ascii?Q?4dAl2+yJaj9fQ8wyecAimYQAWwPKmfFtAOKr7drDdpVQSqKcVjBJaDuEhSeN?=
 =?us-ascii?Q?pMa7jfjIk/T4cRk6s9AIXNtr7VSL+cIbZa9CsEdS+d/Rr7g/wulMpU/BZ/b4?=
 =?us-ascii?Q?aPh7z3/w0XzhtPLXdy1J1B9jK7EMVnDhwl02dATjJZKnmMynHQvrTZDo1GNs?=
 =?us-ascii?Q?A/htShOuLTtZ/sMusXRAB1j1cgULXXVU0VOECDX9vZfbQBTHTb68l1DE0Ser?=
 =?us-ascii?Q?OkrrjS2YhPUXH2sd13K1Xk5fyYW2cuE+pla3U1uqDr3clOkMfBzXInQYIEwZ?=
 =?us-ascii?Q?59KcTce7X3Ki9tLwmnLYd/hWLkbOqARfo1dK5QVe/y2QYxyxw3HFI8SRVPpH?=
 =?us-ascii?Q?N51JC0iklDf6l3ESapHp44OWS1NKFlb3SEMvk3Py8Zei3ie0YLtl0ow++VHa?=
 =?us-ascii?Q?ZEvwJRucNS3DcUsMTKGxPGbd3kL0xYz/+MR1o86QVFVs3hpfeXFTbm6nji1s?=
 =?us-ascii?Q?EANoGNGKkp/8YK86R+fI1fd1+eA4HRbHPKghbvIqz4qFP/BcKgV4cN6LLpwl?=
 =?us-ascii?Q?d9aMSvhOx2hXJbQxViVpSH0ZDmBVA2CXKA9wJh9KNB775ZR3ngKbOOS7i0h3?=
 =?us-ascii?Q?nuxahOgmrP9ddGrBjeu/w2Agff7O06hJ0oABhGJBXeaLB2ET9tw9M1S1F69W?=
 =?us-ascii?Q?Qxx17+InaB1NnEa7uWiy1MwK1M++8iPt1Fcc+i63W+KbCwTMcBgPDttJt265?=
 =?us-ascii?Q?QMbLpv4E3wGLxUuenO/RvT6Mny/Q9//g9bHMYrAz0xRfW3Ts7QPTzwTLnPVA?=
 =?us-ascii?Q?iRDhLQ1/7JUgM9iP1f4HVfSKpfTXeJQWAjTVRxR9PwNMPIrTbDuAzQqwVejG?=
 =?us-ascii?Q?WKHPOOqVfJFvFR5SKLKVp/PJPqJG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400017)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 18:46:05.7773 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89a7edbb-a955-496e-6160-08dc6dfcc975
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9139
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

This will be used to consolidate the register remap offset
configuration and fix  HDP flushes on systems non-4K pages.

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
index a3622897e3fe3..da731a6f6c063 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
@@ -475,6 +475,20 @@ static void nbio_v4_3_program_aspm(struct amdgpu_device *adev)
 #endif
 }
 
+#define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
+
+static void nbio_v4_3_set_reg_remap(struct amdgpu_device *adev)
+{
+	if (!amdgpu_sriov_vf(adev) && (PAGE_SIZE <= 4096)) {
+		adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
+		adev->rmmio_remap.bus_addr = adev->rmmio_base + MMIO_REG_HOLE_OFFSET;
+	} else {
+		adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
+			regBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
+		adev->rmmio_remap.bus_addr = 0;
+	}
+}
+
 const struct amdgpu_nbio_funcs nbio_v4_3_funcs = {
 	.get_hdp_flush_req_offset = nbio_v4_3_get_hdp_flush_req_offset,
 	.get_hdp_flush_done_offset = nbio_v4_3_get_hdp_flush_done_offset,
@@ -497,6 +511,7 @@ const struct amdgpu_nbio_funcs nbio_v4_3_funcs = {
 	.remap_hdp_registers = nbio_v4_3_remap_hdp_registers,
 	.get_rom_offset = nbio_v4_3_get_rom_offset,
 	.program_aspm = nbio_v4_3_program_aspm,
+	.set_reg_remap = nbio_v4_3_set_reg_remap,
 };
 
 
@@ -541,6 +556,7 @@ const struct amdgpu_nbio_funcs nbio_v4_3_sriov_funcs = {
 	.init_registers = nbio_v4_3_init_registers,
 	.remap_hdp_registers = nbio_v4_3_remap_hdp_registers,
 	.get_rom_offset = nbio_v4_3_get_rom_offset,
+	.set_reg_remap = nbio_v4_3_set_reg_remap,
 };
 
 static int nbio_v4_3_set_ras_err_event_athub_irq_state(struct amdgpu_device *adev,
-- 
2.44.0

