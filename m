Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6DB4CD4F54
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 01:03:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8183310E600;
	Wed, 20 May 2026 01:03:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VU9ICyBS";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010003.outbound.protection.outlook.com [52.101.56.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96ACA10E5F3
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 01:03:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XoA1FP/aYr/zGq1yTnC4Y9XNdA0rflukR9wK0XDhgb0/o7fSPnh4UWvGY8WbcgMVZygMNtEN2db+VNg5/Mi05aEQJB5JNgqsD4TMaxGEZs0HLFtgCi/78qIDz+aVZ8Ph+iX9xL0X3+dNFa8TrwuJTCYmUAOk20Q6Z5Pmhw7Lfuq94Aes7oeKXgVdzAIWQiDbqgBSbKzMe7UCEKygoaUinU1AIal8Jac6Y+3DMahCqjP5wzc1TwyjrTiAe8Nspf47lxyZi6TJv9EUaZXj0f6SW+rE/RPAM1S3ToPIhxiF2f7iWNnetUvKBglQiKas0vbTNDcPy60/m/6BweYuODGFnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7epH4A2WUTlat4++hPPx2+yPeP1unRfdFdAmSD34+w8=;
 b=jC7uFQWxU9QyDX0NuM+SHm2jYuSicNwwCNFTzsK3OjJFhyb+U03u16PW47+JAoq7Id9xHxhe4b55qJWbYW8rNdR3O6myOKAhJSaKXZiTAOO/XTVgePAOdvVvqFWD4RRKFnRipJVpyZco9ask8Bx9M/m6OeAC4LSpx4CMDZHpz8RhJVogmQCbdboTH6U9N0J4ORrLHBI+yWA0ycO5fseMvSqPumQQbcMEReBgX8ekjvTKjXmkSPrUxUKKyOy5qys2n5xCuy8y1tOnGBCe8PvlH5nQF7xMvUX+92e8mZuLMiNy17ErMssKc6qtSbCMnqg/GtP6oiWvt5j/4/FDDV0Anw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7epH4A2WUTlat4++hPPx2+yPeP1unRfdFdAmSD34+w8=;
 b=VU9ICyBSfrqou+pP/NAEOoziXZkqweVRaD1TWJ457vJe7JFUaJriek47ds+UYBs6X/alBP24FLOeZ6UpYkflmXqhT77fPUjKQ9jPeaLX5wQTGtfRhhUZVrEG/HpoGjSOMc5R2GtI2EGPXqNUZGM89TPM+yM5Bq6LVwB82+2YF6Y=
