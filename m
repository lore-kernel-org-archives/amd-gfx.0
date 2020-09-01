Return-Path: <SRS0=dANk=CK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14A0C433E2
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 07:50:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 988332071B
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 07:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="N/9/YUMb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 988332071B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4247B6E429;
	Tue,  1 Sep 2020 07:50:47 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760053.outbound.protection.outlook.com [40.107.76.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 450AF6E429
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2020 07:50:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bH12WgJcQp0zdbe0OY92xFFiP113s+m7XVmVVo/bTI0lgpklGcEj58tbb7W7WUM44OWlZdyzwIM1SWzcfHXgvTGNQGADRoKrvW2bjwxD5oS5PQwsMuvaE+UE4B2xNKbpJpWlP/enr6wDX/xdRDV3mkGEcu0Xv9mTvVzVV7cn+Ol+FTSK9+LUa2gcpFkqTB8OIYHYSDIEcJJLxLJ/J1uFmS+lL8bnznsgFEB0DmHBjtH2sOpy2KAjEkn8OwFltOz4j6E2Xc1lnCjos9t79l2t8deCEo/mwCTqQC1GVa8OzOXY4uAltlYDGjLF4i/xcDef5id4lDeznFgdjEvsXGddUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qe0xRpvVozurAHV5aoubCsu17m3IAEvzXvDmuyq+Wv4=;
 b=lmek9wVH1abFBOsIsXks5thotYdBDfSr37paSPrHe69BadinnimpTORyr77mIxm3XlghWMhiPl2E42lA0AmMldF/vPnU6QHuwQ02Te8vg1+CSds3Trn0kLxsBsg4UB334bNfrXzOTuDB0ErMG45Wr8/Y6UT9+AXY2Y8FOW7O/2NKB1EbvvWy8uufh5L7ERNFHw4P8z8B7cXRiOUN3pIrsqEIOP/eR2gs2pTXsZ2EJRN4lxA4mJ0klHR9GWruEbTxlSltPrRnPCNjo55U837g8yzi+SzgTIp+/AMSALRxbGAbrAwx2MnO4H2K+ZaDjUXc6EscHgbR/tOGxdUH8M8DYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qe0xRpvVozurAHV5aoubCsu17m3IAEvzXvDmuyq+Wv4=;
 b=N/9/YUMbW+JOWhfpEIDhKEXkBEcwd2Yw87DM3Y10rZan/zwN83JZGrPFpsZytiEmOhhIGvhR1uMYUyOkg4TE2iFO+ozrHV3XoS0NWNpZex5jHSIqkLnwxNYq8/ODrdFGgb65QrEnR9IzqONajTuviVEJGNGMeXtpXcbvi61oEZ4=
Received: from MWHPR20CA0028.namprd20.prod.outlook.com (2603:10b6:300:ed::14)
 by DM6PR12MB3324.namprd12.prod.outlook.com (2603:10b6:5:11e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Tue, 1 Sep
 2020 07:50:42 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ed:cafe::78) by MWHPR20CA0028.outlook.office365.com
 (2603:10b6:300:ed::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Tue, 1 Sep 2020 07:50:41 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Tue, 1 Sep 2020 07:50:41 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 1 Sep 2020
 02:50:40 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 1 Sep 2020
 02:50:39 -0500
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Tue, 1 Sep 2020 02:50:38 -0500
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <felix.kuehling@amd.com>, <Hawking.Zhang@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH v2] drm/amdgpu: block ring buffer access during GPU recovery
Date: Tue, 1 Sep 2020 15:50:29 +0800
Message-ID: <20200901075029.23502-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ea25c50-1b91-4219-2177-08d84e4bb97e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3324:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3324AFFA440AD052E4B842B0ED2E0@DM6PR12MB3324.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RB2IPO51MZMniLgze7hjP0T7s6Epema3oGwHfeiLwjMC2K9H/WOZtRHkZgHijXh2/Ta6JGkXO0PKkiFsavajmWFHeFNp62wss0CfJqjvEkN31mKaYItSTU0Z9/9OI0WrCpioqf7x2+w+dctqqZeN5hKvSI4rs8iiOuKQP4GgHn21o5TBRa7YTtaSmVy4gLndVgvdczKlfA3b2/MSHLGaAWT3TfJ6bshiuUwestUts2iOlmFyFTIh71XPor78e7blHpSIfsxMWyWkSUL7V/vGcwn6LhZ4oR2zv8B7aaZ8m7v3gZGmAJ8ueBw0Dm042/oggbM2BzohPF6CKWqrG5V7uRJle1kTOGtsYVbwBb+WODGQwcFuCVF8do60pJG18hi5jrUYsnGoFRp9mPAxsTnjqIzOdyw4/a3yWvC0K1W2LJg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(376002)(136003)(46966005)(81166007)(6666004)(47076004)(426003)(2906002)(356005)(2616005)(83380400001)(8936002)(82740400003)(8676002)(316002)(5660300002)(6636002)(1076003)(7696005)(70206006)(70586007)(186003)(26005)(36756003)(4326008)(478600001)(336012)(86362001)(110136005)(82310400003)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2020 07:50:41.2920 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea25c50-1b91-4219-2177-08d84e4bb97e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3324
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

v2: correct indent

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 172dc47b7f39..9b586bc80c38 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -319,8 +319,12 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
 {
 	uint32_t ret;
 
-	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
-		return amdgpu_kiq_rreg(adev, reg);
+	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev) &&
+	    down_read_trylock(&adev->reset_sem)) {
+		ret = amdgpu_kiq_rreg(adev, reg);
+		up_read(&adev->reset_sem);
+		return ret;
+	}
 
 	if ((reg * 4) < adev->rmmio_size)
 		ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
