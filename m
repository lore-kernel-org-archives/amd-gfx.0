Return-Path: <SRS0=NqWJ=3A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019DEC282DD
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Jan 2020 00:41:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88DCF214DB
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Jan 2020 00:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="m6OXdU1s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88DCF214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F3036E1E9;
	Sat, 11 Jan 2020 00:40:50 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B705C6E1E9
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Jan 2020 00:40:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gW3vrUjpLjCgJQm3swyDaPYEHawE+wjSBgLZzzjS2m1p1I7QwwFNRImw55rpS8pXRSIjrQw/o0Of/tqCo7WupwQ5wrw7r1MDiXLIUIBc1MYIeWLJ84qIQrxhGnsr9WpwjFK4KDXYInquOViLid2mvXzIJJRJw3xTMbE1E7XFrYqpzVuZktVty6KAo3u+RFhrmlsxRXzPVoer+Wf0gnBcmkJSN2hudp7y9QkiJDPYtiupZWOWGb0CC0sVN3mu3aaDLiXw0wOU1noCwEkpCBNeqxLfGLteN4JFkkpr290q9mRkyFQM+NnRXV7WGMkwChr0OiIB7JjjXBMhX6ohun0odw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kws4cqX/swBvrXtDA6/CcJ382IOFmJoIFmIO/U7XYFc=;
 b=QOdJ6bU+5p7r0Z61PDxEiJosyPf1eOQvOddqiUW1aZJAW+dtyjH7pCFW9ftgpgCldGA4ppthm7CWhF83m/RBpUMdFta5Rq4HExqoXg6RyLGjW1TAiRdRv7kBY8XaxmgQNZoeoQRI+9yjfebMG0m2ZihOvjjryXBdJkMwEJqWo5rXTXvrODMuA/Y3kCTgdT2wi2AUAxonJXPC1rNiPLsFvmE8HDq5utihGvYZlb1Bt3aJRgwQ5ZyTYdJhRlPE+bBSE+igF5D6AfDbXQiOpisDFwiHfmDZBXzbyEce/aJhSsCsLJco1tl5H+SxNR6lvkOHeJK+tOsNH3Bkyu1/Zizkxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kws4cqX/swBvrXtDA6/CcJ382IOFmJoIFmIO/U7XYFc=;
 b=m6OXdU1sNSWudS6jO9ibXlATStoxkzUGNIJcpEU5iCHKITdPfEdw+AA8NvuLZCbb8iQZx/DDBJ9LCkrd1OcJHlofW9mTpv+tnBfGi2MkL04pU+11v6NF+Hu4PM0mGPZV6RevchMZNio8HkAr81vjUbfcerkTUcCBlpoOgkvNuSg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
Received: from DM5PR1201MB0137.namprd12.prod.outlook.com (10.174.106.18) by
 DM5PR1201MB2473.namprd12.prod.outlook.com (10.172.87.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Sat, 11 Jan 2020 00:40:46 +0000
Received: from DM5PR1201MB0137.namprd12.prod.outlook.com
 ([fe80::b54c:16d9:d613:6877]) by DM5PR1201MB0137.namprd12.prod.outlook.com
 ([fe80::b54c:16d9:d613:6877%9]) with mapi id 15.20.2602.018; Sat, 11 Jan 2020
 00:40:45 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: Fix a compiling warning
Date: Fri, 10 Jan 2020 19:40:32 -0500
Message-Id: <20200111004032.30224-1-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTXPR0101CA0069.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::46) To DM5PR1201MB0137.namprd12.prod.outlook.com
 (2603:10b6:4:54::18)
MIME-Version: 1.0
Received: from yong-dev.amd.com (165.204.55.251) by
 YTXPR0101CA0069.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9 via Frontend
 Transport; Sat, 11 Jan 2020 00:40:45 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0c644c26-6c67-4bbf-36c8-08d7962ee556
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2473:|DM5PR1201MB2473:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2473A8512363676E5A64440BF03B0@DM5PR1201MB2473.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:166;
X-Forefront-PRVS: 0279B3DD0D
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(189003)(199004)(2616005)(52116002)(316002)(478600001)(86362001)(6666004)(26005)(1076003)(8936002)(16526019)(4326008)(7696005)(5660300002)(186003)(956004)(66556008)(66476007)(4744005)(66946007)(81166006)(36756003)(81156014)(8676002)(6916009)(2906002)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB2473;
 H:DM5PR1201MB0137.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a8jXiAXp84Ycs3JFx0sl6lY0vtmh1Pv0uvv9t/zL2crsFp2Gj688K6LwpH2pEfiY5CtLChqlTfFnVZRCGI3WCLyeAMRPSVig3kUpL877MAm//xt9oseNofu97F2pFA/HsSWWjjUEZUjZt8AO5UJFfgL1wng8l8bHT2Ws79KyLsn2mou4mvzNc9ao2vOw8pxIH88X2FyfKs9tHcVqXfNNMzghUzF9CSFIf9HJQ2YiIOpezkFMW5sUySBh/dAI/g90xwAmwuVDdwwtd/eCIe4hmiimfXuUfOW+GrkW7OpPhGHem1DlXaZh6KZ+VqyCaGkE+6qobbqUiGW8JxIIbdaBTxp3NEGpJCVsYJ91qczlOrosjp5CLTPDMlKRJXpmbXQlU9aEq+WGs5/TM/sGD8ww+EBgd17DOWRx8rgeSvJIMLOHbov5AEjGXDiyhcT51YP0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c644c26-6c67-4bbf-36c8-08d7962ee556
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2020 00:40:45.9247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OKZkR3mgt30w3v5gtrk1dtA8owNQJY/GxG2uzQT5S+qsZkZJSfaEC+h1B6WYhFQI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2473
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
Cc: Yong Zhao <Yong.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The warning was introduced in

commit b4267f2e687ff5e0402ab915c9a4d47f9a4eb73e
Author: Yong Zhao <Yong.Zhao@amd.com>
Date:   Fri Dec 13 11:31:48 2019 -0500

    drm/amdkfd: Improve function get_sdma_rlc_reg_offset()

Change-Id: I87da4f1ad8a190327a4a71f0ff78812cb942d6e0
Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
index 2b26925623eb..f9011a07cb90 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
@@ -71,7 +71,7 @@ static uint32_t get_sdma_rlc_reg_offset(struct amdgpu_device *adev,
 				unsigned int engine_id,
 				unsigned int queue_id)
 {
-	uint32_t sdma_engine_reg_base;
+	uint32_t sdma_engine_reg_base = 0;
 	uint32_t sdma_rlc_reg_offset;
 
 	switch (engine_id) {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
