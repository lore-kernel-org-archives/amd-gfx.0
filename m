Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C75606A32A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 19:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BYct3rEv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE25F10E659;
	Tue, 17 Nov 2026 19:55:28 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010063.outbound.protection.outlook.com [52.101.201.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D739D10F78B
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 19:55:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=llk0mTpgkiasuidCJD56VDR5BkYt1kKkxIx9I6oOLB5MKRlqZ0Sa7ZkVQpzwchQntH0Ee4NFCT56FI5nDQasaO1oKv+7P7TtpbJFy9SQdhr9Rpx4seBCxDJ5yEHFhUYaz4J9vHLL5sMsjfaBw44MD6ow1VM5d8b25zK3aCzbHOkGwZUL/os5DNdLbhXkm0fWQGsI6Zh0zrGiJP6qKnAPCRElgFiaguF1MHDr+t33NUOipdCQSEHAEYccoW9PuEAV93/FBnA4OmMyzQcM/j0IWJVGIF2pFV/sS5/j4k2UEZ0ZIJkhtNY8YMYYzIgoIv5pM77evO28dLNkYu1xqFTDUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUOjVu9Eqc2eHN1dhep9I07K/xtCUVBD/aGgj2lrqOA=;
 b=S+nDYYXAMB5w12fuflZGEHGCzakrE92zYvvtldLXS2KrJhIWFMCs6fjec30V7CD7SFOQMA9WqzjszM/9oak5V2I7WibcI4S6URkm5kGrlAZ1iPqMgYissGOhgMFgoRDKSq5qPfRwwhO+LtUOkR405YFwIJ7A8XzmDzaLHn5hfkPaD8E3Cvo4G9hEicC9BI8HdTZW58j9buiHto/ai5sdlpkdCbQi083ZROLbuiqof2Aw7g7VMPAM7JSL5030QHLRAzhUfRBTBLdGPSgIfpif5p+P6smlE930Ovydf9jbmzZE6lKtUh6TPCAuSzFweuKbebQ5YUwdRaFdUMcqsOQHbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUOjVu9Eqc2eHN1dhep9I07K/xtCUVBD/aGgj2lrqOA=;
 b=BYct3rEvsFSqlgTZTaqF2dYYc8CHIIxyOl3k1J/apYa2/VKUfSuiB/QLlD1++i9LGVRppQS2TcYVx5xqtzVERmkCq8+01uL2288HFpJFYAGSQdj/Njz1Ud+ZhszU5LHw97fi+GOOg7jAhSIpRCR5GRzsjomjZrab2PWA0Df1HpM=
Received: from CH0P223CA0027.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::17)
 by PH7PR12MB9076.namprd12.prod.outlook.com (2603:10b6:510:2f6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 19:55:15 +0000
Received: from DSM2EPF00000011.namprd02.prod.outlook.com
 (2603:10b6:610:116:cafe::4b) by CH0P223CA0027.outlook.office365.com
 (2603:10b6:610:116::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 19:55:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DSM2EPF00000011.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 19:55:14 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 13:55:06 -0600
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: reserve fence slot within amdgpu_vm_validation()
Date: Tue, 17 Nov 2026 14:54:57 -0500
Message-ID: <20261117195457.327049-1-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSM2EPF00000011:EE_|PH7PR12MB9076:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d0cb678-dd9c-4f2d-5cd8-08df44e4b22b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|18002099003|6133799003|261009223027099003|11063799006|56012099006|261102123227099003|261021121427099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info: Y8rmgGSli7JOAGO/yLik7gXqs+66ltG+ehx9yPecN5FB3G+NNPBtllZWe3Kisw4wUwpODDUrz9wPFVdnMBgDhQ6GZzJFWPYHUTbH7yAlwrJb57LbXWhonveaUC2ywljLIErV/gtxbrmBfOz+JLdjebgpFaCaBq3Vu2rtE7EKr5KXadDEjTnjmdUncdhbEfSHOnq0rTkkN7kJrw/2Rp6XezPtwiDcgDts9iQTruNdqT3ZewHbBX6UAFGYKPqgjq2yaspsNzKuYevuWQ//dMW+hhybnNJ1YT+j59LxfKveOpBmTT6TXt87xu0TdPkgChiNX4+GAAiDFpRo+IYH4CGu6SqQ/E8Nw6GFRJkeHUBUsGSNt6tDazBIvjj7KPpBCIHFIw3gKwr43N9Dpa8/Iq9L/tbXmdweM5B3z9uym8DF1XzbmYZC45zDaeeGJjKtpRTiiECoIggZ3rQJgp+kWq9mKWmzNMjn5GXtJLZhVB7CFYjchoTimkY1G9M4usRIQUKmFDNrLXC+p0fHHOqwkx4KFw9h512ZI5mdo/A3eAbHkjacHmISoWFfUeIDjW8i8rw8WN4gxDAZHjtrw4emmKPS0SV/gXKmaDh+2kF9K3tGdcAjYVZRZozqBPL0OGctsPBTB6QENtUrGFkvzWQwDIYFjZcoLx/paST35/WXS5KbQnhiIfqcdLNuAIk1nFkxW35Ux3JTp3PG43QLhBRLP50Yig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(18002099003)(6133799003)(261009223027099003)(11063799006)(56012099006)(261102123227099003)(261021121427099003)(261022075727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dAFfQAUNTfx5Fg7XPVqk4zcW2b7Kms1LXbRPvZXHd964DOoyhSlBNUOHMYCEwTU173HcI2LoqjYPlXdgSVuTy1rJlayOJNSe6M4m54ryP5xzeYzc/Ekw11X/hdbj3FAh0vi2++DcIy1qTsM3wURpL9ViGCCmnFuhMZwQjnpqtxUHr1MCt/SLqB5OLx98McO1Kb/Lp6LhMojFC1LKOioFj1OvOQU/sNvcA/sBMKQTaWic3Ogx0ylygeSUjVFH/ovEb5xMCllFbW3IUyhuTAvZ1eBLieYvvdAOg7CQM15+X8mumduHlJMi2GQIK0z7btUFkrMxXI1Qu3HuKC/iJe4sjNuu1ZD8l6gOeIbYBfYNlOlpdVG7F36LngPmwCeVgf/INVA/MZ4YqkGz1OBm8+0g1rx8tHWlIBFhpbS1F18YUg1HyjHG4quLbhkR8rwxHswB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 19:55:14.1470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d0cb678-dd9c-4f2d-5cd8-08df44e4b22b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DSM2EPF00000011.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9076
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

Anytime amdgpu_vm_pt_clear() is called, a job is committed through
vm->update_funcs->commit(). If the GPU is currently using SDMA, this
triggers the function amdgpu_vm_sdma_commit(), which requires a fence
slot due to it utilizing dma_resv_add_fence(). Since this slot is not
provided in amdgpu_vm_validate() a kernel crash can occur.

Reserve a fence slot with dma_resv_reserve_fences() before
amdgpu_vm_pt_clear() is called.

Fixes: ddc3c87584e2 ("drm/amdgpu: clear vm pts upon a vm->generation mismatch")
Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 3bcfe0f3b35a..d5b758b5eb82 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -658,6 +658,9 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		bo_base->moved = true;
 
 		if (vm->generation != new_vm_generation) {
+			r = dma_resv_reserve_fences(bo_base->bo->tbo.base.resv, 1);
+			if (r)
+				return r;
 			r = amdgpu_vm_pt_clear(adev, vm, to_amdgpu_bo_vm(bo_base->bo), false);
 			if (r)
 				return r;
-- 
2.56.0

