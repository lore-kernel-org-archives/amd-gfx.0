Return-Path: <SRS0=bMdI=MH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6EAC07E96
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 08:25:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED68F6120A
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 08:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED68F6120A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91CAC6E595;
	Thu, 15 Jul 2021 08:25:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 750346E595
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jul 2021 08:25:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJgq2lBr15O+FUvwHlXYG/LgmMdjxnCWkrdxiLeQxNjH80rFkaFqudI9p/YxtelDV4gheY8roFSmW2OWEBUq2JWaAQTSKcYCuFaEh+sRFZqxuHPagSz5rH/7dH1mGgu59E5Y8KEEr16HNMbrOs3S1aWabB29BZHyuO4mCiLaiFCNzCZSe6yVmX6LMrR8D0pOMZjL5XuaTPPI9aRBu+XErUa/yQRNY7+rEhVUcVwnGN9ujynJKh+S11FVGQk0z/tiEYqdcZPEGT0IDaloLXqS+Vd3NVBZYW692BdafO2ugcefZX3wAxvDGdbJ27m11Tn9RBxbHUgtUH6y2EQqGSPlpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpeyHnX2XsdA2o3DbUspb12BHz8UMbIz7fBY9+Ej6xE=;
 b=ePfVi/cS8GgffVyB9ZZSU32ReTxwZYr3/L+MCsYKMMGf0M1alxAIlUFX2NXplJDgbALEi+bPldhFCQarl5IzkELmdGYWeKol1TtgR8pr7c7YvUm5PWDPlz4gsFiSlToL8drKuEFXmaDKyXm1cajkGhg7S5QVtteF4PW7bHYTApdvkGNfeTbk2Mk0T2GHfO2DfmEsDW9PMK2NbTM0shh02YrMg4eKtp9oEyrio2WbC+ZdDY4XixV4ZU9RiJrOf0kJHGlh1JsWqY9gMhdcnO5Lz30UcUWJ+r73wr5FfX76WlHxcYHGGttz/8VqnCI/IVzbE7q++VZVaZiHM3hCv6J/Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpeyHnX2XsdA2o3DbUspb12BHz8UMbIz7fBY9+Ej6xE=;
 b=mR9vHuZO2TIGruOmIW6NK0resMni4TB/QCRhfHD48NpMlYKKvnB5ZKGtud8XJF+/bR3wmghsoNenkBP5DUB1dvX68/e6BjEZG8UXvuAY2/G+azOiN3fs9Plybs9jYfa5CqYJnXcSlr2oz48uQ1qInRW6tqYIqsBuca3TYAP1MWo=
