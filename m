Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F59606A32C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=4beYN8ON
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3778110F728;
	Tue, 17 Nov 2026 17:00:17 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011049.outbound.protection.outlook.com [52.101.57.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6C7310F812
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 17:00:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tR5QW/4dUBGOiVmuFNigQ3gWBwvqmeNvlFLYPGD7UX0Ejuk+gK88Yve+m12P56sSKNLVG8kBrPOnnuer2bD1edAVGhAAQtbTbNMJj/MDwMQ+Pslel+3Ce3B8xWG03cpJXYOWkevSrmaOimWmni0NfKUXAFv6p5gih+ek07cgYZv9/ra34FQW8Ts+ox7f2b14c/KY6VWntmvV9/aRr9/xUjnn6e2efEMJJXMa9w/V6Z/Vij3GjR078RUA7Jez9SrwhYhAAIWIxXrbhLP1ZHeR3+6k+oziXYN+5cIJY4PLPoe3D+DTA48dtmwyB6Zn8B/PaAgp+Qfij3ZKazsFsVyckQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89bfUWjSF73QaXfkksBrM1m8S0Kph70YwhB8x5QSnNk=;
 b=x1NuL0Av3+8926Ysgfe1gzvC7V5n+bFpI68taX9gquqjruQXh/ULkGKsWOkip6Xtj9HwnwKrKX7H6yDiGNmjZ9/iUX+5l+gPDTSS82BzA3tP8c+N3X/M3od8v02Us6lWA+Z8MjXQxUsliNcZKSHQr5HOX1RXJ4sVsqASMvH5aLLTv2qWn10Iw7PBswnhFvgm/2Vwu+8BKE3HeNeYFS72y9mwLQtaNk9p/i0kNMmtRJ1ZY4nZVPG5mHXlt1F6ub0qZS39wDSBix2Az8Kt6q40Cm5K6E8bUMB5Kfw1+A6aUprz4geTQbDZHKudRQ7E0j4rSr+9Xr66ZxK4M3Cbg+Tv9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89bfUWjSF73QaXfkksBrM1m8S0Kph70YwhB8x5QSnNk=;
 b=4beYN8ONEXcMriTBWmo/+WJQXDQMS9Tt/IyswLN2WNJCwlhMJ/KgjsNw7gz4JDvu2GB3xR7PWQLsqoh2nZcOORs3dZ3geQwwjmbiMS1L8NjTeK6H7x/c0prjuHnFp9uM75M/40BEEQoV2PpT8tm46AuwUMo2n24PpyML2BJlhKw=
Received: from MW4PR04CA0346.namprd04.prod.outlook.com (2603:10b6:303:8a::21)
 by LY0PR12MB639115.namprd12.prod.outlook.com (2603:10b6:404:216::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Tue, 17 Nov
 2026 17:00:02 +0000
Received: from MWH0EPF000DD30B.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::76) by MW4PR04CA0346.outlook.office365.com
 (2603:10b6:303:8a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 17:00:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000DD30B.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 17:00:02 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 10:59:59 -0600
Received: from work-495456.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 17 Nov 2026 10:59:58 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Sunil
 Khatri" <sunil.khatri@amd.com>, James Zhu <James.Zhu@amd.com>
Subject: [RFC PATCH 3/3] drm/amdgpu: scope AMDGPU_VM_OP_RESERVE_VMID to the
 caller's partition
Date: Tue, 17 Nov 2026 11:59:52 -0500
Message-ID: <20261117165952.3558762-4-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261117165952.3558762-1-James.Zhu@amd.com>
References: <20261117165952.3558762-1-James.Zhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000DD30B:EE_|LY0PR12MB639115:EE_
X-MS-Office365-Filtering-Correlation-Id: 00adcc88-470f-4818-e55a-08df44cc387e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|22082099003|18002099003|6133799003|5023799004|11063799006|56012099006|261026140227099003|261028144727099003|261009223027099003|10067099003|261021121427099003|261021123027099003|261102123227099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: cac7svR6+EvEF6NKg9VwquuauUzzUGNhiL11iTT8RFpzoLRMFsGV5gqA89WMLVWq+KtCvLbGMN9sc/bNfXyWE+98Q/acg7Z7cgIMOZyn4ByIuB+5pkffzbESfZ9ZD8HpZPSNcH8xBlw+T0VIsOeM/67eccYN39sbwzEwiF2PLTUL3EsLt6vPH5myngcsljrW7fVW+rXLW/w3/GLHDt9pBLlGXMtJ+eXS+xAXPT2itRtbRUAfQURTEkf2L6uWxnjOkqUvAKCsxSuwzwPVgpBfBux4IxEIdcmT3y7fQ4kKAcFwSRbvVtVLJjRzQQ0g5sHxDf1wD9Mwt1UAeTUbyg11q7h+2oQnrN6WBxFmWLGOZJkdMs2UK3WxFgsB4MH0GQZP/lITAL9zsI7gMh2lT3+cpDwtGVJkE5/2RZwQMGOzSu/LpuyVSM3wj19NcK8s7xMOLJwmaIu8NLd97sHpC6u8B3eXEFz3HtaoFrsWvzTwTlCzta6OLGSZjnpayS2mJ+3N8YjvH/svE93tCaXmcouiBPSYgBAIE5JYhC9/jPlYMa+EW9s3VzrZI5v3/ntdq0yMON/m+CcmaLuWsOwFpy5odmnWlk3f/2c0BdOEYhXDWUSmUpvXy+wHvKkC0Vtqrr6R4QIQ1CXz+z71yafbCdDFw8oPJoF9p7Qh9oKJcTaABtzzVi983JNY4VBNEf5HCcAyq33hMDpg4+ODJbugtEwSEA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(22082099003)(18002099003)(6133799003)(5023799004)(11063799006)(56012099006)(261026140227099003)(261028144727099003)(261009223027099003)(10067099003)(261021121427099003)(261021123027099003)(261102123227099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fo6gAYi02BrRS+R/oIuLI5Yhhm19q4+nPJCyDjs38VoEti7Nuqhl56TaBVJdKSU2D847Aj3ALj9r+58CX/Xl4ihZ41Q0tJLurl9meHVFo7FYWwLf4tvkg0N5aakmTmWKeq5rQ4Y/HVoiiMX6YUDyQNOcfWL1faa8My2JDjyIaN8KM/bnfho9vQYxeHF4Qv3vkDtc9+8cLd2SZsFpZ61txrVBkofD00+tEgICqHlAwNE3H+d9uSw7xPH2LOOGesiF7DVWuiie7sKmzR+NbOjilamvM7TgZafPaVPPKAKhUmPd61F6ycI2UUeLgi3k+NncGZRgDsNDw8PrwHE5JgjP38rj53ng+46pHFZ9iZXQFukaSrmZmXb1RYY/HJfkWqwmG88obFgry7m5YPUmvDeXOUg7vAiCRVtIdC9eWLLyB9C0quKH2rCLh8dkcnDhMiRV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:00:02.0145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00adcc88-470f-4818-e55a-08df44cc387e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000DD30B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB639115
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index bd9aa35933dc..d37af0dbd691 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3021,11 +3021,21 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 
 	switch (args->in.op) {
 	case AMDGPU_VM_OP_RESERVE_VMID: {
+		uint32_t xcc_mask = adev->gfx.xcc_mask;
 		int r;
 
+		/*
+		 * Scope the reservation to the hardware partition behind the
+		 * caller's render node, so other partitions can hold the
+		 * reserved VMID on their own XCCs independently.
+		 */
+		if (adev->xcp_mgr && fpriv->xcp_id != AMDGPU_XCP_NO_PARTITION)
+			amdgpu_xcp_get_inst_details(
+					&adev->xcp_mgr->xcp[fpriv->xcp_id],
+					AMDGPU_XCP_GFX, &xcc_mask);
+
 		/* We only have requirement to reserve vmid from gfxhub */
-		r = amdgpu_vmid_alloc_spm_gfxhubs(adev, vm,
-						  adev->gfx.xcc_mask);
+		r = amdgpu_vmid_alloc_spm_gfxhubs(adev, vm, xcc_mask);
 		if (!r && !amdgpu_bo_reserve(vm->root.bo, true)) {
 			amdgpu_vm_spm_update(adev, vm);
 			amdgpu_bo_unreserve(vm->root.bo);
-- 
2.34.1

