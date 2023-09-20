Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC29C04ABA
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 17:46:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8084910E52E;
	Wed, 20 Sep 2023 17:46:39 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A931E10E52A
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 17:46:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HT3RXgSd65lgiKrpcV9aRU9+fdegioqKNSPIOOQoKMgTcuT2sR6U4BZMQKzCgfZuy7aWxLLTCZ9estEGFI3wP2ZIpfyNl4IZb7U4WV58OdxtqP8qnLBhgqPpYArSky108WhMHiNRDrx57Sc13rYk9KogjYaeMDG6j8cuzkUxTrkhwkSjHvrFG1OTkwVLAoGFrPSIFQ4DAsN/Ve9RBkQvfQrgWP93+g7+g7WXPzjWH3k23e863SO/+Tqoy9RG20UfbroNUefPwzr7G6ZvpLD84L5TORPa96a+3iM8ZeSxkMBDxX5Qvp8AP0bW3utBBsK8/J5KbNt0hrGqTfCo9F3D1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ws0mLkQALwhiphfOGv5LWUf3HtzdnPj+mKqsmWmVnTQ=;
 b=S1m0jr6rNziQShPSGjKqn5PjNeKPX1sI7t4bzyRYSiVsw/cb92FcC9Ue3oowYyL3QPNaC6T4YZT0uwdM7dfpHriwojqLxQQvYyBg4/FwGOFf4CAty1ObNR5pFOl5/i6MbNDbsNpH3RTTVLCOJZrJACfvNx6odGEN95WNSZ0HYbtw6nK9umo4AuqQ22szxqzUtRjgNH+WyQfMJZfbiRrpRXiAwkb5PPoo4JHnA1+5AWIZDgWWoXZ4KCe/RcoBksRJfHxXwaQ1yW9ytk3HaBhEJOHc/waFqKtroA92xqicRpLi6LMCATboO+AGg9ao77LPoR7OmV9YBpCDcCSxxXYNrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ws0mLkQALwhiphfOGv5LWUf3HtzdnPj+mKqsmWmVnTQ=;
 b=oCXaGbwYnfVmbgKN15TfPKl9vVzwYGn6/kMFqtteLCHNiCEzBWtJSeFTPw6AIPmXM437UsZdJ6ufc94uv1oC+2D8oU7n5NyMrYPJinU0vX1Bz880cltkvDwLJ4yE8u8VKa84K886k5WJGlsRhLRDAaeV9nDuwHvTGBYksricxTU=
Received: from DS7PR03CA0098.namprd03.prod.outlook.com (2603:10b6:5:3b7::13)
 by MN2PR12MB4390.namprd12.prod.outlook.com (2603:10b6:208:26e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 17:46:29 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::87) by DS7PR03CA0098.outlook.office365.com
 (2603:10b6:5:3b7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30 via Frontend
 Transport; Wed, 20 Sep 2023 17:46:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 17:46:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Sep
 2023 12:46:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu/gmc: add a flag to disable AGP
Date: Wed, 20 Sep 2023 13:46:05 -0400
Message-ID: <20230920174606.3086966-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920174606.3086966-1-alexander.deucher@amd.com>
References: <20230920174606.3086966-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|MN2PR12MB4390:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e0dd845-d008-4bc3-b81c-08dbba018519
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E96AK9uMps6zU9MffyqCJtGkOSwbJuN+BhLZCPXCCKEZTykpd+YO26RlxIJFIoohPthLOaL47qoEyBDDB4DQN7z8QsR3Y/Lzx9A3HXj/ByFNevA2H93ZtVyoPMA9VpRBhmdcJH6HtnbPlGfa1FZsaD87Cus43C7d33o+wwOSkVPW96Ox7I2Vzy2C54WL4lEf1jGsKuSVsWlQijsk53TQ4h6QuabQ+1+qKThqxikKs9QkWclrbiOwW5m0uHHfP32o5Bkfp8TblJ07KZ8d9+brwtryqQEkHPbemC3HZBJnl4ypGEvqvFlCOBGyZf6HwliAGdwxUeAFKRBk1JzkAN10VntqJhkamhS2mOH4nJyQcNr4FVjeSUHcMT39YU37a8KsKRHXDhIPGuW8vwuJ4PqQlMzTpBRd6RpZyQnGmsuuAuOP2AWe4Udy7KGU33K5uYgD5xXHO3rf1Td2fIMNEg2q/iYdC3eRKdoYs76G1dQUAxjO4cLB2lphI49Ceu57ZAb1FTFIMBDjyab3i7ym3NAO9bVlocDdCcOgoMuAP91Y4NP3mQYDq9eMyXVls8LK0Y+KdYgU1irQnKNalcTfbEkx4yS0I9hVyr5S3GIt4qqY/sBbtASGFNkJKv3A+rlECw7mjiLISEsS4D7ZLW4R+27NyrCiv03khBm39XaO1QkxMpvOZL4cTAsB09TDgsH/StAuM0z0DfyYX9x3l1hEiyuW1mzkR1MkuBIrLcuiJincIdws862/jfBGI9YuzEu9U9Yk+c7rjZ/JygqO3Fk7jTypvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(186009)(82310400011)(451199024)(1800799009)(36840700001)(40470700004)(46966006)(40480700001)(4326008)(40460700003)(81166007)(316002)(6916009)(70586007)(70206006)(478600001)(2906002)(86362001)(41300700001)(356005)(8676002)(8936002)(5660300002)(36860700001)(83380400001)(2616005)(6666004)(47076005)(7696005)(82740400003)(426003)(336012)(1076003)(26005)(16526019)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 17:46:29.3064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0dd845-d008-4bc3-b81c-08dbba018519
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4390
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

Allows the driver to disable the AGP aperture when
it's not needed.  Program AGP explictly for all asics,
but set the flag to align with previous behavior.  No
functional change.

v2: rework patch

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c           | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h           | 2 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c            | 2 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c            | 2 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c             | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c             | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c             | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c             | 3 ++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 9 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index c7793db6d098..fc1a585d05bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -315,7 +315,7 @@ void amdgpu_gmc_agp_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc)
 	const uint64_t sixteen_gb_mask = ~(sixteen_gb - 1);
 	u64 size_af, size_bf;
 
