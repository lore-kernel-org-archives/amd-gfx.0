Return-Path: <SRS0=ZeSq=BX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF9FC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 07:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA57620716
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 07:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VWb29E2k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA57620716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84B486E452;
	Thu, 13 Aug 2020 07:04:25 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680068.outbound.protection.outlook.com [40.107.68.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A20816E452
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 07:04:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SBveTsPVy+sAtX//ZjuQfKy64uHh23GzX+RMc+4yXHpKVdGNQqd4pxNSqpEmotkF6kyYWfu++zy89HJ07GvWUVbyhUk7iLYPBt9NVBYv80YfycRrX/1/dDI8CQCEb7aIGBH8ilv188vdRXNHAe/l6fUxLdqewvdUp4/vx/NVh7XxCR8lVAjSF4Z2FZSip1U+iuAYPwqJW68ahsOhsg/wqB1Pt9GgMnS038yagenpmOkbTszE5RFLZEVONSqPEtWjNhkqHhDdB6WFTo96s3HDzh0bdr75ppszzuxizIuZ/wx5o0mXMFMBLp+Ey02xlLMKwez/g1ZseqZnnO871uVdXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqotXSLqMZr0XvnfgWht3miaWfkadqAKgbYJOHo7NQE=;
 b=Ggzs/Hrcup3OKCZIZdTVvWZCE+bvOEJq1CTfx61jUa/QXH0GNot9BH0BHaU/nNSV7NLzSKxOMCHnQZJcM6X7jZ79XTQMEXdiKTtO1BaxPlhOIh5aZeX1PMeOrNwjFHkbInQrkmWFXjzArXHZz9iES3rtZt+4vVRtsbAbZnzXl4b2S3BFCuulkx+zMJszKS41tygbQG+WBrhPml3qw2rkngYiuFlvaxVgoVTWHMss96VkJ0rD5NNF7X4LjtZ/5Rj2jPqcYpyoahkMGGywtmmD0c2jERyFHUBfzBF0zPyCsef9lMLTfmiYuztN7D1UczDjoeXzyaJHZLi25rzNAA7zzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqotXSLqMZr0XvnfgWht3miaWfkadqAKgbYJOHo7NQE=;
 b=VWb29E2kJot2EDmDKqFKYmdZVE6CltwgCSWtBbRzpKi4Yc23bX2IJcl/P1k0tgzYoBHyme7ncPNhNjL5c3m5US+YEx/PlfPmu/i6/WTDl6bmBEqrzlY2biFroCVKViTJenas7YHQl2NBgCLnE6uccwXOBK1SIOAp8OE1cswbM8E=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0119.namprd12.prod.outlook.com (2603:10b6:910:1e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.20; Thu, 13 Aug
 2020 07:04:18 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e181:b736:5067:12f2]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e181:b736:5067:12f2%9]) with mapi id 15.20.3261.024; Thu, 13 Aug 2020
 07:04:18 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, Dennis.Li@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com, alexander.deucher@amd.com
Subject: [PATCH] drm/amdgpu: guard ras debugfs creation/removal based on
 CONFIG_DEBUG_FS
