Return-Path: <SRS0=HfWL=CX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9295C433E2
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2020 04:55:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 696B8206B8
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2020 04:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZxqXMgT0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 696B8206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B9406E0C1;
	Mon, 14 Sep 2020 04:55:37 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760051.outbound.protection.outlook.com [40.107.76.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4078D6E0C1
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2020 04:55:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKRQAT/K/8jd5M+Sn0zI1IvWNhpXynYA0u64ENZPVLaGkY+kwnXdnfDhKDF82kSJbNB/AeZTNTg1MDuW9lq2dTr2Gxoeo4n/QFScx+YHa8VAk9pWxm3CbOOr6f6p6UA+gnUkxIL0zHkY4tsp6lFPMgoQ36uScasYDvhNhLdKdVHnxvF6ln+I1iKpdM8fDbBobrB7SKnlZgw4lCVuEiKnGH2f+8xX7BlWThbaH/yRQ1x0bGyhg/NQhMFNtrt3OVdj9jF0ZPY0ihhUC2U+Q0l5DOyfT+aE2a3x1SjQzoJzjZwIGLMAVIx+zP3nYlfjXtGgal/Vhxh4qJ16DQsaoYHliQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxOCeg2fIHpZxGv+eTnp/gJiSgt1hoPJ1ki4PIeCHbE=;
 b=E76pO515pcow0zAddBzfdjvfjtnlxQ+wi6LpszoiMZRAjESNQ53dpUSRb3mjIR/Wh9Arl8tb1y1I37O3WgkdtKR6ItIdwr9/oOGzyY/UNdN2Swl1YsuD3GCuWbllGVB/wECIS+6qzFkgi96E+VIbjdsZGARwJHijz/uvd0TzCvxp+ibMUzGvJvNDHMTRf+yp5hjiHUSykMg1QZXd3fjuIVxfIZfM1YkZfdpYkIVdsBwu4yQTlr8f2Wuvbqxln0wTkWoKcAGVXHEUYiUrj8ahNyC2db3kJrz/Wgp8viQAeIxV1mZcb6jagomgIzj3afr4MC0RP9gJAMwIs7wdEQxf2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxOCeg2fIHpZxGv+eTnp/gJiSgt1hoPJ1ki4PIeCHbE=;
 b=ZxqXMgT0qE+pGVI+ocC6PX7ZIawi/WD2Eyi/C9U+i661HUmW9ump+1QxZFLYOUaSNb+awJkeq0HLYn9q+rFUHql+cyoSUvK8pLdc5ZjJ987zJYYUxIsJSSclVBtkOwG+HgGxaKsNRw5xpY5CSoEr88WqNYEgDCmAe6zt27QFp3I=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3778.namprd12.prod.outlook.com (2603:10b6:a03:1a6::11)
 by BYAPR12MB3464.namprd12.prod.outlook.com (2603:10b6:a03:d9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Mon, 14 Sep
 2020 04:55:33 +0000
Received: from BY5PR12MB3778.namprd12.prod.outlook.com
 ([fe80::8882:7436:2fd0:8dd7]) by BY5PR12MB3778.namprd12.prod.outlook.com
 ([fe80::8882:7436:2fd0:8dd7%6]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 04:55:33 +0000
From: Shirish S <shirish.s@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] amdgpu/gmc_v9: Warn if SDPIF_MMIO_CNTRL_0 is not set
Date: Mon, 14 Sep 2020 10:25:13 +0530
Message-Id: <20200914045513.83649-1-shirish.s@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: MA1PR01CA0100.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:1::16) To BY5PR12MB3778.namprd12.prod.outlook.com
 (2603:10b6:a03:1a6::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from amd-WhiteHaven.amd.com (165.204.156.251) by
 MA1PR01CA0100.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:1::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16 via Frontend Transport; Mon, 14 Sep 2020 04:55:32 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 98790701-f117-4e86-8d72-08d8586a6985
X-MS-TrafficTypeDiagnostic: BYAPR12MB3464:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB34644513C66C2020D5003348F2230@BYAPR12MB3464.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gTC5htt0epKppcfAhEGmRtIaTtkslzjYu5JiodJ/j4wAFIozazJgGpJIiUuS77YIxfN3DqMzoQ/1Crqw62RbSIpTMp9vxZytcW9cK3mepjoDRdV7chL8VamFQw+WLalv/f9WvHP20ItFmR33S5rB29cqGgy1fjYR3Jd0hTbk0NX8tgrpzDubuM6Zzr2W92MaC3WlUzYqIR0xnrpl+2ZQCXsW0XE2iHbHr7ShWSKW3d8hYZhORQ4MVGozJDX3C7N+Iy+0WlIaou/vZltm+mYRShlHNJNAI3ZCd2oqk0Zpg8u0XRVW9VADntfZhw4dA/nJudNHjuI05A4EY2txwZ4Hjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3778.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(86362001)(6636002)(16526019)(37006003)(6862004)(5660300002)(8936002)(4326008)(6666004)(186003)(8676002)(1076003)(36756003)(6486002)(66556008)(66476007)(66946007)(316002)(478600001)(83380400001)(52116002)(2906002)(2616005)(956004)(7696005)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 7seZqoCFzpNYIU/9AgrOGtbc9T/fW8C7g+UGVrFUoJFlQS0IAnhMZ4kl+lvPmJPTDqfvCcBpfdC2tgz/a8g2iENC9d4tkwdqbgnNNvwDlm+9UiPlhPS3cWpjjCobIb4dcd/N/dNlqAioDVYSqmgJPFfEVlNV5nasfv2yVuM2NIBG54YiKYc6kJtMoWudSKzXJ05YnGINEzEYGFur6DM31UJJ5KDnqti3pp8tQ8bGYzEgn6KBUz4TFPU4uiczGwziTmi9nzv+x3QMsNrCeTHGHH/CEf76aaoJwOFJ7Najfq1nuteLuVN6oBd189K/VrdJQ6VPoIlSVMC8Azqq0RxqqcrwB6OigYYgqJHXpSoklNfTGewTqnIwiFzkePiVgBwRCIhI6NxiOHPxZfjX9m18yWNP6FG01VmyV9xG0SVlUlsZIxewe8Ri2Y/lEMPFV6mRq2YLUirTo0azZwAMjVSFPHuU59XDDPJfXhNIY4DkP6B+2S90MKry4zVbEgDSwekbF/5E0PW7kDEAWfAvjyM4bepAP1mF0ylgfHK9uKTkjNht3sLo0FF7kcZQhd6UQxI6LpqQT8j398FdNSWJl7D/AxGMd+CY/nVcUnoqYkklES6VXH8OmUWzae1kBPnC8S0iR9HMbZIHAVYpbhYDtgaSOw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98790701-f117-4e86-8d72-08d8586a6985
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3778.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2020 04:55:33.7660 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0YebS9xT+r7iRlIsQr7ih4zfmjCE/PhsJidmmuay/A8OcKAPKBH/AjrukTOXicW7vN6JWWCw9JtqgDJlb4zo9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3464
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
Cc: amd-gfx@lists.freedesktop.org, Shirish S <shirish.s@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

With IOMMU enabled, if SDPIF_MMIO_CNTRL_0 is not set
appropriately the system hangs without any trace
during S3.

To ease debug and to ensure that the failure, if any,
was caused by a race conditions that disabled write access to
SDPIF_MMIO_CNTRL_0 register, warn the user about it.

Signed-off-by: Shirish S <shirish.s@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index d0645ad3446e..fc2d88dbe828 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1546,8 +1546,11 @@ static void gmc_v9_0_init_golden_registers(struct amdgpu_device *adev)
  */
 void gmc_v9_0_restore_registers(struct amdgpu_device *adev)
 {
-	if (adev->asic_type == CHIP_RAVEN)
+	if (adev->asic_type == CHIP_RAVEN) {
 		WREG32_SOC15(DCE, 0, mmDCHUBBUB_SDPIF_MMIO_CNTRL_0, adev->gmc.sdpif_register);
+		WARN_ON(adev->gmc.sdpif_register !=
+			RREG32_SOC15(DCE, 0, mmDCHUBBUB_SDPIF_MMIO_CNTRL_0);
+	}
 }
 
 /**
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
