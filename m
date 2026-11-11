Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9111D606A89E
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 19:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Wa8ByJaf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED02A10E3FB;
	Wed, 11 Nov 2026 19:23:47 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011061.outbound.protection.outlook.com [52.101.52.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8B7010E440
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 19:23:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GOpPYF1lJJs4v22oQ1Evga5DUNEj6Sv1yxLtQmZiWqjUZPN7WthI0PmnVsEGeVdjVYce8/JEqfd+OyNoTL8uZBmrTfobEM+8E7WudFX5uGku8Z8zY59FHyevJvJ+3HRarvtP5MOpi4gJwhiEz9QBQ/8CgB7IJxEL/HGbpMqCTTYtMOqfAbowaPWNYG/0IETx8RgwoqZimDjduM5MvShGR3/Q6kfpcilJcOSABkjSgkL9iML1gyeB5KW0O0ZxzHYkcAuuPBcx6eEFr8Wd+VnccAoAszeE1gBQuve3DPP+Ylc4AkntpiKk8JUIbfQNdLGakRrbwUIqXHMNHK0Us3BVTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3ZwrJkNZ5nktCDAZ/XTAz0vHo8JKzQKSXhEMQdwvKY=;
 b=EmqCNJcb+6eoK/EjQTL5yMGXtRZpcgDoouhkwMsR3FKfCwRHuw0lkXlqBdYXOejhM32B7fNTrsvtOy7RbfnxBMWohVsN8PVTi4E3LlqmJKZMty25o75DZpEwsbeoM2nVskpejZuT7VdmLQSYD6r8TbOjtqmHMr9H8QZPmt4Agqqvu6RnLKmyQAi8GbWhLdrKzFCpSQQFNgRltW9ZGyumWi/ryOtnMWNHYupSPTe0x6fxVpWbspDpZqalvcg5LqW2EkTmZ/Uk3TKXIaCsTTj3Gvzw3UQ5cg9+5EmGXCcyE1/Rl7ucrX0cuG2wOe7Rqz7tQreY+eXShUYw9X8Wjd7KsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3ZwrJkNZ5nktCDAZ/XTAz0vHo8JKzQKSXhEMQdwvKY=;
 b=Wa8ByJaf7xEqwKRQWD/Xe1gCdD7I7Nwd499fNRpTcwX5ql9WFmEs8kQna8Orrz2nXbJbddEGCt2u7MxkfFnvqzSqVgcTHxKrguI55G2bRoZKIUXGIoFCBmL/T/lt68/aI68y3xQDX8ztW7QX6FRA4wiYGak28GpGRfyto5sI0Wo=
Received: from YT4PR01CA0112.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:d7::11)
 by SJ2PR12MB7894.namprd12.prod.outlook.com (2603:10b6:a03:4c6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 19:23:36 +0000
Received: from BN3PEPF00022BC0.namprd04.prod.outlook.com
 (2603:10b6:b01:d7:cafe::53) by YT4PR01CA0112.outlook.office365.com
 (2603:10b6:b01:d7::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 19:23:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BC0.mail.protection.outlook.com (10.167.248.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 19:23:35 +0000
Received: from MKMZHLUO01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 13:23:34 -0600
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Hawking.Zhang@amd.com>, <Lijo.Lazar@amd.com>, Zhigang Luo
 <Zhigang.Luo@amd.com>, Zhigang Luo <zhigang.luo@amd.com>
Subject: [PATCH 2/4] Revert "drm/amdkfd: mark A+A VF VRAM PTEs as system
 memory"
Date: Wed, 11 Nov 2026 14:23:16 -0500
Message-ID: <20261111192319.297456-2-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111192319.297456-1-Zhigang.Luo@amd.com>
References: <20261111192319.297456-1-Zhigang.Luo@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC0:EE_|SJ2PR12MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: 99220a13-d1f5-4fde-1dc3-08df40294821
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|10067099003|11063799006|261021123027099003|56012099006|261021121427099003|261022105027099003|261026121527099003|261026140227099003|261102123227099003|261028144727099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ojrTkFCM5l4B6SAap5pQpOBIFai0fJyJxaMMcMT0dvonIbdrWnQC9TKLZFhXArjgt44GHuvqQwz8GFHOkHycznaTc7fHL6LHywwJQIZ3H2AHTtcI07F89DQ7NTQXUz0rybr4n3FfmrpiQdlMLGjSlLds7zPuiNNsTSwcPcoAk2Qng1Is4eRvzAZh5sDO521BQvXEexmCVzr4XgMwCJQ3PH+8AWvhOCQKIrZmh3RXl9oXR0faTSSR4v+o48YZuZcc573BXayxeCcuyPvsR8HcysuWYm4WmVPCWFZrSHPJfCDFD8R722Y8lwACRRodxAcj4iXR7D0lHIbPUrpzhAoZ8fUjnTSb0tLH5N2P5yI29ixCsK/RLFm6lvh9cRJy3wyeKbd+ZNvyqXuJPEY0D6mZ0bUGGmucsitQ7L+j3TpPcM1xxxl0nk5eZ6CZnFp2J6DxiF3TFW9g5uT75dg11uxtwWcYp2yJTzeizx1/tBuRFOFS7yALytRHqnRmylShb23L8ndPjKFsSBFior2YqIib4CU1yKI/+psBZxxFVobKNOYCd4yGHzVp6VEtyizwguCFhhNOBoEb5DZ5bG39inGxwt5fVBCnClOuMbtF3M5tDktVO0LuBgz3jo3KKg0tjbSYDDInJW4i1RYPU24qH/YltST+mI0d4dHe/zaqkNuq58wBGCJj7war119G6Xf86JJhPoA4UAfY2k6wx5zV/KYb+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(10067099003)(11063799006)(261021123027099003)(56012099006)(261021121427099003)(261022105027099003)(261026121527099003)(261026140227099003)(261102123227099003)(261028144727099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: B5HJGOiVfByHQW9iZzDT6TBI01G2QcARO33RX407sW237ddyekzdTxJbryfN0aQRzZMpGurZfiYdQ8JzBdQcyth8BPAdLsFJ6E3ALNsEE7QnIcfLTBvNDq261BKEYJnu6oeN2hi/f8hf8BwZHCzDkrsKQXmfr2zaYGHY4c8GFIjjl3xZoNjHLx4lL0XkNP9Ffl3rmixFENdNLgkSf/5w23m1oftro8LQY44YmPcgKyWyH42Vu6/GfuJFK7RR/m8913MgUkRwCt2/GdXDYVCIH0DB1Moour5Tzwy9+OXHqMd+QDlLlMfMQN2+DPvcaEydHkU2jKCti7MWZcQppL3ML7cuBPkZOPETBMKpK5kQ09AYY3EctQZWQrMfbvX7vZNoCb1o1g01T+x5tFrRQV9wit3G9T5dcfAVu4L/iy/xdqKSWOYM/6mvYubiUZhiN0SK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 19:23:35.7427 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99220a13-d1f5-4fde-1dc3-08df40294821
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7894
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

