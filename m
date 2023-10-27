Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C376C25B47
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Oct 2023 20:11:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0DDF10EA3E;
	Fri, 27 Oct 2023 20:11:52 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::615])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84B8B10EA3E
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Oct 2023 20:11:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDE5FkixYoZMPDerQzUFPSq0uogkrC7yrAPo7dv/vDCBlUnqHsHXo/pEtJOZtOwa05x0w6KvbmpAqdSSW8UX7lzxM2g8fvylDkjwVQAqiWaManOp4ZgvasbTZATacRfZWjsp//Op6kiarzkQR3W10r6XoGVyREa+cz+K0aJbP9atOQqh7HO3E3tOmnzVVUYmP+gSemOWTX26nL9I7BPvvue6ZssJFG+h6OQKKFz1X4/ffNMik7uFPHp9MgYgpoNaFWnV2Ws8KTkxY1QBokHmfl/ub7URO0MFF06dv1RY8XONJB2TPlbumE6usgepu42kNyNUmLWg+weabbWx8ZuE7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5g7PFK/1tDpQya2olAcJYnuZps4kq2Au5NF0xddZvM=;
 b=fwLtHmLCgjjB11gmT9waRQEsYAaKzaYYFaf54oVr/0TwgQEkfINNkQnNflIy4fZFbzPBPUf0oBO7AUube/hyWXt48EnJ+d9pDMxtlosYfgpLXgsgHY+XPzEvrF6kX0FXCeXPJOnJ2jMSjoKzy96BIbGXActSnnostQXIPnlikiqqQHy1EjhP0rha4rZ5aoe8nqttytUT2+5DeeZMSB9oJqfHktWe4uMR+Kd1xhOVXBAH/jAiIipTf6DaGcWNFfW3z9ovDfdADyFZ0UmDODdpS0Bj0AdH0J7rqhBOXRqDWujaOgJ+OOvqJtfCERJNXtk7dIj8sp9t9guNHye+V/6GoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5g7PFK/1tDpQya2olAcJYnuZps4kq2Au5NF0xddZvM=;
 b=FxBxG1qBfojUttkZa8WeNdEF+pwW1jHCvKI1aT2mhuM2kq/mjVyeWKBGXRxhvT0vqS3laVq1KBhgv1BBARMI1PBxVPtahz8AOqzQ8jD6JTAXP8IXHcPQeFSf/FoJa7J/JnyOXGBrqC77VDNfbSP/K3RDUqbB+Vakvly9cGz9Lhw=
Received: from MW2PR16CA0050.namprd16.prod.outlook.com (2603:10b6:907:1::27)
 by SJ2PR12MB8979.namprd12.prod.outlook.com (2603:10b6:a03:548::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Fri, 27 Oct
 2023 20:11:48 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:907:1:cafe::7e) by MW2PR16CA0050.outlook.office365.com
 (2603:10b6:907:1::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Fri, 27 Oct 2023 20:11:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Fri, 27 Oct 2023 20:11:47 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 27 Oct
 2023 15:11:47 -0500
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add xcc_inst param to
 amdgpu_virt_kiq_reg_write_reg_wait (v3)
Date: Fri, 27 Oct 2023 16:11:22 -0400
Message-ID: <20231027201122.2344-1-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025205242.40490-4-victorchengchi.lu@amd.com>
References: <20231025205242.40490-4-victorchengchi.lu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|SJ2PR12MB8979:EE_
X-MS-Office365-Filtering-Correlation-Id: 85426138-25ef-489d-aa79-08dbd728f31b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XTC9ASdHCt4fCjgYA+V07QoCcBOui4vcF3y9UMaeLCC2DCtslsn0cFn+GCc8b3mIfh14vGfWLCp4IUBzw0E8ex1sk4U/fwjR107fNPv+nH6PtQuSbAqaWsxPvD3HJyS+p7TE3mMFEafWEIjZXwRnT1C7sCcNUdf4EzamIojsPHOaz+NJWVtHwKcQjJ9TMLTLX1CaS7wPgFCbzOcOJH4PaIDgfJKiLrCSkTFySm9mat/hLUNKAjXbV++QgsgYDAk9gODodEeZ/2LaRDCztmuiOtju4NXIzJlrMP4nAQgYul8paFF2+JELcDpbEqIC385Hd56zLfBRp3v5n1rd4BiAmHwZg5LvWNG12lUs2O8GEPNppEvBkBtByfaTt6MQ34Xisf7z/X1/pUiETQrZ/UkCJiAW0T6n/egBGxxXDAo6UNJy4P2qHg+AV/xAQJIWDDoIINxPGkqPsQz3uGDblJG6JBlKUvDWIyI6rqswG8em1sGRvR4skP7zIVs5pzs0U5wL1K2aT/C+ig6ZaAKz+/Hs72FUKd/YwMtSQOcgJEjws/oF+N44SiH7NPrQmrd6z3IkUzx1L4BA06GO/EbgZttcS00gaL7ESAOirNXwmOeYwGiTd9VCEVAK+jUwA/45nsyE3q41MLzrUZg+GWtvt+pJNVJZJfHOQFx3RyXKqgM3iJ884E3jgInIKCdOTGehy+oY4inPNmijeoZDeuzg5wkzi8ftk6X+FbJ/Io8SqWKtaX9WkBIy/664rGUTRtR+NDXFA3E5zUV2FSSPb9Bz7P+/SQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(6916009)(40460700003)(40480700001)(16526019)(7696005)(478600001)(2616005)(70586007)(36756003)(54906003)(1076003)(6666004)(86362001)(47076005)(336012)(316002)(36860700001)(426003)(70206006)(81166007)(82740400003)(26005)(356005)(8676002)(83380400001)(8936002)(4326008)(5660300002)(2906002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 20:11:47.8834 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85426138-25ef-489d-aa79-08dbd728f31b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8979
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
Cc: lijo.lazar@amd.com, davis.ming@amd.com,
 Victor Lu <victorchengchi.lu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu_virt_kiq_reg_write_reg_wait is hardcoded to use MEC engine 0.
Add xcc_inst as a parameter to allow it to use different MEC engines.

v3: use first xcc for MMHUB in gmc_v9_0_flush_gpu_tlb

v2: rebase

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c |  5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  3 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 26 ++++++++++++++----------
 5 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 7a084fbfd33c..82762c61d3ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -73,9 +73,10 @@ void amdgpu_virt_init_setting(struct amdgpu_device *adev)
 
 void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev,
 					uint32_t reg0, uint32_t reg1,
-					uint32_t ref, uint32_t mask)
+					uint32_t ref, uint32_t mask,
+					uint32_t xcc_inst)
 {
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_inst];
 	struct amdgpu_ring *ring = &kiq->ring;
 	signed long r, cnt = 0;
 	unsigned long flags;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 03c0e38b8aea..5c64258eb728 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -334,7 +334,8 @@ bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev);
 void amdgpu_virt_init_setting(struct amdgpu_device *adev);
 void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev,
 					uint32_t reg0, uint32_t rreg1,
