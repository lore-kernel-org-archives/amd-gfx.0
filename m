Return-Path: <SRS0=OLwD=MI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB44C636CA
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 08:23:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81907613E3
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 08:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81907613E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C18C6E93C;
	Fri, 16 Jul 2021 08:23:54 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E9526E93C
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jul 2021 08:23:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3B+TD10CE3Ma4RyamDg7Txf5tgeBOnmPHwYLou9j68RnWy08O7FkDCcp+Jsx2RcOaUNhza1Qi2vZUkd6mogoQwjI41swuyUAj50lpuAlBLnU+XJTh1FbcseWCS5tGqfRs9wVruvXv4iHKk+3djPchpoWsbBHlK65Ir5dvp8X4k66tsG4Lhlfcb2THEFMKxfhjMIPtncRpbpq4uLDfunCBpyPnq7W+iyk1mEoXf9Ev1Lml089UamCmaCGKW2JOYDM6fYxarEAQyeDbZVrqJg2UJapvibOIJZczdQhnnJjprTkhVnm2KT9BJJwgMjip8zl63BQnzbgzARTabtcSgS/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5veALvte84s2QPqm6IGaXvzglm7SoVMvxYM13lMfFR0=;
 b=RHbpfNLToGMo6ki50t3QG1I6YmHgbD5Sy9gXHsPY8Zgos52fEKoZKqNpXQTMN/uCW+gDKHXZ9PhCBpwj6C0bM0Kk4RotqaMwpW1Ry9HYlMkTUclGEOUpHmg4E9rU0z9iSfygpiu1Y2dOGCk4xIPIai5dM0ZODuk1j4hC6Vj2ML1z71iWdX+ruiFUQkYB+Ijz5RkYS+gOvqBlXeh3zFKJenOrRybxXndsK+UUF07rhwwV/1I7rrpd+51Jqdjt8D/iu6nwPMaSqUnczFF8DYSYzJk4aTnVIJjNM7MO0RVrmfooxyhajl4ERnsmxgBumq8C+gYFrdo+9fiKVj5mu0so/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5veALvte84s2QPqm6IGaXvzglm7SoVMvxYM13lMfFR0=;
 b=heSmJgWoWltm8msj2SyzwzZXY0RGHlZlHpVXObWlRZ3IjnqeDagGCCvvduRWwSlFF2TI1gJiXEMYTXCcGqImZIjPVzVPBH09S+GlMfKYCtVxHEJ/lZn+oxit1Z2qiQxkYSIpvTy0Tmt7JvbAyjGuZsXiRpUSr/DDkHAQTT5HWUE=
Received: from MWHPR14CA0025.namprd14.prod.outlook.com (2603:10b6:300:12b::11)
 by DM6PR12MB2764.namprd12.prod.outlook.com (2603:10b6:5:4a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Fri, 16 Jul
 2021 08:23:51 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12b:cafe::1e) by MWHPR14CA0025.outlook.office365.com
 (2603:10b6:300:12b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Fri, 16 Jul 2021 08:23:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 08:23:50 +0000
Received: from kevin-ws.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 16 Jul
 2021 03:23:48 -0500
From: Kevin Wang <kevin1.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 1/3] drm/amdgpu: split amdgpu_device_access_vram() into two
 small parts
Date: Fri, 16 Jul 2021 16:23:32 +0800
Message-ID: <20210716082334.879149-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 696eb2a1-02ee-4cd0-58b2-08d948330ac4
X-MS-TrafficTypeDiagnostic: DM6PR12MB2764:
X-Microsoft-Antispam-PRVS: <DM6PR12MB276445D20C32C06F2DDE4B2AA2119@DM6PR12MB2764.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q9YNxgvCrN/UOlowh5ojrE5yPwEVrWLrW/9cGqF4hdrWiGYxVshXkrfmulyzQRGs39U2SKW5CGSrxhaJAq3nedZdkg2zcEiJgY8IG8pI9Zt9YqSacDi0dtQl2MwFvC9iV3aOKtx1mjSFG2YvmGRlyzABjBEKxaH/zzTy7sxyQ5nhXB2nL2bR9d7fQNHOFsJNKLtwSIaev76yLD//igxEKP8Vs+6y3gv/0NGievxAVQKg603UZGzGauMNQQ6MWYarksvbaXwg2mo6fv/isLXIfqsuYPXaYwzMcsjNUKNcvP9WUfWDi5d8jKUgWWkr3+ja8EnGQy+JiNFxLfTKQHo1yKRAwsP1MXVe2Fvg8FOk2OG8RypUUwBor8erNPXRtUVyq+c4qNRd8l3NZ2gUDugUZwI8hd41Bg+eLDwXWGOgFEVoGo/o1PxDp1Dahei4Qu+9fFUhSXMKx2CMhKgacfz59c96l/cBxrcgQPYGf60Xk/JRvPmxYQyDQM+Y7A4HLYwOUNO+jT67ErDoG5+lrTEAuAOUcZB3fs511ayudfml0f1WC5I8cy4Vi4Wf/5cn6yXU6I8p+um3RVz3XdtI+jqo8f7pAUVTddd6rbUlJvSwco++5kjJgBfStGgTtQ8kJLeVr9lYsPjJPrUEw/Oh96zCyrOxl57um4fr2aFOHM8TVdH5ZvMCACHqLyqVnmcontR7qOawLPGliJK2PGGPdbTmDA644wCXxuoGxo2hhp5Gp4Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(376002)(136003)(46966006)(36840700001)(1076003)(6916009)(316002)(36756003)(83380400001)(86362001)(2616005)(8936002)(6666004)(54906003)(8676002)(2906002)(82310400003)(356005)(426003)(5660300002)(186003)(36860700001)(26005)(478600001)(81166007)(70586007)(4326008)(16526019)(70206006)(7696005)(336012)(47076005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 08:23:50.9138 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 696eb2a1-02ee-4cd0-58b2-08d948330ac4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2764
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
