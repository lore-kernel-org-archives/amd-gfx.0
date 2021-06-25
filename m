Return-Path: <SRS0=nR5r=LT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85CDC49EA6
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Jun 2021 03:24:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76ED2613FB
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Jun 2021 03:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76ED2613FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CBE36EA83;
	Fri, 25 Jun 2021 03:24:31 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 324E36EA83
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Jun 2021 03:24:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RvCk+uG8ePpnwhKfhZiUwyZZZMUQk5sXIVuPYn4O+mkIXYi90ddCEHX9c10JVvvwA4RIKaLNDWD+74wQ4vKG4I5of93SrSkhht5/M9dReSMe6JKAjrWUMZJKDOUCPc2rbW27EZbKJIUnDnUtofxEpbfkN9swE3DzJBgtUzq1bHH6iFgW3MSjZ8oBRPHeiGPJiZaUtlkPoY8/yqLIQQCMaNKFOUKOskv7g64v06us83zJBB/4dzkShBtt42wIJFWCZ3J4Aqoq4CtKW8Ekjh9m0Rr0FkzcF3aq7HLNQ4lLDyMVe7zTBNRXGqhFi6bGcmf2Niy3dsPtj2a9hBtfGXKf7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6UkRb/Djt+NXpL9vyGy0Jp5koObn3OabyttHevINF8=;
 b=MU/uzG/VieOBBO3HDtle5FZwkt+hm5FamM20/CRYEpekHSbaFYPDnsWhvTNxHFWtn41IvflAgsiQrRWkh6OYw2hPLiKRl4i0ClLqMigbMdjvGgFEg5xaOs65ElvPjTvijMKcL67graTwCyKmG5zaXaRO0CPESs3wZ9DaEo+EvLBnFednshNGkX4WKgrQ3osTE5TMcPuR5vWofCAarS8Yck2OmcNqnq5HvFTTgNJHnGqp0CMlSa8+iU+1YIb9UIA81EqJ1odBx1WLKLmDtC06vk4vmVkUIHrgNRxx9r7mnLyqzB5xKe+NpdcPq4dWoLBuVzgc1OeTsTj895FzftdKOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6UkRb/Djt+NXpL9vyGy0Jp5koObn3OabyttHevINF8=;
 b=WrVMryG5/B3bR7qKiLWi9BcvHZBPB3eyfDUy1H1shptA9LFtn9TkE6cKItn3kSVxcu79RvpJbvpIWmiwSmtkapVLqjNaqQx69y1RqNXKu2+16vqRECUVDZl1wKifBugMjoYNiiRnTeqWIJKzMsIt9ErDNKZUz9M2qPifX/NJwoU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by CO6PR12MB5426.namprd12.prod.outlook.com (2603:10b6:5:35d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Fri, 25 Jun
 2021 03:24:27 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::c8f7:5e9d:ca99:1dbb]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::c8f7:5e9d:ca99:1dbb%7]) with mapi id 15.20.4264.023; Fri, 25 Jun 2021
 03:24:27 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: add non-aligned address supported in
 amdgpu_device_vram_access()
