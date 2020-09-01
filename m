Return-Path: <SRS0=dANk=CK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5E9C433E2
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 01:18:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA5492073A
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 01:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IfP5H1aN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA5492073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 853216E563;
	Tue,  1 Sep 2020 01:18:04 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10EFB6E560
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2020 01:18:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jSsMtXflOUssVvaSE52HFmrGiXXJz3AQCUpn6ffg2aWBrO0TP5i/joaCu/rBeYADthmIjfgP/lmCSZH2YDDCLSHDQnr8SlU6TUdSV9gWDf2S/mtn8bOsQAfuyqlAwfr3Ivvv3FI8KWOFEn6eXnYWi0R6iO/zXZKzSxakxTTQ4u4asxVcLxzJURho4ju49VwLRB7FsUyJnaDzK6NKfVqNX/ywAiDtKDYaSB87hAeNanqfcOwvFHrFuM6JnYDVmVofSJK3Yj0oEQmswHOpBQB4wmdT1DAtSkISJeEzc3LJmUjTEWaInHb8rVA+LFQHReBzM3dZptzKy29M85FpNTNU9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTSVa4E+BKydg58zZQT30gQCF7pkSKDqWdZQQOh/xy0=;
 b=d+2XXOiERdXoUcqwYgwHaDnSWJXl4U1sLXiubw0O0lfJ0N0SVJDqh1vETfdR4ctIxsSbwqvhGq1Ld0mBVxJH19TOAOZfZitfxgiWNt/CITUjPw63NgTsi1/JhOLa8WbQcuIeRM6Hi4YaAF5BJRyqt8x6rWDdW4ZLPLU+EorGQ9BZ9zPlSMhI5AiWKax9iJFb7Sma1xq+Y1QVfQehDxETYRcoYCObpMM+kHqC2riVA6QzzdcPTivdNkNCPFzXh1GYHbFVMHAgCYzHtY8J87oyFGcrv73FsRs55s1TvkHhhJO7jy7CJgJmq+V3zugBGoOo+pRaKvPUMWumvOpy/0lJow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTSVa4E+BKydg58zZQT30gQCF7pkSKDqWdZQQOh/xy0=;
 b=IfP5H1aNAXm6D7cvNXioxF4nTeL0ycG0aDGpNDF9ok1vlOaf/LaFaI8evgRWWdr5lbayzKKLY69ubpyf1cgyIgaO/lS9XIZGNRFlXO4hMgCDJkcd/f0NjQ6Rh2GG1+Z1C54bkzAJDM7rW51yYDgR0Y3n1ZFK9GFScAZmlV2Y0b0=
