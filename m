Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0858C28B2F
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Mar 2025 20:45:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 722C010E68A;
	Tue, 11 Mar 2025 20:45:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R0uifo7f";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 657F910E071
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 20:45:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TAn/vnv8pE93btUoJxH1bwo6B9SWEOU+9JhaouNnjcuYLNCqXKfeF6LYIJ6xnvpg+DpA2LwYxJpTM3xF4DMuOCGI2kEgHK5E0GzdIOOzuRH/zufgVggEqUUA5V27wVTJ2AySL0hlKc9vITxVk4YLDsf7nEQDsq+/Znlw/MtBEH+hBzcMHZh+UYoy2mb4imGSfpjtMZ6TyuHCkXTCmPyJeEx7H55AVKgGnmv5nL5NTTY9T90ESMxfAFYK5UhY9FO1xV5cJRP9aY3UZxGwZTJ1n8zT33ulhyVr37KOzSTvrAFXX9CARyD7Xo2Ney68qaM98fufMgDSttWEFLLyPvVK5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3+XvU2twGPlltEE9mpwu3pa2fn3WFrStxv2L3HU9Xg=;
 b=GOHIv29TIdYOBFYdOQQxOCyrNRAVA3kGvkOpa1dcyXal4F4ZzuQQ/Cl04AiWmFNH6vePsVriSQOpnVrDhwbnk7BozfiOej2r5311i7S0C0LPX/oCpDWKXT1IfXosYjIxypWbx/CiXowKzULCi4/fKUH00LXDfvKKwFUxB4TMl468q2QEDOtFFrCF/kJDlLRFwAqogZGSZfstoCvi8gQ4QaslHyJUwEbvUP/DhOouIcK6qeIbVKHV0cPdub6ZKAqzWh7/zxPFLF/WPhZntSQB39a/IOMU4fNhhW0HQU9emLwTV4St4l67uxi2cR9ScWBunuUOcJxWQDGZyMXzZp9zug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3+XvU2twGPlltEE9mpwu3pa2fn3WFrStxv2L3HU9Xg=;
 b=R0uifo7fzH4TWJNspaFHOM981EuuJpbicc/uloSY/L8Dmnv5+IFjE9m+2wiEfD3gDHRwTtDezI1qBnmZyWZmBTDv7dbd7xe8CKTsY9oT9yhCNLGfh2aobjUerwYAihDmqqfYhywJI0frWUhu2qo6yRaejUez6b9vDQJRubX1eEM=
Received: from SN6PR2101CA0009.namprd21.prod.outlook.com
 (2603:10b6:805:106::19) by SA0PR12MB7461.namprd12.prod.outlook.com
 (2603:10b6:806:24b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 20:45:14 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:805:106:cafe::4e) by SN6PR2101CA0009.outlook.office365.com
 (2603:10b6:805:106::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.3 via Frontend Transport; Tue,
 11 Mar 2025 20:45:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 20:45:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 15:45:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5/6] drm/amdgpu/pm: enable vcn busy sysfs for GC 12.x
