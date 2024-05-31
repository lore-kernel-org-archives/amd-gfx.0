Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 948C0C25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 07:35:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0441610E56F;
	Fri, 31 May 2024 07:35:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GCVe5Ehb";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C64310E56F
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 07:35:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F12eL+YduC4pzhqdFL8WzdPDbQiILhPr0WE3gBWMpKTdl5yde9MLsyFyh3snoi95qkbEay8WCLSdanLxENnHzow95cOMBL+WqxLpopsRw9cNvIkxS8E1CjDiNGj5gAMJlfyI+ZQQclTT0LjPopt3WrtXfO1N3ysJm4ptI99kmClnB7K2I0X8DWcvrrAXnw9mcVFSjrT9eXvzynl6MSkXp49s1jdN5oeMZ7JiVngldOUpuLVZSns42LR/wbPxQ+RrHZfnOhYkLIRLXZC38InnX8aok55rD4swe3rw88v+4c8C0ryk23wX0cu0fMwAGRTFfbpylVCrBvv2FfmWjHjbXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2y+0vSGndRl6g5kd55gwNKwi4V/dguHDmjzVe2TkkY=;
 b=JDTF56eIwGOxZ+S6kKj890YQKa+v8O5nkmf9/YWzN/ArU6RLOuLkCXVI2xk5WPGI4cEPNSsfj0t0VJlfaoi5QP+rp7vMlUpNY1I82hV8v5TAIMuSBLs8zu3vXucGCypU6SPu/ZUckQA+achAXQpIIvx48A4d07ZmjDk0R0RPloybgdQ/Zuf5vxfVsiv34r2ulGGs+QbhiabhcMsfgdFnq8IhUVWLP+zbjLS2OqzTVJI9y0GC+6PrBSrUY+rYgOlMC/bhIwJ2ul/C8El7I09HooTPUlotP1kNJZYRBieaJ9Xuvl55sD3HSAiWaPv8gz5NTQOgasgOuQj/HLFctn+XLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2y+0vSGndRl6g5kd55gwNKwi4V/dguHDmjzVe2TkkY=;
 b=GCVe5EhbuuqhjKAZyC2tlkacSrW9yjRgRo2ZFT8a0oAkssTmKlIS9Ko/0j3BCNXH++2YSa1dNe1yMcAj3O7L8QBzobd2TgJDQE1y1LdTm6UYLFYlXaau7Bbb9rOfiCuude+JfeRhwW7/ioP4Lf2AkKBkpI3Ax/5A7n/waes0S7k=
