Return-Path: <SRS0=gUFK=E2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85523C63777
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 20:20:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA3B122D0A
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 20:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cwaNIrfL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA3B122D0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 392BD6E920;
	Fri, 20 Nov 2020 20:20:32 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB6096E918
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2020 20:20:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFHhMJe7gI2bLnYzIu1SbDkZqRD6vSVHvvbEATBhHDK3xWEmUSw6NyF8fflHnl/jRa9fuMIZyNlhQx1fPNGwFCbCpu5ldlbWR6gUqaU4WOcYRUsVs9IakfdreLksgxzxTM7AhAyFuRkAyZs4dPclwwH54qL+olm49WZ3LRFc8c4SNiyY26kNL3M+cMzhhlc9levpU0QzgD9FI+ATHviF9Ut7TnMCVhmTrUN7XsPIxQtSfwJFCCS4L0blzy+BU3I3gdm42vAaDwRO383bYswG9jZvh1OsBlMay8Hf56K0xdNEmVJjm0C9foQlkLmlQtw1cUt5CKUR3E5claine+zh7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oH9dTtHIjah7nXuKaf0hDRqbgl2pPuI5LXD55PjZaRA=;
 b=i9NbTqhhzIutj77p5bbZ8P+E3302JI/kyLQ5lYoIIQLIkMJ7J9u7zRZ/yHcu9J9KVOmBwqzVDjrvs5IyBc0Fxxx6/9UFMH0LDYNnEGJZqZhAMBBQSKhyfK0o2gBCyLGZO7oGcsdXy5in9ocu5xcmarnFjZWZVVBj+QmyokX+qVXb3DoY6SWVumTjVTvj8njXgQo11K5vNa+NmMUUqfZ5TRm3Ub86/vnrOnU5lB9t6Ewgs6n7sd8fzy74IcRHuCr0ijVbcUUuvq8MLno6Ryc5Zg7aGiWhgJYl50a+W9yxFtj2A1E1A8UcC1R1cLpo4WC74Pz3/jjkWw9gu2883hunTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oH9dTtHIjah7nXuKaf0hDRqbgl2pPuI5LXD55PjZaRA=;
 b=cwaNIrfL60YFuYG38IGJEt+kYtSwbHNWSOlD57SiSWEI0CWKtbXFpRDse4xi/VjSvKRcNdoPiRez67ckxa6EEpC9KatAcJ9+5oDj16c6NbXW61LtI8XvKI0Dc9mQTXn0d9i9l5ErZMo7b3Xoo11ajzeOelE/Mlk5qtQV/j+mr8s=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3781.namprd12.prod.outlook.com (2603:10b6:610:27::11)
 by CH2PR12MB4261.namprd12.prod.outlook.com (2603:10b6:610:a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.24; Fri, 20 Nov
 2020 20:20:23 +0000
Received: from CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::9d:35d6:ff59:1cfa]) by CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::9d:35d6:ff59:1cfa%4]) with mapi id 15.20.3589.024; Fri, 20 Nov 2020
 20:20:23 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/18] drm/amd/display: Source minimum HBlank support
