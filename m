Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2BA606A330
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=jSHdTsNK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CA40112471;
	Fri, 13 Nov 2026 14:57:41 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010031.outbound.protection.outlook.com [52.101.56.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F37C910E7A3
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 14:57:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N4X2v3ycPL0lj9a8XUsw46ZsclIMIOiQZPItM9aOmuvHa7m3AqCZpluM9KIYN1O4AKS0aKcoFnZlf6zJJ2D26NoXu81k043XPemPlbwIj7U9mxhnwaocBuk/HJ1uu3OdETHti5QkxqOU4B8O3bvEawijRfZg2H26T6oUqMQ/4qRRiZI2evk1WvOzHOc2ROmH5UmCicVdoa7giAPOTbsw8vdX4fXGROc73XPVoioA8cpPVdu73v+w+ajgZQejEJ7d4x5IgDEj8zxfm+owHDGQ2J8OJaeBttX4yCfQ4Oi+lfqFwVXHwN60LnUrgJzmP5WX4i80+a9u9L/9LqD8EBYOyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3ZwrJkNZ5nktCDAZ/XTAz0vHo8JKzQKSXhEMQdwvKY=;
 b=BfYCBbUGubApedJUeA0JMK5nP/lcEpX9bXR578gBcVpz0n4xbs3Y71Dpub8MOZ/y/JKIsbJeh7yurBXwqo8kEQNaJZKUkJato6wQBAiunfYgioWzGT/rReuWHDmcl/8ZlRKXYS/mnkMUvtrcsOqSDM7sPKsDlXuz8QA6sfpOfq71tEOnK0i0W66hz8qHHdWFBOEcS2OoNah1jJZ2LHNfUAXmONzQ+C4/S45Mt9DKy1BrqshqfQAcsVvPp4FhJbO1OF5guaTz8k0vvSCvvXDH1Q8vKmUejWRGnNcSDrYxdAw5kmYkfYqeeBjyvGxqultiu+N8Qil9/eb4Z8sWenHL/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3ZwrJkNZ5nktCDAZ/XTAz0vHo8JKzQKSXhEMQdwvKY=;
 b=jSHdTsNKOBAP3SonoFmX4dmvSB6GD47LAmq5z5JZM4pYFuGGCeI9SQNIyicPS5C9ORoY38H+nsQLNyaDLYyz9t175npExPNZQZKJgtvEl8Lv0ewwhlYDUwjzwu+Wu+M7mArXpMTawfvkyN4nDPqUD3xxXQjjNx7TfASBhrH38pM=
Received: from CY8PR19CA0038.namprd19.prod.outlook.com (2603:10b6:930:6::26)
 by SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 14:57:24 +0000
Received: from CY7PEPF000000F3.namprd05.prod.outlook.com
 (2603:10b6:930:6:cafe::37) by CY8PR19CA0038.outlook.office365.com
 (2603:10b6:930:6::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Fri, 13
 Nov 2026 14:57:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY7PEPF000000F3.mail.protection.outlook.com (10.167.247.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 14:57:24 +0000
Received: from MKMZHLUO01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 13 Nov
 2026 08:57:19 -0600
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Hawking.Zhang@amd.com>, <Lijo.Lazar@amd.com>, Zhigang Luo
 <Zhigang.Luo@amd.com>, Zhigang Luo <zhigang.luo@amd.com>
Subject: [PATCH 2/7] Revert "drm/amdkfd: mark A+A VF VRAM PTEs as system
 memory"
Date: Fri, 13 Nov 2026 09:56:57 -0500
Message-ID: <20261113145702.323968-2-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113145702.323968-1-Zhigang.Luo@amd.com>
References: <20261113145702.323968-1-Zhigang.Luo@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY7PEPF000000F3:EE_|SA1PR12MB5614:EE_
X-MS-Office365-Filtering-Correlation-Id: 08d754f0-beb9-497b-5283-08df41966d34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|261028144727099003|11063799006|56012099006|261026140227099003|261021123027099003|261022105027099003|261009223027099003|261021121427099003|261102123227099003|261026121527099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: HABeGYxbiSG5pUdArxhJja8OkIuQNwwvlDgCCpTv6Bcv9rLjZRWoDUpZPDuh1vkG9DtRClBmfi6F3NdBGna98gkwUWRtBeo/9GAJ6S7G4LvXmpmpILFuVjgBwc2v3Xlepf5/iRbDPJrFDnobDT+4JyX6ME75l5dmizuKK+b8Td0Go7C7JH62EVZ6ZKqjmLjY6U7sQwwRg74MnAB+wFK//etGQuJRVdc9Ck+FjDOaZuGPArUdlUr1c6AMjSq95w+qUnkAS5HaR/NkoxghtBan2tWspeqchx4/QAERwre+HJf5bdWlVXq8saLa6lKbXOZps62maBztWe/gK+xweQNJNxTCvv86tK6YBCSyYUOWYXrcgyhRRQxvTWsdjMffG484X1NcFs/VNthBeg9G209rcFSg/P6okF395sJebs4NDbMwHRpn50887rbTtm5CU9PbCND2WV/rX5qy4DfJf3VkyCHj+qebGAbPz13j0peEFBcB2lH/DNscxxIciQPzIo8zut21RM32xCmbocd1l1FRqPbrxMUnAsrFquZeOTPk68zmxNQ/MstK0g9rHuLu07Q0q5taJH3Uw751gBMfkwVzzZ5uE7QVDT7Mp+6qg5djL7GpgYBqoWkMlSaejzmzEvLcuubKWbBFOqm1FZ67Kg6i9JNxSnX37k5mcEVLx0WOOR8aNFWehF1dS+28ysoD4Mg6QNA+CiaiwkHvm5ygAg43kw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(261028144727099003)(11063799006)(56012099006)(261026140227099003)(261021123027099003)(261022105027099003)(261009223027099003)(261021121427099003)(261102123227099003)(261026121527099003)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DMCQQAmX1hcxImr9kyBVOfz9tbkxgQMLmEn4Y5kkjkiqNZjSix3mhjW+/W5DddGVb2g4QpdQAQrnAvkqX0Tusm1k2pDWpPkvhs6X2trCU7SfrkgpCzQYpUrd+GLTNR5MGtKLOrkVm2+i8b8nSHJvE1S3ESh3q0rWKJ2AL4LXCuH/qpvpoSYwe0zB6zgcnv7Pxh12TsrWgcKYyRiWKMvs0ZZmrVkyiojOA2WBLWdJPYQSxCXR1lTq+1otdJ2RPdX9gFPHNupn/nsnVJSVbt7s28kKwLjs+9wUiClt4hh0BtQDvCe2KzNUOMIm6FQAbqPck2BT98Wwj5NGgbn8fi+/qnD0lCB8EnZXMZtMq8ia9nybaflnUOuf7diiECWqArZmN9DwW8ggVXNHGMD4nh2oB52q+qKTXLjh3aRO2KOQsx1M9jlFxfwhXjrdBmSLn/j+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 14:57:24.2041 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d754f0-beb9-497b-5283-08df41966d34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY7PEPF000000F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5614
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This reverts commit daf19be40e04.

SVM VRAM ranges leave AMDGPU_PTE_SYSTEM clear and then call
amdgpu_gmc_get_vm_pte() with a NULL buffer object. The GFX 12.1
PTE helper sets the bit for an A+A VF, so the special case in
svm_range_get_pte_flags() is the wrong place.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 876476046926..a5aed7853775 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1398,13 +1398,7 @@ svm_range_get_pte_flags(struct kfd_node *node, struct amdgpu_vm *vm,
 		mapping_flags |= AMDGPU_VM_PAGE_EXECUTABLE;
 
 	pte_flags = AMDGPU_PTE_VALID;
-	/* SPM-backed VRAM is accessed through the system memory path and
-	 * requires the SYSTEM bit.
-	 */
-	if (amdgpu_virt_vram_is_spm(node->adev))
-		pte_flags |= AMDGPU_PTE_SYSTEM;
-	else
-		pte_flags |= (domain == SVM_RANGE_VRAM_DOMAIN) ? 0 : AMDGPU_PTE_SYSTEM;
+	pte_flags |= (domain == SVM_RANGE_VRAM_DOMAIN) ? 0 : AMDGPU_PTE_SYSTEM;
 	pte_flags |= snoop ? AMDGPU_PTE_SNOOPED : 0;
 	if (gc_ip_version >= IP_VERSION(12, 0, 0))
 		pte_flags |= AMDGPU_PTE_IS_PTE;
-- 
2.43.0

