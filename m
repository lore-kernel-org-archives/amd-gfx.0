Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8B3C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Apr 2022 18:27:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2AB110F093;
	Tue, 26 Apr 2022 18:27:47 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8F2610EF97
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Apr 2022 18:27:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0H634WMIZHWjM6bk0w3u3P8NzyqmXsWwyq3nieAoboi3hQoC1q6QbsvSyicOX2GZ372TkSJKnPq4YNZlvdcYvK7dUHjNPSn5PKfKkhX9tCCvyeYthBkSNckXjKoaQ7nHeBcRIUN4zDSCbI7iNxXqBDcw7AAf5W1WHcsBOZv4eG8MFgn6nxQjB17XEcoppUfKWTgHjnCUwEikD+ScrCQd/guV6HW0rZLgayCmJPUg3Ojz7tqXhw7a86y0ur0iMqLVnmATSr0AaxSPF4RFNEK3hiU2WPnCXVrQo6R/jOsCEIDNWV5piNMhuIr6vm/eAtskJAqlKFlBHaeu+Xu9zU1hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHMDu/gpFw1YS/fgERh0ujPu0koX1QndNQ/tfuGq3xQ=;
 b=BtQuGU6z1MLvYklT+hD/72hByL3shnwLVZUDiBSFv8aO/GaqKri7vVNclUCiaYjCMT4KOSWyqilqI5DtjuynNxpsyx40aGJ5TGJlJX1x9raXfCz+V/ps3M5FRrThZNeGJvWpyDSUoKxnsIZC4ILcnvU8DV2UYQ2Yast4nBhkAsQdpc718CzgXaY38FCqg+nx4b7IbmGDDNhc9IdV4rBibWaSROqZBZaXrG3cUC42W4QX0glK0B42aUMHwZbmmggvg0D/gtcPV2ZQgZwpoBHfLUnfSulxzz9ukyMRlkb02Mxs6q7KXhkybfjJ21w5JU+rrLqjqiL7P9suqyCRlPRDIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHMDu/gpFw1YS/fgERh0ujPu0koX1QndNQ/tfuGq3xQ=;
 b=cCece2iKrRx1Fq/kfuOP8TTJqCRn6IVFh04ef1UININl9uA3IG8hYv4B9uYP4b481A9E5z4VP2oTJDBbfrlGx4je8X4bm1SG8pcmktgZ3e2X+OFpLtrR5mUgI6fC1Bue4A1rMALmedN5NzvSkIe51CdfWcHRF2LYHJa81YLR6Hg=
Received: from BN9PR03CA0750.namprd03.prod.outlook.com (2603:10b6:408:110::35)
 by DM5PR1201MB2504.namprd12.prod.outlook.com (2603:10b6:3:e3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Tue, 26 Apr
 2022 18:27:42 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::2f) by BN9PR03CA0750.outlook.office365.com
 (2603:10b6:408:110::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Tue, 26 Apr 2022 18:27:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Tue, 26 Apr 2022 18:27:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 13:27:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/11] drm/amdgpu: store the mall size in the gmc structure
Date: Tue, 26 Apr 2022 14:27:21 -0400
Message-ID: <20220426182728.3006737-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220426182728.3006737-1-alexander.deucher@amd.com>
References: <20220426182728.3006737-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9089f4d1-26b5-4571-b8ec-08da27b273da
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2504:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2504FA71B064D56D43964113F7FB9@DM5PR1201MB2504.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NOM1821JFsK3pZBc97Ns72DO7GcanQPGOeBCXGJ0nP9mk9VPm+/+24Ry/rgcqIDZb16ncFvP4znMOdhYtIb12s0ey6gMDLsgy+Pd8Zwc8ZwW4Ld05Z26zaeUcFFE591w+b7J8Atmz6axbcltYTfIPtgdRq+N1Wr/xkYxvDF1YZxkJ75DbHC86QFEnnOWVXOt61E6POyE2cO2qdNa9Mhm3TFpa0IlibZh68oJUTz/IjtB3ccaqEKqlHYYEeY2PhaynhRie8Ajld54rhl1ZIOB1mbTBHVC/0dj4LlPmTxeG6QSdetjnrXa24mWxe5yupUFSaM4IQ8V7rLyTVD5RGIRGeaatwQQ0g4tfvgmms+8e0AdyJfPb+Xg/3rEq29vb78ADgpd3efdBiusfkHADso/8LBLMcmiPcByTjDcpDbFMU2mJhtXLUyyEdRqpGITZSXOs8L8YoR3Q4YOFLULcq7LQLwiiLj7S4V+JxolabTjJ52NARF7ZMGzJaiLwVQCZEFUnrmcDgekXDtuRFNcHg1eL/XcpVThZhLM0ZoiDGjZgSwpNSCN/sgQWYrb5snqN7ktAcguCVUfdH8COXT8vrgpxpTltsh7m08GH4aYM8Crw4Vhm5jXqFfFMeGcQOFj3Rc64+QtEgNTJ5fxYIPjxkMHH2s1CfPBabrVVGRsFRjdFojYSFnUuNXBZ95uQkKNnSjh9n4ZuyIIPfBLrM3jU9AnIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2616005)(1076003)(426003)(336012)(186003)(16526019)(47076005)(5660300002)(36756003)(36860700001)(7696005)(6666004)(82310400005)(26005)(6916009)(316002)(70206006)(8676002)(356005)(4326008)(8936002)(2906002)(508600001)(40460700003)(86362001)(81166007)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 18:27:42.7097 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9089f4d1-26b5-4571-b8ec-08da27b273da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2504
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This will be useful in future patches.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  3 +++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 032b0313f277..67e488cdc816 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -257,6 +257,9 @@ struct amdgpu_gmc {
 	struct amdgpu_bo		*pdb0_bo;
 	/* CPU kmapped address of pdb0*/
 	void				*ptr_pdb0;
+
+	/* MALL size */
+	u64 mall_size;
 };
 
 #define amdgpu_gmc_flush_gpu_tlb(adev, vmid, vmhub, type) ((adev)->gmc.gmc_funcs->flush_gpu_tlb((adev), (vmid), (vmhub), (type)))
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 20946bc7fc93..487c33937a87 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -883,6 +883,24 @@ static int gmc_v10_0_sw_init(void *handle)
 		adev->gmc.vram_vendor = vram_vendor;
 	}
 
+	switch (adev->ip_versions[GC_HWIP][0]) {
+	case IP_VERSION(10, 3, 0):
+		adev->gmc.mall_size = 128 * 1024 * 1024;
+		break;
+	case IP_VERSION(10, 3, 2):
+		adev->gmc.mall_size = 96 * 1024 * 1024;
+		break;
+	case IP_VERSION(10, 3, 4):
+		adev->gmc.mall_size = 32 * 1024 * 1024;
+		break;
+	case IP_VERSION(10, 3, 5):
+		adev->gmc.mall_size = 16 * 1024 * 1024;
+		break;
+	default:
+		adev->gmc.mall_size = 0;
+		break;
+	}
+
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(10, 1, 10):
 	case IP_VERSION(10, 1, 1):
-- 
2.35.1

