Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869F4C07545
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Oct 2023 19:21:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9164810E48F;
	Tue, 24 Oct 2023 19:21:06 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E8AE10E48F
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Oct 2023 19:21:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TctIVQ+GQEj5m3L5FYgMo1bpB3Ufdlr8qtfoBRf8Uy4uxVFqBbOopRitc5QS4AKcmsc8DHngdEnrcpvnqNDHJOqU8e8j0scdDBmxhU/8P8nLpFyGdSbphhqdT6JxgqxsxFdbHNg3GcK0lf3Ls0yZ6f7rsMDjiITL/k5CSDHcekszA7DOcEvTBVgvb3agC7EBaa6e9ADIK+wPHG23u+PgcEoRR6Zlnr0g04f/0YsDor+M29GB7tn6nB2X/qvQvy2V8KV1QdSL/rRnEWwOu5MsNjnRUFc9jNFSXTAGfG4+/ZOpWfYbur5x3tMmUfqa3DYK3dNqNcnTJ6qEoYZGD8q0ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1AkAIcuesa1vQb13ryWRGOk3V0GTb63oUFPNcZKkh0=;
 b=VpMwZbBnwfujbjbV/zybEyFVcw/3YdWP9e1JqiEORKiDrnj+ZoNdHQhVgzYmDLf7uBGKyg/owK/ADCVzVvAuiaW082BsKqOESHo+b1OhsfVcavIErYSuXWUULa6tjuknJglvk8BwUYz9ldsnB3VFd93Pnug7t1ULIBP/7TXxNoh9gB1Xnpb+wpXLiDhxesADJxzi4p64YSzfgHvNAcMFm7XlsIfg9Q/WkPzM/avIljw/opRha/+KCPf9BZW2ypHVocD0OpWHNl7QwNoj1ugeUgvK03u0zK1/akVypvYpHSVmBVGbBfR0OqFEN+d5U9U18ziolcdnR3pdklrQACL2qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1AkAIcuesa1vQb13ryWRGOk3V0GTb63oUFPNcZKkh0=;
 b=zOL96eH8qAKLGu+ldGf2vySeKrDM0yikCAacVxgvW1jUqy1KpPuRljhAgDcxydc4DioNP3qhGn4g++jvsGRGEmkgISFIrOwipV1b6cVgA3PfQxhfwWFY3OzhHJ1FJvVgkijVjnKuMaDn+FTwNxFV/OjOmb8dmJPES5uTAr22H6o=
Received: from MW4PR04CA0361.namprd04.prod.outlook.com (2603:10b6:303:81::6)
 by CH3PR12MB8482.namprd12.prod.outlook.com (2603:10b6:610:15b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Tue, 24 Oct
 2023 19:21:01 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:303:81:cafe::29) by MW4PR04CA0361.outlook.office365.com
 (2603:10b6:303:81::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Tue, 24 Oct 2023 19:21:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Tue, 24 Oct 2023 19:21:00 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 24 Oct
 2023 14:20:59 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 2/2] drm/amdgpu: Permit PCIe transfer over links with XGMI
Date: Tue, 24 Oct 2023 15:20:43 -0400
Message-ID: <20231024192043.400319-2-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024192043.400319-1-David.Francis@amd.com>
References: <20231024192043.400319-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|CH3PR12MB8482:EE_
X-MS-Office365-Filtering-Correlation-Id: 989ded76-a84b-4c96-cf65-08dbd4c65bb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wTer1W+K8oRZDu6lNlzJ9Fs5Nnicwj39CzvQT8FJVMOxAw0DdzdTxFV/PzR2KCuGHUfwJTVsUCnDS0DojKOcUsV4cur/LAFoIKmSml7k6eKxRC436wcaDXGu6q2AKpH1XaGYFRNMsQCcmnq7z61CiZjF0GJraYpPtlXNWAYbCPlP54VKp7l+utJW/bTBMvObSxsLLNZltgyg2jAsyWTubzEWsQtIaJpqWigrQA6TkAm97aj+OElIsXK2oDCjGMchB9/FVp1gvL3dPDSdFfG+wNdg1ZTMVLplZxBoRD9mAZ9/RbcrAc5g7Vm0l/o210oObgMkNhG8rvh3oUNJ5c40NbKzyyP00OS8Q9OYYg/wOW6yzzUxt74+1OdE5fklCj0n7WtpA1G/y3HWiqpjYzS/ROFOLopOMyQ46XgDnFNaJMkajVuBVZTonqwz/6TN7SA8G+7lciKLByafs+cHHjLdXFyeW+h04XJ0VC6U80sQqRW9IMfHKCgWCAWiqyAeDq3B4rLzogVWsNEORaMRBv6dCX1rSJ7/kfn5SVZcyaBrBl7JShWJ31QdjcwpneT/pswML2FrfdY1DPxMuuw1cIkqPd8zoURGjk+9VUhiltU/r4AlO2Qeuh4kadkkjcfggxLEx4uLv4/BrDkX9KXmQMmI9oQkGPcBpDyHeFpTPebtaSZFGliiSvApiHoBwy0k+oeOMpwmMWBeTIYEVxIvTKeWQ+EpdezU1nkZ4/kC+M0CTLUd9Jl+HSSqGGPbHL66KR8NZp0Kbb2RD86lSJxIc92tVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(451199024)(1800799009)(186009)(82310400011)(64100799003)(46966006)(36840700001)(40470700004)(6916009)(2906002)(40460700003)(5660300002)(4326008)(8676002)(36756003)(8936002)(40480700001)(41300700001)(70206006)(86362001)(478600001)(70586007)(316002)(7696005)(2616005)(26005)(1076003)(6666004)(426003)(16526019)(36860700001)(336012)(81166007)(47076005)(83380400001)(356005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 19:21:00.8683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 989ded76-a84b-4c96-cf65-08dbd4c65bb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8482
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
index 7ec32b44df05..a5c054f8a427 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5783,9 +5783,7 @@ bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
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

