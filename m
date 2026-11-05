Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E5A606A31B
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 21:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tHEhYG7t
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77D0910E135;
	Thu,  5 Nov 2026 21:00:45 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010070.outbound.protection.outlook.com [52.101.46.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A528F10E135
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 21:00:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PMU05iYZ2+gjiuixdX4NuT60IU0mRoxkNsIq7rQ/22VFfS209gRRO/tqoYCBxf0AYiEzkSq7EbSeIwVvA/p3gqrt7w/HUPzFI39oQGaCr8eeZlkSl+Fj9mik9srar6Z4g4QMh6/xUlkAmpxlNbcmrj3bw52GZM2GtITe/MtCbvHUw0c+qg4E613J0rBUqnE9Mw5j1iQWWiaBJ1c0eXTS47GdzAJ8J1xxr8lwO7eX/9R3Mir8uSPThO8WwLqb0mRfCnDGN+ok1nbEXYURQHAwF74DN2QKgevPfZzygbR3UuVdp8GPboAHPSAHcR+4o5A9vYH3UIwDttYU/kC+QzPUSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nUxVvu7i4DDPUEkJrHj26GcXB1uVq6dDkw4aBRGySY=;
 b=HoMWBq/bw8tdALb9x9AvipqjuVbKYFD3dUtLQZQfzL/REFEczYEjYgdUXOnMxl8//Rv/iZYKL2Z+MLWzOZ+LulJenJbhZXIe/s4QLqa1v4cBFwlabt+1PF6b3q+zgZUsZ8V5Ux/509Y0r4XQm8EQjyy6R0fNf53TMLgWb8d1P4droFhj0xgoQRIiCoZ/tnzcLtrUkx++mR50vSgDBovTGzV1oyUUpqkvrX4SZ5bhu2x1FaiCxI46KtujnIU+4AZUWN2IcmsNuH3dyBPwAlRQSOu9+rkQa91FSM75bO87R4bUQwsAbHWiE74MxyM/JKEXgsRm9zYc42uUtMsfodp20Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nUxVvu7i4DDPUEkJrHj26GcXB1uVq6dDkw4aBRGySY=;
 b=tHEhYG7txd3i5HLYBPAVBzkyidE7cv3fmkNOyq4OD+gQ6iW0cm64wCHGycNe7/wQ6rQYH8v7SgIMpzEaIanwgS9ZcSdOoOeEYaj94zQTIXOaqw04j/8qKWMYrqGP6MofNFIQnXctHtT3gXjBSJnFFT55uqArGJYXpIWE8XUZe4Y=
Received: from BN9PR03CA0415.namprd03.prod.outlook.com (2603:10b6:408:111::30)
 by MN0PR12MB5980.namprd12.prod.outlook.com (2603:10b6:208:37f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 21:00:36 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:408:111:cafe::2d) by BN9PR03CA0415.outlook.office365.com
 (2603:10b6:408:111::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 21:00:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Thu, 5 Nov 2026 21:00:36 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 15:00:34 -0600
Received: from bencheng-dev (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 5 Nov 2026 15:00:34 -0600
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Shahyan Soltani <shahyan.soltani@amd.com>, Benjamin Cheng
 <benjamin.cheng@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/vm: free pte update job on error
Date: Thu, 5 Nov 2026 16:00:19 -0500
Message-ID: <20261105210020.3852328-2-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105210020.3852328-1-benjamin.cheng@amd.com>
References: <20261105210020.3852328-1-benjamin.cheng@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|MN0PR12MB5980:EE_
X-MS-Office365-Filtering-Correlation-Id: f0586974-d6e3-4eec-1ba1-08df3b7fd6da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|22082099003|18002099003|10067099003|11063799006|261009223027099003|261026121527099003|261102123227099003|261026140227099003|261028144727099003|261022105027099003|56012099006|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: QalQzW3e/qPxejijWgl78FUcZa5vQYUJdy0ObkgxiA8SYs2aFnfAsrbnkhSrMa2L5IiVib5CYfbK6cCV/x8S/2bOPAV0OWJIquuZQmKB8Ayft7F0x4Fp1BPImqF5sGKkaL0zSrXtIbnHkitCaQTCO/EHwfkMAfx+zE6otMyo7YEeQv/gzxgkbV63Qf2NrjFcVT92JLNEpDtvjZkMSfZS4Ekt3WalqtTX3E3eV/COgMn3IoA3SvdX3ZYYXodQjtsWFrBvgCvHcHFyESN9/anAnbsb4tAWqTQVvg9gCkm+Fhnnm6stLb87LHbqKXjE/8aEuyg1zLLhmLmKeEuJsbdbzK+nbtgqe8GYeQOClDym7oiZSGpmM/qNdI5giK9xm6yJIpbJwW1NhP60/3dVaQszjSbVfcLwpsABUGGULloloZghKQ2JYiOj4I5/iqYmMOn4sA3Jo7jV8+Se0yLqDDvxuhXSD8Z9wkrjWF+tF9/N20iUzHVNNg7E14x/Sr1uwcX8eYB4HaZqOxqgR66/L+4FCc3VxCUpGk5AFFMWbF+swy4ZdXnibnlUtg2M7o5JkkQh5HtIfukJ88DbW4EO2CiP8NhaN1MhJSzDDUHnmuwztFqGtz4ng8QRWe1t3/Cgy5nIXIC8pKMjhSust/eKJOR8gVraVuPOMcCDdoTj8R1stjo3DPjjU7fGvgDqNABC/CAF2vJDOzqQyeg2RPc/GUHOWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(22082099003)(18002099003)(10067099003)(11063799006)(261009223027099003)(261026121527099003)(261102123227099003)(261026140227099003)(261028144727099003)(261022105027099003)(56012099006)(261021121427099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cKFoZZO/EiT9Z/bpAYxP2O3Y8srULtiKgSR/aB1mttCiy5r26+djCzBQWFD82XQwqyZXElVjDnSHuHMTYwlCHdMzUEd0aRUj6MsbDw8KwI3bPcknKTTNei6kaoW2GxPW4FkulamAxTFIfCOKXIPxTh/ULfZirlJe1UVBxkaknFJdWxZ2qvOyKNjDJ29tACl6+7pjEl1j6pPQ7/PMrWDkK9qvsFNPmXZ91Nl2Aihs6kfh1S38UD32kL9Qy5aYI5WCBKBCKM3xlC7tiiuwinuV7DB9fp2uVGb7JbyC5kl2JlhveSxSN8/Y9+n7NCywRs5rlm0YHWyoGqabgEy7IPKm68Z3RJ/A0ms867kjmACF5UrWBRTikfZi8GWwIYsT8mqxV92n6bEejU0A7ZVxbeNQAjkiJImnVfLA/O7TikbXAHwYj2Wpu4NVDE/FpygMkC3L
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 21:00:36.0947 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0586974-d6e3-4eec-1ba1-08df3b7fd6da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5980
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

In the happy path, the job gets freed when the job is submitted.
However, if amdgpu_vm_ptes_update failed, we don't submit the job, so we
would leak the job.

Fixes: 009f401fb98b ("drm/amdgpu: move amdgpu_vm_bo_update() call into correct location")
Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 2ba33212d507..f6cb2b5854dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1274,8 +1274,11 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 		tmp = start + num_entries;
 		r = amdgpu_vm_ptes_update(&params, start, tmp, addr, flags);
-		if (r)
+		if (r) {
+			if (params.job)
+				amdgpu_job_free(params.job);
 			goto error_free;
+		}
 
 		amdgpu_res_next(&cursor, num_entries * AMDGPU_GPU_PAGE_SIZE);
 		start = tmp;
-- 
2.56.0