-	if (amdgpu_sriov_vf(adev)) {
+	if (mc->disable_agp) {
 		mc->agp_start = 0xffffffffffff;
 		mc->agp_end = 0x0;
 		mc->agp_size = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index fdc25cd559b6..d3b014b84fa9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -333,6 +333,8 @@ struct amdgpu_gmc {
 	u64 MC_VM_MX_L1_TLB_CNTL;
 
 	u64 noretry_flags;
+
+	bool disable_agp;
 };
 
 #define amdgpu_gmc_flush_gpu_tlb(adev, vmid, vmhub, type) ((adev)->gmc.gmc_funcs->flush_gpu_tlb((adev), (vmid), (vmhub), (type)))
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index e582073b57c8..1dc136055f46 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -842,6 +842,8 @@ static int gmc_v10_0_mc_init(struct amdgpu_device *adev)
 		adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
 	}
 
+	if (amdgpu_sriov_vf(adev))
+		adev->gmc.no_agp = true;
 	gmc_v10_0_vram_gtt_location(adev, &adev->gmc);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 69f65e9c4f93..976584ab84ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -741,6 +741,8 @@ static int gmc_v11_0_mc_init(struct amdgpu_device *adev)
 	else
 		adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
 
+	if (amdgpu_sriov_vf(adev))
+		adev->gmc.no_agp = true;
 	gmc_v11_0_vram_gtt_location(adev, &adev->gmc);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 07579fa26fa3..84ffa0cfedf9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -213,6 +213,7 @@ static void gmc_v6_0_vram_gtt_location(struct amdgpu_device *adev,
 
 	amdgpu_gmc_vram_location(adev, mc, base);
 	amdgpu_gmc_gart_location(adev, mc);
+	amdgpu_gmc_agp_location(adev, mc);
 }
 
 static void gmc_v6_0_mc_program(struct amdgpu_device *adev)
@@ -253,8 +254,8 @@ static void gmc_v6_0_mc_program(struct amdgpu_device *adev)
 	WREG32(mmMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR,
 	       adev->mem_scratch.gpu_addr >> 12);
 	WREG32(mmMC_VM_AGP_BASE, 0);
-	WREG32(mmMC_VM_AGP_TOP, 0);
-	WREG32(mmMC_VM_AGP_BOT, 0x0FFFFFFF);
+	WREG32(mmMC_VM_AGP_TOP, adev->gmc.agp_end >> 22);
+	WREG32(mmMC_VM_AGP_BOT, adev->gmc.agp_start >> 22);
 
 	if (gmc_v6_0_wait_for_idle((void *)adev))
 		dev_warn(adev->dev, "Wait for MC idle timedout !\n");
@@ -339,6 +340,7 @@ static int gmc_v6_0_mc_init(struct amdgpu_device *adev)
 	}
 
 	adev->gmc.gart_size += adev->pm.smu_prv_buffer_size;
