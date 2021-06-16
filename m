Return-Path: <SRS0=JvQD=LK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A559C48BE5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 13:23:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 227E66115C
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 13:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 227E66115C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99FCC6E4F9;
	Wed, 16 Jun 2021 13:23:16 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD58B6E4F9
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jun 2021 13:23:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7hROaEAwS1d0T+STY/2P9qmxCo0SepI35UUofOd6RMmNfv4xt7qBuBozqVw/AL04V9wRaKAfaIratWYVnd5LRmIiznA4R7X0puYFt5q8tKha0xEyzQYm4HSR7vFACo9LmNCYDu3nNqLldrhu1tR+72POGUmvMIhYlwiVUx9s+vFLnXJ73s/WMxRCO8gvOwwwoy2lzOWjXA9Nhvk2+sPyW1sUf4st3gjNod9xsEe5sLgi3omAeSzwbFzu61M4qVk8MiFQwXMAYgDLJuNRz1foyQhdISLvT0TNuMGyrSbDflEKfXSAchxzxg7n2VvpvujiMaaYCXOI4XjMKD5lWUKfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7xj+kxDos5nl+j4/HH63bY8TaSB87qT52GJSeBR5/s=;
 b=RvPLwYMezzo5u0tww7pYB+fu14DGLawEQn/6qYQCheAKgpDs3p9yaBRowv6wq4nc8Cb9pqN/NrMOZmJqhbYbdMjgweNf3DHK+5DjnydYxkr7IU2wAPdQKTmoVjcV8lgrW9uadsAONDFvmdkwvX3CBi3xlPrxomXFEgpRSARuanmut7bU/e+ml10Zh2GB8W1xFrqNB7nAMJ+t1j2cTfz5AlhYDglQrzxdIaKgWFF12o3GTKaCFTsbxkp2SaTNFkVwW5S3ygr4BpjzUbMEzKTt9+R4+WVbf/+czbyTBSJBhJWNh4cb1BUsL/IB6e6sxgyj/cmIVcRmAd7sEIAR6UH5sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7xj+kxDos5nl+j4/HH63bY8TaSB87qT52GJSeBR5/s=;
 b=AzEPphQm28PfH+PA+gChsgvy65wOtKSTz0T2UZQ/7fOQkE6X1CHzWGzZX12h2mlPL4xi/Hg+E41CSlh5Lj+H/VzGlvzM0PBmm0JiXszr6G+GmkHJWvnhwmeLEtb4/RP+IIAbPy/rBr6VVJnG23y/kzmCx6l+kuQZS5kblLQHE7M=
Received: from DM5PR04CA0070.namprd04.prod.outlook.com (2603:10b6:3:ef::32) by
 CY4PR12MB1751.namprd12.prod.outlook.com (2603:10b6:903:121::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Wed, 16 Jun
 2021 13:23:14 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ef:cafe::e2) by DM5PR04CA0070.outlook.office365.com
 (2603:10b6:3:ef::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Wed, 16 Jun 2021 13:23:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Wed, 16 Jun 2021 13:23:13 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 16 Jun
 2021 08:23:13 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 16 Jun
 2021 06:23:12 -0700
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Wed, 16 Jun 2021 08:23:11 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: fix bad address translation for
 sienna_cichlid
Date: Wed, 16 Jun 2021 21:23:09 +0800
Message-ID: <20210616132309.14052-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1f086af-0d1e-45ac-eb57-08d930c9e520
X-MS-TrafficTypeDiagnostic: CY4PR12MB1751:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1751610830347D484E0516BF9A0F9@CY4PR12MB1751.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CKjnUaXO/3kn++FiKlB8cScOzdsu1lVF1m9NI9ZyFnGGXdBNQd9npqGEyfppecAuJXjTjzJ7PchbYJucR3ruon+pq0QYz7NL3uug5P6Y+VbLTLVNqOJxXEAp7Vc8yqvoNFJ/1qoqwDQI8e/MXghpGpf4MtLAG4rUV9ZsjjAsugmCG8mkuLhN5hhxcezh9IQ5jdzYAEZ5nNaUHMtuVgfgocb6h2nZzrQVYqluUG3KOpwMChse5YXbses4jrjyQRfNDFrz5Osvg80PR+8AfeA6jfJH2da52AAcz2jT/6AgHy8EU9n7S6BXZvWiUj9QwoDY9tXuAfVRdgeoVDN612CwPNe9Af1p62hO5hjydgYVFFdR52jaCkgCrJeI/z9pwOIsCKHIkMZiPWIwRq1clEoj3jaLkQTotYvWjXLBo0369JN8dMgMiH3WMBspHs+B02w8uzjmZYDRvBGwBtO7IdSPVECCGjE68rz4AGc+KZEN7vG3B4OfjD7YDgerazM7Knu9Acgv1g0t4etd4bB+2kqfrFsFCcePahx4WIwclpUDWsXktIK8/kTkSQ8v7GPMpbrFZijQ7znWSj1dPXgWjy0t/AV4B/TOUaQaM6zle8c2AlqTm5ln9jpgrDtbDLyDpqJLR9ipwaemJwl8BaTMWVxMT4d5LzQP0k0vtQmnBITBQk2/D4lLAeVoIR6kwgW0hrR0
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(136003)(346002)(36840700001)(46966006)(426003)(478600001)(86362001)(81166007)(6636002)(7696005)(4326008)(8936002)(2616005)(83380400001)(36860700001)(1076003)(2906002)(5660300002)(8676002)(356005)(186003)(26005)(336012)(36756003)(70586007)(82740400003)(316002)(70206006)(82310400003)(110136005)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 13:23:13.9276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f086af-0d1e-45ac-eb57-08d930c9e520
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1751
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h | 5 +++++
 drivers/gpu/drm/amd/amdgpu/umc_v8_7.c   | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index bbcccf53080d..e5a75fb788dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -21,6 +21,11 @@
 #ifndef __AMDGPU_UMC_H__
 #define __AMDGPU_UMC_H__
 
+/*
+ * (addr / 256) * 4096, the higher 26 bits in ErrorAddr
+ * is the index of 4KB block
+ */
+#define ADDR_OF_4KB_BLOCK(addr)			(((addr) & ~0xffULL) << 4)
 /*
  * (addr / 256) * 8192, the higher 26 bits in ErrorAddr
  * is the index of 8KB block
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
index 89d20adfa001..af59a35788e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
@@ -234,7 +234,7 @@ static void umc_v8_7_query_error_address(struct amdgpu_device *adev,
 		err_addr &= ~((0x1ULL << lsb) - 1);
 
 		/* translate umc channel address to soc pa, 3 parts are included */
-		retired_page = ADDR_OF_8KB_BLOCK(err_addr) |
+		retired_page = ADDR_OF_4KB_BLOCK(err_addr) |
 				ADDR_OF_256B_BLOCK(channel_index) |
 				OFFSET_IN_256B_BLOCK(err_addr);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
