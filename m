Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A81BC43217
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Dec 2022 16:23:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0716C10E631;
	Thu,  1 Dec 2022 16:23:29 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3B4210E631
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Dec 2022 16:23:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0CBvWJc/ZLCmY03AqcXsIFJybo6F9y/XaBmVQWWmRp71vq3RoH/D3ctuVVTiXljWtQ1vnh0rHjQEW/e4v4WySCHTjdJHzqRyKQl/I+VEmstnXPhjUwCvxYocTMZRWZ3gy6oxrq7j64X6xycseJl4aA4nyliWQbC7dAF52gt481Yv9tqA/dBl7oC4hx8dpIT2+nC/mDpk08HPoZaH38WaOllKPOx3+x8Zcg0cGKtAMUu08XrB7DcdruuV+qmxgL5nSo926+I4yiLeq/Y1Z5/9u4N2Hn1X9bHwsLwrFq80V+HmUfifwmBNsA94s5W0sScLtuRttboapTHr1msqqn+cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=neCBboD5dO7rLydivVVcfky8itG13UQWKYPDMh5Fnr8=;
 b=W69fr+crY6vipHpV9o2i2X64KBKNQRpvzThej4R8y0kh0ejFnnCEYCLV253YYBMwH0SZcFm+yVZAt/hi3AYwekKSabY1e4ebGox9RIzh9Bear3RFRQzi7bqxHjgFD5FT7xPgKSoeEMRqHIZW2lJBXY5syX/rm6nETRG1nno1aK12BjrDK3xXNKRNJ3/kNpCfaLWLHkmeKW/WTEgn7+GjagD9gbfopEut0uKaminqAw0TTYkd+6HWXlay+vw/xWEOaLVZE7QKo4c60H6i+h14a4TIvqmZi1cXGC9ClhMLmwNdiqDl1lBsDMuMXyWaE0gPjhBRPnuoGOGKqJirVMqX0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neCBboD5dO7rLydivVVcfky8itG13UQWKYPDMh5Fnr8=;
 b=OHHMBMYoPP3PVkNhSL/woJ0Rw+MZa9iyqiakvYVNlzSBRRlWmNflajjuQUYh3BHFAtmpVFE+8MewQXPr+PkjAaT3mGgM0nGuY1lb1AVLKQY1HhXSJ+oiiGHV2K+FQLcslBrGkjbZfJPqJLfeXc8agwdMJGMvmqWeLStXtiDPQSE=
Received: from MN2PR05CA0022.namprd05.prod.outlook.com (2603:10b6:208:c0::35)
 by DS0PR12MB6605.namprd12.prod.outlook.com (2603:10b6:8:d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 16:23:25 +0000
Received: from BL02EPF0000EE3D.namprd05.prod.outlook.com
 (2603:10b6:208:c0:cafe::8) by MN2PR05CA0022.outlook.office365.com
 (2603:10b6:208:c0::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8 via Frontend
 Transport; Thu, 1 Dec 2022 16:23:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000EE3D.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.8 via Frontend Transport; Thu, 1 Dec 2022 16:23:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Dec
 2022 10:23:24 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add GART, GPUVM, and GTT to glossary
Date: Thu, 1 Dec 2022 11:23:09 -0500
Message-ID: <20221201162309.3112713-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3D:EE_|DS0PR12MB6605:EE_
X-MS-Office365-Filtering-Correlation-Id: 049cf72e-f9b2-4086-9814-08dad3b85f42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gb+6vLbyHTpPiLbbTTXalmZqg0On/vueHxNBpauYDuOAs4ejfEEqzZmoAyqAPPc48p05G8EBQr/CObsUr2RWvWEEjC7bU73Jg+xDbJ6IHFvvcVt/uEalDtYor/QBUsu1G291YKZwh17RpHR1w4YvI8rHlCNOXzRlkaYdWLOCqkWuhS9dFbdcwxtKzWDYAvvuhONaCANFIvTt9ika8x3pBgfkFbYHbcoEvPdEltdVq4vnW4902qkRgn65v3Jhbjjv+Fg++LBP+gQePDllHERx8J60ZS9SZ23JlIGgkI0sHfei6p5EnS6mdDNPe/Tkz9663bj17hYHHrnEBWx9ithGbtwr5JIelWcXTiWkLzAcDTPwZ6vx7uOZxKRPUHC3l3pYAHaywjLSRey+se2BkVhbJnmJek36uMtqAsUCvPyW4Dht9sPMpNPtd0ObirLwdaglgM+ZDukoOe4iWT0aVPbWoGJ+ohHkNpKQhu7tH467a0b8FsrzPHXJ12aDtqXj/C95K8mPkgeMytt3JGT064h6+ejm6ZTVH/VE6XBXfYdOYlKKlXCgQyBhTiUJUCKMsh4S2lwPCerX2ELi7W3plH+hjXVeS14k7oDnnGApw4XYpe3vdOoMMWuIjjIhx0TvPl9eMhogwzqDB8YkU7tOg9kNuR9hGfyfhKsrnEUZb1+i2AS0mKivDi9GQRaUvUjAaNccgPZo0VT/UVfmVgwsYacU+89Gh5o7dtixuytsRkSoGrs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199015)(36840700001)(46966006)(40470700004)(83380400001)(8676002)(316002)(40460700003)(86362001)(4326008)(70586007)(70206006)(1076003)(47076005)(2616005)(54906003)(36756003)(356005)(16526019)(81166007)(6916009)(336012)(5660300002)(40480700001)(8936002)(426003)(82740400003)(41300700001)(2906002)(36860700001)(186003)(6666004)(478600001)(82310400005)(26005)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 16:23:25.1520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 049cf72e-f9b2-4086-9814-08dad3b85f42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6605
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
Cc: Alex Deucher <alexander.deucher@amd.com>, bellosilicio@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add definitions to clarify GPU virtual memory.

Suggested-by: Peter Maucher <bellosilicio@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 Documentation/gpu/amdgpu/amdgpu-glossary.rst | 21 ++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
index 326896e9800d..944ebcef1d28 100644
--- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
+++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
@@ -30,12 +30,33 @@ we have a dedicated glossary for Display Core at
     EOP
       End Of Pipe/Pipeline
 
+    GART
+      Graphics Address Remapping Table.  This is a GPUVM page table that maps
+      system resources (memory or MMIO space) into the GPU's address space so
+      the GPU can access them.  In the GPU kernel driver's virtual address
+      space is referred to as the GART for legacy reasons going back to AGP
+      and the early GPU remapping hardware.
+
     GC
       Graphics and Compute
 
     GMC
       Graphic Memory Controller
 
+    GPUVM
+      GPU Virtual Memory.  The GPU supports multiple virtual address spaces
+      that can be in flight at any given time.  These allow the GPU to remap
+      VRAM and system resources into GPU virtual address spaces for use by
+      the GPU kernel driver and applications using the GPU.  These provide
+      memory protection for different applications using the GPU.
+
+    GTT
+      Graphics Translation Tables.  This is a memory pool managed through TTM
+      which provides access to system resources (memory or MMIO space) for
+      use by the GPU. These addresses can be mapped into the GART GPUVM page
+      table for use by the kernel driver or into per process GPUVM page tables
+      for application usage.
+
     IH
       Interrupt Handler
 
-- 
2.38.1