Date: Thu, 13 Aug 2020 15:03:59 +0800
Message-Id: <20200813070359.31132-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HKAPR03CA0027.apcprd03.prod.outlook.com
 (2603:1096:203:c9::14) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HKAPR03CA0027.apcprd03.prod.outlook.com (2603:1096:203:c9::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.10 via Frontend Transport; Thu, 13 Aug 2020 07:04:15 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3b257f24-172c-4268-38b8-08d83f571871
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0119:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB011926C5C9A9B9E67D6FAB15F1430@CY4PR1201MB0119.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tJUcszwpuSjfISoSdfNT6lkEgfsjrs0q3bkjWP8e8k2Ed6PK/OO1H7tJ4N/NaBSvE45Wfm9biZe05uKR2x2JildYbqDFQW9MLlAKGKbX6m5p1XtbcZEMUWAxRD/xvml8ArOvo7GjwV7yBfbi1iWP796By1ZcnEcsIuZgHI5lfbxPgNFXwxGtMBvY0CjEoXcaha+xrvN30XsU3GX1IZNDXSWpMHNjG2BTKb8Ib4Y/sfZcKw0l7GGZm17Nlygliv5aI1cVwfImuFZ5on+Zts7O3S5Gao08uszotzXr9W8jxu184cc7nSoFy6eBtgZYhsOIXMj5gMnEj79XALfZ21n50Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(366004)(136003)(39860400002)(346002)(7696005)(956004)(2616005)(2906002)(66556008)(478600001)(52116002)(66476007)(66946007)(6666004)(6486002)(1076003)(44832011)(4326008)(26005)(6636002)(16526019)(186003)(36756003)(5660300002)(316002)(8936002)(86362001)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: /pLchZXSvk1nW+Pkj4rr8Pzsv5NysA0K58j9ZvR4/ETMTRoKLbORkiSqx6V7UANWbQJ8BbazBYyyVmvjngD2d2w1Uouk7LmzRgB1lqW56Jbt9g7XDLvKwK7JGD4ZVc+gEkGFpM+DKreO/nIUpEAStsS7r3ZavCy5mXxzzksm8MdIL+ufPOi/WCJtERQvbMgtT46s/f7u/Yhhu90ch4nJhcxjY1KUYTsHuKv5RHl/vaMCUVp2cRxeII2H+iXHDGZjBKTjntmurOB+I/2LiMfG7113GKA73QhiPWNB08LdlpciXNN+ammuRlmyzNxoeVwKv5TaVbIOwDJMZT3IUTOF8rhyDLPSv2L2xESVoD12grUT86ban5ZrgzgzwUBMQkxOEGMzV0Van3ruo77cdzwlr5QvNVnEayiTlH6WlPRh7EgoqQPtysCGN1Vxso7UkMhMHx5noGr49uFORuFL1pFeTlwyr6XdaVxFDeC7RjLobpaBIPXl0X0YM0+N3hdXZKOrP3d3gT2ZG0j15HPAQHQ08VahmmLtN1Iw19kOBQjqGMCMjmlbBLsGRyMh7fnRZyxp8Tck4BVoIRFrV9yQCkMgqrYLUj8jg2wGy7oN19HN53zfYLSd3qAoU/POfrSh8qEa+0cbjEejGZz8OpR+RA7UMA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b257f24-172c-4268-38b8-08d83f571871
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 07:04:18.0881 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LPbb/ZMEEBCaCy3PdILCn6iJBIJ26l8fVN2AYFPsWx6usBmJ+FfKQB8tIppZqLM6+CMDShGJuEvuCXOA9TRvug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0119
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It can avoid potential build warn/error when
CONFIG_DEBUG_FS is not set.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 35d5bf9e6f6f..e1d78cb448e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1244,6 +1244,7 @@ void amdgpu_ras_debugfs_create(struct amdgpu_device *adev,
 
 void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev)
 {
+#if defined(CONFIG_DEBUG_FS)
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_manager *obj;
 	struct ras_fs_if fs_info;
@@ -1266,6 +1267,7 @@ void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev)
 			amdgpu_ras_debugfs_create(adev, &fs_info);
 		}
 	}
+#endif
 }
 
 void amdgpu_ras_debugfs_remove(struct amdgpu_device *adev,
@@ -1282,6 +1284,7 @@ void amdgpu_ras_debugfs_remove(struct amdgpu_device *adev,
 
 static void amdgpu_ras_debugfs_remove_all(struct amdgpu_device *adev)
 {
+#if defined(CONFIG_DEBUG_FS)
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_manager *obj, *tmp;
 
@@ -1290,6 +1293,7 @@ static void amdgpu_ras_debugfs_remove_all(struct amdgpu_device *adev)
 	}
 
 	con->dir = NULL;
+#endif
 }
 /* debugfs end */
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
