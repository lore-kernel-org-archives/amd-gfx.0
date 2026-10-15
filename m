Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9E7CCA464
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 19:13:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E652111244E;
	Thu, 15 Oct 2026 19:13:10 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013056.outbound.protection.outlook.com
 [40.93.201.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 499D811244E
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 19:13:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yFRcCinjf8lqXpaM7QC80Xo2r4w3tDJo3EeU9vpMHud1MlvHlfIQzBrt06CXPpndI++dWbYke5x7r2c8KDqWooU0wi8aEWJTI2vhKwOKx42b9qiP2GQUinccKKfCqzSsFvBv/MsVwN9yqowopdQT/2sI9Upi98z5a5BphVViMn/7Raxur7JGweKCNMxnLxfs3yW8qip0kg/RYIJqciBwfOPUc0l5AUW4PCERaAwKsutFSfJrk2v5HWEhJaB+ghpZQiNAXILtwBqU6YG2N0aMwrDpYfG0LbefRzrh+xz089Mx+xNCvIGKyncBJ2aAtacAAY+5sUTlcl5V5gAvAD2wSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0mrPAXKNO1MXwXZ+Mra1NTn61NMdwXIaSVZ45cccwXM=;
 b=itZKP7uTXJ6KoVA6XuKfzqCNtQjph1Ep2r8RfqpNWuf89JbbBx90/VSKlhD6QBwPD2kviHR5Nxh0DUhGXn2pafJc9Z/EpU4oIa9wGLKKTG2/5MFZKFQOzArIVXMBpPrTU3Rlrc1uEi8J+m2ePg+Caq5/irbAuZXZXWVtftRCVSiCctOgJwXemJY724lXGG1uuuoXLxqDMv7AZjuJuIIekYEdboS2AkMf5H6faUZxp/Rgu2GDTBm7xKTSix6i+dy7tu5FgxusLNpw5LUT7oXWET5dqoThayRKhO/O9PeL5f75pqnZsh3uA37zyTNNpsVWrQ/gmTHrplb6ZRVjpo8dFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mrPAXKNO1MXwXZ+Mra1NTn61NMdwXIaSVZ45cccwXM=;
 b=OjYL9puA4DoN7wrI9i6XbIpdkk2My5/PYzbiNDxYUnjZ2ZKlTSTELCSvzXBmoteNYN22l4jNPz+GiAmSbvc+qkGvW4AoogTJ6S9bnGLu3Uz7AN223MXYu90927JfnCGppAwO2eyewnZizQTbPOYOZGIAbdYHuoV9UbZ7HlaQy5s=
Received: from DS7PR03CA0177.namprd03.prod.outlook.com (2603:10b6:5:3b2::32)
 by MN6PR12MB8568.namprd12.prod.outlook.com (2603:10b6:208:471::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 19:12:56 +0000
Received: from CH3PEPF0002457A.namprd04.prod.outlook.com
 (2603:10b6:5:3b2:cafe::a) by DS7PR03CA0177.outlook.office365.com
 (2603:10b6:5:3b2::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 15
 Oct 2026 19:12:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0002457A.mail.protection.outlook.com (10.167.252.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 19:12:55 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 14:12:48 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, David Francis <David.Francis@amd.com>
Subject: [PATCH] drm/amdkfd: Check before ctl stack copy in CRIU restore
Date: Thu, 15 Oct 2026 15:12:40 -0400
Message-ID: <20261015191240.23092-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0002457A:EE_|MN6PR12MB8568:EE_
X-MS-Office365-Filtering-Correlation-Id: ba4f9fa7-a575-4634-76c3-08df2af05162
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|261009223027099003|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: 70mdTw+1M8kpmNRWgpTqz5/zfnBYckYTSzuQn+2tPBJlUT+A8NWyUOmMwLkeLqOCKVfUG2gvkudPm0yFWU9mXsxoMBgrsACfgbqHGWzZ+Yn3kFWe04KJ1RfZrEu47ocp0Ti8617M8+fBw3bqQrVuSYprEl6nyFu0sInbobPskUgsI3T+biu2K4hFJRO+zFphVXomVgw8mUO9ijiYHJ80oOjV4fZo8etr4ONi+/iSSNLURccOyYjPLgwHJEt26kqcFAd/JBKg55gIqyNxxLgTRXJg25RyASZL3ksBPezyxewtdWa5QEQd10a8f2qalhWEx4OnRxc2MEMuLEDcg2dqocmO3aVtvmUANa9hbjN3fPt4f2ZCpJ2gezxhj8LKFMxdjEuUyYd8UiXfAogdc1nKY+iDEveTDkPm089mJXkbhVPVbRuq5Hthr737EextqjJ39THDS5AVx5O/VnwmsDl3Pj5vJB5rpS9qfoNMorSlzmlhtU5l9tvd/Ml/7GjM6v4XLOF0mJ6jJxRsfK9hG8V7hS8BS8P3dqhxXGp6g1FR3yKNAmFQcihkUh5S45AHxcODo/ZfMEJa7nIfmZ38MoXQyKpmj2ri3eaV/wolKbkC1+axjQBQATloO+4Qr/9uerl1lxeClIPwJSeAPj7kkE0ItDgvp0aB1FVebx7ohmbXPFwu0Ji6GPwodJk7C/tZg2BHdohSC2DKdexjSynb6c2Iwg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(261009223027099003)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TxoYZKCiQEdj+7r2SDGeFDT/kldbCJZ/AxWTHYwuKDGtzVrQ7IpTWzLkrWmQRyOmp1RhUNPLyzIIHyxeY4/gVcLNerBiwjKnCq1dpfpWiqzrjcH3iNQ/fR51E26wbksuKZFBVVdFBA78gAQ4A6L3Y3KPz0b2xs+sIaT9yZZn4I1tNuan5BADkA4LDq+CHkrRj5T+WygJmCsSlt5je+8QRK9wrMv77dQ40XVs1wl8CFNq1S4vfRxtgOQ5RYCmDtqMnGGx94hfWdsPkVQkYTHaRUXFzIBoLuB8dAXxNn+nyDyHsKKsdlY0NOJGHSjI008UgATrYiCcjXwBl4vkfRh2CEvSV1wB+c7Mzrp+whAHSjlXFi3Tbq6w+BdueQ/7fYuz342r7pU5DcE1FRGabFREc3iHTb6GxdjiLkihL3q5t1IhXR8jZ9jyIqbtcXSyqMMX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 19:12:55.5271 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba4f9fa7-a575-4634-76c3-08df2af05162
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0002457A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8568
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

During CRIU restore, if cwsr is enabled, there is expected
to be a control stack that needs to be restored for
compute queues. In other cases, there shoudl be no control
stack, but we were copying one over anyways.

In that case, skip, and warn once.

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 75e5a9f67d50..0350c7c2b307 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -463,9 +463,13 @@ static void restore_mqd(struct mqd_manager *mm, void **mqd,
 	if (gart_addr)
 		*gart_addr = addr;
 
-	/* Control stack is located one page after MQD. */
-	ctl_stack = (void *)((uintptr_t)*mqd + AMDGPU_GPU_PAGE_SIZE);
-	memcpy(ctl_stack, ctl_stack_src, ctl_stack_size);
+	if (mm->dev->kfd->cwsr_enabled && (qp->type == KFD_QUEUE_TYPE_COMPUTE)) {
+		/* Control stack is located one page after MQD. */
+		ctl_stack = (void *)((uintptr_t)*mqd + AMDGPU_GPU_PAGE_SIZE);
+		memcpy(ctl_stack, ctl_stack_src, ctl_stack_size);
+	} else if (ctl_stack_size > 0) {
+		drm_warn_once(adev_to_drm(mm->dev->adev), "Control stack for non-compute queue in CRIU restore\n");
+	}
 
 	m->cp_hqd_pq_doorbell_control =
 		qp->doorbell_off <<
-- 
2.34.1

