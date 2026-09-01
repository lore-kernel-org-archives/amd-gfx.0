Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D410C61DD3
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 20:11:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED4E210EEF4;
	Tue,  1 Sep 2026 20:10:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A6tN67Vo";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012013.outbound.protection.outlook.com
 [40.93.195.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3EDE10EECC
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 20:10:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hDX9lLowylAytPxyVqhDd9U9DRz9TMtsQ4GvbvvsIq+tFiOCaQkiLw0D0dgR/8s53k7zHsjo/mB4mtnXVk96D6hPCAyh3IIE5zZDCQTYiOpaX9YWomaV7q9pYKNCMd5wOESOXHjtcjl6vXXag/f6CvKlZfRs/VLMnEtNwVEv1aNoxzDXyJKsG9keEbfsbF0Q9T0ae1eSka3M/APMH5HHaK7p9d3r7PDHd96g1VRYdeDJ7YlqJ6zj5O8ya+1t71gymszfmsPh5F25HVyzrtLOd9boRcOFgdjWoidB2VnXEK5fp4wFZE9y0EaGtMPilXKwcXihPd6tF2iIHCU3iWQmFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwPuxV/NAzzqkyzQefJD5kzPhwGPEwkNAp3+XulnCIM=;
 b=wDIJWCwoI/lQPkjHz2wrh8oDTjLJ30xZUuLaJbt77HU/YTDn9hJznmN7XCFlFttT863S7aKhTJCFKihyW3RmTZULkcyZ4Ia4rTz1guIZB0fXdKAyQQItKARALH6wwcUuleh8tgLgbXUZOAO8GsWlikjVZvhGXUqQ1umt/fX3OpbAR6K32qBTZuppkS+UK1f6jl+aYKz0NU/jrFJHLJD46d8GAVallOxGTOPmH8Jt2DcwahIQjpllj38gH3eR1YmQ5R5j2QGd49kvvbPHgFO4cAGUR61MIyMvdt5zc9H2mo9dz/acbgRTTCAyHkDkReNP/a1haR98dxXkhMXJ/Rp68Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwPuxV/NAzzqkyzQefJD5kzPhwGPEwkNAp3+XulnCIM=;
 b=A6tN67VoDnRwWszNsE1+A/OWJYMf5cOi7Q7sMJDHJm6H1F+/dEc8oJjKVFgm4bHPpWjjRC8drux0Wkn4a25+Ni7yEVZ210Em0/xZjP24fV+FTrpb9/OuhZCFFdo3ocIPn+nIwVLl8q8Es3zydiuN1rsamP7IaxMGOCnAaOFHSLg=
Received: from CH0PR13CA0055.namprd13.prod.outlook.com (2603:10b6:610:b2::30)
 by DS7PR12MB9528.namprd12.prod.outlook.com (2603:10b6:8:252::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 20:10:54 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::44) by CH0PR13CA0055.outlook.office365.com
 (2603:10b6:610:b2::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 20:10:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 20:10:53 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 15:10:51 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 15:10:50 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 1 Sep 2026 15:10:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 06/31] drm/amdgpu: add a gmc flag for using MMIO for TLB flush
Date: Tue, 1 Sep 2026 16:10:09 -0400
Message-ID: <20260901201034.2960437-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901201034.2960437-1-alexander.deucher@amd.com>
References: <20260901201034.2960437-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|DS7PR12MB9528:EE_
X-MS-Office365-Filtering-Correlation-Id: e0d0d59f-2ee1-461a-e0ff-08df0865207f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|6133799003|11063799006|56012099006|10067099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: t53LH7Rn53sfV6/mYyIW6FP18iumVG8C7rp6/z3bLHG6RuVA1kiQhSGsC0kTtCTBcDxv/9X0Qe7fdnytmU92wFoWCzC3AlOxjjQGkwYTDdr11gKLTqZUsmvjAN1gq69cv4Ls+TWkyIaup5RW/NGCa/QPpgdwB8H2HrrufAsiEaK9hXXQDCWp513eHTDs5IImaPyIEBbuadQe2qlwEpLg+uGXjmmlXgPrCUNXm64lAsHoXpJY2AzChxpqFxDNVQKaDCpamakZbUK8rsTskEZ/Qq5IJmEK8V2rf5xF3trTwTSPkDgXEljZvsrEMTvwI0d6ePHDByaH5Ao5ygo/WXJJSbdPyFqBP6FixR/yViPyB9JmZIUuvQrW3vtm8uIsZVSbL7fXGwOwHC9uW2F37AkhOsPKmqYXbQHe5u8iHXdl+jiS77SExXVMyjMfTs1Nyvv+7QKp42e3rXL8l7JhTeTbIveiL5gVf5i/xcFJ73LQoIXppZ8/dAmYTDiEJlWoLRrdN0IvaBHl2Np5VjDTRm9JAJ+GC82/5Ugf3BhyypjLhE02UD3R7KZWY0AJvyf4UTNZ6F3h5xeaZK77KiscZ0HqwRIfGG82UKUzbVS0XUsGo73Elex/uFhenkV7wkqlBJSF4jdbiup1AjtSZvd8oBEbBsi0MJFSN6yef48CdkpPc+pBZgdAP+Nd8IGaugjApdk6Ndqc9M7TKmM11QviXBV+SA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(6133799003)(11063799006)(56012099006)(10067099003)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 28JVkRHllFOpRL6D+2vrnADdXGG8GFJAn8WwZQ5NN8UIR1wvyehIkuttKt+SWmcUzHmkN5Y9ZLWEf+rh7DgwUsIHupPl8SLbGVYnQBPIVjKAt+sREwsJ68oENXzoNiJ3gMqizvLQH0XBjk+9t8x86LbqpBYWzW+Xqqw9V/tJdexlcPMGaJf4tYSXjVSseRs8jLOmQErcMz4uB7mMIcTJex4a9z8zwo7BfbzBjjWX6RRMqQfe/j6UJ8ONeYShKf6dId7xojJAPdoCNJK6dXmba0K9LdWcxTvdkpuEaoPif6BM+og9jwnijeySrK3Xl5AJiCReaKPd3AmGaJcziTX1Lb1W0pfSfeprm+mPSpsD334hM2jvxDtQGNSnfihmRUZ/Seb09HfRCXI9DIYm4VP6NadFPN2Rk4aB2Gs3Np15FJtf9XbPhgkZXA/lUZBlkO7i
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 20:10:53.9430 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d0d59f-2ee1-461a-e0ff-08df0865207f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9528
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No intended functional change.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 2 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c  | 6 +++---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 5 ++++-
 6 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index c0884797dd544..f8f4df37d5805 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -367,6 +367,8 @@ struct amdgpu_gmc {
 	bool flush_pasid_uses_kiq;
 
 	bool override_pte;
+
+	bool use_mmio_for_tlb_flush;
 };
 
 #define amdgpu_gmc_emit_flush_gpu_tlb(r, vmid, addr) (r)->adev->gmc.gmc_funcs->emit_flush_gpu_tlb((r), (vmid), (addr))
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 8d88651b18ef9..7ea1c4b878e97 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -256,7 +256,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	 * properly under bare metal
 	 */
 	if (adev->gfx.kiq[0].ring.sched.ready && !adev->enable_mes &&
-	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
+	    !adev->gmc.use_mmio_for_tlb_flush) {
 		amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
 						 1 << vmid, GET_INST(GC, 0));
 		return;
@@ -883,6 +883,9 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	adev->gmc.use_mmio_for_tlb_flush =
+		!(amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev));
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 41ebc6ae182cc..fc730504be5f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -244,7 +244,7 @@ static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	 * properly under bare metal
 	 */
 	if ((adev->gfx.kiq[0].ring.sched.ready || adev->mes.ring[0].sched.ready) &&
-	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
+	    !adev->gmc.use_mmio_for_tlb_flush) {
 		amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
 						 1 << vmid, GET_INST(GC, 0));
 		return;
