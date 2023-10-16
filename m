Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D82ECDB482
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Oct 2023 14:49:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F1E110E1FB;
	Mon, 16 Oct 2023 14:49:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BC7610E1F5
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Oct 2023 14:49:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GEqKBI8lK36WybgSADLrDD9fL5elvBx5p0MWXxUHtOsvb1WmxXnmatt8gpCe3wRVkVKWaX+koQzkN6BEGrwRLf3W13LqzVMYRRpqDiigQH60he467WnIGSO+piKHTHOrrfQD/E1wjhb3hBrIxgXmfsxou9Kut4/FHMvwZzHP/itLuNMZta4yCVIE1ac2KfCBcpZc9Mqh84VMcGzG77+M+g6evMqLGhs+CB62WOLdSxp23f1LtVqBuB/zyF4oAIKj4HtaW+amDjuUEDWCKQlgMQai0D0STiOTDFENpVJhFKiLucUcpdVBKAQGzRi0aK7J4mofDp0QgvjKxWKjBaymuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORiUfzyXGlBjWcXBLTzdYbgcHeiZl5TtyFCQfK1FbFk=;
 b=CGOesSZR5Wq9gxjZV8yth2HZK+laksfUfIhiIujCHOe1Ljt7xRN1cwPUaYLUkGv9jyGNH3kOoJyg9v6vi4+WXPlP1tj/nzWVtvX3Klmu1KJ9h3LQlr0CgWcDmYbd9HANoCTwARBZ3Us15fzTnrGA1aIFEiGeKRPoI1qAVBKvHZxC8Ml8cFVpOi+1X0E6kl+v1Hl9C2OCKGQfi+9siCRyS2dE/1zoWW/pOLyN7hGrX2UGroGEFOkW17ij0/HMyKjBjBwFudz88gg/lO+sR5vH4eLZMfXN0C1WQmGuj6GMN8wfWe2Yhq6lzFhRb33xXDI4pG4wub+oxF/e84lp9T77qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORiUfzyXGlBjWcXBLTzdYbgcHeiZl5TtyFCQfK1FbFk=;
 b=ZEE/DhIfn2SYovP0Y8aMOIOou+8NinBzO54Ea6ssuvtTGt6jXi8Ej3mSEa35w94OU5iKOAf4LH1vQowOqpFZzLQjUDMiOl9XAoX/LLN496UXUqXzkZmKj5l0pGtxYON4PcHJ0iAdHMPHoekny56LmRbQPs0hAGrFkkBy0wXhHYA=
Received: from CY5PR15CA0099.namprd15.prod.outlook.com (2603:10b6:930:7::9) by
 BY5PR12MB4243.namprd12.prod.outlook.com (2603:10b6:a03:20f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 16 Oct
 2023 14:49:49 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:7:cafe::6f) by CY5PR15CA0099.outlook.office365.com
 (2603:10b6:930:7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 14:49:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 14:49:48 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 09:49:46 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 2/2] drm/amdgpu: Permit PCIe transfer over links with XGMI
