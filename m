Return-Path: <SRS0=Hy8X=AR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289E9C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 10:00:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF76C2070B
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 10:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GZbHw5lL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF76C2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4BCA6E047;
	Mon,  6 Jul 2020 10:00:15 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F038A6E047
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2020 10:00:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iu3srLZT9nJ6rDBiBdMK66ALh26OElZji01UszJKIbpOLSNRMZuLGeZOA/F8lIE9Ap71rkYNUhL0xMqq6bc/zee1BpJU7aYpwLk6ix7B72LV8uA5UhyGZlyc+0a0ddToPwbNR2HkHBnY2voMjmT6Fluzt0uFuCdlv38pT04fywfzfd2Uma/fKpbMBEgS/9kLGKjlIYfa6KmFEQGUxlngazrqgljSiL2AKltCcNYDlGaSjAC87lYC4tT8/kBIVhMRJ28/gzcFYs1bA/CYfmCi7pjPGw8UcjjPf1WibBQzfT0isu0ITfnFdc+KCe8Pe2jnX1zkFwXXb2BjdoLlqrVrgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmYoj9p83jUZrBZ9PKEIfNFUgYRr9I4M+Ihy1Ko1M3A=;
 b=erfjavyIJWt9cuy0nUoUOz/ETINSfmhL0/bTvs8Ud7oZtqgAS50C/7D1FfNvcjdpq5Cea/3QlgVzmaFNvBftE4+EnEeqO676QRloFNernPcXGhuMNpxF9vw+T9pclZedw8wWXJ1v9oW6s0atSOa3TuD79ekDWuIiTK8osPKY0Vb9l1BzuJqMi8YKiF+UWt1YidfeWyEdJpTLbYCEfXme/CDtjiUqiMQZ/ZM1fU8sk2ZeeZsyg9hN7lj/Gub3W7imWWfx48RreapHa/OX3aE+T3Fzgqvd90mSmUdvw9mcB45ptVhbCg8Wq5bTz9rhZCwV08LZXISdIBsTwGbV1My/1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmYoj9p83jUZrBZ9PKEIfNFUgYRr9I4M+Ihy1Ko1M3A=;
 b=GZbHw5lL5hqgLndg7/+618XbBiAr6Y6pGiUmK/H3Ej6ugDM16MkafD+nXoY2eEknYr+RLcvCbMZQFiQDLFs3b9sdzECCD23djv3OBTgeWX0Y4rimqn9LvEyUbnIhc747iy8xzOL9SQ9psFkF/40m5DcsnMLK8a4N2fPe3ZAtLYc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MWHPR12MB1376.namprd12.prod.outlook.com (2603:10b6:300:13::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Mon, 6 Jul
 2020 10:00:07 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::f518:2921:b1e3:fea2]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::f518:2921:b1e3:fea2%10]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 10:00:07 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: fix coding error of mmhub pg enablement
Date: Mon,  6 Jul 2020 17:59:33 +0800
Message-Id: <20200706095933.2952832-1-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: HK2PR04CA0049.apcprd04.prod.outlook.com
 (2603:1096:202:14::17) To MWHPR12MB1854.namprd12.prod.outlook.com
 (2603:10b6:300:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (58.247.170.242) by
 HK2PR04CA0049.apcprd04.prod.outlook.com (2603:1096:202:14::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.21 via Frontend Transport; Mon, 6 Jul 2020 10:00:05 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e2c1a153-5a74-4d7d-ca9d-08d821935c59
X-MS-TrafficTypeDiagnostic: MWHPR12MB1376:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB13761E43670229902F6FA320EF690@MWHPR12MB1376.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XOEynS8LRM6qIw2KboD0sO8LO+f4lfzB506G8guQHMpwCZGyFkoTr/KM/QutnsUdYjEDZyDjLhuFoXXQHTj1w4D/phdHFhve3UDbR4kfvmDReCjDQniIisc+aZFFlbecTOJiIZR5viRLlp0LmOqcGqyke7jsLPtqAFpgw2HwTaB/k40ziMSSQHKYIbg6jLneRSn+TC84dQzbEEpWkdGjoGRyq+p0bZWluINGvULNYlQUlgmfy+MLO1egzGJ9THT3P2TvBxe7guu8AHyK/iy7hli4xnTjWvFFRV2IHmad1ypnoZIoZuAAPt3DIGbfgJacAde7UBYY7tRs946/Nki4CQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(478600001)(316002)(54906003)(8676002)(86362001)(26005)(6916009)(2616005)(5660300002)(956004)(83380400001)(36756003)(66476007)(2906002)(66556008)(16526019)(6666004)(6486002)(44832011)(66946007)(4326008)(186003)(52116002)(8936002)(7696005)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: iNVykHItPk0uvTruKJQ3xYUZoHs2r787cQokpTRrZz6er8owJccPRw6DfE346nFAH0/+IOfRxM2F2jI/XMhEU2Yv69mEH2C//8jOZ9NjxqM7Vxv2AJDkhNPibhBUvF/m/JeGS0RWqZEGmjLrDzo1dY1vStpHUKhxpF2GU0H/4uOOCsF3qmD09VBx83fxYmUm9OPYBzF3U3btZRCUyvRDEGLwrmdLL+m3cgQ7E3sTXL6Y7Vlu36+QXsXUXTu3DvIhyhKn4aWwodAiXbVQ9OYsOHgGNYbfwKvOV/2oXCh/qYYu38eNzWzXhatjFUil64hamHkNFrSm9s+duXwTbfgDGFQI3wLqSG/1tf/ufjBGwEBTR8NYpdNFeaQr/eVO1jHYVLWBGdDzBKH7tr3bTBEEEffl1WQIkB233hQ3KZEn69ljlYbB6uNyZgRcvgI2Q0SoHF3SYlUcrJvkl29wlfdu2SXIvcuEGZCKJzfA+RpuGswDId1MzVPe7RdM36RhO7hF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c1a153-5a74-4d7d-ca9d-08d821935c59
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 10:00:07.0660 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rA8YTlUGw7GU192vfBWmhyZC51a82LyT//GxTkfKXdqzFgnFIRxKcLtgEbdAjSyd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1376
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
Cc: Likun Gao <Likun.Gao@amd.com>, Kenneth Feng <Kenneth.Feng@amd.com>,
 Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

MMHUB powergating should be disabled on navi12 and enabled on sienna
cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I0b0e6801408df3c13322c4f9ed8e13b6ffc9ec25
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 4b87506cb005..356849136d1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -707,8 +707,7 @@ static int nv_common_early_init(void *handle)
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_JPEG |
-			AMD_PG_SUPPORT_ATHUB |
-			AMD_PG_SUPPORT_MMHUB;
+			AMD_PG_SUPPORT_ATHUB;
 		/* guest vm gets 0xffffffff when reading RCC_DEV0_EPF0_STRAP0,
 		 * as a consequence, the rev_id and external_rev_id are wrong.
 		 * workaround it by hardcoding rev_id to 0 (default value).
@@ -731,7 +730,8 @@ static int nv_common_early_init(void *handle)
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_JPEG |
-			AMD_PG_SUPPORT_ATHUB;
+			AMD_PG_SUPPORT_ATHUB |
+			AMD_PG_SUPPORT_MMHUB;
 		adev->external_rev_id = adev->rev_id + 0x28;
 		break;
 	default:
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
