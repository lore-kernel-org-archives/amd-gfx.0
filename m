Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C650BC3ABAC
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 15:48:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F238010E2FB;
	Wed, 30 Apr 2025 15:48:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ydnHwfij";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED37C10E00F
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 15:48:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=knXMqFz0xOcB029VZPA/hQTbWn/vkTX2NOWlVTHKHBemu3gsl/vQsHFDZNyDQ2iQe7Ty5oa07aEHcID595LHb0AabGwbJRjwa4nr4WhPo8766oh4lbJ+Mn333RPUtzh6hR/pzbWASv4/rDNSltsisa+M2/PMME1g1+2l4ra1IUkKBX/hvWd23Rna+4ywJzQj7HkONraHhaVM8a0YCAmc+i43tWwdyGefy5qT+UlQrZgQhdM7Rm6Y8UpDUfhQdTnSjLQ7SljnIHmLmaUI1fuDHAnDlNLf7R1Cm+iLX9zAJm1VQFw2sr8wi0c6+B61VZNWV2LCQBk3Fqbq4NCiwzyBvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kOeJSiP6984PKlHZbGtRv3U0e7QMxqA0OwDQE88crQ=;
 b=dZRqLkuYzPQpLcRtrSBOxBsJsv8XhSKzscsVfPr+7XhhRNqYv2P93M4ChLADL4QD5CnpEkvRwQM5hdsrj3jkTI2WWd4Vz42aVIoR7MIp4t6NhWyHTAnvk9iSFtDK305xq6UTiKp+lbNwgneUjudiCbay8ifEeEENX0XVcRNYKWX5RLGOQUUIxcUm4ie6HxECuSxy2AF+RXHbT6RddHX85IQc/ztEO53NcBH1lOslnU5bzH6RVh/MDCVvdIlrTUhCAtHm6cze5pUycLXTSCsJC4JooceEo/WVn/O+AzIF1t8dp7LH4LeyU4f73Cy/76KLs3Q/9dROdc58WMtc4ByCHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kOeJSiP6984PKlHZbGtRv3U0e7QMxqA0OwDQE88crQ=;
 b=ydnHwfijFxlwtWFXcXLXhxBVwYM4cn+SQiJP/gSm6wqOTxwWL4QeyLRjfSoEmg4SKAvXlJ41b5YIXVjZIPaQcRKGG9rFn3x5CZ9rJ3c4Ax5vHLn+f+fPahUnN808jQVVhqqY29tLaJfNTrvXuYaOJvBIAdrzBY37yMzKHLZT1nA=
Received: from MN2PR20CA0014.namprd20.prod.outlook.com (2603:10b6:208:e8::27)
 by MW4PR12MB6898.namprd12.prod.outlook.com (2603:10b6:303:207::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Wed, 30 Apr
 2025 15:48:24 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:e8:cafe::a7) by MN2PR20CA0014.outlook.office365.com
 (2603:10b6:208:e8::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Wed,
 30 Apr 2025 15:48:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025 15:48:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Apr
 2025 10:48:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 2/7] drm/amdgpu/userq: add callback for reset