Date: Fri, 25 Jun 2021 11:24:09 +0800
Message-Id: <20210625032409.15715-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.134.251]
X-ClientProxiedBy: HK2PR02CA0211.apcprd02.prod.outlook.com
 (2603:1096:201:20::23) To CO6PR12MB5473.namprd12.prod.outlook.com
 (2603:10b6:303:13e::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-ws.amd.com (165.204.134.251) by
 HK2PR02CA0211.apcprd02.prod.outlook.com (2603:1096:201:20::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.19 via Frontend Transport; Fri, 25 Jun 2021 03:24:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c20c443-2a3d-4095-48a9-08d93788bc84
X-MS-TrafficTypeDiagnostic: CO6PR12MB5426:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB54265756076E14AFF9C6FDEDA2069@CO6PR12MB5426.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tlJPJv5A88tMWDMi592v3nPeE3IGJgSmUyGeUMPdIEx2Pk7HDIeIgkfOWRoWrz82ZiUDXezDLClpqJRJssZscra3KDVMSYVKoNoyrMYu81lXwBJDqmCTcINyLfGvFYu7MNDPf5hyNJV0CJw+8Rq/4Lhu3EAwcEEXK36N8L7vqCnRsdBY5J5pAndmYS3uXLVmkGWADAKnoE3WHdkk9Q7IBLINnm02GcQo4pAGvDOf64Cd/HFSDAcI7FsQpXyUh/fzAJudUfIXScW7pWrLqRy2qgEIodTbtOD5wIc14IGy7WA8oD2WUhLf14UrnqFbLjSHhHpdywsKVYQpCTCy63gwsFLQdMm28L/iM+9AMroPjTqc4e/+YRDx4FzvgRoYsTEPKv+VsOMHIEJWShIOhLlj+RAqFgLYGEzGqOAbq7sEyphBjGqLqHYfpM2t+f1agih7Xg7fFIgX2D2c+6ps/iijKXTOonPSsfit5TM5Lb6g5ijGRegtC4DOApq0V9R6PXb/pueORgAoQ8jXKGOEA3of+xXF6b8JyvMxd17rx4rqjCazOTjIUt7bx89gMPpYuv5LgEACykUmSZwIoFiFrlfRq7J0OpxGolOn/htTs8n9Buk6nrZ9dwUrCU5RRk9pl/pGX6P4BEyiuvsq/VjS6vh9ZRX+VenKbOcKkZPrAvbakDQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(86362001)(38100700002)(6666004)(52116002)(38350700002)(7696005)(36756003)(16526019)(4326008)(186003)(2906002)(6916009)(26005)(8676002)(6486002)(316002)(478600001)(956004)(2616005)(66556008)(5660300002)(66946007)(8936002)(83380400001)(1076003)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7lHcpvAGWpES0oGWlj50y/PP3gcQYXBwPC6ZFTZUziyFStFHgNjBAeHTFO0R?=
 =?us-ascii?Q?BiGNzORZZIFJRnPnRyu68ZSPa+rVCDUepJ1SD+BxatH1V/mmAdCRRA3oPL2Y?=
 =?us-ascii?Q?yWnDb/6dAvX/SSKnKADc8bQLPL+n5gFNSabcOR3rj8xXJE5izmzmqlKjLS0a?=
 =?us-ascii?Q?et2LheXTpKpXcI+l4k/9CqwhFgpW1FNgIchh0JRUPRQAn6MUdA7tEx/q9QKr?=
 =?us-ascii?Q?NKz1ezaLcN1pD/WLBDWcJZJufR1/1gJeVr+s3XzB70TfWCRbTMFLwwvWDYXj?=
 =?us-ascii?Q?UR7AzbHeLNo2Rie6ybl45A/QQMHnnS/njtmwA349wnX7HuPwYPc6JK4RZjgc?=
 =?us-ascii?Q?iLeBFOF2cWXl/Ne67AO4AWOKyoz7Qb9QDeJlJYWhT5yHuftj7VCjTBKceryD?=
 =?us-ascii?Q?SzgPY4nZ8QKS3KXrcjjWON+lOC13l/1DyEgn5rLIJ1OhL4aDD2yUmPqFTqI5?=
 =?us-ascii?Q?MwsCfJPBgH9auJZv9tEHDm4CastPpHO2SEOqF/dYRE8n+6BTtdlHLvN/aWuq?=
 =?us-ascii?Q?X7eFyDzvSKl1cEaP7SIn8eNWu3QPhtVULQcUga9Xng4bBCX9p2b1L6AzP44W?=
 =?us-ascii?Q?XCK3cZ9p1PD0cD5LAYjGHxGwwWjsQeweij4IYUoxzOp0KOuJXK1EWxKq7sq4?=
 =?us-ascii?Q?nrPDyOGOzmsC99YzMyTPVLPySsQFYE+Zy8aZ/Jo4iSXVInP/taHjz4eVkI0w?=
 =?us-ascii?Q?t3H9hm8NtbB9orII3TQKr/nb4oDSmYFVW5MYdCHOZ74ExNJ0eNQo7rh1QRSr?=
 =?us-ascii?Q?AhnxuR2CuEuIyVu2SgfBpTlp0a7eEOO2STvt5AlDWMZoZb52nmpAvsABLeyZ?=
 =?us-ascii?Q?jcReUqHK5P80sUcReGQK6vbP9eo0Af+KbDixWbC2QqJ/i2/jJaNgpk/L4oxn?=
 =?us-ascii?Q?imsscRguGlBzzYpqO1L27uAOaB0dCsrwISo+A0/a3giHRwiyZJbWBkMRevoK?=
 =?us-ascii?Q?fZhy7h5V5DZc7fMMe0J5JHsVJkFePljShkOrFE9UIrZYZYxUNuusMsTf+4Yw?=
 =?us-ascii?Q?bkRq8865/k92q8cTcoSGoHUt4QFpWZWDd8KBFabCBWEW41kRWVwhv59trlCk?=
 =?us-ascii?Q?JAmlknw9t1rmqIWeHQ57+Bg0AuiSbQjVAugruc28oQEc0671rQFOkcz4JzCt?=
 =?us-ascii?Q?sm8AzUteqwEIXmljMjiUrRCIIOkr3xeeDWdjb7+6o9Kig5JPK4RN40oMO8Yp?=
 =?us-ascii?Q?qraXvvO2B6eitNB7+7YQW6ehIVDjaVpJGXLkAsGDN81k3F2yZyOECvWPvQJ7?=
 =?us-ascii?Q?bAXqrC5RHs2oW1btHTDmpkvGGLFQmK+uUxtnU8lLBeHqVmLGKgYruyKq6SQC?=
 =?us-ascii?Q?fJvvt3r233PM4U28n1LH3l4l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c20c443-2a3d-4095-48a9-08d93788bc84
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2021 03:24:26.9333 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: btaF/qKTjXPrhgr/U7nR3HaZjObzYqUB6480jbxfcH8kUAyLu4WCUYOU6FzwMPj6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5426
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
Cc: alexander.deucher@amd.com, Kevin Wang <kevin1.wang@amd.com>,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1. add non-aligned address support in amdgpu_device_vram_access()
2. reduce duplicate code in amdgpu_ttm_access_memory()

because the MM_INDEX{HI}/DATA are protected register, it is not working
in sriov environment when mmio protect feature is enabled (in some asics),
and the old function amdgpu_ttm_access_memory() will force using MM_INDEX/DATA
to handle non-aligned address by default, it will cause the register(MM_DATA)
is always return 0.

with the patch, the memory will be accessed in the aper way first.
(in visible memory or enable pcie large-bar feature), then using
MM_INDEX{HI}/MM_DATA to access rest vram memroy.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 69 ++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 42 ++-----------
 3 files changed, 58 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index d14b4968a026..8095d9a9c857 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1103,7 +1103,7 @@ void amdgpu_device_fini(struct amdgpu_device *adev);
 int amdgpu_gpu_wait_for_idle(struct amdgpu_device *adev);
 
 void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
-			       uint32_t *buf, size_t size, bool write);
+			       void *buf, size_t size, bool write);
 uint32_t amdgpu_device_rreg(struct amdgpu_device *adev,
 			    uint32_t reg, uint32_t acc_flags);
 void amdgpu_device_wreg(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e6702d136a6d..2047e3c2b365 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -280,6 +280,54 @@ bool amdgpu_device_supports_smart_shift(struct drm_device *dev)
 		amdgpu_acpi_is_power_shift_control_supported());
 }
 
