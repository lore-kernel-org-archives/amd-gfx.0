Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A2BFC7EE30
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Mar 2023 01:10:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 767BC10E127;
	Thu,  2 Mar 2023 01:10:02 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C36E10E127
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Mar 2023 01:09:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jd8zjiRSfuPBBNSUrDkiBS+NMHWJpF1Kw5NN+MP//ZmO3FXzj394XaVZ+QhOKfOtOR1AJIHGy5Nv8QFWli1qLhsgC2aG/QQ73vItb997razgRGU4KuRhCqs3LJRFSfiiGdqWbMjuAxp6jdZ499G/v509dZVENmAJwyDK1U+GRfbp+/P8EC607c8X6pqVEvdxlFnZl/DGG/A+3xx4V75/z5G0ge3hIPUIokp1AQMHDpxz1glcP1UlvLbsJ6C6jKW3SDROSe2Ged91V34RrN0al6sFSx0kHMSBy99mptLd25nc3w99Gt/eh5kkhRSi+6rCNpfnB1XediXbCDMoMQoIfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/psfJAvsX2eiwbFJOSJUz+xgg8AtRyoVTn060xGCLY=;
 b=UzWorLE4cOY42a4u8yKV+PPPKiszQ5KUMcieDTAXNnMXDxpac4KKPRZco0bWSlx+RS69mocIw8vUdZSe9m+srpW+8UdXmjOwIFODc27ZuEc3t/Ol4AhBbGS5x0LKcGsxce95Zsi3dvv2+5hkLEZTVdyFUJEr8d2nC+cUiaYFEdRJjBvrp431sYF5Zyn9TOWDhMTvf+wRFStuM8zYzJ5/sN6RN1VpuTQiXbygTDIvmS22C9/PKjf2SFfq3NHxtCEoieYoTfgryturZfj/Er9U2nI1s7U8Thac2SEt2RAKmFqVbbCMXMUvvNvXOBEsTHZivmpMxr/bG7Es8HagIrlDoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/psfJAvsX2eiwbFJOSJUz+xgg8AtRyoVTn060xGCLY=;
 b=xqcHNfSLWSfp5ZlqPIVjGHVMgO5nbIV4IG+ce/LusF518gNd0ytbzArvFI3C/xROXU72aCEx925fTgtNLNjDI6xtaKC7hMcWp1adkTT94+jmfY5zKaafULCWE6jf/vJQQ3pamnDj+nw0NN6fOuRYz0yPSMhxD1ndISXKLRl0PdE=
Received: from BN9PR03CA0529.namprd03.prod.outlook.com (2603:10b6:408:131::24)
 by CY8PR12MB7660.namprd12.prod.outlook.com (2603:10b6:930:84::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Thu, 2 Mar
 2023 01:09:56 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::6e) by BN9PR03CA0529.outlook.office365.com
 (2603:10b6:408:131::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18 via Frontend
 Transport; Thu, 2 Mar 2023 01:09:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Thu, 2 Mar 2023 01:09:55 +0000
Received: from magnus.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Mar
 2023 19:09:54 -0600
From: Daniel Phillips <daniel.phillips@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] amdkfd: Memory availability can never be negative
Date: Wed, 1 Mar 2023 17:09:26 -0800
Message-ID: <20230302010926.51371-1-daniel.phillips@amd.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT058:EE_|CY8PR12MB7660:EE_
X-MS-Office365-Filtering-Correlation-Id: a922e4cf-6de4-4ed8-f5d3-08db1abad5fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r8Y9tbfCUqoBuURf+LhJwZhi+jNohGfxq3VafonaNYTsQRMRF1g0y96ER3iWBcshe+p46jvYkJIv+6X6q672nbAr6SWubdj6ycJpJR0ms5RqmJXEm2mcz36c907G6ruGKpqfye49NfAv/DYQPi6wBFBUxyIGBcbOd4j/wLFC3TMEURO0JyBPNy5XZrDURjSx2LI33FxjyTj2Pqx8JXQ9zpIR+d4DDrs6CXuSViSljpOKwHBPk0k8exqJKYrIFDuJmqLthjxxz2R1OAbqXJ4gc6JtxzHbnOd7my4eN29FDkEABs90CcPiRC5nhS+HzWb6eZQQL++fJ3Jy/kgpH9rCu8DbwAa4zfedhgQx1Xp/yooRog6cAorjU/SD4UXv3f28TFNib8SfzHk74gkAcfVHwiTwejkWMVMa+cPb+uXlgpUxv0kwWp350VHKpRK7vqbb8Em7RwkAZWyjOPhTLHv+1nPpXXZpRXnSgw058UIqaHsLXszI+2BSBQdKUhv7uN07h4VmaRVFNowITWF1MWjv+NIc6NiYp74n5d3PTmDm2MuJkojRA2xhTqJpDmtc9uMXeBUTk6MWZpu5MuO9YP1L3Krmc9LxoIOeAg3PtpjirobL1IFdKIIP/a54OMNW/6ClplQTQeE/z76mksfeet49A1PzYYjWS5B/ot9J/Bv1WZVgIAxB//5NVg//Rt+pVGc85FF4FFN7KZmkfnJF1/Fe3DlqqykF+66sNDgqhJ8SxFo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199018)(46966006)(40470700004)(36840700001)(36756003)(40460700003)(6666004)(336012)(1076003)(2616005)(16526019)(186003)(26005)(316002)(6916009)(54906003)(41300700001)(4326008)(70586007)(70206006)(44832011)(7696005)(2906002)(8676002)(5660300002)(478600001)(81166007)(82740400003)(8936002)(86362001)(40480700001)(82310400005)(356005)(36860700001)(83380400001)(47076005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 01:09:55.8040 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a922e4cf-6de4-4ed8-f5d3-08db1abad5fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7660
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
Cc: Daniel Phillips <daniel.phillips@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Our assumptions about how much KFD memory is currently available for
allocation may be violated by various complexities so we define the
reported value as advisory, however we should never report negative
availability.

Signed-off-by: Daniel Phillips <daniel.phillips@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 6f236ded5f12..ec74f0ad62a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1574,7 +1574,7 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev)
 {
 	uint64_t reserved_for_pt =
 		ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
-	size_t available;
+	ssize_t available;
 
 	spin_lock(&kfd_mem_limit.mem_limit_lock);
 	available = adev->gmc.real_vram_size
@@ -1583,6 +1583,9 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev)
 		- reserved_for_pt;
 	spin_unlock(&kfd_mem_limit.mem_limit_lock);
 
+	if (available < 0)
+		available = 0;
+
 	return ALIGN_DOWN(available, VRAM_AVAILABLITY_ALIGN);
 }
 
-- 
2.39.0

