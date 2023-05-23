Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64566C77B75
	for <amd-gfx@archiver.kernel.org>; Tue, 23 May 2023 19:51:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7EF110E4BC;
	Tue, 23 May 2023 19:51:04 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::61d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 364D910E4BC
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 May 2023 19:51:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejXu9Uo8afyav9xHxeaOwgYHkxW2ikl2exBx8VTm5rKdPHbkTjej5zOJ3ADs/nR8d11KKK1h6O+HGBOSq8wHtY9MWHbTeAivG5iiVgC8DYMSIGZ+tQHDy5hJkvvUG8U1IelSht4zguK2lb5iDduih/YnjLDJneOAUiUv4ogWZANdRypJdJ25pJ10tBm0pNebbXYg//uPBHdBaDaiKoiJWG9jSd/lodA3AoBzLXRuO/i1n3RyNO1gC5rauB9yqG3lX+ySCqY9IJL7+GBaLNdmLNW+ZZ2p1S2Fl5YV1lR+WqWkOiQM1HvnDyXTTPNg/cUCIUm08xpsOd4p13o6jSb42Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1bZuX0UIIdOcYvQMez5zXebGQ+VUjrfu1xVW/w78yk=;
 b=QnfyaeO+22/70i4j3T8xkW4MJF+IKxzEpghAr2R+mPKGw+xRN3gSV4WVTUykHh22uiadxnVHChrY425opizdCuoCSI7bmfOfiVJeVjcpOtzAlHFXbjOR92nrLfoRNtVa2WEodhukQUo12Zuf4nxgKMFSssU3uzCSxh6ll0QuFnsh2Ru32ulW+2szJHn2WFsTTQv14pEfGLZ4IQF1D67aULO0HTjTjFoNAJLOOmHQoIqkKrUKu1XSFLvuVZ9fv+zh5/+2S0Q2wPrkbnb66EIsvXG/u2SHsrcXq5DSvl+OjvGtgmkNF2pTvoNlHXm2IIU8Bt5FjNct+fRvkoLPWVVsng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1bZuX0UIIdOcYvQMez5zXebGQ+VUjrfu1xVW/w78yk=;
 b=kvrFPgKuGbomsRJ/x7MkJ4xDw3xH0WRM+3uoo4BvtV2OlFzOJil863a7ZZ073wMFkAztBIyEtWEXA9lfZpNchXiSyeDnp6XLKQZKAIZuW0xWMLnszx9VCq6Esv4yVoncK/0u8xGX4yrIPoJ20QHUwXaAhZ/DHyqDvP/HYdP0oGM=
