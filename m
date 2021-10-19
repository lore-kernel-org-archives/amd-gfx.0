Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9494FC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 21:15:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E6C560F8F
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 21:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5E6C560F8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F24976EB6E;
	Tue, 19 Oct 2021 21:15:07 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2065.outbound.protection.outlook.com [40.107.100.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D16B46E8E5
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 21:15:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZAfepUaQLpUHdBT11hmCAYiD5YjJXfJl1PKA0Da35P3NhwRbhoNBeC6bmQXVvMu+HJSDK1ikuz9NPn0hm5RXspEhK/GkqUeYkB/Z5wQIFe+sKzF85r4mRk8uJWaN7GswY1eKlTYY5x4YoKk5X1XDMwYUOU3MeVwHfiz9jNmcO17M2qoUEpfnzj0uNdKv03RGVlWlvC+QeKYFqyyVWrYCXugQbKYEx7z31yuP5NdtzhBe/zCDesuLGM7DWvV0S/HU6v0j/0WtXgjDjI4WgvkqXI4Yf39hk5CKBDy4cegm6v8609ENRHEDYC3KIdOB8oxAALEbqzbgVheFSTVwdugxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VCBeYdLqSHjC5w6cB8bjNeJFRWBdKXGQZWX5hdis/qk=;
 b=Rk8fSLWpJygV3w8+VITA1wC838ydoRQSh9b0xfQUpFKX1Vz+kOPe2SJsUKl9QAfBxDkvcUv7WTwY6VQOBqP2pLYneZ86XeCNkf83qVcEb205kL6iObMvlC/kXU5y4rlhgvdFpS2XSVTUvH6PZTYsk9mGsEFT9QYSoAQbTXOJLSqbcF4o1EKg8NV/7/N0R75Yo6Mi3a9lqV1fpYTx34z/TtUHUxXd2CMdRFOCzUPPZOS+z9L6CNzrb5HuIgOWyzGRadqfP59cNJYZbx2IR94s6L/CR0qXKpRGBLh+gYMBa2MsMBURiQ2on3Ah3IpgcKFR2AQwcRYsRaYkDJ+edowsDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCBeYdLqSHjC5w6cB8bjNeJFRWBdKXGQZWX5hdis/qk=;
 b=uF5c1DgYr8hr84iDB+z1J2fC3xm4V+TXGqGC5Nyfzz9OtYCn981teJ+Dg9az8N/gzQHX3S1F/xbz2rUECCPXC4A2LZP9PPOLadAXFAIhb4ipFlXlHx6LM1sHQm+BxknxkaJBaW99SrXUNiYoJ/CzK/lHadD8h6lNm4rllpslKn0=
Received: from BN9PR03CA0303.namprd03.prod.outlook.com (2603:10b6:408:112::8)
 by CY4PR12MB1734.namprd12.prod.outlook.com (2603:10b6:903:121::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Tue, 19 Oct
 2021 21:15:01 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::63) by BN9PR03CA0303.outlook.office365.com
 (2603:10b6:408:112::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Tue, 19 Oct 2021 21:15:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 21:15:00 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 19 Oct
 2021 16:14:58 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <mukul.joshi@amd.com>, Graham Sider
 <Graham.Sider@amd.com>
Subject: [PATCH 09/13] drm/amdkfd: replace kgd_dev in various amgpu_amdkfd
 funcs
Date: Tue, 19 Oct 2021 17:13:30 -0400
Message-ID: <20211019211334.1552825-9-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211019211334.1552825-1-Graham.Sider@amd.com>
References: <20211019211334.1552825-1-Graham.Sider@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b9d8640-c2c3-4c29-3bdb-08d9934582e5
X-MS-TrafficTypeDiagnostic: CY4PR12MB1734:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1734E9742327512B1D1CDEAD8ABD9@CY4PR12MB1734.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:241;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j597JXsCcDPlMM7jiA8xVkLhWCsT0hxg9fE+lR3qztgS8wljPFtKsXlT6hbZrW4lDqLpsV+tZCU7JaMZn/ZBrAszCjglct9gaSxxpDCcuh9g0VHL7qwExArRrLl9ZxcEe8CSLzHbChWUxua6egXWGlGjG+3VBLzwh/Eyla3slXoLvPrvI4Jr2NEdC93LHPzSf9t2+ewuoOB+c7NxI0znErEuqDyVT5K0T5aGI8nNF7tdQrV5x6y1/X5/WvsALa/SLF22RGgGVkq/H/xhGXqSjNKweLBppTXAiMsF9JLxpUpiKTHF5dQyqtw4FQfBCfuqhN35mirGfbWGW+eYXPLqnpVGfoQImoJgXzNZMH6ZxhwuPV6xiirt/GKJSpFtwiRSC60i0I8MhyMKAZNnVR4BRyJ1Q9iDXI+jiyhq9E5S9wSKIPHwTHTtLAxPJprmnMRRH/hFO7Z/2raHRKNY5QiIfkV+Q5nj6E4du0s5dn0kAMPJzMhV3w40uAg3CJrhyFpwooWIGkS24z2alk5j2WTeQX2K0+SaUCQmuRlv7ZWtlnxggbn+UmQuWV2qeWois/DS6t19A4awD3Vca4897B+sXTz7FtaU3Tso2wo2RFbdrKwuhr5X9G+2FxrHBF6bGFEhAqFMdTMP0guiM+VMp+rAW5ztOqCXF5XrTG+TPI/grZUOfDwYYcLtzW5mdvA/moz+ImiGspzT4z/1sFHzNJzZkTgIFCYrczY8zBAgAVYTwtw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(6916009)(86362001)(5660300002)(1076003)(70586007)(47076005)(2906002)(336012)(316002)(36756003)(426003)(83380400001)(4326008)(8936002)(70206006)(81166007)(7696005)(2616005)(82310400003)(508600001)(30864003)(26005)(54906003)(186003)(36860700001)(8676002)(16526019)(6666004)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 21:15:00.7273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9d8640-c2c3-4c29-3bdb-08d9934582e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1734
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

Modified definitions:

- amdgpu_amdkfd_submit_ib
- amdgpu_amdkfd_set_compute_idle
- amdgpu_amdkfd_have_atomics_support
- amdgpu_amdkfd_flush_gpu_tlb_pasid
- amdgpu_amdkfd_flush_gpu_tlb_pasid
- amdgpu_amdkfd_gpu_reset
- amdgpu_amdkfd_alloc_gtt_mem
- amdgpu_amdkfd_free_gtt_mem
- amdgpu_amdkfd_alloc_gws
- amdgpu_amdkfd_free_gws
- amdgpu_amdkfd_ras_poison_consumption_handler

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    | 41 +++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    | 27 ++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 18 ++++----
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  8 ++--
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   |  4 +-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          | 10 ++---
 8 files changed, 53 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 7077f21f0021..69fc8f0d9c45 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -233,19 +233,16 @@ int amdgpu_amdkfd_post_reset(struct amdgpu_device *adev)
 	return r;
 }
 
-void amdgpu_amdkfd_gpu_reset(struct kgd_dev *kgd)
+void amdgpu_amdkfd_gpu_reset(struct amdgpu_device *adev)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
-
 	if (amdgpu_device_should_recover_gpu(adev))
 		amdgpu_device_gpu_recover(adev, NULL);
 }
 
