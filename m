Return-Path: <SRS0=GTlj=2G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11624C43603
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 20:15:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D81F32146E
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 20:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="t8uLoyb0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81F32146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB3F86E880;
	Mon, 16 Dec 2019 20:15:33 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690065.outbound.protection.outlook.com [40.107.69.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC67B6E880
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2019 20:15:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6bFGcO1KGdfllzt3VaT19l+O9RmGcOlTjUK039B2ZVbeVG70Ife2L8J+2eN6Kj7//i8nf1v+Z2vg6gSOrXrvAH1F3qPuyH7ud2Mso98K9OytEHgNSVvmuS/5ikG+3hzjbiptBvfqKQyDAsQK10XW8GpbkFIKfzwUw7zhRXvkoyBvUYJq9HCBI9RmMdL6yA6mBbMGHHPsHQVOBLWMGZl5zdOXfI8Sy42qpyRQzJnZosCpAUd67+tOhu/XnMUQIO1VSIKlotH1EYslB4d/wYjEPbRwONxVezwnukj6SfbIrz9JYMCKI2KhKGLJBlYUJ56PJXcBzxph0KajVGst+QizQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqhgAspIVcw9+L5kxW2IG8Y/6c0LQML1ML1BsSzc+LU=;
 b=AtHUMj0699IXgDOT7kvUZkPq/aW1IG77sX/Sq1AGmKrAi0Op8VsebqZVIz1z0MbYcjvC3eKlCW1AY53Z6iEuxs04w1ug9Hbk1Xk3nTBLkCkomV7J5Os2JtjjKhNUP+nMXjI9+rcYSRhj5ExV20Gmvtk5KC49e9qKHiYUMz8WzZnuO6DREiD8FAshGR7GUUQN1Bb/6IjEOwRQaVSzOMf9rj2Osep0KL0GsoY54ognduuVlazbkgRXyIwRncC3NthPowudxl8qipkFVpe8+n+JXt1C7G6b3WhmqNPR6Rb2S6Ieb8wKAMm/a0SmC4mM9xEOumFtnbmmcIwufxwilyj0Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqhgAspIVcw9+L5kxW2IG8Y/6c0LQML1ML1BsSzc+LU=;
 b=t8uLoyb0eSqCGYOYzqIpiwm2YVpEQ4X4hjs8QN+Rw7mAJDWLOSmpuxUBPK1P1GvRP/q6Xjdgs7CtIWEY3mfl+61fUXoY5Gyo1gMuBmy/cTQ51ckpb5JK2Q9Cap49FeWunP9sfMX2bT1KJ+lnZdQej0+bfezTjOHsNZr+CLVLqDQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
Received: from DM5PR12MB2456.namprd12.prod.outlook.com (52.132.141.37) by
 DM5PR12MB1323.namprd12.prod.outlook.com (10.168.237.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.19; Mon, 16 Dec 2019 20:15:31 +0000
Received: from DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::5c07:10f2:d913:b03f]) by DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::5c07:10f2:d913:b03f%3]) with mapi id 15.20.2516.021; Mon, 16 Dec 2019
 20:15:31 +0000
From: Leo Liu <leo.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/vcn: remove unnecessary included headers
Date: Mon, 16 Dec 2019 15:14:44 -0500
Message-Id: <20191216201444.28465-1-leo.liu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191216160543.13054-1-leo.liu@amd.com>
References: <20191216160543.13054-1-leo.liu@amd.com>
X-ClientProxiedBy: YTXPR0101CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::33) To DM5PR12MB2456.namprd12.prod.outlook.com
 (2603:10b6:4:b4::37)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8e4ae8f1-321f-46da-c239-08d78264b33d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1323:|DM5PR12MB1323:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1323419D08A1CF4323F4C2DAE5510@DM5PR12MB1323.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-Forefront-PRVS: 02530BD3AA
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(189003)(199004)(6666004)(2906002)(186003)(36756003)(6506007)(52116002)(44832011)(6916009)(5660300002)(2616005)(26005)(4326008)(6512007)(478600001)(66476007)(66556008)(66946007)(81166006)(81156014)(86362001)(8676002)(8936002)(6486002)(4744005)(316002)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1323;
 H:DM5PR12MB2456.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Gqro8JQTXQVGG3KxkKnybl3WMBNWJLmU13d/+3U0clZp3wlEFkaUTp7z8OVrBzNiDkovCJJvHDF/Z7xzOJJe+dSpZXXuzGFi3qZhc9jTXOeZUB7QA4o3r95fcaRLIdvZIt7mWdT6ySZwlqjbO1/QGqBe9hg7VEvzJACcCUiRMC+PsNki12noXl1lclJIsiZk7ejm3xxLP70U0us2LmHa1e08Z4QSoBccwWU04MeDfDdqc0uQz78P05JcdiSTb6SUSlFaxQ1YwyUvcb7jTcUJB4/jZUa6GycqcZ2340QBi55DfJATVhNSen4Z2HNw3IMRSuxh5miwLb6Le+lbyWs8Wtw5O88ytL3An+oLVum6NewYKDB34ddNzskaP95D3ui5OgGci6KsaepehrFM/b9MlyxWm2dc3myLDFsiV66MLBg2jUN/J/KYI++wRkPez+g
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4ae8f1-321f-46da-c239-08d78264b33d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2019 20:15:31.4702 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YdcjtJmX2UowYdab859tHFMkBWr98DY7rKsUqjK2Bs/ag2E7MOH/OHN5ZDUcBiup
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1323
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
Cc: Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Esp. VCN1.0 headers should not be here

v2: add back the <linux/module.h> to keep consistent.

Signed-off-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index e522025430c7..623b9f9ef1ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -28,16 +28,10 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 
-#include <drm/drm.h>
-
 #include "amdgpu.h"
 #include "amdgpu_pm.h"
 #include "amdgpu_vcn.h"
 #include "soc15d.h"
-#include "soc15_common.h"
-
-#include "vcn/vcn_1_0_offset.h"
-#include "vcn/vcn_1_0_sh_mask.h"
 
 /* Firmware Names */
 #define FIRMWARE_RAVEN		"amdgpu/raven_vcn.bin"
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
