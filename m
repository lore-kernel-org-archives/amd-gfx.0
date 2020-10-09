Return-Path: <SRS0=3Gw3=DQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F971C433DF
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2020 09:05:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58FBE21D43
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2020 09:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="McfKfE8G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58FBE21D43
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 958056EC20;
	Fri,  9 Oct 2020 09:05:19 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D20076EC20
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2020 09:05:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNpE44IH3j8FGlSOtfec0Kdo3Xt0mboS44nL0XfvQNscj4hGjBIrMTW6BIqCYpRedZHpYpo3v4hP1gniiBJLWIDp+gkAryybUIYb8Cg3eyvBdJ0YsNOeL7II6rNVglMwMABrbHLqgu7xH0eVLK/WdXi3EIwSEPncKPRWkpsTVJPGXNP6VkC1LlGRwzl8ZJgL3iRYG7wIWX/0OCDnI6W2SzVdPfRX9WVHA/hN1g3WK4ujHW7FT+LcM1FexxJcvEjCzSC5KQgEwcE4zEUz8GQavXRwWc6GbOKPvV+e5a8Zo3AeetnkTSH6iPqEQRIgxZ55iljvKwEOj7fm1LoQtGeuLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIVAMygqNGo/Ua0+pinEModNbWXjw/mGpBGYgRD65Uo=;
 b=hyFiwR93M1M1hnP09VE1+4FaTTemgiaS+iMjxSz+ZtrfCKSf9YQde5qF6fd7NgoDugQFb0d3ejyN51VLLCj0RgY9GLZ77llkjiQf+3CIwd8UoA7i04vgPc9n/YSFCec3ei7NIVL6zeda5kKRltH16jtbJ/ZGvGYSVyvt02Mk/WjFv20uOn3k1WHSh2bsw7fwGnXd4qCVElF9r/ZX8gapeyDmGc36vks1++T56AL12/l2IirojwaN8ADqg96Pt4/0dQFyb1JI7KzkLspWnZH1iAW2l8GatEqDA2vE22/q0TJyZEgFBsKvs3bkC/sbNUVvq77ABhEXrc4JfwjJYm8yIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIVAMygqNGo/Ua0+pinEModNbWXjw/mGpBGYgRD65Uo=;
 b=McfKfE8GJKf34vn4D8A2q+idE3Ong9sIGzZmPZT3TPBh8OgpJvYZ5+N5+UuL3PLqh0+bhbMfUJHOgZxAJmOCOatI4OhIfcbazpHfl2+tD+sKaehcarMz+4D2mFZupgnjJkWEunqtR3JtuxN7AY1id5PKQj2xbNhcACyLj0yD24A=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2938.namprd12.prod.outlook.com (2603:10b6:5:18a::31)
 by DM5PR1201MB0202.namprd12.prod.outlook.com (2603:10b6:4:4d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.26; Fri, 9 Oct
 2020 09:05:16 +0000
Received: from DM6PR12MB2938.namprd12.prod.outlook.com
 ([fe80::3db7:e64:58eb:82f6]) by DM6PR12MB2938.namprd12.prod.outlook.com
 ([fe80::3db7:e64:58eb:82f6%4]) with mapi id 15.20.3455.026; Fri, 9 Oct 2020
 09:05:16 +0000
From: Changfeng <Changfeng.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org,
	christian.koenig@amd.com
Subject: [PATCH] drm/amdgpu: modify kmalloc to kzalloc in
 amdgpu_ctx_init_entity
Date: Fri,  9 Oct 2020 17:04:23 +0800
Message-Id: <20201009090423.1068-1-Changfeng.Zhu@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR02CA0127.apcprd02.prod.outlook.com
 (2603:1096:202:16::11) To DM6PR12MB2938.namprd12.prod.outlook.com
 (2603:10b6:5:18a::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-System-Product-Name.amd.com (58.247.170.242) by
 HK2PR02CA0127.apcprd02.prod.outlook.com (2603:1096:202:16::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.22 via Frontend Transport; Fri, 9 Oct 2020 09:05:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 13b34139-3021-41e9-8ddd-08d86c326ffe
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0202:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0202D5E01D3CEF402309AAA3FD080@DM5PR1201MB0202.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sy5oT3DqhnDIF2y+OUBqLzhIgXsMxmIp5z7rQiL8f2r2nPMLx5+b0AzdJiwYV+Sk19d3hnQ+ylWhAl8ZKb0cT82kQ6rsUIRQoyUt3H1i/yrd07Z4pR7EKbIdgtLFbjL4QEOw4VkcN/ilUlVAriYzS+KIRfMyhqYfSFb1nyGaiJP3TfKkHNqnn+XtzGrQSLWpFQMr4fMLGabJY2Gbyf/UlN6ncTm4lN7uIdPl8PZIyuiP0WAjQKHffXMhdbh1hmiX/6PRHzH2cDtyAQk76R905bDJxI2+nvqUiBgT5PNxf+vMZh4WUT9ho8+df4fUY8RJoR44GkRjomUr6E6JT/i0bg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2938.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(8936002)(6666004)(2906002)(4744005)(83380400001)(1076003)(6486002)(4326008)(7696005)(52116002)(316002)(2616005)(5660300002)(956004)(8676002)(6636002)(26005)(86362001)(186003)(16526019)(478600001)(66556008)(66946007)(36756003)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: l0DtGsLfKURPfwDZU2BrA4+/11VAlVroixYJ6zIw4WRKlrMw6oLweyVpRHFj3nET12cgHkuFQDjH+w0KdpmnLKuP6N0K9jeC5M6RMVMi30WapycjmGX95uQn8GQeY/qaeU7SwGgzniSfBK3MdpWFUdXY4TIm6eTTK54r8qCuSQjfBOv8TcMDZ1cc5VuPfRyimT/s0GSEWiBvcT56h0MdWHiAmLpFPu0pvEHRamOJScsW+LTMOuKyePuyB3y7VK+1AyvdUDp3PuNzPrL/oFy/ptekC5XsyxCUeHEbnYL4Iav2JDxpHiLvpiPO3n2fhQfBCAsDTlF2YXnZtsf/493AWfs7/JFoqrYE5fdeapxyXw1Y2aVXfdeTupfqnFh3GdkCIE1EpqfejehzLtdL6JZfTghm8B1I/OAtCvLqUDoOBciMr+MsQAERw+D0hJVvPWEU05PD32YUA+VmdVp/H33mT2Ne8Qyq3DdEubKBIGstrtFJi5GPx7oBAyNI99XPavC0CeDjeWk5YyzHn0fWmHQ0zcC02S+8J0ZqSQ1nWP4GQm/sxNey/BFmK+m9Kr9Yz5HNoauzN7xZhl0hLZOAWr0vsbmCWSb904zHtrkyges5M3Sljx1X5CxoZAw+fPsKhp4Ue6W5x0ONKKSe0wEYNVUEJA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b34139-3021-41e9-8ddd-08d86c326ffe
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2938.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2020 09:05:16.0480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: isVYeu4Capn5fJD/dqxS0jNjCnaRURKCz4wk7Dqznd4DdkeUUocOPR8LJirbHeAqDIMLJKhvPUkPxgNarzfXSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0202
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
Cc: changzhu <Changfeng.Zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: changzhu <Changfeng.Zhu@amd.com>

From: Changfeng <Changfeng.Zhu@amd.com>

It's better to use kzalloc other than kmalloc to avoid unforeseen
consequences.

Change-Id: I3a73d3f943f4409e6bfbadb0237db3f649d831e9
Signed-off-by: Changfeng <Changfeng.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 5be125f3b92a..a03398c87344 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -100,7 +100,7 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
 	enum drm_sched_priority priority;
 	int r;
 
-	entity = kmalloc(struct_size(entity, fences, amdgpu_sched_jobs),
+	entity = kzalloc(struct_size(entity, fences, amdgpu_sched_jobs),
 			 GFP_KERNEL);
 	if (!entity)
 		return  -ENOMEM;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
