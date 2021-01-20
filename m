Return-Path: <SRS0=ixe6=GX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF46AC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 22:05:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F84C235FF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 22:05:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F84C235FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 243936E457;
	Wed, 20 Jan 2021 22:05:43 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 038066E457
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Jan 2021 22:05:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDuYhSAHOQIKiglR1BRcslDbkCndFvKzNX5fCZ+w68+VxZfzLfUFnBjKTlzrmUtE03gpo3YsE1ZZdglW8W3d11bBfZWwcPO+pW8Ufu5G6oZjWRJBESe44J6SQMyZ3brlASLqCJEzZtgh1EFLNfS4rc77kVEJlnMLZDYDmaKwpu/ISH/VQEE7qQvGI+n2S3WI4M+83Wn3XdKW06NdO3KaLXPFyLqY0RVsrHftEiwFy8GQdbeDzTPyahGPGFJat3pRWT9Ity6qUPmdHFSrtug/EXjC1YL1tvnIDkLlin1sHBDS5LLOaBTgNEFB7VSCTtFvVOLF7DB2XZJX4LF5Ksfs9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czOi4zz3KDqe+dIFohqo3hDySSMRZrx06l2LPqzsZZY=;
 b=nx+UPkobbP2jqGtnACqNMm0djVfKmgDD2iJXgQE1C5J9HyGWeTvax1IB7ORjbwW1uTtwSPH+2fAmPV8vvWgBfTvIx3AyBs1iZQ4kMGuixcKMe8p3vYaN4IzXWFPNlzvX5HOtHX5mW7uT1fwSUENTvA3Ao6rUPNyLdZjPsUdhkWITI3Ssye+bSimvdCgGGD3w1jTe+d/rSbmiqkVTiIo0e5+4h9ULpqf3l71j4JiMgQxDnrElDWT3nNiDJKI+5dsBydAK7Jlk5IVIoZupqkCiEt/JWLRdLtawMdrXlZz2qs+F4PcAZvFm3UEACHrIZnCsGm1Unv8C08UmbZbO/f6A5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czOi4zz3KDqe+dIFohqo3hDySSMRZrx06l2LPqzsZZY=;
 b=rfMC9EjFBjQRWS7whiQmhKDqfFPQ2HRMFgZrPRtLJfA2F3nuwGVdViEmL4vNSoE251RiPWVbLCdrfOkpv35LxIhHUtl9YRtZlu+uT1PsEexsF0eyDeXmGsF+7fHrn9bd4wlsb9mox83CS/je5dJrOrLJtpzW0nw0+6jdtRQ0R3o=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4732.namprd12.prod.outlook.com (2603:10b6:5:32::25) by
 DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9; Wed, 20 Jan 2021 22:05:40 +0000
Received: from DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::4e6:1dd7:b89e:e9d8]) by DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::4e6:1dd7:b89e:e9d8%4]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 22:05:40 +0000
From: Oak Zeng <Oak.Zeng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Use free system memory size for kfd memory
 accounting