+	adev->gmc.no_agp = true;
 	gmc_v6_0_vram_gtt_location(adev, &adev->gmc);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index e77e5593e1ab..d9b7e6e100b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -241,6 +241,7 @@ static void gmc_v7_0_vram_gtt_location(struct amdgpu_device *adev,
 
 	amdgpu_gmc_vram_location(adev, mc, base);
 	amdgpu_gmc_gart_location(adev, mc);
+	amdgpu_gmc_agp_location(adev, mc);
 }
 
 /**
@@ -288,8 +289,8 @@ static void gmc_v7_0_mc_program(struct amdgpu_device *adev)
 	WREG32(mmMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR,
 	       adev->mem_scratch.gpu_addr >> 12);
 	WREG32(mmMC_VM_AGP_BASE, 0);
-	WREG32(mmMC_VM_AGP_TOP, 0);
-	WREG32(mmMC_VM_AGP_BOT, 0x0FFFFFFF);
+	WREG32(mmMC_VM_AGP_TOP, adev->gmc.agp_end >> 22);
+	WREG32(mmMC_VM_AGP_BOT, adev->gmc.agp_start >> 22);
 	if (gmc_v7_0_wait_for_idle((void *)adev))
 		dev_warn(adev->dev, "Wait for MC idle timedout !\n");
 
@@ -406,6 +407,7 @@ static int gmc_v7_0_mc_init(struct amdgpu_device *adev)
 	}
 
 	adev->gmc.gart_size += adev->pm.smu_prv_buffer_size;
+	adev->gmc.no_agp = true;
 	gmc_v7_0_vram_gtt_location(adev, &adev->gmc);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 6acf649469dd..961698dab718 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -415,6 +415,7 @@ static void gmc_v8_0_vram_gtt_location(struct amdgpu_device *adev,
 
 	amdgpu_gmc_vram_location(adev, mc, base);
 	amdgpu_gmc_gart_location(adev, mc);
+	amdgpu_gmc_agp_location(adev, mc);
 }
 
 /**
@@ -473,8 +474,8 @@ static void gmc_v8_0_mc_program(struct amdgpu_device *adev)
 	}
 
 	WREG32(mmMC_VM_AGP_BASE, 0);
-	WREG32(mmMC_VM_AGP_TOP, 0);
-	WREG32(mmMC_VM_AGP_BOT, 0x0FFFFFFF);
+	WREG32(mmMC_VM_AGP_TOP, adev->gmc.agp_end >> 22);
+	WREG32(mmMC_VM_AGP_BOT, adev->gmc.agp_start >> 22);
 	if (gmc_v8_0_wait_for_idle((void *)adev))
 		dev_warn(adev->dev, "Wait for MC idle timedout !\n");
 
@@ -596,6 +597,7 @@ static int gmc_v8_0_mc_init(struct amdgpu_device *adev)
 	}
 
 	adev->gmc.gart_size += adev->pm.smu_prv_buffer_size;
+	adev->gmc.no_agp = true;
 	gmc_v8_0_vram_gtt_location(adev, &adev->gmc);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 2936a0fb7527..920570f25e99 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1788,7 +1788,8 @@ static int gmc_v9_0_mc_init(struct amdgpu_device *adev)
 	}
 
 	adev->gmc.gart_size += adev->pm.smu_prv_buffer_size;
-
+	if (amdgpu_sriov_vf(adev))
+		adev->gmc.no_agp = true;
 	gmc_v9_0_vram_gtt_location(adev, &adev->gmc);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2e4a8bdbf50e..c2cb4b4cd2d7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1255,7 +1255,7 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
 	agp_top = adev->gmc.agp_end >> 24;
 
 	/* AGP aperture is disabled */
-	if (agp_bot == agp_top) {
+	if (agp_bot > agp_top) {
 		logical_addr_low = adev->gmc.fb_start >> 18;
 		if (adev->apu_flags & AMD_APU_IS_RAVEN2)
 			/*
-- 
2.41.0

