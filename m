Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49991C7EE22
	for <amd-gfx@archiver.kernel.org>; Fri,  5 May 2023 14:59:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C615410E624;
	Fri,  5 May 2023 14:59:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE38410E624
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 May 2023 14:59:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PzlNz8+tb64rTdACvZateeOewibubqZFOJ61NMsCfZ/A3ZSI1I0neR+NeVFPmVQRC9HCIvFXO9mDOIDu17RTa5VS/rak8ewJQg2wXCE5/bg59o1L//deIjHHAUyMC/+qEHUePxVMMfwqbOZvAuHd0162MawvzbTr6e+Y5jK5/0y6B3/MFgqmavDcmZgrLKfXAaIF9fMQwyKLLooi6cbOz52IMdMA3cs0v5+7PK/PJfUwNhsZRsps4mu3KILxneLHupM5sKnexeIw5gcfSePRs/XMO/t7mb64OWHOdkz9lc+/uu8wk8hR8vNoWWu0oO53okFZyk2NCoUWWeIL8UHbVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AZw1DwTqcIKFdlcAeQduX+/3uEL3c9+4zpDIt6d3N4=;
 b=BKqOMUT3e8xiwpr4Jeu5IjsONVO/1ssFVf73FFTPX5jtQ5s9rKrls4TBmlFaF0L6s3dqDwOxZfyGQ+piphE+Cspz29EeYgoccjXpMG65gwE50GrGcDlXY65LeJO5k1IRr/HacAvb+8VYJ4dUo4CCePPTv1Xg/gf91Khrwx2tnKK0uLVoMAfc6dtSGqHI4Lp5tAACWazDVovVH/fl35KfelvpgGuNwQh+nqLPjGD7iRDb+Gq48nYKpQUC2xKdorqZJ8eldSknkGNxtnFviCfkWlunlQEx1h194bVSjmif06F3o/QwgT6FcDREVmK7jTDiq7pXUovcOSeZUzFTDMnKxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AZw1DwTqcIKFdlcAeQduX+/3uEL3c9+4zpDIt6d3N4=;
 b=5fvC/WrFK9EsoWXdVS4vWhdDraXIJdwHUNQdeXB4dz2hdfg1WPNxcCzE1wPToJf5EnQbCcpsDcHsdWpzj3l0pV8gZSyb+gtN4uHAZQo6kwMZbBs1dUw0gBRuBet0p+Z1aiukcN2BRzQPCyJ1FvbwZ/RLD5hkG5CCn0h4jPZ/Ksg=