Received: from SN7PR04CA0176.namprd04.prod.outlook.com (2603:10b6:806:125::31)
 by SA1PR12MB6703.namprd12.prod.outlook.com (2603:10b6:806:253::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 31 May
 2024 07:35:34 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:806:125:cafe::76) by SN7PR04CA0176.outlook.office365.com
 (2603:10b6:806:125::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25 via Frontend
 Transport; Fri, 31 May 2024 07:35:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 07:35:34 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 02:35:34 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 02:35:33 -0500
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 31 May 2024 02:35:32 -0500
From: Bob Zhou <bob.zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Tim.Huang@amd.com>, <jesse.zhang@amd.com>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>, Bob Zhou
 <bob.zhou@amd.com>
Subject: [PATCH] drm/amd/pm: add missing error handling in function
 smu_v13_0_6_allocate_dpm_context
Date: Fri, 31 May 2024 15:35:31 +0800
Message-ID: <20240531073531.20364-1-bob.zhou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|SA1PR12MB6703:EE_
X-MS-Office365-Filtering-Correlation-Id: 84812db2-71a2-4ae5-6976-08dc81444210
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Dsd2YXjerr8bDwofzMQX8Zrc2eEkGXHOk3OwVswZEDtuV8muemqNZ+mpmDnr?=
 =?us-ascii?Q?Cg+0HJ259Uql4PVE34fNc5o1i6SYqEY5ucrH7UidHUg1g2XTxvC5Uz0mP+pa?=
 =?us-ascii?Q?S2VYBMBHVfxQQh7nv8PZxDfCvLZPZgtCLig4NnVoeZhfGpdsHwUdk4ChKyvF?=
 =?us-ascii?Q?OIZL/UVUwniorFDNKZRAPqFaxHIz27jSb/Roudi8y4/zyUvJlEV1wj4KiilG?=
 =?us-ascii?Q?6ZwNkjOBBg64R2kGi5yOMsgcPUZDK/YVCcBtYHwtikcJ0q8Iy1EAH9+HiaB4?=
 =?us-ascii?Q?zJSAdJQb7CAR0zEuDACRktBZRe9DuUpfV/MgLwZmA9neX9omPm5JE3T30USa?=
 =?us-ascii?Q?soZQaUChKn1i2UE2UfQR58qmIxBkR8cN7QmexjbFwNBk0ROTQEsVy43M3zD4?=
 =?us-ascii?Q?zhheeibT+WDbFUEPhTtUCGN6yFLe7RSaFoGTqUvGyPwc6NMnh8HfINmDKIpM?=
 =?us-ascii?Q?RlT7JcheHfiFlMcxPrBpWfP2gyQrfZduE0j6V12N05KBJpFknYiWEv+SY4Xi?=
 =?us-ascii?Q?TM7ih250HcGACNr0huU7U25GmppxnP+KKXBTj9boD35eLv5IQp1hmGxu9m/5?=
 =?us-ascii?Q?j+YhcLHCnnyGY7wL8jvbN2wLdjVfdDOKy6NCySeLA6+b+oxC0b3QbjKcLdgj?=
 =?us-ascii?Q?Suzn2ieieCsHC5TD1WryC/wraAKItr/0SBDDuv9XDqxIxhZ9wAvFVmVSCqss?=
 =?us-ascii?Q?K2HAZuOYvdklCQjsATAnCioFhdb3sLiw75AZflHi18mN78yr9Xq1J7FM5x3t?=
 =?us-ascii?Q?6kXUYPjaFzBK/8uD/aHFZL82O+Ebo6U7Y3yGhJZQGBkOOLm9Hlfh6gtkfNZE?=
 =?us-ascii?Q?7kCHIkeSNYhq86VnIG0cn9Io/fWegIltm8ahJMkNsWCCtupbmPChEyESKrBI?=
 =?us-ascii?Q?kCdmoFKbZg5oqB2I4TziZ4aAl2gM/p1KEy3ZGt2sW6+gZ2ByuOu1SE+iAiSg?=
 =?us-ascii?Q?fl2qMGc8TIuqFvv1Z15lLCqBChoGDrhQjD4GG+lTEVeFBl2inE66G+12hsPj?=
 =?us-ascii?Q?U8ma9PxtPqJJG9L3z4lQaV5huYOMBmeySfOp02r6Jb2c2cu9RWFfajpkN1uy?=
 =?us-ascii?Q?5HYL8jZj8oz7CwjANq5yX5kOp6oAHU2BnyLcwqPFPqxz5R41Fwqf7++57fFv?=
 =?us-ascii?Q?c0E0329kQkWlgSolgYJ+ly9bhA68f6frsb0xRzJhWiH4ILF32Y7Y0AYZeKpy?=
 =?us-ascii?Q?gOn0fD+2IqntAJ8XF8lg4UBXqLY15PAjLWhowP0raPIHyVx2tR+QXkpF5D4v?=
 =?us-ascii?Q?GmgHPdOXIup5n6ohqic9ZHrlcVJxEYbmDjN8Db7RaWgD7FJ1wumlfYOGoEwo?=
 =?us-ascii?Q?mVt4pQGqQIEJHZsgMAYZdktwX+4cJGWGFtyxulkKJ33lE2RP7ru1VFjJQJcM?=
 =?us-ascii?Q?wREpxsKAcUWs0FJ9Ltnzm/kdeza1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 07:35:34.5273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84812db2-71a2-4ae5-6976-08dc81444210
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6703
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Check return value to avoid null pointer dereference.

Signed-off-by: Bob Zhou <bob.zhou@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 15c0aa0ad443..419e46cfa065 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -451,6 +451,9 @@ static int smu_v13_0_6_allocate_dpm_context(struct smu_context *smu)
 
 	smu_dpm->dpm_policies =
 		kzalloc(sizeof(struct smu_dpm_policy_ctxt), GFP_KERNEL);
+	if (!smu_dpm->dpm_policies)
+		return -ENOMEM;
+
 	if (!(smu->adev->flags & AMD_IS_APU)) {
 		policy = &(smu_dpm->dpm_policies->policies[0]);
 
-- 
2.34.1

