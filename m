Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C0AC7115D
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 03:08:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D9B610E48E;
	Tue, 17 Jun 2025 03:08:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ymaY8Mpg";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08F6910E485
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 03:08:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3KNKoK6f8AGibgsHvH27Yi01415jfeRFTALd20UUhKvMpyWn6Y5yXmrWeAEEx6tE+vyggmAR/PCQVhXI/+ho2pFMvKoMJhGCPYzY+yfzzGe+tw9ttLwUGZdIylygU3r65xR6W6cRcAmOdkVVcZz/dUeivdEYVSEFxBXzyRA0cVnaqZGhypXpA6C5YhZeH+TVCI7v0Kzr1B1V/ATj0paWYwSbwtAvlnmJd1fXjHdkilYt3EZzNaNPCzsEFekAan+FZpHylEDn2vKrIG/sDE1mRrUgNdREPxng+LsdWK2YR6nLJUYwdCb2kwoZL9WTT3zyvkbQXUet2FZe89SkcDc9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mpn1YypWQIYMy+jwSF7ska5Krlx1nZ5EsYl/RqlsEDY=;
 b=aTK7snrW3/YxbtxhWypD19NbxRaRP2QQJuP3e6AEHwxh/AWor9pak9Ijg7nnwOFyNq3MS1DcBflGeazzOw5LushQdR3ROghDWwQwleeHmCG3BRzQYkyQY1IqXPoZzM7z/W/QwWntViAFyqdIR6o0d1X9QzeMpAapUvOwG58Rx8/lzq1d+oTV/FEfE5M5K+kipn+tCPk9GXvg/Y/pWjnGhJXv2moGvOz2aqPwMAsuK/dikA8c75DfhSiKy1ryWFvOlHC5Mq462cur1XkBHn86HzQ3bV6iS3g3LwwA4xMEF9+iCggyqySTrpGBddaJCpyeYqCvfl74ziWT6U8kX+dOzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mpn1YypWQIYMy+jwSF7ska5Krlx1nZ5EsYl/RqlsEDY=;
 b=ymaY8MpgNp7Ljbnl0WToy14kjDpUZQ7tTrnMv+SxqFvre25VNuZ11jzMqJad8MPfAh7y02WLiBZo2aCEPyxDtVdAhkVt+mECiyRtK1EUFsD5Lw2Hwv5NAyLMoekNdzoQJUJBJWo5toyFvufbeTgENkOUoGN11w69lY26DhzdNcY=
Received: from MW4PR03CA0173.namprd03.prod.outlook.com (2603:10b6:303:8d::28)
 by DM6PR12MB4419.namprd12.prod.outlook.com (2603:10b6:5:2aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Tue, 17 Jun
 2025 03:08:46 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:303:8d:cafe::ca) by MW4PR03CA0173.outlook.office365.com
 (2603:10b6:303:8d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Tue,
 17 Jun 2025 03:08:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 03:08:46 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 22:08:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 19/36] drm/amdgpu/sdma6: re-emit unprocessed state on ring
 reset
