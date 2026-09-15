Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65DE3C88E77
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 21:50:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C83D810E2A2;
	Tue, 15 Sep 2026 21:50:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U6L2UwG9";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011014.outbound.protection.outlook.com [52.101.52.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAB8510E2A2
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 21:50:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=msja+sczWtFQmQY0/ewNg7ttXLByGAg3Xaz+om0t36PrJJAFrKu89qmpXi+iFtKrEHmxy7UzKXRxFDGRRaQ4Ulb3yRIHYuBGb7cJMpe7vDFIuulX1VIqRE9DsEjxha5GwfzvAnjaeAW2lixpCOKPR9qnMULgAXlFVS4lZLLblb4UbjmAXw9uj1yX0bllaZEgfPsll3zk3v0PbVXRuoGklwMkaT7jWOTnXJXe6oa9CrofdO/P+Ut3TpMcCAXHDlkRXHpPLYJ2PfLaUUKW5FrNvUZnPbvcaHLmDQbEjjCuKr+mhePg6lMKh16xlY6X9O+d2OxNM7YoN0R0Nzd98ecNdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbbulTzY0BKp5OeIvCUKYQtL+hrsejMfn2o/dRE+Ea0=;
 b=goUQU124/g8XL1p2ftm1JI6mB2zP5JtwopOuJDJHX9M8kVm1E+iW5mMJrNtDzyLux0Y+tWdLXlPdQiw1reZDGIAl/DPDo79p6U/EW9luHJIFDpcGahBMfaiNBpBw5oVMMZJuCe9vb6nmxj9rTadZBJXfYO0f7zrTJChxnbvuUyG6GIVR4esW46DPQZl6ZVcF85fWG4XwamujjGOEm/GvI7XKa7z0DrX3N8ejRp+Ioo9wr1SFQyq1PpJQIfYTdcAUjitkDINPjgOWnlLu194XT0h3J6/hZPpc8hbV2molbRk3Uv60ueJv8a689ExOu6lEdqSV0yCab/5WW4RF+LsYJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbbulTzY0BKp5OeIvCUKYQtL+hrsejMfn2o/dRE+Ea0=;
 b=U6L2UwG9WFpkvqyjvLJY3v4BbPjGG6JJLrMZtjCsCqw8feFg4eYJF2ZBaWvJ9gKSAFhwd7NNf9cbzGC8or/Csu0A0wCYMx7VCB6is+ZnrYTypo31thSrmVoNEPgEL9NePM+cVEpxk91OL5wEH9mYMg1DZQQBMVNUblHmddf2RNw=
Received: from BN9PR03CA0680.namprd03.prod.outlook.com (2603:10b6:408:10e::25)
 by PH7PR12MB7892.namprd12.prod.outlook.com (2603:10b6:510:27e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Tue, 15 Sep
 2026 21:50:16 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::76) by BN9PR03CA0680.outlook.office365.com
 (2603:10b6:408:10e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Tue, 15
 Sep 2026 21:50:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 21:50:15 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 15 Sep
 2026 16:50:15 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harish.Kasiviswanathan@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCHv2] drm/amd: set CP_HQD_PQ_CONTROL.SCOPE for PM4 and KCQs on
 GFX 12.1