Date: Wed, 20 Jan 2021 16:05:32 -0600
Message-Id: <1611180332-4626-1-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTOPR0101CA0043.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::20) To DM6PR12MB4732.namprd12.prod.outlook.com
 (2603:10b6:5:32::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ozeng-develop.amd.com (165.204.55.250) by
 YTOPR0101CA0043.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3784.12 via Frontend
 Transport; Wed, 20 Jan 2021 22:05:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 52789ee4-7998-4f00-eaf7-08d8bd8f863b
X-MS-TrafficTypeDiagnostic: DM6PR12MB2972:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2972AAB1E06E8003D0BE908A80A20@DM6PR12MB2972.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eHoOqmtTf2aGM5aFExsuLr8W/QABWsr/KE6wDpmgRx4fOGYSAbTwbEjV/5zaxjVW/CgXtMGsf+zYXdDJIEn3ruJ+zYjVsHGQyjWOYWdC9VoNGH6kbPnv7asu1zG/B88ERVhjOhmQZ1vvEMelDEk4dJEoymNJEEdQ5/DlnOUkXX8xQ1miqEb46NEBUBXY0Jcd5mTIJiCzPC9F/SRJ5FJHjrpdgWAakwvX0wk70GEPQ0SK2cUnMck1qoITNMIWgbT7ycO0MITRGicaEiPitbUsQUQxoThV6Y+QlpbJN9kknjrnOqTTGzAq+9UEujHj9Of8b4n/gsjyk/mWHo/AAjZncPVLrm/eayOIsXVKZwKgu99ifReTL20LUtrHar6xuuPpduoQhId1+yn6VseRirKZJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4732.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(6666004)(956004)(2906002)(2616005)(4326008)(83380400001)(36756003)(478600001)(15650500001)(86362001)(26005)(5660300002)(66476007)(186003)(8676002)(52116002)(6486002)(7696005)(66946007)(16526019)(316002)(66556008)(8936002)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?7y6XjQeE4w1m87arU+OV/8QDbleQoTYjLaJW6EvZsn73rQdickXP1lRYkUHw?=
 =?us-ascii?Q?cwnazs4w8u8L/1nhJB1iSTaiX+Sgfcp0kHwL3HjPvobhuyCm3ejtDvA4wX7U?=
 =?us-ascii?Q?gYnxZMDgQ4kgFt+vZKXcTNwHJIaOD+j0Saq+xyi4Xou81tAmLaHKwvNWqsUi?=
 =?us-ascii?Q?wIVGebtYjLaEjbBvqlMAbHnXClhG43d+Box3iHUyEbuBbHjs1DU5SNFFKkcO?=
 =?us-ascii?Q?1jRzVSS7CHu+kZD/Z79kWUK7A6kf7zXubUhtEofAgxt+5BWZ/2AXRBiH5Xx9?=
 =?us-ascii?Q?O9Q6tFidvf3lRbYRUh4m7WO9Q1gMD36dnS+H4K2Tn0WbvRO8lkVLHSXzO6uC?=
 =?us-ascii?Q?BwFHXbuwip2xFBShi0c2Ku7u1Hh88xSxN0vC1gblgDTxq0IiiRVkRyYN39Id?=
 =?us-ascii?Q?j1H9hoq4ImHG1I0gu1bS72OFGUIUg7f3jfBkO0Dql4/gfPMzMizsGkgxwt0f?=
 =?us-ascii?Q?sprDrbBgD8TMZ8PPDlpwYLey/H1s9oIVtGEliE5OEXFtdXsXD85clMfdsIjZ?=
 =?us-ascii?Q?MGPZaozX45jRgl1EY2sdc+2fIMt89HEHg8Kv4kRVibRDHGwghperzTNHdxny?=
 =?us-ascii?Q?lqRmZGFqTxoHYXGb45A/w6DKuRhFGVqp/UYpZcacwwXUoy7dA3xXatBWRFj5?=
 =?us-ascii?Q?r8/kt1r9GLGSFVUuYT+JV9G0nNQUt/oqGmVaiP7k7t6LUfecZ6XAkAi4w66f?=
 =?us-ascii?Q?ctFjRRzkj4xTJvjABAzdZ/Oz94o99N7wO98KRLvmAfQbWexUd7sQaB/8szVP?=
 =?us-ascii?Q?1TY3koxztv/bpXX1PTS7q+Ew1/ehhn0CwvrWO6b3Hlsqe0MmBEKX9aaaaKAp?=
 =?us-ascii?Q?5UsUC6VnMeSXMl512xMUb2aro+CYmaory3NGX6V8JWZ3eWH6KVTa3rS8Ei6p?=
 =?us-ascii?Q?XWlMT5W+x648dCn+0kpeCjeJXKIag21FOURdSoMErYRbgQF2PlZtBxrkDZIc?=
 =?us-ascii?Q?+j9rYPnjczawrqhQaQ0QGAT2FfOOgz1iG4x23oJCVbf9EU4rlCkAwGfQQi1c?=
 =?us-ascii?Q?3MvI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52789ee4-7998-4f00-eaf7-08d8bd8f863b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2021 22:05:40.5200 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ftzLJEA5DSK18uqkHAaU3SKMnZXiE1FVvrdW+YXP0CIusKS2lDx503SoQZ0OYUW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2972
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
Cc: Philip.Yang@amd.com, Felix.Kuehling@amd.com, Oak Zeng <Oak.Zeng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

With the current kfd memory accounting scheme, kfd applications
can use up to 15/16 of total system memory. For system which
has small total system memory size it leaves small system memory
for OS. For example, if the system has totally 16GB of system
memory, this scheme leave OS and non-kfd applications only 1GB
of system memory. In many cases, this leads to OOM killer.

This patch changed the KFD system memory accounting scheme.
15/16 of free system memory when kfd driver load. This deduct
the system memory that OS already use.

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
Suggested-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c       | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index b147d75..e059367 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -45,7 +45,7 @@ int amdgpu_amdkfd_init(void)
 	int ret;
 
 	si_meminfo(&si);
-	amdgpu_amdkfd_total_mem_size = si.totalram - si.totalhigh;
+	amdgpu_amdkfd_total_mem_size = si.freeram - si.freehigh;
 	amdgpu_amdkfd_total_mem_size *= si.mem_unit;
 
 #ifdef CONFIG_HSA_AMD
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 58c8739..44d362b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -97,7 +97,7 @@ void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
 	uint64_t mem;
 
 	si_meminfo(&si);
-	mem = si.totalram - si.totalhigh;
+	mem = si.freeram - si.freehigh;
 	mem *= si.mem_unit;
 
 	spin_lock_init(&kfd_mem_limit.mem_limit_lock);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
