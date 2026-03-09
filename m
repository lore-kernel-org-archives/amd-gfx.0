Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8749F417F1
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2026 14:56:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43C8B10E51D;
	Mon,  9 Mar 2026 14:56:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mXm2AtpX";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011059.outbound.protection.outlook.com [52.101.62.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76CC810E51C
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2026 14:56:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xU94YyLwPaCumIDbNiBcGcrqbs912gLPs5d2QxgnC0PXLff8Y7zeg61bFWEP9pNvy0vowsfJrWX4qZcr6SgCpdSFCHQ0KPHFoYrbTyf8+sajVp5ii8yDlj5lKqlSEPMMdh29wJkCJ5ekiKn0jofD/KLqLqv+IUMuQN8DAtWuDduiOa9U0azSP3K3wQ+fnFSYe4sABCaZq3C4TtVInnm0N48AAogfu0RxNFqNcGLbcEWoAZIPqxSpomKqUxipe6zora5doMDOQN9bNEtSZxXm0ITdVwZbSnQBhgGe8osBAi6eCZ3febsoAqEFV5mwBeFkcFR+l9KTQo72K4V9T5wfIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgjXAqgXa3It+cqfitdOX6gqFHSy5Rp9bJPtBdJYxNs=;
 b=fyW7PW6AYAYfER5J0Iyn5xMUXsYDBDuD+eAOP316siS66fV7gMP7oUxz/IdtYY5AePr5rRAuMT9F7Pw30MxH8NxdQ22FRZUHqUPeE7sV47Tgl2kynHPSXwhMuBXuxxr2yGbzqRRNOynVaZcaALFEHDRguns1tFsOQxF07glQ+Wc3sRpfL8PjVysZjKegLJ+PAlamICCl7vGOJcTGM3PlEyiWcXnjjjNHK37gPWD9A706LVDdtzf/rZTIjjpL/h0T9arSogOhj0xEKcPIZY7fdsKydGd4JdxKo5mCmUyVsbxKxlOSSr05n9MVC1cxZ1b0boZAv0mlChZnxODOgEhTWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgjXAqgXa3It+cqfitdOX6gqFHSy5Rp9bJPtBdJYxNs=;
 b=mXm2AtpXHBR6m1wu48zIm9TQEzutxE5e0ui4KQYQ+t1ktwPqlw1gF+4yONqFF/yY9KshGFR4TFMKmdk+4pfPLQTRRzzQhtpLkb9Je471BuQNQ1tQI8hP+vWqnb6yd2XCZasatXPD01CRMbcC0VQXa9H2TPozp3+LLDPXydN54Jk=
Received: from SJ0PR03CA0200.namprd03.prod.outlook.com (2603:10b6:a03:2ef::25)
 by DM4PR12MB6303.namprd12.prod.outlook.com (2603:10b6:8:a3::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.11; Mon, 9 Mar 2026 14:56:47 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::91) by SJ0PR03CA0200.outlook.office365.com
 (2603:10b6:a03:2ef::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Mon,
 9 Mar 2026 14:56:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 14:56:46 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 9 Mar
 2026 09:56:46 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Mar
 2026 09:56:46 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 9 Mar 2026 09:56:45 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Le Ma <le.ma@amd.com>, Feifei Xu
 <Feifei.Xu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/gmc12: Update gmc aperture base for A + A
Date: Mon, 9 Mar 2026 10:56:20 -0400
Message-ID: <20260309145629.2844495-10-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|DM4PR12MB6303:EE_
X-MS-Office365-Filtering-Correlation-Id: 946ae7c9-83d3-46d1-6dcd-08de7dec1614
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024; 
X-Microsoft-Antispam-Message-Info: +7if7AQYkaCarMXb3r6G242ouKxDXkzxc3cIORpXbSc7crrnZTY2WqXxu16RRPkUB60BwIKqGSaF1w8vr5ZSkDpdDBDHTj9FaZa9QxM/os6Lu04M8YgI59txToQ6xEd2bc2ej2lyF2N3pkg5L1iRp63NOn/1yPfvKF9T828uFtP2RuJ4Ul+O3owfjICCZ5WNhwtZJlGNXh4E7GmEGahB6xWsMBMGaKgk1LIo/EUvMvXiQ6+S4nozWyb8KIETrXKeCi3L/qnpcTPqb02n5DVSuUOI6pmNiNLA7fg+KTABQX4+sJyxjaL6zBaBOi0bpFPOS9mYLn4SW7SMkJ7OzLDGAlCJlrPM80y168nva5URrKgObBviHGIy9+AUSsTN9jhcpy6e0xgB+qcZh8mlgRFcSQ3pUzBi8iAYoDkYDf4Adt2TGKNLYAzacQq+CeXjA3vpFzUZW8aSTka2mLdT3+veJnty+M0Qq26Udd82xQisYP1bzi1VUZef8MzMukl68P3keTI5X59eB4GpPM4HvmFcs55+sJDQgbGMdzlNCaTDAp9agUmop0in5auZH6pjtvRB+P5e3teO83KcHJ8GsMvbL7QlOeAjBNnZTInhyDNfjgg2hxh9t9zqN5g2/QYONzB8D0OkpNH8VP6FyfPwHmYPN0BZ7bpkpkym3gg4ZwgYX1c4GBY39VkBIQZdFMsZjPrLmPZn23DT3HpldlBSaPFmBQSy343KQ5WXZQNiyxms/Bgb5bE5EznrRs/6DNeOWITOXcZgABCKVP1wA8LjyVkrlA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xPsIXjpmSDHZM7GeO2PC7D6HUGUvROctE6Cn3vj/ChC3ssQlY6TlFEI/VH67vAEoNFxwGW5itwtsJlOimuNolnP/axkDEWBVK01L1P5+et1kndXAVtLObYFcyE25Fn0JULp+mphOf9rAkR9t4t50IdS8tH+X/4zu9rsJTVk0F1pb+zAANKc5Nhy1zb61XD7nVy3jNHi3+jm+HQxA4o7kAWe9u/xOwQJpevmaK/aFl8u0bAOr7CnasXRn5jyrUBClfp3DmNakxYy3B82QFO6fqX3GfgmFtQBrclZWHkBC5BzxTM2XNb0ElylOUvZUikbd/YoQQtSAqYFubzbXske0KqQJDigOC2ZplgY2HqelnAw7gRZP6JJaf0n7mCgB8OktrPdb8fxpKmT6el9J898LS60g/pjry6WrCKa0gdJk7hlKBWBBrKf4iymrgdwCCB5M
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 14:56:46.8260 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 946ae7c9-83d3-46d1-6dcd-08de7dec1614
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6303
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

Query mmhub MC_VM_FB_OFFSET, XGMI_LFB_CNTL|SIZE
registers to calculate gmc apeture base address
for A + A configuration

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 2bbd63ffe7105..ac0536be0f90c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -736,8 +736,12 @@ static int gmc_v12_0_mc_init(struct amdgpu_device *adev)
 	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
 
 #ifdef CONFIG_X86_64
-	if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) {
-		adev->gmc.aper_base = adev->mmhub.funcs->get_mc_fb_offset(adev);
+	if (((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) ||
+	    (adev->gmc.xgmi.connected_to_cpu)) {
+		adev->gmc.aper_base =
+			adev->mmhub.funcs->get_mc_fb_offset(adev) +
+			adev->gmc.xgmi.physical_node_id *
+			adev->gmc.xgmi.node_segment_size;
 		adev->gmc.aper_size = adev->gmc.real_vram_size;
 	}
 #endif
-- 
2.53.0

