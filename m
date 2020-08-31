Return-Path: <SRS0=7vr2=CJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56929C433E6
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 15:51:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2621220719
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 15:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nt+Wh/WC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2621220719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BAE589CC1;
	Mon, 31 Aug 2020 15:51:09 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6BEF89C49
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2020 15:51:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2H5xMW+TlwAkHuded233AHU64eTdxfYEwMR/m+MVeJjVfjkP6PFHrXkHJ77CiP38m90en/xTB6EjIZ9ZxCRbir8kQtJX7qL14GtaiO3uYbOPhiVIBnNY6QrdXmauvmrt3d1Sb/15LQpZf1S/fO9UlGiaRUmluBmnbn6H5dZpQSv6SEluJBdNwiW2lzCxl9L8pRvFlTWBi+O9mbHAr0TgqeJ3sxguHhnFErxr/IlC2otxTl4z36GKijCu4egkr7M+NsV4KaLxE7SrfQ7hQcz6Tpd37I+DFD/n3uLlFxdKdF7U3JJyV+Yjg3yi0pCYkFCEeBOcd2WdOrf+e1sXY0C2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADJjh0vnJo6aZXQjfsAG0X6zBxDiRXUrx2RG3WpJ3gY=;
 b=KVlGTBrVu3pjilAdzc93KvmFF2du+EyN30u5R2WXjPiUXhOw0DcHJSW4wMh41OHvOXquEr1A1OJ/Ej8k5vYCxUyn51QRt7Uz7IC8HIt+ruOkxYQwcrkRnTFoIhDTcieISvvT2hyfZHzdMayvkxTd24I/b3nOTMR4oZbv3JSZ2r1hxjJqRzfWWXJnuLoEH6n+1RVLzbPFA1HdeNy7DP8e0Q6AqEWftiUZmOlDQr10ySnk6GpmxL4DMXjpTwyCp686R/cgmN8IBrR5Mr3DzTbzXPO8NobsydzKPE2XhYTmIzuvgOUyWp7ZC8xu2bwcoCZAYMjO6Vp/tC3SY1lNBeGIYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADJjh0vnJo6aZXQjfsAG0X6zBxDiRXUrx2RG3WpJ3gY=;
 b=nt+Wh/WCNED0QlMktP06E07q1WM2ekC/F+O6nMoNtpsrQgyQTSxHu8iHFn1Bjl1RmO6FvtJeUOW/iWcLVVwzr9ZzYn8RHrxiekuC6qQhdPxUziPWVdwbCzrj7IlF2Ty0KuJqdgdOybLcVjIdIQh/z6m4wnH3ukOyHgnZdqIjJkA=
Received: from DM5PR07CA0146.namprd07.prod.outlook.com (2603:10b6:3:ee::12) by
 CH2PR12MB3654.namprd12.prod.outlook.com (2603:10b6:610:22::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19; Mon, 31 Aug 2020 15:51:02 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ee:cafe::fe) by DM5PR07CA0146.outlook.office365.com
 (2603:10b6:3:ee::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Mon, 31 Aug 2020 15:51:02 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Mon, 31 Aug 2020 15:51:02 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 31 Aug
 2020 10:50:58 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 31 Aug
 2020 10:50:57 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Mon, 31 Aug 2020 10:50:57 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 2/8] drm/amdgpu: Avoid accessing HW when suspending SW state
