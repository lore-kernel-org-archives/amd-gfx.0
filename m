Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB685C98302
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 15:13:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E0BE10E5EB;
	Wed, 23 Sep 2026 15:13:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YjbaRvnK";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010054.outbound.protection.outlook.com [52.101.61.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B73710E5EB
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 15:13:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yc1ZKW+rVjU2+k7gT4GFd0lnmMU061YBM5ce6lRymacrn+zDeRsCFRkR0+zv30qRYYkZmJqxCrmum3kDpQt0at0Nhwf8OIUll7MMaVob43RMKxNJN0X670tRd1zXLZY//vJauvvCg9odPesQISGe3W5o4w78Qjzsqy1IdD67dUvFtzwWDmIpXrLVQrHm+DWVJnGLrYHf5ARqkKplHwyXSvWenUCifbbkZ3cRsPEqacwW2BkMw221jMB3/bEMfYT/YTqkAmgJvWnRO8s2UCg0Oo4ieCYQFcSY94nMEKxQYe0m6Ys/WBHgA+wMeq7Nm9DiuC+G0WpmvATXmd4mkKNoaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yf0X5EGot2c5A/etm7LHTki7prnzqD5PCfIXayf3QQ=;
 b=pHtv2MrvfQQf36Y6hVhRDEn1PZod2ftXG1VaFPZ7cdGvRhQLZum+yoCBdmoI6oiupmqNF/vUF/FA8wk36Vv9k9RiChkLs4+pdssPdFcDVnvJ8OAajmTs4er1VAaeTxXaq/3a4xw6doRuXrVq2Z+evaQWv8CyP+MgSeQ+sZLRC7UqbAwEAaqnyYr9o0IWbL+qKhv201X4/vPlyHXRgD71w+jhI9UuN2bQ9eYZYBYqyJU2T4uYGO7hhyQeyJPijFktzihtm8spJJrilTMg9Ug646gM8MZLoBJBq5mXSDs+y8vH5jTCwcLNWZlbYlHus6FhxlOql9bvGVMXukDdy6mhag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yf0X5EGot2c5A/etm7LHTki7prnzqD5PCfIXayf3QQ=;
 b=YjbaRvnK5s9YHEUONgV9oU6+MwXixhx0OgXGQSnLV+ovmuMsRSDmZCJy24tTq1OG8U7AdCFj5PfNmgqgapLB3o7eand3Qc0xjF4NTjziv/g/oZUfDIvfWpfdneSHd1x79jBjsVIlyNmX4rEVQOVry8UL4eXPNZntMXpua3qMPik=
Received: from DS0PR17CA0024.namprd17.prod.outlook.com (2603:10b6:8:191::29)
 by IA1PR12MB6019.namprd12.prod.outlook.com (2603:10b6:208:3d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 15:13:09 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:8:191:cafe::3f) by DS0PR17CA0024.outlook.office365.com
 (2603:10b6:8:191::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Wed,
 23 Sep 2026 15:13:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 15:13:08 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 10:12:41 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 10:12:41 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 10:12:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lin Cao <lincao12@amd.com>, Frank Min <Frank.Min@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 11/12] drm/amdgpu: Add VPE FW list to PSP_15_0_3 under SRIOV
Date: Wed, 23 Sep 2026 11:12:25 -0400
Message-ID: <20260923151226.2778589-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923151226.2778589-1-alexander.deucher@amd.com>
References: <20260923151226.2778589-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|IA1PR12MB6019:EE_
X-MS-Office365-Filtering-Correlation-Id: ab1d7d41-d85f-49a6-354a-08df19852cb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: jh0q3jSg+lcxaswQ75l7D8792McQCpCp/twDI/DMNuSII92UpULYI4HD1zWT1W4kXLLnDKH/OUafdBnUvLO2ZLLaZc2eWBIuAVdsZiXwYeQ8IBXaNnzEM0W8j+cxWGLyeYFDR1iSIKhspxVnpTqHE8dL8I9BofINVPcaNzuix9TV4D1VhIJ8nYXJQlEphNyRBJK5b1ZVViPBwT4+3Z3Y++yBTQArwIXiruBKxhMsPddYKr0a+5NUm8ffQIZBKbmYlx1fqbcYTJ8CmTbCdkyC07mitik2aGs90jucCjapgtpKprEYlcCmw/8AxVhJlzwVrXbE7ju4G4AO3DnHX9jmPmbrw7ztmkKGFQn+kRS8CilyWQWMGMO7wliNx2G1YEwF/KIbvz7Z4dnB9Hdg4il5rmApiVIqsR9cIpZUZGlsc6x4JuyM9BCRU2UQI/ggklG4y7r1Dy8BZvEPjUdpdfWf0UJtXfQD8oqIdKaopG/2PiPF/J+sF1HvWKzJjgq7AZQdLU0gAUDEKOQgmRQuCms91ar1rFhjqna9fGPrWWZxS0WSvWQvsxRoYNyYPD3QJzQgM+GWwuMgJrgYBQGK+3bDYwMLYyVDwfrb7MbxKtcH7SRK1FjG+80r1jJNK5JwQcceMcQ3dyofKhgS0Zciz7q/LYPGTpz3bldHHQvrbw3wduYhs+XAMAKKVf8Rg7xoOlqwDZ2/rtSVQ85HYqOlI6cOSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LX+d8yddlHqjCsVLU5gIiPZnJNh8/8TW36RpILFm7hUvCV2fmlkqs+aOZqAnwpIrAokdgqIF9yeIW+RxMe/gxlob8UWnqhnUmHbK/vHglvGw4Odc17evpOGgwKtnwP9mwYUeyQ3RJc6NNdR2h5t9jpQL2yiPElBo1XNG9va9+VIzK1e6Yi0Yd0IsMm4KkhAeHL7SEHETBOWkuRNmCVvI9jWA0PCLfC0EQiALlC9IVNTbFiQ7E/ZqIc1Aq8w436f2UwHBci14HuBbDdh37Hh78RvdrvJNasNbSXHEArO5GPyidooL0142qw4dFCFDrNJ+f1AkPFymBz9mL7massbBZH0axOOq8HapX5AeSHUi4lc0qWthJScuiVTPaxLD9uUp7gOmgZQMLZEkNcYGRI5DbAxFWQVWKBt61BZW8H/+bPixfYisrxw9V0TpgaSiZUir
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:13:08.0593 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab1d7d41-d85f-49a6-354a-08df19852cb6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6019
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

From: Lin Cao <lincao12@amd.com>

Add VPE FW list including VPE_CTX and VPE_CTL

Signed-off-by: Lin Cao <lincao12@amd.com>
Reviewed-by: Frank Min <Frank.Min@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 8b08297e4a8a7..934fd3e821450 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1388,7 +1388,9 @@ bool amdgpu_virt_fw_load_skip_check(struct amdgpu_device *adev, uint32_t ucode_i
 			|| ucode_id == AMDGPU_UCODE_ID_CP_MES
 			|| ucode_id == AMDGPU_UCODE_ID_CP_MES_DATA
 			|| ucode_id == AMDGPU_UCODE_ID_CP_MES1
-			|| ucode_id == AMDGPU_UCODE_ID_CP_MES1_DATA)
+			|| ucode_id == AMDGPU_UCODE_ID_CP_MES1_DATA
+			|| ucode_id == AMDGPU_UCODE_ID_VPE_CTX
+			|| ucode_id == AMDGPU_UCODE_ID_VPE_CTL)
 			return false;
 		else
 			return true;
-- 
2.55.0

