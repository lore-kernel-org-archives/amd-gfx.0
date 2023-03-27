Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68CF8C76195
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:36:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E11C110E728;
	Mon, 27 Mar 2023 19:36:47 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09A5010E724
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:36:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJI05f0OWoHSkRslOPH02wXAL06d/k3HYTFiSFX1yXB3sHyIhJf0rO0XQ4x7bV8ohbnTeAGZxNnkQQG8FWqHr4sYmmB21jgAkFFAMvTNf4hp6oyqcF2GhMIrdJ1mM464wjdlQ1kKjV4hPucX6jLZ7kF2fcoyQ2G69nID0RJ9k7BfhyZfNY1uLhFbU4Basyx0cxS/GttDds5un6Ao2bJZn/d0AmkHfTgosbRV870Ixxj6O/49nCcGHokgYH6KzDj0n7yKIPMda4xKszS9l+m/8JF5+DynO/L1bkmUfchyRF4YV/teP+UY4LEVnHt2bmmZrkV6YglotGz43kpFH35Ucw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrgfUJUUhLe7MqH+/rKDmfwNcaggmIEk9+zhUrqedJI=;
 b=R8EUCKc+PhvvXZvveCIT9HuH1EipruW1HTCNfxWT+gq1MwG2tnX4xdYVGG+BEXCyxAD2G0gC85ZMp3TJGB9mlY+xz9W+ibehXLueABzr4L9EBz7l+SeVs6NF/iV2SToGVdLNPSW9TIeZExaFPaXRe+Ac+AaL8tdKjjaaygAz+jcaVhyfDRq646fnrp733ynerFIaKCkTQvbqt0JRUAUPEjNjk7D+gE4WT2TMQ7fogcRQazySNOvxVYIQEBIRhSyMaW4AnoXlaw4WVHMI4ALqD7ul1BNVt0UW0McSJLqbH6m3l0a5x3b5mEAwVWO+3U/hSfOLYzU5iQ4BYuxRZUrYbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrgfUJUUhLe7MqH+/rKDmfwNcaggmIEk9+zhUrqedJI=;
 b=LMRcw9zNc0JuLJeKFg4zJbXNp7uQ5qLV5Q41/ZL/7//yKHs1i++4r9ZFo5t5IhoBZ+RuIeu3eM5FmlB1oCP3txDzTQdKaKNcZKKTBuH1dvvO2F0+N1gMi5cbeYqwaUAaTJ31Vxa5PR8lsz11alhUXpOiMoARd90XSRFouZDrMoU=