@@ -332,6 +336,7 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
 		ret = readl(((void __iomem *)adev->rmmio) + (mmMM_DATA * 4));
 		spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
 	}
+
 	trace_amdgpu_mm_rreg(adev->pdev->device, reg, ret);
 	return ret;
 }
@@ -407,8 +412,12 @@ void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg,
 void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
 		    uint32_t acc_flags)
 {
-	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
-		return amdgpu_kiq_wreg(adev, reg, v);
+	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev) &&
+	    down_read_trylock(&adev->reset_sem)) {
+		amdgpu_kiq_wreg(adev, reg, v);
+		up_read(&adev->reset_sem);
+		return;
+	}
 
 	amdgpu_mm_wreg_mmio(adev, reg, v, acc_flags);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index ad9ad622ccce..31359e519d69 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -287,8 +287,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	 */
 	if (adev->gfx.kiq.ring.sched.ready &&
 	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) &&
-	    !amdgpu_in_reset(adev)) {
-
+	    down_read_trylock(&adev->reset_sem)) {
 		struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
 		const unsigned eng = 17;
 		u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
@@ -297,6 +296,8 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 
 		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
 				1 << vmid);
+
+		up_read(&adev->reset_sem);
 		return;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index e1a0ae327cf5..c602ddc68384 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -500,13 +500,14 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	 * as GFXOFF under bare metal
 	 */
 	if (adev->gfx.kiq.ring.sched.ready &&
-			(amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) &&
-			!amdgpu_in_reset(adev)) {
+	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) &&
+	    down_read_trylock(&adev->reset_sem)) {
 		uint32_t req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
 		uint32_t ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
 
 		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
 						   1 << vmid);
+		up_read(&adev->reset_sem);
 		return;
 	}
 
@@ -599,7 +600,7 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	if (amdgpu_in_reset(adev))
 		return -EIO;
 
-	if (ring->sched.ready) {
+	if (ring->sched.ready && down_read_trylock(&adev->reset_sem)) {
 		/* Vega20+XGMI caches PTEs in TC and TLB. Add a
 		 * heavy-weight TLB flush (type 2), which flushes
 		 * both. Due to a race condition with concurrent
@@ -626,6 +627,7 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 		if (r) {
 			amdgpu_ring_undo(ring);
 			spin_unlock(&adev->gfx.kiq.ring_lock);
+			up_read(&adev->reset_sem);
 			return -ETIME;
 		}
 
@@ -634,9 +636,10 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
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
