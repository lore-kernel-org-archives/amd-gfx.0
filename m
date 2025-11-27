Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC7F4D111A8
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Nov 2025 23:45:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08AF410E011;
	Thu, 27 Nov 2025 23:45:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XpXKZSup";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013056.outbound.protection.outlook.com
 [40.107.201.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0255010E002
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Nov 2025 23:45:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wyO0OEbFN62chN4Zb84bz3LorjTnDheq8+GDSqTedj7W80w2Z0+GKJ480mfKRJiidN2OJiEt/RBeSkPG9qW75vm2KLB4Wuvmm7exVj0gnNhJoDjcD6SuN/KChD0MUEbTyOOMEw8atOp27NZaVhuGp1ypv1W9jA+ccOP+KNj7fU10GPGWXa3brk4Wbil0YNSrB+fahGj2Ypk7agn0i0WE11sed7++r6K8Ls/1CB8aIT29V/0ljFOsHRqT5+47u90EHDlqo4Y4WDM6VlV34rlYInWAI29e7rtsoZ4esSbTqHRhYA30dyFQN7NvVdRBL2m/LIsbevQO++m5HY80QSxvTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MsING3zECYm2WVrBFCBjsd9a0hjubr2DOf/rdBmZjZY=;
 b=d/IgwucVxfs6k9hw8LmnLQXbQBlRCXNbm/yQ0MU7URuwn11lKHxsVsTMAU7JpoMXwWCrsRrp952MCJvXDiI2ZOGzy05ae7x2tPG/iGC7k7BTJDIRv8tdUv8Nlxx/UxrRWABvtlh9LT5/oBYL4TysG/NoeWrjfJ78szvEh3WOcFuE6cLXeSijC9pFR7QmzNw6G112NPhdubIjQZoQQ7HTlHUHtNCskUdU2DoiGqTKPF4QKyoQuSP0pOHAQ1cxBBlXT3t7pNwEHqJ74ZE7RWK0dSHeSlwPAw4VfgrJR4uvKa8UHWq4YkvFi6P/Gw5ERr5UNDWW/PGEbUwgZ9AcW6tszg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsING3zECYm2WVrBFCBjsd9a0hjubr2DOf/rdBmZjZY=;
 b=XpXKZSupboc5NKiQEu6+wnzgrlU0t3PyYn/3LmW0hn+8hgJZ5ktQ1P1GXjpyxVy1okkpRCB528jqYM47ufDml59xfTNDaRbMVUYvoJvd1G6GTDXUukBLfCxAzLE0oL1jFpie05RCopeNVy1vdLD6FPJWyYhdgkTbk2sVs/xY7yU=
Received: from SA9PR13CA0033.namprd13.prod.outlook.com (2603:10b6:806:22::8)
 by DM4PR12MB5964.namprd12.prod.outlook.com (2603:10b6:8:6b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.14; Thu, 27 Nov 2025 23:45:47 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:22:cafe::9e) by SA9PR13CA0033.outlook.office365.com
 (2603:10b6:806:22::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.9 via Frontend Transport; Thu,
 27 Nov 2025 23:45:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Thu, 27 Nov 2025 23:45:46 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 27 Nov
 2025 17:45:46 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 27 Nov
 2025 15:45:46 -0800
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 27 Nov 2025 15:45:46 -0800
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Aurabindo Pillai <aurabindo.pillai@amd.com>, Alex Hung
 <alex.hung@amd.com>, Roman Li <Roman.Li@amd.com>
Subject: [PATCH 0/1] DC Patches November 27, 2025
Date: Thu, 27 Nov 2025 18:45:41 -0500
Message-ID: <20251127234542.19547-1-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|DM4PR12MB5964:EE_
X-MS-Office365-Filtering-Correlation-Id: 7af6582a-fd11-4f96-9933-08de2e0f1672
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ttow0NHP+Rq7JM3yfi5RZptiIKdb8FfiMyxlzlTFYWuRQNF2pim7mhwKR+nP?=
 =?us-ascii?Q?K6x46RSj3/4oRGow+2/8hM3roS4aTQczrtj8IuIMW7ywvIs9vMIyWjehDs70?=
 =?us-ascii?Q?OPvh61VN9DFDpiPFeWzZlcGnD7vJZkCOCai7c4WlJpK8qaNvh/dayVyZEE1z?=
 =?us-ascii?Q?1ZrY2UVzUYc5anaAmlUV54QSZDaR5WriO0fphXRCUQzYluX6I1PikeZ+9U0e?=
 =?us-ascii?Q?B/ojXKctl1bynd5num7LcvzENkyqbl8TDAhyS1YGu1zEUj7cslqPmoPaEsrs?=
 =?us-ascii?Q?nrLr2s14LpNKLtyx5+s5vG/E0NnYImpxBWyxctyXDVqalqHL7A+gjJ7GYPKG?=
 =?us-ascii?Q?nwCgEBorym69/0B5s/23RCnPxU/yBjtuaPNR7PgaN4qp7sXGL1G5ZdHbNkr4?=
 =?us-ascii?Q?f8spPyOTOpgfgAPEIOlUBWm7lrzMdd5x+7pFQa/xGtT4a6vRz393qRWfc2H8?=
 =?us-ascii?Q?UNUjtKTPYYhp52CNLGwzdBNmRA5XYN9WH+RGyKrnjKMyKzlbVADcEs/kzjQS?=
 =?us-ascii?Q?BAUfRPhy7cYOiHfENK7BEdBOrUs7bCXjSIl52TDEXaydAu1/wSe28DaR8Iiw?=
 =?us-ascii?Q?nyjFES6iR2I6yTlXjf1PY7GZ4yX/q5vIsUja6NI0VZzbDfdEc3NAB5oTrakt?=
 =?us-ascii?Q?XOFeXssxu7kZ29NrG3/BiMHEN8+BvQr1pNPzsX79/XubVt5W3xjXrPYnkZRc?=
 =?us-ascii?Q?jc8tZDIE97XYjMAl6CJNDXfAwBqafMv1KfmNYGhItyYBa2TwMV8GdVDRpXou?=
 =?us-ascii?Q?A7iZgozBNPhdoq2+FDAdyfK+zaxIxENlK69dhedTfyLrnyTVPHjTHYLd8Doq?=
 =?us-ascii?Q?RB/YBN97j2f9Ps62lsfF2a9ICVszEqhL3glGlfiozdt16UEwR/BrHyYAqGik?=
 =?us-ascii?Q?05eY2JliTN2/YVEHiZlaOTHLrhcVTi1AylaKA7xevFibU3zAVcdJZoAt9Duz?=
 =?us-ascii?Q?zLiUTOLPUUoWGjpn9C8FTaoieS3S1Mw2qkcujfKpspBBRsJU4V6TZdZwIdYf?=
 =?us-ascii?Q?qbtWOSWhmev1CG5csdhbB85ByDaTvnn3Zy0MNRSr5Rdv2dc3/OqnkVgAa4J1?=
 =?us-ascii?Q?y//WPeVHgXhygL981AasHpjrXMyuss00IYbKDu4NNDEwVClEEjEJ0vMj7jJU?=
 =?us-ascii?Q?L5c4hTPxGzYgGv3SPHRKpeYm2T8sV7dKKh5nsf9SzfCYNPiV+Nzq/UPVHnZ9?=
 =?us-ascii?Q?JX+55/m33Hg8915zpu6i1UrbUKcEEYTouMy4uYF8z9GI4AH8Z01G0npTzUk/?=
 =?us-ascii?Q?AXRY2SFx3O+nk4Co97XpfY1ILfg+outVVen7aSu04ecNvAXIzwD/CF0W4Zon?=
 =?us-ascii?Q?2+eryOhYTzSMMp9F+7WBJg+OktnUvUTvr6fqqHqJFJyAJ2oTim70SyYb+Cp+?=
 =?us-ascii?Q?If1V29CpsZIqPgmQsgnyr02tHFO0x8IGkY5v9VMV2fQczn6q4tADq1wzBH67?=
 =?us-ascii?Q?GSwnLRATiPutA6deuQVaJ6vy6M/bcHVqAGgSslbL63LDNiqXNqMmjVfiyu/F?=
 =?us-ascii?Q?oEilbiZC6wT9Seu0b1DPXp2+H/il8PvZvCmZaEUj+hISnnHs4fjgnnEBrU37?=
 =?us-ascii?Q?TDGO1BZFCiBcgQJuNJY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 23:45:46.8526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7af6582a-fd11-4f96-9933-08de2e0f1672
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5964
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

From: Roman Li <Roman.Li@amd.com>

This patch was accidentally overwritten by:
"DC Patches October 27, 2025" series

Aditya Gollamudi (1):
  drm/amd/display: fix typo in display_mode_core_structs.h

 .../gpu/drm/amd/display/dc/dml2_0/display_mode_core_structs.h   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.34.1

