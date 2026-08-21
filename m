Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD8EC5DF93
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:07:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C990B10F353;
	Fri, 21 Aug 2026 16:07:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g7NcmB/6";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011012.outbound.protection.outlook.com
 [40.93.194.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7318810F350
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:07:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WsAwCjTNifMuLpAL+Kw2VVypF6FWfhVx2zsLcjOIlM8KrAP/6xC8z0Szpej0ldNm0xSmxfizgIJcpLINQsZyJRXbaNTI+6ebdJF21VEtPLkiI+3BYV4FkPWbPBD+9g2FSqsdreD1jwpC0bcZpXwKLg3CE3KmfBupO/bTx3MG16mwMtykJSptF4c/Dph8o7aJ+hfy9jI3EUI6gD/CebZOrQa+vrronG/D0kuHSfCEUqKsUhw2FIRz7JmRN98JXWHoVl16Va0yWrSfj4OjQF6JSENXExLSVJn1xUF2gX20fUiAi3LMNmwwk6p0pgINVoaFAo51PWNbOXdRNg5Tn6k4Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIsrvukceXTkYWVOURWCLff6MiheVaT8wRK9AXr32MY=;
 b=GShGCmIWRz+UKHvWXhylWath4Q50qE/WzM/cpOCszwnI07wS8lsNmFPWSHu8EOL6yBJwW+6MdfVBW1KG8nH5DllNsbns+B5WLaivlrFTDbghXtx+OMiHqeyNv45DycibxKh7UXpvDltQGd+r7VsRYZPL7C8UUmvojSlWsAdMRODTB+ZmNxYER6ViEOfisWGmtK150BVOBFvuGdBHknnPazVj4fbKz/qkmzliR0VilyhHZ3s2CQT5cENuYBTz2lvYWV2UikgOqtWEaKZ4qHl+7H6ocvm5jddTYomB4/oLDB3O/gbW+ILs7aoEUDSYXYoERRBlIymBJrsJpZThJH6ofg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIsrvukceXTkYWVOURWCLff6MiheVaT8wRK9AXr32MY=;
 b=g7NcmB/6EPwLqZTZ8jwreo8LRxlYVBbADvr39WUHjbJSqvdKr0WcLpDvChrNn4qqgJ3xsCgrl9/lHlX39MXIXub31/k/Xhkw1ow35yD45ctgXWm26mU5Mv8RBZneDVgLCNkBkClqiqvcAJscQsGa1c5A6/2ojRxSb8cXDIlNzv0=
Received: from BY3PR04CA0010.namprd04.prod.outlook.com (2603:10b6:a03:217::15)
 by IA1PR12MB9532.namprd12.prod.outlook.com (2603:10b6:208:595::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:07:29 +0000
Received: from CO1PEPF00012E64.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::38) by BY3PR04CA0010.outlook.office365.com
 (2603:10b6:a03:217::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 16:07:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E64.mail.protection.outlook.com (10.167.249.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:07:28 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:07:27 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:07:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Sierra <alex.sierra@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 08/15] drm/amdkfd: Use dedicated kernel memory for compute
 MQDs on GFX12.1
Date: Fri, 21 Aug 2026 12:07:03 -0400
Message-ID: <20260821160710.752459-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821160710.752459-1-alexander.deucher@amd.com>
References: <20260821160710.752459-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E64:EE_|IA1PR12MB9532:EE_
X-MS-Office365-Filtering-Correlation-Id: 494bfda2-c452-4bcc-06f9-08deff9e4ca8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: OJVWNiC1nhQ04TPBZh/o3OrgZ2WX9RddX3r/dxutE0UxSzLQ/46PzCMn3iJgtv0VA3d0uMkIY4ZQjkQifvXMermg1nXJo5Tr9WTQOwVgXxgqZyMOrhsyL0eSkmG7SjX1QLei0v8OxlKiKtzgdE2qDgIclOwOn90gInOaTdxibcgE31z5vkfWOgzzaLGp3ebJxAZ5+7tV5od60Nfh1iYgQZIKnFvZZ+1XhkXADyQ+zuOx1z03o7HRcn4wotdJeKRNsXLO843LBrVK0Ji9pMbXmnFFpzV8KxxKyhaz5nHmqC3gv0jPeoYBx1ehzvcfNzsDoXN5noqPOfh6OeC8gqwxUR3enCeAA3N6hmhiJqeKgXWH2mdBVuL75/K3nUCcJhIyWCoLMwBWLlf6dlCFoNvu9EhzbNYE+na6IL7dzUOPKohWtbQSob4GyGURZp7/Ohs1Z7LQmovj/IoTM0iVEXdwA2msWAd1xCQSF6wCvxOkWVgWAJNvyEtLWN22aRUl9Qav+Le5YBqZLdyUC/luRjYH2k+XWkq3dWbLMoAl/JoSihVYdijgf9xzN/hIjaZ3IY9unpCtjSErp3v5KCIak4//9GBVw/qkqRXGo3OXE4+kw137nlDhSyJK65UXvUtNTrTGgOPn7nFt9Ph6ZYJmz/DUTTRpddkWyCO5BjInd08Lk7ju7s26Nxo1I2lLbW3YU9h+7Ij9Wiz+2UAp8XTW3//D3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ptzedFycA83gb0xDZtkscHDr6tQMaZdQmtf4qPQZucaqKKQGPfbVc7HeaOpv6oRfXuVQ3tQWrqdOvcvxo1pszijDxembdCxsnZNa1xmKc8+2Og8mvr5bGbwAAWqhazG6Fqa7Mk63dY2JetqOf6/oeAc95ZgzVIwOg6Jc/Hf0bP87OPRVfLFEFpr0HZUiQPSu7W54OjyfUDe8gqYHkW1BzxXliQPCvc6AcPnEEviatIQz1akAB4Os40bTL1nSRbS1IgQCYCxKqTHJ5ovjxwGKr9LKk7GnY/pccK8++eu+ETlo93pBSWtctxmXFykIF6cd9AwWKjQV9s/3IheppKwXq+Xlx9H6RwCnK+fvLaloymh1vF5XDSbJswL/SRohYREnyfxGEa8/DoyQweGcSCpQaiCY5TnK8Ofje/N3XdmRKRPyIjNa3lo4Ejt9IQ6u/gvG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:07:28.7847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 494bfda2-c452-4bcc-06f9-08deff9e4ca8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E64.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9532
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

From: Alex Sierra <alex.sierra@amd.com>

To avoid allocation failures in high-density queue scenarios, move user
mode compute MQD allocations for GFX12.1 from GTT sub-allocator to
dedicated kernel memory via amdgpu_amdkfd_alloc_kernel_mem.
This ensures that compute queue creation is not bottlenecked by the
fixed size of the sub-allocator pool.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/amdkfd/kfd_mqd_manager_v12_1.c    | 23 +++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
index 431a940f91f3b..13a9ce02f3918 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
@@ -143,12 +143,31 @@ static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
 	u32 mqd_size = AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size);
 	struct kfd_node *node = mm->dev;
 	struct kfd_mem_obj *mqd_mem_obj;
+	int retval;
 
 	if (q->type == KFD_QUEUE_TYPE_COMPUTE)
 		mqd_size *= NUM_XCC(node->xcc_mask);
 
-	if (kfd_gtt_sa_allocate(node, mqd_size, &mqd_mem_obj))
-		return NULL;
+	if (node->kfd->cwsr_enabled && (q->type == KFD_QUEUE_TYPE_COMPUTE)) {
+		mqd_mem_obj = kzalloc(sizeof(struct kfd_mem_obj), GFP_KERNEL);
+		if (!mqd_mem_obj)
+			return NULL;
+		retval = amdgpu_amdkfd_alloc_kernel_mem(node->adev,
+			mqd_size,
+			AMDGPU_GEM_DOMAIN_GTT,
+			&(mqd_mem_obj->mem),
+			&(mqd_mem_obj->gpu_addr),
+			(void *)&(mqd_mem_obj->cpu_ptr), false);
+
+		if (retval) {
+			kfree(mqd_mem_obj);
+			return NULL;
+		}
+	} else {
+		retval = kfd_gtt_sa_allocate(node, mqd_size, &mqd_mem_obj);
+		if (retval)
+			return NULL;
+	}
 
 	return mqd_mem_obj;
 }
-- 
2.55.0