Received: from BL1PR13CA0377.namprd13.prod.outlook.com (2603:10b6:208:2c0::22)
 by DS0PR12MB8294.namprd12.prod.outlook.com (2603:10b6:8:f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 19:36:32 +0000
Received: from BL02EPF000100D2.namprd05.prod.outlook.com
 (2603:10b6:208:2c0:cafe::c4) by BL1PR13CA0377.outlook.office365.com
 (2603:10b6:208:2c0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.16 via Frontend
 Transport; Mon, 27 Mar 2023 19:36:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Mon, 27 Mar 2023 19:36:32 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 14:36:30 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/28] drm/amdgpu: introduce vmhub definition for
 multi-partition cases (v3)
Date: Mon, 27 Mar 2023 15:35:51 -0400
Message-ID: <20230327193602.7901-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327193602.7901-1-alexander.deucher@amd.com>
References: <20230327193602.7901-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D2:EE_|DS0PR12MB8294:EE_
X-MS-Office365-Filtering-Correlation-Id: 3689ff7e-9cd3-4fbf-71d3-08db2efa9184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: flOnUJy153WwTlpoUr9+tHqAqVsuPekm7wJtBqdjmvDyaIuipLJdC/63vui3wyVslEyrL1OiGJCxdwGYKaIZTSyiBKDrgnfXWflvp1vrtLi3db0KIvRkRREJaJde8JNgnYPvRUM9xOqpf7nZeSM1e2X/4/GakADlAOuMs8JDC6DT60OdmM0XSMNPM02ggnAZcMsqMXg6N+9hLmQKygTD7vYjUCmtQuVe7tk/gOuL4lhGci4HWLK4KASgC7JdMQz1xgMd27284Sv23qA/7+dD1Wxmmmfw7gycJox+3KM+4RfusDEGKJR/5cozydunEk9WGGHjobfC72SypNKajlKD3AUYrTQFoUZVuZoQR9OBpzbfCREp5Cqu4WKT4Q1A71XF6ZC1U/ysvGW8eH6jeDuklW7BcHt+k7EXZTZTO9VK//W1tbdRAmUWNt+o8d81xrOmCNR5ayNY0Uf/Z2Ut77Zv1Q8uagVlM1/zW6JvgIXOCES5Jd9mGPUTzSXU61FSeSQbgtfd70TvNHYxxEvCC3wTal5IlfWG2uMh3kUW4PT7mUGpzpbW4DbDvD4YIxTcutiUB7COzTFCEHcaRH+jbKgP/zU0sTc3jFTZ9WVkeEOWpB5f66sguSt5um2nvzDeEUUY6nmv4zL+LrZ8iag4E1Zbvj0o6alE/nCuifC6/CaaJqvriyh1J0U2hdrdY9ZVh/Hdl+/DVv9UQFNNmvpqEYF4t+tyETQJVkRutk5jHctf6BmeR4ZjYezuepkylH0zlsuw
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199021)(36840700001)(40470700004)(46966006)(356005)(40460700003)(40480700001)(36756003)(2906002)(66574015)(47076005)(426003)(83380400001)(2616005)(336012)(316002)(16526019)(5660300002)(6666004)(70206006)(36860700001)(54906003)(70586007)(7696005)(8936002)(30864003)(478600001)(8676002)(186003)(41300700001)(6916009)(82310400005)(81166007)(82740400003)(4326008)(1076003)(26005)(86362001)(21314003)(36900700001)(579004)(559001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:36:32.0666 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3689ff7e-9cd3-4fbf-71d3-08db2efa9184
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8294
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
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

v1: Each partition has its own gfxhub or mmhub. adjust
the num of MAX_VMHUBS and the GFXHUB/MMHUB layout (Le)

v2: re-design the AMDGPU_GFXHUB/AMDGPU_MMHUB layout (Le)

v3: apply the gfxhub/mmhub layout to new IPs (Hawking)

v4: fix up gmc11 (Alex)

v5: rebase (Alex)

Signed-off-by: Le Ma <le.ma@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     | 13 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     |  6 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     |  8 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      |  8 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    |  4 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c   | 10 +--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c   | 10 +--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c   | 10 +--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c   | 12 ++--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c   | 10 +--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c | 10 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     | 33 +++++----
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c     | 26 ++++----
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 78 +++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c     |  4 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c    | 10 +--
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c    | 10 +--
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c    | 10 +--
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c    | 10 +--
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c    | 10 +--
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c    | 10 +--
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c  | 10 +--
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c  | 10 +--
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c    | 10 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     | 10 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c   |  4 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c      |  4 +-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c      |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c      |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c      |  8 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c      |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c      |  2 +-
 47 files changed, 203 insertions(+), 203 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 2ce93b27131b..a7afe1fb8881 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -735,7 +735,7 @@ int amdgpu_amdkfd_flush_gpu_tlb_vmid(struct amdgpu_device *adev,
 		for (i = 0; i < adev->num_vmhubs; i++)
 			amdgpu_gmc_flush_gpu_tlb(adev, vmid, i, 0);
 	} else {
-		amdgpu_gmc_flush_gpu_tlb(adev, vmid, AMDGPU_GFXHUB_0, 0);
+		amdgpu_gmc_flush_gpu_tlb(adev, vmid, AMDGPU_GFXHUB(0), 0);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 465ad0b7cddb..dffa3d34a1c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -315,7 +315,7 @@ int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
 	ring->use_doorbell = true;
 	ring->doorbell_index = adev->doorbell_index.kiq;
 	ring->xcc_id = xcc_id;
-	ring->vm_hub = AMDGPU_GFXHUB_0;
+	ring->vm_hub = AMDGPU_GFXHUB(0);
 	if (xcc_id >= 1)
 		ring->doorbell_index = adev->doorbell_index.xcc1_kiq_start +
 					xcc_id - 1;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 5906763e6e0e..c6b2452e8258 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -639,7 +639,7 @@ void amdgpu_gmc_set_vm_fault_masks(struct amdgpu_device *adev, int hub_type,
 	for (i = 0; i < 16; i++) {
 		reg = hub->vm_context0_cntl + hub->ctx_distance * i;
 
-		tmp = (hub_type == AMDGPU_GFXHUB_0) ?
+		tmp = (hub_type == AMDGPU_GFXHUB(0)) ?
 			RREG32_SOC15_IP(GC, reg) :
 			RREG32_SOC15_IP(MMHUB, reg);
 
@@ -648,7 +648,7 @@ void amdgpu_gmc_set_vm_fault_masks(struct amdgpu_device *adev, int hub_type,
 		else
 			tmp &= ~hub->vm_cntx_cntl_vm_fault;
 
-		(hub_type == AMDGPU_GFXHUB_0) ?
+		(hub_type == AMDGPU_GFXHUB(0)) ?
 			WREG32_SOC15_IP(GC, reg, tmp) :
 			WREG32_SOC15_IP(MMHUB, reg, tmp);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index fa8f48a0fa84..492506446a06 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2371,12 +2371,12 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	case AMDGPU_VM_OP_RESERVE_VMID:
 		/* We only have requirement to reserve vmid from gfxhub */
 		r = amdgpu_vmid_alloc_reserved(adev, &fpriv->vm,
-					       AMDGPU_GFXHUB_0);
+					       AMDGPU_GFXHUB(0));
 		if (r)
 			return r;
 		break;
 	case AMDGPU_VM_OP_UNRESERVE_VMID:
-		amdgpu_vmid_free_reserved(adev, &fpriv->vm, AMDGPU_GFXHUB_0);
+		amdgpu_vmid_free_reserved(adev, &fpriv->vm, AMDGPU_GFXHUB(0));
 		break;
 	default:
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 8ae45a0896cd..8fa88bb43fdc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -111,11 +111,14 @@ struct amdgpu_mem_stats;
 /* Reserve 4MB VRAM for page tables */
 #define AMDGPU_VM_RESERVED_VRAM		(8ULL << 20)
 
-/* max number of VMHUB */
-#define AMDGPU_MAX_VMHUBS			3
-#define AMDGPU_GFXHUB_0				0
-#define AMDGPU_MMHUB_0				1
-#define AMDGPU_MMHUB_1				2
+/*
+ * max number of VMHUB
+ * layout: max 8 GFXHUB + 4 MMHUB0 + 1 MMHUB1
+ */
+#define AMDGPU_MAX_VMHUBS			13
+#define AMDGPU_GFXHUB(x)			(x)
+#define AMDGPU_MMHUB0(x)			(8 + x)
+#define AMDGPU_MMHUB1(x)			(8 + 4 + x)
 
 /* Reserve 2MB at top/bottom of address space for kernel use */
 #define AMDGPU_VA_RESERVED_SIZE			(2ULL << 20)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 8bd07ff59671..ce421e77f7c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4461,7 +4461,7 @@ static int gfx_v10_0_gfx_ring_init(struct amdgpu_device *adev, int ring_id,
 		ring->doorbell_index = adev->doorbell_index.gfx_ring0 << 1;
 	else
 		ring->doorbell_index = adev->doorbell_index.gfx_ring1 << 1;
-	ring->vm_hub = AMDGPU_GFXHUB_0;
+	ring->vm_hub = AMDGPU_GFXHUB(0);
 	sprintf(ring->name, "gfx_%d.%d.%d", ring->me, ring->pipe, ring->queue);
 
 	irq_type = AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP + ring->pipe;
@@ -4490,7 +4490,7 @@ static int gfx_v10_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 	ring->doorbell_index = (adev->doorbell_index.mec_ring0 + ring_id) << 1;
 	ring->eop_gpu_addr = adev->gfx.mec.hpd_eop_gpu_addr
 				+ (ring_id * GFX10_MEC_HPD_SIZE);
-	ring->vm_hub = AMDGPU_GFXHUB_0;
+	ring->vm_hub = AMDGPU_GFXHUB(0);
 	sprintf(ring->name, "comp_%d.%d.%d", ring->me, ring->pipe, ring->queue);
 
 	irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
@@ -4978,7 +4978,7 @@ static void gfx_v10_0_constants_init(struct amdgpu_device *adev)
 	/* XXX SH_MEM regs */
 	/* where to put LDS, scratch, GPUVM in FSA64 space */
 	mutex_lock(&adev->srbm_mutex);
-	for (i = 0; i < adev->vm_manager.id_mgr[AMDGPU_GFXHUB_0].num_ids; i++) {
+	for (i = 0; i < adev->vm_manager.id_mgr[AMDGPU_GFXHUB(0)].num_ids; i++) {
 		nv_grbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
 		WREG32_SOC15(GC, 0, mmSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index fa3c79a6ecaa..8639b38fda6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -866,7 +866,7 @@ static int gfx_v11_0_gfx_ring_init(struct amdgpu_device *adev, int ring_id,
 		ring->doorbell_index = adev->doorbell_index.gfx_ring0 << 1;
 	else
 		ring->doorbell_index = adev->doorbell_index.gfx_ring1 << 1;
-	ring->vm_hub = AMDGPU_GFXHUB_0;
+	ring->vm_hub = AMDGPU_GFXHUB(0);
 	sprintf(ring->name, "gfx_%d.%d.%d", ring->me, ring->pipe, ring->queue);
 
 	irq_type = AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP + ring->pipe;
@@ -897,7 +897,7 @@ static int gfx_v11_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 	ring->doorbell_index = (adev->doorbell_index.mec_ring0 + ring_id) << 1;
 	ring->eop_gpu_addr = adev->gfx.mec.hpd_eop_gpu_addr
 				+ (ring_id * GFX11_MEC_HPD_SIZE);
-	ring->vm_hub = AMDGPU_GFXHUB_0;
+	ring->vm_hub = AMDGPU_GFXHUB(0);
 	sprintf(ring->name, "comp_%d.%d.%d", ring->me, ring->pipe, ring->queue);
 
 	irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
@@ -1674,7 +1674,7 @@ static void gfx_v11_0_constants_init(struct amdgpu_device *adev)
 	/* XXX SH_MEM regs */
 	/* where to put LDS, scratch, GPUVM in FSA64 space */
 	mutex_lock(&adev->srbm_mutex);
-	for (i = 0; i < adev->vm_manager.id_mgr[AMDGPU_GFXHUB_0].num_ids; i++) {
+	for (i = 0; i < adev->vm_manager.id_mgr[AMDGPU_GFXHUB(0)].num_ids; i++) {
 		soc21_grbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
 		WREG32_SOC15(GC, 0, regSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
@@ -4245,7 +4245,7 @@ static int gfx_v11_0_gfxhub_enable(struct amdgpu_device *adev)
 		false : true;
 
 	adev->gfxhub.funcs->set_fault_enable_default(adev, value);
-	amdgpu_gmc_flush_gpu_tlb(adev, 0, AMDGPU_GFXHUB_0, 0);
+	amdgpu_gmc_flush_gpu_tlb(adev, 0, AMDGPU_GFXHUB(0), 0);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 3fb01602acec..118b1592211a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1995,7 +1995,7 @@ static int gfx_v9_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 	ring->doorbell_index = (adev->doorbell_index.mec_ring0 + ring_id) << 1;
 	ring->eop_gpu_addr = adev->gfx.mec.hpd_eop_gpu_addr
 				+ (ring_id * GFX9_MEC_HPD_SIZE);
-	ring->vm_hub = AMDGPU_GFXHUB_0;
+	ring->vm_hub = AMDGPU_GFXHUB(0);
 	sprintf(ring->name, "comp_%d.%d.%d", ring->me, ring->pipe, ring->queue);
 
 	irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
@@ -2095,7 +2095,7 @@ static int gfx_v9_0_sw_init(void *handle)
 
 		/* disable scheduler on the real ring */
 		ring->no_scheduler = true;
-		ring->vm_hub = AMDGPU_GFXHUB_0;
+		ring->vm_hub = AMDGPU_GFXHUB(0);
 		r = amdgpu_ring_init(adev, ring, 1024, &adev->gfx.eop_irq,
 				     AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP,
 				     AMDGPU_RING_PRIO_DEFAULT, NULL);
@@ -2113,7 +2113,7 @@ static int gfx_v9_0_sw_init(void *handle)
 			ring->doorbell_index = adev->doorbell_index.gfx_ring0 << 1;
 			ring->is_sw_ring = true;
 			hw_prio = amdgpu_sw_ring_priority(i);
-			ring->vm_hub = AMDGPU_GFXHUB_0;
+			ring->vm_hub = AMDGPU_GFXHUB(0);
 			r = amdgpu_ring_init(adev, ring, 1024, &adev->gfx.eop_irq,
 					     AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP, hw_prio,
 					     NULL);
@@ -2383,7 +2383,7 @@ static void gfx_v9_0_constants_init(struct amdgpu_device *adev)
 	/* XXX SH_MEM regs */
 	/* where to put LDS, scratch, GPUVM in FSA64 space */
 	mutex_lock(&adev->srbm_mutex);
-	for (i = 0; i < adev->vm_manager.id_mgr[AMDGPU_GFXHUB_0].num_ids; i++) {
+	for (i = 0; i < adev->vm_manager.id_mgr[AMDGPU_GFXHUB(0)].num_ids; i++) {
 		soc15_grbm_select(adev, 0, 0, 0, i, 0);
 		/* CP and shaders */
 		if (i == 0) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index d648a29c33e0..ec7c049c5952 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -1935,7 +1935,7 @@ static bool gfx_v9_4_2_query_uctl2_poison_status(struct amdgpu_device *adev)
 	u32 status = 0;
 	struct amdgpu_vmhub *hub;
 
-	hub = &adev->vmhub[AMDGPU_GFXHUB_0];
+	hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 	status = RREG32(hub->vm_l2_pro_fault_status);
 	/* reset page fault status */
 	WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 21eaec02fa7f..fd8f6508877e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -762,7 +762,7 @@ static int gfx_v9_4_3_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 				(adev->doorbell_index.mec_ring0 + ring_id) << 1;
 	ring->eop_gpu_addr = adev->gfx.mec.hpd_eop_gpu_addr
 				+ (ring_id * GFX9_MEC_HPD_SIZE);
-	ring->vm_hub = AMDGPU_GFXHUB_0;
+	ring->vm_hub = AMDGPU_GFXHUB(0);
 	sprintf(ring->name, "comp_%d.%d.%d.%d",
 			ring->xcc_id, ring->me, ring->pipe, ring->queue);
 
@@ -1001,7 +1001,7 @@ static void gfx_v9_4_3_constants_init(struct amdgpu_device *adev)
 	/* XXX SH_MEM regs */
 	/* where to put LDS, scratch, GPUVM in FSA64 space */
 	mutex_lock(&adev->srbm_mutex);
-	for (i = 0; i < adev->vm_manager.id_mgr[AMDGPU_GFXHUB_0].num_ids; i++) {
+	for (i = 0; i < adev->vm_manager.id_mgr[AMDGPU_GFXHUB(0)].num_ids; i++) {
 		for (j = 0; j < adev->gfx.num_xcd; j++) {
 			soc15_grbm_select(adev, 0, 0, 0, i, j);
 			/* CP and shaders */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index ab2325f6c7ac..d94cc1ec7242 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -40,7 +40,7 @@ static void gfxhub_v1_0_setup_vm_pt_regs(struct amdgpu_device *adev,
 					 uint32_t vmid,
 					 uint64_t page_table_base)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 
 	WREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
 			    hub->ctx_addr_distance * vmid,
@@ -247,7 +247,7 @@ static void gfxhub_v1_0_disable_identity_aperture(struct amdgpu_device *adev)
 
 static void gfxhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 	unsigned num_level, block_size;
 	uint32_t tmp;
 	int i;
@@ -307,7 +307,7 @@ static void gfxhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
 
 static void gfxhub_v1_0_program_invalidation(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 	unsigned i;
 
 	for (i = 0 ; i < 18; ++i) {
@@ -338,7 +338,7 @@ static int gfxhub_v1_0_gart_enable(struct amdgpu_device *adev)
 
 static void gfxhub_v1_0_gart_disable(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 	u32 tmp;
 	u32 i;
 
@@ -411,7 +411,7 @@ static void gfxhub_v1_0_set_fault_enable_default(struct amdgpu_device *adev,
 
 static void gfxhub_v1_0_init(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 
 	hub->ctx0_ptb_addr_lo32 =
 		SOC15_REG_OFFSET(GC, 0,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index 79af32bb078c..9c385ce3a8c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -42,7 +42,7 @@ static void gfxhub_v1_2_setup_vm_pt_regs(struct amdgpu_device *adev,
 					 uint32_t vmid,
 					 uint64_t page_table_base)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 	int i;
 
 	for (i = 0; i < adev->gfx.num_xcd; i++) {
@@ -291,7 +291,7 @@ static void gfxhub_v1_2_disable_identity_aperture(struct amdgpu_device *adev)
 
 static void gfxhub_v1_2_setup_vmid_config(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 	unsigned num_level, block_size;
 	uint32_t tmp;
 	int i, j;
@@ -357,7 +357,7 @@ static void gfxhub_v1_2_setup_vmid_config(struct amdgpu_device *adev)
 
 static void gfxhub_v1_2_program_invalidation(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 	unsigned i, j;
 
 	for (j = 0; j < adev->gfx.num_xcd; j++) {
@@ -406,7 +406,7 @@ static int gfxhub_v1_2_gart_enable(struct amdgpu_device *adev)
 
 static void gfxhub_v1_2_gart_disable(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 	u32 tmp;
 	u32 i, j;
 
@@ -483,7 +483,7 @@ static void gfxhub_v1_2_set_fault_enable_default(struct amdgpu_device *adev,
 
 static void gfxhub_v1_2_init(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 
 	hub->ctx0_ptb_addr_lo32 =
 		SOC15_REG_OFFSET(GC, 0,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index 9b3a02527318..f173a61c6c15 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -120,7 +120,7 @@ static u64 gfxhub_v2_0_get_mc_fb_offset(struct amdgpu_device *adev)
 static void gfxhub_v2_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
 				uint64_t page_table_base)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 
 	WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
 			    hub->ctx_addr_distance * vmid,
@@ -282,7 +282,7 @@ static void gfxhub_v2_0_disable_identity_aperture(struct amdgpu_device *adev)
 
 static void gfxhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 	int i;
 	uint32_t tmp;
 
@@ -331,7 +331,7 @@ static void gfxhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 
 static void gfxhub_v2_0_program_invalidation(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 	unsigned i;
 
 	for (i = 0 ; i < 18; ++i) {
@@ -360,7 +360,7 @@ static int gfxhub_v2_0_gart_enable(struct amdgpu_device *adev)
 
 static void gfxhub_v2_0_gart_disable(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 	u32 tmp;
 	u32 i;
 
@@ -433,7 +433,7 @@ static const struct amdgpu_vmhub_funcs gfxhub_v2_0_vmhub_funcs = {
 
 static void gfxhub_v2_0_init(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 
 	hub->ctx0_ptb_addr_lo32 =
 		SOC15_REG_OFFSET(GC, 0,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index 4aacbbec31e2..d8fc3e8088cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -123,7 +123,7 @@ static u64 gfxhub_v2_1_get_mc_fb_offset(struct amdgpu_device *adev)
 static void gfxhub_v2_1_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
 				uint64_t page_table_base)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 
 	WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
 			    hub->ctx_addr_distance * vmid,
@@ -291,7 +291,7 @@ static void gfxhub_v2_1_disable_identity_aperture(struct amdgpu_device *adev)
 
 static void gfxhub_v2_1_setup_vmid_config(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 	int i;
 	uint32_t tmp;
 
@@ -340,7 +340,7 @@ static void gfxhub_v2_1_setup_vmid_config(struct amdgpu_device *adev)
 
 static void gfxhub_v2_1_program_invalidation(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 	unsigned i;
 
 	for (i = 0 ; i < 18; ++i) {
@@ -381,7 +381,7 @@ static int gfxhub_v2_1_gart_enable(struct amdgpu_device *adev)
 
 static void gfxhub_v2_1_gart_disable(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 	u32 tmp;
 	u32 i;
 
@@ -462,7 +462,7 @@ static const struct amdgpu_vmhub_funcs gfxhub_v2_1_vmhub_funcs = {
 
 static void gfxhub_v2_1_init(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 
 	hub->ctx0_ptb_addr_lo32 =
 		SOC15_REG_OFFSET(GC, 0,
@@ -651,7 +651,7 @@ static void gfxhub_v2_1_restore_regs(struct amdgpu_device *adev)
 
 static void gfxhub_v2_1_halt(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 	int i;
 	uint32_t tmp;
 	int time = 1000;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
index be0d0f47415e..974a7869289d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
@@ -119,7 +119,7 @@ static u64 gfxhub_v3_0_get_mc_fb_offset(struct amdgpu_device *adev)
 static void gfxhub_v3_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
 				uint64_t page_table_base)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 
 	WREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
 			    hub->ctx_addr_distance * vmid,
@@ -290,7 +290,7 @@ static void gfxhub_v3_0_disable_identity_aperture(struct amdgpu_device *adev)
 
 static void gfxhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 	int i;
 	uint32_t tmp;
 
@@ -339,7 +339,7 @@ static void gfxhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
 
 static void gfxhub_v3_0_program_invalidation(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 	unsigned i;
 
 	for (i = 0 ; i < 18; ++i) {
@@ -380,7 +380,7 @@ static int gfxhub_v3_0_gart_enable(struct amdgpu_device *adev)
 
 static void gfxhub_v3_0_gart_disable(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 	u32 tmp;
 	u32 i;
 
@@ -485,7 +485,7 @@ static const struct amdgpu_vmhub_funcs gfxhub_v3_0_vmhub_funcs = {
 
 static void gfxhub_v3_0_init(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 
 	hub->ctx0_ptb_addr_lo32 =
 		SOC15_REG_OFFSET(GC, 0,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
index 6e0bd628c889..ae777487d72e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
@@ -122,7 +122,7 @@ static u64 gfxhub_v3_0_3_get_mc_fb_offset(struct amdgpu_device *adev)
 static void gfxhub_v3_0_3_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
 				uint64_t page_table_base)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 
 	WREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
 			    hub->ctx_addr_distance * vmid,
@@ -295,7 +295,7 @@ static void gfxhub_v3_0_3_disable_identity_aperture(struct amdgpu_device *adev)
 
 static void gfxhub_v3_0_3_setup_vmid_config(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 	int i;
 	uint32_t tmp;
 
@@ -344,7 +344,7 @@ static void gfxhub_v3_0_3_setup_vmid_config(struct amdgpu_device *adev)
 
 static void gfxhub_v3_0_3_program_invalidation(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 	unsigned i;
 
 	for (i = 0 ; i < 18; ++i) {
@@ -373,7 +373,7 @@ static int gfxhub_v3_0_3_gart_enable(struct amdgpu_device *adev)
 
 static void gfxhub_v3_0_3_gart_disable(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 	u32 tmp;
 	u32 i;
 
@@ -451,7 +451,7 @@ static const struct amdgpu_vmhub_funcs gfxhub_v3_0_3_vmhub_funcs = {
 
 static void gfxhub_v3_0_3_init(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 
 	hub->ctx0_ptb_addr_lo32 =
 		SOC15_REG_OFFSET(GC, 0,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 23d4081eca00..a3ac887f36ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -76,7 +76,7 @@ gmc_v10_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
 		/* MM HUB */
-		amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_MMHUB_0, false);
+		amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_MMHUB0(0), false);
 		/* GFX HUB */
 		/* This works because this interrupt is only
 		 * enabled at init/resume and disabled in
@@ -84,11 +84,11 @@ gmc_v10_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
 		 * change over the course of suspend/resume.
 		 */
 		if (!adev->in_s0ix)
-			amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB_0, false);
+			amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB(0), false);
 		break;
 	case AMDGPU_IRQ_STATE_ENABLE:
 		/* MM HUB */
-		amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_MMHUB_0, true);
+		amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_MMHUB0(0), true);
 		/* GFX HUB */
 		/* This works because this interrupt is only
 		 * enabled at init/resume and disabled in
@@ -96,7 +96,7 @@ gmc_v10_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
 		 * change over the course of suspend/resume.
 		 */
 		if (!adev->in_s0ix)
-			amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB_0, true);
+			amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB(0), true);
 		break;
 	default:
 		break;
@@ -149,7 +149,7 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 		 * be updated to avoid reading an incorrect value due to
 		 * the new fast GRBM interface.
 		 */
-		if ((entry->vmid_src == AMDGPU_GFXHUB_0) &&
+		if ((entry->vmid_src == AMDGPU_GFXHUB(0)) &&
 		    (adev->ip_versions[GC_HWIP][0] < IP_VERSION(10, 3, 0)))
 			RREG32(hub->vm_l2_pro_fault_status);
 
@@ -212,8 +212,7 @@ static void gmc_v10_0_set_irq_funcs(struct amdgpu_device *adev)
 static bool gmc_v10_0_use_invalidate_semaphore(struct amdgpu_device *adev,
 				       uint32_t vmhub)
 {
-	return ((vmhub == AMDGPU_MMHUB_0 ||
-		 vmhub == AMDGPU_MMHUB_1) &&
+	return ((vmhub == AMDGPU_MMHUB0(0)) &&
 		(!amdgpu_sriov_vf(adev)));
 }
 
@@ -249,7 +248,7 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 	unsigned int i;
 	unsigned char hub_ip = 0;
 
-	hub_ip = (vmhub == AMDGPU_GFXHUB_0) ?
+	hub_ip = (vmhub == AMDGPU_GFXHUB(0)) ?
 		   GC_HWIP : MMHUB_HWIP;
 
 	spin_lock(&adev->gmc.invalidate_lock);
@@ -284,7 +283,7 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 	 * Issue a dummy read to wait for the ACK register to be cleared
 	 * to avoid a false ACK due to the new fast GRBM interface.
 	 */
-	if ((vmhub == AMDGPU_GFXHUB_0) &&
+	if ((vmhub == AMDGPU_GFXHUB(0)) &&
 	    (adev->ip_versions[GC_HWIP][0] < IP_VERSION(10, 3, 0)))
 		RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_req +
 				  hub->eng_distance * eng, hub_ip);
@@ -361,19 +360,19 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 
 	mutex_lock(&adev->mman.gtt_window_lock);
 
-	if (vmhub == AMDGPU_MMHUB_0) {
-		gmc_v10_0_flush_vm_hub(adev, vmid, AMDGPU_MMHUB_0, 0);
+	if (vmhub == AMDGPU_MMHUB0(0)) {
+		gmc_v10_0_flush_vm_hub(adev, vmid, AMDGPU_MMHUB0(0), 0);
 		mutex_unlock(&adev->mman.gtt_window_lock);
 		return;
 	}
 
-	BUG_ON(vmhub != AMDGPU_GFXHUB_0);
+	BUG_ON(vmhub != AMDGPU_GFXHUB(0));
 
 	if (!adev->mman.buffer_funcs_enabled ||
 	    !adev->ib_pool_ready ||
 	    amdgpu_in_reset(adev) ||
 	    ring->sched.ready == false) {
-		gmc_v10_0_flush_vm_hub(adev, vmid, AMDGPU_GFXHUB_0, 0);
+		gmc_v10_0_flush_vm_hub(adev, vmid, AMDGPU_GFXHUB(0), 0);
 		mutex_unlock(&adev->mman.gtt_window_lock);
 		return;
 	}
@@ -466,7 +465,7 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 							i, flush_type);
 			} else {
 				gmc_v10_0_flush_gpu_tlb(adev, vmid,
-						AMDGPU_GFXHUB_0, flush_type);
+						AMDGPU_GFXHUB(0), flush_type);
 			}
 			if (!adev->enable_mes)
 				break;
@@ -534,7 +533,7 @@ static void gmc_v10_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned vmid
 	if (ring->is_mes_queue)
 		return;
 
-	if (ring->vm_hub == AMDGPU_GFXHUB_0)
+	if (ring->vm_hub == AMDGPU_GFXHUB(0))
 		reg = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_VMID_0_LUT) + vmid;
 	else
 		reg = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_VMID_0_LUT_MM) + vmid;
@@ -1075,9 +1074,9 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
 	if (!adev->in_s0ix)
 		adev->gfxhub.funcs->set_fault_enable_default(adev, value);
 	adev->mmhub.funcs->set_fault_enable_default(adev, value);
-	gmc_v10_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB_0, 0);
+	gmc_v10_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
 	if (!adev->in_s0ix)
-		gmc_v10_0_flush_gpu_tlb(adev, 0, AMDGPU_GFXHUB_0, 0);
+		gmc_v10_0_flush_gpu_tlb(adev, 0, AMDGPU_GFXHUB(0), 0);
 
 	DRM_INFO("PCIE GART of %uM enabled (table at 0x%016llX).\n",
 		 (unsigned)(adev->gmc.gart_size >> 20),
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 3828ca95899f..37bc272bcf98 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -62,7 +62,7 @@ gmc_v11_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
 		/* MM HUB */
-		amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_MMHUB_0, false);
+		amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_MMHUB0(0), false);
 		/* GFX HUB */
 		/* This works because this interrupt is only
 		 * enabled at init/resume and disabled in
@@ -70,11 +70,11 @@ gmc_v11_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
 		 * change over the course of suspend/resume.
 		 */
 		if (!adev->in_s0ix)
-			amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB_0, false);
+			amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB(0), false);
 		break;
 	case AMDGPU_IRQ_STATE_ENABLE:
 		/* MM HUB */
-		amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_MMHUB_0, true);
+		amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_MMHUB0(0), true);
 		/* GFX HUB */
 		/* This works because this interrupt is only
 		 * enabled at init/resume and disabled in
@@ -82,7 +82,7 @@ gmc_v11_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
 		 * change over the course of suspend/resume.
 		 */
 		if (!adev->in_s0ix)
-			amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB_0, true);
+			amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB(0), true);
 		break;
 	default:
 		break;
@@ -108,7 +108,7 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 		 * be updated to avoid reading an incorrect value due to
 		 * the new fast GRBM interface.
 		 */
-		if (entry->vmid_src == AMDGPU_GFXHUB_0)
+		if (entry->vmid_src == AMDGPU_GFXHUB(0))
 			RREG32(hub->vm_l2_pro_fault_status);
 
 		status = RREG32(hub->vm_l2_pro_fault_status);
@@ -168,7 +168,7 @@ static void gmc_v11_0_set_irq_funcs(struct amdgpu_device *adev)
 static bool gmc_v11_0_use_invalidate_semaphore(struct amdgpu_device *adev,
 				       uint32_t vmhub)
 {
-	return ((vmhub == AMDGPU_MMHUB_0) &&
+	return ((vmhub == AMDGPU_MMHUB0(0)) &&
 		(!amdgpu_sriov_vf(adev)));
 }
 
@@ -200,7 +200,7 @@ static void gmc_v11_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 	unsigned int i;
 	unsigned char hub_ip = 0;
 
-	hub_ip = (vmhub == AMDGPU_GFXHUB_0) ?
+	hub_ip = (vmhub == AMDGPU_GFXHUB(0)) ?
 		   GC_HWIP : MMHUB_HWIP;
 
 	spin_lock(&adev->gmc.invalidate_lock);
@@ -249,7 +249,7 @@ static void gmc_v11_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 			      hub->eng_distance * eng, 0, hub_ip);
 
 	/* Issue additional private vm invalidation to MMHUB */
-	if ((vmhub != AMDGPU_GFXHUB_0) &&
+	if ((vmhub != AMDGPU_GFXHUB(0)) &&
 	    (hub->vm_l2_bank_select_reserved_cid2) &&
 		!amdgpu_sriov_vf(adev)) {
 		inv_req = RREG32_NO_KIQ(hub->vm_l2_bank_select_reserved_cid2);
@@ -282,7 +282,7 @@ static void gmc_v11_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 					uint32_t vmhub, uint32_t flush_type)
 {
-	if ((vmhub == AMDGPU_GFXHUB_0) && !adev->gfx.is_poweron)
+	if ((vmhub == AMDGPU_GFXHUB(0)) && !adev->gfx.is_poweron)
 		return;
 
 	/* flush hdp cache */
@@ -367,7 +367,7 @@ static int gmc_v11_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 							i, flush_type);
 			} else {
 				gmc_v11_0_flush_gpu_tlb(adev, vmid,
-						AMDGPU_GFXHUB_0, flush_type);
+						AMDGPU_GFXHUB(0), flush_type);
 			}
 		}
 	}
@@ -433,7 +433,7 @@ static void gmc_v11_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned vmid
 	if (ring->is_mes_queue)
 		return;
 
-	if (ring->vm_hub == AMDGPU_GFXHUB_0)
+	if (ring->vm_hub == AMDGPU_GFXHUB(0))
 		reg = SOC15_REG_OFFSET(OSSSYS, 0, regIH_VMID_0_LUT) + vmid;
 	else
 		reg = SOC15_REG_OFFSET(OSSSYS, 0, regIH_VMID_0_LUT_MM) + vmid;
@@ -867,7 +867,7 @@ static int gmc_v11_0_sw_fini(void *handle)
 static void gmc_v11_0_init_golden_registers(struct amdgpu_device *adev)
 {
 	if (amdgpu_sriov_vf(adev)) {
-		struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+		struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
 
 		WREG32(hub->vm_contexts_disable, 0);
 		return;
@@ -902,7 +902,7 @@ static int gmc_v11_0_gart_enable(struct amdgpu_device *adev)
 		false : true;
 
 	adev->mmhub.funcs->set_fault_enable_default(adev, value);
-	gmc_v11_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB_0, 0);
+	gmc_v11_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
 
 	DRM_INFO("PCIE GART of %uM enabled (table at 0x%016llX).\n",
 		 (unsigned)(adev->gmc.gart_size >> 20),
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 478dd534acad..6d13d42a125f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -491,20 +491,20 @@ static int gmc_v9_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
 				 * fini/suspend, so the overall state doesn't
 				 * change over the course of suspend/resume.
 				 */
-				if (adev->in_s0ix && (j == AMDGPU_GFXHUB_0))
+				if (adev->in_s0ix && (j == AMDGPU_GFXHUB(0)))
 					continue;
 
-				if (j == AMDGPU_GFXHUB_0)
-					tmp = RREG32_SOC15_IP(GC, reg);
-				else
+				if (j >= AMDGPU_MMHUB0(0))
 					tmp = RREG32_SOC15_IP(MMHUB, reg);
+				else
+					tmp = RREG32_SOC15_IP(GC, reg);
 
 				tmp &= ~bits;
 
-				if (j == AMDGPU_GFXHUB_0)
-					WREG32_SOC15_IP(GC, reg, tmp);
-				else
+				if (j >= AMDGPU_MMHUB0(0))
 					WREG32_SOC15_IP(MMHUB, reg, tmp);
+				else
+					WREG32_SOC15_IP(GC, reg, tmp);
 			}
 		}
 		break;
@@ -519,20 +519,20 @@ static int gmc_v9_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
 				 * fini/suspend, so the overall state doesn't
 				 * change over the course of suspend/resume.
 				 */
-				if (adev->in_s0ix && (j == AMDGPU_GFXHUB_0))
+				if (adev->in_s0ix && (j == AMDGPU_GFXHUB(0)))
 					continue;
 
-				if (j == AMDGPU_GFXHUB_0)
-					tmp = RREG32_SOC15_IP(GC, reg);
-				else
+				if (j >= AMDGPU_MMHUB0(0))
 					tmp = RREG32_SOC15_IP(MMHUB, reg);
+				else
+					tmp = RREG32_SOC15_IP(GC, reg);
 
 				tmp |= bits;
 
-				if (j == AMDGPU_GFXHUB_0)
-					WREG32_SOC15_IP(GC, reg, tmp);
-				else
+				if (j >= AMDGPU_MMHUB0(0))
 					WREG32_SOC15_IP(MMHUB, reg, tmp);
+				else
+					WREG32_SOC15_IP(GC, reg, tmp);
 			}
 		}
 		break;
@@ -588,13 +588,13 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 
 	if (entry->client_id == SOC15_IH_CLIENTID_VMC) {
 		hub_name = "mmhub0";
-		hub = &adev->vmhub[AMDGPU_MMHUB_0];
+		hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
 	} else if (entry->client_id == SOC15_IH_CLIENTID_VMC1) {
 		hub_name = "mmhub1";
-		hub = &adev->vmhub[AMDGPU_MMHUB_1];
+		hub = &adev->vmhub[AMDGPU_MMHUB1(0)];
 	} else {
 		hub_name = "gfxhub0";
-		hub = &adev->vmhub[AMDGPU_GFXHUB_0];
+		hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 	}
 
 	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
@@ -619,7 +619,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	 * be updated to avoid reading an incorrect value due to
 	 * the new fast GRBM interface.
 	 */
-	if ((entry->vmid_src == AMDGPU_GFXHUB_0) &&
+	if ((entry->vmid_src == AMDGPU_GFXHUB(0)) &&
 	    (adev->ip_versions[GC_HWIP][0] < IP_VERSION(9, 4, 2)))
 		RREG32(hub->vm_l2_pro_fault_status);
 
@@ -632,7 +632,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	dev_err(adev->dev,
 		"VM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
 		status);
-	if (hub == &adev->vmhub[AMDGPU_GFXHUB_0]) {
+	if (hub == &adev->vmhub[AMDGPU_GFXHUB(0)]) {
 		dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
 			cid >= ARRAY_SIZE(gfxhub_client_ids) ? "unknown" :
 			gfxhub_client_ids[cid],
@@ -742,8 +742,8 @@ static bool gmc_v9_0_use_invalidate_semaphore(struct amdgpu_device *adev,
 	    adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3))
 		return false;
 
-	return ((vmhub == AMDGPU_MMHUB_0 ||
-		 vmhub == AMDGPU_MMHUB_1) &&
+	return ((vmhub == AMDGPU_MMHUB0(0) ||
+		 vmhub == AMDGPU_MMHUB1(0)) &&
 		(!amdgpu_sriov_vf(adev)) &&
 		(!(!(adev->apu_flags & AMD_APU_IS_RAVEN2) &&
 		   (adev->apu_flags & AMD_APU_IS_PICASSO))));
@@ -832,11 +832,10 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	if (use_semaphore) {
 		for (j = 0; j < adev->usec_timeout; j++) {
 			/* a read return value of 1 means semaphore acquire */
-			if (vmhub == AMDGPU_GFXHUB_0)
-				tmp = RREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_sem + hub->eng_distance * eng);
-			else
+			if (vmhub >= AMDGPU_MMHUB0(0))
 				tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, hub->vm_inv_eng0_sem + hub->eng_distance * eng);
-
+			else
+				tmp = RREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_sem + hub->eng_distance * eng);
 			if (tmp & 0x1)
 				break;
 			udelay(1);
@@ -847,27 +846,26 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	}
 
 	do {
-		if (vmhub == AMDGPU_GFXHUB_0)
-			WREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_req + hub->eng_distance * eng, inv_req);
-		else
+		if (vmhub >= AMDGPU_MMHUB0(0))
 			WREG32_SOC15_IP_NO_KIQ(MMHUB, hub->vm_inv_eng0_req + hub->eng_distance * eng, inv_req);
+		else
+			WREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_req + hub->eng_distance * eng, inv_req);
 
 		/*
 		 * Issue a dummy read to wait for the ACK register to
 		 * be cleared to avoid a false ACK due to the new fast
 		 * GRBM interface.
 		 */
-		if ((vmhub == AMDGPU_GFXHUB_0) &&
+		if ((vmhub == AMDGPU_GFXHUB(0)) &&
 		    (adev->ip_versions[GC_HWIP][0] < IP_VERSION(9, 4, 2)))
 			RREG32_NO_KIQ(hub->vm_inv_eng0_req +
 				      hub->eng_distance * eng);
 
 		for (j = 0; j < adev->usec_timeout; j++) {
-			if (vmhub == AMDGPU_GFXHUB_0)
-				tmp = RREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_ack + hub->eng_distance * eng);
-			else
+			if (vmhub >= AMDGPU_MMHUB0(0))
 				tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, hub->vm_inv_eng0_ack + hub->eng_distance * eng);
-
+			else
+				tmp = RREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_ack + hub->eng_distance * eng);
 			if (tmp & (1 << vmid))
 				break;
 			udelay(1);
@@ -883,10 +881,10 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		 * add semaphore release after invalidation,
 		 * write with 0 means semaphore release
 		 */
-		if (vmhub == AMDGPU_GFXHUB_0)
-			WREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_sem + hub->eng_distance * eng, 0);
+		if (vmhub >= AMDGPU_MMHUB0(0))
+			WREG32_SOC15_IP_NO_KIQ(MMHUB, hub->vm_inv_eng0_req + hub->eng_distance * eng, inv_req);
 		else
-			WREG32_SOC15_IP_NO_KIQ(MMHUB, hub->vm_inv_eng0_sem + hub->eng_distance * eng, 0);
+			WREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_req + hub->eng_distance * eng, inv_req);
 	}
 
 	spin_unlock(&adev->gmc.invalidate_lock);
@@ -977,7 +975,7 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 							i, flush_type);
 			} else {
 				gmc_v9_0_flush_gpu_tlb(adev, vmid,
-						AMDGPU_GFXHUB_0, flush_type);
+						AMDGPU_GFXHUB(0), flush_type);
 			}
 			break;
 		}
@@ -1043,10 +1041,10 @@ static void gmc_v9_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned vmid,
 	uint32_t reg;
 
 	/* Do nothing because there's no lut register for mmhub1. */
-	if (ring->vm_hub == AMDGPU_MMHUB_1)
+	if (ring->vm_hub == AMDGPU_MMHUB1(0))
 		return;
 
-	if (ring->vm_hub == AMDGPU_GFXHUB_0)
+	if (ring->vm_hub == AMDGPU_GFXHUB(0))
 		reg = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_VMID_0_LUT) + vmid;
 	else
 		reg = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_VMID_0_LUT_MM) + vmid;
@@ -1930,7 +1928,7 @@ static int gmc_v9_0_hw_init(void *handle)
 		adev->mmhub.funcs->set_fault_enable_default(adev, value);
 	}
 	for (i = 0; i < adev->num_vmhubs; ++i) {
-		if (adev->in_s0ix && (i == AMDGPU_GFXHUB_0))
+		if (adev->in_s0ix && (i == AMDGPU_GFXHUB(0)))
 			continue;
 		gmc_v9_0_flush_gpu_tlb(adev, 0, i, 0);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
index a3076eb8af6a..71fe7f6f9889 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
@@ -485,7 +485,7 @@ int jpeg_v1_0_sw_init(void *handle)
 		return r;
 
 	ring = &adev->jpeg.inst->ring_dec;
-	ring->vm_hub = AMDGPU_MMHUB_0;
+	ring->vm_hub = AMDGPU_MMHUB0(0);
 	sprintf(ring->name, "jpeg_dec");
 	r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst->irq,
 			     0, AMDGPU_RING_PRIO_DEFAULT, NULL);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 0eddf7c824a7..3a43e42f4834 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -86,7 +86,7 @@ static int jpeg_v2_0_sw_init(void *handle)
 	ring = &adev->jpeg.inst->ring_dec;
 	ring->use_doorbell = true;
 	ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 1;
-	ring->vm_hub = AMDGPU_MMHUB_0;
+	ring->vm_hub = AMDGPU_MMHUB0(0);
 	sprintf(ring->name, "jpeg_dec");
 	r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst->irq,
 			     0, AMDGPU_RING_PRIO_DEFAULT, NULL);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index b040f51d9aa9..259b7ba6a842 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -128,9 +128,9 @@ static int jpeg_v2_5_sw_init(void *handle)
 		ring = &adev->jpeg.inst[i].ring_dec;
 		ring->use_doorbell = true;
 		if (adev->ip_versions[UVD_HWIP][0] == IP_VERSION(2, 5, 0))
-			ring->vm_hub = AMDGPU_MMHUB_1;
+			ring->vm_hub = AMDGPU_MMHUB1(0);
 		else
-			ring->vm_hub = AMDGPU_MMHUB_0;
+			ring->vm_hub = AMDGPU_MMHUB0(0);
 		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 1 + 8 * i;
 		sprintf(ring->name, "jpeg_dec_%d", i);
 		r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst[i].irq,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index c55e09432e26..07251dc8607d 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -100,7 +100,7 @@ static int jpeg_v3_0_sw_init(void *handle)
 	ring = &adev->jpeg.inst->ring_dec;
 	ring->use_doorbell = true;
 	ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 1;
-	ring->vm_hub = AMDGPU_MMHUB_0;
+	ring->vm_hub = AMDGPU_MMHUB0(0);
 	sprintf(ring->name, "jpeg_dec");
 	r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst->irq, 0,
 			     AMDGPU_RING_PRIO_DEFAULT, NULL);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index a6ad678fd507..2398e23a7d52 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -108,7 +108,7 @@ static int jpeg_v4_0_sw_init(void *handle)
 	ring = &adev->jpeg.inst->ring_dec;
 	ring->use_doorbell = true;
 	ring->doorbell_index = amdgpu_sriov_vf(adev) ? (((adev->doorbell_index.vcn.vcn_ring0_1) << 1) + 4) : ((adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 1);
-	ring->vm_hub = AMDGPU_MMHUB_0;
+	ring->vm_hub = AMDGPU_MMHUB0(0);
 
 	sprintf(ring->name, "jpeg_dec");
 	r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst->irq, 0,
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index 0599f8a6813e..39aa22b2ded2 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -149,7 +149,7 @@ static int mes_v10_1_add_hw_queue(struct amdgpu_mes *mes,
 {
 	struct amdgpu_device *adev = mes->adev;
 	union MESAPI__ADD_QUEUE mes_add_queue_pkt;
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 	uint32_t vm_cntx_cntl = hub->vm_cntx_cntl;
 
 	memset(&mes_add_queue_pkt, 0, sizeof(mes_add_queue_pkt));
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index d5272e650368..7bd235a98521 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -159,7 +159,7 @@ static int mes_v11_0_add_hw_queue(struct amdgpu_mes *mes,
 {
 	struct amdgpu_device *adev = mes->adev;
 	union MESAPI__ADD_QUEUE mes_add_queue_pkt;
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 	uint32_t vm_cntx_cntl = hub->vm_cntx_cntl;
 
 	memset(&mes_add_queue_pkt, 0, sizeof(mes_add_queue_pkt));
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index 15e7cbeae75b..fb91b31056ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -54,7 +54,7 @@ static u64 mmhub_v1_0_get_fb_location(struct amdgpu_device *adev)
 static void mmhub_v1_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
 				uint64_t page_table_base)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
 
 	WREG32_SOC15_OFFSET(MMHUB, 0, mmVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
 			    hub->ctx_addr_distance * vmid,
@@ -229,7 +229,7 @@ static void mmhub_v1_0_disable_identity_aperture(struct amdgpu_device *adev)
 
 static void mmhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
 	unsigned num_level, block_size;
 	uint32_t tmp;
 	int i;
@@ -285,7 +285,7 @@ static void mmhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
 
 static void mmhub_v1_0_program_invalidation(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
 	unsigned i;
 
 	for (i = 0; i < 18; ++i) {
@@ -338,7 +338,7 @@ static int mmhub_v1_0_gart_enable(struct amdgpu_device *adev)
 
 static void mmhub_v1_0_gart_disable(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
 	u32 tmp;
 	u32 i;
 
@@ -415,7 +415,7 @@ static void mmhub_v1_0_set_fault_enable_default(struct amdgpu_device *adev, bool
 
 static void mmhub_v1_0_init(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
 
 	hub->ctx0_ptb_addr_lo32 =
 		SOC15_REG_OFFSET(MMHUB, 0,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index 73afbf2facc9..9086f2fdfaf4 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -54,7 +54,7 @@ static u64 mmhub_v1_7_get_fb_location(struct amdgpu_device *adev)
 static void mmhub_v1_7_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
 				uint64_t page_table_base)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
 
 	WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
 			hub->ctx_addr_distance * vmid, lower_32_bits(page_table_base));
@@ -261,7 +261,7 @@ static void mmhub_v1_7_disable_identity_aperture(struct amdgpu_device *adev)
 
 static void mmhub_v1_7_setup_vmid_config(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
 	unsigned num_level, block_size;
 	uint32_t tmp;
 	int i;
@@ -319,7 +319,7 @@ static void mmhub_v1_7_setup_vmid_config(struct amdgpu_device *adev)
 
 static void mmhub_v1_7_program_invalidation(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
 	unsigned i;
 
 	for (i = 0; i < 18; ++i) {
@@ -348,7 +348,7 @@ static int mmhub_v1_7_gart_enable(struct amdgpu_device *adev)
 
 static void mmhub_v1_7_gart_disable(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
 	u32 tmp;
 	u32 i;
 
@@ -425,7 +425,7 @@ static void mmhub_v1_7_set_fault_enable_default(struct amdgpu_device *adev, bool
 
 static void mmhub_v1_7_init(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
 
 	hub->ctx0_ptb_addr_lo32 =
 		SOC15_REG_OFFSET(MMHUB, 0,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index 342d1702104c..9ec06f9db761 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -53,7 +53,7 @@ static u64 mmhub_v1_8_get_fb_location(struct amdgpu_device *adev)
 static void mmhub_v1_8_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
 				uint64_t page_table_base)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
 
 	WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
 			    hub->ctx_addr_distance * vmid, lower_32_bits(page_table_base));
@@ -253,7 +253,7 @@ static void mmhub_v1_8_disable_identity_aperture(struct amdgpu_device *adev)
 
 static void mmhub_v1_8_setup_vmid_config(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
 	unsigned num_level, block_size;
 	uint32_t tmp;
 	int i;
@@ -311,7 +311,7 @@ static void mmhub_v1_8_setup_vmid_config(struct amdgpu_device *adev)
 
 static void mmhub_v1_8_program_invalidation(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
 	unsigned i;
 
 	for (i = 0; i < 18; ++i) {
@@ -352,7 +352,7 @@ static int mmhub_v1_8_gart_enable(struct amdgpu_device *adev)
 
 static void mmhub_v1_8_gart_disable(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
 	u32 tmp;
 	u32 i;
 
@@ -426,7 +426,7 @@ static void mmhub_v1_8_set_fault_enable_default(struct amdgpu_device *adev, bool
 
 static void mmhub_v1_8_init(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
 
 	hub->ctx0_ptb_addr_lo32 =
 		SOC15_REG_OFFSET(MMHUB, 0,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index 278e32db878d..8f76c6ecf50a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -187,7 +187,7 @@ mmhub_v2_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
 static void mmhub_v2_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
 				uint64_t page_table_base)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
 
 	WREG32_SOC15_OFFSET_RLC(MMHUB, 0, mmMMVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
 			    hub->ctx_addr_distance * vmid,
@@ -362,7 +362,7 @@ static void mmhub_v2_0_disable_identity_aperture(struct amdgpu_device *adev)
 
 static void mmhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
 	int i;
 	uint32_t tmp;
 
@@ -412,7 +412,7 @@ static void mmhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 
 static void mmhub_v2_0_program_invalidation(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
 	unsigned i;
 
 	for (i = 0; i < 18; ++i) {
@@ -441,7 +441,7 @@ static int mmhub_v2_0_gart_enable(struct amdgpu_device *adev)
 
 static void mmhub_v2_0_gart_disable(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
 	u32 tmp;
 	u32 i;
 
@@ -520,7 +520,7 @@ static const struct amdgpu_vmhub_funcs mmhub_v2_0_vmhub_funcs = {
 
 static void mmhub_v2_0_init(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
 
 	hub->ctx0_ptb_addr_lo32 =
 		SOC15_REG_OFFSET(MMHUB, 0,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
index fcf2813e70db..8bd0fc8d9d25 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
@@ -121,7 +121,7 @@ static void mmhub_v2_3_setup_vm_pt_regs(struct amdgpu_device *adev,
 					uint32_t vmid,
 					uint64_t page_table_base)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
 
 	WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
 			    hub->ctx_addr_distance * vmid, lower_32_bits(page_table_base));
@@ -280,7 +280,7 @@ static void mmhub_v2_3_disable_identity_aperture(struct amdgpu_device *adev)
 
 static void mmhub_v2_3_setup_vmid_config(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
 	int i;
 	uint32_t tmp;
 
@@ -330,7 +330,7 @@ static void mmhub_v2_3_setup_vmid_config(struct amdgpu_device *adev)
 
 static void mmhub_v2_3_program_invalidation(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
 	unsigned i;
 
 	for (i = 0; i < 18; ++i) {
@@ -373,7 +373,7 @@ static int mmhub_v2_3_gart_enable(struct amdgpu_device *adev)
 
 static void mmhub_v2_3_gart_disable(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
 	u32 tmp;
 	u32 i;
 
@@ -446,7 +446,7 @@ static const struct amdgpu_vmhub_funcs mmhub_v2_3_vmhub_funcs = {
 
 static void mmhub_v2_3_init(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
 
 	hub->ctx0_ptb_addr_lo32 =
 		SOC15_REG_OFFSET(MMHUB, 0,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
index 17a792616979..441379e91cfa 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
@@ -136,7 +136,7 @@ mmhub_v3_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
 static void mmhub_v3_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
 				uint64_t page_table_base)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
 
 	WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
 			    hub->ctx_addr_distance * vmid,
@@ -319,7 +319,7 @@ static void mmhub_v3_0_disable_identity_aperture(struct amdgpu_device *adev)
 
 static void mmhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
 	int i;
 	uint32_t tmp;
 
@@ -369,7 +369,7 @@ static void mmhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
 
 static void mmhub_v3_0_program_invalidation(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
 	unsigned i;
 
 	for (i = 0; i < 18; ++i) {
@@ -398,7 +398,7 @@ static int mmhub_v3_0_gart_enable(struct amdgpu_device *adev)
 
 static void mmhub_v3_0_gart_disable(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
 	u32 tmp;
 	u32 i;
 
@@ -477,7 +477,7 @@ static const struct amdgpu_vmhub_funcs mmhub_v3_0_vmhub_funcs = {
 
 static void mmhub_v3_0_init(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
 
 	hub->ctx0_ptb_addr_lo32 =
 		SOC15_REG_OFFSET(MMHUB, 0,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
index 26509b6b8c24..12c7f4b46ea9 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
@@ -138,7 +138,7 @@ static void mmhub_v3_0_1_setup_vm_pt_regs(struct amdgpu_device *adev,
 					  uint32_t vmid,
 					  uint64_t page_table_base)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
 
 	WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
 			    hub->ctx_addr_distance * vmid,
@@ -306,7 +306,7 @@ static void mmhub_v3_0_1_disable_identity_aperture(struct amdgpu_device *adev)
 
 static void mmhub_v3_0_1_setup_vmid_config(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
 	int i;
 	uint32_t tmp;
 
@@ -356,7 +356,7 @@ static void mmhub_v3_0_1_setup_vmid_config(struct amdgpu_device *adev)
 
 static void mmhub_v3_0_1_program_invalidation(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
 	unsigned i;
 
 	for (i = 0; i < 18; ++i) {
@@ -385,7 +385,7 @@ static int mmhub_v3_0_1_gart_enable(struct amdgpu_device *adev)
 
 static void mmhub_v3_0_1_gart_disable(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
 	u32 tmp;
 	u32 i;
 
@@ -459,7 +459,7 @@ static const struct amdgpu_vmhub_funcs mmhub_v3_0_1_vmhub_funcs = {
 
 static void mmhub_v3_0_1_init(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
 
 	hub->ctx0_ptb_addr_lo32 =
 		SOC15_REG_OFFSET(MMHUB, 0,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
index 26abbc6a47ab..5dadc85abf7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
@@ -129,7 +129,7 @@ mmhub_v3_0_2_print_l2_protection_fault_status(struct amdgpu_device *adev,
 static void mmhub_v3_0_2_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
 				uint64_t page_table_base)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
 
 	WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
 			    hub->ctx_addr_distance * vmid,
@@ -311,7 +311,7 @@ static void mmhub_v3_0_2_disable_identity_aperture(struct amdgpu_device *adev)
 
 static void mmhub_v3_0_2_setup_vmid_config(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
 	int i;
 	uint32_t tmp;
 
@@ -361,7 +361,7 @@ static void mmhub_v3_0_2_setup_vmid_config(struct amdgpu_device *adev)
 
 static void mmhub_v3_0_2_program_invalidation(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
 	unsigned i;
 
 	for (i = 0; i < 18; ++i) {
@@ -390,7 +390,7 @@ static int mmhub_v3_0_2_gart_enable(struct amdgpu_device *adev)
 
 static void mmhub_v3_0_2_gart_disable(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
 	u32 tmp;
 	u32 i;
 
@@ -469,7 +469,7 @@ static const struct amdgpu_vmhub_funcs mmhub_v3_0_2_vmhub_funcs = {
 
 static void mmhub_v3_0_2_init(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
 
 	hub->ctx0_ptb_addr_lo32 =
 		SOC15_REG_OFFSET(MMHUB, 0,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
index 72083e96222f..7fe7ade17373 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -57,7 +57,7 @@ static u64 mmhub_v9_4_get_fb_location(struct amdgpu_device *adev)
 static void mmhub_v9_4_setup_hubid_vm_pt_regs(struct amdgpu_device *adev, int hubid,
 				uint32_t vmid, uint64_t value)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
 
 	WREG32_SOC15_OFFSET(MMHUB, 0,
 			    mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
@@ -294,7 +294,7 @@ static void mmhub_v9_4_disable_identity_aperture(struct amdgpu_device *adev,
 
 static void mmhub_v9_4_setup_vmid_config(struct amdgpu_device *adev, int hubid)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
 	unsigned int num_level, block_size;
 	uint32_t tmp;
 	int i;
@@ -363,7 +363,7 @@ static void mmhub_v9_4_setup_vmid_config(struct amdgpu_device *adev, int hubid)
 static void mmhub_v9_4_program_invalidation(struct amdgpu_device *adev,
 					    int hubid)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
 	unsigned i;
 
 	for (i = 0; i < 18; ++i) {
@@ -404,7 +404,7 @@ static int mmhub_v9_4_gart_enable(struct amdgpu_device *adev)
 
 static void mmhub_v9_4_gart_disable(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
 	u32 tmp;
 	u32 i, j;
 
@@ -508,7 +508,7 @@ static void mmhub_v9_4_set_fault_enable_default(struct amdgpu_device *adev, bool
 static void mmhub_v9_4_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub[MMHUB_NUM_INSTANCES] =
-		{&adev->vmhub[AMDGPU_MMHUB_0], &adev->vmhub[AMDGPU_MMHUB_1]};
+		{&adev->vmhub[AMDGPU_MMHUB0(0)], &adev->vmhub[AMDGPU_MMHUB1(0)]};
 	int i;
 
 	for (i = 0; i < MMHUB_NUM_INSTANCES; i++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index c94398565514..dfe91ebc7b43 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1825,12 +1825,12 @@ static int sdma_v4_0_sw_init(void *handle)
 
 		/*
 		 * On Arcturus, SDMA instance 5~7 has a different vmhub
-		 * type(AMDGPU_MMHUB_1).
+		 * type(AMDGPU_MMHUB1).
 		 */
 		if (adev->ip_versions[SDMA0_HWIP][0] == IP_VERSION(4, 2, 2) && i >= 5)
-			ring->vm_hub = AMDGPU_MMHUB_1;
+			ring->vm_hub = AMDGPU_MMHUB1(0);
 		else
-			ring->vm_hub = AMDGPU_MMHUB_0;
+			ring->vm_hub = AMDGPU_MMHUB0(0);
 
 		sprintf(ring->name, "sdma%d", i);
 		r = amdgpu_ring_init(adev, ring, 1024, &adev->sdma.trap_irq,
@@ -1851,9 +1851,9 @@ static int sdma_v4_0_sw_init(void *handle)
 			ring->doorbell_index += 0x400;
 
 			if (adev->ip_versions[SDMA0_HWIP][0] == IP_VERSION(4, 2, 2) && i >= 5)
-				ring->vm_hub = AMDGPU_MMHUB_1;
+				ring->vm_hub = AMDGPU_MMHUB1(0);
 			else
-				ring->vm_hub = AMDGPU_MMHUB_0;
+				ring->vm_hub = AMDGPU_MMHUB0(0);
 
 			sprintf(ring->name, "page%d", i);
 			r = amdgpu_ring_init(adev, ring, 1024,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 64dcaa2670dd..7efe7c43fffb 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1309,7 +1309,7 @@ static int sdma_v4_4_2_sw_init(void *handle)
 
 		/* doorbell size is 2 dwords, get DWORD offset */
 		ring->doorbell_index = adev->doorbell_index.sdma_engine[i] << 1;
-		ring->vm_hub = AMDGPU_MMHUB_0;
+		ring->vm_hub = AMDGPU_MMHUB0(0);
 
 		sprintf(ring->name, "sdma%d", i);
 		r = amdgpu_ring_init(adev, ring, 1024, &adev->sdma.trap_irq,
@@ -1328,7 +1328,7 @@ static int sdma_v4_4_2_sw_init(void *handle)
 			 */
 			ring->doorbell_index = adev->doorbell_index.sdma_engine[i] << 1;
 			ring->doorbell_index += 0x400;
-			ring->vm_hub = AMDGPU_MMHUB_0;
+			ring->vm_hub = AMDGPU_MMHUB0(0);
 
 			sprintf(ring->name, "page%d", i);
 			r = amdgpu_ring_init(adev, ring, 1024,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 92e1299be021..a0077cf41295 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1389,7 +1389,7 @@ static int sdma_v5_0_sw_init(void *handle)
 			(adev->doorbell_index.sdma_engine[0] << 1) //get DWORD offset
 			: (adev->doorbell_index.sdma_engine[1] << 1); // get DWORD offset
 
-		ring->vm_hub = AMDGPU_GFXHUB_0;
+		ring->vm_hub = AMDGPU_GFXHUB(0);
 		sprintf(ring->name, "sdma%d", i);
 		r = amdgpu_ring_init(adev, ring, 1024, &adev->sdma.trap_irq,
 				     (i == 0) ? AMDGPU_SDMA_IRQ_INSTANCE0 :
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index ca7e8757d78e..efa2c84ee78e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1253,7 +1253,7 @@ static int sdma_v5_2_sw_init(void *handle)
 		ring->doorbell_index =
 			(adev->doorbell_index.sdma_engine[i] << 1); //get DWORD offset
 
-		ring->vm_hub = AMDGPU_GFXHUB_0;
+		ring->vm_hub = AMDGPU_GFXHUB(0);
 		sprintf(ring->name, "sdma%d", i);
 		r = amdgpu_ring_init(adev, ring, 1024, &adev->sdma.trap_irq,
 				     AMDGPU_SDMA_IRQ_INSTANCE0 + i,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 67e937158724..77a0a9751536 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1272,7 +1272,7 @@ static int sdma_v6_0_sw_init(void *handle)
 		ring->doorbell_index =
 			(adev->doorbell_index.sdma_engine[i] << 1); // get DWORD offset
 
-		ring->vm_hub = AMDGPU_GFXHUB_0;
+		ring->vm_hub = AMDGPU_GFXHUB(0);
 		sprintf(ring->name, "sdma%d", i);
 		r = amdgpu_ring_init(adev, ring, 1024,
 				     &adev->sdma.trap_irq,
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index e32b656b3dab..abaa4463e906 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -444,7 +444,7 @@ static int uvd_v7_0_sw_init(void *handle)
 			continue;
 		if (!amdgpu_sriov_vf(adev)) {
 			ring = &adev->uvd.inst[j].ring;
-			ring->vm_hub = AMDGPU_MMHUB_0;
+			ring->vm_hub = AMDGPU_MMHUB0(0);
 			sprintf(ring->name, "uvd_%d", ring->me);
 			r = amdgpu_ring_init(adev, ring, 512,
 					     &adev->uvd.inst[j].irq, 0,
@@ -455,7 +455,7 @@ static int uvd_v7_0_sw_init(void *handle)
 
 		for (i = 0; i < adev->uvd.num_enc_rings; ++i) {
 			ring = &adev->uvd.inst[j].ring_enc[i];
-			ring->vm_hub = AMDGPU_MMHUB_0;
+			ring->vm_hub = AMDGPU_MMHUB0(0);
 			sprintf(ring->name, "uvd_enc_%d.%d", ring->me, i);
 			if (amdgpu_sriov_vf(adev)) {
 				ring->use_doorbell = true;
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index 57b85bb6a1e4..e0b70cd3b697 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -466,7 +466,7 @@ static int vce_v4_0_sw_init(void *handle)
 		enum amdgpu_ring_priority_level hw_prio = amdgpu_vce_get_ring_prio(i);
 
 		ring = &adev->vce.ring[i];
-		ring->vm_hub = AMDGPU_MMHUB_0;
+		ring->vm_hub = AMDGPU_MMHUB0(0);
 		sprintf(ring->name, "vce%d", i);
 		if (amdgpu_sriov_vf(adev)) {
 			/* DOORBELL only works under SRIOV */
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 761c28fa6ec1..f877c39c7cdd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -120,7 +120,7 @@ static int vcn_v1_0_sw_init(void *handle)
 		return r;
 
 	ring = &adev->vcn.inst->ring_dec;
-	ring->vm_hub = AMDGPU_MMHUB_0;
+	ring->vm_hub = AMDGPU_MMHUB0(0);
 	sprintf(ring->name, "vcn_dec");
 	r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
 			     AMDGPU_RING_PRIO_DEFAULT, NULL);
@@ -142,7 +142,7 @@ static int vcn_v1_0_sw_init(void *handle)
 		enum amdgpu_ring_priority_level hw_prio = amdgpu_vcn_get_enc_ring_prio(i);
 
 		ring = &adev->vcn.inst->ring_enc[i];
-		ring->vm_hub = AMDGPU_MMHUB_0;
+		ring->vm_hub = AMDGPU_MMHUB0(0);
 		sprintf(ring->name, "vcn_enc%d", i);
 		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
 				     hw_prio, NULL);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 7c2b3aa48083..c975aed2f6c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -129,7 +129,7 @@ static int vcn_v2_0_sw_init(void *handle)
 
 	ring->use_doorbell = true;
 	ring->doorbell_index = adev->doorbell_index.vcn.vcn_ring0_1 << 1;
-	ring->vm_hub = AMDGPU_MMHUB_0;
+	ring->vm_hub = AMDGPU_MMHUB0(0);
 
 	sprintf(ring->name, "vcn_dec");
 	r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
@@ -160,7 +160,7 @@ static int vcn_v2_0_sw_init(void *handle)
 
 		ring = &adev->vcn.inst->ring_enc[i];
 		ring->use_doorbell = true;
-		ring->vm_hub = AMDGPU_MMHUB_0;
+		ring->vm_hub = AMDGPU_MMHUB0(0);
 		if (!amdgpu_sriov_vf(adev))
 			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 2 + i;
 		else
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index ab0b45d0ead1..7044bd7c9f62 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -188,9 +188,9 @@ static int vcn_v2_5_sw_init(void *handle)
 				(amdgpu_sriov_vf(adev) ? 2*j : 8*j);
 
 		if (adev->ip_versions[UVD_HWIP][0] == IP_VERSION(2, 5, 0))
-			ring->vm_hub = AMDGPU_MMHUB_1;
+			ring->vm_hub = AMDGPU_MMHUB1(0);
 		else
-			ring->vm_hub = AMDGPU_MMHUB_0;
+			ring->vm_hub = AMDGPU_MMHUB0(0);
 
 		sprintf(ring->name, "vcn_dec_%d", j);
 		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[j].irq,
@@ -208,9 +208,9 @@ static int vcn_v2_5_sw_init(void *handle)
 					(amdgpu_sriov_vf(adev) ? (1 + i + 2*j) : (2 + i + 8*j));
 
 			if (adev->ip_versions[UVD_HWIP][0] == IP_VERSION(2, 5, 0))
-				ring->vm_hub = AMDGPU_MMHUB_1;
+				ring->vm_hub = AMDGPU_MMHUB1(0);
 			else
-				ring->vm_hub = AMDGPU_MMHUB_0;
+				ring->vm_hub = AMDGPU_MMHUB0(0);
 
 			sprintf(ring->name, "vcn_enc_%d.%d", j, i);
 			r = amdgpu_ring_init(adev, ring, 512,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 3eab186261aa..70fefbf26c48 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -189,7 +189,7 @@ static int vcn_v3_0_sw_init(void *handle)
 		} else {
 			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * i;
 		}
-		ring->vm_hub = AMDGPU_MMHUB_0;
+		ring->vm_hub = AMDGPU_MMHUB0(0);
 		sprintf(ring->name, "vcn_dec_%d", i);
 		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i].irq, 0,
 				     AMDGPU_RING_PRIO_DEFAULT,
@@ -213,7 +213,7 @@ static int vcn_v3_0_sw_init(void *handle)
 			} else {
 				ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 2 + j + 8 * i;
 			}
-			ring->vm_hub = AMDGPU_MMHUB_0;
+			ring->vm_hub = AMDGPU_MMHUB0(0);
 			sprintf(ring->name, "vcn_enc_%d.%d", i, j);
 			r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i].irq, 0,
 					     hw_prio, &adev->vcn.inst[i].sched_score);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index bf0674039598..81446e6996df 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -149,7 +149,7 @@ static int vcn_v4_0_sw_init(void *handle)
 			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + i * (adev->vcn.num_enc_rings + 1) + 1;
 		else
 			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 2 + 8 * i;
-		ring->vm_hub = AMDGPU_MMHUB_0;
+		ring->vm_hub = AMDGPU_MMHUB0(0);
 		sprintf(ring->name, "vcn_unified_%d", i);
 
 		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i].irq, 0,
-- 
2.39.2