Date: Tue, 15 Sep 2026 17:48:55 -0400
Message-ID: <20260915214929.461862-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|PH7PR12MB7892:EE_
X-MS-Office365-Filtering-Correlation-Id: bb8915e7-91d1-41e2-a590-08df137353dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: L/PLEJVyHo82Y4PmhMADoOXAKarSux4kkSPzEnqc8Ln3cORYbMCYptDlah0mtm0klznYxzFqfHMXXiOAEa3FRH/rqGrvetqppWzxbfZ/oTIPhbm7aY9q+UO9c7y1oPHQDuSEo0zQVpfEg+2X6HAZn1WySbwXjFRv9oy1ds3ZJPbB1h2+1LS9IqS/W+zVu3bKplD4u1IM720dpBWrWw0Wz4LEt3cAxu2wPRPwAHuXB9OEN+SOIi/It468fo6XU1VNT5ZPdkXItdVfLSXwbfiRz6GWUmSZKerMsfqYJGfyAcpAZnF630qUbY/ns86mDg8N2IINswhetHjo6zXiG4qZTsgyYitwS9w7c1jvlOZNh9oGf350K6JxTw/1Zwh7927iljNdg5hFnleZWnouKERsADMLiqukxAT/2mPIhNQtk9dpeOTe6FEclBZIB06241a3ePacmmFhPtQ9OJjL9hX6YqME34csmiLT884SiowFlb0oXzw1svxsuUFXkawfxnJwzjW34FGeTzS55IDEsBlBgfm8ru6iapTcTlMseYSy7+CQUFgKDpMbNcIdLcpEfDz49oc2+S2rQQLDXjIDQyM+MvXOgdmujig18mhoGyzYMtXUY7LLXk3LVFOso0fPINxJWT/BE5yK7Aw4eYuUxZTu66vpHqrOhWmEU+KpQos5OrFnw8pi2OAc+uZW6CCghUHbccW/jmy0X8fFmIQNuhLuRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9FG/WdPNTnmE3hMVK8oA8rpsT/+J11Nu4ImqZzNmCBVgqYjBagiuPtEPLQyP/0We+BTqM6PeTnHaY/ep6JGKShZ6JEDhUVe3upxwR/a9hslrOxA/MmhYLqkUqCYApDG9KzQn+nSHPsLi/qFt5mKN3Dvh6tlS1LZ0W0+8E+uCWJwOSTTUDqWQ2fhWrgRZRxYdnADWIr3HZimfXQhkbHCIOphAnfBRpZJbl+wN3tlRDmFhHpC7K5EmFHuSzMWY9lncyKq7x5LGldTeAfa2CJ3ZaHJKbSB7EeN0dewB3Epzd4qMZkZjb94xR3Uku9Fkydlcg6+BeydCRUZbE7arpTgr5JhKeXWfuy5YD7ZfmrE2hAo1utDReVXNmmVUIDbb1o80RzwXaq0g4DRPGDaNvziqiy3JQEgUV/WJ8bBtZ1esVw5laOxYErS4UIFGD7icfjL0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 21:50:15.8596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb8915e7-91d1-41e2-a590-08df137353dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7892
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

The previous change set CP_HQD_PQ_CONTROL.SCOPE=3 (SYSTEM) only for KFD
AQL queues, but PM4 queues and the kernel-managed compute (KCQ) queues
can also use non-coherently cached ring buffers and hit the same
stale-packet problem.

Set the scope for both PM4 queues and KCQs as well.

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
v1->v2:
- Update the change to include KCQs also.

 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c             | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index d7effa43c0fa..1a09bd41f795 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -2276,6 +2276,7 @@ static int gfx_v12_1_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
 			    (order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1));
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 0);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, SCOPE, 3);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH, 0);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
index 29c20398c60b..61e9282f3fb6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
@@ -274,6 +274,7 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 	m->cp_hqd_pq_control |=
 			ffs(q->queue_size / sizeof(unsigned int)) - 1 - 1;
 	m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__UNORD_DISPATCH_MASK;
+	m->cp_hqd_pq_control |= 3 << CP_HQD_PQ_CONTROL__SCOPE__SHIFT;
 	pr_debug("cp_hqd_pq_control 0x%x\n", m->cp_hqd_pq_control);
 
 	m->cp_hqd_pq_base_lo = lower_32_bits((uint64_t)q->queue_address >> 8);
@@ -335,7 +336,6 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 		/* GC 10 removed WPP_CLAMP from PQ Control */
 		m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__NO_UPDATE_RPTR_MASK |
 				2 << CP_HQD_PQ_CONTROL__SLOT_BASED_WPTR__SHIFT |
-				3 << CP_HQD_PQ_CONTROL__SCOPE__SHIFT |
 				1 << CP_HQD_PQ_CONTROL__QUEUE_FULL_EN__SHIFT;
 		m->cp_hqd_pq_doorbell_control |=
 			1 << CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_BIF_DROP__SHIFT;
-- 
2.55.0

