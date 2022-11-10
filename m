Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4BF4C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Nov 2022 07:05:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DFBE10E05B;
	Thu, 10 Nov 2022 07:05:10 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5493410E05B
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Nov 2022 07:05:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcNgnSJ/vOQMXh10aAB9RyLtRkHo7MnhcS9j0DNGy0H3hZ9O82TNeLDMJZGMx2ZsZ4rKOmHCzt+B8kiXkwBvzYGu1HqmcIyZMLINlNGJ/nZ2eGhBL5guAROeFBuerAHk6zB9TtcwZtTFDqweamijpIACsnji7Zwwf762BKCuKVCJEcifySaQoi2phC+33om6wq17DhUNRUhBZYxe7k5IGGVLA0Tqs7KhhbMnQ2b34FToOiqOXI+c3VwGahgxnM8hb2WTdqN6J+d8ija1NRHqPJptbStaQybTNvCLxNvsjz2KpXvwNLq3eOBUUXMfejHmWDYe2Pk1/0gehib2mHGz9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZXwWrXRUqxKy8lRZ0PkLmdljeNdEHYUsU3krifyUvY=;
 b=g54A+MK5qJ27fnAf5Xv+DXsA3KsM4BaXa72SVkEAQb/2PegFm5Z3KBwYhl4NtQRgh2VkHo5cyi5K3hmC+J4odd84K6TizViVTOn26HPoecRefwqqQxOhkonyPVduj/dJPFbRq0DgD9mUmGWu+cnei01+/zf7J2BjVm0usEaHjdG0ID2MVpd1yuKX/nZ2Lf36Ngl73448js+yRiJO92ooixBT53K88bYZeXeABmKNVZi3Bl6d0PksOhwvf9DN+rSwFgrdcnLdpByUlnMmGSzO5r8eguhNscXqbnL8k+WicSDrNGziva1FQmrlrdtaVG3KvdCxd3EUodLlTiM7V6wI3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZXwWrXRUqxKy8lRZ0PkLmdljeNdEHYUsU3krifyUvY=;
 b=SWjmkNiyIYKuEMzEzVHPTlvMwXcT5J/tURNsW/F295A1NhY/sdjx+O84Vg+ZA6zCWY1Ul5QvlbtMA8qNTJcolmiki83H9jnVp4ZGmpicsuCxDYUYyArlCYbSThC5gQN3CTlfpE/7XWbWk68CDdpiFjCV3Q+MZhsp9bM/c4ounxM=
Received: from BN0PR07CA0028.namprd07.prod.outlook.com (2603:10b6:408:141::27)
 by DM6PR12MB4329.namprd12.prod.outlook.com (2603:10b6:5:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Thu, 10 Nov
 2022 07:05:03 +0000
Received: from BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::c3) by BN0PR07CA0028.outlook.office365.com
 (2603:10b6:408:141::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13 via Frontend
 Transport; Thu, 10 Nov 2022 07:05:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT075.mail.protection.outlook.com (10.13.176.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Thu, 10 Nov 2022 07:05:03 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 10 Nov
 2022 01:04:09 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <candice.li@amd.com>,
 <hawking.zhang@amd.com>, <yipeng.chai@amd.com>, <stanley.yang@amd.com>
Subject: [PATCH] drm/amdgpu: remove the check of init status in
 psp_ras_initialize
Date: Thu, 10 Nov 2022 15:04:00 +0800
Message-ID: <20221110070400.23347-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT075:EE_|DM6PR12MB4329:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f7c4669-b41e-4ada-e63e-08dac2e9e3e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vsOc01fuLV22R5qBnxM23LNpeG/KI3eVxgEOawcP4w9y03qEIVBMRIPXM9duXVo3bRdRrBJyuKhEiYnJ2dnx5LdftoBV6YmYbcsormNMpCjzBMQP1zXrONbn0V7oTD+4ZT/h6ZMaayUwRKYtzMYffKsUKTO6jb9krKU62BK065qCaYxOV0vmMmD+O3FP+koZ1B4epD6uEMQuGApRRgqAyThLlcHF91j9mnOmeB4hKV0R7HHvA/gyHQ5dqWjeM3I/Tt+8LW//62T8pKxBcd2fE+uJrHFC9HYoXPfqGCxVf5h3LSMX9BYa21QkPDRCQ6rRYEXgnRKFKkxSO13yDJeZpcZK1uNKTGh7WkN0CCK3im9tbwCI+H7Jnc34FUs9VO9ht+rJ+cPR9Y2CbVVR/VMpoAVlA109GJ6IVcdLrU69fXhnxBCp4LkfMNi4U7JGA3KZWOSUeBnYgoZRF3ck6V/csIj6iP+vTHH1dyh4s8ogpH+YrJXGzTygSZLlwkC/GVSUBaqNjmpFPY1yEUiqR1AvzCLkaZFdiODs9+rlMR+3oQuJHhw9cNCA3HU2dvBhBz3NzboXKwB2HMOXMXfmHt3mlciY3y9Zc+6qb9ID589WHx3NgKd/nMvccNILdaCGb/5NURPCefhR+aBgosM9shOazM3+g26EUB/BLUdUq9TFX8r72UvfGdFEAIM3ZNA+FSvHEu+M/DnlDpUnQlmvPE5XKxF1dx8pQ/pqHMCkhcXHZVdWsXXFvYJzot2kFBCRXma/bK2KnqKOwTNDE+vwNmmmodyubpMqkqhsz3269nIqhkS+TlsvL1GShXAxQNZ2DxiB
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199015)(36840700001)(40470700004)(46966006)(6636002)(110136005)(82740400003)(316002)(40480700001)(36860700001)(47076005)(426003)(6666004)(36756003)(86362001)(2906002)(2616005)(40460700003)(5660300002)(1076003)(186003)(16526019)(336012)(8936002)(8676002)(7696005)(82310400005)(83380400001)(4326008)(41300700001)(70586007)(70206006)(26005)(356005)(81166007)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 07:05:03.1966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7c4669-b41e-4ada-e63e-08dac2e9e3e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4329
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The initialized status indicates RAS TA is loaded, but in some cases
(such as RAS fatal error) RAS TA could be destroyed although it's not
unloaded. Hence we load RAS TA unconditionally here.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 2fcb5bfbef89..0a8c30475dda 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1526,11 +1526,6 @@ int psp_ras_initialize(struct psp_context *psp)
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	if (psp->ras_context.context.initialized) {
-		dev_warn(adev->dev, "RAS WARN: TA has already been loaded\n");
-		return 0;
-	}
-
 	if (!adev->psp.ras_context.context.bin_desc.size_bytes ||
 	    !adev->psp.ras_context.context.bin_desc.start_addr) {
 		dev_info(adev->dev, "RAS: optional ras ta ucode is not available\n");
@@ -1602,6 +1597,9 @@ int psp_ras_initialize(struct psp_context *psp)
 	else {
 		if (ras_cmd->ras_status)
 			dev_warn(psp->adev->dev, "RAS Init Status: 0x%X\n", ras_cmd->ras_status);
+
+		/* fail to load RAS TA */
+		psp->ras_context.context.initialized = false;
 	}
 
 	return ret;
-- 
2.35.1

