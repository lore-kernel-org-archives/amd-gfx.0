Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA795606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 04:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=j6hYFxaZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3919710E2C8;
	Tue, 17 Nov 2026 04:21:17 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010052.outbound.protection.outlook.com [52.101.201.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81AE010E2C8
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 04:21:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/GadqujydqF5eFN6YuscwXfkSzGw9DAneWzzv/GOkdM9KJ8W5vmdj71UkxTtdxn17vvRV/CHqw7NYFeSAGR2pVE8RP8GxzATLxAfKu6qxK0QIpJQR0r4CS8kzfNMWaAvMMnBPR+rAcAcjYCMOET/GLfYyBhNxM2JaY2bSS4DNQeCFt1llfHr+dlTw4yizvADAImU7a5KxRp4PUJyTAcpvscMTOVeR3HycqttC/OUZivLE76wLY8zHKuJ5q5Y/cYnnCecrwkRyfWLBmLjNVMTwVkys2J0eKMbesUYGRg+bcK6CA5q+LGCoNoneAPblh8qUbeVU4CmuSCJgLB0dorSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28c4HPP8PGAyONS3ksFD917+jmGcMLTGaFtu9blbdVA=;
 b=OTtgsGKqAiucZNeTCU9GE2oZXUqPv/OnM3jLYm1GsicoxtOYKOnmgaCezM1E7kKiY6dAZrRp6txKQrbF+Y6QEorO/H+ijdWyw3IIl84bFdswctur7mJMSSqwVzaI4usyzO1LFqpjtcaq3jSB9wkBo4WGQhsFLWpuC85tEYIXA1q/uUpqRIZLAQBtokM5BB7HRBpUJCuXPgyDQCTOemzzp1oSC00R8o1e9bnaG7EunxH/8za+PWoGM+AjZvtb6rhK2M95OznL4Eb94KU7OxKScnisbdrGxzKe8fZq0e1W/uQyGrqqHgyRLs7OzjvN+GmK+SvlrPuTTC5dyiwe/+QNMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28c4HPP8PGAyONS3ksFD917+jmGcMLTGaFtu9blbdVA=;
 b=j6hYFxaZNcEksygMCKwKsat5VznU45nwidzZ5NPl+yGNSxYWmzRNv12TzLG4hEDpS6F6qSwC+N3CShz1U1z4oqPbXVmZark46MgtQNaqnVt7KgnR1Y6kN3DPr8W2CgzBheGn7MWPcDdMkb9FRZj4pS/zZj07/QPPHA27ONWuWCc=
Received: from CH0PR04CA0072.namprd04.prod.outlook.com (2603:10b6:610:74::17)
 by DS2PR12MB9688.namprd12.prod.outlook.com (2603:10b6:8:27d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 04:21:08 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::65) by CH0PR04CA0072.outlook.office365.com
 (2603:10b6:610:74::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 04:21:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 04:21:08 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 22:21:07 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 22:21:07 -0600
Received: from junhua-NucBox-EVO-X2.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57
 via Frontend Transport; Mon, 16 Nov 2026 22:21:04 -0600
From: Junhua Shen <Junhua.Shen@amd.com>
To: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Chris Freehill <Chris.Freehill@amd.com>, Kent Russell
 <Kent.Russell@amd.com>, Maneesh Gupta <Maneesh.Gupta@amd.com>, Denny Iriawan
 <Denny.Iriawan@amd.com>, David Yat Sin <David.YatSin@amd.com>, Huang Rui
 <ray.huang@amd.com>, Jenny Liu <Jenny-Jing.Liu@amd.com>, Zhu Lingshan
 <lingshan.zhu@amd.com>, Honglei Huang <honglei1.huang@amd.com>, Yiru Ma
 <yiru.ma@amd.com>, Junhua Shen <Junhua.Shen@amd.com>
Subject: [PATCH v1 1/2] drm/amdgpu: map KFD userptr read-only when the BO is
 not writable
Date: Tue, 17 Nov 2026 12:20:50 +0800
Message-ID: <20261117042051.768201-2-Junhua.Shen@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117042051.768201-1-Junhua.Shen@amd.com>
References: <20261117042051.768201-1-Junhua.Shen@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|DS2PR12MB9688:EE_
X-MS-Office365-Filtering-Correlation-Id: 2601cd1b-f677-4971-a346-08df4462340a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|18002099003|22082099003|261009223027099003|11063799006|56012099006|261028144727099003|261102123227099003|261026121527099003|261021123027099003|261022105027099003|261026140227099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: ZOcNlDccVfhpkWQdPn4yf/yNzYrxZYT7EC9mynePdvqBUWELfxJP3ohEGACCqyQzw9jhoJ62Jeae/CjDPWvAoCUv2pnP/nRZ+vXEyq1cHxxhpqE9/lcn7qvKhJEpjeZ99O0wDzXjIoC6hWaJ/H21b2hsQX5w6c1yoGwLbZcNr7hYu73gUMhw9Qemh1OY9R7av1Mi4waDPXP3xcToTNFgoqZz+URk+k8Yb77QKOMfpiZU4eJPV4bLToylBqde8VD72j2oUlOzF7VPGrQvHDSdMrSqM/ejb+j9J8N1xBVERal84e4QHpggzadXf/+EjrjHj2jGG6fK+EpF7jnpg0KMRWQ6hDaPKdOyKvscThlmj5GrFzlLU3vXSUDtj3syKdv3Ch6WmPfS3CwO4FBFCePmH8V7lJJG7s4JOxngrGuqbUex31xErdkUdHXRBfo5UktAPq0B7c4c5MnZF0Kwtcv81YjnWIyV9hg/YU492w2xpBsnQrUzXltg7UQJMYGz/JyVrGXTrPBLHVx4GLiNZ7zOvpQcaYLxjdF7ofkuy9NgXZu+W32Xto7balkw7Y+9TRau9rzoarSPQQMhKslo9Y1GRXGRYG4WAuNdkdt8DCy/EQv3cp1V+R1Y6urZkarpuhj/aRgouZ4/ofD6n3NnkBXDEmq17UaJXl5YVG4UUp4NDDLZ6qQB4nuMcJHPmbp6wdrMdyO0RmusZzAtCX+Xj5f1tg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(22082099003)(261009223027099003)(11063799006)(56012099006)(261028144727099003)(261102123227099003)(261026121527099003)(261021123027099003)(261022105027099003)(261026140227099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hP/sQ2r4SZhy+9Ln/UVYc1OxBDaYjYiYlLO/Q4z27EaK/FSY5OpdkU+W3pMhsh3ycSOnJMAGjbEt/82SrTRdPmwiMY9SgIuqQVNRT9FdggAxxGNBtYLZKt36bc7mXfR831D4Uv0dabNMboMFXw2re2cJ0rQxbiR+K+8Zquwg56EGguWY4DncpVbJCV/QKKZitnxRe+JrmekzMWdGq+c2Vts7z+BSjxQgFrVoEC8v8XrXnTgO6xbLnGkeiNoPkGb4KCcsidqaAA2/pGQYwgx3+5Ifty09RMjIrVKNi6QICHvmG1oHImAVJrtpo0x02bFa7HTpLcYAlJwjfv2cQIoqKU4I79MY99hvDdKg6iJShh7vTmv/9MFQSf4/LlsR7Zv+UvUD32kFrjuezSiTO9KJEvnL67935tB3XBjFVG9jaLHgo+gTb7o+VODQaFbIV44j
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 04:21:08.0110 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2601cd1b-f677-4971-a346-08df4462340a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9688
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

init_user_pages() registers every userptr writable (flags = 0), ignoring
the KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE flag that get_pte_flags() already
honors when mapping the BO.

Pass AMDGPU_GEM_USERPTR_READONLY for a read-only allocation, so the
userptr registration matches the permission already enforced in the page
table.

Signed-off-by: Junhua Shen <Junhua.Shen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 1b79c9f182b1..04f221192768 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1082,7 +1082,9 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
 
 	mutex_lock(&process_info->lock);
 
-	ret = amdgpu_ttm_tt_set_userptr(&bo->tbo, user_addr, 0);
+	ret = amdgpu_ttm_tt_set_userptr(&bo->tbo, user_addr,
+					(mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE) ?
+					0 : AMDGPU_GEM_USERPTR_READONLY);
 	if (ret) {
 		pr_err("%s: Failed to set userptr: %d\n", __func__, ret);
 		goto out;
-- 
2.53.0

