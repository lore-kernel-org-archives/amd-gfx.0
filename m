Return-Path: <SRS0=OLwD=MI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23E2C636C9
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 03:11:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BB08601FA
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 03:11:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB08601FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C0F96E8E8;
	Fri, 16 Jul 2021 03:11:08 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2066.outbound.protection.outlook.com [40.107.101.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 108BD6E8E8
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jul 2021 03:11:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/4L7TnJq5tqrMRBnXGDCgt1b9NPGpjFRgxw9+tPqS3djN6pjRFbhGx2+krXkURBi4cXJ1qZkGRpQrrZPtUHC6TBAW6oXz6W1m7tfGHIumf3JPLDn88FTCHTPERuo+5MwAT4KI0ry2Y0Z74G9fbcS2t+ExkNtxh5S5Z3MYI8MDUhM3YvZpXjE2zDTaLPgBVVmFTo1v0vupWmlHUykP1tZwEtU46Rm5jKwAwQqBiUOgqWJ5qJUU/98cbqBRUkoEtCekcCphhCVDbbhKjROwwdmtN+Cxg7onQCiRtw5/X/J04XHELC0PSShryUOEx2EKxrt/wz6lrdiAaJqdQasMgQJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mg3N0Lk9IZOst7r5Zj6KwJNKQtpqvW1PCX5zZa2tzVA=;
 b=S2lg3/IDSTU9Vl4BSUqobKEvs5lreXCS5kuJFxlYmOJfW/NhYqk8bn6vQQ4Sspq1w9fbJXS6W31fyruqxRLWAUKHuRERyvLBEnLdDM3ArkbDeMiOvc3FfNh9pmvlIyfH9lnEcVCuN7DEr/cdSe1mJ94ksTksKUa8NsZqlTYljsNhIMYDEGDIahJVuwRulIegNPpvfHw6UFF3PgxdIpeRAnhS6HLUEXxdFRp5hp3e3MpETXuILuj9P7ybYrDF8Yop3gq1puBgFUCVdlDWw7VU/77ZFsvPRSORW3KbygsYnCCJt9nDaXFQLAmIt6+MEh2a8RPbOHLGZ2NLrxzMJhdj+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mg3N0Lk9IZOst7r5Zj6KwJNKQtpqvW1PCX5zZa2tzVA=;
 b=b3fB/rd1B3Z/7zQ5Nf1J03sP6tWRNrtBLm5JZZVhiVExCmMNSjzVuDbwXwyqCAapK5d4IL3kpkXxcpjB1+TewTT/SFBnm6fW3zWYfMYoWTPZoe12TmuwPo/Vmg4ssR2kdqkAWmXFUsVa/ZF4Sp5PFwvN3zOx+AQw3jY9PWqtj6k=
Received: from BN6PR22CA0045.namprd22.prod.outlook.com (2603:10b6:404:37::31)
 by DM5PR12MB2392.namprd12.prod.outlook.com (2603:10b6:4:b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22; Fri, 16 Jul
 2021 03:11:04 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:37:cafe::c) by BN6PR22CA0045.outlook.office365.com
 (2603:10b6:404:37::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Fri, 16 Jul 2021 03:11:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 03:11:04 +0000
Received: from kevin-ws.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 15 Jul
 2021 22:11:01 -0500
From: Kevin Wang <kevin1.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [RFC PATCH v2 3/3] drm/amdgpu/ttm: optimize vram access in
 amdgpu_ttm_access_memory()
Date: Fri, 16 Jul 2021 11:10:42 +0800
Message-ID: <20210716031042.827317-3-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210716031042.827317-1-kevin1.wang@amd.com>
References: <20210716031042.827317-1-kevin1.wang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a07a810-790b-4556-c588-08d9480758df
X-MS-TrafficTypeDiagnostic: DM5PR12MB2392:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2392CF194B64C085E3E427CEA2119@DM5PR12MB2392.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:489;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sKwn+Bg1CxUJxKSv0RDUX7Uchlnu+L95CI/elwNnhDGEl90iEzZ5CqVZx164W88PWJVve0ViGa3IJUF3PGl32nW00Ym/vIIb0ak+7mpon/xiL4Rm33JQL6FSK91edDTtT/fSQ53jeiF+uKhGKPZwORM+YgIm8bYVaHu/6Cumx9W3AUHX3OUmgC8El9N59tP/R+HJeFVYS2FcNo2gD0vh8pA+AMWfthBfJRH6cx4VLISUlx3xnGV4Bpf8x4WxPbBX3Q3tjWmGEVmwl7KD6uaUa8TH39xcL3kMt/caCCvC1zoiHBjLu8tcOOGYzFIPCIwUnXgPdEH+qXyNd9Ns6B+s7PPFd2VjpSrUkN0+ju9A6rO7zVnU+gJxYTH2L4Knr4/4KqpPkyPLiv0prgRLO1fWYXz/Pq0W6W8hcjmqq+WJToK8fqe8MZDIHmJgN4UWkM2Sq2jeJ4eECen/VotnuDqxXWB8HIWX3D5FHZtvVOJ5Q2ssWLkoy5N2J2Yy8A3bzusdfIlKbRvi8NXoTe9ovG0Rvw3idXYjjYpWlVtfT/Kga47BNYIsqi4DKuHwZiqaUOrJhIOgRc9Kqe6IXnVIgoFBkaWNw+sm77tinczeWINggaQGhBAOrGuNvz0HivdF7pxgJxM80qY0b4hWyzHp9yisk/goL3qsPuSZdqUm6QLFG8sluAfRWD6AqhmPgnrgeMEaFXi6Q6yeYRFrK/Vfzctd27QNKObK1dW3fcFWRQnnuTE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(46966006)(36840700001)(7696005)(26005)(6916009)(8936002)(4326008)(5660300002)(1076003)(82310400003)(336012)(2616005)(426003)(8676002)(82740400003)(2906002)(36756003)(356005)(47076005)(478600001)(81166007)(54906003)(86362001)(316002)(6666004)(36860700001)(186003)(70206006)(16526019)(83380400001)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 03:11:04.2127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a07a810-790b-4556-c588-08d9480758df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2392
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 91 +++++++++++++++----------
 1 file changed, 54 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index f4ff3c9350b3..62ea5089b4f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1407,6 +1407,56 @@ static bool amdgpu_ttm_bo_eviction_valuable(struct ttm_buffer_object *bo,
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
+	size -= count;
+	if (size) {
+		/* using MM to access rest vram and handle un-aligned address */
+		pos += count;
+		buf += count;
+		amdgpu_ttm_vram_mm_access(adev, pos, buf, size, write);
+	}
+}
+
 /**
  * amdgpu_ttm_access_memory - Read or Write memory that backs a buffer object.
  *
@@ -1426,8 +1476,6 @@ static int amdgpu_ttm_access_memory(struct ttm_buffer_object *bo,
 	struct amdgpu_bo *abo = ttm_to_amdgpu_bo(bo);
 	struct amdgpu_device *adev = amdgpu_ttm_adev(abo->tbo.bdev);
 	struct amdgpu_res_cursor cursor;
-	unsigned long flags;
-	uint32_t value = 0;
 	int ret = 0;
 
 	if (bo->mem.mem_type != TTM_PL_VRAM)
@@ -1435,41 +1483,10 @@ static int amdgpu_ttm_access_memory(struct ttm_buffer_object *bo,
 
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