-int amdgpu_amdkfd_alloc_gtt_mem(struct kgd_dev *kgd, size_t size,
+int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
 				void **mem_obj, uint64_t *gpu_addr,
 				void **cpu_ptr, bool cp_mqd_gfx9)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
 	struct amdgpu_bo *bo = NULL;
 	struct amdgpu_bo_param bp;
 	int r;
@@ -314,7 +311,7 @@ int amdgpu_amdkfd_alloc_gtt_mem(struct kgd_dev *kgd, size_t size,
 	return r;
 }
 
-void amdgpu_amdkfd_free_gtt_mem(struct kgd_dev *kgd, void *mem_obj)
+void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void *mem_obj)
 {
 	struct amdgpu_bo *bo = (struct amdgpu_bo *) mem_obj;
 
@@ -325,10 +322,9 @@ void amdgpu_amdkfd_free_gtt_mem(struct kgd_dev *kgd, void *mem_obj)
 	amdgpu_bo_unref(&(bo));
 }
 
-int amdgpu_amdkfd_alloc_gws(struct kgd_dev *kgd, size_t size,
+int amdgpu_amdkfd_alloc_gws(struct amdgpu_device *adev, size_t size,
 				void **mem_obj)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
 	struct amdgpu_bo *bo = NULL;
 	struct amdgpu_bo_user *ubo;
 	struct amdgpu_bo_param bp;
@@ -355,7 +351,7 @@ int amdgpu_amdkfd_alloc_gws(struct kgd_dev *kgd, size_t size,
 	return 0;
 }
 
-void amdgpu_amdkfd_free_gws(struct kgd_dev *kgd, void *mem_obj)
+void amdgpu_amdkfd_free_gws(struct amdgpu_device *adev, void *mem_obj)
 {
 	struct amdgpu_bo *bo = (struct amdgpu_bo *)mem_obj;
 
@@ -675,11 +671,11 @@ int amdgpu_amdkfd_get_noretry(struct kgd_dev *kgd)
 	return adev->gmc.noretry;
 }
 
-int amdgpu_amdkfd_submit_ib(struct kgd_dev *kgd, enum kgd_engine_type engine,
+int amdgpu_amdkfd_submit_ib(struct amdgpu_device *adev,
+				enum kgd_engine_type engine,
 				uint32_t vmid, uint64_t gpu_addr,
 				uint32_t *ib_cmd, uint32_t ib_len)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
 	struct amdgpu_ring *ring;
@@ -730,10 +726,8 @@ int amdgpu_amdkfd_submit_ib(struct kgd_dev *kgd, enum kgd_engine_type engine,
 	return ret;
 }
 
-void amdgpu_amdkfd_set_compute_idle(struct kgd_dev *kgd, bool idle)
+void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
-
 	amdgpu_dpm_switch_power_profile(adev,
 					PP_SMC_POWER_PROFILE_COMPUTE,
 					!idle);
@@ -747,10 +741,9 @@ bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid)
 	return false;
 }
 