Date: Mon, 16 Oct 2023 10:49:29 -0400
Message-ID: <20231016144929.807268-2-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016144929.807268-1-David.Francis@amd.com>
References: <20231016144929.807268-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|BY5PR12MB4243:EE_
X-MS-Office365-Filtering-Correlation-Id: fb961e6b-266b-4287-a3ff-08dbce572592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jr77I+drLOCGMX8R59dYQS/4uk8JAu6kpfNe2SdQ4t5n5qIoPtlu5+QdE/iYTGGdn9EFLffizQdfXKpqjK47Pdzof37iFzFDsELLeApzzESCkf6mSXtyymRrMspeRHiXrrfpd2eOq8N3tES8OsIn8qOmg5jcn/SKD5+UAymqhZZ8/MKKX2bA7tudEwE169OcZ5U0Lg2E7d80L7+Xfa43vePCpTFTSjZy/9gTymlAEMPIFEczm6MsG0p9Jq8tN2rRypyCi2zXBZVEXaSOAsAqbCA4ADm/RcNhmyn0MRi/U5EhgbjpRHZzlMfFtiXkN2IaSrUVf41VKxnzqDx38wJm8veYXfLhB0pq09bbVIlAtG4aRqUvjHjdrelxUccXYGZGq2bjUDeZZLYeTEhQ6NU6UA54wr4r1zyX/FhbgKF9kECZ2U2XflZX7+oKGx45cggyA/JVk8ITrePdNHGKWUOxtzCx1FGuxKDGWfqGPRB3SqVLgmGz9AMJSzgaksl5mtw/MAtQ+oe9Al96c79j7V6vBmUt7JdmaGgKZfZ2+64rmqyQ3VFruZEr4HtExWrrC6aycbpVYINz5bYBCXlpteh15fiKNGabAW8psmF3pUEsg3MtWWVwaerA040c+y41K+dYux0nsJx0vxbgNK0a/qeVSjlT4uvsbt1Hw9TDho9voz5c9dJhWjoLGk/bI2zUV268K5ocdEL3pCK0Jq8Gf38/xFSeVGtiGEQxPS+rCobAbrf3PZBsIF/cT2r9JQRJJbWPc0ZVGum/FoH9NoR44EXjTw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(82310400011)(451199024)(1800799009)(64100799003)(186009)(36840700001)(46966006)(40470700004)(8676002)(40460700003)(2616005)(26005)(1076003)(16526019)(426003)(336012)(5660300002)(6666004)(47076005)(8936002)(478600001)(83380400001)(4326008)(2906002)(70586007)(6916009)(70206006)(316002)(41300700001)(36756003)(82740400003)(86362001)(40480700001)(81166007)(356005)(7696005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 14:49:48.9494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb961e6b-266b-4287-a3ff-08dbce572592
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4243
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
Cc: David Francis <David.Francis@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When the CPU is XGMI connected, the PCIe links should
not be enumerated for topology purposes. However, PCIe
transfer should still be a valid option for remote
doorbells and MMIO mappings.

Move the XGMI connection check out of the shared helper
function amdgpu_device_is_peer_accessible and into the
topology path.

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c  | 6 ++++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index bad2b5577e96..b47cb7f8cfbd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5753,9 +5753,7 @@ bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
 		~*peer_adev->dev->dma_mask : ~((1ULL << 32) - 1);
 	resource_size_t aper_limit =
 		adev->gmc.aper_base + adev->gmc.aper_size - 1;
-	bool p2p_access =
-		!adev->gmc.xgmi.connected_to_cpu &&
-		!(pci_p2pdma_distance(adev->pdev, peer_adev->dev, false) < 0);
+	bool p2p_access = !(pci_p2pdma_distance(adev->pdev, peer_adev->dev, false) < 0);
 
 	return pcie_p2p && p2p_access && (adev->gmc.visible_vram_size &&
 		adev->gmc.real_vram_size == adev->gmc.visible_vram_size &&
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 4e530791507e..cb64c19482f3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1514,11 +1514,13 @@ static int kfd_dev_create_p2p_links(void)
 			goto next;
 
 		/* check if node(s) is/are peer accessible in one direction or bi-direction */
-		ret = kfd_add_peer_prop(new_dev, dev, i, k);
+		if (!new_dev->gpu->adev->gmc.xgmi.connected_to_cpu)
+			ret = kfd_add_peer_prop(new_dev, dev, i, k);
 		if (ret < 0)
 			goto out;
 
-		ret = kfd_add_peer_prop(dev, new_dev, k, i);
+		if (!dev->gpu->adev->gmc.xgmi.connected_to_cpu)
+			ret = kfd_add_peer_prop(dev, new_dev, k, i);
 		if (ret < 0)
 			goto out;
 next:
-- 
2.34.1

