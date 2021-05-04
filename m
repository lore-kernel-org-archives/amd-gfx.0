Return-Path: <SRS0=AKuh=J7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6148C433B4
	for <amd-gfx@archiver.kernel.org>; Tue,  4 May 2021 21:48:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 475F8613C1
	for <amd-gfx@archiver.kernel.org>; Tue,  4 May 2021 21:48:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 475F8613C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECD496EB94;
	Tue,  4 May 2021 21:48:23 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C54556EB76
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 May 2021 21:48:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bt3gDzlFLFVElMyRBaDDHEM36LY0gGWZSX8DuTlXxnIoutJcLklWVX7iX7mVLXNra7SwlPT9N33ux9uejf8M1AMT01LNatfp1r4WafuYHhYhBZ4hQND0u2Ln1mPBqqld8w/GHwdxWwZMWPsMlj5wx8944+qjHsVClFK0Q6lL5/wiiojKS3c+1WVP45SlsMV3tzPXPdXTwLOYD1W8SxNMkCdZBjhFHsl10U7G3lr7lwOiDYuzhlSsgU4fx95GaRkOPfzB0joVOL34AGoS8E7urNb6VKpHi+sIDpedxMGnX+oUTb05BWSD3960O3sA7q8IHoYYinnrORxlnvxN8VbebA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZIQr2fFQPfEXf5zlc77vs6qe1y8P6QIaY0L3qDxd3k=;
 b=WfjkhifssaCg4S9g068rShyE8OW/aKYXHpl1CDhBuhbBHuYBlajKG4TvgmXmtMzkXAeeefTUlH3l4BbgEEqpHpagRgMrDIN7VGCKWphZ2U06rF+sMyuH3CmacvWNOTpEFDczBIoZYkOxpXPSfcPhP67DLWrgC4AKSq01BizmWILpPeJrEuqmHIbKI1/YF6jp15QcJYlzuOP/fpP1pRedaqlkZMxZ/rYeiqsYtxHoTG66Pk1bxIxSa8orrD7x+tKmh0JohGwd5UC3+0jQZAyRVLJ6uRsokywWepmfnZQqv8XEqIdyDsgcC3AIXeJOIGkyVRcCp6gsjy44H2P4gqcpQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZIQr2fFQPfEXf5zlc77vs6qe1y8P6QIaY0L3qDxd3k=;
 b=N7styMCVM5nGYGR6vr9Yjez9DunAQZeyjswcPnFeOGJ2B1APaZHTfx64hXDv8r6CeaQnyXF1kVK1GgYWAxhvdCzTQFEoXgqz754qy+CTgEw7BtfpQ2n/PZon6s5c+XQCOVeVIseTy7s6ecaqFpTw5tiHq4b6mquehhacVSUxuug=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.41; Tue, 4 May
 2021 21:48:20 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4108.024; Tue, 4 May 2021
 21:48:20 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 0/4] Normalize redundant variables
