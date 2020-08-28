Return-Path: <SRS0=kQKQ=CG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536EAC433E6
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 16:06:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22048207DF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 16:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gCE7mB+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22048207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B74EA6E4E8;
	Fri, 28 Aug 2020 16:06:02 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B6486E4CB
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 16:06:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePF9MgAcEG3E7brCneFOqiqL+Bw1ndjglzO7EPTh6WeIeeMrphmKz+FSN9x2XiAbc1SjBDkvFWa47O0osr46L4bNj7Jc6uHHuBl6PT221IVuerF558MqKRJ7gQrGf2CM2HSD3kCw3JCpJW2pEF31PvpdSEwHnH4pht5c1IDVjtjsJpXz8uGuCf13luW3ylzlwcffO4dR5wcgxT2rGAGX4viydIsUCZGNxrsnyDg1AIHqHprQJudTuQgen1AzSdNPGzxMmg/icpjRvQKlnfZGBxwOGpho3ApNfaW/rErC2jADtPkCkwFXoIFTbri+KtF9h/g4QbzbaAVXIOI+wPch0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yz758sxBFNRWHonfwsUpPxnhzyAG2z3z6gXhnNBa7yE=;
 b=A2SXUBoDG52xVfCiRfk/8fwxHdwHhb451kEkELjH8sPmDr+9AxaIk1cSQ+Z1Get1rIy5zzJCO8kzN0Bi+ou2IY6XozNrxrYPTggOTXeMxvvuQ77/b6q/uNQrm8uMaL+n6bQctNMsCUHnE7eafa4zApwoXfo0gC+XlFJm3USSHGodPAX15Ju7Jt1gIK65SueZRW4LkitO8lxbWuVNUsMW5p41+SVJHF03e+j2fpeU+5RvU0qoaf6rZXytSLczzAkAoEL9hmXNukh16JwaGw+NO0FpR0dvSbF4jDWfjOyf0X7jIZz8uJYzKMu+O8ZfMQ1dMUTJL+ETWqduhceketkKdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yz758sxBFNRWHonfwsUpPxnhzyAG2z3z6gXhnNBa7yE=;
 b=gCE7mB+sXhfJdaOFvwALhmQlf0RFnMRasVegjNZk5gUTsoRHIYfiyQiH0TcbneLb8b3LujP0bldcaGDI7xvqFDQT0G1fSkCn3g2wt3zDVSDa8d/5ytHSi+brKYDIvPAca8uyv9LYO95B5NTT0zTPEJYts1qGqspm6+Px0ZeFeoo=
Received: from MWHPR18CA0025.namprd18.prod.outlook.com (2603:10b6:320:31::11)
 by DM6PR12MB3850.namprd12.prod.outlook.com (2603:10b6:5:1c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Fri, 28 Aug
 2020 16:05:58 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:320:31:cafe::94) by MWHPR18CA0025.outlook.office365.com
 (2603:10b6:320:31::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Fri, 28 Aug 2020 16:05:58 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Fri, 28 Aug 2020 16:05:56 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 28 Aug
 2020 11:05:55 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 28 Aug
 2020 11:05:55 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 28 Aug 2020 11:05:54 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/7] drm/amdgpu: Avoid accessing HW when suspending SW state
