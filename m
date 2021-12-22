Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD8AC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Dec 2021 05:51:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AD8010E22B;
	Wed, 22 Dec 2021 05:51:57 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 481C310E22B
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Dec 2021 05:51:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6sC3Aiu1uIAD8CFcqG31rb1QU21xw4ibelAUAacQOvCyrX65h2mEDAO0jBbAn/dA+eVKP8b9TXTIFD5X7yLatZJwJ1OAki28eTEjPIyOF3zfDrHgsBgIApGUb49QrmhBzpHgKgOO8oixXtkaUXsVltq8m3KP6/XhPz/URkQ51gY+D3W1+cjXpWWKbTFDLN8dmbLltHz9S59Dz8IEBULY8lmBo4kNo21O+XRhBw+sipfNiWh8oGpSTXXPJrNelQJRsWKlzw7MsywS/Ud71DLHowX85oIN8U9Y48T/QQYWHz4q86PEETZhX+fuqMMGLNVPdn4cx8/yVVUq5pPmt8HNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzImYX2zs+MRNk0NuLUz8/NNczdJTP2gQMsb966fDYE=;
 b=Oxq58kiKr5oeNtZZZo6QnG3xNv5bkzOvEfAYI4Lzzjn5DVFdFyKgAeBM6U6ihJVJydbtx5VOZSsfxll7rrIiIIpy6OYt5KQPelv4Bw74i5g7dd6RR+gN6RHZrp9rqbgg3d76ujLOCpQdedjl2IUUXxFbqlbzs8HPhHBPw6BaaPgPi3fCoQRT7eAkROC2AczAdFYDwK6iTrZhs911+SV52og4cSOdk56w+ck902u61aS9nX5h2TAhADU1ifZu3aO0qBEe6ilfY/zs3S8FTt94b9sX6GFlanoxGyHdT+RkgPmVQ82y5B64pkrLNX1MOYT9DZckcneWxVRmF0zgEYhh/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzImYX2zs+MRNk0NuLUz8/NNczdJTP2gQMsb966fDYE=;
 b=MdPExzI4HIE7sC0gpBjuHJwnekZTb+8jEt3PyOatbkgzzXeLgn9+0Y67H1J63ah2VVfB9RmIqFByRMTjZJynZa5CK+Bx3kWC24t6/5WzVkAXhMexjmn/XOatWgRIruqVVvfW9yopcIoGF4QZ/v6SdJUyOOWIGHIVmxTDI9/XKi4=
Received: from BN6PR22CA0057.namprd22.prod.outlook.com (2603:10b6:404:ca::19)
 by MWHPR12MB1616.namprd12.prod.outlook.com (2603:10b6:301:b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.20; Wed, 22 Dec
 2021 05:51:52 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:ca:cafe::64) by BN6PR22CA0057.outlook.office365.com
 (2603:10b6:404:ca::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.16 via Frontend
 Transport; Wed, 22 Dec 2021 05:51:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4823.18 via Frontend Transport; Wed, 22 Dec 2021 05:51:51 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 21 Dec
 2021 23:51:51 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 21 Dec
 2021 21:51:50 -0800
Received: from victor-aws2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 21 Dec 2021 23:51:49 -0600
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/ttm: add workaround for some arm hardware issue
Date: Wed, 22 Dec 2021 13:51:40 +0800
Message-ID: <20211222055140.1215839-1-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28f92d94-2856-4ec0-d2f0-08d9c50f26b8
X-MS-TrafficTypeDiagnostic: MWHPR12MB1616:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB16163B492ACB0CED83D6EB62FA7D9@MWHPR12MB1616.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f6u6v5Tih706+e0ywcejQQjpBLPgjUkqMmYdvE4/N5lwKBev8AdS0jmPRfdHqMie+mpmy1WlqYAk72k1FIdtuXyZW5ZaL5Ne8Xkq+6WcTktEQU7l4AUsgBBczW7tgKw9zyhPNLSARgwfvZb6RS7hcfASJYIuBy6KULxFtuDXEP6XmsVAhBr4k9KZRFYP1g6bgddWIpt9taiBpt7LxumsjZ+STf01v5j+WFpGtobun/s9Ju2iuOSOkqKYAbtGrolzbzWpsBmk1TqPaGOzwHSOKz52Tsu6UDXLyJPVZBUlzLXLPiw0OtogkRsN3leDgXx1wpsE3Hqed+gHrVAVKJCBitGkx4HrSpS4bbBnnGVAYw5ExnfsatuoL8B6sH/uQx7+28QShXVv+6RPm+m0f8phBZGLBiCAGd6cbhTg8t5FQmkSixJdj3nChCQCaMb+lwLVFOK1bIRSFhsrIKQkkD+twqXdvfXNTSMf7+yvPHT0jemef0LL8pWzzXHRNP++s+k9ihxWElZuUoOiD4Zd/Pv6jiLT+FiJNCfIx6/tOM3sa6S+ozpxH8GWtjaxUduDy+IIdTPMOwsvzilwDL6ibVBOQ2lsCUBMuEAnd0ybiHL/BN06UDsyunlD1/2VkQ99hCnVqe4R5lTCiyoXEtbzIYcr0YSTVw67JhBB0BDVviHNUJxlVddyDtbFGaujw1SL5Bae9DXF8ZAIO8QV9e27BTSiBhbLCEfnsADTwADWzs8IzsS+zHkccnUyOIpFUW/rWwP6zPcXRZcAvvsHqXK20lGaRvj3jJg2FEC7c8wNu6HT0Sg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(46966006)(36840700001)(36756003)(6916009)(70206006)(36860700001)(82310400004)(336012)(40460700001)(6666004)(1076003)(81166007)(70586007)(2906002)(8676002)(83380400001)(8936002)(5660300002)(4326008)(186003)(47076005)(26005)(316002)(7696005)(426003)(2616005)(356005)(508600001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 05:51:51.3995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f92d94-2856-4ec0-d2f0-08d9c50f26b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1616
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
Cc: Victor Zhao <Victor.Zhao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some Arm based platform has hardware issue which may
generate incorrect addresses when receiving writes from the CPU
with a discontiguous set of byte enables. This affects the writes
with write combine property.

Workaround by change PROT_NORMAL_NC to PROT_DEVICE_nGnRE on arm.
As this is an issue with some specific arm based cpu, adding
a ttm parameter to control.

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/ttm/ttm_module.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_module.c b/drivers/gpu/drm/ttm/ttm_module.c
index e87f40674a4d..b27473cbbd52 100644
--- a/drivers/gpu/drm/ttm/ttm_module.c
+++ b/drivers/gpu/drm/ttm/ttm_module.c
@@ -41,6 +41,12 @@
 
 #include "ttm_module.h"
 
+static int enable_use_wc = 1;
+
+MODULE_PARM_DESC(enable_use_wc,
+	"control write combine usage on arm platform due to hardware issue with write combine found on some specific arm cpu (1 = enable(default), 0 = disable)");
+module_param(enable_use_wc, int, 0644);
+
 /**
  * ttm_prot_from_caching - Modify the page protection according to the
  * ttm cacing mode
@@ -63,7 +69,7 @@ pgprot_t ttm_prot_from_caching(enum ttm_caching caching, pgprot_t tmp)
 #endif
 #if defined(__ia64__) || defined(__arm__) || defined(__aarch64__) || \
 	defined(__powerpc__) || defined(__mips__)
-	if (caching == ttm_write_combined)
+	if (caching == ttm_write_combined && enable_use_wc != 0)
 		tmp = pgprot_writecombine(tmp);
 	else
 		tmp = pgprot_noncached(tmp);
-- 
2.25.1

