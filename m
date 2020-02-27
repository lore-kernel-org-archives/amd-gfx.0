Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC141C4BA3B
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 11:21:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B001624688
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 11:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GaVj+txl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B001624688
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 532BD6EC8D;
	Thu, 27 Feb 2020 11:21:51 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760047.outbound.protection.outlook.com [40.107.76.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DBE16EC8D
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 11:21:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfYC40T/obms3QjIlcbZp1HGw1o8FZhz/USWR5nVL0yqudfxgAUibEuyh2ROAB9Xif9bgL1EH81p5T0EeYhtcP04o04HL3kJn82y+AzRTJN+TUl+y3XX44d22HdA4kgMBRbTTvKLFYRKYtv4dEjhtuvx5QK9b6QgIG7LGA5xSFzOPJLINPWDZCuvo6rCl6Fq6Nw2eyA76ZL1653WPDApqaZ1/Q96cEVAp3I5rL4vgaN+yw7zja7siTL7uahOp18zFpihKHwfNnSM432L1cFcAP2iux4Mg+/FvxZdboT9elFHYp7zxsFSDgG1joQ3qZSA6M3Qgd6NfqlRhGwP0tDDIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFrgzYHKjQ17x6d1xpSaiIqPkgYhpdmN7J4Fy53CIgw=;
 b=kvzN3PybErt5eum3yiO9+Rw+gmcmcQ2andn/fvlYNtSs471AFx93iQgLUatdzOf5ZZvsZIyYHqo+eUOu9y99jUmUniajQNDjXyL05Q6BJLwtrXlYe31gXKMueoIYJyAr8S9JNPKGvOHtMt6BP6C9b98oda24+mJjk6ME+62nbz7Mo9QDtpVkQ/yvZeZ39DHcc3aMU8THh/DiEhcmo+XOx+uJ20tuyyFJsXUgksrIgo4531H/ZEaz2TmFal+YXizYv+FjXZZmbZLoGNBK+k6R3cjlqmXZR7GfN7n5yoT4xEyMsZnvjMJaPbXnablRupWpNPJ/xpsHxwO93kma3Fb4ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFrgzYHKjQ17x6d1xpSaiIqPkgYhpdmN7J4Fy53CIgw=;
 b=GaVj+txleKFvqP3w15dzZmeiA7nvN7xq5qCD356bQgh9Qak534NMTEgIWYSpPpx776OjPEnhntXoClDc4cAXF2qg/Qv1O7h7pEjdvJ3V0fR/A/mKtdajkAaBLwZxdOOZ4enb9bGoZ4WMy33oFkQ1gJ4mRbAzfGfAYrxbTrmBaqg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jiange.Zhao@amd.com; 
Received: from MN2PR12MB3056.namprd12.prod.outlook.com (2603:10b6:208:ca::15)
 by MN2PR12MB3917.namprd12.prod.outlook.com (2603:10b6:208:166::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Thu, 27 Feb
 2020 11:21:47 +0000
Received: from MN2PR12MB3056.namprd12.prod.outlook.com
 ([fe80::10cb:fc6c:98ff:d995]) by MN2PR12MB3056.namprd12.prod.outlook.com
 ([fe80::10cb:fc6c:98ff:d995%7]) with mapi id 15.20.2772.012; Thu, 27 Feb 2020
 11:21:47 +0000
From: jianzh <Jiange.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/sriov: Use VF-accessible register for
 gpu_clock_count
Date: Thu, 27 Feb 2020 19:21:19 +0800
Message-Id: <1582802479-14724-1-git-send-email-Jiange.Zhao@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: HK2PR02CA0166.apcprd02.prod.outlook.com
 (2603:1096:201:1f::26) To MN2PR12MB3056.namprd12.prod.outlook.com
 (2603:10b6:208:ca::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from navi12-sriov.amd.com (180.167.199.188) by
 HK2PR02CA0166.apcprd02.prod.outlook.com (2603:1096:201:1f::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2750.18 via Frontend Transport; Thu, 27 Feb 2020 11:21:45 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.188]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a8fe32da-94ee-40b4-ccae-08d7bb773b7b
X-MS-TrafficTypeDiagnostic: MN2PR12MB3917:|MN2PR12MB3917:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB391767F51ECFCDDED299E583E1EB0@MN2PR12MB3917.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(199004)(189003)(8676002)(6486002)(81166006)(8936002)(81156014)(6916009)(186003)(26005)(66476007)(2616005)(956004)(16526019)(66946007)(66556008)(52116002)(7696005)(6666004)(316002)(36756003)(478600001)(5660300002)(4326008)(2906002)(86362001)(43062003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3917;
 H:MN2PR12MB3056.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x+tL0lVRfhtgzunApwLaGNyjwItx8rZaIbquPfHkxeTox4EmDgpazyrlOHehdRSXsN31KIl3mh4gToWjXeeYUnafWYsxq53ftUaLiXFevG9gcozVOwPOjPJX1cex4Lrx+yi+jK63cVwYA5WGcAG5HAbKtXIjIYbbIubSP7W8kY4vjL/+Lg/PAf71UxspOWbKvKM0uL0l8v7FhJU0E7epnawntoBJpAyGUYPK+s5pPPkoWo2PjZ7DRL1C5gSnITY8cm5rRwKq9p5MgYmlfr2R6FliovuZ48ofh8CoPe4CXuHJJPMkzuP+MuMM25lR0Zdy9CuprRjwsfFwPliRBuUddlRR/fdlwlfRVqDRLyb+8F2rluKEYh2vxdB3OqzsYnOkKibKXszyPWao6BXrhXESOLbM2LAo3CnvLTXilrncKPjp6h2lG2YldWn1QTdwopOEt8NVtVDR3McKSYA/Q3XL3lZtF86ZgY0bdKSpIyDPDzF1GdtyftdCPM+fyZdVXzw3
X-MS-Exchange-AntiSpam-MessageData: tAQHFEpgKBYjxosgDMeomYbDLksqLi/gVcRTcjm/sQ6H3sxBBuawTeY+Mwdq9P0vkrO4MB1iTLbW74e1ggE6bHhdkZRz/cTxaJeWjTc9vAUS6IAZkIZBJjY+1Wr5gNh6cDz1JCkJsBZiKTT/StBgKw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8fe32da-94ee-40b4-ccae-08d7bb773b7b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 11:21:47.2474 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8W5rLt/7mO3hBWdeuNmXkY19CncMbj60msYlXTeTJJ+kc59eyQu0+T2iANcMPFCT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3917
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
Cc: Emily.Deng@amd.com, jianzh <Jiange.Zhao@amd.com>, Monk.Liu@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Navi12 VK CTS subtest timestamp.calibrated.dev_domain_test failed
because mmRLC_CAPTURE_GPU_CLOCK_COUNT register cannot be
written in VF due to security policy.

Solution: use a VF-accessible timestamp register pair
mmGOLDEN_TSC_COUNT_LOWER/UPPER for SRIOV case.

Signed-off-by: jianzh <Jiange.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 44f00ec..8787a46 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -35,6 +35,8 @@
 
 #include "gc/gc_10_1_0_offset.h"
 #include "gc/gc_10_1_0_sh_mask.h"
+#include "smuio/smuio_11_0_0_offset.h"
+#include "smuio/smuio_11_0_0_sh_mask.h"
 #include "navi10_enum.h"
 #include "hdp/hdp_5_0_0_offset.h"
 #include "ivsrcid/gfx/irqsrcs_gfx_10_1.h"
@@ -3920,9 +3922,14 @@ static uint64_t gfx_v10_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 
 	amdgpu_gfx_off_ctrl(adev, false);
 	mutex_lock(&adev->gfx.gpu_clock_mutex);
-	WREG32_SOC15(GC, 0, mmRLC_CAPTURE_GPU_CLOCK_COUNT, 1);
-	clock = (uint64_t)RREG32_SOC15(GC, 0, mmRLC_GPU_CLOCK_COUNT_LSB) |
-		((uint64_t)RREG32_SOC15(GC, 0, mmRLC_GPU_CLOCK_COUNT_MSB) << 32ULL);
+	if (!amdgpu_sriov_vf(adev)) {
+		WREG32_SOC15(GC, 0, mmRLC_CAPTURE_GPU_CLOCK_COUNT, 1);
+		clock = (uint64_t)RREG32_SOC15(GC, 0, mmRLC_GPU_CLOCK_COUNT_LSB) |
+			((uint64_t)RREG32_SOC15(GC, 0, mmRLC_GPU_CLOCK_COUNT_MSB) << 32ULL);
+	} else {
+		clock = (uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER) |
+			((uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER) << 32ULL);
+	}
 	mutex_unlock(&adev->gfx.gpu_clock_mutex);
 	amdgpu_gfx_off_ctrl(adev, true);
 	return clock;
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