Date: Fri, 28 Aug 2020 12:05:38 -0400
Message-ID: <1598630743-21155-3-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598630743-21155-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1598630743-21155-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b728c01-5fb6-4fdb-4fc0-08d84b6c3f8c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3850:
X-Microsoft-Antispam-PRVS: <DM6PR12MB385022268C459A7FCD50B0FDEA520@DM6PR12MB3850.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QeXrdpvYxHX9YpG5E9ZnxvRwDEkwU1nt+23xMVjHZ2EMl2bli0PE7Opk0Io9paN8IpiseuHNj9+yzvHxhTrUwk+md7Q9Mn0luHUN51GT8UTrwEj6KBGxi8f7ISiai/MbWpiKT0BZl5+DywFhoRGilXaMdV86hgGl+BDl40a7jxh8QU8PQEC1WBUH3tAAMG4zEcLsan0b+XAA7H4OoYO0oZErwh4WM/qJnbic8fn9a+1Dv1p4qicSWTVqQ/nlkOaY/WciMPj72jd8FeK9JaFQu/AV0Rtf40F3cMZL2fv8RGhcoEXR3G1n+FunRyzQ2i7J7Vq6jls43smj+4mOhrQRgja1mamAK4x8wpJmyaWJQMe2VunaYLMq2jZdYE7BVh1kO7ZqN/3A7mdzrlYFjUsVwA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(46966005)(26005)(86362001)(81166007)(356005)(8936002)(186003)(6666004)(83380400001)(82310400002)(4326008)(336012)(2906002)(70586007)(36756003)(70206006)(316002)(5660300002)(54906003)(426003)(7696005)(2616005)(44832011)(82740400003)(47076004)(8676002)(6916009)(478600001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2020 16:05:56.6047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b728c01-5fb6-4fdb-4fc0-08d84b6c3f8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3850
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
Cc: alexander.deucher@amd.com, Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 nirmodas@amd.com, christian.koenig@amd.com, Dennis.Li@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

At this point the ASIC is already post reset by the HW/PSP
so the HW not in proper state to be configured for suspension,
some bloks might be even gated and so best is to avoid touching it.

v2: Rename in_dpc to more meaningful name

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 41 +++++++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    |  6 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    |  6 +++++
 drivers/gpu/drm/amd/amdgpu/atom.c          |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 18 ++++++++-----
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  |  3 +++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c     |  3 +++
 8 files changed, 71 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 3399242..cac51e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -992,6 +992,7 @@ struct amdgpu_device {
 	atomic_t			throttling_logging_enabled;
 	struct ratelimit_state		throttling_logging_rs;
 	uint32_t			ras_features;
+	bool                            in_pci_err_recovery;
 };
 
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 937f8b0..e67cbf2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -319,6 +319,9 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
 {
 	uint32_t ret;
 
+	if (adev->in_pci_err_recovery)
+		return 0;
+
 	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
 		return amdgpu_kiq_rreg(adev, reg);
 
@@ -352,6 +355,9 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
  */
 uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset)
 {
+	if (adev->in_pci_err_recovery)
+		return 0;
+
 	if (offset < adev->rmmio_size)
 		return (readb(adev->rmmio + offset));
 	BUG();
@@ -374,14 +380,21 @@ uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset)
  */
 void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value)
 {
+	if (adev->in_pci_err_recovery)
+		return;
+
 	if (offset < adev->rmmio_size)
 		writeb(value, adev->rmmio + offset);
 	else
 		BUG();
 }
 
