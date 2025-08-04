Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D444C87FCF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 11:06:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C71B510E43C;
	Mon,  4 Aug 2025 11:06:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dGWC62Nw";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77E6B10E43D
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 11:06:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQX/M1XuV4nICclWQE+yEc+bR+xI+Bh1Xs8gm9WvCWDYXmIesHwwBKMpsude+Q2PedgyQAL6IM/LeNRVHgo8gcOUz+Q8BUjTNgikB286R4azNj21gEhaTyQe+ou5ceWk6aJV6I/bjgzJ1EaNzkFluhWkIMg2/U4d0ji7C97twYEAu36qcP13jgrRiaWdhWBSNj5EcsXAUOV7S2Q4IjCir4efmmi583iwlY9E+K9NICjnfkInplwH4V3mft4bSMqE5DrRLLdNWHlD2mKN5oEKkyIJwCemRg57XybAr5qzfgrmsHGfcPcRVshc+YKsOrDPBakbv+Qfu6qxl4T2P5zJ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/4zySOuezCNYBzSSzk2KTCeD1etm2MqRWSPTvwxNzA=;
 b=vR+hgZZhp9HjivnWUpgo05j59QPygqvJp7A2YUtzediFYLcuMSivYzvMB5nPVpnJv409FQos3aVBBcE86QORiE/6dVMVX45WsCpTqY3syHhp1+4yjyfe/fC24h94sjJ9cwqdcriAHYp4BqIT+VarTySgnVtTLYfrWAfmDD7PScEKQG4vWZbbmN+RpczNs7KDcjDWS2i1UBRl/W0V0wTy43hXCdjgI5Pj2oeonE9SWqmNB0uf10O0akeoXp2K4/UA2rPIxksdBYLqv32Laq1xtusvmbkYVrakGDZG++4GnXP7D6xE7K9O8hO4L4ttjgbErYxY7oGmBFzmgsySB54R2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/4zySOuezCNYBzSSzk2KTCeD1etm2MqRWSPTvwxNzA=;
 b=dGWC62NwdTud2Rd/a2uohvfWw507WK7qnf7fOgpaue3HP0YCBGaRbXBAvPgKVz7ynEgrWRMYeVYCLTagx1zeAvQwNEElu2HXzJUF0VwSBIgYIDRkUwfOW2ViUme1I9SDuZkjOSaTGQJN4JZsb6rT/ZXs9vI/Fcra43RBenHiXes=
Received: from SJ0PR05CA0072.namprd05.prod.outlook.com (2603:10b6:a03:332::17)
 by PH7PR12MB8122.namprd12.prod.outlook.com (2603:10b6:510:2b7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Mon, 4 Aug
 2025 11:06:41 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:332:cafe::26) by SJ0PR05CA0072.outlook.office365.com
 (2603:10b6:a03:332::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.8 via Frontend Transport; Mon, 4
 Aug 2025 11:06:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 11:06:40 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Aug 2025 06:06:38 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <alexander.deucher@amd.com>, <felix.kuehling@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V3 07/13] amdkfd: process USERPTR allocation only on the
 primary kfd process