-int amdgpu_amdkfd_flush_gpu_tlb_vmid(struct kgd_dev *kgd, uint16_t vmid)
+int amdgpu_amdkfd_flush_gpu_tlb_vmid(struct amdgpu_device *adev,
+				     uint16_t vmid)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
-
 	if (adev->family == AMDGPU_FAMILY_AI) {
 		int i;
 
@@ -763,10 +756,9 @@ int amdgpu_amdkfd_flush_gpu_tlb_vmid(struct kgd_dev *kgd, uint16_t vmid)
 	return 0;
 }
 
-int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct kgd_dev *kgd, uint16_t pasid,
-				      enum TLB_FLUSH_TYPE flush_type)
+int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
+				      uint16_t pasid, enum TLB_FLUSH_TYPE flush_type)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
 	bool all_hub = false;
 
 	if (adev->family == AMDGPU_FAMILY_AI)
@@ -775,21 +767,18 @@ int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct kgd_dev *kgd, uint16_t pasid,
 	return amdgpu_gmc_flush_gpu_tlb_pasid(adev, pasid, flush_type, all_hub);
 }
 
-bool amdgpu_amdkfd_have_atomics_support(struct kgd_dev *kgd)
+bool amdgpu_amdkfd_have_atomics_support(struct amdgpu_device *adev)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
-
 	return adev->have_atomics_support;
 }
 
-void amdgpu_amdkfd_ras_poison_consumption_handler(struct kgd_dev *kgd)
+void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
 	struct ras_err_data err_data = {0, 0, 0, NULL};
 
 	/* CPU MCA will handle page retirement if connected_to_cpu is 1 */
 	if (!adev->gmc.xgmi.connected_to_cpu)
 		amdgpu_umc_process_ras_data_cb(adev, &err_data, NULL);
 	else
-		amdgpu_amdkfd_gpu_reset(kgd);
+		amdgpu_amdkfd_gpu_reset(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 69de31754907..8d5c18953723 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -144,14 +144,16 @@ void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
 void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev);
 void amdgpu_amdkfd_device_init(struct amdgpu_device *adev);
 void amdgpu_amdkfd_device_fini_sw(struct amdgpu_device *adev);
-int amdgpu_amdkfd_submit_ib(struct kgd_dev *kgd, enum kgd_engine_type engine,
+int amdgpu_amdkfd_submit_ib(struct amdgpu_device *adev,
+				enum kgd_engine_type engine,
 				uint32_t vmid, uint64_t gpu_addr,
 				uint32_t *ib_cmd, uint32_t ib_len);
-void amdgpu_amdkfd_set_compute_idle(struct kgd_dev *kgd, bool idle);
-bool amdgpu_amdkfd_have_atomics_support(struct kgd_dev *kgd);
-int amdgpu_amdkfd_flush_gpu_tlb_vmid(struct kgd_dev *kgd, uint16_t vmid);
-int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct kgd_dev *kgd, uint16_t pasid,
-				      enum TLB_FLUSH_TYPE flush_type);
+void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle);
+bool amdgpu_amdkfd_have_atomics_support(struct amdgpu_device *adev);
+int amdgpu_amdkfd_flush_gpu_tlb_vmid(struct amdgpu_device *adev,
+				uint16_t vmid);
+int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
+				uint16_t pasid, enum TLB_FLUSH_TYPE flush_type);
 
 bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid);
 
