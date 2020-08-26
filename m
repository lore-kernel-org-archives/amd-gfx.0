Return-Path: <SRS0=g3tc=CE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2FFC433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 14:46:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F9052078D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 14:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KG94OrYl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F9052078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD8CF6EA5B;
	Wed, 26 Aug 2020 14:46:43 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760052.outbound.protection.outlook.com [40.107.76.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 878BE6EA5B
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2020 14:46:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnUL38mAmh0AtxYv0Gw6BYYCxGb3AEccACxpd8xy+iplrR3C/MiUokIKf5fy4+hd+twnhvsrtkmV7jYxKEHBtxPStc2YEvVVY4q7PcTJ04eSSoWRNyk8JtmiciP26KJnCUY7jLojvBVMrjDMfsG0PxKDexN/bd9MF1LBMMhXcqhk7L0PeiAtTr5YTyANT7RZlgU1jdbyanVCae5/B/lOx7lIEvV19U4+Bsdt8v24I0IcD7N4UR+1mDxf9rJm7JhkbETjEwexjfRDiNZKBTjIe2P30ziYexuVOW/8aY0JwyQE7hfTV6E4MMDxmdxlJU/R45t10MDRVRUCC57+9kreMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+EFLmUO3hqg1Au9xuXbsH23MxtZq7s12pFTKsiabhy4=;
 b=CjNs5ude/50vwwrIPlh2LykMy73JxckVtfL0AhiA5dmX/7KiwK+FymlZ7eoznF5FcgsyO7BKkdRCnoeeDCxdUwyQefHu8MTZ0kj8ru7WP/jCSJlApTMRZYT2ZVaaJBlm/xYwdF/k8yFonIscl8tnF+6pO/8MmHIlcX8yetBhpgIeli7GJ7tUTTqLSyEauXY9UmplSqSLOtSpxPO11OBsYwehdxvoNGeLBifVCELzB38Cvu2rc66BwpG8iUF8KzyatKMckf4WKFnmK2cQE5PztE0LfgLokND2FC4NWv67GeZn9qRrNBFd6aamUq/duucYpy2R/pvQ6Gy+fKjLo7g+WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+EFLmUO3hqg1Au9xuXbsH23MxtZq7s12pFTKsiabhy4=;
 b=KG94OrYlXBbR066mRZh0LLWnnJokvHOmTv9h6uaW3rGZrh7k5DFFsbxrZ7cQXhRUWZqXKzDX5auefwBw0lDbtzPDMLaLXU0nQNWjo6Ge4ebP9ZLB5SMCFSFDSoePYwOBnbAhutAmPMBfbT/WefvRDIdoxezcIa08/SV8+gYqv74=
Received: from MWHPR14CA0055.namprd14.prod.outlook.com (2603:10b6:300:81::17)
 by DM6PR12MB3083.namprd12.prod.outlook.com (2603:10b6:5:11d::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Wed, 26 Aug
 2020 14:46:41 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:81:cafe::72) by MWHPR14CA0055.outlook.office365.com
 (2603:10b6:300:81::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Wed, 26 Aug 2020 14:46:41 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Wed, 26 Aug 2020 14:46:40 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 26 Aug
 2020 09:46:34 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 26 Aug
 2020 09:46:33 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Wed, 26 Aug 2020 09:46:33 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/7] drm/amdgpu: Avoid accessing HW when suspending SW state
Date: Wed, 26 Aug 2020 10:46:17 -0400
Message-ID: <1598453182-6946-3-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598453182-6946-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1598453182-6946-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a1f0299-c5a3-48ca-6a33-08d849ced817
X-MS-TrafficTypeDiagnostic: DM6PR12MB3083:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3083B0C0D7B01047E661B2DCEA540@DM6PR12MB3083.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OBlNtA6Wn2b1oVy4VokM6P6cBzqrKyfrYEneFCFV10XDc36h860/XGTAXltu5ry6cMFGkiDusYk5b/NCUZMtUoUpIubCXh2njlUVQei+zqdcQ6ly7xw8Oc4vrOu4x+8enTGybAv2Q+kBLrHGpM7NCv83adHr4BhwyYA3emRG/YwKJ0H0OTAOfpIgwTZT5F5BmVMh6v26XwCmZRmfy/xctkSSnK1YwYhWfUTXnROtt8Ql4b7NjSdXz/IfyN37qhftYALYWVMxhKSELoztl1PI+mJcVHa8O4Ci56/8P4xgDDp/OH2v3EjVYtYX2fbLb5gStRSRL1ly5PUXFVVcYSCdkoS/Bfi7YqPlOJgQ1J6bRehXf9n4k0ez2PrWoWUuly+EpkyTvgqMCE0Si5suHtC5Y1TCiFjLtb+V8/AtdambXE4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(396003)(346002)(46966005)(86362001)(70206006)(356005)(70586007)(81166007)(6916009)(82740400003)(2616005)(82310400002)(7696005)(8676002)(336012)(54906003)(186003)(26005)(8936002)(316002)(5660300002)(2906002)(83380400001)(6666004)(4326008)(426003)(478600001)(36756003)(47076004)(44832011)(473944003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 14:46:40.8859 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1f0299-c5a3-48ca-6a33-08d849ced817
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3083
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
 nirmodas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

At this point the ASIC is already post reset by the HW/PSP
so the HW not in proper state to be configured for suspension,
some bloks might be even gated and so best is to avoid touching it.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 37 ++++++++++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    |  6 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    |  6 +++++
 drivers/gpu/drm/amd/amdgpu/atom.c          |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 18 +++++++++------
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  |  3 +++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c     |  3 +++
 8 files changed, 64 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 3399242..3489622 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -992,6 +992,7 @@ struct amdgpu_device {
 	atomic_t			throttling_logging_enabled;
 	struct ratelimit_state		throttling_logging_rs;
 	uint32_t			ras_features;
+	bool                            in_dpc;
 };
 
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 84f8d14..e1bbefd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -319,6 +319,9 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
 {
 	uint32_t ret;
 
+	if (adev->in_dpc)
+		return 0;
+
 	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
 		return amdgpu_kiq_rreg(adev, reg);
 
@@ -350,8 +353,10 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
  *
  * Returns the 8 bit value from the offset specified.
  */
-uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset)
-{
+uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset) {
+
+	if (adev->in_dpc)
+		return 0;
 
 	if (offset < adev->rmmio_size)
 		return (readb(adev->rmmio + offset));
@@ -373,8 +378,10 @@ uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset)
  *
  * Writes the value specified to the offset specified.
  */
-void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value)
-{
+void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value) {
+
+	if (adev->in_dpc)
+		return;
 
 	if (offset < adev->rmmio_size)
 		writeb(value, adev->rmmio + offset);
@@ -384,6 +391,8 @@ void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value)
 
 void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint32_t acc_flags)
 {
+	if (adev->in_dpc)
+		return;
 
 	trace_amdgpu_mm_wreg(adev->pdev->device, reg, v);
 
@@ -412,6 +421,8 @@ void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg,
 void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
 		    uint32_t acc_flags)
 {
+	if (adev->in_dpc)
+		return;
 
 	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
 		return amdgpu_kiq_wreg(adev, reg, v);
@@ -427,6 +438,9 @@ void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
 void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
 		    uint32_t acc_flags)
 {
+	if (adev->in_dpc)
+		return;
+
 	if (amdgpu_sriov_fullaccess(adev) &&
 		adev->gfx.rlc.funcs &&
 		adev->gfx.rlc.funcs->is_rlcg_access_range) {
@@ -448,6 +462,9 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev, uint32_t reg, uint32_t
  */
 u32 amdgpu_io_rreg(struct amdgpu_device *adev, u32 reg)
 {
+	if (adev->in_dpc)
+		return 0;
+
 	if ((reg * 4) < adev->rio_mem_size)
 		return ioread32(adev->rio_mem + (reg * 4));
 	else {
@@ -467,6 +484,8 @@ u32 amdgpu_io_rreg(struct amdgpu_device *adev, u32 reg)
  */
 void amdgpu_io_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
 {
+	if (adev->in_dpc)
+		return;
 
 	if ((reg * 4) < adev->rio_mem_size)
 		iowrite32(v, adev->rio_mem + (reg * 4));
@@ -487,6 +506,8 @@ void amdgpu_io_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
  */
 u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
 {
+	if (adev->in_dpc)
+		return 0;
 
 	if (index < adev->doorbell.num_doorbells) {
 		return readl(adev->doorbell.ptr + index);
@@ -508,6 +529,8 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
  */
 void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
 {
+	if (adev->in_dpc)
+		return;
 
 	if (index < adev->doorbell.num_doorbells) {
 		writel(v, adev->doorbell.ptr + index);
@@ -527,6 +550,8 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
  */
 u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
 {
+	if (adev->in_dpc)
+		return 0;
 
 	if (index < adev->doorbell.num_doorbells) {
 		return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
@@ -548,6 +573,8 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
  */
 void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
 {
+	if (adev->in_dpc)
+			return;
 
 	if (index < adev->doorbell.num_doorbells) {
 		atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
@@ -4790,7 +4817,9 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 
 	pci_restore_state(pdev);
 
+	adev->in_dpc = true;
 	r = amdgpu_device_ip_suspend(adev);
+	adev->in_dpc = false;
 	if (r)
 		goto out;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index d698142..50c42c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -693,6 +693,9 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 	struct amdgpu_ring *ring = &kiq->ring;
 
+	if (adev->in_dpc)
+		return 0;
+
 	BUG_ON(!ring->funcs->emit_rreg);
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
@@ -757,6 +760,9 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
 
 	BUG_ON(!ring->funcs->emit_wreg);
 
+	if (adev->in_dpc)
+		return;
+
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 	amdgpu_ring_alloc(ring, 32);
 	amdgpu_ring_emit_wreg(ring, reg, v);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index d6c38e2..555ef59 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -219,6 +219,9 @@ int psp_wait_for(struct psp_context *psp, uint32_t reg_index,
 	int i;
 	struct amdgpu_device *adev = psp->adev;
 
+	if (psp->adev->in_dpc)
+		return 0;
+
 	for (i = 0; i < adev->usec_timeout; i++) {
 		val = RREG32(reg_index);
 		if (check_changed) {
@@ -245,6 +248,9 @@ psp_cmd_submit_buf(struct psp_context *psp,
 	bool ras_intr = false;
 	bool skip_unsupport = false;
 
+	if (psp->adev->in_dpc)
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
index 2db195e..86f268e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6980,15 +6980,19 @@ static int gfx_v10_0_hw_fini(void *handle)
 
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
+
+	if (!adev->in_dpc) {
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
index a58ea08..02cf55e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -112,6 +112,9 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0, index = 0;
 
+	if (smu->adev->in_dpc)
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
