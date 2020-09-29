Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2B6C2D0A8
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 02:23:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEE332145D
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 02:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1PlUFN/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE332145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32AF389EEB;
	Tue, 29 Sep 2020 02:23:31 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDD4C89EEB
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 02:23:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOZQL6ScgeFIcWwKlXKytnfF54W2n05bV1i7SCiS+tJ88wdKsJ9ttjCp8yOCqHjMvxcQhYR5Lp3Et2Iynq+GIUD95EV7htzqWeayI5Ar7N18gd8fEw3/zyPM8PQRRB8O8i3K/u0mhSeL5ndfTqoFWUGlhkRxVxmiWI61808cNqcyGdhT8imW3cwcfvZ7nfp0FrymCdJEDvKphsNBP3Hn7Djvc1ZhJKursrXXS1Rfuj0hiqeYGdL4OYmpo/pagc0Eu0ocOgg3zhysAMdpWetN/EDTPowXV7u7hR3SFe8sgb6ZUXLr9Ad2/W0Sf/TEm+ZOxflI3sk/YIFEypjtX1mTEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67HGGYzvwvglfepyhzT1fQeJJHhh8EhgR2W5pr9qsG4=;
 b=bYailolFtzhEskJXdatgVfzD+viHpYKJ2tUTIpUZNTIT/LD91ZPp4Enya8NtcUF6pt8GPqhtuGeBR4IcD9JesDXODT9K7XuyfS82BYWdegCbLtA3Z737pmgY5EaPDrpNgevnvbHYrQOCcATI2ghMqExH3LgBc6UraOB/H0cXooJzN3Tl2GMqHyzsGC0es2qew6f4ttiO2uNl0kxHFlHl+jYeEQMJaUuKazI2WfpmETIjRRTbrIx62PG/qF9jcVFXPfs9Mhx3Wem3iLZFyFONY4VMzc6i1Gr+S5036CkdSSCvJRFSDxVjw4oOAzwMhpeM/kIJbzoRsLwjKz/D/6uJSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67HGGYzvwvglfepyhzT1fQeJJHhh8EhgR2W5pr9qsG4=;
 b=1PlUFN/y6yiDRA92vIhRjAcfjH+DyTgazoVP8hkFKhH3A63QDRzYNxxjPLIWVnpx3s3wUdaj3XPdTrS/DXEXti+uB3M4QuWTeRbwfU7vRyH++sgLa9ALC1CqJ9xEw/+EDsgcsiazSI95dXZgp53fowSoIpGdbCcjja/XJLPWr0Y=
Received: from BN6PR1201CA0001.namprd12.prod.outlook.com
 (2603:10b6:405:4c::11) by BYAPR12MB3094.namprd12.prod.outlook.com
 (2603:10b6:a03:db::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Tue, 29 Sep
 2020 02:23:29 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4c:cafe::29) by BN6PR1201CA0001.outlook.office365.com
 (2603:10b6:405:4c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Tue, 29 Sep 2020 02:23:28 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3412.21 via Frontend Transport; Tue, 29 Sep 2020 02:23:28 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 28 Sep
 2020 21:23:28 -0500
Received: from willgu.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Mon, 28 Sep 2020 21:23:27 -0500
From: Jiawei <Jiawei.Gu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkcl: include linux/vmalloc.h in kcl_mm.h
Date: Tue, 29 Sep 2020 10:23:17 +0800
Message-ID: <20200929022317.10859-1-Jiawei.Gu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de9b5aa0-eff1-49fe-a36d-08d8641ea6ff
X-MS-TrafficTypeDiagnostic: BYAPR12MB3094:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3094D62E162494D40C945244F8320@BYAPR12MB3094.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZjPUwTqkmdSiqiwXfmWwUhJL3sOqNp2pMKeDzHUt4m9ewF2RDlv5c6rOCtdqog5a3Ct6F0BASKJ5hehLM5ETnzKeij8no3rIQaAGGOnrjHD/duW/lhwrJjechHqOFttYOLVm9Wk0dTkdjCo80DXRktA4IJBLTv3IqQdTJYQo7qnfzkOpjVsQqEcxVhwCD2BPZ3Nh9vJSqGg77bOVc7ytrswlVCslEeOqx7PMVoIMCTU/flv9Ku5B5hbYso50AAnHs8jG6kW7sveop3p4RsdJe0Z6Yz9agiRPyv4OJyBxYlw3qHz7Dh+2T6INonsFw7X3goBq5jU+PGuW1jsI3KjKKnvIbWgFxMYlzT7gHLO3cqZ4ZsB4KAeMPvgQhoPQsEGPyi0Pia14dHeQ1Qz23rymbGIB3nw8Dv1DtDmAZKxjvpak15wsk/7Vz1vaAaZ9NhPb
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(39860400002)(376002)(46966005)(54906003)(426003)(2616005)(6666004)(186003)(316002)(47076004)(8936002)(81166007)(5660300002)(82740400003)(478600001)(26005)(4744005)(7696005)(336012)(70586007)(1076003)(70206006)(4326008)(6916009)(8676002)(2906002)(83380400001)(86362001)(356005)(36756003)(82310400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 02:23:28.5473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de9b5aa0-eff1-49fe-a36d-08d8641ea6ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3094
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
Cc: emily.deng@amd.com, Jiawei <Jiawei.Gu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Include linux/vmalloc.h to fix compile failure in 4.9.184 kernel

Signed-off-by: Jiawei <Jiawei.Gu@amd.com>
---
 include/kcl/kcl_mm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/kcl/kcl_mm.h b/include/kcl/kcl_mm.h
index 0afe2f099aa1..dac2f84c9dd3 100644
--- a/include/kcl/kcl_mm.h
+++ b/include/kcl/kcl_mm.h
@@ -8,6 +8,7 @@
 #include <linux/mm.h>
 #include <linux/gfp.h>
 #include <linux/slab.h>
+#include <linux/vmalloc.h>
 #include <kcl/kcl_mm_types.h>
 #include <kcl/kcl_memory.h>
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
