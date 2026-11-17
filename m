Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F09F606A32A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 18:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lj7xUysM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72E0A10E91D;
	Tue, 17 Nov 2026 18:20:03 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013018.outbound.protection.outlook.com
 [40.107.201.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E3F210E496
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 18:19:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L3EKMLWhUfZa4GNZyBOlqdOYE51WM68DfIHkL/SopghcCsFDV39ravo27lFojkKfeA8cROlKQIBtpRtEaVvxueCZrDcgVucGvBKlwQ9D8286Gtz7OWHydJA6RYi3mIfMoUFx77n1zNLwL995beMGq5tYo1mP4xODOtl9jU/4R+4BO3BUjFkuRl4BqhSyK6+pxBAXr7RuKT3IjGpZxr7oh11QqDJFf7gjG48oI8ZeEREck8unT1OC4wSUDMndoP19OwzgpDHP8PtVzzxXZcNqSl62vSXEt9dTKH8zd3AxbdG1+3VZhSwCNj6BRpA4e6qRurBiNfM0D+Jl25fz7Yt33Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOt7ySH65Cr04A36/2ZT7qii9qy6E2g07rW346JYtwA=;
 b=nGt4W9nGe6Kmkl+BaUNu6BLygA1nVXplMalynuE8k7BHWwIEUOlYgTbaDpa2I8RoiZoA7D/5VmfE1CMBYtAU/qqwitYkKsR8CirC5QvSjMMPo0MpdXEQYVvPIig/i6UtayBVg+qv+rUylOfGgfECB8GIf+vhbwYqfNYVpRh9UXsyR9+QkpZpw5l+MDUvYM5tsUOy35B0ApsSfWgjFpLseES2OlcqAtP8OdETOTNqoo0zVr0nfWzMtu/MYIn1Jgiwn79vOF1ugnnFzjciVV874koC+otmne6PA1+2CuPTxL+u/5jmFQ+tcAd/4VNw2ir8nIU+WQgLirw6Z2/k+FClzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOt7ySH65Cr04A36/2ZT7qii9qy6E2g07rW346JYtwA=;
 b=lj7xUysMyQ8uTH+vpznAxcKKFLJFWdNKM0u5BT+FiIJQwzFyV+AArGezLLL1+7JoMbQ6NogLwvI4RufLg1MwMzJQSf46XTCQ1GdLSBZvwyrZAMz03qysZzfq8MrA/smcprWU2010JH7c22SAh5jRn7XSOzdZ4qFMRa4covSGrTk=
Received: from PH7P221CA0058.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::28)
 by DS7PR12MB5984.namprd12.prod.outlook.com (2603:10b6:8:7f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 18:19:45 +0000
Received: from CY8PEPF0000005E.namprd21.prod.outlook.com
 (2603:10b6:510:33c:cafe::2c) by PH7P221CA0058.outlook.office365.com
 (2603:10b6:510:33c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 18:19:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY8PEPF0000005E.mail.protection.outlook.com (10.167.247.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.0 via Frontend Transport; Tue, 17 Nov 2026 18:19:44 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 12:19:42 -0600
Received: from work-495456.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 17 Nov 2026 12:19:42 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Sunil
 Khatri" <sunil.khatri@amd.com>, James Zhu <James.Zhu@amd.com>
Subject: [RFC PATCH v2 3/3] drm/amdgpu: scope AMDGPU_VM_OP_RESERVE_VMID to the
 caller's partition
Date: Tue, 17 Nov 2026 13:19:41 -0500
Message-ID: <20261117181941.3968996-4-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261117181941.3968996-1-James.Zhu@amd.com>
References: <20261117165952.3558762-1-James.Zhu@amd.com>
 <20261117181941.3968996-1-James.Zhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF0000005E:EE_|DS7PR12MB5984:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c2dacff-eff8-4c38-cbe0-08df44d75b3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|10067099003|11063799006|56012099006|5023799004|4143699003|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: QzXuVKZEC4SpXbIOUqHSXoKMZDbciPyB7eNKPJML36CGiQ0hhuReLlgdx4EoIgvidGzAKtN9gcKOkOu2IXW6wcfdlYS5c8sZO5UtzHeleUJ07nW5gXKD6i9BowA3+ea5gfpuWVF3tuQUcYlkZxDZegg+YifdvGxIPYnJgZ4o8eZCB5lw9XrDOFEUJ4H90TvdVyQDfkjCT5C3fnecIEPaKf1auhVaRc8FYKNCCwIVLpAmukPUSdzy8iVdd52AYF+vYWzBLdre0FVGKWhPuAKLQtbn9zE3gCZZTdZ8GQ9jWaClPJ6PIn7bvoYJ1VS5yQKWoPvyL64bC7gxvIL9yPIf/NcfK7IJpSKtLIC31eE1xOo0d3iw13ifqEtEgAK4fZxaWNCB7EBYS/90Y11fk5PjNwqD32gJPdo0ZiNMPwSFZooveahkhZnN98+qVegtuC7fqAAB/P78PlhP/IiCfg6Lq3yiXN4wtdqSYBWAsTEImBHCXPreAfOCl9HvLbWJB70GLsUHnelwYj22QB1wyeuQqsxfIMy3/dya2n0SorzGbBc/Gdut+4WQhZQTUs437qrYmYjlv/43ySwT0aLcq/xbUNcRApvm8eO5ykD+sds8olLbRPrfQOoC2d4hEo5xWC2kvCoE2D1yHdqyRN+UsT0nIXBMESyUKLYNdRNbTTJvgyTAHniehfULM5VMpEZh9Irm+n84/LXEb7S8+8ukm4IhOg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(10067099003)(11063799006)(56012099006)(5023799004)(4143699003)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1tvYrPCo9YtEeJMI7mWpN+AjT40OkI+F+d9rimyHOXkxLhFldHkiJv1cugPQKc947Fg5CpJ10eliX9jYoER5ztRxfZyzJuEaEjGunS1xljGzp1hBV9Q3l7kWQNqFswBSvKq/q4HtwNGzTMyL/W81cOhD88nsizBmnYN0+rjG9Xgbs7XcnszavvsulCeHmJcyVdv8QtmpjIlZ4TfoKJbN9m7ucFTKUm/2+ANWxrsQkmduV3f9+Otdx86IutYnCOs4Zgwlf5QQd7svsPpnIG/GtqcXyr440qsuf+WQpazMnsQjZCe2yEsw0wDhtAvKvBSAHwCECibGZWkFB5JoLNnnDsaaXgt4gL0PUWzBRsw7Z8XlJVwb7TJr+FlrNisRosYe8YdVNNr0HSISw3is9jqRJr9cQxraEG76QSgXI+DnVoEr8NBwT+/qiVWOA24uJP5y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 18:19:44.8641 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2dacff-eff8-4c38-cbe0-08df44d75b3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY8PEPF0000005E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5984
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

On partitioned devices every partition is exposed as an own render
node and fpriv->xcp_id records which partition a drm file belongs to.
But AMDGPU_VM_OP_RESERVE_VMID reserves the VMID on every GFXHUB of the
device: a reservation made on one partition's render node blocks every
other partition from reserving, and rebinds the VMID's page table base
on XCCs the caller can't even submit to.

Derive the GFXHUB set from the caller's partition instead. The
reservation then only covers the XCCs of the caller's partition, and
each partition can hold the reserved VMID on its own hubs
independently, matching the isolation the render nodes promise.
Unreserve keeps operating on every hub, freeing whatever the VM
actually holds.

Without partitioning, or on the whole-device node, the mask stays
adev->gfx.xcc_mask and nothing changes.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Assisted-by: Claude:claude-fable-5
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index a9c23759d058..403807cb615d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3032,6 +3032,20 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		uint32_t gfxhub_mask = GENMASK(NUM_XCC(adev->gfx.xcc_mask) - 1, 0);
 		int r;
 
+		/*
+		 * Scope the reservation to the hardware partition behind the
+		 * caller's render node, so other partitions can hold the
+		 * reserved VMID on their own XCCs independently. The
+		 * partition's inst_mask is logical like the GFXHUB indices.
+		 */
+		if (adev->xcp_mgr && fpriv->xcp_id != AMDGPU_XCP_NO_PARTITION) {
+			r = amdgpu_xcp_get_inst_details(
+					&adev->xcp_mgr->xcp[fpriv->xcp_id],
+					AMDGPU_XCP_GFX, &gfxhub_mask);
+			if (r)
+				return r;
+		}
+
 		/* We only have requirement to reserve vmid from gfxhub */
 		r = amdgpu_vmid_alloc_spm_gfxhubs(adev, vm, gfxhub_mask);
 		if (!r && !amdgpu_bo_reserve(vm->root.bo, true)) {
-- 
2.34.1