Date: Tue,  4 May 2021 17:47:52 -0400
Message-Id: <20210504214756.3816-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.31.0.97.g1424303384
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YT1PR01CA0091.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::30) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YT1PR01CA0091.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.38 via Frontend Transport; Tue, 4 May 2021 21:48:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46bdf89b-3200-4bca-9c50-08d90f46550b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4155:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4155FBA9DB95CBD72BB5EC7A995A9@DM6PR12MB4155.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eze1r6e1eNqza0+Ir2Ht6YIyZyIj8LkVFce4DEdUhFO1SIULcs5XPCpDwGHbLUelh99sn06reBoRARUL+v6PfJKJvyXOQnaXR2X35MYkHHgr5wgblpsAIh36xvuNhxs+/Kv5VNj4SC0F/ITwAbcwk/EA1MA1kTOrRwBJhJ1Znf+dp3UtlSjNnMTbQDB/l7oZtP4EZ+Z7aABaT5MWt19FzQKI9gZSV2g/+Xx7E07e3itfv2fkHG67RrXvJFfaCW3XiGTcUY5P1B1PveDvV9E7+xuXUFH7FTAhut62bgJs+bRXdbR32/i3NFDe3qZddOlzGM4jGlKDbRpprUtQnMIbIOGt60A8mXLL5J9uxKHrzZQupJcvgJzH3tCjNcCR0IIqgubIa1Ar7TyUiyo1Z91kVlv4S3NbjLmjQzMkaeU8CBgpRg+KfIE3QRMDELIFrkZOz1kBHznvKNk7Fub+bpZ/QqmOBuIhs45gWNBmzsVaxsgmqglBZs9sCp6qnPc7wgwGdySVgYeiTouwOnsfsX3K6YJagl81ZrJTJfrLDI0QNoQkLudpYkKyun5Br1wXERSjVOWWDRj/3+9wf6kjiFaqzZ8DRSAYY6oYIDgIaXFjD6Ysq5icmOi6p4BuZSc+aPyTyCe7g6bkIhs4wmMGVUCG8GEnJRBH9ZpmRjTBODiYANjWvh9YH9efsa1ffeIUMFT5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(478600001)(83380400001)(66476007)(6486002)(2906002)(186003)(2616005)(6666004)(44832011)(5660300002)(36756003)(4326008)(16526019)(316002)(26005)(55236004)(6506007)(66946007)(52116002)(86362001)(8676002)(8936002)(956004)(6512007)(38100700002)(54906003)(66556008)(6916009)(38350700002)(1076003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?OkbcENcsyErhg/5IzHanuYM8+ZQBNb2byfo6Es1A2w3zt6OZ87StY49sIM8W?=
 =?us-ascii?Q?N+5Y/ORXAM4YHx/8jN0/PKuwP4xBhgZZHGHQYUjH61b+0QyhHOzc3gqiMg6U?=
 =?us-ascii?Q?zs/tRUk9fpTzM5tEpvXoDqtDO7YRzzudZJIT4s/Uv6zx2q7kP1EJU5cj4fhN?=
 =?us-ascii?Q?O8GoE5kJT7/cBBFVyMyXrJt50Y7oeSFWHW/3+SgloYOqfAsYMCspJVPSQ8O6?=
 =?us-ascii?Q?chFfHPsXPtUPQX+VA11UbnfhfppTZ0HnpiqLy5q+JYMfGM5fzHQo8WSoBUyG?=
 =?us-ascii?Q?1KFcnWJ0q9mYtgErsGzrRvHxbKAJh9QvE4gYteShzTz5dBgzmCzdjIFUYnxx?=
 =?us-ascii?Q?yvtweKdELdFevCpCwvQvxkJWcW533L+4jWyCyC/QJtF6k3KUffNfZH8whral?=
 =?us-ascii?Q?OOyA3TESOW9XPeRTW4oRKp0g8JLvjiOfogCEyw3FQymFLm/DxmN9Sd3yOzKd?=
 =?us-ascii?Q?T8vFy1qMpZd0l4pdthSNtDuh8A53MN1r3SM/Uu/s4KqCy2OnsRm+ogxmBwzC?=
 =?us-ascii?Q?gMRv46XUZVC+B8lSNIZ5oS/y/4vd8bT4fp6nCyQfHbkmFhB/v15MFHC7ZBIX?=
 =?us-ascii?Q?8bLMDTzhfzSTtBTbVi5rEobbHFdFaq94IBVDKHv7MYQuYZuJBRJFuTPSbJBn?=
 =?us-ascii?Q?00rKGEic8F5n9w746rJhG4TpSzdotbHNGnrYyTecoQtT3NfEuBCNjkWSqnLn?=
 =?us-ascii?Q?dSDVlv6FKL6N3xvgg6eS9I472nOTy1T0GoghoJGOb1VZ/kn8G8NvNmDYD17W?=
 =?us-ascii?Q?u7CFy09VRM3zeh8JLPCfMLmlduvKBYy+HpFOXwihi8/BppZ0WtSJG8AuORiR?=
 =?us-ascii?Q?yUKJGJg5UztbHiyXS8CYX6ioiMigfyzl5x6SQzbhABU2xeezIQQ/UGs4gc0C?=
 =?us-ascii?Q?PaNNpgYyKhylqRIbTpzvxksSaJsYqLbtj74Cw0Dd9Hc70e/rI0w+GRkTRady?=
 =?us-ascii?Q?urDNCtb4VFpc0VvyES/pW1LwPMILcAGwo4IVCXyzcU0pF+Pyd3dkGkwz+2Zw?=
 =?us-ascii?Q?KD7A7GAdKeHPr1B9/1dpVPUPD0K2lGXJusuY6bOg5FvcsyFZPwZrn0vnfqZ1?=
 =?us-ascii?Q?0Roz1RR8cGbSWjq89oNU6bb+yjuWUP5AKF/mzfO0UGmf0Pso2dZRI3IDaDgB?=
 =?us-ascii?Q?RZyYuQXUhAMOKwBQ2Ll4GpITJAuH133GPhHjB8YMunz7bnS4Brd/TADtIalJ?=
 =?us-ascii?Q?R1LhbnoZJIaitvaj1bIU72A1S0YSYwiaUpzmkP/y/ihoCpAHC24CmHcmL155?=
 =?us-ascii?Q?pdUx4I09YPyHChrnFVa/eGDnCkjOoH6CZL47o425lWs1TOVS0YntqQ44VJ9J?=
 =?us-ascii?Q?t8Qc4P4A/suHUjgE/TsCo0N4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46bdf89b-3200-4bca-9c50-08d90f46550b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 21:48:20.0256 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r40xgUIdVJu8Em81ZJxsnRwFTR1IaroKy53mRWyLb7vqX/iuhZuoABgfpmxPUeQs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, John Clements <john.clements@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Classic normalization of a redundant variable.
There is no need to have two variables representing
the same quantity. Move up to the structure which
represents the object which determines their values.
Rename to a consistent name, and export to debugfs
for debugging.

Luben Tuikov (4):
  drm/amdgpu: Remove redundant ras->supported
  drm/amdgpu: Move up ras_hw_supported
  drm/amdgpu: Rename to ras_*_enabled
  drm/amdgpu: Export ras_*_enabled to debugfs

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 91 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  5 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c            |  7 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |  6 +-
 .../drm/amd/pm/powerplay/hwmgr/vega20_baco.c  |  2 +-
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  3 +-
 11 files changed, 63 insertions(+), 66 deletions(-)

Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: John Clements <john.clements@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>

-- 
2.31.0.97.g1424303384

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
