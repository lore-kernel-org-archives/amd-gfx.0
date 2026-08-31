Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C170C61DFD
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43FA210EA87;
	Mon, 31 Aug 2026 18:29:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NK+BRO3e";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013029.outbound.protection.outlook.com
 [40.93.201.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3454A10EA66
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:29:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWdOVCe0ahuLDINo4SIFCzeL6sJznJ6Qh3DRbayQTWu0FTIMh8V46HWMTcypQupIogfBzvENCipDYv3YnwtRzOPxUKAr3v0iL/gql27qQwJVGAslx7eAJYSqGPHDdvdK6j9ltduin11q6W8quIJguXNjh/gMZrYImew5kEALoG7GJqbcpIfdjHWuN9AQMYEqePSVntOI7l7hBCBH6BJKQcnIw+qYcwUC+zjmhnd/ZpuxQ/ewzwTkpHZOyHccY3tGG65qb+b2oyv5S9/OPRRz84A6HSopMy5I18btGUd840niP5dugTUwbWTgp6qNyXn7aerYcuPnIvZ1gQLKxLAIFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8HLaSGocNbrumDj7Ri/MpcT9g6BabEFlW72/q60C8U=;
 b=CbKgwil4DaT0HKJtodt6fUhY31vOzR9N/q+rUHzH8XhjN9UDf2DxT9IThNGzg8Sqr3iACLGodMiVVPuXxJcpcnsNlHSrR+2N9U5+EwMpL8U1+zG3H2KybLc3wSy4jOCPMjFWc1Yul3a8GPA3YMadCoPl/hA6gfCZep0uulapDVjy9qrPcF2DbnQFG4DvImnFjfxr/89UF1PGRsNKZpKAnu3ZoudSbEZ5nKDN6Cu+RO/yh9WNZUp9gfGOQ8ejAQ46G4DbvRrYYjRnK1APs6qHy5MIEDvwEtbq6z23JeKsifqmLWli6oaRVvhKT77ypzBwhAQ/Gi8QP3R+rvm7pnXkwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8HLaSGocNbrumDj7Ri/MpcT9g6BabEFlW72/q60C8U=;
 b=NK+BRO3e0JeZx2QyxLttmfNAPG/H6Vq+7UvrkoVizZAgkJNk/mbbUkW7gknr1vr/cPceBV1KPmiQ6whI0pGNVJvqniLvfkJ+we+MA+wng6PwH8V7apXCeJpbIjQ6JHOQMvERQSO9Gj6+uvSgAN1LQ7tQO6fR8Fr7J6GFnC6KVnI=
Received: from BN0PR04CA0071.namprd04.prod.outlook.com (2603:10b6:408:ea::16)
 by SN7PR12MB7345.namprd12.prod.outlook.com (2603:10b6:806:298::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Mon, 31 Aug
 2026 18:29:12 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:ea:cafe::6d) by BN0PR04CA0071.outlook.office365.com
 (2603:10b6:408:ea::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:29:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:29:12 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:29:03 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:29:04 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:29:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 90/95] drm/amdgpu: Add hw_fini for ualink
Date: Mon, 31 Aug 2026 14:27:49 -0400
Message-ID: <20260831182754.1089811-91-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|SN7PR12MB7345:EE_
X-MS-Office365-Filtering-Correlation-Id: 7442f8fe-fbdc-47f3-9e3c-08df078dc117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: YGIYh76G8Ka7OW5ixb0fB6BUotQDHi9h/X+Qu2hfLJ8Yj68eJFKL/UDtsWB41yA9lBy6w7GGDWUdO92IjJPDe4dFqUHMxuEq4Wj5cVN+MF7HLBLXr8azH6r2gDedT/fr+ayJwJ8adiekpnMhFqwOeMWgjuSnMPYIbBEDqpyscpdarr/npovBAOMcVsNCBleAU7DX7W3utGsGCIK9B4Ld3cWpkRYXElc6kaDqm09lBVoVDi5jcleO5kCxOcOUjUiiv3X14NFjTOd8vTBx3Yvpu4XVWMrfDxuc7ocxdnXM5ZbNjjh6i4x6fZmwpYEVyJzlPCH3sEMLsLLRDrxkvsry+r3XPmvgADgpGTakvP0oIsAOyoGAAlPFd+l5qaqZ42G/Kn10C+fsyLBqkGG46+cf4L8CSQ4KfhVxyhagHoFrfQXOIoGgULyy5XAc3XcqhndPnO2bAwNLQeQdSCM5Fa7CYFrFMarvvon4KG2mw4uZBX8ybxzj6icdn8Bk5LyDzaSUSMwQnw/YS0GGzXnOwcMrjmBCzpIy5r+w5gBy2SIhq5hEHhq3/kd6Tzy8JSafbk0L9yViEfYGNw6R3fNEzuyXzOn7Frn4nVh1UxXsnoH2njO8bhYyketbYgZlh2b18RhoIGiczwIjCKlb+MVVVzLe+iG6KkQbWr3Eh4b3QRHgaUJh0w4KraGZF1Uhlcq0Yu2XXpgN3tH/l96jEm0zOx9Y+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: c0sLIQV2V5VE6VSzSe4L/buk4y8d0cfqZepxT8jvd7GDPzt41R+TcCpexfGGUDHvZ3ryy6JNx/VJ56hMs98ViqNDmoRoWG2bZyvywy75i0PcZ3UJn3lyO7GjV7Z6G8CD4cAEiKpnhMrpBgINeuaXeo7CWBUi/aM3AWRBTCJaSnZbVqqdg6kLqmC5H/qjDdnlRge/4PhKf5kmY5CzpyF/s45Kzz1CdDplnmvcc3LPKFLS8r3IrYLtI2g3HdnWeVFILGRW5Scthmyh9uFDFE1DodM0XWhwCKqTU7r5ntjXiV8KMbtf9SPPvSxaLEOyD1oPZ5MauFayMM3NkGfVI6WjyoedL8WbSU5qceDBKDrJ7UOLnHo09RtoUzswWVF5RPRRZMch5SMErhwHTKAa9lDdJspRVKyihz6kZXXzpgQKHEMV3645gdghqMapTXUek1hu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:29:12.0808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7442f8fe-fbdc-47f3-9e3c-08df078dc117
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7345
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

From: Lijo Lazar <lijo.lazar@amd.com>

Deactivate accelerator from vpod during hw_fini sequence.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 13 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  1 +
 drivers/gpu/drm/amd/amdgpu/ualink_v1_0.c   |  1 +
 3 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 5957a3a2c85b1..19c2df55581b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -425,6 +425,19 @@ int ualink_ip_hw_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
+int ualink_ip_hw_fini(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+
+	if (adev->ualink.mgr_state != AMDGPU_UALINK_INIT_COMPLETE)
+		return 0;
+
+	scoped_guard(mutex, &mgpu_info.mutex)
+		deactivate_accelerator(adev);
+
+	return 0;
+}
+
 int ualink_ip_late_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index 792b0fc9fed97..8ec0bc80a0f7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -413,6 +413,7 @@ int amdgpu_ualink_import_handle(struct drm_device *dev,
 void amdgpu_ualink_revoke_exported_memory(struct amdgpu_bo *bo);
 
 int ualink_ip_hw_init(struct amdgpu_ip_block *ip_block);
+int ualink_ip_hw_fini(struct amdgpu_ip_block *ip_block);
 int ualink_ip_late_init(struct amdgpu_ip_block *ip_block);
 int ualink_ip_sw_init(struct amdgpu_ip_block *ip_block);
 int ualink_ip_sw_fini(struct amdgpu_ip_block *ip_block);
diff --git a/drivers/gpu/drm/amd/amdgpu/ualink_v1_0.c b/drivers/gpu/drm/amd/amdgpu/ualink_v1_0.c
index 58cf98ac94add..d440ed6b57336 100644
--- a/drivers/gpu/drm/amd/amdgpu/ualink_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ualink_v1_0.c
@@ -131,6 +131,7 @@ static const struct amd_ip_funcs ualink_v1_0_ip_funcs = {
 	.sw_init = ualink_v1_0_sw_init,
 	.sw_fini = ualink_ip_sw_fini,
 	.hw_init = ualink_ip_hw_init,
+	.hw_fini = ualink_ip_hw_fini,
 };
 
 const struct amdgpu_ip_block_version ualink_v1_0_ip_block = {
-- 
2.55.0