Date: Wed, 30 Apr 2025 11:48:04 -0400
Message-ID: <20250430154809.2665473-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430154809.2665473-1-alexander.deucher@amd.com>
References: <20250430154809.2665473-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|MW4PR12MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: c8faf8db-1e1b-4d78-4713-08dd87fe7102
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Lm+ICswIWTecFCed2u0uettapixqyP8dtOCsjvlW0RDNZg5AVe37Ia1T+hLH?=
 =?us-ascii?Q?p5du2KXP2ag3Ejt3xBCyuzWNp5UI6TjadgLFHlTHBTxqcYhBPZFYLiq0N+Yj?=
 =?us-ascii?Q?s1WLhLneAbChBBF40m3fLuG+V9WaPWDQnAjvpWt/Bkvj0Ig+8okzhmRP0Ago?=
 =?us-ascii?Q?NQqlivqs7Z3505b4pLMkwgMeUzEWNoaDIbbajRKnQSc3gLgAgiN5EcmceoHu?=
 =?us-ascii?Q?xQa7VmNB1pW4VgEdv+4eMqePwRh+GMx+Sdm/FTHGj5WCexbTaOGRkshUiAv/?=
 =?us-ascii?Q?6MjCCIabXTEKNA00/nSCJZ7Q9gnrSehJOy0l9XfVXLxGE28xbjTl1EK+0LvO?=
 =?us-ascii?Q?uk1wOBL7NmkjZ6slZNo1lHYn3fLbpCVen8DQ//hCwNLO85twK4xOXoMFTkaS?=
 =?us-ascii?Q?o8Misim0thNImg3Z57SL9pdc8FzDrSSiGR4E4N7FWTP6JcDASf6p2aMISTPg?=
 =?us-ascii?Q?iwmeeObYoBLC32Ha8ZvVs0xfbLJ2xtCoixraP6SibvcQW+tCjfwgZ6ah+2qR?=
 =?us-ascii?Q?re7QfesGRXCELUvRrPHxETFDPR5HKOiL6nCEN5QqPotVwwNmec3dWEUlwidE?=
 =?us-ascii?Q?SRWonMw8BtUEFjx2huQl6PHDy4HI20PAKwmuS/AGF7ki9SQoRPZJB9Q9lCbu?=
 =?us-ascii?Q?4Fem3FT1sdfnnLWRtmmo+9I23BCVLOd/1tn3x+vEsSb9ii27s9uLNO96KIZX?=
 =?us-ascii?Q?IlnflHUAbeij5lVslNJCgvwzXJQeMv/fjkgHGOemusmYxTYOesPX1WD/wJ8w?=
 =?us-ascii?Q?4BatWyQUpXV6zQQ9AN0Abz4B7hyMDSNyzptKphTyHHxLNyTm17RnoNIZJ/As?=
 =?us-ascii?Q?UhBJjOHHIW8ZxVw8woa2TR/uLEhYbfyttGKEfWtqy6gCgQmCxppXbIJjhEfS?=
 =?us-ascii?Q?NtWA8SFVucD4KQ8djziC+J7VWipfkZu6izTwleEEMNz+AUAdgvjC+qM9YyqR?=
 =?us-ascii?Q?GLaaaQgxlzfA9Ehy1zrEzpzRfm9OU/OfsnuXLfHb4nCPTe1ZgnVVvu6F5HjU?=
 =?us-ascii?Q?Qujxh7N1zHgF14dfdXrAxLz1p6kBYVyTv1YxcuhD5gnqTjdEnsABN8gTp5tj?=
 =?us-ascii?Q?BzdkWt3gXsLbaxEWOXlzmgAvxLNp7eo+7GBk6SjyMv75zw2N101wn/IwMHUx?=
 =?us-ascii?Q?TCRZUGBiuOCK4gfV9q9NKzGF7tXshXQqOS7eV45YhfMwUd7A01x04t9GcmBx?=
 =?us-ascii?Q?cmFtaaAfoid2lBYxum7WYAG4vExSTyP0TmyUfZ5PFvca2NpCxhwWzYLc68mr?=
 =?us-ascii?Q?RyJBunMj6tfPfuz6fA1wB7MjCt18p6D3fuotmMT4xr3cylzn5DslDosvt90d?=
 =?us-ascii?Q?Z+t20uUwFNyRaK7h4S4/sFXiWuPt+eivY69AzGPXUVTqmeAPtlyHHl8nlgWp?=
 =?us-ascii?Q?PoxkeJBoukkaPc1u8udEyLf9li8pCLXL/+cyI9lXU5gqSips8HdcQz0FBcUP?=
 =?us-ascii?Q?on+rhnE7f1dwWnFpfyX2dFnPgmO6Hlwqk/wgh+Ihb6NcZyO59boD0nvBffWy?=
 =?us-ascii?Q?GWc3roFj5SgGs1YeqnQgPEaF4UQj2WoJdkpJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 15:48:24.3458 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8faf8db-1e1b-4d78-4713-08dd87fe7102
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6898
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

This is used to reset a queue.

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 4d3eb651acf1a..24d201cdc9887 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -77,6 +77,8 @@ struct amdgpu_userq_funcs {
 		     struct amdgpu_usermode_queue *queue);
 	int (*map)(struct amdgpu_userq_mgr *uq_mgr,
 		   struct amdgpu_usermode_queue *queue);
+	int (*reset)(struct amdgpu_userq_mgr *uq_mgr,
+		     struct amdgpu_usermode_queue *queue);
 };
 
 /* Usermode queues for gfx */
-- 
2.49.0

