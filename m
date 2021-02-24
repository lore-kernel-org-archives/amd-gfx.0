Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7880C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A305264E05
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A305264E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 801ED6EB43;
	Wed, 24 Feb 2021 22:20:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 650296EB40
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:20:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKQreQsLEJcHlgeCNH6zzRZfdniYVtzxLm6o0IKztyQuRq5h3+fTsI7pzB9DhtO3IQVVGvGBZ6dz6PMKIIoJ2UYvO7qEGp401+NkuXm1EKHXv0ngLJGQGui87zZwu+N/9TBT6LIvPVe5/dhHeJXVuqyuhnOwZuJ2+SFog+Nps7rfbg9X/7eXs/1TWXBt9bYOjGza9L7W6lPm5vfr2rZ3Ag7vofLxmTWb5JEii5Oclq4Jb7YvyMQH0aReYXQIfpLdXG4GBpLxnPpdYuypU/6aXqQP0j7wUBpoFTrE9tW9OEB3Ya9/SsLV7ppX4dWzqR6OAm/WHbbAncoi7LEIG7PyLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCBqF8P2W9xwaGAzUVk3uKihxJhCIMbfCCzu1OtPhHQ=;
 b=la8278m0G6ijTaCvcTsqbPaVR8vdikiy242QoENGVE9Dy7hLCTFAWvgv/vS3qaSJgJeL4tXHuFgJhSHsrPK5NluNG/W4P90/itkmFTJHozB9ZokdRyrgSc6aH/p+V/7FTkFyZhAZ2emA054F5DGEefVVPusgYeaIlaT/RGf3Pev49wnBtuhi6lSIgQr6TIlFW6GgztXkCpUP+hOG2NwG+VhmPIAj7vZTms7A0uZmk3ICP2jmir761P08PqNDduqDItEWEgNBF1GglH0/bIHkYqlhD/nFMg2iVdCCv3/O6qMKi4+RCyoGPZPJE8rEBg6ieezWq27YeRpPNlZ0In3wOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCBqF8P2W9xwaGAzUVk3uKihxJhCIMbfCCzu1OtPhHQ=;
 b=B+a6QYcxK4fKPMiJ1jyzZWSRymsRhJ/b0MMG/rJxjZIVJIOdJ0hEXwGgufEj5GK7LLxFXpdXuvZDZsrt4bjmfZmA+yngoXZ45I3x/K/iLTOis34g+x7zaZl+EOHv4IS0skksL4yWhiz71SZ2bLqKO0RYWxHXdacoAw+Y8RIqOsM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:20:20 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:20:20 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 049/159] drm/amdkfd: add new flag for uncached GPU mapping
