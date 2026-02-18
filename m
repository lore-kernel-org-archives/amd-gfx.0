Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D475CE9A02C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Feb 2026 19:34:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6498910E30E;
	Wed, 18 Feb 2026 19:34:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V9zm655W";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010020.outbound.protection.outlook.com
 [40.93.198.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70B0D10E30C
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Feb 2026 19:34:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QUWECvxRR2sidh3gYDFJH5ZL7GPSk+88SiTSXAipmnms3VhGR8cOUJmKWqLzVfVxbzzIK6UDlbH4J5R7UCjKOvqxclAdAmGHMVTBNRn1SAnmuv6fysErlIm1lEI8XezoVRu9PdBMGmh1WWlr3IMLfVSZy1kpoM4iYC6SnByC35V+fsb2SgCv6r9tvww3YFlcGZS6X0bfxhVZBNWfUr1n9mqOGlwS2mavuflJLOFKMxNJeCYS2+S8LIOByGC69ioR4vA6F+aO7LQRkj9nm13CPkD4ImBFJLyilQ6AVWlNt5NMy4tGPumWjjoVcVOx5LyR48psauy4gtWHCM8tsTPfvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19/wpKbCCknLYrF1sjl+k8Jd4xNJ7hw/qmQEHKgPn7I=;
 b=CDYStraPqvUHsm0pVrBDONOut+ddmMpcDhZkOCS3EMKBif/ukPrhPDpWnDLdA3QQmd+TE5KD/NYSpMxK6f0Q+noYQJ6JNb1C1a5O8HmzvI9Yx9qDauMIIVvo676xM+NYqOplZS2Vs5BvOpcIWEnSE9IPEo38Zwc/XGrEJS2pmV7wHa6Obc9KdQ6/3qpIhNxlShvujJ90wfIPzekrJcp7N0VT6238l8FRKCsPr2BVuwUnu0lhzODqmWRDo7XDv4UxtAJQMCEF1IY1juPk0f5PSx8/jldjmfQ3MXIaWtO/HsXWtGmVnNqV1Utb+2Ce7N9BAXYKQUEVi3vohOJQ9masBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19/wpKbCCknLYrF1sjl+k8Jd4xNJ7hw/qmQEHKgPn7I=;
 b=V9zm655W2fDy2MCWPA9KShgjQfkpuS2Zptk36RENDgHQ/2+MbF8LM+2mhdmJmY263KhXp1Rp33ANhhFAgaY+jUSB86Jk3TwB3eYg1ChK+vHbC+gjKq1fKINt9KpRawd0i1k/nO1gLmmTLT/24ilMR5/dzwWGXq0V6ROY/uVBu04=
Received: from BN9PR03CA0347.namprd03.prod.outlook.com (2603:10b6:408:f6::22)
 by IA1PR12MB9529.namprd12.prod.outlook.com (2603:10b6:208:592::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 19:34:24 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:f6:cafe::13) by BN9PR03CA0347.outlook.office365.com
 (2603:10b6:408:f6::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.14 via Frontend Transport; Wed,
 18 Feb 2026 19:34:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 19:34:24 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Feb
 2026 13:34:23 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Feb 2026 13:34:23 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/6] drm/amdgpu/gfx9: align mqd settings with KFD
Date: Wed, 18 Feb 2026 14:34:13 -0500
Message-ID: <20260218193416.1474441-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218193416.1474441-1-alexander.deucher@amd.com>
References: <20260218193416.1474441-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|IA1PR12MB9529:EE_
X-MS-Office365-Filtering-Correlation-Id: 272ba63d-d684-4dcb-fc32-08de6f24b8f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1bllgSoGbD/uawkIGZQy+z2NEneZmM8wxJxhOOG1WhxvQE3GuU1jm/134Ydr?=
 =?us-ascii?Q?PEK8Ifx+V1CGw8HhnzoP9mkv13wpLKDNWc7ouseAESgoLHgKwRfmcD+NGjbP?=
 =?us-ascii?Q?2yLB5HCvXLVHzxp1bcs37aUuw+M4pNwlvzS9n/O/zmnogQ/ANFrJCXUl6+w5?=
 =?us-ascii?Q?3YglsScdXmGDjkaU+3jG6R6k2AvuT4WksbjvZLO1/lEpKYab5YtwpZRWL1cA?=
 =?us-ascii?Q?k2CJLsX70GWzlud5f+YK9/rdBv9wwZhXHXZFEy0vybw5fIs2SFqDFmNL0GQ7?=
 =?us-ascii?Q?LJMfly96QimOlolYM1dZnF/kWZJhf7gMxbHTJcjwBC5RnC6o2EbSZiH6rSGV?=
 =?us-ascii?Q?Zda6CDZ9200AkJtahch64GW2CizMwh1Zq2IvC/d0f/hwgC3E1MW3aVH2+01e?=
 =?us-ascii?Q?aVtSEVaWNZQrScDiER/M3irHUHwon/0sEl1DUyk22OHePyyUdPt/kLSYTa7S?=
 =?us-ascii?Q?8xr02qfLVlOrv0/t7ePdqFsW4ICjIFQ9uUfaG0bDyZneXGYT2PZzwXwTf3T5?=
 =?us-ascii?Q?xO+tXRxKOJTTCFnEDarowBnw0B7hWEqTcu8YUaTvym6e70TVTgm8XAiKexyF?=
 =?us-ascii?Q?u1Lk92qnKrSqcdLiXsKCmGDfcvKMsSfqy+7eGnsGi+8PhWx+7XEVquJcRZtN?=
 =?us-ascii?Q?NII8UHI4LURSKZ2upnKik7sV1C91AxLKNjlR8HbXZqQCVdw2KEg+kUDXhLVP?=
 =?us-ascii?Q?nG6yT+ft6uJFZzGnDW9b4yIHyJDokDPjQy8b+R0u83SrUrdVr3Dzi/RyTpbX?=
 =?us-ascii?Q?GzeRdDGItd5WXXPsYSOqmvnnkm8jRGRpZ3ataHGKSEyGPVD1mVMygM26asi4?=
 =?us-ascii?Q?7EhOjMy3utetnKR8MhFTmTEj2daIPDsYk3+wvdpi96CbY46D//yT2MTSXPXH?=
 =?us-ascii?Q?7wVhhaNXzHSjkmhafEIF2dQqE8gK4CLlqjr/3fHyMWlla+GGqTFbhpvhKZPq?=
 =?us-ascii?Q?MG8I82CK/lm3wLCO6Esa7csV16w/x6ASdgGMBPSoWr0ozgxm528ywUjyHcG9?=
 =?us-ascii?Q?xqWW6FKZdIb6vONjtLgY9VXxcCwJd4kMyv7fQYghwIoSMHGjgP+kfzqjeXx+?=
 =?us-ascii?Q?53yk9CjYlHkExiW4LoSpe9000ksFDA8CxfA/4NrIQeNJdYqnweEuCPoZqB+Y?=
 =?us-ascii?Q?U1wiuixkJzXr8SFJ0ZQtmoawN3XaFuVC74P5kAFqCpzWv1KOmcQ/mm0TcmFx?=
 =?us-ascii?Q?AgG5eZWeK5bnaV54V9tvq/w085jP/UNztSPF2MI4re9NeBhw88scsoN9I3Va?=
 =?us-ascii?Q?7AA/+8tV+hacexTGXcqhVCEPHguxYTz7VKE4/OUqRh/E4/aN/nuQx8EKQt9k?=
 =?us-ascii?Q?ebuM0NV7YY0fdR9HayUxq2jVvgMZp3aUChHnILzahilpRdp0Kx5XJIGyHkUd?=
 =?us-ascii?Q?uhaBP7WNh8T4Soulv1x7vIKdDnlsTmk3VulRXEIbgBf2yG2Ec9Nwa0jJpNQA?=
 =?us-ascii?Q?j3S4xHrXHAXOTtnOTfy/4Y58pigVA3Fe/FNvJMKQxggK+uWSX2SjpQNwd445?=
 =?us-ascii?Q?/sNzpV7HDHWjd2uuy0ip9hj1KIYx8TZ6X8c4/h2hahzMND/QiQSIsTqH19ft?=
 =?us-ascii?Q?6halPBY/ZLhSFHa3+XzgOlOl4z5J4YzL5A7FQCJZxRaQ8irT8v1ea3NY0msP?=
 =?us-ascii?Q?QnhMC3Jl/9vzcmbaxMmWl84lW58kXYvWVS6X6P67T8vRM+4h7lbO7fDu80DP?=
 =?us-ascii?Q?zF0r2g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yootn3054EiXVpREflEiVJza8FuQof8PTrtTeI5uziqwrvr3ZRj+cZC8Unbj4MJ2krWJ0TJ7YUKjRkK7diWNh+OrLAOUWX3YzblfDWW+HwRJUMj610P+rekChK4ghGnPWd+iHat6hTj6nFc2l6gWiwcTMXNo4ACK/BQCMWP2Lhq0xnBdok7ZmOYakosxpsqW4N2gU4bsUSa/C1f8AzQjgETfyzCHTm4uXACkiRDswdRk7lZ+IvPYzilHaduykGOwULs59vGK5U8jHIaUrhx37AlOVuoOCnRQh9CUHwrCS7rcHXgxoi51x0mr8dyY7lZicjV6HxTmh3CWuTwrTy9146HDTprCXzYdDwFy/WHm9t+e/hCtWler/xrcZ9yklUrlsJh4nVMFS18seeNgYEiy+noB+sLuWclZSYtpVAx1QnE/jzM7bmnu2QTWPU6x/ZCZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 19:34:24.5129 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 272ba63d-d684-4dcb-fc32-08de6f24b8f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9529
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

Make sure to set the quantum bits in the compute MQD
for better fairness across queues of the same priority.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 7e9d753f4a808..a03c638efb99c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3667,7 +3667,11 @@ static int gfx_v9_0_mqd_init(struct amdgpu_ring *ring)
 
 	/* set static priority for a queue/ring */
 	gfx_v9_0_mqd_set_priority(ring, mqd);
-	mqd->cp_hqd_quantum = RREG32_SOC15(GC, 0, mmCP_HQD_QUANTUM);
+	tmp = RREG32_SOC15(GC, 0, mmCP_HQD_QUANTUM);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_EN, 1);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_SCALE, 1);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 1);
+	mqd->cp_hqd_quantum = tmp;
 
 	/* map_queues packet doesn't need activate the queue,
 	 * so only kiq need set this field.
-- 
2.53.0