-void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint32_t acc_flags)
+void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg,
+				       uint32_t v, uint32_t acc_flags)
 {
+	if (adev->in_pci_err_recovery)
+		return;
+
 	trace_amdgpu_mm_wreg(adev->pdev->device, reg, v);
 
 	if ((reg * 4) < adev->rmmio_size)
@@ -409,6 +422,9 @@ void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg,
 void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
 		    uint32_t acc_flags)
 {
+	if (adev->in_pci_err_recovery)
+		return;
+
 	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
 		return amdgpu_kiq_wreg(adev, reg, v);
 
@@ -423,6 +439,9 @@ void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
 void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
 		    uint32_t acc_flags)
 {
+	if (adev->in_pci_err_recovery)
+		return;
+
 	if (amdgpu_sriov_fullaccess(adev) &&
 		adev->gfx.rlc.funcs &&
 		adev->gfx.rlc.funcs->is_rlcg_access_range) {
@@ -444,6 +463,9 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev, uint32_t reg, uint32_t
  */
 u32 amdgpu_io_rreg(struct amdgpu_device *adev, u32 reg)
 {
+	if (adev->in_pci_err_recovery)
+		return 0;
+
 	if ((reg * 4) < adev->rio_mem_size)
 		return ioread32(adev->rio_mem + (reg * 4));
 	else {
@@ -463,6 +485,9 @@ u32 amdgpu_io_rreg(struct amdgpu_device *adev, u32 reg)
  */
 void amdgpu_io_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
 {
+	if (adev->in_pci_err_recovery)
+		return;
+
 	if ((reg * 4) < adev->rio_mem_size)
 		iowrite32(v, adev->rio_mem + (reg * 4));
 	else {
@@ -482,6 +507,9 @@ void amdgpu_io_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
  */
 u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
 {
+	if (adev->in_pci_err_recovery)
+		return 0;
+
 	if (index < adev->doorbell.num_doorbells) {
 		return readl(adev->doorbell.ptr + index);
 	} else {
@@ -502,6 +530,9 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
  */
 void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
 {
+	if (adev->in_pci_err_recovery)
+		return;
+
 	if (index < adev->doorbell.num_doorbells) {
 		writel(v, adev->doorbell.ptr + index);
 	} else {
@@ -520,6 +551,9 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
  */
 u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
 {
+	if (adev->in_pci_err_recovery)
+		return 0;
+
 	if (index < adev->doorbell.num_doorbells) {
 		return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
 	} else {
@@ -540,6 +574,9 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
  */
 void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
 {
+	if (adev->in_pci_err_recovery)
+		return;
+
 	if (index < adev->doorbell.num_doorbells) {
 		atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
 	} else {
@@ -4778,7 +4815,9 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 
 	pci_restore_state(pdev);
 
+	adev->in_pci_err_recovery = true;
 	r = amdgpu_device_ip_suspend(adev);
+	adev->in_pci_err_recovery = false;
 	if (r)
 		goto out;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index d698142..8c9bacf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -693,6 +693,9 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 	struct amdgpu_ring *ring = &kiq->ring;
 
+	if (adev->in_pci_err_recovery)
+		return 0;
+
 	BUG_ON(!ring->funcs->emit_rreg);
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
@@ -757,6 +760,9 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
 
 	BUG_ON(!ring->funcs->emit_wreg);
 
+	if (adev->in_pci_err_recovery)
+		return;
+
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 	amdgpu_ring_alloc(ring, 32);
 	amdgpu_ring_emit_wreg(ring, reg, v);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index d6c38e2..a7771aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -219,6 +219,9 @@ int psp_wait_for(struct psp_context *psp, uint32_t reg_index,
 	int i;
 	struct amdgpu_device *adev = psp->adev;
 
+	if (psp->adev->in_pci_err_recovery)
+		return 0;
+
 	for (i = 0; i < adev->usec_timeout; i++) {
 		val = RREG32(reg_index);
 		if (check_changed) {
@@ -245,6 +248,9 @@ psp_cmd_submit_buf(struct psp_context *psp,
 	bool ras_intr = false;
 	bool skip_unsupport = false;
 
+	if (psp->adev->in_pci_err_recovery)
+		return 0;
+
 	mutex_lock(&psp->mutex);
 
 	memset(psp->cmd_buf_mem, 0, PSP_CMD_BUFFER_SIZE);
diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index 4cfc786..613dac1 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -750,6 +750,7 @@ static void atom_op_jump(atom_exec_context *ctx, int *ptr, int arg)
 					DRM_ERROR("atombios stuck in loop for more than %dsecs aborting\n",
 						  ATOM_CMD_TIMEOUT_SEC);
 					ctx->abort = true;
+					dump_stack();
 				}
 			} else {
 				/* jiffies wrap around we will just wait a little longer */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 2db195e..ccf096c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6980,15 +6980,19 @@ static int gfx_v10_0_hw_fini(void *handle)
 
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
+
+	if (!adev->in_pci_err_recovery) {
 #ifndef BRING_UP_DEBUG
-	if (amdgpu_async_gfx_ring) {
-		r = gfx_v10_0_kiq_disable_kgq(adev);
-		if (r)
-			DRM_ERROR("KGQ disable failed\n");
-	}
+		if (amdgpu_async_gfx_ring) {
+			r = gfx_v10_0_kiq_disable_kgq(adev);
+			if (r)
+				DRM_ERROR("KGQ disable failed\n");
+		}
 #endif
-	if (amdgpu_gfx_disable_kcq(adev))
-		DRM_ERROR("KCQ disable failed\n");
+		if (amdgpu_gfx_disable_kcq(adev))
+			DRM_ERROR("KCQ disable failed\n");
+	}
+
 	if (amdgpu_sriov_vf(adev)) {
 		gfx_v10_0_cp_gfx_enable(adev, false);
 		/* Program KIQ position of RLC_CP_SCHEDULERS during destroy */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 8462b30..306461d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -224,9 +224,12 @@ int smu_dpm_set_power_gate(struct smu_context *smu, uint32_t block_type,
 {
 	int ret = 0;
 
+
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
+
+
 	switch (block_type) {
 	/*
 	 * Some legacy code of amdgpu_vcn.c and vcn_v2*.c still uses
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index a58ea08..97aa72a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -112,6 +112,9 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0, index = 0;
 
+	if (smu->adev->in_pci_err_recovery)
+		return 0;
+
 	index = smu_cmn_to_asic_specific_index(smu,
 					       CMN2ASIC_MAPPING_MSG,
 					       msg);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
