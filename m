Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8138DC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 04:01:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 310AD64FC6
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 04:01:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 310AD64FC6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D85556E9B3;
	Wed, 10 Mar 2021 04:01:05 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80E1F6E9B3
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 04:01:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MwU+hugOORIEFwUfl2GrEAyoX4j8l4T0TNo412i5axyLVUsuOJtDjh9YNpuv9MkPLWY+vrjmYXoFPBKpFFMHeo8FSdJbPCe6muUEaUKmlEYsF4gJKXcqjVN0InO0yp7aVitvBZTBrG3/PrAm3rYDS08rKReCRSdaJ9+AU1W9crxuxLC+K21GW7Y5uXOVrjZJPLeW4gtvCUxbvedRMsT16VFmjrjjkcBw3GLZJX6E4hSmdtKrCGllLhZkal/NJyTgC1la/hXKeC7ZX43FgcsTKAYH+01cU7DL3WMpDdomv/nYvvqqNOMjwBljTCi646Ni5rsXZDvG753pz30Ff1/VMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NugXYSOhtfvRV5OZVzp+APm9GFi26vFQoBNT9+OCKfs=;
 b=kBSQbaBcyqTbXBHlaPgnyujjOatgsSNGdpbw7i0zcDdcObDCIPpYbZ7HLv+PQvLTWVi9nQJhEB5UPX/J8AivcxMOv0qXj1vY5NPAYwVdPNamuwqrUUHL81wncIxsGNv+xRXYQwuBFY1sI9HKT2e60Bo6CDg9SM8rK3+vm0jpDTWNzdLq5rJE7LRqiPFZcbNztoc9kNbiuyG4+Qb+l/MlB41THti9uVvBnr2P86SEU2jJwM8/i8EwK5qxMze55HpPlyVfOD+JrqTyumJCEEAZzJKVJDoklPUDDZd2p+1bXdTTMvcrDrVTU4I9mGbnHbTxKODzFRjG1J0RgddQqhxJKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NugXYSOhtfvRV5OZVzp+APm9GFi26vFQoBNT9+OCKfs=;
 b=2gUDScwhdj50S3aQJym9Nqg4zv5sVYNJnym9QcGh89+/f5TYevKaMYwHHdfXWVHicRmoN3a3JXdgtxp/l3H7sIF4S2Alv59uxJuTPEL45vtXcvYqqliMxe77UuLGIo1/3oXk1afgwbfXt1uunx/1fCk48uVgFKlKvZPmxlE7l/k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3856.namprd12.prod.outlook.com (2603:10b6:208:168::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 10 Mar
 2021 04:01:01 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%4]) with mapi id 15.20.3912.030; Wed, 10 Mar 2021
 04:01:01 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix S0ix handling when the CONFIG_AMD_PMC=m
