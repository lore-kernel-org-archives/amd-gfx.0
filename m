Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFD760A2608
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 19:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=TfaCClN5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E35E10FF95;
	Wed, 18 Nov 2026 19:07:54 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010052.outbound.protection.outlook.com [52.101.56.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9289310FF93
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 19:07:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3jMzx9Gojv81d8ja34XRalAcmhSfaDaln+BvbBTB3Nt4k1j7iPvW0x2MFG43zYZ0p3Sx5i8oe8mWlTyU0etLTLOo7vYOcKZRCcKoliFGL3z8A6HB/F5pXYsYkqy/slurx1A3IKeES6xuV7IK/MLLWEEl/k1LV4RDkz/2UuMU7IkDNmMZiRc4UQKZ2gL46ZcS6EbXb1/WOhzWf/DUhQ6g5houy/N29vUaI4hCE7UQJf4ohwCWkRWn9+qVknSiPBkXxC8tRGCCCKvVOgTVFrq8qjJYnthllkJS+EJbJ7xwuN5OP+y2BZ96huyzBI/WXUNQ2aecbsvpRLdCJCQ+r9zCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtLmSHFJOH2ltWPUotecwnQpB6wu6c6Q49rko+/EEtE=;
 b=HaQ9FQEtmGXYxgZMUSQKwkQIlPnvhO2y+ZuHGgDk4kpUMMq6crOGAfoIIdKokMtAkIlNZV/b+eZ3WDwKr5spQBzgd2KDzQyWuS/Na7y6rm5eijFCXlGhc+aWD/4Jwp3Lxbw36RlSVh7rDKKZmxZz00wKDxmD5faCPyfVFR53WFDVTG3dvRVDyp0eHt4Ymefk6woJPKetajBaUQz0P0t1REMlx6GjAKmbyXkXx9w0SyNvfSalV5aPr6mkmteW19421xwQ89Kgc6zuxfgRUCBTrCzvrIZo0WOtFf37v3g79c2I7DYU6rBE9W+zQnqe7O+hFIZYcr53S2dNARXKIKWNbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtLmSHFJOH2ltWPUotecwnQpB6wu6c6Q49rko+/EEtE=;
 b=TfaCClN5E3oSS/ShkGEusTHzM9WB1yCeKxwli/vNdW8+yRwfRLQ/BR+m2tM9Hrw/6hhmOMkiSxGevx8g7k8+fE3MZ5HQTNr5nozNYLgZ5AIyC7+lNCk3rREZoBrGWcE0B3hjiZiPaktCEfDXSjW1z4RH2vKudngxIeo0gnwPRNA=
Received: from BYAPR21CA0001.namprd21.prod.outlook.com (2603:10b6:a03:114::11)
 by MN2PR12MB4287.namprd12.prod.outlook.com (2603:10b6:208:1dd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Wed, 18 Nov
 2026 19:07:43 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::2) by BYAPR21CA0001.outlook.office365.com
 (2603:10b6:a03:114::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.1 via Frontend Transport; Wed, 18
 Nov 2026 19:07:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 19:07:42 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 13:07:42 -0600
Received: from bencheng-dev (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 18 Nov 2026 13:07:41 -0600
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, "Shahyan
 Soltani" <shahyan.soltani@amd.com>, Benjamin Cheng <benjamin.cheng@amd.com>
Subject: [PATCH v2 05/10] drm/amdgpu/vm: reserve AMDGPU_VM_UPDATE_FENCES for
 handle_fault
Date: Wed, 18 Nov 2026 14:07:30 -0500
Message-ID: <20261118190735.1863676-6-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118190735.1863676-1-benjamin.cheng@amd.com>
References: <20261118190735.1863676-1-benjamin.cheng@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|MN2PR12MB4287:EE_
X-MS-Office365-Filtering-Correlation-Id: fc547be4-7bc8-4718-5d26-08df45a73909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|261102123227099003|18002099003|22082099003|11063799006|261026140227099003|261021121427099003|56012099006|10067099003|261028144727099003|261022105027099003|261009223027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: dQn7Za1oINWGlmRjj9e8Wf4z+4tmHo8AuD2qYVNY2BbtmLL47QEnKaDSeS4bk2/5Rynr53HKDi4wLrb31feJGNH5z8yFpnuLY+1LTGZcIB45uFlAXvBaFikFzAxru0oDbL0RbAhIQVwQWygJAmRur/Uwk5dzM71w3pTBMnDfU+iIOssr4Vx9SsK63t/lHLXopSpzweFQMO+nc7G6tQxe1PtxQT4I6av4ejH2mcVHV5PKoDVbZKX7+GEy4wH7qEtfZARG94w1WHXuE6RQ/4TWnV27ir37MBcWO8grpSExjkqKedafQ/L3LbMBohNeuyzo2JdLTYYWmuxltNGWFrKiXXHQwLazR05ZNtIuimXIKmXu0DZVu52W2qZJcJJTKCFbaJKvr4t3PQnwgdsU4vNvxNuiPY4cYnn1k3rl+4P/Aar18UzqDbcxfL6qT+TZg672nIDu5PcV+N7v6c0NwwmnAdDIR6gkdED3A0CvuBT1FV2mXI6ulEvyLYrS8a8XqsUmVMeUwAt6ev2aprxHz8odx8Mxd/Lp7wDlMZ3wI5XthJMm3cnfMDpjTCCkS7QrvYyBjVkX4Sdq3Lv2wwhxmcNYwl4oGseEjREUlScB2iOrSLLWCR5coUUJ9Eo54dohDRVi/DLmwQRKa2iLUApV+0R43sdbYxW5c8h978Yg3fPBTROWHgOgFfcPhKq3fixJOujZTmyS/tEguBID3OIHEWM0KA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(261102123227099003)(18002099003)(22082099003)(11063799006)(261026140227099003)(261021121427099003)(56012099006)(10067099003)(261028144727099003)(261022105027099003)(261009223027099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kQUmI/+mcpbTBTngVrw8z0F2ue5NDpCc4zS4SxL2gOnwSJ+TeLzZPsj0AphZVaw3ie1nSz9zr87Wsl+PPIAfZFQDhp7Q1PZX93SWzDM18CV7kzWQh0PiMYjE7MmUvlcDUOPUTagcbGlP4tiKSAekUdDDCexs7EpJlrN/eCEtBuKvMNTbeLQwMhlJg1GRKsf8JBZYeh0fhYTdVfYYGa+dtc9Um/4LK8ZT6VF6z1cgsTpZMrSls2VAkIgvxfojTXY7Y28RkpEEGIrAohFTpuNGUFin3Z9j25w5nqlCzGKsBBs9U7vMCeorDIPuSKbnjBEMXOSVce+K7LVonxQAowckCI5FPLtcjIo7PjqJnb4XeIhS4/HkyiYKY2EBNWfEfN5/bDXYOsPF1lkThE/jTQlGLMfgyVLjCtx7fCJbyc8PVNuOYDJjEpB4g+3kYmFBp8KY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 19:07:42.7585 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc547be4-7bc8-4718-5d26-08df45a73909
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4287
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

Reserving 1 hasn't been enough here for a while (last_unlocked was never
considered originally).

Fixes: 2b665c3735b3 ("drm/amdgpu: reserve fence slot to update page table")
Fixes: d8a3f0a0348d ("drm/amdgpu: implement TLB flush fence")
Fixes: 897ee11ec020 ("drm/amdgpu: create multiple clear/move ttm entities")
Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 6d8d639e5986..f4a836594e7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3186,7 +3186,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 		value = 0;
 	}
 
-	r = dma_resv_reserve_fences(vm->root.bo->tbo.base.resv, 1);
+	r = dma_resv_reserve_fences(vm->root.bo->tbo.base.resv, AMDGPU_VM_UPDATE_FENCES);
 	if (r) {
 		pr_debug("failed %d to reserve fence slot\n", r);
 		goto error_unlock;
-- 
2.56.1

