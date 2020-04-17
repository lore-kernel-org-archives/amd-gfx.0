Return-Path: <SRS0=Q5HU=6B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFDAC2BA2B
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 02:59:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19B9821D94
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 02:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dOh+xsoz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19B9821D94
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1FBB6E0EB;
	Fri, 17 Apr 2020 02:59:18 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EE426E0EB
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2020 02:59:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6uM40Xkf3FXEJW/GxBlMWF1fLm2agmenfWd6A8jGIvQ7PwXCcjQf2/HLMZVeOBreWnj2dWKOMkeexwbOUAoe68Qu8dO3b7eOH1VkIcqe7pC9UA+R09DjwMCEt7q+a0kTy3MIy4i256SXNiP+Oqc/yHgPmHhkuXBux06JwvA+CfYJQi04sgceYTJu3V1SHRrgqL0Ex+SYpAak+XOZu8KoMKMhcsrpLOmeUSeSkIFDbAjnUIXqTGpWmaV4nDFVQUwIMWTx1qHuKDWKKEhhcu8ooviH+Pwd/Eb7EfAN6GhHIYX5FvL6ZmDF6ubYMrtIHyVAIe+3d84GRzsdAVW/GiBWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iS5d92X6nMPqhXvhBZVq9NUEKnSMiJNZfBAEztCX9C8=;
 b=aO/gk1WViHyh3glQ2uDdrlg5rM0JkLW91zbqrk537vk7UuvXE+SEQbk6u+zNpfEpB2pc7gSLiH4ozBDCc8k6LqyoE90MWuZTf9bvLLXMRRsaSIXoKEEx+aspMmdbNvYXlXH8UBq97CsrdAawZqCJL8Wf7HlhEQIJLWDsmSJNAshu5p/sZEAgYOSSB/elcEua+7420ipgvNXWKlbHKi6bs8e/RgIiBXu6bkeTIXD9s4JnWJhsHbc9CspXTcgAieDo5dT7VQq4zYJ3uSfQpHjOEr7oM8FdnyKaE4OfJRVigd9wgmZNdKTeuL2IjhEXZR2uX+NL+yQQS+ZHwte+WTeCVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iS5d92X6nMPqhXvhBZVq9NUEKnSMiJNZfBAEztCX9C8=;
 b=dOh+xsozNAyHtVLmy75iE8yD/MB2lCP01+/ZFTm2c3pElik7klrIk0R9KaFSlTV1RkZ2huaDJ5knFqid5PsU72mtURMyCXlx4awZAKz7ibUSa9GTpZnSlEakBKgRMM7YTVjGH+JxsHeGWNpRXcZEtziktqRVlvg3o7bPOO+wfuI=
Received: from DM6PR06CA0023.namprd06.prod.outlook.com (2603:10b6:5:120::36)
 by SA0PR12MB4414.namprd12.prod.outlook.com (2603:10b6:806:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.17; Fri, 17 Apr
 2020 02:59:14 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::55) by DM6PR06CA0023.outlook.office365.com
 (2603:10b6:5:120::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27 via Frontend
 Transport; Fri, 17 Apr 2020 02:59:14 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2921.25 via Frontend Transport; Fri, 17 Apr 2020 02:59:13 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Apr
 2020 21:59:12 -0500
Received: from jenkins.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 16 Apr 2020 21:59:11 -0500
From: Yuxian Dai <Yuxian.Dai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/powerplay:avoid to show invalid DPM table info
Date: Fri, 17 Apr 2020 10:58:59 +0800
Message-ID: <20200417025859.17577-1-Yuxian.Dai@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(346002)(396003)(136003)(39860400002)(428003)(46966005)(47076004)(316002)(26005)(86362001)(2616005)(81156014)(426003)(1076003)(4744005)(70586007)(6916009)(186003)(81166007)(36756003)(356005)(82740400003)(8676002)(336012)(7696005)(4326008)(8936002)(5660300002)(70206006)(2906002)(478600001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5b21826-9939-4036-fc78-08d7e27b4f48
X-MS-TrafficTypeDiagnostic: SA0PR12MB4414:
X-Microsoft-Antispam-PRVS: <SA0PR12MB44141F757F41C01AF1CF5F1C8DD90@SA0PR12MB4414.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-Forefront-PRVS: 0376ECF4DD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 34KBuG009XYe6FjhKotnlvucsUYHcTG++eMQ4KDXrnQzCI2m/7YsJwYKCfhFTPAYks4arqXAxZBZnB09h5LJgr5ZaKPJdq0hcKH1H5ztQtMEa1zixnvRMmMxutr+j2VOnW1vLr1WM3KY88hmJdaZZZ/xk35kZggBb210OzwHrzfQH+6hiHXPhNkG2DRMkkDmVugnZul0vwErkIic+mqPBC9vFWwDvL1SRuTc+ceLghs4Il7MQjZX8nBclUEsrb6KkNFphdaEGC6B+ZRtvk+4M/lwHhL6Un+T72aOtGDOqwMULLMt/OzyiPG4BBXjkSCKmV9czk6cMFcGgHpy/IYtxvi3MYU0dA9B8r4zQjsPzWSPI26PrYJKv7GtgcnjApqa1JW3VHt1rsAckp/JQFK9TPJEVBI5ikBe0kajqbKxJ/3ZR5yNmgCBYLAuX21VpfRRi6lfopyr6cOM7WaW4xutj0jrGYy+/lvpkpioE4YSFCuCFpZF62Zwbg/BHNr1X06u2Nr1nE39CF1B+Pkl/QOTfw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 02:59:13.3883 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b21826-9939-4036-fc78-08d7e27b4f48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4414
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
Cc: Yuxian Dai <Yuxian.Dai@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

for different ASIC support different the number of DPM levels,
we should avoid to show the invalid level value.
v1 -> v2:
	follow the suggestion,clarifiy the description for this
change
Signed-off-by: Yuxian Dai <Yuxian.Dai@amd.com>
Change-Id: I579ef417ddc8acb4a6cf15c60094743a72d9b050
---
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 281b7b6cf1a4..e4e7a352d032 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -296,6 +296,8 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 
 	for (i = 0; i < count; i++) {
 		GET_DPM_CUR_FREQ(clk_table, clk_type, i, value);
+		if (!value)
+			continue;
 		size += sprintf(buf + size, "%d: %uMhz %s\n", i, value,
 				cur_value == value ? "*" : "");
 		if (cur_value == value)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
