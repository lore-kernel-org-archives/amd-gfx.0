Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEDF8C48BC3
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Feb 2024 06:41:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1460010E154;
	Mon, 19 Feb 2024 06:41:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c6qgx1tW";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4DC010E154
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Feb 2024 06:41:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHiDMTjnPjTa8HDtBGtBSNAluB4PLxh7DPVuYYsfENuNkf+v7vapbZVE0E57IfSc6w5RE4dBlhhZPgSbdNx7AeS92QzsnB62nZa1jlIPiaLWXajQh/I3Tqb3iosSYth3qQIzkNBfPTIt3WkfEosLJgFDbgq7N8uwwI+VA2u/uQZ1lNMFkkmhHLwpzhHum+rXbBxUNJJmiQO5wDKVf7LBd30fdbvQzSftgTt7nMNMKl+3iOPD2b43oynWBFjbGggPKZfw+Y7ZZo0bdRxu8Gmq3iTGPiUJ4EWYlPG3MdbKhArftZE+VYSdXAFEl2WkMqmUt1lDOCh7htk6kjADeu7d9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKnQRxZabXl2k/RpV7pca8jU2Yc5r5mC+74Qe8eQuQ8=;
 b=hnlCbLQUreQujNx62tmdGuGNrFENvdqq0W3zOQBlar8dMGNlAwLQeoFtcg+ZmZhdz1utqZ2m9cltU5Bq3O4fel4nZTz1P0QF95XbX0/WtbF/p23QB0hL/6oYdJIzWXW2vBDDuLF7TFQyjGvsmkRFlfA0kTCVVWo5JnwnMJ7BtNbINvu8u75Pz4PDTxQFh6fTkjpAadWw0v7OJF3BcVXZp+ZOpJVmCo6Il16Nu2+NePiKSg0ZrSo2PBDCziMMZ1w5cT16xALWaf+5VegPR8f3nfDAvLQv0wIVRwCl0PskvBIwLaQziD8yrg1L7G0DiefzrcP6FbzbllGP2be1Zc9D4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKnQRxZabXl2k/RpV7pca8jU2Yc5r5mC+74Qe8eQuQ8=;
 b=c6qgx1tWhx5w5W3c1xa4in9h1zqiWDChhGPPQiIx+QQ2ZnDLTmmmDwhc6ufqqNYfm5FiDLFsLDJN0LkkRpjxuTc4450xBp36f3OL8EtHkpQdkyx15Eu94m8+R0Pya+WWq0BQLw2ubeCZ+79rAOFQQNzFpTq7vIkRwK9IcIMQaHw=
Received: from BN8PR07CA0033.namprd07.prod.outlook.com (2603:10b6:408:ac::46)
 by DM4PR12MB7719.namprd12.prod.outlook.com (2603:10b6:8:101::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Mon, 19 Feb
 2024 06:41:11 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:ac:cafe::16) by BN8PR07CA0033.outlook.office365.com
 (2603:10b6:408:ac::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34 via Frontend
 Transport; Mon, 19 Feb 2024 06:41:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Mon, 19 Feb 2024 06:41:11 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 19 Feb
 2024 00:41:09 -0600
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <Alexander.Deucher@amd.com>
CC: Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH] drm/amdgpu: Drop redundant parameter in
 amdgpu_gfx_kiq_init_ring
Date: Mon, 19 Feb 2024 14:40:55 +0800
Message-ID: <20240219064055.1678968-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|DM4PR12MB7719:EE_
X-MS-Office365-Filtering-Correlation-Id: ca9b05e2-4dd4-4c44-b31b-08dc3115c2cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C1juj6pPkZXdcCjzPH2+Ti9WylRcVyEhLJnMF9vc2Lq27WVbbhNW0+AwVFqOCTwRVQDhnFeFG23O1UnxF0W2iW1CF/J+Z1OEkJbqMoXjz+2baLuZeowu2UgGiToNNvrrA9AciPFCxtWqwZkVechwVJemIJ9H3OFzu4OHCo4IHK4wR4DvLjcjS/iY2VFRRZkb+Xp4eRl+5RsaE+G8aG+e7hF1ebzJsW5RjBIIzD5KIPUi6c75lVHTrhELF/tqEABcEdOduNWjJKY0IXqxk/AUxor2h/8Xr2yYnMgo0D7k39jcWWQkz2OIX+pasoYh8cp0+NSU8vF4PNA2nHLgx3Ujy2tbEV0H6r/39plOfq1roBEqdBq9nvO92ld6yFToBJPEzCJcFZMjyqoLeXpgQR/NrhSQorGYAHJDlpOIzXIFfN4KDzaWkNaMb6NZl0OknF31IEBabH3jJTdlm9M6TrmSywYzGk+6pi4K6eFr8UicPZWM0NwCB5QsWh3oynf8V3qJeO2BWfUizFmngCeEIvP0Lg67pKhaNg5wKWJ+h+HlGNamPfAbpbjZShUCAFjfKAd39Xx5RYIRZ7fcqIoImHgbKLqntvp1mtMnp5a23SQyRjZkqGDoZwdeyCjjhJzFwGl7Q2pwM8fMF+0SFKk85DqIxQk3zGDPPdri1ScBvaYYkcE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(64100799003)(451199024)(186009)(36860700004)(82310400011)(1800799012)(40470700004)(46966006)(6636002)(6666004)(7696005)(316002)(478600001)(110136005)(70206006)(4326008)(2906002)(70586007)(8676002)(8936002)(5660300002)(41300700001)(86362001)(82740400003)(36756003)(2616005)(1076003)(426003)(336012)(26005)(16526019)(81166007)(356005)(83380400001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 06:41:11.1568 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca9b05e2-4dd4-4c44-b31b-08dc3115c2cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7719
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

Drop redundant parameters in function amdgpu_gfx_kiq_init_ring
to simplify the code

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 4 +---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 5 ++---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 5 ++---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 5 ++---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 5 ++---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 4 +---
 7 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index e114694d1131..4835d6d899e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -304,11 +304,11 @@ static int amdgpu_gfx_kiq_acquire(struct amdgpu_device *adev,
 	return -EINVAL;
 }
 
-int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
-			     struct amdgpu_ring *ring,
-			     struct amdgpu_irq_src *irq, int xcc_id)
+int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev, int xcc_id)
 {
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
+	struct amdgpu_irq_src *irq = &kiq->irq;
+	struct amdgpu_ring *ring = &kiq->ring;
 	int r = 0;
 
 	spin_lock_init(&kiq->ring_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index f23bafec71c5..8fcf889ddce9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -471,9 +471,7 @@ static inline u32 amdgpu_gfx_create_bitmask(u32 bit_width)
 void amdgpu_gfx_parse_disable_cu(unsigned *mask, unsigned max_se,
 				 unsigned max_sh);
 
-int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
-			     struct amdgpu_ring *ring,
-			     struct amdgpu_irq_src *irq, int xcc_id);
+int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev, int xcc_id);
 
 void amdgpu_gfx_kiq_free_ring(struct amdgpu_ring *ring);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index b02d63328f1c..691fa40e4e01 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4490,7 +4490,7 @@ static int gfx_v10_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 static int gfx_v10_0_sw_init(void *handle)
 {
 	int i, j, k, r, ring_id = 0;
-	struct amdgpu_kiq *kiq;
+	int xcc_id = 0;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
@@ -4619,8 +4619,7 @@ static int gfx_v10_0_sw_init(void *handle)
 			return r;
 		}
 
