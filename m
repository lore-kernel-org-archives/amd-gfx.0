Return-Path: <SRS0=bMdI=MH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2317C07E96
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 08:25:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84DB96120A
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 08:25:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84DB96120A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3003C6E560;
	Thu, 15 Jul 2021 08:25:00 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CE936E560
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jul 2021 08:24:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dkrazv8y3an6xbw84WVuZccxHNv+OOMzBo/VD94V42R4H8pZMbxZ5GusVQ3653hvGwznKiaa6XVgS7HxEcQ45ugwcuTz03MRfU/W4+9OszkiqyjjOE2t7G9mvUg6K6K8SXTNY13IMU+ohYGt3y4HlcE0oJPjOci06gB/bnd00YKlYXu4kQSa1CpEtKFLusKeuH9zk4n7zjnykHKjCAt3j/O9/R+eY7F1eiN/tkAgJmGZ0QD0SFVeRGcLOmBJnoO2US5FDY8KHu7pkFu+J5H0bfU6gkHih/kU0+zaMs2j9VlU7kGlU6ak0ogy7DVmZrdFoJtcI+1FnDyu9ksLUIXNcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1i2oh03SrN/2P9XDznvwQykm8TTkQcTUCbthXdQujA=;
 b=jM8Oy7a28Dqxu3tdC0vX8t+N29Lui8bCB7yeZYjBw25R5L7pNbw5eA9oPh+LJhRkCG76UQJlOcxn53s1Glo/uhiefihEDvWcu+xxhkB5tdIOPne9lQaozhSxLYEYiIBql+ozmqXvuxDJwMhJSpVSzb7lpIBixo+nOU4bBPnz+VtVO5HRAsH5JNSbSK0iTOAvBLybA6PGpSyHYEc5eEjHD1D+OmgzBkr2Opfpo+YW4FZQE6PGEcQNRuXuJX9ZNUrNxsmh+XtJv7CEX7NbPvegwRtFAnckKVZG1Zn61/llOlheC6WwKAAFW/4ECKLvd5EMpCtqO5+b3cRgMTLJNOw4Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1i2oh03SrN/2P9XDznvwQykm8TTkQcTUCbthXdQujA=;
 b=gepvD+o8bcdCWJ+9k6Tdt+2ZAqgOW/XsSS1y9enDgs+bCkTE7KNYEJ2/quJRqL3r+snnrW21zMcCaQWvuND4l3BqVBvCCU47AHT4bPJn9X1dhK2MCVV3KYkrcd1FUga+1j6DjADv9QsQLAu1BJCde9gFQaZBbUg4f8i2JfexMn0=
Received: from MWHPR21CA0060.namprd21.prod.outlook.com (2603:10b6:300:db::22)
 by BL0PR12MB2484.namprd12.prod.outlook.com (2603:10b6:207:4e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.26; Thu, 15 Jul
 2021 08:24:56 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:db:cafe::d4) by MWHPR21CA0060.outlook.office365.com
 (2603:10b6:300:db::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.3 via Frontend
 Transport; Thu, 15 Jul 2021 08:24:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 08:24:55 +0000
Received: from kevin-ws.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 15 Jul
 2021 03:24:53 -0500
From: Kevin Wang <kevin1.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [RFC PATCH 1/3] drm/amdgpu: split amdgpu_device_access_vram() into
 two small parts
Date: Thu, 15 Jul 2021 16:24:37 +0800
Message-ID: <20210715082439.678512-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 605ea18b-685a-45b3-bf14-08d9476a0720
X-MS-TrafficTypeDiagnostic: BL0PR12MB2484:
X-Microsoft-Antispam-PRVS: <BL0PR12MB248478BC098521506AFACA40A2129@BL0PR12MB2484.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qh/eOxWtlYawfkLCxSxR1sG7v5jX2E/BhQ4c5fTQF4H7yTndwK97BskxzV7b09iqLzyDol4uSDleu3a9MpYbgwE+PyOLElfmw+Ntee8pAUVCprMh0xJSVrw8Cj+z67w4feAP+GFDD0luoqqPVbA/YOuYuo1YPWYUwEJ67m1CGJ5iJElBRPgAvEY/7FpeTk1yasYIbheZ7yuYPn78hzCvk97MxqPH2DkO2lNGQDfEMwvGBibLfRCMPo5zjpiapB30MbQ9vscIEo7iWFywjkhVxI0sn5cxlEv2032ZgaL5EwZv1lIXtFC/tgftpcU3qbC04FtIIBnvz5l5RwMx4eOA8WaRv1OQN+3dxpG07gZBfiTykxyUV5gs7z8owdpxDIbbUZ6ib+ip3bEWRpoatS96HPGGXmGDV+70Gj4b7Sv1PDZB/hRPNJ3V8VzDUsglvrvhkJIv0QMmSwHIKBCq0t/XPDKezm0LoDO0SvnNlwV5TmhEAM/teThXdku/ydVFNatXpp66gcRRGGptMY23cMlBurIW0jFWTP2lDUm7ItZwQ0vAu9dDOdgqmQxdzQZYhvRcB5TBxHA1QagygfnyW9XMPhHtndPf/i9Eoc3xBenOYlYh4wWFfSMsgSY7E/mNgplXCTkuD4iYPMeSnK9GrSwc8fz9/use4UZE1bE/TE0ANaIEEh25UtVliHjka/tYjWuNkko3DZqlYEYQFITyY2k3Vqx/MrYtXHCNws8o9tI/yYI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(46966006)(36840700001)(4326008)(356005)(2616005)(81166007)(426003)(2906002)(26005)(186003)(16526019)(82310400003)(36860700001)(336012)(7696005)(82740400003)(70206006)(6916009)(6666004)(83380400001)(1076003)(70586007)(86362001)(316002)(478600001)(36756003)(5660300002)(8676002)(8936002)(47076005)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 08:24:55.9718 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 605ea18b-685a-45b3-bf14-08d9476a0720
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2484
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
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 101 ++++++++++++++++-----
 2 files changed, 82 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index d14b4968a026..dd2fc89f5c16 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1102,8 +1102,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
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
index eb1f3f42e00b..4a9a7e4d3908 100644
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
@@ -293,19 +293,58 @@ bool amdgpu_device_supports_smart_shift(struct drm_device *dev)
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
+
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
@@ -317,30 +356,42 @@ void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
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
+	if (count == size)
+		return;
+
+	 if (count && count < size) {
+		pos += count;
+		buf += count;
+		size -= count;
 	}
-	spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
+
+	/* using MM to access rest vram */
+	if (size)
+		amdgpu_device_mm_access(adev, pos, buf, size, write);
 }
 
 /*
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
