Return-Path: <SRS0=OLwD=MI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45FBC636C8
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 03:11:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F5AF601FA
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 03:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F5AF601FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC3626E8E4;
	Fri, 16 Jul 2021 03:11:02 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2062.outbound.protection.outlook.com [40.107.100.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49C996E8E4
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jul 2021 03:11:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ku8FUl+FTsyI7FID7GYv7lyWZdTgI0WdWF306Li0/ZBuUk03vbnBy+oGgKqkBVOv8yy8fi2B1prBZ1SWEER1mS2qefW3OZm6o1Cu8jjT8UR1jVRaBuuJ1B/ZO8pI/NO3+M74eH48MNMpZg0dnsqt8Xt4KZkgDaM9D1IrseT1GnHqbmryC0wdfIwMqbYGKp4mUXXwMwSbMZVIgBBl9uJY7RQRGIAjoE7tCXIDvlY0mhZTeui+aNF8/iu2/HNuHMJyzf2kBpIiKXcXgpICtSpNq0+2H0+/IjSGNe3e4+x5UhMg10KftBUfovWDXj2fN3eNiuji9ZSlsz4LfDQHdTVyog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5veALvte84s2QPqm6IGaXvzglm7SoVMvxYM13lMfFR0=;
 b=aHSO26ul9Vwuykag3gsTNvRqLw7eQxJ4J1Sn4JmCWIJmgGdT2mcYTy02XIj/yByh9rYSA8OXmjkaWWb9pMITZzHaYPNZAzSlG1cVTDOx8ruZQj5UNSeDPtvkNWZ+kTeMikSgR75e4mZ4kecxseaYISthx7iRoa3NwtvyYhCliUBMXch4Gwu+uN0AlJJg670fPgbDIlirSVi54OS0Zn6Z3G6mnUFEJRVMtJR5vyL04wtaN88DAPPrY6CX5zeLXRkPh345jW0EQoSGcG1dKiwrvMvtURAIxo5omVVMIQrNttAHveiQtMFYXaKYM1ZfYk9oPmMknNzptiRjjpp4bvbbQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5veALvte84s2QPqm6IGaXvzglm7SoVMvxYM13lMfFR0=;
 b=ZwSzvrBy4gFK0JwWef5xjBtU7wCjfie9+rUAXdkRRMV2j3x9GZZJTDylSeAhhn/II9CRNNYSLE9JILSrH4vlgLSIdrfEVt8ZjYRF0bJsGoxo7VzKXwsBROYXhCS5kGm8FmugkqGYLkk+4KgAAiz2ZTaYcrsR5oDJjmJFpSjf618=
Received: from BN9PR03CA0547.namprd03.prod.outlook.com (2603:10b6:408:138::12)
 by MN2PR12MB3390.namprd12.prod.outlook.com (2603:10b6:208:c9::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Fri, 16 Jul
 2021 03:10:57 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::7a) by BN9PR03CA0547.outlook.office365.com
 (2603:10b6:408:138::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Fri, 16 Jul 2021 03:10:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 03:10:57 +0000
Received: from kevin-ws.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 15 Jul
 2021 22:10:55 -0500
From: Kevin Wang <kevin1.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [RFC PATCH v2 1/3] drm/amdgpu: split amdgpu_device_access_vram() into
 two small parts
Date: Fri, 16 Jul 2021 11:10:40 +0800
Message-ID: <20210716031042.827317-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef3042fa-6093-4355-050b-08d948075503
X-MS-TrafficTypeDiagnostic: MN2PR12MB3390:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3390FA4C5D214CEE51918BCCA2119@MN2PR12MB3390.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gcsrm/lQVEE0J6XxBXQ4QEB0aw/3yzqslDdk8ypKxbXdvjVQXXsb8xQHc35T1ATe8sIVfvQUUcCBh+0fX+Ls5yo8xhrTqrBppxfoUY90UGmcR/hfNqayIQVX+FYJMgmEEHz7zSmAjn0zB09i1PAUmwaQuLKGdImplBmEq4tFHNt81GOfs0J0feB9yk3LaiOkFifWVF2HkSUgt/MjzTcghewUiv1nYQZgjFb0aBCnP8zuC0lTh5QLUQFcXhZ1GEQtkAKDq6bF6zonvm9tNEPIGQWdqumafg9ebKB+E2Wr874brIQw0aVhTrTkB5xR8gpZkSPDwHM0wooaQUmoRGXnEVvq9hf6BgfvRbnW2s4VFyHVyUtaTBxJi1AgsEdO2ZI6LCoO3kg3eYMawl1U57GdloOOgr21bTN+JffqDdZ0cPiZ8WrYbhyUGpArYSUqpOvbXw23dl3WkkVqTp9M8JZziXvdDB5ZPJhdK2ZVK07H3MWloGEDvAKo+UcUhigQRNpJCN9nhrCYA/mU2G0boOkESBHM+hNJPb//dwNvD4pvPcj0rAssPI4q7PAH8+S0Q8T6/mY7y83BJWRiYwG/u/QUHFgOwbq7hfBflN3iC3iIPJq1eBZpgQ4c40KAZQ1xYVKlf9q/WK9patsnugAmCWQZ/n+rtPrJcyJPW7AW7vvizi4rnQBiqHmfylAQjXqKwkbCsPRgvruPGR/aTh/BFTHpOSVKSfJ0iVxdvU+T/lH5l6s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39830400003)(376002)(36840700001)(46966006)(86362001)(82310400003)(426003)(26005)(2616005)(54906003)(6916009)(356005)(36860700001)(81166007)(1076003)(16526019)(6666004)(8676002)(47076005)(70586007)(186003)(508600001)(70206006)(4326008)(5660300002)(8936002)(7696005)(336012)(83380400001)(2906002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 03:10:57.7338 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3042fa-6093-4355-050b-08d948075503
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3390
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
Cc: Kevin
 Wang <kevin1.wang@amd.com>, lijo.lazar@amd.com, alexander.deucher@amd.com,
 frank.min@amd.com, christian.koenig@amd.com, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

split amdgpu_device_access_vram()
1. amdgpu_device_mm_access(): using MM_INDEX/MM_DATA to access vram
2. amdgpu_device_aper_access(): using vram aperature to access vram (option)

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 98 ++++++++++++++++------
 2 files changed, 79 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 61a0897e984a..54cf647bd018 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1109,8 +1109,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 void amdgpu_device_fini(struct amdgpu_device *adev);
 int amdgpu_gpu_wait_for_idle(struct amdgpu_device *adev);
 
+void amdgpu_device_mm_access(struct amdgpu_device *adev, loff_t pos,
+			     void *buf, size_t size, bool write);
+size_t amdgpu_device_aper_access(struct amdgpu_device *adev, loff_t pos,
+				 void *buf, size_t size, bool write);
+
 void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
-			       uint32_t *buf, size_t size, bool write);
+			       void *buf, size_t size, bool write);
 uint32_t amdgpu_device_rreg(struct amdgpu_device *adev,
 			    uint32_t reg, uint32_t acc_flags);
 void amdgpu_device_wreg(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index eb1f3f42e00b..37fa199be8b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -285,7 +285,7 @@ bool amdgpu_device_supports_smart_shift(struct drm_device *dev)
  */
 
 /**
- * amdgpu_device_vram_access - read/write a buffer in vram
+ * amdgpu_device_mm_access - access vram by MM_INDEX/MM_DATA
  *
  * @adev: amdgpu_device pointer
  * @pos: offset of the buffer in vram
@@ -293,19 +293,60 @@ bool amdgpu_device_supports_smart_shift(struct drm_device *dev)
  * @size: read/write size, sizeof(@buf) must > @size
  * @write: true - write to vram, otherwise - read from vram
  */
-void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
-			       uint32_t *buf, size_t size, bool write)
+void amdgpu_device_mm_access(struct amdgpu_device *adev, loff_t pos,
+			     void *buf, size_t size, bool write)
 {
 	unsigned long flags;
-	uint32_t hi = ~0;
+	uint32_t hi = ~0, tmp = 0;
+	uint32_t *data = buf;
 	uint64_t last;
 
+	BUG_ON(!IS_ALIGNED(pos, 4) || !IS_ALIGNED(size, 4));
+
+	spin_lock_irqsave(&adev->mmio_idx_lock, flags);
+	for (last = pos + size; pos < last; pos += 4) {
+		tmp = pos >> 31;
 
+		WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)pos) | 0x80000000);
+		if (tmp != hi) {
+			WREG32_NO_KIQ(mmMM_INDEX_HI, tmp);
+			hi = tmp;
+		}
+		if (write)
+			WREG32_NO_KIQ(mmMM_DATA, *data++);
+		else
+			*data++ = RREG32_NO_KIQ(mmMM_DATA);
+	}
+
+	spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
+}
+
+/**
+ * amdgpu_device_vram_access - access vram by vram aperature
+ *
+ * @adev: amdgpu_device pointer
+ * @pos: offset of the buffer in vram
+ * @buf: virtual address of the buffer in system memory
+ * @size: read/write size, sizeof(@buf) must > @size
+ * @write: true - write to vram, otherwise - read from vram
+ *
+ * The return value means how many bytes have been transferred.
+ */
+size_t amdgpu_device_aper_access(struct amdgpu_device *adev, loff_t pos,
+				 void *buf, size_t size, bool write)
+{
 #ifdef CONFIG_64BIT
+	void __iomem *addr;
+	size_t count = 0;
+	uint64_t last;
+
+	if (!adev->mman.aper_base_kaddr)
+		return 0;
+
 	last = min(pos + size, adev->gmc.visible_vram_size);
 	if (last > pos) {
-		void __iomem *addr = adev->mman.aper_base_kaddr + pos;
-		size_t count = last - pos;
+		addr = adev->mman.aper_base_kaddr + pos;
+		count = last - pos;
 
 		if (write) {
 			memcpy_toio(addr, buf, count);
@@ -317,30 +358,37 @@ void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
 			memcpy_fromio(buf, addr, count);
 		}
 
-		if (count == size)
-			return;
-
-		pos += count;
-		buf += count / 4;
-		size -= count;
 	}
+
+	return count;
+#else
+	return 0;
 #endif
+}
 
