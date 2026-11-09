Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BE6606A31C
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2026 09:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=jDa3WVFC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2178C10E867;
	Mon,  9 Nov 2026 09:05:33 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011027.outbound.protection.outlook.com [52.101.52.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BA1610E868
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 09:05:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TreBZgw4lFi+j7zQ/ndQlxxGHfdRRYdEpkUuxN4HZLP4xFDfW1qjiRXn9UdBHsYItl/74HQwuZkZHRV2xWuDpbm4YpHtoT45b/t2HYq5QsqlAgdfg1xItsCCg8VuGaF4r6RvmzUCBOczqM0dfxUCMq0giA2/ZQPExmpgVbNSPS5Gz2EkTQh1DYzK/fHecIWXE6zJ6HujyGAEBgj/8GGljGIwa34dZbsp3ALbbCzHigYHNCvTeNeXDusMBIb/rqTC8EuAHjt+HOCb1pPZpzGzQmtm/XXhH2rlTwPvdRXqYtyhjxYUDqYCjE3QAgaMkoqbf11D8f6w+YuIz3DlJGrmdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSKtlmZtWn2gtInrYF5PMQkEjMg27hA6ysxjt/k94xQ=;
 b=VF3dWNDKKBcWqvFbyhw/EAm+fCTh9BzifEUZ+r+FFDMzpM8L3JzaiUH3Hu1hV1HRH8Db5lA7PEbNjrUYevBJb1ACARSlYy8FLYam2hzT5sj/vTsxwxK6PNK+LUx5MGzeB2LjTr86yM7fi4gKGNdmfigTz4zP7+rg+UdTUWMD15x+XoP7f49CEfcm49o9uHs/3ZWmlC0NfgT6RIZrtWBBsrPxe2ZxeFHu45FxyGjkySu5KJnOlMdaktxUdzeXcDOxarDLinZvPH3209Le+uv9zIJMuLvImG7Oitu/fspIczfERAuPDnGaiH5oDMmqnqAiQmQVo7B4wx0mYly0IctLvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSKtlmZtWn2gtInrYF5PMQkEjMg27hA6ysxjt/k94xQ=;
 b=jDa3WVFCGwkLt4bKC/xKj7dTgFZ276xm6yOpBOMWF3VWm3BtUzIDS59waEQR2ODvuloQI8U4K7RHoL9L26p1FJ8IrDBtC/sziMdyY2fA2Vqs+YI7Qy2QdHqMx3OX4zGYPdBITBDzxIwnHL6mY07Svy034gyOx7lKeQ/Myol9yDA=
Received: from PH7PR03CA0014.namprd03.prod.outlook.com (2603:10b6:510:339::10)
 by PH7PR12MB6467.namprd12.prod.outlook.com (2603:10b6:510:1f5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Mon, 9 Nov
 2026 09:05:21 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:510:339:cafe::7c) by PH7PR03CA0014.outlook.office365.com
 (2603:10b6:510:339::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 09:05:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 09:05:20 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 03:05:20 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 03:05:19 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 9 Nov 2026 03:05:18 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: take a page table out of the VM when clearing it
 fails
Date: Mon, 9 Nov 2026 17:05:11 +0800
Message-ID: <20261109090517.2905697-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|PH7PR12MB6467:EE_
X-MS-Office365-Filtering-Correlation-Id: 18c5300e-a487-4fde-fa22-08df3e40950c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|11063799006|56012099006|261021135927099003|261021121427099003|261021123027099003|261022105027099003|261009223027099003|261102123227099003|261026140227099003|261026121527099003|261028144727099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: Q5fJywO5TOkzYlOoFE2TW3DSb6gzxW2woQQqBrMidTQT2nZV2Nh7FXs9WfO3yj/YE5HFKiNncw7V/case3KfKF2Gl2bfo9lsXLf/i5oZ/WYZm9ky8spZmoO+2eHq0OEjRRK7ir6T1xWaWUgp7eKgp8VFcCPOt0LTwPQndWfQjgDjVLvOJ6F9qidagITf1+UI+qQPhCjQwZlE35h4pU/whbipVGEfd2HxCmGV7C0tX8YVNioO5gzIKo0xUKygdX0yb1HK4EZtTvj7RfLq6MHu5PlFpKuL/pLPaQWPRDVb+vDWgHIvGI/wUopdtfq+7l4++Ptr+TSCsl8D81Bn/qBXzx2LDGISIobrmh/h9jgdSJdeblnv0uNIDAZznu6/fTVM4d8tyeoWqsfRhbaQobBRjpO5rSLyxDlQLckgSHqS9CsxfN1rHgyuTbLbwAaC7XBR467Fb+naiP+Fb8FHjWI6LqZFJGWSrfWxVo7JfJ40PFJZkhRtK0EDsuBPKsaumjFuvQooVxiGN0sl55XBy/5uIy0t3n/BPxC0EYMLOgjqZ8BSTN2bCTjuFX2Clsp81tlDchcM8oDNxeQguDVz5M/JLLrjRNlFfSKw+WaI0Aa7ZCKqQoSZjry37WDvaMB9bvzQUERZFL3cF1vn6bHea6AKq4DzIo1idqFlcdz6NmeyWr2TaOwSeVmtKSMTQ1F2v3UOYd3dot0pgBBUxSlK4ikbog==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(11063799006)(56012099006)(261021135927099003)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003)(261102123227099003)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: djlIwndqfRhg+/h6JGGEBYe/iBgtQ6699+jRXOLxCovHN7d77PXjwrNisPdQ6sds7UpHdrEiJZ+hXmPmlbHJSi9sLNc5QQ4aC8zgsI0XzscU3rrtQCrAfVpftpFsRISdVS3Gic9VOQjOIoVYLnGOy0f1H4MmzBCNTepMbc7XDEQTZLw1gioZt/ohwf3H1Vr8jtyuYWM8CnQSZwDu6H35B5udZXPQQYW8Tx+D/5VtYMgMK2ehkYS7g7mPfVnTD0Om/iaXl6DQnKM457xknH3+LwKf0JZUcPZ4oKWLkyPrh3pd1QsNxnqK4CROtmoc3GQrYVgLwHFtc2U9f6OsrZ4asjm+kuUSCVifuyuqgHLIWKp/n6bqF8E87HL3MIuQmhRPDo9oZtvpFuVZTiasunhTJIiT1FauVgCXkzuAXHV4tKsxE6j2N76CUGqFX5QPT0wK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 09:05:20.8016 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c5300e-a487-4fde-fa22-08df3e40950c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6467
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

amdgpu_vm_pt_alloc() links a new page table into its parent entry and
the VM with amdgpu_vm_bo_base_init() before clearing it. When clearing
fails, it only drops the reference to the page table: the parent entry
keeps pointing to the freed page table and the VM status list keeps its
entry, so walking the page tables later uses freed memory.

On navi31, opening the render node with failing allocations, where the
CWSR trap mapping of the new file updates the page tables and failing
the open frees the VM again:

  BUG: KASAN: slab-out-of-bounds in amdgpu_vm_pt_free+0x288/0x330 [amdgpu]
   amdgpu_vm_pt_free+0x288/0x330 [amdgpu]
   amdgpu_vm_pt_free_root+0xd5/0x140 [amdgpu]
   amdgpu_vm_fini+0x8ab/0x14f0 [amdgpu]
   amdgpu_driver_open_kms+0x6c6/0xd60 [amdgpu]
  BUG: KASAN: slab-out-of-bounds in amdgpu_vm_pt_descendant+0x27e/0x330 [amdgpu]
  Oops: general protection fault, probably for non-canonical address 0xe0b3bcb1a00000fb: 0000 [#1] SMP KASAN NOPTI

Undo the linking with amdgpu_vm_pt_free(), which also unpins the page
table of NPA VMs. With that the same test shows no KASAN reports.

Fixes: 0ce15d6f7d3f ("drm/amdgpu: allocate VM PDs/PTs on demand")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index c73eb416c0e2..55de3c414deb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -502,6 +502,8 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	return 0;
 }
 
+static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry);
+
 /**
  * amdgpu_vm_pt_alloc - Allocate a specific page table
  *
@@ -544,8 +546,11 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_vm_update_params *p,
 	pt_bo->parent = amdgpu_bo_ref(cursor->parent->bo);
 	amdgpu_vm_bo_base_init(entry, p->vm, pt_bo);
 	r = amdgpu_vm_pt_clear(p->adev, p->vm, pt, p->immediate);
-	if (r)
-		goto error_unpin;
+	if (r) {
+		/* The entry points to the PT now, take it out again */
+		amdgpu_vm_pt_free(entry);
+		return r;
+	}
 
 	return 0;
 
-- 
2.50.1

