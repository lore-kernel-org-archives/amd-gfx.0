Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6E0606A321
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2026 16:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LHPBthLX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38A8E10E603;
	Mon,  9 Nov 2026 16:26:56 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012002.outbound.protection.outlook.com [52.101.48.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D6B910E2B8
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 16:26:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FbO6XAcJAdQuqNzAUsnmDShE61psmUYhzh2R66rGfhBwSFfQm+OSseqGMZIQ7Ki+gZL3wSCIX7KhpUyuO882VjKkBE8WfjvVpYVGmAFqXsYSa/UGtVpZ7fovEw/dGxpjQ5yHZuW3xhAVhVNXxd4LesUjWTx7MBICZEKQmnt/qko0bGsq34nMuqbzqUUHw0h3Wygt1x8FGhdYoEeKE/4mnR3h5JlBLlGkcpcXvuPhGulxYcNLDssG1Q4temnxe0avHSf/ECeZVUHVWuWuk+cMCwGIR/QZTt7qX+mpgOzvwki37TfjEYb6Ws5I8Mjn9QqZi4Ceo1ffNazSksZa5FsXJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3ZwrJkNZ5nktCDAZ/XTAz0vHo8JKzQKSXhEMQdwvKY=;
 b=ZIQSTIYe3gTfxAmJhZs5QoKGbCwWKV8r+5rCGpbgEY79yzLqSmsKNCmw3pjNHLzAuAIlcHxs/Hp9K6qqn8+cE43F8bW+qclB7I0oet+TPHSgOKV4cqm4bQj8pVZE0QPTHQ/98d1Nr3RrFP3lxC5WeRzktICiRDuHAvn+qTCYCEn+2ogSvYu/7jIfbQ1f+DywJCW/gU1oth5SCtXRoEE9cp3WJRkLtWbEFoarUO8QEY+3bqO9XcgbXN65fbUGFBpFudbWgEFo9EVUEOlBiWQYWvncyevXlkszg/m9vAVMJPQm88U3WPXqMbwc0A9o21PEejPKQh4BPzLpzJWWClk+8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3ZwrJkNZ5nktCDAZ/XTAz0vHo8JKzQKSXhEMQdwvKY=;
 b=LHPBthLXVdUtr76shHvWTWCmooB+raxNSWGhUonKhA1R4dtqQpmwr5rJXKFK8a00Jv8F9Y2IRwaTiD8qFVFuQW3Fkrw325GeLPvGbMRbistO8XXupW5K2yC2TxkydmlUDt2ijTuXyZY6wwGllYyO555gWQLBYn78CtugVSdJQFI=
Received: from CH0PR07CA0010.namprd07.prod.outlook.com (2603:10b6:610:32::15)
 by CYXPR12MB9277.namprd12.prod.outlook.com (2603:10b6:930:d8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 16:26:37 +0000
Received: from DS2PEPF00006E25.namprd05.prod.outlook.com
 (2603:10b6:610:32:cafe::c) by CH0PR07CA0010.outlook.office365.com
 (2603:10b6:610:32::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 16:26:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00006E25.mail.protection.outlook.com (10.167.23.218) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 16:26:36 +0000
Received: from MKMZHLUO01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 10:26:33 -0600
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Hawking.Zhang@amd.com>, <Lijo.Lazar@amd.com>, Zhigang Luo
 <Zhigang.Luo@amd.com>, Zhigang Luo <zhigang.luo@amd.com>
Subject: [PATCH 2/4] Revert "drm/amdkfd: mark A+A VF VRAM PTEs as system
 memory"
Date: Mon, 9 Nov 2026 11:26:13 -0500
Message-ID: <20261109162615.167236-2-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109162615.167236-1-Zhigang.Luo@amd.com>
References: <20261109162615.167236-1-Zhigang.Luo@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00006E25:EE_|CYXPR12MB9277:EE_
X-MS-Office365-Filtering-Correlation-Id: fd26ddc7-4122-41c9-1069-08df3e7e39b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|18002099003|22082099003|10067099003|11063799006|56012099006|261028144727099003|261026121527099003|261102123227099003|261022105027099003|261021123027099003|261021121427099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: iEqssDjfPoVmQrsPy5Y/13EFkRF1SdA/1Wa8CKbFbx+NQ3e7rIq0pzNTV5zDVvBI+EkbR20Ckke/SqliuB9K/JAmR6eZ+b1twEmHLGyVDj/fliSHYitnW49dn5GXqKbFDmqLVbZGRTKfgpcaWebT3GZKOOqTKSE91N1/z3ScVsImDVL4v99SUM5GuQpBPkDVbu3oqIVPDIzwTgJxMjIYYoARQVuuCqQuYC6GGCzE3lwCS2ikfVFLKjdjbytHnc2Q7MvD0OC9oRs8kBoN6IeSGwAPZcXGh8U7OzRrF8BoMMMpwlm+nKuY+r5OIjnobEo5sQCxbu/oL2NSKSej72vjckNm4HsoDsJtn38ldvCfxq9nprn3lRvh9/2nPEx0ZMbJts2a4auM+k15PK79zHsrv9x/EhMRiiokBxGqZCrAEIxNoTQHvTWAbtxW3rKMXh8NKlI4+pGvNFYkUEfUU+yiN/V68xNfoLxAm7d4K5EvYLfi0004gD+kuxlSw/FIwmkmvMed80+rrbbtD3JqLpWnlpQqLyk8wJsCLJ7ftfpzePa9HGD0OpzbuMVTcqlR0VTQIHL8EiGcz0ZJLchoEqaAKmNDSN1xb/YpC05yi08jE1sdNtQjajXgF8Zz9eHcIc3nNMSNxo0PJBKhpa894XpKx+72J5A53IiYNPHTBY71SLkmItIR34BfYcFTq1dOMNAgVGfJV+g90g5NNHAxQSxfuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(261028144727099003)(261026121527099003)(261102123227099003)(261022105027099003)(261021123027099003)(261021121427099003)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KqVeHiwaS/9cRKJNWGBS/aMCsdqkf2d7ehMbIRBw3lE99ipKQwX4WeZwsMLz8djfDZ0QvvOG4f5JeZzCEu1Fi4z6FQ46ywgqmVBNJnoq+m4TKNAG6JgMiS4Ux2uTUbVyS9ZFEkuf14Uwqehbv1Kl5yZNOkMYl49TqTE6yYxWuUstUNDZKBfS8klGtuzTi+jqjwiSWze4P4E237M6IpMzgzVGKPp4gHWunwJ3UqgFC8MrAmxeBF20c25PB/mxdG7xyyv0T3x3Sf95wMqRRir6Ab5/vQiZkscIMLXucSZ+S4MSH6Vtjyo4xVnFMri5u+ogKn9LufhGz82UcCaK+ap4yNOTkNe4l9LOI1/1eDasn7NCYgDLXxkxjWxHknwngIy5o0KpU3xWvoGPUCLUdiWTECjbhmt2lVRNc0DJU/jOrYc8cWCYj7+4PmB81lfY7Nw2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 16:26:36.4029 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd26ddc7-4122-41c9-1069-08df3e7e39b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00006E25.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9277
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