-	spin_lock_irqsave(&adev->mmio_idx_lock, flags);
-	for (last = pos + size; pos < last; pos += 4) {
-		uint32_t tmp = pos >> 31;
+/**
+ * amdgpu_device_vram_access - read/write a buffer in vram
+ *
+ * @adev: amdgpu_device pointer
+ * @pos: offset of the buffer in vram
+ * @buf: virtual address of the buffer in system memory
+ * @size: read/write size, sizeof(@buf) must > @size
+ * @write: true - write to vram, otherwise - read from vram
+ */
+void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
+			       void *buf, size_t size, bool write)
+{
+	size_t count;
 
-		WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)pos) | 0x80000000);
-		if (tmp != hi) {
-			WREG32_NO_KIQ(mmMM_INDEX_HI, tmp);
-			hi = tmp;
-		}
-		if (write)
-			WREG32_NO_KIQ(mmMM_DATA, *buf++);
-		else
-			*buf++ = RREG32_NO_KIQ(mmMM_DATA);
+	/* try to using vram apreature to access vram first */
+	count = amdgpu_device_aper_access(adev, pos, buf, size, write);
+	size -= count;
+	if (size) {
+		/* using MM to access rest vram */
+		pos += count;
+		buf += count;
+		amdgpu_device_mm_access(adev, pos, buf, size, write);
 	}
-	spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
 }
 
 /*
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
