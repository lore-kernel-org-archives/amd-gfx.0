Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB6DC52CDC
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 14:08:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25D1010E90E;
	Thu, 18 Jul 2024 14:08:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gJTPdRLz";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 097B910E8E4
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 14:08:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLPZB+MmIx/fu4b+zlRN9wtg3FIWcht3weYv6jST+vx2BKwpUVAqUFpK5So442Sbiia6tt/Eg2Tclb+Vf1RI8YQR+wR+hRZqTj75qR+g5k+fgsGFWEIa4MV3yuk5N+cdAD3TTEr/41qSJtR0n5cI6Yg8/zx19+3jtF1YwGYlDpYRsjr8mzGSNjC4D6xEdvt5TeDQ7ZX4yEwoUYBxZTdeqysCZiDRtl4qUdFlk3U6GGxg1zgNGuNmeIiRBOBP+FKM6YE5Z20piySvsD6SVr48B/6qlZdxz54Eg6CrO3LwUnj+SzN9hzrSX2yoE6rAJZhtPEHn9+XA8adCoprV/Nqdlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgRfwY/wm1Hz6UsAlR2sM5fEPwZgdukelLOIL2gfphk=;
 b=zJgohyjx7MfkIEKJUDUh4+bvrtZn9xwiHWxfItHq7Pw7d/D45OOlAXmIsyLGNTBEb0Jweujh9W1JoUiLlrS3gGlTgLZ6A/St0Ki2ElD1AUJKj8oN6NxQUUxROz2GM3oXGqrzEUPJDiL3sRhMWJ925RDQEO1+CRLjWHy9009TixEujFO+FRsfbwF8jkYN5hipXy46vERiU8h3kt9XJAnG064Ve1m19U4HJH38U1qCDp6zsCT9dwX/04jBGoLQ6/UtQcdUmQtMku/FysNuZ6rDQKBlNQ8Of9mblxEuaobgz7SVgckMsrNoponXJvU8EN03ii5hgdnSSHm+o9DyxIGYFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgRfwY/wm1Hz6UsAlR2sM5fEPwZgdukelLOIL2gfphk=;
 b=gJTPdRLzEzZ1Xm8U28ymkAmsmwgG1KqTQDy3KZ6r0zQBRrXaWFfvdWLCctfaUoZzmyUGWn83TItADa0K0DgLApbmTDWiFYRhSnYmbY/O/YGyu9UIs+7L5O7hY3Wce4KGfKzx4RyFaNwjho/NW+4DTjxstC+54ptugSi5lHgsM/k=
Received: from BL1PR13CA0072.namprd13.prod.outlook.com (2603:10b6:208:2b8::17)
 by PH7PR12MB8778.namprd12.prod.outlook.com (2603:10b6:510:26b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.30; Thu, 18 Jul
 2024 14:08:08 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:2b8:cafe::ef) by BL1PR13CA0072.outlook.office365.com
 (2603:10b6:208:2b8::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16 via Frontend
 Transport; Thu, 18 Jul 2024 14:08:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 14:08:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 09:08:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jiadong Zhu <Jiadong.Zhu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 27/34] drm/amdgpu/gfx9: implement reset_hw_queue for gfx9
Date: Thu, 18 Jul 2024 10:07:26 -0400
Message-ID: <20240718140733.1731004-28-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718140733.1731004-1-alexander.deucher@amd.com>
References: <20240718140733.1731004-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|PH7PR12MB8778:EE_
X-MS-Office365-Filtering-Correlation-Id: dc3c2543-85b3-4d4b-445f-08dca7330ccf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uHd53i6JnSA5U+X8FlWRsDY2mnKPDIBoZT/MasrIWBDE9xzRCsv1uMwPymIH?=
 =?us-ascii?Q?ycBfF9xUIkJGv7nutUx1rl347Sj7fCnh+n188thok9FhdrGJqIW50RMXdyC5?=
 =?us-ascii?Q?jj3zxcnwo6t6NzsJx0YXmu5qy3Sd3GFrVIG8In6rt++psM2GJYglRP19Ulvp?=
 =?us-ascii?Q?J+xu89DN4JeGm0XH2n9X/nsEkfpIOCv/cD6zJ96ufzdv6ORWIWspKYlcG4bu?=
 =?us-ascii?Q?Svmw/BiMWhNXKSbk0DKN2zJqpX0cfMjUnpQHtiivyEUvL5XqBsEUt0BaTp1T?=
 =?us-ascii?Q?hSZaTdY85W6zdJlqxIKM5SMTYpNdH/2snCvM0VydMpn4auAeb+CkW20QPQU9?=
 =?us-ascii?Q?KCU8DiIqxMpTKvNCcrBKaKVbrWmRBvw7Evlb2BQu7w95onURGogDdpqGcMTi?=
 =?us-ascii?Q?INoZh5XU2nsYDUYLjZVkhh0QKYDhh8pBAwTYhrUSFGPgIV3Z/x8wHhmD7O7W?=
 =?us-ascii?Q?0oYaWtHItbGBBuXSVXlsYLL5pa6bQyaKLPTzL3MYlKolfdzNRy17mAu16m25?=
 =?us-ascii?Q?mw4sO5pIIL+WiX2HfQXR7ULfQ9FaKbhoiNP18Ny9fhv4iRsEuISlFK7h+DaS?=
 =?us-ascii?Q?GFNJj+9c5Xqzq8KggtA8O1RWMZqSeiNKfYfNZZUnA74j9Y16qElbF8nZ9lFD?=
 =?us-ascii?Q?2sNs51jXCksrLFnwMhAcls3cqeFmHfTR96EAJbiIZIE+FvXvkuogEQFQQGuw?=
 =?us-ascii?Q?Th+QDHf1U4trIPwl0ctkU6WP2mKjXRk3kJOJk53bj97YI0oRCeSy/kXl2Wx+?=
 =?us-ascii?Q?OaPIGIHFIJ0GAECjQ3z14IvHUisi7wCardIQfnUwF767x8NS4OQ8tVdIzwYq?=
 =?us-ascii?Q?IiFMk0dx3ofBAi0mep2z7+5ie3a81Zpg66Kw5s9h/0LqMgIK8UVWLD6AX8Fy?=
 =?us-ascii?Q?CvmH2DycDKZxqEycKK6K+/0t0+XFtk8joRb7knWssY7O2Y1JtgXj+ghLCw2L?=
 =?us-ascii?Q?rZBrmuYnXMI8xB2pw6QjVdS1ssDxWOw0TNVF025wTQBqNUf7RW7JBqSSuhLG?=
 =?us-ascii?Q?yZPHrzQkogh/Hq5qpHFsFhc93vKlOFOnPI5KhHmXBsisW98U9ZpN6goOme6F?=
 =?us-ascii?Q?JtcO2faSbf0DGMTr5XbfRwoVjJO8ALQTWdFxliJxUh30ODjCNd/mX9C1kIec?=
 =?us-ascii?Q?HbGZ51kRt+ssFYa4aQ9J6bpm5Mp+O5e0Bg6gCoRw7XOS8R4J71N3QAzK4vPM?=
 =?us-ascii?Q?rnC+GmqURRJg0rolMKuFuS4PAGuHfehPOgJP0vwjh0Qlvxr92OvG+sTlYZD8?=
 =?us-ascii?Q?q+cuJKtA4i4X01BX3LzrBEUUfaYBWczIUYdI4N2GS7nOn7q+b8oO9C9C7AeX?=
 =?us-ascii?Q?0Xog+LjPfHGefAvPpEvO9Zu+c8cyfvmQMOnhPswn6jpLnQf8uUB+6rGnMJMh?=
 =?us-ascii?Q?YDnCbMIyppTMyx+zjhESvF8lJsmWZN35frd3gGlovdC0Vzwn0SKbN98I/hWG?=
 =?us-ascii?Q?O+iYZwcioFKnmvgyw6RLV++mA3sr6ut5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:08:07.9067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc3c2543-85b3-4d4b-445f-08dca7330ccf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8778
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

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

