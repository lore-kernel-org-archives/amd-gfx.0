Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AAD7C433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 19 Feb 2022 00:58:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A15E710EAE3;
	Sat, 19 Feb 2022 00:58:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76AF310EAE3
 for <amd-gfx@lists.freedesktop.org>; Sat, 19 Feb 2022 00:58:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=furn6HJBdooY8SF/5dWhGaYtrgu6yO93pXDL3r3bbUf8ICLW8nfvHhx0WRb8NDKVw97YGtPPfnUX4RYPN9lhTwW0koOKlPx7DVmnf+B5u6srY9wYhjPMGUNdQm8sxA+vC+kY+Vbj5seRKqHupYABpO/C1y/kFPZ++0UUX0veQRLWTSTgPE5NQOa2cJ5z+ImPASWVY8D0ZxOkCnCHRIfsZvxmEk5WCs1xfvQJFW1kNB/rP7Amhpi0AUWtKvhkYMW1s1Cu2927uz7UHWzht0TPiogG77S3/+fYrsmsZxqQ87pTbCbMLPI+fYaYjyH/jjFiG/O3JeidIMBGFoZiKZa+Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwlwSGFytNhmz4aE61y5FsoF5dPXLXZsxCw7pCeodNs=;
 b=EuTiv7wL2L/4H1Tlxh6uU8/EV6HaumgvS6kODRWy2pqbPrlk6RMFlICf7/6ZZHeQ2Xk4n4m7dJ8BgKBgbZ0vfijup0+Kjhq9vtc2HQTEY2ja+3eGxLiI+s9Ym9+BrSVOvUiSesLtmunPYqZyDmTEnqcNCFuoZODUkhf3hZa7Xiun4ksT7DjvnFUdaG2x9gYi2ZYWlZssYTMzzOTZI2szGjlWOje5IZYkhYuGDgE5OHxe/si3q009+PAFeDstGbf9QawzdBsLyXHywYr+nlsVRp02UGSZvZ/RQxs4gPiR8g15cFbUojhVJ521oFra00F80BsFncSCci+GXv0CEp16JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwlwSGFytNhmz4aE61y5FsoF5dPXLXZsxCw7pCeodNs=;
 b=poGBPnbecobVC811DxaVbM7oN8VV/82uEn9DaGxfPlRw6sMVbz12rsSgVN96FAfYg0Kdnh9+swKdr1fPF1Dn0C9fERez6xtFivJ71JoVQw38fku3/8v4U8DdYcNl1Ci5HsNzogU5t1TC5Im3lCaSS75aPFjN0hjmQ+LIXybyMHw=