Date: Tue,  9 Mar 2021 23:00:43 -0500
Message-Id: <20210310040043.289471-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
X-Originating-IP: [192.161.79.247]
X-ClientProxiedBy: BL1PR13CA0402.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::17) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.247) by
 BL1PR13CA0402.namprd13.prod.outlook.com (2603:10b6:208:2c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.23 via Frontend
 Transport; Wed, 10 Mar 2021 04:01:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5470907a-7ec7-4127-7d0f-08d8e3791e27
X-MS-TrafficTypeDiagnostic: MN2PR12MB3856:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3856AF310655253275B8EDE9F7919@MN2PR12MB3856.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:747;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wez6gF+drskgoZWstz5g8B3e8EwpSutkyVdv1Q/yvompzpZoTLJcpNCIzSiSPOWXYCPsmTNKWKcv/hr1cf7QwF4J3XEMjABXc5p6edIJjX/27DGtE9WnD9Chfczc7Z/YbhscI2txevNr/fgVweRhXQ8nTQ6kU7G3rqok5QI2uaEY4/31nTshngnYjkBXpX0g7SqLGV3pnDDfTbTbWUIomSqsP9iUmEZHk5IDs1iAfxUY63oGm/H4BgdXepxvGt4TS28D+Kg9Op5Y2t8u5mJvvUFdhFS1D84iYHGkeehS4Ts6vJevuYUd5+IvTqIohHxfs72nGsuxdfMZf1noMf4vFpH5fXza2zhciD/jVMd7eWpENAWUIv2w0KgVt5te352s0tSXEHMkJ/0Zb87p9yBJ8MySZS33vFAXpxi3D1OpdLwnpum9PBX0hre/b6+rUnzj2fHbkgy8pxD1Zl2kd/6EKo4udmZX9urb//4izpR3+NLMbZWT89j6rcS5I6LEyZw/aOyIncN/5HcFX8sr3BWQ6TUm4g3HEUAWe88N7EiwYn/FDMtyGSMfNix8msAEurjY7TbVfG+WpfJXWrAj+z9V9CsJMe+1acGsgvkdEbGke5o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(4744005)(86362001)(4326008)(66556008)(8936002)(1076003)(956004)(2616005)(6486002)(316002)(52116002)(6666004)(36756003)(6512007)(6506007)(478600001)(26005)(66946007)(2906002)(66476007)(16526019)(83380400001)(69590400012)(6916009)(8676002)(5660300002)(186003)(32563001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?byuK3PO9xGGTUSnG6sfflUYTlertkxejvA/v8vaCt+SwW/DS+ORBlDfFwX3u?=
 =?us-ascii?Q?u1KyRNdDaVNZHZzlJ8ByrSFrsZv/gtgEI98Srro0VUi5pcyQE8h9Yy2S5ygO?=
 =?us-ascii?Q?nSwcVhXcnOHPE9yiVvxr44/oOw+zo74fCeU0DIcQexNvko/FDqiW+k4fk6Tq?=
 =?us-ascii?Q?ckIq6JpCaltDQSAGuJ8279Hj1uuVEtVlYO8qnuXcERqOpde6/CKCzTP049E/?=
 =?us-ascii?Q?zeeu69H/WgU78fUWxaL5he4SHs7m6Lkx0jaAzBAk53fje1qqJ1/mfokKLQjU?=
 =?us-ascii?Q?6rP6Vf+FGaddwCSqZYazK2xOqCjdJdyxHqqdBZJ8JbK06hktRhDfV1zBUAsn?=
 =?us-ascii?Q?YqGqSseJl4bx0II9Q0sBlbMz5uRgTWbS0bxSPl18urJmYOoGkfHFrjF60KEs?=
 =?us-ascii?Q?EESM/zwju8ghCPnu+m8RNbIN1Adm0v49eIF3UuHpkkofLQQ33fqcrZq5Q0ud?=
 =?us-ascii?Q?UYHnR/u8JlQCUjgQXBf2U1IkQP7LJMqHHv95a5oDC+lpJUSwcqXhNi7F4QON?=
 =?us-ascii?Q?X9f7VF7PFCMpHt2HT95BPSQXbwAiIeiQfVBMqGGbLh5yiZ7eCqxbZIv7cY1U?=
 =?us-ascii?Q?nV0+ALHXO8LLQaR7ULuOvzdKqzznfItVxU4q9aogm2YLOjE8m38qOEl9keC0?=
 =?us-ascii?Q?rsi3PO9sASeCOzKV6v+k32Cl++qlZQ8iCdHW3qs0DwwYFWjmv/n4QhwEgiQb?=
 =?us-ascii?Q?2GDXzy1rCTjy+wpd2NPKau35W0ZttV4qYsZD5R00avFrSUo32ggG2wtuIHQf?=
 =?us-ascii?Q?u2Fsiy5akzqLrO3TyS47uABI7krd8QINro8OkfrEpJtFkKVBw9Nt8+c51Yvb?=
 =?us-ascii?Q?v5d7rQ/6SQLyqCnmfIVUl5jFwCyaJX0dwcQRuhEztz+LGVp26s+Kkw55Snpo?=
 =?us-ascii?Q?5cvNnIxD0VnSw1JnLa5sKYxQXCaib+o3db1ZWiz53p4ct8jIAMZVvFOronRg?=
 =?us-ascii?Q?GgSlXmSlQBR4IxczOwtY/YdKsVOvOWNBzogm60t6BTPoaD2xeziBvLHHjWf5?=
 =?us-ascii?Q?TDmvnHWZOepAvWbH0MgRU+pD9nw3rdp/R0fGbiqM7eZfgk3nIzUZl9w+2P2T?=
 =?us-ascii?Q?QmvhO7x1nqbOM4JTYNc2NaTSUvIffhqhbvnYrQFEwsRKaOXrk/R7JahjlifM?=
 =?us-ascii?Q?QvDNekewRVgbF+iXaIFHAfbkaNl5LamZTUyxZcEpA4QaIqq0WSlAcFVGhgcK?=
 =?us-ascii?Q?0vAhGSks6q3CgYHAq4AFWab/Ici8x0ueAGOyeGCdNUKQVwfVuPdxWDqHxdnv?=
 =?us-ascii?Q?7fA60Yc7trIelLcg3l9pcCdbI8/enqeSRpfc9q1B1KLXvOsUu7YIswhxrb0E?=
 =?us-ascii?Q?3/N7csZdzoyuZVVkzk9dDqsL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5470907a-7ec7-4127-7d0f-08d8e3791e27
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 04:01:01.1727 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4v3DxhsGg7ZNKea2B8OyNHgJTCF2X7GYx9QYrA4IKKCAju6TtiYpD8PF3f3lp5IlhrOTweeThcO06BSbVRQG9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3856
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Need to check the module variant as well.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 36a741d63ddc..2e9b16fb3fcd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -903,7 +903,7 @@ void amdgpu_acpi_fini(struct amdgpu_device *adev)
  */
 bool amdgpu_acpi_is_s0ix_supported(struct amdgpu_device *adev)
 {
-#if defined(CONFIG_AMD_PMC)
+#if defined(CONFIG_AMD_PMC) || defined(CONFIG_AMD_PMC_MODULE)
 	if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
 		if (adev->flags & AMD_IS_APU)
 			return true;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