Using mmio to do queue reset. Enter safe mode
when writing registers.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 37 +++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index fdc3fb636e02..1a04f52ce0a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -893,6 +893,8 @@ static int gfx_v9_0_ras_error_inject(struct amdgpu_device *adev,
 static void gfx_v9_0_reset_ras_error_count(struct amdgpu_device *adev);
 static void gfx_v9_0_update_spm_vmid_internal(struct amdgpu_device *adev,
 					      unsigned int vmid);
+static void gfx_v9_0_set_safe_mode(struct amdgpu_device *adev, int xcc_id);
+static void gfx_v9_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
 
 static void gfx_v9_0_kiq_set_resources(struct amdgpu_ring *kiq_ring,
 				uint64_t queue_mask)
@@ -1004,12 +1006,47 @@ static void gfx_v9_0_kiq_invalidate_tlbs(struct amdgpu_ring *kiq_ring,
 			PACKET3_INVALIDATE_TLBS_FLUSH_TYPE(flush_type));
 }
 
+
+static void gfx_v9_0_kiq_reset_hw_queue(struct amdgpu_ring *kiq_ring, uint32_t queue_type,
+					uint32_t me_id, uint32_t pipe_id, uint32_t queue_id,
+					uint32_t xcc_id, uint32_t vmid)
+{
+	struct amdgpu_device *adev = kiq_ring->adev;
+	unsigned i;
+
+	/* enter save mode */
+	gfx_v9_0_set_safe_mode(adev, xcc_id);
+	mutex_lock(&adev->srbm_mutex);
+	soc15_grbm_select(adev, me_id, pipe_id, queue_id, 0, 0);
+
+	if (queue_type == AMDGPU_RING_TYPE_COMPUTE) {
+		WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, 0x2);
+		WREG32_SOC15(GC, 0, mmSPI_COMPUTE_QUEUE_RESET, 0x1);
+		/* wait till dequeue take effects */
+		for (i = 0; i < adev->usec_timeout; i++) {
+			if (!(RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE) & 1))
+				break;
+			udelay(1);
+		}
+		if (i >= adev->usec_timeout)
+			dev_err(adev->dev, "fail to wait on hqd deactive\n");
+	} else {
+		dev_err(adev->dev, "reset queue_type(%d) not supported\n", queue_type);
+	}
+
+	soc15_grbm_select(adev, 0, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+	/* exit safe mode */
+	gfx_v9_0_unset_safe_mode(adev, xcc_id);
+}
+
 static const struct kiq_pm4_funcs gfx_v9_0_kiq_pm4_funcs = {
 	.kiq_set_resources = gfx_v9_0_kiq_set_resources,
 	.kiq_map_queues = gfx_v9_0_kiq_map_queues,
 	.kiq_unmap_queues = gfx_v9_0_kiq_unmap_queues,
 	.kiq_query_status = gfx_v9_0_kiq_query_status,
 	.kiq_invalidate_tlbs = gfx_v9_0_kiq_invalidate_tlbs,
+	.kiq_reset_hw_queue = gfx_v9_0_kiq_reset_hw_queue,
 	.set_resources_size = 8,
 	.map_queues_size = 7,
 	.unmap_queues_size = 6,
-- 
2.45.2