Received: from BN9PR03CA0857.namprd03.prod.outlook.com (2603:10b6:408:13d::22)
 by MWHPR12MB1918.namprd12.prod.outlook.com (2603:10b6:300:114::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.22; Sat, 19 Feb
 2022 00:58:11 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::61) by BN9PR03CA0857.outlook.office365.com
 (2603:10b6:408:13d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Sat, 19 Feb 2022 00:58:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Sat, 19 Feb 2022 00:58:11 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Feb
 2022 18:58:10 -0600
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdkfd: Use real device for messages
Date: Fri, 18 Feb 2022 19:57:45 -0500
Message-ID: <20220219005745.1559114-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 870b1f4a-3ec4-498e-655f-08d9f342e693
X-MS-TrafficTypeDiagnostic: MWHPR12MB1918:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB191804E63144E7994CB23D8692389@MWHPR12MB1918.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hRbXL1eOhvYwstVimCQXcg1P77eU54AeH+C74O0kWTyvVNYjinVEZO+y/4DcTfg5lCM2BUJl2BpsPPpNBKXBdgj3D1vOKHf8BuAsqObx/UmDIcXzso3X84JTLn+oJWhGFHw831U996TcmE1k7SJ9YMEvvMmmuI5Jh+N/XQhuZuh/VxSF3YC8UrjoaBlSqjlSIPoBvibU9X0lY7JmIUzD7Do2e6s2peRorphX3jeL28AWfg0RAXXT+q5tVLMEbKHTEYKjwIzIt5mAAxmQm2/VETE8iFIxC5r1FHjT8XXT6tcCkFiapiJY7HfC9nxMlLiPl4ZrkmQnEOouz9OaMGJE+BX92XZTwG7of5frdjQLlNx6I+pZKCMMXf8IHj2kAUpU4JTxpEg1w7xHShpqVvC2tiB0KA27mfHKHtDzetQ+dvBQlACkO9SkS9qWpVXD5dNnyfr1aMk6QlEQ8GlMXrNzPZAX+hsvMMgf2bT1wk26Fv4kHLqyObOf3bO9c/p/xbJwX64PWpE28XpcpCFj+47k8svkXw1x1gVAfojF0SNqeBLP3fjp7Plr6SjNLtwMcZvfTdiFyeAkEW5kvN7aoLXAfIlefP/DDbZK62YVzGMaD70A/Te8CqmZLr1fOuDCq9qQWwIfQrZQNGUJL23o7xtItK35pIsdop2jpUrfvx7eJOpzHjspQGlRllrLaqcZ+BvyEzXTxNNRF/+zRsM88BZgBg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(508600001)(83380400001)(426003)(336012)(47076005)(16526019)(2906002)(40460700003)(26005)(186003)(1076003)(15650500001)(81166007)(36756003)(86362001)(356005)(2616005)(8936002)(5660300002)(70586007)(70206006)(8676002)(6666004)(7696005)(82310400004)(4326008)(6916009)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2022 00:58:11.0508 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 870b1f4a-3ec4-498e-655f-08d9f342e693
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1918
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
Cc: kent.russell@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

kfd_chardev() doesn't provide much useful information in dev_... messages
on multi-GPU systems because there is only one KFD device, which doesn't
correspond to any particular GPU. Use the actual GPU device to indicate
the GPU that caused a message.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c   | 5 -----
 drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c | 8 ++++----
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h      | 1 -
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 7affec907fd1..ceeb0d5e9060 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -104,11 +104,6 @@ void kfd_chardev_exit(void)
 	kfd_device = NULL;
 }
 
-struct device *kfd_chardev(void)
-{
-	return kfd_device;
-}
-
 
 static int kfd_open(struct inode *inode, struct file *filep)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
index 7041a6714baa..9178cfe34f20 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
@@ -58,14 +58,14 @@ int kfd_interrupt_init(struct kfd_dev *kfd)
 		KFD_IH_NUM_ENTRIES * kfd->device_info.ih_ring_entry_size,
 		GFP_KERNEL);
 	if (r) {
-		dev_err(kfd_chardev(), "Failed to allocate IH fifo\n");
+		dev_err(kfd->adev->dev, "Failed to allocate IH fifo\n");
 		return r;
 	}
 
 	kfd->ih_wq = alloc_workqueue("KFD IH", WQ_HIGHPRI, 1);
 	if (unlikely(!kfd->ih_wq)) {
 		kfifo_free(&kfd->ih_fifo);
-		dev_err(kfd_chardev(), "Failed to allocate KFD IH workqueue\n");
+		dev_err(kfd->adev->dev, "Failed to allocate KFD IH workqueue\n");
 		return -ENOMEM;
 	}
 	spin_lock_init(&kfd->interrupt_lock);
@@ -117,7 +117,7 @@ bool enqueue_ih_ring_entry(struct kfd_dev *kfd,	const void *ih_ring_entry)
 	count = kfifo_in(&kfd->ih_fifo, ih_ring_entry,
 				kfd->device_info.ih_ring_entry_size);
 	if (count != kfd->device_info.ih_ring_entry_size) {
-		dev_dbg_ratelimited(kfd_chardev(),
+		dev_dbg_ratelimited(kfd->adev->dev,
 			"Interrupt ring overflow, dropping interrupt %d\n",
 			count);
 		return false;
@@ -148,7 +148,7 @@ static void interrupt_wq(struct work_struct *work)
 	uint32_t ih_ring_entry[KFD_MAX_RING_ENTRY_SIZE];
 
 	if (dev->device_info.ih_ring_entry_size > sizeof(ih_ring_entry)) {
-		dev_err_once(kfd_chardev(), "Ring entry too small\n");
+		dev_err_once(dev->adev->dev, "Ring entry too small\n");
 		return;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 783d53a3dd9e..f36062be9ca8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -355,7 +355,6 @@ enum kfd_mempool {
 /* Character device interface */
 int kfd_chardev_init(void);
 void kfd_chardev_exit(void);
-struct device *kfd_chardev(void);
 
 /**
  * enum kfd_unmap_queues_filter - Enum for queue filters.
-- 
2.32.0