Date: Mon, 16 Jun 2025 23:07:58 -0400
Message-ID: <20250617030815.5785-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617030815.5785-1-alexander.deucher@amd.com>
References: <20250617030815.5785-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|DM6PR12MB4419:EE_
X-MS-Office365-Filtering-Correlation-Id: 5269bb98-bf6b-4a94-f3c2-08ddad4c4622
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?z8O3X6Xsd5X8IdS60aX5LqFMsmd9oc+G5PWT7Zjl99FwAZ2/TpkaRA0D3ET+?=
 =?us-ascii?Q?4L8gBhHpseQnfynL4gEqvJ623250NYOTzwF6J9pz/UxuyG4xJKQxTBN9WBPO?=
 =?us-ascii?Q?bG5LfAW8w/wixHTM+C3ocQHYKQbKvFKXnvTMqyukd0O4BOu+vIEdJSQRoPjm?=
 =?us-ascii?Q?vWO4tk8VPbQh8/omPDwVVNtMZ0qYQaIB7wezCE1+myPWfDQOdfZsEJG19IHw?=
 =?us-ascii?Q?Qba3OIiA8UkgcZcS1kalDW4pX1/vfPR+bjxRy969Q3sL3oDE5k86wPMTXiEa?=
 =?us-ascii?Q?LPNxgc1vpQ8kTFqTJPI8LB1TPKV5QgbYEurOhtswxRVbfrvLi6yIXq5XbVmZ?=
 =?us-ascii?Q?KV5kMvz5FUmHYtR1inhHUCFUQdJc0hAdQrnCHvNSgMYOgtR5WaIfPeGYnXja?=
 =?us-ascii?Q?PoOoFmOzXlEm26w8aMois7pkQqGd3GCEClIBIvJOWOFYqhYkRvZK0SjFH6kY?=
 =?us-ascii?Q?9rh6B5Id0sbjvs9qQd3L2AJqzi5KzU1t25YMY1SHQVOykYU6A+s7KZ9YC4b0?=
 =?us-ascii?Q?4NB2UX9SFZlUllL5LqZmlSY4ToIZgUIGaixNeZrvUBAvDz/ksaGROcH23pqT?=
 =?us-ascii?Q?zhGcxfOfwxB3RGXLCdllJOYTY3nOFfvnygQdUm9lzL5Z6lxsSXnxxxvpEyep?=
 =?us-ascii?Q?OeaudmL9/qPwdQZfsC+CTCXH8HeGXEFPq2BUxjkHCfSHUfbSsVx8JJV1xSzn?=
 =?us-ascii?Q?fnkRMSYb8VY3w7Byq2EmggvV4RG7MqhGYX8R2vrelzANqdQ17ZaZtmFANEZb?=
 =?us-ascii?Q?m0PTE+HOCycUIEkfBVAaa/dEroRL7icl+Ef6sVTHPTH98BIfSJmtJ/wbW3WA?=
 =?us-ascii?Q?gJ+Z9FofXTKZZ2H9/ClgKgH2sIHxAVNzxZYfNSHd/W7+86unWlOWd2y1xskh?=
 =?us-ascii?Q?nY7SdP2295BHpZ0BCOSMUGbKNPGOkmRr8VdAXLyen2TZ/zAYpvSeFt4QXeCA?=
 =?us-ascii?Q?9Ggv2J/b9zWLK5/p07KouvroebcefIJwEN8vomXD/iyIwypN6Rn2C2dJNEVZ?=
 =?us-ascii?Q?lmpxzYWMObNktZHQYGxLGhSEPbibCi3lFWZPasDWW+sRI0i9vNUOE5u52HPE?=
 =?us-ascii?Q?+uyPMXJLH9tP9z7Q4BnrB05Mu+g1b9dbuk58A0uWiPzrhRM3yKOj9G6mfsxo?=
 =?us-ascii?Q?5Wn/PxKtnBQYcmQLjGs+IknIMkbiT3/c+4mRVr4Z4ZLeSmAnuISQSyhC7HzI?=
 =?us-ascii?Q?MmXYmf/HCf44FFUJ/pJoeBLEvKq+EKA6R5NASXLBjZuLaxRBwuLKc/Kcp3Is?=
 =?us-ascii?Q?a2bEDMb1LNaWLXO3gqq7IbKlgIy/88lAjUNGdjVgN3ZI7HT5zO6zS+qn23kk?=
 =?us-ascii?Q?zqV0xl+gc4ehjPzsknkmeqN6P1bBo+C2pxaiZOLH3LDve3rtIcJkj5LswiCm?=
 =?us-ascii?Q?WxVRi5M+bKi/T5Kylob308vfuItrI729Ur5yefDDmtwm+iAh17F9nTjDAFJ8?=
 =?us-ascii?Q?R9ZD0IXiRtiG1YKSkq6yXAxm6zb+od7MPIm+l6L59x3mFA+eR5sVfu6twXIQ?=
 =?us-ascii?Q?n1qNO2Ep8UFt+TBtN3M1DgMnuodBAy5ocO0m?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 03:08:46.0957 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5269bb98-bf6b-4a94-f3c2-08ddad4c4622
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4419
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 6ba8cb5995779..6fee53afd6809 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1537,11 +1537,23 @@ static int sdma_v6_0_ring_preempt_ib(struct amdgpu_ring *ring)
 	return r;
 }
 
+static bool sdma_v6_0_is_queue_selected(struct amdgpu_device *adev,
+					u32 instance_id)
+{
+	/* we always use queue0 for KGD */
+	u32 context_status = RREG32(sdma_v6_0_get_reg_offset(adev, instance_id,
+							     regSDMA0_QUEUE0_CONTEXT_STATUS));
+
+	/* Check if the SELECTED bit is set */
+	return (context_status & SDMA0_QUEUE0_CONTEXT_STATUS__SELECTED_MASK) != 0;
+}
+
 static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
 				 unsigned int vmid,
 				 struct amdgpu_fence *guilty_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
+	bool is_guilty;
 	int i, r;
 
 	if (amdgpu_sriov_vf(adev))
@@ -1557,7 +1569,8 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
 		return -EINVAL;
 	}
 
-	drm_sched_wqueue_stop(&ring->sched);
+	is_guilty = sdma_v6_0_is_queue_selected(adev, i);
+	amdgpu_ring_reset_helper_begin(ring, is_guilty ? guilty_fence : NULL);
 
 	r = amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true);
 	if (r)
@@ -1566,9 +1579,8 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
 	r = sdma_v6_0_gfx_resume_instance(adev, i, true);
 	if (r)
 		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+
+	return amdgpu_ring_reset_helper_end(ring, is_guilty ? guilty_fence : NULL);
 }
 
 static int sdma_v6_0_set_trap_irq_state(struct amdgpu_device *adev,
-- 
2.49.0