Date: Tue, 11 Mar 2025 16:44:58 -0400
Message-ID: <20250311204459.23864-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311204459.23864-1-alexander.deucher@amd.com>
References: <20250311204459.23864-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|SA0PR12MB7461:EE_
X-MS-Office365-Filtering-Correlation-Id: d4cda313-451c-4bae-c778-08dd60dda03c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jJrUSE53dACqqGw9MDrzbKcQN4ufn+EgiGxKsyaHXAvTUJI82ht4O6i2BCYe?=
 =?us-ascii?Q?0kE51oXG2+OjRVS13IXZF2INsEqeH4P58cCZC6poilHr3haybDc41t6RZ+VR?=
 =?us-ascii?Q?Stz2oRN1jQejtu98puYM9hFdWnBNV2roHf9OGbU2v5cnO6sJZQL7ElDF8AsW?=
 =?us-ascii?Q?UNG+fdOzOctlNUCYuSSj9u4H8NwnuQwexm+CYp2jAOLg8hEkIwBAM1LJhb+P?=
 =?us-ascii?Q?+l1YHSUOxsigqWOTyN16O2BXky+5sk8djVJ06q51rki1V1Jz2aOg/VUkbnaM?=
 =?us-ascii?Q?ll6fIdZwBPg17yXAJSMjiKDGmPytLPgCrTMLR1JltU+9L9lfD2jvrqZKyWQD?=
 =?us-ascii?Q?xQPGAI8fgDbV1vheXxBg7JRMrPS2AB9uWxq7megv6Z2Z7UMMVVWJs0iu+rPO?=
 =?us-ascii?Q?aABEesn4rfbpmdfAxZflnPrVtso1hTPWxklPrqJlnsy2M4KzzzInrQfNCQKa?=
 =?us-ascii?Q?P76pBk98bKaXvieqNl9cDQUZC3af0AwuYXPhtUnnbTj1WKo79Bp9jb/YJxJC?=
 =?us-ascii?Q?rZYVAkBf44pYLDD1sQTVjD0/eOG5s9au1CaZeHWUQ5N8xGL+iIAY8z1nVZQu?=
 =?us-ascii?Q?aQidJG8Qe2JtXX96SNHcYqGxkOwUFvYFLV8M7VaoxIvAcxKR+KpXia8HLwvG?=
 =?us-ascii?Q?Vec+hdgv0Iq9tHVxLN2pKpYawXga7rq3Y1dFV93Q6HppW/XKgPGcSVIeNiRz?=
 =?us-ascii?Q?W1zYQwfoT3JWuTzc/aPnEIFy4v/sRAXVVvEd4o4B+LfFG6HI509SEsw9r0kD?=
 =?us-ascii?Q?Drj6nYWJ0ngw54GsRmZVS3GC7QZBYSEvAa+SMocA+v7KgnZATOvD6ALlElaJ?=
 =?us-ascii?Q?DkMl4OyZFJbhE0cT/VpwHD7HBIeUy3eKgP7gzqkYL6XyyXfdVi8u5QY0d/F/?=
 =?us-ascii?Q?qZzT3JUYRXeNtkwzv6RRxE2U8TC5VwxWGdhsjVNHsZcP65/BpoV9wGQhipQ5?=
 =?us-ascii?Q?Xe54hgwPARToeNw+dLN2B2jikY14YSAt1ZuK4bk1x44/5yLkhUDZQ5YJluMZ?=
 =?us-ascii?Q?EqtyyyUpqEhSYziDDaE3CrqXqXRq+WjDMjLND6YfYCehCadW+DRTWe0cHI5l?=
 =?us-ascii?Q?y3eBOkwjeTWd8e8Ddiadi4Y2u45UJV2KJDcPe+WlzJqH42pA7kqlufqK+2LE?=
 =?us-ascii?Q?bJGcdMFdv+iMD9a2D8k/nCRfaNtJFyznFSElnQc29WiuFObfkMHkqG/ctLoj?=
 =?us-ascii?Q?e0/N31qU4qyzBEQ27JX0g28P3f29wMfuOaJv1V2cVyaCPGcA2Cn/teeaE/8q?=
 =?us-ascii?Q?hiIwBtB7p/50qfTmaeAN/ubqdwW3S+339b8BioCRkFfBh/ZW5Vwn/Y0VJZqE?=
 =?us-ascii?Q?tT5JAhfVDrYtx70qA64oLWEYXEjp2RHHC1qhk8buIHD2+gYttwRyVISFmpSx?=
 =?us-ascii?Q?NzYwKJTdJIO07G8WB97Lf2aXZZcnncqCbsQ5Stfh5yetU+GYRWD60uL8oLTr?=
 =?us-ascii?Q?1+M3FDNVf/5jx+kzgBPzQmcdxq45Kvii/eyp6c8tEZOT8QE/LdijGQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 20:45:14.8073 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4cda313-451c-4bae-c778-08dd60dda03c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7461
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

Make it visible for the all GC 12.x chips that support it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index bb39e7f83341b..c5abf4eacbfcd 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2326,7 +2326,9 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		      gc_ver == IP_VERSION(11, 5, 0) ||
 		      gc_ver == IP_VERSION(11, 5, 1) ||
 		      gc_ver == IP_VERSION(11, 5, 2) ||
-		      gc_ver == IP_VERSION(11, 5, 3)))
+		      gc_ver == IP_VERSION(11, 5, 3) ||
+		      gc_ver == IP_VERSION(12, 0, 0) ||
+		      gc_ver == IP_VERSION(12, 0, 1)))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pcie_bw)) {
 		/* PCIe Perf counters won't work on APU nodes */
-- 
2.48.1