Received: from BN6PR02CA0043.namprd02.prod.outlook.com (2603:10b6:404:5f::29)
 by MWHPR12MB1824.namprd12.prod.outlook.com (2603:10b6:300:113::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Tue, 1 Sep
 2020 01:17:55 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:5f:cafe::cf) by BN6PR02CA0043.outlook.office365.com
 (2603:10b6:404:5f::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Tue, 1 Sep 2020 01:17:54 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Tue, 1 Sep 2020 01:17:54 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 31 Aug
 2020 20:17:54 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 31 Aug
 2020 20:17:53 -0500
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Mon, 31 Aug 2020 20:17:52 -0500
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <felix.kuehling@amd.com>, <Hawking.Zhang@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: block ring buffer access during GPU recovery
Date: Tue, 1 Sep 2020 09:17:27 +0800
Message-ID: <20200901011727.14059-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31646e25-1620-45c7-52c1-08d84e14da98
X-MS-TrafficTypeDiagnostic: MWHPR12MB1824:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1824008E73FD2F09954BD17CED2E0@MWHPR12MB1824.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rhfVyF5KVAyP7ShSlbVvLYo038o67O2XhUa2rrQbhwCldUDYPP29K2SG8DGiu81Ao9V/XztI42NvO7ADQ8ZWv7vHNdC5MexeAn8xSbFwNiL9WFtGhzQKCzFxvLLJ94TsxYMag9z0RpUND7J8/nemjguknf5xN9f5xn1h8Dz1dGVSpYTIkqmAvm9ts2DUUhWDjRWAb5NMXCP4V+YJd8PUqy6/n8qwBq0tEaUD0iim/fw2uir311ADyJkW5ksT90fJ5uwzt8Kdw5VlO4XXmPXKs8w3+/XMChfZ6BxR4yt0ghxCRId3Y7T1NpnLSRB3iGClvEwo29dbNSVd2u1eqtW6cSmVO3B3T5Iah0FFBiIi9oP796ATGRA9omycpr0CVpwr1bAxoNa2wWAEWkyoMaFstmTXyi2ZTWZwhGoR53TKDXc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(346002)(396003)(46966005)(7696005)(426003)(186003)(110136005)(86362001)(70206006)(2616005)(26005)(70586007)(6636002)(336012)(316002)(8936002)(36756003)(2906002)(5660300002)(8676002)(82740400003)(478600001)(6666004)(1076003)(4326008)(83380400001)(356005)(81166007)(82310400003)(47076004)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2020 01:17:54.6223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31646e25-1620-45c7-52c1-08d84e14da98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1824
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
Cc: Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When GPU is in reset, its status isn't stable and ring buffer also need
be reset when resuming. Therefore driver should protect GPU recovery
thread from ring buffer accessed by other threads. Otherwise GPU will
randomly hang during recovery.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 172dc47b7f39..8db56a22cd1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -319,8 +319,13 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
 {
 	uint32_t ret;
 
-	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
-		return amdgpu_kiq_rreg(adev, reg);
+	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
+		amdgpu_sriov_runtime(adev) &&
+		down_read_trylock(&adev->reset_sem)) {
+		ret = amdgpu_kiq_rreg(adev, reg);
+		up_read(&adev->reset_sem);
+		return ret;
+	}
 
 	if ((reg * 4) < adev->rmmio_size)
 		ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
@@ -332,6 +337,7 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
 		ret = readl(((void __iomem *)adev->rmmio) + (mmMM_DATA * 4));
 		spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
 	}
+
 	trace_amdgpu_mm_rreg(adev->pdev->device, reg, ret);
 	return ret;
 }
@@ -407,8 +413,13 @@ void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg,
 void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
 		    uint32_t acc_flags)
 {
-	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
-		return amdgpu_kiq_wreg(adev, reg, v);
+	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
+		amdgpu_sriov_runtime(adev) &&
+		down_read_trylock(&adev->reset_sem)) {
+		amdgpu_kiq_wreg(adev, reg, v);
+		up_read(&adev->reset_sem);
+		return;
+	}
 
 	amdgpu_mm_wreg_mmio(adev, reg, v, acc_flags);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index ad9ad622ccce..4ea2a065daa9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -287,7 +287,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	 */
 	if (adev->gfx.kiq.ring.sched.ready &&
 	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) &&
-	    !amdgpu_in_reset(adev)) {
+	    down_read_trylock(&adev->reset_sem)) {
 
 		struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
 		const unsigned eng = 17;
@@ -297,6 +297,8 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 
 		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
 				1 << vmid);
+
+		up_read(&adev->reset_sem);
 		return;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index e1a0ae327cf5..33b7cf1c79ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -501,12 +501,13 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	 */
 	if (adev->gfx.kiq.ring.sched.ready &&
 			(amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) &&
-			!amdgpu_in_reset(adev)) {
+			down_read_trylock(&adev->reset_sem)) {
 		uint32_t req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
 		uint32_t ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
 
 		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
 						   1 << vmid);
+		up_read(&adev->reset_sem);
 		return;
 	}
 
@@ -599,7 +600,8 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	if (amdgpu_in_reset(adev))
 		return -EIO;
 
-	if (ring->sched.ready) {
+	if (ring->sched.ready &&
+		 down_read_trylock(&adev->reset_sem)) {
 		/* Vega20+XGMI caches PTEs in TC and TLB. Add a
 		 * heavy-weight TLB flush (type 2), which flushes
 		 * both. Due to a race condition with concurrent
@@ -626,6 +628,7 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 		if (r) {
 			amdgpu_ring_undo(ring);
 			spin_unlock(&adev->gfx.kiq.ring_lock);
+			up_read(&adev->reset_sem);
 			return -ETIME;
 		}
 
@@ -634,9 +637,10 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 		r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
 		if (r < 1) {
 			dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
+			up_read(&adev->reset_sem);
 			return -ETIME;
 		}
-
+		up_read(&adev->reset_sem);
 		return 0;
 	}
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
