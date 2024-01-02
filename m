Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 894AAC46CD2
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 03:44:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31CAF10E108;
	Tue,  2 Jan 2024 03:44:19 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30A7E10E108
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 03:44:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9ZxoHjhSX0ctYTDNbgWgutSU8SdtpT7yUkUYhTARGt5fj+N3GhvcCd6IbP9CLbhlhLI//DDSMFQS7N0tmJxF3aR/BbgTD2iCBeupLfIIxFPtdsUEm6t3C76H/0NUtgF71/w/QCeUNzzkHXx5uDa8EaXK6zVF7n+yKrovtndoU4omesjisO4FSJS58tkYVDBxd461E+RuBfjMx3fpjUsHDA9O1ufkh03xZlywDV6bf6TVRaQmzhIVbM8RKKuQwbtvVfTd/gOJFZbhzsQO2aG4QGcdimuLc+1BGcTWw/TDc4z2+MmLaHj+nmQmPWmgInC4o/LitL51P2UmS6qx2yrYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUs2UUoXHy4CooRXIWMmkwA/v7OjewRUZC1lxrSk8bo=;
 b=E78C7VuwFE4J83g026UCuDwSlpzkvjPQnQg+mP0WlXgmIZpi6k1LnKAtiwmqAL6ylPCHVteAzY66kI9K8OWb4/5OctBcNvm01ZA/YL1xLpQjHvKwos/TkHIo9JG9XX+QbhvqDQHDXEx+tvqrWiBEpRyySsLSkhPJ9ISQDr665E20e8vDEsZIwRlY7gIAHlaTALvHac9wH3OQziynShs11HYjUmU2KV/EoEga2kH2MJeb2/iX/WUA+T8oNgC6pnVnZG1LfpURNXBiUj3AYhnrigY/jAImHHee/rc5OMmmCA8jMebUCbK0rHiZk+beVKMD0zzAEKPOockbA6vpUut1Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUs2UUoXHy4CooRXIWMmkwA/v7OjewRUZC1lxrSk8bo=;
 b=mYAotQ0/hZSomyQuWzTi2y3hHmBGCBcOJXYfjzT0ljBiP4xiA+KVAuD1s5X7OeISxQ5RR9pXnVuwrxW+qAz+yDrUhRo/gAo2f638wqHkQ2bQiDnqDS1TOaCk4eUWO9uJ6eab44S/c9zdyMfSZIQpnMEPOg09F8Th/9Y16DX2xak=
Received: from SA1P222CA0092.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::12)
 by PH7PR12MB8778.namprd12.prod.outlook.com (2603:10b6:510:26b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Tue, 2 Jan
 2024 03:44:13 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:35e:cafe::b2) by SA1P222CA0092.outlook.office365.com
 (2603:10b6:806:35e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25 via Frontend
 Transport; Tue, 2 Jan 2024 03:44:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Tue, 2 Jan 2024 03:44:13 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 1 Jan
 2024 21:44:12 -0600
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2507.34 via Frontend Transport; Mon, 1 Jan 2024 21:44:10 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Yang Wang <kevinyang.wang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>, Candice Li <Candice.Li@amd.com>
Subject: [PATCH 2/5] drm/amdgpu: Init pcie_index/data address as fallback
Date: Tue, 2 Jan 2024 11:43:38 +0800
Message-ID: <20240102034341.16321-3-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240102034341.16321-1-Hawking.Zhang@amd.com>
References: <20240102034341.16321-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|PH7PR12MB8778:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b183bfa-05fe-44fe-17b7-08dc0b451647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9L5kvbJqqJV6gZ4ZGPj5lK1sW4+nI/EszywYajnvR1Wnxa91yYO839H0yxiOsyZmaXKrbE6aXWKi6Niha6fnh3BsvH22aDRc4maXlXS+7+Lg1gJHiZxT9SLqeT53koIeoxIWukqW1asbBBwlC67wMGnUbFIOi4zx5sMFnMefSWwOslRhimipgzcbYH1gti31jC1LuI0L2g01ltp0jt/QSQNZWUsOZKRNXCMl4KD8zoWWyfj49XiMkzbCZyzSoMbIyeXuc4UOUTWof7ahLSkNS+aRx83kM6U2UGm41idN+5qi+LrFLDTugYMa99vho6BKsa5t5jg8LltZH/E6V/8nyZRMeyiKKlvKbIIkXPWQEqBGUt1LUloC5q6MklT87uvNzKyCsADLMfXCpZPjXWJ57/57CbMATRoj15KkUzs6nfJjlD0bSE9Y+4R6I9ODomn5nx0d1JVzh/CunfdiB9HZ5LZUcnJ+NO2Iv/RJFYg6/Q8WXQpQUR6UB4S+lLj1G8Jdrno7XG04ZcEuj4d+T7JIncujkLcgHI5RUZ6tWTO9vtx3F/njK79PGv+1A5zO1BPJ3JPDknNOrWDYRwOTzJaw0i2dBEW+wlIlsvh8UoBpoC/b6qJxUG+4zpz7RuZRK+TWEyjynqGApArHTLnv1KAWBC28B+fvGVf0K/N4YxBaM68KzgehwfDKDwQu7kW54QJ8t2lVs9fIXuT1ktB3Nvsrdl74J9iq9caoC8lnUeRu7V5q5yznKhrj7QHWMdeTYZKMtptthZcq4u+Da2A1SfNPJA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(186009)(1800799012)(82310400011)(451199024)(64100799003)(46966006)(40470700004)(36840700001)(7696005)(54906003)(6666004)(40480700001)(356005)(70586007)(110136005)(316002)(82740400003)(47076005)(70206006)(6636002)(478600001)(81166007)(40460700003)(8676002)(5660300002)(4326008)(8936002)(36756003)(36860700001)(86362001)(1076003)(426003)(2616005)(26005)(336012)(83380400001)(2906002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 03:44:13.3549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b183bfa-05fe-44fe-17b7-08dc0b451647
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8778
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To allow using this helper for indirect access when
nbio funcs is not available. For instance, in ip
discovery phase.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 001a35fa0f19..873419a5b9aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -781,12 +781,22 @@ u32 amdgpu_device_indirect_rreg_ext(struct amdgpu_device *adev,
 	void __iomem *pcie_index_hi_offset;
 	void __iomem *pcie_data_offset;
 
-	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
-	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
-	if ((reg_addr >> 32) && (adev->nbio.funcs->get_pcie_index_hi_offset))
-		pcie_index_hi = adev->nbio.funcs->get_pcie_index_hi_offset(adev);
-	else
+	if (unlikely(!adev->nbio.funcs)) {
+		pcie_index = (0x38 >> 2);
+		pcie_data = (0x3C >> 2);
+	} else {
+		pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
+		pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
+	}
+
+	if (reg_addr >> 32) {
+		if (unlikely(!adev->nbio.funcs))
+			pcie_index_hi = (0x44 >> 2);
+		else
+			pcie_index_hi = adev->nbio.funcs->get_pcie_index_hi_offset(adev);
+	} else {
 		pcie_index_hi = 0;
+	}
 
 	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
 	pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4;
-- 
2.17.1

