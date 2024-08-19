Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 214F2C52D7C
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Aug 2024 15:14:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7F0D10E2BC;
	Mon, 19 Aug 2024 15:14:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x/Gkuj4J";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9D8E10E2BB
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Aug 2024 15:14:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vE8GX89MkozTUVTnl3TG1x7dKuzW4ZECrdxDAnEKbrI0SA74QvCAcBY92D7hJpAReVhviilyui73Bv/RD4cgx8Zrmu4bGEKw5kQLwJXkbrLEIIGY4VbR9JDLcWxc1UWyLGev7qTJUXi2f8qbUDJtKlIEAt7lglsdQZeKNlpmyiyc8Lw4Oxigs+EAYtkU5JQk17cpdctlAOwGKVkV3AUUMVGjDAXyCU1Bx9izvMAWMzzjd1xw+kXXaguGpbcb1SxMNPuAj3i+W+IGJF1SIVXKtuc/sW7X6IfCozCmSDf67W/MH2zMSwVeSUCCWOIvSDiKjUXoLFCxIVHlnXORMbWxtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HnNCvvyu4lU89Nxqc7iQnM7oo1bSFRD6yT0kUw+Y6m8=;
 b=qGTxKB3z+tkkcYjK02T/NuKbRj1Lx3e6aUkCtYB19oMrCfiKVJVqyGnZ23yhV4E0d5dmdkoWR9dUw4kxUfQKk+76/D6achm50s9OAlAign7oUdAjf1FHfgIb36LJ7KSm8fEN5oTr1qrEKBO8D9kcxEnJuzunLCWhkqtE+jEtz1kyxxMBI2V06r0FeLWlLgbVjskJnxLs7+mJ/Xd9dloHKycTjr+Hsd2txZr2ZjAewu238+DFgjaYWgavM1tdoVhmF1bR375Sg2YAO+Lr6jihmnImjWWZuZnh9QGQK+79yEcrHN5fIISlQOBZYFVwmAFQpI0I5YQdhEVTY4LNVT3+Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnNCvvyu4lU89Nxqc7iQnM7oo1bSFRD6yT0kUw+Y6m8=;
 b=x/Gkuj4JyTWcZjTR8YC5k652Ts5R7j7YXGgyrNThwvSrRErYSnR3KbH74o80upmYJ/tN0CHQRHIk2Jb5PGHPPLrkQqA2QpfB0C3K44h4ra+rBNCP+hgZKYbqwrwz3+l9Ng15PhOPWfHQDkRa3MnUc9CZ9sv8V8FENQLnU+qIdOU=
