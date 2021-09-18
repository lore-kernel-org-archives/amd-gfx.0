Return-Path: <SRS0=x7R6=OI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F3FC433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Sep 2021 06:09:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C18B61212
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Sep 2021 06:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7C18B61212
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB24C6E0D8;
	Sat, 18 Sep 2021 06:09:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AF936E0D8
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Sep 2021 06:09:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9+5xEOk83bDnC5bOwkFEk8hqei/mmK1x8IuKMb4o4Jp+2hL0u9q7f61KcLzIw9xYECdNgRxPPjlSI1BVgQJ31USNPRRU6hLqjN7zHhdiaKP2vGixsvwka3kNl++qCT1gLwCGRkUEX7DtoIWJ9YVg5nOfLiEGq3gVdPXrDUHx9JDQT1WlSgjAXHJQf1rvCz5bPUARUt0+cz3ZT6lCy5JAJHeB7Nvhaqp9YHdZ4wmkMAupY4+OP4KHo/RrTjKg/9C83tskV8Q62S6pFYFQmEB281KhJOI7ENP0m12aT54ok6Cg7Im6XYx1RxBTD8cNoanaQhUkLCS0/ZzYlp+CdYGGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=NZWP+z6SJHLZ7IO0HQRtqbsv8wQ0uZGH5dUOexxFBIM=;
 b=VIBj/yDA8ZYWoYLmMtrmp1PTefP0e8+6Y/q4j4gnmVwKmGekmlOYekwNlqPHeKoejnFof/o+GlS0KgMzAbXEZR26VfEjZ8wBCgYN48gSBIF++CXomDtHhTDHVXH87SYlJUJyEIKmA0Yjbh4GCRPnqaULHDXajbtXqv7kYrR937RPWGM4VNIL2jUZDVnWqzpNJUqi7YsYOCb8e3wcDVeR3zJbjdo8NFteUlJzeh6E7N9g6mk5yaiI0KctFGqGCcWgc8ugzg7aPk2M2lByljwnRCK66NXk8Hoz+iK76EW+FKi47mpArBINxbDyWVND7w2Mq5ZwVqxt7ZnyJSN6jWsVSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZWP+z6SJHLZ7IO0HQRtqbsv8wQ0uZGH5dUOexxFBIM=;
 b=oA3fhjzesoAQJ2dENcELixqvuevIdPbnkoWrVaBUdyXVIc+ONSR0z2+MeUJdnzy7lMm03++5tL0jw3ipdf9hsnBVuQpadJ9JjYWY50nGilicfCdOkNjgACIaubIQ/RnKiFP2NSpratxtrsx7oeUUEyIDlWyCA3kq69VlSVGO+V4=
Received: from MWHPR17CA0051.namprd17.prod.outlook.com (2603:10b6:300:93::13)
 by DM6PR12MB3561.namprd12.prod.outlook.com (2603:10b6:5:3e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Sat, 18 Sep
 2021 06:09:28 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:93:cafe::b7) by MWHPR17CA0051.outlook.office365.com
 (2603:10b6:300:93::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Sat, 18 Sep 2021 06:09:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Sat, 18 Sep 2021 06:09:27 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Sat, 18 Sep 2021 01:09:24 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <xinhui.pan@amd.com>, <alexander.deucher@amd.com>,
 <andrey.grodzovsky@amd.com>, <monk.liu@amd.com>
CC: Guchun Chen <guchun.chen@amd.com>, Leslie Shi <Yuliang.Shi@amd.com>
Subject: [PATCH] drm/amdgpu: move amdgpu_virt_release_full_gpu to fini_early
 stage
Date: Sat, 18 Sep 2021 14:09:09 +0800
Message-ID: <20210918060909.8068-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1ab80f6-3dcc-4c5a-ce72-08d97a6adecd
X-MS-TrafficTypeDiagnostic: DM6PR12MB3561:
X-Microsoft-Antispam-PRVS: <DM6PR12MB35619415961BF2FA69CB2FDBF1DE9@DM6PR12MB3561.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xxjLaqaH4NPE6OZwo8bHQ+dm5heP/LnN/skCLmTJrX6jBaBr5n++rWbttyaHjFVlFJXKiAa9VqAa7Nysv3j2NYzyf9+yZcR7om+FtMZohwjoDOyqZWpQ8QGMzQFVm2T0BN82vvMPn1sxQpwfhlLjTzIsOim9XIxqF4b6VtmCPPCdPH297OZPwDagAoNPfznRbLqaxtejLbbrT/o8Mi1N8a/0VyY+4NjHlOa9M/8SEx8FWX2jkcvIF/B26dSOu58rwa2QzJkAeCda7Y/eb9C5qpIZytfRM2xiFoDASTtKrbeiU1guJKeHh/EQ6doQwrN8NvsnQ2DftaRgZh3Ra4yH5G799xWR6IgtTo71uiAiN9pYKiFh7xSwMn6lBoioRgP+dKgOBwQtFEo16eeuI3o3FR30oPMIBZQ3Tih69ogRnGAHLRiDy3YVbcUMBiZzGRsQr7oMMNvnicH0Nt9cn80ro5okncwEswZn/mY8z+8201jfbEZWIB5rsV7ZzMBya6jqcgOaQv8V0o92brDwUr79d3PVrkVoHfo+osJskKAU6s3FNVTmJV3b9ztwn881nbb3zbgDxGSgP0yUGFr1py1LBtC2TnXVth9+PCZSOsGWp9I2b1g2nLioRfaaHBt2feROfNRGg4qjJMFFkdZw8SMIw+PljY1rPw5nLeSnxChqR63tM8Wg3tqcF5K5shITcULkBjWioVMdw5kIVLeW0FQar1KvewlID0qbj3n3zfRc8k0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(336012)(44832011)(26005)(16526019)(6636002)(5660300002)(508600001)(2906002)(70206006)(7696005)(70586007)(81166007)(186003)(316002)(86362001)(356005)(36756003)(110136005)(83380400001)(82310400003)(8936002)(4326008)(36860700001)(2616005)(426003)(54906003)(47076005)(1076003)(6666004)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2021 06:09:27.1158 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ab80f6-3dcc-4c5a-ce72-08d97a6adecd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3561
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

adev->rmmio is set to be NULL in amdgpu_device_unmap_mmio to prevent
access after pci_remove, however, in SRIOV case, amdgpu_virt_release_full_gpu
will still use adev->rmmio for access after amdgpu_device_unmap_mmio.
The patch is to move such SRIOV calling earlier to fini_early stage.

Fixes: 07775fc13878("drm/amdgpu: Unmap all MMIO mappings")
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f3da97086f7d..2a75c09c4884 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2810,6 +2810,11 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
 		adev->ip_blocks[i].status.hw = false;
 	}
 
+	if (amdgpu_sriov_vf(adev)) {
+		if (amdgpu_virt_release_full_gpu(adev, false))
+			DRM_ERROR("failed to release exclusive mode on fini\n");
+	}
+
 	return 0;
 }
 
@@ -2870,10 +2875,6 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 
 	amdgpu_ras_fini(adev);
 
-	if (amdgpu_sriov_vf(adev))
-		if (amdgpu_virt_release_full_gpu(adev, false))
-			DRM_ERROR("failed to release exclusive mode on fini\n");
-
 	return 0;
 }
 
-- 
2.17.1