-					uint32_t ref, uint32_t mask);
+					uint32_t ref, uint32_t mask,
+					uint32_t xcc_id);
 int amdgpu_virt_request_full_gpu(struct amdgpu_device *adev, bool init);
 int amdgpu_virt_release_full_gpu(struct amdgpu_device *adev, bool init);
 int amdgpu_virt_reset_gpu(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index d8a4fddab9c1..173237e99882 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -268,7 +268,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	if (adev->gfx.kiq[0].ring.sched.ready && !adev->enable_mes &&
 	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
 		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
-				1 << vmid);
+				1 << vmid, 0);
 		return;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 19eaada35ede..2e4abb356e38 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -228,7 +228,7 @@ static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	if ((adev->gfx.kiq[0].ring.sched.ready || adev->mes.ring.sched.ready) &&
 	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
 		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
-				1 << vmid);
+				1 << vmid, 0);
 		return;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 0ab9c554da78..32cc3645f02b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -817,7 +817,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 					uint32_t vmhub, uint32_t flush_type)
 {
 	bool use_semaphore = gmc_v9_0_use_invalidate_semaphore(adev, vmhub);
-	u32 j, inv_req, tmp, sem, req, ack;
+	u32 j, inv_req, tmp, sem, req, ack, inst;
 	const unsigned int eng = 17;
 	struct amdgpu_vmhub *hub;
 
@@ -832,13 +832,17 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	/* This is necessary for a HW workaround under SRIOV as well
 	 * as GFXOFF under bare metal
 	 */
-	if (adev->gfx.kiq[0].ring.sched.ready &&
+	if (vmhub >= AMDGPU_MMHUB0(0))
+		inst = 0;
+	else
+		inst = vmhub;
+	if (adev->gfx.kiq[inst].ring.sched.ready &&
 	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
 		uint32_t req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
 		uint32_t ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
 
 		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
-						   1 << vmid);
+						   1 << vmid, inst);
 		return;
 	}
 
@@ -856,9 +860,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		for (j = 0; j < adev->usec_timeout; j++) {
 			/* a read return value of 1 means semaphore acquire */
 			if (vmhub >= AMDGPU_MMHUB0(0))
-				tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, sem, 0);
+				tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, sem, inst);
 			else
-				tmp = RREG32_SOC15_IP_NO_KIQ(GC, sem, vmhub);
+				tmp = RREG32_SOC15_IP_NO_KIQ(GC, sem, inst);
 			if (tmp & 0x1)
 				break;
 			udelay(1);
@@ -869,9 +873,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	}
 
 	if (vmhub >= AMDGPU_MMHUB0(0))
-		WREG32_SOC15_IP_NO_KIQ(MMHUB, req, inv_req, 0);
+		WREG32_SOC15_IP_NO_KIQ(MMHUB, req, inv_req, inst);
 	else
-		WREG32_SOC15_IP_NO_KIQ(GC, req, inv_req, vmhub);
+		WREG32_SOC15_IP_NO_KIQ(GC, req, inv_req, inst);
 
 	/*
 	 * Issue a dummy read to wait for the ACK register to
@@ -884,9 +888,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 
 	for (j = 0; j < adev->usec_timeout; j++) {
 		if (vmhub >= AMDGPU_MMHUB0(0))
-			tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, ack, 0);
+			tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, ack, inst);
 		else
-			tmp = RREG32_SOC15_IP_NO_KIQ(GC, ack, vmhub);
+			tmp = RREG32_SOC15_IP_NO_KIQ(GC, ack, inst);
 		if (tmp & (1 << vmid))
 			break;
 		udelay(1);
@@ -899,9 +903,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		 * write with 0 means semaphore release
 		 */
 		if (vmhub >= AMDGPU_MMHUB0(0))
-			WREG32_SOC15_IP_NO_KIQ(MMHUB, sem, 0, 0);
+			WREG32_SOC15_IP_NO_KIQ(MMHUB, sem, 0, inst);
 		else
-			WREG32_SOC15_IP_NO_KIQ(GC, sem, 0, vmhub);
+			WREG32_SOC15_IP_NO_KIQ(GC, sem, 0, inst);
 	}
 
 	spin_unlock(&adev->gmc.invalidate_lock);
-- 
2.34.1