Date: Wed, 24 Feb 2021 17:17:09 -0500
Message-Id: <20210224221859.3068810-42-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:19:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 11a599b4-a5fb-427c-55aa-08d8d9124f4e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4175E6EEC29014CA403FBF9AF79F9@MN2PR12MB4175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7dZKsEWTckPyfrYqNKhKCo3w27OV6zWfQHqMmeCQ4au5SBL1nYGJIoB/2voYJOPU3zylrQby4B+kp3AvR7/wvmKekJgNekgaoRK0smujoKUSqxRYeG0u4BOEsXBEQjmL3pwXBvPmZqHwyuOaUnMZL+rIyAVPr59travbTmUqnGCzIMxg9D31eAf37GkmOrHxScEvGNAK6G9SjVJwmS7sA0TVmJSuUqu0GKI22DZwd2gsSORW4GJ0/13lCLoVLoHLBT8dWCbRjnA4J4zgSWOQDWuhZSxwayfwnZexeosVGlTin6yWzdTHMz/UBP2XrYbhfrIn8idi0DV/LuHyi/iU6dmCgo34JNPryd5ly01CYC8QNxaeDP+9ZitEVNBdceGi04PiVhW+v6dy3qnJh6Othgk9NaoznvqyiDGPjzTvC/6SboaLv/fGP1XlQJVKq/mDVDbVxaXDrJ4dZAhVPxFrGy3ClOH49MTtTY0Io3r5eOE6zrIdO3DYMdBiEg1oQzhTW3IjTaX/cHh7Ti+inR/y7x1ZS/3iJT6Yagw64BG7tOrVYGpEEmw8E4RTEXjJkzGjd+U716GV6h7K9WYZIXt+Og==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(66946007)(5660300002)(4326008)(6512007)(66476007)(6916009)(26005)(36756003)(66556008)(2616005)(186003)(956004)(16526019)(478600001)(8936002)(6506007)(2906002)(69590400012)(86362001)(1076003)(54906003)(4744005)(6666004)(52116002)(8676002)(6486002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?atDFrDAoFjmqet+L/qcQ4Pc7loNzfMvBrLoiyAyjMCDQIqFgLWXNo4mb4XH1?=
 =?us-ascii?Q?MS7VVc/4tg1R9ZdcBZNIG0qr0Ch8Glhe443j7oFOysP4dsz45yYARlP2TdZN?=
 =?us-ascii?Q?qNzEqdH82oOUwnQYoNu8g0BEmKML8peNoQB+rOKKmcuFWXNwyaxDnaCV0Jfy?=
 =?us-ascii?Q?eGoqwklZ7ls6mjcbPfIO31FxqklAz5LZDXgsZWewR+jPByiR9GQojcztyinB?=
 =?us-ascii?Q?DoOpOUYO0d7yCWniONR/0jCgOXVclI3R3v6zpNy9nCSbzdNxz1Ut5ClFS9fW?=
 =?us-ascii?Q?OeAb6xjbiH63JGXchOna4cPi36q3tbV46jHTw2eF+IWkopjOdAbB7Sga2ng/?=
 =?us-ascii?Q?MPtqU+uPAOQbekhRmU4IH3KRDoSyiYrBoIfQ4in0iErgMuy+x/CB9VVY6zlD?=
 =?us-ascii?Q?aW79gBcj1vZxqU6+/gMebg3jg2ptMNiDeftaq9LXEOEWkl1UxMu0EVJZVtg7?=
 =?us-ascii?Q?wbV2eKF1wF7NrHFl9E/YQCwV2/Y9S937M+Oy6WojR/Wwg1WczS2OGKZBFkMk?=
 =?us-ascii?Q?dITs7SO+oZ21PkfmFyDsvHEvaPjaddjxAojmkexp/XNrhKnpyFQKy+bZK5/G?=
 =?us-ascii?Q?7+FdtMmNuD82HTtZmkATsDPU+wD8RVpFyLVnGRtvF73z7Fl4Dwz+DOZnVpfO?=
 =?us-ascii?Q?g4ao3dATAlFfTOXs+IAL4OpG7Bhznwx7Oh7anQQkJOPk+F6OHWwvCKsm9c3b?=
 =?us-ascii?Q?C3zrcQOJXmmpVypYkTe13V2gKeow/CumF6fm1zgezpcDEhqA9FpL1PSKhO4o?=
 =?us-ascii?Q?57hj/3Q6PMKPEyqiQyJT01JdHQfefEPqxzMErfcro/DNQP97fQjAJJQ5fxOP?=
 =?us-ascii?Q?G7rMCa4qcHS1Yev5W0K4+4OM58fl++eR75Em5HyYx5ON0PIYPGdOdRBrsm5g?=
 =?us-ascii?Q?3jU3AnuE0fXW1BZ5HXeT5sbM+x1p2tZkNIuVXncod11qpum1fNwmIuE5/FzT?=
 =?us-ascii?Q?HCOu2AqJ/aKk0m8sdcw+J9IjTR3vqn3mpGGpy55BVqsFnsnzJWWQMhs3qxDL?=
 =?us-ascii?Q?8HhbQ54qpwtIEZLEzQ0H7aODwc8sjhABHxQqkixfXxGxxjPODCNuGMirpdH0?=
 =?us-ascii?Q?09ALWlEohxloRAyZVeYHYGZgXKy+vHB3MxYo3SaacSNUnprnwAwBKpTdpLbS?=
 =?us-ascii?Q?74Iv6m2PDLFvops8lIJPn8UYd7vppNlGwIPxG3rqbkexOHlzGpCyJ3YLz0X/?=
 =?us-ascii?Q?G8CtC6gz5SzDCqeTHhRBQCJaFEhuWoKdQl4EZBA4B9OsRDDTuiw4Ajn5FJZw?=
 =?us-ascii?Q?3RyHRWq64msKKdygBsStYiSZCIRsi+SpjHUZRMzBSxhfYO1+qrVjm/QheET7?=
 =?us-ascii?Q?a/BFxzZicsqnZ9epDspbKkv6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a599b4-a5fb-427c-55aa-08d8d9124f4e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:53.8059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6TI2L8WmhWqS86EDKLwmBhoumLoxxraoPIkx88+c8GEqxh767ZgPWFVd0DDa/zMIbJ7k3ExA/HcKTImhsDIUYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
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
Cc: Eric Huang <jinhuieric.huang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Oak Zeng <Oak.Zeng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Huang <jinhuieric.huang@amd.com>

The macro is for memory mapped by GPU as uncached.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
Reviewed-by: Oak Zeng <Oak.Zeng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 include/uapi/linux/kfd_ioctl.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 695b606da4b1..18449f746097 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -351,6 +351,7 @@ struct kfd_ioctl_acquire_vm_args {
 #define KFD_IOC_ALLOC_MEM_FLAGS_NO_SUBSTITUTE	(1 << 28)
 #define KFD_IOC_ALLOC_MEM_FLAGS_AQL_QUEUE_MEM	(1 << 27)
 #define KFD_IOC_ALLOC_MEM_FLAGS_COHERENT	(1 << 26)
+#define KFD_IOC_ALLOC_MEM_FLAGS_UNCACHED	(1 << 25)
 
 /* Allocate memory for later SVM (shared virtual memory) mapping.
  *
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
