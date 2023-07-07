Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB06DEB64D9
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 15:49:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C40D10E5B7;
	Fri,  7 Jul 2023 15:49:31 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31EF810E5B7
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 15:49:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmfCLJeXarq2dvvxe8II+CLPRQoe/edx9wZsKwVEwpKUllSi3Ur7eYypC1gtDiwaYPYABuK5OSfzAL0J4STfCHskt6bxVxeDCG3jrWajkd0DnyYdrlsiGqhZmHro5cMNeYQltgThnmwcc4abTZnLsn1sQlSoXoAgI/F01b1OZcbHqJJKSAM3PbkmVnH7AGQarQINU51UN6hZA5wsxXDTcz0lrTHZiv9kFtXIlis/26i449ws2614mN0rUV0bXVuQzt2w8iiR8z87KJdCjjiCqMYMbPFTygQoJ6SK5HZ/QN0ZZocN30a60oo8062TNyOD38nmHT8gZ8C8BQUSQJZV4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YdF68HjkU0qfGGmtkXzAAYUSWZ+EnkEar3p/s46+57Q=;
 b=cDXr07lwl1kCnq6DecOwOQj6j2uCyYYBDhFnFupKwUN7Hypp/uZjihwGjD02rL3LKHS8MFNloAFUfSMdPMu03zpgQ2xiYeEYk+WzrlhruuG8vId610fmfrs2C4Z0ldCyXEDcg218sxHDsHmuRVulpMdx0NoxvD0jjFmhng4tuFU+gzO+pY69MfGx5in8lvFMaQ3SdxxH5mhjEGDb4bCdotzw4fiA0ZwJeeILDb8j89aFtjq/4tOfo58/y0odEot+mfc3Kh1eU1TUhkzYpkEld0pmXb0LlQ0AMjZj7NQwQJ9wNTIaX+RDW38RZDtdR0zaRiKJA28+Lwqnujiz6BdSeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YdF68HjkU0qfGGmtkXzAAYUSWZ+EnkEar3p/s46+57Q=;
 b=LOxiUYLxjRj+yi9xSzMusgXSQXNoJKSU82vYmP4PvveAdZKbq4yr3kXLH+QTs4B96y+ULTTCk4DDcpB8vbqwQ0AEL8LM2VS/kcZE0NI7YhoYif/Hy+wlp+wh40MwVBZ1dr9outyD4V1H9alNS/j1ubL2tj9Qzq35h8BGtXN6n/I=