@@ -865,6 +865,9 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	adev->gmc.use_mmio_for_tlb_flush =
+		!(amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev));
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 3b7764b94de19..3b1fe15fa1c01 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -315,7 +315,7 @@ static void gmc_v12_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	 * properly under bare metal
 	 */
 	if ((adev->gfx.kiq[0].ring.sched.ready || adev->mes.ring[0].sched.ready) &&
-	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
+	    !adev->gmc.use_mmio_for_tlb_flush) {
 		struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
 		const unsigned eng = 17;
 		u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
@@ -968,6 +968,9 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	adev->gmc.use_mmio_for_tlb_flush =
+		!(amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev));
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index 5fe43f7eab29d..6c0d2689cc05d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -375,9 +375,9 @@ static void gmc_v12_1_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	/* This is necessary for SRIOV as well as for GFXOFF to function
 	 * properly under bare metal
 	 */
-	if (((adev->gfx.kiq[inst].ring.sched.ready ||
-	      adev->mes.ring[MES_PIPE_INST(inst, 0)].sched.ready) &&
-	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)))) {
+	if ((adev->gfx.kiq[inst].ring.sched.ready ||
+	     adev->mes.ring[MES_PIPE_INST(inst, 0)].sched.ready) &&
+	    !adev->gmc.use_mmio_for_tlb_flush) {
 		struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
 		const unsigned eng = 17;
 		u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 73b96efd45484..23de2caf13646 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -780,7 +780,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	 * properly under bare metal
 	 */
 	if (adev->gfx.kiq[inst].ring.sched.ready &&
-	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
+	    !adev->gmc.use_mmio_for_tlb_flush) {
 		uint32_t req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
 		uint32_t ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
 
@@ -2037,6 +2037,9 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_is_multi_aid(adev))
 		amdgpu_gmc_sysfs_init(adev);
 
+	adev->gmc.use_mmio_for_tlb_flush =
+		!(amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev));
+
 	return 0;
 }
 
-- 
2.55.0