Date: Mon, 31 Aug 2020 11:50:43 -0400
Message-ID: <1598889049-28321-3-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598889049-28321-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1598889049-28321-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 397711a4-11c7-4d6b-1691-08d84dc5a9f0
X-MS-TrafficTypeDiagnostic: CH2PR12MB3654:
X-Microsoft-Antispam-PRVS: <CH2PR12MB36540697E1DB04358F80912BEA510@CH2PR12MB3654.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PllliJc1ByySicnlaiUDHSSuDVk0aujV5mHh721bxZoZSA70A86fk26gT5zIP/ZStmADFhJg3B4H8dIo+UFJtha3Gj2KBLzZvXCru3XrVrJdOf5G7yadRGRwZ5bLLKsoiG7BRcC6OROfO5I7hqxHM8G6Urt6yQankxjHySaV7Iii4DfldWMjgMR87AzdpAQFlCW0AC4jJru8+3DFKUFjxwTieMOqzoZXMgjXFPeeOda7hIpw4s50gFwnL7PslNCyscdp8ypNX1B8VMXtiHzxQ6GUWkuHbPH/u5WLpGgxi8ikMaAIz4EDEZTv2q1KjKh4nIZkOZ1yRhMRR6gDESJs2x1uDnJsXLw7He+ZKiQQPF9ROCevJ0yN8n2oDaDoIzoujQ+ZMSBXVENqSrUA+uG1dg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(46966005)(336012)(2906002)(44832011)(36756003)(86362001)(5660300002)(316002)(6916009)(8936002)(4326008)(186003)(6666004)(70586007)(8676002)(2616005)(478600001)(426003)(26005)(83380400001)(47076004)(7696005)(54906003)(81166007)(356005)(82310400002)(82740400003)(70206006);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 15:51:02.6995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 397711a4-11c7-4d6b-1691-08d84dc5a9f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3654
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
some blocks might be even gated and so best is to avoid touching it.

v2: Rename in_dpc to more meaningful name

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 41 +++++++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    |  6 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    |  6 +++++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 18 ++++++++-----
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c     |  3 +++
 6 files changed, 67 insertions(+), 8 deletions(-)

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
index 67d61a5..43ce473 100644
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
 
@@ -351,6 +354,9 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
  * Returns the 8 bit value from the offset specified.
  */
 uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset) {
+	if (adev->in_pci_err_recovery)
+		return 0;
+
 	if (offset < adev->rmmio_size)
 		return (readb(adev->rmmio + offset));
 	BUG();
@@ -372,14 +378,21 @@ uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset) {
  * Writes the value specified to the offset specified.
  */
 void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value) {
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
@@ -407,6 +420,9 @@ void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg,
 void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
 		    uint32_t acc_flags)
 {
+	if (adev->in_pci_err_recovery)
+		return;
+
 	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
 		return amdgpu_kiq_wreg(adev, reg, v);
 
@@ -421,6 +437,9 @@ void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
 void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
 		    uint32_t acc_flags)
 {
+	if (adev->in_pci_err_recovery)
+		return;
+
 	if (amdgpu_sriov_fullaccess(adev) &&
 		adev->gfx.rlc.funcs &&
 		adev->gfx.rlc.funcs->is_rlcg_access_range) {
@@ -442,6 +461,9 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev, uint32_t reg, uint32_t
  */
 u32 amdgpu_io_rreg(struct amdgpu_device *adev, u32 reg)
 {
+	if (adev->in_pci_err_recovery)
+		return 0;
+
 	if ((reg * 4) < adev->rio_mem_size)
 		return ioread32(adev->rio_mem + (reg * 4));
 	else {
@@ -461,6 +483,9 @@ u32 amdgpu_io_rreg(struct amdgpu_device *adev, u32 reg)
  */
 void amdgpu_io_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
 {
+	if (adev->in_pci_err_recovery)
+		return;
+
 	if ((reg * 4) < adev->rio_mem_size)
 		iowrite32(v, adev->rio_mem + (reg * 4));
 	else {
@@ -480,6 +505,9 @@ void amdgpu_io_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
  */
 u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
 {
+	if (adev->in_pci_err_recovery)
+		return 0;
+
 	if (index < adev->doorbell.num_doorbells) {
 		return readl(adev->doorbell.ptr + index);
 	} else {
@@ -500,6 +528,9 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
  */
 void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
 {
+	if (adev->in_pci_err_recovery)
+		return;
+
 	if (index < adev->doorbell.num_doorbells) {
 		writel(v, adev->doorbell.ptr + index);
 	} else {
@@ -518,6 +549,9 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
  */
 u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
 {
+	if (adev->in_pci_err_recovery)
+		return 0;
+
 	if (index < adev->doorbell.num_doorbells) {
 		return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
 	} else {
@@ -538,6 +572,9 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
  */
 void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
 {
+	if (adev->in_pci_err_recovery)
+		return;
+
 	if (index < adev->doorbell.num_doorbells) {
 		atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
 	} else {
@@ -4775,7 +4812,9 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 
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