Received: from CH2PR19CA0007.namprd19.prod.outlook.com (2603:10b6:610:4d::17)
 by IA1PR12MB7542.namprd12.prod.outlook.com (2603:10b6:208:42e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 01:03:02 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::11) by CH2PR19CA0007.outlook.office365.com
 (2603:10b6:610:4d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Wed, 20
 May 2026 01:03:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 01:03:02 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Tue, 19 May
 2026 20:03:01 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 May
 2026 20:03:01 -0500
Received: from AB350-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 19 May 2026 20:03:01 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Vitaly Prosyak <vitaly.prosyak@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: fix recursive locking in devcoredump IB dump
Date: Tue, 19 May 2026 21:01:46 -0400
Message-ID: <20260520010257.115740-2-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520010257.115740-1-vitaly.prosyak@amd.com>
References: <20260520010257.115740-1-vitaly.prosyak@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: vitaly.prosyak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|IA1PR12MB7542:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fc2d555-ed52-4f0e-72e5-08deb60b8ab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|11063799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 89Jhh3bOkTePMscnpxMzQRjZ8c5uTjv5ZtnoAtRA76ZJAH8CJJ6FYhyR8h2lihQUpY7cSE8QiWXxFENVcd+92MdXZm+ksilfXrWBeP7qL1XjA+jh4vvGhwdmzGTuiT3YRBt80tsgqJM4L4+ELXXU91D5l3Qc+ZFvV6/6OIZ3jDyImfusx1c/juXWGOuBYjh47DIE/O9lfI+Mn907JXIV4TbK2vwMSseyT6hAsPCLT+bmvanQEkX3cHslzY0HCLWxgeN0lrCtd7HT5lYjxu9RRdxKOOsKe9VAO7CWk5z/zZplbcfJ257iKjo46nZCp45UPm5U+H+NOojKynGNy3Ax3C8lQApiwQh3+8iw/I14uCkCY0NiAYQH9RoxnHQDqRGN05ofvP8BuodQqG+fceGyKhoyFYoRFXpFo2a+GSSEAcvIvcDNc4q4C38uEhi56z7jifxZD/lwGWiBr64ioFl+KwL8/Z+dvlA/0I3OCIJmZcLG0OEiCoAm2ljlaL0jRr4ibBY41jtD3TrWZyXei2XCBDXzql0nDhDTAX7DndsYKIvlVNtF5AQz0IsIvbdybxD1JSyoqSFC9ZKOq/h4O9I9PVCc2q2/3RADS/UyhdwC1QnmvCLxS4zJoOh/zd2u02RwQ5zwlDTfMDDpGkWpWZpai3re/NXd/nZht7lysASfriVrlMKATUpVDol8w7kuPViZG5Nx/R/5KIflVxFNJeqIsKwUl0nF0A52EyOAlkxAtZY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(11063799006)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fPBV1WEqxou45cL1pfXJ1al8vtZ7G7lNLf932iaeF7xLYR6JGBNxfKQx6Llspzbwhf1K98Wc8G+QWIu3bX5SWmZTeS3jNQT16JEMz5zbKwcnWUK5OAeFd+3sdk4UvE9x25VufU2Auxh3aPCok/JMec5yPkg6S57jl47LL0jaLQqKGd7WjIqpq98KC9TrtEJ8qx1mQsVjWZl69C7+g9TITiq1/b6F4k1bay1f0B9WNEMkZhgF53WTzVcF5To7g7S9+Nl8BzgghZXcPdLBQfLKR/tkEFpWrAPV5+JW51fArMC3LJ3fQQ9wLJK9MElDl9r2dxekux2cD+/tI8Xa2x6hX8jw73z7vtpqtsEzMnmnQX6rsPEor2O3LIMy0CElTtn8VoUmvSXuq2YB5n1UyqYu/UGAXAjzdVToWyoJXT7YMWZ1YsO/gEXudbJT8WkgZgf5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 01:03:02.1184 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc2d555-ed52-4f0e-72e5-08deb60b8ab8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7542
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

amdgpu_devcoredump_format() takes dma_resv_lock on the VM root BO via
amdgpu_vm_lock_by_pasid(), then attempts amdgpu_bo_reserve() on the IB
backing BO. Both are reservation_ww_class_mutex instances, so lockdep
reports a recursive locking (possible deadlock) since no ww_acquire_ctx
distinguishes them.

Since the coredump path is best-effort and non-critical, replace the
blocking amdgpu_bo_reserve() with dma_resv_trylock(). If the IB BO is
contended, we simply skip dumping that IB content rather than risk a
real deadlock or a false lockdep splat.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Change-Id: Ieebe7f103f52eb98b040c5aabf0a57c42db3cdf9
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index 0811593fca7f..714419c7b18d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -371,7 +371,7 @@ amdgpu_devcoredump_format(char *buffer, size_t count, struct amdgpu_coredump_inf
 
 			offset = va_start - (mapping->start * AMDGPU_GPU_PAGE_SIZE);
 			abo = amdgpu_bo_ref(mapping->bo_va->base.bo);
-			r = amdgpu_bo_reserve(abo, false);
+			r = dma_resv_trylock(abo->tbo.base.resv) ? 0 : -EBUSY;
 			if (r)
 				goto free_ib_content;
 
-- 
2.54.0

