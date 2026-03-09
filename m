Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DFEF417EE
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2026 14:57:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4420710E51F;
	Mon,  9 Mar 2026 14:57:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TQXcps04";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011002.outbound.protection.outlook.com
 [40.93.194.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB6E010E51F
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2026 14:57:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HcVvFqRd+kjTsNlOYG6qa+7yHIAROwrvnbeIvXChMps63uWtkVHctKOD7CEWSOLH7Kczwi2XKmA73H49hkzbCNgeoZ8vOloqb4R6qwoN0HxCI8l1kqEemukkIhMPMPmshNp0Z9+9L7rSoFP2aoL/Ef8fLtkVCVqO2sh2JKKQLdSuv6m7WS0TuV9eB9IwzLWnFEto8EfLppuM2XdGCeYw+FPyM8txqDNuTg+nHyWx883spcAFP7x5JLhYF3RW6HFQLI+rMWnt3ja08Fcl1U8dZx0LCOL8VAd01gKZsnIa5wiaosjmFSjxpalxCxKm7YElmxhDPRpIIHu6Uw/DnCaJsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bok608bhN5MeWwMNFlsW7YyWc9sB325h8Rc4i7xmW1Q=;
 b=ahc2OfUNTvUkzwFr+uKVo8Ehuxd3GF4KzwqIXC43hI3/ESSIHwmpbBSrSFw89/OV47lzKzbbkA+hpZHdqEUDVW3Xq0abRx9IH2ToBSraDst4kuUwm6gCHAb4EB+6wXVcDRaHHRuDvwVxW3H6mRnu9E2f11qob1P35qaXu99teKjqMS9wI9Ayr0s8v9wc3KPOxAYNymh6PoYIg3XaQkSuyPfyZv6VdzSW5clv9qVXnBcV6eYdg5WTG9kI1iBHKxKrtIt0SKX8LybBFoZIeDVp3o8p4CPV49FgU6w2XtYWXDSevegAjjAydmd1ySvEVMtqBl8l5lGIAsliXzVlCCQy7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bok608bhN5MeWwMNFlsW7YyWc9sB325h8Rc4i7xmW1Q=;
 b=TQXcps04/jknxKd6b76YC3o8Ty2Cs/+nKtVG0snBnTj/xKWJSY/PS7iRymb2s0p3azc1NgdhMfmp4VcFDYnA+2iTDb+XBs6vrA6F+sX/8UHnsw0eWNILPgP+GWT0+0uqe/9NsLQfSqlA5xjvhDYRbaO1HKqdv3zimxM3iJu1AqY=
Received: from SJ0PR03CA0371.namprd03.prod.outlook.com (2603:10b6:a03:3a1::16)
 by MN0PR12MB6320.namprd12.prod.outlook.com (2603:10b6:208:3d3::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 14:56:58 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::db) by SJ0PR03CA0371.outlook.office365.com
 (2603:10b6:a03:3a1::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Mon,
 9 Mar 2026 14:56:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 14:56:57 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 9 Mar
 2026 09:56:47 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Mar
 2026 09:56:46 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 9 Mar 2026 09:56:46 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Le Ma <le.ma@amd.com>, Feifei Xu
 <Feifei.Xu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Implement get_xgmi_info callback for mmhub_v4_2
Date: Mon, 9 Mar 2026 10:56:21 -0400
Message-ID: <20260309145629.2844495-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309145629.2844495-1-alexander.deucher@amd.com>
References: <20260309145629.2844495-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|MN0PR12MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d25db07-8fe7-40de-502c-08de7dec1ca8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: KFIOddO8KVcG5KGN20veb4iEqf+Sspsmqmsfk0Py12+8d74fcph4aW1TdtGErf196Et/Wi3Cyv/6K9se1oMyOB94Mn/1/D3XAVdA8w8PSxxq3QKgWWODYEhDVmGL+ywFvPX8uhhTgp/zXoTtlRXXONuLPSNBNriJH9ZEYFL0dfbFEYPWhRCgw4bI5uMuoac73qiG+uzjK/JOnYRtaNmsNTxIXjzD1XXC9lIo2nf0YAU8hB9xTZJz1lmu5YRFaUg1wUrH3hLBA1F+9K1WvrcwDxVWZbDyhBKj3TD4BQNW17FY7SZ7gzxQhPhrN7C38qxn5BA7NXvMjDFBkrVhf1Wb78OZhHbyknZDcU2Pf0BcADL0lTxShlwQZAXsqV0e3eS5oLBX6nJRorMt+dUxbMLoNOzzq+VGH5gKp3siRMLaxEnrcFfoUcn2JlCAka8j2OSYCrouuzoJiBdVraH2Ae1uEcppxnd6D82GktiAzyEZmFM7Te6YU+oV7tqWXYNQnnXzIIeRBeKB2KFyeNMihffPIEiTz0n5IvgSj0O3Y74pSZ3VEtuhXJ42QnuSwBvLwBA/C29Eyw8WkZEkkwfItv8XRnQDk6f9kDHJ2aBi15EUwfSVvJ6RXtRhouSqi7pC696iafK5NJVXmm9TymBFVxYrgJNmUfmnGR5ntYiWiSLbWC+7HHPjibFQHEKgbbBCBUalNfW5gJrEEwJbtBo7rnm8L1zwKWsLQ0Vsvwnpkke5HwQlOflDq8UXs0d9g3YErE9y8sc9yduyTg4zrDqfX3DJhQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RJ4FmZ1eBVMJBqLPU2d6LXjaa0HqhL7mGxw2uEXLQIanCWJCIn9QYmLEgAxhZTzYaVD7/CyYJUtVmXuewRm2ojBTLIPudgrRrxtJl6AKVch3t0hsOsoZ+Kh8AOZ9afXFM4C6U8QZIGrxQ0AznFrfEI5DyCrwUNAUpqdbDx5LKicILtQ09q6GzC6NIJ+w3+SoK1WI3g1Pk8p2wBxZotF/9D393IM+EQoZNcZbfm93y1HklJy/klChlZR4IzllL75ZDlC3iauvj/H9W7tp3ATx6rElHSpw4UydabXdkvve8PHjoXkwvVbrwm5BNyMr6TkUoeOlWdx1cCGvz3BCpQuaFv7DBEU+rnvYPbKXVyLDqLxlyporuzIHemhxAn+pQaNLGQ2rHLFe0L96vSL3Bh8maYpsWrSTVtigCiSkSExjIO82HcLg62dSxVl97sR4Wxlr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 14:56:57.8395 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d25db07-8fe7-40de-502c-08de7dec1ca8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6320
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Query memory region assignment and address via mmhub

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h |  1 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c | 40 +++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
index 1ca9d4ed8063a..92918101a95d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
@@ -63,6 +63,7 @@ struct amdgpu_mmhub_funcs {
 				uint64_t page_table_base);
 	void (*update_power_gating)(struct amdgpu_device *adev,
                                 bool enable);
+	int (*get_xgmi_info)(struct amdgpu_device *adev);
 };
 
 struct amdgpu_mmhub {
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
index 60bba87e42a01..b025c1fdc52c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
@@ -72,6 +72,45 @@ static const char *mmhub_client_ids_v4_2_0[][2] = {
 	[23][1] = "VCN1",
 };
 
+static int mmhub_v4_2_0_get_xgmi_info(struct amdgpu_device *adev)
+{
+	u32 max_num_physical_nodes;
+	u32 max_physical_node_id;
+	u32 xgmi_lfb_cntl;
+	u32 max_region;
+	u64 seg_size;
+
+	/* limit this callback to A + A configuration only */
+	if (!adev->gmc.xgmi.connected_to_cpu)
+		return 0;
+
+	xgmi_lfb_cntl = RREG32_SOC15(MMHUB, GET_INST(MMHUB, 0),
+				     regMMMC_VM_XGMI_LFB_CNTL);
+	seg_size = REG_GET_FIELD(
+		RREG32_SOC15(MMHUB, GET_INST(MMHUB, 0), regMMMC_VM_XGMI_LFB_SIZE),
+		MMMC_VM_XGMI_LFB_SIZE, PF_LFB_SIZE) << 24;
+	max_region =
+		REG_GET_FIELD(xgmi_lfb_cntl, MMMC_VM_XGMI_LFB_CNTL, PF_MAX_REGION);
+
+	max_num_physical_nodes   = 4;
+	max_physical_node_id     = 3;
+
+	adev->gmc.xgmi.num_physical_nodes = max_region + 1;
+
+	if (adev->gmc.xgmi.num_physical_nodes > max_num_physical_nodes)
+		return -EINVAL;
+
+	adev->gmc.xgmi.physical_node_id =
+		REG_GET_FIELD(xgmi_lfb_cntl, MMMC_VM_XGMI_LFB_CNTL, PF_LFB_REGION);
+
+	if (adev->gmc.xgmi.physical_node_id > max_physical_node_id)
+		return -EINVAL;
+
+	adev->gmc.xgmi.node_segment_size = seg_size;
+
+	return 0;
+}
+
 static u64 mmhub_v4_2_0_get_fb_location(struct amdgpu_device *adev)
 {
 	u64 base;
@@ -884,6 +923,7 @@ const struct amdgpu_mmhub_funcs mmhub_v4_2_0_funcs = {
 	.set_fault_enable_default = mmhub_v4_2_0_set_fault_enable_default,
 	.set_clockgating = mmhub_v4_2_0_set_clockgating,
 	.get_clockgating = mmhub_v4_2_0_get_clockgating,
+	.get_xgmi_info = mmhub_v4_2_0_get_xgmi_info,
 };
 
 static int mmhub_v4_2_0_xcp_resume(void *handle, uint32_t inst_mask)
-- 
2.53.0

