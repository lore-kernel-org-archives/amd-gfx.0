Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EF8E7717A
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2024 17:36:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7A6710E3D2;
	Thu,  5 Dec 2024 17:36:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ez/rcPXJ";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 121C510E3CE
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2024 17:36:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tZV2LkXkOQqM7ueo15e3SKxO+sneMs5P77uBMcoQzMwtLRF2O3k3x+oJPS1mu+vPamFY3hY2mwVl0Ab6Q9ta8u/eSk4A289yqItxGdvXKAD93VFOXqUQkOQ8xUOvu9VuycC6vUuNFqUn7XJT3TH9tvkwi8ibr3hYnVBFQihmhUs7pkHsS00oAyg+2NaSVdVPDgHugL3L6WEzJIlVW8CbK+rOnuUrussADosY2A2Cvl7dK9BUzbSclEtO7fBqWFUuOThAtBpH34eX0vmNk7TpRK8QsEeOS8AhYY8jzHdg85GYp0FlXvr/90NMZtlZPca3rpHz2GZVr3C7MWPuWR8HJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDznns/hANmIAWmQKE3rI9wZBv3Vc4zro5fd+NFpR9g=;
 b=eq12Hr5rKqu8FW1zYuaLhOPk3ri2oYb6e/LtNJuqfY3vIF/4P60/npVERYGzDB/WGDdehKsyQNHAMTiXhGgrmE8PnbW+ntwIrlt13zjM8jbYZ777yPslk4wIodIcXdZ3oCRtZRlsHc98xayc9bqHilEK1soG075SVs9STfWHumN/FeCJa9ekjPditH2+e+26faEkON35yOZJ/3fH2d7RVeFBqIneKn+wCMkn/wZh+q4OjrzKAdgODo+l4JiKbmVHN/LSrfUnrNMoCP51/efS1v/NLV2cw564FUFhx1jsTLpcBOo/aFOs3Po2mvMmD872OcNF7HZ5bKzx2jkDtIZaZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDznns/hANmIAWmQKE3rI9wZBv3Vc4zro5fd+NFpR9g=;
 b=Ez/rcPXJFOq2uDOM1tThxKNLb0KGtz9Qrx3Kl8oPxJT8Gjgtd9mnaIQu0YfLGL5aqb/eNukE6SCSl4dyxfxvTNtU3ufMWBnis32uhIMMsf4D2wMSASmyoLofzvnDhy/F+IElv+uNkdF8KMV9iGMAsV3Ss7d2JZ0Jmy9kEkUJUWU=
Received: from BN9PR03CA0464.namprd03.prod.outlook.com (2603:10b6:408:139::19)
 by PH7PR12MB7139.namprd12.prod.outlook.com (2603:10b6:510:1ef::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 17:36:25 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:408:139:cafe::2a) by BN9PR03CA0464.outlook.office365.com
 (2603:10b6:408:139::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.9 via Frontend Transport; Thu, 5
 Dec 2024 17:36:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 17:36:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 11:36:24 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 02/10] drm/amdgpu: update irq sec header for jpeg 5.0.0