@@ -159,7 +161,7 @@ int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev);
 
 int amdgpu_amdkfd_post_reset(struct amdgpu_device *adev);
 
-void amdgpu_amdkfd_gpu_reset(struct kgd_dev *kgd);
+void amdgpu_amdkfd_gpu_reset(struct amdgpu_device *adev);
 
 int amdgpu_queue_mask_bit_to_set_resource_bit(struct amdgpu_device *adev,
 					int queue_bit);
@@ -198,12 +200,13 @@ int amdgpu_amdkfd_evict_userptr(struct kgd_mem *mem, struct mm_struct *mm)
 }
 #endif
 /* Shared API */
-int amdgpu_amdkfd_alloc_gtt_mem(struct kgd_dev *kgd, size_t size,
+int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
 				void **mem_obj, uint64_t *gpu_addr,
 				void **cpu_ptr, bool mqd_gfx9);
-void amdgpu_amdkfd_free_gtt_mem(struct kgd_dev *kgd, void *mem_obj);
-int amdgpu_amdkfd_alloc_gws(struct kgd_dev *kgd, size_t size, void **mem_obj);
-void amdgpu_amdkfd_free_gws(struct kgd_dev *kgd, void *mem_obj);
+void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void *mem_obj);
+int amdgpu_amdkfd_alloc_gws(struct amdgpu_device *adev, size_t size,
+				void **mem_obj);
+void amdgpu_amdkfd_free_gws(struct amdgpu_device *adev, void *mem_obj);
 int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem);
 int amdgpu_amdkfd_remove_gws_from_process(void *info, void *mem);
 uint32_t amdgpu_amdkfd_get_fw_version(struct kgd_dev *kgd,
@@ -290,7 +293,7 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct kgd_dev *kgd,
 				      uint64_t *mmap_offset);
 int amdgpu_amdkfd_get_tile_config(struct kgd_dev *kgd,
 				struct tile_config *config);
-void amdgpu_amdkfd_ras_poison_consumption_handler(struct kgd_dev *kgd);
+void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev);
 #if IS_ENABLED(CONFIG_HSA_AMD)
 void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
 void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 81ca00d7b3da..a90ec8de213b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -893,7 +893,7 @@ static int kfd_gws_init(struct kfd_dev *kfd)
 			&& kfd->mec2_fw_version >= 0x30)
 		|| (kfd->device_info->asic_family == CHIP_ALDEBARAN
 			&& kfd->mec2_fw_version >= 0x28))