Received: from MW4PR04CA0311.namprd04.prod.outlook.com (2603:10b6:303:82::16)
 by DM4PR12MB5216.namprd12.prod.outlook.com (2603:10b6:5:398::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 19:50:58 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::74) by MW4PR04CA0311.outlook.office365.com
 (2603:10b6:303:82::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29 via Frontend
 Transport; Tue, 23 May 2023 19:50:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.29 via Frontend Transport; Tue, 23 May 2023 19:50:58 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 23 May
 2023 14:50:56 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Fix warnings in amdgpu_irq.c
Date: Wed, 24 May 2023 01:20:37 +0530
Message-ID: <20230523195037.3150894-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT037:EE_|DM4PR12MB5216:EE_
X-MS-Office365-Filtering-Correlation-Id: 45ffc174-2969-4535-21fc-08db5bc7075a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FPakxtcAfRi5jwAWrpmINV80fPflQm6kE2yb1QQhiK9bRF9CQENoNVDU0wMNxUsdSN7jm/F+M6VOz3HCUtnzg1tLfnsVon/THzelkBdnbumIFWTgNQUCMXVDr9Rv8S5BRX64e04PG5g//Gqx2nQz0VnpHdpZhYjHT5bsAxIAFIp+ZbO74feVkIlvY1zdM8u0isXTgFhUDHpIgnvGi5Ju4ZuwkOF+NZ0ckXiMDdCY0e4VP4yhVQiieObVAFHMfQHrFES+rhwt1qlEcZc4exaifU+attMriCtDELhpY4yUNPco64Aq/77NP569iMK6aREAViWd2DN3FS+PECfB0t2u8vopdjS31T7DHL84jOQwFGjAq96Rp4VZf5koEMjy1vjhXRQKPTjeQyKlYfQSONfjzOR+yHdGM5TXGQ5dF90khViPkG6WHfqnfCatvryA4FG6rj98lcVRTzEpYm8vn4AxiwP8rommkDKJnUKaKQpQkPlTee72uV5OF9OCNUAVF+9u6O9zuIbfdD5X/HgV/8bQQU3jflRaHR3leGH+8WorD4yV12rdZ8EuEr1kQx/JsUE4nfarBzgw1q6NnNJbirk8dQnzcTP43t9H238rB0KPCFdgkbfVVhtqJ8ERil96UOKwPMBJ/vKngMUq1kMcgedVqYu1h/+NEVxVryHJHVG/tsXQqlbVJMLd7rdELE+Pc2jJQsrUNpqXzCO7fRyHiidXmAO+Cs0WDMS/MOzKLChOQsFziYdXEjHriqf1rlSJvmIcy926B+qRnIY1PNRmgHa0KQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199021)(36840700001)(46966006)(40470700004)(36860700001)(54906003)(110136005)(83380400001)(86362001)(478600001)(82310400005)(2616005)(47076005)(70586007)(70206006)(16526019)(186003)(4326008)(6636002)(336012)(426003)(66574015)(2906002)(26005)(82740400003)(316002)(40480700001)(6666004)(1076003)(44832011)(41300700001)(7696005)(5660300002)(8936002)(8676002)(40460700003)(36756003)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 19:50:58.1617 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ffc174-2969-4535-21fc-08db5bc7075a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5216
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
WARNING: braces {} are not necessary for any arm of this statement
+               if (nvec <= 0) {
[...]
+               } else {
[...]
WARNING: Block comments use a trailing */ on a separate line

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 27 +++++++++++++------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index ad5368e15114..00f2106c17b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -125,7 +125,7 @@ const int node_id_to_phys_map[NODEID_MAX] = {
 void amdgpu_irq_disable_all(struct amdgpu_device *adev)
 {
 	unsigned long irqflags;
-	unsigned i, j, k;
+	unsigned int i, j, k;
 	int r;
 
 	spin_lock_irqsave(&adev->irq.lock, irqflags);
@@ -284,11 +284,11 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
 		int nvec = pci_msix_vec_count(adev->pdev);
 		unsigned int flags;
 
-		if (nvec <= 0) {
+		if (nvec <= 0)
 			flags = PCI_IRQ_MSI;
-		} else {
+		else
 			flags = PCI_IRQ_MSI | PCI_IRQ_MSIX;
-		}
+
 		/* we only need one vector */
 		nvec = pci_alloc_irq_vectors(adev->pdev, 1, 1, flags);
 		if (nvec > 0) {
@@ -347,7 +347,7 @@ void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
  */
 void amdgpu_irq_fini_sw(struct amdgpu_device *adev)
 {
-	unsigned i, j;
+	unsigned int i, j;
 
 	for (i = 0; i < AMDGPU_IRQ_CLIENTID_MAX; ++i) {
 		if (!adev->irq.client[i].sources)
@@ -381,7 +381,7 @@ void amdgpu_irq_fini_sw(struct amdgpu_device *adev)
  * 0 on success or error code otherwise
  */
 int amdgpu_irq_add_id(struct amdgpu_device *adev,
-		      unsigned client_id, unsigned src_id,
+		      unsigned int client_id, unsigned int src_id,
 		      struct amdgpu_irq_src *source)
 {
 	if (client_id >= AMDGPU_IRQ_CLIENTID_MAX)
@@ -433,7 +433,7 @@ void amdgpu_irq_dispatch(struct amdgpu_device *adev,
 {
 	u32 ring_index = ih->rptr >> 2;
 	struct amdgpu_iv_entry entry;
-	unsigned client_id, src_id;
+	unsigned int client_id, src_id;
 	struct amdgpu_irq_src *src;
 	bool handled = false;
 	int r;
@@ -508,7 +508,7 @@ void amdgpu_irq_delegate(struct amdgpu_device *adev,
  * Updates interrupt state for the specific source (all ASICs).
  */
 int amdgpu_irq_update(struct amdgpu_device *adev,
-			     struct amdgpu_irq_src *src, unsigned type)
+			     struct amdgpu_irq_src *src, unsigned int type)
 {
 	unsigned long irqflags;
 	enum amdgpu_interrupt_state state;
@@ -517,7 +517,8 @@ int amdgpu_irq_update(struct amdgpu_device *adev,
 	spin_lock_irqsave(&adev->irq.lock, irqflags);
 
 	/* We need to determine after taking the lock, otherwise
-	   we might disable just enabled interrupts again */
+	 * we might disable just enabled interrupts again
+	 */
 	if (amdgpu_irq_enabled(adev, src, type))
 		state = AMDGPU_IRQ_STATE_ENABLE;
 	else
@@ -571,7 +572,7 @@ void amdgpu_irq_gpu_reset_resume_helper(struct amdgpu_device *adev)
  * 0 on success or error code otherwise
  */
 int amdgpu_irq_get(struct amdgpu_device *adev, struct amdgpu_irq_src *src,
-		   unsigned type)
+		   unsigned int type)
 {
 	if (!adev->irq.installed)
 		return -ENOENT;
@@ -601,7 +602,7 @@ int amdgpu_irq_get(struct amdgpu_device *adev, struct amdgpu_irq_src *src,
  * 0 on success or error code otherwise
  */
 int amdgpu_irq_put(struct amdgpu_device *adev, struct amdgpu_irq_src *src,
-		   unsigned type)
+		   unsigned int type)
 {
 	if (!adev->irq.installed)
 		return -ENOENT;
@@ -635,7 +636,7 @@ int amdgpu_irq_put(struct amdgpu_device *adev, struct amdgpu_irq_src *src,
  * invalid parameters
  */
 bool amdgpu_irq_enabled(struct amdgpu_device *adev, struct amdgpu_irq_src *src,
-			unsigned type)
+			unsigned int type)
 {
 	if (!adev->irq.installed)
 		return false;
@@ -748,7 +749,7 @@ void amdgpu_irq_remove_domain(struct amdgpu_device *adev)
  * Returns:
  * Linux IRQ
  */
-unsigned amdgpu_irq_create_mapping(struct amdgpu_device *adev, unsigned src_id)
+unsigned int amdgpu_irq_create_mapping(struct amdgpu_device *adev, unsigned int src_id)
 {
 	adev->irq.virq[src_id] = irq_create_mapping(adev->irq.domain, src_id);
 
-- 
2.25.1