Date: Fri, 20 Nov 2020 15:19:42 -0500
Message-Id: <20201120201958.2455002-3-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201120201958.2455002-1-Rodrigo.Siqueira@amd.com>
References: <20201120201958.2455002-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60::c908]
X-ClientProxiedBy: CH2PR16CA0025.namprd16.prod.outlook.com
 (2603:10b6:610:50::35) To CH2PR12MB3781.namprd12.prod.outlook.com
 (2603:10b6:610:27::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60::c908) by
 CH2PR16CA0025.namprd16.prod.outlook.com (2603:10b6:610:50::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20 via Frontend Transport; Fri, 20 Nov 2020 20:20:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f19157ee-18a2-4710-0b43-08d88d91b575
X-MS-TrafficTypeDiagnostic: CH2PR12MB4261:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4261031DFEAAFEDB7096BF9498FF0@CH2PR12MB4261.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8WWBU6jIzXBCrvrrNQpaA+SRnJ2Y/f7JiR31rIVDb3tYguumfF1MQsDJXzsmTj4rArfE+x5I1+FU9O59v7+oq26ShF66UNyTSOA0mPvTXOoK7IeYhcwBPh/dGP9pgxfi0JrFaDAucBNTAyH2yytJO7qJqGv97VdEH3s5ReYHFHFIubRzPMHDU6GlCAH8947/Usj3t29uZZZUtrZaaWrk/8WnllKLYdx8+7TbKA8rEti+EaWBA//3UH9yjWXuvp48Ul8e37OEEq9iRuhrosQGRlmkEPnJm+eQzWEiz5Cf8IM9ykhHVR39QFdgH0dtnUGMc9EToT0h1J+v2FZM7vCmrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3781.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(5660300002)(83380400001)(1076003)(6512007)(66476007)(66556008)(186003)(6486002)(66946007)(4326008)(2906002)(16526019)(86362001)(6916009)(316002)(8936002)(36756003)(6506007)(8676002)(54906003)(52116002)(6666004)(478600001)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: MXPFB5L2OYHWbc/h0G7pzDN757N0OF0GM0sr8V9v234lsOS50w6z15Fw+LxsNJ1y3w4urp26kYbcjzIe+v0QfDTIQt+rftlmzf6fbIuIxZZ5W2+jYX2JoADbjM3N/Xwfd3eebyskwnsi9KacRqLQyn+DzI0KqrpSB/kNeWqcHHMjczEfY5lXA60JjlFpTJOii2V3rjSEtC5Rxxg6rhHUjp7GbKNXJI52IeUgjaXhjhrgXm+pSyzZwa3og0zpoF3Ij2ERl0s6/yDjVAQz7GwesRFUxxsC9LnXg3YIofm+7Wr6Uqh4ohPxRNol1Ae18by9f9NFCz9VGi05fyFIxAvseTEcj2Ctx+72bZXugeeKbR++8CorF7tW8NBDd/RBPQDTEEkX6SLekRrlzwhP9IBNgGrJS1rwV17wrU3W0AScT8ZaRAEhvnM8W90d4PuX3oYJEQcLPsg5jSXnOOFjz5jlF+V71WpGkoA9yuK19i3UfegkMFsNTEuNNNia8BcL9RsJZA+GkRoUq4PzfrkXgM1nZNWW+uVMoeMZbFpAbj8cxUkJcuLMGNZk278VEIhQSjNdblrvVLrktMvZ+z1A6pM12WTrKL7X7U1DsMFnjwuuUQ+X6HBh6Y0s1ZAqxSOr5GXvriC/KPA+IvR6k8T60oZOt+j1ROqMxBN4stoows2cLff6QqHjsJd/trpI9VQ5iah5eXvsZO/5Yy0GE7U85vTvVipEbiLg4RbBy2pkcFQzUorjyGfuMHkWARzgmiJTTQGMqf5Xv3tapX8WZMvL+Ez4u7GquXFNGE4HG5iC6t30n6tZRgEH8cyUVOIoCmt2I2OnUsD6+zpdwfNBTuhpvvlgxAVDwRkREyjYh7KhBkXLyxUDsefFZJM+AHs3BnXChD/Jq8Df4CMVMlvmVQVQ/p84RXMbXzQIOm9vWECJMzUqOJMtxRyKdq3V7t057S61XWkE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f19157ee-18a2-4710-0b43-08d88d91b575
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3781.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 20:20:22.8964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xLZG98YCpj2apP5Ap4QRgW6guQxBH8Pkp8/P7RxDj6LXuP6/UQHggDSeOvaF6g+dckrm0IU676MB825PPCfLMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4261
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
Cc: Ashley Thomas <Ashley.Thomas2@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
 Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Wenjing Liu <Wenjing.Liu@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ashley Thomas <Ashley.Thomas2@amd.com>

[Why]
Some sink devices wish to have access to the minimum HBlank supported by
the ASIC.

[How]
Make the ASIC minimum HBlank available in Source Device information
address 0x340.

Signed-off-by: Ashley Thomas <Ashley.Thomas2@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index d15220a4eeb6..be58134a7954 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -1761,6 +1761,7 @@ static bool dcn301_resource_construct(
 	dc->caps.i2c_speed_in_khz = 100;
 	dc->caps.i2c_speed_in_khz_hdcp = 5; /*1.4 w/a enabled by default*/
 	dc->caps.max_cursor_size = 256;
+	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.dmdata_alloc_size = 2048;
 	dc->caps.max_slave_planes = 1;
 	dc->caps.is_apu = true;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index 15ffd8a21e4e..87fe84a06301 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -1308,6 +1308,7 @@ static bool dcn302_resource_construct(
 	dc->caps.i2c_speed_in_khz = 100;
 	dc->caps.i2c_speed_in_khz_hdcp = 5; /*1.4 w/a applied by derfault*/
 	dc->caps.max_cursor_size = 256;
+	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.dmdata_alloc_size = 2048;
 
 	dc->caps.max_slave_planes = 1;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