Date: Mon, 4 Aug 2025 19:05:44 +0800
Message-ID: <20250804110550.261311-8-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250804110550.261311-1-lingshan.zhu@amd.com>
References: <20250804110550.261311-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|PH7PR12MB8122:EE_
X-MS-Office365-Filtering-Correlation-Id: 18291c79-4809-4614-069d-08ddd346fd46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/HWnkU5rH1LHymSDlzNXTinYlbUAb6gxyMywYEcxAiWD3wtD7Yb5J1z5QwXD?=
 =?us-ascii?Q?eZ1E8YUqj68UhbLaZ5ULfoKdzHxaklWJx1h9NxIuKz9KhHgPPEA3OuBd+Oma?=
 =?us-ascii?Q?ZOrtS/T61OGTtvRvdA5FZNjTEj5gjjCVUugm5Nk20Ez3NiXZPo3WKHk/Mu2b?=
 =?us-ascii?Q?6qnfuEOJvARohCIoC6zyOkz2XCWAD+0tMuAaFL2gp7h/umlgbm1k4v1HVFV4?=
 =?us-ascii?Q?faN+m4rGhkSINimx9jgY9f8ymHWWwnlqbIBHlAShIXrh6Kje/hEO9t3U1xyu?=
 =?us-ascii?Q?Hl/hAEjSsU98s/0JmREMDUdXvAZA/r+bW2OQCqsLGbKwTCDz1pmszCGkJGsD?=
 =?us-ascii?Q?vskBnKo1gVQnSMySb+xJjnQYPbAbNzTgUvzgpkcWnFNbLIFkEsm+PeRzZOUj?=
 =?us-ascii?Q?AXuQrRKqsXn4OIvVAZsfo8uZP9kDpaFYRPRFIMD2UwiZhTDha9K97fIsvVoE?=
 =?us-ascii?Q?Bgk25g/j4G673J7I2xFhnDSjszOmb3cTe3K/vkdQEb3BC9DluEn8D//focFF?=
 =?us-ascii?Q?EiQRToq9O9przQGAkjCYcyAaTDUplyj7rkgXdFHZC9JO0kkufcDTK1dJJPqE?=
 =?us-ascii?Q?0Y9ME0Fy/q0S+PRdQyktyir8oqSiYlEnh2r1HtiuUJKsCrS17VsrFpyXQU2Y?=
 =?us-ascii?Q?YwWqcdLk13ES6RCvWhrd6kg2DqdmZtG0PnZIYrUwRJOXKO0qubFnY1xTtenf?=
 =?us-ascii?Q?OQCFcaE/vTiPsDtt11srrPPA8OY7rewzNkLjqunEoORCdM/KODfOu7CcltYl?=
 =?us-ascii?Q?yy0fMVKFboqjgJE00iqLYzDnhGYAhMgiybA0DsGQNMlrHzzEKjUxxY6kQT67?=
 =?us-ascii?Q?bv+9zzORKQhJ87Y4QGADbTE/PaB9ZIa8zbFJXhcuQ8stfYmI6gemJ2nhFsXk?=
 =?us-ascii?Q?bDzii7oghiYndgy3k1TnUjPYt+ERr9+bzdCrsrhZ+YgwnpOwzxkUdfNT9JAt?=
 =?us-ascii?Q?mcNezm0flh8prGLcVPdFBHRAOO/300OQ58ZBhZJYr+FT7ixppz5Aa9gnQJKv?=
 =?us-ascii?Q?NNsPmvif/FxQctHjDQMpIcRtxI4oRoortEj/DzrKdefPb6w75EqHXIuoV2If?=
 =?us-ascii?Q?c2Gl5qW2NgALRARSPxJWLyWzdG/qyjs+gBRf3XNh97159keAlIcjeAFG4+SR?=
 =?us-ascii?Q?8wZ/7ms50Cmmt5FISi6Ua9wcYHiviuuXD2CV7VY7FmD23HuNKj/u0XaiQAVH?=
 =?us-ascii?Q?DAB1dkmSFgYETV6AcOkH8okctKMwrF2oPGauPtP08SFp+VoaCP9TFN2P683C?=
 =?us-ascii?Q?huyrNEkfWX+kCWxpSpeLrsxRY2DF+qBBXi/ubQKFsGLcnMlL5bEDO5aBhXBS?=
 =?us-ascii?Q?0r8vnIbv1xK4KV6NHAI5jg7zYKsSM74//fKTtITwVKVu5QxRoC5+Av9HNzcn?=
 =?us-ascii?Q?9EWPVg5y2LYDTTRjAy0289bR8bgXCyr1isgTPPyri1ypo9lUWFE3SNjTTcsI?=
 =?us-ascii?Q?g8iMibOBG+ymJIOsjoQDwzH831ElF1c+v3fz6jcYgEXCsXJxN2UZ7NqkHZgO?=
 =?us-ascii?Q?ljaXWiQ4d/pmK+BvtgWOPAwi40a5pzbPk82g?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 11:06:40.5540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18291c79-4809-4614-069d-08ddd346fd46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8122
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

The lifecycle of the primary kfd process is tied to
the user space program, all secondary kfd process
would be destroyed when fd close. Thus only the primary
kfd process should process USERPTR memory allocation.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index f56faf11ee43..28df35a63c29 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1068,6 +1068,12 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 	if (args->size == 0)
 		return -EINVAL;
 
+	if (!p->primary && (flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR)) {
+		pr_debug("USERPTR is not supported on non-primary kfd_process\n");
+
+		return -EOPNOTSUPP;
+	}
+
 #if IS_ENABLED(CONFIG_HSA_AMD_SVM)
 	/* Flush pending deferred work to avoid racing with deferred actions
 	 * from previous memory map changes (e.g. munmap).
-- 
2.47.1

