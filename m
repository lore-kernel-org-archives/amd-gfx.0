Return-Path: <SRS0=OLwD=MI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE57C07E95
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 08:24:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09395613E3
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 08:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09395613E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68C736E942;
	Fri, 16 Jul 2021 08:23:59 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2055.outbound.protection.outlook.com [40.107.212.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 982796E940
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jul 2021 08:23:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eEjM9G/SmZb974j4vJhXQf2vA29HYhJ0LKwa4VIpY6as/Py5bPwXwiKJyVJnTQ4QpaLqc9ypZGt0uJmccOuX2h/4KuJ1dwyyc7iZJo/KbfXVtmPmsMu1wbvMKNqif2Zc+E10GeERVaU6n80Ub2v60cg8QC74Hi1p0iX7cLr/5F/rxSgYkLiuC6VHW33idigu2K6yHWbNFD7qPbvOu6YM4qawEeyTnxuXHxcEawX78Bq7Pq7IpHISoZImSBl2xPmN3QryZ4QFBS2/ElC3hbzmEGgXrvWAyAb3PSA3ie5qbFYDPNBDUAYrFMscnM9JXm1Jwuju0SuxNBhJ1690GkiBrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCyd0dqqydCSGgwaUGDUCBW1/+BHZxwAtyOznTjgxYk=;
 b=ZMEoR/yq07ZI3nxRVv5b1iwYVfo79AKKhmnlMN9BNOf2Of24UeY/mtCHydY9OYtn7SkGLxpYCa9iryLCyhxtXEq9ajmTKfGyPng48rBZgVdUWnlnZa1gjom7vazuoGo/9gtUBiURmgy8tMNdIJp6F5FhzwJDmGs22wrI8ggFLYwsq6+hSSPh/o1bYbDupfbm8s6GCaEEbfhc0lJSmVpwLDGn/1eo/BcBxiu63ONOmLUQ09XBxCERsG48jIXXnuEi4RW11nFeLVtH8DzgeE7bNEmpSYtkC44HFNb0ahTXaaLnULQpoiEtEYwd12fx4OcQ6U0Z4f1sHNKYx0BZ6MzdOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCyd0dqqydCSGgwaUGDUCBW1/+BHZxwAtyOznTjgxYk=;
 b=dWMUni7IcbBLyVG6i3hM/tnuDc0UWeymKWinVW1WgA/AOq/zCPRRlbLLTA4YZDzOgFNkRvMaBTIG1b4gp5MMD2/Wb8SFMfSMUkT07Y/o30iIc7MSWiuwYH1Al/wSy5Aeuo4zUQF1o6uKB8WlhKpEuntyXTPO+YPBZOOPvPJ+MMM=
Received: from CO2PR04CA0179.namprd04.prod.outlook.com (2603:10b6:104:4::33)
 by BN8PR12MB3457.namprd12.prod.outlook.com (2603:10b6:408:67::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22; Fri, 16 Jul
 2021 08:23:55 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:4:cafe::4d) by CO2PR04CA0179.outlook.office365.com
 (2603:10b6:104:4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Fri, 16 Jul 2021 08:23:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 08:23:55 +0000
Received: from kevin-ws.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 16 Jul
 2021 03:23:52 -0500
From: Kevin Wang <kevin1.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 3/3] drm/amdgpu/ttm: optimize vram access in
 amdgpu_ttm_access_memory()
Date: Fri, 16 Jul 2021 16:23:34 +0800
Message-ID: <20210716082334.879149-3-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210716082334.879149-1-kevin1.wang@amd.com>
References: <20210716082334.879149-1-kevin1.wang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a91fe7ae-c7ec-42d2-5aad-08d948330d6b
X-MS-TrafficTypeDiagnostic: BN8PR12MB3457:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3457CA0E17AB5E657B5174E3A2119@BN8PR12MB3457.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:489;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s0Zn7GGwlODalofuODAy/Nnk3JiWc+Fk11fYG+/kdzWGucMhqvcENrWUzuZ8fJxEvZ9/TbDa712tLmIRz4Z+HutC7CDJxvAygPIiVfkM3wZ4bVl6BVovU6HE600Fsa98Y4tdIL/pyL3RbbM2f6HsrAyT5Xug1jWYnevYUlmiLm+Kml4qt4gJYqJZt0SV2J++ZnKTp/5fhTEnE6LmB+DO6uunQyX9RtyXjs90UNWVtuYT48JRHuVTu5i0RD8P7r5BaorWuQOMFzSd7mHyGzjpJyiQoCujhKInarVQ1O8AIvjLfcNDVfVZnF0G6LWNkKBxi2/Vy+zXSxYju4ySVOf75OkFvigsxXzOP/3Y4AN312UUCpw/P62SsVYCX/gIAv5CD7RFNkmAH5H9P6dKpKONy14gaVQQwrz7o0n4jvYqk2JBhbBY8JTJbC6e61IkHCEOLL7UazlTNsTpkXVYYeHWpA0/8CgfaUHbaCBXUZ9kQNnaSdUdw5NL+ukm+TQpCuMXAF5/j0K4eltV2aNR3gxdAjJ2kCfnlVvvJJqSJqaIXAVezYkZ7dk/QRYLET+rr9eHDI0KHprGOy8voZuRZs5C/mQDM+GFnz+zGeSKWFgRp7KBzkLNMXE0zZwXE+MVlhJlqnOVtXDA4fN5CQzerLmsyJOjWRKvJxmIElAAkmBu2UPAsopHMeUm/JziG1CtXeVLYJ3wWxfb1JzGAoWW+nVvDRjRqXdyBa0zKk2S8e7F4cM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(36840700001)(46966006)(7696005)(5660300002)(82310400003)(70206006)(4326008)(1076003)(6916009)(336012)(26005)(8936002)(8676002)(2616005)(82740400003)(36756003)(426003)(16526019)(478600001)(54906003)(316002)(86362001)(81166007)(6666004)(70586007)(2906002)(186003)(83380400001)(47076005)(356005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 08:23:55.3548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a91fe7ae-c7ec-42d2-5aad-08d948330d6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3457
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 84 ++++++++++++++-----------
 1 file changed, 49 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index f4ff3c9350b3..0aacdafd1ef6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1407,6 +1407,41 @@ static bool amdgpu_ttm_bo_eviction_valuable(struct ttm_buffer_object *bo,
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
 /**
  * amdgpu_ttm_access_memory - Read or Write memory that backs a buffer object.
  *
@@ -1426,50 +1461,29 @@ static int amdgpu_ttm_access_memory(struct ttm_buffer_object *bo,
 	struct amdgpu_bo *abo = ttm_to_amdgpu_bo(bo);
 	struct amdgpu_device *adev = amdgpu_ttm_adev(abo->tbo.bdev);
 	struct amdgpu_res_cursor cursor;
-	unsigned long flags;
-	uint32_t value = 0;
 	int ret = 0;
 
 	if (bo->mem.mem_type != TTM_PL_VRAM)
 		return -EIO;
 
 	amdgpu_res_first(&bo->mem, offset, len, &cursor);
-	while (cursor.remaining) {
-		uint64_t aligned_pos = cursor.start & ~(uint64_t)3;
-		uint64_t bytes = 4 - (cursor.start & 3);
-		uint32_t shift = (cursor.start & 3) * 8;
-		uint32_t mask = 0xffffffff << shift;
 
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
+	while (cursor.remaining) {
+		size_t count, size = cursor.size;
+		loff_t pos = cursor.start;
+
+		count = amdgpu_device_aper_access(adev, pos, buf, size, write);
+		size -= count;
+		if (size) {
+			/* using MM to access rest vram and handle un-aligned address */
+			pos += count;
+			buf += count;
+			amdgpu_ttm_vram_mm_access(adev, pos, buf, size, write);
 		}
 
-		ret += bytes;
-		buf = (uint8_t *)buf + bytes;
-		amdgpu_res_next(&cursor, bytes);
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
