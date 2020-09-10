Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213FCC433E2
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7FA121D7E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Ne2QQeHq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7FA121D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F36C6E94B;
	Thu, 10 Sep 2020 13:47:58 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 100AC6E94B
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 13:47:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYuz6LUPL98zmDWCjaWiJLLxfJD6wsLUmOhwrOK7v/pJ0HpEgUiBTslZha7k7rzAjOCTM/g9H65AyogBOCFR0l5ZAgEhw2EgT0TJYBZwsOoarGPpcJsLDNH8UTPCe68hK9TCiiKiIpLVy3Lg6tECEfkiaYlvJFOYx9DakMFgKF6/KAERk3QVIkbvivb5QcYVty5SLSgs/isvHqjzxreBu+WhBZ5SmVPZ7xwPxPCdmM/x6DtiRIqxEhuBpLKsQSJAJxmidZMPmv2vHPFRX3BxOr6qYDDczY5+Vb8X2Pb/RUbkc3aYUimcuqIG2piDJmJjWFdAdxofGwIWoCO7Rw0jdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lu2C9j0Xk0hm8HffGlbVkbevN+K11yKZiPWFIEt/0sk=;
 b=Uod+Rieredjw3wmGSnxqLP2zz7H/nQl7SZymZ64eY1iSxsYXX/huyXKFiGec198G5+4nb5WMYl15zEWZzgxwLdIP2S1YO/bsZZnTnmtbkuBUwd7ZlnMFVTLt0nKAvTxdjQyd7KjrqNC+XkGdfmdjbJx24BhcoUCyrauE8JbHrHLV/b3EaQoHztfNIaQliAFjGSegRMaWUetPEKZpVU92sjw7NPlHSQyLeKZLTqfeqmCYgZvI7mYKIXdrymNKVR4LyS9FvwNL5mLEzL5ODx4hsWRzzBjGnsncDpRpxYHtpsl2YT2Y83LOmBHKOoKVV6D5wKxdaGKA/Lge1eK3K5kWJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lu2C9j0Xk0hm8HffGlbVkbevN+K11yKZiPWFIEt/0sk=;
 b=Ne2QQeHqTG1TexGkfKCfIZitCbgdOx7eYVCXZvRzPi9cR9Ai2n3i1bb8lmfWV6zgX+qEZnvsVGOeXjgymwCUQBbVQeTCZe2RQnSLjf7wKX1CX7WJ5CZHjR83+/GSyMPUoEax8qsU4loD99Jp2RVVZ6Gf0+BopzturI2uY1tguKw=
Received: from DM5PR19CA0015.namprd19.prod.outlook.com (2603:10b6:3:151::25)
 by MWHPR1201MB0253.namprd12.prod.outlook.com (2603:10b6:301:52::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 13:47:55 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:151:cafe::80) by DM5PR19CA0015.outlook.office365.com
 (2603:10b6:3:151::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 13:47:54 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 13:47:54 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:54 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:53 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Sep 2020 08:47:53 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 29/42] drm/amd/display: [FW Promotion] Release 0.0.32
Date: Thu, 10 Sep 2020 09:47:10 -0400
Message-ID: <20200910134723.27410-30-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910134723.27410-1-aurabindo.pillai@amd.com>
References: <20200910134723.27410-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7f8c711-3dbf-4660-b3ed-08d855901e6b
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0253:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0253C341061B7F54D6A61E328B270@MWHPR1201MB0253.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W3b/ATT/3DNR5u29/ewo+nO29sD/Er3RHmOyH51aw0ywHlWFRWJsm0crzmCKB2uPHn0MkWyYCNmg82LwIuQT5yaTG71heDCpY0SoAbWqRysUFVQxzK7zLdmxzbxKahe5GxW3rVT8wX2ceWtzucfjeF2iVTnD0nqh8Ko423qzacjJubekuAwFnU0jpQt5OS4vKo9vNsfP8yS1iP5065FEAz+jqn1P795euaNxk//Z1LEmUsDVzHigtf11c/lgLL0us0/IGN3wOuOMujS89ps4xxI6KHikQssFbtjc7Griz/wcU7SPX77B+kEqiprKO79mk0lvkb2WGXiU213xvMr8K/4T6lQAjay0jQjmv+xRiR6c0wDQIP9SM9MflkCAWiSUJcMdNVpVMUa/4+S6i+3TTg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(46966005)(6916009)(70206006)(54906003)(83380400001)(70586007)(336012)(86362001)(7696005)(82310400003)(316002)(1076003)(5660300002)(26005)(8676002)(81166007)(6666004)(426003)(82740400003)(44832011)(47076004)(2906002)(4326008)(8936002)(478600001)(2616005)(356005)(36756003)(186003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 13:47:54.5972 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f8c711-3dbf-4660-b3ed-08d855901e6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0253
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

| [Header Changes]
|       - Add debug flag to log line numbers for PSR debug

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 3f84060d79c0..a0bd502dc7d7 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -36,10 +36,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x08aa15e57
+#define DMUB_FW_VERSION_GIT_HASH 0x82f998da6
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 31
+#define DMUB_FW_VERSION_REVISION 32
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
@@ -97,6 +97,7 @@ union dmub_psr_debug_flags {
 	struct {
 		uint32_t visual_confirm : 1;
 		uint32_t use_hw_lock_mgr : 1;
+		uint32_t log_line_nums : 1;
 	} bitfields;
 
 	uint32_t u32All;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