Received: from BN8PR16CA0022.namprd16.prod.outlook.com (2603:10b6:408:4c::35)
 by SA1PR12MB8885.namprd12.prod.outlook.com (2603:10b6:806:376::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 15:49:27 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::b4) by BN8PR16CA0022.outlook.office365.com
 (2603:10b6:408:4c::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25 via Frontend
 Transport; Fri, 7 Jul 2023 15:49:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Fri, 7 Jul 2023 15:49:26 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 7 Jul
 2023 10:49:26 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Increase soft IH ring size
Date: Fri, 7 Jul 2023 11:49:01 -0400
Message-ID: <20230707154901.29568-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT051:EE_|SA1PR12MB8885:EE_
X-MS-Office365-Filtering-Correlation-Id: 307b37ea-bef1-43c8-c9d4-08db7f01be5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fi/geDNrkwsJwkjT886S2Pl8CAHNLL5xWCt263BzBY28TUP/q/hUfzyb8Y8Xqcj0oi1JhNoR7rvZjYJSN2VNsgAxuXetCiyen8GYsBtH/+AVrMnwqrsIlCPOnHH/zEX2ZB5a0UfpCfln43e7LPGZ6IgDFAnEUb5iGpghyC7io6aTTHouj/nKDqZBXAWRwv8hnMLSs0T/mOvML4NEBQdJjYEJ37VwQ7Ao8HQ8M7mWx7zwyRh2CGYraa62Y5mqjbPOpniHW10FkMQhlVWmcohDyyeWwYW7XswCfVQY6xIqS8SMp4ianTdgoz4RuTYr2iH0mpvjlTjKtw1pjlstPLieMsZvOqYvWM761BP/gwi3ipUNwjpuJNnQ8qWxTHrPEbe9shkALUtHxXnL1/mqWnES/nvW1r7iw608laF5Ly4r+yzrbuqQRyw1R+U+ywXtesCn3JE/i0OqBkk/hj/n1VbQv7TFCWCGIJstUdB/qp9D59e3rOanLkJk2G201byf8mygUKKs6kaZbdI4uNziIrzGWxb00jou3s8MazQJRPeJGbCxF0MLpV/aqdCzJBVm6gnWoeWw4TwYijPiVK9I5a4nlt9HAwruQMeVnGvaZY1liqNdya6oIlNA38X49WqnlJva44mbMNQW8ufc5hkkNU2/tpKbjQl0PsVD/46ig9yflhlHBCFKSBI/6cB1B5s8INa2Z9Mnr47DbInD5lhMBswVTzMeG3e7yBZAJQYaehga7p0BDwBH8VABreyToHq8hYObHcixr44Nno0s3D3EdZ8Q6A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199021)(36840700001)(46966006)(40470700004)(82310400005)(7696005)(6666004)(40460700003)(316002)(8676002)(8936002)(41300700001)(186003)(40480700001)(36756003)(16526019)(336012)(1076003)(26005)(478600001)(83380400001)(47076005)(54906003)(70206006)(70586007)(426003)(356005)(81166007)(4326008)(6916009)(82740400003)(5660300002)(2906002)(36860700001)(2616005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 15:49:26.8100 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 307b37ea-bef1-43c8-c9d4-08db7f01be5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8885
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
Cc: mukul.joshi@amd.com, Felix.Kuehling@amd.com,
 Philip Yang <Philip.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Retry faults are delegated to soft IH ring and then processed by
deferred worker. Current soft IH ring size PAGE_SIZE can store 128
entries, which may overflow and drop retry faults, causes HW stucks
because the retry fault is not recovered.

Increase soft IH ring size to 8KB, enough to store 256 CAM entries
because we clear the CAM entry after handling the retry fault from soft
ring.

Define macro IH_RING_SIZE and IH_SW_RING_SIZE to remove duplicate
constant.

Show warning message if soft IH ring overflows because this should not
happen.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c  | 8 ++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h  | 7 +++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c    | 4 ++--
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c  | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c  | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c  | 4 ++--
 7 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
index fceb3b384955..51a0dbd2358a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
@@ -138,6 +138,7 @@ void amdgpu_ih_ring_fini(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
 /**
  * amdgpu_ih_ring_write - write IV to the ring buffer
  *
+ * @adev: amdgpu_device pointer
  * @ih: ih ring to write to
  * @iv: the iv to write
  * @num_dw: size of the iv in dw
@@ -145,8 +146,8 @@ void amdgpu_ih_ring_fini(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
  * Writes an IV to the ring buffer using the CPU and increment the wptr.
  * Used for testing and delegating IVs to a software ring.
  */
-void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
-			  unsigned int num_dw)
+void amdgpu_ih_ring_write(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
+			  const uint32_t *iv, unsigned int num_dw)
 {
 	uint32_t wptr = le32_to_cpu(*ih->wptr_cpu) >> 2;
 	unsigned int i;
@@ -161,6 +162,9 @@ void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
 	if (wptr != READ_ONCE(ih->rptr)) {
 		wmb();
 		WRITE_ONCE(*ih->wptr_cpu, cpu_to_le32(wptr));
+	} else {
+		dev_warn(adev->dev, "IH soft ring buffer overflow 0x%X, 0x%X\n",
+			 wptr, ih->rptr);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
index dd1c2eded6b9..6c6184f0dbc1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
@@ -27,6 +27,9 @@
 /* Maximum number of IVs processed at once */
 #define AMDGPU_IH_MAX_NUM_IVS	32
 
+#define IH_RING_SIZE	(256 * 1024)
+#define IH_SW_RING_SIZE	(8 * 1024)	/* enough for 256 CAM entries */
+
 struct amdgpu_device;
 struct amdgpu_iv_entry;
 
@@ -97,8 +100,8 @@ struct amdgpu_ih_funcs {
 int amdgpu_ih_ring_init(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
 			unsigned ring_size, bool use_bus_addr);
 void amdgpu_ih_ring_fini(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
-void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
-			  unsigned int num_dw);
+void amdgpu_ih_ring_write(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
+			  const uint32_t *iv, unsigned int num_dw);
 int amdgpu_ih_wait_on_checkpoint_process_ts(struct amdgpu_device *adev,
 					    struct amdgpu_ih_ring *ih);
 int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 5273decc5753..fa6d0adcec20 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -493,7 +493,7 @@ void amdgpu_irq_delegate(struct amdgpu_device *adev,
 			 struct amdgpu_iv_entry *entry,
 			 unsigned int num_dw)
 {
-	amdgpu_ih_ring_write(&adev->irq.ih_soft, entry->iv_entry, num_dw);
+	amdgpu_ih_ring_write(adev, &adev->irq.ih_soft, entry->iv_entry, num_dw);
 	schedule_work(&adev->irq.ih_soft_work);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
index b02e1cef78a7..980b24120080 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
@@ -535,7 +535,7 @@ static int ih_v6_0_sw_init(void *handle)
 	 * use bus address for ih ring by psp bl */
 	use_bus_addr =
 		(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) ? false : true;
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, 256 * 1024, use_bus_addr);
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, IH_RING_SIZE, use_bus_addr);
 	if (r)
 		return r;
 
@@ -548,7 +548,7 @@ static int ih_v6_0_sw_init(void *handle)
 	/* initialize ih control register offset */
 	ih_v6_0_init_register_offset(adev);
 
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, PAGE_SIZE, true);
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_SW_RING_SIZE, true);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index eec13cb5bf75..b6a8478dabf4 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -565,7 +565,7 @@ static int navi10_ih_sw_init(void *handle)
 		use_bus_addr = false;
 	else
 		use_bus_addr = true;
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, 256 * 1024, use_bus_addr);
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, IH_RING_SIZE, use_bus_addr);
 	if (r)
 		return r;
 