+static inline void amdgpu_device_vram_mmio_align_access_locked(struct amdgpu_device *adev, loff_t pos,
+							       uint32_t *value, bool write)
+{
+	BUG_ON(!IS_ALIGNED(pos, 4));
+
+	WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)pos) | 0x80000000);
+	WREG32_NO_KIQ(mmMM_INDEX_HI, pos >> 31);
+	if (write)
+		WREG32_NO_KIQ(mmMM_DATA, *value);
+	else
+		*value = RREG32_NO_KIQ(mmMM_DATA);
+}
+
+static void amdgpu_device_vram_mmio_access_locked(struct amdgpu_device *adev, loff_t pos,
+						  void *buf, size_t size, bool write)
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
+			amdgpu_device_vram_mmio_align_access_locked(adev, aligned_pos, &value, false);
+			if (write) {
+				value &= ~mask;
+				value |= (*(uint32_t *)buf << shift) & mask;
+				amdgpu_device_vram_mmio_align_access_locked(adev, aligned_pos, &value, true);
+			} else {
+				value = (value & mask) >> shift;
+				memcpy(buf, &value, bytes);
+			}
+		} else {
+			amdgpu_device_vram_mmio_align_access_locked(adev, aligned_pos, buf, write);
+		}
+
+		pos += bytes;
+		buf += bytes;
+		size -= bytes;
+	}
+}
+
 /*
  * VRAM access helper functions
  */
@@ -294,13 +342,11 @@ bool amdgpu_device_supports_smart_shift(struct drm_device *dev)
  * @write: true - write to vram, otherwise - read from vram
  */
 void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
-			       uint32_t *buf, size_t size, bool write)
+			       void *buf, size_t size, bool write)
 {
 	unsigned long flags;
-	uint32_t hi = ~0;
 	uint64_t last;
 
-
 #ifdef CONFIG_64BIT
 	last = min(pos + size, adev->gmc.visible_vram_size);
 	if (last > pos) {
@@ -321,25 +367,12 @@ void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
 			return;
 
 		pos += count;
-		buf += count / 4;
+		buf += count;
 		size -= count;
 	}
 #endif
-
 	spin_lock_irqsave(&adev->mmio_idx_lock, flags);
-	for (last = pos + size; pos < last; pos += 4) {
-		uint32_t tmp = pos >> 31;
-
-		WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)pos) | 0x80000000);
-		if (tmp != hi) {
-			WREG32_NO_KIQ(mmMM_INDEX_HI, tmp);
-			hi = tmp;
-		}
-		if (write)
-			WREG32_NO_KIQ(mmMM_DATA, *buf++);
-		else
-			*buf++ = RREG32_NO_KIQ(mmMM_DATA);
-	}
+	amdgpu_device_vram_mmio_access_locked(adev, pos, buf, size, write);
 	spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 6297363ab740..cf5b8bdc2dd3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1430,8 +1430,6 @@ static int amdgpu_ttm_access_memory(struct ttm_buffer_object *bo,
 	struct amdgpu_bo *abo = ttm_to_amdgpu_bo(bo);
 	struct amdgpu_device *adev = amdgpu_ttm_adev(abo->tbo.bdev);
 	struct amdgpu_res_cursor cursor;
-	unsigned long flags;
-	uint32_t value = 0;
 	int ret = 0;
 
 	if (bo->mem.mem_type != TTM_PL_VRAM)
@@ -1439,41 +1437,13 @@ static int amdgpu_ttm_access_memory(struct ttm_buffer_object *bo,
 
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
+		amdgpu_device_vram_access(adev, cursor.start,
+					  buf, cursor.size,
+					  write);
 
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