Date: Thu, 5 Dec 2024 12:36:02 -0500
Message-ID: <20241205173610.334358-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241205173610.334358-1-alexander.deucher@amd.com>
References: <20241205173610.334358-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|PH7PR12MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: 53063ef3-0e88-4002-a732-08dd1553579d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sQErDqGUzeuLdBNb56ibslZDyL94BaxPxT6XU4H8FnFw2xIN8LDkZWDG8gI6?=
 =?us-ascii?Q?/WZmLVDjYLec6SMDnwnT2CO9QqU4ASTTrgaUcoTXVg+kyJKwg3+0jTpS+DUq?=
 =?us-ascii?Q?L3FujZzpQeLoLzb8XJG8ln+WecDreUZLd5p5UDdzEZA4GmdE2UELKssXtz//?=
 =?us-ascii?Q?TuvW+lYT72ztz59uwHdny/wfArGrgQehUIXi8k5L6yOQVm0eq9M3rMVK/i/d?=
 =?us-ascii?Q?xGLT7LAnBjkJOI/ukwnnLmqe92ydlFvXIl+9jHVnWeGC40j/PuF2Xo0qEOy2?=
 =?us-ascii?Q?UfjenFA4RfUwz+/nhGpYvBRQUg+uJnEA65Z52bwdMPHa9G8Niq5gYPobDb9N?=
 =?us-ascii?Q?kAOk0w/mm3447FBAcMvgWGsAL4pAnBrj5z0ILwDqQD9FXakrQfeYNfR/jE/H?=
 =?us-ascii?Q?RJ65vyemsZgjdo801o4qGnbFvr6l7MsZ5kuczHlv+XHhRRDVtepaDJA58/Yu?=
 =?us-ascii?Q?quvUNaSwNV61gVfQFGQUItlg+sSpc6N0ULA96ZS64oNZDFGAWbPVCUltkotC?=
 =?us-ascii?Q?RXI46REAw5882nS5ilpyNDhqBFdjwzqTj5WEO7Z7DRw9H2vwKbjm66UBRHQu?=
 =?us-ascii?Q?126tmKHztfkV2z88lYtWtL8pk/U5FRO2WrbOjJ3QIRT/+CjtrtXwuo+HaQe7?=
 =?us-ascii?Q?EOGhJBr5zY0WumyyYJztsEddIfjVEbnFr4PGS/yYdkgLpz9pSmjkKOO2v3iI?=
 =?us-ascii?Q?S3BzAOSfpHRNrkHr7SV5v7E2+yjtLeL5L3/kvTqGbhsEzpKuCNW5Q/ELQith?=
 =?us-ascii?Q?x64gGtvmzXw9YDgcdSkD7N+XnvQJptHvjMWUimdY2zWt717crfhX4omVllSa?=
 =?us-ascii?Q?Rerj3SN9Cyug030FVocDAWF2aTU7N9XcL5PcGK9PktGVHXt0yd44HvKChx4n?=
 =?us-ascii?Q?0U3xesr64yDnzvoPTUUpmc8FJy9RYlzuqi3nK02Te1nzFCaL5R6b1joM855i?=
 =?us-ascii?Q?IN0YXLPUOvtua7V6laU/NptMBqQVoJMkpnry1G+RzwUdUoyrtUK3CxioeIlH?=
 =?us-ascii?Q?XfYxBK9a+EcL7YJTnV9SEq6tXxEo3a3kLb2VaP+Mlfnbz83zK6v0xqAFnQFi?=
 =?us-ascii?Q?NRuvqaBVp1xPrOBtMIjQnkggPrGJQHeV+KQ5IuqWfBPyN6dZqJPkCRvdegZk?=
 =?us-ascii?Q?v/iO55JVUHY1graIaLMIV226/cm/0RN8z5BKCQy3oVSWoji5ErcIQ/BznhL8?=
 =?us-ascii?Q?zMLJ+/r5voMbPEsmqp0nS3u68HbcVyp3VrjO7l/u+vVT+9y3wD3H9Rny6uAK?=
 =?us-ascii?Q?wb54rLrC+cvxEDea8jTOcRuDBKQBKDw7VNqV5bqIhnDaPAKsVW7qxRy+dQUo?=
 =?us-ascii?Q?h3Zm3eL+m0g4zBMQcqjPbBp6e3/N+bCv9PUCpgbZ810FaK4oBq+WTlrgzcod?=
 =?us-ascii?Q?9st34ycIqkfW3SqHoPuxcOsUdqAc2jNW/QoazJwJwfvt1nsrkz+OWkpyQkYX?=
 =?us-ascii?Q?wkRQzPdhD8TUhpBLPtxqW3mDoa7Z64P7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 17:36:25.2272 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53063ef3-0e88-4002-a732-08dd1553579d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7139
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

No functional change.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index 87b3f91440e2e..d5cf0f2799d44 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -31,7 +31,7 @@
 
 #include "vcn/vcn_5_0_0_offset.h"
 #include "vcn/vcn_5_0_0_sh_mask.h"
-#include "ivsrcid/vcn/irqsrcs_vcn_4_0.h"
+#include "ivsrcid/vcn/irqsrcs_vcn_5_0.h"
 #include "jpeg_v5_0_0.h"
 
 static void jpeg_v5_0_0_set_dec_ring_funcs(struct amdgpu_device *adev);
@@ -74,7 +74,7 @@ static int jpeg_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	/* JPEG TRAP */
 	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
-		VCN_4_0__SRCID__JPEG_DECODE, &adev->jpeg.inst->irq);
+		VCN_5_0__SRCID__JPEG_DECODE, &adev->jpeg.inst->irq);
 	if (r)
 		return r;
 
@@ -612,7 +612,7 @@ static int jpeg_v5_0_0_process_interrupt(struct amdgpu_device *adev,
 	DRM_DEBUG("IH: JPEG TRAP\n");
 
 	switch (entry->src_id) {
-	case VCN_4_0__SRCID__JPEG_DECODE:
+	case VCN_5_0__SRCID__JPEG_DECODE:
 		amdgpu_fence_process(adev->jpeg.inst->ring_dec);
 		break;
 	default:
-- 
2.47.0