@@ -578,7 +578,7 @@ static int navi10_ih_sw_init(void *handle)
 	/* initialize ih control registers offset */
 	navi10_ih_init_register_offset(adev);
 
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, PAGE_SIZE, true);
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_SW_RING_SIZE, true);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
index 1e83db0c5438..d364c6dd152c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -485,7 +485,7 @@ static int vega10_ih_sw_init(void *handle)
 	if (r)
 		return r;
 
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, 256 * 1024, true);
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, IH_RING_SIZE, true);
 	if (r)
 		return r;
 
@@ -510,7 +510,7 @@ static int vega10_ih_sw_init(void *handle)
 	/* initialize ih control registers offset */
 	vega10_ih_init_register_offset(adev);
 
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, PAGE_SIZE, true);
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_SW_RING_SIZE, true);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index 4d719df376a7..544ee55a22da 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -539,7 +539,7 @@ static int vega20_ih_sw_init(void *handle)
 	    (adev->ip_versions[OSSSYS_HWIP][0] == IP_VERSION(4, 4, 2)))
 		use_bus_addr = false;
 
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, 256 * 1024, use_bus_addr);
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, IH_RING_SIZE, use_bus_addr);
 	if (r)
 		return r;
 
@@ -565,7 +565,7 @@ static int vega20_ih_sw_init(void *handle)
 	/* initialize ih control registers offset */
 	vega20_ih_init_register_offset(adev);
 
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, PAGE_SIZE, use_bus_addr);
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_SW_RING_SIZE, use_bus_addr);
 	if (r)
 		return r;
 
-- 
2.35.1