Received: from MW4P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::7)
 by MN6PR12MB8543.namprd12.prod.outlook.com (2603:10b6:208:47b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Fri, 5 May
 2023 14:59:33 +0000
Received: from CO1NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::8c) by MW4P222CA0002.outlook.office365.com
 (2603:10b6:303:114::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27 via Frontend
 Transport; Fri, 5 May 2023 14:59:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT103.mail.protection.outlook.com (10.13.174.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.27 via Frontend Transport; Fri, 5 May 2023 14:59:32 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 5 May
 2023 09:59:30 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Fix assingment in if condition in amdgpu_irq.c
Date: Fri, 5 May 2023 20:29:14 +0530
Message-ID: <20230505145914.194871-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT103:EE_|MN6PR12MB8543:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d5629c5-429c-40dd-87c9-08db4d795575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fi26f2FJ3Rl4j6u5DDmweaqdTQylXHZr1SNTK44cWmzwfXOWn+F1rmeW4UPEkD6qHba6cNGfDWi2L/7vn9JPzFO08YOwq9rB7LSqcwgQY+gdAD8Spkro1joU939q8dHUwGipMNzXBxaPYjQBxM7a05XKe96v8YkQHHy/ZuQhIYSPAzxA89LxpH18g1X0a7FeG6JWTy1rdPIsagWK1CFaPPIRrb/gH+5foSY1lLJqpXEym1dl4DQyDKxTftt70txMsYw51xA1NVTb6APBPLZLk20mJKEjo7L0+L+vdrfzYdeNVqOyxfsHH/zhKLM2F2lK8TwWzafqCfI3l8lyC+UlrYMcJCfbdzdAds936ARI6GsbWO9sZ+wS1bHNvZWBTfm4nA8TymXWCMrG040zQiRUlcHd/Ic/E2+hacsB2etD6x1ERzgaGPF4xTo59yJKPB3ttjXMM5uJLQLsV3Ks8ybmVc0RPJs6cApsgy2tYXK0lbvawv7emsEFE7bYLpCq9c79KBqiZ41qnX7Hzms9M/aRBq4PIjMN//eXIGXI3Xq7rAI64wQ4gmo8NAAdU28Kr/blQCztvEMxOnHnvG5UZ32PLpM4QcI1nDBpU/NrL7eOJTI6IWGQydiUi1MVhX0wv57hV8k8A78ObUlxgADpzYAZGrp2qVPwwDHM/kDgjAgpt3jiyyli0W+DYxVaUIgR5JTlWCIchu4iuX7jWSAb2eNhOg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(451199021)(40470700004)(46966006)(36840700001)(5660300002)(8936002)(8676002)(44832011)(426003)(66574015)(83380400001)(82310400005)(36860700001)(186003)(47076005)(16526019)(1076003)(2616005)(26005)(336012)(86362001)(81166007)(356005)(70206006)(316002)(6636002)(36756003)(4326008)(70586007)(40460700003)(7696005)(6666004)(110136005)(54906003)(508600001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 14:59:32.1798 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d5629c5-429c-40dd-87c9-08db4d795575
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8543
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

Assignments in if condition are less readable and error-prone.

Fixes below error & warnings reported by checkpatch"

ERROR: do not use assignment in if condition
+       } else if ((src = adev->irq.client[client_id].sources[src_id])) {

WARNING: braces {} are not necessary for any arm of this statement
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 27 +++++++++++++------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index c8413470e057..f312e8ca0015 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -110,7 +110,7 @@ const char *soc15_ih_clientid_name[] = {
 void amdgpu_irq_disable_all(struct amdgpu_device *adev)
 {
 	unsigned long irqflags;
-	unsigned i, j, k;
+	unsigned int i, j, k;
 	int r;
 
 	spin_lock_irqsave(&adev->irq.lock, irqflags);
@@ -269,11 +269,11 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
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
@@ -332,7 +332,7 @@ void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
  */
 void amdgpu_irq_fini_sw(struct amdgpu_device *adev)
 {
-	unsigned i, j;
+	unsigned int i, j;
 
 	for (i = 0; i < AMDGPU_IRQ_CLIENTID_MAX; ++i) {
 		if (!adev->irq.client[i].sources)
@@ -366,7 +366,7 @@ void amdgpu_irq_fini_sw(struct amdgpu_device *adev)
  * 0 on success or error code otherwise
  */
 int amdgpu_irq_add_id(struct amdgpu_device *adev,
-		      unsigned client_id, unsigned src_id,
+		      unsigned int client_id, unsigned int src_id,
 		      struct amdgpu_irq_src *source)
 {
 	if (client_id >= AMDGPU_IRQ_CLIENTID_MAX)
@@ -418,7 +418,7 @@ void amdgpu_irq_dispatch(struct amdgpu_device *adev,
 {
 	u32 ring_index = ih->rptr >> 2;
 	struct amdgpu_iv_entry entry;
-	unsigned client_id, src_id;
+	unsigned int client_id, src_id;
 	struct amdgpu_irq_src *src;
 	bool handled = false;
 	int r;
@@ -431,6 +431,7 @@ void amdgpu_irq_dispatch(struct amdgpu_device *adev,
 
 	client_id = entry.client_id;
 	src_id = entry.src_id;
+	src = adev->irq.client[client_id].sources[src_id];
 
 	if (client_id >= AMDGPU_IRQ_CLIENTID_MAX) {
 		DRM_DEBUG("Invalid client_id in IV: %d\n", client_id);
@@ -446,7 +447,7 @@ void amdgpu_irq_dispatch(struct amdgpu_device *adev,
 		DRM_DEBUG("Unregistered interrupt client_id: %d src_id: %d\n",
 			  client_id, src_id);
 
-	} else if ((src = adev->irq.client[client_id].sources[src_id])) {
+	} else if (src) {
 		r = src->funcs->process(adev, src, &entry);
 		if (r < 0)
 			DRM_ERROR("error processing interrupt (%d)\n", r);
@@ -493,7 +494,7 @@ void amdgpu_irq_delegate(struct amdgpu_device *adev,
  * Updates interrupt state for the specific source (all ASICs).
  */
 int amdgpu_irq_update(struct amdgpu_device *adev,
-			     struct amdgpu_irq_src *src, unsigned type)
+			     struct amdgpu_irq_src *src, unsigned int type)
 {
 	unsigned long irqflags;
 	enum amdgpu_interrupt_state state;
@@ -556,7 +557,7 @@ void amdgpu_irq_gpu_reset_resume_helper(struct amdgpu_device *adev)
  * 0 on success or error code otherwise
  */
 int amdgpu_irq_get(struct amdgpu_device *adev, struct amdgpu_irq_src *src,
-		   unsigned type)
+		   unsigned int type)
 {
 	if (!adev->irq.installed)
 		return -ENOENT;
@@ -586,7 +587,7 @@ int amdgpu_irq_get(struct amdgpu_device *adev, struct amdgpu_irq_src *src,
  * 0 on success or error code otherwise
  */
 int amdgpu_irq_put(struct amdgpu_device *adev, struct amdgpu_irq_src *src,
-		   unsigned type)
+		   unsigned int type)
 {
 	if (!adev->irq.installed)
 		return -ENOENT;
@@ -620,7 +621,7 @@ int amdgpu_irq_put(struct amdgpu_device *adev, struct amdgpu_irq_src *src,
  * invalid parameters
  */
 bool amdgpu_irq_enabled(struct amdgpu_device *adev, struct amdgpu_irq_src *src,
-			unsigned type)
+			unsigned int type)
 {
 	if (!adev->irq.installed)
 		return false;
@@ -733,7 +734,7 @@ void amdgpu_irq_remove_domain(struct amdgpu_device *adev)
  * Returns:
  * Linux IRQ
  */
-unsigned amdgpu_irq_create_mapping(struct amdgpu_device *adev, unsigned src_id)
+unsigned int amdgpu_irq_create_mapping(struct amdgpu_device *adev, unsigned int src_id)
 {
 	adev->irq.virq[src_id] = irq_create_mapping(adev->irq.domain, src_id);
 
-- 
2.25.1