-		kiq = &adev->gfx.kiq[0];
-		r = amdgpu_gfx_kiq_init_ring(adev, &kiq->ring, &kiq->irq, 0);
+		r = amdgpu_gfx_kiq_init_ring(adev, xcc_id);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 2fb1342d5bd9..9d8ec709cd52 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1329,7 +1329,7 @@ static int gfx_v11_0_rlc_backdoor_autoload_enable(struct amdgpu_device *adev)
 static int gfx_v11_0_sw_init(void *handle)
 {
 	int i, j, k, r, ring_id = 0;
-	struct amdgpu_kiq *kiq;
+	int xcc_id = 0;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
@@ -1454,8 +1454,7 @@ static int gfx_v11_0_sw_init(void *handle)
 			return r;
 		}
 
-		kiq = &adev->gfx.kiq[0];
-		r = amdgpu_gfx_kiq_init_ring(adev, &kiq->ring, &kiq->irq, 0);
+		r = amdgpu_gfx_kiq_init_ring(adev, xcc_id);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index ea174b76ee70..b97ea62212b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1900,8 +1900,8 @@ static void gfx_v8_0_sq_irq_work_func(struct work_struct *work);
 static int gfx_v8_0_sw_init(void *handle)
 {
 	int i, j, k, r, ring_id;
+	int xcc_id = 0;
 	struct amdgpu_ring *ring;
-	struct amdgpu_kiq *kiq;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	switch (adev->asic_type) {
@@ -2022,8 +2022,7 @@ static int gfx_v8_0_sw_init(void *handle)
 		return r;
 	}
 
-	kiq = &adev->gfx.kiq[0];
-	r = amdgpu_gfx_kiq_init_ring(adev, &kiq->ring, &kiq->irq, 0);
+	r = amdgpu_gfx_kiq_init_ring(adev, xcc_id);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 169d45268ef6..7669f82aa1da 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1997,8 +1997,8 @@ static int gfx_v9_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 static int gfx_v9_0_sw_init(void *handle)
 {
 	int i, j, k, r, ring_id;
+	int xcc_id = 0;
 	struct amdgpu_ring *ring;
-	struct amdgpu_kiq *kiq;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	unsigned int hw_prio;
 
@@ -2151,8 +2151,7 @@ static int gfx_v9_0_sw_init(void *handle)
 		return r;
 	}
 
-	kiq = &adev->gfx.kiq[0];
-	r = amdgpu_gfx_kiq_init_ring(adev, &kiq->ring, &kiq->irq, 0);
+	r = amdgpu_gfx_kiq_init_ring(adev, xcc_id);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index aace4594a603..ec92c3c2080b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -843,7 +843,6 @@ static int gfx_v9_4_3_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 static int gfx_v9_4_3_sw_init(void *handle)
 {
 	int i, j, k, r, ring_id, xcc_id, num_xcc;
-	struct amdgpu_kiq *kiq;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	adev->gfx.mec.num_mec = 2;
@@ -912,8 +911,7 @@ static int gfx_v9_4_3_sw_init(void *handle)
 			return r;
 		}
 
-		kiq = &adev->gfx.kiq[xcc_id];
-		r = amdgpu_gfx_kiq_init_ring(adev, &kiq->ring, &kiq->irq, xcc_id);
+		r = amdgpu_gfx_kiq_init_ring(adev, xcc_id);
 		if (r)
 			return r;
 
-- 
2.34.1