Received: from MW4PR04CA0261.namprd04.prod.outlook.com (2603:10b6:303:88::26)
 by CH3PR12MB8235.namprd12.prod.outlook.com (2603:10b6:610:120::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 15:14:48 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:303:88:cafe::ee) by MW4PR04CA0261.outlook.office365.com
 (2603:10b6:303:88::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Mon, 19 Aug 2024 15:14:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Mon, 19 Aug 2024 15:14:47 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 Aug
 2024 10:14:46 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 Aug
 2024 10:14:46 -0500
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 10:14:44
 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <Tao.Zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Shikang Fan <shikang.fan@amd.com>
Subject: [PATCH 1/3] drm/amdkfd: Check int source id for utcl2 poison event
Date: Mon, 19 Aug 2024 23:14:35 +0800
Message-ID: <20240819151437.13808-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|CH3PR12MB8235:EE_
X-MS-Office365-Filtering-Correlation-Id: 557d3215-81e5-44ce-98a4-08dcc061aa41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?U0Y6MgMJWn7JmBgNWEvpyK5L54Pwd8MSLLFEMWZgNCzkaOF+0VE/NSXFvjPj?=
 =?us-ascii?Q?mSEMlbw43GbjHCaylw0ghUSVkyEy9UDg4UIv/JWSrBFeFIlHE0hUER+B0C+q?=
 =?us-ascii?Q?0K4v66Ufiu5wGMDZiFnhvKxBWRm6HGuCfxXuQ9RyRbop4JH2dNPo25P/Lc/B?=
 =?us-ascii?Q?mo2eC+NSp7L4ExOkmSFt8I07QN9YcpoheAkzCcPBYAi+IqXkZZZJC+nvunb0?=
 =?us-ascii?Q?h52is6l/h1aZOh5u+3urrAxQM46Tp+7yE8bnSdhgZiC4zyEKuaokshLw7eu6?=
 =?us-ascii?Q?Hz8X5SxQavnIKtsT3GqKjlHPsHBKpFqw0aFbvEWPCnZ4EH7U40xSOticN6e4?=
 =?us-ascii?Q?tWC+4TiLUOI0ilxYluLlyDT4xB8N2jaq5CTJYOA+JcewPT+GTX01JDwOK3GX?=
 =?us-ascii?Q?eLQZVWKrtyUE3Q5FCWN8bMi2FS+Sn/LWeZRroW06QVpHSwjtO79FDUTW3Suq?=
 =?us-ascii?Q?W9jID6ZA/yAeFszsDwTywJCdPWIf43+yjXKmrgBaCQHCUfbvystVEgUDcv65?=
 =?us-ascii?Q?pzDbSHfFDDHIpYrN5QM+OUL6WnI1oCFAoaI5QiwB80RjE5cHofb9aN7s1aXo?=
 =?us-ascii?Q?evxhxNqPCO4Xm7bG6OsXhjRtp+efYwhaJXymjvdU8XcxDm3/7EZH65E0e2v5?=
 =?us-ascii?Q?JBoDMZIRoV7m9SJFSpQEtTmTDI2W0YIK5Dh8rYpI0o1DZRA1G12acloo9AmQ?=
 =?us-ascii?Q?FP2DJyF1cA0M+/eNsPofVD8db0GtTfqUBp6qVrjhvDQ0q2827Z8CLNYc2lQz?=
 =?us-ascii?Q?9p2rHsELDL+WSH4pIN+VAzhGHQD1MzqVwRE1HoeQJtKMDHA3SvmuRbE9hwyx?=
 =?us-ascii?Q?s2o6Tv+G37g50O7npNMwssgdLkLVIqj1EdfXvizLabRRFPKCDS/v9G3eOe5m?=
 =?us-ascii?Q?6a2zrH34kqzMxlB/shnNrztj2fzYeT4xScK0zx71bM9f+BshlEIkSrtW2V7l?=
 =?us-ascii?Q?E4T/EzyDFdEQ/aQ8+LBme9s9hU9koS60oJLrFjkKgQCvFkmCQ8zN+7GuHFiU?=
 =?us-ascii?Q?aYoDzW659gw+NBr4OhcjF9Js8ph6he5sBLNFC3CVssP5Rd3A4y+TiON/76jh?=
 =?us-ascii?Q?KTwTt+bXqwSfusvFEaMPQLEgEhOPdHfA11/sqdSr8dGvp7Sd5DtpV5715MbD?=
 =?us-ascii?Q?CLqZLYHlLyzQHmRZhT1tEJFVDEtvBZCRzL+jVBtyDHaCR9jiEn7EbtdsFjC9?=
 =?us-ascii?Q?3VyEpvQCeIYvlNZzUVCjz4YjjvKkGgl969EW3PCMuRwO7tQoTO+BSG+s0jn7?=
 =?us-ascii?Q?kijD2YmlcgpM8KJ1VP9egTsJOuBOUI9jSwX29+pm0vjEjZVSXkF/o81DPp2h?=
 =?us-ascii?Q?oIdXuExL4C018OEtsEHcVP1hvoVPZVDUNuJgJ7joceqMWVqDAwR/6fBui3hF?=
 =?us-ascii?Q?qLpafVmPBVVnHw4w9VXWe6b+Gy2OakLzmHGIWaTJIWa7OarLtQDXAMuJaL3B?=
 =?us-ascii?Q?jEryB0fbVo2G8CmyArqTlV6I1REG8S0K?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 15:14:47.9147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 557d3215-81e5-44ce-98a4-08dcc061aa41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8235
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

Traditional utcl2 fault_status polling does not
work in SRIOV environment. The polling of fault
status register from guest side will be dropped
by hardware.

Driver should switch to check utcl2 interrupt
source id to identify utcl2 poison event. It is
set to 1 when poisoned data interrupts are
signaled.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 3 +--
 drivers/gpu/drm/amd/amdkfd/soc15_int.h          | 1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index a9c3580be8c9..1196dccbe6bc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -448,8 +448,7 @@ static void event_interrupt_wq_v9(struct kfd_node *dev,
 		if (vmid_type && client_id == SOC15_IH_CLIENTID_VMC)
 			hub_inst = node_id / 4;
 
-		if (amdgpu_amdkfd_ras_query_utcl2_poison_status(dev->adev,
-					hub_inst, vmid_type)) {
+		if (source_id == SOC15_INTSRC_VMC_UTCL2_POISON) {
 			event_interrupt_poison_consumption_v9(dev, pasid, client_id);
 			return;
 		}
diff --git a/drivers/gpu/drm/amd/amdkfd/soc15_int.h b/drivers/gpu/drm/amd/amdkfd/soc15_int.h
index 10138676f27f..e5c0205f2618 100644
--- a/drivers/gpu/drm/amd/amdkfd/soc15_int.h
+++ b/drivers/gpu/drm/amd/amdkfd/soc15_int.h
@@ -29,6 +29,7 @@
 #define SOC15_INTSRC_CP_BAD_OPCODE	183
 #define SOC15_INTSRC_SQ_INTERRUPT_MSG	239
 #define SOC15_INTSRC_VMC_FAULT		0
+#define SOC15_INTSRC_VMC_UTCL2_POISON	1
 #define SOC15_INTSRC_SDMA_TRAP		224
 #define SOC15_INTSRC_SDMA_ECC		220
 #define SOC21_INTSRC_SDMA_TRAP		49
-- 
2.17.1