Received: from MW3PR05CA0019.namprd05.prod.outlook.com (2603:10b6:303:2b::24)
 by DM4PR12MB5246.namprd12.prod.outlook.com (2603:10b6:5:399::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Thu, 15 Jul
 2021 08:25:02 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::d3) by MW3PR05CA0019.outlook.office365.com
 (2603:10b6:303:2b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.9 via Frontend
 Transport; Thu, 15 Jul 2021 08:25:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 08:25:01 +0000
Received: from kevin-ws.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 15 Jul
 2021 03:24:58 -0500
From: Kevin Wang <kevin1.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [RFC PATCH 3/3] drm/amdgpu/ttm: optimize vram access in
 amdgpu_ttm_access_memory()
Date: Thu, 15 Jul 2021 16:24:39 +0800
Message-ID: <20210715082439.678512-3-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210715082439.678512-1-kevin1.wang@amd.com>
References: <20210715082439.678512-1-kevin1.wang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe7a1f04-1c30-462a-2cac-08d9476a0a52
X-MS-TrafficTypeDiagnostic: DM4PR12MB5246:
X-Microsoft-Antispam-PRVS: <DM4PR12MB524681ED9CB317316C9FFE2EA2129@DM4PR12MB5246.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:489;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t3FXzFZw0itXKa9BoWjDym7QJjHdXRj4xpnkIwVUAG+HgUsN9z8h+GHSbuZX4IfDzCzm6CtjRRtRFjmXHcyl8wQhgH6M+eyO/bdbWivnbLNA6x2dT4JSieBgBoVxel/xwiHjP7ioJnDWcD2hQi/mT1lkBrD8XpNeE6Ug5YGBh58QCrKjCzKeJo3TU1oxxtu53MWU2MiCz+7GIpavzMsbmDmJBNbT0N2Ft9rV4Sj9aoWUFetxU1B689FqZDMpOxsZ8l13gkyqg7AQKdMyX3WuOwWjfn7nUq+JWZUslP1kKMGXwpcYVXa3tJFXC50+nVzB/nzoToROEgA/yprB0qVxAyRUu1oTLcjHKoCwIrjJ0mHHvK0ZBJurmR25Sh9K+1N034h3a/78ZVn9pPwm+HzCCjFq8BtoUrOwbLtY+0vfHTC+X7f5ff9LGmyojVsuVXMrCUZEu0Y+LfFlrXwLB576xo5awTGax0sgC1WHuXETXdF1vrWnVSMvAkTw5N8yEQtmotxzFfxaOg3lwHf/8JYDQT9VpHlS+UrirMtJn/KNwYmXtBkcPxET2Pjixd+QEo0cmW+1OaliQTllPAfrwvcWXpiEEpdZnp0ssei+RddEcu8wvnzNzvNSyo4e74v3PaS1YNGqwvEw/hgfl4m9xRQ8SAz92AIfJk7sUqFFpjRuArdfg3sVIyh/GpT1pFxJK2rKqved/B9krWEm2a50Jugfc7s78Mp6M7T6cY51hJp/A9Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(136003)(346002)(36840700001)(46966006)(2616005)(6916009)(316002)(7696005)(336012)(54906003)(426003)(26005)(5660300002)(1076003)(8676002)(16526019)(2906002)(6666004)(186003)(70586007)(8936002)(4326008)(70206006)(83380400001)(82740400003)(82310400003)(36756003)(47076005)(356005)(81166007)(478600001)(86362001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 08:25:01.3279 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe7a1f04-1c30-462a-2cac-08d9476a0a52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5246
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 95 +++++++++++++++----------
 1 file changed, 58 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 2c98e4345ad3..bf2d50a918e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1407,6 +1407,60 @@ static bool amdgpu_ttm_bo_eviction_valuable(struct ttm_buffer_object *bo,
 	return ttm_bo_eviction_valuable(bo, place);
 }
 
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
+			amdgpu_device_mm_access(adev, aligned_pos, &value, 4, false);
+			if (write) {
+				value &= ~mask;
+				value |= (*(uint32_t *)buf << shift) & mask;
+				amdgpu_device_mm_access(adev, aligned_pos, &value, 4, true);
+			} else {
+				value = (value & mask) >> shift;
+				memcpy(buf, &value, bytes);
+			}
+		} else {
+			amdgpu_device_mm_access(adev, aligned_pos, buf, 4, write);
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
+	size_t count;
+
+	count = amdgpu_device_aper_access(adev, pos, buf, size, write);
+	if (count == size)
+		return;
+
+	if (count && count < size) {
+		pos += count;
+		buf += count;
+		size -= count;
+	}
+
+	if (size)
+		amdgpu_ttm_vram_mm_access(adev, pos, buf, size, write);
+}
+
 /**
  * amdgpu_ttm_access_memory - Read or Write memory that backs a buffer object.
  *
@@ -1426,8 +1480,6 @@ static int amdgpu_ttm_access_memory(struct ttm_buffer_object *bo,
 	struct amdgpu_bo *abo = ttm_to_amdgpu_bo(bo);
 	struct amdgpu_device *adev = amdgpu_ttm_adev(abo->tbo.bdev);
 	struct amdgpu_res_cursor cursor;
-	unsigned long flags;
-	uint32_t value = 0;
 	int ret = 0;
 
 	if (bo->mem.mem_type != TTM_PL_VRAM)
@@ -1435,41 +1487,10 @@ static int amdgpu_ttm_access_memory(struct ttm_buffer_object *bo,
 
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
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