-		ret = amdgpu_amdkfd_alloc_gws(kfd->kgd,
+		ret = amdgpu_amdkfd_alloc_gws(kfd->adev,
 				amdgpu_amdkfd_get_num_gws(kfd->kgd), &kfd->gws);
 
 	return ret;
@@ -928,7 +928,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	 * 32 and 64-bit requests are possible and must be
 	 * supported.
 	 */
-	kfd->pci_atomic_requested = amdgpu_amdkfd_have_atomics_support(kfd->kgd);
+	kfd->pci_atomic_requested = amdgpu_amdkfd_have_atomics_support(kfd->adev);
 	if (!kfd->pci_atomic_requested &&
 	    kfd->device_info->needs_pci_atomics &&
 	    (!kfd->device_info->no_atomic_fw_version ||
@@ -975,7 +975,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	size += 512 * 1024;
 
 	if (amdgpu_amdkfd_alloc_gtt_mem(
-			kfd->kgd, size, &kfd->gtt_mem,
+			kfd->adev, size, &kfd->gtt_mem,
 			&kfd->gtt_start_gpu_addr, &kfd->gtt_start_cpu_ptr,
 			false)) {
 		dev_err(kfd_device, "Could not allocate %d bytes\n", size);
@@ -1069,10 +1069,10 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 kfd_doorbell_error:
 	kfd_gtt_sa_fini(kfd);
 kfd_gtt_sa_init_error:
-	amdgpu_amdkfd_free_gtt_mem(kfd->kgd, kfd->gtt_mem);
+	amdgpu_amdkfd_free_gtt_mem(kfd->adev, kfd->gtt_mem);
 alloc_gtt_mem_failure:
 	if (kfd->gws)
-		amdgpu_amdkfd_free_gws(kfd->kgd, kfd->gws);
+		amdgpu_amdkfd_free_gws(kfd->adev, kfd->gws);
 	dev_err(kfd_device,
 		"device %x:%x NOT added due to errors\n",
 		kfd->pdev->vendor, kfd->pdev->device);
@@ -1089,9 +1089,9 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
 		kfd_doorbell_fini(kfd);
 		ida_destroy(&kfd->doorbell_ida);
 		kfd_gtt_sa_fini(kfd);
-		amdgpu_amdkfd_free_gtt_mem(kfd->kgd, kfd->gtt_mem);
+		amdgpu_amdkfd_free_gtt_mem(kfd->adev, kfd->gtt_mem);
 		if (kfd->gws)
-			amdgpu_amdkfd_free_gws(kfd->kgd, kfd->gws);
+			amdgpu_amdkfd_free_gws(kfd->adev, kfd->gws);
 	}
 
 	kfree(kfd);
@@ -1527,7 +1527,7 @@ void kgd2kfd_set_sram_ecc_flag(struct kfd_dev *kfd)
 void kfd_inc_compute_active(struct kfd_dev *kfd)
 {
 	if (atomic_inc_return(&kfd->compute_profile) == 1)
-		amdgpu_amdkfd_set_compute_idle(kfd->kgd, false);
+		amdgpu_amdkfd_set_compute_idle(kfd->adev, false);
 }
 
 void kfd_dec_compute_active(struct kfd_dev *kfd)
@@ -1535,7 +1535,7 @@ void kfd_dec_compute_active(struct kfd_dev *kfd)
 	int count = atomic_dec_return(&kfd->compute_profile);
 
 	if (count == 0)
-		amdgpu_amdkfd_set_compute_idle(kfd->kgd, true);
+		amdgpu_amdkfd_set_compute_idle(kfd->adev, true);
 	WARN_ONCE(count < 0, "Compute profile ref. count error");
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 9cdf3fb8c58e..330fbbb15d83 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -283,7 +283,7 @@ static int flush_texture_cache_nocpsch(struct kfd_dev *kdev,
 	if (ret)
 		return ret;
 
-	return amdgpu_amdkfd_submit_ib(kdev->kgd, KGD_ENGINE_MEC1, qpd->vmid,
+	return amdgpu_amdkfd_submit_ib(kdev->adev, KGD_ENGINE_MEC1, qpd->vmid,
 				qpd->ib_base, (uint32_t *)qpd->ib_kaddr,
 				pmf->release_mem_size / sizeof(uint32_t));
 }
@@ -1844,7 +1844,7 @@ static int allocate_hiq_sdma_mqd(struct device_queue_manager *dqm)
 		dev->device_info->num_sdma_queues_per_engine +
 		dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ]->mqd_size;
 
-	retval = amdgpu_amdkfd_alloc_gtt_mem(dev->kgd, size,
+	retval = amdgpu_amdkfd_alloc_gtt_mem(dev->adev, size,
 		&(mem_obj->gtt_mem), &(mem_obj->gpu_addr),
 		(void *)&(mem_obj->cpu_ptr), false);
 
@@ -1994,7 +1994,7 @@ static void deallocate_hiq_sdma_mqd(struct kfd_dev *dev,
 {
 	WARN(!mqd, "No hiq sdma mqd trunk to free");
 
-	amdgpu_amdkfd_free_gtt_mem(dev->kgd, mqd->gtt_mem);
+	amdgpu_amdkfd_free_gtt_mem(dev->adev, mqd->gtt_mem);
 }
 
 void device_queue_manager_uninit(struct device_queue_manager *dqm)
@@ -2025,7 +2025,7 @@ static void kfd_process_hw_exception(struct work_struct *work)
 {
 	struct device_queue_manager *dqm = container_of(work,
 			struct device_queue_manager, hw_exception_work);
-	amdgpu_amdkfd_gpu_reset(dqm->dev->kgd);
+	amdgpu_amdkfd_gpu_reset(dqm->dev->adev);
 }
 
 #if defined(CONFIG_DEBUG_FS)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 543e7ea75593..20512a4e9a91 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -231,7 +231,7 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 				if (sq_intr_err != SQ_INTERRUPT_ERROR_TYPE_ILLEGAL_INST &&
 					sq_intr_err != SQ_INTERRUPT_ERROR_TYPE_MEMVIOL) {
 					kfd_signal_poison_consumed_event(dev, pasid);
-					amdgpu_amdkfd_ras_poison_consumption_handler(dev->kgd);
+					amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev);
 					return;
 				}
 				break;
@@ -253,7 +253,7 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 			kfd_signal_event_interrupt(pasid, context_id0 & 0xfffffff, 28);
 		} else if (source_id == SOC15_INTSRC_SDMA_ECC) {
 			kfd_signal_poison_consumed_event(dev, pasid);
-			amdgpu_amdkfd_ras_poison_consumption_handler(dev->kgd);
+			amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev);
 			return;
 		}
 	} else if (client_id == SOC15_IH_CLIENTID_VMC ||
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 643d3eb18ebc..3a5e484a4192 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -107,7 +107,7 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_dev *kfd,
 		mqd_mem_obj = kzalloc(sizeof(struct kfd_mem_obj), GFP_KERNEL);
 		if (!mqd_mem_obj)
 			return NULL;
-		retval = amdgpu_amdkfd_alloc_gtt_mem(kfd->kgd,
+		retval = amdgpu_amdkfd_alloc_gtt_mem(kfd->adev,
 			ALIGN(q->ctl_stack_size, PAGE_SIZE) +
 				ALIGN(sizeof(struct v9_mqd), PAGE_SIZE),
 			&(mqd_mem_obj->gtt_mem),
@@ -299,7 +299,7 @@ static void free_mqd(struct mqd_manager *mm, void *mqd,
 	struct kfd_dev *kfd = mm->dev;
 
 	if (mqd_mem_obj->gtt_mem) {
-		amdgpu_amdkfd_free_gtt_mem(kfd->kgd, mqd_mem_obj->gtt_mem);
+		amdgpu_amdkfd_free_gtt_mem(kfd->adev, mqd_mem_obj->gtt_mem);
 		kfree(mqd_mem_obj);
 	} else {
 		kfd_gtt_sa_free(mm->dev, mqd_mem_obj);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 8b3dc6462405..704f07be2b3f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1896,10 +1896,10 @@ void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type)
 		 * only happens when the first queue is created.
 		 */
 		if (pdd->qpd.vmid)
-			amdgpu_amdkfd_flush_gpu_tlb_vmid(dev->kgd,
+			amdgpu_amdkfd_flush_gpu_tlb_vmid(dev->adev,
 							pdd->qpd.vmid);
 	} else {
-		amdgpu_amdkfd_flush_gpu_tlb_pasid(dev->kgd,
+		amdgpu_amdkfd_flush_gpu_tlb_pasid(dev->adev,
 					pdd->process->pasid, type);
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index b691c8495d66..5b67b14fd8be 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1129,7 +1129,6 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
 	DECLARE_BITMAP(bitmap, MAX_GPU_INSTANCE);
 	struct kfd_process_device *pdd;
 	struct dma_fence *fence = NULL;
-	struct amdgpu_device *adev;
 	struct kfd_process *p;
 	uint32_t gpuidx;
 	int r = 0;
@@ -1145,9 +1144,9 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
 			pr_debug("failed to find device idx %d\n", gpuidx);
 			return -EINVAL;
 		}
-		adev = (struct amdgpu_device *)pdd->dev->kgd;
 
-		r = svm_range_unmap_from_gpu(adev, drm_priv_to_vm(pdd->drm_priv),
+		r = svm_range_unmap_from_gpu(pdd->dev->adev,
+					     drm_priv_to_vm(pdd->drm_priv),
 					     start, last, &fence);
 		if (r)
 			break;
@@ -1159,7 +1158,7 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
 			if (r)
 				break;
 		}
-		amdgpu_amdkfd_flush_gpu_tlb_pasid((struct kgd_dev *)adev,
+		amdgpu_amdkfd_flush_gpu_tlb_pasid(pdd->dev->adev,
 					p->pasid, TLB_FLUSH_HEAVYWEIGHT);
 	}
 
@@ -1243,8 +1242,7 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		struct kfd_process *p;
 
 		p = container_of(prange->svms, struct kfd_process, svms);
-		amdgpu_amdkfd_flush_gpu_tlb_pasid((struct kgd_dev *)adev,
-						p->pasid, TLB_FLUSH_LEGACY);
+		amdgpu_amdkfd_flush_gpu_tlb_pasid(adev, p->pasid, TLB_FLUSH_LEGACY);
 	}
 out:
 	return r;
-- 
2.25.1

