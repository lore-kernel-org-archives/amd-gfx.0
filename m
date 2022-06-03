Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8BFAC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 10:52:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3148410FCAF;
	Fri,  3 Jun 2022 10:52:17 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B999B10FBE8
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 10:52:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOVJRYuwagBhlm14t+Al1Bh85n8ohA66ApmxBfaPz9kqPiwOq+9NzGHWqSOezbUartCFLTOoyKYUta14nOrBK6Ux/6BcIBkq2V/UDxbdRaT2o0HwVLC3Aau18p75QOa3NH41F5ZdQTFQ3KEs3pWowIoOUOrD2pLrcxwks5/maRi2aE1ktJYI2NHUWmiUO4qDB+BiamQ1tbwVZ5aBtPQV2FkdC6wJrgs4Mbt/NjIT89kGoRn6ioP2v9j/DPg/p/p6TgbC6rXQ13zHfmTFcGKUaYVi4A/AwXOUQd9KT3hxft80PW8qNofQoFJNBoYn1QrnEzxPzoyxYvDfOTDlgW1sqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZzJRLlPpckz90bMYLuU4i15M31p+B/LwhGYe3UywIo=;
 b=BcyPs92s+kmtPrdl5Nv7Gn2ankVBs7pfgqkJfcB6EJSxehx5RNF/wWZgnWDGSUKBx6ERitPK3j9a91fj4RBn2dy6OoyvxvsE935C8CSTkgxPnhLh2KHRFyzdYWFa1wc4yjAL9XuGUajiR9qtqGJMTC5o9BGep5ynqxCL2ejA2ZhCTdFX8FUujbo2EXNpf7GGDqmMJLd5wLBUouP1PeadcbYR+h2TrWnz+APB15gnlvyJgFs8UAmVAtqeoRB/f/H2XbBiwunqfLewj5IYOGZzR4fInDRrc6CgyUfuw+nzBO8SbVBMMLVUIHX7fnNLPAv0AhTg0QE1G+pz55oTUsEpkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZzJRLlPpckz90bMYLuU4i15M31p+B/LwhGYe3UywIo=;
 b=kcROb/f/Af7LiEi78NsKGlrjDLaKUPCL4bZoZoZMynwJvkQ6UBgl2j101Ir8gPZZ5n4Lsx0+euUISC+Vtkom8GrnszyoGcZE7WuS7UlfcYPTN4rErLP+/82vkki5RaczpuOdYSAuwEMGbkSecKDMh1UXuIGJQ61nxHUNRgpjaVU=
Received: from CO1PR15CA0047.namprd15.prod.outlook.com (2603:10b6:101:1f::15)
 by CH0PR12MB5386.namprd12.prod.outlook.com (2603:10b6:610:d5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 3 Jun
 2022 10:52:13 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:1f:cafe::a) by CO1PR15CA0047.outlook.office365.com
 (2603:10b6:101:1f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.16 via Frontend
 Transport; Fri, 3 Jun 2022 10:52:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Fri, 3 Jun 2022 10:52:13 +0000
Received: from RErrabolDevMach.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 3 Jun
 2022 05:52:12 -0500
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdkfd: Define config HSA_AMD_P2P to support
 peer-to-peer
Date: Fri, 3 Jun 2022 05:52:03 -0500
Message-ID: <20220603105203.3353654-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c59e4beb-c7d2-4b80-1a0f-08da454f1df2
X-MS-TrafficTypeDiagnostic: CH0PR12MB5386:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5386E4C55D097B1578DB7DE4E3A19@CH0PR12MB5386.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: irFPNzCwSZad/P71mGcVjeBtJtH/YtLu2WpvccdHqVIzuhn7N4dXbh4RIm/06n+REEcLMaQenBF+IFMR2wswKgVnPh9PB5nhdUxNEj1jndoOEubDesSZjyvcrrlbSzQxWavj2yi4Ce5E/rbwKCCqybX+yPARCiZIeZjszGmgTYSk6Ymm2yx9V+U+SuB6orpjXJoV1I5HdhGTXye68hH4cjHHzYHtGZvppAEuDJyZ05wzf81apQd+fict5lWTTQvEPV0kcqrX+eLA/iOuw4rKMZclIeKs/Qntn0pOQWjj+vquJ26ez3aWIIE6SeOn+8bXvVxeDohjgW1PEjv9hee4h/JCAE/bt+6mtmrGyMXmzHXxXiOWqrbGYqyCL+n6OdEPUI4SLBMA5Bl33lbBy4pnCO8PIfzA+AEveOpItSZhx3ybAboROA8ESe2aSQZSV8Ut3vbkuJUbgdq4N8jsQaH3fvnhKRPPypcHOxRF9+C0Zn4lIxVc8LUERfv+40PuzGMaG1IURb7tkw/T9rOXTWeVmae4g6a0vL5wv+T/EmGqoVQc+xJul1x+adqdJbTZd8O7aOvNDnz4gr2c1b81Hch9xVRT7g52A6RaX/T2+MNzq0qlN9mV5fQfw+RiipoM25eefGLkoHa5CO4lu2rnUeMUjYKa+oKSj6TayiLnqBmovlBblTJ4SeGb4fnSjMh+2BnqPmnWRBAys+KkRaujHaKUXw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(86362001)(83380400001)(426003)(47076005)(336012)(36860700001)(8936002)(508600001)(81166007)(1076003)(7696005)(26005)(40460700003)(5660300002)(82310400005)(16526019)(2616005)(6666004)(2906002)(186003)(356005)(6916009)(36756003)(316002)(4326008)(8676002)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 10:52:13.1610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c59e4beb-c7d2-4b80-1a0f-08da454f1df2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5386
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
Cc: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Extend current kernel config requirements of amdgpu by adding config
HSA_AMD_P2P. Enabling HSA_AMD_P2P is REQUIRED to support peer-to-peer
communication between AMD GPU devices over PCIe bus

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/Kconfig | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/Kconfig b/drivers/gpu/drm/amd/amdkfd/Kconfig
index 8cc0a76ddf9f..93bd4eda0d94 100644
--- a/drivers/gpu/drm/amd/amdkfd/Kconfig
+++ b/drivers/gpu/drm/amd/amdkfd/Kconfig
@@ -25,3 +25,17 @@ config HSA_AMD_SVM
 	  preemptions and one based on page faults. To enable page fault
 	  based memory management on most GFXv9 GPUs, set the module
 	  parameter amdgpu.noretry=0.
+
+config HSA_AMD_P2P
+	bool "HSA kernel driver support for peer-to-peer for AMD GPU devices"
+	depends on HSA_AMD && PCI_P2PDMA && DMABUF_MOVE_NOTIFY
+	help
+	  Enable peer-to-peer (P2P) communication between AMD GPUs over
+	  the PCIe bus. This can improve performance of multi-GPU compute
+	  applications and libraries by enabling GPUs to access data directly
+	  in peer GPUs' memory without intermediate copies in system memory.
+
+	  This P2P feature is only enabled on compatible chipsets, and between
+	  GPUs with large memory BARs that expose the entire VRAM in PCIe bus
+	  address space within the physical address limits of the GPUs.
+
-- 
2.35.1

