Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A942B606A332
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 18:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1gK6vVi6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2794D10E623;
	Tue, 17 Nov 2026 18:20:32 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011020.outbound.protection.outlook.com [52.101.62.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B0EC10E623
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 18:20:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rOyyJfYvq3P5Gw7JzQ86CTPIeWK7ICTvkYrJ2Pma3XXuDtrEUf4KcTvfCFvbvp2Ev9mbRqrWgo4YkB2tt5Hc//QNsXsFSnUyRL1V4AoexnEOrZe2yRwE9BQ83cRNzJVdFLEtmcPO4vMNMmug4PwXLyAw7uF7fdags2H3cK1F8R9A7+V6HwAoiYqJLLsSuWSATDD3j78i51YDrNYy7d9zOpYz89w5WOONXU2TYqxV07moOyvM4gY1sod2n13LUspGXoXEPTaHzW9MCnaptTRaNO8YyV5njjKJqBnAGYJZuLVNKMlJGnDn5KLmyJ4ensuL1r2t3dmvcH863GiH26tsag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxw0kvp42sE9TAeF2WZ1qMQmpyYgHQYSL24MtgeDDR8=;
 b=SOyLTHaZqivC3Wyw9qrKi2qJqaxN6Qvo7IPVCBY2pPfUkxigNK2EXk/AfFqVnACzkrImzBNegLp++ABJhPV0beqbs1yt24F0XojyA+shTrkUL9eePPo8zp63bUy2j46Ng6zt/sEjroE8uF34pyiPliu/sdw9stecEy/pJJdj6Vyx6vxbezC06gUIu0FuWN1J8l3F5R9a13HiInHa50kjZ9xPNWEzEokUPTn4TQ15VL3v9qpblsdyZM1CrRQKn0p7ZMdzVkZPiRj7C9OqIHE/1k9m3pGDgbbsHfA/8uHqZzyxs/gH8rT/Mpr5aPxdYMcq2os9vopDtZlmo9X+4hJNTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxw0kvp42sE9TAeF2WZ1qMQmpyYgHQYSL24MtgeDDR8=;
 b=1gK6vVi6vrHwtl3MocAWXpfGcUzyNpuiV4urL1CUXQCEWCZRRiy7pU9xGA7Zei2A0rVT/COPbPrcld7hWA23Z+XrjJ4dPNElP3VacsldE8+CJlmrbGquMD3yLJOTjE+XLytxPq2Tp06MQilxoVYigZ/B8i9nSACd6SMnsXHcXnA=
Received: from PH7P221CA0058.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::28)
 by MN6PR12MB8472.namprd12.prod.outlook.com (2603:10b6:208:46c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 18:19:43 +0000
Received: from CY8PEPF0000005E.namprd21.prod.outlook.com
 (2603:10b6:510:33c:cafe::34) by PH7P221CA0058.outlook.office365.com
 (2603:10b6:510:33c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 18:19:43 +0000
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
 15.21.662.0 via Frontend Transport; Tue, 17 Nov 2026 18:19:42 +0000
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
Subject: [RFC PATCH v2 1/3] drm/amdgpu: expose the XCC-masked setup_vm_pt_regs
 as a gfxhub callback
Date: Tue, 17 Nov 2026 13:19:39 -0500
Message-ID: <20261117181941.3968996-2-James.Zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY8PEPF0000005E:EE_|MN6PR12MB8472:EE_
X-MS-Office365-Filtering-Correlation-Id: e2856f1a-98c7-4b66-a2e4-08df44d759fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|261102123227099003|10067099003|4143699003|11063799006|56012099006|261026121527099003|261021121427099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: lAi91aapkJs7qK3IeMYK/3nBIXzINYnqViQt0m3ConAiwrYctUT2P7z7qKeASZjFWj6CDYB6l4FL5RQcFLzOkqE+cR4rhZpX7OnQdXzeWlazbQLWRfnksh+a11Lv5r4mOYx8tikA0WMuujcRI0aT5iOWMw7Of092FpnT2HYdyevXj8ii5Ng2WtV6iq+pzExM0usAzG016a7fhsr+Jwcz1TCCfNz08oTLYBjI/ft1sNHb4DwWLXUOLkLbaQ6hpEsPWnmp8vBPP+y7NObgfyhRPJUFB23jSo/uZLKpta+KQ4xVHUd23EIPQjADRv11l0uiZUgX+JsFH0VfuGli4aU2Pnmd+K0vOuHElK3aI33XQYR0vBUObWBloYhJfg5cDe41+kUxA5q5m4xbjMb1pJ90U1K6mYmZtaDx5sWJxi71pqAFp7xG63K8HiA9ikD58nrnnfSGCIaeB81xOM8zRMUCeOZWpsSvcgyiks6xYYJQO9QPg/o2Spcva+CDnX+nwXtDhKMOSKZn40w1l0VZqjxiqlNFVc7nTN/byXj7BZ0ukx4VSAMJqWei50zBcFynrsFNkKx6BYZlg7OG5cGUhY5pSBLusjcydDfaNxJxNQywcme+cmwxp5ZR41qDmY/kuOjKIVEF3YUyuSTNdVm/Dp8JujzSoC2gRCyGznEVgYeajrXwVeM5LIoXywISHGRnKPh1ApDHZBtFMylwBHoviN4sAg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(261102123227099003)(10067099003)(4143699003)(11063799006)(56012099006)(261026121527099003)(261021121427099003)(261009223027099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uta6KqtPVoHhL1ypc+MEoTeCxGI2tjRNL3h8/WlC9fWJ3sEysr2sMzXw+P6hVG09ohLp0Uh1fyNlk0GBdzjDbgSjip0f3Q7/LIvWhlijHETyYj4K+Y7LS3DVNOx0eGd/acgQCjL8JNwSQSb113HrUgvb9mAhlEzHjX1xv7PsiBkghnKYcZcnQh9Y4ayfyIStlrFUvi1YOwcQFU9lnfOFKXL7zj5yEkQGB0eb63PTWRtP9p3A4Wwz3XF8XRUWcI6ilg8pGaOxx38+I2GnRsVYs0LquRjNE0f7TLwMVaKuCpYp4k/Zt9iO42XofHpSegD5PiaB2h1AGEOu3UqVwCq9cID7ERcv6smn3CjsP9NyH+PlDHqq8LU/qriB6URDa2bxobp+fq1CcBZ9C65f3q+3WYGfmoMoayrebGCqm50N52ejKLwj/j24H2PEZwkqA2dk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 18:19:42.7527 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2856f1a-98c7-4b66-a2e4-08df44d759fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY8PEPF0000005E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8472
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

On GFX IPs with multiple XCCs each XCC has an own GFXHUB, but the
setup_vm_pt_regs gfxhub callback programs a VMID's page table base on
every XCC. Callers which bind a VMID on a single VMHUB, like the SPM
VMID binding, have no way to reach one GFXHUB through the callback
interface.

gfxhub v1.2 and v12.1 already implement an XCC-masked variant
internally. Expose it as a new setup_vm_pt_regs_xcc callback. GFXHUBs
of IPs with a single XCC don't implement it, for them the existing
callback already is per-hub.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Assisted-by: Claude:claude-fable-5
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h | 2 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c   | 1 +
 3 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
index c7b44aeb671b..19b961cb12f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
@@ -28,6 +28,8 @@ struct amdgpu_gfxhub_funcs {
 	u64 (*get_mc_fb_offset)(struct amdgpu_device *adev);
 	void (*setup_vm_pt_regs)(struct amdgpu_device *adev, uint32_t vmid,
 			uint64_t page_table_base);
+	void (*setup_vm_pt_regs_xcc)(struct amdgpu_device *adev, uint32_t vmid,
+			uint64_t page_table_base, uint32_t xcc_mask);
 	int (*gart_enable)(struct amdgpu_device *adev);
 
 	void (*gart_disable)(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
index b13967a1c8fb..7bc17721f463 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
@@ -809,6 +809,7 @@ const struct amdgpu_gfxhub_funcs gfxhub_v12_1_funcs = {
 	.get_fb_location = gfxhub_v12_1_get_fb_location,
 	.get_mc_fb_offset = gfxhub_v12_1_get_mc_fb_offset,
 	.setup_vm_pt_regs = gfxhub_v12_1_setup_vm_pt_regs,
+	.setup_vm_pt_regs_xcc = gfxhub_v12_1_xcc_setup_vm_pt_regs,
 	.gart_enable = gfxhub_v12_1_gart_enable,
 	.gart_disable = gfxhub_v12_1_gart_disable,
 	.set_fault_enable_default = gfxhub_v12_1_set_fault_enable_default,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index e89813590539..a56c072daf15 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -634,6 +634,7 @@ static int gfxhub_v1_2_get_xgmi_info(struct amdgpu_device *adev)
 const struct amdgpu_gfxhub_funcs gfxhub_v1_2_funcs = {
 	.get_mc_fb_offset = gfxhub_v1_2_get_mc_fb_offset,
 	.setup_vm_pt_regs = gfxhub_v1_2_setup_vm_pt_regs,
+	.setup_vm_pt_regs_xcc = gfxhub_v1_2_xcc_setup_vm_pt_regs,
 	.gart_enable = gfxhub_v1_2_gart_enable,
 	.gart_disable = gfxhub_v1_2_gart_disable,
 	.set_fault_enable_default = gfxhub_v1_2_set_fault_enable_default,
-- 
2.34.1

