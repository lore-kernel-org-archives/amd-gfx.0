Return-Path: <SRS0=V/Q8=BI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE200C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 08:50:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD1AD2075D
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 08:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="B8BYSip3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD1AD2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BEE06E488;
	Wed, 29 Jul 2020 08:50:18 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770082.outbound.protection.outlook.com [40.107.77.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F03ED6E488
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 08:50:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LU9aGNXxA4LfNvF7pxuQRe4wkp1q6oU2vAO5eZbv/v7aeCjqj3WSUDDU7tCaDfStRWWnXBV44wiFhPN7KlTRD3kKRLhf6K0uZf0SAakXD6UaQ/chrNQiSNZmaG+slJgIeokUHd0g30RL38Og2mHodhf5ZLJKIsGfnRjw7Y0krvd8fgLg0zvf8PnCH3xVeI4mAN4YGmJtAux8j0ae0n507Yhx2+WAcBw5CG4opyOdCI6BEOijXbseeANGMb8Q52xI/W2xYQifuUfq7tHH6m8i6p3X5dpcXum/bfA7if12AWnkrkgfS9fE33f+jFHm5fTGIfjonE4Mgr9H00+ZxDBn0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XEi/9woPYF9V5XNb80lbwGKMCIzyGPdgQm+w1YZnns=;
 b=RRq5RdGhaUU22Blttwkw5QZ9ZDkbBiFhBgEvAB6f8LUfv+AsWAgGgWL1o4GrHh510Ym/lqVaZ5OyNvZ+xGFEjElKcnsRkD8MqsSNIHVVg3PulYUmFU1yJQfkIXC19LfdrwohxKtKGXRKhitKRhC87BL1M7cdPKIZhnh+sU1vDaT6MivNMt+zkUGrZQGyq4i3b47DyTdDTvSJSq0XBn/6AGbiC4GvXq4sGQ3Xr7lG0JrO8Y7otKgUOiBmM7z7EFBOuFy7F/u2aGqxtd6YX2j5J75zfvkBFJ8s0Bof1njRcHJgfiPnncgn/4led3Q+f9o/8ZF2sj2y2fl3wg9RHd3hOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XEi/9woPYF9V5XNb80lbwGKMCIzyGPdgQm+w1YZnns=;
 b=B8BYSip3yf7SCyjulRkpKYuZjrtGXilFAapEHkctlpmWKhnaY0H9ZF1TQvPys1i5L893/P58bQxiUe++NbwhUfljYlRWEeTiRQvyHA3OFzciqrfLFBIE5IcpH3BszBiST3XL2IECDdAlP2eE+k2pstHFLs5R8rVHphULCuinicE=
Received: from DM5PR13CA0027.namprd13.prod.outlook.com (2603:10b6:3:7b::13) by
 MWHPR1201MB0176.namprd12.prod.outlook.com (2603:10b6:301:59::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Wed, 29 Jul
 2020 08:50:15 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:7b:cafe::2a) by DM5PR13CA0027.outlook.office365.com
 (2603:10b6:3:7b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.9 via Frontend
 Transport; Wed, 29 Jul 2020 08:50:15 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3216.10 via Frontend Transport; Wed, 29 Jul 2020 08:50:14 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 29 Jul
 2020 03:50:14 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 29 Jul
 2020 03:50:13 -0500
Received: from chengzhe-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 29 Jul 2020 03:50:11 -0500
From: Liu ChengZhe <ChengZhe.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix PSP autoload twice in FLR
Date: Wed, 29 Jul 2020 16:50:03 +0800
Message-ID: <20200729085003.1133792-1-ChengZhe.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99a7e2d0-1ced-4ccc-f94d-08d8339c694f
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0176:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0176A82F4EAEF57198E7FF8693700@MWHPR1201MB0176.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W+VJcxdE5qo/WL305GgOx9EnP/tH9LfxyGguhDaeHAt+qeJV+XGeDkSaKHEkJr/aHjqXodIUu+pLMOKiucUsxs0ZrMtcQWfD4CRenrGA2Iv4rA6YwsQXaqDeHflU+3i2O/akdBMgrVNh04LTV9e23JpE1cIokSy3sGks3YxeKCdmanezOA0InY+Eil9GhP7Zi8mOCkX3wHRfE5nR+Cx/e+fSuJb856xHfutEsTBF8Lfchxgd+nxhz6QnBaDLeNUErPDVmPyUQGAhDytqOSSrQLfArU+bKTi24JZP1QxN9s/Y8EbFOvmw3f6bFnlNghTp9220txaXUrGJPskr4xIsDN8fjxKOlQhZDNDo5HZS0ntDz9pd/JT2o1Wut490VSHVdjeEJTy4h9bVsCtjRK28cw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(46966005)(86362001)(336012)(316002)(4326008)(6666004)(5660300002)(2906002)(1076003)(2616005)(8936002)(426003)(54906003)(82310400002)(81166007)(478600001)(70206006)(82740400003)(83380400001)(356005)(7696005)(186003)(36756003)(70586007)(26005)(8676002)(6916009)(47076004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 08:50:14.6849 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a7e2d0-1ced-4ccc-f94d-08d8339c694f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0176
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
Cc: Deucher Alexander <Alexander.Deucher@amd.m>, Jack Xiao <Jack.Xiao@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, Kevin Wang <Kevin1.Wang@amd.com>,
 Liu ChengZhe <ChengZhe.Liu@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Assigning false to block->status.hw overwrites PSP's previous
hardware status, which causes the PSP to Resume operation after
hardware init.

Remove this assignment and let the PSP execute Resume operation
when it is told to.

v2: Remove the braces.
v3: Modify the description.

Signed-off-by: Liu ChengZhe <ChengZhe.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 62ecac97fbd2..5d9affa1d35a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2574,6 +2574,9 @@ static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
 		AMD_IP_BLOCK_TYPE_IH,
 	};
 
+	for (i = 0; i < adev->num_ip_blocks; i++)
+		adev->ip_blocks[i].status.hw = false;
+
 	for (i = 0; i < ARRAY_SIZE(ip_order); i++) {
 		int j;
 		struct amdgpu_ip_block *block;
@@ -2581,7 +2584,6 @@ static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
 		for (j = 0; j < adev->num_ip_blocks; j++) {
 			block = &adev->ip_blocks[j];
 
-			block->status.hw = false;
 			if (block->version->type != ip_order[i] ||
 				!block->status.valid)
 				continue;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
