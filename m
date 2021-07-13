Return-Path: <SRS0=Y2YZ=MF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6930C07E9A
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 03:23:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61EE6606A5
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 03:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61EE6606A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0213C897F5;
	Tue, 13 Jul 2021 03:23:49 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2057.outbound.protection.outlook.com [40.107.96.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBDCF897F5
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jul 2021 03:23:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkWdGpIOPMMCe3W3yeCUTNcs+DW+UZxTZwsst5qMCIvMsrsMA3BBA/Iqu3Xcc5Pj0klpK2IENiASi8xwZvNZh+GcnC46c/2YpBFosDfQxARMT9SUbI2OShT9B6fomNmSRV+4f6owSAFOAN/0XVaCbFAKKKkP8+IW6gioq5tOCfX3VBqIlfcTPfLompaDL/Y/iEsWyi8ZJF4tKszwjVXjC2pmzEdzxAkMzA1NzF4DVrlXeMKZ8/txtNOAfw+osD06Ssq5HbxaqX518NEd5XHO6PBCGZQ6+snl/4oY1xX5k1vXrNkQ84q6mN0Nd5uBctCPnTDenA+tXatFNGEKECWhkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgqkOsiUwamIpywmn4I9XoGY9bT/O3PTHdSNGkoqnHQ=;
 b=ZLj3pXBd4ka9uajXH4ARcEpjAlSpyXzTJvSUtxH8abmCz99auTVNHrQmORAWFvl1mwF8XDWjwORr6vHryzdQpPFRCEzUoPYx9z1wk9LbnPNnx8xbUOLSoaiynIScM1et4wgWFxYTeMXgqSKAmgTSj4YqKD8W3TWVmbeV8pIfRYkeH4/tP/Ae5XueaUILMYH6nm5uk48nznUESDENraJbKMoPpcYYfo4PczI455MTHtyOqHjUeK1DcAgtZsr4FbH4N6T/7jPMxhicZxx12xUeuxZ+q4viuV9URWJH+SNKOwzs987+/YeQdrUiL/vNKZgOygFpHBTqqcyAaFwFw/OXkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgqkOsiUwamIpywmn4I9XoGY9bT/O3PTHdSNGkoqnHQ=;
 b=AJYbzDe9T4wqvdy4e1cyhn/bF7/kyFfSFXNeU2a28l8bWivn5YzbqNTKdh64S2cUvGNZECQ1U76va96SLYkLBSaRt3Woq497F4a2bP8yHrq59gGzkym9yPRsdwjSpQnsGfeTGp5rgsVDjVcgmr6O05tJpo+qKw19mghauACVSNM=
Received: from DM6PR17CA0035.namprd17.prod.outlook.com (2603:10b6:5:1b3::48)
 by BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Tue, 13 Jul
 2021 03:23:45 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::20) by DM6PR17CA0035.outlook.office365.com
 (2603:10b6:5:1b3::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend
 Transport; Tue, 13 Jul 2021 03:23:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4308.20 via Frontend Transport; Tue, 13 Jul 2021 03:23:45 +0000
Received: from kevin-ws.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 12 Jul
 2021 22:23:42 -0500
From: Kevin Wang <kevin1.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [RFC PATCH v2] drm/amdgpu/ttm: optimize vram access in
 amdgpu_ttm_access_memory()
Date: Tue, 13 Jul 2021 11:23:29 +0800
Message-ID: <20210713032329.7393-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66e7f1aa-e82c-4542-d80b-08d945ad9f5f
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5115BB13C05AA6EF283640ADA2149@BN9PR12MB5115.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:311;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 24mPDJcmB3Abuen4DZZYKpHTC4wDzkcppw8MaIrygggeduSPiLD+oJ3BC5gwNodBgjMjZ9bpBfOMI778zufdqaRrYZKZcMmucx4Q4s0p3GCd0/+VSFLGdHjqbGxXQ/Cph7Mja82LmI7WgD3RVzzZNOXO2vg/Ylsxfur3Hle0fCpjhoHMJ/6d2SybYEeWntoPeJXdiBaJTuZn4BaXFUzwW2u5sheIJICU7am9O8IYZHOebGvPoxWcOd6rnuavVBT0HmWyTOav1siBLyi31Ym1M1Jpvk9O0/5DhsGytZM/a0O/qhoUQ8Gnw2qW+GHTLg7Bx/t4dsRl/cY0xXX1vJEjw0ySKO7KNt0/lAGXK9FAzBrV1xSoTqotQhlrA+9lCRWF8PqzDAJ8hcMVljM8en09t14BS9eHUuT6d7Hs23uSl73ZFsOLhjxY81sG8FxeErZS3u8QVZG4q3xFFwXH7sdHjt++K3BWIIGAn2ICVVjKcefp1rnp7bQ5gbgGXvsBHNRqCq+kVwsRv/hcTMiBwDSPVdfpNkxqAJoZd7+3wuEPDISFzm5JCWt9d1YVvt2aM2IvhZWII8ertTYMElFrNKsEmf33AYaBfH7dQkXlyN+nVRS0g/4w4P2EmHZn/NXkM3enoceubbbJOYv6hufFkLR786mN1xSMPJRrfl8zr4/WuXqxtU/M/M9y36gqzC/yN7YZip2TGTHKj/m0NNCq19BxDRVJ0QMoJToy4MbCQwXz7hE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(36840700001)(46966006)(426003)(356005)(2906002)(5660300002)(2616005)(86362001)(16526019)(36860700001)(6666004)(336012)(8676002)(6916009)(8936002)(7696005)(1076003)(54906003)(70586007)(478600001)(81166007)(82740400003)(82310400003)(4326008)(186003)(47076005)(83380400001)(70206006)(36756003)(26005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 03:23:45.4063 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e7f1aa-e82c-4542-d80b-08d945ad9f5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5115
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

1. using vram aper to access vram if possible
2. avoid MM_INDEX/MM_DATA is not working when mmio protect feature is
enabled.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 126 +++++++++++++++++-------
 1 file changed, 89 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 2aa2eb5de37a..8f6f605bc459 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1407,6 +1407,91 @@ static bool amdgpu_ttm_bo_eviction_valuable(struct ttm_buffer_object *bo,
 	return ttm_bo_eviction_valuable(bo, place);
 }
 
+static void amdgpu_ttm_vram_mm_align_access(struct amdgpu_device *adev, loff_t pos,
+					    uint32_t *value, bool write)
+{
+	unsigned long flags;
+
+	BUG_ON(!IS_ALIGNED(pos, 4));
+
+	spin_lock_irqsave(&adev->mmio_idx_lock, flags);
+	WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)pos) | 0x80000000);
+	WREG32_NO_KIQ(mmMM_INDEX_HI, pos >> 31);
+	if (write)
+		WREG32_NO_KIQ(mmMM_DATA, *value);
+	else
+		*value = RREG32_NO_KIQ(mmMM_DATA);
+	spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
+}
+
+static void amdgpu_ttm_vram_mm_access(struct amdgpu_device *adev, loff_t pos,
+				      void *buf, size_t size, bool write)
+{
+	while (size) {
+		uint64_t aligned_pos = ALIGN_DOWN(pos, 4);
+		uint64_t bytes = 4 - (pos & 0x3);
+		uint32_t shift = (pos & 0x3) * 8;
+		uint32_t mask = 0xffffffff << shift;
+		uint32_t value = 0;
+
+		if (size < bytes) {
+			mask &= 0xffffffff >> (bytes - size) * 8;
+			bytes = size;
+		}
+
+		if (mask != 0xffffffff) {
+			amdgpu_ttm_vram_mm_align_access(adev, aligned_pos, &value, false);
+			if (write) {
+				value &= ~mask;
+				value |= (*(uint32_t *)buf << shift) & mask;
+				amdgpu_ttm_vram_mm_align_access(adev, aligned_pos, &value, true);
+			} else {
+				value = (value & mask) >> shift;
+				memcpy(buf, &value, bytes);
+			}
+		} else {
+			amdgpu_ttm_vram_mm_align_access(adev, aligned_pos, buf, write);
+		}
+
+		pos += bytes;
+		buf += bytes;
+		size -= bytes;
+	}
+}
+
+static void amdgpu_ttm_vram_access(struct amdgpu_device *adev, loff_t pos,
+				   void *buf, size_t size, bool write)
+{
+	uint64_t last;
+
+#ifdef CONFIG_64BIT
+	last = min(pos + size, adev->gmc.visible_vram_size);
+	if (last > pos) {
+		void __iomem *addr = adev->mman.aper_base_kaddr + pos;
+		size_t count = last - pos;
+
+		if (write) {
+			memcpy_toio(addr, buf, count);
+			mb();
+			amdgpu_device_flush_hdp(adev, NULL);
+		} else {
+			amdgpu_device_invalidate_hdp(adev, NULL);
+			mb();
+			memcpy_fromio(buf, addr, count);
+		}
+
+		if (count == size)
+			return;
+
+		pos += count;
+		buf += count;
+		size -= count;
+	}
+#endif
+
+	amdgpu_ttm_vram_mm_access(adev, pos, buf, size, write);
+}
+
 /**
  * amdgpu_ttm_access_memory - Read or Write memory that backs a buffer object.
  *
@@ -1426,8 +1511,6 @@ static int amdgpu_ttm_access_memory(struct ttm_buffer_object *bo,
 	struct amdgpu_bo *abo = ttm_to_amdgpu_bo(bo);
 	struct amdgpu_device *adev = amdgpu_ttm_adev(abo->tbo.bdev);
 	struct amdgpu_res_cursor cursor;
-	unsigned long flags;
-	uint32_t value = 0;
 	int ret = 0;
 
 	if (bo->mem.mem_type != TTM_PL_VRAM)
@@ -1435,41 +1518,10 @@ static int amdgpu_ttm_access_memory(struct ttm_buffer_object *bo,
 
 	amdgpu_res_first(&bo->mem, offset, len, &cursor);
 	while (cursor.remaining) {
-		uint64_t aligned_pos = cursor.start & ~(uint64_t)3;
-		uint64_t bytes = 4 - (cursor.start & 3);
-		uint32_t shift = (cursor.start & 3) * 8;
-		uint32_t mask = 0xffffffff << shift;
-
-		if (cursor.size < bytes) {
-			mask &= 0xffffffff >> (bytes - cursor.size) * 8;
-			bytes = cursor.size;
-		}
-
-		if (mask != 0xffffffff) {
-			spin_lock_irqsave(&adev->mmio_idx_lock, flags);
-			WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)aligned_pos) | 0x80000000);
-			WREG32_NO_KIQ(mmMM_INDEX_HI, aligned_pos >> 31);
-			value = RREG32_NO_KIQ(mmMM_DATA);
-			if (write) {
-				value &= ~mask;
-				value |= (*(uint32_t *)buf << shift) & mask;
-				WREG32_NO_KIQ(mmMM_DATA, value);
-			}
-			spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
-			if (!write) {
-				value = (value & mask) >> shift;
-				memcpy(buf, &value, bytes);
-			}
-		} else {
-			bytes = cursor.size & ~0x3ULL;
-			amdgpu_device_vram_access(adev, cursor.start,
-						  (uint32_t *)buf, bytes,
-						  write);
-		}
-
-		ret += bytes;
-		buf = (uint8_t *)buf + bytes;
-		amdgpu_res_next(&cursor, bytes);
+		amdgpu_ttm_vram_access(adev, cursor.start, buf, cursor.size, write);
+		ret += cursor.size;
+		buf += cursor.size;
+		amdgpu_res_next(&cursor, cursor.size);
 	}
 
 	return ret;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
